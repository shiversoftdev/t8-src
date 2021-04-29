// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\lui_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\util.csc;
#using scripts\zm_common\zm_equipment.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_altbody;

/*
	Name: function_89f2df9
	Namespace: zm_altbody
	Checksum: 0x82A296D7
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_altbody", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_altbody
	Checksum: 0x582C78B9
	Offset: 0x190
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "player_mana", 1, 8, "float", &set_player_mana, 0, 1);
	clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", &toggle_player_altbody, 0, 1);
	clientfield::register("allplayers", "player_altbody", 1, 1, "int", &function_7706e75d, 0, 1);
	setupclientfieldcodecallbacks("toplayer", 1, "player_in_afterlife");
}

/*
	Name: init
	Namespace: zm_altbody
	Checksum: 0x45B44CE6
	Offset: 0x2D8
	Size: 0x18A
	Parameters: 9
	Flags: None
*/
function init(name, trigger_name, trigger_hint, visionset_name, visionset_priority, enter_callback, exit_callback, var_ce76c522, var_152151d1)
{
	if(!isdefined(level.altbody_enter_callbacks))
	{
		level.altbody_enter_callbacks = [];
	}
	if(!isdefined(level.altbody_exit_callbacks))
	{
		level.altbody_exit_callbacks = [];
	}
	if(!isdefined(level.var_3b3a54b9))
	{
		level.var_3b3a54b9 = [];
	}
	if(!isdefined(level.var_449bb0ea))
	{
		level.var_449bb0ea = [];
	}
	if(!isdefined(level.altbody_visionsets))
	{
		level.altbody_visionsets = [];
	}
	level.altbody_name = name;
	if(isdefined(visionset_name))
	{
		level.altbody_visionsets[name] = visionset_name;
		visionset_mgr::register_visionset_info(visionset_name, 1, 1, visionset_name, visionset_name);
	}
	level.altbody_enter_callbacks[name] = enter_callback;
	level.altbody_exit_callbacks[name] = exit_callback;
	level.var_3b3a54b9[name] = var_ce76c522;
	level.var_449bb0ea[name] = var_152151d1;
}

/*
	Name: set_player_mana
	Namespace: zm_altbody
	Checksum: 0xD44B5123
	Offset: 0x470
	Size: 0x4A
	Parameters: 7
	Flags: None
*/
function set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.mana = newval;
}

/*
	Name: toggle_player_altbody
	Namespace: zm_altbody
	Checksum: 0x4E5AD5A5
	Offset: 0x4C8
	Size: 0x144
	Parameters: 7
	Flags: None
*/
function toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.altbody))
	{
		self.altbody = 0;
	}
	self usealternatehud(newval);
	if(self.altbody !== newval)
	{
		self.altbody = newval;
		if(bwastimejump)
		{
			self thread function_f2e3981e(localclientnum, newval);
		}
		else
		{
			self thread cover_transition(localclientnum, newval);
		}
		if(newval == 1)
		{
			callback = level.altbody_enter_callbacks[level.altbody_name];
			if(isdefined(callback))
			{
				self [[callback]](localclientnum);
			}
		}
		else
		{
			callback = level.altbody_exit_callbacks[level.altbody_name];
			if(isdefined(callback))
			{
				self [[callback]](localclientnum);
			}
		}
	}
}

/*
	Name: function_7706e75d
	Namespace: zm_altbody
	Checksum: 0xDDFDA3C7
	Offset: 0x618
	Size: 0xE0
	Parameters: 7
	Flags: None
*/
function function_7706e75d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self function_21c0fa55())
	{
		return;
	}
	self.var_d44cb9d2 = newval;
	if(newval == 1)
	{
		callback = level.var_3b3a54b9[level.altbody_name];
		if(isdefined(callback))
		{
			self [[callback]](localclientnum);
		}
	}
	else
	{
		callback = level.var_449bb0ea[level.altbody_name];
		if(isdefined(callback))
		{
			self [[callback]](localclientnum);
		}
	}
}

/*
	Name: cover_transition
	Namespace: zm_altbody
	Checksum: 0xCEBE4EA2
	Offset: 0x700
	Size: 0xC4
	Parameters: 2
	Flags: None
*/
function cover_transition(localclientnum, onoff)
{
	if(!self util::function_50ed1561(localclientnum))
	{
		return;
	}
	if(isdemoplaying() && demoisanyfreemovecamera())
	{
		return;
	}
	self lui::screen_fade_out(0.05);
	level waittill_timeout(0.15, #"demo_jump");
	if(isdefined(self))
	{
		self lui::screen_fade_in(0.1);
	}
}

/*
	Name: function_f2e3981e
	Namespace: zm_altbody
	Checksum: 0xE53C822A
	Offset: 0x7D0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_f2e3981e(localclientnum, onoff)
{
	self lui::screen_fade_in(0);
}

