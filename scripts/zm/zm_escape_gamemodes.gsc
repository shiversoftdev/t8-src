// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2979d67aff5a4c4a;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_ca530363;

/*
	Name: main
	Namespace: namespace_ca530363
	Checksum: 0x34FBC09D
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
			namespace_abf5a219::main();
			break;
		}
	}
}

