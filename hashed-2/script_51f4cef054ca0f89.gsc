// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_111d4fea7428184e;
#using script_164ba4a711296dd5;
#using script_16cb0a6a492a6a4f;
#using script_18309c5377e297c0;
#using script_1f2f7ef27f2aabba;
#using script_256b8879317373de;
#using script_290b3da82a2a68e4;
#using script_29ed825598140ca0;
#using script_2c49ae69cd8ce30c;
#using script_38755604e51a604e;
#using script_3f9e54c7a9a7e1e2;
#using script_47fb62300ac0bd60;
#using script_4bf0b8603057e5ac;
#using script_55e622b35104ba68;
#using script_5cd62dd0736e797d;
#using script_5ebc70029e06b264;
#using script_64176e152a2cbf82;
#using script_65d4fc42e5e94766;
#using script_66052559f4fc2bf9;
#using script_6c8abe14025b47c4;
#using script_737b89ed0025745;
#using script_7452a079afe69150;
#using script_75be2950b381443;
#using script_788472602edbe3b9;
#using script_9279a21b1e8b6c9;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\death_circle.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\bb.gsc;
#using scripts\mp_common\gameadvertisement.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\dogtags.gsc;
#using scripts\mp_common\gametypes\gametype.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\menus.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\util.gsc;
#using scripts\wz_common\player.gsc;
#using scripts\wz_common\vehicle.gsc;

#namespace warzone;

/*
	Name: main
	Namespace: warzone
	Checksum: 0xDBEA0090
	Offset: 0x800
	Size: 0xECC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level.var_87bcb1b = 0;
	globallogic::init();
	util::registerroundswitch(0, 9);
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
	level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
	level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
	level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
	level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
	level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
	level.var_79219af4 = 0;
	if(getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0)
	{
		level.var_79219af4 = (isdefined(getgametypesetting(#"hash_21ff0f3139be8f97")) ? getgametypesetting(#"hash_21ff0f3139be8f97") : 0);
	}
	level.var_4cea2bec = (isdefined(getgametypesetting(#"hash_6cc7b012775d9662")) ? getgametypesetting(#"hash_6cc7b012775d9662") : 0);
	level.var_6c900548 = (isdefined(getgametypesetting(#"hash_2b3e56efad3a1504")) ? getgametypesetting(#"hash_2b3e56efad3a1504") : 0);
	level.var_e16a689f = (isdefined(getgametypesetting(#"hash_557cb4680634f585")) ? getgametypesetting(#"hash_557cb4680634f585") : 0);
	level.var_f97a6ba3 = 1;
	level.overrideteamscore = 1;
	level.onstartgametype = &function_d81f6eb7;
	level.onspawnplayer = &on_spawn_player;
	level.onroundswitch = &on_round_switch;
	level.var_f6d301b = &function_66cbd790;
	level.onendgame = &on_end_game;
	level.ondeadevent = &function_40843d72;
	level.ononeleftevent = &function_80efb8b1;
	level.givecustomloadout = &function_511245ae;
	level.var_a962eeb6 = &function_486a8395;
	level.var_a3e209ba = &function_a3e209ba;
	level.var_3a0bbaea = 0;
	level.var_5495fbf1 = 0;
	level.var_e7b05b51 = 0;
	level.var_674e8051 = 1;
	level.var_827f5a28 = 1;
	level.var_3d984b4c = 0;
	level.var_36a111f3 = &function_10dc43bc;
	level.disableweapondrop = 1;
	level.var_a2915a68 = insertion_passenger_count::register("insertionPassengerElem");
	level.var_a3c0d635 = &insertion_passenger_count::is_open;
	level.var_f3320ad2 = &insertion_passenger_count::open;
	level.var_81b39a59 = &insertion_passenger_count::close;
	level.var_ce84dde9 = &insertion_passenger_count::set_count;
	level.var_ec375172 = &function_ec375172;
	level.var_eed7c027 = [];
	level.resurrect_override_spawn = &spawn::function_b76a2e3f;
	if(isdefined(getgametypesetting(#"hash_5b7b817a91ce3534")) && getgametypesetting(#"hash_5b7b817a91ce3534"))
	{
		level.var_30783ca9 = &function_b3f02397;
	}
	clientfield::register("worlduimodel", "hudItems.warzone.collapseTimerState", 1, 2, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.collapseProgress", 1, 7, "float");
	clientfield::register("worlduimodel", "hudItems.warzone.reinsertionPassengerCount", 1, 7, "int");
	clientfield::function_a8bbc967("hudItems.distanceFromDeathCircle", 1, 7, "float", 0);
	clientfield::function_a8bbc967("hudItems.alivePlayerCount", 1, 7, "int", 0);
	clientfield::function_a8bbc967("hudItems.alivePlayerCountEnemy", 1, 7, "int", 0);
	clientfield::function_a8bbc967("hudItems.aliveTeammateCount", 1, 7, "int", 1);
	clientfield::function_a8bbc967("hudItems.spectatorsCount", 1, 7, "int", 1);
	clientfield::function_a8bbc967("hudItems.playerKills", 1, 7, "int", 0);
	clientfield::function_a8bbc967("hudItems.playerCleanUps", 1, 7, "int", 0);
	clientfield::function_a8bbc967("presence.modeparam", 1, 7, "int", 1);
	clientfield::function_a8bbc967("hudItems.hasBackpack", 1, 1, "int", 0);
	clientfield::function_a8bbc967("hudItems.armorType", 1, 2, "int", 0);
	clientfield::function_a8bbc967("hudItems.streamerLoadFraction", 1, 5, "float", 1);
	clientfield::function_a8bbc967("hudItems.wzLoadFinished", 1, 1, "int", 1);
	clientfield::function_a8bbc967("hudItems.showReinsertionPassengerCount", 1, 1, "int", 0);
	clientfield::function_a8bbc967("hudItems.playerLivesRemaining", 15000, 3, "int");
	clientfield::function_a8bbc967("hudItems.playerCanRedeploy", 15000, 1, "int");
	clientfield::function_a8bbc967("hudItems.playerOnInfectedPlatoon", 21000, 1, "int");
	clientfield::register("allplayers", "eliminator_screen", 1, 1, "int");
	clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.collapse", 11000, 21, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.waveRespawnTimer", 15000, 21, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.collapseIndex", 1, 3, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.collapseCount", 1, 3, "int");
	clientfield::register("worlduimodel", "hudItems.warzone.reinsertionIndex", 1, 3, "int");
	callback::on_player_killed_with_params(&function_c1a417ee);
	player::function_cf3aa03d(&player_killed);
	callback::on_spawned(&on_player_spawned);
	callback::on_connect(&on_player_connect);
	callback::on_disconnect(&on_player_disconnect);
	callback::function_98a0917d(&function_1bcd6e1e);
	callback::add_callback(#"hash_6b7d26d34885b425", &function_4012c0ab);
	callback::add_callback(#"hash_84d8c1164d90313", &function_5af3a29);
	globallogic_spawn::addsupportedspawnpointtype("tdm");
	function_aaa24662();
	level.var_bde3d03 = &function_b777ff94;
	setdvar(#"hash_53e6eeca9f56d0bf", 1);
	setdvar(#"hash_7036719f41a78d54", 50);
	setdvar(#"hash_6d545f685fa213dd", 3);
	setdvar(#"scr_deleteexplosivesonspawn", 0);
	level.var_6adbdb63 = 1;
	level.var_b219667f = 1;
	level thread function_23600e7d();
	if(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312"))
	{
		key = "warSpectreRisingStart";
	}
	else if(isdefined(getgametypesetting(#"hash_53d529e82bcf1212")) && getgametypesetting(#"hash_53d529e82bcf1212"))
	{
		key = "hcStartWarzone";
	}
	else if(isdefined(getgametypesetting(#"hash_4ff7ee3c3a534065")) && getgametypesetting(#"hash_4ff7ee3c3a534065"))
	{
		key = "warZombieStart";
	}
	else
	{
		key = "startWarzone";
	}
	globallogic_audio::set_leader_gametype_dialog(key, undefined, undefined, undefined);
	level.var_606becce = [];
	level callback::add_callback(#"hash_7119d854cd41a4fd", &function_61c315e0);
	/#
		callback::on_vehicle_spawned(&function_5d7553c9);
		level.var_5efad16e = &function_73b0f715;
		var_34e67a68 = getdvarstring(#"hash_22388768f7c15ebc", "");
		if(var_34e67a68 != "")
		{
			level.var_34e67a68 = var_34e67a68;
		}
		level thread function_c2a75696();
	#/
}

/*
	Name: on_spawn_player
	Namespace: warzone
	Checksum: 0x1E448730
	Offset: 0x16D8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function on_spawn_player()
{
	spawn::on_spawn_player();
	if(infection::function_74650d7())
	{
		platoon = function_22448d6c(self.team);
		var_8cc84817 = infection::function_76601b7d();
		if(var_8cc84817 != #"none" && platoon == infection::function_76601b7d())
		{
			self infection::function_c37a6757();
			self player::spawn_player();
		}
	}
}

/*
	Name: function_5d7553c9
	Namespace: warzone
	Checksum: 0x2B286512
	Offset: 0x17A8
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function function_5d7553c9()
{
	/#
		if(game.state == "")
		{
			return;
		}
		if(level flagsys::get(#"hash_38a387462f3a9ad"))
		{
			return;
		}
		if(!isdefined(self.scriptvehicletype))
		{
			return;
		}
		if(!isdefined(level.var_9c103fe0))
		{
			return;
		}
		if(!isinarray(level.var_9c103fe0, self.scriptvehicletype))
		{
			return;
		}
		if(self isremotecontrol())
		{
			return;
		}
		if(!isdefined(level.spawned_vehicles))
		{
			level.spawned_vehicles = 0;
		}
		level.spawned_vehicles++;
		if(getdvarint(#"hash_10daadecda56ef52", 1) && level.spawned_vehicles > 80)
		{
			/#
				assert(level.spawned_vehicles <= 80, "");
			#/
		}
	#/
}

/*
	Name: function_c2a75696
	Namespace: warzone
	Checksum: 0x318ABC98
	Offset: 0x18E8
	Size: 0x130
	Parameters: 0
	Flags: Private
*/
private function function_c2a75696()
{
	/#
		mapname = util::function_53bbf9d2();
		adddebugcommand("" + mapname + "");
		adddebugcommand("" + mapname + "");
		while(true)
		{
			waitframe(1);
			string = getdvarstring(#"hash_68a6ac70f8821d9d", "");
			switch(string)
			{
				case "start":
				{
					function_73b0f715();
					break;
				}
				default:
				{
					break;
				}
			}
			setdvar(#"hash_68a6ac70f8821d9d", "");
		}
	#/
}

/*
	Name: function_75189494
	Namespace: warzone
	Checksum: 0x8412A6B5
	Offset: 0x1A20
	Size: 0x84
	Parameters: 3
	Flags: Linked, Private
*/
private function function_75189494(var_c6ce2627, playercount, var_404397c4)
{
	data = {#hash_4a2854ac:var_404397c4, #hash_f388074a:playercount, #hash_19b5b856:var_c6ce2627};
	function_92d1707f(#"hash_7bcd081bd6940681", data);
}

/*
	Name: function_23600e7d
	Namespace: warzone
	Checksum: 0x7F8D669F
	Offset: 0x1AB0
	Size: 0xF10
	Parameters: 0
	Flags: Linked, Private
*/
private function function_23600e7d()
{
	var_26ef8eea = (isdefined(getgametypesetting(#"hash_bd1199baafe11fe")) ? getgametypesetting(#"hash_bd1199baafe11fe") : 1);
	/#
		var_26ef8eea = 0;
	#/
	if(var_26ef8eea && !isdedicated())
	{
		/#
			println("");
		#/
		return;
	}
	if(getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0)
	{
		/#
			println("");
		#/
		return;
	}
	while(!isdefined(game.state) || game.state != "pregame")
	{
		waitframe(1);
	}
	while(!isdefined(level.activeplayers))
	{
		waitframe(1);
	}
	while(level.activeplayers.size == 0)
	{
		waitframe(1);
	}
	if(getdvarint(#"hash_4ea975785ad6baf9", 0) != 0)
	{
		/#
			println("");
		#/
		level function_73b0f715();
		return;
	}
	level endon(#"hash_1c605a92cc507414");
	level.var_8fcd8a61 = (isdefined(getgametypesetting(#"hash_35c2d850e39fa704")) ? getgametypesetting(#"hash_35c2d850e39fa704") : 100);
	level.var_e9d6c52f = (isdefined(getgametypesetting(#"hash_46f957248efbd39a")) ? getgametypesetting(#"hash_46f957248efbd39a") : 10);
	level.var_f414be13 = (isdefined(getgametypesetting(#"hash_21e0d28e8692d5a")) ? getgametypesetting(#"hash_21e0d28e8692d5a") : 4);
	level.var_9290cd7c = (isdefined(getgametypesetting(#"hash_368f9b5b4992b8da")) ? getgametypesetting(#"hash_368f9b5b4992b8da") : 20);
	level.var_8ca0499 = (isdefined(getgametypesetting(#"hash_ad6c0d1cd92c1fe")) ? getgametypesetting(#"hash_ad6c0d1cd92c1fe") : 30);
	level.var_493d04d3 = (isdefined(getgametypesetting(#"hash_28233b1037888945")) ? getgametypesetting(#"hash_28233b1037888945") : 15);
	level.max_wait_time = (isdefined(getgametypesetting(#"max_wait_time")) ? getgametypesetting(#"max_wait_time") : 0);
	level.var_3f631d69 = (isdefined(getgametypesetting(#"hash_2d4ff63e866cdd74")) ? getgametypesetting(#"hash_2d4ff63e866cdd74") : 120);
	if(level.var_9290cd7c <= 0)
	{
		level.var_9290cd7c = 1;
	}
	level.var_25fc8e84 = int(ceil(level.max_wait_time * 60 / level.var_9290cd7c));
	starttime = gettime();
	var_fb9555e1 = 3;
	level.var_a132ca2b = level.var_8fcd8a61;
	level.var_7dc1df3a = spawnstruct();
	level.var_7dc1df3a.var_e2382b29 = level.var_8fcd8a61;
	var_e09e5160 = level.activeplayers.size;
	var_761c5049 = 0;
	/#
		println("" + starttime);
	#/
	/#
		println("" + level.var_8fcd8a61);
	#/
	/#
		println("" + level.var_e9d6c52f);
	#/
	/#
		println("" + level.var_f414be13);
	#/
	/#
		println("" + level.var_9290cd7c);
	#/
	/#
		println("" + level.var_8ca0499);
	#/
	/#
		println("" + level.var_493d04d3);
	#/
	/#
		println("" + level.max_wait_time);
	#/
	/#
		println("" + level.var_3f631d69);
	#/
	/#
		println("" + level.var_25fc8e84);
	#/
	/#
		println("" + level.var_a132ca2b);
	#/
	while(true)
	{
		/#
			println("");
		#/
		/#
			println("" + var_761c5049);
		#/
		if(getdvarint(#"hash_2cc9b0ef1896d89a", 1) != 0)
		{
			/#
				println("");
			#/
			level.var_7dc1df3a = undefined;
			return;
		}
		if(level.max_wait_time > 0 && level.var_25fc8e84 <= 0)
		{
			level.var_a132ca2b = level.var_e9d6c52f;
			level.var_8ca0499 = level.var_3f631d69;
			level.var_493d04d3 = 0;
			/#
				println("" + level.max_wait_time + "");
			#/
			/#
				println("" + level.var_a132ca2b + "" + level.var_8ca0499);
			#/
		}
		if(level.activeplayers.size >= level.var_a132ca2b)
		{
			level.var_7dc1df3a.var_7be962bb = level.activeplayers.size;
			level.var_7dc1df3a.var_7d960258 = level.var_a132ca2b;
			if(level.activeplayers.size < level.var_8fcd8a61)
			{
				/#
					println("" + level.var_8fcd8a61 + "" + level.activeplayers.size);
				#/
				if(level.var_8ca0499 > 0)
				{
					timeleft = level.var_8ca0499;
					/#
						println("" + level.var_8ca0499);
					#/
					while(timeleft > 0)
					{
						timeleft = timeleft - 1;
						wait(1);
						if(level.activeplayers.size >= level.var_8fcd8a61)
						{
							break;
						}
					}
					level.var_7dc1df3a.var_a104a7da = level.activeplayers.size - level.var_7dc1df3a.var_7be962bb;
				}
			}
			if(level.activeplayers.size < level.var_a132ca2b)
			{
				wait(5);
				var_fb9555e1 = 3;
				continue;
			}
			/#
				println("");
			#/
			gameadvertisement::setadvertisedstatus(0);
			level.var_7dc1df3a.duration = gettime() - starttime;
			/#
				println("" + gettime());
			#/
			level function_73b0f715();
			return;
		}
		if(level.var_493d04d3 <= 0 && level.activeplayers.size < level.var_e9d6c52f)
		{
			if(var_fb9555e1 > 0)
			{
				/#
					println("" + level.activeplayers.size);
				#/
				wait(5);
				var_fb9555e1--;
				/#
					println("" + var_fb9555e1);
				#/
				continue;
			}
			function_75189494(gettime() - starttime, level.activeplayers.size, level.var_e9d6c52f);
			/#
				println("" + gettime());
			#/
			level.var_7dc1df3a = undefined;
			exitlevel(0, #"hash_35b5848d9f1b58e0");
			return;
		}
		/#
			println("");
		#/
		/#
			println("" + level.activeplayers.size);
		#/
		/#
			println("" + level.var_a132ca2b);
		#/
		if(level.activeplayers.size < level.var_a132ca2b)
		{
			var_7bce82a7 = level.activeplayers.size - var_e09e5160;
			if(var_7bce82a7 >= 3)
			{
				/#
					println("" + var_7bce82a7);
				#/
				if(level.var_a132ca2b < level.var_8fcd8a61 - level.maxteamplayers)
				{
					var_b0c8b797 = level.var_a132ca2b - level.activeplayers.size;
					if(var_b0c8b797 < 4 * level.maxteamplayers)
					{
						level.var_a132ca2b = level.var_a132ca2b + level.maxteamplayers;
						/#
							println("" + level.var_a132ca2b);
						#/
					}
				}
				var_e09e5160 = level.activeplayers.size;
				wait(2);
				/#
					println("" + var_761c5049);
				#/
				continue;
			}
		}
		var_761c5049++;
		var_e09e5160 = level.activeplayers.size;
		/#
			println("" + level.var_9290cd7c);
		#/
		timeleft = level.var_9290cd7c;
		while(timeleft > 0)
		{
			timeleft = timeleft - 1;
			wait(1);
			if(level.activeplayers.size >= level.var_a132ca2b)
			{
				break;
			}
		}
		if(level.activeplayers.size < level.var_a132ca2b)
		{
			level.var_a132ca2b = level.var_a132ca2b - level.var_f414be13;
			if(level.var_a132ca2b < level.var_e9d6c52f)
			{
				level.var_a132ca2b = level.var_e9d6c52f;
			}
		}
		if(level.var_25fc8e84 > 0)
		{
			level.var_25fc8e84--;
		}
		if(level.var_493d04d3 > 0)
		{
			level.var_493d04d3--;
		}
		/#
			println("" + level.var_a132ca2b);
		#/
		/#
			println("" + level.var_493d04d3);
		#/
		/#
			println("");
		#/
	}
}

/*
	Name: function_d81f6eb7
	Namespace: warzone
	Checksum: 0x590FD289
	Offset: 0x29C8
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function function_d81f6eb7()
{
	level.callbackplayerlaststand = &namespace_2daa33c5::playerlaststand;
	level.displayroundendtext = 0;
	level.usestartspawns = 0;
	level.var_992e9235 = [];
	level thread spawn::function_e93291ff();
	level.var_86513cd0 = &function_3b0db3c2;
	level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07);
	level flagsys::clear(#"spawning_allowed");
	function_414115a0();
	namespace_8e41fc17::register_handler(#"warzombiestart", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warspectrerisinginfiltration", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warboostinfiltration", &function_8076d591);
	namespace_8e41fc17::register_handler(#"hcwarboostinfiltration", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warpilotbail", &function_8e7ae35);
	namespace_8e41fc17::register_handler(#"warcircledetectedfirst", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warcircledetectedlast", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warcircledetected", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warcirclecollapseimminent", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warcirclecollapseoccurring", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warsupplydropincoming", &function_8076d591);
	namespace_8e41fc17::register_handler(#"warteamwon", &function_8076d591);
	namespace_8e41fc17::register_handler(#"hash_62888dc8c07f757a", &function_8076d591);
	setdvar(#"hash_2b903fa2368b18c9", 0);
	if(isdefined(level.var_4cea2bec) && level.var_4cea2bec)
	{
		level thread function_6ee52dd0(level.var_6c900548, level.var_e16a689f);
	}
	level thread function_5db32126();
}

/*
	Name: function_bcde1e07
	Namespace: warzone
	Checksum: 0xECF407A0
	Offset: 0x2D98
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_bcde1e07()
{
	level flagsys::clear(#"spawning_allowed");
	namespace_67838d10::function_bcde1e07();
}

/*
	Name: function_3b0db3c2
	Namespace: warzone
	Checksum: 0x468C637
	Offset: 0x2DD8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_3b0db3c2()
{
	level.prematchperiod = max(level.prematchperiod, 5);
	level thread namespace_12d19e59::start();
	level waittill(#"hash_78e53817cafb5265");
	level thread namespace_12d19e59::stop();
	/#
		println("");
	#/
	gameadvertisement::setadvertisedstatus(0);
}

/*
	Name: function_70171add
	Namespace: warzone
	Checksum: 0xA57F2B4F
	Offset: 0x2E90
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_70171add()
{
	if(randomfloat(1) <= getdvarfloat(#"survey_chance", 0))
	{
		return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
	}
	return 0;
}

/*
	Name: function_272029d0
	Namespace: warzone
	Checksum: 0xD44B063F
	Offset: 0x2F18
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_272029d0()
{
	/#
		if(getdvarint(#"hash_6fd0fd3292f07618", 0))
		{
			level.var_bde3d03 = undefined;
			level flagsys::set(#"hash_5a3e17fbc33cdc86");
			return;
		}
		while(getplayers().size == 0)
		{
			wait(0.5);
		}
	#/
	level flagsys::set(#"spawning_allowed");
	level namespace_67838d10::function_8dcd8623();
}

/*
	Name: function_a9822793
	Namespace: warzone
	Checksum: 0x3ADC830B
	Offset: 0x2FE8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_a9822793()
{
	if(getdvarint(#"hash_761d80face4c4459", 0))
	{
		return;
	}
	var_3ff328e2 = gamemodeismode(1) || gamemodeismode(7);
	if(var_3ff328e2)
	{
		return;
	}
	teams::function_a9822793();
}

/*
	Name: function_1bcd6e1e
	Namespace: warzone
	Checksum: 0x66E71346
	Offset: 0x3070
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function function_1bcd6e1e()
{
	level notify(#"hash_1c605a92cc507414");
	if(infection::function_74650d7())
	{
		infection::function_fb163563(#"hash_78eec1ce4940c8e8");
		infection::function_153000d0(#"hash_26cbd829e32a90c5", #"hash_197817ab19e99648");
	}
	/#
		println("");
	#/
	gameadvertisement::setadvertisedstatus(0);
	function_a9822793();
	if(isdefined(level.var_f220c297) && level.var_f220c297)
	{
		level callback::add_callback(#"hash_3057417db7f8acdd", &function_77319881);
	}
	if(sessionmodeisonlinegame() && getdvarint(#"hash_6aad986495699040", 0) != 0)
	{
		function_f539d880();
	}
	function_65469e2e();
	function_d547b972();
	level thread function_fbb2b180();
	level thread wz_ai::ai_init();
	level function_272029d0();
	level.ingraceperiod = 0;
	level.var_bde3d03 = undefined;
	var_f9adbf05 = function_70171add();
	foreach(player in getplayers())
	{
		player spawn::function_8cef1872();
		player val::reset(#"hash_2c372a1c55b534a4", "takedamage");
		if(sessionmodeisonlinegame())
		{
			player stats::function_7a850245(#"demofileid", getdemofileid());
			if(level.rankedmatch)
			{
				player stats::function_7a850245("surveyId", var_f9adbf05);
			}
		}
	}
	spawn::function_cb5864fc();
}

/*
	Name: function_fbb2b180
	Namespace: warzone
	Checksum: 0xD83E4124
	Offset: 0x33B8
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fbb2b180()
{
	level flagsys::wait_till(#"hash_5a3e17fbc33cdc86");
	function_3ca3c6e4();
	resetglass();
	if(isdefined(level.var_82eb1dab))
	{
		foreach(deathmodel in level.var_82eb1dab)
		{
			deathmodel delete();
		}
		level.var_82eb1dab = undefined;
	}
	level flagsys::set(#"hash_507a4486c4a79f1d");
}

/*
	Name: on_player_connect
	Namespace: warzone
	Checksum: 0xDEBAC9DB
	Offset: 0x34C0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.var_63af7f75 = -1;
	self.var_c5134737 = 1;
	level function_22df4165();
	self namespace_d3564fd8::function_456aacb1();
}

/*
	Name: on_player_disconnect
	Namespace: warzone
	Checksum: 0xE9E07BEB
	Offset: 0x3518
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	self namespace_d3564fd8::player_disconnected();
	level function_22df4165();
}

/*
	Name: function_ec2c9808
	Namespace: warzone
	Checksum: 0xBCA7838E
	Offset: 0x3558
	Size: 0x1A0
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ec2c9808(response, intpayload)
{
	if(!isalive(self) && !player::function_73da2f89())
	{
		return;
	}
	foreach(player in getplayers())
	{
		if(player.team === self.team)
		{
			if(response == "placed")
			{
				xcoord = int(intpayload / 1000);
				ycoord = intpayload - xcoord * 1000;
				player luinotifyevent(#"hash_34bb692dbc392d7f", 3, self getentitynumber(), xcoord, ycoord);
				continue;
			}
			if(response == "removed")
			{
				player luinotifyevent(#"hash_123261c89a0bc7a", 1, self getentitynumber());
			}
		}
	}
}

/*
	Name: function_cc47bb2f
	Namespace: warzone
	Checksum: 0xAFA9A779
	Offset: 0x3700
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_cc47bb2f()
{
	if(game.state == "pregame")
	{
		return 1;
	}
	return 0;
}

/*
	Name: on_player_spawned
	Namespace: warzone
	Checksum: 0xAF97742D
	Offset: 0x3730
	Size: 0x612
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"death");
	level endon(#"game_ended");
	if((isdefined(getgametypesetting(#"hash_24918193d72a5866")) ? getgametypesetting(#"hash_24918193d72a5866") : 0))
	{
		self setperk(#"hash_1a1660312a4db585");
		self setperk(#"specialty_fallheight");
	}
	self.var_1ab1ec0c = self.origin;
	self namespace_2daa33c5::function_7e714b6a();
	level function_22df4165();
	character_index = self getcharacterbodytype();
	fields = getcharacterfields(character_index, currentsessionmode());
	if(isdefined(fields))
	{
		if(isdefined(fields.var_9c1be670) && fields.var_9c1be670)
		{
			self hidepart("tag_ability_hero");
		}
		if(isdefined(fields.var_1b216715) && fields.var_1b216715)
		{
			self hidepart("tag_equipment_hero");
		}
	}
	if(isdefined(self.pers) && isdefined(self.pers[#"lives"]))
	{
		self spawn::function_1390f875(self.pers[#"lives"]);
		if(infection::function_74650d7() && self infection::function_bf46a7aa())
		{
			if(function_47851c07())
			{
				self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 1);
				self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 1);
				self.var_874448e8 = 1;
			}
			else
			{
				self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
			}
		}
		else if(self.pers[#"lives"] != 1 && (!(isdefined(self.var_874448e8) && self.var_874448e8)))
		{
			self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 1);
			self.var_874448e8 = 1;
		}
		if(self.pers[#"lives"] == 1)
		{
			self clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
		}
	}
	self menus::register_menu_response_callback("WaypointPlaced", &function_ec2c9808);
	if(function_cc47bb2f())
	{
		self val::reset(#"spawn_player", "freezecontrols");
		self val::reset(#"spawn_player", "disablegadgets");
		self val::set(#"hash_2c372a1c55b534a4", "takedamage", 0);
		if(level.var_79219af4 > 0 && level.activeplayers.size + 1 >= level.var_79219af4)
		{
			level function_73b0f715();
		}
	}
	else if(infection::function_74650d7() && self infection::function_bf46a7aa())
	{
		self infection::function_8bdd6715();
	}
	else
	{
		/#
			self menus::register_menu_response_callback("", &function_ec2c9808);
			return;
		#/
		if(getdvarint(#"hash_6fd0fd3292f07618", 0))
		{
		}
		var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
		self clientfield::set_to_player("realtime_multiplay", 1);
		switch(var_7eb8f61a)
		{
			case 0:
			{
				self thread namespace_c2bb938a::function_584c9f1();
				break;
			}
			case 1:
			{
				self thread namespace_c2bb938a::function_39a51e47();
				break;
			}
			case 2:
			{
				self thread namespace_c2bb938a::function_3c4884f1();
				break;
			}
		}
	}
}

/*
	Name: on_round_switch
	Namespace: warzone
	Checksum: 0xADFE711E
	Offset: 0x3D50
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function on_round_switch()
{
	gametype::on_round_switch();
	globallogic_score::updateteamscorebyroundswon();
}

/*
	Name: function_66cbd790
	Namespace: warzone
	Checksum: 0xAEED2A51
	Offset: 0x3D80
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_66cbd790(var_c1e98979)
{
	function_f1394038();
	function_16e6bd2e(var_c1e98979);
}

/*
	Name: function_74a8f2ed
	Namespace: warzone
	Checksum: 0x882BCC22
	Offset: 0x3DC0
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function function_74a8f2ed(var_d3ba512b, var_c0856555)
{
	if(var_d3ba512b.score > var_c0856555.score)
	{
		return 1;
	}
	if(var_c0856555.score > var_d3ba512b.score)
	{
		return 0;
	}
	return function_39971b81(var_d3ba512b, var_c0856555);
}

/*
	Name: function_f1394038
	Namespace: warzone
	Checksum: 0x3E275E16
	Offset: 0x3E38
	Size: 0x620
	Parameters: 0
	Flags: Linked
*/
function function_f1394038()
{
	if(infection::function_74650d7())
	{
		placement = 1;
		params = globallogic::function_9c839e9();
		if(!function_eb1c0d37(params.var_dfa2cc2c))
		{
			foreach(team in params.var_dfa2cc2c)
			{
				level.var_eed7c027[team] = placement;
			}
			placement++;
		}
		var_6c4bfa17 = infection::function_76601b7d();
		foreach(team in function_37d3bfcb(var_6c4bfa17))
		{
			level.var_eed7c027[team] = placement;
		}
		return;
	}
	if(namespace_aa9b5883::function_382a49e0())
	{
		placement = 1;
		foreach(platoon, _ in level.var_aa9b5883)
		{
			if(!namespace_aa9b5883::function_6ce0360d(platoon))
			{
				foreach(team in function_37d3bfcb(platoon))
				{
					level.var_eed7c027[team] = placement;
				}
				placement++;
			}
		}
		foreach(platoon, _ in level.var_aa9b5883)
		{
			if(namespace_aa9b5883::function_6ce0360d(platoon))
			{
				foreach(team in function_37d3bfcb(platoon))
				{
					level.var_eed7c027[team] = placement;
				}
				placement++;
			}
		}
		return;
	}
	var_17616452 = [];
	foreach(team, _ in level.teams)
	{
		if(teams::function_9dd75dad(team) && (!(isdefined(level.var_606becce[team]) && level.var_606becce[team])) && !isdefined(level.var_eed7c027[team]))
		{
			players = getplayers(team);
			team_score = [[level._getteamscore]](team);
			team_kills = function_7e309c84(team, players);
			damage_done = function_3915e148(team, players);
			if(!isdefined(var_17616452))
			{
				var_17616452 = [];
			}
			else if(!isarray(var_17616452))
			{
				var_17616452 = array(var_17616452);
			}
			var_17616452[var_17616452.size] = {#score:team_score, #damage:damage_done, #kills:team_kills, #last_alive:undefined, #players:players, #team:team};
		}
	}
	var_ec950e92 = array::merge_sort(var_17616452, &function_74a8f2ed);
	placement = 1;
	foreach(team in var_ec950e92)
	{
		level.var_eed7c027[team.team] = placement;
		placement++;
	}
}

/*
	Name: function_94203702
	Namespace: warzone
	Checksum: 0x48577924
	Offset: 0x4460
	Size: 0xE2
	Parameters: 2
	Flags: Linked
*/
function function_94203702(team, players)
{
	var_b7771cfa = 0;
	last_player = undefined;
	foreach(player in players)
	{
		if(isdefined(player.teamkilled) && player.teamkilled)
		{
			continue;
		}
		if(player.deathtime > var_b7771cfa)
		{
			var_b7771cfa = player.deathtime;
			last_player = player;
		}
	}
	return last_player;
}

/*
	Name: function_7e309c84
	Namespace: warzone
	Checksum: 0x56CD6FDF
	Offset: 0x4550
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function function_7e309c84(team, players)
{
	team_kills = 0;
	foreach(player in players)
	{
		team_kills = team_kills + player.kills;
	}
	return team_kills;
}

/*
	Name: function_3915e148
	Namespace: warzone
	Checksum: 0xF599F2E3
	Offset: 0x45F0
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function function_3915e148(team, players)
{
	damage_done = 0;
	foreach(player in players)
	{
		damage_done = damage_done + player.damagedone;
	}
	return damage_done;
}

/*
	Name: function_39971b81
	Namespace: warzone
	Checksum: 0xE3F3C6E5
	Offset: 0x4690
	Size: 0x172
	Parameters: 2
	Flags: Linked
*/
function function_39971b81(var_d3ba512b, var_c0856555)
{
	if(isdefined(var_d3ba512b.last_alive) && !isdefined(var_c0856555.last_alive))
	{
		return 1;
	}
	if(isdefined(var_c0856555.last_alive) && !isdefined(var_d3ba512b.last_alive))
	{
		return 0;
	}
	if(isdefined(var_d3ba512b.last_alive) && var_d3ba512b.last_alive.deathtime > var_c0856555.last_alive.deathtime)
	{
		return 1;
	}
	if(isdefined(var_d3ba512b.last_alive) && var_c0856555.last_alive.deathtime > var_d3ba512b.last_alive.deathtime)
	{
		return 0;
	}
	if(var_d3ba512b.kills > var_c0856555.kills)
	{
		return 1;
	}
	if(var_c0856555.kills > var_d3ba512b.kills)
	{
		return 0;
	}
	if(var_d3ba512b.damage > var_c0856555.damage)
	{
		return 1;
	}
	if(var_c0856555.damage > var_d3ba512b.damage)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c7eae573
	Namespace: warzone
	Checksum: 0x7BBE80B0
	Offset: 0x4810
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function function_c7eae573()
{
	var_d72df62 = [];
	foreach(team, _ in level.teams)
	{
		if(teams::function_9dd75dad(team) && (!(isdefined(level.var_606becce[team]) && level.var_606becce[team])) && teams::function_6ce0360d(team))
		{
			players = getplayers(team);
			last_alive = function_94203702(team, players);
			team_kills = function_7e309c84(team, players);
			damage_done = function_3915e148(team, players);
			var_d72df62[var_d72df62.size] = {#damage:damage_done, #kills:team_kills, #last_alive:last_alive, #players:players, #team:team};
		}
	}
	var_ec950e92 = array::merge_sort(var_d72df62, &function_39971b81);
	return var_ec950e92;
}

/*
	Name: function_c2f2fb84
	Namespace: warzone
	Checksum: 0x588A7BDF
	Offset: 0x49F8
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_c2f2fb84(var_d72df62)
{
	if(var_d72df62.size == 0)
	{
		return undefined;
	}
	if(var_d72df62.size == 1)
	{
		return var_d72df62[0].team;
	}
	return var_d72df62[0].team;
}

/*
	Name: function_5fed3908
	Namespace: warzone
	Checksum: 0x3172871F
	Offset: 0x4A50
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_5fed3908(team)
{
	if(!isdefined(team))
	{
		return;
	}
	level thread namespace_d3564fd8::function_5648f82(team);
	level thread namespace_78a95918::function_5648f82(team);
	if(function_8b1a219a())
	{
		players = getplayers(team);
		foreach(player in players)
		{
			player clientfield::set_to_player("RGB_keyboard_manager", 1);
		}
	}
}

/*
	Name: team_eliminated
	Namespace: warzone
	Checksum: 0x71441969
	Offset: 0x4B50
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function team_eliminated(team, var_293493b)
{
	level.var_606becce[team] = 1;
	namespace_d3564fd8::team_eliminated(team, var_293493b);
	level function_22df4165();
	level thread function_9498e451(team);
	var_3aef38fd = getplayers(team);
	foreach(teammember in var_3aef38fd)
	{
		teammember notify(#"end_respawn");
		if(!namespace_aa9b5883::function_382a49e0())
		{
			teammember luinotifyevent(#"team_eliminated", 1, var_293493b);
		}
	}
	level.var_eed7c027[team] = var_293493b;
}

/*
	Name: function_40843d72
	Namespace: warzone
	Checksum: 0x827247C
	Offset: 0x4CB8
	Size: 0x39C
	Parameters: 1
	Flags: Linked
*/
function function_40843d72(team)
{
	if(team == "all")
	{
		var_d72df62 = function_c7eae573();
		winning_team = function_c2f2fb84(var_d72df62);
		count = 2;
		foreach(var_b524076f in var_d72df62)
		{
			if(!isdefined(winning_team) || util::function_fbce7263(winning_team, var_b524076f.team))
			{
				team_eliminated(var_b524076f.team, count);
				count++;
			}
		}
		function_5fed3908(winning_team);
		round::function_af2e264f(winning_team);
		thread globallogic::end_round(6);
	}
	else
	{
		platoon = function_22448d6c(team);
		if(infection::function_74650d7())
		{
			var_293493b = 2;
			level.var_eed7c027[team] = var_293493b;
			namespace_d3564fd8::team_eliminated(team, var_293493b);
		}
		else if(namespace_aa9b5883::function_382a49e0() && (platoon != #"none" && platoon != #"invalid"))
		{
			if(teams::function_9dd75dad(team) && (!(isdefined(level.var_606becce[team]) && level.var_606becce[team])) && namespace_aa9b5883::function_6ce0360d(platoon))
			{
				foreach(team in function_37d3bfcb(platoon))
				{
					team_eliminated(team, namespace_aa9b5883::function_cea75f29() + 1);
				}
			}
		}
		else if(teams::function_9dd75dad(team) && (!(isdefined(level.var_606becce[team]) && level.var_606becce[team])) && teams::function_6ce0360d(team))
		{
			team_eliminated(team, globallogic::function_e9e52d05() + 1);
		}
	}
}

/*
	Name: function_61c315e0
	Namespace: warzone
	Checksum: 0xCAD18E91
	Offset: 0x5060
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_61c315e0()
{
	if(infection::function_74650d7())
	{
		params = globallogic::function_9c839e9();
		function_ded0be06(params);
	}
}

/*
	Name: function_a40b79b1
	Namespace: warzone
	Checksum: 0x3B7C0F6D
	Offset: 0x50B8
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function function_a40b79b1(team)
{
	if(!isdefined(team) || teams::function_6ce0360d(team))
	{
		return 1;
	}
	foreach(player in getplayers(team))
	{
		if(isalive(player) && !player laststand::player_is_in_laststand())
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_eb1c0d37
	Namespace: warzone
	Checksum: 0xE9FB959E
	Offset: 0x51A0
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_eb1c0d37(teams)
{
	if(!isdefined(teams))
	{
		return 1;
	}
	foreach(team in teams)
	{
		if(!isdefined(team) || function_a40b79b1(team))
		{
			continue;
		}
		return 0;
	}
	return 1;
}

/*
	Name: function_ded0be06
	Namespace: warzone
	Checksum: 0x2A72B663
	Offset: 0x5250
	Size: 0x51C
	Parameters: 1
	Flags: Linked
*/
function function_ded0be06(params)
{
	if(function_eb1c0d37(params.var_dfa2cc2c))
	{
		level notify(#"hash_334bade8f4c0b69f");
	}
	else
	{
		level endon(#"hash_334bade8f4c0b69f");
		if(flagsys::get(#"hash_402b08cbe8f533d2"))
		{
			return;
		}
		music::setmusicstate("pan_timeout_01");
		flagsys::set(#"hash_402b08cbe8f533d2");
		foreach(player in getplayers())
		{
			player luinotifyevent(#"create_prematch_timer", 3, gettime() + 60000, 1, 1);
		}
		wait(60);
	}
	var_f1a61e0 = 0;
	foreach(var_a505a9b4 in params.var_dfa2cc2c)
	{
		if(!isdefined(var_a505a9b4))
		{
			continue;
		}
		if(!function_a40b79b1(var_a505a9b4) && function_22448d6c(var_a505a9b4) != infection::function_76601b7d())
		{
			if(var_f1a61e0 == 0)
			{
				round::function_af2e264f(var_a505a9b4);
			}
			else
			{
				round::function_af2e264f();
			}
			level thread function_3832a0d2(var_a505a9b4);
			function_5fed3908(var_a505a9b4);
			var_f1a61e0++;
		}
	}
	var_b00f47b3 = var_f1a61e0 >= 1;
	platoon = infection::function_76601b7d();
	if(!var_b00f47b3)
	{
		round::function_35702443(platoon);
	}
	foreach(team in function_37d3bfcb(platoon))
	{
		if(teams::function_9dd75dad(team))
		{
			if(var_b00f47b3)
			{
				namespace_d3564fd8::team_eliminated(team, 2);
				continue;
			}
			level thread function_3832a0d2(team);
			function_5fed3908(team);
		}
	}
	if(!var_b00f47b3 && (isdefined(params.var_46a749a8) || isdefined(params.var_dfa2cc2c)))
	{
		foreach(team in params.var_dfa2cc2c)
		{
			if(function_22448d6c(team) != platoon)
			{
				namespace_d3564fd8::team_eliminated(team, 2);
			}
		}
		foreach(team in params.var_46a749a8)
		{
			if(function_22448d6c(team) != platoon)
			{
				namespace_d3564fd8::team_eliminated(team, 2);
			}
		}
	}
	thread globallogic::end_round(6);
}

/*
	Name: function_5af3a29
	Namespace: warzone
	Checksum: 0x85EA7B0D
	Offset: 0x5778
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_5af3a29(params)
{
	if(infection::function_74650d7())
	{
		level function_ded0be06(params);
	}
	else if(namespace_aa9b5883::function_382a49e0())
	{
		platoon = function_22448d6c(params.var_48787ba8[0]);
		foreach(team in function_37d3bfcb(platoon))
		{
			if(teams::function_9dd75dad(team))
			{
				level thread function_3832a0d2(team);
				function_5fed3908(team);
			}
		}
	}
	else
	{
		level thread function_3832a0d2(params.var_48787ba8[0]);
		function_5fed3908(params.var_48787ba8[0]);
	}
}

/*
	Name: function_3832a0d2
	Namespace: warzone
	Checksum: 0x3726AA9F
	Offset: 0x5900
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_3832a0d2(team)
{
	winner = function_b5f4c9d8(team);
	if(isdefined(winner))
	{
		var_fc96f513 = winner getmpdialogname();
		if(isdefined(var_fc96f513))
		{
			var_6cc23875 = struct::get_script_bundle("mpdialog_player", var_fc96f513);
			if(isdefined(var_6cc23875))
			{
				var_520b24a = var_6cc23875.boostwin;
				if(isdefined(var_520b24a))
				{
					level.var_fec861a7 = 1;
					winner battlechatter::function_a48c33ff(var_520b24a, 148, 5);
					level.var_fec861a7 = undefined;
				}
			}
		}
	}
	wait(5);
	globallogic_audio::leader_dialog("warTeamWon", team);
}

/*
	Name: function_b5f4c9d8
	Namespace: warzone
	Checksum: 0xEEDE985E
	Offset: 0x5A20
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_b5f4c9d8(team)
{
	winner = undefined;
	players = getplayers(team);
	foreach(player in players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(!isdefined(player.lastkilltime))
		{
			player.lastkilltime = 0;
		}
		if(!isdefined(winner) || player.lastkilltime > winner.lastkilltime)
		{
			winner = player;
		}
	}
	return winner;
}

/*
	Name: function_9498e451
	Namespace: warzone
	Checksum: 0x270FB890
	Offset: 0x5B30
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_9498e451(team)
{
	wait(1);
	while(isdefined(level.var_fec861a7) && level.var_fec861a7)
	{
		waitframe(1);
	}
}

/*
	Name: function_80efb8b1
	Namespace: warzone
	Checksum: 0xFA51C0C7
	Offset: 0x5B78
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function function_80efb8b1(team)
{
	if(team == "all")
	{
		return;
	}
	platoon = function_22448d6c(team);
	if(platoon != #"none" && platoon != #"invalid")
	{
		return;
	}
	foreach(player in getplayers(team))
	{
		if(isalive(player) && !player laststand::player_is_in_laststand())
		{
			player globallogic_audio::leader_dialog_on_player("warLastManStanding");
			return;
		}
	}
}

/*
	Name: function_379afb41
	Namespace: warzone
	Checksum: 0xBD99ACE6
	Offset: 0x5CB8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_379afb41()
{
	death_circle::function_27d5d349();
	namespace_bf3feaf0::function_dc16557c();
}

/*
	Name: on_end_game
	Namespace: warzone
	Checksum: 0x945DDDB
	Offset: 0x5CE8
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function on_end_game(var_c1e98979)
{
	function_379afb41();
	if(infection::function_74650d7())
	{
		luinotifyevent(#"prematch_timer_ended", 2, 1, 1);
	}
	level.var_bde3d03 = &function_b777ff94;
	level thread globallogic_audio::function_85818e24("matchcomplete");
	winner = round::function_9b24638f();
	var_1167be0c = round::function_d30d1a2e();
	match::function_af2e264f(winner);
	match::function_35702443(var_1167be0c);
	setmatchflag("game_ended", 0);
	wait(2);
	setmatchflag("game_ended", 1);
}

/*
	Name: function_c1a417ee
	Namespace: warzone
	Checksum: 0x86CD2404
	Offset: 0x5E30
	Size: 0x28C
	Parameters: 1
	Flags: Linked
*/
function function_c1a417ee(params)
{
	level function_22df4165();
	attacker = params.attacker;
	weapon = params.weapon;
	smeansofdeath = params.smeansofdeath;
	if(isdefined(params.laststandparams))
	{
		attacker = params.laststandparams.attacker;
		weapon = params.laststandparams.sweapon;
		smeansofdeath = params.laststandparams.smeansofdeath;
	}
	if(isplayer(attacker))
	{
		itemindex = getitemindexfromref(weapon.name);
		if(itemindex == 0)
		{
			itemindex = getitemindexfromref(weapon.statname);
		}
		var_97dcd0a5 = getunlockableiteminfofromindex(itemindex, 1);
		if(isdefined(var_97dcd0a5))
		{
			attackerid = attacker getentitynumber();
			self luinotifyevent(#"hash_4f354475cce89512", 3, attackerid, 0, weapon.statindex);
		}
		else
		{
			self luinotifyevent(#"hash_4f354475cce89512", 3, 0, function_4a856ead(smeansofdeath), 0);
		}
	}
	else
	{
		self luinotifyevent(#"hash_4f354475cce89512", 3, 0, function_4a856ead(smeansofdeath), 0);
	}
	self function_75134917();
	self function_e6f9e3cd();
	self.specialty = self getloadoutperks(0);
	self loadout::register_perks();
}

/*
	Name: function_75134917
	Namespace: warzone
	Checksum: 0xCF16F5D2
	Offset: 0x60C8
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_75134917()
{
	if(infection::function_74650d7() && !self infection::function_bf46a7aa())
	{
		foreach(player in getplayers())
		{
			if(player.team === self.team)
			{
				player luinotifyevent(#"hash_123261c89a0bc7a", 1, self getentitynumber());
				self luinotifyevent(#"hash_123261c89a0bc7a", 1, player getentitynumber());
			}
		}
	}
}

/*
	Name: function_c14ef1aa
	Namespace: warzone
	Checksum: 0x6C8A5D39
	Offset: 0x61F0
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_c14ef1aa(attacker)
{
	if(getdvarint(#"hash_10c3f1c0958c1fba", 0) == 0)
	{
		return 0;
	}
	if(!isdedicated())
	{
		return 0;
	}
	if(isalive(self))
	{
		return 0;
	}
	if(isdefined(self.switching_teams))
	{
		return 0;
	}
	if(isdefined(attacker) && attacker == self)
	{
		return 0;
	}
	if(level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team)
	{
		return 0;
	}
	if(isdefined(attacker) && (!isdefined(attacker.team) || attacker.team == "free") && (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: player_killed
	Namespace: warzone
	Checksum: 0x6D84F30F
	Offset: 0x6350
	Size: 0x456
	Parameters: 9
	Flags: Linked
*/
function player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	self clientfield::set_to_player("realtime_multiplay", 0);
	if(smeansofdeath == "MOD_META")
	{
		return;
	}
	if(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn)
	{
		thread dogtags::checkallowspectating();
		should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
		if(should_spawn_tags)
		{
			level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
		}
	}
	if(isplayer(attacker) && self function_c14ef1aa(attacker))
	{
		var_27a8d662 = self getxuid(1) + attacker getxuid(1);
		self function_b096092b(var_27a8d662);
		attacker function_b096092b(var_27a8d662);
	}
	if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
	{
		attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
		self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
		}
	}
	if(infection::function_74650d7())
	{
		params = globallogic::function_9c839e9();
		lastsurvivor = 0;
		if(params.var_dfa2cc2c.size == 1)
		{
			survivors = 0;
			foreach(player in getplayers(params.var_dfa2cc2c[0]))
			{
				if(isalive(player) && !player laststand::player_is_in_laststand())
				{
					survivors++;
				}
			}
			lastsurvivor = survivors <= 1;
		}
		if(!lastsurvivor)
		{
			self infection::function_d3da95cf();
			self clientfield::set_player_uimodel("hudItems.playerOnInfectedPlatoon", 1);
			if(level.numlives == 0 && function_47851c07())
			{
				self.pers[#"lives"] = 1;
			}
		}
	}
}

/*
	Name: function_16e6bd2e
	Namespace: warzone
	Checksum: 0xC1FEE8A0
	Offset: 0x67B0
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_16e6bd2e(var_c1e98979)
{
	var_1e866967 = spawnstruct();
	var_1e866967.remainingtime = max(0, globallogic_utils::gettimeremaining());
	switch(var_c1e98979)
	{
		case 2:
		{
			var_1e866967.wintype = "time_limit_reached";
			break;
		}
		case 3:
		{
			var_1e866967.wintype = "score_limit_reached";
			break;
		}
		case 9:
		case 10:
		default:
		{
			var_1e866967.wintype = "NA";
			break;
		}
	}
	bb::function_bf5cad4e(var_1e866967);
}

/*
	Name: function_73b0f715
	Namespace: warzone
	Checksum: 0x3D68518B
	Offset: 0x68D0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_73b0f715(player = undefined)
{
	if(game.state != "pregame")
	{
		return;
	}
	if(isdedicated())
	{
		if(getdvarint(#"hash_41feb500743b0d15", 0) != 0)
		{
			return;
		}
	}
	level notify(#"hash_78e53817cafb5265");
}

/*
	Name: function_47851c07
	Namespace: warzone
	Checksum: 0x161A416A
	Offset: 0x6960
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_47851c07()
{
	if(game.state != "playing")
	{
		return 0;
	}
	if(infection::function_74650d7())
	{
		return 1;
	}
	if(isdefined(level.var_f220c297) && level.var_f220c297)
	{
		return death_circle::function_d66a3de1();
	}
	if(isdefined(level.wave_spawn) && level.wave_spawn && (death_circle::function_9956f107() || (isdefined(level.var_75db41a7) && gettime() > level.var_75db41a7)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_de15dc32
	Namespace: warzone
	Checksum: 0x5B446BBC
	Offset: 0x6A38
	Size: 0x356
	Parameters: 2
	Flags: Linked
*/
function function_de15dc32(killed_player, var_67bb0009)
{
	player_count = {#hash_85587598:[], #alive:0, #total:0};
	var_77cfc33d = game.state == "pregame" || function_47851c07();
	foreach(team in level.teams)
	{
		players = getplayers(team);
		if(players.size == 0)
		{
			continue;
		}
		platoon = function_22448d6c(team);
		var_40073db2 = 0;
		var_ead60f69 = 0;
		foreach(player in players)
		{
			if(var_67bb0009 === player)
			{
				continue;
			}
			player_count.total++;
			if(isalive(player) || (infection::function_74650d7() && player infection::function_bf46a7aa()))
			{
				var_40073db2++;
				continue;
			}
			if(player.sessionstate != "playing" || killed_player === player)
			{
				if(player globallogic_spawn::function_38527849())
				{
					var_ead60f69++;
				}
			}
		}
		player_count.alive = player_count.alive + var_40073db2;
		if(!isdefined(player_count.var_85587598[platoon]))
		{
			player_count.var_85587598[platoon] = 0;
		}
		player_count.var_85587598[platoon] = player_count.var_85587598[platoon] + var_40073db2;
		if(var_77cfc33d && level.var_c2cc011f && var_40073db2 > 0)
		{
			player_count.alive = player_count.alive + var_ead60f69;
			player_count.var_85587598[platoon] = player_count.var_85587598[platoon] + var_ead60f69;
		}
	}
	return player_count;
}

/*
	Name: function_22df4165
	Namespace: warzone
	Checksum: 0x8830226C
	Offset: 0x6D98
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_22df4165()
{
	level.var_22df4165 = 1;
}

/*
	Name: function_5db32126
	Namespace: warzone
	Checksum: 0x389BCB37
	Offset: 0x6DB8
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_5db32126()
{
	while(true)
	{
		waitframe(1);
		if(isdefined(level.var_22df4165) && level.var_22df4165)
		{
			function_e91890a7();
		}
	}
}

/*
	Name: function_e91890a7
	Namespace: warzone
	Checksum: 0x29ED4BE5
	Offset: 0x6E08
	Size: 0x35A
	Parameters: 0
	Flags: Linked
*/
function function_e91890a7()
{
	if(!(isdefined(level.var_22df4165) && level.var_22df4165))
	{
		return;
	}
	util::waittillslowprocessallowed();
	player_counts = function_de15dc32();
	players = getplayers();
	foreach(player in players)
	{
		var_dcf52474 = player_counts.alive;
		player clientfield::set_player_uimodel("presence.modeparam", var_dcf52474);
		if(!namespace_aa9b5883::function_382a49e0())
		{
			player clientfield::set_player_uimodel("hudItems.alivePlayerCount", var_dcf52474);
		}
		else
		{
			var_a4812ee3 = function_22448d6c(player.team);
			/#
				assert(isdefined(player_counts.var_85587598[var_a4812ee3]));
			#/
			player clientfield::set_player_uimodel("hudItems.alivePlayerCount", player_counts.var_85587598[var_a4812ee3]);
			player clientfield::set_player_uimodel("hudItems.alivePlayerCountEnemy", 0);
			foreach(platoon, _ in player_counts.var_85587598)
			{
				if(platoon == var_a4812ee3)
				{
					continue;
				}
				player clientfield::set_player_uimodel("hudItems.alivePlayerCountEnemy", player_counts.var_85587598[platoon]);
				break;
			}
		}
		var_31cc0ff8 = 0;
		var_7102d43a = getplayers(player.team);
		foreach(member in var_7102d43a)
		{
			if(isalive(member) && member != player)
			{
				var_31cc0ff8++;
			}
		}
		player clientfield::set_player_uimodel("hudItems.aliveTeammateCount", var_31cc0ff8);
	}
	level.var_22df4165 = undefined;
}

/*
	Name: function_4012c0ab
	Namespace: warzone
	Checksum: 0x4CF6E29E
	Offset: 0x7170
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_4012c0ab(params)
{
	count = function_c14f7557();
	level clientfield::set_world_uimodel("hudItems.warzone.reinsertionPassengerCount", count);
}

/*
	Name: function_c14f7557
	Namespace: warzone
	Checksum: 0x3A5DF67
	Offset: 0x71C0
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function function_c14f7557()
{
	if(game.state != "pregame" && game.state != "playing")
	{
		return 0;
	}
	if(!infection::function_74650d7())
	{
		if(isdefined(level.var_f220c297) && level.var_f220c297 && death_circle::function_4dc40125())
		{
			return 0;
		}
		if(isdefined(level.wave_spawn) && level.wave_spawn && death_circle::function_9956f107())
		{
			return 0;
		}
	}
	count = 0;
	foreach(team in level.teams)
	{
		players = getplayers(team);
		var_40073db2 = 0;
		var_ead60f69 = 0;
		foreach(player in players)
		{
			if(isalive(player))
			{
				var_40073db2++;
				continue;
			}
			if(player.sessionstate != "playing" && player globallogic_spawn::function_38527849())
			{
				var_ead60f69++;
			}
		}
		if(!level.var_c2cc011f || var_40073db2 > 0)
		{
			count = count + var_ead60f69;
		}
	}
	return count;
}

/*
	Name: function_2f66bc37
	Namespace: warzone
	Checksum: 0xCE59CABB
	Offset: 0x7418
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_2f66bc37()
{
	/#
		assert(isplayer(self));
	#/
	self setactionslot(3, "flourish_callouts");
	self setactionslot(4, "sprays_boasts");
}

/*
	Name: function_cb4b48d5
	Namespace: warzone
	Checksum: 0xA844C801
	Offset: 0x7490
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_cb4b48d5(var_80427091 = 1)
{
	/#
		assert(isplayer(self));
	#/
	if(var_80427091)
	{
		self setactionslot(3, "");
	}
	self setactionslot(4, "");
}

/*
	Name: function_de916514
	Namespace: warzone
	Checksum: 0x4824A151
	Offset: 0x7528
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event function_de916514(eventstruct)
{
	if(isplayer(self))
	{
		self function_cb4b48d5(0);
	}
}

/*
	Name: function_feb0a2aa
	Namespace: warzone
	Checksum: 0x98F5A52
	Offset: 0x7570
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event function_feb0a2aa(eventstruct)
{
	if(isplayer(self))
	{
		self function_2f66bc37();
	}
}

/*
	Name: function_5019e563
	Namespace: warzone
	Checksum: 0xEFFE119D
	Offset: 0x75B8
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event function_5019e563(eventstruct)
{
	if(eventstruct.freefall)
	{
		self function_cb4b48d5();
	}
	else if(!eventstruct.var_695a7111)
	{
		self function_2f66bc37();
	}
}

/*
	Name: function_87b05fa3
	Namespace: warzone
	Checksum: 0x777FF0B0
	Offset: 0x7618
	Size: 0x44
	Parameters: 1
	Flags: Event
*/
event function_87b05fa3(eventstruct)
{
	if(eventstruct.parachute)
	{
		self function_cb4b48d5();
	}
	else
	{
		self function_2f66bc37();
	}
}

/*
	Name: function_511245ae
	Namespace: warzone
	Checksum: 0xB4A873C5
	Offset: 0x7668
	Size: 0x318
	Parameters: 1
	Flags: Linked
*/
function function_511245ae(takeoldweapon = 0)
{
	self loadout::init_player(!takeoldweapon);
	if(takeoldweapon)
	{
		oldweapon = self getcurrentweapon();
		weapons = self getweaponslist();
		foreach(weapon in weapons)
		{
			self takeweapon(weapon);
		}
	}
	var_43d69af6 = getweapon(#"null_offhand_primary");
	self giveweapon(var_43d69af6);
	self setweaponammoclip(var_43d69af6, 0);
	self switchtooffhand(var_43d69af6);
	if(self.firstspawn !== 0)
	{
		function_2f66bc37();
	}
	var_2b15e2fe = getweapon(#"gadget_health_regen");
	self giveweapon(var_2b15e2fe);
	self setweaponammoclip(var_2b15e2fe, 0);
	self switchtooffhand(var_2b15e2fe);
	level.var_ef61b4b5 = var_2b15e2fe;
	var_fb6490c8 = self gadgetgetslot(var_2b15e2fe);
	self gadgetpowerset(var_fb6490c8, 0);
	bare_hands = getweapon(#"bare_hands");
	self giveweapon(bare_hands);
	self function_c9a111a(bare_hands);
	self switchtoweapon(bare_hands, 1);
	if(self.firstspawn !== 0)
	{
		self setspawnweapon(bare_hands);
	}
	self.specialty = self getloadoutperks(0);
	self loadout::register_perks();
	return bare_hands;
}

/*
	Name: function_486a8395
	Namespace: warzone
	Checksum: 0x259A467B
	Offset: 0x7988
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_486a8395()
{
	return 0;
}

/*
	Name: function_8076d591
	Namespace: warzone
	Checksum: 0x1A5FE4A
	Offset: 0x7998
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8076d591(event, params)
{
	if(isdefined(params))
	{
		globallogic_audio::leader_dialog(event, params.team);
	}
	else
	{
		globallogic_audio::leader_dialog(event);
	}
}

/*
	Name: function_8e7ae35
	Namespace: warzone
	Checksum: 0xD8F51F03
	Offset: 0x79F8
	Size: 0x140
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8e7ae35(event, params)
{
	var_e8d63736 = array(#"hash_780a85992e00c556", #"hash_1669c4b328d5e163", #"hash_67baa029914d2410", #"hash_3f71a3968fd86875");
	var_1f1b9efb = var_e8d63736[randomint(var_e8d63736.size)];
	if(isdefined(params) && isdefined(params.insertion))
	{
		foreach(player in params.insertion.players)
		{
			if(isdefined(player))
			{
				player playlocalsound(var_1f1b9efb);
			}
		}
	}
}

/*
	Name: function_a3e209ba
	Namespace: warzone
	Checksum: 0xF89EFA8E
	Offset: 0x7B40
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function function_a3e209ba()
{
	if(namespace_67838d10::function_6660c1f())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_aaa24662
	Namespace: warzone
	Checksum: 0xBCC99739
	Offset: 0x7B68
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_aaa24662()
{
	var_c013a394 = getent("below_world_trigger", "targetname");
	if(!isentity(var_c013a394))
	{
		return;
	}
	var_c013a394 callback::function_35a12f19(&function_3c8be2d2);
}

/*
	Name: function_1e150a0b
	Namespace: warzone
	Checksum: 0x25BBE0E8
	Offset: 0x7BE0
	Size: 0x28C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1e150a0b(player)
{
	if(!isplayer(player))
	{
		/#
			assert(0);
		#/
		return;
	}
	var_9c24b065 = 5;
	var_2497d4aa = 100;
	var_9a5b8004 = 250;
	var_3a60655f = 100;
	var_50c30b0c = 250;
	var_5988a0d = 10000;
	var_85d40a8 = player.origin[2] + 500;
	startpos = (player.origin[0] + randomintrange(var_2497d4aa, var_9a5b8004), player.origin[1] + randomintrange(var_3a60655f, var_50c30b0c), var_5988a0d);
	endpos = (startpos[0], startpos[1], var_85d40a8);
	for(index = 0; index < var_9c24b065; index++)
	{
		var_708a2754 = physicstrace(startpos, endpos, (0, 0, 0), (0, 0, 0), player, 32);
		if(var_708a2754[#"fraction"] < 1)
		{
			player setorigin(var_708a2754[#"position"]);
			return;
		}
		startpos = (startpos[0] + randomintrange(var_2497d4aa, var_9a5b8004), startpos[1] + randomintrange(var_3a60655f, var_50c30b0c), var_5988a0d);
		endpos = (startpos[0], startpos[1], var_85d40a8);
	}
	player dodamage(player.health * 100, player.origin);
}

/*
	Name: function_293cd859
	Namespace: warzone
	Checksum: 0x4E2B6BDA
	Offset: 0x7E78
	Size: 0x17C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_293cd859(ent)
{
	if(isplayer(ent))
	{
		data = {#type:#"player", #pos_z:ent.origin[2], #pos_y:ent.origin[1], #pos_x:ent.origin[0]};
		function_92d1707f(#"hash_5820ed7a498888c4", data);
	}
	else
	{
		data = {#type:ent.model, #pos_z:ent.origin[2], #pos_y:ent.origin[1], #pos_x:ent.origin[0]};
		function_92d1707f(#"hash_5820ed7a498888c4", data);
	}
}

/*
	Name: function_3c8be2d2
	Namespace: warzone
	Checksum: 0x5D154C17
	Offset: 0x8000
	Size: 0x324
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3c8be2d2(trigger_struct)
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death");
	usetrigger = self;
	activator = trigger_struct.activator;
	if(isplayer(activator))
	{
		/#
			iprintlnbold("" + activator.origin[0] + "" + activator.origin[1] + "" + activator.origin[2] + "");
		#/
		function_293cd859(activator);
		if(activator isinvehicle())
		{
			vehicle = activator getvehicleoccupied();
			occupants = vehicle getvehoccupants();
			foreach(occupant in occupants)
			{
				occupant unlink();
			}
			vehicle delete();
			foreach(occupant in occupants)
			{
				function_1e150a0b(occupant);
			}
			return;
		}
		function_1e150a0b(activator);
	}
	else if(isentity(activator))
	{
		/#
			iprintlnbold("" + activator.origin[0] + "" + activator.origin[1] + "" + activator.origin[2] + "");
		#/
		function_293cd859(activator);
		activator delete();
	}
}

/*
	Name: function_3c597e8d
	Namespace: warzone
	Checksum: 0x7A175009
	Offset: 0x8330
	Size: 0x70
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3c597e8d()
{
	var_6024133d = getentarray("map_corner", "targetname");
	if(var_6024133d.size)
	{
		return math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
	}
	return (0, 0, 0);
}

/*
	Name: function_2a3d483d
	Namespace: warzone
	Checksum: 0x44057760
	Offset: 0x83A8
	Size: 0x122
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2a3d483d(start)
{
	mapcenter = function_3c597e8d();
	jumpdistance = 600;
	var_d7afe542 = mapcenter - start;
	var_d80c8cde = length(var_d7afe542);
	var_fa57b4b3 = vectornormalize(var_d7afe542);
	steps = int(var_d80c8cde / jumpdistance);
	for(index = 1; index <= steps; index++)
	{
		newpoint = start + var_fa57b4b3 * index * jumpdistance;
		if(!oob::function_e3fdd830(newpoint))
		{
			return newpoint;
		}
	}
	return mapcenter;
}

/*
	Name: function_c1471c7c
	Namespace: warzone
	Checksum: 0x1B400DDF
	Offset: 0x84D8
	Size: 0x128
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c1471c7c(point)
{
	startpoint = (point[0], point[1], 10000);
	endpoint = (point[0], point[1], -10000);
	groundtrace = groundtrace(startpoint, endpoint, 0, undefined, 0, 0);
	physicstrace = physicstraceex(startpoint, endpoint, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), undefined, 32);
	if(groundtrace[#"position"][2] > physicstrace[#"position"][2])
	{
		return groundtrace[#"position"];
	}
	return physicstrace[#"position"];
}

/*
	Name: _teleport_player
	Namespace: warzone
	Checksum: 0xFEB2779C
	Offset: 0x8608
	Size: 0x112
	Parameters: 3
	Flags: Linked, Private
*/
private function _teleport_player(origin, angles, var_9914886a = 0)
{
	self endon(#"disconnect", #"hash_6b2be5fc7a5ce34f");
	self.oobdisabled = 1;
	fadetime = 0.5;
	self thread hud::fade_to_black_for_x_sec(0, 1, fadetime, fadetime);
	wait(fadetime);
	self.var_63b63c2 = 1;
	self unlink();
	self setorigin(origin);
	self setplayerangles((0, angles[1], 0));
	self.oobdisabled = 0;
	self.var_63b63c2 = 0;
}

/*
	Name: function_b777ff94
	Namespace: warzone
	Checksum: 0x4C5E96AB
	Offset: 0x8728
	Size: 0x2BE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b777ff94(entity)
{
	/#
		iprintlnbold("" + entity.origin[0] + "" + entity.origin[1] + "" + entity.origin[2] + "");
	#/
	if(!isdefined(entity))
	{
		return;
	}
	players = [];
	var_9914886a = 0;
	if(isplayer(entity) && entity isinvehicle())
	{
		vehicle = entity getvehicleoccupied();
		players = vehicle getvehoccupants();
		if(isdefined(vehicle.scriptvehicletype) && vehicle.scriptvehicletype == #"tactical_raft_wz")
		{
			var_9914886a = 1;
		}
	}
	else
	{
		players[players.size] = entity;
	}
	playeroffset = vectorscale((0, 1, 0), 120);
	mapcenter = function_3c597e8d();
	for(index = 0; index < players.size; index++)
	{
		player = players[index];
		startpoint = player.origin + playeroffset * index;
		var_8390ff37 = function_2a3d483d(startpoint);
		var_8390ff37 = function_c1471c7c(var_8390ff37);
		var_ee243d11 = vectortoangles(mapcenter - player.origin);
		if(!isplayer(player))
		{
			player dodamage(player.health, player.origin);
			continue;
		}
		player thread _teleport_player(var_8390ff37, var_ee243d11, var_9914886a);
	}
}

/*
	Name: function_6ee52dd0
	Namespace: warzone
	Checksum: 0xE67D92BD
	Offset: 0x89F0
	Size: 0x284
	Parameters: 2
	Flags: Linked, Private
*/
private function function_6ee52dd0(damage, var_c71fc4f4)
{
	level flagsys::wait_till(#"hash_5a3e17fbc33cdc86");
	var_366959 = 0;
	var_1b5e849 = int(var_c71fc4f4 * 1000);
	while(!(isdefined(level.gameended) && level.gameended))
	{
		time = gettime();
		foreach(i, player in getplayers())
		{
			if(!isalive(player))
			{
				continue;
			}
			if(!isdefined(player.var_21b83511))
			{
				if(player ishidden() || player isinfreefall() || player function_9a0edd92())
				{
					continue;
				}
				player.var_21b83511 = time + var_1b5e849;
				continue;
			}
			if(player.heal.enabled)
			{
				delta = player.var_21b83511 - time;
				player.var_21b83511 = time + delta;
				continue;
			}
			if(i % 10 == var_366959 && player.var_21b83511 < time)
			{
				player dodamage(damage, player.origin, undefined, undefined, undefined, "MOD_BLED_OUT");
				player.var_21b83511 = time + var_1b5e849;
			}
		}
		var_366959 = var_366959 + 1 % 10;
		waitframe(1);
	}
}

/*
	Name: function_77319881
	Namespace: warzone
	Checksum: 0xCD74593C
	Offset: 0x8C80
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_77319881()
{
	if(!(isdefined(level.var_f220c297) && level.var_f220c297))
	{
		return;
	}
	level flagsys::set(#"spawning_allowed");
	/#
		function_cc5d43a1("");
	#/
	level namespace_c2bb938a::function_fec68e5c();
	/#
		function_cc5d43a1("");
	#/
	level flagsys::clear(#"spawning_allowed");
	waitframe(1);
	if(!function_47851c07())
	{
		namespace_c2bb938a::function_8ea9be1c();
		level callback::remove_callback(#"hash_3057417db7f8acdd", &function_77319881);
	}
}

/*
	Name: function_cc5d43a1
	Namespace: warzone
	Checksum: 0xFFB89EA0
	Offset: 0x8DA8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_cc5d43a1(msg)
{
	/#
		println(msg);
		adddebugcommand("");
	#/
}

/*
	Name: function_ec375172
	Namespace: warzone
	Checksum: 0xF340412D
	Offset: 0x8DF0
	Size: 0x17A
	Parameters: 1
	Flags: Linked
*/
function function_ec375172(player)
{
	if(!isdefined(player))
	{
		return;
	}
	player endon(#"disconnect");
	var_40e2a4c8 = getcharacterassetname(player getcharacterbodytype(), currentsessionmode());
	if(var_40e2a4c8 !== #"hash_4b5db84146fbdfd5" && !getdvarint(#"hash_65cc1eba6dcaba72", 0))
	{
		return;
	}
	var_410bcc74 = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
	switch(var_410bcc74)
	{
		case 0:
		{
			wait(0.1);
			playfxontag(#"hash_57f2dadebce0586c", player, "j_spine4");
			break;
		}
		case 1:
		{
			wait(0.1);
			break;
		}
	}
}

/*
	Name: function_10dc43bc
	Namespace: warzone
	Checksum: 0x3AE34062
	Offset: 0x8F78
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_10dc43bc(params)
{
	if(infection::function_74650d7())
	{
		if(params.var_8245068d == 0)
		{
			return 0;
		}
		if(params.var_39ee8eb2.size == 1 && params.var_39ee8eb2[0] == infection::function_76601b7d())
		{
			return 1;
		}
		if(params.var_dfa2cc2c.size == 1)
		{
			return 1;
		}
		return 0;
	}
	return globallogic::function_10dc43bc(params);
}

/*
	Name: function_b3f02397
	Namespace: warzone
	Checksum: 0xF0E7B33B
	Offset: 0x9030
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_b3f02397()
{
	var_e29c5f3b = "0" + randomintrange(1, 2);
	game.musicset = "_za_" + var_e29c5f3b;
}

/*
	Name: function_414115a0
	Namespace: warzone
	Checksum: 0x50ED4033
	Offset: 0x9080
	Size: 0x1AC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_414115a0()
{
	if(util::function_5df4294() == "warzone_heavy_metal_heroes")
	{
		namespace_2daa33c5::function_414115a0(900, 150);
		namespace_2daa33c5::function_414115a0(200, 150);
		namespace_2daa33c5::function_414115a0(90, 150);
		namespace_2daa33c5::function_414115a0(40, 150);
		namespace_2daa33c5::function_414115a0(10, 150);
		namespace_2daa33c5::function_414115a0(3, 150);
		namespace_2daa33c5::function_414115a0(1, 150);
		namespace_2daa33c5::function_414115a0(0, 150);
	}
	else
	{
		namespace_2daa33c5::function_414115a0(90, 150);
		namespace_2daa33c5::function_414115a0(25, 150);
		namespace_2daa33c5::function_414115a0(15, 150);
		namespace_2daa33c5::function_414115a0(10, 150);
		namespace_2daa33c5::function_414115a0(5, 150);
		namespace_2daa33c5::function_414115a0(3, 150);
		namespace_2daa33c5::function_414115a0(1, 150);
		namespace_2daa33c5::function_414115a0(0, 150);
	}
}

