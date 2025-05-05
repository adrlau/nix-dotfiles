{ pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    settings = {
      # Data files
      db_path = "~/.history.db";

      # Filtering
      filter_mode = "host";
      filter_mode_shell_up_key_binding = "directory";

      # UI
      max_preview_height    = 2;
      show_help             = true;
      prefers_reduced_motion = true;

      # History storage
      secrets_filter = true;
      enter_accept   = true;

      # Sync v2
      sync = {
        records = true;
      };

      # Stats
      stats = {
        common_subcommands = [
          "apt" "cargo" "composer" "dnf" "docker" "git" "go" "ip"
          "kubectl" "nix" "nmcli" "npm" "pecl" "pnpm" "podman"
          "port" "systemctl" "tmux" "yarn"
        ];
        common_prefix = [ "sudo" ];
      };

      # Keys
      keys = {
        scroll_exits = true;
      };

      # Theme
      theme = {
        name = "marine";
      };

      # Search
      search = {
        filters = [ "directory" "host" "session" ];
      };
    };
  };
}
