
output "objects" {
  value = tomap(
    { (var.landingzone.key) = {
      for key, value in module.example : key => value
      if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}