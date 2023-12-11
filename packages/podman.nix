{
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
		dockerSocket.enable = true ;
		autoPrune.flags = ["--all"];
		autoPrune.enable = true;
	

	};
}
