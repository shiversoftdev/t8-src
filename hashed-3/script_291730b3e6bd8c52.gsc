// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_260abbdf1ff0aa9a;
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_83bc53d2;

/*
	Name: function_89f2df9
	Namespace: namespace_83bc53d2
	Checksum: 0x91864D0A
	Offset: 0x418
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4bca7168ca976d7f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_83bc53d2
	Checksum: 0x9C214B01
	Offset: 0x460
	Size: 0x1CC
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!isarchetypeloaded(#"catalyst"))
	{
		return;
	}
	level._effect[#"hash_30c9f7c5634dd1dc"] = "zm_weapons/fx8_aat_opposite_exp";
	level._effect[#"hash_390fbb50a6b5a228"] = "zm_ai/fx8_cata_cor_aura";
	level._effect[#"hash_639f073aee9c643"] = "zm_ai/fx8_cata_cor_aura_locked";
	level._effect[#"hash_5f870c6f09760971"] = "zm_ai/fx8_cata_water_purify";
	level._effect[#"hash_7fb3b46f4bd12a2"] = "zm_ai/fx8_cata_elec_blast";
	level._effect[#"hash_7fb3b46f4bd12a2"] = "zm_ai/fx8_cata_elec_blast";
	level._effect[#"hash_30656ca97fa97a81"] = "zm_ai/fx8_cata_plasma_blast";
	level._effect[#"hash_1be360ed968399f0"] = "zm_ai/fx8_cata_plasma_blast_tell_head";
	level._effect[#"hash_74a34e22285cf305"] = "zm_ai/fx8_cata_plasma_blast_tell_torso";
	function_b6fd8c68();
	ai::add_archetype_spawn_function(#"catalyst", &function_5608540a);
}

/*
	Name: function_b6fd8c68
	Namespace: namespace_83bc53d2
	Checksum: 0xF8365BAE
	Offset: 0x638
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_b6fd8c68()
{
	clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int", &function_213aaacc, 0, 0);
	clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter", &function_b3c2dc1c, 0, 0);
	clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int", &function_8cc5be3b, 0, 0);
	clientfield::register("actor", "water_catalyst_purified", 1, 1, "int", &function_72d9d9e7, 0, 0);
	clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int", &function_dce55f49, 0, 0);
	clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int", &function_1578a764, 0, 0);
	clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int", &function_5c22755, 0, 0);
}

/*
	Name: function_213aaacc
	Namespace: namespace_83bc53d2
	Checksum: 0x68D0E4F4
	Offset: 0x840
	Size: 0x14C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_213aaacc(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	self util::waittill_dobj(localclientnum);
	switch(newvalue)
	{
		case 1:
		{
			spawn_sfx = "zmb_ai_catalyst_corrosive_spawn";
			break;
		}
		case 4:
		{
			spawn_sfx = "zmb_ai_catalyst_water_spawn";
			break;
		}
		case 3:
		{
			spawn_sfx = "zmb_ai_catalyst_electric_spawn";
			break;
		}
		case 2:
		{
			spawn_sfx = "zmb_ai_catalyst_plasma_spawn";
			break;
		}
		default:
		{
			fxclientutils::function_ae92446(localclientnum, self, self.fxdef);
			return;
		}
	}
	if(isdefined(self))
	{
		fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
	}
}

/*
	Name: function_b3c2dc1c
	Namespace: namespace_83bc53d2
	Checksum: 0x4F48B3BF
	Offset: 0x998
	Size: 0x9C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_b3c2dc1c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_30c9f7c5634dd1dc"], self, "j_spine4");
	playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
}

/*
	Name: function_8cc5be3b
	Namespace: namespace_83bc53d2
	Checksum: 0x5737973E
	Offset: 0xA40
	Size: 0x194
	Parameters: 7
	Flags: Linked, Private
*/
private function function_8cc5be3b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		self.var_565b4840 = util::playfxontag(localclientnum, level._effect[#"hash_390fbb50a6b5a228"], self, "j_spine4");
		self.var_430cfa87 = util::playfxontag(localclientnum, level._effect[#"hash_639f073aee9c643"], self, "tag_origin");
		if(!isdefined(self.var_8c3a51be))
		{
			self.var_8c3a51be = self playloopsound("zmb_ai_catalyst_corrosive_lp");
		}
	}
	else if(isdefined(self.var_565b4840))
	{
		stopfx(localclientnum, self.var_565b4840);
		self.var_565b4840 = undefined;
	}
	if(isdefined(self.var_430cfa87))
	{
		stopfx(localclientnum, self.var_430cfa87);
		self.var_430cfa87 = undefined;
	}
	if(isdefined(self.var_8c3a51be))
	{
		self stoploopsound(self.var_8c3a51be);
	}
}

/*
	Name: function_72d9d9e7
	Namespace: namespace_83bc53d2
	Checksum: 0x3F55DB04
	Offset: 0xBE0
	Size: 0x186
	Parameters: 7
	Flags: Linked, Private
*/
private function function_72d9d9e7(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue === 1)
	{
		self.var_5fe1f99b = util::playfxontag(localclientnum, level._effect[#"hash_5f870c6f09760971"], self, "tag_eye");
		if(!isdefined(self.var_983b7af9))
		{
			self playsound(localclientnum, #"hash_56157e961854c964");
			self.var_983b7af9 = self playloopsound(#"hash_4d16df16d08f6404");
		}
	}
	else if(isdefined(self.var_5fe1f99b))
	{
		stopfx(localclientnum, self.var_5fe1f99b);
		self.var_5fe1f99b = undefined;
	}
	if(isdefined(self.var_983b7af9))
	{
		self playsound(localclientnum, #"hash_58e6fac48dd8515d");
		self stoploopsound(self.var_983b7af9);
		self.var_983b7af9 = undefined;
	}
}

/*
	Name: function_dce55f49
	Namespace: namespace_83bc53d2
	Checksum: 0x8B895A48
	Offset: 0xD70
	Size: 0xD6
	Parameters: 7
	Flags: Linked, Private
*/
private function function_dce55f49(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue === 1)
	{
		self playsound(localclientnum, #"hash_579a9e520b10d768");
		self thread function_8c78e227(localclientnum);
	}
	else if(isdefined(self.var_5e3f0a3c))
	{
		stopfx(localclientnum, self.var_5e3f0a3c);
		self.var_5e3f0a3c = undefined;
		self notify(#"scream_attack_done");
	}
}

/*
	Name: function_8c78e227
	Namespace: namespace_83bc53d2
	Checksum: 0xB1ED09EA
	Offset: 0xE50
	Size: 0x13C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8c78e227(localclientnum)
{
	self notify(#"hash_28942d030dbe705");
	self endon(#"hash_28942d030dbe705");
	if(isdefined(self.var_c1e13a67))
	{
		self.var_c1e13a67 delete();
	}
	str_tag = "tag_eye";
	v_origin = self gettagorigin(str_tag);
	self.var_c1e13a67 = util::spawn_model(localclientnum, "tag_origin", v_origin, self.angles);
	self.var_5e3f0a3c = util::playfxontag(localclientnum, level._effect[#"hash_7fb3b46f4bd12a2"], self.var_c1e13a67, "tag_origin");
	self waittill(#"death", #"scream_attack_done");
	self.var_c1e13a67 delete();
}

/*
	Name: function_1578a764
	Namespace: namespace_83bc53d2
	Checksum: 0xF02C27E3
	Offset: 0xF98
	Size: 0xC4
	Parameters: 7
	Flags: Linked, Private
*/
private function function_1578a764(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_30656ca97fa97a81"], self, "j_spine4");
	playsound(0, #"hash_7d7c027e3b78c5b6", self.origin);
	function_2a9101fe(localclientnum, #"hash_528115ad9eebc84f", self.origin);
}

/*
	Name: function_5c22755
	Namespace: namespace_83bc53d2
	Checksum: 0xD9779E91
	Offset: 0x1068
	Size: 0x15C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_5c22755(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	self util::waittill_dobj(localclientnum);
	if(newvalue && isdefined(self) && self.var_9fde8624 === #"hash_78ca8e8e6bdbc8ab")
	{
		animname = self getprimarydeltaanim();
		if(!isdefined(animname) || (animname != "ai_t8_zm_zod_catalyst_corrosive_death_01" && animname != "ai_t8_zm_zod_catalyst_corrosive_death_02"))
		{
			animname = "ai_t8_zm_zod_catalyst_corrosive_death_01";
		}
		script_model = util::spawn_anim_model(localclientnum, "c_t8_zmb_catalyst_decay_body_noreveal", self gettagorigin("j_mainroot"), self.angles);
		if(isdefined(script_model))
		{
			script_model attach("c_t8_zmb_catalyst_decay_head_noreveal");
			script_model thread function_ce9e3dc7(animname);
		}
	}
}

/*
	Name: function_ce9e3dc7
	Namespace: namespace_83bc53d2
	Checksum: 0xEB6F2090
	Offset: 0x11D0
	Size: 0x124
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ce9e3dc7(animname)
{
	self endon(#"death");
	var_1d3061ce = animname + "_scale";
	animlength = int(getanimlength(var_1d3061ce) * 1000);
	if(animlength <= 0)
	{
		return;
	}
	starttime = gettime();
	endtime = starttime + animlength;
	self thread animation::play(var_1d3061ce);
	while(endtime > gettime())
	{
		scale = 1 - gettime() - starttime / animlength;
		if(scale > 0)
		{
			self setscale(scale);
		}
		waitframe(1);
	}
	self delete();
}

/*
	Name: function_5608540a
	Namespace: namespace_83bc53d2
	Checksum: 0x9E735D7E
	Offset: 0x1300
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5608540a(localclientnum)
{
	self.var_fab3cf78 = #"hash_10bdf06ea5640d49";
}

