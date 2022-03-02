// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_1961df59;

/*
	Name: function_89f2df9
	Namespace: namespace_1961df59
	Checksum: 0x1175ABB
	Offset: 0x1C0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7b83cad7c8661103", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1961df59
	Checksum: 0xD137A0A0
	Offset: 0x208
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"hash_6da63d760c1788e2", &function_e4d3a447, &function_82460430);
	zm_perks::register_perk_effects(#"hash_6da63d760c1788e2", "ethereal_razor_light");
	zm_perks::register_perk_init_thread(#"hash_6da63d760c1788e2", &function_32981481);
	zm_perks::function_b60f4a9f(#"hash_6da63d760c1788e2", #"hash_fa99ca2546a082", "zombie/fx8_perk_altar_symbol_ambient_ethereal_razor", #"hash_2635890f53e8633d");
	zm_perks::function_f3c80d73("zombie_perk_bottle_ethereal_razor", "zombie_perk_totem_ethereal_razor");
	clientfield::register("actor", "" + #"hash_29c26fb019da89f3", 13000, 1, "counter", &function_f041176c, 0, 0);
	clientfield::register("allplayers", "" + #"hash_450d9f824068dcc2", 13000, 1, "counter", &function_8f9318d5, 0, 0);
	clientfield::register("allplayers", "" + #"hash_4de2dbcd551f1fb7", 13000, 1, "counter", &function_680538e2, 0, 0);
	level._effect[#"hash_450693824062a9b0"] = #"hash_2e1db0f023ce973f";
	level._effect[#"hash_450d9f824068dcc2"] = #"hash_2e16c4f023c89a8d";
	level._effect[#"hash_5200740c0a0b2719"] = #"hash_2a3552f078e23d4e";
	level._effect[#"hash_4de2dbcd551f1fb7"] = #"hash_4741ce659d06a390";
	level._effect[#"hash_29c26fb019da89f3"] = #"hash_6e2b2bcea07134d1";
	callback::on_localplayer_spawned(&on_localplayer_spawned);
}

/*
	Name: on_localplayer_spawned
	Namespace: namespace_1961df59
	Checksum: 0x95EFB974
	Offset: 0x530
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	self thread function_58c4bf12(localclientnum);
}

/*
	Name: function_32981481
	Namespace: namespace_1961df59
	Checksum: 0xAD225DFE
	Offset: 0x560
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_32981481()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"ethereal_razor_light"] = #"hash_1442db17b83460ad";
	}
}

/*
	Name: function_e4d3a447
	Namespace: namespace_1961df59
	Checksum: 0x80F724D1
	Offset: 0x5C0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_e4d3a447()
{
}

/*
	Name: function_82460430
	Namespace: namespace_1961df59
	Checksum: 0x80F724D1
	Offset: 0x5D0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_82460430()
{
}

/*
	Name: function_f041176c
	Namespace: namespace_1961df59
	Checksum: 0x6A0A4192
	Offset: 0x5E0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_f041176c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_29c26fb019da89f3"], self, "tag_weapon_chest");
}

/*
	Name: function_8f9318d5
	Namespace: namespace_1961df59
	Checksum: 0xBA2617DA
	Offset: 0x660
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_8f9318d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endoncallback(&function_e6bf47a3, #"death");
	level endoncallback(&function_e6bf47a3, #"demo_jump");
	self function_e6bf47a3();
	if(!self zm_utility::function_f8796df3(localclientnum))
	{
		self.var_e59cd78 = util::playfxontag(localclientnum, level._effect[#"hash_4de2dbcd551f1fb7"], self, self function_a5b9c520(localclientnum));
		wait(0.3);
		self function_e6bf47a3();
	}
}

/*
	Name: function_680538e2
	Namespace: namespace_1961df59
	Checksum: 0x8CAFB9AD
	Offset: 0x788
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_680538e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endoncallback(&function_e6bf47a3, #"death");
	level endoncallback(&function_e6bf47a3, #"demo_jump");
	self function_e6bf47a3();
	if(!self zm_utility::function_f8796df3(localclientnum))
	{
		self.var_e59cd78 = util::playfxontag(localclientnum, level._effect[#"hash_4de2dbcd551f1fb7"], self, self function_a5b9c520(localclientnum));
		wait(0.3);
		self function_e6bf47a3();
	}
}

/*
	Name: function_58c4bf12
	Namespace: namespace_1961df59
	Checksum: 0xEB492AD4
	Offset: 0x8B0
	Size: 0x260
	Parameters: 1
	Flags: Linked
*/
function function_58c4bf12(localclientnum)
{
	self notify("74273462170704a3");
	self endon("74273462170704a3");
	self endoncallback(&function_c8066972, #"death");
	self function_c8066972();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"notetrack");
		str_notetrack = waitresult.notetrack;
		if(str_notetrack === "razor_fx_on" && self hasperk(localclientnum, #"hash_6da63d760c1788e2"))
		{
			w_current = getcurrentweaponincludingmelee(localclientnum);
			if(w_current === level.var_1c0d76f8)
			{
				self.var_9f0aad27 = playviewmodelfx(localclientnum, level._effect[#"hash_5200740c0a0b2719"], "tag_weapon_left");
			}
			else
			{
				if(w_current === level.var_b77d3496)
				{
					self.var_9f0aad27 = playviewmodelfx(localclientnum, level._effect[#"hash_450693824062a9b0"], "tag_weapon_right");
				}
				else
				{
					self.var_9f0aad27 = playviewmodelfx(localclientnum, level._effect[#"hash_450693824062a9b0"], "tag_weapon_left");
				}
			}
			self playsound(localclientnum, #"hash_5e4e6d81b10399dc");
			self util::function_e532f5da(0.8, self, "notetrack", level, "demo_jump");
			self function_c8066972();
		}
	}
}

/*
	Name: function_c8066972
	Namespace: namespace_1961df59
	Checksum: 0xBDBC3A06
	Offset: 0xB18
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_c8066972(str_notify)
{
	if(isdefined(self.var_9f0aad27))
	{
		deletefx(self.localclientnum, self.var_9f0aad27);
		self.var_9f0aad27 = undefined;
	}
}

/*
	Name: function_e6bf47a3
	Namespace: namespace_1961df59
	Checksum: 0x744705F2
	Offset: 0xB68
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_e6bf47a3(str_notify)
{
	if(isdefined(self.var_e59cd78))
	{
		deletefx(self.localclientnum, self.var_e59cd78);
		self.var_e59cd78 = undefined;
	}
}

/*
	Name: function_a5b9c520
	Namespace: namespace_1961df59
	Checksum: 0x5043182F
	Offset: 0xBB8
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function function_a5b9c520(localclientnum)
{
	w_current = getcurrentweaponincludingmelee(localclientnum);
	str_tag = "tag_weapon_left";
	if(w_current === level.var_b77d3496)
	{
		str_tag = "tag_weapon_right";
	}
	return str_tag;
}

