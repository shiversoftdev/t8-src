// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using script_698dd790cdc4965f;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;

#namespace namespace_e01afe67;

/*
	Name: __init__system__
	Namespace: namespace_e01afe67
	Checksum: 0xAE7C0C7C
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_993ee8bedbddc19", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e01afe67
	Checksum: 0x53595DCD
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_27897abffa9137fc", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_e01afe67
	Checksum: 0x2AD713FB
	Offset: 0x150
	Size: 0x35C
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	zm::register_actor_damage_callback(&height_check);
	callback::on_ai_spawned(&on_ai_spawned);
	level.var_8c018a0e = 1;
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
	Namespace: namespace_e01afe67
	Checksum: 0x67A2CED
	Offset: 0x4B8
	Size: 0x224
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	callback::remove_on_ai_spawned(&on_ai_spawned);
	level.var_8c018a0e = undefined;
	if(isinarray(level.actor_damage_callbacks, &height_check))
	{
		arrayremovevalue(level.actor_damage_callbacks, &height_check, 0);
	}
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
	Namespace: namespace_e01afe67
	Checksum: 0x113E9CA
	Offset: 0x6E8
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_27897abffa9137fc");
	return isdefined(challenge);
}

/*
	Name: height_check
	Namespace: namespace_e01afe67
	Checksum: 0xC80E936D
	Offset: 0x728
	Size: 0xBA
	Parameters: 12
	Flags: Private
*/
function private height_check(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker.origin) && isdefined(self.origin) && attacker.origin[2] > (self.origin[2] + 40))
	{
		return damage;
	}
	return 0;
}

/*
	Name: on_ai_spawned
	Namespace: namespace_e01afe67
	Checksum: 0xE2E2DFD9
	Offset: 0x7F0
	Size: 0x1E
	Parameters: 0
	Flags: Private
*/
function private on_ai_spawned()
{
	self.ignore_nuke = 1;
	self.no_gib = 1;
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_e01afe67
	Checksum: 0x19EBD0D1
	Offset: 0x818
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
function private function_33f0ddd3(eventstruct)
{
	self function_6a8979c9();
}

/*
	Name: function_6a8979c9
	Namespace: namespace_e01afe67
	Checksum: 0x739397B6
	Offset: 0x848
	Size: 0x1E0
	Parameters: 0
	Flags: Private
*/
function private function_6a8979c9()
{
	/#
		assert(isdefined(level.var_3e2ac3b6));
	#/
	foreach(weapon in self getweaponslist(1))
	{
		if(zm_loadout::is_hero_weapon(weapon) || (isdefined(weapon.isriotshield) && weapon.isriotshield))
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

