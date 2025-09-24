{ config, pkgs, lib, ... }:
let
  myPython = pkgs.python3; 

  myJupyterHubEnv = myPython.withPackages (ps: with ps; [
    jupyterhub
    jupyterhub-systemdspawner 
    ipython
    jupyterlab
    notebook
    ipykernel
    numpy
    scipy
    pandas
    matplotlib
    seaborn
    scikit-learn
  ]);

  myJupyterLabEnv = myPython.withPackages (ps: with ps; [
    jupyterhub
    jupyterlab
    ipykernel
    numpy
    scipy
    pandas
    matplotlib
    seaborn
    scikit-learn
  ]);

in
{
  environment.systemPackages = with pkgs; [
    python3Packages.numpy
    python3Packages.scipy
    python3Packages.pandas
    python3Packages.matplotlib
    python3Packages.seaborn
    python3Packages.scikit-learn
  ];
  
  users.users.tdt4117 = {
    isNormalUser = true;
    home = "/home/tdt4117";
    description = "Alice Foobar";
    extraGroups = [ ];  
    # openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... " ];
  };

  services.jupyterhub = {
    jupyterhubEnv = myJupyterHubEnv;
    jupyterlabEnv = myJupyterLabEnv;
    enable = true;
    port = 8770;
    host = "0.0.0.0";
    extraConfig = ''
      c.Authenticator.allow_all = True
      c.ConfigurableHTTPProxy.api_url = 'http://0.0.0.0:8770'
      c.JupyterHub.bind_url = 'http://0.0.0.0:8771'
      '';

    kernels = {
      python3 = let
        env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
                ipykernel
                pandas
                scikit-learn
                seaborn
                pandas
                huggingface-hub
                datasets
                matplotlib
                tqdm
                numpy
                scipy

              ]));
      in {
        displayName = "Python 3 for machine learning";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };




  };

}
