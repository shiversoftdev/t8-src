// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_perk_mod_quick_revive;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x45087633
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x25AE13BD
	Offset: 0x100
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_quick_revive_perk_for_level();
}

/*
	Name: enable_quick_revive_perk_for_level
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x86245DC3
	Offset: 0x120
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_quickrevive", "mod_revive", #"perk_quick_revive", #"specialty_quickrevive", 2500);
	zm_perks::register_perk_threads(#"specialty_mod_quickrevive", &give_perk, &take_perk);
	callback::on_revived(&on_revived);
}

/*
	Name: give_perk
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x2CB2CA71
	Offset: 0x1E0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	self thread monitor_health_regen();
}

/*
	Name: take_perk
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x7C91D7E6
	Offset: 0x208
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_478eed143ecc82fc");
	if(self hasperk(#"specialty_sprintspeed"))
	{
		self perks::perk_unsetperk(#"specialty_sprintspeed");
	}
}

/*
	Name: on_revived
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0x5DEAA7F9
	Offset: 0x288
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function on_revived(s_params)
{
	if(isplayer(s_params.e_reviver) && s_params.e_reviver hasperk(#"specialty_mod_quickrevive"))
	{
		s_params.e_reviver zm_utility::set_max_health();
		s_params.e_reviver thread function_118be9d8();
	}
	else
	{
		return;
	}
	if(isplayer(s_params.e_revivee))
	{
		s_params.e_revivee thread function_118be9d8();
	}
}

/*
	Name: monitor_health_regen
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0xC5E1739F
	Offset: 0x358
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function monitor_health_regen()
{
	self endon(#"hash_478eed143ecc82fc", #"disconnect");
	while(true)
	{
		self waittill(#"snd_breathing_better");
		if(!(isdefined(self.heal.enabled) && self.heal.enabled))
		{
			continue;
		}
		self thread function_118be9d8();
		wait(3);
	}
}

/*
	Name: function_118be9d8
	Namespace: zm_perk_mod_quick_revive
	Checksum: 0xC59CAE18
	Offset: 0x3F0
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_118be9d8()
{
	self notify("16d61e93859b61b7");
	self endon("16d61e93859b61b7");
	self endon(#"hash_478eed143ecc82fc", #"disconnect");
	if(!self hasperk(#"specialty_sprintspeed"))
	{
		self perks::perk_setperk(#"specialty_sprintspeed");
	}
	wait(3);
	if(self hasperk(#"specialty_sprintspeed"))
	{
		self perks::perk_unsetperk(#"specialty_sprintspeed");
	}
}

