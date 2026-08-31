{ pkgs, ... }:
{
  # Host-specific configuration for ouroboros goes here.
  home.packages = with pkgs; [
    llama-cpp
  ];
}
