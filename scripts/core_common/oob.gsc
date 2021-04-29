// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace oob;

/*
	Name: function_89f2df9
	Namespace: oob
	Checksum: 0x4EDF9298
	Offset: 0x1C0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: oob
	Checksum: 0x548E3867
	Offset: 0x208
	Size: 0x564
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.oob_triggers = [];
	if(sessionmodeismultiplayergame())
	{
		level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
		level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
		level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
		level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
		level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
		level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
	}
	else if(function_f99d2668())
	{
		level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
		level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
		level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
		level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
		level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
		level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
	}
	else
	{
		level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
		level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 1000);
		level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 5);
		level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 400);
		level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", 1000);
	}
	level.oob_damage_interval_sec = float(level.oob_damage_interval_ms) / 1000;
	var_4eb37b66 = getentarray("trigger_out_of_bounds", "classname");
	/#
		if(var_4eb37b66.size)
		{
			level thread function_e1076862();
		}
	#/
	var_ad08787d = getentarray("trigger_out_of_bounds_new", "classname");
	var_4ed8e045 = arraycombine(var_4eb37b66, var_ad08787d, 1, 0);
	foreach(trigger in var_4ed8e045)
	{
		trigger thread run_oob_trigger();
	}
	val::register("disable_oob", 1, "$self", &disableplayeroob, "$value");
	val::default_value("disable_oob", 0);
	clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
	clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int");
}

/*
	Name: function_e1076862
	Namespace: oob
	Checksum: 0x9D79F78
	Offset: 0x778
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_e1076862()
{
	/#
		level flagsys::wait_till("");
		iprintlnbold("");
	#/
}

/*
	Name: run_oob_trigger
	Namespace: oob
	Checksum: 0x1EB70A73
	Offset: 0x7C0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function run_oob_trigger()
{
	self.oob_players = [];
	if(!isdefined(level.oob_triggers))
	{
		level.oob_triggers = [];
	}
	else if(!isarray(level.oob_triggers))
	{
		level.oob_triggers = array(level.oob_triggers);
	}
	level.oob_triggers[level.oob_triggers.size] = self;
	self thread waitforplayertouch();
	self thread waitforclonetouch();
}

/*
	Name: isoutofbounds
	Namespace: oob
	Checksum: 0x5DB4318F
	Offset: 0x888
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function isoutofbounds()
{
	if(!isdefined(self.oob_start_time))
	{
		return 0;
	}
	return self.oob_start_time != -1;
}

/*
	Name: istouchinganyoobtrigger
	Namespace: oob
	Checksum: 0x905C4D42
	Offset: 0x8B0
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function istouchinganyoobtrigger()
{
	result = 0;
	if(isplayer(self) && function_65b20())
	{
		return 0;
	}
	level.oob_triggers = array::remove_undefined(level.oob_triggers);
	foreach(trigger in level.oob_triggers)
	{
		if(!trigger istriggerenabled())
		{
			continue;
		}
		n_flags = function_27f2ef17(trigger);
		if(trigger.classname == "trigger_out_of_bounds_new" && (self.team == #"axis" && !n_flags & 1) || (self.team == #"allies" && !n_flags & 2))
		{
			continue;
		}
		if(self istouching(trigger))
		{
			result = 1;
			break;
		}
	}
	if(result == 0 && self.var_8516173f === 1 && function_9fcf70e6())
	{
		result = !self isinsideheightlock();
	}
	return result;
}

/*
	Name: function_e3fdd830
	Namespace: oob
	Checksum: 0xC654EF7E
	Offset: 0xAB0
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function function_e3fdd830(point)
{
	level.oob_triggers = array::remove_undefined(level.oob_triggers);
	foreach(trigger in level.oob_triggers)
	{
		if(!trigger istriggerenabled())
		{
			continue;
		}
		if(istouching(point, trigger))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: resetoobtimer
	Namespace: oob
	Checksum: 0x2CA0683B
	Offset: 0xB90
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function resetoobtimer(is_host_migrating, b_disable_timekeep)
{
	self.oob_lastvalidplayerloc = undefined;
	self.oob_lastvalidplayerdir = undefined;
	self clientfield::set_to_player("out_of_bounds", 0);
	self val::reset(#"oob", "show_hud");
	self.oob_start_time = -1;
	if(isdefined(level.oob_timekeep_ms))
	{
		if(isdefined(b_disable_timekeep) && b_disable_timekeep)
		{
			self.last_oob_timekeep_ms = undefined;
		}
		else
		{
			self.last_oob_timekeep_ms = gettime();
		}
	}
	if(!(isdefined(is_host_migrating) && is_host_migrating))
	{
		self notify(#"oob_host_migration_exit");
	}
	self notify(#"oob_exit");
}

/*
	Name: waitforclonetouch
	Namespace: oob
	Checksum: 0xE97C9157
	Offset: 0xC80
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function waitforclonetouch()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		clone = waitresult.activator;
		if(isactor(clone) && isdefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted())
		{
			clone notify(#"clone_shutdown");
		}
	}
}

/*
	Name: getadjusedplayer
	Namespace: oob
	Checksum: 0x5951F19F
	Offset: 0xD58
	Size: 0x48
	Parameters: 1
	Flags: None
*/
function getadjusedplayer(player)
{
	if(isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity))
	{
		return player.hijacked_vehicle_entity;
	}
	return player;
}

/*
	Name: waitforplayertouch
	Namespace: oob
	Checksum: 0x1D891C1D
	Offset: 0xDA8
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function waitforplayertouch()
{
	self endon(#"death");
	while(true)
	{
		if(sessionmodeismultiplayergame() || function_f99d2668())
		{
			hostmigration::waittillhostmigrationdone();
		}
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		entity = waitresult.activator;
		if(isplayer(entity))
		{
			player = entity;
		}
		else if(isvehicle(entity) && isalive(entity))
		{
			player = entity getseatoccupant(0);
			if(!isdefined(player) || !isplayer(player))
			{
				continue;
			}
			if(isdefined(entity.var_50e3187f) && entity.var_50e3187f)
			{
				continue;
			}
		}
		else
		{
			continue;
		}
		if(player function_65b20())
		{
			continue;
		}
		if(player isoutofbounds())
		{
			continue;
		}
		player function_11c959d9(entity);
	}
}

/*
	Name: function_11c959d9
	Namespace: oob
	Checksum: 0xE4B32947
	Offset: 0xF78
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_11c959d9(entity)
{
	player = self;
	player notify(#"oob_enter");
	if(isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms)
	{
		player.oob_start_time = gettime() - level.oob_timelimit_ms - player.last_oob_duration_ms;
	}
	else
	{
		player.oob_start_time = gettime();
	}
	player.oob_lastvalidplayerloc = entity.origin;
	player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
	player clientfield::set_to_player("nonplayer_oob_usage", 0);
	player val::set(#"oob", "show_hud", 0);
	player thread watchforleave(entity);
	player thread watchfordeath(entity);
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		player thread watchforhostmigration(entity);
	}
}

/*
	Name: function_c5278cb0
	Namespace: oob
	Checksum: 0xCEBB6651
	Offset: 0x1148
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function function_c5278cb0(vehicle)
{
	self endon(#"disconnect");
	if(vehicle.var_8516173f !== 1)
	{
		return;
	}
	self notify("4986a6d17190ada9" + vehicle getentitynumber());
	self endon("4986a6d17190ada9" + vehicle getentitynumber());
	vehicle endon(#"death");
	while(true)
	{
		if(!vehicle isinsideheightlock())
		{
			self function_11c959d9(vehicle);
			self waittill(#"oob_exit");
		}
		wait(0.1);
	}
}

/*
	Name: function_65b20
	Namespace: oob
	Checksum: 0x3BBE4319
	Offset: 0x1238
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_65b20()
{
	if(self scene::is_igc_active())
	{
		return 1;
	}
	if(isdefined(self.oobdisabled) && self.oobdisabled)
	{
		return 1;
	}
	if(level flag::exists("draft_complete") && !level flag::get("draft_complete"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: getdistancefromlastvalidplayerloc
	Namespace: oob
	Checksum: 0x838C722C
	Offset: 0x12D0
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function getdistancefromlastvalidplayerloc(entity)
{
	if(isdefined(self.oob_lastvalidplayerdir) && self.oob_lastvalidplayerdir != (0, 0, 0))
	{
		vectoplayerlocfromorigin = entity.origin - self.oob_lastvalidplayerloc;
		distance = vectordot(vectoplayerlocfromorigin, self.oob_lastvalidplayerdir);
	}
	else
	{
		distance = distance(entity.origin, self.oob_lastvalidplayerloc);
	}
	if(distance < 0)
	{
		distance = 0;
	}
	if(distance > level.oob_max_distance_before_black)
	{
		distance = level.oob_max_distance_before_black;
	}
	return distance / level.oob_max_distance_before_black;
}

/*
	Name: updatevisualeffects
	Namespace: oob
	Checksum: 0xD1426056
	Offset: 0x13B0
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function updatevisualeffects(entity)
{
	timeremaining = 0;
	if(isdefined(level.oob_timelimit_ms) && isdefined(self.oob_start_time))
	{
		timeremaining = level.oob_timelimit_ms - gettime() - self.oob_start_time;
	}
	if(entity.var_c5d65381 === 1 && isplayer(self) && !self isremotecontrolling() && isvehicle(entity))
	{
		self clientfield::set_to_player("out_of_bounds", 0);
		self val::reset(#"oob", "show_hud");
		return;
	}
	if(isdefined(level.oob_timekeep_ms))
	{
		self.last_oob_duration_ms = timeremaining;
	}
	oob_effectvalue = 0;
	if(timeremaining <= level.oob_time_remaining_before_black)
	{
		if(!isdefined(self.oob_lasteffectvalue))
		{
			self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(entity);
		}
		time_val = 1 - timeremaining / level.oob_time_remaining_before_black;
		if(time_val > 1)
		{
			time_val = 1;
		}
		oob_effectvalue = self.oob_lasteffectvalue + 1 - self.oob_lasteffectvalue * time_val;
	}
	else
	{
		oob_effectvalue = getdistancefromlastvalidplayerloc(entity);
		if(oob_effectvalue > 0.9)
		{
			oob_effectvalue = 0.9;
		}
		else if(oob_effectvalue < 0.05)
		{
			oob_effectvalue = 0.05;
		}
		self.oob_lasteffectvalue = oob_effectvalue;
	}
	oob_effectvalue = ceil(oob_effectvalue * 31);
	self clientfield::set_to_player("out_of_bounds", int(oob_effectvalue));
}

/*
	Name: killentity
	Namespace: oob
	Checksum: 0x23F05D42
	Offset: 0x1620
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function killentity(entity)
{
	self resetoobtimer();
	if(isdefined(level.var_bde3d03))
	{
		[[level.var_bde3d03]](entity);
		return;
	}
	entity val::set(#"oob", "takedamage", 1);
	if(isplayer(entity) && entity isinvehicle())
	{
		vehicle = entity getvehicleoccupied();
		vehicle val::set(#"oob", "takedamage", 1);
		occupants = vehicle getvehoccupants();
		foreach(occupant in occupants)
		{
			occupant unlink();
		}
		if(!(isdefined(vehicle.allowdeath) && !vehicle.allowdeath))
		{
			vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
		}
	}
	entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);
	if(isplayer(entity))
	{
		entity suicide();
	}
}

/*
	Name: watchforleave
	Namespace: oob
	Checksum: 0xAB6CD90A
	Offset: 0x18A0
	Size: 0x210
	Parameters: 1
	Flags: Linked
*/
function watchforleave(entity)
{
	self endon(#"oob_exit");
	self endon(#"disconnect");
	entity endon(#"death");
	while(true)
	{
		if(entity istouchinganyoobtrigger() && (isplayer(entity) || (isplayer(self) && self isremotecontrolling()) || entity.var_c5d65381 === 1))
		{
			updatevisualeffects(entity);
			cur_time = gettime();
			elapsed_time = cur_time - self.oob_start_time;
			if(elapsed_time > level.oob_timelimit_ms)
			{
				if(isplayer(entity))
				{
					entity val::set(#"oob_touch", "ignoreme", 0);
					entity.laststand = undefined;
					if(isdefined(entity.revivetrigger))
					{
						entity.revivetrigger delete();
					}
				}
				if(self !== entity)
				{
					self.last_oob_duration_ms = level.oob_timelimit_ms;
					self clientfield::set_to_player("nonplayer_oob_usage", 1);
				}
				self thread killentity(entity);
			}
		}
		else
		{
			self resetoobtimer();
		}
		wait(0.1);
	}
}

/*
	Name: watchfordeath
	Namespace: oob
	Checksum: 0x37F29FED
	Offset: 0x1AB8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function watchfordeath(entity)
{
	self endon(#"disconnect", #"oob_exit");
	util::waittill_any_ents_two(self, "death", entity, "death");
	self resetoobtimer();
}

/*
	Name: watchforhostmigration
	Namespace: oob
	Checksum: 0xC1F09C11
	Offset: 0x1B38
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function watchforhostmigration(entity)
{
	self endon(#"oob_host_migration_exit");
	level waittill(#"host_migration_begin");
	self resetoobtimer(1, 1);
}

/*
	Name: disableplayeroob
	Namespace: oob
	Checksum: 0x77D5B80
	Offset: 0x1B98
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
private function disableplayeroob(disabled)
{
	if(disabled)
	{
		self resetoobtimer();
		self.oobdisabled = 1;
	}
	else
	{
		self.oobdisabled = 0;
	}
}

