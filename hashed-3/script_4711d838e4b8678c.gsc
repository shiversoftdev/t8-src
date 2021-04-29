// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_3a56904b;

/*
	Name: function_89f2df9
	Namespace: namespace_3a56904b
	Checksum: 0x7DDF020F
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_14545d2d685e6304", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3a56904b
	Checksum: 0x3AEECAF
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_53d304fe41545371", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_3a56904b
	Checksum: 0x8B7D35CE
	Offset: 0x148
	Size: 0x24
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	zm::register_actor_damage_callback(&function_306332df);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_3a56904b
	Checksum: 0x2B527A4C
	Offset: 0x178
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(isinarray(level.actor_damage_callbacks, &function_306332df))
	{
		arrayremovevalue(level.actor_damage_callbacks, &function_306332df, 0);
	}
}

/*
	Name: is_active
	Namespace: namespace_3a56904b
	Checksum: 0xEFA99908
	Offset: 0x1E8
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_53d304fe41545371");
	return isdefined(challenge);
}

/*
	Name: function_306332df
	Namespace: namespace_3a56904b
	Checksum: 0xC61B8F08
	Offset: 0x228
	Size: 0x11A
	Parameters: 12
	Flags: Private
*/
private function function_306332df(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isplayer(attacker) && !isplayer(inflictor))
	{
		return -1;
	}
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return damage;
	}
	if(isdefined(attacker.origin) && isdefined(self.origin) && distance2dsquared(attacker.origin, self.origin) <= 122500)
	{
		return damage;
	}
	return 0;
}

/*
	Name: function_23d15bf3
	Namespace: namespace_3a56904b
	Checksum: 0x17D280BF
	Offset: 0x350
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_23d15bf3(var_f85889ce)
{
	if(isplayer(var_f85889ce) && distance2dsquared(var_f85889ce.origin, self.origin) <= 122500)
	{
		return 1;
	}
	return 0;
}

