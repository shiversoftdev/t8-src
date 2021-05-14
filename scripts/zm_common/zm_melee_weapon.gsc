// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1254ac024174d9c0;
#using script_14f4a3c583c77d4b;
#using script_7133a4d461308099;
#using script_ab890501c40b73c;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_melee_weapon;

/*
	Name: function_89f2df9
	Namespace: zm_melee_weapon
	Checksum: 0x25562EEC
	Offset: 0x158
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"melee_weapon", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_melee_weapon
	Checksum: 0x2ADCA86B
	Offset: 0x1A8
	Size: 0x22
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!isdefined(level._melee_weapons))
	{
		level._melee_weapons = [];
	}
}

/*
	Name: __main__
	Namespace: zm_melee_weapon
	Checksum: 0x80F724D1
	Offset: 0x1D8
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
}

/*
	Name: init
	Namespace: zm_melee_weapon
	Checksum: 0xB71DB945
	Offset: 0x1E8
	Size: 0x340
	Parameters: 9
	Flags: Linked
*/
function init(weapon_name, flourish_weapon_name, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn, is_ee = 0, in_box = 0)
{
	weapon = getweapon(weapon_name);
	flourish_weapon = getweapon(flourish_weapon_name);
	add_melee_weapon(weapon, flourish_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
	melee_weapon_triggers = getentarray(wallbuy_targetname, "targetname");
	for(i = 0; i < melee_weapon_triggers.size; i++)
	{
		knife_model = getent(melee_weapon_triggers[i].target, "targetname");
		if(isdefined(knife_model))
		{
			knife_model hide();
		}
		melee_weapon_triggers[i] thread melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon);
		melee_weapon_triggers[i] sethintstring(hint_string, cost);
		cursor_hint = "HINT_WEAPON";
		cursor_hint_weapon = weapon;
		melee_weapon_triggers[i] setcursorhint(cursor_hint, cursor_hint_weapon);
		melee_weapon_triggers[i] usetriggerrequirelookat();
	}
	melee_weapon_structs = struct::get_array(wallbuy_targetname, "targetname");
	for(i = 0; i < melee_weapon_structs.size; i++)
	{
		prepare_stub(melee_weapon_structs[i].trigger_stub, weapon, flourish_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
	}
	zm_loadout::register_melee_weapon_for_level(weapon.name);
	/#
		if(!isdefined(level.zombie_weapons[weapon]) && (!is_ee || getdvarint(#"hash_11ad6a9695943217", 0)))
		{
			if(isdefined(level.devgui_add_weapon))
			{
				level thread [[level.devgui_add_weapon]](weapon, undefined, in_box, cost);
			}
		}
	#/
}

/*
	Name: prepare_stub
	Namespace: zm_melee_weapon
	Checksum: 0xFA2B8C58
	Offset: 0x530
	Size: 0xFE
	Parameters: 8
	Flags: Linked
*/
function prepare_stub(stub, weapon, flourish_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn)
{
	if(isdefined(stub))
	{
		stub.hint_string = hint_string;
		stub.cursor_hint = "HINT_WEAPON";
		stub.cursor_hint_weapon = weapon;
		stub.cost = cost;
		stub.weapon = weapon;
		stub.vo_dialog_id = vo_dialog_id;
		stub.flourish_weapon = flourish_weapon;
		stub.trigger_func = &melee_weapon_think;
		stub.prompt_and_visibility_func = &function_e5bf8f08;
		stub.flourish_fn = flourish_fn;
	}
}

/*
	Name: find_melee_weapon
	Namespace: zm_melee_weapon
	Checksum: 0x56CF4CC6
	Offset: 0x638
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function find_melee_weapon(weapon)
{
	melee_weapon = undefined;
	for(i = 0; i < level._melee_weapons.size; i++)
	{
		if(level._melee_weapons[i].weapon == weapon)
		{
			return level._melee_weapons[i];
		}
	}
	return undefined;
}

/*
	Name: add_stub
	Namespace: zm_melee_weapon
	Checksum: 0x8AE4D30D
	Offset: 0x6C0
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function add_stub(stub, weapon)
{
	melee_weapon = find_melee_weapon(weapon);
	if(isdefined(stub) && isdefined(melee_weapon))
	{
		prepare_stub(stub, melee_weapon.weapon, melee_weapon.flourish_weapon, melee_weapon.cost, melee_weapon.wallbuy_targetname, melee_weapon.hint_string, melee_weapon.vo_dialog_id, melee_weapon.flourish_fn);
	}
}

/*
	Name: add_melee_weapon
	Namespace: zm_melee_weapon
	Checksum: 0xD0A5F65
	Offset: 0x778
	Size: 0xFE
	Parameters: 7
	Flags: Linked
*/
function add_melee_weapon(weapon, flourish_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn)
{
	melee_weapon = spawnstruct();
	melee_weapon.weapon = weapon;
	melee_weapon.flourish_weapon = flourish_weapon;
	melee_weapon.cost = cost;
	melee_weapon.wallbuy_targetname = wallbuy_targetname;
	melee_weapon.hint_string = hint_string;
	melee_weapon.vo_dialog_id = vo_dialog_id;
	melee_weapon.flourish_fn = flourish_fn;
	if(!isdefined(level._melee_weapons))
	{
		level._melee_weapons = [];
	}
	level._melee_weapons[level._melee_weapons.size] = melee_weapon;
}

/*
	Name: set_fallback_weapon
	Namespace: zm_melee_weapon
	Checksum: 0xB5F8B666
	Offset: 0x880
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function set_fallback_weapon(weapon_name, fallback_weapon_name)
{
	melee_weapon = find_melee_weapon(getweapon(weapon_name));
	if(isdefined(melee_weapon))
	{
		melee_weapon.fallback_weapon = getweapon(fallback_weapon_name);
	}
}

/*
	Name: determine_fallback_weapon
	Namespace: zm_melee_weapon
	Checksum: 0xC2C7ADAC
	Offset: 0x8F8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function determine_fallback_weapon()
{
	fallback_weapon = level.weaponzmfists;
	if(isdefined(self zm_loadout::get_player_melee_weapon()) && self hasweapon(self zm_loadout::get_player_melee_weapon()))
	{
		melee_weapon = find_melee_weapon(self zm_loadout::get_player_melee_weapon());
		if(isdefined(melee_weapon) && isdefined(melee_weapon.fallback_weapon))
		{
			return melee_weapon.fallback_weapon;
		}
	}
	return fallback_weapon;
}

/*
	Name: give_fallback_weapon
	Namespace: zm_melee_weapon
	Checksum: 0x3D5A4223
	Offset: 0x9B8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function give_fallback_weapon(immediate = 0)
{
	fallback_weapon = self determine_fallback_weapon();
	had_weapon = self hasweapon(fallback_weapon);
	self giveweapon(fallback_weapon);
	if(immediate && had_weapon)
	{
		self switchtoweaponimmediate(fallback_weapon);
	}
	else
	{
		self switchtoweapon(fallback_weapon);
	}
}

/*
	Name: take_fallback_weapon
	Namespace: zm_melee_weapon
	Checksum: 0x77ECD4F2
	Offset: 0xA70
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function take_fallback_weapon()
{
	fallback_weapon = self determine_fallback_weapon();
	had_weapon = self hasweapon(fallback_weapon);
	self zm_weapons::weapon_take(fallback_weapon);
	return had_weapon;
}

/*
	Name: player_can_see_weapon_prompt
	Namespace: zm_melee_weapon
	Checksum: 0x7D79299B
	Offset: 0xAD8
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function player_can_see_weapon_prompt()
{
	if(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)
	{
		return 1;
	}
	if(isdefined(self zm_loadout::get_player_melee_weapon()) && self hasweapon(self zm_loadout::get_player_melee_weapon()))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e5bf8f08
	Namespace: zm_melee_weapon
	Checksum: 0x69E2CF88
	Offset: 0xB50
	Size: 0x360
	Parameters: 1
	Flags: Linked
*/
function function_e5bf8f08(player)
{
	weapon = self.stub.weapon;
	player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
	if(isdefined(level.func_override_wallbuy_prompt))
	{
		if(!self [[level.func_override_wallbuy_prompt]](player, player_has_weapon))
		{
			return 0;
		}
	}
	else if(namespace_497ab7da::is_active())
	{
		return 0;
	}
	if(!player_has_weapon && !player zm_utility::is_drinking())
	{
		self.stub.cursor_hint = "HINT_WEAPON";
		cost = zm_weapons::get_weapon_cost(weapon);
		if(player bgb::is_enabled(#"hash_4a6b297c85fafec1"))
		{
			if(function_8b1a219a())
			{
				self.stub.hint_string = #"hash_7a24a147b8f09767";
			}
			else
			{
				self.stub.hint_string = #"hash_791fe9da17cf7059";
			}
			if(self.stub.var_8d306e51)
			{
				self sethintstringforplayer(player, self.stub.hint_string);
			}
			else
			{
				self sethintstring(self.stub.hint_string);
			}
		}
		else if(function_8b1a219a())
		{
			self.stub.hint_string = #"hash_2791ecebb85142c4";
		}
		else
		{
			self.stub.hint_string = #"hash_60606b68e93a29c8";
		}
		if(self.stub.var_8d306e51)
		{
			self sethintstringforplayer(player, self.stub.hint_string);
		}
		else
		{
			self sethintstring(self.stub.hint_string);
		}
	}
	else
	{
		self.stub.hint_string = "";
		if(self.stub.var_8d306e51)
		{
			self sethintstringforplayer(player, self.stub.hint_string);
		}
		else
		{
			self sethintstring(self.stub.hint_string);
		}
		return 0;
	}
	self.stub.cursor_hint = "HINT_WEAPON";
	self.stub.cursor_hint_weapon = weapon;
	self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
	return 1;
}

/*
	Name: spectator_respawn_all
	Namespace: zm_melee_weapon
	Checksum: 0x2CCF3F9B
	Offset: 0xEB8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function spectator_respawn_all()
{
	for(i = 0; i < level._melee_weapons.size; i++)
	{
		self spectator_respawn(level._melee_weapons[i].wallbuy_targetname, level._melee_weapons[i].weapon);
	}
}

/*
	Name: spectator_respawn
	Namespace: zm_melee_weapon
	Checksum: 0x700E8BD3
	Offset: 0xF30
	Size: 0x128
	Parameters: 2
	Flags: Linked
*/
function spectator_respawn(wallbuy_targetname, weapon)
{
	melee_triggers = getentarray(wallbuy_targetname, "targetname");
	players = getplayers();
	for(i = 0; i < melee_triggers.size; i++)
	{
		melee_triggers[i] setvisibletoall();
		if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching))
		{
			for(j = 0; j < players.size; j++)
			{
				if(!players[j] player_can_see_weapon_prompt())
				{
					melee_triggers[i] setinvisibletoplayer(players[j]);
				}
			}
		}
	}
}

/*
	Name: trigger_hide_all
	Namespace: zm_melee_weapon
	Checksum: 0x9C1B9A10
	Offset: 0x1060
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function trigger_hide_all()
{
	for(i = 0; i < level._melee_weapons.size; i++)
	{
		self trigger_hide(level._melee_weapons[i].wallbuy_targetname);
	}
}

/*
	Name: trigger_hide
	Namespace: zm_melee_weapon
	Checksum: 0xF255D66
	Offset: 0x10C0
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function trigger_hide(wallbuy_targetname)
{
	melee_triggers = getentarray(wallbuy_targetname, "targetname");
	for(i = 0; i < melee_triggers.size; i++)
	{
		melee_triggers[i] setinvisibletoplayer(self);
	}
}

/*
	Name: change_melee_weapon
	Namespace: zm_melee_weapon
	Checksum: 0x144C1FED
	Offset: 0x1148
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function change_melee_weapon(weapon, current_weapon)
{
	current_melee_weapon = self zm_loadout::get_player_melee_weapon();
	self zm_loadout::set_player_melee_weapon(weapon);
	if(current_melee_weapon != level.weaponnone && current_melee_weapon != weapon && self hasweapon(current_melee_weapon))
	{
		self takeweapon(current_melee_weapon);
	}
	return current_weapon;
}

/*
	Name: melee_weapon_think
	Namespace: zm_melee_weapon
	Checksum: 0x28942087
	Offset: 0x11F0
	Size: 0x828
	Parameters: 5
	Flags: Linked
*/
function melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon)
{
	self.first_time_triggered = 0;
	if(isdefined(self.stub))
	{
		self endon(#"kill_trigger");
		if(isdefined(self.stub.first_time_triggered))
		{
			self.first_time_triggered = self.stub.first_time_triggered;
		}
		weapon = self.stub.weapon;
		cost = self.stub.cost;
		flourish_fn = self.stub.flourish_fn;
		vo_dialog_id = self.stub.vo_dialog_id;
		flourish_weapon = self.stub.flourish_weapon;
		players = getplayers();
		if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching))
		{
			for(i = 0; i < players.size; i++)
			{
				if(!players[i] player_can_see_weapon_prompt())
				{
					self setinvisibletoplayer(players[i]);
				}
			}
		}
	}
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::is_player_valid(player))
		{
			player thread zm_utility::ignore_triggers(0.5);
			continue;
		}
		if(player zm_utility::in_revive_trigger())
		{
			wait(0.1);
			continue;
		}
		if(player isthrowinggrenade())
		{
			wait(0.1);
			continue;
		}
		if(player zm_utility::is_drinking())
		{
			wait(0.1);
			continue;
		}
		if(namespace_497ab7da::is_active())
		{
			wait(0.1);
			continue;
		}
		player_has_weapon = player hasweapon(weapon);
		if(player_has_weapon || player zm_loadout::has_powerup_weapon())
		{
			wait(0.1);
			continue;
		}
		if(player isswitchingweapons())
		{
			wait(0.1);
			continue;
		}
		current_weapon = player getcurrentweapon();
		if(zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon))
		{
			wait(0.1);
			continue;
		}
		if(player laststand::player_is_in_laststand() || (isdefined(player.intermission) && player.intermission))
		{
			wait(0.1);
			continue;
		}
		if(isdefined(player.check_override_melee_wallbuy_purchase))
		{
			if(player [[player.check_override_melee_wallbuy_purchase]](vo_dialog_id, flourish_weapon, weapon, flourish_fn, self))
			{
				continue;
			}
		}
		if(!player_has_weapon)
		{
			cost = self.stub.cost;
			if(isdefined(player.var_dc25727a))
			{
				foreach(func_override in player.var_dc25727a)
				{
					n_cost = player [[func_override]](weapon, self);
					if(isdefined(n_cost))
					{
						if(n_cost < cost)
						{
							cost = n_cost;
						}
					}
				}
			}
			if(player zm_score::can_player_purchase(cost))
			{
				if(self.first_time_triggered == 0)
				{
					model = getent(self.target, "targetname");
					if(isdefined(model))
					{
						model thread melee_weapon_show(player);
					}
					else if(isdefined(self.clientfieldname))
					{
						level clientfield::set(self.clientfieldname, 1);
					}
					if(zm_utility::function_166646a6() != 1 && !isdefined(model))
					{
						var_6ff4b667 = struct::get(self.target, "targetname");
						if(isdefined(var_6ff4b667) && isdefined(var_6ff4b667.target))
						{
							var_8d0ce13b = getent(var_6ff4b667.target, "targetname");
							var_8d0ce13b clientfield::set("wallbuy_reveal_fx", 1);
							var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 0);
						}
					}
					self.first_time_triggered = 1;
					if(isdefined(self.stub))
					{
						self.stub.first_time_triggered = 1;
					}
				}
				level notify(#"weapon_bought", {#weapon:weapon, #player:player});
				player zm_score::minus_to_player_score(cost);
				player zm_stats::function_c0c6ab19(#"wallbuys", 1, 1);
				player zm_stats::function_c0c6ab19(#"hash_6f9f408a95b50400", 1, 1);
				player contracts::function_5b88297d(#"hash_4a8bbc38f59c2743", 1, #"zstandard");
				player contracts::function_5b88297d(#"hash_56a15f4e4fa5f4b7", 1, #"zstandard");
				player thread give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, flourish_fn, self);
			}
			else
			{
				zm_utility::play_sound_on_ent("no_purchase");
				player zm_audio::create_and_play_dialog(#"general", #"outofmoney", 1);
			}
			continue;
		}
		if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching))
		{
			self setinvisibletoplayer(player);
		}
	}
}

/*
	Name: melee_weapon_show
	Namespace: zm_melee_weapon
	Checksum: 0x79F5330F
	Offset: 0x1A20
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function melee_weapon_show(player)
{
	player_angles = vectortoangles(player.origin - self.origin);
	player_yaw = player_angles[1];
	weapon_yaw = self.angles[1];
	yaw_diff = angleclamp180(player_yaw - weapon_yaw);
	if(yaw_diff > 0)
	{
		yaw = weapon_yaw - 90;
	}
	else
	{
		yaw = weapon_yaw + 90;
	}
	self.og_origin = self.origin;
	self.origin = self.origin + anglestoforward((0, yaw, 0)) * 8;
	waitframe(1);
	self show();
	zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
	time = 1;
	self moveto(self.og_origin, time);
}

/*
	Name: award_melee_weapon
	Namespace: zm_melee_weapon
	Checksum: 0x8A75439
	Offset: 0x1B98
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function award_melee_weapon(weapon_name)
{
	weapon = getweapon(weapon_name);
	melee_weapon = find_melee_weapon(weapon);
	if(isdefined(melee_weapon))
	{
		self give_melee_weapon(melee_weapon.vo_dialog_id, melee_weapon.flourish_weapon, melee_weapon.weapon, melee_weapon.flourish_fn, undefined);
	}
}

/*
	Name: give_melee_weapon
	Namespace: zm_melee_weapon
	Checksum: 0xD4988879
	Offset: 0x1C40
	Size: 0x1C4
	Parameters: 5
	Flags: Linked
*/
function give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, flourish_fn, trigger)
{
	self activecamo::function_8d3b94ea(weapon, 1, 0);
	if(isdefined(flourish_fn))
	{
		self thread [[flourish_fn]]();
	}
	original_weapon = self do_melee_weapon_flourish_begin(flourish_weapon);
	if(isdefined(vo_dialog_id))
	{
		self zm_audio::create_and_play_dialog(#"weapon_pickup", vo_dialog_id);
	}
	self endon(#"disconnect");
	self waittill(#"fake_death", #"death", #"player_downed", #"weapon_change_complete");
	if(!isdefined(self))
	{
		return;
	}
	self do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon);
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission))
	{
		return;
	}
	if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching))
	{
		if(isdefined(trigger))
		{
			trigger setinvisibletoplayer(self);
		}
		self trigger_hide_all();
	}
}

/*
	Name: do_melee_weapon_flourish_begin
	Namespace: zm_melee_weapon
	Checksum: 0x41688DE8
	Offset: 0x1E10
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function do_melee_weapon_flourish_begin(flourish_weapon)
{
	self zm_utility::increment_is_drinking();
	self zm_utility::disable_player_move_states(1);
	original_weapon = self getcurrentweapon();
	weapon = self zm_weapons::give_build_kit_weapon(flourish_weapon);
	self switchtoweapon(weapon);
	return original_weapon;
}

/*
	Name: do_melee_weapon_flourish_end
	Namespace: zm_melee_weapon
	Checksum: 0xF565640C
	Offset: 0x1EB0
	Size: 0x2BC
	Parameters: 3
	Flags: Linked
*/
function do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon)
{
	/#
		assert(!original_weapon.isperkbottle);
	#/
	/#
		assert(original_weapon != level.weaponrevivetool);
	#/
	if(!isdefined(self))
	{
		return;
	}
	self zm_utility::enable_player_move_states();
	self takeweapon(flourish_weapon);
	weapon = self zm_weapons::give_build_kit_weapon(weapon);
	original_weapon = change_melee_weapon(weapon, original_weapon);
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission))
	{
		self.lastactiveweapon = level.weaponnone;
		return;
	}
	if(self hasweapon(level.weaponbasemelee))
	{
		self takeweapon(level.weaponbasemelee);
	}
	if(self zm_utility::is_multiple_drinking())
	{
		self zm_utility::decrement_is_drinking();
		return;
	}
	if(original_weapon == level.weaponbasemelee)
	{
		self switchtoweapon(weapon);
		self zm_utility::decrement_is_drinking();
		return;
	}
	if(original_weapon != level.weaponbasemelee && !zm_loadout::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon))
	{
		self zm_weapons::switch_back_primary_weapon(original_weapon);
	}
	else
	{
		self zm_weapons::switch_back_primary_weapon();
	}
	while(self isswitchingweapons())
	{
		waitframe(1);
	}
	if(!self laststand::player_is_in_laststand() && (!(isdefined(self.intermission) && self.intermission)))
	{
		self zm_utility::decrement_is_drinking();
	}
}

