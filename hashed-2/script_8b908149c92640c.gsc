// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_324d329b31b9b4ec;
#using script_6ae78a9592670fa2;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace ai_tank;

/*
	Name: init_shared
	Namespace: ai_tank
	Checksum: 0xF2292D4C
	Offset: 0x3C8
	Size: 0x43C
	Parameters: 1
	Flags: None
*/
function init_shared(bundlename)
{
	if(!isdefined(level.var_400ded61))
	{
		level.var_400ded61 = {};
		ir_strobe::init_shared();
		if(!isdefined(bundlename))
		{
			bundlename = "killstreak_tank_robot";
		}
		bundle = struct::get_script_bundle("killstreak", bundlename);
		level.var_400ded61.aitankkillstreakbundle = bundle;
		level.var_400ded61._ai_tank_fx = [];
		level.var_400ded61._ai_tank_fx[#"light_green"] = "killstreaks/fx_agr_vlight_eye_grn";
		level.var_400ded61._ai_tank_fx[#"light_red"] = "killstreaks/fx_agr_vlight_eye_red";
		level.var_400ded61._ai_tank_fx[#"immobile"] = "killstreaks/fx8_drone_tank_stun";
		level.var_400ded61._ai_tank_fx[#"stun"] = "killstreaks/fx_agr_emp_stun";
		clientfield::register("vehicle", "ai_tank_death", 1, 1, "int", &death, 0, 0);
		clientfield::register("vehicle", "ai_tank_immobile", 1, 1, "int", &function_942c857, 0, 0);
		clientfield::register("vehicle", "ai_tank_change_control", 1, 1, "int", &function_77f17280, 0, 0);
		clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter", &update_hud, 0, 0);
		clientfield::register("clientuimodel", "hudItems.tankState", 1, 3, "int", undefined, 0, 0);
		clientfield::register("toplayer", "ai_tank_jam_hud", 9000, 1, "int", &function_aedc4c37, 0, 1);
		if(!(isdefined(level.var_9f011465) && level.var_9f011465))
		{
			multi_stage_target_lockon::register("multi_stage_target_lockon0");
			multi_stage_target_lockon::register("multi_stage_target_lockon1");
			multi_stage_target_lockon::register("multi_stage_target_lockon2");
			multi_stage_target_lockon::register("multi_stage_target_lockon3");
			multi_stage_target_lockon::register("multi_stage_target_lockon4");
		}
		vehicle::add_vehicletype_callback("ai_tank_drone_mp", &spawned);
		vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp", &spawned);
		vehicle::add_vehicletype_callback("spawner_bo3_ai_tank_mp_player", &spawned);
		vehicle::add_vehicletype_callback("archetype_mini_quadtank_mp", &spawned);
		visionset_mgr::register_visionset_info("agr_visionset", 1, 16, undefined, "mp_vehicles_agr");
	}
}

/*
	Name: spawned
	Namespace: ai_tank
	Checksum: 0xE613DB4C
	Offset: 0x810
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function spawned(localclientnum, killstreak_duration)
{
	self thread play_driving_rumble(localclientnum);
	self.killstreakbundle = level.var_400ded61.aitankkillstreakbundle;
	var_2c9baa0c = self.killstreakbundle.var_7249d50f;
	self.var_da04aa74 = 1;
	if(isdefined(var_2c9baa0c) && var_2c9baa0c != 0)
	{
		self function_5db470de(localclientnum, var_2c9baa0c);
	}
}

/*
	Name: missile_fire
	Namespace: ai_tank
	Checksum: 0x8F60B91D
	Offset: 0x8B8
	Size: 0xD4
	Parameters: 7
	Flags: None
*/
function missile_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(self hasanimtree() == 0)
	{
		self useanimtree("generic");
	}
	missiles_loaded = newval;
	if(missiles_loaded <= 4)
	{
		update_ui_ammo_count(localclientnum, missiles_loaded);
	}
}

/*
	Name: function_aedc4c37
	Namespace: ai_tank
	Checksum: 0xB52ED295
	Offset: 0x998
	Size: 0x9C
	Parameters: 7
	Flags: None
*/
function function_aedc4c37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self postfx::playpostfxbundle(#"hash_68b6dee9bf4fbfbe");
	}
	else if(newval == 0)
	{
		self postfx::stoppostfxbundle(#"hash_68b6dee9bf4fbfbe");
	}
}

/*
	Name: update_hud
	Namespace: ai_tank
	Checksum: 0xC67FFCDC
	Offset: 0xA40
	Size: 0x86
	Parameters: 7
	Flags: None
*/
function update_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"disconnect");
	waitframe(1);
	if(isdefined(self))
	{
		vehicle = getplayervehicle(self);
	}
}

/*
	Name: update_ui_ammo_count
	Namespace: ai_tank
	Checksum: 0xBC6C10BC
	Offset: 0xAD0
	Size: 0x64
	Parameters: 2
	Flags: None
*/
function update_ui_ammo_count(localclientnum, missiles_loaded)
{
	if(self function_4add50a7() || function_65b9eb0f(localclientnum))
	{
		update_ui_model_ammo_count(localclientnum, missiles_loaded);
	}
}

/*
	Name: update_ui_model_ammo_count
	Namespace: ai_tank
	Checksum: 0x2EC2DA86
	Offset: 0xB40
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function update_ui_model_ammo_count(localclientnum, missiles_loaded)
{
	ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
	if(isdefined(ammo_ui_data_model))
	{
		setuimodelvalue(ammo_ui_data_model, missiles_loaded);
	}
}

/*
	Name: function_942c857
	Namespace: ai_tank
	Checksum: 0xD1742647
	Offset: 0xBB8
	Size: 0xB4
	Parameters: 7
	Flags: None
*/
function function_942c857(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		self notify(#"light_disable");
		self function_7713b297(localclientnum);
		self function_407a7b51(localclientnum);
	}
	else
	{
		self function_7713b297(localclientnum);
	}
}

/*
	Name: function_77f17280
	Namespace: ai_tank
	Checksum: 0x94064129
	Offset: 0xC78
	Size: 0x1AC
	Parameters: 7
	Flags: None
*/
function function_77f17280(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		self function_d309e55a("tag_turret_constrained_barrel_lower", 0);
		self function_d309e55a("tag_turret_base_pivot", 1);
		self function_d309e55a("tag_turret_constraint_base", 1);
		self function_d309e55a("tag_turret_constrained_barrel", 1);
		playsound(localclientnum, #"hash_a919be8bee9e599", self.origin);
	}
	else
	{
		self function_d309e55a("tag_turret_constrained_barrel_lower", 1);
		self function_d309e55a("tag_turret_base_pivot", 0);
		self function_d309e55a("tag_turret_constraint_base", 0);
		self function_d309e55a("tag_turret_constrained_barrel", 0);
		playsound(localclientnum, #"hash_a919be8bee9e599", self.origin);
	}
}

/*
	Name: death
	Namespace: ai_tank
	Checksum: 0xBDBA34B0
	Offset: 0xE30
	Size: 0x86
	Parameters: 7
	Flags: None
*/
function death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(function_1cbf351b(localclientnum))
	{
		return;
	}
	if(newval)
	{
		self function_7713b297(localclientnum);
		self notify(#"light_disable");
	}
}

/*
	Name: function_407a7b51
	Namespace: ai_tank
	Checksum: 0xEEBE79E
	Offset: 0xEC0
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_407a7b51(localclientnum)
{
	self.immobile_fx = util::playfxontag(localclientnum, level.var_400ded61._ai_tank_fx[#"immobile"], self, "tag_body");
	playsound(localclientnum, #"veh_talon_shutdown", self.origin);
}

/*
	Name: function_7713b297
	Namespace: ai_tank
	Checksum: 0x3D4F2D5A
	Offset: 0xF48
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_7713b297(localclientnum)
{
	if(isdefined(self.immobile_fx))
	{
		stopfx(localclientnum, self.immobile_fx);
		self.immobile_fx = undefined;
	}
}

/*
	Name: play_driving_rumble
	Namespace: ai_tank
	Checksum: 0xB640DCB9
	Offset: 0xF90
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function play_driving_rumble(localclientnum)
{
	self notify(#"driving_rumble");
	self endon(#"death");
	self endon(#"driving_rumble");
	for(;;)
	{
		if(isinvehicle(localclientnum, self))
		{
			speed = self getspeed();
			if(speed >= 40 || speed <= -40)
			{
				earthquake(localclientnum, 0.1, 0.1, self.origin, 200);
			}
		}
		util::server_wait(localclientnum, 0.05);
	}
}

