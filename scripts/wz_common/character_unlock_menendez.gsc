// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using script_71e26f08f03b7a7a;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_menendez;

/*
	Name: __init__system__
	Namespace: character_unlock_menendez
	Checksum: 0xF929C0B9
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_menendez", &__init__, undefined, #"character_unlock_menendez_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_menendez
	Checksum: 0x711E648A
	Offset: 0x100
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"menendez_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_menendez
	Checksum: 0x942365D2
	Offset: 0x140
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		character_unlock::function_d2294476(#"hash_2b254f3a3ccabfaf", 2, 3);
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_menendez
	Checksum: 0xB7EC4C15
	Offset: 0x1A8
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	function_b00fd65d();
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
	means = params.smeansofdeath;
	if(!isplayer(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"menendez_unlock"))
	{
		return;
	}
	if(weapon.weapclass === "spread")
	{
		if(!isdefined(attacker.var_a028bb76))
		{
			attacker.var_a028bb76 = 0;
		}
		attacker.var_a028bb76++;
		attacker function_15d026c0();
		if(attacker.var_a028bb76 >= 2)
		{
			attacker character_unlock::function_c8beca5e(#"menendez_unlock", #"hash_4bc3134998048aa7", 1);
		}
	}
}

/*
	Name: function_15d026c0
	Namespace: character_unlock_menendez
	Checksum: 0xE8A2DD15
	Offset: 0x388
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private function_15d026c0()
{
	self playsoundtoplayer(#"hash_3e5c00ae62aa9c91", self);
}

/*
	Name: function_b00fd65d
	Namespace: character_unlock_menendez
	Checksum: 0xE3CBA42C
	Offset: 0x3B8
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
		namespace_3d2704b3::function_d0178153(#"hash_2b254f3a3ccabfaf");
	}
}

