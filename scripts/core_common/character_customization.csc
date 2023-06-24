// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\activecamo_shared.csc;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\multi_extracam.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

class class_7da27482 
{
	var var_444a0d45;
	var var_b3113387;
	var var_f141235b;
	var var_228f64da;
	var var_9896541c;
	var var_5633914d;
	var _i_mode;
	var var_cfe86a3e;
	var var_cf55444c;
	var var_1d73bad9;
	var var_f5c0467b;
	var var_db113baf;
	var _xuid;
	var var_eb95665;
	var var_640fbaae;
	var var_27af8d38;
	var var_54430cb6;
	var var_a287debe;
	var var_c31e86ed;
	var var_1d18f5c7;
	var var_cbcee022;
	var var_8d2161e9;
	var _angles;
	var _origin;
	var var_bf273e28;
	var var_266b2ff0;
	var var_9a4a8ea;
	var var_45210dc7;
	var var_bf4feef5;
	var var_851003fe;
	var var_9bea772f;
	var var_43b94d19;
	var var_ff2bed36;
	var var_b627749c;
	var var_506d3c33;
	var var_d781e2e4;
	var var_ef017bf9;
	var var_81bd1932;
	var var_609efd3e;
	var var_180f1c7d;
	var _target_name;

	/*
		Name: constructor
		Namespace: namespace_7da27482
		Checksum: 0xBF6979B3
		Offset: 0x598
		Size: 0x246
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self.var_f141235b = 0;
		self.var_81bd1932 = 0;
		self._xuid = undefined;
		self._target_name = undefined;
		self._i_mode = 4;
		self.var_1d73bad9 = 0;
		self.var_db113baf = 0;
		self.var_cf55444c = 0;
		self.var_cfe86a3e = 0;
		self.var_f5c0467b = [7:0, 6:0, 5:0, 4:0, 3:0, 2:0, 1:0, 0:0];
		/#
			/#
				assert(-1);
			#/
		#/
		self.var_228f64da = undefined;
		self.var_43b94d19 = 1;
		self.var_c31e86ed = 0;
		self.var_b3113387 = 0;
		self.var_444a0d45 = 0;
		self._origin = (0, 0, 0);
		self._angles = (0, 0, 0);
		self.var_9a4a8ea = undefined;
		self.var_cbcee022 = undefined;
		self.var_54430cb6 = undefined;
		self.var_9bea772f = undefined;
		self.var_a287debe = undefined;
		self.var_8d2161e9 = 0;
		self.var_45210dc7 = [];
		self.var_bf273e28 = [];
		self.var_5633914d = [];
		self.var_eb95665 = undefined;
		self.var_b627749c = 1;
		self.var_27af8d38 = [];
		self.var_bf4feef5 = 1;
		self.var_609efd3e = 1;
		self.var_9896541c = 0;
		self.var_851003fe = 1;
		self.var_ef017bf9 = 0;
		self.var_506d3c33 = [];
		self.var_ff2bed36 = undefined;
		self.var_640fbaae = undefined;
		self.var_266b2ff0 = undefined;
		self.var_d781e2e4 = undefined;
		self.var_180f1c7d = [];
		self.var_1d18f5c7 = 0;
	}

	/*
		Name: destructor
		Namespace: namespace_7da27482
		Checksum: 0x80F724D1
		Offset: 0x4998
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_7792df22
		Namespace: namespace_7da27482
		Checksum: 0xA6380985
		Offset: 0x4950
		Size: 0x3C
		Parameters: 1
		Flags: Linked
	*/
	function function_7792df22(locked)
	{
		if(var_444a0d45 != locked)
		{
			self.var_444a0d45 = locked;
			function_2a5421e3();
		}
	}

	/*
		Name: function_27945cb8
		Namespace: namespace_7da27482
		Checksum: 0x265FE91D
		Offset: 0x48E8
		Size: 0x5C
		Parameters: 2
		Flags: Linked
	*/
	function function_27945cb8(on_off, force = 0)
	{
		if(var_b3113387 != on_off || force)
		{
			self.var_b3113387 = on_off;
			function_2a5421e3();
		}
	}

	/*
		Name: function_2a5421e3
		Namespace: namespace_7da27482
		Checksum: 0x729806D
		Offset: 0x48A0
		Size: 0x3C
		Parameters: 0
		Flags: Linked, Private
	*/
	function private function_2a5421e3()
	{
		var_228f64da duplicate_render::set_entity_draft_unselected(var_f141235b, var_b3113387 || var_444a0d45);
	}

	/*
		Name: function_ca932c8
		Namespace: namespace_7da27482
		Checksum: 0x93DCCE76
		Offset: 0x47B0
		Size: 0xE2
		Parameters: 0
		Flags: Linked
	*/
	function function_ca932c8()
	{
		if(isdefined(var_228f64da))
		{
			if(!var_228f64da isstreamed())
			{
				return false;
			}
		}
		if(var_9896541c && function_d9aed86())
		{
			return false;
		}
		foreach(ent in var_5633914d)
		{
			if(isdefined(ent))
			{
				if(!ent isstreamed())
				{
					return false;
				}
			}
		}
		return true;
	}

	/*
		Name: function_da76c6d1
		Namespace: namespace_7da27482
		Checksum: 0xDA156A78
		Offset: 0x4750
		Size: 0x58
		Parameters: 0
		Flags: Linked
	*/
	function function_da76c6d1()
	{
		var_65496229 = [[ self ]]->function_690c9509();
		head_index = getequippedheadindexforhero(var_65496229, _i_mode);
		[[ self ]]->set_character_head(head_index);
	}

	/*
		Name: function_225b6e07
		Namespace: namespace_7da27482
		Checksum: 0xE2101686
		Offset: 0x46F0
		Size: 0x58
		Parameters: 0
		Flags: Linked
	*/
	function function_225b6e07()
	{
		var_65496229 = [[ self ]]->function_690c9509();
		character_index = getequippedheroindex(var_65496229, _i_mode);
		[[ self ]]->set_character_index(character_index);
	}

	/*
		Name: function_9146bf81
		Namespace: namespace_7da27482
		Checksum: 0xE4D8375A
		Offset: 0x4650
		Size: 0x94
		Parameters: 2
		Flags: Linked
	*/
	function function_9146bf81(itemindex, itemtype)
	{
		outfit_index = (itemtype == 7 ? var_cfe86a3e : var_cf55444c);
		if(!isdefined(itemindex))
		{
			itemindex = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype);
		}
		[[ self ]]->function_8701f84e(itemindex, itemtype);
	}

	/*
		Name: function_ac9cc79d
		Namespace: namespace_7da27482
		Checksum: 0xE9C299CA
		Offset: 0x45D0
		Size: 0x78
		Parameters: 1
		Flags: Linked
	*/
	function function_ac9cc79d(itemtype)
	{
		outfit_index = (itemtype == 7 ? var_cfe86a3e : var_cf55444c);
		[[ self ]]->function_8701f84e(function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype), itemtype);
	}

	/*
		Name: function_59d1302f
		Namespace: namespace_7da27482
		Checksum: 0xC7F9A1A0
		Offset: 0x4588
		Size: 0x3A
		Parameters: 0
		Flags: Linked
	*/
	function function_59d1302f()
	{
		for(itemtype = 0; itemtype < 8; itemtype++)
		{
			[[ self ]]->function_ac9cc79d(itemtype);
		}
	}

	/*
		Name: function_10b0cbea
		Namespace: namespace_7da27482
		Checksum: 0xF710D6F8
		Offset: 0x4548
		Size: 0x38
		Parameters: 0
		Flags: Linked
	*/
	function function_10b0cbea()
	{
		[[ self ]]->function_158505aa(function_76fbb09e(var_f141235b, _i_mode, var_1d73bad9));
	}

	/*
		Name: function_72be01b9
		Namespace: namespace_7da27482
		Checksum: 0x5A1C106
		Offset: 0x4508
		Size: 0x38
		Parameters: 0
		Flags: Linked
	*/
	function function_72be01b9()
	{
		[[ self ]]->set_character_outfit(function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9));
	}

	/*
		Name: function_77e3be08
		Namespace: namespace_7da27482
		Checksum: 0xE4995906
		Offset: 0x44B8
		Size: 0x44
		Parameters: 0
		Flags: Linked
	*/
	function function_77e3be08()
	{
		[[ self ]]->function_da76c6d1();
		[[ self ]]->function_72be01b9();
		[[ self ]]->function_10b0cbea();
		[[ self ]]->function_59d1302f();
	}

	/*
		Name: function_e599283f
		Namespace: namespace_7da27482
		Checksum: 0x152893EB
		Offset: 0x4400
		Size: 0xAC
		Parameters: 0
		Flags: Linked
	*/
	function function_e599283f()
	{
		return {#hash_5f383817:var_f5c0467b, #hash_665ae20e:var_cfe86a3e, #outfit:var_cf55444c, #hash_e1c69280:var_db113baf, #charactertype:var_1d73bad9, #charactermode:_i_mode, #xuid:_xuid};
	}

	/*
		Name: function_15a8906a
		Namespace: namespace_7da27482
		Checksum: 0x250332C6
		Offset: 0x42A8
		Size: 0x14C
		Parameters: 1
		Flags: Linked
	*/
	function function_15a8906a(var_23904c1d)
	{
		if(isdefined(var_23904c1d.xuid))
		{
			[[ self ]]->set_xuid(var_23904c1d.xuid);
		}
		[[ self ]]->set_character_mode(var_23904c1d.charactermode);
		[[ self ]]->set_character_index(var_23904c1d.charactertype);
		[[ self ]]->set_character_head(var_23904c1d.characterhead);
		[[ self ]]->set_character_outfit(var_23904c1d.outfit);
		[[ self ]]->function_158505aa(var_23904c1d.var_665ae20e);
		/#
			/#
				assert(var_23904c1d.var_5f383817.size == 8);
			#/
		#/
		foreach(itemtype, itemindex in var_23904c1d.var_5f383817)
		{
			[[ self ]]->function_8701f84e(itemindex, itemtype);
		}
	}

	/*
		Name: function_95779b72
		Namespace: namespace_7da27482
		Checksum: 0x8020593E
		Offset: 0x4260
		Size: 0x3A
		Parameters: 0
		Flags: Linked
	*/
	function function_95779b72()
	{
		for(itemtype = 0; itemtype < 8; itemtype++)
		{
			[[ self ]]->function_8701f84e(0, itemtype);
		}
	}

	/*
		Name: function_22039feb
		Namespace: namespace_7da27482
		Checksum: 0x6E5D2D77
		Offset: 0x4210
		Size: 0x44
		Parameters: 0
		Flags: Linked
	*/
	function function_22039feb()
	{
		set_character_outfit(0);
		function_158505aa(0);
		function_95779b72();
	}

	/*
		Name: function_81d84c71
		Namespace: namespace_7da27482
		Checksum: 0xE06DE8F4
		Offset: 0x4140
		Size: 0xC4
		Parameters: 0
		Flags: Linked
	*/
	function function_81d84c71()
	{
		self notify("78af646c5bda58c9");
		self endon("78af646c5bda58c9");
		if(var_9896541c)
		{
			while(function_d9aed86())
			{
				waitframe(1);
			}
			if(isdefined(var_eb95665))
			{
				var_228f64da function_5790ec6e(var_eb95665);
			}
			else
			{
				var_228f64da function_a72ef0c5(var_f141235b, _i_mode);
			}
		}
		else
		{
			var_228f64da function_a7842493();
		}
	}

	/*
		Name: function_7412658d
		Namespace: namespace_7da27482
		Checksum: 0xBAE906DA
		Offset: 0x40A0
		Size: 0x94
		Parameters: 1
		Flags: Linked
	*/
	function function_7412658d(params)
	{
		if(var_640fbaae !== params.exploder_id)
		{
			if(isdefined(var_640fbaae))
			{
				killradiantexploder(var_f141235b, var_640fbaae);
			}
			self.var_640fbaae = params.exploder_id;
			if(isdefined(var_640fbaae))
			{
				playradiantexploder(var_f141235b, var_640fbaae);
			}
		}
	}

	/*
		Name: function_dd872e2b
		Namespace: namespace_7da27482
		Checksum: 0x15B5738F
		Offset: 0x3F28
		Size: 0x16C
		Parameters: 2
		Flags: Linked
	*/
	function function_dd872e2b(params, force_updates)
	{
		if(isdefined(params.weapon_right) || isdefined(params.weapon_left))
		{
			[[ self ]]->update_model_attachment(params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, force_updates);
			[[ self ]]->update_model_attachment(params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, force_updates);
		}
		else if(isdefined(params.activeweapon))
		{
			var_228f64da attachweapon(params.activeweapon, (isdefined(params.var_b8f20727) ? params.var_b8f20727 : 0));
			function_2e77aae4(var_f141235b, var_228f64da, (isdefined(params.var_b8f20727) ? params.var_b8f20727 : 0), var_27af8d38);
			var_228f64da useweaponhidetags(params.activeweapon);
		}
	}

	/*
		Name: function_2e77aae4
		Namespace: namespace_7da27482
		Checksum: 0xCE41BB6A
		Offset: 0x3DF0
		Size: 0x12A
		Parameters: 4
		Flags: Linked, Private
	*/
	function private function_2e77aae4(localclientnum, weaponmodel, var_6f2ae9c0, var_49daa2f6)
	{
		stage = getactivecamostage(var_6f2ae9c0);
		camoindex = getcamoindex(var_6f2ae9c0);
		activecamoinfo = activecamo::function_ae141bf2(camoindex);
		if(!isdefined(activecamoinfo))
		{
			return 0;
		}
		var_ddcdb079 = array(166, 167, 168, 170, 171, 172, 173);
		if(isinarray(var_ddcdb079, camoindex))
		{
			stage = 1;
		}
		var_3594168e = activecamoinfo.stages[stage];
		return activecamo::function_374e37a0(localclientnum, weaponmodel, var_3594168e, var_49daa2f6);
	}

	/*
		Name: function_39a68bf2
		Namespace: namespace_7da27482
		Checksum: 0x3C350DE0
		Offset: 0x3D30
		Size: 0xB2
		Parameters: 2
		Flags: Linked
	*/
	function function_39a68bf2(stop_update = 1, var_93eea46f = 0)
	{
		self.var_1d18f5c7 = 0;
		if(stop_update)
		{
			self notify(#"hash_578cb70e92c24a5a");
			self.var_1d18f5c7 = 1;
		}
		if(isdefined(var_54430cb6))
		{
			var_a287debe scene::cancel(var_54430cb6, 0);
			if(!var_93eea46f)
			{
				self.var_54430cb6 = undefined;
				self.var_a287debe = undefined;
			}
		}
	}

	/*
		Name: function_69ac4009
		Namespace: namespace_7da27482
		Checksum: 0x3641AB94
		Offset: 0x3CF8
		Size: 0x2E
		Parameters: 1
		Flags: Linked
	*/
	function function_69ac4009(var_cc478c99)
	{
		gesture = get_gesture(var_cc478c99);
	}

	/*
		Name: function_8144231c
		Namespace: namespace_7da27482
		Checksum: 0x2B5F58C
		Offset: 0x3C88
		Size: 0x62
		Parameters: 0
		Flags: Linked
	*/
	function function_8144231c()
	{
		if(!var_c31e86ed && #"female" === getherogender(var_1d73bad9, _i_mode))
		{
			return #"hash_26d5282647da1123";
		}
		return #"hash_4157b71749071ad4";
	}

	/*
		Name: function_47ad026
		Namespace: namespace_7da27482
		Checksum: 0xB099001E
		Offset: 0x3C38
		Size: 0x44
		Parameters: 0
		Flags: Linked
	*/
	function function_47ad026()
	{
		if(var_1d18f5c7 && isdefined(var_cbcee022))
		{
			var_228f64da thread animation::play(var_cbcee022, var_228f64da);
		}
	}

	/*
		Name: function_b204f6e3
		Namespace: namespace_7da27482
		Checksum: 0x6092CEB
		Offset: 0x3928
		Size: 0x304
		Parameters: 4
		Flags: Linked
	*/
	function function_b204f6e3(var_cc478c99, var_4a759822, var_1b1e990c = 1, var_e14a92d8 = 0)
	{
		self endon(#"deleted");
		self endon(#"cancel_gesture");
		if(var_4a759822 && isdefined(var_1d18f5c7))
		{
			while(![[ self ]]->function_ea4ac9f8())
			{
				wait(0.25);
			}
		}
		var_2ec36514 = var_cbcee022;
		[[ self ]]->function_39a68bf2(1, 1);
		gesture = get_gesture(var_cc478c99);
		if(isdefined(gesture) && isdefined(gesture.animation))
		{
			self endon(#"hash_578cb70e92c24a5a", #"cancel_gesture");
			while(!isdefined(var_cbcee022) && !isdefined(var_54430cb6))
			{
				wait(0.1);
			}
			var_a7e34ee1 = var_228f64da getcurrentanimscriptedname();
			var_99789677 = var_a7e34ee1 === gesture.animation || var_a7e34ee1 === gesture.intro || var_a7e34ee1 === gesture.outro;
			if(!var_e14a92d8 || !var_99789677)
			{
				if(var_1b1e990c || !var_99789677)
				{
					self thread function_60b3658e(var_2ec36514, 1);
					character_customization::function_bee62aa1(self);
					if(isdefined(gesture.intro))
					{
						var_228f64da animation::play(gesture.intro, var_228f64da);
					}
					var_228f64da animation::play(gesture.animation, var_228f64da);
					if(isdefined(gesture.outro))
					{
						var_228f64da animation::play(gesture.outro, var_228f64da);
					}
					self notify(#"gesture_ended");
				}
				else
				{
					self thread function_60b3658e(var_2ec36514, 0);
				}
			}
		}
	}

	/*
		Name: function_60b3658e
		Namespace: namespace_7da27482
		Checksum: 0xDB091B8
		Offset: 0x3850
		Size: 0xCC
		Parameters: 2
		Flags: Linked, Private
	*/
	function private function_60b3658e(var_2ec36514, need_wait)
	{
		if(need_wait)
		{
			self endon(#"deleted", #"hash_578cb70e92c24a5a");
			self waittill(#"cancel_gesture", #"gesture_ended");
		}
		if(isdefined(var_2ec36514))
		{
			var_228f64da thread animation::play(var_2ec36514, var_228f64da);
		}
		else if(isdefined(var_54430cb6))
		{
			if(var_8d2161e9)
			{
				var_a287debe thread scene::play(var_54430cb6, var_228f64da);
			}
		}
	}

	/*
		Name: function_b94f710e
		Namespace: namespace_7da27482
		Checksum: 0xCC8C4EFA
		Offset: 0x36E0
		Size: 0x168
		Parameters: 0
		Flags: Linked
	*/
	function function_b94f710e()
	{
		if(isdefined(var_cbcee022))
		{
			[[ self ]]->function_39a68bf2();
			var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_cbcee022, 0);
		}
		else if(isdefined(var_54430cb6))
		{
			[[ self ]]->function_39a68bf2();
			if(var_8d2161e9)
			{
				var_a287debe thread scene::play(var_54430cb6, var_228f64da);
			}
			else
			{
				var_a287debe thread scene::play(var_54430cb6);
			}
		}
		foreach(slot, ent in var_5633914d)
		{
			ent thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_bf273e28[slot], 1);
		}
	}

	/*
		Name: function_ef064067
		Namespace: namespace_7da27482
		Checksum: 0xDE8EFB2C
		Offset: 0x3298
		Size: 0x440
		Parameters: 2
		Flags: Linked
	*/
	function function_ef064067(params, force_update)
	{
		changed = 0;
		if(!isdefined(params))
		{
			params = {};
		}
		if(!isdefined(params.exploder_id))
		{
			params.exploder_id = var_266b2ff0;
		}
		align_changed = 0;
		if(isdefined(var_9a4a8ea))
		{
			if(!isdefined(params.align_struct))
			{
				params.align_struct = struct::get(var_9a4a8ea);
			}
		}
		if(isdefined(params.align_struct) && (params.align_struct.origin !== _origin || params.align_struct.angles !== _angles))
		{
			self._origin = params.align_struct.origin;
			self._angles = params.align_struct.angles;
			if(!isdefined(params.anim_name))
			{
				params.anim_name = var_cbcee022;
			}
			align_changed = 1;
		}
		if(isdefined(params.anim_name) && (params.anim_name !== var_cbcee022 || align_changed || force_update))
		{
			changed = 1;
			[[ self ]]->function_39a68bf2(0);
			self.var_cbcee022 = params.anim_name;
			self.var_54430cb6 = undefined;
			self.var_a287debe = undefined;
			var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, params.anim_intro_name, var_cbcee022, 0);
		}
		else if(isdefined(params.scene) && (params.scene !== var_54430cb6 || params.var_c66a4a5d !== var_a287debe || ((isdefined(params.var_a34c858c) && params.var_a34c858c) != var_8d2161e9) || force_update))
		{
			changed = 1;
			[[ self ]]->function_39a68bf2(0);
			self.var_54430cb6 = params.scene;
			self.var_a287debe = (isdefined(params.var_c66a4a5d) ? params.var_c66a4a5d : level);
			self.var_8d2161e9 = isdefined(params.var_a34c858c) && params.var_a34c858c;
			self.var_cbcee022 = undefined;
			if(var_8d2161e9)
			{
				var_a287debe thread scene::play(var_54430cb6, var_228f64da);
			}
			else
			{
				if(isdefined(params.scene_shot))
				{
					var_a287debe thread scene::play(var_54430cb6, params.scene_shot);
				}
				else
				{
					if(isdefined(params.var_f5332569) && params.var_f5332569 > 0 && params.var_f5332569 < 1)
					{
						var_a287debe thread scene::play(var_54430cb6, undefined, undefined, 0, "play_from_time_normalized", params.var_f5332569);
					}
					else
					{
						var_a287debe thread scene::play(var_54430cb6);
					}
				}
			}
		}
		return changed;
	}

	/*
		Name: update_model_attachment
		Namespace: namespace_7da27482
		Checksum: 0x8AD5F2BC
		Offset: 0x2EF0
		Size: 0x3A0
		Parameters: 5
		Flags: Linked
	*/
	function update_model_attachment(attached_model, slot, model_anim, model_intro_anim, force_update)
	{
		/#
			/#
				assert(isdefined(level.model_type_bones));
			#/
		#/
		if(force_update || attached_model !== var_45210dc7[slot] || model_anim !== var_bf273e28[slot])
		{
			bone = (isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot);
			/#
				assert(isdefined(bone));
			#/
			if(isdefined(var_45210dc7[slot]))
			{
				if(isdefined(var_5633914d[slot]))
				{
					var_5633914d[slot] unlink();
					var_5633914d[slot] delete();
					self.var_5633914d[slot] = undefined;
				}
				else if(var_228f64da isattached(var_45210dc7[slot], bone))
				{
					var_228f64da detach(var_45210dc7[slot], bone);
				}
				self.var_45210dc7[slot] = undefined;
			}
			self.var_45210dc7[slot] = attached_model;
			if(isdefined(var_45210dc7[slot]))
			{
				if(isdefined(model_anim))
				{
					ent = spawn(var_f141235b, var_228f64da.origin, "script_model");
					ent sethighdetail(var_851003fe, var_bf4feef5);
					self.var_5633914d[slot] = ent;
					ent setmodel(var_45210dc7[slot]);
					if(!ent hasanimtree())
					{
						ent useanimtree("generic");
					}
					ent.origin = _origin;
					ent.angles = _angles;
					ent thread character_customization::play_intro_and_animation(_origin, _angles, model_intro_anim, model_anim, 1);
				}
				else if(!var_228f64da isattached(var_45210dc7[slot], bone))
				{
					var_228f64da attach(var_45210dc7[slot], bone);
				}
				self.var_bf273e28[slot] = model_anim;
			}
		}
		if(isdefined(var_5633914d[slot]))
		{
			[[ self ]]->function_62dd99d6(var_5633914d[slot]);
		}
	}

	/*
		Name: function_7ea1db75
		Namespace: namespace_7da27482
		Checksum: 0xAE9F8D6E
		Offset: 0x1CD8
		Size: 0x1210
		Parameters: 1
		Flags: Linked
	*/
	function function_7ea1db75(params)
	{
		self notify("6ce05c58b7635c54");
		self endon("6ce05c58b7635c54");
		self endon(#"deleted");
		self endon(#"hash_578cb70e92c24a5a");
		if(isdefined(var_9bea772f))
		{
			function_66b6e720(var_9bea772f);
			self.var_9bea772f = undefined;
			if(var_43b94d19)
			{
				var_228f64da show();
			}
		}
		function_66de4847();
		if(!isdefined(params))
		{
			params = {};
		}
		self.var_1d18f5c7 = 0;
		if([[ self ]]->function_bf7bce05())
		{
			base_model = [[ self ]]->function_d5e754c6();
			attached_models = [#"outfit_torso":#"tag_origin", #"outfit_legs":#"tag_origin", #"outfit_headgear":#"tag_origin", #"outfit_head":[[ self ]]->function_8c6b7af7(params), #"head":[[ self ]]->function_ccc149f(params)];
		}
		else
		{
			base_model = [[ self ]]->function_b06080fb();
			attached_models = [#"outfit_torso":[[ self ]]->function_d5e754c6(), #"outfit_legs":[[ self ]]->function_cdc02b18(), #"outfit_headgear":[[ self ]]->function_1978bfeb(), #"outfit_head":[[ self ]]->function_8c6b7af7(params), #"head":[[ self ]]->function_ccc149f(params)];
		}
		var_9e7c4fde = array(base_model);
		self.var_ff2bed36 = util::spawn_model(var_f141235b, base_model, (0, 0, 0));
		var_ff2bed36 hide();
		_models = [];
		foreach(slot, model in attached_models)
		{
			if(isdefined(model) && !isdefined(array::find(var_9e7c4fde, model)))
			{
				array::add(var_9e7c4fde, model);
				bone = (isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot);
				var_ff2bed36 attach(model, bone);
			}
		}
		foreach(model in var_9e7c4fde)
		{
			force_stream_model(model);
		}
		if(isdefined(params.var_d8cb38a9) && params.var_d8cb38a9 && isdefined(params.scene))
		{
			self.var_9bea772f = params.scene;
			var_a942d0c7 = 1;
			while(!forcestreambundle(params.scene))
			{
				if(var_a942d0c7)
				{
					var_228f64da hide();
					var_a942d0c7 = 0;
				}
				waitframe(1);
			}
			if(var_43b94d19)
			{
				var_228f64da show();
			}
		}
		var_56293673 = 1;
		foreach(model in var_9e7c4fde)
		{
			var_56293673 = var_56293673 & function_c358189(model);
		}
		[[ self ]]->function_62dd99d6(var_ff2bed36);
		if(isdefined(params.var_c76f3e47) && params.var_c76f3e47 && !var_c31e86ed && !var_ff2bed36 isstreamed(params.var_5bd51249, params.var_13fb1841))
		{
			if(isdefined(params.var_401d9a1) && params.var_401d9a1)
			{
				var_228f64da hide();
				[[ self ]]->function_27945cb8(1, 1);
				outfit_index = function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9);
				var_d92aad5c = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 0);
				var_2f1dcdbb = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 2);
				var_cb9bcfe7 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 3);
				var_173f7170 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 4);
				var_1f170bc0 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 6);
				if([[ self ]]->function_bf7bce05())
				{
					var_867954ad = character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, 0, _i_mode);
					var_89610e9c = [#"outfit_torso":#"tag_origin", #"outfit_legs":#"tag_origin", #"outfit_headgear":#"tag_origin", #"outfit_head":character_customization::function_6bca50af(&function_44a7328f, var_1d73bad9, outfit_index, 0, _i_mode), #"head":character_customization::function_6bca50af(&getcharacterheadmodel, 0, _i_mode)];
				}
				else
				{
					var_867954ad = character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, outfit_index, var_d92aad5c, _i_mode);
					var_89610e9c = [#"outfit_torso":character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, var_1f170bc0, _i_mode), #"outfit_legs":character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, outfit_index, var_173f7170, _i_mode), #"outfit_headgear":character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, outfit_index, var_cb9bcfe7, _i_mode), #"outfit_head":character_customization::function_6bca50af(&function_44a7328f, var_1d73bad9, outfit_index, var_2f1dcdbb, _i_mode), #"head":(isdefined(getcharacterheadmodel(0, _i_mode)) ? getcharacterheadmodel(0, _i_mode) : #"tag_origin")];
				}
				var_cf2f5fb7 = array(var_867954ad);
				foreach(model in var_89610e9c)
				{
					if(!isdefined(var_cf2f5fb7))
					{
						var_cf2f5fb7 = [];
					}
					else if(!isarray(var_cf2f5fb7))
					{
						var_cf2f5fb7 = array(var_cf2f5fb7);
					}
					if(!isinarray(var_cf2f5fb7, model))
					{
						var_cf2f5fb7[var_cf2f5fb7.size] = model;
					}
				}
				var_a9916921 = getdvarint(#"hash_40f551189b68d5c2", 1);
				foreach(model in var_cf2f5fb7)
				{
					force_stream_model(model, var_a9916921, 0);
				}
				do
				{
					waitframe(1);
					var_e2e2ee90 = 1;
					foreach(model in var_cf2f5fb7)
					{
						var_e2e2ee90 = var_e2e2ee90 & function_c358189(model, var_a9916921, 0);
					}
				}
				while(!var_e2e2ee90);
				function_91cd5499(util::spawn_model(var_f141235b, var_867954ad, _origin, _angles), 0, 0);
				self.var_b627749c = 1;
				[[ self ]]->function_27945cb8(1, 1);
				if(!var_43b94d19)
				{
					var_228f64da hide();
				}
				var_cc204afb = [];
				foreach(slot, model in var_89610e9c)
				{
					if(isdefined(model) && !isdefined(array::find(var_cc204afb, model)))
					{
						array::add(var_cc204afb, model);
						bone = (isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot);
						var_228f64da attach(model, bone);
					}
				}
				[[ self ]]->function_ef064067(params, 1);
				foreach(model in var_cf2f5fb7)
				{
					function_b020b858(model, var_a9916921, 0);
				}
			}
			do
			{
				waitframe(1);
			}
			while(!var_ff2bed36 isstreamed(params.var_5bd51249, params.var_13fb1841));
		}
		var_ff704b7c = isdefined(params.var_99a89f83) && params.var_99a89f83;
		if(var_b627749c)
		{
			self.var_b627749c = 0;
			var_ff704b7c = 1;
			[[ self ]]->function_39a68bf2(0);
			if(isdefined(base_model))
			{
				function_91cd5499(util::spawn_model(var_f141235b, base_model, _origin, _angles));
				self.var_45210dc7 = [];
				self.var_bf273e28 = [];
				self.var_5633914d = [];
			}
			if(!var_43b94d19)
			{
				var_228f64da hide();
			}
		}
		foreach(slot, model in attached_models)
		{
			[[ self ]]->update_model_attachment(model, slot, undefined, undefined, 1);
		}
		[[ self ]]->function_62dd99d6(var_228f64da);
		function_66de4847();
		changed = [[ self ]]->function_ef064067(params, var_ff704b7c);
		[[ self ]]->function_dd872e2b(params, changed);
		[[ self ]]->function_7412658d(params);
		self.var_9bea772f = undefined;
		if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
		{
			function_27945cb8(0);
		}
		if(isdefined(params.var_8d3b5f69) && params.var_8d3b5f69)
		{
			fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
			setuimodelvalue(fbc, 0);
		}
		thread [[ self ]]->function_81d84c71();
		self.var_1d18f5c7 = 1;
		var_2d0192e5 = [[ self ]]->function_82e05d64();
		if(isdefined(var_2d0192e5))
		{
			if(isdefined(var_2d0192e5.visible_model))
			{
				setuimodelvalue(var_2d0192e5.visible_model, [[ self ]]->function_ea4ac9f8() && [[ self ]]->is_visible());
			}
		}
		gestureindex = character_customization::function_6aee5a4e(self);
		if(isdefined(gestureindex) && gestureindex > 0)
		{
			thread [[ self ]]->function_b204f6e3(gestureindex, 0, 1, 0);
		}
	}

	/*
		Name: update
		Namespace: namespace_7da27482
		Checksum: 0x4BCD0259
		Offset: 0x1CA8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function update(params)
	{
		self thread function_7ea1db75(params);
	}

	/*
		Name: function_62dd99d6
		Namespace: namespace_7da27482
		Checksum: 0x699C46A4
		Offset: 0x1BE8
		Size: 0xB4
		Parameters: 1
		Flags: Linked
	*/
	function function_62dd99d6(model)
	{
		render_options = function_aa478513({#hash_18d63ea2:var_f5c0467b, #hash_34ba1b60:var_cfe86a3e, #outfitindex:var_cf55444c, #characterindex:var_1d73bad9, #mode:_i_mode});
		model setbodyrenderoptionspacked(render_options);
	}

	/*
		Name: function_d5e754c6
		Namespace: namespace_7da27482
		Checksum: 0xDC040CAC
		Offset: 0x1B78
		Size: 0x62
		Parameters: 0
		Flags: Linked
	*/
	function function_d5e754c6()
	{
		if(var_c31e86ed)
		{
			return #"c_t8_mp_swatbuddy_body2";
		}
		return character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, var_cf55444c, var_f5c0467b[6], _i_mode);
	}

	/*
		Name: function_cdc02b18
		Namespace: namespace_7da27482
		Checksum: 0x87175E3B
		Offset: 0x1B08
		Size: 0x62
		Parameters: 0
		Flags: Linked
	*/
	function function_cdc02b18()
	{
		if(var_c31e86ed)
		{
			return #"tag_origin";
		}
		return character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, var_cf55444c, var_f5c0467b[4], _i_mode);
	}

	/*
		Name: function_1978bfeb
		Namespace: namespace_7da27482
		Checksum: 0xCCCDC0B6
		Offset: 0x1A98
		Size: 0x62
		Parameters: 0
		Flags: Linked
	*/
	function function_1978bfeb()
	{
		if(var_c31e86ed)
		{
			return #"tag_origin";
		}
		return character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, var_cf55444c, var_f5c0467b[3], _i_mode);
	}

	/*
		Name: function_8c6b7af7
		Namespace: namespace_7da27482
		Checksum: 0x7528EA14
		Offset: 0x1A00
		Size: 0x8A
		Parameters: 1
		Flags: Linked
	*/
	function function_8c6b7af7(params)
	{
		if(var_c31e86ed)
		{
			return #"c_t8_mp_swatbuddy_head2";
		}
		if(![[ self ]]->function_ef6f931f(params))
		{
			return #"tag_origin";
		}
		return character_customization::function_6bca50af(&function_44a7328f, var_1d73bad9, var_cf55444c, var_f5c0467b[2], _i_mode);
	}

	/*
		Name: function_b06080fb
		Namespace: namespace_7da27482
		Checksum: 0x9F1DA52B
		Offset: 0x1998
		Size: 0x5A
		Parameters: 0
		Flags: Linked
	*/
	function function_b06080fb()
	{
		if(var_c31e86ed)
		{
			return #"tag_origin";
		}
		return character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, var_cf55444c, var_f5c0467b[0], _i_mode);
	}

	/*
		Name: function_ccc149f
		Namespace: namespace_7da27482
		Checksum: 0x436C2756
		Offset: 0x1928
		Size: 0x62
		Parameters: 1
		Flags: Linked
	*/
	function function_ccc149f(params)
	{
		if(var_c31e86ed)
		{
			return #"tag_origin";
		}
		if(![[ self ]]->function_f941c5de(params))
		{
			return #"tag_origin";
		}
		return getcharacterheadmodel(var_db113baf, _i_mode);
	}

	/*
		Name: function_ef6f931f
		Namespace: namespace_7da27482
		Checksum: 0x6C9F8702
		Offset: 0x1910
		Size: 0x10
		Parameters: 1
		Flags: Linked
	*/
	function function_ef6f931f(params)
	{
		return true;
	}

	/*
		Name: function_f941c5de
		Namespace: namespace_7da27482
		Checksum: 0xA88AD8F2
		Offset: 0x18F8
		Size: 0x10
		Parameters: 1
		Flags: Linked
	*/
	function function_f941c5de(params)
	{
		return true;
	}

	/*
		Name: function_bf7bce05
		Namespace: namespace_7da27482
		Checksum: 0xC4676A5F
		Offset: 0x18B8
		Size: 0x32
		Parameters: 0
		Flags: Linked
	*/
	function function_bf7bce05()
	{
		if(var_c31e86ed)
		{
			return 1;
		}
		return function_4611d0e6(_i_mode, var_1d73bad9);
	}

	/*
		Name: function_158505aa
		Namespace: namespace_7da27482
		Checksum: 0x4B2C70EC
		Offset: 0x1868
		Size: 0x42
		Parameters: 1
		Flags: Linked
	*/
	function function_158505aa(outfit_index)
	{
		/#
			/#
				assert(_i_mode != 4);
			#/
		#/
		self.var_cfe86a3e = outfit_index;
	}

	/*
		Name: function_8701f84e
		Namespace: namespace_7da27482
		Checksum: 0x6D516B69
		Offset: 0x1798
		Size: 0xC2
		Parameters: 2
		Flags: Linked
	*/
	function function_8701f84e(item_index, item_type)
	{
		/#
			/#
				assert(_i_mode != 4);
			#/
		#/
		if(var_f5c0467b[item_type] != item_index)
		{
			self.var_b627749c = var_b627749c | (item_type == 0 || item_type == 2 || item_type == 3 || item_type == 4 || item_type == 6);
			self.var_f5c0467b[item_type] = item_index;
		}
	}

	/*
		Name: set_character_outfit
		Namespace: namespace_7da27482
		Checksum: 0x5F3355C7
		Offset: 0x1730
		Size: 0x5E
		Parameters: 1
		Flags: Linked
	*/
	function set_character_outfit(outfit_index)
	{
		/#
			/#
				assert(_i_mode != 4);
			#/
		#/
		if(var_cf55444c != outfit_index)
		{
			self.var_b627749c = 1;
			self.var_cf55444c = outfit_index;
		}
	}

	/*
		Name: set_character_head
		Namespace: namespace_7da27482
		Checksum: 0x568A6F0C
		Offset: 0x16C8
		Size: 0x5E
		Parameters: 1
		Flags: Linked
	*/
	function set_character_head(head_index)
	{
		/#
			/#
				assert(_i_mode != 4);
			#/
		#/
		if(var_db113baf != head_index)
		{
			self.var_b627749c = 1;
			self.var_db113baf = head_index;
		}
	}

	/*
		Name: get_character_mode
		Namespace: namespace_7da27482
		Checksum: 0x5FC4F37F
		Offset: 0x16B0
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function get_character_mode()
	{
		return _i_mode;
	}

	/*
		Name: function_9004475c
		Namespace: namespace_7da27482
		Checksum: 0xB0A85254
		Offset: 0x1698
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function function_9004475c()
	{
		return var_1d73bad9;
	}

	/*
		Name: set_character_index
		Namespace: namespace_7da27482
		Checksum: 0x655455B8
		Offset: 0x1638
		Size: 0x56
		Parameters: 1
		Flags: Linked
	*/
	function set_character_index(character_index)
	{
		/#
			/#
				assert(isdefined(character_index));
			#/
		#/
		if(var_1d73bad9 != character_index)
		{
			self.var_b627749c = 1;
			self.var_1d73bad9 = character_index;
		}
	}

	/*
		Name: set_character_mode
		Namespace: namespace_7da27482
		Checksum: 0xA2AFA48D
		Offset: 0x15D8
		Size: 0x56
		Parameters: 1
		Flags: Linked
	*/
	function set_character_mode(character_mode)
	{
		/#
			/#
				assert(isdefined(character_mode));
			#/
		#/
		if(_i_mode != character_mode)
		{
			self.var_b627749c = 1;
			self._i_mode = character_mode;
		}
	}

	/*
		Name: function_617a9ce4
		Namespace: namespace_7da27482
		Checksum: 0x3D54CEA8
		Offset: 0x15A0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function function_617a9ce4(character_mode)
	{
		/#
			assert(character_mode === _i_mode);
		#/
	}

	/*
		Name: function_b020b858
		Namespace: namespace_7da27482
		Checksum: 0x3DABD529
		Offset: 0x14B0
		Size: 0xE4
		Parameters: 3
		Flags: Linked, Private
	*/
	function private function_b020b858(model_name, lod = -1, mip = -1)
	{
		index = array::find(var_506d3c33, {#mip:mip, #lod:lod, #model:model_name}, &function_1a57b132);
		if(isdefined(index))
		{
			array::pop(var_506d3c33, index, 0);
			character_customization::function_247f6628(model_name, lod, mip);
		}
	}

	/*
		Name: function_1a57b132
		Namespace: namespace_7da27482
		Checksum: 0xD5659B25
		Offset: 0x1438
		Size: 0x6A
		Parameters: 2
		Flags: Linked, Private
	*/
	function private function_1a57b132(data_1, data_2)
	{
		return data_1.model == data_2.model && data_1.lod == data_2.lod && data_1.mip == data_2.mip;
	}

	/*
		Name: function_c358189
		Namespace: namespace_7da27482
		Checksum: 0x51565B02
		Offset: 0x1348
		Size: 0xE2
		Parameters: 3
		Flags: Linked, Private
	*/
	function private function_c358189(model_name, lod = -1, mip = -1)
	{
		index = array::find(var_506d3c33, {#mip:mip, #lod:lod, #model:model_name}, &function_1a57b132);
		/#
			/#
				assert(isdefined(index));
			#/
		#/
		if(!isdefined(index))
		{
			return 1;
		}
		return character_customization::function_c358189(model_name, lod, mip);
	}

	/*
		Name: force_stream_model
		Namespace: namespace_7da27482
		Checksum: 0x9BBCF833
		Offset: 0x1290
		Size: 0xAC
		Parameters: 3
		Flags: Linked, Private
	*/
	function private force_stream_model(model_name, lod = -1, mip = -1)
	{
		array::add(var_506d3c33, {#mip:mip, #lod:lod, #model:model_name});
		character_customization::function_221a94ac(model_name, lod, mip);
	}

	/*
		Name: function_66de4847
		Namespace: namespace_7da27482
		Checksum: 0x6D2D920E
		Offset: 0x11B0
		Size: 0xD2
		Parameters: 0
		Flags: Linked, Private
	*/
	function private function_66de4847()
	{
		if(isdefined(var_ff2bed36))
		{
			var_ff2bed36 delete();
			self.var_ff2bed36 = undefined;
		}
		foreach(model_data in var_506d3c33)
		{
			character_customization::function_247f6628(model_data.model, model_data.lod, model_data.mip);
		}
		self.var_506d3c33 = [];
	}

	/*
		Name: function_ea4ac9f8
		Namespace: namespace_7da27482
		Checksum: 0xC28C21D6
		Offset: 0x1198
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function function_ea4ac9f8()
	{
		return var_1d18f5c7;
	}

	/*
		Name: get_gesture
		Namespace: namespace_7da27482
		Checksum: 0xAE9AC4F6
		Offset: 0x10C8
		Size: 0xC2
		Parameters: 1
		Flags: Linked
	*/
	function get_gesture(var_cc478c99)
	{
		if(var_cc478c99 == -1)
		{
			if(#"female" === getherogender(var_1d73bad9, _i_mode))
			{
				return {#animation:#"hash_108a8b0f7d2f377d"};
			}
			return {#animation:#"hash_233be4ac797ac20"};
		}
		return function_2a6a2af(var_1d73bad9, _i_mode, var_cc478c99);
	}

	/*
		Name: function_e8b0acef
		Namespace: namespace_7da27482
		Checksum: 0xF6D15428
		Offset: 0x1098
		Size: 0x22
		Parameters: 0
		Flags: Linked
	*/
	function function_e8b0acef()
	{
		return getcharacterfields(var_1d73bad9, _i_mode);
	}

	/*
		Name: function_82e05d64
		Namespace: namespace_7da27482
		Checksum: 0x956136A1
		Offset: 0x1068
		Size: 0x22
		Parameters: 0
		Flags: Linked
	*/
	function function_82e05d64()
	{
		if(!isdefined(var_d781e2e4))
		{
			self.var_d781e2e4 = {};
		}
		return var_d781e2e4;
	}

	/*
		Name: delete_models
		Namespace: namespace_7da27482
		Checksum: 0xBB4F3B76
		Offset: 0xF48
		Size: 0x114
		Parameters: 0
		Flags: Linked
	*/
	function delete_models()
	{
		self notify(#"deleted");
		foreach(ent in var_5633914d)
		{
			ent unlink();
			ent delete();
		}
		level.custom_characters[var_f141235b][var_228f64da.targetname] = undefined;
		self.var_5633914d = [];
		var_228f64da delete();
		self.var_228f64da = undefined;
		function_66de4847();
	}

	/*
		Name: get_angles
		Namespace: namespace_7da27482
		Checksum: 0x836CDACF
		Offset: 0xF30
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function get_angles()
	{
		return _angles;
	}

	/*
		Name: get_origin
		Namespace: namespace_7da27482
		Checksum: 0x9865DD1F
		Offset: 0xF18
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function get_origin()
	{
		return _origin;
	}

	/*
		Name: function_4a271da1
		Namespace: namespace_7da27482
		Checksum: 0xFEC14451
		Offset: 0xF00
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function function_4a271da1()
	{
		return var_ef017bf9;
	}

	/*
		Name: function_4240a39a
		Namespace: namespace_7da27482
		Checksum: 0x799FDF2C
		Offset: 0xE98
		Size: 0x5A
		Parameters: 2
		Flags: Linked
	*/
	function function_4240a39a(var_1f64805f, angles)
	{
		self.var_ef017bf9 = var_1f64805f;
		if(isdefined(angles))
		{
			var_228f64da.angles = angles;
		}
		else
		{
			var_228f64da.angles = _angles;
		}
	}

	/*
		Name: hide_model
		Namespace: namespace_7da27482
		Checksum: 0x19377A11
		Offset: 0xE40
		Size: 0x4C
		Parameters: 0
		Flags: Linked
	*/
	function hide_model()
	{
		var_228f64da hide();
		self notify(#"cancel_gesture");
		self.var_43b94d19 = 0;
		function_c39fbf91();
	}

	/*
		Name: show_model
		Namespace: namespace_7da27482
		Checksum: 0x9BB5DC3F
		Offset: 0xDF8
		Size: 0x3C
		Parameters: 0
		Flags: Linked
	*/
	function show_model()
	{
		var_228f64da show();
		self.var_43b94d19 = 1;
		function_c39fbf91();
	}

	/*
		Name: is_visible
		Namespace: namespace_7da27482
		Checksum: 0x652DBDB0
		Offset: 0xDE0
		Size: 0xA
		Parameters: 0
		Flags: Linked
	*/
	function is_visible()
	{
		return var_43b94d19;
	}

	/*
		Name: function_47cb6b19
		Namespace: namespace_7da27482
		Checksum: 0xB2FCD59B
		Offset: 0xDB8
		Size: 0x1A
		Parameters: 0
		Flags: Linked
	*/
	function function_47cb6b19()
	{
		return var_228f64da getentitynumber();
	}

	/*
		Name: function_98d70bef
		Namespace: namespace_7da27482
		Checksum: 0xF467960A
		Offset: 0xD50
		Size: 0x5C
		Parameters: 0
		Flags: Linked
	*/
	function function_98d70bef()
	{
		animation = var_228f64da getcurrentanimscriptedname();
		if(isdefined(var_228f64da) && isdefined(animation))
		{
			return var_228f64da getanimtime(animation);
		}
	}

	/*
		Name: set_xuid
		Namespace: namespace_7da27482
		Checksum: 0xA5DDF705
		Offset: 0xD28
		Size: 0x1A
		Parameters: 1
		Flags: Linked
	*/
	function set_xuid(xuid)
	{
		self._xuid = xuid;
	}

	/*
		Name: function_690c9509
		Namespace: namespace_7da27482
		Checksum: 0x4BE5E7E8
		Offset: 0xCF8
		Size: 0x22
		Parameters: 0
		Flags: Linked
	*/
	function function_690c9509()
	{
		return (isdefined(var_81bd1932) ? var_81bd1932 : var_f141235b);
	}

	/*
		Name: set_show_helmets
		Namespace: namespace_7da27482
		Checksum: 0x4BF9D923
		Offset: 0xCB8
		Size: 0x38
		Parameters: 1
		Flags: Linked
	*/
	function set_show_helmets(show_helmets)
	{
		if(var_609efd3e != show_helmets)
		{
			self.var_609efd3e = show_helmets;
			[[ self ]]->function_c1aab607();
		}
	}

	/*
		Name: function_e08bf4f2
		Namespace: namespace_7da27482
		Checksum: 0x15671C24
		Offset: 0xC90
		Size: 0x1A
		Parameters: 1
		Flags: Linked
	*/
	function function_e08bf4f2(var_db61785f)
	{
		self.var_81bd1932 = var_db61785f;
	}

	/*
		Name: function_79f89fb6
		Namespace: namespace_7da27482
		Checksum: 0xC79D9EFB
		Offset: 0xC68
		Size: 0x1A
		Parameters: 1
		Flags: Linked
	*/
	function function_79f89fb6(var_925f39ce)
	{
		self.var_9896541c = var_925f39ce;
	}

	/*
		Name: set_alt_render_mode
		Namespace: namespace_7da27482
		Checksum: 0x21EB1D5E
		Offset: 0xC40
		Size: 0x1A
		Parameters: 1
		Flags: Linked
	*/
	function set_alt_render_mode(alt_render_mode)
	{
		self.var_bf4feef5 = alt_render_mode;
	}

	/*
		Name: function_c0ccd9ea
		Namespace: namespace_7da27482
		Checksum: 0xA977AC9D
		Offset: 0xC18
		Size: 0x1A
		Parameters: 1
		Flags: Linked
	*/
	function function_c0ccd9ea(default_exploder)
	{
		self.var_266b2ff0 = default_exploder;
	}

	/*
		Name: function_1ec9448d
		Namespace: namespace_7da27482
		Checksum: 0x202C39F0
		Offset: 0xBD8
		Size: 0x36
		Parameters: 1
		Flags: Linked
	*/
	function function_1ec9448d(var_6ef2ca20)
	{
		if(var_6ef2ca20 != var_c31e86ed)
		{
			self.var_c31e86ed = var_6ef2ca20;
			self.var_b627749c = 1;
		}
	}

	/*
		Name: function_217b10ed
		Namespace: namespace_7da27482
		Checksum: 0x3D753D1
		Offset: 0xBC0
		Size: 0xA
		Parameters: 0
		Flags: Linked, Private
	*/
	function private function_217b10ed()
	{
		return var_228f64da;
	}

	/*
		Name: function_184a4d2e
		Namespace: namespace_7da27482
		Checksum: 0x8A5724A6
		Offset: 0xB20
		Size: 0x92
		Parameters: 1
		Flags: Linked
	*/
	function function_184a4d2e(callback_fn)
	{
		if(!isdefined(var_180f1c7d))
		{
			self.var_180f1c7d = [];
		}
		else if(!isarray(var_180f1c7d))
		{
			self.var_180f1c7d = array(var_180f1c7d);
		}
		if(!isinarray(var_180f1c7d, callback_fn))
		{
			self.var_180f1c7d[var_180f1c7d.size] = callback_fn;
		}
	}

	/*
		Name: function_7ed995de
		Namespace: namespace_7da27482
		Checksum: 0x79A44652
		Offset: 0xA40
		Size: 0xD4
		Parameters: 3
		Flags: Linked
	*/
	function function_7ed995de(local_client_num, character_model, alt_render_mode = 1)
	{
		/#
			/#
				assert(!isdefined(var_228f64da), "");
			#/
		#/
		self.var_f141235b = local_client_num;
		self.var_81bd1932 = local_client_num;
		self.var_bf4feef5 = alt_render_mode;
		self._target_name = character_model.targetname;
		self._origin = character_model.origin;
		self._angles = character_model.angles;
		function_91cd5499(character_model);
	}

	/*
		Name: function_91cd5499
		Namespace: namespace_7da27482
		Checksum: 0x332A98FD
		Offset: 0x868
		Size: 0x1CC
		Parameters: 3
		Flags: Linked, Private
	*/
	function private function_91cd5499(character_model, var_87606b20, var_584905de)
	{
		if(isdefined(var_228f64da))
		{
			self._origin = var_228f64da.origin;
			self._angles = var_228f64da.angles;
			[[ self ]]->function_39a68bf2(0);
			var_228f64da delete();
		}
		self.var_228f64da = character_model;
		var_228f64da.targetname = _target_name;
		var_228f64da.origin = _origin;
		var_228f64da.angles = _angles;
		var_228f64da sethighdetail((isdefined(var_87606b20) ? var_87606b20 : var_851003fe), (isdefined(var_584905de) ? var_584905de : var_bf4feef5));
		if(var_228f64da hasdobj(var_f141235b) && !var_228f64da hasanimtree())
		{
			var_228f64da useanimtree("all_player");
		}
		var_228f64da.var_90ff9782 = self;
		var_228f64da.var_463f8196 = 1;
		function_2a5421e3();
		function_c39fbf91();
	}

	/*
		Name: function_c39fbf91
		Namespace: namespace_7da27482
		Checksum: 0x3B3D465D
		Offset: 0x7E8
		Size: 0x78
		Parameters: 0
		Flags: Linked, Private
	*/
	function private function_c39fbf91()
	{
		foreach(callback in var_180f1c7d)
		{
			[[callback]](var_f141235b, self);
		}
	}

}

#namespace character_customization;

/*
	Name: __init__system__
	Namespace: character_customization
	Checksum: 0x2E74F733
	Offset: 0x310
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_customization", &__init__, undefined, undefined);
}

/*
	Name: function_6bca50af
	Namespace: character_customization
	Checksum: 0xE2AAD6EC
	Offset: 0x358
	Size: 0xB2
	Parameters: 5
	Flags: Linked
*/
function function_6bca50af(fn, character_index, outfit_index, var_e1daa8d9, mode)
{
	model = [[fn]](character_index, outfit_index, var_e1daa8d9, mode);
	if(!isdefined(model))
	{
		model = [[fn]](character_index, outfit_index, 0, mode);
		if(!isdefined(model))
		{
			model = [[fn]](character_index, 0, 0, mode);
		}
	}
	return (isdefined(model) ? model : #"tag_origin");
}

/*
	Name: function_6aee5a4e
	Namespace: character_customization
	Checksum: 0x8E4A206F
	Offset: 0x418
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_6aee5a4e(character)
{
	if(isdefined(level.var_6963abdb))
	{
		var_2d0192e5 = [[ character ]]->function_82e05d64();
		if(isdefined(var_2d0192e5) && isdefined(var_2d0192e5.xuid))
		{
			xuid = function_baf6cb99(var_2d0192e5.xuid);
			return level.var_6963abdb[xuid];
		}
		if(isdefined(character._xuid))
		{
			return level.var_6963abdb[character._xuid];
		}
	}
	return 0;
}

/*
	Name: function_bee62aa1
	Namespace: character_customization
	Checksum: 0x4B48330
	Offset: 0x4D0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_bee62aa1(character)
{
	if(isdefined(level.var_6963abdb))
	{
		var_2d0192e5 = [[ character ]]->function_82e05d64();
		if(isdefined(var_2d0192e5) && isdefined(var_2d0192e5.xuid))
		{
			xuid = function_baf6cb99(var_2d0192e5.xuid);
			level.var_6963abdb[xuid] = 0;
		}
		if(isdefined(character._xuid))
		{
			level.var_6963abdb[character._xuid] = 0;
		}
	}
}

/*
	Name: __init__
	Namespace: character_customization
	Checksum: 0x1210246A
	Offset: 0x5998
	Size: 0x1CA
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.extra_cam_render_current_hero_headshot_func_callback = &process_current_hero_headshot_extracam_request;
	level.extra_cam_render_head_preview_func_callback = &process_head_preview_extracam_request;
	level.var_dda8e1d8 = &function_1c0ddf49;
	level.extra_cam_render_character_head_item_func_callback = &process_character_head_item_extracam_request;
	level.extra_cam_render_gender_func_callback = &process_gender_extracam_request;
	level.model_type_bones = [#"outfit_torso":"", #"outfit_legs":"", #"outfit_headgear":"", #"outfit_head":"", #"head":""];
	if(!isdefined(level.liveccdata))
	{
		level.liveccdata = [];
	}
	if(!isdefined(level.custom_characters))
	{
		level.custom_characters = [];
	}
	if(!isdefined(level.extra_cam_hero_data))
	{
		level.extra_cam_hero_data = [];
	}
	if(!isdefined(level.extra_cam_headshot_hero_data))
	{
		level.extra_cam_headshot_hero_data = [];
	}
	if(!isdefined(level.extra_cam_head_preview_data))
	{
		level.extra_cam_head_preview_data = [];
	}
	if(!isdefined(level.extra_cam_gender_preview_data))
	{
		level.extra_cam_gender_preview_data = [];
	}
	level.charactercustomizationsetup = &localclientconnect;
	level.var_6e23b0fc = [];
}

/*
	Name: localclientconnect
	Namespace: character_customization
	Checksum: 0x7F257ED4
	Offset: 0x5B70
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function localclientconnect(localclientnum)
{
	level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum, "updateHero");
	level.staticccdata = setup_static_character_customization_target(localclientnum);
}

/*
	Name: function_cb64c6d0
	Namespace: character_customization
	Checksum: 0x8FBC87B7
	Offset: 0x5BD8
	Size: 0xDE
	Parameters: 3
	Flags: Linked, Private
*/
function private function_cb64c6d0(model_name, lod, mip)
{
	if(!isdefined(level.var_6e23b0fc[model_name]))
	{
		level.var_6e23b0fc[model_name] = array();
	}
	if(!isdefined(level.var_6e23b0fc[model_name][lod]))
	{
		level.var_6e23b0fc[model_name][lod] = array();
	}
	if(!isdefined(level.var_6e23b0fc[model_name][lod][mip]))
	{
		level.var_6e23b0fc[model_name][lod][mip] = 0;
	}
}

/*
	Name: function_221a94ac
	Namespace: character_customization
	Checksum: 0x7AB960BF
	Offset: 0x5CC0
	Size: 0xA4
	Parameters: 3
	Flags: Linked
*/
function function_221a94ac(model_name, lod, mip)
{
	if(!isdefined(model_name))
	{
		return;
	}
	function_cb64c6d0(model_name, lod, mip);
	level.var_6e23b0fc[model_name][lod][mip]++;
	if(level.var_6e23b0fc[model_name][lod][mip] == 1)
	{
		forcestreamxmodel(model_name, lod, mip);
	}
}

/*
	Name: function_c358189
	Namespace: character_customization
	Checksum: 0x2248B81
	Offset: 0x5D70
	Size: 0x9A
	Parameters: 3
	Flags: Linked, Private
*/
function private function_c358189(model_name, lod, mip)
{
	if(!isdefined(model_name))
	{
		return 1;
	}
	function_cb64c6d0(model_name, lod, mip);
	if(level.var_6e23b0fc[model_name][lod][mip] == 0)
	{
		function_221a94ac(model_name);
	}
	return forcestreamxmodel(model_name, lod, mip);
}

/*
	Name: function_247f6628
	Namespace: character_customization
	Checksum: 0xA596B7D9
	Offset: 0x5E18
	Size: 0x144
	Parameters: 3
	Flags: Linked
*/
function function_247f6628(model_name, lod, mip)
{
	if(!isdefined(model_name))
	{
		return;
	}
	function_cb64c6d0(model_name, lod, mip);
	level.var_6e23b0fc[model_name][lod][mip]--;
	if(level.var_6e23b0fc[model_name][lod][mip] == 0)
	{
		stopforcestreamingxmodel(model_name);
		array::pop(level.var_6e23b0fc[model_name][lod], mip);
		if(level.var_6e23b0fc[model_name][lod].size == 0)
		{
			array::pop(level.var_6e23b0fc[model_name], lod);
			if(level.var_6e23b0fc[model_name].size == 0)
			{
				array::pop(level.var_6e23b0fc, model_name);
			}
		}
	}
}

/*
	Name: function_dd295310
	Namespace: character_customization
	Checksum: 0xCC6AD13F
	Offset: 0x5F68
	Size: 0x100
	Parameters: 3
	Flags: Linked
*/
function function_dd295310(charactermodel, localclientnum, alt_render_mode = 1)
{
	if(!isdefined(charactermodel))
	{
		return undefined;
	}
	if(!isdefined(level.custom_characters[localclientnum]))
	{
		level.custom_characters[localclientnum] = [];
	}
	if(isdefined(level.custom_characters[localclientnum][charactermodel.targetname]))
	{
		return level.custom_characters[localclientnum][charactermodel.targetname];
	}
	var_c372a4ea = new class_7da27482();
	[[ var_c372a4ea ]]->function_7ed995de(localclientnum, charactermodel, alt_render_mode);
	level.custom_characters[localclientnum][charactermodel.targetname] = var_c372a4ea;
	return var_c372a4ea;
}

/*
	Name: function_aa5382ed
	Namespace: character_customization
	Checksum: 0x8264C61F
	Offset: 0x6070
	Size: 0x188
	Parameters: 3
	Flags: Linked
*/
function function_aa5382ed(customization1, customization2, var_f91927a1 = 1)
{
	if(isdefined(customization1) != isdefined(customization2))
	{
		return true;
	}
	if(!isdefined(customization1))
	{
		return false;
	}
	if(var_f91927a1 && customization1.xuid !== customization2.xuid)
	{
		return true;
	}
	if(customization1.charactermode != customization2.charactermode)
	{
		return true;
	}
	if(customization1.charactertype != customization2.charactertype)
	{
		return true;
	}
	if(customization1.characterhead != customization2.characterhead)
	{
		return true;
	}
	if(customization1.outfit != customization2.outfit)
	{
		return true;
	}
	if(customization1.var_cfe86a3e != customization2.var_cfe86a3e)
	{
		return true;
	}
	for(i = 0; i < customization1.var_5f383817.size; i++)
	{
		if(customization1.var_5f383817[i] != customization2.var_5f383817[i])
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_7474681d
	Namespace: character_customization
	Checksum: 0x563FFD9B
	Offset: 0x6200
	Size: 0x174
	Parameters: 3
	Flags: Linked
*/
function function_7474681d(local_client_num, session_mode, character_index)
{
	outfit_index = function_9ec573f1(local_client_num, session_mode, character_index);
	var_17b172ca = function_76fbb09e(local_client_num, session_mode, character_index);
	var_809a2fb0 = [];
	for(itemtype = 0; itemtype < 8; itemtype++)
	{
		var_9b90e15d = (itemtype == 7 ? var_17b172ca : outfit_index);
		var_809a2fb0[itemtype] = function_bd9a67ae(local_client_num, session_mode, character_index, var_9b90e15d, itemtype);
	}
	return {#hash_5f383817:var_809a2fb0, #hash_665ae20e:var_17b172ca, #outfit:outfit_index, #hash_e1c69280:getequippedheadindexforhero(local_client_num, session_mode), #charactertype:character_index, #charactermode:session_mode};
}

/*
	Name: function_3f5625f1
	Namespace: character_customization
	Checksum: 0x21B737EA
	Offset: 0x6380
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_3f5625f1(mode, character_index = 1)
{
	var_809a2fb0 = [];
	for(itemtype = 0; itemtype < 8; itemtype++)
	{
		var_809a2fb0[itemtype] = 0;
	}
	return {#hash_5f383817:var_809a2fb0, #hash_665ae20e:0, #outfit:0, #hash_e1c69280:0, #charactertype:character_index, #charactermode:mode};
}

/*
	Name: play_intro_and_animation
	Namespace: character_customization
	Checksum: 0x47DA341D
	Offset: 0x6458
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function play_intro_and_animation(origin, angles, intro_anim_name, anim_name, b_keep_link)
{
	self notify("354f0097cb99821b");
	self endon("354f0097cb99821b");
	if(isdefined(intro_anim_name))
	{
		self animation::play(intro_anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
	}
	if(isdefined(self))
	{
		self animation::play(anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
	}
}

/*
	Name: setup_live_character_customization_target
	Namespace: character_customization
	Checksum: 0x59B86410
	Offset: 0x6518
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function setup_live_character_customization_target(localclientnum, notifyname)
{
	characterent = getent(localclientnum, "character_customization", "targetname");
	if(isdefined(characterent))
	{
		var_d0b01271 = function_dd295310(characterent, localclientnum, 1);
		[[ var_d0b01271 ]]->function_c0ccd9ea("char_customization");
		level thread updateeventthread(localclientnum, var_d0b01271, notifyname);
		return var_d0b01271;
	}
	return undefined;
}

/*
	Name: update_locked_shader
	Namespace: character_customization
	Checksum: 0xD237A568
	Offset: 0x65D8
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function update_locked_shader(localclientnum, params)
{
	if(isdefined(params.isitemunlocked) && params.isitemunlocked != 1)
	{
		enablefrontendlockedweaponoverlay(localclientnum, 1);
	}
	else
	{
		enablefrontendlockedweaponoverlay(localclientnum, 0);
	}
}

/*
	Name: function_bcc8bdf4
	Namespace: character_customization
	Checksum: 0x1C0E1C7C
	Offset: 0x6658
	Size: 0x3E
	Parameters: 4
	Flags: Linked
*/
function function_bcc8bdf4(localclientnum, var_d0b01271, waitresult, params)
{
	params.anim_name = [[ var_d0b01271 ]]->function_8144231c();
}

/*
	Name: updateeventthread
	Namespace: character_customization
	Checksum: 0x315D426D
	Offset: 0x66A0
	Size: 0xC16
	Parameters: 4
	Flags: Linked
*/
function updateeventthread(localclientnum, var_d0b01271, notifyname, var_1d7f1597 = &function_bcc8bdf4)
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(notifyname + localclientnum);
		switch(waitresult.event_name)
		{
			case "update_lcn":
			{
				[[ var_d0b01271 ]]->function_e08bf4f2(waitresult.local_client_num);
				break;
			}
			case "update_locked":
			{
				[[ var_d0b01271 ]]->function_7792df22(waitresult.locked);
				break;
			}
			case "refresh":
			{
				[[ var_d0b01271 ]]->function_e08bf4f2(waitresult.local_client_num);
				[[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
				[[ var_d0b01271 ]]->function_225b6e07();
				[[ var_d0b01271 ]]->function_77e3be08();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "refresh_anim":
			{
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				params.var_99a89f83 = 1;
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "changehero":
			{
				[[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
				[[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
				[[ var_d0b01271 ]]->function_77e3be08();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "changegender":
			{
				bodyindex = getfirstheroofgender(waitresult.gender, waitresult.mode);
				headindex = getfirstheadofgender(waitresult.gender, waitresult.mode);
				[[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
				[[ var_d0b01271 ]]->set_character_index(bodyindex);
				[[ var_d0b01271 ]]->function_77e3be08();
				[[ var_d0b01271 ]]->set_character_head(headindex);
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "changehead":
			{
				[[ var_d0b01271 ]]->function_617a9ce4(waitresult.mode);
				[[ var_d0b01271 ]]->set_character_head(waitresult.head);
				params = {};
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "resetcharacter":
			{
				[[ var_d0b01271 ]]->function_77e3be08();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "changeoutfit":
			{
				[[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
				[[ var_d0b01271 ]]->function_10b0cbea();
				[[ var_d0b01271 ]]->function_59d1302f();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "hash_4d0b69451140c364":
			{
				[[ var_d0b01271 ]]->function_72be01b9();
				[[ var_d0b01271 ]]->function_158505aa(waitresult.outfit_index);
				[[ var_d0b01271 ]]->function_59d1302f();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "hash_51c6c251729c60bd":
			{
				[[ var_d0b01271 ]]->function_8701f84e(waitresult.item_index, waitresult.item_type);
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "hash_220546ce38834f4c":
			{
				[[ var_d0b01271 ]]->function_ac9cc79d(waitresult.item_type);
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "updateface":
			{
				[[ var_d0b01271 ]]->function_617a9ce4(waitresult.mode);
				thread [[ var_d0b01271 ]]->function_81d84c71();
				break;
			}
			case "previewshop":
			case "previewshopface":
			{
				[[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
				[[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
				[[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
				[[ var_d0b01271 ]]->function_158505aa(waitresult.outfit_index);
				var_5f383817 = strtok(waitresult.var_5f383817, ";");
				foreach(type, item in var_5f383817)
				{
					[[ var_d0b01271 ]]->function_9146bf81(int(item), type);
				}
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(waitresult.event_name == "previewShopFace")
				{
					params.align_struct = struct::get(#"hash_1b6b643ea423735b");
				}
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "loadpreset":
			{
				var_5f383817 = strtok(waitresult.presets, ";");
				foreach(type, item in var_5f383817)
				{
					if(type != 7 && type != 1)
					{
						[[ var_d0b01271 ]]->function_9146bf81(int(item), type);
					}
				}
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "previewshopgesture":
			{
				[[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
				[[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
				[[ var_d0b01271 ]]->function_22039feb();
				params = {};
				[[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
				if(isdefined(params.var_c76f3e47) && params.var_c76f3e47)
				{
					[[ var_d0b01271 ]]->function_27945cb8(1);
				}
				[[ var_d0b01271 ]]->update(params);
				break;
			}
			case "previewgesture":
			{
				thread [[ var_d0b01271 ]]->function_b204f6e3(waitresult.var_cc478c99, waitresult.var_4a759822, waitresult.var_1b1e990c, waitresult.var_e14a92d8);
				break;
			}
			case "stopgesture":
			{
				var_d0b01271 notify(#"cancel_gesture");
				break;
			}
			case "hide":
			{
				[[ var_d0b01271 ]]->hide_model();
				break;
			}
			case "show":
			{
				[[ var_d0b01271 ]]->show_model();
				break;
			}
		}
	}
}

/*
	Name: rotation_thread_spawner
	Namespace: character_customization
	Checksum: 0x947788E3
	Offset: 0x72C0
	Size: 0x9A
	Parameters: 3
	Flags: Linked
*/
function rotation_thread_spawner(localclientnum, var_d0b01271, endonevent)
{
	if(!isdefined(endonevent))
	{
		return;
	}
	baseangles = [[ var_d0b01271 ]]->function_217b10ed().angles;
	level update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent);
	level waittill(endonevent);
	if(![[ var_d0b01271 ]]->function_4a271da1())
	{
		[[ var_d0b01271 ]]->function_217b10ed().angles = baseangles;
	}
}

/*
	Name: update_model_rotation_for_right_stick
	Namespace: character_customization
	Checksum: 0xF72BD59
	Offset: 0x7368
	Size: 0x1F0
	Parameters: 3
	Flags: Linked, Private
*/
function private update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent)
{
	level endon(endonevent);
	while(true)
	{
		data_lcn = [[ var_d0b01271 ]]->function_690c9509();
		if(localclientnum == data_lcn && localclientactive(data_lcn) && !([[ var_d0b01271 ]]->function_4a271da1()))
		{
			model = [[ var_d0b01271 ]]->function_217b10ed();
			if(isdefined(model))
			{
				pos = getcontrollerposition(data_lcn);
				change = (isdefined(pos[#"rightstick"]) ? pos[#"rightstick"][0] : pos[#"look"][0]);
				if(ispc())
				{
					pos = getxcammousecontrol(data_lcn);
					change = change - pos[#"yaw"];
				}
				if(abs(change) > 0.0001)
				{
					model.angles = (model.angles[0], absangleclamp360(model.angles[1] + (change * 3)), model.angles[2]);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: setup_static_character_customization_target
	Namespace: character_customization
	Checksum: 0x3780C680
	Offset: 0x7560
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function setup_static_character_customization_target(localclientnum)
{
	characterent = getent(localclientnum, "character_customization_staging", "targetname");
	level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", #"pb_cac_main_lobby_idle");
	level.extra_cam_headshot_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_vs_screen_idle_1");
	level.extra_cam_head_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_main_lobby_idle");
	level.extra_cam_gender_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_main_lobby_idle");
	if(isdefined(characterent))
	{
		var_d0b01271 = function_dd295310(characterent, localclientnum);
		level thread update_character_extracam(localclientnum, var_d0b01271);
		return var_d0b01271;
	}
	return undefined;
}

/*
	Name: setup_character_extracam_struct
	Namespace: character_customization
	Checksum: 0xF290BE5A
	Offset: 0x76F8
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function setup_character_extracam_struct(xcam, subxcam, model_animation)
{
	newstruct = {#anim_name:model_animation, #subxcam:subxcam, #xcam:xcam};
	return newstruct;
}

/*
	Name: setup_character_extracam_settings
	Namespace: character_customization
	Checksum: 0xEE714C07
	Offset: 0x7768
	Size: 0x3F8
	Parameters: 3
	Flags: Linked
*/
function setup_character_extracam_settings(localclientnum, var_d0b01271, extracam_data_struct)
{
	/#
		assert(isdefined(extracam_data_struct.jobindex));
	#/
	if(!isdefined(level.camera_ents))
	{
		level.camera_ents = [];
	}
	initializedextracam = 0;
	camera_ent = (isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined);
	if(!isdefined(camera_ent))
	{
		initializedextracam = 1;
		multi_extracam::extracam_init_index(localclientnum, "character_staging_extracam" + (extracam_data_struct.extracamindex + 1), extracam_data_struct.extracamindex);
		camera_ent = level.camera_ents[localclientnum][extracam_data_struct.extracamindex];
	}
	/#
		assert(isdefined(camera_ent));
	#/
	camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam);
	params = {#hide_helmet:isdefined(extracam_data_struct.hidehelmet) && extracam_data_struct.hidehelmet, #sessionmode:extracam_data_struct.sessionmode, #extracam_data:extracam_data_struct, #anim_name:extracam_data_struct.anim_name};
	[[ var_d0b01271 ]]->function_79f89fb6(extracam_data_struct.sessionmode === 2);
	[[ var_d0b01271 ]]->set_alt_render_mode(0);
	[[ var_d0b01271 ]]->set_character_mode(extracam_data_struct.sessionmode);
	[[ var_d0b01271 ]]->set_character_index(extracam_data_struct.characterindex);
	if(isdefined(extracam_data_struct.isdefaulthero) && extracam_data_struct.isdefaulthero || (isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender))
	{
		[[ var_d0b01271 ]]->function_22039feb();
	}
	else
	{
		[[ var_d0b01271 ]]->function_77e3be08();
		if(isdefined(extracam_data_struct.var_d3927004) && isdefined(extracam_data_struct.var_eb3dfef8))
		{
			[[ var_d0b01271 ]]->function_8701f84e(extracam_data_struct.var_eb3dfef8, extracam_data_struct.var_d3927004);
		}
		if(isdefined(extracam_data_struct.useheadindex))
		{
			[[ var_d0b01271 ]]->set_character_head(extracam_data_struct.useheadindex);
		}
	}
	[[ var_d0b01271 ]]->update(params);
	while(![[ var_d0b01271 ]]->function_ca932c8())
	{
		waitframe(1);
	}
	if(isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender)
	{
		wait(0.5);
	}
	else
	{
		wait(0.1);
	}
	setextracamrenderready(extracam_data_struct.jobindex);
	extracam_data_struct.jobindex = undefined;
	level waittill((("render_complete_" + localclientnum) + "_") + extracam_data_struct.extracamindex);
	if(initializedextracam)
	{
		multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
	}
	[[ var_d0b01271 ]]->function_79f89fb6(0);
}

/*
	Name: update_character_extracam
	Namespace: character_customization
	Checksum: 0x190334E
	Offset: 0x7B68
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function update_character_extracam(localclientnum, var_d0b01271)
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill("process_character_extracam" + localclientnum);
		setup_character_extracam_settings(localclientnum, var_d0b01271, waitresult.extracam_data_struct);
	}
}

/*
	Name: process_current_hero_headshot_extracam_request
	Namespace: character_customization
	Checksum: 0xA9664B3E
	Offset: 0x7BF0
	Size: 0xF6
	Parameters: 6
	Flags: Linked
*/
function process_current_hero_headshot_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero)
{
	level.extra_cam_headshot_hero_data[localclientnum].jobindex = jobindex;
	level.extra_cam_headshot_hero_data[localclientnum].extracamindex = extracamindex;
	level.extra_cam_headshot_hero_data[localclientnum].characterindex = characterindex;
	level.extra_cam_headshot_hero_data[localclientnum].isdefaulthero = isdefaulthero;
	level.extra_cam_headshot_hero_data[localclientnum].sessionmode = sessionmode;
	level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_headshot_hero_data[localclientnum]});
}

/*
	Name: process_head_preview_extracam_request
	Namespace: character_customization
	Checksum: 0xE446738E
	Offset: 0x7CF0
	Size: 0x10E
	Parameters: 5
	Flags: Linked
*/
function process_head_preview_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex)
{
	level.extra_cam_head_preview_data[localclientnum].jobindex = jobindex;
	level.extra_cam_head_preview_data[localclientnum].extracamindex = extracamindex;
	level.extra_cam_head_preview_data[localclientnum].useheadindex = headindex;
	level.extra_cam_head_preview_data[localclientnum].characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
	level.extra_cam_head_preview_data[localclientnum].sessionmode = sessionmode;
	level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_outfit_preview_data[localclientnum]});
}

/*
	Name: function_1c0ddf49
	Namespace: character_customization
	Checksum: 0xD0ABDA5B
	Offset: 0x7E08
	Size: 0x1AE
	Parameters: 9
	Flags: Linked
*/
function function_1c0ddf49(localclientnum, jobindex, extracamindex, sessionmode, characterindex, outfitindex, itemtype, itemindex, defaultimagerender)
{
	extracam_data = undefined;
	if(defaultimagerender)
	{
		extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", #"pb_cac_vs_screen_idle_1");
		extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
	}
	else
	{
		extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", #"pb_cac_vs_screen_idle_1");
	}
	extracam_data.jobindex = jobindex;
	extracam_data.extracamindex = extracamindex;
	extracam_data.sessionmode = sessionmode;
	extracam_data.characterindex = characterindex;
	extracam_data.outfitindex = outfitindex;
	extracam_data.var_d3927004 = itemtype;
	extracam_data.var_eb3dfef8 = itemindex;
	extracam_data.defaultimagerender = defaultimagerender;
	level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

/*
	Name: process_character_head_item_extracam_request
	Namespace: character_customization
	Checksum: 0xFAA7FCC
	Offset: 0x7FC0
	Size: 0x176
	Parameters: 6
	Flags: Linked
*/
function process_character_head_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultimagerender)
{
	extracam_data = undefined;
	if(defaultimagerender)
	{
		extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "cam_head", #"pb_cac_vs_screen_idle_1");
	}
	else
	{
		extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_head", #"pb_cac_vs_screen_idle_1");
	}
	extracam_data.jobindex = jobindex;
	extracam_data.extracamindex = extracamindex;
	extracam_data.sessionmode = sessionmode;
	extracam_data.useheadindex = headindex;
	extracam_data.hidehelmet = 1;
	extracam_data.defaultimagerender = defaultimagerender;
	extracam_data.characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
	level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

/*
	Name: process_gender_extracam_request
	Namespace: character_customization
	Checksum: 0x1D68A053
	Offset: 0x8140
	Size: 0x10E
	Parameters: 5
	Flags: Linked
*/
function process_gender_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, gender)
{
	level.extra_cam_gender_preview_data[localclientnum].jobindex = jobindex;
	level.extra_cam_gender_preview_data[localclientnum].extracamindex = extracamindex;
	level.extra_cam_gender_preview_data[localclientnum].useheadindex = getfirstheadofgender(gender, sessionmode);
	level.extra_cam_gender_preview_data[localclientnum].characterindex = getfirstheroofgender(gender, sessionmode);
	level.extra_cam_gender_preview_data[localclientnum].sessionmode = sessionmode;
	level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_gender_preview_data[localclientnum]});
}

