// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_545a0bac37bda541;
#using script_56ca01b3b31455b5;
#using script_bc839bb0e693558;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace ability_player;

/*
	Name: function_89f2df9
	Namespace: ability_player
	Checksum: 0x23E136A2
	Offset: 0x190
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"ability_player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: ability_player
	Checksum: 0x21F63A83
	Offset: 0x1D8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level callback::add_callback(#"on_end_game", &on_end_game);
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	callback::on_disconnect(&on_player_disconnect);
	if(!isdefined(level._gadgets_level))
	{
		level._gadgets_level = [];
	}
	/#
		level thread abilities_devgui_init();
	#/
}

/*
	Name: on_player_connect
	Namespace: ability_player
	Checksum: 0x5F14D1BB
	Offset: 0x2B0
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(!isdefined(self._gadgets_player))
	{
		self._gadgets_player = [];
	}
	if(!isdefined(self.var_aec4af05))
	{
		self.var_aec4af05 = [];
	}
	if(!isdefined(self.pers[#"herogadgetnotified"]))
	{
		self.pers[#"herogadgetnotified"] = [];
	}
	for(slot = 0; slot < 3; slot++)
	{
		self.pers[#"herogadgetnotified"][slot] = 0;
	}
	self callback::on_death(&function_32e782df);
	/#
		if(self getentnum() < 10)
		{
			self thread abilities_devgui_player_connect();
		}
	#/
}

/*
	Name: on_player_spawned
	Namespace: ability_player
	Checksum: 0xB000EE57
	Offset: 0x3C0
	Size: 0x2CE
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	var_aa960fc9 = self getweaponslist();
	foreach(weapon in var_aa960fc9)
	{
		if((isdefined(weapon.gadget_power_reset_on_spawn) ? weapon.gadget_power_reset_on_spawn : 0))
		{
			slot = self gadgetgetslot(weapon);
			isfirstspawn = (isdefined(self.firstspawn) ? self.firstspawn : 1);
			self gadgetpowerreset(slot, isfirstspawn);
		}
	}
	if((isdefined(self.var_36546d49) ? self.var_36546d49 : 1) && game.state == "playing")
	{
		self.var_36546d49 = 0;
		for(slot = 0; slot < 3; slot++)
		{
			if(isdefined(self._gadgets_player) && isdefined(self._gadgets_player[slot]))
			{
				gadgetweapon = self._gadgets_player[slot];
				if((isdefined(gadgetweapon.var_ddaa57f2) ? gadgetweapon.var_ddaa57f2 : 0))
				{
					self gadgetpowerset(slot, (isdefined(gadgetweapon.var_6a864cad) ? gadgetweapon.var_6a864cad : 100));
				}
			}
		}
	}
	else if(game.state != "playing")
	{
		self.var_36546d49 = 0;
	}
	if(!(isdefined(self.pers[#"changed_class"]) && self.pers[#"changed_class"]))
	{
		self.pers[#"held_gadgets_power"] = [];
		self.pers[#"hash_7a954c017d693f69"] = [];
		self.pers[#"hash_68cdf8807cfaabff"] = [];
	}
	self.heroabilityactivatetime = undefined;
	self.heroabilitydectivatetime = undefined;
	self.heroabilityactive = undefined;
}

/*
	Name: on_player_disconnect
	Namespace: ability_player
	Checksum: 0xDDC2CED4
	Offset: 0x698
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	/#
		self thread abilities_devgui_player_disconnect();
	#/
}

/*
	Name: is_using_any_gadget
	Namespace: ability_player
	Checksum: 0xB08C988D
	Offset: 0x6C0
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function is_using_any_gadget()
{
	if(!isplayer(self))
	{
		return 0;
	}
	for(i = 0; i < 3; i++)
	{
		if(self util::gadget_is_in_use(i))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: gadgets_save_power
	Namespace: ability_player
	Checksum: 0x2D931DAF
	Offset: 0x730
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function gadgets_save_power(game_ended)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	for(slot = 0; slot < 3; slot++)
	{
		if(!isdefined(self._gadgets_player[slot]))
		{
			continue;
		}
		gadgetweapon = self._gadgets_player[slot];
		powerleft = self gadgetpowerchange(slot, 0);
		var_51ec1787 = self function_adc6203f(slot);
		deployed = self function_36dfc05f(slot);
		if(game_ended && (deployed || util::gadget_is_in_use(slot)))
		{
			if(gadgetweapon.gadget_power_round_end_active_penalty > 0)
			{
				powerleft = powerleft - gadgetweapon.gadget_power_round_end_active_penalty;
				powerleft = max(0, powerleft);
			}
		}
		self.pers[#"held_gadgets_power"][gadgetweapon] = powerleft;
		self.pers[#"hash_7a954c017d693f69"][gadgetweapon] = var_51ec1787;
		self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon] = deployed;
	}
}

/*
	Name: function_c9b950e3
	Namespace: ability_player
	Checksum: 0xCD936784
	Offset: 0x8E8
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_c9b950e3()
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	for(slot = 0; slot < 3; slot++)
	{
		if(!isdefined(self._gadgets_player[slot]))
		{
			continue;
		}
		self function_19ed70ca(slot, 0);
	}
}

/*
	Name: function_116ec442
	Namespace: ability_player
	Checksum: 0x24D9E723
	Offset: 0x958
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function function_116ec442()
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	for(slot = 0; slot < 3; slot++)
	{
		if(!isdefined(self._gadgets_player[slot]))
		{
			continue;
		}
		if(self._gadgets_player[slot].statname == #"gadget_health_regen")
		{
			continue;
		}
		self function_19ed70ca(slot, 1);
	}
}

/*
	Name: function_c22f319e
	Namespace: ability_player
	Checksum: 0x5BBB9620
	Offset: 0x9F8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_c22f319e(weapon, var_4dd90b81 = 0)
{
	slot = self gadgetgetslot(weapon);
	self gadgetdeactivate(slot, weapon, var_4dd90b81);
	self function_ac25fc1f(slot, weapon);
}

/*
	Name: function_f2250880
	Namespace: ability_player
	Checksum: 0x13BAB8FB
	Offset: 0xA80
	Size: 0x1BC
	Parameters: 2
	Flags: Linked
*/
function function_f2250880(weapon, var_4dd90b81 = 0)
{
	if(!isdefined(self) || !isdefined(weapon))
	{
		return;
	}
	if(isalive(self))
	{
		slot = self gadgetgetslot(weapon);
		self function_95218c27(slot, var_4dd90b81);
	}
	else if(!isdefined(self.var_8912d8d9))
	{
		self.var_8912d8d9 = [];
		self.var_41ea5be4 = [];
	}
	if(!isdefined(self.var_8912d8d9))
	{
		self.var_8912d8d9 = [];
	}
	else if(!isarray(self.var_8912d8d9))
	{
		self.var_8912d8d9 = array(self.var_8912d8d9);
	}
	self.var_8912d8d9[self.var_8912d8d9.size] = weapon;
	if(!isdefined(self.var_41ea5be4))
	{
		self.var_41ea5be4 = [];
	}
	else if(!isarray(self.var_41ea5be4))
	{
		self.var_41ea5be4 = array(self.var_41ea5be4);
	}
	self.var_41ea5be4[self.var_41ea5be4.size] = var_4dd90b81;
	callback::function_d8abfc3d(#"on_player_spawned", &function_9c46835d);
}

/*
	Name: function_9c46835d
	Namespace: ability_player
	Checksum: 0x2C5B0287
	Offset: 0xC48
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_9c46835d(params)
{
	if(isdefined(self.var_8912d8d9))
	{
		for(i = 0; i < self.var_8912d8d9.size; i++)
		{
			slot = self gadgetgetslot(self.var_8912d8d9[i]);
			self function_95218c27(slot, self.var_41ea5be4[i]);
		}
	}
	self.var_8912d8d9 = undefined;
	self.var_41ea5be4 = undefined;
	callback::function_52ac9652(#"on_player_spawned", &function_9c46835d);
}

/*
	Name: function_95218c27
	Namespace: ability_player
	Checksum: 0xF06B7935
	Offset: 0xD20
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_95218c27(slot, var_4dd90b81 = 0)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
	self function_48e08b4(slot, self._gadgets_player[slot], var_4dd90b81);
}

/*
	Name: function_c2d9d3e1
	Namespace: ability_player
	Checksum: 0x5BB93F7F
	Offset: 0xDC0
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function function_c2d9d3e1()
{
	for(slot = 0; slot < 3; slot++)
	{
		self function_95218c27(slot);
	}
}

/*
	Name: function_32e782df
	Namespace: ability_player
	Checksum: 0x55EA0BD5
	Offset: 0xE08
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_32e782df(params)
{
	if(game.state != "playing")
	{
		return;
	}
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	self gadgets_save_power(0);
}

/*
	Name: on_end_game
	Namespace: ability_player
	Checksum: 0xEBBB8B59
	Offset: 0xE60
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	players = getplayers();
	foreach(player in players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(!isdefined(player._gadgets_player))
		{
			continue;
		}
		player gadgets_save_power(1);
	}
}

/*
	Name: script_set_cclass
	Namespace: ability_player
	Checksum: 0xA28562AB
	Offset: 0xF30
	Size: 0x24
	Parameters: 2
	Flags: None
*/
function script_set_cclass(cclass, save = 1)
{
}

/*
	Name: register_gadget
	Namespace: ability_player
	Checksum: 0x145CC765
	Offset: 0xF60
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function register_gadget(type)
{
	if(!isdefined(level._gadgets_level))
	{
		level._gadgets_level = [];
	}
	if(!isdefined(level._gadgets_level[type]))
	{
		level._gadgets_level[type] = spawnstruct();
		level._gadgets_level[type].should_notify = 1;
	}
}

/*
	Name: register_gadget_should_notify
	Namespace: ability_player
	Checksum: 0x2627F1E8
	Offset: 0xFF0
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function register_gadget_should_notify(type, should_notify)
{
	register_gadget(type);
	if(isdefined(should_notify))
	{
		level._gadgets_level[type].should_notify = should_notify;
	}
}

/*
	Name: register_gadget_possession_callbacks
	Namespace: ability_player
	Checksum: 0x92EB8E1B
	Offset: 0x1050
	Size: 0x252
	Parameters: 3
	Flags: Linked
*/
function register_gadget_possession_callbacks(type, on_give, on_take)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].on_give))
	{
		level._gadgets_level[type].on_give = [];
	}
	if(!isdefined(level._gadgets_level[type].on_take))
	{
		level._gadgets_level[type].on_take = [];
	}
	if(isdefined(on_give))
	{
		if(!isdefined(level._gadgets_level[type].on_give))
		{
			level._gadgets_level[type].on_give = [];
		}
		else if(!isarray(level._gadgets_level[type].on_give))
		{
			level._gadgets_level[type].on_give = array(level._gadgets_level[type].on_give);
		}
		level._gadgets_level[type].on_give[level._gadgets_level[type].on_give.size] = on_give;
	}
	if(isdefined(on_take))
	{
		if(!isdefined(level._gadgets_level[type].on_take))
		{
			level._gadgets_level[type].on_take = [];
		}
		else if(!isarray(level._gadgets_level[type].on_take))
		{
			level._gadgets_level[type].on_take = array(level._gadgets_level[type].on_take);
		}
		level._gadgets_level[type].on_take[level._gadgets_level[type].on_take.size] = on_take;
	}
}

/*
	Name: register_gadget_activation_callbacks
	Namespace: ability_player
	Checksum: 0x6F4C7E0A
	Offset: 0x12B0
	Size: 0x252
	Parameters: 3
	Flags: Linked
*/
function register_gadget_activation_callbacks(type, turn_on, turn_off)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].turn_on))
	{
		level._gadgets_level[type].turn_on = [];
	}
	if(!isdefined(level._gadgets_level[type].turn_off))
	{
		level._gadgets_level[type].turn_off = [];
	}
	if(isdefined(turn_on))
	{
		if(!isdefined(level._gadgets_level[type].turn_on))
		{
			level._gadgets_level[type].turn_on = [];
		}
		else if(!isarray(level._gadgets_level[type].turn_on))
		{
			level._gadgets_level[type].turn_on = array(level._gadgets_level[type].turn_on);
		}
		level._gadgets_level[type].turn_on[level._gadgets_level[type].turn_on.size] = turn_on;
	}
	if(isdefined(turn_off))
	{
		if(!isdefined(level._gadgets_level[type].turn_off))
		{
			level._gadgets_level[type].turn_off = [];
		}
		else if(!isarray(level._gadgets_level[type].turn_off))
		{
			level._gadgets_level[type].turn_off = array(level._gadgets_level[type].turn_off);
		}
		level._gadgets_level[type].turn_off[level._gadgets_level[type].turn_off.size] = turn_off;
	}
}

/*
	Name: function_92292af6
	Namespace: ability_player
	Checksum: 0x1E25AB41
	Offset: 0x1510
	Size: 0x252
	Parameters: 3
	Flags: None
*/
function function_92292af6(type, var_1a7f628d, var_5ade95a3)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].var_1a7f628d))
	{
		level._gadgets_level[type].var_1a7f628d = [];
	}
	if(!isdefined(level._gadgets_level[type].var_5ade95a3))
	{
		level._gadgets_level[type].var_5ade95a3 = [];
	}
	if(isdefined(var_1a7f628d))
	{
		if(!isdefined(level._gadgets_level[type].var_1a7f628d))
		{
			level._gadgets_level[type].var_1a7f628d = [];
		}
		else if(!isarray(level._gadgets_level[type].var_1a7f628d))
		{
			level._gadgets_level[type].var_1a7f628d = array(level._gadgets_level[type].var_1a7f628d);
		}
		level._gadgets_level[type].var_1a7f628d[level._gadgets_level[type].var_1a7f628d.size] = var_1a7f628d;
	}
	if(isdefined(var_5ade95a3))
	{
		if(!isdefined(level._gadgets_level[type].var_5ade95a3))
		{
			level._gadgets_level[type].var_5ade95a3 = [];
		}
		else if(!isarray(level._gadgets_level[type].var_5ade95a3))
		{
			level._gadgets_level[type].var_5ade95a3 = array(level._gadgets_level[type].var_5ade95a3);
		}
		level._gadgets_level[type].var_5ade95a3[level._gadgets_level[type].var_5ade95a3.size] = var_5ade95a3;
	}
}

/*
	Name: register_gadget_flicker_callbacks
	Namespace: ability_player
	Checksum: 0x2A8612A9
	Offset: 0x1770
	Size: 0x13A
	Parameters: 2
	Flags: None
*/
function register_gadget_flicker_callbacks(type, on_flicker)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].on_flicker))
	{
		level._gadgets_level[type].on_flicker = [];
	}
	if(isdefined(on_flicker))
	{
		if(!isdefined(level._gadgets_level[type].on_flicker))
		{
			level._gadgets_level[type].on_flicker = [];
		}
		else if(!isarray(level._gadgets_level[type].on_flicker))
		{
			level._gadgets_level[type].on_flicker = array(level._gadgets_level[type].on_flicker);
		}
		level._gadgets_level[type].on_flicker[level._gadgets_level[type].on_flicker.size] = on_flicker;
	}
}

/*
	Name: register_gadget_ready_callbacks
	Namespace: ability_player
	Checksum: 0x30386D6D
	Offset: 0x18B8
	Size: 0x13A
	Parameters: 2
	Flags: Linked
*/
function register_gadget_ready_callbacks(type, ready_func)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].on_ready))
	{
		level._gadgets_level[type].on_ready = [];
	}
	if(isdefined(ready_func))
	{
		if(!isdefined(level._gadgets_level[type].on_ready))
		{
			level._gadgets_level[type].on_ready = [];
		}
		else if(!isarray(level._gadgets_level[type].on_ready))
		{
			level._gadgets_level[type].on_ready = array(level._gadgets_level[type].on_ready);
		}
		level._gadgets_level[type].on_ready[level._gadgets_level[type].on_ready.size] = ready_func;
	}
}

/*
	Name: register_gadget_primed_callbacks
	Namespace: ability_player
	Checksum: 0x58E749A1
	Offset: 0x1A00
	Size: 0x13A
	Parameters: 2
	Flags: None
*/
function register_gadget_primed_callbacks(type, primed_func)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].on_primed))
	{
		level._gadgets_level[type].on_primed = [];
	}
	if(isdefined(primed_func))
	{
		if(!isdefined(level._gadgets_level[type].on_primed))
		{
			level._gadgets_level[type].on_primed = [];
		}
		else if(!isarray(level._gadgets_level[type].on_primed))
		{
			level._gadgets_level[type].on_primed = array(level._gadgets_level[type].on_primed);
		}
		level._gadgets_level[type].on_primed[level._gadgets_level[type].on_primed.size] = primed_func;
	}
}

/*
	Name: register_gadget_is_inuse_callbacks
	Namespace: ability_player
	Checksum: 0x1F8AC6A1
	Offset: 0x1B48
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function register_gadget_is_inuse_callbacks(type, inuse_func)
{
	register_gadget(type);
	if(isdefined(inuse_func))
	{
		level._gadgets_level[type].isinuse = inuse_func;
	}
}

/*
	Name: register_gadget_is_flickering_callbacks
	Namespace: ability_player
	Checksum: 0xE306265D
	Offset: 0x1BA8
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function register_gadget_is_flickering_callbacks(type, flickering_func)
{
	register_gadget(type);
	if(isdefined(flickering_func))
	{
		level._gadgets_level[type].isflickering = flickering_func;
	}
}

/*
	Name: register_gadget_failed_activate_callback
	Namespace: ability_player
	Checksum: 0xF2D977FD
	Offset: 0x1C08
	Size: 0x13A
	Parameters: 2
	Flags: None
*/
function register_gadget_failed_activate_callback(type, failed_activate)
{
	register_gadget(type);
	if(!isdefined(level._gadgets_level[type].failed_activate))
	{
		level._gadgets_level[type].failed_activate = [];
	}
	if(isdefined(failed_activate))
	{
		if(!isdefined(level._gadgets_level[type].failed_activate))
		{
			level._gadgets_level[type].failed_activate = [];
		}
		else if(!isarray(level._gadgets_level[type].failed_activate))
		{
			level._gadgets_level[type].failed_activate = array(level._gadgets_level[type].failed_activate);
		}
		level._gadgets_level[type].failed_activate[level._gadgets_level[type].failed_activate.size] = failed_activate;
	}
}

/*
	Name: gadget_is_flickering
	Namespace: ability_player
	Checksum: 0x568D691F
	Offset: 0x1D50
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function gadget_is_flickering(slot)
{
	if(!isdefined(self._gadgets_player))
	{
		return 0;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return 0;
	}
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering))
	{
		return 0;
	}
	return self [[level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering]](slot);
}

/*
	Name: give_gadget
	Namespace: ability_player
	Checksum: 0x4CFD3653
	Offset: 0x1DE8
	Size: 0x28A
	Parameters: 2
	Flags: Linked
*/
function give_gadget(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(isdefined(self._gadgets_player[slot]))
	{
		if(self._gadgets_player[slot] != weapon)
		{
			self.pers[#"hash_68cdf8807cfaabff"][self._gadgets_player[slot]] = 0;
		}
		self take_gadget(slot, self._gadgets_player[slot]);
	}
	for(eslot = 0; eslot < 3; eslot++)
	{
		existinggadget = self._gadgets_player[eslot];
		if(isdefined(existinggadget) && existinggadget == weapon)
		{
			self take_gadget(eslot, existinggadget);
		}
	}
	self._gadgets_player[slot] = weapon;
	if(!isdefined(self.var_aec4af05[slot]))
	{
		self.var_aec4af05[slot] = 0;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give))
		{
			foreach(on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)
			{
				self thread [[on_give]](slot, weapon);
			}
		}
	}
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self.heroabilityname = (isdefined(weapon) ? weapon.name : undefined);
	}
}

/*
	Name: take_gadget
	Namespace: ability_player
	Checksum: 0x700016AA
	Offset: 0x2080
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function take_gadget(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take))
		{
			foreach(on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)
			{
				if(isdefined(on_take))
				{
					self thread [[on_take]](slot, weapon);
				}
			}
		}
	}
	self._gadgets_player[slot] = undefined;
}

/*
	Name: turn_gadget_on
	Namespace: ability_player
	Checksum: 0x672CBFC6
	Offset: 0x21B8
	Size: 0x60C
	Parameters: 2
	Flags: Linked
*/
function turn_gadget_on(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	if(weapon != self._gadgets_player[slot])
	{
		return;
	}
	self.var_aec4af05[slot] = 0;
	self gadgetsetactivatetime(slot, gettime());
	self.playedgadgetsuccess = 0;
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on))
		{
			self function_2c464c28(weapon);
			var_ef2d7dfd = self function_880f27a7();
			players = util::get_active_players(self.team);
			clientnum = self getentitynumber();
			foreach(player in players)
			{
				player luinotifyevent(#"hash_a2cf40647d18112", 2, var_ef2d7dfd, clientnum);
			}
			foreach(turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)
			{
				self thread [[turn_on]](slot, weapon);
			}
		}
	}
	if(sessionmodeismultiplayergame())
	{
		if(weapon.name == #"gadget_health_regen")
		{
			var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
			if(isdefined(var_f8e6b703))
			{
				self match_record::inc_stat(#"lives", var_f8e6b703, #"hash_2380fc76594e930d", 1);
			}
		}
		else
		{
			self function_33644ff2(game.timepassed, weapon.name);
		}
	}
	else
	{
		self function_33644ff2(game.timepassed, weapon.name);
	}
	level notify(#"hero_gadget_activated", {#weapon:weapon, #player:self});
	self notify(#"hero_gadget_activated", {#weapon:weapon});
	if(isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_on))
	{
		self thread [[level.cybercom._ability_turn_on]](slot, weapon);
	}
	self.pers[#"herogadgetnotified"][slot] = 0;
	xuid = int(self getxuid(1));
	if(sessionmodeismultiplayergame())
	{
		mpheropowerevents = {#xuid:xuid, #playername:self.name, #powerstate:"activated", #name:self._gadgets_player[slot].name, #gametime:function_f8d53445(), #spawnid:getplayerspawnid(self)};
		function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
	}
	if(isdefined(level.playgadgetactivate))
	{
		self thread [[level.playgadgetactivate]](weapon);
	}
	if(weapon.gadget_type != 11)
	{
		if(isdefined(self.isneardeath) && self.isneardeath == 1)
		{
			if(isdefined(level.heroabilityactivateneardeath))
			{
				self thread [[level.heroabilityactivateneardeath]]();
			}
		}
		self.heroabilityactivatetime = gettime();
		self.heroabilityactive = 1;
		self.heroability = weapon;
	}
	self thread ability_power::power_consume_timer_think(slot, weapon);
}

/*
	Name: turn_gadget_off
	Namespace: ability_player
	Checksum: 0xF9F8F2D8
	Offset: 0x27D0
	Size: 0x43C
	Parameters: 2
	Flags: Linked
*/
function turn_gadget_off(slot, weapon)
{
	if(!isdefined(self) || !isdefined(self._gadgets_player) || !isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	self.var_aec4af05[slot] = 0;
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off))
	{
		self function_3e8bb406(0);
		foreach(turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)
		{
			self thread [[turn_off]](slot, weapon);
			self globallogic_score::function_61254438(weapon);
		}
	}
	if(isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_off))
	{
		self thread [[level.cybercom._ability_turn_off]](slot, weapon);
	}
	if(weapon.gadget_type != 11)
	{
		self.heroabilitydectivatetime = gettime();
		self.heroabilityactive = undefined;
		self.heroability = weapon;
	}
	dead = self.health <= 0;
	if(sessionmodeismultiplayergame())
	{
		if(weapon.name != #"gadget_health_regen")
		{
			self function_79cd8cd6(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
		}
	}
	else
	{
		self function_79cd8cd6(game.timepassed, weapon.name, dead, self.heavyweaponshots, self.heavyweaponhits);
	}
	self notify(#"heroability_off", {#weapon:weapon});
	xuid = int(self getxuid(1));
	if(sessionmodeismultiplayergame())
	{
		mpheropowerevents = {#xuid:xuid, #playername:self.name, #powerstate:"expired", #name:self._gadgets_player[slot].name, #gametime:function_f8d53445(), #spawnid:getplayerspawnid(self)};
		function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
	}
	if(isdefined(level.oldschool) && level.oldschool)
	{
		self takeweapon(weapon);
	}
}

/*
	Name: function_50557027
	Namespace: ability_player
	Checksum: 0x1BE09DC0
	Offset: 0x2C18
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_50557027(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	self.var_aec4af05[slot] = 0;
	self gadgetsetactivatetime(slot, gettime());
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].var_1a7f628d))
	{
		self function_3e8bb406(0);
		foreach(var_1a7f628d in level._gadgets_level[self._gadgets_player[slot].gadget_type].var_1a7f628d)
		{
			self thread [[var_1a7f628d]](slot, weapon);
		}
	}
}

/*
	Name: function_d5260ebe
	Namespace: ability_player
	Checksum: 0x93F829CD
	Offset: 0x2D78
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_d5260ebe(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	self.var_aec4af05[slot] = 0;
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].var_5ade95a3))
	{
		self function_3e8bb406(0);
		foreach(var_5ade95a3 in level._gadgets_level[self._gadgets_player[slot].gadget_type].var_5ade95a3)
		{
			self thread [[var_5ade95a3]](slot, weapon);
		}
	}
}

/*
	Name: gadget_checkheroabilitykill
	Namespace: ability_player
	Checksum: 0xF9391D7D
	Offset: 0x2EC0
	Size: 0x286
	Parameters: 1
	Flags: Linked
*/
function gadget_checkheroabilitykill(attacker)
{
	heroabilitystat = 0;
	if(isdefined(attacker.heroability))
	{
		switch(attacker.heroability.name)
		{
			case "gadget_clone":
			case "gadget_heat_wave":
			case "gadget_armor":
			case "gadget_speed_burst":
			{
				if(isdefined(attacker.heroabilityactive) || (isdefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 100))
				{
					heroabilitystat = 1;
				}
				break;
			}
			case "gadget_resurrect":
			case "gadget_camo":
			{
				if(isdefined(attacker.heroabilityactive) || (isdefined(attacker.heroabilitydectivatetime) && attacker.heroabilitydectivatetime > gettime() - 6000))
				{
					heroabilitystat = 1;
				}
				break;
			}
			case "gadget_vision_pulse":
			{
				if(isdefined(attacker.visionpulsespottedenemytime))
				{
					timecutoff = gettime();
					if(attacker.visionpulsespottedenemytime + 10000 > timecutoff)
					{
						for(i = 0; i < attacker.visionpulsespottedenemy.size; i++)
						{
							spottedenemy = attacker.visionpulsespottedenemy[i];
							if(spottedenemy == self)
							{
								if(self.lastspawntime < attacker.visionpulsespottedenemytime)
								{
									heroabilitystat = 1;
									break;
								}
							}
						}
					}
				}
			}
			case "gadget_combat_efficiency":
			{
				if(isdefined(attacker._gadget_combat_efficiency) && attacker._gadget_combat_efficiency == 1)
				{
					heroabilitystat = 1;
					break;
				}
				else if(isdefined(attacker.combatefficiencylastontime) && attacker.combatefficiencylastontime > gettime() - 100)
				{
					heroabilitystat = 1;
					break;
				}
			}
		}
	}
	return heroabilitystat;
}

/*
	Name: gadget_flicker
	Namespace: ability_player
	Checksum: 0xB9BBD4F2
	Offset: 0x3150
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function gadget_flicker(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker))
	{
		foreach(on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)
		{
			self thread [[on_flicker]](slot, weapon);
		}
	}
}

/*
	Name: gadget_ready
	Namespace: ability_player
	Checksum: 0x15FAC4C0
	Offset: 0x3270
	Size: 0x51C
	Parameters: 2
	Flags: Linked
*/
function gadget_ready(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	type = self._gadgets_player[slot].gadget_type;
	if(isdefined(type) && isdefined(level._gadgets_level[type]) && (isdefined(level._gadgets_level[type].should_notify) && level._gadgets_level[type].should_notify))
	{
		gadget_index = getitemindexfromref(self._gadgets_player[slot].name);
		if(gadget_index > 0)
		{
			iteminfo = getunlockableiteminfofromindex(gadget_index, 1);
			if(iteminfo.itemgroupname === "killstreak")
			{
				return;
			}
			if(isdefined(iteminfo))
			{
				loadoutslotname = iteminfo.loadoutslotname;
				if(isdefined(loadoutslotname) && loadoutslotname == "herogadget")
				{
					self luinotifyevent(#"hero_weapon_received", 1, gadget_index);
					self function_b552ffa9(#"hero_weapon_received", 1, gadget_index);
				}
			}
		}
	}
	if(!isdefined(level.gameended) || !level.gameended)
	{
		if(!self.pers[#"herogadgetnotified"][slot])
		{
			self.pers[#"herogadgetnotified"][slot] = 1;
			if(isdefined(level.playgadgetready))
			{
				self thread [[level.playgadgetready]](weapon);
			}
		}
	}
	if(sessionmodeismultiplayergame())
	{
		if(weapon.name == #"gadget_health_regen")
		{
			var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
			if(isdefined(var_f8e6b703))
			{
				self match_record::inc_stat(#"lives", var_f8e6b703, #"hash_656f3981134db095", 1);
			}
		}
		else
		{
			self function_ac24127(game.timepassed, weapon.name);
		}
	}
	else
	{
		self function_ac24127(game.timepassed, weapon.name);
	}
	xuid = int(self getxuid(1));
	if(sessionmodeismultiplayergame())
	{
		mpheropowerevents = {#xuid:xuid, #playername:self.name, #powerstate:"ready", #name:self._gadgets_player[slot].name, #gametime:function_f8d53445(), #spawnid:getplayerspawnid(self)};
		function_92d1707f(#"hash_2d561b2f8bbe1aac", mpheropowerevents);
	}
	if(isdefined(type) && isdefined(level._gadgets_level[type]) && isdefined(level._gadgets_level[type].on_ready))
	{
		foreach(on_ready in level._gadgets_level[type].on_ready)
		{
			self thread [[on_ready]](slot, weapon);
		}
	}
}

/*
	Name: gadget_primed
	Namespace: ability_player
	Checksum: 0xA13D8F50
	Offset: 0x3798
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function gadget_primed(slot, weapon)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	if(!isdefined(self._gadgets_player[slot]))
	{
		return;
	}
	if(!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type]))
	{
		return;
	}
	if(isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed))
	{
		foreach(on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)
		{
			self thread [[on_primed]](slot, weapon);
		}
	}
}

/*
	Name: function_3d2a352e
	Namespace: ability_player
	Checksum: 0xCE21DF03
	Offset: 0x38B8
	Size: 0xFE
	Parameters: 3
	Flags: Linked
*/
function function_3d2a352e(weapon, var_8be5aa55, var_de825ec6)
{
	/#
		assert(isdefined(var_8be5aa55) && isstring(var_8be5aa55));
	#/
	if(isdefined(var_de825ec6))
	{
		function_fff8c2ac(weapon);
		self.pers[#"hash_2c18b7a9ddcf325c"][weapon].(var_8be5aa55) = gettime() + var_de825ec6 * 1000;
	}
	return isdefined(self.pers[#"hash_2c18b7a9ddcf325c"][weapon].(var_8be5aa55)) && self.pers[#"hash_2c18b7a9ddcf325c"][weapon].(var_8be5aa55) > gettime();
}

/*
	Name: function_fff8c2ac
	Namespace: ability_player
	Checksum: 0x6D7830E4
	Offset: 0x39C0
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_fff8c2ac(weapon)
{
	if(!isdefined(self.pers[#"hash_2c18b7a9ddcf325c"]))
	{
		self.pers[#"hash_2c18b7a9ddcf325c"] = [];
	}
	if(!isdefined(self.pers[#"hash_2c18b7a9ddcf325c"][weapon]))
	{
		self.pers[#"hash_2c18b7a9ddcf325c"][weapon] = spawnstruct();
	}
}

/*
	Name: function_4f74cee6
	Namespace: ability_player
	Checksum: 0xA7346C82
	Offset: 0x3A60
	Size: 0x388
	Parameters: 6
	Flags: None
*/
function function_4f74cee6(slot, weapon, var_8430d11b, var_6c65cb8d, var_eadf8864, var_be7c29a3)
{
	self notify("equip_tutorial_text_" + weapon.name);
	self endon(#"disconnect", #"death", "equip_tutorial_text_" + weapon.name);
	self function_fff8c2ac(weapon);
	while(true)
	{
		if(!self hasweapon(weapon))
		{
			break;
		}
		var_abf7af91 = self gadgetgetslot(weapon);
		if(var_abf7af91 != slot)
		{
			break;
		}
		if(!self gadgetisready(slot))
		{
			break;
		}
		if(self gadgetisprimed(slot))
		{
			break;
		}
		if(self util::gadget_is_in_use(slot))
		{
			break;
		}
		if(self isinvehicle() || self function_8bc54983() || self scene::is_igc_active() || self isplayinganimscripted())
		{
			wait(5);
			continue;
		}
		if(self function_3d2a352e(weapon, "recentlyUsed"))
		{
			wait(5);
			continue;
		}
		if(self function_3d2a352e(weapon, "recentlyEquip"))
		{
			wait(5);
			continue;
		}
		if(self function_3d2a352e(weapon, "recentlyReady"))
		{
			wait(5);
			continue;
		}
		if(!self function_3d2a352e(weapon, "recentlyEquipText") && isdefined(var_6c65cb8d) && isdefined(var_be7c29a3) && self [[var_be7c29a3]](slot, weapon))
		{
			self function_3d2a352e(weapon, "recentlyEquipText", 60);
			self thread [[var_6c65cb8d]](var_8430d11b, 0, "hide_gadget_equip_hint", 7);
			/#
				self function_374c4352(var_8430d11b);
			#/
		}
		if(!self function_3d2a352e(weapon, "recentlyReadyVoice") && isdefined(var_eadf8864))
		{
			self function_3d2a352e(weapon, "recentlyReadyVoice", 60);
			function_58ca2822(var_eadf8864, self, undefined);
			/#
				self function_374c4352(var_eadf8864);
			#/
		}
		wait(5);
	}
}

/*
	Name: function_fc4dc54
	Namespace: ability_player
	Checksum: 0x4984F208
	Offset: 0x3DF0
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function function_fc4dc54(var_6fcde3b6 = 0)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	for(slot = 0; slot < 3; slot++)
	{
		if(!isdefined(self._gadgets_player[slot]))
		{
			continue;
		}
		gadgetweapon = self._gadgets_player[slot];
		if(ability_util::is_hero_weapon(gadgetweapon))
		{
			continue;
		}
		self gadgetdeactivate(slot, gadgetweapon);
	}
	self forceoffhandend();
}

/*
	Name: function_374c4352
	Namespace: ability_player
	Checksum: 0xAAFAF4C4
	Offset: 0x3EC8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_374c4352(str)
{
	/#
		if(function_7a600918(str))
		{
			str = function_9e72a96(str);
		}
		toprint = "" + str;
		println(toprint);
	#/
}

/*
	Name: abilities_print
	Namespace: ability_player
	Checksum: 0x5900FBCB
	Offset: 0x3F40
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function abilities_print(str)
{
	/#
		toprint = "" + str;
		println(toprint);
	#/
}

/*
	Name: abilities_devgui_init
	Namespace: ability_player
	Checksum: 0x9CA97CDF
	Offset: 0x3F88
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function abilities_devgui_init()
{
	/#
		setdvar(#"scr_abilities_devgui_cmd", "");
		setdvar(#"scr_abilities_devgui_arg", "");
		setdvar(#"scr_abilities_devgui_player", 0);
		if(isdedicated())
		{
			return;
		}
		level.abilities_devgui_base = "";
		level.abilities_devgui_player_connect = &abilities_devgui_player_connect;
		level.abilities_devgui_player_disconnect = &abilities_devgui_player_disconnect;
		level thread abilities_devgui_think();
	#/
}

/*
	Name: abilities_devgui_player_connect
	Namespace: ability_player
	Checksum: 0x88DA8B34
	Offset: 0x4080
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function abilities_devgui_player_connect()
{
	/#
		if(!isdefined(level.abilities_devgui_base))
		{
			return;
		}
		wait(2);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] != self)
			{
				continue;
			}
			thread abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
			return;
		}
	#/
}

/*
	Name: abilities_devgui_add_player_commands
	Namespace: ability_player
	Checksum: 0xFD79C642
	Offset: 0x4138
	Size: 0x14E
	Parameters: 3
	Flags: None
*/
function abilities_devgui_add_player_commands(root, pname, index)
{
	/#
		add_cmd_with_root = "" + root + pname + "";
		pid = "" + index;
		menu_index = 1;
		if(isdefined(level.abilities_devgui_add_gadgets_custom))
		{
			menu_index = self thread [[level.abilities_devgui_add_gadgets_custom]](root, pname, pid, menu_index);
		}
		else
		{
			util::waittill_can_add_debug_command();
			menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
			util::waittill_can_add_debug_command();
			menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
			util::waittill_can_add_debug_command();
			menu_index = function_2e0162e9(add_cmd_with_root, pid, menu_index);
		}
	#/
}

/*
	Name: abilities_devgui_add_player_command
	Namespace: ability_player
	Checksum: 0x4A0089EF
	Offset: 0x4290
	Size: 0x104
	Parameters: 6
	Flags: None
*/
function abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar)
{
	/#
		if(!isdefined(argdvar))
		{
			argdvar = "";
		}
		var_eece3d04 = "" + "" + "" + pid;
		var_9b1fa683 = "" + "" + "" + cmddvar;
		var_dc0fa12c = "" + "" + "" + argdvar + "";
		util::add_queued_debug_command(root + cmdname + var_eece3d04 + var_9b1fa683 + var_dc0fa12c);
	#/
}

/*
	Name: abilities_devgui_add_power
	Namespace: ability_player
	Checksum: 0x2805F421
	Offset: 0x43A0
	Size: 0x17A
	Parameters: 3
	Flags: None
*/
function abilities_devgui_add_power(add_cmd_with_root, pid, menu_index)
{
	/#
		root = add_cmd_with_root + "" + menu_index + "";
		abilities_devgui_add_player_command(root, pid, "", 1, "", "");
		abilities_devgui_add_player_command(root, pid, "", 2, "", "");
		power = 0;
		while(power <= 1)
		{
			abilities_devgui_add_player_command(root, pid, "" + power, 2, "", "" + power);
			abilities_devgui_add_player_command(root, pid, "" + power, 2, "", "" + power);
			power = power + 0.25;
		}
		menu_index++;
		return menu_index;
	#/
}

/*
	Name: function_2e0162e9
	Namespace: ability_player
	Checksum: 0x693F841F
	Offset: 0x4528
	Size: 0x280
	Parameters: 3
	Flags: None
*/
function function_2e0162e9(add_cmd_with_root, pid, menu_index)
{
	/#
		if(sessionmodeiszombiesgame() || function_f99d2668())
		{
			return;
		}
		root = add_cmd_with_root + "" + menu_index + "";
		session_mode = currentsessionmode();
		var_a2865de6 = getplayerroletemplatecount(session_mode);
		for(i = 1; i < var_a2865de6; i++)
		{
			var_854a6ba2 = getplayerrolecategory(i, session_mode);
			if(!isdefined(var_854a6ba2))
			{
				continue;
			}
			var_d59b8ebf = getplayerrolecategoryinfo(var_854a6ba2);
			var_1a27a47a = makelocalizedstring(getcharacterdisplayname(i, session_mode));
			var_1a27a47a = function_ea13f55(var_1a27a47a, "", "");
			if(var_1a27a47a == "")
			{
				var_1a27a47a = "";
			}
			var_eb49090f = function_9e72a96(function_b14806c6(i, session_mode));
			var_4f6b7b98 = var_1a27a47a + "" + (isdefined(var_eb49090f) ? var_eb49090f : "") + "";
			if(!isdefined(var_d59b8ebf.enabled) || var_d59b8ebf.enabled == 0)
			{
				var_4f6b7b98 = var_4f6b7b98 + "";
			}
			abilities_devgui_add_player_command(root, pid, var_4f6b7b98, i, "", i);
		}
		menu_index++;
		return menu_index;
	#/
}

/*
	Name: function_2ced294
	Namespace: ability_player
	Checksum: 0x9BBA2972
	Offset: 0x47B8
	Size: 0xEC
	Parameters: 3
	Flags: None
*/
function function_2ced294(a_weapons, a_array, weaponname)
{
	/#
		weapon = getweapon(weaponname);
		if(!isdefined(weapon))
		{
			return;
		}
		if(!isinarray(a_weapons, weapon))
		{
			return;
		}
		if(!isdefined(a_array))
		{
			a_array = [];
		}
		else if(!isarray(a_array))
		{
			a_array = array(a_array);
		}
		if(!isinarray(a_array, weapon))
		{
			a_array[a_array.size] = weapon;
		}
		arrayremovevalue(a_weapons, weapon);
	#/
}

/*
	Name: function_60b82b68
	Namespace: ability_player
	Checksum: 0x44A899D5
	Offset: 0x48B0
	Size: 0x166
	Parameters: 4
	Flags: None
*/
function function_60b82b68(a_weapons, var_5e5ad048, var_c5b1a23e, var_ec1d48cc)
{
	/#
		if(sessionmodeiszombiesgame())
		{
			return;
		}
		session_mode = currentsessionmode();
		var_a2865de6 = getplayerroletemplatecount(session_mode);
		for(i = 1; i < var_a2865de6; i++)
		{
			fields = function_934db9a0(i, session_mode);
			if(!isdefined(fields))
			{
				continue;
			}
			if(isdefined(fields.var_a7e7cb46))
			{
				function_2ced294(a_weapons, var_5e5ad048, fields.var_a7e7cb46);
			}
			if(isdefined(fields.var_c21d61e9))
			{
				function_2ced294(a_weapons, var_c5b1a23e, fields.var_c21d61e9);
			}
			if(isdefined(fields.var_ec20b2a))
			{
				function_2ced294(a_weapons, var_ec1d48cc, fields.var_ec20b2a);
			}
		}
	#/
}

/*
	Name: function_1c3e8791
	Namespace: ability_player
	Checksum: 0x5EA19E9B
	Offset: 0x4A20
	Size: 0xC6
	Parameters: 2
	Flags: None
*/
function function_1c3e8791(a_weapons, var_dd06e779)
{
	/#
		for(i = 0; i < 1024; i++)
		{
			iteminfo = getunlockableiteminfofromindex(i, 0);
			if(isdefined(iteminfo))
			{
				reference_s = iteminfo.var_3cf2d21;
				loadoutslotname = iteminfo.loadoutslotname;
				if(loadoutslotname == "")
				{
					function_2ced294(a_weapons, var_dd06e779, reference_s);
				}
			}
		}
	#/
}

/*
	Name: abilities_devgui_add_gadgets
	Namespace: ability_player
	Checksum: 0x8F93A2D2
	Offset: 0x4AF0
	Size: 0x5F6
	Parameters: 3
	Flags: None
*/
function abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index)
{
	/#
		a_weapons = enumerateweapons("");
		var_6b97f6f9 = [];
		for(i = 0; i < a_weapons.size; i++)
		{
			if(isdefined(a_weapons[i]) && a_weapons[i].isgadget)
			{
				if(!isdefined(var_6b97f6f9))
				{
					var_6b97f6f9 = [];
				}
				else if(!isarray(var_6b97f6f9))
				{
					var_6b97f6f9 = array(var_6b97f6f9);
				}
				if(!isinarray(var_6b97f6f9, a_weapons[i]))
				{
					var_6b97f6f9[var_6b97f6f9.size] = a_weapons[i];
				}
			}
		}
		var_5e5ad048 = [];
		var_c5b1a23e = [];
		var_ec1d48cc = [];
		function_60b82b68(var_6b97f6f9, var_5e5ad048, var_c5b1a23e, var_ec1d48cc);
		var_dd06e779 = [];
		function_1c3e8791(var_6b97f6f9, var_dd06e779);
		var_ef060ee3 = [];
		var_cdbfed45 = [];
		var_7e367d09 = [];
		var_4557f227 = [];
		var_fa6298dc = [];
		for(i = 0; i < var_6b97f6f9.size; i++)
		{
			if(var_6b97f6f9[i].gadget_type == 11 && var_6b97f6f9[i].var_b76e0a09)
			{
				if(!isdefined(var_ef060ee3))
				{
					var_ef060ee3 = [];
				}
				else if(!isarray(var_ef060ee3))
				{
					var_ef060ee3 = array(var_ef060ee3);
				}
				if(!isinarray(var_ef060ee3, var_6b97f6f9[i]))
				{
					var_ef060ee3[var_ef060ee3.size] = var_6b97f6f9[i];
				}
				continue;
			}
			if(var_6b97f6f9[i].gadget_type == 11)
			{
				if(!isdefined(var_cdbfed45))
				{
					var_cdbfed45 = [];
				}
				else if(!isarray(var_cdbfed45))
				{
					var_cdbfed45 = array(var_cdbfed45);
				}
				if(!isinarray(var_cdbfed45, var_6b97f6f9[i]))
				{
					var_cdbfed45[var_cdbfed45.size] = var_6b97f6f9[i];
				}
				continue;
			}
			if(var_6b97f6f9[i].isheavyweapon)
			{
				if(!isdefined(var_7e367d09))
				{
					var_7e367d09 = [];
				}
				else if(!isarray(var_7e367d09))
				{
					var_7e367d09 = array(var_7e367d09);
				}
				if(!isinarray(var_7e367d09, var_6b97f6f9[i]))
				{
					var_7e367d09[var_7e367d09.size] = var_6b97f6f9[i];
				}
				continue;
			}
			if(var_6b97f6f9[i].gadget_type == 23)
			{
				if(!isdefined(var_fa6298dc))
				{
					var_fa6298dc = [];
				}
				else if(!isarray(var_fa6298dc))
				{
					var_fa6298dc = array(var_fa6298dc);
				}
				if(!isinarray(var_fa6298dc, var_6b97f6f9[i]))
				{
					var_fa6298dc[var_fa6298dc.size] = var_6b97f6f9[i];
				}
				continue;
			}
			if(!isdefined(var_4557f227))
			{
				var_4557f227 = [];
			}
			else if(!isarray(var_4557f227))
			{
				var_4557f227 = array(var_4557f227);
			}
			if(!isinarray(var_4557f227, var_6b97f6f9[i]))
			{
				var_4557f227[var_4557f227.size] = var_6b97f6f9[i];
			}
		}
		function_174037fe(add_cmd_with_root, pid, var_5e5ad048, "", menu_index);
		menu_index++;
		function_76032a31(add_cmd_with_root, pid, var_fa6298dc, "", menu_index);
		menu_index++;
		function_a40d04ca(add_cmd_with_root, pid, var_c5b1a23e, "", menu_index);
		menu_index++;
		function_174037fe(add_cmd_with_root, pid, var_dd06e779, "", menu_index);
		menu_index++;
		function_174037fe(add_cmd_with_root, pid, var_4557f227, "", menu_index);
		menu_index++;
		function_a40d04ca(add_cmd_with_root, pid, var_ef060ee3, "", menu_index);
		menu_index++;
		return menu_index;
	#/
}

/*
	Name: function_174037fe
	Namespace: ability_player
	Checksum: 0xCB8A6DE1
	Offset: 0x50F0
	Size: 0xBE
	Parameters: 5
	Flags: None
*/
function function_174037fe(root, pid, a_weapons, weapon_type, menu_index)
{
	/#
		if(isdefined(a_weapons))
		{
			player_devgui_root = root + weapon_type + "";
			for(i = 0; i < a_weapons.size; i++)
			{
				function_b04fbf27(player_devgui_root, pid, function_a16a090d(a_weapons[i]), i + 1);
			}
		}
	#/
}

/*
	Name: function_76032a31
	Namespace: ability_player
	Checksum: 0xF8D18C25
	Offset: 0x51B8
	Size: 0xBE
	Parameters: 5
	Flags: None
*/
function function_76032a31(root, pid, a_weapons, weapon_type, menu_index)
{
	/#
		if(isdefined(a_weapons))
		{
			player_devgui_root = root + weapon_type + "";
			for(i = 0; i < a_weapons.size; i++)
			{
				function_50543efb(player_devgui_root, pid, function_a16a090d(a_weapons[i]), i + 1);
			}
		}
	#/
}

/*
	Name: function_a40d04ca
	Namespace: ability_player
	Checksum: 0xBCE880A7
	Offset: 0x5280
	Size: 0xBE
	Parameters: 5
	Flags: None
*/
function function_a40d04ca(root, pid, a_weapons, weapon_type, menu_index)
{
	/#
		if(isdefined(a_weapons))
		{
			player_devgui_root = root + weapon_type + "";
			for(i = 0; i < a_weapons.size; i++)
			{
				function_90502d72(player_devgui_root, pid, function_a16a090d(a_weapons[i]), i + 1);
			}
		}
	#/
}

/*
	Name: function_b04fbf27
	Namespace: ability_player
	Checksum: 0xDFC7E4B7
	Offset: 0x5348
	Size: 0xAC
	Parameters: 4
	Flags: None
*/
function function_b04fbf27(root, pid, weap_name, cmdindex)
{
	/#
		util::add_queued_debug_command(root + weap_name + "" + "" + "" + pid + "" + "" + "" + "" + "" + "" + "" + weap_name + "");
	#/
}

/*
	Name: function_50543efb
	Namespace: ability_player
	Checksum: 0x4E3032BE
	Offset: 0x5400
	Size: 0xAC
	Parameters: 4
	Flags: None
*/
function function_50543efb(root, pid, weap_name, cmdindex)
{
	/#
		util::add_queued_debug_command(root + weap_name + "" + "" + "" + pid + "" + "" + "" + "" + "" + "" + "" + weap_name + "");
	#/
}

/*
	Name: function_90502d72
	Namespace: ability_player
	Checksum: 0x7BC91EE0
	Offset: 0x54B8
	Size: 0xAC
	Parameters: 4
	Flags: None
*/
function function_90502d72(root, pid, weap_name, cmdindex)
{
	/#
		util::add_queued_debug_command(root + weap_name + "" + "" + "" + pid + "" + "" + "" + "" + "" + "" + "" + weap_name + "");
	#/
}

/*
	Name: abilities_devgui_player_disconnect
	Namespace: ability_player
	Checksum: 0xD37BA103
	Offset: 0x5570
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function abilities_devgui_player_disconnect()
{
	/#
		if(!isdefined(level.abilities_devgui_base))
		{
			return;
		}
		remove_cmd_with_root = "" + level.abilities_devgui_base + self.playername + "";
		util::add_queued_debug_command(remove_cmd_with_root);
	#/
}

/*
	Name: abilities_devgui_think
	Namespace: ability_player
	Checksum: 0x5833D8B3
	Offset: 0x55D8
	Size: 0x368
	Parameters: 0
	Flags: None
*/
function abilities_devgui_think()
{
	/#
		setdvar(#"hash_67d528f29bfc7c97", "");
		for(;;)
		{
			cmd = "";
			arg = getdvarstring(#"hash_67d528f29bfc7c97", "");
			if(arg == "")
			{
				cmd = getdvarstring(#"scr_abilities_devgui_cmd");
				arg = getdvarstring(#"scr_abilities_devgui_arg");
			}
			if(cmd == "")
			{
				waitframe(1);
				continue;
			}
			switch(cmd)
			{
				case "power_f":
				{
					abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
					break;
				}
				case "power_t_af":
				{
					abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
					break;
				}
				case "hash_5c13c5720e67cf5e":
				{
					abilities_devgui_handle_player_command(cmd, &function_3db3dc4f, arg);
					break;
				}
				case "hash_5b8a32e219f9ae64":
				{
					abilities_devgui_handle_player_command(cmd, &function_626f2cd1, arg);
					break;
				}
				case "hash_2d2f6f2bb98a38b3":
				{
					abilities_devgui_handle_player_command(cmd, &function_9a0f80b1, arg);
					break;
				}
				case "hash_5ddbad8870b98e93":
				{
					abilities_devgui_handle_player_command(cmd, &function_ce4e80a7, arg);
					break;
				}
				case "hash_5515835378aa90c8":
				{
					abilities_devgui_handle_player_command(cmd, &function_4f50aea3, arg);
					break;
				}
				case "hash_67d528f29bfc7c97":
				{
					abilities_devgui_handle_player_command(cmd, &function_b4f43681, arg);
					break;
				}
				case 0:
				{
					break;
				}
				default:
				{
					break;
				}
			}
			setdvar(#"hash_67d528f29bfc7c97", "");
			setdvar(#"scr_abilities_devgui_cmd", "");
			setdvar(#"scr_abilities_devgui_player", "");
			wait(0.5);
		}
	#/
}

/*
	Name: function_c94ba490
	Namespace: ability_player
	Checksum: 0x9FE7E0A
	Offset: 0x5948
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function function_c94ba490(weapon)
{
	/#
		self notify(#"gadget_devgui_give");
		self giveweapon(weapon);
		waitframe(1);
		slot = self gadgetgetslot(weapon);
		self gadgetpowerreset(slot, 1);
		self gadgetpowerset(slot, 100);
		self gadgetcharging(slot, 0);
		if(isbot(self))
		{
			self bot_action::function_ee2eaccc(slot);
		}
		self iprintlnbold(function_a16a090d(weapon));
	#/
}

/*
	Name: abilities_devgui_give
	Namespace: ability_player
	Checksum: 0xF0E6DD05
	Offset: 0x5A68
	Size: 0xE6
	Parameters: 3
	Flags: None
*/
function abilities_devgui_give(weapon_name, slot, var_1d6918cf)
{
	/#
		level.devgui_giving_abilities = 1;
		if(isdefined(self._gadgets_player[slot]) && self hasweapon(self._gadgets_player[slot]))
		{
			self gadgetpowerreset(slot, 1);
			self takeweapon(self._gadgets_player[slot]);
		}
		weapon = getweapon(weapon_name);
		self thread function_c94ba490(weapon);
		level.devgui_giving_abilities = undefined;
	#/
}

/*
	Name: function_4f50aea3
	Namespace: ability_player
	Checksum: 0x630DC8B0
	Offset: 0x5B58
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_4f50aea3(weapon_name)
{
	/#
		if(isdefined(level.var_124446e) && isarray(level.var_124446e) && isdefined(level.var_124446e[weapon_name]))
		{
			self [[level.var_124446e[weapon_name]]](self, 2);
		}
		else if(isdefined(level.var_124446e))
		{
			self [[level.var_124446e]](weapon_name, 2);
		}
		else
		{
			self abilities_devgui_give(weapon_name, 2);
		}
	#/
}

/*
	Name: function_ce4e80a7
	Namespace: ability_player
	Checksum: 0xB0256FE1
	Offset: 0x5C28
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_ce4e80a7(weapon_name)
{
	/#
		if(isdefined(level.var_c49b362f) && isdefined(level.var_c49b362f[weapon_name]))
		{
			self [[level.var_c49b362f[weapon_name]]](self, 1);
		}
		else
		{
			self abilities_devgui_give(weapon_name, 1);
		}
	#/
}

/*
	Name: function_9a0f80b1
	Namespace: ability_player
	Checksum: 0x74FA9703
	Offset: 0x5CA8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_9a0f80b1(weapon_name)
{
	/#
		if(isdefined(level.var_fdfc376e) && isdefined(level.var_fdfc376e[weapon_name]))
		{
			self [[level.var_fdfc376e[weapon_name]]](self, 0);
		}
		else
		{
			self abilities_devgui_give(weapon_name, 0);
		}
	#/
}

/*
	Name: function_f3fa2789
	Namespace: ability_player
	Checksum: 0x8570C495
	Offset: 0x5D28
	Size: 0x134
	Parameters: 2
	Flags: None
*/
function function_f3fa2789(offhandslot, var_f0242d8a)
{
	/#
		if(!isdefined(var_f0242d8a))
		{
			var_f0242d8a = level.var_29d4fb5b;
		}
		if(!isdefined(var_f0242d8a))
		{
			return;
		}
		weapon = undefined;
		if(isdefined(self._gadgets_player[offhandslot]))
		{
			weapon = self._gadgets_player[offhandslot];
		}
		weapon_name = undefined;
		if(isdefined(weapon))
		{
			var_29bc3853 = 0;
			for(i = 0; i < var_f0242d8a.size; i++)
			{
				ability_name = var_f0242d8a[i];
				if(weapon.name == ability_name)
				{
					var_29bc3853 = i;
					break;
				}
			}
			var_29bc3853 = var_29bc3853 + 1 % var_f0242d8a.size;
			weapon_name = var_f0242d8a[var_29bc3853];
		}
		if(2 == offhandslot)
		{
			self function_4f50aea3(weapon_name);
		}
	#/
}

/*
	Name: abilities_devgui_handle_player_command
	Namespace: ability_player
	Checksum: 0xC3708A52
	Offset: 0x5E68
	Size: 0xE4
	Parameters: 3
	Flags: None
*/
function abilities_devgui_handle_player_command(cmd, playercallback, pcb_param)
{
	/#
		pid = getdvarint(#"scr_abilities_devgui_player", 0);
		if(pid > 0)
		{
			player = getplayers()[pid - 1];
			if(isdefined(player))
			{
				if(isdefined(pcb_param))
				{
					player thread [[playercallback]](pcb_param);
				}
				else
				{
					player thread [[playercallback]]();
				}
			}
		}
		else
		{
			array::thread_all(getplayers(), playercallback, pcb_param);
		}
	#/
}

/*
	Name: abilities_devgui_power_fill
	Namespace: ability_player
	Checksum: 0x608E1B25
	Offset: 0x5F58
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function abilities_devgui_power_fill()
{
	/#
		if(!isdefined(self) || !isdefined(self._gadgets_player))
		{
			return;
		}
		for(i = 0; i < 3; i++)
		{
			if(isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i]))
			{
				self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
			}
		}
	#/
}

/*
	Name: function_626f2cd1
	Namespace: ability_player
	Checksum: 0x593FD4BB
	Offset: 0x6010
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_626f2cd1(var_44b235)
{
	/#
		if(!isdefined(self) || !isdefined(self._gadgets_player))
		{
			return;
		}
		if(isdefined(self._gadgets_player[0]) && self hasweapon(self._gadgets_player[0]))
		{
			self gadgetpowerset(0, self._gadgets_player[0].gadget_powermax * float(var_44b235));
		}
	#/
}

/*
	Name: function_3db3dc4f
	Namespace: ability_player
	Checksum: 0x6CDBCB0A
	Offset: 0x60B8
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_3db3dc4f(var_44b235)
{
	/#
		if(!isdefined(self) || !isdefined(self._gadgets_player))
		{
			return;
		}
		if(isdefined(self._gadgets_player[2]) && self hasweapon(self._gadgets_player[2]))
		{
			self gadgetpowerset(2, self._gadgets_player[2].gadget_powermax * float(var_44b235));
		}
	#/
}

/*
	Name: abilities_devgui_power_toggle_auto_fill
	Namespace: ability_player
	Checksum: 0xB9B96759
	Offset: 0x6170
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function abilities_devgui_power_toggle_auto_fill()
{
	/#
		if(!isdefined(self) || !isdefined(self._gadgets_player))
		{
			return;
		}
		self.abilities_devgui_power_toggle_auto_fill = !(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
		self thread abilities_devgui_power_toggle_auto_fill_think();
	#/
}

/*
	Name: abilities_devgui_power_toggle_auto_fill_think
	Namespace: ability_player
	Checksum: 0xAC18B77A
	Offset: 0x61D8
	Size: 0x178
	Parameters: 0
	Flags: None
*/
function abilities_devgui_power_toggle_auto_fill_think()
{
	/#
		self endon(#"disconnect");
		self notify(#"auto_fill_think");
		self endon(#"auto_fill_think");
		for(;;)
		{
			if(!isdefined(self) || !isdefined(self._gadgets_player))
			{
				return;
			}
			if(!(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill))
			{
				return;
			}
			for(i = 0; i < 3; i++)
			{
				if(isdefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i]))
				{
					n_power = self gadgetpowerget(i);
					if(!self util::gadget_is_in_use(i) && !self function_36dfc05f(i) && n_power < self._gadgets_player[i].gadget_powermax)
					{
						self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
					}
				}
			}
			wait(1);
		}
	#/
}

/*
	Name: function_b4f43681
	Namespace: ability_player
	Checksum: 0xB7E57A02
	Offset: 0x6358
	Size: 0x378
	Parameters: 1
	Flags: None
*/
function function_b4f43681(var_a5c8eb94)
{
	/#
		if(sessionmodeiszombiesgame())
		{
			return;
		}
		if(self isinmovemode(""))
		{
			adddebugcommand("");
			wait(0.5);
		}
		if(self isinmovemode(""))
		{
			adddebugcommand("");
			wait(0.5);
		}
		if(var_a5c8eb94 == "")
		{
			startindex = self player_role::get();
			index = startindex;
			do
			{
				index = index + 1;
				if(index == startindex)
				{
					return;
				}
				if(index >= getplayerroletemplatecount(currentsessionmode()))
				{
					index = 0;
				}
			}
			while(!self player_role::is_valid(index));
		}
		else if(var_a5c8eb94 == "")
		{
			startindex = self player_role::get();
			index = startindex;
			do
			{
				index = index - 1;
				if(index == startindex)
				{
					return;
				}
				if(index == 0)
				{
					index = getplayerroletemplatecount(currentsessionmode());
				}
			}
			while(!self player_role::is_valid(index));
		}
		else
		{
			index = int(var_a5c8eb94);
		}
		self function_c9b950e3();
		self function_c2d9d3e1();
		self player_role::set(index);
		if(sessionmodeismultiplayergame() || function_f99d2668())
		{
			spawnselect = level.spawnselectenabled;
			level.spawnselectenabled = 0;
			if(level.numlives)
			{
				self.pers[#"lives"]++;
			}
			self suicide("");
			waitframe(1);
			if(isdefined(self))
			{
				self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
			}
			level.spawnselectenabled = spawnselect;
		}
		else if(sessionmodeiscampaigngame())
		{
			if(isdefined(level.var_86734d48))
			{
				self thread [[level.var_86734d48]](self.team, self.curclass);
			}
		}
	#/
}

