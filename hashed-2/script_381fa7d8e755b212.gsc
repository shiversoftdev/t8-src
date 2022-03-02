// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_71e26f08f03b7a7a;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_56dcd5e;

/*
	Name: function_89f2df9
	Namespace: namespace_56dcd5e
	Checksum: 0xF929C0B9
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4d20bdb63281c38", &__init__, undefined, #"hash_1906a0df69010a5");
}

/*
	Name: __init__
	Namespace: namespace_56dcd5e
	Checksum: 0x711E648A
	Offset: 0x100
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_36698e3567c4b204", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_56dcd5e
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
	Namespace: namespace_56dcd5e
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
	if(!attacker character_unlock::function_f0406288(#"hash_36698e3567c4b204"))
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
			attacker character_unlock::function_c8beca5e(#"hash_36698e3567c4b204", #"hash_4bc3134998048aa7", 1);
		}
	}
}

/*
	Name: function_15d026c0
	Namespace: namespace_56dcd5e
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
	Namespace: namespace_56dcd5e
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

