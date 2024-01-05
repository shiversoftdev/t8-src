// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\wz_common_fixup.csc;

#namespace namespace_96ab18d4;

/*
	Name: __init__
	Namespace: namespace_96ab18d4
	Checksum: 0x48986FAD
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
	Checksum: 0x7859A222
	Offset: 0x98
	Size: 0x2DB4
	Parameters: 0
	Flags: Linked
*/
function function_6df391ab()
{
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	if(!(isdefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_blue", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_police", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_red", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"quad_wz_vehicle_tan", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablecargotruck")) && getgametypesetting(#"wzenablecargotruck")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_dark", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"cargo_truck_wz_vehicle_tan", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelittlebird")) && getgametypesetting(#"wzenablelittlebird")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_police", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_dark", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_light_wz_vehicle_tan", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletacticalraft")) && getgametypesetting(#"wzenabletacticalraft")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_odg", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablearav")) && getgametypesetting(#"wzenablearav")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_blk", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_grn", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"fav_wz_vehicle_tan", #"");
		if(!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"open_skyscraper_vehicles_cargo_truck");
		}
	}
	if(!(isdefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_tan", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pbr_wz_vehicle_police", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_tan", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_dark", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"helicopter_attack_wz_vehicle_green", #"");
	}
	else if(!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && (!(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"open_skyscraper_vehicles_attack_heli");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_6d754bec0d9dfae7");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_blue", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_orange", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_red", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_white", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_yellow", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_bandit_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_racing_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_phantom", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_dark_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_light_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_metal_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_olive", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_tan", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"motorcycle_wz_vehicle_white", #"");
	}
	else if(isdefined(getgametypesetting(#"wzenableatv")) && getgametypesetting(#"wzenableatv") && (isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle")) && (!(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar"))) && (!(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_35aa8b10467eb39d");
	}
	if(!(isdefined(getgametypesetting(#"wzenablereplacercar")) && getgametypesetting(#"wzenablereplacercar")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"muscle_car_wz_vehicle_replacer", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_met_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_white", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_wz_vehicle_private_security", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"suv_police_wz_vehicle", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_black", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_green", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_grey", #"");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"tank_wz_vehicle_tan", #"");
	}
	else if(!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles")) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"hash_3812049990542183");
	}
	if(!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles")) && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		if(isdefined(getgametypesetting(#"wzenablemusclecar")) && getgametypesetting(#"wzenablemusclecar"))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"open_skyscraper_vehicles_muscle_car");
			if(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))
			{
				if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
				{
					wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_1df26c2b584534f0");
				}
				else
				{
					wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_6626d2dc4952331e");
				}
				if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
				{
					wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_small");
				}
				wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"open_skyscraper_vehicles_suv");
			}
			else
			{
				if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
				{
					wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_23031ef9fe71ef45");
				}
				else
				{
					wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_2174b8eb76412fb3");
				}
			}
		}
		else if(isdefined(getgametypesetting(#"wzenablesuv")) && getgametypesetting(#"wzenablesuv"))
		{
			if(isdefined(getgametypesetting(#"wzenablemotorcycle")) && getgametypesetting(#"wzenablemotorcycle"))
			{
				wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_23031ef9fe71ef45");
			}
			else
			{
				wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_2174b8eb76412fb3");
			}
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_4748761d5bf2d25a");
		}
	}
	if(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_6edfaf70ad03eaef");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_3a27bf78d24805e");
		if(!(isdefined(getgametypesetting(#"wzenableattacklittlebird")) && getgametypesetting(#"wzenableattacklittlebird")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"hash_47932c30b6d303f9");
		}
		else
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"hash_ec830fead8a57a6");
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_6d754bec0d9dfae7");
		}
		if(isdefined(getgametypesetting(#"wzenablepbr")) && getgametypesetting(#"wzenablepbr"))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"hash_346e4bfaf0aee29");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletank")) && getgametypesetting(#"wzenabletank")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"hash_3331822e00aa2879");
		}
	}
	if(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"zodiac_wz_vehicle_odg", #"zodiac_wz_vehicle_grey");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_6f6862f0792bbdf");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_6626d2dc4952331e");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"open_skyscraper_vehicles_cargo_truck_small");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"open_skyscraper_vehicles_suv");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_zodiac", #"hash_7ecbe823245c481d");
	}
	if(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b") && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))) && (!(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_69f2d708a56d4dce");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_12cd1dd2b05b0b78", #"hash_17040e317630b65b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"hash_4906b8fb30b2a129");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"hash_1453e53ab79e1ca3");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_18134e61b5fb4bd0", #"hash_5324113c5a347f7d");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav", #"hash_76d32c1253e6d6b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_77502a4dc5ec85e8", #"hash_603aa0121556373b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"hash_13310f7937bf1713");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_3b1a45effd27050", #"hash_603aa0121556373b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_11cff4740828adb1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_tank", #"hash_5f77f9db644aa7b2");
	}
	if(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles") && (!(isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b"))) && (!(isdefined(getgametypesetting(#"wzwetworks")) && getgametypesetting(#"wzwetworks"))) && (!(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles"))) && (!(isdefined(getgametypesetting(#"wzenableheavymetalvehicles")) && getgametypesetting(#"wzenableheavymetalvehicles"))) && (!(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_159e4e48721d6125", #"hash_420abeab1f0adba1");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_atv", #"hash_4aba76ceb9def5c8");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_cargo_truck", #"hash_e337ee5d12813");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"hash_19b0005ca3a8c6c", #"hash_72083d9a8a873599");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_arav", #"hash_6f8362fe5cab627b");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_heli", #"hash_3ffbf9051e22a760");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_pbr", #"hash_24f73a36dd4d10e3");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_tank", #"hash_790c3e289d5389a3");
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"open_skyscraper_vehicles_motorcycle", #"hash_21de0b3bb1e1f5a8");
	}
}

