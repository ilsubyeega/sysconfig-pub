{ pkgs-unstable, lib, ... }: {
  home.packages = with pkgs-unstable; [ 
    
    (lib.setPrio 0 nodejs_22)
    (lib.setPrio 8 nodejs_20)
    (lib.setPrio 10 nodejs_18)
    
    pnpm
    yarn-berry
    typescript
    
    deno
    bun
    
  ];
}