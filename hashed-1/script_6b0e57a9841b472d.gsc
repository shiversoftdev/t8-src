// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_235cad39dd72e0ac;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_765d6379;

/*
	Name: init
	Namespace: namespace_765d6379
	Checksum: 0x46CBFF36
	Offset: 0x150
	Size: 0x426
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("missile", "" + #"hash_64910f94ebb8d66a", 16000, 2, "int", &function_6e3ecc82, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_584149c4564f2d95", 16000, 1, "counter", &function_d7fa0a53, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_77ad8ced9471eae9", 16000, 1, "int", &function_272aa016, 0, 0);
	clientfield::register("allplayers", "" + #"hash_73e309ffb25bf63d", 16000, 1, "int", &function_a27b945a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_3bb8b5cda11eecc6", 16000, 1, "counter", &function_b9329291, 0, 0);
	clientfield::register("scriptmover", "" + #"lightning_impact_fx", 16000, 1, "int", &function_ed1d0231, 0, 0);
	clientfield::register("scriptmover", "" + #"lightning_arc_fx", 16000, 1, "int", &function_37d1ee2e, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2bb63677db4333d4", 16000, 1, "int", &function_5091797, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_2b842a4f17120dfb", 16000, 1, "counter", &function_e2680ff3, 0, 0);
	level._effect[#"hash_52f038f656770d3f"] = #"hash_433034414b39f1ef";
	level._effect[#"hash_52f039f656770ef2"] = #"hash_433035414b39f3a2";
	level._effect[#"hash_52f03af6567710a5"] = #"hash_7a9a94bbcf902878";
	level._effect[#"hash_584149c4564f2d95"] = #"hash_9c7935d1106ec1d";
	level._effect[#"hash_6c266b19031d2c09"] = #"hash_4dd46a244305d465";
	level.s_boss_battle = spawnstruct();
}

/*
	Name: function_6e3ecc82
	Namespace: namespace_765d6379
	Checksum: 0x8F91D013
	Offset: 0x580
	Size: 0x132
	Parameters: 7
	Flags: Linked
*/
function function_6e3ecc82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	switch(newval)
	{
		case 0:
		{
			if(isdefined(self.fx))
			{
				stopfx(localclientnum, self.fx);
			}
			break;
		}
		case 1:
		case 2:
		case 3:
		{
			self util::waittill_dobj(localclientnum);
			self.fx = util::playfxontag(localclientnum, level._effect[#"hash_57e8678ca1730874" + newval], self, "tag_origin");
			break;
		}
	}
}

/*
	Name: function_d7fa0a53
	Namespace: namespace_765d6379
	Checksum: 0x39975A05
	Offset: 0x6C0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_d7fa0a53(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_584149c4564f2d95"], self, "tag_origin");
}

/*
	Name: function_272aa016
	Namespace: namespace_765d6379
	Checksum: 0x40C444C1
	Offset: 0x740
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_272aa016(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify("1eb9df21273269b8");
	self endon("1eb9df21273269b8");
	if(newval)
	{
		self.fx_id = util::playfxontag(localclientnum, level._effect[#"hash_6c266b19031d2c09"], self, "tag_origin");
		if(!isdefined(self.sfx_id))
		{
			self.sfx_id = self playloopsound(#"hash_5760b615b9b749d2");
		}
	}
	else
	{
		if(isdefined(self.fx_id))
		{
			stopfx(localclientnum, self.fx_id);
		}
		if(isdefined(self.sfx_id))
		{
			self stoploopsound(self.sfx_id);
			self.sfx_id = undefined;
		}
	}
}

/*
	Name: function_a27b945a
	Namespace: namespace_765d6379
	Checksum: 0x9CC32CB6
	Offset: 0x888
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_a27b945a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.s_boss_battle.var_4475b443))
	{
		return false;
	}
	str_tag = "tag_origin";
	level beam::launch(level.s_boss_battle.var_4475b443, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike", 1);
	self playsound(localclientnum, #"hash_61c057ffadb7a5af");
	wait(1.5);
	level beam::kill(level.s_boss_battle.var_4475b443, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike");
}

/*
	Name: function_b9329291
	Namespace: namespace_765d6379
	Checksum: 0xC0DCA5A3
	Offset: 0x9B0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_b9329291(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_36e4ebd4(localclientnum, "damage_light");
}

/*
	Name: function_ed1d0231
	Namespace: namespace_765d6379
	Checksum: 0x3145D344
	Offset: 0xA18
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_ed1d0231(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx_tag = (isdefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver");
	if(isdefined(self.var_89d8285))
	{
		deletefx(localclientnum, self.var_89d8285, 1);
		self.var_89d8285 = undefined;
	}
	if(newval == 1)
	{
		self.var_89d8285 = util::playfxontag(localclientnum, level._effect[#"lightning_impact"], self, str_fx_tag);
		self playsound(localclientnum, #"hash_63d588d1f28ecdc1");
	}
}

/*
	Name: function_37d1ee2e
	Namespace: namespace_765d6379
	Checksum: 0x5D72CA99
	Offset: 0xB50
	Size: 0x96
	Parameters: 7
	Flags: Linked
*/
function function_37d1ee2e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread function_e9aa9e80(localclientnum);
		self thread function_954b9602(localclientnum);
	}
	else
	{
		self notify(#"hash_5531647ca0352039");
	}
}

/*
	Name: function_e9aa9e80
	Namespace: namespace_765d6379
	Checksum: 0xA336065E
	Offset: 0xBF0
	Size: 0x278
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e9aa9e80(localclientnum)
{
	self endon(#"death", #"hash_5531647ca0352039");
	while(!isdefined(level.var_76234ae5[localclientnum]))
	{
		waitframe(1);
	}
	var_9d68990a = level.var_76234ae5[localclientnum];
	var_9d68990a endon(#"death");
	util::server_wait(localclientnum, randomfloatrange(0.05, 0.1));
	if(!isdefined(var_9d68990a))
	{
		return;
	}
	self.e_fx = util::spawn_model(localclientnum, #"tag_origin", var_9d68990a.origin);
	self.fx_arc = util::playfxontag(localclientnum, level._effect[#"lightning_arc"], self.e_fx, "tag_origin");
	while(true)
	{
		str_fx_tag = (isdefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver");
		var_a05eed18 = self gettagorigin(str_fx_tag);
		if(isdefined(var_a05eed18))
		{
			self.e_fx moveto(var_a05eed18, 0.1);
		}
		else
		{
			self.e_fx moveto(self.origin, 0.1);
		}
		util::server_wait(localclientnum, 0.1);
		if(!isdefined(var_9d68990a))
		{
			return;
		}
		self.e_fx moveto(var_9d68990a.origin, 0.1);
		util::server_wait(localclientnum, 0.1);
	}
}

/*
	Name: function_954b9602
	Namespace: namespace_765d6379
	Checksum: 0xCF72EA6F
	Offset: 0xE70
	Size: 0x96
	Parameters: 1
	Flags: Linked, Private
*/
function private function_954b9602(localclientnum)
{
	self waittill(#"death", #"hash_5531647ca0352039");
	if(isdefined(self.fx_arc))
	{
		stopfx(localclientnum, self.fx_arc);
		self.fx_arc = undefined;
	}
	if(isdefined(self.e_fx))
	{
		self.e_fx delete();
		self.e_fx = undefined;
	}
}

/*
	Name: function_5091797
	Namespace: namespace_765d6379
	Checksum: 0x4CA58769
	Offset: 0xF10
	Size: 0x1F4
	Parameters: 7
	Flags: Linked
*/
function function_5091797(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx_tag = (isdefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver");
	if(newval == 1)
	{
		self.var_cc9c5baa = util::playfxontag(localclientnum, level._effect[#"hash_206a58239ffb5e0f"], self, str_fx_tag);
		if(!isdefined(self.var_6450813b))
		{
			self playsound(localclientnum, #"hash_76feff9b8f93c3d9");
			self.var_6450813b = self playloopsound(#"hash_117558f0dda6471f");
		}
	}
	else
	{
		if(isdefined(self.var_cc9c5baa))
		{
			stopfx(localclientnum, self.var_cc9c5baa);
		}
		if(isdefined(self.var_6450813b))
		{
			self playsound(localclientnum, #"hash_ae4b548c1d4a748");
			self stoploopsound(self.var_6450813b);
			self.var_6450813b = undefined;
		}
		util::playfxontag(localclientnum, level._effect[#"hash_b784dd4d224f7e"], self, str_fx_tag);
	}
}

/*
	Name: function_e2680ff3
	Namespace: namespace_765d6379
	Checksum: 0xABC85803
	Offset: 0x1110
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_e2680ff3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_fx_tag = (isdefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver");
	util::playfxontag(localclientnum, level._effect[#"hash_2b842a4f17120dfb"], self, str_fx_tag);
	self playsound(0, #"hash_3098cba1f74bb5d1");
}

