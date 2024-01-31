vpc_cidr_range="10.9.0.0/16"
pblcsbnt-config = {
  pblc-a = {
    availability_zone = "ap-southeast-2a"
    cidr_block        = "10.9.0.0/26"
    name              = "pblc-A"
  }
   
}
prvtsbnt-config = {
  prvt-a = {
    availability_zone = "ap-southeast-2b"
    cidr_block        = "10.9.0.128/26"
     name              = "prvt-A"
  }
   prvt-b = {
    availability_zone = "ap-southeast-2b"
    cidr_block        = "10.9.14.128/26"
     name              = "prvt-B"
  }
   
}