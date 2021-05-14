// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1e34fbb210f87b6f;
#using script_6ad3fda349f49bf9;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\character_customization.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\dialog_shared.csc;
#using scripts\core_common\serverfield_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace draft;

/*
	Name: function_89f2df9
	Namespace: draft
	Checksum: 0x19315C36
	Offset: 0x3218
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"draft", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: draft
	Checksum: 0x44295C9E
	Offset: 0x3260
	Size: 0xB8E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "draft", 1, 3, "int", &handledraftstage, 0, 0);
	clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int", undefined, 0, 0);
	serverfield::register("PositionDraft.uiLoaded", 1, 1, "int");
	level.var_a968beb = [];
	level.var_a968beb[0] = #"free";
	level.var_a968beb[1] = #"allies";
	level.var_a968beb[2] = #"axis";
	level.var_8cb8d474 = [];
	level.var_8cb8d474[#"free"] = [];
	level.var_8cb8d474[#"free"][0] = #"hash_6eb882c3b52cdbb3";
	level.var_8cb8d474[#"free"][2] = #"hash_6eb881c3b52cda00";
	level.var_8cb8d474[#"free"][1] = #"hash_6eb884c3b52cdf19";
	level.var_8cb8d474[#"free"][3] = #"hash_6eb883c3b52cdd66";
	level.var_8cb8d474[#"free"][4] = #"hash_6eb886c3b52ce27f";
	level.var_8cb8d474[#"allies"] = [];
	level.var_8cb8d474[#"allies"][0] = #"hash_3de928cb4eca5c62";
	level.var_8cb8d474[#"allies"][2] = #"hash_14207ac052338b77";
	level.var_8cb8d474[#"allies"][1] = #"hash_2da80819aca61444";
	level.var_8cb8d474[#"allies"][3] = #"hash_477e5761fdabcb19";
	level.var_8cb8d474[#"allies"][4] = #"hash_42145b8ebbfee26";
	level.var_8cb8d474[#"axis"] = [];
	level.var_8cb8d474[#"axis"][0] = #"hash_3b2607cfca030035";
	level.var_8cb8d474[#"axis"][2] = #"hash_253fd3975ea7547c";
	level.var_8cb8d474[#"axis"][1] = #"hash_1edd5ff5456df7f7";
	level.var_8cb8d474[#"axis"][3] = #"hash_61f816d9a00b29c6";
	level.var_8cb8d474[#"axis"][4] = #"hash_753a11f84aa8941";
	level.var_a72b250f = [];
	level.var_a72b250f[#"free"] = #"hash_24d789c80dba10e6";
	level.var_a72b250f[#"allies"] = #"hash_e2e52f9cab15dce";
	level.var_a72b250f[#"axis"] = #"hash_50c9ef9e41155cf9";
	level.var_a72b250f[#"spectator"] = #"hash_e2e52f9cab15dce";
	level.var_f7fb38f8 = [];
	level.var_f7fb38f8[#"free"] = #"draft_team_struct";
	level.var_f7fb38f8[#"allies"] = #"hash_4fb87afe0caa6177";
	level.var_f7fb38f8[#"axis"] = #"hash_700492f71a083a7c";
	level.var_f7fb38f8[#"spectator"] = #"hash_4fb87afe0caa6177";
	level.var_1f0933dc = [];
	level.var_1f0933dc[#"allies"] = "mp_draft_lights_allies";
	level.var_1f0933dc[#"axis"] = "mp_draft_lights_axis";
	level.var_eeee7da4 = undefined;
	level.playerscriptstructs = [];
	level.playerscriptstructs[#"free"] = [];
	level.playerscriptstructs[#"allies"] = [];
	level.playerscriptstructs[#"axis"] = [];
	for(i = 0; i < 5; i++)
	{
		level.playerscriptstructs[#"free"][i] = struct::get(level.var_8cb8d474[#"free"][i]);
		level.playerscriptstructs[#"allies"][i] = struct::get(level.var_8cb8d474[#"allies"][i]);
		level.playerscriptstructs[#"axis"][i] = struct::get(level.var_8cb8d474[#"axis"][i]);
	}
	level thread function_ca03ab69();
	level thread function_91858511();
	level.draftstage = 0;
	level.draftcharacters = [];
	level.draftactive = [];
	level.var_368aaeb9 = [];
	level.var_df72fe54 = [];
	level.draftintroplayed = [];
	for(i = 0; i < getmaxlocalclients(); i++)
	{
		level.draftactive[i] = 0;
		level.draftintroplayed[i] = 0;
		level.var_368aaeb9[i] = "";
		level.var_df72fe54[i] = "";
		for(t = 0; t < level.var_a968beb.size; t++)
		{
			level.draftcharacters[i][level.var_a968beb[t]] = [];
		}
	}
	autoselectcharacter = getdvarint(#"auto_select_character", -1);
	if(player_role::is_valid(autoselectcharacter))
	{
		clearstreamerloadinghints();
	}
	level.var_8c099032 = getgametypesetting(#"draftenabled") && !getroundsplayed(0);
	level.var_f35699bc = [#"hash_68a980198a51e72b":"melee_actionfigure", #"melee_zombiearm_t8":"melee_backhand", #"special_ballisticknife_t8_dw_dw":"melee_alt", #"special_ballisticknife_t8_dw":"melee_alt", #"melee_cutlass_t8":"melee_alt", #"melee_club_t8":"melee_alt", #"melee_demohammer_t8":"melee_alt", #"melee_coinbag_t8":"melee_alt", #"melee_secretsanta_t8":"melee_alt", #"melee_slaybell_t8":"melee_alt"];
}

/*
	Name: function_c4dfe16e
	Namespace: draft
	Checksum: 0x61A89DAB
	Offset: 0x3DF8
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_c4dfe16e(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	var_86012318 = function_b2272884();
	if(!var_86012318 && localplayer.team != #"free")
	{
		return #"allies";
	}
	return localplayer.team;
}

/*
	Name: function_75442e78
	Namespace: draft
	Checksum: 0x6F01924E
	Offset: 0x3E98
	Size: 0x62
	Parameters: 2
	Flags: None
*/
function function_75442e78(team, index)
{
	if(!isdefined(level.var_8cb8d474[team]))
	{
		team = #"free";
	}
	return struct::get(level.var_8cb8d474[team][index]);
}

/*
	Name: play_intro_cinematic
	Namespace: draft
	Checksum: 0x5CC758C1
	Offset: 0x3F08
	Size: 0x272
	Parameters: 1
	Flags: Linked
*/
function play_intro_cinematic(localclientnum)
{
	if(isdefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum])
	{
		return 0;
	}
	team = function_c4dfe16e(localclientnum);
	if(isdefined(level.var_a72b250f[team]))
	{
		var_17e3fc35 = struct::get(level.var_a72b250f[team]);
		if(isdefined(var_17e3fc35) && isdefined(level.var_99ef4320) && isdefined(level.var_99ef4320[team]))
		{
			level.var_368aaeb9[localclientnum] = "cam_draft_intro";
			playmaincamxcam(localclientnum, level.var_99ef4320[team], 0, "cam_draft_intro", "", var_17e3fc35.origin, var_17e3fc35.angles);
			duration = getcamanimtime(level.var_99ef4320[team]);
			wait(float(duration) / 1000);
			level.draftintroplayed[localclientnum] = 1;
		}
	}
	setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "PositionDraft.introPlayed"), 1);
	if(team == #"spectator")
	{
		function_532dfc0b(localclientnum, 0);
	}
	else
	{
		function_e79c182b(localclientnum, 0);
		if(isdefined(level.var_a72b250f[team]))
		{
			function_26c00d58(localclientnum);
		}
	}
	return isdefined(level.draftintroplayed[localclientnum]) && level.draftintroplayed[localclientnum];
}

/*
	Name: function_469f6fc7
	Namespace: draft
	Checksum: 0x77CE5FE7
	Offset: 0x4188
	Size: 0x1BA
	Parameters: 4
	Flags: Linked
*/
function function_469f6fc7(localclientnum, xcam, animname, lerpduration)
{
	if(isdefined(level.var_84e5adfd) && level.var_84e5adfd)
	{
		return;
	}
	if(!isdefined(xcam) || !isdefined(animname))
	{
		return;
	}
	if(isdefined(level.var_368aaeb9[localclientnum]) && level.var_368aaeb9[localclientnum] == animname && isdefined(level.var_df72fe54[localclientnum]) && level.var_df72fe54[localclientnum] == xcam)
	{
		return;
	}
	if(shoutcaster::is_shoutcaster(localclientnum))
	{
		lerpduration = 0;
	}
	team = function_c4dfe16e(localclientnum);
	if(isdefined(level.var_f7fb38f8[team]))
	{
		var_390a1a64 = struct::get(level.var_f7fb38f8[team], "targetname");
		if(isdefined(var_390a1a64))
		{
			playmaincamxcam(localclientnum, xcam, lerpduration, animname, "", var_390a1a64.origin, var_390a1a64.angles);
			level.var_368aaeb9[localclientnum] = animname;
			level.var_df72fe54[localclientnum] = xcam;
		}
	}
}

/*
	Name: function_e1e243c1
	Namespace: draft
	Checksum: 0xF15E68EC
	Offset: 0x4350
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_e1e243c1(localclientnum)
{
	stopmaincamxcam(localclientnum);
	level.var_368aaeb9[localclientnum] = undefined;
	level.var_df72fe54[localclientnum] = undefined;
}

/*
	Name: function_532dfc0b
	Namespace: draft
	Checksum: 0x90093316
	Offset: 0x43A0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_532dfc0b(localclientnum, lerpduration)
{
	function_469f6fc7(localclientnum, level.var_482af62e, "cam_draft_zoom", lerpduration);
}

/*
	Name: function_e79c182b
	Namespace: draft
	Checksum: 0x86EDB503
	Offset: 0x43E8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_e79c182b(localclientnum, lerpduration)
{
	function_469f6fc7(localclientnum, level.var_bbb8810e, "cam_draft_ingame", lerpduration);
}

/*
	Name: function_fccaf2ed
	Namespace: draft
	Checksum: 0x1308E40A
	Offset: 0x4430
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_fccaf2ed(localclientnum, lerpduration)
{
	function_469f6fc7(localclientnum, "ui_cam_frontend_loadout_mp", "cam_loadout_mp", lerpduration);
}

/*
	Name: function_1dccd222
	Namespace: draft
	Checksum: 0xB75654DF
	Offset: 0x4478
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_1dccd222(localclientnum)
{
	team = function_c4dfe16e(localclientnum);
	if(isdefined(level.var_1f0933dc[team]))
	{
		level.var_eeee7da4 = level.var_1f0933dc[team];
		playradiantexploder(localclientnum, level.var_eeee7da4);
	}
}

/*
	Name: function_2c486f35
	Namespace: draft
	Checksum: 0x3FFA44B
	Offset: 0x4500
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_2c486f35(localclientnum)
{
	if(isdefined(level.var_eeee7da4))
	{
		killradiantexploder(localclientnum, level.var_eeee7da4);
		level.var_eeee7da4 = undefined;
	}
}

/*
	Name: handledraftstage
	Namespace: draft
	Checksum: 0x3E6D49C0
	Offset: 0x4550
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function handledraftstage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(newval))
	{
		controllermodel = getuimodelforcontroller(localclientnum);
		var_a5976120 = createuimodel(controllermodel, "PositionDraft.stage");
		setuimodelvalue(var_a5976120, newval);
		level.draftstage = newval;
		if(newval != 0)
		{
			level.var_8c099032 = undefined;
		}
	}
	if(oldval != 0 && newval == 0)
	{
		killstreak_detect::function_3eff7815(localclientnum);
		killstreak_detect::function_32c8b999(localclientnum);
	}
}

/*
	Name: function_799e0ac1
	Namespace: draft
	Checksum: 0x9972830D
	Offset: 0x4670
	Size: 0xFE
	Parameters: 3
	Flags: Linked
*/
function function_799e0ac1(localclientnum, var_d0c67621, masked)
{
	if(masked && (!(isdefined([[ var_d0c67621 ]]->function_82e05d64().masked) && [[ var_d0c67621 ]]->function_82e05d64().masked)))
	{
		[[ var_d0c67621 ]]->function_27945cb8(1);
		[[ var_d0c67621 ]]->function_82e05d64().masked = 1;
	}
	else if(!masked && (isdefined([[ var_d0c67621 ]]->function_82e05d64().masked) && [[ var_d0c67621 ]]->function_82e05d64().masked))
	{
		[[ var_d0c67621 ]]->function_27945cb8(0);
		[[ var_d0c67621 ]]->function_82e05d64().masked = 0;
	}
}

/*
	Name: function_236a944e
	Namespace: draft
	Checksum: 0x6DDC3F11
	Offset: 0x4778
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_236a944e(localclientnum)
{
	team = function_c4dfe16e(localclientnum);
	foreach(character in level.draftcharacters[localclientnum][team])
	{
		if([[ character ]]->function_82e05d64().showmodel)
		{
			[[ character ]]->show_model();
		}
	}
}

/*
	Name: function_26c00d58
	Namespace: draft
	Checksum: 0x5E3985D3
	Offset: 0x4848
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_26c00d58(localclientnum)
{
	team = function_c4dfe16e(localclientnum);
	foreach(character in level.draftcharacters[localclientnum][team])
	{
		[[ character ]]->hide_model();
	}
}

/*
	Name: function_b139ecfb
	Namespace: draft
	Checksum: 0x3C37DC7A
	Offset: 0x4900
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function function_b139ecfb(localclientnum)
{
	team = function_c4dfe16e(localclientnum);
	for(i = 0; i < level.draftcharacters[localclientnum][team].size; i++)
	{
		character = level.draftcharacters[localclientnum][team][i];
		var_2d0192e5 = [[ character ]]->function_82e05d64();
		if(var_2d0192e5.islocalclient && var_2d0192e5.showmodel)
		{
			[[ character ]]->show_model();
			continue;
		}
		[[ character ]]->hide_model();
	}
}

/*
	Name: function_1cf2437c
	Namespace: draft
	Checksum: 0x72DD7A0C
	Offset: 0x49F8
	Size: 0x14C
	Parameters: 4
	Flags: Linked
*/
function function_1cf2437c(localclientnum, var_d0c67621, var_c0286f82, var_121d6e9a)
{
	if(!isdefined([[ var_d0c67621 ]]->function_82e05d64().player))
	{
		return;
	}
	if([[ var_d0c67621 ]]->function_82e05d64().localclientnum === localclientnum && isdefined([[ var_d0c67621 ]]->function_82e05d64().var_c018da16) && player_role::is_valid([[ var_d0c67621 ]]->function_82e05d64().var_c018da16.charactertype))
	{
		if(isdefined(level.var_aefa616f) && level.var_aefa616f && dialog_shared::dialog_chance("characterSelectMaldivesChance"))
		{
			[[ var_d0c67621 ]]->function_82e05d64().player dialog_shared::play_dialog("maldivesCharacterSelectOverride", localclientnum);
		}
		else
		{
			[[ var_d0c67621 ]]->function_82e05d64().player dialog_shared::play_dialog("characterSelect", localclientnum);
		}
	}
}

/*
	Name: function_bb0565d0
	Namespace: draft
	Checksum: 0xDF6B0DEF
	Offset: 0x4B50
	Size: 0x1E14
	Parameters: 1
	Flags: Linked
*/
function function_bb0565d0(var_de58f286)
{
	var_e78b2a99 = "default";
	weapon = var_de58f286.activeweapon;
	if(isdefined(weapon))
	{
		weapon_group = function_e2703c27(weapon);
		if(isdefined(level.var_f35699bc[weapon.name]))
		{
			var_e78b2a99 = level.var_f35699bc[weapon.name];
		}
		else if(weapon_group == #"")
		{
			var_e78b2a99 = "brawler";
			dualwield = getweapon(#"hash_1b055fadc5573c29");
			if(weapon.name == dualwield.name)
			{
				var_e78b2a99 = "pistol";
			}
		}
		else if(weapon_group == #"weapon_launcher" || weapon_group == #"weapon_launcher_alt")
		{
			var_e78b2a99 = "launcher";
		}
		else if(weapon_group == #"weapon_pistol" || weapon_group == #"weapon_pistol_dw")
		{
			var_e78b2a99 = "pistol";
		}
		else if(weapon_group == #"weapon_smg")
		{
			var_e78b2a99 = "smg";
		}
		else if(weapon_group == #"weapon_knife")
		{
			var_e78b2a99 = "melee";
		}
	}
	return associativearray(#"default", associativearray(#"select", associativearray(#"male", "pb_rifle_male_draft_ch_select_3", #"female", "pb_rifle_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_rifle_male_draft_select_to_preready_3", #"female", "pb_rifle_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_rifle_male_draft_preready_to_select_3", #"female", "pb_rifle_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5"), #"female", array("pb_rifle_fem_draft_preready_1", "pb_rifle_fem_draft_preready_2", "pb_rifle_fem_draft_preready_3", "pb_rifle_fem_draft_preready_4", "pb_rifle_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_rifle_male_draft_transition_1", "pb_rifle_male_draft_transition_2", "pb_rifle_male_draft_transition_3", "pb_rifle_male_draft_transition_4", "pb_rifle_male_draft_transition_5"), #"female", array("pb_rifle_fem_draft_transition_1", "pb_rifle_fem_draft_transition_2", "pb_rifle_fem_draft_transition_3", "pb_rifle_fem_draft_transition_4", "pb_rifle_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_rifle_male_draft_readyup_1", "pb_rifle_male_draft_readyup_2", "pb_rifle_male_draft_readyup_3", "pb_rifle_male_draft_readyup_4", "pb_rifle_male_draft_readyup_5"), #"female", array("pb_rifle_fem_draft_readyup_1", "pb_rifle_fem_draft_readyup_2", "pb_rifle_fem_draft_readyup_3", "pb_rifle_fem_draft_readyup_4", "pb_rifle_fem_draft_readyup_5"))), #"brawler", associativearray(#"select", associativearray(#"male", "pb_brawler_male_draft_idle_ch_select_3", #"female", "pb_brawler_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_brawler_male_draft_select_to_preready_3", #"female", "pb_brawler_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_brawler_male_draft_preready_to_select_3", #"female", "pb_brawler_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_brawler_male_draft_idle_preready1", "pb_brawler_male_draft_idle_preready2", "pb_brawler_male_draft_idle_preready3", "pb_brawler_male_draft_idle_preready4", "pb_brawler_male_draft_idle_preready5"), #"female", array("pb_brawler_fem_draft_idle_preready1", "pb_brawler_fem_draft_idle_preready2", "pb_brawler_fem_draft_idle_preready3", "pb_brawler_fem_draft_idle_preready4", "pb_brawler_fem_draft_idle_preready5")), #"ready", associativearray(#"male", array("pb_brawler_male_draft_idle_transition_1", "pb_brawler_male_draft_idle_transition_2", "pb_brawler_male_draft_idle_transition_3", "pb_brawler_male_draft_idle_transition_4", "pb_brawler_male_draft_idle_transition_5"), #"female", array("pb_brawler_fem_draft_idle_transition_1", "pb_brawler_fem_draft_idle_transition_2", "pb_brawler_fem_draft_idle_transition_3", "pb_brawler_fem_draft_idle_transition_4", "pb_brawler_fem_draft_idle_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_brawler_male_draft_readyup_1", "pb_brawler_male_draft_readyup_2", "pb_brawler_male_draft_readyup_3", "pb_brawler_male_draft_readyup_4", "pb_brawler_male_draft_readyup_5"), #"female", array("pb_brawler_fem_draft_readyup_1", "pb_brawler_fem_draft_readyup_2", "pb_brawler_fem_draft_readyup_3", "pb_brawler_fem_draft_readyup_4", "pb_brawler_fem_draft_readyup_5"))), #"melee", associativearray(#"select", associativearray(#"male", "pb_melee_male_draft_ch_select_3", #"female", "pb_melee_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_melee_male_draft_select_to_preready_3", #"female", "pb_melee_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_melee_male_draft_preready_to_select_3", #"female", "pb_melee_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_melee_male_draft_preready_1", "pb_melee_male_draft_preready_2", "pb_melee_male_draft_preready_3", "pb_melee_male_draft_preready_4", "pb_melee_male_draft_preready_5"), #"female", array("pb_melee_fem_draft_preready_1", "pb_melee_fem_draft_preready_2", "pb_melee_fem_draft_preready_3", "pb_melee_fem_draft_preready_4", "pb_melee_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_melee_male_draft_transition_1", "pb_melee_male_draft_transition_2", "pb_melee_male_draft_transition_3", "pb_melee_male_draft_transition_4", "pb_melee_male_draft_transition_5"), #"female", array("pb_melee_fem_draft_transition_1", "pb_melee_fem_draft_transition_2", "pb_melee_fem_draft_transition_3", "pb_melee_fem_draft_transition_4", "pb_melee_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_melee_male_draft_readyup_1", "pb_melee_male_draft_readyup_2", "pb_melee_male_draft_readyup_3", "pb_melee_male_draft_readyup_4", "pb_melee_male_draft_readyup_5"), #"female", array("pb_melee_fem_draft_readyup_1", "pb_melee_fem_draft_readyup_2", "pb_melee_fem_draft_readyup_3", "pb_melee_fem_draft_readyup_4", "pb_melee_fem_draft_readyup_5"))), #"melee_alt", associativearray(#"select", associativearray(#"male", "pb_melee_alt_male_draft_ch_select_3", #"female", "pb_melee_alt_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_melee_alt_male_draft_select_to_preready_3", #"female", "pb_melee_alt_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_melee_alt_male_draft_preready_to_select_3", #"female", "pb_melee_alt_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_melee_alt_male_draft_preready_1", "pb_melee_alt_male_draft_preready_2", "pb_melee_alt_male_draft_preready_3", "pb_melee_alt_male_draft_preready_4", "pb_melee_alt_male_draft_preready_5"), #"female", array("pb_melee_alt_fem_draft_preready_1", "pb_melee_alt_fem_draft_preready_2", "pb_melee_alt_fem_draft_preready_3", "pb_melee_alt_fem_draft_preready_4", "pb_melee_alt_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_melee_alt_male_draft_transition_1", "pb_melee_alt_male_draft_transition_2", "pb_melee_alt_male_draft_transition_3", "pb_melee_alt_male_draft_transition_4", "pb_melee_alt_male_draft_transition_5"), #"female", array("pb_melee_alt_fem_draft_transition_1", "pb_melee_alt_fem_draft_transition_2", "pb_melee_alt_fem_draft_transition_3", "pb_melee_alt_fem_draft_transition_4", "pb_melee_alt_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_melee_alt_male_draft_readyup_1", "pb_melee_alt_male_draft_readyup_2", "pb_melee_alt_male_draft_readyup_3", "pb_melee_alt_male_draft_readyup_4", "pb_melee_alt_male_draft_readyup_5"), #"female", array("pb_melee_alt_fem_draft_readyup_1", "pb_melee_alt_fem_draft_readyup_2", "pb_melee_alt_fem_draft_readyup_3", "pb_melee_alt_fem_draft_readyup_4", "pb_melee_alt_fem_draft_readyup_5"))), #"melee_backhand", associativearray(#"select", associativearray(#"male", "pb_backhander_male_draft_ch_select_3", #"female", "pb_backhander_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_backhander_male_draft_select_to_preready_3", #"female", "pb_backhander_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_backhander_male_draft_preready_to_select_3", #"female", "pb_backhander_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_backhander_male_draft_preready_1", "pb_backhander_male_draft_preready_2", "pb_backhander_male_draft_preready_3", "pb_backhander_male_draft_preready_4", "pb_backhander_male_draft_preready_5"), #"female", array("pb_backhander_fem_draft_preready_1", "pb_backhander_fem_draft_preready_2", "pb_backhander_fem_draft_preready_3", "pb_backhander_fem_draft_preready_4", "pb_backhander_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_backhander_male_draft_transition_1", "pb_backhander_male_draft_transition_2", "pb_backhander_male_draft_transition_3", "pb_backhander_male_draft_transition_4", "pb_backhander_male_draft_transition_5"), #"female", array("pb_backhander_fem_draft_transition_1", "pb_backhander_fem_draft_transition_2", "pb_backhander_fem_draft_transition_3", "pb_backhander_fem_draft_transition_4", "pb_backhander_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_backhander_male_draft_readyup_1", "pb_backhander_male_draft_readyup_2", "pb_backhander_male_draft_readyup_3", "pb_backhander_male_draft_readyup_4", "pb_backhander_male_draft_readyup_5"), #"female", array("pb_backhander_fem_draft_readyup_1", "pb_backhander_fem_draft_readyup_2", "pb_backhander_fem_draft_readyup_3", "pb_backhander_fem_draft_readyup_4", "pb_backhander_fem_draft_readyup_5"))), #"melee_actionfigure", associativearray(#"select", associativearray(#"male", "pb_action_figure_male_draft_ch_select_3", #"female", "pb_action_figure_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_action_figure_male_draft_select_to_preready_3", #"female", "pb_action_figure_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_action_figure_male_draft_preready_to_select_3", #"female", "pb_action_figure_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_action_figure_male_draft_preready_1", "pb_action_figure_male_draft_preready_2", "pb_action_figure_male_draft_preready_3", "pb_action_figure_male_draft_preready_4", "pb_action_figure_male_draft_preready_5"), #"female", array("pb_action_figure_fem_draft_preready_1", "pb_action_figure_fem_draft_preready_2", "pb_action_figure_fem_draft_preready_3", "pb_action_figure_fem_draft_preready_4", "pb_action_figure_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_action_figure_male_draft_transition_1", "pb_action_figure_male_draft_transition_2", "pb_action_figure_male_draft_transition_3", "pb_action_figure_male_draft_transition_4", "pb_action_figure_male_draft_transition_5"), #"female", array("pb_action_figure_fem_draft_transition_1", "pb_action_figure_fem_draft_transition_2", "pb_action_figure_fem_draft_transition_3", "pb_action_figure_fem_draft_transition_4", "pb_action_figure_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_action_figure_male_draft_readyup_1", "pb_action_figure_male_draft_readyup_2", "pb_action_figure_male_draft_readyup_3", "pb_action_figure_male_draft_readyup_4", "pb_action_figure_male_draft_readyup_5"), #"female", array("pb_action_figure_fem_draft_readyup_1", "pb_action_figure_fem_draft_readyup_2", "pb_action_figure_fem_draft_readyup_3", "pb_action_figure_fem_draft_readyup_4", "pb_action_figure_fem_draft_readyup_5"))), #"launcher", associativearray(#"select", associativearray(#"male", "pb_launcher_male_draft_ch_select_3", #"female", "pb_launcher_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_launcher_male_draft_select_to_preready_3", #"female", "pb_launcher_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_launcher_male_draft_preready_to_select_3", #"female", "pb_launcher_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_launcher_male_draft_preready1", "pb_launcher_male_draft_preready2", "pb_launcher_male_draft_preready3", "pb_launcher_male_draft_preready4", "pb_launcher_male_draft_preready5"), #"female", array("pb_launcher_fem_draft_ch_preready_1", "pb_launcher_fem_draft_ch_preready_2", "pb_launcher_fem_draft_ch_preready_3", "pb_launcher_fem_draft_ch_preready_4", "pb_launcher_fem_draft_ch_preready_5")), #"ready", associativearray(#"male", array("pb_launcher_male_draft_transition_1", "pb_launcher_male_draft_transition_2", "pb_launcher_male_draft_transition_3", "pb_launcher_male_draft_transition_4", "pb_launcher_male_draft_transition_5"), #"female", array("pb_launcher_fem_draft_transition_1", "pb_launcher_fem_draft_transition_2", "pb_launcher_fem_draft_transition_3", "pb_launcher_fem_draft_transition_4", "pb_launcher_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_launcher_male_draft_readyup_1", "pb_launcher_male_draft_readyup_2", "pb_launcher_male_draft_readyup_3", "pb_launcher_male_draft_readyup_4", "pb_launcher_male_draft_readyup_5"), #"female", array("pb_launcher_fem_draft_readyup_1", "pb_launcher_fem_draft_readyup_2", "pb_launcher_fem_draft_readyup_3", "pb_launcher_fem_draft_readyup_4", "pb_launcher_fem_draft_readyup_5"))), #"pistol", associativearray(#"select", associativearray(#"male", "pb_pistol_male_draft_ch_select_3", #"female", "pb_pistol_fem_draft_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_pistol_male_draft_select_to_preready_3", #"female", "pb_pistol_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_pistol_male_draft_preready_to_select_3", #"female", "pb_pistol_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_pistol_male_draft_preready_1", "pb_pistol_male_draft_preready_2", "pb_pistol_male_draft_preready_3", "pb_pistol_male_draft_preready_4", "pb_pistol_male_draft_preready_5"), #"female", array("pb_pistol_fem_draft_preready_1", "pb_pistol_fem_draft_preready_2", "pb_pistol_fem_draft_preready_3", "pb_pistol_fem_draft_preready_4", "pb_pistol_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_pistol_male_draft_transition_1", "pb_pistol_male_draft_transition_2", "pb_pistol_male_draft_transition_3", "pb_pistol_male_draft_transition_4", "pb_pistol_male_draft_transition_5"), #"female", array("pb_pistol_fem_draft_transition_1", "pb_pistol_fem_draft_transition_2", "pb_pistol_fem_draft_transition_3", "pb_pistol_fem_draft_transition_4", "pb_pistol_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_pistol_male_draft_readyup_1", "pb_pistol_male_draft_readyup_2", "pb_pistol_male_draft_readyup_3", "pb_pistol_male_draft_readyup_4", "pb_pistol_male_draft_readyup_5"), #"female", array("pb_pistol_fem_draft_readyup_1", "pb_pistol_fem_draft_readyup_2", "pb_pistol_fem_draft_readyup_3", "pb_pistol_fem_draft_readyup_4", "pb_pistol_fem_draft_readyup_5"))), #"smg", associativearray(#"select", associativearray(#"male", "pb_smg_male_draft_idle_ch_select_3", #"female", "pb_smg_fem_draft_idle_ch_select_3"), #"hash_6eaac8719751cb14", associativearray(#"male", "pb_smg_male_draft_select_to_preready_3", #"female", "pb_smg_fem_draft_select_to_preready_3"), #"hash_2fe61241a25ee67c", associativearray(#"male", "pb_smg_male_draft_preready_to_select_3", #"female", "pb_smg_fem_draft_preready_to_select_3"), #"hash_173d4186160f785", associativearray(#"male", array("pb_smg_male_draft_preready_1", "pb_smg_male_draft_preready_2", "pb_smg_male_draft_preready_3", "pb_smg_male_draft_preready_4", "pb_smg_male_draft_preready_5"), #"female", array("pb_smg_fem_draft_preready_1", "pb_smg_fem_draft_preready_2", "pb_smg_fem_draft_preready_3", "pb_smg_fem_draft_preready_4", "pb_smg_fem_draft_preready_5")), #"ready", associativearray(#"male", array("pb_smg_male_draft_transition_1", "pb_smg_male_draft_transition_2", "pb_smg_male_draft_transition_3", "pb_smg_male_draft_transition_4", "pb_smg_male_draft_transition_5"), #"female", array("pb_smg_fem_draft_transition_1", "pb_smg_fem_draft_transition_2", "pb_smg_fem_draft_transition_3", "pb_smg_fem_draft_transition_4", "pb_smg_fem_draft_transition_5")), #"hash_47427a985c282f7e", associativearray(#"male", array("pb_smg_male_draft_readyup_1", "pb_smg_male_draft_readyup_2", "pb_smg_male_draft_readyup_3", "pb_smg_male_draft_readyup_4", "pb_smg_male_draft_readyup_5"), #"female", array("pb_smg_fem_draft_readyup_1", "pb_smg_fem_draft_readyup_2", "pb_smg_fem_draft_readyup_3", "pb_smg_fem_draft_readyup_4", "pb_smg_fem_draft_readyup_5"))))[var_e78b2a99];
}

/*
	Name: function_6b532f83
	Namespace: draft
	Checksum: 0x6F612938
	Offset: 0x6970
	Size: 0x44E
	Parameters: 3
	Flags: Linked
*/
function function_6b532f83(localclientnum, var_de58f286, sessionmode)
{
	var_7eb5dfe9 = var_de58f286.positionindex;
	anim_intro_name = undefined;
	anim_name = undefined;
	var_799bae98 = function_bb0565d0(var_de58f286);
	if(isdefined(var_de58f286.var_625ec6da) && player_role::is_valid(var_de58f286.var_625ec6da.charactertype))
	{
		if(!isdefined(var_de58f286) || !isdefined(var_de58f286.var_91065a59) || !isdefined(var_de58f286.var_3afd181d))
		{
			/#
				assert(isdefined(var_de58f286));
			#/
			/#
				assert(isdefined(var_de58f286.var_91065a59));
			#/
			/#
				assert(isdefined(var_de58f286.var_3afd181d));
			#/
			return;
		}
		gender = getherogender(var_de58f286.var_625ec6da.charactertype, sessionmode);
		if(var_de58f286.var_91065a59 != var_de58f286.var_3afd181d)
		{
			if(var_de58f286.var_91065a59)
			{
				var_ca1716fe = var_799bae98[#"ready"][gender];
				anim_intro_name = var_ca1716fe[var_7eb5dfe9 % var_ca1716fe.size];
				var_177782dd = var_799bae98[#"hash_47427a985c282f7e"][gender];
				anim_name = var_177782dd[var_7eb5dfe9 % var_177782dd.size];
			}
			var_de58f286.var_3afd181d = var_de58f286.var_91065a59;
		}
		else if(player_role::is_valid(var_de58f286.focusedcharacterindex))
		{
			if(var_de58f286.selected)
			{
				anim_intro_name = var_799bae98[#"hash_2fe61241a25ee67c"][gender];
				var_de58f286.selected = 0;
			}
			anim_name = var_799bae98[#"select"][gender];
		}
		else if(!var_de58f286.var_91065a59)
		{
			if(var_7eb5dfe9 == 1 && !shoutcaster::is_shoutcaster(localclientnum))
			{
				anim_intro_name = var_799bae98[#"hash_6eaac8719751cb14"][gender];
			}
			var_b793aad = var_799bae98[#"hash_173d4186160f785"][gender];
			anim_name = var_b793aad[var_7eb5dfe9 % var_b793aad.size];
		}
		else
		{
			var_ca1716fe = var_799bae98[#"ready"][gender];
			anim_intro_name = var_ca1716fe[var_7eb5dfe9 % var_ca1716fe.size];
			var_177782dd = var_799bae98[#"hash_47427a985c282f7e"][gender];
			anim_name = var_177782dd[var_7eb5dfe9 % var_177782dd.size];
		}
		var_de58f286.selected = 1;
	}
	else
	{
		anim_name = array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5")[var_7eb5dfe9 % array("pb_rifle_male_draft_preready_1", "pb_rifle_male_draft_preready_2", "pb_rifle_male_draft_preready_3", "pb_rifle_male_draft_preready_4", "pb_rifle_male_draft_preready_5").size];
	}
	var_de58f286.params.anim_intro_name = anim_intro_name;
	var_de58f286.params.anim_name = anim_name;
}

/*
	Name: function_93a4f3c5
	Namespace: draft
	Checksum: 0x7257A282
	Offset: 0x6DC8
	Size: 0x238
	Parameters: 2
	Flags: Linked
*/
function function_93a4f3c5(localclientnum, var_d0c67621)
{
	sessionmode = currentsessionmode();
	var_de58f286 = [[ var_d0c67621 ]]->function_82e05d64();
	if(player_role::is_valid(var_de58f286.focusedcharacterindex))
	{
		var_3f83e0ee = character_customization::function_7474681d(localclientnum, sessionmode, [[ var_d0c67621 ]]->function_82e05d64().focusedcharacterindex);
		if(!character_customization::function_aa5382ed(var_de58f286.var_625ec6da, var_3f83e0ee))
		{
			return 0;
		}
		[[ var_d0c67621 ]]->function_82e05d64().var_625ec6da = var_3f83e0ee;
	}
	else if(!isdefined(var_de58f286.var_625ec6da) || character_customization::function_aa5382ed(var_de58f286.var_625ec6da, var_de58f286.var_c018da16))
	{
		function_1cf2437c(localclientnum, var_d0c67621, var_de58f286.var_625ec6da, var_de58f286.var_c018da16);
		var_de58f286.var_625ec6da = var_de58f286.var_c018da16;
	}
	if(isdefined(var_de58f286.var_625ec6da) && player_role::is_valid(var_de58f286.var_625ec6da.charactertype))
	{
		[[ var_d0c67621 ]]->function_1ec9448d(0);
		[[ var_d0c67621 ]]->function_15a8906a([[ var_d0c67621 ]]->function_82e05d64().var_625ec6da);
		function_799e0ac1(localclientnum, var_d0c67621, 0);
	}
	else
	{
		[[ var_d0c67621 ]]->function_1ec9448d(1);
		[[ var_d0c67621 ]]->function_72e88afb(0);
		function_799e0ac1(localclientnum, var_d0c67621, 1);
	}
	return 1;
}

/*
	Name: function_2dfe152c
	Namespace: draft
	Checksum: 0x9258CC10
	Offset: 0x7008
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_2dfe152c(localclientnum, var_d0c67621, oldweapon, newweapon)
{
}

/*
	Name: function_4ccc033d
	Namespace: draft
	Checksum: 0x5E942A2E
	Offset: 0x7038
	Size: 0x212
	Parameters: 2
	Flags: Linked
*/
function function_4ccc033d(localclientnum, var_d0c67621)
{
	if(isdefined([[ var_d0c67621 ]]->function_82e05d64().primaryweapon))
	{
		if(!isdefined([[ var_d0c67621 ]]->function_82e05d64().activeweapon))
		{
			return 1;
		}
		if(isdefined(level.var_ea696257) && level.var_ea696257)
		{
			return [[ var_d0c67621 ]]->function_82e05d64().activeweapon != getweapon(#"pistol_standard_t8");
		}
		if(isdefined(level.var_8eef5741) && level.var_8eef5741)
		{
			return [[ var_d0c67621 ]]->function_82e05d64().activeweapon != level.var_bf82f6b0;
		}
		if(isdefined(level.isgungame) && level.isgungame)
		{
			return [[ var_d0c67621 ]]->function_82e05d64().activeweapon != getweapon(#"pistol_fullauto_t8");
		}
		if(isdefined(level.var_207a1c9a) && level.var_207a1c9a)
		{
			return [[ var_d0c67621 ]]->function_82e05d64().activeweapon != getweapon(#"hash_124cfa74fbc2fd96");
		}
		var_aec11cf1 = [[ var_d0c67621 ]]->function_82e05d64().activeweapon != [[ var_d0c67621 ]]->function_82e05d64().primaryweapon || [[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 !== [[ var_d0c67621 ]]->function_82e05d64().primaryweaponoptions;
		return var_aec11cf1;
	}
	return 0;
}

/*
	Name: function_a1c71160
	Namespace: draft
	Checksum: 0xB9977D82
	Offset: 0x7258
	Size: 0x35E
	Parameters: 2
	Flags: Linked
*/
function function_a1c71160(localclientnum, var_d0c67621)
{
	changed = 0;
	if(function_4ccc033d(localclientnum, var_d0c67621))
	{
		function_2dfe152c(localclientnum, var_d0c67621, [[ var_d0c67621 ]]->function_82e05d64().activeweapon, [[ var_d0c67621 ]]->function_82e05d64().primaryweapon);
		if(isdefined(level.var_ea696257) && level.var_ea696257)
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = getweapon(#"pistol_standard_t8");
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = 0;
		}
		else if(isdefined(level.var_8eef5741) && level.var_8eef5741)
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = level.var_bf82f6b0;
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = 0;
		}
		else if(isdefined(level.isgungame) && level.isgungame)
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = getweapon(#"pistol_fullauto_t8");
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = 0;
		}
		else if(isdefined(level.var_207a1c9a) && level.var_207a1c9a)
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = getweapon(#"special_crossbow_t8");
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = 0;
		}
		else if([[ var_d0c67621 ]]->function_82e05d64().primaryweapon == level.weaponnone)
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = [[ var_d0c67621 ]]->function_82e05d64().secondaryweapon;
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = [[ var_d0c67621 ]]->function_82e05d64().secondaryweaponoptions;
		}
		else
		{
			[[ var_d0c67621 ]]->function_82e05d64().activeweapon = [[ var_d0c67621 ]]->function_82e05d64().primaryweapon;
			[[ var_d0c67621 ]]->function_82e05d64().var_b8f20727 = [[ var_d0c67621 ]]->function_82e05d64().primaryweaponoptions;
		}
		[[ var_d0c67621 ]]->function_82e05d64().params.activeweapon = [[ var_d0c67621 ]]->function_82e05d64().activeweapon;
		[[ var_d0c67621 ]]->function_82e05d64().params.var_b8f20727 = [[ var_d0c67621 ]]->function_82e05d64().var_b8f20727;
		changed = 1;
	}
	return changed;
}

/*
	Name: function_71a9fb67
	Namespace: draft
	Checksum: 0xB7425E50
	Offset: 0x75C0
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_71a9fb67(localclientnum, var_d0c67621)
{
	update = 0;
	if(function_93a4f3c5(localclientnum, var_d0c67621))
	{
		update = 1;
	}
	if(function_a1c71160(localclientnum, var_d0c67621))
	{
		update = 1;
	}
	if(update)
	{
		sessionmode = currentsessionmode();
		var_de58f286 = [[ var_d0c67621 ]]->function_82e05d64();
		function_6b532f83(localclientnum, var_de58f286, sessionmode);
		[[ var_d0c67621 ]]->update([[ var_d0c67621 ]]->function_82e05d64().params);
	}
}

/*
	Name: function_41c16f74
	Namespace: draft
	Checksum: 0x7D2E19E
	Offset: 0x76B0
	Size: 0x876
	Parameters: 2
	Flags: Linked
*/
function function_41c16f74(localclientnum, var_4123f2c1)
{
	localplayer = function_5c10bd79(localclientnum);
	team = function_c4dfe16e(localclientnum);
	controllermodel = getuimodelforcontroller(localclientnum);
	positiondraftclientsmodel = getuimodel(controllermodel, "PositionDraftClients");
	for(i = 0; i < 5; i++)
	{
		if(!isdefined(level.draftcharacters[localclientnum][team]) || !isdefined(level.draftcharacters[localclientnum][team][i]))
		{
			continue;
		}
		var_d0c67621 = level.draftcharacters[localclientnum][team][i];
		[[ var_d0c67621 ]]->function_82e05d64().var_c018da16 = undefined;
		[[ var_d0c67621 ]]->function_82e05d64().primaryweapon = level.weaponnone;
		[[ var_d0c67621 ]]->function_82e05d64().primaryweaponoptions = 0;
		[[ var_d0c67621 ]]->function_82e05d64().secondaryweapon = level.weaponnone;
		[[ var_d0c67621 ]]->function_82e05d64().secondaryweaponoptions = 0;
		if(isdefined(positiondraftclientsmodel))
		{
			luaindex = i + 1;
			positionmodel = getuimodel(positiondraftclientsmodel, luaindex);
			clientnum = getuimodelvalue(getuimodel(positionmodel, "clientNum"));
			[[ var_d0c67621 ]]->function_82e05d64().islocalclient = getuimodelvalue(getuimodel(positionmodel, "isLocalClient"));
			[[ var_d0c67621 ]]->function_82e05d64().var_90ba8f6f = createuimodel(positionmodel, "entNum");
			setuimodelvalue([[ var_d0c67621 ]]->function_82e05d64().var_90ba8f6f, [[ var_d0c67621 ]]->function_47cb6b19());
			if(clientnum >= 0)
			{
				player = getentbynum(localclientnum, clientnum);
				if(isdefined(player) && player function_e4f35989())
				{
					[[ var_d0c67621 ]]->function_82e05d64().player = player;
					[[ var_d0c67621 ]]->function_82e05d64().var_c018da16 = player function_79a48799();
					if(isdefined([[ var_d0c67621 ]]->function_82e05d64().var_c018da16) && player_role::is_valid([[ var_d0c67621 ]]->function_82e05d64().var_c018da16.charactertype) && player_role::is_valid([[ var_d0c67621 ]]->function_82e05d64().focusedcharacterindex))
					{
						[[ var_d0c67621 ]]->function_82e05d64().var_625ec6da = undefined;
						[[ var_d0c67621 ]]->function_82e05d64().focusedcharacterindex = 0;
					}
					[[ var_d0c67621 ]]->function_82e05d64().primaryweapon = player getprimaryweapon();
					[[ var_d0c67621 ]]->function_82e05d64().primaryweaponoptions = player function_519bc773();
					[[ var_d0c67621 ]]->function_82e05d64().secondaryweapon = player getsecondaryweapon();
					[[ var_d0c67621 ]]->function_82e05d64().secondaryweaponoptions = player function_64c66c4b();
				}
				else
				{
					[[ var_d0c67621 ]]->function_82e05d64().player = undefined;
				}
				if(isdefined([[ var_d0c67621 ]]->function_82e05d64().islocalclient) && [[ var_d0c67621 ]]->function_82e05d64().islocalclient || shoutcaster::is_shoutcaster(localclientnum))
				{
					if(!isdefined([[ var_d0c67621 ]]->function_82e05d64().player))
					{
						[[ var_d0c67621 ]]->function_82e05d64().player = localplayer;
						[[ var_d0c67621 ]]->function_82e05d64().primaryweapon = localplayer getprimaryweapon();
						[[ var_d0c67621 ]]->function_82e05d64().primaryweaponoptions = localplayer function_519bc773();
						[[ var_d0c67621 ]]->function_82e05d64().secondaryweapon = localplayer getsecondaryweapon();
						[[ var_d0c67621 ]]->function_82e05d64().secondaryweaponoptions = localplayer function_64c66c4b();
					}
					[[ var_d0c67621 ]]->function_82e05d64().localclientnum = localclientnum;
					if(isdefined([[ var_d0c67621 ]]->function_82e05d64().var_c018da16) && player_role::is_valid([[ var_d0c67621 ]]->function_82e05d64().var_c018da16.charactertype) || shoutcaster::is_shoutcaster(localclientnum))
					{
						function_236a944e(localclientnum);
						lerpduration = 1000;
						if(var_4123f2c1)
						{
							lerpduration = 0;
						}
						function_e79c182b(localclientnum, lerpduration);
					}
					else
					{
						function_b139ecfb(localclientnum);
						lerpduration = 1000;
						if(var_4123f2c1)
						{
							lerpduration = 0;
						}
						function_532dfc0b(localclientnum, lerpduration);
						positiondraftmodel = getuimodel(controllermodel, "PositionDraft");
						if(isdefined(positiondraftmodel))
						{
							[[ var_d0c67621 ]]->function_82e05d64().focusedcharacterindex = getuimodelvalue(getuimodel(positiondraftmodel, "focusedCharacterIndex"));
						}
					}
				}
				else
				{
					[[ var_d0c67621 ]]->function_82e05d64().localclientnum = undefined;
				}
				var_24b754fa = getuimodelvalue(getuimodel(positionmodel, "clientInfo"));
				[[ var_d0c67621 ]]->function_82e05d64().var_91065a59 = getuimodelvalue(getuimodel(var_24b754fa, "ready"));
				if(shoutcaster::is_shoutcaster(localclientnum) && !(isdefined([[ var_d0c67621 ]]->function_82e05d64().var_91065a59)) && isdefined(player) && isbot(player))
				{
					[[ var_d0c67621 ]]->function_82e05d64().var_91065a59 = 0;
				}
			}
		}
		function_71a9fb67(localclientnum, var_d0c67621);
	}
}

/*
	Name: function_9e9e1117
	Namespace: draft
	Checksum: 0x8E148077
	Offset: 0x7F30
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_9e9e1117(localclientnum, var_d0c67621)
{
	if(isdefined([[ var_d0c67621 ]]->function_82e05d64().var_90ba8f6f))
	{
		setuimodelvalue([[ var_d0c67621 ]]->function_82e05d64().var_90ba8f6f, [[ var_d0c67621 ]]->function_47cb6b19());
	}
}

/*
	Name: function_20811f66
	Namespace: draft
	Checksum: 0x46BB7470
	Offset: 0x7FA0
	Size: 0x120
	Parameters: 1
	Flags: Linked
*/
function function_20811f66(localclientnum)
{
	foreach(team in getarraykeys(level.draftcharacters[localclientnum]))
	{
		foreach(char in level.draftcharacters[localclientnum][team])
		{
			[[ char ]]->delete_models();
		}
		level.draftcharacters[localclientnum][team] = [];
	}
}

/*
	Name: function_5e495c81
	Namespace: draft
	Checksum: 0x674D06A0
	Offset: 0x80C8
	Size: 0x290
	Parameters: 1
	Flags: Linked
*/
function function_5e495c81(localclientnum)
{
	function_20811f66(localclientnum);
	teambased = function_b2272884();
	team = function_c4dfe16e(localclientnum);
	if(isdefined(level.playerscriptstructs[team]))
	{
		for(i = 0; i < level.playerscriptstructs[team].size; i++)
		{
			if(!isdefined(level.draftcharacters[localclientnum][team][i]))
			{
				model = util::spawn_model(localclientnum, "tag_origin", level.playerscriptstructs[team][i].origin, level.playerscriptstructs[team][i].angles);
				model.targetname = level.playerscriptstructs[team][i].targetname;
				var_d0c67621 = character_customization::function_dd295310(model, localclientnum, 0);
				[[ var_d0c67621 ]]->function_184a4d2e(&function_9e9e1117);
				[[ var_d0c67621 ]]->set_character_mode(currentsessionmode());
				var_de58f286 = [[ var_d0c67621 ]]->function_82e05d64();
				var_de58f286.positionindex = i;
				var_de58f286.var_3afd181d = 0;
				var_de58f286.var_91065a59 = 0;
				var_de58f286.selected = 0;
				var_de58f286.params = spawnstruct();
				var_de58f286.params.sessionmode = currentsessionmode();
				var_de58f286.islocalclient = 0;
				var_de58f286.showmodel = teambased || i == 1;
				level.draftcharacters[localclientnum][team][i] = var_d0c67621;
			}
		}
	}
}

/*
	Name: watchupdate
	Namespace: draft
	Checksum: 0x9F809250
	Offset: 0x8360
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function watchupdate(localclientnum)
{
	level endon(#"disconnect", #"hash_5d0cdc8933e4f6f9");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"positiondraft_update", #"positiondraft_reject");
		if(localclientnum == waitresult.localclientnum)
		{
			if(shoutcaster::is_shoutcaster(localclientnum))
			{
				function_5e495c81(localclientnum);
			}
			function_41c16f74(localclientnum, 0);
		}
	}
}

/*
	Name: watchteamchange
	Namespace: draft
	Checksum: 0x171C576C
	Offset: 0x8438
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function watchteamchange(localclientnum)
{
	self endon(#"disconnect", #"hash_5d0cdc8933e4f6f9");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"team_changed");
		if(localclientnum == waitresult.localclientnum)
		{
			function_5e495c81(localclientnum);
			function_41c16f74(localclientnum, 1);
		}
	}
}

/*
	Name: function_1b96cc80
	Namespace: draft
	Checksum: 0x76AFA385
	Offset: 0x84E8
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_1b96cc80()
{
	self notify(#"hash_79dc7957d60fa25");
	self endon(#"hash_79dc7957d60fa25", #"disconnect", #"hash_5d0cdc8933e4f6f9");
	while(true)
	{
		level.var_84e5adfd = 0;
		level waittill(#"killcam_begin");
		level.var_84e5adfd = 1;
		level waittill(#"killcam_end");
	}
}

/*
	Name: function_9afd868e
	Namespace: draft
	Checksum: 0xA48B6017
	Offset: 0x8590
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_9afd868e(localclientnum)
{
	self notify("5d2e4287c1d8f08d");
	self endon("5d2e4287c1d8f08d");
	self endon(#"hash_5d0cdc8933e4f6f9");
	if(!(isdefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum]))
	{
		level.draftactive[localclientnum] = 1;
		function_5e495c81(localclientnum);
		play_intro_cinematic(localclientnum);
		function_1dccd222(localclientnum);
		level thread watchupdate(localclientnum);
		level thread watchteamchange(localclientnum);
		if(!(isdefined(level.var_f6501ae8) && level.var_f6501ae8))
		{
			level.var_f6501ae8 = 1;
			level thread function_1b96cc80();
		}
		function_41c16f74(localclientnum, 1);
	}
}

/*
	Name: function_ca03ab69
	Namespace: draft
	Checksum: 0x97E64986
	Offset: 0x86E8
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_ca03ab69()
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"positiondraft_open");
		localclientnum = waitresult.localclientnum;
		localplayer = function_5c10bd79(localclientnum);
		localplayer serverfield::set("PositionDraft.uiLoaded", 1);
		level thread function_9afd868e(localclientnum);
	}
}

/*
	Name: function_91858511
	Namespace: draft
	Checksum: 0xDD92CC4C
	Offset: 0x87A8
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function function_91858511()
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"positiondraft_close");
		localclientnum = waitresult.localclientnum;
		if(isdefined(level.draftactive[localclientnum]) && level.draftactive[localclientnum])
		{
			if(!(isdefined(level.var_c5e590e5) && level.var_c5e590e5))
			{
				level notify(#"hash_5d0cdc8933e4f6f9");
				clearstreamerloadinghints();
				level.var_c5e590e5 = 1;
			}
			function_20811f66(localclientnum);
			function_2c486f35(localclientnum);
			function_e1e243c1(localclientnum);
			level.draftactive[localclientnum] = 0;
		}
	}
}

