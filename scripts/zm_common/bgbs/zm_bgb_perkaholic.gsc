// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_randomize_perks.gsc;
#using scripts\zm_common\trials\zm_trial_disable_perks.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_bgb_perkaholic;

/*
	Name: __init__system__
	Namespace: zm_bgb_perkaholic
	Checksum: 0x26551737
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_perkaholic", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_perkaholic
	Checksum: 0x9B801D19
	Offset: 0x100
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_perkaholic", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: validation
	Namespace: zm_bgb_perkaholic
	Checksum: 0x810439BA
	Offset: 0x180
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(self.var_1eba264f) && self.var_1eba264f)
	{
		return false;
	}
	if(zm_trial_disable_perks::is_active() || zm_trial_randomize_perks::is_active())
	{
		return false;
	}
	if(self zm_perks::function_80cb4982() && self zm_perks::function_9a0e9d65())
	{
		return false;
	}
	return true;
}

/*
	Name: activation
	Namespace: zm_bgb_perkaholic
	Checksum: 0xDB87CDDB
	Offset: 0x218
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"fake_death", #"death", #"player_downed");
	if(!self laststand::player_is_in_laststand() && self.sessionstate != "spectator")
	{
		self zm_perks::function_cc24f525();
		self thread function_cd55a662();
		for(i = 0; i < 6; i++)
		{
			var_16c042b8 = self zm_perks::function_b2cba45a();
			if(isdefined(var_16c042b8))
			{
				self.var_1eba264f = 1;
				continue;
			}
			return;
		}
	}
}

/*
	Name: function_cd55a662
	Namespace: zm_bgb_perkaholic
	Checksum: 0x5108DA89
	Offset: 0x318
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_cd55a662()
{
	self notify(#"hash_764a30e1b90e56f6");
	self endon(#"hash_764a30e1b90e56f6");
	self waittill(#"fake_death", #"player_downed", #"death");
	if(isdefined(self))
	{
		self.var_1eba264f = undefined;
	}
}

