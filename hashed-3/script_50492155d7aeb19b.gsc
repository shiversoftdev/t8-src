// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using script_6e3c826b1814cab6;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_e87f6502;

/*
	Name: function_89f2df9
	Namespace: namespace_e87f6502
	Checksum: 0xEDAC1FC7
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_32c6ae5e840ecca3", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e87f6502
	Checksum: 0x73E40380
	Offset: 0x118
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_63788b93aa1642c1", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_e87f6502
	Checksum: 0x17B3512C
	Offset: 0x180
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1de6a85()
{
	level.var_b31000be = 600;
	foreach(e_player in getplayers())
	{
		e_player thread function_8bb2443b();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_e87f6502
	Checksum: 0x5A12A664
	Offset: 0x218
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	level.var_b31000be = undefined;
}

/*
	Name: function_8bb2443b
	Namespace: namespace_e87f6502
	Checksum: 0xC2AA5406
	Offset: 0x238
	Size: 0x9E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8bb2443b()
{
	level endon(#"hash_7646638df88a3656");
	self endon(#"death");
	while(true)
	{
		if(self clientfield::get_to_player("nova_crawler_gas_cloud_postfx_clientfield"))
		{
			self namespace_59ff1d6c::function_db030433();
			self zm_score::player_reduce_points("take_specified", level.var_b31000be);
		}
		wait(1);
	}
}

