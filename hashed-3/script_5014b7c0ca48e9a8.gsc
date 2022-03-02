// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10e9968112011b37;
#using script_170a9c130859c688;

#namespace namespace_e27c7374;

/*
	Name: function_45a212c0
	Namespace: namespace_e27c7374
	Checksum: 0xF733A520
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
	var_87d0eef8 = &namespace_b0722f43::function_63bfe27;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	if(!(isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
	{
		if(!(isdefined(getgametypesetting(#"hash_28a3a35c24fe616")) && getgametypesetting(#"hash_28a3a35c24fe616")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27a77e458cb2223e", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_2f4adaa9de981357")) && getgametypesetting(#"hash_2f4adaa9de981357")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7fe452ac99dcb25f", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_72baa3480316bf55")) && getgametypesetting(#"hash_72baa3480316bf55")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2572e1a193175b4d", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_30ca3c2a4473f979")) && getgametypesetting(#"hash_30ca3c2a4473f979")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2bb44d78cfdc661", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_26c067f1dd032ebc")) && getgametypesetting(#"hash_26c067f1dd032ebc")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7f50125ebbc15534", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_f04393e2e028c01")) && getgametypesetting(#"hash_f04393e2e028c01")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_5d334f942754156e", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_64aba694bd70856c")) && getgametypesetting(#"hash_64aba694bd70856c")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_10db7f8ca1621554", #"hash_5ffca3f1385154e6");
		}
		if(!(isdefined(getgametypesetting(#"hash_7fb8c0dadeac34d9")) && getgametypesetting(#"hash_7fb8c0dadeac34d9")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27d464e9703672a1", #"hash_5ffca3f1385154e6");
		}
	}
	if(maxteamplayers == 1)
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2011eafeff274fc8");
	}
	if(!(isdefined(getgametypesetting(#"hash_437b759bd6885560")) && getgametypesetting(#"hash_437b759bd6885560")))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_7f877a112c8c4187", #"");
	}
	if(!(isdefined(getgametypesetting(#"hash_33d1ac5e99fb0584")) && getgametypesetting(#"hash_33d1ac5e99fb0584")) && (!(isdefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) && getgametypesetting(#"hash_3e2d2cf6b1cc6c68"))))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_7aca06dcd83beef3", #"");
	}
	if(isdefined(getgametypesetting(#"hash_230e67d5ddfb2c06")) && getgametypesetting(#"hash_230e67d5ddfb2c06"))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_32c805d452b5f91b", #"hash_1d9cd69d5981d2c7");
	}
	if(isdefined(getgametypesetting(#"hash_661ee23f114191c1")) && getgametypesetting(#"hash_661ee23f114191c1"))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_32c805d452b5f91b", #"hash_1d9cd69d5981d2c7");
	}
	if(isdefined(getgametypesetting(#"hash_7e60451699436d76")) && getgametypesetting(#"hash_7e60451699436d76"))
	{
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1b31f48b11bd3801", #"hash_7f6ccc550b17457f");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_5af6760a28de557d", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_2c228a7b8b32e6b9", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_3d4da55492286012", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_24234ca61e649d64", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_6bbeca41cf389982", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_2e486f8abfbeba49", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_5cc9b5e23093ac03", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_15cefca07f84f894", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_6a992c957fb327bb", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_34e069748d48b434", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_25b4ece6d3e0173c", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_73ba92c06ae7102a", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_2e9b377396dcd11", #"hash_6cfcc2143e6ee6ee");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_46dd75a1a3f70780", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_182fdef2ad243e20", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_212b01feaa916a00", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_1abfcce0e9955057", #"hash_665eccfe5d58f636");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_ff50c93155e445f", #"hash_394e9478cf4f8d9d");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_799f875c8f064a83", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_3d82033b67579745", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_750be705a5c4201e", #"hash_735d22a674b7f8c0");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_332dd2a4956f495f", #"hash_61d6c77ca964fa5b");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_1a79c2970ba8bf79", #"hash_61d6c77ca964fa5b");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_2011eafeff274fc8", #"hash_61d6c77ca964fa5b");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_1b898a6e72d622d8", #"hash_61d6c77ca964fa5b");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_5d35f83e51965781", #"hash_394e9478cf4f8d9d");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_35f5430256d9c158", #"hash_394e9478cf4f8d9d");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_5506836b90ed93a9", #"hash_394e9478cf4f8d9d");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_18e6f0326e75bce4", #"hash_394e9478cf4f8d9d");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_43d8944b55b1e63c", #"hash_394e9478cf4f8d9d");
	}
	var_3ff328e2 = gamemodeismode(1) || gamemodeismode(7);
	namespace_da5c04c3::function_7860b659(var_a12b4736, undefined, #"hash_5e9c3f9821e1ee0a");
	if(!(isdefined(getgametypesetting(#"hash_512aec4c9e79844f")) && getgametypesetting(#"hash_512aec4c9e79844f")) || var_3ff328e2)
	{
		namespace_da5c04c3::function_7860b659(var_87d0eef8, undefined, #"hash_5e9c3f9821e1ee0a");
	}
	else
	{
		maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
		if(maxteamplayers == 1)
		{
			namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_60ffe3aa992db93a", #"hash_b87a51e99e52b58");
			namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_3aab463fff2b617", #"hash_25409de8d2edefb7");
		}
	}
	if(!(isdefined(getgametypesetting(#"hash_30057feeefa8bd68")) && getgametypesetting(#"hash_30057feeefa8bd68")))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_29a10cad59531d04", #"");
	}
	if(!(isdefined(getgametypesetting(#"hash_2f455474efdce33f")) && getgametypesetting(#"hash_2f455474efdce33f")))
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_4346f80fbf536799", #"");
	}
	if(isdefined(getgametypesetting(#"hash_6f272bb00e2d646e")) && getgametypesetting(#"hash_6f272bb00e2d646e"))
	{
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_13ba73311ab5250f", #"hash_3c9e4970b3140181");
	}
	if(!(isdefined(getgametypesetting(#"hash_542ec48cf30b74c0")) && getgametypesetting(#"hash_542ec48cf30b74c0")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_76aecc693bee59bf");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1a3febc9dd2ff956");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_285b16162518c948");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_44d9fdaac46214a4");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_48e9d48bfecf8dd");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_166b2f213a373dba");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7017e5a5441c4da2");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_69123f639841ddc7");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_40103f4d2f71a6a7");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_695778cec905e59b");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7be8f876858deae3");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6728f5fbe7b9eb60");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_74cbb6df24a0f9bb");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"hash_660271b8cdaeb9a6")) && getgametypesetting(#"hash_660271b8cdaeb9a6")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_76aecc693bee59bf");
		}
		if(!(isdefined(getgametypesetting(#"hash_5b8edad0ddd32514")) && getgametypesetting(#"hash_5b8edad0ddd32514")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1a3febc9dd2ff956");
		}
		if(!(isdefined(getgametypesetting(#"hash_1b859efecd7c5ada")) && getgametypesetting(#"hash_1b859efecd7c5ada")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_285b16162518c948");
		}
		if(!(isdefined(getgametypesetting(#"hash_3c8207806a75697a")) && getgametypesetting(#"hash_3c8207806a75697a")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_44d9fdaac46214a4");
		}
		if(!(isdefined(getgametypesetting(#"hash_7fa8685ec958ecdd")) && getgametypesetting(#"hash_7fa8685ec958ecdd")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_48e9d48bfecf8dd");
		}
		if(!(isdefined(getgametypesetting(#"hash_6061d8cc58f521fb")) && getgametypesetting(#"hash_6061d8cc58f521fb")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_166b2f213a373dba");
		}
		if(!(isdefined(getgametypesetting(#"hash_33b7c0db94a8da")) && getgametypesetting(#"hash_33b7c0db94a8da")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7017e5a5441c4da2");
		}
		if(!(isdefined(getgametypesetting(#"hash_2cce084109c75fb8")) && getgametypesetting(#"hash_2cce084109c75fb8")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_69123f639841ddc7");
		}
		if(!(isdefined(getgametypesetting(#"hash_1c60fd943cbf2207")) && getgametypesetting(#"hash_1c60fd943cbf2207")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_40103f4d2f71a6a7");
		}
		if(!(isdefined(getgametypesetting(#"hash_4b3e4a8072125ce2")) && getgametypesetting(#"hash_4b3e4a8072125ce2")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_695778cec905e59b");
		}
		if(!(isdefined(getgametypesetting(#"hash_9589e8a0dbb8631")) && getgametypesetting(#"hash_9589e8a0dbb8631")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7be8f876858deae3");
		}
		if(!(isdefined(getgametypesetting(#"hash_2c6d9b9532d042fe")) && getgametypesetting(#"hash_2c6d9b9532d042fe")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6728f5fbe7b9eb60");
		}
		if(!(isdefined(getgametypesetting(#"hash_fea506177d61a7e")) && getgametypesetting(#"hash_fea506177d61a7e")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_74cbb6df24a0f9bb");
		}
	}
	if(!(isdefined(getgametypesetting(#"hash_5c6371ef701d7485")) && getgametypesetting(#"hash_5c6371ef701d7485")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_250876d81f2e6f6e");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_9dcbf9df7b19434");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6857c7a83fc6cdb1");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2799bb4fa8f20048");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_e0a40edfec418ef");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_ac66bb9a3a19d91");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_691f420597727d56");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_321c0010d0c7fdc5");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_363ed03cee79d627");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_64f996475acdd244");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7a53240a3664fe64");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_52d37104fb5e6eb5");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1b69ed326eaa32c4");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_59da79c0dcf9cf76");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_21779574e3841392");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_52083f0c0759df13");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_48db4f35da313bd1");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7dced4169cb1c6bd");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6fbf66e753d55ddd");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2a4214db930e08a7");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1efebec8697e5720");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1caa1516c9ea66af");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6d33368b7b126df8");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"hash_213efc0cbd414268")) && getgametypesetting(#"hash_213efc0cbd414268")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_32834da10f1048b0");
		}
		if(!(isdefined(getgametypesetting(#"hash_2c6d9b9532d042fe")) && getgametypesetting(#"hash_2c6d9b9532d042fe")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_250876d81f2e6f6e");
		}
		if(!(isdefined(getgametypesetting(#"hash_3e882b80b421ca7d")) && getgametypesetting(#"hash_3e882b80b421ca7d")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_499748ba05372c7");
		}
		if(!(isdefined(getgametypesetting(#"hash_6bf344e62e07bffe")) && getgametypesetting(#"hash_6bf344e62e07bffe")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_40ced73804c1be81");
		}
		if(!(isdefined(getgametypesetting(#"hash_754aaf85b6f920ab")) && getgametypesetting(#"hash_754aaf85b6f920ab")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_524268075ef65e1e");
		}
		if(!(isdefined(getgametypesetting(#"hash_7fac34a754ef395a")) && getgametypesetting(#"hash_7fac34a754ef395a")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1bfc7320c1335797");
		}
		if(!(isdefined(getgametypesetting(#"hash_75240ded586d3172")) && getgametypesetting(#"hash_75240ded586d3172")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_31c3a0cc51a512d2");
		}
		if(!(isdefined(getgametypesetting(#"hash_4c2d5ba737e6acdf")) && getgametypesetting(#"hash_4c2d5ba737e6acdf")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_9dcbf9df7b19434");
		}
		if(!(isdefined(getgametypesetting(#"hash_9589e8a0dbb8631")) && getgametypesetting(#"hash_9589e8a0dbb8631")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1bd3cb5b4becaad9");
		}
		if(!(isdefined(getgametypesetting(#"hash_2209ae80a348895d")) && getgametypesetting(#"hash_2209ae80a348895d")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2799bb4fa8f20048");
		}
		if(!(isdefined(getgametypesetting(#"hash_6f7723e2e1175279")) && getgametypesetting(#"hash_6f7723e2e1175279")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_e0a40edfec418ef");
		}
		if(!(isdefined(getgametypesetting(#"hash_4b3e4a8072125ce2")) && getgametypesetting(#"hash_4b3e4a8072125ce2")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6857c7a83fc6cdb1");
		}
		if(!(isdefined(getgametypesetting(#"hash_d0928790c76d5cb")) && getgametypesetting(#"hash_d0928790c76d5cb")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_ac66bb9a3a19d91");
		}
		if(!(isdefined(getgametypesetting(#"hash_3624e1f373e400cf")) && getgametypesetting(#"hash_3624e1f373e400cf")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_691f420597727d56");
		}
		if(!(isdefined(getgametypesetting(#"hash_1d1418091b83b2f")) && getgametypesetting(#"hash_1d1418091b83b2f")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_321c0010d0c7fdc5");
		}
		if(!(isdefined(getgametypesetting(#"hash_1771050d3e1a9622")) && getgametypesetting(#"hash_1771050d3e1a9622")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_363ed03cee79d627");
		}
		if(!(isdefined(getgametypesetting(#"hash_754adea7069d7708")) && getgametypesetting(#"hash_754adea7069d7708")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_64f996475acdd244");
		}
		if(!(isdefined(getgametypesetting(#"hash_74f828ed58482468")) && getgametypesetting(#"hash_74f828ed58482468")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7a53240a3664fe64");
		}
		if(!(isdefined(getgametypesetting(#"hash_660271b8cdaeb9a6")) && getgametypesetting(#"hash_660271b8cdaeb9a6")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_52d37104fb5e6eb5");
		}
		if(!(isdefined(getgametypesetting(#"hash_5b8edad0ddd32514")) && getgametypesetting(#"hash_5b8edad0ddd32514")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1b69ed326eaa32c4");
		}
		if(!(isdefined(getgametypesetting(#"hash_1b859efecd7c5ada")) && getgametypesetting(#"hash_1b859efecd7c5ada")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_59da79c0dcf9cf76");
		}
		if(!(isdefined(getgametypesetting(#"hash_3c8207806a75697a")) && getgametypesetting(#"hash_3c8207806a75697a")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_21779574e3841392");
		}
		if(!(isdefined(getgametypesetting(#"hash_7fa8685ec958ecdd")) && getgametypesetting(#"hash_7fa8685ec958ecdd")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_52083f0c0759df13");
		}
		if(!(isdefined(getgametypesetting(#"hash_fea506177d61a7e")) && getgametypesetting(#"hash_fea506177d61a7e")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_48db4f35da313bd1");
		}
		if(!(isdefined(getgametypesetting(#"hash_1c60fd943cbf2207")) && getgametypesetting(#"hash_1c60fd943cbf2207")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7dced4169cb1c6bd");
		}
		if(!(isdefined(getgametypesetting(#"hash_2cce084109c75fb8")) && getgametypesetting(#"hash_2cce084109c75fb8")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6fbf66e753d55ddd");
		}
		if(!(isdefined(getgametypesetting(#"hash_5f44f580c6226773")) && getgametypesetting(#"hash_5f44f580c6226773")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2a4214db930e08a7");
		}
		if(!(isdefined(getgametypesetting(#"hash_33b7c0db94a8da")) && getgametypesetting(#"hash_33b7c0db94a8da")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1efebec8697e5720");
		}
		if(!(isdefined(getgametypesetting(#"hash_21865506375b245a")) && getgametypesetting(#"hash_21865506375b245a")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1caa1516c9ea66af");
		}
		if(!(isdefined(getgametypesetting(#"hash_34284880adc550c3")) && getgametypesetting(#"hash_34284880adc550c3")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_199230a69a867bf8");
		}
		if(!(isdefined(getgametypesetting(#"hash_6061d8cc58f521fb")) && getgametypesetting(#"hash_6061d8cc58f521fb")))
		{
			namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6d33368b7b126df8");
		}
	}
	if(!(isdefined(getgametypesetting(#"hash_41d75cbe78f7837c")) && getgametypesetting(#"hash_41d75cbe78f7837c")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3063198fc139e3b0");
	}
	if(!(isdefined(getgametypesetting(#"hash_211486dd31982753")) && getgametypesetting(#"hash_211486dd31982753")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2f73719d945fc6b5");
	}
	if(!(isdefined(getgametypesetting(#"hash_46abc67b302b3b9a")) && getgametypesetting(#"hash_46abc67b302b3b9a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6c0eed50f4c26acb");
	}
	if(!(isdefined(getgametypesetting(#"hash_6e712c690b82cff9")) && getgametypesetting(#"hash_6e712c690b82cff9")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_19f93a4afe31c8f1");
	}
	if(!(isdefined(getgametypesetting(#"hash_358fb7a0761fc54d")) && getgametypesetting(#"hash_358fb7a0761fc54d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7313f9c02b023a53");
	}
	if(!(isdefined(getgametypesetting(#"hash_5f99f52d9081044e")) && getgametypesetting(#"hash_5f99f52d9081044e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_237d7fbe80a5dd72");
	}
	if(!(isdefined(getgametypesetting(#"hash_3a92adec8c38ead3")) && getgametypesetting(#"hash_3a92adec8c38ead3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_359c16f0ecf7fa33");
	}
	if(!(isdefined(getgametypesetting(#"hash_18cc28436f74f40")) && getgametypesetting(#"hash_18cc28436f74f40")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_108e6539e3886420");
	}
	if(!(isdefined(getgametypesetting(#"hash_213efc0cbd414268")) && getgametypesetting(#"hash_213efc0cbd414268")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5cc9b5e23093ac03");
	}
	if(!(isdefined(getgametypesetting(#"hash_2c6d9b9532d042fe")) && getgametypesetting(#"hash_2c6d9b9532d042fe")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2e486f8abfbeba49");
	}
	if(!(isdefined(getgametypesetting(#"hash_3e882b80b421ca7d")) && getgametypesetting(#"hash_3e882b80b421ca7d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6bbeca41cf389982");
	}
	if(!(isdefined(getgametypesetting(#"hash_6bf344e62e07bffe")) && getgametypesetting(#"hash_6bf344e62e07bffe")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_24234ca61e649d64");
	}
	if(!(isdefined(getgametypesetting(#"hash_754aaf85b6f920ab")) && getgametypesetting(#"hash_754aaf85b6f920ab")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2c228a7b8b32e6b9");
	}
	if(!(isdefined(getgametypesetting(#"hash_7fac34a754ef395a")) && getgametypesetting(#"hash_7fac34a754ef395a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3d4da55492286012");
	}
	if(!(isdefined(getgametypesetting(#"hash_75240ded586d3172")) && getgametypesetting(#"hash_75240ded586d3172")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5af6760a28de557d");
	}
	if(!(isdefined(getgametypesetting(#"hash_6ca9876ab1b88d9d")) && getgametypesetting(#"hash_6ca9876ab1b88d9d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3cb0287b7a6acb0b");
	}
	if(!(isdefined(getgametypesetting(#"hash_4c2d5ba737e6acdf")) && getgametypesetting(#"hash_4c2d5ba737e6acdf")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_59cfdb25a9e268d7");
	}
	if(!(isdefined(getgametypesetting(#"hash_9589e8a0dbb8631")) && getgametypesetting(#"hash_9589e8a0dbb8631")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_25b4ece6d3e0173c");
	}
	if(!(isdefined(getgametypesetting(#"hash_2209ae80a348895d")) && getgametypesetting(#"hash_2209ae80a348895d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6a992c957fb327bb");
	}
	if(!(isdefined(getgametypesetting(#"hash_63afbb959aff54fa")) && getgametypesetting(#"hash_63afbb959aff54fa")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_60d59d946f08ce33");
	}
	if(!(isdefined(getgametypesetting(#"hash_6f7723e2e1175279")) && getgametypesetting(#"hash_6f7723e2e1175279")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_73ba92c06ae7102a");
	}
	if(!(isdefined(getgametypesetting(#"hash_4b3e4a8072125ce2")) && getgametypesetting(#"hash_4b3e4a8072125ce2")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_15cefca07f84f894");
	}
	if(!(isdefined(getgametypesetting(#"hash_d0928790c76d5cb")) && getgametypesetting(#"hash_d0928790c76d5cb")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_34e069748d48b434");
	}
	if(!(isdefined(getgametypesetting(#"hash_3624e1f373e400cf")) && getgametypesetting(#"hash_3624e1f373e400cf")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2e9b377396dcd11");
	}
	if(!(isdefined(getgametypesetting(#"hash_1d1418091b83b2f")) && getgametypesetting(#"hash_1d1418091b83b2f")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6c6c011df03c8f18");
	}
	if(!(isdefined(getgametypesetting(#"hash_1771050d3e1a9622")) && getgametypesetting(#"hash_1771050d3e1a9622")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_4e96ed69230e28a2");
	}
	if(!(isdefined(getgametypesetting(#"hash_754adea7069d7708")) && getgametypesetting(#"hash_754adea7069d7708")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_371a6c5b25d41927");
	}
	if(!(isdefined(getgametypesetting(#"hash_74f828ed58482468")) && getgametypesetting(#"hash_74f828ed58482468")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3aa75724345f7f87");
	}
	if(!(isdefined(getgametypesetting(#"hash_660271b8cdaeb9a6")) && getgametypesetting(#"hash_660271b8cdaeb9a6")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_47b346d1e63e6488");
	}
	if(!(isdefined(getgametypesetting(#"hash_5b8edad0ddd32514")) && getgametypesetting(#"hash_5b8edad0ddd32514")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_11366e8cbf37dea7");
	}
	if(!(isdefined(getgametypesetting(#"hash_3438dd4245dd0515")) && getgametypesetting(#"hash_3438dd4245dd0515")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_36349aad8f680651");
	}
	if(!(isdefined(getgametypesetting(#"hash_1b859efecd7c5ada")) && getgametypesetting(#"hash_1b859efecd7c5ada")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_75142ec69bd0df71");
	}
	if(!(isdefined(getgametypesetting(#"hash_3c8207806a75697a")) && getgametypesetting(#"hash_3c8207806a75697a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_29f4e28734c2613d");
	}
	if(!(isdefined(getgametypesetting(#"hash_7fa8685ec958ecdd")) && getgametypesetting(#"hash_7fa8685ec958ecdd")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_938a51cfa9e21fe");
	}
	if(!(isdefined(getgametypesetting(#"hash_fea506177d61a7e")) && getgametypesetting(#"hash_fea506177d61a7e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1abd0375a9ba4674");
	}
	if(!(isdefined(getgametypesetting(#"hash_2301a180a41b1495")) && getgametypesetting(#"hash_2301a180a41b1495")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7bf2825f31eb6f0c");
	}
	if(!(isdefined(getgametypesetting(#"hash_1c60fd943cbf2207")) && getgametypesetting(#"hash_1c60fd943cbf2207")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_36978e3a9321b430");
	}
	if(!(isdefined(getgametypesetting(#"hash_2cce084109c75fb8")) && getgametypesetting(#"hash_2cce084109c75fb8")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_15f30a19a23c0190");
	}
	if(!(isdefined(getgametypesetting(#"hash_5f44f580c6226773")) && getgametypesetting(#"hash_5f44f580c6226773")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7868873aabca7422");
	}
	if(!(isdefined(getgametypesetting(#"hash_33b7c0db94a8da")) && getgametypesetting(#"hash_33b7c0db94a8da")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_75c91bcbb2ac5f3");
	}
	if(!(isdefined(getgametypesetting(#"hash_21865506375b245a")) && getgametypesetting(#"hash_21865506375b245a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_75ed0988ff325bea");
	}
	if(!(isdefined(getgametypesetting(#"hash_34284880adc550c3")) && getgametypesetting(#"hash_34284880adc550c3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_298f2c53101e30eb");
	}
	if(!(isdefined(getgametypesetting(#"hash_6061d8cc58f521fb")) && getgametypesetting(#"hash_6061d8cc58f521fb")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_38628762fb7c16eb");
	}
	if(!(isdefined(getgametypesetting(#"hash_36d000592fe3c302")) && getgametypesetting(#"hash_36d000592fe3c302")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1114f950994a0ad");
	}
	if(!(isdefined(getgametypesetting(#"hash_25c035e6c2647b25")) && getgametypesetting(#"hash_25c035e6c2647b25")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_154ee1cd494fed23");
	}
	if(!(isdefined(getgametypesetting(#"hash_580dd188be1df5b0")) && getgametypesetting(#"hash_580dd188be1df5b0")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_38406c9af972cfc8");
	}
	if(!(isdefined(getgametypesetting(#"hash_2f54612ef16bb07b")) && getgametypesetting(#"hash_2f54612ef16bb07b")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6cfcc2143e6ee6ee");
	}
	if(!(isdefined(getgametypesetting(#"hash_51fb2c5cf353734c")) && getgametypesetting(#"hash_51fb2c5cf353734c")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_32c805d452b5f91b");
	}
	if(!(isdefined(getgametypesetting(#"hash_72bb0b1fd35b9351")) && getgametypesetting(#"hash_72bb0b1fd35b9351")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_44e8c54439fa37e4");
	}
	if(!(isdefined(getgametypesetting(#"hash_5571ecd1d1424351")) && getgametypesetting(#"hash_5571ecd1d1424351")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_d06321f16576d1");
	}
	if(!(isdefined(getgametypesetting(#"hash_5a147405a1dfd976")) && getgametypesetting(#"hash_5a147405a1dfd976")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_779bd05ab23a8960");
	}
	if(!(isdefined(getgametypesetting(#"hash_2260f0046cdcaabf")) && getgametypesetting(#"hash_2260f0046cdcaabf")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_43aca7fcfd3e5949");
	}
	if(!(isdefined(getgametypesetting(#"hash_446939a6459aedf3")) && getgametypesetting(#"hash_446939a6459aedf3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5ab8d5a7f1052988");
	}
	if(!(isdefined(getgametypesetting(#"hash_5408e974098bc234")) && getgametypesetting(#"hash_5408e974098bc234")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_351539ca27808950");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7d4f218271a68cab");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_188b62566928d932");
	}
	if(!(isdefined(getgametypesetting(#"hash_76432fd7e57b1bee")) && getgametypesetting(#"hash_76432fd7e57b1bee")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_50e8d062f783c1b6");
	}
	if(!(isdefined(getgametypesetting(#"hash_57743f417c14e3f9")) && getgametypesetting(#"hash_57743f417c14e3f9")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_57193614dcdf4d44");
	}
	if(!(isdefined(getgametypesetting(#"hash_49746a22bfe5fb83")) && getgametypesetting(#"hash_49746a22bfe5fb83")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7e1689892a14df96");
	}
	if(!(isdefined(getgametypesetting(#"hash_71f1a84d7208bd57")) && getgametypesetting(#"hash_71f1a84d7208bd57")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_300632fdf0b9f295");
	}
	if(!(isdefined(getgametypesetting(#"hash_69502334f96452e5")) && getgametypesetting(#"hash_69502334f96452e5")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_74af73187bee531c");
	}
	if(!(isdefined(getgametypesetting(#"hash_4da10871d345f646")) && getgametypesetting(#"hash_4da10871d345f646")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6c4a730e599b8513");
	}
	if(!(isdefined(getgametypesetting(#"hash_39d72f93c54f240e")) && getgametypesetting(#"hash_39d72f93c54f240e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_383a7ee05d5b8327");
	}
	if(!(isdefined(getgametypesetting(#"hash_5f3e0480c61c6242")) && getgametypesetting(#"hash_5f3e0480c61c6242")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5dbe742451e190cb");
	}
	if(!(isdefined(getgametypesetting(#"hash_3507f93c9c154f91")) && getgametypesetting(#"hash_3507f93c9c154f91")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6cb371d07db8ad2f");
	}
	if(!(isdefined(getgametypesetting(#"hash_f5a1f8a32fee915")) && getgametypesetting(#"hash_f5a1f8a32fee915")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2c0c595e0e899af3");
	}
	if(!(isdefined(getgametypesetting(#"hash_3ef0b277331a6967")) && getgametypesetting(#"hash_3ef0b277331a6967")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_213093d947c30be6");
	}
	if(!(isdefined(getgametypesetting(#"hash_176ffa7e5bcc3e9b")) && getgametypesetting(#"hash_176ffa7e5bcc3e9b")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1a7edb90a484158b");
	}
	if(!(isdefined(getgametypesetting(#"hash_6ac86084bc041660")) && getgametypesetting(#"hash_6ac86084bc041660")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_300914db9caf4033");
	}
	if(!(isdefined(getgametypesetting(#"hash_50352319697250b")) && getgametypesetting(#"hash_50352319697250b")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3074c41bb205ed8c");
	}
	if(!(isdefined(getgametypesetting(#"hash_3c652ce65176098e")) && getgametypesetting(#"hash_3c652ce65176098e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_665eccfe5d58f636");
	}
	if(!(isdefined(getgametypesetting(#"hash_3c652ce65176098e")) && getgametypesetting(#"hash_3c652ce65176098e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_665eccfe5d58f636");
	}
	if(!(isdefined(getgametypesetting(#"hash_565cb574e1da9e2a")) && getgametypesetting(#"hash_565cb574e1da9e2a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2b06a3f530395182");
	}
	if(!(isdefined(getgametypesetting(#"hash_2fd89902533bd300")) && getgametypesetting(#"hash_2fd89902533bd300")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3e2adcfef9a6105b");
	}
	if(!(isdefined(getgametypesetting(#"hash_20787bdeafae5592")) && getgametypesetting(#"hash_20787bdeafae5592")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_743b859c2367ff54");
	}
	if(!(isdefined(getgametypesetting(#"hash_7d2d9c6d8d1efde4")) && getgametypesetting(#"hash_7d2d9c6d8d1efde4")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1242946e889704c7");
	}
	if(!(isdefined(getgametypesetting(#"hash_1f66d712319e8a92")) && getgametypesetting(#"hash_1f66d712319e8a92")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_745d80b3e4f28da1");
	}
	if(!(isdefined(getgametypesetting(#"hash_270fc90c123830a3")) && getgametypesetting(#"hash_270fc90c123830a3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_4cec712579f1202f");
	}
	if(!(isdefined(getgametypesetting(#"hash_3ff237bde39c8efd")) && getgametypesetting(#"hash_3ff237bde39c8efd")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5752a7e130ea202a");
	}
	if(!(isdefined(getgametypesetting(#"hash_54b31c3bfb70da4c")) && getgametypesetting(#"hash_54b31c3bfb70da4c")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_14b578e446580ad5");
	}
	if(!(isdefined(getgametypesetting(#"hash_24263e1413f95dff")) && getgametypesetting(#"hash_24263e1413f95dff")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_53a2516ec1d3a096");
	}
	if(!(isdefined(getgametypesetting(#"hash_26e0ba5b365a4566")) && getgametypesetting(#"hash_26e0ba5b365a4566")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2b5027622c0b6d07");
	}
	if(!(isdefined(getgametypesetting(#"hash_48bfd40836d0ef18")) && getgametypesetting(#"hash_48bfd40836d0ef18")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_57504010ce1814dc");
	}
	if(!(isdefined(getgametypesetting(#"hash_264b3275c189b600")) && getgametypesetting(#"hash_264b3275c189b600")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5e5f2ed57ac4601f");
	}
	if(!(isdefined(getgametypesetting(#"hash_13337313b93577d")) && getgametypesetting(#"hash_13337313b93577d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_527b2cdb9b6837f3");
	}
	if(!(isdefined(getgametypesetting(#"hash_16f10373ec8e6906")) && getgametypesetting(#"hash_16f10373ec8e6906")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2e8b13391f6544");
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_735d22a674b7f8c0");
	}
	if(!(isdefined(getgametypesetting(#"hash_2fa72a7ec2d86741")) && getgametypesetting(#"hash_2fa72a7ec2d86741")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7e8c84081fafaea4");
	}
	if(!(isdefined(getgametypesetting(#"hash_6eeaa45e9976304a")) && getgametypesetting(#"hash_6eeaa45e9976304a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_4a2739676c12d92a");
	}
	if(!(isdefined(getgametypesetting(#"hash_1c49677d802ba06a")) && getgametypesetting(#"hash_1c49677d802ba06a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_140318e970e711ce");
	}
	if(!(isdefined(getgametypesetting(#"hash_7c6aa297d67f94c1")) && getgametypesetting(#"hash_7c6aa297d67f94c1")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_4edf613e9b9032da");
	}
	if(!(isdefined(getgametypesetting(#"hash_29e7b59313a2f532")) && getgametypesetting(#"hash_29e7b59313a2f532")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_105f32560e2fb0fe");
	}
	if(!(isdefined(getgametypesetting(#"hash_950a1bae46ea69e")) && getgametypesetting(#"hash_950a1bae46ea69e")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_50b970644e43947b");
	}
	if(!(isdefined(getgametypesetting(#"hash_5e9a89fe817a3fac")) && getgametypesetting(#"hash_5e9a89fe817a3fac")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1abfcce0e9955057");
	}
	if(!(isdefined(getgametypesetting(#"hash_5ee2b0f4d3fcc73d")) && getgametypesetting(#"hash_5ee2b0f4d3fcc73d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_ff50c93155e445f");
	}
	if(!(isdefined(getgametypesetting(#"hash_18a48cc68a5ea51b")) && getgametypesetting(#"hash_18a48cc68a5ea51b")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_80292d121740f6f");
	}
	if(!(isdefined(getgametypesetting(#"hash_459bf1e2c40244a0")) && getgametypesetting(#"hash_459bf1e2c40244a0")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_45ced3880667df22");
	}
	if(!(isdefined(getgametypesetting(#"hash_6441f0d43571288")) && getgametypesetting(#"hash_6441f0d43571288")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5d35f83e51965781");
	}
	if(!(isdefined(getgametypesetting(#"hash_624b317222a0532b")) && getgametypesetting(#"hash_624b317222a0532b")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_750be705a5c4201e");
	}
	if(!(isdefined(getgametypesetting(#"hash_6062f089b8e2a9b6")) && getgametypesetting(#"hash_6062f089b8e2a9b6")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1a79c2970ba8bf79");
	}
	if(!(isdefined(getgametypesetting(#"hash_26c2d144e8174846")) && getgametypesetting(#"hash_26c2d144e8174846")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3d82033b67579745");
	}
	if(!(isdefined(getgametypesetting(#"hash_330eef3a75c26bb4")) && getgametypesetting(#"hash_330eef3a75c26bb4")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_799f875c8f064a83");
	}
	if(!(isdefined(getgametypesetting(#"hash_2ca3c9c6942bd9a6")) && getgametypesetting(#"hash_2ca3c9c6942bd9a6")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_58c7fc0e9b3387bf");
	}
	if(!(isdefined(getgametypesetting(#"hash_50105b0ebfabeb63")) && getgametypesetting(#"hash_50105b0ebfabeb63")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_35f5430256d9c158");
	}
	if(!(isdefined(getgametypesetting(#"hash_522bb6c75afd7380")) && getgametypesetting(#"hash_522bb6c75afd7380")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_3ccd209713ecb085");
	}
	if(!(isdefined(getgametypesetting(#"hash_7f16c3fe5a8dcf07")) && getgametypesetting(#"hash_7f16c3fe5a8dcf07")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2011eafeff274fc8");
	}
	if(!(isdefined(getgametypesetting(#"hash_78e459ad87509a46")) && getgametypesetting(#"hash_78e459ad87509a46")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1f0f67f0ad9a766");
	}
	if(!(isdefined(getgametypesetting(#"hash_270660990ceab264")) && getgametypesetting(#"hash_270660990ceab264")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_332dd2a4956f495f");
	}
	if(!(isdefined(getgametypesetting(#"hash_9fa187740ff5e40")) && getgametypesetting(#"hash_9fa187740ff5e40")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5df4c523191c9bf7");
	}
	if(!(isdefined(getgametypesetting(#"hash_f5ea977f20c026a")) && getgametypesetting(#"hash_f5ea977f20c026a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5d7898105fc6595a");
	}
	if(!(isdefined(getgametypesetting(#"hash_59fbb75e58a43cc6")) && getgametypesetting(#"hash_59fbb75e58a43cc6")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_61d6c77ca964fa5b");
	}
	if(!(isdefined(getgametypesetting(#"hash_2f487cfcc854c2e3")) && getgametypesetting(#"hash_2f487cfcc854c2e3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_1b898a6e72d622d8");
	}
	if(!(isdefined(getgametypesetting(#"hash_146e1b05312c9ab5")) && getgametypesetting(#"hash_146e1b05312c9ab5")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_568173e016d45c2a");
	}
	if(!(isdefined(getgametypesetting(#"hash_5b664424fc3e930")) && getgametypesetting(#"hash_5b664424fc3e930")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_8578856a247ab60");
	}
	if(!(isdefined(getgametypesetting(#"hash_78ab4c93600cd5c7")) && getgametypesetting(#"hash_78ab4c93600cd5c7")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_6f80136c3b79d9e");
	}
	if(!(isdefined(getgametypesetting(#"hash_236b15ded103132a")) && getgametypesetting(#"hash_236b15ded103132a")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2e33ce38d6cda617");
	}
	if(!(isdefined(getgametypesetting(#"hash_230f75891223e1f5")) && getgametypesetting(#"hash_230f75891223e1f5")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_23c6d9e19274be66");
	}
	if(!(isdefined(getgametypesetting(#"hash_76563462cf31f5c")) && getgametypesetting(#"hash_76563462cf31f5c")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_a1deb882d59a069");
	}
	if(!(isdefined(getgametypesetting(#"hash_5d93a4005fc11d4f")) && getgametypesetting(#"hash_5d93a4005fc11d4f")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5506836b90ed93a9");
	}
	if(!(isdefined(getgametypesetting(#"hash_daba3be8725aaab")) && getgametypesetting(#"hash_daba3be8725aaab")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_43b78d5eff27f2f7");
	}
	if(!(isdefined(getgametypesetting(#"hash_2a43a965bf36a10d")) && getgametypesetting(#"hash_2a43a965bf36a10d")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_66023e3bee6c58a1");
	}
	if(!(isdefined(getgametypesetting(#"hash_62181bb12898aef6")) && getgametypesetting(#"hash_62181bb12898aef6")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2a10ad247a663aaa");
	}
	if(!(isdefined(getgametypesetting(#"hash_bbe8adfda44e21c")) && getgametypesetting(#"hash_bbe8adfda44e21c")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_513a787ad3a20198");
	}
	if(!(isdefined(getgametypesetting(#"hash_34f53d28a9bbfae9")) && getgametypesetting(#"hash_34f53d28a9bbfae9")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_38821d90f8209d05");
	}
	if(!(isdefined(getgametypesetting(#"hash_13eba17dc37792f7")) && getgametypesetting(#"hash_13eba17dc37792f7")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_2b2bf36e2ea5ab8f");
	}
	if(!(isdefined(getgametypesetting(#"hash_284d72b0796fe6d3")) && getgametypesetting(#"hash_284d72b0796fe6d3")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_43d8944b55b1e63c");
	}
	if(!(isdefined(getgametypesetting(#"hash_1b28296927171330")) && getgametypesetting(#"hash_1b28296927171330")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_7bdf38527a146679");
	}
	if(!(isdefined(getgametypesetting(#"hash_3f7e825f67393df5")) && getgametypesetting(#"hash_3f7e825f67393df5")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_19c5c6ca805715e5");
	}
	if(!(isdefined(getgametypesetting(#"hash_7b794bb976baacfc")) && getgametypesetting(#"hash_7b794bb976baacfc")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_18e6f0326e75bce4");
	}
	if(!(isdefined(getgametypesetting(#"hash_6fd3b6b84cd7c91f")) && getgametypesetting(#"hash_6fd3b6b84cd7c91f")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_5cadbeaa35cf0a4b");
	}
	if(!(isdefined(getgametypesetting(#"hash_21617b6e09ed2361")) && getgametypesetting(#"hash_21617b6e09ed2361")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_460aadea32c22c61");
	}
	if(!(isdefined(getgametypesetting(#"hash_5da4b0807ccc818f")) && getgametypesetting(#"hash_5da4b0807ccc818f")))
	{
		namespace_da5c04c3::function_7860b659(var_a12b4736, var_87d0eef8, #"hash_559f58d5af0b432d");
	}
}

