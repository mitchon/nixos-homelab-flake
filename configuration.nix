{ config, lib, pkgs, stateVersion, user, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  
  time.timeZone = "Europe/Moscow";

  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ user "wheel" "docker" ];
  };

  users.groups.${user} = {
    gid = 1000;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = stateVersion;
}
