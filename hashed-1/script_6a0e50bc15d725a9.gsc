// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_b4a066ff;

/*
	Name: function_89f2df9
	Namespace: namespace_b4a066ff
	Checksum: 0x9BACD1B1
	Offset: 0x300
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_725ce960f13b96e7", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b4a066ff
	Checksum: 0xBB1EBC1B
	Offset: 0x350
	Size: 0x93A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_4e845c84 = getweapon(#"hash_185abc5c82e9d849");
	level.var_22a393d4 = [];
	clientfield::register("allplayers", "" + #"hash_184a34e85c29399f", 1, 1, "int", &function_b7608e70, 0, 0);
	clientfield::register("toplayer", "" + #"hash_3538d219b7eb5ba0", 1, 1, "int", &function_98ff6333, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3c8cd47650fbb324", 1, 2, "int", &function_a694da18, 0, 0);
	clientfield::register("allplayers", "" + #"hash_e9b9b677ff2b8e2", 1, 1, "int", &function_e943883, 0, 1);
	clientfield::register("allplayers", "" + #"hash_1efc6bf68f09d02c", 1, 2, "int", &function_f9a03171, 0, 0);
	n_bits = getminbitcountfornum(4);
	clientfield::register("actor", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int", &function_b570d455, 0, 0);
	clientfield::register("vehicle", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int", &function_b570d455, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int", &function_b570d455, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_7a8b6df890ccc630", 1, 1, "int", &function_5655dc55, 0, 0);
	clientfield::register("allplayers", "" + #"hash_7663ae2eb866d2eb", 1, 1, "counter", &function_50119cc1, 0, 0);
	clientfield::register("allplayers", "" + #"hash_e0f652f4a9ad8d5", 1, 2, "int", &function_36c349d0, 0, 0);
	clientfield::register("allplayers", "" + #"hash_5fc4ff8f1017bd0a", 1, 1, "counter", &function_6b58c030, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6a04c04eae77e006", 1, 1, "counter", &function_107af28d, 0, 0);
	clientfield::register("actor", "" + #"hash_3abdd4f4d64241e5", 1, 1, "int", &function_1b1ec967, 0, 0);
	clientfield::register("allplayers", "" + #"hash_65fcbf0b7e534d0b", 1, 1, "counter", &function_3f83a22f, 0, 0);
	level._effect[#"spectral_key_muzzle_flash1p"] = #"hash_1897770e10623dab";
	level._effect[#"spectral_key_muzzle_flash3p"] = #"hash_18906b0e105c0a99";
	level._effect[#"spectral_key_muzzle_flash1p_idle"] = #"hash_74f3e07770b3c780";
	level._effect[#"spectral_key_muzzle_flash3p_idle"] = #"hash_74faec7770b9fa92";
	level._effect[#"hash_5a834a39ce281cef"] = #"hash_42b1e9abdde1d678";
	level._effect[#"hash_6ca5cf8a3ac2254a"] = #"hash_6894b23015ff2626";
	level._effect[#"hash_5e08e3b80445f6d7"] = #"hash_db890f21c0af009";
	level._effect[#"hash_5e01d7b8043fc3c5"] = #"hash_dbf9cf21c11231b";
	level._effect[#"hash_3ae08d08271270d6"] = #"hash_35b66c4bdba4f1a8";
	level._effect[#"hash_3ad9a108270c7424"] = #"hash_35bd784bdbab24ba";
	level._effect[#"hash_4a41e8484e30822e"] = #"hash_55a201e66dbc23d3";
	level._effect[#"hash_4a3bdc484e2c021c"] = #"hash_559b15e66db62721";
	level._effect[#"hash_29b0420a85baa71b"] = #"hash_4a8de7cdf2716f1b";
	level._effect[#"hash_28b1c64bd72686eb"] = #"hash_5e46c3cecd080eeb";
	level._effect[#"hash_a64dd624f3d5eff"] = #"hash_3a4825045da5aa1f";
	level._effect[#"hash_a5ef1624f39154d"] = #"hash_3a4139045d9fad6d";
	level._effect[#"hash_568709b6dd3a62e2"] = #"hash_70630dd76a790b4";
	level._effect[#"hash_3757ad652a2b0e54"] = #"hash_382d55804b58cfcb";
	level._effect[#"hash_4c48b3d3cd5aca57"] = #"hash_1e261e7fd620ac9e";
	level._effect[#"hash_1bd80166d9e218c4"] = #"zombie/fx_bgb_near_death_3p";
}

/*
	Name: __main__
	Namespace: namespace_b4a066ff
	Checksum: 0x80F724D1
	Offset: 0xC98
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_b7608e70
	Namespace: namespace_b4a066ff
	Checksum: 0x62E9F2
	Offset: 0xCA8
	Size: 0x4DC
	Parameters: 7
	Flags: Linked
*/
function function_b7608e70(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(!isdefined(self.var_1d12110c))
	{
		self.var_1d12110c = [];
	}
	if(newval == 1)
	{
		if(!isdefined(self.weapon))
		{
			return;
		}
		if(!function_98890cd8(self.weapon))
		{
			return;
		}
		if(self getlocalclientnumber() === localclientnum)
		{
			if(!isdemoplaying() && !namespace_a6aea2c6::is_active(#"hash_65cfe78dc61dd3af"))
			{
				self thread postfx::playpostfxbundle(#"hash_529f2ffb7f62ca50");
				a_e_players = getlocalplayers();
				foreach(e_player in a_e_players)
				{
					if(!e_player util::function_50ed1561(localclientnum))
					{
						e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_529f2ffb7f62ca50", #"hash_242ff4bae72c27b3");
					}
				}
			}
			level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);
			foreach(var_56fd8656 in level.var_22a393d4)
			{
				if(isdefined(var_56fd8656.var_922c0c5c))
				{
					var_56fd8656.var_a5a0e616 = 1;
					var_56fd8656 thread [[var_56fd8656.var_922c0c5c]](localclientnum);
				}
			}
			self thread function_85e7adcf(localclientnum);
		}
		else
		{
			self.var_1d12110c[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_3757ad652a2b0e54"], self, "tag_window_fx");
		}
	}
	else if(self getlocalclientnumber() === localclientnum)
	{
		self notify(#"hash_eefcf8215207987");
		self postfx::stoppostfxbundle(#"hash_529f2ffb7f62ca50");
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player notify(#"hash_242ff4bae72c27b3");
			}
		}
		level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);
		foreach(var_56fd8656 in level.var_22a393d4)
		{
			if(isdefined(var_56fd8656.var_ffeecdb6))
			{
				var_56fd8656.var_a5a0e616 = undefined;
				var_56fd8656 thread [[var_56fd8656.var_ffeecdb6]](localclientnum);
			}
		}
	}
	else if(isdefined(self.var_1d12110c[localclientnum]))
	{
		stopfx(localclientnum, self.var_1d12110c[localclientnum]);
		self.var_1d12110c[localclientnum] = undefined;
	}
}

/*
	Name: function_85e7adcf
	Namespace: namespace_b4a066ff
	Checksum: 0x6BA6B7D0
	Offset: 0x1190
	Size: 0x168
	Parameters: 1
	Flags: Linked, Private
*/
private function function_85e7adcf(localclientnum)
{
	self endon(#"death", #"hash_eefcf8215207987");
	var_61467197 = level.var_22a393d4.size;
	while(true)
	{
		if(var_61467197 !== level.var_22a393d4.size)
		{
			level.var_22a393d4 = array::remove_undefined(level.var_22a393d4, 0);
			foreach(var_56fd8656 in level.var_22a393d4)
			{
				if(isdefined(var_56fd8656.var_922c0c5c) && (!(isdefined(var_56fd8656.var_a5a0e616) && var_56fd8656.var_a5a0e616)))
				{
					var_56fd8656.var_a5a0e616 = 1;
					var_56fd8656 thread [[var_56fd8656.var_922c0c5c]](localclientnum);
				}
			}
			var_61467197 = level.var_22a393d4.size;
		}
		wait(0.1);
	}
}

/*
	Name: function_98ff6333
	Namespace: namespace_b4a066ff
	Checksum: 0xF4814573
	Offset: 0x1300
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_98ff6333(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self function_bf9d3071("rob_shield_window");
	}
	else
	{
		self function_5d482e78("rob_shield_window");
	}
}

/*
	Name: function_a694da18
	Namespace: namespace_b4a066ff
	Checksum: 0xC6045DEF
	Offset: 0x1390
	Size: 0x194
	Parameters: 7
	Flags: Linked
*/
function function_a694da18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(!isdefined(level.var_22a393d4))
		{
			level.var_22a393d4 = [];
		}
		else if(!isarray(level.var_22a393d4))
		{
			level.var_22a393d4 = array(level.var_22a393d4);
		}
		if(!isinarray(level.var_22a393d4, self))
		{
			level.var_22a393d4[level.var_22a393d4.size] = self;
		}
		self.var_922c0c5c = &function_f66111c5;
		self.var_ffeecdb6 = &function_5681824;
		self hide();
	}
	else if(newval == 2)
	{
		self notify(#"hash_60940765153fcb7d");
		self.b_seen = undefined;
		self.var_ffeecdb6 = undefined;
		self function_bf9d3071("rob_skull_grab");
		self show();
	}
}

/*
	Name: function_f66111c5
	Namespace: namespace_b4a066ff
	Checksum: 0x9BD1CF1
	Offset: 0x1530
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_f66111c5(localclientnum)
{
	self endon(#"death", #"hash_60940765153fcb7d");
	self function_bf9d3071("rob_spectral_vision");
	self show();
}

/*
	Name: function_5681824
	Namespace: namespace_b4a066ff
	Checksum: 0x13F54175
	Offset: 0x15A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_5681824(localclientnum)
{
	self endon(#"death", #"hash_60940765153fcb7d");
	self function_5d482e78("rob_spectral_vision");
}

/*
	Name: function_1b1ec967
	Namespace: namespace_b4a066ff
	Checksum: 0xE43D8C64
	Offset: 0x15F8
	Size: 0xF2
	Parameters: 7
	Flags: Linked
*/
function function_1b1ec967(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_39306eaa))
	{
		deletefx(localclientnum, self.var_39306eaa, 1);
		self.var_39306eaa = undefined;
	}
	if(newval == 1)
	{
		str_tag = "j_spineupper";
		if(self.archetype == #"zombie_dog")
		{
			str_tag = "j_spine1";
		}
		self.var_39306eaa = util::playfxontag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], self, str_tag);
	}
}

/*
	Name: function_e943883
	Namespace: namespace_b4a066ff
	Checksum: 0xE4FE5C7B
	Offset: 0x16F8
	Size: 0x10E
	Parameters: 7
	Flags: Linked
*/
function function_e943883(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death", #"disconnect", #"hash_3ed4154ad2e33ec3");
	if(!isdefined(self.var_2723e767))
	{
		self.var_2723e767 = [];
	}
	if(!isdefined(self.var_3e52c79e))
	{
		self.var_3e52c79e = [];
	}
	self function_4700b6cd(localclientnum);
	if(newval == 1)
	{
		self thread function_848179f5(localclientnum);
		self thread function_a950c92c(localclientnum);
	}
	else
	{
		self notify(#"hash_3ed4154ad2e33ec3");
	}
}

/*
	Name: function_a950c92c
	Namespace: namespace_b4a066ff
	Checksum: 0xB17EE58E
	Offset: 0x1810
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function function_a950c92c(localclientnum)
{
	self endon(#"death", #"hash_3ed4154ad2e33ec3");
	while(true)
	{
		level.var_443d1164 = undefined;
		s_result = undefined;
		s_result = level waittill(#"hash_73ff8d0d706c332d", #"hash_527d9fdde8903b80");
		level.var_443d1164 = 1;
		self function_4700b6cd(localclientnum);
		if(s_result._notify === #"hash_73ff8d0d706c332d" && s_result.e_attacker === self && isdefined(s_result.e_target))
		{
			var_3da509de = s_result.e_target;
			self thread function_5ab769d8(localclientnum);
			self thread function_28291f40(localclientnum, s_result.e_target);
		}
		else if(isdefined(var_3da509de) && var_3da509de !== s_result.e_target)
		{
			continue;
		}
		var_3da509de = undefined;
		self thread function_848179f5(localclientnum);
	}
}

/*
	Name: function_4700b6cd
	Namespace: namespace_b4a066ff
	Checksum: 0x4786D16B
	Offset: 0x1988
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_4700b6cd(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"hash_4ea2d9a0f785e09b");
	if(isdefined(self.var_3e52c79e[localclientnum]))
	{
		beamkill(localclientnum, self.var_3e52c79e[localclientnum]);
		self.var_3e52c79e[localclientnum] = undefined;
	}
	if(isdefined(self.var_2723e767[localclientnum]))
	{
		self.var_2723e767[localclientnum] delete();
		self.var_2723e767[localclientnum] = undefined;
	}
	if(isdefined(self.var_4cd8e6cb))
	{
		self stoploopsound(self.var_4cd8e6cb);
		self.var_4cd8e6cb = undefined;
		self playsound(localclientnum, #"hash_3126b098b980b5a3");
	}
}

/*
	Name: function_848179f5
	Namespace: namespace_b4a066ff
	Checksum: 0xCE61E299
	Offset: 0x1A98
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_848179f5(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_4ea2d9a0f785e09b");
	if(!isdefined(self.var_4cd8e6cb))
	{
		self playsound(localclientnum, #"hash_3765e25049981166");
		self.var_4cd8e6cb = self playloopsound(#"hash_170aa1970243fc4a");
	}
	self thread function_64148d8e(localclientnum);
}

/*
	Name: function_64148d8e
	Namespace: namespace_b4a066ff
	Checksum: 0x67CBFC99
	Offset: 0x1B50
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_64148d8e(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_4ea2d9a0f785e09b");
	wait(0.5);
	if(isdefined(self) && isdefined(self.var_4cd8e6cb))
	{
		self stoploopsound(self.var_4cd8e6cb);
		self.var_4cd8e6cb = undefined;
		self playsound(localclientnum, #"hash_3126b098b980b5a3");
	}
}

/*
	Name: function_28291f40
	Namespace: namespace_b4a066ff
	Checksum: 0xB691E5B5
	Offset: 0x1C00
	Size: 0x232
	Parameters: 2
	Flags: Linked
*/
function function_28291f40(localclientnum, e_target)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_4ea2d9a0f785e09b");
	if(!isdefined(self.var_4cd8e6cb))
	{
		self playsound(localclientnum, #"hash_3765e25049981166");
		self.var_4cd8e6cb = self playloopsound(#"hash_170aa1970243fc4a");
	}
	var_1f694afe = "j_spinelower";
	if(e_target isai())
	{
		if(e_target.archetype == #"zombie_dog")
		{
			var_1f694afe = "j_spine1";
		}
		else if(!isdefined(e_target gettagorigin(var_1f694afe)))
		{
			var_1f694afe = "tag_origin";
		}
		self.var_2723e767[localclientnum] = util::spawn_model(localclientnum, "tag_origin", e_target gettagorigin(var_1f694afe));
	}
	else if(e_target.type == "scriptmover")
	{
		var_1f694afe = "tag_origin";
		self.var_2723e767[localclientnum] = util::spawn_model(localclientnum, "tag_origin", e_target.origin);
	}
	self.var_2723e767[localclientnum] linkto(e_target, var_1f694afe);
	self.var_3e52c79e[localclientnum] = level beam::function_cfb2f62a(localclientnum, self, "tag_shield_key_fx", self.var_2723e767[localclientnum], "tag_origin", "beam8_zm_shield_key_ray_targeted");
}

/*
	Name: function_f9a03171
	Namespace: namespace_b4a066ff
	Checksum: 0xAECFE9E1
	Offset: 0x1E40
	Size: 0x450
	Parameters: 7
	Flags: Linked
*/
function function_f9a03171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.fx_muzzle_flash))
	{
		self.fx_muzzle_flash = [];
	}
	if(isdefined(self.fx_muzzle_flash[localclientnum]))
	{
		deletefx(localclientnum, self.fx_muzzle_flash[localclientnum]);
		self.fx_muzzle_flash[localclientnum] = undefined;
	}
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(!e_player util::function_50ed1561(localclientnum))
		{
			e_player notify(#"hash_52e05d0e2370536d");
		}
	}
	if(newval == 1)
	{
		var_27aa6343 = "spectral_key_muzzle_flash1p_idle";
		var_a1f103c8 = "spectral_key_muzzle_flash3p_idle";
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_27aa6343], "tag_flash");
		}
		else
		{
			self.fx_muzzle_flash[localclientnum] = util::playfxontag(localclientnum, level._effect[var_a1f103c8], self, "tag_flash");
		}
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player thread zm_utility::function_ae3780f1(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
			}
		}
	}
	else if(newval == 2)
	{
		var_27aa6343 = "spectral_key_muzzle_flash1p";
		var_a1f103c8 = "spectral_key_muzzle_flash3p";
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.fx_muzzle_flash[localclientnum] = playviewmodelfx(localclientnum, level._effect[var_27aa6343], "tag_flash");
		}
		else
		{
			self.fx_muzzle_flash[localclientnum] = util::playfxontag(localclientnum, level._effect[var_a1f103c8], self, "tag_flash");
		}
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player thread zm_utility::function_ae3780f1(localclientnum, self.fx_muzzle_flash[localclientnum], #"hash_52e05d0e2370536d");
			}
		}
	}
}

/*
	Name: function_3f83a22f
	Namespace: namespace_b4a066ff
	Checksum: 0xB0D94A49
	Offset: 0x2298
	Size: 0x166
	Parameters: 7
	Flags: Linked
*/
function function_3f83a22f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_local_player = function_5c10bd79(localclientnum);
	if(e_local_player != self)
	{
		if(!isdefined(self.var_aa9e07fe))
		{
			self.var_aa9e07fe = [];
		}
		if(isdefined(self.var_aa9e07fe[localclientnum]))
		{
			return;
		}
		if(!(isdefined(self.var_5427d523) && self.var_5427d523))
		{
			self.var_5427d523 = 1;
			self.var_aa9e07fe[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_1bd80166d9e218c4"], self, "j_spine4");
			fxhandle = self.var_aa9e07fe[localclientnum];
			wait(0.5);
			if(isdefined(fxhandle))
			{
				stopfx(localclientnum, fxhandle);
				if(isdefined(self))
				{
					self.var_aa9e07fe[localclientnum] = undefined;
					self.var_5427d523 = undefined;
				}
			}
		}
	}
}

/*
	Name: function_5ab769d8
	Namespace: namespace_b4a066ff
	Checksum: 0xE0F9C8D7
	Offset: 0x2408
	Size: 0xF0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5ab769d8(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"hash_360be32d770a6eb2");
	self endon(#"death", #"hash_360be32d770a6eb2", #"hash_4ea2d9a0f785e09b");
	self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_hit_rumble");
	wait(0.5);
	while(true)
	{
		if(isplayer(self) && self function_21c0fa55())
		{
			self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_rumble");
		}
		wait(0.5);
	}
}

/*
	Name: function_b570d455
	Namespace: namespace_b4a066ff
	Checksum: 0xD3F9747E
	Offset: 0x2500
	Size: 0x36C
	Parameters: 7
	Flags: Linked
*/
function function_b570d455(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval == 0)
	{
		if(self isai())
		{
			if(isdefined(self.var_961fed16))
			{
				deletefx(localclientnum, self.var_961fed16, 1);
			}
			self.var_961fed16 = undefined;
			if(isdefined(self.var_5024b58) && self.var_5024b58)
			{
				zm_utility::function_704f7c0e(localclientnum);
				self.var_5024b58 = undefined;
			}
		}
		else if(isdefined(self.var_961fed16))
		{
			deletefx(localclientnum, self.var_961fed16, 1);
			self.var_961fed16 = undefined;
		}
		if(isdefined(self.var_3415a5d7))
		{
			self stoploopsound(self.var_3415a5d7);
			self.var_3415a5d7 = undefined;
		}
		level thread function_3dec76cb(localclientnum, self, undefined, 0);
	}
	else
	{
		e_attacker = getentbynum(localclientnum, newval - 1);
		if(self isai() && (!(isdefined(self.isvehicle) && self.isvehicle)))
		{
			if(!isdefined(self.var_961fed16))
			{
				str_tag = self zm_utility::function_467efa7b();
				self.var_961fed16 = util::playfxontag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, str_tag);
			}
			if(!(isdefined(self.var_5024b58) && self.var_5024b58) && self.archetype !== #"ghost")
			{
				zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_blue", level._effect[#"hash_6ca5cf8a3ac2254a"]);
				self.var_5024b58 = 1;
			}
		}
		else if(!isdefined(self.var_961fed16))
		{
			self.var_961fed16 = util::playfxontag(localclientnum, level._effect[#"hash_5a834a39ce281cef"], self, "tag_origin");
		}
		if(!isdefined(self.var_3415a5d7))
		{
			self.var_3415a5d7 = self playloopsound(#"hash_4c803bdbf30dd7fc");
		}
		level thread function_3dec76cb(localclientnum, self, e_attacker, 1);
	}
}

/*
	Name: function_3dec76cb
	Namespace: namespace_b4a066ff
	Checksum: 0x83C433DE
	Offset: 0x2878
	Size: 0x1E4
	Parameters: 4
	Flags: Linked
*/
function function_3dec76cb(localclientnum, e_target, e_attacker, var_19f39a16 = 1)
{
	if(isdefined(var_19f39a16) && var_19f39a16)
	{
		waitframe(1);
	}
	while(isdefined(level.var_443d1164) && level.var_443d1164)
	{
		waitframe(1);
	}
	if(!isdefined(e_target))
	{
		return;
	}
	if(var_19f39a16)
	{
		level notify(#"hash_73ff8d0d706c332d", {#e_attacker:e_attacker, #e_target:e_target});
		if(e_target.archetype === #"zombie_dog")
		{
			level thread function_9c08e4b6(localclientnum, e_target, e_attacker);
		}
	}
	else
	{
		level notify(#"hash_527d9fdde8903b80", {#e_attacker:e_attacker, #e_target:e_target});
		if(isdefined(e_target) && !isalive(e_target) && e_target.archetype === #"zombie")
		{
			util::playfxontag(localclientnum, level._effect[#"hash_28b1c64bd72686eb"], e_target, "j_spinelower");
			playsound(localclientnum, #"hash_5eb0bbabfbde1ce8", e_target.origin);
		}
	}
}

/*
	Name: function_9c08e4b6
	Namespace: namespace_b4a066ff
	Checksum: 0x39714A81
	Offset: 0x2A68
	Size: 0x11C
	Parameters: 3
	Flags: Linked
*/
function function_9c08e4b6(localclientnum, e_target, e_attacker)
{
	if(isdefined(e_target))
	{
		var_545d6c28 = e_target gettagorigin("j_spine1");
	}
	while(isalive(e_target) && isdefined(e_target.var_961fed16))
	{
		var_545d6c28 = e_target gettagorigin("j_spine1");
		waitframe(1);
	}
	level notify(#"hash_527d9fdde8903b80", {#e_attacker:e_attacker, #e_target:e_target});
	if(!isalive(e_target) && isdefined(var_545d6c28))
	{
		playsound(localclientnum, #"hash_5eb0bbabfbde1ce8", var_545d6c28);
	}
}

/*
	Name: function_5655dc55
	Namespace: namespace_b4a066ff
	Checksum: 0x37B16E7E
	Offset: 0x2B90
	Size: 0xF6
	Parameters: 7
	Flags: Linked
*/
function function_5655dc55(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_131284b6))
		{
			deletefx(localclientnum, self.var_131284b6, 1);
		}
		self.var_131284b6 = util::playfxontag(localclientnum, level._effect[#"hash_29b0420a85baa71b"], self, "tag_origin");
	}
	else if(isdefined(self.var_131284b6))
	{
		deletefx(localclientnum, self.var_131284b6, 1);
		self.var_131284b6 = undefined;
	}
}

/*
	Name: function_36c349d0
	Namespace: namespace_b4a066ff
	Checksum: 0xF21AF113
	Offset: 0x2C90
	Size: 0x416
	Parameters: 7
	Flags: Linked
*/
function function_36c349d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_2a2f2afa))
	{
		self.var_2a2f2afa = [];
	}
	if(!isdefined(self.var_b2b4e5eb))
	{
		self.var_b2b4e5eb = [];
	}
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(!e_player util::function_50ed1561(localclientnum))
		{
			return;
		}
	}
	if(isdefined(self.var_2a2f2afa[localclientnum]))
	{
		deletefx(localclientnum, self.var_2a2f2afa[localclientnum], 1);
		self.var_2a2f2afa[localclientnum] = undefined;
		self function_f6e99a8d("rob_key_charging", "tag_weapon_right");
	}
	if(isdefined(self.var_b2b4e5eb[localclientnum]))
	{
		deletefx(localclientnum, self.var_b2b4e5eb[localclientnum], 1);
		self.var_b2b4e5eb[localclientnum] = undefined;
		self function_f6e99a8d("rob_key_charged", "tag_weapon_right");
	}
	if(!isdefined(self.weapon))
	{
		return;
	}
	if(!function_98890cd8(self.weapon))
	{
		return;
	}
	if(newval == 1)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_2a2f2afa[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_5e08e3b80445f6d7"], "tag_flash");
			self function_bf9d3071("rob_key_charging", "tag_weapon_right");
		}
		else
		{
			self.var_2a2f2afa[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_5e01d7b8043fc3c5"], self, "tag_flash");
		}
		self thread function_7203304d(localclientnum);
	}
	else if(newval == 2)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_b2b4e5eb[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_3ae08d08271270d6"], "tag_flash");
			self function_bf9d3071("rob_key_charged", "tag_weapon_right");
		}
		else
		{
			self.var_2a2f2afa[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_3ad9a108270c7424"], self, "tag_flash");
		}
		self thread function_7203304d(localclientnum);
	}
	else
	{
		self notify(#"hash_479f7dbb037c00bc");
	}
}

/*
	Name: function_7203304d
	Namespace: namespace_b4a066ff
	Checksum: 0x3ED35E16
	Offset: 0x30B0
	Size: 0x162
	Parameters: 1
	Flags: Linked
*/
function function_7203304d(localclientnum)
{
	self endon(#"death", #"disconnect");
	while(true)
	{
		self waittill(#"weapon_change", #"hash_479f7dbb037c00bc");
		if(!function_98890cd8(self.weapon))
		{
			if(isdefined(self.var_2a2f2afa[localclientnum]))
			{
				deletefx(localclientnum, self.var_2a2f2afa[localclientnum], 1);
				self.var_2a2f2afa[localclientnum] = undefined;
				self function_f6e99a8d("rob_key_charging", "tag_weapon_right");
			}
			if(isdefined(self.var_b2b4e5eb[localclientnum]))
			{
				deletefx(localclientnum, self.var_b2b4e5eb[localclientnum], 1);
				self.var_b2b4e5eb[localclientnum] = undefined;
				self function_f6e99a8d("rob_key_charged", "tag_weapon_right");
			}
			return;
		}
	}
}

/*
	Name: function_50119cc1
	Namespace: namespace_b4a066ff
	Checksum: 0xEDAEDEA6
	Offset: 0x3220
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_50119cc1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!function_98890cd8(self.weapon))
	{
		return;
	}
	str_tag = "tag_flash";
	if(!isdefined(self gettagorigin("tag_flash")))
	{
		str_tag = "tag_weapon_right";
	}
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_a64dd624f3d5eff"], str_tag);
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_a5ef1624f39154d"], self, str_tag);
	}
}

/*
	Name: function_6b58c030
	Namespace: namespace_b4a066ff
	Checksum: 0xBF394F2A
	Offset: 0x3348
	Size: 0x2EC
	Parameters: 7
	Flags: Linked
*/
function function_6b58c030(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_3e85852d))
	{
		self.var_3e85852d = [];
	}
	w_current = self.weapon;
	if(w_current !== getweapon(#"hash_185abc5c82e9d849") && w_current !== getweapon(#"hash_158041aab1e14f3a"))
	{
		return;
	}
	if(isdefined(self.var_3e85852d[localclientnum]))
	{
		deletefx(localclientnum, self.var_3e85852d[localclientnum], 1);
	}
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		self.var_3e85852d[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_4a41e8484e30822e"], "tag_body_window");
	}
	else
	{
		self.var_3e85852d[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_4a3bdc484e2c021c"], self, "tag_body_window");
	}
	util::playfxontag(localclientnum, level._effect[#"hash_568709b6dd3a62e2"], self, "tag_origin");
	var_d58aab0e = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("tag_flash_window"), self gettagangles("tag_flash_window"));
	var_d58aab0e linkto(self, "tag_flash_window");
	var_d58aab0e scene::play(#"p8_fxanim_zm_esc_blast_afterlife_bundle");
	var_d58aab0e unlink();
	var_d58aab0e delete();
	if(isdefined(self))
	{
		if(isdefined(self.var_3e85852d[localclientnum]))
		{
			deletefx(localclientnum, self.var_3e85852d[localclientnum], 1);
		}
		self.var_3e85852d[localclientnum] = undefined;
	}
}

/*
	Name: function_98890cd8
	Namespace: namespace_b4a066ff
	Checksum: 0xE5842754
	Offset: 0x3640
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function function_98890cd8(w_current, var_94c10bbd = 0)
{
	if(!var_94c10bbd)
	{
		if(w_current == getweapon(#"hash_42a45d43be3dba42") || w_current == getweapon(#"hash_78e66b21aa05c753"))
		{
			return 1;
		}
	}
	if(w_current == getweapon(#"hash_185abc5c82e9d849") || w_current == getweapon(#"hash_158041aab1e14f3a"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_107af28d
	Namespace: namespace_b4a066ff
	Checksum: 0x2C36F19D
	Offset: 0x3728
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_107af28d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_4c48b3d3cd5aca57"], self, "tag_origin");
}

