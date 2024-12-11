{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  time.timeZone = "Europe/Belgrade";
  
  i18n.defaultLocale = "en_GB.UTF-8";
}