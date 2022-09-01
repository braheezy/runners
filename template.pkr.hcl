source "vagrant" "qemu" {
  communicator = "ssh"
  source_path = "generic/fedora35"
  provider = "libvirt"
}

build {
  sources = ["source.vagrant.qemu"]

  # Required for ansible-local provisioners
  provisioner "shell" {
    inline = ["sudo yum install -y ansible-core cowsay",
              "ansible-galaxy collection install community.general"]
  }

  # Do bulk of provisioning
  provisioner "ansible-local" {
    playbook_file = "provision.yml"
    playbook_dir = "roles"
    command = var.ansible_command
    extra_arguments = [
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
}

# Changing the called command seems to be the only way to inject Ansible ENV vars
variable "ansible_command" {
  type = string
  default = "ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ANSIBLE_COW_SELECTION=hellokitty ansible-playbook"
}
