// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_b912c30b;

/*
	Name: function_89f2df9
	Namespace: namespace_b912c30b
	Checksum: 0x3D3340FE
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6977117f54c58849", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b912c30b
	Checksum: 0xBF7CF87
	Offset: 0x140
	Size: 0x31E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "aizoneflag", -1, 2, "int", &function_5c69ac3b, 0, 0);
	clientfield::register("scriptmover", "aizoneflag_tu14", 14000, 3, "int", &function_5c69ac3b, 0, 0);
	clientfield::register("scriptmover", "magicboxflag", 1, 3, "int", &function_7e5339f3, 0, 0);
	clientfield::register("scriptmover", "soultransfer", 14000, 2, "int", &function_88a28ed1, 0, 0);
	clientfield::register("actor", "zombie_died", 17000, 1, "int", &function_46c950, 1, 0);
	level._effect[#"hash_2ff87d61167ea531"] = #"hash_1127495f599a3db4";
	level._effect[#"hash_1e5c0bbc60604949"] = #"wz/fx8_zm_box_marker_red";
	level._effect[#"hash_7fe086085cbbacac"] = #"hash_4bd4c9b0fb97f425";
	level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
	level._effect[#"hash_1e35a559be3b8286"] = #"wz/fx8_magicbox_marker_fl_red";
	level._effect[#"hash_19f4dd97cbb87594"] = #"hash_5f376e9395e16666";
	level._effect[#"hash_4fbab83578c5a7e7"] = #"hash_5c4ef04b0752716a";
	level._effect[#"hash_538c528b09706dc8"] = #"hash_286e0d228779181";
	level.var_96add4a1 = #"hash_210be93b3bfae433";
	level.var_86e1b0cc = #"hash_1807f48a5193ce49";
}

/*
	Name: function_46c950
	Namespace: namespace_b912c30b
	Checksum: 0x27761FBD
	Offset: 0x468
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_46c950(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval === 1 && isdefined(self))
	{
		spawn_pos = (self.origin[0], self.origin[1], self.origin[2] + 64);
		var_e2c1d066 = (randomint(1), randomint(1), 1);
		dynent = createdynentandlaunch(localclientnum, #"p8_zm_red_floatie_duck", spawn_pos, self.angles, self.origin, var_e2c1d066);
		if(isdefined(dynent))
		{
			dynent thread function_645efd58();
		}
	}
}

/*
	Name: function_645efd58
	Namespace: namespace_b912c30b
	Checksum: 0xC1E63882
	Offset: 0x5A0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_645efd58()
{
	wait(randomintrange(15, 25));
	if(isdefined(self))
	{
		setdynentenabled(self, 0);
	}
}

/*
	Name: function_5c69ac3b
	Namespace: namespace_b912c30b
	Checksum: 0xC49E8812
	Offset: 0x5E8
	Size: 0x246
	Parameters: 7
	Flags: Linked
*/
function function_5c69ac3b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		if(isdefined(self.var_26a0bda1))
		{
			stopfx(localclientnum, self.var_26a0bda1);
			self.var_26a0bda1 = undefined;
		}
		if(newval == 1)
		{
			playfx(localclientnum, level._effect[#"hash_4048cb4967032c4a"], self.origin);
			self.var_26a0bda1 = playfx(localclientnum, level._effect[#"hash_2ff87d61167ea531"], self.origin);
		}
		else
		{
			if(newval == 2)
			{
				playfx(localclientnum, level._effect[#"hash_1e35a559be3b8286"], self.origin);
				self.var_26a0bda1 = playfx(localclientnum, level._effect[#"hash_1e5c0bbc60604949"], self.origin);
			}
			else if(newval == 3)
			{
				self.var_26a0bda1 = playfx(localclientnum, level._effect[#"hash_7fe086085cbbacac"], self.origin);
			}
		}
		self playsound(localclientnum, #"hash_7d0432d3e280bce1", self.origin);
	}
	else if(isdefined(self.var_26a0bda1))
	{
		stopfx(localclientnum, self.var_26a0bda1);
		self.var_26a0bda1 = undefined;
	}
}

/*
	Name: function_7e5339f3
	Namespace: namespace_b912c30b
	Checksum: 0xDB2EDD47
	Offset: 0x838
	Size: 0x1CA
	Parameters: 7
	Flags: Linked
*/
function function_7e5339f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		if(newval == 1)
		{
			util::playfxontag(localclientnum, level._effect[#"hash_4fbab83578c5a7e7"], self, "tag_origin");
			self playsound(localclientnum, level.var_86e1b0cc, self.origin);
		}
		else
		{
			if(newval == 2)
			{
				self.var_8ddb3e81 = util::playfxontag(localclientnum, level._effect[#"hash_19f4dd97cbb87594"], self, "tag_origin");
				self playsound(localclientnum, level.var_96add4a1, self.origin);
			}
			else
			{
				if(newval == 3)
				{
					if(isdefined(self.var_8ddb3e81))
					{
						stopfx(localclientnum, self.var_8ddb3e81);
						self.var_8ddb3e81 = undefined;
					}
				}
				else if(newval == 4)
				{
					self.var_8ddb3e81 = util::playfxontag(localclientnum, level._effect[#"hash_19f4dd97cbb87594"], self, "tag_origin");
				}
			}
		}
	}
}

/*
	Name: function_88a28ed1
	Namespace: namespace_b912c30b
	Checksum: 0x53871B8B
	Offset: 0xA10
	Size: 0x17E
	Parameters: 7
	Flags: Linked
*/
function function_88a28ed1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		self.var_39557fca = util::playfxontag(localclientnum, level._effect[#"hash_538c528b09706dc8"], self, "tag_origin");
		if(!isdefined(self.var_2a145797))
		{
			self playsound(localclientnum, #"zmb_sq_souls_release");
			self.var_2a145797 = self playloopsound(#"zmb_sq_souls_lp");
		}
	}
	else
	{
		if(isdefined(self.var_39557fca))
		{
			stopfx(localclientnum, self.var_39557fca);
			self.var_39557fca = undefined;
		}
		if(isdefined(self.var_2a145797))
		{
			self playsound(localclientnum, #"zmb_sq_souls_impact");
			self stoploopsound(self.var_2a145797);
			self.var_2a145797 = undefined;
		}
	}
}

