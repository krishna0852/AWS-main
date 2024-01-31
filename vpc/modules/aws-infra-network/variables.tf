variable "vpc_cidr_range" {
      type=string 
      description="vpc-cidr-block"
 }

 variable "nat-pblc-instance" {
       type=map(object({
       availability_zone=string 
       cidr_block=string
       name=string

  }))

 }

 variable "elastic-ip-name" {
     type=string
     description = "give elastic-ip-names"   
 }

 variable "pblcsbnt-config" {
  type=map(object({
    availability_zone=string 
    cidr_block=string
    name=string

  }))

}


variable "prvtsbnt-config" {
  type=map(object({
    availability_zone=string 
    cidr_block=string
    name=string

  }))
}


# variable "vpc-id" {
#    type=string 
#    description="vpc-id"  
# }


# "10.9.0.0/24" 


# 10.9.0.0/27 --> 32 


# 10.9.0.35/27 --->32