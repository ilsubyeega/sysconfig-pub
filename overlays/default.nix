{ super, ... }:
let

  # adding custom packages from the packages directory.
  additions = final: _prev: import ../packages { pkgs = final; };

  # todo: add modifications
  modifications = final: prev:
    {

    };

  # add stable, unstable, master packages
  add-extra-packages = final: _prev:
    let
      arg = {
        system = final.system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };

      };
    in with super.inputs; {
      stable = import nixpkgs-stable arg;
      unstable = import nixpkgs-unstable arg;
      master = import nixpkgs-master arg;
      stable-locked = import nixpkgs-stable-locked arg;
    };

in { nixpkgs.overlays = [ additions modifications add-extra-packages ]; }
