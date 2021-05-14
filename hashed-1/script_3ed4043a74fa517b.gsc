// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_clone.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_95574d51;

/*
	Name: function_89f2df9
	Namespace: namespace_95574d51
	Checksum: 0x42675EFE
	Offset: 0x198
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7ec9595768b1ec91", &__init__, &__main__, #"zm_weapons");
}

/*
	Name: __init__
	Namespace: namespace_95574d51
	Checksum: 0xFCD31B99
	Offset: 0x1F8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.weaponzmcymbalmonkey = getweapon(#"cymbal_monkey");
	zm_weapons::register_zombie_weapon_callback(level.weaponzmcymbalmonkey, &player_give_cymbal_monkey);
	zm_loadout::register_lethal_grenade_for_level(#"cymbal_monkey");
	clientfield::register("scriptmover", "" + #"hash_60a7e5b79e8064a5", 1, 1, "int");
	zm::function_84d343d(#"cymbal_monkey", &function_3681e2bc);
}

/*
	Name: __main__
	Namespace: namespace_95574d51
	Checksum: 0x61A48DDA
	Offset: 0x2E8
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!cymbal_monkey_exists())
	{
		return;
	}
	/#
		level.zombiemode_devgui_cymbal_monkey_give = &player_give_cymbal_monkey;
	#/
	if(isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey)
	{
		level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
	}
	else
	{
		level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
	}
	level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
	level._effect[#"grenade_samantha_steal"] = #"hash_7965ec9e0938553f";
	level.cymbal_monkeys = [];
	level.var_2f2478f2 = 1;
	if(!isdefined(level.valid_poi_max_radius))
	{
		level.valid_poi_max_radius = 150;
	}
	if(!isdefined(level.valid_poi_half_height))
	{
		level.valid_poi_half_height = 100;
	}
	if(!isdefined(level.valid_poi_inner_spacing))
	{
		level.valid_poi_inner_spacing = 2;
	}
	if(!isdefined(level.valid_poi_radius_from_edges))
	{
		level.valid_poi_radius_from_edges = 16;
	}
	if(!isdefined(level.valid_poi_height))
	{
		level.valid_poi_height = 36;
	}
}

/*
	Name: function_3681e2bc
	Namespace: namespace_95574d51
	Checksum: 0xA7EE9AF3
	Offset: 0x478
	Size: 0xEA
	Parameters: 12
	Flags: Linked
*/
function function_3681e2bc(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_IMPACT")
	{
		return 0;
	}
	var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
	var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 50);
	return var_5d7b4163;
}

/*
	Name: player_give_cymbal_monkey
	Namespace: namespace_95574d51
	Checksum: 0xC5822134
	Offset: 0x570
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function player_give_cymbal_monkey()
{
	w_weapon = level.weaponzmcymbalmonkey;
	if(!self hasweapon(w_weapon))
	{
		self giveweapon(w_weapon);
	}
	self thread player_handle_cymbal_monkey();
}

/*
	Name: player_handle_cymbal_monkey
	Namespace: namespace_95574d51
	Checksum: 0xAC0C740E
	Offset: 0x5E0
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function player_handle_cymbal_monkey()
{
	self notify(#"starting_monkey_watch");
	self endon(#"starting_monkey_watch", #"disconnect");
	attract_dist_diff = level.monkey_attract_dist_diff;
	if(!isdefined(attract_dist_diff))
	{
		attract_dist_diff = 16;
	}
	num_attractors = level.num_monkey_attractors;
	if(!isdefined(num_attractors))
	{
		num_attractors = 32;
	}
	max_attract_dist = level.monkey_attract_dist;
	if(!isdefined(max_attract_dist))
	{
		max_attract_dist = 3000;
	}
	while(true)
	{
		grenade = get_thrown_monkey();
		self player_throw_cymbal_monkey(grenade, num_attractors, max_attract_dist, attract_dist_diff);
		waitframe(1);
	}
}

/*
	Name: watch_for_dud
	Namespace: namespace_95574d51
	Checksum: 0x8BB8DBB0
	Offset: 0x6E8
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function watch_for_dud(actor)
{
	self endon(#"death");
	self waittill(#"grenade_dud");
	self.var_bdd70f6a.dud = 1;
	self playsound(#"zmb_vox_monkey_scream");
	self.monk_scream_vox = 1;
	wait(3);
	if(isdefined(self.var_bdd70f6a))
	{
		self.var_bdd70f6a delete();
	}
	if(isdefined(actor))
	{
		actor delete();
	}
	if(isdefined(self.damagearea))
	{
		self.damagearea delete();
	}
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: watch_for_emp
	Namespace: namespace_95574d51
	Checksum: 0x8D2069C1
	Offset: 0x7F8
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function watch_for_emp(actor)
{
	self endon(#"death");
	if(!zm_utility::should_watch_for_emp())
	{
		return;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"emp_detonate");
		if(distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius)
		{
			break;
		}
	}
	self.stun_fx = 1;
	if(isdefined(level._equipment_emp_destroy_fx))
	{
		playfx(level._equipment_emp_destroy_fx, self.origin + vectorscale((0, 0, 1), 5), (0, randomfloat(360), 0));
	}
	wait(0.15);
	self.attract_to_origin = 0;
	self zm_utility::deactivate_zombie_point_of_interest();
	wait(1);
	self detonate();
	wait(1);
	if(isdefined(self.var_bdd70f6a))
	{
		self.var_bdd70f6a delete();
	}
	if(isdefined(actor))
	{
		actor delete();
	}
	if(isdefined(self.damagearea))
	{
		self.damagearea delete();
	}
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: clone_player_angles
	Namespace: namespace_95574d51
	Checksum: 0x60F0A34D
	Offset: 0x9F0
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function clone_player_angles(owner)
{
	self endon(#"death");
	owner endon(#"death");
	while(isdefined(self))
	{
		self.angles = owner.angles;
		waitframe(1);
	}
}

/*
	Name: show_briefly
	Namespace: namespace_95574d51
	Checksum: 0x18E7EB92
	Offset: 0xA50
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function show_briefly(showtime)
{
	self endon(#"show_owner");
	if(isdefined(self.show_for_time))
	{
		self.show_for_time = showtime;
		return;
	}
	self.show_for_time = showtime;
	self setvisibletoall();
	while(self.show_for_time > 0)
	{
		self.show_for_time = self.show_for_time - 0.05;
		waitframe(1);
	}
	self setvisibletoallexceptteam(level.zombie_team);
	self.show_for_time = undefined;
}

/*
	Name: show_owner_on_attack
	Namespace: namespace_95574d51
	Checksum: 0xF359D543
	Offset: 0xB10
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function show_owner_on_attack(owner)
{
	owner endon(#"hide_owner", #"show_owner");
	self endon(#"explode", #"death", #"grenade_dud");
	owner.show_for_time = undefined;
	for(;;)
	{
		owner waittill(#"weapon_fired");
		owner thread show_briefly(0.5);
	}
}

/*
	Name: hide_owner
	Namespace: namespace_95574d51
	Checksum: 0x1185CDDE
	Offset: 0xBC8
	Size: 0x23C
	Parameters: 1
	Flags: Linked
*/
function hide_owner(owner)
{
	owner notify(#"hide_owner");
	owner endon(#"hide_owner");
	owner setperk("specialty_immunemms");
	owner.no_burning_sfx = 1;
	owner notify(#"stop_flame_sounds");
	owner setvisibletoallexceptteam(level.zombie_team);
	owner.hide_owner = 1;
	if(isdefined(level._effect[#"human_disappears"]))
	{
		playfx(level._effect[#"human_disappears"], owner.origin);
	}
	self thread show_owner_on_attack(owner);
	evt = undefined;
	evt = self waittill(#"explode", #"death", #"grenade_dud");
	/#
		println("" + evt._notify);
	#/
	owner notify(#"show_owner");
	owner unsetperk("specialty_immunemms");
	if(isdefined(level._effect[#"human_disappears"]))
	{
		playfx(level._effect[#"human_disappears"], owner.origin);
	}
	owner.no_burning_sfx = undefined;
	owner setvisibletoall();
	owner.hide_owner = undefined;
	owner show();
}

/*
	Name: proximity_detonate
	Namespace: namespace_95574d51
	Checksum: 0xD1334175
	Offset: 0xE10
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function proximity_detonate(owner)
{
	wait(1.5);
	if(!isdefined(self))
	{
		return;
	}
	detonateradius = 96;
	explosionradius = detonateradius * 2;
	damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 512 | 4, detonateradius, detonateradius * 1.5);
	damagearea setexcludeteamfortrigger(owner.team);
	damagearea enablelinkto();
	damagearea linkto(self);
	self.damagearea = damagearea;
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = damagearea waittill(#"trigger");
		ent = waitresult.activator;
		if(isdefined(owner) && ent == owner)
		{
			continue;
		}
		if(isdefined(ent.team) && ent.team == owner.team)
		{
			continue;
		}
		self playsound(#"wpn_claymore_alert");
		dist = distance(self.origin, ent.origin);
		radiusdamage(self.origin + vectorscale((0, 0, 1), 12), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.weaponzmcymbalmonkey);
		if(isdefined(owner))
		{
			self detonate(owner);
		}
		else
		{
			self detonate(undefined);
		}
		break;
	}
	if(isdefined(damagearea))
	{
		damagearea delete();
	}
}

/*
	Name: player_throw_cymbal_monkey
	Namespace: namespace_95574d51
	Checksum: 0x23C53732
	Offset: 0x1098
	Size: 0x5A4
	Parameters: 4
	Flags: Linked
*/
function player_throw_cymbal_monkey(e_grenade, num_attractors, max_attract_dist, attract_dist_diff)
{
	self endon(#"starting_monkey_watch", #"disconnect");
	if(isdefined(e_grenade))
	{
		e_grenade endon(#"death");
		if(self laststand::player_is_in_laststand())
		{
			if(isdefined(e_grenade.damagearea))
			{
				e_grenade.damagearea delete();
			}
			e_grenade delete();
			return;
		}
		e_grenade ghost();
		e_grenade.angles = self.angles;
		e_grenade.var_bdd70f6a = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
		e_grenade.var_bdd70f6a linkto(e_grenade);
		e_grenade.var_bdd70f6a thread monkey_cleanup(e_grenade);
		e_grenade.var_bdd70f6a playsound(#"hash_68402c92c838b7f7");
		clone = undefined;
		if(isdefined(level.cymbal_monkey_dual_view) && level.cymbal_monkey_dual_view)
		{
			e_grenade.var_bdd70f6a setvisibletoallexceptteam(level.zombie_team);
			clone = zm_clone::spawn_player_clone(self, vectorscale((0, 0, -1), 999), level.cymbal_monkey_clone_weapon, undefined);
			e_grenade.var_bdd70f6a.simulacrum = clone;
			clone zm_clone::clone_animate("idle");
			clone thread clone_player_angles(self);
			clone notsolid();
			clone ghost();
		}
		e_grenade thread watch_for_dud(clone);
		e_grenade thread watch_for_emp(clone);
		info = spawnstruct();
		info.sound_attractors = [];
		e_grenade waittill(#"stationary");
		if(isdefined(level.grenade_planted))
		{
			self thread [[level.grenade_planted]](e_grenade, e_grenade.var_bdd70f6a);
		}
		if(isdefined(e_grenade))
		{
			if(isdefined(clone))
			{
				clone forceteleport(e_grenade.origin, e_grenade.angles);
				clone thread hide_owner(self);
				e_grenade thread proximity_detonate(self);
				clone show();
				clone setinvisibletoall();
				clone setvisibletoteam(level.zombie_team);
			}
			e_grenade resetmissiledetonationtime();
			playfxontag(level._effect[#"monkey_glow"], e_grenade.var_bdd70f6a, "tag_weapon");
			valid_poi = e_grenade is_on_navmesh(self);
			if(valid_poi && (isdefined(e_grenade.var_45eaa114) && e_grenade.var_45eaa114))
			{
				wait(0.1);
				e_grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
				valid_poi = e_grenade zm_utility::create_zombie_point_of_interest_attractor_positions(attract_dist_diff, undefined, level.valid_poi_max_radius, 1);
				if(valid_poi)
				{
					e_grenade thread do_monkey_sound(info);
					e_grenade thread function_875fd1df();
					level.cymbal_monkeys[level.cymbal_monkeys.size] = e_grenade;
				}
				else
				{
					e_grenade zm_utility::deactivate_zombie_point_of_interest();
				}
			}
			if(!valid_poi)
			{
				e_grenade.script_noteworthy = undefined;
				level thread grenade_stolen_by_sam(e_grenade, clone);
			}
		}
		else
		{
			e_grenade.script_noteworthy = undefined;
			level thread grenade_stolen_by_sam(e_grenade, clone);
		}
	}
}

/*
	Name: function_ab9a9770
	Namespace: namespace_95574d51
	Checksum: 0x39897D1C
	Offset: 0x1648
	Size: 0xAE
	Parameters: 0
	Flags: Private
*/
private function function_ab9a9770()
{
	s_trace = groundtrace(self.origin + vectorscale((0, 0, 1), 70), self.origin + vectorscale((0, 0, -1), 100), 0, self);
	if(isdefined(s_trace[#"entity"]))
	{
		entity = s_trace[#"entity"];
		if(entity ismovingplatform())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_2f2478f2
	Namespace: namespace_95574d51
	Checksum: 0xB1411C12
	Offset: 0x1700
	Size: 0x1AE
	Parameters: 0
	Flags: None
*/
function function_2f2478f2()
{
	v_orig = self.origin;
	queryresult = positionquery_source_navigation(self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges);
	if(queryresult.data.size)
	{
		foreach(point in queryresult.data)
		{
			height_offset = abs(self.origin[2] - point.origin[2]);
			if(height_offset > level.valid_poi_height)
			{
				continue;
			}
			if(zm_utility::check_point_in_enabled_zone(point.origin) && bullettracepassed(point.origin + vectorscale((0, 0, 1), 20), v_orig + vectorscale((0, 0, 1), 20), 0, self, undefined, 0, 0))
			{
				self.origin = point.origin;
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: grenade_stolen_by_sam
	Namespace: namespace_95574d51
	Checksum: 0x45DE44DD
	Offset: 0x18B8
	Size: 0x2D4
	Parameters: 2
	Flags: Linked
*/
function grenade_stolen_by_sam(e_grenade, e_actor)
{
	if(!isdefined(e_grenade.var_bdd70f6a))
	{
		return;
	}
	direction = e_grenade.var_bdd70f6a.origin;
	direction = (direction[1], direction[0], 0);
	if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0))
	{
		direction = (direction[0], direction[1] * -1, 0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1, direction[1], 0);
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isalive(players[i]))
		{
			players[i] playlocalsound(level.zmb_laugh_alias);
		}
	}
	playfxontag(level._effect[#"grenade_samantha_steal"], e_grenade.var_bdd70f6a, "tag_origin");
	e_grenade.var_bdd70f6a unlink();
	e_grenade.var_bdd70f6a movez(60, 1, 0.25, 0.25);
	e_grenade.var_bdd70f6a vibrate(direction, 1.5, 2.5, 1);
	e_grenade.var_bdd70f6a waittill(#"movedone");
	e_grenade.var_bdd70f6a delete();
	if(isdefined(e_actor))
	{
		e_actor delete();
	}
	if(isdefined(e_grenade))
	{
		if(isdefined(e_grenade.damagearea))
		{
			e_grenade.damagearea delete();
		}
		e_grenade delete();
	}
}

/*
	Name: monkey_cleanup
	Namespace: namespace_95574d51
	Checksum: 0x13C27AC5
	Offset: 0x1B98
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function monkey_cleanup(e_grenade)
{
	self endon(#"death");
	while(true)
	{
		if(!isdefined(e_grenade))
		{
			if(isdefined(self.dud) && self.dud)
			{
				wait(6);
			}
			if(isdefined(self.simulacrum))
			{
				self.simulacrum delete();
			}
			zm_utility::self_delete();
			return;
		}
		waitframe(1);
	}
}

/*
	Name: do_monkey_sound
	Namespace: namespace_95574d51
	Checksum: 0x1935FA7C
	Offset: 0x1C30
	Size: 0x260
	Parameters: 1
	Flags: Linked
*/
function do_monkey_sound(info)
{
	self endon(#"death");
	self.monk_scream_vox = 0;
	if(isdefined(level.grenade_safe_to_bounce))
	{
		if(![[level.grenade_safe_to_bounce]](self.owner, level.weaponzmcymbalmonkey))
		{
			self playsound(#"zmb_vox_monkey_scream");
			self.monk_scream_vox = 1;
		}
	}
	if(!self.monk_scream_vox && level.musicsystem.currentplaytype < 4)
	{
		self playsound(#"hash_4509539f9e7954e2");
	}
	self playloopsound(#"hash_4ac1d6c76c698e02");
	if(!self.monk_scream_vox)
	{
		self thread play_delayed_explode_vox();
	}
	waitresult = undefined;
	waitresult = self waittill(#"explode");
	level notify(#"grenade_exploded", waitresult.position, 100, 5000, 450);
	self stoploopsound();
	monkey_index = -1;
	for(i = 0; i < level.cymbal_monkeys.size; i++)
	{
		if(!isdefined(level.cymbal_monkeys[i]))
		{
			monkey_index = i;
			break;
		}
	}
	if(monkey_index >= 0)
	{
		arrayremoveindex(level.cymbal_monkeys, monkey_index);
	}
	for(i = 0; i < info.sound_attractors.size; i++)
	{
		if(isdefined(info.sound_attractors[i]))
		{
			info.sound_attractors[i] notify(#"monkey_blown_up");
		}
	}
}

/*
	Name: function_875fd1df
	Namespace: namespace_95574d51
	Checksum: 0xA65F7A3E
	Offset: 0x1E98
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_875fd1df()
{
	var_bdd70f6a = self.var_bdd70f6a;
	var_bdd70f6a thread scene::play(#"hash_2b352ec1d391daaa", var_bdd70f6a);
	while(isdefined(self))
	{
		waitframe(1);
	}
	if(isdefined(var_bdd70f6a))
	{
		var_bdd70f6a thread scene::stop();
	}
}

/*
	Name: play_delayed_explode_vox
	Namespace: namespace_95574d51
	Checksum: 0x39A5B6A5
	Offset: 0x1F10
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function play_delayed_explode_vox()
{
	wait(6.5);
	if(isdefined(self))
	{
		self playsound(#"zmb_vox_monkey_explode");
	}
}

/*
	Name: get_thrown_monkey
	Namespace: namespace_95574d51
	Checksum: 0x77E4F217
	Offset: 0x1F50
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function get_thrown_monkey()
{
	self endon(#"starting_monkey_watch", #"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(weapon == level.weaponzmcymbalmonkey)
		{
			grenade.use_grenade_special_long_bookmark = 1;
			grenade.grenade_multiattack_bookmark_count = 1;
			grenade.weapon = weapon;
			return grenade;
		}
		waitframe(1);
	}
}

/*
	Name: monitor_zombie_groans
	Namespace: namespace_95574d51
	Checksum: 0xE6A62CBA
	Offset: 0x2030
	Size: 0x1B0
	Parameters: 1
	Flags: None
*/
function monitor_zombie_groans(info)
{
	self endon(#"explode");
	while(true)
	{
		if(!isdefined(self))
		{
			return;
		}
		if(!isdefined(self.attractor_array))
		{
			waitframe(1);
			continue;
		}
		for(i = 0; i < self.attractor_array.size; i++)
		{
			if(!isinarray(info.sound_attractors, self.attractor_array[i]))
			{
				if(isdefined(self.origin) && isdefined(self.attractor_array[i].origin))
				{
					if(distancesquared(self.origin, self.attractor_array[i].origin) < 250000)
					{
						if(!isdefined(info.sound_attractors))
						{
							info.sound_attractors = [];
						}
						else if(!isarray(info.sound_attractors))
						{
							info.sound_attractors = array(info.sound_attractors);
						}
						info.sound_attractors[info.sound_attractors.size] = self.attractor_array[i];
						self.attractor_array[i] thread play_zombie_groans();
					}
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: play_zombie_groans
	Namespace: namespace_95574d51
	Checksum: 0xAFA87B6C
	Offset: 0x21E8
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function play_zombie_groans()
{
	self endon(#"monkey_blown_up", #"death");
	while(true)
	{
		if(isdefined(self))
		{
			self playsound(#"zmb_vox_zombie_groan");
			wait(randomfloatrange(2, 3));
		}
		else
		{
			return;
		}
	}
}

/*
	Name: cymbal_monkey_exists
	Namespace: namespace_95574d51
	Checksum: 0x2ABAFF38
	Offset: 0x2270
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function cymbal_monkey_exists()
{
	return zm_weapons::is_weapon_included(level.weaponzmcymbalmonkey);
}

/*
	Name: is_on_navmesh
	Namespace: namespace_95574d51
	Checksum: 0x66B36B46
	Offset: 0x2298
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function is_on_navmesh(e_player)
{
	self endon(#"death");
	if(isdefined(e_player))
	{
		e_player endon(#"death");
		e_origin = e_player.origin;
	}
	else
	{
		e_origin = self.origin;
	}
	if(ispointonnavmesh(self.origin, 60) == 1)
	{
		self.var_45eaa114 = 1;
		return 1;
	}
	v_valid_point = getclosestpointonnavmesh(self.origin, 150, 12);
	if(isdefined(v_valid_point))
	{
		var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);
		if(!(isdefined(var_3fb36683) && var_3fb36683))
		{
			v_dir = vectornormalize(e_origin - self.origin);
			v_pos = self.origin + v_dir * 24;
			v_valid_point = getclosestpointonnavmesh(v_pos, 150, 12);
			if(isdefined(v_valid_point))
			{
				var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);
				if(!(isdefined(var_3fb36683) && var_3fb36683))
				{
					v_valid_point = undefined;
				}
			}
		}
	}
	if(isdefined(v_valid_point))
	{
		self.origin = v_valid_point;
		if(isdefined(self.var_bdd70f6a))
		{
			self.var_bdd70f6a.origin = self.origin;
			self.var_bdd70f6a clientfield::set("" + #"hash_60a7e5b79e8064a5", 1);
		}
		self.var_45eaa114 = 1;
		return 1;
	}
	self.var_45eaa114 = 0;
	return 0;
}

