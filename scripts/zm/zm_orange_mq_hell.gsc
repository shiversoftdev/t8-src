// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d4cc4687ff9afd;
#using script_1c72973fb240f263;
#using scripts\zm\zm_orange_pap.gsc;
#using script_35598499769dbb3d;
#using script_3e5ec44cfab7a201;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_4333a03353e1e13a;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm\zm_orange_ee_dynamite.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm\zm_orange_zones.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_mq_hell;

/*
	Name: preload
	Namespace: zm_orange_mq_hell
	Checksum: 0xE1EB06D
	Offset: 0x3C0
	Size: 0x444
	Parameters: 0
	Flags: None
*/
function preload()
{
	clientfield::register("scriptmover", "" + #"hash_6aaf03a4358f45f5", 24000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_6a4317183d0ca452", 24000, 1, "counter");
	clientfield::register("world", "" + #"lava_init", 24000, 1, "int");
	clientfield::register("world", "" + #"lava_control", 24000, 2, "int");
	clientfield::register("world", "" + #"hash_72b5b0359ca48427", 24000, 1, "int");
	clientfield::register("world", "" + #"hash_5e69ee96304ec40b", 24000, 1, "int");
	clientfield::register("vehicle", "" + #"lantern_fx", 24000, 2, "int");
	clientfield::register("vehicle", "" + #"lantern_explode_fx", 24000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_78b8d89d34b32241", 24000, 2, "int");
	clientfield::register("scriptmover", "" + #"lantern_outline", 24000, 1, "int");
	namespace_617a54f4::function_d8383812(#"sc_lantern_1", 24000, "sc_lantern_1", &function_36eb3c96, &function_defd8c26, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_2", 24000, "sc_lantern_2", &function_36eb3c96, &function_defd8c26, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_3", 24000, "sc_lantern_3", &function_36eb3c96, &function_defd8c26, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_4", 24000, "sc_lantern_4", &function_36eb3c96, &function_defd8c26, 1);
	namespace_617a54f4::function_d8383812(#"sc_lantern_end", 24000, "sc_lantern_end", &function_36eb3c96, &function_f578fb22, 1);
	level flag::init(#"hell_on_earth");
	init_2();
}

/*
	Name: main
	Namespace: zm_orange_mq_hell
	Checksum: 0xF7D41895
	Offset: 0x810
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function main()
{
	level thread lava_init();
	level function_7922664f();
}

/*
	Name: function_5309464a
	Namespace: zm_orange_mq_hell
	Checksum: 0x2D0ECE32
	Offset: 0x850
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function function_5309464a(var_5ea5c94d)
{
	zm_ui_inventory::function_7df6bb60(#"hash_2fbec633e5118bab", 10);
	level flag::clear(#"hash_18b94410e3b6b0bf");
	level thread function_d9d65ea6();
	if(!var_5ea5c94d)
	{
		/#
			if(level.var_50b3f446 === 1)
			{
				function_c5bf1974();
			}
		#/
		level thread function_a340f5a2();
		level flag::wait_till(#"hash_621acea2fedc0408");
	}
}

/*
	Name: function_ae270d9e
	Namespace: zm_orange_mq_hell
	Checksum: 0xEF37EBD8
	Offset: 0x930
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_ae270d9e(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_hms_util::function_314447b(1, 0);
	}
}

/*
	Name: function_d9d65ea6
	Namespace: zm_orange_mq_hell
	Checksum: 0x112EDEB3
	Offset: 0x978
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_d9d65ea6()
{
	level endon(#"end_game");
	zm_hms_util::function_df67a12d(#"surrounded");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"oh", #"shit");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"general", #"attacked");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"zipline", #"activate");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"flinger", #"react");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"location_enter");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"electric_zombie");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"935_zombie");
	waitframe(1);
	zm_hms_util::function_df67a12d(#"german_zombie");
}

/*
	Name: init_2
	Namespace: zm_orange_mq_hell
	Checksum: 0x3EEEE281
	Offset: 0xB40
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function init_2()
{
	level.var_5d5b7e8e = spawnstruct();
	level.var_5d5b7e8e.s_ring_center = struct::get("ring_center");
}

/*
	Name: function_f1749965
	Namespace: zm_orange_mq_hell
	Checksum: 0x6F0A792F
	Offset: 0xB90
	Size: 0x21C
	Parameters: 0
	Flags: None
*/
function function_f1749965()
{
	s_player_start = struct::get("ring_player_start");
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player.var_1547e779 = 1;
		e_player setorigin(s_player_start.origin);
		e_player setplayerangles(s_player_start.angles);
	}
	level.var_5d5b7e8e.e_ring = util::spawn_model("p8_big_cylinder", level.var_5d5b7e8e.s_ring_center.origin);
	level.var_5d5b7e8e.e_ring clientfield::increment("" + #"hash_6aaf03a4358f45f5", 1);
	level.var_5d5b7e8e.e_ring.n_radius = 500;
	level.var_5d5b7e8e.e_ring thread function_af9fb8d1();
	level.var_5d5b7e8e.e_ring thread function_556d1b32();
	level.func_get_delay_between_rounds = &no_delay;
	zm_hms_util::function_2ba419ee(0, 29);
	level flag::set(#"infinite_round_spawning");
}

/*
	Name: function_556d1b32
	Namespace: zm_orange_mq_hell
	Checksum: 0x2B3CFEAF
	Offset: 0xDB8
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function function_556d1b32()
{
	self endon(#"death");
	while(self.n_radius > 200)
	{
		wait(0.1);
		self.n_radius = max(200, self.n_radius - 1);
		level.var_5d5b7e8e.e_ring clientfield::increment("" + #"hash_6a4317183d0ca452", 1);
	}
}

/*
	Name: function_af9fb8d1
	Namespace: zm_orange_mq_hell
	Checksum: 0x2142EA33
	Offset: 0xE58
	Size: 0x170
	Parameters: 0
	Flags: None
*/
function function_af9fb8d1()
{
	self endon(#"death");
	while(true)
	{
		n_radius_sqr = self.n_radius * self.n_radius;
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			if(distancesquared(self.origin, e_player.origin) > n_radius_sqr)
			{
				n_damage = 10 * e_player.var_1547e779;
				e_player dodamage(n_damage, e_player.origin);
				e_player.var_1547e779 = e_player.var_1547e779 * 1.2;
				continue;
			}
			if(e_player.var_1547e779 > 1)
			{
				e_player.var_1547e779 = 1;
			}
		}
		wait(1);
	}
}

/*
	Name: no_delay
	Namespace: zm_orange_mq_hell
	Checksum: 0x8019556A
	Offset: 0xFD0
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function no_delay()
{
	return false;
}

/*
	Name: lava_init
	Namespace: zm_orange_mq_hell
	Checksum: 0x5D2FA27E
	Offset: 0xFE0
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function lava_init()
{
	level.var_eb7fcc70 = getentarray("lava_entity", "targetname");
	foreach(var_59bd23de in level.var_eb7fcc70)
	{
		var_59bd23de hide();
		var_59bd23de notsolid();
	}
	level.var_71435e8 = 0;
}

/*
	Name: lava_control
	Namespace: zm_orange_mq_hell
	Checksum: 0x4C0FDBC4
	Offset: 0x10B8
	Size: 0x1E6
	Parameters: 0
	Flags: None
*/
function lava_control()
{
	if(level.var_71435e8 == 0)
	{
		setlightingstate(1);
		level clientfield::set("" + #"lava_control", 1);
		foreach(var_59bd23de in level.var_eb7fcc70)
		{
			var_59bd23de show();
			var_59bd23de solid();
		}
		level.var_71435e8 = 1;
	}
	else
	{
		setlightingstate(0);
		level clientfield::set("" + #"lava_control", 0);
		foreach(var_59bd23de in level.var_eb7fcc70)
		{
			var_59bd23de hide();
			var_59bd23de notsolid();
		}
		level.var_71435e8 = 0;
	}
}

/*
	Name: function_7922664f
	Namespace: zm_orange_mq_hell
	Checksum: 0x1FDEFA9F
	Offset: 0x12A8
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function function_7922664f()
{
	level.var_5d5b7e8e = spawnstruct();
	level.var_5d5b7e8e.var_5ca15e11 = getent("hell_floor", "targetname");
	level.var_5d5b7e8e.var_5ca15e11 notsolid();
	level.var_5d5b7e8e.s_sc_lantern = struct::get("sc_lantern");
	level.var_5d5b7e8e.nd_start = getvehiclenode("hell_path_start", "targetname");
	level.var_35e33dbe = getentarray("lava_rock", "targetname");
	array::run_all(level.var_35e33dbe, &lava_rock_init);
	level flag::init(#"hash_621acea2fedc0408");
}

/*
	Name: spawn_guide
	Namespace: zm_orange_mq_hell
	Checksum: 0x40BA8CB4
	Offset: 0x13E8
	Size: 0x212
	Parameters: 0
	Flags: None
*/
function spawn_guide()
{
	level endon(#"end_game");
	var_a41818b5 = spawner::simple_spawn_single(getent("virgil", "targetname"));
	while(!isdefined(var_a41818b5))
	{
		waitframe(1);
		var_a41818b5 = spawner::simple_spawn_single(getent("virgil", "targetname"));
	}
	var_a41818b5.origin = level.var_5d5b7e8e.nd_start.origin;
	var_a41818b5.angles = level.var_5d5b7e8e.nd_start.angles;
	var_a41818b5.var_e70e15ad = util::spawn_model("p8_zm_ora_elemental_vessel", var_a41818b5.origin + (vectorscale((0, 0, -1), 10)));
	var_a41818b5.var_e70e15ad linkto(var_a41818b5);
	var_a41818b5.var_e70e15ad thread rotate_forever(vectorscale((0, 1, 0), 45));
	var_a41818b5.var_e70e15ad clientfield::set("" + #"lantern_outline", 1);
	var_a41818b5 val::set(#"mq_hell", "takedamage", 0);
	var_a41818b5 clientfield::set("" + #"lantern_fx", 1);
	level.var_5d5b7e8e.var_a41818b5 = var_a41818b5;
}

/*
	Name: rotate_forever
	Namespace: zm_orange_mq_hell
	Checksum: 0x7C236699
	Offset: 0x1608
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function rotate_forever(v_rotation)
{
	self endon(#"death");
	while(true)
	{
		self rotatevelocity(v_rotation, 60);
		wait(60);
	}
}

/*
	Name: function_bda09311
	Namespace: zm_orange_mq_hell
	Checksum: 0x92A596DA
	Offset: 0x1660
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_bda09311()
{
	self._starting_round_number = max(level.round_number, 30);
}

/*
	Name: function_a31d9184
	Namespace: zm_orange_mq_hell
	Checksum: 0xA8A6364F
	Offset: 0x1698
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function function_a31d9184(n_points)
{
	n_round = max(level.round_number, 30);
	return (n_round * n_round) * 2;
}

/*
	Name: function_a340f5a2
	Namespace: zm_orange_mq_hell
	Checksum: 0x609CAC08
	Offset: 0x16E8
	Size: 0x754
	Parameters: 0
	Flags: None
*/
function function_a340f5a2()
{
	level endon(#"end_game");
	level clientfield::set("" + #"hash_72b5b0359ca48427", 1);
	playsoundatposition(#"hash_431cadb65b1777ce", (0, 0, 0));
	level.var_5d5b7e8e.var_a41818b5 setspeed(2);
	level.var_5d5b7e8e.var_a41818b5 thread vehicle::get_on_and_go_path(level.var_5d5b7e8e.nd_start);
	level.var_5d5b7e8e.var_a41818b5 waittill(#"stop");
	level.var_5d5b7e8e.var_a41818b5 setspeedimmediate(0);
	wait(2);
	level.var_5d5b7e8e.var_a41818b5 setspeed(3);
	level.var_5d5b7e8e.var_a41818b5 waittill(#"stop");
	level.var_5d5b7e8e.var_a41818b5 setspeedimmediate(0);
	level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 3);
	wait(5);
	/#
		iprintlnbold("");
	#/
	level.var_5d5b7e8e.var_a41818b5 clientfield::increment("" + #"lantern_explode_fx", 1);
	level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
	wait(0.2);
	zm_orange_ee_dynamite::function_70f4c8c3("sunken_path_blocker");
	lava_control();
	level.var_5d5b7e8e.var_5ca15e11 show();
	level.var_5d5b7e8e.var_5ca15e11 solid();
	level clientfield::set("" + #"hash_5e69ee96304ec40b", 1);
	array::thread_all(level.var_35e33dbe, &function_a8fd16d0);
	level.func_get_delay_between_rounds = &no_delay;
	callback::on_ai_spawned(&function_bda09311);
	zm_round_spawning::function_c1571721(&function_a31d9184);
	function_cb00d0e9();
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"hell_on_earth");
	level flag::set(#"hash_69a9d00e65ee6c40");
	level.musicsystemoverride = 1;
	music::setmusicstate("hell_on_earth_1");
	level.var_5d5b7e8e.var_a41818b5.e_ring = util::spawn_model("p8_fxp_hell_sphere", level.var_5d5b7e8e.var_a41818b5.origin);
	function_5c135d54(500);
	level.var_5d5b7e8e.var_a41818b5.e_ring linkto(level.var_5d5b7e8e.var_a41818b5);
	level.var_5d5b7e8e.var_a41818b5.e_ring thread function_93a18905();
	array::run_all(getplayers(), &clientfield::set_to_player, "" + #"hash_78b8d89d34b32241", 1);
	level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 1);
	foreach(s_altar in level.var_76a7ad28)
	{
		s_altar.var_3468124 zm_perks::function_efd2c9e6();
	}
	foreach(e_pap in level.var_4d8e32c8)
	{
		e_pap flag::set("pap_waiting_for_user");
		e_pap zm_orange_pap::function_e3921120(0);
	}
	wait(2);
	level thread function_4c647a2();
	wait(3);
	level.var_857878e6 = &function_f78ab325;
	level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 1);
	level.var_5d5b7e8e.var_a41818b5 setspeed(10);
	level.var_5d5b7e8e.var_a41818b5 thread function_25c6ed8d();
}

/*
	Name: function_4c647a2
	Namespace: zm_orange_mq_hell
	Checksum: 0xA56C0A11
	Offset: 0x1E48
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_4c647a2()
{
	level endon(#"end_game");
	zm_orange_util::function_fd24e47f(#"hash_519ab3eee65867f8");
	level.var_1c53964e thread zm_hms_util::function_6a0d675d(#"hash_519ab3eee65867f8");
}

/*
	Name: function_5c135d54
	Namespace: zm_orange_mq_hell
	Checksum: 0x2682BD6
	Offset: 0x1EB8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_5c135d54(n_radius)
{
	level.var_5d5b7e8e.var_a41818b5.e_ring.n_radius = n_radius;
	n_scale = n_radius / 73;
	level.var_5d5b7e8e.var_a41818b5.e_ring setscale(n_scale);
}

/*
	Name: function_25c6ed8d
	Namespace: zm_orange_mq_hell
	Checksum: 0x2D273F38
	Offset: 0x1F38
	Size: 0x30C
	Parameters: 0
	Flags: None
*/
function function_25c6ed8d()
{
	self endon(#"death");
	self waittill(#"fling");
	self setspeed(5);
	vol_fling = getent("hell_start", "str_location");
	var_d49079c = 0;
	foreach(e_player in getplayers())
	{
		if(zombie_utility::is_player_valid(e_player, 0, 0))
		{
			e_player thread namespace_6036de69::fling_player(vol_fling);
			e_player playsound(#"hash_7f08b47352413d9a");
			if(!var_d49079c)
			{
				e_player thread function_6f0a7fea();
				var_d49079c = 1;
			}
		}
	}
	zm_hms_util::function_314447b(0);
	self waittill(#"defend");
	self playsound(#"hash_1af3a3933941d01a");
	level function_9be0a8a6("sc_lantern_1");
	self waittill(#"defend");
	self playsound(#"hash_1af3a3933941d01a");
	level function_9be0a8a6("sc_lantern_2");
	self waittill(#"defend");
	self playsound(#"hash_1af3a3933941d01a");
	level function_9be0a8a6("sc_lantern_4");
	self waittill(#"zip");
	self setspeed(7);
	self waittill(#"zip_end");
	self setspeed(5);
	self waittill(#"last_stand");
	level thread function_3c3bee91();
}

/*
	Name: function_93a18905
	Namespace: zm_orange_mq_hell
	Checksum: 0x49276E3A
	Offset: 0x2250
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function function_93a18905()
{
	self endoncallback(&function_c1189522, #"death");
	while(true)
	{
		n_radius_sqr = self.n_radius * self.n_radius;
		foreach(e_player in getplayers())
		{
			if(distancesquared(self.origin, e_player.origin) > n_radius_sqr)
			{
				if(e_player.var_8ec9550d !== 1)
				{
					e_player thread function_87b541aa();
				}
				continue;
			}
			if(e_player.var_8ec9550d !== 0)
			{
				e_player function_2649e7fc();
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_87b541aa
	Namespace: zm_orange_mq_hell
	Checksum: 0xEADD9C8E
	Offset: 0x2398
	Size: 0xB6
	Parameters: 0
	Flags: None
*/
function function_87b541aa()
{
	self endon(#"death");
	self.var_8ec9550d = 1;
	self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 2);
	self zm_audio::create_and_play_dialog(#"hell_on_earth", #"circle");
	while(self.var_8ec9550d)
	{
		self dodamage(10, self.origin);
		wait(1);
	}
}

/*
	Name: function_2649e7fc
	Namespace: zm_orange_mq_hell
	Checksum: 0x224D3710
	Offset: 0x2458
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_2649e7fc()
{
	self.var_8ec9550d = 0;
	self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 1);
}

/*
	Name: function_c1189522
	Namespace: zm_orange_mq_hell
	Checksum: 0xD97EAEFE
	Offset: 0x24A0
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function function_c1189522(s_notify)
{
	foreach(e_player in getplayers())
	{
		e_player.var_8ec9550d = 0;
		e_player clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 0);
	}
}

/*
	Name: function_36eb3c96
	Namespace: zm_orange_mq_hell
	Checksum: 0xD1A34125
	Offset: 0x2560
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function function_36eb3c96(var_88206a50, ent)
{
	if(isdefined(ent))
	{
		b_killed_by_player = isplayer(ent.attacker) || isplayer(ent.damageinflictor);
		b_in_range = distancesquared(var_88206a50.origin, ent.origin) < (level.var_5d5b7e8e.var_a41818b5.e_ring.n_radius * level.var_5d5b7e8e.var_a41818b5.e_ring.n_radius);
		return b_killed_by_player && b_in_range;
	}
	return 0;
}

/*
	Name: function_defd8c26
	Namespace: zm_orange_mq_hell
	Checksum: 0x42902848
	Offset: 0x2650
	Size: 0xF4
	Parameters: 2
	Flags: None
*/
function function_defd8c26(var_f0e6c7a2, ent)
{
	n_souls_required = var_f0e6c7a2.var_bc07224f;
	if(getplayers().size > 2)
	{
		n_souls_required = var_f0e6c7a2.var_71561996;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = var_f0e6c7a2.var_d4fada4a;
	}
	var_f0e6c7a2.var_7944be4a++;
	/#
		if(level flag::get(#"soul_fill"))
		{
			var_f0e6c7a2.var_7944be4a = n_souls_required;
		}
	#/
	if(var_f0e6c7a2.var_7944be4a >= n_souls_required)
	{
		var_f0e6c7a2 function_5e3a92e();
	}
}

/*
	Name: function_f578fb22
	Namespace: zm_orange_mq_hell
	Checksum: 0x7E9BD407
	Offset: 0x2750
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_f578fb22(var_f0e6c7a2, ent)
{
}

/*
	Name: function_5e3a92e
	Namespace: zm_orange_mq_hell
	Checksum: 0x8B2918BE
	Offset: 0x2770
	Size: 0x2E4
	Parameters: 0
	Flags: None
*/
function function_5e3a92e()
{
	namespace_617a54f4::function_2a94055d(self.var_5f9f040);
	level thread function_a4210fd2(6);
	playsoundatposition(#"evt_nuke_flash", (0, 0, 0));
	a_e_players = getplayers();
	if(a_e_players.size > 1)
	{
		array::thread_all(a_e_players, &zm_player::spectator_respawn_player);
	}
	if(self.var_32245390 === 1)
	{
		v_drop = self.origin;
		if(isdefined(self.target))
		{
			s_drop = struct::get(self.target);
			v_drop = s_drop.origin;
		}
		v_ground = groundtrace((v_drop + vectorscale((1, 0, 0), 32)) + vectorscale((0, 0, 1), 8), (v_drop + vectorscale((1, 0, 0), 32)) + (vectorscale((0, 0, -1), 100000)), 0, self)[#"position"];
		level thread zm_powerups::specific_powerup_drop("full_ammo", v_ground, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
		v_ground = groundtrace((v_drop - vectorscale((1, 0, 0), 32)) + vectorscale((0, 0, 1), 8), (v_drop - vectorscale((1, 0, 0), 32)) + (vectorscale((0, 0, -1), 100000)), 0, self)[#"position"];
		level thread zm_powerups::specific_powerup_drop("carpenter", v_ground, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
	}
	function_cb00d0e9();
	level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 1);
	level.var_5d5b7e8e.var_a41818b5 thread function_fd5d0f2d(3);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_f78ab325
	Namespace: zm_orange_mq_hell
	Checksum: 0x6D601E70
	Offset: 0x2A60
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_f78ab325()
{
	wait(1);
	self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 1);
	self.var_8ec9550d = 0;
}

/*
	Name: function_fd5d0f2d
	Namespace: zm_orange_mq_hell
	Checksum: 0x70292BDE
	Offset: 0x2AB0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_fd5d0f2d(n_delay)
{
	self endon(#"death");
	wait(n_delay);
	level.var_5d5b7e8e.var_a41818b5 setspeed(5);
}

/*
	Name: function_a4210fd2
	Namespace: zm_orange_mq_hell
	Checksum: 0x244D0EB1
	Offset: 0x2B08
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_a4210fd2(n_time)
{
	level endon(#"end_game");
	zm_hms_util::function_314447b(1);
	wait(n_time);
	zm_hms_util::function_314447b(0);
}

/*
	Name: function_9be0a8a6
	Namespace: zm_orange_mq_hell
	Checksum: 0x58217EE6
	Offset: 0x2B68
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function function_9be0a8a6(str_id)
{
	level.var_5d5b7e8e.var_a41818b5 setspeedimmediate(0);
	level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 2);
	level thread zm_orange_util::function_fd24e47f(#"hash_6f4de6a856d64c98");
	function_95557832();
	s_sc = struct::get(str_id, "script_noteworthy");
	s_sc.var_7944be4a = 0;
	s_sc.var_5f9f040 = hash(str_id);
	namespace_617a54f4::function_3f808d3d(s_sc.var_5f9f040);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_e2b8d7bb
	Namespace: zm_orange_mq_hell
	Checksum: 0x1613FEB5
	Offset: 0x2CA8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_e2b8d7bb()
{
	self endon(#"death");
	self setspeedimmediate(0);
	/#
		iprintlnbold("");
	#/
	level waittilltimeout(10, #"zipline_used");
	self setspeed(25);
}

/*
	Name: function_3c3bee91
	Namespace: zm_orange_mq_hell
	Checksum: 0x7D70DC86
	Offset: 0x2D38
	Size: 0x2C4
	Parameters: 0
	Flags: None
*/
function function_3c3bee91()
{
	level.var_5d5b7e8e.var_a41818b5 setspeedimmediate(0);
	function_95557832();
	namespace_617a54f4::function_3f808d3d(#"sc_lantern_end");
	level thread zm_orange_util::function_fd24e47f(#"hash_6f4de6a856d64c98");
	/#
		iprintlnbold("");
	#/
	thread function_27c3d40f();
	wait(20);
	level.var_5d5b7e8e.var_a41818b5.e_ring function_d12badc3(200);
	thread function_199360fe();
	wait(15);
	zm_orange_util::function_fd24e47f(#"hash_5aba3394c65e8f8c");
	wait(5);
	namespace_617a54f4::function_2a94055d(#"sc_lantern_end");
	zm_hms_util::function_314447b(1);
	if(getplayers().size > 1)
	{
		level thread zm_player::spectators_respawn();
	}
	level flag::set(#"hold_round_end");
	level.var_d555ff19 = 1;
	level.musicsystemoverride = 0;
	music::setmusicstate("none");
	playsoundatposition(#"hash_2b86a75118ae1608", (0, 0, 0));
	level.var_5d5b7e8e.var_a41818b5.e_ring delete();
	level flag::clear(#"hell_on_earth");
	level.var_5d5b7e8e.var_a41818b5 setspeed(2);
	level.var_857878e6 = undefined;
	wait(1);
	level zm_orange_util::function_fd24e47f(#"hash_66817621c4ce4596");
	wait(1);
	level thread function_737be926();
}

/*
	Name: function_27c3d40f
	Namespace: zm_orange_mq_hell
	Checksum: 0xB5DE5170
	Offset: 0x3008
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_27c3d40f()
{
	playsoundatposition(#"evt_last_stand", (0, 0, 0));
	wait(1);
	music::setmusicstate("hell_on_earth_2");
}

/*
	Name: function_199360fe
	Namespace: zm_orange_mq_hell
	Checksum: 0x600445C5
	Offset: 0x3060
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_199360fe()
{
	wait(6);
	playsoundatposition(#"hash_7450f52d085366c6", (0, 0, 0));
}

/*
	Name: function_d12badc3
	Namespace: zm_orange_mq_hell
	Checksum: 0xD37FACCC
	Offset: 0x3098
	Size: 0x70
	Parameters: 1
	Flags: None
*/
function function_d12badc3(n_radius)
{
	self endon(#"death");
	while(self.n_radius > n_radius)
	{
		wait(0.1);
		function_5c135d54(max(200, self.n_radius - 1));
	}
}

/*
	Name: function_2855a4fc
	Namespace: zm_orange_mq_hell
	Checksum: 0xF7E990CD
	Offset: 0x3110
	Size: 0x8C
	Parameters: 2
	Flags: None
*/
function function_2855a4fc(e_item, e_player)
{
	level flag::set(#"hash_621acea2fedc0408");
	e_player playrumbleonentity("zm_mansion_atlas_interact_rumble");
	e_item.var_e70e15ad delete();
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_cb00d0e9
	Namespace: zm_orange_mq_hell
	Checksum: 0xE6BA82A0
	Offset: 0x31A8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_cb00d0e9()
{
	n_spawn_delay = [[level.func_get_zombie_spawn_delay]](max(level.round_number, 30));
	zombie_utility::set_zombie_var(#"zombie_spawn_delay", 2 * n_spawn_delay);
}

/*
	Name: function_95557832
	Namespace: zm_orange_mq_hell
	Checksum: 0x12DD13DE
	Offset: 0x3218
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_95557832()
{
	zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[level.func_get_zombie_spawn_delay]](max(level.round_number, 30)));
}

/*
	Name: lava_rock_init
	Namespace: zm_orange_mq_hell
	Checksum: 0x65C57721
	Offset: 0x3270
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function lava_rock_init()
{
	self.var_3a161b40 = self.origin;
	self.var_dfcc5d82 = spawn("trigger_radius_new", self.origin, 0, 384);
	self.var_dfcc5d82.e_rock = self;
	self.origin = self.origin - vectorscale((0, 0, 1), 100);
	self.var_dfcc5d82 triggerenable(0);
}

/*
	Name: function_a8fd16d0
	Namespace: zm_orange_mq_hell
	Checksum: 0x5EFAAC49
	Offset: 0x3308
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_a8fd16d0()
{
	self.origin = self.var_3a161b40 - vectorscale((0, 0, 1), 16);
	self.var_dfcc5d82 thread function_8a1356b6();
	self.var_dfcc5d82 triggerenable(1);
}

/*
	Name: function_8a1356b6
	Namespace: zm_orange_mq_hell
	Checksum: 0xD25821E3
	Offset: 0x3370
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function function_8a1356b6()
{
	self endon(#"death");
	self waittill(#"trigger");
	self.e_rock moveto(self.e_rock.var_3a161b40, 0.5);
	self.e_rock playsound(#"hash_7d258d025446af9");
	self delete();
}

/*
	Name: function_6f0a7fea
	Namespace: zm_orange_mq_hell
	Checksum: 0xEFEB9265
	Offset: 0x3418
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_6f0a7fea()
{
	self endoncallback(&function_7a57c14, #"death");
	while(self.var_e63ac5c !== 1)
	{
		wait(1);
	}
	while(self.var_e63ac5c)
	{
		wait(1);
	}
	function_7a57c14();
}

/*
	Name: function_7a57c14
	Namespace: zm_orange_mq_hell
	Checksum: 0x3718AD68
	Offset: 0x3490
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_7a57c14(s_notify)
{
	level.var_1c53964e thread zm_hms_util::function_6a0d675d(#"hash_7f649ba02c11110c");
}

/*
	Name: function_737be926
	Namespace: zm_orange_mq_hell
	Checksum: 0xB276BF34
	Offset: 0x34D0
	Size: 0x154
	Parameters: 0
	Flags: None
*/
function function_737be926()
{
	zm_hms_util::function_3c173d37();
	foreach(e_player in getplayers())
	{
		e_player playsoundtoplayer(#"hash_5742cfb2660b4d62", e_player);
	}
	n_wait_time = float(soundgetplaybacktime(#"hash_5742cfb2660b4d62")) / 1000;
	wait(n_wait_time);
	level.var_5d5b7e8e.var_a41818b5 namespace_2e9c09b3::function_f1827cc6(&function_2855a4fc, zm_utility::function_d6046228(#"hash_50d83a4f11ad9d8", #"hash_51d8e27e625c6bd4"), undefined, 128);
}

/*
	Name: function_c5bf1974
	Namespace: zm_orange_mq_hell
	Checksum: 0xC7AAFFEF
	Offset: 0x3630
	Size: 0x18C
	Parameters: 0
	Flags: None
*/
function function_c5bf1974()
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		namespace_99a6629b::function_80a9077f();
		zm_orange_zones::function_3b77181c(1);
		if(!level flag::get(#"hash_6f7fd3d4d070db87"))
		{
			level.var_a385f14 notify(#"force_extinguisher");
		}
		a_s_start_pos = struct::get_array("");
		a_e_players = getplayers();
		n_index = 0;
		foreach(e_player in a_e_players)
		{
			s_pos = a_s_start_pos[n_index];
			e_player setorigin(s_pos.origin);
			e_player setplayerangles(s_pos.angles);
			n_index++;
		}
		wait(3);
	#/
}

/*
	Name: function_405f867d
	Namespace: zm_orange_mq_hell
	Checksum: 0xF58D2EEC
	Offset: 0x37C8
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function function_405f867d()
{
	/#
		a_s_start_pos = struct::get_array("");
		a_e_players = getplayers();
		n_index = 0;
		foreach(e_player in a_e_players)
		{
			s_pos = a_s_start_pos[n_index];
			e_player setorigin(s_pos.origin);
			e_player setplayerangles(s_pos.angles);
			n_index++;
		}
		level.var_5d5b7e8e.var_a41818b5 vehicle::get_off_path();
		var_1452c94f = getvehiclenode("", "");
		level.var_5d5b7e8e.var_a41818b5.origin = var_1452c94f.origin;
		level thread function_3c3bee91();
	#/
}

/*
	Name: function_fe36418c
	Namespace: zm_orange_mq_hell
	Checksum: 0x1D8101B
	Offset: 0x3978
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function function_fe36418c()
{
	/#
		if(!isdefined(level.var_5d5b7e8e.var_a41818b5))
		{
			spawn_guide();
		}
		zm_hms_util::function_314447b(1, 0);
		level.var_5d5b7e8e.var_a41818b5 setspeed(5);
		level.var_5d5b7e8e.var_a41818b5 thread vehicle::get_on_and_go_path(level.var_5d5b7e8e.nd_start);
	#/
}

/*
	Name: test_hell
	Namespace: zm_orange_mq_hell
	Checksum: 0x77553BB6
	Offset: 0x3A28
	Size: 0x218
	Parameters: 0
	Flags: None
*/
function test_hell()
{
	/#
		lava_control();
		level.var_5d5b7e8e.var_5ca15e11 show();
		level.var_5d5b7e8e.var_5ca15e11 solid();
		array::thread_all(level.var_35e33dbe, &function_a8fd16d0);
		level flag::set(#"hell_on_earth");
		level.musicsystemoverride = 1;
		music::setmusicstate("");
		level clientfield::set("" + #"hash_5e69ee96304ec40b", 1);
		foreach(s_altar in level.var_76a7ad28)
		{
			s_altar.var_3468124 zm_perks::function_efd2c9e6();
		}
		foreach(e_pap in level.var_4d8e32c8)
		{
			e_pap flag::set("");
			e_pap zm_orange_pap::function_e3921120(0);
		}
	#/
}

