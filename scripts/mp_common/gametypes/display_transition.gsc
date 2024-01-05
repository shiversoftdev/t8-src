// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_utils.gsc;
#using scripts\mp_common\gametypes\overtime.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\gametypes\hud_message.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace display_transition;

/*
	Name: init_shared
	Namespace: display_transition
	Checksum: 0xDD1D752F
	Offset: 0x1B8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	registerclientfields();
	function_7e74281();
}

/*
	Name: registerclientfields
	Namespace: display_transition
	Checksum: 0x854E5A7B
	Offset: 0x1E8
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private registerclientfields()
{
	if(sessionmodeiswarzonegame())
	{
		clientfield::register("clientuimodel", "eliminated_postfx", 12000, 1, "int");
	}
}

/*
	Name: function_a5ce91f1
	Namespace: display_transition
	Checksum: 0xB8034E6E
	Offset: 0x238
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a5ce91f1(val)
{
	if(sessionmodeiswarzonegame())
	{
		self clientfield::set_player_uimodel("eliminated_postfx", val);
	}
}

/*
	Name: function_81d670f5
	Namespace: display_transition
	Checksum: 0x680AA0AF
	Offset: 0x280
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_81d670f5()
{
	if(isdefined(level.var_d1455682))
	{
		if(!isdefined(level.var_d1455682.var_3e72919) || level.var_d1455682.var_3e72919.size == 0)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_b8e20f5f
	Namespace: display_transition
	Checksum: 0x7EB137BD
	Offset: 0x2E0
	Size: 0x88
	Parameters: 5
	Flags: Linked, Private
*/
function private function_b8e20f5f(transition, outcome, var_f6e1baec, var_b6818fc8, func)
{
	if(isdefined(var_f6e1baec) && var_f6e1baec)
	{
		if((isdefined(var_b6818fc8) ? var_b6818fc8 : 0) != 0)
		{
			wait(float(var_b6818fc8) / 1000);
		}
		[[func]](transition, outcome);
	}
}

/*
	Name: function_e6b4f2f7
	Namespace: display_transition
	Checksum: 0xFEBAFF27
	Offset: 0x370
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_e6b4f2f7(outcome)
{
	function_76f27db3(outcome.var_c1e98979, outcome::function_2e00fa44(outcome), outcome.platoon, outcome.team, outcome.players);
}

/*
	Name: function_12d1f62a
	Namespace: display_transition
	Checksum: 0x70333191
	Offset: 0x3D8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_12d1f62a(outcome)
{
	function_2fa975e0(util::getroundsplayed(), outcome.var_c1e98979, outcome::function_2e00fa44(outcome), outcome.platoon, outcome.team, outcome.players);
}

/*
	Name: function_19adc0b7
	Namespace: display_transition
	Checksum: 0x50DB3D52
	Offset: 0x458
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_19adc0b7(outcome)
{
	player::function_2f80d95b(&function_3f65d5d3);
	function_e6b4f2f7(outcome);
	array::run_all(level.players, &hud_message::can_bg_draw, outcome);
	function_15e28b1a(outcome);
	globallogic::function_452e18ad();
	array::run_all(level.players, &hud_message::function_6be746c2);
}

/*
	Name: display_round_end
	Namespace: display_transition
	Checksum: 0xE06B1F82
	Offset: 0x520
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function display_round_end(outcome)
{
	player::function_2f80d95b(&function_3f65d5d3);
	player::function_2f80d95b(&function_3cfb29e1);
	function_12d1f62a(outcome);
	function_cf3d556b(outcome);
	globallogic::function_452e18ad();
	array::run_all(level.players, &hud_message::function_6be746c2);
}

/*
	Name: function_91b514e8
	Namespace: display_transition
	Checksum: 0xACACCB3E
	Offset: 0x5E0
	Size: 0xC2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_91b514e8(menuname)
{
	player = self;
	player endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = player waittill(#"menuresponse");
		menu = waitresult.menu;
		response = waitresult.response;
		if(isdefined(menuname))
		{
			if(menu == menuname)
			{
				return;
			}
		}
		else if(menu == "GameEndScore")
		{
			return;
		}
	}
}

/*
	Name: function_61d01718
	Namespace: display_transition
	Checksum: 0xF86AEB6A
	Offset: 0x6B0
	Size: 0x1F0
	Parameters: 2
	Flags: Linked
*/
function function_61d01718(transitions, lui_event)
{
	player = self;
	player endon(#"disconnect");
	foreach(index, transition in transitions)
	{
		player function_b797319e(lui_event, index + 1);
		if((isdefined(transition.time) ? transition.time : 0) != 0)
		{
			round_end_wait(float(transition.time) / 1000);
			continue;
		}
		if((isdefined(transition.var_bda115b5) ? transition.var_bda115b5 : 0) != 0)
		{
			self function_a5ce91f1(1);
			self thread function_c6f81aa1(float(transition.var_f4df0630) / 1000);
			player function_91b514e8(transition.menuresponse);
			self function_a5ce91f1(0);
			continue;
		}
		player function_91b514e8(transition.menuresponse);
	}
}

/*
	Name: function_c6f81aa1
	Namespace: display_transition
	Checksum: 0x6854B883
	Offset: 0x8A8
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function function_c6f81aa1(time)
{
	if(!isdefined(time))
	{
		return;
	}
	player = self;
	player endon(#"disconnect", #"spawned");
	player.var_686890d5 = 1;
	if(time <= 0)
	{
		time = 0.1;
	}
	wait(time);
	if(!isdefined(player))
	{
		return;
	}
	player.var_686890d5 = undefined;
	player.sessionstate = "spectator";
	player.spectatorclient = -1;
	player.killcamentity = -1;
	player.archivetime = 0;
	player.psoffsettime = 0;
	player.spectatekillcam = 0;
}

/*
	Name: function_9b2bd02c
	Namespace: display_transition
	Checksum: 0xCF6AA99F
	Offset: 0x998
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_9b2bd02c()
{
	player = self;
	player function_3f65d5d3();
	player function_61d01718(level.var_d1455682.var_87a42f09, #"elimination_transition");
}

/*
	Name: function_b3964dc9
	Namespace: display_transition
	Checksum: 0xE1988524
	Offset: 0x9F8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_b3964dc9()
{
	/#
		if(getdvarint(#"scr_disable_infiltration", 0))
		{
			return;
		}
	#/
	if(isdefined(level.var_a4c48e88) && level.var_a4c48e88)
	{
		return;
	}
	player = self;
	player function_3f65d5d3();
	player function_61d01718(level.var_d1455682.var_87a42f09, #"hash_ee32e40c182320b");
}

/*
	Name: function_f4c03c3b
	Namespace: display_transition
	Checksum: 0xEF0666D2
	Offset: 0xAA8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_f4c03c3b()
{
	if(isdefined(self.var_58f00ca2) && self.var_58f00ca2)
	{
		return;
	}
	self.var_58f00ca2 = 1;
	self thread function_61d01718(level.var_d1455682.var_87a42f09, #"hash_4a3306cfce6719bc");
}

/*
	Name: function_1caf5c87
	Namespace: display_transition
	Checksum: 0x6B89CFDC
	Offset: 0xB10
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_1caf5c87(team)
{
	players = getplayers(team);
	player::function_4dcd9a89(players, &function_3f65d5d3);
	foreach(player in players)
	{
		if(player != self)
		{
			player.var_58f00ca2 = 1;
			player thread function_61d01718(level.var_d1455682.var_87a42f09, #"hash_4a3306cfce6719bc");
		}
	}
	if(self.team == team)
	{
		self.var_58f00ca2 = 1;
		self function_61d01718(level.var_d1455682.var_87a42f09, #"hash_4a3306cfce6719bc");
	}
}

/*
	Name: function_3f65d5d3
	Namespace: display_transition
	Checksum: 0xD2B8DE71
	Offset: 0xC60
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_3f65d5d3()
{
	if(!isdefined(self.pers[#"team"]))
	{
		self [[level.spawnintermission]](1);
		return true;
	}
	return false;
}

/*
	Name: function_3cfb29e1
	Namespace: display_transition
	Checksum: 0x44C6173B
	Offset: 0xCA8
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_3cfb29e1()
{
	if(!util::waslastround())
	{
		self playlocalsound(#"hash_7353399f9153966f");
		self thread globallogic_audio::set_music_on_player("none");
		if(isdefined(self.pers[#"music"].spawn))
		{
			self.pers[#"music"].spawn = 0;
		}
	}
}

/*
	Name: freeze_player_for_round_end
	Namespace: display_transition
	Checksum: 0xA3967B22
	Offset: 0xD50
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private freeze_player_for_round_end()
{
	self player::freeze_player_for_round_end();
	self thread globallogic::roundenddof();
}

/*
	Name: function_ba94df6c
	Namespace: display_transition
	Checksum: 0xF6713522
	Offset: 0xD90
	Size: 0x38
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ba94df6c()
{
	self setclientuivisibilityflag("hud_visible", 0);
	self thread [[level.spawnintermission]](0);
}

/*
	Name: function_9185f489
	Namespace: display_transition
	Checksum: 0x86B20D7
	Offset: 0xDD0
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_9185f489(transition, outcome)
{
	globallogic::function_2556afb5(transition.var_20c0730c, transition.var_18d4b2ad, float(transition.var_3efb751d) / 1000);
}

/*
	Name: function_e22f5208
	Namespace: display_transition
	Checksum: 0xECE187B5
	Offset: 0xE40
	Size: 0x34
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e22f5208(transition, outcome)
{
	player::function_2f80d95b(&function_ba94df6c);
}

/*
	Name: function_a3b4d41d
	Namespace: display_transition
	Checksum: 0x6CBBC8A0
	Offset: 0xE80
	Size: 0x34
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a3b4d41d(transition, outcome)
{
	player::function_2f80d95b(&freeze_player_for_round_end);
}

/*
	Name: function_654c0030
	Namespace: display_transition
	Checksum: 0xBF838AC7
	Offset: 0xEC0
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_654c0030(transition, outcome)
{
	player::function_2f80d95b(&function_d7b5082e);
	thread globallogic_audio::announce_game_winner(outcome);
	player::function_2f80d95b(&globallogic_audio::function_6374b97e, outcome::get_flag(outcome, "tie"));
}

/*
	Name: function_d9d842b2
	Namespace: display_transition
	Checksum: 0xBDE6D962
	Offset: 0xF58
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_d9d842b2(transition, outcome)
{
	thread globallogic_audio::function_57678746(outcome);
}

/*
	Name: function_b7fec738
	Namespace: display_transition
	Checksum: 0x50972822
	Offset: 0xF90
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b7fec738(transition, outcome)
{
	thread globallogic_audio::announce_round_winner(0);
}

/*
	Name: function_66713ac
	Namespace: display_transition
	Checksum: 0x4F8AE427
	Offset: 0xFC8
	Size: 0x24
	Parameters: 2
	Flags: Linked, Private
*/
function private function_66713ac(transition, outcome)
{
	thread globallogic_audio::function_5e0a6842();
}

/*
	Name: function_8feabee3
	Namespace: display_transition
	Checksum: 0x452F6B4C
	Offset: 0xFF8
	Size: 0x24
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8feabee3(transition, outcome)
{
	thread globallogic_audio::function_dfd17bd3();
}

/*
	Name: function_26bbb839
	Namespace: display_transition
	Checksum: 0xBBA690B3
	Offset: 0x1028
	Size: 0x214
	Parameters: 2
	Flags: Linked, Private
*/
function private function_26bbb839(transition, outcome)
{
	thread function_b8e20f5f(transition, outcome, transition.slowdown, transition.var_d7f20c92, &function_9185f489);
	thread function_b8e20f5f(transition, outcome, transition.freezeplayers, transition.freezetime, &function_a3b4d41d);
	thread function_b8e20f5f(transition, outcome, transition.var_b0bc6ae0, transition.var_8d7c57a2, &function_8feabee3);
	thread function_b8e20f5f(transition, outcome, transition.var_619875ca, transition.var_73f860db, &function_b7fec738);
	thread function_b8e20f5f(transition, outcome, transition.var_7a712c7, transition.var_a803fe51, &function_66713ac);
	thread function_b8e20f5f(transition, outcome, transition.var_93a95648, transition.var_de820e2d, &function_654c0030);
	thread function_b8e20f5f(transition, outcome, transition.var_f9995c63, transition.var_41fc87a8, &function_d9d842b2);
	thread function_b8e20f5f(transition, outcome, transition.pickup_message, transition.var_5026a297, &function_e22f5208);
}

/*
	Name: checkroundswitch
	Namespace: display_transition
	Checksum: 0x5FB53968
	Offset: 0x1248
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function checkroundswitch()
{
	if(!isdefined(level.roundswitch) || !level.roundswitch)
	{
		return false;
	}
	if(!isdefined(level.onroundswitch))
	{
		return false;
	}
	/#
		assert(game.roundsplayed > 0);
	#/
	if((game.roundsplayed % level.roundswitch) == 0)
	{
		[[level.onroundswitch]]();
		return true;
	}
	return false;
}

/*
	Name: function_e3855f6d
	Namespace: display_transition
	Checksum: 0xD6678BC9
	Offset: 0x12E0
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e3855f6d(transition, outcome)
{
	if(util::waslastround())
	{
		return;
	}
	if(!(isdefined(level.var_3e7c197f) && level.var_3e7c197f) && !checkroundswitch())
	{
		return;
	}
	level.var_3e7c197f = 1;
	function_26bbb839(transition, outcome);
}

/*
	Name: function_a2d39e40
	Namespace: display_transition
	Checksum: 0x331BD2B5
	Offset: 0x1378
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a2d39e40(transition, outcome)
{
	globallogic::function_452e18ad();
	array::run_all(level.players, &hud_message::function_6be746c2);
	killcam::post_round_final_killcam();
}

/*
	Name: function_e3442abc
	Namespace: display_transition
	Checksum: 0x7920032F
	Offset: 0x13E0
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e3442abc(transition, outcome)
{
	globallogic::function_452e18ad();
	array::run_all(level.players, &hud_message::function_6be746c2);
	potm::post_round_potm();
}

/*
	Name: function_aed7dbe1
	Namespace: display_transition
	Checksum: 0x86FC5D23
	Offset: 0x1448
	Size: 0x6C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_aed7dbe1(p1, p2)
{
	if(p1.score != p2.score)
	{
		return p1.score > p2.score;
	}
	return p1 getentitynumber() <= p2 getentitynumber();
}

/*
	Name: function_e17d407e
	Namespace: display_transition
	Checksum: 0xE16C9346
	Offset: 0x14C0
	Size: 0x33C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e17d407e(transition, outcome)
{
	var_77d0878c = array();
	foreach(player in level.players)
	{
		if(player.team == outcome.team && player player_role::get() != 0)
		{
			array::add(var_77d0878c, player);
		}
	}
	player_positions = array();
	i = 0;
	for(;;)
	{
		pos = struct::get("team_pose_" + i, "targetname");
		if(isdefined(pos))
		{
			array::add(player_positions, pos);
		}
		else
		{
			break;
		}
		i++;
	}
	var_5a552ef6 = struct::get("team_pose_cam", "targetname");
	if(var_77d0878c.size == 0 || player_positions.size == 0 || !isdefined(var_5a552ef6))
	{
		return;
	}
	function_26bbb839(transition, outcome);
	var_77d0878c = array::quick_sort(var_77d0878c, &function_aed7dbe1);
	for(i = 0; i < min(var_77d0878c.size, player_positions.size); i++)
	{
		player = var_77d0878c[i];
		player.sessionstate = "playing";
		player takeallweapons();
		fields = getcharacterfields(player player_role::get(), currentsessionmode());
		if(i == 0)
		{
			player_positions[i] thread scene::play(fields.var_fa8365dc[0].scene, player);
			continue;
		}
		player_positions[i] thread scene::play(fields.var_728ccd3d[0].scene, player);
	}
	var_5a552ef6 thread scene::play("team_pose_cam");
}

/*
	Name: function_b3214a0a
	Namespace: display_transition
	Checksum: 0xE7877507
	Offset: 0x1808
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function function_b3214a0a(transition, outcome, var_61f85cf)
{
	if(isdefined(var_61f85cf))
	{
		if(var_61f85cf.type == "play_of_the_match")
		{
			level waittill(#"hash_4ead2cd3fa59f29b");
		}
		var_5a552ef6 = struct::get("team_pose_cam", "targetname");
		var_5a552ef6 thread scene::stop("team_pose_cam");
	}
}

/*
	Name: function_7e74281
	Namespace: display_transition
	Checksum: 0xF77248DE
	Offset: 0x18B0
	Size: 0x1E2
	Parameters: 0
	Flags: Linked
*/
function function_7e74281()
{
	level.var_3a309902[#"blank"] = &function_26bbb839;
	level.var_3a309902[#"outcome"] = &function_26bbb839;
	level.var_3a309902[#"outcome_with_score"] = &function_26bbb839;
	level.var_3a309902[#"outcome_with_time"] = &function_26bbb839;
	level.var_3a309902[#"switch_sides"] = &function_e3855f6d;
	level.var_3a309902[#"final_killcam"] = &function_a2d39e40;
	level.var_3a309902[#"play_of_the_match"] = &function_e3442abc;
	level.var_3a309902[#"team_pose"] = &function_e17d407e;
	level.var_3a309902[#"high_value_operatives"] = &function_26bbb839;
	level.var_5d720398[#"team_pose"] = &function_b3214a0a;
}

/*
	Name: function_b797319e
	Namespace: display_transition
	Checksum: 0xABEDEC03
	Offset: 0x1AA0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_b797319e(transition_type, var_e6825eda)
{
	self luinotifyevent(transition_type, 1, var_e6825eda);
}

/*
	Name: function_752a920f
	Namespace: display_transition
	Checksum: 0x4962A91A
	Offset: 0x1AE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_752a920f()
{
	self luinotifyevent(#"clear_transition");
}

/*
	Name: function_d7b5082e
	Namespace: display_transition
	Checksum: 0x807AD83F
	Offset: 0x1B10
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_d7b5082e()
{
	if(isdefined(self.pers[#"totalmatchbonus"]))
	{
		self luinotifyevent(#"hash_9dfc8d44ea4547e", 1, self.pers[#"totalmatchbonus"]);
	}
}

/*
	Name: display_transition
	Namespace: display_transition
	Checksum: 0x9BF6EFDD
	Offset: 0x1B78
	Size: 0x8E
	Parameters: 4
	Flags: Linked
*/
function display_transition(transition, var_e6825eda, outcome, lui_event)
{
	level thread globallogic::sndsetmatchsnapshot(2);
	player::function_e7f18b20(&function_b797319e, lui_event, var_e6825eda + 1);
	[[level.var_3a309902[transition.type]]](transition, outcome);
}

/*
	Name: function_f2ffece2
	Namespace: display_transition
	Checksum: 0x6DBF3FD4
	Offset: 0x1C10
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function function_f2ffece2(transition, outcome, var_61f85cf)
{
	if(isdefined(level.var_5d720398[transition.type]))
	{
		level thread [[level.var_5d720398[transition.type]]](transition, outcome, var_61f85cf);
	}
}

/*
	Name: clear_transition
	Namespace: display_transition
	Checksum: 0x7E72CBA0
	Offset: 0x1C80
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function clear_transition()
{
	player::function_2f80d95b(&function_752a920f);
	array::run_all(level.players, &hud_message::function_6be746c2);
}

/*
	Name: function_40a46b5b
	Namespace: display_transition
	Checksum: 0x9FAE0F8
	Offset: 0x1CD8
	Size: 0x280
	Parameters: 2
	Flags: Linked
*/
function function_40a46b5b(transition, outcome)
{
	if(isdefined(transition.disable) && transition.disable)
	{
		return true;
	}
	if(isdefined(transition.var_b5dabc6b) && transition.var_b5dabc6b)
	{
		if(util::waslastround() || util::isoneround())
		{
			return true;
		}
	}
	var_860cd9fa = isdefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]();
	if(isdefined(level.shouldplayovertimeround) && [[level.shouldplayovertimeround]]())
	{
		if(isdefined(transition.var_d0f2da62) && transition.var_d0f2da62)
		{
			return true;
		}
	}
	else if(isdefined(transition.var_fb87c2b4) && transition.var_fb87c2b4)
	{
		return true;
	}
	if(overtime::is_overtime_round())
	{
		if(isdefined(transition.var_e0d86f3) && transition.var_e0d86f3)
		{
			return true;
		}
	}
	else if(isdefined(transition.var_7b778818) && transition.var_7b778818)
	{
		return true;
	}
	if(transition.type == "team_pose")
	{
		if(outcome.team == #"free")
		{
			return true;
		}
		if(!isdefined(struct::get("team_pose_cam", "targetname")))
		{
			return true;
		}
	}
	if(transition.type == "switch_sides")
	{
		if(!(isdefined(level.roundswitch) && level.roundswitch))
		{
			return true;
		}
	}
	if(transition.type == "outcome")
	{
		if(isdefined(level.var_67a68459) && level.var_67a68459)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_7e8f8c47
	Namespace: display_transition
	Checksum: 0x6CD5651D
	Offset: 0x1F60
	Size: 0x174
	Parameters: 3
	Flags: Linked
*/
function function_7e8f8c47(transitions, outcome, lui_event)
{
	foreach(index, transition in transitions)
	{
		if(function_40a46b5b(transition, outcome))
		{
			continue;
		}
		level notify(#"display_transition", index, transition, outcome);
		display_transition(transition, index, outcome, lui_event);
		if((isdefined(transition.time) ? transition.time : 0) != 0)
		{
			round_end_wait(float(transition.time) / 1000);
		}
		function_f2ffece2(transition, outcome, transitions[index + 1]);
	}
	clear_transition();
}

/*
	Name: function_15e28b1a
	Namespace: display_transition
	Checksum: 0xB1C272C3
	Offset: 0x20E0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_15e28b1a(outcome)
{
	function_7e8f8c47(level.var_d1455682.var_3e72919, outcome, #"match_transition");
}

/*
	Name: function_cf3d556b
	Namespace: display_transition
	Checksum: 0x1ABD7972
	Offset: 0x2128
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_cf3d556b(outcome)
{
	if(isdefined(level.var_d1455682.var_e779605d) && level.var_d1455682.var_e779605d)
	{
		if(util::waslastround() || util::isoneround())
		{
			return;
		}
	}
	transitions = level.var_d1455682.var_573005c3;
	if(!isdefined(transitions))
	{
		return;
	}
	function_7e8f8c47(transitions, outcome, #"round_transition");
}

/*
	Name: round_end_wait
	Namespace: display_transition
	Checksum: 0x2D3C244B
	Offset: 0x21F0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function round_end_wait(time)
{
	if(time <= 0)
	{
		return;
	}
	level waittilltimeout(time * level.var_49d9aa70, #"hash_197c640e2f684a74");
}

/*
	Name: function_ad717b18
	Namespace: display_transition
	Checksum: 0x5C6F6014
	Offset: 0x2240
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function function_ad717b18(var_c139bfe2)
{
	/#
		assert(isdefined(level.roundenddelay[var_c139bfe2]));
	#/
	delay = level.roundenddelay[var_c139bfe2] * level.var_49d9aa70;
	if(delay)
	{
		return;
	}
	var_f05b8779 = delay / 2;
	if(var_f05b8779 > 0)
	{
		wait(var_f05b8779);
		var_f05b8779 = delay / 2;
	}
	else
	{
		var_f05b8779 = (delay / 2) + var_f05b8779;
	}
	level notify(#"give_match_bonus");
	if(var_f05b8779 > 0)
	{
		wait(var_f05b8779);
	}
}

