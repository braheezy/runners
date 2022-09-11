source "vagrant" "qemu" {
  communicator = "ssh"
  source_path = "generic/fedora35"
  provider = "libvirt"
}

build {
  sources = ["source.vagrant.qemu"]

  # Required for ansible-local provisioners
  provisioner "shell" {
    inline = [
      "sudo yum install -y ansible-core python3-psutil cowsay"
    ]
  }

  # Do bulk of provisioning
  provisioner "ansible-local" {
    playbook_file = "provision.yml"
    role_paths = [
      "roles/github-runner",
      "roles/gnome",
      "roles/hashicorp",
      "roles/qemu",
    ]
    galaxy_file = "requirements.yml"
    extra_arguments = [
      "-e", "stdout_callback=yaml",
      "-e", "vagrant_password=${var.vagrant_password}",
      "-e", "runner_password=${var.runner_password}",
      "-e", "github_pat=${var.github_pat}",
      "-e", "github_account=${var.github_account}",
      "-e", "github_repo=${var.github_repo}"
    ]
  }
}

variable "github_pat" {
  type = string
  sensitive = true
}

variable "vagrant_password" {
  type = string
  sensitive = true
}

variable "runner_password" {
  type = string
  sensitive = true
}

variable "github_account" {
  type = string
}

variable "github_repo" {
  type = string
}