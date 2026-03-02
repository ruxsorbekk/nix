{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Enabling Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10; # Keeps boot menu clean
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # --- DESKTOP ENVIRONMENT (GNOME) ---
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Helper services for a smooth desktop experience
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.blueman.enable = true;

  # Networking & Localization
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  # Hardware / Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Background Services
  services.redis.servers."default".enable = true;

  # Programs & Compatibility
  programs.nix-ld.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.firefox.enable = true;
  programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;

  users.users.ruxsorbek = {
    isNormalUser = true;
    description = "Ruxsorbek Norimmatov";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    # Applications
    spotify 
    telegram-desktop
    google-chrome
    vscode
    obs-studio
    vlc
    # Development
    neovim
    zed-editor
    jetbrains.rust-rover
    jetbrains.pycharm
    python314
    gcc
    git
    direnv
    nix-direnv
    wakatime-cli
    jre8
    # Utilities
    fastfetch
    neofetch
    anydesk
    vim
    wget
    kitty
    flatpak
    ffmpeg    
  ];

  system.stateVersion = "25.11";
}