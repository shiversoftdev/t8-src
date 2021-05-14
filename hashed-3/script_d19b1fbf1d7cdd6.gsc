// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2fcb47e3735a6edd;
#using script_5660bae5b402a1eb;
#using script_57f7003580bb15e0;
#using script_6a3f43063dfd1bdc;
#using script_6e3c826b1814cab6;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d09ff23c;

/*
	Name: function_89f2df9
	Namespace: namespace_d09ff23c
	Checksum: 0xA7F00795
	Offset: 0x400
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2336b570f470a29c", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d09ff23c
	Checksum: 0xDB1253AF
	Offset: 0x450
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.var_db63b33b))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_db63b33b = object;
		[[ level.var_db63b33b ]]->initialize(2, 0.1);
	}
	init_clientfields();
	/#
		level thread devgui();
		function_f5a342bc();
	#/
}

/*
	Name: __main__
	Namespace: namespace_d09ff23c
	Checksum: 0x1C26BE17
	Offset: 0x4E0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.var_f92c8836 = struct::get_array("lighthouse_trap_switch", "script_noteworthy");
	array::run_all(level.var_f92c8836, &trap_switch_init);
	level.var_ab11c23d = getent("lighthouse_light", "targetname");
	level thread function_ad646ef8(0);
	level.var_98138d6b = 0;
	level thread function_b87894c1("power_on1");
	if(!zm_utility::is_standard())
	{
		level thread function_b87894c1("power_on2");
		level thread function_b87894c1("power_on3");
	}
	var_f9b3aa5e = getentarray("use_elec_switch", "targetname");
	array::thread_all(var_f9b3aa5e, &function_fcbb2307);
	zm_traps::register_trap_damage("lighthouse", &function_542e3c73, &function_2853c44e);
}

/*
	Name: init_clientfields
	Namespace: namespace_d09ff23c
	Checksum: 0x2F1798FA
	Offset: 0x678
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "lighthouse_on", 24000, 3, "int");
	clientfield::register("vehicle", "" + #"hash_19bce46b8ab82440", 24000, 1, "int");
	clientfield::register("actor", "" + #"hash_5af1cd27f90895ae", 24000, 1, "counter");
}

/*
	Name: function_6a10478
	Namespace: namespace_d09ff23c
	Checksum: 0x626FABC5
	Offset: 0x738
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_6a10478()
{
	if(level flag::get(#"hash_5a3d0402a5557739"))
	{
		level.var_ab11c23d clientfield::set("lighthouse_on", 2);
		function_1f29d511();
	}
	else
	{
		level.var_ab11c23d clientfield::set("lighthouse_on", 1);
	}
	function_da304f6e(3);
}

/*
	Name: function_da304f6e
	Namespace: namespace_d09ff23c
	Checksum: 0x2545B286
	Offset: 0x7E0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_da304f6e(n_state)
{
	if(level.var_ab11c23d.var_3931cef9 !== n_state)
	{
		level.var_ab11c23d notify(#"hash_78fc5bbd712046b0");
		level.var_ab11c23d.var_3931cef9 = n_state;
		if(!is_trap_active())
		{
			function_d85bd834();
		}
	}
}

/*
	Name: function_d85bd834
	Namespace: namespace_d09ff23c
	Checksum: 0xE0196AE8
	Offset: 0x870
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_d85bd834()
{
	switch(level.var_ab11c23d.var_3931cef9)
	{
		case 0:
		{
			level.var_ab11c23d thread function_1aeab14e();
			break;
		}
		case 1:
		{
			level.var_ab11c23d thread lighthouse_freakout();
			break;
		}
		case 2:
		{
			level.var_ab11c23d thread function_92b102fc();
			break;
		}
		case 3:
		{
			level.var_ab11c23d thread function_dbad2f5a();
			break;
		}
	}
}

/*
	Name: function_dbad2f5a
	Namespace: namespace_d09ff23c
	Checksum: 0xCBB2E78C
	Offset: 0x968
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_dbad2f5a()
{
	self endon(#"death", #"hash_78fc5bbd712046b0");
	level endon(#"end_game");
	self thread function_1b488412(level.var_3428b470.origin, 1);
	wait(5);
	level thread function_da304f6e(0);
}

/*
	Name: function_1aeab14e
	Namespace: namespace_d09ff23c
	Checksum: 0xA5E4214D
	Offset: 0x9F8
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function function_1aeab14e()
{
	self endon(#"death", #"hash_78fc5bbd712046b0");
	var_14c78bd5 = 2;
	var_223dfca3 = 0.2;
	var_d4cb0c1 = var_223dfca3 / 2;
	if(level flag::get(#"hash_5a3d0402a5557739"))
	{
		level.var_ab11c23d clientfield::set("lighthouse_on", 2);
	}
	if(self.angles[0] != 0)
	{
		self rotateto((10, self.angles[1] + 50, 0), var_14c78bd5);
		wait(var_14c78bd5);
	}
	while(true)
	{
		self rotateto((10, self.angles[1] + 5, 0), var_223dfca3);
		wait(var_d4cb0c1);
	}
}

/*
	Name: lighthouse_freakout
	Namespace: namespace_d09ff23c
	Checksum: 0x6A306E5E
	Offset: 0xB40
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function lighthouse_freakout()
{
	self endon(#"death", #"hash_78fc5bbd712046b0");
	while(true)
	{
		n_time = randomfloatrange(0.5, 1);
		self rotateto((randomintrange(-90, 90), randomintrange(-180, 180), randomintrange(-90, 90)), n_time);
		self waittill(#"rotatedone");
	}
}

/*
	Name: function_92b102fc
	Namespace: namespace_d09ff23c
	Checksum: 0xF88B934B
	Offset: 0xC18
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_92b102fc()
{
	v_pap = level.var_7d8bf93f.origin;
	self function_1b488412(v_pap, 1);
	if(level flag::get(#"hash_5a3d0402a5557739"))
	{
		level.var_ab11c23d clientfield::set("lighthouse_on", 3);
	}
}

/*
	Name: function_1b488412
	Namespace: namespace_d09ff23c
	Checksum: 0xAA0054E3
	Offset: 0xCA8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_1b488412(v_pos, n_aim_time)
{
	v_dir = v_pos - self.origin;
	angles = vectortoangles(v_dir);
	self rotateto(angles, n_aim_time);
}

/*
	Name: function_b87894c1
	Namespace: namespace_d09ff23c
	Checksum: 0x51D7F821
	Offset: 0xD20
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_b87894c1(str_flag)
{
	level endon(#"game_ended");
	level flag::wait_till(str_flag);
	function_45489835(str_flag);
	if(level.var_98138d6b < 1)
	{
		function_1baa684c(str_flag);
	}
	level thread function_320f5fb3();
}

/*
	Name: function_45489835
	Namespace: namespace_d09ff23c
	Checksum: 0xA102A9B5
	Offset: 0xDC0
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function function_45489835(str_flag)
{
	switch(str_flag)
	{
		case "power_on1":
		{
			playsoundatposition(#"hash_5f9ff903d1e07acb", (0, 0, 0));
			break;
		}
		case "power_on2":
		{
			playsoundatposition(#"hash_7bb9774ddb11bc9f", (0, 0, 0));
			playsoundatposition(#"hash_957e90e703a238a", (1311, -1971, 1102));
			break;
		}
		case "power_on3":
		{
			playsoundatposition(#"hash_4760ffee46ef7f74", (0, 0, 0));
			break;
		}
	}
}

/*
	Name: function_320f5fb3
	Namespace: namespace_d09ff23c
	Checksum: 0x18192C49
	Offset: 0xEC8
	Size: 0x1E2
	Parameters: 0
	Flags: Linked
*/
function function_320f5fb3()
{
	level endon(#"end_game");
	level.var_98138d6b++;
	switch(level.var_98138d6b)
	{
		case 1:
		{
			function_6a10478();
			wait(3);
			if(isdefined(level.var_9a8dee15))
			{
				level.var_9a8dee15 thread namespace_3263198e::function_51b752a9(#"hash_52d22e25dd1ac29f");
			}
			break;
		}
		case 2:
		{
			level thread namespace_44916ada::function_56db9cdc();
			if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") != 2)
			{
				wait(3);
				level.var_1c53964e namespace_509a75d1::function_6a0d675d("vox_power_switch_2_activate");
				level thread namespace_3263198e::function_fd24e47f("vox_power_switch_2_activate");
			}
			level thread namespace_3263198e::function_3d6809e9();
			break;
		}
		case 3:
		{
			level.var_6ed7c585 = 1;
			level thread namespace_44916ada::function_2401694f();
			if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") != 2)
			{
				wait(3);
				level.var_1c53964e thread namespace_509a75d1::function_6a0d675d("vox_power_switch_3_activate");
			}
			break;
		}
	}
}

/*
	Name: function_602d605
	Namespace: namespace_d09ff23c
	Checksum: 0xE04FF06F
	Offset: 0x10B8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_602d605()
{
	level.var_ab11c23d clientfield::set("lighthouse_on", 2);
	level.var_ab11c23d.b_blue = 1;
	if(level flag::get(#"hash_3028604821838259"))
	{
		exploder::exploder("fxexp_pap_light_icefloe");
	}
	level thread function_ad646ef8(2);
}

/*
	Name: function_1f29d511
	Namespace: namespace_d09ff23c
	Checksum: 0x3E0C1702
	Offset: 0x1158
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_1f29d511()
{
	array::thread_all(level.var_f92c8836, &function_1e43f3c7);
	level thread function_ad646ef8(2);
}

/*
	Name: function_1baa684c
	Namespace: namespace_d09ff23c
	Checksum: 0x9B845018
	Offset: 0x11A8
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_1baa684c(str_flag)
{
	switch(str_flag)
	{
		case "power_on1":
		{
			level.var_3428b470 = struct::get("power_intro_1");
			break;
		}
		case "power_on2":
		{
			level.var_3428b470 = struct::get("power_intro_2");
			break;
		}
		case "power_on3":
		{
			level.var_3428b470 = struct::get("power_intro_3");
			break;
		}
	}
}

/*
	Name: function_ad646ef8
	Namespace: namespace_d09ff23c
	Checksum: 0xE32E927A
	Offset: 0x1278
	Size: 0x39A
	Parameters: 1
	Flags: Linked
*/
function function_ad646ef8(n_state)
{
	var_5606acc0 = level.var_ab11c23d;
	if(var_5606acc0.var_58df9892 !== n_state)
	{
		var_5606acc0 notify(#"hash_1aa56851d9d4ec0d");
		var_5606acc0.var_58df9892 = n_state;
		/#
			iprintln("" + level.var_4b3d7dc1[var_5606acc0.var_58df9892]);
		#/
		switch(var_5606acc0.var_58df9892)
		{
			case 0:
			{
				array::thread_all(level.var_f92c8836, &function_76adab5e);
				break;
			}
			case 1:
			{
				var_5606acc0 notify(#"hash_6e9ab520bd7ba3c");
				function_d85bd834();
				array::run_all(level.var_f92c8836, &function_f7e6bf61, 0);
				n_cooldown = zm_traps::function_da13db45(60, var_5606acc0.var_d9ae30d6);
				var_5606acc0.var_a5a067c5 = undefined;
				var_5606acc0.var_d9ae30d6 = undefined;
				var_5606acc0.activated_by_player = undefined;
				var_5606acc0.v_trap_target = undefined;
				var_5606acc0 thread function_74b930af(n_cooldown, 2);
				break;
			}
			case 2:
			{
				array::thread_all(level.var_f92c8836, &function_76adab5e);
				break;
			}
			case 3:
			{
				var_5606acc0 notify(#"hash_78fc5bbd712046b0");
				var_5606acc0 thread function_71399d9c();
				break;
			}
			case 4:
			{
				var_5606acc0 thread function_ef69a891(var_5606acc0.var_a5a067c5, var_5606acc0.var_d9ae30d6);
				break;
			}
			case 5:
			{
				var_5606acc0 thread function_72ff128e(var_5606acc0.v_trap_target);
				break;
			}
			case 6:
			{
				var_5606acc0 thread shoot_trap_target(var_5606acc0.v_trap_target, var_5606acc0.var_d9ae30d6);
				break;
			}
			case 7:
			{
				var_5606acc0.v_trap_target = undefined;
				var_5606acc0 thread function_ea089392();
				var_5606acc0 thread function_74b930af(3, 4);
				break;
			}
			case 8:
			{
				var_5606acc0 thread function_74a24d00();
				break;
			}
			case 9:
			{
				var_5606acc0 thread function_76ff758d();
				break;
			}
		}
	}
}

/*
	Name: function_74b930af
	Namespace: namespace_d09ff23c
	Checksum: 0xB210AABC
	Offset: 0x1620
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_74b930af(n_time, n_state)
{
	self endon(#"death", #"hash_6e9ab520bd7ba3c");
	wait(n_time);
	while(n_state == 1 && (self.var_58df9892 == 5 || self.var_58df9892 == 6))
	{
		wait(0.1);
	}
	level thread function_ad646ef8(n_state);
}

/*
	Name: function_71399d9c
	Namespace: namespace_d09ff23c
	Checksum: 0xC5B0EB3E
	Offset: 0x16C0
	Size: 0x21C
	Parameters: 0
	Flags: Linked
*/
function function_71399d9c()
{
	self endon(#"death", #"hash_1aa56851d9d4ec0d");
	vh_target = spawner::simple_spawn_single(getent("virgil", "targetname"));
	while(!isdefined(vh_target))
	{
		waitframe(1);
		vh_target = spawner::simple_spawn_single(getent("virgil", "targetname"));
	}
	vh_target.origin = self.var_223285b1.origin;
	vh_target.b_moving = 0;
	vh_target val::set(#"trap_target", "takedamage", 0);
	self.vh_target = vh_target;
	self function_1b488412(vh_target.origin, 1);
	self waittill(#"rotatedone");
	level.var_ab11c23d clientfield::set("lighthouse_on", 4);
	self.vh_target clientfield::set("" + #"hash_19bce46b8ab82440", 1);
	self.vh_target thread function_18f63949();
	self function_2b2f2a7f();
	self.var_9bda8088 thread zm_traps::trap_damage();
	self.var_9bda8088 thread soapstone_watcher();
	wait(2);
	level thread function_ad646ef8(8);
}

/*
	Name: function_2b2f2a7f
	Namespace: namespace_d09ff23c
	Checksum: 0x4D4E505E
	Offset: 0x18E8
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_2b2f2a7f()
{
	var_9bda8088 = spawn("trigger_radius_new", self.vh_target.origin, 512 | 1, 100);
	var_9bda8088._trap_type = "lighthouse";
	var_9bda8088 enablelinkto();
	var_9bda8088 linkto(self.vh_target);
	self.var_9bda8088 = var_9bda8088;
	var_9bda8088.activated_by_player = level.var_ab11c23d.activated_by_player;
}

/*
	Name: function_74a24d00
	Namespace: namespace_d09ff23c
	Checksum: 0x3876B187
	Offset: 0x19A8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_74a24d00()
{
	self.vh_target thread vehicle::get_on_and_go_path(self.var_223285b1);
	self.vh_target setspeed(self.var_3f813eec);
	self.vh_target.b_moving = 1;
	self.vh_target thread function_fc65cb61();
}

/*
	Name: function_18f63949
	Namespace: namespace_d09ff23c
	Checksum: 0x65D63047
	Offset: 0x1A20
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_18f63949()
{
	self endon(#"death");
	while(true)
	{
		if(self.b_moving)
		{
			level.var_ab11c23d function_1b488412(self.origin, 0.1);
		}
		wait(0.1);
	}
}

/*
	Name: function_fc65cb61
	Namespace: namespace_d09ff23c
	Checksum: 0x4566C0D9
	Offset: 0x1A88
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_fc65cb61()
{
	self endon(#"death");
	self waittill(#"reached_end_node");
	level.var_ab11c23d thread function_76ff758d();
}

/*
	Name: function_76ff758d
	Namespace: namespace_d09ff23c
	Checksum: 0x13E89DE6
	Offset: 0x1AD8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_76ff758d()
{
	self endon(#"death");
	self.vh_target.b_moving = 0;
	wait(2);
	self.var_9bda8088 notify(#"trap_done");
	self.vh_target clientfield::set("" + #"hash_19bce46b8ab82440", 0);
	self.var_9bda8088 delete();
	self.vh_target delete();
	level thread function_ad646ef8(1);
}

/*
	Name: function_56b9aca4
	Namespace: namespace_d09ff23c
	Checksum: 0x8302EB5F
	Offset: 0x1BA8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_56b9aca4(var_64c09f7f)
{
	var_82224aaf = (isdefined(self.var_82224aaf) ? self.var_82224aaf : 500);
	a_e_targets = var_64c09f7f function_bdda420f(self.origin, var_82224aaf);
	if(a_e_targets.size > 0)
	{
		return arraygetclosest(self.origin, a_e_targets);
	}
}

/*
	Name: function_72ff128e
	Namespace: namespace_d09ff23c
	Checksum: 0xE5D01AFD
	Offset: 0x1C38
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_72ff128e(v_target)
{
	self endon(#"death", #"hash_1aa56851d9d4ec0d");
	self function_1b488412(v_target, 1);
	self waittill(#"rotatedone");
	level thread function_ad646ef8(6);
}

/*
	Name: shoot_trap_target
	Namespace: namespace_d09ff23c
	Checksum: 0xFDFB53FC
	Offset: 0x1CC0
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function shoot_trap_target(v_target, var_64c09f7f)
{
	self endon(#"death", #"hash_1aa56851d9d4ec0d");
	wait(0.5);
	trigger_trap_explosion(v_target, var_64c09f7f);
	level thread function_ad646ef8(7);
}

/*
	Name: trigger_trap_explosion
	Namespace: namespace_d09ff23c
	Checksum: 0x737412FF
	Offset: 0x1D40
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function trigger_trap_explosion(v_pos, var_64c09f7f)
{
	var_a2e909e9 = var_64c09f7f function_bdda420f(v_pos, 250);
	array::thread_all(var_a2e909e9, &zm_trap_electric::damage, level.var_ab11c23d);
	if(var_a2e909e9.size > 0)
	{
		level notify(#"hash_5e2619172b4487dd", {#n_count:var_a2e909e9.size});
	}
	a_e_players = getplayers();
	var_6cb5ae98 = 250 * 250;
	foreach(e_player in a_e_players)
	{
		if(distancesquared(v_pos, e_player.origin) <= var_6cb5ae98)
		{
			e_player thread zm_trap_electric::player_damage(level.var_ab11c23d);
		}
	}
	if(isdefined(level.s_soapstone) && isdefined(level.s_soapstone.var_4eed727b))
	{
		if(distancesquared(v_pos, level.s_soapstone.var_4eed727b.origin) <= 250 * 250)
		{
			level.s_soapstone.is_charged = 1;
			level.s_soapstone.is_hot = 1;
		}
	}
	level thread function_576ecbe6(v_pos);
}

/*
	Name: function_576ecbe6
	Namespace: namespace_d09ff23c
	Checksum: 0x2928444F
	Offset: 0x1F78
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_576ecbe6(v_pos)
{
	e_tag = util::spawn_model("tag_origin", v_pos, (0, 0, 0));
	wait(5);
	e_tag delete();
}

/*
	Name: function_27304b98
	Namespace: namespace_d09ff23c
	Checksum: 0xA2403CD7
	Offset: 0x1FD8
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_27304b98(var_a5a067c5, var_a75e9b3b)
{
	var_82224aaf = (isdefined(var_a5a067c5.var_82224aaf) ? var_a5a067c5.var_82224aaf : 500);
	var_548dce62 = var_a5a067c5.origin + var_82224aaf * namespace_509a75d1::function_b649cf93();
	self function_1b488412(var_548dce62, var_a75e9b3b);
}

/*
	Name: function_ef69a891
	Namespace: namespace_d09ff23c
	Checksum: 0x3EBB03B3
	Offset: 0x2070
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_ef69a891(var_a5a067c5, var_64c09f7f)
{
	self endon(#"death", #"hash_1aa56851d9d4ec0d");
	e_target = var_a5a067c5 function_56b9aca4(var_64c09f7f);
	if(!isdefined(e_target))
	{
		self thread function_ea089392();
		while(!isdefined(e_target))
		{
			wait(0.1);
			e_target = var_a5a067c5 function_56b9aca4(var_64c09f7f);
		}
	}
	self.v_trap_target = e_target.origin;
	level thread function_ad646ef8(5);
}

/*
	Name: function_ea089392
	Namespace: namespace_d09ff23c
	Checksum: 0xA7C11031
	Offset: 0x2158
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_ea089392()
{
	self endon(#"death", #"hash_1aa56851d9d4ec0d");
	while(true)
	{
		self function_27304b98(self.var_a5a067c5, 2);
		self waittill(#"rotatedone");
	}
}

/*
	Name: function_2ad3b642
	Namespace: namespace_d09ff23c
	Checksum: 0x73D007F0
	Offset: 0x21D0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_2ad3b642(s_trap)
{
	self thread zm_audio::create_and_play_dialog(#"hash_4ae4c7201edb7f07", #"activate");
	level.var_ab11c23d.var_223285b1 = s_trap.var_223285b1;
	level.var_ab11c23d.var_3f813eec = s_trap.travel_speed;
	level.var_ab11c23d.var_d9ae30d6 = self;
	playsoundatposition(#"zmb_cha_ching", (1692, 444, 134));
	level.var_ab11c23d.activated_by_player = self;
	level thread function_ad646ef8(3);
	array::run_all(level.var_f92c8836, &function_f7e6bf61, 1);
	array::thread_all(level.var_f92c8836, &function_76adab5e);
}

/*
	Name: electrocute_zombie
	Namespace: namespace_d09ff23c
	Checksum: 0xE05E7116
	Offset: 0x2318
	Size: 0x20C
	Parameters: 0
	Flags: None
*/
function electrocute_zombie()
{
	self endon(#"death");
	self clientfield::set("electrocute_ai_fx", 1);
	self.marked_for_death = 1;
	if(isactor(self))
	{
		refs[0] = "guts";
		refs[1] = "right_arm";
		refs[2] = "left_arm";
		refs[3] = "right_leg";
		refs[4] = "left_leg";
		refs[5] = "no_legs";
		refs[6] = "head";
		self.a.gib_ref = refs[randomint(refs.size)];
		playsoundatposition(#"hash_5183b687ad8d715a", self.origin);
		if(math::cointoss())
		{
			self thread zm_traps::electroctute_death_fx();
		}
		function_6eac4ca1(self, "electrocute");
		self notify(#"bhtn_action_notify", {#action:"electrocute"});
		wait(randomfloat(1.25));
		self playsound(#"hash_5183b687ad8d715a");
	}
	self dodamage(self.health + 666, self.origin);
}

/*
	Name: function_93284efd
	Namespace: namespace_d09ff23c
	Checksum: 0xFD219BBC
	Offset: 0x2530
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_93284efd()
{
	var_5b857980 = function_4d1e7b48(#"hash_19533caf858a9f3b");
	if(!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage))
	{
		self thread zm_traps::player_elec_damage(level.var_ab11c23d);
		self status_effect::status_effect_apply(var_5b857980, undefined, self, 0);
	}
}

/*
	Name: trap_switch_init
	Namespace: namespace_d09ff23c
	Checksum: 0x2422EB3F
	Offset: 0x25C0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function trap_switch_init()
{
	self.var_223285b1 = getvehiclenode(self.var_40d27c6d, "targetname");
	a_pieces = namespace_509a75d1::function_bffcedde(self.target, "targetname", "script_noteworthy");
	self.var_c275b624 = a_pieces[#"switch"];
	self.var_307df34b = a_pieces[#"light"];
	self.s_panel = struct::get(self.target);
	self zm_unitrigger::create(&function_85d3d607, 64);
	self thread function_72d528e6();
}

/*
	Name: function_85d3d607
	Namespace: namespace_d09ff23c
	Checksum: 0xE1256C37
	Offset: 0x26C0
	Size: 0x1F6
	Parameters: 1
	Flags: Linked
*/
function function_85d3d607(e_player)
{
	if(level.var_98138d6b < 1)
	{
		self namespace_509a75d1::function_b2e1326(1);
	}
	else if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
	{
		self namespace_509a75d1::function_b2e1326(0);
	}
	else
	{
		switch(level.var_ab11c23d.var_58df9892)
		{
			case 0:
			{
				self namespace_509a75d1::function_b2e1326(0);
				break;
			}
			case 1:
			{
				self namespace_509a75d1::function_b2e1326(4);
				break;
			}
			case 2:
			{
				if(level flag::get(#"half_price_traps"))
				{
					self namespace_509a75d1::function_b2e1326(2, int(500));
				}
				else
				{
					self namespace_509a75d1::function_b2e1326(2, 1000);
				}
				break;
			}
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			{
				self namespace_509a75d1::function_b2e1326(3);
				break;
			}
		}
	}
	return 1;
}

/*
	Name: function_72d528e6
	Namespace: namespace_d09ff23c
	Checksum: 0x7AA6FEF0
	Offset: 0x28C0
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_72d528e6()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.var_ab11c23d.var_58df9892 === 2)
		{
			if(level flag::get(#"half_price_traps"))
			{
				if(self.var_c275b624 zm_traps::function_3f0a4c65(e_who, int(500)))
				{
					e_who function_2ad3b642(self);
				}
			}
			else if(self.var_c275b624 zm_traps::function_3f0a4c65(e_who, 1000))
			{
				e_who function_2ad3b642(self);
			}
		}
	}
}

/*
	Name: function_f7e6bf61
	Namespace: namespace_d09ff23c
	Checksum: 0x97288241
	Offset: 0x2A30
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_f7e6bf61(b_on)
{
	if(b_on)
	{
		self.var_c275b624 rotatepitch(180, 0.5);
	}
	else
	{
		self.var_c275b624 rotatepitch(-180, 0.5);
	}
}

/*
	Name: function_76adab5e
	Namespace: namespace_d09ff23c
	Checksum: 0x46AA6871
	Offset: 0x2AA0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_76adab5e()
{
	switch(level.var_ab11c23d.var_58df9892)
	{
		case 0:
		{
			self.var_307df34b setmodel("p8_zm_off_trap_switch_light");
			break;
		}
		case 3:
		{
			self.var_307df34b setmodel("p8_zm_off_trap_switch_light_red_on");
			break;
		}
		case 2:
		{
			self.var_307df34b setmodel("p8_zm_off_trap_switch_light_green_on");
			break;
		}
	}
}

/*
	Name: function_1e43f3c7
	Namespace: namespace_d09ff23c
	Checksum: 0x3AF975C5
	Offset: 0x2B78
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_1e43f3c7()
{
	self.s_panel scene::play("open");
}

/*
	Name: is_trap_active
	Namespace: namespace_d09ff23c
	Checksum: 0xBB049FE7
	Offset: 0x2BA8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_trap_active()
{
	return level.var_ab11c23d.var_58df9892 > 2;
}

/*
	Name: function_2853c44e
	Namespace: namespace_d09ff23c
	Checksum: 0xC2028685
	Offset: 0x2BD0
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_2853c44e(e_trap)
{
	self endon(#"death");
	self clientfield::increment("" + #"hash_5af1cd27f90895ae", 1);
	if(isdefined(self.fire_damage_func))
	{
		self [[self.fire_damage_func]](e_trap);
	}
	else
	{
		[[ level.var_db63b33b ]]->waitinqueue(self);
		level notify(#"trap_kill", {#e_trap:e_trap, #e_victim:self});
		level notify(#"hash_5e2619172b4487dd", {#n_count:1});
		if(isdefined(level.var_ab11c23d.activated_by_player) && isplayer(level.var_ab11c23d.activated_by_player))
		{
			level.var_ab11c23d.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			level.var_ab11c23d.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		}
		self dodamage(20000, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
	}
}

/*
	Name: function_542e3c73
	Namespace: namespace_d09ff23c
	Checksum: 0x95141CD6
	Offset: 0x2DA0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_542e3c73(e_trap)
{
	if(!isdefined(self.var_ab551063))
	{
		self dodamage(50, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
		self thread function_b00e24fb();
	}
}

/*
	Name: soapstone_watcher
	Namespace: namespace_d09ff23c
	Checksum: 0xF4B17C65
	Offset: 0x2E18
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function soapstone_watcher()
{
	self endon(#"trap_done");
	var_76b556c9 = 0;
	var_dac21b13 = 0;
	while(true)
	{
		if(isdefined(level.s_soapstone) && isdefined(level.s_soapstone.s_placement) && level.s_soapstone.s_placement.var_4eed727b istouching(self))
		{
			var_76b556c9 = var_76b556c9 + 0.1;
			if(var_76b556c9 >= 1)
			{
				if(!level.s_soapstone.is_charged || !level.s_soapstone.is_hot)
				{
					level thread namespace_3263198e::function_fd24e47f("vox_soap_stones_heat", -1, 1, 0);
				}
				level.s_soapstone.is_charged = 1;
				level.s_soapstone.is_hot = 1;
				level.s_soapstone.s_placement.var_4eed727b clientfield::set("soapstone_start_fx", 2);
				level.s_soapstone.s_placement.var_4eed727b setmodel("p8_zm_ora_soapstone_01_hot");
				if(level.s_soapstone.var_b6e5b65f == 2)
				{
					level.s_soapstone.s_placement.var_28f1732d clientfield::set("soapstone_start_fx", 2);
					level.s_soapstone.s_placement.var_28f1732d setmodel("p8_zm_ora_soapstone_01_hot");
				}
				break;
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_b00e24fb
	Namespace: namespace_d09ff23c
	Checksum: 0xD12CC051
	Offset: 0x3050
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_b00e24fb()
{
	self endon(#"death");
	self.var_ab551063 = 1;
	wait(0.5);
	self.var_ab551063 = undefined;
}

/*
	Name: function_fcbb2307
	Namespace: namespace_d09ff23c
	Checksum: 0x4FC9B805
	Offset: 0x3098
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_fcbb2307()
{
	level endon(#"hash_9a7b18e2622af5d");
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	level.var_9a8dee15 = waitresult.activator;
	level notify(#"hash_9a7b18e2622af5d");
}

/*
	Name: function_f5a342bc
	Namespace: namespace_d09ff23c
	Checksum: 0x480A6619
	Offset: 0x3120
	Size: 0x182
	Parameters: 0
	Flags: Private
*/
private function function_f5a342bc()
{
	/#
		if(!isdefined(level.var_4b3d7dc1))
		{
			level.var_4b3d7dc1 = [];
		}
		else if(!isarray(level.var_4b3d7dc1))
		{
			level.var_4b3d7dc1 = array(level.var_4b3d7dc1);
		}
		level.var_4b3d7dc1[0] = "";
		level.var_4b3d7dc1[1] = "";
		level.var_4b3d7dc1[2] = "";
		level.var_4b3d7dc1[3] = "";
		level.var_4b3d7dc1[4] = "";
		level.var_4b3d7dc1[5] = "";
		level.var_4b3d7dc1[6] = "";
		level.var_4b3d7dc1[7] = "";
		level.var_4b3d7dc1[8] = "";
		level.var_4b3d7dc1[9] = "";
	#/
}

/*
	Name: devgui
	Namespace: namespace_d09ff23c
	Checksum: 0xF72BE9B2
	Offset: 0x32B0
	Size: 0x1E0
	Parameters: 0
	Flags: Private
*/
private function devgui()
{
	/#
		level.var_10f86d56 = namespace_509a75d1::function_2719d4c0("", "", "");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"hash_76a56193c8903787", "");
			switch(str_command)
			{
				case "hash_2e5bdb11c6bc0cd":
				{
					getplayers()[0] function_2ad3b642(level.var_10f86d56[0]);
					break;
				}
				case "hash_2e5bab11c6bbbb4":
				{
					getplayers()[0] function_2ad3b642(level.var_10f86d56[1]);
					break;
				}
				case "hash_2e5bbb11c6bbd67":
				{
					getplayers()[0] function_2ad3b642(level.var_10f86d56[2]);
					break;
				}
			}
			setdvar(#"hash_76a56193c8903787", "");
		}
	#/
}

/*
	Name: function_f6d23861
	Namespace: namespace_d09ff23c
	Checksum: 0x85EF2B21
	Offset: 0x3498
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_f6d23861()
{
	/#
		self endon(#"death");
		while(true)
		{
			sphere(self.origin, 100, (1, 0, 0), 0.6, 0, 8, 1);
			waitframe(1);
		}
	#/
}

