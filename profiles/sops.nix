{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ssh-to-age
    pkgs.sops
  ];

#  imports = [ nix-sops ];
  
  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  # sops.defaultSopsFile = "/etc/nixos/nix-dotfiles/secrets/secrets.yaml";
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    validateSopsFiles = false;

    # This will automaticx-sopsally import SSH keys as age keys
    age.sshKeyPaths = [
			  "/etc/ssh/nixos"
			  "/root/.ssh/nixos"
			];
    # This is using an age key that is expected to already be in the filesystem
    #age.keyFile = "/var/lib/sops-nix/key.txt";
    age.keyFile = "/root/.config/sops/age/key.txt";
    # This will generate a new key if the key specified above does not exist
    age.generateKey = true;
    # This is the actual specification of the secrets.
    #secrets."myservice/my_subdir/my_secret" = {};
  };
}
