// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_e9fabe71;

/*
	Name: function_89f2df9
	Namespace: namespace_e9fabe71
	Checksum: 0xC547B4FD
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4a37af0ab2b66e1c", &__init__, undefined, #"hash_3ae75105991ff4c1");
}

/*
	Name: __init__
	Namespace: namespace_e9fabe71
	Checksum: 0xABA5C5BC
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_708b8753a922b9a8", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_e9fabe71
	Checksum: 0xF1679921
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
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 3);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_e9fabe71
	Checksum: 0xB3FDFEF1
	Offset: 0x220
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	params = self.var_a1d415ee;
	if(!isdefined(params))
	{
		if(!isdefined(self.laststandparams) || (isdefined(self.laststandparams.bledout) && self.laststandparams.bledout))
		{
			return;
		}
		params = self.laststandparams;
	}
	attacker = params.attacker;
	weapon = params.sweapon;
	if(!isdefined(params.attacker))
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(weapon.name != #"melee_bowie" && weapon.name != #"hash_3c94920deb0cbd90")
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_708b8753a922b9a8"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"hash_708b8753a922b9a8", #"hash_374df23cda9c79ed", 1);
}

