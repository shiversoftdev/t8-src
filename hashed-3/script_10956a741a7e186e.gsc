// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_174ebb9642933bf7;
#using script_28b18e98462a3c7c;
#using script_3510d12b63a575c3;
#using script_3657077a08b7f19e;
#using script_3f9e0dc8454d98e1;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using script_74aa7b4c7d0a5ec6;
#using script_7e59d7bba853fe4b;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_5c160465;

/*
	Name: init
	Namespace: namespace_5c160465
	Checksum: 0x8E70BA4A
	Offset: 0xD28
	Size: 0x4CC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	var_75b393f9 = level.var_819e7dfd[#"nova_crawler"];
	var_376db024 = var_75b393f9.var_f6a3b5b0;
	arrayremovevalue(level.var_33e85fa1[var_376db024], var_75b393f9);
	var_376db024 = 20;
	var_75b393f9.var_f6a3b5b0 = var_376db024;
	if(!isdefined(level.var_33e85fa1[var_376db024]))
	{
		level.var_33e85fa1[var_376db024] = [];
	}
	else if(!isarray(level.var_33e85fa1[var_376db024]))
	{
		level.var_33e85fa1[var_376db024] = array(level.var_33e85fa1[var_376db024]);
	}
	if(!isinarray(level.var_33e85fa1[var_376db024], var_75b393f9))
	{
		level.var_33e85fa1[var_376db024][level.var_33e85fa1[var_376db024].size] = var_75b393f9;
	}
	level.var_819e7dfd[#"nova_crawler"].var_ef500cb7 = &function_ccdfa71b;
	level.var_819e7dfd[#"nova_crawler"].var_87ed2709 = &function_dd836251;
	namespace_c3287616::function_2876740e(#"nova_crawler", &function_f3f325cb);
	namespace_57ff8cbb::function_cdf5a512(#"nova_crawler", &function_b448360c);
	level.ranged_nova_crawler_spawner = getent("ranged_nova_crawler_spawner", "script_noteworthy");
	/#
		assert(isdefined(level.ranged_nova_crawler_spawner), "");
	#/
	if(zm_utility::is_classic())
	{
		level thread function_2791c411();
		level thread function_5daa45ac();
		level thread enable_dog_rounds();
		level thread function_3fc75ca6();
	}
	if(zm_utility::is_standard())
	{
		var_8b762855 = struct::get_array("malaria", "targetname");
		foreach(var_27bc564a in var_8b762855)
		{
			var_27bc564a thread function_ff5c24a8();
		}
		s_generator = struct::get("main_generator", "targetname");
		s_generator thread scene::play("shot 1");
	}
	if(zm_utility::function_3bff983f())
	{
		level thread function_2791c411();
		level thread function_5daa45ac();
		level thread function_3fc75ca6();
		namespace_32192f7::function_95c1dd81(#"nova_crawler", &function_75309b09);
		namespace_c3287616::function_376e51ef(#"zombie_dog", 15);
	}
	level thread function_2790a022();
	level thread function_8a965a96();
	level thread function_cb3e8fb9();
	level thread function_2ae2045c();
}

/*
	Name: register_clientfields
	Namespace: namespace_5c160465
	Checksum: 0x85E76B79
	Offset: 0x1200
	Size: 0x2B4
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("scriptmover", "white_event_gas_lg_clientfield", 1, 1, "int");
	clientfield::register("scriptmover", "white_event_gas_MD_clientfield", 1, 1, "int");
	clientfield::register("scriptmover", "white_event_gas_lg_vent_clientfield", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicators_init", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_green_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_hammond_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_hoggatt_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_obrien_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_reinsel_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_yellow_house", 1, 1, "int");
	clientfield::register("world", "portal_map_gas_indicator_generators", 1, 1, "int");
	clientfield::register("world", "generator_sound_sweetner", 1, 1, "int");
	clientfield::register("world", "" + #"hash_1c11f70bb8445095", 1, 3, "int");
	clientfield::register("toplayer", "vent_interact_feedback", 20000, 1, "counter");
}

/*
	Name: function_2ae2045c
	Namespace: namespace_5c160465
	Checksum: 0x14111264
	Offset: 0x14C0
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_2ae2045c()
{
	level endon(#"end_game");
	if(zm_utility::is_classic())
	{
		var_845efa03 = 0;
		do
		{
			waitresult = undefined;
			waitresult = level waittill(#"buffed");
			if(zm_audio::function_63f85f39(#"hash_5d38f35adb891", #"react"))
			{
				var_845efa03 = waitresult.ai zm_audio::function_ef9ba49c(#"hash_5d38f35adb891");
			}
		}
		while(!(isdefined(var_845efa03) && var_845efa03));
	}
}

/*
	Name: enable_dog_rounds
	Namespace: namespace_5c160465
	Checksum: 0x1DDD2D41
	Offset: 0x15A0
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function enable_dog_rounds()
{
	level.var_973488a5 = function_21a3a673(5, 7);
	if(zm_utility::is_classic())
	{
		level.var_2f14be05 = level.round_number + 1;
		if(level.round_number < 15)
		{
			level.var_2f14be05 = 15;
		}
		namespace_c3287616::function_376e51ef(#"zombie_dog", level.var_2f14be05);
	}
	else if(zm_utility::function_3bff983f())
	{
		level.var_2f14be05 = level.round_number + 1;
		if(level.round_number < 10)
		{
			level.var_2f14be05 = 10;
		}
		namespace_c3287616::function_376e51ef(#"zombie_dog", level.var_2f14be05);
		level.dog_round_track_override = &namespace_c402654::function_246a0760;
	}
	else if(zm_utility::is_standard())
	{
		level.var_2f14be05 = 10;
	}
	namespace_c402654::function_aec3446d(0);
	level thread function_dc9c5c32();
}

/*
	Name: function_2790a022
	Namespace: namespace_5c160465
	Checksum: 0xB2C31FFF
	Offset: 0x1740
	Size: 0x220
	Parameters: 0
	Flags: Linked
*/
function function_2790a022()
{
	level flag::init(#"hash_16b68e037e570465");
	namespace_9cf755b::function_ca4ee4d1("bunker_door");
	var_c247a965 = namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6");
	if(var_c247a965 === 1)
	{
		var_c39fcc2 = getentarray("lockdown_trigger", "targetname");
		foreach(var_77ccde7f in var_c39fcc2)
		{
			var_77ccde7f sethintstring(#"hash_42a58f21fe6769a4");
		}
		level flag::wait_till(#"power_on1");
		namespace_9cf755b::function_bf25aeb1("bunker_door_electric");
		level flag::wait_till(#"hash_16b68e037e570465");
		namespace_9cf755b::function_bf25aeb1("bunker_door_solitary_lockdown");
		namespace_9cf755b::function_bf25aeb1("bunker_door_storage_lockdown");
		foreach(var_77ccde7f in var_c39fcc2)
		{
			if(isdefined(var_77ccde7f))
			{
				var_77ccde7f delete();
			}
		}
	}
}

/*
	Name: function_61753e3
	Namespace: namespace_5c160465
	Checksum: 0x9DD421F9
	Offset: 0x1968
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_61753e3()
{
	level clientfield::set("portal_map_gas_indicators_init", 1);
	level clientfield::set("portal_map_gas_indicator_green_house", 0);
	level clientfield::set("portal_map_gas_indicator_hammond_house", 0);
	level clientfield::set("portal_map_gas_indicator_hoggatt_house", 0);
	level clientfield::set("portal_map_gas_indicator_obrien_house", 0);
	level clientfield::set("portal_map_gas_indicator_reinsel_house", 0);
	level clientfield::set("portal_map_gas_indicator_yellow_house", 0);
}

/*
	Name: function_10f8273e
	Namespace: namespace_5c160465
	Checksum: 0xDE9D39B2
	Offset: 0x1A58
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_10f8273e()
{
	level clientfield::set("portal_map_gas_indicators_init", 0);
	wait(1);
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		if(var_ab611263[#"hash_5ec516364540f76a"] == #"active")
		{
			str_identifier = var_ab611263[#"group"];
			clientfield::set("portal_map_gas_indicator_" + str_identifier, 1);
		}
	}
}

/*
	Name: function_8a965a96
	Namespace: namespace_5c160465
	Checksum: 0x4A5EAB
	Offset: 0x1B58
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_8a965a96()
{
	level clientfield::set("portal_map_gas_indicators_init", 1);
	level flag::wait_till(#"power_on1");
	level clientfield::set("portal_map_gas_indicators_init", 0);
	level clientfield::set("portal_map_gas_indicator_generators", 1);
	level flag::wait_till(#"hash_16b68e037e570465");
	level clientfield::set("portal_map_gas_indicator_generators", 0);
}

/*
	Name: function_dc9c5c32
	Namespace: namespace_5c160465
	Checksum: 0xF60EBF8A
	Offset: 0x1C28
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function function_dc9c5c32()
{
	level endon(#"end_game");
	level waittill(#"start_of_round");
	var_2b95ab5b = getent("use_elec_switch", "targetname");
	if(isdefined(var_2b95ab5b))
	{
		waitresult = undefined;
		waitresult = var_2b95ab5b waittill(#"trigger");
		user = waitresult.activator;
		wait(1.5);
		while(isdefined(user) && (isdefined(user.isspeaking) && user.isspeaking))
		{
			waitframe(1);
		}
		level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_38a4d1f9d149b97b", 0, 0);
		if(!(isdefined(level.var_15747fb1) && level.var_15747fb1 || (isdefined(level.var_4a03b294) && level.var_4a03b294) || !namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 1))
		{
			var_a9e4d1ee = zm_utility::get_number_of_valid_players() + 2;
			while(isdefined(level.intermission) && level.intermission)
			{
				wait(1);
			}
			for(i = 0; i < var_a9e4d1ee; i++)
			{
				ai = namespace_c402654::function_62db7b1c(0);
				if(isdefined(ai))
				{
					level.zombie_total = level.zombie_total + 1;
				}
				wait(0.5);
			}
		}
		playsoundatposition(#"hash_3fc59a2ac3e3a5b9", (0, 0, 0));
		wait(1.5);
		level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_38a4d0f9d149b7c8", 0, 0);
	}
}

/*
	Name: function_5daa45ac
	Namespace: namespace_5c160465
	Checksum: 0xDBC255BB
	Offset: 0x1EC8
	Size: 0x420
	Parameters: 0
	Flags: Linked
*/
function function_5daa45ac()
{
	var_5a7b8007 = getentarray("c_blockage", "targetname");
	var_6fd4a6e = getentarray("c_blockage_trigger", "targetname");
	level.var_d372355e = struct::get_array("powered_spray", "targetname");
	var_f7ce8af6 = struct::get_array("fluffy_dust", "targetname");
	level.var_7af8330f = getentarray("goo_vol", "targetname");
	var_d4a0b9f4 = [];
	var_8b762855 = struct::get_array("malaria", "targetname");
	level.var_35f057f6 = 0;
	level.var_bcaf8591 = 0;
	level.var_48ff1185 = 0;
	level.var_c3ee1c6e = 0;
	level flag::init(#"hash_68ac76bb578976f1");
	level flag::init(#"hash_1643995c3d7501b0");
	if(var_f7ce8af6.size > 0)
	{
		foreach(var_82bedb0a in var_f7ce8af6)
		{
			var_9449a4d2 = [];
			var_9449a4d2[#"gas_cloud"] = var_82bedb0a;
			var_f1c779a7 = var_82bedb0a.script_string + "_" + var_82bedb0a.script_int;
			var_9449a4d2[#"group"] = var_82bedb0a.script_string;
			var_9449a4d2[#"hash_3c7656a1cdb9849a"] = 0;
			var_9449a4d2[#"hash_e027de9788f58f0"] = 0;
			var_9449a4d2[#"hash_5ec516364540f76a"] = #"waiting";
			foreach(var_27bc564a in var_8b762855)
			{
				if(var_f1c779a7 == var_27bc564a.script_string)
				{
					var_9449a4d2[#"hash_3524befbbbbe0afe"] = var_27bc564a;
					var_27bc564a thread function_ff5c24a8();
				}
			}
			var_d4a0b9f4[var_f1c779a7] = var_9449a4d2;
		}
	}
	level.var_d4a0b9f4 = var_d4a0b9f4;
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		var_f1c779a7 = var_ab611263[#"gas_cloud"].script_string + "_" + var_ab611263[#"gas_cloud"].script_int;
		level function_503db3da(var_f1c779a7);
	}
}

/*
	Name: function_fb32496a
	Namespace: namespace_5c160465
	Checksum: 0xD6BA320
	Offset: 0x22F0
	Size: 0x188
	Parameters: 1
	Flags: None
*/
function function_fb32496a(str_identifier)
{
	foreach(var_efb22590 in level.var_d372355e)
	{
		if(var_efb22590.script_string == str_identifier)
		{
			var_efb22590.var_43428f = util::spawn_model("tag_origin", var_efb22590.origin);
			var_efb22590.var_43428f.angles = var_efb22590.angles;
			var_efb22590.var_43428f clientfield::set("white_event_gas_lg_vent_clientfield", 1);
		}
	}
	foreach(var_6c0fa827 in level.var_7af8330f)
	{
		if(var_6c0fa827.script_string == str_identifier)
		{
			var_6c0fa827 thread function_78d01716();
		}
	}
}

/*
	Name: function_1d0bb4d1
	Namespace: namespace_5c160465
	Checksum: 0x25221E16
	Offset: 0x2480
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function function_1d0bb4d1(str_identifier)
{
	foreach(var_efb22590 in level.var_d372355e)
	{
		if(var_efb22590.script_string == str_identifier && isdefined(var_efb22590.var_43428f))
		{
			var_efb22590.var_43428f delete();
			var_efb22590.var_43428f = undefined;
		}
	}
	foreach(var_6c0fa827 in level.var_7af8330f)
	{
		if(var_6c0fa827.script_string == str_identifier)
		{
			var_6c0fa827 thread function_d16d4153();
		}
	}
}

/*
	Name: function_10671c7e
	Namespace: namespace_5c160465
	Checksum: 0xC7E280EF
	Offset: 0x25D0
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function function_10671c7e(var_22a056cf)
{
	var_18a839cc = [];
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		if(var_22a056cf || var_ab611263[#"hash_5ec516364540f76a"] == #"disabled" && var_ab611263[#"hash_5ec516364540f76a"] != #"waiting" && var_ab611263[#"hash_5ec516364540f76a"] != #"active")
		{
			if(!isdefined(var_18a839cc))
			{
				var_18a839cc = [];
			}
			else if(!isarray(var_18a839cc))
			{
				var_18a839cc = array(var_18a839cc);
			}
			var_18a839cc[var_18a839cc.size] = var_ab611263;
		}
	}
	s_return = undefined;
	if(var_18a839cc.size > 0)
	{
		s_return = array::random(var_18a839cc);
	}
	return s_return;
}

/*
	Name: function_7b706d1d
	Namespace: namespace_5c160465
	Checksum: 0xDF50444C
	Offset: 0x2760
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_7b706d1d(str_identifier)
{
	level.var_d4a0b9f4[str_identifier][#"hash_e027de9788f58f0"] = 4;
	level.var_d4a0b9f4[str_identifier][#"hash_5ec516364540f76a"] = #"waiting";
	level.var_d4a0b9f4[str_identifier][#"total_waves"] = 0;
	level.var_d4a0b9f4[str_identifier][#"hash_3524befbbbbe0afe"] thread function_470af002();
	level function_a5b37c69(level.var_d4a0b9f4[str_identifier][#"group"]);
	level.var_d4a0b9f4[str_identifier][#"hash_5ec516364540f76a"] = #"active";
	level.var_d4a0b9f4[str_identifier][#"gas_cloud"] function_802c4c74();
	level.var_d4a0b9f4[str_identifier][#"gas_cloud"] function_5bb49d44();
}

/*
	Name: function_a5b37c69
	Namespace: namespace_5c160465
	Checksum: 0x5B5076C
	Offset: 0x28F0
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_a5b37c69(str_identifier)
{
	switch(str_identifier)
	{
		case "hash_25be9190acbc94af":
		{
			exploder::exploder("fxexp_toxic_gas_house_green");
			wait(0.1);
			break;
		}
		case "hash_7a8b4e50820270d2":
		{
			exploder::exploder("fxexp_toxic_gas_house_yellow");
			wait(0.1);
			break;
		}
		case "hash_a673b6d22213365":
		{
			exploder::exploder("fxexp_toxic_gas_house_obrien");
			wait(0.1);
			break;
		}
		case "hash_472f084dd231c176":
		{
			exploder::exploder("fxexp_toxic_gas_house_reinsel");
			wait(0.1);
			break;
		}
		case "hash_488591c68794105c":
		{
			exploder::exploder("fxexp_toxic_gas_house_hammond");
			wait(0.1);
			break;
		}
		case "hash_43a1e2c04be12ea6":
		{
			exploder::exploder("fxexp_toxic_gas_house_hoggatt");
			wait(0.1);
			break;
		}
	}
	clientfield::set("portal_map_gas_indicator_" + str_identifier, 1);
	wait(0.1);
}

/*
	Name: function_3be5a506
	Namespace: namespace_5c160465
	Checksum: 0xA10C61B9
	Offset: 0x2A90
	Size: 0x15A
	Parameters: 1
	Flags: Linked
*/
function function_3be5a506(str_identifier)
{
	clientfield::set("portal_map_gas_indicator_" + str_identifier, 0);
	switch(str_identifier)
	{
		case "hash_25be9190acbc94af":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_green");
			break;
		}
		case "hash_7a8b4e50820270d2":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_yellow");
			break;
		}
		case "hash_a673b6d22213365":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_obrien");
			break;
		}
		case "hash_472f084dd231c176":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_reinsel");
			break;
		}
		case "hash_488591c68794105c":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_hammond");
			break;
		}
		case "hash_43a1e2c04be12ea6":
		{
			exploder::stop_exploder("fxexp_toxic_gas_house_hoggatt");
			break;
		}
	}
}

/*
	Name: function_2fc11fb8
	Namespace: namespace_5c160465
	Checksum: 0xB0A88A0C
	Offset: 0x2BF8
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function function_2fc11fb8()
{
	switch(level.var_bcaf8591)
	{
		case 0:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
		case 1:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
		case 2:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
		case 3:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
		case 4:
		{
			/#
				iprintlnbold("");
			#/
			break;
		}
	}
}

/*
	Name: function_503db3da
	Namespace: namespace_5c160465
	Checksum: 0x1C13698E
	Offset: 0x2D18
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_503db3da(str_identifier)
{
	if(level.var_d4a0b9f4[str_identifier][#"hash_5ec516364540f76a"] != #"active")
	{
		level.var_d4a0b9f4[str_identifier][#"hash_5ec516364540f76a"] = #"disabled";
	}
}

/*
	Name: function_5c4d70d4
	Namespace: namespace_5c160465
	Checksum: 0x8B1F5DA7
	Offset: 0x2D90
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_5c4d70d4(e_player)
{
	if(!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete"))
	{
		self sethintstring(#"hash_25ac72d1e45049ef");
	}
	else
	{
		self sethintstring(#"hash_71158766520dc432");
	}
	return 1;
}

/*
	Name: function_802c4c74
	Namespace: namespace_5c160465
	Checksum: 0xA5B0E47D
	Offset: 0x2E40
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_802c4c74()
{
	s_unitrigger = self zm_unitrigger::create(&function_5c4d70d4, 64);
	self thread function_778aec95();
}

/*
	Name: function_53ffbb2e
	Namespace: namespace_5c160465
	Checksum: 0x78BDD2CC
	Offset: 0x2E98
	Size: 0x290
	Parameters: 1
	Flags: Linked
*/
function function_53ffbb2e(var_cf2bbe1e)
{
	var_eef18fbd = [];
	var_eef18fbd[#"zombie_location"] = [];
	var_eef18fbd[#"dog_location"] = [];
	var_b72ab239 = var_cf2bbe1e + "_spawn";
	var_eef18fbd[#"zombie_location"] = struct::get_array(var_b72ab239, "targetname");
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		if(var_ab611263[#"gas_cloud"].script_string == var_cf2bbe1e)
		{
			var_3e91e4d2 = var_ab611263[#"gas_cloud"].script_noteworthy;
			foreach(s_loc in level.zm_loc_types[#"dog_location"])
			{
				if(s_loc.zone_name == var_3e91e4d2)
				{
					if(!isdefined(var_eef18fbd[#"dog_location"]))
					{
						var_eef18fbd[#"dog_location"] = [];
					}
					else if(!isarray(var_eef18fbd[#"dog_location"]))
					{
						var_eef18fbd[#"dog_location"] = array(var_eef18fbd[#"dog_location"]);
					}
					var_eef18fbd[#"dog_location"][var_eef18fbd[#"dog_location"].size] = s_loc;
				}
			}
		}
	}
	return var_eef18fbd;
}

/*
	Name: function_778aec95
	Namespace: namespace_5c160465
	Checksum: 0x6AC67BE8
	Offset: 0x3130
	Size: 0x3B6
	Parameters: 0
	Flags: Linked
*/
function function_778aec95()
{
	self.var_a1edb69e = 0;
	while(self.var_a1edb69e < 10)
	{
		var_bd1bdc73 = undefined;
		var_bd1bdc73 = self waittill(#"trigger_activated");
		e_who = var_bd1bdc73.e_who;
		var_3ba1f680 = 1;
		var_f1c779a7 = self.script_string + "_" + self.script_int;
		while(var_3ba1f680 && (!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete")))
		{
			if(isdefined(e_who))
			{
				e_who clientfield::increment_to_player("vent_interact_feedback", 1);
			}
			var_3ba1f680 = 1;
			if(!e_who usebuttonpressed() || !zm_utility::can_use(e_who) || !isdefined(self.s_unitrigger) || !isdefined(self.s_unitrigger.trigger) || !e_who istouching(self.s_unitrigger.trigger))
			{
				var_3ba1f680 = 0;
				break;
			}
			if(self.var_a1edb69e == 0)
			{
				self function_8a3b2065(var_f1c779a7);
			}
			self.var_a1edb69e = self.var_a1edb69e + 1;
			level.var_d4a0b9f4[var_f1c779a7][#"hash_3524befbbbbe0afe"] thread function_c5552e49(self.var_a1edb69e);
			playsoundatposition(#"hash_49d9da44ea86bf03", self.origin);
			/#
				var_847964c = floor(self.var_a1edb69e / 10 * 100);
				var_ca13796a = level function_b822e13(self.script_string);
				iprintlnbold(var_ca13796a + "" + var_847964c + "");
			#/
			wait(1);
			if(self.var_a1edb69e >= 10)
			{
				if(level.var_bcaf8591 == 0 && !level flag::get(#"hash_1643995c3d7501b0"))
				{
					e_who namespace_509a75d1::function_51b752a9("vox_generic_responses_positive");
				}
				self function_27a8604b(level.var_d4a0b9f4[var_f1c779a7][#"group"]);
				/#
					iprintlnbold(var_ca13796a + "");
				#/
				var_3ba1f680 = 0;
				break;
			}
		}
	}
}

/*
	Name: function_b822e13
	Namespace: namespace_5c160465
	Checksum: 0x6796291F
	Offset: 0x34F0
	Size: 0xCA
	Parameters: 1
	Flags: None
*/
function function_b822e13(str_identifier)
{
	switch(str_identifier)
	{
		case "hash_7a8b4e50820270d2":
		{
			return "Yellow House";
			break;
		}
		case "hash_25be9190acbc94af":
		{
			return "Green House";
			break;
		}
		case "hash_43a1e2c04be12ea6":
		{
			return "Transfusion Facility";
			break;
		}
		case "hash_488591c68794105c":
		{
			return "Prisoner Holding";
			break;
		}
		case "hash_472f084dd231c176":
		{
			return "APD Interrogation";
			break;
		}
		case "hash_a673b6d22213365":
		{
			return "Broken Arrow Operations";
			break;
		}
	}
}

/*
	Name: function_c5552e49
	Namespace: namespace_5c160465
	Checksum: 0xD5EAC936
	Offset: 0x35C8
	Size: 0x19A
	Parameters: 1
	Flags: Linked
*/
function function_c5552e49(n_step)
{
	if(n_step >= 10)
	{
		self function_38fa21c2();
		return 1;
	}
	if(n_step >= 9)
	{
		self function_f8f62327();
		return 1;
	}
	if(n_step >= 8)
	{
		self function_9c8e6a55();
		return 1;
	}
	if(n_step >= 7)
	{
		self function_8b5047d9();
		return 1;
	}
	if(n_step >= 6)
	{
		self function_d20c5554();
		return 1;
	}
	if(n_step >= 5)
	{
		self function_aecd0ed6();
		return 1;
	}
	if(n_step >= 4)
	{
		self function_6374f823();
		return 1;
	}
	if(n_step >= 3)
	{
		self function_523ad5af();
		return 1;
	}
	if(n_step >= 2)
	{
		self function_791ea376();
		return 1;
	}
	if(n_step >= 1)
	{
		self function_75c79cc8();
		return 1;
	}
}

/*
	Name: function_7103a97e
	Namespace: namespace_5c160465
	Checksum: 0x743D8D1A
	Offset: 0x3770
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_7103a97e()
{
	playsoundatposition(#"hash_3fc59a2ac3e3a5b9", (0, 0, 0));
	wait(0.5);
	level namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d("vox_air_vent_repair", 0, 0);
	thread namespace_509a75d1::function_fd24e47f("vox_air_vent_repair_react", -1, 0, 1);
}

/*
	Name: function_d81c4786
	Namespace: namespace_5c160465
	Checksum: 0xFA4351B0
	Offset: 0x3810
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function function_d81c4786()
{
	level thread function_7103a97e();
	for(i = 0; i < 4; i++)
	{
		var_cde7175c = level function_10671c7e(0);
		if(isdefined(var_cde7175c))
		{
			var_e09dd0ac = var_cde7175c[#"gas_cloud"].script_string + "_" + var_cde7175c[#"gas_cloud"].script_int;
			level function_7b706d1d(var_e09dd0ac);
			foreach(var_ab611263 in level.var_d4a0b9f4)
			{
				if(var_ab611263[#"group"] == var_cde7175c[#"group"] && var_ab611263[#"hash_5ec516364540f76a"] == #"disabled")
				{
					var_ab611263[#"hash_5ec516364540f76a"] = #"complete";
				}
			}
			continue;
		}
		i = i - 1;
	}
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		if(var_ab611263[#"hash_5ec516364540f76a"] != #"active")
		{
			var_ab611263[#"hash_3524befbbbbe0afe"] function_c58562f9();
			var_ab611263[#"hash_3524befbbbbe0afe"] function_38fa21c2();
		}
	}
	level thread function_993de6f7();
	level function_2fc11fb8();
}

/*
	Name: function_d16d4153
	Namespace: namespace_5c160465
	Checksum: 0xC5462E2C
	Offset: 0x3AC8
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d16d4153()
{
	self notify(#"hash_3ffd1d32bfb3738c");
}

/*
	Name: function_78d01716
	Namespace: namespace_5c160465
	Checksum: 0xD5D83F7F
	Offset: 0x3AE8
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_78d01716()
{
	self endon(#"death", #"hash_3ffd1d32bfb3738c");
	while(true)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(self))
			{
				players[i] status_effect::status_effect_apply(function_4d1e7b48(#"hash_1b824ff143d6ba43"), undefined, players[i], 1);
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_2b6db5eb
	Namespace: namespace_5c160465
	Checksum: 0x1C6212BD
	Offset: 0x3BE8
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_2b6db5eb()
{
	n_players = zm_utility::get_number_of_valid_players();
	var_111a6185 = 2;
	if(n_players == 2)
	{
		var_111a6185 = 3;
	}
	else if(n_players > 2)
	{
		var_111a6185 = 5;
	}
	n_round = namespace_a28acff3::get_round_number();
	var_453a5b46 = 0;
	if(n_round > 50)
	{
		var_453a5b46 = 2;
	}
	else if(n_round > 25)
	{
		var_453a5b46 = 1.5;
	}
	else if(n_round > 15)
	{
		var_453a5b46 = 1;
	}
	n_spawn_count = floor(var_111a6185 + var_453a5b46 * n_players);
	return n_spawn_count;
}

/*
	Name: function_8a3b2065
	Namespace: namespace_5c160465
	Checksum: 0x9E55A8E
	Offset: 0x3CF0
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_8a3b2065(var_f1c779a7)
{
	level.var_d4a0b9f4[var_f1c779a7][#"spawn_points"] = function_53ffbb2e(self.script_string);
	level thread function_2dfe81a1(var_f1c779a7);
}

/*
	Name: function_5bb49d44
	Namespace: namespace_5c160465
	Checksum: 0x7C253696
	Offset: 0x3D60
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_5bb49d44()
{
	self notify(#"hash_462324f983b236df");
	var_f1c779a7 = self.script_string + "_" + self.script_int;
}

/*
	Name: function_27a8604b
	Namespace: namespace_5c160465
	Checksum: 0x4B088B92
	Offset: 0x3DA8
	Size: 0x4DC
	Parameters: 1
	Flags: Linked
*/
function function_27a8604b(str_identifier)
{
	foreach(var_ab611263 in level.var_d4a0b9f4)
	{
		if(var_ab611263[#"group"] == str_identifier)
		{
			var_ab611263[#"hash_5ec516364540f76a"] = #"complete";
		}
	}
	level.var_bcaf8591 = level.var_bcaf8591 + 1;
	level thread function_2fc11fb8();
	playsoundatposition(#"hash_4a67e67e0a9d6df9", (0, 0, 0));
	if(level.var_bcaf8591 >= 4)
	{
		var_680128c2 = namespace_a28acff3::get_round_number();
		level.var_154aee78 = var_680128c2 + randomintrange(3, 5);
		if(level.var_154aee78 === level.next_dog_round)
		{
			level.var_154aee78 = level.var_154aee78 + 1;
		}
		/#
			iprintln("" + level.var_154aee78);
		#/
		level.var_7a86ba58 function_ccc74648("string_06");
	}
	if(!level flag::get(#"hash_1643995c3d7501b0"))
	{
		if(level.var_bcaf8591 >= 4)
		{
			if(level.var_154aee78 < 16)
			{
				level.var_154aee78 = 13 + randomintrange(3, 5);
				if(level.var_154aee78 === level.next_dog_round)
				{
					level.var_154aee78 = level.var_154aee78 + 1;
				}
			}
			level thread function_751e9580();
			level flag::set(#"hash_1643995c3d7501b0");
			level thread function_1fef0f43();
			level.var_7a86ba58 function_ccc74648("string_06");
			level thread function_bd2bb73a();
			level.var_39984142 = namespace_a28acff3::get_round_number() + 1;
			level thread function_b990c084();
		}
		level thread function_5be4c9e4(4 - level.var_bcaf8591);
	}
	else
	{
		switch(level.var_bcaf8591)
		{
			case 1:
			{
				level thread function_5be4c9e4(3);
				break;
			}
			case 2:
			{
				level thread function_5be4c9e4(2);
				break;
			}
			case 3:
			{
				level thread function_5be4c9e4(1);
				break;
			}
			case 4:
			{
				level thread function_1fef0f43();
				level thread function_5be4c9e4(0);
				level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_7305313894f05e93", 0, 0);
				break;
			}
		}
	}
	level thread function_1d0bb4d1(self.script_string);
	level thread function_3be5a506(self.script_string);
	level zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_b990c084
	Namespace: namespace_5c160465
	Checksum: 0x2649277E
	Offset: 0x4290
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_b990c084()
{
	while(level.var_39984142 > namespace_a28acff3::get_round_number())
	{
		wait(1);
	}
	namespace_ee206246::start(#"hash_290a78ab47105457");
}

/*
	Name: function_bd2bb73a
	Namespace: namespace_5c160465
	Checksum: 0x4522763E
	Offset: 0x42F0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_bd2bb73a()
{
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_66d4e14752453ba5", 0, 0);
	level namespace_509a75d1::function_3c173d37();
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_66d4e047524539f2", 0, 0, 1);
	level namespace_509a75d1::function_3c173d37();
	level namespace_509a75d1::function_fd24e47f("vox_air_vent_repaired_react", -1, 0, 1);
}

/*
	Name: function_993de6f7
	Namespace: namespace_5c160465
	Checksum: 0xCC8D1BCD
	Offset: 0x43B8
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function function_993de6f7()
{
	if(isdefined(level.var_2b94ce72) && level.var_2b94ce72 || (isdefined(level.var_5e45f817) && level.var_5e45f817))
	{
		return;
	}
	if(getplayers().size > 2)
	{
		n_to_spawn = 12;
	}
	else if(getplayers().size > 1)
	{
		n_to_spawn = 9;
	}
	else
	{
		n_to_spawn = 6;
	}
	n_spawned = 0;
	exploder::exploder("fxexp_jolting_jack_fx");
	wait(3);
	while(level.var_bcaf8591 < 4 && n_spawned < n_to_spawn)
	{
		s_spawn_loc = undefined;
		var_63cf6c7b = 0;
		while(isdefined(level.intermission) && level.intermission)
		{
			var_63cf6c7b = 1;
			wait(1);
		}
		if(var_63cf6c7b)
		{
			level waittill(#"zombie_total_set");
		}
		var_a1ef7f29 = level.zm_loc_types[#"hash_605a47238f0057ac"];
		if(isdefined(s_spawn_loc))
		{
			arrayremovevalue(var_a1ef7f29, s_spawn_loc);
		}
		if(var_a1ef7f29.size > 0)
		{
			s_spawn_loc = array::random(var_a1ef7f29);
		}
		if(isdefined(s_spawn_loc) && !level flag::get("mee_round"))
		{
			ai = zombie_utility::spawn_zombie(level.ranged_nova_crawler_spawner);
			if(isdefined(ai))
			{
				n_spawned = n_spawned + 1;
				level.zombie_total = level.zombie_total + 1;
				ai playsound(#"hash_27b6a39054ad63ec");
				ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
				ai namespace_f9871db2::function_dc0238e4();
				wait(6);
			}
		}
		wait(1);
	}
	exploder::stop_exploder("fxexp_jolting_jack_fx");
}

/*
	Name: function_ba63b9ed
	Namespace: namespace_5c160465
	Checksum: 0x5D467E1
	Offset: 0x46A0
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function function_ba63b9ed(s_params)
{
	if(self.archetype === #"zombie" && self.var_a0baa27d === 1 && level.var_c3ee1c6e > level.var_48ff1185)
	{
		if(namespace_c3287616::function_40229072(namespace_a28acff3::get_round_number()))
		{
			level.zombie_total = level.zombie_total - 1;
		}
		level.var_48ff1185 = level.var_48ff1185 + 1;
		if(level.var_48ff1185 >= level.var_c3ee1c6e)
		{
			level callback::remove_on_ai_spawned(&function_3e2137a4);
			level callback::remove_on_ai_killed(&function_ba63b9ed);
			level flag::clear(#"hash_68ac76bb578976f1");
		}
	}
}

/*
	Name: function_2dfe81a1
	Namespace: namespace_5c160465
	Checksum: 0xFEA5505
	Offset: 0x47C8
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function function_2dfe81a1(var_f1c779a7)
{
	if(!level flag::get(#"hash_68ac76bb578976f1"))
	{
		level flag::set(#"hash_68ac76bb578976f1");
		level callback::on_ai_spawned(&function_3e2137a4);
		level callback::on_ai_killed(&function_ba63b9ed);
	}
	n_to_spawn = level function_2b6db5eb();
	for(i = 0; i < n_to_spawn; i++)
	{
		s_spawn_point = level function_9c35a6e7(var_f1c779a7);
		ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
		if(isdefined(ai))
		{
			level.var_c3ee1c6e = level.var_c3ee1c6e + 1;
			level.zombie_total = level.zombie_total + 1;
			ai.var_a0baa27d = 1;
			ai.ignore_enemy_count = 1;
			ai.exclude_cleanup_adding_to_total = 1;
		}
		wait(0.1);
	}
}

/*
	Name: function_3e2137a4
	Namespace: namespace_5c160465
	Checksum: 0x2F48DB7A
	Offset: 0x4980
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_3e2137a4()
{
	waitframe(2);
	if(self.archetype == #"zombie" && self.var_a0baa27d === 1)
	{
		self namespace_f9871db2::function_850768d1();
	}
}

/*
	Name: function_9c35a6e7
	Namespace: namespace_5c160465
	Checksum: 0x5DA5F1EA
	Offset: 0x49D8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_9c35a6e7(var_f1c779a7)
{
	return array::random(level.var_d4a0b9f4[var_f1c779a7][#"spawn_points"][#"zombie_location"]);
}

/*
	Name: function_751e9580
	Namespace: namespace_5c160465
	Checksum: 0x1B13B440
	Offset: 0x4A30
	Size: 0x5C4
	Parameters: 0
	Flags: Linked
*/
function function_751e9580()
{
	level endon(#"hash_48039f3a4c1a3248");
	while(level.var_154aee78 > namespace_a28acff3::get_round_number() || (isdefined(level.intermission) && level.intermission))
	{
		wait(1);
	}
	level waittill(#"zombie_total_set");
	if(level.var_154aee78 <= namespace_a28acff3::get_round_number() && level.var_bcaf8591 > 0 && (!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete")))
	{
		n_zombie_count = level.var_38b15968;
		var_26d4dd52 = floor(randomfloatrange(floor(n_zombie_count / 5), floor(n_zombie_count * 2 / 3)));
		while(level.var_9427911d > var_26d4dd52)
		{
			wait(1);
		}
		if(level.var_154aee78 <= namespace_a28acff3::get_round_number())
		{
			var_680128c2 = namespace_a28acff3::get_round_number();
			var_d62bc957 = 1;
			playsoundatposition(#"hash_3fc59a2ac3e3a5b9", (0, 0, 0));
			waitframe(1);
			var_cde7175c = level function_10671c7e(1);
			var_e09dd0ac = var_cde7175c[#"gas_cloud"].script_string + "_" + var_cde7175c[#"gas_cloud"].script_int;
			level.var_bcaf8591 = level.var_bcaf8591 - 1;
			level function_7b706d1d(var_e09dd0ac);
			level.var_7a86ba58 function_ccc74648("string_05");
			waitframe(1);
			level namespace_9cf755b::function_2389bb7a("zmb_goop_repair_fail");
			switch(level.var_bcaf8591)
			{
				case 0:
				{
					level thread function_5be4c9e4(4);
					level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_3ed78c28756a66f", 0, 0);
					namespace_509a75d1::function_fd24e47f("vox_air_vent_repair", -1, 1);
					break;
				}
				case 1:
				{
					level thread function_5be4c9e4(3);
					level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_3ed78c28756a66f", 0, 0);
					namespace_509a75d1::function_fd24e47f("vox_air_vent_repair", -1, 1);
					break;
				}
				case 2:
				{
					level thread function_5be4c9e4(2);
					level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_3ed78c28756a66f", 0, 0);
					namespace_509a75d1::function_fd24e47f("vox_air_vent_repair", -1, 1);
					break;
				}
				case 3:
				{
					level thread function_85644731();
					level thread function_5be4c9e4(1);
					level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_48d01436dc5c21bb", 0, 0);
					var_e29c5f3b = function_21a3a673(1, 2);
					namespace_509a75d1::function_fd24e47f("vox_air_vent_repair", var_e29c5f3b, 1);
					level thread namespace_9cf755b::function_2389bb7a("zmb_goop_pap_locked");
					break;
				}
			}
		}
		var_680128c2 = namespace_a28acff3::get_round_number();
		level.var_154aee78 = var_680128c2 + 1;
	}
	else
	{
		level.var_154aee78 = namespace_a28acff3::get_round_number() + 1;
	}
	level thread function_751e9580();
}

/*
	Name: function_85644731
	Namespace: namespace_5c160465
	Checksum: 0xF2F2CD5D
	Offset: 0x5000
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_85644731()
{
	/#
		iprintlnbold("");
	#/
	if(isdefined(level.pack_a_punch))
	{
		level.pack_a_punch.trigger_stubs[0].pap_machine flag::wait_till("pap_waiting_for_user");
	}
	level flag::clear("pap_power_ready");
}

/*
	Name: function_1fef0f43
	Namespace: namespace_5c160465
	Checksum: 0xA0367D04
	Offset: 0x5098
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_1fef0f43()
{
	if(!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete"))
	{
		level thread namespace_9cf755b::function_2389bb7a("zmb_goop_pap_unlocked");
		/#
			iprintlnbold("");
		#/
		level flag::set(#"pap_power_ready");
	}
}

/*
	Name: function_1605f69a
	Namespace: namespace_5c160465
	Checksum: 0xA50F7E5D
	Offset: 0x5150
	Size: 0xA0
	Parameters: 0
	Flags: None
*/
function function_1605f69a()
{
	/#
		iprintlnbold("");
	#/
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 function_d12682c5();
	}
}

/*
	Name: function_94cdb242
	Namespace: namespace_5c160465
	Checksum: 0x5DAC472D
	Offset: 0x51F8
	Size: 0xE8
	Parameters: 0
	Flags: None
*/
function function_94cdb242()
{
	if(!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete"))
	{
		/#
			iprintlnbold("");
		#/
		foreach(var_5baafbb2 in level.var_76a7ad28)
		{
			var_5baafbb2 function_f6ac524d();
		}
	}
}

/*
	Name: function_cd39be3
	Namespace: namespace_5c160465
	Checksum: 0xEC31F535
	Offset: 0x52E8
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function function_cd39be3()
{
	/#
		iprintlnbold("");
		iprintlnbold("");
	#/
	var_c718a93c = level namespace_1846c963::function_688df525();
	foreach(s_portal in var_c718a93c)
	{
		s_portal thread namespace_1846c963::function_978923cd();
		s_portal.b_active = 0;
		waitframe(1);
		s_portal thread namespace_1846c963::function_16ccd69f();
	}
}

/*
	Name: function_ab8edf2c
	Namespace: namespace_5c160465
	Checksum: 0x5A9C67E5
	Offset: 0x53E8
	Size: 0x118
	Parameters: 0
	Flags: None
*/
function function_ab8edf2c()
{
	if(!level flag::get(#"hash_1478cafcd626c361") || level flag::get(#"circuit_step_complete"))
	{
		/#
			iprintlnbold("");
		#/
		var_c718a93c = level namespace_1846c963::function_688df525();
		foreach(s_portal in var_c718a93c)
		{
			s_portal.b_active = 1;
			waitframe(1);
			s_portal thread namespace_1846c963::function_16ccd69f();
		}
	}
}

/*
	Name: function_8f9249e9
	Namespace: namespace_5c160465
	Checksum: 0xB1F0D7AF
	Offset: 0x5508
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_8f9249e9()
{
	/#
		iprintlnbold("");
	#/
	level namespace_9cf755b::function_6f635c39("bunker_power_event_storage");
	level namespace_9cf755b::function_6f635c39("bunker_power_event_solitary");
}

/*
	Name: function_19e428bc
	Namespace: namespace_5c160465
	Checksum: 0x13D25A27
	Offset: 0x5578
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_19e428bc()
{
	/#
		iprintlnbold("");
	#/
	level namespace_9cf755b::function_364cd8c0("bunker_power_event_storage");
	level namespace_9cf755b::function_364cd8c0("bunker_power_event_solitary");
}

/*
	Name: function_f6ac524d
	Namespace: namespace_5c160465
	Checksum: 0x121906D8
	Offset: 0x55E8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_f6ac524d()
{
	self zm_perks::function_a30c73b9("on");
	if(isdefined(self.var_a0fc37f6))
	{
		self.prompt_and_visibility_func = self.var_a0fc37f6;
		self.var_a0fc37f6 = undefined;
	}
	if(isdefined(self.var_492080a5))
	{
		self.trigger_func = self.var_492080a5;
		self.var_492080a5 = undefined;
	}
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_d12682c5
	Namespace: namespace_5c160465
	Checksum: 0xE84CCB47
	Offset: 0x5670
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_d12682c5()
{
	self zm_perks::function_a30c73b9("off");
	if(!isdefined(self.var_a0fc37f6))
	{
		self.var_a0fc37f6 = self.prompt_and_visibility_func;
	}
	self.prompt_and_visibility_func = &function_c03c3007;
	if(!isdefined(self.var_492080a5))
	{
		self.var_492080a5 = self.trigger_func;
	}
	self.trigger_func = &function_713b8131;
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_c03c3007
	Namespace: namespace_5c160465
	Checksum: 0x84B16666
	Offset: 0x5710
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_c03c3007(e_player)
{
	self sethintstring(#"hash_5f2758a66286e12f");
	return 1;
}

/*
	Name: function_713b8131
	Namespace: namespace_5c160465
	Checksum: 0x5969B8F1
	Offset: 0x5748
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_713b8131(e_player)
{
	while(true)
	{
		waitframe(1);
	}
}

/*
	Name: function_2791c411
	Namespace: namespace_5c160465
	Checksum: 0x95B9981E
	Offset: 0x5770
	Size: 0x2F8
	Parameters: 0
	Flags: Linked
*/
function function_2791c411()
{
	level flag::init(#"hash_40856b65dff0f6eb");
	level flag::init(#"hash_639e8274a1b57729");
	level flag::init(#"hash_5cdee936ef283689");
	level.var_ddcd74c6 = &function_f79e10f9;
	s_switch = struct::get("crawler_switch", "targetname");
	wait(1);
	level.var_9c82c58d = 0.2;
	level.var_dc337f29 = getentarray("mask_chamber", "targetname");
	level namespace_9cf755b::function_6f635c39("bunker_power_event_storage");
	level namespace_9cf755b::function_6f635c39("bunker_power_event_solitary");
	level flag::wait_till(#"power_on1");
	level thread function_feab1e8a();
	callback::on_ai_spawned(&function_96c2cbb3);
	var_4aad2831 = getentarray("pre_power_gas", "targetname");
	level thread function_c70d673e(var_4aad2831);
	level exploder::exploder("fxexp_toxic_gas_corridor");
	var_48c6775f = getentarray("green_gas_lg", "targetname");
	level exploder::exploder("fxexp_toxic_gas_bunker");
	if(!(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2 || namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 2))
	{
		level flag::wait_till(#"bunker_beds_to_bunker_power");
	}
	level.var_9808f4d = zombie_utility::function_d2dfacfd(#"hash_7d5a25e2463f7fc5");
	while(!level flag::get(#"hash_40856b65dff0f6eb"))
	{
		level function_2330b278();
	}
}

/*
	Name: function_feab1e8a
	Namespace: namespace_5c160465
	Checksum: 0x7EA5C85E
	Offset: 0x5A70
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_feab1e8a()
{
	level clientfield::set("" + #"hash_1c11f70bb8445095", 4);
	level.var_7a86ba58 function_ccc74648("string_01");
}

/*
	Name: function_5be4c9e4
	Namespace: namespace_5c160465
	Checksum: 0xD81B0345
	Offset: 0x5AD8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_5be4c9e4(var_49c1a8cf)
{
	level clientfield::set("" + #"hash_1c11f70bb8445095", var_49c1a8cf);
}

/*
	Name: function_f79e10f9
	Namespace: namespace_5c160465
	Checksum: 0xD6D6E5DE
	Offset: 0x5B20
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_f79e10f9(e_door)
{
	if(e_door.script_flag === "bunker_power_event")
	{
		e_door sethintstring(#"hash_42a58f21fe6769a4");
	}
	else
	{
		e_door sethintstring(#"hash_71158766520dc432");
	}
}

/*
	Name: function_71753169
	Namespace: namespace_5c160465
	Checksum: 0x1E9EA504
	Offset: 0x5B98
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_71753169(var_65500f70)
{
	str_zone = self zm_zonemgr::get_player_zone();
	if(str_zone == "zone_bunker_power_1" || str_zone == "zone_bunker_power_2")
	{
		var_65500f70 = [];
	}
	return var_65500f70;
}

/*
	Name: function_8d7b02b0
	Namespace: namespace_5c160465
	Checksum: 0x88FBAB50
	Offset: 0x5C00
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_8d7b02b0()
{
	level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_4e0bf2b29c38452f", 0, 0);
	level thread namespace_509a75d1::function_fd24e47f("vox_generator_defend", -1, 1);
}

/*
	Name: function_75cb64de
	Namespace: namespace_5c160465
	Checksum: 0xF3458B1D
	Offset: 0x5C68
	Size: 0x2E
	Parameters: 5
	Flags: Linked
*/
function function_75cb64de(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 0;
}

/*
	Name: function_dba114b7
	Namespace: namespace_5c160465
	Checksum: 0x4D281C65
	Offset: 0x5CA0
	Size: 0x30
	Parameters: 5
	Flags: Linked
*/
function function_dba114b7(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 10;
}

/*
	Name: function_2330b278
	Namespace: namespace_5c160465
	Checksum: 0x3035CBA1
	Offset: 0x5CD8
	Size: 0xE7C
	Parameters: 0
	Flags: Linked
*/
function function_2330b278()
{
	level endon(#"hash_7ae5a07827985e98");
	s_switch = struct::get("crawler_switch", "targetname");
	s_unitrigger = s_switch zm_unitrigger::create(&function_d4e24379, 64);
	s_switch thread function_748fcb3c();
	level flag::wait_till(#"hash_639e8274a1b57729");
	level.var_72581f75 = [];
	foreach(s_loc in level.zm_loc_types[#"zombie_location"])
	{
		if(s_loc.zone_name == #"zone_bunker_power_1" || s_loc.zone_name == #"zone_bunker_power_2")
		{
			if(!isdefined(level.var_72581f75))
			{
				level.var_72581f75 = [];
			}
			else if(!isarray(level.var_72581f75))
			{
				level.var_72581f75 = array(level.var_72581f75);
			}
			level.var_72581f75[level.var_72581f75.size] = s_loc;
		}
	}
	level.var_58eee1ff = [];
	foreach(s_loc in level.zm_loc_types[#"zombie_location"])
	{
		if(s_loc.zone_name == #"zone_bunker_power_1" || s_loc.zone_name == #"zone_bunker_power_2")
		{
			if(s_loc.var_683460c9 === 1)
			{
				if(!isdefined(level.var_58eee1ff))
				{
					level.var_58eee1ff = [];
				}
				else if(!isarray(level.var_58eee1ff))
				{
					level.var_58eee1ff = array(level.var_58eee1ff);
				}
				level.var_58eee1ff[level.var_58eee1ff.size] = s_loc;
			}
		}
	}
	level.var_6e616641 = [];
	foreach(s_loc in level.zm_loc_types[#"dog_location"])
	{
		if(s_loc.zone_name == #"zone_bunker_power_1" || s_loc.zone_name == #"zone_bunker_power_2")
		{
			if(!isdefined(level.var_6e616641))
			{
				level.var_6e616641 = [];
			}
			else if(!isarray(level.var_6e616641))
			{
				level.var_6e616641 = array(level.var_6e616641);
			}
			level.var_6e616641[level.var_6e616641.size] = s_loc;
		}
	}
	s_switch.s_unitrigger zm_unitrigger::unregister_unitrigger(s_unitrigger);
	while(isdefined(level.intermission) && level.intermission)
	{
		wait(1);
	}
	exploder::exploder("fxexp_script_power_room_gas_event");
	exploder::exploder("fxexp_script_power_room_gas_event_intermediate");
	level.var_14eba0b3 = 2;
	var_5341234e = getentarray("event_green_gas_lg", "targetname");
	if(var_5341234e.size > 0)
	{
		foreach(var_530a0f2e in var_5341234e)
		{
			var_530a0f2e.fx_handle = util::spawn_model("tag_origin", var_530a0f2e.origin);
			var_530a0f2e.fx_handle.angles = var_530a0f2e.angles;
			var_530a0f2e.fx_handle clientfield::set("white_event_gas_lg_vent_clientfield", 1);
		}
	}
	var_cc5e1906 = getentarray("event_green_gas_md", "targetname");
	if(var_cc5e1906.size > 0)
	{
		foreach(var_530a0f2e in var_cc5e1906)
		{
			var_530a0f2e.fx_handle = util::spawn_model("tag_origin", var_530a0f2e.origin);
			var_530a0f2e.fx_handle.angles = var_530a0f2e.angles;
			var_530a0f2e.fx_handle clientfield::set("white_event_gas_MD_clientfield", 1);
		}
	}
	level.old_dog_spawn = level.var_819e7dfd[#"zombie_dog"].var_87ed2709;
	level.var_ce4d36df = level.zombie_total;
	level.var_9291cfb3 = #"zombie_dog";
	level.var_819e7dfd[#"zombie_dog"].var_87ed2709 = &function_e2260632;
	level.var_dc22f98 = level.fn_custom_round_ai_spawn;
	level.fn_custom_round_ai_spawn = &function_cc062056;
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	level.var_382a24b0 = 1;
	/#
		iprintlnbold("");
	#/
	playsoundatposition(#"hash_22f33ce72be33eab", (0, -334, -337));
	wait(6);
	exploder::stop_exploder("fxexp_script_power_room_gas_event_intermediate");
	var_d1ef124f = 0;
	var_bb655cde = 0;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		foreach(var_7b52a014 in level.var_dc337f29)
		{
			if(players[i] istouching(var_7b52a014) && !players[i] laststand::player_is_in_laststand())
			{
				var_d1ef124f = 1;
				var_bb655cde = var_bb655cde + 1;
			}
		}
	}
	if(var_bb655cde < players.size)
	{
		level function_6acd363d(0);
	}
	level namespace_9cf755b::function_6f635c39("bunker_power_event_beds");
	level namespace_9cf755b::function_6f635c39("bunker_power_event_storage");
	level namespace_9cf755b::function_6f635c39("bunker_power_event_solitary");
	level.var_7a86ba58 function_ccc74648("string_03");
	level.a_func_score_events[#"damage_points"] = &function_75cb64de;
	level.a_func_score_events[#"death"] = &function_dba114b7;
	level thread function_8d7b02b0();
	level.var_e120ae98 = &function_71753169;
	level.var_eeb98313 = &function_71753169;
	level.var_63fca02d[#"portal_power"] thread namespace_1846c963::function_978923cd();
	level.var_63fca02d[#"portal_power"].b_active = 0;
	waitframe(1);
	level.var_63fca02d[#"portal_power"] thread namespace_1846c963::function_16ccd69f(0);
	zm_unitrigger::unregister_unitrigger(level.var_63fca02d[#"portal_power"].s_unitrigger);
	wait(5);
	if(!(isdefined(level.var_5e45f817) && level.var_5e45f817 || (isdefined(level.var_2b94ce72) && level.var_2b94ce72)))
	{
		foreach(s_spawn in level.var_58eee1ff)
		{
			level zombie_utility::spawn_zombie(level.nova_crawler_spawner, undefined, s_spawn);
			wait(0.1);
		}
	}
	level.zones[#"zone_bunker_power_1"].adjacent_zones[#"zone_bunker_beds_1"].is_connected = 0;
	level.zones[#"zone_bunker_power_2"].adjacent_zones[#"zone_bunker_beds_2"].is_connected = 0;
	level.var_4a31d48a = 0;
	level.var_f9c3678e = 0;
	zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", level.var_9808f4d * 0.75);
	/#
		iprintlnbold("");
	#/
	level thread function_4ea7c90a();
	var_4aad2831 = getentarray("power_room_gas", "targetname");
	level thread function_ec9a1827(var_4aad2831);
	wait(15);
	level.var_9c82c58d = 0.5;
	wait(15);
	/#
		iprintlnbold("");
	#/
	level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_56c42fa94656e07b", 0, 0);
	zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", level.var_9808f4d * 0.5);
	level.var_9c82c58d = 0.8;
	wait(30);
	/#
		iprintlnbold("");
	#/
	level function_6acd363d(1);
}

/*
	Name: function_748fcb3c
	Namespace: namespace_5c160465
	Checksum: 0x53FE4646
	Offset: 0x6B60
	Size: 0x21A
	Parameters: 0
	Flags: Linked
*/
function function_748fcb3c()
{
	is_complete = 0;
	while(!is_complete)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		var_5a9db060 = 1;
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			is_touching = 0;
			foreach(var_7b52a014 in level.var_dc337f29)
			{
				if(players[i] istouching(var_7b52a014) && !players[i] laststand::player_is_in_laststand())
				{
					is_touching = 1;
				}
			}
			if(!is_touching)
			{
				var_5a9db060 = 0;
			}
		}
		if(var_5a9db060)
		{
			is_complete = 1;
			level.var_7a86ba58 function_ccc74648("string_02");
			playsoundatposition("evt_gen_terminal_interact", self.origin);
			level.musicsystemoverride = 1;
			music::setmusicstate("generator_defend");
			level flag::set(#"hash_639e8274a1b57729");
			s_switch = struct::get("crawler_switch", "targetname");
		}
	}
}

/*
	Name: function_d4e24379
	Namespace: namespace_5c160465
	Checksum: 0x819B1174
	Offset: 0x6D88
	Size: 0x1B8
	Parameters: 1
	Flags: Linked
*/
function function_d4e24379(e_player)
{
	var_5a9db060 = 1;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		is_touching = 0;
		foreach(var_7b52a014 in level.var_dc337f29)
		{
			if(players[i] istouching(var_7b52a014) && !players[i] laststand::player_is_in_laststand())
			{
				is_touching = 1;
			}
		}
		if(!is_touching)
		{
			var_5a9db060 = 0;
		}
	}
	if(var_5a9db060)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_276fd5b98fead0c4");
			return 1;
		}
		self sethintstring(#"hash_544ec9f3ae2423c8");
		return 1;
	}
	self sethintstring(#"hash_2101bfc49f49de46");
	return 1;
}

/*
	Name: function_6acd363d
	Namespace: namespace_5c160465
	Checksum: 0x4B293F56
	Offset: 0x6F50
	Size: 0x96C
	Parameters: 1
	Flags: Linked
*/
function function_6acd363d(is_completed)
{
	/#
		if(!is_completed)
		{
			iprintlnbold("");
		}
	#/
	level.var_e120ae98 = undefined;
	level.var_eeb98313 = undefined;
	level.var_63fca02d[#"portal_power"] namespace_1846c963::function_97d4ad50();
	if(level.var_63fca02d[#"portal_power"].var_59aa5add === 1)
	{
		level.var_63fca02d[#"portal_power"].b_active = 1;
		waitframe(1);
		if(level.var_868c98df === 0)
		{
			level.var_63fca02d[#"portal_power"] namespace_1846c963::function_16ccd69f();
		}
	}
	level callback::remove_on_ai_spawned(&function_96c2cbb3);
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.var_382a24b0 = undefined;
	level.a_func_score_events[#"damage_points"] = undefined;
	level.a_func_score_events[#"death"] = undefined;
	a_e_enemies = getaiteamarray(level.zombie_team);
	if(a_e_enemies.size > 0)
	{
		foreach(e_enemy in a_e_enemies)
		{
			e_enemy zm_score::function_acaab828(1);
		}
	}
	level.fn_custom_round_ai_spawn = level.var_dc22f98;
	level.var_dc22f98 = undefined;
	level.var_819e7dfd[#"zombie_dog"].var_87ed2709 = level.old_dog_spawn;
	zombie_utility::set_zombie_var(#"hash_7d5a25e2463f7fc5", level.var_9808f4d);
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	level.zombie_total = 0;
	var_5341234e = getentarray("event_green_gas_lg", "targetname");
	foreach(var_530a0f2e in var_5341234e)
	{
		if(isdefined(var_530a0f2e.fx_handle))
		{
			var_530a0f2e.fx_handle delete();
		}
	}
	if(is_completed)
	{
		level thread namespace_3e3742fd::function_dd616fdd();
		level.var_bf802299 = 0;
		level thread callback::on_actor_killed(&function_7ca1064d);
		namespace_c3287616::function_376e51ef(#"nova_crawler", namespace_a28acff3::get_round_number());
		playsoundatposition(#"hash_70c11b6f27e8119e", (0, -334, -337));
		level.var_7a86ba58 function_ccc74648("string_05");
		level exploder::stop_exploder("fxexp_toxic_gas_corridor");
		var_cc5e1906 = getentarray("event_green_gas_md", "targetname");
		foreach(var_530a0f2e in var_cc5e1906)
		{
			if(isdefined(var_530a0f2e.fx_handle))
			{
				var_530a0f2e.fx_handle delete();
			}
		}
		level flag::set(#"hash_40856b65dff0f6eb");
		exploder::stop_exploder("fxexp_toxic_gas_power_vent");
		wait(1.5);
		level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_45611e2b5750e320", 0, 0);
		wait(1);
		exploder::stop_exploder("fxexp_script_power_room_gas_event");
		level namespace_9cf755b::function_364cd8c0("bunker_power_event_beds");
		zm_zonemgr::enable_zone("zone_bunker_storage");
		zm_zonemgr::enable_zone("zone_bunker_solitary");
		level namespace_9cf755b::function_364cd8c0("bunker_power_event_storage");
		level namespace_9cf755b::function_364cd8c0("bunker_power_event_solitary");
		level flag::set(#"hash_16b68e037e570465");
		level zm_power::turn_power_on_and_open_doors(3);
		level namespace_9cf755b::function_612918d9("bunker_door_solitary_blocker");
		level namespace_9cf755b::function_612918d9("bunker_door_storage_blocker");
		namespace_9cf755b::function_364cd8c0("apd_lockdown");
		namespace_9cf755b::function_f2fa71ce();
		zm_zonemgr::enable_zone("zone_bunker_apd");
		level function_d81c4786();
		level exploder::stop_exploder("fxexp_toxic_gas_bunker");
	}
	else
	{
		exploder::stop_exploder("fxexp_script_power_room_gas_event");
		level namespace_9cf755b::function_364cd8c0("bunker_power_event_beds");
		zm_zonemgr::enable_zone("zone_bunker_storage");
		zm_zonemgr::enable_zone("zone_bunker_solitary");
		var_4aad2831 = getentarray("power_room_gas", "targetname");
		foreach(var_677ba5c4 in var_4aad2831)
		{
			var_677ba5c4 notify(#"hash_3ffd1d32bfb3738c");
		}
		level thread function_79f7d595();
		playsoundatposition(#"hash_409e21a8cc122b1f", (0, -334, -337));
		wait(2);
		level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_213e287fc814959d", 0, 0);
		level flag::clear(#"hash_639e8274a1b57729");
		level notify(#"hash_7ae5a07827985e98");
		s_switch = struct::get("crawler_switch", "targetname");
		waitframe(1);
		level.var_7a86ba58 function_ccc74648("string_01");
	}
}

/*
	Name: function_7ca1064d
	Namespace: namespace_5c160465
	Checksum: 0xDD4D667F
	Offset: 0x78C8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_7ca1064d(s_params)
{
	if(isplayer(s_params.eattacker) && level.var_bf802299 === 0)
	{
		level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
		level.var_bf802299 = 1;
		wait(5);
		callback::remove_on_actor_killed(&function_7ca1064d);
	}
}

/*
	Name: function_696a0eca
	Namespace: namespace_5c160465
	Checksum: 0x5773183B
	Offset: 0x7978
	Size: 0x3CE
	Parameters: 0
	Flags: None
*/
function function_696a0eca()
{
	var_e6da0a39 = 0;
	while(level flag::get(#"hash_639e8274a1b57729") && !level flag::get(#"hash_40856b65dff0f6eb"))
	{
		var_d1ef124f = 0;
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			foreach(var_7b52a014 in level.var_dc337f29)
			{
				if(players[i] istouching(var_7b52a014) && !players[i] laststand::player_is_in_laststand())
				{
					var_d1ef124f = 1;
					if(var_e6da0a39 > 0)
					{
						level.var_7a86ba58 function_ccc74648("string_03");
					}
					var_e6da0a39 = 0;
				}
			}
		}
		if(!var_d1ef124f)
		{
			switch(var_e6da0a39)
			{
				case 0:
				{
					level.var_8200dc81 namespace_509a75d1::function_6a0d675d(#"hash_737e2502279778f5", 0, 0);
					level.var_7a86ba58 function_ccc74648("strong_04");
					break;
				}
				case 1:
				{
					level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_737e23022797758f", 0, 0);
					break;
				}
				case 2:
				{
					level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_737e2202279773dc", 0, 0);
					break;
				}
				case 3:
				{
					level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_737e210227977229", 0, 0);
					break;
				}
				case 4:
				{
					level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_737e200227977076", 0, 0);
					break;
				}
				case 5:
				{
					level.var_8200dc81 thread namespace_509a75d1::function_6a0d675d(#"hash_737e1f0227976ec3", 0, 0);
					break;
				}
			}
			var_e6da0a39 = var_e6da0a39 + 1;
			if(var_e6da0a39 > 5)
			{
				level function_6acd363d(0);
			}
			/#
				if(var_e6da0a39 < 5)
				{
					n_time_remaining = 5 - var_e6da0a39;
					iprintlnbold("" + n_time_remaining + "");
				}
			#/
		}
		wait(1);
	}
}

/*
	Name: function_d39f2f3e
	Namespace: namespace_5c160465
	Checksum: 0xCACE608F
	Offset: 0x7D50
	Size: 0x2D2
	Parameters: 0
	Flags: Linked
*/
function function_d39f2f3e()
{
	var_619e4cd6 = zm_zonemgr::get_players_in_zone(#"zone_bunker_power_1");
	var_619e4cd6 = var_619e4cd6 + zm_zonemgr::get_players_in_zone(#"zone_bunker_power_2");
	var_6bfcea24 = level.activeplayers.size - var_619e4cd6;
	var_619e4cd6 = var_619e4cd6 * 2;
	var_fdf44034 = var_619e4cd6 + var_6bfcea24;
	var_29c6d263 = var_619e4cd6 / var_fdf44034;
	s_spawn_loc = array::random(level.zm_loc_types[#"dog_location"]);
	if(var_6bfcea24 > 0)
	{
		var_eb3b90d = [];
		foreach(s_spawn in level.zm_loc_types[#"dog_location"])
		{
			if(s_spawn.zone_name != #"zone_bunker_power_1" && s_spawn.zone_name != #"zone_bunker_power_2")
			{
				if(!isdefined(var_eb3b90d))
				{
					var_eb3b90d = [];
				}
				else if(!isarray(var_eb3b90d))
				{
					var_eb3b90d = array(var_eb3b90d);
				}
				if(!isinarray(var_eb3b90d, s_spawn))
				{
					var_eb3b90d[var_eb3b90d.size] = s_spawn;
				}
			}
		}
		if(var_eb3b90d.size > 0)
		{
			s_spawn_loc = array::random(var_eb3b90d);
		}
		else
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"dog_location"]);
		}
	}
	n_chance = randomfloat(1);
	if(n_chance <= var_29c6d263 && level.var_6e616641.size > 0)
	{
		s_spawn_loc = array::random(level.var_6e616641);
	}
	return s_spawn_loc;
}

/*
	Name: function_cc0dec67
	Namespace: namespace_5c160465
	Checksum: 0x91635083
	Offset: 0x8030
	Size: 0x36A
	Parameters: 0
	Flags: Linked
*/
function function_cc0dec67()
{
	var_619e4cd6 = 0;
	foreach(e_player in level.players)
	{
		if(e_player.zone_name === #"zone_bunker_power_1" || e_player.zone_name === #"zone_bunker_power_2")
		{
			var_619e4cd6 = var_619e4cd6 + 1;
		}
	}
	var_6bfcea24 = level.activeplayers.size - var_619e4cd6;
	var_619e4cd6 = var_619e4cd6 * 2;
	var_fdf44034 = var_619e4cd6 + var_6bfcea24;
	var_29c6d263 = var_619e4cd6 / var_fdf44034;
	s_spawn_loc = array::random(level.zm_loc_types[#"zombie_location"]);
	if(var_6bfcea24 > 0)
	{
		var_eb3b90d = [];
		foreach(s_spawn in level.zm_loc_types[#"zombie_location"])
		{
			if(s_spawn.zone_name != #"zone_bunker_power_1" && s_spawn.zone_name != #"zone_bunker_power_2")
			{
				if(!isdefined(var_eb3b90d))
				{
					var_eb3b90d = [];
				}
				else if(!isarray(var_eb3b90d))
				{
					var_eb3b90d = array(var_eb3b90d);
				}
				if(!isinarray(var_eb3b90d, s_spawn))
				{
					var_eb3b90d[var_eb3b90d.size] = s_spawn;
				}
			}
		}
		if(var_eb3b90d.size > 0)
		{
			s_spawn_loc = array::random(var_eb3b90d);
		}
		else
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"zombie_location"]);
		}
	}
	s_spawn_loc.var_d15183fd = 0;
	n_chance = randomfloat(1);
	if(n_chance <= var_29c6d263 && level.var_72581f75.size > 0 || level.var_14eba0b3 > 0)
	{
		s_spawn_loc = array::random(level.var_72581f75);
		s_spawn_loc.var_d15183fd = 1;
	}
	return s_spawn_loc;
}

/*
	Name: function_428035a
	Namespace: namespace_5c160465
	Checksum: 0x9037C48D
	Offset: 0x83A8
	Size: 0x1EA
	Parameters: 0
	Flags: Linked
*/
function function_428035a()
{
	s_spawn_point = level function_cc0dec67();
	var_3b8ab239 = randomfloat(1);
	if(level.var_14eba0b3 > 0)
	{
		var_3b8ab239 = 0;
	}
	if(var_3b8ab239 < 0.33 && s_spawn_point.var_d15183fd === 1 && (!(isdefined(level.var_5e45f817) && level.var_5e45f817 || (isdefined(level.var_2b94ce72) && level.var_2b94ce72))))
	{
		var_b912d513 = arraycombine(zm_zonemgr::get_players_in_zone(#"zone_bunker_power_1", 1), zm_zonemgr::get_players_in_zone(#"zone_bunker_power_2", 1), 0, 0);
		target_player = array::random(var_b912d513);
		if(isdefined(target_player))
		{
			ai = function_ff73da7f(target_player);
			if(isdefined(ai) && level.var_14eba0b3 > 0)
			{
				level.var_14eba0b3 = level.var_14eba0b3 - 1;
			}
		}
	}
	else
	{
		ai = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, s_spawn_point);
	}
	return ai;
}

/*
	Name: function_cc062056
	Namespace: namespace_5c160465
	Checksum: 0xEAFE1933
	Offset: 0x85A0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_cc062056()
{
	ai = level function_428035a();
	wait(namespace_a28acff3::get_zombie_spawn_delay(namespace_a28acff3::get_round_number()));
	if(isdefined(ai))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e2260632
	Namespace: namespace_5c160465
	Checksum: 0xD54AD6E6
	Offset: 0x8608
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_e2260632()
{
	if(level.var_9291cfb3 === #"zombie_dog" || level.var_ce4d36df <= 0)
	{
		level.var_9291cfb3 = #"zombie";
		ai = level function_428035a();
	}
	else
	{
		ai = namespace_c402654::function_62db7b1c(0, level function_d39f2f3e());
		level.var_9291cfb3 = #"zombie_dog";
		if(isdefined(ai))
		{
			level.var_ce4d36df = level.var_ce4d36df - 1;
		}
	}
	if(isdefined(ai))
	{
		level.zombie_total = level.zombie_total + 1;
	}
	return ai;
}

/*
	Name: function_96c2cbb3
	Namespace: namespace_5c160465
	Checksum: 0x5C1A6F06
	Offset: 0x8710
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_96c2cbb3()
{
	waitframe(2);
	if(self.archetype === #"zombie" && level flag::get(#"hash_639e8274a1b57729") && !level flag::get(#"hash_40856b65dff0f6eb") && level.var_14eba0b3 <= 0)
	{
		if(randomfloat(1) > level.var_9c82c58d)
		{
			self namespace_f9871db2::function_850768d1();
		}
	}
}

/*
	Name: function_c70d673e
	Namespace: namespace_5c160465
	Checksum: 0x9AEDBE4D
	Offset: 0x87E0
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_c70d673e(var_4aad2831)
{
	foreach(var_677ba5c4 in var_4aad2831)
	{
		var_677ba5c4 thread function_130bfe4();
	}
	level flag::wait_till(#"hash_40856b65dff0f6eb");
	foreach(var_677ba5c4 in var_4aad2831)
	{
		if(isdefined(var_677ba5c4))
		{
			var_677ba5c4 delete();
		}
		exploder::exploder("fxexp_ground_fog_bunker_on");
	}
}

/*
	Name: function_ec9a1827
	Namespace: namespace_5c160465
	Checksum: 0xE0195027
	Offset: 0x8918
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function function_ec9a1827(var_4aad2831)
{
	self notify("138d9059508423a7");
	self endon("138d9059508423a7");
	foreach(var_677ba5c4 in var_4aad2831)
	{
		var_677ba5c4 thread function_130bfe4();
	}
	level flag::wait_till(#"hash_40856b65dff0f6eb");
	foreach(var_677ba5c4 in var_4aad2831)
	{
		var_677ba5c4 delete();
		exploder::exploder("fxexp_ground_fog_bunker_on");
	}
}

/*
	Name: function_130bfe4
	Namespace: namespace_5c160465
	Checksum: 0x94B6184E
	Offset: 0x8A60
	Size: 0x140
	Parameters: 0
	Flags: Linked, Private
*/
private function function_130bfe4()
{
	self endon(#"death", #"hash_3ffd1d32bfb3738c");
	while(true)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(self))
			{
				players[i] status_effect::status_effect_apply(function_4d1e7b48(#"hash_1b824ff143d6ba43"), undefined, players[i], 1);
				if(!isdefined(level.var_8a15167f))
				{
					players[i] thread namespace_509a75d1::function_51b752a9("vox_nova_gas_encounter", -1, 1);
					level.var_8a15167f = 1;
				}
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_4ea7c90a
	Namespace: namespace_5c160465
	Checksum: 0x8073E858
	Offset: 0x8BA8
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_4ea7c90a()
{
	var_936b6ed5 = getentarray("power_room_fan", "targetname");
	exploder::exploder("fxexp_toxic_gas_power_vent");
	level flag::set(#"hash_5cdee936ef283689");
	foreach(var_e6ad66ce in var_936b6ed5)
	{
		var_e6ad66ce thread function_20e43aae();
	}
}

/*
	Name: function_79f7d595
	Namespace: namespace_5c160465
	Checksum: 0xB11FF6F5
	Offset: 0x8C88
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_79f7d595()
{
	var_936b6ed5 = getentarray("power_room_fan", "targetname");
	exploder::stop_exploder("fxexp_toxic_gas_power_vent");
	level flag::clear(#"hash_5cdee936ef283689");
}

/*
	Name: function_217e3c0f
	Namespace: namespace_5c160465
	Checksum: 0xFB92756
	Offset: 0x8CF8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_217e3c0f()
{
	level flag::clear(#"hash_5cdee936ef283689");
}

/*
	Name: function_4b72fed8
	Namespace: namespace_5c160465
	Checksum: 0xA7EA8C80
	Offset: 0x8D28
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_4b72fed8()
{
	level flag::set(#"hash_5cdee936ef283689");
}

/*
	Name: function_3fc75ca6
	Namespace: namespace_5c160465
	Checksum: 0x5536F31
	Offset: 0x8D58
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_3fc75ca6()
{
	s_generator = struct::get("main_generator", "targetname");
	s_generator thread scene::play("shot 1");
	level flag::wait_till(#"hash_639e8274a1b57729");
	wait(5);
	s_generator thread scene::play("shot 2");
	level clientfield::set("generator_sound_sweetner", 1);
}

/*
	Name: function_20e43aae
	Namespace: namespace_5c160465
	Checksum: 0x7F7093E9
	Offset: 0x8E18
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_20e43aae()
{
	self endon(#"death");
	var_8ada9d = -720;
	var_f63ac386 = 2;
	var_e03da92 = 10;
	level flag::wait_till(#"hash_5cdee936ef283689");
	self rotatevelocity((0, 0, var_8ada9d), var_f63ac386, var_f63ac386, 0);
	self playloopsound(#"hash_3c2abf1f67d713e4");
	wait(var_f63ac386);
	while(level flag::get(#"hash_5cdee936ef283689"))
	{
		self rotatevelocity((0, 0, var_8ada9d), 1);
		wait(1);
	}
	self rotatevelocity((0, 0, var_8ada9d), var_e03da92, 0, var_e03da92);
	self stoploopsound();
	self function_20e43aae();
}

/*
	Name: function_f3f325cb
	Namespace: namespace_5c160465
	Checksum: 0x2EAE45EE
	Offset: 0x8F88
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_f3f325cb(var_148cc603)
{
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	return int(0.1 * level.var_38b15968);
}

/*
	Name: function_b448360c
	Namespace: namespace_5c160465
	Checksum: 0x853AFC55
	Offset: 0x8FE8
	Size: 0x32E
	Parameters: 0
	Flags: Linked
*/
function function_b448360c()
{
	a_s_spawn_locs = level.zm_loc_types[#"dog_location"];
	if(!isdefined(a_s_spawn_locs) || a_s_spawn_locs.size < 1)
	{
		return 0;
	}
	var_905a9429 = [];
	var_51fb0ec7 = [];
	e_target = namespace_509a75d1::function_3815943c();
	if(isplayer(self.last_closest_player))
	{
		e_target = self.last_closest_player;
	}
	if(!isdefined(e_target))
	{
		return 0;
	}
	foreach(loc in a_s_spawn_locs)
	{
		var_e3c2bfe4 = distancesquared(loc.origin, e_target.origin);
		if(var_e3c2bfe4 < 9000000)
		{
			if(var_e3c2bfe4 > 250000)
			{
				if(!isdefined(var_51fb0ec7))
				{
					var_51fb0ec7 = [];
				}
				else if(!isarray(var_51fb0ec7))
				{
					var_51fb0ec7 = array(var_51fb0ec7);
				}
				var_51fb0ec7[var_51fb0ec7.size] = loc;
				continue;
			}
			if(var_e3c2bfe4 > 10000)
			{
				if(!isdefined(var_905a9429))
				{
					var_905a9429 = [];
				}
				else if(!isarray(var_905a9429))
				{
					var_905a9429 = array(var_905a9429);
				}
				var_905a9429[var_905a9429.size] = loc;
			}
		}
	}
	if(var_905a9429.size < 3)
	{
		var_905a9429 = arraycombine(var_905a9429, var_51fb0ec7, 0, 0);
	}
	s_spawn_loc = array::random(var_905a9429);
	if(!isdefined(s_spawn_loc))
	{
		return 0;
	}
	if(isentity(self))
	{
		self namespace_e0710ee6::function_a8dc3363(s_spawn_loc);
		self ghost();
		var_e1e4facc = s_spawn_loc function_13f107c4(self, s_spawn_loc);
		if(isdefined(var_e1e4facc) && !var_e1e4facc)
		{
			return 0;
		}
	}
	if(isdefined(self.var_b421bafe) && self.var_b421bafe)
	{
		function_c33d4387();
		self.var_b421bafe = 0;
		self.no_powerups = 0;
	}
	return 1;
}

/*
	Name: function_c33d4387
	Namespace: namespace_5c160465
	Checksum: 0x14A01C82
	Offset: 0x9320
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c33d4387()
{
	if(isdefined(self.var_3fc4c097))
	{
		self.var_3fc4c097 thread function_46aa5dda();
		self.var_3fc4c097 = undefined;
	}
}

/*
	Name: function_46aa5dda
	Namespace: namespace_5c160465
	Checksum: 0xAE06B06F
	Offset: 0x9360
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
private function function_46aa5dda()
{
	wait(randomfloatrange(4, 5));
	self.is_claimed = undefined;
}

/*
	Name: function_a409c2a7
	Namespace: namespace_5c160465
	Checksum: 0x93DFD97F
	Offset: 0x9390
	Size: 0x4BE
	Parameters: 1
	Flags: Linked
*/
function function_a409c2a7(e_target)
{
	if(namespace_df88241c::function_4748fb49() >= namespace_df88241c::function_59257d57())
	{
		return undefined;
	}
	if(isdefined(level.zm_loc_types[#"dog_location"]) && level.zm_loc_types[#"dog_location"].size > 0)
	{
		var_d45dac2a = e_target zm_zonemgr::get_player_zone();
		if(!isdefined(var_d45dac2a))
		{
			return undefined;
		}
		var_c61e7ea7 = level.zones[var_d45dac2a];
		adj_zone_names = getarraykeys(var_c61e7ea7.adjacent_zones);
		var_2057a8c1 = array(var_c61e7ea7.name);
		foreach(zone_name in adj_zone_names)
		{
			if(var_c61e7ea7.adjacent_zones[zone_name].is_connected)
			{
				if(!isdefined(var_2057a8c1))
				{
					var_2057a8c1 = [];
				}
				else if(!isarray(var_2057a8c1))
				{
					var_2057a8c1 = array(var_2057a8c1);
				}
				var_2057a8c1[var_2057a8c1.size] = level.zones[zone_name].name;
			}
		}
		var_905a9429 = [];
		var_51fb0ec7 = [];
		foreach(loc in level.zm_loc_types[#"dog_location"])
		{
			if(array::contains(var_2057a8c1, loc.zone_name))
			{
				var_e3c2bfe4 = distancesquared(loc.origin, e_target.origin);
				if(var_e3c2bfe4 < 9000000)
				{
					if(var_e3c2bfe4 > 250000)
					{
						if(!isdefined(var_905a9429))
						{
							var_905a9429 = [];
						}
						else if(!isarray(var_905a9429))
						{
							var_905a9429 = array(var_905a9429);
						}
						var_905a9429[var_905a9429.size] = loc;
						continue;
					}
					if(var_e3c2bfe4 > 10000)
					{
						if(!isdefined(var_51fb0ec7))
						{
							var_51fb0ec7 = [];
						}
						else if(!isarray(var_51fb0ec7))
						{
							var_51fb0ec7 = array(var_51fb0ec7);
						}
						var_51fb0ec7[var_51fb0ec7.size] = loc;
					}
				}
			}
		}
		if(var_905a9429.size < 3)
		{
			var_905a9429 = arraycombine(var_905a9429, var_51fb0ec7, 0, 0);
		}
		s_spawn_loc = array::random(var_905a9429);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.ranged_nova_crawler_spawner);
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		ai ghost();
		s_spawn_loc thread function_13f107c4(ai, s_spawn_loc);
		ai.favoriteenemy = e_target;
	}
	return ai;
}

/*
	Name: function_45bb11e4
	Namespace: namespace_5c160465
	Checksum: 0xE4E57420
	Offset: 0x9858
	Size: 0x444
	Parameters: 1
	Flags: Linked
*/
function function_45bb11e4(spot)
{
	self endon_callback(&zm_spawner::function_fe3cb19a, #"death");
	self.var_5535a47d = 1;
	self zm_spawner::function_fe3cb19a();
	self.mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
	self ghost();
	if(!isdefined(spot.angles))
	{
		spot.angles = (0, 0, 0);
	}
	self.mdl_anchor moveto(spot.origin, 0.05);
	self.mdl_anchor rotateto(spot.angles, 0.05);
	self.mdl_anchor waittill(#"movedone", #"death");
	waitframe(1);
	self.create_eyes = 1;
	self show();
	if(!isdefined(self.var_9ed3cc11))
	{
		self.var_9ed3cc11 = self function_e827fc0e();
	}
	self pushplayer(1);
	e_align = (isdefined(self.mdl_anchor) ? self.mdl_anchor : spot);
	if(self.archetype == #"nova_crawler")
	{
		if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), "nova_crawler"))
		{
			e_align scene::play(spot.scriptbundlename, "nova_crawler", self);
		}
		else
		{
			e_align scene::play(spot.scriptbundlename, self);
		}
	}
	else if(isdefined(self.has_legs) && !self.has_legs || (isdefined(self.var_eb91c296) && self.var_eb91c296))
	{
		if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), "crawler"))
		{
			e_align scene::play(spot.scriptbundlename, "crawler", self);
		}
		else
		{
			e_align scene::play(spot.scriptbundlename, self);
		}
	}
	else if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), "default"))
	{
		e_align scene::play(spot.scriptbundlename, "default", self);
	}
	else
	{
		e_align scene::play(spot.scriptbundlename, self);
	}
	if(isdefined(self.var_9ed3cc11))
	{
		self pushplayer(self.var_9ed3cc11);
		self.var_9ed3cc11 = undefined;
	}
	self.var_5535a47d = 0;
	self thread zm_spawner::function_2d97cae1();
	self notify(#"risen", spot.script_string);
	self zm_spawner::zombie_complete_emerging_into_playable_area();
}

/*
	Name: function_ff73da7f
	Namespace: namespace_5c160465
	Checksum: 0x57DBF0E7
	Offset: 0x9CA8
	Size: 0x5C0
	Parameters: 1
	Flags: Linked
*/
function function_ff73da7f(e_target)
{
	if(namespace_df88241c::function_4748fb49() >= namespace_df88241c::function_59257d57())
	{
		return undefined;
	}
	var_a887d6e1 = [];
	if(isdefined(level.zm_loc_types[#"crawl"]) && isdefined(level.zm_loc_types[#"hash_605a47238f0057ac"]))
	{
		a_locs = arraycombine(level.zm_loc_types[#"crawl"], level.zm_loc_types[#"hash_605a47238f0057ac"], 0, 0);
		foreach(loc in a_locs)
		{
			if(loc.var_683460c9)
			{
				if(!isdefined(var_a887d6e1))
				{
					var_a887d6e1 = [];
				}
				else if(!isarray(var_a887d6e1))
				{
					var_a887d6e1 = array(var_a887d6e1);
				}
				var_a887d6e1[var_a887d6e1.size] = loc;
			}
		}
	}
	if(var_a887d6e1.size > 0)
	{
		var_d45dac2a = e_target zm_zonemgr::get_player_zone();
		if(!isdefined(var_d45dac2a))
		{
			return undefined;
		}
		var_c61e7ea7 = level.zones[var_d45dac2a];
		adj_zone_names = getarraykeys(var_c61e7ea7.adjacent_zones);
		var_2057a8c1 = array(var_c61e7ea7.name);
		foreach(zone_name in adj_zone_names)
		{
			if(var_c61e7ea7.adjacent_zones[zone_name].is_connected)
			{
				if(!isdefined(var_2057a8c1))
				{
					var_2057a8c1 = [];
				}
				else if(!isarray(var_2057a8c1))
				{
					var_2057a8c1 = array(var_2057a8c1);
				}
				var_2057a8c1[var_2057a8c1.size] = level.zones[zone_name].name;
			}
		}
		var_905a9429 = [];
		var_51fb0ec7 = [];
		foreach(loc in var_a887d6e1)
		{
			if(array::contains(var_2057a8c1, loc.zone_name))
			{
				if(!isdefined(var_905a9429))
				{
					var_905a9429 = [];
				}
				else if(!isarray(var_905a9429))
				{
					var_905a9429 = array(var_905a9429);
				}
				var_905a9429[var_905a9429.size] = loc;
			}
		}
		s_spawn_loc = array::random(var_905a9429);
	}
	if(!isdefined(s_spawn_loc) || (isdefined(s_spawn_loc.var_2901f207) && s_spawn_loc.var_2901f207 && !level flag::get(#"hash_1643995c3d7501b0")))
	{
		return undefined;
	}
	if(isdefined(s_spawn_loc.var_2901f207) && s_spawn_loc.var_2901f207)
	{
		ai = zombie_utility::spawn_zombie(level.ranged_nova_crawler_spawner);
	}
	else
	{
		ai = zombie_utility::spawn_zombie(level.nova_crawler_spawner);
	}
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		if(isdefined(s_spawn_loc.var_11ef3e6e) && s_spawn_loc.var_11ef3e6e)
		{
			ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		}
		else
		{
			ai thread function_45bb11e4(s_spawn_loc);
		}
		ai.favoriteenemy = e_target;
		if(isdefined(s_spawn_loc.var_11ef3e6e) && s_spawn_loc.var_11ef3e6e)
		{
			ai namespace_f9871db2::function_dc0238e4();
		}
	}
	return ai;
}

/*
	Name: function_13f107c4
	Namespace: namespace_5c160465
	Checksum: 0x43B1644B
	Offset: 0xA270
	Size: 0x260
	Parameters: 2
	Flags: Linked
*/
function function_13f107c4(ai, ent)
{
	ai endon(#"death");
	ai val::set(#"hash_37e10c667b66c5a7", "allowdeath", 0);
	ai setfreecameralockonallowed(0);
	waitframe(1);
	ai clientfield::increment("crawler_portal_spawn_fx");
	playsoundatposition(#"evt_teleporter_go", ent.origin);
	if(isdefined(ai.favoriteenemy))
	{
		angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
		angles = (ai.angles[0], angle[1], ai.angles[2]);
	}
	else
	{
		angles = ent.angles;
	}
	ai dontinterpolate();
	ai forceteleport(ent.origin, angles);
	if(isdefined(ai) && isalive(ai))
	{
		ai val::reset(#"hash_37e10c667b66c5a7", "allowdeath");
		wait(0.1);
		ai show();
		ai setfreecameralockonallowed(1);
		ai val::reset(#"hash_37e10c667b66c5a7", "ignoreme");
		ai notify(#"spawn_complete");
		ai notify(#"visible");
		return 1;
	}
	return 0;
}

/*
	Name: function_dd836251
	Namespace: namespace_5c160465
	Checksum: 0xD536BFC5
	Offset: 0xA4D8
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_dd836251()
{
	e_target = namespace_df88241c::function_a5abd591();
	if(!isdefined(e_target))
	{
		return undefined;
	}
	ai = function_ff73da7f(e_target);
	if(isdefined(ai))
	{
		if(level.round_number < 10)
		{
			ai zombie_utility::set_zombie_run_cycle("run");
		}
		else if(level.round_number < 15)
		{
			if(math::cointoss(66))
			{
				ai zombie_utility::set_zombie_run_cycle("run");
			}
			else
			{
				ai zombie_utility::set_zombie_run_cycle("sprint");
			}
		}
		else
		{
			ai zombie_utility::set_zombie_run_cycle("sprint");
		}
	}
	return ai;
}

/*
	Name: function_ccdfa71b
	Namespace: namespace_5c160465
	Checksum: 0x2B11F79A
	Offset: 0xA5F0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_ccdfa71b()
{
	ai = function_dd836251();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_75309b09
	Namespace: namespace_5c160465
	Checksum: 0xD834D02E
	Offset: 0xA638
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function function_75309b09()
{
	ai = undefined;
	e_target = namespace_df88241c::function_a5abd591();
	var_4a106fbe = namespace_f9871db2::function_51e81aba(level.var_b389ecc9);
	if(math::cointoss(33) && isdefined(var_4a106fbe))
	{
		n_to_spawn = level.zm_loc_types[#"hash_605a47238f0057ac"].size;
		s_loc = array::random(level.zm_loc_types[#"hash_605a47238f0057ac"]);
		ai = zombie_utility::spawn_zombie(level.ranged_nova_crawler_spawner);
		if(isdefined(ai))
		{
			ai namespace_f9871db2::function_dc0238e4();
			ai forceteleport(s_loc.origin, s_loc.angles);
		}
	}
	else if(isdefined(e_target))
	{
		ai = function_a409c2a7(e_target);
	}
	if(isdefined(ai))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_39caf8c7
	Namespace: namespace_5c160465
	Checksum: 0x54DB0ACB
	Offset: 0xA7B0
	Size: 0xCA
	Parameters: 0
	Flags: None
*/
function function_39caf8c7()
{
	var_52f17dc9 = getentarray("soul_goo", "targetname");
	if(level.var_b085d90f < 28)
	{
		foreach(var_5535190e in var_52f17dc9)
		{
			var_5535190e function_dd7cd488();
		}
		level.var_b085d90f = level.var_b085d90f + 1;
	}
}

/*
	Name: function_dd7cd488
	Namespace: namespace_5c160465
	Checksum: 0xEC11328
	Offset: 0xA888
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_dd7cd488()
{
	var_a573a0b5 = self.origin[2];
	self movez(1, 1);
	wait(1);
}

/*
	Name: function_14121764
	Namespace: namespace_5c160465
	Checksum: 0xCD1BCB95
	Offset: 0xA8D8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_14121764()
{
	self.scene_ents[#"hash_51689f26a4262ba6"].fx_tag = util::spawn_model("tag_origin", self.scene_ents[#"hash_51689f26a4262ba6"].origin);
	self.scene_ents[#"hash_51689f26a4262ba6"].fx_tag.angles = self.scene_ents[#"hash_51689f26a4262ba6"].angles;
	playfxontag("maps/zm_white/fx8_toxic_gas_vent_machine", self.scene_ents[#"hash_51689f26a4262ba6"].fx_tag, "tag_origin");
}

/*
	Name: function_dddf8a79
	Namespace: namespace_5c160465
	Checksum: 0xEC072CF8
	Offset: 0xA9C8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_dddf8a79()
{
	if(!isdefined(self.scene_ents[#"hash_51689f26a4262ba6"]))
	{
		return undefined;
	}
	if(!isdefined(self.scene_ents[#"hash_51689f26a4262ba6"].fx_tag))
	{
		return undefined;
	}
	self.scene_ents[#"hash_51689f26a4262ba6"].fx_tag delete();
}

/*
	Name: function_c58562f9
	Namespace: namespace_5c160465
	Checksum: 0xD8269F60
	Offset: 0xAA60
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_c58562f9()
{
	self scene::play("init");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_red");
	self.scene_ents[#"hash_51689f26a4262ba6"] showpart("tag_light_green");
}

/*
	Name: function_b21c0682
	Namespace: namespace_5c160465
	Checksum: 0xE6612391
	Offset: 0xAAF0
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function function_b21c0682()
{
	self thread scene::play("start_goop");
	self.scene_ents[#"hash_51689f26a4262ba6"] showpart("tag_light_red");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_green");
	self function_14121764();
}

/*
	Name: function_d225557a
	Namespace: namespace_5c160465
	Checksum: 0xE0ACF32D
	Offset: 0xAB98
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_d225557a()
{
	self thread scene::play("gauge_00");
	self function_14121764();
}

/*
	Name: function_75c79cc8
	Namespace: namespace_5c160465
	Checksum: 0xC5788C1D
	Offset: 0xABE0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_75c79cc8()
{
	self scene::stop("gauge_00");
	self thread scene::play("gauge_01");
}

/*
	Name: function_791ea376
	Namespace: namespace_5c160465
	Checksum: 0x2F0E154F
	Offset: 0xAC30
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_791ea376()
{
	self scene::stop("gauge_01");
	self thread scene::play("gauge_02");
}

/*
	Name: function_523ad5af
	Namespace: namespace_5c160465
	Checksum: 0x9178DE8F
	Offset: 0xAC80
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_523ad5af()
{
	self scene::stop("gauge_02");
	self thread scene::play("gauge_03");
}

/*
	Name: function_6374f823
	Namespace: namespace_5c160465
	Checksum: 0x9D7063F2
	Offset: 0xACD0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_6374f823()
{
	self scene::stop("gauge_03");
	self thread scene::play("gauge_04");
}

/*
	Name: function_aecd0ed6
	Namespace: namespace_5c160465
	Checksum: 0x54ED1F08
	Offset: 0xAD20
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_aecd0ed6()
{
	self scene::stop("gauge_04");
	self thread scene::play("gauge_05");
}

/*
	Name: function_d20c5554
	Namespace: namespace_5c160465
	Checksum: 0x469FFAF8
	Offset: 0xAD70
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_d20c5554()
{
	self scene::stop("gauge_05");
	self thread scene::play("gauge_06");
}

/*
	Name: function_8b5047d9
	Namespace: namespace_5c160465
	Checksum: 0x35F48A8F
	Offset: 0xADC0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_8b5047d9()
{
	self scene::stop("gauge_06");
	self thread scene::play("gauge_07");
}

/*
	Name: function_9c8e6a55
	Namespace: namespace_5c160465
	Checksum: 0x151EB040
	Offset: 0xAE10
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_9c8e6a55()
{
	self scene::stop("gauge_07");
	self thread scene::play("gauge_08");
}

/*
	Name: function_f8f62327
	Namespace: namespace_5c160465
	Checksum: 0x14F9FB04
	Offset: 0xAE60
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f8f62327()
{
	self scene::stop("gauge_08");
	self thread scene::play("gauge_09");
}

/*
	Name: function_38fa21c2
	Namespace: namespace_5c160465
	Checksum: 0xFC8E0AE8
	Offset: 0xAEB0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_38fa21c2()
{
	self scene::stop("gauge_09");
	self thread scene::play("gauge_10");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_red");
	self.scene_ents[#"hash_51689f26a4262ba6"] showpart("tag_light_green");
	self function_dddf8a79();
}

/*
	Name: function_470af002
	Namespace: namespace_5c160465
	Checksum: 0x44A1236D
	Offset: 0xAF78
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_470af002()
{
	self scene::stop();
	self thread scene::play("regoop");
	self.scene_ents[#"hash_51689f26a4262ba6"] showpart("tag_light_red");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_green");
	self function_14121764();
}

/*
	Name: function_ff5c24a8
	Namespace: namespace_5c160465
	Checksum: 0x7072A7FE
	Offset: 0xB038
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_ff5c24a8()
{
	self scene::stop();
	self scene::play("stopped");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_red");
	self.scene_ents[#"hash_51689f26a4262ba6"] hidepart("tag_light_green");
	self function_dddf8a79();
}

/*
	Name: function_ccc74648
	Namespace: namespace_5c160465
	Checksum: 0x3C25B783
	Offset: 0xB0F8
	Size: 0x262
	Parameters: 1
	Flags: Linked
*/
function function_ccc74648(var_f9dc3b9d)
{
	switch(var_f9dc3b9d)
	{
		case "string_01":
		{
			self function_1bce0fd();
			self showpart("tag_string_01");
			exploder::exploder("fxexp_script_power_room_monitor_red");
			break;
		}
		case "string_02":
		{
			self function_1bce0fd();
			self showpart("tag_string_02");
			exploder::exploder("fxexp_script_power_room_monitor_yellow");
			break;
		}
		case "string_03":
		{
			self function_1bce0fd();
			self showpart("tag_string_03");
			exploder::exploder("fxexp_script_power_room_monitor_white");
			break;
		}
		case "string_04":
		{
			self function_1bce0fd();
			self showpart("tag_string_04");
			exploder::exploder("fxexp_script_power_room_monitor_red");
			break;
		}
		case "string_05":
		{
			self function_1bce0fd();
			self showpart("tag_string_05");
			exploder::exploder("fxexp_script_power_room_monitor_yellow");
			break;
		}
		case "string_06":
		{
			self function_1bce0fd();
			self showpart("tag_string_06");
			exploder::exploder("fxexp_script_power_room_monitor_green");
			break;
		}
	}
}

/*
	Name: function_1bce0fd
	Namespace: namespace_5c160465
	Checksum: 0x11655225
	Offset: 0xB368
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_1bce0fd()
{
	self hidepart("tag_string_01");
	self hidepart("tag_string_02");
	self hidepart("tag_string_03");
	self hidepart("tag_string_04");
	self hidepart("tag_string_05");
	self hidepart("tag_string_06");
	exploder::stop_exploder("fxexp_script_power_room_monitor_red");
	exploder::stop_exploder("fxexp_script_power_room_monitor_white");
	exploder::stop_exploder("fxexp_script_power_room_monitor_yellow");
	exploder::stop_exploder("fxexp_script_power_room_monitor_green");
}

/*
	Name: function_cb3e8fb9
	Namespace: namespace_5c160465
	Checksum: 0x18D36701
	Offset: 0xB498
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_cb3e8fb9()
{
	level.var_7a86ba58 = getent("vent_screen", "targetname");
}

/*
	Name: function_3698d819
	Namespace: namespace_5c160465
	Checksum: 0x4B670847
	Offset: 0xB4D0
	Size: 0xFE
	Parameters: 0
	Flags: None
*/
function function_3698d819()
{
	while(true)
	{
		level.var_7a86ba58 function_ccc74648("string_01");
		wait(10);
		level.var_7a86ba58 function_ccc74648("string_02");
		wait(10);
		level.var_7a86ba58 function_ccc74648("string_03");
		wait(10);
		level.var_7a86ba58 function_ccc74648("string_04");
		wait(10);
		level.var_7a86ba58 function_ccc74648("string_05");
		wait(10);
		level.var_7a86ba58 function_ccc74648("string_06");
		wait(10);
	}
}

