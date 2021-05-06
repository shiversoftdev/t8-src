// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_dcce0aab;

/*
	Name: function_89f2df9
	Namespace: namespace_dcce0aab
	Checksum: 0xB0F59B9F
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6c4d4b6a61988dc4", &__init__, undefined, #"hash_32b19c501f6cd5f9");
}

/*
	Name: __init__
	Namespace: namespace_dcce0aab
	Checksum: 0x6356142D
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_7c61b9fd505b42dc", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_dcce0aab
	Checksum: 0x65DB0B3A
	Offset: 0x130
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_dcce0aab
	Checksum: 0xC57B9FF0
	Offset: 0x170
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!isdefined(self.laststandparams))
	{
		return;
	}
	attacker = self.laststandparams.attacker;
	inflictor = self.laststandparams.einflictor;
	mod = self.laststandparams.smeansofdeath;
	if(!isplayer(attacker) || !isvehicle(inflictor) || mod !== "MOD_CRUSH")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_7c61b9fd505b42dc"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"hash_7c61b9fd505b42dc", #"hash_698918780b4406f1", 1);
}

