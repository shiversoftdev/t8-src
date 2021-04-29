// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_placeable_mine;

/*
	Name: function_89f2df9
	Namespace: zm_placeable_mine
	Checksum: 0xB62C55BF
	Offset: 0x168
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"placeable_mine", undefined, &__main__, undefined);
}

/*
	Name: __main__
	Namespace: zm_placeable_mine
	Checksum: 0x4F3C053
	Offset: 0x1A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	if(isdefined(level.placeable_mines))
	{
		level thread replenish_after_rounds();
	}
}

/*
	Name: init_internal
	Namespace: zm_placeable_mine
	Checksum: 0xBA56334F
	Offset: 0x1E0
	Size: 0x7A
	Parameters: 0
	Flags: Linked, Private
*/
private function init_internal()
{
	if(isdefined(level.placeable_mines))
	{
		return;
	}
	level.placeable_mines = [];
	level.placeable_mines_on_damage = &placeable_mine_damage;
	level.pickup_placeable_mine = &pickup_placeable_mine;
	level.pickup_placeable_mine_trigger_listener = &pickup_placeable_mine_trigger_listener;
	level.placeable_mine_planted_callbacks = [];
}

/*
	Name: get_first_available
	Namespace: zm_placeable_mine
	Checksum: 0x19B0A78B
	Offset: 0x268
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function get_first_available()
{
	if(isdefined(namespace_2ba51478::function_5a5a742a("placeable_mine")) && namespace_2ba51478::function_5a5a742a("placeable_mine").size > 0)
	{
		str_key = getarraykeys(namespace_2ba51478::function_5a5a742a("placeable_mine"))[0];
		return namespace_2ba51478::function_5a5a742a("placeable_mine")[str_key];
	}
	return level.weaponnone;
}

/*
	Name: add_mine_type
	Namespace: zm_placeable_mine
	Checksum: 0xB8F6CACE
	Offset: 0x318
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function add_mine_type(mine_name, str_retrieval_prompt)
{
	init_internal();
	namespace_2ba51478::function_e884e095("placeable_mine", mine_name);
	level.placeable_mine_planted_callbacks[mine_name] = [];
}

/*
	Name: add_weapon_to_mine_slot
	Namespace: zm_placeable_mine
	Checksum: 0xE75643C1
	Offset: 0x378
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function add_weapon_to_mine_slot(mine_name)
{
	init_internal();
	level.placeable_mines[mine_name] = getweapon(mine_name);
	level.placeable_mine_planted_callbacks[mine_name] = [];
	if(!isdefined(level.placeable_mines_in_name_only))
	{
		level.placeable_mines_in_name_only = [];
	}
	level.placeable_mines_in_name_only[mine_name] = getweapon(mine_name);
}

/*
	Name: set_max_per_player
	Namespace: zm_placeable_mine
	Checksum: 0x3E55A63B
	Offset: 0x420
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_max_per_player(n_max_per_player)
{
	level.placeable_mines_max_per_player = n_max_per_player;
}

/*
	Name: add_planted_callback
	Namespace: zm_placeable_mine
	Checksum: 0xC0DA4AAC
	Offset: 0x448
	Size: 0xC0
	Parameters: 2
	Flags: None
*/
function add_planted_callback(fn_planted_cb, wpn_name)
{
	if(!isdefined(level.placeable_mine_planted_callbacks[wpn_name]))
	{
		level.placeable_mine_planted_callbacks[wpn_name] = [];
	}
	else if(!isarray(level.placeable_mine_planted_callbacks[wpn_name]))
	{
		level.placeable_mine_planted_callbacks[wpn_name] = array(level.placeable_mine_planted_callbacks[wpn_name]);
	}
	level.placeable_mine_planted_callbacks[wpn_name][level.placeable_mine_planted_callbacks[wpn_name].size] = fn_planted_cb;
}

/*
	Name: run_planted_callbacks
	Namespace: zm_placeable_mine
	Checksum: 0x271502CD
	Offset: 0x510
	Size: 0x8E
	Parameters: 1
	Flags: Linked, Private
*/
private function run_planted_callbacks(e_planter)
{
	foreach(fn in level.placeable_mine_planted_callbacks[self.weapon.name])
	{
		self thread [[fn]](e_planter);
	}
}

/*
	Name: safe_to_plant
	Namespace: zm_placeable_mine
	Checksum: 0x44DB5B08
	Offset: 0x5A8
	Size: 0x3E
	Parameters: 0
	Flags: Linked, Private
*/
private function safe_to_plant()
{
	if(isdefined(level.placeable_mines_max_per_player) && self.owner.placeable_mines.size >= level.placeable_mines_max_per_player)
	{
		return 0;
	}
	return 1;
}

/*
	Name: wait_and_detonate
	Namespace: zm_placeable_mine
	Checksum: 0x1C5FFC79
	Offset: 0x5F0
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function wait_and_detonate()
{
	wait(0.1);
	self detonate(self.owner);
}

/*
	Name: mine_watch
	Namespace: zm_placeable_mine
	Checksum: 0xCECB6554
	Offset: 0x628
	Size: 0x1A0
	Parameters: 1
	Flags: Linked, Private
*/
private function mine_watch(wpn_type)
{
	self endon(#"death");
	self notify(#"mine_watch");
	self endon(#"mine_watch");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		mine = waitresult.projectile;
		fired_weapon = waitresult.weapon;
		if(fired_weapon == wpn_type)
		{
			mine.owner = self;
			mine.team = self.team;
			mine.weapon = fired_weapon;
			self notify("zmb_enable_" + fired_weapon.name + "_prompt");
			if(mine safe_to_plant())
			{
				mine run_planted_callbacks(self);
				self zm_stats::increment_client_stat(fired_weapon.name + "_planted");
				self zm_stats::increment_player_stat(fired_weapon.name + "_planted");
			}
			else
			{
				mine thread wait_and_detonate();
			}
		}
	}
}

/*
	Name: is_true_placeable_mine
	Namespace: zm_placeable_mine
	Checksum: 0x2738E70D
	Offset: 0x7D0
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function is_true_placeable_mine(mine_name)
{
	if(!isdefined(level.placeable_mines_in_name_only))
	{
		return 1;
	}
	if(!isdefined(level.placeable_mines_in_name_only[mine_name]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: setup_for_player
	Namespace: zm_placeable_mine
	Checksum: 0x1BC25C54
	Offset: 0x818
	Size: 0x15A
	Parameters: 2
	Flags: Linked
*/
function setup_for_player(wpn_type, ui_model = "hudItems.showDpadRight")
{
	if(!isdefined(self.placeable_mines))
	{
		self.placeable_mines = [];
	}
	if(isdefined(self.last_placeable_mine_uimodel))
	{
		self clientfield::set_player_uimodel(self.last_placeable_mine_uimodel, 0);
	}
	if(is_true_placeable_mine(wpn_type.name))
	{
		self thread mine_watch(wpn_type);
	}
	self giveweapon(wpn_type);
	self namespace_2ba51478::set_player_placeable_mine(wpn_type);
	self setactionslot(4, "weapon", wpn_type);
	startammo = wpn_type.startammo;
	if(startammo)
	{
		self setweaponammostock(wpn_type, startammo);
	}
	if(isdefined(ui_model))
	{
		self clientfield::set_player_uimodel(ui_model, 1);
	}
	self.last_placeable_mine_uimodel = ui_model;
}

/*
	Name: disable_prompt_for_player
	Namespace: zm_placeable_mine
	Checksum: 0x23422F85
	Offset: 0x980
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function disable_prompt_for_player(wpn_type)
{
	self notify("zmb_disable_" + wpn_type.name + "_prompt");
}

/*
	Name: disable_all_prompts_for_player
	Namespace: zm_placeable_mine
	Checksum: 0x5DDBB7F4
	Offset: 0x9B8
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function disable_all_prompts_for_player()
{
	foreach(mine in namespace_2ba51478::function_5a5a742a("placeable_mine"))
	{
		self disable_prompt_for_player(mine);
	}
}

/*
	Name: pickup_placeable_mine
	Namespace: zm_placeable_mine
	Checksum: 0xD47A5526
	Offset: 0xA48
	Size: 0x27C
	Parameters: 0
	Flags: Linked, Private
*/
private function pickup_placeable_mine()
{
	player = self.owner;
	wpn_type = self.weapon;
	if(player zm_utility::is_drinking())
	{
		return;
	}
	current_player_mine = player namespace_2ba51478::get_player_placeable_mine();
	if(current_player_mine != wpn_type)
	{
		player takeweapon(current_player_mine);
	}
	if(!player hasweapon(wpn_type))
	{
		player thread mine_watch(wpn_type);
		player giveweapon(wpn_type);
		player namespace_2ba51478::set_player_placeable_mine(wpn_type);
		player setactionslot(4, "weapon", wpn_type);
		player setweaponammoclip(wpn_type, 0);
		player notify("zmb_enable_" + wpn_type.name + "_prompt");
	}
	else
	{
		clip_ammo = player getweaponammoclip(wpn_type);
		clip_max_ammo = wpn_type.clipsize;
		if(clip_ammo >= clip_max_ammo)
		{
			self delete();
			player disable_prompt_for_player(wpn_type);
			return;
		}
	}
	self zm_utility::pick_up();
	clip_ammo = player getweaponammoclip(wpn_type);
	clip_max_ammo = wpn_type.clipsize;
	if(clip_ammo >= clip_max_ammo)
	{
		player disable_prompt_for_player(wpn_type);
	}
	player zm_stats::increment_client_stat(wpn_type.name + "_pickedup");
	player zm_stats::increment_player_stat(wpn_type.name + "_pickedup");
}

/*
	Name: pickup_placeable_mine_trigger_listener
	Namespace: zm_placeable_mine
	Checksum: 0x56865EB2
	Offset: 0xCD0
	Size: 0x44
	Parameters: 2
	Flags: Linked, Private
*/
private function pickup_placeable_mine_trigger_listener(trigger, player)
{
	self thread pickup_placeable_mine_trigger_listener_enable(trigger, player);
	self thread pickup_placeable_mine_trigger_listener_disable(trigger, player);
}

/*
	Name: pickup_placeable_mine_trigger_listener_enable
	Namespace: zm_placeable_mine
	Checksum: 0x48B8ADAF
	Offset: 0xD20
	Size: 0xB8
	Parameters: 2
	Flags: Linked, Private
*/
private function pickup_placeable_mine_trigger_listener_enable(trigger, player)
{
	self endon(#"delete", #"death");
	while(true)
	{
		player waittill("zmb_enable_" + self.weapon.name + "_prompt", #"spawned_player");
		if(!isdefined(trigger))
		{
			return;
		}
		trigger triggerenable(1);
		trigger linkto(self);
	}
}

/*
	Name: pickup_placeable_mine_trigger_listener_disable
	Namespace: zm_placeable_mine
	Checksum: 0x1BD9D4AF
	Offset: 0xDE0
	Size: 0xA8
	Parameters: 2
	Flags: Linked, Private
*/
private function pickup_placeable_mine_trigger_listener_disable(trigger, player)
{
	self endon(#"delete", #"death");
	while(true)
	{
		player waittill("zmb_disable_" + self.weapon.name + "_prompt");
		if(!isdefined(trigger))
		{
			return;
		}
		trigger unlink();
		trigger triggerenable(0);
	}
}

/*
	Name: placeable_mine_damage
	Namespace: zm_placeable_mine
	Checksum: 0xF9C42BB4
	Offset: 0xE90
	Size: 0x1F4
	Parameters: 0
	Flags: Linked, Private
*/
private function placeable_mine_damage()
{
	self endon(#"death");
	self setcandamage(1);
	self.health = 100000;
	self.maxhealth = self.health;
	attacker = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(!isdefined(self))
		{
			return;
		}
		self.health = self.maxhealth;
		if(!isplayer(waitresult.attacker))
		{
			continue;
		}
		if(isdefined(self.owner) && attacker == self.owner)
		{
			continue;
		}
		if(isdefined(waitresult.attacker.pers) && isdefined(waitresult.attacker.pers[#"team"]) && waitresult.attacker.pers[#"team"] != level.zombie_team)
		{
			continue;
		}
		break;
	}
	if(level.satchelexplodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	level.satchelexplodethisframe = 1;
	thread reset_satchel_explode_this_frame();
	self detonate(waitresult.attacker);
}

/*
	Name: reset_satchel_explode_this_frame
	Namespace: zm_placeable_mine
	Checksum: 0x74E46135
	Offset: 0x1090
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
private function reset_satchel_explode_this_frame()
{
	waitframe(1);
	level.satchelexplodethisframe = 0;
}

/*
	Name: replenish_after_rounds
	Namespace: zm_placeable_mine
	Checksum: 0x15B7D092
	Offset: 0x10B0
	Size: 0x212
	Parameters: 0
	Flags: Linked, Private
*/
private function replenish_after_rounds()
{
	while(true)
	{
		level waittill(#"between_round_over");
		if(isdefined(level.func_custom_placeable_mine_round_replenish))
		{
			[[level.func_custom_placeable_mine_round_replenish]]();
			continue;
		}
		if(!level flag::exists("teleporter_used") || !level flag::get("teleporter_used"))
		{
			players = getplayers();
			for(i = 0; i < players.size; i++)
			{
				foreach(mine in namespace_2ba51478::function_5a5a742a("placeable_mine"))
				{
					if(players[i] namespace_2ba51478::is_player_placeable_mine(mine) && is_true_placeable_mine(mine.name))
					{
						players[i] giveweapon(mine);
						players[i] namespace_2ba51478::set_player_placeable_mine(mine);
						players[i] setactionslot(4, "weapon", mine);
						players[i] setweaponammoclip(mine, 2);
						break;
					}
				}
			}
		}
	}
}

/*
	Name: setup_watchers
	Namespace: zm_placeable_mine
	Checksum: 0x6CBFE8D5
	Offset: 0x12D0
	Size: 0xC0
	Parameters: 0
	Flags: None
*/
function setup_watchers()
{
	if(isdefined(namespace_2ba51478::function_5a5a742a("placeable_mine")))
	{
		foreach(mine_type in namespace_2ba51478::function_5a5a742a("placeable_mine"))
		{
			weaponobjects::function_e6400478(mine_type.name, &function_c7e3a5fd, 1);
		}
	}
}

/*
	Name: function_c7e3a5fd
	Namespace: zm_placeable_mine
	Checksum: 0xEC300F23
	Offset: 0x1398
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_c7e3a5fd(watcher)
{
	watcher.onspawnretrievetriggers = &on_spawn_retrieve_trigger;
	watcher.adjusttriggerorigin = &adjust_trigger_origin;
	watcher.pickup = level.pickup_placeable_mine;
	watcher.pickup_trigger_listener = level.pickup_placeable_mine_trigger_listener;
	watcher.skip_weapon_object_damage = 1;
	watcher.watchforfire = 1;
	watcher.ondetonatecallback = &placeable_mine_detonate;
	watcher.ondamage = level.placeable_mines_on_damage;
}

/*
	Name: on_spawn_retrieve_trigger
	Namespace: zm_placeable_mine
	Checksum: 0xF28BEC34
	Offset: 0x1458
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function on_spawn_retrieve_trigger(watcher, player)
{
	self weaponobjects::function_23b0aea9(watcher, player);
	if(isdefined(self.pickuptrigger))
	{
		self.pickuptrigger sethintlowpriority(0);
	}
}

/*
	Name: adjust_trigger_origin
	Namespace: zm_placeable_mine
	Checksum: 0xAF6DA5E4
	Offset: 0x14B8
	Size: 0x26
	Parameters: 1
	Flags: Linked, Private
*/
private function adjust_trigger_origin(origin)
{
	origin = origin + vectorscale((0, 0, 1), 20);
	return origin;
}

/*
	Name: placeable_mine_detonate
	Namespace: zm_placeable_mine
	Checksum: 0xE50B4F45
	Offset: 0x14E8
	Size: 0xBC
	Parameters: 3
	Flags: Linked, Private
*/
private function placeable_mine_detonate(attacker, weapon, target)
{
	if(weapon.isemp)
	{
		self delete();
		return;
	}
	if(isdefined(attacker))
	{
		self detonate(attacker);
	}
	else if(isdefined(self.owner) && isplayer(self.owner))
	{
		self detonate(self.owner);
	}
	else
	{
		self detonate();
	}
}

