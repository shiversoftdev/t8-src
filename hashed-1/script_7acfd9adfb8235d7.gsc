// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_5bb072c3abf4652c;
#using script_61a734c95edc17aa;
#using script_6b221588ece2c4aa;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_79c9122f9058e8ba;
#using script_8988fdbc78d6c53;
#using script_b52a163973f339f;
#using script_b761c44ab2e5b46;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion_pap_quest.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_bfa7c2ed;

/*
	Name: init
	Namespace: namespace_bfa7c2ed
	Checksum: 0xB0094993
	Offset: 0x3F8
	Size: 0x3A4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "" + #"hash_2d18ba139fbb02f", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_7ce5699ea3eb9099", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4d45dc65a8307183", 8000, 1, "counter");
	clientfield::register("actor", "" + #"hash_5a88903973664de5", 8000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_3d7d4c5e6ed616e9", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_338e6c710a21b0c", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3d5a64bed5e39d24", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_73123721764d7374", 8000, 1, "int");
	level.var_e93e5852 = 0;
	level.var_3891e803 = getweapon(#"hash_25f355b5d35b8488");
	zm_weapons::include_zombie_weapon(#"hash_25f355b5d35b8488", 0);
	zm_weapons::add_zombie_weapon(#"hash_25f355b5d35b8488", "", 0, 0, undefined, undefined, 0, "", "special", 0, undefined, 0);
	weaponobjects::function_e6400478(#"hash_25f355b5d35b8488", &createspecialcrossbowwatchertypes, 1);
	callback::on_ai_damage(&function_615d8c38);
	function_c739f755();
	init_flags();
	function_c6e2a4fd();
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4") && namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") != 2)
	{
		namespace_ee206246::start(#"hash_4e21e987e2c0592d", 1);
	}
}

/*
	Name: function_c739f755
	Namespace: namespace_bfa7c2ed
	Checksum: 0xDBBC2A32
	Offset: 0x7A8
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	namespace_ee206246::register(#"hash_4e21e987e2c0592d", #"step_1", #"hash_66fb6a37bb95210e", &function_cdfe68a2, &function_c5868f47);
	namespace_ee206246::register(#"hash_4e21e987e2c0592d", #"step_2", #"hash_66fb6937bb951f5b", &function_a03f8d25, &function_f05be4f1);
	namespace_ee206246::register(#"hash_4e21e987e2c0592d", #"step_3", #"hash_66fb6837bb951da8", &function_aa79a199, &function_bafa7a2b);
	namespace_ee206246::register(#"hash_4e21e987e2c0592d", #"step_4", #"hash_66fb6f37bb95298d", &function_86e35a69, &function_a93d56b1);
	namespace_ee206246::register(#"hash_4e21e987e2c0592d", #"step_5", #"hash_66fb6e37bb9527da", &function_e35c1359, &function_de9a416a);
}

/*
	Name: init_flags
	Namespace: namespace_bfa7c2ed
	Checksum: 0xEA4FF13C
	Offset: 0x998
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_67e415588696c592");
	level flag::init(#"hash_67e416588696c745");
	level flag::init(#"hash_67e413588696c22c");
	level flag::init(#"hash_67e414588696c3df");
	level flag::init(#"hash_1687323c95faf914");
	level flag::init(#"hash_1687333c95fafac7");
	level flag::init(#"hash_1687343c95fafc7a");
	level flag::init(#"hash_1687353c95fafe2d");
	level flag::init(#"hash_54326b9f13bd4f1");
	level flag::init(#"hash_2e0f59cef233a264");
	level flag::init(#"hash_864c8ec1475abdc");
	level flag::init(#"hash_61263135b6fb6340");
	level flag::init(#"hash_38fe2a57d5f9d6ba");
	level flag::init(#"hash_f3875ca909e696f");
}

/*
	Name: function_c6e2a4fd
	Namespace: namespace_bfa7c2ed
	Checksum: 0x3BAE7147
	Offset: 0xB68
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_c6e2a4fd()
{
	array::thread_all(struct::get_array("s_burn"), &function_edb1add2);
	level thread function_355450a4();
}

/*
	Name: function_355450a4
	Namespace: namespace_bfa7c2ed
	Checksum: 0x11FB2323
	Offset: 0xBC8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_355450a4()
{
	level flag::wait_till("all_players_spawned");
	scene::init("p8_fxanim_zm_man_crypt_bundle");
	exploder::exploder_stop("exp_lgt_crypt_normal");
	exploder::exploder_stop("exp_lgt_crypt_darker");
}

/*
	Name: function_edb1add2
	Namespace: namespace_bfa7c2ed
	Checksum: 0x2EFEF39E
	Offset: 0xC40
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_edb1add2()
{
	level flag::wait_till("all_players_spawned");
	self.var_ce3d3ff6 = util::spawn_model(self.model, self.origin, self.angles);
	util::wait_network_frame();
	self.var_ce3d3ff6 clientfield::set("" + #"hash_2d18ba139fbb02f", 1);
	self.var_ce3d3ff6 setcandamage(1);
	self.var_ce3d3ff6.health = 10000;
	self thread function_d84548e7();
}

/*
	Name: function_cdfe68a2
	Namespace: namespace_bfa7c2ed
	Checksum: 0xEA4814FE
	Offset: 0xD30
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_cdfe68a2(var_a276c861)
{
	if(!var_a276c861)
	{
		while(level.var_e93e5852 < 6)
		{
			wait(1);
		}
		level flag::wait_till("open_pap");
	}
}

/*
	Name: function_c5868f47
	Namespace: namespace_bfa7c2ed
	Checksum: 0xA5A16CE9
	Offset: 0xD88
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_c5868f47(var_5ea5c94d, ended_early)
{
	a_s_candles = struct::get_array("s_burn");
	foreach(s_candle in a_s_candles)
	{
		s_candle.var_ce3d3ff6 clientfield::set("" + #"hash_2d18ba139fbb02f", 0);
	}
	level notify(#"hash_785f94bb8c05dc05");
}

/*
	Name: function_a03f8d25
	Namespace: namespace_bfa7c2ed
	Checksum: 0xF857BE6A
	Offset: 0xE70
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_a03f8d25(var_a276c861)
{
	if(!var_a276c861)
	{
		s_monolith = struct::get("s_monolith");
		s_monolith.var_f4ecfb70 = util::spawn_model("tag_origin", s_monolith.origin, s_monolith.angles);
		util::wait_network_frame();
		s_monolith.var_f4ecfb70 clientfield::set("" + #"hash_7ce5699ea3eb9099", 1);
		var_47323b73 = s_monolith zm_unitrigger::create(undefined, 64, &function_9a99a7b8, 1, 1);
		var_a6356bbe = array::random(struct::get_array("s_monolith_ghost"));
		s_monolith thread function_d17deac0(var_a6356bbe);
		level flag::wait_till(#"hash_f3875ca909e696f");
		zm_unitrigger::unregister_unitrigger(var_47323b73);
	}
}

/*
	Name: function_f05be4f1
	Namespace: namespace_bfa7c2ed
	Checksum: 0xAF3C6F81
	Offset: 0xFF8
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function function_f05be4f1(var_5ea5c94d, ended_early)
{
	level notify(#"hash_3e6c62c9a38d67de");
	level flag::set(#"hash_f3875ca909e696f");
	s_monolith = struct::get("s_monolith");
	if(isdefined(s_monolith.var_f4ecfb70))
	{
		s_monolith.var_f4ecfb70 clientfield::set("" + #"hash_7ce5699ea3eb9099", 0);
	}
	if(isdefined(level.var_a91e1dd1) && isdefined(level.var_a91e1dd1.var_c176969a))
	{
		level.var_a91e1dd1.var_c176969a thread scene::stop();
		level.var_a91e1dd1 thread scene::stop();
		level.var_a91e1dd1.var_c176969a notify(#"reached_end_node");
		level.var_a91e1dd1.var_c176969a delete();
	}
	wait(3);
	if(isdefined(s_monolith.var_f4ecfb70))
	{
		s_monolith.var_f4ecfb70 delete();
	}
}

/*
	Name: function_aa79a199
	Namespace: namespace_bfa7c2ed
	Checksum: 0x603BD3FE
	Offset: 0x1190
	Size: 0x684
	Parameters: 1
	Flags: Linked
*/
function function_aa79a199(var_a276c861)
{
	if(!var_a276c861)
	{
		var_37ed2a9b = struct::get("s_possess");
		if(isdefined(level.var_a91e1dd1))
		{
			n_time = function_c5a4ae6(level.var_a91e1dd1.origin, var_37ed2a9b.origin);
			level.var_a91e1dd1.var_dafa2b89 = util::spawn_model("tag_origin", level.var_a91e1dd1.origin, level.var_a91e1dd1.angles);
			util::wait_network_frame();
			level.var_a91e1dd1 linkto(level.var_a91e1dd1.var_dafa2b89);
			if(n_time > 1 && n_time < 10)
			{
				level.var_a91e1dd1.var_dafa2b89 moveto(var_37ed2a9b.origin, n_time);
				level.var_a91e1dd1.var_dafa2b89 rotateto(var_37ed2a9b.angles, n_time);
				level.var_a91e1dd1 setvisibletoall();
				level.var_a91e1dd1.mdl_head setvisibletoall();
				level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_d278eff0ca38301", level.var_a91e1dd1);
				level.var_a91e1dd1 thread scene::play(#"hash_d278eff0ca38301", level.var_a91e1dd1.mdl_head);
				level.var_a91e1dd1.var_dafa2b89 waittill(#"movedone");
				level.var_a91e1dd1.var_dafa2b89 thread scene::stop();
				level.var_a91e1dd1 thread scene::stop();
				level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1);
				level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
			}
			else
			{
				level.var_a91e1dd1.var_dafa2b89.origin = var_37ed2a9b.origin;
				level.var_a91e1dd1.var_dafa2b89.angles = var_37ed2a9b.angles;
				level.var_a91e1dd1 setvisibletoall();
				level.var_a91e1dd1.mdl_head setvisibletoall();
				level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1);
				level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
			}
		}
		else
		{
			level.var_a91e1dd1 = util::spawn_model("tag_origin", var_37ed2a9b.origin, var_37ed2a9b.angles);
			level.var_a91e1dd1.var_dafa2b89 = util::spawn_model("tag_origin", var_37ed2a9b.origin, var_37ed2a9b.angles);
			level.var_a91e1dd1 setmodel(#"c_t8_zmb_dlc1_catherine_ghost_body");
			level.var_a91e1dd1.mdl_head = util::spawn_model(#"c_t8_zmb_dlc1_catherine_ghost_head", level.var_a91e1dd1.origin, level.var_a91e1dd1.angles);
			util::wait_network_frame();
			level.var_a91e1dd1 linkto(level.var_a91e1dd1.var_dafa2b89);
			level.var_a91e1dd1.mdl_head linkto(level.var_a91e1dd1);
			level.var_a91e1dd1 thread namespace_b8f22955::function_c9c7a593();
			level.var_a91e1dd1 clientfield::set("" + #"ghost_trail", 1);
			util::wait_network_frame();
			level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1);
			level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
		}
		var_37ed2a9b thread function_9ee098d5();
		level flag::wait_till_all(array(#"hash_67e415588696c592", #"hash_67e416588696c745", #"hash_67e413588696c22c", #"hash_67e414588696c3df"));
	}
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_bfa7c2ed
	Checksum: 0x99B5CC6E
	Offset: 0x1820
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_bafa7a2b(var_5ea5c94d, ended_early)
{
	level notify(#"hash_aa10db1b6143db9");
	if(isdefined(level.var_a91e1dd1) && isdefined(level.var_a91e1dd1.mdl_head))
	{
		level.var_a91e1dd1.var_dafa2b89 scene::stop();
		level.var_a91e1dd1 scene::stop();
		level.var_a91e1dd1.mdl_head delete();
		level.var_a91e1dd1 delete();
	}
}

/*
	Name: function_86e35a69
	Namespace: namespace_bfa7c2ed
	Checksum: 0x688362A8
	Offset: 0x18F0
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_86e35a69(var_a276c861)
{
	if(!var_a276c861)
	{
		var_1c3e934b = struct::get("s_imp_enter");
		array::thread_all(struct::get_array("s_imp_symbol"), &function_e7423237);
		level flag::wait_till_all(array(#"hash_1687323c95faf914", #"hash_1687333c95fafac7", #"hash_1687343c95fafc7a", #"hash_1687353c95fafe2d"));
		level thread function_9768c04b();
		var_1c3e934b zm_unitrigger::create(undefined, 64, &function_d7d6b759, 1, 1);
		level flag::wait_till(#"hash_54326b9f13bd4f1");
	}
}

/*
	Name: function_a93d56b1
	Namespace: namespace_bfa7c2ed
	Checksum: 0x492F67F9
	Offset: 0x1A30
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_a93d56b1(var_5ea5c94d, ended_early)
{
	level notify(#"hash_1c676c7286de913a");
	callback::remove_on_ai_killed(&function_58251713);
}

/*
	Name: function_e35c1359
	Namespace: namespace_bfa7c2ed
	Checksum: 0xEBA4B1EF
	Offset: 0x1A88
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_e35c1359(var_a276c861)
{
	level thread function_886c88e();
	level thread function_b9289f93();
	if(!var_a276c861)
	{
		level flag::wait_till(#"hash_38fe2a57d5f9d6ba");
	}
}

/*
	Name: function_de9a416a
	Namespace: namespace_bfa7c2ed
	Checksum: 0x420D79A6
	Offset: 0x1AF8
	Size: 0x1B8
	Parameters: 2
	Flags: Linked
*/
function function_de9a416a(var_5ea5c94d, ended_early)
{
	level notify(#"hash_69c33933b1ab3e2b");
	level flag::set(#"hash_61263135b6fb6340");
	zm_weapons::function_603af7a8(level.var_3891e803);
	level thread namespace_c05f06c7::function_f1c106b("loc1", 0);
	exploder::exploder_stop("fxexp_barrier_gameplay_crypt");
	level flag::set(#"spawn_zombies");
	level flag::clear(#"pause_round_timeout");
	exploder::exploder_stop("exp_lgt_crypt_darker");
	exploder::exploder("exp_lgt_crypt_normal");
	namespace_c05f06c7::function_5904a8e1();
	var_14d5aa56 = getentarray("imp_floor_symbols", "script_noteworthy");
	foreach(var_9e7c3935 in var_14d5aa56)
	{
		var_9e7c3935 delete();
	}
}

/*
	Name: function_d84548e7
	Namespace: namespace_bfa7c2ed
	Checksum: 0x89883D0B
	Offset: 0x1CB8
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_d84548e7()
{
	level endon(#"hash_785f94bb8c05dc05");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self.var_ce3d3ff6 waittill(#"damage");
		if(var_385703b7.mod === "MOD_MELEE")
		{
			self.var_ce3d3ff6 clientfield::set("" + #"hash_2d18ba139fbb02f", 0);
			level.var_e93e5852++;
			break;
		}
	}
}

/*
	Name: function_9a99a7b8
	Namespace: namespace_bfa7c2ed
	Checksum: 0xF9BD1445
	Offset: 0x1D68
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_9a99a7b8()
{
	level endon(#"hash_3e6c62c9a38d67de");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player) && (!(isdefined(e_player.b_is_designated_target) && e_player.b_is_designated_target)) && function_89d75db(e_player) && (!(isdefined(e_player function_32606f19()) && e_player function_32606f19())))
		{
			e_player thread function_c929af49();
		}
	}
}

/*
	Name: function_32606f19
	Namespace: namespace_bfa7c2ed
	Checksum: 0xD4B6CB8F
	Offset: 0x1E70
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_32606f19()
{
	if(isdefined(self.bgb) && self.bgb != #"none")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_89d75db
	Namespace: namespace_bfa7c2ed
	Checksum: 0x24765585
	Offset: 0x1EB0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_89d75db(e_player)
{
	if(zm_utility::function_3bff983f())
	{
		if(isdefined(e_player.b_is_designated_target) && e_player.b_is_designated_target)
		{
			return 0;
		}
		return 1;
	}
	if(!(isdefined(level.is_forever_solo_game) && level.is_forever_solo_game) && isdefined(e_player.var_34b7151c) && e_player.var_34b7151c == level.round_number)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c929af49
	Namespace: namespace_bfa7c2ed
	Checksum: 0xCAE9DC8
	Offset: 0x1F68
	Size: 0x26E
	Parameters: 0
	Flags: Linked
*/
function function_c929af49()
{
	self endon(#"disconnect");
	self notify(#"bgb_update");
	self.var_2c195483 = 1;
	self.b_is_designated_target = 1;
	self.var_34b7151c = level.round_number;
	self thread function_9950740f();
	self playsound(#"zmb_bgb_nysm_start");
	self playloopsound(#"zmb_bgb_nysm_loop", 1);
	self util::delay(0.75, "death", &zm_audio::create_and_play_dialog, #"hash_fd153016f33c413", #"hash_78479df80c69cfa4");
	self clientfield::set_to_player("" + #"hash_3d7d4c5e6ed616e9", 1);
	if(isdefined(level.is_forever_solo_game) && level.is_forever_solo_game)
	{
		n_duration = 120;
	}
	else
	{
		n_duration = 60;
	}
	self.var_ea6941e2 = gettime() + int(n_duration * 1000);
	self waittill_timeout(0.5 + n_duration, #"hash_115d2cc01ac8b1e9", #"end_game", #"bgb_update");
	self stoploopsound(1);
	self playsound(#"zmb_bgb_nysm_end");
	self clientfield::set_to_player("" + #"hash_3d7d4c5e6ed616e9", 0);
	self.b_is_designated_target = 0;
	self.var_2c195483 = 0;
	self notify(#"hash_398b46ae1d545804");
}

/*
	Name: function_92e77dc6
	Namespace: namespace_bfa7c2ed
	Checksum: 0x89EE4B3C
	Offset: 0x21E0
	Size: 0x21E
	Parameters: 0
	Flags: Linked
*/
function function_92e77dc6()
{
	level endon(#"hash_3e6c62c9a38d67de");
	level.var_a91e1dd1.mdl_head endon(#"death");
	level.var_a91e1dd1 endon(#"death");
	self endon(#"disconnect");
	level.var_a91e1dd1 setinvisibletoplayer(self);
	level.var_a91e1dd1.mdl_head setinvisibletoplayer(self);
	while(true)
	{
		if(isdefined(self.b_is_designated_target) && self.b_is_designated_target && !isdefined(level.var_8491c913) && (!(isdefined(self.var_22514848) && self.var_22514848)))
		{
			self.var_22514848 = 1;
			level.var_a91e1dd1 setvisibletoplayer(self);
			level.var_a91e1dd1.mdl_head setvisibletoplayer(self);
			level.var_a91e1dd1 thread namespace_b8f22955::function_c9c7a593();
		}
		else if(!(isdefined(self.b_is_designated_target) && self.b_is_designated_target) && (isdefined(self.var_22514848) && self.var_22514848) || isdefined(level.var_8491c913))
		{
			self.var_22514848 = 0;
			level.var_a91e1dd1 setinvisibletoplayer(self);
			level.var_a91e1dd1.mdl_head setinvisibletoplayer(self);
			level.var_a91e1dd1 notify(#"hash_6edff0409a51550e");
		}
		waitframe(1);
	}
}

/*
	Name: function_9950740f
	Namespace: namespace_bfa7c2ed
	Checksum: 0x90721B9B
	Offset: 0x2408
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_9950740f()
{
	self notify(#"hash_398b46ae1d545804");
	self endon(#"disconnect", #"hash_398b46ae1d545804");
	self waittill(#"bled_out", #"fake_death");
	self notify(#"hash_115d2cc01ac8b1e9");
}

/*
	Name: function_d17deac0
	Namespace: namespace_bfa7c2ed
	Checksum: 0xF20FBEC
	Offset: 0x2480
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_d17deac0(var_a6356bbe)
{
	level endon(#"hash_3e6c62c9a38d67de");
	nd_start = getvehiclenode(var_a6356bbe.target, "targetname");
	level.var_a91e1dd1 = util::spawn_model("tag_origin", var_a6356bbe.origin, var_a6356bbe.angles);
	util::wait_network_frame();
	level.var_a91e1dd1 thread function_a6978e42(nd_start);
}

/*
	Name: function_a6978e42
	Namespace: namespace_bfa7c2ed
	Checksum: 0xE7764479
	Offset: 0x2548
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function function_a6978e42(nd_start)
{
	level endon(#"hash_3e6c62c9a38d67de");
	self setmodel(#"c_t8_zmb_dlc1_catherine_ghost_body");
	self.mdl_head = util::spawn_model(#"c_t8_zmb_dlc1_catherine_ghost_head", self.origin, self.angles);
	self.mdl_head linkto(self);
	util::wait_network_frame();
	self clientfield::set("" + #"ghost_trail", 1);
	array::thread_all(getplayers(), &function_92e77dc6);
	self.var_c176969a = spawner::simple_spawn_single(getent("veh_power_on_projectile", "targetname"));
	self.var_c176969a.team = #"allies";
	self.var_c176969a.var_6353e3f1 = 1;
	self.var_c176969a.origin = nd_start.origin;
	self.var_c176969a.angles = nd_start.angles;
	self linkto(self.var_c176969a);
	var_878f0f0a = getallvehiclenodes();
	self thread function_4802a272();
	self thread namespace_b8f22955::function_900b7dca(var_878f0f0a, 1);
	self.var_c176969a vehicle::get_on_and_go_path(nd_start);
	self.var_c176969a thread scene::stop();
	self thread scene::stop();
	while(isdefined(level.var_8491c913))
	{
		wait(1);
	}
	level flag::set(#"hash_f3875ca909e696f");
}

/*
	Name: function_4802a272
	Namespace: namespace_bfa7c2ed
	Checksum: 0xC82066BF
	Offset: 0x27E8
	Size: 0x55C
	Parameters: 0
	Flags: Linked
*/
function function_4802a272()
{
	level endon(#"hash_3e6c62c9a38d67de");
	self endon(#"death");
	/#
		sphere(self.origin, 64, (1, 1, 1), 1, 0, 16, 5000);
	#/
	do
	{
		var_80296afc = self function_4a51430a(160, 1);
		waitframe(1);
	}
	while(!isalive(var_80296afc));
	n_player_index = var_80296afc namespace_48f3568::function_d35e4c92();
	switch(n_player_index)
	{
		case 10:
		{
			var_5e246f88 = #"hash_56bcb3a8b0feb0ac";
			var_bfe15d00 = #"hash_4b8b51645e23b3d3";
			break;
		}
		case 12:
		{
			var_5e246f88 = #"hash_1da4031734c7836f";
			var_bfe15d00 = #"hash_5cb53f6467d09e7d";
			break;
		}
		case 11:
		{
			var_5e246f88 = #"hash_65f76254230c2099";
			var_bfe15d00 = #"hash_52da086461e4f9c8";
			break;
		}
		case 9:
		{
			var_5e246f88 = #"hash_5ddb037cae2d16db";
			var_bfe15d00 = #"hash_472fcbf532d22583";
			break;
		}
		default:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
	if(isdefined(var_5e246f88) && isdefined(var_bfe15d00) && var_80296afc function_188bb878(var_bfe15d00))
	{
		var_80296afc namespace_891c9bac::function_8e0f4696(var_bfe15d00, 0, 1, 9999);
		self function_79556c43(var_80296afc, var_5e246f88);
	}
	level flag::wait_till("impaler_halfway");
	do
	{
		var_80296afc = self function_4a51430a();
		waitframe(1);
	}
	while(!isalive(var_80296afc));
	n_player_index = var_80296afc namespace_48f3568::function_d35e4c92();
	var_5e246f88 = undefined;
	switch(n_player_index)
	{
		case 10:
		{
			var_5e246f88 = #"hash_4973070961c8d129";
			break;
		}
		case 12:
		{
			var_5e246f88 = #"hash_78c730f53ef32126";
			break;
		}
		case 11:
		{
			var_5e246f88 = #"hash_226e2edabe762438";
			break;
		}
		case 9:
		{
			var_5e246f88 = #"hash_615a8415bb0bfe1a";
			break;
		}
		default:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
	if(isdefined(var_5e246f88))
	{
		self function_79556c43(var_80296afc, var_5e246f88);
	}
	level flag::wait_till("impaler_arrive");
	do
	{
		var_80296afc = self function_4a51430a();
		waitframe(1);
	}
	while(!isalive(var_80296afc));
	n_player_index = var_80296afc namespace_48f3568::function_d35e4c92();
	var_5e246f88 = undefined;
	switch(n_player_index)
	{
		case 10:
		{
			var_5e246f88 = #"hash_770d93aab97174b2";
			break;
		}
		case 12:
		{
			var_5e246f88 = #"hash_3c39ca349a4d1e4d";
			break;
		}
		case 11:
		{
			var_5e246f88 = #"hash_52cfd32c338e64b7";
			break;
		}
		case 9:
		{
			var_5e246f88 = #"hash_41b1fbce8a92a725";
			break;
		}
		default:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
	if(isdefined(var_5e246f88))
	{
		self function_79556c43(var_80296afc, var_5e246f88);
	}
}

/*
	Name: function_188bb878
	Namespace: namespace_bfa7c2ed
	Checksum: 0x7FD0C723
	Offset: 0x2D50
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_188bb878(str_vo)
{
	if(!isdefined(self.var_ea6941e2))
	{
		self.var_ea6941e2 = 15;
	}
	var_88546af8 = soundgetplaybacktime(str_vo);
	var_ac930d11 = gettime() + var_88546af8;
	return isdefined(self.b_is_designated_target) && self.b_is_designated_target && self.var_ea6941e2 >= var_ac930d11;
}

/*
	Name: function_79556c43
	Namespace: namespace_bfa7c2ed
	Checksum: 0x4872EC1B
	Offset: 0x2DE0
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_79556c43(var_80296afc, var_5e246f88)
{
	if(isalive(var_80296afc))
	{
		var_5e243806 = function_8846933a();
		foreach(var_e5e56c3d in var_5e243806)
		{
			if(isalive(var_e5e56c3d) && var_e5e56c3d !== var_80296afc && var_e5e56c3d function_188bb878(var_5e246f88) && distancesquared(var_e5e56c3d.origin, self.origin) <= 90000)
			{
				var_e5e56c3d thread namespace_891c9bac::function_8e0f4696(var_5e246f88, 0, 1, 9999, 1, 1);
			}
		}
		if(var_80296afc function_188bb878(var_5e246f88))
		{
			var_80296afc namespace_891c9bac::function_8e0f4696(var_5e246f88, 0, 1, 9999, 1, 1);
		}
	}
}

/*
	Name: function_8846933a
	Namespace: namespace_bfa7c2ed
	Checksum: 0xCFF4B03
	Offset: 0x2F80
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_8846933a()
{
	var_446aeb44 = [];
	foreach(player in getplayers())
	{
		if(isdefined(player.b_is_designated_target) && player.b_is_designated_target)
		{
			var_446aeb44[var_446aeb44.size] = player;
		}
	}
	return var_446aeb44;
}

/*
	Name: function_4a51430a
	Namespace: namespace_bfa7c2ed
	Checksum: 0xDB2D2D92
	Offset: 0x3040
	Size: 0x158
	Parameters: 3
	Flags: Linked
*/
function function_4a51430a(n_range = 190, var_16752072 = 1, var_caa1b6b8 = 0.8)
{
	var_446aeb44 = function_8846933a();
	n_range_sq = n_range * n_range;
	if(var_446aeb44.size > 0)
	{
		var_446aeb44 = arraysortclosest(var_446aeb44, self.origin);
		player = var_446aeb44[0];
		if(var_16752072)
		{
			b_can_see = player util::is_player_looking_at(self.origin, var_caa1b6b8, 0, self);
		}
		else
		{
			b_can_see = 1;
		}
		n_distsq = distancesquared(self.origin, player.origin);
		if(n_distsq <= n_range_sq && (isdefined(b_can_see) && b_can_see))
		{
			return player;
		}
	}
	return undefined;
}

/*
	Name: function_9ee098d5
	Namespace: namespace_bfa7c2ed
	Checksum: 0x17F72310
	Offset: 0x31A0
	Size: 0x914
	Parameters: 0
	Flags: Linked
*/
function function_9ee098d5()
{
	level endon(#"hash_aa10db1b6143db9");
	var_ac3fdee1 = 0;
	var_b82ff340 = undefined;
	while(var_ac3fdee1 < 4)
	{
		while(isdefined(level.var_8491c913))
		{
			wait(1);
		}
		var_c31108da = self function_5270aabe(e_trigger);
		if(isdefined(var_b82ff340))
		{
			var_24a4f2c0 = var_b82ff340;
			var_b82ff340 = undefined;
		}
		else
		{
			var_24a4f2c0 = self.origin;
		}
		fx_org = util::spawn_model("tag_origin", var_24a4f2c0 + vectorscale((0, 0, 1), 32), self.angles);
		util::wait_network_frame();
		if(!fx_org istouching(e_trigger))
		{
			fx_org.origin = self.origin;
		}
		wait(0.15);
		if(isdefined(var_c31108da))
		{
			fx_org clientfield::increment("" + #"hash_4d45dc65a8307183");
			n_time = function_c5a4ae6(fx_org.origin, var_c31108da.origin);
			fx_org moveto(var_c31108da gettagorigin("j_spine4"), n_time);
			level.var_a91e1dd1 notify(#"hash_6edff0409a51550e");
			level.var_a91e1dd1 hide();
			level.var_a91e1dd1.mdl_head hide();
			fx_org waittill(#"movedone");
			fx_org delete();
		}
		if(isdefined(var_c31108da))
		{
			var_c31108da clientfield::set("" + #"hash_5a88903973664de5", 1);
			var_c31108da thread function_99257c19();
			waitresult = undefined;
			waitresult = var_c31108da waittill(#"death");
		}
		if(isdefined(var_c31108da) && isdefined(var_c31108da.origin))
		{
			var_6a991844 = var_c31108da.origin;
		}
		var_b82ff340 = namespace_c05f06c7::function_a8176b98(var_6a991844);
		if(isdefined(var_b82ff340))
		{
			switch(var_ac3fdee1)
			{
				case 0:
				{
					if(isplayer(waitresult.attacker))
					{
						level thread function_7de84c26(var_b82ff340, var_ac3fdee1);
						var_ac3fdee1++;
					}
					break;
				}
				case 1:
				{
					if(!namespace_2ba51478::is_hero_weapon(waitresult.weapon) && waitresult.mod === "MOD_BURNED")
					{
						level thread function_7de84c26(var_b82ff340, var_ac3fdee1);
						var_ac3fdee1++;
					}
					break;
				}
				case 2:
				{
					if(namespace_2ba51478::is_hero_weapon(waitresult.weapon))
					{
						level thread function_7de84c26(var_b82ff340, var_ac3fdee1);
						var_ac3fdee1++;
					}
					break;
				}
				case 3:
				{
					if(isdefined(waitresult.weapon) && (isdefined(waitresult.weapon.isriotshield) && waitresult.weapon.isriotshield))
					{
						level thread function_7de84c26(var_b82ff340, var_ac3fdee1);
						var_ac3fdee1++;
					}
					break;
				}
			}
			level.var_a91e1dd1.var_dafa2b89.origin = var_b82ff340 + vectorscale((0, 0, 1), 32);
		}
		else
		{
			level.var_a91e1dd1.var_dafa2b89.origin = self.origin;
		}
		wait(1.5);
		level.var_a91e1dd1 show();
		level.var_a91e1dd1.mdl_head show();
		level.var_a91e1dd1 thread namespace_b8f22955::function_c9c7a593();
		waitframe(1);
		level.var_a91e1dd1.var_dafa2b89 thread scene::stop();
		level.var_a91e1dd1 thread scene::stop();
		level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1);
		level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
		if(!level.var_a91e1dd1 istouching(e_trigger))
		{
			n_time = function_c5a4ae6(level.var_a91e1dd1.origin, self.origin);
			level.var_a91e1dd1.var_dafa2b89 moveto(self.origin, n_time);
			level.var_a91e1dd1.var_dafa2b89 rotateto(self.angles, n_time);
			level.var_a91e1dd1.var_dafa2b89 thread scene::stop();
			level.var_a91e1dd1 thread scene::stop();
			level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_d278eff0ca38301", level.var_a91e1dd1);
			level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
			level.var_a91e1dd1.var_dafa2b89 waittill(#"movedone");
			level.var_a91e1dd1.var_dafa2b89 thread scene::stop();
			level.var_a91e1dd1 thread scene::stop();
			level.var_a91e1dd1.var_dafa2b89 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1);
			level.var_a91e1dd1 thread scene::play(#"hash_1d324e9f967f0848", level.var_a91e1dd1.mdl_head);
		}
		wait(function_21a3a673(3, 5));
	}
	level.var_a91e1dd1.var_dafa2b89 thread scene::stop();
	level.var_a91e1dd1 thread scene::stop();
	level.var_a91e1dd1.var_dafa2b89 delete();
	level.var_a91e1dd1.mdl_head delete();
	level.var_a91e1dd1 delete();
}

/*
	Name: function_99257c19
	Namespace: namespace_bfa7c2ed
	Checksum: 0xFBA188D0
	Offset: 0x3AC0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_99257c19()
{
	self endon(#"death");
	level waittill(#"hash_aa10db1b6143db9");
	self clientfield::set("" + #"hash_5a88903973664de5", 0);
}

/*
	Name: function_c5a4ae6
	Namespace: namespace_bfa7c2ed
	Checksum: 0x2C1C493C
	Offset: 0x3B20
	Size: 0x58
	Parameters: 2
	Flags: Linked
*/
function function_c5a4ae6(v_start, v_end)
{
	n_distance = distance2d(v_start, v_end);
	n_time = n_distance / 200;
	return n_time;
}

/*
	Name: function_5270aabe
	Namespace: namespace_bfa7c2ed
	Checksum: 0x2AB6DFAD
	Offset: 0x3B80
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function function_5270aabe(e_trigger)
{
	level endon(#"hash_aa10db1b6143db9");
	while(true)
	{
		var_4bb8adfe = array::get_touching(zombie_utility::get_zombie_array(), e_trigger);
		if(isdefined(var_4bb8adfe) && var_4bb8adfe.size)
		{
			var_680eece8 = arraysortclosest(var_4bb8adfe, self.origin, undefined, 256, undefined);
			foreach(ai_zombie in var_680eece8)
			{
				if(isalive(ai_zombie) && (isdefined(ai_zombie.completed_emerging_into_playable_area) && ai_zombie.completed_emerging_into_playable_area))
				{
					return ai_zombie;
				}
			}
		}
		wait(1.5);
	}
}

/*
	Name: function_7de84c26
	Namespace: namespace_bfa7c2ed
	Checksum: 0x1C1BCAF4
	Offset: 0x3CD0
	Size: 0x1CE
	Parameters: 2
	Flags: Linked
*/
function function_7de84c26(var_b82ff340, n_drop)
{
	switch(n_drop)
	{
		case 0:
		{
			var_8dd283dd = #"hash_5dec945778e394c6";
			break;
		}
		case 1:
		{
			var_8dd283dd = #"hash_59fed9f5ca4fb350";
			break;
		}
		case 2:
		{
			var_8dd283dd = #"hash_71fabfe21d3e3eaa";
			break;
		}
		case 3:
		{
			var_8dd283dd = #"hash_4b3c8cf802555ee2";
			break;
		}
	}
	var_ce72b8cb = util::spawn_model(var_8dd283dd, var_b82ff340 + vectorscale((0, 0, 1), 12));
	util::wait_network_frame();
	var_ce72b8cb clientfield::set("" + #"hash_338e6c710a21b0c", 1);
	var_ce72b8cb bobbing((0, 0, 1), 2, 3);
	/#
	#/
	var_ffba68db = var_ce72b8cb zm_unitrigger::create(undefined, 64, &function_3c1f242b, 1, 1);
	var_ffba68db.script_int = n_drop;
	var_ffba68db.var_ce72b8cb = var_ce72b8cb;
}

/*
	Name: function_3c1f242b
	Namespace: namespace_bfa7c2ed
	Checksum: 0x1F5E40D6
	Offset: 0x3EA8
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_3c1f242b()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	var_ce72b8cb = self.stub.var_ce72b8cb;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player))
		{
			switch(var_9d29e393)
			{
				case 0:
				{
					str_flag = #"hash_67e415588696c592";
					break;
				}
				case 1:
				{
					str_flag = #"hash_67e416588696c745";
					break;
				}
				case 2:
				{
					str_flag = #"hash_67e413588696c22c";
					break;
				}
				case 3:
				{
					str_flag = #"hash_67e414588696c3df";
					break;
				}
			}
			if(isdefined(var_ce72b8cb))
			{
				playsoundatposition(#"hash_6b3b011b2d22c586", var_ce72b8cb.origin);
			}
			e_player thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
			level flag::set(str_flag);
			if(isdefined(var_ce72b8cb))
			{
				var_ce72b8cb delete();
			}
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_e7423237
	Namespace: namespace_bfa7c2ed
	Checksum: 0xFD818404
	Offset: 0x40C8
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function function_e7423237()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	var_9e7c3935 = getent(self.target, "targetname");
	var_9e7c3935 clientfield::set("" + #"hash_3d5a64bed5e39d24", 1);
	var_ffba68db = self zm_unitrigger::create(undefined, 80, &function_9f0de8b3, 1, 1);
	var_ffba68db.script_int = self.script_int;
	switch(self.script_int)
	{
		case 0:
		{
			str_flag = #"hash_1687323c95faf914";
			break;
		}
		case 1:
		{
			str_flag = #"hash_1687333c95fafac7";
			break;
		}
		case 2:
		{
			str_flag = #"hash_1687343c95fafc7a";
			break;
		}
		case 3:
		{
			str_flag = #"hash_1687353c95fafe2d";
			break;
		}
	}
	level flag::wait_till(str_flag);
	var_cd1b359 = util::spawn_model(self.model, self.origin + vectorscale((0, 0, 1), 6));
	if(self.target === "impaler_symbol_bracelet")
	{
		var_cd1b359 setscale(2);
	}
	util::wait_network_frame();
	var_cd1b359 bobbing((0, 0, 1), 2, 3);
	var_cd1b359 clientfield::set("" + #"hash_338e6c710a21b0c", 1);
	var_9e7c3935 clientfield::set("" + #"hash_3d5a64bed5e39d24", 0);
	level flag::wait_till(#"hash_61263135b6fb6340");
	if(isdefined(var_cd1b359))
	{
		var_cd1b359 delete();
	}
	if(isdefined(var_9e7c3935))
	{
		var_9e7c3935 delete();
	}
}

/*
	Name: function_9f0de8b3
	Namespace: namespace_bfa7c2ed
	Checksum: 0xF65A38C5
	Offset: 0x43D8
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_9f0de8b3()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player))
		{
			switch(self.stub.script_int)
			{
				case 0:
				{
					str_flag = #"hash_1687323c95faf914";
					break;
				}
				case 1:
				{
					str_flag = #"hash_1687333c95fafac7";
					break;
				}
				case 2:
				{
					str_flag = #"hash_1687343c95fafc7a";
					break;
				}
				case 3:
				{
					str_flag = #"hash_1687353c95fafe2d";
					break;
				}
			}
			level flag::set(str_flag);
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_9768c04b
	Namespace: namespace_bfa7c2ed
	Checksum: 0xE8314F10
	Offset: 0x4548
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_9768c04b()
{
	level endon(#"hash_1c676c7286de913a");
	var_7853cc7c = getent("imp_symbol_base", "targetname");
	level.var_6a17ff24 = 0;
	callback::on_ai_killed(&function_58251713);
	var_7853cc7c clientfield::set("" + #"hash_3d5a64bed5e39d24", 1);
	while(!level flag::get(#"hash_54326b9f13bd4f1"))
	{
		level flag::wait_till(#"hash_2e0f59cef233a264");
		var_7853cc7c clientfield::set("" + #"hash_3d5a64bed5e39d24", 0);
		function_cc11b6fd();
		var_7853cc7c clientfield::set("" + #"hash_3d5a64bed5e39d24", 1);
	}
}

/*
	Name: function_cc11b6fd
	Namespace: namespace_bfa7c2ed
	Checksum: 0x863D710D
	Offset: 0x46B8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_cc11b6fd()
{
	level endon(#"hash_1c676c7286de913a");
	wait(30);
	level.var_6a17ff24 = 0;
	level flag::clear(#"hash_2e0f59cef233a264");
}

/*
	Name: function_58251713
	Namespace: namespace_bfa7c2ed
	Checksum: 0x8B1E0E7B
	Offset: 0x4710
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_58251713(s_params)
{
	if(self.archetype === #"hash_50f4e0eea9f4e4a4" && !level flag::get(#"hash_2e0f59cef233a264"))
	{
		t_radius = getent("t_imp_kill", "targetname");
		if(self istouching(t_radius) && isplayer(s_params.eattacker))
		{
			level.var_6a17ff24++;
			self playsound(#"hash_4dd41aee138bb20c");
			if(level.var_6a17ff24 == 6)
			{
				level flag::set(#"hash_2e0f59cef233a264");
				self playsound(#"hash_57a171ab3437ea96");
			}
		}
	}
}

/*
	Name: function_d7d6b759
	Namespace: namespace_bfa7c2ed
	Checksum: 0x275AEF02
	Offset: 0x4858
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_d7d6b759()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player) && level flag::get(#"hash_2e0f59cef233a264"))
		{
			level flag::set(#"hash_54326b9f13bd4f1");
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_886c88e
	Namespace: namespace_bfa7c2ed
	Checksum: 0x3959069F
	Offset: 0x4930
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_886c88e()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	var_a8534fa4 = struct::get("s_imp");
	exploder::exploder("fxexp_pickup");
	level thread function_520a8a02();
	level thread function_486252bc();
	var_ffba68db = var_a8534fa4 zm_unitrigger::create(undefined, 64, &function_d23a6d02, 1, 1);
	level flag::wait_till(#"hash_61263135b6fb6340");
	exploder::kill_exploder("fxexp_pickup");
	playsoundatposition(#"hash_64edabe355229d32", (0, 0, 0));
	zm_unitrigger::unregister_unitrigger(var_ffba68db);
}

/*
	Name: function_b9289f93
	Namespace: namespace_bfa7c2ed
	Checksum: 0x16459233
	Offset: 0x4A70
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_b9289f93()
{
	level endon(#"hash_69c33933b1ab3e2b");
	clientfield::set("" + #"hash_73123721764d7374", 1);
	e_floor = getent("imp_open2", "targetname");
	e_clip = getent("imp_blocker", "targetname");
	if(isdefined(e_floor))
	{
		e_floor delete();
	}
	level thread scene::play("p8_fxanim_zm_man_crypt_bundle");
	exploder::exploder("exp_lgt_crypt_normal");
	wait(4);
	if(isdefined(e_clip))
	{
		e_clip notsolid();
		e_clip connectpaths();
		e_clip delete();
	}
	level flag::set("connect_cemetery_graveyard_to_underground");
	level flag::wait_till(#"hash_61263135b6fb6340");
	level thread namespace_c05f06c7::function_f1c106b("loc1", 1);
	exploder::exploder("fxexp_barrier_gameplay_crypt");
}

/*
	Name: function_520a8a02
	Namespace: namespace_bfa7c2ed
	Checksum: 0x38D61950
	Offset: 0x4C30
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_520a8a02()
{
	level endon(#"hash_69c33933b1ab3e2b");
	var_77663e28 = getent("t_imp_in", "targetname");
	while(!level flag::get(#"hash_61263135b6fb6340"))
	{
		if(array::is_touching(util::get_active_players(), var_77663e28))
		{
			if(!level flag::get(#"hash_864c8ec1475abdc"))
			{
				level flag::set(#"hash_864c8ec1475abdc");
				array::run_all(var_a5b74fed, &movez, -40, 0.5);
			}
		}
		else if(level flag::get(#"hash_864c8ec1475abdc"))
		{
			level flag::clear(#"hash_864c8ec1475abdc");
			array::run_all(var_a5b74fed, &movez, 40, 0.5);
		}
		wait(0.5);
	}
	var_77663e28 delete();
}

/*
	Name: function_486252bc
	Namespace: namespace_bfa7c2ed
	Checksum: 0x52B4398D
	Offset: 0x4E08
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_486252bc()
{
	level endon(#"hash_69c33933b1ab3e2b");
	level flag::wait_till(#"hash_61263135b6fb6340");
	level flag::clear(#"spawn_zombies");
	level flag::set(#"pause_round_timeout");
	exploder::exploder_stop("exp_lgt_crypt_normal");
	exploder::exploder("exp_lgt_crypt_darker");
	namespace_c05f06c7::function_45ac4bb8();
}

/*
	Name: function_d23a6d02
	Namespace: namespace_bfa7c2ed
	Checksum: 0x46E72CB
	Offset: 0x4ED0
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_d23a6d02()
{
	level endon(#"hash_38fe2a57d5f9d6ba");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player, 1) && level flag::get(#"hash_864c8ec1475abdc"))
		{
			e_player zm_weapons::weapon_give(level.var_3891e803);
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_5b257b4bd8a2c6ec", 1);
			e_player thread function_a9bfed2d();
			level flag::set(#"hash_61263135b6fb6340");
		}
	}
}

/*
	Name: function_a9bfed2d
	Namespace: namespace_bfa7c2ed
	Checksum: 0x7D261108
	Offset: 0x4FF0
	Size: 0x3E4
	Parameters: 0
	Flags: Linked
*/
function function_a9bfed2d()
{
	level endon(#"hash_69c33933b1ab3e2b");
	a_players = getplayers();
	switch(a_players.size)
	{
		case 1:
		{
			n_enemy_count = 16;
			n_wait_min = 2.25;
			n_wait_max = 2.75;
			break;
		}
		case 2:
		{
			n_enemy_count = 26;
			n_wait_min = 1.75;
			n_wait_max = 2.25;
			break;
		}
		case 3:
		{
			n_enemy_count = 36;
			n_wait_min = 1.25;
			n_wait_max = 1.75;
			break;
		}
		case 4:
		{
			n_enemy_count = 46;
			n_wait_min = 0.75;
			n_wait_max = 1.25;
			break;
		}
	}
	var_219a33e2 = [];
	var_f1c4ec4f = self zm_utility::get_current_zone(1);
	a_spawn_locs = var_f1c4ec4f.a_loc_types[#"nosferatu_location"];
	for(i = 0; i < n_enemy_count; i++)
	{
		if(randomint(100) > 90)
		{
			var_950c7b6b = 1;
		}
		else
		{
			var_950c7b6b = 0;
		}
		if(isdefined(a_spawn_locs))
		{
			s_spawn_loc = array::random(a_spawn_locs);
		}
		else
		{
			s_spawn_loc = namespace_2fa8319f::function_6502a84d();
		}
		if(isdefined(s_spawn_loc))
		{
			var_7afd04dc = namespace_2fa8319f::function_74f25f8a(1, s_spawn_loc, var_950c7b6b, level.round_number);
			if(isdefined(var_7afd04dc))
			{
				if(!isdefined(var_219a33e2))
				{
					var_219a33e2 = [];
				}
				else if(!isarray(var_219a33e2))
				{
					var_219a33e2 = array(var_219a33e2);
				}
				var_219a33e2[var_219a33e2.size] = var_7afd04dc;
				var_7afd04dc.var_126d7bef = 1;
				var_7afd04dc.ignore_round_spawn_failsafe = 1;
				var_7afd04dc.ignore_enemy_count = 1;
				var_7afd04dc.b_ignore_cleanup = 1;
				var_7afd04dc.no_powerups = 1;
				var_7afd04dc zm_score::function_acaab828();
				var_7afd04dc forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
				s_spawn_loc = undefined;
				wait(randomfloatrange(n_wait_min, n_wait_max));
			}
		}
	}
	while(var_219a33e2.size > 1)
	{
		array::remove_dead(var_219a33e2, 0);
		wait(1.5);
	}
	level flag::set(#"hash_38fe2a57d5f9d6ba");
	playsoundatposition(#"hash_7bd7306de23aa3bd", (0, 0, 0));
}

/*
	Name: function_615d8c38
	Namespace: namespace_bfa7c2ed
	Checksum: 0x540C0DE6
	Offset: 0x53E0
	Size: 0x54A
	Parameters: 1
	Flags: Linked
*/
function function_615d8c38(params)
{
	self endon(#"death");
	if(params.weapon != level.var_3891e803)
	{
		return;
	}
	if(!isalive(self) || (isdefined(self.var_a05119b7) && self.var_a05119b7))
	{
		return;
	}
	if(!isplayer(params.eattacker))
	{
		return;
	}
	e_player = params.eattacker;
	if(isdefined(self.var_e104fa93) && self.var_e104fa93)
	{
		return;
	}
	if(isdefined(params.shitloc))
	{
		str_hitloc = params.shitloc;
	}
	else
	{
		return;
	}
	if(isdefined(params.smeansofdeath))
	{
		str_meansofdeath = params.smeansofdeath;
	}
	if(isdefined(params.einflictor))
	{
		var_40dea06f = params.einflictor;
	}
	switch(self.archetype)
	{
		case "zombie":
		{
			self.allowdeath = 1;
			switch(str_hitloc)
			{
				case "left_leg_lower":
				case "left_foot":
				case "left_leg_upper":
				{
					gibserverutils::gibleftleg(self);
					self thread function_9a05e3c2(e_player, var_40dea06f, str_hitloc, str_meansofdeath);
					break;
				}
				case "right_leg_upper":
				case "right_leg_lower":
				case "right_foot":
				{
					gibserverutils::gibrightleg(self);
					self thread function_9a05e3c2(e_player, var_40dea06f, str_hitloc, str_meansofdeath);
					break;
				}
				case "left_arm_lower":
				case "left_arm_upper":
				case "left_hand":
				{
					gibserverutils::gibleftarm(self);
					break;
				}
				case "right_arm_lower":
				case "right_arm_upper":
				case "right_hand":
				{
					gibserverutils::gibrightarm(self);
					break;
				}
				case "head":
				case "helmet":
				case "neck":
				{
					gibserverutils::gibhead(self);
					self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
					break;
				}
			}
			if(randomint(100) < 25)
			{
				self zombie_utility::gib_random_parts();
				gibserverutils::annihilate(self);
				self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
				break;
			}
			break;
		}
		case "hash_1bab8a0ba811401e":
		{
			switch(str_hitloc)
			{
				case "head":
				case "helmet":
				case "neck":
				{
					gibserverutils::gibhead(self);
					self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
					break;
				}
			}
			if(randomint(100) < 25)
			{
				self zombie_utility::gib_random_parts();
				gibserverutils::annihilate(self);
				self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
				break;
			}
			break;
		}
		case "hash_50f4e0eea9f4e4a4":
		{
			self zombie_utility::gib_random_parts();
			gibserverutils::annihilate(self);
			self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
			break;
		}
	}
}

/*
	Name: crossbow_kill
	Namespace: namespace_bfa7c2ed
	Checksum: 0x1F2F30F9
	Offset: 0x5938
	Size: 0x74
	Parameters: 5
	Flags: Linked
*/
function crossbow_kill(n_damage, e_player, var_40dea06f, str_hitloc, str_meansofdeath)
{
	self.var_e104fa93 = 1;
	self dodamage(n_damage, self.origin, e_player, var_40dea06f, str_hitloc, str_meansofdeath, 0, level.var_3891e803);
}

/*
	Name: function_9a05e3c2
	Namespace: namespace_bfa7c2ed
	Checksum: 0x5CC28BA5
	Offset: 0x59B8
	Size: 0x180
	Parameters: 4
	Flags: Linked
*/
function function_9a05e3c2(e_player, var_40dea06f, str_hitloc, str_meansofdeath)
{
	self endon(#"death");
	if(isdefined(level.var_41259f0d) && level.var_41259f0d || ((isdefined(level.var_41017830) ? level.var_41017830 : 0)))
	{
		self crossbow_kill(self.health, e_player, var_40dea06f, str_hitloc, str_meansofdeath);
		return;
	}
	self.has_legs = 0;
	self zombie_utility::function_df5afb5e(1);
	self allowedstances("crouch");
	self setphysparams(15, 0, 24);
	self allowpitchangle(1);
	self setpitchorient();
	health = self.health;
	health = health * 0.1;
}

/*
	Name: createspecialcrossbowwatchertypes
	Namespace: namespace_bfa7c2ed
	Checksum: 0x5CD3D032
	Offset: 0x5B40
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function createspecialcrossbowwatchertypes(watcher)
{
	watcher.onfizzleout = undefined;
	watcher.ondetonatecallback = &weaponobjects::deleteent;
	watcher.ondamage = &weaponobjects::voidondamage;
	watcher.onspawn = &onspawncrossbowboltimpact;
	watcher.onspawnretrievetriggers = &weaponobjects::voidonspawnretrievetriggers;
	watcher.pickup = &weaponobjects::voidpickup;
}

/*
	Name: onspawncrossbowboltimpact
	Namespace: namespace_bfa7c2ed
	Checksum: 0x25DD2313
	Offset: 0x5BD8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowboltimpact(s_watcher, e_player)
{
	self.delete_on_death = 1;
	self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

/*
	Name: onspawncrossbowboltimpact_internal
	Namespace: namespace_bfa7c2ed
	Checksum: 0x1E1DDD3F
	Offset: 0x5C20
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowboltimpact_internal(s_watcher, e_player)
{
	self endon(#"death");
	e_player endon(#"disconnect");
	self waittill(#"stationary");
	s_watcher thread waitandfizzleout(self, 2);
	foreach(n_index, e_object in s_watcher.objectarray)
	{
		if(self == e_object)
		{
			s_watcher.objectarray[n_index] = undefined;
		}
	}
	cleanweaponobjectarray(s_watcher);
}

/*
	Name: cleanweaponobjectarray
	Namespace: namespace_bfa7c2ed
	Checksum: 0x188D033F
	Offset: 0x5D30
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function cleanweaponobjectarray(watcher)
{
	watcher.objectarray = array::remove_undefined(watcher.objectarray);
}

/*
	Name: waitandfizzleout
	Namespace: namespace_bfa7c2ed
	Checksum: 0x98EA87DD
	Offset: 0x5D68
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function waitandfizzleout(object, delay)
{
	object endon(#"death", #"hacked");
	if(isdefined(object.detonated) && object.detonated)
	{
		return;
	}
	object.detonated = 1;
	object notify(#"fizzleout");
	if(delay > 0)
	{
		wait(delay);
	}
	object deleteent();
}

/*
	Name: deleteent
	Namespace: namespace_bfa7c2ed
	Checksum: 0x47662256
	Offset: 0x5E18
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function deleteent(attacker, emp, target)
{
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_1e640843
	Namespace: namespace_bfa7c2ed
	Checksum: 0x318DE6DD
	Offset: 0x5E60
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_1e640843(n_drop)
{
	/#
		level endon(#"hash_aa10db1b6143db9");
		while(isdefined(self))
		{
			print3d(self.origin, n_drop, (0, 1, 0), 1, 0.4, 10);
			wait(0.2);
		}
	#/
}

