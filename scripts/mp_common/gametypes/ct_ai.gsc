// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\ct_utils.gsc;
#using scripts\mp_common\gametypes\ct_bots.gsc;
#using scripts\core_common\bots\bot_stance.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace ct_ai;

/*
	Name: function_4c8f915a
	Namespace: ct_ai
	Checksum: 0xF2990096
	Offset: 0x218
	Size: 0x2F0
	Parameters: 1
	Flags: None
*/
function function_4c8f915a(origin)
{
	team = #"axis";
	waittillframeend();
	var_d88f5623 = #"hash_153a326c2357a196";
	drone = spawnvehicle(var_d88f5623, origin, (0, 0, 0), "talon", undefined, 1);
	drone.team = team;
	drone.settings = struct::get_script_bundle("vehiclecustomsettings", drone.scriptbundlesettings);
	drone.isstunned = 0;
	drone.var_b61a6415 = 0;
	drone vehicle_ai::startinitialstate("combat");
	drone.customdamagemonitor = 1;
	drone.original_vehicle_type = drone.vehicletype;
	drone clientfield::set("enemyvehicle", 1);
	drone setvehicleavoidance(1);
	drone.type = "tank_drone";
	drone.dontdisconnectpaths = 1;
	drone.soundmod = "drone_land";
	drone.ignore_vehicle_underneath_splash_scalar = 1;
	drone.ignore_team_kills = 1;
	drone.var_b4c9d62 = 1;
	drone.offhand_special = 1;
	drone.var_e9d49a33 = 1;
	drone.goalradius = 250;
	if(isdefined(level.var_1dd2fbe1))
	{
		drone [[level.var_1dd2fbe1]]();
	}
	drone.controlled = 0;
	drone makevehicleunusable();
	drone.numberrockets = 4;
	drone.warningshots = 3;
	drone setdrawinfrared(1);
	target_set(drone, vectorscale((0, 0, 1), 20));
	drone vehicle::init_target_group();
	drone vehicle::add_to_target_group(drone);
	drone setneargoalnotifydist(35);
	drone playloopsound(#"hash_aa65b39680b8d1b");
	return drone;
}

/*
	Name: spawn_zombie
	Namespace: ct_ai
	Checksum: 0x8F9C0F33
	Offset: 0x510
	Size: 0x218
	Parameters: 3
	Flags: None
*/
function spawn_zombie(v_spawn_pos, b_keyline, var_8ac47d78)
{
	zombie = spawnactor("spawner_boct_zombie_mp", v_spawn_pos, (0, 0, 0), "zombie");
	if(!isdefined(zombie))
	{
		return;
	}
	zombie.var_10a6d7df = 0;
	zombie.var_3c5a5d29 = 0;
	zombie.navmeshpoint = undefined;
	zombie.var_86ba7e6d = 0;
	zombie.disabletargetservice = 1;
	zombie.var_5a8f690 = undefined;
	zombie.var_ea34ab74 = undefined;
	zombie.var_f38f922 = undefined;
	zombie.damagedone = 0;
	zombie.highlyawareradius = 10;
	zombie.var_ef59b90 = 3;
	zombie.var_9a79d89d = v_spawn_pos;
	zombie.var_5ab7c19c = (0, 0, 0);
	zombie.var_bab91f2 = 100;
	zombie.var_59860ee1 = 8000;
	zombie.var_dd940df3 = 12000;
	zombie.ai.var_3af1add3 = &function_f02d23b2;
	zombie.var_648ec54a = 1;
	if(isdefined(level.var_d9f6b173))
	{
		zombie thread [[level.var_d9f6b173]]();
	}
	if(isdefined(b_keyline) && b_keyline)
	{
		waitframe(1);
		zombie clientfield::set("actor_keyline_render", 1);
	}
	if(isdefined(var_8ac47d78) && var_8ac47d78)
	{
		zombie thread function_1495c8c(zombie.origin, zombie.angles, "ai_zombie_base_traverse_ground_climbout_fast");
	}
	return zombie;
}

/*
	Name: spawn_blight_father
	Namespace: ct_ai
	Checksum: 0x2235CBBC
	Offset: 0x730
	Size: 0x208
	Parameters: 4
	Flags: None
*/
function spawn_blight_father(v_spawn_pos, b_keyline, var_8ac47d78, var_158efaf3)
{
	zombie = spawnactor("spawner_mp_blight_father", v_spawn_pos, (0, 0, 0), "blightfather");
	if(!isdefined(zombie))
	{
		return;
	}
	zombie.var_10a6d7df = 0;
	zombie.var_3c5a5d29 = 0;
	zombie.navmeshpoint = undefined;
	zombie.var_86ba7e6d = 0;
	zombie.disabletargetservice = 1;
	zombie.var_5a8f690 = undefined;
	zombie.var_ea34ab74 = undefined;
	zombie.var_f38f922 = undefined;
	zombie.damagedone = 0;
	zombie.highlyawareradius = 10;
	zombie.var_ef59b90 = 3;
	zombie.var_9a79d89d = v_spawn_pos;
	zombie.var_5ab7c19c = (0, 0, 0);
	zombie.var_bab91f2 = 100;
	zombie.var_59860ee1 = 8000;
	zombie.var_dd940df3 = 12000;
	zombie.ai.var_3af1add3 = &function_f02d23b2;
	zombie.var_648ec54a = 1;
	if(isdefined(level.var_d9f6b173))
	{
		zombie thread [[level.var_d9f6b173]]();
	}
	if(isdefined(b_keyline) && b_keyline)
	{
		waitframe(1);
		zombie clientfield::set("actor_keyline_render", 1);
	}
	if(isdefined(var_158efaf3) && var_158efaf3)
	{
		zombie clientfield::set("enemy_on_radar", 1);
	}
	return zombie;
}

/*
	Name: function_1495c8c
	Namespace: ct_ai
	Checksum: 0x196C34A2
	Offset: 0x940
	Size: 0x242
	Parameters: 3
	Flags: None
*/
function function_1495c8c(v_origin, v_angles, anim_name)
{
	self endon(#"death");
	self clientfield::set("zombie_riser_fx", 1);
	self.in_the_ground = 1;
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}
	self.anchor = spawn("script_origin", self.origin);
	self.anchor.angles = self.angles;
	self linkto(self.anchor);
	if(!isdefined(v_angles))
	{
		v_angles = (0, 0, 0);
	}
	anim_org = v_origin;
	anim_ang = v_angles;
	anim_org = anim_org + (0, 0, 0);
	self ghost();
	self.anchor moveto(anim_org, 0.05);
	self.anchor waittill(#"movedone");
	self unlink();
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}
	self thread hide_pop();
	self orientmode("face default");
	self animscripted("rise_anim", self.origin, v_angles, anim_name, "normal");
	self notify(#"rise_anim_finished");
	self.in_the_ground = 0;
}

/*
	Name: hide_pop
	Namespace: ct_ai
	Checksum: 0x60BD9557
	Offset: 0xB90
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function hide_pop()
{
	self endon(#"death");
	self ghost();
	wait(0.5);
	if(isdefined(self))
	{
		self show();
		waitframe(1);
		if(isdefined(self))
		{
			self.create_eyes = 1;
		}
	}
}

/*
	Name: function_f02d23b2
	Namespace: ct_ai
	Checksum: 0xBDF97C24
	Offset: 0xC08
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_f02d23b2(var_f6a3e268)
{
	if(isdefined(var_f6a3e268.var_2925fedc))
	{
		return var_f6a3e268.var_2925fedc;
	}
	return var_f6a3e268.var_9a79d89d;
}

/*
	Name: function_45a6adc0
	Namespace: ct_ai
	Checksum: 0xF37E0C64
	Offset: 0xC48
	Size: 0xBA
	Parameters: 12
	Flags: None
*/
function function_45a6adc0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex)
{
	if(isdefined(level.var_403b73b4))
	{
		idamage = [[level.var_403b73b4]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
	}
	return idamage;
}

/*
	Name: spawn_warlord
	Namespace: ct_ai
	Checksum: 0xE54AE5A3
	Offset: 0xD10
	Size: 0x1D4
	Parameters: 2
	Flags: None
*/
function spawn_warlord(v_spawn_pos, var_9ac46b0e)
{
	warlord = spawnactor("spawner_boct_sidea_warlord_mp", v_spawn_pos, var_9ac46b0e, "warlord");
	warlord.overrideactordamage = &function_45a6adc0;
	warlord.var_10a6d7df = 0;
	warlord.var_3c5a5d29 = 0;
	warlord.navmeshpoint = undefined;
	warlord.var_86ba7e6d = 0;
	warlord.var_5a8f690 = undefined;
	warlord.var_ea34ab74 = undefined;
	warlord.var_f38f922 = undefined;
	warlord.damagedone = 0;
	warlord.highlyawareradius = 10;
	warlord.var_ef59b90 = 4;
	warlord.var_9a79d89d = v_spawn_pos;
	warlord.var_5ab7c19c = var_9ac46b0e;
	warlord.var_bab91f2 = 1000;
	warlord.var_59860ee1 = 8000;
	warlord.var_dd940df3 = 12000;
	warlord.ai.var_3af1add3 = &function_f02d23b2;
	warlord.var_648ec54a = 1;
	warlord val::set(#"nomad_warlord", "ignoreme", 1);
	if(isdefined(level.var_42a4603))
	{
		warlord thread [[level.var_42a4603]]();
	}
	waitframe(1);
	warlord clientfield::set("actor_keyline_render", 1);
}

/*
	Name: function_9ca5c5fc
	Namespace: ct_ai
	Checksum: 0xD9775351
	Offset: 0xEF0
	Size: 0x106
	Parameters: 3
	Flags: None
*/
function function_9ca5c5fc(v_loc, str_team, n_radius)
{
	var_4ed86107 = [];
	a_bots = ct_bots::function_fbe3dcbb();
	foreach(bot in a_bots)
	{
		if(bot.team == str_team)
		{
			n_dist = distance(v_loc, bot.origin);
			if(n_dist <= n_radius)
			{
				var_4ed86107[var_4ed86107.size] = bot;
			}
		}
	}
	return var_4ed86107;
}

/*
	Name: function_9313dd47
	Namespace: ct_ai
	Checksum: 0xD7AD30E4
	Offset: 0x1000
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function function_9313dd47(s_loc, n_radius)
{
	self endon(#"death");
	while(true)
	{
		n_dist = distance(s_loc.origin, self.origin);
		if(n_dist < n_radius)
		{
			e_player = getplayers()[0];
			self.var_2925fedc = e_player.origin;
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_12f9ed01
	Namespace: ct_ai
	Checksum: 0x3802CE2C
	Offset: 0x10B0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_12f9ed01(var_4abe70c5)
{
	self endon(#"deah");
	self.var_2925fedc = undefined;
	foreach(s_loc in var_4abe70c5)
	{
		self function_8e0db9e6(s_loc, 40, 40, 1);
	}
	self thread ct_utils::function_89cd182c(s_loc);
}

/*
	Name: function_8e0db9e6
	Namespace: ct_ai
	Checksum: 0xD28F75FD
	Offset: 0x1180
	Size: 0x14C
	Parameters: 4
	Flags: None
*/
function function_8e0db9e6(s_loc, var_feefa8d9, var_ecf349de, var_3fc5d539)
{
	self endon(#"death");
	if(isdefined(var_3fc5d539) && var_3fc5d539)
	{
		self bot_stance::stand();
	}
	self thread ct_utils::function_5b59f3b7(s_loc.origin, s_loc.angles, var_feefa8d9);
	while(true)
	{
		n_dist = distance(self.origin, s_loc.origin);
		if(n_dist <= var_feefa8d9)
		{
			break;
		}
		waitframe(1);
	}
	if(isdefined(s_loc.script_noteworthy) && s_loc.script_noteworthy == #"crouch")
	{
		self bot_stance::crouch();
	}
	self thread ct_utils::function_5b59f3b7(s_loc.origin, s_loc.angles, var_ecf349de);
}

