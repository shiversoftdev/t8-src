// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_33fd053376f47476;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_46cea9e5d4ef9e21;
#using script_4cc2542101cb7973;
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using script_7c62f55ce3a557ff;
#using script_7e59d7bba853fe4b;
#using script_b00fcbc28051f15;
#using script_b52a163973f339f;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_a9aa9d72;

/*
	Name: function_89f2df9
	Namespace: namespace_a9aa9d72
	Checksum: 0x30652922
	Offset: 0x968
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3478ed13fc9440e6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a9aa9d72
	Checksum: 0xC5BE85B7
	Offset: 0x9B0
	Size: 0x78C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	n_bits = getminbitcountfornum(3);
	clientfield::register("scriptmover", "" + #"hash_632f7bc0b1a15f71", 1, n_bits, "int");
	clientfield::register("scriptmover", "" + #"hash_4614e4fa180c79af", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_53586aa63ca15286", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_65da20412fcaf97e", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_65da20412fcaf97e", 1, 2, "int");
	clientfield::register("toplayer", "" + #"hash_7d4d423d8dabbee3", 1, getminbitcountfornum(10), "int");
	clientfield::register("toplayer", "" + #"hash_46bc4b451b7419bb", 1, getminbitcountfornum(3), "int");
	clientfield::register("toplayer", "" + #"hash_49fecafe0b5d6da4", 1, 2, "counter");
	clientfield::register("vehicle", "" + #"hash_584f13d0c8662647", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_584f13d0c8662647", 1, 1, "int");
	clientfield::register("vehicle", "" + #"hash_22ffb9cf999f16c0", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_22ffb9cf999f16c0", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_a51ae59006ab41b", 1, getminbitcountfornum(4), "int");
	clientfield::register("scriptmover", "" + #"hash_64f2dd36b17bf17", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_119729072e708651", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_3e506d7aedac6ae0", 1, getminbitcountfornum(10), "int");
	clientfield::register("actor", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int");
	clientfield::register("scriptmover", "" + #"hash_504d26c38b96651c", 1, getminbitcountfornum(10), "int");
	clientfield::register("vehicle", "" + #"hash_504d26c38b96651c", 1, getminbitcountfornum(10), "int");
	clientfield::register("scriptmover", "" + #"hash_7dc9331ef45ed81f", 1, getminbitcountfornum(10), "int");
	clientfield::register("scriptmover", "" + #"hash_7dc9341ef45ed9d2", 1, getminbitcountfornum(10), "int");
	clientfield::register("scriptmover", "" + #"hash_7dc9351ef45edb85", 1, getminbitcountfornum(10), "int");
	clientfield::register("actor", "" + #"hash_7a8eab5597b25400", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_28a1a80b64f97e05", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_7f7790ca43a7fffe", 1, 1, "int");
	clientfield::register("world", "" + #"hash_437bd1912fc36607", 9000, 1, "int");
	if(zm_utility::function_e51dc2d8())
	{
		/#
			level thread function_96ac2d88();
		#/
	}
	level thread function_b247e756();
}

/*
	Name: function_b247e756
	Namespace: namespace_a9aa9d72
	Checksum: 0x987B8428
	Offset: 0x1148
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b247e756()
{
	level waittill(#"all_players_spawned");
	hidemiscmodels("rt_gh_sanim");
}

/*
	Name: function_307fdd13
	Namespace: namespace_a9aa9d72
	Checksum: 0xECAA841F
	Offset: 0x1188
	Size: 0x3A0
	Parameters: 1
	Flags: Linked
*/
function function_307fdd13(var_a276c861)
{
	if(var_a276c861)
	{
		var_328baab5 = struct::get_array("pa_po_pos", "targetname");
		foreach(var_1f5391d1 in var_328baab5)
		{
			var_aa11c23c = util::spawn_model("tag_origin", var_1f5391d1.origin, var_1f5391d1.angles);
			var_aa11c23c.script_string = var_1f5391d1.script_string;
			level thread namespace_69ddf44f::function_e998f810("tag_socket_a");
			level thread namespace_69ddf44f::function_e998f810("tag_socket_c");
			level thread namespace_69ddf44f::function_e998f810("tag_socket_d");
			level thread namespace_69ddf44f::function_e998f810("tag_socket_e");
			level thread namespace_69ddf44f::function_e998f810("tag_socket_g");
			var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
			exploder::exploder("fxexp_script_l_d");
			exploder::exploder("fxexp_script_l_c");
			exploder::exploder("fxexp_script_l_n_i");
			exploder::exploder("fxexp_script_l_s");
			exploder::exploder("fxexp_script_l_p_p");
			var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 1);
			waitframe(1);
			var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 0);
		}
	}
	else
	{
		zm::register_actor_damage_callback(&function_1d42763a);
		level clientfield::set("" + #"hash_437bd1912fc36607", 1);
		level.var_85cc9fcc = array("docks", "cellblock", "new_industries", "showers", "power_plant");
		level function_486ef0f6();
		level clientfield::set("" + #"hash_437bd1912fc36607", 0);
		level notify(#"hash_29b90ce9aa921f78");
	}
}

/*
	Name: function_486ef0f6
	Namespace: namespace_a9aa9d72
	Checksum: 0x2B9ADEBE
	Offset: 0x1530
	Size: 0xAA0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_486ef0f6()
{
	level endon(#"game_ended", #"hash_54eae43edf7f08cd");
	if(!isdefined(level.var_bbc27d0e))
	{
		var_c26c0a90 = struct::get("k_fx_pos", "targetname");
		level.var_bbc27d0e = util::spawn_model(#"hash_4c06bc763e373f0f", var_c26c0a90.origin, var_c26c0a90.angles);
	}
	var_a9b19429 = 0;
	while(level.var_85cc9fcc.size > 0)
	{
		if(!(isdefined(level.var_d486e9c4) && level.var_d486e9c4))
		{
			if(var_a9b19429)
			{
				level.var_bbc27d0e thread namespace_69ddf44f::function_9e723e9(3, 1);
			}
			level.var_bbc27d0e thread function_a9277243();
			level.var_bbc27d0e thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 2", level.var_bbc27d0e);
			level.var_bbc27d0e clientfield::set("" + #"hash_4614e4fa180c79af", 1);
			level.var_bbc27d0e waittill(#"hash_1f3cf68a268a10f1");
			level.var_bbc27d0e clientfield::set("" + #"hash_4614e4fa180c79af", 0);
			level.var_bbc27d0e thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 1", level.var_bbc27d0e);
		}
		var_aa11c23c = function_9f38c4a2();
		var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 1);
		switch(var_aa11c23c.script_string)
		{
			case "docks":
			{
				str_hint_text = #"hash_4213dc004145588f";
				break;
			}
			case "cellblock":
			{
				str_hint_text = #"hash_70fa5ff9f448bc96";
				break;
			}
			case "hash_38093b9299119ea0":
			{
				str_hint_text = #"hash_786af67b8225aaf4";
				break;
			}
			case "showers":
			{
				str_hint_text = #"hash_8a1754e2c346504";
				break;
			}
			case "power_plant":
			{
				str_hint_text = #"hash_7806b6b51cd2aed2";
				break;
			}
		}
		if(!(isdefined(level.var_d486e9c4) && level.var_d486e9c4))
		{
			level.var_99b333e1 = level function_23fa3cae();
			var_4894fd91 = "" + level.var_99b333e1[0] + level.var_99b333e1[1] + level.var_99b333e1[2];
			level thread function_c5319ebe();
			callback::on_connect(&function_c5319ebe);
			level thread function_5b7bbc40();
			while(true)
			{
				var_88706ea7 = undefined;
				var_88706ea7 = level waittill(#"hash_1ba800da972b0558");
				if(var_88706ea7.var_d46a1171 == var_4894fd91)
				{
					arrayremovevalue(level.var_d8e7f0cf, level.var_99b333e1);
					level thread function_b3df3f03();
					break;
				}
			}
		}
		var_aa11c23c thread namespace_69ddf44f::function_9e723e9();
		level thread function_9b1d9d6a();
		var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 1);
		if(!(isdefined(level.var_d486e9c4) && level.var_d486e9c4))
		{
			var_aa11c23c thread function_d3aa5310();
			var_88706ea7 = undefined;
			var_88706ea7 = var_aa11c23c waittill(#"hash_1726927392797d97", #"hash_6fd7f8e1f00deffe");
			if(var_88706ea7._notify == #"hash_1726927392797d97")
			{
				var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
				var_aa11c23c delete();
				var_a9b19429 = 1;
				continue;
			}
		}
		else
		{
			level.var_d486e9c4 = undefined;
			waitframe(1);
		}
		var_a9b19429 = 1;
		var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 0);
		s_beam = struct::get("s_p_s1_lh_r_light");
		s_beam.var_8999a4bf clientfield::set("" + #"hash_1f572bbcdde55d9d", 0);
		switch(var_aa11c23c.script_string)
		{
			case "docks":
			{
				var_aa11c23c.var_be009f9c = "tag_socket_g";
				var_81c75ce3 = "fxexp_script_l_d";
				var_aa11c23c thread function_b264ca4d();
				break;
			}
			case "cellblock":
			{
				var_aa11c23c.var_be009f9c = "tag_socket_e";
				var_81c75ce3 = "fxexp_script_l_c";
				var_aa11c23c thread function_2b37242f();
				break;
			}
			case "hash_38093b9299119ea0":
			{
				var_aa11c23c.var_be009f9c = "tag_socket_c";
				var_81c75ce3 = "fxexp_script_l_n_i";
				var_aa11c23c thread function_cdc8090a();
				break;
			}
			case "showers":
			{
				var_aa11c23c.var_be009f9c = "tag_socket_d";
				var_81c75ce3 = "fxexp_script_l_s";
				var_aa11c23c thread function_b80b6749();
				break;
			}
			case "power_plant":
			{
				var_aa11c23c.var_be009f9c = "tag_socket_a";
				var_81c75ce3 = "fxexp_script_l_p_p";
				var_aa11c23c thread function_c11e25eb();
				break;
			}
		}
		/#
			var_aa11c23c thread function_283daa98();
		#/
		var_88706ea7 = undefined;
		var_88706ea7 = var_aa11c23c waittill(#"hash_300e9fed7925cd69");
		if(isdefined(var_88706ea7.b_success) && var_88706ea7.b_success)
		{
			var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
			exploder::exploder(var_81c75ce3);
			foreach(e_player in util::get_active_players())
			{
				e_player clientfield::increment_to_player("" + #"hash_55539d0cf92a8855");
				e_player playrumbleonentity("damage_heavy");
			}
		}
		else
		{
			var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
			var_aa11c23c delete();
			if(!(isdefined(var_88706ea7.var_d0af61fc) && var_88706ea7.var_d0af61fc))
			{
				level waittill(#"between_round_over");
			}
			continue;
		}
		arrayremovevalue(level.var_85cc9fcc, var_aa11c23c.script_string);
	}
	level.var_bbc27d0e thread namespace_69ddf44f::function_9e723e9();
	var_c699e2b5 = struct::get("s_p_s2_ins");
	while(level.var_dd650b0e.size < 6)
	{
		var_c699e2b5.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
	}
}

/*
	Name: function_9f38c4a2
	Namespace: namespace_a9aa9d72
	Checksum: 0xD402FD08
	Offset: 0x1FD8
	Size: 0x186
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9f38c4a2()
{
	if(isdefined(level.var_daaf0e5d) && isinarray(level.var_85cc9fcc, level.var_daaf0e5d))
	{
		var_ce57a284 = level.var_daaf0e5d;
		level.var_daaf0e5d = undefined;
	}
	else
	{
		var_ce57a284 = array::random(level.var_85cc9fcc);
	}
	var_328baab5 = struct::get_array("pa_po_pos", "targetname");
	foreach(var_1f5391d1 in var_328baab5)
	{
		if(var_1f5391d1.script_string === var_ce57a284)
		{
			var_aa11c23c = util::spawn_model("tag_origin", var_1f5391d1.origin, var_1f5391d1.angles);
			var_aa11c23c.script_string = var_1f5391d1.script_string;
			var_aa11c23c.script_noteworthy = "blast_attack_interactables";
			break;
		}
	}
	return var_aa11c23c;
}

/*
	Name: function_23fa3cae
	Namespace: namespace_a9aa9d72
	Checksum: 0xB04C9A52
	Offset: 0x2168
	Size: 0x2C2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_23fa3cae()
{
	var_8171dd3a = randomint(10);
	var_8dfff656 = randomint(10);
	var_44e1e41b = randomint(10);
	while(!namespace_1063645::function_aac7105a(var_8171dd3a, var_8dfff656, var_44e1e41b))
	{
		var_8171dd3a = randomint(10);
		var_8dfff656 = randomint(10);
		var_44e1e41b = randomint(10);
	}
	if(!isdefined(level.var_d8e7f0cf))
	{
		level.var_d8e7f0cf = [];
	}
	else if(!isarray(level.var_d8e7f0cf))
	{
		level.var_d8e7f0cf = array(level.var_d8e7f0cf);
	}
	if(!isinarray(level.var_d8e7f0cf, array(var_8171dd3a, var_8dfff656, var_44e1e41b)))
	{
		level.var_d8e7f0cf[level.var_d8e7f0cf.size] = array(var_8171dd3a, var_8dfff656, var_44e1e41b);
	}
	var_679f0ee5 = struct::get_array("nixie_tubes", "script_noteworthy");
	foreach(var_18b64c03 in var_679f0ee5)
	{
		switch(var_18b64c03.script_string)
		{
			case "nixie_tube_trigger_1":
			{
				n_code = var_8171dd3a;
				break;
			}
			case "nixie_tube_trigger_2":
			{
				n_code = var_8dfff656;
				break;
			}
			case "nixie_tube_trigger_3":
			{
				n_code = var_44e1e41b;
				break;
			}
		}
	}
	return array(var_8171dd3a, var_8dfff656, var_44e1e41b);
}

/*
	Name: function_c5319ebe
	Namespace: namespace_a9aa9d72
	Checksum: 0xAF9282E4
	Offset: 0x2438
	Size: 0x1CE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c5319ebe()
{
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9351ef45edb85", 0);
	for(i = 0; i < level.var_99b333e1.size; i++)
	{
		switch(i)
		{
			case 0:
			{
				var_5a557bfb = "" + #"hash_7dc9331ef45ed81f";
				break;
			}
			case 1:
			{
				var_5a557bfb = "" + #"hash_7dc9341ef45ed9d2";
				break;
			}
			case 2:
			{
				var_5a557bfb = "" + #"hash_7dc9351ef45edb85";
				break;
			}
		}
		if(level.var_99b333e1[i] == 0)
		{
			level.var_bbc27d0e clientfield::set(var_5a557bfb, 10);
			continue;
		}
		level.var_bbc27d0e clientfield::set(var_5a557bfb, level.var_99b333e1[i]);
	}
}

/*
	Name: function_b3df3f03
	Namespace: namespace_a9aa9d72
	Checksum: 0x58EF992C
	Offset: 0x2610
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b3df3f03()
{
	callback::remove_on_connect(&function_c5319ebe);
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
	level.var_bbc27d0e clientfield::set("" + #"hash_7dc9351ef45edb85", 0);
}

/*
	Name: function_5b7bbc40
	Namespace: namespace_a9aa9d72
	Checksum: 0x1AA75C1D
	Offset: 0x26D0
	Size: 0x148
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5b7bbc40()
{
	foreach(e_player in util::get_players())
	{
		w_current = e_player getcurrentweapon();
		if(w_current == level.var_4e845c84 || w_current == level.var_58e17ce3)
		{
			if(e_player adsbuttonpressed())
			{
				e_player clientfield::set("" + #"hash_184a34e85c29399f", 0);
				util::wait_network_frame();
				e_player clientfield::set("" + #"hash_184a34e85c29399f", 1);
			}
		}
	}
}

/*
	Name: function_d3aa5310
	Namespace: namespace_a9aa9d72
	Checksum: 0x4DAEAF7E
	Offset: 0x2820
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d3aa5310()
{
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_6fd7f8e1f00deffe");
	wait(180);
	level waittill(#"between_round_over");
	self notify(#"hash_1726927392797d97");
}

/*
	Name: function_b264ca4d
	Namespace: namespace_a9aa9d72
	Checksum: 0xA8EEEE67
	Offset: 0x2890
	Size: 0x626
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b264ca4d()
{
	self endon_callback(&function_5711b0c2, #"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	level.var_5deac933 = [];
	var_3df8381d = level function_5dc786f7();
	var_6433d2a2 = getent("m_c_ra", "targetname");
	var_6433d2a2 thread function_333c93f3(var_3df8381d);
	level waittill(#"hash_3ffb8bc647b5d06b");
	var_6e25652d = getvehiclenode("gh_b_st_node", "targetname");
	level.var_ddea3ebd = vehicle::spawn(undefined, "gh_tb", #"hash_741d76f17830f464", var_6e25652d.origin, var_6e25652d.angles);
	level.var_ddea3ebd thread function_c2f5fca4(var_6e25652d);
	array::thread_all(util::get_players(), &function_29d29761, level.var_ddea3ebd, #"hash_115ac6d40d4cc85b");
	self thread function_c3923440();
	level waittill(#"hash_361c36fab747c7f0");
	var_4f11e61a = struct::get("gh_d_pos", "targetname");
	level.var_ddea3ebd notify(#"stop_path");
	level.var_ddea3ebd vehicle::detach_path();
	level.var_ddea3ebd clientfield::set("" + #"hash_504d26c38b96651c", 0);
	level.var_ddea3ebd clientfield::increment("" + #"hash_22ffb9cf999f16c0");
	waitframe(1);
	level.var_ddea3ebd delete();
	wait(0.5);
	level.var_a33f961e = util::spawn_model(var_4f11e61a.model, var_4f11e61a.origin, var_4f11e61a.angles);
	level.var_a33f961e clientfield::set("" + #"hash_504d26c38b96651c", 1);
	level.var_a33f961e clientfield::set("" + #"hash_584f13d0c8662647", 1);
	waitframe(1);
	level.var_a33f961e clientfield::increment("" + #"hash_22ffb9cf999f16c0");
	level.var_a33f961e playsound(#"hash_2cd9134632e7f398");
	level.var_a33f961e playloopsound(#"hash_5ca999a30dd19c01");
	var_b9526d6f = struct::get("gh_b_pos", "targetname");
	level.var_aca3d5e = spawn("trigger_radius_new", var_b9526d6f.origin, 512 | 2 + 8, var_b9526d6f.radius);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level.var_aca3d5e waittill(#"trigger");
		if(var_88706ea7.activator == level.var_558993a0)
		{
			callback::remove_on_ai_killed(&function_744712bc);
			level.var_558993a0 notify(#"hash_71716a8e79096aee");
			if(isdefined(level.var_558993a0.t_interact))
			{
				level.var_558993a0.t_interact delete();
			}
			var_7df17d61 = level.var_558993a0.origin;
			level.var_558993a0 delete();
			break;
		}
	}
	level.var_aca3d5e delete();
	level.var_a33f961e thread function_dbb17bef(var_4f11e61a);
	var_9c502e92 = 1;
	if(isdefined(var_9c502e92) && var_9c502e92)
	{
		self thread function_56e41aa6(var_7df17d61);
		level thread function_ac1d7a0e(#"hash_7d360b71501ba662");
	}
	self thread function_5711b0c2();
	self notify(#"hash_300e9fed7925cd69", {#b_success:var_9c502e92});
}

/*
	Name: function_5711b0c2
	Namespace: namespace_a9aa9d72
	Checksum: 0x5CAD5A44
	Offset: 0x2EC0
	Size: 0x1AC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5711b0c2(var_c34665fc)
{
	callback::remove_on_ai_killed(&function_744712bc);
	if(isdefined(level.var_66a47b57))
	{
		level.var_66a47b57 delete();
	}
	if(isdefined(level.var_558993a0))
	{
		if(isdefined(level.var_558993a0.t_interact))
		{
			level.var_558993a0.t_interact delete();
		}
		level.var_558993a0 delete();
	}
	if(isdefined(level.var_ddea3ebd))
	{
		level.var_ddea3ebd delete();
	}
	if(isdefined(level.var_533e85d0))
	{
		while(level.var_533e85d0.size)
		{
			var_6a14d409 = level.var_533e85d0[0];
			var_6a14d409 delete();
			arrayremovevalue(level.var_533e85d0, var_6a14d409);
		}
		level.var_533e85d0 = undefined;
	}
	if(isdefined(level.var_a33f961e))
	{
		level.var_a33f961e delete();
	}
	if(isdefined(level.var_aca3d5e))
	{
		level.var_aca3d5e delete();
	}
}

/*
	Name: function_c2f5fca4
	Namespace: namespace_a9aa9d72
	Checksum: 0x7E056A27
	Offset: 0x3078
	Size: 0xFE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c2f5fca4(var_6e25652d)
{
	self endon(#"death", #"stop_path");
	waitframe(1);
	self clientfield::increment("" + #"hash_22ffb9cf999f16c0");
	self clientfield::set("" + #"hash_584f13d0c8662647", 1);
	self clientfield::set("" + #"hash_504d26c38b96651c", 1);
	while(true)
	{
		self vehicle::get_on_and_go_path(var_6e25652d);
		self vehicle::detach_path();
		waitframe(1);
	}
}

/*
	Name: function_5dc786f7
	Namespace: namespace_a9aa9d72
	Checksum: 0x291A7DAC
	Offset: 0x3180
	Size: 0x324
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5dc786f7()
{
	var_304cc83e = randomint(10);
	var_a31c3d78 = randomint(10);
	var_17a14b0b = randomint(10);
	var_3df8381d = var_304cc83e + var_a31c3d78 + var_17a14b0b;
	level.var_533e85d0 = [];
	var_991213f6 = struct::get_array("m_c_pos", "targetname");
	foreach(var_844fa02e in var_991213f6)
	{
		var_6a14d409 = spawn("trigger_radius_new", var_844fa02e.origin, 0, var_844fa02e.radius, 96);
		var_6a14d409.script_noteworthy = var_844fa02e.script_noteworthy;
		var_6a14d409.targetname = var_844fa02e.targetname;
		var_6a14d409.s_lookat = struct::get(var_844fa02e.target, "targetname");
		if(!isdefined(level.var_533e85d0))
		{
			level.var_533e85d0 = [];
		}
		else if(!isarray(level.var_533e85d0))
		{
			level.var_533e85d0 = array(level.var_533e85d0);
		}
		if(!isinarray(level.var_533e85d0, var_6a14d409))
		{
			level.var_533e85d0[level.var_533e85d0.size] = var_6a14d409;
		}
		switch(var_844fa02e.script_noteworthy)
		{
			case "hash_5f87b4f6b225a759":
			{
				var_6a14d409.n_code = var_17a14b0b;
				var_6a14d409.var_c08a71ea = 2;
				break;
			}
			case "catwalk":
			{
				var_6a14d409.n_code = var_304cc83e;
				var_6a14d409.var_c08a71ea = 0;
				break;
			}
			case "hash_107d006e1967d7f1":
			{
				var_6a14d409.n_code = var_a31c3d78;
				var_6a14d409.var_c08a71ea = 1;
				break;
			}
		}
		var_6a14d409 thread function_45862f35();
	}
	return var_3df8381d;
}

/*
	Name: function_45862f35
	Namespace: namespace_a9aa9d72
	Checksum: 0xEF46A09E
	Offset: 0x34B0
	Size: 0xEE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_45862f35()
{
	level endon(#"hash_3ffb8bc647b5d06b");
	self endon(#"death");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(isplayer(var_88706ea7.activator) && (!(isdefined(var_88706ea7.activator.var_f0096e2c) && var_88706ea7.activator.var_f0096e2c)))
		{
			var_88706ea7.activator.var_f0096e2c = 1;
			self thread function_76e46dd1(var_88706ea7.activator);
		}
		waitframe(1);
	}
}

/*
	Name: function_76e46dd1
	Namespace: namespace_a9aa9d72
	Checksum: 0x3577334
	Offset: 0x35A8
	Size: 0x3A2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_76e46dd1(e_player)
{
	level endon(#"hash_3ffb8bc647b5d06b");
	e_player endon(#"death");
	self endon(#"death");
	while(e_player istouching(self))
	{
		w_current = e_player getcurrentweapon();
		if(w_current == level.var_4e845c84 || w_current == level.var_58e17ce3 && e_player util::is_looking_at(self.s_lookat.origin))
		{
			e_player thread function_bb88526(self.n_code);
			if(!isdefined(level.var_5deac933))
			{
				level.var_5deac933 = [];
			}
			else if(!isarray(level.var_5deac933))
			{
				level.var_5deac933 = array(level.var_5deac933);
			}
			if(!isinarray(level.var_5deac933, self))
			{
				level.var_5deac933[level.var_5deac933.size] = self;
			}
			e_player clientfield::set_to_player("" + #"hash_46bc4b451b7419bb", self.var_c08a71ea + 1);
			if(level.var_5deac933.size >= 3)
			{
				level notify(#"hash_31bf59ee8be67433");
			}
			n_start_time = gettime();
			n_total_time = 0;
			while(n_total_time < 8 && e_player istouching(self) && (w_current == level.var_4e845c84 || w_current == level.var_58e17ce3) && e_player util::is_looking_at(self.s_lookat.origin))
			{
				wait(0.1);
				w_current = e_player getcurrentweapon();
				n_current_time = gettime();
				n_total_time = n_current_time - n_start_time / 1000;
			}
			e_player clientfield::set_to_player("" + #"hash_46bc4b451b7419bb", 0);
			if(e_player clientfield::get_to_player("" + #"hash_7d4d423d8dabbee3"))
			{
				e_player clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
			}
		}
		wait(1.6);
	}
	e_player.var_f0096e2c = undefined;
}

/*
	Name: function_bb88526
	Namespace: namespace_a9aa9d72
	Checksum: 0x5425721F
	Offset: 0x3958
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bb88526(n_num)
{
	if(n_num == 0)
	{
		self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 10);
	}
	else
	{
		self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", n_num);
	}
}

/*
	Name: function_333c93f3
	Namespace: namespace_a9aa9d72
	Checksum: 0x2DF00809
	Offset: 0x39D8
	Size: 0x8F6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_333c93f3(var_3df8381d)
{
	level.var_66a47b57 = spawn("trigger_radius_use", self.origin, 0, 48);
	level.var_66a47b57 triggerignoreteam();
	level.var_66a47b57 sethintstring(#"");
	level.var_66a47b57 setcursorhint("HINT_NOICON");
	level.var_66a47b57.is_visible = 1;
	level.var_66a47b57 endon(#"death");
	var_ae5529ba = undefined;
	var_9b830416 = 0;
	var_af097de7 = [];
	var_77d58f80 = [];
	var_3ad399df = #"hash_4436799f2c213e5c";
	var_ca1854a9 = #"hash_4b6197842909de9";
	if(var_3df8381d == 30)
	{
		var_ae5529ba = 3;
		var_af097de7 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
	}
	else if(var_3df8381d >= 20)
	{
		var_ae5529ba = 2;
		var_af097de7 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
	}
	else if(var_3df8381d >= 10)
	{
		var_ae5529ba = 1;
		var_af097de7 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
	}
	switch(var_3df8381d)
	{
		case 1:
		case 11:
		case 21:
		{
			var_9b830416 = 1;
			var_77d58f80 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
			break;
		}
		case 2:
		case 12:
		case 22:
		{
			var_9b830416 = 2;
			var_77d58f80 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
			break;
		}
		case 3:
		case 13:
		case 23:
		{
			var_9b830416 = 3;
			var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
			break;
		}
		case 4:
		case 14:
		case 24:
		{
			var_9b830416 = 4;
			var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9);
			break;
		}
		case 5:
		case 15:
		case 25:
		{
			var_9b830416 = 5;
			var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
			break;
		}
		case 6:
		case 16:
		case 26:
		{
			var_9b830416 = 6;
			var_77d58f80 = array(var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
			break;
		}
		case 7:
		case 17:
		case 27:
		{
			var_9b830416 = 7;
			var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df);
			break;
		}
		case 8:
		case 18:
		case 28:
		{
			var_9b830416 = 8;
			var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df);
			break;
		}
		case 9:
		case 19:
		case 29:
		{
			var_9b830416 = 9;
			var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df);
			break;
		}
		case 0:
		case 10:
		case 20:
		case 30:
		{
			var_9b830416 = 0;
			var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
			break;
		}
		default:
		{
			break;
		}
	}
	var_fda79bf3 = 0;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level.var_66a47b57 waittill(#"trigger");
		e_player = var_88706ea7.activator;
		level.var_66a47b57 setinvisibletoall();
		level.var_66a47b57.is_visible = 0;
		if(!isplayer(e_player))
		{
			level.var_66a47b57 setvisibletoall();
			level.var_66a47b57.is_visible = 1;
			continue;
		}
		if(!(isdefined(var_fda79bf3) && var_fda79bf3))
		{
			level.var_66a47b57 thread function_b87b2393();
			var_fda79bf3 = 1;
		}
		if(isdefined(var_ae5529ba) && var_ae5529ba > 0)
		{
			var_49e994d2 = e_player function_bfe4e5a9(var_af097de7, var_ae5529ba);
			if(!(isdefined(var_49e994d2) && var_49e994d2))
			{
				if(isdefined(e_player))
				{
					e_player playlocalsound(#"hash_28d80c177e66c724");
				}
				level.var_66a47b57 setvisibletoall();
				level.var_66a47b57.is_visible = 1;
				continue;
			}
		}
		if(isplayer(e_player))
		{
			var_5830315f = e_player function_bfe4e5a9(var_77d58f80, var_9b830416);
			if(isdefined(var_5830315f) && var_5830315f)
			{
				playsoundatposition(#"zmb_lightning_l", level.var_66a47b57.origin);
				level notify(#"hash_3ffb8bc647b5d06b");
				e_player thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
				level.var_66a47b57 delete();
				return;
			}
			if(isdefined(e_player))
			{
				e_player playlocalsound(#"hash_28d80c177e66c724");
			}
		}
		level.var_66a47b57 setvisibletoall();
		level.var_66a47b57.is_visible = 1;
	}
}

/*
	Name: function_b87b2393
	Namespace: namespace_a9aa9d72
	Checksum: 0x29E08C6C
	Offset: 0x42D8
	Size: 0xB8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b87b2393()
{
	self endon(#"death");
	level endon(#"hash_3ffb8bc647b5d06b");
	level waittill(#"end_of_round");
	while(isdefined(level.var_66a47b57) && (!(isdefined(level.var_66a47b57.is_visible) && level.var_66a47b57.is_visible)))
	{
		waitframe(1);
	}
	level notify(#"hash_1a286cacd101f4eb", {#b_success:0});
}

/*
	Name: function_bfe4e5a9
	Namespace: namespace_a9aa9d72
	Checksum: 0xCDF41212
	Offset: 0x4398
	Size: 0x31E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_bfe4e5a9(var_5faf08a9, n_entry)
{
	self.var_da61dab6 = 1;
	self thread function_b8dc82a8();
	var_628c4a3a = getent("m_c_ra", "targetname");
	if(isdefined(level.var_bf412074) && level.var_bf412074)
	{
		self thread function_bb88526(n_entry);
		wait(6);
		if(isdefined(self))
		{
			self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
		}
		return 1;
	}
	for(i = 0; i < var_5faf08a9.size; i++)
	{
		var_6dcb990a = var_5faf08a9[i];
		while(isdefined(self) && !self usebuttonpressed() && (isdefined(self.var_da61dab6) && self.var_da61dab6))
		{
			waitframe(1);
		}
		n_start_time = gettime();
		var_628c4a3a thread scene::play(#"hash_764de91b689294b4", "DOWN", var_628c4a3a);
		var_628c4a3a clientfield::set("" + #"hash_7f7790ca43a7fffe", 1);
		while(isdefined(self) && self usebuttonpressed() && (isdefined(self.var_da61dab6) && self.var_da61dab6))
		{
			waitframe(1);
		}
		var_628c4a3a thread scene::play(#"hash_764de91b689294b4", "UP", var_628c4a3a);
		var_628c4a3a clientfield::set("" + #"hash_7f7790ca43a7fffe", 0);
		if(!isdefined(self) || (!(isdefined(self.var_da61dab6) && self.var_da61dab6)))
		{
			return 0;
		}
		var_f661e07a = gettime();
		n_total_time = var_f661e07a - n_start_time / 1000;
		if(n_total_time <= 1.25)
		{
			var_751473a9 = #"hash_4436799f2c213e5c";
		}
		else
		{
			var_751473a9 = #"hash_4b6197842909de9";
		}
		if(var_751473a9 !== var_6dcb990a)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_b8dc82a8
	Namespace: namespace_a9aa9d72
	Checksum: 0x5B3E40E6
	Offset: 0x46C0
	Size: 0x76
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b8dc82a8()
{
	self endon(#"death");
	level.var_66a47b57 endon(#"death");
	while(distance2d(self.origin, level.var_66a47b57.origin) <= 64)
	{
		waitframe(1);
	}
	self.var_da61dab6 = undefined;
}

/*
	Name: function_bb47b90d
	Namespace: namespace_a9aa9d72
	Checksum: 0x5353B269
	Offset: 0x4740
	Size: 0x156
	Parameters: 1
	Flags: Private
*/
private function function_bb47b90d(var_dcd55ef2)
{
	self endon(#"death", #"hash_fdbf10dbf063a82");
	var_25d70459 = var_dcd55ef2;
	s_next_pos = struct::get(var_dcd55ef2.target, "targetname");
	while(true)
	{
		n_dist = distance(s_next_pos.origin, var_25d70459.origin);
		var_213e9c69 = n_dist / 45;
		self moveto(s_next_pos.origin, var_213e9c69);
		self rotateto(s_next_pos.angles, var_213e9c69);
		wait(var_213e9c69);
		var_25d70459 = s_next_pos;
		if(isdefined(var_25d70459.target))
		{
			s_next_pos = struct::get(var_25d70459.target, "targetname");
		}
		else
		{
			s_next_pos = var_dcd55ef2;
		}
	}
}

/*
	Name: function_c3923440
	Namespace: namespace_a9aa9d72
	Checksum: 0xF31C8B1
	Offset: 0x48A0
	Size: 0x298
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c3923440()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	callback::on_ai_killed(&function_744712bc);
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_4e2f6e88e9985f10");
	if(!isdefined(level.var_558993a0) || var_88706ea7.var_84200bb4 !== level.var_558993a0)
	{
		self notify(#"hash_300e9fed7925cd69", {#hash_d0af61fc:1, #b_success:0});
	}
	level.var_558993a0 endon(#"death");
	self thread function_3e62ca0b(level.var_558993a0);
	level.var_558993a0 thread function_1db8a8b2("in_gh_pa");
	level.var_558993a0 waittill(#"hash_6fd7f8e1f00deffe");
	level.var_558993a0 notify(#"hash_585dd04498227242");
	level.var_558993a0 setgoal(level.var_558993a0.origin);
	level.var_558993a0 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	level.var_558993a0 thread function_768e71d5();
	level.var_558993a0 waittill(#"hash_17de7292d988f537");
	level.var_558993a0.var_2ef9b50a = 1;
	level.var_558993a0 thread function_4e69659c();
	var_5e7c3fee = getent("pa_do_vol", "targetname");
	while(!level.var_558993a0 istouching(var_5e7c3fee))
	{
		wait(1);
	}
	level notify(#"hash_361c36fab747c7f0");
}

/*
	Name: function_744712bc
	Namespace: namespace_a9aa9d72
	Checksum: 0x18C65AFC
	Offset: 0x4B40
	Size: 0x2DC
	Parameters: 1
	Flags: Linked
*/
function function_744712bc(s_params)
{
	if(!isdefined(level.var_558993a0) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_infirmary") || self zm_zonemgr::entity_in_zone("zone_infirmary_roof")))
	{
		var_48940c64 = self.origin + vectorscale((0, 0, 1), 5);
		level.var_558993a0 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");
		while(!isdefined(level.var_558993a0))
		{
			waitframe(1);
			level.var_558993a0 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");
		}
		level.var_558993a0 function_e128a8d4();
		level.var_558993a0 forceteleport(var_48940c64, self.angles, 1, 1);
		level.var_558993a0.script_noteworthy = "blast_attack_interactables";
		level.var_558993a0 thread function_a51841a(s_params.eattacker, #"hash_fd8e78c22906fc1");
		level.var_558993a0 thread function_ff88f6aa(var_48940c64);
		waitframe(1);
		level notify(#"hash_4e2f6e88e9985f10", {#hash_84200bb4:level.var_558993a0});
	}
	else if(isdefined(level.var_558993a0) && isplayer(s_params.eattacker) && distance2d(self.origin, level.var_558993a0.origin) < 600 && (isdefined(level.var_558993a0.var_2ef9b50a) && level.var_558993a0.var_2ef9b50a))
	{
		self thread function_b952c1b(level.var_558993a0);
	}
}

/*
	Name: function_e5801a77
	Namespace: namespace_a9aa9d72
	Checksum: 0x5E78A428
	Offset: 0x4E28
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e5801a77()
{
	self endon(#"death", #"hash_71716a8e79096aee");
	self.var_7fbed236 = 0;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_7b36770a2988e5d1");
		self.var_7fbed236 = self.var_7fbed236 + 15;
		self notify(#"hash_2499fc5cec93bec8");
	}
}

/*
	Name: function_4e69659c
	Namespace: namespace_a9aa9d72
	Checksum: 0x91D65C17
	Offset: 0x4EC0
	Size: 0x180
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4e69659c()
{
	self endon(#"death", #"hash_71716a8e79096aee");
	self thread function_e5801a77();
	while(true)
	{
		while(self.var_7fbed236 > 0)
		{
			self.goalradius = 128;
			if(isalive(self.var_64c09f7f))
			{
				self thread function_23d7198d(self.var_64c09f7f);
				self setgoal(self.var_64c09f7f);
			}
			else
			{
				self setgoal(self.origin);
			}
			wait(0.25);
			self.var_7fbed236 = math::clamp(self.var_7fbed236 - 0.25, 0, 300);
		}
		self setgoal(self.origin);
		self playsound(#"hash_2d161f5686b2700a");
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_2499fc5cec93bec8");
	}
}

/*
	Name: function_23d7198d
	Namespace: namespace_a9aa9d72
	Checksum: 0x37F98A0A
	Offset: 0x5048
	Size: 0x15C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_23d7198d(e_player)
{
	if(self zm_utility::function_ab9a9770() && !e_player zm_utility::function_ab9a9770())
	{
		n_distance = distance(self.origin, e_player.origin);
		if(n_distance > 128 && (!(isdefined(self.var_e1e4facc) && self.var_e1e4facc)))
		{
			self thread function_54e0f89(e_player);
		}
	}
	if(self zm_utility::function_ab9a9770() && e_player zm_utility::function_ab9a9770())
	{
		if(isdefined(self.t_interact) && (!(isdefined(e_player.var_c0a4d6b1) && e_player.var_c0a4d6b1)))
		{
			e_player.var_c0a4d6b1 = 1;
			self.t_interact setinvisibletoplayer(e_player);
			self thread function_524c833(e_player);
		}
	}
}

/*
	Name: function_524c833
	Namespace: namespace_a9aa9d72
	Checksum: 0x31C3A97D
	Offset: 0x51B0
	Size: 0x8E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_524c833(e_player)
{
	self endon(#"death");
	e_player endon(#"death");
	while(self zm_utility::function_ab9a9770() && e_player zm_utility::function_ab9a9770())
	{
		wait(0.2);
	}
	self.t_interact setvisibletoplayer(e_player);
	e_player.var_c0a4d6b1 = undefined;
}

/*
	Name: function_54e0f89
	Namespace: namespace_a9aa9d72
	Checksum: 0xBD5A3051
	Offset: 0x5248
	Size: 0xDA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_54e0f89(e_player)
{
	self endon(#"death");
	v_dir = vectornormalize(e_player.origin - self.origin);
	v_pos = e_player.origin + v_dir * 40;
	v_pos = getclosestpointonnavmesh(v_pos, 128, 16);
	if(isdefined(v_pos))
	{
		self.var_e1e4facc = 1;
		self forceteleport(v_pos);
		wait(5);
		self.var_e1e4facc = undefined;
	}
}

/*
	Name: function_dbb17bef
	Namespace: namespace_a9aa9d72
	Checksum: 0x7D3D42A6
	Offset: 0x5330
	Size: 0x17C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dbb17bef(var_25d70459)
{
	self endon(#"death");
	s_next_pos = struct::get(var_25d70459.target, "targetname");
	n_dist = distance(s_next_pos.origin, var_25d70459.origin);
	var_213e9c69 = n_dist / 45;
	self moveto(s_next_pos.origin, var_213e9c69);
	self rotateto(s_next_pos.angles, var_213e9c69);
	wait(var_213e9c69);
	self stoploopsound();
	self clientfield::increment("" + #"hash_22ffb9cf999f16c0");
	self clientfield::set("" + #"hash_584f13d0c8662647", 0);
	self clientfield::set("" + #"hash_504d26c38b96651c", 0);
	waitframe(1);
	self delete();
}

/*
	Name: function_2b37242f
	Namespace: namespace_a9aa9d72
	Checksum: 0xD7F71AE2
	Offset: 0x54B8
	Size: 0x466
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2b37242f()
{
	self endon_callback(&function_e1137e13, #"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	self thread function_6c1f6b4e();
	level waittill(#"hash_4e2f6e88e9985f10");
	waitframe(1);
	level.var_7b71cdb7 waittill(#"hash_6fd7f8e1f00deffe");
	level.var_7b71cdb7 notify(#"hash_71716a8e79096aee");
	self thread function_4c8b4a87();
	if(isdefined(level.var_7b71cdb7.t_interact))
	{
		level.var_7b71cdb7.t_interact delete();
	}
	var_498d47f7 = struct::get_array("cellblocks_barrier_fx", "targetname");
	self thread function_cd0d0123(var_498d47f7, "fxexp_flame_wall_door_glow_shower_cellblock");
	level thread function_2c4516ae("cellblock_start_door");
	self thread function_19df5c43();
	level.var_7b71cdb7 thread function_7de21668();
	level.var_7b71cdb7 val::reset(#"hash_7e90c10175dadf0f", "ignoreme");
	level.var_7b71cdb7 val::reset(#"hash_7e90c10175dadf0f", "allowdeath");
	level.var_7b71cdb7 setcandamage(1);
	level.var_7b71cdb7 solid();
	if(!(isdefined(namespace_e0710ee6::function_2d29434e(level.var_7b71cdb7)) && namespace_e0710ee6::function_2d29434e(level.var_7b71cdb7)))
	{
		namespace_e0710ee6::function_8de1b5b9(level.var_7b71cdb7);
	}
	level.var_7b71cdb7 thread function_67a6f551();
	var_88706ea7 = undefined;
	var_88706ea7 = level.var_7b71cdb7 waittill(#"death", #"hash_6f435cd868870904");
	if(var_88706ea7._notify == #"hash_6f435cd868870904")
	{
		var_9c502e92 = 1;
	}
	else
	{
		v_pos = undefined;
		if(isdefined(level.var_7b71cdb7))
		{
			v_pos = level.var_7b71cdb7.origin;
		}
		level thread function_4219d0d8(v_pos);
	}
	if(isdefined(level.var_7b71cdb7))
	{
		if(isdefined(namespace_e0710ee6::function_2d29434e(level.var_7b71cdb7)) && namespace_e0710ee6::function_2d29434e(level.var_7b71cdb7))
		{
			namespace_e0710ee6::function_901eccf2(level.var_7b71cdb7);
		}
		var_7df17d61 = level.var_7b71cdb7.origin;
	}
	self thread function_e1137e13();
	if(isdefined(var_9c502e92) && var_9c502e92)
	{
		self thread function_56e41aa6(var_7df17d61);
		level thread function_ac1d7a0e(#"hash_368df266f54ec3b1");
	}
	self notify(#"hash_300e9fed7925cd69", {#b_success:var_9c502e92});
}

/*
	Name: function_e1137e13
	Namespace: namespace_a9aa9d72
	Checksum: 0x4B22C6C0
	Offset: 0x5928
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e1137e13(var_c34665fc)
{
	callback::remove_on_ai_killed(&function_59945272);
	if(isdefined(level.var_7b71cdb7))
	{
		level.var_7b71cdb7 delete();
	}
	hidemiscmodels("rt_gh_sanim");
	exploder::stop_exploder("fxexp_riot_ghoul");
	exploder::stop_exploder("fxexp_riot_ghoul2");
}

/*
	Name: function_4c8b4a87
	Namespace: namespace_a9aa9d72
	Checksum: 0x195607CE
	Offset: 0x59D0
	Size: 0x56
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4c8b4a87()
{
	var_39633c28 = zombie_utility::get_current_zombie_count();
	if(var_39633c28 + level.zombie_total < 4)
	{
		level.zombie_total = level.zombie_total + 5;
	}
}

/*
	Name: function_19df5c43
	Namespace: namespace_a9aa9d72
	Checksum: 0x99822F3
	Offset: 0x5A30
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_19df5c43()
{
	level util::clientnotify("sndriot");
	showmiscmodels("rt_gh_sanim");
	exploder::exploder("fxexp_riot_ghoul");
	exploder::exploder("fxexp_riot_ghoul2");
	self thread function_9ee74e2c();
	self waittill(#"death", #"hash_300e9fed7925cd69");
	level util::clientnotify("sndriot");
	hidemiscmodels("rt_gh_sanim");
	exploder::stop_exploder("fxexp_riot_ghoul");
	exploder::stop_exploder("fxexp_riot_ghoul2");
}

/*
	Name: function_9ee74e2c
	Namespace: namespace_a9aa9d72
	Checksum: 0x159BB975
	Offset: 0x5B48
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_9ee74e2c()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	while(true)
	{
		var_fe655381 = zm_zonemgr::get_players_in_zone("zone_cellblock_east", 1);
		if(var_fe655381.size > 0)
		{
			e_player = array::random(var_fe655381);
			level thread function_629fa2c8(#"hash_72bb7bc935d4da67", e_player);
			return;
		}
		wait(1);
	}
}

/*
	Name: function_67a6f551
	Namespace: namespace_a9aa9d72
	Checksum: 0x636C5AD2
	Offset: 0x5C08
	Size: 0xF8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_67a6f551()
{
	self endon(#"death");
	var_9cdf5d68 = 10;
	while(isalive(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		n_percent = self.health / 961;
		var_6f89c2f6 = int(n_percent * 10);
		if(var_6f89c2f6 != var_9cdf5d68)
		{
			self clientfield::set("" + #"hash_3e506d7aedac6ae0", var_6f89c2f6);
			var_9cdf5d68 = var_6f89c2f6;
		}
		self function_1b049b47();
	}
}

/*
	Name: function_1b049b47
	Namespace: namespace_a9aa9d72
	Checksum: 0x4BB00C40
	Offset: 0x5D08
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1b049b47()
{
	self endon(#"death");
	self setcandamage(0);
	var_a94e126 = 0;
	is_visible = 1;
	while(var_a94e126 < 7)
	{
		if(isdefined(is_visible) && is_visible)
		{
			self ghost();
			is_visible = 0;
		}
		else
		{
			self show();
			is_visible = 1;
		}
		var_a94e126++;
		wait(0.1);
	}
	self show();
	self setcandamage(1);
}

/*
	Name: function_1d42763a
	Namespace: namespace_a9aa9d72
	Checksum: 0x87746C12
	Offset: 0x5E08
	Size: 0x98
	Parameters: 12
	Flags: Linked
*/
function function_1d42763a(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self === level.var_7b71cdb7 && isplayer(eattacker))
	{
		return 0;
	}
	return -1;
}

/*
	Name: function_7de21668
	Namespace: namespace_a9aa9d72
	Checksum: 0x9112EA91
	Offset: 0x5EA8
	Size: 0x1DE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7de21668()
{
	self endon(#"death");
	self.goalradius = 64;
	var_397f8272 = struct::get_array("cellblocks_final_path", "script_noteworthy");
	var_25d70459 = arraygetclosest(self.origin, var_397f8272);
	s_next_pos = struct::get(var_25d70459.target, "targetname");
	self setgoal(var_25d70459.origin);
	self waittill(#"goal");
	while(isdefined(s_next_pos))
	{
		self setgoal(s_next_pos.origin);
		self waittill(#"goal");
		if(s_next_pos.script_string === "smoke")
		{
			s_next_pos thread function_e5b11574();
		}
		else if(s_next_pos.script_string === "brutus_sp")
		{
			level thread function_b88f57f9();
		}
		var_25d70459 = s_next_pos;
		if(isdefined(var_25d70459.target))
		{
			s_next_pos = struct::get(var_25d70459.target, "targetname");
		}
		else
		{
			s_next_pos = undefined;
		}
	}
	self notify(#"hash_6f435cd868870904");
}

/*
	Name: function_b88f57f9
	Namespace: namespace_a9aa9d72
	Checksum: 0x528B14F7
	Offset: 0x6090
	Size: 0x1CC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b88f57f9()
{
	var_f9c8cb3a = struct::get("cel_bru_pos", "targetname");
	var_a9c0254c = struct::get(var_f9c8cb3a.target, "targetname");
	if(level.brutus_count + 1 <= level.brutus_max_count)
	{
		ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);
		if(isalive(ai_brutus))
		{
			ai_brutus endon(#"death");
			ai_brutus namespace_961cf978::brutus_spawn(undefined, undefined, undefined, undefined, undefined);
			ai_brutus forceteleport(var_f9c8cb3a.origin, var_f9c8cb3a.angles);
			ai_brutus playsound(#"zmb_ai_brutus_spawn_2d");
			ai_brutus val::set(#"ai_brutus", "ignoreall", 1);
			ai_brutus setgoal(var_a9c0254c.origin);
			ai_brutus waittill(#"goal");
			ai_brutus val::reset(#"ai_brutus", "ignoreall");
		}
	}
}

/*
	Name: function_e5b11574
	Namespace: namespace_a9aa9d72
	Checksum: 0x6B4177B2
	Offset: 0x6268
	Size: 0x13C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e5b11574()
{
	if(math::cointoss())
	{
		v_target_pos = (self.origin[0] + randomfloat(256), self.origin[1] + randomfloat(256), self.origin[2]);
		v_target_pos = getclosestpointonnavmesh(v_target_pos, 256, 16);
		if(isdefined(v_target_pos))
		{
			var_82c080ed = util::spawn_model("tag_origin", v_target_pos + vectorscale((0, 0, 1), 32));
			e_grenade = var_82c080ed magicgrenadetype(getweapon(#"willy_pete"), v_target_pos, (0, 0, 0), 0.4);
			waitframe(1);
			var_82c080ed delete();
		}
	}
}

/*
	Name: function_ae8a20de
	Namespace: namespace_a9aa9d72
	Checksum: 0x6B868A02
	Offset: 0x63B0
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_ae8a20de()
{
	self endon(#"death", #"hash_6f435cd868870904");
	while(true)
	{
		var_d8036031 = getaiteamarray(level.zombie_team).size;
		if(var_d8036031 >= function_5b5301c9())
		{
			waitframe(1);
			continue;
		}
		str_zone = zm_zonemgr::get_zone_from_position(self.origin);
		var_3c0dcfe8 = function_9e55b467(str_zone);
		function_eee2ccd4(var_3c0dcfe8);
		function_eee2ccd4(var_3c0dcfe8);
		if(var_3c0dcfe8 === "zone_start")
		{
			function_eee2ccd4(var_3c0dcfe8);
		}
		else if(str_zone === "zone_start")
		{
			function_eee2ccd4("zone_library");
		}
		wait(randomfloatrange(2.9, 6.1));
	}
}

/*
	Name: function_5b5301c9
	Namespace: namespace_a9aa9d72
	Checksum: 0xB302BCD1
	Offset: 0x6520
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_5b5301c9()
{
	switch(util::get_active_players().size)
	{
		case 1:
		{
			var_63a54520 = 21;
			break;
		}
		case 2:
		{
			var_63a54520 = 22;
			break;
		}
		case 3:
		{
			var_63a54520 = 23;
			break;
		}
		default:
		{
			var_63a54520 = 26;
			break;
		}
	}
	return var_63a54520;
}

/*
	Name: function_1eab6e39
	Namespace: namespace_a9aa9d72
	Checksum: 0xE3D22561
	Offset: 0x65E8
	Size: 0x1C0
	Parameters: 0
	Flags: Private
*/
private function function_1eab6e39()
{
	self endon(#"death", #"hash_6f435cd868870904");
	self thread function_7c71661a();
	while(true)
	{
		str_zone = zm_zonemgr::get_zone_from_position(self.origin);
		var_3cd5bf76 = 0;
		if(str_zone != "zone_cellblock_entrance")
		{
			var_2b198109 = getaiteamarray(level.zombie_team);
			foreach(e_zombie in var_2b198109)
			{
				if(isalive(e_zombie) && isdefined(e_zombie.zone_name) && e_zombie.zone_name == str_zone)
				{
					var_3cd5bf76++;
				}
			}
			if(!level function_7edf3657(var_3cd5bf76))
			{
				var_3c0dcfe8 = function_9e55b467(str_zone);
				level thread function_eee2ccd4(var_3c0dcfe8);
			}
		}
		wait(randomfloatrange(3, 5));
	}
}

/*
	Name: function_7c71661a
	Namespace: namespace_a9aa9d72
	Checksum: 0x600FC400
	Offset: 0x67B0
	Size: 0x228
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7c71661a()
{
	self endon(#"death", #"hash_6f435cd868870904");
	level thread function_eee2ccd4("zone_cellblock_entrance");
	var_d4c2136c = 0;
	var_fe69e6bb = 0;
	var_adf35a34 = 0;
	var_70edc3d5 = 0;
	var_629eec30 = 0;
	while(!var_629eec30)
	{
		str_zone = zm_zonemgr::get_zone_from_position(self.origin);
		if(str_zone == "zone_cellblock_east" && !var_d4c2136c)
		{
			var_d4c2136c = 1;
			level thread function_eee2ccd4("zone_library");
		}
		else if(str_zone == "zone_cellblock_entrance" && !var_fe69e6bb)
		{
			var_fe69e6bb = 1;
			level thread function_eee2ccd4("zone_library");
		}
		else if(str_zone == "zone_start" && !var_adf35a34)
		{
			var_adf35a34 = 1;
			level thread function_eee2ccd4("zone_cellblock_west");
		}
		else if(str_zone == "zone_library" && !var_70edc3d5)
		{
			var_70edc3d5 = 1;
			level thread function_eee2ccd4("zone_broadway_floor_2");
		}
		else if(str_zone == "zone_cellblock_west" && !var_629eec30)
		{
			var_629eec30 = 1;
			level thread function_eee2ccd4("zone_cellblock_west_warden");
		}
		wait(1);
	}
}

/*
	Name: function_7edf3657
	Namespace: namespace_a9aa9d72
	Checksum: 0x5C47A6A0
	Offset: 0x69E0
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7edf3657(var_3cd5bf76)
{
	switch(util::get_players().size)
	{
		case 1:
		{
			n_threshold = 3;
			break;
		}
		case 2:
		{
			n_threshold = 4;
			break;
		}
		case 3:
		{
			n_threshold = 5;
			break;
		}
		case 4:
		{
			n_threshold = 6;
			break;
		}
	}
	if(var_3cd5bf76 >= n_threshold)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_9e55b467
	Namespace: namespace_a9aa9d72
	Checksum: 0x12BADD87
	Offset: 0x6AA8
	Size: 0x186
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e55b467(str_zone)
{
	var_3c0dcfe8 = "zone_cafeteria";
	if(!isdefined(str_zone))
	{
		return var_3c0dcfe8;
	}
	switch(str_zone)
	{
		case "zone_cafeteria_end":
		{
			var_3c0dcfe8 = "zone_cellblock_east";
			break;
		}
		case "zone_cafeteria":
		{
			var_3c0dcfe8 = "zone_cellblock_entrance";
			break;
		}
		case "zone_cellblock_east":
		{
			var_3c0dcfe8 = "zone_start";
			break;
		}
		case "zone_cellblock_entrance":
		{
			var_3c0dcfe8 = "zone_library";
			break;
		}
		case "zone_start":
		{
			var_3c0dcfe8 = "zone_cellblock_west";
			break;
		}
		case "zone_library":
		{
			var_3c0dcfe8 = "zone_broadway_floor_2";
			break;
		}
		case "zone_cellblock_west":
		{
			var_3c0dcfe8 = "zone_cellblock_west_barber";
			break;
		}
		case "zone_broadway_floor_2":
		{
			var_3c0dcfe8 = "zone_cellblock_west_warden";
			break;
		}
		case "zone_cellblock_west_barber":
		{
			var_3c0dcfe8 = "zone_sally_port";
			break;
		}
		case "zone_cellblock_west_warden":
		{
			var_3c0dcfe8 = "zone_sally_port";
			break;
		}
	}
	return var_3c0dcfe8;
}

/*
	Name: function_eee2ccd4
	Namespace: namespace_a9aa9d72
	Checksum: 0x61A48072
	Offset: 0x6C38
	Size: 0x234
	Parameters: 1
	Flags: Linked, Private
*/
private function function_eee2ccd4(str_zone)
{
	var_7d53907e = getnode(str_zone, "targetname");
	var_f3f7c164 = struct::get_array(var_7d53907e.target);
	var_5ab4bb90 = [];
	foreach(s_spawner in var_f3f7c164)
	{
		if(s_spawner.script_noteworthy != "dog_location" && s_spawner.script_noteworthy != "brutus_location" && s_spawner.script_noteworthy != "wait_location")
		{
			if(!isdefined(var_5ab4bb90))
			{
				var_5ab4bb90 = [];
			}
			else if(!isarray(var_5ab4bb90))
			{
				var_5ab4bb90 = array(var_5ab4bb90);
			}
			var_5ab4bb90[var_5ab4bb90.size] = s_spawner;
		}
	}
	var_8f2dfb2c = function_8f06b9dc();
	for(i = 0; i < var_8f2dfb2c; i++)
	{
		var_86febf77 = array::random(var_5ab4bb90);
		e_enemy = undefined;
		while(!isdefined(e_enemy))
		{
			e_enemy = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, var_86febf77);
			waitframe(1);
		}
		e_enemy thread namespace_54386dac::function_24d3ec02(undefined, 1);
		waitframe(1);
	}
}

/*
	Name: function_8f06b9dc
	Namespace: namespace_a9aa9d72
	Checksum: 0x3C45227F
	Offset: 0x6E78
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_8f06b9dc()
{
	switch(util::get_players().size)
	{
		case 1:
		{
			n_zombies = 3;
			break;
		}
		case 2:
		{
			n_zombies = 4;
			break;
		}
		case 3:
		{
			n_zombies = 5;
			break;
		}
		case 4:
		{
			n_zombies = 6;
			break;
		}
	}
	return n_zombies;
}

/*
	Name: function_6c1f6b4e
	Namespace: namespace_a9aa9d72
	Checksum: 0x434DDA80
	Offset: 0x6F20
	Size: 0x1CC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6c1f6b4e()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	callback::on_ai_killed(&function_59945272);
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_4e2f6e88e9985f10");
	if(!isdefined(level.var_7b71cdb7) || var_88706ea7.var_84200bb4 !== level.var_7b71cdb7)
	{
		self notify(#"hash_300e9fed7925cd69", {#hash_d0af61fc:1, #b_success:0});
	}
	level.var_7b71cdb7 endon(#"death");
	self thread function_3e62ca0b(level.var_7b71cdb7);
	level.var_7b71cdb7 thread function_1db8a8b2("ce_gh_pa");
	level.var_7b71cdb7 waittill(#"hash_6fd7f8e1f00deffe");
	level.var_7b71cdb7 notify(#"hash_585dd04498227242");
	level.var_7b71cdb7.b_is_visible = 1;
	level.var_7b71cdb7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	level.var_7b71cdb7 thread function_ae8a20de();
}

/*
	Name: function_59945272
	Namespace: namespace_a9aa9d72
	Checksum: 0x1080857B
	Offset: 0x70F8
	Size: 0x258
	Parameters: 1
	Flags: Linked
*/
function function_59945272(s_params)
{
	if(!isdefined(level.var_7b71cdb7) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_cafeteria") || self zm_zonemgr::entity_in_zone("zone_cafeteria_end")))
	{
		callback::remove_on_ai_killed(&function_59945272);
		var_48940c64 = self.origin + vectorscale((0, 0, 1), 5);
		level.var_7b71cdb7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "cb_gh");
		while(!isdefined(level.var_7b71cdb7))
		{
			waitframe(1);
			level.var_7b71cdb7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "cb_gh");
		}
		level.var_7b71cdb7 function_e128a8d4(0);
		level.var_7b71cdb7.var_238b3806 = 1;
		level.var_7b71cdb7 forceteleport(var_48940c64, self.angles, 1, 1);
		level.var_7b71cdb7.script_noteworthy = "blast_attack_interactables";
		level.var_7b71cdb7 thread function_a51841a(s_params.eattacker, #"hash_2ea20c8cd81b5464");
		level.var_7b71cdb7 thread function_ff88f6aa(var_48940c64);
		level notify(#"hash_4e2f6e88e9985f10", {#hash_84200bb4:level.var_7b71cdb7});
	}
}

/*
	Name: function_4219d0d8
	Namespace: namespace_a9aa9d72
	Checksum: 0xEA2FA14C
	Offset: 0x7358
	Size: 0x11C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4219d0d8(v_pos)
{
	foreach(e_player in util::get_active_players())
	{
		if(isdefined(v_pos) && e_player zm_utility::is_player_looking_at(v_pos + vectorscale((0, 0, 1), 32)))
		{
			level thread function_629fa2c8(#"hash_215fb85a66e4b593", e_player);
		}
		waitframe(1);
	}
	e_player = array::random(util::get_active_players());
	level thread function_629fa2c8(#"hash_215fb85a66e4b593", e_player);
}

/*
	Name: function_cdc8090a
	Namespace: namespace_a9aa9d72
	Checksum: 0xD6AF3AFE
	Offset: 0x7480
	Size: 0x56E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cdc8090a()
{
	self endon_callback(&function_4b6d9f06, #"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	self thread function_d2bf4eeb();
	level waittill(#"hash_4e2f6e88e9985f10");
	waitframe(1);
	level.var_acc853e7 waittill(#"hash_585dd04498227242");
	self thread function_729b2218(level.var_acc853e7);
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill_timeout(6, #"hash_754ca63bdd999035");
	if(var_88706ea7._notify == "timeout")
	{
		self notify(#"hash_141c4fe73e47836f");
	}
	level.var_acc853e7 thread function_3c3c455c();
	level.var_acc853e7 thread function_3f90c49f();
	level.var_acc853e7 waittill(#"hash_57648a286155c924");
	array::thread_all(util::get_players(), &function_2992f8fe, level.var_acc853e7, #"hash_7cf90fc327de893e");
	level thread function_2c4516ae("door_model_west_side_exterior_to_new_industries");
	level.var_acc853e7 thread function_a50552d1();
	level.var_acc853e7 waittill(#"hash_42d705f0ff5334bb");
	level zm_audio::function_6191af93(#"trap_activate", #"zm_spinning_trap", "", "");
	level zm_audio::function_6191af93(#"hash_2c3c478eed0f3b99", #"hook", "", "");
	level.var_acc853e7 ai::set_behavior_attribute("run", 0);
	if(level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e"))
	{
		level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	}
	level scene::add_scene_func(#"hash_5c1cf4dde1ca088c", &function_e78de01b, "init");
	level thread scene::init(#"hash_5c1cf4dde1ca088c");
	level.var_acc853e7 thread function_7f71a2b2(self);
	var_e4f517f0 = getentarray("zm_spinning_trap", "script_noteworthy");
	array::thread_all(var_e4f517f0, &function_f8da844f, self);
	var_88706ea7 = undefined;
	var_88706ea7 = level.var_acc853e7 waittill(#"death", #"hash_436fe34b5e12d99a");
	var_7df17d61 = level.var_acc853e7.origin;
	if(var_88706ea7._notify == "death")
	{
		var_9c502e92 = 1;
		level thread scene::stop(#"hash_5c1cf4dde1ca088c");
	}
	else
	{
		self waittill_timeout(9, #"hash_17cc254c45796829");
		e_player = array::random(util::get_active_players());
		level thread function_629fa2c8(#"hash_7ab135537c096a5a", e_player);
	}
	level thread function_4b6d9f06();
	if(isdefined(var_9c502e92) && var_9c502e92)
	{
		self thread function_56e41aa6(var_7df17d61);
		level thread function_ac1d7a0e(#"hash_53aafd7783e33981");
	}
	self notify(#"hash_300e9fed7925cd69", {#b_success:var_9c502e92});
}

/*
	Name: function_2992f8fe
	Namespace: namespace_a9aa9d72
	Checksum: 0x17F693F2
	Offset: 0x79F8
	Size: 0x1AA
	Parameters: 2
	Flags: Linked
*/
function function_2992f8fe(e_ghost, var_5b9ba5a5)
{
	e_ghost endon(#"death", #"hash_29156bb763ad6672");
	self endon(#"disconnect");
	wait(1.6);
	while(true)
	{
		var_da2705ac = self zm_utility::is_player_looking_at(e_ghost getcentroid());
		var_8924ba8b = self clientfield::get("" + #"hash_184a34e85c29399f");
		var_383e18aa = isdefined(level.var_acc853e7.var_c95261d) && level.var_acc853e7.var_c95261d;
		if(var_da2705ac && (var_8924ba8b || var_383e18aa))
		{
			if(!(isdefined(level.var_9cb7c32e) && level.var_9cb7c32e))
			{
				level.var_9cb7c32e = 1;
				level function_629fa2c8(#"hash_57e9c23bed1bd753", self);
				wait(0.5);
			}
			level thread function_629fa2c8(var_5b9ba5a5, self);
			e_ghost notify(#"hash_29156bb763ad6672");
		}
		waitframe(1);
	}
}

/*
	Name: function_729b2218
	Namespace: namespace_a9aa9d72
	Checksum: 0xFC650A0F
	Offset: 0x7BB0
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_729b2218(var_84200bb4)
{
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_141c4fe73e47836f");
	foreach(e_player in util::get_active_players())
	{
		if(e_player util::is_looking_at(var_84200bb4 getcentroid()))
		{
			self notify(#"hash_754ca63bdd999035");
			return;
		}
	}
}

/*
	Name: function_d2bf4eeb
	Namespace: namespace_a9aa9d72
	Checksum: 0x1260BD80
	Offset: 0x7CA0
	Size: 0x20C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d2bf4eeb()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	callback::on_ai_killed(&function_995231f6);
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_4e2f6e88e9985f10");
	if(!isdefined(level.var_acc853e7) || var_88706ea7.var_84200bb4 !== level.var_acc853e7)
	{
		self notify(#"hash_300e9fed7925cd69", {#hash_d0af61fc:1, #b_success:0});
	}
	level.var_acc853e7 endon(#"death");
	self thread function_3e62ca0b(level.var_acc853e7);
	level.var_acc853e7 thread function_1db8a8b2("ni_gh_pa");
	level.var_acc853e7 waittill(#"hash_6fd7f8e1f00deffe");
	level.var_acc853e7 notify(#"hash_585dd04498227242");
	level.var_acc853e7 setgoal(level.var_acc853e7.origin);
	level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	level.var_acc853e7.var_c95261d = 1;
	level.var_68fa1bc = level.var_acc853e7;
	level.var_acc853e7 solid();
}

/*
	Name: function_995231f6
	Namespace: namespace_a9aa9d72
	Checksum: 0xA2C41F99
	Offset: 0x7EB8
	Size: 0x258
	Parameters: 1
	Flags: Linked
*/
function function_995231f6(s_params)
{
	if(!isdefined(level.var_acc853e7) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_library") || self zm_zonemgr::entity_in_zone("zone_start")))
	{
		callback::remove_on_ai_killed(&function_995231f6);
		var_48940c64 = self.origin + vectorscale((0, 0, 1), 5);
		level.var_acc853e7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "ni_gh");
		while(!isdefined(level.var_acc853e7))
		{
			waitframe(1);
			level.var_acc853e7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "ni_gh");
		}
		level.var_acc853e7 function_e128a8d4(0);
		level.var_acc853e7 forceteleport(var_48940c64, self.angles, 1, 1);
		level.var_acc853e7.script_noteworthy = "blast_attack_interactables";
		level.var_acc853e7 thread function_a51841a(s_params.eattacker, #"hash_1d191ca6765471c6");
		level.var_acc853e7 thread function_ff88f6aa(var_48940c64);
		level.var_acc853e7.var_238b3806 = 1;
		level notify(#"hash_4e2f6e88e9985f10", {#hash_84200bb4:level.var_acc853e7});
	}
}

/*
	Name: function_3f90c49f
	Namespace: namespace_a9aa9d72
	Checksum: 0x9E6F5826
	Offset: 0x8118
	Size: 0x374
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3f90c49f()
{
	self endon(#"death");
	var_14a84ac9 = struct::get_array("ni_sp_pos", "targetname");
	v_pos = undefined;
	var_14a84ac9 = array::randomize(var_14a84ac9);
	while(!isdefined(v_pos))
	{
		foreach(var_24f2b6cf in var_14a84ac9)
		{
			v_pos = getclosestpointonnavmesh(var_24f2b6cf.origin, 128, 16);
			v_angles = var_24f2b6cf.angles;
			if(isdefined(v_pos))
			{
				var_3af6337 = self findpath(self.origin, v_pos, 1, 0);
				if(var_3af6337)
				{
					break;
				}
				iprintln("" + var_24f2b6cf.origin);
				continue;
			}
			/#
				iprintln("" + var_24f2b6cf.origin);
			#/
		}
	}
	level.var_9e23e046 = util::spawn_model(#"hash_630bdbfa8e91025e", v_pos, v_angles);
	self.goalradius = 64;
	while(distance2d(self.origin, v_pos) > 80)
	{
		self setgoal(v_pos);
		self waittill_timeout(6, #"goal");
	}
	self notify(#"hash_57648a286155c924");
	self scene::play(#"hash_274b267ae90b4ed8", self);
	if(isdefined(level.var_9e23e046))
	{
		level.var_9e23e046 delete();
	}
	self.var_6b6eb535 = util::spawn_model(#"hash_630bdbfa8e91025e", self gettagorigin("tag_weapon_right"), self gettagangles("tag_weapon_right"));
	self.var_6b6eb535 linkto(self, "tag_weapon_right");
	self.var_6b6eb535 clientfield::set("" + #"hash_28a1a80b64f97e05", 1);
}

/*
	Name: function_3c3c455c
	Namespace: namespace_a9aa9d72
	Checksum: 0xAA652EF9
	Offset: 0x8498
	Size: 0x1D8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3c3c455c()
{
	self endon(#"death", #"hash_3cef5405e0643505", #"hash_436fe34b5e12d99a");
	self thread function_685fffc4();
	wait(11);
	level.var_acc853e7.var_c95261d = undefined;
	level.var_68fa1bc = undefined;
	level.var_acc853e7 notsolid();
	level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 2);
	while(true)
	{
		level.var_acc853e7 waittill(#"hash_6fd7f8e1f00deffe");
		level.var_acc853e7.var_c95261d = 1;
		level.var_68fa1bc = level.var_acc853e7;
		level.var_acc853e7 solid();
		level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
		wait(11);
		level.var_acc853e7.var_c95261d = undefined;
		level.var_68fa1bc = undefined;
		level.var_acc853e7 notsolid();
		level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 2);
	}
}

/*
	Name: function_ae0bae8
	Namespace: namespace_a9aa9d72
	Checksum: 0xFF033D3D
	Offset: 0x8678
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function function_ae0bae8()
{
	var_9636ee0 = 61;
	switch(util::get_players().size)
	{
		case 1:
		{
			var_9636ee0 = 30.5;
			break;
		}
		case 2:
		{
			var_9636ee0 = 42.7;
			break;
		}
		case 3:
		{
			var_9636ee0 = 48.8;
			break;
		}
		case 4:
		{
			break;
		}
	}
	return var_9636ee0;
}

/*
	Name: function_685fffc4
	Namespace: namespace_a9aa9d72
	Checksum: 0xF14D1E4B
	Offset: 0x8730
	Size: 0x2FC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_685fffc4()
{
	self endon(#"death", #"hash_42d705f0ff5334bb");
	var_9636ee0 = function_ae0bae8();
	var_31adaadb = 0;
	var_e5b1f8d7 = undefined;
	var_49154180 = 10;
	while(var_31adaadb <= var_9636ee0)
	{
		if(isdefined(self.var_c95261d) && self.var_c95261d && (isdefined(self.var_5bf7575e) && self.var_5bf7575e))
		{
			var_31adaadb++;
		}
		var_36f8baa8 = var_9636ee0 - var_31adaadb / var_9636ee0;
		var_b25755cf = int(var_36f8baa8 * 10);
		if(var_b25755cf != var_49154180)
		{
			self clientfield::set("" + #"hash_3e506d7aedac6ae0", var_b25755cf);
			var_49154180 = var_b25755cf;
		}
		/#
			if(var_36f8baa8 == 0.25 || var_36f8baa8 == 0.5 || (var_36f8baa8 == 0.75 && var_e5b1f8d7 !== var_36f8baa8))
			{
				var_e5b1f8d7 = var_36f8baa8;
				iprintlnbold("" + var_36f8baa8);
			}
		#/
		wait(1);
	}
	level.var_acc853e7 notify(#"hash_3cef5405e0643505");
	level.var_acc853e7 playsound(#"zmb_sq_souls_release");
	waitframe(1);
	if(level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e"))
	{
		level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	}
	/#
		iprintlnbold("");
	#/
	level.var_acc853e7.var_c95261d = undefined;
	level.var_68fa1bc = undefined;
	level.var_acc853e7.var_238b3806 = undefined;
	level.var_acc853e7 notsolid();
	level.var_acc853e7 ai::set_behavior_attribute("run", 1);
}

/*
	Name: function_a50552d1
	Namespace: namespace_a9aa9d72
	Checksum: 0x5EDE7D5F
	Offset: 0x8A38
	Size: 0xEE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a50552d1()
{
	self endon(#"death");
	var_38da48af = struct::get("ni_gh_fi", "targetname");
	var_38da48af.origin = (7888, 11072, 320);
	self.goalradius = 64;
	while(distance2d(self.origin, var_38da48af.origin) > 92)
	{
		self setgoal(var_38da48af.origin);
		self waittill_timeout(30, #"goal");
	}
	self notify(#"hash_42d705f0ff5334bb");
}

/*
	Name: function_7f71a2b2
	Namespace: namespace_a9aa9d72
	Checksum: 0x869F8978
	Offset: 0x8B30
	Size: 0x1B0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7f71a2b2(var_aa11c23c)
{
	self endon(#"death");
	var_aa11c23c endon(#"hash_300e9fed7925cd69");
	var_48bbb849 = struct::get("gh_vi_pos", "targetname");
	self.goalradius = 24;
	while(distance2d(self.origin, var_48bbb849.origin) > self.goalradius)
	{
		self setgoal(var_48bbb849.origin, 1);
		self waittill_timeout(15, #"goal");
	}
	self notify(#"hash_436fe34b5e12d99a");
	waitframe(1);
	if(isalive(level.var_acc853e7) && level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e"))
	{
		level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
	}
	level scene::play(#"hash_5c1cf4dde1ca088c");
	var_aa11c23c notify(#"hash_17cc254c45796829");
}

/*
	Name: function_f8da844f
	Namespace: namespace_a9aa9d72
	Checksum: 0xD1C7F23A
	Offset: 0x8CE8
	Size: 0x1E0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f8da844f(var_aa11c23c)
{
	level.var_acc853e7 endon(#"death");
	var_aa11c23c endon(#"hash_300e9fed7925cd69");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(isdefined(self._trap_in_use) && self._trap_in_use && var_88706ea7.activator === level.var_acc853e7 && (!(isdefined(level.var_acc853e7.var_238b3806) && level.var_acc853e7.var_238b3806)))
		{
			wait(1.6);
			level.var_acc853e7 val::reset(#"hash_7e90c10175dadf0f", "allowdeath");
			level.var_acc853e7 setcandamage(1);
			level.var_acc853e7 clientfield::set("" + #"hash_7a8eab5597b25400", 1);
			playsoundatposition("zmb_spoon_ghost_annihilate", level.var_acc853e7.origin);
			gibserverutils::annihilate(level.var_acc853e7);
			level.var_acc853e7 dodamage(level.var_acc853e7.health + 1000, self.origin, undefined, self);
		}
	}
}

/*
	Name: function_4b6d9f06
	Namespace: namespace_a9aa9d72
	Checksum: 0xCCE3FB5
	Offset: 0x8ED0
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4b6d9f06(var_c34665fc)
{
	callback::remove_on_ai_killed(&function_995231f6);
	if(isdefined(level.var_acc853e7))
	{
		if(isdefined(level.var_acc853e7.var_6b6eb535))
		{
			level.var_acc853e7.var_6b6eb535 clientfield::set("" + #"hash_28a1a80b64f97e05", 0);
			level.var_acc853e7.var_6b6eb535 delete();
		}
		level.var_acc853e7 delete();
	}
	if(isdefined(level.var_9488f62c))
	{
		level.var_9488f62c delete();
	}
	if(isdefined(level.var_9e23e046))
	{
		level.var_9e23e046 delete();
	}
	level zm_audio::function_e1666976(#"trap_activate", #"zm_spinning_trap");
	level zm_audio::function_e1666976(#"hash_2c3c478eed0f3b99", #"hook");
}

/*
	Name: function_e78de01b
	Namespace: namespace_a9aa9d72
	Checksum: 0x9C12C5EE
	Offset: 0x9050
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_e78de01b(a_ents)
{
	if(isdefined(a_ents[#"hash_7fb186719bbfd666"]))
	{
		level.var_9488f62c = a_ents[#"hash_7fb186719bbfd666"];
	}
}

/*
	Name: function_b80b6749
	Namespace: namespace_a9aa9d72
	Checksum: 0x9F3AE4B
	Offset: 0x90A0
	Size: 0x816
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b80b6749()
{
	self endon_callback(&function_549f1fcd, #"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	var_aa851834 = undefined;
	a_str_zones = array("cellblock_shower");
	while(!(isdefined(var_aa851834) && var_aa851834))
	{
		foreach(e_player in util::get_players())
		{
			if(isdefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones))
			{
				var_aa851834 = 1;
				break;
			}
		}
		waitframe(1);
	}
	s_scene = struct::get("sh_b_scene", "targetname");
	scene::remove_scene_func(s_scene.scriptbundlename, &function_fdfca800, "init");
	s_scene scene::add_scene_func(s_scene.scriptbundlename, &function_fdfca800, "init");
	s_scene scene::init(#"hash_4b357e771fe94108");
	wait(5);
	level thread function_629fa2c8(#"hash_1e0663f4102106fa", level.var_9d950ce5.var_64c09f7f);
	level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
	level.var_9d950ce5.t_interact setinvisibletoall();
	level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 9);
	/#
		iprintlnbold("");
	#/
	exploder::exploder("fxexp_shower_ambient_ground_fog");
	var_498d47f7 = struct::get_array("sh_ba_fx", "targetname");
	self thread function_cd0d0123(var_498d47f7, "fxexp_flame_wall_door_glow_shower");
	level flag::clear(#"hash_107c5504e3325022");
	s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_of");
	wait(2);
	if(util::get_players().size == 1)
	{
		self thread function_3854c592();
	}
	level.var_9d950ce5.t_interact setvisibletoall();
	level.var_9d950ce5.var_64c09f7f = undefined;
	level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
	level.var_9d950ce5.t_interact setinvisibletoall();
	self thread function_580723de(0, level.var_9d950ce5.var_64c09f7f);
	level thread function_629fa2c8(#"hash_46252c9e0b200ae6", level.var_9d950ce5.var_64c09f7f);
	self thread function_b1aeb165(s_scene);
	self thread function_33701563();
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
	if(var_88706ea7._notify == #"hash_4636f041ae52f0fa" || !isalive(level.var_9d950ce5.var_64c09f7f))
	{
		s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_out");
		var_c74251a4 = scene::function_8582657c(#"hash_4b357e771fe94108", "shot_out");
		wait(var_c74251a4);
	}
	else
	{
		/#
			iprintlnbold("");
		#/
		foreach(e_player in util::get_active_players())
		{
			e_player clientfield::increment_to_player("" + #"hash_55539d0cf92a8855");
			e_player playsoundtoplayer(#"hash_3f03a6b2d8cfc1b9", e_player);
		}
		if(isdefined(level.var_9d950ce5.t_interact))
		{
			level.var_9d950ce5.t_interact setvisibletoplayer(level.var_9d950ce5.var_64c09f7f);
			level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
		}
		self thread function_580723de(1);
		var_7df17d61 = level.var_9d950ce5.origin;
		s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_out");
		var_c74251a4 = scene::function_8582657c(#"hash_4b357e771fe94108", "shot_out");
		wait(var_c74251a4);
		var_9c502e92 = 1;
	}
	exploder::stop_exploder("fxexp_shower_ambient_ground_fog");
	if(isdefined(var_9c502e92) && var_9c502e92)
	{
		self thread function_56e41aa6(var_7df17d61);
		level thread function_ac1d7a0e(#"hash_51300ea0974da947", level.var_9d950ce5.var_64c09f7f);
	}
	self thread function_549f1fcd();
	self notify(#"hash_300e9fed7925cd69", {#b_success:var_9c502e92});
}

/*
	Name: function_fdfca800
	Namespace: namespace_a9aa9d72
	Checksum: 0xA0AAFE70
	Offset: 0x98C0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_fdfca800(a_ents)
{
	if(isdefined(a_ents[#"hash_5c444bf83e9913b4"]))
	{
		level.var_9d950ce5 = a_ents[#"hash_5c444bf83e9913b4"];
		level.var_9d950ce5 thread function_768e71d5();
	}
	if(isdefined(a_ents[#"hash_5c1148f83e6db502"]))
	{
		level.var_4dad7caf = a_ents[#"hash_5c1148f83e6db502"];
		level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 10);
	}
}

/*
	Name: function_b1aeb165
	Namespace: namespace_a9aa9d72
	Checksum: 0x442F400F
	Offset: 0x9990
	Size: 0x228
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b1aeb165(s_scene)
{
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
	s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_wa");
	while(true)
	{
		level.var_9d950ce5.t_interact setvisibletoplayer(level.var_9d950ce5.var_64c09f7f);
		self thread function_aa26a9be(level.var_9d950ce5.var_64c09f7f);
		level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
		self thread function_580723de(1);
		level.var_9d950ce5.var_64c09f7f notify(#"hash_c5c509724d92ec4");
		s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_of");
		level.var_9d950ce5.t_interact setvisibletoall();
		level.var_9d950ce5.var_64c09f7f = undefined;
		level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
		level.var_9d950ce5.t_interact setinvisibletoall();
		self thread function_580723de(0, level.var_9d950ce5.var_64c09f7f);
		s_scene thread scene::play(#"hash_4b357e771fe94108", "shot_wa");
		wait(2);
	}
}

/*
	Name: function_549f1fcd
	Namespace: namespace_a9aa9d72
	Checksum: 0x17F80FE7
	Offset: 0x9BC0
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_549f1fcd(var_c34665fc)
{
	level flag::set(#"hash_107c5504e3325022");
	if(isdefined(level.var_9d950ce5))
	{
		if(isdefined(level.var_9d950ce5.t_interact))
		{
			level.var_9d950ce5.t_interact delete();
		}
		level.var_9d950ce5 delete();
	}
	if(isdefined(level.var_4dad7caf))
	{
		level.var_4dad7caf delete();
	}
	if(isdefined(level.var_7c9cd6ae))
	{
		level.var_7c9cd6ae delete();
	}
	self notify(#"hash_7953672ffc47be3");
}

/*
	Name: function_aa26a9be
	Namespace: namespace_a9aa9d72
	Checksum: 0x272893D0
	Offset: 0x9CB8
	Size: 0xE8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_aa26a9be(e_player)
{
	e_player endon(#"death", #"hash_c5c509724d92ec4");
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
	self thread function_58808acb(e_player);
	wait(60);
	while(isalive(e_player))
	{
		e_player dodamage(10, e_player.origin);
		wait(1);
	}
}

/*
	Name: function_58808acb
	Namespace: namespace_a9aa9d72
	Checksum: 0x9E03D740
	Offset: 0x9DA8
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_58808acb(e_player)
{
	e_player endon(#"hash_c5c509724d92ec4");
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_7953672ffc47be3");
	e_player waittill(#"death", #"player_downed");
	self notify(#"hash_4636f041ae52f0fa");
	e_speaker = zm_utility::get_closest_player(e_player.origin);
	level thread function_629fa2c8(#"hash_26aa170c4122be2b", e_speaker);
}

/*
	Name: function_33701563
	Namespace: namespace_a9aa9d72
	Checksum: 0x494BB8BD
	Offset: 0x9E90
	Size: 0x272
	Parameters: 0
	Flags: Linked, Private
*/
private function function_33701563()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	var_64aaa12a = struct::get_array("showers_kill_pos", "targetname");
	callback::on_ai_killed(&function_c8d4b885);
	level.var_b1060d52 = 0;
	while(true)
	{
		var_45143585 = array::random(var_64aaa12a);
		var_81de1755 = util::spawn_model("tag_origin", var_45143585.origin, var_45143585.angles);
		self thread function_6bb299fa();
		self thread function_613cf0a7(var_81de1755);
		var_d61ccd7e = randomfloatrange(16, 29);
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill_timeout(var_d61ccd7e, #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
		var_81de1755 playsound(#"hash_6f41c19432e2559a");
		var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 0);
		var_81de1755 delete();
		level.var_3f1b1c67 delete();
		if(var_88706ea7._notify == #"hash_7953672ffc47be3" || var_88706ea7._notify == #"hash_4636f041ae52f0fa")
		{
			callback::remove_on_ai_killed(&function_c8d4b885);
			level.var_b1060d52 = undefined;
			return;
		}
		self notify(#"hash_60f9171b687c9d06");
	}
}

/*
	Name: function_613cf0a7
	Namespace: namespace_a9aa9d72
	Checksum: 0x7ED3F326
	Offset: 0xA110
	Size: 0x424
	Parameters: 1
	Flags: Linked, Private
*/
private function function_613cf0a7(var_81de1755)
{
	self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
	level.var_3f1b1c67 = spawn("trigger_radius_new", var_81de1755.origin, 512 | 1 + 2, 80, 64);
	var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 1);
	while(isdefined(var_81de1755))
	{
		var_db30ff9a = 0;
		foreach(e_player in util::get_active_players())
		{
			if(e_player istouching(level.var_3f1b1c67))
			{
				var_db30ff9a++;
			}
		}
		switch(var_db30ff9a)
		{
			case 0:
			{
				if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 1)
				{
					var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 1);
					level.var_3f1b1c67.maxs = (80, 80, 64);
				}
				break;
			}
			case 1:
			{
				if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 2)
				{
					var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 2);
					level.var_3f1b1c67.maxs = (98, 98, 64);
				}
				break;
			}
			case 2:
			{
				if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 3)
				{
					var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 3);
					level.var_3f1b1c67.maxs = (112, 112, 64);
				}
				break;
			}
			case 3:
			case 4:
			{
				if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 4)
				{
					var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 4);
					level.var_3f1b1c67.maxs = (128, 128, 64);
				}
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_6bb299fa
	Namespace: namespace_a9aa9d72
	Checksum: 0xFA2325D9
	Offset: 0xA540
	Size: 0x224
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6bb299fa()
{
	self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
	var_9cdf5d68 = 2;
	var_202d423f = function_841bb7a7();
	while(level.var_b1060d52 < var_202d423f)
	{
		n_percent = level.var_b1060d52 / 29;
		var_6f89c2f6 = int(10 - n_percent * 10);
		if(var_6f89c2f6 != var_9cdf5d68 && var_6f89c2f6 < 9)
		{
			if(isdefined(level.var_4dad7caf))
			{
				level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", var_6f89c2f6);
			}
			var_9cdf5d68 = var_6f89c2f6;
			if(isdefined(level.var_7c9cd6ae))
			{
				level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", var_6f89c2f6);
			}
		}
		wait(0.2);
	}
	self notify(#"hash_7953672ffc47be3");
	if(isdefined(level.var_4dad7caf))
	{
		level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 1);
	}
	if(isdefined(level.var_7c9cd6ae))
	{
		level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", 1);
	}
}

/*
	Name: function_841bb7a7
	Namespace: namespace_a9aa9d72
	Checksum: 0xE74B874
	Offset: 0xA770
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_841bb7a7()
{
	var_550d6907 = 0;
	foreach(player in util::get_active_players())
	{
		if(player zm_zonemgr::is_player_in_zone("cellblock_shower"))
		{
			var_550d6907++;
		}
	}
	var_202d423f = 29 * var_550d6907;
	return var_202d423f;
}

/*
	Name: function_c8d4b885
	Namespace: namespace_a9aa9d72
	Checksum: 0x7F9F76F2
	Offset: 0xA838
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function function_c8d4b885(s_params)
{
	if(isplayer(s_params.eattacker) && isdefined(level.var_3f1b1c67) && s_params.eattacker istouching(level.var_3f1b1c67))
	{
		if(isdefined(level.var_9d950ce5) && isdefined(level.var_9d950ce5.var_64c09f7f) && isdefined(level.var_3f1b1c67) && level.var_9d950ce5.var_64c09f7f istouching(level.var_3f1b1c67))
		{
			self thread function_b952c1b(level.var_9d950ce5.var_64c09f7f, "tag_weapon_right");
			level.var_b1060d52++;
		}
	}
}

/*
	Name: function_580723de
	Namespace: namespace_a9aa9d72
	Checksum: 0x670D7AEB
	Offset: 0xA940
	Size: 0x20C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_580723de(var_1bb50dab = 1, e_player)
{
	self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
	if(var_1bb50dab)
	{
		if(isdefined(level.var_7c9cd6ae))
		{
			level.var_7c9cd6ae unlink();
			level.var_7c9cd6ae delete();
		}
		if(isdefined(level.var_4dad7caf))
		{
			level.var_4dad7caf show();
		}
	}
	else if(isdefined(level.var_4dad7caf))
	{
		level.var_4dad7caf ghost();
	}
	if(isdefined(e_player))
	{
		level.var_7c9cd6ae = util::spawn_model(#"hash_122bc018037432b0", e_player gettagorigin("tag_stowed_back"), e_player gettagangles("tag_stowed_back"));
		level.var_7c9cd6ae linkto(e_player, "tag_stowed_back", (30, -2, -5), (0, 90, -90));
		level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", 10);
		level.var_7c9cd6ae setinvisibletoplayer(e_player);
	}
}

/*
	Name: function_3854c592
	Namespace: namespace_a9aa9d72
	Checksum: 0x7E7B416C
	Offset: 0xAB58
	Size: 0x1CE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3854c592()
{
	var_bdf9e3c2 = "cellblock_shower";
	a_str_active_zones = namespace_57ff8cbb::get_adjacencies_to_zone(var_bdf9e3c2);
	arrayremovevalue(a_str_active_zones, var_bdf9e3c2);
	var_b607f902 = level.zones[var_bdf9e3c2];
	a_str_zones = arraycopy(a_str_active_zones);
	foreach(var_1968096a in a_str_zones)
	{
		if(var_b607f902.adjacent_zones[var_1968096a].is_connected)
		{
			var_b607f902.adjacent_zones[var_1968096a].is_connected = 0;
			continue;
		}
		arrayremovevalue(a_str_active_zones, var_1968096a);
	}
	self waittill(#"death", #"hash_300e9fed7925cd69");
	foreach(var_1968096a in a_str_active_zones)
	{
		var_b607f902.adjacent_zones[var_1968096a].is_connected = 1;
	}
}

/*
	Name: function_c11e25eb
	Namespace: namespace_a9aa9d72
	Checksum: 0x2497C935
	Offset: 0xAD30
	Size: 0x4D6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c11e25eb()
{
	self endon_callback(&function_bc57a72c, #"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	var_4c18a58 = undefined;
	a_str_zones = array("zone_powerhouse");
	while(!(isdefined(var_4c18a58) && var_4c18a58))
	{
		foreach(e_player in util::get_players())
		{
			if(isdefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones))
			{
				var_4c18a58 = 1;
				break;
			}
		}
		waitframe(1);
	}
	self thread function_fb553d70();
	self function_adf8de89(e_player);
	var_58774a5e = struct::get("ph_gen_pos", "targetname");
	self thread function_eab368cb(var_58774a5e);
	self waittill(#"hash_47037a033334904");
	playsoundatposition(#"hash_7a1782a9382ccd72", var_58774a5e.origin);
	self thread function_718e6106();
	var_7ed2d43 = undefined;
	var_7ed2d43 = self waittill(#"hash_2877e7dda4d090c8");
	var_ca60d50 = getent("b64_si_gen", "script_noteworthy");
	var_ca60d50 setmodel(#"hash_12ffdb460266366");
	var_ca60d50 thread scene::play(var_ca60d50.bundle, "ON", var_ca60d50);
	playsoundatposition(#"hash_5a77a78c82aebb7", var_ca60d50.origin);
	exploder::exploder("lgtexp_building64_power_on");
	if(!(isdefined(var_7ed2d43.b_success) && var_7ed2d43.b_success))
	{
		self notify(#"hash_300e9fed7925cd69", {#b_success:b_success});
		self thread function_bc57a72c();
		return;
	}
	self thread function_1fb1907c();
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"hash_75c79817bd1107aa");
	level thread function_629fa2c8(#"hash_57a7dd2d1b78a952", var_88706ea7.activator);
	self thread function_ca9ddf1b();
	self waittill(#"hash_1548855706869d2f");
	self thread function_34e153c7();
	self thread function_bd132295();
	var_9c502e92 = self function_cadaca27();
	self notify(#"hash_3e30564346f7cd94");
	var_7df17d61 = level.var_8eec9430.origin;
	self thread function_bc57a72c();
	if(isdefined(var_9c502e92) && var_9c502e92)
	{
		self thread function_56e41aa6(var_7df17d61);
		level thread function_ac1d7a0e(#"hash_34aad6dd5eebdb0b", e_player);
	}
	self notify(#"hash_300e9fed7925cd69", {#b_success:var_9c502e92});
}

/*
	Name: function_adf8de89
	Namespace: namespace_a9aa9d72
	Checksum: 0xBC1BA09E
	Offset: 0xB210
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function function_adf8de89(e_player)
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	if(!isdefined(level.var_8eec9430))
	{
		var_bc84fb2a = struct::get("ph_gh_sp", "targetname");
		level.var_8eec9430 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_bc84fb2a);
		while(!isdefined(level.var_8eec9430))
		{
			waitframe(1);
			level.var_8eec9430 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_bc84fb2a);
		}
	}
	level.var_8eec9430 function_e128a8d4();
	level.var_8eec9430 thread function_a51841a(e_player, #"hash_4c753651e8079572");
	self thread function_dc369dee("ph_gh_pa");
}

/*
	Name: function_dc369dee
	Namespace: namespace_a9aa9d72
	Checksum: 0x9DDE26A7
	Offset: 0xB390
	Size: 0x762
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dc369dee(var_b51b4b08)
{
	level.var_8eec9430 endon(#"death", #"hash_585dd04498227242");
	self endon(#"death", #"hash_300e9fed7925cd69");
	level.var_8eec9430.goalradius = 16;
	var_3741f4b0 = struct::get_array(var_b51b4b08, "script_noteworthy");
	level.var_8eec9430 waittill_timeout(20, #"goal");
	var_922f086e = 1;
	s_next_pos = array::random(var_3741f4b0);
	level.var_ed42611e = [];
	while(!(isdefined(level.var_8eec9430.var_ecdd7879) && level.var_8eec9430.var_ecdd7879))
	{
		level.var_8eec9430 setgoal(s_next_pos.origin);
		level.var_8eec9430 waittill_timeout(20, #"goal");
		if(isdefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible && isinarray(level.var_62f48651, s_next_pos.script_int))
		{
			var_ad0c3ba3 = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
			var_ad0c3ba3 scene::play(#"hash_fa0e1383821390e", array(level.var_8eec9430, var_ad0c3ba3));
			if(!isdefined(level.var_ed42611e))
			{
				level.var_ed42611e = [];
			}
			else if(!isarray(level.var_ed42611e))
			{
				level.var_ed42611e = array(level.var_ed42611e);
			}
			if(!isinarray(level.var_ed42611e, var_ad0c3ba3))
			{
				level.var_ed42611e[level.var_ed42611e.size] = var_ad0c3ba3;
			}
			arrayremovevalue(level.var_62f48651, s_next_pos.script_int);
			level.var_8eec9430 notify(#"hash_6f38117315565110", {#b_success:1});
			self thread function_3b4d7656(s_next_pos.script_int);
		}
		else
		{
			var_ad0c3ba3 = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
			var_ad0c3ba3 scene::play(#"hash_f73b18cc3a4c4ef", level.var_8eec9430);
			if(!isinarray(level.var_ed42611e, var_ad0c3ba3))
			{
				if(isdefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible && isinarray(level.var_62f48651, s_next_pos.script_int))
				{
					var_ad0c3ba3 = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
					var_ad0c3ba3 scene::play(#"hash_fa0e1383821390e", array(level.var_8eec9430, var_ad0c3ba3));
					if(!isdefined(level.var_ed42611e))
					{
						level.var_ed42611e = [];
					}
					else if(!isarray(level.var_ed42611e))
					{
						level.var_ed42611e = array(level.var_ed42611e);
					}
					if(!isinarray(level.var_ed42611e, var_ad0c3ba3))
					{
						level.var_ed42611e[level.var_ed42611e.size] = var_ad0c3ba3;
					}
					arrayremovevalue(level.var_62f48651, s_next_pos.script_int);
					level.var_8eec9430 notify(#"hash_6f38117315565110", {#b_success:1});
					self thread function_3b4d7656(s_next_pos.script_int);
				}
				else if(isdefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible)
				{
					level.var_8eec9430 notify(#"hash_6f38117315565110", {#b_success:0});
				}
			}
		}
		wait(1);
		var_25d70459 = s_next_pos;
		if(var_922f086e && isdefined(var_25d70459.target))
		{
			s_next_pos = struct::get(var_25d70459.target, "targetname");
		}
		else if(var_922f086e && !isdefined(var_25d70459.target))
		{
			var_922f086e = 0;
			s_next_pos = struct::get(var_25d70459.targetname, "target");
		}
		else if(!var_922f086e && var_25d70459.script_int != 0)
		{
			s_next_pos = struct::get(var_25d70459.targetname, "target");
		}
		else if(!var_922f086e && var_25d70459.script_int == 0)
		{
			var_922f086e = 1;
			s_next_pos = struct::get(var_25d70459.target, "targetname");
		}
	}
}

/*
	Name: function_34e153c7
	Namespace: namespace_a9aa9d72
	Checksum: 0x4991854A
	Offset: 0xBB00
	Size: 0x5D4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_34e153c7()
{
	exploder::exploder("lgtexp_comm_monitors_on");
	var_3ab52107 = array(0, 1, 2, 3, 4, 5);
	var_3ab52107 = array::randomize(var_3ab52107);
	level.var_72ea8db7 = [];
	for(i = 0; i < 6; i++)
	{
		if(!isdefined(level.var_72ea8db7))
		{
			level.var_72ea8db7 = [];
		}
		else if(!isarray(level.var_72ea8db7))
		{
			level.var_72ea8db7 = array(level.var_72ea8db7);
		}
		level.var_72ea8db7[level.var_72ea8db7.size] = var_3ab52107[i];
	}
	var_3ab52107 = array::randomize(var_3ab52107);
	level.var_e2279748 = [];
	for(i = 0; i < 6; i++)
	{
		if(!isdefined(level.var_e2279748))
		{
			level.var_e2279748 = [];
		}
		else if(!isarray(level.var_e2279748))
		{
			level.var_e2279748 = array(level.var_e2279748);
		}
		level.var_e2279748[level.var_e2279748.size] = var_3ab52107[i];
	}
	level.var_62f48651 = [];
	for(i = 0; i < level.var_30e1cfa.size; i++)
	{
		n_result = level.var_e2279748[level.var_30e1cfa[i]];
		if(!isdefined(level.var_62f48651))
		{
			level.var_62f48651 = [];
		}
		else if(!isarray(level.var_62f48651))
		{
			level.var_62f48651 = array(level.var_62f48651);
		}
		level.var_62f48651[level.var_62f48651.size] = n_result;
	}
	level.var_6df70f90 = getentarray("jcc_01", "targetname");
	foreach(var_a001c66d in level.var_6df70f90)
	{
		var_aa794395 = var_a001c66d.origin + anglestoforward(var_a001c66d.angles) * -15;
		var_a001c66d.t_interact = spawn("trigger_radius_use", var_aa794395, 0, 64, 64);
		var_a001c66d.t_interact sethintstring(#"");
		var_a001c66d.t_interact setcursorhint("HINT_NOICON");
		var_a001c66d.t_interact triggerignoreteam();
		var_a001c66d thread function_a9c796c9(1);
		var_a001c66d thread function_3f41df11(self);
	}
	self waittill(#"death", #"hash_300e9fed7925cd69");
	foreach(var_a001c66d in level.var_6df70f90)
	{
		var_a001c66d setmodel(#"hash_15811ad0143213e9");
		var_a001c66d.t_interact delete();
		var_a001c66d thread function_a9c796c9(0);
	}
	var_e1b1210d = getent("md_te_mi", "targetname");
	var_e1b1210d setmodel(#"hash_75a106abbb5f5fa1");
	var_e1b1210d playsound(#"hash_4bf7a429b9e473");
	var_e1b1210d stoploopsound();
	exploder::stop_exploder("lgtexp_comm_monitors_on");
}

/*
	Name: function_a9c796c9
	Namespace: namespace_a9aa9d72
	Checksum: 0x9C11B3F
	Offset: 0xC0E0
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_a9c796c9(var_ad361c37)
{
	self endon(#"death");
	wait(randomfloatrange(0, 0.4));
	if(var_ad361c37)
	{
		self playsound(#"hash_36db3f0a61c9a48f");
		self playloopsound(#"hash_36df3b0a61cd869a");
	}
	else
	{
		self stoploopsound();
		self playsound(#"hash_4bf7a429b9e473");
	}
}

/*
	Name: function_3f41df11
	Namespace: namespace_a9aa9d72
	Checksum: 0xCEED00BC
	Offset: 0xC1A8
	Size: 0x254
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3f41df11(var_aa11c23c)
{
	var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69");
	var_fda10a91 = array(#"hash_7b807c00f606fd42", #"hash_7b807b00f606fb8f", #"hash_7b807a00f606f9dc", #"hash_7b807900f606f829", #"hash_7b807800f606f676", #"hash_7b807700f606f4c3", #"hash_7b807600f606f310", #"hash_7b808500f6070c8d", #"hash_7b808400f6070ada", #"hash_7b7cf700f603e56c", #"hash_7b7cf800f603e71f", #"hash_7b7cf900f603e8d2");
	var_bef01ba5 = level.var_72ea8db7[self.script_int];
	var_d7fe6e89 = var_fda10a91[var_bef01ba5];
	var_888f63a1 = level.var_e2279748[var_bef01ba5] + 6;
	var_6695748c = var_fda10a91[var_888f63a1];
	self setmodel(var_d7fe6e89);
	var_a9ef48ba = var_6695748c;
	while(isdefined(self.t_interact))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			self setmodel(var_a9ef48ba);
			self playsound(#"hash_552ae6616a45cb98");
			if(var_a9ef48ba == var_6695748c)
			{
				var_a9ef48ba = var_d7fe6e89;
			}
			else
			{
				var_a9ef48ba = var_6695748c;
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_cadaca27
	Namespace: namespace_a9aa9d72
	Checksum: 0x425456B0
	Offset: 0xC408
	Size: 0x1CA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cadaca27()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	level.var_8eec9430 endon(#"death");
	level.var_8eec9430.script_noteworthy = "blast_attack_interactables";
	while(!(isdefined(level.var_8eec9430.var_ecdd7879) && level.var_8eec9430.var_ecdd7879))
	{
		level.var_8eec9430 waittill(#"hash_6fd7f8e1f00deffe");
		level.var_8eec9430 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
		level.var_8eec9430.b_visible = 1;
		var_88706ea7 = undefined;
		var_88706ea7 = level.var_8eec9430 waittill(#"hash_6f38117315565110");
		level.var_8eec9430 clientfield::set("" + #"hash_65da20412fcaf97e", 2);
		level.var_8eec9430.b_visible = undefined;
		if(!(isdefined(var_88706ea7.b_success) && var_88706ea7.b_success))
		{
			level.var_8eec9430.var_ecdd7879 = 1;
			return 0;
		}
		if(level.var_62f48651.size <= 0)
		{
			level.var_8eec9430.var_ecdd7879 = 1;
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_3b4d7656
	Namespace: namespace_a9aa9d72
	Checksum: 0x76D210F0
	Offset: 0xC5E0
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function function_3b4d7656(n_num)
{
	level.var_8eec9430 endon(#"death", #"hash_585dd04498227242");
	self endon(#"death", #"hash_300e9fed7925cd69");
	switch(n_num)
	{
		case 0:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
		case 1:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
		case 2:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
		case 3:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
		case 4:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
		case 5:
		{
			var_52eca396 = getent("ph_p_1", "script_noteworthy");
			break;
		}
	}
	var_52eca396 thread scene::play(var_52eca396.bundle, "GREEN", var_52eca396);
	var_52eca396 playsound(#"hash_30d4c7c667c80123");
	wait(3);
	var_52eca396 thread scene::play(var_52eca396.bundle, "RESET", var_52eca396);
}

/*
	Name: function_eab368cb
	Namespace: namespace_a9aa9d72
	Checksum: 0xDE76303C
	Offset: 0xC830
	Size: 0x2D6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_eab368cb(s_interact)
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	var_ca60d50 = getent("b64_si_gen", "script_noteworthy");
	var_ca60d50 setmodel(#"hash_15aa134ac94c6614");
	var_ca60d50 thread scene::play(var_ca60d50.bundle, "OFF", var_ca60d50);
	s_interact.var_b31fa41a = util::spawn_model("tag_origin", s_interact.origin, s_interact.angles);
	s_interact.var_b31fa41a clientfield::set("" + #"hash_64f2dd36b17bf17", 1);
	s_interact.t_interact = spawn("trigger_radius_use", s_interact.origin, 0, 128, 64);
	s_interact.t_interact sethintstring(#"");
	s_interact.t_interact setcursorhint("HINT_NOICON");
	s_interact.t_interact triggerignoreteam();
	s_interact.t_interact setvisibletoall();
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = s_interact.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			s_interact.var_64c09f7f = var_88706ea7.activator;
			break;
		}
	}
	s_interact.t_interact delete();
	s_interact.var_b31fa41a clientfield::set("" + #"hash_64f2dd36b17bf17", 0);
	s_interact.var_b31fa41a delete();
	exploder::stop_exploder("lgtexp_building64_power_on");
	self notify(#"hash_47037a033334904");
}

/*
	Name: function_718e6106
	Namespace: namespace_a9aa9d72
	Checksum: 0x788E5174
	Offset: 0xCB10
	Size: 0x5C0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_718e6106()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	b_success = undefined;
	if(!isdefined(level.var_6ab72806))
	{
		level.var_6ab72806 = 5;
	}
	if(!isdefined(level.var_f7febee4))
	{
		level function_18b599e0();
	}
	b_success = self function_dc164d78();
	self notify(#"hash_3e30564346f7cd94");
	self notify(#"hash_2877e7dda4d090c8", {#b_success:b_success});
	if(isdefined(b_success) && b_success)
	{
		level.var_f7febee4 = array::randomize(level.var_f7febee4);
		level.var_30e1cfa = array(level.var_f7febee4[0].script_int, level.var_f7febee4[1].script_int, level.var_f7febee4[2].script_int);
		var_abad41d = [];
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			if(isinarray(level.var_30e1cfa, var_7b2c16b1.script_int))
			{
				if(!isdefined(var_abad41d))
				{
					var_abad41d = [];
				}
				else if(!isarray(var_abad41d))
				{
					var_abad41d = array(var_abad41d);
				}
				if(!isinarray(var_abad41d, var_7b2c16b1.var_307df34b))
				{
					var_abad41d[var_abad41d.size] = var_7b2c16b1.var_307df34b;
				}
				var_7b2c16b1.var_307df34b setmodel(#"hash_41eb00e7f82d89ea");
				var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 1);
				continue;
			}
			var_7b2c16b1.var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
			var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
		}
		wait(6);
		var_a94e126 = 0;
		var_47df32b8 = 1;
		while(var_a94e126 < 7)
		{
			foreach(var_307df34b in var_abad41d)
			{
				if(isdefined(var_47df32b8) && var_47df32b8)
				{
					var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
					var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
					var_47df32b8 = 0;
					continue;
				}
				var_307df34b setmodel(#"hash_41eb00e7f82d89ea");
				var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 1);
				var_47df32b8 = 1;
			}
			var_a94e126++;
			wait(0.2);
		}
	}
	level.var_89231fe9 = undefined;
	level.var_84fbe7bc = undefined;
	if(isdefined(level.var_f7febee4))
	{
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			if(isdefined(var_7b2c16b1.var_307df34b))
			{
				var_7b2c16b1.var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
				var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
			}
			if(isdefined(var_7b2c16b1.t_interact))
			{
				var_7b2c16b1.t_interact setinvisibletoall();
			}
		}
	}
}

/*
	Name: function_18b599e0
	Namespace: namespace_a9aa9d72
	Checksum: 0x1843B25B
	Offset: 0xD0D8
	Size: 0x326
	Parameters: 0
	Flags: Linked
*/
function function_18b599e0()
{
	level.var_f7febee4 = struct::get_array("64_sm_pos", "targetname");
	foreach(var_7b2c16b1 in level.var_f7febee4)
	{
		var_7b2c16b1.var_9e7c3935 = util::spawn_model(var_7b2c16b1.model, var_7b2c16b1.origin, var_7b2c16b1.angles);
		var_7b2c16b1.var_307df34b = getent(var_7b2c16b1.target, "targetname");
		var_7b2c16b1.t_interact = spawn("trigger_radius_use", var_7b2c16b1.origin, 0, 64, 64);
		var_7b2c16b1.t_interact sethintstring(#"");
		var_7b2c16b1.t_interact setcursorhint("HINT_NOICON");
		var_7b2c16b1.t_interact triggerignoreteam();
		var_7b2c16b1.t_interact setinvisibletoall();
	}
	level.var_b530c85c = [];
	var_dcb38ed6 = struct::get_array("ph_sm_pos", "targetname");
	foreach(var_85151c86 in var_dcb38ed6)
	{
		var_9e7c3935 = util::spawn_model(var_85151c86.model, var_85151c86.origin, var_85151c86.angles);
		if(!isdefined(level.var_b530c85c))
		{
			level.var_b530c85c = [];
		}
		else if(!isarray(level.var_b530c85c))
		{
			level.var_b530c85c = array(level.var_b530c85c);
		}
		if(!isinarray(level.var_b530c85c, var_9e7c3935))
		{
			level.var_b530c85c[level.var_b530c85c.size] = var_9e7c3935;
		}
	}
}

/*
	Name: function_dc164d78
	Namespace: namespace_a9aa9d72
	Checksum: 0x10BBBFCC
	Offset: 0xD408
	Size: 0x648
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dc164d78()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	level.var_84fbe7bc = function_1b0a3e6e();
	var_56eace20 = 1;
	b_trace_passed = 0;
	n_start_time = gettime();
	n_total_time = 0;
	while(!(isdefined(b_trace_passed) && b_trace_passed) & n_total_time < 6.1)
	{
		foreach(e_player in util::get_players())
		{
			if(isdefined(level.var_84fbe7bc[0].var_9e7c3935 sightconetrace(e_player geteye(), e_player, vectornormalize(e_player getplayerangles()), 30)) && level.var_84fbe7bc[0].var_9e7c3935 sightconetrace(e_player geteye(), e_player, vectornormalize(e_player getplayerangles()), 30))
			{
				b_trace_passed = 1;
				break;
			}
		}
		waitframe(1);
		n_current_time = gettime();
		n_total_time = n_current_time - n_start_time / 1000;
	}
	self thread function_bd132295();
	while(var_56eace20 <= level.var_6ab72806)
	{
		for(i = 0; i < var_56eace20; i++)
		{
			level.var_84fbe7bc[i].var_307df34b setmodel(#"hash_41eb00e7f82d89ea");
			level.var_84fbe7bc[i].var_307df34b clientfield::set("" + #"hash_119729072e708651", 1);
			wait(3.9);
			level.var_84fbe7bc[i].var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
			level.var_84fbe7bc[i].var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
			if(var_56eace20 > 1)
			{
				wait(1.3);
			}
		}
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			var_7b2c16b1.t_interact setvisibletoall();
		}
		level.var_89231fe9 = 0;
		array::thread_all(level.var_f7febee4, &function_81650808, self, var_56eace20);
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill_timeout(30, #"hash_34486fb413da1672");
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			var_7b2c16b1.t_interact setinvisibletoall();
		}
		if(!(isdefined(var_88706ea7.b_success) && var_88706ea7.b_success))
		{
			if(isdefined(var_88706ea7.e_player))
			{
				var_88706ea7.e_player playlocalsound(#"hash_1588095b858588d");
			}
			return 0;
		}
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			if(isdefined(var_7b2c16b1.var_307df34b))
			{
				var_7b2c16b1.var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
				var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
			}
		}
		var_56eace20++;
		level.var_84fbe7bc = function_1b0a3e6e();
	}
	playsoundatposition(#"hash_2218138040c6b2ff", (0, 0, 0));
	return 1;
}

/*
	Name: function_81650808
	Namespace: namespace_a9aa9d72
	Checksum: 0xD0C58854
	Offset: 0xDA58
	Size: 0x1F8
	Parameters: 2
	Flags: Linked, Private
*/
private function function_81650808(var_aa11c23c, var_56eace20)
{
	var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69", #"hash_34486fb413da1672");
	while(level.var_89231fe9 < var_56eace20)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self.t_interact waittill(#"trigger");
		self.var_307df34b setmodel(#"hash_41eb00e7f82d89ea");
		self.var_307df34b clientfield::set("" + #"hash_119729072e708651", 1);
		wait(1);
		self.var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
		self.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
		wait(1);
		if(self !== level.var_84fbe7bc[level.var_89231fe9])
		{
			var_aa11c23c notify(#"hash_34486fb413da1672", {#e_player:var_88706ea7.activator, #b_success:0});
		}
		level.var_89231fe9++;
	}
	var_aa11c23c notify(#"hash_34486fb413da1672", {#e_player:var_88706ea7.activator, #b_success:1});
}

/*
	Name: function_1b0a3e6e
	Namespace: namespace_a9aa9d72
	Checksum: 0x8D63BC3D
	Offset: 0xDC58
	Size: 0x16A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1b0a3e6e()
{
	var_84fbe7bc = [];
	var_f3b29ae8 = undefined;
	for(i = 0; i < level.var_6ab72806; i++)
	{
		s_pos[i] = array::random(level.var_f7febee4);
		if(i >= 2 && (s_pos[i] == var_f3b29ae8 && s_pos[i] == s_pos[i - 2]))
		{
			while(s_pos[i] === var_f3b29ae8)
			{
				s_pos[i] = array::random(level.var_f7febee4);
			}
		}
		if(!isdefined(var_84fbe7bc))
		{
			var_84fbe7bc = [];
		}
		else if(!isarray(var_84fbe7bc))
		{
			var_84fbe7bc = array(var_84fbe7bc);
		}
		var_84fbe7bc[var_84fbe7bc.size] = s_pos[i];
		var_f3b29ae8 = s_pos[i];
	}
	return var_84fbe7bc;
}

/*
	Name: function_bc57a72c
	Namespace: namespace_a9aa9d72
	Checksum: 0x54B3B7DB
	Offset: 0xDDD0
	Size: 0x40C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bc57a72c(var_c34665fc)
{
	if(isdefined(level.var_ed42611e) && level.var_ed42611e.size)
	{
		foreach(var_7cc5799f in level.var_ed42611e)
		{
			if(!isdefined(var_7cc5799f))
			{
				continue;
			}
			var_7cc5799f scene::stop(#"hash_fa0e1383821390e");
			var_7cc5799f animation::stop();
			waitframe(1);
			if(isdefined(var_7cc5799f))
			{
				var_7cc5799f thread scene::init(#"hash_fa0e1383821390e", array(level.var_8eec9430, var_7cc5799f));
			}
		}
		level.var_ed42611e = undefined;
	}
	if(isdefined(level.var_8eec9430))
	{
		level.var_8eec9430 notify(#"hash_585dd04498227242");
		level.var_8eec9430 delete();
	}
	var_58774a5e = struct::get("ph_gen_pos", "targetname");
	if(isdefined(var_58774a5e.t_interact))
	{
		var_58774a5e.t_interact delete();
	}
	if(isdefined(var_58774a5e.var_b31fa41a))
	{
		var_58774a5e.var_b31fa41a delete();
	}
	level.var_89231fe9 = undefined;
	level.var_84fbe7bc = undefined;
	if(isdefined(level.var_f7febee4))
	{
		foreach(var_7b2c16b1 in level.var_f7febee4)
		{
			if(isdefined(var_7b2c16b1.var_307df34b))
			{
				var_7b2c16b1.var_307df34b setmodel(#"hash_2fc1262ab54a0c5c");
				var_7b2c16b1.var_307df34b clientfield::set("" + #"hash_119729072e708651", 0);
			}
			if(isdefined(var_7b2c16b1.t_interact))
			{
				var_7b2c16b1.t_interact setinvisibletoall();
			}
		}
	}
	var_78fda516 = struct::get("ph_pc_pos", "targetname");
	if(isdefined(var_78fda516.var_11e3fffb))
	{
		var_78fda516.var_11e3fffb delete();
	}
	if(isdefined(var_78fda516.t_interact))
	{
		var_78fda516.t_interact delete();
	}
	var_e1b1210d = getent("md_te_mi", "targetname");
	if(isdefined(var_e1b1210d))
	{
		var_e1b1210d setmodel(#"hash_75a106abbb5f5fa1");
		if(isdefined(var_e1b1210d.t_interact))
		{
			var_e1b1210d.t_interact delete();
		}
	}
}

/*
	Name: function_1fb1907c
	Namespace: namespace_a9aa9d72
	Checksum: 0x6037BEF3
	Offset: 0xE1E8
	Size: 0x22E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1fb1907c()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	var_78fda516 = struct::get("ph_pc_pos", "targetname");
	var_78fda516.var_11e3fffb = util::spawn_model(var_78fda516.model, var_78fda516.origin, var_78fda516.angles);
	var_78fda516.var_11e3fffb playsound(#"hash_13aeee936e183bc7");
	var_78fda516.t_interact = spawn("trigger_radius_use", var_78fda516.origin, 0, 64, 64);
	var_78fda516.t_interact sethintstring(#"");
	var_78fda516.t_interact setcursorhint("HINT_NOICON");
	var_78fda516.t_interact triggerignoreteam();
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_78fda516.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			var_88706ea7.activator playsound(#"hash_5cc174edb720191c");
			var_78fda516.var_11e3fffb delete();
			break;
		}
	}
	self notify(#"hash_75c79817bd1107aa", {#activator:var_88706ea7.activator});
}

/*
	Name: function_ca9ddf1b
	Namespace: namespace_a9aa9d72
	Checksum: 0x11BEF12A
	Offset: 0xE420
	Size: 0x228
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ca9ddf1b()
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	var_e1b1210d = getent("md_te_mi", "targetname");
	var_aa794395 = var_e1b1210d.origin + anglestoforward(var_e1b1210d.angles) * -15 + vectorscale((0, 0, 1), 5);
	var_e1b1210d.t_interact = spawn("trigger_radius_use", var_aa794395, 0, 64, 64);
	var_e1b1210d.t_interact sethintstring(#"");
	var_e1b1210d.t_interact setcursorhint("HINT_NOICON");
	var_e1b1210d.t_interact triggerignoreteam();
	while(isdefined(var_e1b1210d.t_interact))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_e1b1210d.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			var_e1b1210d setmodel(#"hash_1cfe304d7d3199a5");
			var_e1b1210d playsound(#"hash_2ebc34552a47c16f");
			var_e1b1210d playloopsound(#"hash_2ebf30552a49f07a");
			self notify(#"hash_1548855706869d2f");
			var_e1b1210d.t_interact delete();
		}
	}
}

/*
	Name: function_fb553d70
	Namespace: namespace_a9aa9d72
	Checksum: 0x39B79080
	Offset: 0xE650
	Size: 0x210
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fb553d70()
{
	level scene::add_scene_func(#"hash_ebbd500183a767f", &function_23467a20, "play");
	level scene::add_scene_func(#"hash_ebbd600183a7832", &function_23467a20, "play");
	level scene::add_scene_func(#"hash_ebbd700183a79e5", &function_23467a20, "play");
	level scene::add_scene_func(#"hash_ebbd000183a6e00", &function_23467a20, "play");
	var_fd2e212e = struct::get_array("ph_gh_pi", "targetname");
	foreach(var_6c72ee3e in var_fd2e212e)
	{
		var_6c72ee3e thread scene::play();
	}
	self waittill(#"death", #"hash_300e9fed7925cd69");
	foreach(var_6c72ee3e in var_fd2e212e)
	{
		var_6c72ee3e thread scene::stop();
	}
}

/*
	Name: function_23467a20
	Namespace: namespace_a9aa9d72
	Checksum: 0x78B4977
	Offset: 0xE868
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_23467a20(a_ents)
{
	foreach(e_ent in a_ents)
	{
		e_ent clientfield::set("" + #"hash_504d26c38b96651c", 1);
		e_ent clientfield::set("" + #"hash_65da20412fcaf97e", 1);
	}
}

/*
	Name: function_bd132295
	Namespace: namespace_a9aa9d72
	Checksum: 0x5469AE97
	Offset: 0xE948
	Size: 0xE2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bd132295()
{
	self endon(#"death", #"hash_300e9fed7925cd69", #"hash_3e30564346f7cd94");
	if(util::get_players().size == 1)
	{
		return;
	}
	while(true)
	{
		wait(randomfloatrange(3, 15));
		if(zombie_utility::get_current_zombie_count() < zombie_utility::function_d2dfacfd(#"zombie_max_ai"))
		{
			ai_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
		}
	}
}

/*
	Name: function_629fa2c8
	Namespace: namespace_a9aa9d72
	Checksum: 0x79A6BA94
	Offset: 0xEA38
	Size: 0x314
	Parameters: 2
	Flags: Linked, Private
*/
private function function_629fa2c8(var_5b9ba5a5, e_player)
{
	level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");
	if(!isalive(e_player))
	{
		e_player = array::random(util::get_active_players());
	}
	switch(var_5b9ba5a5)
	{
		case "hash_57e9c23bed1bd753":
		{
			str_vo_line = #"hash_e6dbc38573eb591";
			break;
		}
		case "hash_215fb85a66e4b593":
		{
			str_vo_line = #"hash_75dd4d3a12f7a4ff";
			break;
		}
		case "hash_2ea20c8cd81b5464":
		{
			str_vo_line = #"hash_2db7e999104e9d85";
			break;
		}
		case "hash_72bb7bc935d4da67":
		{
			str_vo_line = #"hash_7908358765812286";
			break;
		}
		case "hash_fd8e78c22906fc1":
		{
			str_vo_line = #"hash_5f84ae79adca64b4";
			break;
		}
		case "hash_115ac6d40d4cc85b":
		{
			str_vo_line = #"hash_459548ac9c477e2e";
			break;
		}
		case "hash_1d191ca6765471c6":
		{
			str_vo_line = #"hash_58698646dc41b7cc";
			break;
		}
		case "hash_7cf90fc327de893e":
		{
			str_vo_line = #"hash_346283ac47189915";
			break;
		}
		case "hash_7ab135537c096a5a":
		{
			str_vo_line = #"hash_4de71ac9ed523e0f";
			break;
		}
		case "hash_4c753651e8079572":
		{
			str_vo_line = #"hash_6a36332b44f8f69";
			break;
		}
		case "hash_487ac9fba78b1604":
		{
			str_vo_line = #"hash_6aa237e9482e5cd2";
			break;
		}
		case "hash_57a7dd2d1b78a952":
		{
			str_vo_line = #"hash_449831e8d03243ab";
			break;
		}
		case "hash_1e0663f4102106fa":
		{
			str_vo_line = #"hash_21d36ad9aebdc862";
			break;
		}
		case "hash_46252c9e0b200ae6":
		{
			str_vo_line = #"hash_420cd62afa5f7e5f";
			break;
		}
		case "hash_26aa170c4122be2b":
		{
			str_vo_line = #"hash_7cf068b4ca0db57b";
			break;
		}
	}
	e_player namespace_891c9bac::function_a2bd5a0c(str_vo_line, 0, 1, 9999, 0, 0, 1);
}

/*
	Name: function_ac1d7a0e
	Namespace: namespace_a9aa9d72
	Checksum: 0x8F3664CD
	Offset: 0xED58
	Size: 0x42A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ac1d7a0e(var_5b9ba5a5, e_player)
{
	level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");
	if(!isalive(e_player))
	{
		e_player = array::random(util::get_active_players());
	}
	e_richtofen = namespace_69ddf44f::function_b1203924();
	var_2c5c52cb = e_player namespace_48f3568::function_d35e4c92() - 5;
	switch(var_5b9ba5a5)
	{
		case "hash_368df266f54ec3b1":
		{
			str_vo_line = #"hash_49abe33ce5251a4b";
			var_6d4b089d = #"hash_4a5baedb3bc6ec08";
			var_566e10e3 = #"hash_49abe53ce5251db1";
			break;
		}
		case "hash_7d360b71501ba662":
		{
			str_vo_line = #"hash_647c6e21cc49b3cc";
			var_6d4b089d = #"hash_1ec507e435e1a4bd";
			var_566e10e3 = #"hash_647c7021cc49b732";
			break;
		}
		case "hash_53aafd7783e33981":
		{
			str_vo_line = #"hash_6fb17b666e2addfb";
			var_6d4b089d = #"hash_5cfddff273a7cf98";
			var_566e10e3 = #"hash_6fb17d666e2ae161";
			break;
		}
		case "hash_34aad6dd5eebdb0b":
		{
			str_vo_line = #"hash_da5ecd0d4841b4a";
			var_6d4b089d = #"hash_4b6f538c82ce10eb";
			var_566e10e3 = #"hash_da5ead0d48417e4";
			break;
		}
		case "hash_51300ea0974da947":
		{
			str_vo_line = #"hash_3563aeaee897cb95";
			var_6d4b089d = #"hash_54fabdc91a5724b2";
			var_566e10e3 = #"hash_3563acaee897c82f";
			break;
		}
		case "hash_334295910a49036e":
		{
			str_vo_line = #"hash_780ebb7a9f39cdc8";
			var_6d4b089d = #"hash_69a626c29083fc71";
			var_566e10e3 = #"hash_780ebd7a9f39d12e";
			break;
		}
	}
	var_a8d847a7 = undefined;
	while(!(isdefined(var_a8d847a7) && var_a8d847a7))
	{
		namespace_891c9bac::function_3c173d37(e_player.origin, 512);
		var_a8d847a7 = e_player namespace_891c9bac::function_a2bd5a0c(str_vo_line, 0, 1, 9999);
	}
	if(!isdefined(e_richtofen) || !isalive(e_richtofen) || (!(isdefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6)))
	{
		return;
	}
	e_richtofen namespace_891c9bac::function_57b8cd17();
	var_26e0e1ec = e_richtofen namespace_891c9bac::function_8e0f4696(var_6d4b089d, 0, 1, 9999, 1, 1, 1);
	var_350e5be3 = undefined;
	while(!(isdefined(var_350e5be3) && var_350e5be3) && isalive(e_richtofen))
	{
		namespace_891c9bac::function_3c173d37(e_richtofen.origin, 512);
		var_350e5be3 = e_richtofen namespace_891c9bac::function_a2bd5a0c(var_566e10e3, 0, 1, 9999);
	}
}

/*
	Name: function_29d29761
	Namespace: namespace_a9aa9d72
	Checksum: 0x481C7C99
	Offset: 0xF190
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
private function function_29d29761(e_ghost, var_5b9ba5a5)
{
	e_ghost endon(#"death", #"hash_29156bb763ad6672");
	self endon(#"disconnect");
	while(true)
	{
		if(self zm_utility::is_player_looking_at(e_ghost getcentroid()) && self clientfield::get("" + #"hash_184a34e85c29399f"))
		{
			if(!(isdefined(level.var_9cb7c32e) && level.var_9cb7c32e))
			{
				level.var_9cb7c32e = 1;
				level function_629fa2c8(#"hash_57e9c23bed1bd753", self);
				wait(0.5);
			}
			level thread function_629fa2c8(var_5b9ba5a5, self);
			e_ghost notify(#"hash_29156bb763ad6672");
		}
		waitframe(1);
	}
}

/*
	Name: function_a9277243
	Namespace: namespace_a9aa9d72
	Checksum: 0x4836C428
	Offset: 0xF2E0
	Size: 0x128
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a9277243()
{
	self endon(#"death");
	self.t_interact = spawn("trigger_radius_use", self.origin, 0, 94, 64);
	self.t_interact sethintstring(#"");
	self.t_interact setcursorhint("HINT_NOICON");
	self.t_interact triggerignoreteam();
	while(isdefined(self.t_interact))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			self notify(#"hash_1f3cf68a268a10f1");
			self.t_interact delete();
		}
	}
}

/*
	Name: function_e128a8d4
	Namespace: namespace_a9aa9d72
	Checksum: 0x5F12A279
	Offset: 0xF410
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e128a8d4(var_982513ee = 1)
{
	if(!var_982513ee)
	{
		self clientfield::set("" + #"hash_3e506d7aedac6ae0", 10);
	}
	self setteam(util::get_enemy_team(level.zombie_team));
	self.health = 961;
	self val::set(#"hash_7e90c10175dadf0f", "ignoreme", 1);
	self val::set(#"hash_7e90c10175dadf0f", "ignoreall", 1);
	self val::set(#"hash_7e90c10175dadf0f", "allowdeath", 0);
	self setcandamage(0);
	self.b_ignore_cleanup = 1;
	self.var_77858b62 = &function_1cda4094;
	self.disable_flame_fx = 1;
	self notsolid();
}

/*
	Name: function_3e62ca0b
	Namespace: namespace_a9aa9d72
	Checksum: 0x41BFE1D0
	Offset: 0xF590
	Size: 0xBE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3e62ca0b(var_84200bb4)
{
	self endon(#"death", #"hash_300e9fed7925cd69");
	var_84200bb4 endon(#"death", #"hash_6fd7f8e1f00deffe", #"hash_585dd04498227242");
	wait(90);
	level waittill(#"between_round_over");
	self notify(#"hash_300e9fed7925cd69", {#hash_d0af61fc:1, #b_success:0});
}

/*
	Name: function_a51841a
	Namespace: namespace_a9aa9d72
	Checksum: 0x6D99AAD4
	Offset: 0xF658
	Size: 0x7C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a51841a(e_attacker, var_5b9ba5a5)
{
	self clientfield::set("" + #"hash_65da20412fcaf97e", 1);
	array::thread_all(util::get_players(), &function_29d29761, self, var_5b9ba5a5);
}

/*
	Name: function_1db8a8b2
	Namespace: namespace_a9aa9d72
	Checksum: 0x82313ABC
	Offset: 0xF6E0
	Size: 0x1DA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1db8a8b2(var_b51b4b08)
{
	self endon(#"death", #"hash_585dd04498227242");
	var_3741f4b0 = struct::get_array(var_b51b4b08, "script_noteworthy");
	var_25d70459 = arraygetclosest(self.origin, var_3741f4b0);
	s_next_pos = struct::get(var_25d70459.target, "targetname");
	self.goalradius = 64;
	v_pos = getclosestpointonnavmesh(var_25d70459.origin, 128, 16);
	/#
		assert(isdefined(v_pos), "" + var_25d70459.origin);
	#/
	wait(2.9);
	self setgoal(v_pos);
	self waittill_timeout(20, #"goal");
	while(true)
	{
		self setgoal(s_next_pos.origin);
		self waittill_timeout(20, #"goal");
		var_25d70459 = s_next_pos;
		if(isdefined(var_25d70459.target))
		{
			s_next_pos = struct::get(var_25d70459.target, "targetname");
		}
	}
}

/*
	Name: function_768e71d5
	Namespace: namespace_a9aa9d72
	Checksum: 0x86517C00
	Offset: 0xF8C8
	Size: 0x1E8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_768e71d5()
{
	self endon(#"death", #"hash_71716a8e79096aee");
	self.t_interact = spawn("trigger_radius_use", self.origin + anglestoforward(self.angles) * 15 + vectorscale((0, 0, 1), 5), 0, 64, 64);
	self.t_interact enablelinkto();
	self.t_interact linkto(self);
	self.t_interact sethintstring(#"");
	self.t_interact setcursorhint("HINT_NOICON");
	self.t_interact triggerignoreteam();
	self.t_interact setvisibletoall();
	self.t_interact endon(#"death");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			self notify(#"hash_17de7292d988f537");
			self.var_64c09f7f = var_88706ea7.activator;
			self playsound(#"hash_3ebf00b76f5438f8");
		}
	}
}

/*
	Name: function_cd0d0123
	Namespace: namespace_a9aa9d72
	Checksum: 0x1696C63
	Offset: 0xFAB8
	Size: 0x1FC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_cd0d0123(var_498d47f7, str_exploder)
{
	var_d3c21d73 = vectorscale((0, 0, 1), 48);
	level zm_bgb_anywhere_but_here::function_886fce8f(0);
	foreach(var_71e6f067 in var_498d47f7)
	{
		var_71e6f067.mdl_collision = util::spawn_model("collision_player_wall_128x128x10", var_71e6f067.origin + var_d3c21d73, var_71e6f067.angles);
		var_71e6f067.mdl_collision ghost();
	}
	if(isdefined(str_exploder))
	{
		exploder::exploder(str_exploder);
	}
	self waittill(#"death", #"hash_300e9fed7925cd69");
	if(isdefined(str_exploder))
	{
		exploder::stop_exploder(str_exploder);
	}
	foreach(var_71e6f067 in var_498d47f7)
	{
		if(isdefined(var_71e6f067.mdl_collision))
		{
			var_71e6f067.mdl_collision delete();
		}
	}
	level zm_bgb_anywhere_but_here::function_886fce8f(1);
}

/*
	Name: function_1cda4094
	Namespace: namespace_a9aa9d72
	Checksum: 0x42B02350
	Offset: 0xFCC0
	Size: 0x316
	Parameters: 1
	Flags: Linked
*/
function function_1cda4094(e_player)
{
	self notify(#"hash_3f91506396266ee6");
	self endon(#"hash_3f91506396266ee6");
	e_player endon(#"disconnect");
	if(!isalive(self) || (isdefined(self.var_5bf7575e) && self.var_5bf7575e) || (isdefined(self.aat_turned) && self.aat_turned) || (!(isdefined(self.var_c95261d) && self.var_c95261d)))
	{
		return;
	}
	self.var_5bf7575e = 1;
	self ai::stun();
	self.instakill_func = &function_6472c628;
	if(!self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
	{
		var_21c1ba1 = e_player getentitynumber();
		self clientfield::set("" + #"hash_1b02e77fdbc51a4d", var_21c1ba1 + 1);
		e_player clientfield::set("" + #"hash_1efc6bf68f09d02c", 2);
	}
	while(e_player.var_f1b20bef === self && isalive(self) && (isdefined(self.var_c95261d) && self.var_c95261d))
	{
		waitframe(1);
	}
	var_d64818ae = e_player clientfield::get("" + #"hash_1efc6bf68f09d02c");
	if(e_player attackbuttonpressed() && var_d64818ae === 2)
	{
		e_player clientfield::set("" + #"hash_1efc6bf68f09d02c", 1);
	}
	if(isalive(self))
	{
		if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
		{
			self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
		}
		self.var_5bf7575e = 0;
		self ai::function_62795e55();
		self.instakill_func = undefined;
	}
}

/*
	Name: function_6472c628
	Namespace: namespace_a9aa9d72
	Checksum: 0xDCBA3C19
	Offset: 0xFFE0
	Size: 0x6E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_6472c628(e_player, mod, shitloc)
{
	w_current = e_player getcurrentweapon();
	if(w_current === level.var_d7e67022 || w_current === level.var_637136f3)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b952c1b
	Namespace: namespace_a9aa9d72
	Checksum: 0xA870ADB4
	Offset: 0x10058
	Size: 0x31C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b952c1b(var_4bdd091b, str_tag = "j_spinelower")
{
	var_4bdd091b endon(#"death", #"hash_71716a8e79096aee");
	v_pos = self getcentroid();
	var_88f24b00 = util::spawn_model("tag_origin", v_pos + vectorscale((0, 0, 1), 12), self.angles);
	var_88f24b00 clientfield::set("" + #"hash_7a8b6df890ccc630", 1);
	var_88f24b00 playsound(#"zmb_sq_souls_release");
	n_dist = distance(var_88f24b00.origin, var_4bdd091b gettagorigin(str_tag));
	n_move_time = n_dist / 800;
	n_dist_sq = distance2dsquared(var_88f24b00.origin, var_4bdd091b gettagorigin(str_tag));
	n_start_time = gettime();
	n_total_time = 0;
	while(n_dist_sq > 576 && isalive(var_4bdd091b))
	{
		var_88f24b00 moveto(var_4bdd091b gettagorigin(str_tag), n_move_time);
		wait(0.1);
		if(isalive(var_4bdd091b))
		{
			n_current_time = gettime();
			n_total_time = n_current_time - n_start_time / 1000;
			n_move_time = var_4bdd091b namespace_b4a066ff::function_f40aa0ef(var_88f24b00, n_total_time);
			if(n_move_time == 0)
			{
				break;
			}
			n_dist_sq = distance2dsquared(var_88f24b00.origin, var_4bdd091b geteye());
		}
	}
	var_4bdd091b playsound(#"zmb_sq_souls_impact");
	var_88f24b00 clientfield::set("" + #"hash_7a8b6df890ccc630", 0);
	wait(0.5);
	var_4bdd091b notify(#"hash_7b36770a2988e5d1");
	var_88f24b00 delete();
}

/*
	Name: function_56e41aa6
	Namespace: namespace_a9aa9d72
	Checksum: 0x99859F41
	Offset: 0x10380
	Size: 0x19E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_56e41aa6(var_7df17d61)
{
	var_be009f9c = self.var_be009f9c;
	if(!isdefined(var_7df17d61))
	{
		return 0;
	}
	var_b212834c = getclosestpointonnavmesh(var_7df17d61, 128, 16);
	if(isdefined(var_b212834c))
	{
		var_7df17d61 = var_b212834c;
		var_b212834c = groundtrace(var_7df17d61 + vectorscale((0, 0, 1), 100), var_7df17d61 + vectorscale((0, 0, -1), 1000), 0, undefined, 0)[#"position"];
		if(isdefined(var_b212834c))
		{
			var_7df17d61 = var_b212834c;
		}
	}
	b_success = level function_252499a3(var_7df17d61);
	if(b_success)
	{
		if(!isdefined(level.var_659daf1d))
		{
			level.var_659daf1d = [];
		}
		else if(!isarray(level.var_659daf1d))
		{
			level.var_659daf1d = array(level.var_659daf1d);
		}
		if(!isinarray(level.var_659daf1d, var_be009f9c))
		{
			level.var_659daf1d[level.var_659daf1d.size] = var_be009f9c;
		}
	}
	return b_success;
}

/*
	Name: function_252499a3
	Namespace: namespace_a9aa9d72
	Checksum: 0xABE74262
	Offset: 0x10528
	Size: 0x226
	Parameters: 1
	Flags: Linked, Private
*/
private function function_252499a3(v_pos)
{
	var_b7eee573 = util::spawn_model(#"hash_27ac5ad4aaeb197", v_pos + vectorscale((0, 0, 1), 5));
	var_b7eee573 setscale(4);
	var_b7eee573 playsound(#"hash_748c338212771d3");
	var_b7eee573.t_interact = spawn("trigger_radius_use", v_pos + vectorscale((0, 0, 1), 20), 0, 64, 64);
	var_b7eee573.t_interact sethintstring(#"");
	var_b7eee573.t_interact setcursorhint("HINT_NOICON");
	var_b7eee573.t_interact triggerignoreteam();
	while(isdefined(var_b7eee573))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_b7eee573.t_interact waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			playsoundatposition(#"hash_6aa220e65103f345", var_b7eee573.origin);
			var_b7eee573.t_interact delete();
			var_b7eee573 delete();
			var_88706ea7.activator thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
			return 1;
		}
	}
}

/*
	Name: function_2c4516ae
	Namespace: namespace_a9aa9d72
	Checksum: 0x81346929
	Offset: 0x10758
	Size: 0x122
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2c4516ae(str_door_name)
{
	var_df1533c0 = getentarray(str_door_name, "target");
	foreach(zombie_door in var_df1533c0)
	{
		if(isdefined(zombie_door.var_ef717893) && zombie_door.var_ef717893)
		{
			continue;
		}
		zombie_door notify(#"trigger", {#hash_3fc8547c:1, #activator:zombie_door});
		zombie_door.script_flag_wait = undefined;
		zombie_door notify(#"power_on");
		zombie_door.var_ef717893 = 1;
	}
}

/*
	Name: function_ff88f6aa
	Namespace: namespace_a9aa9d72
	Checksum: 0x14E294A9
	Offset: 0x10888
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ff88f6aa(var_48940c64)
{
	self endon(#"hash_6fd7f8e1f00deffe", #"death");
	while(true)
	{
		str_zone = zm_zonemgr::get_zone_from_position(self.origin);
		if(!isdefined(str_zone))
		{
			self forceteleport(var_48940c64, self.angles, 1, 1);
		}
		wait(1);
	}
}

/*
	Name: function_9b1d9d6a
	Namespace: namespace_a9aa9d72
	Checksum: 0x29815292
	Offset: 0x10928
	Size: 0x2C2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9b1d9d6a()
{
	var_2d52f9db = struct::get("p_l_exp");
	var_fe4d15a4 = var_2d52f9db.scene_ents[#"hash_7aff0ee60ddd937b"];
	var_2287bf7c = [];
	foreach(e_player in util::get_players())
	{
		if(isalive(e_player) && var_fe4d15a4 sightconetrace(e_player getweaponmuzzlepoint(), e_player, e_player getweaponforwarddir(), 70))
		{
			if(!isdefined(var_2287bf7c))
			{
				var_2287bf7c = [];
			}
			else if(!isarray(var_2287bf7c))
			{
				var_2287bf7c = array(var_2287bf7c);
			}
			var_2287bf7c[var_2287bf7c.size] = e_player;
		}
		waitframe(1);
	}
	if(var_2287bf7c.size > 0)
	{
		var_2287bf7c = array::randomize(var_2287bf7c);
		foreach(e_player in var_2287bf7c)
		{
			if(e_player zm_audio::function_65e5c19a())
			{
				str_alias = #"hash_2240a0ede7e89d42" + e_player namespace_48f3568::function_d35e4c92();
				var_db4208eb = zm_audio::get_valid_lines(str_alias);
				var_346ed7cd = 5 - level.var_85cc9fcc.size;
				str_alias = var_db4208eb[var_346ed7cd];
				namespace_891c9bac::function_3c173d37(e_player.origin, 512);
				e_player thread namespace_891c9bac::function_8e0f4696(str_alias, 0, 0, 9999);
				return;
			}
		}
	}
}

/*
	Name: function_96ac2d88
	Namespace: namespace_a9aa9d72
	Checksum: 0x7CB541F6
	Offset: 0x10BF8
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_96ac2d88()
{
	/#
		if(!getdvarint(#"hash_11ad6a9695943217", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_2d0990d7);
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
	#/
}

/*
	Name: function_2d0990d7
	Namespace: namespace_a9aa9d72
	Checksum: 0x4056601E
	Offset: 0x10DC0
	Size: 0x2EA
	Parameters: 1
	Flags: None
*/
function function_2d0990d7(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_77f372679d07a739":
			{
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_439f7c3b2be3e69e":
			{
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_4c0666160f60f30c":
			{
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_18772c2e191751b2":
			{
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_476f76510ea19e0a":
			{
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_7993d72e5b3831ee":
			{
				level.var_d486e9c4 = 1;
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_619ec063638bb2df":
			{
				level.var_d486e9c4 = 1;
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_63836a8684b4a3db":
			{
				level.var_d486e9c4 = 1;
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_6efe06e0e34fcda1":
			{
				level.var_d486e9c4 = 1;
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_55764ba6b85e2f4d":
			{
				level.var_d486e9c4 = 1;
				level.var_daaf0e5d = "";
				break;
			}
			case "hash_18be8ae474605ed0":
			{
				level notify(#"hash_1a286cacd101f4eb", {#b_success:0});
				break;
			}
			case "hash_58ae202f026c337":
			{
				level notify(#"hash_1a286cacd101f4eb", {#b_success:1});
				break;
			}
			case "hash_6499ce5666508b":
			{
				level.var_bf412074 = 1;
				break;
			}
			case "hash_70db80c9c71f4e66":
			{
				level.var_6ab72806 = 1;
				break;
			}
			case "hash_70db7ec9c71f4b00":
			{
				level.var_6ab72806 = 3;
				break;
			}
		}
	#/
}

/*
	Name: function_283daa98
	Namespace: namespace_a9aa9d72
	Checksum: 0x799904C
	Offset: 0x110B8
	Size: 0xBE
	Parameters: 0
	Flags: Private
*/
private function function_283daa98()
{
	/#
		self endon(#"death", #"hash_300e9fed7925cd69");
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_1a286cacd101f4eb");
		if(isdefined(var_88706ea7.b_success) && var_88706ea7.b_success)
		{
			self notify(#"hash_300e9fed7925cd69", {#b_success:1});
		}
		else
		{
			self notify(#"hash_300e9fed7925cd69", {#b_success:0});
		}
	#/
}

