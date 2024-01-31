locals {
  env="dev"
  projectName="petclinic"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_range

  tags = {
    Name="${local.env}-${local.projectName}"
    executebyterraform=true
  }
}


locals {
  typesubnet=["public","private"]
  terraform=true

}


resource "aws_subnet" "nat-public-instance"{
    
    
    vpc_id = aws_vpc.main.id
    availability_zone = var.nat-pblc-instance.nat-subnet["availability_zone"]
    cidr_block = var.nat-pblc-instance.nat-subnet["cidr_block"]
    tags={
        Name=var.nat-pblc-instance.nat-subnet["name"]
    }
}


resource "aws_subnet" "public-subnets"{

    for_each=var.pblcsbnt-config
    vpc_id = aws_vpc.main.id
    availability_zone = each.value.availability_zone
    cidr_block= each.value.cidr_block
    tags={
        Name=each.value.name
        executebyterraform="${local.terraform}"
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id

    tags={
        Name="${local.typesubnet[0]}-route"
        executebyterraform="${local.terraform}"
    }
}

resource "aws_route_table" "pblc-route" {
    vpc_id = aws_vpc.main.id


    route {
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw.id 
    }
    tags={
        Name="terra-1"
        executebyterraform="${local.terraform}"
    }

}

resource "aws_route_table_association" "public-association" {
   for_each = aws_subnet.public-subnets
   subnet_id       = each.value.id
   route_table_id = aws_route_table.pblc-route.id
}

resource "aws_route_table_association" "nat-assocation"{
    subnet_id=aws_subnet.nat-public-instance.id 
    route_table_id= aws_route_table.pblc-route.id
}

/*  ===========private-subnet-configuration=========== */


resource "aws_eip" "elastic-ip"{
    domain = "vpc" 
   

    tags={

        Name=var.elastic-ip-name
        executebyterraform="${local.terraform}"
    }
}


resource "aws_subnet" "private-subnets"{
    for_each=var.prvtsbnt-config
    vpc_id = aws_vpc.main.id
    availability_zone =each.value.availability_zone
    cidr_block = each.value.cidr_block


    tags={
        Name=each.value.name
        executebyterraform="${local.terraform}"
    }
}


resource "aws_nat_gateway" "ngw"{
    
    allocation_id = aws_eip.elastic-ip.id
    subnet_id= aws_subnet.nat-public-instance.id
}




resource "aws_route_table"  "prvt-route"{
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
      
     }

     tags={
        Name="prvt-route"
     }

}



resource "aws_route_table_association" "prvt-association" {
  for_each = aws_subnet.private-subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.prvt-route.id
}



# resource "aws_security_group" "ecs-sg" {
#   name ="ecs-sg"
#   vpc_id = aws_vpc.main.id
#   ingress {
#       description = "inbound-traffic"
#       from_port = "80"
#       to_port = "80"
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress{
#       description = "outbound-traffic"
#       from_port = "0"
#       to_port= "0"
#       protocol = "-1" 
#       cidr_blocks = ["0.0.0.0/0"]
#   }
# }