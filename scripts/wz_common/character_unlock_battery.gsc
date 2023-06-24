// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using script_71e26f08f03b7a7a;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace character_unlock_battery;

/*
	Name: __init__system__
	Namespace: character_unlock_battery
	Checksum: 0x5CC671CE
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_battery", &__init__, undefined, #"character_unlock_battery_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_battery
	Checksum: 0xBFE0A00D
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"battery_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_battery
	Checksum: 0x3D7107D8
	Offset: 0x130
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		character_unlock::function_d2294476(#"hash_7f75d13d0c20331e", 2, 3);
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_battery
	Checksum: 0x5FE3311E
	Offset: 0x198
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	function_b00fd65d();
	if(!isdefined(self.laststandparams))
	{
		return;
	}
	attacker = self.laststandparams.attacker;
	weapon = self.laststandparams.sweapon;
	if(!isplayer(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(weapon.name != #"hero_pineapple_grenade" && weapon.name != #"hero_pineapplegun")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"battery_unlock"))
	{
		return;
	}
	if(!isdefined(attacker.var_28411f6f))
	{
		attacker.var_28411f6f = 0;
	}
	attacker.var_28411f6f++;
	if(attacker.var_28411f6f == 2)
	{
		attacker character_unlock::function_c8beca5e(#"battery_unlock", #"hash_c5713430b8fb888", 1);
	}
}

/*
	Name: function_b00fd65d
	Namespace: character_unlock_battery
	Checksum: 0xD9DBD88F
	Offset: 0x328
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b00fd65d()
{
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 4);
	var_49170438 = globallogic::totalalivecount();
	if(var_49170438 < maxteamplayers + 2)
	{
		namespace_3d2704b3::function_d0178153(#"hash_7f75d13d0c20331e");
	}
}

