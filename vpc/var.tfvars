vpc_cidr_range="10.9.0.0/16"

nat-pblc-instance ={
  nat-subnet={
     availability_zone = "ap-southeast-2a"
     cidr_block        = "10.9.0.0/24"
     name              = "pblc-A"

  }
}

elastic-ip-name="elp-1"

pblcsbnt-config = {
  pblc-B = {
    availability_zone = "ap-southeast-2a"
    cidr_block        = "10.9.16.0/24"
    name             = "pblc-B"
  }
  
}

prvtsbnt-config = {
  prvt-A = {
    availability_zone = "ap-southeast-2b"
    cidr_block        = "10.9.32.128/26"
     name              = "prvt-A"
  }
}
#    prvt-b = {
#     availability_zone = "ap-southeast-2b"
#     cidr_block        = "10.9.64.128/26"
#      name              = "prvt-B"
#   }
   
# }