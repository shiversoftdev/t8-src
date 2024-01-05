// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace namespace_456de992;

/*
	Name: init
	Namespace: namespace_456de992
	Checksum: 0xC1B1B179
	Offset: 0x260
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_flags();
	level thread perks_behind_door();
}

/*
	Name: init_flags
	Namespace: namespace_456de992
	Checksum: 0xC724DE7D
	Offset: 0x298
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init("magic_door_power_up_grabbed");
	level flag::init("population_count_step_complete");
}

/*
	Name: door_powerup_drop
	Namespace: namespace_456de992
	Checksum: 0x7B0DA623
	Offset: 0x2E8
	Size: 0x13A
	Parameters: 4
	Flags: Linked
*/
function door_powerup_drop(powerup_name, drop_spot, powerup_team, powerup_location)
{
	if(isdefined(level.door_powerup))
	{
		level.door_powerup zm_powerups::powerup_delete();
	}
	powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_spot + vectorscale((0, 0, 1), 40));
	powerup setmodel(#"tag_origin");
	level notify(#"powerup_dropped", powerup);
	if(isdefined(powerup))
	{
		powerup.grabbed_level_notify = #"magic_door_power_up_grabbed";
		powerup function_94cd396e(powerup_name, powerup_team, drop_spot);
		powerup thread zm_powerups::powerup_wobble();
		powerup thread zm_powerups::powerup_grab(powerup_team);
		level.door_powerup = powerup;
	}
}

/*
	Name: perks_behind_door
	Namespace: namespace_456de992
	Checksum: 0xBE3BCB39
	Offset: 0x430
	Size: 0x300
	Parameters: 0
	Flags: Linked
*/
function perks_behind_door()
{
	if(level.enable_magic !== 1)
	{
		return;
	}
	if(!zm_custom::function_901b751c("zmPowerupsActive") || zm_custom::function_901b751c("zmPowerupsIsLimitedRound") || !zm_custom::function_901b751c("zmPowerupNuke") || !zm_custom::function_901b751c("zmPowerupDouble") || !zm_custom::function_901b751c("zmPowerupInstakill") || !zm_custom::function_901b751c("zmPowerupFireSale") || !zm_custom::function_901b751c("zmPowerupMaxAmmo"))
	{
		return;
	}
	level endon(#"magic_door_power_up_grabbed", #"population_count_step_complete");
	level thread powerup_grabbed_watcher();
	level flag::wait_till("initial_blackscreen_passed");
	level.door_perk_drop_list = [];
	level.door_perk_drop_list[0] = "nuke";
	level.door_perk_drop_list[1] = "double_points";
	level.door_perk_drop_list[2] = "insta_kill";
	level.door_perk_drop_list[3] = "fire_sale";
	level.door_perk_drop_list[4] = "full_ammo";
	index = 0;
	level.ammodrop = struct::get("zm_nuked_ammo_drop", "script_noteworthy");
	level.perk_type = level.door_perk_drop_list[index];
	index++;
	door_powerup_drop(level.perk_type, level.ammodrop.origin);
	while(true)
	{
		level waittill(#"nuke_clock_moved");
		if(index == level.door_perk_drop_list.size)
		{
			index = 0;
		}
		level.perk_type = level.door_perk_drop_list[index];
		index++;
		door_powerup_drop(level.perk_type, level.ammodrop.origin);
	}
}

/*
	Name: powerup_grabbed_watcher
	Namespace: namespace_456de992
	Checksum: 0xAEA8966A
	Offset: 0x738
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function powerup_grabbed_watcher()
{
	level waittill(#"magic_door_power_up_grabbed");
	level flag::set(#"magic_door_power_up_grabbed");
}

/*
	Name: function_94cd396e
	Namespace: namespace_456de992
	Checksum: 0xB1F698D5
	Offset: 0x780
	Size: 0x3D4
	Parameters: 6
	Flags: Linked
*/
function function_94cd396e(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1, var_a6d11a96)
{
	str_powerup = undefined;
	if(!isdefined(powerup_override))
	{
		str_powerup = zm_powerups::get_valid_powerup();
	}
	else
	{
		str_powerup = powerup_override;
		if("tesla" == str_powerup && zm_powerups::tesla_powerup_active())
		{
			str_powerup = "minigun";
		}
	}
	struct = level.zombie_powerups[str_powerup];
	if(isdefined(powerup_team))
	{
		self.powerup_team = powerup_team;
	}
	if(isdefined(powerup_location))
	{
		self.powerup_location = powerup_location;
	}
	if(isdefined(powerup_player))
	{
		self.powerup_player = powerup_player;
	}
	else
	{
		/#
			assert(!(isdefined(struct.player_specific) && struct.player_specific), "");
		#/
	}
	self.powerup_name = struct.powerup_name;
	self.hint = struct.hint;
	self.only_affects_grabber = struct.only_affects_grabber;
	self.any_team = struct.any_team;
	self.zombie_grabbable = struct.zombie_grabbable;
	self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
	if(isdefined(level._custom_powerups) && isdefined(level._custom_powerups[str_powerup]) && isdefined(level._custom_powerups[str_powerup].setup_powerup))
	{
		self [[level._custom_powerups[str_powerup].setup_powerup]]();
	}
	else
	{
		self zm_powerups::function_76678c8d(powerup_location, struct.model_name, var_a6d11a96);
	}
	if(isdefined(struct.fx))
	{
		self.fx = struct.fx;
	}
	if(isdefined(struct.can_pick_up_in_last_stand))
	{
		self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
	}
	var_b9dc5e9 = (isdefined(struct.var_184f74ef) ? struct.var_184f74ef : 0);
	if(!(isdefined(var_b9dc5e9) && var_b9dc5e9))
	{
		if(str_powerup == "bonus_points_player" || str_powerup == "bonus_points_player_shared" && zm_utility::is_standard())
		{
			self playsound(#"hash_1229e9d60b3181ef");
			self playloopsound(#"hash_46b9bf1ae523021c");
		}
		else
		{
			self playsound(#"zmb_spawn_powerup");
			self playloopsound(#"zmb_spawn_powerup_loop");
		}
	}
	level.active_powerups[level.active_powerups.size] = self;
	self thread zm_powerups::function_14b7208c(str_powerup, powerup_team, powerup_location, powerup_player);
}

