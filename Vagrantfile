# The resources to give the VM.
CPUS = 2
MEMORY = 6144
# The name of the VM.
NAME = "builder-f35"

Vagrant.configure("2") do |config|
  config.vm.box = NAME

  config.vm.define NAME
  config.vm.hostname = NAME

  config.vm.provider :libvirt do |l, override|
    override.vm.box_url =  "#{__dir__}/output-qemu/package.box"
    override.vm.box = NAME

    l.driver = "kvm"
    l.cpus = CPUS
    l.memory = MEMORY
    l.disk_bus = "virtio"

    l.default_prefix = ""

    # Use the preferred video driver
    l.video_type = 'qxl'
    # Enable sound!
    l.sound_type = 'ich9'
    # SPICE looks great and provides copy/paste too.
    l.graphics_type = "spice"
    l.channel :type => 'spicevmc', :target_name => 'com.redhat.spice.0', :target_type => 'virtio'

    # Libvirt shared folders. This requires fairly modern versions of Linux.
    l.memorybacking :source, :type => "memfd"
    l.memorybacking :access, :mode => "shared"
    override.vm.synced_folder ".", "/vagrant", type: "rsync", disabled: true

    # Enable Hyper-V enlightments: https://blog.wikichoon.com/2014/07/enabling-hyper-v-enlightenments-with-kvm.html
    l.hyperv_feature :name => 'relaxed', :state => 'on'
    l.hyperv_feature :name => 'synic',   :state => 'on'
    l.hyperv_feature :name => 'vapic',   :state => 'on'
    l.hyperv_feature :name => 'vpindex', :state => 'on'

    l.nested = true
  end

end
