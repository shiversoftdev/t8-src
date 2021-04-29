// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3a3c430eb58ed475;
#using script_6021ce59143452c3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_8a476bc7;

/*
	Name: function_89f2df9
	Namespace: namespace_8a476bc7
	Checksum: 0x25C71C39
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_48f50c5660fa9f4c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8a476bc7
	Checksum: 0xA7A77724
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_1fd6f58939deba71", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_8a476bc7
	Checksum: 0x80F724D1
	Offset: 0x140
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_8a476bc7
	Checksum: 0xDE4B9AEA
	Offset: 0x150
	Size: 0x144
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		var_acba5af0 = array();
		foreach(e_player in level.players)
		{
			if(!e_player namespace_ebd828b::function_aa0b6eb())
			{
				if(!isdefined(var_acba5af0))
				{
					var_acba5af0 = [];
				}
				else if(!isarray(var_acba5af0))
				{
					var_acba5af0 = array(var_acba5af0);
				}
				if(!isinarray(var_acba5af0, e_player))
				{
					var_acba5af0[var_acba5af0.size] = e_player;
				}
			}
		}
		if(var_acba5af0.size)
		{
			namespace_f551babc::fail(#"hash_746c876308278b16", var_acba5af0);
		}
	}
}

