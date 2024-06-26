{ pkgs, lib, ... }:
{
    home.packages = with pkgs; [
    	wofi
    	wofi-emoji
    	bemoji
    ];

  programs.wofi = {
        enable = true;
        settings = {
            location = "center";
            allow_markup = true;
            width = "80%";
          };
       ## let stylix handle this.
       # style = ''
       #           * {
       #               font-family: monospace;
       #           }

       #           window {
       #               margin: 0px;
       #               border: 1px solid #c0c0c0;
       #               background-color: #282a36;
       #               border-radius: 10%;
       #           }
       #           
       #           #input {
       #               margin: 2 px;
       #               border: none;
       #               color: #222222;
       #               background-color: #eeeeee;
       #           }
       #           
       #           #inner-box {
       #               margin: 2px;
       #               border: none;
       #               background-color: #282a36;
       #           }
       #           
       #           #outer-box {
       #               margin: 2px;
       #               border: none;
       #               background-color: #282a36;
       #           }
       #           
       #           #scroll {
       #               margin: 0px;
       #               border: none;
       #           }
       #           
       #           #text {
       #               margin: 2px;
       #               border: none;
       #               color: #f8f8f2;
       #           }
       #           
       #           #entry:selected {
       #               background-color: #44475a;
       #           }
       #           #entry {
       #               border-bottom-style: solid;
       #               border-width: 1px;
       #               border-color: #d4af37;
       #           }
       #     '';
    };

   
}

