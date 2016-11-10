variable "public_key" {
    description = "Contents of the public key file, eg. .ssh/id_rsa.pub"
}

variable "access_key" {
}

variable "secret_key" {
}

# ---------

provider "aws" {
    region = "eu-west-1"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}

resource "random_id" "owner_id" {
    keepers = {
        public_key = "${var.public_key}"
    }
    byte_length = 4
}

resource "aws_key_pair" "key" {
    key_name = "tf-key-${random_id.owner_id.b64}"
    public_key = "${var.public_key}"
}

data "aws_ami" "centos" {
    most_recent = true
    # CentOS 7 product code
    filter {
      name = "product-code"
      values = ["aw0evgkw8e5c1q413zgy5pjce"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    owners = ["aws-marketplace"]
}

resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/22"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "tf managed vpc"
    }
}

resource "aws_subnet" "default" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "tf managed subnet"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "tf managed gw"
    }
}

resource "aws_route" "internet_access" {
    route_table_id = "${aws_vpc.default.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
}

resource "aws_security_group" "ssh" {
    vpc_id = "${aws_vpc.default.id}"
    name = "ssh"
    description = "Allow SSH"
    tags {
        Name = "tf managed security groups"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "master" {
    ami = "${data.aws_ami.centos.id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.key.key_name}"
    subnet_id = "${aws_subnet.default.id}"
    vpc_security_group_ids = [ "${aws_security_group.ssh.id}",  "${aws_vpc.default.default_security_group_id}" ]
    tags {
        Name = "swarm-master"
    }
    root_block_device {
        delete_on_termination = true
    }

    connection {
        user = "centos"
    }
    provisioner "remote-exec" {
        scripts = [
          "${path.module}/scripts/docker.sh"
        ]
    }
}

resource "aws_instance" "worker" {
    count = 2
    ami = "${data.aws_ami.centos.id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.key.key_name}"
    subnet_id = "${aws_subnet.default.id}"
    vpc_security_group_ids = [ "${aws_security_group.ssh.id}",  "${aws_vpc.default.default_security_group_id}" ]
    tags {
        Name = "swarm-worker-${count.index}"
    }
    root_block_device {
        delete_on_termination = true
    }

    connection {
        user = "centos"
    }
    provisioner "remote-exec" {
        scripts = [
          "${path.module}/scripts/docker.sh"
        ]
    }
}

resource "aws_security_group" "http" {
    vpc_id = "${aws_vpc.default.id}"
    name = "http"
    description = "Allow HTTP"
    tags {
        Name = "tf managed security groups"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_elb" "lb" {
    name = "tf-lb-${random_id.owner_id.b64}"
    subnets = [ "${aws_subnet.default.id}" ]
    security_groups = [ "${aws_security_group.http.id}",  "${aws_vpc.default.default_security_group_id}" ]
  

    listener {
        instance_port       = 8080
        instance_protocol   = "http"
        lb_port             = 80
        lb_protocol         = "http"
    }

    instances = [
        "${aws_instance.master.id}",
        "${aws_instance.worker.*.id}"
    ]
}

# ---------

output "ami" {
    value = "${data.aws_ami.centos.id}"
}

output "master_public_ip" {
    value = "${aws_instance.master.public_ip}"
}

output "worker_public_ips" {
    value = "${join(" ", aws_instance.worker.*.public_ip)}"
}

output "elb_dns_name" {
    value = "${aws_elb.lb.dns_name}"
}
