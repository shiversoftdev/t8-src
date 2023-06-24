// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace aat;

/*
	Name: __init__system__
	Namespace: aat
	Checksum: 0xEE0BFCA7
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"aat", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: aat
	Checksum: 0x670565D6
	Offset: 0x188
	Size: 0x1D4
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	level.aat_initializing = 1;
	level.aat = [];
	level.aat[#"none"] = spawnstruct();
	level.aat[#"none"].name = "none";
	level.aat_reroll = [];
	level.var_bdba6ee8 = [];
	callback::on_connect(&on_player_connect);
	callback::function_33f0ddd3(&function_33f0ddd3);
	spawners = getspawnerarray();
	foreach(spawner in spawners)
	{
		spawner spawner::add_spawn_function(&aat_cooldown_init);
	}
	level.aat_exemptions = [];
	callback::on_finalize_initialization(&finalize_clientfields);
	/#
		level thread setup_devgui();
	#/
}

/*
	Name: on_player_connect
	Namespace: aat
	Checksum: 0x3FEB439E
	Offset: 0x368
	Size: 0xF8
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_connect()
{
	self.aat = [];
	self.aat_cooldown_start = [];
	if(!isdefined(self.var_b01de37))
	{
		self.var_b01de37 = [];
	}
	else if(!isarray(self.var_b01de37))
	{
		self.var_b01de37 = array(self.var_b01de37);
	}
	foreach(key, v in level.aat)
	{
		self.aat_cooldown_start[key] = 0;
	}
	self thread watch_weapon_changes();
	/#
	#/
}

/*
	Name: function_33f0ddd3
	Namespace: aat
	Checksum: 0xA7B81AFC
	Offset: 0x468
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "take_weapon" && isdefined(s_event.weapon))
	{
		weapon = function_702fb333(s_event.weapon);
		if(isdefined(self.aat[weapon]))
		{
			self remove(weapon);
		}
	}
}

/*
	Name: setup_devgui
	Namespace: aat
	Checksum: 0x25BE2DDA
	Offset: 0x500
	Size: 0x174
	Parameters: 0
	Flags: Private
*/
function private setup_devgui()
{
	/#
		waittillframeend();
		setdvar(#"aat_acquire_devgui", "");
		aat_devgui_base = "";
		foreach(key, v in level.aat)
		{
			if(key != "")
			{
				name = function_9e72a96(key);
				adddebugcommand((((((aat_devgui_base + name) + "") + "") + "") + name) + "");
			}
		}
		adddebugcommand(((((aat_devgui_base + "") + "") + "") + "") + "");
		level thread aat_devgui_think();
	#/
}

/*
	Name: aat_devgui_think
	Namespace: aat
	Checksum: 0xE4AF2B33
	Offset: 0x680
	Size: 0x170
	Parameters: 0
	Flags: Private
*/
function private aat_devgui_think()
{
	/#
		for(;;)
		{
			aat_name = getdvarstring(#"aat_acquire_devgui");
			if(aat_name != "")
			{
				for(i = 0; i < level.players.size; i++)
				{
					if(aat_name == "")
					{
						level.players[i] thread remove(level.players[i] getcurrentweapon());
					}
					else
					{
						level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
					}
					level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
				}
			}
			setdvar(#"aat_acquire_devgui", "");
			wait(0.5);
		}
	#/
}

/*
	Name: aat_set_debug_text
	Namespace: aat
	Checksum: 0x5A9826CA
	Offset: 0x7F8
	Size: 0x202
	Parameters: 4
	Flags: Private
*/
function private aat_set_debug_text(name, success, success_reroll, fail)
{
	/#
		self notify(#"aat_set_debug_text_thread");
		self endon(#"aat_set_debug_text_thread", #"disconnect");
		if(!isdefined(self.aat_debug_text))
		{
			return;
		}
		percentage = "";
		if(isdefined(level.aat[name]) && name != "")
		{
			percentage = level.aat[name].percentage;
		}
		self.aat_debug_text fadeovertime(0.05);
		self.aat_debug_text.alpha = 1;
		self.aat_debug_text settext((("" + name) + "") + percentage);
		if(success)
		{
			self.aat_debug_text.color = (0, 1, 0);
		}
		else
		{
			if(success_reroll)
			{
				self.aat_debug_text.color = vectorscale((1, 0, 1), 0.8);
			}
			else
			{
				if(fail)
				{
					self.aat_debug_text.color = (1, 0, 0);
				}
				else
				{
					self.aat_debug_text.color = (1, 1, 1);
				}
			}
		}
		wait(1);
		self.aat_debug_text fadeovertime(1);
		self.aat_debug_text.color = (1, 1, 1);
		if("" == name)
		{
			self.aat_debug_text.alpha = 0;
		}
	#/
}

/*
	Name: aat_cooldown_init
	Namespace: aat
	Checksum: 0xABDA58D5
	Offset: 0xA08
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
function private aat_cooldown_init()
{
	self.aat_cooldown_start = [];
	foreach(key, v in level.aat)
	{
		self.aat_cooldown_start[key] = 0;
	}
}

/*
	Name: aat_vehicle_damage_monitor
	Namespace: aat
	Checksum: 0x9C197A6A
	Offset: 0xA98
	Size: 0x100
	Parameters: 15
	Flags: Linked
*/
function aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	willbekilled = (self.health - idamage) <= 0;
	if(isdefined(level.aat_in_use) && level.aat_in_use)
	{
		self thread aat_response(willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal);
	}
	return idamage;
}

/*
	Name: function_3895d220
	Namespace: aat
	Checksum: 0x2749F1D7
	Offset: 0xBA0
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_3895d220(weapon)
{
	if(isdefined(weapon))
	{
		if(weapon.isaltmode)
		{
			weapon = weapon.altweapon;
		}
		if(weapon.inventorytype == "dwlefthand")
		{
			weapon = weapon.dualwieldweapon;
		}
		weapon = weapon.rootweapon;
	}
	return weapon;
}

/*
	Name: aat_response
	Namespace: aat
	Checksum: 0x762ED1E9
	Offset: 0xC18
	Size: 0x6DC
	Parameters: 13
	Flags: Linked
*/
function aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isplayer(attacker) || !isdefined(attacker.aat) || !isdefined(weapon))
	{
		return;
	}
	if(mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" && (mod != "MOD_MELEE" || (!(isdefined(level.var_9d1d502c) && level.var_9d1d502c))))
	{
		return;
	}
	name = attacker.aat[function_702fb333(weapon)];
	if(!isdefined(name))
	{
		return;
	}
	if(isdefined(death) && death && !level.aat[name].occurs_on_death)
	{
		return;
	}
	if(!isdefined(self.archetype))
	{
		return;
	}
	if(isdefined(self.var_dd6fe31f) && self.var_dd6fe31f)
	{
		return;
	}
	if(isdefined(self.var_69a981e6) && self.var_69a981e6)
	{
		return;
	}
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	if(isdefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype])
	{
		return;
	}
	now = float(gettime()) / 1000;
	if(isdefined(self.aat_cooldown_start) && now <= (self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity))
	{
		return;
	}
	if(now <= (attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker))
	{
		return;
	}
	if(now <= (level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global))
	{
		return;
	}
	if(isdefined(level.aat[name].validation_func))
	{
		if(![[level.aat[name].validation_func]]())
		{
			return;
		}
	}
	success = 0;
	reroll_icon = undefined;
	percentage = level.aat[name].percentage;
	if(isdefined(level.var_bdba6ee8[weapon]))
	{
		if(level.var_bdba6ee8[weapon] < percentage)
		{
			percentage = level.var_bdba6ee8[weapon];
		}
	}
	/#
		aat_percentage_override = getdvarfloat(#"scr_aat_percentage_override", 0);
		if(aat_percentage_override > 0)
		{
			percentage = aat_percentage_override;
		}
	#/
	if(percentage >= randomfloat(1))
	{
		success = 1;
		/#
			attacker thread aat_set_debug_text(name, 1, 0, 0);
		#/
	}
	if(!success)
	{
		keys = getarraykeys(level.aat_reroll);
		keys = array::randomize(keys);
		foreach(key in keys)
		{
			if(attacker [[level.aat_reroll[key].active_func]]())
			{
				for(i = 0; i < level.aat_reroll[key].count; i++)
				{
					if(percentage >= randomfloat(1))
					{
						success = 1;
						reroll_icon = level.aat_reroll[key].damage_feedback_icon;
						/#
							attacker thread aat_set_debug_text(name, 0, 1, 0);
						#/
						break;
					}
				}
			}
			if(success)
			{
				break;
			}
		}
	}
	if(!success)
	{
		/#
			attacker thread aat_set_debug_text(name, 0, 0, 1);
		#/
		return;
	}
	level.aat[name].cooldown_time_global_start = now;
	attacker.aat_cooldown_start[name] = now;
	self thread [[level.aat[name].result_func]](death, attacker, mod, weapon);
	if(isplayer(attacker))
	{
		attacker playlocalsound(level.aat[name].damage_feedback_sound);
	}
}

/*
	Name: register
	Namespace: aat
	Checksum: 0xC6B5D86D
	Offset: 0x1300
	Size: 0x61A
	Parameters: 11
	Flags: Linked
*/
function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, catalyst)
{
	/#
		assert(isdefined(level.aat_initializing) && level.aat_initializing, "");
	#/
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert("" != name, ("" + "") + "");
	#/
	/#
		assert(!isdefined(level.aat[name]), ("" + name) + "");
	#/
	/#
		assert(isdefined(percentage), ("" + name) + "");
	#/
	/#
		assert(0 <= percentage && 1 > percentage, ("" + name) + "");
	#/
	/#
		assert(isdefined(cooldown_time_entity), ("" + name) + "");
	#/
	/#
		assert(0 <= cooldown_time_entity, ("" + name) + "");
	#/
	/#
		assert(isdefined(cooldown_time_entity), ("" + name) + "");
	#/
	/#
		assert(0 <= cooldown_time_entity, ("" + name) + "");
	#/
	/#
		assert(isdefined(cooldown_time_global), ("" + name) + "");
	#/
	/#
		assert(0 <= cooldown_time_global, ("" + name) + "");
	#/
	/#
		assert(isdefined(occurs_on_death), ("" + name) + "");
	#/
	/#
		assert(isdefined(result_func), ("" + name) + "");
	#/
	/#
		assert(isdefined(damage_feedback_icon), ("" + name) + "");
	#/
	/#
		assert(isstring(damage_feedback_icon), ("" + name) + "");
	#/
	/#
		assert(isdefined(damage_feedback_sound), ("" + name) + "");
	#/
	/#
		assert(isstring(damage_feedback_sound), ("" + name) + "");
	#/
	level.aat[name] = spawnstruct();
	level.aat[name].name = name;
	level.aat[name].var_33c87f51 = function_129f6487(name);
	level.aat[name].percentage = percentage;
	level.aat[name].cooldown_time_entity = cooldown_time_entity;
	level.aat[name].cooldown_time_attacker = cooldown_time_attacker;
	level.aat[name].cooldown_time_global = cooldown_time_global;
	level.aat[name].cooldown_time_global_start = 0;
	level.aat[name].occurs_on_death = occurs_on_death;
	level.aat[name].result_func = result_func;
	level.aat[name].damage_feedback_icon = damage_feedback_icon;
	level.aat[name].damage_feedback_sound = damage_feedback_sound;
	level.aat[name].validation_func = validation_func;
	level.aat[name].immune_trigger = [];
	level.aat[name].immune_result_direct = [];
	level.aat[name].immune_result_indirect = [];
	if(isdefined(catalyst))
	{
		level.aat[name].catalyst = catalyst;
	}
}

/*
	Name: register_immunity
	Namespace: aat
	Checksum: 0xCF2D2AE0
	Offset: 0x1928
	Size: 0x1F6
	Parameters: 5
	Flags: Linked
*/
function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect)
{
	while(level.aat_initializing !== 0)
	{
		waitframe(1);
	}
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert(isdefined(archetype), "");
	#/
	/#
		assert(isdefined(immune_trigger), "");
	#/
	/#
		assert(isdefined(immune_result_direct), "");
	#/
	/#
		assert(isdefined(immune_result_indirect), "");
	#/
	if(!isdefined(level.aat[name].immune_trigger))
	{
		level.aat[name].immune_trigger = [];
	}
	if(!isdefined(level.aat[name].immune_result_direct))
	{
		level.aat[name].immune_result_direct = [];
	}
	if(!isdefined(level.aat[name].immune_result_indirect))
	{
		level.aat[name].immune_result_indirect = [];
	}
	level.aat[name].immune_trigger[archetype] = immune_trigger;
	level.aat[name].immune_result_direct[archetype] = immune_result_direct;
	level.aat[name].immune_result_indirect[archetype] = immune_result_indirect;
}

/*
	Name: finalize_clientfields
	Namespace: aat
	Checksum: 0x70BDB19
	Offset: 0x1B28
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function finalize_clientfields()
{
	/#
		println("");
	#/
	if(level.aat.size > 1)
	{
		array::alphabetize(level.aat);
		i = 0;
		foreach(aat in level.aat)
		{
			aat.clientfield_index = i;
			i++;
			/#
				println("" + aat.name);
			#/
		}
		n_bits = getminbitcountfornum(level.aat.size - 1);
		clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
	}
	level.aat_initializing = 0;
}

/*
	Name: register_aat_exemption
	Namespace: aat
	Checksum: 0x4DC0DD99
	Offset: 0x1CA8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function register_aat_exemption(weapon)
{
	weapon = function_702fb333(weapon);
	level.aat_exemptions[weapon] = 1;
}

/*
	Name: is_exempt_weapon
	Namespace: aat
	Checksum: 0x36085A03
	Offset: 0x1CF0
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function is_exempt_weapon(weapon)
{
	weapon = function_702fb333(weapon);
	return isdefined(level.aat_exemptions[weapon]);
}

/*
	Name: register_reroll
	Namespace: aat
	Checksum: 0xCA71F9F9
	Offset: 0x1D30
	Size: 0x25E
	Parameters: 4
	Flags: None
*/
function register_reroll(name, count, active_func, damage_feedback_icon)
{
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert("" != name, ("" + "") + "");
	#/
	/#
		assert(!isdefined(level.aat[name]), ("" + name) + "");
	#/
	/#
		assert(isdefined(count), ("" + name) + "");
	#/
	/#
		assert(0 < count, ("" + name) + "");
	#/
	/#
		assert(isdefined(active_func), ("" + name) + "");
	#/
	/#
		assert(isdefined(damage_feedback_icon), ("" + name) + "");
	#/
	/#
		assert(isstring(damage_feedback_icon), ("" + name) + "");
	#/
	level.aat_reroll[name] = spawnstruct();
	level.aat_reroll[name].name = name;
	level.aat_reroll[name].count = count;
	level.aat_reroll[name].active_func = active_func;
	level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

/*
	Name: function_702fb333
	Namespace: aat
	Checksum: 0x4EECC1A9
	Offset: 0x1F98
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_702fb333(weapon)
{
	if(isdefined(level.var_ee5c0b6e))
	{
		weapon = self [[level.var_ee5c0b6e]](weapon);
		return weapon;
	}
	weapon = function_3895d220(weapon);
	return weapon;
}

/*
	Name: getaatonweapon
	Namespace: aat
	Checksum: 0x92C2BAD7
	Offset: 0x1FF8
	Size: 0x108
	Parameters: 2
	Flags: Linked
*/
function getaatonweapon(weapon, var_a217d0c1 = 0)
{
	weapon = function_702fb333(weapon);
	if(weapon == level.weaponnone || (!(isdefined(level.aat_in_use) && level.aat_in_use)) || is_exempt_weapon(weapon) || (!isdefined(self.aat) || !isdefined(self.aat[weapon])) || !isdefined(level.aat[self.aat[weapon]]))
	{
		return undefined;
	}
	if(var_a217d0c1)
	{
		return self.aat[weapon];
	}
	return level.aat[self.aat[weapon]];
}

/*
	Name: acquire
	Namespace: aat
	Checksum: 0x10046349
	Offset: 0x2108
	Size: 0x392
	Parameters: 3
	Flags: Linked
*/
function acquire(weapon, name, var_77cf85b7)
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	/#
		assert(isdefined(weapon), "");
	#/
	/#
		assert(weapon != level.weaponnone, "");
	#/
	weapon = function_702fb333(weapon);
	if(is_exempt_weapon(weapon))
	{
		return;
	}
	if(isdefined(name))
	{
		/#
			assert("" != name, ("" + "") + "");
		#/
		/#
			assert(isdefined(level.aat[name]), ("" + name) + "");
		#/
		self.aat[weapon] = name;
	}
	else
	{
		keys = getarraykeys(level.aat);
		arrayremovevalue(keys, hash("none"));
		if(isdefined(self.aat[weapon]))
		{
			arrayremovevalue(keys, self.aat[weapon]);
		}
		if(isdefined(var_77cf85b7))
		{
			arrayremovevalue(keys, hash(var_77cf85b7));
		}
		rand = randomint(keys.size);
		name = keys[rand];
		self.aat[weapon] = name;
	}
	if(weapon == function_702fb333(self getcurrentweapon()))
	{
		self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
	}
	switch(name)
	{
		case "zm_aat_brain_decay":
		{
			self.var_b01de37[weapon] = 2;
			break;
		}
		case "zm_aat_plasmatic_burst":
		{
			self.var_b01de37[weapon] = 3;
			break;
		}
		case "zm_aat_kill_o_watt":
		{
			self.var_b01de37[weapon] = 4;
			break;
		}
		case "zm_aat_frostbite":
		{
			self.var_b01de37[weapon] = 1;
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: remove
	Namespace: aat
	Checksum: 0xC843936C
	Offset: 0x24A8
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function remove(weapon)
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	/#
		assert(isdefined(weapon), "");
	#/
	/#
		assert(weapon != level.weaponnone, "");
	#/
	weapon = function_702fb333(weapon);
	self.aat[weapon] = undefined;
	self.var_b01de37[weapon] = undefined;
}

/*
	Name: watch_weapon_changes
	Namespace: aat
	Checksum: 0x9E81098E
	Offset: 0x2568
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function watch_weapon_changes()
{
	self endon(#"disconnect");
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		weapon = waitresult.weapon;
		weapon = function_702fb333(weapon);
		name = "none";
		if(isdefined(self.aat[weapon]))
		{
			name = self.aat[weapon];
		}
		self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
	}
}

/*
	Name: has_aat
	Namespace: aat
	Checksum: 0xEEF201F7
	Offset: 0x2650
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function has_aat(w_current)
{
	w_current = function_702fb333(w_current);
	if(isdefined(self.aat) && isdefined(self.aat[w_current]))
	{
		return true;
	}
	return false;
}

