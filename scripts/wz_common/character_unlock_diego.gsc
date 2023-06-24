// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace character_unlock_diego;

/*
	Name: __init__system__
	Namespace: character_unlock_diego
	Checksum: 0xA3BF6DEE
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_diego", &__init__, undefined, #"character_unlock_diego_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_diego
	Checksum: 0x4EA59DA7
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"diego_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_diego
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
		callback::on_downed(&on_player_downed);
	}
}

/*
	Name: on_player_downed
	Namespace: character_unlock_diego
	Checksum: 0xB886EEEF
	Offset: 0x170
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function on_player_downed()
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
		if(!attacker character_unlock::function_f0406288(#"diego_unlock"))
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
			attacker character_unlock::function_c8beca5e(#"diego_unlock", #"hash_7d0b41a17f2e9a9", 1);
		}
	}
}

