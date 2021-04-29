// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5660bae5b402a1eb;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_powerup_weapon_minigun;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x8AE7679B
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0xB4DD7F7
	Offset: 0x1A8
	Size: 0x17C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	zm_powerups::register_powerup("minigun", &grab_minigun);
	zm_powerups::register_powerup_weapon("minigun", &minigun_countdown);
	zm_powerups::powerup_set_prevent_pick_up_if_drinking("minigun", 1);
	zm_powerups::set_weapon_ignore_max_ammo("minigun");
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("minigun", "zombie_pickup_minigun", #"hash_59b04447e22b4f0c", &func_should_drop_minigun, 1, 0, 0, undefined, "powerup_mini_gun", "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
		level.zombie_powerup_weapon[#"minigun"] = getweapon(#"minigun");
	}
	callback::on_connect(&init_player_zombie_vars);
	zm::register_actor_damage_callback(&minigun_damage_adjust);
}

/*
	Name: grab_minigun
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x9B3D2A48
	Offset: 0x330
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function grab_minigun(player)
{
	level thread minigun_weapon_powerup(player);
	player thread zm_powerups::powerup_vo("minigun");
	if(isdefined(level._grab_minigun))
	{
		level thread [[level._grab_minigun]](player);
	}
}

/*
	Name: init_player_zombie_vars
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x14709939
	Offset: 0x3A8
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function init_player_zombie_vars()
{
	self.zombie_vars[#"zombie_powerup_minigun_on"] = 0;
	self.zombie_vars[#"zombie_powerup_minigun_time"] = 0;
}

/*
	Name: func_should_drop_minigun
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0xA7886497
	Offset: 0x3E8
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function func_should_drop_minigun()
{
	if(zm_powerups::minigun_no_drop())
	{
		return 0;
	}
	return 1;
}

/*
	Name: minigun_weapon_powerup
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x38325209
	Offset: 0x410
	Size: 0x264
	Parameters: 2
	Flags: None
*/
function minigun_weapon_powerup(ent_player, time)
{
	ent_player endon(#"disconnect", #"death", #"player_downed");
	if(!isdefined(time))
	{
		time = 30;
	}
	if(isdefined(level._minigun_time_override))
	{
		time = level._minigun_time_override;
	}
	if(ent_player.zombie_vars[#"zombie_powerup_minigun_on"] && (level.zombie_powerup_weapon[#"minigun"] == ent_player getcurrentweapon() || (isdefined(ent_player.has_powerup_weapon[#"minigun"]) && ent_player.has_powerup_weapon[#"minigun"])))
	{
		if(ent_player.zombie_vars[#"zombie_powerup_minigun_time"] < time)
		{
			ent_player.zombie_vars[#"zombie_powerup_minigun_time"] = time;
		}
		return;
	}
	level._zombie_minigun_powerup_last_stand_func = &minigun_powerup_last_stand;
	stance_disabled = 0;
	if(ent_player getstance() === "prone")
	{
		ent_player allowcrouch(0);
		ent_player allowprone(0);
		while(ent_player getstance() != "stand")
		{
			waitframe(1);
		}
	}
	zm_powerups::weapon_powerup(ent_player, time, "minigun", 1);
	if(stance_disabled)
	{
		ent_player allowcrouch(1);
		ent_player allowprone(1);
	}
}

/*
	Name: minigun_powerup_last_stand
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0xA0C3D237
	Offset: 0x680
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function minigun_powerup_last_stand()
{
	zm_powerups::weapon_watch_gunner_downed("minigun");
}

/*
	Name: minigun_countdown
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x4D60DA4
	Offset: 0x6A8
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function minigun_countdown(ent_player, str_weapon_time)
{
	while(ent_player.zombie_vars[str_weapon_time] > 0)
	{
		waitframe(1);
		ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] - 0.05;
	}
}

/*
	Name: minigun_weapon_powerup_off
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0xB8B93223
	Offset: 0x710
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function minigun_weapon_powerup_off()
{
	self.zombie_vars[#"zombie_powerup_minigun_time"] = 0;
}

/*
	Name: minigun_damage_adjust
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x17A1377F
	Offset: 0x738
	Size: 0x194
	Parameters: 12
	Flags: None
*/
function minigun_damage_adjust(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(weapon.name != "minigun")
	{
		return -1;
	}
	if(self.archetype == #"zombie" || self.archetype == #"zombie_dog" || self.archetype == #"zombie_quad")
	{
		n_percent_damage = self.health * randomfloatrange(0.34, 0.75);
	}
	if(isdefined(level.minigun_damage_adjust_override))
	{
		n_override_damage = thread [[level.minigun_damage_adjust_override]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		if(isdefined(n_override_damage))
		{
			n_percent_damage = n_override_damage;
		}
	}
	if(isdefined(n_percent_damage))
	{
		damage = damage + n_percent_damage;
	}
	return damage;
}

