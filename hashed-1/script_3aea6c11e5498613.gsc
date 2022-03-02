// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_d41295e8;

/*
	Name: function_89f2df9
	Namespace: namespace_d41295e8
	Checksum: 0xD0DC9FDB
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"ray_gun_mk2v", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d41295e8
	Checksum: 0x1B209169
	Offset: 0x190
	Size: 0x364
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_115fbee47e748af2"] = #"hash_26ac45625e745ea8";
	level._effect[#"hash_1158b2e47e6e57e0"] = #"hash_26ac45625e745ea8";
	level._effect[#"hash_278ec0c224a81e7"] = #"hash_137c5ba31b8e6395";
	level._effect[#"hash_6039940c56f50818"] = #"zm_weapons/fx8_aat_elec_torso";
	level._effect[#"hash_670449447f448da"] = #"zm_weapons/fx8_aat_elec_eye";
	level._effect[#"hash_66d2b9447f1e888"] = #"zm_weapons/fx8_aat_elec_exp";
	level._effect[#"ray_gun_mk2v_death"] = #"hash_4b0f5fb2f910fe94";
	clientfield::register("allplayers", "" + #"hash_15cff60ea68de320", 20000, 2, "int", &function_9438f132, 0, 1);
	clientfield::register("allplayers", "" + #"hash_7f4f3fbb9ccded2e", 20000, 1, "int", &flash_fx, 0, 0);
	clientfield::register("actor", "" + #"hash_784061e6c2684e58", 20000, 1, "int", &function_84a63db9, 0, 0);
	clientfield::register("actor", "" + #"hash_3b193ae69f9f4fac", 20000, 1, "counter", &function_97482bc3, 0, 0);
	clientfield::register("actor", "" + #"ray_gun_mk2v_death", 20000, 1, "int", &death_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_278ec0c224a81e7", 20000, 1, "int", &function_4013653a, 0, 0);
}

/*
	Name: function_9438f132
	Namespace: namespace_d41295e8
	Checksum: 0x53B028DD
	Offset: 0x500
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_9438f132(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death", #"disconnect");
	self function_efbf12ac(localclientnum);
	if(newval > 0)
	{
		self thread function_e7a7ac96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
}

/*
	Name: function_efbf12ac
	Namespace: namespace_d41295e8
	Checksum: 0xBBF03A3F
	Offset: 0x5B8
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_efbf12ac(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"hash_5423f6c5db580daa");
	if(isdefined(self.var_21553ca5))
	{
		beamkill(localclientnum, self.var_21553ca5);
		self.var_21553ca5 = undefined;
	}
	if(isdefined(self.var_d1f92a1c))
	{
		self.var_d1f92a1c delete();
		self.var_d1f92a1c = undefined;
	}
}

/*
	Name: function_e7a7ac96
	Namespace: namespace_d41295e8
	Checksum: 0xE5C40CB8
	Offset: 0x650
	Size: 0x10A
	Parameters: 7
	Flags: Linked
*/
function function_e7a7ac96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_5423f6c5db580daa");
	self.var_d1f92a1c = util::spawn_model(localclientnum, "tag_origin", self.origin + vectorscale((0, 0, 1), 4000));
	var_be18b9fb = "beam8_zm_raygun2v_elec";
	if(newval > 1)
	{
		var_be18b9fb = "beam8_zm_raygun2v_ug_elec";
	}
	self.var_21553ca5 = level beam::function_cfb2f62a(localclientnum, self, "tag_flash", self.var_d1f92a1c, "tag_origin", var_be18b9fb);
}

/*
	Name: flash_fx
	Namespace: namespace_d41295e8
	Checksum: 0xFEF27540
	Offset: 0x768
	Size: 0x19A
	Parameters: 7
	Flags: Linked
*/
function flash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!self hasdobj(localclientnum))
	{
		return;
	}
	if(isdefined(self.fx_muzzle_flash))
	{
		deletefx(localclientnum, self.fx_muzzle_flash);
		self.fx_muzzle_flash = undefined;
	}
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(newval > 0)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			if(viewmodelhastag(localclientnum, "tag_flash"))
			{
				self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[#"hash_115fbee47e748af2"], "tag_flash");
			}
		}
		else if(isdefined(self gettagorigin("tag_flash")))
		{
			self.fx_muzzle_flash = util::playfxontag(localclientnum, level._effect[#"hash_1158b2e47e6e57e0"], self, "tag_flash");
		}
	}
}

/*
	Name: function_84a63db9
	Namespace: namespace_d41295e8
	Checksum: 0x9D197363
	Offset: 0x910
	Size: 0x1BE
	Parameters: 7
	Flags: Linked
*/
function function_84a63db9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_fx_tag = self zm_utility::function_467efa7b(1);
		if(!isdefined(str_fx_tag))
		{
			str_fx_tag = "tag_origin";
		}
		self.var_d4f84669 = util::playfxontag(localclientnum, level._effect[#"hash_6039940c56f50818"], self, str_fx_tag);
		self.var_38e2508e = util::playfxontag(localclientnum, level._effect[#"hash_670449447f448da"], self, "j_eyeball_le");
		if(!isdefined(self.var_12941c1d))
		{
			self.var_12941c1d = self playloopsound("zmb_aat_kilowatt_stunned_lp");
		}
	}
	else if(isdefined(self.var_d4f84669))
	{
		stopfx(localclientnum, self.var_d4f84669);
		self.var_d4f84669 = undefined;
		stopfx(localclientnum, self.var_38e2508e);
		self.var_38e2508e = undefined;
		if(isdefined(self.var_12941c1d))
		{
			self stoploopsound(self.var_12941c1d);
			self.var_12941c1d = undefined;
		}
	}
}

/*
	Name: function_97482bc3
	Namespace: namespace_d41295e8
	Checksum: 0xAEAC3E71
	Offset: 0xAD8
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_97482bc3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));
		if(!isdefined(v_fx_origin))
		{
			v_fx_origin = self.origin;
		}
		playfx(localclientnum, level._effect[#"hash_66d2b9447f1e888"], v_fx_origin);
		self playsound(localclientnum, #"zmb_aat_kilowatt_explode");
	}
}

/*
	Name: function_4013653a
	Namespace: namespace_d41295e8
	Checksum: 0x5EDCA0D5
	Offset: 0xBC8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_4013653a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_278ec0c224a81e7"], self, "tag_origin");
}

/*
	Name: death_fx
	Namespace: namespace_d41295e8
	Checksum: 0xB9D26123
	Offset: 0xC48
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		str_tag = self zm_utility::function_467efa7b(1);
		util::playfxontag(localclientnum, level._effect[#"ray_gun_mk2v_death"], self, str_tag);
	}
}

