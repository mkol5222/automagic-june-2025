
# random password 16 chars - numbers, letters
resource "random_password" "sic_key" {
  length  = 16
  special = false
}

output sic_key {
  value       = random_password.sic_key.result
  sensitive   = true
  description = "SIC Key"
  depends_on  = [random_password.sic_key]
}


# ../secrets/vwan-nva-sic.txt
resource "local_file" "vwan_nva_sic" {
  content  = random_password.sic_key.result
  filename = "${path.module}/../secrets/vwan-nva-sic.txt"
}