// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_87b5173f;

/*
	Name: init
	Namespace: namespace_87b5173f
	Checksum: 0x3CA9E79A
	Offset: 0x200
	Size: 0x3F2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "shower_trap_death_fx", 1, 1, "int", &acid_trap_death_fx, 0, 0);
	clientfield::register("scriptmover", "shower_trap_fx", 1, 1, "int", &acid_trap_fx, 0, 0);
	clientfield::register("toplayer", "player_shower_trap_post_fx", 18000, 1, "int", &player_acid_trap_post_fx, 0, 0);
	clientfield::register("toplayer", "player_fire_trap_post_fx", 18000, 1, "int", &player_fire_trap_post_fx, 0, 0);
	clientfield::register("scriptmover", "fire_trap_fx", 1, 1, "int", &fire_trap_fx, 0, 0);
	clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int", &spinning_trap_blood_fx, 0, 0);
	clientfield::register("actor", "spinning_trap_eye_fx", 1, 1, "int", &spinning_trap_eye_fx, 0, 0);
	clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int", &rumble_spinning_trap, 0, 0);
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"acid_spray"] = #"hash_424786ecbc7f5672";
	level._effect[#"hash_31adca9427875cc3"] = #"hash_48d74d13d0c569c";
	level._effect[#"hash_294b19c300d1b482"] = #"hash_29ac72c5aa5398bc";
	level._effect[#"hash_4391e5c4b43c63c9"] = #"hash_709cca7d0048aa72";
	level._effect[#"hash_5647f8e593893bce"] = #"hash_69af1783a31b44f7";
	level._effect[#"hash_13b6f9efa3cf588a"] = #"hash_526060b70ce93d7e";
	level._effect[#"hash_1a3aa0422b5a92a4"] = #"hash_358533e8293f131d";
	level._effect[#"hash_44ccd33973542202"] = #"hash_5fdb13b4843bc710";
}

/*
	Name: acid_trap_fx
	Namespace: namespace_87b5173f
	Checksum: 0xF780B5E3
	Offset: 0x600
	Size: 0x1AC
	Parameters: 7
	Flags: Linked
*/
function acid_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_91180673))
		{
			self.var_91180673 delete();
		}
		playsound(localclientnum, #"hash_68f3e5dbc3422363", self.origin);
		audio::playloopat("zmb_trap_acid_loop", self.origin);
		self.var_91180673 = util::playfxontag(localclientnum, level._effect[#"acid_spray"], self, "tag_origin");
	}
	else
	{
		playsound(localclientnum, #"hash_4da8231bc8767676", self.origin);
		audio::stoploopat("zmb_trap_acid_loop", self.origin);
		if(isdefined(self.var_91180673))
		{
			stopfx(localclientnum, self.var_91180673);
			self.var_91180673 = undefined;
		}
		playfx(localclientnum, level._effect[#"hash_31adca9427875cc3"], self.origin);
	}
}

/*
	Name: acid_trap_death_fx
	Namespace: namespace_87b5173f
	Checksum: 0x4E802F2A
	Offset: 0x7B8
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function acid_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_963e2d39 = util::playfxontag(localclientnum, level._effect[#"hash_294b19c300d1b482"], self, "tag_stowed_back");
		playsound(localclientnum, #"hash_4d4c9f8ad239b61f", self.origin);
	}
	else if(isdefined(self.var_963e2d39))
	{
		stopfx(localclientnum, self.var_963e2d39);
		self.var_963e2d39 = undefined;
	}
}

/*
	Name: player_acid_trap_post_fx
	Namespace: namespace_87b5173f
	Checksum: 0xA83BABBC
	Offset: 0x8B0
	Size: 0x206
	Parameters: 7
	Flags: Linked
*/
function player_acid_trap_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdemoplaying() && demoisanyfreemovecamera())
		{
			return;
		}
		if(self != function_5c10bd79(localclientnum))
		{
			return;
		}
		self notify(#"hash_5703f63dbeb5305e");
		self.var_431ddde9 = self playloopsound(#"hash_341a3fa00975f232");
		self thread function_17956e93(localclientnum);
		self thread postfx::playpostfxbundle(#"hash_98397d99cb3a03");
		self.var_b1409d8f = playfxoncamera(localclientnum, level._effect[#"hash_4391e5c4b43c63c9"]);
		self function_bf9d3071(#"hash_216f6c4ece79a4b8");
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_7a7fac87 = playviewmodelfx(localclientnum, level._effect[#"hash_5647f8e593893bce"], "j_wrist_ri");
		}
	}
	else
	{
		self notify(#"hash_5703f63dbeb5305e");
		if(isdefined(self.var_431ddde9))
		{
			self stoploopsound(self.var_431ddde9);
			self.var_431ddde9 = undefined;
		}
	}
}

/*
	Name: function_17956e93
	Namespace: namespace_87b5173f
	Checksum: 0x89250D26
	Offset: 0xAC0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_17956e93(localclientnum)
{
	self endon_callback(&function_502136a5, #"death");
	self waittill(#"hash_5703f63dbeb5305e");
	if(isdefined(self))
	{
		self postfx::exitpostfxbundle(#"hash_98397d99cb3a03");
		if(isdefined(localclientnum) && isdefined(self.var_b1409d8f))
		{
			stopfx(localclientnum, self.var_b1409d8f);
			self.var_b1409d8f = undefined;
		}
		if(isdefined(localclientnum) && isdefined(self.var_7a7fac87))
		{
			stopfx(localclientnum, self.var_7a7fac87);
			self.var_7a7fac87 = undefined;
		}
		if(isdefined(self.var_431ddde9))
		{
			self stoploopsound(self.var_431ddde9);
			self.var_431ddde9 = undefined;
		}
		self function_5d482e78(#"hash_216f6c4ece79a4b8");
	}
}

/*
	Name: function_502136a5
	Namespace: namespace_87b5173f
	Checksum: 0x15D3EAE5
	Offset: 0xC08
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_502136a5(str_notify)
{
	if(isdefined(self))
	{
		localclientnum = self getlocalclientnumber();
		if(self postfx::function_556665f2(#"hash_98397d99cb3a03"))
		{
			self postfx::exitpostfxbundle(#"hash_98397d99cb3a03");
		}
		if(isdefined(self.var_431ddde9))
		{
			self stoploopsound(self.var_431ddde9);
			self.var_431ddde9 = undefined;
		}
		if(isdefined(localclientnum) && isdefined(self.var_b1409d8f))
		{
			stopfx(localclientnum, self.var_b1409d8f);
			self.var_b1409d8f = undefined;
		}
		if(isdefined(localclientnum) && isdefined(self.var_7a7fac87))
		{
			stopfx(localclientnum, self.var_7a7fac87);
			self.var_7a7fac87 = undefined;
		}
		self function_5d482e78(#"hash_216f6c4ece79a4b8");
	}
}

/*
	Name: fire_trap_fx
	Namespace: namespace_87b5173f
	Checksum: 0xC623B751
	Offset: 0xD58
	Size: 0x176
	Parameters: 7
	Flags: Linked
*/
function fire_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_91180673))
		{
			self.var_91180673 delete();
		}
		playsound(localclientnum, #"hash_370460eab1a33ee6", self.origin);
		audio::playloopat("wpn_fire_trap_loop", self.origin);
		self.var_91180673 = util::playfxontag(localclientnum, level._effect[#"hash_44ccd33973542202"], self, "tag_origin");
	}
	else
	{
		playsound(localclientnum, #"hash_5d8ec72f0838594e", self.origin);
		audio::stoploopat("wpn_fire_trap_loop", self.origin);
		if(isdefined(self.var_91180673))
		{
			stopfx(localclientnum, self.var_91180673);
			self.var_91180673 = undefined;
		}
	}
}

/*
	Name: player_fire_trap_post_fx
	Namespace: namespace_87b5173f
	Checksum: 0x5B1AFB06
	Offset: 0xED8
	Size: 0xFE
	Parameters: 7
	Flags: Linked
*/
function player_fire_trap_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdemoplaying() && demoisanyfreemovecamera())
		{
			return;
		}
		if(self != function_5c10bd79(localclientnum))
		{
			return;
		}
		self notify(#"hash_6ff87b60bee15b27");
		self thread function_33da4ab(localclientnum);
		self thread postfx::playpostfxbundle(#"pstfx_zm_fire_blue_trap");
	}
	else
	{
		self notify(#"hash_6ff87b60bee15b27");
	}
}

/*
	Name: function_33da4ab
	Namespace: namespace_87b5173f
	Checksum: 0x25D11A1D
	Offset: 0xFE0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_33da4ab(localclientnum)
{
	self endon_callback(&function_3204a9f, #"death");
	self waittill(#"hash_6ff87b60bee15b27");
	if(isdefined(self))
	{
		self postfx::exitpostfxbundle(#"pstfx_zm_fire_blue_trap");
	}
}

/*
	Name: function_3204a9f
	Namespace: namespace_87b5173f
	Checksum: 0x67C7A1A8
	Offset: 0x1058
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_3204a9f(str_notify)
{
	if(isdefined(self))
	{
		localclientnum = self getlocalclientnumber();
		if(self postfx::function_556665f2(#"pstfx_zm_fire_blue_trap"))
		{
			self postfx::exitpostfxbundle(#"pstfx_zm_fire_blue_trap");
		}
	}
}

/*
	Name: spinning_trap_blood_fx
	Namespace: namespace_87b5173f
	Checksum: 0x2721F6AF
	Offset: 0x10D8
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function spinning_trap_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_34cc2b51))
	{
		stopfx(localclientnum, self.var_34cc2b51);
		self.var_34cc2b51 = undefined;
	}
	if(newval == 1)
	{
		var_1f694afe = "j_spinelower";
		if(self.archetype == #"zombie_dog")
		{
			var_1f694afe = "j_spine1";
		}
		self.var_34cc2b51 = util::playfxontag(localclientnum, level._effect[#"hash_1a3aa0422b5a92a4"], self, var_1f694afe);
		playsound(localclientnum, #"hash_5840ac12dd5f08cd", self.origin);
	}
}

/*
	Name: spinning_trap_eye_fx
	Namespace: namespace_87b5173f
	Checksum: 0x7C00637
	Offset: 0x11F8
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function spinning_trap_eye_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_9ae91529))
	{
		stopfx(localclientnum, self.var_9ae91529);
		self.var_9ae91529 = undefined;
	}
	if(newval == 1)
	{
		self.var_9ae91529 = util::playfxontag(localclientnum, level._effect[#"hash_13b6f9efa3cf588a"], self, "tag_eye");
	}
}

/*
	Name: rumble_spinning_trap
	Namespace: namespace_87b5173f
	Checksum: 0xC0F336AE
	Offset: 0x12C0
	Size: 0xDE
	Parameters: 7
	Flags: Linked
*/
function rumble_spinning_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	if(newval == 1)
	{
		self endon(#"hash_6fb55d3438a8d5fa");
		while(true)
		{
			if(isinarray(getlocalplayers(), self))
			{
				self playrumbleonentity(localclientnum, "damage_light");
			}
			wait(0.25);
		}
	}
	else
	{
		self notify(#"hash_6fb55d3438a8d5fa");
	}
}

