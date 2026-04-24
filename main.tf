terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.92"
    }
  }
  required_version = ">= 1.2"
}

# Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "${locals.project}-${locals.env}-data"

  tags = {
    Project = locals.project
    Env     = locals.env
  }
}

module "iam" {
  source = "./modules/iam"

  role_name     = "${locals.project}-${locals.env}-execution-role"
  s3_bucket_arn = module.s3.bucket_arn
}


module "sqs" {
  source = "./modules/sqs"

  queue_name = "${locals.project}-${locals.env}-events"

  tags = {
    Project = locals.project
    Env     = locals.env
  }
}

module "lambda" {
  source = "./modules/lambda"

  function_name = "${locals.project}-${locals.env}-rps-generator"
  role_arn      = module.iam.role_arn

  handler  = "app.handler"
  runtime  = "python3.10"
  timeout  = 60
  filename = "./artifacts/rps_lambda.zip"

  s3_bucket    = module.s3.bucket_name
  sqs_queue_url = module.sqs.queue_url
}

module "lambda_logs" {
  source = "./modules/cloudwatch"

  log_group_name = "/aws/lambda/${module.lambda.function_name}"
  retention_in_days = 14

  tags = {
    project = locals.project
    Env     = locals.env
  }
  
}

module "glue" {
  source = "./modules/glue"

  job_name = "${locals.project}-${locals.env}-glue-etl" # rps-dev-glue-etl
  role_arn = module.iam.role_arn

  script_location = "s3://${module.s3.bucket_name}/scripts/etl.py"
  temp_dir = "s3://${module.s3.bucket_name}/tmp/"

  worker_type = "G.1X"
  number_of_workers = 2
  glue_version = "4.0"
  timeout = 30
  max_retries = 1

  default_arguments = {
    "--enable-continous-cloudwatch-log" = "true"
    "--enable-spark-ui"                 = "true"
    "--enable-monitoring"               = "true"
    "--s3-bucket-location"              = "${module.s3.bucket_name}"
  } 
}

resource "aws_lambda_event_source_mapping" "sqs_to_glue_lambda" {
  event_source_arn = module.sqs.queue_arn
  function_name = module.glue_trigger_lambda.function_arn

  batch_size = 1
  enabled = true
}