// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_common_fixup.csc;
#using script_731df012f3a3c2fc;

#namespace namespace_e27c7374;

/*
	Name: function_45a212c0
	Namespace: namespace_e27c7374
	Checksum: 0xB134C494
	Offset: 0x78
	Size: 0x6B14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_45a212c0()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	if(!(isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
	{
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyasylum")) && getgametypesetting(#"wzenablewallbuyasylum")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27a77e458cb2223e", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuydiner")) && getgametypesetting(#"wzenablewallbuydiner")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7fe452ac99dcb25f", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuycemetary")) && getgametypesetting(#"wzenablewallbuycemetary")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2572e1a193175b4d", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyfarm")) && getgametypesetting(#"wzenablewallbuyfarm")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2bb44d78cfdc661", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuynuketown")) && getgametypesetting(#"wzenablewallbuynuketown")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7f50125ebbc15534", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_f04393e2e028c01")) && getgametypesetting(#"hash_f04393e2e028c01")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_5d334f942754156e", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_64aba694bd70856c")) && getgametypesetting(#"hash_64aba694bd70856c")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_10db7f8ca1621554", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuylighthouse")) && getgametypesetting(#"wzenablewallbuylighthouse")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27d464e9703672a1", #"hash_5ffca3f1385154e6");
		}
	}
	if(maxteamplayers == 1)
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2011eafeff274fc8");
	}
	if(!(isdefined(getgametypesetting(#"wzsnowballsenabled")) && getgametypesetting(#"wzsnowballsenabled")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"wz_snowball", #"");
	}
	if(!(isdefined(getgametypesetting(#"hash_33d1ac5e99fb0584")) && getgametypesetting(#"hash_33d1ac5e99fb0584")) && (!(isdefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) && getgametypesetting(#"hash_3e2d2cf6b1cc6c68"))))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"wz_waterballoon", #"");
	}
	if(isdefined(getgametypesetting(#"hash_230e67d5ddfb2c06")) && getgametypesetting(#"hash_230e67d5ddfb2c06"))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_32c805d452b5f91b", #"hash_1d9cd69d5981d2c7");
	}
	if(isdefined(getgametypesetting(#"hash_661ee23f114191c1")) && getgametypesetting(#"hash_661ee23f114191c1"))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_32c805d452b5f91b", #"hash_1d9cd69d5981d2c7");
	}
	if(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1b31f48b11bd3801", #"hash_7f6ccc550b17457f");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"shotgun_fullauto_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"shotgun_pump_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"shotgun_semiauto_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"pistol_fullauto_t8_item", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"pistol_burst_t8_item", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"pistol_revolver_t8_item", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"pistol_standard_t8_item", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_accurate_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_standard_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_fastburst_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_fastfire_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_capacity_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"smg_folding_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_46dd75a1a3f70780", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_182fdef2ad243e20", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_212b01feaa916a00", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1abfcce0e9955057", #"grapple_wz_item");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_ff50c93155e445f", #"hash_394e9478cf4f8d9d");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_799f875c8f064a83", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_3d82033b67579745", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_750be705a5c4201e", #"hash_735d22a674b7f8c0");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_332dd2a4956f495f", #"hash_61d6c77ca964fa5b");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1a79c2970ba8bf79", #"hash_61d6c77ca964fa5b");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2011eafeff274fc8", #"hash_61d6c77ca964fa5b");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1b898a6e72d622d8", #"hash_61d6c77ca964fa5b");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_5d35f83e51965781", #"hash_394e9478cf4f8d9d");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_35f5430256d9c158", #"hash_394e9478cf4f8d9d");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"acog_wz_item", #"hash_394e9478cf4f8d9d");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"sniperscope_wz_item", #"hash_394e9478cf4f8d9d");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"laser_sight_wz_item", #"hash_394e9478cf4f8d9d");
	}
	customgame = gamemodeismode(1) || gamemodeismode(7);
	wz_common_fixup::item_remover(var_a12b4736, undefined, #"hash_5e9c3f9821e1ee0a");
	if(!(isdefined(getgametypesetting(#"wzenablespraycans")) && getgametypesetting(#"wzenablespraycans")) || customgame)
	{
		wz_common_fixup::item_remover(var_87d0eef8, undefined, #"hash_5e9c3f9821e1ee0a");
	}
	else
	{
		maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
		if(maxteamplayers == 1)
		{
			wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_60ffe3aa992db93a", #"hash_b87a51e99e52b58");
			wz_common_fixup::function_149cbc84(var_f8a4c541, undefined, #"hash_3aab463fff2b617", #"hash_25409de8d2edefb7");
		}
	}
	if(!(isdefined(getgametypesetting(#"wzenablesecretsanta")) && getgametypesetting(#"wzenablesecretsanta")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"melee_secretsanta_t8_item", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenableslaybell")) && getgametypesetting(#"wzenableslaybell")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"melee_slaybell_t8_item", #"");
	}
	if(isdefined(getgametypesetting(#"wzenablecontrabandstash")) && getgametypesetting(#"wzenablecontrabandstash"))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_13ba73311ab5250f", #"hash_3c9e4970b3140181");
	}
	if(!(isdefined(getgametypesetting(#"wzenableoperatorweapons")) && getgametypesetting(#"wzenableoperatorweapons")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_76aecc693bee59bf");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1a3febc9dd2ff956");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_285b16162518c948");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_44d9fdaac46214a4");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_48e9d48bfecf8dd");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_166b2f213a373dba");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7017e5a5441c4da2");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_69123f639841ddc7");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_40103f4d2f71a6a7");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_695778cec905e59b");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7be8f876858deae3");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6728f5fbe7b9eb60");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_74cbb6df24a0f9bb");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"wzenablemaddox")) && getgametypesetting(#"wzenablemaddox")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_76aecc693bee59bf");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevapr")) && getgametypesetting(#"wzenablevapr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1a3febc9dd2ff956");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswordfish")) && getgametypesetting(#"wzenableswordfish")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_285b16162518c948");
		}
		if(!(isdefined(getgametypesetting(#"wzenableabr")) && getgametypesetting(#"wzenableabr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_44d9fdaac46214a4");
		}
		if(!(isdefined(getgametypesetting(#"wzenableauger")) && getgametypesetting(#"wzenableauger")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_48e9d48bfecf8dd");
		}
		if(!(isdefined(getgametypesetting(#"wzenableoutlaw")) && getgametypesetting(#"wzenableoutlaw")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_166b2f213a373dba");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekoshka")) && getgametypesetting(#"wzenablekoshka")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7017e5a5441c4da2");
		}
		if(!(isdefined(getgametypesetting(#"wzenablehades")) && getgametypesetting(#"wzenablehades")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_69123f639841ddc7");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletitan")) && getgametypesetting(#"wzenabletitan")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_40103f4d2f71a6a7");
		}
		if(!(isdefined(getgametypesetting(#"wzenablegks")) && getgametypesetting(#"wzenablegks")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_695778cec905e59b");
		}
		if(!(isdefined(getgametypesetting(#"wzenablespitfire")) && getgametypesetting(#"wzenablespitfire")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7be8f876858deae3");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemozu")) && getgametypesetting(#"wzenablemozu")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6728f5fbe7b9eb60");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevendetta")) && getgametypesetting(#"wzenablevendetta")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_74cbb6df24a0f9bb");
		}
	}
	if(!(isdefined(getgametypesetting(#"hash_5c6371ef701d7485")) && getgametypesetting(#"hash_5c6371ef701d7485")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_250876d81f2e6f6e");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_9dcbf9df7b19434");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6857c7a83fc6cdb1");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2799bb4fa8f20048");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_e0a40edfec418ef");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_ac66bb9a3a19d91");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_691f420597727d56");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_321c0010d0c7fdc5");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_363ed03cee79d627");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_64f996475acdd244");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7a53240a3664fe64");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_52d37104fb5e6eb5");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1b69ed326eaa32c4");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_59da79c0dcf9cf76");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_21779574e3841392");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_52083f0c0759df13");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_48db4f35da313bd1");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7dced4169cb1c6bd");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6fbf66e753d55ddd");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2a4214db930e08a7");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1efebec8697e5720");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1caa1516c9ea66af");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6d33368b7b126df8");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"wzenablestrife")) && getgametypesetting(#"wzenablestrife")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_32834da10f1048b0");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemozu")) && getgametypesetting(#"wzenablemozu")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_250876d81f2e6f6e");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerk7")) && getgametypesetting(#"wzenablerk7")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_499748ba05372c7");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekap45")) && getgametypesetting(#"wzenablekap45")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_40ced73804c1be81");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemog12")) && getgametypesetting(#"wzenablemog12")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_524268075ef65e1e");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesg12")) && getgametypesetting(#"wzenablesg12")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1bfc7320c1335797");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerampage")) && getgametypesetting(#"wzenablerampage")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_31c3a0cc51a512d2");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesaug")) && getgametypesetting(#"wzenablesaug")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_9dcbf9df7b19434");
		}
		if(!(isdefined(getgametypesetting(#"wzenablespitfire")) && getgametypesetting(#"wzenablespitfire")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1bd3cb5b4becaad9");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemx9")) && getgametypesetting(#"wzenablemx9")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2799bb4fa8f20048");
		}
		if(!(isdefined(getgametypesetting(#"wzenablecordite")) && getgametypesetting(#"wzenablecordite")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_e0a40edfec418ef");
		}
		if(!(isdefined(getgametypesetting(#"wzenablegks")) && getgametypesetting(#"wzenablegks")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6857c7a83fc6cdb1");
		}
		if(!(isdefined(getgametypesetting(#"wzenabledaemon")) && getgametypesetting(#"wzenabledaemon")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_ac66bb9a3a19d91");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswitchblade")) && getgametypesetting(#"wzenableswitchblade")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_691f420597727d56");
		}
		if(!(isdefined(getgametypesetting(#"wzenableicr")) && getgametypesetting(#"wzenableicr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_321c0010d0c7fdc5");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekn")) && getgametypesetting(#"wzenablekn")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_363ed03cee79d627");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswat")) && getgametypesetting(#"wzenableswat")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_64f996475acdd244");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerampart")) && getgametypesetting(#"wzenablerampart")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7a53240a3664fe64");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemaddox")) && getgametypesetting(#"wzenablemaddox")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_52d37104fb5e6eb5");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevapr")) && getgametypesetting(#"wzenablevapr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1b69ed326eaa32c4");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswordfish")) && getgametypesetting(#"wzenableswordfish")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_59da79c0dcf9cf76");
		}
		if(!(isdefined(getgametypesetting(#"wzenableabr")) && getgametypesetting(#"wzenableabr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_21779574e3841392");
		}
		if(!(isdefined(getgametypesetting(#"wzenableauger")) && getgametypesetting(#"wzenableauger")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_52083f0c0759df13");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevendetta")) && getgametypesetting(#"wzenablevendetta")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_48db4f35da313bd1");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletitan")) && getgametypesetting(#"wzenabletitan")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7dced4169cb1c6bd");
		}
		if(!(isdefined(getgametypesetting(#"wzenablehades")) && getgametypesetting(#"wzenablehades")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6fbf66e753d55ddd");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevkm")) && getgametypesetting(#"wzenablevkm")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2a4214db930e08a7");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekoshka")) && getgametypesetting(#"wzenablekoshka")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1efebec8697e5720");
		}
		if(!(isdefined(getgametypesetting(#"wzenablepaladin")) && getgametypesetting(#"wzenablepaladin")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1caa1516c9ea66af");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesdm")) && getgametypesetting(#"wzenablesdm")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		}
		if(!(isdefined(getgametypesetting(#"wzenableoutlaw")) && getgametypesetting(#"wzenableoutlaw")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6d33368b7b126df8");
		}
	}
	if(!(isdefined(getgametypesetting(#"wzenablewarmachine")) && getgametypesetting(#"wzenablewarmachine")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"warmachine_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablepurifier")) && getgametypesetting(#"wzenablepurifier")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"flamethrower_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableannihilator")) && getgametypesetting(#"wzenableannihilator")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6c0eed50f4c26acb");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesparrow")) && getgametypesetting(#"wzenablesparrow")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sparrow_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableraygun")) && getgametypesetting(#"wzenableraygun")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7313f9c02b023a53");
	}
	if(!(isdefined(getgametypesetting(#"wzenableraygunmark2")) && getgametypesetting(#"wzenableraygunmark2")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_237d7fbe80a5dd72");
	}
	if(!(isdefined(getgametypesetting(#"wzenableblundergat")) && getgametypesetting(#"wzenableblundergat")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"blundergat_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecoinbag")) && getgametypesetting(#"wzenablecoinbag")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_coinbag_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablestrife")) && getgametypesetting(#"wzenablestrife")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_standard_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemozu")) && getgametypesetting(#"wzenablemozu")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablerk7")) && getgametypesetting(#"wzenablerk7")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_burst_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablekap45")) && getgametypesetting(#"wzenablekap45")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_fullauto_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemog12")) && getgametypesetting(#"wzenablemog12")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_pump_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesg12")) && getgametypesetting(#"wzenablesg12")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_semiauto_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablerampage")) && getgametypesetting(#"wzenablerampage")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_fullauto_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableargus")) && getgametypesetting(#"wzenableargus")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_precision_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesaug")) && getgametypesetting(#"wzenablesaug")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablespitfire")) && getgametypesetting(#"wzenablespitfire")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemx9")) && getgametypesetting(#"wzenablemx9")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemp40")) && getgametypesetting(#"wzenablemp40")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_mp40_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecordite")) && getgametypesetting(#"wzenablecordite")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablegks")) && getgametypesetting(#"wzenablegks")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabledaemon")) && getgametypesetting(#"wzenabledaemon")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableswitchblade")) && getgametypesetting(#"wzenableswitchblade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableicr")) && getgametypesetting(#"wzenableicr")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablekn")) && getgametypesetting(#"wzenablekn")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableswat")) && getgametypesetting(#"wzenableswat")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablerampart")) && getgametypesetting(#"wzenablerampart")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemaddox")) && getgametypesetting(#"wzenablemaddox")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablevapr")) && getgametypesetting(#"wzenablevapr")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablegrav")) && getgametypesetting(#"wzenablegrav")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_galil_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableswordfish")) && getgametypesetting(#"wzenableswordfish")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableabr")) && getgametypesetting(#"wzenableabr")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableauger")) && getgametypesetting(#"wzenableauger")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablevendetta")) && getgametypesetting(#"wzenablevendetta")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablem16")) && getgametypesetting(#"wzenablem16")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_damageburst_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletitan")) && getgametypesetting(#"wzenabletitan")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablehades")) && getgametypesetting(#"wzenablehades")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablevkm")) && getgametypesetting(#"wzenablevkm")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablekoshka")) && getgametypesetting(#"wzenablekoshka")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablepaladin")) && getgametypesetting(#"wzenablepaladin")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesdm")) && getgametypesetting(#"wzenablesdm")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableoutlaw")) && getgametypesetting(#"wzenableoutlaw")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"hash_36d000592fe3c302")) && getgametypesetting(#"hash_36d000592fe3c302")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_damagesemi_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableessex")) && getgametypesetting(#"wzenableessex")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_leveraction_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablezweihander")) && getgametypesetting(#"wzenablezweihander")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_double_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelauncher")) && getgametypesetting(#"wzenablelauncher")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"launcher_standard_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablebowieknife")) && getgametypesetting(#"wzenablebowieknife")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_32c805d452b5f91b");
	}
	if(!(isdefined(getgametypesetting(#"wzenablehomewrecker")) && getgametypesetting(#"wzenablehomewrecker")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_demohammer_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablezombiearm")) && getgametypesetting(#"wzenablezombiearm")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_zombiearm_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablestopsign")) && getgametypesetting(#"wzenablestopsign")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_stopsign_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableblade")) && getgametypesetting(#"wzenableblade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sig_blade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabledeathoforion")) && getgametypesetting(#"wzenabledeathoforion")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_5ab8d5a7f1052988");
	}
	if(!(isdefined(getgametypesetting(#"hash_5408e974098bc234")) && getgametypesetting(#"hash_5408e974098bc234")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_351539ca27808950");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7d4f218271a68cab");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_188b62566928d932");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesavageimpaler")) && getgametypesetting(#"wzenablesavageimpaler")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ww_crossbow_impaler_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablegambit22")) && getgametypesetting(#"wzenablegambit22")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"special_crossbow_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablewintersfury")) && getgametypesetting(#"wzenablewintersfury")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_7e1689892a14df96");
	}
	if(!(isdefined(getgametypesetting(#"wzenablealistairsfolly")) && getgametypesetting(#"wzenablealistairsfolly")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_300632fdf0b9f295");
	}
	if(!(isdefined(getgametypesetting(#"wzenablean94")) && getgametypesetting(#"wzenablean94")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_an94_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabledoublebarrel")) && getgametypesetting(#"wzenabledoublebarrel")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_doublebarrel_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableminigun")) && getgametypesetting(#"wzenableminigun")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_minigun_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablevmp")) && getgametypesetting(#"wzenablevmp")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_vmp_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableamulet")) && getgametypesetting(#"wzenableamulet")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6cb371d07db8ad2f");
	}
	if(!(isdefined(getgametypesetting(#"wzenableactionfigure")) && getgametypesetting(#"wzenableactionfigure")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_actionfigure_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableempgrenade")) && getgametypesetting(#"wzenableempgrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"emp_grenade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableconcussiongrenade")) && getgametypesetting(#"wzenableconcussiongrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"concussion_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesensordart")) && getgametypesetting(#"wzenablesensordart")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sensor_dart_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableclustergrenade")) && getgametypesetting(#"wzenableclustergrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_3074c41bb205ed8c");
	}
	if(!(isdefined(getgametypesetting(#"wzenablegrapple")) && getgametypesetting(#"wzenablegrapple")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"grapple_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablegrapple")) && getgametypesetting(#"wzenablegrapple")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"grapple_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablebarricade")) && getgametypesetting(#"wzenablebarricade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"barricade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablereconcar")) && getgametypesetting(#"wzenablereconcar")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"recon_car_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemeshmines")) && getgametypesetting(#"wzenablemeshmines")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"trip_wire_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletrophysystem")) && getgametypesetting(#"wzenabletrophysystem")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"trophy_system_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesmokegrenade")) && getgametypesetting(#"wzenablesmokegrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smoke_grenade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemolotov")) && getgametypesetting(#"wzenablemolotov")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"molotov_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecombataxe")) && getgametypesetting(#"wzenablecombataxe")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hatchet_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablerazorwire")) && getgametypesetting(#"wzenablerazorwire")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"concertina_wire_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablefraggrenade")) && getgametypesetting(#"wzenablefraggrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"frag_grenade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableacidbomb")) && getgametypesetting(#"wzenableacidbomb")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"acid_bomb_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablewraithfire")) && getgametypesetting(#"wzenablewraithfire")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"wraithfire_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecymbalmonkey")) && getgametypesetting(#"wzenablecymbalmonkey")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"cymbal_monkey_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"hash_13337313b93577d")) && getgametypesetting(#"hash_13337313b93577d")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"backpack_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableflareguns")) && getgametypesetting(#"wzenableflareguns")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"flare_gun_wz_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_735d22a674b7f8c0");
	}
	if(!(isdefined(getgametypesetting(#"wzenablespectregrenade")) && getgametypesetting(#"wzenablespectregrenade")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"spectre_grenade_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenabledart")) && getgametypesetting(#"wzenabledart")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"dart_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablehawk")) && getgametypesetting(#"wzenablehawk")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hawk_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablehellsretriever")) && getgametypesetting(#"wzenablehellsretriever")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tomahawk_t8_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablehomunculus")) && getgametypesetting(#"wzenablehomunculus")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"homunculus_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesentrygun")) && getgametypesetting(#"wzenablesentrygun")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ultimate_turret_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablebandages")) && getgametypesetting(#"wzenablebandages")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1abfcce0e9955057");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemedkit")) && getgametypesetting(#"wzenablemedkit")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_ff50c93155e445f");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletraumakit")) && getgametypesetting(#"wzenabletraumakit")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_80292d121740f6f");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletak5")) && getgametypesetting(#"wzenabletak5")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_45ced3880667df22");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkparanoia")) && getgametypesetting(#"wzenableperkparanoia")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_5d35f83e51965781");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkconsumer")) && getgametypesetting(#"wzenableperkconsumer")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_750be705a5c4201e");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkironlungs")) && getgametypesetting(#"wzenableperkironlungs")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1a79c2970ba8bf79");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkbrawler")) && getgametypesetting(#"wzenableperkbrawler")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_3d82033b67579745");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkawareness")) && getgametypesetting(#"wzenableperkawareness")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_799f875c8f064a83");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperklooter")) && getgametypesetting(#"wzenableperklooter")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_58c7fc0e9b3387bf");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperksquadlink")) && getgametypesetting(#"wzenableperksquadlink")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_35f5430256d9c158");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkreinforced")) && getgametypesetting(#"wzenableperkreinforced")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_3ccd209713ecb085");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkmedic")) && getgametypesetting(#"wzenableperkmedic")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_2011eafeff274fc8");
	}
	if(!(isdefined(getgametypesetting(#"hash_78e459ad87509a46")) && getgametypesetting(#"hash_78e459ad87509a46")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1f0f67f0ad9a766");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkdeadsilence")) && getgametypesetting(#"wzenableperkdeadsilence")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_332dd2a4956f495f");
	}
	if(!(isdefined(getgametypesetting(#"hash_9fa187740ff5e40")) && getgametypesetting(#"hash_9fa187740ff5e40")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_5df4c523191c9bf7");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkmobility")) && getgametypesetting(#"wzenableperkmobility")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_5d7898105fc6595a");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkengineer")) && getgametypesetting(#"wzenableperkengineer")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_61d6c77ca964fa5b");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkoutlander")) && getgametypesetting(#"wzenableperkoutlander")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_1b898a6e72d622d8");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv3armor")) && getgametypesetting(#"wzenablelv3armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_568173e016d45c2a");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv2armor")) && getgametypesetting(#"wzenablelv2armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_8578856a247ab60");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv1armor")) && getgametypesetting(#"wzenablelv1armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_6f80136c3b79d9e");
	}
	if(!(isdefined(getgametypesetting(#"wzenablearmorplate")) && getgametypesetting(#"wzenablearmorplate")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_shard_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenable4xscope")) && getgametypesetting(#"wzenable4xscope")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"acog_plus_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenable3xscope")) && getgametypesetting(#"wzenable3xscope")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"reddot_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenable2xscope")) && getgametypesetting(#"wzenable2xscope")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"acog_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableextfastmag")) && getgametypesetting(#"wzenableextfastmag")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_43b78d5eff27f2f7");
	}
	if(!(isdefined(getgametypesetting(#"wzenableextmag")) && getgametypesetting(#"wzenableextmag")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"extmag_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableextbarrel")) && getgametypesetting(#"wzenableextbarrel")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"extbarrel_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablefastmag")) && getgametypesetting(#"wzenablefastmag")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"fastmag_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableforegrip")) && getgametypesetting(#"wzenableforegrip")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"foregrip_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableholo")) && getgametypesetting(#"wzenableholo")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"holo_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelasersight")) && getgametypesetting(#"wzenablelasersight")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"laser_sight_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablepistolgrip")) && getgametypesetting(#"wzenablepistolgrip")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_grip_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablereflex")) && getgametypesetting(#"wzenablereflex")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"reflex_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesniperscope")) && getgametypesetting(#"wzenablesniperscope")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniperscope_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablestock")) && getgametypesetting(#"wzenablestock")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"stock_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesuppressor")) && getgametypesetting(#"wzenablesuppressor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"suppressor_wz_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableelo")) && getgametypesetting(#"wzenableelo")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"hash_559f58d5af0b432d");
	}
}

