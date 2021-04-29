// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_696e327e00824120;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_b623f8ef;

/*
	Name: main
	Namespace: namespace_b623f8ef
	Checksum: 0xA4EA617E
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
			namespace_6569a107::main();
			break;
		}
	}
}

