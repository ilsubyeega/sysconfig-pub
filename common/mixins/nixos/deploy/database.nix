{ ... }: {
  #users.mysql = {
  #  enable = true;
  #}; FIXME: needs password file
  # todo: run both mysql and mariadb.
  services = {
    postgresql = {
      enable = true;
      # todo: settings, extensions
    };
    
    #surrealdb = {
    #  enable = true;
    #};
    
    #cockroachdb = {
    #  enable = true;
    #};
    
    #mongodb = {
    #  enable = true;
    #};
    
  };
}