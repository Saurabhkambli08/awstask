output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app_nginx.arn
}

output "ecr_app_repo_url" {
  value = aws_ecr_repository.app.repository_url
}

output "ecr_nginx_repo_url" {
  value = aws_ecr_repository.nginx.repository_url
}

output "db_endpoint" {
  value = aws_db_instance.myapp_db.endpoint
}

output "db_password_secret_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}
