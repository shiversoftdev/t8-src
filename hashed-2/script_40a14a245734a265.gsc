// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_7aa9aa73;

/*
	Name: function_89f2df9
	Namespace: namespace_7aa9aa73
	Checksum: 0x902ED361
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_29d607517753436d", &__init__, undefined, #"hash_2b729a318b495ddc");
}

/*
	Name: __init__
	Namespace: namespace_7aa9aa73
	Checksum: 0xFF53D15E
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_14743213b896d2e5", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_7aa9aa73
	Checksum: 0xC65B91A5
	Offset: 0x128
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245b711188db4c", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d245b711188db4c", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_7aa9aa73
	Checksum: 0xE26751BC
	Offset: 0x220
	Size: 0x144
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
	if(!isplayer(attacker))
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_14743213b896d2e5"))
	{
		return;
	}
	if(!isdefined(attacker.var_520e7d03))
	{
		attacker.var_520e7d03 = 0;
	}
	if(!isdefined(attacker.var_9854aa3a) || !isinarray(attacker.var_9854aa3a, self))
	{
		attacker.var_520e7d03++;
	}
	if(attacker.var_520e7d03 >= 2)
	{
		attacker character_unlock::function_c8beca5e(#"hash_14743213b896d2e5", #"hash_7eb32c4c67ae13fe", 1);
	}
}

