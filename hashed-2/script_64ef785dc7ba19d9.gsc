// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_2255a7ad3edc838f;
#using script_24c32478acf44108;
#using script_35598499769dbb3d;
#using script_3aa54d3cb36ea43f;
#using script_3f9e0dc8454d98e1;
#using script_42ac6fc8b2ff0f3e;
#using script_4a88aba9724a1fa1;
#using script_4d00889cf8c807d5;
#using script_508e64253010d13c;
#using script_52c6c2d1a2ef1b46;
#using script_56ca01b3b31455b5;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_5bb072c3abf4652c;
#using script_5ec057fa3b983309;
#using script_6021ce59143452c3;
#using script_6c5b51f98cd04fa3;
#using script_6c9e3e6eadb385ca;
#using script_731866b56c3ff255;
#using script_7c8638603dcfd100;
#using script_7e59d7bba853fe4b;
#using script_b52a163973f339f;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_red_challenges.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_31170709;

/*
	Name: init
	Namespace: namespace_31170709
	Checksum: 0xC352CBBB
	Offset: 0x990
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	function_842831cf();
	init_flags();
	function_97d75392();
	function_e3ed59fb();
	function_90bb0d3e();
	function_3ffc2c9e();
	init_light();
	function_fd38f0c2();
	function_26af8a57();
	function_c4f4035e();
	function_3335f286();
	if(!zm_utility::function_e51dc2d8())
	{
		hidemiscmodels("mdl_progress_route");
	}
}

/*
	Name: main
	Namespace: namespace_31170709
	Checksum: 0x43CE2E7B
	Offset: 0xA78
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level thread function_5f80a70a();
}

/*
	Name: function_842831cf
	Namespace: namespace_31170709
	Checksum: 0xBDB1B80C
	Offset: 0xAA0
	Size: 0x1184
	Parameters: 0
	Flags: Linked
*/
function function_842831cf()
{
	var_7551dff2 = getminbitcountfornum(4);
	var_b7863a03 = getminbitcountfornum(3);
	clientfield::register("allplayers", "" + #"hash_72bd7a6af2ba1c5e", 16000, 1, "int");
	clientfield::register("allplayers", "" + #"hash_4a149c9daff159cd", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7343b1cdab1f31c5", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_2a17f2993036fab4", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_1af6f489b6868e7a", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3cc2dfd1a3c36ae3", 16000, var_7551dff2, "int");
	clientfield::register("scriptmover", "" + #"hash_78fa79d021d86cb6", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4f90c0f4c5bc1c42", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_784f06b253332f8f", 16000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_491027931a3fc18f", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_682b7b65432b7746", 16000, var_b7863a03, "int");
	clientfield::register("toplayer", "" + #"hash_214549d33d068451", 16000, 1, "counter");
	clientfield::register("world", "" + #"hash_51858e923e750c33", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_2b05d4c6217bac22", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_3836d3a94cf05642", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_53e684a319647b40", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_70e157c389c1c02f", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_4f59799617fef9c7", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_31a10d565ae05ddb", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_1c97c11fb59eb4bf", 16000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_797e7381ba62ff8a", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_30660c47aae060a9", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_22acf133b0aa208a", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_530e1caa1a8c81d2", 16000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_11480c2b11f0c92f", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_6d76e4b7a31537af", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_4d77ba61cd7f3eb7", 16000, 1, "counter");
	clientfield::register("world", "" + #"hash_43972920fa314daa", 16000, 2, "int");
	clientfield::register("toplayer", "" + #"hash_25cfe5e9786d97e7", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_125706eb7b363924", 16000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_7fc7f7b5958831d4", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_431f319e4b8fe9db", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_158233cdc645bef6", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_492a33037a532fe0", 16000, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_4aeb7fcdd8302eaa", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7a99ff005314c5fc", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7f85dc0ce20a6f2c", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_4e3e66f200f76f34", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_565ca9982285f23e", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_415416bf220de94", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_3e2b1092de25c2dd", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_24b5302c2f39ebc2", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_6a8479b5a5b359a7", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_4feb66128e57d092", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_7552d5567ab25417", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_4e1b58f05f69a65a", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_5a6761fe764bdccf", 16000, 1, "int");
	var_ff76a259 = getminbitcountfornum(5);
	clientfield::register("world", "" + #"hash_74aaba5c17a71e0d", 16000, var_ff76a259, "int");
	clientfield::register("world", "" + #"hash_7e49e921c4dd052f", 16000, var_ff76a259, "int");
	clientfield::register("world", "" + #"hash_9d4aab5c25b93ff", 16000, var_ff76a259, "int");
	clientfield::register("world", "" + #"hash_58e58259618537e7", 16000, var_ff76a259, "int");
	clientfield::register("scriptmover", "" + #"hash_155f8a4473c5849f", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4400550c9847a1c5", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1f0dd5bf6862e335", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_ab97fcf2b12187d", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_d80665c22fafd1e", 16000, 1, "int");
	var_995dd8bf = getminbitcountfornum(9);
	clientfield::register("world", "" + #"hash_516899418a30cd4d", 16000, var_995dd8bf, "int");
	clientfield::register("scriptmover", "" + #"hash_4c6d342dccfd6d73", 16000, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_67b317587e795ec2", 16000, 1, "int");
	clientfield::register("allplayers", "" + #"hash_10275bcd47e53936", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_49068d48a9eb7b89", 16000, 2, "int");
	clientfield::register("world", "" + #"hash_51e28147388ee3d8", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_16e27bea0cc1b56b", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_297c800c6e18f746", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_26ddf1f70bd1f67a", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_508fc6409c815104", 16000, 1, "counter");
	clientfield::register("world", "" + #"hash_7525e43acf9ca679", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_5474fbb93aebbb65", 16000, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_31170709
	Checksum: 0xD95CD55A
	Offset: 0x1C30
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_288dea8dd196ef3");
	level flag::init(#"hash_4e74b4172497a14a");
	level flag::init(#"hash_5ea3c73090a7e665");
	level flag::init(#"hash_70a5801e57336554");
	level flag::init(#"hash_e12ab4b5304a50d");
	level flag::init(#"hash_6b77f898f5d70f1c");
	level flag::init(#"hash_79fd5851173fd4f6");
	level flag::init(#"hash_f38b18eaf7b063b");
	level flag::init(#"hash_5a7f1f9adac6dc8c");
}

/*
	Name: function_3335f286
	Namespace: namespace_31170709
	Checksum: 0xE1EDAC62
	Offset: 0x1D60
	Size: 0x9A4
	Parameters: 0
	Flags: Linked
*/
function function_3335f286()
{
	namespace_ee206246::register(#"main_quest", #"oil", #"oil", &function_e4dadb03, &function_bda20d06);
	namespace_ee206246::register(#"main_quest", #"reflect", #"reflect", &function_8da2802b, &function_46087bd2);
	namespace_ee206246::register(#"main_quest", #"split", #"split", &function_fa377cf7, &function_1a787421);
	namespace_ee206246::register(#"hash_162fe3b17b2752e7", #"hash_7751da18864137ca", #"hash_7751da18864137ca", &function_6c7d67a0, &function_593e3d1f);
	namespace_ee206246::register(#"hash_162fe3b17b2752e7", #"hash_2e55ff1b489306ce", #"hash_2e55ff1b489306ce", &function_c311ba46, &function_d0656fba);
	namespace_ee206246::register(#"hash_162fe3b17b2752e7", #"hash_7f8f1fe8f7b285d0", #"hash_7f8f1fe8f7b285d0", &function_f7b5ebc7, &function_3fda7cb);
	namespace_ee206246::register(#"hash_162fe3b17b2752e7", #"hash_51920e5d18511f72", #"hash_51920e5d18511f72", &function_ceb38216, &function_8d2b7b74);
	namespace_ee206246::register(#"hash_162fe3b17b2752e7", #"hash_38a06e6fa57d2c74", #"hash_38a06e6fa57d2c74", &function_d424710c, &function_7724c926);
	namespace_ee206246::register(#"light", #"hash_59b9d987109997c8", #"hash_59b9d987109997c8", &function_f342bc18, &function_beb7d290);
	namespace_ee206246::register(#"light", #"hash_540790592c78a3cb", #"hash_540790592c78a3cb", &function_5cd1e2d4, &function_9e4314ec);
	namespace_ee206246::register(#"light", #"hash_b2e4c67e2932769", #"hash_b2e4c67e2932769", &function_7c9ece4f, &function_3b1a65ee);
	namespace_ee206246::register(#"light", #"hash_177b41a8c9da003b", #"hash_177b41a8c9da003b", &function_4259a2c9, &function_ddcd9609);
	namespace_ee206246::register(#"light", #"hash_2ef35a0caeaf1677", #"hash_2ef35a0caeaf1677", &function_ec93aa41, &function_63c49b59);
	namespace_ee206246::register(#"light", #"hash_6f1d1e83bc66b715", #"hash_6f1d1e83bc66b715", &function_1533614, &function_8faf150e);
	namespace_ee206246::register(#"main_quest", #"hash_1b1abb2af5960bfe", #"hash_1b1abb2af5960bfe", &function_29a8dcd4, &function_488a4eb2);
	namespace_ee206246::register(#"main_quest", #"play", #"play", &function_c4f65b06, &function_32363763);
	namespace_ee206246::register(#"main_quest", #"blood", #"blood", &function_2954c1bf, &function_e74f32a2);
	namespace_ee206246::register(#"main_quest", #"hash_75294573d425dff4", #"hash_75294573d425dff4", &function_1cb738a0, &function_ebe10128);
	namespace_ee206246::register(#"main_quest", #"mid_igc", #"mid_igc", &function_ce32cc66, &function_e5cd3130);
	namespace_ee206246::register(#"main_quest", #"cleanse", #"cleanse", &function_d2ab893e, &function_8dc89390);
	namespace_ee206246::register(#"main_quest", #"hash_1f875aef67e9ade4", #"hash_1f875aef67e9ade4", &function_5e84e8f9, &function_8000f525);
	namespace_ee206246::register(#"main_quest", #"hash_d861e03ebf38f96", #"hash_d861e03ebf38f96", &function_2f9d2650, &function_358b40ed);
	namespace_ee206246::register(#"main_quest", #"teleport", #"teleport", &function_22165535, &function_9f8fe5ae);
	namespace_ee206246::register(#"hash_5474fbb93aebbb65", #"1", #"hash_64d6af5ddc324d26", &function_6f55d670, &function_13c87ace);
	namespace_ee206246::register(#"hash_5474fbb93aebbb65", #"2", #"hash_3f567f217222e5b2", &function_e6ce9708, &function_4f6285d0);
	namespace_ee206246::start(#"main_quest");
	namespace_ee206246::start(#"hash_5474fbb93aebbb65");
}

/*
	Name: function_e4dadb03
	Namespace: namespace_31170709
	Checksum: 0x3B50B018
	Offset: 0x2710
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_e4dadb03(var_77104def)
{
	level.var_38ee0d9e = array(0, 0, 0);
	level flag::wait_till(#"pap_quest_completed");
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 1);
	level flag::wait_till("fl_oracle_unlocked");
	function_40b663e7();
	for(i = 1; i <= 3; i++)
	{
		level thread function_881659b(i, var_77104def);
	}
	level flag::wait_till(#"hash_5ea3c73090a7e665");
}

/*
	Name: function_97d75392
	Namespace: namespace_31170709
	Checksum: 0xC2D8A5DD
	Offset: 0x2820
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_97d75392()
{
	level.var_6c94f00a = 0;
	for(i = 1; i <= 3; i++)
	{
		var_782728a8 = getent("rune_" + i, "targetname");
		var_782728a8 hidepart("tag_emissive");
	}
}

/*
	Name: function_40b663e7
	Namespace: namespace_31170709
	Checksum: 0xEFAEC448
	Offset: 0x28B8
	Size: 0x15A
	Parameters: 0
	Flags: Linked
*/
function function_40b663e7()
{
	callback::on_connect(&function_a9481419);
	a_players = getplayers();
	foreach(player in a_players)
	{
		player thread function_a9481419();
	}
	level.var_1177ae05 = &function_f26aeec5;
	namespace_9ff9f642::function_9d45c058(#"hash_26b7fbb55bad5c2f", 16, 6);
	zm::function_84d343d(#"zhield_zpear_dw", &function_b252fc5);
	zm::function_84d343d(#"hash_1a385be4d5103a33", &function_b252fc5);
	level.var_ec37138d = 1;
}

/*
	Name: function_a9481419
	Namespace: namespace_31170709
	Checksum: 0x52DE85F5
	Offset: 0x2A20
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_a9481419()
{
	self endon(#"disconnect");
	while(true)
	{
		var_e9614513 = struct::get(#"hash_11e79ab8fb768baa");
		function_e9af1fc4(var_e9614513, 13689);
		if(!(isdefined(self.var_b4f85096) && self.var_b4f85096))
		{
			self thread function_fbc44c3e();
		}
	}
}

/*
	Name: function_e9af1fc4
	Namespace: namespace_31170709
	Checksum: 0xAD67D147
	Offset: 0x2AC8
	Size: 0x22A
	Parameters: 4
	Flags: Linked
*/
function function_e9af1fc4(s_target, var_7d07543f, var_a0d128c8 = 1, str_notify)
{
	self endon(#"disconnect");
	if(isdefined(str_notify))
	{
		level endon(str_notify);
	}
	if(!var_a0d128c8 && !isdefined(s_target.t_damage))
	{
		level thread function_eebc7e40(s_target, str_notify);
	}
	var_8f1e485e = 0;
	while(!var_8f1e485e)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_melee");
		if(isdefined(var_88706ea7.weapon.isriotshield) && var_88706ea7.weapon.isriotshield)
		{
			if(var_a0d128c8 && var_88706ea7.weapon == level.var_ce3aa8a8)
			{
				continue;
			}
			if(distancesquared(self.origin, s_target.origin) < var_7d07543f)
			{
				v_player_eye = self geteye();
				var_830a645d = vectornormalize(s_target.origin - v_player_eye);
				var_24169a2e = self getweaponforwarddir();
				n_dot = vectordot(var_24169a2e, var_830a645d);
				if(n_dot > 0.16)
				{
					var_8f1e485e = 1;
					if(isdefined(str_notify))
					{
						level notify(str_notify, {#e_player:self});
					}
				}
			}
		}
	}
}

/*
	Name: function_eebc7e40
	Namespace: namespace_31170709
	Checksum: 0x298CC75A
	Offset: 0x2D00
	Size: 0x240
	Parameters: 2
	Flags: Linked
*/
function function_eebc7e40(s_target, str_notify)
{
	level endon(#"hash_5ea3c73090a7e665");
	if(!isdefined(s_target.t_damage))
	{
		s_target.t_damage = spawn("trigger_damage_new", s_target.origin, 0, 61, 61);
		s_target.t_damage.health = 999999;
		s_target.t_damage endon(#"death");
	}
	var_c4b94b6 = 0;
	while(!var_c4b94b6)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = s_target.t_damage waittill(#"damage");
		s_target.t_damage.health = s_target.t_damage.health + var_88706ea7.amount;
		if(isplayer(var_88706ea7.inflictor))
		{
			var_8f1e485e = isdefined(var_88706ea7.weapon.isriotshield) && var_88706ea7.weapon.isriotshield && (var_88706ea7.mod === "MOD_PROJECTILE" || var_88706ea7.mod === "MOD_PROJECTILE_SPLASH");
			if(var_8f1e485e && (isdefined(var_88706ea7.inflictor.var_b4f85096) && var_88706ea7.inflictor.var_b4f85096))
			{
				level notify(str_notify, {#e_player:var_88706ea7.inflictor});
				var_c4b94b6 = 1;
				s_target.t_damage delete();
			}
		}
	}
}

/*
	Name: function_fbc44c3e
	Namespace: namespace_31170709
	Checksum: 0x246E56D4
	Offset: 0x2F48
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function function_fbc44c3e()
{
	self endon(#"death", #"hash_313ddbccf660de40");
	self clientfield::set("" + #"hash_72bd7a6af2ba1c5e", 1);
	self.var_b4f85096 = 1;
	if(!level.var_6c94f00a)
	{
		level.var_6c94f00a = 1;
		level thread function_3135d0e6(self);
	}
	self thread function_1251d08c();
	self thread function_630766ac();
	self waittill(#"hash_cbf6a8f73a300c8");
	self clientfield::set("" + #"hash_4a149c9daff159cd", 1);
	self clientfield::set("" + #"hash_72bd7a6af2ba1c5e", 0);
	self.var_b0cde18d = 1;
}

/*
	Name: function_3135d0e6
	Namespace: namespace_31170709
	Checksum: 0xF37E999E
	Offset: 0x3090
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function function_3135d0e6(e_player)
{
	level endon(#"end_game");
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
	wait(10);
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	waitframe(1);
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_5d135a09f5f75f0e");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level thread function_7b345f6d(#"hash_2b67d88ef795d22c");
	}
	level zm_audio::sndvoxoverride(0);
}

/*
	Name: function_1251d08c
	Namespace: namespace_31170709
	Checksum: 0x7FA71C3F
	Offset: 0x3280
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function function_1251d08c()
{
	self endon(#"death");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"hash_459246e5bfcc3713", #"destroy_riotshield", #"weapon_fired", #"fake_death");
	self clientfield::set("" + #"hash_72bd7a6af2ba1c5e", 0);
	if(isdefined(self.var_b0cde18d) && self.var_b0cde18d)
	{
		self clientfield::set("" + #"hash_4a149c9daff159cd", 0);
	}
	self thread zm_audio::create_and_play_dialog(#"generic", #"response_negative");
	if(var_88706ea7._notify == "weapon_fired")
	{
		wait(1.6);
	}
	self.var_b4f85096 = 0;
	self.var_b0cde18d = 0;
	self notify(#"hash_313ddbccf660de40");
}

/*
	Name: function_f26aeec5
	Namespace: namespace_31170709
	Checksum: 0x30AFFB96
	Offset: 0x33D8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_f26aeec5()
{
	if(!(isdefined(self.var_16735873) && self.var_16735873))
	{
		self notify(#"hash_459246e5bfcc3713");
	}
}

/*
	Name: function_b252fc5
	Namespace: namespace_31170709
	Checksum: 0xD7FC1709
	Offset: 0x3410
	Size: 0x248
	Parameters: 12
	Flags: Linked
*/
function function_b252fc5(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && (isdefined(attacker.var_b4f85096) && attacker.var_b4f85096))
	{
		if(isdefined(attacker.var_b0cde18d) && attacker.var_b0cde18d && self.var_6f84b820 == #"basic")
		{
			if(self.archetype == #"zombie" && !zm_utility::is_magic_bullet_shield_enabled(self))
			{
				mdl_fx = util::spawn_model(#"tag_origin", self gettagorigin("j_spine4"), self gettagangles("j_spine4"));
				mdl_fx clientfield::increment("" + #"hash_2a17f2993036fab4");
				mdl_fx thread util::delayed_delete(0.25);
				gibserverutils::annihilate(self);
			}
			return self.health + 666;
		}
		self clientfield::set("zm_nuked", 1);
		self namespace_9ff9f642::burn(#"hash_26b7fbb55bad5c2f", attacker, weapon, 16);
	}
	return damage;
}

/*
	Name: function_630766ac
	Namespace: namespace_31170709
	Checksum: 0xBC8819D5
	Offset: 0x3660
	Size: 0x160
	Parameters: 0
	Flags: Linked
*/
function function_630766ac()
{
	self notify("2c94f6cd68ab93b0");
	self endon("2c94f6cd68ab93b0");
	level endon(#"end_game");
	self endon(#"death", #"hash_459246e5bfcc3713", #"destroy_riotshield");
	while(self hasriotshield() && (isdefined(self.var_b4f85096) && self.var_b4f85096))
	{
		wait(5);
		if(self hasriotshield() && (isdefined(self.var_b4f85096) && self.var_b4f85096))
		{
			if(!isbot(self))
			{
				self clientfield::increment_to_player("" + #"hash_7343b1cdab1f31c5");
			}
			self riotshield::player_damage_shield(25 / zombie_utility::function_d2dfacfd(#"hash_cc85b961f25c2ff"), undefined, undefined, undefined, 0);
		}
	}
}

/*
	Name: function_881659b
	Namespace: namespace_31170709
	Checksum: 0xBC249AEE
	Offset: 0x37C8
	Size: 0x3E4
	Parameters: 2
	Flags: Linked
*/
function function_881659b(n_index, var_77104def)
{
	level endon(#"hash_5ea3c73090a7e665");
	var_782728a8 = getent("rune_" + n_index, "targetname");
	var_e13b91f9 = struct::get(var_782728a8.target);
	if(!var_77104def)
	{
		var_c4b94b6 = 0;
		str_notify = #"hash_662a9e46fc7043ed" + n_index;
		while(!var_c4b94b6)
		{
			a_players = getplayers();
			foreach(player in a_players)
			{
				player thread function_e9af1fc4(var_e13b91f9, 3721, 0, str_notify);
			}
			var_88706ea7 = undefined;
			var_88706ea7 = level waittill(str_notify);
			if(isdefined(var_88706ea7.e_player.var_b4f85096) && var_88706ea7.e_player.var_b4f85096)
			{
				var_c4b94b6 = 1;
				if(!(isdefined(level.var_3dc6358c) && level.var_3dc6358c))
				{
					level.var_3dc6358c = 1;
					var_88706ea7.e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
				}
			}
		}
	}
	if(isdefined(var_e13b91f9.t_damage))
	{
		var_e13b91f9.t_damage delete();
	}
	level clientfield::set("" + #"hash_682b7b65432b7746", n_index);
	if(!var_77104def)
	{
		level scene::play(#"hash_76acbb03fdd478a0" + var_e13b91f9.var_471a77a9 + "_bundle");
	}
	var_782728a8 showpart("tag_emissive");
	var_782728a8 clientfield::set("" + #"hash_1af6f489b6868e7a", 1);
	level.var_38ee0d9e[n_index - 1] = 1;
	var_2df64d67 = 0;
	foreach(var_9ce1d083 in level.var_38ee0d9e)
	{
		if(var_9ce1d083)
		{
			var_2df64d67++;
		}
	}
	if(var_2df64d67 == 3)
	{
		level flag::set(#"hash_5ea3c73090a7e665");
	}
}

/*
	Name: function_bda20d06
	Namespace: namespace_31170709
	Checksum: 0xE95E82BC
	Offset: 0x3BB8
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_bda20d06(var_77104def, var_19e802fa)
{
	if(var_77104def || var_19e802fa)
	{
		if(!(isdefined(level.var_ec37138d) && level.var_ec37138d))
		{
			function_40b663e7();
		}
		if(!level flag::get(#"hash_5ea3c73090a7e665"))
		{
			for(i = 1; i <= 3; i++)
			{
				if(!level.var_38ee0d9e[i - 1])
				{
					function_881659b(i, 1);
				}
			}
		}
	}
	level thread function_f0f982b();
}

/*
	Name: function_f0f982b
	Namespace: namespace_31170709
	Checksum: 0xD1C1464A
	Offset: 0x3CA8
	Size: 0x344
	Parameters: 0
	Flags: Linked
*/
function function_f0f982b()
{
	playsoundatposition(#"hash_48910fcc61ab6c8a", (0, 0, 0));
	exploder::exploder("exp_lgt_skylight");
	var_e986e64a = getent("cave_door", "targetname");
	var_d25ef27c = struct::get(#"hash_4625361373037689");
	var_a4a51709 = struct::get(#"hash_9e0e9cf53602f0a");
	var_e986e64a moveto(var_d25ef27c.origin, 2.9);
	wait(0.25);
	playsoundatposition(#"hash_396f1597d3662c78", (0, 0, 0));
	foreach(e_player in getplayers())
	{
		e_player clientfield::increment_to_player("" + #"hash_214549d33d068451");
	}
	var_e986e64a waittill_timeout(2.9 - 0.25, #"movedone");
	var_e986e64a rotateto(var_a4a51709.angles, 2.9);
	var_e986e64a moveto(var_a4a51709.origin, 2.9);
	var_e986e64a waittill(#"movedone");
	level clientfield::set("" + #"hash_51858e923e750c33", 1);
	wait(1);
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_7c2fc0e6e835e8df");
			break;
		}
	}
}

/*
	Name: function_8da2802b
	Namespace: namespace_31170709
	Checksum: 0x3A9B5963
	Offset: 0x3FF8
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_8da2802b(var_77104def)
{
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 2);
	if(!var_77104def)
	{
		level thread function_9388cf21();
		level thread function_e35827a4();
		a_players = getplayers();
		foreach(player in a_players)
		{
			player thread function_8142733f();
		}
		level flag::wait_till(#"hash_4e74b4172497a14a");
		a_players = util::get_active_players();
		foreach(player in a_players)
		{
			player playrumbleonentity("zm_red_step_complete_rumble");
		}
		playsoundatposition(#"hash_396f1597d3662c78", (0, 0, 0));
	}
}

/*
	Name: function_9388cf21
	Namespace: namespace_31170709
	Checksum: 0x69A7A8A2
	Offset: 0x41C8
	Size: 0x21C
	Parameters: 0
	Flags: Linked
*/
function function_9388cf21()
{
	level flag::wait_till(#"hash_5ea3c73090a7e665");
	level thread function_cad81195();
	level thread function_a9bde51();
	array::thread_all(getplayers(), &function_e64c55ea);
	wait(15);
	var_845efa03 = 0;
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_76a20f43fee4ec4f");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level thread function_7b345f6d(#"hash_fa3fa8d2434cae7");
	}
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_2a4e028a916b763d");
	if(isplayer(var_88706ea7.e_player))
	{
		var_88706ea7.e_player zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
}

/*
	Name: function_a9bde51
	Namespace: namespace_31170709
	Checksum: 0xF53A6220
	Offset: 0x43F0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_a9bde51()
{
	level waittill(#"hash_59d8b409e328117b");
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_2a4e028a916b763d");
	level waittill(#"hash_6a78cf8b84796501");
	if(zm_utility::is_player_valid(var_88706ea7.e_player))
	{
		var_88706ea7.e_player namespace_891c9bac::function_a2bd5a0c(#"hash_5b6e60c5280dcb1c");
	}
	else
	{
		a_e_players = util::get_active_players();
		a_e_players = array::randomize(a_e_players);
		foreach(e_player in a_e_players)
		{
			if(zm_utility::is_player_valid(e_player))
			{
				e_player namespace_891c9bac::function_a2bd5a0c(#"hash_5b6e60c5280dcb1c");
				break;
			}
		}
	}
	level flag::set(#"hash_70a5801e57336554");
}

/*
	Name: function_e64c55ea
	Namespace: namespace_31170709
	Checksum: 0x6CBB92E8
	Offset: 0x4588
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_e64c55ea()
{
	self endon(#"disconnect");
	level endon(#"hash_103477b55ed9a149");
	var_c29a1099 = getent("vol_reflect", "targetname");
	while(!level flag::get(#"hash_4e74b4172497a14a"))
	{
		if(zm_utility::is_player_valid(self) && (!(isdefined(level.var_4ea7b88f) && level.var_4ea7b88f)) && self istouching(var_c29a1099))
		{
			level.var_4ea7b88f = 1;
			self thread namespace_891c9bac::function_a2bd5a0c(#"hash_1aa9fc5f46a728d0");
		}
		waitframe(1);
	}
}

/*
	Name: function_cad81195
	Namespace: namespace_31170709
	Checksum: 0xE7F4A183
	Offset: 0x4690
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_cad81195()
{
	a_origin = (439, -4107, -677);
	var_e25ba3b3 = spawn("script_origin", a_origin);
	var_e25ba3b3 playloopsound(#"hash_34d1426dd3b11eb8");
	flag::wait_till(#"hash_4e74b4172497a14a");
	var_e25ba3b3 delete();
}

/*
	Name: function_8142733f
	Namespace: namespace_31170709
	Checksum: 0x21B2F999
	Offset: 0x4738
	Size: 0x318
	Parameters: 0
	Flags: Linked
*/
function function_8142733f()
{
	self endon(#"disconnect");
	level endon(#"hash_4e74b4172497a14a");
	self thread function_f94701f3();
	var_c29a1099 = getent("vol_reflect", "targetname");
	while(!level flag::get(#"hash_4e74b4172497a14a"))
	{
		self waittill(#"hash_288cb56263c7b7fa");
		if(self istouching(var_c29a1099))
		{
			if(!(isdefined(self.var_a56de6e0) && self.var_a56de6e0))
			{
				self clientfield::set_to_player("" + #"hash_491027931a3fc18f", 1);
				self.var_a56de6e0 = 1;
				self thread function_b87e4fa1();
			}
			if(!(isdefined(level.var_97a5d82f) && level.var_97a5d82f))
			{
				level.var_97a5d82f = 1;
				level notify(#"hash_103477b55ed9a149");
				self thread namespace_891c9bac::function_a2bd5a0c(#"hash_4c8a4f38397df93a");
			}
			level flag::wait_till(#"hash_288dea8dd196ef3");
			level.var_67c7040c flag::clear(#"hash_1267306c12c34607");
			var_e041507a = self getentitynumber() + 1;
			level.var_67c7040c clientfield::set("" + #"hash_3cc2dfd1a3c36ae3", var_e041507a);
			level.var_67c7040c.b_in_use = 1;
			var_46307de5 = level.var_67c7040c;
			namespace_76c5fc73::function_25513188(var_46307de5);
			var_88706ea7 = undefined;
			var_88706ea7 = self waittill(#"hash_6976c1afc34dbda5", #"hash_56c5053f5e67838b", #"hash_2a4e028a916b763d");
			if(isdefined(var_46307de5))
			{
				namespace_76c5fc73::function_5760b289(var_46307de5);
				var_46307de5 clientfield::set("" + #"hash_3cc2dfd1a3c36ae3", 0);
				var_46307de5 thread function_b7c33177();
			}
		}
	}
}

/*
	Name: function_b7c33177
	Namespace: namespace_31170709
	Checksum: 0x24D217D2
	Offset: 0x4A58
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_b7c33177()
{
	wait(0.15);
	if(isdefined(self))
	{
		self flag::set(#"hash_1267306c12c34607");
		self.b_in_use = undefined;
	}
}

/*
	Name: function_f94701f3
	Namespace: namespace_31170709
	Checksum: 0x1C9A24FB
	Offset: 0x4AA0
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function function_f94701f3()
{
	level endon(#"hash_4e74b4172497a14a");
	self waittill(#"disconnect");
	foreach(var_9be47330 in level.var_6775c28d)
	{
		if(isdefined(var_9be47330))
		{
			namespace_76c5fc73::function_5760b289(var_9be47330);
			var_9be47330 clientfield::set("" + #"hash_3cc2dfd1a3c36ae3", 0);
			var_9be47330.b_in_use = undefined;
		}
	}
	if(isdefined(level.var_42a95bde))
	{
		namespace_76c5fc73::function_5760b289(level.var_42a95bde);
		level.var_42a95bde clientfield::set("" + #"hash_3cc2dfd1a3c36ae3", 0);
		level.var_42a95bde.b_in_use = undefined;
	}
}

/*
	Name: function_b87e4fa1
	Namespace: namespace_31170709
	Checksum: 0xB80AFC4B
	Offset: 0x4C00
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_b87e4fa1()
{
	self endon(#"death");
	while(isdefined(self.var_b1224954) && self istouching(self.var_b1224954) && !level flag::get(#"hash_4e74b4172497a14a"))
	{
		waitframe(1);
	}
	self.var_a56de6e0 = undefined;
	self clientfield::set_to_player("" + #"hash_491027931a3fc18f", 0);
	self notify(#"hash_56c5053f5e67838b");
	if(isdefined(level.var_67c7040c))
	{
		level.var_67c7040c notify(#"clean_up");
	}
}

/*
	Name: function_47c0d27
	Namespace: namespace_31170709
	Checksum: 0xD44F08B0
	Offset: 0x4CF8
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_47c0d27()
{
	self endon(#"death");
	self flag::init(#"hash_1267306c12c34607");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_1bf3d1cc10e09c43");
		if(isdefined(self))
		{
			if(var_88706ea7.e_entity === self && self == level.var_67c7040c)
			{
				if(isplayer(var_88706ea7.player) && (isdefined(var_88706ea7.player.var_a56de6e0) && var_88706ea7.player.var_a56de6e0))
				{
					self notify(#"hash_2a4e028a916b763d");
					var_88706ea7.player notify(#"hash_2a4e028a916b763d");
					level notify(#"hash_2a4e028a916b763d", {#e_player:var_88706ea7.player});
					self flag::wait_till(#"hash_1267306c12c34607");
				}
			}
		}
	}
}

/*
	Name: function_abad8624
	Namespace: namespace_31170709
	Checksum: 0xACC937FB
	Offset: 0x4E78
	Size: 0x384
	Parameters: 2
	Flags: Linked
*/
function function_abad8624(e_projectile, var_862206ea)
{
	e_projectile endon(#"death");
	e_projectile thread function_723b1d66();
	if(isdefined(var_862206ea))
	{
		var_4d8b7233 = 0;
		var_edf17cfc = var_862206ea getcentroid();
		n_dist = distance(e_projectile.origin, var_edf17cfc);
		var_948c9fb6 = n_dist - n_dist * 0.29;
		while(isdefined(var_862206ea) && distance2dsquared(e_projectile.origin, var_862206ea.origin) > 289)
		{
			var_edf17cfc = var_862206ea getcentroid();
			var_727d3c77 = e_projectile.origin;
			v_forward = vectornormalize(var_862206ea.origin - var_727d3c77);
			v_target = var_727d3c77 + v_forward * 61;
			n_dist = distance2d(e_projectile.origin, var_edf17cfc);
			var_4d8b7233 = randomintrange(92, 116);
			if(n_dist <= var_948c9fb6)
			{
				var_4d8b7233 = var_4d8b7233 * 0.29;
				var_4d8b7233 = var_4d8b7233 * -1;
			}
			v_end = v_target + (0, 0, var_4d8b7233);
			if(isdefined(v_end) && isdefined(var_862206ea))
			{
				if(distance2dsquared(e_projectile.origin, var_862206ea.origin) <= 289)
				{
					v_end = var_862206ea getcentroid();
				}
				e_projectile moveto(v_end, 0.2);
				wait(0.2 - 0.05);
			}
			else
			{
				waitframe(1);
			}
		}
	}
	if(isdefined(var_862206ea) && var_862206ea.var_6f84b820 === #"boss")
	{
		if(isdefined(var_862206ea gettagorigin("tag_body")))
		{
			v_end = var_862206ea gettagorigin("tag_body");
		}
	}
	if(isdefined(v_end))
	{
		e_projectile moveto(v_end, 0.05);
		e_projectile waittill(#"movedone");
	}
	e_projectile playsound(#"hash_7c51534a91103a32");
	if(isdefined(e_projectile))
	{
		e_projectile delete();
	}
}

/*
	Name: function_723b1d66
	Namespace: namespace_31170709
	Checksum: 0xF5F86705
	Offset: 0x5208
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_723b1d66()
{
	self endon(#"death");
	wait(6.1);
	self delete();
}

/*
	Name: function_e3ed59fb
	Namespace: namespace_31170709
	Checksum: 0x44D11D27
	Offset: 0x5248
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function function_e3ed59fb()
{
	var_3d8894cc = struct::get_array(#"hash_178b1abb7a6d4287", "script_noteworthy");
	var_3d8894cc = array::randomize(var_3d8894cc);
	foreach(var_d0d9d7ce in var_3d8894cc)
	{
		if(var_d0d9d7ce.script_string === "reflect_0")
		{
			var_f1962e98 = var_d0d9d7ce;
			break;
		}
	}
	arrayremovevalue(var_3d8894cc, var_f1962e98);
	level.var_42a95bde = var_f1962e98 function_e4ccd9be(0);
	for(i = 0; i < 3; i++)
	{
		var_3d8894cc[i] function_e4ccd9be();
	}
}

/*
	Name: function_5f80a70a
	Namespace: namespace_31170709
	Checksum: 0xA52D4FC4
	Offset: 0x53B0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_5f80a70a()
{
	while(!isdefined(level.var_6775c28d) || level.var_6775c28d.size == 0)
	{
		waitframe(1);
	}
	foreach(var_9be47330 in level.var_6775c28d)
	{
		var_9be47330 clientfield::set("" + #"hash_78fa79d021d86cb6", 1);
	}
	while(!isdefined(level.var_42a95bde))
	{
		waitframe(1);
	}
	level.var_42a95bde clientfield::set("" + #"hash_78fa79d021d86cb6", 1);
}

/*
	Name: function_e35827a4
	Namespace: namespace_31170709
	Checksum: 0x6237A008
	Offset: 0x54D8
	Size: 0x59C
	Parameters: 0
	Flags: Linked
*/
function function_e35827a4()
{
	level endon(#"hash_4e74b4172497a14a");
	level.var_4822b326 = 1;
	while(level.var_6775c28d.size > 0)
	{
		var_9aa36ed = arraycopy(level.var_6775c28d);
		foreach(var_407cfce6 in level.var_6775c28d)
		{
			if(isdefined(var_407cfce6) && (!(isdefined(var_407cfce6.var_344e2520) && var_407cfce6.var_344e2520)))
			{
				level.var_67c7040c = var_407cfce6;
				level flag::set(#"hash_288dea8dd196ef3");
				var_4c07cedf = function_2a9c51b5();
				var_88706ea7 = undefined;
				var_88706ea7 = var_407cfce6 waittill_timeout(var_4c07cedf, #"hash_2a4e028a916b763d");
				level flag::clear(#"hash_288dea8dd196ef3");
				a_players = getplayers();
				foreach(player in a_players)
				{
					player notify(#"hash_6976c1afc34dbda5");
				}
				if(isdefined(var_407cfce6.b_in_use) && var_407cfce6.b_in_use)
				{
					var_407cfce6 function_5dc6a4b7(var_88706ea7._notify);
				}
				wait(1.6);
			}
		}
		level.var_6775c28d = array::remove_undefined(level.var_6775c28d);
		foreach(var_407cfce6 in level.var_6775c28d)
		{
			if(var_407cfce6.var_344e2520)
			{
				arrayremovevalue(var_9aa36ed, var_407cfce6, 0);
			}
		}
		var_9aa36ed = array::remove_undefined(var_9aa36ed);
		level.var_6775c28d = var_9aa36ed;
		waitframe(1);
	}
	level.var_67c7040c = level.var_42a95bde;
	level flag::set(#"hash_288dea8dd196ef3");
	level notify(#"hash_59d8b409e328117b");
	var_b6225a1f = 0;
	while(!var_b6225a1f)
	{
		var_4c07cedf = function_2a9c51b5();
		var_88706ea7 = undefined;
		var_88706ea7 = level.var_67c7040c waittill_timeout(var_4c07cedf, #"clean_up", #"hash_2a4e028a916b763d");
		if(var_88706ea7._notify == #"hash_2a4e028a916b763d")
		{
			var_b6225a1f = 1;
			level.var_67c7040c thread function_5dc6a4b7(var_88706ea7._notify);
		}
		a_players = getplayers();
		foreach(player in a_players)
		{
			player notify(#"hash_6976c1afc34dbda5");
		}
	}
	level.var_67c7040c function_822fc9a(1.6);
	level flag::set(#"hash_4e74b4172497a14a");
	a_players = getplayers();
	foreach(player in a_players)
	{
		player notify(#"hash_6976c1afc34dbda5");
	}
	level.var_67c7040c flag::wait_till(#"hash_1267306c12c34607");
}

/*
	Name: function_2a9c51b5
	Namespace: namespace_31170709
	Checksum: 0x71334460
	Offset: 0x5A80
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_2a9c51b5()
{
	var_4c07cedf = 6.1;
	a_players = util::get_active_players();
	if(a_players.size > 1)
	{
		var_4c07cedf = 2.9;
	}
	return var_4c07cedf;
}

/*
	Name: function_5dc6a4b7
	Namespace: namespace_31170709
	Checksum: 0x3804892A
	Offset: 0x5AE0
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_5dc6a4b7(str_notify)
{
	v_origin = self.origin;
	v_angles = self.angles;
	self flag::wait_till(#"hash_1267306c12c34607");
	if(str_notify == #"hash_2a4e028a916b763d")
	{
		self.var_344e2520 = 1;
		self thread function_822fc9a();
		a_players = util::get_active_players();
		var_59797ee2 = 3 * a_players.size;
		var_cbca5580 = 0;
		for(i = 0; i < var_59797ee2; i++)
		{
			var_862206ea = namespace_bc12435c::function_1ea880bd(1);
			if(isdefined(var_862206ea))
			{
				var_862206ea.var_3c394b1b = 1;
				var_cbca5580++;
				if(var_cbca5580 <= 3)
				{
					level thread function_2d65c8cf(v_origin, v_angles, var_862206ea);
				}
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_2d65c8cf
	Namespace: namespace_31170709
	Checksum: 0x23BB567D
	Offset: 0x5C60
	Size: 0xAC
	Parameters: 3
	Flags: Linked
*/
function function_2d65c8cf(var_524ee19b, var_2bbeb776, var_862206ea)
{
	wait(1);
	e_projectile = util::spawn_model("tag_origin", var_524ee19b + vectorscale((0, 0, 1), 128), var_524ee19b);
	e_projectile clientfield::set("" + #"hash_4f90c0f4c5bc1c42", 1);
	function_abad8624(e_projectile, var_862206ea);
}

/*
	Name: function_822fc9a
	Namespace: namespace_31170709
	Checksum: 0xF751DB09
	Offset: 0x5D18
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_822fc9a(n_wait = 0)
{
	self clientfield::set("" + #"hash_78fa79d021d86cb6", 0);
	self playsound(#"hash_4b4a1df956b94dd8");
	if(n_wait > 0)
	{
		self thread scene::play(self.str_fxanim, self);
		wait(n_wait);
	}
	else
	{
		self scene::play(self.str_fxanim, self);
	}
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_e4ccd9be
	Namespace: namespace_31170709
	Checksum: 0x46DC17BE
	Offset: 0x5DF8
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_e4ccd9be(var_1c49ffa5 = 1)
{
	var_407cfce6 = util::spawn_model(self.model, self.origin, self.angles);
	var_407cfce6.var_344e2520 = 0;
	var_407cfce6.str_fxanim = self.var_bc27cb13;
	var_407cfce6 thread function_47c0d27();
	if(var_1c49ffa5)
	{
		if(!isdefined(level.var_6775c28d))
		{
			level.var_6775c28d = [];
		}
		else if(!isarray(level.var_6775c28d))
		{
			level.var_6775c28d = array(level.var_6775c28d);
		}
		level.var_6775c28d[level.var_6775c28d.size] = var_407cfce6;
	}
	hidemiscmodels(self.targetname);
	return var_407cfce6;
}

/*
	Name: function_46087bd2
	Namespace: namespace_31170709
	Checksum: 0x909D644F
	Offset: 0x5F30
	Size: 0x2AC
	Parameters: 2
	Flags: Linked
*/
function function_46087bd2(var_77104def, var_19e802fa)
{
	if(!level flag::get(#"hash_4e74b4172497a14a"))
	{
		level flag::set(#"hash_4e74b4172497a14a");
	}
	foreach(var_9be47330 in level.var_6775c28d)
	{
		if(isdefined(var_9be47330))
		{
			var_9be47330 delete();
		}
	}
	if(isdefined(level.var_42a95bde))
	{
		level.var_42a95bde delete();
	}
	var_a6ac7ab6 = struct::get(#"hash_1f35a43b3fe90f67");
	var_919d328 = util::spawn_model(var_a6ac7ab6.model, var_a6ac7ab6.origin, var_a6ac7ab6.angles);
	var_919d328 movez(320, 2.9);
	if(!var_77104def && !var_19e802fa)
	{
		var_919d328 waittill(#"movedone");
		level notify(#"hash_6a78cf8b84796501");
	}
	else if(!level flag::get(#"hash_70a5801e57336554"))
	{
		level flag::set(#"hash_70a5801e57336554");
	}
	playsoundatposition(#"hash_48910ecc61ab6ad7", (0, 0, 0));
	level clientfield::set("" + #"hash_51858e923e750c33", 2);
	level clientfield::set("" + #"hash_2b05d4c6217bac22", 1);
}

/*
	Name: function_fa377cf7
	Namespace: namespace_31170709
	Checksum: 0x991D88F4
	Offset: 0x61E8
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_fa377cf7(var_77104def)
{
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 3);
	callback::on_connect(&function_b8911151);
	array::thread_all(getplayers(), &function_b8911151);
	if(!var_77104def)
	{
		level thread function_3d0f05e();
		var_9313321d = struct::get_array(#"hash_5ccf0c3f893e24a8");
		foreach(var_32644c5b in var_9313321d)
		{
			var_32644c5b thread function_8b20a029();
		}
		level flag::wait_till(#"hash_e12ab4b5304a50d");
	}
}

/*
	Name: function_90bb0d3e
	Namespace: namespace_31170709
	Checksum: 0x415C7FEF
	Offset: 0x6358
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_90bb0d3e()
{
	var_ef84b792 = struct::get(#"hash_50738141206b8c");
	level.var_20622c6 = util::spawn_model(var_ef84b792.model, var_ef84b792.origin, var_ef84b792.angles);
}

/*
	Name: function_3d0f05e
	Namespace: namespace_31170709
	Checksum: 0xA11A1367
	Offset: 0x63D0
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_3d0f05e()
{
	level flag::wait_till(#"hash_70a5801e57336554");
	wait(10);
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_56e84d8c794a63f7");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level thread function_7b345f6d(#"hash_210265271f212c8f");
	}
}

/*
	Name: function_b8911151
	Namespace: namespace_31170709
	Checksum: 0x86948046
	Offset: 0x6510
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_b8911151()
{
	self notify("1114015a3e4d9c5d");
	self endon("1114015a3e4d9c5d");
	level endon(#"end_game", #"hash_1beb529f935869e4");
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"projectile_impact");
		w_weapon = var_be17187b.weapon;
		if(isdefined(w_weapon.isriotshield) && w_weapon.isriotshield)
		{
			e_projectile = var_be17187b.projectile;
			if(isdefined(e_projectile))
			{
				self.var_7808e305 = e_projectile.angles;
				self thread function_b77d6eae();
			}
		}
	}
}

/*
	Name: function_b77d6eae
	Namespace: namespace_31170709
	Checksum: 0xB8091077
	Offset: 0x6620
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_b77d6eae()
{
	self notify("8450fe687a4c855");
	self endon("8450fe687a4c855");
	self endon(#"disconnect");
	waitframe(2);
	self.var_7808e305 = undefined;
}

/*
	Name: function_8b20a029
	Namespace: namespace_31170709
	Checksum: 0xFD3C08CC
	Offset: 0x6668
	Size: 0xDBC
	Parameters: 0
	Flags: Linked
*/
function function_8b20a029()
{
	if(isdefined(self.anim_id))
	{
		level scene::play(#"hash_3ec0153ab122b92b" + self.anim_id + "_bundle", "Shot 1");
	}
	var_cff0c83d = util::spawn_model(self.model, self.origin, self.angles);
	var_cff0c83d.n_axis = self.script_int;
	var_cff0c83d playloopsound(#"hash_61150086f42e0ae1");
	var_2becd382 = struct::get(self.script_noteworthy);
	var_cff0c83d.var_f1560899 = spawn("trigger_damage_new", var_2becd382.origin, 0, 29, 29);
	var_cff0c83d.var_f1560899.origin = var_cff0c83d.var_f1560899.origin - (0, 0, 29);
	var_cff0c83d.var_f1560899.health = 999999;
	var_73bd6df = struct::get(self.target);
	var_99fea1a4 = util::spawn_model(var_73bd6df.model, var_73bd6df.origin, var_73bd6df.angles);
	var_ff61d09e = self.origin;
	var_293aacbe = struct::get(self.script_string);
	if(isdefined(var_293aacbe))
	{
		var_ff61d09e = var_293aacbe.origin;
	}
	var_61550b0 = 0;
	t_damage = spawn("trigger_damage_new", var_ff61d09e, 0, 61, 61);
	t_damage.health = 999999;
	while(!var_61550b0)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = t_damage waittill(#"damage");
		t_damage.health = t_damage.health + var_88706ea7.amount;
		if(isplayer(var_88706ea7.inflictor))
		{
			t_damage delete();
			var_61550b0 = 1;
			if(!(isdefined(level.var_8007cbae) && level.var_8007cbae))
			{
				level.var_8007cbae = 1;
				var_88706ea7.inflictor thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
			}
		}
	}
	var_cff0c83d stoploopsound();
	if(isdefined(self.anim_id))
	{
		level scene::play(#"hash_3ec0153ab122b92b" + self.anim_id + "_bundle", "Shot 2");
	}
	var_99fea1a4 flag::init(#"hash_7cec01549505c1f6");
	var_99fea1a4.var_b6226b48 = 1;
	var_99fea1a4.n_rotate_angle = 296;
	var_99fea1a4.var_d5b27ae8 = 0;
	var_99fea1a4 thread function_dacc5df9(var_73bd6df.target);
	var_99fea1a4 thread function_f0c7fe90();
	var_cff0c83d thread function_a0e1ae36(var_99fea1a4);
	var_99fea1a4 flag::wait_till(#"hash_7cec01549505c1f6");
	var_e18247ac = var_99fea1a4.origin;
	var_399ded8a = var_99fea1a4.var_1101ac10;
	var_eb37cc87 = util::spawn_model(#"hash_36510c7f31145aba", var_e18247ac, var_399ded8a);
	var_eb37cc87 setscale(0.92);
	var_99fea1a4 moveto(var_99fea1a4.origin, 0.01);
	var_eb37cc87 playsound(#"hash_2c3c886a5f128a1b");
	var_cff0c83d.var_b6226b48 = 1;
	var_cff0c83d.n_rotate_angle = 296;
	if(var_99fea1a4.n_rotate_angle > 0)
	{
		var_cff0c83d.n_rotate_angle = var_cff0c83d.n_rotate_angle * -1;
	}
	var_cff0c83d thread function_f0c7fe90();
	var_cff0c83d playloopsound(#"hash_3b4498972bdd0afe");
	var_dd06fc1c = getent(self.var_f2bbd25a, "targetname");
	if(!isdefined(level.var_eb5ed779))
	{
		level.var_eb5ed779 = [];
	}
	if(!isdefined(level.var_eb5ed779))
	{
		level.var_eb5ed779 = [];
	}
	else if(!isarray(level.var_eb5ed779))
	{
		level.var_eb5ed779 = array(level.var_eb5ed779);
	}
	level.var_eb5ed779[level.var_eb5ed779.size] = var_dd06fc1c;
	level.var_20622c6 clientfield::increment("" + #"hash_784f06b253332f8f");
	level.var_20622c6 hidepart("tag_chaos_0" + level.var_eb5ed779.size);
	if(level.var_eb5ed779.size >= 3)
	{
		level.var_e0146859 = 0;
		foreach(var_8899ca5c in level.var_eb5ed779)
		{
			var_8899ca5c thread function_922154d9();
		}
		level.var_20622c6.var_b6226b48 = 1;
		level.var_20622c6.n_rotate_angle = 296;
		level.var_20622c6 thread function_f0c7fe90();
		level.var_20622c6 playloopsound(#"hash_495a282fc8b810f5");
		t_damage = spawn("trigger_damage_new", level.var_20622c6.origin, 0, 61, 61);
		t_damage.health = 999999;
		t_damage.origin = t_damage.origin - (0, 0, 61);
		var_32071ca7 = 0;
		while(!var_32071ca7)
		{
			var_88706ea7 = undefined;
			var_88706ea7 = t_damage waittill(#"damage");
			t_damage.health = t_damage.health + var_88706ea7.amount;
			var_db76a822 = level.var_eb5ed779[0] function_b35c1d18() || level.var_eb5ed779[1] function_b35c1d18() || level.var_eb5ed779[2] function_b35c1d18();
			if(isplayer(var_88706ea7.inflictor) && var_88706ea7.weapon === getweapon(#"hash_1a385be4d5103a33") && var_db76a822)
			{
				t_damage delete();
				var_32071ca7 = 1;
				level.var_720c7171 = var_88706ea7.inflictor;
			}
		}
		level notify(#"hash_1beb529f935869e4");
		callback::remove_on_connect(&function_b8911151);
		level.var_20622c6 notify(#"hash_474f0368e00ce559");
		level.var_20622c6 stoploopsound();
		level.var_20622c6 playsound(#"hash_2c3c886a5f128a1b");
		var_399ded8a = level.var_20622c6.angles + vectorscale((0, -1, 0), 180);
		util::spawn_model(#"hash_36510c7f31145aba", level.var_20622c6.origin, var_399ded8a);
		foreach(var_8899ca5c in level.var_eb5ed779)
		{
			var_8899ca5c notify(#"hash_28fdd13c3ec45417");
			var_8899ca5c stoploopsound();
			var_8899ca5c playsound(#"hash_3f2007b693c27c10");
			v_forward = anglestoforward(var_8899ca5c.angles);
			s_fountain = struct::get(#"hash_120e59168f5c859d");
			var_b033e1a5 = vectornormalize(s_fountain.origin - var_8899ca5c.origin);
			v_angles = vectortoangles(var_b033e1a5);
			v_angles = (0, v_angles[1], 0);
			if(var_8899ca5c.targetname == #"hash_1d9730159c4cbb32")
			{
				v_angles = v_angles + vectorscale((0, 1, 0), 10);
			}
			var_8899ca5c rotateto(v_angles, 0.01);
		}
		a_players = util::get_active_players();
		foreach(player in a_players)
		{
			player playrumbleonentity("zm_red_step_complete_rumble");
		}
		level util::delay("reflect_reflected", "end_game", &clientfield::set, "" + #"hash_2b05d4c6217bac22", 2);
		level scene::play(#"hash_61b2bae95d706f3f");
		level flag::set(#"hash_e12ab4b5304a50d");
	}
	else
	{
		var_dd06fc1c thread function_922154d9(0);
	}
}

/*
	Name: function_7a8d146e
	Namespace: namespace_31170709
	Checksum: 0xD1AE27C5
	Offset: 0x7430
	Size: 0x286
	Parameters: 2
	Flags: None
*/
function function_7a8d146e(var_99fea1a4, v_angles)
{
	n_x = var_99fea1a4.origin[0];
	n_y = var_99fea1a4.origin[1];
	n_z = var_99fea1a4.origin[2];
	switch(self.var_d9488319)
	{
		case 0:
		{
			n_x = n_x + self.var_d9a41f3c;
			break;
		}
		case 1:
		{
			n_y = n_y + self.var_d9a41f3c;
			break;
		}
		case 2:
		{
			n_z = n_z + self.var_d9a41f3c;
			break;
		}
		default:
		{
			break;
		}
	}
	var_e18247ac = (n_x, n_y, n_z);
	if(isdefined(self.var_86928b64))
	{
		v_forward = anglestoforward(v_angles);
		var_a0fca4e1 = var_e18247ac + self.var_5b6446b4 * v_forward;
		switch(self.var_86928b64)
		{
			case 0:
			{
				var_b3337edf = var_a0fca4e1[0] - var_99fea1a4.origin[0];
				var_e18247ac = var_e18247ac + (var_b3337edf * -1, 0, 0);
				break;
			}
			case 1:
			{
				var_b3337edf = var_a0fca4e1[1] - var_99fea1a4.origin[1];
				var_e18247ac = var_e18247ac + (0, var_b3337edf * -1, 0);
				break;
			}
			case 2:
			{
				var_b3337edf = var_a0fca4e1[2] - var_99fea1a4.origin[2];
				var_e18247ac = var_e18247ac + (0, 0, var_b3337edf * -1);
				break;
			}
			default:
			{
				break;
			}
		}
	}
	return var_e18247ac;
}

/*
	Name: function_b35c1d18
	Namespace: namespace_31170709
	Checksum: 0x534C253E
	Offset: 0x76C0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_b35c1d18()
{
	var_d0f267b3 = 0;
	v_forward = anglestoforward(self.angles);
	s_fountain = struct::get(#"hash_120e59168f5c859d");
	var_b033e1a5 = vectornormalize(s_fountain.origin - self.origin);
	n_dot = vectordot(v_forward, var_b033e1a5);
	if(n_dot > 0.92)
	{
		var_d0f267b3 = 1;
	}
	return var_d0f267b3;
}

/*
	Name: function_a0e1ae36
	Namespace: namespace_31170709
	Checksum: 0xFAEC42DF
	Offset: 0x7798
	Size: 0x158
	Parameters: 1
	Flags: Linked
*/
function function_a0e1ae36(var_99fea1a4)
{
	self endon(#"hash_7cec01549505c1f6");
	self flag::init(#"hash_7cec01549505c1f6");
	self thread function_a0111782(var_99fea1a4);
	while(true)
	{
		var_2f3fee37 = abs(self.origin[self.n_axis] - var_99fea1a4.origin[self.n_axis]);
		if(var_99fea1a4.var_d5b27ae8 && var_2f3fee37 < 3)
		{
			n_rotate_angle = 61;
			if(var_99fea1a4.n_rotate_angle > 0)
			{
				n_rotate_angle = n_rotate_angle * -1;
			}
			self playsound(#"hash_42d34713fed239f2");
			self rotateroll(n_rotate_angle, 0.3);
			self waittill(#"rotatedone");
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_a0111782
	Namespace: namespace_31170709
	Checksum: 0x87A7B8B1
	Offset: 0x78F8
	Size: 0x248
	Parameters: 1
	Flags: Linked
*/
function function_a0111782(var_99fea1a4)
{
	self endon(#"hash_7cec01549505c1f6");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self.var_f1560899 waittill(#"damage");
		self.var_f1560899.health = self.var_f1560899.health + var_88706ea7.amount;
		var_2f3fee37 = abs(self.origin[self.n_axis] - var_99fea1a4.origin[self.n_axis]);
		if(var_99fea1a4.var_d5b27ae8 && var_2f3fee37 <= 3.9)
		{
			if(isplayer(var_88706ea7.inflictor) && (isdefined(var_88706ea7.weapon.isriotshield) && var_88706ea7.weapon.isriotshield))
			{
				if(!(isdefined(level.var_2a3c1c63) && level.var_2a3c1c63))
				{
					level.var_2a3c1c63 = 1;
					var_88706ea7.inflictor thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
				}
				v_angles = var_88706ea7.inflictor function_c8fd26ac();
				if(!isdefined(v_angles))
				{
					continue;
				}
				self.var_f1560899 delete();
				var_99fea1a4.var_4f9c8c58 = var_88706ea7.inflictor;
				var_99fea1a4.var_1101ac10 = v_angles;
				var_99fea1a4 flag::set(#"hash_7cec01549505c1f6");
				self flag::set(#"hash_7cec01549505c1f6");
			}
		}
	}
}

/*
	Name: function_c8fd26ac
	Namespace: namespace_31170709
	Checksum: 0x798803D2
	Offset: 0x7B48
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_c8fd26ac()
{
	self notify("10940de7d70a55a1");
	self endon("10940de7d70a55a1");
	if(isdefined(0.25))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(0.25, "timeout");
	}
	self endon(#"disconnect");
	v_angles = self.var_7808e305;
	while(!isdefined(v_angles))
	{
		v_angles = self.var_7808e305;
		waitframe(1);
	}
	return v_angles;
}

/*
	Name: function_dacc5df9
	Namespace: namespace_31170709
	Checksum: 0x5481EC69
	Offset: 0x7C18
	Size: 0x2B2
	Parameters: 1
	Flags: Linked
*/
function function_dacc5df9(str_target)
{
	self endon(#"hash_7cec01549505c1f6");
	s_target = struct::get(str_target);
	while(true)
	{
		self.var_d5b27ae8 = 0;
		if(isdefined(s_target.script_int) && s_target.script_int)
		{
			self.var_d5b27ae8 = 1;
		}
		n_move_time = 2.9;
		if(isdefined(s_target.move_time))
		{
			n_move_time = s_target.move_time;
		}
		self playloopsound(#"hash_1e2887a33211a780");
		self moveto(s_target.origin, n_move_time);
		self.var_b6226b48 = 1;
		self waittill(#"movedone");
		self.var_b6226b48 = 0;
		self notify(#"rotatedone");
		self rotateroll(1, 0.01);
		self stoploopsound();
		self.n_rotate_angle = self.n_rotate_angle * -1;
		if(isdefined(s_target.rotate_angle))
		{
			self.var_9f82b856 = self.n_rotate_angle;
			if(s_target.rotate_angle == 1 && self.n_rotate_angle < 1)
			{
				self.n_rotate_angle = self.n_rotate_angle * -1;
			}
			else if(s_target.rotate_angle == -1 && self.n_rotate_angle > 1)
			{
				self.n_rotate_angle = self.n_rotate_angle * -1;
			}
		}
		else if(isdefined(self.var_9f82b856))
		{
			self.n_rotate_angle = -1 * self.var_9f82b856;
			self.var_9f82b856 = undefined;
		}
		n_wait_time = 1.6;
		if(isdefined(s_target.wait_time))
		{
			n_wait_time = s_target.wait_time;
		}
		wait(n_wait_time);
		s_target = struct::get(s_target.target);
	}
}

/*
	Name: function_f0c7fe90
	Namespace: namespace_31170709
	Checksum: 0x870DAD89
	Offset: 0x7ED8
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_f0c7fe90()
{
	self endon(#"hash_474f0368e00ce559");
	while(true)
	{
		if(self.var_b6226b48)
		{
			self rotateroll(self.n_rotate_angle, 1.6);
			self waittill(#"rotatedone");
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_922154d9
	Namespace: namespace_31170709
	Checksum: 0x3D7B7B07
	Offset: 0x7F50
	Size: 0x236
	Parameters: 1
	Flags: Linked
*/
function function_922154d9(var_b796a21e = 1)
{
	self notify(#"hash_28fdd13c3ec45417");
	self endon(#"hash_28fdd13c3ec45417");
	v_forward = anglestoforward(self.angles);
	s_fountain = struct::get(#"hash_120e59168f5c859d");
	var_b033e1a5 = vectornormalize(s_fountain.origin - self.origin);
	v_angles = vectortoangles(var_b033e1a5);
	v_angles = (0, v_angles[1], 0);
	if(self.targetname == #"hash_1d9730159c4cbb32")
	{
		v_angles = v_angles + vectorscale((0, 1, 0), 10);
	}
	if(var_b796a21e)
	{
		self rotateto(v_angles, 0.01);
		self waittill(#"rotatedone");
		level.var_e0146859++;
		if(level.var_e0146859 == 3)
		{
			level notify(#"hash_a176192d6b745f0");
		}
		else
		{
			level waittill(#"hash_a176192d6b745f0");
		}
	}
	self playsound(#"hash_d9cd3d59940994");
	self playloopsound(#"hash_5abec0ae1cc80274");
	while(true)
	{
		self rotateyaw(296, 2.9);
		self waittill(#"rotatedone");
	}
}

/*
	Name: function_1a787421
	Namespace: namespace_31170709
	Checksum: 0xDE03576E
	Offset: 0x8190
	Size: 0x2F4
	Parameters: 2
	Flags: Linked
*/
function function_1a787421(var_77104def, var_19e802fa)
{
	level notify(#"hash_1beb529f935869e4");
	callback::remove_on_connect(&function_b8911151);
	level clientfield::set("" + #"hash_2b05d4c6217bac22", 2);
	level clientfield::set("" + #"hash_3836d3a94cf05642", 1);
	level clientfield::set("" + #"hash_53e684a319647b40", 1);
	e_player = level.var_720c7171;
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_74d703743c928320");
	}
	else
	{
		a_e_players = util::get_active_players();
		a_e_players = array::randomize(a_e_players);
		foreach(e_player in a_e_players)
		{
			if(zm_utility::is_player_valid(e_player))
			{
				e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_74d703743c928320");
				break;
			}
		}
	}
	playsoundatposition(#"hash_72db081c52e1b776", (108, -2838, -191));
	playsoundatposition(#"hash_48910dcc61ab6924", (0, 0, 0));
	if(var_19e802fa)
	{
		if(isarray(level.var_eb5ed779))
		{
			foreach(var_de94db8f in level.var_eb5ed779)
			{
				var_de94db8f notify(#"hash_28fdd13c3ec45417");
			}
		}
	}
}

/*
	Name: function_3ffc2c9e
	Namespace: namespace_31170709
	Checksum: 0x7359578A
	Offset: 0x8490
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function function_3ffc2c9e()
{
	var_1f976659 = spawnstruct();
	level.var_cc9c60d2 = var_1f976659;
	var_ee799ebb[#"easy"] = struct::get_array(#"hash_2783a0c589b287e5");
	var_ee799ebb[#"medium"] = struct::get_array(#"hash_7262d5ff710a3d2c");
	var_ee799ebb[#"hard"] = struct::get_array(#"hash_3686ffef2f4fe836");
	var_1f976659.var_ee799ebb = var_ee799ebb;
	var_61bf8b71[#"outer"] = getent("mdl_prophecy_code_easy", "targetname");
	var_61bf8b71[#"middle"] = getent("mdl_prophecy_code_medium", "targetname");
	var_61bf8b71[#"inner"] = getent("mdl_prophecy_code_hard", "targetname");
	var_1f976659.var_61bf8b71 = var_61bf8b71;
	var_7bb826c5 = getent("mdl_prophecy_block", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_7bb826c5 delete();
		foreach(var_c6ebeb1 in var_ee799ebb)
		{
			array::delete_all(var_c6ebeb1);
		}
	}
	else
	{
		var_7bb826c5 notsolid();
		var_7bb826c5 connectpaths();
	}
}

/*
	Name: function_6c7d67a0
	Namespace: namespace_31170709
	Checksum: 0x5360985
	Offset: 0x8748
	Size: 0x456
	Parameters: 1
	Flags: Linked
*/
function function_6c7d67a0(var_77104def)
{
	level endon(#"end_game", #"hash_7751da18864137ca" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	var_1f976659 = level.var_cc9c60d2;
	var_ee799ebb = var_1f976659.var_ee799ebb;
	foreach(str_difficulty, var_f5f12a34 in var_ee799ebb)
	{
		var_79a46648 = [];
		for(i = 0; i < var_f5f12a34.size; i++)
		{
			s_target = struct::get(var_f5f12a34[i].target);
			var_79a46648[i] = util::spawn_model(#"tag_origin", s_target.origin, s_target.angles);
			s_target struct::delete();
			var_f5f12a34[i] scene::init();
		}
		var_b01f45f0[str_difficulty] = var_79a46648;
	}
	var_1f976659.var_79a46648 = var_b01f45f0;
	level.var_5b7d4d8d = 1;
	level.var_f521216c = 1;
	level thread function_2ee0f84b();
	while(true)
	{
		foreach(mdl_target in var_79a46648)
		{
			namespace_4834f482::function_6d783edd(mdl_target);
		}
		foreach(str_difficulty, var_1c6c2a44 in var_ee799ebb)
		{
			if(str_difficulty != #"easy")
			{
				foreach(var_989b34f7 in var_1c6c2a44)
				{
					if(isdefined(var_989b34f7.var_24e08b15) && var_989b34f7.var_24e08b15)
					{
						var_989b34f7.var_24e08b15 = undefined;
						var_989b34f7 scene::stop();
						var_989b34f7 thread scene::play(var_989b34f7.scriptbundlename, "in");
					}
				}
			}
		}
		wait(3);
		function_310741f7(#"easy");
		wait(3);
		b_success = function_310741f7(#"medium");
		if(!b_success)
		{
			continue;
		}
		wait(3);
		b_success = function_310741f7(#"hard");
		if(!b_success)
		{
			continue;
		}
		else
		{
			break;
		}
	}
}

/*
	Name: function_2ee0f84b
	Namespace: namespace_31170709
	Checksum: 0x29C8F75C
	Offset: 0x8BA8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_2ee0f84b()
{
	level thread function_bb660b8a();
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_1e533dd76c452301");
	if(isplayer(var_88706ea7.e_player))
	{
		var_88706ea7.e_player zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
}

/*
	Name: function_bb660b8a
	Namespace: namespace_31170709
	Checksum: 0xCA9DC547
	Offset: 0x8C50
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_bb660b8a()
{
	level endon(#"hash_b8ac6bada03e328");
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_22f69672129581f6");
	if(isplayer(var_88706ea7.e_player))
	{
		var_88706ea7.e_player zm_audio::create_and_play_dialog(#"generic", #"response_negative");
	}
}

/*
	Name: function_66f49835
	Namespace: namespace_31170709
	Checksum: 0xC55E919
	Offset: 0x8CF0
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_66f49835()
{
	level endon(#"hash_1e533dd76c452301", #"hash_22f69672129581f6");
	wait(6.1);
	level notify(#"hash_4885c7e8226d2fdd", {#hash_f9486bd2:0});
}

/*
	Name: function_593e3d1f
	Namespace: namespace_31170709
	Checksum: 0xD105AE0F
	Offset: 0x8D58
	Size: 0x268
	Parameters: 2
	Flags: Linked
*/
function function_593e3d1f(var_77104def, var_19e802fa)
{
	var_1f976659 = level.var_cc9c60d2;
	var_f18de103 = var_1f976659.var_79a46648;
	if(isdefined(var_f18de103))
	{
		foreach(var_b01f45f0 in var_f18de103)
		{
			foreach(mdl_target in var_b01f45f0)
			{
				namespace_4834f482::function_6d783edd(mdl_target);
				mdl_target thread util::delayed_delete(1);
			}
		}
	}
	var_d9d7f557 = var_1f976659.var_ee799ebb;
	foreach(var_ee799ebb in var_d9d7f557)
	{
		foreach(var_5295124f in var_ee799ebb)
		{
			var_5295124f scene::stop(1);
			var_5295124f struct::delete();
		}
	}
	level.var_5b7d4d8d = undefined;
	level.var_f521216c = undefined;
	level notify(#"hash_b8ac6bada03e328");
}

/*
	Name: function_310741f7
	Namespace: namespace_31170709
	Checksum: 0x9E205DAA
	Offset: 0x8FC8
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function function_310741f7(var_1cd2521, n_time_limit)
{
	level endon(#"end_game", #"hash_7751da18864137ca" + "_ended_early");
	var_1f976659 = level.var_cc9c60d2;
	var_ee799ebb = var_1f976659.var_ee799ebb[var_1cd2521];
	var_1f976659.var_c77a0713 = 0;
	var_1f976659.var_46b09973 = var_ee799ebb.size;
	var_b01f45f0 = var_1f976659.var_79a46648;
	var_79a46648 = var_b01f45f0[var_1cd2521];
	for(i = 0; i < var_ee799ebb.size; i++)
	{
		mdl_target = var_79a46648[i];
		var_ee799ebb[i] thread function_c538a5b7(mdl_target);
	}
	if(var_1cd2521 != #"easy")
	{
		level thread function_66f49835();
	}
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_1e5cf7b7965152f3", #"hash_4885c7e8226d2fdd");
	if(var_88706ea7.var_f9486bd2 != var_ee799ebb.size)
	{
		foreach(mdl_target in var_79a46648)
		{
			mdl_target notify(#"hash_580cbae7da0c821d");
		}
		level notify(#"hash_22f69672129581f6", {#e_player:var_88706ea7.e_player});
		level waittill(#"hash_768102de761a94ee");
		return 0;
	}
	level notify(#"hash_1e533dd76c452301", {#e_player:var_88706ea7.e_player});
	return 1;
}

/*
	Name: function_c538a5b7
	Namespace: namespace_31170709
	Checksum: 0x29B22ED6
	Offset: 0x9260
	Size: 0x348
	Parameters: 1
	Flags: Linked
*/
function function_c538a5b7(mdl_target)
{
	level endon(#"end_game", #"hash_7751da18864137ca" + "_ended_early", #"hash_768102de761a94ee", #"hash_580cbae7da0c821d");
	self endon(#"death");
	mdl_target endon(#"death");
	if(!(isdefined(self.var_24e08b15) && self.var_24e08b15))
	{
		mdl_target clientfield::increment("" + #"hash_797e7381ba62ff8a");
		self.var_24e08b15 = 1;
		self scene::play(self.scriptbundlename, "out");
	}
	mdl_target val::set(#"hash_3d3c7d9db3deecea", "takedamage", 1);
	namespace_4834f482::function_5fc81f0a(mdl_target);
	while(true)
	{
		mdl_target.health = 999999;
		var_be17187b = undefined;
		var_be17187b = mdl_target waittill(#"damage", #"hash_580cbae7da0c821d");
		w_weapon = var_be17187b.weapon;
		if(is_wonder_weapon(w_weapon, #"earth", 1) || is_wonder_weapon(w_weapon, #"earth", 0))
		{
			break;
		}
		else if(var_be17187b._notify == #"hash_580cbae7da0c821d")
		{
			break;
		}
	}
	if(var_be17187b._notify != #"hash_580cbae7da0c821d")
	{
		mdl_target clientfield::increment("" + #"hash_797e7381ba62ff8a");
	}
	self.var_24e08b15 = undefined;
	self thread scene::play(self.scriptbundlename, "in");
	namespace_4834f482::function_6d783edd(mdl_target);
	mdl_target val::reset(#"hash_3d3c7d9db3deecea", "takedamage");
	var_1f976659 = level.var_cc9c60d2;
	var_1f976659.var_c77a0713++;
	if(var_1f976659.var_c77a0713 >= var_1f976659.var_46b09973)
	{
		level notify(#"hash_768102de761a94ee");
	}
}

/*
	Name: function_f275243f
	Namespace: namespace_31170709
	Checksum: 0xFB7289ED
	Offset: 0x95B0
	Size: 0x130
	Parameters: 0
	Flags: None
*/
function function_f275243f()
{
	level endon(#"end_game", #"hash_7751da18864137ca" + "_ended_early", #"hash_6961c92dc5b5cb68");
	var_1f976659 = level.var_cc9c60d2;
	var_feb69dca = var_1f976659.var_feb69dca;
	v_target = var_feb69dca.origin;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_3ac605b3a73cc198");
		v_hit = var_be17187b.v_origin;
		if(isdefined(v_hit))
		{
			n_dist = distance2dsquared(v_hit, v_target);
			if(n_dist <= 64 * 64)
			{
				break;
			}
		}
	}
	level notify(#"hash_687e8fa112fa1330");
}

/*
	Name: function_c311ba46
	Namespace: namespace_31170709
	Checksum: 0x54F04782
	Offset: 0x96E8
	Size: 0x276
	Parameters: 1
	Flags: Linked
*/
function function_c311ba46(var_77104def)
{
	level endon(#"end_game", #"hash_2e55ff1b489306ce" + "_ended_early");
	level.var_ed006fe8 = array(3);
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	zm::register_zombie_damage_override_callback(&function_907d5e60);
	s_scene = struct::get(#"hash_5cdbfb51944a90ff", "scriptbundlename");
	s_scene.var_6efb24e2 = 1;
	while(true)
	{
		var_8756a1bd = namespace_75cbf125::function_6249817(1, s_scene);
		if(isdefined(var_8756a1bd))
		{
			break;
		}
		util::wait_network_frame();
	}
	var_8756a1bd namespace_bd668ff::function_59e9f77b();
	var_8756a1bd.var_e946c8e8 = 1;
	var_8756a1bd namespace_bd668ff::function_d06af584();
	var_8756a1bd scene::stop();
	level thread scene::play(#"hash_5cdbfb51944a90ff", var_8756a1bd);
	var_8756a1bd.var_126d7bef = 1;
	var_8756a1bd.ignore_round_spawn_failsafe = 1;
	var_8756a1bd.b_ignore_cleanup = 1;
	var_8756a1bd.ignore_enemy_count = 1;
	var_8756a1bd.var_3c394b1b = 1;
	var_8756a1bd.no_powerups = 1;
	var_8756a1bd.maxhealth = var_8756a1bd.maxhealth * 2;
	var_8756a1bd.health = var_8756a1bd.health * 2;
	var_1f976659 = level.var_cc9c60d2;
	var_1f976659.var_8756a1bd = var_8756a1bd;
	while(isalive(var_8756a1bd))
	{
		waitframe(1);
	}
	var_1f976659.var_a7bb7d71 = var_8756a1bd.origin;
}

/*
	Name: function_907d5e60
	Namespace: namespace_31170709
	Checksum: 0xC860CFFD
	Offset: 0x9968
	Size: 0xD8
	Parameters: 13
	Flags: Linked
*/
function function_907d5e60(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	var_1f976659 = level.var_cc9c60d2;
	if(isdefined(var_1f976659))
	{
		var_8756a1bd = var_1f976659.var_8756a1bd;
		if(var_8756a1bd === self && (isdefined(death) && death))
		{
			self namespace_bd668ff::function_59e9f77b();
		}
	}
	return damage;
}

/*
	Name: function_d0656fba
	Namespace: namespace_31170709
	Checksum: 0xC4C932FF
	Offset: 0x9A48
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_d0656fba(var_77104def, var_19e802fa)
{
	var_8e761bf6 = struct::get(#"hash_3556fe84a78fb6b");
	if(isdefined(var_8e761bf6))
	{
		var_8e761bf6 struct::delete();
	}
	var_1f976659 = level.var_cc9c60d2;
	var_8756a1bd = var_1f976659.var_8756a1bd;
	if(var_19e802fa && isdefined(var_8756a1bd))
	{
		while(zm_utility::is_magic_bullet_shield_enabled(var_8756a1bd))
		{
			waitframe(1);
		}
		var_1f976659.var_a7bb7d71 = var_8756a1bd.origin;
		var_8756a1bd namespace_bd668ff::function_59e9f77b();
		var_8756a1bd kill();
	}
}

/*
	Name: function_f7b5ebc7
	Namespace: namespace_31170709
	Checksum: 0xCFA7657A
	Offset: 0x9B58
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function function_f7b5ebc7(var_77104def)
{
	level endon(#"end_game", #"hash_7f8f1fe8f7b285d0" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	var_1f976659 = level.var_cc9c60d2;
	var_f426e4c8 = struct::get(#"hash_7c6d4a7c40906a70");
	if(!isdefined(var_1f976659.var_a7bb7d71))
	{
		var_1f976659.var_a7bb7d71 = var_f426e4c8.origin;
	}
	v_origin = var_1f976659.var_a7bb7d71;
	a_info = zm_utility::function_b0eeaada(v_origin);
	if(isdefined(a_info))
	{
		var_eb4fc39f = a_info[#"point"];
		if(isdefined(var_eb4fc39f))
		{
			v_origin = var_eb4fc39f;
		}
	}
	if(!zm_utility::check_point_in_playable_area(v_origin))
	{
		v_origin = var_f426e4c8.origin;
	}
	var_f426e4c8 struct::delete();
	v_origin = v_origin + (0, 0, 95);
	v_angles = vectorscale((0, 0, 1), 165);
	var_1f976659.var_eb37cc87 = util::spawn_model("c_t8_zmb_dlc2_gegenees_spear_golden", v_origin, v_angles);
	var_1f976659.var_eb37cc87 playsound(#"hash_5dd75be565f9cc2");
	e_player = var_1f976659.var_eb37cc87 zm_unitrigger::function_fac87205(&function_8ddf09ff, 96);
	var_1f976659.var_8257a25e = e_player;
	e_player playsound(#"hash_230737b2535a3374");
}

/*
	Name: function_3fda7cb
	Namespace: namespace_31170709
	Checksum: 0x124C9AC5
	Offset: 0x9DA8
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_3fda7cb(var_77104def, var_19e802fa)
{
	var_f426e4c8 = struct::get(#"hash_7c6d4a7c40906a70");
	if(isdefined(var_f426e4c8))
	{
		var_f426e4c8 struct::delete();
	}
	var_1f976659 = level.var_cc9c60d2;
	var_eb37cc87 = var_1f976659.var_eb37cc87;
	if(isdefined(var_eb37cc87))
	{
		if(isdefined(var_eb37cc87.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(var_eb37cc87.s_unitrigger);
			var_eb37cc87.s_unitrigger = undefined;
		}
		var_eb37cc87 delete();
	}
	if(!var_77104def && !var_19e802fa)
	{
		e_player = var_1f976659.var_8257a25e;
		if(zm_utility::is_player_valid(e_player))
		{
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_3cfe15f9edeeb79c");
		}
	}
}

/*
	Name: function_8ddf09ff
	Namespace: namespace_31170709
	Checksum: 0xB47A84F3
	Offset: 0x9EF0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_8ddf09ff(e_player)
{
	return zm_utility::is_player_valid(e_player);
}

/*
	Name: function_ceb38216
	Namespace: namespace_31170709
	Checksum: 0xEC742859
	Offset: 0x9F20
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function function_ceb38216(var_77104def)
{
	level endon(#"end_game", #"hash_7f8f1fe8f7b285d0" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	s_loc = struct::get(#"hash_1deabdaf47d6a78");
	e_player = s_loc zm_unitrigger::function_fac87205(&function_63b805db, 96);
}

/*
	Name: function_8d2b7b74
	Namespace: namespace_31170709
	Checksum: 0xA6CDB0A8
	Offset: 0x9FD0
	Size: 0x360
	Parameters: 2
	Flags: Linked
*/
function function_8d2b7b74(var_77104def, var_19e802fa)
{
	s_loc = struct::get(#"hash_1deabdaf47d6a78");
	if(isdefined(s_loc.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
		s_loc.s_unitrigger = undefined;
	}
	var_1f976659 = level.var_cc9c60d2;
	var_aac4a37f = struct::get(#"hash_18ff2df3f645697b");
	var_eb37cc87 = util::spawn_model("c_t8_zmb_dlc2_gegenees_spear_golden", var_aac4a37f.origin, var_aac4a37f.angles);
	var_aac4a37f struct::delete();
	var_f8d39ecf = struct::get(#"hash_69e0bef55957f3ff");
	var_48474ec7 = util::spawn_model(#"tag_origin", var_f8d39ecf.origin, var_f8d39ecf.angles);
	var_f8d39ecf struct::delete();
	var_7bb826c5 = getent("mdl_prophecy_block", "targetname");
	var_7bb826c5 solid();
	var_7bb826c5 disconnectpaths();
	var_48474ec7 linkto(var_eb37cc87);
	var_7bb826c5 linkto(var_eb37cc87);
	var_1f976659.var_eb37cc87 = var_eb37cc87;
	var_1f976659.var_48474ec7 = var_48474ec7;
	level clientfield::increment("" + #"hash_530e1caa1a8c81d2");
	var_eb37cc87 playsound(#"hash_6e7410aad6f58cde");
	var_608a9071 = var_eb37cc87.angles + (0, 90, 0);
	var_eb37cc87 rotateto(var_608a9071, 1);
	var_eb37cc87 waittill_timeout(1, #"rotatedone");
	wait(1);
	var_eb37cc87 playsound(#"hash_647f96cdf0b9fce0");
	var_eb37cc87 movez(8 * -1, 1);
	var_eb37cc87 waittill_timeout(1, #"movedone");
}

/*
	Name: function_63b805db
	Namespace: namespace_31170709
	Checksum: 0x4D130D3F
	Offset: 0xA338
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_63b805db(e_player)
{
	return zm_utility::is_player_valid(e_player);
}

/*
	Name: function_d424710c
	Namespace: namespace_31170709
	Checksum: 0x4C1217F8
	Offset: 0xA368
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_d424710c(var_77104def)
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	function_4c903aa5();
}

/*
	Name: function_7724c926
	Namespace: namespace_31170709
	Checksum: 0xE2ACBCD0
	Offset: 0xA3D0
	Size: 0x294
	Parameters: 2
	Flags: Linked
*/
function function_7724c926(var_77104def, var_19e802fa)
{
	level notify(#"hash_1995757cb678aacb");
	callback::remove_on_ai_killed(&function_c48b575b);
	var_1f976659 = level.var_cc9c60d2;
	var_625d23b8 = var_1f976659.var_625d23b8;
	if(isdefined(var_625d23b8))
	{
		var_625d23b8 show();
	}
	var_14d5aa56 = var_1f976659.var_14d5aa56;
	if(isdefined(var_14d5aa56))
	{
		array::delete_all(var_14d5aa56);
	}
	s_unitrigger = struct::get(#"hash_1deabdaf47d6a78");
	if(isdefined(s_unitrigger))
	{
		if(isdefined(s_unitrigger.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_unitrigger.s_unitrigger);
			s_unitrigger.s_unitrigger = undefined;
		}
		s_unitrigger struct::delete();
	}
	s_end = struct::get(#"hash_a42e01481663cf0");
	s_end struct::delete();
	var_48474ec7 = var_1f976659.var_48474ec7;
	if(isdefined(var_48474ec7))
	{
		var_48474ec7 clientfield::set("" + #"hash_22acf133b0aa208a", 0);
		var_48474ec7 delete();
	}
	level.var_ed006fe8 = undefined;
	if(var_77104def || var_19e802fa)
	{
		level thread function_8ed9dd3c();
	}
	else
	{
		function_8ed9dd3c();
	}
	level flag::set(#"hash_6b77f898f5d70f1c");
	playsoundatposition(#"hash_48910ccc61ab6771", (0, 0, 0));
	level.var_cc9c60d2 struct::delete();
}

/*
	Name: function_4c903aa5
	Namespace: namespace_31170709
	Checksum: 0x6B0C17C2
	Offset: 0xA670
	Size: 0x9E6
	Parameters: 0
	Flags: Linked
*/
function function_4c903aa5()
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	callback::on_ai_killed(&function_c48b575b);
	level thread function_ade40c4a();
	level thread function_3ddff1b4();
	var_1f976659 = level.var_cc9c60d2;
	var_61bf8b71 = var_1f976659.var_61bf8b71;
	var_3ab52107 = array(2, 3, 4, 5, 6, 7, 8);
	b_clockwise = math::cointoss();
	s_unitrigger = struct::get(#"hash_1deabdaf47d6a78");
	s_unitrigger zm_unitrigger::create(&function_63b805db, 96);
	s_unitrigger thread function_8e8da19a();
	foreach(var_1222bd48, var_d0cd0dba in var_61bf8b71)
	{
		switch(var_1222bd48)
		{
			case "outer":
			{
				var_dcc2eee3 = 0.5;
				var_ef2b4932 = 0.5;
				str_scene = #"hash_1f1bb50b909dd41b";
				var_7a64a440 = "outer";
				str_letter = "a";
				break;
			}
			case "middle":
			{
				var_dcc2eee3 = 0.5;
				var_ef2b4932 = 0.25;
				str_scene = #"hash_738dc1b0721689c7";
				var_7a64a440 = "mid";
				str_letter = "b";
				break;
			}
			case "inner":
			{
				var_dcc2eee3 = 0.25;
				var_ef2b4932 = 0.25;
				str_scene = #"hash_6f79773cf26cd02e";
				var_7a64a440 = "inner";
				str_letter = "c";
				break;
			}
		}
		var_69836136 = "alchemical_symbol_" + str_letter + "_";
		var_58cb9965 = var_d0cd0dba.angles;
		while(true)
		{
			var_d0cd0dba.angles = var_58cb9965;
			var_1f976659.var_d7ebba27 = 0;
			var_1f976659.var_3dd6bbe9 = 0;
			var_1f976659.var_4bd614ab = 0;
			level waittill(#"hash_22acf133b0aa208a");
			var_1f976659.var_3dd6bbe9 = 1;
			var_1f976659.var_48474ec7 clientfield::set("" + #"hash_22acf133b0aa208a", 1);
			var_fb1b957b = array::random(var_3ab52107);
			for(i = 1; i <= 8; i++)
			{
				str_on = var_69836136 + i + "_on_jnt";
				str_off = var_69836136 + i + "_off_jnt";
				if(i == var_fb1b957b)
				{
					var_d0cd0dba showpart(str_on);
					var_d0cd0dba hidepart(str_off);
					continue;
				}
				var_d0cd0dba hidepart(str_on);
				var_d0cd0dba showpart(str_off);
			}
			var_8a435e75 = function_21a3a673(2, 4);
			str_shot = var_7a64a440 + "_0" + var_8a435e75 + "_open";
			level scene::play(str_scene, str_shot);
			b_clockwise = !b_clockwise;
			var_137a6201 = var_fb1b957b;
			while(isdefined(var_1f976659.var_3dd6bbe9) && var_1f976659.var_3dd6bbe9)
			{
				if(b_clockwise)
				{
					var_137a6201--;
					if(var_137a6201 == 0)
					{
						var_137a6201 = 8;
					}
				}
				else
				{
					var_137a6201++;
					if(var_137a6201 == 8 + 1)
					{
						var_137a6201 = 1;
					}
				}
				var_82d542fb = var_137a6201 == 1;
				if(var_82d542fb)
				{
					var_1f976659.var_4bd614ab = 1;
				}
				var_d0cd0dba function_a92eaaa(b_clockwise, var_dcc2eee3);
				if(isdefined(var_1f976659.var_3dd6bbe9) && var_1f976659.var_3dd6bbe9 && var_ef2b4932 > 0)
				{
					wait(var_ef2b4932);
				}
				if(var_82d542fb)
				{
					level thread function_f3979ca2();
				}
			}
			var_1f976659.var_48474ec7 clientfield::set("" + #"hash_22acf133b0aa208a", 0);
			str_shot = var_7a64a440 + "_0" + var_8a435e75 + "_close";
			level scene::play(str_scene, str_shot);
			e_player = var_1f976659.var_6a8e51de;
			if(isdefined(var_1f976659.var_113bf6cb) && var_1f976659.var_113bf6cb)
			{
				var_b93429b = (0, 45 * var_fb1b957b - 1, 0);
				var_d0cd0dba.angles = var_58cb9965 - var_b93429b;
				str_shot = var_7a64a440 + "_01_open";
				level scene::play(str_scene, str_shot);
				wait(1);
				if(zm_utility::is_player_valid(e_player))
				{
					switch(var_1222bd48)
					{
						case "outer":
						{
							level thread function_590ba57a(e_player);
							break;
						}
						case "middle":
						{
							e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
							break;
						}
						case "inner":
						{
							level thread function_ca906c66(e_player);
							break;
						}
					}
				}
				var_eb37cc87 = var_1f976659.var_eb37cc87;
				var_eb37cc87 playrumbleonentity(#"hash_2f90ad8c2371d73d");
				var_850120d = 16;
				var_42496c02 = 2;
				var_7a831b48 = var_1222bd48 == #"inner";
				str_alias = #"hash_7dd8d603476a2fdc";
				if(var_7a831b48)
				{
					var_850120d = 64;
					var_42496c02 = 8;
					str_alias = #"hash_2115ac365fbaf55f";
				}
				var_eb37cc87 playsound(str_alias);
				var_eb37cc87 movez(var_850120d * -1, var_42496c02);
				var_eb37cc87 waittill(#"movedone");
				if(var_7a831b48)
				{
					var_7bb826c5 = getent("mdl_prophecy_block", "targetname");
					var_7bb826c5 delete();
				}
				var_1f976659.var_113bf6cb = undefined;
				break;
			}
			var_1f976659.var_6a8e51de = undefined;
		}
	}
}

/*
	Name: function_f3979ca2
	Namespace: namespace_31170709
	Checksum: 0xB5BEA302
	Offset: 0xB060
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_f3979ca2()
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	wait(0.1);
	var_1f976659 = level.var_cc9c60d2;
	if(isdefined(var_1f976659))
	{
		var_1f976659.var_4bd614ab = 0;
	}
}

/*
	Name: function_590ba57a
	Namespace: namespace_31170709
	Checksum: 0x174D2B8A
	Offset: 0xB0D0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_590ba57a(e_player)
{
	if(!isdefined(e_player))
	{
		return;
	}
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	e_player endon(#"disconnect");
	if(zm_utility::is_player_valid(e_player))
	{
		e_player namespace_891c9bac::function_a2bd5a0c(#"hash_3f73cd79382c519");
	}
	wait(2);
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_11241cd3fee87d8c");
	}
}

/*
	Name: function_ca906c66
	Namespace: namespace_31170709
	Checksum: 0xD7770C05
	Offset: 0xB1A0
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_ca906c66(e_player)
{
	if(!isdefined(e_player))
	{
		return;
	}
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	e_player endon(#"disconnect");
	if(e_player namespace_48f3568::function_69e9e553(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6")))
	{
		if(zm_utility::is_player_valid(e_player))
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_682a22908f49f4ab");
		}
		if(var_845efa03 === 1)
		{
			e_player thread namespace_891c9bac::function_8e0f4696(#"hash_5b1fc7fce1734175", undefined, undefined, undefined, undefined, 1);
		}
	}
	else if(zm_utility::is_player_valid(e_player))
	{
		e_player thread zm_audio::create_and_play_dialog(#"hash_68a62c5935265ce1", #"final");
	}
}

/*
	Name: function_c48b575b
	Namespace: namespace_31170709
	Checksum: 0xC1655E0
	Offset: 0xB310
	Size: 0x120
	Parameters: 1
	Flags: Linked
*/
function function_c48b575b(s_params)
{
	if(self.archetype == #"hash_1bab8a0ba811401e" && self.var_9fde8624 == #"hash_266b62e342076a90")
	{
		var_1f976659 = level.var_cc9c60d2;
		var_eb37cc87 = var_1f976659.var_eb37cc87;
		n_dist = distance2dsquared(self.origin, var_eb37cc87.origin);
		if(!(isdefined(var_1f976659.var_d7ebba27) && var_1f976659.var_d7ebba27) && n_dist <= 128 * 128)
		{
			var_1f976659.var_d7ebba27 = 1;
			level function_7e47a01a(self.origin);
			level notify(#"hash_22acf133b0aa208a");
		}
	}
}

/*
	Name: function_7e47a01a
	Namespace: namespace_31170709
	Checksum: 0x9925A3D4
	Offset: 0xB438
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_7e47a01a(v_start)
{
	params = level.var_7fe61e7a;
	s_end = struct::get(#"hash_a42e01481663cf0");
	if(!isdefined(s_end))
	{
		return;
	}
	v_end = s_end.origin;
	mdl_fx = util::spawn_model(#"tag_origin", v_start);
	mdl_fx clientfield::set("" + #"hash_30660c47aae060a9", 1);
	mdl_fx moveto(v_end, params.arc_travel_time);
	mdl_fx waittill(#"death", #"movedone");
	mdl_fx clientfield::set("" + #"hash_30660c47aae060a9", 0);
	mdl_fx delete();
}

/*
	Name: function_ade40c4a
	Namespace: namespace_31170709
	Checksum: 0xDE484492
	Offset: 0xB5A8
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_ade40c4a()
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early", #"hash_1995757cb678aacb");
	while(true)
	{
		level thread function_3c71e07d();
		level waittill(#"end_of_round");
	}
}

/*
	Name: function_3c71e07d
	Namespace: namespace_31170709
	Checksum: 0x491F14E0
	Offset: 0xB630
	Size: 0x406
	Parameters: 0
	Flags: Linked
*/
function function_3c71e07d()
{
	self notify("a7b89283a4c0771");
	self endon("a7b89283a4c0771");
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early", #"end_of_round", #"hash_1995757cb678aacb");
	var_1f976659 = level.var_cc9c60d2;
	var_eb37cc87 = var_1f976659.var_eb37cc87;
	var_6aac9774 = var_eb37cc87.origin;
	for(i = 0; i < 2; i++)
	{
		b_has_spawned = 0;
		while(true)
		{
			wait(30);
			if(isdefined(var_1f976659.var_d7ebba27) && var_1f976659.var_d7ebba27)
			{
				continue;
			}
			var_e244831f = getaiarchetypearray(#"hash_1bab8a0ba811401e");
			var_e7f5b3e0 = 1;
			foreach(var_47c2dcf7 in var_e244831f)
			{
				if(isalive(var_47c2dcf7) && var_47c2dcf7.var_9fde8624 == #"hash_266b62e342076a90")
				{
					var_e7f5b3e0 = 0;
					break;
				}
			}
			if(var_e7f5b3e0 && !namespace_3fffba66::function_abf1dcb4(#"hash_266b62e342076a90"))
			{
				a_ai_zombies = getaiarchetypearray(#"zombie");
				a_ai_zombies = array::randomize(a_ai_zombies);
				foreach(ai_zombie in a_ai_zombies)
				{
					if(isdefined(ai_zombie.completed_emerging_into_playable_area) && ai_zombie.completed_emerging_into_playable_area && !zm_utility::is_magic_bullet_shield_enabled(ai_zombie) && (!(isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death)) && (!(isdefined(ai_zombie.var_94c53b42) && ai_zombie.var_94c53b42)) && (!(isdefined(ai_zombie.var_52531256) && ai_zombie.var_52531256)) && (!(isdefined(ai_zombie.var_3c394b1b) && ai_zombie.var_3c394b1b)) && ai_zombie namespace_e0710ee6::function_db610082())
					{
						b_has_spawned = 1;
						level thread namespace_3fffba66::function_9acf76e6(ai_zombie, #"hash_266b62e342076a90");
						break;
					}
				}
			}
			if(b_has_spawned)
			{
				break;
			}
		}
	}
}

/*
	Name: function_3ddff1b4
	Namespace: namespace_31170709
	Checksum: 0x59D28B35
	Offset: 0xBA40
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_3ddff1b4()
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early", #"hash_1995757cb678aacb");
	var_1f976659 = level.var_cc9c60d2;
	var_eb37cc87 = var_1f976659.var_eb37cc87;
	var_6aac9774 = var_eb37cc87.origin;
	while(true)
	{
		wait(1);
		a_corpses = getcorpsearray();
		a_corpses = arraysortclosest(a_corpses, var_6aac9774, undefined, 0, 150);
		foreach(corpse in a_corpses)
		{
			if(isdefined(corpse) && (!(isdefined(corpse.var_acce8803) && corpse.var_acce8803)))
			{
				corpse.var_acce8803 = 1;
				corpse thread util::delayed_delete(5);
			}
			util::wait_network_frame();
		}
	}
}

/*
	Name: function_a92eaaa
	Namespace: namespace_31170709
	Checksum: 0x1D1EA7F
	Offset: 0xBBF0
	Size: 0x15A
	Parameters: 2
	Flags: Linked
*/
function function_a92eaaa(b_clockwise, var_dcc2eee3)
{
	self endon(#"death");
	v_angles = self.angles;
	if(b_clockwise)
	{
		var_1df0b136 = v_angles - vectorscale((0, 1, 0), 45);
	}
	else
	{
		var_1df0b136 = v_angles + vectorscale((0, 1, 0), 45);
	}
	var_a36ad416 = v_angles[1];
	if(var_a36ad416 >= 360 || var_a36ad416 <= -360)
	{
		v_angles = (0, 0, 0);
	}
	if(var_dcc2eee3 >= 0.5)
	{
		self playsound(#"hash_868e3ed7747ae38");
	}
	else
	{
		self playsound(#"hash_d4c1b4d970f73ef");
	}
	self thread function_b2c1549();
	self rotateto(var_1df0b136, var_dcc2eee3);
	self waittill(#"rotatedone");
}

/*
	Name: function_b2c1549
	Namespace: namespace_31170709
	Checksum: 0xA01209BF
	Offset: 0xBD58
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_b2c1549()
{
	self endon(#"death");
	wait(0.1);
	self playrumbleonentity(#"hash_1bdf9c4013e4d12f");
}

/*
	Name: function_8e8da19a
	Namespace: namespace_31170709
	Checksum: 0xB1061F85
	Offset: 0xBDA8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_8e8da19a()
{
	level endon(#"end_game", #"hash_38a06e6fa57d2c74" + "_ended_early");
	self endon(#"death");
	var_1f976659 = level.var_cc9c60d2;
	var_80841b2c = function_4d1e7b48("blind_zm_catalyst");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_player = var_be17187b.e_who;
		if(isdefined(var_1f976659.var_3dd6bbe9) && var_1f976659.var_3dd6bbe9)
		{
			if(isdefined(var_1f976659.var_4bd614ab) && var_1f976659.var_4bd614ab)
			{
				var_1f976659.var_6a8e51de = e_player;
				var_1f976659.var_113bf6cb = 1;
				var_1f976659.var_eb37cc87 playsound(#"hash_49d17300fbc95a4a");
			}
			else
			{
				var_eb37cc87 = var_1f976659.var_eb37cc87;
				if(!isdefined(var_eb37cc87))
				{
					var_eb37cc87 = e_player;
				}
				e_player playsound(#"hash_5af2a9d11f007b9");
				e_player thread status_effect::status_effect_apply(var_80841b2c, undefined, var_eb37cc87);
				e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_negative");
			}
			e_player clientfield::increment_to_player("" + #"hash_11480c2b11f0c92f");
			var_1f976659.var_3dd6bbe9 = 0;
			level notify(#"hash_79c10e50a279a37f");
		}
	}
}

/*
	Name: function_8ed9dd3c
	Namespace: namespace_31170709
	Checksum: 0x79804EBE
	Offset: 0xBFF0
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_8ed9dd3c()
{
	level endon(#"end_game");
	var_a6ac7ab6 = struct::get(#"hash_6ac21db894ff6862");
	str_model = var_a6ac7ab6.model;
	v_origin = var_a6ac7ab6.origin;
	v_angles = var_a6ac7ab6.angles;
	var_a6ac7ab6 struct::delete();
	v_origin = v_origin - (0, 0, 118);
	var_919d328 = util::spawn_model(str_model, v_origin, v_angles);
	var_919d328 setscale(0.43);
	var_919d328 movez(118, 5);
	playrumbleonposition(#"hash_78384ae5c2a95e85", v_origin);
	playsoundatposition(#"hash_396f1597d3662c78", (0, 0, 0));
	wait(5 - 1.5);
	level clientfield::set("" + #"hash_3836d3a94cf05642", 2);
	level clientfield::set("" + #"hash_70e157c389c1c02f", 1);
}

/*
	Name: init_light
	Namespace: namespace_31170709
	Checksum: 0x7D48CD11
	Offset: 0xC1E8
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function init_light()
{
	s_light = spawnstruct();
	level.var_5299790a = s_light;
	var_9ef22ee0 = struct::get(#"hash_629b7a21e0492c7f");
	s_light.var_7b57e2cc = util::spawn_model(var_9ef22ee0.model, var_9ef22ee0.origin, var_9ef22ee0.angles);
	s_light.var_7b57e2cc setscale(0.5);
	var_9ef22ee0 struct::delete();
	level scene::add_scene_func(#"hash_7ad421e5d2a71030", &function_9d73ee19, "init");
	level thread scene::init(#"hash_7ad421e5d2a71030");
	if(zm_utility::function_e51dc2d8())
	{
		s_staff = struct::get(#"hash_711f47fcf57e02d6");
		s_light.var_d422b652 = util::spawn_model(s_staff.model, s_staff.origin, s_staff.angles);
		s_staff struct::delete();
		str_shot = "init_idle";
	}
	else
	{
		str_shot = "lower_staff";
		level thread function_f10904df();
	}
	level scene::add_scene_func(#"hash_434a2df99683c51c", &function_abba38a8, str_shot, str_shot);
	level thread scene::play(#"hash_434a2df99683c51c", str_shot);
}

/*
	Name: function_9d73ee19
	Namespace: namespace_31170709
	Checksum: 0xFA7448E6
	Offset: 0xC440
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_9d73ee19(a_ents)
{
	s_light = level.var_5299790a;
	s_light.var_8d22740d = a_ents[#"hash_7aff0ee60ddd937b"];
	level scene::remove_scene_func(#"hash_7ad421e5d2a71030", &function_9d73ee19, "init");
}

/*
	Name: function_abba38a8
	Namespace: namespace_31170709
	Checksum: 0x46BC94DF
	Offset: 0xC4C8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_abba38a8(a_ents, str_shot)
{
	s_light = level.var_5299790a;
	s_light.var_19d2da88 = a_ents[#"hash_7aff0ee60ddd937b"];
	level scene::remove_scene_func(#"hash_434a2df99683c51c", &function_abba38a8, str_shot);
}

/*
	Name: function_f342bc18
	Namespace: namespace_31170709
	Checksum: 0xCA849615
	Offset: 0xC550
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_f342bc18(var_77104def)
{
	level endon(#"end_game", #"hash_59b9d987109997c8" + "_ended_early");
	if(var_77104def)
	{
		level thread function_11d400f9();
		return;
	}
	function_11d400f9();
	level thread function_38548080();
	level thread function_aabfb424();
	spawner::add_archetype_spawn_function(#"gegenees", &function_d62a2d14);
	array::thread_all(getaiarchetypearray(#"gegenees"), &function_d62a2d14);
	level waittill(#"hash_6a89add74b46c461");
}

/*
	Name: function_beb7d290
	Namespace: namespace_31170709
	Checksum: 0x1A7E1BD3
	Offset: 0xC688
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_beb7d290(var_77104def, var_19e802fa)
{
	level notify(#"hash_6a89add74b46c461");
	s_light = level.var_5299790a;
	s_light.var_5e622c60 = 1;
	level scene::play(#"hash_7ad421e5d2a71030", "Shot 1");
	if(!var_77104def && !var_19e802fa)
	{
		var_8d22740d = s_light.var_8d22740d;
		a_e_players = util::get_active_players();
		a_e_players = arraysortclosest(a_e_players, var_8d22740d.origin, undefined, 0, 512);
		foreach(e_player in a_e_players)
		{
			if(zm_utility::is_player_valid(e_player))
			{
				e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
				break;
			}
		}
	}
}

/*
	Name: function_11d400f9
	Namespace: namespace_31170709
	Checksum: 0xF99EECEE
	Offset: 0xC828
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_11d400f9()
{
	s_start = struct::get(#"hash_b2180b8714f30b");
	mdl_fx = util::spawn_model(#"tag_origin", s_start.origin);
	s_start struct::delete();
	mdl_fx clientfield::set("" + #"hash_6d76e4b7a31537af", 1);
	s_end = struct::get(#"hash_16d7f49b344088ee");
	v_end = s_end.origin;
	mdl_fx moveto(v_end, 0.5);
	mdl_fx waittill_timeout(0.5, #"movedone");
	mdl_fx playsound(#"hash_772b6a593788929f");
	mdl_fx clientfield::set("" + #"hash_6d76e4b7a31537af", 0);
	level clientfield::increment("" + #"hash_4d77ba61cd7f3eb7");
	s_light = level.var_5299790a;
	s_light.var_7b57e2cc delete();
}

/*
	Name: function_38548080
	Namespace: namespace_31170709
	Checksum: 0x846AB0AC
	Offset: 0xCA20
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_38548080()
{
	level endon(#"end_game", #"hash_59b9d987109997c8" + "_ended_early", #"hash_6a89add74b46c461");
	s_light = level.var_5299790a;
	var_5bc8925e = s_light.var_19d2da88;
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
			{
				n_dist = distance2dsquared(e_player.origin, var_5bc8925e.origin);
				if(n_dist <= 128 * 128)
				{
					level notify(#"hash_705d83d9c92550de");
					e_player thread zm_audio::create_and_play_dialog(#"hash_200626ef77358c1b", #"hash_7a616dd0c242ce92");
					return;
				}
			}
		}
		wait(2);
	}
}

/*
	Name: function_aabfb424
	Namespace: namespace_31170709
	Checksum: 0x414BC514
	Offset: 0xCBE0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_aabfb424()
{
	level endon(#"end_game", #"hash_59b9d987109997c8" + "_ended_early", #"hash_6a89add74b46c461");
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		level thread function_49b3f5aa();
	}
}

/*
	Name: function_49b3f5aa
	Namespace: namespace_31170709
	Checksum: 0x1BF1598E
	Offset: 0xCC68
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function function_49b3f5aa()
{
	self notify("f01c424d82d3513");
	self endon("f01c424d82d3513");
	level endon(#"end_game", #"hash_59b9d987109997c8" + "_ended_early", #"end_of_round", #"hash_6a89add74b46c461");
	n_random_wait = randomfloatrange(10, 30);
	wait(n_random_wait);
	var_d5bd9bcb = getaiarchetypearray(#"gegenees");
	if(namespace_c3287616::function_d0db51fc(#"gegenees") || var_d5bd9bcb.size > 0)
	{
		return;
	}
	s_target = struct::get(#"hash_2419db3559d2bbcb");
	v_target = s_target.origin;
	while(true)
	{
		var_eb3b90d = level.zm_loc_types[#"gegenees_location"];
		if(var_eb3b90d.size > 0)
		{
			s_spawn = arraygetclosest(v_target, var_eb3b90d);
			while(true)
			{
				var_8756a1bd = namespace_75cbf125::function_6249817(1, s_spawn);
				if(isdefined(var_8756a1bd))
				{
					return;
				}
				util::wait_network_frame();
			}
		}
		util::wait_network_frame();
	}
}

/*
	Name: function_d62a2d14
	Namespace: namespace_31170709
	Checksum: 0x17B5C682
	Offset: 0xCE60
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_d62a2d14()
{
	self notify("63970f0e43bba472");
	self endon("63970f0e43bba472");
	level endon(#"end_game", #"hash_59b9d987109997c8" + "_ended_early", #"hash_6a89add74b46c461");
	self endon(#"death");
	s_light = level.var_5299790a;
	if(!isdefined(s_light) || (isdefined(s_light.var_5e622c60) && s_light.var_5e622c60))
	{
		return;
	}
	s_target = struct::get(#"hash_2419db3559d2bbcb");
	v_target = s_target.origin;
	while(true)
	{
		self waittill(#"hash_10501c0a873461f9");
		n_dist = distancesquared(self.origin, v_target);
		if(n_dist <= 1200 * 1200 && self util::is_looking_at(v_target, undefined, 1))
		{
			level notify(#"hash_6a89add74b46c461");
		}
	}
}

/*
	Name: function_5cd1e2d4
	Namespace: namespace_31170709
	Checksum: 0xB6AC8433
	Offset: 0xCFF8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_5cd1e2d4(var_77104def)
{
	level endon(#"end_game", #"hash_589a676acbec281a" + "_ended_early");
	s_loc = struct::get(#"hash_6812ea5a7f9fdf21");
	/#
		if(var_77104def)
		{
			s_loc struct::delete();
			return;
		}
	#/
	e_player = s_loc zm_unitrigger::function_fac87205(&function_8e7bc7d6);
	e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_78f60d6898d690f");
	e_player playsound(#"hash_27af4f102b79c3c0");
}

/*
	Name: function_9e4314ec
	Namespace: namespace_31170709
	Checksum: 0x6BDEAC30
	Offset: 0xD0F0
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_9e4314ec(var_77104def, var_19e802fa)
{
	s_loc = struct::get(#"hash_6812ea5a7f9fdf21");
	if(isdefined(s_loc))
	{
		if(isdefined(s_loc.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
			s_loc.s_unitrigger = undefined;
		}
		s_loc struct::delete();
	}
	level scene::play(#"hash_7ad421e5d2a71030", "Shot 2");
}

/*
	Name: function_8e7bc7d6
	Namespace: namespace_31170709
	Checksum: 0xCAD34798
	Offset: 0xD1B8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_8e7bc7d6(e_player)
{
	s_light = level.var_5299790a;
	var_8d22740d = s_light.var_8d22740d;
	v_target = var_8d22740d gettagorigin("tag_chaos_chunks_all");
	var_39b20ef6 = e_player zm_utility::is_player_looking_at(v_target, 0.9, 0);
	b_is_valid = zm_utility::is_player_valid(e_player);
	return var_39b20ef6 && b_is_valid;
}

/*
	Name: function_7c9ece4f
	Namespace: namespace_31170709
	Checksum: 0xF2C94C13
	Offset: 0xD280
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_7c9ece4f(var_77104def)
{
	level endon(#"end_game", #"hash_b2e4c67e2932769" + "_ended_early");
	s_loc = struct::get(#"hash_68e5680a6c84cf71");
	/#
		if(var_77104def)
		{
			s_loc struct::delete();
			return;
		}
	#/
	s_light = level.var_5299790a;
	var_19d2da88 = s_light.var_19d2da88;
	s_light.var_7134dc2b = var_19d2da88 gettagorigin("ankh_jnt");
	s_loc zm_unitrigger::function_fac87205(&function_4998929a);
	s_loc struct::delete();
}

/*
	Name: function_3b1a65ee
	Namespace: namespace_31170709
	Checksum: 0x5C9A5F59
	Offset: 0xD398
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_3b1a65ee(var_77104def, var_19e802fa)
{
	s_loc = struct::get(#"hash_68e5680a6c84cf71");
	if(isdefined(s_loc))
	{
		if(isdefined(s_loc.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
			s_loc.s_unitrigger = undefined;
		}
		s_loc struct::delete();
	}
	level scene::play(#"hash_434a2df99683c51c", "give_ankh");
}

/*
	Name: function_4998929a
	Namespace: namespace_31170709
	Checksum: 0x5C2C2BE
	Offset: 0xD460
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_4998929a(e_player)
{
	s_light = level.var_5299790a;
	var_39b20ef6 = e_player zm_utility::is_player_looking_at(s_light.var_7134dc2b, 0.9, 0);
	b_is_valid = zm_utility::is_player_valid(e_player);
	var_ca29a143 = 1;
	if(isdefined(s_light.var_f1e9d276) && s_light.var_f1e9d276)
	{
		w_current = e_player getcurrentweapon();
		var_ca29a143 = is_wonder_weapon(w_current, #"light", 0);
	}
	return var_39b20ef6 && b_is_valid && var_ca29a143;
}

/*
	Name: function_4259a2c9
	Namespace: namespace_31170709
	Checksum: 0x8411302
	Offset: 0xD570
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_4259a2c9(var_77104def)
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	function_ecbc541d();
}

/*
	Name: function_ddcd9609
	Namespace: namespace_31170709
	Checksum: 0xCBB6D30F
	Offset: 0xD5D8
	Size: 0x310
	Parameters: 2
	Flags: Linked
*/
function function_ddcd9609(var_77104def, var_19e802fa)
{
	function_9f390ef0(0);
	s_unitrigger = struct::get(#"hash_56ba037bba790648");
	if(isdefined(s_unitrigger) && isdefined(s_unitrigger.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(s_unitrigger.s_unitrigger);
		s_unitrigger.s_unitrigger = undefined;
	}
	var_f5a17b42 = struct::get(#"hash_1cc363b6ee27ea18");
	if(isdefined(var_f5a17b42))
	{
		var_f5a17b42 struct::delete();
	}
	var_bc18bce = getent("t_light_fuel_ignite_close", "targetname");
	var_46e3b24 = getent("t_light_fuel_ignite_far", "targetname");
	var_bc18bce delete();
	var_46e3b24 delete();
	a_s_scenes = struct::get_array(#"hash_eef2e238d701a8e");
	foreach(s_scene in a_s_scenes)
	{
		var_1e6432ae = struct::get(s_scene.target);
		var_1e6432ae struct::delete();
		s_scene scene::stop();
		s_scene struct::delete();
	}
	var_2a28e6d4 = getaiarchetypearray(#"skeleton");
	foreach(var_862206ea in var_2a28e6d4)
	{
		var_862206ea.var_67faa700 = undefined;
		var_862206ea val::reset(#"hash_644a9e9d528c2f44", "ignoreall");
	}
}

/*
	Name: function_ecbc541d
	Namespace: namespace_31170709
	Checksum: 0xBDEE7C5B
	Offset: 0xD8F0
	Size: 0x918
	Parameters: 0
	Flags: Linked
*/
function function_ecbc541d()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c");
	s_light = level.var_5299790a;
	var_19d2da88 = s_light.var_19d2da88;
	level.var_8016c0d8 = 40;
	s_light.var_f1e9d276 = 1;
	s_light.var_7134dc2b = var_19d2da88 gettagorigin("staff_jnt");
	s_unitrigger = struct::get(#"hash_56ba037bba790648");
	var_f5a17b42 = struct::get(#"hash_1cc363b6ee27ea18");
	var_d93f6af3 = var_f5a17b42.model;
	var_151563d0 = var_f5a17b42.origin;
	var_97e6bcd7 = var_f5a17b42.angles;
	var_f5a17b42 struct::delete();
	var_38b50c7 = struct::get(#"hash_ea56ff869e65f82");
	var_8d5cca6b[0] = util::spawn_model(#"hash_733272a4848675e2", var_38b50c7.origin, var_38b50c7.angles);
	var_8d5cca6b[1] = util::spawn_model(#"hash_733271a48486742f", var_38b50c7.origin, var_38b50c7.angles);
	var_8d5cca6b[2] = util::spawn_model(#"hash_733270a48486727c", var_38b50c7.origin, var_38b50c7.angles);
	var_38b50c7 struct::delete();
	s_light.var_8d5cca6b = var_8d5cca6b;
	var_bc18bce = getent("t_light_fuel_ignite_close", "targetname");
	var_46e3b24 = getent("t_light_fuel_ignite_far", "targetname");
	var_bc18bce thread function_6af7dacb();
	var_46e3b24 thread function_6af7dacb();
	var_bc18bce triggerenable(0);
	var_46e3b24 triggerenable(0);
	callback::on_connect(&function_d45f304f);
	array::thread_all(getplayers(), &function_d45f304f);
	s_light.var_1b52cf99 = level.var_b897ed83;
	level.var_b897ed83 = &function_173c692b;
	a_e_players = util::get_active_players();
	a_e_players = arraysortclosest(a_e_players, var_19d2da88.origin);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			e_player thread zm_audio::create_and_play_dialog(#"hash_200626ef77358c1b", #"hash_1bb63aa8676692a0");
			break;
		}
	}
	s_unitrigger zm_unitrigger::create(&function_4998929a);
	while(true)
	{
		while(true)
		{
			var_be17187b = undefined;
			var_be17187b = s_unitrigger waittill(#"trigger_activated");
			e_player = var_be17187b.e_who;
			if(zm_utility::is_player_valid(e_player))
			{
				w_current = e_player getcurrentweapon();
				if(is_wonder_weapon(w_current, #"light", 0))
				{
					level.var_8016c0d8 = e_player getammocount(w_current);
					break;
				}
			}
		}
		e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
		var_b235f9b8 = util::spawn_model(var_d93f6af3, var_151563d0, var_97e6bcd7);
		var_b235f9b8 setscale(2.2);
		var_b235f9b8 playsound(#"hash_6d4d114514ea4566");
		s_light.var_24a1abd7 = var_b235f9b8;
		var_b235f9b8 playloopsound(#"hash_5a4a005ac681a695");
		var_26eac22c = e_player.var_7e19c3db;
		e_player.var_7e19c3db = 1;
		e_player thread function_cd5fc887(var_26eac22c);
		var_f657affa = function_36afae35(#"light");
		foreach(var_4d248f0c in var_f657affa)
		{
			if(e_player hasweapon(var_4d248f0c))
			{
				e_player takeweapon(var_4d248f0c);
				break;
			}
		}
		wait(2);
		level flag::set(#"infinite_round_spawning");
		var_b235f9b8 stoploopsound();
		var_b235f9b8 playsound(#"hash_2612baeb741d5600");
		level thread function_3288a0d2();
		level thread function_202bd7b8();
		level thread function_a30dee24();
		level waittill(#"hash_2f511b37fc55c45a");
		a_e_players = util::get_active_players();
		a_e_players = arraysortclosest(a_e_players, var_19d2da88.origin, undefined, 0, 1024);
		a_e_players = array::randomize(a_e_players);
		foreach(e_player in a_e_players)
		{
			if(zm_utility::is_player_valid(e_player))
			{
				e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_negative");
				break;
			}
		}
		function_9f390ef0();
	}
}

/*
	Name: function_cd5fc887
	Namespace: namespace_31170709
	Checksum: 0x1015DC46
	Offset: 0xE210
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_cd5fc887(var_26eac22c)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	wait(2);
	self.var_7e19c3db = var_26eac22c;
}

/*
	Name: function_3288a0d2
	Namespace: namespace_31170709
	Checksum: 0x72CA6661
	Offset: 0xE268
	Size: 0x246
	Parameters: 0
	Flags: Linked
*/
function function_3288a0d2()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_2f511b37fc55c45a");
	level thread function_e5352d71();
	var_bc18bce = getent("t_light_fuel_ignite_close", "targetname");
	var_46e3b24 = getent("t_light_fuel_ignite_far", "targetname");
	while(true)
	{
		var_bc18bce triggerenable(1);
		var_46e3b24 triggerenable(1);
		level clientfield::set("" + #"hash_43972920fa314daa", 1);
		level thread function_6511349e();
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_d0d79bd22a685c1");
		var_d01e844a = var_be17187b.var_d01e844a;
		level clientfield::set("" + #"hash_43972920fa314daa", var_d01e844a);
		if(var_d01e844a == 2)
		{
			var_46e3b24 triggerenable(0);
		}
		var_83aeafd6 = var_be17187b.var_83aeafd6;
		if(isdefined(var_83aeafd6))
		{
			level thread function_1c1d4313();
			while(isdefined(var_83aeafd6) && isalive(var_83aeafd6))
			{
				waitframe(1);
			}
		}
	}
}

/*
	Name: function_6511349e
	Namespace: namespace_31170709
	Checksum: 0xC928D40B
	Offset: 0xE4B8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_6511349e()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early");
	s_light = level.var_5299790a;
	var_5bc8925e = s_light.var_19d2da88;
	if(!isdefined(s_light.var_93919a1f))
	{
		s_light.var_93919a1f = 60;
	}
	n_start_time = gettime();
	var_be17187b = undefined;
	var_be17187b = level waittill_timeout(s_light.var_93919a1f, #"hash_d0d79bd22a685c1");
	if(var_be17187b._notify == #"hash_d0d79bd22a685c1")
	{
		var_f661e07a = gettime();
		s_light.var_93919a1f = s_light.var_93919a1f - float(var_f661e07a - n_start_time) / 1000;
	}
	else
	{
		level notify(#"hash_4140f0472ba137c");
	}
}

/*
	Name: function_e5352d71
	Namespace: namespace_31170709
	Checksum: 0x811288CC
	Offset: 0xE600
	Size: 0x240
	Parameters: 0
	Flags: Linked
*/
function function_e5352d71()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_2f511b37fc55c45a");
	s_light = level.var_5299790a;
	var_8d5cca6b = s_light.var_8d5cca6b;
	var_42e59b17 = var_8d5cca6b.size;
	var_e41dced6 = 60 / var_42e59b17 + 1;
	foreach(var_740e1e0e in var_8d5cca6b)
	{
		n_time_left = var_e41dced6;
		while(true)
		{
			n_start_time = gettime();
			var_be17187b = undefined;
			var_be17187b = level waittill_timeout(n_time_left, #"hash_d0d79bd22a685c1");
			if(var_be17187b._notify == #"hash_d0d79bd22a685c1")
			{
				var_f661e07a = gettime();
				n_time_passed = float(var_f661e07a - n_start_time) / 1000;
				n_time_left = n_time_left - n_time_passed;
				var_83aeafd6 = var_be17187b.var_83aeafd6;
				while(isdefined(var_83aeafd6) && isalive(var_83aeafd6))
				{
					waitframe(1);
				}
			}
			else
			{
				break;
			}
		}
		var_740e1e0e clientfield::set("" + #"hash_125706eb7b363924", 1);
	}
}

/*
	Name: function_1c1d4313
	Namespace: namespace_31170709
	Checksum: 0xFAFC6753
	Offset: 0xE848
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_1c1d4313()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_7eef54a6ef1d07e8");
	wait(5);
	level notify(#"hash_2f511b37fc55c45a");
}

/*
	Name: function_202bd7b8
	Namespace: namespace_31170709
	Checksum: 0x13EEB5AF
	Offset: 0xE8B8
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function function_202bd7b8()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c", #"hash_2f511b37fc55c45a");
	n_random_wait = randomfloatrange(10, 30);
	wait(n_random_wait);
	s_light = level.var_5299790a;
	var_5bc8925e = s_light.var_19d2da88;
	var_81cc0bab = var_5bc8925e.origin;
	while(true)
	{
		if(!namespace_3fffba66::function_abf1dcb4(#"blight_father"))
		{
			var_2d23a7ee = getaiarchetypearray(#"blight_father");
			var_2d23a7ee = arraysortclosest(var_2d23a7ee, var_81cc0bab, undefined, 0, 1024);
			if(var_2d23a7ee.size == 0)
			{
				a_ai_zombies = getaiarchetypearray(#"zombie");
				a_ai_zombies = arraysortclosest(a_ai_zombies, var_81cc0bab, undefined, 0, 1024);
				a_ai_zombies = array::randomize(a_ai_zombies);
				foreach(ai_zombie in a_ai_zombies)
				{
					if(isdefined(ai_zombie.completed_emerging_into_playable_area) && ai_zombie.completed_emerging_into_playable_area && !zm_utility::is_magic_bullet_shield_enabled(ai_zombie) && (!(isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death)) && (!(isdefined(ai_zombie.var_94c53b42) && ai_zombie.var_94c53b42)) && (!(isdefined(ai_zombie.var_52531256) && ai_zombie.var_52531256)) && (!(isdefined(ai_zombie.var_3c394b1b) && ai_zombie.var_3c394b1b)) && ai_zombie namespace_e0710ee6::function_db610082())
					{
						level thread namespace_3fffba66::function_9acf76e6(ai_zombie, #"blight_father");
						return;
					}
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_a30dee24
	Namespace: namespace_31170709
	Checksum: 0x33E5E8BB
	Offset: 0xEC00
	Size: 0x388
	Parameters: 0
	Flags: Linked
*/
function function_a30dee24()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c", #"hash_2f511b37fc55c45a");
	s_light = level.var_5299790a;
	var_eb3b90d = struct::get_array(#"hash_33fd28ee963853d6");
	while(true)
	{
		var_2a28e6d4 = getaiarchetypearray(#"skeleton");
		if(var_2a28e6d4.size <= 2)
		{
			s_spawn = array::random(var_eb3b90d);
			while(true)
			{
				var_862206ea = namespace_bc12435c::function_1ea880bd(1, s_spawn, undefined, 0);
				if(isdefined(var_862206ea))
				{
					break;
				}
				util::wait_network_frame();
			}
			if(level.zombie_total > 0)
			{
				level.zombie_total--;
			}
			if(level.zombie_respawns > 0)
			{
				level.zombie_respawns--;
			}
			if(!isdefined(var_2a28e6d4))
			{
				var_2a28e6d4 = [];
			}
			else if(!isarray(var_2a28e6d4))
			{
				var_2a28e6d4 = array(var_2a28e6d4);
			}
			var_2a28e6d4[var_2a28e6d4.size] = var_862206ea;
		}
		var_83aeafd6 = s_light.var_83aeafd6;
		if(!isdefined(var_83aeafd6) || !isalive(var_83aeafd6) || (isdefined(var_83aeafd6.fake_death) && var_83aeafd6.fake_death))
		{
			level notify(#"hash_7eef54a6ef1d07e8");
			foreach(var_862206ea in var_2a28e6d4)
			{
				if(isdefined(var_862206ea.var_4e9f7942) && var_862206ea.var_4e9f7942 && (!(isdefined(var_862206ea.fake_death) && var_862206ea.fake_death)) && (!(isdefined(var_862206ea.aat_turned) && var_862206ea.aat_turned)))
				{
					s_light.var_83aeafd6 = var_862206ea;
					var_862206ea.var_d3ddc8ed = 1;
					var_862206ea.var_126d7bef = 1;
					var_862206ea.ignore_round_spawn_failsafe = 1;
					var_862206ea.b_ignore_cleanup = 1;
					var_862206ea.var_3c394b1b = 1;
					var_862206ea thread function_e4162ab8();
					break;
				}
			}
		}
		util::wait_network_frame();
	}
}

/*
	Name: function_e4162ab8
	Namespace: namespace_31170709
	Checksum: 0x569C15E8
	Offset: 0xEF90
	Size: 0x394
	Parameters: 0
	Flags: Linked
*/
function function_e4162ab8()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c", #"hash_2f511b37fc55c45a");
	self endon(#"death", #"hash_4a05d34e6e2ebdf0");
	self thread watch_for_fake_death();
	waitframe(1);
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		self.completed_emerging_into_playable_area = 1;
		self notify(#"completed_emerging_into_playable_area");
	}
	self zombie_utility::set_zombie_run_cycle_override_value("sprint");
	self val::set(#"hash_644a9e9d528c2f44", "ignoreall", 1);
	a_s_scenes = struct::get_array(#"hash_eef2e238d701a8e");
	s_scene = arraygetclosest(self.origin, a_s_scenes);
	var_3c74628d = s_scene.origin;
	s_source = struct::get(#"hash_28652987572c5885");
	v_source = s_source.origin;
	self.var_67faa700 = 1;
	self setgoal(var_3c74628d, 1);
	while(true)
	{
		n_dist = distance2dsquared(self.origin, var_3c74628d);
		if(n_dist <= 64 * 64)
		{
			break;
		}
		waitframe(1);
	}
	self notify(#"goal");
	n_dot = self math::get_dot_right(v_source);
	if(n_dot > 0)
	{
		str_scene = #"hash_6d1fff2d23ac09ea";
	}
	else
	{
		str_scene = #"hash_256f627494515380";
	}
	self.var_37f733c3 = 1;
	s_scene scene::stop();
	self thread function_fbbee9d0(s_scene, str_scene);
	level waittill_timeout(4, #"hash_ff74c046715d687");
	var_1e6432ae = struct::get(s_scene.target);
	var_d01e844a = var_1e6432ae.var_333e279d;
	level notify(#"hash_d0d79bd22a685c1", {#hash_d01e844a:var_d01e844a, #hash_83aeafd6:self});
	self thread function_554bdd28(s_scene, str_scene);
}

/*
	Name: function_fbbee9d0
	Namespace: namespace_31170709
	Checksum: 0x7CCA575D
	Offset: 0xF330
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_fbbee9d0(s_scene, str_scene)
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c", #"hash_2f511b37fc55c45a");
	self endon(#"death", #"hash_4a05d34e6e2ebdf0");
	s_scene scene::play(str_scene, "init", self);
	s_scene thread scene::play(str_scene, "loop", self);
}

/*
	Name: watch_for_fake_death
	Namespace: namespace_31170709
	Checksum: 0x4D2094C9
	Offset: 0xF408
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function watch_for_fake_death()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c", #"hash_2f511b37fc55c45a");
	self endon(#"death");
	if(!(isdefined(self.fake_death) && self.fake_death))
	{
		while(!(isdefined(self.fake_death) && self.fake_death))
		{
			waitframe(1);
		}
	}
	if(isdefined(self.var_37f733c3) && self.var_37f733c3)
	{
		self util::stop_magic_bullet_shield();
		self kill();
	}
	else
	{
		self notify(#"hash_4a05d34e6e2ebdf0");
	}
}

/*
	Name: function_554bdd28
	Namespace: namespace_31170709
	Checksum: 0xDC432755
	Offset: 0xF518
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_554bdd28(s_scene, str_scene)
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c");
	self endon(#"death");
	level waittill(#"hash_2f511b37fc55c45a");
	s_scene scene::play(str_scene, "exit", self);
	self val::reset(#"hash_644a9e9d528c2f44", "ignoreall");
	self.var_67faa700 = undefined;
	self.var_126d7bef = undefined;
	self.ignore_round_spawn_failsafe = undefined;
	self.b_ignore_cleanup = undefined;
	self thread zombie_utility::round_spawn_failsafe();
}

/*
	Name: function_173c692b
	Namespace: namespace_31170709
	Checksum: 0x7AE1B2F
	Offset: 0xF620
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_173c692b()
{
	if(isdefined(self.var_d3ddc8ed) && self.var_d3ddc8ed)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_6af7dacb
	Namespace: namespace_31170709
	Checksum: 0x8101E681
	Offset: 0xF650
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function function_6af7dacb()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c");
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		e_victim = var_be17187b.activator;
		if(isdefined(e_victim) && isactor(e_victim))
		{
			var_dee5880d = 0;
			var_8e22b0cb = 0;
			switch(e_victim.archetype)
			{
				case "zombie":
				{
					var_dee5880d = 1;
					break;
				}
				case "hash_1bab8a0ba811401e":
				{
					var_dee5880d = 1;
					break;
				}
				case "gegenees":
				{
					var_8e22b0cb = 1;
					var_1ca047d8 = 0.1;
					break;
				}
			}
			if(var_dee5880d && !zm_utility::is_magic_bullet_shield_enabled(e_victim))
			{
				gibserverutils::annihilate(e_victim);
				e_victim kill();
				continue;
			}
			if(var_8e22b0cb && (!(isdefined(e_victim.var_77e2b5bf) && e_victim.var_77e2b5bf)))
			{
				e_victim.var_77e2b5bf = 1;
				e_victim thread function_124c623e();
			}
			if(isdefined(var_1ca047d8) && (!(isdefined(e_victim.var_a3156ec0) && e_victim.var_a3156ec0)))
			{
				e_victim.var_a3156ec0 = 1;
				n_damage = int(e_victim.maxhealth * var_1ca047d8);
				e_victim dodamage(n_damage, e_victim.origin);
				e_victim thread function_89a22f4e();
			}
		}
	}
}

/*
	Name: function_124c623e
	Namespace: namespace_31170709
	Checksum: 0x7A6FEDD6
	Offset: 0xF8F8
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_124c623e()
{
	self endon(#"death");
	self thread ai::stun(3);
	wait(3 + 4);
	self.var_77e2b5bf = undefined;
}

/*
	Name: function_89a22f4e
	Namespace: namespace_31170709
	Checksum: 0x41A73115
	Offset: 0xF958
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_89a22f4e()
{
	self endon(#"death");
	wait(1);
	self.var_a3156ec0 = undefined;
}

/*
	Name: function_d45f304f
	Namespace: namespace_31170709
	Checksum: 0x5AE3D794
	Offset: 0xF988
	Size: 0x2AA
	Parameters: 0
	Flags: Linked
*/
function function_d45f304f()
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c");
	self endon(#"disconnect");
	if(isdefined(self.var_59378b6a) && self.var_59378b6a)
	{
		return;
	}
	self.var_59378b6a = 1;
	self.var_6e4f26e5 = 0;
	var_bc18bce = getent("t_light_fuel_ignite_close", "targetname");
	var_46e3b24 = getent("t_light_fuel_ignite_far", "targetname");
	self thread function_c2d50fdc(var_bc18bce);
	self thread function_c2d50fdc(var_46e3b24);
	while(true)
	{
		self waittill(#"hash_465838105ca1e0c2");
		self allowsprint(0);
		self allowslide(0);
		self setmovespeedscale(0.5);
		if(!isbot(self))
		{
			self clientfield::set_to_player("" + #"hash_25cfe5e9786d97e7", 1);
		}
		self.var_de9eef5a = 1;
		while(true)
		{
			self waittill(#"hash_488d86d3e6f92c");
			if(self.var_6e4f26e5 <= 0)
			{
				break;
			}
		}
		self allowsprint(1);
		self allowslide(1);
		self setmovespeedscale(1);
		if(!isbot(self))
		{
			self clientfield::set_to_player("" + #"hash_25cfe5e9786d97e7", 0);
		}
		self.var_de9eef5a = undefined;
	}
}

/*
	Name: function_c2d50fdc
	Namespace: namespace_31170709
	Checksum: 0x70075310
	Offset: 0xFC40
	Size: 0x21A
	Parameters: 1
	Flags: Linked
*/
function function_c2d50fdc(var_7ecf0d18)
{
	level endon(#"end_game", #"hash_177b41a8c9da003b" + "_ended_early", #"hash_4140f0472ba137c");
	self endon(#"disconnect");
	var_7ecf0d18 endon(#"death");
	while(true)
	{
		while(!zm_utility::is_player_valid(self) || self getstance() == "crouch" || self getstance() == "prone" || self issliding() || !self istouching(var_7ecf0d18) || !var_7ecf0d18 istriggerenabled())
		{
			waitframe(1);
		}
		self.var_6e4f26e5++;
		self notify(#"hash_465838105ca1e0c2");
		while(zm_utility::is_player_valid(self) && self getstance() != "crouch" && self getstance() != "prone" && !self issliding() && self istouching(var_7ecf0d18) && var_7ecf0d18 istriggerenabled())
		{
			waitframe(1);
		}
		self.var_6e4f26e5--;
		self notify(#"hash_488d86d3e6f92c");
	}
}

/*
	Name: function_9f390ef0
	Namespace: namespace_31170709
	Checksum: 0x2B340170
	Offset: 0xFE68
	Size: 0x34C
	Parameters: 1
	Flags: Linked
*/
function function_9f390ef0(var_3561625b = 1)
{
	level flag::clear(#"infinite_round_spawning");
	s_light = level.var_5299790a;
	s_light.var_6c41dc66 = undefined;
	s_light.var_93919a1f = undefined;
	if(isdefined(s_light.var_24a1abd7))
	{
		s_light.var_24a1abd7 stoploopsound();
		s_light.var_24a1abd7 delete();
	}
	level clientfield::set("" + #"hash_43972920fa314daa", 0);
	var_bc18bce = getent("t_light_fuel_ignite_close", "targetname");
	var_46e3b24 = getent("t_light_fuel_ignite_far", "targetname");
	var_bc18bce triggerenable(0);
	var_46e3b24 triggerenable(0);
	callback::remove_on_connect(&function_d45f304f);
	if(isdefined(s_light.var_1b52cf99))
	{
		level.var_b897ed83 = s_light.var_1b52cf99;
	}
	foreach(e_player in getplayers())
	{
		if(isdefined(e_player.var_de9eef5a) && e_player.var_de9eef5a)
		{
			e_player allowsprint(1);
			e_player allowslide(1);
			e_player setmovespeedscale(1);
			if(!isbot(e_player))
			{
				e_player clientfield::set_to_player("" + #"hash_25cfe5e9786d97e7", 0);
			}
			e_player.var_de9eef5a = undefined;
		}
	}
	if(var_3561625b)
	{
		var_8d5cca6b = s_light.var_8d5cca6b;
		if(isdefined(var_8d5cca6b))
		{
			array::run_all(var_8d5cca6b, &clientfield::set, "" + #"hash_125706eb7b363924", 0);
		}
	}
	level thread function_e952e361();
}

/*
	Name: function_e952e361
	Namespace: namespace_31170709
	Checksum: 0xAB31F51A
	Offset: 0x101C0
	Size: 0x16E
	Parameters: 0
	Flags: Linked
*/
function function_e952e361()
{
	level endon(#"end_game");
	while(true)
	{
		var_92121491 = spawner::simple_spawn_single("sp_light_return");
		if(isdefined(var_92121491))
		{
			break;
		}
		util::wait_network_frame();
	}
	var_92121491 clientfield::set("" + #"hash_7fc7f7b5958831d4", 1);
	wait(1);
	if(isdefined(var_92121491))
	{
		nd_start = getvehiclenode("nd_light_return", "targetname");
		var_92121491 vehicle::get_on_and_go_path(nd_start);
		if(isdefined(var_92121491))
		{
			var_92121491 clientfield::set("" + #"hash_7fc7f7b5958831d4", 0);
			var_92121491 delete();
		}
	}
	level thread namespace_b7e8677a::function_887b7e4b(#"light", level.var_8016c0d8);
	level.var_8016c0d8 = undefined;
}

/*
	Name: function_ec93aa41
	Namespace: namespace_31170709
	Checksum: 0x5F14AF6
	Offset: 0x10338
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function function_ec93aa41(var_77104def)
{
	level endon(#"end_game", #"hash_2ef35a0caeaf1677" + "_ended_early");
	if(!var_77104def)
	{
		wait(2);
	}
	s_light = level.var_5299790a;
	var_8d5cca6b = s_light.var_8d5cca6b;
	if(isdefined(var_8d5cca6b))
	{
		var_8d5cca6b = array::remove_undefined(var_8d5cca6b);
		array::delete_all(var_8d5cca6b);
	}
	level thread scene::play(#"hash_6cde458e75cfe4f7");
	var_4b6d2c14 = getent("script_brush_hole_blend_01", "targetname");
	var_4b6d2c14 delete();
	s_loc = struct::get(#"hash_1ab7c0d94efd8f5b");
	/#
		if(var_77104def)
		{
			s_loc struct::delete();
			return;
		}
	#/
	level thread function_de6854c2();
	e_player = s_loc zm_unitrigger::function_fac87205(&function_4340daa);
	e_player playsound(#"hash_7209c8ab82d14e04");
	s_loc struct::delete();
}

/*
	Name: function_63c49b59
	Namespace: namespace_31170709
	Checksum: 0xCA304AF4
	Offset: 0x10510
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_63c49b59(var_77104def, var_19e802fa)
{
	level notify(#"hash_5fcd23307b562aca");
	s_loc = struct::get(#"hash_1ab7c0d94efd8f5b");
	if(isdefined(s_loc))
	{
		if(isdefined(s_loc.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
			s_loc.s_unitrigger = undefined;
		}
		s_loc struct::delete();
	}
	s_light = level.var_5299790a;
	s_light.var_d422b652 delete();
}

/*
	Name: function_de6854c2
	Namespace: namespace_31170709
	Checksum: 0x57C6C0F2
	Offset: 0x105F8
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_de6854c2()
{
	level endon(#"end_game");
	s_dest = struct::get(#"hash_1ab7c0d94efd8f5b");
	v_dest = s_dest.origin;
	var_845efa03 = 0;
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
			{
				n_dist = distance2dsquared(e_player.origin, v_dest);
				if(n_dist <= 64 * 64)
				{
					var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_54a1b97aabbc232e");
					if(isdefined(var_845efa03) && var_845efa03)
					{
						break;
					}
				}
			}
		}
		if(isdefined(var_845efa03) && var_845efa03)
		{
			break;
		}
		wait(1);
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
		level zm_audio::sndvoxoverride(1);
		function_7b345f6d(#"hash_9d670ad099b664c");
		level zm_audio::sndvoxoverride(0);
	}
}

/*
	Name: function_4340daa
	Namespace: namespace_31170709
	Checksum: 0xED6E980B
	Offset: 0x10830
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_4340daa(e_player)
{
	return zm_utility::is_player_valid(e_player);
}

/*
	Name: function_1533614
	Namespace: namespace_31170709
	Checksum: 0x860F647
	Offset: 0x10860
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_1533614(var_77104def)
{
	level endon(#"end_game", #"hash_6f1d1e83bc66b715" + "_ended_early");
	s_loc = struct::get(#"hash_56ba037bba790648");
	/#
		if(var_77104def)
		{
			s_loc struct::delete();
			return;
		}
	#/
	s_light = level.var_5299790a;
	var_19d2da88 = s_light.var_19d2da88;
	s_light.var_f1e9d276 = 0;
	s_light.var_7134dc2b = var_19d2da88 gettagorigin("staff_jnt");
	e_player = s_loc zm_unitrigger::function_fac87205(&function_4998929a);
	s_light.var_6f46a620 = e_player;
	e_player playsound(#"hash_339e50753ce9c39b");
}

/*
	Name: function_8faf150e
	Namespace: namespace_31170709
	Checksum: 0x8662FA3B
	Offset: 0x109A8
	Size: 0x3BC
	Parameters: 2
	Flags: Linked
*/
function function_8faf150e(var_77104def, var_19e802fa)
{
	s_loc = struct::get(#"hash_56ba037bba790648");
	if(isdefined(s_loc))
	{
		if(isdefined(s_loc.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(s_loc.s_unitrigger);
			s_loc.s_unitrigger = undefined;
		}
		s_loc struct::delete();
	}
	s_light = level.var_5299790a;
	e_player = s_light.var_6f46a620;
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
	level thread function_f10904df();
	level scene::play(#"hash_434a2df99683c51c", "aim_staff");
	if(!var_77104def && !var_19e802fa)
	{
		level clientfield::set("" + #"hash_158233cdc645bef6", 1);
		foreach(e_player in getplayers())
		{
			e_player clientfield::increment_to_player("" + #"hash_492a33037a532fe0");
		}
		wait(10);
		level clientfield::set("" + #"hash_158233cdc645bef6", 0);
	}
	level thread function_5436fd42();
	var_fbefc1ba = struct::get(#"hash_6873469a7f41e2af");
	var_e527b76d = struct::get(#"hash_258b38a5968b7b5a");
	var_fbefc1ba struct::delete();
	var_e527b76d struct::delete();
	level thread scene::play(#"hash_434a2df99683c51c", "lower_staff");
	if(var_77104def || var_19e802fa)
	{
		level thread function_82b3a72();
	}
	else
	{
		function_82b3a72();
	}
	level flag::set(#"hash_79fd5851173fd4f6");
	playsoundatposition(#"hash_48910bcc61ab65be", (0, 0, 0));
	level.var_5299790a struct::delete();
}

/*
	Name: function_f10904df
	Namespace: namespace_31170709
	Checksum: 0xD5C01FF3
	Offset: 0x10D70
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_f10904df()
{
	level endon(#"end_game");
	level flag::wait_till("all_players_spawned");
	s_light = level.var_5299790a;
	while(!isdefined(s_light.var_19d2da88))
	{
		waitframe(1);
	}
	var_8127aa11 = s_light.var_19d2da88;
	mdl_fx = util::spawn_model(#"tag_origin", var_8127aa11 gettagorigin("fx_tag_ra_scepter"), var_8127aa11 gettagangles("fx_tag_ra_scepter"));
	mdl_fx linkto(var_8127aa11, "fx_tag_ra_scepter");
	mdl_fx clientfield::set("" + #"hash_431f319e4b8fe9db", 1);
}

/*
	Name: function_5436fd42
	Namespace: namespace_31170709
	Checksum: 0xDA9ADE4D
	Offset: 0x10EB0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_5436fd42()
{
	level endon(#"end_game");
	s_rumble = struct::get(#"hash_6873469a7f41e2af");
	if(!isdefined(s_rumble))
	{
		return;
	}
	var_3e8e9404 = s_rumble.origin;
	playrumbleonposition(#"hash_bd49fc7b8840e7d", var_3e8e9404);
	var_be17187b = undefined;
	var_be17187b = level waittill_timeout(60, #"hash_4badb9f184af8780");
	if(var_be17187b._notify == "light_second_part")
	{
		playrumbleonposition(#"hash_bd49cc7b8840964", var_3e8e9404);
	}
}

/*
	Name: function_82b3a72
	Namespace: namespace_31170709
	Checksum: 0xEC14D817
	Offset: 0x10FB0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_82b3a72()
{
	level endon(#"end_game");
	level thread scene::play(#"hash_57c05025d9d2f220");
	level waittill(#"hash_125671e6c3fe4dba");
	level clientfield::set("" + #"hash_53e684a319647b40", 2);
	level clientfield::set("" + #"hash_4f59799617fef9c7", 1);
}

/*
	Name: function_29a8dcd4
	Namespace: namespace_31170709
	Checksum: 0x474E27FF
	Offset: 0x11080
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_29a8dcd4(var_77104def)
{
	namespace_ee206246::start(#"hash_162fe3b17b2752e7");
	namespace_ee206246::start(#"light");
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 4);
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	level endon(#"end_game", #"hash_1b1abb2af5960bfe" + "_ended_early");
	level thread function_59ef31c5();
	level flag::wait_till_all(array(#"hash_6b77f898f5d70f1c", #"hash_79fd5851173fd4f6"));
}

/*
	Name: function_488a4eb2
	Namespace: namespace_31170709
	Checksum: 0xC8A9E62C
	Offset: 0x11198
	Size: 0x158
	Parameters: 2
	Flags: Linked
*/
function function_488a4eb2(var_77104def, var_19e802fa)
{
	level flag::set(#"hash_6b77f898f5d70f1c");
	level flag::set(#"hash_79fd5851173fd4f6");
	/#
		if(var_77104def || var_19e802fa)
		{
			var_3a390e15 = array(#"hash_162fe3b17b2752e7", #"light");
			foreach(var_de782fc6 in var_3a390e15)
			{
				var_401b2544 = level.var_ec84950b[var_de782fc6];
				var_1c9b219a = var_401b2544.steps.size - 1;
				namespace_ee206246::function_f2dd8601(var_de782fc6, var_1c9b219a);
			}
		}
	#/
}

/*
	Name: function_59ef31c5
	Namespace: namespace_31170709
	Checksum: 0xF26AB6C0
	Offset: 0x112F8
	Size: 0x2B4
	Parameters: 0
	Flags: Linked
*/
function function_59ef31c5()
{
	level endon(#"end_game", #"hash_1b1abb2af5960bfe" + "_setup_completed", #"hash_1b1abb2af5960bfe" + "_ended_early");
	wait(10);
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_7ffb03b3b746f056");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		function_7b345f6d(#"hash_27b9dcc6ada75bb4");
	}
	level waittill(#"end_of_round", #"between_round_over", #"start_of_round", #"hash_6b77f898f5d70f1c", #"hash_79fd5851173fd4f6");
	wait(10);
	var_845efa03 = 0;
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player))
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_106b08864b5ae288");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level thread function_7b345f6d(#"hash_678f44703c046db6");
	}
}

/*
	Name: function_fd38f0c2
	Namespace: namespace_31170709
	Checksum: 0x2F40EFBF
	Offset: 0x115B8
	Size: 0x454
	Parameters: 0
	Flags: Linked
*/
function function_fd38f0c2()
{
	var_99c9ce0c = spawnstruct();
	level.var_28dcf408 = var_99c9ce0c;
	var_38e73d19[#"death"] = "" + #"hash_4aeb7fcdd8302eaa";
	var_38e73d19[#"earth"] = "" + #"hash_7a99ff005314c5fc";
	var_38e73d19[#"air"] = "" + #"hash_7f85dc0ce20a6f2c";
	var_38e73d19[#"light"] = "" + #"hash_4e3e66f200f76f34";
	var_38e73d19[#"return"] = "" + #"hash_565ca9982285f23e";
	var_99c9ce0c.var_38e73d19 = var_38e73d19;
	var_59f7dee9[#"death"] = struct::get(#"hash_11302005e130b7eb");
	var_59f7dee9[#"earth"] = struct::get(#"hash_2b292979020933aa");
	var_59f7dee9[#"air"] = struct::get(#"hash_286a392e24892dee");
	var_59f7dee9[#"light"] = struct::get(#"hash_5ae30fa5823821ee");
	var_59f7dee9[1] = struct::get(#"hash_2038ad2a6cbb9188");
	var_59f7dee9[2] = struct::get(#"hash_2038b02a6cbb96a1");
	var_59f7dee9[3] = struct::get(#"hash_2038af2a6cbb94ee");
	var_59f7dee9[4] = struct::get(#"hash_2038b22a6cbb9a07");
	var_99c9ce0c.var_59f7dee9 = var_59f7dee9;
	var_ed2fbe40[#"death"] = "" + #"hash_74aaba5c17a71e0d";
	var_ed2fbe40[#"earth"] = "" + #"hash_7e49e921c4dd052f";
	var_ed2fbe40[#"air"] = "" + #"hash_9d4aab5c25b93ff";
	var_ed2fbe40[#"light"] = "" + #"hash_58e58259618537e7";
	var_99c9ce0c.var_ed2fbe40 = var_ed2fbe40;
	var_cbf56f63 = getent("mdl_play_leave", "targetname");
	var_99c9ce0c.var_cbf56f63 = var_cbf56f63;
	if(!zm_utility::function_e51dc2d8() && !zm_utility::function_3bff983f())
	{
		array::delete_all(var_59f7dee9);
		var_cbf56f63 delete();
	}
	else
	{
		var_cbf56f63 notsolid();
	}
}

/*
	Name: function_c4f65b06
	Namespace: namespace_31170709
	Checksum: 0x5D88E3CF
	Offset: 0x11A18
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_c4f65b06(var_77104def)
{
	level endon(#"end_game", #"play" + "_ended_early");
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 5);
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	function_2a9aac63();
}

/*
	Name: function_32363763
	Namespace: namespace_31170709
	Checksum: 0x17DE354C
	Offset: 0x11AA0
	Size: 0x57C
	Parameters: 2
	Flags: Linked
*/
function function_32363763(var_77104def, var_19e802fa)
{
	level.no_powerups = undefined;
	level.var_58f509b6 = undefined;
	level.var_14f649ad = undefined;
	array::notify_all(getplayers(), #"hash_3f61d1172dd383b2");
	array::notify_all(getplayers(), #"hash_1ff39e85b7b8e833");
	var_99c9ce0c = level.var_28dcf408;
	if(isdefined(var_99c9ce0c.var_1b52cf99))
	{
		level.var_b897ed83 = var_99c9ce0c.var_1b52cf99;
	}
	var_59f7dee9 = var_99c9ce0c.var_59f7dee9;
	array::delete_all(var_59f7dee9);
	var_83242632 = getent("vol_play_away", "targetname");
	var_64c757e0 = getent("vol_play_home", "targetname");
	var_83242632 delete();
	var_64c757e0 delete();
	var_cbf56f63 = var_99c9ce0c.var_cbf56f63;
	var_cbf56f63 delete();
	level clientfield::set("" + #"hash_d80665c22fafd1e", 0);
	playsoundatposition(#"hash_48910acc61ab640b", (0, 0, 0));
	playsoundatposition(#"hash_396f1597d3662c78", (0, 0, 0));
	if(!var_77104def && !var_19e802fa)
	{
		level thread function_1ddccc6c();
		util::delay(1, "end_game", &zm_audio::function_bca32e49, #"hash_33bbbfd7607b221d", #"complete");
	}
	/#
		if(var_19e802fa)
		{
			foreach(ai_zombie in getaiarray())
			{
				if(isdefined(ai_zombie.var_be2fc36d) && ai_zombie.var_be2fc36d)
				{
					ai_zombie kill();
				}
			}
			level flag::set("");
			level flag::clear("");
			level flag::clear("");
			callback::remove_on_ai_killed(&function_93e711a6);
			callback::remove_on_spawned(&function_b0457d15);
			var_a3db07f9 = var_99c9ce0c.var_a3db07f9;
			var_8d8bdb5b = var_99c9ce0c.var_8d8bdb5b;
			var_c755ceee = var_99c9ce0c.var_c755ceee;
			var_e630bec4 = array(var_a3db07f9, var_8d8bdb5b, var_c755ceee);
			var_e630bec4 = array::remove_undefined(var_e630bec4);
			array::delete_all(var_e630bec4);
			var_ed2fbe40 = var_99c9ce0c.var_ed2fbe40;
			foreach(var_8c827c67 in var_ed2fbe40)
			{
				level clientfield::set(var_8c827c67, 0);
			}
		}
	#/
	level clientfield::set("" + #"hash_31a10d565ae05ddb", 1);
	level exploder::exploder("fxexp_mq_mirror_light_waterfall");
	level.var_28dcf408 struct::delete();
}

/*
	Name: function_2a9aac63
	Namespace: namespace_31170709
	Checksum: 0xAE525A2
	Offset: 0x12028
	Size: 0x1020
	Parameters: 0
	Flags: Linked
*/
function function_2a9aac63()
{
	level endon(#"end_game", #"play" + "_ended_early");
	var_99c9ce0c = level.var_28dcf408;
	var_99c9ce0c.var_a3db07f9 = spawnstruct();
	var_99c9ce0c.var_8d8bdb5b = spawnstruct();
	var_99c9ce0c.var_c755ceee = spawnstruct();
	var_99c9ce0c.var_8ed0f199 = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
	var_99c9ce0c.var_75c04ca3 = arraycopy(var_99c9ce0c.var_8ed0f199);
	var_99c9ce0c.var_d5353976 = -1;
	var_99c9ce0c.var_1b52cf99 = level.var_b897ed83;
	level.var_b897ed83 = &function_64b2fedf;
	zm::register_zombie_damage_override_callback(&function_c3d19eae);
	var_59f7dee9 = var_99c9ce0c.var_59f7dee9;
	var_ed2fbe40 = var_99c9ce0c.var_ed2fbe40;
	var_cbf56f63 = var_99c9ce0c.var_cbf56f63;
	var_cbf56f63 notsolid();
	var_4ebe6ac0 = 0;
	level thread function_9348c9a4();
	while(true)
	{
		while(true)
		{
			function_c170200a();
			var_99c9ce0c.n_players_ready = 0;
			foreach(e_player in util::get_active_players())
			{
				if(e_player function_3d581a6(#"death", 0))
				{
					var_2c03c1e4 = #"death";
				}
				else if(e_player function_3d581a6(#"earth", 0))
				{
					var_2c03c1e4 = #"earth";
				}
				else if(e_player function_3d581a6(#"air", 0))
				{
					var_2c03c1e4 = #"air";
				}
				else if(e_player function_3d581a6(#"light", 0))
				{
					var_2c03c1e4 = #"light";
				}
				if(isdefined(var_2c03c1e4))
				{
					var_59f7dee9[var_2c03c1e4] thread function_7413c414(var_2c03c1e4);
				}
			}
			level notify(#"hash_52b0d62a28ee7a99");
			level thread function_1f96a60e();
			level thread function_bc6f767();
			b_ready = function_9ccbf284();
			if(b_ready === 1)
			{
				break;
			}
			else
			{
				array::notify_all(getplayers(), #"hash_3f61d1172dd383b2");
				foreach(var_8c827c67 in var_ed2fbe40)
				{
					level clientfield::set(var_8c827c67, 0);
				}
			}
		}
		a_e_players = util::get_active_players();
		var_fc14780a = [];
		var_bddee53a = [];
		foreach(e_player in a_e_players)
		{
			foreach(var_2c03c1e4 in array(#"death", #"earth", #"air", #"light"))
			{
				if(e_player function_3d581a6(var_2c03c1e4, 0))
				{
					var_fc14780a[var_2c03c1e4] = e_player;
					if(!isdefined(var_bddee53a))
					{
						var_bddee53a = [];
					}
					else if(!isarray(var_bddee53a))
					{
						var_bddee53a = array(var_bddee53a);
					}
					if(!isinarray(var_bddee53a, var_2c03c1e4))
					{
						var_bddee53a[var_bddee53a.size] = var_2c03c1e4;
					}
					break;
				}
			}
		}
		level notify(#"hash_3e32a367cd31ffb6");
		var_99c9ce0c.var_fc14780a = var_fc14780a;
		var_99c9ce0c.var_38993303 = var_fc14780a.size;
		var_99c9ce0c.var_bddee53a = var_bddee53a;
		level.no_powerups = 1;
		level.disable_nuke_delay_spawning = 1;
		level.var_58f509b6 = 1;
		level.var_14f649ad = 1;
		level flag::clear("spawn_zombies");
		level flag::set("pause_round_timeout");
		level flag::set("hold_round_end");
		level thread zm_utility::function_9ad5aeb1();
		playsoundatposition(#"hash_2175b725b43ec02d", (0, 0, 0));
		level thread zm_audio::sndmusicsystem_playstate("play");
		foreach(var_2c03c1e4, e_player in var_fc14780a)
		{
			e_player notify(#"hash_3f61d1172dd383b2");
			e_player thread function_41577fb();
			e_player thread function_86d3bb1(var_2c03c1e4);
		}
		callback::on_ai_killed(&function_93e711a6);
		callback::on_spawned(&function_b0457d15);
		foreach(var_8c827c67 in var_ed2fbe40)
		{
			level clientfield::set(var_8c827c67, 0);
		}
		var_cbf56f63 solid();
		level clientfield::set("" + #"hash_d80665c22fafd1e", 1);
		var_be17187b = undefined;
		var_be17187b = level waittill_timeout(3, #"hash_285de4ce79135552");
		if(var_be17187b._notify != #"hash_285de4ce79135552")
		{
			level thread function_14727b8f();
			var_be17187b = undefined;
			var_be17187b = level waittill(#"hash_666e960831b9abc4", #"hash_285de4ce79135552");
		}
		level.no_powerups = undefined;
		level.var_58f509b6 = undefined;
		level.var_14f649ad = undefined;
		level thread zm_utility::function_9ad5aeb1(0);
		level thread function_caeca1d3();
		callback::remove_on_ai_killed(&function_93e711a6);
		callback::remove_on_spawned(&function_b0457d15);
		array::notify_all(getplayers(), #"hash_3f61d1172dd383b2");
		array::notify_all(getplayers(), #"hash_1ff39e85b7b8e833");
		foreach(var_8c827c67 in var_ed2fbe40)
		{
			level clientfield::set(var_8c827c67, 0);
		}
		var_cbf56f63 notsolid();
		level clientfield::set("" + #"hash_d80665c22fafd1e", 0);
		if(var_be17187b._notify == #"hash_666e960831b9abc4")
		{
			/#
				iprintlnbold("");
			#/
			level thread function_4d79231e();
			music::setmusicstate("none");
			break;
		}
		else
		{
			music::setmusicstate("none");
			playsoundatposition(#"hash_dd13a4fbdd9c86d", (0, 0, 0));
			e_player = var_be17187b.e_player;
			if(isdefined(e_player))
			{
				e_player thread function_2efcf3bf();
			}
			/#
				iprintlnbold("");
				str_reason = var_be17187b.str_reason;
				if(isdefined(str_reason))
				{
					switch(str_reason)
					{
						case "hash_73a05eaf7c626673":
						{
							iprintlnbold("");
							break;
						}
						case "hash_1ece6cc954f84271":
						{
							iprintlnbold("");
							break;
						}
						case "hash_4953398aedb1c367":
						{
							iprintlnbold("");
							break;
						}
						case "hash_59d8c544fc58f755":
						{
							iprintlnbold("");
							break;
						}
						case "hash_159120ca40f5fea4":
						{
							iprintlnbold("");
							break;
						}
						case "hash_76b177229e281fd":
						{
							iprintlnbold("");
							break;
						}
						case "downed":
						{
							iprintlnbold("");
							break;
						}
						case "rezzed":
						{
							iprintlnbold("");
							break;
						}
						case "hash_1a34cad8f471eea4":
						{
							iprintlnbold("");
							break;
						}
						case "hash_a3d841d32682b30":
						{
							iprintlnbold("");
							break;
						}
					}
				}
				if(isdefined(e_player))
				{
					str_name = e_player.name;
					if(isdefined(str_name))
					{
						iprintlnbold(str_name);
					}
				}
			#/
			var_4ebe6ac0++;
			if(var_4ebe6ac0 >= 5 && !zm_utility::function_3bff983f())
			{
				/#
					iprintlnbold("");
				#/
				var_4ebe6ac0 = 0;
				level waittill(#"between_round_over");
			}
			else
			{
				foreach(var_8c827c67 in var_ed2fbe40)
				{
					level clientfield::set(var_8c827c67, 0);
				}
				if(zm_utility::function_3bff983f())
				{
					namespace_f551babc::fail(#"hash_3cd5b19b981e5c3c", getplayers());
					namespace_f551babc::function_ae725d63(5);
				}
			}
		}
	}
}

/*
	Name: function_1f96a60e
	Namespace: namespace_31170709
	Checksum: 0xD3D28A20
	Offset: 0x13050
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_1f96a60e()
{
	level endon(#"end_game");
	var_99c9ce0c = level.var_28dcf408;
	if(isdefined(var_99c9ce0c.var_134fadcb) && var_99c9ce0c.var_134fadcb)
	{
		return;
	}
	var_99c9ce0c.var_134fadcb = 1;
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
		{
			if(e_player namespace_48f3568::function_69e9e553(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6")))
			{
				var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_573c7474847811");
				if(isdefined(var_845efa03) && var_845efa03)
				{
					e_player thread namespace_891c9bac::function_8e0f4696(#"hash_242d4dda05399a77", undefined, undefined, undefined, undefined, 1);
				}
			}
			else
			{
				e_player thread zm_audio::create_and_play_dialog(#"hash_33bbbfd7607b221d", #"enter");
			}
			break;
		}
	}
}

/*
	Name: function_2efcf3bf
	Namespace: namespace_31170709
	Checksum: 0x930EB9D1
	Offset: 0x13268
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_2efcf3bf()
{
	level endon(#"end_game", #"play" + "_ended_early");
	self endon(#"death");
	wait(1);
	if(zm_utility::is_player_valid(self))
	{
		self thread zm_audio::create_and_play_dialog(#"generic", #"response_negative");
	}
}

/*
	Name: function_c170200a
	Namespace: namespace_31170709
	Checksum: 0x6D5AA31F
	Offset: 0x13308
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function function_c170200a()
{
	level endon(#"end_game", #"play" + "_ended_early");
	while(true)
	{
		var_24a19a92 = 1;
		foreach(e_player in util::get_active_players())
		{
			if(!zm_utility::is_player_valid(e_player) || !e_player function_dc5aa56f() || !is_wonder_weapon(e_player getcurrentweapon(), undefined, 0))
			{
				var_24a19a92 = 0;
				break;
			}
		}
		if(var_24a19a92)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_bc6f767
	Namespace: namespace_31170709
	Checksum: 0xF0E7E274
	Offset: 0x13448
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function function_bc6f767()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_3e32a367cd31ffb6");
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(!zm_utility::is_player_valid(e_player) || !e_player function_dc5aa56f() || !is_wonder_weapon(e_player getcurrentweapon(), undefined, 0))
			{
				level notify(#"hash_2fd7b0f35f31ef25");
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_9ccbf284
	Namespace: namespace_31170709
	Checksum: 0xFA107D15
	Offset: 0x13588
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_9ccbf284()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_2fd7b0f35f31ef25");
	var_99c9ce0c = level.var_28dcf408;
	while(true)
	{
		a_e_players = util::get_active_players();
		if(var_99c9ce0c.n_players_ready >= a_e_players.size)
		{
			return 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_c3d19eae
	Namespace: namespace_31170709
	Checksum: 0xE1D09BC4
	Offset: 0x13638
	Size: 0x13A
	Parameters: 13
	Flags: Linked
*/
function function_c3d19eae(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!(isdefined(self.var_be2fc36d) && self.var_be2fc36d))
	{
		return;
	}
	var_2c03c1e4 = self.var_8ca159b2;
	var_adf060c6 = self.var_71ecb9db;
	if(is_wonder_weapon(weapon, var_2c03c1e4, var_adf060c6) && mod !== "MOD_MELEE")
	{
		return self.health + 666;
	}
	var_f657affa = function_36afae35();
	if(isinarray(var_f657affa, weapon))
	{
		return 0;
	}
	return damage;
}

/*
	Name: function_64b2fedf
	Namespace: namespace_31170709
	Checksum: 0xED4B0C7A
	Offset: 0x13780
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_64b2fedf()
{
	if(isdefined(self.var_be2fc36d) && self.var_be2fc36d)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_93e711a6
	Namespace: namespace_31170709
	Checksum: 0x7C93311F
	Offset: 0x137B0
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_93e711a6(s_params)
{
	if(!(isdefined(self.var_be2fc36d) && self.var_be2fc36d) || (isdefined(self.var_b07f4eb9) && self.var_b07f4eb9))
	{
		return;
	}
	self.var_b07f4eb9 = 1;
	var_2c03c1e4 = self.var_8ca159b2;
	var_adf060c6 = self.var_71ecb9db;
	w_weapon = s_params.weapon;
	str_mod = s_params.smeansofdeath;
	if(is_wonder_weapon(w_weapon, var_2c03c1e4, var_adf060c6) && str_mod !== "MOD_MELEE")
	{
		var_99c9ce0c = level.var_28dcf408;
		var_99c9ce0c.var_155837a1[var_2c03c1e4]++;
	}
	else
	{
		e_player = s_params.eattacker;
		level notify(#"hash_285de4ce79135552", {#e_player:e_player, #str_reason:#"hash_76b177229e281fd"});
	}
}

/*
	Name: function_caeca1d3
	Namespace: namespace_31170709
	Checksum: 0x7C9C5B21
	Offset: 0x13920
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_caeca1d3()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_3e32a367cd31ffb6");
	wait(10);
	level.disable_nuke_delay_spawning = undefined;
	level flag::set("spawn_zombies");
	level flag::clear("pause_round_timeout");
	level flag::clear("hold_round_end");
}

/*
	Name: function_9348c9a4
	Namespace: namespace_31170709
	Checksum: 0x9231E1CE
	Offset: 0x139D8
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_9348c9a4()
{
	level endon(#"end_game");
	wait(10);
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	waitframe(1);
	while(true)
	{
		var_845efa03 = 0;
		a_e_players = util::get_active_players();
		a_e_players = array::randomize(a_e_players);
		foreach(e_player in a_e_players)
		{
			if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
			{
				var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_a2f572761972fa2");
				if(isdefined(var_845efa03) && var_845efa03)
				{
					break;
				}
			}
		}
		if(isdefined(var_845efa03) && var_845efa03)
		{
			break;
		}
		wait(1);
	}
	function_7b345f6d(#"hash_6ee819ce1d175470");
	level zm_audio::sndvoxoverride(0);
}

/*
	Name: function_7413c414
	Namespace: namespace_31170709
	Checksum: 0xB5A98CC0
	Offset: 0x13BB8
	Size: 0x2A8
	Parameters: 1
	Flags: Linked
*/
function function_7413c414(var_2c03c1e4)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_2fd7b0f35f31ef25", #"hash_3e32a367cd31ffb6");
	self endon(#"death");
	var_99c9ce0c = level.var_28dcf408;
	var_ed2fbe40 = var_99c9ce0c.var_ed2fbe40;
	var_8c827c67 = var_ed2fbe40[var_2c03c1e4];
	level clientfield::set(var_8c827c67, 1);
	while(true)
	{
		while(true)
		{
			var_548144c0 = 0;
			foreach(e_player in util::get_active_players())
			{
				if(e_player function_813c4629(self, var_2c03c1e4))
				{
					var_548144c0 = 1;
					break;
				}
			}
			if(var_548144c0)
			{
				break;
			}
			waitframe(1);
		}
		if(!isdefined(e_player))
		{
			continue;
		}
		e_player thread function_e028a26f(var_2c03c1e4, 1);
		b_success = e_player function_5d2011fa(self, var_2c03c1e4, 3);
		if(!isdefined(b_success))
		{
			b_success = 0;
		}
		if(!b_success)
		{
			if(isdefined(e_player))
			{
				e_player notify(#"hash_3f61d1172dd383b2");
			}
			continue;
		}
		var_99c9ce0c.n_players_ready++;
		while(true)
		{
			if(!isdefined(e_player) || !e_player function_813c4629(self, var_2c03c1e4))
			{
				break;
			}
			waitframe(1);
		}
		if(isdefined(e_player))
		{
			e_player notify(#"hash_3f61d1172dd383b2");
		}
		var_99c9ce0c.n_players_ready--;
	}
}

/*
	Name: function_813c4629
	Namespace: namespace_31170709
	Checksum: 0xE18850D1
	Offset: 0x13E68
	Size: 0xD2
	Parameters: 2
	Flags: Linked
*/
function function_813c4629(var_c016547, var_2c03c1e4)
{
	b_is_valid = zm_utility::is_player_valid(self);
	var_c04e7375 = 1;
	if(isdefined(var_2c03c1e4))
	{
		var_c04e7375 = self function_3d581a6(var_2c03c1e4, 0);
	}
	n_dist = distance2dsquared(self.origin, var_c016547.origin);
	var_a9c01904 = n_dist <= 64 * 64;
	return b_is_valid && var_c04e7375 && var_a9c01904;
}

/*
	Name: function_5d2011fa
	Namespace: namespace_31170709
	Checksum: 0x1EA82553
	Offset: 0x13F48
	Size: 0x118
	Parameters: 3
	Flags: Linked
*/
function function_5d2011fa(var_c016547, var_2c03c1e4, n_duration)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	if(n_duration <= 0)
	{
		return 1;
	}
	n_start_time = gettime();
	while(self function_813c4629(var_c016547, var_2c03c1e4))
	{
		n_current_time = gettime();
		n_time_passed = float(n_current_time - n_start_time) / 1000;
		if(n_time_passed >= n_duration)
		{
			return 1;
		}
		waitframe(1);
	}
	return 0;
}

/*
	Name: function_e028a26f
	Namespace: namespace_31170709
	Checksum: 0x4EF34F5F
	Offset: 0x14068
	Size: 0x194
	Parameters: 3
	Flags: Linked
*/
function function_e028a26f(var_2c03c1e4, var_9410d484 = 1, var_8cc138bc = 0)
{
	self endon(#"disconnect");
	var_99c9ce0c = level.var_28dcf408;
	var_a5e426e5 = var_99c9ce0c.var_38e73d19;
	var_c674c4ec = var_a5e426e5[var_2c03c1e4];
	if(!isbot(self))
	{
		if(var_9410d484)
		{
			self clientfield::set_to_player(var_c674c4ec, 1);
		}
		if(var_8cc138bc)
		{
			self clientfield::set_to_player("" + #"hash_565ca9982285f23e", 1);
		}
	}
	self thread function_12d27b4f();
	self waittill(#"hash_3f61d1172dd383b2");
	if(!isbot(self))
	{
		self clientfield::set_to_player(var_c674c4ec, 0);
		self clientfield::set_to_player("" + #"hash_565ca9982285f23e", 0);
	}
}

/*
	Name: function_12d27b4f
	Namespace: namespace_31170709
	Checksum: 0xDA2AF542
	Offset: 0x14208
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_12d27b4f()
{
	self endon(#"disconnect", #"hash_3f61d1172dd383b2");
	level waittill(#"end_game");
	self notify(#"hash_3f61d1172dd383b2");
}

/*
	Name: function_41577fb
	Namespace: namespace_31170709
	Checksum: 0xCD92A79F
	Offset: 0x14260
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_41577fb()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	if(isdefined(self))
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"entering_last_stand", #"death", #"fake_death");
	}
	if(var_be17187b._notify == "fake_death")
	{
		var_e84738a3 = #"hash_a3d841d32682b30";
	}
	else
	{
		var_e84738a3 = #"downed";
	}
	level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:var_e84738a3});
}

/*
	Name: function_86d3bb1
	Namespace: namespace_31170709
	Checksum: 0x566EF1C
	Offset: 0x14388
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_86d3bb1(var_2c03c1e4)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	while(self function_3d581a6(var_2c03c1e4, 0))
	{
		waitframe(1);
	}
	level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:#"hash_1a34cad8f471eea4"});
}

/*
	Name: function_b0457d15
	Namespace: namespace_31170709
	Checksum: 0xE92FD719
	Offset: 0x14480
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_b0457d15()
{
	level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:#"rezzed"});
}

/*
	Name: function_36afae35
	Namespace: namespace_31170709
	Checksum: 0x1D43AD42
	Offset: 0x144D8
	Size: 0x256
	Parameters: 1
	Flags: Linked
*/
function function_36afae35(var_2c03c1e4 = "")
{
	switch(var_2c03c1e4)
	{
		case "death":
		{
			var_f657affa = array(level.var_c50bf24c, level.var_8a49b135, level.var_951a7644);
			break;
		}
		case "earth":
		{
			var_f657affa = array(level.var_53789618, level.var_161aeda7, level.var_54ed88ec);
			break;
		}
		case "air":
		{
			var_f657affa = array(level.var_f7e963d9, level.var_7e83ad70, level.var_2812f85f);
			break;
		}
		case "light":
		{
			var_f657affa = array(level.var_45072d7d, level.var_f10d87a1, level.var_836fa4da);
			break;
		}
		default:
		{
			var_da715f40 = function_36afae35(#"death");
			var_e5f953e5 = function_36afae35(#"earth");
			var_c5f68b51 = function_36afae35(#"air");
			var_3c1b41d1 = function_36afae35(#"light");
			var_f657affa = arraycombine(var_da715f40, var_e5f953e5, 0, 0);
			var_f657affa = arraycombine(var_f657affa, var_c5f68b51, 0, 0);
			var_f657affa = arraycombine(var_f657affa, var_3c1b41d1, 0, 0);
			break;
		}
	}
	return var_f657affa;
}

/*
	Name: function_a67dc10
	Namespace: namespace_31170709
	Checksum: 0x7046D45D
	Offset: 0x14738
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_a67dc10(var_2c03c1e4)
{
	switch(var_2c03c1e4)
	{
		case "death":
		{
			var_e4bacb96 = level.var_ca7edc78;
			break;
		}
		case "earth":
		{
			var_e4bacb96 = level.var_b784afad;
			break;
		}
		case "air":
		{
			var_e4bacb96 = level.var_1bf918c7;
			break;
		}
		case "light":
		{
			var_e4bacb96 = level.var_e8ffa40;
			break;
		}
		default:
		{
			var_e4bacb96 = array(level.var_ca7edc78, level.var_b784afad, level.var_1bf918c7, level.var_e8ffa40);
			break;
		}
	}
	return var_e4bacb96;
}

/*
	Name: function_3d581a6
	Namespace: namespace_31170709
	Checksum: 0x7CF7E606
	Offset: 0x14838
	Size: 0x11A
	Parameters: 2
	Flags: Linked
*/
function function_3d581a6(var_2c03c1e4, var_adf060c6 = 0)
{
	if(var_adf060c6)
	{
		var_d9d642ba = function_a67dc10(var_2c03c1e4);
		if(!isdefined(var_d9d642ba))
		{
			var_d9d642ba = [];
		}
		else if(!isarray(var_d9d642ba))
		{
			var_d9d642ba = array(var_d9d642ba);
		}
	}
	else
	{
		var_d9d642ba = function_36afae35(var_2c03c1e4);
	}
	foreach(var_6642b54d in var_d9d642ba)
	{
		if(self hasweapon(var_6642b54d))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: is_wonder_weapon
	Namespace: namespace_31170709
	Checksum: 0x5398280B
	Offset: 0x14960
	Size: 0xCA
	Parameters: 3
	Flags: Linked
*/
function is_wonder_weapon(w_weapon, var_2c03c1e4, var_adf060c6 = 0)
{
	if(!isdefined(w_weapon))
	{
		return 0;
	}
	if(var_adf060c6)
	{
		var_d9d642ba = function_a67dc10(var_2c03c1e4);
		if(!isdefined(var_d9d642ba))
		{
			var_d9d642ba = [];
		}
		else if(!isarray(var_d9d642ba))
		{
			var_d9d642ba = array(var_d9d642ba);
		}
	}
	else
	{
		var_d9d642ba = function_36afae35(var_2c03c1e4);
	}
	return isinarray(var_d9d642ba, w_weapon);
}

/*
	Name: function_14727b8f
	Namespace: namespace_31170709
	Checksum: 0x88918890
	Offset: 0x14A38
	Size: 0x8C0
	Parameters: 0
	Flags: Linked
*/
function function_14727b8f()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	function_a6ec87a7();
	var_99c9ce0c = level.var_28dcf408;
	var_59f7dee9 = var_99c9ce0c.var_59f7dee9;
	var_59f7dee9 = array(var_59f7dee9[1], var_59f7dee9[2], var_59f7dee9[3], var_59f7dee9[4]);
	var_fc14780a = var_99c9ce0c.var_fc14780a;
	array::thread_all(var_fc14780a, &function_5ea46511);
	var_551a187 = [];
	var_55b0fa0c = [];
	for(var_12caf287 = 1; var_12caf287 <= 3; var_12caf287++)
	{
		/#
			iprintlnbold("" + var_12caf287 + "");
		#/
		switch(var_12caf287)
		{
			case 1:
			{
				var_5aa9e9ae = var_99c9ce0c.var_a3db07f9;
				break;
			}
			case 2:
			{
				var_5aa9e9ae = var_99c9ce0c.var_8d8bdb5b;
				var_8088b8ed = 0;
				break;
			}
			case 3:
			{
				var_5aa9e9ae = var_99c9ce0c.var_c755ceee;
				break;
			}
		}
		var_d8d4faff = 0;
		var_c3815c7 = var_5aa9e9ae.var_c3815c7;
		var_37c7bb4d = var_5aa9e9ae.var_37c7bb4d;
		var_a208cb58 = var_c3815c7.size;
		for(i = 0; i < var_a208cb58; i++)
		{
			switch(var_12caf287)
			{
				case 2:
				{
					var_d8d4faff = math::cointoss();
					if(!var_d8d4faff)
					{
						var_8088b8ed++;
						if(var_8088b8ed >= 2)
						{
							var_8088b8ed = 0;
							var_d8d4faff = 1;
						}
					}
					break;
				}
				case 3:
				{
					var_d8d4faff = 2;
					break;
				}
			}
			var_99c9ce0c.var_ef5091fc = 0;
			var_bddee53a = var_c3815c7[i];
			var_5841fdb6 = var_37c7bb4d[i];
			var_99c9ce0c.var_ecc915b5 = 0;
			if(isinarray(var_bddee53a, #"air"))
			{
				n_index = array::find(var_bddee53a, #"air");
				if(var_5841fdb6[n_index] === #"charged")
				{
					var_99c9ce0c.var_ecc915b5 = 1;
				}
			}
			var_39324db2 = arraycopy(var_59f7dee9);
			foreach(var_2c03c1e4, e_player in var_fc14780a)
			{
				if(isinarray(var_bddee53a, var_2c03c1e4) && isinarray(var_551a187, var_2c03c1e4))
				{
					var_ce7c00 = var_55b0fa0c[var_2c03c1e4];
					var_f7dfd45a = arraycopy(var_39324db2);
					arrayremovevalue(var_f7dfd45a, var_ce7c00);
					var_c016547 = arraygetfarthest(e_player.origin, var_f7dfd45a);
					arrayremovevalue(var_39324db2, var_c016547);
					var_55b0fa0c[var_2c03c1e4] = var_c016547;
				}
			}
			var_551a187 = [];
			foreach(var_2c03c1e4, e_player in var_fc14780a)
			{
				if(isinarray(var_bddee53a, var_2c03c1e4))
				{
					if(!isdefined(var_551a187))
					{
						var_551a187 = [];
					}
					else if(!isarray(var_551a187))
					{
						var_551a187 = array(var_551a187);
					}
					var_551a187[var_551a187.size] = var_2c03c1e4;
					var_c016547 = var_55b0fa0c[var_2c03c1e4];
					if(!isdefined(var_c016547))
					{
						var_c016547 = arraygetfarthest(e_player.origin, var_39324db2);
						arrayremovevalue(var_39324db2, var_c016547);
						var_55b0fa0c[var_2c03c1e4] = var_c016547;
					}
					var_661f2ab9 = array::find(var_bddee53a, var_2c03c1e4);
					str_task = var_5841fdb6[var_661f2ab9];
					var_32617a77 = array::find(var_59f7dee9, var_c016547);
					var_32617a77++;
					e_player thread function_9cb5a6ac(var_2c03c1e4, str_task, var_12caf287, var_32617a77, var_d8d4faff);
					continue;
				}
				var_55b0fa0c[var_2c03c1e4] = undefined;
				e_player thread function_9cb5a6ac(var_2c03c1e4, #"return", var_12caf287);
			}
			level waittill(#"hash_6f04da8e7237740");
			level thread function_b927f16();
			wait(1);
		}
		if(var_12caf287 < 3)
		{
			var_99c9ce0c.var_ef5091fc = 0;
			foreach(var_2c03c1e4, e_player in var_fc14780a)
			{
				e_player thread function_9cb5a6ac(var_2c03c1e4, #"return", var_12caf287);
			}
			level waittill(#"hash_6f04da8e7237740");
			array::thread_all(var_fc14780a, &function_5ea46511);
			level thread function_b927f16();
		}
		/#
			iprintlnbold("" + var_12caf287 + "");
		#/
		level notify(#"hash_79ebfc45b1857e0a");
		if(var_12caf287 < 3)
		{
			playsoundatposition(#"hash_83542f629d907c8", (0, 0, 0));
			level thread function_759871d0();
			wait(10);
			continue;
		}
		playsoundatposition(#"hash_c775906a283558d", (0, 0, 0));
	}
	level notify(#"hash_666e960831b9abc4");
}

/*
	Name: function_b927f16
	Namespace: namespace_31170709
	Checksum: 0x5D695F2C
	Offset: 0x15300
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_b927f16()
{
	var_99c9ce0c = level.var_28dcf408;
	if(var_99c9ce0c.var_75c04ca3.size == 0)
	{
		var_99c9ce0c.var_75c04ca3 = arraycopy(var_99c9ce0c.var_8ed0f199);
	}
	arrayremovevalue(var_99c9ce0c.var_75c04ca3, var_99c9ce0c.var_d5353976);
	var_d40bf404 = array::random(var_99c9ce0c.var_75c04ca3);
	arrayremovevalue(var_99c9ce0c.var_75c04ca3, var_d40bf404);
	var_99c9ce0c.var_d5353976 = var_d40bf404;
	level clientfield::set("" + #"hash_516899418a30cd4d", var_d40bf404);
}

/*
	Name: function_4d79231e
	Namespace: namespace_31170709
	Checksum: 0x7DF9F383
	Offset: 0x15408
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_4d79231e()
{
	level endon(#"end_game");
	wait(2);
	level clientfield::set("" + #"hash_516899418a30cd4d", 8);
	wait(1);
	level clientfield::set("" + #"hash_516899418a30cd4d", 5);
	wait(3);
	level clientfield::set("" + #"hash_516899418a30cd4d", 9);
	wait(3);
	level clientfield::set("" + #"hash_516899418a30cd4d", 0);
}

/*
	Name: function_759871d0
	Namespace: namespace_31170709
	Checksum: 0xAF3BFBA5
	Offset: 0x15510
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_759871d0()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	wait(1);
	level thread zm_audio::function_bca32e49(#"generic", #"response_positive");
}

/*
	Name: function_a6ec87a7
	Namespace: namespace_31170709
	Checksum: 0x9B7795D0
	Offset: 0x15598
	Size: 0x724
	Parameters: 0
	Flags: Linked
*/
function function_a6ec87a7()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	var_99c9ce0c = level.var_28dcf408;
	var_bddee53a = var_99c9ce0c.var_bddee53a;
	var_5841fdb6 = array(#"hash_ed86ee1cb8dfb7a", #"charged");
	for(i = 1; i <= 3; i++)
	{
		switch(i)
		{
			case 1:
			{
				var_5aa9e9ae = var_99c9ce0c.var_a3db07f9;
				var_c877d37f = 50;
				var_a3ef3c8c = 25;
				var_8175d38 = 0;
				var_a208cb58 = 3;
				break;
			}
			case 2:
			{
				var_5aa9e9ae = var_99c9ce0c.var_8d8bdb5b;
				var_c877d37f = 75;
				var_a3ef3c8c = 50;
				var_8175d38 = 25;
				var_a208cb58 = 4;
				break;
			}
			case 3:
			{
				var_5aa9e9ae = var_99c9ce0c.var_c755ceee;
				var_c877d37f = 100;
				var_a3ef3c8c = 100;
				var_8175d38 = 100;
				var_a208cb58 = 5;
				break;
			}
		}
		var_c3815c7 = [];
		var_5280384 = array::randomize(var_bddee53a);
		for(j = 0; j < var_a208cb58; j++)
		{
			var_ec8414b6 = math::cointoss(var_c877d37f);
			var_f2e5b13e = math::cointoss(var_a3ef3c8c);
			var_17cf7caa = math::cointoss(var_8175d38);
			n_players = 1;
			switch(var_bddee53a.size)
			{
				case 2:
				{
					if(var_ec8414b6)
					{
						n_players = 2;
					}
					break;
				}
				case 3:
				{
					if(var_f2e5b13e)
					{
						n_players = 3;
					}
					else if(var_ec8414b6)
					{
						n_players = 2;
					}
					break;
				}
				case 4:
				{
					if(var_17cf7caa)
					{
						n_players = 4;
					}
					else if(var_f2e5b13e)
					{
						n_players = 3;
					}
					else if(var_ec8414b6)
					{
						n_players = 2;
					}
				}
			}
			var_e8e6e6da = [];
			for(k = 0; k < n_players; k++)
			{
				var_2c03c1e4 = array::random(var_5280384);
				if(!isdefined(var_e8e6e6da))
				{
					var_e8e6e6da = [];
				}
				else if(!isarray(var_e8e6e6da))
				{
					var_e8e6e6da = array(var_e8e6e6da);
				}
				var_e8e6e6da[var_e8e6e6da.size] = var_2c03c1e4;
				if(var_bddee53a.size > 1)
				{
					arrayremovevalue(var_5280384, var_2c03c1e4);
					if(var_5280384.size == 0)
					{
						var_5280384 = array::randomize(var_bddee53a);
						arrayremovevalue(var_5280384, var_2c03c1e4);
					}
				}
			}
			if(!isdefined(var_c3815c7))
			{
				var_c3815c7 = [];
			}
			else if(!isarray(var_c3815c7))
			{
				var_c3815c7 = array(var_c3815c7);
			}
			var_c3815c7[var_c3815c7.size] = var_e8e6e6da;
		}
		var_37c7bb4d = [];
		var_76b58dd = [];
		var_79dd2c3d = [];
		foreach(part in var_c3815c7)
		{
			var_f704b824 = [];
			for(j = 0; j < part.size; j++)
			{
				str_task = array::random(var_5841fdb6);
				var_2c03c1e4 = part[j];
				if(isdefined(var_2c03c1e4))
				{
					var_f804950f = var_76b58dd[var_2c03c1e4];
					if(isdefined(var_79dd2c3d[var_2c03c1e4]) && var_79dd2c3d[var_2c03c1e4])
					{
						var_79dd2c3d[var_2c03c1e4] = 0;
						if(isdefined(var_f804950f))
						{
							var_7dbbbf1f = arraycopy(var_5841fdb6);
							arrayremovevalue(var_7dbbbf1f, var_f804950f);
							var_c88233d3 = var_7dbbbf1f[0];
							if(isdefined(var_c88233d3))
							{
								str_task = var_c88233d3;
							}
						}
					}
					if(var_f804950f === str_task)
					{
						var_79dd2c3d[var_2c03c1e4] = 1;
					}
					var_76b58dd[var_2c03c1e4] = str_task;
				}
				if(!isdefined(var_f704b824))
				{
					var_f704b824 = [];
				}
				else if(!isarray(var_f704b824))
				{
					var_f704b824 = array(var_f704b824);
				}
				var_f704b824[var_f704b824.size] = str_task;
			}
			if(!isdefined(var_37c7bb4d))
			{
				var_37c7bb4d = [];
			}
			else if(!isarray(var_37c7bb4d))
			{
				var_37c7bb4d = array(var_37c7bb4d);
			}
			var_37c7bb4d[var_37c7bb4d.size] = var_f704b824;
		}
		var_5aa9e9ae.var_c3815c7 = var_c3815c7;
		var_5aa9e9ae.var_37c7bb4d = var_37c7bb4d;
	}
}

/*
	Name: function_9cb5a6ac
	Namespace: namespace_31170709
	Checksum: 0x46F5E90C
	Offset: 0x15CC8
	Size: 0x5A0
	Parameters: 5
	Flags: Linked
*/
function function_9cb5a6ac(var_2c03c1e4, str_task, var_12caf287, var_32617a77, var_d8d4faff)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	var_b1224954 = self.var_b1224954;
	if(isdefined(var_b1224954))
	{
		var_b1224954 delete();
		var_79e746a9 = self.var_79e746a9;
		if(isdefined(var_79e746a9))
		{
			var_79e746a9 zm_utility::deactivate_zombie_point_of_interest();
			var_79e746a9 clientfield::set("charon_pool", 0);
			var_79e746a9 delete();
		}
	}
	wait(0.5);
	var_99c9ce0c = level.var_28dcf408;
	switch(var_12caf287)
	{
		case 1:
		{
			var_c9386af2 = 5;
			var_bfa3340e = 10;
			break;
		}
		case 2:
		{
			var_c9386af2 = 5;
			var_bfa3340e = 10;
			break;
		}
		case 3:
		{
			var_c9386af2 = 5;
			var_bfa3340e = 10;
			break;
		}
	}
	var_59f7dee9 = var_99c9ce0c.var_59f7dee9;
	var_ed2fbe40 = var_99c9ce0c.var_ed2fbe40;
	var_8c827c67 = var_ed2fbe40[var_2c03c1e4];
	var_8cc138bc = str_task == #"return";
	if(var_8cc138bc)
	{
		var_24437625 = 1;
		var_c9386af2 = 5;
		var_c016547 = var_59f7dee9[var_2c03c1e4];
		var_fb51c008 = self function_6a5bdb08();
	}
	else
	{
		var_24437625 = var_32617a77 + 1;
		var_c016547 = var_59f7dee9[var_32617a77];
		var_fb51c008 = self function_813c4629(var_c016547);
	}
	self thread function_5ea46511(var_2c03c1e4);
	if(!var_fb51c008 || var_8cc138bc)
	{
		self notify(#"hash_1ff39e85b7b8e833");
	}
	if(!var_fb51c008)
	{
		level clientfield::set(var_8c827c67, var_24437625);
		self thread function_e028a26f(var_2c03c1e4, 0, var_8cc138bc);
		self thread function_4900fd63(var_c016547, var_8cc138bc);
		var_be17187b = undefined;
		var_be17187b = self waittill_timeout(var_c9386af2, #"hash_29f30403ceebc819");
		level clientfield::set(var_8c827c67, 0);
		self notify(#"hash_3f61d1172dd383b2");
		if(var_be17187b._notify != #"hash_29f30403ceebc819")
		{
			str_reason = #"hash_73a05eaf7c626673";
			if(var_8cc138bc)
			{
				str_reason = #"hash_1ece6cc954f84271";
			}
			level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:str_reason});
			return;
		}
	}
	if(var_8cc138bc)
	{
		self thread function_ad68de97();
	}
	else
	{
		self thread function_4f45dd3c();
	}
	if(!var_8cc138bc)
	{
		level thread function_542a6ee4(self, var_2c03c1e4, str_task, var_32617a77, var_d8d4faff);
		level thread function_4462d56a(self, var_2c03c1e4);
		var_be17187b = undefined;
		var_be17187b = self waittill_timeout(var_bfa3340e, #"hash_794badff330d135f");
		if(var_be17187b._notify != #"hash_794badff330d135f")
		{
			level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:#"hash_4953398aedb1c367"});
			return;
		}
	}
	var_99c9ce0c.var_ef5091fc++;
	var_2d971fd7 = var_99c9ce0c.var_fc14780a.size;
	if(var_99c9ce0c.var_ef5091fc >= var_2d971fd7)
	{
		level notify(#"hash_6f04da8e7237740");
	}
}

/*
	Name: function_5ea46511
	Namespace: namespace_31170709
	Checksum: 0x9707FC9C
	Offset: 0x16270
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_5ea46511(var_2c03c1e4)
{
	if(!isdefined(self))
	{
		return;
	}
	var_f657affa = function_36afae35(var_2c03c1e4);
	foreach(var_4d248f0c in var_f657affa)
	{
		if(self hasweapon(var_4d248f0c))
		{
			if(self getweaponammoclip(var_4d248f0c) < 5)
			{
				self setweaponammoclip(var_4d248f0c, 10);
			}
			break;
		}
	}
}

/*
	Name: function_4900fd63
	Namespace: namespace_31170709
	Checksum: 0x277F413
	Offset: 0x16370
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function function_4900fd63(var_c016547, var_515ad80f = 0)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	if(!var_515ad80f)
	{
		while(!self function_813c4629(var_c016547))
		{
			waitframe(1);
		}
	}
	else
	{
		while(!self function_6a5bdb08())
		{
			waitframe(1);
		}
	}
	self notify(#"hash_29f30403ceebc819");
}

/*
	Name: function_dc5aa56f
	Namespace: namespace_31170709
	Checksum: 0x10AB42D1
	Offset: 0x16468
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_dc5aa56f()
{
	return self function_6a5bdb08() || self function_3471a3dc();
}

/*
	Name: function_3471a3dc
	Namespace: namespace_31170709
	Checksum: 0xE0F728C0
	Offset: 0x164A8
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_3471a3dc()
{
	var_83242632 = getent("vol_play_away", "targetname");
	return self istouching(var_83242632);
}

/*
	Name: function_6a5bdb08
	Namespace: namespace_31170709
	Checksum: 0xD2EFDAB7
	Offset: 0x164F8
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_6a5bdb08()
{
	var_64c757e0 = getent("vol_play_home", "targetname");
	return self istouching(var_64c757e0);
}

/*
	Name: function_4f45dd3c
	Namespace: namespace_31170709
	Checksum: 0x562EFFC1
	Offset: 0x16548
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_4f45dd3c()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_6f04da8e7237740", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	while(!self function_3471a3dc())
	{
		waitframe(1);
	}
	while(true)
	{
		while(self function_3471a3dc())
		{
			waitframe(1);
		}
		wait(2);
		if(!self function_3471a3dc())
		{
			break;
		}
	}
	level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:#"hash_59d8c544fc58f755"});
}

/*
	Name: function_ad68de97
	Namespace: namespace_31170709
	Checksum: 0x7AAB2AD
	Offset: 0x16680
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_ad68de97()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_6f04da8e7237740", #"hash_285de4ce79135552");
	self endon(#"entering_last_stand", #"death");
	while(!self function_6a5bdb08())
	{
		waitframe(1);
	}
	while(true)
	{
		while(self function_6a5bdb08())
		{
			waitframe(1);
		}
		wait(2);
		if(!self function_6a5bdb08())
		{
			break;
		}
	}
	level notify(#"hash_285de4ce79135552", {#e_player:self, #str_reason:#"hash_159120ca40f5fea4"});
}

/*
	Name: function_4462d56a
	Namespace: namespace_31170709
	Checksum: 0x3E914B2D
	Offset: 0x167B8
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function function_4462d56a(e_player, var_2c03c1e4)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	e_player endon(#"entering_last_stand", #"death", #"hash_1ff39e85b7b8e833");
	var_65adf081 = util::spawn_model(#"tag_origin", e_player.origin);
	switch(var_2c03c1e4)
	{
		case "death":
		{
			var_c674c4ec = "" + #"hash_155f8a4473c5849f";
			break;
		}
		case "earth":
		{
			var_c674c4ec = "" + #"hash_4400550c9847a1c5";
			break;
		}
		case "air":
		{
			var_c674c4ec = "" + #"hash_1f0dd5bf6862e335";
			break;
		}
		case "light":
		{
			var_c674c4ec = "" + #"hash_ab97fcf2b12187d";
			break;
		}
	}
	var_65adf081 clientfield::set(var_c674c4ec, 1);
	var_65adf081 thread function_52b56ea3(var_c674c4ec);
	var_65adf081 thread function_2593636e(e_player, var_c674c4ec);
	while(true)
	{
		v_origin = e_player.origin;
		a_info = zm_utility::function_b0eeaada(v_origin);
		if(isdefined(a_info))
		{
			var_eb4fc39f = a_info[#"point"];
			if(isdefined(var_eb4fc39f))
			{
				v_origin = var_eb4fc39f;
			}
		}
		var_65adf081.origin = v_origin;
		waitframe(1);
	}
}

/*
	Name: function_52b56ea3
	Namespace: namespace_31170709
	Checksum: 0xEA67B12
	Offset: 0x16A50
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_52b56ea3(var_c674c4ec)
{
	self endon(#"death");
	level waittill(#"end_game", #"play" + "_ended_early", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	self thread function_1fa773bf(var_c674c4ec);
}

/*
	Name: function_2593636e
	Namespace: namespace_31170709
	Checksum: 0x47369A8
	Offset: 0x16AE0
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function function_2593636e(e_player, var_c674c4ec)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	self endon(#"death");
	if(isdefined(e_player))
	{
		var_be17187b = undefined;
		var_be17187b = e_player waittill(#"entering_last_stand", #"death", #"hash_1ff39e85b7b8e833", #"fake_death");
	}
	self thread function_1fa773bf(var_c674c4ec);
}

/*
	Name: function_1fa773bf
	Namespace: namespace_31170709
	Checksum: 0x6C150A65
	Offset: 0x16BD8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_1fa773bf(var_c674c4ec)
{
	self endon(#"death");
	if(isdefined(self.var_46f6099a) && self.var_46f6099a)
	{
		return;
	}
	self.var_46f6099a = 1;
	self clientfield::set(var_c674c4ec, 0);
	wait(1);
	self delete();
}

/*
	Name: function_542a6ee4
	Namespace: namespace_31170709
	Checksum: 0x22164AEC
	Offset: 0x16C60
	Size: 0x540
	Parameters: 5
	Flags: Linked
*/
function function_542a6ee4(e_player, var_2c03c1e4, str_task, var_32617a77, var_d8d4faff)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	e_player endon(#"entering_last_stand", #"death");
	if(str_task == #"both")
	{
		var_5841fdb6 = array(#"hash_ed86ee1cb8dfb7a", #"charged");
	}
	else
	{
		var_5841fdb6 = array(str_task);
	}
	var_99c9ce0c = level.var_28dcf408;
	n_to_kill = 0;
	var_99c9ce0c.var_155837a1[var_2c03c1e4] = 0;
	foreach(str_task in var_5841fdb6)
	{
		if(str_task == #"hash_ed86ee1cb8dfb7a")
		{
			var_59f7dee9 = var_99c9ce0c.var_59f7dee9;
			var_c016547 = var_59f7dee9[var_32617a77];
			var_eb3b90d = struct::get_array(var_c016547.target);
			n_to_kill = n_to_kill + var_eb3b90d.size;
			level function_37411f7e(var_eb3b90d, var_2c03c1e4, 1, 1, var_d8d4faff);
			continue;
		}
		switch(var_2c03c1e4)
		{
			case "death":
			{
				var_8959ce50 = array(#"hash_75db9afbf4e59ab7", #"hash_75db9bfbf4e59c6a");
				str_group = array::random(var_8959ce50);
				if(isdefined(var_99c9ce0c.var_ecc915b5) && var_99c9ce0c.var_ecc915b5)
				{
					str_group = #"hash_75db9afbf4e59ab7";
				}
				var_eb3b90d = struct::get_array(str_group);
				n_to_kill = n_to_kill + var_eb3b90d.size;
				var_d8d4faff = 0;
				level function_37411f7e(var_eb3b90d, var_2c03c1e4, 0, 1, var_d8d4faff);
				break;
			}
			case "earth":
			{
				var_8959ce50 = array(#"hash_56c60404554c8d15", #"hash_56c60104554c87fc");
				str_group = array::random(var_8959ce50);
				var_eb3b90d = struct::get_array(str_group);
				n_to_kill = n_to_kill + var_eb3b90d.size;
				level function_37411f7e(var_eb3b90d, var_2c03c1e4, 0, 1, var_d8d4faff);
				break;
			}
			case "air":
			{
				var_eb3b90d = struct::get_array(#"hash_6da4b236b2ab84fa");
				n_to_kill = n_to_kill + var_eb3b90d.size;
				level function_37411f7e(var_eb3b90d, var_2c03c1e4, 0, 1, var_d8d4faff);
				break;
			}
			case "light":
			{
				var_8959ce50 = array(#"hash_5a3fbb7f6ef6cdb8", #"hash_5a3fbe7f6ef6d2d1");
				str_group = array::random(var_8959ce50);
				var_eb3b90d = struct::get_array(str_group);
				n_to_kill = n_to_kill + 12;
				level thread function_3c6638c1(var_eb3b90d, 12, var_d8d4faff);
				break;
			}
		}
	}
	while(var_99c9ce0c.var_155837a1[var_2c03c1e4] < n_to_kill)
	{
		waitframe(1);
	}
	e_player notify(#"hash_794badff330d135f");
}

/*
	Name: function_37411f7e
	Namespace: namespace_31170709
	Checksum: 0xF94B7ECB
	Offset: 0x171A8
	Size: 0x100
	Parameters: 5
	Flags: Linked
*/
function function_37411f7e(var_eb3b90d, var_2c03c1e4, var_adf060c6, var_ad7a4904, var_d8d4faff)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	foreach(s_spawn in var_eb3b90d)
	{
		s_spawn function_6cdf4b0(var_2c03c1e4, var_adf060c6, var_ad7a4904, var_d8d4faff);
		util::wait_network_frame();
	}
}

/*
	Name: function_6cdf4b0
	Namespace: namespace_31170709
	Checksum: 0x104532BD
	Offset: 0x172B0
	Size: 0x440
	Parameters: 4
	Flags: Linked
*/
function function_6cdf4b0(var_2c03c1e4, var_adf060c6, var_ad7a4904, var_d8d4faff)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	self endon(#"death");
	var_d27a6650 = 0;
	switch(var_d8d4faff)
	{
		case 1:
		{
			var_d27a6650 = 1;
			break;
		}
		case 2:
		{
			var_d27a6650 = math::cointoss();
			break;
		}
	}
	while(true)
	{
		if(!var_d27a6650)
		{
			ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, self);
		}
		else
		{
			ai_zombie = namespace_bc12435c::function_1ea880bd(1, self);
		}
		if(isdefined(ai_zombie))
		{
			break;
		}
		util::wait_network_frame();
	}
	ai_zombie.var_be2fc36d = 1;
	ai_zombie.var_8ca159b2 = var_2c03c1e4;
	ai_zombie.var_71ecb9db = var_adf060c6;
	ai_zombie.var_564012c4 = 1;
	ai_zombie.var_aea6e035 = 1;
	ai_zombie.var_827f6f4a = 1;
	ai_zombie.var_5a3ebaa3 = 1;
	ai_zombie.var_2e4247bc = 1;
	switch(var_2c03c1e4)
	{
		case "death":
		{
			ai_zombie.var_2e4247bc = undefined;
			break;
		}
		case "earth":
		{
			ai_zombie.var_5a3ebaa3 = undefined;
			break;
		}
		case "air":
		{
			ai_zombie.var_827f6f4a = undefined;
			break;
		}
		case "light":
		{
			ai_zombie.var_aea6e035 = undefined;
			break;
		}
	}
	ai_zombie.var_f9b38410 = 1;
	ai_zombie.var_339655cf = 1;
	if(var_adf060c6)
	{
		ai_zombie.var_f9b38410 = undefined;
		ai_zombie thread function_b22c312e(var_2c03c1e4);
	}
	else
	{
		ai_zombie.var_339655cf = undefined;
		switch(var_2c03c1e4)
		{
			case "death":
			{
				ai_zombie thread function_a9398fd4();
				break;
			}
			case "earth":
			{
				ai_zombie thread function_9364cb64();
				break;
			}
		}
	}
	ai_zombie.var_126d7bef = 1;
	ai_zombie.ignore_round_spawn_failsafe = 1;
	ai_zombie.b_ignore_cleanup = 1;
	ai_zombie.ignore_enemy_count = 1;
	ai_zombie.no_powerups = 1;
	ai_zombie.var_12745932 = 1;
	ai_zombie.var_3c394b1b = 1;
	if(var_ad7a4904)
	{
		ai_zombie val::set(#"hash_1673426d64658fd5", "ignoreall", 1);
		ai_zombie.start_inert = 1;
		ai_zombie.var_67faa700 = 1;
		ai_zombie thread function_d9b360d2(self);
	}
	ai_zombie thread function_790e49a5(var_2c03c1e4, var_adf060c6);
	return ai_zombie;
}

/*
	Name: function_d9b360d2
	Namespace: namespace_31170709
	Checksum: 0xF0DD91AA
	Offset: 0x176F8
	Size: 0x10E
	Parameters: 1
	Flags: Linked
*/
function function_d9b360d2(s_spawn)
{
	self endon_callback(&function_7b08eb2c, #"death");
	v_origin = s_spawn.origin;
	v_angles = s_spawn.angles;
	self forceteleport(v_origin, v_angles);
	self dontinterpolate();
	self.var_621c2eb4 = util::spawn_model(#"tag_origin", v_origin, v_angles);
	self linkto(self.var_621c2eb4);
	while(true)
	{
		self setgoal(v_origin, 1);
		waitframe(1);
	}
}

/*
	Name: function_7b08eb2c
	Namespace: namespace_31170709
	Checksum: 0xA6E64A0C
	Offset: 0x17810
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_7b08eb2c(notifyhash)
{
	if(isdefined(self.var_621c2eb4))
	{
		self.var_621c2eb4 delete();
	}
}

/*
	Name: function_790e49a5
	Namespace: namespace_31170709
	Checksum: 0x16FDBA7F
	Offset: 0x17850
	Size: 0x214
	Parameters: 2
	Flags: Linked
*/
function function_790e49a5(var_2c03c1e4, var_adf060c6)
{
	switch(var_2c03c1e4)
	{
		case "death":
		{
			if(var_adf060c6)
			{
				var_84c10792 = "" + #"hash_415416bf220de94";
			}
			else
			{
				var_84c10792 = "" + #"hash_3e2b1092de25c2dd";
			}
			break;
		}
		case "earth":
		{
			if(var_adf060c6)
			{
				var_84c10792 = "" + #"hash_24b5302c2f39ebc2";
			}
			else
			{
				var_84c10792 = "" + #"hash_6a8479b5a5b359a7";
			}
			break;
		}
		case "air":
		{
			if(var_adf060c6)
			{
				var_84c10792 = "" + #"hash_4feb66128e57d092";
			}
			else
			{
				var_84c10792 = "" + #"hash_7552d5567ab25417";
			}
			break;
		}
		case "light":
		{
			if(var_adf060c6)
			{
				var_84c10792 = "" + #"hash_4e1b58f05f69a65a";
			}
			else
			{
				var_84c10792 = "" + #"hash_5a6761fe764bdccf";
			}
			break;
		}
	}
	self clientfield::set(var_84c10792, 1);
	while(isdefined(self) && isalive(self) && (!(isdefined(self.var_47d982a1) && self.var_47d982a1)))
	{
		waitframe(1);
	}
	if(isdefined(self))
	{
		self clientfield::set(var_84c10792, 0);
	}
}

/*
	Name: function_b22c312e
	Namespace: namespace_31170709
	Checksum: 0x43E4E4AC
	Offset: 0x17A70
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_b22c312e(var_2c03c1e4)
{
	self endon(#"death");
	while(!(isdefined(self.var_61768419) && self.var_61768419))
	{
		waitframe(1);
	}
	var_e4bacb96 = function_a67dc10(var_2c03c1e4);
	s_params = {#weapon:var_e4bacb96};
	self thread function_93e711a6(s_params);
}

/*
	Name: function_a9398fd4
	Namespace: namespace_31170709
	Checksum: 0x80941CC4
	Offset: 0x17B10
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_a9398fd4()
{
	self endon(#"death");
	while(!(isdefined(self.var_47d982a1) && self.var_47d982a1))
	{
		waitframe(1);
	}
	s_params = {#weapon:level.var_c50bf24c};
	self thread function_93e711a6(s_params);
}

/*
	Name: function_9364cb64
	Namespace: namespace_31170709
	Checksum: 0x46504375
	Offset: 0x17B90
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_9364cb64()
{
	self endon(#"death");
	while(!(isdefined(self.var_a447e680) && self.var_a447e680))
	{
		waitframe(1);
	}
	s_params = {#weapon:level.var_53789618};
	self thread function_93e711a6(s_params);
}

/*
	Name: function_3c6638c1
	Namespace: namespace_31170709
	Checksum: 0xAEB0AA40
	Offset: 0x17C10
	Size: 0xF6
	Parameters: 3
	Flags: Linked
*/
function function_3c6638c1(var_eb3b90d, n_zombies, var_d8d4faff)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_285de4ce79135552");
	for(i = 0; i < n_zombies; i++)
	{
		s_spawn = array::random(var_eb3b90d);
		ai_zombie = s_spawn function_6cdf4b0(#"light", 0, 0, var_d8d4faff);
		ai_zombie zombie_utility::set_zombie_run_cycle_override_value("sprint");
		wait(0.25);
	}
}

/*
	Name: function_12ff6bb5
	Namespace: namespace_31170709
	Checksum: 0x655813E6
	Offset: 0x17D10
	Size: 0x2D0
	Parameters: 1
	Flags: None
*/
function function_12ff6bb5(var_12caf287)
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_79ebfc45b1857e0a", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	var_eb3b90d = struct::get_array(#"hash_408827725d1ed07a");
	a_ai_spawned = [];
	while(true)
	{
		a_ai_spawned = array::remove_dead(a_ai_spawned);
		if(a_ai_spawned.size < 6 && getaiarray().size < level.zombie_ai_limit)
		{
			var_d27a6650 = 0;
			if(var_12caf287 > 2)
			{
				var_d27a6650 = math::cointoss();
			}
			s_spawn = array::random(var_eb3b90d);
			if(isdefined(s_spawn.script_noteworthy))
			{
				var_d27a6650 = 0;
			}
			while(true)
			{
				if(!var_d27a6650)
				{
					ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, s_spawn);
				}
				else
				{
					ai_zombie = namespace_bc12435c::function_1ea880bd(1, s_spawn);
				}
				if(isdefined(ai_zombie))
				{
					break;
				}
				waitframe(1);
			}
			if(!isdefined(a_ai_spawned))
			{
				a_ai_spawned = [];
			}
			else if(!isarray(a_ai_spawned))
			{
				a_ai_spawned = array(a_ai_spawned);
			}
			a_ai_spawned[a_ai_spawned.size] = ai_zombie;
			ai_zombie.var_126d7bef = 1;
			ai_zombie.ignore_round_spawn_failsafe = 1;
			ai_zombie.b_ignore_cleanup = 1;
			ai_zombie.ignore_enemy_count = 1;
			ai_zombie.no_powerups = 1;
			ai_zombie.var_3c394b1b = 1;
		}
		n_random_wait = randomfloatrange(1, 2);
		wait(n_random_wait);
	}
}

/*
	Name: function_79a4f7f8
	Namespace: namespace_31170709
	Checksum: 0xC1D4E9C7
	Offset: 0x17FE8
	Size: 0x152
	Parameters: 0
	Flags: None
*/
function function_79a4f7f8()
{
	level endon(#"end_game", #"play" + "_ended_early", #"hash_79ebfc45b1857e0a", #"hash_666e960831b9abc4", #"hash_285de4ce79135552");
	n_random_wait = randomfloatrange(10, 20);
	wait(n_random_wait);
	s_spawn = struct::get(#"hash_55ffe99e3e9981b7");
	while(true)
	{
		var_8756a1bd = namespace_75cbf125::function_6249817(1, s_spawn);
		if(isdefined(var_8756a1bd))
		{
			break;
		}
		waitframe(1);
	}
	var_8756a1bd.var_126d7bef = 1;
	var_8756a1bd.ignore_round_spawn_failsafe = 1;
	var_8756a1bd.b_ignore_cleanup = 1;
	var_8756a1bd.ignore_enemy_count = 1;
	var_8756a1bd.no_powerups = 1;
	var_8756a1bd.var_3c394b1b = 1;
}

/*
	Name: function_1ddccc6c
	Namespace: namespace_31170709
	Checksum: 0xDC0A5651
	Offset: 0x18148
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function function_1ddccc6c()
{
	level endon(#"end_game");
	wait(5);
	s_reward = struct::get(#"hash_534aae214445a501");
	var_33b1d054 = s_reward.origin;
	s_reward struct::delete();
	level thread zm_powerups::specific_powerup_drop("full_ammo", var_33b1d054, undefined, undefined, undefined, 0, 1);
	var_6463d67c = level.var_6463d67c;
	var_2b4d16c2 = level.var_48e2ab90;
	level.var_6463d67c = undefined;
	level.var_48e2ab90 = undefined;
	zm_utility::function_4a25b584(var_33b1d054, 10, 128);
	level.var_6463d67c = var_6463d67c;
	level.var_48e2ab90 = var_2b4d16c2;
}

/*
	Name: function_26af8a57
	Namespace: namespace_31170709
	Checksum: 0x9089C9BD
	Offset: 0x18290
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_26af8a57()
{
	var_9586c2b5 = spawnstruct();
	level.var_d16c3b5 = var_9586c2b5;
	var_736d4873 = array(12, 2, 15, 19, 6, 9);
	var_8b3ef4f7 = [];
	var_8cdb3dc1 = [];
	mdl_door = getent("mdl_blood_code", "targetname");
	foreach(var_3d018683 in var_736d4873)
	{
		var_66d75ac = "tag_panel_real_";
		var_cd82427a = "tag_panel_real_emissive_";
		if(var_3d018683 < 10)
		{
			var_66d75ac = var_66d75ac + 0;
			var_cd82427a = var_cd82427a + 0;
		}
		str_tag = var_66d75ac + var_3d018683;
		str_glow_tag = var_cd82427a + var_3d018683;
		mdl_door hidepart(str_glow_tag);
		v_target = mdl_door gettagorigin(str_tag);
		if(!isdefined(var_8b3ef4f7))
		{
			var_8b3ef4f7 = [];
		}
		else if(!isarray(var_8b3ef4f7))
		{
			var_8b3ef4f7 = array(var_8b3ef4f7);
		}
		var_8b3ef4f7[var_8b3ef4f7.size] = str_glow_tag;
		if(!isdefined(var_8cdb3dc1))
		{
			var_8cdb3dc1 = [];
		}
		else if(!isarray(var_8cdb3dc1))
		{
			var_8cdb3dc1 = array(var_8cdb3dc1);
		}
		var_8cdb3dc1[var_8cdb3dc1.size] = v_target;
	}
	var_9586c2b5.var_8b3ef4f7 = var_8b3ef4f7;
	var_9586c2b5.var_8cdb3dc1 = var_8cdb3dc1;
	mdl_weapon_clip = getent("mdl_blood_bounce", "targetname");
	if(zm_utility::function_e51dc2d8())
	{
		mdl_weapon_clip notsolid();
	}
	else
	{
		mdl_weapon_clip delete();
	}
}

/*
	Name: function_2954c1bf
	Namespace: namespace_31170709
	Checksum: 0xF2A8CF4
	Offset: 0x18588
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_2954c1bf(var_77104def)
{
	level endon(#"end_game", #"blood" + "_ended_early");
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 6);
	level thread scene::init_streamer(#"hash_53792003d706a2e", #"allies");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	var_9586c2b5 = level.var_d16c3b5;
	var_9586c2b5.var_774f9f7b = 6;
	var_9586c2b5.var_27dc3a2f = 0;
	callback::function_78ccee50(&function_b224d9eb);
	level waittill(#"hash_59e7b50156995646");
}

/*
	Name: function_e74f32a2
	Namespace: namespace_31170709
	Checksum: 0xBE3D4C22
	Offset: 0x18698
	Size: 0x118
	Parameters: 2
	Flags: Linked
*/
function function_e74f32a2(var_77104def, var_19e802fa)
{
	callback::function_deba137d(&function_b224d9eb);
	level notify(#"hash_59e7b50156995646");
	var_9586c2b5 = level.var_d16c3b5;
	var_8b3ef4f7 = var_9586c2b5.var_8b3ef4f7;
	mdl_door = getent("mdl_blood_code", "targetname");
	foreach(str_glow_tag in var_8b3ef4f7)
	{
		mdl_door showpart(str_glow_tag);
	}
}

/*
	Name: function_b224d9eb
	Namespace: namespace_31170709
	Checksum: 0x704FCB91
	Offset: 0x187B8
	Size: 0x508
	Parameters: 1
	Flags: Linked
*/
function function_b224d9eb(s_params)
{
	w_weapon = s_params.weapon;
	if(!zm_utility::is_player_valid(self) || (!(isdefined(w_weapon.isprimary) && w_weapon.isprimary)) || (isdefined(w_weapon.isprojectileweapon) && w_weapon.isprojectileweapon) || w_weapon.type === "script")
	{
		return;
	}
	var_9586c2b5 = level.var_d16c3b5;
	if(!isdefined(var_9586c2b5) || (isdefined(var_9586c2b5.var_3886603c) && var_9586c2b5.var_3886603c))
	{
		return;
	}
	var_2ed6f142 = self getweaponmuzzlepoint();
	v_forward = self getweaponforwarddir();
	v_end = var_2ed6f142 + v_forward * 10000;
	a_trace = bullettrace(var_2ed6f142, v_end, 0, self);
	if(isdefined(a_trace))
	{
		var_20986e19 = a_trace[#"entity"];
		v_hit = a_trace[#"position"];
		mdl_door = getent("mdl_blood_code", "targetname");
		if(var_20986e19 === mdl_door && isdefined(v_hit))
		{
			n_index = var_9586c2b5.var_27dc3a2f;
			var_8b3ef4f7 = var_9586c2b5.var_8b3ef4f7;
			var_8cdb3dc1 = var_9586c2b5.var_8cdb3dc1;
			v_target = var_8cdb3dc1[n_index];
			if(!isdefined(v_target))
			{
				return;
			}
			n_dist = distancesquared(v_hit, v_target);
			if(n_dist <= 10 * 10)
			{
				str_glow_tag = var_8b3ef4f7[n_index];
				mdl_door showpart(str_glow_tag);
				mdl_door playsoundontag(#"hash_27384a9aed0e6481", str_glow_tag);
				var_9586c2b5.var_27dc3a2f++;
				if(var_9586c2b5.var_27dc3a2f >= var_9586c2b5.var_774f9f7b)
				{
					var_9586c2b5.var_3886603c = 1;
					var_9586c2b5.var_ea0be65c = self;
					level notify(#"hash_59e7b50156995646");
				}
			}
			else
			{
				var_35a69490 = 0;
				for(i = 0; i < var_9586c2b5.var_27dc3a2f; i++)
				{
					v_target = var_8cdb3dc1[i];
					n_dist = distancesquared(v_hit, v_target);
					if(n_dist <= 10 * 10)
					{
						var_35a69490 = 1;
						break;
					}
				}
				if(!var_35a69490)
				{
					if(var_9586c2b5.var_27dc3a2f > 0)
					{
						self thread zm_audio::create_and_play_dialog(#"generic", #"response_negative");
						foreach(str_glow_tag in var_8b3ef4f7)
						{
							mdl_door playsoundontag(#"hash_255e2eb89fb1d228", str_glow_tag);
						}
					}
					var_9586c2b5.var_27dc3a2f = 0;
					foreach(str_glow_tag in var_8b3ef4f7)
					{
						mdl_door hidepart(str_glow_tag);
					}
				}
			}
		}
	}
}

/*
	Name: function_1cb738a0
	Namespace: namespace_31170709
	Checksum: 0xA515E632
	Offset: 0x18CC8
	Size: 0x2A6
	Parameters: 1
	Flags: Linked
*/
function function_1cb738a0(var_77104def)
{
	level endon(#"end_game", #"hash_75294573d425dff4" + "_ended_early", #"hash_385b5bbf2492408c");
	var_9586c2b5 = level.var_d16c3b5;
	/#
		if(var_77104def)
		{
			callback::on_disconnect(&function_afd5b72a);
			var_9586c2b5.var_d5c65c5e = 1;
			return;
		}
	#/
	if(!function_9eacf92d())
	{
		var_9586c2b5 = level.var_d16c3b5;
		e_player = var_9586c2b5.var_ea0be65c;
		if(zm_utility::is_player_valid(e_player))
		{
			e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
		}
		return;
	}
	callback::on_connect(&function_2fdd2850);
	array::thread_all(getplayers(), &function_2fdd2850);
	callback::on_disconnect(&function_afd5b72a);
	s_unitrigger = struct::get(#"hash_4054acecbf766067");
	s_unitrigger zm_unitrigger::create(&function_c3735f60, 64);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = s_unitrigger waittill(#"trigger_activated");
		e_player = var_be17187b.e_who;
		if(zm_utility::is_player_valid(e_player) && e_player function_90836224() && (isdefined(var_9586c2b5.b_players_ready) && var_9586c2b5.b_players_ready) && (!(isdefined(e_player.var_564dec14) && e_player.var_564dec14)))
		{
			break;
		}
	}
	var_9586c2b5.var_d5c65c5e = 1;
}

/*
	Name: function_ebe10128
	Namespace: namespace_31170709
	Checksum: 0x1B71A4E9
	Offset: 0x18F78
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_ebe10128(var_77104def, var_19e802fa)
{
	level notify(#"hash_57e7801ba472d7f9");
	s_unitrigger = struct::get(#"hash_4054acecbf766067");
	if(isdefined(s_unitrigger.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(s_unitrigger.s_unitrigger);
		s_unitrigger.s_unitrigger = undefined;
	}
	s_unitrigger struct::delete();
}

/*
	Name: function_c3735f60
	Namespace: namespace_31170709
	Checksum: 0x21F634DD
	Offset: 0x19028
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_c3735f60(e_player)
{
	if(zm_utility::is_player_valid(e_player) && e_player function_90836224() && (isdefined(e_player.var_4f958d45) && e_player.var_4f958d45) && (!(isdefined(e_player.var_564dec14) && e_player.var_564dec14)))
	{
		a_e_players = function_e3142c13();
		var_5e0ce220 = a_e_players[#"hash_1e10943309f858e"];
		var_5adbb2f7 = a_e_players[#"hash_6becd1d9b42235f"];
		if(var_5e0ce220 === e_player)
		{
			var_57ce903d = var_5adbb2f7;
			var_6fd6a42e = #"hash_3ee9cef44af6161a";
		}
		else
		{
			var_57ce903d = var_5e0ce220;
			var_6fd6a42e = #"hash_6e9541ef6c1ea427";
		}
		b_enabled = 1;
		if(isdefined(var_57ce903d))
		{
			if(!(isdefined(var_57ce903d.var_4f958d45) && var_57ce903d.var_4f958d45) || (isdefined(var_57ce903d.var_564dec14) && var_57ce903d.var_564dec14))
			{
				b_enabled = 0;
			}
		}
		var_9586c2b5 = level.var_d16c3b5;
		var_9586c2b5.b_players_ready = b_enabled;
		if(b_enabled)
		{
			str_prompt = zm_utility::function_d6046228(#"hash_69c54340ac778652", #"hash_19bff4ab299e71e6");
			self sethintstringforplayer(e_player, str_prompt);
		}
		else
		{
			self sethintstringforplayer(e_player, var_6fd6a42e);
		}
	}
	else
	{
		self sethintstringforplayer(e_player, "");
	}
	return 1;
}

/*
	Name: function_153ee6c7
	Namespace: namespace_31170709
	Checksum: 0x6F407796
	Offset: 0x192A8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_153ee6c7(str_character)
{
	foreach(e_player in getplayers())
	{
		if(e_player namespace_48f3568::function_69e9e553(str_character))
		{
			return e_player;
		}
	}
}

/*
	Name: function_e3142c13
	Namespace: namespace_31170709
	Checksum: 0x16BC0EB1
	Offset: 0x19348
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function function_e3142c13()
{
	a_e_players = [];
	var_5e0ce220 = function_153ee6c7(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
	var_5adbb2f7 = function_153ee6c7(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
	if(isdefined(var_5e0ce220))
	{
		a_e_players[#"hash_1e10943309f858e"] = var_5e0ce220;
	}
	if(isdefined(var_5adbb2f7))
	{
		a_e_players[#"hash_6becd1d9b42235f"] = var_5adbb2f7;
	}
	return a_e_players;
}

/*
	Name: function_9eacf92d
	Namespace: namespace_31170709
	Checksum: 0xE8FC130E
	Offset: 0x19448
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_9eacf92d()
{
	a_e_players = function_e3142c13();
	return isdefined(a_e_players[#"hash_1e10943309f858e"]) || isdefined(a_e_players[#"hash_6becd1d9b42235f"]);
}

/*
	Name: function_90836224
	Namespace: namespace_31170709
	Checksum: 0xE0907575
	Offset: 0x194A0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_90836224()
{
	a_e_players = function_e3142c13();
	return isinarray(a_e_players, self);
}

/*
	Name: function_2fdd2850
	Namespace: namespace_31170709
	Checksum: 0xC46E30C5
	Offset: 0x194E0
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function function_2fdd2850()
{
	self notify("4068843564855f72");
	self endon("4068843564855f72");
	level endon(#"end_game", #"hash_75294573d425dff4" + "_ended_early", #"hash_57e7801ba472d7f9", #"hash_385b5bbf2492408c");
	self endon(#"disconnect");
	if(!self function_90836224())
	{
		return;
	}
	s_door = struct::get(#"hash_4054acecbf766067");
	var_402f253d = s_door.origin;
	while(true)
	{
		waitframe(1);
		if(zm_utility::is_player_valid(self))
		{
			n_dist = distance2dsquared(var_402f253d, self.origin);
			if(n_dist <= 64 * 64)
			{
				self.var_4f958d45 = 1;
				continue;
			}
		}
		self.var_4f958d45 = undefined;
	}
}

/*
	Name: function_afd5b72a
	Namespace: namespace_31170709
	Checksum: 0x1D5C2A72
	Offset: 0x19648
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_afd5b72a()
{
	if(!function_9eacf92d())
	{
		level notify(#"hash_385b5bbf2492408c");
	}
	if(self function_90836224() && level scene::is_active(#"hash_53792003d706a2e"))
	{
		level thread function_f9c3ccc4();
	}
}

/*
	Name: function_f9c3ccc4
	Namespace: namespace_31170709
	Checksum: 0x138662DF
	Offset: 0x196C8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_f9c3ccc4()
{
	self notify("393d26483d138935");
	self endon("393d26483d138935");
	util::wait_network_frame();
	level notify(#"hash_7a407f37d5416506");
	level scene::stop(#"hash_53792003d706a2e");
}

/*
	Name: function_ce32cc66
	Namespace: namespace_31170709
	Checksum: 0xBD88F999
	Offset: 0x19740
	Size: 0xCBC
	Parameters: 1
	Flags: Linked
*/
function function_ce32cc66(var_77104def)
{
	level endon(#"end_game", #"mid_igc" + "_ended_early");
	var_9586c2b5 = level.var_d16c3b5;
	var_9586c2b5.var_52ecb170 = level.player_out_of_playable_area_override;
	level.player_out_of_playable_area_override = &function_5810a89;
	level.var_b2b15659 = 1;
	level notify(#"hash_6e979a553f2df885");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	if(!(isdefined(var_9586c2b5.var_d5c65c5e) && var_9586c2b5.var_d5c65c5e))
	{
		return;
	}
	var_5e0ce220 = function_153ee6c7(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
	var_5adbb2f7 = function_153ee6c7(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
	if(!isdefined(var_5e0ce220) && !isdefined(var_5adbb2f7))
	{
		return;
	}
	n_players = util::get_active_players().size;
	if(isdefined(var_5e0ce220))
	{
		n_players--;
	}
	if(isdefined(var_5adbb2f7))
	{
		n_players--;
	}
	if(n_players <= 0)
	{
		level flag::clear("spawn_zombies");
		level flag::set("pause_round_timeout");
		level flag::set("hold_round_end");
		var_9586c2b5.var_45fcc5e8 = 1;
	}
	else
	{
		var_9586c2b5.var_45fcc5e8 = 0;
	}
	if(!isdefined(var_5e0ce220))
	{
		var_5e0ce220 = bot::add_bot(#"allies");
		var_9586c2b5.var_c702bbb0 = var_5e0ce220;
		var_5e0ce220 namespace_48f3568::set_character(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
		var_5e0ce220 function_79cb401b();
	}
	if(!isdefined(var_5adbb2f7))
	{
		var_5adbb2f7 = bot::add_bot(#"allies");
		var_9586c2b5.var_208b164f = var_5adbb2f7;
		var_5adbb2f7 namespace_48f3568::set_character(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
		var_5adbb2f7 function_79cb401b();
	}
	var_54cae2d8 = getweapon(#"zhield_zpear_dw");
	var_2d23a7ee = getaiarchetypearray(#"blight_father");
	foreach(e_actor in array(var_5e0ce220, var_5adbb2f7))
	{
		if(!isplayer(e_actor))
		{
			return;
		}
		e_actor val::set(#"hash_55fd1fb4f9d0d36a", "takedamage", 0);
		e_actor val::set(#"hash_4bf78d3b9951a760", "ignoreme", 1);
		e_actor val::set(#"hash_bdeb2459b0170b1", "ignoreall", 1);
		e_actor.var_f22c83f5 = 1;
		e_actor.var_f4e33249 = 1;
		e_actor.var_6b830459 = 1;
		e_actor notify(#"hash_46064b6c2cb5cf20");
		foreach(var_b9a803af in var_2d23a7ee)
		{
			var_beb2295 = var_b9a803af.var_beb2295;
			if(var_beb2295 === e_actor)
			{
				var_b9a803af notify(#"hash_2fb2eddfa6a0ef3f");
				level thread namespace_1e226e4e::function_c526065b(var_b9a803af);
				break;
			}
		}
		var_c7410412 = e_actor.var_fd05e363;
		if(isdefined(var_c7410412))
		{
			var_bcd1c2ff = e_actor gadgetgetslot(var_c7410412);
			if(e_actor gadgetisactive(var_bcd1c2ff) || e_actor function_36dfc05f(var_bcd1c2ff))
			{
				e_actor.var_b0df5e59 = var_bcd1c2ff;
				e_actor thread zm_hero_weapon::function_3d1ba0b(var_bcd1c2ff, var_c7410412);
			}
		}
	}
	while(true)
	{
		var_b5d11642 = 1;
		foreach(e_player in array(var_5e0ce220, var_5adbb2f7))
		{
			if(!isdefined(e_player))
			{
				return;
			}
			var_bcd1c2ff = e_player.var_b0df5e59;
			if(isdefined(var_bcd1c2ff) && (e_player gadgetisactive(var_bcd1c2ff) || e_player function_36dfc05f(var_bcd1c2ff)))
			{
				var_b5d11642 = 0;
				break;
			}
		}
		if(var_b5d11642)
		{
			break;
		}
		waitframe(1);
	}
	if(!isdefined(var_5e0ce220) || !isdefined(var_5adbb2f7))
	{
		return;
	}
	setdvar(#"cg_disableplayernames", 1);
	setdvar(#"hash_2d5b0d6d4ce995d7", 0);
	namespace_14104b98::function_33565c6e(1);
	var_9586c2b5.var_9f2db310 = 1;
	foreach(e_actor in array(var_5e0ce220, var_5adbb2f7))
	{
		if(e_actor hasweapon(var_54cae2d8))
		{
			e_actor.var_94bab787 = 1;
			e_actor takeweapon(var_54cae2d8);
		}
		mdl_fx = util::spawn_model(#"tag_origin", e_actor gettagorigin("j_spine4"), e_actor gettagangles("j_spine4"));
		mdl_fx clientfield::increment("" + #"hash_4c6d342dccfd6d73");
		mdl_fx thread util::delayed_delete(1);
		e_actor clientfield::set("" + #"hash_67b317587e795ec2", 1);
		e_actor setinvisibletoall();
		e_actor val::set(#"hash_3d6959de8fb9ed1a", "disable_weapons", 1);
		e_actor thread lui::screen_fade_out(0.5);
	}
	wait(0.75);
	if(!isdefined(var_5e0ce220) || !isdefined(var_5adbb2f7))
	{
		return;
	}
	var_ad33d7fe = struct::get(#"hash_5391982125b20498");
	var_eaf1740a = struct::get(#"hash_401be93bf2a88e39");
	var_5e0ce220 dontinterpolate();
	var_5e0ce220 setorigin(var_ad33d7fe.origin);
	var_5e0ce220 setvisibletoall();
	var_5adbb2f7 dontinterpolate();
	var_5adbb2f7 setorigin(var_eaf1740a.origin);
	var_5adbb2f7 setvisibletoall();
	wait(1);
	if(!isdefined(var_5e0ce220) || !isdefined(var_5adbb2f7))
	{
		return;
	}
	var_5e0ce220.script_animname = "e_blood_scar";
	var_5adbb2f7.script_animname = "e_blood_brute";
	mdl_door = getent("mdl_blood_code", "targetname");
	mdl_door.script_animname = "mdl_blood_code";
	level thread function_b8834fae(1);
	var_5e0ce220 thread function_c12407c0();
	var_5adbb2f7 thread function_a750434e();
	var_5e0ce220 thread function_7e27fc5e();
	var_5adbb2f7 thread function_7e27fc5e();
	level scene::add_scene_func(#"hash_53792003d706a2e", &function_f81bfa93, "play");
	level scene::play(#"hash_53792003d706a2e", array(var_5e0ce220, var_5adbb2f7, mdl_door));
	namespace_14104b98::function_33565c6e(0);
	level thread function_b8834fae(0);
}

/*
	Name: function_f81bfa93
	Namespace: namespace_31170709
	Checksum: 0x10D17398
	Offset: 0x1A408
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_f81bfa93(a_ents)
{
	mdl_weapon_clip = getent("mdl_blood_bounce", "targetname");
	mdl_weapon_clip solid();
	var_5e0ce220 = a_ents[#"hash_576fb31703d2283d"];
	var_5adbb2f7 = a_ents[#"hash_5a42f96ff19f28"];
	var_5adbb2f7 playsoundtoplayer(#"hash_6469d6b70bfbf855", var_5adbb2f7);
	var_5e0ce220 playsoundtoplayer(#"hash_3a00192f62922210", var_5e0ce220);
	level thread function_cce14a84(var_5e0ce220, var_5adbb2f7);
	level scene::remove_scene_func(#"hash_53792003d706a2e", &function_f81bfa93, "play");
}

/*
	Name: function_cce14a84
	Namespace: namespace_31170709
	Checksum: 0x72AAEA8B
	Offset: 0x1A538
	Size: 0xB2
	Parameters: 2
	Flags: Linked
*/
function function_cce14a84(var_5e0ce220, var_5adbb2f7)
{
	wait(0.1);
	var_9586c2b5 = level.var_d16c3b5;
	if(isdefined(var_9586c2b5.var_9f2db310) && var_9586c2b5.var_9f2db310)
	{
		if(isdefined(var_5e0ce220))
		{
			var_5e0ce220 thread lui::screen_fade_in(0.5);
		}
		if(isdefined(var_5adbb2f7))
		{
			var_5adbb2f7 thread lui::screen_fade_in(0.5);
		}
		var_9586c2b5.var_9f2db310 = 0;
	}
}

/*
	Name: function_b8834fae
	Namespace: namespace_31170709
	Checksum: 0x444FA980
	Offset: 0x1A5F8
	Size: 0x270
	Parameters: 1
	Flags: Linked
*/
function function_b8834fae(var_bcf66490)
{
	var_5e0ce220 = function_153ee6c7(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
	var_5adbb2f7 = function_153ee6c7(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
	foreach(e_player in getplayers())
	{
		if(isdefined(var_bcf66490) && var_bcf66490)
		{
			if(e_player !== var_5e0ce220 && e_player !== var_5adbb2f7)
			{
				e_player.dontspeak = 1;
				e_player scene::function_8b06792(#"hash_53792003d706a2e");
			}
			if(isdefined(var_5e0ce220) && e_player === var_5e0ce220 || (isdefined(var_5adbb2f7) && e_player === var_5adbb2f7))
			{
				e_player clientfield::set_to_player("" + #"hash_49068d48a9eb7b89", 1);
			}
			else
			{
				e_player clientfield::set_to_player("" + #"hash_49068d48a9eb7b89", 2);
			}
			continue;
		}
		if(e_player !== var_5e0ce220 && e_player !== var_5adbb2f7)
		{
			e_player.dontspeak = undefined;
		}
		e_player clientfield::set_to_player("" + #"hash_49068d48a9eb7b89", 0);
	}
}

/*
	Name: function_c12407c0
	Namespace: namespace_31170709
	Checksum: 0x50E842A5
	Offset: 0x1A870
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_c12407c0()
{
	self endon(#"death");
	self waittill(#"start_fade");
	self thread lui::screen_fade_out(3, (0, 0, 0));
	self waittill(#"start_fade");
	self lui::screen_fade_in(0, (1, 1, 1));
	self thread lui::screen_fade_out(0.1, (1, 1, 1));
	self waittill(#"end_fade");
	self thread lui::screen_fade_in(2, (1, 1, 1));
}

/*
	Name: function_a750434e
	Namespace: namespace_31170709
	Checksum: 0xF73B2DE9
	Offset: 0x1A940
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_a750434e()
{
	self endon(#"death");
	self waittill(#"start_fade");
	self thread lui::screen_fade_out(0.5, (1, 1, 1));
	self waittill(#"end_fade");
	self thread lui::screen_fade_in(2, (1, 1, 1));
}

/*
	Name: function_7e27fc5e
	Namespace: namespace_31170709
	Checksum: 0xF459D1B2
	Offset: 0x1A9C8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_7e27fc5e()
{
	self endon(#"death");
	var_be17187b = undefined;
	var_be17187b = level waittill(#"hash_1326170570136bab", #"end_game", #"hash_7a407f37d5416506");
	if(var_be17187b._notify == "blood_fuzzy_start")
	{
		self clientfield::set("" + #"hash_10275bcd47e53936", 1);
		level waittill(#"hash_6fc71e0dfad6268e", #"end_game", #"hash_7a407f37d5416506");
		self clientfield::set("" + #"hash_10275bcd47e53936", 0);
	}
}

/*
	Name: function_e5cd3130
	Namespace: namespace_31170709
	Checksum: 0x4386EA4B
	Offset: 0x1AAD8
	Size: 0xA4C
	Parameters: 2
	Flags: Linked
*/
function function_e5cd3130(var_77104def, var_19e802fa)
{
	var_9586c2b5 = level.var_d16c3b5;
	level.player_out_of_playable_area_override = var_9586c2b5.var_52ecb170;
	level.var_b2b15659 = undefined;
	callback::remove_on_disconnect(&function_afd5b72a);
	if(isdefined(var_9586c2b5.var_45fcc5e8) && var_9586c2b5.var_45fcc5e8)
	{
		level flag::set("spawn_zombies");
		level flag::clear("pause_round_timeout");
		level flag::clear("hold_round_end");
	}
	mdl_weapon_clip = getent("mdl_blood_bounce", "targetname");
	mdl_weapon_clip delete();
	var_ad33d7fe = struct::get(#"hash_125d10ad0d2bf469");
	var_eaf1740a = struct::get(#"hash_4c80f9a7539d48a8");
	var_45de69ce = var_ad33d7fe.origin;
	var_8fa0b4c1 = var_ad33d7fe.angles;
	var_43b8df0c = var_eaf1740a.origin;
	var_c5aa5678 = var_eaf1740a.angles;
	var_ad33d7fe struct::delete();
	var_eaf1740a struct::delete();
	var_54cae2d8 = getweapon(#"zhield_zpear_dw");
	if(isdefined(var_9586c2b5.var_c702bbb0))
	{
		bot::remove_bot(var_9586c2b5.var_c702bbb0);
	}
	else
	{
		var_5e0ce220 = function_153ee6c7(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
		if(isdefined(var_5e0ce220))
		{
			var_5e0ce220 val::reset(#"hash_3d6959de8fb9ed1a", "disable_weapons");
			var_5e0ce220.var_f22c83f5 = undefined;
			var_5e0ce220.var_f4e33249 = undefined;
			var_5e0ce220.var_6b830459 = undefined;
			var_5e0ce220 val::reset(#"hash_55fd1fb4f9d0d36a", "takedamage");
			var_5e0ce220 val::reset(#"hash_4bf78d3b9951a760", "ignoreme");
			var_5e0ce220 val::reset(#"hash_bdeb2459b0170b1", "ignoreall");
			var_5e0ce220 util::delay(float(function_60d95f53()) / 1000, undefined, &clientfield::set, "" + #"hash_67b317587e795ec2", 0);
			var_5e0ce220 clientfield::set("" + #"hash_10275bcd47e53936", 0);
			if(!var_77104def && !var_19e802fa)
			{
				var_5e0ce220 dontinterpolate();
				var_5e0ce220 setorigin(var_45de69ce);
				var_5e0ce220 setplayerangles(var_8fa0b4c1);
				mdl_fx = util::spawn_model(#"tag_origin", var_5e0ce220 gettagorigin("j_spine4"), var_5e0ce220 gettagangles("j_spine4"));
				mdl_fx clientfield::increment("" + #"hash_4c6d342dccfd6d73");
				mdl_fx thread util::delayed_delete(1);
			}
			if(isdefined(var_5e0ce220.var_94bab787) && var_5e0ce220.var_94bab787)
			{
				var_5e0ce220 giveweapon(var_54cae2d8);
			}
			if(isdefined(var_9586c2b5.var_9f2db310) && var_9586c2b5.var_9f2db310)
			{
				var_5e0ce220 thread lui::screen_fade_in(1);
			}
		}
	}
	if(isdefined(var_9586c2b5.var_208b164f))
	{
		bot::remove_bot(var_9586c2b5.var_208b164f);
	}
	else
	{
		var_5adbb2f7 = function_153ee6c7(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
		if(isdefined(var_5adbb2f7))
		{
			var_5adbb2f7 val::reset(#"hash_3d6959de8fb9ed1a", "disable_weapons");
			var_5adbb2f7.var_f22c83f5 = undefined;
			var_5adbb2f7.var_f4e33249 = undefined;
			var_5adbb2f7.var_6b830459 = undefined;
			var_5adbb2f7 val::reset(#"hash_55fd1fb4f9d0d36a", "takedamage");
			var_5adbb2f7 val::reset(#"hash_4bf78d3b9951a760", "ignoreme");
			var_5adbb2f7 val::reset(#"hash_bdeb2459b0170b1", "ignoreall");
			var_5adbb2f7 util::delay(float(function_60d95f53()) / 1000, undefined, &clientfield::set, "" + #"hash_67b317587e795ec2", 0);
			var_5adbb2f7 clientfield::set("" + #"hash_10275bcd47e53936", 0);
			if(!var_77104def && !var_19e802fa)
			{
				var_5adbb2f7 dontinterpolate();
				var_5adbb2f7 setorigin(var_43b8df0c);
				var_5adbb2f7 setplayerangles(var_c5aa5678);
				mdl_fx = util::spawn_model(#"tag_origin", var_5adbb2f7 gettagorigin("j_spine4"), var_5adbb2f7 gettagangles("j_spine4"));
				mdl_fx clientfield::increment("" + #"hash_4c6d342dccfd6d73");
				mdl_fx thread util::delayed_delete(1);
			}
			if(isdefined(var_5adbb2f7.var_94bab787) && var_5adbb2f7.var_94bab787)
			{
				var_5adbb2f7 giveweapon(var_54cae2d8);
			}
			if(isdefined(var_9586c2b5.var_9f2db310) && var_9586c2b5.var_9f2db310)
			{
				var_5adbb2f7 thread lui::screen_fade_in(1);
			}
		}
	}
	var_9586c2b5.var_9f2db310 = 0;
	setdvar(#"cg_disableplayernames", 0);
	setdvar(#"hash_2d5b0d6d4ce995d7", 1);
	namespace_891c9bac::function_769aa73b("post_mid_banter", array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"), array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
	callback::on_connect(&function_dcc3c705);
	if(isdefined(var_5e0ce220))
	{
		var_5e0ce220 thread function_dcc3c705();
	}
	if(var_77104def || var_19e802fa)
	{
		level thread function_5a8c0d95();
	}
	else
	{
		level thread function_cb724dc5();
		function_5a8c0d95();
	}
	level.var_d16c3b5 struct::delete();
}

/*
	Name: function_5810a89
	Namespace: namespace_31170709
	Checksum: 0xDDF767B5
	Offset: 0x1B530
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_5810a89()
{
	if(isdefined(self.var_6b830459) && self.var_6b830459)
	{
		return 0;
	}
	return undefined;
}

/*
	Name: function_79cb401b
	Namespace: namespace_31170709
	Checksum: 0x55BFE872
	Offset: 0x1B560
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_79cb401b()
{
	self endon(#"disconnect");
	while(self.sessionstate !== "playing")
	{
		waitframe(1);
	}
	while(self.sessionstate !== "spectator")
	{
		waitframe(1);
	}
	if(self util::function_bf5a8f5c())
	{
		self zm_player::spectator_respawn_player();
	}
	while(self.sessionstate !== "playing")
	{
		waitframe(1);
	}
}

/*
	Name: function_5a8c0d95
	Namespace: namespace_31170709
	Checksum: 0x873FFBF6
	Offset: 0x1B610
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function function_5a8c0d95()
{
	level endon(#"end_game");
	var_a6ac7ab6 = struct::get(#"hash_5a26d9402630b7e1");
	s_base = struct::get(#"hash_4d4ad65b737bdceb");
	playrumbleonposition(#"hash_78384ae5c2a95e85", s_base.origin);
	v_mirror = var_a6ac7ab6.origin - (0, 0, 256);
	var_a27921de = s_base.origin - (0, 0, 256);
	playsoundatposition(#"hash_396f1597d3662c78", (0, 0, 0));
	var_919d328 = util::spawn_model(var_a6ac7ab6.model, v_mirror, var_a6ac7ab6.angles);
	mdl_base = util::spawn_model(s_base.model, var_a27921de, s_base.angles);
	var_919d328 setscale(0.75);
	mdl_base setscale(0.75);
	var_a6ac7ab6 struct::delete();
	s_base struct::delete();
	var_919d328 movez(256, 5);
	mdl_base movez(256, 5);
	wait(5 - 1.5);
	level clientfield::set("" + #"hash_31a10d565ae05ddb", 2);
	level clientfield::set("" + #"hash_1c97c11fb59eb4bf", 1);
	level clientfield::set("" + #"hash_51e28147388ee3d8", 1);
	level clientfield::set("" + #"hash_16e27bea0cc1b56b", 1);
	exploder::exploder("fxexp_barrier_egg_hit");
}

/*
	Name: function_cb724dc5
	Namespace: namespace_31170709
	Checksum: 0xE92E4BB4
	Offset: 0x1B948
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function function_cb724dc5()
{
	level endon(#"end_game");
	wait(2);
	var_5e0ce220 = function_153ee6c7(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771"));
	var_5adbb2f7 = function_153ee6c7(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6"));
	if(isdefined(var_5e0ce220) && isdefined(var_5adbb2f7))
	{
		var_5e0ce220 endon(#"disconnect");
		var_5adbb2f7 endon(#"disconnect");
		var_845efa03 = var_5e0ce220 namespace_891c9bac::function_8e0f4696(#"hash_66cea79656de98a3", undefined, undefined, undefined, undefined, 1);
		if(isdefined(var_845efa03) && var_845efa03)
		{
			var_845efa03 = 0;
			var_845efa03 = var_5e0ce220 namespace_891c9bac::function_a2bd5a0c(#"hash_62227711901aad2");
			if(isdefined(var_845efa03) && var_845efa03)
			{
				var_5adbb2f7 thread namespace_891c9bac::function_a2bd5a0c(#"hash_62226711901a91f");
			}
		}
	}
	else if(isdefined(var_5e0ce220))
	{
		var_5e0ce220 endon(#"disconnect");
		var_845efa03 = var_5e0ce220 namespace_891c9bac::function_8e0f4696(#"hash_72f5967a35325ac3", undefined, undefined, undefined, undefined, 1);
		if(isdefined(var_845efa03) && var_845efa03)
		{
			var_5e0ce220 thread namespace_891c9bac::function_a2bd5a0c(#"hash_3e5825fcf6f95472");
		}
	}
	else if(isdefined(var_5adbb2f7))
	{
		var_5adbb2f7 endon(#"disconnect");
		var_845efa03 = var_5adbb2f7 namespace_891c9bac::function_a2bd5a0c(#"hash_552391bd4f9ce741");
		if(isdefined(var_845efa03) && var_845efa03)
		{
			var_5adbb2f7 thread namespace_891c9bac::function_8e0f4696(#"hash_1b221d6248a53127", undefined, undefined, undefined, undefined, 1);
		}
	}
}

/*
	Name: function_dcc3c705
	Namespace: namespace_31170709
	Checksum: 0x8CCB32D5
	Offset: 0x1BBF0
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_dcc3c705()
{
	self notify("3c63cddddcc253bf");
	self endon("3c63cddddcc253bf");
	level endon(#"end_game", #"hash_3af8b167d222aed5");
	self endon(#"disconnect");
	if(!self namespace_48f3568::function_69e9e553(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771")))
	{
		return;
	}
	if(!isdefined(level.var_3dd1c71a))
	{
		level.var_3dd1c71a = 0;
	}
	while(level.var_3dd1c71a < 3)
	{
		self waittill(#"hash_ed377b19afa69d2");
		switch(level.var_3dd1c71a)
		{
			case 0:
			{
				self thread namespace_891c9bac::function_8e0f4696(#"hash_189f560c95cb6d61", undefined, undefined, undefined, undefined, 1);
				break;
			}
			case 2:
			{
				self thread namespace_891c9bac::function_8e0f4696(#"hash_dcc0683b777af3", undefined, undefined, undefined, undefined, 1);
				break;
			}
		}
		level.var_3dd1c71a++;
	}
}

/*
	Name: function_c4f4035e
	Namespace: namespace_31170709
	Checksum: 0x6B15FC52
	Offset: 0x1BD90
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_c4f4035e()
{
	var_21692d94 = spawnstruct();
	level.var_29e8cce2 = var_21692d94;
	if(zm_utility::function_e51dc2d8())
	{
		level scene::add_scene_func(#"hash_66e518746652c89f", &function_db9be550);
		level thread scene::init(#"hash_66e518746652c89f");
	}
}

/*
	Name: function_db9be550
	Namespace: namespace_31170709
	Checksum: 0x6F8AE7E9
	Offset: 0x1BE30
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_db9be550(a_ents)
{
	var_21692d94 = level.var_29e8cce2;
	if(isdefined(var_21692d94))
	{
		var_21692d94.var_19a09d0c = a_ents[#"hash_7aff0ee60ddd937b"];
		level scene::remove_scene_func(#"hash_66e518746652c89f", &function_db9be550);
	}
}

/*
	Name: function_d2ab893e
	Namespace: namespace_31170709
	Checksum: 0xFBE3DE7C
	Offset: 0x1BEB8
	Size: 0x3CC
	Parameters: 1
	Flags: Linked
*/
function function_d2ab893e(var_77104def)
{
	level endon(#"end_game", #"cleanse" + "_ended_early");
	var_eb3b90d = struct::get_array(#"hash_39c4d9c02205984c");
	foreach(s_spawn in var_eb3b90d)
	{
		if(isdefined(s_spawn.var_8448183f) && s_spawn.var_8448183f && isdefined(s_spawn.script_noteworthy))
		{
			switch(s_spawn.script_noteworthy)
			{
				default:
				{
					var_ed0e316b = #"hash_18cccc85670ce70e";
					break;
				}
				case "gegenees_location":
				{
					var_ed0e316b = #"hash_6c2f8e1ec515638";
					break;
				}
				case "blight_father_location":
				{
					var_ed0e316b = #"hash_37ed662e10c50b79";
					break;
				}
			}
			s_move = struct::get(var_ed0e316b);
			s_spawn.origin = s_move.origin;
			s_spawn.angles = s_move.angles;
			s_move struct::delete();
		}
	}
	level scene::play(#"hash_66e518746652c89f", "Shot 1");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	level thread function_f2fa1520();
	level thread function_482dc5ac();
	var_e63a207 = struct::get(#"hash_7a21f9a230f88631");
	var_740e1e0e = util::spawn_model(var_e63a207.model, var_e63a207.origin, var_e63a207.angles);
	var_db8ec3ee = util::spawn_model(#"tag_origin", var_e63a207.origin);
	var_db8ec3ee clientfield::set("" + #"hash_297c800c6e18f746", 1);
	var_db8ec3ee playloopsound(#"hash_6f30c390503d064f");
	var_21692d94 = level.var_29e8cce2;
	var_21692d94.var_740e1e0e = var_740e1e0e;
	var_21692d94.var_db8ec3ee = var_db8ec3ee;
	var_21692d94.var_8121ef9f = level.var_b3b0d9d7;
	level.var_b3b0d9d7 = &function_cecc7973;
	level waittill(#"hash_6a4f03503cfcfac4");
}

/*
	Name: function_8dc89390
	Namespace: namespace_31170709
	Checksum: 0xD6756127
	Offset: 0x1C290
	Size: 0x796
	Parameters: 2
	Flags: Linked
*/
function function_8dc89390(var_77104def, var_19e802fa)
{
	var_21692d94 = level.var_29e8cce2;
	var_740e1e0e = var_21692d94.var_740e1e0e;
	if(isdefined(var_740e1e0e))
	{
		var_740e1e0e delete();
	}
	var_db8ec3ee = var_21692d94.var_db8ec3ee;
	if(isdefined(var_db8ec3ee))
	{
		var_db8ec3ee clientfield::set("" + #"hash_297c800c6e18f746", 0);
		var_db8ec3ee thread util::delayed_delete(1);
	}
	var_19a09d0c = var_21692d94.var_19a09d0c;
	if(!var_77104def && !var_19e802fa)
	{
		var_21692d94.var_5b7cf289 = 1;
		callback::on_connect(&function_7b4b880f);
		array::thread_all(getplayers(), &function_7b4b880f);
		level thread function_1f6e4a6d();
		var_783eaf1a = struct::get(#"hash_6e87a80cd6f532b3");
		var_1f514a0c = util::spawn_model(var_783eaf1a.model, var_783eaf1a.origin, var_783eaf1a.angles);
		var_783eaf1a struct::delete();
		var_1f514a0c zm_utility::create_zombie_point_of_interest(undefined, 16, 10000);
		var_1f514a0c zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 400, 1);
		var_1f514a0c util::delay(float(function_60d95f53()) / 1000, undefined, &clientfield::set, "" + #"hash_1187b848bf7868c5", 1);
		wait(1);
		foreach(e_player in getplayers())
		{
			e_player playsoundtoplayer(#"hash_737ff3246a85fd0e", e_player);
		}
		wait(2);
		s_scene = struct::get(#"hash_1dda242c988113ce");
		level scene::add_scene_func(s_scene.scriptbundlename, &function_67e537fd);
		s_scene thread scene::play();
		while(!isdefined(var_21692d94.var_10d4f67d))
		{
			waitframe(1);
		}
		var_10d4f67d = var_21692d94.var_10d4f67d;
		mdl_fx = util::spawn_model(#"tag_origin", var_10d4f67d.origin, var_10d4f67d.angles);
		mdl_fx clientfield::set("" + #"hash_5e74ad0afcfe7364", 1);
		wait(2);
		var_10d4f67d clientfield::set("" + #"hash_26ddf1f70bd1f67a", 1);
		wait(0.1);
		var_19a09d0c playrumbleonentity(#"hash_22cb25543ecfd0bf");
		wait(3);
	}
	var_19a09d0c playrumbleonentity(#"hash_32ed6d5a446f6a3a");
	level scene::play(#"hash_66e518746652c89f", "Shot 2");
	if(!var_77104def && !var_19e802fa)
	{
		var_10d4f67d clientfield::set("" + #"hash_26ddf1f70bd1f67a", 0);
		wait(2);
		foreach(e_player in getplayers())
		{
			e_player playsoundtoplayer(#"hash_737ff3246a85fd0e", e_player);
		}
		wait(1);
		s_scene scene::play(s_scene.scriptbundlename, "end");
		mdl_fx clientfield::set("" + #"hash_5e74ad0afcfe7364", 0);
		mdl_fx thread util::delayed_delete(1);
		var_10d4f67d delete();
		var_1f514a0c delete();
		var_21692d94.var_5b7cf289 = 0;
		level notify(#"hash_3970f4ab245a1853");
		var_49d60273 = getweapon(#"hash_27e4878539bc7f72");
		foreach(e_player in getplayers())
		{
			if(isdefined(e_player.var_69c1f71b) && e_player.var_69c1f71b)
			{
				e_player ability_util::function_1a38f0b0(var_49d60273);
			}
		}
	}
	var_9520d62 = var_21692d94.var_8121ef9f;
	if(isdefined(var_9520d62))
	{
		level.var_b3b0d9d7 = var_9520d62;
	}
}

/*
	Name: function_f2fa1520
	Namespace: namespace_31170709
	Checksum: 0x2FAB030C
	Offset: 0x1CA30
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_f2fa1520()
{
	level endon(#"end_game", #"cleanse" + "_ended_early", #"hash_6a4f03503cfcfac4");
	wait(20);
	a_e_players = util::get_active_players();
	a_e_players = array::randomize(a_e_players);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
		{
			var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_1ea1fc078a770c47");
			break;
		}
	}
	if(isdefined(var_845efa03) && var_845efa03)
	{
		level thread function_7b345f6d(#"hash_792896baba5747bf");
	}
}

/*
	Name: function_482dc5ac
	Namespace: namespace_31170709
	Checksum: 0x976120EA
	Offset: 0x1CBB0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_482dc5ac()
{
	level endon(#"end_game", #"cleanse" + "_ended_early", #"hash_6a4f03503cfcfac4");
	s_target = struct::get(#"hash_5c0ec58a74f10a88");
	v_target = s_target.origin;
	s_target struct::delete();
	while(true)
	{
		foreach(e_player in util::get_active_players())
		{
			if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a() && e_player zm_utility::is_player_looking_at(v_target))
			{
				n_dist = distance2dsquared(e_player.origin, v_target);
				if(n_dist <= 512 * 512)
				{
					e_player thread zm_audio::create_and_play_dialog(#"ballista", #"rises");
					return;
				}
			}
		}
		wait(2);
	}
}

/*
	Name: function_1f6e4a6d
	Namespace: namespace_31170709
	Checksum: 0x77529622
	Offset: 0x1CD98
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_1f6e4a6d()
{
	level endon(#"end_game");
	wait(1);
	var_21692d94 = level.var_29e8cce2;
	e_player = var_21692d94.var_e935dae1;
	if(zm_utility::is_player_valid(e_player))
	{
		e_player thread zm_audio::create_and_play_dialog(#"pegasus", #"summon");
	}
}

/*
	Name: function_cecc7973
	Namespace: namespace_31170709
	Checksum: 0xEE3ACCC6
	Offset: 0x1CE38
	Size: 0x172
	Parameters: 2
	Flags: Linked
*/
function function_cecc7973(e_grenade, e_player)
{
	var_21692d94 = level.var_29e8cce2;
	if(isdefined(var_21692d94) && (isdefined(var_21692d94.var_5b7cf289) && var_21692d94.var_5b7cf289))
	{
		if(isdefined(e_grenade))
		{
			e_grenade.origin = e_grenade.origin - (0, 0, 2048);
		}
		return 0;
	}
	if(isdefined(e_player))
	{
		var_21692d94 = level.var_29e8cce2;
		var_740e1e0e = var_21692d94.var_740e1e0e;
		if(isdefined(var_21692d94) && isdefined(var_740e1e0e))
		{
			n_dist = distance2dsquared(e_player.origin, var_740e1e0e.origin);
			if(n_dist <= 64 * 64)
			{
				var_21692d94.var_e935dae1 = e_player;
				level notify(#"hash_6a4f03503cfcfac4");
				if(isdefined(e_grenade))
				{
					e_grenade.origin = e_grenade.origin - (0, 0, 2048);
				}
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_7b4b880f
	Namespace: namespace_31170709
	Checksum: 0x22E43DD
	Offset: 0x1CFB8
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function function_7b4b880f()
{
	self notify("3800075c6875cab1");
	self endon("3800075c6875cab1");
	level endon(#"end_game", #"hash_3970f4ab245a1853");
	self endon(#"disconnect");
	var_49d60273 = getweapon(#"hash_27e4878539bc7f72");
	while(true)
	{
		while(true)
		{
			var_291db748 = self._gadgets_player;
			if(isdefined(var_291db748) && isinarray(var_291db748, var_49d60273))
			{
				break;
			}
			waitframe(1);
		}
		self ability_util::function_e8aa75b8(var_49d60273);
		self.var_69c1f71b = 1;
		while(true)
		{
			var_291db748 = self._gadgets_player;
			if(isdefined(var_291db748) && !isinarray(var_291db748, var_49d60273))
			{
				break;
			}
			waitframe(1);
		}
		self ability_util::function_1a38f0b0(var_49d60273);
		self.var_69c1f71b = 0;
	}
}

/*
	Name: function_67e537fd
	Namespace: namespace_31170709
	Checksum: 0xEB6B729D
	Offset: 0x1D130
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_67e537fd(a_ents)
{
	if(isdefined(self.targetname) && self.targetname != #"hash_1dda242c988113ce")
	{
		return;
	}
	var_21692d94 = level.var_29e8cce2;
	if(isdefined(var_21692d94))
	{
		var_21692d94.var_10d4f67d = a_ents[#"hash_7aff0ee60ddd937b"];
		level scene::remove_scene_func(self.scriptbundlename, &function_67e537fd);
	}
}

/*
	Name: function_5e84e8f9
	Namespace: namespace_31170709
	Checksum: 0xCEE9DB13
	Offset: 0x1D1D8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_5e84e8f9(var_77104def)
{
	level endon(#"end_game", #"hash_1f875aef67e9ade4" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	function_4109a3a1();
}

/*
	Name: function_8000f525
	Namespace: namespace_31170709
	Checksum: 0x5BF067EC
	Offset: 0x1D240
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_8000f525(var_77104def, var_19e802fa)
{
	callback::remove_on_connect(&function_a2147cf);
	level notify(#"hash_4d110cc2383265e3");
	if(var_77104def || var_19e802fa)
	{
		level scene::play(#"hash_66e518746652c89f", "Shot 6");
	}
}

/*
	Name: function_4109a3a1
	Namespace: namespace_31170709
	Checksum: 0x26692B36
	Offset: 0x1D2D0
	Size: 0x19E
	Parameters: 0
	Flags: Linked
*/
function function_4109a3a1()
{
	level endon(#"end_game", #"hash_1f875aef67e9ade4" + "_ended_early");
	callback::on_connect(&function_a2147cf);
	level thread function_95210026();
	for(i = 0; i < 4; i++)
	{
		array::thread_all(getplayers(), &function_a2147cf);
		level waittill(#"hash_4d110cc2383265e3");
		switch(i)
		{
			case 0:
			{
				str_shot = "Shot 3";
				break;
			}
			case 1:
			{
				str_shot = "Shot 4";
				break;
			}
			case 2:
			{
				str_shot = "Shot 5";
				break;
			}
			case 3:
			{
				str_shot = "Shot 6";
				break;
			}
		}
		level scene::play(#"hash_66e518746652c89f", str_shot);
	}
}

/*
	Name: function_95210026
	Namespace: namespace_31170709
	Checksum: 0xEF47647B
	Offset: 0x1D478
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_95210026()
{
	level endon(#"end_game", #"hash_1f875aef67e9ade4" + "_ended_early", #"hash_4d110cc2383265e3");
	wait(1);
	var_21692d94 = level.var_29e8cce2;
	var_19a09d0c = var_21692d94.var_19a09d0c;
	a_e_players = util::get_active_players();
	a_e_players = arraysortclosest(a_e_players, var_19a09d0c.origin, undefined, 0, 512);
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player) && e_player zm_audio::function_65e5c19a())
		{
			e_player thread zm_audio::create_and_play_dialog(#"ballista", #"stuck");
			break;
		}
	}
}

/*
	Name: function_a2147cf
	Namespace: namespace_31170709
	Checksum: 0x3BF979C8
	Offset: 0x1D610
	Size: 0x2A6
	Parameters: 0
	Flags: Linked
*/
function function_a2147cf()
{
	self notify("3313d94ce5b7d5e");
	self endon("3313d94ce5b7d5e");
	level endon(#"end_game", #"hash_1f875aef67e9ade4" + "_ended_early", #"hash_4d110cc2383265e3");
	self endon(#"disconnect");
	var_21692d94 = level.var_29e8cce2;
	var_19a09d0c = var_21692d94.var_19a09d0c;
	while(true)
	{
		var_afb3c2b3 = 0;
		while(!self function_9bd33cca())
		{
			waitframe(1);
		}
		var_bca7143f = 0;
		while(self function_9bd33cca())
		{
			var_62b177c = var_19a09d0c gettagorigin("mid_moss_01_jnt");
			n_dist = distance2dsquared(self.origin, var_62b177c);
			var_5168e40f = self zm_utility::is_player_looking_at(var_62b177c, 0.7, 0);
			var_f62556c4 = var_19a09d0c math::get_dot_right(self.origin) > 0;
			var_6a0e3c64 = n_dist <= 512 * 512 && var_5168e40f && var_f62556c4;
			if(var_6a0e3c64)
			{
				n_start_time = gettime();
			}
			else
			{
				var_afb3c2b3 = 0;
			}
			waitframe(1);
			if(var_6a0e3c64)
			{
				n_current_time = gettime();
				n_time_passed = float(n_current_time - n_start_time) / 1000;
				var_afb3c2b3 = var_afb3c2b3 + n_time_passed;
				if(var_afb3c2b3 >= 1)
				{
					var_bca7143f = 1;
					break;
				}
			}
		}
		if(var_bca7143f)
		{
			level notify(#"hash_4d110cc2383265e3");
			return;
		}
	}
}

/*
	Name: function_9bd33cca
	Namespace: namespace_31170709
	Checksum: 0x90CA7C6
	Offset: 0x1D8C0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_9bd33cca()
{
	w_current = self getcurrentweapon();
	return zm_utility::is_player_valid(self) && self attackbuttonpressed() && is_wonder_weapon(w_current, #"air", 0) && self.chargeshotlevel === 2 && self getweaponammoclip(w_current);
}

/*
	Name: function_2f9d2650
	Namespace: namespace_31170709
	Checksum: 0xAF10EAB7
	Offset: 0x1D978
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_2f9d2650(var_77104def)
{
	level endon(#"end_game", #"hash_d861e03ebf38f96" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	a_e_players = getplayers();
	callback::on_connect(&function_2b23b087);
	array::thread_all(a_e_players, &function_2b23b087);
	level thread function_995ff495();
	level waittill(#"hash_659f3fc9efbd4620");
}

/*
	Name: function_358b40ed
	Namespace: namespace_31170709
	Checksum: 0xBD14EE10
	Offset: 0x1DA58
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function function_358b40ed(var_77104def, var_19e802fa)
{
	callback::remove_on_connect(&function_2b23b087);
	array::notify_all(getplayers(), #"hash_659f3fc9efbd4620");
	var_182674af = struct::get(#"hash_dfe5ea1e5b36d65");
	var_ef24f2e7 = struct::get(#"hash_3e111145a5afc255");
	var_182674af struct::delete();
	var_ef24f2e7 struct::delete();
	var_21692d94 = level.var_29e8cce2;
	var_19a09d0c = var_21692d94.var_19a09d0c;
	var_19a09d0c clientfield::increment("" + #"hash_508fc6409c815104");
	wait(2);
	level thread scene::play(#"hash_66e518746652c89f", "Shot 7");
	level scene::play(#"hash_4703db4679985a0a");
	level namespace_6747c550::function_7df6bb60(#"hash_566a6ec283e2360a", 7);
	playsoundatposition(#"hash_489109cc61ab6258", (0, 0, 0));
	level clientfield::set("" + #"hash_51e28147388ee3d8", 0);
	exploder::stop_exploder("fxexp_barrier_egg_hit");
}

/*
	Name: function_2b23b087
	Namespace: namespace_31170709
	Checksum: 0x402F9F30
	Offset: 0x1DC90
	Size: 0x256
	Parameters: 0
	Flags: Linked
*/
function function_2b23b087()
{
	self notify("3bd01db8602ba8a7");
	self endon("3bd01db8602ba8a7");
	level endon(#"end_game", #"hash_d861e03ebf38f96" + "_ended_early", #"hash_659f3fc9efbd4620");
	self endon(#"disconnect");
	var_182674af = struct::get(#"hash_dfe5ea1e5b36d65");
	var_ef24f2e7 = struct::get(#"hash_3e111145a5afc255");
	var_cfaa1cf5 = var_182674af.origin;
	var_27128cf9 = var_ef24f2e7.origin;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_melee_power", #"weapon_melee");
		w_weapon = var_be17187b.weapon;
		if(zm_utility::is_player_valid(self) && isdefined(w_weapon) && (isdefined(w_weapon.isriotshield) && w_weapon.isriotshield) && (isdefined(self.var_b0cde18d) && self.var_b0cde18d))
		{
			n_dist = distance2dsquared(self.origin, var_27128cf9);
			if(n_dist <= 64 * 64)
			{
				var_39b20ef6 = self zm_utility::is_player_looking_at(var_cfaa1cf5, 0.9, 0);
				if(var_39b20ef6)
				{
					var_21692d94 = level.var_29e8cce2;
					var_21692d94.var_fabe5be7 = self;
					level notify(#"hash_659f3fc9efbd4620");
					return;
				}
			}
		}
	}
}

/*
	Name: function_995ff495
	Namespace: namespace_31170709
	Checksum: 0x7F49254B
	Offset: 0x1DEF0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_995ff495()
{
	level endon(#"end_game", #"hash_d861e03ebf38f96" + "_ended_early");
	wait(1);
	foreach(e_player in util::get_active_players())
	{
		if(zm_utility::is_player_valid(e_player) && e_player function_3d581a6(#"air", 0))
		{
			e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_6838bb9002545093");
			break;
		}
	}
}

/*
	Name: function_22165535
	Namespace: namespace_31170709
	Checksum: 0x386D574
	Offset: 0x1E008
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function function_22165535(var_77104def)
{
	level endon(#"end_game", #"teleport" + "_ended_early");
	/#
		if(var_77104def)
		{
			return;
		}
	#/
	level thread function_c54d30d5();
	while(true)
	{
		var_eb75c56d = 0;
		foreach(e_player in util::get_active_players())
		{
			str_zone = e_player zm_utility::get_current_zone();
			if(str_zone === "zone_drakaina_arena")
			{
				var_eb75c56d = 1;
				break;
			}
		}
		if(var_eb75c56d)
		{
			break;
		}
		wait(1);
	}
	level thread function_d67d9a14();
	s_unitrigger = struct::get(#"hash_5112e768ad998b70");
	s_unitrigger zm_unitrigger::create(&function_72004612);
	var_21692d94 = level.var_29e8cce2;
	level thread scene::init_streamer(#"hash_be0d30822a1c21b", #"allies");
	while(true)
	{
		s_unitrigger waittill(#"trigger_activated");
		if(isdefined(var_21692d94.var_6b2fb7d6) && var_21692d94.var_6b2fb7d6)
		{
			break;
		}
	}
}

/*
	Name: function_9f8fe5ae
	Namespace: namespace_31170709
	Checksum: 0x8F73A6B5
	Offset: 0x1E230
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_9f8fe5ae(var_77104def, var_19e802fa)
{
	level notify(#"hash_3af8b167d222aed5");
	level flag::set(#"hash_5a7f1f9adac6dc8c");
	callback::remove_on_connect(&function_dcc3c705);
	s_unitrigger = struct::get(#"hash_5112e768ad998b70");
	if(isdefined(s_unitrigger.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(s_unitrigger.s_unitrigger);
		s_unitrigger.s_unitrigger = undefined;
	}
	s_unitrigger struct::delete();
	level.var_29e8cce2 struct::delete();
	level thread namespace_765d6379::function_3a2efd4e(0);
}

/*
	Name: function_c54d30d5
	Namespace: namespace_31170709
	Checksum: 0x3FA0C9BA
	Offset: 0x1E350
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_c54d30d5()
{
	level endon(#"end_game");
	wait(1);
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	waitframe(1);
	var_21692d94 = level.var_29e8cce2;
	e_player = var_21692d94.var_fabe5be7;
	if(zm_utility::is_player_valid(e_player))
	{
		e_player namespace_891c9bac::function_a2bd5a0c(#"hash_3280eb0abc8ec3ed");
	}
	level zm_audio::sndvoxoverride(0);
	level flag::wait_till(#"hash_f38b18eaf7b063b");
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level zm_audio::sndvoxoverride(1);
	waitframe(1);
	function_7b345f6d(#"hash_50daf567c473d26d");
	level zm_audio::sndvoxoverride(0);
}

/*
	Name: function_d67d9a14
	Namespace: namespace_31170709
	Checksum: 0x199F2EE8
	Offset: 0x1E4D0
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_d67d9a14()
{
	level endon(#"end_game", #"hash_3af8b167d222aed5");
	level flag::set(#"hash_f38b18eaf7b063b");
	level clientfield::set("" + #"hash_16e27bea0cc1b56b", 0);
	level clientfield::set("" + #"hash_7525e43acf9ca679", 1);
	level thread scene::play(#"hash_1df842b1fb8e6e4a");
	wait(0.25);
	level clientfield::set("" + #"hash_1c97c11fb59eb4bf", 2);
	level thread function_e8e36e67();
}

/*
	Name: function_e8e36e67
	Namespace: namespace_31170709
	Checksum: 0x979A22B1
	Offset: 0x1E608
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_e8e36e67()
{
	level endon(#"end_game");
	level flag::wait_till(#"hash_5a7f1f9adac6dc8c");
	level clientfield::set("" + #"hash_7525e43acf9ca679", 0);
	level clientfield::set("" + #"hash_51858e923e750c33", 0);
	level clientfield::set("" + #"hash_2b05d4c6217bac22", 0);
	level clientfield::set("" + #"hash_3836d3a94cf05642", 0);
	level clientfield::set("" + #"hash_53e684a319647b40", 0);
	level clientfield::set("" + #"hash_70e157c389c1c02f", 0);
	level clientfield::set("" + #"hash_4f59799617fef9c7", 0);
	level clientfield::set("" + #"hash_31a10d565ae05ddb", 0);
	level clientfield::set("" + #"hash_1c97c11fb59eb4bf", 0);
}

/*
	Name: function_72004612
	Namespace: namespace_31170709
	Checksum: 0x2874CE33
	Offset: 0x1E800
	Size: 0x1CE
	Parameters: 1
	Flags: Linked
*/
function function_72004612(e_player)
{
	s_teleport = struct::get(#"hash_5112e768ad998b70");
	var_5faaf34c = s_teleport.origin;
	b_ready = 1;
	foreach(var_cd411384 in util::get_active_players())
	{
		n_dist = distance2dsquared(var_cd411384.origin, var_5faaf34c);
		if(n_dist > 128 * 128)
		{
			b_ready = 0;
			break;
		}
	}
	if(b_ready)
	{
		str_prompt = zm_utility::function_d6046228(#"hash_cb9ec6ff4ccecb8", #"hash_2bbe0121500d0f4");
		self sethintstringforplayer(e_player, str_prompt);
	}
	else
	{
		self sethintstringforplayer(e_player, #"hash_45fd3f34a60262a3");
	}
	var_21692d94 = level.var_29e8cce2;
	var_21692d94.var_6b2fb7d6 = b_ready;
	return 1;
}

/*
	Name: function_7b345f6d
	Namespace: namespace_31170709
	Checksum: 0x54D204CD
	Offset: 0x1E9D8
	Size: 0x226
	Parameters: 1
	Flags: Linked
*/
function function_7b345f6d(str_alias)
{
	var_3562ed6 = [];
	foreach(e_player in getplayers())
	{
		if(e_player zm_audio::function_65e5c19a(1) && (!(isdefined(e_player.isspeaking) && e_player.isspeaking)) && (!(isdefined(e_player.var_5b6ebfd0) && e_player.var_5b6ebfd0)))
		{
			if(!isdefined(var_3562ed6))
			{
				var_3562ed6 = [];
			}
			else if(!isarray(var_3562ed6))
			{
				var_3562ed6 = array(var_3562ed6);
			}
			var_3562ed6[var_3562ed6.size] = e_player;
		}
	}
	if(var_3562ed6.size == 0)
	{
		return 0;
	}
	foreach(i, e_player in var_3562ed6)
	{
		var_dc5f4a1c = i + 1 == var_3562ed6.size;
		if(!var_dc5f4a1c)
		{
			e_player thread namespace_891c9bac::function_8e0f4696(str_alias, undefined, undefined, undefined, 1);
			continue;
		}
		var_845efa03 = e_player namespace_891c9bac::function_8e0f4696(str_alias, undefined, undefined, undefined, 1);
	}
	return var_845efa03;
}

/*
	Name: function_6f55d670
	Namespace: namespace_31170709
	Checksum: 0x606449C0
	Offset: 0x1EC08
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_6f55d670(var_a276c861)
{
	level waittill(#"hash_2e0f22819e845463");
}

/*
	Name: function_13c87ace
	Namespace: namespace_31170709
	Checksum: 0x37F1D5C5
	Offset: 0x1EC38
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_13c87ace(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_e6ce9708
	Namespace: namespace_31170709
	Checksum: 0xF3ED1D9
	Offset: 0x1EC58
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_e6ce9708(var_a276c861)
{
	level flag::set(#"hash_38ace2856b88126");
	mdl_door = getent("portico_model", "targetname");
	mdl_door rotateyaw(129, 1.6);
	var_3400a741 = getentarray("portico_clip", "targetname");
	array::run_all(var_3400a741, &delete);
	level clientfield::set("" + #"hash_5474fbb93aebbb65", 1);
}

/*
	Name: function_4f6285d0
	Namespace: namespace_31170709
	Checksum: 0x7F52E25E
	Offset: 0x1ED58
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_4f6285d0(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_69e1a1fc
	Namespace: namespace_31170709
	Checksum: 0xCA5D2BBD
	Offset: 0x1ED78
	Size: 0x3B4
	Parameters: 0
	Flags: None
*/
function function_69e1a1fc()
{
	/#
		level flag::wait_till("");
		if(!isdefined(level.var_9d581f96))
		{
			level.var_9d581f96 = 0;
		}
		if(!level.var_9d581f96)
		{
			level.var_9d581f96 = 1;
			level clientfield::set("" + #"hash_51858e923e750c33", 2);
			level clientfield::set("" + #"hash_2b05d4c6217bac22", 2);
			level clientfield::set("" + #"hash_3836d3a94cf05642", 2);
			level clientfield::set("" + #"hash_53e684a319647b40", 2);
			level clientfield::set("" + #"hash_70e157c389c1c02f", 1);
			level clientfield::set("" + #"hash_4f59799617fef9c7", 1);
			level clientfield::set("" + #"hash_31a10d565ae05ddb", 2);
			level clientfield::set("" + #"hash_1c97c11fb59eb4bf", 1);
		}
		else
		{
			level.var_9d581f96 = 0;
			level clientfield::set("" + #"hash_51858e923e750c33", 0);
			level clientfield::set("" + #"hash_2b05d4c6217bac22", 0);
			level clientfield::set("" + #"hash_3836d3a94cf05642", 0);
			level clientfield::set("" + #"hash_53e684a319647b40", 0);
			level clientfield::set("" + #"hash_70e157c389c1c02f", 0);
			level clientfield::set("" + #"hash_4f59799617fef9c7", 0);
			level clientfield::set("" + #"hash_31a10d565ae05ddb", 0);
			level clientfield::set("" + #"hash_1c97c11fb59eb4bf", 0);
		}
	#/
}

/*
	Name: function_25bb4829
	Namespace: namespace_31170709
	Checksum: 0xA6C1360A
	Offset: 0x1F138
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function function_25bb4829(var_57c9944e)
{
	/#
		foreach(e_player in getplayers())
		{
			w_current = e_player getcurrentweapon();
			if(isdefined(w_current.isriotshield) && w_current.isriotshield)
			{
				if(!(isdefined(e_player.var_b4f85096) && e_player.var_b4f85096))
				{
					e_player thread function_fbc44c3e();
					if(var_57c9944e)
					{
						e_player notify(#"hash_cbf6a8f73a300c8");
					}
					continue;
				}
				e_player notify(#"hash_459246e5bfcc3713");
			}
		}
	#/
}

