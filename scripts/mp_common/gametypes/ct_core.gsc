// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_loadout.gsc;
#using scripts\core_common\player\player_role.gsc;
#using script_4c8dba49908aecc2;
#using scripts\abilities\ability_util.gsc;
#using scripts\mp_common\gametypes\ct_utils.gsc;
#using scripts\mp_common\player\player_loadout.gsc;
#using scripts\mp_common\gametypes\ct_difficulty.gsc;
#using scripts\mp_common\gametypes\ct_ui.gsc;
#using scripts\mp_common\gametypes\ct_bots.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\util.gsc;

#namespace ct_core;

/*
	Name: function_46e95cc7
	Namespace: ct_core
	Checksum: 0x602BDFBA
	Offset: 0x2D0
	Size: 0x384
	Parameters: 0
	Flags: None
*/
function function_46e95cc7()
{
	level.var_e7c95d09 = 1;
	level.givecustomloadout = &function_1dd43d36;
	level.var_7b05c4b5 = 1;
	level.var_9f011465 = 1;
	level.var_e3049e92 = 0;
	level.var_903e2252 = 1;
	level.var_87bcb1b = 0;
	level.var_827f5a28 = 1;
	level.skipgameend = 1;
	level.var_d0c7d280 = 0;
	level.var_e72728b8 = [];
	setgametypesetting(#"disableweapondrop", 1);
	level.disableweapondrop = 1;
	callback::add_callback(#"on_player_killed", &function_1ca625ba);
	callback::add_callback(#"on_end_game", &on_end_game);
	globallogic::init();
	util::registerroundswitch(0, 9);
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	setdvar(#"com_pausesupported", 1);
	setdvar(#"custom_killstreak_mode", 0);
	setdvar(#"hash_48162cd174e3034d", 1);
	setdvar(#"scr_scorestreaks", 0);
	setdvar(#"bot_maxfree", 0);
	setdvar(#"bot_maxallies", 0);
	setdvar(#"bot_maxaxis", 0);
	level.usingscorestreaks = 0;
	level.disablescoreevents = 1;
	level.disablemomentum = 1;
	level.overrideteamscore = 1;
	level.forceusekillstreak = 1;
	level.forcedplayerteam = #"allies";
	ct_difficulty::function_be562a72();
	level.var_edd52efc = &function_edd52efc;
	level thread function_6a1d53f3();
}

/*
	Name: function_1dd43d36
	Namespace: ct_core
	Checksum: 0x92BABFF1
	Offset: 0x660
	Size: 0x836
	Parameters: 1
	Flags: None
*/
function function_1dd43d36(spawn_weapon)
{
	player = self;
	if(player.var_560765bb === player.spawntime)
	{
		return player.spawnweapon;
	}
	player loadout::init_player(1);
	player loadout::function_c67222df();
	player loadout::give_perks();
	if(!isdefined(player.var_de9764de))
	{
		player.var_de9764de = [];
	}
	player setplayerrenderoptions(0);
	var_e6b5e0d7 = getdvar(#"hash_3fb2952874e511c2");
	hands_weapon = ct_utils::function_84adcd1f();
	var_d0d43f5a = getdvar(#"hash_4b0035c0038e0762");
	if(isdefined(var_d0d43f5a))
	{
		attachments = [];
		for(i = 0; i < 6; i++)
		{
			if(!isdefined(attachments))
			{
				attachments = [];
			}
			else if(!isarray(attachments))
			{
				attachments = array(attachments);
			}
			if(!isinarray(attachments, getdvar(#"hash_721ee06404866532" + i)))
			{
				attachments[attachments.size] = getdvar(#"hash_721ee06404866532" + i);
			}
		}
		arrayremovevalue(attachments, #"");
		primary_weapon = getweapon(var_d0d43f5a, attachments);
		stashweapon = getdvarint(#"hash_48162cd174e3034d", 0) || isdefined(spawn_weapon);
		if(stashweapon)
		{
			if(!isdefined(player.var_de9764de))
			{
				player.var_de9764de = [];
			}
			else if(!isarray(player.var_de9764de))
			{
				player.var_de9764de = array(player.var_de9764de);
			}
			if(!isinarray(player.var_de9764de, primary_weapon))
			{
				player.var_de9764de[player.var_de9764de.size] = primary_weapon;
			}
			if(!isdefined(spawn_weapon))
			{
				spawn_weapon = hands_weapon;
			}
		}
		else
		{
			spawn_weapon = primary_weapon;
		}
	}
	else if(!isdefined(spawn_weapon))
	{
		primary_weapon = getweapon(#"ar_accurate_t8");
		if(!isdefined(player.var_de9764de))
		{
			player.var_de9764de = [];
		}
		else if(!isarray(player.var_de9764de))
		{
			player.var_de9764de = array(player.var_de9764de);
		}
		if(!isinarray(player.var_de9764de, primary_weapon))
		{
			player.var_de9764de[player.var_de9764de.size] = primary_weapon;
		}
		spawn_weapon = hands_weapon;
	}
	player giveweapon(spawn_weapon);
	player loadout::function_442539("primary", spawn_weapon);
	var_670cba7 = getdvar(#"hash_6dcfed2e90bdae6e");
	if(isdefined(var_670cba7))
	{
		attachments = [];
		for(i = 0; i < 6; i++)
		{
			if(!isdefined(attachments))
			{
				attachments = [];
			}
			else if(!isarray(attachments))
			{
				attachments = array(attachments);
			}
			if(!isinarray(attachments, getdvar(#"hash_c7f896e4dff882e" + i)))
			{
				attachments[attachments.size] = getdvar(#"hash_c7f896e4dff882e" + i);
			}
		}
		arrayremovevalue(attachments, #"");
		secondary_weapon = getweapon(var_670cba7, attachments);
		if(getdvarint(#"hash_48162cd174e3034d", 0))
		{
			if(!isdefined(player.var_de9764de))
			{
				player.var_de9764de = [];
			}
			else if(!isarray(player.var_de9764de))
			{
				player.var_de9764de = array(player.var_de9764de);
			}
			if(!isinarray(player.var_de9764de, secondary_weapon))
			{
				player.var_de9764de[player.var_de9764de.size] = secondary_weapon;
			}
		}
		else
		{
			player giveweapon(secondary_weapon);
			player loadout::function_442539("secondary", secondary_weapon);
		}
	}
	if(isdefined(player.playerrole))
	{
		primaryoffhand = getweapon(player.playerrole.var_a7e7cb46);
		player giveweapon(primaryoffhand);
		player loadout::function_442539("primarygrenade", primaryoffhand);
		player loadout::function_c3448ab0("specialgrenade", undefined, 1);
		specialoffhand = getweapon(player.playerrole.var_c21d61e9);
		player giveweapon(specialoffhand);
		player loadout::function_442539("herogadget", specialoffhand);
	}
	player loadout::function_d98a8122(spawn_weapon);
	player.health = 150;
	player.maxhealth = 150;
	player.var_66cb03ad = 150;
	player loadout::function_da96d067();
	player.var_560765bb = player.spawntime;
	return spawn_weapon;
}

/*
	Name: function_1ca625ba
	Namespace: ct_core
	Checksum: 0x7FBED88E
	Offset: 0xEA0
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_1ca625ba()
{
	entity = self;
	entity.var_560765bb = undefined;
}

/*
	Name: function_6a1d53f3
	Namespace: ct_core
	Checksum: 0x5AE1B5C9
	Offset: 0xEC8
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function function_6a1d53f3()
{
	level waittill(#"game_ended");
	level notify(#"combattraining_logic_finished", {#success:0});
}

/*
	Name: function_edd52efc
	Namespace: ct_core
	Checksum: 0x674950C0
	Offset: 0xF18
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function function_edd52efc()
{
	/#
		assert(player_role::is_valid(level.select_character));
	#/
	if(player_role::is_valid(level.select_character))
	{
		self player_role::set(level.select_character);
	}
	level notify(#"hash_2cbc372b0dee9bec");
}

/*
	Name: function_fa03fc55
	Namespace: ct_core
	Checksum: 0x3C5CB1
	Offset: 0xFA0
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_fa03fc55()
{
	clientfield::register("allplayers", "enemy_on_radar", 1, 1, "int");
	clientfield::register("actor", "enemy_on_radar", 1, 1, "int");
	clientfield::register("allplayers", "player_keyline_render", 1, 1, "int");
	clientfield::register("allplayers", "enemy_keyline_render", 1, 1, "int");
	clientfield::register("scriptmover", "enemyobj_keyline_render", 1, 1, "int");
	clientfield::register("actor", "actor_keyline_render", 1, 1, "int");
	clientfield::register("vehicle", "enemy_vehicle_keyline_render", 1, 1, "int");
	clientfield::register("allplayers", "set_vip", 1, 2, "int");
	clientfield::register("scriptmover", "animate_spawn_beacon", 1, 1, "int");
	clientfield::register("scriptmover", "objective_glow", 1, 1, "int");
}

/*
	Name: function_d2845186
	Namespace: ct_core
	Checksum: 0xD730E8F8
	Offset: 0x1190
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function function_d2845186()
{
	level endon(#"hash_699329b4df616aed");
	level waittill(#"hash_4c62fe02843b1a98");
	if(isdefined(level.var_e92a00d3))
	{
		self [[level.var_e92a00d3]]();
	}
}

/*
	Name: function_1aeaebae
	Namespace: ct_core
	Checksum: 0xD39DB629
	Offset: 0x11F0
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_1aeaebae()
{
	level.allowspecialistdialog = 0;
	e_player = getplayers(#"allies")[0];
	while(!isdefined(e_player))
	{
		e_player = getplayers(#"allies")[0];
		waitframe(1);
	}
	e_player endon(#"death");
	e_player thread ct_ui::function_6889bb61(0);
	level waittill(#"hash_3779df13251ba6f7");
	return level.var_cd9d597c;
}

/*
	Name: function_f8f94589
	Namespace: ct_core
	Checksum: 0x28EC28F5
	Offset: 0x12C8
	Size: 0x130
	Parameters: 1
	Flags: None
*/
function function_f8f94589(gamedifficulty)
{
	level flag::set("combat_training_started");
	if(isdefined(level.var_49240db3))
	{
		level thread [[level.var_49240db3]](gamedifficulty);
	}
	waitresult = undefined;
	waitresult = level waittill(#"combattraining_logic_finished");
	level flag::clear("combat_training_started");
	e_player = ct_utils::get_player();
	if(isdefined(e_player) && isdefined(e_player.var_560765bb))
	{
		e_player on_end_game(undefined);
	}
	recordgameresult(#"draw");
	globallogic::updateandfinalizematchrecord();
	level notify(#"hash_699329b4df616aed");
}

/*
	Name: function_1e84c767
	Namespace: ct_core
	Checksum: 0x652791F5
	Offset: 0x1400
	Size: 0x524
	Parameters: 0
	Flags: None
*/
function function_1e84c767()
{
	level waittill(#"hash_2cbc372b0dee9bec", #"draft_complete");
	level.usingmomentum = 0;
	level.var_90bb9821 = 0;
	setdvar(#"scr_disablechallenges", 1);
	level flag::init("bot_init_complete");
	level thread ct_bots::function_fa0d912f(17);
	if(isdefined(level.var_4c2ecc6f))
	{
		level thread [[level.var_4c2ecc6f]]();
	}
	ct_utils::function_1edf99df();
	function_9a022fbc("open");
	player = getplayers()[0];
	var_60786cb4 = 0;
	if(util::function_8570168d())
	{
		while(true)
		{
			waitresult = undefined;
			waitresult = player waittill(#"menuresponse");
			menu = waitresult.menu;
			response = waitresult.response;
			var_244a2498 = waitresult.intpayload;
			if(response == "isIntroTutorialMovie")
			{
				var_60786cb4 = var_244a2498 == 1;
				break;
			}
		}
	}
	while(isloadingcinematicplaying())
	{
		waitframe(1);
	}
	if(var_60786cb4)
	{
		waitframe(1);
		function_e9b83be8();
	}
	function_9a022fbc("close");
	/#
		level.var_63c19b1b = getdvarint(#"hash_6c85efe41dc0fd26", 0) == 1;
	#/
	if(!(isdefined(level.var_63c19b1b) && level.var_63c19b1b))
	{
		gamedifficulty = function_1aeaebae();
		level thread function_f8f94589(gamedifficulty);
		if(player function_c2c1d36b(player function_76785843()) == #"not_started")
		{
			player function_3b91934f(player function_76785843(), #"tutorial_started");
			player function_ea859fe2();
		}
		s_result = undefined;
		s_result = level waittill(#"combattraining_logic_finished");
		b_completed = s_result.success;
		level waittill(#"hash_699329b4df616aed");
	}
	else
	{
		b_completed = 1;
	}
	if(util::function_8570168d() && b_completed)
	{
		str_state = player function_c2c1d36b(player function_76785843());
		if(str_state == #"skirmish_completed")
		{
			player thread namespace_9096c917::function_b4ebcd8a();
			player function_ea859fe2();
			function_588a84ce();
			thread globallogic::end_round(9);
		}
		else if(str_state == #"tutorial_started" || str_state == #"tutorial_completed")
		{
			player function_3b91934f(player function_76785843(), #"tutorial_completed");
			player function_ea859fe2();
			waitframe(1);
			player thread namespace_9096c917::function_b4ebcd8a();
			function_588a84ce();
			namespace_9096c917::function_5e1029a();
		}
	}
}

/*
	Name: function_a217c7b4
	Namespace: ct_core
	Checksum: 0x97B38FC4
	Offset: 0x1930
	Size: 0x2C0
	Parameters: 1
	Flags: None
*/
function function_a217c7b4(b_success)
{
	if(isdefined(level.var_8b9d690e))
	{
		var_cd803a6b = level thread [[level.var_8b9d690e]](b_success);
	}
	level thread ct_bots::function_87cf954e();
	axis = getaiteamarray(#"axis");
	foreach(entity in axis)
	{
		entity delete();
	}
	if(b_success && 1 && (isdefined(level.var_38c87b5) && level.var_38c87b5))
	{
		wait(2);
		e_player = getplayers(#"allies")[0];
		e_player val::set(#"potm", "freezecontrols", 1);
		/#
			println("");
		#/
		/#
			println("");
		#/
		level potm::function_b6a5e7fa();
		/#
			println("");
		#/
		e_player = getplayers(#"allies")[0];
		e_player val::reset(#"potm", "freezecontrols");
		wait(0.3);
	}
	e_player = getplayers(#"allies")[0];
	e_player ct_ui::function_fa910e34(b_success, var_cd803a6b);
	level notify(#"hash_6731a3e5cccf7357");
	level notify(#"hash_42057c28bd084d77");
}

/*
	Name: function_45a4f027
	Namespace: ct_core
	Checksum: 0xAFB94E12
	Offset: 0x1BF8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_45a4f027()
{
	function_c7c103cd(#"allies", #"invalid");
	function_c7c103cd(#"axis", #"invalid");
}

/*
	Name: on_end_game
	Namespace: ct_core
	Checksum: 0xAB4CDD7F
	Offset: 0x1C68
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function on_end_game(params)
{
	ct_utils::function_64f9f527();
	ct_utils::function_c3a6c010();
	e_player = ct_utils::get_player();
	if(isdefined(e_player))
	{
		e_player.var_560765bb = undefined;
	}
	callback::remove_callback(#"on_player_killed", &function_1ca625ba);
	callback::remove_callback(#"on_end_game", &on_end_game);
}

/*
	Name: function_a1fb023a
	Namespace: ct_core
	Checksum: 0x31D61C05
	Offset: 0x1D30
	Size: 0x70
	Parameters: 1
	Flags: Private
*/
function private function_a1fb023a(ismaturecontent)
{
	e_player = ct_utils::get_player();
	if(isdefined(e_player))
	{
		var_1e77bf82 = ismature(e_player);
	}
	return isdefined(ismaturecontent) && ismaturecontent || (isdefined(var_1e77bf82) && var_1e77bf82);
}

/*
	Name: function_95e72b33
	Namespace: ct_core
	Checksum: 0xDB3137B
	Offset: 0x1DA8
	Size: 0xC4
	Parameters: 1
	Flags: Private
*/
function private function_95e72b33(moviefile)
{
	self notify(#"hash_76ffabe3ed35bd68");
	self val::set(#"hash_61f16f3175b9a96f", "freezecontrols", 1);
	self thread lui::play_movie(hash(moviefile), "fullscreen", 1, 0, 1);
	level waittill(#"movie_done");
	self val::reset(#"hash_61f16f3175b9a96f", "freezecontrols");
}

/*
	Name: function_e9b83be8
	Namespace: ct_core
	Checksum: 0xA20938C4
	Offset: 0x1E78
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function function_e9b83be8()
{
	/#
		/#
			assert(isdefined(level.select_character), "");
		#/
	#/
	fields = getcharacterfields(level.select_character, currentsessionmode());
	if(isdefined(fields) && isdefined(fields.intromovie) && function_a1fb023a(fields.var_5331abe0))
	{
		e_player = getplayers(#"allies")[0];
		if(isdefined(e_player) && isplayer(e_player))
		{
			e_player function_95e72b33(fields.intromovie);
		}
	}
}

/*
	Name: function_588a84ce
	Namespace: ct_core
	Checksum: 0xEA7E6158
	Offset: 0x1F98
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function function_588a84ce()
{
	/#
		/#
			assert(isdefined(level.select_character), "");
		#/
	#/
	fields = getcharacterfields(level.select_character, currentsessionmode());
	if(isdefined(fields) && isdefined(fields.var_55f31ab6) && function_a1fb023a(fields.var_148d6d91))
	{
		e_player = getplayers(#"allies")[0];
		if(isdefined(e_player) && isplayer(e_player))
		{
			e_player function_95e72b33(fields.var_55f31ab6);
		}
	}
}

/*
	Name: function_9a022fbc
	Namespace: ct_core
	Checksum: 0xFF7DB201
	Offset: 0x20B8
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_9a022fbc(str_state)
{
	player = getplayers()[0];
	lui_menu = lui::get_luimenu("FullScreenBlack");
	if(str_state == "open")
	{
		if(isdefined(lui_menu))
		{
			[[ lui_menu ]]->open(player);
			[[ lui_menu ]]->set_startAlpha(player, 1);
			[[ lui_menu ]]->set_endAlpha(player, 1);
			[[ lui_menu ]]->set_fadeOverTime(player, int(2000));
		}
	}
	else if(isdefined(lui_menu))
	{
		[[ lui_menu ]]->close(player);
	}
}

