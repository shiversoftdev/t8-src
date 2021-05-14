// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_e03931f;

/*
	Name: function_89f2df9
	Namespace: namespace_e03931f
	Checksum: 0x45087633
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_120f55104b05e7c6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e03931f
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
	Namespace: namespace_e03931f
	Checksum: 0x86245DC3
	Offset: 0x120
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	zm_perks::function_7f42e14e(#"hash_a6796d796a8d2b9", "mod_revive", #"perk_quick_revive", #"specialty_quickrevive", 2500);
	zm_perks::register_perk_threads(#"hash_a6796d796a8d2b9", &give_perk, &take_perk);
	callback::on_revived(&on_revived);
}

/*
	Name: give_perk
	Namespace: namespace_e03931f
	Checksum: 0x2CB2CA71
	Offset: 0x1E0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	self thread function_733c712e();
}

/*
	Name: take_perk
	Namespace: namespace_e03931f
	Checksum: 0x7C91D7E6
	Offset: 0x208
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_478eed143ecc82fc");
	if(self hasperk(#"hash_650a97787905913f"))
	{
		self perks::function_45d12554(#"hash_650a97787905913f");
	}
}

/*
	Name: on_revived
	Namespace: namespace_e03931f
	Checksum: 0x5DEAA7F9
	Offset: 0x288
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function on_revived(s_params)
{
	if(isplayer(s_params.e_reviver) && s_params.e_reviver hasperk(#"hash_a6796d796a8d2b9"))
	{
		s_params.e_reviver zm_utility::function_e0448fec();
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
	Name: function_733c712e
	Namespace: namespace_e03931f
	Checksum: 0xC5E1739F
	Offset: 0x358
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_733c712e()
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
	Namespace: namespace_e03931f
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
	if(!self hasperk(#"hash_650a97787905913f"))
	{
		self perks::function_7637bafa(#"hash_650a97787905913f");
	}
	wait(3);
	if(self hasperk(#"hash_650a97787905913f"))
	{
		self perks::function_45d12554(#"hash_650a97787905913f");
	}
}

