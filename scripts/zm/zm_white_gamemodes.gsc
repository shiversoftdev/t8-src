// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_152668a12c94fe8;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_460fc6f7;

/*
	Name: main
	Namespace: namespace_460fc6f7
	Checksum: 0xC94CEE9
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
			namespace_2eb2d493::main();
			break;
		}
	}
}

