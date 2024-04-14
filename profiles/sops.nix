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
  sops.defaultSopsFile = "/etc/nixos/nix-dotfiles/secrets/secrets.yaml";
  sops.validateSopsFiles = false;
  # This will automaticx-sopsally import SSH keys as age keys
  sops.age.sshKeyPaths = [
			  "/etc/ssh/nixos"
			  #"/$HOME/.ssh/nixos"
        #"/home/gunalx/.ssh/nixos"
			];
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;

  # This is the actual specification of the secrets.
  #sops.secrets."myservice/my_subdir/my_secret" = {};

}
