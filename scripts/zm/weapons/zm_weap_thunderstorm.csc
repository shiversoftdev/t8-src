// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_weap_thunderstorm;

/*
	Name: __init__system__
	Namespace: zm_weap_thunderstorm
	Checksum: 0xD139720C
	Offset: 0x158
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_thunderstorm", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_thunderstorm
	Checksum: 0x3913AC70
	Offset: 0x1A8
	Size: 0x44A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"aoe_indicator", 16000, 1, "counter", &function_60d8c392, 0, 0);
	clientfield::register("scriptmover", "" + #"electric_storm", 16000, 1, "int", &function_83e58cf4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_7006a7d528a6f05c", 16000, 3, "int", &function_6e837718, 0, 0);
	clientfield::register("actor", "" + #"hash_51b05e5d116438a9", 16000, 3, "int", &function_46a56fe2, 0, 0);
	clientfield::register("actor", "" + #"hash_561a1fd86bc1a53a", 16000, 1, "int", &function_ab086ad8, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_43cf6c236d2e9ba", 16000, 1, "counter", &function_acecb36a, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1187b848bf7868c5", 16000, 1, "int", &function_5b4619, 0, 0);
	level._effect[#"electric_storm"] = #"hash_162a58538b5d6db0";
	level._effect[#"hash_11c14ffaefdfd970"] = #"hash_515548ac872ebd06";
	level._effect[#"hash_3d5823fb08a48ea1"] = #"hash_58e484ac8b26c8ef";
	level._effect[#"hash_6da9e29916d2ac16"] = #"hash_7668b8e00c2854ae";
	level._effect[#"hash_43cf6c236d2e9ba"] = #"hash_7d7d5c3856622734";
	level._effect[#"electrocute"] = #"hash_5aa1120d061d1f6c";
	level._effect[#"aoe_marker"] = #"hash_211c80023671737b";
	level._effect[#"hash_6bfee027c13054b6"] = #"hash_2dc8e3470244bf1c";
	level._effect[#"hash_788ff1a315628747"] = #"hash_661f2c77e14f0edf";
	level._effect[#"pegasus_teleport"] = #"hash_5f7d8c231fbcf09e";
}

/*
	Name: __main__
	Namespace: zm_weap_thunderstorm
	Checksum: 0x7DB25EA7
	Offset: 0x600
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!zm_weapons::is_weapon_included(getweapon(#"thunderstorm")))
	{
		return;
	}
}

/*
	Name: function_ab086ad8
	Namespace: zm_weap_thunderstorm
	Checksum: 0x80BF38C7
	Offset: 0x640
	Size: 0x156
	Parameters: 7
	Flags: Linked
*/
function function_ab086ad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self gettagorigin("j_eyeball_le")))
		{
			self.var_1550c80f = util::playfxontag(localclientnum, level._effect[#"hemera_proj_death_head"], self, "j_eyeball_le");
		}
		else if(isdefined(self gettagorigin("j_head")))
		{
			self.var_1550c80f = util::playfxontag(localclientnum, level._effect[#"hemera_proj_death_head"], self, "j_head");
		}
	}
	else if(isdefined(self) && isdefined(self.var_1550c80f))
	{
		deletefx(localclientnum, self.var_1550c80f);
		self.var_1550c80f = undefined;
	}
}

/*
	Name: function_60d8c392
	Namespace: zm_weap_thunderstorm
	Checksum: 0xF5375A65
	Offset: 0x7A0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_60d8c392(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::playfxontag(localclientnum, level._effect[#"aoe_marker"], self, "tag_origin");
}

/*
	Name: function_83e58cf4
	Namespace: zm_weap_thunderstorm
	Checksum: 0x14077D6E
	Offset: 0x820
	Size: 0x10A
	Parameters: 7
	Flags: Linked
*/
function function_83e58cf4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			if(isdefined(self.var_d00cf6ff))
			{
				stopfx(localclientnum, self.var_d00cf6ff);
				self.var_d00cf6ff = undefined;
			}
			break;
		}
		case 1:
		{
			self.var_d00cf6ff = playfx(localclientnum, level._effect[#"electric_storm"], self.origin + vectorscale((0, 0, 1), 180), self.angles);
			break;
		}
	}
}

/*
	Name: function_acecb36a
	Namespace: zm_weap_thunderstorm
	Checksum: 0xF89A24E9
	Offset: 0x938
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_acecb36a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_43cf6c236d2e9ba"], self, "tag_origin");
}

/*
	Name: function_6e837718
	Namespace: zm_weap_thunderstorm
	Checksum: 0x32E5A7B8
	Offset: 0x9B8
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_6e837718(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.var_667af8b4[newval] = self;
	if(isdefined(self gettagorigin("j_h_chest")))
	{
		playfx(localclientnum, level._effect[#"pegasus_teleport"], self gettagorigin("j_h_chest"), self gettagangles("j_h_chest"));
	}
	else if(newval == 5)
	{
		playfx(localclientnum, level._effect[#"pegasus_teleport"], self.origin);
	}
}

/*
	Name: function_46a56fe2
	Namespace: zm_weap_thunderstorm
	Checksum: 0x220CA976
	Offset: 0xAE0
	Size: 0x1DC
	Parameters: 7
	Flags: Linked
*/
function function_46a56fe2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!isdefined(level.var_667af8b4))
	{
		return;
	}
	var_10d4f67d = level.var_667af8b4[newval];
	if(!isdefined(var_10d4f67d))
	{
		return;
	}
	if(!newval)
	{
		return;
	}
	var_10d4f67d endon(#"death");
	v_left = var_10d4f67d gettagorigin("j_feather_le_10");
	v_right = var_10d4f67d gettagorigin("j_feather_ri_10");
	if(distancesquared(v_left, self.origin) < distancesquared(v_right, self.origin))
	{
		str_tag = "j_feather_le_10";
	}
	else
	{
		str_tag = "j_feather_ri_10";
	}
	level beam::launch(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike", 1);
	self playsound(localclientnum, #"hash_61c057ffadb7a5af");
	wait(0.3);
	level beam::kill(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike");
}

/*
	Name: function_5b4619
	Namespace: zm_weap_thunderstorm
	Checksum: 0xA1EFA434
	Offset: 0xCC8
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_5b4619(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_788ff1a315628747"], self, "tag_fx_ball");
	util::playfxontag(localclientnum, level._effect[#"hash_6bfee027c13054b6"], self, "tag_fx_ball");
}

