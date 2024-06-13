{ pkgs, lib, ... }: {

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true;

    # Extensions
    extensions = (with pkgs.vscode-extensions; [
      # Stable
      ms-vscode-remote.remote-ssh
      mhutchie.git-graph
      pkief.material-icon-theme
      oderwat.indent-rainbow
      
      yzhang.markdown-all-in-one
      bierner.markdown-checkbox
      svsool.markdown-memo
      shd101wyy.markdown-preview-enhanced
      jebbs.plantuml
      
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
      vue.volar
      ms-vscode.cpptools-extension-pack
      ms-python.python
      vscjava.vscode-java-pack

      github.copilot
      github.copilot-chat



    ]) ++ (with pkgs.unstable.vscode-extensions; [
      # Unstable
      continue.continue

    ]);

    # Settings
    userSettings = {
      # General
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'Jetbrains Mono', 'monospace', monospace";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "window.zoomLevel" = 1;
      "editor.multiCursorModifier" = "ctrlCmd";
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;
      # Whitespace
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "diffEditor.ignoreTrimWhitespace" = false;
      # Git
      "git.enableCommitSigning" = true;
      "git-graph.repository.sign.commits" = true;
      "git-graph.repository.sign.tags" = true;
      "git-graph.repository.commits.showSignatureStatus" = true;
      # Styling
      "window.autoDetectColorScheme" = true;
      "workbench.preferredDarkColorTheme" = "Default Dark Modern";
      "workbench.preferredLightColorTheme" = "Default Light Modern";
      "workbench.iconTheme" = "material-icon-theme";
      "material-icon-theme.activeIconPack" = "none";
      "material-icon-theme.folders.theme" = "classic";
      # Extentions
      "nix.enableLanguageServer"= true;

      # Other
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
    };

  };
}
