// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_customgame.csc;
#using scripts\zm_common\zm_wallbuy.csc;
#using script_624a704d0f6bf28d;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\serverfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace mansion_pap;

/*
	Name: init_clientfields
	Namespace: mansion_pap
	Checksum: 0x3AF0921F
	Offset: 0x2F8
	Size: 0x78C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_51257ec597a8f84f", 8000, getminbitcountfornum(3), "int", &function_9e5522ac, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_47b8db8cde2c4291", 8000, getminbitcountfornum(13), "int", &function_731e7fcf, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6babc320ed9a08f1", 8000, 1, "int", &function_828749d4, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1f18edb30c01161a", 8000, 1, "int", &function_9d797e21, 0, 0);
	clientfield::register("scriptmover", "" + #"ghost_trail", 8000, 1, "int", &ghost_trail_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_11eb6b7dc7db71ad", 8000, getminbitcountfornum(1), "int", &function_924f922d, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_58b293ceeb7f93e4", 8000, 1, "int", &function_5fc23aa1, 0, 0);
	clientfield::register("scriptmover", "" + #"vision_stone_wormhole", 8000, getminbitcountfornum(17), "int", &function_c0257c1d, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2d63a1398e98f279", 8000, 1, "int", &function_6812bd74, 0, 0);
	clientfield::register("toplayer", "" + #"hash_ea66e39c63f5b41", 13000, 1, "int", &function_ec12026f, 0, 0);
	clientfield::register("allplayers", "" + #"hash_49de76d6c4f95e5d", 8000, 1, "int", &function_738252b1, 0, 0);
	if(zm_utility::is_standard() || zm_custom::function_901b751c(#"zmpapenabled") == 2)
	{
		return;
	}
	namespace_617a54f4::function_d8383812(#"sc_mh1", 8000, #"mh_cpt1", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_mh2", 8000, #"mh_cpt2", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_mh3", 8000, #"mh_cpt3", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lb1", 8000, #"lb_cpt1", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lb2", 8000, #"lb_cpt2", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_lb3", 8000, #"lb_cpt3", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_cl1", 8000, #"cl_cpt1", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_cl2", 8000, #"cl_cpt2", 400, level._effect[#"pap_projectile"], level._effect[#"pap_projectile_end"], undefined, undefined, 1);
}

/*
	Name: init_fx
	Namespace: mansion_pap
	Checksum: 0x6FDA750E
	Offset: 0xA90
	Size: 0x782
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"ghost_trail"] = #"hash_1548e64b3b6c131";
	level._effect[#"pap_projectile"] = #"hash_59977c4c851916e0";
	level._effect[#"pap_projectile_end"] = #"hash_1a06427eff8dfe13";
	level._effect[#"hash_3e60b8be62e0e427"] = #"hash_41384db90e66558b";
	level._effect[#"hash_32c45f56d5a6bf6c"] = #"hash_5d1eb6746beee299";
	level._effect[#"hash_5dfd7f47fc0123ad"] = #"hash_45b5a28321d54ea0";
	level._effect[#"hash_34d62c40ae5290e6"] = #"hash_3d736a45c27a711d";
	level._effect[#"hash_229bf68ca0edaadb"] = #"hash_2949c26febe96072";
	level._effect[#"hash_2e59763a88bb2bd4"] = #"hash_749d6ee7eea4a790";
	level._effect[#"hash_9ac3900bb7115d"] = #"hash_75d6f353559fa727";
	level._effect[#"hash_59f382e0eb4cd8ae"] = #"hash_c7fd90f65f34ace";
	level._effect[#"hash_11eb6b7dc7db71ad"] = #"hash_64716dfdcaeec561";
	level._effect[#"hash_40afbfdd24d6ef3f"] = #"hash_564c423f11cec2a0";
	level._effect[#"hash_3fee8d30e3aef8f4"] = #"hash_48f874b8f527eb83";
	level._effect[#"hash_10828fdcdb29a8ed"] = #"hash_6c7970dafaa21ca1";
	level._effect[#"hash_38b6a9869169d0e4"] = #"hash_4cb9b6f2bdbab2e5";
	level._effect[#"hash_43c55f8b435b5b5d"] = #"hash_47de9e64d1f4457e";
	level._effect[#"hash_82b00d6eafcaeb2"] = #"hash_3076ea9e7398795b";
	level._effect[#"hash_2c459fc1dea4fc1a"] = #"hash_405b88c6ff597dd6";
	level._effect[#"hash_7dfd2f1cae6da563"] = #"hash_750666763510e998";
	level._effect[#"hash_60c83e34e4fd1f6c"] = #"hash_73f660fbf8e552c7";
	level._effect[#"hash_24e8dc159b114ae3"] = #"hash_715cf74f791295c4";
	level._effect[#"hash_17a4fb60d97429ad"] = #"hash_7dcfe2ffad2ca4fc";
	level._effect[#"hash_736e639110a07205"] = #"hash_d9457aa02fd04ec";
	level._effect[#"hash_736e609110a06cec"] = #"hash_5d311a076b143596";
	level._effect[#"hash_736e619110a06e9f"] = #"hash_163eb4e35b91af14";
	level._effect[#"hash_736e5e9110a06986"] = #"hash_680fec8c354d5473";
	level._effect[#"hash_736e5f9110a06b39"] = #"hash_60fe8e16abfbc3dc";
	level._effect[#"hash_736e5c9110a06620"] = #"hash_60fe9116abfbc8f5";
	level._effect[#"hash_736e5d9110a067d3"] = #"hash_60fe9016abfbc742";
	level._effect[#"hash_736e6a9110a07dea"] = #"hash_2445dc176f3ccbd0";
	level._effect[#"hash_736e6b9110a07f9d"] = #"hash_641b8ba2af258ead";
	level._effect[#"hash_4505647f40a2100f"] = #"hash_dff2364b383cb35";
	level._effect[#"hash_4505637f40a20e5c"] = #"hash_5e3ff002a36de9bf";
	level._effect[#"hash_4505667f40a21375"] = #"hash_4c3f2c9d9bab6b2b";
	level._effect[#"hash_4505657f40a211c2"] = #"hash_686a88e23e439f4b";
	level._effect[#"hash_4505607f40a20943"] = #"hash_60d482b113231004";
	level._effect[#"hash_45055f7f40a20790"] = #"hash_3df0d337eb84dcac";
	level._effect[#"hash_4505627f40a20ca9"] = #"hash_5e4b61b99bf91d12";
	level._effect[#"hash_4505617f40a20af6"] = #"hash_2f0597b421f2c488";
}

/*
	Name: soul_release
	Namespace: mansion_pap
	Checksum: 0x843E58B2
	Offset: 0x1220
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"pap_projectile"], self, "tag_origin");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"pap_projectile_end"], self, "tag_origin");
	}
}

/*
	Name: function_9e5522ac
	Namespace: mansion_pap
	Checksum: 0x6A7B9748
	Offset: 0x12E8
	Size: 0x1AA
	Parameters: 7
	Flags: Linked
*/
function function_9e5522ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_f5227f6))
	{
		playfx(localclientnum, level._effect[#"hash_10828fdcdb29a8ed"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		stopfx(localclientnum, self.var_f5227f6);
		return;
	}
	switch(newval)
	{
		case 1:
		{
			str_fx = level._effect[#"hash_2c459fc1dea4fc1a"];
			break;
		}
		case 2:
		{
			str_fx = level._effect[#"hash_60c83e34e4fd1f6c"];
			break;
		}
		default:
		{
			str_fx = level._effect[#"hash_7dfd2f1cae6da563"];
		}
	}
	self.var_f5227f6 = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
}

/*
	Name: function_731e7fcf
	Namespace: mansion_pap
	Checksum: 0xD4A15505
	Offset: 0x14A0
	Size: 0x884
	Parameters: 7
	Flags: Linked
*/
function function_731e7fcf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	switch(newval)
	{
		case 0:
		{
			if(isdefined(self.var_23864f02))
			{
				stopfx(localclientnum, self.var_23864f02);
				self.var_23864f02 = undefined;
			}
			break;
		}
		case 1:
		{
			str_tag = "charging_circle_number_01_jnt";
			self stoprenderoverridebundle(#"hash_61170b938ecbae23", str_tag);
			break;
		}
		case 2:
		{
			str_tag = "charging_circle_number_02_jnt";
			self stoprenderoverridebundle(#"hash_61170c938ecbafd6", str_tag);
			break;
		}
		case 3:
		{
			str_tag = "charging_circle_number_03_jnt";
			self stoprenderoverridebundle(#"hash_61170d938ecbb189", str_tag);
			break;
		}
		case 4:
		{
			str_tag = "charging_circle_number_04_jnt";
			self stoprenderoverridebundle(#"hash_61170e938ecbb33c", str_tag);
			break;
		}
		case 5:
		{
			str_tag = "charging_circle_number_05_jnt";
			self stoprenderoverridebundle(#"hash_61170f938ecbb4ef", str_tag);
			break;
		}
		case 6:
		{
			str_tag = "charging_circle_number_06_jnt";
			self stoprenderoverridebundle(#"hash_611710938ecbb6a2", str_tag);
			var_24a77d58 = self playloopsound(#"hash_4cbb119df079b8ad");
			break;
		}
		case 7:
		{
			str_tag = "charging_circle_number_07_jnt";
			self stoprenderoverridebundle(#"hash_611711938ecbb855", str_tag);
			break;
		}
		case 8:
		{
			str_tag = "charging_circle_number_08_jnt";
			self stoprenderoverridebundle(#"hash_611712938ecbba08", str_tag);
			break;
		}
		case 9:
		{
			str_tag = "charging_circle_number_09_jnt";
			self stoprenderoverridebundle(#"hash_611713938ecbbbbb", str_tag);
			break;
		}
		case 10:
		{
			str_tag = "charging_circle_number_10_jnt";
			self stoprenderoverridebundle(#"hash_611a90938ecec5f9", str_tag);
			break;
		}
		case 11:
		{
			str_tag = "charging_circle_number_11_jnt";
			self stoprenderoverridebundle(#"hash_611a8f938ecec446", str_tag);
			break;
		}
		case 12:
		{
			self.b_completed = 1;
			str_tag = "charging_circle_number_12_jnt";
			self stoprenderoverridebundle(#"hash_611a8e938ecec293", str_tag);
			self stoprenderoverridebundle(#"hash_31724d2ff7557f6f", "charging_circle_jnt");
			self stopallloopsounds();
			if(isdefined(self.var_23864f02))
			{
				stopfx(localclientnum, self.var_23864f02);
				self.var_23864f02 = undefined;
			}
			break;
		}
		case 13:
		{
			if(!isdefined(self.var_23864f02) && (!(isdefined(self.b_completed) && self.b_completed)))
			{
				self.var_23864f02 = playfx(localclientnum, level._effect[#"hash_32c45f56d5a6bf6c"], self.origin, vectorscale((0, 0, 1), 360), vectorscale((1, 0, 0), 360));
			}
			if(!(isdefined(self.b_started) && self.b_started))
			{
				self.b_started = 1;
				self playrenderoverridebundle(#"hash_31724d2ff7557f6f", "charging_circle_jnt");
				self playrenderoverridebundle(#"hash_61170b938ecbae23", "charging_circle_number_01_jnt");
				self playrenderoverridebundle(#"hash_61170c938ecbafd6", "charging_circle_number_02_jnt");
				self playrenderoverridebundle(#"hash_61170d938ecbb189", "charging_circle_number_03_jnt");
				self playrenderoverridebundle(#"hash_61170e938ecbb33c", "charging_circle_number_04_jnt");
				self playrenderoverridebundle(#"hash_61170f938ecbb4ef", "charging_circle_number_05_jnt");
				self playrenderoverridebundle(#"hash_611710938ecbb6a2", "charging_circle_number_06_jnt");
				self playrenderoverridebundle(#"hash_611711938ecbb855", "charging_circle_number_07_jnt");
				self playrenderoverridebundle(#"hash_611712938ecbba08", "charging_circle_number_08_jnt");
				self playrenderoverridebundle(#"hash_611713938ecbbbbb", "charging_circle_number_09_jnt");
				self playrenderoverridebundle(#"hash_611a90938ecec5f9", "charging_circle_number_10_jnt");
				self playrenderoverridebundle(#"hash_611a8f938ecec446", "charging_circle_number_11_jnt");
				self playrenderoverridebundle(#"hash_611a8e938ecec293", "charging_circle_number_12_jnt");
				var_f6f521f4 = self playloopsound(#"hash_4f64bfb4c243e852");
			}
			break;
		}
	}
	if(isdefined(str_tag) && isdefined(self))
	{
		v_org = self gettagorigin(str_tag);
		v_tag_angles = self gettagangles(str_tag);
		if(!isvec(v_tag_angles))
		{
			return;
		}
		v_right = anglestoright(v_tag_angles);
		v_up = anglestoup(v_tag_angles);
		if(isvec(v_org) && isvec(v_right) && isvec(v_up))
		{
			playfx(localclientnum, level._effect[#"hash_24e8dc159b114ae3"], v_org, v_right, v_up);
		}
	}
}

/*
	Name: function_828749d4
	Namespace: mansion_pap
	Checksum: 0xCAF37C65
	Offset: 0x1D30
	Size: 0x1C6
	Parameters: 7
	Flags: Linked
*/
function function_828749d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(!isdefined(self.var_817d52ab))
		{
			switch(self.model)
			{
				case "p8_zm_man_pap_gazing_stone_01_full":
				{
					str_effect = level._effect[#"hash_59f382e0eb4cd8ae"];
					break;
				}
				case "hash_7e08d4df1f3ead6":
				{
					str_effect = level._effect[#"hash_2e59763a88bb2bd4"];
					break;
				}
				case "p8_zm_man_pap_gazing_stone_03_full":
				{
					str_effect = level._effect[#"hash_9ac3900bb7115d"];
					break;
				}
			}
			if(isdefined(str_effect))
			{
				self.var_817d52ab = playfx(localclientnum, str_effect, self.origin, anglestoforward(self.angles), anglestoup(self.angles));
				if(isdefined(self.var_c71b680c))
				{
					stopfx(localclientnum, self.var_c71b680c);
					self.var_c71b680c = undefined;
				}
			}
		}
	}
	else if(isdefined(self.var_817d52ab))
	{
		stopfx(localclientnum, self.var_817d52ab);
		self.var_817d52ab = undefined;
	}
}

/*
	Name: function_9d797e21
	Namespace: mansion_pap
	Checksum: 0xA60E51F9
	Offset: 0x1F00
	Size: 0x26A
	Parameters: 7
	Flags: Linked
*/
function function_9d797e21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(!isdefined(self.var_306bf925))
		{
			switch(self.model)
			{
				case "p8_zm_man_pap_gazing_stone_01_full":
				{
					str_effect = level._effect[#"hash_229bf68ca0edaadb"];
					break;
				}
				case "hash_7e08d4df1f3ead6":
				{
					str_effect = level._effect[#"hash_5dfd7f47fc0123ad"];
					break;
				}
				case "p8_zm_man_pap_gazing_stone_03_full":
				{
					str_effect = level._effect[#"hash_34d62c40ae5290e6"];
					break;
				}
			}
			if(isdefined(str_effect))
			{
				v_up = vectorscale((1, 0, 0), 360);
				v_forward = vectorscale((0, 0, 1), 360);
				self.var_306bf925 = playfx(localclientnum, str_effect, self.origin, v_forward, v_up);
			}
		}
	}
	else if(isdefined(self.var_306bf925))
	{
		stopfx(localclientnum, self.var_306bf925);
		self.var_306bf925 = undefined;
		switch(self.model)
		{
			case "p8_zm_man_pap_gazing_stone_01_full":
			{
				str_effect = level._effect[#"hash_82b00d6eafcaeb2"];
				break;
			}
			case "hash_7e08d4df1f3ead6":
			{
				str_effect = level._effect[#"hash_38b6a9869169d0e4"];
				break;
			}
			case "p8_zm_man_pap_gazing_stone_03_full":
			{
				str_effect = level._effect[#"hash_43c55f8b435b5b5d"];
				break;
			}
		}
		self.var_c71b680c = playfx(localclientnum, str_effect, self.origin);
	}
}

/*
	Name: ghost_trail_fx
	Namespace: mansion_pap
	Checksum: 0xC55603F8
	Offset: 0x2178
	Size: 0x236
	Parameters: 7
	Flags: Linked
*/
function ghost_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(!isdefined(self.fx_ghost_trail))
		{
			if(!isdefined(level.var_e62313ec))
			{
				level.var_e62313ec = [];
			}
			foreach(var_ff4b3a13 in array::remove_undefined(level.var_e62313ec))
			{
				var_ff4b3a13.b_force_stream = 0;
			}
			self.fx_ghost_trail = util::playfxontag(localclientnum, level._effect[#"ghost_trail"], self, "j_spine4");
			self thread ghost_impact_fx(localclientnum);
			self.var_ad049408 = self playloopsound(#"hash_298631572be3dd79");
		}
	}
	else if(isdefined(self.fx_ghost_trail))
	{
		playfx(localclientnum, level._effect[#"hash_40afbfdd24d6ef3f"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		stopfx(localclientnum, self.fx_ghost_trail);
		self stoploopsound(self.var_ad049408);
		self.fx_ghost_trail = undefined;
	}
}

/*
	Name: function_924f922d
	Namespace: mansion_pap
	Checksum: 0xEAC1E19D
	Offset: 0x23B8
	Size: 0x3A2
	Parameters: 7
	Flags: Linked
*/
function function_924f922d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	switch(newval)
	{
		case 1:
		{
			self.b_force_stream = 1;
			str_model = self.model;
			if(!isdefined(level.var_e62313ec))
			{
				level.var_e62313ec = [];
			}
			if(!isdefined(level.var_e62313ec))
			{
				level.var_e62313ec = [];
			}
			else if(!isarray(level.var_e62313ec))
			{
				level.var_e62313ec = array(level.var_e62313ec);
			}
			if(!isinarray(level.var_e62313ec, self))
			{
				level.var_e62313ec[level.var_e62313ec.size] = self;
			}
			self playrenderoverridebundle(#"hash_51b6bba95848bab8");
			forcestreamxmodel(str_model);
			while(isdefined(self) && self.b_force_stream)
			{
				wait(1);
				e_player = function_5c10bd79(localclientnum);
				if(!isdefined(e_player) || !isdefined(self))
				{
					continue;
				}
				v_eye = e_player geteye();
				if((abs(self.origin[2] - v_eye[2])) <= 96 && distance2dsquared(v_eye, self.origin) <= 202500)
				{
					/#
						self thread function_3e31854(e_player);
					#/
					forcestreamxmodel(str_model);
				}
				else
				{
					/#
						self thread function_3e31854(e_player, (1, 0, 0));
					#/
					stopforcestreamingxmodel(str_model);
				}
			}
			stopforcestreamingxmodel(str_model);
			/#
				if(isdefined(self))
				{
					self notify(#"hash_199d88acd54c89d4");
				}
			#/
			break;
		}
		default:
		{
			self.b_force_stream = 0;
			playfx(localclientnum, level._effect[#"hash_11eb6b7dc7db71ad"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
			self stoprenderoverridebundle(#"hash_51b6bba95848bab8");
		}
	}
}

/*
	Name: function_3e31854
	Namespace: mansion_pap
	Checksum: 0x1D90D741
	Offset: 0x2768
	Size: 0x1D6
	Parameters: 2
	Flags: None
*/
function function_3e31854(e_player, v_color)
{
	/#
		if(!isdefined(v_color))
		{
			v_color = (0, 1, 0);
		}
		if(!getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			return;
		}
		self notify(#"hash_199d88acd54c89d4");
		self endon(#"death", #"hash_199d88acd54c89d4");
		v_upper = self.origin + vectorscale((0, 0, 1), 96);
		v_lower = self.origin - vectorscale((0, 0, 1), 96);
		v_edge = vectorscale(anglestoforward(self.angles), 450);
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			circle(v_upper, 450, v_color, 0, 1);
			circle(v_lower, 450, v_color, 0, 1);
			line(v_upper, v_lower, v_color);
			line(v_upper, v_upper + v_edge, v_color);
			line(v_lower, v_lower + v_edge, v_color);
			waitframe(1);
		}
	#/
}

/*
	Name: function_738252b1
	Namespace: mansion_pap
	Checksum: 0x2ACC430C
	Offset: 0x2948
	Size: 0xDA
	Parameters: 7
	Flags: Linked
*/
function function_738252b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_d7a01210))
	{
		stopfx(localclientnum, self.var_d7a01210);
		self.var_d7a01210 = undefined;
		return;
	}
	str_fx = level._effect[#"hash_17a4fb60d97429ad"];
	str_tag = "j_spine4";
	if(self function_21c0fa55())
	{
		return;
	}
	self.var_d7a01210 = util::playfxontag(localclientnum, str_fx, self, str_tag);
}

/*
	Name: function_5fc23aa1
	Namespace: mansion_pap
	Checksum: 0xBFB57EA5
	Offset: 0x2A30
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_5fc23aa1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self playrenderoverridebundle(#"hash_42273a05e6150ef0");
		return;
	}
	self stoprenderoverridebundle(#"hash_42273a05e6150ef0");
	wait(6);
	if(isdefined(self))
	{
		self function_f6e99a8d(#"hash_42273a05e6150ef0");
		self playrenderoverridebundle(#"hash_1b29e0471c3a0eb7");
	}
}

/*
	Name: ghost_impact_fx
	Namespace: mansion_pap
	Checksum: 0x3109846C
	Offset: 0x2B10
	Size: 0x33E
	Parameters: 1
	Flags: Linked
*/
function ghost_impact_fx(localclientnum)
{
	self endon(#"death");
	v_contact = (0, 0, 0);
	var_c2b3e9bf = v_contact;
	while(isdefined(self))
	{
		v_start = self gettagorigin("j_spinelower");
		v_end = v_start + vectorscale(anglestoforward(self.angles), 16);
		a_trace = physicstrace(v_start, v_end, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), self, 8);
		v_contact = a_trace[#"position"];
		if(a_trace[#"surfacetype"] != "none" && distance2dsquared(v_contact, var_c2b3e9bf) > (256 * 2))
		{
			var_c2b3e9bf = v_contact;
			v_forward = anglestoforward(self.angles);
			/#
				self thread function_e0caca4e(v_contact, v_forward * -1);
			#/
			playfx(localclientnum, level._effect[#"hash_3fee8d30e3aef8f4"], v_contact, v_forward * -1, anglestoup(self.angles));
		}
		v_end = v_start + (vectorscale(anglestoforward(self.angles) * -1, 16));
		a_trace = physicstrace(v_start, v_end, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), self, 8);
		v_contact = a_trace[#"position"];
		if(a_trace[#"surfacetype"] != "none" && distance2dsquared(v_contact, var_c2b3e9bf) > (256 * 2))
		{
			var_c2b3e9bf = v_contact;
			v_forward = anglestoforward(self.angles);
			/#
				self thread function_e0caca4e(v_contact, v_forward);
			#/
			playfx(localclientnum, level._effect[#"hash_3fee8d30e3aef8f4"], v_contact, v_forward, anglestoup(self.angles));
		}
		waitframe(1);
	}
}

/*
	Name: function_c0257c1d
	Namespace: mansion_pap
	Checksum: 0x5A203766
	Offset: 0x2E58
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_c0257c1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_1e8f5c4b))
	{
		killfx(localclientnum, self.var_1e8f5c4b);
		self.var_1e8f5c4b = undefined;
	}
	if(newval)
	{
		self.var_1e8f5c4b = util::playfxontag(localclientnum, level._effect["vision_stone_wormhole_" + newval], self, "tag_fx_wormhole");
		/#
			self thread function_466c2fa3(level._effect["" + newval], newval);
		#/
		/#
			level thread function_5545acc1(newval);
		#/
	}
}

/*
	Name: function_ec12026f
	Namespace: mansion_pap
	Checksum: 0xDBCA05FB
	Offset: 0x2F68
	Size: 0xF4
	Parameters: 7
	Flags: Linked
*/
function function_ec12026f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(function_8b1a219a())
		{
			self.basefov = getdvar(#"cg_fov_default", 90);
			setdvar(#"cg_fov_default", 80);
		}
	}
	else if(function_8b1a219a())
	{
		if(isdefined(self.basefov))
		{
			setdvar(#"cg_fov_default", self.basefov);
		}
	}
}

/*
	Name: function_6812bd74
	Namespace: mansion_pap
	Checksum: 0x9DCB8949
	Offset: 0x3068
	Size: 0x106
	Parameters: 7
	Flags: Linked
*/
function function_6812bd74(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_cc366f3c))
		{
			self playsound(localclientnum, #"hash_5294772867120e07");
			self.var_cc366f3c = self playloopsound(#"hash_7c88ba38729587c9");
		}
	}
	else if(isdefined(self.var_cc366f3c))
	{
		self playsound(localclientnum, #"hash_6f1b4bead6f32c82");
		self stoploopsound(self.var_cc366f3c);
		self.var_cc366f3c = undefined;
	}
}

/*
	Name: function_466c2fa3
	Namespace: mansion_pap
	Checksum: 0xF9182A33
	Offset: 0x3178
	Size: 0xD6
	Parameters: 2
	Flags: None
*/
function function_466c2fa3(str_fx, newval)
{
	/#
		str_hint = function_f415205b(newval);
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0) && isdefined(self))
		{
			debug2dtext((100, 800, 0), (((("" + newval) + "") + str_hint) + "") + function_9e72a96(str_fx), (1, 1, 1));
			waitframe(1);
		}
	#/
}

/*
	Name: function_5545acc1
	Namespace: mansion_pap
	Checksum: 0x5B0BD20A
	Offset: 0x3258
	Size: 0x1EA
	Parameters: 1
	Flags: None
*/
function function_5545acc1(newval)
{
	/#
		if(!getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			return;
		}
		self notify("");
		self endon("");
		str_hint = function_f415205b(newval);
		if(!isdefined(level.var_d23472c9))
		{
			level.var_d23472c9 = [];
		}
		level.var_d23472c9[str_hint] = newval;
		v_pos = vectorscale((1, 1, 0), 128);
		n_offset = 24;
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			var_8b7c6b64 = 0;
			debug2dtext(v_pos, "", (0, 1, 0));
			foreach(i, n_step in level.var_d23472c9)
			{
				var_8b7c6b64 = var_8b7c6b64 + n_offset;
				debug2dtext(v_pos + (0, var_8b7c6b64, 0), (function_9e72a96(i) + "") + n_step, (0, 1, 0));
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_f415205b
	Namespace: mansion_pap
	Checksum: 0x5CF48FC
	Offset: 0x3450
	Size: 0x26E
	Parameters: 1
	Flags: None
*/
function function_f415205b(newval)
{
	/#
		switch(newval)
		{
			case 1:
			{
				str_hint = "";
				break;
			}
			case 2:
			{
				str_hint = "";
				break;
			}
			case 3:
			{
				str_hint = "";
				break;
			}
			case 4:
			{
				str_hint = "";
				break;
			}
			case 5:
			{
				str_hint = "";
				break;
			}
			case 6:
			{
				str_hint = "";
				break;
			}
			case 7:
			{
				str_hint = "";
				break;
			}
			case 8:
			{
				str_hint = "";
				break;
			}
			case 9:
			{
				str_hint = "";
				break;
			}
			case 10:
			{
				str_hint = "";
				break;
			}
			case 11:
			{
				str_hint = "";
				break;
			}
			case 12:
			{
				str_hint = "";
				break;
			}
			case 13:
			{
				str_hint = "";
				break;
			}
			case 14:
			{
				str_hint = "";
				break;
			}
			case 15:
			{
				str_hint = "";
				break;
			}
			case 16:
			{
				str_hint = "";
				break;
			}
			case 17:
			{
				str_hint = "";
				break;
			}
			default:
			{
				str_hint = "";
			}
		}
		return str_hint;
	#/
}

/*
	Name: function_e0caca4e
	Namespace: mansion_pap
	Checksum: 0xA7A63A6D
	Offset: 0x36C8
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function function_e0caca4e(org, ang)
{
	/#
		self notify("");
		self endon("");
		while(getdvarint(#"hash_3c4df2fe4b1618d5", 0) && isdefined(self))
		{
			debug_arrow(org, ang, (0, 1, 0));
			waitframe(1);
		}
	#/
}

/*
	Name: debug_arrow
	Namespace: mansion_pap
	Checksum: 0xC35C5A97
	Offset: 0x3758
	Size: 0x29C
	Parameters: 3
	Flags: None
*/
function debug_arrow(org, ang, opcolor)
{
	/#
		forward = anglestoforward(ang);
		forwardfar = vectorscale(forward, 25);
		forwardclose = vectorscale(forward, 25 * 0.8);
		right = anglestoright(ang);
		leftdraw = vectorscale(right, 25 * -0.2);
		rightdraw = vectorscale(right, 25 * 0.2);
		up = anglestoup(ang);
		right = vectorscale(right, 25);
		up = vectorscale(up, 25);
		red = (0.9, 0.2, 0.2);
		green = (0.2, 0.9, 0.2);
		blue = (0.2, 0.2, 0.9);
		if(isdefined(opcolor))
		{
			red = opcolor;
			green = opcolor;
			blue = opcolor;
		}
		line(org, org + forwardfar, red, 0.9);
		line(org + forwardfar, (org + forwardclose) + rightdraw, red, 0.9);
		line(org + forwardfar, (org + forwardclose) + leftdraw, red, 0.9);
		line(org, org + right, blue, 0.9);
		line(org, org + up, green, 0.9);
	#/
}

