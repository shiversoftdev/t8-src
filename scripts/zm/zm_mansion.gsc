// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1035f8d62d51bc68;
#using script_14f4a3c583c77d4b;
#using script_18e21a7011416ce0;
#using script_18eb520705898614;
#using script_190d6b82bcca0908;
#using script_1b10fdf0addd52e;
#using script_1ef0852930d362dc;
#using script_285a7fef0e443482;
#using script_349128b28e416f03;
#using script_3496aeeccaa9d66a;
#using script_35598499769dbb3d;
#using script_387eab232fe22983;
#using script_3cebb48c37fc271;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_42ac4a2f5444022b;
#using script_42ac6fc8b2ff0f3e;
#using script_467027ea7017462b;
#using script_4ce221fa76511ddd;
#using script_4d000493c57bb851;
#using script_519f5896ce786d58;
#using script_52c6c2d1a2ef1b46;
#using script_56827ded777071f1;
#using script_5bb072c3abf4652c;
#using script_5e6956db6de5b044;
#using script_67bf0b64dcb873b1;
#using script_68b63ff01433d9ea;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using script_760946ab27d685b4;
#using script_79c9122f9058e8ba;
#using script_7acfd9adfb8235d7;
#using script_7e59d7bba853fe4b;
#using script_9af9e17217da6e6;
#using script_a2c974cd6e11ddf;
#using script_ab862743b3070a;
#using script_b52a163973f339f;
#using script_b761c44ab2e5b46;
#using script_c17220bc4d57fdd;
#using script_c54399dcca098ce;
#using script_db06eb511bd9b36;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion_achievements.gsc;
#using scripts\zm\zm_mansion_gamemodes.gsc;
#using scripts\zm\zm_mansion_pap_quest.gsc;
#using scripts\zm\zm_mansion_sound.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm\zm_mansion_zones.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_60895c83;

/*
	Name: opt_in
	Namespace: namespace_60895c83
	Checksum: 0xB2684D09
	Offset: 0xF68
	Size: 0x306
	Parameters: 0
	Flags: AutoExec
*/
autoexec function opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	level.var_4ea5cce8 = 2;
	level.random_pandora_box_start = 1;
	level.custom_magic_box_selection_logic = &function_745370d2;
	level.var_2f57e2d2 = &function_d0a9da98;
	level flag::init("power_on2");
	level flag::init("power_on3");
	level flag::init("power_on666");
	level flag::init("first_werewolf_spawned");
	level flag::init("allow_normal_werewolf_spawns");
	level flag::init("open_pap");
	level flag::init("open_pap_dev");
	level flag::init("ww_obtained");
	level flag::init("ww3_obtained");
	level flag::init("guano_drop");
	level flag::init("gazed_main_hall");
	level flag::init("gazed_library");
	level flag::init("gazed_greenhouse");
	level flag::init(#"hash_29b12646045186fa");
	level flag::init(#"hash_2daf5bdda85cc660");
	/#
		level flag::init("");
		level flag::init("");
		level flag::init("");
	#/
	level.var_6eac23d4 = 0;
	level.var_8442091f = 0;
	level.var_6930d2fd = 0;
	level.var_f1028094 = [];
	level.pack_a_punch_camo_index = 280;
	level.pack_a_punch_camo_index_number_variants = 5;
}

/*
	Name: main
	Namespace: namespace_60895c83
	Checksum: 0xC3D98FBA
	Offset: 0x1278
	Size: 0x13AC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setclearanceceiling(131);
	level.var_e1d82d33 = 1500;
	level.var_cd24b30 = 32;
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_be633b3a = getweapon(#"knife");
	level.var_1c0d76f8 = getweapon(#"bowie_knife");
	zm::init_fx();
	namespace_c2ad41c5::init();
	namespace_b8f22955::init_clientfields();
	namespace_b8f22955::function_7255025f();
	namespace_a8113e97::init();
	namespace_b6ca3ccc::init();
	namespace_7922d3d4::init();
	namespace_bfa7c2ed::init();
	namespace_59d4913f::init();
	namespace_a34af286::init();
	namespace_4810a820::init();
	namespace_8f39dfb1::init();
	clientfield::register("clientuimodel", "player_lives", 8000, 2, "int");
	clientfield::register("clientuimodel", "zmhud.ammoModifierActive", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_42e03f9ae74a1070", 8000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_602ae5683c010563", 8000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_4bd91c5285da0899", 8000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_4d9406530777d95", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_60051e21f8eb4af", 8000, 1, "int");
	clientfield::register("actor", "" + #"hash_48a4712e85ec8fcc", 8000, 1, "int");
	clientfield::register("actor", "" + #"hash_1d0080ad80fd0913", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4b4f7c300315b9d0", 8000, 1, "int");
	clientfield::register("item", "" + #"hash_524ec892754aeb34", 8000, 1, "int");
	clientfield::register("item", "" + #"hash_35ce4034ca7e543c", 8000, 3, "int");
	clientfield::register("scriptmover", "" + #"hash_487e544e29aa8e45", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_65180cdab951d111", 8000, getminbitcountfornum(3), "int");
	clientfield::register("scriptmover", "" + #"hash_44ee99a6591fe600", 8000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_6a4f537da00ae3f9", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_7fcdc47572bdbafa", 8000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_17b6a8253206a3cf", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_458d10e70473adfd", 8000, 1, "int");
	namespace_ee206246::register(#"hash_24a3efb2884c6f31", #"hash_12a37f2c621d1245", #"hash_55d5dabec89c9272", &namespace_b8f22955::init, &namespace_b8f22955::cleanup);
	namespace_ee206246::register(#"hash_342287f6118ddaab", #"hash_5460ffe3987d805f", #"hash_ec9e072ae387a61", &namespace_d0842c8b::init, &namespace_d0842c8b::cleanup);
	level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
	level._effect[#"switch_sparks"] = #"electric/fx8_sparks_burst_dir_sm_orange_os";
	level._effect[#"zombie_jump_in_glass_burst"] = #"hash_336284821ea3902e";
	level._effect[#"power_on_impact"] = #"hash_6e44fde5d49cfc9b";
	level._effect[#"hash_451e2c6a17435939"] = #"hash_6714ad8af406b4ee";
	level._no_vending_machine_auto_collision = 1;
	level.default_start_location = "start_room";
	level.default_game_mode = "zclassic";
	level.round_wait_func = &function_802dde1f;
	level.pack_a_punch.custom_power_think = &namespace_b8f22955::function_124362b5;
	level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_monitor_callback;
	level thread namespace_9d27962b::init();
	level.var_22fda912 = &offhand_weapon_overrride;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	level.var_ee565b3f = &namespace_82497b8a::function_1998c3ac;
	level.var_bb2323e4 = &namespace_82497b8a::function_912c1a28;
	level.var_d0ab70a2 = #"hash_67972fca091f2c13";
	level._allow_melee_weapon_switching = 1;
	level.zombiemode_reusing_pack_a_punch = 1;
	level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
	level.custom_spawner_entry[#"hash_1c3a866a84cdb52a"] = &function_4b4b59ed;
	level.custom_spawner_entry[#"hash_21e32c4c500397a2"] = &function_d05b12f;
	level thread function_fc9d7a1f();
	callback::on_spawned(&on_player_spawned);
	callback::on_ai_killed(&namespace_c05f06c7::function_9e147e0c);
	/#
		callback::on_bleedout(&on_player_bleedout);
	#/
	spawner::add_archetype_spawn_function(#"zombie", &function_d7bc28f1);
	callback::on_spawned(&namespace_48607e17::function_a3a92098);
	if(util::function_5df4294() == #"zstandard")
	{
		level.var_c032ff64 = &function_3bc4f1b5;
	}
	load::main();
	level.zones = [];
	level.zone_manager_init_func = &namespace_8b84598b::zone_init;
	init_zones[0] = "zone_start_east";
	init_zones[1] = "zone_start_west";
	level thread namespace_8b84598b::init();
	level thread zm_zonemgr::manage_zones(init_zones);
	level.random_pandora_box_start = 1;
	level.open_chest_location = [];
	level.magic_box_zbarrier_state_func = &zm_magicbox::function_35c66b27;
	level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
	level.chest_joker_custom_movement = &zm_magicbox::function_f5503c41;
	var_2c661c04 = struct::get_array("treasure_chest_use");
	for(i = 0; i < var_2c661c04.size; i++)
	{
		level.open_chest_location[i] = var_2c661c04[i].script_noteworthy;
	}
	level._zombiemode_custom_box_move_logic = &function_c8ac6f35;
	level.customrandomweaponweights = &function_adac5e49;
	level.var_d5bd7049 = #"hash_d113c0c2602fb97";
	level thread sndfunctions();
	getweapon(#"hash_1d492d987b5f57ed").var_62a98b13 = #"charcoal";
	getweapon(#"hash_1d492a987b5f52d4").var_62a98b13 = #"hash_2ae70d22510b8557";
	getweapon(#"hash_1d492b987b5f5487").var_62a98b13 = #"hash_2e2de79ba5c0c3ac";
	getweapon(#"hash_11ae647a1f0d9704").var_25bb96cc = #"hash_70ba93e662197328";
	getweapon(#"hash_11ae677a1f0d9c1d").var_25bb96cc = #"hash_70ba93e662197328";
	getweapon(#"hash_11ae667a1f0d9a6a").var_25bb96cc = #"hash_70ba93e662197328";
	getweapon(#"hash_1d492d987b5f57ed").var_25bb96cc = #"hash_69e071a8eb1f216e";
	getweapon(#"hash_1d492a987b5f52d4").var_25bb96cc = #"hash_b94435b24bcdaf7";
	getweapon(#"hash_1d492b987b5f5487").var_25bb96cc = #"hash_7b5b4849016125ac";
	namespace_ee206246::start(#"hash_24a3efb2884c6f31", 1);
	namespace_ee206246::start(#"hash_342287f6118ddaab", 1);
	level thread function_2d164b86();
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2 && namespace_59ff1d6c::function_901b751c(#"zmpowerstate") != 2)
	{
		level flag::set(#"hash_2daf5bdda85cc660");
		level notify(#"hash_2daf5bdda85cc660");
		function_e764a14b();
	}
	/#
		level thread devgui_setup();
	#/
	function_2c7766d0();
	function_7abcb565();
	function_38c64c43();
	level thread function_fa17b8da();
	level thread function_4972130a();
	level thread namespace_c05f06c7::function_7b248ec9();
	if(!zm_utility::is_standard())
	{
		level.var_932a1afb = &function_ae29ba0f;
		level.var_f7d93c4e = &function_cda69f5e;
	}
	level thread namespace_48607e17::main();
	namespace_59ff1d6c::function_a00576dd(undefined, &function_389e7c22, &function_c8ce0a17, undefined);
	level flag::wait_till("all_players_spawned");
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 2 || namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
	{
		level thread function_ff767eac();
	}
	level thread function_df9d5ef();
	hidemiscmodels("sentinel_artifact_destruction");
	if(!(isdefined(level.var_6d1e18b9) && level.var_6d1e18b9))
	{
		hidemiscmodels("damaged_chandelier");
	}
	scene::add_scene_func("p_zm_seer_stone_s_in_female", &function_4db79562, "play");
	scene::add_scene_func("p_zm_seer_stone_s_in_female", &function_78276077, "done");
	scene::add_scene_func("p_zm_seer_stone_s_out_female", &function_48276a5e, "play");
	scene::add_scene_func("p_zm_seer_stone_s_in_male", &function_4db79562, "play");
	scene::add_scene_func("p_zm_seer_stone_s_in_male", &function_78276077, "done");
	scene::add_scene_func("p_zm_seer_stone_s_out_male", &function_48276a5e, "play");
	/#
		var_41a0524b = getent("", "");
		var_41a0524b callback::function_35a12f19(&function_d4ff1dd6);
	#/
}

/*
	Name: function_fc9d7a1f
	Namespace: namespace_60895c83
	Checksum: 0xAB75216C
	Offset: 0x2630
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fc9d7a1f()
{
	level flag::wait_till("all_players_connected");
	level flag::wait_till_any(array(#"power_on1", #"hash_2daf5bdda85cc660"));
	changeadvertisedstatus(0);
}

/*
	Name: on_player_spawned
	Namespace: namespace_60895c83
	Checksum: 0x1D033378
	Offset: 0x26B8
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.var_d049df11 = 0;
	self.var_c09a076a = 0;
	self.var_95e3c73a = 0;
	self clientfield::set_to_player("" + #"hash_6a4f537da00ae3f9", 0);
	self thread function_3bd89e18();
	self thread function_3cdddd34();
	self.var_aed1893c = [];
	if(self namespace_48f3568::function_69e9e553(array(#"hash_5ebf024e1559c04a")))
	{
		self zm_audio::function_87714659(&namespace_48607e17::function_c8d42aba, #"revive", #"down");
		self zm_audio::function_87714659(&namespace_48607e17::function_e432aeb6, #"pap", #"wait");
		self zm_audio::function_87714659(&namespace_48607e17::function_658ce256, #"hash_5868069fa119e9a3", #"sword_pistol");
		self zm_audio::function_87714659(&namespace_48607e17::function_edae33b5, #"kill", #"sword");
		self zm_audio::function_87714659(&namespace_48607e17::function_fe8cce7a, #"hash_6a87c913e3ecd37a", #"hammer");
		self zm_audio::function_87714659(&namespace_48607e17::function_bb1888fe, #"hash_14214c4848ae30d9", #"scepter");
		self zm_audio::function_87714659(&namespace_48607e17::function_f26d178f, #"hash_5868069fa119e9a3", #"scepter");
		self zm_audio::function_87714659(&namespace_48607e17::function_1f4ab5ec, #"perk", #"generic");
		self.var_ab7bf755 = &namespace_48607e17::function_df8a01f3;
	}
	else
	{
		self zm_audio::function_87714659(&namespace_48607e17::function_4928382a, #"revive", #"down");
	}
	/#
		self thread function_60a2e5e1();
	#/
}

/*
	Name: function_d7bc28f1
	Namespace: namespace_60895c83
	Checksum: 0x28FFC4CB
	Offset: 0x29F8
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_d7bc28f1()
{
	self.var_fad2bca9 = 1;
}

/*
	Name: function_4db79562
	Namespace: namespace_60895c83
	Checksum: 0xBADA274E
	Offset: 0x2A18
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_4db79562(a_ents)
{
	if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
	{
		a_ents[#"hash_210212f859dd4b63"] waittill(#"fade_out", #"disconnect");
		if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
		{
			a_ents[#"hash_210212f859dd4b63"] thread lui::screen_fade_out(0.5, "black");
		}
	}
}

/*
	Name: function_78276077
	Namespace: namespace_60895c83
	Checksum: 0x3E203625
	Offset: 0x2AF0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_78276077(a_ents)
{
	if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
	{
		a_ents[#"hash_210212f859dd4b63"] thread lui::screen_fade_in(0.1, "black");
		a_ents[#"hash_210212f859dd4b63"] waittill(#"hash_30795d8b5cd79089", #"hide_equipment_hint_text", #"disconnect");
		if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
		{
			a_ents[#"hash_210212f859dd4b63"] thread lui::screen_fade_out(0, "black");
		}
	}
}

/*
	Name: function_48276a5e
	Namespace: namespace_60895c83
	Checksum: 0x46A3387F
	Offset: 0x2C08
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_48276a5e(a_ents)
{
	if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
	{
		a_ents[#"hash_210212f859dd4b63"] waittill(#"fade_in", #"disconnect");
		if(isplayer(a_ents[#"hash_210212f859dd4b63"]))
		{
			a_ents[#"hash_210212f859dd4b63"] thread lui::screen_fade_in(0.3, "black");
		}
	}
}

/*
	Name: function_60a2e5e1
	Namespace: namespace_60895c83
	Checksum: 0xEEB4D6BD
	Offset: 0x2CE0
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function function_60a2e5e1()
{
	/#
		self endon(#"disconnect");
		if(isdefined(self.var_ab7f1fb))
		{
			self.var_ab7f1fb destroy();
		}
		level waittill(#"start_of_round");
		if(!level flag::get(""))
		{
			self.var_ab7f1fb = namespace_c05f06c7::create_hudelem(20, 120);
		}
	#/
}

/*
	Name: on_player_bleedout
	Namespace: namespace_60895c83
	Checksum: 0x1AC55741
	Offset: 0x2D88
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function on_player_bleedout()
{
	/#
		if(isdefined(self.var_ab7f1fb))
		{
			self.var_ab7f1fb destroy();
		}
	#/
}

/*
	Name: function_3cdddd34
	Namespace: namespace_60895c83
	Checksum: 0x974E7598
	Offset: 0x2DC0
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_3cdddd34()
{
	self endon(#"death");
	if(!isdefined(self.var_15ba8367))
	{
		self.var_15ba8367 = 0;
	}
	if(!isdefined(self.var_714f6ae6))
	{
		self.var_714f6ae6 = 0;
	}
	while(!self.var_15ba8367 || !self.var_714f6ae6)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_change");
		var_8bf1402f = var_be17187b.weapon;
		if(!self.var_15ba8367 && var_8bf1402f === level.var_6fe89212)
		{
			self thread zm_equipment::show_hint_text(#"hash_495dc239b32c6400", 7);
			self.var_15ba8367 = 1;
		}
		else if(!self.var_714f6ae6 && var_8bf1402f === level.var_7b9ca97a)
		{
			self thread zm_equipment::show_hint_text(#"hash_5a27ab1680f0b8e5", 7);
			self.var_714f6ae6 = 1;
			return;
		}
	}
}

/*
	Name: function_3bd89e18
	Namespace: namespace_60895c83
	Checksum: 0xF1CEF93C
	Offset: 0x2F20
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_3bd89e18()
{
	self notify(#"hash_fcd5027fc170ae7");
	self endon(#"disconnect", #"hash_fcd5027fc170ae7", #"bled_out");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"weapon_change", #"hash_459246e5bfcc3713", #"destroy_riotshield");
		if(namespace_c05f06c7::function_9b4de361(var_385703b7.weapon))
		{
			self.var_c09a076a = 1;
		}
		else
		{
			self.var_c09a076a = 0;
		}
	}
}

/*
	Name: function_fa17b8da
	Namespace: namespace_60895c83
	Checksum: 0xB484A599
	Offset: 0x2FF8
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_fa17b8da()
{
	var_8ef8659 = namespace_a1d9b01d::function_4c2f8683(#"hash_1d492a987b5f52d4");
	var_2631c53e = namespace_a1d9b01d::function_4c2f8683(#"hash_1d492b987b5f5487");
	var_602e9ffa = namespace_a1d9b01d::function_4c2f8683(#"hash_11ae647a1f0d9704");
	var_725ec45a = namespace_a1d9b01d::function_4c2f8683(#"hash_11ae677a1f0d9c1d");
	var_c970f275 = namespace_a1d9b01d::function_4c2f8683(#"hash_11ae667a1f0d9a6a");
	foreach(var_f235dce4 in level.var_223728ac)
	{
		foreach(var_d1f8412f in var_f235dce4)
		{
			var_dae71351 = 0;
			if(!isdefined(var_d1f8412f) || !isdefined(var_d1f8412f.item))
			{
				continue;
			}
			if(var_d1f8412f.item === var_8ef8659)
			{
				var_dae71351 = 1;
			}
			else if(var_d1f8412f.item === var_2631c53e)
			{
				var_dae71351 = 2;
			}
			else if(var_d1f8412f.item === var_602e9ffa || var_d1f8412f.item === var_725ec45a)
			{
				var_dae71351 = 3;
			}
			else if(var_d1f8412f.item === var_c970f275)
			{
				var_dae71351 = 4;
			}
			if(var_dae71351)
			{
				var_d1f8412f clientfield::set("" + #"hash_35ce4034ca7e543c", var_dae71351);
			}
		}
	}
}

/*
	Name: function_4972130a
	Namespace: namespace_60895c83
	Checksum: 0xE0145951
	Offset: 0x3290
	Size: 0x23E
	Parameters: 0
	Flags: Linked
*/
function function_4972130a()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_78451720bf647f70");
		if(isdefined(waitresult.component.e_fx))
		{
			waitresult.component.e_fx delete();
		}
		switch(waitresult.component.name)
		{
			case "hash_5dba840c6ed3ea3b":
			case "hash_5dba850c6ed3ebee":
			{
				level.var_8442091f++;
				level notify(#"hash_879562bd9e764a4");
				if(level.var_8442091f > 1)
				{
					level thread function_91430bcc("ww2");
				}
				if(level flag::get("ww_obtained"))
				{
					level thread function_5a39ced2("ww2");
				}
				break;
			}
			case "hash_3f639544c52d4fa3":
			case "hash_3f639644c52d5156":
			case "zitem_chaos_lvl3_part_3":
			{
				level.var_6930d2fd++;
				if(level.var_6930d2fd > 2)
				{
					level thread function_91430bcc("ww3");
				}
				level thread function_5a39ced2("ww3");
				break;
			}
			case "hash_1d4928987b5f4f6e":
			case "hash_1d492a987b5f52d4":
			case "hash_1d492b987b5f5487":
			case "hash_1d492d987b5f57ed":
			{
				level thread function_5a39ced2("bullet");
				break;
			}
		}
	}
}

/*
	Name: function_5a39ced2
	Namespace: namespace_60895c83
	Checksum: 0x145CEA0C
	Offset: 0x34D8
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function function_5a39ced2(str_type)
{
	switch(str_type)
	{
		case "ww2":
		{
			foreach(player in getplayers())
			{
				if(isdefined(player.var_ab7f1fb))
				{
					/#
						player.var_ab7f1fb settext("" + level.var_8442091f + "");
					#/
				}
			}
			break;
		}
		case "ww3":
		{
			foreach(player in getplayers())
			{
				if(isdefined(player.var_ab7f1fb))
				{
					/#
						player.var_ab7f1fb settext("" + level.var_6930d2fd + "");
					#/
				}
			}
			break;
		}
	}
}

/*
	Name: function_91430bcc
	Namespace: namespace_60895c83
	Checksum: 0x86868D2C
	Offset: 0x3690
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_91430bcc(str_weapon)
{
	var_cb200b7d = 0;
	if(str_weapon == "ww2")
	{
		var_6642b54d = level.var_6fe89212;
		var_7a2b6ba8 = level.var_74cf08b1;
	}
	else
	{
		var_6642b54d = level.var_7b9ca97a;
		var_7a2b6ba8 = level.var_4b14202f;
	}
	while(!var_cb200b7d)
	{
		foreach(player in getplayers())
		{
			a_weapons = player getweaponslistprimaries();
			foreach(weapon in a_weapons)
			{
				if(weapon == var_7a2b6ba8 || weapon == var_6642b54d)
				{
					level thread function_ea36bce3(str_weapon);
					var_cb200b7d = 1;
					break;
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_ea36bce3
	Namespace: namespace_60895c83
	Checksum: 0xCA6A7DFC
	Offset: 0x3848
	Size: 0x180
	Parameters: 1
	Flags: Linked
*/
function function_ea36bce3(str_weapon)
{
	if(str_weapon == "ww2")
	{
		foreach(player in getplayers())
		{
			if(isdefined(player.var_ab7f1fb))
			{
				/#
					player.var_ab7f1fb settext("" + level.var_6930d2fd + "");
				#/
			}
		}
	}
	else
	{
		level flag::set("ww3_obtained");
		foreach(player in getplayers())
		{
			if(isdefined(player.var_ab7f1fb))
			{
				/#
					player.var_ab7f1fb destroy();
				#/
			}
		}
	}
}

/*
	Name: player_out_of_playable_area_monitor_callback
	Namespace: namespace_60895c83
	Checksum: 0x608D1D35
	Offset: 0x39D0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function player_out_of_playable_area_monitor_callback()
{
	if(isdefined(self.var_f22c83f5) && self.var_f22c83f5)
	{
		return 0;
	}
	return 1;
}

/*
	Name: offhand_weapon_overrride
	Namespace: namespace_60895c83
	Checksum: 0x9DB60655
	Offset: 0x3A00
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function offhand_weapon_overrride()
{
	namespace_2ba51478::register_tactical_grenade_for_level("zhield_dw", 1);
}

/*
	Name: offhand_weapon_give_override
	Namespace: namespace_60895c83
	Checksum: 0x88DB7F6C
	Offset: 0x3A30
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function offhand_weapon_give_override(str_weapon)
{
	self endon(#"death");
	if(namespace_2ba51478::is_tactical_grenade(str_weapon) && isdefined(self namespace_2ba51478::get_player_tactical_grenade()) && !self namespace_2ba51478::is_player_tactical_grenade(str_weapon))
	{
		self setweaponammoclip(self namespace_2ba51478::get_player_tactical_grenade(), 0);
		self takeweapon(self namespace_2ba51478::get_player_tactical_grenade());
	}
	return 0;
}

/*
	Name: function_78f60fd5
	Namespace: namespace_60895c83
	Checksum: 0xB3BA0330
	Offset: 0x3B00
	Size: 0x1A6
	Parameters: 12
	Flags: Linked
*/
function function_78f60fd5(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && isdefined(self.archetype) && (self.archetype == #"hash_50f4e0eea9f4e4a4" || self.archetype == #"hash_69eff09684574252") && attacker hasweapon(level.var_6d66c4ba))
	{
		if(!(isdefined(attacker.var_594a3318) && attacker.var_594a3318))
		{
			attacker thread namespace_891c9bac::function_a2bd5a0c(#"hash_682afe734ec44af", 3);
			attacker.var_594a3318 = 1;
		}
		self clientfield::set("" + #"hash_7a260c02e8c345c2", 1);
		self zombie_utility::gib_random_parts();
		gibserverutils::annihilate(self);
		return self.health + 666;
	}
	return damage;
}

/*
	Name: function_293e7d89
	Namespace: namespace_60895c83
	Checksum: 0x34A95AE4
	Offset: 0x3CB0
	Size: 0x10E
	Parameters: 15
	Flags: Linked
*/
function function_293e7d89(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isplayer(eattacker) && smeansofdeath === "MOD_MELEE" && eattacker hasweapon(level.var_6d66c4ba))
	{
		self clientfield::set("" + #"hash_7a260c02e8c345c2", 1);
		return self.health + 666;
	}
	return idamage;
}

/*
	Name: function_d515f923
	Namespace: namespace_60895c83
	Checksum: 0x8A4CE288
	Offset: 0x3DC8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_d515f923()
{
	level flag::init("always_on");
	level flag::set("always_on");
	level.disable_kill_thread = 1;
	zm_zonemgr::add_adjacent_zone("start_zone", "corner_zone", "corner_zone_on", 0);
}

/*
	Name: function_c8ac6f35
	Namespace: namespace_60895c83
	Checksum: 0xDADBEE90
	Offset: 0x3E50
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_c8ac6f35()
{
	if(level flag::get("open_pap"))
	{
		zm_magicbox::default_box_move_logic();
	}
	else
	{
		var_15612e55 = level.chests[level.chest_index].script_noteworthy;
		level.chests = array::randomize(level.chests);
		for(i = 0; i < level.chests.size; i++)
		{
			if(level.chests[i].script_noteworthy != "pap_zone_chest" && level.chests[i].script_noteworthy != var_15612e55)
			{
				level.chest_index = i;
				break;
			}
		}
	}
}

/*
	Name: function_adac5e49
	Namespace: namespace_60895c83
	Checksum: 0xB0B42A6
	Offset: 0x3F70
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function function_adac5e49(a_keys)
{
	if(!isdefined(level.var_ee09b3bf))
	{
		level.var_ee09b3bf = 0;
	}
	if(!isdefined(level.var_6481a9af))
	{
		level.var_6481a9af = 0;
	}
	if(!zm_weapons::get_is_in_box(level.var_f086136b))
	{
		return a_keys;
	}
	if(a_keys[0] === level.var_f086136b)
	{
		level.var_ee09b3bf = 0;
		return a_keys;
	}
	n_chance = 0;
	if(!self hasweapon(level.var_f086136b) && !self hasweapon(level.var_6fe89212) && !self hasweapon(level.var_7b9ca97a))
	{
		if(level.chest_moves == level.var_6481a9af)
		{
			return a_keys;
		}
		level.var_ee09b3bf++;
		if(level.var_ee09b3bf > 2 && level.var_ee09b3bf <= 5)
		{
			n_chance = 10;
		}
		else if(level.var_ee09b3bf > 5 && level.var_ee09b3bf <= 8)
		{
			n_chance = 25;
		}
		else if(level.var_ee09b3bf > 8)
		{
			n_chance = 50;
		}
		if(randomint(100) <= n_chance)
		{
			arrayinsert(a_keys, level.var_f086136b, 0);
			level.var_ee09b3bf = 0;
			level.var_6481a9af++;
		}
	}
	return a_keys;
}

/*
	Name: function_d0a9da98
	Namespace: namespace_60895c83
	Checksum: 0x14218F18
	Offset: 0x4198
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_d0a9da98(e_player)
{
	if(isdefined(self.stub.trigger_target.weapon_out) && self.stub.trigger_target.weapon_out)
	{
		if(self.stub.trigger_target.zbarrier.weapon == level.var_f086136b)
		{
			if(e_player hasweapon(level.var_f086136b, 1) || e_player hasweapon(level.var_6fe89212, 1) || e_player hasweapon(level.var_7b9ca97a, 1))
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_745370d2
	Namespace: namespace_60895c83
	Checksum: 0x1039F8EA
	Offset: 0x4290
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_745370d2(w_weapon, e_player)
{
	if(w_weapon == level.var_f086136b && (e_player hasweapon(level.var_6fe89212) || e_player hasweapon(level.var_7b9ca97a)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_802dde1f
	Namespace: namespace_60895c83
	Checksum: 0x8D8515EC
	Offset: 0x4310
	Size: 0x1FA
	Parameters: 0
	Flags: Linked
*/
function function_802dde1f()
{
	level endon(#"restart_round");
	/#
		level endon(#"kill_round");
		if(getdvarint(#"zombie_rise_test", 0))
		{
			level waittill(#"forever");
		}
		if(zm::cheat_enabled(2))
		{
			level waittill(#"forever");
		}
		if(getdvarint(#"zombie_default_max", 0) == 0)
		{
			level waittill(#"forever");
		}
		level thread namespace_a28acff3::print_zombie_counts();
		level thread namespace_a28acff3::sndmusiconkillround();
	#/
	while(true)
	{
		var_7e5b8365 = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
		if(!var_7e5b8365 || level flag::get("end_round_wait"))
		{
			break;
		}
		if(level flag::get("round_reset"))
		{
			break;
		}
		wait(1);
	}
	level.var_13473346 = 0;
}

/*
	Name: sndfunctions
	Namespace: namespace_60895c83
	Checksum: 0xC91AE49C
	Offset: 0x4518
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function sndfunctions()
{
	if(zm_utility::is_standard())
	{
		level.zmannouncerprefix = "rush";
	}
	else
	{
		level.zmannouncerprefix = "prst";
	}
	zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
	level thread setupmusic();
	level thread custom_add_vox();
}

/*
	Name: custom_add_vox
	Namespace: namespace_60895c83
	Checksum: 0x17984081
	Offset: 0x45B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function custom_add_vox()
{
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_c79aaf74e007b22");
	zm_audio::loadplayervoicecategories(#"hash_74c49b8d4f407798");
}

/*
	Name: setupmusic
	Namespace: namespace_60895c83
	Checksum: 0xB9B74576
	Offset: 0x4628
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "mansion_roundstart_1", "mansion_roundstart_2", "mansion_roundstart_3");
	zm_audio::musicstate_create("round_start_first", 3, "mansion_roundstart_first");
	zm_audio::musicstate_create("round_end", 3, "mansion_roundend_1", "mansion_roundend_2", "mansion_roundend_3");
	zm_audio::musicstate_create("round_start_special", 3, "mansion_roundstart_special_1");
	zm_audio::musicstate_create("round_end_special", 3, "mansion_roundend_special_1");
	zm_audio::musicstate_create("game_over", 5, "mansion_death");
	zm_audio::musicstate_create("ee_song", 4, "ee_song");
	zm_audio::musicstate_create("quest_1", 4, "quest_1");
	zm_audio::musicstate_create("quest_2", 4, "quest_2");
	zm_audio::musicstate_create("quest_3", 4, "quest_3");
	level thread zm_audio::function_3442c81a(#"hash_2b19c9a3e37c977c", "location_music_room");
	level thread zm_audio::function_3442c81a(#"hash_4cfb09573e278f6a", "location_dining_room");
	level thread zm_audio::function_3442c81a(#"hash_4fa0217a1bf4ccdc", "location_greenhouse");
}

/*
	Name: function_7abcb565
	Namespace: namespace_60895c83
	Checksum: 0xFFF339AA
	Offset: 0x4860
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_7abcb565()
{
	if(util::function_5df4294() == #"zstandard")
	{
		s_loc = struct::get("rush_perk_altar_cellar", "targetname");
	}
	else
	{
		s_loc = struct::get("random_perk_vapor_altar", "script_noteworthy");
	}
	if(isdefined(s_loc))
	{
		var_75787fd3 = struct::get_array("s_mansion_random_statue_loc");
		level.var_8104ec1b = arraygetclosest(s_loc.origin, var_75787fd3);
		if(isstring(s_loc.target2))
		{
			var_b900cd16 = getentarray(s_loc.target2, "targetname");
			array::run_all(var_b900cd16, &disconnectpaths);
		}
	}
}

/*
	Name: function_3bc4f1b5
	Namespace: namespace_60895c83
	Checksum: 0xABFA606A
	Offset: 0x49A8
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_3bc4f1b5()
{
	s_loc = struct::get("rush_perk_altar_cellar", "targetname");
	var_75787fd3 = struct::get_array("random_perk_vapor_altar", "script_noteworthy");
	return arraygetclosest(s_loc.origin, var_75787fd3);
}

/*
	Name: function_38c64c43
	Namespace: namespace_60895c83
	Checksum: 0x8CDC0B1D
	Offset: 0x4A28
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function function_38c64c43()
{
	foreach(var_454e1877 in struct::get_array("perk_sigil"))
	{
		foreach(var_839c3bf7 in struct::get_array(var_454e1877.script_noteworthy, "prefabname"))
		{
			if(isdefined(var_839c3bf7.script_int))
			{
				switch(var_839c3bf7.script_int)
				{
					case 0:
					{
						var_e09cfdd5 = "p8_zm_man_tea_room_door_frame_top_earth";
						break;
					}
					case 1:
					{
						var_e09cfdd5 = "p8_zm_man_tea_room_door_frame_top_fire";
						break;
					}
					case 2:
					{
						var_e09cfdd5 = "p8_zm_man_tea_room_door_frame_top_air";
						break;
					}
					case 3:
					{
						var_e09cfdd5 = "p8_zm_man_tea_room_door_frame_top_water";
						break;
					}
				}
				if(isdefined(var_e09cfdd5))
				{
					var_454e1877.var_e09cfdd5 = util::spawn_model(var_e09cfdd5, var_454e1877.origin, var_454e1877.angles);
				}
			}
		}
	}
}

/*
	Name: function_df9d5ef
	Namespace: namespace_60895c83
	Checksum: 0xA50C7F59
	Offset: 0x4C10
	Size: 0x38E
	Parameters: 0
	Flags: Linked
*/
function function_df9d5ef()
{
	foreach(s_altar in struct::get_array("perk_vapor_altar"))
	{
		switch(s_altar.prefabname)
		{
			case "graveyard":
			{
				if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_zeus_mod")
				{
					exploder::exploder("exp_lgt_cemeter_alter_zeus");
				}
				else if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_odin_mod")
				{
					exploder::exploder("exp_lgt_cemeter_alter_odin");
				}
				else
				{
					exploder::exploder("exp_lgt_cemeter_alter_ra");
				}
				break;
			}
			case "gardens":
			{
				if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_zeus_mod")
				{
					exploder::exploder("exp_lgt_garden_alter_zeus");
				}
				else if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_odin_mod")
				{
					exploder::exploder("exp_lgt_garden_alter_odin");
				}
				else
				{
					exploder::exploder("exp_lgt_garden_alter_ra");
				}
				break;
			}
			case "cellar":
			{
				if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_zeus_mod")
				{
					exploder::exploder("exp_lgt_cellar_alter_zeus");
				}
				else if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_odin_mod")
				{
					exploder::exploder("exp_lgt_cellar_alter_odin");
				}
				else
				{
					exploder::exploder("exp_lgt_cellar_alter_ra");
				}
				break;
			}
			case "hash_8fb73b3e63758fb":
			{
				if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_zeus_mod")
				{
					exploder::exploder("exp_lgt_forest_alter_zeus");
				}
				else if(s_altar.var_73bd396b.model === #"p8_fxanim_zm_vapor_altar_odin_mod")
				{
					exploder::exploder("exp_lgt_forest_alter_odin");
				}
				else
				{
					exploder::exploder("exp_lgt_forest_alter_ra");
				}
				break;
			}
		}
	}
}

/*
	Name: function_4b4b59ed
	Namespace: namespace_60895c83
	Checksum: 0xF9C7CE93
	Offset: 0x4FA8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_4b4b59ed(spot)
{
	self thread zm_spawner::function_45bb11e4(spot);
	self thread function_5734f4d9();
}

/*
	Name: function_5734f4d9
	Namespace: namespace_60895c83
	Checksum: 0x5922B31B
	Offset: 0x4FF0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_5734f4d9()
{
	self endon(#"death");
	wait(0.3);
	self fx::play("zombie_jump_in_glass_burst", self.origin, self.angles, 7);
	glassradiusdamage(self.origin, 128, 128, 64);
	playrumbleonposition("damage_heavy", self.origin);
}

/*
	Name: function_d05b12f
	Namespace: namespace_60895c83
	Checksum: 0xF73C62C
	Offset: 0x5098
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_d05b12f(spot)
{
	if(randomint(100) > 50)
	{
		spot.scriptbundlename = "aib_vign_tplt_zm_ent_wall_crack_sngl_base_zombie_03";
	}
	self zm_spawner::function_45bb11e4(spot);
}

/*
	Name: function_2d164b86
	Namespace: namespace_60895c83
	Checksum: 0x455ECACD
	Offset: 0x50F8
	Size: 0xB4C
	Parameters: 0
	Flags: Linked
*/
function function_2d164b86()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") != 2)
	{
		level.var_f3a008f = &function_db3037c7;
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_2c6b5594940cc305") == 2)
	{
		level.var_229f30cd = &function_d9848d71;
	}
	var_c712b3e9 = getent("artifact_mind", "script_noteworthy");
	var_3f772556 = getent("artifact_mind_card", "targetname");
	var_3f772556 linkto(var_c712b3e9);
	var_c712b3e9 clientfield::set("" + #"hash_65180cdab951d111", 1);
	var_3f772556 clientfield::set("" + #"hash_44ee99a6591fe600", 1);
	var_c712b3e9 notsolid();
	var_c712b3e9 bobbing((0, 0, 1), 0.5, 5);
	var_5573ec58 = util::spawn_model("tag_origin", var_c712b3e9.origin, var_c712b3e9.angles);
	if(zm_utility::is_standard())
	{
		var_6152b664 = getent("use_elec_switch", "targetname");
		var_6152b664 triggerenable(0);
	}
	var_fdbbb780 = 0;
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
	{
		level waittill(#"all_players_spawned");
		level thread function_6f4dc4ad("debris_to_dining_room_upper_scene", "connect_bedroom_to_dining_room", "Shot 1", "Shot 2");
		level thread function_6f4dc4ad("debris_cemetery_entrance_scene", "connect_library_to_cemetery_entrance", "Shot 1", "Shot 2");
		level thread function_6f4dc4ad("debris_cemetery_scene", "connect_cemetery_entrance_to_cemetery_graveyard", "Shot 1", "Shot 2");
		level thread scene::play("entrance_hall_exploding_door", "targetname");
		var_fdbbb780 = 1;
	}
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_3e80d503318a5674");
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 2)
	{
		level flag::set("power_on1");
		level flag::set("power_on2");
		level flag::set("power_on3");
	}
	if(isplayer(var_88706ea7.player))
	{
		var_d11a4648 = var_88706ea7.player;
	}
	if(!var_fdbbb780)
	{
		level thread function_6f4dc4ad("debris_to_dining_room_upper_scene", "connect_bedroom_to_dining_room", "Shot 1", "Shot 2");
		level thread function_6f4dc4ad("debris_cemetery_entrance_scene", "connect_library_to_cemetery_entrance", "Shot 1", "Shot 2");
		level thread function_6f4dc4ad("debris_cemetery_scene", "connect_cemetery_entrance_to_cemetery_graveyard", "Shot 1", "Shot 2");
	}
	var_c712b3e9 playsound(#"hash_75b9c9ad6ebe8af2");
	if(isalive(var_d11a4648))
	{
		var_d11a4648 val::set("artifact_pickup", "takedamage", 0);
		var_d11a4648 val::set("artifact_pickup", "ignoreme", 1);
	}
	var_c712b3e9 clientfield::set("" + #"hash_65180cdab951d111", 2);
	var_3f772556 clientfield::set("" + #"hash_44ee99a6591fe600", 0);
	wait(3);
	var_3f772556 delete();
	var_c712b3e9 setmodel(#"hash_57d5802b9383f9c7");
	var_c712b3e9 clientfield::set("" + #"hash_65180cdab951d111", 3);
	var_8a281f69 = getvehiclenode("power_on_projectile_path_1", "targetname");
	v_pos = var_8a281f69.origin + vectorscale((0, 0, -1), 16);
	var_c712b3e9 moveto(v_pos, 1.5, 1, 0.5);
	var_c712b3e9 waittill(#"movedone");
	if(isalive(var_d11a4648))
	{
		var_d11a4648 val::reset("artifact_pickup", "takedamage");
		var_d11a4648 val::reset("artifact_pickup", "ignoreme");
	}
	exploder::exploder("fxexp_power_artifact_burst");
	var_c712b3e9 clientfield::set("" + #"hash_65180cdab951d111", 0);
	var_c712b3e9 delete();
	foreach(var_7653f3d0 in util::get_active_players())
	{
		var_7653f3d0 playrumbleonentity("zm_power_on_rumble");
	}
	var_5573ec58 notify(#"hash_d46f768bfeb3aeb");
	var_5573ec58 delete();
	playsoundatposition(#"hash_3d8fef5997663b17", (0, 0, 0));
	var_5314bd63 = getent("veh_power_on_projectile", "targetname");
	for(i = 0; i < 4; i++)
	{
		var_a11e6097[i] = spawner::simple_spawn_single(var_5314bd63);
	}
	level thread function_94cf8d37("power_on_projectile_path_1", var_a11e6097[0], 30, 88);
	var_a11e6097[0] thread function_3e1f5f39(1);
	level thread function_94cf8d37("power_on_projectile_path_2", var_a11e6097[1], 30, 88);
	var_a11e6097[1] thread function_3e1f5f39(2);
	level thread function_94cf8d37("power_on_projectile_path_3", var_a11e6097[2], 30, 88);
	var_a11e6097[2] thread function_3e1f5f39(3);
	level thread function_94cf8d37("power_on_projectile_path_4", var_a11e6097[3], 30, 88);
	var_a11e6097[3] thread function_3e1f5f39(4);
	zm_power::turn_power_on_and_open_doors(2);
	if(!zm_utility::is_standard() && namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 1)
	{
		level thread scene::play("entrance_hall_exploding_door", "targetname");
	}
	if(isalive(var_d11a4648))
	{
		var_d11a4648 util::delay(6, "death", &zm_audio::create_and_play_dialog, #"sentinel", #"key");
	}
}

/*
	Name: function_db3037c7
	Namespace: namespace_60895c83
	Checksum: 0xBB65ABF5
	Offset: 0x5C50
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_db3037c7()
{
	if(self.script_int === 666)
	{
		self thread function_ba054e47();
		return 1;
	}
	return 0;
}

/*
	Name: function_ba054e47
	Namespace: namespace_60895c83
	Checksum: 0x66E6A7A7
	Offset: 0x5C90
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_ba054e47()
{
	level endon(#"end_game");
	self.script_noteworthy = undefined;
	level flag::wait_till("gameplay_started");
	if(isdefined(self))
	{
		self.script_noteworthy = "local_electric_door";
	}
}

/*
	Name: function_d9848d71
	Namespace: namespace_60895c83
	Checksum: 0x5EFA9388
	Offset: 0x5CF0
	Size: 0x33E
	Parameters: 1
	Flags: Linked
*/
function function_d9848d71(var_4506f72b)
{
	level endon(#"end_game");
	var_ed3ddfdf = getentarray("zombie_debris", "targetname");
	var_38a6b7d0 = getentarray("zombie_airlock_buy", "targetname");
	foreach(door in var_4506f72b)
	{
		if(door.target === "door_start_to_hall" || door.target === "door_hallend_to_grand_staircase")
		{
			if(!(isdefined(door.has_been_opened) && door.has_been_opened))
			{
				door notify(#"trigger", {#hash_3fc8547c:1});
			}
			waitframe(1);
		}
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 0)
	{
		var_4506f72b = [];
		var_ed3ddfdf = [];
		var_38a6b7d0 = [];
	}
	level flag::wait_till_any(array(#"power_on", #"power_on1", #"hash_2daf5bdda85cc660"));
	for(i = 0; i < var_4506f72b.size; i++)
	{
		if(!(isdefined(var_4506f72b[i].has_been_opened) && var_4506f72b[i].has_been_opened))
		{
			var_4506f72b[i] notify(#"trigger", {#hash_3fc8547c:1});
		}
		waitframe(1);
	}
	for(i = 0; i < var_38a6b7d0.size; i++)
	{
		if(isdefined(var_38a6b7d0[i]))
		{
			var_38a6b7d0[i] notify(#"trigger", {#hash_3fc8547c:1});
		}
		waitframe(1);
	}
	for(i = 0; i < var_ed3ddfdf.size; i++)
	{
		if(isdefined(var_ed3ddfdf[i]))
		{
			var_ed3ddfdf[i] notify(#"trigger", {#hash_3fc8547c:1});
		}
		waitframe(1);
	}
}

/*
	Name: function_94cf8d37
	Namespace: namespace_60895c83
	Checksum: 0x9B80B604
	Offset: 0x6038
	Size: 0x18C
	Parameters: 4
	Flags: Linked
*/
function function_94cf8d37(var_62406c, var_62c4256, n_acceleration, n_speed)
{
	nd_spline = getvehiclenode(var_62406c, "targetname");
	var_62c4256.origin = nd_spline.origin;
	var_62c4256.angles = nd_spline.angles;
	var_62c4256 setacceleration(n_acceleration);
	if(isdefined(n_speed))
	{
		var_62c4256 setspeed(n_speed);
	}
	var_62c4256 clientfield::set("" + #"hash_602ae5683c010563", 1);
	var_62c4256 vehicle::get_on_and_go_path(nd_spline);
	var_62c4256 clientfield::set("" + #"hash_602ae5683c010563", 0);
	var_62c4256 clientfield::increment("" + #"hash_4bd91c5285da0899", 1);
	wait(0.1);
	var_62c4256 delete();
}

/*
	Name: function_3e1f5f39
	Namespace: namespace_60895c83
	Checksum: 0xCE5F2F1F
	Offset: 0x61D0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_3e1f5f39(var_54c5ef49)
{
	level endon(#"end_game");
	self endon_callback(&function_3ffb36f6, #"death");
	if(var_54c5ef49 === 4)
	{
		level waittill(#"chandelier_fall");
		self thread power_on_impact();
		level thread function_de344348();
		level thread function_2ef77fbf();
	}
	level waittill("ceiling_break_" + var_54c5ef49);
	self thread power_on_impact();
	level scene::play("ceiling_break_" + var_54c5ef49, "targetname");
}

/*
	Name: function_de344348
	Namespace: namespace_60895c83
	Checksum: 0xCF9A6336
	Offset: 0x62E8
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_de344348()
{
	level endon(#"end_game");
	if(isdefined(level.var_6d1e18b9) && level.var_6d1e18b9)
	{
		return;
	}
	level thread function_c72fed9e();
	level scene::play("chandelier_fall", "targetname");
	showmiscmodels("sentinel_artifact_destruction");
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") != 0)
	{
		level scene::delete_scene_spawned_ents("entrance_hall_exploding_door");
	}
	level scene::delete_scene_spawned_ents("ceiling_break_1");
	level scene::delete_scene_spawned_ents("ceiling_break_2");
	level scene::delete_scene_spawned_ents("ceiling_break_3");
	level scene::delete_scene_spawned_ents("ceiling_break_4");
	level scene::delete_scene_spawned_ents("chandelier_fall");
}

/*
	Name: function_c72fed9e
	Namespace: namespace_60895c83
	Checksum: 0x7A3B2BC0
	Offset: 0x6468
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_c72fed9e()
{
	level endon(#"end_game");
	level waittill(#"hash_2f2d88b84e2b0e4e");
	showmiscmodels("damaged_chandelier");
}

/*
	Name: function_e764a14b
	Namespace: namespace_60895c83
	Checksum: 0x7F5B8BE4
	Offset: 0x64C0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_e764a14b()
{
	level scene::play("chandelier_fall", "targetname");
	level scene::delete_scene_spawned_ents("chandelier_fall");
	level.var_6d1e18b9 = 1;
	showmiscmodels("damaged_chandelier");
}

/*
	Name: function_2ef77fbf
	Namespace: namespace_60895c83
	Checksum: 0x472DDD6B
	Offset: 0x6540
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_2ef77fbf()
{
	level endon(#"end_game");
	wait(3);
	zm_power::turn_power_on_and_open_doors(3);
}

/*
	Name: function_3ffb36f6
	Namespace: namespace_60895c83
	Checksum: 0x78949A69
	Offset: 0x6588
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function function_3ffb36f6(var_5a5260d8)
{
	level notify(#"hash_8b10a9a92b1a162");
}

/*
	Name: power_on_impact
	Namespace: namespace_60895c83
	Checksum: 0xEA01DDB
	Offset: 0x65B0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function power_on_impact()
{
	self fx::play("power_on_impact", self.origin);
	playsoundatposition(#"zmb_sq_souls_release", self.origin);
}

/*
	Name: function_6f4dc4ad
	Namespace: namespace_60895c83
	Checksum: 0xE25A330D
	Offset: 0x6610
	Size: 0x94
	Parameters: 4
	Flags: Linked
*/
function function_6f4dc4ad(str_targetname, str_script_flag, var_d46cd47, var_d6d5180b)
{
	level thread scene::play(str_targetname, var_d46cd47);
	level flag::wait_till(str_script_flag);
	level scene::play(str_targetname, var_d6d5180b);
	level scene::delete_scene_spawned_ents(str_targetname);
}

/*
	Name: function_2c7766d0
	Namespace: namespace_60895c83
	Checksum: 0xECB98938
	Offset: 0x66B0
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_2c7766d0()
{
	namespace_eaaeba61::function_44a82004("power_on1");
	level.var_5bfd847e = #"power_on1";
	level.var_e9737821 = &function_c52e8ba;
	level.var_352c9e03 = &function_af65fe93;
}

/*
	Name: function_c52e8ba
	Namespace: namespace_60895c83
	Checksum: 0xFF954DFE
	Offset: 0x6720
	Size: 0x406
	Parameters: 2
	Flags: Linked
*/
function function_c52e8ba(player, var_8d5d092c)
{
	b_result = 0;
	if(!isdefined(self.hint_string))
	{
		self.hint_string = [];
	}
	n_player_index = player getentitynumber();
	if(!self namespace_eaaeba61::function_d06e636b(player))
	{
		self.hint_string[n_player_index] = #"";
	}
	else if(isdefined(self.stub.var_a4134e51) && !level flag::get(self.stub.var_a4134e51))
	{
		switch(self.stub.var_a4134e51)
		{
			case "open_pap":
			{
				self.hint_string[n_player_index] = #"hash_6dcacaabbe757952";
				break;
			}
			default:
			{
				self.hint_string[n_player_index] = #"hash_222289639943b061";
				break;
			}
		}
		b_result = 1;
	}
	else if(isdefined(player.var_9c7b96ed[var_8d5d092c]) && player.var_9c7b96ed[var_8d5d092c])
	{
		self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
		b_result = 1;
	}
	else if(isdefined(self.stub.delay) && !self.stub flag::get("delayed"))
	{
		self.hint_string[n_player_index] = #"hash_4be7c1bbfe9f5d86";
		b_result = 1;
	}
	else
	{
		switch(self.stub.script_string)
		{
			case "greenhouse":
			case "cemetery":
			{
				self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_34f259136740edfd", #"hash_58e6e210eddbebe3", #"hash_6de5ca8f5e14be4", #"hash_109ff9cf832cd388");
				break;
			}
			case "forest":
			{
				self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_3662e0cf1e9f6351", #"hash_54a78a5bd72eed4f", #"hash_18afd9a5deaedfe0", #"hash_538a37b473f5834c");
				break;
			}
			case "entrance_hall":
			{
				self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_65cbaa6146c8a85", #"hash_aed57a705546ebb", #"hash_471da16d5cb1956c", #"hash_276bed61279c11e0");
				break;
			}
			default:
			{
				self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
				break;
			}
		}
		b_result = 1;
	}
	return b_result;
}

/*
	Name: function_af65fe93
	Namespace: namespace_60895c83
	Checksum: 0xDD839B81
	Offset: 0x6B30
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_af65fe93(var_79bf62e6)
{
	if(!isplayer(self) || !isdefined(var_79bf62e6))
	{
		return;
	}
	str_loc = var_79bf62e6.stub.script_string;
	s_loc = struct::get(str_loc + "_end_" + namespace_c05f06c7::get_player_index(self));
	self util::create_streamer_hint(s_loc.origin, s_loc.angles, 1);
	self util::delay("fasttravel_over", "disconnect", &util::clear_streamer_hint);
}

/*
	Name: function_ae29ba0f
	Namespace: namespace_60895c83
	Checksum: 0x6B7604C6
	Offset: 0x6C30
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_ae29ba0f(player)
{
	switch(self.blueprint.name)
	{
		case "zblueprint_chaos_lvl3":
		case "zblueprint_mansion_ww_lvl2":
		{
			if(!player hasweapon(self.blueprint.components[0]) && (isdefined(self.bought) && self.bought))
			{
				self.hint_string = #"hash_64cb545dd18c607";
			}
			break;
		}
	}
}

/*
	Name: function_cda69f5e
	Namespace: namespace_60895c83
	Checksum: 0x3CF11DE6
	Offset: 0x6CF0
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_cda69f5e(player)
{
	switch(self.stub.blueprint.name)
	{
		case "zblueprint_chaos_lvl3":
		case "zblueprint_mansion_ww_lvl2":
		{
			if(!player hasweapon(self.stub.blueprint.components[0]) && (isdefined(self.stub.bought) && self.stub.bought))
			{
				return 0;
			}
			break;
		}
	}
	return 1;
}

/*
	Name: function_ee4021ea
	Namespace: namespace_60895c83
	Checksum: 0x8197DEA0
	Offset: 0x6DB8
	Size: 0x588
	Parameters: 0
	Flags: Linked
*/
function function_ee4021ea()
{
	setdvar(#"hash_44340be18f159be3", 0);
	level.var_ea32773 = &function_7f493481;
	level thread scene::init_streamer(#"hash_3f0bec2bc9216cd4", #"allies", 0, 0);
	scene::add_scene_func(#"hash_3f0bec2bc9216cd4", &function_8b76623, "play");
	scene::add_scene_func(#"hash_3f0bec2bc9216cd4", &function_9419b975, "sh195");
	scene::add_scene_func(#"hash_3f0bec2bc9216cd4", &function_4e94caa8, "sh240");
	scene::add_scene_func(#"hash_231df2f485c6e30", &function_34273b53, "play");
	scene::add_scene_func(#"hash_ab97b28f47828e9", &function_f996845d, "play");
	foreach(e_player in util::get_active_players())
	{
		e_player freezecontrols(1);
		e_player.var_16735873 = 1;
		if(e_player laststand::player_is_in_laststand())
		{
			e_player thread zm_laststand::auto_revive(e_player, 0, 0);
		}
		e_player val::set(#"outro", "takedamage", 0);
		e_player val::set(#"outro", "ignoreme", 1);
		e_player notify(#"bgb_update");
	}
	function_b7f33afa();
	level flag::clear("spawn_zombies");
	level flag::set(#"pause_round_timeout");
	level lui::screen_fade_out(1.6, "white");
	level util::delay(1.6, "end_game", &zm_utility::function_9ad5aeb1, 0, 0, 1, 0, 0);
	wait(1.6);
	level thread function_5bfd87e9();
	if(!isdefined(level.var_4b922415))
	{
		level.var_4b922415 = util::spawn_anim_model(#"hash_68e43aaeda249da8");
	}
	level.var_4b922415.targetname = "mansion_hero";
	level.var_4b922415 hide();
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	clientfield::set("" + #"hash_7fcdc47572bdbafa", 1);
	hidemiscmodels("end_igc");
	zombie_utility::clear_all_corpses();
	util::set_lighting_state(0);
	level zm_utility::create_streamer_hint((-100, -26800, -5550), (12, -39, 0), 1, 180);
	scene::play(#"hash_3f0bec2bc9216cd4");
	scene::play(#"hash_231df2f485c6e30");
	scene::play(#"hash_ab97b28f47828e9");
	scene::play(#"hash_12cf1a9d1efe9bde");
	level notify(#"end_game");
}

/*
	Name: function_7f493481
	Namespace: namespace_60895c83
	Checksum: 0xFC5D27E1
	Offset: 0x7348
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_7f493481()
{
	setdvar(#"hash_44340be18f159be3", 1);
}

/*
	Name: function_5bfd87e9
	Namespace: namespace_60895c83
	Checksum: 0xAAEA0B84
	Offset: 0x7380
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_5bfd87e9()
{
	foreach(e_player in util::get_active_players())
	{
		var_c97f5c44 = e_player getentitynumber();
		switch(var_c97f5c44)
		{
			case 0:
			{
				v_position = (-893, -603, 4);
				break;
			}
			case 1:
			{
				v_position = (-857, -547, 4);
				break;
			}
			case 2:
			{
				v_position = (-775, -547, 4);
				break;
			}
			case 3:
			{
				v_position = (-736, -604, 4);
				break;
			}
		}
		if(isdefined(v_position))
		{
			e_player dontinterpolate();
			e_player setorigin(v_position);
		}
	}
}

/*
	Name: function_b7f33afa
	Namespace: namespace_60895c83
	Checksum: 0xB7264F2E
	Offset: 0x74F8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_b7f33afa()
{
	if(isdefined(level.chests))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
		level notify(#"fire_sale_off");
		for(i = 0; i < level.chests.size; i++)
		{
			level.chests[i] zm_magicbox::hide_chest(0);
		}
	}
}

/*
	Name: function_8b76623
	Namespace: namespace_60895c83
	Checksum: 0x79C45919
	Offset: 0x7598
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_8b76623(a_ents)
{
	level lui::screen_fade_in(0.15, "white");
	foreach(e_player in util::get_active_players())
	{
		e_player freezecontrols(0);
	}
	level thread scene::init_streamer(#"hash_231df2f485c6e30", #"allies", 0, 0);
}

/*
	Name: function_9419b975
	Namespace: namespace_60895c83
	Checksum: 0x6F154B44
	Offset: 0x7690
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_9419b975(a_ents)
{
	level clientfield::set("" + #"hash_458d10e70473adfd", 1);
}

/*
	Name: function_4e94caa8
	Namespace: namespace_60895c83
	Checksum: 0x740C2E4C
	Offset: 0x76E0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_4e94caa8(a_ents)
{
	level.var_4b922415 show();
	level clientfield::set("" + #"hash_458d10e70473adfd", 0);
}

/*
	Name: function_34273b53
	Namespace: namespace_60895c83
	Checksum: 0x424AB0F
	Offset: 0x7740
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_34273b53(a_ents)
{
	level thread scene::init_streamer(#"hash_ab97b28f47828e9", #"allies", 0, 0);
}

/*
	Name: function_f996845d
	Namespace: namespace_60895c83
	Checksum: 0x9F32E6F4
	Offset: 0x7790
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_f996845d(a_ents)
{
	level thread scene::init_streamer(#"hash_12cf1a9d1efe9bde", #"allies", 0, 0);
}

/*
	Name: function_389e7c22
	Namespace: namespace_60895c83
	Checksum: 0x4E3E8E2C
	Offset: 0x77E0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_389e7c22(var_404e4288, var_8dd554ee)
{
	ai = namespace_977da60::function_47a88a0c(1, undefined, 1);
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_c8ce0a17
	Namespace: namespace_60895c83
	Checksum: 0x8086155B
	Offset: 0x7848
	Size: 0x158
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	if(math::cointoss())
	{
		var_6095c0b6 = namespace_a28acff3::function_4e8157cd(var_404e4288, var_8dd554ee);
		if(isalive(var_6095c0b6.ai_spawned))
		{
			namespace_3fffba66::function_d2374144(var_6095c0b6.ai_spawned, array::random(array(#"hash_78ca8e8e6bdbc8ab", #"hash_266b62e342076a90", #"hash_5cfa99582cc66c59", #"hash_5d6b55906fc82ff2")));
		}
		return 1;
	}
	var_950c7b6b = 0;
	if(math::cointoss(20))
	{
		var_950c7b6b = 1;
	}
	ai = namespace_2fa8319f::function_74f25f8a(0, undefined, var_950c7b6b);
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return 1;
}

/*
	Name: function_ff767eac
	Namespace: namespace_60895c83
	Checksum: 0xCEA50082
	Offset: 0x79B0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_ff767eac()
{
	level endon(#"end_game");
	level flag::wait_till("connect_foyer_end_to_grand_staircase");
	level flag::set("connect_start_east_to_foyer_floor2_east");
	level flag::set("connect_start_west_to_foyer_floor2_west");
}

/*
	Name: function_d4ff1dd6
	Namespace: namespace_60895c83
	Checksum: 0x11E9BDE3
	Offset: 0x7A30
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_d4ff1dd6(waitresult)
{
	/#
		if(waitresult.activator.health <= 0)
		{
			iprintlnbold("" + waitresult.activator.origin);
		}
	#/
}

/*
	Name: devgui_setup
	Namespace: namespace_60895c83
	Checksum: 0xDF93CE42
	Offset: 0x7A98
	Size: 0xE4C
	Parameters: 0
	Flags: None
*/
function devgui_setup()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_3f147b12);
		if(zm_utility::function_e51dc2d8())
		{
			adddebugcommand("");
			adddebugcommand("");
		}
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		wait(0.5);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		wait(0.5);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		wait(0.5);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		wait(0.5);
		if(zm_utility::function_e51dc2d8())
		{
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
		}
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_3f147b12
	Namespace: namespace_60895c83
	Checksum: 0xE0DD620A
	Offset: 0x88F0
	Size: 0x2572
	Parameters: 1
	Flags: None
*/
function function_3f147b12(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_3f7ea542adb3e296":
			{
				level thread open_sesame();
				return 1;
				break;
			}
			case "hash_50d92ca3c6c7c2a8":
			{
				level open_sesame();
				function_1aba9a64();
				level notify(#"hash_2588983e2be22ca5");
				level thread namespace_bfa7c2ed::function_b9289f93();
				level thread namespace_ee206246::function_f2dd8601(#"hash_4c0e5e4b34877996", 1);
				level thread namespace_ee206246::function_f2dd8601(#"hash_65636bbec86da22c", 1);
				level thread namespace_ee206246::function_f2dd8601(#"hash_4ca89643d74ccffb", 1);
				break;
			}
			case "hash_7913b71a1f12913a":
			{
				level thread namespace_bfa7c2ed::function_b9289f93();
				break;
			}
			case "open_pap":
			{
				function_1aba9a64();
				return 1;
				break;
			}
			case "hash_41301a1e09c42bf":
			case "hash_3ba92f19a63db88a":
			case "hash_4b566bfdbd45465e":
			case "hash_5c799ac70a138764":
			{
				function_a8dfebca(cmd);
				break;
			}
			case "hash_66c794063cfbe16b":
			{
				level.var_573d960c = undefined;
				break;
			}
			case "hash_7010e0191ddfd71e":
			{
				level.players[0] giveweapon(level.var_f086136b);
				break;
			}
			case "hash_7010df191ddfd56b":
			{
				level.players[0] giveweapon(level.var_6fe89212);
				level notify(#"hash_24c45fc7880ee4f0");
				break;
			}
			case "hash_7010de191ddfd3b8":
			{
				level.players[0] giveweapon(level.var_7b9ca97a);
				level notify(#"hash_4b7b4119989a60ef");
				break;
			}
			case "hash_7defe9dc837ecdb7":
			{
				level.var_573d960c = 0;
				break;
			}
			case "hash_49ae48ac61695b43":
			{
				level.var_573d960c = 3;
				break;
			}
			case "hash_3c30825a658c87fd":
			{
				level.var_573d960c = 2;
				break;
			}
			case "hash_1ff61dc18e3fe8c":
			{
				level.var_573d960c = 1;
				break;
			}
			case "hash_61784dca9e1bb496":
			{
				level flag::set("");
				break;
			}
			case "hash_265294215e19c2c1":
			{
				level flag::set("");
				break;
			}
			case "hash_64431ba102b7be4c":
			{
				level flag::set("");
				break;
			}
			case "hash_1e2d878115c34df1":
			{
				level flag::set("");
				break;
			}
			case "hash_7143ffe29e3ae202":
			{
				level flag::set("");
				break;
			}
			case "hash_50721510760870d3":
			{
				level flag::set("");
				break;
			}
			case "hash_38316c2c32e062e1":
			{
				zm_devgui::zombie_devgui_goto_round(level.var_abe2c289);
				break;
			}
			case "hash_bb64387472f6f70":
			{
				zm_devgui::zombie_devgui_goto_round(level.var_5657e981);
				break;
			}
			case "hash_32a1dfdaac71530":
			{
				zm_devgui::zombie_devgui_goto_round(level.var_83b4d39);
				break;
			}
			case "hash_4d26340ade7eef62":
			{
				foreach(player in level.players)
				{
					player namespace_d0842c8b::function_4e849ab();
				}
				break;
			}
			case "hash_7555d593aa74da8a":
			{
				var_1dfad0cc = namespace_a1d9b01d::function_4c2f8683("");
				var_627759fc = namespace_a1d9b01d::function_4c2f8683("");
				var_66ba6282 = namespace_a1d9b01d::function_4c2f8683("");
				var_38f98701 = namespace_a1d9b01d::function_4c2f8683("");
				level.players[0] giveweapon(var_1dfad0cc);
				level.players[0] giveweapon(var_627759fc);
				level.players[0] giveweapon(var_66ba6282);
				level.players[0] giveweapon(var_38f98701);
				break;
			}
			case "hash_b5647815560c6c6":
			{
				level.var_940ee624 = 100;
				level namespace_6747c550::function_7df6bb60(#"hash_379a0cb8e272c259", 1);
				level namespace_6747c550::function_7df6bb60(#"hash_379a09b8e272bd40", 1);
				level namespace_6747c550::function_7df6bb60(#"hash_379a0ab8e272bef3", 1);
				break;
			}
			case "hash_5a3bd6ce89f5f995":
			{
				if(level flag::exists(""))
				{
					level flag::set("");
				}
				break;
			}
			case "hash_7af3cd7329aacc60":
			{
				level.var_14a33fde = 1;
				break;
			}
			case "hash_36303c699ab54dd3":
			{
				level flag::clear(#"hash_2287cf5d6310237e");
				break;
			}
			case "hash_682ea0da80525b64":
			{
				level flag::set("");
				break;
			}
			case "hash_5e5988c329d7cffe":
			{
				level notify(#"hash_348748d248801d6b");
				break;
			}
			case "hash_692c555ad0747a7c":
			{
				bat::function_2e37549f(1, undefined);
				break;
			}
			case "hash_627749f1d7a46328":
			{
				if(isdefined(level.zm_loc_types[#"werewolf_location"]) && level.zm_loc_types[#"werewolf_location"].size > 0)
				{
					s_spawn = array::random(level.zm_loc_types[#"werewolf_location"]);
					namespace_977da60::function_47a88a0c(1, undefined, 1, s_spawn);
				}
				break;
			}
			case "hash_5bf31fb6caf6eac5":
			{
				namespace_977da60::function_47a88a0c(1, undefined, 1);
				break;
			}
			case "hash_141442e4fca71a1d":
			{
				namespace_c402654::function_62db7b1c(1, undefined);
				break;
			}
			case "hash_50f5df2c61fab9c0":
			{
				namespace_2fa8319f::function_74f25f8a(1, undefined);
				break;
			}
			case "hash_737d2d8656f8cee":
			{
				namespace_2fa8319f::function_74f25f8a(1, undefined, 1);
				break;
			}
			case "hash_62387515007c880":
			{
				level.var_dd0ec1fe rotateto(level.var_dd0ec1fe.v_start, 1);
				level.var_dd0ec1fe waittill(#"rotatedone");
				level.var_7ff4f03a.angles rotateto(level.var_7ff4f03a.v_start, 1);
				level.var_7ff4f03a waittill(#"rotatedone");
				level.var_6ce9da5c.angles rotateto(level.var_6ce9da5c.v_start, 1);
				level.var_6ce9da5c waittill(#"rotatedone");
				break;
			}
			case "hash_314962c418b83370":
			{
				level flag::set("");
				break;
			}
			case "hash_9d9c5e54ae57d6":
			{
				level.players[0] giveweapon(level.var_3891e803);
				break;
			}
			case "hash_77792be9b7f894df":
			{
				foreach(player in level.players)
				{
					player giveweapon(level.var_3891e803);
				}
				break;
			}
			case "hash_2b311f89b1f9483a":
			{
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				break;
			}
			case "hash_51d8ec3895703755":
			{
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
			}
			case "hash_7b299dd5674009bb":
			{
				var_99a245 = getent("", "");
				var_d8f56b29 = getent("", "");
				var_aa527474 = getent("", "");
				var_99a245 magicgrenadetype(getweapon(#"hash_34b7eb9fde56bd35"), var_99a245.origin + vectorscale((0, 0, 1), 24), (0, 0, 1), 0.1);
				var_d8f56b29 magicgrenadetype(getweapon(#"hash_34b7eb9fde56bd35"), var_d8f56b29.origin + vectorscale((0, 0, 1), 24), (0, 0, 1), 0.1);
				var_aa527474 magicgrenadetype(getweapon(#"hash_34b7eb9fde56bd35"), var_aa527474.origin + vectorscale((0, 0, 1), 24), (0, 0, 1), 0.1);
				if(cmd !== "")
				{
					break;
				}
				wait(1);
			}
			case "hash_369a377d29f023e4":
			{
				var_8d9148db = [];
				if(!isdefined(var_8d9148db))
				{
					var_8d9148db = [];
				}
				else if(!isarray(var_8d9148db))
				{
					var_8d9148db = array(var_8d9148db);
				}
				var_8d9148db[var_8d9148db.size] = getent("", "");
				if(!isdefined(var_8d9148db))
				{
					var_8d9148db = [];
				}
				else if(!isarray(var_8d9148db))
				{
					var_8d9148db = array(var_8d9148db);
				}
				var_8d9148db[var_8d9148db.size] = getent("", "");
				if(!isdefined(var_8d9148db))
				{
					var_8d9148db = [];
				}
				else if(!isarray(var_8d9148db))
				{
					var_8d9148db = array(var_8d9148db);
				}
				var_8d9148db[var_8d9148db.size] = getent("", "");
				spawners = getspawnerarray("", "");
				foreach(stone in var_8d9148db)
				{
					spawner = array::random(spawners);
					spawner.script_forcespawn = 1;
					ai = zombie_utility::spawn_zombie(spawner);
					if(isai(ai))
					{
						ai forceteleport(stone.origin, stone.angles);
						waitframe(1);
						ai kill(ai.origin, level.players[0]);
					}
				}
				break;
			}
			case "hash_36298237b468465":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_22d9fdee453c7ffd":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_9b8b2bde7077b5d":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_114557ff111b0d23":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_701981ede51fb6a3":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_59233024a82f6a3":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_1d2f70e6617bd429":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_4819b6f7db3eb7d9":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_68a7b05b1e1aabd9":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_413d5b18f5751f8a":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_6018399b26a3112c":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_4485a0ddf8eb649d":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_13c626edcb44fdf0":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_22e2f365e2153202":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_3d1b999a9efe068f":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_3c7ca5099e1d1256":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_15abb94c74e59368":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_1df86acdb45b3a61":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_c73cd1cb76ef466":
			{
				level thread function_cdb82bab();
				break;
			}
			case "hash_67005c00c89e63c9":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_67005900c89e5eb0":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_67005a00c89e6063":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_67005f00c89e68e2":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_62d142021a0c6a13":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_62d143021a0c6bc6":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_62d144021a0c6d79":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_62d145021a0c6f2c":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_6154a32fbbcf2a8d":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_6154a02fbbcf2574":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_6154a12fbbcf2727":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_61549e2fbbcf220e":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_5b857bd9fbf0f6d9":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_6f622b829db8e60c":
			{
				level.var_426fec.var_1ed09409 = "";
				level.var_426fec.str_hint = "";
				break;
			}
			case "hash_e3411c7ce19a133":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_720c2222cca24e72":
			{
				level.var_2ff50a.var_1ed09409 = "";
				level.var_2ff50a.str_hint = "";
				break;
			}
			case "hash_32551178b04964b5":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_af8eded21ec9f40":
			{
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				break;
			}
			case "hash_4014ef26303c0251":
			{
				level flag::set("");
				break;
			}
			case "hash_79839f0e8f87465":
			{
				if(isdefined(level.var_5c086e54))
				{
					level.var_5c086e54[0] = level.var_d181080c[0].script_int;
					level.var_5c086e54[1] = level.var_d181080c[1].script_int;
					level.var_5c086e54[2] = level.var_d181080c[2].script_int;
					level flag::set("");
				}
				break;
			}
			case "hash_558fa735338f60d9":
			{
				level flag::set(#"hash_2d21160da504fb1");
				level flag::set(#"hash_1abd4da28f5bc572");
				level flag::set(#"hash_10693cfc20e83df1");
				break;
			}
			case "hash_158be57bab31a1fd":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_15125cf53616f2ab":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_63a191ef9ddff6a1":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_4cae1f6081a88091":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_39764bcce49b936d":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_68da4019022ea82a":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_519759be1fb9f671":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_392566928f90f17":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_1ed2c1cfc4d8f32":
			{
				level.var_584c4114 = getvehiclenode("", "");
				level.var_7ccd6341.var_1ed09409 = "";
				level.var_7ccd6341.str_hint = "";
				level.var_bc07224f = 1;
				level.var_d4fada4a = 1;
				level.var_71561996 = 1;
				level thread open_sesame();
				break;
			}
			case "hash_575338253fb36c2":
			{
				function_a72077f8();
				break;
			}
			case "hash_6c540109ff20f86d":
			{
				level.var_d698a430 = 1;
				break;
			}
			case "hash_1fd93602bc1b246d":
			{
				level thread function_2527ee2d();
				break;
			}
			case "hash_5838dc9777787d3d":
			{
				function_ed41e7ca();
				break;
			}
			case "hash_4cb3ec4adfa4a708":
			{
				level thread function_6802b9c8();
				break;
			}
			case "hash_42f5013f7892233e":
			{
				level thread function_7a1bd36c();
				break;
			}
			case "hash_18e5378066aedefa":
			case "hash_7c40bb2e7b0d29cc":
			{
				level thread function_e907bb3d(cmd);
				break;
			}
			case "hash_2bf9bc30e54a1470":
			{
				level thread function_ae21a5ee();
				break;
			}
			case "hash_59e2caf7a91feffb":
			{
				level flag::set("");
				break;
			}
			case "hash_54603db1db9f5ec5":
			{
				level flag::set("");
				break;
			}
			case "hash_2540786a5e16c895":
			{
				level flag::set("");
				break;
			}
			case "hash_77191ec75f0d58a9":
			{
				level scene::init_streamer(#"hash_3f0bec2bc9216cd4", #"allies", 0, 0);
				level thread function_ee4021ea();
				break;
			}
			case "hash_100d3e9a512de314":
			case "hash_2b5e2a1e2bb301d1":
			{
				function_d7bc714e(cmd);
				break;
			}
			case "hash_3dcf262f16faced0":
			{
				var_cbd5530c = getdvarint(#"hash_3dcf262f16faced0", 0);
				setdvar(#"hash_3dcf262f16faced0", !var_cbd5530c);
				break;
			}
		}
	#/
}

/*
	Name: open_sesame
	Namespace: namespace_60895c83
	Checksum: 0xF15EFFA
	Offset: 0xAE70
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function open_sesame()
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread scene::play("", "");
		level thread function_de344348();
		level flag::set("");
		level flag::set("");
	#/
}

/*
	Name: function_a8dfebca
	Namespace: namespace_60895c83
	Checksum: 0xCD693062
	Offset: 0xAFB8
	Size: 0x20A
	Parameters: 1
	Flags: None
*/
function function_a8dfebca(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_5c799ac70a138764":
			{
				level flag::set("");
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a9a7abf4d516", 1);
				break;
			}
			case "hash_4b566bfdbd45465e":
			{
				level flag::set("");
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a8a7abf4d363", 1);
				break;
			}
			case "hash_3ba92f19a63db88a":
			{
				level flag::set("");
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a7a7abf4d1b0", 1);
				break;
			}
			default:
			{
				level flag::set("");
				level flag::set("");
				level flag::set("");
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a9a7abf4d516", 1);
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a8a7abf4d363", 1);
				level namespace_6747c550::function_7df6bb60(#"hash_1dd7a7a7abf4d1b0", 1);
			}
		}
	#/
}

/*
	Name: function_1aba9a64
	Namespace: namespace_60895c83
	Checksum: 0x43D4B23D
	Offset: 0xB1D0
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function function_1aba9a64()
{
	/#
		var_b49229c2 = struct::get("");
		function_a8dfebca("");
		level thread scene::play(#"hash_79dc3cec0f9c544f", "");
		level thread scene::play(#"hash_79dc3cec0f9c544f", "");
		level thread scene::play(#"hash_79dc3cec0f9c544f", "");
		level flag::set("");
		level flag::set("");
		level flag::set("");
		zm_unitrigger::unregister_unitrigger(var_b49229c2.var_47323b73);
	#/
}

/*
	Name: function_a72077f8
	Namespace: namespace_60895c83
	Checksum: 0xC8700295
	Offset: 0xB310
	Size: 0x166
	Parameters: 0
	Flags: None
*/
function function_a72077f8()
{
	/#
		foreach(ai_zombie in getaiteamarray(#"axis"))
		{
			if(!isdefined(ai_zombie.var_3f5addd0))
			{
				if(isalive(ai_zombie) && isdefined(ai_zombie.archetype) && (ai_zombie.archetype == #"zombie" || ai_zombie.archetype == #"hash_50f4e0eea9f4e4a4" || ai_zombie.archetype == #"zombie_dog"))
				{
					ai_zombie clientfield::set("" + #"hash_1d0080ad80fd0913", 1);
					ai_zombie.var_3f5addd0 = 1;
				}
			}
		}
	#/
}

/*
	Name: function_2527ee2d
	Namespace: namespace_60895c83
	Checksum: 0xBE35BC3F
	Offset: 0xB480
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function function_2527ee2d()
{
	/#
		level endon(#"end_game", #"hash_59a4398b145082a");
		level flag::wait_till("");
		if(isdefined(level.players[0].var_88c7d6c3) && level.players[0].var_88c7d6c3)
		{
			return;
		}
		namespace_b8f22955::function_9e7129d2(level.players[0]);
		level.players[0].var_88c7d6c3 = 0;
	#/
}

/*
	Name: function_ed41e7ca
	Namespace: namespace_60895c83
	Checksum: 0x2B369FA5
	Offset: 0xB538
	Size: 0xF4
	Parameters: 0
	Flags: None
*/
function function_ed41e7ca()
{
	/#
		if(isdefined(level.var_956b1da3) && isdefined(level.var_ad214ed0))
		{
			level.var_956b1da3.origin = level.var_ad214ed0.origin;
			return;
		}
		level.var_ad214ed0 = util::spawn_model("", level.players[0].origin);
		level.var_956b1da3 = util::spawn_model("", vectorscale((1, 1, 1), 100000));
		level.var_ad214ed0 thread namespace_b8f22955::function_d409a74f(level.var_956b1da3);
		level.var_ad214ed0 thread namespace_b8f22955::function_c9c7a593();
	#/
}

/*
	Name: function_cdb82bab
	Namespace: namespace_60895c83
	Checksum: 0x180C2D2C
	Offset: 0xB638
	Size: 0x218
	Parameters: 0
	Flags: None
*/
function function_cdb82bab()
{
	/#
		level notify(#"hash_48ee29312bd2ad06");
		level endon(#"hash_48ee29312bd2ad06");
		var_8f129c8e = [];
		if(!isdefined(var_8f129c8e))
		{
			var_8f129c8e = [];
		}
		else if(!isarray(var_8f129c8e))
		{
			var_8f129c8e = array(var_8f129c8e);
		}
		var_8f129c8e[var_8f129c8e.size] = getent("", "");
		if(!isdefined(var_8f129c8e))
		{
			var_8f129c8e = [];
		}
		else if(!isarray(var_8f129c8e))
		{
			var_8f129c8e = array(var_8f129c8e);
		}
		var_8f129c8e[var_8f129c8e.size] = getent("", "");
		if(!isdefined(var_8f129c8e))
		{
			var_8f129c8e = [];
		}
		else if(!isarray(var_8f129c8e))
		{
			var_8f129c8e = array(var_8f129c8e);
		}
		var_8f129c8e[var_8f129c8e.size] = getent("", "");
		level thread function_89244213(var_8f129c8e);
		do
		{
			array::thread_all(var_8f129c8e, &namespace_b8f22955::function_1a82ca71, undefined, 0);
			array::wait_till(var_8f129c8e, "");
			wait(1.5);
		}
		while(getdvarint(#"hash_2340f8cb271f85fd", 0));
		level notify(#"hash_48ee29312bd2ad06");
	#/
}

/*
	Name: function_89244213
	Namespace: namespace_60895c83
	Checksum: 0x5B1B4851
	Offset: 0xB858
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_89244213(var_8f129c8e)
{
	/#
		level endon(#"hash_48ee29312bd2ad06");
		while(isdefined(1))
		{
			wait(2);
			array::thread_all(var_8f129c8e, &clientfield::set, "" + #"hash_47b8db8cde2c4291", 13);
			wait(2);
			level notify(#"hash_5a23f461b8ae05a4");
			wait(2);
			array::thread_all(var_8f129c8e, &clientfield::set, "" + #"hash_47b8db8cde2c4291", 0);
		}
	#/
}

/*
	Name: function_6802b9c8
	Namespace: namespace_60895c83
	Checksum: 0x231AC081
	Offset: 0xB930
	Size: 0x1F4
	Parameters: 0
	Flags: None
*/
function function_6802b9c8()
{
	/#
		var_382cf0d = [];
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		array::thread_all(var_382cf0d, &clientfield::set, "" + #"hash_11eb6b7dc7db71ad", 1);
	#/
}

/*
	Name: function_7a1bd36c
	Namespace: namespace_60895c83
	Checksum: 0x3C63BF26
	Offset: 0xBB30
	Size: 0x1F4
	Parameters: 0
	Flags: None
*/
function function_7a1bd36c()
{
	/#
		var_382cf0d = [];
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		if(!isdefined(var_382cf0d))
		{
			var_382cf0d = [];
		}
		else if(!isarray(var_382cf0d))
		{
			var_382cf0d = array(var_382cf0d);
		}
		var_382cf0d[var_382cf0d.size] = getent("", "");
		array::thread_all(var_382cf0d, &clientfield::set, "" + #"hash_11eb6b7dc7db71ad", 0);
	#/
}

/*
	Name: function_e907bb3d
	Namespace: namespace_60895c83
	Checksum: 0x6E6BF797
	Offset: 0xBD30
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_e907bb3d(cmd)
{
	/#
		if(cmd == "")
		{
			array::thread_all(level.activeplayers, &clientfield::set, "" + #"hash_49de76d6c4f95e5d", 0);
			return;
		}
		array::thread_all(level.activeplayers, &clientfield::set, "" + #"hash_49de76d6c4f95e5d", 1);
	#/
}

/*
	Name: function_ae21a5ee
	Namespace: namespace_60895c83
	Checksum: 0x58274CAD
	Offset: 0xBDE8
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function function_ae21a5ee(cmd)
{
	/#
		foreach(ai in getaiteamarray(#"axis"))
		{
			if(isalive(ai) && ai.archetype === #"zombie")
			{
				ai clientfield::set("" + #"hash_48a4712e85ec8fcc", 1);
			}
		}
	#/
}

/*
	Name: function_d7bc714e
	Namespace: namespace_60895c83
	Checksum: 0x79437C8E
	Offset: 0xBEE8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_d7bc714e(cmd)
{
	/#
		if(cmd == "")
		{
			level thread namespace_9d27962b::function_93eab559();
			return;
		}
		level clientfield::set("" + #"hash_42e03f9ae74a1070", 0);
	#/
}

