// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d0809bc5;

/*
	Name: function_89f2df9
	Namespace: namespace_d0809bc5
	Checksum: 0xB61551C
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3d3a72fc3c1ad212", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d0809bc5
	Checksum: 0x7E04F7C7
	Offset: 0x118
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_perk_start_3", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_d0809bc5
	Checksum: 0x5EAA4E7
	Offset: 0x150
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	if(isdefined(self.var_c27f1e90) && namespace_59ff1d6c::function_d9f0defb(self.var_c27f1e90[2]))
	{
		self.talisman_perk_start_3 = 1;
	}
}

