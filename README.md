
# Project Title

A brief description of what this project does.

# DevOps Project

### Project introduction:
I created aws infrastructure using Terraform modules. Deployed and configured an Nginx Docker container on EC2 instance. I Configured different index.html on each EC2 instance using Jinja2 and Docker log delivered to Cloudwatch. 

### Prerequisites  :
- An AWS account.
- AWS user with programmatic access and attach AdministratorAccess policy with it.
- The AWS CLI installed and configured Access key and Secret key.
- Create key pair dev-ops.pem and place it into the main_project folder.

### Getting Started:

I Created terraform modules to build aws infrastructure.

### Modules
### Terraform-aws-vpc-module

Terraform VPC/networking module which creates VPC with CIDR rang 10.161.0.0/24 and following resources on AWS - 
    
      Three public subnet one per availability zone.
      Route table.
      Security group.
      Internet gatway and associate route table with subnet.
 


### Terraform-aws-ec2-module

Terraform EC2 module which creates three EC2 instances, upload ansible_negix.yml and template.j2 on EC2 and execute ansible playbook on each instance.


### Terraform-aws-alb-module
Terraform ALB module which creates application load balancer which is serving port 80 on each instance.

### terraform-aws-iam-module
Terraform IAM module which creates role, policy, log group, instance profile to access cloudwatch. 


### Main Project

I created the main project and used the above modules.
 
### Ansible
I created ansible file ansible_negix.yml to deploy and configure an Nginx Docker container on each EC2 instance. It will connect to each EC2 instances and perform the following tasks - docker installation, start the docker services, installation of docker library, creates container with Nginx latest image.It also get the container information like ipaddress, connect to docker and replace index.html with jinja2 template and restart the Nginx.   

#### Installation/Code execution:

###### Initializing  working directory
  
      naojha@naojha-mac main_project % terraform init
      Initializing modules...
      - alb in ../modules/terraform-aws-alb-module
      - iam in ../modules/terraform-aws-iam-module
      - instance_1 in ../modules/terraform-aws-ec2-module
      - instance_2 in ../modules/terraform-aws-ec2-module
      - instance_3 in ../modules/terraform-aws-ec2-module
      - vpc in ../modules/terraform-aws-vpc-module
      
      Initializing the backend...
      
      Initializing provider plugins...
      - Finding latest version of hashicorp/aws...
      - Installing hashicorp/aws v4.0.0...
      - Installed hashicorp/aws v4.0.0 (signed by HashiCorp)
      
      Terraform has created a lock file .terraform.lock.hcl to record the provider
      selections it made above. Include this file in your version control repository
      so that Terraform can guarantee to make the same selections by default when
      you run "terraform init" in the future.
      
      Terraform has been successfully initialized!

#### Generate plan


    naojha@naojha-mac main_project % terraform plan

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # module.alb.aws_lb.applications_load_balancer will be created
      + resource "aws_lb" "applications_load_balancer" {
          + arn                        = (known after apply)
          + arn_suffix                 = (known after apply)
          + desync_mitigation_mode     = "defensive"
          + dns_name                   = (known after apply)
          + drop_invalid_header_fields = false
          + enable_deletion_protection = false
          + enable_http2               = true
          + enable_waf_fail_open       = false
          + id                         = (known after apply)
          + idle_timeout               = 60
          + internal                   = false
          + ip_address_type            = (known after apply)
          + load_balancer_type         = "application"
          + name                       = "my-ALB"
          + security_groups            = (known after apply)
          + subnets                    = (known after apply)
          + tags                       = {
              + "Environment" = "test"
            }
          + tags_all                   = {
              + "Environment" = "test"
            }
          + vpc_id                     = (known after apply)
          + zone_id                    = (known after apply)
    
          + subnet_mapping {
              + allocation_id        = (known after apply)
              + ipv6_address         = (known after apply)
              + outpost_id           = (known after apply)
              + private_ipv4_address = (known after apply)
              + subnet_id            = (known after apply)
            }
        }
    
      # module.alb.aws_lb_listener.front_end will be created
      + resource "aws_lb_listener" "front_end" {
          + arn               = (known after apply)
          + id                = (known after apply)
          + load_balancer_arn = (known after apply)
          + port              = 80
          + protocol          = "HTTP"
          + ssl_policy        = (known after apply)
          + tags_all          = (known after apply)
    
          + default_action {
              + order            = (known after apply)
              + target_group_arn = (known after apply)
              + type             = "forward"
            }
        }
    
      # module.alb.aws_lb_target_group.alb_target_group will be created
      + resource "aws_lb_target_group" "alb_target_group" {
          + arn                                = (known after apply)
          + arn_suffix                         = (known after apply)
          + connection_termination             = false
          + deregistration_delay               = "300"
          + id                                 = (known after apply)
          + lambda_multi_value_headers_enabled = false
          + load_balancing_algorithm_type      = (known after apply)
          + name                               = "tg"
          + port                               = 80
          + preserve_client_ip                 = (known after apply)
          + protocol                           = "HTTP"
          + protocol_version                   = (known after apply)
          + proxy_protocol_v2                  = false
          + slow_start                         = 0
          + tags                               = {
              + "Name" = "tg"
            }
          + tags_all                           = {
              + "Name" = "tg"
            }
          + target_type                        = "instance"
          + vpc_id                             = (known after apply)
    
          + health_check {
              + enabled             = (known after apply)
              + healthy_threshold   = (known after apply)
              + interval            = (known after apply)
              + matcher             = (known after apply)
              + path                = (known after apply)
              + port                = (known after apply)
              + protocol            = (known after apply)
              + timeout             = (known after apply)
              + unhealthy_threshold = (known after apply)
            }
    
          + stickiness {
              + cookie_duration = 86400
              + enabled         = false
              + type            = "lb_cookie"
            }
        }
    
      # module.iam.aws_cloudwatch_log_group.ec2_log_group will be created
      + resource "aws_cloudwatch_log_group" "ec2_log_group" {
          + arn               = (known after apply)
          + id                = (known after apply)
          + name              = "log_to_cloudwatch"
          + retention_in_days = 30
          + tags_all          = (known after apply)
        }
    
      # module.iam.aws_iam_instance_profile.iam_instance_profile will be created
      + resource "aws_iam_instance_profile" "iam_instance_profile" {
          + arn         = (known after apply)
          + create_date = (known after apply)
          + id          = (known after apply)
          + name        = "cloudwatch_log_instance_profile"
          + path        = "/"
          + role        = (known after apply)
          + tags_all    = (known after apply)
          + unique_id   = (known after apply)
        }
    
      # module.iam.aws_iam_policy.cloudwatch_policy will be created
      + resource "aws_iam_policy" "cloudwatch_policy" {
          + arn       = (known after apply)
          + id        = (known after apply)
          + name      = "cloudwatch_log_policy"
          + path      = "/"
          + policy    = (known after apply)
          + policy_id = (known after apply)
          + tags_all  = (known after apply)
        }
    
      # module.iam.aws_iam_policy_attachment.policy-attachment will be created
      + resource "aws_iam_policy_attachment" "policy-attachment" {
          + id         = (known after apply)
          + name       = "cloudwatch_policy_attachment"
          + policy_arn = (known after apply)
          + roles      = (known after apply)
        }
    
      # module.iam.aws_iam_role.cloudwatch_role will be created
      + resource "aws_iam_role" "cloudwatch_role" {
          + arn                   = (known after apply)
          + assume_role_policy    = jsonencode(
                {
                  + Statement = [
                      + {
                          + Action    = "sts:AssumeRole"
                          + Effect    = "Allow"
                          + Principal = {
                              + Service = "ec2.amazonaws.com"
                            }
                          + Sid       = ""
                        },
                    ]
                  + Version   = "2012-10-17"
                }
            )
          + create_date           = (known after apply)
          + force_detach_policies = false
          + id                    = (known after apply)
          + managed_policy_arns   = (known after apply)
          + max_session_duration  = 3600
          + name                  = "cloudwatch_log_role"
          + name_prefix           = (known after apply)
          + path                  = "/"
          + tags_all              = (known after apply)
          + unique_id             = (known after apply)
    
          + inline_policy {
              + name   = (known after apply)
              + policy = (known after apply)
            }
        }
    
      # module.instance_1.aws_instance.instance will be created
      + resource "aws_instance" "instance" {
          + ami                                  = "ami-0ed9277fb7eb570c9"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = true
          + availability_zone                    = "us-east-1a"
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + iam_instance_profile                 = "cloudwatch_log_instance_profile"
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t2.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = "dev-ops"
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "name" = "Instance_1"
            }
          + tags_all                             = {
              + "name" = "Instance_1"
            }
          + tenancy                              = (known after apply)
          + user_data                            = "1bb9833a34d1b0030afe95959ed61e47ddff909e"
          + user_data_base64                     = (known after apply)
          + vpc_security_group_ids               = (known after apply)
    
          + capacity_reservation_specification {
              + capacity_reservation_preference = (known after apply)
    
              + capacity_reservation_target {
                  + capacity_reservation_id = (known after apply)
                }
            }
    
          + ebs_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + snapshot_id           = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
    
          + enclave_options {
              + enabled = (known after apply)
            }
    
          + ephemeral_block_device {
              + device_name  = (known after apply)
              + no_device    = (known after apply)
              + virtual_name = (known after apply)
            }
    
          + metadata_options {
              + http_endpoint               = (known after apply)
              + http_put_response_hop_limit = (known after apply)
              + http_tokens                 = (known after apply)
              + instance_metadata_tags      = (known after apply)
            }
    
          + network_interface {
              + delete_on_termination = (known after apply)
              + device_index          = (known after apply)
              + network_interface_id  = (known after apply)
            }
    
          + root_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
        }
    
      # module.instance_1.aws_lb_target_group_attachment.tg_attachment_test will be created
      + resource "aws_lb_target_group_attachment" "tg_attachment_test" {
          + id               = (known after apply)
          + port             = 80
          + target_group_arn = (known after apply)
          + target_id        = (known after apply)
        }
    
      # module.instance_2.aws_instance.instance will be created
      + resource "aws_instance" "instance" {
          + ami                                  = "ami-0ed9277fb7eb570c9"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = true
          + availability_zone                    = "us-east-1b"
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + iam_instance_profile                 = "cloudwatch_log_instance_profile"
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t2.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = "dev-ops"
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "name" = "Instance_2"
            }
          + tags_all                             = {
              + "name" = "Instance_2"
            }
          + tenancy                              = (known after apply)
          + user_data                            = "19338fdb533303d3f8c5510da04a8e5c3fbb9fe3"
          + user_data_base64                     = (known after apply)
          + vpc_security_group_ids               = (known after apply)
    
          + capacity_reservation_specification {
              + capacity_reservation_preference = (known after apply)
    
              + capacity_reservation_target {
                  + capacity_reservation_id = (known after apply)
                }
            }
    
          + ebs_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + snapshot_id           = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
    
          + enclave_options {
              + enabled = (known after apply)
            }
    
          + ephemeral_block_device {
              + device_name  = (known after apply)
              + no_device    = (known after apply)
              + virtual_name = (known after apply)
            }
    
          + metadata_options {
              + http_endpoint               = (known after apply)
              + http_put_response_hop_limit = (known after apply)
              + http_tokens                 = (known after apply)
              + instance_metadata_tags      = (known after apply)
            }
    
          + network_interface {
              + delete_on_termination = (known after apply)
              + device_index          = (known after apply)
              + network_interface_id  = (known after apply)
            }
    
          + root_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
        }
    
      # module.instance_2.aws_lb_target_group_attachment.tg_attachment_test will be created
      + resource "aws_lb_target_group_attachment" "tg_attachment_test" {
          + id               = (known after apply)
          + port             = 80
          + target_group_arn = (known after apply)
          + target_id        = (known after apply)
        }
    
      # module.instance_3.aws_instance.instance will be created
      + resource "aws_instance" "instance" {
          + ami                                  = "ami-0ed9277fb7eb570c9"
          + arn                                  = (known after apply)
          + associate_public_ip_address          = true
          + availability_zone                    = "us-east-1c"
          + cpu_core_count                       = (known after apply)
          + cpu_threads_per_core                 = (known after apply)
          + disable_api_termination              = (known after apply)
          + ebs_optimized                        = (known after apply)
          + get_password_data                    = false
          + host_id                              = (known after apply)
          + iam_instance_profile                 = "cloudwatch_log_instance_profile"
          + id                                   = (known after apply)
          + instance_initiated_shutdown_behavior = (known after apply)
          + instance_state                       = (known after apply)
          + instance_type                        = "t2.micro"
          + ipv6_address_count                   = (known after apply)
          + ipv6_addresses                       = (known after apply)
          + key_name                             = "dev-ops"
          + monitoring                           = (known after apply)
          + outpost_arn                          = (known after apply)
          + password_data                        = (known after apply)
          + placement_group                      = (known after apply)
          + placement_partition_number           = (known after apply)
          + primary_network_interface_id         = (known after apply)
          + private_dns                          = (known after apply)
          + private_ip                           = (known after apply)
          + public_dns                           = (known after apply)
          + public_ip                            = (known after apply)
          + secondary_private_ips                = (known after apply)
          + security_groups                      = (known after apply)
          + source_dest_check                    = true
          + subnet_id                            = (known after apply)
          + tags                                 = {
              + "name" = "Instance_3"
            }
          + tags_all                             = {
              + "name" = "Instance_3"
            }
          + tenancy                              = (known after apply)
          + user_data                            = "d1a310f8a26ed16f197713d6f7da68d153f499eb"
          + user_data_base64                     = (known after apply)
          + vpc_security_group_ids               = (known after apply)
    
          + capacity_reservation_specification {
              + capacity_reservation_preference = (known after apply)
    
              + capacity_reservation_target {
                  + capacity_reservation_id = (known after apply)
                }
            }
    
          + ebs_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + snapshot_id           = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
    
          + enclave_options {
              + enabled = (known after apply)
            }
    
          + ephemeral_block_device {
              + device_name  = (known after apply)
              + no_device    = (known after apply)
              + virtual_name = (known after apply)
            }
    
          + metadata_options {
              + http_endpoint               = (known after apply)
              + http_put_response_hop_limit = (known after apply)
              + http_tokens                 = (known after apply)
              + instance_metadata_tags      = (known after apply)
            }
    
          + network_interface {
              + delete_on_termination = (known after apply)
              + device_index          = (known after apply)
              + network_interface_id  = (known after apply)
            }
    
          + root_block_device {
              + delete_on_termination = (known after apply)
              + device_name           = (known after apply)
              + encrypted             = (known after apply)
              + iops                  = (known after apply)
              + kms_key_id            = (known after apply)
              + tags                  = (known after apply)
              + throughput            = (known after apply)
              + volume_id             = (known after apply)
              + volume_size           = (known after apply)
              + volume_type           = (known after apply)
            }
        }
    
      # module.instance_3.aws_lb_target_group_attachment.tg_attachment_test will be created
      + resource "aws_lb_target_group_attachment" "tg_attachment_test" {
          + id               = (known after apply)
          + port             = 80
          + target_group_arn = (known after apply)
          + target_id        = (known after apply)
        }
    
      # module.vpc.aws_internet_gateway.myIGW will be created
      + resource "aws_internet_gateway" "myIGW" {
          + arn      = (known after apply)
          + id       = (known after apply)
          + owner_id = (known after apply)
          + tags     = {
              + "Name" = "tcw_igw"
            }
          + tags_all = {
              + "Name" = "tcw_igw"
            }
          + vpc_id   = (known after apply)
        }
    
      # module.vpc.aws_route.public_internet_gateway will be created
      + resource "aws_route" "public_internet_gateway" {
          + destination_cidr_block = "0.0.0.0/0"
          + gateway_id             = (known after apply)
          + id                     = (known after apply)
          + instance_id            = (known after apply)
          + instance_owner_id      = (known after apply)
          + network_interface_id   = (known after apply)
          + origin                 = (known after apply)
          + route_table_id         = (known after apply)
          + state                  = (known after apply)
        }
    
      # module.vpc.aws_route_table.public_route_table will be created
      + resource "aws_route_table" "public_route_table" {
          + arn              = (known after apply)
          + id               = (known after apply)
          + owner_id         = (known after apply)
          + propagating_vgws = (known after apply)
          + route            = (known after apply)
          + tags             = {
              + "Name" = "tcw_public_route_table"
            }
          + tags_all         = {
              + "Name" = "tcw_public_route_table"
            }
          + vpc_id           = (known after apply)
        }
    
      # module.vpc.aws_route_table_association.public_route_table_association_1 will be created
      + resource "aws_route_table_association" "public_route_table_association_1" {
          + id             = (known after apply)
          + route_table_id = (known after apply)
          + subnet_id      = (known after apply)
        }
    
      # module.vpc.aws_route_table_association.public_route_table_association_2 will be created
      + resource "aws_route_table_association" "public_route_table_association_2" {
          + id             = (known after apply)
          + route_table_id = (known after apply)
          + subnet_id      = (known after apply)
        }
    
      # module.vpc.aws_route_table_association.public_route_table_association_3 will be created
      + resource "aws_route_table_association" "public_route_table_association_3" {
          + id             = (known after apply)
          + route_table_id = (known after apply)
          + subnet_id      = (known after apply)
        }
    
      # module.vpc.aws_security_group.sg will be created
      + resource "aws_security_group" "sg" {
          + arn                    = (known after apply)
          + description            = "Allow all inbound traffic"
          + egress                 = [
              + {
                  + cidr_blocks      = [
                      + "0.0.0.0/0",
                    ]
                  + description      = "Outbound rule"
                  + from_port        = 0
                  + ipv6_cidr_blocks = [
                      + "::/0",
                    ]
                  + prefix_list_ids  = []
                  + protocol         = "-1"
                  + security_groups  = []
                  + self             = false
                  + to_port          = 0
                },
            ]
          + id                     = (known after apply)
          + ingress                = [
              + {
                  + cidr_blocks      = [
                      + "0.0.0.0/0",
                    ]
                  + description      = "only http"
                  + from_port        = 80
                  + ipv6_cidr_blocks = []
                  + prefix_list_ids  = []
                  + protocol         = "tcp"
                  + security_groups  = []
                  + self             = false
                  + to_port          = 80
                },
              + {
                  + cidr_blocks      = [
                      + "0.0.0.0/0",
                    ]
                  + description      = "only ssh"
                  + from_port        = 22
                  + ipv6_cidr_blocks = []
                  + prefix_list_ids  = []
                  + protocol         = "tcp"
                  + security_groups  = []
                  + self             = false
                  + to_port          = 22
                },
            ]
          + name                   = "tcw_security_group"
          + name_prefix            = (known after apply)
          + owner_id               = (known after apply)
          + revoke_rules_on_delete = false
          + tags                   = {
              + "Name" = "tcw_security_group"
            }
          + tags_all               = {
              + "Name" = "tcw_security_group"
            }
          + vpc_id                 = (known after apply)
        }
    
      # module.vpc.aws_subnet.public_subnet_1 will be created
      + resource "aws_subnet" "public_subnet_1" {
          + arn                                            = (known after apply)
          + assign_ipv6_address_on_creation                = false
          + availability_zone                              = "us-east-1a"
          + availability_zone_id                           = (known after apply)
          + cidr_block                                     = "10.161.0.0/26"
          + enable_dns64                                   = false
          + enable_resource_name_dns_a_record_on_launch    = false
          + enable_resource_name_dns_aaaa_record_on_launch = false
          + id                                             = (known after apply)
          + ipv6_cidr_block_association_id                 = (known after apply)
          + ipv6_native                                    = false
          + map_public_ip_on_launch                        = false
          + owner_id                                       = (known after apply)
          + private_dns_hostname_type_on_launch            = (known after apply)
          + tags                                           = {
              + "Name" = "tcw_public_subnet_az_1a"
            }
          + tags_all                                       = {
              + "Name" = "tcw_public_subnet_az_1a"
            }
          + vpc_id                                         = (known after apply)
        }
    
      # module.vpc.aws_subnet.public_subnet_2 will be created
      + resource "aws_subnet" "public_subnet_2" {
          + arn                                            = (known after apply)
          + assign_ipv6_address_on_creation                = false
          + availability_zone                              = "us-east-1b"
          + availability_zone_id                           = (known after apply)
          + cidr_block                                     = "10.161.0.64/26"
          + enable_dns64                                   = false
          + enable_resource_name_dns_a_record_on_launch    = false
          + enable_resource_name_dns_aaaa_record_on_launch = false
          + id                                             = (known after apply)
          + ipv6_cidr_block_association_id                 = (known after apply)
          + ipv6_native                                    = false
          + map_public_ip_on_launch                        = false
          + owner_id                                       = (known after apply)
          + private_dns_hostname_type_on_launch            = (known after apply)
          + tags                                           = {
              + "Name" = "tcw_public_subnet_az_1b"
            }
          + tags_all                                       = {
              + "Name" = "tcw_public_subnet_az_1b"
            }
          + vpc_id                                         = (known after apply)
        }
    
      # module.vpc.aws_subnet.public_subnet_3 will be created
      + resource "aws_subnet" "public_subnet_3" {
          + arn                                            = (known after apply)
          + assign_ipv6_address_on_creation                = false
          + availability_zone                              = "us-east-1c"
          + availability_zone_id                           = (known after apply)
          + cidr_block                                     = "10.161.0.128/26"
          + enable_dns64                                   = false
          + enable_resource_name_dns_a_record_on_launch    = false
          + enable_resource_name_dns_aaaa_record_on_launch = false
          + id                                             = (known after apply)
          + ipv6_cidr_block_association_id                 = (known after apply)
          + ipv6_native                                    = false
          + map_public_ip_on_launch                        = false
          + owner_id                                       = (known after apply)
          + private_dns_hostname_type_on_launch            = (known after apply)
          + tags                                           = {
              + "Name" = "tcw_public_subnet_az_1c"
            }
          + tags_all                                       = {
              + "Name" = "tcw_public_subnet_az_1c"
            }
          + vpc_id                                         = (known after apply)
        }
    
      # module.vpc.aws_vpc.myVPC will be created
      + resource "aws_vpc" "myVPC" {
          + arn                                  = (known after apply)
          + cidr_block                           = "10.161.0.0/24"
          + default_network_acl_id               = (known after apply)
          + default_route_table_id               = (known after apply)
          + default_security_group_id            = (known after apply)
          + dhcp_options_id                      = (known after apply)
          + enable_classiclink                   = (known after apply)
          + enable_classiclink_dns_support       = (known after apply)
          + enable_dns_hostnames                 = true
          + enable_dns_support                   = true
          + id                                   = (known after apply)
          + instance_tenancy                     = "default"
          + ipv6_association_id                  = (known after apply)
          + ipv6_cidr_block                      = (known after apply)
          + ipv6_cidr_block_network_border_group = (known after apply)
          + main_route_table_id                  = (known after apply)
          + owner_id                             = (known after apply)
          + tags                                 = {
              + "Name" = "tcw_vpc"
            }
          + tags_all                             = {
              + "Name" = "tcw_vpc"
            }
        }
    
    Plan: 25 to add, 0 to change, 0 to destroy.


#### Plan Apply (Building Infrastructure) 


    Plan: 25 to add, 0 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    module.iam.aws_cloudwatch_log_group.ec2_log_group: Creating...
    module.iam.aws_iam_role.cloudwatch_role: Creating...
    module.vpc.aws_vpc.myVPC: Creating...
    module.iam.aws_cloudwatch_log_group.ec2_log_group: Creation complete after 6s [id=log_to_cloudwatch]
    module.iam.aws_iam_policy.cloudwatch_policy: Creating...
    module.iam.aws_iam_role.cloudwatch_role: Creation complete after 7s [id=cloudwatch_log_role]
    module.iam.aws_iam_instance_profile.iam_instance_profile: Creating...
    module.iam.aws_iam_policy.cloudwatch_policy: Creation complete after 4s [id=arn:aws:iam::759176466666:policy/cloudwatch_log_policy]
    module.iam.aws_iam_policy_attachment.policy-attachment: Creating...
    module.vpc.aws_vpc.myVPC: Still creating... [10s elapsed]
    module.iam.aws_iam_instance_profile.iam_instance_profile: Creation complete after 5s [id=cloudwatch_log_instance_profi
    module.instance_1.aws_instance.instance: Creation complete after 2m23s [id=i-04a6316f54135f8c2]
    module.instance_1.aws_lb_target_group_attachment.tg_attachment_test: Creating...
    module.instance_2.aws_instance.instance: Creation complete after 2m24s [id=i-0eab691a6497b3ade]
    module.instance_2.aws_lb_target_group_attachment.tg_attachment_test: Creating...
    module.instance_1.aws_lb_target_group_attachment.tg_attachment_test: Creation complete after 2s [id=arn:aws:elasticloadbalancing:us-east-1:759176466666:targetgroup/tg/bafe676847b8aa92-20220213162909080300000002]
    module.instance_2.aws_lb_target_group_attachment.tg_attachment_test: Creation complete after 2s [id=arn:aws:elasticloadbalancing:us-east-1:759176466666:targetgroup/tg/bafe676847b8aa92-20220213162909776300000003]
    module.alb.aws_lb.applications_load_balancer: Still creating... [2m31s elapsed]
    module.alb.aws_lb.applications_load_balancer: Still creating... [2m41s elapsed]
    module.alb.aws_lb.applications_load_balancer: Still creating... [2m51s elapsed]
    module.alb.aws_lb.applications_load_balancer: Still creating... [3m1s elapsed]
    module.alb.aws_lb.applications_load_balancer: Creation complete after 3m1s [id=arn:aws:elasticloadbalancing:us-east-1:759176466666:loadbalancer/app/my-ALB/9b7a80af848b87f2]
    module.alb.aws_lb_listener.front_end: Creating...
    module.alb.aws_lb_listener.front_end: Creation complete after 4s [id=arn:aws:elasticloadbalancing:us-east-1:759176466666:listener/app/my-ALB/9b7a80af848b87f2/7a55bc53f000d488]
    
    Apply complete! Resources: 25 added, 0 changed, 0 destroyed.

## Screenshots

#### VPC Created with CIDR 10.161.0.0/24
![VPC Created](https://github.com/navojha/devops_project/blob/master/Screenshot/VPC.png?raw=true)


#### 3 Subnets: 1 per availability zone 
![Subnets](https://github.com/navojha/devops_project/blob/master/Screenshot/Subnet.png?raw=true)


#### Internet Gateway 
![Internet Gateway](https://github.com/navojha/devops_project/blob/master/Screenshot/Internet_gatway.png?raw=true)


#### Route Table
![Route Table](https://github.com/navojha/devops_project/blob/master/Screenshot/Route_Table.png?raw=true)


#### Security Group
![Security Group](https://github.com/navojha/devops_project/blob/master/Screenshot/Security_Group.png?raw=true)


#### 3 EC2 instances
![EC2 instance](https://github.com/navojha/devops_project/blob/master/Screenshot/EC2_Instance.png?raw=true)

#### Target groups
![Target groups](https://github.com/navojha/devops_project/blob/master/Screenshot/Target_Group.png?raw=true)


#### Application Load Balancer
![Application Load Balancer](https://github.com/navojha/devops_project/blob/master/Screenshot/Load_Balancer.png?raw=true)

#### Cloud Watch log group
![Cloud Watch log group](https://github.com/navojha/devops_project/blob/master/Screenshot/Log_group.png?raw=true)


#### Nginx 1 Server responce
![Nginx Server](https://github.com/navojha/devops_project/blob/master/Screenshot/Server1_Responce.png?raw=true)


#### Nginx 2 Server responce
![Nginx Server](https://github.com/navojha/devops_project/blob/master/Screenshot/Server2_responce.png?raw=true)


#### Nginx 3 Server responce
![Nginx Server](https://github.com/navojha/devops_project/blob/master/Screenshot/Server3_responce.png?raw=true)

#### Project Tree
![Project Tree](https://github.com/navojha/devops_project/blob/master/Screenshot/Project_Tree.png?raw=true)


## Acknowledgements
   
  Following documents was referred to Achive this project:

 - Terraform AWS Documentation https://registry.terraform.io/providers/hashicorp/aws/latest/docs
 - Ansible Document https://docs.ansible.com/ansible/latest/index.html
 - NGINX Document https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker
 - Document reffered for Jinja2 https://www.linuxtechi.com/configure-use-ansible-jinja2-templates/
