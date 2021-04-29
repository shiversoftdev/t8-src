// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_435c51ae43d7d9c7;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_78dfd964;

/*
	Name: main
	Namespace: namespace_78dfd964
	Checksum: 0x285E26CA
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
			namespace_cde8b7d2::main();
			break;
		}
	}
}

