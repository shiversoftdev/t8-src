// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_reset_points;

/*
	Name: __init__system__
	Namespace: zm_trial_reset_points
	Checksum: 0xDBF50EC
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_reset_points", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_reset_points
	Checksum: 0x6EB8DFC
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
	zm_trial::register_challenge(#"reset_points", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_reset_points
	Checksum: 0x36C5F326
	Offset: 0x148
	Size: 0xC8
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_899c6d17)
{
	if(isdefined(var_899c6d17))
	{
		var_899c6d17 = zm_trial::function_5769f26a(var_899c6d17);
	}
	else
	{
		var_899c6d17 = 0;
	}
	wait(6);
	foreach(player in getplayers())
	{
		player thread reset_points(var_899c6d17);
	}
}

/*
	Name: reset_points
	Namespace: zm_trial_reset_points
	Checksum: 0xB06211FD
	Offset: 0x218
	Size: 0x8E
	Parameters: 1
	Flags: Private
*/
function private reset_points(var_899c6d17)
{
	if(self bgb::is_enabled(#"zm_bgb_shopping_free"))
	{
		self bgb::do_one_shot_use();
		self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
		return;
	}
	self.score = var_899c6d17;
	self.pers[#"score"] = var_899c6d17;
}

/*
	Name: on_end
	Namespace: zm_trial_reset_points
	Checksum: 0x5463264F
	Offset: 0x2B0
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
}

