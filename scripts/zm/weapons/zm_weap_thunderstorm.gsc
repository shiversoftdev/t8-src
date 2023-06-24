// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using script_35598499769dbb3d;
#using scripts\weapons\deployable.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_weap_thunderstorm;

/*
	Name: __init__system__
	Namespace: zm_weap_thunderstorm
	Checksum: 0x9F73184E
	Offset: 0x1F0
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_thunderstorm", &__init__, &__main__, #"zm_weapons");
}

/*
	Name: __init__
	Namespace: zm_weap_thunderstorm
	Checksum: 0xF6639AE1
	Offset: 0x250
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_loadout::register_lethal_grenade_for_level(#"thunderstorm");
	clientfield::register("scriptmover", "" + #"aoe_indicator", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"electric_storm", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_7006a7d528a6f05c", 16000, 3, "int");
	clientfield::register("actor", "" + #"hash_51b05e5d116438a9", 16000, 3, "int");
	clientfield::register("actor", "" + #"hash_561a1fd86bc1a53a", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_43cf6c236d2e9ba", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_1187b848bf7868c5", 16000, 1, "int");
	weaponobjects::function_e6400478(#"thunderstorm", &function_72e5d54f, undefined);
	deployable::register_deployable(getweapon(#"thunderstorm"), &function_3b0168a9, undefined, undefined, #"hash_3b6c37d4718707a2");
	level.var_899f5cb = [];
	level.var_b3b0d9d7 = &function_cd366cf2;
	callback::on_connect(&function_6c5cb6e);
}

/*
	Name: __main__
	Namespace: zm_weap_thunderstorm
	Checksum: 0x2BE1F346
	Offset: 0x508
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.var_49d60273 = getweapon(#"thunderstorm");
	level.var_c9bbd599 = getweapon(#"thunderstorm");
	if(!function_d0671de3())
	{
		return;
	}
	level._effect[#"grenade_samantha_steal"] = #"zombie/fx_monkey_lightning_zmb";
	scene::add_scene_func("p8_fxanim_zm_zod_staff_ra_bundle", &function_f2cc0ca9, "play");
}

/*
	Name: function_f2cc0ca9
	Namespace: zm_weap_thunderstorm
	Checksum: 0x264A64D7
	Offset: 0x5E0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_f2cc0ca9(entities)
{
	level.var_bc5fecf1 = entities[#"prop 1"];
}

/*
	Name: function_72e5d54f
	Namespace: zm_weap_thunderstorm
	Checksum: 0xC83D12F8
	Offset: 0x618
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_72e5d54f(watcher)
{
	watcher.onspawn = &function_39a41e25;
	watcher.deleteonplayerspawn = 0;
	watcher.watchforfire = 1;
}

/*
	Name: function_6c5cb6e
	Namespace: zm_weap_thunderstorm
	Checksum: 0xE3B4DAB6
	Offset: 0x668
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function function_6c5cb6e()
{
	self endon(#"disconnect");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_change");
		wpn_cur = s_result.weapon;
		if(wpn_cur == getweapon(#"thunderstorm"))
		{
			self thread function_feb1573e();
		}
		else
		{
			self val::reset(#"pegasus_strike", "freezecontrols");
			self notify(#"hash_2938992396267cf3");
		}
	}
}

/*
	Name: function_feb1573e
	Namespace: zm_weap_thunderstorm
	Checksum: 0x267D635A
	Offset: 0x750
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_feb1573e()
{
	self notify(#"hash_2938992396267cf3");
	self endon(#"disconnect", #"hash_2938992396267cf3");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"grenade_fire", #"grenade_throw_cancelled");
		if(s_result.weapon == getweapon(#"thunderstorm"))
		{
			self val::reset(#"pegasus_strike", "freezecontrols");
		}
	}
}

/*
	Name: function_cf0a2056
	Namespace: zm_weap_thunderstorm
	Checksum: 0x78B0F161
	Offset: 0x828
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_cf0a2056()
{
	self notify("c644bc956afb928");
	self endon("c644bc956afb928");
	self endon(#"disconnect");
	self val::set(#"pegasus_strike", "freezecontrols", 1);
	wait(0.1);
	self val::reset(#"pegasus_strike", "freezecontrols");
}

/*
	Name: function_39a41e25
	Namespace: zm_weap_thunderstorm
	Checksum: 0xD5640669
	Offset: 0x8C0
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_39a41e25(watcher, player)
{
	self hide();
	var_285f353f = level [[level.var_b3b0d9d7]](self, player);
	if(var_285f353f)
	{
		self weaponobjects::onspawnuseweaponobject(watcher, player);
		player.var_7e19c3db = 1;
		player thread function_5f724c2e(self);
	}
	else
	{
		level thread function_5abeb589(self);
	}
}

/*
	Name: function_3b0168a9
	Namespace: zm_weap_thunderstorm
	Checksum: 0x4D375117
	Offset: 0x988
	Size: 0x25C
	Parameters: 3
	Flags: Linked
*/
function function_3b0168a9(v_origin, v_angles, player)
{
	if(isdefined(level.var_899f5cb) && level.var_899f5cb.size >= 2)
	{
		return false;
	}
	var_78e5d9d1 = (v_origin[0], v_origin[1], v_origin[2] + 40);
	trace = bullettrace(var_78e5d9d1, var_78e5d9d1 + (0, 0, 300 - 40), 0, player);
	if(trace[#"fraction"] < 1)
	{
		return false;
	}
	foreach(var_10d4f67d in level.var_899f5cb)
	{
		n_dist = distance(var_10d4f67d.var_f013d620, player.origin);
		if(n_dist < 600)
		{
			n_time = gettime() / 1000;
			dt = n_time - var_10d4f67d.n_created_time;
			if(dt > 2)
			{
				return false;
			}
		}
	}
	v_origin = getclosestpointonnavmesh(v_origin, 40, 24);
	if(isdefined(v_origin))
	{
		if(zm_utility::check_point_in_playable_area(v_origin) && zm_utility::check_point_in_enabled_zone(v_origin, 1))
		{
			if(!player fragbuttonpressed())
			{
				if(isdefined(player))
				{
					player thread function_cf0a2056();
				}
			}
			return true;
		}
	}
	return false;
}

/*
	Name: function_cd366cf2
	Namespace: zm_weap_thunderstorm
	Checksum: 0xDC28E4CF
	Offset: 0xBF0
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function function_cd366cf2(e_grenade, e_player)
{
	return true;
}

/*
	Name: function_5f724c2e
	Namespace: zm_weap_thunderstorm
	Checksum: 0xD3E9B8A1
	Offset: 0xC10
	Size: 0x48E
	Parameters: 1
	Flags: Linked
*/
function function_5f724c2e(e_grenade)
{
	if(!isdefined(e_grenade))
	{
		return;
	}
	self endon(#"death", #"disconnect");
	if(self laststand::player_is_in_laststand())
	{
		level thread function_5abeb589(e_grenade);
		return;
	}
	var_285f353f = level [[level.var_b3b0d9d7]](e_grenade, self);
	if(!var_285f353f)
	{
		level thread function_5abeb589(e_grenade);
		return;
	}
	weapon = e_grenade.weapon;
	var_f013d620 = e_grenade.origin;
	var_dd83e2c2 = undefined;
	e_grenade waittill(#"stationary");
	level thread function_5abeb589(e_grenade, 0);
	var_3fb36683 = 1;
	if(level.var_899f5cb.size >= 2)
	{
		var_3fb36683 = 0;
	}
	if(var_3fb36683)
	{
		if(zm_utility::check_point_in_enabled_zone(var_f013d620) && zm_utility::check_point_in_playable_area(var_f013d620))
		{
			var_3fb36683 = 1;
			var_dd83e2c2 = var_f013d620;
		}
	}
	if(var_3fb36683 && !isdefined(var_dd83e2c2))
	{
		var_dd83e2c2 = getclosestpointonnavmesh(self.origin, 40);
		if(!isdefined(var_dd83e2c2))
		{
			var_3fb36683 = 0;
		}
	}
	if(var_3fb36683 && !isdefined(var_dd83e2c2))
	{
		var_dd83e2c2 = getclosestpointonnavmesh(var_f013d620, 128, 40);
		if(!isdefined(var_dd83e2c2))
		{
			var_3fb36683 = 0;
		}
	}
	if(isdefined(var_dd83e2c2))
	{
		v_ground = undefined;
		v_trace = groundtrace(var_dd83e2c2 + vectorscale((0, 0, 1), 200), var_dd83e2c2 + (vectorscale((0, 0, -1), 2000)), 0, self, 1)[#"position"];
		v_on_navmesh = zm_utility::function_b0eeaada(v_trace);
		if(isdefined(v_on_navmesh))
		{
			v_ground = v_on_navmesh[#"point"];
		}
		if(isdefined(v_ground))
		{
			var_dd83e2c2 = v_ground;
		}
		else
		{
			var_3fb36683 = 0;
		}
	}
	if(var_3fb36683)
	{
		if(!isdefined(level.var_373fe23f))
		{
			level.var_373fe23f = 0;
		}
		level.var_373fe23f++;
		var_373fe23f = level.var_373fe23f;
		var_10d4f67d = level function_57011892(self);
		var_10d4f67d.var_373fe23f = var_373fe23f;
		var_10d4f67d.var_f013d620 = var_f013d620;
		var_10d4f67d.n_created_time = gettime() / 1000;
		level.var_899f5cb[level.var_899f5cb.size] = var_10d4f67d;
		level thread function_b603ab34(self, var_10d4f67d);
		var_10d4f67d thread function_6973e5e8(self getentitynumber() + 1, var_f013d620);
		var_10d4f67d thread function_72085d9();
		var_10d4f67d thread function_5d44b698(var_dd83e2c2);
		slot = self gadgetgetslot(weapon);
		self gadgetpowerreset(slot);
		self gadgetpowerset(slot, 0);
	}
	else
	{
		self thread grenade_stolen_by_sam(weapon);
	}
	self.var_7e19c3db = 0;
}

/*
	Name: function_5abeb589
	Namespace: zm_weap_thunderstorm
	Checksum: 0x986FEC0E
	Offset: 0x10A8
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_5abeb589(e_grenade, var_e6d102c0 = 1)
{
	if(!isdefined(e_grenade))
	{
		return;
	}
	e_grenade endon(#"death");
	if(var_e6d102c0)
	{
		e_grenade waittill(#"stationary");
	}
	if(isdefined(e_grenade.damagearea))
	{
		e_grenade.damagearea delete();
	}
	e_grenade delete();
}

/*
	Name: function_5d44b698
	Namespace: zm_weap_thunderstorm
	Checksum: 0x726CD1B9
	Offset: 0x1158
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_5d44b698(v_origin)
{
	var_14aca4c7 = util::spawn_model("tag_origin", v_origin);
	if(isdefined(var_14aca4c7))
	{
		var_14aca4c7.var_abfcb0d9 = 1;
		var_14aca4c7 zm_utility::create_zombie_point_of_interest(undefined, 16, 10000);
		var_14aca4c7 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, 8, 400, 1);
		var_14aca4c7.var_8305fd51 = #"thunderstorm";
		self waittill(#"hash_7a19b162c9e303dc");
		var_14aca4c7 delete();
	}
}

/*
	Name: function_b603ab34
	Namespace: zm_weap_thunderstorm
	Checksum: 0xEF3F7B35
	Offset: 0x1230
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function function_b603ab34(e_player, var_10d4f67d)
{
	level scene::function_27f5972e(#"p8_fxanim_zm_zod_staff_ra_bundle");
	e_player playsound(#"hash_178614dae860a551");
	if(isdefined(level.var_338bae81))
	{
		level thread [[level.var_338bae81]](e_player);
	}
	v_forward = anglestoforward(e_player.angles);
	v_pos = e_player.origin + (v_forward * 30);
	v_pos = util::ground_position(v_pos + vectorscale((0, 0, 1), 30), 1000, 12);
	mdl_temp = util::spawn_model(#"hash_30b0badbca0a10de", v_pos + (0, 0, -5), (0, 0, 0));
	waitframe(1);
	mdl_temp clientfield::set("" + #"hash_1187b848bf7868c5", 1);
	var_10d4f67d waittill(#"hash_7a19b162c9e303dc");
	mdl_temp delete();
}

/*
	Name: function_57011892
	Namespace: zm_weap_thunderstorm
	Checksum: 0x63BE43D6
	Offset: 0x13E0
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_57011892(e_player)
{
	var_10d4f67d = spawn("script_model", e_player.origin + vectorscale((0, 0, 1), 170));
	var_10d4f67d setmodel("c_t8_zmb_dlc2_pegasus_fb");
	var_10d4f67d notsolid();
	var_10d4f67d.player = e_player;
	var_10d4f67d thread function_77abe09b();
	return var_10d4f67d;
}

/*
	Name: function_77abe09b
	Namespace: zm_weap_thunderstorm
	Checksum: 0xA2B5DBF7
	Offset: 0x1488
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_77abe09b()
{
	self clientfield::set("" + #"hash_7006a7d528a6f05c", self.player getentitynumber() + 1);
	self thread scene::play("aib_zm_red_vign_peg_inair_flapattack_01", "loop", self);
	self clientfield::set("" + #"electric_storm", 1);
	self waittill(#"hash_7a19b162c9e303dc");
	self clientfield::set("" + #"electric_storm", 0);
	self clientfield::set("" + #"hash_7006a7d528a6f05c", 5);
	wait(0.1);
	self delete();
}

/*
	Name: function_4b198b8f
	Namespace: zm_weap_thunderstorm
	Checksum: 0xE79607EE
	Offset: 0x15C0
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_4b198b8f(a_ents)
{
	var_10d4f67d = a_ents[#"prop 1"];
	if(isdefined(var_10d4f67d))
	{
		var_10d4f67d thread scene::play("aib_zm_red_vign_peg_inair_flapattack_01", "loop", var_10d4f67d);
	}
}

/*
	Name: function_6973e5e8
	Namespace: zm_weap_thunderstorm
	Checksum: 0x535EDDA
	Offset: 0x1628
	Size: 0x152
	Parameters: 2
	Flags: Linked
*/
function function_6973e5e8(n_player_index, var_f013d620)
{
	self endon(#"hash_7a19b162c9e303dc");
	while(true)
	{
		self waittill(#"pegasus_clap");
		a_ai_zombies = self get_zombie_targets(var_f013d620);
		if(isdefined(a_ai_zombies) && a_ai_zombies.size)
		{
			for(i = 0; i < a_ai_zombies.size; i++)
			{
				if(isalive(a_ai_zombies[i]) && isdefined(a_ai_zombies[i].takedamage) && (!(isdefined(a_ai_zombies[i].aat_turned) && a_ai_zombies[i].aat_turned)) && isdefined(a_ai_zombies[i].var_6f84b820))
				{
					a_ai_zombies[i] thread function_9c1450b8(self, n_player_index);
					wait(0.1);
				}
			}
		}
	}
}

/*
	Name: function_3f08f8e9
	Namespace: zm_weap_thunderstorm
	Checksum: 0x323BFF95
	Offset: 0x1788
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_3f08f8e9(var_10d4f67d)
{
	if(!isdefined(self.var_534a42ac))
	{
		self.var_534a42ac = [];
	}
	foreach(var_56a585e8 in self.var_534a42ac)
	{
		if(var_56a585e8 == var_10d4f67d.var_373fe23f)
		{
			return true;
		}
	}
	self.var_534a42ac[self.var_534a42ac.size] = var_10d4f67d.var_373fe23f;
	self.var_45bfef99 = 1;
	return false;
}

/*
	Name: function_9c1450b8
	Namespace: zm_weap_thunderstorm
	Checksum: 0xD7BDE5A0
	Offset: 0x1860
	Size: 0x142
	Parameters: 2
	Flags: Linked
*/
function function_9c1450b8(var_10d4f67d, n_player_index)
{
	self endon(#"death");
	e_player = var_10d4f67d.player;
	self.var_45bfef99 = 1;
	switch(self.var_6f84b820)
	{
		case "heavy":
		case "miniboss":
		{
			var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 0.25, 1);
			var_5d7b4163 = zm_equipment::function_379f6b5d(500, var_b1c1c5cf, 1, 4, 50);
			self thread function_7c333a0f(var_10d4f67d, var_5d7b4163, n_player_index);
			break;
		}
		default:
		{
			self thread function_90c53706(var_10d4f67d, n_player_index);
			break;
		}
	}
}

/*
	Name: function_90c53706
	Namespace: zm_weap_thunderstorm
	Checksum: 0x381DED3A
	Offset: 0x19B0
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function function_90c53706(var_10d4f67d, n_player_index)
{
	self endon(#"death");
	e_player = var_10d4f67d.player;
	if(isdefined(e_player))
	{
		e_player endon(#"death");
	}
	self function_97429d68(n_player_index);
	if(self.archetype == #"zombie" || self.archetype == #"skeleton" || self.archetype == #"catalyst")
	{
		self playsound(#"hash_3fbc22745dc90009");
		gibserverutils::annihilate(self);
		self dodamage(self.health + 999, self.origin, e_player, e_player, "none", "MOD_UNKNOWN", 0, level.var_49d60273);
	}
}

/*
	Name: function_7c333a0f
	Namespace: zm_weap_thunderstorm
	Checksum: 0x48A91CA8
	Offset: 0x1B08
	Size: 0x110
	Parameters: 3
	Flags: Linked
*/
function function_7c333a0f(var_10d4f67d, var_5d7b4163, n_player_index)
{
	self endon(#"death");
	var_10d4f67d endon(#"death");
	e_player = var_10d4f67d.player;
	self thread function_54ad0847(var_10d4f67d);
	while(isalive(self))
	{
		self function_97429d68(n_player_index);
		self playsound(#"hash_3a99f739009a77fa");
		self dodamage(var_5d7b4163, self.origin, e_player, e_player, "none", "MOD_UNKNOWN", 0, level.var_49d60273);
		wait(0.5);
	}
}

/*
	Name: function_54ad0847
	Namespace: zm_weap_thunderstorm
	Checksum: 0xB9B07425
	Offset: 0x1C20
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_54ad0847(var_10d4f67d)
{
	self endon(#"death");
	var_10d4f67d waittill(#"hash_7a19b162c9e303dc");
	self.var_c6aafbdb = 0;
}

/*
	Name: get_zombie_targets
	Namespace: zm_weap_thunderstorm
	Checksum: 0xD898421E
	Offset: 0x1C68
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function get_zombie_targets(v_origin)
{
	a_ai_zombies = array::get_all_closest(v_origin, getaispeciesarray(level.zombie_team, "all"), undefined, 32, 500);
	var_45a4e11d = [];
	foreach(ai_zombie in a_ai_zombies)
	{
		if(self function_32b5113(ai_zombie))
		{
			if(!isdefined(var_45a4e11d))
			{
				var_45a4e11d = [];
			}
			else if(!isarray(var_45a4e11d))
			{
				var_45a4e11d = array(var_45a4e11d);
			}
			var_45a4e11d[var_45a4e11d.size] = ai_zombie;
		}
	}
	return var_45a4e11d;
}

/*
	Name: function_32b5113
	Namespace: zm_weap_thunderstorm
	Checksum: 0xC18547AE
	Offset: 0x1DA0
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_32b5113(ai_zombie)
{
	self endon(#"death");
	ai_zombie endon(#"death");
	n_dist = distance(self.origin, ai_zombie.origin);
	if(n_dist > 400)
	{
		return false;
	}
	if(!zm_utility::check_point_in_playable_area(ai_zombie.origin) || ai_zombie function_3f08f8e9(self))
	{
		return false;
	}
	if(isdefined(ai_zombie.var_69a981e6) && ai_zombie.var_69a981e6)
	{
		return false;
	}
	if(!isdefined(ai_zombie.var_6f84b820))
	{
		/#
			if(isdefined(ai_zombie.archetype))
			{
				println(("" + ai_zombie.archetype) + "");
			}
		#/
		return false;
	}
	return true;
}

/*
	Name: function_97429d68
	Namespace: zm_weap_thunderstorm
	Checksum: 0x8C692482
	Offset: 0x1EE0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_97429d68(n_player_index)
{
	self endon(#"death");
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	if(!(isdefined(self.var_c6aafbdb) && self.var_c6aafbdb))
	{
		self ai::stun();
		if(self.archetype == #"zombie")
		{
			function_6eac4ca1(self, "electrocute");
		}
	}
	self.var_c6aafbdb = 1;
	self clientfield::set("" + #"hash_51b05e5d116438a9", n_player_index);
	wait(0.3);
	self clientfield::set("" + #"hash_51b05e5d116438a9", 0);
	self.var_c6aafbdb = 0;
	self ai::function_62795e55();
}

/*
	Name: function_d0671de3
	Namespace: zm_weap_thunderstorm
	Checksum: 0xC06CDCEC
	Offset: 0x2018
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_d0671de3()
{
	return zm_weapons::is_weapon_included(level.var_49d60273);
}

/*
	Name: grenade_stolen_by_sam
	Namespace: zm_weap_thunderstorm
	Checksum: 0xA706735D
	Offset: 0x2040
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function grenade_stolen_by_sam(weapon)
{
	self thread zm_equipment::show_hint_text(#"hash_58c731d86f4eabed", 4, 1.75, 120);
	n_slot = self gadgetgetslot(weapon);
	self gadgetpowerset(n_slot, 100);
	self gadgetcharging(n_slot, 0);
}

/*
	Name: function_72085d9
	Namespace: zm_weap_thunderstorm
	Checksum: 0x9722B223
	Offset: 0x20E0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_72085d9()
{
	self waittilltimeout(30, #"hash_90cfd38343f41f2", #"death");
	self zm_utility::deactivate_zombie_point_of_interest();
	self notify(#"hash_7a19b162c9e303dc");
	arrayremovevalue(level.var_899f5cb, self);
}

