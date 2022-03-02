// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_25b8e6a85a7f8635;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_b9fd696c;

/*
	Name: preload
	Namespace: namespace_b9fd696c
	Checksum: 0x498ED2D2
	Offset: 0x7D0
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	clientfield::register("scriptmover", "" + #"hash_2a3dbcaa79e8e3d6", 20000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_5e1264789183cde1", 20000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_72a33f6d2cc925c5", 20000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_1df297369e47699a", 20000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_7d631c764117de1e", 20000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 20000, 1, "counter");
	clientfield::register("toplayer", "" + #"delete_model", 20000, 1, "counter");
	callback::on_spawned(&function_ba51762d);
}

/*
	Name: init
	Namespace: namespace_b9fd696c
	Checksum: 0x9A21B396
	Offset: 0x9C0
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function init()
{
	namespace_c3287616::register_archetype(#"mannequin", &function_f3cef15a, &mee_round_spawn, &function_293e9585, 5);
	level.var_1f856570 = array(function_fd846a91());
	array::thread_all(level.var_1f856570, &spawner::add_spawn_function, &zm_behavior::function_57d3b5eb);
	if(!zm_utility::function_e51dc2d8())
	{
		getent("ee_head", "targetname") delete();
	}
	level.var_22569770 = getent("e_spy", "targetname");
	level.var_22569770 hide();
	function_ec9e5cf2();
}

/*
	Name: function_ec9e5cf2
	Namespace: namespace_b9fd696c
	Checksum: 0x40E7B0F1
	Offset: 0xB30
	Size: 0x3F4
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	level flag::init("mee_round");
	level flag::init("mee_projectile_count_reached");
	namespace_ee206246::register(#"hash_104f80e15d623b58", #"step_1", #"hash_4fa5474cce491e7a", &function_ec78c3ce, &function_99e0948b);
	level flag::init("mee_melee_count_reached");
	var_57ce903d = getent("mee_2_female", "targetname");
	var_57ce903d hide();
	var_e979d075 = getentarray("e_mee_2_weeper_final", "targetname");
	foreach(e_model in var_e979d075)
	{
		e_model hide();
	}
	namespace_ee206246::register(#"hash_1e9936918d3e7bdd", #"step_1", #"hash_302164323de8aeff", &function_c5265b, &function_2dea6f24);
	level flag::init("mee_galvaknuckle_count_reached");
	namespace_ee206246::register(#"hash_3eeb31180b204955", #"step_1", #"hash_24b97ea56a2b24c7", &function_ca6ddaed, &function_a2c337dc);
	level flag::init("mee_mixed_count_reached");
	namespace_ee206246::register(#"hash_638821b038a894ea", #"step_1", #"hash_637cb3437044e304", &function_af78658, &function_af4d3b51);
	level flag::init(#"hash_502f2e83a538c679");
	level flag::init(#"hash_7346ae8e42a74ce6");
	namespace_ee206246::register(#"hash_306a7f142403b7c6", #"step_1", #"hash_3203b932029a4e0b", &function_4d029800, &function_e3a2a8ab);
	level flag::wait_till(#"all_players_spawned");
	if(zm_utility::function_e51dc2d8())
	{
		namespace_ee206246::start(#"hash_306a7f142403b7c6");
	}
}

/*
	Name: function_ec78c3ce
	Namespace: namespace_b9fd696c
	Checksum: 0x224077BD
	Offset: 0xF30
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_ec78c3ce(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"mee_projectile_count_reached");
	}
}

/*
	Name: function_99e0948b
	Namespace: namespace_b9fd696c
	Checksum: 0xDC8C7C12
	Offset: 0xF70
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_99e0948b(var_5ea5c94d, ended_early)
{
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	if(level.round_number < 25)
	{
		level.var_d2fac739 = 29 - level.round_number;
	}
	else
	{
		if(level.round_number < 60)
		{
			level.var_d2fac739 = 59 - level.round_number;
		}
		else
		{
			level.var_d2fac739 = 0;
		}
	}
	function_61e129a8();
}

/*
	Name: function_c5265b
	Namespace: namespace_b9fd696c
	Checksum: 0xC1110C3A
	Offset: 0x1088
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_c5265b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"mee_melee_count_reached");
	}
}

/*
	Name: function_2dea6f24
	Namespace: namespace_b9fd696c
	Checksum: 0x3CBA2D24
	Offset: 0x10C8
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_2dea6f24(var_5ea5c94d, ended_early)
{
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	function_800ff39e();
}

/*
	Name: function_ca6ddaed
	Namespace: namespace_b9fd696c
	Checksum: 0xB2964CEB
	Offset: 0x1178
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_ca6ddaed(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"mee_galvaknuckle_count_reached");
	}
}

/*
	Name: function_a2c337dc
	Namespace: namespace_b9fd696c
	Checksum: 0x933678F5
	Offset: 0x11B8
	Size: 0x262
	Parameters: 2
	Flags: Linked
*/
function function_a2c337dc(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_f5624728 = getplayers()[0];
	}
	s_look = struct::get("mee_3_look_target", "targetname");
	watcher = spawn("script_origin", s_look.origin);
	while(watcher function_7f971d26())
	{
		waitframe(1);
	}
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level.var_f5624728 clientfield::set_to_player("" + #"hash_72a33f6d2cc925c5", 0);
	watcher delete();
	var_74370e46 = getent("mee3_reward", "targetname");
	level thread trigger::look_trigger(var_74370e46);
	b_saw_the_wth = 0;
	while(!b_saw_the_wth)
	{
		waitresult = undefined;
		waitresult = var_74370e46 waittill(#"trigger_look");
		if(waitresult.activator == level.var_f5624728)
		{
			b_saw_the_wth = 1;
			level.var_f5624728 clientfield::increment_to_player("" + #"hash_1df297369e47699a", 1);
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_af78658
	Namespace: namespace_b9fd696c
	Checksum: 0x70D99423
	Offset: 0x1428
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_af78658(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"mee_mixed_count_reached");
	}
}

/*
	Name: function_af4d3b51
	Namespace: namespace_b9fd696c
	Checksum: 0x8E716C3A
	Offset: 0x1468
	Size: 0x17C
	Parameters: 2
	Flags: Linked
*/
function function_af4d3b51(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_561ae1f8 = 1;
		level.var_e80139f = 4;
		level flag::wait_till(#"mee_mixed_count_reached");
	}
	vec = anglestoforward(level.var_d53f00cb) + vectorscale((0, 0, 1), 15);
	var_e3f0084a = level.var_de56cee7.attacker magicgrenadeplayer(getweapon(#"hash_34b7eb9fde56bd35"), level.var_81603165 + vectorscale((0, 0, 1), 2), vec);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
}

/*
	Name: function_7b33625a
	Namespace: namespace_b9fd696c
	Checksum: 0x538998FE
	Offset: 0x15F0
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_7b33625a()
{
	if(isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_BURNED", "MOD_MELEE"), self.mod))
	{
		return false;
	}
	return true;
}

/*
	Name: function_ce7e594b
	Namespace: namespace_b9fd696c
	Checksum: 0xFFAF88D2
	Offset: 0x1668
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_ce7e594b()
{
	foreach(player in level.players)
	{
		if(isplayer(self.attacker) && !isbot(self.attacker))
		{
			if(isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_BURNED"), self.mod))
			{
				return false;
			}
			return true;
		}
	}
	return false;
}

/*
	Name: function_5b685950
	Namespace: namespace_b9fd696c
	Checksum: 0xF3EA36C6
	Offset: 0x1778
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_5b685950()
{
	var_8ce4094 = level.var_e80139f === 3;
	zm_weap_chakram_melee_hit_rumblemembers = self.weapon.name === #"galvaknuckles_t8";
	return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

/*
	Name: function_6e0162e8
	Namespace: namespace_b9fd696c
	Checksum: 0x50FD79A9
	Offset: 0x17D8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_6e0162e8()
{
	var_8ce4094 = level.var_e80139f === 2;
	zm_weap_chakram_melee_hit_rumblemembers = self.mod === "MOD_MELEE";
	return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

/*
	Name: function_663fd427
	Namespace: namespace_b9fd696c
	Checksum: 0x7F911A45
	Offset: 0x1830
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_663fd427()
{
	var_8ce4094 = level.var_e80139f === 1;
	zm_weap_chakram_melee_hit_rumblemembers = self function_7b33625a();
	return var_8ce4094 && !zm_weap_chakram_melee_hit_rumblemembers;
}

/*
	Name: function_8d3f2364
	Namespace: namespace_b9fd696c
	Checksum: 0x782EF3ED
	Offset: 0x1888
	Size: 0x7A4
	Parameters: 1
	Flags: Linked
*/
function function_8d3f2364(waitresult)
{
	level endon(#"game_ended", #"insanity_mode_triggered");
	if(isdefined(level.var_73d1e054) && level.var_73d1e054)
	{
		return;
	}
	if(level.var_561ae1f8 <= 0 || level flag::get(#"hash_48039f3a4c1a3248"))
	{
		return;
	}
	if(level.var_e80139f === 0)
	{
		if(waitresult.mod === "MOD_MELEE")
		{
			if(waitresult.weapon.name === #"galvaknuckles_t8")
			{
				level.var_e80139f = 3;
				namespace_ee206246::start(#"hash_3eeb31180b204955");
				/#
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						if(getdvarint(#"hash_11ad6a9695943217", 0))
						{
							iprintlnbold("");
							println("");
						}
					}
				#/
			}
			else
			{
				level.var_e80139f = 2;
				namespace_ee206246::start(#"hash_1e9936918d3e7bdd");
				/#
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						if(getdvarint(#"hash_11ad6a9695943217", 0))
						{
							iprintlnbold("");
							println("");
						}
					}
				#/
			}
		}
		else if(waitresult function_7b33625a())
		{
			level.var_e80139f = 1;
			namespace_ee206246::start(#"hash_104f80e15d623b58");
			/#
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						iprintlnbold("");
						println("");
					}
				}
			#/
		}
	}
	else if(!level.var_e80139f == 4)
	{
		if(waitresult function_5b685950() || waitresult function_6e0162e8() || waitresult function_663fd427())
		{
			/#
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						iprintlnbold("");
						println("");
					}
				}
			#/
			/#
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						iprintlnbold("");
						println("");
					}
				}
			#/
			playsoundatposition(#"hash_8b7db1eb1a3365b", (0, 0, 0));
			namespace_ee206246::start(#"hash_638821b038a894ea");
			level.var_e80139f = 4;
			waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_negative");
		}
	}
	level.var_561ae1f8--;
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("" + level.var_561ae1f8);
				println("" + level.var_561ae1f8);
			}
		}
	#/
	if(level.var_561ae1f8 <= 0)
	{
		playsoundatposition(#"hash_a24b8d649da9f00", (0, 0, 0));
		if(zm_utility::is_trials())
		{
			waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
			level flag::set(#"hash_7346ae8e42a74ce6");
		}
		else
		{
			if(level.var_e80139f == 1)
			{
				waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
				level flag::set("mee_projectile_count_reached");
			}
			else
			{
				if(level.var_e80139f == 2)
				{
					waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
					level flag::set("mee_melee_count_reached");
				}
				else
				{
					if(level.var_e80139f == 3)
					{
						waitresult.attacker zm_audio::create_and_play_dialog("generic", "response_positive");
						level flag::set("mee_galvaknuckle_count_reached");
						level.var_f5624728 = waitresult.attacker;
					}
					else
					{
						level.var_de56cee7 = waitresult;
						level flag::set("mee_mixed_count_reached");
					}
				}
			}
		}
	}
}

/*
	Name: function_e9768f1f
	Namespace: namespace_b9fd696c
	Checksum: 0x3C98EA03
	Offset: 0x2038
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_e9768f1f()
{
	level.var_561ae1f8 = 0;
	level.var_e80139f = 0;
	level.var_df3991a = getentarray("dummy", "targetname");
	level.var_561ae1f8 = level.var_df3991a.size;
	if(level.var_df3991a.size <= 0)
	{
		return;
	}
	foreach(m in level.var_df3991a)
	{
		if(isdefined(m))
		{
			m thread function_6e678915();
			m thread function_edcadf04();
		}
	}
}

/*
	Name: function_e32cc1a7
	Namespace: namespace_b9fd696c
	Checksum: 0x6ED4A1F8
	Offset: 0x2148
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_e32cc1a7(var_8c7a21ea, var_7dc08477)
{
	return var_8c7a21ea.script_noteworthy == "head";
}

/*
	Name: function_a292531e
	Namespace: namespace_b9fd696c
	Checksum: 0xBA787EE8
	Offset: 0x2178
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_a292531e(var_8c7a21ea, var_7dc08477)
{
	return var_8c7a21ea.script_noteworthy == "body";
}

/*
	Name: function_edcadf04
	Namespace: namespace_b9fd696c
	Checksum: 0x87045EA5
	Offset: 0x21A8
	Size: 0x35C
	Parameters: 0
	Flags: Linked
*/
function function_edcadf04()
{
	self notify("1bf25477c2dd3455");
	self endon("1bf25477c2dd3455");
	self setcandamage(1);
	self val::set("quest_mee", "allowDeath", 0);
	self endon(#"death");
	e_head = self;
	if(zm_utility::function_e51dc2d8() || level flag::get(#"hash_502f2e83a538c679"))
	{
		pixbeginevent(#"hash_76daa837c3b1d91b");
		b_player_damaged = 0;
		while(!b_player_damaged)
		{
			self.health = 999;
			waitresult = undefined;
			waitresult = self waittill(#"damage");
			b_player_damaged = waitresult function_ce7e594b();
			if(!b_player_damaged)
			{
				waitframe(1);
			}
		}
		angles = e_head.angles;
		origin = e_head.origin;
		force = vectornormalize(origin - waitresult.position);
		force = force + (0, 0, randomfloatrange(0.4, 0.6));
		force = force * randomfloatrange(0.4, 0.6);
		head_model = "p8_zm_white_mannequin_female_01_head_dyn";
		if(self.male_head)
		{
			head_model = "p8_zm_white_mannequin_male_01_head_dyn";
			if(self.model == #"hash_6b4ae942a9a5301b")
			{
				head_model = "c_t8_zmb_dlc3_mannequin_male_damage_head_2_dyn";
			}
		}
		self notsolid();
		createdynentandlaunch(head_model, origin, angles, origin, force);
		var_d569099e = spawn("script_model", e_head.origin);
		var_d569099e thread function_f05235a0();
		level.var_81603165 = e_head.origin;
		level.var_d53f00cb = e_head.angles;
		if(!zm_utility::is_standard())
		{
			self function_8d3f2364(waitresult);
		}
		pixendevent();
		self delete();
	}
}

/*
	Name: function_f05235a0
	Namespace: namespace_b9fd696c
	Checksum: 0x63585968
	Offset: 0x2510
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_f05235a0()
{
	self endon(#"death");
	self clientfield::set("" + #"hash_5e1264789183cde1", 1);
	playsoundatposition(#"hash_452b9f142d5f6352", self.origin);
	wait(1);
	self delete();
}

/*
	Name: function_303c5d09
	Namespace: namespace_b9fd696c
	Checksum: 0x78467758
	Offset: 0x25A0
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function function_303c5d09()
{
	if(isdefined(self.var_4073461b))
	{
		if(self.var_4073461b == 1)
		{
			var_bd8043ec = randomintrange(0, 4);
			if(var_bd8043ec == 0)
			{
				return;
			}
			if(isassetloaded("xmodel", (self.model + "_color_0") + string(var_bd8043ec)))
			{
				self setmodel((self.model + "_color_0") + string(var_bd8043ec));
			}
		}
	}
}

/*
	Name: function_6e678915
	Namespace: namespace_b9fd696c
	Checksum: 0xA8A3B519
	Offset: 0x2680
	Size: 0x200
	Parameters: 0
	Flags: Linked
*/
function function_6e678915()
{
	self endon(#"death");
	while(isdefined(self))
	{
		b_player_in_range = 0;
		while(!b_player_in_range)
		{
			wait(function_21a3a673(4, 8));
			player = namespace_509a75d1::function_3815943c();
			if(isdefined(player))
			{
				distance = distance(player.origin, self.origin);
				if(player cansee(self) && distance < 240)
				{
					b_player_in_range = 1;
				}
			}
		}
		if(isdefined(self))
		{
			if(math::cointoss(10))
			{
				if(math::cointoss(20))
				{
					angles = function_794aee3c(player.origin, self);
					self rotateto(angles, 0.1);
				}
				else
				{
					for(i = 0; i < 5; i++)
					{
						if(isdefined(self) && isdefined(player))
						{
							angles = function_794aee3c(player.origin, self, 1);
							self rotateto(angles, 1);
							wait(1);
						}
					}
				}
			}
			wait(function_21a3a673(4, 8));
		}
	}
}

/*
	Name: function_794aee3c
	Namespace: namespace_b9fd696c
	Checksum: 0x1FBE5732
	Offset: 0x2888
	Size: 0x184
	Parameters: 3
	Flags: Linked
*/
function function_794aee3c(player_pos, e_head, b_tracking = 0)
{
	player_pos = (player_pos[0], player_pos[1], 0) + (0, 0, e_head.origin[2]);
	player_vec = player_pos - e_head.origin;
	angles = vectortoangles(player_vec);
	if(b_tracking)
	{
		x = difftrackangle(angles[0], e_head.angles[0], 0.5, 1);
		y = difftrackangle(angles[1], e_head.angles[1], 0.5, 1);
		z = difftrackangle(angles[2], e_head.angles[2], 0.5, 1);
		angles = (x, y, z);
	}
	return angles;
}

/*
	Name: function_61e129a8
	Namespace: namespace_b9fd696c
	Checksum: 0x52E91A3D
	Offset: 0x2A18
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function function_61e129a8()
{
	level flag::set("mee_round");
	var_d1ec2571 = level.round_number + 1;
	b_delayed = 0;
	do
	{
		if(level flag::get(#"hash_7cc3b03eefb11fc") && !level flag::get(#"crawler_step_complete") || (level flag::get(#"hash_6ebb9d0d0539bf68") && !level flag::get(#"hash_7c2ae917559738ec")))
		{
			b_delayed = 1;
			wait(1);
		}
		else
		{
			var_d1ec2571 = level.round_number + 1;
			b_delayed = 0;
		}
	}
	while(b_delayed);
	var_898a45da = level.var_45827161[var_d1ec2571];
	if(isdefined(var_898a45da))
	{
		namespace_c3287616::function_43aed0ca(var_d1ec2571);
	}
	level.zombie_round_start_delay = 0;
	namespace_c3287616::function_b4a8f95a(#"mannequin", var_d1ec2571, &function_991eb140, &function_bc9a7799, &function_b76df747, &function_e2d1e574, 0);
	if(namespace_c3287616::function_40229072(level.round_number) && !level flag::get("special_round"))
	{
		level waittill(#"special_round");
	}
	else if(!level flag::get("begin_spawning"))
	{
		level waittill(#"begin_spawning");
	}
	namespace_509a75d1::function_2ba419ee(0);
}

/*
	Name: function_991eb140
	Namespace: namespace_b9fd696c
	Checksum: 0xDAFFBB48
	Offset: 0x2C88
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_991eb140()
{
	level flag::set("mee_round");
	level.var_5edd153f = 1;
	callback::on_laststand(&function_1025a301);
	namespace_c3287616::function_5bc2cea1(&namespace_c402654::function_ed67c5e7);
	level thread zm_audio::sndmusicsystem_playstate("dog_start");
	level thread zm_audio::sndannouncerplayvox(undefined, undefined, "vox_event_robotstart_avoa_0");
}

/*
	Name: function_d45ae839
	Namespace: namespace_b9fd696c
	Checksum: 0x82346CDC
	Offset: 0x2D48
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function function_d45ae839()
{
	return false;
}

/*
	Name: function_1025a301
	Namespace: namespace_b9fd696c
	Checksum: 0x6FBB541D
	Offset: 0x2D58
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_1025a301()
{
	a_players = getplayers();
	if(a_players.size < 2)
	{
		level.var_5edd153f = 0;
		namespace_509a75d1::function_2ba419ee();
	}
}

/*
	Name: function_fd846a91
	Namespace: namespace_b9fd696c
	Checksum: 0x5BFCA1EF
	Offset: 0x2DB0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_fd846a91()
{
	spawner = getent("mannequin_zombie_spawner", "script_noteworthy");
	return spawner;
}

/*
	Name: function_bc9a7799
	Namespace: namespace_b9fd696c
	Checksum: 0x76EE118E
	Offset: 0x2DF0
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_bc9a7799(var_d25bbdd5)
{
	level flag::clear("mee_round");
	if(isdefined(level.var_5edd153f) && level.var_5edd153f)
	{
		level thread function_6af32608();
	}
	callback::function_53888e7f(&function_1025a301);
	namespace_c3287616::function_df803678(&namespace_c402654::function_ed67c5e7);
	level thread zm_audio::sndmusicsystem_playstate("dog_end");
	level.fn_custom_zombie_spawner_selection = undefined;
	level.zombie_round_start_delay = undefined;
	wait(5);
}

/*
	Name: function_b76df747
	Namespace: namespace_b9fd696c
	Checksum: 0x9249E847
	Offset: 0x2ED8
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function function_b76df747()
{
	a_e_players = getplayers();
	n_max = 10;
	switch(a_e_players.size)
	{
		case 1:
		{
			n_max = 60;
			break;
		}
		case 2:
		{
			n_max = 90;
			break;
		}
		case 3:
		case 4:
		{
			n_max = 120;
			break;
		}
	}
	return n_max;
}

/*
	Name: function_e2d1e574
	Namespace: namespace_b9fd696c
	Checksum: 0x6B5F4285
	Offset: 0x2F90
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_e2d1e574()
{
	n_time = namespace_a28acff3::get_zombie_spawn_delay(level.round_number + level.var_d2fac739);
	wait(n_time);
}

/*
	Name: function_6af32608
	Namespace: namespace_b9fd696c
	Checksum: 0xD091CFAC
	Offset: 0x2FD8
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_6af32608()
{
	if(!zm_utility::is_standard())
	{
		drop_point = struct::get("mee_perk_drop");
		var_c9e07c3e = drop_point.origin;
		level.var_dcd1e798 = getent("perk_machine_mover", "targetname");
		level.var_dcd1e798 useanimtree("generic");
		var_2379bb0e = spawn("script_model", var_c9e07c3e);
		var_2379bb0e setmodel("zombie_pickup_perk_bottle");
		var_2379bb0e hide();
		level.var_dcd1e798.origin = var_c9e07c3e;
		var_2379bb0e linkto(level.var_dcd1e798, "tag_animate_origin");
		level.var_dcd1e798 thread animation::play("p8_fxanim_zm_white_perk_machine_dummy_fly_in");
		waitframe(2);
		var_2379bb0e show();
		wait(3.5);
		level thread namespace_9efb8d22::function_48acb6ed(var_c9e07c3e);
		playrumbleonposition("zm_white_perk_impact", var_c9e07c3e);
		playrumbleonposition("zm_white_perk_aftershock", var_c9e07c3e);
		level thread zm_powerups::specific_powerup_drop("free_perk", var_c9e07c3e, undefined, 0.1, undefined, 1);
		var_2379bb0e delete();
	}
}

/*
	Name: function_2c41e66e
	Namespace: namespace_b9fd696c
	Checksum: 0xAA0D8C4C
	Offset: 0x31D8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_2c41e66e(params)
{
	if(zombie_utility::get_current_zombie_count() == 1 && level.zombie_total == 0)
	{
		self thread function_6af32608();
	}
}

/*
	Name: function_293e9585
	Namespace: namespace_b9fd696c
	Checksum: 0xC11BBF7C
	Offset: 0x3230
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_293e9585()
{
	spawner = function_fd846a91();
	spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
	ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point, level.round_number + level.var_d2fac739);
	return ai;
}

/*
	Name: mee_round_spawn
	Namespace: namespace_b9fd696c
	Checksum: 0xF2FBDEC0
	Offset: 0x32D8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function mee_round_spawn()
{
	ai = function_293e9585();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

/*
	Name: function_f3cef15a
	Namespace: namespace_b9fd696c
	Checksum: 0x799A3DF4
	Offset: 0x3320
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_f3cef15a(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 5));
	if(level.round_number < 20)
	{
		var_a8ce2d71 = 0.02;
	}
	else
	{
		if(level.round_number < 30)
		{
			var_a8ce2d71 = 0.03;
		}
		else
		{
			var_a8ce2d71 = 0.04;
		}
	}
	return min(var_8cf00d40, int(ceil(level.zombie_total * var_a8ce2d71)));
}

/*
	Name: function_7f971d26
	Namespace: namespace_b9fd696c
	Checksum: 0xAF916774
	Offset: 0x3410
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_7f971d26()
{
	foreach(player in level.players)
	{
		if(player cansee(self))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_800ff39e
	Namespace: namespace_b9fd696c
	Checksum: 0xC170F060
	Offset: 0x34A8
	Size: 0x8F4
	Parameters: 0
	Flags: Linked
*/
function function_800ff39e()
{
	level endon(#"boss_lockdown", #"game_ended");
	while(level.var_22569770 function_7f971d26())
	{
		waitframe(1);
	}
	spawner = getent("weeping_spawner", "script_noteworthy");
	level.var_5f4eaf85 = zombie_utility::spawn_zombie(spawner, spawner.targetname, undefined, level.round_number);
	level.var_5f4eaf85 setmodel("c_t8_zmb_dlc3_mannequin_male");
	level.var_5f4eaf85.var_72411ccf = &function_589845fe;
	level.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "takedamage", 0);
	level.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "ignoreme", 1);
	level.var_5f4eaf85.team = #"team3";
	var_83302022 = getent("t_mee_2_activate", "targetname");
	level thread trigger::look_trigger(var_83302022);
	waitresult = undefined;
	waitresult = var_83302022 waittill(#"trigger_look");
	var_83302022 delete();
	level.var_5f4eaf85.var_72411ccf = undefined;
	level.var_5f4eaf85 thread function_d10bf985();
	level.var_57ce903d = getent("mee_2_female", "targetname");
	level.var_57ce903d show();
	level.var_7b22edab = spawn("script_origin", level.var_57ce903d.origin + vectorscale((0, 0, 1), 10));
	while(!level.var_5f4eaf85 is_near("mee_2_follow_trigger"))
	{
		waitframe(1);
	}
	level.var_57ce903d thread function_6fa00342(level.var_5f4eaf85);
	s_goal = struct::get("s_mee_2_goalPos", "targetname");
	level.var_5f4eaf85.var_3d366381 = getclosestpointonnavmesh(s_goal.origin, 32);
	level.var_5f4eaf85.team = #"allies";
	level.var_5f4eaf85 zombie_utility::set_zombie_run_cycle("run");
	level.var_5f4eaf85.var_72411ccf = &function_589845fe;
	while(!level.var_5f4eaf85 is_near("mee_2_shed"))
	{
		waitframe(1);
	}
	level.var_57ce903d notify(#"follow_complete");
	level.var_5f4eaf85.var_3d366381 = undefined;
	e_door = getent("mee_2_door", "targetname");
	e_door playsound("zmb_shed_door_open");
	e_door rotateto(vectorscale((0, 1, 0), 202), 1);
	wait(2);
	var_e979d075 = getentarray("e_mee_2_weeper_final", "targetname");
	while(level.var_5f4eaf85 function_7f971d26() || level.var_57ce903d function_7f971d26() || var_e979d075[0] function_7f971d26())
	{
		waitframe(1);
	}
	if(isdefined(level.var_5f4eaf85.kill_brush))
	{
		level.var_5f4eaf85.kill_brush delete();
	}
	level.var_5f4eaf85 delete();
	level.var_7b22edab delete();
	level.var_57ce903d show();
	foreach(e_model in var_e979d075)
	{
		e_model show();
	}
	var_881f5a41 = struct::get("s_mee_2_partner_final", "targetname");
	level.var_57ce903d.origin = var_881f5a41.origin;
	level.var_57ce903d.angles = var_881f5a41.angles;
	var_1d15513c = struct::get("s_mee_2_partner_final_head", "targetname");
	var_1ccba54f = getent("e_mee_2_partner_head", "targetname");
	var_1ccba54f.origin = var_1d15513c.origin;
	var_1ccba54f.angles = var_1d15513c.angles;
	var_c3a00a1a = getent("t_mee_2_shed", "targetname");
	level thread trigger::look_trigger(var_c3a00a1a);
	waitresult = undefined;
	waitresult = var_c3a00a1a waittill(#"trigger_look");
	var_c3a00a1a delete();
	e_door playsound("zmb_shed_door_close");
	e_door rotateto(vectorscale((0, 1, 0), 340), 1);
	wait(2);
	e_player = waitresult.activator;
	s_reward = struct::get("s_mee_2_reward", "targetname");
	var_4d0b3b87 = spawn("script_model", s_reward.origin);
	var_4d0b3b87 setmodel("p8_zm_gla_heart_zombie");
	var_4d0b3b87 movez(5, 1);
	var_4d0b3b87 thread powerup_wobble_fx();
	var_4d0b3b87 playsound("zmb_shed_powerup_burst");
	s_reward.var_4d0b3b87 = var_4d0b3b87;
	s_reward zm_unitrigger::create(&function_ce3168e6);
	s_reward thread function_50aeeeff();
}

/*
	Name: function_d10bf985
	Namespace: namespace_b9fd696c
	Checksum: 0x2D9513DC
	Offset: 0x3DA8
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_d10bf985()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.is_inert) && self.is_inert)
		{
			wait(2);
			if(isdefined(self.is_inert) && self.is_inert)
			{
				self.kill_brush = spawn("trigger_radius", self.origin, 0, 30, 72);
				self.kill_brush.script_noteworthy = "kill_brush";
				self.kill_brush thread function_d857924d();
				while(isdefined(self.is_inert) && self.is_inert)
				{
					waitframe(1);
				}
				self.kill_brush delete();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_d857924d
	Namespace: namespace_b9fd696c
	Checksum: 0x551C79F2
	Offset: 0x3EB0
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function function_d857924d()
{
	self endoncallback(&function_33e0a5d1, #"death");
	while(true)
	{
		foreach(player in getplayers())
		{
			if(player istouching(self) && player clientfield::get_to_player("zm_zone_out_of_bounds") == 0)
			{
				player clientfield::set_to_player("zm_zone_out_of_bounds", 1);
				continue;
			}
			if(!player istouching(self) && player clientfield::get_to_player("zm_zone_out_of_bounds") == 1)
			{
				player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_33e0a5d1
	Namespace: namespace_b9fd696c
	Checksum: 0x41740A77
	Offset: 0x4030
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_33e0a5d1(str_notify)
{
	foreach(player in getplayers())
	{
		player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
	}
}

/*
	Name: function_589845fe
	Namespace: namespace_b9fd696c
	Checksum: 0xE4ED01E
	Offset: 0x40C8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_589845fe(behaviortreeentity)
{
	if(function_5ebeab8c() && isdefined(behaviortreeentity.var_3d366381))
	{
		behaviortreeentity setgoal(behaviortreeentity.var_3d366381);
	}
	else
	{
		behaviortreeentity setgoal(behaviortreeentity.origin);
	}
}

/*
	Name: function_5ebeab8c
	Namespace: namespace_b9fd696c
	Checksum: 0x804BA9C0
	Offset: 0x4148
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_5ebeab8c()
{
	foreach(player in getplayers())
	{
		dist = distancesquared(self.origin, player.origin);
		if(dist <= 262144)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_ce3168e6
	Namespace: namespace_b9fd696c
	Checksum: 0x723FEEBE
	Offset: 0x4208
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_ce3168e6(e_player)
{
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_59a1cf82de6de51");
	}
	else
	{
		self sethintstring(#"hash_69320c1b3c0f8fdb");
	}
	return true;
}

/*
	Name: function_50aeeeff
	Namespace: namespace_b9fd696c
	Checksum: 0x5AF31104
	Offset: 0x4278
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_50aeeeff()
{
	self endon(#"death");
	self waittill(#"trigger_activated");
	a_e_players = getplayers();
	foreach(player in a_e_players)
	{
		player zm_laststand::function_3a00302e();
	}
	self.var_4d0b3b87 delete();
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: powerup_wobble_fx
	Namespace: namespace_b9fd696c
	Checksum: 0x5DA69851
	Offset: 0x4370
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function powerup_wobble_fx()
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	self clientfield::set("powerup_fx", 1);
}

/*
	Name: is_near
	Namespace: namespace_b9fd696c
	Checksum: 0xD59DB4AA
	Offset: 0x43C0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function is_near(str_info)
{
	t_proximity = getent(str_info, "targetname");
	if(isdefined(self))
	{
		b_near = self istouching(t_proximity);
		return b_near;
	}
	return 0;
}

/*
	Name: function_6fa00342
	Namespace: namespace_b9fd696c
	Checksum: 0x2A36A1CF
	Offset: 0x4438
	Size: 0x1D6
	Parameters: 1
	Flags: Linked
*/
function function_6fa00342(var_374b5229)
{
	self endon(#"follow_complete");
	level endon(#"hash_366807a48fc105bb");
	while(true)
	{
		var_9d88bc68 = anglestoforward(var_374b5229.angles);
		var_9d88bc68 = 15 * vectornormalize(var_9d88bc68);
		goal_pos = var_374b5229.origin - var_9d88bc68;
		goal_pos = getnearestpathpoint(goal_pos, 64);
		level.var_7b22edab.origin = goal_pos + vectorscale((0, 0, 1), 15);
		if(self function_66a7e20a() && level.var_7b22edab function_66a7e20a())
		{
			self ghost();
			self.origin = goal_pos;
			var_6dcf609c = (var_374b5229.origin[0], var_374b5229.origin[1], 0) + (0, 0, self.origin[2]);
			var_61e1fa2f = var_6dcf609c - self.origin;
			var_867c9147 = vectortoangles(var_61e1fa2f);
			self.angles = var_867c9147;
			waitframe(1);
			self show();
		}
		waitframe(1);
	}
}

/*
	Name: function_66a7e20a
	Namespace: namespace_b9fd696c
	Checksum: 0xF52161BC
	Offset: 0x4618
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function function_66a7e20a()
{
	foreach(player in getplayers())
	{
		if(player cansee(self))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_ba51762d
	Namespace: namespace_b9fd696c
	Checksum: 0x35079EB3
	Offset: 0x46B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_ba51762d()
{
	self endon(#"disconnect");
	level flag::wait_till("start_zombie_round_logic");
	waitframe(1);
	self clientfield::set_to_player("" + #"hash_72a33f6d2cc925c5", 1);
}

/*
	Name: function_c4fbad3
	Namespace: namespace_b9fd696c
	Checksum: 0x6EB40216
	Offset: 0x4728
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_c4fbad3()
{
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_4b660ce0();
		level thread function_3117c10();
	}
	level thread function_e9768f1f();
}

/*
	Name: function_4b660ce0
	Namespace: namespace_b9fd696c
	Checksum: 0x964DD273
	Offset: 0x4790
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_4b660ce0()
{
	level waittill(#"nuke_clock_moved");
	level waittill(#"magic_door_power_up_grabbed");
	if(level.population_count == 15)
	{
		/#
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
		#/
	}
}

/*
	Name: function_3117c10
	Namespace: namespace_b9fd696c
	Checksum: 0x55160DB1
	Offset: 0x4860
	Size: 0x1FA
	Parameters: 0
	Flags: Linked
*/
function function_3117c10()
{
	var_28560003 = getentarray("teddy_bear", "targetname");
	foreach(var_7da32058 in var_28560003)
	{
		unitrigger_stub = spawnstruct();
		unitrigger_stub.related_parent = var_7da32058;
		unitrigger_stub.origin = var_7da32058.origin;
		unitrigger_stub.angles = var_7da32058.angles;
		unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
		unitrigger_stub.cursor_hint = "HINT_NOICON";
		unitrigger_stub.script_width = 64;
		unitrigger_stub.script_height = 64;
		unitrigger_stub.script_length = 64;
		unitrigger_stub.require_look_at = 0;
		unitrigger_stub.targetname = "teddy_bear_unitrigger";
		unitrigger_stub.hint_string = undefined;
		unitrigger_stub.hint_parm1 = undefined;
		unitrigger_stub.hint_parm2 = undefined;
		unitrigger_stub.e_model = var_7da32058;
		unitrigger_stub.e_model playloopsound(#"hash_1fd4928ce5489175");
		zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_15534b78);
		var_7da32058.unitrigger_stub = unitrigger_stub;
	}
	level.meteor_counter = 0;
}

/*
	Name: function_15534b78
	Namespace: namespace_b9fd696c
	Checksum: 0x5F87B969
	Offset: 0x4A68
	Size: 0x25C
	Parameters: 0
	Flags: Linked
*/
function function_15534b78()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	player = waitresult.activator;
	self.stub.e_model stoploopsound();
	self.stub.e_model playsound(#"hash_20284b79e543698c");
	level.meteor_counter++;
	if(level.meteor_counter == 3)
	{
		if(level.musicsystem.currentplaytype < 4)
		{
			level thread zm_audio::sndmusicsystem_stopandflush();
			waitframe(1);
			level thread zm_audio::sndmusicsystem_playstate("ee_song_main");
		}
		/#
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
		#/
	}
	else
	{
		/#
			iprintlnbold(("" + level.meteor_counter) + "");
			println(("" + level.meteor_counter) + "");
		#/
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
			}
		}
	}
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: on_player_connect
	Namespace: namespace_b9fd696c
	Checksum: 0x73D16028
	Offset: 0x4CD0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread track_player_eyes();
}

/*
	Name: function_4d029800
	Namespace: namespace_b9fd696c
	Checksum: 0x849ADE42
	Offset: 0x4CF8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_4d029800(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread track_player_eyes();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: track_player_eyes
	Namespace: namespace_b9fd696c
	Checksum: 0x29C7251F
	Offset: 0x4DB0
	Size: 0x278
	Parameters: 0
	Flags: Linked
*/
function track_player_eyes()
{
	self notify(#"track_player_eyes");
	self endon(#"disconnect", #"track_player_eyes");
	level endon(#"hash_10a56459715cd20e", #"insanity_mode_triggered");
	self thread function_cbeb9a33();
	b_saw_the_wth = 0;
	var_616e76c5 = struct::get("sq_gl_scare", "targetname");
	waitframe(1);
	self clientfield::increment_to_player("" + #"hash_7d631c764117de1e", 1);
	while(!b_saw_the_wth)
	{
		for(n_time = 0; self adsbuttonpressed() && n_time < 90; n_time++)
		{
			waitframe(1);
		}
		if(n_time >= 90 && self adsbuttonpressed() && self zm_zonemgr::entity_in_zone("zone_green_backyard") && is_weapon_sniper(self getcurrentweapon()) && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self))
		{
			self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
			self clientfield::increment_to_player("" + #"hash_f2d0b920043dbbd", 1);
			for(j_time = 0; self adsbuttonpressed() && j_time < 5; j_time++)
			{
				waitframe(1);
			}
			b_saw_the_wth = 1;
		}
		waitframe(1);
	}
}

/*
	Name: is_weapon_sniper
	Namespace: namespace_b9fd696c
	Checksum: 0xAAC0C93C
	Offset: 0x5030
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
function private is_weapon_sniper(w_weapon)
{
	if(isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon)
	{
		if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is"))
		{
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: function_e3a2a8ab
	Namespace: namespace_b9fd696c
	Checksum: 0xD74946C2
	Offset: 0x50F8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_e3a2a8ab(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_b9fd696c
	Checksum: 0x670206BB
	Offset: 0x5118
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	if(isdefined(self))
	{
		self clientfield::increment_to_player("" + #"delete_model", 1);
	}
}

