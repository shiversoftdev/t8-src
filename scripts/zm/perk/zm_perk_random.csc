// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_score.csc;
#using scripts\zm_common\zm_audio.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_perk_random;

/*
	Name: __init__system__
	Namespace: zm_perk_random
	Checksum: 0x4920E8DC
	Offset: 0x230
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_random", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_random
	Checksum: 0xE4737B45
	Offset: 0x278
	Size: 0x34A
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("scriptmover", "perk_bottle_cycle_state", 1, 2, "int", &start_bottle_cycling, 0, 0);
	clientfield::register("zbarrier", "set_client_light_state", 1, 2, "int", &set_light_state, 0, 0);
	clientfield::register("zbarrier", "init_perk_random_machine", 1, 1, "int", &perk_random_machine_init, 0, 0);
	clientfield::register("zbarrier", "client_stone_emmissive_blink", 1, 1, "int", &perk_random_machine_rock_emissive, 0, 0);
	clientfield::register("scriptmover", "turn_active_perk_light_green", 1, 1, "int", &turn_on_active_light_green, 0, 0);
	clientfield::register("scriptmover", "turn_on_location_indicator", 1, 1, "int", &turn_on_location_indicator, 0, 0);
	clientfield::register("zbarrier", "lightning_bolt_FX_toggle", 1, 1, "int", &lightning_bolt_fx_toggle, 0, 0);
	clientfield::register("scriptmover", "turn_active_perk_ball_light", 1, 1, "int", &turn_on_active_ball_light, 0, 0);
	clientfield::register("scriptmover", "zone_captured", 1, 1, "int", &zone_captured_cb, 0, 0);
	level._effect[#"perk_machine_light_yellow"] = #"hash_63cff764b54ceca2";
	level._effect[#"perk_machine_light_red"] = #"hash_5b7d2edb8392ef21";
	level._effect[#"perk_machine_light_green"] = #"hash_130f1aaf8384975";
	level._effect[#"perk_machine_location"] = #"hash_53e8ba7551663778";
}

/*
	Name: init_animtree
	Namespace: zm_perk_random
	Checksum: 0x80F724D1
	Offset: 0x5D0
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function init_animtree()
{
}

/*
	Name: turn_on_location_indicator
	Namespace: zm_perk_random
	Checksum: 0x9F033F11
	Offset: 0x5E0
	Size: 0x3C
	Parameters: 7
	Flags: None
*/
function turn_on_location_indicator(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: lightning_bolt_fx_toggle
	Namespace: zm_perk_random
	Checksum: 0x5C886439
	Offset: 0x628
	Size: 0x1BE
	Parameters: 7
	Flags: None
*/
function lightning_bolt_fx_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdemoplaying() && getdemoversion() < 17)
	{
		return;
	}
	self notify("lightning_bolt_fx_toggle" + localclientnum);
	self endon("lightning_bolt_fx_toggle" + localclientnum);
	player = function_5c10bd79(localclientnum);
	player endon(#"death");
	if(!isdefined(self._location_indicator))
	{
		self._location_indicator = [];
	}
	while(true)
	{
		if(newval == 1 && !isigcactive(localclientnum))
		{
			if(!isdefined(self._location_indicator[localclientnum]))
			{
				self._location_indicator[localclientnum] = playfx(localclientnum, level._effect[#"perk_machine_location"], self.origin);
			}
		}
		else if(isdefined(self._location_indicator[localclientnum]))
		{
			stopfx(localclientnum, self._location_indicator[localclientnum]);
			self._location_indicator[localclientnum] = undefined;
		}
		wait(1);
	}
}

/*
	Name: zone_captured_cb
	Namespace: zm_perk_random
	Checksum: 0x23255964
	Offset: 0x7F0
	Size: 0xDC
	Parameters: 7
	Flags: None
*/
function zone_captured_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.mapped_const))
	{
		self mapshaderconstant(localclientnum, 1, "ScriptVector0");
		self.mapped_const = 1;
	}
	if(newval == 1)
	{
	}
	else
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 0;
		self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}

/*
	Name: perk_random_machine_rock_emissive
	Namespace: zm_perk_random
	Checksum: 0xD6A60DBB
	Offset: 0x8D8
	Size: 0xAE
	Parameters: 7
	Flags: None
*/
function perk_random_machine_rock_emissive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		piece = self zbarriergetpiece(3);
		piece.blinking = 1;
		piece thread rock_emissive_think(localclientnum);
	}
	else if(newval == 0)
	{
		self.blinking = 0;
	}
}

/*
	Name: rock_emissive_think
	Namespace: zm_perk_random
	Checksum: 0x2C875000
	Offset: 0x990
	Size: 0x80
	Parameters: 1
	Flags: None
*/
function rock_emissive_think(localclientnum)
{
	level endon(#"demo_jump");
	while(isdefined(self.blinking) && self.blinking)
	{
		self rock_emissive_fade(localclientnum, 8, 0);
		self rock_emissive_fade(localclientnum, 0, 8);
	}
}

/*
	Name: rock_emissive_fade
	Namespace: zm_perk_random
	Checksum: 0xB2DF7EDD
	Offset: 0xA18
	Size: 0x178
	Parameters: 3
	Flags: None
*/
function rock_emissive_fade(localclientnum, n_max_val, n_min_val)
{
	n_start_time = gettime();
	n_end_time = n_start_time + (0.5 * 1000);
	b_is_updating = 1;
	while(b_is_updating)
	{
		n_time = gettime();
		if(n_time >= n_end_time)
		{
			n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_end_time);
			b_is_updating = 0;
		}
		else
		{
			n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_time);
		}
		if(isdefined(self))
		{
			self mapshaderconstant(localclientnum, 0, "scriptVector2", n_shader_value, 0, 0);
			self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, n_shader_value, 0);
			self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, n_shader_value);
		}
		wait(0.01);
	}
}

/*
	Name: perk_random_machine_init
	Namespace: zm_perk_random
	Checksum: 0xA581FEBE
	Offset: 0xB98
	Size: 0xB2
	Parameters: 7
	Flags: Private
*/
function private perk_random_machine_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.perk_random_machine_fx))
	{
		return;
	}
	if(!isdefined(self))
	{
		return;
	}
	self.perk_random_machine_fx = [];
	self.perk_random_machine_fx["tag_animate" + 1] = [];
	self.perk_random_machine_fx["tag_animate" + 2] = [];
	self.perk_random_machine_fx["tag_animate" + 3] = [];
}

/*
	Name: set_light_state
	Namespace: zm_perk_random
	Checksum: 0xC137C85C
	Offset: 0xC58
	Size: 0x192
	Parameters: 7
	Flags: None
*/
function set_light_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_n_piece_indices = array(1, 2, 3);
	foreach(n_piece_index in a_n_piece_indices)
	{
		if(newval == 0)
		{
			perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", undefined);
			continue;
		}
		if(newval == 3)
		{
			perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_red"]);
			continue;
		}
		if(newval == 1)
		{
			perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_green"]);
			continue;
		}
	}
}

/*
	Name: perk_random_machine_play_fx
	Namespace: zm_perk_random
	Checksum: 0xE9A63267
	Offset: 0xDF8
	Size: 0x108
	Parameters: 5
	Flags: Private
*/
function private perk_random_machine_play_fx(localclientnum, piece_index, tag, fx, deleteimmediate = 1)
{
	piece = self zbarriergetpiece(piece_index);
	if(isdefined(self.perk_random_machine_fx[tag + piece_index][localclientnum]))
	{
		deletefx(localclientnum, self.perk_random_machine_fx[tag + piece_index][localclientnum], deleteimmediate);
		self.perk_random_machine_fx[tag + piece_index][localclientnum] = undefined;
	}
	if(isdefined(fx))
	{
		self.perk_random_machine_fx[tag + piece_index][localclientnum] = util::playfxontag(localclientnum, fx, piece, tag);
	}
}

/*
	Name: turn_on_active_light_green
	Namespace: zm_perk_random
	Checksum: 0x5599BCDA
	Offset: 0xF08
	Size: 0x98
	Parameters: 7
	Flags: None
*/
function turn_on_active_light_green(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 0.7;
		self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}

/*
	Name: turn_on_active_ball_light
	Namespace: zm_perk_random
	Checksum: 0x3EBEC2A3
	Offset: 0xFA8
	Size: 0x98
	Parameters: 7
	Flags: None
*/
function turn_on_active_ball_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.artifact_glow_setting = 1;
		self.machinery_glow_setting = 1;
		self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
	}
}

/*
	Name: start_bottle_cycling
	Namespace: zm_perk_random
	Checksum: 0x145715DF
	Offset: 0x1048
	Size: 0x7C
	Parameters: 7
	Flags: None
*/
function start_bottle_cycling(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread start_vortex_fx(localclientnum);
	}
	else
	{
		self thread stop_vortex_fx(localclientnum);
	}
}

/*
	Name: start_vortex_fx
	Namespace: zm_perk_random
	Checksum: 0x17E9C4F7
	Offset: 0x10D0
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function start_vortex_fx(localclientnum)
{
	self endon(#"activation_electricity_finished");
	self endon(#"death");
	if(!isdefined(self.glow_location))
	{
		self.glow_location = spawn(localclientnum, self.origin, "script_model");
		self.glow_location.angles = self.angles;
		self.glow_location setmodel(#"tag_origin");
	}
	self thread fx_activation_electric_loop(localclientnum);
	self thread fx_artifact_pulse_thread(localclientnum);
	wait(0.5);
	self thread fx_bottle_cycling(localclientnum);
}

/*
	Name: stop_vortex_fx
	Namespace: zm_perk_random
	Checksum: 0xC2C4EBB3
	Offset: 0x11D8
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function stop_vortex_fx(localclientnum)
{
	self endon(#"death");
	self notify(#"bottle_cycling_finished");
	wait(0.5);
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"activation_electricity_finished");
	if(isdefined(self.glow_location))
	{
		self.glow_location delete();
	}
	self.artifact_glow_setting = 1;
	self.machinery_glow_setting = 0.7;
	self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

/*
	Name: fx_artifact_pulse_thread
	Namespace: zm_perk_random
	Checksum: 0x3C98630D
	Offset: 0x12B8
	Size: 0x106
	Parameters: 1
	Flags: None
*/
function fx_artifact_pulse_thread(localclientnum)
{
	self endon(#"activation_electricity_finished");
	self endon(#"death");
	while(isdefined(self))
	{
		shader_amount = sin(getrealtime() * 0.2);
		if(shader_amount < 0)
		{
			shader_amount = shader_amount * -1;
		}
		shader_amount = 0.75 - (shader_amount * 0.75);
		self.artifact_glow_setting = shader_amount;
		self.machinery_glow_setting = 1;
		self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
		waitframe(1);
	}
}

/*
	Name: fx_activation_electric_loop
	Namespace: zm_perk_random
	Checksum: 0xB6CF4A69
	Offset: 0x13C8
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function fx_activation_electric_loop(localclientnum)
{
	self endon(#"activation_electricity_finished");
	self endon(#"death");
	while(true)
	{
		wait(0.1);
	}
}

/*
	Name: fx_bottle_cycling
	Namespace: zm_perk_random
	Checksum: 0xD3BDB88B
	Offset: 0x1420
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function fx_bottle_cycling(localclientnum)
{
	self endon(#"bottle_cycling_finished");
	while(true)
	{
		wait(0.1);
	}
}

/*
	Name: function_6a9b1884
	Namespace: zm_perk_random
	Checksum: 0xB9528761
	Offset: 0x1468
	Size: 0x78
	Parameters: 1
	Flags: None
*/
function function_6a9b1884(localclientnum)
{
	self endon(#"hash_fcaf7071581a306");
	self endon(#"death");
	level endon(#"demo_jump");
	while(isdefined(self))
	{
		wait(randomfloatrange(3, 4));
	}
}

