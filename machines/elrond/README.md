# things to setup on new headscale server
### setup nixos
1. get nixos running (preferably 22.11 or later)
2. get a way to paste the config file from this repo to /etc/nixos/configuration.nix (like over ssh)

### domain provider
1. setup domain and domain and domain with wildcard to point to new server ip.
2. make sure any other domains that require this ingress points to it.
3. create a api key or similar to fit in a file like this. https://go-acme.github.io/lego/dns
4. create api kay file in /ver/lib/secrets/cert.secret, you can drop the \ and the last config line in  the example from lego as this is not needed with nixos




### setup tailscale headscale
1. create a namespace in headscale.
2. add tailscale to headscale with ```sudo tailscale up --login-server https://vpn.example.domain ``` (could be localhost) 
3. follow link in a browser, copy result command on this server, but replace USERNAME in --user USERNAME with namespace name (might be that headscale has updated and only uses namespaces as term now?)
4. add all other clients needed to tailscale again with the same process

### done

# add a new remote or nated service
1. add the machine running the service to the tailscale/headscale network like in install process
2. get the headscale name with ``` headscale nodes list ```
3. go to configuration.nix with vim or another editor
4. add a virtual host to nginx for proxy, can copy one and change subdomain and proxy to  machine + port, might remove basic auth if the service is intendend for everyone.


#Other solutions
might end in the situation where nixos is not an option and docker containers with diffrent things is my backup solution.
nothing is created yet but plan to use headscale with headscale-ui docker container in addition to something like nginxproxymanager,træfik or caddy.  In this case use  certbot or acme for certs i think.

NGINX alternative: Caddy seems promising with tailscale integrated in the future. 

Tailscale/headscale alternative: plain wireguard, openvpn or 

