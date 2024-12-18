{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=false"
        "udev.log_priority=3"
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device"
        "nowatchdog"
        "modprobe.blacklist=iTCO_wdt"
      ];
      kernelModules = ["v4l2loopback"];
      extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
      initrd = {
        verbose = false;
        availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      };
      loader.efi = {
        canTouchEfiVariables = true;
      };
      loader.timeout = 3;
      loader.grub = {
	    enable = true;
	      devices = [ "nodev" ];
	      efiSupport = true;
	      memtest86.enable = true;
	      extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
	      configurationName = "${host}";
        dedsec-theme = {
          enable = true;
          style = "reaper";
          icon = "color";
          resolution = "1440p";
    };     
  	};
      tmp = {
        useTmpfs = false;
        tmpfsSize = "30%";
      };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = true;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
      
    plymouth.enable = true;
    plymouth.themePackages = [
      pkgs.catppuccin-plymouth
    ];
    plymouth.theme = "catppuccin-macchiato";
    };
}
