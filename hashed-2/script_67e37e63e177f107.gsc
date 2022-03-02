// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_545a0bac37bda541;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\statemachine_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace namespace_77b8863;

/*
	Name: function_89f2df9
	Namespace: namespace_77b8863
	Checksum: 0xB0A733E5
	Offset: 0x180
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_60e9e594b4389b03", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_77b8863
	Checksum: 0xA7467E6E
	Offset: 0x1C8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_main_callback(#"hash_3b41c3299f47fb7f", &function_c346ef73);
	clientfield::register("scriptmover", "towers_boss_dust_ball_fx", 1, getminbitcountfornum(4), "int");
	/#
		level thread update_dvars();
	#/
}

/*
	Name: update_dvars
	Namespace: namespace_77b8863
	Checksum: 0x109DB60B
	Offset: 0x260
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function update_dvars()
{
	/#
	#/
}

/*
	Name: function_c346ef73
	Namespace: namespace_77b8863
	Checksum: 0x5B16DE1
	Offset: 0x270
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_c346ef73()
{
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.var_1dab821a = 0;
	self useanimtree("generic");
	if(isdefined(self.owner))
	{
		self setteam(self.owner.team);
	}
	self setneargoalnotifydist(60);
	defaultrole();
}

/*
	Name: defaultrole
	Namespace: namespace_77b8863
	Checksum: 0x83E605EB
	Offset: 0x328
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function defaultrole()
{
	statemachine = self vehicle_ai::init_state_machine_for_role("default");
	statemachine statemachine::add_state("seek", &function_9ddc7275, &function_3e16dec3, &function_64f7393f);
	statemachine statemachine::add_state("soul", &function_3f83eb6, &function_e452a40c, &function_22828012);
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	self val::set(#"hash_3b41c3299f47fb7f", "takedamage", 0);
	self.takedamage = 0;
	self vehicle_ai::call_custom_add_state_callbacks();
	self.fxent = spawn("script_model", self.origin);
	self.fxent setmodel("tag_origin");
	self.fxent linkto(self);
	self.fxent clientfield::set("towers_boss_dust_ball_fx", 1);
	vehicle_ai::startinitialstate("seek");
}

/*
	Name: function_d3a9800e
	Namespace: namespace_77b8863
	Checksum: 0xDEDC40E9
	Offset: 0x508
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_d3a9800e()
{
	return self.origin + vectorscale((0, 0, 1), 30);
}

/*
	Name: waittill_pathing_done
	Namespace: namespace_77b8863
	Checksum: 0xD44FACF6
	Offset: 0x530
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function waittill_pathing_done(maxtime = 15)
{
	self endon(#"death");
	self endon(#"change_state");
	self waittilltimeout(maxtime, #"near_goal");
}

/*
	Name: function_f2fd92d1
	Namespace: namespace_77b8863
	Checksum: 0x8944334F
	Offset: 0x590
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_f2fd92d1()
{
	if(isdefined(self.favoriteenemy))
	{
		target_pos = self.favoriteenemy.origin;
	}
	if(isdefined(target_pos))
	{
		target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, 20, self.radius, 4194287);
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
	Name: function_3f83eb6
	Namespace: namespace_77b8863
	Checksum: 0xC7474D0D
	Offset: 0x628
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_3f83eb6(params)
{
	self.fxent unlink();
	self.fxent linkto(self, "tag_origin", vectorscale((0, 0, 1), 50));
	self.fxent clientfield::set("towers_boss_dust_ball_fx", 3);
}

/*
	Name: function_e452a40c
	Namespace: namespace_77b8863
	Checksum: 0x8A6070D1
	Offset: 0x6B0
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_e452a40c(params)
{
	self endon(#"death");
	self setneargoalnotifydist(40);
	while(true)
	{
		if(!isdefined(self.ai.var_a38db64f))
		{
			waitframe(1);
			continue;
		}
		self setspeed(self.settings.var_9eff22ee);
		self setbrake(0);
		self function_a57c34b7(self.ai.var_a38db64f, 1, 1);
		self waittilltimeout(30, #"near_goal");
		if(isdefined(self.fxent))
		{
			self.fxent delete();
		}
		self delete();
	}
}

/*
	Name: function_22828012
	Namespace: namespace_77b8863
	Checksum: 0x893E99CB
	Offset: 0x7E0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_22828012(params)
{
}

/*
	Name: function_9ddc7275
	Namespace: namespace_77b8863
	Checksum: 0x9212BCC
	Offset: 0x7F8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_9ddc7275(params)
{
	self.var_33506050 = undefined;
	self.favoriteenemy = undefined;
	duration = 2;
	self.var_373d5c91 = gettime() + (int(duration * 1000));
	self thread function_ef0bfb9d();
	self thread function_419f8ccb();
	if(isdefined(self.settings.var_d76543dd))
	{
		self playloopsound(self.settings.var_d76543dd);
	}
}

/*
	Name: function_64f7393f
	Namespace: namespace_77b8863
	Checksum: 0x1D9E4038
	Offset: 0x8C0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_64f7393f(params)
{
	self stoploopsound();
}

/*
	Name: function_78b6454d
	Namespace: namespace_77b8863
	Checksum: 0x33BA554A
	Offset: 0x8F0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_78b6454d()
{
	if(gettime() > self.var_373d5c91)
	{
		return true;
	}
	return false;
}

/*
	Name: function_3e16dec3
	Namespace: namespace_77b8863
	Checksum: 0xEBDD481E
	Offset: 0x918
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_3e16dec3(params)
{
	self endon(#"death");
	self endon(#"change_state");
	for(;;)
	{
		if(isdefined(self.favoriteenemy))
		{
			if(isdefined(self.settings.var_cfe1cc83))
			{
				self playloopsound(self.settings.var_cfe1cc83);
			}
			self.current_pathto_pos = self function_f2fd92d1();
			if(isdefined(self.current_pathto_pos))
			{
				self setspeed(self.settings.var_9eff22ee);
				self setbrake(0);
				self function_a57c34b7(self.current_pathto_pos, 1, 1);
				self waittill_pathing_done(1);
				continue;
			}
		}
		else
		{
			self function_55be8453();
		}
		waitframe(1);
	}
}

/*
	Name: function_ef0bfb9d
	Namespace: namespace_77b8863
	Checksum: 0x2960300B
	Offset: 0xA68
	Size: 0x286
	Parameters: 0
	Flags: Linked
*/
function function_ef0bfb9d()
{
	self endon(#"death");
	self endon(#"change_state");
	wait(0.5);
	while(true)
	{
		enemies = util::function_81ccf6d3(self.team);
		var_61c9e8b6 = arraysort(enemies, self function_d3a9800e(), 1);
		var_a5a1f99c = getaiarchetypearray(#"zombie");
		var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"catalyst"), 0, 0);
		var_61c9e8b6 = arraycombine(var_a5a1f99c, var_61c9e8b6, 0, 0);
		foreach(target in var_61c9e8b6)
		{
			var_87c0ec9c = distancesquared(target.origin, self function_d3a9800e());
			if(var_87c0ec9c <= (self.settings.damage_radius * self.settings.damage_radius))
			{
				if(isdefined(target.archetype))
				{
					target zombie_utility::setup_zombie_knockdown(self);
					target.knockdown_type = "knockdown_shoved";
					continue;
				}
				target dodamage(self.settings.var_274be2d6, self.origin, self, self, "", "MOD_IMPACT", 0);
			}
		}
		physicsexplosionsphere(self.origin, 200, 100, 2);
		waitframe(1);
	}
}

/*
	Name: function_413aacb3
	Namespace: namespace_77b8863
	Checksum: 0xDD8C4307
	Offset: 0xCF8
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_413aacb3(target)
{
	var_7588d977 = getaiarchetypearray(#"hash_3b41c3299f47fb7f");
	foreach(var_3f1f1429 in var_7588d977)
	{
		if(var_3f1f1429 == self)
		{
			continue;
		}
		if(var_3f1f1429.favoriteenemy === target)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_55be8453
	Namespace: namespace_77b8863
	Checksum: 0x2DEFF325
	Offset: 0xDC0
	Size: 0x2BA
	Parameters: 0
	Flags: Linked
*/
function function_55be8453()
{
	self endon(#"death");
	self endon(#"change_state");
	wait(0.5);
	if(isdefined(self.favoriteenemy))
	{
		if(util::within_fov(self.origin, self.angles, self.favoriteenemy.origin, 0.939))
		{
			var_87c0ec9c = distancesquared(self.favoriteenemy.origin, self function_d3a9800e());
			if(var_87c0ec9c <= 10000)
			{
				return;
			}
		}
	}
	enemies = util::function_81ccf6d3(self.team);
	var_61c9e8b6 = arraysort(enemies, self function_d3a9800e(), 1);
	foreach(target in var_61c9e8b6)
	{
		angles = self.angles;
		if(self function_413aacb3(target))
		{
			continue;
		}
		if(util::within_fov(self.origin, angles, target.origin, 0))
		{
			self.favoriteenemy = target;
			return;
		}
	}
	foreach(target in var_61c9e8b6)
	{
		var_87c0ec9c = distancesquared(target.origin, self function_d3a9800e());
		if(var_87c0ec9c <= 10000)
		{
			self.favoriteenemy = target;
			return;
		}
	}
	if(var_61c9e8b6.size && isdefined(var_61c9e8b6[0]))
	{
		self.favoriteenemy = var_61c9e8b6[0];
	}
}

/*
	Name: function_419f8ccb
	Namespace: namespace_77b8863
	Checksum: 0x82653D52
	Offset: 0x1088
	Size: 0x16E
	Parameters: 0
	Flags: Linked
*/
function function_419f8ccb()
{
	self endon(#"death");
	self endon(#"change_state");
	for(;;)
	{
		if(self function_78b6454d())
		{
			self vehicle_ai::set_state("death");
		}
		if(isdefined(self.favoriteenemy))
		{
			distfromplayer = distancesquared(self.origin, self.favoriteenemy.origin);
			if(distfromplayer < (self.settings.var_2c001f55 * self.settings.var_2c001f55) && (!(isdefined(self.var_8d5279eb) && self.var_8d5279eb)))
			{
				self.fxent clientfield::set("towers_boss_dust_ball_fx", 2);
				self.var_8d5279eb = 1;
			}
			if(distfromplayer < self.settings.zmb_zod_sprayer_pickupids * self.settings.zmb_zod_sprayer_pickupids)
			{
				self vehicle_ai::set_state("death");
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_469f1e03
	Namespace: namespace_77b8863
	Checksum: 0x95B91ACF
	Offset: 0x1200
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_469f1e03(fxent)
{
	wait(0.1);
	fxent delete();
}

/*
	Name: state_death_update
	Namespace: namespace_77b8863
	Checksum: 0x891A0D00
	Offset: 0x1238
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function state_death_update(params)
{
	self.fxent clientfield::set("towers_boss_dust_ball_fx", 0);
	if(isdefined(level.var_c6001986))
	{
		[[level.var_c6001986]](self);
	}
	fxent = self.fxent;
	vehicle_ai::defaultstate_death_update(params);
	wait(2);
	if(isdefined(fxent))
	{
		level thread function_469f1e03(fxent);
	}
	if(isdefined(self))
	{
		self delete();
	}
}

