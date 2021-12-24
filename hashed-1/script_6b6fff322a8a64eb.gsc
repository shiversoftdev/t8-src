// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b65a63cea0fa4b5;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_4333a03353e1e13a;
#using script_52c6c2d1a2ef1b46;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using script_b52a163973f339f;
#using script_db06eb511bd9b36;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_f9df92f;

/*
	Name: preload
	Namespace: namespace_f9df92f
	Checksum: 0x3AAA421
	Offset: 0x4E0
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function preload()
{
	clientfield::register("toplayer", "" + #"hash_12114abc7407913b", 24000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_5e38e846ce88405b", 24000, 1, "counter");
}

/*
	Name: main
	Namespace: namespace_f9df92f
	Checksum: 0x60C6CC25
	Offset: 0x570
	Size: 0x5AC
	Parameters: 0
	Flags: None
*/
function main()
{
	level flag::init(#"hash_50e35eeb800b7a13");
	level flag::init(#"trinket_round");
	level flag::init("ship_flinger_fixed");
	level flag::init("facility_flinger_fixed");
	level flag::init(#"hash_1e0f5a674141f03");
	level flag::init(#"edge_of_the_world_complete");
	namespace_ee206246::register(#"hash_12114abc7407913b", #"step_1", #"hash_5986bb2ab1879d84", &function_30ed45c9, &function_960f84d7);
	namespace_ee206246::register(#"hash_5e38e846ce88405b", #"step_1", #"hash_2572fbc6efde23a8", &function_48a634b7, &function_ee63b8a7);
	namespace_ee206246::register(#"hash_729a1e4eb041be9b", #"step_1", #"hash_1f2d771acb13cdad", &function_7635afee, &function_ad3e72f);
	namespace_ee206246::register(#"edge_of_the_world", #"step_1", #"hash_32fca8166d23c911", &function_6c61118a, &function_2980b28b);
	namespace_ee206246::register(#"edge_of_the_world", #"step_2", #"hash_32fca8166d23c911", &function_8bc27fd3, &security_balcony_time_);
	level.var_4ac8ef63 = getent("edge_flinger_spot", "targetname");
	level flag::init(#"hash_72bd35eacb1940de");
	level flag::init(#"hash_59d5ba61f4b8f405");
	namespace_ee206246::register(#"hash_66685502a7dee586", #"step_1", #"hash_66685502a7dee586", &function_a589e722, &function_239ae2e1);
	namespace_ee206246::register(#"hash_3e4c279707a5abe5", #"step_1", #"hash_3e4c279707a5abe5", &function_594f2c26, &function_5c6d5a0e);
	namespace_ee206246::start(#"hash_66685502a7dee586", !zm_utility::is_standard());
	namespace_ee206246::start(#"hash_3e4c279707a5abe5", !zm_utility::is_standard());
	level flag::init(#"hash_431a5026505d71aa");
	function_779045();
	if(zm_utility::function_e51dc2d8())
	{
		namespace_ee206246::start(#"edge_of_the_world");
		callback::on_spawned(&edge_watcher);
		level.var_5cfc800b = &function_fdc3c7c4;
	}
	level flag::wait_till(#"all_players_spawned");
	if(zm_utility::function_e51dc2d8())
	{
		namespace_ee206246::start(#"hash_12114abc7407913b");
		namespace_ee206246::start(#"hash_5e38e846ce88405b");
		namespace_ee206246::start(#"hash_729a1e4eb041be9b");
		level thread function_716974ba();
		level thread sq_glasses();
		level thread function_7836d215();
	}
}

/*
	Name: function_779045
	Namespace: namespace_f9df92f
	Checksum: 0xB96AE95E
	Offset: 0xB28
	Size: 0x1BA
	Parameters: 0
	Flags: None
*/
function function_779045()
{
	level.var_d2ed4be7 = array(#"zombie");
	level.var_f9ae8dab = getentarray("sq_trinket", "targetname");
	level.var_f9ae8dab = array::sort_by_script_int(level.var_f9ae8dab, 1);
	level.var_b4b3ecd1 = struct::get("sq_trinket_shrine", "targetname");
	level.var_b4b3ecd1.n_collected = 0;
	level.var_b4b3ecd1.var_f9ae8dab = getentarray("sq_trinket_placed", "targetname");
	level.var_b4b3ecd1.var_f9ae8dab = array::sort_by_script_int(level.var_b4b3ecd1.var_f9ae8dab, 1);
	foreach(var_4011ff2f in level.var_b4b3ecd1.var_f9ae8dab)
	{
		var_4011ff2f hide();
		var_4011ff2f.b_pickedup = 0;
		var_4011ff2f.b_placed = 0;
	}
}

/*
	Name: function_7635afee
	Namespace: namespace_f9df92f
	Checksum: 0x4B8F29D9
	Offset: 0xCF0
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_7635afee(var_a276c861)
{
	level.var_b4b3ecd1 zm_unitrigger::create("", 64);
	level.var_b4b3ecd1 thread function_abf8d5ce();
	foreach(var_4011ff2f in level.var_f9ae8dab)
	{
		var_4011ff2f zm_unitrigger::create("", 64);
		var_4011ff2f thread function_ef88a022();
	}
	level flag::wait_till(#"hash_50e35eeb800b7a13");
}

/*
	Name: function_ef88a022
	Namespace: namespace_f9df92f
	Checksum: 0x5B89EB42
	Offset: 0xE08
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_ef88a022()
{
	level endon(#"end_game", #"hash_9cfd45106ac760d", #"hash_198bc172b5af7f25", #"hash_50e35eeb800b7a13");
	self endon(#"death");
	var_4c0be1cb = undefined;
	foreach(pap in level.var_4d8e32c8)
	{
		if(pap.script_noteworthy === self.script_noteworthy)
		{
			var_4c0be1cb = pap;
			continue;
		}
	}
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		e_who = s_notify.e_who;
		if(var_4c0be1cb flag::get("Pack_A_Punch_on"))
		{
			level.var_b4b3ecd1.var_f9ae8dab[self.script_int].b_pickedup = 1;
			self playsound("zmb_trinket_pickup");
			e_who playrumbleonentity("zm_office_drawer_rumble");
			self hide();
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_abf8d5ce
	Namespace: namespace_f9df92f
	Checksum: 0x2D10EBA
	Offset: 0xFF8
	Size: 0x1A8
	Parameters: 0
	Flags: None
*/
function function_abf8d5ce()
{
	level endon(#"end_game", #"hash_9cfd45106ac760d", #"hash_50e35eeb800b7a13", #"hash_198bc172b5af7f25");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		e_who = s_notify.e_who;
		for(i = 0; i < self.var_f9ae8dab.size; i++)
		{
			if(self.var_f9ae8dab[i].b_pickedup === 1 && self.var_f9ae8dab[i].b_placed === 0)
			{
				self.var_f9ae8dab[i] show();
				self.var_f9ae8dab[i].b_placed = 1;
				self.n_collected++;
			}
			self.var_f9ae8dab[0] playsound("zmb_trinket_drop");
			e_who playrumbleonentity("zm_office_drawer_rumble");
		}
		if(self.n_collected >= 5)
		{
			level flag::set(#"hash_50e35eeb800b7a13");
		}
	}
}

/*
	Name: function_ad3e72f
	Namespace: namespace_f9df92f
	Checksum: 0x1B87A04F
	Offset: 0x11A8
	Size: 0x1DC
	Parameters: 2
	Flags: None
*/
function function_ad3e72f(var_a276c861, var_19e802fa)
{
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	if(var_a276c861)
	{
		foreach(var_4011ff2f in level.var_f9ae8dab)
		{
			var_4011ff2f hide();
		}
		foreach(var_4011ff2f in level.var_b4b3ecd1.var_f9ae8dab)
		{
			var_4011ff2f show();
			var_4011ff2f.b_pickedup = 1;
			var_4011ff2f.b_placed = 1;
		}
		level flag::set(#"hash_50e35eeb800b7a13");
	}
	function_a4e86068();
}

/*
	Name: function_a4e86068
	Namespace: namespace_f9df92f
	Checksum: 0x53013732
	Offset: 0x1390
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_a4e86068()
{
	var_d1ec2571 = level.round_number + 1;
	b_delayed = 0;
	do
	{
		if(0)
		{
			b_delayed = 1;
			wait(1);
		}
		else
		{
			var_d1ec2571 = level.round_number + 1;
			b_delayed = 0;
		}
	}
	while(b_delayed);
	var_898a45da = level.var_45827161[var_d1ec2571];
	if(isdefined(var_898a45da))
	{
		namespace_c3287616::function_43aed0ca(var_d1ec2571);
	}
	level.zombie_round_start_delay = 0;
	namespace_c3287616::function_b4a8f95a(#"zombie_electric", var_d1ec2571, &function_a092874, &function_a1b4b25d, &function_c83f59db, &function_5bfaa04, 0);
	if(namespace_c3287616::function_40229072(level.round_number) && !level flag::get("special_round"))
	{
		level waittill(#"special_round");
	}
	else if(!level flag::get("begin_spawning"))
	{
		level waittill(#"begin_spawning");
	}
	namespace_509a75d1::function_2ba419ee(0);
}

/*
	Name: function_a092874
	Namespace: namespace_f9df92f
	Checksum: 0xEFF91236
	Offset: 0x1558
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_a092874()
{
	level flag::set(#"trinket_round");
	if(level.round_number < 25)
	{
		level.var_1c921b2b = 29 - level.round_number;
	}
	else if(level.round_number < 60)
	{
		level.var_1c921b2b = 59 - level.round_number;
	}
	else
	{
		level.var_1c921b2b = 0;
	}
	level.var_c03f9529 = 1;
	callback::on_laststand(&function_500dfb49);
	namespace_c3287616::function_5bc2cea1(&namespace_c402654::function_ed67c5e7);
	level thread zm_audio::sndmusicsystem_playstate("dog_start");
}

/*
	Name: function_baf34b69
	Namespace: namespace_f9df92f
	Checksum: 0x23A38C27
	Offset: 0x1660
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function function_baf34b69()
{
	return 0;
}

/*
	Name: function_500dfb49
	Namespace: namespace_f9df92f
	Checksum: 0xC5653A59
	Offset: 0x1670
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_500dfb49()
{
	a_players = getplayers();
	if(a_players.size < 2)
	{
		level.var_c03f9529 = 0;
		namespace_509a75d1::function_2ba419ee();
	}
}

/*
	Name: function_a1b4b25d
	Namespace: namespace_f9df92f
	Checksum: 0x9CD97EBE
	Offset: 0x16C8
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function function_a1b4b25d(var_d25bbdd5)
{
	level flag::clear(#"trinket_round");
	level.var_1c921b2b = 0;
	if(isdefined(level.var_c03f9529) && level.var_c03f9529)
	{
		level thread function_8b0417eb();
	}
	callback::function_53888e7f(&function_500dfb49);
	namespace_c3287616::function_df803678(&namespace_c402654::function_ed67c5e7);
	level thread zm_audio::sndmusicsystem_playstate("dog_end");
	level.zombie_round_start_delay = undefined;
	wait(5);
}

/*
	Name: function_c83f59db
	Namespace: namespace_f9df92f
	Checksum: 0x4622672
	Offset: 0x17B0
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function function_c83f59db()
{
	a_e_players = getplayers();
	n_max = 10;
	switch(a_e_players.size)
	{
		case 1:
		{
			n_max = 60;
			break;
		}
		case 2:
		{
			n_max = 90;
			break;
		}
		case 3:
		case 4:
		{
			n_max = 120;
			break;
		}
	}
	return n_max;
}

/*
	Name: function_5bfaa04
	Namespace: namespace_f9df92f
	Checksum: 0xBA6806D1
	Offset: 0x1868
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_5bfaa04()
{
	n_time = namespace_a28acff3::get_zombie_spawn_delay(level.round_number + level.var_1c921b2b);
	wait(n_time);
}

/*
	Name: function_8b0417eb
	Namespace: namespace_f9df92f
	Checksum: 0x4C0A5C63
	Offset: 0x18B0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_8b0417eb()
{
	if(!zm_utility::is_standard())
	{
		drop_point = level.var_b4b3ecd1.origin - vectorscale((0, 0, 1), 20);
		level thread zm_powerups::specific_powerup_drop("free_perk", drop_point, undefined, 0.1, undefined, 1);
	}
}

/*
	Name: function_9e857126
	Namespace: namespace_f9df92f
	Checksum: 0x78DC8D3D
	Offset: 0x1930
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_9e857126(params)
{
	if(zombie_utility::get_current_zombie_count() == 1 && level.zombie_total == 0)
	{
		self thread function_8b0417eb();
	}
}

/*
	Name: sq_glasses
	Namespace: namespace_f9df92f
	Checksum: 0x5FDF7DDB
	Offset: 0x1988
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function sq_glasses()
{
	s_glasses = struct::get("sq_glasses", "targetname");
	s_glasses zm_unitrigger::create("", 32);
	s_glasses function_ea04cfd2();
}

/*
	Name: function_ea04cfd2
	Namespace: namespace_f9df92f
	Checksum: 0x686DFE9
	Offset: 0x19F8
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function function_ea04cfd2()
{
	level endon(#"end_game");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		player = s_notify.e_who;
		if(!(isdefined(player.var_456e7962) && player.var_456e7962))
		{
			player zm_score::add_to_player_score(500, 1, "bonus_points_powerup_shared");
			player.var_456e7962 = 1;
			player playsoundtoplayer(#"zmb_cha_ching", player);
			player thread namespace_3263198e::function_51b752a9("vox_romero_glasses", -1, 0, 0);
		}
	}
}

/*
	Name: function_a589e722
	Namespace: namespace_f9df92f
	Checksum: 0x4D69E78
	Offset: 0x1B00
	Size: 0x1C4
	Parameters: 1
	Flags: None
*/
function function_a589e722(var_5ea5c94d)
{
	level endon(#"end_game");
	if(!var_5ea5c94d)
	{
		level waittill(#"power_on2");
		var_3fae43ee = struct::get("sq_flinger_boat", "targetname");
		var_3fae43ee zm_unitrigger::create(&function_301c7dca);
		var_3fae43ee.b_picked_up = 0;
		var_3fae43ee function_a2993671();
		var_3fae43ee.b_picked_up = undefined;
		namespace_85e029d3::register_drop_off(13, #"hash_15b81856e839fed9", #"hash_eb543cd4ec82ae7", &function_bfb15d08);
		namespace_85e029d3::function_d83490c5(13);
		level waittill(#"hash_50e54529f8a671a1");
		namespace_85e029d3::function_3f9e02b8(5, #"hash_4ed14fd62a0c189c", #"hash_b9eef4c2cef38d0", &function_130c65ff);
		namespace_85e029d3::function_d83490c5(5);
		level waittill(#"hash_3cbe96c6150e208c");
		var_3fae43ee.b_picked_up = 1;
		var_3fae43ee.var_db053a52 = 1;
		var_3fae43ee function_1856c416();
	}
}

/*
	Name: function_239ae2e1
	Namespace: namespace_f9df92f
	Checksum: 0x6FC08572
	Offset: 0x1CD0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_239ae2e1(var_5ea5c94d, ended_early)
{
	level flag::set("ship_flinger_fixed");
}

/*
	Name: function_bfb15d08
	Namespace: namespace_f9df92f
	Checksum: 0x4B90D9A1
	Offset: 0x1D20
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function function_bfb15d08()
{
	namespace_6747c550::function_7df6bb60("flinger_gear_box_1", 0);
	namespace_85e029d3::function_b9e15919(1);
	level flag::set(#"hash_59d5ba61f4b8f405");
	wait(15);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level notify(#"hash_50e54529f8a671a1");
}

/*
	Name: function_130c65ff
	Namespace: namespace_f9df92f
	Checksum: 0x467772CD
	Offset: 0x1E18
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function function_130c65ff()
{
	namespace_6747c550::function_7df6bb60("flinger_gear_box_1", 2);
	level.pablo_npc.var_cb3ed98f[4].var_e7b75754 = #"";
	level notify(#"hash_3cbe96c6150e208c");
}

/*
	Name: function_301c7dca
	Namespace: namespace_f9df92f
	Checksum: 0x4C462605
	Offset: 0x1E88
	Size: 0x130
	Parameters: 1
	Flags: None
*/
function function_301c7dca(player)
{
	if(isdefined(self.stub.related_parent.b_picked_up) && self.stub.related_parent.b_picked_up)
	{
		str_hint = zm_utility::function_d6046228(#"hash_15b81856e839fed9", #"hash_eb543cd4ec82ae7");
		self sethintstring(str_hint);
		return 1;
	}
	if(isdefined(self.stub.related_parent.b_picked_up) && !self.stub.related_parent.b_picked_up)
	{
		str_hint = zm_utility::function_d6046228(#"hash_4ed14fd62a0c189c", #"hash_b9eef4c2cef38d0");
		self sethintstring(str_hint);
		return 1;
	}
	return 0;
}

/*
	Name: function_a2993671
	Namespace: namespace_f9df92f
	Checksum: 0x120F5B40
	Offset: 0x1FC8
	Size: 0x154
	Parameters: 0
	Flags: None
*/
function function_a2993671()
{
	s_notify = undefined;
	s_notify = self waittill(#"trigger_activated");
	player = s_notify.e_who;
	playsoundatposition(#"hash_20807cb66d31146e", self.origin);
	flinger = struct::get(self.target, "targetname");
	flinger namespace_6036de69::function_60325438(0);
	if(!level flag::get(#"hash_72bd35eacb1940de"))
	{
		level flag::set(#"hash_72bd35eacb1940de");
		player thread namespace_3263198e::function_51b752a9("vox_gear_box_pickup", -1, 0, 1);
		namespace_6747c550::function_7df6bb60("flinger_gear_box_1", 1);
	}
	else
	{
		namespace_6747c550::function_7df6bb60("flinger_gear_box_2", 1);
	}
}

/*
	Name: function_1856c416
	Namespace: namespace_f9df92f
	Checksum: 0x47403F73
	Offset: 0x2128
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function function_1856c416()
{
	s_notify = undefined;
	s_notify = self waittill(#"trigger_activated");
	player = s_notify.e_who;
	playsoundatposition(#"hash_30a5ec16dcd18c49", self.origin);
	flinger = struct::get(self.target, "targetname");
	flinger namespace_6036de69::function_60325438(1);
	player thread namespace_3263198e::function_51b752a9("vox_generic_responses_positive", -1, 0, 0);
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	if(self.var_db053a52 === 1)
	{
		namespace_6747c550::function_7df6bb60("flinger_gear_box_1", 0);
	}
	else
	{
		namespace_6747c550::function_7df6bb60("flinger_gear_box_2", 0);
	}
}

/*
	Name: function_594f2c26
	Namespace: namespace_f9df92f
	Checksum: 0xB77DAC30
	Offset: 0x2270
	Size: 0x1C4
	Parameters: 1
	Flags: None
*/
function function_594f2c26(var_5ea5c94d)
{
	level endon(#"end_game");
	if(!var_5ea5c94d)
	{
		level waittill(#"power_on3");
		var_3fae43ee = struct::get("sq_flinger_facility", "targetname");
		var_3fae43ee zm_unitrigger::create(&function_ab759b3a);
		var_3fae43ee.b_picked_up = 0;
		var_3fae43ee function_a2993671();
		var_3fae43ee.b_picked_up = undefined;
		namespace_85e029d3::register_drop_off(14, #"hash_494d7fc0d10e2ff6", #"hash_9af968cebf182d2", &function_b37bdeb4);
		namespace_85e029d3::function_d83490c5(14);
		level waittill(#"hash_3070e882982e5a46");
		namespace_85e029d3::function_3f9e02b8(4, #"hash_3b3769bc56dab413", #"hash_28eeceb083aa7339", &function_7619040c);
		namespace_85e029d3::function_d83490c5(4);
		level waittill(#"hash_3b6b392c9f59fe4b");
		var_3fae43ee.b_picked_up = 1;
		var_3fae43ee.var_cbf64bca = 1;
		var_3fae43ee function_1856c416();
	}
}

/*
	Name: function_5c6d5a0e
	Namespace: namespace_f9df92f
	Checksum: 0x8F48AB60
	Offset: 0x2440
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_5c6d5a0e(var_5ea5c94d, ended_early)
{
	level flag::set("facility_flinger_fixed");
}

/*
	Name: function_b37bdeb4
	Namespace: namespace_f9df92f
	Checksum: 0xBD938542
	Offset: 0x2490
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function function_b37bdeb4()
{
	namespace_6747c550::function_7df6bb60("flinger_gear_box_2", 0);
	namespace_85e029d3::function_b9e15919(1);
	level flag::set(#"hash_59d5ba61f4b8f405");
	wait(15);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	level notify(#"hash_3070e882982e5a46");
}

/*
	Name: function_7619040c
	Namespace: namespace_f9df92f
	Checksum: 0x47FD9080
	Offset: 0x2588
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function function_7619040c()
{
	namespace_6747c550::function_7df6bb60("flinger_gear_box_2", 2);
	level.pablo_npc.var_cb3ed98f[5].var_e7b75754 = #"";
	level notify(#"hash_3b6b392c9f59fe4b");
}

/*
	Name: function_ab759b3a
	Namespace: namespace_f9df92f
	Checksum: 0xE9273AD8
	Offset: 0x25F8
	Size: 0x118
	Parameters: 1
	Flags: None
*/
function function_ab759b3a(player)
{
	if(isdefined(self.stub.related_parent.b_picked_up) && self.stub.related_parent.b_picked_up)
	{
		self sethintstring(zm_utility::function_d6046228(#"hash_494d7fc0d10e2ff6", #"hash_9af968cebf182d2"));
		return 1;
	}
	if(isdefined(self.stub.related_parent.b_picked_up) && !self.stub.related_parent.b_picked_up)
	{
		self sethintstring(zm_utility::function_d6046228(#"hash_3b3769bc56dab413", #"hash_28eeceb083aa7339"));
		return 1;
	}
	return 0;
}

/*
	Name: function_716974ba
	Namespace: namespace_f9df92f
	Checksum: 0xE3CBF786
	Offset: 0x2720
	Size: 0x1FA
	Parameters: 0
	Flags: None
*/
function function_716974ba()
{
	var_c44262f6 = getentarray("cotd_weapon", "targetname");
	foreach(e_weapon in var_c44262f6)
	{
		unitrigger_stub = spawnstruct();
		unitrigger_stub.related_parent = e_weapon;
		unitrigger_stub.origin = e_weapon.origin;
		unitrigger_stub.angles = e_weapon.angles;
		unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
		unitrigger_stub.cursor_hint = "HINT_NOICON";
		unitrigger_stub.script_width = 64;
		unitrigger_stub.script_height = 64;
		unitrigger_stub.script_length = 64;
		unitrigger_stub.require_look_at = 0;
		unitrigger_stub.targetname = "cotd_unitrigger";
		unitrigger_stub.hint_string = undefined;
		unitrigger_stub.hint_parm1 = undefined;
		unitrigger_stub.hint_parm2 = undefined;
		unitrigger_stub.e_model = e_weapon;
		unitrigger_stub.e_model playloopsound(#"hash_13707a3a16b15f48");
		zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_6ad0e23f);
		e_weapon.unitrigger_stub = unitrigger_stub;
	}
	level.meteor_counter = 0;
}

/*
	Name: function_6ad0e23f
	Namespace: namespace_f9df92f
	Checksum: 0x468928D
	Offset: 0x2928
	Size: 0x25C
	Parameters: 0
	Flags: None
*/
function function_6ad0e23f()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	player = waitresult.activator;
	self.stub.e_model stoploopsound();
	self.stub.e_model playsound(#"hash_2c5f0a10ddf9dfa5");
	level.meteor_counter++;
	if(level.meteor_counter == 3)
	{
		if(level.musicsystem.currentplaytype < 4)
		{
			level thread zm_audio::sndmusicsystem_stopandflush();
			waitframe(1);
			level thread zm_audio::sndmusicsystem_playstate("ee_song_main");
		}
		/#
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
		#/
	}
	iprintlnbold(("" + level.meteor_counter) + "");
	println(("" + level.meteor_counter) + "");
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: on_player_connect
	Namespace: namespace_f9df92f
	Checksum: 0xAAAB5583
	Offset: 0x2B90
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function on_player_connect()
{
	if(zm_utility::is_trials() !== 1)
	{
		self thread function_dbb49281();
		self thread function_b6b24d3a();
	}
}

/*
	Name: function_30ed45c9
	Namespace: namespace_f9df92f
	Checksum: 0xEEF85C4B
	Offset: 0x2BE8
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_30ed45c9(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread function_dbb49281();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: function_dbb49281
	Namespace: namespace_f9df92f
	Checksum: 0xB5F853B3
	Offset: 0x2CA0
	Size: 0x258
	Parameters: 0
	Flags: None
*/
function function_dbb49281()
{
	self notify(#"hash_2ca5123c06ec42f0");
	self endon(#"disconnect", #"hash_2ca5123c06ec42f0");
	b_saw_the_wth = 0;
	var_616e76c5 = struct::get("sq_scare_lighthouse", "targetname");
	while(!b_saw_the_wth)
	{
		for(n_time = 0; self adsbuttonpressed() && n_time < 30; n_time++)
		{
			waitframe(1);
		}
		if(n_time >= 30 && self adsbuttonpressed() && (self zm_zonemgr::entity_in_zone("main_entrance") || self zm_zonemgr::entity_in_zone("outer_walkway") || self zm_zonemgr::entity_in_zone("loading_platform")) && is_weapon_sniper(self getcurrentweapon()) && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self))
		{
			self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
			self clientfield::increment_to_player("" + #"hash_12114abc7407913b", 1);
			for(j_time = 0; self adsbuttonpressed() && j_time < 5; j_time++)
			{
				waitframe(1);
			}
			b_saw_the_wth = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_960f84d7
	Namespace: namespace_f9df92f
	Checksum: 0x5BE2B2C7
	Offset: 0x2F00
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_960f84d7(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_48a634b7
	Namespace: namespace_f9df92f
	Checksum: 0xC1F52AB9
	Offset: 0x2F20
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_48a634b7(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread function_b6b24d3a();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: function_b6b24d3a
	Namespace: namespace_f9df92f
	Checksum: 0xD53955E5
	Offset: 0x2FD8
	Size: 0x256
	Parameters: 0
	Flags: None
*/
function function_b6b24d3a()
{
	self notify(#"hash_7bbb3fe051fd6c74");
	self endon(#"disconnect", #"hash_7bbb3fe051fd6c74");
	var_11dc5e9d = 144;
	b_saw_the_wth = 0;
	var_616e76c5 = struct::get("sq_scare_note", "targetname");
	while(!b_saw_the_wth)
	{
		for(n_time = 0; self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self) && distance(self.origin, var_616e76c5.origin) <= var_11dc5e9d && self getstance() === "crouch" && n_time < 30; n_time++)
		{
			waitframe(1);
		}
		if(n_time >= 30 && distance(self.origin, var_616e76c5.origin) <= var_11dc5e9d && self zm_zonemgr::entity_in_zone("forecastle") && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self) && self getstance() === "crouch")
		{
			self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
			self clientfield::increment_to_player("" + #"hash_5e38e846ce88405b", 1);
			b_saw_the_wth = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_ee63b8a7
	Namespace: namespace_f9df92f
	Checksum: 0xCFA62728
	Offset: 0x3238
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_ee63b8a7(var_a276c861, var_19e802fa)
{
}

/*
	Name: is_weapon_sniper
	Namespace: namespace_f9df92f
	Checksum: 0xE2A16373
	Offset: 0x3258
	Size: 0xF8
	Parameters: 1
	Flags: Private
*/
private function is_weapon_sniper(w_weapon)
{
	if(isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon || w_weapon.name === #"ww_tesla_sniper_t8" || w_weapon.name === #"ww_tesla_sniper_upgraded_t8")
	{
		if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is"))
		{
			return 0;
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_6c61118a
	Namespace: namespace_f9df92f
	Checksum: 0xE7268629
	Offset: 0x3358
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_6c61118a(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_1e0f5a674141f03");
	}
}

/*
	Name: function_2980b28b
	Namespace: namespace_f9df92f
	Checksum: 0x21112B9C
	Offset: 0x3398
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function function_2980b28b(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		s_pos = struct::get("ee_edge_teleport", "targetname");
		a_e_players = getplayers();
		a_e_players[0] setorigin(s_pos.origin);
		a_e_players[0] setplayerangles(s_pos.angles);
	}
}

/*
	Name: edge_watcher
	Namespace: namespace_f9df92f
	Checksum: 0x49F3C2B7
	Offset: 0x3458
	Size: 0x1E6
	Parameters: 0
	Flags: None
*/
function edge_watcher()
{
	level endon(#"end_game");
	self endon(#"death");
	level flag::wait_till("facility_flinger_fixed");
	while(!level flag::get(#"hash_1e0f5a674141f03"))
	{
		if(self istouching(level.var_4ac8ef63) && (!(isdefined(level.var_4ac8ef63.b_claimed) && level.var_4ac8ef63.b_claimed)))
		{
			level.var_4ac8ef63.b_claimed = 1;
			wait(0.5);
			self thread function_bc1ff036();
			while(self istouching(level.var_4ac8ef63))
			{
				var_68460903 = self getnormalizedcameramovement();
				/#
				#/
				if(abs(var_68460903[1]) < 0.9 || self getstance() != "crouch")
				{
					level.var_4ac8ef63.b_claimed = 0;
					wait(3);
					self thread edge_watcher();
					return;
				}
				waitframe(1);
			}
			level.var_4ac8ef63.b_claimed = 0;
			wait(3);
		}
		waitframe(1);
	}
}

/*
	Name: function_bc1ff036
	Namespace: namespace_f9df92f
	Checksum: 0xC4F94F97
	Offset: 0x3648
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function function_bc1ff036()
{
	level endon(#"end_game");
	self endon(#"death");
	wait(2.4);
	if(level.var_4ac8ef63.b_claimed)
	{
		self.var_e5340f3e = 1;
	}
}

/*
	Name: function_8bc27fd3
	Namespace: namespace_f9df92f
	Checksum: 0x66CA2272
	Offset: 0x36B0
	Size: 0x188
	Parameters: 1
	Flags: None
*/
function function_8bc27fd3(var_5ea5c94d)
{
	level endon(#"end_game", #"hash_9cfd45106ac760d", #"hash_198bc172b5af7f25");
	if(!var_5ea5c94d)
	{
		if(getplayers().size == 1)
		{
			namespace_509a75d1::function_314447b(1, 0);
		}
		var_67dae760 = getent("edge_of_the_world", "targetname");
		while(true)
		{
			foreach(player in getplayers())
			{
				if(player istouching(var_67dae760))
				{
					level.var_dc2e3646 = player;
					level notify(#"hash_21d844f0069092bd");
					level.var_dc2e3646 thread edge_exit_watcher();
					return;
				}
			}
			wait(1);
		}
	}
}

/*
	Name: security_balcony_time_
	Namespace: namespace_f9df92f
	Checksum: 0xB8AD3090
	Offset: 0x3840
	Size: 0xD0
	Parameters: 2
	Flags: None
*/
function security_balcony_time_(var_5ea5c94d, ended_early)
{
	level flag::set(#"edge_of_the_world_complete");
	s_exit = struct::get("edge_exit", "targetname");
	player = s_exit zm_unitrigger::function_fac87205(zm_utility::function_d6046228(#"hash_2f168c7542029caa", #"hash_71bb91d3e3e956ee"));
	player notify(#"edge_exit", var_5ea5c94d || ended_early);
}

/*
	Name: function_1b0e51b5
	Namespace: namespace_f9df92f
	Checksum: 0x93613528
	Offset: 0x3918
	Size: 0x194
	Parameters: 0
	Flags: None
*/
function function_1b0e51b5()
{
	level endon(#"end_game", #"hash_21d844f0069092bd");
	edge_life_brush = getent("edge_life_brush", "targetname");
	s_notify = undefined;
	s_notify = self waittill_timeout(160, #"entering_last_stand");
	if(isalive(self) && (self zm_zonemgr::is_player_in_zone(array("edge")) || self istouching(edge_life_brush)))
	{
		if(self isusingoffhand())
		{
			self forceoffhandend();
		}
		self notify(#"hash_53bfad7081c69dee");
		self zm_bgb_anywhere_but_here::activation(0);
		if(getplayers().size == 1)
		{
			namespace_509a75d1::function_314447b(0);
		}
		self.var_cdce7ec = 0;
		self val::reset(#"edge_of_the_world", "ignoreme");
	}
}

/*
	Name: edge_exit_watcher
	Namespace: namespace_f9df92f
	Checksum: 0x86D1EEB1
	Offset: 0x3AB8
	Size: 0x1D4
	Parameters: 0
	Flags: None
*/
function edge_exit_watcher()
{
	level endon(#"end_game");
	edge_life_brush = getent("edge_life_brush", "targetname");
	s_notify = undefined;
	s_notify = self waittill_timeout(120, #"entering_last_stand", #"edge_exit");
	if(isalive(self) && (self zm_zonemgr::is_player_in_zone(array("edge")) || self istouching(edge_life_brush)))
	{
		self thread lui::screen_flash(3, 1, 0.5, 1, "white");
		wait(3.5);
		if(self isusingoffhand())
		{
			self forceoffhandend();
		}
		self notify(#"hash_53bfad7081c69dee");
		self zm_bgb_anywhere_but_here::activation(0);
		if(getplayers().size == 1)
		{
			namespace_509a75d1::function_314447b(0);
		}
		self.var_cdce7ec = 0;
		self val::reset(#"edge_of_the_world", "ignoreme");
	}
}

/*
	Name: function_fdc3c7c4
	Namespace: namespace_f9df92f
	Checksum: 0xE4477DFD
	Offset: 0x3C98
	Size: 0x222
	Parameters: 0
	Flags: None
*/
function function_fdc3c7c4()
{
	var_fded3d81 = [];
	foreach(player in level.activeplayers)
	{
		if(namespace_770fd0f5::is_valid_target(player) && (!(isdefined(player.var_cdce7ec) && player.var_cdce7ec)))
		{
			if(!isdefined(var_fded3d81))
			{
				var_fded3d81 = [];
			}
			else if(!isarray(var_fded3d81))
			{
				var_fded3d81 = array(var_fded3d81);
			}
			var_fded3d81[var_fded3d81.size] = player;
		}
	}
	if(var_fded3d81.size)
	{
		arraysortclosest(var_fded3d81, self.origin);
		var_fded3d81 = array::reverse(var_fded3d81);
	}
	else if(!isdefined(var_fded3d81))
	{
		var_fded3d81 = [];
	}
	else if(!isarray(var_fded3d81))
	{
		var_fded3d81 = array(var_fded3d81);
	}
	var_fded3d81[var_fded3d81.size] = self;
	foreach(player in var_fded3d81)
	{
		s_player_respawn = self namespace_770fd0f5::get_best_spawnpoint(player);
		if(isdefined(s_player_respawn))
		{
			return s_player_respawn;
		}
	}
	return undefined;
}

/*
	Name: function_7836d215
	Namespace: namespace_f9df92f
	Checksum: 0x464015F
	Offset: 0x3EC8
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_7836d215()
{
	s_location = struct::spawn((-528, 1196, 320));
	s_unitrigger = s_location zm_unitrigger::create("", 32);
	s_location thread function_cabcfdd2();
	waitresult = level flag::wait_till_any(array(#"hash_778a2b8282d704f", #"hash_431a5026505d71aa"));
	if(waitresult._notify === #"hash_431a5026505d71aa")
	{
		if(level.musicsystem.currentplaytype < 4)
		{
			level thread zm_audio::sndmusicsystem_stopandflush();
			waitframe(1);
			level thread zm_audio::sndmusicsystem_playstate("ee_song_2");
		}
	}
	s_location zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_cabcfdd2
	Namespace: namespace_f9df92f
	Checksum: 0x706364E1
	Offset: 0x4018
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function function_cabcfdd2()
{
	level endon(#"hash_778a2b8282d704f");
	level endon(#"hash_431a5026505d71aa");
	var_b3ee22cc = 0;
	while(true)
	{
		self waittill(#"trigger_activated");
		var_b3ee22cc++;
		playsoundatposition(#"hash_71d9e237e73ab437", self.origin);
		wait(0.5);
		if(var_b3ee22cc >= 3)
		{
			playsoundatposition(#"hash_4d9caefa6e6dd2e7", self.origin);
			wait(3);
			level flag::set(#"hash_431a5026505d71aa");
		}
	}
}

