// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_698dd790cdc4965f;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_fc5170d1;

/*
	Name: __init__system__
	Namespace: namespace_fc5170d1
	Checksum: 0x404C015F
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_388ce832b10c2f83", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fc5170d1
	Checksum: 0x98A06EDF
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_c2ef6223096d3ca", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_fc5170d1
	Checksum: 0x9CA09F20
	Offset: 0x140
	Size: 0x30C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	weapon_names = array(#"hero_chakram_lv1", #"hero_chakram_lv2", #"hero_chakram_lv3", #"hero_chakram_lh_lv1", #"hero_chakram_lh_lv2", #"hero_chakram_lh_lv3", #"hero_hammer_lv1", #"hero_hammer_lv2", #"hero_hammer_lv3", #"hero_katana_t8_lv1", #"hero_katana_t8_lv2", #"hero_katana_t8_lv3", #"hero_scepter_lv1", #"hero_scepter_lv2", #"hero_scepter_lv3", #"hero_sword_pistol_lv1", #"hero_sword_pistol_lv2", #"hero_sword_pistol_lv3", #"hero_sword_pistol_lh_lv1", #"hero_sword_pistol_lh_lv2", #"hero_sword_pistol_lh_lv3");
	level.var_3e2ac3b6 = [];
	foreach(weapon_name in weapon_names)
	{
		weapon = getweapon(weapon_name);
		if(isdefined(weapon) && weapon != level.weaponnone)
		{
			level.var_3e2ac3b6[weapon.name] = weapon;
		}
	}
	foreach(player in getplayers())
	{
		player function_6a8979c9();
		player callback::function_33f0ddd3(&function_33f0ddd3);
		player zm_trial_util::function_9bf8e274();
	}
	level zm_trial::function_44200d07(1);
}

/*
	Name: on_end
	Namespace: namespace_fc5170d1
	Checksum: 0xEE1E6482
	Offset: 0x458
	Size: 0x1A4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::function_824d206(&function_33f0ddd3);
		foreach(weapon in player getweaponslist(1))
		{
			player unlockweapon(weapon);
			if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
			{
				player unlockweapon(weapon.dualwieldweapon);
			}
		}
		player zm_trial_util::function_73ff0096();
	}
	level.var_3e2ac3b6 = undefined;
	level zm_trial::function_44200d07(0);
}

/*
	Name: is_active
	Namespace: namespace_fc5170d1
	Checksum: 0x9984D1F6
	Offset: 0x608
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_c2ef6223096d3ca");
	return isdefined(challenge);
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_fc5170d1
	Checksum: 0x8B7BDB9F
	Offset: 0x648
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(eventstruct)
{
	self function_6a8979c9();
}

/*
	Name: function_6a8979c9
	Namespace: namespace_fc5170d1
	Checksum: 0x70B33242
	Offset: 0x678
	Size: 0x1C0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6a8979c9()
{
	/#
		assert(isdefined(level.var_3e2ac3b6));
	#/
	foreach(weapon in self getweaponslist(1))
	{
		if(isdefined(level.var_3e2ac3b6[weapon.name]))
		{
			self function_28602a03(weapon);
		}
		else if(!namespace_83dc3729::is_active() || !isarray(level.var_af806901) || !isdefined(level.var_af806901[weapon.name]))
		{
			self unlockweapon(weapon);
		}
		if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
		{
			if(self function_635f9c02(weapon))
			{
				self function_28602a03(weapon.dualwieldweapon);
				continue;
			}
			self unlockweapon(weapon.dualwieldweapon);
		}
	}
}

