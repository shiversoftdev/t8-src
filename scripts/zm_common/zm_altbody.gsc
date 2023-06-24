// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_characters.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_altbody;

/*
	Name: __init__system__
	Namespace: zm_altbody
	Checksum: 0x80F98D21
	Offset: 0x240
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_altbody", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_altbody
	Checksum: 0x354176B6
	Offset: 0x288
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!isdefined(level.var_28f2d2b1))
	{
		level.var_28f2d2b1 = [];
	}
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
	clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int");
	clientfield::register("clientuimodel", "player_mana", 1, 8, "float");
	clientfield::register("allplayers", "player_altbody", 1, 1, "int");
}

/*
	Name: init
	Namespace: zm_altbody
	Checksum: 0x595658E6
	Offset: 0x378
	Size: 0x224
	Parameters: 12
	Flags: None
*/
function init(name, kiosk_name, trigger_hint, visionset_name, visionset_priority, loadout, character_index, enter_callback, exit_callback, allow_callback, notrigger_hint, var_64d51f6)
{
	if(!isdefined(level.altbody_enter_callbacks))
	{
		level.altbody_enter_callbacks = [];
	}
	if(!isdefined(level.altbody_exit_callbacks))
	{
		level.altbody_exit_callbacks = [];
	}
	if(!isdefined(level.altbody_allow_callbacks))
	{
		level.altbody_allow_callbacks = [];
	}
	if(!isdefined(level.altbody_loadouts))
	{
		level.altbody_loadouts = [];
	}
	if(!isdefined(level.altbody_visionsets))
	{
		level.altbody_visionsets = [];
	}
	if(!isdefined(level.altbody_charindexes))
	{
		level.altbody_charindexes = [];
	}
	if(isdefined(visionset_name))
	{
		level.altbody_visionsets[name] = visionset_name;
		visionset_mgr::register_info("visionset", visionset_name, 1, visionset_priority, 1, 1);
	}
	function_87585132(name, kiosk_name, trigger_hint, notrigger_hint);
	level.altbody_enter_callbacks[name] = enter_callback;
	level.altbody_exit_callbacks[name] = exit_callback;
	level.altbody_allow_callbacks[name] = allow_callback;
	level.altbody_loadouts[name] = loadout;
	level.altbody_charindexes[name] = character_index;
	level.var_28f2d2b1[name] = var_64d51f6;
	level thread function_6991025d();
}

/*
	Name: function_6991025d
	Namespace: zm_altbody
	Checksum: 0xB86C1A74
	Offset: 0x5A8
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_6991025d()
{
	level waittill(#"end_game");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] notify(#"altbody_end");
	}
}

/*
	Name: devgui_start_altbody
	Namespace: zm_altbody
	Checksum: 0xBEE5F2E
	Offset: 0x628
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function devgui_start_altbody(name)
{
	/#
		self player_altbody(name);
	#/
}

/*
	Name: function_17d98816
	Namespace: zm_altbody
	Checksum: 0x9CCDA7C3
	Offset: 0x658
	Size: 0x100
	Parameters: 2
	Flags: Private
*/
function private function_17d98816(trigger, name)
{
	if(self zm_utility::is_drinking() && (!(isdefined(self.trigger_kiosks_in_altbody) && self.trigger_kiosks_in_altbody)))
	{
		return false;
	}
	if(self zm_utility::in_revive_trigger())
	{
		return false;
	}
	if(self laststand::player_is_in_laststand())
	{
		return false;
	}
	if(self isthrowinggrenade())
	{
		return false;
	}
	if(self function_1193c448(name))
	{
		return false;
	}
	callback = level.altbody_allow_callbacks[name];
	if(isdefined(callback))
	{
		if(!self [[callback]](name, trigger.kiosk))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: player_can_altbody
	Namespace: zm_altbody
	Checksum: 0xE268A5B3
	Offset: 0x760
	Size: 0x112
	Parameters: 2
	Flags: Private
*/
function private player_can_altbody(kiosk, name)
{
	if(isdefined(self.altbody) && self.altbody)
	{
		return false;
	}
	if(self zm_utility::is_drinking() && (!(isdefined(self.trigger_kiosks_in_altbody) && self.trigger_kiosks_in_altbody)))
	{
		return false;
	}
	if(self zm_utility::in_revive_trigger())
	{
		return false;
	}
	if(self laststand::player_is_in_laststand())
	{
		return false;
	}
	if(self isthrowinggrenade())
	{
		return false;
	}
	if(self function_1193c448(name))
	{
		return false;
	}
	callback = level.altbody_allow_callbacks[name];
	if(isdefined(callback))
	{
		if(!self [[callback]](name, kiosk))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_1193c448
	Namespace: zm_altbody
	Checksum: 0x9B47EF3F
	Offset: 0x880
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function function_1193c448(name)
{
	if(!isdefined(level.var_28f2d2b1))
	{
		level.var_28f2d2b1 = [];
	}
	if(!isdefined(level.var_28f2d2b1[name]))
	{
		level.var_28f2d2b1[name] = [];
	}
	foreach(str_bgb in level.var_28f2d2b1[name])
	{
		if(self bgb::is_enabled(str_bgb))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: player_try_altbody
	Namespace: zm_altbody
	Checksum: 0x70065376
	Offset: 0x968
	Size: 0x9C
	Parameters: 2
	Flags: Private
*/
function private player_try_altbody(trigger, name)
{
	self endon(#"disconnect");
	if(self player_can_altbody(trigger, name))
	{
		level notify(#"kiosk_used", {#kiosk:trigger.stub.kiosk});
		self player_altbody(name, trigger);
	}
}

/*
	Name: player_altbody
	Namespace: zm_altbody
	Checksum: 0xCF8B346F
	Offset: 0xA10
	Size: 0x9E
	Parameters: 2
	Flags: Private
*/
function private player_altbody(name, trigger)
{
	self.altbody = 1;
	self thread val::set_for_time(1, "altbody", "takedamage", 0);
	self player_enter_altbody(name, trigger);
	self waittill(#"altbody_end");
	self player_exit_altbody(name, trigger);
	self.altbody = 0;
}

/*
	Name: get_altbody_weapon_limit
	Namespace: zm_altbody
	Checksum: 0x7FA88FF2
	Offset: 0xAB8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function get_altbody_weapon_limit(player)
{
	return 16;
}

/*
	Name: player_enter_altbody
	Namespace: zm_altbody
	Checksum: 0x3CB9427E
	Offset: 0xAD0
	Size: 0x144
	Parameters: 2
	Flags: Private
*/
function private player_enter_altbody(name, trigger)
{
	charindex = level.altbody_charindexes[name];
	self.var_fdbe134c = self.origin;
	self.var_55433be5 = self.angles;
	self setperk("specialty_playeriszombie");
	self thread function_d709966a(1);
	self setcharacterbodytype(charindex);
	clientfield::set_to_player("player_in_afterlife", 1);
	self player_apply_loadout(name);
	self thread player_apply_visionset(name);
	callback = level.altbody_enter_callbacks[name];
	if(isdefined(callback))
	{
		self [[callback]](name, trigger);
	}
	clientfield::set("player_altbody", 1);
}

/*
	Name: player_apply_visionset
	Namespace: zm_altbody
	Checksum: 0xEDC83C2F
	Offset: 0xC20
	Size: 0xEA
	Parameters: 1
	Flags: Private
*/
function private player_apply_visionset(name)
{
	if(!isdefined(self.altbody_visionset))
	{
		self.altbody_visionset = [];
	}
	visionset = level.altbody_visionsets[name];
	if(isdefined(visionset))
	{
		if(isdefined(self.altbody_visionset[name]) && self.altbody_visionset[name])
		{
			visionset_mgr::deactivate("visionset", visionset, self);
			util::wait_network_frame();
			util::wait_network_frame();
			if(!isdefined(self))
			{
				return;
			}
		}
		visionset_mgr::activate("visionset", visionset, self);
		self.altbody_visionset[name] = 1;
	}
}

/*
	Name: player_apply_loadout
	Namespace: zm_altbody
	Checksum: 0xCAEE5EC7
	Offset: 0xD18
	Size: 0x174
	Parameters: 1
	Flags: Private
*/
function private player_apply_loadout(name)
{
	self bgb::suspend_weapon_cycling();
	loadout = level.altbody_loadouts[name];
	if(isdefined(loadout))
	{
		self disableweaponcycling();
		/#
			assert(!isdefined(self.get_player_weapon_limit));
		#/
		self.get_player_weapon_limit = &get_altbody_weapon_limit;
		self.altbody_loadout[name] = zm_weapons::player_get_loadout();
		self zm_weapons::player_give_loadout(loadout, 0, 1);
		if(!isdefined(self.altbody_loadout_ever_had))
		{
			self.altbody_loadout_ever_had = [];
		}
		if(isdefined(self.altbody_loadout_ever_had[name]) && self.altbody_loadout_ever_had[name])
		{
			self seteverhadweaponall(1);
		}
		self.altbody_loadout_ever_had[name] = 1;
		self waittilltimeout(1, #"weapon_change_complete");
		self resetanimations();
	}
}

/*
	Name: player_exit_altbody
	Namespace: zm_altbody
	Checksum: 0x27E6B1AD
	Offset: 0xE98
	Size: 0x15C
	Parameters: 2
	Flags: Private
*/
function private player_exit_altbody(name, trigger)
{
	clientfield::set("player_altbody", 0);
	clientfield::set_to_player("player_in_afterlife", 0);
	callback = level.altbody_exit_callbacks[name];
	if(isdefined(callback))
	{
		self [[callback]](name, trigger);
	}
	if(!isdefined(self.altbody_visionset))
	{
		self.altbody_visionset = [];
	}
	visionset = level.altbody_visionsets[name];
	if(isdefined(visionset))
	{
		visionset_mgr::deactivate("visionset", visionset, self);
		self.altbody_visionset[name] = 0;
	}
	self thread player_restore_loadout(name);
	self unsetperk("specialty_playeriszombie");
	self detachall();
	self thread function_d709966a(0);
	zm_characters::set_character();
}

/*
	Name: player_restore_loadout
	Namespace: zm_altbody
	Checksum: 0xAB1F7316
	Offset: 0x1000
	Size: 0x134
	Parameters: 2
	Flags: Private
*/
function private player_restore_loadout(name, trigger)
{
	loadout = level.altbody_loadouts[name];
	if(isdefined(loadout))
	{
		if(isdefined(self.altbody_loadout[name]))
		{
			self zm_weapons::switch_back_primary_weapon(self.altbody_loadout[name].current, 1);
			self.altbody_loadout[name] = undefined;
			self waittilltimeout(1, #"weapon_change_complete");
		}
		self zm_weapons::player_take_loadout(loadout);
		/#
			assert(self.get_player_weapon_limit == (&get_altbody_weapon_limit));
		#/
		self.get_player_weapon_limit = undefined;
		self resetanimations();
		self enableweaponcycling();
	}
	self bgb::resume_weapon_cycling();
}

/*
	Name: function_d709966a
	Namespace: zm_altbody
	Checksum: 0xE05E63F4
	Offset: 0x1140
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_d709966a(washuman)
{
	if(washuman)
	{
		playfx(level._effect[#"human_disappears"], self.origin);
	}
	else
	{
		playfx(level._effect[#"zombie_disappears"], self.origin);
		playsoundatposition(#"zmb_player_disapparate", self.origin);
		self playlocalsound(#"zmb_player_disapparate_2d");
	}
}

/*
	Name: function_87585132
	Namespace: zm_altbody
	Checksum: 0x25656818
	Offset: 0x1210
	Size: 0x110
	Parameters: 4
	Flags: None
*/
function function_87585132(name, kiosk_name, trigger_hint, notrigger_hint)
{
	if(!isdefined(level.altbody_kiosks))
	{
		level.altbody_kiosks = [];
	}
	level.altbody_kiosks[name] = struct::get_array(kiosk_name, "targetname");
	foreach(kiosk in level.altbody_kiosks[name])
	{
		function_f5e5eac2(kiosk, name, trigger_hint, notrigger_hint);
	}
	level notify(#"hash_3cf24457a0015f72", name);
}

/*
	Name: function_f5e5eac2
	Namespace: zm_altbody
	Checksum: 0xB457A5CD
	Offset: 0x1328
	Size: 0x16C
	Parameters: 4
	Flags: None
*/
function function_f5e5eac2(kiosk, name, trigger_hint, notrigger_hint)
{
	width = 128;
	height = 128;
	length = 128;
	unitrigger_stub = spawnstruct();
	unitrigger_stub.origin = kiosk.origin + vectorscale((0, 0, 1), 32);
	unitrigger_stub.angles = kiosk.angles;
	unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	unitrigger_stub.radius = 64;
	unitrigger_stub.require_look_at = 0;
	unitrigger_stub.kiosk = kiosk;
	unitrigger_stub.altbody_name = name;
	unitrigger_stub.trigger_hint = trigger_hint;
	unitrigger_stub.notrigger_hint = notrigger_hint;
	unitrigger_stub.prompt_and_visibility_func = &kiosk_trigger_visibility;
	zm_unitrigger::register_static_unitrigger(unitrigger_stub, &kiosk_trigger_think);
}

/*
	Name: kiosk_trigger_visibility
	Namespace: zm_altbody
	Checksum: 0x40AACF37
	Offset: 0x14A0
	Size: 0x148
	Parameters: 1
	Flags: None
*/
function kiosk_trigger_visibility(player)
{
	if(!isdefined(player))
	{
		return 0;
	}
	visible = !(isdefined(player.altbody) && player.altbody) || (isdefined(player.see_kiosks_in_altbody) && player.see_kiosks_in_altbody);
	self.stub.usable = player player_can_altbody(self.stub.kiosk, self.stub.altbody_name);
	if(self.stub.usable)
	{
		self.stub.hint_string = self.stub.trigger_hint;
	}
	else
	{
		self.stub.hint_string = self.stub.notrigger_hint;
	}
	self sethintstring(self.stub.hint_string);
	self setinvisibletoplayer(player, !visible);
	return visible;
}

/*
	Name: kiosk_trigger_think
	Namespace: zm_altbody
	Checksum: 0xE39F7026
	Offset: 0x15F0
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function kiosk_trigger_think()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(isdefined(self.stub.usable) && self.stub.usable)
		{
			self.stub.usable = 0;
			name = self.stub.altbody_name;
			if(isdefined(player.custom_altbody_callback))
			{
				player thread [[player.custom_altbody_callback]](self, name);
			}
			else
			{
				player thread player_try_altbody(self, name);
			}
		}
	}
}

/*
	Name: watch_kiosk_triggers
	Namespace: zm_altbody
	Checksum: 0x64834891
	Offset: 0x16E8
	Size: 0xA4
	Parameters: 4
	Flags: Private
*/
function private watch_kiosk_triggers(name, trigger_name, trigger_hint, whenvisible)
{
	triggers = getentarray(trigger_name, "targetname");
	if(!triggers.size)
	{
		triggers = getentarray(trigger_name, "script_noteworthy");
	}
	array::thread_all(triggers, &trigger_watch_kiosk, name, trigger_name, trigger_hint, whenvisible);
}

/*
	Name: trigger_watch_kiosk
	Namespace: zm_altbody
	Checksum: 0x730CD48D
	Offset: 0x1798
	Size: 0x178
	Parameters: 4
	Flags: Private
*/
function private trigger_watch_kiosk(name, trigger_name, trigger_hint, whenvisible)
{
	self endon(#"death");
	self sethintstring(trigger_hint);
	self setcursorhint("HINT_NOICON");
	self setvisibletoall();
	self thread trigger_monitor_visibility(name, whenvisible);
	if(whenvisible)
	{
		if(isdefined(self.target))
		{
			target = getent(self.target, "targetname");
			self.kiosk = target;
		}
		while(isdefined(self))
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			player = waitresult.activator;
			if(isdefined(player.custom_altbody_callback))
			{
				player thread [[player.custom_altbody_callback]](self, name);
			}
			else
			{
				player thread player_try_altbody(self, name);
			}
		}
	}
}

/*
	Name: trigger_monitor_visibility
	Namespace: zm_altbody
	Checksum: 0x289F0B51
	Offset: 0x1918
	Size: 0x1D0
	Parameters: 2
	Flags: None
*/
function trigger_monitor_visibility(name, whenvisible)
{
	self endon(#"death");
	self setinvisibletoall();
	level flagsys::wait_till("start_zombie_round_logic");
	self setvisibletoall();
	pid = 0;
	self.is_unlocked = 1;
	while(isdefined(self))
	{
		players = level.players;
		if(pid >= players.size)
		{
			pid = 0;
		}
		player = players[pid];
		pid++;
		if(isdefined(player))
		{
			visible = 1;
			visible = player player_can_altbody(self, name);
			if(visible == whenvisible && (!(isdefined(player.altbody) && player.altbody) || (isdefined(player.see_kiosks_in_altbody) && player.see_kiosks_in_altbody)) && (isdefined(self.is_unlocked) && self.is_unlocked))
			{
				self setvisibletoplayer(player);
			}
			else
			{
				self setinvisibletoplayer(player);
			}
		}
		wait(randomfloatrange(0.2, 0.5));
	}
}

