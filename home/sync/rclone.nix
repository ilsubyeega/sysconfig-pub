# todo: implement preconfigured one.
{ pkgs, ... }:
let

  #createService = (name, config) : {
  #  [ name ] = {
  #    enable = true;
  #    serviceConfig = {
  #      ExecStart = "${pkgs.rclone}/bin/rclone ${config}";
  #      Restart = "always";
  #      RestartSec = "10";
  #      User = "sob";
  #      Group = "sob";
  #    };
  #  };
  #};

  fuse = pkgs.fuse;
  rclone = pkgs.unstable.rclone;

  createService = { name, fullName, args, ... }: {
    "rclone-${name}" = {
      Unit = {
        Description = "Rclone ${fullName} service";
        Documentation = "man:rclone(1)";
        After = [ "network-online.target" "systemd-tmpfiles-setup.service" ];
        Wants = [ "network-online.target" "systemd-tmpfiles-setup.service" ];
      };
      Service = {
        Type = "notify";
        # create directory if it doesn't exist.
        ExecStartPre =
          "/usr/bin/env mkdir -p /mnt-sync/rclone-cache /mnt-sync/${name}";
        # todo: figure out options => umask, syslog
        ExecStart = ''
          ${rclone}/bin/rclone \
                      mount ${name}: /mnt-sync/${name} \
                      --config=%h/.config/rclone/rclone.conf \
                      --volname "${fullName}" \
                      --log-level INFO \
                      --log-file /tmp/rclone-${name}.log \
                      --cache-dir /mnt-sync/rclone-cache \
                      ${args} '';
        ExecStop = "/run/wrappers/bin/fusermount -u -z /mnt-sync/${name}";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
  cache-template = ''
    --dir-cache-time 5m \
  '';
  vfs-template = ''
    --vfs-cache-mode full \
    --vfs-cache-max-size 40G \
    --vfs-read-chunk-size 128M \
    --vfs-read-ahead 2G  \
    --vfs-cache-max-age 24h \
    --vfs-write-back 5s \
  '';

  poll-template = ''
    --poll-interval 10s \
  '';

  # https://forum.rclone.org/t/ability-to-disable-directory-calculation-on-features-about/39741/4
  disable-remote-size = ''
    --disable About \
  '';

in {

  home.packages = [ fuse rclone ];

  #systemd.user.services = createService {
  # redacted


  systemd.user.tmpfiles.rules = [
    /* From manpage,

       - D: Similar to d, but in addition the contents of the directory will be removed when --remove is used.
         - Rule syntax: `D /path/path(Path) Mode User Group Age -`
    */
    "D /mnt-sync 1777 sob root -"
  ];

}
