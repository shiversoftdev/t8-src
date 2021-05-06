// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_135d37089bbde4f2;
#using script_20a30e3aaa7368c9;
#using script_2255a7ad3edc838f;
#using script_2c49ae69cd8ce30c;
#using script_2fe3a06d826114db;
#using script_490759cf62a1abc8;
#using script_61826ca279ffa0;
#using script_6fdaf2c63629994b;
#using script_788472602edbe3b9;
#using script_bb99a1f9be8d0a7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;

#namespace namespace_28cdc89f;

/*
	Name: main
	Namespace: namespace_28cdc89f
	Checksum: 0xF819B318
	Offset: 0x230
	Size: 0x28C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	level.select_character = namespace_73e1c3e3::function_d153452e(#"prt_mp_buffassault");
	level.var_820c5561 = "CRASH";
	namespace_73e1c3e3::function_be3a76b7(level.var_820c5561);
	level.var_d6d98fbe = 1;
	level.var_5e97302a = 0;
	namespace_13777bae::function_fa03fc55();
	level.var_4c2ecc6f = &function_6db6572b;
	level.var_c01b7f8b = &function_ba542258;
	level.var_49240db3 = &function_b89106ad;
	level.var_8b9d690e = &function_cf3224fe;
	level.onspawnplayer = &function_7c4ef26b;
	player::function_cf3aa03d(&function_9d65db70);
	level.var_cdb8ae2c = &namespace_73e1c3e3::function_a8da260c;
	level.resurrect_override_spawn = &namespace_73e1c3e3::function_78469779;
	level.var_e31c5d7a = &namespace_64a487a9::function_e31c5d7a;
	callback::function_98a0917d(&namespace_13777bae::function_1e84c767);
	globallogic_spawn::addsupportedspawnpointtype("ct");
	level flag::init("combat_training_started");
	namespace_73e1c3e3::function_6046a5e3(#"ar_fastfire_t8", array(#"ar_fastfire_t8", "elo", "fastreload", "fastreload2", "quickdraw", "quickdraw2"));
	namespace_73e1c3e3::function_c3e647e2(#"pistol_standard_t8");
	if(level.var_cd9d597c == 0)
	{
		level namespace_47ace5cf::init();
	}
}

/*
	Name: function_ee93e2d4
	Namespace: namespace_28cdc89f
	Checksum: 0x9AF35B38
	Offset: 0x4C8
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function function_ee93e2d4(weapon, var_e2959480)
{
	if(!(isdefined(self.revived) && self.revived))
	{
		var_a9b02eaa = 1;
		if(var_a9b02eaa)
		{
			self notify(#"player_input_revive");
			if(!(isdefined(self.var_6722b63) && self.var_6722b63))
			{
				var_e2959480 thread namespace_73e1c3e3::function_d471f8fa(10, undefined, 1);
				self.var_6722b63 = 1;
			}
			self.b_revived = 1;
			self.var_3c5a5d29 = 2;
			self.resurrect_not_allowed_by = undefined;
			self.var_9a79d89d = undefined;
			level thread function_bcf30399();
			level.var_cea5b696++;
		}
	}
}

/*
	Name: function_bcf30399
	Namespace: namespace_28cdc89f
	Checksum: 0xFE1B5006
	Offset: 0x5C0
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function function_bcf30399()
{
	level.var_3574b65f = 1;
	wait(7);
	level.var_3574b65f = 0;
}

/*
	Name: function_c5e29f2e
	Namespace: namespace_28cdc89f
	Checksum: 0xDF229D91
	Offset: 0x5F0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_c5e29f2e()
{
	self endon(#"death");
	self.resurrect_not_allowed_by = 1;
	namespace_64a487a9::function_e31c5d7a();
}

/*
	Name: function_7c4ef26b
	Namespace: namespace_28cdc89f
	Checksum: 0x18BA477D
	Offset: 0x638
	Size: 0xE0
	Parameters: 1
	Flags: None
*/
function function_7c4ef26b(predictedspawn)
{
	if(level.var_cd9d597c == 0)
	{
		self namespace_47ace5cf::function_c9ff0dce();
		return;
	}
	self thread namespace_13777bae::function_d2845186();
	spawning::onspawnplayer(predictedspawn);
	if(self.team == #"allies")
	{
		if(isdefined(level.var_f78f9034))
		{
			self thread function_6b37f8a5();
		}
	}
	if(isbot(self))
	{
		if(isdefined(level.var_e31c5d7a))
		{
			self [[level.var_e31c5d7a]]();
		}
	}
}

/*
	Name: function_9d65db70
	Namespace: namespace_28cdc89f
	Checksum: 0xC942BFC6
	Offset: 0x720
	Size: 0x174
	Parameters: 9
	Flags: None
*/
function function_9d65db70(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(level.var_cd9d597c == 0)
	{
		self namespace_47ace5cf::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		return;
	}
	if(self.team == #"allies")
	{
		if(!isbot(self))
		{
			self thread namespace_73e1c3e3::function_ee4639dd(-10);
		}
	}
	else if(isplayer(einflictor) && einflictor.team == #"allies")
	{
		einflictor thread namespace_73e1c3e3::function_d471f8fa(5, undefined, 1);
		if(isdefined(level.var_93f322c9) && level.var_93f322c9)
		{
			einflictor namespace_73e1c3e3::function_785eb2ca();
		}
	}
}

/*
	Name: function_6db6572b
	Namespace: namespace_28cdc89f
	Checksum: 0x9D50F09C
	Offset: 0x8A0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_6db6572b()
{
	level flag::init("mission_success");
	level flag::init("mission_failed");
	level flag::init("gamemode_started");
}

/*
	Name: function_ba542258
	Namespace: namespace_28cdc89f
	Checksum: 0xB2365A99
	Offset: 0x910
	Size: 0x154
	Parameters: 1
	Flags: None
*/
function function_ba542258(mode)
{
	level flag::clear("mission_success");
	level flag::clear("mission_failed");
	level flag::clear("gamemode_started");
	level clientfield::set("area_arrows_specialist", 2);
	level.var_88024dd9 = 0;
	if(isdefined(level.var_1ecfe3a2))
	{
		self.var_71a70093 = level.var_1ecfe3a2;
	}
	self thread namespace_d82263d5::function_19181566();
	var_61ca8276 = 420000;
	self function_9270ab93(0, var_61ca8276);
	self loadout::function_cdb86a18();
	if(level.var_cd9d597c != 0)
	{
		level flag::wait_till("bot_init_complete");
		self thread function_587088a0();
	}
}

/*
	Name: function_9270ab93
	Namespace: namespace_28cdc89f
	Checksum: 0xF6D88844
	Offset: 0xA70
	Size: 0x284
	Parameters: 2
	Flags: None
*/
function function_9270ab93(var_db89c655, var_27875ecd)
{
	var_e7cc5e43 = [];
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][1] = 240000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][2] = 180000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][3] = 120000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][1] = 240000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][2] = 180000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][3] = 120000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][1] = 240000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][2] = 180000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][3] = 120000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][1] = 240000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][2] = 180000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][3] = 120000;
	var_e7cc5e43[#"mp_gridlock"][1] = 240000;
	var_e7cc5e43[#"mp_gridlock"][2] = 180000;
	var_e7cc5e43[#"mp_gridlock"][3] = 120000;
	var_b1cb18f1 = hash(getrootmapname());
	namespace_73e1c3e3::function_7a21ac57(var_db89c655, var_27875ecd, var_e7cc5e43[var_b1cb18f1][1], var_e7cc5e43[var_b1cb18f1][2], var_e7cc5e43[var_b1cb18f1][3]);
}

/*
	Name: function_b89106ad
	Namespace: namespace_28cdc89f
	Checksum: 0xC7E84281
	Offset: 0xD00
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function function_b89106ad(gamedifficulty)
{
	level endon(#"combattraining_logic_finished");
	level flag::set("gamemode_started");
	level.var_ebad4ea8 = gettime();
	level notify(#"hash_2a473e02881ca991");
	level.usingscorestreaks = 0;
	level.var_64ce2685 = 1;
	level.disablemomentum = 1;
	if(gamedifficulty == 0)
	{
		namespace_47ace5cf::function_9b9525e9();
	}
	else
	{
		function_72e84e64();
	}
	level notify(#"combattraining_logic_finished", {#success:1});
}

/*
	Name: function_cf3224fe
	Namespace: namespace_28cdc89f
	Checksum: 0x41057791
	Offset: 0xDF8
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_cf3224fe(b_success)
{
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	level notify(#"hash_2459a7f38b7c48c2");
	level.var_e95a926f = 0;
	var_cd803a6b = gettime() - level.var_ebad4ea8;
	return var_cd803a6b;
}

/*
	Name: function_72e84e64
	Namespace: namespace_28cdc89f
	Checksum: 0x639838B5
	Offset: 0xE80
	Size: 0x27E
	Parameters: 0
	Flags: None
*/
function function_72e84e64()
{
	level endon(#"combattraining_logic_finished");
	level thread function_e424e334();
	level thread namespace_64a487a9::function_4d9cfd95(8, #"axis");
	level thread function_836b3d02();
	level thread function_e60bbaf4();
	level thread function_807d5645();
	var_806acf86 = int(gettime() + 1000 + int(420 * 1000));
	setmatchflag("bomb_timer_a", 1);
	setbombtimer("A", var_806acf86);
	while(true)
	{
		if(isdefined(level.var_e6db911d) && level.var_e6db911d)
		{
			e_player = getplayers()[0];
			var_1411e20e = e_player namespace_64a487a9::function_dde6edbd();
			if(var_1411e20e.size == 0)
			{
				level flag::set("mission_success");
				break;
			}
		}
		if(level flag::get("mission_failed"))
		{
			break;
		}
		var_f08fde43 = function_4c27be22("A");
		currenttime = gettime();
		if(currenttime > var_f08fde43)
		{
			level flag::set("mission_failed");
			break;
		}
		waitframe(1);
	}
	if(isdefined(level.var_f78f9034))
	{
		level.var_f78f9034 gameobjects::set_visible_team("none");
		level.var_f78f9034 = undefined;
	}
}

/*
	Name: function_587088a0
	Namespace: namespace_28cdc89f
	Checksum: 0xB833624
	Offset: 0x1108
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function function_587088a0()
{
	var_1411e20e = getplayers(#"axis");
	foreach(bot in var_1411e20e)
	{
		bot clientfield::set("set_vip", 1);
	}
	level.var_1102e61 = struct::get_array("s_human_captive", "targetname");
	if(level.var_1102e61.size > 0)
	{
		level.var_9e8e503f = level.var_1102e61.size;
		function_7bc70c24(level.var_9e8e503f);
		self namespace_73e1c3e3::function_68e9fa9e(undefined, 0, level.var_9e8e503f, 1, 1);
		self thread function_5f17f29();
	}
}

/*
	Name: function_7bc70c24
	Namespace: namespace_28cdc89f
	Checksum: 0x36352042
	Offset: 0x1270
	Size: 0x2A8
	Parameters: 1
	Flags: None
*/
function function_7bc70c24(var_a1b34e6f)
{
	entities = bot::get_bots();
	level.var_1102e61 = struct::get_array("s_human_captive", "targetname");
	var_e8d6f89 = 0;
	foreach(entity in entities)
	{
		if(!isdefined(entity.bot))
		{
			continue;
		}
		if(isdefined(entity.isinuse) && entity.isinuse)
		{
			continue;
		}
		entity.var_9a79d89d = level.var_1102e61[var_e8d6f89].origin;
		entity.var_5ab7c19c = level.var_1102e61[var_e8d6f89].angles;
		entity namespace_64a487a9::function_3895c193("allies");
		entity clientfield::set("set_vip", 2);
		entity.var_57f1bd45 = level.var_1102e61[var_e8d6f89];
		entity.var_d6c52b74 = 1;
		entity namespace_64a487a9::function_26d45f32();
		entity.var_ef59b90 = 5;
		entity.resurrect_not_allowed_by = undefined;
		entity setorigin(entity.var_9a79d89d);
		entity setplayerangles(entity.var_5ab7c19c);
		entity.disablespawning = 1;
		entity.var_6722b63 = 0;
		entity.b_revived = 0;
		entity show();
		entity bot::function_678e7c0(level.var_6e246fb7);
		entity.var_81c43c = level.var_6e246fb7;
		var_e8d6f89++;
		if(var_e8d6f89 >= var_a1b34e6f)
		{
			break;
		}
		waitframe(1);
	}
	level notify(#"hash_5de15de451493f4a");
}

/*
	Name: function_807d5645
	Namespace: namespace_28cdc89f
	Checksum: 0xB4718DB2
	Offset: 0x1520
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_807d5645()
{
	level waittill(#"hash_4974b99613386da1");
	level clientfield::set("area_arrows", 1);
}

/*
	Name: function_836b3d02
	Namespace: namespace_28cdc89f
	Checksum: 0x4E312D25
	Offset: 0x1568
	Size: 0x1F4
	Parameters: 0
	Flags: None
*/
function function_836b3d02()
{
	level endon(#"combattraining_logic_finished");
	wait(20);
	var_6207d37d = 0;
	while(true)
	{
		if(1)
		{
			if(level.var_88024dd9 > 0 && var_6207d37d != 4)
			{
				var_6207d37d = 4;
			}
		}
		switch(var_6207d37d)
		{
			case 0:
			{
				while(isdefined(level.var_3bdcb692) && level.var_3bdcb692)
				{
					waitframe(1);
				}
				var_1639ae86 = function_d4c7a27f();
				if(isdefined(var_1639ae86))
				{
					var_346f0ce6 = var_1639ae86 namespace_73e1c3e3::function_aa9c8fbf();
					if(isdefined(var_346f0ce6))
					{
						var_6207d37d = 1;
					}
				}
				else
				{
					return;
				}
				break;
			}
			case 1:
			{
				if(isalive(var_1639ae86) && isalive(var_346f0ce6))
				{
					var_346f0ce6 function_e268297c(var_1639ae86);
					var_6207d37d = 2;
				}
				break;
			}
			case 2:
			{
				var_1639ae86 = function_d4c7a27f();
				if(!isdefined(var_1639ae86))
				{
					return;
				}
				wait(10);
				var_6207d37d = 0;
				break;
			}
			case 4:
			{
				while(level.var_88024dd9 > 0)
				{
					waitframe(1);
				}
				var_6207d37d = 0;
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_d4c7a27f
	Namespace: namespace_28cdc89f
	Checksum: 0x9A92B762
	Offset: 0x1768
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_d4c7a27f()
{
	e_player = getplayers()[0];
	var_66775908 = util::get_active_players(#"allies");
	arrayremovevalue(var_66775908, e_player);
	var_66775908 = array::randomize(var_66775908);
	foreach(var_85dd2f92 in var_66775908)
	{
		if(!(isdefined(var_85dd2f92.b_revived) && var_85dd2f92.b_revived))
		{
			return var_85dd2f92;
		}
	}
	return undefined;
}

/*
	Name: function_e268297c
	Namespace: namespace_28cdc89f
	Checksum: 0xF4DC9471
	Offset: 0x1880
	Size: 0x4F6
	Parameters: 1
	Flags: None
*/
function function_e268297c(var_1639ae86)
{
	self.var_ef59b90 = 4;
	self.var_59860ee1 = 1000;
	self.var_dd940df3 = 5000;
	self.var_bab91f2 = 128;
	self.var_4c7240f1 = 1;
	self.var_b1fd680c = 1;
	v_dir = anglestoforward(var_1639ae86.var_57f1bd45.angles);
	var_6c9efff0 = var_1639ae86.var_57f1bd45.origin + v_dir * 150;
	self.var_9a79d89d = var_6c9efff0;
	v_dir = v_dir * -1;
	v_angles = vectortoangles(v_dir);
	self.var_5ab7c19c = v_angles;
	var_e47f9e94 = 0;
	n_start_time = undefined;
	while(true)
	{
		if(!isalive(self))
		{
			e_player = getplayers()[0];
			e_player thread namespace_73e1c3e3::function_d471f8fa(15, undefined, 1);
			level thread function_6511fb07();
			break;
		}
		if(var_1639ae86.var_3c5a5d29 != 1)
		{
			self.var_ef59b90 = 1;
			break;
		}
		if(1)
		{
			if(level.var_88024dd9 > 0 && !isdefined(level.var_f78f9034))
			{
				break;
			}
		}
		if(isdefined(n_start_time))
		{
			n_time = gettime() / 1000;
			dt = n_time - n_start_time;
			level.var_db674473 = 1 - dt / 40;
			if(!(isdefined(var_e47f9e94) && var_e47f9e94) && dt > 20)
			{
				level thread function_3a3bc266();
				var_e47f9e94 = 1;
			}
			if(dt >= 40)
			{
				var_1639ae86 suicide();
				e_player = getplayers()[0];
				e_player thread namespace_73e1c3e3::function_d471f8fa(-60, undefined, 1);
				level thread function_f5eba86b();
				level.var_9e8e503f--;
				n_count = e_player namespace_73e1c3e3::function_acfb4f94();
				e_player namespace_73e1c3e3::function_68e9fa9e(undefined, n_count, level.var_9e8e503f, 1, 1);
				break;
			}
		}
		n_dist = distance(self.origin, var_6c9efff0);
		if(n_dist < 256 && !isdefined(level.var_f78f9034) && (!(isdefined(level.var_3574b65f) && level.var_3574b65f)))
		{
			level thread function_1b25b7dc();
			level.var_f78f9034 = namespace_73e1c3e3::create_waypoint(#"hash_10b60fe281bbfeca", var_1639ae86.origin, var_1639ae86.angles, #"any", undefined, 0, undefined);
			self.var_7630c482 = 1;
			n_start_time = gettime() / 1000;
			e_player = getplayers()[0];
			e_player thread function_6b37f8a5();
		}
		waitframe(1);
	}
	if(isalive(self))
	{
		self.var_ef59b90 = 1;
	}
	level.var_db674473 = 0;
	if(isdefined(level.var_f78f9034))
	{
		level.var_f78f9034 gameobjects::set_visible_team("none");
		level.var_f78f9034 = undefined;
	}
}

/*
	Name: function_52a2e58a
	Namespace: namespace_28cdc89f
	Checksum: 0x5EC9C462
	Offset: 0x1D80
	Size: 0x1B0
	Parameters: 1
	Flags: None
*/
function function_52a2e58a(a_players)
{
	e_player = getplayers(#"allies")[0];
	var_3f21ce47 = arraysortclosest(a_players, e_player.origin, undefined, 0, 800);
	var_811b6a20 = [];
	v_forward = anglestoforward(e_player.angles);
	foreach(bot in a_players)
	{
		n_dist = distance(bot.origin, e_player.origin);
		if(n_dist < 800)
		{
			v_dir = vectornormalize(bot.origin - e_player.origin);
			dp = vectordot(v_forward, v_dir);
			if(dp > 0.4)
			{
				var_811b6a20[var_811b6a20.size] = bot;
			}
		}
	}
	return var_811b6a20;
}

/*
	Name: function_e60bbaf4
	Namespace: namespace_28cdc89f
	Checksum: 0x4EFB1BE1
	Offset: 0x1F38
	Size: 0x1B4
	Parameters: 0
	Flags: None
*/
function function_e60bbaf4()
{
	level.var_cea5b696 = 0;
	while(true)
	{
		e_player = getplayers()[0];
		var_86810743 = util::get_active_players(#"allies");
		arrayremovevalue(var_86810743, e_player);
		var_177356ca = 1;
		foreach(var_1639ae86 in var_86810743)
		{
			if(!(isdefined(var_1639ae86.var_563afe18) && var_1639ae86.var_563afe18))
			{
				var_177356ca = 0;
				break;
			}
		}
		if(var_177356ca)
		{
			break;
		}
		waitframe(1);
	}
	if(!level.var_cea5b696)
	{
		level flag::set("mission_failed");
		level thread function_f8888fe5();
		return;
	}
	level.var_e6db911d = 1;
	namespace_64a487a9::function_87cf954e();
	level flag::set("mission_success");
}

/*
	Name: function_9087a4b6
	Namespace: namespace_28cdc89f
	Checksum: 0xCD8CCC9A
	Offset: 0x20F8
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function function_9087a4b6()
{
	level endon(#"combattraining_logic_finished");
	level.var_3bdcb692 = 0;
	while(true)
	{
		level waittill(#"hash_1b2f366c8974d17a");
		level.var_3bdcb692 = 1;
		wait(10);
		level.var_3bdcb692 = 0;
	}
}

/*
	Name: function_6b37f8a5
	Namespace: namespace_28cdc89f
	Checksum: 0xFE11BF2B
	Offset: 0x2170
	Size: 0x28A
	Parameters: 0
	Flags: None
*/
function function_6b37f8a5()
{
	self endon(#"death");
	if(isdefined(level.var_8a300598) && level.var_8a300598)
	{
		level.var_e8c8fc4 luielembar_ct::close(self);
		waitframe(1);
	}
	level.xpos = 750;
	level.ypos = 70;
	level.width = 50;
	level.height = 8;
	level.var_8a300598 = 1;
	self namespace_73e1c3e3::function_7b70bd74(level.var_e8c8fc4, level.xpos, level.ypos, level.width, level.height);
	level.var_e8c8fc4 luielembar_ct::set_color(self, 1, 0, 0);
	level.var_db674473 = 0;
	while(isdefined(level.var_f78f9034))
	{
		level.var_e8c8fc4 luielembar_ct::function_fd8c13fb(self, level.var_db674473);
		if(level flag::get("mission_success") || level flag::get("mission_failed"))
		{
			break;
		}
		level.var_e8c8fc4 luielembar_ct::function_e5898fd7(self, level.xpos);
		level.var_e8c8fc4 luielembar_ct::function_58a135d3(self, level.ypos);
		level.var_e8c8fc4 luielembar_ct::function_8b0b5811(self, level.width);
		level.var_e8c8fc4 luielembar_ct::function_5dbd7024(self, level.height);
		waitframe(1);
	}
	level.var_e8c8fc4 luielembar_ct::close(self);
	level.var_8a300598 = 0;
}

/*
	Name: function_e424e334
	Namespace: namespace_28cdc89f
	Checksum: 0x3A5DCCC5
	Offset: 0x2408
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_e424e334()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_7fcaeb7f148aba86", 4, "green", 0);
}

/*
	Name: function_f5eba86b
	Namespace: namespace_28cdc89f
	Checksum: 0xB8AC85BF
	Offset: 0x2468
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_f5eba86b()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_4c6cfe7bf6bdab6d", 4, "red");
}

/*
	Name: function_1b25b7dc
	Namespace: namespace_28cdc89f
	Checksum: 0xEF782D65
	Offset: 0x24C8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_1b25b7dc()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_76cbc958f8398240", 5, "red", 2);
}

/*
	Name: function_6511fb07
	Namespace: namespace_28cdc89f
	Checksum: 0xD227842B
	Offset: 0x2530
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_6511fb07()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_14db51c946ba874e", 5, "green");
}

/*
	Name: function_f8888fe5
	Namespace: namespace_28cdc89f
	Checksum: 0x2CE6AFF3
	Offset: 0x2590
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_f8888fe5()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_69afc05cf0c10527", 4, "red", 2);
}

/*
	Name: function_3a3bc266
	Namespace: namespace_28cdc89f
	Checksum: 0xFA8E6117
	Offset: 0x25F8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_3a3bc266()
{
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_6a9ca42b7fbc4ccd", 4, "red", 2);
}

/*
	Name: function_5f17f29
	Namespace: namespace_28cdc89f
	Checksum: 0x4B464D24
	Offset: 0x2660
	Size: 0x70
	Parameters: 0
	Flags: None
*/
function function_5f17f29()
{
	level endon(#"hash_2459a7f38b7c48c2");
	e_player = getplayers()[0];
	while(true)
	{
		level waittill(#"hash_4467c8999d018835");
		e_player thread namespace_73e1c3e3::function_785eb2ca();
	}
}

