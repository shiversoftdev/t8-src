// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_trial_close_quarters;

/*
	Name: __init__system__
	Namespace: zm_trial_close_quarters
	Checksum: 0x7DDF020F
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_close_quarters", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_close_quarters
	Checksum: 0x3AEECAF
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"close_quarters", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_close_quarters
	Checksum: 0x8B7D35CE
	Offset: 0x148
	Size: 0x24
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	zm::register_actor_damage_callback(&range_check);
}

/*
	Name: on_end
	Namespace: zm_trial_close_quarters
	Checksum: 0x2B527A4C
	Offset: 0x178
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	if(isinarray(level.actor_damage_callbacks, &range_check))
	{
		arrayremovevalue(level.actor_damage_callbacks, &range_check, 0);
	}
}

/*
	Name: is_active
	Namespace: zm_trial_close_quarters
	Checksum: 0xEFA99908
	Offset: 0x1E8
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"close_quarters");
	return isdefined(challenge);
}

/*
	Name: range_check
	Namespace: zm_trial_close_quarters
	Checksum: 0xC61B8F08
	Offset: 0x228
	Size: 0x11A
	Parameters: 12
	Flags: Private
*/
function private range_check(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
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
	Namespace: zm_trial_close_quarters
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
		return true;
	}
	return false;
}

