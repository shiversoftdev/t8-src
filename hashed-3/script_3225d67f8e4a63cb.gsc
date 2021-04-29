// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_519b18b4;

/*
	Name: function_89f2df9
	Namespace: namespace_519b18b4
	Checksum: 0xCE56FDED
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_930401a52c2f14b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_519b18b4
	Checksum: 0x5E748E1
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
	namespace_f551babc::register_challenge(#"hash_7bf2e6c8a4d3be84", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_519b18b4
	Checksum: 0xD7998FEC
	Offset: 0x140
	Size: 0x1D0
	Parameters: 4
	Flags: Linked, Private
*/
private function function_d1de6a85(var_b7088c5b, var_5bf91a8, var_d9f1b8f9, var_fc678144)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_795dfe46 = namespace_f551babc::function_5769f26a(var_b7088c5b);
			break;
		}
		case 2:
		{
			level.var_795dfe46 = namespace_f551babc::function_5769f26a(var_5bf91a8);
			break;
		}
		case 3:
		{
			level.var_795dfe46 = namespace_f551babc::function_5769f26a(var_d9f1b8f9);
			break;
		}
		case 4:
		{
			level.var_795dfe46 = namespace_f551babc::function_5769f26a(var_fc678144);
			break;
		}
	}
	foreach(player in getplayers())
	{
		player.var_795dfe46 = 0;
		player namespace_b22c99a5::function_c2cd0cba(level.var_795dfe46);
		player namespace_b22c99a5::function_2190356a(player.var_795dfe46);
		player thread function_729edb5f();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_519b18b4
	Checksum: 0x89A6D9E1
	Offset: 0x318
	Size: 0x1A2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(player.var_795dfe46 < level.var_795dfe46)
			{
				if(!isdefined(var_696c3b4))
				{
					var_696c3b4 = [];
				}
				else if(!isarray(var_696c3b4))
				{
					var_696c3b4 = array(var_696c3b4);
				}
				var_696c3b4[var_696c3b4.size] = player;
			}
		}
		if(var_696c3b4.size)
		{
			namespace_f551babc::fail(#"hash_5a354b422e429f71", var_696c3b4);
		}
	}
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
	level.var_795dfe46 = undefined;
}

/*
	Name: function_729edb5f
	Namespace: namespace_519b18b4
	Checksum: 0xD593E8C9
	Offset: 0x4C8
	Size: 0xD0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_729edb5f()
{
	level endon(#"hash_7646638df88a3656");
	while(self.var_795dfe46 < level.var_795dfe46)
	{
		self waittill(#"hash_15541419dbbe7e1a");
		self.var_795dfe46++;
		if(self.var_795dfe46 < level.var_795dfe46)
		{
			self namespace_b22c99a5::function_c2cd0cba(level.var_795dfe46);
			self namespace_b22c99a5::function_2190356a(self.var_795dfe46);
		}
		if(self.var_795dfe46 == level.var_795dfe46)
		{
			self namespace_b22c99a5::function_63060af4(1);
		}
	}
}

