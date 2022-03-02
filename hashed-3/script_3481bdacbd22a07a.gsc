// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_71e26f08f03b7a7a;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_18a42c03;

/*
	Name: function_89f2df9
	Namespace: namespace_18a42c03
	Checksum: 0x5E0B52A6
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_739ff925eb6257e2", &__init__, undefined, #"hash_5ff3d0a390e9775f");
}

/*
	Name: __init__
	Namespace: namespace_18a42c03
	Checksum: 0x1B2B97F0
	Offset: 0x110
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_77a2176db1d8a05c", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_18a42c03
	Checksum: 0xCBB8E06B
	Offset: 0x150
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::function_1475a073(&function_4927535c);
		character_unlock::function_d2294476(#"hash_2b1b5e3a3cc284a7", 3, 4);
	}
}

/*
	Name: function_4927535c
	Namespace: namespace_18a42c03
	Checksum: 0x2F486AD2
	Offset: 0x1B8
	Size: 0xFC
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
		if(self.laststandparams.smeansofdeath != "MOD_MELEE" && self.laststandparams.smeansofdeath != "MOD_MELEE_WEAPON_BUTT")
		{
			return;
		}
		if(!attacker util::isenemyteam(self.team))
		{
			return;
		}
		if(!attacker character_unlock::function_f0406288(#"hash_77a2176db1d8a05c"))
		{
			return;
		}
		attacker character_unlock::function_c8beca5e(#"hash_77a2176db1d8a05c", #"hash_21c5510d64c20b71", 1);
	}
}

