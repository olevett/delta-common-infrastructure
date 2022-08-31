resource "aws_instance" "ad_management_server" {
  subnet_id = var.public_subnet.id
  ami           = data.aws_ami.windows_server.id
  instance_type = var.management_instance_type
  key_name = aws_key_pair.ad_management_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ad_management_server.id]
  associate_public_ip_address = true
  get_password_data = true
  iam_instance_profile = aws_iam_instance_profile.ad_management_profile.name

  tags = merge(var.default_tags, {name="AD management server"})
}

resource "aws_ssm_document" "ad_join_domain" {
  name          = "ad-join-domain"
  document_type = "Command"
  content = jsonencode(
    {
      "schemaVersion" = "2.2"
      "description"   = "aws:domainJoin"
      "mainSteps" = [
        {
          "action" = "aws:domainJoin",
          "name"   = "domainJoin",
          "inputs" = {
            "directoryId" : aws_directory_service_directory.directory_service.id,
            "directoryName" : aws_directory_service_directory.directory_service.name
            "dnsIpAddresses" : sort(aws_directory_service_directory.directory_service.dns_ip_addresses)
          }
        }
      ]
    }
  )
}

resource "aws_ssm_association" "windows_server" {
  name = aws_ssm_document.ad_join_domain.name
  targets {
    key    = "InstanceIds"
    values = [ aws_instance.ad_management_server.id ]
  }
}