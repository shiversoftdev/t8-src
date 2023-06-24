// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weapons.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace pickup_items;

/*
	Name: __init__system__
	Namespace: pickup_items
	Checksum: 0x45FD14FB
	Offset: 0x180
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"pickup_items", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: pickup_items
	Checksum: 0x95966BE0
	Offset: 0x1C8
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_start_gametype(&start_gametype);
	level.nullprimaryoffhand = getweapon(#"null_offhand_primary");
	level.nullsecondaryoffhand = getweapon(#"null_offhand_secondary");
	level.pickup_items = [];
	level.pickupitemrespawn = 1;
}

/*
	Name: on_player_spawned
	Namespace: pickup_items
	Checksum: 0xB474D8BF
	Offset: 0x268
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self.pickup_damage_scale = undefined;
	self.pickup_damage_scale_time = undefined;
}

/*
	Name: start_gametype
	Namespace: pickup_items
	Checksum: 0xC53556C8
	Offset: 0x288
	Size: 0x1EE
	Parameters: 0
	Flags: None
*/
function start_gametype()
{
	callback::on_spawned(&on_player_spawned);
	pickup_triggers = getentarray("pickup_item", "targetname");
	pickup_models = getentarray("pickup_model", "targetname");
	visuals = [];
	foreach(trigger in pickup_triggers)
	{
		visuals[0] = get_visual_for_trigger(trigger, pickup_models);
		/#
			assert(isdefined(visuals[0]));
		#/
		visuals[0] pickup_item_init();
		pickup_item_object = gameobjects::create_use_object(#"neutral", trigger, visuals, vectorscale((0, 0, 1), 32), #"pickup_item");
		pickup_item_object gameobjects::allow_use(#"any");
		pickup_item_object gameobjects::set_use_time(0);
		pickup_item_object.onuse = &on_touch;
		level.pickup_items[level.pickup_items.size] = pickup_item_object;
	}
}

/*
	Name: get_visual_for_trigger
	Namespace: pickup_items
	Checksum: 0xEFA8C0A8
	Offset: 0x480
	Size: 0x92
	Parameters: 2
	Flags: None
*/
function get_visual_for_trigger(trigger, pickup_models)
{
	foreach(model in pickup_models)
	{
		if(model istouchingswept(trigger))
		{
			return model;
		}
	}
	return undefined;
}

/*
	Name: set_pickup_bobbing
	Namespace: pickup_items
	Checksum: 0x115CAE38
	Offset: 0x520
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function set_pickup_bobbing()
{
	self bobbing((0, 0, 1), 4, 1);
}

/*
	Name: set_pickup_rotation
	Namespace: pickup_items
	Checksum: 0x8DA1BF9F
	Offset: 0x550
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function set_pickup_rotation()
{
	self rotate(vectorscale((0, 1, 0), 175));
}

/*
	Name: get_item_for_pickup
	Namespace: pickup_items
	Checksum: 0xAA34CBE4
	Offset: 0x580
	Size: 0x82
	Parameters: 0
	Flags: None
*/
function get_item_for_pickup()
{
	if(self.items.size == 1)
	{
		return self.items[0];
	}
	if(self.items_shuffle.size == 0)
	{
		self.items_shuffle = arraycopy(self.items);
		array::randomize(self.items_shuffle);
	}
	return array::pop_front(self.items_shuffle);
}

/*
	Name: cycle_item
	Namespace: pickup_items
	Checksum: 0xDAE5CA1B
	Offset: 0x610
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function cycle_item()
{
	self.current_item = self get_item_for_pickup();
	if(isdefined(self.current_item.model))
	{
		self setmodel(self.current_item.model);
	}
}

/*
	Name: get_item_from_string_ammo
	Namespace: pickup_items
	Checksum: 0x5A59380B
	Offset: 0x678
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function get_item_from_string_ammo(perks_string)
{
	item_struct = spawnstruct();
	item_struct.name = "ammo";
	item_struct.weapon = getweapon(#"scavenger_item");
	item_struct.model = item_struct.weapon.worldmodel;
	self.angles = vectorscale((0, 0, 1), 90);
	self thread weapons::scavenger_think();
	return item_struct;
}

/*
	Name: get_item_from_string_damage
	Namespace: pickup_items
	Checksum: 0xAB7AE4D5
	Offset: 0x738
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function get_item_from_string_damage(perks_string)
{
	item_struct = spawnstruct();
	item_struct.name = "damage";
	item_struct.damage_scale = float(perks_string);
	item_struct.model = "wpn_t7_igc_bullet_prop";
	self.angles = vectorscale((-1, 0, 0), 45);
	self setscale(2);
	return item_struct;
}

/*
	Name: get_item_from_string_health
	Namespace: pickup_items
	Checksum: 0xF811AED9
	Offset: 0x7E0
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function get_item_from_string_health(perks_string)
{
	item_struct = spawnstruct();
	item_struct.name = "health";
	item_struct.extra_health = int(perks_string);
	item_struct.model = "p7_medical_surgical_tools_syringe";
	self.angles = vectorscale((-1, 0, 1), 45);
	self setscale(5);
	return item_struct;
}

/*
	Name: get_item_from_string_perk
	Namespace: pickup_items
	Checksum: 0xBA2D033
	Offset: 0x888
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function get_item_from_string_perk(perks_string)
{
	item_struct = spawnstruct();
	if(!isdefined(level.perkspecialties[perks_string]))
	{
		/#
			util::error((("" + perks_string) + "") + self.origin);
		#/
		return;
	}
	item_struct.name = perks_string;
	item_struct.specialties = strtok(level.perkspecialties[perks_string], "|");
	item_struct.model = "p7_perk_" + level.perkicons[perks_string];
	self setscale(2);
	return item_struct;
}

/*
	Name: get_item_from_string_weapon
	Namespace: pickup_items
	Checksum: 0x87C98885
	Offset: 0x980
	Size: 0x110
	Parameters: 1
	Flags: None
*/
function get_item_from_string_weapon(weapon_and_attachments_string)
{
	item_struct = spawnstruct();
	weapon_and_attachments = strtok(weapon_and_attachments_string, "+");
	weapon_name = getsubstr(weapon_and_attachments[0], 0, weapon_and_attachments[0].size);
	attachments = array::remove_index(weapon_and_attachments, 0);
	item_struct.name = weapon_name;
	item_struct.weapon = getweapon(weapon_name, attachments);
	item_struct.model = item_struct.weapon.worldmodel;
	self setscale(1.5);
	return item_struct;
}

/*
	Name: get_item_from_string
	Namespace: pickup_items
	Checksum: 0x4D3A4894
	Offset: 0xA98
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function get_item_from_string(item_string)
{
	switch(self.script_noteworthy)
	{
		case "ammo":
		{
			return self get_item_from_string_ammo(item_string);
		}
		case "damage":
		{
			return self get_item_from_string_damage(item_string);
		}
		case "health":
		{
			return self get_item_from_string_health(item_string);
		}
		case "perk":
		{
			return self get_item_from_string_perk(item_string);
		}
		case "weapon":
		{
			return self get_item_from_string_weapon(item_string);
		}
	}
}

/*
	Name: init_items_for_pickup
	Namespace: pickup_items
	Checksum: 0x4AB0DBC2
	Offset: 0xB90
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function init_items_for_pickup()
{
	items_string = self.script_parameters;
	items_array = strtok(items_string, " ");
	items = [];
	foreach(item_string in items_array)
	{
		items[items.size] = self get_item_from_string(item_string);
	}
	return items;
}

/*
	Name: pickup_item_respawn_time
	Namespace: pickup_items
	Checksum: 0x65F03293
	Offset: 0xC68
	Size: 0x8A
	Parameters: 0
	Flags: None
*/
function pickup_item_respawn_time()
{
	switch(self.script_noteworthy)
	{
		case "ammo":
		{
			return 10;
		}
		case "damage":
		{
			return 60;
		}
		case "health":
		{
			return 10;
		}
		case "perk":
		{
			return 10;
		}
		case "weapon":
		{
			return 30;
		}
	}
}

/*
	Name: pickup_item_sound_pickup
	Namespace: pickup_items
	Checksum: 0x5C18FCFD
	Offset: 0xD00
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function pickup_item_sound_pickup()
{
	switch(self.script_noteworthy)
	{
		case "ammo":
		{
			return "wpn_ammo_pickup_oldschool";
		}
		case "damage":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "health":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "perk":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "weapon":
		{
			return "wpn_weap_pickup_oldschool";
		}
	}
}

/*
	Name: pickup_item_sound_respawn
	Namespace: pickup_items
	Checksum: 0x4AAEDBB9
	Offset: 0xDA0
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function pickup_item_sound_respawn()
{
	switch(self.script_noteworthy)
	{
		case "ammo":
		{
			return "wpn_ammo_pickup_oldschool";
		}
		case "damage":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "health":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "perk":
		{
			return "wpn_weap_pickup_oldschool";
		}
		case "weapon":
		{
			return "wpn_weap_pickup_oldschool";
		}
	}
}

/*
	Name: pickup_item_init
	Namespace: pickup_items
	Checksum: 0x295B504E
	Offset: 0xE40
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function pickup_item_init()
{
	self.items_shuffle = [];
	self set_pickup_bobbing();
	self.items = self init_items_for_pickup();
	self.respawn_time = self pickup_item_respawn_time();
	self.sound_pickup = self pickup_item_sound_pickup();
	self.sound_respawn = self pickup_item_sound_respawn();
	self set_pickup_rotation();
	self cycle_item();
}

/*
	Name: on_touch
	Namespace: pickup_items
	Checksum: 0x9D55C81F
	Offset: 0xF00
	Size: 0x1CC
	Parameters: 1
	Flags: None
*/
function on_touch(player)
{
	self endon(#"respawned");
	pickup_item = self.visuals[0];
	switch(pickup_item.script_noteworthy)
	{
		case "ammo":
		{
			pickup_item on_touch_ammo(player);
			break;
		}
		case "damage":
		{
			pickup_item on_touch_damage(player);
			break;
		}
		case "health":
		{
			pickup_item on_touch_health(player);
			break;
		}
		case "perk":
		{
			pickup_item on_touch_perk(player);
			break;
		}
		case "weapon":
		{
			if(!pickup_item on_touch_weapon(player))
			{
				return;
			}
			break;
		}
	}
	pickup_item playsound(pickup_item.sound_pickup);
	self gameobjects::set_model_visibility(0);
	self gameobjects::allow_use(#"none");
	if(level.pickupitemrespawn)
	{
		wait(pickup_item.respawn_time);
		self thread respawn_pickup();
	}
}

/*
	Name: respawn_pickup
	Namespace: pickup_items
	Checksum: 0x3B719CA1
	Offset: 0x10D8
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function respawn_pickup()
{
	self notify(#"respawned");
	pickup_item = self.visuals[0];
	pickup_item playsound(pickup_item.sound_respawn);
	pickup_item cycle_item();
	self gameobjects::set_model_visibility(1);
	self gameobjects::allow_use(#"any");
}

/*
	Name: respawn_all_pickups
	Namespace: pickup_items
	Checksum: 0x83B83122
	Offset: 0x1180
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function respawn_all_pickups()
{
	foreach(item in level.pickup_items)
	{
		item respawn_pickup();
	}
}

/*
	Name: on_touch_ammo
	Namespace: pickup_items
	Checksum: 0x458ED3BC
	Offset: 0x1208
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function on_touch_ammo(player)
{
	self notify(#"scavenger", {#player:player});
	player pickupammoevent();
}

/*
	Name: on_touch_damage
	Namespace: pickup_items
	Checksum: 0x40BB3401
	Offset: 0x1260
	Size: 0x66
	Parameters: 1
	Flags: None
*/
function on_touch_damage(player)
{
	damage_scale_length = int(15 * 1000);
	player.pickup_damage_scale = self.current_item.damage_scale;
	player.pickup_damage_scale_time = gettime() + damage_scale_length;
}

/*
	Name: on_touch_health
	Namespace: pickup_items
	Checksum: 0x5C4CCA63
	Offset: 0x12D0
	Size: 0x86
	Parameters: 1
	Flags: None
*/
function on_touch_health(player)
{
	if(self.current_item.extra_health <= 100)
	{
		health = player.health + self.current_item.extra_health;
		if(health > 100)
		{
			health = 100;
		}
	}
	else
	{
		health = self.current_item.extra_health;
	}
	player.health = health;
}

/*
	Name: on_touch_perk
	Namespace: pickup_items
	Checksum: 0x3380FC10
	Offset: 0x1360
	Size: 0x90
	Parameters: 1
	Flags: None
*/
function on_touch_perk(player)
{
	foreach(specialty in self.current_item.specialties)
	{
		player setperk(specialty);
	}
}

/*
	Name: has_active_gadget
	Namespace: pickup_items
	Checksum: 0xD7E6565E
	Offset: 0x13F8
	Size: 0x10A
	Parameters: 0
	Flags: None
*/
function has_active_gadget()
{
	weapons = self getweaponslist(1);
	foreach(weapon in weapons)
	{
		if(!weapon.isgadget)
		{
			continue;
		}
		if(!weapon.isheavyweapon && weapon.offhandslot !== "Gadget")
		{
			continue;
		}
		slot = self gadgetgetslot(weapon);
		if(self gadgetisactive(slot))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: take_player_gadgets
	Namespace: pickup_items
	Checksum: 0xA458A6BA
	Offset: 0x1510
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function take_player_gadgets()
{
	weapons = self getweaponslist(1);
	foreach(weapon in weapons)
	{
		if(weapon.isgadget)
		{
			self takeweapon(weapon);
		}
	}
}

/*
	Name: take_offhand_weapon
	Namespace: pickup_items
	Checksum: 0xFB7F1249
	Offset: 0x15C0
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function take_offhand_weapon(offhandslot)
{
	weapons = self getweaponslist(1);
	foreach(weapon in weapons)
	{
		if(weapon.offhandslot == offhandslot)
		{
			self takeweapon(weapon);
			return;
		}
	}
}

/*
	Name: should_switch_to_pickup_weapon
	Namespace: pickup_items
	Checksum: 0x73DFA8B1
	Offset: 0x1688
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function should_switch_to_pickup_weapon(weapon)
{
	if(weapon.isgadget)
	{
		return false;
	}
	if(weapon.isgrenadeweapon)
	{
		return false;
	}
	return true;
}

/*
	Name: on_touch_weapon
	Namespace: pickup_items
	Checksum: 0xC42CB006
	Offset: 0x16C8
	Size: 0x270
	Parameters: 1
	Flags: None
*/
function on_touch_weapon(player)
{
	weapon = self.current_item.weapon;
	had_weapon = player hasweapon(weapon);
	ammo_in_reserve = player getweaponammostock(weapon);
	if(weapon.isgadget)
	{
		if(player has_active_gadget())
		{
			return false;
		}
		player take_player_gadgets();
	}
	if(weapon.inventorytype == "offhand")
	{
		player take_offhand_weapon(weapon.offhandslot);
	}
	player pickupweaponevent(weapon);
	player giveweapon(weapon);
	if(!player hasweapon(weapon))
	{
		return false;
	}
	if(isdefined(self.script_ammo_clip) && isdefined(self.script_ammo_extra))
	{
		if(had_weapon)
		{
			player setweaponammostock(weapon, (ammo_in_reserve + self.script_ammo_clip) + self.script_ammo_extra);
		}
		else
		{
			if(self.script_ammo_clip >= 0)
			{
				player setweaponammoclip(weapon, self.script_ammo_clip);
			}
			if(self.script_ammo_extra >= 0)
			{
				player setweaponammostock(weapon, self.script_ammo_extra);
			}
		}
	}
	if(weapon.isgadget)
	{
		slot = player gadgetgetslot(weapon);
		player gadgetpowerset(slot, 100);
	}
	if(!had_weapon && should_switch_to_pickup_weapon(weapon))
	{
		player switchtoweapon(weapon);
	}
	return true;
}

