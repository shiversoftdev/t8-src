// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\character_unlock_firebreak_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_firebreak;

/*
	Name: __init__system__
	Namespace: character_unlock_firebreak
	Checksum: 0x6D974134
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_firebreak", &__init__, undefined, #"character_unlock_firebreak_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_firebreak
	Checksum: 0xCC779B6D
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"firebreak_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_firebreak
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
			item_world_fixup::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245c711188dcff", 1);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"hash_d245c711188dcff", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_firebreak
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
	if(!attacker character_unlock::function_f0406288(#"firebreak_unlock"))
	{
		return;
	}
	if(!isdefined(attacker.var_8edd57b6))
	{
		attacker.var_8edd57b6 = 0;
	}
	if(weapon.name === #"eq_molotov" || weapon.name === #"molotov_fire" || weapon.name === #"wraith_fire_fire" || weapon.name === #"eq_wraith_fire" || weapon.name === #"hero_flamethrower")
	{
		attacker.var_8edd57b6++;
	}
	if(attacker.var_8edd57b6 == 1)
	{
		attacker character_unlock::function_c8beca5e(#"firebreak_unlock", #"hash_48b3b84fe88578f2", 1);
	}
}

