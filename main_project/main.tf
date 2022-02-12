module "vpc" {
  source = "../modules/terraform-aws-vpc-module"
  cidr   = "10.161.0.0/24"
}

module "iam" {
  source = "../modules/terraform-aws-iam-module"
}

module "instance_1" {
  source             = "../modules/terraform-aws-ec2-module"
  availability_zone  = module.vpc.availability_zone_1
  key                = data.aws_key_pair.key.key_name
  security_group_ids = [module.vpc.security_group_id]
  subnet_id          = module.vpc.public_subnet_id_1
  instance_name      = "Instance_1"
  user_data          = "Hello_Server1"
  target_group       = module.alb.target_group_arn
  instance_profile   = module.iam.iam_instance_profile_name
}

module "instance_2" {
  source             = "../modules/terraform-aws-ec2-module"
  availability_zone  = module.vpc.availability_zone_2
  key                = data.aws_key_pair.key.key_name
  security_group_ids = [module.vpc.security_group_id]
  subnet_id          = module.vpc.public_subnet_id_2
  instance_name      = "Instance_2"
  user_data          = "Hello_Server2"
  target_group       = module.alb.target_group_arn
  instance_profile   = module.iam.iam_instance_profile_name
}

module "instance_3" {
  source             = "../modules/terraform-aws-ec2-module"
  availability_zone  = module.vpc.availability_zone_3
  key                = data.aws_key_pair.key.key_name
  security_group_ids = [module.vpc.security_group_id]
  subnet_id          = module.vpc.public_subnet_id_3
  instance_name      = "Instance_3"
  user_data          = "Hello_Server3"
  target_group       = module.alb.target_group_arn
  instance_profile   = module.iam.iam_instance_profile_name
}

module "alb" {
  source            = "../modules/terraform-aws-alb-module"
  security_group_id = [module.vpc.security_group_id]
  public_subnet_ids = [module.vpc.public_subnet_id_1, module.vpc.public_subnet_id_2, module.vpc.public_subnet_id_3]
  vpc_id            = module.vpc.vpc_id
}

