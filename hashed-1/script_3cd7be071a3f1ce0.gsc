// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_b6ca3ccc;

/*
	Name: init_clientfields
	Namespace: namespace_b6ca3ccc
	Checksum: 0xA8F0A5FE
	Offset: 0x128
	Size: 0x3B2
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_2314cac4e546c79", 8000, 1, "int", &function_664898b6, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_34321e7ca580e772", 8000, 1, "int", &function_f6c7ad1b, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_7e5a6f88110635fc", 8000, 2, "int", &function_959fcbff, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_33fddc34b8b16bca", 8000, 1, "counter", &function_a7012457, 0, 0);
	clientfield::register("toplayer", "" + #"hash_3d81eda4ac6c4d15", 8000, 1, "int", &function_a5f32c8f, 0, 0);
	clientfield::register("toplayer", "" + #"hash_4be98315796ad666", 8000, 1, "int", &function_f568352e, 0, 0);
	clientfield::register("allplayers", "" + #"hash_4f277352731d8da", 8000, 1, "int", &function_d61c8c59, 0, 0);
	clientfield::register("allplayers", "" + #"hash_30aa04edc476253f", 8000, 1, "int", &function_3c4642b1, 0, 0);
	level._effect[#"hash_7e5a6f88110635fc"] = #"hash_31d36dbca458b0dd";
	level._effect[#"hash_2314cac4e546c79"] = #"hash_6d3c039680511839";
	level._effect[#"hash_dea2f3dceff7569"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
	level._effect[#"hash_69a7c889c962b6e3"] = #"hash_6484874c383f70f9";
	level._effect[#"hash_418533e3f4de4e1a"] = #"hash_5586bb7a838e870a";
}

/*
	Name: function_a7012457
	Namespace: namespace_b6ca3ccc
	Checksum: 0x834303D7
	Offset: 0x4E8
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_a7012457(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playfx(localclientnum, level._effect[#"hash_dea2f3dceff7569"], self.origin);
	}
}

/*
	Name: function_f6c7ad1b
	Namespace: namespace_b6ca3ccc
	Checksum: 0xD453FF67
	Offset: 0x570
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_f6c7ad1b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_bf9d3071(#"hash_2db85fc8b73a1571");
	}
	else
	{
		self function_5d482e78(#"hash_2db85fc8b73a1571");
	}
}

/*
	Name: function_664898b6
	Namespace: namespace_b6ca3ccc
	Checksum: 0x599BD8A
	Offset: 0x608
	Size: 0xAA
	Parameters: 7
	Flags: Linked
*/
function function_664898b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.var_f65805a8))
		{
			stopfx(localclientnum, self.var_f65805a8);
		}
		self.var_f65805a8 = util::playfxontag(localclientnum, level._effect[#"hash_2314cac4e546c79"], self, "tag_origin");
	}
}

/*
	Name: function_959fcbff
	Namespace: namespace_b6ca3ccc
	Checksum: 0x2CFBED70
	Offset: 0x6C0
	Size: 0x312
	Parameters: 7
	Flags: Linked
*/
function function_959fcbff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(isdefined(self.var_d8243293))
	{
		stopfx(localclientnum, self.var_d8243293);
		self.var_d8243293 = undefined;
	}
	if(isdefined(self.var_f756621f))
	{
		stopfx(localclientnum, self.var_f756621f);
		self.var_f756621f = undefined;
	}
	if(isdefined(self.var_a0bfa25b))
	{
		self playsound(localclientnum, #"hash_7afee3f791f6bfa2");
		self stoploopsound(self.var_a0bfa25b);
	}
	if(newval == 1)
	{
		self.var_d8243293 = util::playfxontag(localclientnum, level._effect[#"hash_7e5a6f88110635fc"], self, "tag_origin");
		if(!isdefined(self.var_a0bfa25b))
		{
			self playsound(localclientnum, #"hash_4c82cdad375db1a2");
			self.var_a0bfa25b = self playloopsound(#"hash_7449f6af6a74ea36");
		}
	}
	else if(newval == 2)
	{
		forcestreamxmodel(#"hash_10ad36f3d6ec9cba");
		util::delay(2, undefined, &stopforcestreamingxmodel, #"hash_10ad36f3d6ec9cba");
		self.var_d8243293 = util::playfxontag(localclientnum, level._effect[#"hash_7e5a6f88110635fc"], self, "tag_origin");
		if(!isdefined(self.var_a0bfa25b))
		{
			self playsound(localclientnum, #"hash_4c82cdad375db1a2");
			self.var_a0bfa25b = self playloopsound(#"hash_7449f6af6a74ea36");
		}
		wait(2);
		self.var_f756621f = util::playfxontag(localclientnum, level._effect[#"hash_418533e3f4de4e1a"], self, "tag_origin");
	}
}

/*
	Name: function_a5f32c8f
	Namespace: namespace_b6ca3ccc
	Checksum: 0xFFBE2F6D
	Offset: 0x9E0
	Size: 0x1D6
	Parameters: 7
	Flags: Linked
*/
function function_a5f32c8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(isdefined(self.var_fe11bb61))
	{
		deletefx(localclientnum, self.var_fe11bb61, 1);
		self.var_fe11bb61 = undefined;
	}
	if(newval == 1)
	{
		self.var_fe11bb61 = playfxoncamera(localclientnum, level._effect[#"hash_69a7c889c962b6e3"]);
		self postfx::playpostfxbundle(#"hash_66a9fee7028a1e13");
		if(!isdefined(self.var_9096803d))
		{
			self playsound(localclientnum, #"hash_6395d64b5a8efc03");
			self.var_9096803d = self playloopsound(#"hash_6e133362b9af5877");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_66a9fee7028a1e13");
		if(isdefined(self.var_9096803d))
		{
			self playsound(localclientnum, #"hash_3ca6c0d3ecd48de2");
			self stoploopsound(self.var_9096803d);
			self.var_9096803d = undefined;
		}
	}
}

/*
	Name: function_f568352e
	Namespace: namespace_b6ca3ccc
	Checksum: 0xDFFDF0BA
	Offset: 0xBC0
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_f568352e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"hash_2b222dbd1ad76165");
		if(!isdefined(self.var_eb29cb6e))
		{
			self playsound(localclientnum, #"hash_414c95206d51679c");
			self.var_eb29cb6e = self playloopsound(#"hash_1d748b5f5528a66a");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_2b222dbd1ad76165");
		if(isdefined(self.var_eb29cb6e))
		{
			self playsound(localclientnum, #"hash_6560ce0b7a4a80c9");
			self stoploopsound(self.var_eb29cb6e);
			self.var_eb29cb6e = undefined;
		}
	}
}

/*
	Name: function_d61c8c59
	Namespace: namespace_b6ca3ccc
	Checksum: 0x14B0B781
	Offset: 0xD10
	Size: 0x4DE
	Parameters: 7
	Flags: Linked
*/
function function_d61c8c59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_b196c692))
	{
		self.var_b196c692 = [];
	}
	if(!isdefined(self.var_b196c692[localclientnum]))
	{
		self.var_b196c692[localclientnum] = [];
	}
	if(newval == 1)
	{
		if(self getlocalclientnumber() === localclientnum)
		{
			self thread postfx::playpostfxbundle(#"hash_33e699252aac7a7e");
			if(!isdefined(self.var_637d4665))
			{
				self playsound(localclientnum, #"hash_4ce4fa4f56e4698d");
				self.var_637d4665 = self playloopsound(#"hash_43bc941f5e61242d");
			}
			a_e_players = getlocalplayers();
			foreach(e_player in a_e_players)
			{
				if(!e_player util::function_50ed1561(localclientnum))
				{
					e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_33e699252aac7a7e", #"hash_3ac1c56d5f920a24");
				}
			}
		}
		else if(self hasdobj(localclientnum))
		{
			self.var_b196c692[localclientnum] = playtagfxset(localclientnum, "weapon_katana_smoke_3p", self);
		}
		if(!isdefined(self.var_5d816fd0))
		{
			self playsound(localclientnum, #"hash_50cea74fea1f3dcc");
			self.var_637d4665 = self playloopsound(#"hash_47a7411ff19dab6c");
		}
	}
	else if(self getlocalclientnumber() === localclientnum)
	{
		self postfx::stoppostfxbundle(#"hash_33e699252aac7a7e");
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player notify(#"hash_3ac1c56d5f920a24");
			}
		}
		if(isdefined(self.var_637d4665))
		{
			self playsound(localclientnum, #"hash_db54c67c5697558");
			self stoploopsound(self.var_637d4665);
			self.var_637d4665 = undefined;
		}
	}
	else if(isdefined(self.var_b196c692[localclientnum]))
	{
		foreach(fx in self.var_b196c692[localclientnum])
		{
			stopfx(localclientnum, fx);
		}
		self.var_b196c692[localclientnum] = undefined;
	}
	if(isdefined(self.var_5d816fd0))
	{
		self playsound(localclientnum, #"hash_28d41f681d0c4371");
		self stoploopsound(self.var_5d816fd0);
		self.var_5d816fd0 = undefined;
	}
}

/*
	Name: function_3c4642b1
	Namespace: namespace_b6ca3ccc
	Checksum: 0x65638026
	Offset: 0x11F8
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function function_3c4642b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_928ceb18))
	{
		stopfx(localclientnum, self.var_928ceb18);
		self.var_928ceb18 = undefined;
		self notify(#"hash_ac788aea26a8b23");
	}
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(newval == 1)
	{
		self.var_928ceb18 = util::playfxontag(localclientnum, "zm_weapons/fx8_www_drag_enemy_torso", self, "j_spinelower");
		self thread function_443d6ae(localclientnum);
		self playsound(localclientnum, #"hash_71ccbe40ffaafe22");
	}
}

/*
	Name: function_443d6ae
	Namespace: namespace_b6ca3ccc
	Checksum: 0xD0B2AA4D
	Offset: 0x1318
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_443d6ae(localclientnum)
{
	self endon(#"death", #"hash_ac788aea26a8b23");
	wait(0.15);
	self function_bf9d3071(#"hash_429426f01ad84c8b");
}

