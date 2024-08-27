output "cname_records" {
  description = "CNAME records for DNS validation"
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      name  = dvo.resource_record_name,
      value = dvo.resource_record_value
    }
  ]
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}