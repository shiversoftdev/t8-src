// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_ec6b032;

/*
	Name: function_89f2df9
	Namespace: namespace_ec6b032
	Checksum: 0x9D819F64
	Offset: 0x2E8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4f9f7fa7527fb431", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ec6b032
	Checksum: 0xACCE9D37
	Offset: 0x330
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_1c1a8ed8d0bf271c", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: namespace_ec6b032
	Checksum: 0x87122C8D
	Offset: 0x378
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"hash_377149a415143f1b", &function_37236662, &function_6705773b);
	zm_perks::register_perk_init_thread(#"hash_377149a415143f1b", &init);
	zm_perks::function_b60f4a9f(#"hash_377149a415143f1b", #"hash_2c7d417ffd8a2a0", "zombie/fx8_perk_altar_symbol_ambient_blaze_phase", #"hash_544b157a9fa6573d");
	zm_perks::function_f3c80d73("zombie_perk_bottle_death_dash", "zombie_perk_totem_death_dash");
}

/*
	Name: init
	Namespace: namespace_ec6b032
	Checksum: 0x80F724D1
	Offset: 0x460
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: function_37236662
	Namespace: namespace_ec6b032
	Checksum: 0x83901AFD
	Offset: 0x470
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_37236662()
{
	clientfield::register("allplayers", "death_dash_charging", 24000, 1, "int", &function_bfd817c1, 0, 0);
	clientfield::register("allplayers", "death_dash_charged", 24000, 1, "int", &function_fe2634b2, 0, 0);
	clientfield::register("allplayers", "death_dash_charged_mod", 24000, 1, "int", &function_237b1f1e, 0, 0);
	clientfield::register("allplayers", "death_dash_trail", 24000, 1, "int", &function_dced8aba, 0, 0);
	clientfield::register("toplayer", "death_dash_charging_postfx", 24000, 1, "int", &function_fbdede2b, 0, 0);
	clientfield::register("toplayer", "death_dash_dash_postfx", 24000, 1, "int", &function_c8a1ee6b, 0, 0);
	clientfield::register("toplayer", "death_dash_charged_mod_postfx", 24000, 1, "int", &function_cc24f836, 0, 0);
}

/*
	Name: function_6705773b
	Namespace: namespace_ec6b032
	Checksum: 0x80F724D1
	Offset: 0x678
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_6705773b()
{
}

/*
	Name: function_bfd817c1
	Namespace: namespace_ec6b032
	Checksum: 0x937B1491
	Offset: 0x688
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_bfd817c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_db7bd81e = util::playfxontag(localclientnum, "zombie/fx8_perk_blaze_phase_charging", self, "tag_origin");
		if(!isdefined(self.var_51a4a975))
		{
			self.var_51a4a975 = self playloopsound(#"hash_4d72f993ab3784d0");
		}
		self playrumbleonentity(localclientnum, #"damage_light");
	}
	else if(isdefined(self.var_db7bd81e))
	{
		stopfx(localclientnum, self.var_db7bd81e);
		self.var_db7bd81e = undefined;
	}
	if(isdefined(self.var_51a4a975))
	{
		self stoploopsound(self.var_51a4a975);
		self.var_51a4a975 = undefined;
	}
}

/*
	Name: function_fe2634b2
	Namespace: namespace_ec6b032
	Checksum: 0x92AAF6A9
	Offset: 0x7D8
	Size: 0x176
	Parameters: 7
	Flags: Linked
*/
function function_fe2634b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_64630ee8 = util::playfxontag(localclientnum, "zombie/fx8_perk_blaze_phase_charged", self, "tag_origin");
		if(!isdefined(self.var_202e9919))
		{
			self.var_202e9919 = self playloopsound(#"hash_1bd81725dee72cb");
		}
		if(isdefined(self.var_51a4a975))
		{
			self stoploopsound(self.var_51a4a975);
			self.var_51a4a975 = undefined;
		}
		self playrumbleonentity(localclientnum, #"damage_light");
	}
	else if(isdefined(self.var_64630ee8))
	{
		stopfx(localclientnum, self.var_64630ee8);
		self.var_64630ee8 = undefined;
	}
	if(isdefined(self.var_202e9919))
	{
		self stoploopsound(self.var_202e9919);
		self.var_202e9919 = undefined;
	}
}

/*
	Name: function_237b1f1e
	Namespace: namespace_ec6b032
	Checksum: 0x9F5A9CFD
	Offset: 0x958
	Size: 0x176
	Parameters: 7
	Flags: Linked
*/
function function_237b1f1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_c1726d31 = util::playfxontag(localclientnum, "zombie/fx8_perk_blaze_phase_charged_stretch", self, "tag_origin");
		if(!isdefined(self.var_202e9919))
		{
			self.var_202e9919 = self playloopsound(#"hash_1bd81725dee72cb");
		}
		if(isdefined(self.var_51a4a975))
		{
			self stoploopsound(self.var_51a4a975);
			self.var_51a4a975 = undefined;
		}
		self playrumbleonentity(localclientnum, #"damage_heavy");
	}
	else if(isdefined(self.var_c1726d31))
	{
		stopfx(localclientnum, self.var_c1726d31);
		self.var_c1726d31 = undefined;
	}
	if(isdefined(self.var_202e9919))
	{
		self stoploopsound(self.var_202e9919);
		self.var_202e9919 = undefined;
	}
}

/*
	Name: function_dced8aba
	Namespace: namespace_ec6b032
	Checksum: 0x26108400
	Offset: 0xAD8
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function function_dced8aba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_80098dea = util::playfxontag(localclientnum, "zombie/fx8_perk_blaze_phase_trail", self, "tag_origin");
		if(!isdefined(self.var_884925ad))
		{
			self playsound(localclientnum, #"hash_1075f6d6c2524599");
			self.var_884925ad = self playloopsound(#"hash_fa14d87437616df");
		}
	}
	else if(isdefined(self.var_80098dea))
	{
		stopfx(localclientnum, self.var_80098dea);
		self.var_80098dea = undefined;
	}
	if(isdefined(self.var_884925ad))
	{
		self playsound(localclientnum, #"hash_42cb90d7c4d6ad08");
		self stoploopsound(self.var_884925ad);
		self.var_884925ad = undefined;
	}
	self playrumbleonentity(localclientnum, "damage_heavy");
}

/*
	Name: function_fbdede2b
	Namespace: namespace_ec6b032
	Checksum: 0x78755345
	Offset: 0xC70
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_fbdede2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self postfx::playpostfxbundle("pstfx_burn_loop_blaze_phaze");
	}
	else
	{
		self postfx::stoppostfxbundle("pstfx_burn_loop_blaze_phaze");
	}
}

/*
	Name: function_c8a1ee6b
	Namespace: namespace_ec6b032
	Checksum: 0xF0BFD176
	Offset: 0xD00
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_c8a1ee6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self postfx::stoppostfxbundle("pstfx_zm_chakram_speedblur");
		self postfx::playpostfxbundle("pstfx_zm_chakram_speedblur");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_zm_chakram_speedblur");
	}
}

/*
	Name: function_cc24f836
	Namespace: namespace_ec6b032
	Checksum: 0xB3C08E21
	Offset: 0xDB0
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_cc24f836(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self postfx::stoppostfxbundle("pstfx_zm_fire_blue_trap");
		self postfx::playpostfxbundle("pstfx_zm_fire_blue_trap");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_zm_fire_blue_trap");
	}
}

