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
    playbook_dir = "roles"
    command = var.ansible_command
    galaxy_file = "galaxy-requirements.yml"
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3",
      "-e", "vagrant_password=${var.vagrant_password}",
      "-e", "runner_password=${var.runner_password}",
      "-e", "github_pat=${var.github_pat}"
    ]
  }
}

# Changing the called command seems to be the only way to inject Ansible ENV vars
variable "ansible_command" {
  type = string
  default = <<TEXT
    ANSIBLE_FORCE_COLOR=1 \
    PYTHONUNBUFFERED=1 \
    ANSIBLE_COW_SELECTION=hellokitty \
    ansible-playbook \
  TEXT
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