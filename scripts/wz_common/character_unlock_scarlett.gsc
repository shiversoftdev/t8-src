// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_scarlett;

/*
	Name: __init__system__
	Namespace: character_unlock_scarlett
	Checksum: 0xB0F59B9F
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_scarlett", &__init__, undefined, #"character_unlock_scarlett_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_scarlett
	Checksum: 0x6356142D
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"scarlett_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_scarlett
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
	Namespace: character_unlock_scarlett
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
	if(!attacker character_unlock::function_f0406288(#"scarlett_unlock"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"scarlett_unlock", #"hash_698918780b4406f1", 1);
}

