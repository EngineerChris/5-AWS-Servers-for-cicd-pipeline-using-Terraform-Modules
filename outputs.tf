output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}

output "maven_public_ip" {
  value = module.maven.public_ip
}

output "sonarqube_public_ip" {
  value = module.sonarqube.public_ip
}

output "gradle_public_ip" {
  value = module.gradle.public_ip
}

output "nexus_public_ip" {
  value = module.nexus.public_ip
}
