{ inputs, ... }: {
  perSystem = { self', inputs', pkgs, system, config, ... }: {
    formatter = pkgs.nixfmt-classic; # todo: use nixfmt-rfc-style later.
  };
}
