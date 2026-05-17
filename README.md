## Installation steps

#### clone and cd

`git clone https://github.com/mitchon/nixos-homelab-flake.git
cd nixos-homelab-flake`

#### run disko (check disk name)

`sudo nix --experimental-features 'nix-command flakes' \ 
run github:nix-community/disko -- --mode disko ./disko-configuration.nix`

#### regenerate hardware config if needed

`nixos-generate-config --no-filesystem --show-hardware-config > ./hardware-configuration.nix`

#### making swapfile (optional, 4 gigs is not enough)

`sudo dd if=/dev/zero of=/dev/swapfile bs=1M count=4096
sudo mkswap /dev/swapfile
sudo swapon /dev/swapfile`

#### run nixos-install

`sudo nixos-install --flake .#homelab --root /mnt --no-root-passwd`
