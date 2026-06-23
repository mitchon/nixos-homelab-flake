{ pkgs, stateVersion, user, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-configuration.nix
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
      trusted-users = [ "mitchanx" ];
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  
  time.timeZone = "Europe/Moscow";

  users.users = {
    ${user} = {
      isNormalUser = true;
      hashedPassword = "$6$de/UeqWKkV/fcHBT$b4aR5evqxWWz22S89iVik/rpszxXbu.jN/cL33BCZW.IT1VyPjYx6rWnCATxdAdTwrleLGFtSy095xjwjo3VA0";
      uid = 1000;
      extraGroups = [ user "wheel" "docker" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvu0QbEP/ADt7+XBL2UHncZtPxgXuCTgQt6hufCk0Tl mitchanx@think-nix"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL9SPeg/wwqfMhfagx+atX/dq8IMTU8jipXzHiSSkxg2 nugget@hp-deep-fryer"
      ];
    };
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

  services.qemuGuest.enable = true;

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
