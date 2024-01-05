// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_35598499769dbb3d;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;

#namespace zm_weap_ray_gun_mk2v;

/*
	Name: __init__system__
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x14AD1047
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"ray_gun_mk2v", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x1BAD242F
	Offset: 0x1B8
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_477ad229 = getweapon("ray_gun_mk2v");
	level.var_5bda3938 = getweapon("ray_gun_mk2v_upgraded");
	level.var_f3d38af6 = lightning_chain::create_lightning_chain_params();
	level.var_f3d38af6.max_arcs = 6;
	level.var_f3d38af6.max_enemies_killed = 7;
	level.var_f3d38af6.radius_start = 160;
	level.var_f3d38af6.head_gib_chance = 0;
	level.var_f3d38af6.network_death_choke = 4;
	level.var_f3d38af6.should_kill_enemies = 0;
	level.var_f3d38af6.no_fx = 1;
	level.var_f3d38af6.clientside_fx = 0;
	level.var_f3d38af6.str_mod = "MOD_ELECTROCUTED";
	callback::add_weapon_fired(level.var_477ad229, &on_weapon_fired);
	callback::add_weapon_fired(level.var_5bda3938, &on_weapon_fired);
	callback::function_4b58e5ab(&function_ae5c4e8b);
	callback::on_ai_killed(&on_ai_killed);
	clientfield::register("allplayers", "" + #"hash_15cff60ea68de320", 20000, 2, "int");
	clientfield::register("allplayers", "" + #"hash_7f4f3fbb9ccded2e", 20000, 1, "int");
	clientfield::register("actor", "" + #"hash_784061e6c2684e58", 20000, 1, "int");
	clientfield::register("actor", "" + #"hash_3b193ae69f9f4fac", 20000, 1, "counter");
	clientfield::register("actor", "" + #"ray_gun_mk2v_death", 20000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_278ec0c224a81e7", 20000, 1, "int");
	if(!isdefined(level.var_46a7950a))
	{
		level.var_46a7950a = new throttle();
		[[ level.var_46a7950a ]]->initialize(3, 0.1);
	}
}

/*
	Name: on_weapon_fired
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xFCC5D8F1
	Offset: 0x538
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function on_weapon_fired(weapon)
{
	if(self.var_1de56cc8 !== 1)
	{
		self.var_1de56cc8 = 1;
		if(weapon == level.var_5bda3938)
		{
			self clientfield::set("" + #"hash_15cff60ea68de320", 2);
		}
		else
		{
			self clientfield::set("" + #"hash_15cff60ea68de320", 1);
		}
		self clientfield::set("" + #"hash_7f4f3fbb9ccded2e", 1);
		self thread function_8d93c592(weapon);
		self thread function_f8fdc6ad(weapon);
	}
}

/*
	Name: on_ai_killed
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x210C27A6
	Offset: 0x640
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	if(function_4e923311(s_params.weapon))
	{
		self clientfield::set("" + #"ray_gun_mk2v_death", 1);
	}
}

/*
	Name: function_4e923311
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x77ED273D
	Offset: 0x6A0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_4e923311(weapon)
{
	return isdefined(weapon) && (weapon == level.var_477ad229 || weapon == level.var_5bda3938);
}

/*
	Name: function_8d93c592
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x29D08E36
	Offset: 0x6E8
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_8d93c592(w_curr)
{
	self endon(#"death", #"stop_damage");
	while(true)
	{
		v_position = self getweaponmuzzlepoint();
		v_forward = self getweaponforwarddir();
		a_trace = beamtrace(v_position, v_position + (v_forward * 20000), 1, self);
		var_1c218ece = a_trace[#"position"];
		/#
			function_7067b673(v_position, var_1c218ece, (1, 1, 0));
			render_debug_sphere(v_position, (1, 1, 0));
			render_debug_sphere(var_1c218ece, (1, 0, 0));
		#/
		if(isdefined(a_trace[#"entity"]))
		{
			e_last_target = a_trace[#"entity"];
			if(isdefined(e_last_target.var_6f84b820) && e_last_target.team !== #"allies" || isdefined(e_last_target.male_head))
			{
				self thread function_5c035588(e_last_target, var_1c218ece, w_curr);
			}
		}
		e_last_target = undefined;
		waitframe(1);
	}
}

/*
	Name: function_f8fdc6ad
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x4364454B
	Offset: 0x8B8
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_f8fdc6ad(w_curr)
{
	self endoncallback(&stop_beam, #"death");
	wait(0.1);
	while(zm_utility::is_player_valid(self) && self isfiring() && self getweaponammoclip(w_curr) > 0 && !self ismeleeing() && !self isswitchingweapons())
	{
		waitframe(1);
	}
	self stop_beam();
}

/*
	Name: stop_beam
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xCB572EDF
	Offset: 0x9A0
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function stop_beam(s_notify)
{
	self clientfield::set("" + #"hash_15cff60ea68de320", 0);
	self clientfield::set("" + #"hash_7f4f3fbb9ccded2e", 0);
	self.var_1de56cc8 = undefined;
	self notify(#"stop_damage");
}

/*
	Name: get_closest_tag
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x32EF7023
	Offset: 0xA20
	Size: 0x1CA
	Parameters: 1
	Flags: Linked, Private
*/
function private get_closest_tag(v_pos)
{
	if(!isdefined(level.gib_tags))
	{
		zombie_utility::init_gib_tags();
	}
	tag_closest = undefined;
	var_9aabd9de = arraycopy(level.gib_tags);
	if(!isdefined(var_9aabd9de))
	{
		var_9aabd9de = [];
	}
	else if(!isarray(var_9aabd9de))
	{
		var_9aabd9de = array(var_9aabd9de);
	}
	if(!isinarray(var_9aabd9de, "j_head"))
	{
		var_9aabd9de[var_9aabd9de.size] = "j_head";
	}
	for(i = 0; i < var_9aabd9de.size; i++)
	{
		if(!isdefined(tag_closest))
		{
			tag_closest = var_9aabd9de[i];
			continue;
		}
		var_abe265db = self gettagorigin(var_9aabd9de[i]);
		var_2cd7818f = self gettagorigin(tag_closest);
		if(!isdefined(var_abe265db) || !isdefined(var_2cd7818f))
		{
			continue;
		}
		if(distancesquared(v_pos, var_abe265db) < distancesquared(v_pos, var_2cd7818f))
		{
			tag_closest = var_9aabd9de[i];
		}
	}
	return tolower(tag_closest);
}

/*
	Name: function_5c035588
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x64FAB0C0
	Offset: 0xBF8
	Size: 0x2EC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_5c035588(e_target, v_target_pos, w_curr, b_launched = 0, var_9a119ceb = 0)
{
	e_target endon(#"death");
	self endon(#"disconnect");
	if(!var_9a119ceb)
	{
		[[ level.var_46a7950a ]]->waitinqueue(e_target);
	}
	if(e_target.archetype === #"zombie")
	{
		str_hitloc = "torso_lower";
		str_tag = e_target get_closest_tag(v_target_pos);
		if(str_tag === "j_head")
		{
			str_hitloc = "head";
		}
	}
	else
	{
		str_hitloc = "head";
	}
	if(isdefined(level.headshots_only) && level.headshots_only && str_hitloc !== "head")
	{
		return;
	}
	n_damage = 250;
	if(w_curr == level.var_5bda3938)
	{
		n_damage = 500;
	}
	if(isalive(e_target))
	{
		if(isai(e_target))
		{
			e_target function_3ac73c92(self, w_curr == level.var_5bda3938);
		}
		e_target dodamage(n_damage, v_target_pos, self, self, str_hitloc, "MOD_UNKNOWN", 0, w_curr);
	}
	if(b_launched && (e_target.var_6f84b820 === #"basic" || e_target.var_6f84b820 === #"enhanced"))
	{
		n_random_x = randomfloatrange(-3, 3);
		n_random_y = randomfloatrange(-3, 3);
		v_fling = 200 * (vectornormalize((e_target.origin - v_target_pos) + (n_random_x, n_random_y, 100)));
		e_target zm_utility::function_ffc279(v_fling, self, undefined, w_curr);
	}
}

/*
	Name: function_3ac73c92
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x31ACD090
	Offset: 0xEF0
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_3ac73c92(e_player, b_upgraded)
{
	if(!isdefined(self.var_a8f3f795))
	{
		self.var_a8f3f795 = 0;
	}
	self.var_a8f3f795++;
	if(self.var_a8f3f795 >= 5)
	{
		self thread function_58fb8f5e(e_player, b_upgraded);
		self.var_a8f3f795 = 0;
		self notify(#"hash_3def847106434aab");
	}
	else
	{
		self thread function_3821f26e();
	}
}

/*
	Name: function_3821f26e
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xF7CB8264
	Offset: 0xF88
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_3821f26e()
{
	self notify(#"hash_3def847106434aab");
	self endon(#"death", #"hash_3def847106434aab");
	wait(1);
	self.var_a8f3f795 = 0;
}

/*
	Name: function_58fb8f5e
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x44D50920
	Offset: 0xFE0
	Size: 0x1E8
	Parameters: 2
	Flags: Linked
*/
function function_58fb8f5e(e_player, b_upgraded = 0)
{
	self endon(#"death");
	if(gettime() === self.spawn_time)
	{
		waitframe(1);
	}
	if(isdefined(self))
	{
		self clientfield::increment("" + #"hash_3b193ae69f9f4fac", 1);
	}
	if(!b_upgraded)
	{
		self function_2c08b6ac(e_player);
	}
	else
	{
		a_e_zombies = getaiteamarray(level.zombie_team);
		a_e_zombies = arraysortclosest(a_e_zombies, self getcentroid(), level.var_f3d38af6.max_arcs, 0, level.var_f3d38af6.radius_start);
		foreach(e_zombie in a_e_zombies)
		{
			e_zombie function_2c08b6ac(e_player);
			if(self != e_zombie)
			{
				level thread function_6f9fb9d7(self, e_zombie);
			}
		}
	}
	level notify(#"hash_4543ba0bff75332e", {#e_player:e_player});
}

/*
	Name: function_2c08b6ac
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x98FB1EE7
	Offset: 0x11D0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_2c08b6ac(e_player)
{
	if(!isalive(self))
	{
		return;
	}
	if(self ai::is_stunned() || (isdefined(self.var_6ee03e9a) && self.var_6ee03e9a))
	{
		return;
	}
	self.var_6ee03e9a = 1;
	self thread function_57f0555a(e_player);
}

/*
	Name: function_57f0555a
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xFCB5E4D4
	Offset: 0x1260
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_57f0555a(e_player)
{
	self endon(#"death");
	self clientfield::set("" + #"hash_784061e6c2684e58", 1);
	self lightning_chain::arc_damage_ent(e_player, 2, level.var_f3d38af6);
	wait(6);
	self thread function_ae5c4e8b();
}

/*
	Name: function_ae5c4e8b
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x8EF6215C
	Offset: 0x12F8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_ae5c4e8b()
{
	if(self.var_6ee03e9a === 1)
	{
		self.var_6ee03e9a = 0;
		self clientfield::set("" + #"hash_784061e6c2684e58", 0);
	}
}

/*
	Name: function_6f9fb9d7
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xE40011D4
	Offset: 0x1350
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_6f9fb9d7(e_source, e_target)
{
	level endon(#"game_ended");
	v_source = e_source getcentroid();
	v_target = e_target getcentroid();
	if(distancesquared(v_source, v_target) >= 4096)
	{
		e_fx = util::spawn_model("tag_origin", v_source);
		e_fx clientfield::set("" + #"hash_278ec0c224a81e7", 1);
		e_fx moveto(v_target, 0.11);
		e_fx waittill(#"movedone");
		e_fx delete();
	}
}

/*
	Name: render_debug_sphere
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0x9D8D840
	Offset: 0x1488
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function render_debug_sphere(origin, color)
{
	if(getdvarint(#"turret_debug_server", 0))
	{
		/#
			sphere(origin, 2, color, 0.75, 1, 10, 100);
		#/
	}
}

/*
	Name: function_7067b673
	Namespace: zm_weap_ray_gun_mk2v
	Checksum: 0xC8412F40
	Offset: 0x1500
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function function_7067b673(origin1, origin2, color)
{
	if(getdvarint(#"turret_debug_server", 0))
	{
		/#
			line(origin1, origin2, color, 0.75, 1, 100);
		#/
	}
}

