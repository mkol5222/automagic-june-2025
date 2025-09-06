data "http" "myip" {
  # url = "http://ip.iol.cz/ip/"
  url = "https://ifconfig.me/ip"
}

output "myip" {
  value = data.http.myip.response_body
}