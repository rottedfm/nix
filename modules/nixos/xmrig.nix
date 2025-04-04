{ ... }:

{
  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = {
        enabled = true;
        max-threads-hint = 90;
      };
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.supportxmr.com:443";
          user = "48UEoFuv5n9Hweg5JioChG4aX1jXPQtYcKtUqfry2iWe8HgqJHVztPYCqvQD8aX5f6CzG8jcXbkJMFexcKvkTRMsGEyhr5U";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };

  services.monero = {
    enable = true;
  };
}
