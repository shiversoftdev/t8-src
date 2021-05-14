// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_aat_brain_decay;

/*
	Name: function_89f2df9
	Namespace: zm_aat_brain_decay
	Checksum: 0xEFBF62AA
	Offset: 0x1C0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("zm_aat_brain_decay", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_aat_brain_decay
	Checksum: 0x7B49959D
	Offset: 0x200
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_brain_decay", #"hash_3c1c6f0860be6c5", "t7_icon_zm_aat_turned");
	clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int", &function_791e18ed, 0, 0);
	clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int", &function_791e18ed, 0, 0);
	clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
	clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
	renderoverridebundle::function_f72f089c(#"hash_5afb2d74423459bf", "rob_sonar_set_friendly_zm", &function_b9c917cc);
}

/*
	Name: function_791e18ed
	Namespace: zm_aat_brain_decay
	Checksum: 0x49B0F3AA
	Offset: 0x3B8
	Size: 0x2E4
	Parameters: 7
	Flags: Linked
*/
function function_791e18ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self renderoverridebundle::function_c8d97b8e(localclientnum, #"hash_5d0631b016d4fe26", #"hash_5afb2d74423459bf");
	if(newval)
	{
		self setdrawname(#"hash_3a9d51a39880facd", 1);
		str_fx_tag = self zm_utility::function_467efa7b(1);
		if(!isdefined(str_fx_tag))
		{
			str_fx_tag = "tag_origin";
		}
		eye_pos = self gettagorigin("j_eyeball_le");
		if(isdefined(eye_pos))
		{
			self.var_8c12ae9 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_eye", self, "j_eyeball_le");
		}
		self.var_8dfe2b97 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_torso", self, str_fx_tag);
		if(!isdefined(self.var_67857d4d))
		{
			self playsound(localclientnum, #"hash_637c5e1579bb239a");
			self.var_67857d4d = self playloopsound(#"hash_6064261162c8a2e");
		}
		if(isdefined(self.var_4703d488))
		{
			self [[self.var_4703d488]](localclientnum, newval);
		}
	}
	else if(isdefined(self.var_8c12ae9))
	{
		stopfx(localclientnum, self.var_8c12ae9);
		self.var_8c12ae9 = undefined;
	}
	if(isdefined(self.var_4bc659c4))
	{
		stopfx(localclientnum, self.var_4bc659c4);
		self.var_4bc659c4 = undefined;
	}
	if(isdefined(self.var_8dfe2b97))
	{
		stopfx(localclientnum, self.var_8dfe2b97);
		self.var_8dfe2b97 = undefined;
	}
	if(isdefined(self.var_67857d4d))
	{
		self stoploopsound(self.var_67857d4d);
		self.var_67857d4d = undefined;
	}
	if(isdefined(self.var_4703d488))
	{
		self [[self.var_4703d488]](localclientnum, newval);
	}
}

/*
	Name: function_b9c917cc
	Namespace: zm_aat_brain_decay
	Checksum: 0xE284431C
	Offset: 0x6A8
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_b9c917cc(localclientnum, str_bundle)
{
	if(!self function_ca024039() || (isdefined(level.var_dc60105c) && level.var_dc60105c) || isigcactive(localclientnum))
	{
		return 0;
	}
	return 1;
}

/*
	Name: zm_aat_brain_decay_explosion
	Namespace: zm_aat_brain_decay
	Checksum: 0x69C17BFA
	Offset: 0x720
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function zm_aat_brain_decay_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_head", self, "j_head");
	self playsound(0, #"hash_422ccb7ddff9b3f4");
}

