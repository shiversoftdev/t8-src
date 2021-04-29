// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_68e77f81585a09e1;
#using script_6e3c826b1814cab6;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_1d5cedd9;

/*
	Name: function_89f2df9
	Namespace: namespace_1d5cedd9
	Checksum: 0x2705BF5D
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3241acb2149d4f34", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1d5cedd9
	Checksum: 0xDAAFE3D2
	Offset: 0x110
	Size: 0x196
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_314051a1 = getscriptbundle(#"hash_7258efc12235efc9");
	if(isdefined(level.var_314051a1.var_2e61f0ce))
	{
		for(i = 0; i < level.var_314051a1.var_2e61f0ce.size; i++)
		{
			for(j = 0; j < level.var_314051a1.var_2e61f0ce[i].factionlist.size; j++)
			{
				level.var_314051a1.var_2e61f0ce[i].var_ecb4fc1[hash(level.var_314051a1.var_2e61f0ce[i].factionlist[j].var_b3bfb429)] = level.var_314051a1.var_2e61f0ce[i].factionlist[j];
				level.var_314051a1.var_2e61f0ce[i].var_ecb4fc1[hash(level.var_314051a1.var_2e61f0ce[i].factionlist[j].var_b3bfb429)].index = j;
			}
		}
	}
}

/*
	Name: __main__
	Namespace: namespace_1d5cedd9
	Checksum: 0x669621BB
	Offset: 0x2B0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	/#
		level thread namespace_fa8546e1::function_9f47471();
	#/
}

/*
	Name: function_c3be3572
	Namespace: namespace_1d5cedd9
	Checksum: 0x3BB97DA9
	Offset: 0x2D8
	Size: 0x236
	Parameters: 6
	Flags: Linked, Private
*/
private function function_c3be3572(var_9c939fff, var_27426b47, target, xp, var_b68d50cb = 1, var_7b2027fe = 1)
{
	var_1eb89301 = getscriptbundle(var_9c939fff);
	if(isdefined(var_1eb89301.var_38fc223d))
	{
		var_341c004b = undefined;
		for(i = 0; i < level.var_314051a1.var_df270379.size; i++)
		{
			if(level.var_314051a1.var_df270379[i].task == var_9c939fff)
			{
				var_341c004b = i;
				break;
			}
		}
		if(isdefined(var_341c004b))
		{
			if(!isdefined(self.var_96d6f6d1))
			{
				self.var_96d6f6d1 = array();
			}
			var_d1017f27 = {#hash_949f9254:var_7b2027fe, #hash_52ac6e9c:var_b68d50cb, #hash_4a01cb77:self.var_96d6f6d1.size, #hash_30c47a21:var_27426b47, #hash_de86e878:var_341c004b, #n_xp:xp, #hash_ad971622:var_1eb89301.var_38fc223d, #hash_e226ec4f:target};
			if(!isdefined(self.var_96d6f6d1))
			{
				self.var_96d6f6d1 = [];
			}
			else if(!isarray(self.var_96d6f6d1))
			{
				self.var_96d6f6d1 = array(self.var_96d6f6d1);
			}
			self.var_96d6f6d1[self.var_96d6f6d1.size] = var_d1017f27;
		}
	}
}

/*
	Name: function_f3393d6a
	Namespace: namespace_1d5cedd9
	Checksum: 0x97CBE5C4
	Offset: 0x518
	Size: 0x544
	Parameters: 0
	Flags: Linked
*/
function function_f3393d6a()
{
	var_ef74f2da = self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_5bf1ebbfa7b16c64");
	if(!var_ef74f2da)
	{
		return;
	}
	self.var_e06cb519 = self stats::get_stat(#"hash_5ae679fef1e88988", #"currentseason");
	self.var_bf6f8ec3 = self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_3a5ab6fb11258ebf");
	if(zm_utility::is_classic() || zm_utility::is_standard())
	{
		self.var_d0b65bbe = hash(self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_34814ea44bc6fed6"));
		var_3afde5e2 = hash(self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", self.var_e06cb519, #"hash_7e597fbe41270a4d"));
		var_51fe014e = level.var_314051a1.var_2e61f0ce[self.var_e06cb519].var_ecb4fc1[var_3afde5e2].var_642e4919 - 1;
		var_51fe014e = var_51fe014e + self.var_bf6f8ec3;
		var_51fe014e = var_51fe014e % level.var_314051a1.var_742e4106.size;
		if(zm_utility::is_classic())
		{
			var_98a2d658 = level.var_314051a1.var_742e4106[var_51fe014e].var_effda190;
			foreach(task in var_98a2d658)
			{
				self function_c3be3572(task.task, #"hash_20deab97abbf7b12", task.target, task.xp);
			}
		}
		else if(zm_utility::is_standard())
		{
			var_c53e054e = level.var_314051a1.var_742e4106[var_51fe014e].var_ebb6275a;
			foreach(task in var_c53e054e)
			{
				self function_c3be3572(task.task, #"hash_764a5fc3ba8820d2", task.target, task.xp);
			}
		}
	}
	else
	{
		self.var_eb15d3ac = level.var_314051a1.var_2e61f0ce[self.var_e06cb519].var_203c6468[self.var_bf6f8ec3].var_4e49f678;
		str_gametype = util::function_5df4294();
		if(self.var_eb15d3ac == str_gametype)
		{
			var_3125770c = level.var_314051a1.var_2e61f0ce[self.var_e06cb519].var_203c6468[self.var_bf6f8ec3];
			foreach(task in var_3125770c.var_272b4041)
			{
				self function_c3be3572(task.task, #"hash_647ebc7d24425fee", task.target, task.xp);
			}
			self function_c3be3572(var_3125770c.var_75399ff2, #"hash_25bf2f1ea44e6b98", var_3125770c.var_baa2833f, var_3125770c.var_b7150b6, 0, 0);
		}
	}
}

/*
	Name: function_10a1ac3c
	Namespace: namespace_1d5cedd9
	Checksum: 0x47BC3DB6
	Offset: 0xA68
	Size: 0x15A
	Parameters: 3
	Flags: Linked, Private
*/
private function function_10a1ac3c(var_d1017f27, var_e06cb519, var_bf6f8ec3)
{
	if(isdefined(var_d1017f27.var_949f9254) && var_d1017f27.var_949f9254)
	{
		if(isdefined(var_d1017f27.var_52ac6e9c) && var_d1017f27.var_52ac6e9c)
		{
			return self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, var_d1017f27.var_4a01cb77, #"progress");
		}
		return self stats::get_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, #"progress");
	}
	if(!isdefined(var_d1017f27.var_1020847d))
	{
		var_d1017f27.var_1020847d = 0;
	}
	return var_d1017f27.var_1020847d;
}

/*
	Name: function_66714869
	Namespace: namespace_1d5cedd9
	Checksum: 0x9AF2BAFF
	Offset: 0xBD0
	Size: 0x172
	Parameters: 4
	Flags: Linked, Private
*/
private function function_66714869(var_d1017f27, var_e06cb519, var_bf6f8ec3, n_inc)
{
	if(isdefined(var_d1017f27.var_949f9254) && var_d1017f27.var_949f9254)
	{
		if(isdefined(var_d1017f27.var_52ac6e9c) && var_d1017f27.var_52ac6e9c)
		{
			self stats::inc_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, var_d1017f27.var_4a01cb77, #"progress", n_inc);
		}
		else
		{
			self stats::inc_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, #"progress", n_inc);
		}
	}
	else if(!isdefined(var_d1017f27.var_1020847d))
	{
		var_d1017f27.var_1020847d = 0;
	}
	var_d1017f27.var_1020847d = var_d1017f27.var_1020847d + n_inc;
}

/*
	Name: function_a6a40735
	Namespace: namespace_1d5cedd9
	Checksum: 0x58524FCC
	Offset: 0xD50
	Size: 0x18C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_a6a40735(var_d1017f27, var_e06cb519, var_bf6f8ec3, n_value, var_32a60884 = 0)
{
	if(!(isdefined(var_d1017f27.var_949f9254) && var_d1017f27.var_949f9254))
	{
		var_d1017f27.var_1020847d = n_value;
	}
	if(isdefined(var_d1017f27.var_949f9254) && var_d1017f27.var_949f9254 || var_32a60884)
	{
		if(isdefined(var_d1017f27.var_52ac6e9c) && var_d1017f27.var_52ac6e9c)
		{
			self stats::set_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, var_d1017f27.var_4a01cb77, #"progress", n_value);
		}
		else
		{
			self stats::set_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", var_e06cb519, #"hash_7e5c33509a9a20ac", var_bf6f8ec3, var_d1017f27.var_30c47a21, #"progress", n_value);
		}
	}
}

/*
	Name: function_7b01d125
	Namespace: namespace_1d5cedd9
	Checksum: 0xB1419030
	Offset: 0xEE8
	Size: 0x3E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_7b01d125(var_a0639b8c, var_f65a9845)
{
	return level.var_314051a1.var_2e61f0ce[var_a0639b8c].var_ecb4fc1[var_f65a9845].index;
}

/*
	Name: function_104c5d35
	Namespace: namespace_1d5cedd9
	Checksum: 0xA8BD1B77
	Offset: 0xF30
	Size: 0x340
	Parameters: 0
	Flags: Linked, Private
*/
private function function_104c5d35()
{
	var_94237d8 = array(#"hash_20deab97abbf7b12", #"hash_764a5fc3ba8820d2", #"hash_647ebc7d24425fee", #"hash_25bf2f1ea44e6b98");
	foreach(var_acbd7392 in var_94237d8)
	{
		var_1e9f2834 = 1;
		var_ed9fe2be = 0;
		foreach(var_d1017f27 in self.var_96d6f6d1)
		{
			if(var_d1017f27.var_30c47a21 == var_acbd7392)
			{
				var_e4edaaf0 = self function_10a1ac3c(var_d1017f27, self.var_e06cb519, self.var_bf6f8ec3);
				n_target = var_d1017f27.var_e226ec4f;
				if(var_e4edaaf0 < n_target)
				{
					var_1e9f2834 = 0;
					break;
				}
				if(!var_ed9fe2be && (isdefined(var_d1017f27.var_89ed7b39) && var_d1017f27.var_89ed7b39))
				{
					var_d1017f27.var_89ed7b39 = 0;
					var_ed9fe2be = 1;
				}
			}
		}
		if(isdefined(var_1e9f2834) && var_1e9f2834 && (isdefined(var_ed9fe2be) && var_ed9fe2be))
		{
			self luinotifyevent(#"hash_675b38b81564449", 4, 3, function_7b01d125(self.var_e06cb519, self.var_d0b65bbe) + 1, self.var_e06cb519 + 1, self getentitynumber());
			self stats::inc_stat(#"hash_5ae679fef1e88988", #"hash_ffbfacdd776e531", self.var_e06cb519, #"factions", self.var_d0b65bbe, #"hash_7a54171ce10db54f", 1);
			/#
				iprintln("" + function_9e72a96(var_acbd7392) + "" + function_9e72a96(self.var_d0b65bbe));
			#/
		}
	}
}

/*
	Name: function_4368582a
	Namespace: namespace_1d5cedd9
	Checksum: 0xD08F827
	Offset: 0x1278
	Size: 0x2C4
	Parameters: 2
	Flags: Linked
*/
function function_4368582a(var_d1017f27, n_value = 1)
{
	var_e4edaaf0 = self function_10a1ac3c(var_d1017f27, self.var_e06cb519, self.var_bf6f8ec3);
	n_target = var_d1017f27.var_e226ec4f;
	if(var_e4edaaf0 < n_target)
	{
		if(var_e4edaaf0 + n_value >= n_target)
		{
			var_d1017f27.var_89ed7b39 = 1;
			self function_a6a40735(var_d1017f27, self.var_e06cb519, self.var_bf6f8ec3, n_target, 1);
			self addrankxpvalue("faction_calling_task", var_d1017f27.n_xp);
			self luinotifyevent(#"hash_675b38b81564449", 3, 2, var_d1017f27.var_de86e878, self getentitynumber());
			/#
				iprintln(self.name + "" + function_9e72a96(var_d1017f27.var_ad971622) + "" + var_d1017f27.n_xp + "");
			#/
			self function_104c5d35();
			uploadstats(self);
			self function_4835d26a();
		}
		else
		{
			/#
				progress = var_e4edaaf0 + n_value;
				target = n_target;
				iprintln(self.name + "" + function_9e72a96(var_d1017f27.var_ad971622) + "" + progress + "" + target);
			#/
			self function_66714869(var_d1017f27, self.var_e06cb519, self.var_bf6f8ec3, n_value);
		}
	}
	return self function_10a1ac3c(var_d1017f27, self.var_e06cb519, self.var_bf6f8ec3);
}

