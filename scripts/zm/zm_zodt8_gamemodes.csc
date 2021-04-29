// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5cc4813bae17d230;
#using scripts\core_common\util_shared.csc;

#namespace namespace_7dc0077c;

/*
	Name: main
	Namespace: namespace_7dc0077c
	Checksum: 0x28D9ECB6
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
	gametype = hash(util::function_5df4294());
	switch(gametype)
	{
		case "zstandard":
		{
			namespace_a4c489e7::main();
			break;
		}
	}
}

