// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1611421ee9b880d3;
#using script_624a704d0f6bf28d;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_a8113e97;

/*
	Name: init_clientfields
	Namespace: namespace_a8113e97
	Checksum: 0xCCA9C678
	Offset: 0x250
	Size: 0x62A
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("allplayers", "" + #"hash_5370f4bc9fc25d13", 8000, 1, "int", &function_bdecc239, 0, 1);
	clientfield::register("scriptmover", "" + #"hash_42b6c982eeb59c79", 8000, 2, "int", &function_9caa803, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_15af8e35c0c1f344", 8000, 2, "int", &function_986307c4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_663a4a99828c832b", 8000, 2, "int", &function_d9cc443f, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_709c03abf1a2e08b", 8000, 2, "int", &function_faf293b9, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_61d9ba9310d827ea", 8000, 2, "int", &function_8c4a565c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5eff598dc267e32a", 8000, 1, "int", &function_b75c6b4f, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4f11537440270a3", 8000, 1, "counter", &function_dea9fad1, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_141bb928b3d09e20", 8000, 1, "int", &function_6628d887, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_34c5ab29531f15f0", 8000, 1, "int", &function_b4e6c7be, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_546e7612359187c3", 8000, 1, "counter", &function_a0d4ae11, 0, 0);
	clientfield::register("toplayer", "" + #"hash_73a4abf07bc65bc3", 8000, 1, "counter", &function_b479829c, 0, 0);
	clientfield::register("world", "" + #"hash_557a1703971f074c", 8000, 1, "int", &function_bca55d4e, 0, 0);
	level._effect[#"hash_663a4a99828c832b"] = #"hash_7046110ad3c65161";
	level._effect[#"hash_709c03abf1a2e08b"] = #"hash_532ac819595d9bb5";
	level._effect[#"hash_61d9ba9310d827ea"] = #"hash_4a495cef0ef4aee2";
	level._effect[#"hash_415a43ea0ce519d0"] = #"hash_6a1ab09280787b72";
	level._effect[#"hash_52032416326181f0"] = #"hash_2cd1f480eb43a66e";
	level._effect[#"hash_4588a89d6156133b"] = #"hash_547b680a63dd5023";
	level._effect[#"hash_250f495cbd75db2a"] = #"zombie/fx8_doorbuy_death";
	level._effect[#"hash_52d102bc9f3a4964"] = #"hash_1e6d673cdbbf3f40";
	level._effect[#"hash_52d7eebc9f404616"] = #"hash_1e74733cdbc57252";
}

/*
	Name: function_a0d4ae11
	Namespace: namespace_a8113e97
	Checksum: 0x8A8AD572
	Offset: 0x888
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_a0d4ae11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self util::playfxontag(localclientnum, #"hash_71f448e1a71c505d", self, "tag_origin");
	}
}

/*
	Name: function_b479829c
	Namespace: namespace_a8113e97
	Checksum: 0xBA6D7409
	Offset: 0x908
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_b479829c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "zm_mansion_mq_rumble");
	}
}

/*
	Name: function_b4e6c7be
	Namespace: namespace_a8113e97
	Checksum: 0xAC3F6516
	Offset: 0x978
	Size: 0x1B4
	Parameters: 7
	Flags: Linked
*/
function function_b4e6c7be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(isdefined(self.var_de4f1b63))
		{
			stopfx(localclientnum, self.var_de4f1b63);
			self.var_de4f1b63 = undefined;
		}
		else
		{
			self.var_2efc1a24 = util::playfxontag(localclientnum, #"hash_4d334fce6095f749", self, "tag_origin");
		}
		if(isdefined(self.var_52baf800))
		{
			self stoploopsound(self.var_52baf800);
		}
	}
	else if(isdefined(self.var_2efc1a24))
	{
		stopfx(localclientnum, self.var_2efc1a24);
		self.var_2efc1a24 = undefined;
	}
	self.var_de4f1b63 = util::playfxontag(localclientnum, #"hash_335e6ce4ca3a37b3", self, "tag_origin");
	if(!isdefined(self.var_52baf800))
	{
		self.var_52baf800 = self playloopsound(#"hash_67377acc9921b8fe");
	}
	self function_5d482e78(#"hash_309e494aade1703c");
	self function_bf9d3071(#"hash_591c2c7461c7beed");
}

/*
	Name: function_6628d887
	Namespace: namespace_a8113e97
	Checksum: 0x3FECA2D
	Offset: 0xB38
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function function_6628d887(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_19fc85d = util::playfxontag(localclientnum, level._effect[#"hash_51c7bc3539ed5540"], self, "tag_origin");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_68213763a7707b92"], self, "tag_origin");
		if(isdefined(self.var_19fc85d))
		{
			stopfx(localclientnum, self.var_19fc85d);
			self.var_19fc85d = undefined;
		}
	}
}

/*
	Name: function_dea9fad1
	Namespace: namespace_a8113e97
	Checksum: 0xC6980EB4
	Offset: 0xC30
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_dea9fad1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playfx(localclientnum, level._effect[#"hash_250f495cbd75db2a"], self.origin);
	}
}

/*
	Name: function_b75c6b4f
	Namespace: namespace_a8113e97
	Checksum: 0xC07C3EB9
	Offset: 0xCB8
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function function_b75c6b4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self endon(#"death");
		self util::waittill_dobj(localclientnum);
		self function_f6e99a8d(#"hash_7f2b5509bb2ebd3f");
		self function_bf9d3071(#"hash_7f2b5509bb2ebd3f");
	}
	else
	{
		self function_5d482e78(#"hash_7f2b5509bb2ebd3f");
	}
}

/*
	Name: function_d9cc443f
	Namespace: namespace_a8113e97
	Checksum: 0xD80D7592
	Offset: 0xDA0
	Size: 0x194
	Parameters: 7
	Flags: Linked
*/
function function_d9cc443f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_c04854d8))
	{
		stopfx(localclientnum, self.var_c04854d8);
		self.var_c04854d8 = undefined;
	}
	if(isdefined(self.var_a5575986))
	{
		stopfx(localclientnum, self.var_a5575986);
		self.var_a5575986 = undefined;
		playsound(localclientnum, #"hash_7959a9d39417b936", self.origin);
	}
	if(newval == 1)
	{
		self.var_c04854d8 = util::playfxontag(localclientnum, level._effect[#"hash_663a4a99828c832b"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		self.var_a5575986 = util::playfxontag(localclientnum, level._effect[#"hash_415a43ea0ce519d0"], self, "tag_origin");
		playsound(localclientnum, #"hash_21707843209589cf", self.origin);
	}
}

/*
	Name: function_faf293b9
	Namespace: namespace_a8113e97
	Checksum: 0x43288D90
	Offset: 0xF40
	Size: 0x194
	Parameters: 7
	Flags: Linked
*/
function function_faf293b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_b3fcc406))
	{
		stopfx(localclientnum, self.var_b3fcc406);
		self.var_b3fcc406 = undefined;
	}
	if(isdefined(self.var_5092defe))
	{
		stopfx(localclientnum, self.var_5092defe);
		self.var_5092defe = undefined;
		playsound(localclientnum, #"hash_7959a9d39417b936", self.origin);
	}
	if(newval == 1)
	{
		self.var_b3fcc406 = util::playfxontag(localclientnum, level._effect[#"hash_709c03abf1a2e08b"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		self.var_5092defe = util::playfxontag(localclientnum, level._effect[#"hash_52032416326181f0"], self, "tag_origin");
		playsound(localclientnum, #"hash_2170794320958b82", self.origin);
	}
}

/*
	Name: function_8c4a565c
	Namespace: namespace_a8113e97
	Checksum: 0x5078CD4C
	Offset: 0x10E0
	Size: 0x194
	Parameters: 7
	Flags: Linked
*/
function function_8c4a565c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_f17dcf6b))
	{
		stopfx(localclientnum, self.var_f17dcf6b);
		self.var_f17dcf6b = undefined;
	}
	if(isdefined(self.var_47ae8f53))
	{
		stopfx(localclientnum, self.var_47ae8f53);
		self.var_47ae8f53 = undefined;
		playsound(localclientnum, #"hash_7959a9d39417b936", self.origin);
	}
	if(newval == 1)
	{
		self.var_f17dcf6b = util::playfxontag(localclientnum, level._effect[#"hash_61d9ba9310d827ea"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		self.var_47ae8f53 = util::playfxontag(localclientnum, level._effect[#"hash_4588a89d6156133b"], self, "tag_origin");
		playsound(localclientnum, #"hash_21707a4320958d35", self.origin);
	}
}

/*
	Name: function_9caa803
	Namespace: namespace_a8113e97
	Checksum: 0x1BECA2B6
	Offset: 0x1280
	Size: 0x312
	Parameters: 7
	Flags: Linked
*/
function function_9caa803(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_8709ee5a))
	{
		level.var_8709ee5a = [];
	}
	else if(!isarray(level.var_8709ee5a))
	{
		level.var_8709ee5a = array(level.var_8709ee5a);
	}
	if(newval == 1)
	{
		var_db37a1f6 = "beam_man_";
		if(!isdefined(level.var_8709ee5a))
		{
			level.var_8709ee5a = [];
		}
		else if(!isarray(level.var_8709ee5a))
		{
			level.var_8709ee5a = array(level.var_8709ee5a);
		}
		level.var_8709ee5a[level.var_8709ee5a.size] = util::playfxontag(localclientnum, #"hash_580bb2a71ac88814", self, "tag_origin");
	}
	else if(newval == 2)
	{
		var_79b95a68 = getent(localclientnum, "beam_man_2", "targetname");
		var_f1b20bef = getent(localclientnum, "beam_man_3", "targetname");
		level beam::kill(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", "beam8_zm_mansion_cemetery_observatory_sm");
		var_db37a1f6 = "beam_obs_";
	}
	else if(newval == 3)
	{
		var_db37a1f6 = "beam_obs_";
	}
	else
	{
		var_db37a1f6 = "beam_man_";
	}
	self function_81f056fe(localclientnum, newval, var_db37a1f6);
	if(newval == 0)
	{
		if(isdefined(level.var_8709ee5a))
		{
			foreach(n_fx in level.var_8709ee5a)
			{
				stopfx(localclientnum, n_fx);
			}
			level.var_8709ee5a = undefined;
		}
	}
}

/*
	Name: function_81f056fe
	Namespace: namespace_a8113e97
	Checksum: 0x58C5950B
	Offset: 0x15A0
	Size: 0x604
	Parameters: 3
	Flags: Linked
*/
function function_81f056fe(localclientnum, newval, var_db37a1f6)
{
	if(!isdefined(level.var_8709ee5a))
	{
		level.var_8709ee5a = [];
	}
	else if(!isarray(level.var_8709ee5a))
	{
		level.var_8709ee5a = array(level.var_8709ee5a);
	}
	var_79b95a68 = self;
	for(i = 0; i < 3; i++)
	{
		if(!isdefined(var_79b95a68))
		{
			var_79b95a68 = getent(localclientnum, var_db37a1f6 + i, "targetname");
		}
		var_f1b20bef = getent(localclientnum, var_db37a1f6 + i + 1, "targetname");
		if(isdefined(var_79b95a68) && isdefined(var_f1b20bef))
		{
			if(i == 2 && var_db37a1f6 == "beam_man_" || (i == 0 && var_db37a1f6 == "beam_obs_"))
			{
				var_be18b9fb = "beam8_zm_mansion_cemetery_observatory_sm";
			}
			else
			{
				var_be18b9fb = "beam8_zm_mansion_cemetery_observatory";
			}
			if(newval == 1 || newval == 2)
			{
				level beam::launch(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", var_be18b9fb, 1);
				soundlineemitter(#"hash_1c73b17d13624a48", var_79b95a68.origin, var_f1b20bef.origin);
				if(var_f1b20bef.targetname === "beam_obs_3")
				{
					if(!isdefined(level.var_8709ee5a))
					{
						level.var_8709ee5a = [];
					}
					else if(!isarray(level.var_8709ee5a))
					{
						level.var_8709ee5a = array(level.var_8709ee5a);
					}
					level.var_8709ee5a[level.var_8709ee5a.size] = util::playfxontag(localclientnum, #"hash_c6b5dc9777950d8", var_f1b20bef, "tag_origin");
				}
				else if(var_f1b20bef.targetname === "beam_man_2" || var_f1b20bef.targetname === "beam_obs" || var_f1b20bef.targetname === "beam_obs_2")
				{
					if(!isdefined(level.var_8709ee5a))
					{
						level.var_8709ee5a = [];
					}
					else if(!isarray(level.var_8709ee5a))
					{
						level.var_8709ee5a = array(level.var_8709ee5a);
					}
					level.var_8709ee5a[level.var_8709ee5a.size] = util::playfxontag(localclientnum, #"hash_b87fed38a9f91a", var_f1b20bef, "tag_origin");
				}
				else if(var_f1b20bef.targetname === "beam_man_1" || var_f1b20bef.targetname === "beam_obs_1")
				{
					if(!isdefined(level.var_8709ee5a))
					{
						level.var_8709ee5a = [];
					}
					else if(!isarray(level.var_8709ee5a))
					{
						level.var_8709ee5a = array(level.var_8709ee5a);
					}
					level.var_8709ee5a[level.var_8709ee5a.size] = playfx(localclientnum, #"hash_b87fed38a9f91a", var_f1b20bef.origin, anglestoforward(var_f1b20bef.angles) * -1, anglestoup(var_f1b20bef.angles));
				}
			}
			else
			{
				level beam::kill(var_79b95a68, "tag_origin", var_f1b20bef, "tag_origin", var_be18b9fb);
				soundstoplineemitter(#"hash_1c73b17d13624a48", var_79b95a68.origin, var_f1b20bef.origin);
			}
		}
		waitframe(5);
		if(newval == 0 || newval == 3 && var_79b95a68 !== self)
		{
			if(isdefined(var_79b95a68))
			{
				var_79b95a68 delete();
			}
			continue;
		}
		var_79b95a68 = undefined;
	}
	if(newval == 0 || newval == 3)
	{
		if(isdefined(var_f1b20bef))
		{
			var_f1b20bef delete();
		}
	}
}

/*
	Name: function_bca55d4e
	Namespace: namespace_a8113e97
	Checksum: 0xEB7BAC6C
	Offset: 0x1BB0
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_bca55d4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		forcestreammaterial("mc/mtl_skybox_zm_mansion_exposed_moon");
	}
	else
	{
		stopforcestreamingmaterial("mc/mtl_skybox_zm_mansion_exposed_moon");
	}
}

/*
	Name: function_986307c4
	Namespace: namespace_a8113e97
	Checksum: 0xA8005704
	Offset: 0x1C40
	Size: 0x206
	Parameters: 7
	Flags: Linked
*/
function function_986307c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.e_target = getent(localclientnum, "obs_target", "targetname");
		v_angles = self gettagangles("tag_fx_beam");
		v_end = self.origin + anglestoforward(v_angles) * 9999;
		self.e_target.origin = v_end;
		self.e_target.angles = v_angles;
		if(newval == 2)
		{
			self.var_f7aa5696 = util::playfxontag(localclientnum, #"hash_7fff0aac54c2724c", self, "tag_fx_beam");
		}
		else
		{
			self.var_f7aa5696 = util::playfxontag(localclientnum, #"hash_27c3041be4fa392e", self, "tag_fx_beam");
		}
		self.var_bd83c74d = util::playfxontag(localclientnum, #"hash_73298f54156f81e4", self.e_target, "tag_origin");
	}
	else if(isdefined(self.var_f7aa5696))
	{
		stopfx(localclientnum, self.var_f7aa5696);
		self.var_f7aa5696 = undefined;
	}
	if(isdefined(self.var_bd83c74d))
	{
		stopfx(localclientnum, self.var_bd83c74d);
		self.var_bd83c74d = undefined;
	}
}

/*
	Name: function_bdecc239
	Namespace: namespace_a8113e97
	Checksum: 0xB6B91E32
	Offset: 0x1E50
	Size: 0x1EC
	Parameters: 7
	Flags: Linked
*/
function function_bdecc239(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_22364243))
		{
			if(zm_utility::function_f8796df3(localclientnum))
			{
				self.var_22364243 = playviewmodelfx(localclientnum, level._effect[#"hash_52d102bc9f3a4964"], "tag_weapon_left");
			}
			else
			{
				self.var_22364243 = util::playfxontag(localclientnum, level._effect[#"hash_52d7eebc9f404616"], self, "tag_weapon_left");
			}
		}
		if(!isdefined(self.var_1fd2907d))
		{
			if(zm_utility::function_f8796df3(localclientnum))
			{
				self.var_1fd2907d = self playloopsound(#"hash_459db861d003fae1");
			}
			else
			{
				self.var_1fd2907d = self playloopsound(#"hash_48e1d623c45d8a0");
			}
		}
	}
	else if(isdefined(self.var_22364243))
	{
		deletefx(localclientnum, self.var_22364243);
		self.var_22364243 = undefined;
	}
	if(isdefined(self.var_1fd2907d))
	{
		self stoploopsound(self.var_1fd2907d);
		self.var_1fd2907d = undefined;
		self playsound(localclientnum, #"hash_7bf00147e0370d89");
	}
}

