// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_common_fixup.gsc;
#using script_170a9c130859c688;

#namespace namespace_96ab18d4;

/*
	Name: __init__
	Namespace: namespace_96ab18d4
	Checksum: 0xD061E379
	Offset: 0x78
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	function_6df391ab();
}

/*
	Name: function_6df391ab
	Namespace: namespace_96ab18d4
	Checksum: 0xBB57758B
	Offset: 0x98
	Size: 0x2DB4
	Parameters: 0
	Flags: Linked
*/
function function_6df391ab()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
	if(!(isdefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_25481b71f9abe27d", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_519d3a4a64c8cb41", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_7df5c3630a76391e", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_7a16abae7d7cbe91", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2be5ba2fe4176cec", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2a97e28588c0e70d", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_187986857e448901", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecargotruck")) && getgametypesetting(#"wzenablecargotruck")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1fb06a3f56ce1796", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_4cb788e3e2dbf87b", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_42baf85b0315910a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_734a2c922f9005de", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelittlebird")) && getgametypesetting(#"wzenablelittlebird")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_3838dc85d5d723c2", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_4d7bcf7f8d0c186d", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_75eee449043ac5de", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_52f2c1a871c6ec1f", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1901d08fcd916430", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_fd6f140d8bcdac2", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletacticalraft")) && getgametypesetting(#"wzenabletacticalraft")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_400500d7f09c79bc", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2042fbc5251cee8", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_5596b963052eb73a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_4e20ad723ed1eaaf", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablearav")) && getgametypesetting(#"wzenablearav")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_71e093f11898ba29", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_7e203893238d1bbd", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_29e322933c77313b", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_3d64db939015efd5", #"");
		if(!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"hash_139acdd590ca3442");
		}
	}
	if(!(isdefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_19dc50f4de7eee0a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2731d0584cb10b76", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_17ad8eedc1451066", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_378682f68abe6168", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_63e35d15854d826a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_2e020e9650f91845", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1594dd26d1a41114", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_74be96797856fa8a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_7baa5f6e6279bc21", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1c836de919898458", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_36e1b4677bd71228", #"");
	}
	else if(!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && (!(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_16e0b9072c3b1e13");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_6d754bec0d9dfae7");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_466620938ca8df9a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_25c2cc7eb3a2a6e6", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_633457fb952af20b", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_14bb8c1eee3726b6", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_f9565d1de3f0ca5", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_65599b297608d916", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_497e2b75eba10fe8", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_671e5a59078f147b", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_5b7b068157e0d401", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_315468ed02f0a459", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_e43a7178b27fa38", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_783d715d99a78f7", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_6c03445407374b2", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_181704659001416a", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_1575cc856e117a7f", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_65daa543e7b9645f", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_b7249ef08ef3fe3", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_58b2f14a0f17dad5", #"");
	}
	else if(isdefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv") && (isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")) && (!(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar"))) && (!(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_35aa8b10467eb39d");
	}
	if(!(isdefined(getgametypesetting(#"wzenablereplacercar")) && getgametypesetting(#"wzenablereplacercar")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_4bc7cb3d2c929e11", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_281f596586975bd0", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_57d41aed7b572c2c", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_127376a55715570e", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_64507c7b423c85e5", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_25b05667a203f86e", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_319e7234b67c192f", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_132b60e9b406d9bb", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_ae20347969d9e80", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_5fb94a533612f4fc", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_50dd094cb5f196a4", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_70f97f9de558c03e", #"");
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_48626b1f40e63c40", #"");
	}
	else if(!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_3812049990542183");
	}
	if(!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		if(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar"))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_1a6670777ac8e38c");
			if(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))
			{
				if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
				{
					wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_1df26c2b584534f0");
				}
				else
				{
					wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_6626d2dc4952331e");
				}
				if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
				{
					wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_604d143f1f7c7f76");
				}
				wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_119ebf7c38f10724");
			}
			else
			{
				if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
				{
					wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_23031ef9fe71ef45");
				}
				else
				{
					wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_2174b8eb76412fb3");
				}
			}
		}
		else if(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))
		{
			if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
			{
				wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_23031ef9fe71ef45");
			}
			else
			{
				wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_2174b8eb76412fb3");
			}
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_4748761d5bf2d25a");
		}
	}
	if(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_6edfaf70ad03eaef");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_3a27bf78d24805e");
		if(!(isdefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_47932c30b6d303f9");
		}
		else
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_ec830fead8a57a6");
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_6d754bec0d9dfae7");
		}
		if(isdefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr"))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1926dc7c3ce2bfb2", #"hash_346e4bfaf0aee29");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
		{
			wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_3331822e00aa2879");
		}
	}
	if(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::function_149cbc84(var_d2223309, var_74257310, #"hash_4e20ad723ed1eaaf", #"hash_5596b963052eb73a");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_6f6862f0792bbdf");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_6626d2dc4952331e");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_604d143f1f7c7f76");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_119ebf7c38f10724");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_10f8fa86764a95a2", #"hash_7ecbe823245c481d");
	}
	if(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b") && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_69f2d708a56d4dce");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_12cd1dd2b05b0b78", #"hash_17040e317630b65b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_4906b8fb30b2a129");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_1453e53ab79e1ca3");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_5324113c5a347f7d");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6e8a65a99293fcaa", #"hash_76d32c1253e6d6b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"hash_603aa0121556373b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1926dc7c3ce2bfb2", #"hash_13310f7937bf1713");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_3b1a45effd27050", #"hash_603aa0121556373b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_11cff4740828adb1");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_646d7b3e172b5772", #"hash_5f77f9db644aa7b2");
	}
	if(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))))
	{
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_420abeab1f0adba1");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_2cb3a37c908b9d9b", #"hash_4aba76ceb9def5c8");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_139acdd590ca3442", #"hash_e337ee5d12813");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_72083d9a8a873599");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6e8a65a99293fcaa", #"hash_6f8362fe5cab627b");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_6d90d15ce8e75ac2", #"hash_3ffbf9051e22a760");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_1926dc7c3ce2bfb2", #"hash_24f73a36dd4d10e3");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_646d7b3e172b5772", #"hash_790c3e289d5389a3");
		wz_common_fixup::function_149cbc84(var_b5014996, var_f8a4c541, #"hash_e9680c97b9d703b", #"hash_21de0b3bb1e1f5a8");
	}
}

