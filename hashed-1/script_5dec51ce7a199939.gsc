// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_5c38b278c9ab58fc;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_bbbf9329;

/*
	Name: function_89f2df9
	Namespace: namespace_bbbf9329
	Checksum: 0x6D974134
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_27d3acc14df5c31", &__init__, undefined, #"hash_2bd6bd7ba1f2b5d8");
}

/*
	Name: __init__
	Namespace: namespace_bbbf9329
	Checksum: 0xCC779B6D
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_3a3698e1b47c7a79", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_bbbf9329
	Checksum: 0x4D567EE5
	Offset: 0x130
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
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245c711188dcff", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d245c711188dcff", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_bbbf9329
	Checksum: 0x848E638A
	Offset: 0x228
	Size: 0x224
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
	if(!isplayer(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_3a3698e1b47c7a79"))
	{
		return;
	}
	if(!isdefined(attacker.var_8edd57b6))
	{
		attacker.var_8edd57b6 = 0;
	}
	if(weapon.name === #"eq_molotov" || weapon.name === #"hash_23dd6039fe2f36c6" || weapon.name === #"hash_55a4aa4a1077e2cc" || weapon.name === #"hash_c78156ba6aeda14" || weapon.name === #"hero_flamethrower")
	{
		attacker.var_8edd57b6++;
	}
	if(attacker.var_8edd57b6 == 1)
	{
		attacker character_unlock::function_c8beca5e(#"hash_3a3698e1b47c7a79", #"hash_48b3b84fe88578f2", 1);
	}
}

