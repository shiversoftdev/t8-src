// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_ix_diego;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_diego
	Checksum: 0xC547B4FD
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_diego", &__init__, undefined, #"character_unlock_ix_diego_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_diego
	Checksum: 0xABA5C5BC
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ix_diego_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ix_diego
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
			item_world_fixup::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 3);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_ix_diego
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
	if(weapon.name != #"melee_bowie" && weapon.name != #"melee_bowie_bloody")
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"ix_diego_unlock"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"ix_diego_unlock", #"hash_374df23cda9c79ed", 1);
}

