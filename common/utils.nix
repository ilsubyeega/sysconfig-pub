{lib, ...}: with lib; rec {
  #forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
  #  pkgs = import nixpkgs { inherit system; };
  #});


  # https://github.com/infinisil/system/blob/559426678cd18ed9edd6d97bbe8e1cd2cce3488d/config/new-modules/default.nix
  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  getDir = dir: mapAttrs
    (file: type: if type == "directory" then getDir "${dir}/${file}" else type)
    (builtins.readDir dir);
  
  # Collects all files of a directory as a list of strings of paanths
  files = dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  # todo remove .nix suffix
  validFiles = dir: filter (file: hasSuffix ".nix" file && file != "default.nix") (files dir);

  makeDirImportAttr = dir:
    lib.attrsets.updateManyAttrsByPath 
      (map 
        (strPath:
          {
            # https://github.com/NixOS/nixpkgs/blob/0c59695ccc5d8452a4d4c3a3318422efd282918f/lib/strings.nix#L1474
            path = builtins.filter builtins.isString (builtins.split "/|\\." (removeSuffix ".nix" strPath));
            update = old: import ("${dir}/${strPath}");
          }
        ) (validFiles dir)
      )
      {}; # initial attr set

  forAllSystemsInit = supportedSystems : lib.genAttrs supportedSystems;
}
