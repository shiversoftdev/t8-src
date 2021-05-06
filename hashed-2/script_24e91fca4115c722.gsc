// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_39de7799;

/*
	Name: function_89f2df9
	Namespace: namespace_39de7799
	Checksum: 0xA3BF6DEE
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5af9657aa38244e6", &__init__, undefined, #"hash_323f3675919752ab");
}

/*
	Name: __init__
	Namespace: namespace_39de7799
	Checksum: 0x4EA59DA7
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_4dcc9053e0685c94", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_39de7799
	Checksum: 0x347D33CB
	Offset: 0x130
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::function_1475a073(&function_4927535c);
	}
}

/*
	Name: function_4927535c
	Namespace: namespace_39de7799
	Checksum: 0xB886EEEF
	Offset: 0x170
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_4927535c()
{
	if(isdefined(self.laststandparams))
	{
		attacker = self.laststandparams.attacker;
		if(!isplayer(attacker))
		{
			return;
		}
		if(self.laststandparams.smeansofdeath != "MOD_HEAD_SHOT")
		{
			return;
		}
		if(!attacker util::isenemyteam(self.team))
		{
			return;
		}
		if(!attacker character_unlock::function_f0406288(#"hash_4dcc9053e0685c94"))
		{
			return;
		}
		if(!isdefined(attacker.var_7128013a))
		{
			attacker.var_7128013a = 0;
		}
		attacker.var_7128013a++;
		if(attacker.var_7128013a == 1)
		{
			attacker character_unlock::function_c8beca5e(#"hash_4dcc9053e0685c94", #"hash_7d0b41a17f2e9a9", 1);
		}
	}
}

