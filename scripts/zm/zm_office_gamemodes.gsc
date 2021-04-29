// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_23c4b17fd29f98d9;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_5eaa8b14;

/*
	Name: main
	Namespace: namespace_5eaa8b14
	Checksum: 0x6CB9F54D
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
			namespace_5203fdd::main();
			break;
		}
	}
}

