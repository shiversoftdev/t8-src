// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_blockers;

/*
	Name: function_89f2df9
	Namespace: zm_blockers
	Checksum: 0x3D9C5B4E
	Offset: 0x2B8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_blockers", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_blockers
	Checksum: 0x7CF5D0A
	Offset: 0x300
	Size: 0x37C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"doorbuy_ambient_fx"] = "zombie/fx8_doorbuy_amb";
	level._effect[#"doorbuy_bought_fx"] = "zombie/fx8_doorbuy_death";
	level._effect[#"debrisbuy_ambient_fx"] = "zombie/fx8_debrisbuy_amb";
	level._effect[#"debrisbuy_bought_fx"] = "zombie/fx8_debrisbuy_death";
	level._effect[#"hash_69c64db3e88de22c"] = "zombie/fx8_power_door_amb";
	level._effect[#"hash_2599f6b58bd6457"] = "zombie/fx8_power_door_death";
	level._effect[#"power_debris_ambient_fx"] = "zombie/fx8_power_debris_amb";
	level._effect[#"power_debris_bought_fx"] = "zombie/fx8_power_debris_death";
	clientfield::register("scriptmover", "doorbuy_ambient_fx", 1, 1, "int", &doorbuy_ambient_fx, 0, 0);
	clientfield::register("scriptmover", "doorbuy_bought_fx", 1, 1, "int", &doorbuy_bought_fx, 0, 0);
	clientfield::register("scriptmover", "debrisbuy_ambient_fx", 1, 1, "int", &debrisbuy_ambient_fx, 0, 0);
	clientfield::register("scriptmover", "debrisbuy_bought_fx", 1, 1, "int", &debrisbuy_bought_fx, 0, 0);
	clientfield::register("scriptmover", "power_door_ambient_fx", 1, 1, "int", &power_door_ambient_fx, 0, 0);
	clientfield::register("scriptmover", "power_door_bought_fx", 1, 1, "int", &power_door_bought_fx, 0, 0);
	clientfield::register("scriptmover", "power_debris_ambient_fx", 1, 1, "int", &power_debris_ambient_fx, 0, 0);
	clientfield::register("scriptmover", "power_debris_bought_fx", 1, 1, "int", &power_debris_bought_fx, 0, 0);
}

/*
	Name: __main__
	Namespace: zm_blockers
	Checksum: 0x80F724D1
	Offset: 0x688
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function __main__()
{
}

/*
	Name: doorbuy_ambient_fx
	Namespace: zm_blockers
	Checksum: 0x2114BB0F
	Offset: 0x698
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function doorbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_aa07bb71(level._effect[#"doorbuy_ambient_fx"], "zmb_blocker_door_lp", localclientnum, newval);
}

/*
	Name: debrisbuy_ambient_fx
	Namespace: zm_blockers
	Checksum: 0x84F2ED75
	Offset: 0x718
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function debrisbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_aa07bb71(level._effect[#"debrisbuy_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

/*
	Name: power_door_ambient_fx
	Namespace: zm_blockers
	Checksum: 0xC49F6197
	Offset: 0x798
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function power_door_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_aa07bb71(level._effect[#"hash_69c64db3e88de22c"], "zmb_blocker_powerdoor_lp", localclientnum, newval);
}

/*
	Name: power_debris_ambient_fx
	Namespace: zm_blockers
	Checksum: 0x44CE7336
	Offset: 0x818
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function power_debris_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_aa07bb71(level._effect[#"power_debris_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

/*
	Name: doorbuy_bought_fx
	Namespace: zm_blockers
	Checksum: 0x249C637D
	Offset: 0x898
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function doorbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_e6eed4fe(level._effect[#"doorbuy_bought_fx"], #"hash_21b4bf152e90fd76", localclientnum, newval);
}

/*
	Name: debrisbuy_bought_fx
	Namespace: zm_blockers
	Checksum: 0x9AF791F5
	Offset: 0x920
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function debrisbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_e6eed4fe(level._effect[#"debrisbuy_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

/*
	Name: power_door_bought_fx
	Namespace: zm_blockers
	Checksum: 0x54263D74
	Offset: 0x9A8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function power_door_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_e6eed4fe(level._effect[#"hash_2599f6b58bd6457"], #"hash_5dcb54d98c9787b1", localclientnum, newval);
}

/*
	Name: power_debris_bought_fx
	Namespace: zm_blockers
	Checksum: 0xA2CF6955
	Offset: 0xA30
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function power_debris_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_e6eed4fe(level._effect[#"power_debris_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

/*
	Name: function_aa07bb71
	Namespace: zm_blockers
	Checksum: 0x9B4D0984
	Offset: 0xAB8
	Size: 0xE4
	Parameters: 4
	Flags: Linked
*/
function function_aa07bb71(str_fx_name, var_bd367366, var_6142f944, var_ee0af263)
{
	if(var_ee0af263)
	{
		if(isdefined(self) && !isdefined(self.var_907b36d0))
		{
			self.var_907b36d0 = util::playfxontag(var_6142f944, str_fx_name, self, "tag_origin");
		}
		audio::playloopat(var_bd367366, self.origin);
	}
	else if(isdefined(self.var_907b36d0))
	{
		killfx(var_6142f944, self.var_907b36d0);
		self.var_907b36d0 = undefined;
	}
	audio::stoploopat(var_bd367366, self.origin);
}

/*
	Name: function_e6eed4fe
	Namespace: zm_blockers
	Checksum: 0xE099EDFA
	Offset: 0xBA8
	Size: 0xEC
	Parameters: 4
	Flags: Linked
*/
function function_e6eed4fe(str_fx_name, var_d34b6d2b, var_6142f944, var_ee0af263)
{
	if(var_ee0af263)
	{
		if(!isdefined(self.var_4da473fc))
		{
			var_4da473fc = util::spawn_model(var_6142f944, #"tag_origin", self.origin, self.angles);
		}
		else
		{
			var_4da473fc = self.var_4da473fc;
		}
		util::playfxontag(var_6142f944, str_fx_name, var_4da473fc, "tag_origin");
		playsound(var_6142f944, var_d34b6d2b, var_4da473fc.origin);
		wait(2);
		if(isdefined(var_4da473fc))
		{
			var_4da473fc delete();
		}
	}
}

