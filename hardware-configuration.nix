{ lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/mnt/hdd" = { 
    device = "/dev/disk/by-uuid/2eeedad6-fb5e-434e-a6a0-f340f7503eb1";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
      "nofail"
    ];
    neededForBoot = false;
  };

  swapDevices = [ {
    device = "/.swapfile";
    size = 4 * 1024;
  } ];

  systemd.tmpfiles.rules = [
    "d /mnt/hdd 0755 mitchanx users - -"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
