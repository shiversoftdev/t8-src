// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using script_24c32478acf44108;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using script_35598499769dbb3d;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_b13f32ef;

/*
	Name: __init__system__
	Namespace: namespace_b13f32ef
	Checksum: 0x6D7EF02F
	Offset: 0x170
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_67501a71e89fb822", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b13f32ef
	Checksum: 0xF7458B1
	Offset: 0x1C0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_96059a93 = getweapon(#"zhield_zpear_dw");
	level.var_85ed93f4 = getweapon(#"hash_136814846f94f0cd");
	level.var_ce3aa8a8 = getweapon(#"zhield_zpear_turret");
}

/*
	Name: __main__
	Namespace: namespace_b13f32ef
	Checksum: 0x180208F
	Offset: 0x248
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.riotshield_melee = &function_4b03aab;
}

/*
	Name: function_64ff58da
	Namespace: namespace_b13f32ef
	Checksum: 0x13FF5CC9
	Offset: 0x270
	Size: 0x18
	Parameters: 2
	Flags: None
*/
function function_64ff58da(color, var_6ab2cf36)
{
	/#
	#/
}

/*
	Name: function_4b03aab
	Namespace: namespace_b13f32ef
	Checksum: 0x80C02641
	Offset: 0x290
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_4b03aab(weapon)
{
	if(weapon == level.var_ce3aa8a8)
	{
		riotshield::riotshield_melee(weapon);
		return;
	}
	function_dcdaf81c(weapon, 128, 128, 96, 360, 240);
}

/*
	Name: function_dcdaf81c
	Namespace: namespace_b13f32ef
	Checksum: 0x32373E77
	Offset: 0x300
	Size: 0x42C
	Parameters: 7
	Flags: Linked
*/
function function_dcdaf81c(weapon, riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee)
{
	level.riotshield_knockdown_enemies = [];
	level.riotshield_knockdown_gib = [];
	level.riotshield_fling_enemies = [];
	level.riotshield_fling_vecs = [];
	level.var_21ffc192 = [];
	self riotshield::riotshield_get_enemies_in_range(riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee);
	shield_damage = 0;
	for(i = 0; i < level.riotshield_fling_enemies.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_fling_enemies[i]);
		if(isdefined(level.riotshield_fling_enemies[i]))
		{
			/#
				function_64ff58da((1, 0, 0), level.riotshield_fling_enemies[i].origin);
			#/
			level.riotshield_fling_enemies[i] thread function_80a146c1(self, weapon);
			var_d3f92d4d = 30;
			if(self hasperk(#"specialty_mod_shield"))
			{
				var_d3f92d4d = var_d3f92d4d * 0.66;
			}
			shield_damage = shield_damage + var_d3f92d4d;
		}
	}
	for(i = 0; i < level.riotshield_knockdown_enemies.size; i++)
	{
		/#
			function_64ff58da((0, 1, 0), level.riotshield_knockdown_enemies[i].origin);
		#/
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_knockdown_enemies[i]);
		if(!isdefined(level.riotshield_knockdown_enemies[i]))
		{
			continue;
		}
		level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i], weapon);
		shield_damage = shield_damage + 20;
	}
	foreach(ai_enemy in level.var_21ffc192)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(ai_enemy);
		if(!isdefined(ai_enemy))
		{
			continue;
		}
		switch(ai_enemy.var_6f84b820)
		{
			case "heavy":
			case "miniboss":
			case "boss":
			{
				var_d3f92d4d = 30;
				break;
			}
			default:
			{
				var_d3f92d4d = 20;
			}
		}
		if(self hasperk(#"specialty_mod_shield"))
		{
			var_d3f92d4d = var_d3f92d4d * 0.66;
		}
		shield_damage = shield_damage + var_d3f92d4d;
	}
	level.riotshield_knockdown_enemies = [];
	level.riotshield_knockdown_gib = [];
	level.riotshield_fling_enemies = [];
	level.riotshield_fling_vecs = [];
	level.var_21ffc192 = [];
	if(shield_damage)
	{
		self riotshield::player_damage_shield(shield_damage, 0);
	}
}

/*
	Name: function_80a146c1
	Namespace: namespace_b13f32ef
	Checksum: 0x972C1556
	Offset: 0x738
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_80a146c1(player, weapon)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(self.ignore_riotshield) && self.ignore_riotshield)
	{
		return;
	}
	if(isdefined(self.riotshield_fling_func))
	{
		self [[self.riotshield_fling_func]](player);
		return;
	}
	self dodamage(3000, player.origin, player, player, "", "MOD_IMPACT", 0, weapon);
	if(self.health < 1 || player zm_powerups::is_insta_kill_active())
	{
		gibserverutils::annihilate(self);
	}
}

/*
	Name: function_a5ed9221
	Namespace: namespace_b13f32ef
	Checksum: 0xC882CD49
	Offset: 0x840
	Size: 0x226
	Parameters: 1
	Flags: None
*/
function function_a5ed9221(weapon)
{
	if(weapon == level.var_ce3aa8a8)
	{
		riotshield::riotshield_melee(weapon);
		return;
	}
	view_pos = self.origin;
	var_25e2354 = function_4d8c71ce();
	var_72714481 = getaispeciesarray(level.zombie_team, "all");
	a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);
	forward_view_angles = self getweaponforwarddir();
	end_pos = view_pos + vectorscale(forward_view_angles, 64);
	/#
		sphere(end_pos, 48, (1, 0, 0), 0.1, 1, 16, int(5 * (1 / (float(function_60d95f53()) / 1000))));
	#/
	a_e_targets = array::get_all_closest(end_pos, a_e_targets, undefined, undefined, 48);
	if(!isdefined(a_e_targets) || a_e_targets.size < 1)
	{
		return;
	}
	for(i = 0; i < a_e_targets.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(a_e_targets[i]);
		if(!isdefined(a_e_targets[i]))
		{
			continue;
		}
		a_e_targets[i] thread riotshield::riotshield_knockdown_zombie(self, 0, weapon);
	}
}

/*
	Name: function_376cd4f6
	Namespace: namespace_b13f32ef
	Checksum: 0x2C69EA80
	Offset: 0xA70
	Size: 0x3DE
	Parameters: 1
	Flags: None
*/
function function_376cd4f6(weapon)
{
	if(!isdefined(level.riotshield_knockdown_enemies))
	{
		level.riotshield_knockdown_enemies = [];
		level.riotshield_knockdown_gib = [];
		level.riotshield_fling_enemies = [];
		level.riotshield_fling_vecs = [];
		level.var_21ffc192 = [];
	}
	self riotshield::riotshield_get_enemies_in_range(128, 128, 128);
	shield_damage = 0;
	for(i = 0; i < level.riotshield_fling_enemies.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_fling_enemies[i]);
		if(isdefined(level.riotshield_fling_enemies[i]))
		{
			level.riotshield_fling_enemies[i] thread riotshield::riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
			var_d3f92d4d = zombie_utility::function_d2dfacfd(#"riotshield_fling_damage_shield");
			if(self hasperk(#"specialty_mod_shield"))
			{
				var_d3f92d4d = var_d3f92d4d * 0.66;
			}
			shield_damage = shield_damage + var_d3f92d4d;
		}
	}
	for(i = 0; i < level.riotshield_knockdown_enemies.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_knockdown_enemies[i]);
		if(!isdefined(level.riotshield_knockdown_enemies[i]))
		{
			continue;
		}
		level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
		shield_damage = shield_damage + zombie_utility::function_d2dfacfd(#"riotshield_knockdown_damage_shield");
	}
	foreach(ai_enemy in level.var_21ffc192)
	{
		switch(ai_enemy.var_6f84b820)
		{
			case "heavy":
			case "miniboss":
			case "boss":
			{
				var_d3f92d4d = zombie_utility::function_d2dfacfd(#"hash_bfdf728041b626a");
				break;
			}
			default:
			{
				var_d3f92d4d = zombie_utility::function_d2dfacfd(#"hash_6835f7c5524585f3");
			}
		}
		if(self hasperk(#"specialty_mod_shield"))
		{
			var_d3f92d4d = var_d3f92d4d * 0.66;
		}
		shield_damage = shield_damage + var_d3f92d4d;
	}
	level.riotshield_knockdown_enemies = [];
	level.riotshield_knockdown_gib = [];
	level.riotshield_fling_enemies = [];
	level.riotshield_fling_vecs = [];
	level.var_21ffc192 = [];
}

