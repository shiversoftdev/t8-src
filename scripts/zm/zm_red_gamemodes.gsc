// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_red_zstandard.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace zm_red_gamemodes;

/*
	Name: main
	Namespace: zm_red_gamemodes
	Checksum: 0x85C3B57D
	Offset: 0x78
	Size: 0xE2
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	if(!isdefined(level.flag) || (!(isdefined(level.flag[#"load_main_complete"]) && level.flag[#"load_main_complete"])))
	{
		level waittill(#"load_main_complete");
	}
	gametype = hash(util::get_game_type());
	switch(gametype)
	{
		case "zstandard":
		{
			zm_red_zstandard::main();
			break;
		}
	}
}

