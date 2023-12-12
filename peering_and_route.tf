data "aws_caller_identity" "peer" {
  provider = aws.peer
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = module.region-1.vpc_id
  peer_vpc_id   = module.region-2.vpc_id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = var.region-2.region
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}


# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}


data "aws_route_table" "main" {
  vpc_id = module.region-1.vpc_id
}

resource "aws_route" "peer" {
  route_table_id         = data.aws_route_table.main.id
  destination_cidr_block = var.region-2.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}


data "aws_route_table" "secondary" {
  provider = aws.peer
  vpc_id = module.region-2.vpc_id
}


resource "aws_route" "main" {
  provider = aws.peer
  route_table_id         = data.aws_route_table.secondary.id
  destination_cidr_block = var.region-1.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id
}
