// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_electric_cherry;

/*
	Name: function_89f2df9
	Namespace: zm_perk_electric_cherry
	Checksum: 0x8004A7F9
	Offset: 0x1E8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_perk_electric_cherry", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_electric_cherry
	Checksum: 0xFA42616E
	Offset: 0x230
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"specialty_electriccherry", &electric_cherry_client_field_func, &electric_cherry_code_callback_func);
	zm_perks::register_perk_effects(#"specialty_electriccherry", "electric_cherry_light");
	zm_perks::register_perk_init_thread(#"specialty_electriccherry", &init_electric_cherry);
	zm_perks::function_b60f4a9f(#"specialty_electriccherry", #"hash_415de96df488bf83", "zombie/fx8_perk_altar_symbol_ambient_electric_cherry", #"hash_77c5cc2d9b6ca16c");
	zm_perks::function_f3c80d73("zombie_perk_bottle_cherry", "zombie_perk_totem_electric_burst");
}

/*
	Name: init_electric_cherry
	Namespace: zm_perk_electric_cherry
	Checksum: 0xDC52733E
	Offset: 0x340
	Size: 0x2A2
	Parameters: 0
	Flags: Linked
*/
function init_electric_cherry()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"electric_cherry_light"] = #"hash_1442db17b83460ad";
	}
	clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int", &electric_cherry_reload_attack_fx, 0, 0);
	clientfield::register("actor", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
	clientfield::register("vehicle", "tesla_death_fx_veh", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
	clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
	clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
	level._effect[#"electric_cherry_explode"] = #"hash_413a313438a3a4e1";
	level._effect[#"electric_cherry_trail"] = #"hash_58c2d7d24c0d61a7";
	level._effect[#"tesla_death_cherry"] = #"zombie/fx_tesla_shock_zmb";
	level._effect[#"tesla_shock_eyes_cherry"] = #"zombie/fx_tesla_shock_eyes_zmb";
	level._effect[#"tesla_shock_cherry"] = #"zombie/fx_bmode_shock_os_zod_zmb";
}

/*
	Name: electric_cherry_client_field_func
	Namespace: zm_perk_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x5F0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_client_field_func()
{
}

/*
	Name: electric_cherry_code_callback_func
	Namespace: zm_perk_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x600
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_code_callback_func()
{
}

/*
	Name: electric_cherry_reload_attack_fx
	Namespace: zm_perk_electric_cherry
	Checksum: 0x4842FF75
	Offset: 0x610
	Size: 0x122
	Parameters: 7
	Flags: Linked
*/
function electric_cherry_reload_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.electric_cherry_reload_fx))
	{
		stopfx(localclientnum, self.electric_cherry_reload_fx);
		self.electric_cherry_reload_fx = undefined;
	}
	switch(newval)
	{
		case 1:
		case 2:
		case 3:
		{
			self.electric_cherry_reload_fx = util::playfxontag(localclientnum, level._effect[#"electric_cherry_explode"], self, "tag_origin");
			break;
		}
	}
}

/*
	Name: tesla_death_fx_callback
	Namespace: zm_perk_electric_cherry
	Checksum: 0xEC2AF631
	Offset: 0x740
	Size: 0x1F6
	Parameters: 7
	Flags: Linked
*/
function tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval == 1)
	{
		str_tag = "J_SpineUpper";
		if(isdefined(self.str_tag_tesla_death_fx))
		{
			str_tag = self.str_tag_tesla_death_fx;
		}
		else if(isdefined(self.isdog) && self.isdog)
		{
			str_tag = "J_Spine1";
		}
		if(!isdefined(self.var_16e53a57))
		{
			self playsound(localclientnum, #"hash_3b277f4572603015");
			self.var_16e53a57 = self playloopsound(#"hash_2f0f235f7f6fc84d");
		}
		self.n_death_fx = util::playfxontag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);
		if(isdefined(self.n_death_fx))
		{
			setfxignorepause(localclientnum, self.n_death_fx, 1);
		}
	}
	else if(isdefined(self.n_death_fx))
	{
		deletefx(localclientnum, self.n_death_fx, 1);
		self.n_death_fx = undefined;
	}
	if(isdefined(self.var_16e53a57))
	{
		self stoploopsound(self.var_16e53a57);
		self.var_16e53a57 = undefined;
	}
}

/*
	Name: tesla_shock_eyes_fx_callback
	Namespace: zm_perk_electric_cherry
	Checksum: 0xFA342FE2
	Offset: 0x940
	Size: 0x2B6
	Parameters: 7
	Flags: Linked
*/
function tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval == 1)
	{
		str_tag = "J_SpineUpper";
		if(isdefined(self.str_tag_tesla_shock_eyes_fx))
		{
			str_tag = self.str_tag_tesla_shock_eyes_fx;
		}
		else if(isdefined(self.isdog) && self.isdog)
		{
			str_tag = "J_Spine1";
		}
		if(!isdefined(self.var_16e53a57))
		{
			self playsound(localclientnum, #"hash_3b277f4572603015");
			self.var_16e53a57 = self playloopsound(#"hash_2f0f235f7f6fc84d");
		}
		self.n_shock_eyes_fx = util::playfxontag(localclientnum, level._effect[#"tesla_shock_eyes_cherry"], self, "J_Eyeball_LE");
		if(isdefined(self) && isdefined(self.n_shock_eyes_fx))
		{
			setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
		}
		self.n_shock_fx = util::playfxontag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);
		if(isdefined(self) && isdefined(self.n_shock_eyes_fx))
		{
			setfxignorepause(localclientnum, self.n_shock_fx, 1);
		}
	}
	else if(isdefined(self.n_shock_eyes_fx))
	{
		deletefx(localclientnum, self.n_shock_eyes_fx, 1);
		self.n_shock_eyes_fx = undefined;
	}
	if(isdefined(self.n_shock_fx))
	{
		deletefx(localclientnum, self.n_shock_fx, 1);
		self.n_shock_fx = undefined;
	}
	if(isdefined(self.var_16e53a57))
	{
		self stoploopsound(self.var_16e53a57);
		self.var_16e53a57 = undefined;
	}
}

