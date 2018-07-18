resource "aws_vpc" "defaultvpc" {
  cidr_block = "10.0.0.0/16"
  
  tags {
    Name = "defaultvpc"
  }
}

resource "aws_subnet" "external" {
  vpc_id = "${aws_vpc.defaultvpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1d"
  
  tags {
    Name = "defaultvpc.external.ap-northeast-1d"
  }
}
