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

#namespace namespace_b57ab804;

/*
	Name: function_89f2df9
	Namespace: namespace_b57ab804
	Checksum: 0xF1BAB6AB
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_21f23b8f17851cd0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b57ab804
	Checksum: 0xA799D0C2
	Offset: 0x120
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_1d5c8e6f0e20201a") || !namespace_59ff1d6c::function_901b751c(#"hash_7bc64c0823c87e41"))
	{
		return;
	}
	zm_talisman::function_88a60d36("talisman_start_weapon_ar", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_b57ab804
	Checksum: 0x83B382C2
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self.var_8313fee5 = #"ar_modular_t8";
}

