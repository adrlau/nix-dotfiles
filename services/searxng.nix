{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [

  ];


services.searx = {
  enable = false;
  redisCreateLocally = true;

  # Rate limiting
  limiterSettings = {
    real_ip = {
      x_for = 1;
      ipv4_prefix = 32;
      ipv6_prefix = 56;
    };

    botdetection = {
      ip_limit = {
        filter_link_local = true;
        link_token = true;
      };
    };
  };

  # UWSGI configuration should be true for non single user instances.
  runInUwsgi = false;

  uwsgiConfig = {
    socket = "/run/searx/searx.sock";
    http = ":8888";
    chmod-socket = "660";
  };

  # Searx configuration
  settings = {
    # Instance settings
    general = {
      debug = false;
      instance_name = "SearXNG Instance";
      donation_url = false;
      contact_url = false;
      privacypolicy_url = false;
      enable_metrics = false;
    };

    # User interface
    ui = {
      static_use_hash = true;
      default_locale = "en";
      query_in_title = true;
      infinite_scroll = false;
      center_alignment = true;
      default_theme = "simple";
      theme_args.simple_style = "auto";
      search_on_category_select = false;
      hotkeys = "vim";
    };

    # Search engine settings
    search = {
      safe_search = 2;
      autocomplete_min = 2;
      autocomplete = "duckduckgo";
      ban_time_on_fail = 5;
      max_ban_time_on_fail = 120;
    };

    # Server configuration
    server = {
      base_url = "https://search.lauterer.it";
      port = 8888;
      bind_address = "127.0.0.1";
      secret_key = config.sops.secrets.searx.path;
      limiter = true;
      public_instance = false;
      image_proxy = true;
      method = "GET";
    };

    # Search engines
    engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
      "duckduckgo".disabled = false;
      "brave".disabled = true;
      "bing".disabled = false;
      "mojeek".disabled = true;
      "mwmbl".disabled = false;
      "mwmbl".weight = 0.4;
      "qwant".disabled = true;
      "crowdview".disabled = false;
      "crowdview".weight = 0.5;
      "curlie".disabled = true;
      "ddg definitions".disabled = false;
      "ddg definitions".weight = 2;
      "wikibooks".disabled = false;
      "wikidata".disabled = false;
      "wikiquote".disabled = true;
      "wikisource".disabled = true;
      "wikispecies".disabled = false;
      "wikispecies".weight = 0.5;
      "wikiversity".disabled = false;
      "wikiversity".weight = 0.5;
      "wikivoyage".disabled = false;
      "wikivoyage".weight = 0.5;
      "currency".disabled = true;
      "dictzone".disabled = true;
      "lingva".disabled = true;
      "bing images".disabled = false;
      "brave.images".disabled = true;
      "duckduckgo images".disabled = false;
      "google images".disabled = false;
      "qwant images".disabled = true;
      "1x".disabled = true;
      "artic".disabled = false;
      "deviantart".disabled = true;
      "flickr".disabled = true;
      "imgur".disabled = false;
      "library of congress".disabled = false;
      "material icons".disabled = true;
      "material icons".weight = 0.2;
      "openverse".disabled = false;
      "pinterest".disabled = true;
      "svgrepo".disabled = false;
      "unsplash".disabled = false;
      "wallhaven".disabled = false;
      "wikicommons.images".disabled = false;
      "yacy images".disabled = true;
      "bing videos".disabled = true;
      "brave.videos".disabled = true;
      "duckduckgo videos".disabled = false;
      "google videos".disabled = false;
      "qwant videos".disabled = false;
      "dailymotion".disabled = true;
      "google play movies".disabled = true;
      "invidious".disabled = false;
      "odysee".disabled = true;
      "peertube".disabled = false;
      "piped".disabled = true;
      "rumble".disabled = false;
      "sepiasearch".disabled = false;
      "vimeo".disabled = true;
      "youtube".disabled = true;
      "brave.news".disabled = true;
      "google news".disabled = true;
    };

    # Outgoing requests
    outgoing = {
      request_timeout = 5.0;
      max_request_timeout = 15.0;
      pool_connections = 100;
      pool_maxsize = 15;
      enable_http2 = true;
    };

    # Enabled plugins
    enabled_plugins = [
      "Basic Calculator"
      "Hash plugin"
      "Hostnames plugin"
      "Self Information"
      "Tor check plugin"
      "Open Access DOI rewrite"
      "Hostnames plugin"
      "Unit converter plugin"
      "Tracker URL remover"
    ];
  };
};

# Systemd configuration
#systemd.services.nginx.serviceConfig.ProtectHome = false;

# User management
users.groups.searx.members = ["nginx"];


 }
