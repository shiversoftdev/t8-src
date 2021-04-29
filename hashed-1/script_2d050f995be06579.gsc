// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;

#namespace radar_sweeps;

/*
	Name: function_ce66ebf2
	Namespace: radar_sweeps
	Checksum: 0xCCCA18F
	Offset: 0x98
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_ce66ebf2()
{
	level endon(#"game_ended");
	if(!sessionmodeismultiplayergame())
	{
		return;
	}
	level.var_f0eb9bca = getgametypesetting(#"hash_6aba2f652c6f4e07");
	level.var_fdd4b16 = getgametypesetting(#"hash_926bf70c5a0d23b");
	while(game.state !== "playing")
	{
		wait(1);
	}
	if(level.var_f0eb9bca)
	{
		while(!level.var_fdd4b16 || float(globallogic_utils::gettimeremaining()) / 1000 > level.var_e4cfa0c3)
		{
			wait(level.var_f0eb9bca);
			var_bc40925b = level.var_f0eb9bca > 10;
			thread doradarsweep(var_bc40925b);
		}
	}
	else if(level.var_fdd4b16)
	{
		while(float(globallogic_utils::gettimeremaining()) / 1000 > level.var_e4cfa0c3)
		{
			wait(1);
		}
	}
	if(level.var_fdd4b16)
	{
		while(game.state == "playing")
		{
			wait(level.var_fdd4b16);
			var_bc40925b = level.var_fdd4b16 > 10;
			thread doradarsweep();
		}
	}
}

/*
	Name: doradarsweep
	Namespace: radar_sweeps
	Checksum: 0xE5B2AF34
	Offset: 0x2B8
	Size: 0x280
	Parameters: 1
	Flags: Linked, Private
*/
private function doradarsweep(var_bc40925b)
{
	if(isdefined(var_bc40925b) && globallogic_utils::gettimeremaining() > 10)
	{
		thread globallogic_audio::leader_dialog("bountyUAVSweep");
	}
	if(level.teambased)
	{
		setteamspyplane(#"allies", 1);
		setteamspyplane(#"axis", 1);
		wait(5);
		setteamspyplane(#"allies", 0);
		setteamspyplane(#"axis", 0);
	}
	else
	{
		foreach(player in level.players)
		{
			player.pers[#"hasradar"] = 1;
			player.hasspyplane = 1;
			level.activeuavs[player getentitynumber()] = 1;
		}
		level notify(#"uav_update");
		wait(5);
		foreach(player in level.players)
		{
			player.pers[#"hasradar"] = 0;
			player.hasspyplane = 0;
			level.activeuavs[player getentitynumber()] = 0;
		}
		level notify(#"uav_update");
	}
}

