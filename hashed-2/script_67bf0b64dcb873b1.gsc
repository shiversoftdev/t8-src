// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_81c2da86;

/*
	Name: function_89f2df9
	Namespace: namespace_81c2da86
	Checksum: 0xD1544470
	Offset: 0x3D8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5e3499ddc3965135", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_81c2da86
	Checksum: 0x7C077159
	Offset: 0x428
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_9e0e74ff = 0;
	level flag::init("flag_player_grabbed_werewolf_material");
	level flag::init("flag_player_grabbed_catalyst_material");
	level flag::init("flag_player_grabbed_nosferatu_material");
	level flag::init("flag_player_grabbed_werewolf_prima");
	level flag::init("flag_player_grabbed_bat_prima");
	level flag::init("flag_player_grabbed_nosferatu_prima");
	var_a70a763b = getentarray("ww_lvl2_quest_piece_on_table", "targetname");
	array::run_all(var_a70a763b, &hide);
	array::run_all(var_a70a763b, &notsolid);
}

/*
	Name: __main__
	Namespace: namespace_81c2da86
	Checksum: 0x18D2476A
	Offset: 0x568
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		level thread function_6b6712e3();
		level thread function_c9e23896();
		var_35da56ee = namespace_a1d9b01d::function_b18074d0(#"zblueprint_mansion_ww_lvl2");
		var_35da56ee.var_670f9944.var_62a98b13 = #"hash_5b861e557c672a2b";
		var_35da56ee.var_2e0a273a.var_62a98b13 = #"hash_42e3673730d13c20";
		namespace_a1d9b01d::function_d1f16587(#"zblueprint_mansion_ww_lvl2", &function_1d1da682);
		callback::on_connect(&function_27b91fdb);
	}
	level flag::init(#"hash_1462d174d4023e58");
	level thread function_514a3f80();
}

/*
	Name: function_27b91fdb
	Namespace: namespace_81c2da86
	Checksum: 0xFB02938B
	Offset: 0x6B8
	Size: 0x1B8
	Parameters: 0
	Flags: Linked
*/
function function_27b91fdb()
{
	self endon(#"disconnect");
	level endon(#"ww_lvl2_crafting_completed");
	self flag::init(#"hash_4428586b42c7a522");
	while(true)
	{
		var_e7df750a = 0;
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_change");
		var_3ba4bf7d = self getweaponslistprimaries();
		foreach(w_primary in var_3ba4bf7d)
		{
			if(w_primary == level.var_f086136b)
			{
				var_e7df750a = 1;
				if(!self flag::get(#"hash_4428586b42c7a522"))
				{
					self flag::set(#"hash_4428586b42c7a522");
				}
			}
		}
		if(!var_e7df750a && self flag::get(#"hash_4428586b42c7a522"))
		{
			self flag::clear(#"hash_4428586b42c7a522");
		}
	}
}

/*
	Name: function_6b6712e3
	Namespace: namespace_81c2da86
	Checksum: 0x5106F972
	Offset: 0x878
	Size: 0x21C
	Parameters: 0
	Flags: Linked
*/
function function_6b6712e3()
{
	level flagsys::wait_till("start_zombie_round_logic");
	var_ca45945a = scene::get_active_scenes(#"p8_fxanim_zm_man_bookcase_04_bundle");
	var_48e18d96 = var_ca45945a[0];
	var_80c684f = var_48e18d96.scene_ents[#"hash_7aff0ee60ddd937b"];
	var_728bcf6e = getent("ww_l2_part_clip_right", "targetname");
	var_728bcf6e linkto(var_80c684f, "tag_animate_02");
	var_45e56423 = getent("ww_l2_part_clip_left", "targetname");
	var_45e56423 linkto(var_80c684f, "tag_animate_01");
	var_728bcf6e disconnectpaths();
	var_45e56423 disconnectpaths();
	var_80c684f thread function_4a81e337();
	level waittill(#"hash_2588983e2be22ca5");
	s_loc = struct::get("s_wwlvl2_quest_pickup_1", "targetname");
	var_ef5b83bb = namespace_c05f06c7::function_89e9bca5(#"hash_5dba840c6ed3ea3b", s_loc.origin, s_loc.angles);
	var_ef5b83bb clientfield::set("" + #"hash_524ec892754aeb34", 1);
}

/*
	Name: function_4a81e337
	Namespace: namespace_81c2da86
	Checksum: 0xD49D0911
	Offset: 0xAA0
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_4a81e337()
{
	level endon(#"hash_2588983e2be22ca5");
	self setcandamage(1);
	self thread function_292dd34f();
	self.health = 10000;
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		if(isplayer(var_385703b7.attacker))
		{
			if(function_216d0545(var_385703b7))
			{
				level notify(#"hash_2588983e2be22ca5");
			}
		}
		else
		{
			self.health = 10000;
		}
	}
}

/*
	Name: function_292dd34f
	Namespace: namespace_81c2da86
	Checksum: 0x3E526549
	Offset: 0xB88
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_292dd34f(var_d42a9ac5)
{
	level waittill(#"hash_2588983e2be22ca5");
	self setcandamage(0);
	level scene::play(#"p8_fxanim_zm_man_bookcase_04_bundle");
}

/*
	Name: function_216d0545
	Namespace: namespace_81c2da86
	Checksum: 0x665C82A3
	Offset: 0xBF0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_216d0545(var_385703b7)
{
	/#
		if(var_385703b7.mod === "" && (isdefined(level.var_14a33fde) && level.var_14a33fde))
		{
			return 1;
		}
	#/
	return var_385703b7.mod === "MOD_MELEE" || var_385703b7.mod === "MOD_IMPACT" && namespace_c05f06c7::function_9b4de361(var_385703b7.weapon);
}

/*
	Name: function_c9e23896
	Namespace: namespace_81c2da86
	Checksum: 0xAB6235E2
	Offset: 0xC98
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_c9e23896()
{
	level endon(#"hash_3b0bcf867c23b993");
	level waittill(#"hash_879562bd9e764a4");
	var_9e030909 = getweapon(#"hash_138efe2bb30be63c");
	level flag::init("ww_lvl2_crafting_completed");
	level thread function_6231b511();
}

/*
	Name: function_6231b511
	Namespace: namespace_81c2da86
	Checksum: 0x1572AEE8
	Offset: 0xD38
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_6231b511()
{
	while(!level flag::get("ww_lvl2_crafting_completed"))
	{
		var_385703b7 = undefined;
		var_385703b7 = level waittill(#"hash_656719782f57ca1a");
		if(var_385703b7.blueprint.name === "zblueprint_mansion_ww_lvl2")
		{
			level flag::set("ww_lvl2_crafting_completed");
			callback::remove_on_connect(&function_27b91fdb);
			level namespace_6747c550::function_7df6bb60(#"hash_5ddc0f3d5535879b", 1);
		}
	}
}

/*
	Name: function_514a3f80
	Namespace: namespace_81c2da86
	Checksum: 0xC0B4F669
	Offset: 0xE18
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_514a3f80()
{
	if(!isdefined(level.var_9332cecc))
	{
		level.var_9332cecc = 0;
	}
	if(!isdefined(level.var_f6a6ddae))
	{
		level.var_f6a6ddae = 0;
	}
	if(!isdefined(level.var_ea58030a))
	{
		level.var_ea58030a = 0;
	}
	struct::get("s_prima_material_device") zm_unitrigger::create(&function_32573d2a, 64, &function_ea6f56ee);
	namespace_93829f86::function_4d230236(namespace_a1d9b01d::function_4c2f8683(#"hash_5dba850c6ed3ebee"), &function_b9cbdac6);
	namespace_93829f86::function_4d230236(namespace_a1d9b01d::function_4c2f8683(#"hash_3f639544c52d4fa3"), &function_b9cbdac6);
	namespace_93829f86::function_4d230236(namespace_a1d9b01d::function_4c2f8683(#"hash_3f639644c52d5156"), &function_b9cbdac6);
	level flagsys::wait_till_any(array(#"power_on1", #"hash_2daf5bdda85cc660"));
	wait(randomintrange(20, 30));
	var_56dd89fc = struct::get("s_pr_mach");
	var_56dd89fc scene::play("Open");
	exploder::exploder("exp_lgt_prima_disp_green_sml");
	exploder::exploder("exp_lgt_prima_disp_red_lrg");
}

/*
	Name: function_32573d2a
	Namespace: namespace_81c2da86
	Checksum: 0x3A526E5
	Offset: 0x1050
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_32573d2a(player)
{
	if(!level flag::get(#"hash_1462d174d4023e58") && (level flag::get("flag_player_grabbed_werewolf_material") && !level.var_9332cecc || (level flag::get("flag_player_grabbed_catalyst_material") && !level.var_f6a6ddae) || (level flag::get("flag_player_grabbed_nosferatu_material") && !level.var_ea58030a)))
	{
		self sethintstringforplayer(player, #"hash_7e343f7677cbafe5");
	}
	else
	{
		self sethintstringforplayer(player, "");
	}
	return 1;
}

/*
	Name: function_ea6f56ee
	Namespace: namespace_81c2da86
	Checksum: 0xCEDD132C
	Offset: 0x1170
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function function_ea6f56ee()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player) || level flag::get(#"hash_1462d174d4023e58"))
		{
			continue;
		}
		var_21839a96 = #"";
		var_57ec466d = #"zmb_sq_souls_release";
		if(level flag::get("flag_player_grabbed_werewolf_material") && !level flag::get("flag_player_grabbed_werewolf_prima"))
		{
			var_21839a96 = #"hash_5dba850c6ed3ebee";
			level thread function_29f66f1a(var_21839a96, var_57ec466d);
			level.var_9332cecc = 1;
			level namespace_6747c550::function_7df6bb60(#"hash_3761ebdf006d549e", 0);
		}
		else if(level flag::get("flag_player_grabbed_catalyst_material") && !level flag::get("flag_player_grabbed_bat_prima"))
		{
			var_21839a96 = #"hash_3f639544c52d4fa3";
			level thread function_29f66f1a(var_21839a96, var_57ec466d);
			level.var_f6a6ddae = 1;
			level namespace_6747c550::function_7df6bb60(#"hash_3eb09edf042e93c7", 0);
		}
		else if(level flag::get("flag_player_grabbed_nosferatu_material") && !level flag::get("flag_player_grabbed_nosferatu_prima"))
		{
			var_21839a96 = #"hash_3f639644c52d5156";
			level thread function_29f66f1a(var_21839a96, var_57ec466d);
			level.var_ea58030a = 1;
			level namespace_6747c550::function_7df6bb60(#"hash_3eb09ddf042e9214", 0);
		}
		if(isdefined(level.var_9332cecc) && level.var_9332cecc && (isdefined(level.var_f6a6ddae) && level.var_f6a6ddae) && (isdefined(level.var_ea58030a) && level.var_ea58030a))
		{
			break;
		}
	}
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_29f66f1a
	Namespace: namespace_81c2da86
	Checksum: 0x86A878F9
	Offset: 0x14B0
	Size: 0x1BC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_29f66f1a(var_21839a96, var_57ec466d)
{
	level flag::set(#"hash_1462d174d4023e58");
	var_56dd89fc = struct::get("s_pr_mach");
	s_start_loc = struct::get(#"s_prima_material_device");
	var_feb69dca = util::spawn_model(s_start_loc.model, s_start_loc.origin, s_start_loc.angles);
	var_56dd89fc scene::play("Start");
	var_feb69dca thread function_6f29b131();
	exploder::exploder("exp_lgt_prima_disp_red_sml");
	exploder::exploder_stop("exp_lgt_prima_disp_green_sml");
	var_56dd89fc thread scene::play("init");
	wait(12);
	level thread function_672eb1dc(var_21839a96, var_57ec466d);
	var_56dd89fc scene::play("Finish");
	exploder::exploder("exp_lgt_prima_disp_green_lrg");
	exploder::exploder_stop("exp_lgt_prima_disp_red_lrg");
}

/*
	Name: function_6f29b131
	Namespace: namespace_81c2da86
	Checksum: 0x961394C0
	Offset: 0x1678
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_6f29b131()
{
	self endon(#"death");
	wait(2.5);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_672eb1dc
	Namespace: namespace_81c2da86
	Checksum: 0xB578B76D
	Offset: 0x16C0
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function function_672eb1dc(var_21839a96, var_57ec466d)
{
	s_loc = struct::get("s_prima_material_spawn_loc");
	wait(5);
	var_58b3e56b = namespace_c05f06c7::function_89e9bca5(var_21839a96, s_loc.origin, s_loc.angles);
	playsoundatposition(var_57ec466d, var_58b3e56b.origin);
	level notify(#"hash_144b3192f03325f3");
}

/*
	Name: function_b9cbdac6
	Namespace: namespace_81c2da86
	Checksum: 0x5B5507A9
	Offset: 0x1768
	Size: 0x214
	Parameters: 2
	Flags: Linked
*/
function function_b9cbdac6(e_holder, var_9c95ad05)
{
	var_56dd89fc = struct::get("s_pr_mach");
	switch(var_9c95ad05.name)
	{
		case "hash_5dba850c6ed3ebee":
		{
			level namespace_6747c550::function_7df6bb60(#"hash_3761ebdf006d549e", 2);
			level flag::set("flag_player_grabbed_werewolf_prima");
			break;
		}
		case "hash_3f639544c52d4fa3":
		{
			level namespace_6747c550::function_7df6bb60(#"hash_3eb09edf042e93c7", 2);
			level flag::set("flag_player_grabbed_bat_prima");
			break;
		}
		case "hash_3f639644c52d5156":
		{
			level namespace_6747c550::function_7df6bb60(#"hash_3eb09ddf042e9214", 5);
			level flag::set("flag_player_grabbed_nosferatu_prima");
			break;
		}
	}
	var_56dd89fc scene::play("Close");
	exploder::exploder("exp_lgt_prima_disp_red_lrg");
	exploder::exploder_stop("exp_lgt_prima_disp_green_lrg");
	var_56dd89fc scene::play("Open");
	exploder::exploder("exp_lgt_prima_disp_green_sml");
	exploder::exploder_stop("exp_lgt_prima_disp_red_sml");
	level flag::clear(#"hash_1462d174d4023e58");
}

/*
	Name: function_1d1da682
	Namespace: namespace_81c2da86
	Checksum: 0x220D98A0
	Offset: 0x1988
	Size: 0x12E
	Parameters: 1
	Flags: Linked
*/
function function_1d1da682(e_player)
{
	level notify(#"hash_24c45fc7880ee4f0");
	var_a70a763b = getentarray("ww_lvl2_quest_piece_on_table", "targetname");
	array::run_all(var_a70a763b, &show);
	unitrigger_stub = self.stub;
	e_player zm_weapons::weapon_take(level.var_f086136b);
	e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_ab2e19733266586", 1);
	e_player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
	wait(0.1);
	unitrigger_stub namespace_a1d9b01d::function_6dccf508();
	unitrigger_stub.prompt_and_visibility_func = &function_7aa50bb7;
}

/*
	Name: function_7aa50bb7
	Namespace: namespace_81c2da86
	Checksum: 0x3B886936
	Offset: 0x1AC0
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function function_7aa50bb7(e_player)
{
	can_use = self.stub namespace_a1d9b01d::function_18f2be60(e_player);
	if(e_player zm_weapons::has_weapon_or_upgrade(level.var_6fe89212) || e_player zm_weapons::has_weapon_or_upgrade(level.var_7b9ca97a))
	{
		self sethintstring("");
	}
	else if(e_player zm_weapons::has_weapon_or_upgrade(level.var_f086136b))
	{
		self sethintstring(self.stub.blueprint.var_4dbc4aee);
	}
	else
	{
		self sethintstring(#"hash_61bd1f669b4c6a1c");
	}
	return can_use;
}

