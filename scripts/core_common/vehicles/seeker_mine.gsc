// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\arc.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\vehicles\smart_bomb.gsc;
#using scripts\core_common\globallogic\globallogic_score.gsc;
#using scripts\core_common\targetting_delay.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\statemachine_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace seeker_mine;

/*
	Name: __init__system__
	Namespace: seeker_mine
	Checksum: 0xBB58545B
	Offset: 0x230
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"seeker_mine", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: seeker_mine
	Checksum: 0xFD03A9A8
	Offset: 0x278
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	vehicle::add_main_callback("seeker_mine", &function_b23e4b45);
	clientfield::register("vehicle", "seeker_mine_fx", 1, 1, "int");
	clientfield::register("vehicle", "seeker_mine_light_fx", 1, 1, "int");
	if(!isdefined(level.var_477515d3))
	{
		level.var_477515d3 = new throttle();
		[[ level.var_477515d3 ]]->initialize(1, 0.1);
	}
	/#
		level thread update_dvars();
	#/
}

/*
	Name: update_dvars
	Namespace: seeker_mine
	Checksum: 0x4EA9FBD3
	Offset: 0x370
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function update_dvars()
{
	/#
		while(true)
		{
			wait(1);
			level.var_d3c21969 = getdvarint(#"hash_6b0c29fe436582f0", 0);
		}
	#/
}

/*
	Name: is_in_water
	Namespace: seeker_mine
	Checksum: 0x93C618D8
	Offset: 0x3C8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function is_in_water(location)
{
	var_8a7edebd = 15;
	depth = getwaterheight(location) - self.origin[2];
	inwater = depth > var_8a7edebd;
	if(inwater)
	{
		return true;
	}
	return false;
}

/*
	Name: function_b23e4b45
	Namespace: seeker_mine
	Checksum: 0x5920BCD7
	Offset: 0x448
	Size: 0x804
	Parameters: 0
	Flags: None
*/
function function_b23e4b45()
{
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.allowfriendlyfiredamageoverride = &smart_bomb::function_bf16c9ed;
	self.var_1dab821a = 0;
	self.var_e962dfaf = 0;
	self.delete_on_death = 1;
	self setplayercollision(0);
	self setavoidancemask("avoid none");
	self useanimtree("generic");
	self.ignore_death_jolt = 1;
	self thread function_313aa1b8();
	self.var_6e9e073d = 1;
	self.var_101a013c = 1;
	self.overridevehicledamage = &function_9e38a14a;
	if(isdefined(self.owner))
	{
		self setteam(self.owner.team);
	}
	self setneargoalnotifydist(31);
	defaultrole();
	if(self oob::istouchinganyoobtrigger() || !function_d55a99f2(300, 1, 1))
	{
		function_afd97197();
		return;
	}
	ispointonnavmesh = ispointonnavmesh(self.origin, self getpathfindingradius());
	if(!ispointonnavmesh)
	{
		/#
			recordsphere(self.origin, 3, (1, 0, 0), "");
		#/
	}
	else
	{
		/#
			recordsphere(self.origin, 3, (0, 1, 0), "");
		#/
	}
	if(!ispointonnavmesh)
	{
		newpos = undefined;
		var_921106a1 = getclosestpointonnavmesh(self.origin, 250, 30);
		if(isdefined(var_921106a1))
		{
			results = groundtrace(var_921106a1 + vectorscale((0, 0, 1), 70), var_921106a1 + (vectorscale((0, 0, -1), 70)), 0, self);
			if(isdefined(results) && isdefined(results[#"position"]))
			{
				var_921106a1 = results[#"position"];
				if(bullettracepassed(self.origin + vectorscale((0, 0, 1), 10), var_921106a1, 0, self, self, 0, 0))
				{
					/#
						recordline(self.origin + vectorscale((0, 0, 1), 10), var_921106a1, (0, 0, 1), "");
					#/
					/#
						recordsphere(self.origin + vectorscale((0, 0, 1), 10), 3, (0, 0, 1), "");
					#/
					/#
						recordsphere(var_921106a1, 3, (0, 0, 1), "");
					#/
					newpos = var_921106a1;
				}
				else
				{
					/#
						recordline(self.origin + vectorscale((0, 0, 1), 10), var_921106a1, (1, 0.5, 0), "");
					#/
					/#
						recordsphere(self.origin + vectorscale((0, 0, 1), 10), 3, (1, 0.5, 0), "");
					#/
					/#
						recordsphere(var_921106a1, 3, (1, 0.5, 0), "");
					#/
				}
			}
		}
		if(!isdefined(newpos))
		{
			var_68860686 = ai::t_cylinder(self.origin, 10, 60);
			cylinder = ai::t_cylinder(self.origin, 300, 60);
			tacpoints = tacticalquery("mp_seeker_seek_no_enemy_fallback", self.origin, self, var_68860686, cylinder);
			if(isdefined(tacpoints) && tacpoints.size > 0)
			{
				foreach(tacpoint in tacpoints)
				{
					if(function_96c81b85(tacpoint, self.origin + vectorscale((0, 0, 1), 30)))
					{
						var_cc66f3f5 = getclosestpointonnavmesh(tacpoint.origin, 250, 30);
						if(isdefined(var_cc66f3f5) && function_d15dd929(self getpathfindingradius(), var_cc66f3f5) && sighttracepassed(self.origin, var_cc66f3f5, 0, self))
						{
							newpos = var_cc66f3f5;
							break;
						}
					}
				}
			}
		}
		if(isdefined(newpos))
		{
			self.origin = newpos;
		}
		else
		{
			function_afd97197();
			return;
		}
	}
	if(!(isdefined(level.var_8fce01d) && level.var_8fce01d))
	{
		if(is_in_water(self.origin))
		{
			function_afd97197();
			return;
		}
		if(!function_d15dd929(self getpathfindingradius(), self.origin))
		{
			function_afd97197();
			return;
		}
		if(function_d39f1cf2())
		{
			tacpoint = getclosesttacpoint(self.origin);
			if(isdefined(tacpoint))
			{
				self.origin = tacpoint.origin;
			}
		}
	}
	vehicle_ai::startinitialstate("seek");
	self thread function_d00f14e3();
	self thread function_2651fb42();
	self thread targetting_delay::function_7e1a12ce();
}

/*
	Name: defaultrole
	Namespace: seeker_mine
	Checksum: 0x7CBEA234
	Offset: 0xC58
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function defaultrole()
{
	statemachine = self vehicle_ai::init_state_machine_for_role("default");
	statemachine statemachine::add_state("seek", &function_9ddc7275, &function_3e16dec3, &function_64f7393f);
	statemachine statemachine::add_state("chase", &state_chase_start, &function_391d5d90, &function_24465583);
	statemachine statemachine::add_state("discharge", &function_c23ecb2, &function_fb89ba8a, &function_32e99568);
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	self vehicle_ai::call_custom_add_state_callbacks();
}

/*
	Name: function_d3a9800e
	Namespace: seeker_mine
	Checksum: 0xC2C86152
	Offset: 0xDA8
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_d3a9800e()
{
	return self.origin + vectorscale((0, 0, 1), 30);
}

/*
	Name: function_d39f1cf2
	Namespace: seeker_mine
	Checksum: 0x66C3D219
	Offset: 0xDD0
	Size: 0xAE
	Parameters: 0
	Flags: Private
*/
function private function_d39f1cf2()
{
	trace = groundtrace(self.origin + vectorscale((0, 0, 1), 70), self.origin + (vectorscale((0, 0, -1), 100)), 0, self);
	if(isdefined(trace[#"entity"]))
	{
		entity = trace[#"entity"];
		if(entity ismovingplatform())
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_23d1cec2
	Namespace: seeker_mine
	Checksum: 0x53377EA3
	Offset: 0xE88
	Size: 0x4E
	Parameters: 0
	Flags: Private
*/
function private function_23d1cec2()
{
	result = function_9cc082d2(self.origin + vectorscale((0, 0, 1), 100), 400);
	if(isdefined(result))
	{
		return true;
	}
	return false;
}

/*
	Name: function_9e38a14a
	Namespace: seeker_mine
	Checksum: 0x5F9C0E2A
	Offset: 0xEE0
	Size: 0xCA
	Parameters: 15
	Flags: None
*/
function function_9e38a14a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(weapon == level.var_1b72f911)
	{
		idamage = self.health;
	}
	if(weapon === getweapon(#"ability_smart_cover"))
	{
		idamage = 0;
	}
	return idamage;
}

/*
	Name: state_chase_start
	Namespace: seeker_mine
	Checksum: 0xBFF061B1
	Offset: 0xFB8
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function state_chase_start(params)
{
	self clientfield::set("seeker_mine_light_fx", 1);
	self.var_3a0564e = gettime();
	if(isdefined(self.settings.var_fb42187e))
	{
		self playloopsound(self.settings.var_fb42187e);
	}
	self thread function_55be8453();
	self thread function_d03a7fe8();
	self thread watch_for_timeout(&function_d017dfc, int(self.settings.var_efc15586 * 1000));
}

/*
	Name: function_24465583
	Namespace: seeker_mine
	Checksum: 0x4F12F374
	Offset: 0x10B8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_24465583(params)
{
	self.var_e962dfaf = function_d017dfc();
	self stoploopsound();
}

/*
	Name: function_d017dfc
	Namespace: seeker_mine
	Checksum: 0xC2A67B06
	Offset: 0x10F8
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function function_d017dfc()
{
	time = self.var_e962dfaf + (gettime() - self.var_3a0564e);
	return time;
}

/*
	Name: function_391d5d90
	Namespace: seeker_mine
	Checksum: 0x606DE5AF
	Offset: 0x1128
	Size: 0x196
	Parameters: 1
	Flags: None
*/
function function_391d5d90(params)
{
	self endon(#"death", #"change_state");
	for(;;)
	{
		if(function_112a6b52())
		{
			waitframe(2);
			continue;
		}
		if(isdefined(self.favoriteenemy) && isalive(self.favoriteenemy))
		{
			self setbrake(0);
			self setspeed(self.settings.var_2c69a255);
			if(function_23d1cec2() && !ispointonnavmesh(self.origin, self))
			{
				function_d55a99f2(500, 0);
			}
			if(!chase_enemy())
			{
				self.var_c5c8c31 = randomintrange(1, 3);
				self vehicle_ai::set_state("seek");
			}
		}
		else
		{
			self vehicle_ai::set_state("seek");
		}
		self waittill_pathing_done(2);
		waitframe(1);
	}
}

/*
	Name: waittill_pathing_done
	Namespace: seeker_mine
	Checksum: 0xBB4710FE
	Offset: 0x12C8
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function waittill_pathing_done(maxtime = 15)
{
	self endon(#"death", #"change_state");
	result = undefined;
	result = self waittilltimeout(maxtime, #"near_goal", #"hash_f6b2d6a37e22523", #"switch_enemy");
}

/*
	Name: function_33d3892a
	Namespace: seeker_mine
	Checksum: 0x491FB0BB
	Offset: 0x1358
	Size: 0xE2
	Parameters: 0
	Flags: None
*/
function function_33d3892a()
{
	iterationlimit = getdvarint(#"hkai_pathfinditerationlimit", 1800);
	if(isdefined(self.favoriteenemy) && !function_9ba314a1(self.favoriteenemy))
	{
		targetpos = function_3acf1c61();
		if(isdefined(targetpos))
		{
			path = generatenavmeshpath(self.origin, targetpos, self, undefined, undefined, iterationlimit);
			if(isdefined(path) && path.status === "succeeded")
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: chase_enemy
	Namespace: seeker_mine
	Checksum: 0x2AA169D3
	Offset: 0x1448
	Size: 0x8A
	Parameters: 0
	Flags: None
*/
function chase_enemy()
{
	if(isdefined(self.favoriteenemy) && function_9ba314a1(self.favoriteenemy))
	{
		return false;
	}
	targetpos = function_3acf1c61();
	if(isdefined(targetpos))
	{
		if(self function_a57c34b7(targetpos, 0, 1))
		{
			self.current_pathto_pos = targetpos;
			return true;
		}
	}
	return false;
}

/*
	Name: function_3acf1c61
	Namespace: seeker_mine
	Checksum: 0x51EDF722
	Offset: 0x14E0
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_3acf1c61()
{
	if(isdefined(self.favoriteenemy))
	{
		target_pos = self.favoriteenemy.origin;
	}
	if(isdefined(target_pos))
	{
		target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, self.settings.var_c694bbbf * 1.5, self getpathfindingradius() * 1.2, 4194287);
	}
	if(isdefined(target_pos_onnavmesh))
	{
		return target_pos_onnavmesh;
	}
	if(isdefined(self.current_pathto_pos))
	{
		return self.current_pathto_pos;
	}
}

/*
	Name: function_d03a7fe8
	Namespace: seeker_mine
	Checksum: 0x4372C4BC
	Offset: 0x15A0
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_d03a7fe8()
{
	self endon(#"death", #"change_state");
	for(;;)
	{
		if(isdefined(self.favoriteenemy) && isalive(self.favoriteenemy))
		{
			if(function_9ba314a1(self.favoriteenemy))
			{
				self vehicle_ai::set_state("seek");
			}
			var_d0ca034f = arc::function_33d5b9a6(level.var_8a74f7fc[self.arcweapon], self.owner, self, self function_d3a9800e(), 0, self.favoriteenemy);
			if(var_d0ca034f)
			{
				self vehicle_ai::set_state("discharge");
			}
		}
		else
		{
			self vehicle_ai::set_state("seek");
		}
		waitframe(1);
	}
}

/*
	Name: function_c23ecb2
	Namespace: seeker_mine
	Checksum: 0xA264B242
	Offset: 0x16D8
	Size: 0xE4
	Parameters: 1
	Flags: None
*/
function function_c23ecb2(params)
{
	if(isplayer(self.owner))
	{
		self notify(#"seeker_discharge");
		self.owner notify(#"seeker_discharge");
	}
	self setbrake(1);
	self function_d4c687c9();
	self function_a57c34b7(self.origin);
	self thread animation::play("p8_fxanim_mp_drone_seeker_fire_anim", self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
}

/*
	Name: function_32e99568
	Namespace: seeker_mine
	Checksum: 0x606EBA0
	Offset: 0x17C8
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_32e99568(params)
{
	if(isplayer(self.owner))
	{
		self notify(#"hash_14dc5509ffad9ddb");
		self.owner notify(#"hash_14dc5509ffad9ddb");
	}
	if(isdefined(self.var_f8f0b8f8))
	{
		self.var_f8f0b8f8 delete();
	}
	self stoploopsound();
	self animation::stop();
}

/*
	Name: function_13ade03e
	Namespace: seeker_mine
	Checksum: 0xD4F43AAF
	Offset: 0x1878
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_13ade03e()
{
	self endon(#"death", #"change_state");
	while(true)
	{
		self animation::play("p8_fxanim_mp_drone_seeker_shock_anim", self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
		waitframe(1);
	}
}

/*
	Name: function_fb89ba8a
	Namespace: seeker_mine
	Checksum: 0xD0C6EC70
	Offset: 0x1908
	Size: 0x244
	Parameters: 1
	Flags: None
*/
function function_fb89ba8a(params)
{
	self endon(#"death");
	self endon(#"change_state");
	self thread function_13ade03e();
	starttime = gettime();
	var_b2c9484f = int(self.settings.var_e0c78652 * 1000);
	while((starttime + var_b2c9484f) > gettime() && !isdefined(self.var_290ed3ab) || (isdefined(self.var_290ed3ab) && self.var_290ed3ab > gettime()) || (isdefined(self.var_e19bcce0) && self.var_e19bcce0))
	{
		if(isdefined(self.arcweapon))
		{
			if(isdefined(level.var_8a74f7fc[self.arcweapon]))
			{
				self.var_8a74f7fc = level.var_8a74f7fc[self.arcweapon];
				if(!isdefined(self.var_d8d780c1) || self.var_d8d780c1.size < level.var_8a74f7fc[self.arcweapon].var_755593b1)
				{
					arc::find_arc_targets(level.var_8a74f7fc[self.arcweapon], self.owner, self, self function_d3a9800e(), 0, 0);
				}
			}
			if(!(isdefined(self.var_52ed036d) && self.var_52ed036d))
			{
				self clientfield::set("seeker_mine_fx", 1);
				if(isdefined(self.settings.var_93a31357))
				{
					self playsound(self.settings.var_93a31357);
				}
				self.var_52ed036d = 1;
			}
		}
		waitframe(1);
	}
	self vehicle_ai::set_state("death");
}

/*
	Name: function_9ddc7275
	Namespace: seeker_mine
	Checksum: 0x848E4228
	Offset: 0x1B58
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function function_9ddc7275(params)
{
	self.favoriteenemy = undefined;
	self.var_fc1d25b1 = gettime();
	self clientfield::set("seeker_mine_light_fx", 0);
	self thread function_55be8453();
	self thread function_3e3b6ce1();
	self thread function_82e5be34();
	self thread watch_for_timeout(&function_c82edc1a, int(self.settings.var_7fa25761 * 1000));
}

/*
	Name: function_64f7393f
	Namespace: seeker_mine
	Checksum: 0x3B8A0309
	Offset: 0x1C40
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_64f7393f(params)
{
	self stoploopsound();
	self.var_1dab821a = function_c82edc1a();
}

/*
	Name: function_c82edc1a
	Namespace: seeker_mine
	Checksum: 0x711A722D
	Offset: 0x1C88
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function function_c82edc1a()
{
	time = self.var_1dab821a + (gettime() - self.var_fc1d25b1);
	return time;
}

/*
	Name: function_d00f14e3
	Namespace: seeker_mine
	Checksum: 0xAF99B057
	Offset: 0x1CB8
	Size: 0x66
	Parameters: 0
	Flags: Private
*/
function private function_d00f14e3()
{
	self endon(#"death");
	self.ai.var_b0f9c1a3 = gettime();
	while(true)
	{
		self waittill(#"hash_47fe95a0475dea3d");
		self.ai.var_b0f9c1a3 = gettime() + 2000;
	}
}

/*
	Name: function_112a6b52
	Namespace: seeker_mine
	Checksum: 0xBFDEC55C
	Offset: 0x1D28
	Size: 0x3C
	Parameters: 0
	Flags: Private
*/
function private function_112a6b52()
{
	if(!isdefined(self.ai.var_b0f9c1a3))
	{
		return false;
	}
	if(gettime() <= self.ai.var_b0f9c1a3)
	{
		return true;
	}
	return false;
}

/*
	Name: function_2651fb42
	Namespace: seeker_mine
	Checksum: 0x50E48A5E
	Offset: 0x1D70
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private function_2651fb42()
{
	self endon(#"death");
	while(true)
	{
		if(function_112a6b52())
		{
			waitframe(2);
			continue;
		}
		if(!function_23d1cec2() && function_d55a99f2())
		{
			self notify(#"hash_f6b2d6a37e22523");
		}
		waitframe(2);
	}
}

/*
	Name: function_82e5be34
	Namespace: seeker_mine
	Checksum: 0x2D33D814
	Offset: 0x1E08
	Size: 0xE0
	Parameters: 0
	Flags: Private
*/
function private function_82e5be34()
{
	self endon(#"death");
	self endon(#"change_state");
	while(true)
	{
		currentdir = anglestoforward(self.angles);
		wait(1);
		newdir = anglestoforward(self.angles);
		if(vectordot(currentdir, newdir) < -0.5)
		{
			if(isdefined(self.settings.var_f282dc0a))
			{
				self playsound(self.settings.var_f282dc0a);
			}
		}
	}
}

/*
	Name: function_d15dd929
	Namespace: seeker_mine
	Checksum: 0x6C500FA4
	Offset: 0x1EF0
	Size: 0xAE
	Parameters: 2
	Flags: None
*/
function function_d15dd929(radius, origin)
{
	result = function_9cc082d2(origin + vectorscale((0, 0, 1), 100), 200);
	if(isdefined(result) && isdefined(result[#"materialflags"]) && result[#"materialflags"] & 2)
	{
		return false;
	}
	if(!ispointonnavmesh(origin, radius, 1))
	{
		return false;
	}
	return true;
}

/*
	Name: damage_armor_activati_
	Namespace: seeker_mine
	Checksum: 0xE7C30EA1
	Offset: 0x1FA8
	Size: 0x17C
	Parameters: 2
	Flags: None
*/
function damage_armor_activati_(entity, tacpoints)
{
	validpoints = [];
	radius = entity getpathfindingradius();
	if(isdefined(tacpoints) && tacpoints.size > 0)
	{
		foreach(tacpoint in tacpoints)
		{
			if(function_d15dd929(radius, tacpoint.origin))
			{
				array::add(validpoints, tacpoint);
				continue;
			}
			/#
				record3dtext("", tacpoint.origin + vectorscale((0, 0, 1), 40), (1, 1, 1), "");
			#/
			/#
				recordline(tacpoint.origin + vectorscale((0, 0, 1), 40), tacpoint.origin, (1, 1, 1), "");
			#/
		}
	}
	return validpoints;
}

/*
	Name: function_3e16dec3
	Namespace: seeker_mine
	Checksum: 0x7938D308
	Offset: 0x2130
	Size: 0x566
	Parameters: 1
	Flags: None
*/
function function_3e16dec3(params)
{
	self endon(#"death");
	self endon(#"change_state");
	for(;;)
	{
		if(function_112a6b52())
		{
			waitframe(2);
			continue;
		}
		if(isdefined(self.favoriteenemy))
		{
			self.current_pathto_pos = self function_3acf1c61();
			if(isdefined(self.current_pathto_pos))
			{
				if(self function_a57c34b7(self.current_pathto_pos, 0, 1))
				{
					self setspeed(self.settings.var_68c74e4f);
					self setbrake(0);
					self waittill_pathing_done(2);
					continue;
				}
			}
		}
		self setspeed(self.settings.var_9eff22ee);
		if(function_23d1cec2())
		{
			if(!ispointonnavmesh(self.origin, self))
			{
				function_d55a99f2(500, 0);
			}
			if(isdefined(level.var_477515d3))
			{
				[[ level.var_477515d3 ]]->waitinqueue(self);
			}
			forward = anglestoforward(self.angles);
			forwardpos = self.origin + (forward * 500);
			var_68860686 = ai::t_cylinder(self.origin, 200, 60);
			tacpoints = tacticalquery("mp_seeker_seek_no_enemy", self.origin, self, var_68860686, forwardpos);
			tacpoints = damage_armor_activati_(self, tacpoints);
			if(isdefined(tacpoints) && tacpoints.size != 0)
			{
				/#
					record3dtext("", self.origin - vectorscale((0, 0, 1), 20), (1, 0, 0));
				#/
				newpos = tacpoints[0].origin;
				newpos = getclosestpointonnavmesh(newpos, 500, self getpathfindingradius() * 1.2, self.var_6e9e073d);
				if(isdefined(newpos))
				{
					if(self function_a57c34b7(newpos, 0, 1))
					{
						self waittill_pathing_done(2);
					}
					else
					{
						self function_a57c34b7(newpos, 0, 0);
						self waittill_pathing_done(2);
					}
				}
			}
			else
			{
				if(isdefined(level.var_6cfbe5a))
				{
					[[ level.var_6cfbe5a ]]->waitinqueue(self);
				}
				newpos = getclosestpointonnavmesh(self.origin, 1000, 10);
				if(isdefined(newpos))
				{
					var_68860686 = ai::t_cylinder(self.origin, 400, 60);
					cylinder = ai::t_cylinder(self.origin, 1500, 150);
					tacpoints = tacticalquery("mp_seeker_seek_no_enemy_fallback", newpos, self, var_68860686, cylinder);
					tacpoints = damage_armor_activati_(self, tacpoints);
					if(isdefined(tacpoints) && tacpoints.size != 0)
					{
						/#
							record3dtext("", self.origin - vectorscale((0, 0, 1), 20), (1, 0, 0));
						#/
						newpos = tacpoints[0].origin;
						newpos = getclosestpointonnavmesh(newpos, 500, self getpathfindingradius() * 1.2);
						if(isdefined(newpos))
						{
							if(self function_a57c34b7(newpos, 0, 1))
							{
								self waittill_pathing_done(2);
							}
							else
							{
								self function_a57c34b7(newpos, 0, 0);
								self waittill_pathing_done(2);
							}
						}
					}
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_ab9a9770
	Namespace: seeker_mine
	Checksum: 0x985B7ABD
	Offset: 0x26A0
	Size: 0xC0
	Parameters: 1
	Flags: None
*/
function function_ab9a9770(target)
{
	results = groundtrace(target.origin + vectorscale((0, 0, 1), 70), target.origin + (vectorscale((0, 0, -1), 100)), 0, target);
	if(isdefined(results) && isdefined(results[#"entity"]) && results[#"entity"] ismovingplatform())
	{
		return true;
	}
	return false;
}

/*
	Name: function_9ba314a1
	Namespace: seeker_mine
	Checksum: 0x94396F84
	Offset: 0x2768
	Size: 0x466
	Parameters: 1
	Flags: None
*/
function function_9ba314a1(target)
{
	if(isplayer(target))
	{
		if(!isalive(target))
		{
			return true;
		}
		if(isdefined(target.var_4233f7e5) && target.var_4233f7e5)
		{
			return true;
		}
		if(isdefined(target.var_bb257569) && gettime() < target.var_bb257569)
		{
			return true;
		}
		if(isdefined(target.currentweapon))
		{
			shield = getweapon(#"sig_buckler_dw");
			if(isdefined(shield) && target.currentweapon == shield)
			{
				return true;
			}
			shield = getweapon(#"sig_buckler_lh");
			if(isdefined(shield) && target.currentweapon == shield)
			{
				return true;
			}
			shield = getweapon(#"sig_shield_turret");
			if(isdefined(shield) && target.currentweapon == shield)
			{
				return true;
			}
		}
		if(function_ab9a9770(target))
		{
			return true;
		}
		if(isdefined(target.isplanting) && target.isplanting || (isdefined(target.isdefusing) && target.isdefusing) || target oob::isoutofbounds())
		{
			return true;
		}
		if(target laststand::player_is_in_laststand())
		{
			return true;
		}
		if(target isremotecontrolling() || isdefined(target.holding_placeable))
		{
			return true;
		}
		if(target isinvehicle())
		{
			return true;
		}
		if(target player::is_spawn_protected())
		{
			return true;
		}
		if(isdefined(target.var_beee9523) && target.var_beee9523)
		{
			return true;
		}
		if(target isgrappling())
		{
			return true;
		}
		if(target depthinwater() >= 30 || target isplayerswimming())
		{
			return true;
		}
		if(isdefined(target.var_dda9b735) && (isdefined(target.var_dda9b735.isshocked) && target.var_dda9b735.isshocked))
		{
			return true;
		}
		if(target hasperk(#"specialty_nottargetedbyraps") && !isdefined(level.var_91a1cd89))
		{
			var_87c0ec9c = distancesquared(target.origin, self.origin);
			if(var_87c0ec9c <= 15625)
			{
				return false;
			}
			return true;
		}
	}
	target_pos_onnavmesh = undefined;
	if(isdefined(target))
	{
		target_pos_onnavmesh = getclosestpointonnavmesh(target.origin, self.settings.var_c694bbbf * 1.5, self getpathfindingradius() * 1.2, 4194287);
		if(!isdefined(target_pos_onnavmesh))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_3e3b6ce1
	Namespace: seeker_mine
	Checksum: 0x167E4769
	Offset: 0x2BD8
	Size: 0x212
	Parameters: 0
	Flags: None
*/
function function_3e3b6ce1()
{
	self endon(#"death");
	self endon(#"change_state");
	if(isdefined(self.var_c5c8c31))
	{
		delay = self.var_c5c8c31;
		self.var_c5c8c31 = undefined;
		wait(delay);
	}
	while(true)
	{
		if(isdefined(self.favoriteenemy))
		{
			target = self.favoriteenemy;
			var_87c0ec9c = distancesquared(target.origin, self.origin);
			if(var_87c0ec9c <= 122500)
			{
				var_cbf5ba86 = 1;
			}
			var_b9733045 = self targetting_delay::function_1c169b3a(target, 0);
			canseetarget = var_b9733045 && target sightconetrace(self function_d3a9800e(), self, anglestoforward(self.angles), self.settings.var_e7260470);
			if(isdefined(level.var_6cfbe5a))
			{
				[[ level.var_6cfbe5a ]]->waitinqueue(self);
			}
			if(function_33d3892a())
			{
				if(canseetarget || (isdefined(var_cbf5ba86) && var_cbf5ba86))
				{
					if(isdefined(self.settings.var_af34ede3))
					{
						self playsound(self.settings.var_af34ede3);
					}
					self vehicle_ai::set_state("chase");
					break;
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_45eb6b84
	Namespace: seeker_mine
	Checksum: 0xA0DA6845
	Offset: 0x2DF8
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_45eb6b84(target)
{
	if(isdefined(self.favoriteenemy) && self.favoriteenemy != target)
	{
		self targetting_delay::function_a4d6d6d8(target);
		self notify(#"switch_enemy");
	}
	self.favoriteenemy = target;
}

/*
	Name: function_55be8453
	Namespace: seeker_mine
	Checksum: 0x14AFCA6A
	Offset: 0x2E68
	Size: 0x3F6
	Parameters: 0
	Flags: None
*/
function function_55be8453()
{
	self endon(#"death", #"change_state");
	waitframe(2);
	firsttime = 1;
	while(true)
	{
		if(isdefined(self.favoriteenemy) && function_9ba314a1(self.favoriteenemy))
		{
			self.favoriteenemy = undefined;
		}
		if(isdefined(self.favoriteenemy))
		{
			if(util::within_fov(self.origin, self.angles, self.favoriteenemy.origin, 0.939))
			{
				var_87c0ec9c = distancesquared(self.favoriteenemy.origin, self.origin);
				if(var_87c0ec9c <= 122500)
				{
					waitframe(1);
					continue;
				}
			}
		}
		enemies = util::function_81ccf6d3(self.team);
		alltargets = arraycombine(enemies, getactorarray(), 1, 0);
		alltargets = arraysort(enemies, self function_d3a9800e(), 1);
		foundenemy = 0;
		foreach(target in alltargets)
		{
			if(function_9ba314a1(target))
			{
				continue;
			}
			angles = self.angles;
			if(isdefined(firsttime) && firsttime && isdefined(self.owner))
			{
				angles = self.owner.angles;
				firsttime = 0;
			}
			if(util::within_fov(self.origin, angles, target.origin, 0))
			{
				function_45eb6b84(target);
				foundenemy = 1;
				break;
			}
		}
		if(!foundenemy)
		{
			foreach(target in alltargets)
			{
				var_87c0ec9c = distancesquared(target.origin, self.origin);
				if(var_87c0ec9c <= 122500 && !function_9ba314a1(target))
				{
					function_45eb6b84(target);
					foundenemy = 1;
					break;
				}
			}
		}
		if(!foundenemy && alltargets.size && isdefined(alltargets[0]) && !function_9ba314a1(alltargets[0]))
		{
			function_45eb6b84(target);
		}
		waitframe(1);
	}
}

/*
	Name: function_d55a99f2
	Namespace: seeker_mine
	Checksum: 0xA8382C09
	Offset: 0x3268
	Size: 0x212
	Parameters: 3
	Flags: None
*/
function function_d55a99f2(var_4700521d = 500, var_53050fec = 1, var_30336a7c = 0)
{
	if(var_53050fec && function_23d1cec2())
	{
		return true;
	}
	/#
		record3dtext("", self.origin - vectorscale((0, 0, 1), 20), (1, 0, 0));
	#/
	newpos = getclosestpointonnavmesh(self.origin, var_4700521d, self getpathfindingradius() * 1.2);
	if(isdefined(newpos))
	{
		trace = groundtrace(newpos + vectorscale((0, 0, 1), 70), newpos + (vectorscale((0, 0, -1), 70)), 0, undefined);
		if(isdefined(trace[#"position"]))
		{
			newpos = trace[#"position"];
			if(var_30336a7c && !sighttracepassed(self.origin, newpos, 0, self))
			{
				return false;
			}
			/#
				record3dtext("", self.origin - vectorscale((0, 0, 1), 20), (0, 0, 1));
			#/
			/#
				recordline(newpos, self.origin, (0, 0, 1), "");
			#/
		}
		self.origin = newpos;
		return true;
	}
	return false;
}

/*
	Name: watch_for_timeout
	Namespace: seeker_mine
	Checksum: 0x84B24725
	Offset: 0x3488
	Size: 0xAE
	Parameters: 2
	Flags: None
*/
function watch_for_timeout(var_9d52f0b7, max_duration)
{
	self endon(#"death");
	self endon(#"change_state");
	for(;;)
	{
		if(isdefined(self.var_672e0d51))
		{
			if(self.var_672e0d51 < gettime())
			{
				self vehicle_ai::set_state("death");
			}
		}
		else if(self [[var_9d52f0b7]]() > max_duration)
		{
			self vehicle_ai::set_state("death");
		}
		waitframe(1);
	}
}

/*
	Name: function_313aa1b8
	Namespace: seeker_mine
	Checksum: 0xD84BF9D4
	Offset: 0x3540
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function function_313aa1b8()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_collision");
		self playsound(#"veh_wasp_wall_imp");
	}
}

/*
	Name: function_afd97197
	Namespace: seeker_mine
	Checksum: 0x666E45B7
	Offset: 0x35B0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_afd97197()
{
	self vehicle_ai::set_state("death");
}

/*
	Name: state_death_update
	Namespace: seeker_mine
	Checksum: 0xCC916316
	Offset: 0x35E0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function state_death_update(params)
{
	self clientfield::set("seeker_mine_fx", 0);
	self arc::function_936e96aa(self.var_8a74f7fc);
	vehicle_ai::defaultstate_death_update(params);
	if(isdefined(self.owner))
	{
		self.owner globallogic_score::function_d3ca3608(#"hash_2cbb2354f066e90");
	}
}

