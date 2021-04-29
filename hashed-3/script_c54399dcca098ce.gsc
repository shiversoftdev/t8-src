// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1ef0852930d362dc;
#using script_3496aeeccaa9d66a;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_79c9122f9058e8ba;
#using script_b761c44ab2e5b46;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_1bf74f9e;

/*
	Name: function_89f2df9
	Namespace: namespace_1bf74f9e
	Checksum: 0x6FE9146E
	Offset: 0x4C0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_46962ccd84e04308", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1bf74f9e
	Checksum: 0x80FBBEE0
	Offset: 0x510
	Size: 0x404
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		clientfield::register("scriptmover", "" + #"hash_63ffcbb6c8f4bc11", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_62ee80337662b3cd", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_7ef82b98770c5c0d", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_c0e8acbde8dbc06", 8000, 1, "int");
		clientfield::register("vehicle", "" + #"hash_6ded20ebb8e016ba", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_48c6d058e9587c19", 8000, 1, "int");
		clientfield::register("world", "" + #"hash_19f5ea0e9b3d47f3", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_486960f190957256", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_12e4702a9346b3d9", 8000, 1, "int");
		clientfield::register("scriptmover", "" + #"ww_lvl3_crafting_table_fx", 8000, 1, "int");
		zm::register_vehicle_damage_callback(&function_e92f09d0);
		callback::on_vehicle_killed(&function_3da8da85);
		callback::on_actor_killed(&function_9a0471ab);
		level.var_27f4ef2f = &function_ee901070;
		level.var_8b14dbe3 = &function_1b4df249;
		level flag::init("bile_collected");
		level flag::init(#"hash_1d477cd627a495d9");
		level.var_e01d217e = 0;
		var_a70a763b = getentarray("ww_lvl3_quest_piece_on_table", "targetname");
		array::run_all(var_a70a763b, &hide);
		array::run_all(var_a70a763b, &notsolid);
		hidemiscmodels("ww_lvl3_quest_piece_on_table");
	}
}

/*
	Name: __main__
	Namespace: namespace_1bf74f9e
	Checksum: 0x72AC5737
	Offset: 0x920
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		level thread function_6e094214();
		level thread function_7b5a8c15();
		level thread function_bc8c390e();
		getweapon(#"zitem_chaos_lvl3_part_3").var_62a98b13 = #"hash_3b036955869eed34";
		namespace_a1d9b01d::function_d1f16587(#"zblueprint_chaos_lvl3", &function_8bca35b9);
		level thread function_25058256();
	}
}

/*
	Name: function_e92f09d0
	Namespace: namespace_1bf74f9e
	Checksum: 0x9972D4EF
	Offset: 0xA18
	Size: 0x16C
	Parameters: 15
	Flags: Linked
*/
function function_e92f09d0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(self.var_9cf26285) && self.var_9cf26285 && !level flag::get("flag_player_grabbed_catalyst_material"))
	{
		if(!isdefined(self.var_31fdb1f9))
		{
			self.var_31fdb1f9 = 0;
		}
		if(smeansofdeath === "MOD_PROJECTILE")
		{
			if(weapon === level.var_6fe89212 || weapon === level.var_74cf08b1)
			{
				self.var_31fdb1f9++;
				if(self.var_31fdb1f9 >= 1 || weapon === level.var_74cf08b1)
				{
					return self.health + 666;
				}
				self thread function_a8fd8406();
			}
		}
		return 0;
	}
	return idamage;
}

/*
	Name: function_3da8da85
	Namespace: namespace_1bf74f9e
	Checksum: 0x8BE2CFAD
	Offset: 0xB90
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_3da8da85(params)
{
	if(params.weapon === level.var_6fe89212 || params.weapon === level.var_74cf08b1 && params.smeansofdeath === "MOD_PROJECTILE")
	{
		if(isdefined(self.var_9cf26285) && self.var_9cf26285 && !level flag::get("flag_player_grabbed_catalyst_material"))
		{
			v_velocity = self function_58439640();
			if(isdefined(v_velocity))
			{
				function_e217ba73(self.origin, v_velocity);
			}
		}
	}
}

/*
	Name: function_e217ba73
	Namespace: namespace_1bf74f9e
	Checksum: 0xF2B93F07
	Offset: 0xC78
	Size: 0x32C
	Parameters: 2
	Flags: Linked
*/
function function_e217ba73(v_pos, v_velocity)
{
	var_26420508 = util::spawn_model(#"hash_6f97a0d9c769da03", v_pos);
	util::wait_network_frame();
	var_26420508 setscale(2);
	var_26420508 clientfield::set("" + #"hash_c0e8acbde8dbc06", 1);
	e_grenade = level.var_52d4b640 magicgrenadetype(getweapon(#"hash_34b7eb9fde56bd35"), v_pos + vectorscale((0, 0, 1), 16), v_velocity);
	e_grenade makegrenadedud();
	e_grenade ghost();
	e_grenade util::deleteaftertime(8);
	util::wait_network_frame();
	if(isdefined(e_grenade))
	{
		var_26420508.origin = e_grenade.origin;
		var_26420508 linkto(e_grenade, "tag_fx");
		while(true)
		{
			var_be17187b = undefined;
			var_be17187b = e_grenade waittill(#"death", #"grenade_bounce", #"grenade_stuck");
			if(var_be17187b._notify == "death")
			{
				break;
			}
			else if(var_be17187b._notify == "grenade_bounce")
			{
				/#
					iprintln("");
				#/
				var_1054c42f = function_68a875b(var_26420508.origin);
				if(isdefined(var_1054c42f) && distancesquared(var_1054c42f, var_26420508.origin) < 1024)
				{
					level.var_5f2726dc = var_1054c42f;
					break;
				}
			}
		}
	}
	if(!isdefined(level.var_5f2726dc))
	{
		level.var_5f2726dc = function_68a875b(var_26420508.origin);
	}
	if(isdefined(e_grenade))
	{
		e_grenade delete();
	}
	var_26420508 delete();
	level thread function_44a776ee();
}

/*
	Name: function_9a0471ab
	Namespace: namespace_1bf74f9e
	Checksum: 0xF3E53B71
	Offset: 0xFB0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_9a0471ab(params)
{
	if(self.archetype == #"hash_50f4e0eea9f4e4a4" && !level flag::get("bile_collected") && (isdefined(self.var_bd48b030) && self.var_bd48b030))
	{
		if(isdefined(self))
		{
			self thread function_cfffc455();
		}
	}
}

/*
	Name: function_6e094214
	Namespace: namespace_1bf74f9e
	Checksum: 0x2EEF8DAE
	Offset: 0x1040
	Size: 0x56E
	Parameters: 0
	Flags: Linked
*/
function function_6e094214()
{
	level waittill(#"hash_24c45fc7880ee4f0");
	level.var_c40da3d5 = struct::get_array("bat_catalyst_starter", "targetname");
	level.var_b7a0ccb2 = [];
	foreach(var_74f1c6f6 in level.var_c40da3d5)
	{
		if(!isdefined(level.var_b7a0ccb2))
		{
			level.var_b7a0ccb2 = [];
		}
		else if(!isarray(level.var_b7a0ccb2))
		{
			level.var_b7a0ccb2 = array(level.var_b7a0ccb2);
		}
		level.var_b7a0ccb2[level.var_b7a0ccb2.size] = struct::get(var_74f1c6f6.target, "targetname");
	}
	while(!level flag::get("flag_player_grabbed_catalyst_material"))
	{
		level.var_5f2726dc = undefined;
		level.var_52d4b640 clientfield::set("" + #"hash_7ef82b98770c5c0d", 0);
		b_success = function_fc4f1886();
		if(b_success)
		{
			s_spawn_loc = level.var_52d4b640.var_3bf1ec5a;
			level.var_52d4b640.origin = s_spawn_loc.origin;
			wait(0.2);
			level.var_52d4b640 clientfield::set("" + #"hash_7ef82b98770c5c0d", 1);
			wait(1);
			var_45acb524 = bat::function_2e37549f(1, s_spawn_loc);
			if(isdefined(var_45acb524))
			{
				var_45acb524.var_126d7bef = 1;
				var_45acb524.ignore_round_spawn_failsafe = 1;
				var_45acb524.ignore_enemy_count = 1;
				var_45acb524.b_ignore_cleanup = 1;
				var_45acb524.no_powerups = 1;
				var_45acb524 zm_score::function_acaab828();
				/#
					var_45acb524 thread function_fd7c6bd1();
				#/
				var_45acb524.ignore_nuke = 1;
				var_45acb524.var_9cf26285 = 1;
				var_ba8531b6 = struct::get_array(s_spawn_loc.script_noteworthy, "script_noteworthy");
				var_ba8531b6 = array::exclude(var_ba8531b6, level.var_b7a0ccb2);
				var_9427f9e7 = array::random(var_ba8531b6);
				var_45acb524 notify(#"change_state");
				var_45acb524 thread function_30210e26();
				var_45acb524 function_4999f099(var_9427f9e7);
				if(isalive(var_45acb524))
				{
					var_de7057ea = var_45acb524.origin + vectorscale((0, 0, 1), 640);
					level.var_52d4b640 clientfield::set("" + #"hash_7ef82b98770c5c0d", 0);
					var_45acb524 setspeed(var_45acb524.settings.defaultmovespeed);
					var_45acb524 function_a57c34b7(var_de7057ea, 0, 0);
					var_45acb524 vehlookat(var_de7057ea);
					var_45acb524 waittill(#"near_goal", #"death");
					level.var_52d4b640.origin = var_de7057ea;
					wait(0.2);
					level.var_52d4b640 clientfield::set("" + #"hash_7ef82b98770c5c0d", 1);
					if(isdefined(var_45acb524))
					{
						var_45acb524 delete();
					}
				}
			}
		}
		wait(90);
	}
}

/*
	Name: function_fc4f1886
	Namespace: namespace_1bf74f9e
	Checksum: 0x29CA38A6
	Offset: 0x15B8
	Size: 0x2F6
	Parameters: 0
	Flags: Linked
*/
function function_fc4f1886()
{
	level.var_c40da3d5 = array::randomize(level.var_c40da3d5);
	var_1fc5672 = 0;
	level.var_12469d5 = undefined;
	while(var_1fc5672 < 4)
	{
		level.var_52d4b640 thread function_6730d7f4(level.var_c40da3d5[var_1fc5672], var_1fc5672);
		var_be17187b = undefined;
		var_be17187b = level.var_52d4b640 waittill(#"hash_5806ee636b7dafda", #"hash_52349a04253a83b2", #"hash_2b1cabe38e2ce84b");
		if(var_be17187b._notify == #"hash_5806ee636b7dafda")
		{
			if(var_be17187b.index == var_1fc5672)
			{
				level.var_c40da3d5[var_1fc5672].mdl_fx clientfield::set("" + #"hash_12e4702a9346b3d9", 0);
				level.var_c40da3d5[var_1fc5672].mdl_fx delete();
				level.var_c40da3d5[var_1fc5672].t_damage delete();
				level.var_52d4b640.var_672fad63 = level.var_c40da3d5[var_1fc5672];
				var_1fc5672++;
				level.var_52d4b640 notify(#"hash_4c246c05db5c64bc");
				if(var_1fc5672 < 4)
				{
					level.var_52d4b640 thread function_927ac839();
				}
			}
			else
			{
				level.var_52d4b640 notify(#"hash_52349a04253a83b2");
				return 0;
			}
		}
		else
		{
			level.var_c40da3d5[var_1fc5672].mdl_fx clientfield::set("" + #"hash_12e4702a9346b3d9", 0);
			level.var_c40da3d5[var_1fc5672].mdl_fx delete();
			level.var_c40da3d5[var_1fc5672].t_damage delete();
			return 0;
		}
	}
	level.var_52d4b640.var_3bf1ec5a = struct::get(level.var_52d4b640.var_672fad63.target, "targetname");
	return 1;
}

/*
	Name: function_6730d7f4
	Namespace: namespace_1bf74f9e
	Checksum: 0x9B80AA43
	Offset: 0x18B8
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_6730d7f4(var_74f1c6f6, var_1fc5672)
{
	var_74f1c6f6.script_index = var_1fc5672;
	var_74f1c6f6.mdl_fx = util::spawn_model("tag_origin", var_74f1c6f6.origin);
	var_74f1c6f6.mdl_fx clientfield::set("" + #"hash_12e4702a9346b3d9", 1);
	var_74f1c6f6.t_damage = spawn("trigger_damage_new", var_74f1c6f6.origin, 0, 16, 16);
	self function_afb9c21c(var_74f1c6f6);
}

/*
	Name: function_afb9c21c
	Namespace: namespace_1bf74f9e
	Checksum: 0x5777AABE
	Offset: 0x1998
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function function_afb9c21c(var_74f1c6f6)
{
	self endon(#"hash_52349a04253a83b2", #"hash_2b1cabe38e2ce84b");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = var_74f1c6f6.t_damage waittill(#"damage");
		if(isdefined(var_be17187b.attacker) && (!isdefined(level.var_12469d5) || level.var_12469d5 == var_be17187b.attacker) && (var_be17187b.mod === "MOD_PROJECTILE" || var_be17187b.mod === "MOD_PROJECTILE_SPLASH") && (var_be17187b.weapon === level.var_6fe89212 || var_be17187b.weapon === level.var_74cf08b1))
		{
			level.var_12469d5 = var_be17187b.attacker;
			self notify(#"hash_5806ee636b7dafda", {#index:var_74f1c6f6.script_index});
			break;
		}
		else if(level.var_12469d5 !== var_be17187b.attacker)
		{
			self notify(#"hash_52349a04253a83b2");
		}
	}
}

/*
	Name: function_927ac839
	Namespace: namespace_1bf74f9e
	Checksum: 0xBC972591
	Offset: 0x1B38
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_927ac839()
{
	self endon(#"hash_4c246c05db5c64bc");
	wait(8);
	self notify(#"hash_52349a04253a83b2");
}

/*
	Name: function_30210e26
	Namespace: namespace_1bf74f9e
	Checksum: 0xADD258BB
	Offset: 0x1B78
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_30210e26()
{
	self endon(#"death");
	while(!b_seen)
	{
		if(isdefined(self.var_5a1faad3) && self.var_5a1faad3)
		{
			foreach(var_7653f3d0 in util::get_active_players(#"allies"))
			{
				if(distance2dsquared(var_7653f3d0.origin, self.origin) < 1638400 && !var_7653f3d0 function_80d68e4d(self, 0.9, 0))
				{
					b_seen = 1;
					break;
				}
			}
		}
		wait(0.5);
	}
	self util::delay_notify(120, #"hash_b59af7576a97635");
	self thread function_7229d73c();
}

/*
	Name: function_7229d73c
	Namespace: namespace_1bf74f9e
	Checksum: 0x10249827
	Offset: 0x1D10
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_7229d73c()
{
	self endon(#"death", #"hash_b59af7576a97635");
	a_str_zones = array("zone_cemetery_entrance", "zone_cemetery_path_left", "zone_cemetery_path_right", "zone_cemetery_graveyard", "zone_cemetery_mausoleum", "zone_underground");
	while(b_continue)
	{
		b_continue = 0;
		foreach(e_player in util::get_active_players(#"allies"))
		{
			if(isinarray(a_str_zones, e_player.zone_name))
			{
				b_continue = 1;
				break;
			}
		}
		wait(1);
	}
	self delete();
}

/*
	Name: function_4999f099
	Namespace: namespace_1bf74f9e
	Checksum: 0x191CA6C6
	Offset: 0x1E70
	Size: 0x410
	Parameters: 1
	Flags: Linked
*/
function function_4999f099(var_9427f9e7)
{
	self endon(#"death", #"hash_b59af7576a97635");
	var_57d9b9a5 = [];
	var_d17bd352 = 1;
	var_6219bef = (0, 0, 1.6 * 256);
	var_409d46fe = 0.5 + 1.6 * 0.1;
	while(true)
	{
		self setneargoalnotifydist(64);
		var_dbac44db = var_409d46fe;
		if(var_d17bd352)
		{
			var_dbac44db = var_daa7e03a;
			var_d17bd352 = 0;
		}
		self setspeed(self.settings.defaultmovespeed * var_dbac44db);
		var_6c9efff0 = var_9427f9e7.origin + var_6219bef + (0, 0, randomintrange(0, 84) * 1.6);
		self function_a57c34b7(var_6c9efff0, 0, 0);
		self vehlookat(var_6c9efff0);
		self.var_5e3ca234 = self.var_3c20808;
		self.var_3c20808 = var_9427f9e7;
		self waittill(#"near_goal");
		wait(randomfloatrange(5, 12));
		self.var_5a1faad3 = 1;
		var_57d9b9a5 = [];
		a_s_locs = struct::get_array(var_9427f9e7.target, "targetname");
		foreach(s_loc in a_s_locs)
		{
			if(!isdefined(var_57d9b9a5))
			{
				var_57d9b9a5 = [];
			}
			else if(!isarray(var_57d9b9a5))
			{
				var_57d9b9a5 = array(var_57d9b9a5);
			}
			var_57d9b9a5[var_57d9b9a5.size] = s_loc;
		}
		a_s_locs = struct::get_array(var_9427f9e7.targetname, "target");
		foreach(s_loc in a_s_locs)
		{
			if(!isdefined(var_57d9b9a5))
			{
				var_57d9b9a5 = [];
			}
			else if(!isarray(var_57d9b9a5))
			{
				var_57d9b9a5 = array(var_57d9b9a5);
			}
			var_57d9b9a5[var_57d9b9a5.size] = s_loc;
		}
		if(isdefined(self.var_5e3ca234))
		{
			var_57d9b9a5 = array::exclude(var_57d9b9a5, self.var_5e3ca234);
		}
		var_2bab3af1 = array::random(var_57d9b9a5);
		var_9427f9e7 = var_2bab3af1;
		waitframe(1);
	}
}

/*
	Name: function_fd7c6bd1
	Namespace: namespace_1bf74f9e
	Checksum: 0x9DE53CB9
	Offset: 0x2288
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_fd7c6bd1()
{
	/#
		self endon(#"death");
		level waittill(#"hash_348748d248801d6b");
		e_player = getplayers()[0];
		self dodamage(self.health, e_player.origin, e_player, e_player, undefined, "", 0, level.var_6fe89212);
	#/
}

/*
	Name: function_3c9915f4
	Namespace: namespace_1bf74f9e
	Checksum: 0x395D17FD
	Offset: 0x2328
	Size: 0x210
	Parameters: 2
	Flags: None
*/
function function_3c9915f4(var_9427f9e7, var_2bab3af1)
{
	/#
		self endon(#"death", #"near_goal");
		while(true)
		{
			var_b2bd87c7 = groundtrace(var_9427f9e7.origin + vectorscale((0, 0, 1), 8), var_9427f9e7.origin + vectorscale((0, 0, -1), 100000), 0, undefined)[#"position"];
			var_e9683beb = groundtrace(var_2bab3af1.origin + vectorscale((0, 0, 1), 8), var_2bab3af1.origin + vectorscale((0, 0, -1), 100000), 0, undefined)[#"position"];
			sphere(groundtrace(self.origin + vectorscale((0, 0, 1), 8), self.origin + vectorscale((0, 0, -1), 100000), 0, self)[#"position"], 4, (1, 0, 0), 1, 1, 4, 12);
			sphere(var_b2bd87c7, 4, (1, 1, 0), 1, 1, 8, 12);
			sphere(var_e9683beb, 8, (0, 1, 0), 1, 1, 8, 12);
			line(var_b2bd87c7, var_e9683beb, (1, 1, 1), 1, 1, 12);
			wait(0.2);
		}
	#/
}

/*
	Name: function_a8fd8406
	Namespace: namespace_1bf74f9e
	Checksum: 0xFC966DFA
	Offset: 0x2540
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_a8fd8406()
{
	self notify("7a6f46837cf06d82");
	self endon("7a6f46837cf06d82");
	self endon(#"death");
	self clientfield::set("" + #"hash_6ded20ebb8e016ba", 1);
	wait(0.6);
	self clientfield::set("" + #"hash_6ded20ebb8e016ba", 0);
}

/*
	Name: function_58439640
	Namespace: namespace_1bf74f9e
	Checksum: 0x6E6883FF
	Offset: 0x25D8
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function function_58439640()
{
	var_44a24b57 = function_68a875b(self.origin);
	if(isdefined(var_44a24b57))
	{
		/#
			sphere(var_44a24b57, 4, (1, 0, 0), 1, 1, 4, 480);
			sphere(self.origin, 16, (1, 1, 0), 1, 1, 4, 480);
			line(self.origin, var_44a24b57, (1, 1, 1), 1, 1, 480);
		#/
		var_e2d0a89 = vectornormalize(var_44a24b57 - self.origin);
		var_e2d0a89 = (var_e2d0a89[0], var_e2d0a89[1], 0);
		var_e2d0a89 = var_e2d0a89 * self.origin[2] - var_44a24b57[2] * 0.8;
		return var_e2d0a89;
	}
}

/*
	Name: function_44a776ee
	Namespace: namespace_1bf74f9e
	Checksum: 0xF1891EE5
	Offset: 0x2718
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_44a776ee()
{
	if(!isdefined(level.var_5f2726dc))
	{
		return;
	}
	/#
		keys = getarraykeys(level.zones);
		for(i = 0; i < keys.size; i++)
		{
			zone = level.zones[keys[i]];
			node = function_52c1730(level.var_5f2726dc, zone.nodes, 500);
			if(isdefined(node))
			{
				iprintln("" + function_9e72a96(keys[i]));
			}
		}
	#/
	if(isdefined(level.var_b434e769))
	{
		level.var_b434e769 delete();
	}
	level.var_5f2726dc = groundtrace(level.var_5f2726dc + vectorscale((0, 0, 1), 8), level.var_5f2726dc + vectorscale((0, 0, -1), 100000), 0, undefined)[#"position"];
	var_b434e769 = util::spawn_model(#"hash_6f97a0d9c769da03", level.var_5f2726dc);
	util::wait_network_frame();
	s_loc = spawnstruct();
	s_loc.origin = level.var_5f2726dc + vectorscale((0, 0, 1), 8);
	if(isdefined(var_b434e769))
	{
		level.var_b434e769 = var_b434e769;
		var_b434e769 clientfield::set("" + #"hash_63ffcbb6c8f4bc11", 1);
		var_47323b73 = s_loc zm_unitrigger::create(&function_c7c9f8d3, 96, &function_c73f430e);
		var_47323b73.var_b434e769 = var_b434e769;
		var_b434e769 waittill(#"death");
		zm_unitrigger::unregister_unitrigger(var_47323b73);
		if(isdefined(s_loc))
		{
			s_loc struct::delete();
		}
	}
}

/*
	Name: function_c73f430e
	Namespace: namespace_1bf74f9e
	Checksum: 0x6B46D728
	Offset: 0x2A10
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_c73f430e()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		if(isdefined(self.stub.var_b434e769) & !level flag::get("flag_player_grabbed_catalyst_material"))
		{
			self.stub.var_b434e769 delete();
			level namespace_6747c550::function_7df6bb60(#"hash_3eb09edf042e93c7", 1);
			level flag::set("flag_player_grabbed_catalyst_material");
			level.var_52d4b640 notify(#"hash_2b1cabe38e2ce84b");
			level.var_b434e769 = undefined;
			break;
		}
	}
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_68a875b
	Namespace: namespace_1bf74f9e
	Checksum: 0x286A65C9
	Offset: 0x2B60
	Size: 0x40C
	Parameters: 1
	Flags: Linked
*/
function function_68a875b(v_pos)
{
	if(!isdefined(v_pos))
	{
		return;
	}
	v_drop_point = zm_utility::function_b0eeaada(v_pos, 3200);
	if(isdefined(v_drop_point))
	{
		if(zm_zonemgr::function_66bf6a43(v_drop_point[#"point"]))
		{
			/#
				iprintln("");
			#/
			return v_drop_point[#"point"];
		}
		var_f6193a60 = getclosestpointonnavmesh(v_drop_point[#"point"], 256);
		if(isdefined(var_f6193a60))
		{
			if(zm_zonemgr::function_66bf6a43(var_f6193a60))
			{
				/#
					iprintln("");
				#/
				return var_f6193a60;
			}
		}
	}
	for(i = 1; i <= 10; i++)
	{
		var_48dba99e = zm_utility::function_b0eeaada(v_pos + (64 * i * -1, 0, 0), 3200);
		if(isdefined(var_48dba99e))
		{
			if(zm_zonemgr::function_66bf6a43(var_48dba99e[#"point"]))
			{
				/#
					iprintln("" + 64 * i);
				#/
				return var_48dba99e[#"point"];
			}
		}
		var_dc4239c1 = zm_utility::function_b0eeaada(v_pos + (64 * i, 0, 0), 3200);
		if(isdefined(var_dc4239c1))
		{
			if(zm_zonemgr::function_66bf6a43(var_dc4239c1[#"point"]))
			{
				/#
					iprintln("" + 64 * i);
				#/
				return var_dc4239c1[#"point"];
			}
		}
		var_f21e9d9b = zm_utility::function_b0eeaada(v_pos + (0, 64 * i, 0), 3200);
		if(isdefined(var_f21e9d9b))
		{
			if(zm_zonemgr::function_66bf6a43(var_f21e9d9b[#"point"]))
			{
				/#
					iprintln("" + 64 * i);
				#/
				return var_f21e9d9b[#"point"];
			}
		}
		var_23fdc586 = zm_utility::function_b0eeaada(v_pos + (0, 64 * i * -1, 0), 3200);
		if(isdefined(var_23fdc586))
		{
			if(zm_zonemgr::function_66bf6a43(var_23fdc586[#"point"]))
			{
				/#
					iprintln("" + 64 * i);
				#/
				return var_23fdc586[#"point"];
			}
		}
	}
	/#
		iprintln("");
	#/
}

/*
	Name: function_cfffc455
	Namespace: namespace_1bf74f9e
	Checksum: 0x2B6A5AFC
	Offset: 0x2F78
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_cfffc455()
{
	v_loc = self.origin;
	v_angles = self.angles;
	if(!isdefined(v_angles))
	{
		v_angles = (0, 0, 0);
	}
	if(isdefined(self.var_bd48b030) && self.var_bd48b030)
	{
		v_loc = function_68a875b(self.origin);
	}
	if(!isdefined(v_loc) || !isdefined(self))
	{
		return;
	}
	v_loc = groundtrace(v_loc + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, 1), 8), v_loc + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
	if(!isdefined(v_loc))
	{
		return;
	}
	v_normal = getnavmeshfacenormal(v_loc, 32);
	if(!isdefined(v_normal))
	{
		return;
	}
	var_d43d0ba1 = util::spawn_model(#"hash_36f02781e6db9e53", v_loc + (0, 0, 1));
	util::wait_network_frame();
	if(!isdefined(var_d43d0ba1))
	{
		return;
	}
	var_d43d0ba1.angles = function_c1fa62a2(v_angles, v_normal);
	if(isdefined(var_d43d0ba1))
	{
		var_d43d0ba1 clientfield::set("" + #"hash_48c6d058e9587c19", 1);
		var_47323b73 = var_d43d0ba1 zm_unitrigger::create(&function_21db5b62, 96);
		var_d43d0ba1 thread function_dca0343();
		var_be17187b = undefined;
		var_be17187b = var_d43d0ba1 waittill_timeout(90, #"hash_4f8ef502f90d41d3");
		zm_unitrigger::unregister_unitrigger(var_47323b73);
		if(isdefined(var_d43d0ba1))
		{
			var_d43d0ba1 delete();
		}
	}
}

/*
	Name: function_dca0343
	Namespace: namespace_1bf74f9e
	Checksum: 0xAEA9931D
	Offset: 0x3210
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_dca0343()
{
	self endon(#"death");
	self thread function_fb72da74();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		player = waitresult.e_who;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		self thread function_c60245c1(player);
		break;
	}
}

/*
	Name: function_fb72da74
	Namespace: namespace_1bf74f9e
	Checksum: 0xD74FE1B0
	Offset: 0x32C8
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_fb72da74()
{
	self endon(#"death");
	level flag::wait_till("bile_collected");
	self notify(#"hash_4f8ef502f90d41d3");
}

/*
	Name: function_c60245c1
	Namespace: namespace_1bf74f9e
	Checksum: 0x8EC03588
	Offset: 0x3318
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_c60245c1(e_player)
{
	if(!(isdefined(e_player.var_9b668949) && e_player.var_9b668949))
	{
		e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_12fcbcf5f7dfcc6f", 1);
		e_player.var_9b668949 = 1;
	}
	self thread function_366a1f08();
	level.var_e01d217e++;
	level namespace_6747c550::function_7df6bb60(#"hash_3eb09ddf042e9214", level.var_e01d217e);
	if(level.var_e01d217e > 2)
	{
		level flag::set("bile_collected");
	}
}

/*
	Name: function_366a1f08
	Namespace: namespace_1bf74f9e
	Checksum: 0xC343690F
	Offset: 0x3400
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_366a1f08()
{
	self endon(#"death");
	self clientfield::set("" + #"hash_48c6d058e9587c19", 0);
	wait(0.1);
	self ghost();
	self notify(#"hash_4f8ef502f90d41d3");
}

/*
	Name: function_c7c9f8d3
	Namespace: namespace_1bf74f9e
	Checksum: 0x4FCBE28F
	Offset: 0x3480
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_c7c9f8d3(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_4adb4ee2a021cc5f", #"hash_390f9a902256dcbd");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_21db5b62
	Namespace: namespace_1bf74f9e
	Checksum: 0x8A19EF43
	Offset: 0x34F0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_21db5b62(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_1ad9cccccf49590a", #"hash_43ddac2161b2260e");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_7b5a8c15
	Namespace: namespace_1bf74f9e
	Checksum: 0x487ED26A
	Offset: 0x3560
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_7b5a8c15()
{
	level flag::wait_till("bile_collected");
	callback::remove_on_ai_killed(&function_9a0471ab);
	var_783eaf1a = struct::get("summon_crm_nos");
	exploder::exploder("fxexp_crypt_glow");
	var_47323b73 = var_783eaf1a zm_unitrigger::create(&function_13547ea4, 64);
	var_783eaf1a thread function_9d36c592();
	var_783eaf1a thread function_5ccad751();
}

/*
	Name: function_5ccad751
	Namespace: namespace_1bf74f9e
	Checksum: 0xF38968A9
	Offset: 0x3648
	Size: 0x116
	Parameters: 0
	Flags: Linked
*/
function function_5ccad751()
{
	self endon_callback(&function_5ce9ff7a, #"hash_3a35866d24190abf", #"death");
	while(true)
	{
		var_1445d063 = array::get_all_closest(self.origin, util::get_active_players(#"allies"), undefined, 4, 1024);
		if(var_1445d063.size)
		{
			level clientfield::set("" + #"hash_19f5ea0e9b3d47f3", 1);
		}
		else
		{
			level clientfield::set("" + #"hash_19f5ea0e9b3d47f3", 0);
		}
		wait(1);
	}
}

/*
	Name: function_5ce9ff7a
	Namespace: namespace_1bf74f9e
	Checksum: 0xDFEB3C04
	Offset: 0x3768
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_5ce9ff7a(var_385703b7)
{
	level thread util::delay(10, undefined, &clientfield::set, "" + #"hash_19f5ea0e9b3d47f3", 0);
}

/*
	Name: function_13547ea4
	Namespace: namespace_1bf74f9e
	Checksum: 0xD0D107E0
	Offset: 0x37C0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_13547ea4(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_1c45ec9f9414b664", #"hash_7d81ba22ba54bb08");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_9d36c592
	Namespace: namespace_1bf74f9e
	Checksum: 0xAC6CD5C
	Offset: 0x3830
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_9d36c592()
{
	self endon(#"hash_3a35866d24190abf");
	s_loc = struct::get("nosferatu_pos");
	s_bile = struct::get("s_bile");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		player = waitresult.e_who;
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player zm_utility::is_drinking())
		{
			continue;
		}
		if(isdefined(player.var_564dec14) && player.var_564dec14)
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		self thread function_d8648a1e(player);
	}
}

/*
	Name: function_d8648a1e
	Namespace: namespace_1bf74f9e
	Checksum: 0xFDA23C78
	Offset: 0x3968
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_d8648a1e(e_player)
{
	level flag::set("flag_crimson_nosferatu_set_intro");
	level namespace_6747c550::function_7df6bb60(#"hash_3eb09ddf042e9214", 0);
	s_loc = struct::get("nosferatu_pos");
	s_bile = struct::get("s_bile");
	self.var_76a23f3 = util::spawn_model(#"hash_36f02881e6dba006", s_bile.origin, s_bile.angles);
	var_7afd04dc = namespace_2fa8319f::function_74f25f8a(1, s_loc, 1, 35);
	if(isalive(var_7afd04dc))
	{
		var_7afd04dc.var_126d7bef = 1;
		var_7afd04dc.ignore_round_spawn_failsafe = 1;
		var_7afd04dc.ignore_enemy_count = 1;
		var_7afd04dc.b_ignore_cleanup = 1;
		var_7afd04dc.ignore_nuke = 1;
		callback::on_ai_killed(&function_be3fbc6f);
		var_7afd04dc thread function_42c889b7(e_player);
		e_player thread function_c1c2fc5b(6);
		self notify(#"hash_3a35866d24190abf");
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
}

/*
	Name: function_42c889b7
	Namespace: namespace_1bf74f9e
	Checksum: 0x5B18D526
	Offset: 0x3B48
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_42c889b7(e_player)
{
	level thread scene::init(#"hash_1f7947f335a89821", self);
	level thread scene::play(#"hash_4ef2ee22a6e7fe81");
	level waittill(#"hash_771956e8f5a4a301");
	scene::add_scene_func(#"hash_1f7947f335a89821", &function_79b81681, "play");
	scene::add_scene_func(#"hash_1f7947f335a89821", &function_2c0edc3d, "done");
	level thread scene::play(#"hash_1f7947f335a89821", self);
	exploder::stop_exploder("fxexp_crypt_glow");
	self waittill(#"hash_11d606d611e5047e");
	function_d2278936(e_player);
}

/*
	Name: function_79b81681
	Namespace: namespace_1bf74f9e
	Checksum: 0x55A831B3
	Offset: 0x3C88
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_79b81681(a_ents)
{
	if(isactor(a_ents[#"hash_17e93fc8e34f1d4d"]))
	{
		a_ents[#"hash_17e93fc8e34f1d4d"].var_7b0667d9 = 1;
		a_ents[#"hash_17e93fc8e34f1d4d"].blockingpain = 1;
	}
}

/*
	Name: function_2c0edc3d
	Namespace: namespace_1bf74f9e
	Checksum: 0xB398776D
	Offset: 0x3D10
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_2c0edc3d(a_ents)
{
	waitframe(1);
	if(isalive(a_ents[#"hash_17e93fc8e34f1d4d"]))
	{
		a_ents[#"hash_17e93fc8e34f1d4d"].var_7b0667d9 = undefined;
		a_ents[#"hash_17e93fc8e34f1d4d"].blockingpain = 0;
	}
}

/*
	Name: function_d2278936
	Namespace: namespace_1bf74f9e
	Checksum: 0x44AAF57A
	Offset: 0x3D98
	Size: 0x266
	Parameters: 1
	Flags: Linked
*/
function function_d2278936(e_player)
{
	a_players = getplayers();
	switch(a_players.size)
	{
		case 1:
		{
			n_enemy_count = 8;
			n_wait_min = 2.25;
			n_wait_max = 2.75;
			break;
		}
		case 2:
		{
			n_enemy_count = 16;
			n_wait_min = 1.75;
			n_wait_max = 2.25;
			break;
		}
		case 3:
		{
			n_enemy_count = 24;
			n_wait_min = 1.25;
			n_wait_max = 1.75;
			break;
		}
		case 4:
		{
			n_enemy_count = 32;
			n_wait_min = 0.75;
			n_wait_max = 1.25;
			break;
		}
	}
	for(i = 0; i < n_enemy_count; i++)
	{
		s_spawn_loc = namespace_2fa8319f::function_6502a84d();
		if(isdefined(s_spawn_loc))
		{
			var_7afd04dc = namespace_2fa8319f::function_74f25f8a(1, s_spawn_loc, 0, level.round_number);
			if(isdefined(var_7afd04dc))
			{
				var_7afd04dc.var_126d7bef = 1;
				var_7afd04dc.ignore_round_spawn_failsafe = 1;
				var_7afd04dc.ignore_enemy_count = 1;
				var_7afd04dc.b_ignore_cleanup = 1;
				var_7afd04dc.no_powerups = 1;
				if(isdefined(e_player))
				{
					var_7afd04dc.favoriteenemy = e_player;
				}
				var_7afd04dc zm_score::function_acaab828();
				var_7afd04dc forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
				s_spawn_loc = undefined;
				wait(randomfloatrange(n_wait_min, n_wait_max));
			}
		}
	}
}

/*
	Name: function_be3fbc6f
	Namespace: namespace_1bf74f9e
	Checksum: 0x4A17C487
	Offset: 0x4008
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function function_be3fbc6f(s_params)
{
	if(self.var_9fde8624 === #"hash_69eff09684574252" && isplayer(s_params.eattacker) && level flag::get("flag_crimson_nosferatu_set_intro") && !level flag::get("flag_player_grabbed_nosferatu_material"))
	{
		s_loc = spawnstruct();
		s_loc.origin = self.origin;
		s_loc.angles = self.angles;
		var_7162cf15 = function_68a875b(s_loc.origin);
		if(isdefined(var_7162cf15))
		{
			s_loc.origin = var_7162cf15;
		}
		else
		{
			s_loc.origin = getclosestpointonnavmesh(struct::get("nosferatu_pos").origin, 256, 32);
		}
		s_loc.origin = groundtrace(s_loc.origin + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, 1), 8), s_loc.origin + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
		level thread function_6f3f4e18(s_loc);
	}
}

/*
	Name: function_6f3f4e18
	Namespace: namespace_1bf74f9e
	Checksum: 0x9F3951EF
	Offset: 0x4200
	Size: 0x374
	Parameters: 1
	Flags: Linked
*/
function function_6f3f4e18(s_loc)
{
	if(!isdefined(level.var_8e7ee650))
	{
		level.var_8e7ee650 = [];
	}
	else if(!isarray(level.var_8e7ee650))
	{
		level.var_8e7ee650 = array(level.var_8e7ee650);
	}
	array::remove_undefined(level.var_8e7ee650, 0);
	if(level.var_8e7ee650.size >= 1)
	{
		return;
	}
	s_loc endon_callback(&function_7b8d385, #"hash_3cead30b0acc91c1");
	s_loc util::delay_notify(120, #"hash_3cead30b0acc91c1");
	s_loc.var_817342a7 = util::spawn_model(#"hash_1db3b13073cc966d", s_loc.origin, s_loc.angles);
	if(!isdefined(level.var_8e7ee650))
	{
		level.var_8e7ee650 = [];
	}
	else if(!isarray(level.var_8e7ee650))
	{
		level.var_8e7ee650 = array(level.var_8e7ee650);
	}
	level.var_8e7ee650[level.var_8e7ee650.size] = s_loc;
	util::wait_network_frame();
	s_loc.var_817342a7 clientfield::set("" + #"hash_62ee80337662b3cd", 1);
	playsoundatposition(#"zmb_sq_souls_release", s_loc.var_817342a7.origin);
	s_loc.origin = s_loc.origin + vectorscale((0, 0, 1), 8);
	e_holder = s_loc zm_unitrigger::function_fac87205(&function_fdc93dd2, 64);
	if(!level flag::get("flag_player_grabbed_nosferatu_material"))
	{
		e_holder thread namespace_891c9bac::function_a2bd5a0c(#"hash_31e2f2fbfc612834", 1);
		level namespace_6747c550::function_7df6bb60(#"hash_3eb09ddf042e9214", 4);
		s_loc.var_817342a7 delete();
		s_loc struct::delete();
		level.var_8e7ee650 = undefined;
		level flag::set("flag_player_grabbed_nosferatu_material");
		callback::remove_on_ai_killed(&function_be3fbc6f);
	}
}

/*
	Name: function_7b8d385
	Namespace: namespace_1bf74f9e
	Checksum: 0x4D350F76
	Offset: 0x4580
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_7b8d385(var_385703b7)
{
	if(isdefined(self.var_817342a7))
	{
		self.var_817342a7 delete();
	}
	if(isdefined(self.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
	arrayremovevalue(level.var_8e7ee650, self);
	self struct::delete();
}

/*
	Name: function_fdc93dd2
	Namespace: namespace_1bf74f9e
	Checksum: 0x2311E7FB
	Offset: 0x4620
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_fdc93dd2(player)
{
	if(!level flag::get("flag_player_grabbed_nosferatu_material"))
	{
		str_prompt = zm_utility::function_d6046228(#"hash_33e523e840caec34", #"hash_2bc1f0690d248b98");
		self sethintstringforplayer(player, str_prompt);
	}
	else
	{
		self sethintstringforplayer(player, "");
	}
	return 1;
}

/*
	Name: function_c1c2fc5b
	Namespace: namespace_1bf74f9e
	Checksum: 0xC49DA8B6
	Offset: 0x46D8
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_c1c2fc5b(n_to_spawn)
{
	n_spawned = 0;
	var_f1c4ec4f = self zm_utility::get_current_zone(1);
	if(!isdefined(var_f1c4ec4f))
	{
		return;
	}
	var_8deb2034 = var_f1c4ec4f.a_loc_types[#"bat_location"];
	foreach(var_c92978fa in getarraykeys(var_f1c4ec4f.adjacent_zones))
	{
		var_c714ccfe = level.zones[var_c92978fa];
		var_9387e4ab = var_c714ccfe.a_loc_types[#"bat_location"];
		if(isdefined(var_9387e4ab))
		{
			foreach(s_spawner in var_9387e4ab)
			{
				if(!isdefined(var_8deb2034))
				{
					var_8deb2034 = [];
				}
				else if(!isarray(var_8deb2034))
				{
					var_8deb2034 = array(var_8deb2034);
				}
				var_8deb2034[var_8deb2034.size] = s_spawner;
			}
		}
	}
	while(n_spawned < n_to_spawn)
	{
		s_pos = array::random(var_8deb2034);
		if(isdefined(s_pos))
		{
			ai = bat::function_2e37549f(1, s_pos, level.round_number);
			if(isdefined(ai))
			{
				arrayremovevalue(var_8deb2034, s_pos);
				n_spawned++;
				namespace_9d27962b::function_f46db405();
			}
		}
	}
}

/*
	Name: function_ee901070
	Namespace: namespace_1bf74f9e
	Checksum: 0xFE8F228
	Offset: 0x4958
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_ee901070(e_attacker)
{
	self endon(#"death");
	e_attacker endon_callback(&function_ff107ee6, #"death");
	if(isdefined(self.var_3ca04328) && self.var_3ca04328 && (!level flag::get(#"hash_1d477cd627a495d9") || !isdefined(e_attacker.var_cbdbce01)) && (isdefined(self function_2e1a2c88()) && self function_2e1a2c88()))
	{
		if(!isdefined(level.var_105c6f35))
		{
			level.var_105c6f35 = [];
		}
		else if(!isarray(level.var_105c6f35))
		{
			level.var_105c6f35 = array(level.var_105c6f35);
		}
		level.var_105c6f35[level.var_105c6f35.size] = self;
		e_attacker.var_cbdbce01 = self;
		self.var_b8391660 = 0;
		level flag::set(#"hash_1d477cd627a495d9");
		self thread function_a167efd7();
		self thread namespace_82497b8a::function_b47bcfb0(e_attacker, 60);
		while(true)
		{
			if(!self.var_b8391660)
			{
				self.n_zombie_custom_goal_radius = 96;
				self.v_zombie_custom_goal_pos = e_attacker.origin;
			}
			wait(1);
		}
	}
	else if(isinarray(level.var_105c6f35, self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_ff107ee6
	Namespace: namespace_1bf74f9e
	Checksum: 0x4B1EAB7D
	Offset: 0x4B98
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_ff107ee6(str_notify)
{
	if(isdefined(self.var_cbdbce01))
	{
		self.var_cbdbce01 notify(#"hash_28e3235da53ba083");
	}
}

/*
	Name: function_2e1a2c88
	Namespace: namespace_1bf74f9e
	Checksum: 0x40883A2A
	Offset: 0x4BD8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_2e1a2c88()
{
	a_str_zones = array("zone_forest_entrance", "zone_forest_s", "zone_forest_se", "zone_forest_center", "zone_forest_nw", "zone_forest_n");
	str_zone = zm_utility::get_current_zone();
	if(isdefined(str_zone) && isinarray(a_str_zones, str_zone))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bc8c390e
	Namespace: namespace_1bf74f9e
	Checksum: 0x13B84EC1
	Offset: 0x4C80
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_bc8c390e()
{
	level.var_105c6f35 = [];
	var_7846fbf = struct::get_array("ww_lvl3_part_3_pos");
	var_7846fbf = array::randomize(var_7846fbf);
	var_7846fbf[0].var_3dd3b66e = 1;
	foreach(var_bcc0d06a in var_7846fbf)
	{
		var_bcc0d06a.var_ac144521 = 0;
		var_bcc0d06a.var_b92834ee = util::spawn_model("tag_origin", var_bcc0d06a.origin + vectorscale((0, 0, -1), 16));
		var_bcc0d06a thread function_de394c52();
	}
}

/*
	Name: function_de394c52
	Namespace: namespace_1bf74f9e
	Checksum: 0xD0BB0A5A
	Offset: 0x4DA8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_de394c52()
{
	while(!self.var_ac144521)
	{
		level flag::wait_till(#"hash_1d477cd627a495d9");
		self thread function_4eca0031();
		level flag::wait_till_clear(#"hash_1d477cd627a495d9");
	}
}

/*
	Name: function_4eca0031
	Namespace: namespace_1bf74f9e
	Checksum: 0x4147605A
	Offset: 0x4E18
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_4eca0031()
{
	level endon(#"hash_5966d6342dbd6f82");
	while(true)
	{
		foreach(var_f8a1403f in level.var_105c6f35)
		{
			if(isdefined(var_f8a1403f) && !var_f8a1403f.var_b8391660 && distance2dsquared(var_f1935ec8, var_f8a1403f.origin) < 10000)
			{
				var_f8a1403f thread function_a2256244(self, var_f1935ec8);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_75636add
	Namespace: namespace_1bf74f9e
	Checksum: 0xEEB110A6
	Offset: 0x4F40
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function function_75636add(var_f1935ec8)
{
	/#
		self endon(#"death", #"goal");
		while(true)
		{
			sphere(var_f1935ec8, 8, (1, 0, 0), 1, 0, 4, 10);
			line(self.origin, var_f1935ec8, (1, 1, 1), 1, 0, 10);
			wait(0.2);
		}
	#/
}

/*
	Name: function_a2256244
	Namespace: namespace_1bf74f9e
	Checksum: 0xC5E3BADE
	Offset: 0x4FE0
	Size: 0x1E6
	Parameters: 2
	Flags: Linked
*/
function function_a2256244(var_f9105ee8, var_f1935ec8)
{
	self endon(#"death");
	/#
		self thread function_75636add(var_f1935ec8);
	#/
	self.var_b8391660 = 1;
	self.n_zombie_custom_goal_radius = 16;
	self.v_zombie_custom_goal_pos = var_f1935ec8;
	self waittill(#"goal");
	var_f9105ee8.var_b92834ee thread function_6a21ff38();
	self scene::play(#"hash_7c22ddfd9102f68f", self);
	var_f9105ee8.var_b92834ee clientfield::set("" + #"hash_486960f190957256", 0);
	var_f9105ee8.var_ac144521 = 1;
	hidemiscmodels(var_f9105ee8.script_noteworthy);
	if(isdefined(var_f9105ee8.var_3dd3b66e) && var_f9105ee8.var_3dd3b66e)
	{
		var_9c95ad05 = namespace_a1d9b01d::function_4c2f8683("zitem_chaos_lvl3_part_3");
		var_5ab22b80 = namespace_93829f86::spawn_item(var_9c95ad05, var_f9105ee8.origin, var_f9105ee8.angles, 1);
		level.var_27f4ef2f = undefined;
		var_5ab22b80 clientfield::set("" + #"hash_524ec892754aeb34", 1);
	}
	wait(2);
	self notify(#"hash_28e3235da53ba083");
}

/*
	Name: function_6a21ff38
	Namespace: namespace_1bf74f9e
	Checksum: 0x451DE41
	Offset: 0x51D0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_6a21ff38()
{
	wait(1);
	self clientfield::set("" + #"hash_486960f190957256", 1);
}

/*
	Name: function_a167efd7
	Namespace: namespace_1bf74f9e
	Checksum: 0x460CC32F
	Offset: 0x5210
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_a167efd7()
{
	self waittill(#"death");
	if(isdefined(self))
	{
		level.var_105c6f35 = array::exclude(level.var_105c6f35, self);
	}
	level.var_105c6f35 = array::remove_undefined(level.var_105c6f35);
	if(!level.var_105c6f35.size)
	{
		level flag::clear(#"hash_1d477cd627a495d9");
		level notify(#"hash_5966d6342dbd6f82");
	}
}

/*
	Name: function_1b4df249
	Namespace: namespace_1bf74f9e
	Checksum: 0x409407B8
	Offset: 0x52C8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_1b4df249()
{
	if(isinarray(level.var_105c6f35, self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_25058256
	Namespace: namespace_1bf74f9e
	Checksum: 0xC99D4271
	Offset: 0x5300
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_25058256()
{
	level flagsys::wait_till(#"load_main_complete");
	foreach(s_stub in level.var_4fe2f84d[#"zblueprint_chaos_lvl3"])
	{
		s_stub.var_c060d2c8 = 0;
	}
}

/*
	Name: function_8bca35b9
	Namespace: namespace_1bf74f9e
	Checksum: 0x6A695DA8
	Offset: 0x53B0
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_8bca35b9(e_player)
{
	var_a70a763b = getentarray("ww_lvl3_quest_piece_on_table", "targetname");
	array::run_all(var_a70a763b, &show);
	showmiscmodels("ww_lvl3_quest_piece_on_table");
	unitrigger_stub = self.stub;
	if(!isdefined(unitrigger_stub.var_1a95256))
	{
		unitrigger_stub thread function_c834e06();
	}
	e_player zm_weapons::weapon_take(level.var_6fe89212);
	e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_1bee1f8c64cef00f", 1);
	e_player zm_weapons::weapon_give(unitrigger_stub.blueprint.var_54a97edd);
	wait(0.1);
	unitrigger_stub namespace_a1d9b01d::function_6dccf508();
	unitrigger_stub.prompt_and_visibility_func = &function_7aa50bb7;
}

/*
	Name: function_c834e06
	Namespace: namespace_1bf74f9e
	Checksum: 0xB92A1500
	Offset: 0x5508
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_c834e06()
{
	var_d68dd87d = struct::get("ww_lvl3_crafting_table_fx", "targetname");
	self.var_1a95256 = util::spawn_model("tag_origin", var_d68dd87d.origin, var_d68dd87d.angles);
	util::wait_network_frame();
	self.var_1a95256 clientfield::set("" + #"ww_lvl3_crafting_table_fx", 1);
}

/*
	Name: function_7aa50bb7
	Namespace: namespace_1bf74f9e
	Checksum: 0x5184FC5
	Offset: 0x55C0
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_7aa50bb7(e_player)
{
	can_use = self.stub namespace_a1d9b01d::function_18f2be60(e_player);
	if(e_player zm_weapons::has_weapon_or_upgrade(level.var_7b9ca97a))
	{
		self sethintstring("");
	}
	else if(e_player zm_weapons::has_weapon_or_upgrade(level.var_6fe89212))
	{
		self sethintstring(self.stub.blueprint.var_4dbc4aee);
	}
	else
	{
		self sethintstring(#"hash_652c97821a6cf09d");
	}
	return can_use;
}

