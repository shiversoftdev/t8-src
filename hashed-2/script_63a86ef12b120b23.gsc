// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_24c32478acf44108;
#using script_27c22e1d8df4d852;
#using script_2dc48f46bfeac894;
#using script_3f9e0dc8454d98e1;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_67272ed;

/*
	Name: function_89f2df9
	Namespace: namespace_67272ed
	Checksum: 0x25A1C890
	Offset: 0x2F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2aa13876578b1f89", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_67272ed
	Checksum: 0x4C63D089
	Offset: 0x340
	Size: 0x61C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"hash_70c8a5d240e431ec", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_dce196aefa0c9d", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_50aa88683b97ef09", 1, 1, "counter");
	clientfield::register("actor", "" + #"hash_18aecd09c861f097", 1, 1, "int");
	clientfield::register("vehicle", "" + #"hash_18aecd09c861f097", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"beacon_fx", 1, 1, "int");
	clientfield::register("allplayers", "" + #"skull_turret_beam_fire", 1, 2, "int");
	clientfield::register("allplayers", "" + #"hash_6635e6da6fcfe594", 1, 2, "int");
	clientfield::register("toplayer", "" + #"hash_2964d1cb7c4bd175", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_412d8d5f8625ca52", 1, 1, "int");
	clientfield::register("toplayer", "" + #"scepter_rumble", 1, 3, "counter");
	level.hero_weapon[#"scepter"][0] = getweapon(#"hash_50f35e4cfb775e02");
	level.hero_weapon[#"scepter"][1] = getweapon(#"hash_50f35d4cfb775c4f");
	level.hero_weapon[#"scepter"][2] = getweapon(#"hash_50f35c4cfb775a9c");
	zm_loadout::register_hero_weapon_for_level(#"hash_50f35e4cfb775e02");
	zm_loadout::register_hero_weapon_for_level(#"hash_50f35d4cfb775c4f");
	zm_loadout::register_hero_weapon_for_level(#"hash_50f35c4cfb775a9c");
	zm_hero_weapon::function_7a394ec4("scepter", 0, 4000, 7000);
	zm_spawner::register_zombie_death_event_callback(&function_cc91b3fe);
	zm_perks::register_lost_perk_override(&function_3a00c0a6);
	callback::on_connect(&on_connect);
	callback::on_disconnect(&on_player_disconnect);
	callback::on_bleedout(&function_f47257d7);
	callback::on_revived(&function_f47257d7);
	callback::on_bleedout(&function_37946a1d);
	namespace_9ff9f642::register_slowdown(#"hash_6c580993aa401a5b", 0.6, 3);
	namespace_9ff9f642::register_slowdown(#"hash_449bc314b0c3da73", 0.4, 3);
	namespace_9ff9f642::register_slowdown(#"hash_6c580f93aa40248d", 0.6, 5);
	namespace_9ff9f642::register_slowdown(#"hash_1cc2b03094ad09bd", 0.4, 5);
	namespace_9ff9f642::register_slowdown(#"hash_59b633ea4aeff841", 0.6, 0.5);
	if(!isdefined(level.var_cfeea502))
	{
		level.var_cfeea502 = new throttle();
		[[ level.var_cfeea502 ]]->initialize(3, 0.1);
	}
}

/*
	Name: on_connect
	Namespace: namespace_67272ed
	Checksum: 0x8935DADC
	Offset: 0x968
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self thread function_fa0a1b19();
	self thread function_717a1af2();
	self thread function_63e57124();
}

/*
	Name: function_63e57124
	Namespace: namespace_67272ed
	Checksum: 0x306E1FDB
	Offset: 0x9C0
	Size: 0x4D0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_63e57124()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_219c7081783c2153");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(wpn_prev == level.hero_weapon[#"scepter"][0] || wpn_prev == level.hero_weapon[#"scepter"][1] || wpn_prev == level.hero_weapon[#"scepter"][2])
		{
			self thread scepter_rumble(1);
			self clientfield::set("" + #"skull_turret_beam_fire", 0);
			self clientfield::set("" + #"hash_6635e6da6fcfe594", 0);
			self notify(#"stop_damage");
			if(wpn_prev == level.hero_weapon[#"scepter"][1])
			{
				self thread function_89fc5431();
			}
			else if(wpn_prev == level.hero_weapon[#"scepter"][2])
			{
				self thread function_89fc5431();
				level scene::function_f81475ae(#"p8_fxanim_zm_zod_staff_ra_bundle");
			}
		}
		if(wpn_cur == level.hero_weapon[#"scepter"][0])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_7ebea2becf0c1aee");
			self thread function_4521ac7e(wpn_cur, 1);
			self thread function_4493c71b(wpn_cur, 1);
			playrumbleonposition("grenade_rumble", self.origin);
		}
		else
		{
			if(wpn_cur == level.hero_weapon[#"scepter"][1])
			{
				zm_hero_weapon::show_hint(wpn_cur, #"hash_7ebea2becf0c1aee");
				self thread function_4521ac7e(wpn_cur, 2);
				self thread function_4493c71b(wpn_cur, 2);
				playrumbleonposition("grenade_rumble", self.origin);
				self thread function_eae0296b(#"hash_50f35d4cfb775c4f", 1);
			}
			else if(wpn_cur == level.hero_weapon[#"scepter"][2])
			{
				if(!self gamepadusedlast())
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_5ba4f6bd62a74330");
				}
				else
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_57c3251d6df56d4");
				}
				self.var_7e973e30 = wpn_prev;
				self thread function_4521ac7e(wpn_cur, 3);
				self thread function_4493c71b(wpn_cur, 3);
				self thread function_e874c3e1(wpn_cur);
				playrumbleonposition("grenade_rumble", self.origin);
				self thread function_68ff89f7(wpn_cur);
				self thread function_eae0296b(#"hash_50f35c4cfb775a9c", 1);
			}
		}
	}
}

/*
	Name: function_304a3c9b
	Namespace: namespace_67272ed
	Checksum: 0x69561EDD
	Offset: 0xE98
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_304a3c9b(var_c34665fc)
{
	if(var_c34665fc === "hero_weapon_power_off" || var_c34665fc === "player_downed")
	{
		self clientfield::set("" + #"skull_turret_beam_fire", 0);
		self clientfield::set("" + #"hash_6635e6da6fcfe594", 0);
		self.var_1de56cc8 = undefined;
		self notify(#"stop_damage");
	}
}

/*
	Name: function_4521ac7e
	Namespace: namespace_67272ed
	Checksum: 0xA37C7F88
	Offset: 0xF40
	Size: 0x352
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4521ac7e(var_f2a06582, n_lvl)
{
	self endoncallback(&function_304a3c9b, #"hash_219c7081783c2153", #"player_downed", #"disconnect", #"hero_weapon_power_off");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee_power");
		if(s_result.weapon !== var_f2a06582)
		{
			continue;
		}
		if(!namespace_6b49f66b::function_5fbf572(var_f2a06582))
		{
			continue;
		}
		v_flash_pos = self gettagorigin("tag_flash");
		if(!isdefined(v_flash_pos) || (!(isdefined(bullettracepassed(self geteye(), v_flash_pos, 0, self)) && bullettracepassed(self geteye(), v_flash_pos, 0, self))))
		{
			continue;
		}
		self clientfield::set("" + #"skull_turret_beam_fire", n_lvl);
		self clientfield::set("" + #"hash_6635e6da6fcfe594", n_lvl);
		self.var_1de56cc8 = 1;
		self thread function_be8ae52f(var_f2a06582);
		self notify(#"hash_7d855302d88c6701", {#weapon:var_f2a06582});
		wait(0.1);
		var_43b42a60 = 1;
		do
		{
			waitframe(1);
			var_43b42a60 = var_43b42a60 - (float(function_60d95f53()) / 1000);
			if(var_43b42a60 <= 0)
			{
				self notify(#"hash_7d855302d88c6701", {#weapon:var_f2a06582});
				var_43b42a60 = 1;
			}
		}
		while(zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed());
		self clientfield::set("" + #"skull_turret_beam_fire", 0);
		self clientfield::set("" + #"hash_6635e6da6fcfe594", 0);
		self.var_1de56cc8 = undefined;
		self notify(#"stop_damage");
	}
}

/*
	Name: function_4493c71b
	Namespace: namespace_67272ed
	Checksum: 0x69B35F8A
	Offset: 0x12A0
	Size: 0xE8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4493c71b(weapon, n_lvl = 1)
{
	self endon(#"hash_219c7081783c2153", #"bled_out", #"disconnect");
	while(true)
	{
		if(n_lvl < 3)
		{
			self waittill(#"weapon_melee_power_left", #"weapon_melee");
		}
		else
		{
			self waittill(#"weapon_melee_power_left");
		}
		if(!namespace_6b49f66b::function_5fbf572(weapon, 1))
		{
			continue;
		}
		weapon thread function_6dfe361b(self);
	}
}

/*
	Name: function_eae0296b
	Namespace: namespace_67272ed
	Checksum: 0x6BFDC1E6
	Offset: 0x1390
	Size: 0xCA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_eae0296b(var_65b6e624, b_postfx = 0)
{
	if(b_postfx)
	{
		self clientfield::increment_to_player("" + #"hash_2964d1cb7c4bd175");
	}
	self.var_a0a1475c = 1;
	self notify(#"hash_11d4cfae418fcfe1");
	switch(var_65b6e624)
	{
		case "hash_50f35c4cfb775a9c":
		{
			self.var_5762241e = 35;
			break;
		}
		default:
		{
			self.var_5762241e = 30;
			break;
		}
	}
}

/*
	Name: function_89fc5431
	Namespace: namespace_67272ed
	Checksum: 0x6BA7E555
	Offset: 0x1468
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
function private function_89fc5431()
{
	self.var_5762241e = undefined;
	self.var_a0a1475c = undefined;
}

/*
	Name: function_e874c3e1
	Namespace: namespace_67272ed
	Checksum: 0x891611D3
	Offset: 0x1488
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e874c3e1(weapon)
{
	self endon(#"hash_219c7081783c2153", #"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee");
		if(!namespace_6b49f66b::function_5fbf572(weapon))
		{
			continue;
		}
		if(s_result.weapon == weapon)
		{
			self thread function_b603ab34(weapon);
		}
	}
}

/*
	Name: blood_death_fx
	Namespace: namespace_67272ed
	Checksum: 0xD53B807A
	Offset: 0x1538
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
function private blood_death_fx(var_14ef0a6c)
{
}

/*
	Name: function_fe3f086c
	Namespace: namespace_67272ed
	Checksum: 0x5EB9500F
	Offset: 0x1560
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_fe3f086c(e_target, weapon = level.weaponnone)
{
	if(isactor(e_target))
	{
		self chop_actor(e_target, weapon);
	}
	else
	{
		self function_5e2c9b64(e_target, weapon);
	}
}

/*
	Name: chop_actor
	Namespace: namespace_67272ed
	Checksum: 0x2376F3AF
	Offset: 0x15E8
	Size: 0x254
	Parameters: 2
	Flags: Linked
*/
function chop_actor(e_target, weapon = level.weaponnone)
{
	self endon(#"hash_219c7081783c2153", #"bled_out", #"disconnect");
	if(!isalive(e_target))
	{
		return;
	}
	if(!isdefined(e_target.var_6f84b820))
	{
		return;
	}
	switch(e_target.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		case "enhanced":
		{
			n_damage = e_target.health;
			break;
		}
		case "heavy":
		{
			n_damage = int(e_target.maxhealth * 0.25);
			break;
		}
		case "miniboss":
		{
			n_damage = int(e_target.maxhealth * 0.15);
			break;
		}
		case "boss":
		{
			n_damage = 3000;
		}
	}
	if(n_damage >= e_target.health)
	{
		e_target.ignoremelee = 1;
	}
	e_target thread zm_hero_weapon::function_acee2761();
	[[ level.var_cfeea502 ]]->waitinqueue(e_target);
	if(isalive(e_target))
	{
		e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
		e_target blood_death_fx();
	}
	util::wait_network_frame();
}

/*
	Name: function_5e2c9b64
	Namespace: namespace_67272ed
	Checksum: 0x9E69287
	Offset: 0x1848
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_5e2c9b64(e_target, weapon)
{
	e_target endon(#"death");
	[[ level.var_cfeea502 ]]->waitinqueue(e_target);
	e_target dodamage(3000, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
}

/*
	Name: function_286a8d10
	Namespace: namespace_67272ed
	Checksum: 0xD965BF7B
	Offset: 0x18D0
	Size: 0x2E6
	Parameters: 1
	Flags: Linked
*/
function function_286a8d10(weapon = level.weaponnone)
{
	view_pos = self getweaponmuzzlepoint();
	forward_view_angles = self getweaponforwarddir();
	var_537e767d = 130 * 130;
	self clientfield::increment("" + #"hash_dce196aefa0c9d");
	a_e_targets = zm_hero_weapon::function_7c3681f7();
	var_f3edb3a6 = 0;
	foreach(e_target in a_e_targets)
	{
		if(!isdefined(e_target) || !isalive(e_target))
		{
			continue;
		}
		test_origin = e_target getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		dist_to_check = var_537e767d;
		if(dist_sq > dist_to_check)
		{
			continue;
		}
		normal = vectornormalize(test_origin - view_pos);
		dot = vectordot(forward_view_angles, normal);
		if(dot <= 0)
		{
			continue;
		}
		if(0 == e_target damageconetrace(view_pos, self))
		{
			continue;
		}
		e_target.chopped = 1;
		if(!var_f3edb3a6)
		{
			self clientfield::increment("" + #"hash_70c8a5d240e431ec");
			var_f3edb3a6 = 1;
		}
		if(isdefined(e_target.var_73973410))
		{
			self thread [[e_target.var_73973410]](e_target, self, weapon);
		}
		else
		{
			self thread scepter_rumble(3);
			self thread function_fe3f086c(e_target, weapon);
		}
		waitframe(1);
	}
}

/*
	Name: function_6dfe361b
	Namespace: namespace_67272ed
	Checksum: 0x7335183
	Offset: 0x1BC0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_6dfe361b(player)
{
	player thread scepter_rumble(2);
	player thread function_286a8d10(self);
}

/*
	Name: function_4e055c08
	Namespace: namespace_67272ed
	Checksum: 0x1A6EE741
	Offset: 0x1C08
	Size: 0x60
	Parameters: 2
	Flags: None
*/
function function_4e055c08(d, n)
{
	perp = 2 * vectordot(d, n);
	var_50ffa80c = d - (perp * n);
	return var_50ffa80c;
}

/*
	Name: function_be8ae52f
	Namespace: namespace_67272ed
	Checksum: 0x31DD69BD
	Offset: 0x1C70
	Size: 0x6B4
	Parameters: 1
	Flags: Linked
*/
function function_be8ae52f(var_f2a06582)
{
	self endon(#"death", #"stop_damage");
	switch(var_f2a06582.name)
	{
		case "hash_50f35d4cfb775c4f":
		{
			n_base_damage = 150;
			var_c4d00e65 = 0.07;
			break;
		}
		case "hash_50f35c4cfb775a9c":
		{
			n_base_damage = 200;
			var_c4d00e65 = 0.1;
			break;
		}
		default:
		{
			n_base_damage = 100;
			var_c4d00e65 = 0.05;
			break;
		}
	}
	self thread function_254a7556();
	while(true)
	{
		var_24bae834 = 0;
		v_position = self getweaponmuzzlepoint();
		v_forward = self getweaponforwarddir();
		if(isdefined(level.var_1f1de1ef) && level.var_1f1de1ef)
		{
			a_trace = bullettrace(v_position, v_position + (v_forward * 20000), 1, self);
		}
		else
		{
			a_trace = beamtrace(v_position, v_position + (v_forward * 20000), 1, self);
		}
		var_1c218ece = a_trace[#"position"];
		/#
			function_7067b673(v_position, var_1c218ece, (1, 1, 0));
			render_debug_sphere(v_position, (1, 1, 0));
			render_debug_sphere(var_1c218ece, (1, 0, 0));
		#/
		if(isdefined(a_trace[#"entity"]))
		{
			e_last_target = a_trace[#"entity"];
			if(isdefined(e_last_target.var_6f84b820) && e_last_target.team !== #"allies")
			{
				if(namespace_6b49f66b::is_active(1))
				{
					self namespace_b22c99a5::function_97444b02();
					return;
				}
				if(!isdefined(e_last_target.maxhealth))
				{
					e_last_target.maxhealth = e_last_target.health;
				}
				switch(e_last_target.var_6f84b820)
				{
					case "heavy":
					case "miniboss":
					{
						if(isalive(e_last_target) & (!(isdefined(e_last_target.var_25cb9682) && e_last_target.var_25cb9682)))
						{
							if(!isdefined(e_last_target.var_1b6dab30))
							{
								e_last_target.var_1b6dab30 = self;
							}
							e_last_target thread function_97429d68(3);
						}
						n_damage = e_last_target.maxhealth * 0.02;
						break;
					}
					case "boss":
					{
						n_damage = 100;
						break;
					}
					case "popcorn":
					{
						n_damage = e_last_target.health + 100;
						break;
					}
					default:
					{
						var_24a53699 = var_c4d00e65 * e_last_target.health;
						n_damage = max(var_24a53699, n_base_damage);
						if(isactor(e_last_target) && (!(isdefined(e_last_target.var_61435d9) && e_last_target.var_61435d9)) && !namespace_6b49f66b::is_active(1))
						{
							e_last_target.var_4857363e = 1;
							e_last_target thread function_75e6e51c(5, self);
						}
					}
				}
				self scepter_rumble(6);
				self thread function_b67b2aff(e_last_target, n_damage, var_1c218ece, var_f2a06582);
			}
			else if(isplayer(e_last_target))
			{
				e_last_target thread function_1f6199f0(self);
			}
		}
		else
		{
			var_24bae834 = 0;
			switch(a_trace[#"surfacetype"])
			{
				case "glasscar":
				case "rock":
				case "metal":
				case "metalcar":
				case "glass":
				{
					var_24bae834 = 1;
					var_7a585212 = "reflective_geo";
					break;
				}
			}
		}
		level notify(#"hash_3e0895cd0cc16d2d", {#player:self});
		self notify(#"hash_3e0895cd0cc16d2d");
		e_last_target = undefined;
		waitframe(1);
		if(isdefined(level.var_2e32e0bb))
		{
			level notify(#"hero_weapon_hit", {#v_position:a_trace[#"position"], #hash_80e17549:self.currentweapon, #e_entity:a_trace[#"entity"], #player:self});
		}
	}
}

/*
	Name: function_b67b2aff
	Namespace: namespace_67272ed
	Checksum: 0xE0AEFD1C
	Offset: 0x2330
	Size: 0x29C
	Parameters: 6
	Flags: Linked, Private
*/
function private function_b67b2aff(e_target, n_damage, v_target_pos, w_hero, b_launched = 0, var_9a119ceb = 0)
{
	e_target endon(#"death");
	self endon(#"disconnect");
	if(!var_9a119ceb)
	{
		[[ level.var_cfeea502 ]]->waitinqueue(e_target);
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
	if(isalive(e_target))
	{
		e_target dodamage(int(n_damage), v_target_pos, self, self, str_hitloc, "MOD_BURNED", 0, w_hero);
	}
	if(b_launched && (e_target.var_6f84b820 === #"basic" || e_target.var_6f84b820 === #"enhanced"))
	{
		n_random_x = randomfloatrange(-3, 3);
		n_random_y = randomfloatrange(-3, 3);
		v_fling = 200 * (vectornormalize((e_target.origin - v_target_pos) + (n_random_x, n_random_y, 100)));
		e_target zm_utility::function_ffc279(v_fling, self, undefined, w_hero);
	}
}

/*
	Name: get_closest_tag
	Namespace: namespace_67272ed
	Checksum: 0x32A43911
	Offset: 0x25D8
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
	var_144ac6c7 = undefined;
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
		if(!isdefined(var_144ac6c7))
		{
			var_144ac6c7 = var_9aabd9de[i];
			continue;
		}
		var_abe265db = self gettagorigin(var_9aabd9de[i]);
		var_2cd7818f = self gettagorigin(var_144ac6c7);
		if(!isdefined(var_abe265db) || !isdefined(var_2cd7818f))
		{
			continue;
		}
		if(distancesquared(v_pos, var_abe265db) < distancesquared(v_pos, var_2cd7818f))
		{
			var_144ac6c7 = var_9aabd9de[i];
		}
	}
	return tolower(var_144ac6c7);
}

/*
	Name: function_254a7556
	Namespace: namespace_67272ed
	Checksum: 0xEF3EE162
	Offset: 0x27B0
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_254a7556()
{
	self endon(#"disconnect", #"laststand", #"stop_damage");
	while(true)
	{
		self thread scepter_rumble(5);
		wait(0.5);
	}
}

/*
	Name: function_fa0a1b19
	Namespace: namespace_67272ed
	Checksum: 0x9E2AD778
	Offset: 0x2820
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_fa0a1b19()
{
	if(!isdefined(self.var_84f67244))
	{
		self.var_84f67244 = [];
	}
	s_revive_override = self zm_laststand::register_revive_override(&function_d5c9a81);
	if(!isdefined(self.var_84f67244))
	{
		self.var_84f67244 = [];
	}
	else if(!isarray(self.var_84f67244))
	{
		self.var_84f67244 = array(self.var_84f67244);
	}
	self.var_84f67244[self.var_84f67244.size] = s_revive_override;
}

/*
	Name: function_f47257d7
	Namespace: namespace_67272ed
	Checksum: 0x65B5539
	Offset: 0x28E0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_f47257d7(s_params)
{
	if(self != level)
	{
		if(isdefined(s_params))
		{
			e_revivee = s_params.e_revivee;
		}
		else
		{
			e_revivee = self;
		}
		e_revivee endon(#"death");
		e_revivee.get_revive_time = undefined;
		e_revivee.var_84280a99 = undefined;
		val::reset(#"hash_2aa13876578b1f89", "disable_health_regen_delay");
		e_revivee.var_4fc8bf2a = undefined;
		wait(0.2);
		e_revivee.var_fbc66a96 = undefined;
		if(e_revivee clientfield::get("" + #"hash_412d8d5f8625ca52"))
		{
			if(isdefined(e_revivee))
			{
				e_revivee clientfield::set("" + #"hash_412d8d5f8625ca52", 0);
			}
		}
	}
}

/*
	Name: function_37946a1d
	Namespace: namespace_67272ed
	Checksum: 0x47EC3C0F
	Offset: 0x2A10
	Size: 0x1F0
	Parameters: 1
	Flags: Linked
*/
function function_37946a1d(s_params)
{
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		player.n_level = player clientfield::get("" + #"hash_6635e6da6fcfe594");
		if(player.n_level)
		{
			player clientfield::set("" + #"hash_6635e6da6fcfe594", 0);
		}
	}
	waitframe(1);
	foreach(player in level.players)
	{
		if(zm_utility::is_player_valid(player) && (isdefined(player.var_1de56cc8) && player.var_1de56cc8) && isdefined(player.n_level))
		{
			player clientfield::set("" + #"hash_6635e6da6fcfe594", player.n_level);
		}
	}
}

/*
	Name: function_d5c9a81
	Namespace: namespace_67272ed
	Checksum: 0xF8FAD3F3
	Offset: 0x2C08
	Size: 0x1B8
	Parameters: 1
	Flags: Linked
*/
function function_d5c9a81(e_revivee)
{
	if(!isdefined(e_revivee.revivetrigger))
	{
		return false;
	}
	if(!isalive(self))
	{
		return false;
	}
	if(isdefined(e_revivee.var_4fc8bf2a) && e_revivee.var_4fc8bf2a)
	{
		return true;
	}
	if(self laststand::player_is_in_laststand() && !isdefined(self.var_6d772cb))
	{
		return false;
	}
	if(self.team != e_revivee.team)
	{
		return false;
	}
	if(isdefined(self.is_zombie) && self.is_zombie)
	{
		return false;
	}
	if(isdefined(self.var_7b2f6755) && self.var_7b2f6755)
	{
		return false;
	}
	if(isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10)
	{
		return true;
	}
	if(isdefined(level.can_revive) && ![[level.can_revive]](e_revivee))
	{
		return false;
	}
	if(isdefined(level.can_revive_game_module) && ![[level.can_revive_game_module]](e_revivee))
	{
		return false;
	}
	if(e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area())
	{
		return false;
	}
	return false;
}

/*
	Name: function_1f6199f0
	Namespace: namespace_67272ed
	Checksum: 0x99021D5E
	Offset: 0x2DC8
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_1f6199f0(e_reviver)
{
	self endon(#"disconnect");
	self notify("7e2848503b1eac4d");
	self endon("7e2848503b1eac4d");
	if(self laststand::player_is_in_laststand() && (!(isdefined(self.var_ea7ea155) && self.var_ea7ea155)))
	{
		self function_fa095da6(e_reviver);
	}
	else
	{
		val::set(#"hash_2aa13876578b1f89", "disable_health_regen_delay", 1);
		if(self.health < self.var_66cb03ad)
		{
			n_health_regen = int(self.health + 5);
			self.health = math::clamp(n_health_regen, 1, self.var_66cb03ad);
			self clientfield::increment("" + #"hash_50aa88683b97ef09", 1);
			e_reviver.var_ec334996 = e_reviver.var_ec334996 + 1;
		}
	}
	waitframe(1);
	val::reset(#"hash_2aa13876578b1f89", "disable_health_regen_delay");
}

/*
	Name: function_fa095da6
	Namespace: namespace_67272ed
	Checksum: 0xBFF9B49E
	Offset: 0x2F60
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_fa095da6(e_reviver)
{
	if(!(isdefined(self.var_4fc8bf2a) && self.var_4fc8bf2a) && (!(isdefined(self.var_7b2f6755) && self.var_7b2f6755)))
	{
		if(self != e_reviver)
		{
			e_reviver.var_ec334996 = e_reviver.var_ec334996 + 100;
			e_reviver zm_stats::increment_challenge_stat(#"hash_5f629a09731f538c", undefined, 1);
		}
		self.get_revive_time = &override_revive_time;
		self.var_84280a99 = e_reviver;
		self.var_4fc8bf2a = 1;
		self.var_fbc66a96 = 1;
		self clientfield::set("" + #"hash_412d8d5f8625ca52", 1);
	}
}

/*
	Name: override_revive_time
	Namespace: namespace_67272ed
	Checksum: 0x2D73E606
	Offset: 0x3068
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function override_revive_time(e_revivee)
{
	n_time = 3;
	if(self hasperk(#"specialty_quickrevive"))
	{
		n_time = n_time / 4;
	}
	else
	{
		n_time = n_time / 2;
	}
	return n_time;
}

/*
	Name: function_97429d68
	Namespace: namespace_67272ed
	Checksum: 0xFCBECA49
	Offset: 0x30D8
	Size: 0x206
	Parameters: 1
	Flags: Linked
*/
function function_97429d68(n_time = 5)
{
	self endon(#"death");
	self notify("67db915a1a3257ee");
	self endon("67db915a1a3257ee");
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	self.var_25cb9682 = 1;
	if(n_time == 5)
	{
		if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
		{
			self thread namespace_9ff9f642::slowdown(#"hash_1cc2b03094ad09bd");
		}
		else
		{
			self thread namespace_9ff9f642::slowdown(#"hash_6c580f93aa40248d");
		}
	}
	else
	{
		if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
		{
			self thread namespace_9ff9f642::slowdown(#"hash_449bc314b0c3da73");
		}
		else
		{
			self thread namespace_9ff9f642::slowdown(#"hash_6c580993aa401a5b");
		}
	}
	self clientfield::set("" + #"hash_18aecd09c861f097", 1);
	wait(n_time);
	if(!(isdefined(self.var_693f4e69) && self.var_693f4e69))
	{
		self clientfield::set("" + #"hash_18aecd09c861f097", 0);
	}
	self.var_25cb9682 = 0;
	self.var_1b6dab30 = undefined;
}

/*
	Name: function_75e6e51c
	Namespace: namespace_67272ed
	Checksum: 0x11E3F58D
	Offset: 0x32E8
	Size: 0x1FE
	Parameters: 2
	Flags: Linked
*/
function function_75e6e51c(n_time = 5, e_attacker)
{
	self endon(#"hash_6b85fa3a80afb815", #"death");
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	if(isdefined(self.var_61435d9) && self.var_61435d9)
	{
		return;
	}
	n_damage = ceil(self.maxhealth / ((n_time * 2) / 0.5));
	self.var_61435d9 = 1;
	if(n_time == 5)
	{
		self thread namespace_9ff9f642::slowdown(#"hash_6c580f93aa40248d");
	}
	else
	{
		self thread namespace_9ff9f642::slowdown(#"hash_6c580993aa401a5b");
	}
	self clientfield::set("" + #"hash_18aecd09c861f097", 1);
	for(x = 0; x < n_time / 0.5; x++)
	{
		wait(0.5);
		[[ level.var_cfeea502 ]]->waitinqueue(self);
		self dodamage(n_damage, self.origin, e_attacker, e_attacker);
	}
	self clientfield::set("" + #"hash_18aecd09c861f097", 0);
	self.var_61435d9 = 0;
}

/*
	Name: function_717a1af2
	Namespace: namespace_67272ed
	Checksum: 0x52FA7B70
	Offset: 0x34F0
	Size: 0x19C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_717a1af2()
{
	self endon(#"bled_out", #"death", #"beacon_expired");
	w_beacon = getweapon(#"hash_50f35c4cfb775a9c");
	self function_1728db6f(0);
	self.var_d6fe2916 = 0;
	self.disable_hero_power_charging = 0;
	self.var_d8eb19f5 = 0;
	self thread reset_after_bleeding_out();
	do
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_4078956b159dd0f3");
	}
	while(var_be17187b.weapon != w_beacon);
	if(isdefined(self.var_165b5fce))
	{
		self gadgetpowerset(self gadgetgetslot(w_beacon), self.var_165b5fce);
		self.saved_spike_power = undefined;
	}
	else
	{
		self gadgetpowerset(self gadgetgetslot(w_beacon), 100);
	}
	self.var_b4e3db6c = undefined;
	self thread weapon_drop_watcher();
	self thread weapon_change_watcher();
}

/*
	Name: weapon_drop_watcher
	Namespace: namespace_67272ed
	Checksum: 0x17C911E4
	Offset: 0x3698
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function weapon_drop_watcher()
{
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_switch_started");
		if(zm_loadout::is_hero_weapon(var_be17187b.w_current))
		{
			self setweaponammoclip(var_be17187b.w_current, 0);
		}
	}
}

/*
	Name: weapon_change_watcher
	Namespace: namespace_67272ed
	Checksum: 0x59B0C26D
	Offset: 0x3728
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function weapon_change_watcher()
{
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_219c7081783c2153");
		if(isdefined(var_be17187b.w_previous) && zm_loadout::is_hero_weapon(var_be17187b.w_current))
		{
			self.var_7e973e30 = var_be17187b.w_previous;
		}
	}
}

/*
	Name: reset_after_bleeding_out
	Namespace: namespace_67272ed
	Checksum: 0x84DC9735
	Offset: 0x37B8
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function reset_after_bleeding_out()
{
	self endon(#"disconnect");
	w_beacon = getweapon(#"hash_50f35c4cfb775a9c");
	if(isdefined(self.var_8a5094fe) && self.var_8a5094fe)
	{
		util::wait_network_frame();
		self zm_weapons::weapon_give(w_beacon, 0, 1);
		self function_1728db6f(2);
	}
	self waittill(#"bled_out");
	if(self hasweapon(w_beacon))
	{
		self.var_8a5094fe = 1;
		self.var_3d89e839 = self gadgetpowerget(self gadgetgetslot(w_beacon));
		if(self.var_3d89e839 >= 100)
		{
			self.var_3d89e839 = undefined;
		}
		self.var_4831c9c9[#"hash_50f35c4cfb775a9c"] = self getweaponammoclip(w_beacon);
	}
	if(isdefined(self.var_b4e3db6c))
	{
		zm_unitrigger::unregister_unitrigger(self.var_b4e3db6c);
		self.var_b4e3db6c = undefined;
	}
	self waittill(#"spawned_player");
	self thread function_717a1af2();
}

/*
	Name: function_22bebb6b
	Namespace: namespace_67272ed
	Checksum: 0x4DF6B3C1
	Offset: 0x3980
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_22bebb6b()
{
	if(isdefined(level.var_2358785f))
	{
		return self [[level.var_2358785f]]();
	}
	if(ispointonnavmesh(self.origin, self))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b603ab34
	Namespace: namespace_67272ed
	Checksum: 0xE90289C7
	Offset: 0x39D8
	Size: 0x38E
	Parameters: 1
	Flags: Linked
*/
function function_b603ab34(w_beacon)
{
	self endoncallback(&function_d14a3750, #"disconnect");
	level scene::function_27f5972e(#"p8_fxanim_zm_zod_staff_ra_bundle");
	waitframe(14);
	self thread scepter_rumble(4);
	waitframe(1);
	if(!isdefined(self))
	{
		level scene::function_f81475ae(#"p8_fxanim_zm_zod_staff_ra_bundle");
		return;
	}
	if(self function_22bebb6b())
	{
		v_forward = anglestoforward(self.angles);
		v_spawn_pos = self.origin + vectorscale((0, 0, 1), 32);
		a_trace = physicstraceex(v_spawn_pos, v_spawn_pos + (v_forward * 24), vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), self);
		v_spawn_pos = v_spawn_pos + (v_forward * (a_trace[#"fraction"] * 24));
		var_4eaa1f4c = util::ground_position(v_spawn_pos, 1000, 12);
	}
	else
	{
		var_4eaa1f4c = self.origin + vectorscale((0, 0, 1), 12);
	}
	playrumbleonposition("grenade_rumble", self.origin);
	self function_f67f53a7(var_4eaa1f4c);
	self thread beacon_fx_on();
	self thread zm_hero_weapon::function_4e984e83(w_beacon, 0.13);
	self thread beacon_loop(w_beacon, var_4eaa1f4c);
	self.var_6d772cb = self.var_6afa034c;
	self.var_d6fe2916 = 1;
	var_1c136516 = self gadgetpowerget(level.var_a53a05b5);
	if(var_1c136516 > 5)
	{
		self thread function_d3dc001e(w_beacon);
		zm_utility::function_3e549e65();
		self waittill(#"beacon_off", #"beacon_retrieved", #"death", #"hash_2b69105d9436130a");
		zm_utility::function_b7e5029f();
	}
	if(isdefined(self))
	{
		self thread function_f168b337();
		self notify(#"beacon_retrieved");
		self ability_player::function_f2250880(w_beacon);
		self.var_6d772cb = undefined;
		self.var_d6fe2916 = 0;
		self.disable_hero_power_charging = 0;
		self notify(#"hash_2b69105d9436130a");
	}
}

/*
	Name: function_d14a3750
	Namespace: namespace_67272ed
	Checksum: 0xFD6D4BBE
	Offset: 0x3D70
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_d14a3750(var_c34665fc)
{
	if(isdefined(self.var_d6fe2916) && self.var_d6fe2916)
	{
		zm_utility::function_b7e5029f();
	}
}

/*
	Name: function_d3dc001e
	Namespace: namespace_67272ed
	Checksum: 0x88AAA125
	Offset: 0x3DB0
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function function_d3dc001e(w_beacon)
{
	self endoncallback(&function_e7e5d6f5, #"beacon_retrieved", #"death");
	self.var_80612bea = 1;
	while(true)
	{
		slot = self gadgetgetslot(w_beacon);
		n_power = self gadgetpowerget(slot);
		if(n_power <= 0)
		{
			break;
		}
		waitframe(1);
	}
	self notify(#"beacon_off");
	self.var_80612bea = 0;
}

/*
	Name: function_e7e5d6f5
	Namespace: namespace_67272ed
	Checksum: 0xC1206199
	Offset: 0x3E90
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_e7e5d6f5(var_5a5260d8)
{
	if(isdefined(self))
	{
		self notify(#"beacon_off");
		self.var_80612bea = 0;
	}
}

/*
	Name: function_f67f53a7
	Namespace: namespace_67272ed
	Checksum: 0x1C8A3526
	Offset: 0x3ED0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_f67f53a7(var_4eaa1f4c)
{
	if(!isdefined(self.var_6afa034c))
	{
		self.var_6afa034c = util::spawn_model(#"hash_22d226727b787ebf", var_4eaa1f4c);
	}
	self playsound(#"hash_178614dae860a551");
	self.var_6afa034c notsolid();
	self.var_6afa034c show();
	waitframe(1);
	if(!namespace_6b49f66b::is_active(1))
	{
		self.var_6afa034c thread beacon_smash(self);
	}
	self.var_6afa034c thread scene::play(#"p8_fxanim_zm_zod_staff_ra_bundle", self.var_6afa034c);
	if(isdefined(level.beacon_watcher))
	{
		[[level.beacon_watcher]](self.var_6afa034c);
	}
}

/*
	Name: beacon_smash
	Namespace: namespace_67272ed
	Checksum: 0x23EE0D9E
	Offset: 0x4008
	Size: 0x246
	Parameters: 1
	Flags: Linked
*/
function beacon_smash(player)
{
	a_ai_zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 240);
	a_ai_zombies = array::filter(a_ai_zombies, 0, &function_39c07);
	foreach(zombie in a_ai_zombies)
	{
		launch = isdefined(zombie.var_2f68be48) && zombie.var_2f68be48;
		if(isdefined(zombie.var_6f84b820))
		{
			switch(zombie.var_6f84b820)
			{
				case "popcorn":
				case "basic":
				case "enhanced":
				{
					player thread function_b67b2aff(zombie, zombie.health, self.origin, level.hero_weapon[#"scepter"][2], launch);
					break;
				}
				case "heavy":
				case "miniboss":
				{
					if(isalive(zombie) & (!(isdefined(zombie.var_25cb9682) && zombie.var_25cb9682)))
					{
						if(!isdefined(zombie.var_1b6dab30))
						{
							zombie.var_1b6dab30 = player;
						}
						zombie thread function_97429d68(3);
					}
				}
			}
		}
	}
}

/*
	Name: beacon_fx_on
	Namespace: namespace_67272ed
	Checksum: 0xC2285EFE
	Offset: 0x4258
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function beacon_fx_on()
{
	self.var_6afa034c clientfield::set("" + #"beacon_fx", 1);
	self thread beacon_rumble();
}

/*
	Name: beacon_fx_off
	Namespace: namespace_67272ed
	Checksum: 0x2CCE6B4F
	Offset: 0x42B8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function beacon_fx_off()
{
	if(isdefined(self))
	{
		self clientfield::set("" + #"beacon_fx", 0);
	}
}

/*
	Name: beacon_rumble
	Namespace: namespace_67272ed
	Checksum: 0x28DA2205
	Offset: 0x42F8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function beacon_rumble()
{
	self endon(#"disconnect", #"beacon_fx_off");
	while(isdefined(self.var_6afa034c))
	{
		self.var_6afa034c playrumbleonentity(#"hash_2bdce8ff08474d57");
		wait(0.5);
	}
}

/*
	Name: function_f168b337
	Namespace: namespace_67272ed
	Checksum: 0x829EDE99
	Offset: 0x4368
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_f168b337()
{
	if(isdefined(self.var_6afa034c))
	{
		var_6afa034c = self.var_6afa034c;
	}
	else
	{
		return;
	}
	foreach(e_player in level.players)
	{
		if(isdefined(e_player.var_bbff3b76))
		{
			arrayremovevalue(e_player.var_bbff3b76, var_6afa034c);
		}
	}
	var_6afa034c endon(#"death");
	var_6afa034c beacon_fx_off();
	var_6afa034c thread scene::stop(#"p8_fxanim_zm_zod_staff_ra_bundle");
	waitframe(1);
	var_6afa034c delete();
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"beacon_fx_off");
	self function_1728db6f(4);
	self function_eae0296b(#"hash_50f35c4cfb775a9c");
}

/*
	Name: beacon_loop
	Namespace: namespace_67272ed
	Checksum: 0xE92EF4F8
	Offset: 0x44D8
	Size: 0x180
	Parameters: 2
	Flags: Linked
*/
function beacon_loop(w_beacon, var_4eaa1f4c)
{
	self endon(#"beacon_retrieved", #"death", #"bled_out", #"disconnect");
	while(true)
	{
		slot = self gadgetgetslot(w_beacon);
		if(self gadgetpowerget(slot) > 0)
		{
			array::thread_all(level.players, &function_888d5bd9, self);
			if(!namespace_6b49f66b::is_active(1))
			{
				n_frame = self function_15c2525e(var_4eaa1f4c, 0.25);
				var_adaf2ccb = math::clamp(0.25 - (n_frame * 0.05), 0.05, 0.25);
			}
		}
		else if(1)
		{
			return;
		}
		if(!isdefined(var_adaf2ccb))
		{
			var_adaf2ccb = 0.25;
		}
		wait(var_adaf2ccb);
	}
}

/*
	Name: function_39c07
	Namespace: namespace_67272ed
	Checksum: 0xCDD0382B
	Offset: 0x4660
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_39c07(ai_enemy)
{
	b_callback_result = 1;
	if(isdefined(level.var_93b9a0db))
	{
		b_callback_result = [[level.var_93b9a0db]](ai_enemy);
	}
	return b_callback_result;
}

/*
	Name: function_15c2525e
	Namespace: namespace_67272ed
	Checksum: 0x270E7342
	Offset: 0x46B0
	Size: 0x15A
	Parameters: 2
	Flags: Linked
*/
function function_15c2525e(var_a7e57ef9, n_loop_time)
{
	self endon(#"disconnect");
	a_ai_zombies = zm_hero_weapon::function_7c3681f7();
	a_ai_zombies = array::get_all_closest(var_a7e57ef9, a_ai_zombies, undefined, undefined, 240);
	a_ai_zombies = array::filter(a_ai_zombies, 0, &function_39c07);
	n_count = 0;
	n_frames = 0;
	foreach(zombie in a_ai_zombies)
	{
		zombie beacon_check(self, var_a7e57ef9, n_loop_time);
		n_count++;
		if(n_count == 4)
		{
			waitframe(1);
			n_count = 0;
			n_frames++;
		}
	}
	return n_frames;
}

/*
	Name: beacon_check
	Namespace: namespace_67272ed
	Checksum: 0xC933C4B4
	Offset: 0x4818
	Size: 0x2BC
	Parameters: 3
	Flags: Linked
*/
function beacon_check(e_player, var_a7e57ef9, n_loop_time)
{
	e_player endon(#"beacon_retrieved", #"bled_out", #"death", #"disconnect");
	if(isalive(self) && isdefined(self.var_6f84b820))
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			case "miniboss":
			{
				n_damage = (self.maxhealth * 0.08) * n_loop_time;
				break;
			}
			case "boss":
			{
				n_damage = 100;
				break;
			}
			case "popcorn":
			{
				n_damage = self.health + 100;
				break;
			}
			default:
			{
				n_max_health = (isdefined(self.maxhealth) ? self.maxhealth : level.zombie_health);
				n_damage = ceil(n_max_health / (10 / n_loop_time));
				break;
			}
		}
		if(!isdefined(self.var_1b6dab30) || self.var_1b6dab30 == e_player)
		{
			e_player thread function_b67b2aff(self, n_damage, var_a7e57ef9, level.hero_weapon[#"scepter"][2]);
		}
		if(self.var_6f84b820 === #"basic" || self.var_6f84b820 === #"enhanced" && isalive(self) && isactor(self) && (!(isdefined(self.var_25cb9682) && self.var_25cb9682)) && !self function_dd070839())
		{
			if(!isdefined(self.var_1b6dab30))
			{
				self.var_1b6dab30 = e_player;
			}
			self thread function_97429d68();
		}
	}
}

/*
	Name: check_for_range_and_los
	Namespace: namespace_67272ed
	Checksum: 0xE710BC21
	Offset: 0x4AE0
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function check_for_range_and_los(v_attack_source, n_allowed_z_diff, n_radius_sq)
{
	if(isalive(self))
	{
		n_z_diff = self.origin[2] - v_attack_source[2];
		if(!isdefined(n_allowed_z_diff) || abs(n_z_diff) < n_allowed_z_diff)
		{
			if(distancesquared(self.origin, v_attack_source) < n_radius_sq)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_888d5bd9
	Namespace: namespace_67272ed
	Checksum: 0x54760F69
	Offset: 0x4BA0
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_888d5bd9(e_player)
{
	e_player endon(#"beacon_retrieved", #"bled_out", #"death");
	/#
		assert(isdefined(e_player));
	#/
	var_2a0066d5 = 57600;
	var_a7e57ef9 = e_player.var_6afa034c.origin;
	if(!isalive(self))
	{
		return;
	}
	if(self check_for_range_and_los(var_a7e57ef9, undefined, var_2a0066d5))
	{
		self thread function_4451b45f();
		if(self laststand::player_is_in_laststand())
		{
			self function_fa095da6(e_player);
		}
		if(!isdefined(self.var_bbff3b76))
		{
			self.var_bbff3b76 = [];
		}
		else if(!isarray(self.var_bbff3b76))
		{
			self.var_bbff3b76 = array(self.var_bbff3b76);
		}
		if(!isinarray(self.var_bbff3b76, e_player.var_6afa034c))
		{
			self.var_bbff3b76[self.var_bbff3b76.size] = e_player.var_6afa034c;
		}
	}
	else if(isdefined(self.var_bbff3b76) && isinarray(self.var_bbff3b76, e_player.var_6afa034c))
	{
		arrayremovevalue(self.var_bbff3b76, e_player.var_6afa034c);
		self function_f47257d7();
		self function_89fc5431();
	}
}

/*
	Name: function_3a00c0a6
	Namespace: namespace_67272ed
	Checksum: 0xFF951297
	Offset: 0x4DD0
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_3a00c0a6(perk)
{
	self thread zm_perks::function_b2dfd295(perk, &function_cd010531);
	return false;
}

/*
	Name: function_cd010531
	Namespace: namespace_67272ed
	Checksum: 0x51D2CD5D
	Offset: 0x4E10
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_cd010531(e_reviver, var_84280a99)
{
	if(isdefined(self.var_fbc66a96) && self.var_fbc66a96)
	{
		return 1;
	}
	if(self clientfield::get("" + #"hash_412d8d5f8625ca52"))
	{
		return 1;
	}
	return function_6dfa3b7a();
}

/*
	Name: function_4451b45f
	Namespace: namespace_67272ed
	Checksum: 0x6929D3F2
	Offset: 0x4E90
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_4451b45f()
{
	self endon(#"disconnect");
	self notify("50c5b852bd6ed496");
	self endon("50c5b852bd6ed496");
	self function_eae0296b(#"hash_50f35d4cfb775c4f");
	wait(0.3);
	self function_89fc5431();
}

/*
	Name: function_cc91b3fe
	Namespace: namespace_67272ed
	Checksum: 0xFC58DF02
	Offset: 0x4F10
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_cc91b3fe(e_attacker)
{
	if(!isactor(self) || !isvehicle(self))
	{
		return;
	}
	if(self clientfield::get("" + #"hash_18aecd09c861f097"))
	{
		self clientfield::set("" + #"hash_18aecd09c861f097", 0);
	}
}

/*
	Name: on_player_disconnect
	Namespace: namespace_67272ed
	Checksum: 0x277FBB1A
	Offset: 0x4FB8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	self thread function_f168b337();
}

/*
	Name: function_1728db6f
	Namespace: namespace_67272ed
	Checksum: 0x8255B649
	Offset: 0x4FE0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_1728db6f(var_6554d141)
{
	self.var_6adb7c8f = var_6554d141;
}

/*
	Name: function_6dfa3b7a
	Namespace: namespace_67272ed
	Checksum: 0x443399
	Offset: 0x5008
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_6dfa3b7a()
{
	return isdefined(self.var_bbff3b76) && self.var_bbff3b76.size;
}

/*
	Name: render_debug_sphere
	Namespace: namespace_67272ed
	Checksum: 0x7A0A6B81
	Offset: 0x5030
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
	Namespace: namespace_67272ed
	Checksum: 0xD69286E9
	Offset: 0x50A8
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

/*
	Name: scepter_rumble
	Namespace: namespace_67272ed
	Checksum: 0x26799781
	Offset: 0x5120
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function scepter_rumble(var_b2e05bae)
{
	if(var_b2e05bae)
	{
		switch(var_b2e05bae)
		{
			case 1:
			{
				self playrumbleonentity("zm_weap_special_activate_rumble");
				break;
			}
			case 2:
			{
				self clientfield::increment_to_player("" + #"scepter_rumble", 2);
				break;
			}
			case 3:
			{
				self playrumbleonentity("zm_weap_scepter_melee_hit_rumble");
				break;
			}
			case 4:
			{
				playrumbleonposition("zm_weap_scepter_plant_rumble", self.origin);
				break;
			}
			case 5:
			{
				self clientfield::increment_to_player("" + #"scepter_rumble", 5);
				break;
			}
			case 6:
			{
				self clientfield::increment_to_player("" + #"scepter_rumble", 6);
				break;
			}
		}
	}
}

/*
	Name: function_68ff89f7
	Namespace: namespace_67272ed
	Checksum: 0xD00820F4
	Offset: 0x52B0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(var_fe4f91c7)
{
	self endon(#"hash_219c7081783c2153", #"disconnect", #"bled_out");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee");
	if(s_result.weapon == var_fe4f91c7)
	{
		self thread zm_audio::create_and_play_dialog(#"hash_6a87c913e3ecd37a", #"scepter");
	}
}

