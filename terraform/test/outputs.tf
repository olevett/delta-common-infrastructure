output "ad_management_server_ip" {
  value = module.active_directory.ad_management_server_ip
}

output "ad_management_server_dns" {
  value = module.active_directory.ad_management_server_dns
}

output "ad_management_server_password" {
  # this is encrypted, so not sensitive
  value = module.active_directory.ad_management_server_password
}
