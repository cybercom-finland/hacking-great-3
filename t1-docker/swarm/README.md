# Docker Swarm Mode on AWS using Terraform

## Requirements

- Terraform v0.7 or higher
- AWS API credentials

## Setup

1. Put AWS secrets and SSH public key to `terraform.tfvars`
2. Check `terraform plan`
3. Run `terraform apply` to create the setup
4. Log in to master node (user: centos, IP: can be obtained from `terraform output`) and run

   ```
   docker swarm init
   ```

5. Run the printed `join` command on worker nodes

   ```
   docker join --token XXX 10.0.X.X:2377
   ```

6. Check the status on master node

   ```
   docker node ls
   ```

## Usage

    sh to-swarm.sh up

## Note

Remember to destroy the setup after hacking

    terraform destroy

## Credits

The infra code inspired by

- <https://github.com/Praqma/terraform-aws-docker>
- <https://github.com/namikingsoft/sample-terraform-docker-swarm-over-tls>
- <https://github.com/piyush0101/terraform-swarm>

