// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_67594c4a;

/*
	Name: init
	Namespace: namespace_67594c4a
	Checksum: 0xE6EAD2D9
	Offset: 0x170
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	init_flags();
}

/*
	Name: init_clientfields
	Namespace: namespace_67594c4a
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
}

/*
	Name: init_flags
	Namespace: namespace_67594c4a
	Checksum: 0x1696F76
	Offset: 0x1B0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_478e70a97b556206");
	level flag::init(#"hash_6a417acc02a28c9d");
	level flag::init(#"hash_6b5e9a7b23ad25a5");
}

/*
	Name: main
	Namespace: namespace_67594c4a
	Checksum: 0x5749490F
	Offset: 0x220
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level.var_97da986d = spawnstruct();
	level.var_97da986d.var_6f9b20c6 = 0;
	level.var_97da986d.var_7d4c9076 = 105000;
	level.var_97da986d.n_start_time = 0;
	var_954f6810 = struct::get("ee_tundragun_weapon_box");
	var_5fbb6b48 = struct::get("ee_tundragun_weapon_box_lid");
	if(isdefined(var_954f6810) && isdefined(var_5fbb6b48))
	{
		level.var_97da986d.var_954f6810 = var_954f6810;
		e_model = util::spawn_model(var_954f6810.model, var_954f6810.origin, var_954f6810.angles);
		level.var_97da986d.var_954f6810.e_model = e_model;
		level.var_97da986d.var_5fbb6b48 = var_5fbb6b48;
		e_model = util::spawn_model(var_5fbb6b48.model, var_5fbb6b48.origin, var_5fbb6b48.angles);
		level.var_97da986d.var_5fbb6b48.e_model = e_model;
	}
	namespace_ee206246::register(#"ee_tundragun", #"step_1", #"hash_3e669a61b30bad3c", &function_8128801a, &function_5f8f9262);
	namespace_ee206246::register(#"ee_tundragun", #"step_2", #"hash_3e669d61b30bb255", &function_219876e0, &function_67098abf);
	namespace_ee206246::start(#"ee_tundragun", !zm_utility::is_standard());
}

/*
	Name: function_8128801a
	Namespace: namespace_67594c4a
	Checksum: 0x519C246B
	Offset: 0x4B0
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function function_8128801a(var_5ea5c94d)
{
	/#
		iprintlnbold("");
	#/
	level.var_97da986d.a_s_targets = struct::get_array("ee_tundragun_target");
	foreach(s_target in level.var_97da986d.a_s_targets)
	{
		if(isdefined(s_target.model))
		{
			s_target.e_target = util::spawn_model(s_target.model, s_target.origin, s_target.angles);
			s_target.e_target setcandamage(1);
			s_target.e_target val::set("ee_tundragun", "allowDeath", 0);
			s_target.e_target.script_int = s_target.script_int;
			s_target.e_target thread function_f16c0259();
		}
	}
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_478e70a97b556206");
	}
}

/*
	Name: function_5f8f9262
	Namespace: namespace_67594c4a
	Checksum: 0x5FDB17D0
	Offset: 0x678
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_5f8f9262(var_5ea5c94d, ended_early)
{
	/#
		iprintlnbold("");
	#/
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_478e70a97b556206");
	}
}

/*
	Name: function_f16c0259
	Namespace: namespace_67594c4a
	Checksum: 0x32CE10A5
	Offset: 0x6E8
	Size: 0x370
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f16c0259()
{
	self endon(#"death");
	level endon(#"end_game", #"hash_478e70a97b556206");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		level.var_97da986d.var_af9bf642 = var_385703b7.inflictor;
		var_b6d64a72 = isdefined(var_385703b7.weapon) && (var_385703b7.weapon.rootweapon === level.var_ad5d43cf || var_385703b7.weapon.rootweapon === level.var_f8934665 || var_385703b7.weapon.rootweapon === level.var_bf70d56c || var_385703b7.weapon.rootweapon === level.var_d879215);
		var_d35fda46 = level.var_97da986d.var_2759714a === level.var_97da986d.var_af9bf642 || level.var_97da986d.var_6f9b20c6 === 0;
		if(var_b6d64a72 && var_d35fda46)
		{
			var_cf41b762 = self.script_int === level.var_97da986d.var_6f9b20c6;
			if(var_cf41b762)
			{
				self playsound(#"hash_4a51cdb0e1682b6c");
				if(level.var_97da986d.var_6f9b20c6 === 0)
				{
					level thread function_213f1c48();
					level.var_97da986d.var_2759714a = level.var_97da986d.var_af9bf642;
				}
				n_time_remaining = level.var_97da986d.var_7d4c9076 - gettime() - level.var_97da986d.n_start_time / 1000 / 60;
				/#
					iprintlnbold("" + self.script_int + 1 + "" + n_time_remaining + "");
				#/
				level.var_97da986d.var_6f9b20c6++;
				if(level.var_97da986d.var_6f9b20c6 === level.var_97da986d.a_s_targets.size)
				{
					/#
						iprintlnbold("");
					#/
					level notify(#"hash_3dcff814c31d2298");
					level flag::set(#"hash_478e70a97b556206");
				}
			}
			else
			{
				/#
					iprintlnbold("");
				#/
				function_c19f52ea();
			}
		}
	}
}

/*
	Name: function_213f1c48
	Namespace: namespace_67594c4a
	Checksum: 0x64390664
	Offset: 0xA60
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
private function function_213f1c48()
{
	level endon(#"end_game", #"hash_3dcff814c31d2298");
	/#
		iprintlnbold("" + 1.75 + "");
	#/
	level flag::clear(#"hash_6a417acc02a28c9d");
	level.var_97da986d.n_start_time = gettime();
	while(gettime() < level.var_97da986d.n_start_time + level.var_97da986d.var_7d4c9076)
	{
		wait(0.5);
	}
	/#
		iprintlnbold("");
	#/
	level flag::set(#"hash_6a417acc02a28c9d");
	function_c19f52ea();
}

/*
	Name: function_c19f52ea
	Namespace: namespace_67594c4a
	Checksum: 0xECF588A5
	Offset: 0xB80
	Size: 0x88
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c19f52ea()
{
	if(level.var_97da986d.var_6f9b20c6 > 0 && math::cointoss())
	{
		level.var_97da986d.var_af9bf642 thread namespace_3263198e::function_51b752a9("vox_generic_responses_negative");
	}
	level.var_97da986d.var_6f9b20c6 = 0;
	level notify(#"hash_3dcff814c31d2298");
}

/*
	Name: function_219876e0
	Namespace: namespace_67594c4a
	Checksum: 0xB424EE0A
	Offset: 0xC10
	Size: 0x28C
	Parameters: 1
	Flags: Linked
*/
function function_219876e0(var_5ea5c94d)
{
	/#
		iprintlnbold("");
	#/
	/#
		iprintlnbold("");
	#/
	var_aa345c88 = struct::get("ee_tundragun_weapon");
	level.var_97da986d.var_aa345c88 = var_aa345c88;
	e_weapon = util::spawn_model(var_aa345c88.model, var_aa345c88.origin, var_aa345c88.angles);
	level.var_97da986d.var_aa345c88.e_weapon = e_weapon;
	var_9dd10753 = level.var_97da986d.var_5fbb6b48.e_model;
	var_9dd10753 playsound(#"hash_1cfa90c531f36b92");
	var_9dd10753 rotatepitch(-100, 1.5);
	var_9dd10753 waittill(#"rotatedone");
	if(isdefined(var_aa345c88))
	{
		e_weapon moveto(e_weapon.origin + vectorscale((0, 0, 1), 16), 1.5);
		e_weapon waittill(#"movedone");
		level.var_97da986d.var_aa345c88.e_weapon namespace_3263198e::function_dfa12910(getweapon("tundragun"), &function_37d390f8);
	}
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_6b5e9a7b23ad25a5");
		if(isdefined(level.var_97da986d.var_aa345c88) && isdefined(level.var_97da986d.var_aa345c88.e_weapon))
		{
			level.var_97da986d.var_aa345c88.e_weapon delete();
		}
	}
}

/*
	Name: function_67098abf
	Namespace: namespace_67594c4a
	Checksum: 0xD0C41112
	Offset: 0xEA8
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_67098abf(var_5ea5c94d, ended_early)
{
	/#
		iprintlnbold("");
	#/
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_6b5e9a7b23ad25a5");
	}
}

/*
	Name: function_37d390f8
	Namespace: namespace_67594c4a
	Checksum: 0x2AB6B8D5
	Offset: 0xF18
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_37d390f8(e_player, var_876ad064)
{
	if(var_876ad064)
	{
		e_player thread namespace_3263198e::function_51b752a9("vox_tundragun_get");
	}
	level flag::set(#"hash_6b5e9a7b23ad25a5");
}

