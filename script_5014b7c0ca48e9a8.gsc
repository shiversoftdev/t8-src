// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\wz_common_fixup.gsc;

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
	var_a12b4736 = &item_world_fixup::function_96ff7b88;
	var_d2223309 = &item_world_fixup::function_261ab7f5;
	var_b5014996 = &item_world_fixup::function_19089c75;
	var_87d0eef8 = &item_world_fixup::remove_item;
	var_74257310 = &item_world_fixup::add_item_replacement;
	var_f8a4c541 = &item_world_fixup::function_6991057;
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	if(!(isdefined(getgametypesetting(#"hash_232750b87390cbff")) && getgametypesetting(#"hash_232750b87390cbff")))
	{
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyasylum")) && getgametypesetting(#"wzenablewallbuyasylum")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_asylum", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuydiner")) && getgametypesetting(#"wzenablewallbuydiner")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_diner", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuycemetary")) && getgametypesetting(#"wzenablewallbuycemetary")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_cemetary", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyfarm")) && getgametypesetting(#"wzenablewallbuyfarm")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_farm", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuynuketown")) && getgametypesetting(#"wzenablewallbuynuketown")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_nuketown", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyboxinggym")) && getgametypesetting(#"wzenablewallbuyboxinggym")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_boxing_gym", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuyghosttown")) && getgametypesetting(#"wzenablewallbuyghosttown")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_ghosttown", #"wz_open_skyscrapers_wallbuy_none");
		}
		if(!(isdefined(getgametypesetting(#"wzenablewallbuylighthouse")) && getgametypesetting(#"wzenablewallbuylighthouse")))
		{
			wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"wz_open_skyscrapers_wallbuy_guns_list_lighthouse", #"wz_open_skyscrapers_wallbuy_none");
		}
	}
	if(maxteamplayers == 1)
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_medic");
	}
	if(!(isdefined(getgametypesetting(#"wzsnowballsenabled")) && getgametypesetting(#"wzsnowballsenabled")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"wz_snowball", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzwaterballoonsenabled")) && getgametypesetting(#"wzwaterballoonsenabled")) && (!(isdefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) && getgametypesetting(#"hash_3e2d2cf6b1cc6c68"))))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"wz_waterballoon", #"");
	}
	if(isdefined(getgametypesetting(#"hash_230e67d5ddfb2c06")) && getgametypesetting(#"hash_230e67d5ddfb2c06"))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"melee_bowie_t8_item", #"melee_bloody_bowie_t8_item");
	}
	if(isdefined(getgametypesetting(#"hash_661ee23f114191c1")) && getgametypesetting(#"hash_661ee23f114191c1"))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"melee_bowie_t8_item", #"melee_bloody_bowie_t8_item");
	}
	if(isdefined(getgametypesetting(#"wztestallvehicles")) && getgametypesetting(#"wztestallvehicles"))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"equipment_list_med", #"hash_7f6ccc550b17457f");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"shotgun_fullauto_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"shotgun_pump_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"shotgun_semiauto_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pistol_fullauto_t8_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pistol_burst_t8_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pistol_revolver_t8_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"pistol_standard_t8_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_accurate_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_standard_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_fastburst_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_fastfire_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_capacity_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smg_folding_t8_item", #"launcher_standard_t8_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_12ga_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_9mm_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_45_item", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"health_item_small", #"grapple_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"health_item_medium", #"ammo_type_rocket_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_awareness", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_brawler", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_consumer", #"flare_gun_veh_wz_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_deadsilence", #"perk_item_engineer");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_ironlungs", #"perk_item_engineer");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_medic", #"perk_item_engineer");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_outlander", #"perk_item_engineer");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_paranoia", #"ammo_type_rocket_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"perk_item_squadlink", #"ammo_type_rocket_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"acog_wz_item", #"ammo_type_rocket_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"sniperscope_wz_item", #"ammo_type_rocket_item");
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"laser_sight_wz_item", #"ammo_type_rocket_item");
	}
	customgame = gamemodeismode(1) || gamemodeismode(7);
	wz_common_fixup::item_remover(var_a12b4736, undefined, #"resource_item_paint");
	if(!(isdefined(getgametypesetting(#"wzenablespraycans")) && getgametypesetting(#"wzenablespraycans")) || customgame)
	{
		wz_common_fixup::item_remover(var_87d0eef8, undefined, #"resource_item_paint");
	}
	else
	{
		maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
		if(maxteamplayers == 1)
		{
			wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"resource_item_paint_list_furniture", #"resource_item_paint_list_furniture_solo");
			wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"resource_item_paint_list", #"resource_item_paint_list_solo");
		}
	}
	if(!(isdefined(getgametypesetting(#"wzenablesecretsanta")) && getgametypesetting(#"wzenablesecretsanta")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"melee_secretsanta_t8_item", #"");
	}
	if(!(isdefined(getgametypesetting(#"wzenableslaybell")) && getgametypesetting(#"wzenableslaybell")))
	{
		wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"melee_slaybell_t8_item", #"");
	}
	if(isdefined(getgametypesetting(#"wzenablecontrabandstash")) && getgametypesetting(#"wzenablecontrabandstash"))
	{
		wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"blackjack_ammo_stash_parent_placeholder", #"blackjack_ammo_stash_parent_guns");
	}
	if(!(isdefined(getgametypesetting(#"wzenableoperatorweapons")) && getgametypesetting(#"wzenableoperatorweapons")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_operator_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_operator_item");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"wzenablemaddox")) && getgametypesetting(#"wzenablemaddox")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevapr")) && getgametypesetting(#"wzenablevapr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswordfish")) && getgametypesetting(#"wzenableswordfish")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableabr")) && getgametypesetting(#"wzenableabr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableauger")) && getgametypesetting(#"wzenableauger")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableoutlaw")) && getgametypesetting(#"wzenableoutlaw")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekoshka")) && getgametypesetting(#"wzenablekoshka")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablehades")) && getgametypesetting(#"wzenablehades")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletitan")) && getgametypesetting(#"wzenabletitan")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablegks")) && getgametypesetting(#"wzenablegks")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablespitfire")) && getgametypesetting(#"wzenablespitfire")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemozu")) && getgametypesetting(#"wzenablemozu")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_operator_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevendetta")) && getgametypesetting(#"wzenablevendetta")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_operator_item");
		}
	}
	if(!(isdefined(getgametypesetting(#"hash_5c6371ef701d7485")) && getgametypesetting(#"hash_5c6371ef701d7485")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_gold_item");
	}
	else
	{
		if(!(isdefined(getgametypesetting(#"wzenablestrife")) && getgametypesetting(#"wzenablestrife")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_standard_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemozu")) && getgametypesetting(#"wzenablemozu")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_revolver_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerk7")) && getgametypesetting(#"wzenablerk7")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_burst_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekap45")) && getgametypesetting(#"wzenablekap45")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"pistol_fullauto_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemog12")) && getgametypesetting(#"wzenablemog12")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_pump_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesg12")) && getgametypesetting(#"wzenablesg12")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_semiauto_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerampage")) && getgametypesetting(#"wzenablerampage")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"shotgun_fullauto_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesaug")) && getgametypesetting(#"wzenablesaug")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_handling_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablespitfire")) && getgametypesetting(#"wzenablespitfire")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastfire_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemx9")) && getgametypesetting(#"wzenablemx9")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_standard_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablecordite")) && getgametypesetting(#"wzenablecordite")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_capacity_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablegks")) && getgametypesetting(#"wzenablegks")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_accurate_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenabledaemon")) && getgametypesetting(#"wzenabledaemon")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_fastburst_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswitchblade")) && getgametypesetting(#"wzenableswitchblade")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"smg_folding_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableicr")) && getgametypesetting(#"wzenableicr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_accurate_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekn")) && getgametypesetting(#"wzenablekn")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_modular_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswat")) && getgametypesetting(#"wzenableswat")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_standard_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablerampart")) && getgametypesetting(#"wzenablerampart")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_damage_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablemaddox")) && getgametypesetting(#"wzenablemaddox")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_fastfire_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevapr")) && getgametypesetting(#"wzenablevapr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ar_stealth_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableswordfish")) && getgametypesetting(#"wzenableswordfish")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_longburst_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableabr")) && getgametypesetting(#"wzenableabr")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_midburst_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableauger")) && getgametypesetting(#"wzenableauger")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tr_powersemi_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevendetta")) && getgametypesetting(#"wzenablevendetta")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_mini14_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenabletitan")) && getgametypesetting(#"wzenabletitan")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_standard_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablehades")) && getgametypesetting(#"wzenablehades")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_spray_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablevkm")) && getgametypesetting(#"wzenablevkm")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"lmg_heavy_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablekoshka")) && getgametypesetting(#"wzenablekoshka")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_quickscope_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablepaladin")) && getgametypesetting(#"wzenablepaladin")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powerbolt_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenablesdm")) && getgametypesetting(#"wzenablesdm")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_powersemi_t8_gold_item");
		}
		if(!(isdefined(getgametypesetting(#"wzenableoutlaw")) && getgametypesetting(#"wzenableoutlaw")))
		{
			wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"sniper_fastrechamber_t8_gold_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenableraygunmark2")) && getgametypesetting(#"wzenableraygunmark2")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2_t8_item");
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
	if(!(isdefined(getgametypesetting(#"wzenablevivaldi")) && getgametypesetting(#"wzenablevivaldi")))
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_bowie_t8_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"death_of_orion_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"hash_5408e974098bc234")) && getgametypesetting(#"hash_5408e974098bc234")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2x_t8_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2y_t8_item");
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ray_gun_mk2z_t8_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"ww_winters_fury_t8_item");
	}
	if(!(isdefined(getgametypesetting(#"wzenablealistairsfolly")) && getgametypesetting(#"wzenablealistairsfolly")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"allistairs_folly_t8_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"melee_amulet_t8_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"flare_gun_veh_wz_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"health_item_small");
	}
	if(!(isdefined(getgametypesetting(#"wzenablemedkit")) && getgametypesetting(#"wzenablemedkit")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"health_item_medium");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletraumakit")) && getgametypesetting(#"wzenabletraumakit")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"health_item_large");
	}
	if(!(isdefined(getgametypesetting(#"wzenabletak5")) && getgametypesetting(#"wzenabletak5")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"health_item_squad");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkparanoia")) && getgametypesetting(#"wzenableperkparanoia")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_paranoia");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkconsumer")) && getgametypesetting(#"wzenableperkconsumer")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_consumer");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkironlungs")) && getgametypesetting(#"wzenableperkironlungs")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_ironlungs");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkbrawler")) && getgametypesetting(#"wzenableperkbrawler")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_brawler");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkawareness")) && getgametypesetting(#"wzenableperkawareness")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_awareness");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperklooter")) && getgametypesetting(#"wzenableperklooter")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_looter");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperksquadlink")) && getgametypesetting(#"wzenableperksquadlink")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_squadlink");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkreinforced")) && getgametypesetting(#"wzenableperkreinforced")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_reinforced");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkmedic")) && getgametypesetting(#"wzenableperkmedic")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_medic");
	}
	if(!(isdefined(getgametypesetting(#"hash_78e459ad87509a46")) && getgametypesetting(#"hash_78e459ad87509a46")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_drifter");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkdeadsilence")) && getgametypesetting(#"wzenableperkdeadsilence")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_deadsilence");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkstimulant")) && getgametypesetting(#"wzenableperkstimulant")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_stimulant");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkmobility")) && getgametypesetting(#"wzenableperkmobility")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_lightweight");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkengineer")) && getgametypesetting(#"wzenableperkengineer")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_engineer");
	}
	if(!(isdefined(getgametypesetting(#"wzenableperkoutlander")) && getgametypesetting(#"wzenableperkoutlander")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"perk_item_outlander");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv3armor")) && getgametypesetting(#"wzenablelv3armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_large");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv2armor")) && getgametypesetting(#"wzenablelv2armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_medium");
	}
	if(!(isdefined(getgametypesetting(#"wzenablelv1armor")) && getgametypesetting(#"wzenablelv1armor")))
	{
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"armor_item_small");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"advmag_wz_item");
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
		wz_common_fixup::item_remover(var_a12b4736, var_87d0eef8, #"tritium_wz_item");
	}
}

