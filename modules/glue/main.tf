resource "aws_glue_job" "this" {
    name = var.job_name
    role_arn = var.role_arn

    glue_version = var.glue_version
    worker_type = var.worker_type
    number_of_workers = var.number_of_workers

    timeout = var.timeout
    max_retries = var.max_retries

    command {
      name = "rps-glue-job"
      script_location = var.script_location
      python_version = "3"
    }

    default_arguments = merge(
        {
            "--TempDir"             = var.temp_dir
            "--job-bookmark-option" = "job-bookmark-enable"
            "--enable-metrics"      = "true"
        },
        var.default_arguments
    )
}