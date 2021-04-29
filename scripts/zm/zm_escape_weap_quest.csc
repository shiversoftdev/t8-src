// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_7228a45f434ec207;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_60a296cc;

/*
	Name: function_89f2df9
	Namespace: namespace_60a296cc
	Checksum: 0x713886E8
	Offset: 0x210
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_35f86e4c2035f69f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_60a296cc
	Checksum: 0xE9B9898F
	Offset: 0x258
	Size: 0x3D2
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	n_bits = getminbitcountfornum(4);
	clientfield::register("scriptmover", "" + #"hash_5ecbfb9042fc7f38", 1, 1, "int", &function_e4a48a64, 0, 0);
	clientfield::register("actor", "" + #"hash_588871862d19b97d", 1, 1, "int", &function_b543a4ed, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2be4ce9b84bd3b58", 1, 1, "counter", &function_1f632068, 0, 0);
	clientfield::register("actor", "" + #"hash_338ecd1287d0623b", 1, 1, "counter", &function_63eff42e, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_661cd5b850004033", 1, n_bits, "int", &function_dfe17a5d, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_51657261e835ac7c", 1, n_bits, "int", &function_724af26a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_661cd5b850004033", 13000, 1, "int", &function_1302ffdd, 0, 0);
	clientfield::register("toplayer", "" + #"hash_51657261e835ac7c", 13000, 1, "int", &function_c17bd665, 0, 0);
	level._effect[#"hell_portal"] = "maps/zm_escape/fx8_wolf_portal_hell";
	level._effect[#"hell_portal_close"] = "maps/zm_escape/fx8_wolf_portal_hell_close";
	level._effect[#"soul_charged"] = "maps/zm_escape/fx8_wolf_soul_charged";
	level._effect[#"soul_charge_start"] = "maps/zm_escape/fx8_wolf_soul_charge_start";
	level._effect[#"soul_charge_impact"] = "maps/zm_escape/fx8_wolf_soul_charge_impact_sm";
	level._effect[#"wolf_bite_blood"] = "maps/zm_escape/fx8_wolf_soul_charge_impact";
}

/*
	Name: function_e4a48a64
	Namespace: namespace_60a296cc
	Checksum: 0xD9FB8728
	Offset: 0x638
	Size: 0x252
	Parameters: 7
	Flags: Linked
*/
function function_e4a48a64(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_8eb4e749))
		{
			stopfx(localclientnum, self.var_8eb4e749);
		}
		self.var_8eb4e749 = util::playfxontag(localclientnum, level._effect[#"hell_portal"], self, "tag_origin");
		self playsound(localclientnum, #"hash_6e048d37333004da");
		if(!isdefined(self.var_dd081ca4))
		{
			self.var_dd081ca4 = self playloopsound(#"hash_f80ff339436a985");
		}
	}
	else if(isdefined(self.var_8eb4e749))
	{
		stopfx(localclientnum, self.var_8eb4e749);
		self.var_8eb4e749 = undefined;
	}
	self playsound(localclientnum, #"hash_4435f84f2c7dd54f");
	if(isdefined(self.var_dd081ca4))
	{
		self stoploopsound(self.var_dd081ca4);
	}
	self.var_8eb4e749 = util::playfxontag(localclientnum, level._effect[#"hell_portal_close"], self, "tag_origin");
	wait(0.5);
	if(isdefined(self))
	{
		if(isdefined(self.var_78ef40db))
		{
			stopfx(localclientnum, self.var_78ef40db);
		}
		self.var_78ef40db = util::playfxontag(localclientnum, level._effect[#"soul_charged"], self, "tag_origin");
	}
}

/*
	Name: function_b543a4ed
	Namespace: namespace_60a296cc
	Checksum: 0x8DCB1735
	Offset: 0x898
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function function_b543a4ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_f74c7894))
		{
			stopfx(localclientnum, self.var_f74c7894);
		}
		self.var_f74c7894 = util::playfxontag(localclientnum, level._effect[#"soul_charge_start"], self, "tag_origin");
	}
	else if(isdefined(self.var_f74c7894))
	{
		stopfx(localclientnum, self.var_f74c7894);
		self.var_f74c7894 = undefined;
	}
}

/*
	Name: function_1f632068
	Namespace: namespace_60a296cc
	Checksum: 0xD8EF6797
	Offset: 0x990
	Size: 0xA2
	Parameters: 7
	Flags: Linked
*/
function function_1f632068(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_d634930c))
	{
		stopfx(localclientnum, self.var_d634930c);
	}
	self.var_d634930c = util::playfxontag(localclientnum, level._effect[#"soul_charge_impact"], self, "TAG_MOUTH_FX");
}

/*
	Name: function_63eff42e
	Namespace: namespace_60a296cc
	Checksum: 0x85D5E8CA
	Offset: 0xA40
	Size: 0xA2
	Parameters: 7
	Flags: Linked
*/
function function_63eff42e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_d634930c))
	{
		stopfx(localclientnum, self.var_d634930c);
	}
	self.var_d634930c = util::playfxontag(localclientnum, level._effect[#"wolf_bite_blood"], self, "TAG_MOUTH_FX");
}

/*
	Name: function_dfe17a5d
	Namespace: namespace_60a296cc
	Checksum: 0xB81674AD
	Offset: 0xAF0
	Size: 0x13A
	Parameters: 7
	Flags: Linked
*/
function function_dfe17a5d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		if(isdefined(self.n_fx_id))
		{
			killfx(localclientnum, self.n_fx_id);
			self.n_fx_id = undefined;
		}
	}
	else if(newval > 0)
	{
		e_player = getentbynum(localclientnum, newval - 1);
		a_e_players = getlocalplayers();
		if(array::contains(a_e_players, e_player))
		{
			self.n_fx_id = playfx(localclientnum, level._effect[#"tomahawk_pickup"], self.origin - vectorscale((0, 0, 1), 24));
		}
	}
}

/*
	Name: function_724af26a
	Namespace: namespace_60a296cc
	Checksum: 0xA46CBB8C
	Offset: 0xC38
	Size: 0x122
	Parameters: 7
	Flags: Linked
*/
function function_724af26a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		if(isdefined(self.var_e7b65a20))
		{
			killfx(localclientnum, self.var_e7b65a20);
			self.var_e7b65a20 = undefined;
		}
	}
	else
	{
		e_player = getentbynum(localclientnum, newval - 1);
		a_e_players = getlocalplayers();
		if(array::contains(a_e_players, e_player))
		{
			self.var_e7b65a20 = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup_upgrade"], self, "tag_origin");
		}
	}
}

/*
	Name: function_1302ffdd
	Namespace: namespace_60a296cc
	Checksum: 0xC2E3F05B
	Offset: 0xD68
	Size: 0xF2
	Parameters: 7
	Flags: Linked
*/
function function_1302ffdd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_4488630f = struct::get("s_tom_fx");
	if(isdefined(self.var_18331887))
	{
		killfx(localclientnum, self.var_18331887);
		self.var_18331887 = undefined;
	}
	if(newval)
	{
		self.var_18331887 = playfx(localclientnum, level._effect[#"tomahawk_pickup"], var_4488630f.origin - vectorscale((0, 0, 1), 24));
	}
}

/*
	Name: function_c17bd665
	Namespace: namespace_60a296cc
	Checksum: 0xF5BFBED0
	Offset: 0xE68
	Size: 0xF2
	Parameters: 7
	Flags: Linked
*/
function function_c17bd665(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_4488630f = struct::get("s_tom_fx");
	if(isdefined(self.var_18331887))
	{
		killfx(localclientnum, self.var_18331887);
		self.var_18331887 = undefined;
	}
	if(newval)
	{
		self.var_18331887 = playfx(localclientnum, level._effect[#"tomahawk_pickup_upgrade"], var_4488630f.origin - vectorscale((0, 0, 1), 24));
	}
}

