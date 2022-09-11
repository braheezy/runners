NAME            := $(shell basename $(CURDIR))
VERSION         := 0.1.0
ROOT_DIR        := $(CURDIR)
PACKER_BIN      := /usr/bin/packer
PACKER_TEMPLATE := $(ROOT_DIR)/template.pkr.hcl
QEMU_OUTPUT     := $(ROOT_DIR)/output-qemu/package.box

ORANGE = \e[0;33m
GREEN = \e[0;32m
END = \e[0m

.PHONY: qemu all clean help

define help_text
Targets:
  - make qemu:           Create QEMU/Libvirt target.
  - make all:            Create all targets listed above.
  - make clean:          Delete build aritfacts, like it never happened
  - make [help]:         Print this help.
endef
export help_text

help:
	@echo "$$help_text"

all: qemu
	@echo -e "${GREEN}Build is complete!${END}"

qemu: $(QEMU_OUTPUT)

$(QEMU_OUTPUT): $(PACKER_TEMPLATE)
	@echo -e "${GREEN}Starting build for qemu!${END}"
	$(PACKER_BIN) build .

clean:
	@echo -e "${GREEN}Deleting output folders...${END}"
	@rm -rf output-*
