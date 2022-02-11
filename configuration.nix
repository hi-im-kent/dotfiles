# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, libs, pkgs, options, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "(Your Hostname)"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "(Time zone)";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sounds
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.(User Name) = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };
  
 };
  nixpkgs.config = {
     nixpkgs.config.allowUnfree = true;
     packageOverrides = pkgs: {
     unstable = import <nixos-unstable> {
     config = config.nixpkgs.config;
     };
   };
 };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  ### You don't need to copy all of those packages
  environment.systemPackages = with pkgs; [
     vim neovim wget tor privoxy steam pipewire flatpak chrome-gnome-shell
     virt-manager keepassxc tor-browser-bundle-bin libvirt gnome.gnome-tweaks git neofetch killall
     htop vscode papirus-icon-theme lolcat mesa onionshare freenet transmission blender 
     gimp firefox transmission-gtk handbrake krita torsocks gnomeExtensions.espresso
     gnomeExtensions.clipboard-indicator fractal
 ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin

 ];
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy hangul mozc m17n typing-booster table table-chinese table-others ];
 };

  fonts.fontDir.enable = true;

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
      '';
 };

  services.yggdrasil = {
    enable = true;
    persistentKeys = false;
 };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable Flatpaks
  services.flatpak.enable = true;

  # Enable Bluetooth support (Uncomment to enable bluetooth support)
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # Pipewire config
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    #media-session.enable = true;
  };

  # Enable Steam support
  programs.steam.enable = true;
  
  # Allow installing unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Chrom Gnome Shell (GNOME Extension support)
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome.chrome-gnome-shell.enable = true; 

  # Tor and Privoxy stuff
  # services.tor.enable = true; 
  # services.tor.client.enable = true;
  # services.privoxy.enable = true; 
  # services.privoxy.enableTor= true;

  # Virt Manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Zeronet thingy 
  # services.zeronet.enable = true; 
  
  ### Uncomment to enable printing support
  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.gutenprint pkgs.gutenprintBin pkgs.cnijfilter2 ];

  ### Uncomment to enable auto upgrade (Unstable branch)
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = false;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

