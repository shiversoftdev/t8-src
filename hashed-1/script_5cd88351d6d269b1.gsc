// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1479b2205c2a8ccd;
#using script_1a970b4b3bc5fb3a;
#using script_1fd1a25536bc59cf;
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_48586eea5c3542a4;
#using script_493d9b5ad424cee7;
#using script_4b80fc97d8469299;
#using script_4ec1d631174f7283;
#using script_57f7003580bb15e0;
#using script_5a4c716662b66a50;
#using script_5bb072c3abf4652c;
#using script_5c6694d7aa0f1490;
#using script_5e177698fdcdbe2c;
#using script_61a734c95edc17aa;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6f35f7919b97e062;
#using script_7bc1d63f5e0e027;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_ec1f72a0;

/*
	Name: preload
	Namespace: namespace_ec1f72a0
	Checksum: 0x106A5391
	Offset: 0x298
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_45e52e8a::preload();
	namespace_c52ee24f::preload();
	namespace_ff7e4f08::preload();
	namespace_1a68a5da::preload();
	namespace_4b68b2b3::preload();
	namespace_bfc8ee03::preload();
	namespace_13b4b4b::preload();
	clientfield::register("toplayer", "" + #"hash_668f474410d5c1d0", 24000, 1, "int");
}

/*
	Name: main
	Namespace: namespace_ec1f72a0
	Checksum: 0x6AF85D
	Offset: 0x358
	Size: 0x7FC
	Parameters: 0
	Flags: Linked
*/
function main()
{
	namespace_45e52e8a::main();
	namespace_c52ee24f::main();
	namespace_ff7e4f08::main();
	namespace_1a68a5da::main();
	namespace_4b68b2b3::main();
	namespace_bfc8ee03::main();
	namespace_13b4b4b::init();
	level flag::init("sam_music_done");
	level flag::init(#"hash_18b94410e3b6b0bf");
	namespace_ee206246::register(#"main_quest", #"hash_86e283359f19a5f", #"hash_269c18969e47568f", &namespace_45e52e8a::function_77ed3bab, &namespace_45e52e8a::function_51ecc801);
	namespace_ee206246::register(#"main_quest", #"hash_467104204a4803ad", #"hash_269c19969e475842", &namespace_c52ee24f::function_a5254494, &namespace_c52ee24f::function_77e4073b);
	namespace_ee206246::register(#"main_quest", #"hash_7c16d3a3e4250b9a", #"hash_269c1a969e4759f5", &namespace_ff7e4f08::function_8d43b840, &namespace_ff7e4f08::function_2d9e1e29);
	namespace_ee206246::register(#"main_quest", #"hash_2dfcd4264b2c2340", #"hash_269c13969e474e10", &namespace_1a68a5da::function_13dda28a, &namespace_1a68a5da::function_a874e5d0);
	namespace_ee206246::register(#"main_quest", #"hash_c2e45a40a675911", #"hash_269c14969e474fc3", &namespace_f7a40df8::function_d878e1ee, &namespace_f7a40df8::function_9ee4c8c3);
	namespace_ee206246::register(#"main_quest", #"hash_72bc0ec65f4afcca", #"hash_6289c5eef32eca15", &namespace_55999fe::function_742dfdb5, &namespace_55999fe::function_9e34b0d4);
	namespace_ee206246::register(#"main_quest", #"hash_28c88f40ace27a7b", #"hash_6289c2eef32ec4fc", &namespace_55999fe::function_c723e684, &namespace_55999fe::function_3d5a45fb);
	namespace_ee206246::register(#"main_quest", #"hash_382d731d4de07ed3", #"hash_269c16969e475329", &namespace_ff7e4f08::function_8d43b840, &namespace_ff7e4f08::function_2d9e1e29);
	namespace_ee206246::register(#"main_quest", #"hash_2c00866b95e17ff5", #"hash_269c1f969e476274", &namespace_1a68a5da::function_13dda28a, &namespace_1a68a5da::function_a874e5d0);
	namespace_ee206246::register(#"main_quest", #"hash_ebca448700872b8", #"hash_62afa5eef34f62f2", &namespace_4b68b2b3::function_1faf4b9, &namespace_4b68b2b3::function_a8748143);
	namespace_ee206246::register(#"main_quest", #"hash_810019231f11ea1", #"hash_62afa4eef34f613f", &namespace_4b68b2b3::function_91fbb734, &namespace_4b68b2b3::function_c2898bf0);
	namespace_ee206246::register(#"main_quest", #"hash_11c4f1ecb0dd5a34", #"hash_629486eef338668d", &namespace_ff7e4f08::function_8d43b840, &namespace_ff7e4f08::function_2d9e1e29);
	namespace_ee206246::register(#"main_quest", #"hash_d0bf3cf30a07a84", #"hash_629485eef33864da", &namespace_1a68a5da::function_13dda28a, &namespace_1a68a5da::function_a874e5d0);
	namespace_ee206246::register(#"main_quest", #"hash_13b9abe1bd17294c", #"hash_629484eef3386327", &namespace_4b68b2b3::function_816c3132, &namespace_4b68b2b3::function_3c9be590);
	namespace_ee206246::register(#"main_quest", #"hash_7d78cef11f6afb5e", #"hash_629483eef3386174", &namespace_bfc8ee03::function_5309464a, &namespace_bfc8ee03::function_ae270d9e);
	namespace_ee206246::register(#"main_quest", #"hash_2bd81e2b05fccbed", #"hash_629482eef3385fc1", &namespace_13b4b4b::function_5309464a, &namespace_13b4b4b::function_ae270d9e);
	namespace_ee206246::register(#"main_quest", #"hash_49b41abaa9addedd", #"hash_629481eef3385e0e", &function_d4147875, &function_895265b1, 1);
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_93a140f7();
	}
	level.var_d1cf60c8 = getentarray("loc_outro_vo", "targetname");
	foreach(loc in level.var_d1cf60c8)
	{
		loc hide();
	}
	level thread function_fe09cd56();
}

/*
	Name: function_93a140f7
	Namespace: namespace_ec1f72a0
	Checksum: 0x370C2DA8
	Offset: 0xB60
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_93a140f7()
{
	level endon(#"end_game");
	while(level.var_a43a746d < 2)
	{
		wait(2);
	}
	namespace_ee206246::start(#"main_quest");
}

/*
	Name: function_cb512dd4
	Namespace: namespace_ec1f72a0
	Checksum: 0x7E8FD85C
	Offset: 0xBC8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_cb512dd4(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		wait(10);
	}
}

/*
	Name: function_f615b0f
	Namespace: namespace_ec1f72a0
	Checksum: 0x5D10585F
	Offset: 0xBF0
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_f615b0f(var_5ea5c94d, ended_early)
{
}

/*
	Name: play_outro
	Namespace: namespace_ec1f72a0
	Checksum: 0xD2933143
	Offset: 0xC10
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function play_outro()
{
	a_e_players = getplayers();
	if(a_e_players.size > 1)
	{
		foreach(e_player in a_e_players)
		{
			if(e_player laststand::player_is_in_laststand())
			{
				e_player thread zm_laststand::auto_revive(e_player);
			}
		}
		array::thread_all(a_e_players, &zm_player::spectator_respawn_player);
	}
	namespace_509a75d1::function_3c173d37();
	level zm_audio::sndvoxoverride(1);
	lui::play_movie(#"hash_13e1b680be72dcd3", "fullscreen", 1, 0, 0, #"hash_1d54dda4d1e82bc3", undefined, 0);
}

/*
	Name: function_d4147875
	Namespace: namespace_ec1f72a0
	Checksum: 0x122AB0FC
	Offset: 0xD68
	Size: 0x684
	Parameters: 1
	Flags: Linked
*/
function function_d4147875(var_5ea5c94d)
{
	namespace_509a75d1::function_314447b(1, 0);
	namespace_db48768d::function_b1c6d4f2();
	level flag::set(#"hold_round_end");
	level thread play_outro();
	wait(320);
	/#
		println("");
	#/
	level thread lui::screen_flash(0.2, 7, 7, 1, "black");
	wait(0.3);
	level.var_583a0efc = function_4d1e7b48(#"hash_13e1b680be72dcd3");
	/#
		println("");
	#/
	function_b0fc5631();
	veh_start = getvehiclenode("mq_gehen_01", "targetname");
	veh_end = getvehiclenode("mq_gehen_02", "targetname");
	/#
		println("");
	#/
	sam_spawner = getent("mq_gehen_s", "targetname");
	level.sam = sam_spawner spawnfromspawner("sam", 1);
	level.sam.team = #"allies";
	util::magic_bullet_shield(level.sam);
	eddie_spawner = getent("mq_gehen_e", "targetname");
	eddie = eddie_spawner spawnfromspawner("eddie", 1);
	eddie.team = #"allies";
	util::magic_bullet_shield(eddie);
	waitframe(1);
	/#
		println("");
	#/
	namespace_3b9dec72::function_1c989dc4();
	/#
		println("");
	#/
	namespace_db48768d::function_e9f6e0f7();
	/#
		println("");
	#/
	array::thread_all(level.var_d1cf60c8, &function_74963add);
	/#
		println("");
	#/
	a_e_players = getplayers();
	n_player = 1;
	foreach(player in a_e_players)
	{
		player.var_c5e36086 = 1;
		player thread function_c40f70df(n_player);
		n_player++;
	}
	wait(1);
	/#
		println("");
	#/
	namespace_3b9dec72::function_303ab700();
	/#
		println("");
	#/
	level.var_9441bf02 = spawn("script_origin", (0, 0, 0));
	level.var_9441bf02 playloopsound(#"hash_503b99b370ac70b9");
	/#
		println("");
	#/
	wait(5);
	/#
		println("");
	#/
	level.musicsystemoverride = 1;
	music::setmusicstate("sam_eddie_walk");
	thread music_watcher();
	/#
		println("");
	#/
	while(true)
	{
		waitframe(1);
		_attack_barrier_sprint = vectornormalize(veh_end.origin - level.sam.origin);
		var_7d910a84 = vectordot(_attack_barrier_sprint, anglestoforward(level.sam.angles));
		if(var_7d910a84 < 0)
		{
			break;
		}
	}
	namespace_3b9dec72::function_10add6a8();
	namespace_3b9dec72::function_ddbe2dbb(1000);
	wait(5);
	level thread lui::screen_flash(10, 30, 5, 1, "white");
	while(!flag::get("sam_music_done"))
	{
		wait(0.5);
	}
	wait(8);
}

/*
	Name: music_watcher
	Namespace: namespace_ec1f72a0
	Checksum: 0x1E20AC38
	Offset: 0x13F8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function music_watcher()
{
	wait(120);
	level flag::set(#"sam_music_done");
}

/*
	Name: function_895265b1
	Namespace: namespace_ec1f72a0
	Checksum: 0x2F262384
	Offset: 0x1430
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function function_895265b1(var_5ea5c94d, ended_early)
{
	namespace_e9563b61::function_ea67bd7c();
	level.var_9441bf02 delete();
	level.musicsystemoverride = 0;
	music::setmusicstate("none");
	wait(2);
	level notify(#"end_game");
}

/*
	Name: function_74963add
	Namespace: namespace_ec1f72a0
	Checksum: 0x5E723729
	Offset: 0x14B8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_74963add()
{
	while(true)
	{
		waitframe(1);
		_attack_barrier_sprint = vectornormalize(self.origin - level.sam.origin);
		var_7d910a84 = vectordot(_attack_barrier_sprint, anglestoforward(level.sam.angles));
		if(var_7d910a84 < 0)
		{
			break;
		}
	}
	playsoundatposition(self.script_string, self.origin);
}

/*
	Name: function_b0fc5631
	Namespace: namespace_ec1f72a0
	Checksum: 0xE5427B87
	Offset: 0x1580
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_b0fc5631()
{
	foreach(player in getplayers())
	{
		player function_e0c7d69(0);
		player allowcrouch(0);
		player thread function_b20c4898();
		player clientfield::set_to_player("" + #"hash_668f474410d5c1d0", 1);
		player val::set(#"gehen", "disable_weapons", 1);
	}
}

/*
	Name: function_33e15dfb
	Namespace: namespace_ec1f72a0
	Checksum: 0x60208315
	Offset: 0x16A8
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function function_33e15dfb()
{
	foreach(player in getplayers())
	{
		player function_e0c7d69(1);
		player allowcrouch(1);
		player clientfield::set_to_player("" + #"hash_668f474410d5c1d0", 0);
	}
}

/*
	Name: function_b20c4898
	Namespace: namespace_ec1f72a0
	Checksum: 0x6C538B3F
	Offset: 0x1780
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_b20c4898()
{
	level endon(#"end_game");
	self endon(#"death");
	while(true)
	{
		self status_effect::status_effect_apply(level.var_583a0efc, undefined, self, 0);
		wait(30);
	}
}

/*
	Name: function_c40f70df
	Namespace: namespace_ec1f72a0
	Checksum: 0x48EDD3E
	Offset: 0x17F0
	Size: 0x354
	Parameters: 1
	Flags: Linked
*/
function function_c40f70df(var_21c1ba1)
{
	level endon(#"end_game");
	self endon(#"death");
	/#
		println(("" + var_21c1ba1) + "");
	#/
	self bgb::suspend_weapon_cycling();
	self namespace_7d0afffb::function_ac9cb612(1);
	self util::magic_bullet_shield();
	self allowsprint(0);
	self allowcrouch(0);
	self allowprone(0);
	self allowmelee(0);
	self allowads(0);
	self hide();
	w_current = self getcurrentweapon();
	if(w_current.name == #"ww_tesla_sniper_t8" || w_current.name == #"ww_tesla_sniper_upgraded_t8")
	{
		self zm_weapons::weapon_give(level.weaponzmfists, 1);
	}
	waitframe(1);
	/#
		println(("" + var_21c1ba1) + "");
	#/
	self namespace_b22c99a5::function_3f8a4145(0);
	if(!self laststand::player_is_in_laststand())
	{
		str_stance = self getstance();
		switch(str_stance)
		{
			case "crouch":
			{
				self setstance("stand");
				/#
					println(("" + var_21c1ba1) + "");
				#/
				wait(0.2);
				break;
			}
			case "prone":
			{
				self setstance("stand");
				/#
					println(("" + var_21c1ba1) + "");
				#/
				wait(1);
				break;
			}
		}
	}
	/#
		println(("" + var_21c1ba1) + "");
	#/
}

/*
	Name: function_fe09cd56
	Namespace: namespace_ec1f72a0
	Checksum: 0x17424876
	Offset: 0x1B50
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_fe09cd56()
{
	n_length = 12;
	angle = vectorscale((0, 1, 0), 270);
	start_pos = (-8752, 50696, 1784);
	pos = start_pos;
	for(i = 0; i < n_length; i++)
	{
		spawncollision("collision_clip_wall_512x512x10", "collider", pos, angle);
		pos = pos + vectorscale((1, 0, 0), 512);
	}
	angle = vectorscale((0, 1, 0), 270);
	start_pos = (-8752, 50216, 1784);
	pos = start_pos;
	for(i = 0; i < n_length; i++)
	{
		spawncollision("collision_clip_wall_512x512x10", "collider", pos, angle);
		pos = pos + vectorscale((1, 0, 0), 512);
	}
	angle = vectorscale((1, 0, 0), 90);
	start_pos = (-8752, 50456, 2040);
	pos = start_pos;
	for(i = 0; i < n_length; i++)
	{
		spawncollision("collision_clip_wall_512x512x10", "collider", pos, angle);
		pos = pos + vectorscale((1, 0, 0), 512);
	}
	angle = (0, 0, 0);
	start_pos = (-3656, 50456, 1792);
	spawncollision("collision_clip_wall_512x512x10", "collider", pos, angle);
}

