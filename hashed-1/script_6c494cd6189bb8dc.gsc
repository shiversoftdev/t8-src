// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1611421ee9b880d3;
#using script_624a704d0f6bf28d;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_59d4913f;

/*
	Name: init
	Namespace: namespace_59d4913f
	Checksum: 0xF416557E
	Offset: 0x178
	Size: 0x542
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("world", "" + #"hash_3b4f11e825b1f62b", 8000, 1, "int", &function_5980b4fd, 0, 0);
	clientfield::register("world", "" + #"hash_300ef0a8a2afdab9", 8000, 3, "int", &function_8b09185, 0, 0);
	clientfield::register("world", "" + #"hash_300eefa8a2afd906", 8000, 3, "int", &function_1a723508, 0, 0);
	clientfield::register("world", "" + #"hash_300eeea8a2afd753", 8000, 3, "int", &function_e34446ad, 0, 0);
	clientfield::register("world", "" + #"hash_300eeda8a2afd5a0", 8000, 3, "int", &function_f4fe6a21, 0, 0);
	clientfield::register("world", "" + #"hash_155407a9010f2b23", 8000, 1, "int", &function_1edcfaa9, 0, 0);
	clientfield::register("world", "" + #"hash_70b438bea0135fc8", 8000, 3, "int", &function_860933ea, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_693891d7b7f47419", 8000, 2, "int", &function_813aa911, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_c2169a9806df05e", 8000, 1, "int", &function_4a77ba1b, 0, 0);
	clientfield::register("vehicle", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int", &function_6736abbe, 0, 0);
	clientfield::register("actor", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int", &function_6736abbe, 0, 0);
	clientfield::register("world", "" + #"hash_5f0c4b68b2a6a75d", 16000, 1, "int", &function_36123d34, 0, 0);
	namespace_617a54f4::function_d8383812("ee_asf_altar", 1, #"a_skeet_fink_charge", 400, level._effect[#"hash_51c7bc3539ed5540"], level._effect[#"hash_68213763a7707b92"], undefined, undefined, 1);
	level._effect[#"hash_1a9940efe1d3ed25"] = #"hash_4fc9f92d9016ecad";
	level._effect[#"hash_7cd0c2ae0222691"] = #"hash_4a2a2a8ca5ef4c74";
	level._effect[#"hash_c2169a9806df05e"] = #"hash_34d06e6d2aa00b39";
	level._effect[#"hash_7a260c02e8c345c2"] = #"hash_65d0a2cee07e8664";
}

/*
	Name: function_5980b4fd
	Namespace: namespace_59d4913f
	Checksum: 0xFD6DC107
	Offset: 0x6C8
	Size: 0x4D6
	Parameters: 7
	Flags: Linked
*/
function function_5980b4fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	level.var_5e01899a = [];
	level.var_a791c3be = [];
	level.var_97a6ac9f = [];
	for(i = 0; i < 4; i++)
	{
		level.var_a791c3be[i] = [];
		level.var_a791c3be[i][0] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_air");
		level.var_a791c3be[i][1] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_earth");
		level.var_a791c3be[i][2] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_fire");
		level.var_a791c3be[i][3] = findvolumedecalindexarray("a_skeet_fink_carvel_0" + i + "_water");
		foreach(var_9d4544e1 in level.var_a791c3be[i])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	for(i = 0; i < 4; i++)
	{
		level.var_97a6ac9f[i] = [];
		level.var_97a6ac9f[i][0] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_air");
		level.var_97a6ac9f[i][1] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_earth");
		level.var_97a6ac9f[i][2] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_fire");
		level.var_97a6ac9f[i][3] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_water");
		level.var_97a6ac9f[i][4] = findvolumedecalindexarray("a_skeet_fink_step_2_carvel_0" + i + "_slash");
		foreach(var_9d4544e1 in level.var_97a6ac9f[i])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
}

/*
	Name: function_8b09185
	Namespace: namespace_59d4913f
	Checksum: 0xD3F9FA2F
	Offset: 0xBA8
	Size: 0x21C
	Parameters: 7
	Flags: Linked
*/
function function_8b09185(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		level.var_5e01899a[0] = newval - 1;
		if(isdefined(level.var_a791c3be) && isdefined(level.var_a791c3be[0]))
		{
			var_1a257ffa = level.var_a791c3be[0][newval - 1];
		}
		if(isdefined(var_1a257ffa) && isarray(var_1a257ffa))
		{
			foreach(var_97af50b7 in var_1a257ffa)
			{
				if(isdefined(var_97af50b7))
				{
					unhidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	else
	{
		foreach(var_9d4544e1 in level.var_a791c3be[0])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
}

/*
	Name: function_1a723508
	Namespace: namespace_59d4913f
	Checksum: 0xA979A4F1
	Offset: 0xDD0
	Size: 0x22C
	Parameters: 7
	Flags: Linked
*/
function function_1a723508(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		level.var_5e01899a[1] = newval - 1;
		if(isdefined(level.var_a791c3be) && isdefined(level.var_a791c3be[1]))
		{
			var_1a257ffa = level.var_a791c3be[1][newval - 1];
		}
		if(isdefined(var_1a257ffa) && isarray(var_1a257ffa))
		{
			foreach(var_97af50b7 in var_1a257ffa)
			{
				if(isdefined(var_97af50b7))
				{
					unhidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	else
	{
		foreach(var_9d4544e1 in level.var_a791c3be[1])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
}

/*
	Name: function_e34446ad
	Namespace: namespace_59d4913f
	Checksum: 0xE869529D
	Offset: 0x1008
	Size: 0x22C
	Parameters: 7
	Flags: Linked
*/
function function_e34446ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		level.var_5e01899a[2] = newval - 1;
		if(isdefined(level.var_a791c3be) && isdefined(level.var_a791c3be[2]))
		{
			var_1a257ffa = level.var_a791c3be[2][newval - 1];
		}
		if(isdefined(var_1a257ffa) && isarray(var_1a257ffa))
		{
			foreach(var_97af50b7 in var_1a257ffa)
			{
				if(isdefined(var_97af50b7))
				{
					unhidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	else
	{
		foreach(var_9d4544e1 in level.var_a791c3be[2])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
}

/*
	Name: function_f4fe6a21
	Namespace: namespace_59d4913f
	Checksum: 0x635E2D3F
	Offset: 0x1240
	Size: 0x22C
	Parameters: 7
	Flags: Linked
*/
function function_f4fe6a21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		level.var_5e01899a[3] = newval - 1;
		if(isdefined(level.var_a791c3be) && isdefined(level.var_a791c3be[3]))
		{
			var_1a257ffa = level.var_a791c3be[3][newval - 1];
		}
		if(isdefined(var_1a257ffa) && isarray(var_1a257ffa))
		{
			foreach(var_97af50b7 in var_1a257ffa)
			{
				if(isdefined(var_97af50b7))
				{
					unhidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	else
	{
		foreach(var_9d4544e1 in level.var_a791c3be[3])
		{
			foreach(var_97af50b7 in var_9d4544e1)
			{
				if(isdefined(var_97af50b7))
				{
					hidevolumedecal(var_97af50b7);
				}
			}
		}
	}
}

/*
	Name: function_1edcfaa9
	Namespace: namespace_59d4913f
	Checksum: 0xCE6EC2D0
	Offset: 0x1478
	Size: 0x21E
	Parameters: 7
	Flags: Linked
*/
function function_1edcfaa9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(!isdefined(level.var_97a6ac9f))
	{
		return;
	}
	if(newval)
	{
		for(i = 0; i < level.var_97a6ac9f.size; i++)
		{
			foreach(var_97af50b7 in level.var_97a6ac9f[i][level.var_5e01899a[i]])
			{
				if(isdefined(var_97af50b7))
				{
					unhidevolumedecal(var_97af50b7);
				}
			}
		}
	}
	else
	{
		for(i = 0; i < level.var_97a6ac9f.size; i++)
		{
			foreach(var_9d4544e1 in level.var_97a6ac9f[i])
			{
				foreach(var_97af50b7 in var_9d4544e1)
				{
					if(isdefined(var_97af50b7))
					{
						hidevolumedecal(var_97af50b7);
					}
				}
			}
		}
	}
}

/*
	Name: function_860933ea
	Namespace: namespace_59d4913f
	Checksum: 0xE1F7471C
	Offset: 0x16A0
	Size: 0xD8
	Parameters: 7
	Flags: Linked
*/
function function_860933ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		foreach(var_89319027 in level.var_97a6ac9f[newval - 1][4])
		{
			if(isdefined(var_89319027))
			{
				unhidevolumedecal(var_89319027);
			}
		}
	}
}

/*
	Name: function_813aa911
	Namespace: namespace_59d4913f
	Checksum: 0x89997CC7
	Offset: 0x1780
	Size: 0xFA
	Parameters: 7
	Flags: Linked
*/
function function_813aa911(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	switch(newval)
	{
		case 1:
		{
			util::playfxontag(localclientnum, level._effect[#"hash_1a9940efe1d3ed25"], self, "tag_origin");
			break;
		}
		case 2:
		{
			util::playfxontag(localclientnum, level._effect[#"hash_7cd0c2ae0222691"], self, "tag_origin");
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_4a77ba1b
	Namespace: namespace_59d4913f
	Checksum: 0xD7941134
	Offset: 0x1888
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_4a77ba1b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(isdefined(self.var_2dd2a2dd))
	{
		stopfx(localclientnum, self.var_2dd2a2dd);
		self.var_2dd2a2dd = undefined;
	}
	if(newval)
	{
		self.var_2dd2a2dd = util::playfxontag(localclientnum, level._effect[#"hash_c2169a9806df05e"], self, "tag_origin");
	}
}

/*
	Name: function_6736abbe
	Namespace: namespace_59d4913f
	Checksum: 0xDC6A1626
	Offset: 0x1948
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_6736abbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_7a260c02e8c345c2"], self, "j_neck");
	}
}

/*
	Name: function_36123d34
	Namespace: namespace_59d4913f
	Checksum: 0x9D3C689F
	Offset: 0x19D0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_36123d34(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_1a8e66a7966f8086");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_1a8e66a7966f8086");
	}
}

