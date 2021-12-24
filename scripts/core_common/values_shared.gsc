// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\string_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace val;

/*
	Name: function_89f2df9
	Namespace: val
	Checksum: 0x65E81D0E
	Offset: 0x200
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"values", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: val
	Checksum: 0x4DDC18F9
	Offset: 0x248
	Size: 0x684
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	register("takedamage", 1, "$self", &set_takedamage, "$value");
	default_func("takedamage", "$self", &default_takedamage);
	register("allowdeath", 1);
	default_func("allowdeath", "$self", &function_d5397f5b);
	register("ignoreme", 1, "$self", &set_ignoreme, "$value");
	default_value("ignoreme", 0);
	register("ignoreall", 1);
	default_value("ignoreall", 0);
	register("take_weapons", 1, "$self", &set_takeweapons, "$value");
	default_value("take_weapons", 0);
	register("disable_weapons", 1, "$self", &set_disableweapons, "$value");
	default_value("disable_weapons", 0);
	register("disable_offhand_weapons", 1, "$self", &function_9492c418, "$value");
	default_value("disable_offhand_weapons", 0);
	register("freezecontrols", 1, "$self", &freezecontrols, "$value");
	default_value("freezecontrols", 0);
	register("freezecontrols_allowlook", 1, "$self", &freezecontrolsallowlook, "$value");
	default_value("freezecontrols_allowlook", 0);
	register("disablegadgets", 1, "$self", &function_cd5fec49, "$value");
	default_value("disablegadgets", 0);
	register("hide", 1, "$self", &function_b981952a, "$value");
	default_value("hide", 0);
	register("health_regen", 1, "$self", &function_a8c51b69, "$value");
	default_value("health_regen", 1);
	register("disable_health_regen_delay", 1, "$self", &function_a89d2031, "$value");
	default_value("disable_health_regen_delay", 0);
	register("ignore_health_regen_delay", 1, "$self", &function_ee2e556b, "$value");
	default_value("ignore_health_regen_delay", 0);
	register("show_hud", 1, "$self", &setclientuivisibilityflag, "hud_visible", "$value");
	default_value("show_hud", 1);
	register("show_weapon_hud", 1, "$self", &setclientuivisibilityflag, "weapon_hud_visible", "$value");
	default_value("show_weapon_hud", 1);
	register("disable_gestures", 1, "$self", &function_8210793d, "$value");
	default_value("disable_gestures", 0);
	/#
		level thread debug_values();
		validate("", "", &validate_takedamage);
		validate("", "", &arecontrolsfrozen);
		validate("", "", &function_5972c3cf);
		validate("", "", &function_cd5fec49);
		validate("", "", &ishidden);
	#/
}

/*
	Name: register
	Namespace: val
	Checksum: 0x5B2CF81
	Offset: 0x8D8
	Size: 0x15E
	Parameters: 5
	Flags: Linked, Variadic
*/
function register(str_name, var_3509ed3e, call_on = "$self", func, vararg)
{
	if(!isdefined(level.values))
	{
		level.values = [];
	}
	a_registered = getarraykeys(level.values);
	if(isinarray(a_registered, hash(str_name)))
	{
		/#
			assertmsg(("" + str_name) + "");
		#/
		return;
	}
	s_value = spawnstruct();
	s_value.str_name = str_name;
	s_value.call_on = call_on;
	s_value.func = func;
	s_value.var_3509ed3e = var_3509ed3e;
	s_value.a_args = vararg;
	level.values[str_name] = s_value;
}

/*
	Name: assert_registered
	Namespace: val
	Checksum: 0xE7DBDDD8
	Offset: 0xA40
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
private function assert_registered(str_name)
{
	/#
		a_registered = getarraykeys(level.values);
		if(!isinarray(a_registered, hash(str_name)))
		{
			/#
				assertmsg(("" + str_name) + "");
			#/
			return 0;
		}
	#/
	return 1;
}

/*
	Name: default_func
	Namespace: val
	Checksum: 0x9CE9CB4A
	Offset: 0xAE0
	Size: 0x86
	Parameters: 4
	Flags: Linked, Variadic
*/
function default_func(str_name, call_on, value, vararg)
{
	if(assert_registered(str_name))
	{
		s_value = level.values[str_name];
		s_value.default_call_on = call_on;
		s_value.default_value = value;
		s_value.default_args = vararg;
	}
}

/*
	Name: default_value
	Namespace: val
	Checksum: 0x1500819E
	Offset: 0xB70
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function default_value(str_name, value)
{
	if(assert_registered(str_name))
	{
		s_value = level.values[str_name];
		s_value.default_value = value;
	}
}

/*
	Name: set
	Namespace: val
	Checksum: 0xA0596F05
	Offset: 0xBD0
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function set(str_id, str_name, value)
{
	if(assert_registered(str_name))
	{
		if(!isdefined(value))
		{
			value = level.values[str_name].var_3509ed3e;
		}
		_push_value(str_id, str_name, value);
		_set_value(str_name, value);
	}
}

/*
	Name: set_for_time
	Namespace: val
	Checksum: 0xFEE735F2
	Offset: 0xC68
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function set_for_time(n_time, str_id, str_name, value)
{
	self endon(#"death");
	set(str_id, str_name, value);
	wait(n_time);
	reset(str_id, str_name);
}

/*
	Name: reset
	Namespace: val
	Checksum: 0xC649C637
	Offset: 0xCE8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function reset(str_id, str_name)
{
	n_index = _remove_value(str_id, str_name);
	if(!n_index)
	{
		if(isdefined(self.values) && isdefined(self.values[str_name]) && self.values[str_name].size > 0)
		{
			_set_value(str_name, self.values[str_name][0].value);
		}
		else
		{
			_set_default(str_name);
		}
	}
}

/*
	Name: nuke
	Namespace: val
	Checksum: 0xF7A497C
	Offset: 0xDB0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function nuke(str_name)
{
	self.values[str_name] = [];
	_set_default(str_name);
}

/*
	Name: _push_value
	Namespace: val
	Checksum: 0x1419FBFF
	Offset: 0xDF0
	Size: 0xBC
	Parameters: 3
	Flags: Linked, Private
*/
private function _push_value(str_id, str_name, value)
{
	_remove_value(str_id, str_name);
	if(!isdefined(self.values))
	{
		self.values = [];
	}
	if(!isdefined(self.values[str_name]))
	{
		self.values[str_name] = [];
	}
	arrayinsert(self.values[str_name], {#value:value, #str_id:str_id}, 0);
}

/*
	Name: _remove_value
	Namespace: val
	Checksum: 0x2C1F3140
	Offset: 0xEB8
	Size: 0x10E
	Parameters: 2
	Flags: Linked, Private
*/
private function _remove_value(str_id, str_name)
{
	if(!isdefined(self))
	{
		return -1;
	}
	if(isdefined(self.values) && isdefined(self.values[str_name]))
	{
		for(n_index = self.values[str_name].size - 1; n_index >= 0; n_index--)
		{
			if(self.values[str_name][n_index].str_id == str_id)
			{
				arrayremoveindex(self.values[str_name], n_index);
				break;
			}
		}
		if(!self.values[str_name].size)
		{
			self.values[str_name] = undefined;
			if(!self.values.size)
			{
				self.values = undefined;
			}
		}
	}
	return (isdefined(n_index) ? n_index : -1);
}

/*
	Name: _set_value
	Namespace: val
	Checksum: 0xD30301DE
	Offset: 0xFD0
	Size: 0xD8
	Parameters: 2
	Flags: Linked, Private
*/
private function _set_value(str_name, value)
{
	s_value = level.values[str_name];
	if(isdefined(s_value) && isdefined(s_value.func))
	{
		call_on = (s_value.call_on === "$self" ? self : s_value.call_on);
		util::single_func_argarray(call_on, s_value.func, _replace_values(s_value.a_args, value));
	}
	else
	{
		self.(str_name) = value;
	}
}

/*
	Name: _set_default
	Namespace: val
	Checksum: 0x7F63899B
	Offset: 0x10B0
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
private function _set_default(str_name)
{
	s_value = level.values[str_name];
	if(isdefined(s_value.default_value))
	{
		if(isfunctionptr(s_value.default_value))
		{
			call_on = (s_value.default_call_on === "$self" ? self : s_value.default_call_on);
			default_value = util::single_func_argarray(call_on, s_value.default_value, _replace_values(s_value.default_args));
		}
		else
		{
			default_value = s_value.default_value;
		}
		_set_value(str_name, default_value);
	}
}

/*
	Name: _replace_values
	Namespace: val
	Checksum: 0xCD3262CB
	Offset: 0x11C0
	Size: 0x5A
	Parameters: 2
	Flags: Linked, Private
*/
private function _replace_values(a_args, value)
{
	a_args = array::replace(a_args, "$self", self);
	a_args = array::replace(a_args, "$value", value);
	return a_args;
}

/*
	Name: set_takedamage
	Namespace: val
	Checksum: 0x9F56E7ED
	Offset: 0x1228
	Size: 0x7E
	Parameters: 1
	Flags: Linked, Private
*/
private function set_takedamage(b_value = 1)
{
	if(isplayer(self))
	{
		if(b_value)
		{
			self disableinvulnerability();
		}
		else
		{
			self enableinvulnerability();
		}
	}
	else
	{
		self.takedamage = b_value;
	}
}

/*
	Name: default_takedamage
	Namespace: val
	Checksum: 0x827FA1ED
	Offset: 0x12B0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function default_takedamage()
{
	return issentient(self) || isvehicle(self);
}

/*
	Name: function_d5397f5b
	Namespace: val
	Checksum: 0x5149C9C3
	Offset: 0x12F0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_d5397f5b()
{
	return issentient(self) || isvehicle(self);
}

/*
	Name: validate_takedamage
	Namespace: val
	Checksum: 0x45EAE5F
	Offset: 0x1330
	Size: 0x42
	Parameters: 0
	Flags: Private
*/
private function validate_takedamage()
{
	if(isplayer(self))
	{
		return !self getinvulnerability();
	}
	return self.takedamage;
}

/*
	Name: set_takeweapons
	Namespace: val
	Checksum: 0x2E1E25A9
	Offset: 0x1380
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
private function set_takeweapons(b_value = 1)
{
	if(b_value)
	{
		if(!(isdefined(self.gun_removed) && self.gun_removed))
		{
			if(isplayer(self))
			{
				self player::take_weapons();
			}
			else
			{
				self animation::detach_weapon();
			}
		}
	}
	else if(isplayer(self))
	{
		self player::give_back_weapons();
	}
	else
	{
		self animation::attach_weapon();
	}
}

/*
	Name: set_disableweapons
	Namespace: val
	Checksum: 0xD28166AF
	Offset: 0x1458
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
private function set_disableweapons(b_value = 1)
{
	if(b_value)
	{
		self disableweapons();
	}
	else
	{
		self enableweapons();
	}
}

/*
	Name: function_9492c418
	Namespace: val
	Checksum: 0xA195CC5C
	Offset: 0x14B8
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9492c418(b_value = 1)
{
	if(b_value)
	{
		self disableoffhandweapons();
	}
	else
	{
		self enableoffhandweapons();
	}
}

/*
	Name: set_ignoreme
	Namespace: val
	Checksum: 0x7FCE6214
	Offset: 0x1518
	Size: 0x92
	Parameters: 1
	Flags: Linked, Private
*/
private function set_ignoreme(b_value = 1)
{
	if(b_value)
	{
		if(function_ffa5b184(self))
		{
			self.var_becd4d91 = 1;
		}
		else
		{
			self.ignoreme = 1;
		}
	}
	else if(function_ffa5b184(self))
	{
		self.var_becd4d91 = 0;
	}
	else
	{
		self.ignoreme = 0;
	}
}

/*
	Name: function_8210793d
	Namespace: val
	Checksum: 0xD4A8E1D3
	Offset: 0x15B8
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8210793d(b_value = 1)
{
	if(isplayer(self))
	{
		self.var_89b32012 = b_value;
	}
}

/*
	Name: function_b981952a
	Namespace: val
	Checksum: 0x6F86A78
	Offset: 0x1608
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b981952a(b_value = 1)
{
	if(b_value)
	{
		if(b_value == 1)
		{
			self hide();
		}
		else
		{
			self ghost();
		}
	}
	else
	{
		self show();
	}
}

/*
	Name: function_a8c51b69
	Namespace: val
	Checksum: 0x11EB3634
	Offset: 0x1688
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a8c51b69(b_value = 1)
{
	if(b_value)
	{
		self.heal.enabled = 1;
	}
	else
	{
		self.heal.enabled = 0;
	}
}

/*
	Name: function_a89d2031
	Namespace: val
	Checksum: 0x8160CB18
	Offset: 0x16E0
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a89d2031(b_value = 1)
{
	if(b_value)
	{
		self.disable_health_regen_delay = 1;
	}
	else
	{
		self.disable_health_regen_delay = 0;
	}
}

/*
	Name: function_ee2e556b
	Namespace: val
	Checksum: 0x6F81C590
	Offset: 0x1730
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ee2e556b(b_value = 1)
{
	if(b_value)
	{
		self.ignore_health_regen_delay = 1;
	}
	else
	{
		self.ignore_health_regen_delay = 0;
	}
}

/*
	Name: validate
	Namespace: val
	Checksum: 0xED43BEBF
	Offset: 0x1780
	Size: 0xFE
	Parameters: 4
	Flags: Private, Variadic
*/
private function validate(str_name, call_on, func, vararg)
{
	/#
		a_registered = getarraykeys(level.values);
		if(!isinarray(a_registered, hash(str_name)))
		{
			/#
				assertmsg(("" + str_name) + "");
			#/
			return;
		}
		s_value = level.values[str_name];
		s_value.b_validate = 1;
		s_value.func_validate = func;
		s_value.validate_call_on = call_on;
		s_value.validate_args = vararg;
	#/
}

/*
	Name: _validate_value
	Namespace: val
	Checksum: 0x5560FF6C
	Offset: 0x1888
	Size: 0x168
	Parameters: 3
	Flags: Private
*/
private function _validate_value(str_name, value, b_assert)
{
	/#
		if(!isdefined(b_assert))
		{
			b_assert = 0;
		}
		s_value = level.values[str_name];
		if(isdefined(s_value.func_validate))
		{
			call_on = (s_value.validate_call_on === "" ? self : s_value.validate_call_on);
			current_value = util::single_func_argarray(call_on, s_value.func_validate, _replace_values(s_value.validate_args));
		}
		else
		{
			current_value = self.(str_name);
		}
		b_match = current_value === value;
		if(b_assert)
		{
			/#
				assert(b_match, ((((("" + function_9e72a96(str_name)) + "") + current_value) + "") + value) + "");
			#/
		}
		return b_match;
	#/
}

/*
	Name: debug_values
	Namespace: val
	Checksum: 0x490C882D
	Offset: 0x1A00
	Size: 0x484
	Parameters: 0
	Flags: Private
*/
private function debug_values()
{
	/#
		level flagsys::init_dvar("");
		level flagsys::wait_till("");
		while(true)
		{
			level flagsys::wait_till("");
			str_debug_values_entity = getdvarstring(#"scr_debug_values_entity", "");
			if(str_debug_values_entity == "" || str_debug_values_entity == "" || str_debug_values_entity == "")
			{
				hud_ent = level.host;
				str_label = "";
			}
			else if(strisnumber(str_debug_values_entity))
			{
				hud_ent = getentbynum(int(str_debug_values_entity));
				str_label = "" + str_debug_values_entity;
			}
			else
			{
				str_value = str_debug_values_entity;
				str_key = "";
				if(issubstr(str_value, ""))
				{
					a_toks = strtok(str_value, "");
					str_value = a_toks[0];
					str_key = a_toks[1];
				}
				hud_ent = getent(str_value, str_key, 1);
				str_label = (str_value + "") + str_key;
			}
			debug2dtext((200, 100, 0), str_label, (1, 1, 1), 1, (0, 0, 0), 0.5, 0.8, 1);
			if(!isdefined(hud_ent) || !isdefined(hud_ent.values))
			{
				waitframe(1);
				continue;
			}
			a_all_ents = getentarray();
			foreach(ent in a_all_ents)
			{
				if(isdefined(ent.values))
				{
					i = 1;
					foreach(str_name, a_value in ent.values)
					{
						top_value = a_value[0];
						if(isdefined(top_value))
						{
							b_valid = 1;
							if(isdefined(level.values[str_name].b_validate) && level.values[str_name].b_validate)
							{
								b_assert = getdvarint(#"scr_debug_values", 0) > 1;
								b_valid = ent _validate_value(str_name, top_value.value, b_assert);
							}
							ent display_value(i, str_name, top_value.str_id, top_value.value, b_valid, ent == hud_ent);
							i++;
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: display_value
	Namespace: val
	Checksum: 0x2C9DA168
	Offset: 0x1E90
	Size: 0x224
	Parameters: 6
	Flags: None
*/
function display_value(index, str_name, str_id, value, b_valid, on_hud)
{
	/#
		if(!isdefined(on_hud))
		{
			on_hud = 0;
		}
		if(function_7a600918(str_name))
		{
			str_name = function_9e72a96(str_name);
		}
		if(function_7a600918(str_id))
		{
			str_id = function_9e72a96(str_id);
		}
		str_value = "";
		if((isdefined(str_name) ? "" + str_name : "") != "")
		{
			str_value = string::rjust(str_name, 20);
			if(isdefined(value))
			{
				str_value = str_value + ("" + value);
			}
			str_value = str_value + ("" + (string::ljust((isdefined(str_id) ? "" + str_id : ""), 30)));
		}
		color = (b_valid ? (1, 1, 1) : (1, 0, 0));
		if(on_hud)
		{
			debug2dtext((200, 100 + (index * 20), 0), str_value, color, 1, (0, 0, 0), 0.5, 0.8, 1);
		}
		print3d(self.origin - (0, 0, index * 8), str_value, color, 1, 0.3, 1);
	#/
}

