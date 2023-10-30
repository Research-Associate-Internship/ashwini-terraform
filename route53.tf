resource "aws_route53_record" "hashicorp-vault" {
  zone_id = "Z03309881PN2JZ6GGLOJ8"
  name    = "vault-rac3.axle-interns.com"
  type    = "A"
  alias {
    name                   = aws_lb.rac3-hashicorp.dns_name
    zone_id                = "Z35SXDOTRQ7X7K"
    evaluate_target_health = true
  }
}
