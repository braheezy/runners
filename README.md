# Runners
Packer templates and other scripts for building custom runner images for GitHub actions.

The only project in here now builds a virtual image that has nested virtualization enabled so it can build other VMs.

## Usage
Copy `secret.auto.pkrvars.hcl.template` to `secret.auto.pkrvars.hcl` and populate with information.

Run `make qemu` to create a new Runner box. The image inside is registered to GitHub, so watch for that!

Run `vagrant up` to get the box up. Now keep it up forever or only when you need it.
