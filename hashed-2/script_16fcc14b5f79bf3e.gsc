// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_52c6c2d1a2ef1b46;
#using script_6021ce59143452c3;
#using script_64ef785dc7ba19d9;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_efec71f7;

/*
	Name: function_89f2df9
	Namespace: namespace_efec71f7
	Checksum: 0xE552E8F9
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3db89e7dfe4633b0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_efec71f7
	Checksum: 0x3E514D2C
	Offset: 0xE0
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
	zm_trial::register_challenge(#"hash_285312733a97eea3", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_efec71f7
	Checksum: 0x9F359C0E
	Offset: 0x148
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 5);
	if(!(isdefined(level.var_4e4909a6) && level.var_4e4909a6))
	{
		level thread function_57755268();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_efec71f7
	Checksum: 0x897829D7
	Offset: 0x1B8
	Size: 0x66
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		if(!(isdefined(level.var_84199d1) && level.var_84199d1))
		{
			zm_trial::fail(undefined, getplayers());
		}
	}
	level.var_84199d1 = undefined;
}

/*
	Name: function_57755268
	Namespace: namespace_efec71f7
	Checksum: 0x8282395F
	Offset: 0x228
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_57755268()
{
	level endon(#"end_game");
	level.var_4e4909a6 = 1;
	namespace_31170709::play_think();
	namespace_31170709::play_cleanup(0, 0);
	level.var_84199d1 = 1;
	level.var_4e4909a6 = undefined;
	level endon(#"hash_7646638df88a3656");
	wait(5);
	level notify(#"kill_round_wait");
}

