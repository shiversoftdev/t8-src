// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_nomad;

/*
	Name: __init__system__
	Namespace: character_unlock_nomad
	Checksum: 0x902ED361
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_nomad", &__init__, undefined, #"character_unlock_nomad_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_nomad
	Checksum: 0xFF53D15E
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"nomad_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_nomad
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
			item_world_fixup::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245b711188db4c", 1);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"hash_d245b711188db4c", 6);
		}
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_nomad
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
	if(!attacker character_unlock::function_f0406288(#"nomad_unlock"))
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
		attacker character_unlock::function_c8beca5e(#"nomad_unlock", #"hash_7eb32c4c67ae13fe", 1);
	}
}

