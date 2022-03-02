// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_93a948d8;

/*
	Name: function_89f2df9
	Namespace: namespace_93a948d8
	Checksum: 0xA64E8F97
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_62481f126a275788", &function_f0f91440, undefined, undefined);
}

/*
	Name: function_f0f91440
	Namespace: namespace_93a948d8
	Checksum: 0x63CF4791
	Offset: 0x178
	Size: 0x396
	Parameters: 0
	Flags: Linked
*/
function function_f0f91440()
{
	level.var_1d893842 = getweapon(#"hash_2605a6745df58840");
	level.var_2f3fae68 = getweapon(#"hash_5e450b80e312b0d1");
	callback::function_34dea974(level.var_1d893842, &function_660bf66e);
	callback::function_34dea974(level.var_2f3fae68, &function_660bf66e);
	callback::on_ai_damage(&function_b65fd5ae);
	zombie_utility::add_zombie_gib_weapon_callback(#"hash_2605a6745df58840", &function_3eedf19c, &function_3eedf19c);
	zombie_utility::add_zombie_gib_weapon_callback(#"hash_5e450b80e312b0d1", &function_3eedf19c, &function_3eedf19c);
	clientfield::register("actor", "" + #"hash_2f305a0bea20d6ed", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_757f891a37d3db00", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_26d3eeef96a2291e", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_32ec41222f58aa75", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_259cdeffe60fe48f", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_1aa3522b88c2b76f", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_5ad28d5f104a6e3b", 1, 1, "int");
	namespace_9ff9f642::register_slowdown(#"hash_7706017a8f91f35c", 0.85, 10);
	namespace_9ff9f642::register_slowdown(#"hash_5a1a7bceb3b8fded", 0.65, 15);
	level.var_58e6238 = &mp_dom_flag_d_captured_byinterfaceattributes;
	level.var_f975b6ae = &function_9a01c5b0;
}

/*
	Name: function_3eedf19c
	Namespace: namespace_93a948d8
	Checksum: 0xB141A78A
	Offset: 0x518
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_3eedf19c(damage_percent)
{
	return false;
}

/*
	Name: function_b65fd5ae
	Namespace: namespace_93a948d8
	Checksum: 0xFE3C2F11
	Offset: 0x530
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function function_b65fd5ae(params)
{
	if(isdefined(self.water_damage) && self.water_damage)
	{
		if(params.idamage >= self.health)
		{
			self thread freezegun_death(params);
			return;
		}
	}
	if(!is_freezegun_damage(params))
	{
		return;
	}
	if(!isplayer(params.eattacker))
	{
		return;
	}
	if(!isalive(self))
	{
		return;
	}
	if(params.idamage >= self.health)
	{
		self thread freezegun_death(params);
		return;
	}
	if(!isdefined(self.freezegun_damage))
	{
		self.freezegun_damage = 0;
	}
	if(!isdefined(self.var_4592c713))
	{
		self.var_4592c713 = 0;
	}
	var_bdbde2d2 = #"hash_7706017a8f91f35c";
	if(self.var_4592c713 || params.weapon == level.var_2f3fae68)
	{
		var_bdbde2d2 = #"hash_5a1a7bceb3b8fded";
	}
	if(self.archetype != #"zombie_dog")
	{
		self thread namespace_9ff9f642::slowdown(var_bdbde2d2);
		self thread slow_watcher(var_bdbde2d2);
	}
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_cdcf36d9();
	}
}

/*
	Name: slow_watcher
	Namespace: namespace_93a948d8
	Checksum: 0x6C0F0C6B
	Offset: 0x720
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function slow_watcher(var_bdbde2d2)
{
	self notify(#"hash_7898db449656ed5a");
	self endon(#"death", #"hash_7898db449656ed5a");
	self.var_4592c713 = 1;
	n_wait = 10;
	if(var_bdbde2d2 == #"hash_5a1a7bceb3b8fded")
	{
		n_wait = 15;
	}
	wait(n_wait);
	self.var_4592c713 = 0;
}

/*
	Name: function_660bf66e
	Namespace: namespace_93a948d8
	Checksum: 0x445B013A
	Offset: 0x7C0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_660bf66e(weapon)
{
	self endon(#"disconnect");
	self thread freezegun_fired(weapon == level.var_2f3fae68);
}

/*
	Name: freezegun_fired
	Namespace: namespace_93a948d8
	Checksum: 0xB10794FB
	Offset: 0x810
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function freezegun_fired(is_upgraded)
{
	if(!isdefined(level.freezegun_enemies))
	{
		level.freezegun_enemies = [];
		level.freezegun_enemies_dist_ratio = [];
	}
	self freezegun_get_enemies_in_range(is_upgraded);
	for(i = 0; i < level.freezegun_enemies.size; i++)
	{
		level.freezegun_enemies[i] thread freezegun_do_damage(is_upgraded, self, level.freezegun_enemies_dist_ratio[i]);
	}
	level.freezegun_enemies = [];
	level.freezegun_enemies_dist_ratio = [];
	self function_4aa98d7d(is_upgraded);
}

/*
	Name: freezegun_get_enemies_in_range
	Namespace: namespace_93a948d8
	Checksum: 0x98A093C4
	Offset: 0x8F8
	Size: 0x51A
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_enemies_in_range(is_upgraded)
{
	inner_range = freezegun_get_inner_range(is_upgraded);
	outer_range = freezegun_get_outer_range(is_upgraded);
	cylinder_radius = freezegun_get_cylinder_radius(is_upgraded);
	view_pos = self getweaponmuzzlepoint();
	a_targets = getentitiesinradius(view_pos, outer_range * 1.1, 15);
	if(!isdefined(a_targets))
	{
		return;
	}
	a_targets = arraysortclosest(a_targets, view_pos);
	freezegun_inner_range_squared = inner_range * inner_range;
	freezegun_outer_range_squared = outer_range * outer_range;
	cylinder_radius_squared = cylinder_radius * cylinder_radius;
	forward_view_angles = self getweaponforwarddir();
	end_pos = view_pos + vectorscale(forward_view_angles, outer_range);
	/#
		if(2 == getdvarint(#"hash_1f9b7149df8b7dcb", 0))
		{
			near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
			circle(near_circle_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
			line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
			circle(end_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
		}
	#/
	foreach(ai in a_targets)
	{
		if(!isdefined(ai) || (ai.archetype !== #"zombie" && ai.archetype !== #"zombie_dog" && ai.archetype !== #"nova_crawler") || ai getteam() !== level.zombie_team || !isalive(ai))
		{
			continue;
		}
		test_origin = ai getcentroid();
		test_range_squared = distancesquared(view_pos, test_origin);
		if(test_range_squared > freezegun_outer_range_squared)
		{
			ai freezegun_debug_print("range", (1, 0, 0));
			return;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(0 > dot)
		{
			ai freezegun_debug_print("dot", (1, 0, 0));
			continue;
		}
		radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
		if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared)
		{
			ai freezegun_debug_print("cylinder", (1, 0, 0));
			continue;
		}
		if(0 == ai damageconetrace(view_pos, self))
		{
			ai freezegun_debug_print("cone", (1, 0, 0));
			continue;
		}
		level.freezegun_enemies[level.freezegun_enemies.size] = ai;
		level.freezegun_enemies_dist_ratio[level.freezegun_enemies_dist_ratio.size] = (freezegun_outer_range_squared - test_range_squared) / (freezegun_outer_range_squared - freezegun_inner_range_squared);
	}
}

/*
	Name: freezegun_do_damage
	Namespace: namespace_93a948d8
	Checksum: 0x7C6E7AEF
	Offset: 0xE20
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function freezegun_do_damage(is_upgraded, player, dist_ratio)
{
	damage = int(lerpfloat(freezegun_get_outer_damage(is_upgraded), freezegun_get_inner_damage(is_upgraded), dist_ratio));
	self dodamage(damage, self.origin, player, undefined, undefined, "MOD_PROJECTILE");
}

/*
	Name: function_4aa98d7d
	Namespace: namespace_93a948d8
	Checksum: 0xC0B0BC90
	Offset: 0xEC8
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_4aa98d7d(is_upgraded)
{
	view_pos = self getweaponmuzzlepoint();
	var_6beec13a = self getweaponforwarddir();
	var_61101445 = freezegun_get_outer_range(is_upgraded);
	n_max_damage = freezegun_get_inner_damage(is_upgraded);
	n_min_damage = freezegun_get_outer_damage(is_upgraded);
	end_pos = view_pos + vectorscale(var_6beec13a, var_61101445);
	var_6a748e6b = beamtrace(view_pos, end_pos, 0, self);
	if(isdefined(var_6a748e6b[#"position"]))
	{
		glassradiusdamage(var_6a748e6b[#"position"], 40, n_max_damage, n_min_damage);
	}
}

/*
	Name: freezegun_do_shatter
	Namespace: namespace_93a948d8
	Checksum: 0x6086A4B7
	Offset: 0x1018
	Size: 0x314
	Parameters: 3
	Flags: Linked
*/
function freezegun_do_shatter(params, shatter_trigger, crumple_trigger)
{
	freezegun_debug_print("shattered");
	self thread freezegun_cleanup_freezegun_triggers(shatter_trigger, crumple_trigger);
	is_upgraded = params.weapon == level.var_2f3fae68;
	centroid = self getcentroid();
	a_targets = getentitiesinradius(centroid, freezegun_get_shatter_range(is_upgraded), 15);
	foreach(ai in a_targets)
	{
		if(!isdefined(ai) || (ai.archetype !== #"zombie" && ai.archetype !== #"zombie_dog" && ai.archetype !== #"nova_crawler") || ai getteam() !== level.zombie_team)
		{
			continue;
			continue;
		}
		if(isalive(ai))
		{
			ai dodamage(freezegun_get_shatter_inner_damage(is_upgraded), ai.origin, params.eattacker, undefined, undefined, "MOD_EXPLOSIVE");
			continue;
		}
		if(isdefined(ai.shatter_trigger))
		{
			ai.shatter_trigger dodamage(freezegun_get_shatter_inner_damage(is_upgraded), ai.origin, params.eattacker, undefined, undefined, "MOD_EXPLOSIVE");
		}
	}
	level notify(#"hash_36bd057e4aa760bd");
	self zombie_utility::zombie_eye_glow_stop();
	self function_1cdfba74(is_upgraded);
	if(isdefined(params.eattacker) && isdefined(params.eattacker.var_5a15be2a))
	{
		params.eattacker [[params.eattacker.var_5a15be2a]]();
	}
}

/*
	Name: freezegun_wait_for_shatter
	Namespace: namespace_93a948d8
	Checksum: 0x85E25750
	Offset: 0x1338
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function freezegun_wait_for_shatter(params, shatter_trigger, crumple_trigger)
{
	shatter_trigger endon(#"death", #"cleanup_freezegun_triggers");
	self endon(#"death");
	wait(0.1);
	orig_attacker = params.eattacker;
	s_notify = undefined;
	s_notify = shatter_trigger waittill(#"damage");
	if(isdefined(s_notify.eattacker) && orig_attacker == s_notify.eattacker && s_notify.smeansofdeath == "MOD_PROJECTILE" && (s_notify.weapon == level.var_1d893842 || s_notify.weapon == level.var_2f3fae68))
	{
		self thread freezegun_do_crumple(params, shatter_trigger, crumple_trigger);
	}
	else
	{
		self thread freezegun_do_shatter(params, shatter_trigger, crumple_trigger);
	}
}

/*
	Name: freezegun_do_crumple
	Namespace: namespace_93a948d8
	Checksum: 0x2D282BEA
	Offset: 0x1498
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function freezegun_do_crumple(params, shatter_trigger, crumple_trigger)
{
	freezegun_debug_print("crumpled");
	self freezegun_cleanup_freezegun_triggers(shatter_trigger, crumple_trigger);
	is_upgraded = params.weapon == level.var_2f3fae68;
	level notify(#"hash_4904b9ea745d6545");
	self zombie_utility::zombie_eye_glow_stop();
	self function_c61abffb(is_upgraded);
	self startragdoll();
}

/*
	Name: freezegun_wait_for_crumple
	Namespace: namespace_93a948d8
	Checksum: 0x44E85B8
	Offset: 0x1568
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function freezegun_wait_for_crumple(params, shatter_trigger, crumple_trigger)
{
	crumple_trigger endon(#"death", #"cleanup_freezegun_triggers");
	self endon(#"death");
	wait(0.1);
	crumple_trigger waittill(#"trigger");
	self thread freezegun_do_crumple(params, shatter_trigger, crumple_trigger);
}

/*
	Name: freezegun_cleanup_freezegun_triggers
	Namespace: namespace_93a948d8
	Checksum: 0xAB32AF99
	Offset: 0x1608
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function freezegun_cleanup_freezegun_triggers(shatter_trigger, crumple_trigger)
{
	self endon(#"death");
	self.cleanup_freezegun_triggers = 1;
	self notify(#"cleanup_freezegun_triggers");
	shatter_trigger notify(#"cleanup_freezegun_triggers");
	crumple_trigger notify(#"cleanup_freezegun_triggers");
	shatter_trigger delete();
	crumple_trigger delete();
}

/*
	Name: freezegun_run_skipped_death_events
	Namespace: namespace_93a948d8
	Checksum: 0xC0180536
	Offset: 0x16B0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function freezegun_run_skipped_death_events()
{
	self thread zombie_utility::zombie_eye_glow_stop();
}

/*
	Name: freezegun_death
	Namespace: namespace_93a948d8
	Checksum: 0xD5BEEEEA
	Offset: 0x16D8
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function freezegun_death(params)
{
	if(self.archetype === #"zombie_dog")
	{
		self freezegun_run_skipped_death_events();
		return;
	}
	self.freezegun_death = 1;
	self.skip_death_notetracks = 1;
	self.nodeathragdoll = 1;
	self.var_606a4641 = params;
	self playsound(#"hash_2039f8c77ff89659");
}

/*
	Name: mp_dom_flag_d_captured_byinterfaceattributes
	Namespace: namespace_93a948d8
	Checksum: 0x3090A737
	Offset: 0x1770
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function mp_dom_flag_d_captured_byinterfaceattributes()
{
	if(!getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		self thread function_cdcf36d9();
		self thread function_aa09d4c6();
	}
	self thread function_cd5a6d8();
	shatter_trigger = spawn("trigger_damage", self.origin, 0, 15, 72);
	shatter_trigger enablelinkto();
	shatter_trigger linkto(self);
	shatter_trigger thread function_e31780b1();
	spawnflags = (512 | 1) | (512 | 2) | (512 | 4) | 16;
	crumple_trigger = spawn("trigger_radius", self.origin, spawnflags, 15, 72);
	crumple_trigger enablelinkto();
	crumple_trigger linkto(self);
	crumple_trigger thread function_e31780b1();
	self.shatter_trigger = shatter_trigger;
	self.crumple_trigger = crumple_trigger;
	self thread freezegun_wait_for_shatter(self.var_606a4641, shatter_trigger, crumple_trigger);
	self thread freezegun_wait_for_crumple(self.var_606a4641, shatter_trigger, crumple_trigger);
}

/*
	Name: function_9a01c5b0
	Namespace: namespace_93a948d8
	Checksum: 0xB57CF5EC
	Offset: 0x1980
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_9a01c5b0()
{
	if(isdefined(self.cleanup_freezegun_triggers) && self.cleanup_freezegun_triggers)
	{
		return;
	}
	if(isdefined(self.shatter_trigger) && isdefined(self.crumple_trigger))
	{
		self freezegun_do_crumple(self.var_606a4641, self.shatter_trigger, self.crumple_trigger);
	}
	else if(isdefined(self))
	{
		if(!getdvarint(#"splitscreen_playercount", 1) > 2)
		{
			self function_1e71ac1e();
			self function_95a1c464();
		}
		self startragdoll();
	}
}

/*
	Name: function_e31780b1
	Namespace: namespace_93a948d8
	Checksum: 0x881E127E
	Offset: 0x1A70
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_e31780b1()
{
	level endon(#"game_ended");
	self endon(#"death");
	wait(10);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: is_freezegun_damage
	Namespace: namespace_93a948d8
	Checksum: 0xD87E84D1
	Offset: 0x1AD0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function is_freezegun_damage(params)
{
	return params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath == "MOD_PROJECTILE" && isdefined(params.weapon) && (params.weapon == level.var_1d893842 || params.weapon == level.var_2f3fae68);
}

/*
	Name: is_freezegun_shatter_damage
	Namespace: namespace_93a948d8
	Checksum: 0x259F19E9
	Offset: 0x1B60
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function is_freezegun_shatter_damage(params)
{
	return params.smeansofdeath == "MOD_EXPLOSIVE" && isdefined(params.weapon) && (params.weapon == level.var_1d893842 || params.weapon == level.var_2f3fae68);
}

/*
	Name: should_do_freezegun_death
	Namespace: namespace_93a948d8
	Checksum: 0x930AB6FE
	Offset: 0x1BD0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function should_do_freezegun_death(params)
{
	return is_freezegun_damage(params);
}

/*
	Name: enemy_damaged_by_freezegun
	Namespace: namespace_93a948d8
	Checksum: 0xC15B3AC4
	Offset: 0x1C00
	Size: 0x10
	Parameters: 0
	Flags: None
*/
function enemy_damaged_by_freezegun()
{
	return 0 < self.freezegun_damage;
}

/*
	Name: enemy_percent_damaged_by_freezegun
	Namespace: namespace_93a948d8
	Checksum: 0x7FF89E55
	Offset: 0x1C18
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function enemy_percent_damaged_by_freezegun()
{
	return self.freezegun_damage / self.maxhealth;
}

/*
	Name: enemy_killed_by_freezegun
	Namespace: namespace_93a948d8
	Checksum: 0x86DD93A1
	Offset: 0x1C38
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function enemy_killed_by_freezegun()
{
	return isdefined(self.freezegun_death) && self.freezegun_death == 1;
}

/*
	Name: freezegun_get_cylinder_radius
	Namespace: namespace_93a948d8
	Checksum: 0x27798D27
	Offset: 0x1C60
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_cylinder_radius(is_upgraded)
{
	if(is_upgraded)
	{
		return 180;
	}
	return 120;
}

/*
	Name: freezegun_get_inner_range
	Namespace: namespace_93a948d8
	Checksum: 0xC2EFE7F6
	Offset: 0x1C90
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_inner_range(is_upgraded)
{
	if(is_upgraded)
	{
		return 120;
	}
	return 60;
}

/*
	Name: freezegun_get_outer_range
	Namespace: namespace_93a948d8
	Checksum: 0xA0311D2A
	Offset: 0x1CC0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_outer_range(is_upgraded)
{
	if(is_upgraded)
	{
		return 900;
	}
	return 600;
}

/*
	Name: freezegun_get_inner_damage
	Namespace: namespace_93a948d8
	Checksum: 0xA63B54FE
	Offset: 0x1CF0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_inner_damage(is_upgraded)
{
	if(is_upgraded)
	{
		return 3000;
	}
	return 1500;
}

/*
	Name: freezegun_get_outer_damage
	Namespace: namespace_93a948d8
	Checksum: 0x3938D4EB
	Offset: 0x1D20
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_outer_damage(is_upgraded)
{
	if(is_upgraded)
	{
		return 1500;
	}
	return 750;
}

/*
	Name: freezegun_get_shatter_range
	Namespace: namespace_93a948d8
	Checksum: 0x61219AAD
	Offset: 0x1D50
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_shatter_range(is_upgraded)
{
	if(is_upgraded)
	{
		return 300;
	}
	return 180;
}

/*
	Name: freezegun_get_shatter_inner_damage
	Namespace: namespace_93a948d8
	Checksum: 0x39F704DC
	Offset: 0x1D80
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function freezegun_get_shatter_inner_damage(is_upgraded)
{
	if(is_upgraded)
	{
		return 750;
	}
	return 500;
}

/*
	Name: freezegun_get_shatter_outer_damage
	Namespace: namespace_93a948d8
	Checksum: 0x19400DA4
	Offset: 0x1DB0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function freezegun_get_shatter_outer_damage(is_upgraded)
{
	if(is_upgraded)
	{
		return 500;
	}
	return 250;
}

/*
	Name: freezegun_debug_print
	Namespace: namespace_93a948d8
	Checksum: 0x44E17CF8
	Offset: 0x1DE0
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function freezegun_debug_print(msg, color)
{
	/#
		if(!getdvarint(#"hash_1f9b7149df8b7dcb", 0))
		{
			return;
		}
		if(!isdefined(color))
		{
			color = (1, 1, 1);
		}
		print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
	#/
}

/*
	Name: function_1cdfba74
	Namespace: namespace_93a948d8
	Checksum: 0x51A337B8
	Offset: 0x1E78
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_1cdfba74(is_upgraded)
{
	if(is_upgraded)
	{
		self clientfield::set("" + #"hash_26d3eeef96a2291e", 1);
		self playsound(#"hash_3bed1320e59a493c");
	}
	else
	{
		self clientfield::set("" + #"hash_2f305a0bea20d6ed", 1);
		self playsound(#"hash_3bed1320e59a493c");
	}
}

/*
	Name: function_c61abffb
	Namespace: namespace_93a948d8
	Checksum: 0xB5A64D1B
	Offset: 0x1F38
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_c61abffb(is_upgraded)
{
	if(is_upgraded)
	{
		self clientfield::set("" + #"hash_32ec41222f58aa75", 1);
		self playsound(#"hash_55070bed4172e08c");
	}
	else
	{
		self clientfield::set("" + #"hash_757f891a37d3db00", 1);
		self playsound(#"hash_55070bed4172e08c");
	}
}

/*
	Name: function_cdcf36d9
	Namespace: namespace_93a948d8
	Checksum: 0xD46C9EB5
	Offset: 0x1FF8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_cdcf36d9()
{
	self clientfield::set("" + #"hash_1aa3522b88c2b76f", 1);
}

/*
	Name: function_1e71ac1e
	Namespace: namespace_93a948d8
	Checksum: 0x9880D3E
	Offset: 0x2038
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_1e71ac1e()
{
	self clientfield::set("" + #"hash_1aa3522b88c2b76f", 0);
}

/*
	Name: function_aa09d4c6
	Namespace: namespace_93a948d8
	Checksum: 0x7528112
	Offset: 0x2070
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_aa09d4c6()
{
	self clientfield::set("" + #"hash_259cdeffe60fe48f", 1);
}

/*
	Name: function_95a1c464
	Namespace: namespace_93a948d8
	Checksum: 0x990205A0
	Offset: 0x20B0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_95a1c464()
{
	self clientfield::set("" + #"hash_259cdeffe60fe48f", 0);
}

/*
	Name: function_cd5a6d8
	Namespace: namespace_93a948d8
	Checksum: 0xA8F1A79B
	Offset: 0x20E8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_cd5a6d8()
{
	self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 1);
}

/*
	Name: function_7258958d
	Namespace: namespace_93a948d8
	Checksum: 0x54630F29
	Offset: 0x2128
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_7258958d()
{
	self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 0);
}

