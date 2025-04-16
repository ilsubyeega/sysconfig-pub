{ pkgs, ... }: let

  # https://bugs.kde.org/show_bug.cgi?id=423187
  # See this bug for freeze issue....


  fuse = pkgs.fuse;
  rclone = pkgs.rclone;

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
        ExecStartPre = "/usr/bin/env mkdir -p /mnt-sync/rclone-cache /mnt-sync/${name}";
        ExecStart = ''
          ${rclone}/bin/rclone \
            mount ${name}: /mnt-sync/${name} \
            --config=%h/.config/rclone/rclone.conf \
            --volname "${fullName}" \
            --log-level INFO \
            --cache-dir /mnt-sync/rclone-cache \
            ${args}
        '';

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

  in
{
  home.packages = [ fuse rclone ];

  systemd.user.services = createService {
    name = "onedrive";
    fullName = "ilsubyeega@outlook.com";
    args = cache-template + vfs-template + poll-template;
  } // createService {
    name = "onedrive-crypt";
    fullName = "ilsubyeega@outlook.com (Crypted)";
    args = cache-template + vfs-template + poll-template;
  } // createService {
    name = "gdrive";
    fullName = "ilsubyeega@gmail.com";
    args = cache-template + vfs-template + poll-template + ''
      --fast-list \
    '';
  } // createService {
    name = "thftgr";
    fullName = "thftgr synology";
    args = vfs-template + disable-remote-size + ''
      --dir-cache-time 10s \
      --sftp-idle-timeout 30m \
    '';
  } // createService {
    name = "thftgr-crypt";
    fullName = "thftgr synology (Crypted)";
    args = vfs-template + disable-remote-size + ''
      --dir-cache-time 10s \
      --sftp-idle-timeout 30m \
    '';
  };

  systemd.user.tmpfiles.rules = [
    /* From manpage,

       - D: Similar to d, but in addition the contents of the directory will be removed when --remove is used.
         - Rule syntax: `D /path/path(Path) Mode User Group Age -`
    */
    "D /mnt-sync 1777 sob root -"
  ];

  # sudo chown -R sob /mnt-sync
}
