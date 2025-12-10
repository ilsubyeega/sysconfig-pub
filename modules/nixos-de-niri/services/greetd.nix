_: {
  services.greetd =
    let
      session = {
        command = "niri-session";
        user = "sob";
      };
    in
    {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };

  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "sob";
  };
}
