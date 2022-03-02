// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\draft.gsc;

#namespace namespace_1261609;

/*
	Name: function_89f2df9
	Namespace: namespace_1261609
	Checksum: 0xC9F02658
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_33946b9507c6ec22", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1261609
	Checksum: 0x60A82057
	Offset: 0x118
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::function_98a0917d(&function_98a0917d);
}

/*
	Name: __main__
	Namespace: namespace_1261609
	Checksum: 0xDEC49F0A
	Offset: 0x148
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	/#
		function_2085db3b();
	#/
	function_2cdcf5c3();
}

/*
	Name: function_98a0917d
	Namespace: namespace_1261609
	Checksum: 0x5D89E816
	Offset: 0x180
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_98a0917d()
{
	array::delete_all(getentarray("sun_block", "targetname"));
	wait(getdvarfloat(#"hash_68cf1e8e429452b0", 0));
	if(util::isfirstround())
	{
		level thread scene::play(#"p8_fxanim_mp_fir_flyover_bundle", "Shot 2");
	}
}

/*
	Name: function_2cdcf5c3
	Namespace: namespace_1261609
	Checksum: 0x25CB11A4
	Offset: 0x220
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_2cdcf5c3()
{
	if(!getdvarint(#"hash_14f8907ba73d8e4f", 1))
	{
		return;
	}
	if(util::isfirstround())
	{
		while(!draft::function_d255fb3e())
		{
			waitframe(1);
		}
		level thread scene::play(#"p8_fxanim_mp_fir_flyover_bundle", "Shot 1");
		return;
	}
	level scene::skipto_end(#"p8_fxanim_mp_fir_flyover_bundle");
}

/*
	Name: function_2085db3b
	Namespace: namespace_1261609
	Checksum: 0x6A46A7AE
	Offset: 0x2E0
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function function_2085db3b()
{
	/#
		mapname = util::function_53bbf9d2();
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
	#/
}

