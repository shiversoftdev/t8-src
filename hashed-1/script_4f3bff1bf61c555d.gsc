// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c6ff91addfd14b7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace raps;

/*
	Name: function_89f2df9
	Namespace: raps
	Checksum: 0x2363599C
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"raps", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: raps
	Checksum: 0xA202FC6D
	Offset: 0x160
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int");
	vehicle::add_main_callback("raps", &raps_initialize);
	slow_triggers = getentarray("raps_slow", "targetname");
	array::thread_all(slow_triggers, &slow_raps_trigger);
}

/*
	Name: raps_initialize
	Namespace: raps
	Checksum: 0x54126865
	Offset: 0x210
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function raps_initialize()
{
	namespace_c2dce87e::function_c6f75619();
	self useanimtree("generic");
	self initsounds();
	if(isdefined(level.vehicle_initializer_cb))
	{
		[[level.vehicle_initializer_cb]](self);
	}
	defaultrole();
}

/*
	Name: defaultrole
	Namespace: raps
	Checksum: 0xB9D414B1
	Offset: 0x2A0
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").update_func = &namespace_c2dce87e::state_combat_update;
	self vehicle_ai::get_state_callbacks("driving").update_func = &namespace_c2dce87e::state_scripted_update;
	self vehicle_ai::get_state_callbacks("death").update_func = &namespace_c2dce87e::state_death_update;
	self vehicle_ai::get_state_callbacks("emped").update_func = &namespace_c2dce87e::state_emped_update;
	self vehicle_ai::call_custom_add_state_callbacks();
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: slow_raps_trigger
	Namespace: raps
	Checksum: 0x896C602C
	Offset: 0x3B8
	Size: 0xC0
	Parameters: 0
	Flags: None
*/
function slow_raps_trigger()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		other = waitresult.activator;
		if(isvehicle(other) && isdefined(other.archetype) && other.archetype == "raps")
		{
			other thread slow_raps(self);
		}
		wait(0.1);
	}
}

/*
	Name: slow_raps
	Namespace: raps
	Checksum: 0x17BFA55B
	Offset: 0x480
	Size: 0x17E
	Parameters: 1
	Flags: None
*/
function slow_raps(trigger)
{
	self notify(#"slow_raps");
	self endon(#"slow_raps", #"death");
	self.slow_trigger = 1;
	if(isdefined(trigger.script_int))
	{
		if(isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < trigger.script_int)
		{
			self setspeedimmediate(self._override_raps_combat_speed);
		}
		else
		{
			self setspeedimmediate(trigger.script_int, 200, 200);
		}
	}
	else
	{
		if(isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < (0.5 * self.settings.defaultmovespeed))
		{
			self setspeed(self._override_raps_combat_speed);
		}
		else
		{
			self setspeed(0.5 * self.settings.defaultmovespeed);
		}
	}
	wait(1);
	self resumespeed();
	self.slow_trigger = undefined;
}

/*
	Name: initsounds
	Namespace: raps
	Checksum: 0x9BF47030
	Offset: 0x608
	Size: 0x516
	Parameters: 0
	Flags: None
*/
function initsounds()
{
	self.sndalias = [];
	self.sndalias[#"inair"] = #"veh_raps_in_air";
	self.sndalias[#"land"] = #"veh_raps_land";
	self.sndalias[#"spawn"] = #"veh_raps_spawn";
	self.sndalias[#"direction"] = #"veh_raps_direction";
	self.sndalias[#"jump_up"] = #"veh_raps_jump_up";
	self.sndalias[#"hash_6dacc5a8faf1b6f3"] = #"veh_raps_close_250";
	self.sndalias[#"hash_22b0b71c07ac7fea"] = #"veh_raps_close_1500";
	self.sndalias[#"hash_26569720e0ae76f3"] = #"veh_raps_targeting";
	self.sndalias[#"hash_2b3a22d457fba169"] = #"evt_raps_alarm";
	self.sndalias[#"hash_56dd8cae01fc143c"] = #"veh_wasp_wall_imp";
	if(isdefined(self.vehicletype) && (self.vehicletype == #"spawner_enemy_zombie_vehicle_raps_suicide" || self.vehicletype == #"spawner_zombietron_veh_meatball" || self.vehicletype == #"spawner_zombietron_veh_meatball_med" || self.vehicletype == #"spawner_zombietron_veh_meatball_small"))
	{
		self.sndalias[#"inair"] = #"zmb_meatball_in_air";
		self.sndalias[#"land"] = #"zmb_meatball_land";
		self.sndalias[#"spawn"] = undefined;
		self.sndalias[#"direction"] = undefined;
		self.sndalias[#"jump_up"] = #"zmb_meatball_jump_up";
		self.sndalias[#"hash_6dacc5a8faf1b6f3"] = #"zmb_meatball_close_250";
		self.sndalias[#"hash_22b0b71c07ac7fea"] = undefined;
		self.sndalias[#"hash_26569720e0ae76f3"] = #"zmb_meatball_targeting";
		self.sndalias[#"hash_2b3a22d457fba169"] = undefined;
		self.sndalias[#"hash_56dd8cae01fc143c"] = #"zmb_meatball_collision";
	}
	if(isdefined(self.vehicletype) && self.vehicletype == #"hash_22f2770b0b570f88")
	{
		self.sndalias[#"inair"] = #"hash_b4c1fb7fb7b70be";
		self.sndalias[#"land"] = #"hash_56707e87f5b058df";
		self.sndalias[#"spawn"] = #"hash_220536a567c22f9d";
		self.sndalias[#"direction"] = undefined;
		self.sndalias[#"jump_up"] = #"hash_1182d9ecfe86442e";
		self.sndalias[#"hash_6dacc5a8faf1b6f3"] = #"hash_4d4a13f08b063112";
		self.sndalias[#"hash_22b0b71c07ac7fea"] = undefined;
		self.sndalias[#"hash_26569720e0ae76f3"] = #"hash_57d3d8cf8a3cb109";
		self.sndalias[#"hash_2b3a22d457fba169"] = #"hash_28033d94de922793";
		self.sndalias[#"hash_56dd8cae01fc143c"] = #"hash_481f37c2ab12bdfe";
	}
}

/*
	Name: detonate_damage_monitored
	Namespace: raps
	Checksum: 0xC9C06616
	Offset: 0xB28
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function detonate_damage_monitored(attacker, weapon)
{
	self.selfdestruct = 1;
	namespace_c2dce87e::detonate(attacker);
}

/*
	Name: detonate
	Namespace: raps
	Checksum: 0x92DD17BD
	Offset: 0xB68
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function detonate(attacker)
{
	namespace_c2dce87e::detonate(attacker);
}

