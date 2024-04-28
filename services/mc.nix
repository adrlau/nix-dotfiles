{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.ollama
  ];

  services.minecraft-server = {
	enable = true;
	eula = true;
        #jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";

		
#	serverProperties = {
#		  server-port = 25500;
# 		  difficulty = 3;
# 		  gamemode = 1;
# 		  max-players = 8;
# 		  motd = "Adrian Minecraft server!";
#		};
	openFirewall = true;	

	};
}
