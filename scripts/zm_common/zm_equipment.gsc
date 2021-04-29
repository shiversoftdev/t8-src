// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2cb831533cab2794;
#using script_2dc48f46bfeac894;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_equipment;

/*
	Name: function_89f2df9
	Namespace: zm_equipment
	Checksum: 0x82633D7B
	Offset: 0x1E8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_equipment", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_equipment
	Checksum: 0x204B8196
	Offset: 0x238
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.buildable_piece_count = 24;
	/#
		level.abilities_devgui_add_gadgets_custom = &abilities_devgui_add_gadgets_custom;
	#/
	level.placeable_equipment_destroy_fn = [];
	if(!(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield))
	{
		clientfield::register("scriptmover", "equipment_activated", 1, 4, "int");
	}
	level.zm_hint_text = zm_hint_text::register("zm_hint_text");
}

/*
	Name: __main__
	Namespace: zm_equipment
	Checksum: 0x50ADC020
	Offset: 0x2F0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	init_upgrade();
}

/*
	Name: abilities_devgui_add_gadgets_custom
	Namespace: zm_equipment
	Checksum: 0x161867AB
	Offset: 0x310
	Size: 0xD60
	Parameters: 4
	Flags: None
*/
function abilities_devgui_add_gadgets_custom(root, pname, pid, menu_index)
{
	/#
		var_61b8f8fb = "";
		add_cmd_with_root = "" + var_61b8f8fb + pname + "";
		a_abilities = [];
		arrayinsert(a_abilities, getweapon(#"hash_34b7eb9fde56bd35"), 0);
		arrayinsert(a_abilities, getweapon(#"incendiary_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"sticky_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"proximity_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"incendiary_fire"), 0);
		arrayinsert(a_abilities, getweapon(#"concussion_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"flash_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"emp_grenade"), 0);
		arrayinsert(a_abilities, getweapon(#"cymbal_monkey"), 0);
		arrayinsert(a_abilities, getweapon(#"hash_13fbf1dd07d9cf3e"), 0);
		arrayinsert(a_abilities, getweapon(#"tomahawk_t8"), 0);
		ability_player::function_174037fe(add_cmd_with_root, pid, a_abilities, "", menu_index);
		var_ab290760 = [];
		arrayinsert(var_ab290760, getweapon(#"hero_gravityspikes"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_lightninggun"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_minigun"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_pineapplegun"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chemicalgelgun"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_bowlauncher"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_armblade"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_annihilator"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_flamethrower"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35e4cfb775e02"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35d4cfb775c4f"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35c4cfb775a9c"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_chakram_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_hammer_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35e4cfb775e02"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35d4cfb775c4f"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_50f35c4cfb775a9c"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv2"), 0);
		arrayinsert(var_ab290760, getweapon(#"hero_sword_pistol_lv3"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_18829d56b3fbd75b"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_18829e56b3fbd90e"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_18829f56b3fbdac1"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_1d3a5509fa2c9ee6"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_1d3a5409fa2c9d33"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_1d3a5309fa2c9b80"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_6627879099b8a337"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_6627889099b8a4ea"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_6627899099b8a69d"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_74dd67dd8a46d144"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_74dd6add8a46d65d"), 0);
		arrayinsert(var_ab290760, getweapon(#"hash_74dd69dd8a46d4aa"), 0);
		ability_player::function_a40d04ca(add_cmd_with_root, pid, var_ab290760, "", menu_index);
		menu_index++;
		menu_index = ability_player::abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
		menu_index = ability_player::function_2e0162e9(add_cmd_with_root, pid, menu_index);
		adddebugcommand("");
		return menu_index;
	#/
}

/*
	Name: signal_activated
	Namespace: zm_equipment
	Checksum: 0xFBFEB987
	Offset: 0x1080
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function signal_activated(val = 1)
{
	if(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield)
	{
		return;
	}
	self endon(#"death");
	self clientfield::set("equipment_activated", val);
	for(i = 0; i < 2; i++)
	{
		util::wait_network_frame();
	}
	self clientfield::set("equipment_activated", 0);
}

/*
	Name: register
	Namespace: zm_equipment
	Checksum: 0xEF7B71DC
	Offset: 0x1150
	Size: 0x1E4
	Parameters: 5
	Flags: None
*/
function register(equipment_name, hint, howto_hint, hint_icon, equipmentvo)
{
	equipment = getweapon(equipment_name);
	struct = spawnstruct();
	if(!isdefined(level.zombie_equipment))
	{
		level.zombie_equipment = [];
	}
	struct.equipment = equipment;
	struct.hint = hint;
	struct.howto_hint = howto_hint;
	struct.hint_icon = hint_icon;
	struct.vox = equipmentvo;
	struct.triggers = [];
	struct.models = [];
	struct.notify_strings = spawnstruct();
	struct.notify_strings.activate = equipment.name + "_activate";
	struct.notify_strings.deactivate = equipment.name + "_deactivate";
	struct.notify_strings.taken = equipment.name + "_taken";
	struct.notify_strings.pickup = equipment.name + "_pickup";
	level.zombie_equipment[equipment] = struct;
	/#
		level thread function_1d34b98d(equipment);
	#/
}

/*
	Name: register_slot_watcher_override
	Namespace: zm_equipment
	Checksum: 0x1FD76761
	Offset: 0x1340
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function register_slot_watcher_override(str_equipment, func_slot_watcher_override)
{
	level.a_func_equipment_slot_watcher_override[str_equipment] = func_slot_watcher_override;
}

/*
	Name: is_included
	Namespace: zm_equipment
	Checksum: 0x8307EE42
	Offset: 0x1378
	Size: 0x66
	Parameters: 1
	Flags: None
*/
function is_included(equipment)
{
	if(!isdefined(level.zombie_include_equipment))
	{
		return 0;
	}
	if(isstring(equipment))
	{
		equipment = getweapon(equipment);
	}
	return isdefined(level.zombie_include_equipment[equipment.rootweapon]);
}

/*
	Name: include
	Namespace: zm_equipment
	Checksum: 0xB64259A7
	Offset: 0x13E8
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function include(equipment_name)
{
	if(!isdefined(level.zombie_include_equipment))
	{
		level.zombie_include_equipment = [];
	}
	level.zombie_include_equipment[getweapon(equipment_name)] = 1;
}

/*
	Name: set_ammo_driven
	Namespace: zm_equipment
	Checksum: 0x4D06C965
	Offset: 0x1448
	Size: 0xA6
	Parameters: 3
	Flags: None
*/
function set_ammo_driven(equipment_name, start, refill_max_ammo = 0)
{
	level.zombie_equipment[getweapon(equipment_name)].notake = 1;
	level.zombie_equipment[getweapon(equipment_name)].start_ammo = start;
	level.zombie_equipment[getweapon(equipment_name)].refill_max_ammo = refill_max_ammo;
}

/*
	Name: limit
	Namespace: zm_equipment
	Checksum: 0xE2DB8578
	Offset: 0x14F8
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function limit(equipment_name, limited)
{
	if(!isdefined(level._limited_equipment))
	{
		level._limited_equipment = [];
	}
	if(limited)
	{
		level._limited_equipment[level._limited_equipment.size] = getweapon(equipment_name);
	}
	else
	{
		arrayremovevalue(level._limited_equipment, getweapon(equipment_name), 0);
	}
}

/*
	Name: init_upgrade
	Namespace: zm_equipment
	Checksum: 0x9D425A1B
	Offset: 0x1598
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function init_upgrade()
{
	equipment_spawns = [];
	equipment_spawns = getentarray("zombie_equipment_upgrade", "targetname");
	for(i = 0; i < equipment_spawns.size; i++)
	{
		equipment_spawns[i].equipment = getweapon(equipment_spawns[i].zombie_equipment_upgrade);
		hint_string = get_hint(equipment_spawns[i].equipment);
		equipment_spawns[i] sethintstring(hint_string);
		equipment_spawns[i] setcursorhint("HINT_NOICON");
		equipment_spawns[i] usetriggerrequirelookat();
		equipment_spawns[i] add_to_trigger_list(equipment_spawns[i].equipment);
		equipment_spawns[i] thread equipment_spawn_think();
	}
}

/*
	Name: get_hint
	Namespace: zm_equipment
	Checksum: 0x3F2B4D36
	Offset: 0x1700
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_hint(equipment)
{
	/#
		assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "");
	#/
	return level.zombie_equipment[equipment].hint;
}

/*
	Name: get_howto_hint
	Namespace: zm_equipment
	Checksum: 0x45C40936
	Offset: 0x1768
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_howto_hint(equipment)
{
	/#
		assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "");
	#/
	return level.zombie_equipment[equipment].howto_hint;
}

/*
	Name: get_icon
	Namespace: zm_equipment
	Checksum: 0x6F7FB347
	Offset: 0x17D0
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function get_icon(equipment)
{
	/#
		assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "");
	#/
	return level.zombie_equipment[equipment].hint_icon;
}

/*
	Name: get_notify_strings
	Namespace: zm_equipment
	Checksum: 0x56329EBA
	Offset: 0x1838
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_notify_strings(equipment)
{
	/#
		assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "");
	#/
	return level.zombie_equipment[equipment].notify_strings;
}

/*
	Name: add_to_trigger_list
	Namespace: zm_equipment
	Checksum: 0x62127ED3
	Offset: 0x18A0
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function add_to_trigger_list(equipment)
{
	/#
		assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "");
	#/
	level.zombie_equipment[equipment].triggers[level.zombie_equipment[equipment].triggers.size] = self;
	level.zombie_equipment[equipment].models[level.zombie_equipment[equipment].models.size] = getent(self.target, "targetname");
}

/*
	Name: equipment_spawn_think
	Namespace: zm_equipment
	Checksum: 0x86B68686
	Offset: 0x1978
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function equipment_spawn_think()
{
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(player zm_utility::in_revive_trigger() || player zm_utility::is_drinking())
		{
			wait(0.1);
			continue;
		}
		if(!is_limited(self.equipment) || !limited_in_use(self.equipment))
		{
			if(is_limited(self.equipment))
			{
				player setup_limited(self.equipment);
				if(isdefined(level.hacker_tool_positions))
				{
					new_pos = array::random(level.hacker_tool_positions);
					self.origin = new_pos.trigger_org;
					model = getent(self.target, "targetname");
					model.origin = new_pos.model_org;
					model.angles = new_pos.model_ang;
				}
			}
			player give(self.equipment);
			continue;
		}
		wait(0.1);
	}
}

/*
	Name: set_equipment_invisibility_to_player
	Namespace: zm_equipment
	Checksum: 0x23555719
	Offset: 0x1B48
	Size: 0xFE
	Parameters: 2
	Flags: Linked
*/
function set_equipment_invisibility_to_player(equipment, invisible)
{
	triggers = level.zombie_equipment[equipment].triggers;
	for(i = 0; i < triggers.size; i++)
	{
		if(isdefined(triggers[i]))
		{
			triggers[i] setinvisibletoplayer(self, invisible);
		}
	}
	models = level.zombie_equipment[equipment].models;
	for(i = 0; i < models.size; i++)
	{
		if(isdefined(models[i]))
		{
			models[i] setinvisibletoplayer(self, invisible);
		}
	}
}

/*
	Name: take
	Namespace: zm_equipment
	Checksum: 0x9D6710DE
	Offset: 0x1C50
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function take(equipment = self get_player_equipment())
{
	if(!isdefined(equipment))
	{
		return;
	}
	if(equipment == level.weaponnone)
	{
		return;
	}
	if(!self has_player_equipment(equipment))
	{
		return;
	}
	current = 0;
	current_weapon = 0;
	if(isdefined(self get_player_equipment()) && equipment == self get_player_equipment())
	{
		current = 1;
	}
	if(equipment == self getcurrentweapon())
	{
		current_weapon = 1;
	}
	/#
		println("" + self.name + "" + function_a16a090d(equipment) + "");
	#/
	notify_strings = get_notify_strings(equipment);
	if(isdefined(self.current_equipment_active[equipment]) && self.current_equipment_active[equipment])
	{
		self.current_equipment_active[equipment] = 0;
		self notify(notify_strings.deactivate);
	}
	self notify(notify_strings.taken);
	if(!is_limited(equipment) || (is_limited(equipment) && !limited_in_use(equipment)))
	{
		self set_equipment_invisibility_to_player(equipment, 0);
	}
	if(current)
	{
		self set_player_equipment(level.weaponnone);
		self setactionslot(2, "");
	}
	else
	{
		arrayremovevalue(self.deployed_equipment, equipment);
	}
	if(self hasweapon(equipment))
	{
		self takeweapon(equipment);
	}
	if(current_weapon)
	{
		self zm_weapons::switch_back_primary_weapon();
	}
}

/*
	Name: give
	Namespace: zm_equipment
	Checksum: 0x62E43110
	Offset: 0x1F30
	Size: 0x1EE
	Parameters: 1
	Flags: Linked
*/
function give(equipment)
{
	if(!isdefined(equipment))
	{
		return;
	}
	if(!isdefined(level.zombie_equipment[equipment]))
	{
		return;
	}
	if(self has_player_equipment(equipment))
	{
		return;
	}
	/#
		println("" + self.name + "" + function_a16a090d(equipment) + "");
	#/
	curr_weapon = self getcurrentweapon();
	curr_weapon_was_curr_equipment = self is_player_equipment(curr_weapon);
	self take();
	self set_player_equipment(equipment);
	self giveweapon(equipment);
	self start_ammo(equipment);
	self thread show_hint(equipment);
	self set_equipment_invisibility_to_player(equipment, 1);
	self setactionslot(2, "weapon", equipment);
	self thread slot_watcher(equipment);
	self zm_audio::create_and_play_dialog(#"weapon_pickup", level.zombie_equipment[equipment].vox);
	self notify(#"player_given", equipment);
}

/*
	Name: buy
	Namespace: zm_equipment
	Checksum: 0x7518F3B5
	Offset: 0x2128
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function buy(equipment)
{
	if(isstring(equipment))
	{
		equipment = getweapon(equipment);
	}
	/#
		println("" + self.name + "" + function_a16a090d(equipment) + "");
	#/
	if(isdefined(self.current_equipment) && equipment != self.current_equipment && self.current_equipment != level.weaponnone)
	{
		self take(self.current_equipment);
	}
	self notify(#"player_bought", equipment);
	self give(equipment);
	if(equipment.isriotshield && isdefined(self.player_shield_reset_health))
	{
		self [[self.player_shield_reset_health]](equipment);
	}
}

/*
	Name: slot_watcher
	Namespace: zm_equipment
	Checksum: 0x881BD8BF
	Offset: 0x2268
	Size: 0x21E
	Parameters: 1
	Flags: Linked
*/
function slot_watcher(equipment)
{
	self notify(#"kill_equipment_slot_watcher");
	self endon(#"kill_equipment_slot_watcher", #"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		prev_weapon = waitresult.last_weapon;
		curr_weapon = waitresult.weapon;
		self.prev_weapon_before_equipment_change = undefined;
		if(isdefined(prev_weapon) && level.weaponnone != prev_weapon)
		{
			prev_weapon_type = prev_weapon.inventorytype;
			if("primary" == prev_weapon_type || "altmode" == prev_weapon_type)
			{
				self.prev_weapon_before_equipment_change = prev_weapon;
			}
		}
		if(!isdefined(level.a_func_equipment_slot_watcher_override))
		{
			level.a_func_equipment_slot_watcher_override = [];
		}
		if(isdefined(level.a_func_equipment_slot_watcher_override[equipment.name]))
		{
			self [[level.a_func_equipment_slot_watcher_override[equipment.name]]](equipment, curr_weapon, prev_weapon, notify_strings);
		}
		else if(curr_weapon == equipment && !self.current_equipment_active[equipment])
		{
			self notify(notify_strings.activate);
			self.current_equipment_active[equipment] = 1;
		}
		else if(curr_weapon != equipment && self.current_equipment_active[equipment])
		{
			self notify(notify_strings.deactivate);
			self.current_equipment_active[equipment] = 0;
		}
	}
}

/*
	Name: is_limited
	Namespace: zm_equipment
	Checksum: 0x5F00398E
	Offset: 0x2490
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function is_limited(equipment)
{
	if(isdefined(level._limited_equipment))
	{
		for(i = 0; i < level._limited_equipment.size; i++)
		{
			if(level._limited_equipment[i] == equipment)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: limited_in_use
	Namespace: zm_equipment
	Checksum: 0xF70F3F9A
	Offset: 0x2500
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function limited_in_use(equipment)
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		current_equipment = players[i] get_player_equipment();
		if(isdefined(current_equipment) && current_equipment == equipment)
		{
			return 1;
		}
	}
	if(isdefined(level.dropped_equipment) && isdefined(level.dropped_equipment[equipment]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: setup_limited
	Namespace: zm_equipment
	Checksum: 0x88095B08
	Offset: 0x25C8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function setup_limited(equipment)
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] set_equipment_invisibility_to_player(equipment, 1);
	}
	self thread release_limited_on_disconnect(equipment);
	self thread release_limited_on_taken(equipment);
}

/*
	Name: release_limited_on_taken
	Namespace: zm_equipment
	Checksum: 0xAE1A98EE
	Offset: 0x2670
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function release_limited_on_taken(equipment)
{
	self endon(#"disconnect");
	notify_strings = get_notify_strings(equipment);
	self util::waittill_either(notify_strings.taken, "spawned_spectator");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] set_equipment_invisibility_to_player(equipment, 0);
	}
}

/*
	Name: release_limited_on_disconnect
	Namespace: zm_equipment
	Checksum: 0xC4DF0DA1
	Offset: 0x2740
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function release_limited_on_disconnect(equipment)
{
	notify_strings = get_notify_strings(equipment);
	self endon(notify_strings.taken);
	self waittill(#"disconnect");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isalive(players[i]))
		{
			players[i] set_equipment_invisibility_to_player(equipment, 0);
		}
	}
}

/*
	Name: is_active
	Namespace: zm_equipment
	Checksum: 0x437EAAC2
	Offset: 0x2820
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function is_active(equipment)
{
	if(!isdefined(self.current_equipment_active) || !isdefined(self.current_equipment_active[equipment]))
	{
		return 0;
	}
	return self.current_equipment_active[equipment];
}

/*
	Name: init_hint_hudelem
	Namespace: zm_equipment
	Checksum: 0x9D94FBE6
	Offset: 0x2870
	Size: 0x8A
	Parameters: 6
	Flags: None
*/
function init_hint_hudelem(x, y, alignx, aligny, fontscale, alpha)
{
	self.x = x;
	self.y = y;
	self.alignx = alignx;
	self.aligny = aligny;
	self.fontscale = fontscale;
	self.alpha = alpha;
	self.sort = 20;
}

/*
	Name: setup_client_hintelem
	Namespace: zm_equipment
	Checksum: 0x124AD65A
	Offset: 0x2908
	Size: 0x184
	Parameters: 2
	Flags: None
*/
function setup_client_hintelem(ypos, font_scale)
{
	/#
		if(!isdefined(ypos))
		{
			ypos = 220;
		}
		if(!isdefined(font_scale))
		{
			font_scale = 1.25;
		}
		self endon(#"death");
		if(!isdefined(self.hintelem))
		{
			self.hintelem = newdebughudelem(self);
		}
		if(self issplitscreen())
		{
			if(getdvarint(#"splitscreen_playercount", 0) >= 3)
			{
				self.hintelem init_hint_hudelem(160, 90, "", "", font_scale * 0.8, 1);
			}
			else
			{
				self.hintelem init_hint_hudelem(160, 90, "", "", font_scale, 1);
			}
		}
		else
		{
			self.hintelem init_hint_hudelem(320, ypos, "", "", font_scale, 1);
		}
	#/
}

/*
	Name: show_hint
	Namespace: zm_equipment
	Checksum: 0xE6213C83
	Offset: 0x2A98
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function show_hint(equipment)
{
	self notify(#"kill_previous_show_equipment_hint_thread");
	self endon(#"kill_previous_show_equipment_hint_thread", #"death");
	if(isdefined(self.do_not_display_equipment_pickup_hint) && self.do_not_display_equipment_pickup_hint)
	{
		return;
	}
	wait(0.5);
	text = get_howto_hint(equipment);
	self show_hint_text(text);
}

/*
	Name: show_hint_text
	Namespace: zm_equipment
	Checksum: 0xFD7DE478
	Offset: 0x2B40
	Size: 0x25C
	Parameters: 4
	Flags: Linked
*/
function show_hint_text(text, show_for_time = 3.2, font_scale = 1.25, ypos = 220)
{
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}
	self notify("1caf49f0db5051c");
	self endon("1caf49f0db5051c");
	self endon(#"disconnect");
	level endon_callback(&function_57fbff5c, #"end_game");
	if(!level.zm_hint_text zm_hint_text::is_open(self))
	{
		level.zm_hint_text zm_hint_text::open(self);
	}
	level.zm_hint_text zm_hint_text::function_d5ea17f0(self, text);
	level.zm_hint_text zm_hint_text::set_state(self, #"visible");
	time = undefined;
	time = self waittill_timeout(show_for_time, #"hide_equipment_hint_text", #"death", #"disconnect");
	if(isdefined(time) && isdefined(self) && level.zm_hint_text zm_hint_text::is_open(self))
	{
		level.zm_hint_text zm_hint_text::set_state(self, #"defaultstate");
		self waittill_timeout(1, #"hide_equipment_hint_text");
	}
	if(isdefined(self) && level.zm_hint_text zm_hint_text::is_open(self))
	{
		level.zm_hint_text zm_hint_text::close(self);
	}
}

/*
	Name: function_57fbff5c
	Namespace: zm_equipment
	Checksum: 0x9D034914
	Offset: 0x2DA8
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_57fbff5c(str_notify)
{
	foreach(player in level.players)
	{
		if(isdefined(player) && level.zm_hint_text zm_hint_text::is_open(player))
		{
			level.zm_hint_text zm_hint_text::close(player);
		}
	}
}

/*
	Name: start_ammo
	Namespace: zm_equipment
	Checksum: 0x82A52645
	Offset: 0x2E68
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function start_ammo(equipment)
{
	if(self hasweapon(equipment))
	{
		maxammo = 1;
		if(isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake)
		{
			maxammo = level.zombie_equipment[equipment].start_ammo;
		}
		self setweaponammoclip(equipment, maxammo);
		self notify(#"equipment_ammo_changed", {#equipment:equipment});
		return maxammo;
	}
	return 0;
}

/*
	Name: change_ammo
	Namespace: zm_equipment
	Checksum: 0x50AD69CE
	Offset: 0x2F48
	Size: 0x146
	Parameters: 2
	Flags: None
*/
function change_ammo(equipment, change)
{
	if(self hasweapon(equipment))
	{
		oldammo = self getweaponammoclip(equipment);
		maxammo = 1;
		if(isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake)
		{
			maxammo = level.zombie_equipment[equipment].start_ammo;
		}
		newammo = int(min(maxammo, max(0, oldammo + change)));
		self setweaponammoclip(equipment, newammo);
		self notify(#"equipment_ammo_changed", {#equipment:equipment});
		return newammo;
	}
	return 0;
}

/*
	Name: register_for_level
	Namespace: zm_equipment
	Checksum: 0x7FF3B188
	Offset: 0x3098
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function register_for_level(weaponname)
{
	weapon = getweapon(weaponname);
	if(is_equipment(weapon))
	{
		return;
	}
	if(!isdefined(level.zombie_equipment_list))
	{
		level.zombie_equipment_list = [];
	}
	level.zombie_equipment_list[weapon] = weapon;
}

/*
	Name: is_equipment
	Namespace: zm_equipment
	Checksum: 0x2CF65096
	Offset: 0x3120
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function is_equipment(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_equipment_list))
	{
		return 0;
	}
	return isdefined(level.zombie_equipment_list[weapon]);
}

/*
	Name: is_equipment_that_blocks_purchase
	Namespace: zm_equipment
	Checksum: 0x5B3A7B91
	Offset: 0x3168
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_equipment_that_blocks_purchase(weapon)
{
	return is_equipment(weapon);
}

/*
	Name: is_player_equipment
	Namespace: zm_equipment
	Checksum: 0x9BDA1477
	Offset: 0x3198
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function is_player_equipment(weapon)
{
	if(!isdefined(weapon) || !isdefined(self.current_equipment))
	{
		return 0;
	}
	return self.current_equipment == weapon;
}

/*
	Name: has_deployed_equipment
	Namespace: zm_equipment
	Checksum: 0x83859315
	Offset: 0x31D8
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function has_deployed_equipment(weapon)
{
	if(!isdefined(weapon) || !isdefined(self.deployed_equipment) || self.deployed_equipment.size < 1)
	{
		return 0;
	}
	for(i = 0; i < self.deployed_equipment.size; i++)
	{
		if(self.deployed_equipment[i] == weapon)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: has_player_equipment
	Namespace: zm_equipment
	Checksum: 0xC2EA3664
	Offset: 0x3268
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function has_player_equipment(weapon)
{
	return self is_player_equipment(weapon) || self has_deployed_equipment(weapon);
}

/*
	Name: get_player_equipment
	Namespace: zm_equipment
	Checksum: 0x8A101A5E
	Offset: 0x32B0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function get_player_equipment()
{
	equipment = level.weaponnone;
	if(isdefined(self.current_equipment))
	{
		equipment = self.current_equipment;
	}
	return equipment;
}

/*
	Name: hacker_active
	Namespace: zm_equipment
	Checksum: 0xDC210434
	Offset: 0x32F0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function hacker_active()
{
	return self is_active(getweapon(#"equip_hacker"));
}

/*
	Name: set_player_equipment
	Namespace: zm_equipment
	Checksum: 0x6A152DF5
	Offset: 0x3330
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function set_player_equipment(weapon)
{
	if(!isdefined(self.current_equipment_active))
	{
		self.current_equipment_active = [];
	}
	if(isdefined(weapon))
	{
		self.current_equipment_active[weapon] = 0;
	}
	if(!isdefined(self.equipment_got_in_round))
	{
		self.equipment_got_in_round = [];
	}
	if(isdefined(weapon))
	{
		self.equipment_got_in_round[weapon] = level.round_number;
	}
	self notify(#"new_equipment", weapon);
	self.current_equipment = weapon;
}

/*
	Name: init_player_equipment
	Namespace: zm_equipment
	Checksum: 0xF64A1D84
	Offset: 0x33D8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_player_equipment()
{
	self set_player_equipment(level.zombie_equipment_player_init);
}

/*
	Name: function_7d948481
	Namespace: zm_equipment
	Checksum: 0xF6717638
	Offset: 0x3408
	Size: 0xFA
	Parameters: 4
	Flags: Linked
*/
function function_7d948481(var_52c8cf74 = 0.1, var_9a35edeb = 0.25, var_69ddab33 = 0.5, var_54fa03d9 = 1)
{
	if(!isdefined(self.var_6f84b820))
	{
		return 1;
	}
	switch(self.var_6f84b820)
	{
		case "boss":
		{
			return var_52c8cf74;
		}
		case "miniboss":
		{
			return var_9a35edeb;
		}
		case "heavy":
		{
			return var_69ddab33;
		}
		default:
		{
			return var_54fa03d9;
		}
	}
}

/*
	Name: function_379f6b5d
	Namespace: zm_equipment
	Checksum: 0x10E122F5
	Offset: 0x3510
	Size: 0xC2
	Parameters: 5
	Flags: Linked
*/
function function_379f6b5d(n_base_damage, var_177ec733 = 1, var_b68e56de = 1, var_694e2cee = 4, var_f14e81ea = 30)
{
	n_base_damage = n_base_damage * var_177ec733;
	var_5d7b4163 = n_base_damage * var_b68e56de * math::clamp(level.round_number, var_694e2cee, var_f14e81ea);
	return int(var_5d7b4163);
}

/*
	Name: function_e418901e
	Namespace: zm_equipment
	Checksum: 0x6F6385F6
	Offset: 0x35E0
	Size: 0x1CE
	Parameters: 0
	Flags: None
*/
function function_e418901e()
{
	/#
		setdvar(#"hash_2554cdbcc1e45023", "");
		waitframe(1);
		level flag::wait_till("");
		waitframe(1);
		str_cmd = "" + "" + "";
		adddebugcommand(str_cmd);
		while(true)
		{
			equipment_id = getdvarstring(#"hash_2554cdbcc1e45023");
			if(equipment_id != "")
			{
				foreach(player in getplayers())
				{
					if(equipment_id == "")
					{
						player take();
						continue;
					}
					if(is_included(equipment_id))
					{
						player buy(equipment_id);
					}
				}
				setdvar(#"hash_2554cdbcc1e45023", "");
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_1d34b98d
	Namespace: zm_equipment
	Checksum: 0x58006EC8
	Offset: 0x37B8
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_1d34b98d(equipment)
{
	/#
		waitframe(1);
		level flag::wait_till("");
		waitframe(1);
		if(isdefined(equipment))
		{
			equipment_id = function_a16a090d(equipment);
			str_cmd = "" + equipment_id + "" + equipment_id + "";
			adddebugcommand(str_cmd);
		}
	#/
}

