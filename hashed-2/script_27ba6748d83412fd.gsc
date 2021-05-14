// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_fasttravel;

/*
	Name: function_89f2df9
	Namespace: zm_fasttravel
	Checksum: 0xF54ADA92
	Offset: 0x320
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_fasttravel", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_fasttravel
	Checksum: 0x4A57BF6B
	Offset: 0x368
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function __init__()
{
	init_clientfields();
	init_fx();
}

/*
	Name: init_clientfields
	Namespace: zm_fasttravel
	Checksum: 0x930A5852
	Offset: 0x398
	Size: 0x254
	Parameters: 0
	Flags: None
*/
function init_clientfields()
{
	clientfield::register("world", "fasttravel_exploder", 1, 1, "int", &fasttravel_exploder, 0, 0);
	clientfield::register("scriptmover", "" + #"wormhole_fx", 1, 2, "int", &wormhole_fx, 0, 0);
	clientfield::register("toplayer", "player_stargate_fx", 1, 1, "int", &player_stargate_fx, 0, 1);
	clientfield::register("toplayer", "player_chaos_light_rail_fx", 1, 1, "int", &player_chaos_light_rail_fx, 0, 1);
	clientfield::register("toplayer", "fasttravel_teleport_sfx", 1, 1, "int", &fasttravel_teleport_sfx, 0, 0);
	clientfield::register("allplayers", "fasttravel_start_fx", 1, 1, "counter", &fasttravel_start_fx, 0, 0);
	clientfield::register("allplayers", "fasttravel_end_fx", 1, 1, "counter", &fasttravel_end_fx, 0, 0);
	clientfield::register("allplayers", "fasttravel_rail_fx", 1, 2, "int", &fasttravel_rail_fx, 0, 0);
}

/*
	Name: init_fx
	Namespace: zm_fasttravel
	Checksum: 0xAE49D863
	Offset: 0x5F8
	Size: 0x152
	Parameters: 0
	Flags: None
*/
function init_fx()
{
	level._effect[#"hash_714f14fd267445b8"] = #"hash_2f54a4439f3a1dbf";
	level._effect[#"fasttravel_end"] = #"hash_4ab05aa1282b9bb7";
	level._effect[#"fasttravel_rail_1p"] = #"hash_259bb7806d596ed3";
	level._effect[#"fasttravel_break_1p"] = #"hash_37257517a8fd29e";
	level._effect[#"fasttravel_rail_3p"] = #"hash_809f6b4b699e4df";
	level._effect[#"fasttravel_break_3p"] = #"hash_13715b19c0c0e890";
	level._effect[#"fasttravel_rail_travel"] = #"hash_3659a06ed75f940a";
}

/*
	Name: fasttravel_exploder
	Namespace: zm_fasttravel
	Checksum: 0x6895289B
	Offset: 0x758
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function fasttravel_exploder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level exploder::exploder("fxexp_fast_travel_orbs");
	}
	else
	{
		level exploder::stop_exploder("fxexp_fast_travel_orbs");
	}
}

/*
	Name: player_chaos_light_rail_fx
	Namespace: zm_fasttravel
	Checksum: 0xA325FFB
	Offset: 0x7E8
	Size: 0x224
	Parameters: 7
	Flags: None
*/
function player_chaos_light_rail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdemoplaying() && demoisanyfreemovecamera())
		{
			return;
		}
		var_8203417 = function_5c10bd79(localclientnum);
		if(self != var_8203417)
		{
			return;
		}
		if(!isdefined(self.var_9a68f89f))
		{
			v_origin = self gettagorigin("tag_eye");
			self.var_9a68f89f = self function_dddf661d(localclientnum, "fasttravel_rail_travel", "tag_origin", v_origin, self.angles);
			self thread function_eaba4969(localclientnum, "fasttravel_rail_travel_complete", self.var_9a68f89f);
		}
		if(isdefined(level.var_5603a802))
		{
			self thread postfx::playpostfxbundle(level.var_5603a802);
		}
		else
		{
			self thread postfx::playpostfxbundle("pstfx_zm_chaos_temp");
		}
	}
	else
	{
		self notify(#"fasttravel_rail_travel_complete");
		if(isdefined(self.var_9a68f89f))
		{
			function_4468d7ac(localclientnum, self.var_9a68f89f);
			self.var_9a68f89f = undefined;
		}
		if(isdefined(level.var_5603a802))
		{
			self postfx::exitpostfxbundle(level.var_5603a802);
		}
		else
		{
			self postfx::exitpostfxbundle("pstfx_zm_chaos_temp");
		}
	}
}

/*
	Name: wormhole_fx
	Namespace: zm_fasttravel
	Checksum: 0x9F1743DF
	Offset: 0xA18
	Size: 0xC4
	Parameters: 7
	Flags: None
*/
function wormhole_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		str_fx = "zombie/fx8_teleport_instant_1p_ported";
	}
	else if(newval == 2)
	{
		str_fx = "zombie/fx8_teleport_instant_1p";
	}
	if(isdefined(str_fx))
	{
		self util::waittill_dobj(localclientnum);
		util::playfxontag(localclientnum, str_fx, self, "tag_fx_wormhole");
	}
}

/*
	Name: player_stargate_fx
	Namespace: zm_fasttravel
	Checksum: 0x11DB31E2
	Offset: 0xAE8
	Size: 0xB4
	Parameters: 7
	Flags: None
*/
function player_stargate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(isdemoplaying() && demoisanyfreemovecamera())
		{
			return;
		}
		self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_zm_wormhole");
	}
}

/*
	Name: fasttravel_teleport_sfx
	Namespace: zm_fasttravel
	Checksum: 0xFA0E1384
	Offset: 0xBA8
	Size: 0x126
	Parameters: 7
	Flags: None
*/
function fasttravel_teleport_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		if(!isdefined(self.fasttravel_teleport_sfx))
		{
			self playsound(localclientnum, #"hash_695df080bafaf6b7");
			self.fasttravel_teleport_sfx = self playloopsound(#"hash_337255a64f96457b");
		}
	}
	else if(isdefined(self.fasttravel_teleport_sfx))
	{
		self playsound(localclientnum, #"hash_32def2a5219ba9ee");
		self stoploopsound(self.fasttravel_teleport_sfx);
		self.fasttravel_teleport_sfx = undefined;
	}
}

/*
	Name: fasttravel_start_fx
	Namespace: zm_fasttravel
	Checksum: 0xCFAFE89D
	Offset: 0xCD8
	Size: 0x1BC
	Parameters: 7
	Flags: None
*/
function fasttravel_start_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level endon(#"end_game");
	self endon(#"bled_out", #"disconnect");
	if(self != function_5c10bd79(localclientnum))
	{
		if(newval == 1)
		{
			var_1d1bbd52 = struct::get_array("fasttravel_trigger", "targetname");
			var_4d611aa2 = arraygetclosest(self.origin, var_1d1bbd52);
			if(!isdefined(var_4d611aa2))
			{
				return;
			}
			v_angles = vectortoangles(var_4d611aa2.origin - self.origin);
			mdl_fx = util::spawn_model(localclientnum, "tag_origin", self.origin, v_angles);
			waitframe(1);
			util::playfxontag(localclientnum, level._effect[#"hash_714f14fd267445b8"], mdl_fx, "tag_origin");
			wait(1.5);
			mdl_fx delete();
		}
	}
}

/*
	Name: fasttravel_end_fx
	Namespace: zm_fasttravel
	Checksum: 0xE8C6FF9F
	Offset: 0xEA0
	Size: 0x5C
	Parameters: 7
	Flags: None
*/
function fasttravel_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread play_fasttravel_end_fx(localclientnum);
	}
}

/*
	Name: play_fasttravel_end_fx
	Namespace: zm_fasttravel
	Checksum: 0xEA1B324
	Offset: 0xF08
	Size: 0x12C
	Parameters: 2
	Flags: None
*/
function play_fasttravel_end_fx(localclientnum, var_b8763ebc = "fasttravel_end")
{
	level endon(#"end_game");
	self endon(#"bled_out", #"disconnect");
	if(self != function_5c10bd79(localclientnum))
	{
		v_angles = combineangles(self.angles, vectorscale((-1, 0, 0), 90));
		mdl_fx = util::spawn_model(localclientnum, "tag_origin", self.origin, v_angles);
		waitframe(1);
		util::playfxontag(localclientnum, level._effect[var_b8763ebc], mdl_fx, "tag_origin");
		wait(1.15);
		mdl_fx delete();
	}
}

/*
	Name: fasttravel_rail_fx
	Namespace: zm_fasttravel
	Checksum: 0xF98309AA
	Offset: 0x1040
	Size: 0x43E
	Parameters: 7
	Flags: None
*/
function fasttravel_rail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_a7fc7689))
		{
			self playsound(localclientnum, #"hash_7204b092c976136b");
			self.var_a7fc7689 = self playloopsound(#"hash_33b6a998603c309d");
		}
		if(!isdefined(self.var_a6b9f4c1))
		{
			var_8203417 = function_5c10bd79(localclientnum);
			if(self == var_8203417)
			{
				v_origin = self gettagorigin("tag_eye");
				self.var_a6b9f4c1 = self function_dddf661d(localclientnum, "fasttravel_rail_1p", "tag_origin", v_origin, self.angles);
			}
			else
			{
				v_origin = self gettagorigin("j_spine4");
				self.var_a6b9f4c1 = self function_dddf661d(localclientnum, "fasttravel_rail_3p", "tag_origin", v_origin, self.angles);
			}
			self thread function_eaba4969(localclientnum, "fasttravel_rail_fx_complete", self.var_a6b9f4c1);
		}
	}
	else if(newval == 2)
	{
		if(!isdefined(self.var_a7fc7689))
		{
			self playsound(localclientnum, #"hash_7f171ce50ab41fb8");
			self.var_a7fc7689 = self playloopsound(#"hash_59921813746566c8");
		}
		if(isdefined(self.var_a6b9f4c1))
		{
			self notify(#"fasttravel_rail_fx_complete");
			function_4468d7ac(localclientnum, self.var_a6b9f4c1);
		}
		var_8203417 = function_5c10bd79(localclientnum);
		if(self == var_8203417)
		{
			v_origin = self gettagorigin("tag_eye");
			self.var_a6b9f4c1 = self function_dddf661d(localclientnum, "fasttravel_break_1p", "tag_origin", v_origin, self.angles);
		}
		else
		{
			v_origin = self gettagorigin("j_spine4");
			self.var_a6b9f4c1 = self function_dddf661d(localclientnum, "fasttravel_break_3p", "tag_origin", v_origin, self.angles);
		}
		self thread function_eaba4969(localclientnum, "fasttravel_rail_fx_complete", self.var_a6b9f4c1);
	}
	else if(newval == 0)
	{
		if(isdefined(self.var_a7fc7689))
		{
			self playsound(localclientnum, #"hash_588047eba8deb34e");
			self stoploopsound(self.var_a7fc7689);
			self.var_a7fc7689 = undefined;
		}
		if(isdefined(self.var_a6b9f4c1))
		{
			self notify(#"fasttravel_rail_fx_complete");
			function_4468d7ac(localclientnum, self.var_a6b9f4c1);
			self.var_a6b9f4c1 = undefined;
		}
	}
}

/*
	Name: function_dddf661d
	Namespace: zm_fasttravel
	Checksum: 0x32043E85
	Offset: 0x1488
	Size: 0xB2
	Parameters: 5
	Flags: Private
*/
private function function_dddf661d(localclientnum, str_fx, str_tag, v_origin, v_angles)
{
	mdl_fx = util::spawn_model(localclientnum, "tag_origin", v_origin, v_angles);
	mdl_fx linkto(self, str_tag);
	mdl_fx.n_fx = util::playfxontag(localclientnum, level._effect[str_fx], mdl_fx, "tag_origin");
	return mdl_fx;
}

/*
	Name: function_eaba4969
	Namespace: zm_fasttravel
	Checksum: 0xA4A8EEC7
	Offset: 0x1548
	Size: 0x6C
	Parameters: 3
	Flags: Private
*/
private function function_eaba4969(localclientnum, var_92d4e054, mdl_fx)
{
	level endon(#"end_game");
	self endon(var_92d4e054);
	self waittill(#"death");
	function_4468d7ac(localclientnum, mdl_fx);
}

/*
	Name: function_4468d7ac
	Namespace: zm_fasttravel
	Checksum: 0xDAA9BB01
	Offset: 0x15C0
	Size: 0x64
	Parameters: 2
	Flags: Private
*/
private function function_4468d7ac(localclientnum, mdl_fx)
{
	if(isdefined(mdl_fx))
	{
		if(isdefined(mdl_fx.n_fx))
		{
			stopfx(localclientnum, mdl_fx.n_fx);
		}
		mdl_fx delete();
	}
}

