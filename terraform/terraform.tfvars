# ------------------------
# Example Terraform Variables
# ------------------------

# AWS region to deploy
aws_region = "ap-south-1"

# VPC ID where ECS and RDS will run
vpc_id = "vpc-015ee24d80251f6b1"  # <-- replace with your actual VPC ID

# Subnets for ECS tasks, ALB, and RDS subnet group
# Best practice: use private subnets for DB, public for ALB/ECS if needed
subnets = [
  "subnet-02d089e43bb79f39f",  # <-- replace with your Subnet ID 1
  "subnet-07bd32140edd31829"   # <-- replace with your Subnet ID 2
]

# Desired task count for ECS Service
desired_count = 1

# Optional: specify image tags if using versioned builds
app_image_tag   = "latest"
nginx_image_tag = "latest"