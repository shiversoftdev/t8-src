// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_aat_frostbite;

/*
	Name: function_89f2df9
	Namespace: zm_aat_frostbite
	Checksum: 0xD1EE0168
	Offset: 0x1C0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("zm_aat_frostbite", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_aat_frostbite
	Checksum: 0x392862E6
	Offset: 0x200
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_frostbite", #"hash_5386c3e338c1b314", "t7_icon_zm_aat_thunder_wall");
	clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
	clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
	clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &function_3fc593cb, 1, 0);
	clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &function_3fc593cb, 1, 0);
	level._effect[#"hash_139ac9f86d1a96cd"] = "zm_weapons/fx8_aat_water_torso";
	level._effect[#"hash_3fe83e6067198346"] = "zm_weapons/fx8_aat_water_exp";
}

/*
	Name: function_bad6b477
	Namespace: zm_aat_frostbite
	Checksum: 0x719853AD
	Offset: 0x3D0
	Size: 0x174
	Parameters: 7
	Flags: Linked
*/
function function_bad6b477(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_fx_tag = self zm_utility::function_467efa7b(1);
		if(!isdefined(str_fx_tag))
		{
			str_fx_tag = "tag_origin";
		}
		self.var_c19403bf = util::playfxontag(localclientnum, level._effect[#"hash_139ac9f86d1a96cd"], self, str_fx_tag);
		if(self.archetype === #"hash_1bab8a0ba811401e" || self.archetype === #"tiger")
		{
			self thread function_b8cda358(localclientnum);
		}
		if(!isdefined(self.var_dacf22f6))
		{
			self.var_dacf22f6 = self playloopsound(#"hash_f5d043ac36e0244");
		}
		self thread function_d84b013b(localclientnum, 1);
	}
	else
	{
		self thread function_d84b013b(localclientnum, 0);
	}
}

/*
	Name: function_d84b013b
	Namespace: zm_aat_frostbite
	Checksum: 0x41AE1FBF
	Offset: 0x550
	Size: 0x1F8
	Parameters: 2
	Flags: Linked
*/
function function_d84b013b(localclientnum, var_ccc9bda1)
{
	self notify(#"hash_224e66d46cc29cd6");
	self endon(#"death", #"hash_224e66d46cc29cd6");
	self function_bf9d3071("rob_test_character_ice");
	if(!isdefined(self.var_82fb67e7))
	{
		self.var_82fb67e7 = 0;
	}
	if(var_ccc9bda1)
	{
		var_875c79c1 = self.var_82fb67e7 + 0.5;
	}
	while(true)
	{
		self function_78233d29("rob_test_character_ice", "", "Threshold", self.var_82fb67e7);
		if(var_ccc9bda1)
		{
			self.var_82fb67e7 = self.var_82fb67e7 + 0.2;
		}
		else
		{
			self.var_82fb67e7 = self.var_82fb67e7 - 0.05;
		}
		if(var_ccc9bda1 && (self.var_82fb67e7 >= var_875c79c1 || self.var_82fb67e7 >= 1))
		{
			break;
		}
		else if(self.var_82fb67e7 <= 0)
		{
			self function_5d482e78("rob_test_character_ice");
			if(isdefined(self.var_c19403bf))
			{
				stopfx(localclientnum, self.var_c19403bf);
				self.var_c19403bf = undefined;
			}
			if(isdefined(self.var_dacf22f6))
			{
				self stoploopsound(self.var_dacf22f6);
				self.var_dacf22f6 = undefined;
			}
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_b8cda358
	Namespace: zm_aat_frostbite
	Checksum: 0x680FDA49
	Offset: 0x750
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_b8cda358(localclientnum)
{
	self notify("38bbbe5a5d69da68");
	self endon("38bbbe5a5d69da68");
	var_c19403bf = self.var_c19403bf;
	self waittill(#"death");
	if(isdefined(var_c19403bf))
	{
		killfx(localclientnum, var_c19403bf);
	}
}

/*
	Name: function_3fc593cb
	Namespace: zm_aat_frostbite
	Checksum: 0x836279DA
	Offset: 0x7D0
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_3fc593cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));
		if(!isdefined(v_fx_origin))
		{
			v_fx_origin = self.origin;
		}
		playfx(localclientnum, level._effect[#"hash_3fe83e6067198346"], v_fx_origin);
		self playsound(localclientnum, #"hash_7de1026336539baa");
	}
}

