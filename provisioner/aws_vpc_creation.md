for creating the aws VPC 
1. creating the key  adding the path for public key for log in to server 
2. we need CIDR block in the aws_vpc terraform block 
3. creating for public and private subnets --> adding CDIR block for subnet --> adding the available_zone  --> adding vpc id in the subnet block 
4. creating the InternetGateway (IG) --> adding the vpc id in the IG 
5. creating the routing table  --> adding the vpc id --> adding route block in this block adding gateway id 
6. associating routing table to subnet --> adding public subnet id --> adding routing table id
7. creating the security_group --> need to add vpc id --> adding ingress --> engress 
8. creating the instances  -- > adding keyname --> adding the security group ids --> adding the subent id 
