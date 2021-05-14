// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1dfbba29049027e1;
#using script_4cc2542101cb7973;
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_a0f5c7fc;

/*
	Name: function_89f2df9
	Namespace: namespace_a0f5c7fc
	Checksum: 0x56A55E21
	Offset: 0x240
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_261b71c31eed2733", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a0f5c7fc
	Checksum: 0x5C4588F2
	Offset: 0x290
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	level init_flags();
	level thread function_247786e5();
}

/*
	Name: __main__
	Namespace: namespace_a0f5c7fc
	Checksum: 0xBBFC86C4
	Offset: 0x2F0
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level flag::wait_till(#"all_players_spawned");
	level thread function_f1da2bd5();
	level thread function_bdc25d1b();
	level thread function_35491a0e();
	level thread function_49189399();
	level thread function_3deb7fb0();
	level thread function_a78a3261();
	level thread function_f34169e8();
	level thread function_22101968();
	level thread function_4e68b0f4();
	level thread function_29543c();
	level thread function_963edada();
}

/*
	Name: init_flags
	Namespace: namespace_a0f5c7fc
	Checksum: 0xADC2FE3F
	Offset: 0x428
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_20ac26ecda866c45");
	level flag::init(#"hash_59cfca3c898df56d");
	level flag::init(#"hash_779398f97110e7b8");
	level flag::init(#"hash_732657441f7793dc");
}

/*
	Name: function_247786e5
	Namespace: namespace_a0f5c7fc
	Checksum: 0x83C7422C
	Offset: 0x4B8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_247786e5()
{
	zm_audio::sndannouncervoxadd(#"hash_180baca4b791b352", #"hash_53687fb8d75cd0d");
}

/*
	Name: on_player_connect
	Namespace: namespace_a0f5c7fc
	Checksum: 0xD77A5F0F
	Offset: 0x4F8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self flag::init(#"hash_1308e79a11093c1e");
	self thread function_9af564c();
}

/*
	Name: function_4e68b0f4
	Namespace: namespace_a0f5c7fc
	Checksum: 0x606D2643
	Offset: 0x540
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_4e68b0f4()
{
	var_baa069fa = getent("t_v_o_exam", "targetname");
	s_info = undefined;
	s_info = var_baa069fa waittill(#"trigger");
	e_player = s_info.activator;
	e_player thread zm_audio::create_and_play_dialog(#"hash_64207dd7a5dc4420", #"react", undefined, 1);
}

/*
	Name: function_29543c
	Namespace: namespace_a0f5c7fc
	Checksum: 0x80F51943
	Offset: 0x5F0
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function function_29543c()
{
	var_baa069fa = getent("t_v_o_docks", "targetname");
	s_info = undefined;
	s_info = var_baa069fa waittill(#"trigger");
	e_player = s_info.activator;
	b_say = e_player zm_audio::create_and_play_dialog(#"zone_dock", #"hash_4f30a7de1a21c7cb", undefined, 1);
	if(isdefined(b_say) && b_say && e_player zm_characters::is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4")))
	{
		wait(soundgetplaybacktime(#"hash_6598db6cd61c4aad") / 1000);
		e_nikolai = undefined;
		foreach(var_a7cf1037 in level.players)
		{
			if(var_a7cf1037 zm_characters::is_character(array(#"hash_22e6f7e13c3a99ef", #"hash_46b92e1337b43236")))
			{
				e_nikolai = var_a7cf1037;
				break;
			}
		}
		if(isalive(e_nikolai) && isalive(e_player))
		{
			if(distancesquared(e_nikolai.origin, e_player.origin) < 589824)
			{
				var_9a0250b7 = #"hash_465a6e7feb94a61d";
				e_nikolai zm_vo::function_8e0f4696(var_9a0250b7, 0, 0, 9999);
			}
		}
	}
}

/*
	Name: function_9af564c
	Namespace: namespace_a0f5c7fc
	Checksum: 0x88C6058D
	Offset: 0x890
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_9af564c()
{
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"hash_1413599b710f10bd");
		self thread zm_audio::create_and_play_dialog(#"brutus", #"helm_off", undefined);
	}
}

/*
	Name: function_f34169e8
	Namespace: namespace_a0f5c7fc
	Checksum: 0xD1D6B10F
	Offset: 0x900
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f34169e8()
{
	level endon(#"end_game");
	s_escape_plan_vo_react = struct::get("s_map_react_vo_rich_lab");
	s_escape_plan_vo_react.s_unitrigger_stub = s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_65a374eb);
	if(level flag::exists(#"hash_40e9ad323fe8402a"))
	{
		level flag::wait_till(#"hash_40e9ad323fe8402a");
		zm_unitrigger::unregister_unitrigger(s_escape_plan_vo_react.s_unitrigger_stub);
	}
}

/*
	Name: function_65a374eb
	Namespace: namespace_a0f5c7fc
	Checksum: 0x9277D66D
	Offset: 0x9D0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_65a374eb()
{
	level endon(#"hash_40e9ad323fe8402a");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		e_player thread zm_audio::create_and_play_dialog(#"map", #"react");
	}
}

/*
	Name: function_f1da2bd5
	Namespace: namespace_a0f5c7fc
	Checksum: 0xA792CF2F
	Offset: 0xA68
	Size: 0x178
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f1da2bd5()
{
	var_44e6a82b = struct::get_array("s_pods_react");
	foreach(s_pod in var_44e6a82b)
	{
		s_pod.s_unitrigger_stub = s_pod zm_unitrigger::create(&function_480ec8c, 96, &function_4f89089b);
	}
	if(level flag::exists(#"hash_379fc22ed85f0dbc"))
	{
		level flag::wait_till(#"hash_379fc22ed85f0dbc");
		foreach(s_pod in var_44e6a82b)
		{
			zm_unitrigger::unregister_unitrigger(s_pod.s_unitrigger_stub);
		}
	}
}

/*
	Name: function_480ec8c
	Namespace: namespace_a0f5c7fc
	Checksum: 0x7AF09238
	Offset: 0xBE8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_480ec8c(player)
{
	if(!(isdefined(player.var_b5fbfab4) && player.var_b5fbfab4))
	{
		self sethintstring(#"");
		return 1;
	}
	return 0;
}

/*
	Name: function_4f89089b
	Namespace: namespace_a0f5c7fc
	Checksum: 0x4AF1DF75
	Offset: 0xC50
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function function_4f89089b()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator) && isalive(s_result.activator))
		{
			b_played = s_result.activator zm_audio::create_and_play_dialog(#"hash_2df8832316a42fe1", #"react");
			if(isdefined(b_played) && b_played)
			{
				s_result.activator.var_b5fbfab4 = 1;
				if(isdefined(self.stub.related_parent.script_string) && self.stub.related_parent.script_string == "stuh")
				{
					s_result.activator.var_59dde2f6 = 1;
				}
			}
		}
	}
}

/*
	Name: function_963edada
	Namespace: namespace_a0f5c7fc
	Checksum: 0xCC6198FF
	Offset: 0xD98
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_963edada()
{
	level endon_callback(&function_19af3d1b, #"hash_59cfca3c898df56d", #"hash_732657441f7793dc", #"end_game");
	var_d98d7f94 = getent("t_cell_block_vista_vo", "targetname");
	while(isdefined(var_d98d7f94))
	{
		s_result = undefined;
		s_result = var_d98d7f94 waittill(#"trigger");
		b_play = s_result.activator zm_audio::create_and_play_dialog(#"vista", #"react");
		if(isdefined(b_play) && b_play)
		{
			level flag::set(#"hash_59cfca3c898df56d");
		}
		wait(0.1);
	}
}

/*
	Name: function_19af3d1b
	Namespace: namespace_a0f5c7fc
	Checksum: 0xCD6D09D4
	Offset: 0xEC8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_19af3d1b(str_notify)
{
	var_d98d7f94 = getent("t_cell_block_vista_vo", "targetname");
	if(isdefined(var_d98d7f94))
	{
		var_d98d7f94 delete();
	}
}

/*
	Name: function_bdc25d1b
	Namespace: namespace_a0f5c7fc
	Checksum: 0xF931B205
	Offset: 0xF28
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bdc25d1b()
{
	var_73707aab = getent("power_house_power_switch", "script_noteworthy");
	var_73707aab endon(#"death");
	s_info = undefined;
	s_info = var_73707aab waittill(#"trigger");
	e_player = s_info.activator;
	e_player thread zm_audio::create_and_play_dialog(#"powerplant", #"turn_on");
}

/*
	Name: function_350029c6
	Namespace: namespace_a0f5c7fc
	Checksum: 0xF7E38B4
	Offset: 0xFE0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_350029c6()
{
	self endon(#"death");
	s_info = undefined;
	s_info = self waittill(#"trigger");
	e_player = s_info.activator;
	e_player thread zm_audio::create_and_play_dialog(#"hash_b5b3ba3a669576", #"turn_on");
}

/*
	Name: function_35491a0e
	Namespace: namespace_a0f5c7fc
	Checksum: 0xB5A3295F
	Offset: 0x1070
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_35491a0e()
{
	s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
	s_catwalk_lava_exp.var_ef66d35a = s_catwalk_lava_exp zm_unitrigger::create(&function_58813027, s_catwalk_lava_exp.radius, &function_f118f554, 0, 0);
	level flag::wait_till(#"hash_779398f97110e7b8");
	zm_unitrigger::unregister_unitrigger(s_catwalk_lava_exp.var_ef66d35a);
}

/*
	Name: function_58813027
	Namespace: namespace_a0f5c7fc
	Checksum: 0xD43D02A0
	Offset: 0x1120
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_58813027(e_player)
{
	return !level flag::get(#"hash_779398f97110e7b8");
}

/*
	Name: function_f118f554
	Namespace: namespace_a0f5c7fc
	Checksum: 0xEF94AD28
	Offset: 0x1158
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_f118f554()
{
	self endon(#"death");
	s_info = undefined;
	s_info = self waittill(#"trigger");
	e_player = s_info.activator;
	exploder::exploder("fxexplo_catwalk_lava_burst");
	level clientfield::set("" + #"hash_24deaa9795e06d41", 1);
	e_player thread function_5860fce9();
}

/*
	Name: function_5860fce9
	Namespace: namespace_a0f5c7fc
	Checksum: 0x86CBA5B0
	Offset: 0x1220
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5860fce9()
{
	self endon(#"disconnect");
	wait(10);
	if(isalive(self))
	{
		b_say = self zm_vo::function_a2bd5a0c(#"hash_227bd68a057f7198", 0, 1);
		if(b_say && isalive(self) && level.activeplayers.size > 1)
		{
			e_richtofen = namespace_69ddf44f::function_b1203924();
			if(isdefined(e_richtofen) && self != e_richtofen && distancesquared(self.origin, e_richtofen.origin) < 1000000)
			{
				e_richtofen zm_vo::function_a2bd5a0c(#"hash_227bd68a057f7198");
			}
		}
	}
	level flag::set(#"hash_779398f97110e7b8");
}

/*
	Name: function_49189399
	Namespace: namespace_a0f5c7fc
	Checksum: 0x137A37B0
	Offset: 0x1370
	Size: 0x17C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_49189399()
{
	var_e5bf9843 = getent("t_reached_cellbock_vo", "targetname");
	var_e5bf9843 endon(#"death");
	while(true)
	{
		s_info = undefined;
		s_info = var_e5bf9843 waittill(#"trigger");
		e_player = s_info.activator;
		if(isplayer(e_player))
		{
			break;
		}
	}
	if(level.players.size > 1)
	{
		e_player thread zm_audio::create_and_play_dialog(#"hash_3eb2a18d21c3a5db", #"react", undefined, 1);
	}
	else
	{
		e_richtofen = namespace_69ddf44f::function_b1203924();
		if(isalive(e_richtofen))
		{
			e_richtofen thread zm_audio::create_and_play_dialog(#"hash_3eb2a18d21c3a5db", #"react", undefined, 1);
		}
	}
	level flag::set(#"hash_732657441f7793dc");
}

/*
	Name: function_22101968
	Namespace: namespace_a0f5c7fc
	Checksum: 0xAB7322DB
	Offset: 0x14F8
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_22101968()
{
	var_d756a0b4 = getent("t_infir_full_react", "targetname");
	var_d756a0b4 endon(#"death");
	while(true)
	{
		s_info = undefined;
		s_info = var_d756a0b4 waittill(#"trigger");
		e_player = s_info.activator;
		if(isplayer(e_player) && e_player flag::get(#"hash_30ae3926b2d211db"))
		{
			break;
		}
	}
	if(!level flag::get(#"hash_1a367a4a0dfb0471"))
	{
		e_player zm_audio::create_and_play_dialog(#"bathtub", #"react", undefined, 1);
		var_d756a0b4 delete();
	}
}

/*
	Name: function_3deb7fb0
	Namespace: namespace_a0f5c7fc
	Checksum: 0x1AA64BF1
	Offset: 0x1640
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3deb7fb0()
{
	s_escape_plan_vo_react = struct::get("s_escape_plan_vo_react");
	s_escape_plan_vo_react zm_unitrigger::create(undefined, 64, &function_db185b3, 1);
}

/*
	Name: function_db185b3
	Namespace: namespace_a0f5c7fc
	Checksum: 0x81C79C2F
	Offset: 0x16A0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_db185b3()
{
	self endon(#"death");
	while(true)
	{
		s_info = undefined;
		s_info = self waittill(#"trigger");
		e_player = s_info.activator;
		e_player thread zm_audio::create_and_play_dialog(#"hash_6530bd618d24bb74", #"react");
	}
}

/*
	Name: function_a78a3261
	Namespace: namespace_a0f5c7fc
	Checksum: 0x4BF17B94
	Offset: 0x1738
	Size: 0x14E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a78a3261()
{
	for(var_12d0accd = 0; var_12d0accd < 3; var_12d0accd++)
	{
		while(true)
		{
			level waittill(#"gondola_moving");
			var_be632f74 = 1;
			foreach(player in getplayers())
			{
				if(player namespace_efb8c7fe::function_9a8ab327())
				{
					var_be632f74 = 0;
					break;
				}
			}
			if(var_be632f74 == 0)
			{
				continue;
			}
			else
			{
				break;
			}
		}
		if(isdefined(level.var_105462b6))
		{
			level.var_105462b6 thread zm_audio::create_and_play_dialog(#"gondola", #"call");
		}
	}
}

/*
	Name: function_818b85eb
	Namespace: namespace_a0f5c7fc
	Checksum: 0xDD425265
	Offset: 0x1890
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_818b85eb()
{
	self endon(#"death", #"disconnect");
	wait(1);
	if(!isdefined(self))
	{
		return;
	}
	if(!self flag::get(#"hash_1308e79a11093c1e"))
	{
		self flag::set(#"hash_1308e79a11093c1e");
		self thread zm_audio::create_and_play_dialog(#"hellhole", #"hash_18fc0277d6348d4");
	}
	else
	{
		self thread zm_audio::create_and_play_dialog(#"hellhole", #"enter");
	}
}

/*
	Name: function_c179111e
	Namespace: namespace_a0f5c7fc
	Checksum: 0x748E0074
	Offset: 0x1980
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_c179111e()
{
	level endon(#"hash_dd62a8822ea4a38", #"end_game");
	level waittill(#"hash_231c2abba527e2e4");
	a_e_players = zm_zonemgr::get_players_in_zone("zone_citadel_stairs", 1);
	if(isarray(a_e_players) && a_e_players.size > 0)
	{
		e_player = array::random(a_e_players);
		if(isalive(e_player))
		{
			e_player thread zm_audio::create_and_play_dialog(#"hash_440246191b63e903", #"react");
		}
	}
}

/*
	Name: function_d62aaf66
	Namespace: namespace_a0f5c7fc
	Checksum: 0x170BA816
	Offset: 0x1A88
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_d62aaf66()
{
	e_player = array::random(level.activeplayers);
	return e_player;
}

