// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_44b75d7fe4cd9245;
#using scripts\core_common\util_shared.csc;

#namespace namespace_5eaa8b14;

/*
	Name: main
	Namespace: namespace_5eaa8b14
	Checksum: 0xD29ABD81
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

