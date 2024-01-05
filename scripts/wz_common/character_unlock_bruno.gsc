// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using script_71e26f08f03b7a7a;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_bruno;

/*
	Name: __init__system__
	Namespace: character_unlock_bruno
	Checksum: 0x5E0B52A6
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_bruno", &__init__, undefined, #"character_unlock_bruno_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_bruno
	Checksum: 0x1B2B97F0
	Offset: 0x110
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"bruno_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_bruno
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
		callback::on_downed(&on_player_downed);
		character_unlock::function_d2294476(#"hash_2b1b5e3a3cc284a7", 3, 4);
	}
}

/*
	Name: on_player_downed
	Namespace: character_unlock_bruno
	Checksum: 0x2F486AD2
	Offset: 0x1B8
	Size: 0xFC
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
		if(self.laststandparams.smeansofdeath != "MOD_MELEE" && self.laststandparams.smeansofdeath != "MOD_MELEE_WEAPON_BUTT")
		{
			return;
		}
		if(!attacker util::isenemyteam(self.team))
		{
			return;
		}
		if(!attacker character_unlock::function_f0406288(#"bruno_unlock"))
		{
			return;
		}
		attacker character_unlock::function_c8beca5e(#"bruno_unlock", #"hash_21c5510d64c20b71", 1);
	}
}

