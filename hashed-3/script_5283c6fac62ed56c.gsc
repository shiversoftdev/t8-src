// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10e9968112011b37;
#using script_170a9c130859c688;

#namespace namespace_ec834edc;

/*
	Name: __init__
	Namespace: namespace_ec834edc
	Checksum: 0x32E3B4B3
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
autoexec function __init__()
{
	function_62cd02cc();
}

/*
	Name: function_62cd02cc
	Namespace: namespace_ec834edc
	Checksum: 0x3D7BDD5
	Offset: 0xE0
	Size: 0x10AC
	Parameters: 0
	Flags: Linked
*/
function function_62cd02cc()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::function_63bfe27;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	var_edfbccd0 = &namespace_b0722f43::function_e70fa91c;
	var_e92b5b25 = getgametypesetting(#"hash_280809419b2cabc0");
	if(isdefined(var_e92b5b25) && var_e92b5b25)
	{
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_212b01feaa916a00", #"hash_7ebaa4e1e2f5d8a2");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_3bf6ed4e3a22e9f3", #"hash_3b5119f663e783b1");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_1f72dec518451f8c", #"hash_3b5119f663e783b1");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_182fdef2ad243e20", #"hash_3b5119f663e783b1");
		namespace_da5c04c3::function_149cbc84(var_d2223309, var_74257310, #"hash_46dd75a1a3f70780", #"hash_7ebaa4e1e2f5d8a2");
		if(var_e92b5b25 == 1)
		{
			str_list = #"ambush";
		}
		else
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_157da59e7a4b1f80", #"hash_5bd1324b19fc827a");
			namespace_da5c04c3::function_149cbc84(var_edfbccd0, undefined, #"hash_1edbe1c283127e19", #"hash_229b26f37060a5c3");
			namespace_da5c04c3::function_149cbc84(var_edfbccd0, undefined, #"hash_4bfbb656e63b17ae", #"hash_229b26f37060a5c3");
			namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_30dcaca16025cb02", #"hash_71bfd39dd3312198");
			str_list = #"hash_5b59c601969f4bb2";
		}
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6e8a65a99293fcaa", #"hash_604d143f1f7c7f76");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_670d02ab3b4128b2", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_46f73ca5ddb4e276", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_73b67150c513b4f9", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_4a637cd4a03131b2", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27e22f275feb07fe", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_5169964579e807e3", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3c8a483e6ebb08cb", str_list + "_guns");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_288777455d94303e", str_list + "_guns_gold");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_25fc1eba4e8349b", str_list + "_guns_gold");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_774a49591e12d6d", str_list + "_supply_stash_slot1");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_53568e2a0a929c12", str_list + "_supply_stash_slot2");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_4be238cfa4c911b7", #"hash_53e812893205cbc5");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_58959191442a7ad4", #"hash_53e80b893205bfe0");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_3ea2902b7908e871", #"hash_53e80c893205c193");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_56de9a2fafe83d34", str_list + "_supply_stash_slot1");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_56de9d2fafe8424d", str_list + "_supply_stash_slot2");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_56de9c2fafe8409a", #"hash_53e812893205cbc5");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_56de972fafe8381b", #"hash_53e80b893205bfe0");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_56de962fafe83668", #"hash_53e80c893205c193");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_166d47d063a39440", #"hash_3d02f5c56a6ca079");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_7f70b6e5eca04933", str_list + "_guns_gold");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_7eaaa233311733c6", #"hash_761df57ee1afd730");
		namespace_da5c04c3::function_149cbc84(var_f8a4c541, undefined, #"hash_72237d19c92c6b21", #"hash_5f368fdfb643d45e");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6fc60554f331d773", #"hash_14c8f136272c2cc0");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7491ec9e64118e2c", #"hash_629cbe2478d19625");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6a6bd69e5de63610", #"hash_6598098381e1a09");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_230efa8b15f70979", #"hash_1d4ea58da145f816");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_403ed348400ef4e7", #"hash_46049cde635b2f84");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3f8034fc64c31ee1", #"hash_7b45beb26f4d91e");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2d961760cac60b12", #"hash_576fbac492e4d1cb");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_353d5160ced2a576", #"hash_2ce1cb4b0fa1a2ff");
		namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_c89114ed7149b85", #"hash_2716d5ce25496be2");
		if(isdefined(getgametypesetting(#"hash_28a3a35c24fe616")) && getgametypesetting(#"hash_28a3a35c24fe616") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27a77e458cb2223e", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_2f4adaa9de981357")) && getgametypesetting(#"hash_2f4adaa9de981357") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7fe452ac99dcb25f", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_72baa3480316bf55")) && getgametypesetting(#"hash_72baa3480316bf55") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2572e1a193175b4d", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_30ca3c2a4473f979")) && getgametypesetting(#"hash_30ca3c2a4473f979") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2bb44d78cfdc661", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_26c067f1dd032ebc")) && getgametypesetting(#"hash_26c067f1dd032ebc") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_7f50125ebbc15534", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_f04393e2e028c01")) && getgametypesetting(#"hash_f04393e2e028c01") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_5d334f942754156e", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_64aba694bd70856c")) && getgametypesetting(#"hash_64aba694bd70856c") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_10db7f8ca1621554", #"hash_45b5072d8475909");
		}
		if(isdefined(getgametypesetting(#"hash_7fb8c0dadeac34d9")) && getgametypesetting(#"hash_7fb8c0dadeac34d9") || (isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
		{
			namespace_da5c04c3::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_27d464e9703672a1", #"hash_45b5072d8475909");
		}
	}
}

