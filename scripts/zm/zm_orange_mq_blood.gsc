// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace zm_orange_mq_blood;

/*
	Name: preload
	Namespace: zm_orange_mq_blood
	Checksum: 0x4FF40A22
	Offset: 0x3A0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	clientfield::register("scriptmover", "" + #"hash_10906b9ce905bda8", 24000, 3, "int");
	clientfield::register("scriptmover", "" + #"hash_5dd642a0bd6e6cb9", 24000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_1b72c208f2964e24", 24000, 3, "int");
}

/*
	Name: main
	Namespace: zm_orange_mq_blood
	Checksum: 0xCE01057
	Offset: 0x470
	Size: 0x43E
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"blood_waiting");
	level flag::init(#"blood_active");
	level.s_mq_blood_vessel_loc = struct::get("mq_blood_vessel_loc", "targetname");
	level.s_mq_blood_vessel_loc.vessel = getent(level.s_mq_blood_vessel_loc.target, "targetname");
	level.s_mq_blood_vessel_loc.vessel hide();
	level.s_mq_blood_vessel_loc zm_unitrigger::create("", 128);
	level.var_4adebdfc = getent("mq_blood", "targetname");
	level.var_4adebdfc val::set(#"mq_blood", "allowdeath", 0);
	level.var_4adebdfc val::set(#"mq_blood", "takedamage", 0);
	level.var_4adebdfc.a_wisps = [];
	level.var_9e3c632e = 1;
	level.var_ed1e7d4d = 0;
	level.var_63a35083 = zm_hms_util::function_2719d4c0("mq_blood_loc", "targetname", "script_int");
	level.var_e70fa660 = zm_hms_util::function_2719d4c0("mq_blood_whisp_loc", "targetname", "script_int");
	level waittill(#"start_zombie_round_logic");
	level.s_mq_blood_vessel_loc thread blood_think();
	level.var_4adebdfc moveto(level.var_63a35083[0].origin, 1, 0.1, 0.3);
	level.var_4adebdfc clientfield::set("" + #"hash_10906b9ce905bda8", level.var_9e3c632e);
	level.var_9928b94b = [];
	level.var_9928b94b[0] = array("docks_1", "docks_2", "boathouse", "frozen_crevasse", "ice_grotto", "lagoon");
	level.var_9928b94b[1] = array("beach", "lighthouse_approach", "lighthouse_station", "lighthouse_cove", "hidden_path");
	level.var_9928b94b[2] = array("main_entrance", "outer_walkway", "loading_platform", "specimen_storage", "decontamination", "security_lobby", "geological_processing", "upper_catwalk", "human_infusion");
	level.var_16972e5c = array(#"snowball", #"snowball_upgraded", #"snowball_yellow", #"snowball_yellow_upgraded", #"tundragun", #"tundragun_upgraded");
}

/*
	Name: function_8d43b840
	Namespace: zm_orange_mq_blood
	Checksum: 0x9DA3D618
	Offset: 0x8B8
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function function_8d43b840(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"blood_waiting");
		level.s_mq_blood_vessel_loc notify(#"blood_waiting");
		switch(level.var_9e3c632e)
		{
			case 1:
			{
				zm_ui_inventory::function_7df6bb60(#"zm_orange_objective_progress", 3);
				break;
			}
			case 2:
			{
				zm_ui_inventory::function_7df6bb60(#"zm_orange_objective_progress", 5);
				break;
			}
			case 3:
			{
				zm_ui_inventory::function_7df6bb60(#"zm_orange_objective_progress", 7);
				break;
			}
		}
		while(!zm_hms_util::any_player_in_zone(array("artifact_storage")))
		{
			waitframe(1);
		}
		switch(level.var_9e3c632e)
		{
			case 1:
			{
				level.var_60b08c24 thread zm_hms_util::function_6a0d675d(#"hash_3cd0832e040f6c84", -1, 0, 1);
				break;
			}
			case 2:
			{
				level.var_60b08c24 thread zm_hms_util::function_6a0d675d(#"hash_65bb9d30e635b942", -1, 0, 1);
				break;
			}
			case 3:
			{
				level.var_60b08c24 thread zm_hms_util::function_6a0d675d(#"hash_6222894db8f79c0c", -1, 0, 1);
				break;
			}
		}
		level.var_64f7b41e = 0;
		level.var_9928b94b = array::randomize(level.var_9928b94b);
		level.var_e70fa660 = array::randomize(level.var_e70fa660);
		level.var_4adebdfc blood_event();
	}
}

/*
	Name: function_2d9e1e29
	Namespace: zm_orange_mq_blood
	Checksum: 0x23880FA0
	Offset: 0xB78
	Size: 0x1E0
	Parameters: 2
	Flags: Linked
*/
function function_2d9e1e29(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level notify(#"hash_6cbede8616798eb");
		level.s_mq_blood_vessel_loc.vessel hide();
		level.s_mq_blood_vessel_loc thread blood_think();
		if(level flag::get(#"blood_active"))
		{
			level flag::clear(#"blood_active");
		}
		level.var_9e3c632e++;
		level.var_4adebdfc clientfield::set("" + #"hash_10906b9ce905bda8", level.var_9e3c632e);
		level.var_ed1e7d4d = level.var_9e3c632e - 1;
		foreach(wisp in level.var_4adebdfc.a_wisps)
		{
			if(isdefined(wisp))
			{
				wisp thread util::delayed_delete(0.2);
			}
		}
		level flag::clear(#"infinite_round_spawning");
	}
	level notify(#"hash_1f0238cda598f6e9");
}

/*
	Name: blood_think
	Namespace: zm_orange_mq_blood
	Checksum: 0x98AC63C6
	Offset: 0xD60
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function blood_think()
{
	self notify("27bec720b5d077a2");
	self endon("27bec720b5d077a2");
	level endon(#"end_game");
	while(!level flag::get(#"blood_waiting"))
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated", #"blood_waiting");
		player = s_notify.e_who;
		if(s_notify._notify === "trigger_activated")
		{
			damage = 0;
			switch(level.var_9e3c632e)
			{
				case 1:
				{
					player.isspeaking = 1;
					damage = 666;
					break;
				}
				case 2:
				{
					damage = 150;
					break;
				}
				case 3:
				{
					damage = 100;
					break;
				}
			}
			player dodamage(damage, level.var_4adebdfc.origin);
			if(getplayers().size < 2 && player laststand::player_is_in_laststand())
			{
				player thread function_15f8d6f0();
			}
			if(level flag::get(#"blood_hints"))
			{
				level.var_4adebdfc playsoundtoplayer(level.var_60b08c24.var_489c2917 + "_apot_0", player);
			}
			wait(2);
		}
	}
	level.s_mq_blood_vessel_loc thread function_ee4a200b();
}

/*
	Name: function_ee4a200b
	Namespace: zm_orange_mq_blood
	Checksum: 0x9EE95A2D
	Offset: 0xFA8
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_ee4a200b()
{
	level endon(#"end_game", #"hash_6cbede8616798eb");
	if(level.var_9e3c632e > 1)
	{
		self.vessel setmodel("p8_zm_ora_elemental_vessel");
	}
	self waittill(#"trigger_activated");
	self.vessel show();
	self.vessel playsound("zmb_vessel_drop");
	level notify(#"hash_6fb77fda0e7419a6");
	level waittill(#"blood_collected");
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level.var_ed1e7d4d++;
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", level.var_ed1e7d4d);
	self waittill(#"trigger_activated");
	self.vessel hide();
	self.vessel playsound("zmb_vessel_pickup");
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", 0);
	level notify(#"vessel_collected");
	level flag::clear(#"blood_waiting");
	wait(2);
	level.s_mq_blood_vessel_loc thread blood_think();
}

/*
	Name: function_15f8d6f0
	Namespace: zm_orange_mq_blood
	Checksum: 0xF5E810F5
	Offset: 0x1228
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_15f8d6f0()
{
	var_3269dfa3 = (isdefined(self.var_b92e42da) ? self.var_b92e42da : getdvarfloat(#"player_laststandbleedouttime", 0)) * 0.25;
	var_3269dfa3 = getdvarfloat(#"hash_1d447d6b4492bf4f", var_3269dfa3);
	wait(var_3269dfa3 - 0.5);
	self thread zm_laststand::auto_revive(self, 0, 0);
}

/*
	Name: blood_event
	Namespace: zm_orange_mq_blood
	Checksum: 0xCF2BC93A
	Offset: 0x12D8
	Size: 0x4A4
	Parameters: 0
	Flags: Linked
*/
function blood_event()
{
	level endon(#"hash_1f0238cda598f6e9", #"end_game");
	level waittill(#"hash_6fb77fda0e7419a6");
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"blood_active");
	var_84f1a7ae = zombie_utility::ai_calculate_health(3000, level.round_number) * level.var_9e3c632e;
	level.var_4adebdfc.health = var_84f1a7ae;
	wait(2);
	level.var_4adebdfc val::set(#"mq_blood", "takedamage", 1);
	self thread blood_move();
	while(level.var_4adebdfc.health > int(var_84f1a7ae * 0.6666667))
	{
		waitframe(1);
	}
	self notify(#"threshold_hit");
	level thread function_9a991dc2(0);
	while(level.var_4adebdfc.health > int(var_84f1a7ae * 0.3333333))
	{
		waitframe(1);
	}
	self notify(#"threshold_hit");
	level thread function_9a991dc2(1);
	while(level.var_4adebdfc.health > 2)
	{
		waitframe(1);
	}
	level flag::clear(#"blood_active");
	level thread function_9a991dc2(2);
	self moveto(level.var_63a35083[0].origin, 1, 0.1, 0.5);
	self.var_d0fed9fb = undefined;
	level.var_9e3c632e++;
	level.var_4adebdfc clientfield::set("" + #"hash_10906b9ce905bda8", level.var_9e3c632e);
	level zm_utility::function_9ad5aeb1(1, 1, 0, 1, 0);
	level flag::clear(#"infinite_round_spawning");
	switch(level.var_9e3c632e)
	{
		case 2:
		{
			level thread function_7535dc08();
			break;
		}
		case 3:
		{
			level.var_60b08c24 thread zm_hms_util::function_6a0d675d(#"hash_554da7ef3c71bc2a", -1, 0, 1);
			break;
		}
	}
	while(level.var_64f7b41e < 3)
	{
		waitframe(1);
	}
	level notify(#"blood_collected");
	switch(level.var_9e3c632e)
	{
		case 2:
		{
			if(level.var_98138d6b > 1)
			{
				level.var_1c53964e thread zm_hms_util::function_6a0d675d(#"hash_1ab690c8635a053b", -1, 0, 1);
			}
			break;
		}
		case 4:
		{
			level thread function_df1ea27();
			break;
		}
	}
	level waittill(#"vessel_collected");
}

/*
	Name: function_7535dc08
	Namespace: zm_orange_mq_blood
	Checksum: 0x939F5485
	Offset: 0x1788
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_7535dc08()
{
	level endon(#"end_game");
	zm_orange_util::function_fd24e47f(#"hash_17d537f3403651e2");
	level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_17d537f3403651e2");
}

/*
	Name: function_df1ea27
	Namespace: zm_orange_mq_blood
	Checksum: 0xE80EE7BC
	Offset: 0x17F8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_df1ea27()
{
	level endon(#"end_game");
	level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_359fe3561c4d0623", 0, 0, 1);
	level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_359fe3561c4d0623", 1, 0, 1);
}

/*
	Name: blood_move
	Namespace: zm_orange_mq_blood
	Checksum: 0x4858A741
	Offset: 0x1880
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function blood_move()
{
	level endon(#"end_game");
	while(level flag::get(#"blood_active"))
	{
		stance_any_step = array::remove_index(level.var_63a35083, 0);
		if(isdefined(self.var_d0fed9fb))
		{
			stance_any_step = array::remove_index(stance_any_step, self.var_d0fed9fb);
		}
		s_point = array::random(stance_any_step);
		self moveto(s_point.origin, 0.5, 0.1, 0.2);
		self.var_d0fed9fb = s_point.script_int;
		s_result = undefined;
		s_result = self waittilltimeout(function_21a3a673(4 - level.var_9e3c632e, 6 - level.var_9e3c632e), #"threshold_hit");
	}
}

/*
	Name: function_9a991dc2
	Namespace: zm_orange_mq_blood
	Checksum: 0xF2BC18D
	Offset: 0x19E0
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function function_9a991dc2(n_index)
{
	var_c80c2ab6 = spawn("script_model", level.var_4adebdfc.origin);
	var_c80c2ab6 setmodel("apothican_blood_sphere_16");
	var_c80c2ab6 clientfield::set("" + #"hash_5dd642a0bd6e6cb9", 1);
	var_c80c2ab6.b_frozen = 0;
	var_c80c2ab6.b_primed = 0;
	var_c80c2ab6.health = 999;
	var_c80c2ab6 val::set(#"mq_blood", "allowdeath", 0);
	var_c80c2ab6 val::set(#"mq_blood", "takedamage", 1);
	var_c80c2ab6 thread function_c2d403f(n_index);
	var_c80c2ab6 thread function_a4fa2df0(n_index);
	level.var_4adebdfc.a_wisps[n_index] = var_c80c2ab6;
}

/*
	Name: function_c2d403f
	Namespace: zm_orange_mq_blood
	Checksum: 0x4B6E3E19
	Offset: 0x1B58
	Size: 0x266
	Parameters: 1
	Flags: Linked
*/
function function_c2d403f(n_index)
{
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		if(isplayer(s_notify.attacker))
		{
			if(self.b_frozen)
			{
				if(self.b_primed)
				{
					self moveto(level.s_mq_blood_vessel_loc.vessel.origin, 0.7, 0.1, 0.1);
					wait(0.7);
					level.var_64f7b41e++;
					self thread util::delayed_delete(0.1);
				}
				else
				{
					var_3a253a6f = max(distance(self.origin, level.var_e70fa660[n_index].origin) / 1000, 1);
					self moveto(level.var_e70fa660[n_index].origin, var_3a253a6f, 0.2, 0.2);
					wait(var_3a253a6f);
					self.b_primed = 1;
					self notify(#"primed");
					self clientfield::set("" + #"hash_5dd642a0bd6e6cb9", 1);
					self.b_frozen = 0;
				}
			}
			else
			{
				if(isinarray(level.var_16972e5c, s_notify.weapon.name))
				{
					self clientfield::set("" + #"hash_5dd642a0bd6e6cb9", 2);
					self.b_frozen = 1;
				}
				else
				{
					self.b_near = 1;
				}
			}
		}
	}
}

/*
	Name: function_a4fa2df0
	Namespace: zm_orange_mq_blood
	Checksum: 0xFFBC5960
	Offset: 0x1DC8
	Size: 0x490
	Parameters: 1
	Flags: Linked
*/
function function_a4fa2df0(n_index)
{
	level endon(#"end_game");
	self endon(#"death", #"primed");
	if(level.var_9e3c632e > 2)
	{
		self moveto(level.var_e70fa660[n_index].origin, 0.3, 0.1, 0.1);
		self.b_primed = 1;
	}
	else
	{
		self.zone = "";
		while(!self.b_frozen)
		{
			zone = "";
			do
			{
				zone = array::random(level.var_9928b94b[n_index]);
				waitframe(1);
			}
			while(zone == self.zone);
			/#
				if(getdvarint(#"zm_debug_ee", 0))
				{
					if(getdvarint(#"zm_debug_ee", 0))
					{
						iprintlnbold("" + zone);
						println("" + zone);
					}
				}
			#/
			self.zone = zone;
			a_locations = struct::get_array("dog_location", "script_noteworthy");
			var_a4cd10ea = [];
			foreach(loc in a_locations)
			{
				if(loc.targetname === (self.zone + "_spawns"))
				{
					if(!isdefined(var_a4cd10ea))
					{
						var_a4cd10ea = [];
					}
					else if(!isarray(var_a4cd10ea))
					{
						var_a4cd10ea = array(var_a4cd10ea);
					}
					if(!isinarray(var_a4cd10ea, loc))
					{
						var_a4cd10ea[var_a4cd10ea.size] = loc;
					}
				}
			}
			loc = array::random(var_a4cd10ea);
			var_3a253a6f = max(distance(self.origin, loc.origin) / 1000, 1);
			self moveto(loc.origin + vectorscale((0, 0, 1), 50), var_3a253a6f, 0.2, 0.2);
			wait(var_3a253a6f);
			self.b_near = 0;
			while(!self.b_near)
			{
				a_players = zm_vo::function_347f7d34();
				foreach(player in a_players)
				{
					distance = distance(player.origin, self.origin);
					if(distance < 300 && player cansee(self))
					{
						self.b_near = 1;
					}
				}
				waitframe(1);
			}
		}
	}
}

