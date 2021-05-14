// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1615105f580458d3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_7c0074b5;

/*
	Name: function_89f2df9
	Namespace: namespace_7c0074b5
	Checksum: 0xC088175E
	Offset: 0x3B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_77ae506b4db4f2ce", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7c0074b5
	Checksum: 0x362F6C50
	Offset: 0x400
	Size: 0x75C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_11ff39a3100ac894", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_37c33178198d54e4", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_5d9808a62579e894", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_4ec2b359458774e4", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_4724376be4e925a3", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_1aa1c7790dc67d1e", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_7cdfc8f4819bab2e", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_61ed2f45564d54f9", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_6335a683b93e26a2", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_2a7ceb22f84e5aa9", 1, 1, "int");
	level flag::init(#"hash_6ee51d9a7d37aecc");
	level flag::init(#"hash_43114a11c9ca5302");
	level flag::init(#"hash_4e263b5dda470559");
	level flag::init(#"hash_5466d69fa17fc721");
	level.var_7a736cd5 = array(#"hash_79ab766693ef2532", #"hash_5acbab45c034f5bd");
	level.var_c147bf26 = array(#"hash_12826eeb0abe1308", #"hash_465b23ced2029d95", #"hash_3aa12cac41d4ba98");
	level.var_409cb3de = array(#"hash_59f3be0494c4801f", #"hash_29001ce64677a5cf", #"hash_1c96d8540b5d8c50");
	level.var_288dc330 = getent("mdl_acid_trap_finished_g", "targetname");
	level.var_288dc330 setinvisibletoall();
	level.var_57808c93 = getent("mdl_spin_trap_finished_r", "targetname");
	level.var_57808c93 setinvisibletoall();
	level.var_dc120ff3 = getent("mdl_fan_trap_finished_b", "targetname");
	level.var_dc120ff3 setinvisibletoall();
	level.var_9e1eb3aa = getentarray("zm_escape_rubble_pieces", "targetname");
	foreach(mdl_piece in level.var_9e1eb3aa)
	{
		mdl_piece setinvisibletoall();
	}
	level.var_3e7cd669 = getent("mdl_new_indust_geo_brush", "targetname");
	level.var_3e7cd669 setinvisibletoall();
	level.var_3e7cd669 notsolid();
	level.var_4024aaf6 = getent("mdl_white_metal", "targetname");
	level.var_4024aaf6.var_ca691b03 = 0;
	level.var_4024aaf6.var_bab19cbf = 25;
	level.var_4024aaf6.var_56a5d127 = -25;
	level.var_4024aaf6 movez(level.var_4024aaf6.var_56a5d127, 1.5);
	level.var_8e667d9c = getent("mdl_world_rebar_g", "targetname");
	level.var_8e667d9c setinvisibletoall();
	level.var_18220f55 = getentarray("mdl_d_w_i_k", "targetname");
	foreach(var_5da925c6 in level.var_18220f55)
	{
		var_5da925c6 setinvisibletoall();
	}
	level.var_ba89bc85 = 0;
	callback::on_connect(&on_player_connect);
}

/*
	Name: __main__
	Namespace: namespace_7c0074b5
	Checksum: 0xAC72AABC
	Offset: 0xB68
	Size: 0x39A
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(getdvarint(#"hash_11ad6a9695943217", 0))
	{
		/#
			level thread function_9562e9c1();
		#/
	}
	level flag::wait_till("start_zombie_round_logic");
	if(zm_utility::function_e51dc2d8())
	{
		foreach(e_player in level.players)
		{
			e_player thread function_d0baa3e9();
		}
		callback::on_spawned(&function_d0baa3e9);
	}
	level flag::wait_till(#"hash_29dc018e9551ecf");
	foreach(e_player in level.players)
	{
		if(zm_utility::function_e51dc2d8())
		{
			e_player thread function_cf58d5fe();
		}
	}
	callback::on_connect(&function_cf58d5fe);
	zm_spawner::register_zombie_death_event_callback(&function_7d6c1805);
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_1d02544f;
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_b74fca4c;
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_a93fd607;
}

/*
	Name: function_d0baa3e9
	Namespace: namespace_7c0074b5
	Checksum: 0xC2F11906
	Offset: 0xF10
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_d0baa3e9()
{
	if(!isbot(self))
	{
		if(!self flag::get(#"hash_59f3be0494c4801f"))
		{
			self clientfield::set_to_player("" + #"hash_37c33178198d54e4", 1);
		}
		if(!self flag::get(#"hash_1c96d8540b5d8c50"))
		{
			self clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 1);
		}
	}
}

/*
	Name: on_player_connect
	Namespace: namespace_7c0074b5
	Checksum: 0x26FD06DD
	Offset: 0xFD8
	Size: 0x398
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self endon(#"disconnect");
	self flag::init(#"hash_5acbab45c034f5bd");
	self flag::init(#"hash_d41f651bb868608");
	self flag::init(#"hash_334221cd7977f5d5");
	self flag::init(#"hash_12826eeb0abe1308");
	self flag::init(#"hash_465b23ced2029d95");
	self flag::init(#"hash_3aa12cac41d4ba98");
	self flag::init(#"hash_7317dfbae4fa0df5");
	self flag::init(#"hash_2218e030b30c77e2");
	self flag::init(#"hash_12000c871284e0b5");
	self flag::init(#"hash_7e372a60b99a89e0");
	self flag::init(#"hash_59f3be0494c4801f");
	self flag::init(#"hash_29001ce64677a5cf");
	self flag::init(#"hash_1c96d8540b5d8c50");
	self flag::init(#"hash_1213756b45a941f0");
	self flag::init(#"hash_21827937692e2aba");
	self flag::init(#"hash_3043d41614094af2");
	self flag::init(#"hash_f3f31bee1b786f2");
	self flag::init(#"hash_85d6f56e62aa0c4");
	self flag::init(#"hash_7bcf95ea12236f0d");
	self flag::init(#"hash_548a6763233817f5");
	while(true)
	{
		var_29b8f3d0 = undefined;
		var_29b8f3d0 = self waittill("new_" + "lethal_grenade");
		var_3759bc11 = var_29b8f3d0.weapon;
		var_22e180dd = self zm_loadout::get_player_lethal_grenade();
		var_b7c4015f = getweapon(#"tomahawk_t8_upgraded");
		if(var_3759bc11 == var_b7c4015f || var_22e180dd === var_b7c4015f)
		{
			self flag::set(#"hash_5acbab45c034f5bd");
		}
		else
		{
			self flag::clear(#"hash_5acbab45c034f5bd");
		}
	}
}

/*
	Name: function_cf58d5fe
	Namespace: namespace_7c0074b5
	Checksum: 0x378D8E9D
	Offset: 0x1378
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_cf58d5fe()
{
	self endon(#"disconnect");
	foreach(var_fb8c33cc in level.var_7a736cd5)
	{
		while(!self flag::exists(var_fb8c33cc))
		{
			wait(1);
		}
	}
	self flag::wait_till_all(level.var_7a736cd5);
	self.var_b3076a2d = 0;
	self flag::wait_till(#"hash_d41f651bb868608");
	self.var_b3076a2d = undefined;
	self thread function_21e59cf5();
}

/*
	Name: function_7d6c1805
	Namespace: namespace_7c0074b5
	Checksum: 0x81DE933D
	Offset: 0x1488
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_7d6c1805(e_player)
{
	if(!isplayer(e_player))
	{
		return;
	}
	if(!isdefined(e_player.var_b3076a2d))
	{
		return;
	}
	var_69e7f149 = getweapon(#"hash_32a584f5a65c70d1");
	if(self.damageweapon == var_69e7f149)
	{
		e_player.var_b3076a2d++;
		/#
			iprintln("" + e_player.var_b3076a2d);
		#/
		if(e_player.var_b3076a2d >= 100)
		{
			level.var_3e7cd669 setvisibletoplayer(e_player);
			e_player.var_b3076a2d = undefined;
			e_player flag::set(#"hash_d41f651bb868608");
			e_player playsoundtoplayer(#"hash_197a1f4b39686315", e_player);
		}
	}
}

/*
	Name: function_21e59cf5
	Namespace: namespace_7c0074b5
	Checksum: 0x9DC8AC71
	Offset: 0x15C0
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_21e59cf5()
{
	var_1a1a39e8 = struct::get("s_white_metal_loc");
	playsoundatposition(#"hash_1e25c8aa9abeb1ae", var_1a1a39e8.origin);
	if(!isdefined(var_1a1a39e8.var_87697f87))
	{
		var_1a1a39e8.var_87697f87 = var_1a1a39e8 zm_unitrigger::create(&function_545c69d8, 64, &function_3c616882);
	}
	self flag::wait_till(#"hash_334221cd7977f5d5");
	self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
	self thread function_d238a134();
}

/*
	Name: function_545c69d8
	Namespace: namespace_7c0074b5
	Checksum: 0x311B02D1
	Offset: 0x16D0
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_545c69d8(e_player)
{
	if(!e_player flag::get(#"hash_334221cd7977f5d5") && e_player flag::get(#"hash_d41f651bb868608"))
	{
		return 1;
	}
	if(!e_player flag::get(#"hash_85d6f56e62aa0c4") && e_player flag::get(#"hash_f3f31bee1b786f2"))
	{
		return 1;
	}
	if(!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_3c616882
	Namespace: namespace_7c0074b5
	Checksum: 0x78B909AB
	Offset: 0x17F0
	Size: 0x330
	Parameters: 0
	Flags: Linked
*/
function function_3c616882()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		e_player endon(#"disconnect");
		if(!e_player flag::get(#"hash_334221cd7977f5d5") && e_player flag::get(#"hash_d41f651bb868608"))
		{
			if(!level.var_4024aaf6.var_ca691b03)
			{
				level.var_4024aaf6 thread function_831aa56d(e_player, #"hash_32a584f5a65c70d1");
				e_player flag::set(#"hash_334221cd7977f5d5");
			}
		}
		else if(!e_player flag::get(#"hash_85d6f56e62aa0c4") && e_player flag::get(#"hash_f3f31bee1b786f2"))
		{
			if(!level.var_4024aaf6.var_ca691b03)
			{
				level.var_4024aaf6 thread function_831aa56d(e_player, #"golden_knife");
				e_player flag::set(#"hash_85d6f56e62aa0c4");
			}
		}
		else if(!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d") && !level flag::get(#"hash_4e263b5dda470559"))
		{
			if(!level.var_4024aaf6.var_ca691b03)
			{
				level.var_4024aaf6 thread function_6c5fdbbf(e_player);
			}
		}
		else if(!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d") && level flag::get(#"hash_4e263b5dda470559"))
		{
			level.var_4024aaf6 thread function_f23ddf20(e_player);
			e_player flag::set(#"hash_548a6763233817f5");
		}
		wait(0.1);
	}
}

/*
	Name: function_831aa56d
	Namespace: namespace_7c0074b5
	Checksum: 0xF837226A
	Offset: 0x1B28
	Size: 0x32C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_831aa56d(e_player, var_69970c6)
{
	e_player endon_callback(&function_905f55bb, #"disconnect");
	level.var_4024aaf6.var_ca691b03 = 1;
	level.var_4024aaf6.v_original_pos = level.var_4024aaf6.origin;
	level.var_4024aaf6.v_original_angles = level.var_4024aaf6.angles;
	function_455ede41(e_player);
	level.var_4024aaf6.var_e88acf63 = level.var_4024aaf6 gettagorigin("tag_spork");
	level.var_4024aaf6.var_a9a3211a = level.var_4024aaf6 gettagangles("tag_spork");
	if(var_69970c6 == #"hash_32a584f5a65c70d1")
	{
		level.var_4024aaf6.var_87d57162 = util::spawn_model("wpn_t8_zm_spork_world", level.var_4024aaf6.var_e88acf63, level.var_4024aaf6.var_a9a3211a);
		level.var_4024aaf6.var_87d57162 linkto(level.var_4024aaf6);
		e_player takeweapon(getweapon(#"hash_32a584f5a65c70d1"));
	}
	else
	{
		level.var_4024aaf6.var_c109c2a3 = util::spawn_model("wpn_t8_zm_goldenknife_world", level.var_4024aaf6.var_e88acf63, level.var_4024aaf6.var_a9a3211a);
		level.var_4024aaf6.var_c109c2a3 linkto(level.var_4024aaf6);
		e_player takeweapon(getweapon(#"golden_knife"));
	}
	w_current = e_player.currentweapon;
	e_player giveweapon(getweapon(#"knife"));
	e_player switchtoweapon(w_current);
	wait(0.5);
	level.var_4024aaf6 rotateyaw(720, 1);
	level.var_4024aaf6 waittill(#"rotatedone");
	function_6fc1189b();
	function_905f55bb();
}

/*
	Name: function_6c5fdbbf
	Namespace: namespace_7c0074b5
	Checksum: 0x87A81ECB
	Offset: 0x1E60
	Size: 0x1AC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6c5fdbbf(e_player)
{
	e_player endon_callback(&function_905f55bb, #"disconnect");
	level flag::set(#"hash_4e263b5dda470559");
	level.var_4024aaf6.var_ca691b03 = 1;
	level.var_4024aaf6.v_original_pos = level.var_4024aaf6.origin;
	level.var_4024aaf6.v_original_angles = level.var_4024aaf6.angles;
	level.var_4024aaf6.var_e88acf63 = level.var_4024aaf6 gettagorigin("tag_spork");
	level.var_4024aaf6.var_a9a3211a = level.var_4024aaf6 gettagangles("tag_spork");
	level.var_4024aaf6.var_55484b66 = util::spawn_model("wpn_t8_zm_spknifeork_world", level.var_4024aaf6.var_e88acf63, level.var_4024aaf6.var_a9a3211a);
	level.var_4024aaf6.var_55484b66 linkto(level.var_4024aaf6);
	function_455ede41(e_player);
	level.var_4024aaf6 thread function_f30298e4();
}

/*
	Name: function_f23ddf20
	Namespace: namespace_7c0074b5
	Checksum: 0x98EB9E6B
	Offset: 0x2018
	Size: 0x134
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f23ddf20(e_player)
{
	e_player endon_callback(&function_905f55bb, #"disconnect");
	level notify(#"hash_421aca00fd70d9ea");
	playsoundatposition(#"hash_5077c643bb3c5f9e", level.var_4024aaf6.origin);
	w_current = e_player.currentweapon;
	e_player thread zm_melee_weapon::award_melee_weapon(#"spknifeork");
	if(isdefined(level.var_4024aaf6.var_55484b66))
	{
		level.var_4024aaf6.var_55484b66 ghost();
	}
	level.var_4024aaf6 rotateyaw(1440, 1.5);
	function_6fc1189b();
	function_905f55bb();
}

/*
	Name: function_905f55bb
	Namespace: namespace_7c0074b5
	Checksum: 0x84376E31
	Offset: 0x2158
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_905f55bb(str_notify)
{
	if(isdefined(level.var_4024aaf6.var_ca691b03) && level.var_4024aaf6.var_ca691b03)
	{
		level.var_4024aaf6.var_ca691b03 = 0;
	}
	if(isdefined(level.var_4024aaf6.v_original_pos))
	{
		level.var_4024aaf6 moveto(level.var_4024aaf6.v_original_pos, 0.1);
		level.var_4024aaf6.v_original_pos = undefined;
	}
	if(isdefined(level.var_4024aaf6.v_original_angles))
	{
		level.var_4024aaf6 rotateto(level.var_4024aaf6.v_original_angles, 0.1);
		level.var_4024aaf6.v_original_angles = undefined;
	}
	if(isdefined(level.var_4024aaf6.var_87d57162))
	{
		level.var_4024aaf6.var_87d57162 delete();
	}
	if(isdefined(level.var_4024aaf6.var_c109c2a3))
	{
		level.var_4024aaf6.var_c109c2a3 delete();
	}
	if(isdefined(level.var_4024aaf6.var_55484b66))
	{
		level.var_4024aaf6.var_55484b66 delete();
	}
}

/*
	Name: function_455ede41
	Namespace: namespace_7c0074b5
	Checksum: 0x7E86DA16
	Offset: 0x2308
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_455ede41(e_player)
{
	level.var_4024aaf6 clientfield::set("" + #"hash_2a7ceb22f84e5aa9", 1);
	level.var_4024aaf6 movez(level.var_4024aaf6.var_bab19cbf, 1);
	playsoundatposition(#"hash_157cd287d6504d0e", level.var_4024aaf6.origin);
	level.var_4024aaf6 waittill(#"movedone");
}

/*
	Name: function_6fc1189b
	Namespace: namespace_7c0074b5
	Checksum: 0x625FC927
	Offset: 0x23D0
	Size: 0xD6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6fc1189b()
{
	level.var_4024aaf6 movez(level.var_4024aaf6.var_56a5d127, 1.5);
	level.var_4024aaf6 waittill(#"movedone");
	level.var_4024aaf6 clientfield::set("" + #"hash_2a7ceb22f84e5aa9", 0);
	if(isdefined(level.var_4024aaf6.v_original_pos))
	{
		level.var_4024aaf6.v_original_pos = undefined;
	}
	if(isdefined(level.var_4024aaf6.v_original_angles))
	{
		level.var_4024aaf6.v_original_angles = undefined;
	}
}

/*
	Name: function_f30298e4
	Namespace: namespace_7c0074b5
	Checksum: 0xBA3E2EF2
	Offset: 0x24B0
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_f30298e4()
{
	level endon(#"hash_421aca00fd70d9ea");
	wait(5);
	level.var_4024aaf6 movez(level.var_4024aaf6.var_56a5d127, 1.5);
	level.var_4024aaf6 waittill(#"movedone");
	if(isdefined(level.var_4024aaf6.var_55484b66))
	{
		level.var_4024aaf6.var_55484b66 delete();
	}
	level flag::clear(#"hash_4e263b5dda470559");
	level.var_4024aaf6.var_ca691b03 = 0;
}

/*
	Name: function_d238a134
	Namespace: namespace_7c0074b5
	Checksum: 0xC7E409B1
	Offset: 0x2598
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_d238a134()
{
	self endon(#"disconnect");
	self flag::wait_till_all(level.var_c147bf26);
	self flag::set(#"hash_7317dfbae4fa0df5");
	self function_6c31bcd3();
}

/*
	Name: function_a93fd607
	Namespace: namespace_7c0074b5
	Checksum: 0x7EF0635D
	Offset: 0x2610
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function function_a93fd607(e_grenade, n_grenade_charge_power)
{
	if(!isdefined(level.var_ca0f81c1) || !self flag::get(#"hash_334221cd7977f5d5"))
	{
		return 0;
	}
	if(distancesquared(e_grenade.origin, level.var_ca0f81c1.origin) < 62500 && !self flag::get(#"hash_465b23ced2029d95"))
	{
		level flag::set(#"hash_6ee51d9a7d37aecc");
		var_6e6ec518 = namespace_268fc37c::tomahawk_spawn(e_grenade.origin);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_bba04f72 = util::spawn_model(level.var_ca0f81c1.model, e_grenade.origin, level.var_ca0f81c1.angles);
		var_bba04f72 setscale(1.2);
		var_bba04f72 linkto(var_6e6ec518);
		level.var_ca0f81c1 delete();
		self thread namespace_268fc37c::tomahawk_return_player(var_6e6ec518, undefined, 800);
		self thread function_986bf0d5(var_6e6ec518, var_bba04f72);
		return 1;
	}
	return 0;
}

/*
	Name: function_986bf0d5
	Namespace: namespace_7c0074b5
	Checksum: 0x255550DE
	Offset: 0x27F8
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_986bf0d5(var_6e6ec518, var_e5d078)
{
	self endon(#"disconnect");
	var_6e6ec518 waittill(#"death");
	var_e5d078 delete();
	self flag::set(#"hash_465b23ced2029d95");
}

/*
	Name: function_1d02544f
	Namespace: namespace_7c0074b5
	Checksum: 0xDEB7955D
	Offset: 0x2878
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function function_1d02544f(e_grenade, n_grenade_charge_power)
{
	s_rock = struct::get("s_g_r_sp2");
	if(!isdefined(s_rock) || !self flag::get(#"hash_334221cd7977f5d5"))
	{
		return 0;
	}
	if(distancesquared(e_grenade.origin, s_rock.origin) < 10000 && !self flag::get(#"hash_3aa12cac41d4ba98"))
	{
		self clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 0);
		var_6e6ec518 = namespace_268fc37c::tomahawk_spawn(e_grenade.origin);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_bba04f72 = util::spawn_model(s_rock.model, e_grenade.origin, s_rock.angles);
		var_bba04f72 setscale(2.75);
		var_bba04f72 linkto(var_6e6ec518);
		self thread namespace_268fc37c::tomahawk_return_player(var_6e6ec518, undefined, 800);
		self thread function_f02db707(var_6e6ec518, var_bba04f72);
		return 1;
	}
	return 0;
}

/*
	Name: function_f02db707
	Namespace: namespace_7c0074b5
	Checksum: 0xD8419153
	Offset: 0x2A60
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_f02db707(var_6e6ec518, var_e5d078)
{
	self endon(#"disconnect");
	var_6e6ec518 waittill(#"death");
	var_e5d078 delete();
	self flag::set(#"hash_3aa12cac41d4ba98");
}

/*
	Name: function_b74fca4c
	Namespace: namespace_7c0074b5
	Checksum: 0xBF85D930
	Offset: 0x2AE0
	Size: 0x1BC
	Parameters: 2
	Flags: Linked
*/
function function_b74fca4c(e_grenade, n_grenade_charge_power)
{
	s_rock = struct::get("s_r_s_sp2");
	if(!isdefined(s_rock) || !self flag::get(#"hash_334221cd7977f5d5"))
	{
		return 0;
	}
	if(distancesquared(e_grenade.origin, s_rock.origin) < 10000 && !self flag::get(#"hash_12826eeb0abe1308"))
	{
		self clientfield::set_to_player("" + #"hash_37c33178198d54e4", 0);
		var_6e6ec518 = namespace_268fc37c::tomahawk_spawn(e_grenade.origin);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_bba04f72 = util::spawn_model(s_rock.model, e_grenade.origin, s_rock.angles);
		var_bba04f72 linkto(var_6e6ec518);
		self thread namespace_268fc37c::tomahawk_return_player(var_6e6ec518, undefined, 800);
		self thread function_7694f3cb(var_6e6ec518, var_bba04f72);
		return 1;
	}
	return 0;
}

/*
	Name: function_7694f3cb
	Namespace: namespace_7c0074b5
	Checksum: 0x40C8815A
	Offset: 0x2CA8
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_7694f3cb(var_6e6ec518, var_e5d078)
{
	self endon(#"disconnect");
	var_6e6ec518 waittill(#"death");
	var_e5d078 delete();
	self flag::set(#"hash_12826eeb0abe1308");
}

/*
	Name: function_6c31bcd3
	Namespace: namespace_7c0074b5
	Checksum: 0xD5858430
	Offset: 0x2D28
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_6c31bcd3()
{
	self endon(#"disconnect");
	self thread acid_trap_think();
	self thread function_5a8a4082();
	self thread fan_trap_think();
	self thread function_d291665f();
	self flag::wait_till_all(level.var_409cb3de);
	self flag::set(#"hash_1213756b45a941f0");
	self function_68eca9eb();
}

/*
	Name: acid_trap_think
	Namespace: namespace_7c0074b5
	Checksum: 0xE047A8A3
	Offset: 0x2E00
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function acid_trap_think()
{
	self endon(#"disconnect");
	s_acid_trap_place_loc = struct::get("s_acid_trap_place_loc");
	var_d93460a2 = struct::get(s_acid_trap_place_loc.target);
	if(!isdefined(var_d93460a2.s_unitrigger_stub))
	{
		var_d93460a2.s_unitrigger_stub = var_d93460a2 zm_unitrigger::create(&function_b07f181b, 64, &function_352a977a);
	}
	self.var_78b705d8 = 0;
	self flag::wait_till(#"hash_2218e030b30c77e2");
	self clientfield::set_to_player("" + #"hash_7cdfc8f4819bab2e", 1);
	self clientfield::set_to_player("" + #"hash_5d9808a62579e894", 0);
	level.var_288dc330 setvisibletoplayer(self);
	level.var_288dc330 playloopsound(#"hash_3129e04ec52b7ef2");
	self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
}

/*
	Name: function_b07f181b
	Namespace: namespace_7c0074b5
	Checksum: 0xFDD8E042
	Offset: 0x2FC0
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_b07f181b(e_player)
{
	if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_2218e030b30c77e2"))
	{
		return 1;
	}
	if(e_player flag::get(#"hash_2218e030b30c77e2") && !e_player flag::get(#"hash_1c96d8540b5d8c50"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_352a977a
	Namespace: namespace_7c0074b5
	Checksum: 0xD07F1546
	Offset: 0x3078
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_352a977a()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_2218e030b30c77e2"))
		{
			e_player clientfield::set_to_player("" + #"hash_5d9808a62579e894", 1);
		}
		else if(e_player flag::get(#"hash_2218e030b30c77e2") && !e_player flag::get(#"hash_1c96d8540b5d8c50"))
		{
			level.var_288dc330 setinvisibletoplayer(e_player);
			e_player flag::set(#"hash_1c96d8540b5d8c50");
			playsoundatposition(#"hash_7cfaf85826852b1f", level.var_288dc330.origin);
			level.var_288dc330 stoploopsound();
			return;
		}
		wait(0.1);
	}
}

/*
	Name: function_5a8a4082
	Namespace: namespace_7c0074b5
	Checksum: 0xD362561A
	Offset: 0x3228
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_5a8a4082()
{
	self endon(#"disconnect");
	s_spin_trap_place_loc = struct::get("s_spin_trap_place_loc");
	var_e624dbc9 = struct::get(s_spin_trap_place_loc.target);
	if(!isdefined(var_e624dbc9.s_unitrigger_stub))
	{
		var_e624dbc9.s_unitrigger_stub = var_e624dbc9 zm_unitrigger::create(&function_84ff44c, 64, &function_139dd88c);
	}
	self.var_8d32f494 = 0;
	self flag::wait_till(#"hash_12000c871284e0b5");
	self clientfield::set_to_player("" + #"hash_1aa1c7790dc67d1e", 1);
	self clientfield::set_to_player("" + #"hash_4ec2b359458774e4", 0);
	level.var_57808c93 setvisibletoplayer(self);
	level.var_57808c93 playloopsound(#"hash_3129e04ec52b7ef2");
	self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
}

/*
	Name: function_84ff44c
	Namespace: namespace_7c0074b5
	Checksum: 0x700A171D
	Offset: 0x33E8
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_84ff44c(e_player)
{
	if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_12000c871284e0b5"))
	{
		return 1;
	}
	if(e_player flag::get(#"hash_12000c871284e0b5") && !e_player flag::get(#"hash_59f3be0494c4801f"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_139dd88c
	Namespace: namespace_7c0074b5
	Checksum: 0x82596478
	Offset: 0x34A0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_139dd88c()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_12000c871284e0b5"))
		{
			e_player clientfield::set_to_player("" + #"hash_4ec2b359458774e4", 1);
		}
		else if(e_player flag::get(#"hash_12000c871284e0b5") && !e_player flag::get(#"hash_59f3be0494c4801f"))
		{
			level.var_57808c93 setinvisibletoplayer(e_player);
			e_player flag::set(#"hash_59f3be0494c4801f");
			playsoundatposition(#"hash_7cfaf85826852b1f", level.var_57808c93.origin);
			level.var_57808c93 stoploopsound();
			return;
		}
		wait(0.1);
	}
}

/*
	Name: fan_trap_think
	Namespace: namespace_7c0074b5
	Checksum: 0xBE8BE25B
	Offset: 0x3650
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function fan_trap_think()
{
	self endon(#"disconnect");
	s_fan_trap_place_loc = struct::get("s_fan_trap_place_loc");
	var_8c258084 = struct::get(s_fan_trap_place_loc.target);
	if(!isdefined(var_8c258084.var_87697f87))
	{
		var_8c258084.var_87697f87 = var_8c258084 zm_unitrigger::create(&function_93cd35c7, 64, &function_34759490);
	}
	self.var_27738b05 = 0;
	self flag::wait_till(#"hash_7e372a60b99a89e0");
	self clientfield::set_to_player("" + #"hash_61ed2f45564d54f9", 1);
	self clientfield::set_to_player("" + #"hash_4724376be4e925a3", 0);
	level.var_dc120ff3 setvisibletoplayer(self);
	level.var_dc120ff3 playloopsound(#"hash_3129e04ec52b7ef2");
	self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
}

/*
	Name: function_93cd35c7
	Namespace: namespace_7c0074b5
	Checksum: 0xAE0E412B
	Offset: 0x3810
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_93cd35c7(e_player)
{
	if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_7e372a60b99a89e0"))
	{
		return 1;
	}
	if(e_player flag::get(#"hash_7e372a60b99a89e0") && !e_player flag::get(#"hash_29001ce64677a5cf"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_34759490
	Namespace: namespace_7c0074b5
	Checksum: 0x6EA95033
	Offset: 0x38C8
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_34759490(e_player)
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		if(e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_7e372a60b99a89e0"))
		{
			e_player clientfield::set_to_player("" + #"hash_4724376be4e925a3", 1);
		}
		else if(e_player flag::get(#"hash_7e372a60b99a89e0") && !e_player flag::get(#"hash_29001ce64677a5cf"))
		{
			level.var_dc120ff3 setinvisibletoplayer(e_player);
			e_player flag::set(#"hash_29001ce64677a5cf");
			playsoundatposition(#"hash_7cfaf85826852b1f", level.var_dc120ff3.origin);
			level.var_dc120ff3 stoploopsound();
			return;
		}
		wait(0.1);
	}
}

/*
	Name: function_d291665f
	Namespace: namespace_7c0074b5
	Checksum: 0xF44DFFF7
	Offset: 0x3A78
	Size: 0x256
	Parameters: 0
	Flags: Linked
*/
function function_d291665f()
{
	self endon(#"disconnect");
	while(!self flag::get(#"hash_1213756b45a941f0"))
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_148b3ce521088846", #"hash_317f58ba0d580c27", #"hash_528d7b7f7d6c51a1");
		switch(waitresult._notify)
		{
			case "hash_148b3ce521088846":
			{
				if(isdefined(self.var_8d32f494))
				{
					self.var_8d32f494++;
					/#
						self function_d89318a3(self.var_8d32f494, "");
					#/
					if(self.var_8d32f494 >= 100)
					{
						self.var_8d32f494 = undefined;
						self flag::set(#"hash_12000c871284e0b5");
					}
				}
				break;
			}
			case "hash_317f58ba0d580c27":
			{
				if(isdefined(self.var_78b705d8))
				{
					self.var_78b705d8++;
					/#
						self function_d89318a3(self.var_78b705d8, "");
					#/
					if(self.var_78b705d8 >= 100)
					{
						self.var_78b705d8 = undefined;
						self flag::set(#"hash_2218e030b30c77e2");
					}
				}
				break;
			}
			case "hash_528d7b7f7d6c51a1":
			{
				if(isdefined(self.var_27738b05))
				{
					self.var_27738b05++;
					/#
						self function_d89318a3(self.var_27738b05, "");
					#/
					if(self.var_27738b05 >= 100)
					{
						self.var_27738b05 = undefined;
						self flag::set(#"hash_7e372a60b99a89e0");
					}
				}
				break;
			}
		}
	}
}

/*
	Name: function_68eca9eb
	Namespace: namespace_7c0074b5
	Checksum: 0x9ADCB73D
	Offset: 0x3CD8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_68eca9eb()
{
	self endon(#"disconnect");
	level.t_g_o_s4 = getent("t_g_o_s4", "targetname");
	self thread ee_exp_monkey_fire_();
	self flag::wait_till(#"hash_21827937692e2aba");
	self construction();
}

/*
	Name: ee_exp_monkey_fire_
	Namespace: namespace_7c0074b5
	Checksum: 0x2C0BA604
	Offset: 0x3D78
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function ee_exp_monkey_fire_()
{
	self endon(#"disconnect", #"hash_21827937692e2aba");
	while(!self flag::get(#"hash_21827937692e2aba"))
	{
		s_result = undefined;
		s_result = self waittill(#"throwing_tomahawk");
		var_288eb627 = s_result.e_grenade;
		if(!isdefined(var_288eb627))
		{
			return;
		}
		while(isdefined(var_288eb627) && self flag::get(#"hash_1213756b45a941f0") && level flag::get(#"hash_5466d69fa17fc721"))
		{
			if(var_288eb627 istouching(level.t_g_o_s4))
			{
				self function_a88a6e6a();
				self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
				break;
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_a88a6e6a
	Namespace: namespace_7c0074b5
	Checksum: 0x8FC6C009
	Offset: 0x3EE0
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_a88a6e6a()
{
	self endon(#"disconnect");
	var_531107f7 = struct::get("s_g_n_o_sp2");
	var_9db87c23 = getent("mdl_g_o_s4", "targetname");
	var_9db87c23 setinvisibletoplayer(self);
	scene::add_scene_func(#"p8_fxanim_zm_esc_golden_nugget_bundle", &function_ca9bfe21, "play", self);
	var_531107f7 thread scene::play();
}

/*
	Name: function_ca9bfe21
	Namespace: namespace_7c0074b5
	Checksum: 0x9A2D8EF
	Offset: 0x3FB8
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_ca9bfe21(a_ents, e_player)
{
	self notify("79b726cd6d4f2032");
	self endon("79b726cd6d4f2032");
	var_1520674d = a_ents[#"hash_7aff0ee60ddd937b"];
	var_1520674d setinvisibletoall();
	var_1520674d setvisibletoplayer(e_player);
	self waittill(#"scene_done");
	var_1520674d.s_unitrigger_stub = var_1520674d zm_unitrigger::function_fac87205(&function_45c5ebfb, 64);
	e_player flag::set(#"hash_21827937692e2aba");
	playsoundatposition(#"hash_7cfaf85826852b1f", var_1520674d.origin);
	var_1520674d delete();
}

/*
	Name: function_45c5ebfb
	Namespace: namespace_7c0074b5
	Checksum: 0xEC064B45
	Offset: 0x40E0
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_45c5ebfb(e_player)
{
	if(!e_player flag::get(#"hash_21827937692e2aba") && e_player flag::get(#"hash_1213756b45a941f0"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: construction
	Namespace: namespace_7c0074b5
	Checksum: 0xF1EEBE47
	Offset: 0x4150
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function construction()
{
	self endon(#"disconnect");
	var_1c5e406d = struct::get("s_table_loc_ni");
	if(!isdefined(var_1c5e406d.var_87697f87))
	{
		var_1c5e406d.var_87697f87 = var_1c5e406d zm_unitrigger::create(&function_4c6348bd, 64, &function_858b2d2f);
	}
	self flag::wait_till(#"hash_f3f31bee1b786f2");
	self function_5d60a7a0();
}

/*
	Name: function_4c6348bd
	Namespace: namespace_7c0074b5
	Checksum: 0xD5618E44
	Offset: 0x4220
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_4c6348bd(e_player)
{
	if(!e_player flag::get(#"hash_3043d41614094af2") && e_player flag::get(#"hash_21827937692e2aba"))
	{
		return 1;
	}
	if(!e_player flag::get(#"hash_f3f31bee1b786f2") && e_player flag::get(#"hash_3043d41614094af2"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_858b2d2f
	Namespace: namespace_7c0074b5
	Checksum: 0x1390AA44
	Offset: 0x42E8
	Size: 0x5E4
	Parameters: 0
	Flags: Linked
*/
function function_858b2d2f()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_player = s_result.activator;
		e_player endon(#"disconnect");
		if(!e_player flag::get(#"hash_3043d41614094af2") && e_player flag::get(#"hash_21827937692e2aba"))
		{
			foreach(mdl_piece in level.var_9e1eb3aa)
			{
				mdl_piece setvisibletoplayer(e_player);
			}
			playsoundatposition(#"hash_35c5e590e88c66e9", e_player.origin);
			if(e_player hasweapon(getweapon(#"hash_32a584f5a65c70d1")))
			{
				e_player takeweapon(getweapon(#"hash_32a584f5a65c70d1"));
				if(isdefined(e_player.var_1c4683c4))
				{
					e_player giveweapon(e_player.var_1c4683c4);
				}
				else
				{
					var_be633b3a = getweapon(#"knife");
					e_player giveweapon(var_be633b3a);
				}
			}
			var_25b99c94 = struct::get("s_ni_mach");
			var_25b99c94 thread scene::play();
			level waittill(#"hash_b36aace774a3377");
			level.var_9e1eb3aa = getentarray("zm_escape_rubble_pieces", "targetname");
			foreach(mdl_piece in level.var_9e1eb3aa)
			{
				mdl_piece setinvisibletoall();
			}
			level waittill(#"hash_933f0a634e259d9");
			level.var_8e667d9c setvisibletoplayer(e_player);
			playsoundatposition(#"hash_7e581306db035797", level.var_8e667d9c.origin);
			e_player flag::set(#"hash_3043d41614094af2");
		}
		else if(!e_player flag::get(#"hash_f3f31bee1b786f2") && e_player flag::get(#"hash_3043d41614094af2"))
		{
			level.var_8e667d9c setinvisibletoplayer(e_player);
			playsoundatposition(#"hash_5077c643bb3c5f9e", level.var_8e667d9c.origin);
			if(isdefined(e_player.var_1c4683c4) && e_player hasweapon(e_player.var_1c4683c4))
			{
				e_player thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
				e_player takeweapon(e_player.var_1c4683c4);
				w_current = e_player.currentweapon;
				e_player zm_melee_weapon::award_melee_weapon(#"golden_knife");
			}
			else
			{
				w_current = e_player.currentweapon;
				e_player zm_melee_weapon::award_melee_weapon(#"golden_knife");
				e_player giveweapon(getweapon(#"golden_knife"));
				e_player switchtoweapon(w_current);
			}
			e_player flag::set(#"hash_f3f31bee1b786f2");
			level.var_bff24582 clientfield::set("" + #"hash_228caf5cb0610875", 0);
			return;
		}
		wait(0.1);
	}
}

/*
	Name: function_5d60a7a0
	Namespace: namespace_7c0074b5
	Checksum: 0xEBC78F88
	Offset: 0x48D8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_5d60a7a0()
{
	self endon(#"disconnect");
	self flag::wait_till(#"hash_85d6f56e62aa0c4");
	self function_195d2fb();
}

/*
	Name: function_195d2fb
	Namespace: namespace_7c0074b5
	Checksum: 0x99326301
	Offset: 0x4938
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function function_195d2fb()
{
	self endon(#"disconnect");
	foreach(var_5da925c6 in level.var_18220f55)
	{
		var_5da925c6 setvisibletoplayer(self);
	}
	if(!level flag::get(#"hash_43114a11c9ca5302"))
	{
		zm_spawner::register_zombie_death_event_callback(&function_134e0d03);
		level flag::set(#"hash_43114a11c9ca5302");
		level.var_ba89bc85 = 1;
	}
	self.n_brutus_killed = 0;
	self thread function_588dcdff();
	self flag::wait_till(#"hash_7bcf95ea12236f0d");
	self thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
	var_326289fb = getent("mdl_d_w_i_k_t", "script_noteworthy");
	var_326289fb setinvisibletoplayer(self);
	self clientfield::set_to_player("" + #"hash_6335a683b93e26a2", 1);
	self.n_brutus_killed = undefined;
	if(level flag::get(#"hash_43114a11c9ca5302"))
	{
		foreach(player in getplayers())
		{
			if(isdefined(player.n_brutus_killed))
			{
				level.var_ba89bc85 = 1;
			}
		}
		if(!level.var_ba89bc85)
		{
			zm_spawner::deregister_zombie_death_event_callback(&function_134e0d03);
			level flag::clear(#"hash_43114a11c9ca5302");
		}
	}
	self function_666a9223();
}

/*
	Name: function_588dcdff
	Namespace: namespace_7c0074b5
	Checksum: 0x53019866
	Offset: 0x4C48
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_588dcdff()
{
	self endon(#"disconnect");
	t_r_br_sp2_7 = getent("t_r_br_sp2_7", "targetname");
	self.var_946c0773 = 0;
	while(!self flag::get(#"hash_7bcf95ea12236f0d"))
	{
		if(self istouching(t_r_br_sp2_7))
		{
			self.var_946c0773 = 1;
		}
		else
		{
			self.var_946c0773 = 0;
		}
		wait(0.1);
	}
}

/*
	Name: function_134e0d03
	Namespace: namespace_7c0074b5
	Checksum: 0x72AD5EC8
	Offset: 0x4D08
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function function_134e0d03(e_player)
{
	if(!isplayer(e_player))
	{
		return;
	}
	if(!isdefined(e_player.n_brutus_killed))
	{
		return;
	}
	var_be633b3a = getweapon("knife");
	if(self.damageweapon == var_be633b3a && self.archetype == #"brutus" && e_player.var_946c0773 === 1)
	{
		e_player.n_brutus_killed++;
		e_player flag::set(#"hash_7bcf95ea12236f0d");
		level.var_ba89bc85 = 0;
		foreach(player in getplayers())
		{
			if(isdefined(player.n_brutus_killed))
			{
				level.var_ba89bc85 = 1;
			}
		}
	}
}

/*
	Name: function_666a9223
	Namespace: namespace_7c0074b5
	Checksum: 0xA6DFF55C
	Offset: 0x4E80
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_666a9223()
{
	self flag::wait_till(#"hash_548a6763233817f5");
}

/*
	Name: function_d89318a3
	Namespace: namespace_7c0074b5
	Checksum: 0xE4F4C9CA
	Offset: 0x4EB0
	Size: 0x2FA
	Parameters: 2
	Flags: None
*/
function function_d89318a3(var_e818669b, var_13de0d8f)
{
	/#
		switch(var_13de0d8f)
		{
			case "hash_153549eef89a2cb":
			{
				switch(var_e818669b)
				{
					case 10:
					case 20:
					case 30:
					case 40:
					case 50:
					case 60:
					case 70:
					case 80:
					case 90:
					case 100:
					{
						iprintln("" + var_e818669b);
						break;
					}
				}
				break;
			}
			case "hash_7ec791ae12e7fd6c":
			{
				switch(var_e818669b)
				{
					case 10:
					case 20:
					case 30:
					case 40:
					case 50:
					case 60:
					case 70:
					case 80:
					case 90:
					case 100:
					{
						iprintln("" + var_e818669b);
						break;
					}
				}
				break;
			}
			case "hash_30df56340ab43d5":
			{
				switch(var_e818669b)
				{
					case 10:
					case 20:
					case 30:
					case 40:
					case 50:
					case 60:
					case 70:
					case 80:
					case 90:
					case 100:
					{
						iprintln("" + var_e818669b);
						break;
					}
				}
				break;
			}
		}
	#/
}

/*
	Name: function_9562e9c1
	Namespace: namespace_7c0074b5
	Checksum: 0x964C1A39
	Offset: 0x51B8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function function_9562e9c1()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_cd9397ea);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_cd9397ea
	Namespace: namespace_7c0074b5
	Checksum: 0xF67FA1D7
	Offset: 0x5280
	Size: 0x142
	Parameters: 1
	Flags: None
*/
function function_cd9397ea(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_b30f093de3148f5":
			{
				level thread function_efd25c9();
				return 1;
			}
			case "hash_25b76a136a0ab4c8":
			{
				level thread function_c3861242();
				return 1;
			}
			case "hash_3fe16111be57cd0f":
			{
				level thread function_63a03d53();
				return 1;
			}
			case "hash_7683c4d00e818d43":
			{
				level thread function_cb9f06fb();
				return 1;
			}
			case "hash_8f708281a7f98f4":
			{
				level thread function_af78dff9();
				return 1;
			}
			case "construction":
			{
				level thread function_cac69c4c();
				return 1;
			}
		}
	#/
}

/*
	Name: function_efd25c9
	Namespace: namespace_7c0074b5
	Checksum: 0x8CEBD897
	Offset: 0x53D0
	Size: 0x388
	Parameters: 0
	Flags: None
*/
function function_efd25c9()
{
	/#
		level flag::set(#"hash_dd62a8822ea4a38");
		level flag::set(#"hash_66f358c0066d77d8");
		level flag::set(#"hash_3b1ad1b5bdc81825");
		level flag::set(#"hash_29dc018e9551ecf");
		var_217fca51 = struct::get("");
		var_6b6eb535 = var_217fca51.scene_ents[#"hash_29358891420766c3"];
		var_6b6eb535 hide();
		foreach(player in level.players)
		{
			if(!player hasweapon(getweapon(#"hash_32a584f5a65c70d1")))
			{
				while(!isdefined(player.var_1c4683c4))
				{
					player.var_1c4683c4 = player.var_49377865[#"melee_weapon"];
					wait(0.1);
				}
				w_current = player.currentweapon;
				player zm_melee_weapon::award_melee_weapon(#"hash_32a584f5a65c70d1");
				player flag::set(#"hash_79ab766693ef2532");
			}
			if(!player hasweapon(getweapon(#"tomahawk_t8_upgraded")))
			{
				player.var_67e1d531 = player._gadgets_player[1];
				w_current = player.currentweapon;
				player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
				player switchtoweapon(w_current);
			}
			if(!player hasweapon(getweapon(#"hash_42a45d43be3dba42")))
			{
				player.var_67e1d531 = player._gadgets_player[1];
				w_current = player.currentweapon;
				player giveweapon(getweapon(#"hash_42a45d43be3dba42"));
				player switchtoweapon(w_current);
			}
			player clientfield::set_to_player("", 0);
		}
	#/
}

/*
	Name: function_c3861242
	Namespace: namespace_7c0074b5
	Checksum: 0x7346B41A
	Offset: 0x5760
	Size: 0xA0
	Parameters: 0
	Flags: None
*/
function function_c3861242()
{
	/#
		function_efd25c9();
		foreach(player in level.players)
		{
			player flag::set(#"hash_d41f651bb868608");
		}
	#/
}

/*
	Name: function_63a03d53
	Namespace: namespace_7c0074b5
	Checksum: 0x2BDF0DC3
	Offset: 0x5808
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function function_63a03d53()
{
	/#
		function_c3861242();
		foreach(player in level.players)
		{
			player flag::set(#"hash_334221cd7977f5d5");
			player flag::set(#"hash_79ab766693ef2532");
			player flag::set(#"hash_d41f651bb868608");
			player flag::set(#"hash_334221cd7977f5d5");
		}
	#/
}

/*
	Name: function_cb9f06fb
	Namespace: namespace_7c0074b5
	Checksum: 0x6EE36163
	Offset: 0x5910
	Size: 0x1E0
	Parameters: 0
	Flags: None
*/
function function_cb9f06fb()
{
	/#
		function_63a03d53();
		level flag::set(#"hash_6ee51d9a7d37aecc");
		foreach(player in level.players)
		{
			player flag::set(#"hash_79ab766693ef2532");
			player flag::set(#"hash_d41f651bb868608");
			player flag::set(#"hash_334221cd7977f5d5");
			player flag::set(#"hash_12826eeb0abe1308");
			player flag::set(#"hash_465b23ced2029d95");
			player flag::set(#"hash_3aa12cac41d4ba98");
			player flag::set(#"hash_7317dfbae4fa0df5");
			player clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 0);
			player clientfield::set_to_player("" + #"hash_37c33178198d54e4", 0);
		}
	#/
}

/*
	Name: function_af78dff9
	Namespace: namespace_7c0074b5
	Checksum: 0xFAF823F0
	Offset: 0x5AF8
	Size: 0x378
	Parameters: 0
	Flags: None
*/
function function_af78dff9()
{
	/#
		function_cb9f06fb();
		foreach(player in level.players)
		{
			player flag::set(#"hash_79ab766693ef2532");
			player flag::set(#"hash_d41f651bb868608");
			player flag::set(#"hash_334221cd7977f5d5");
			player flag::set(#"hash_12826eeb0abe1308");
			player flag::set(#"hash_465b23ced2029d95");
			player flag::set(#"hash_3aa12cac41d4ba98");
			player flag::set(#"hash_7317dfbae4fa0df5");
			player clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 0);
			player clientfield::set_to_player("" + #"hash_37c33178198d54e4", 0);
			level.var_c52768f4 = getent("", "");
			level.var_c52768f4 setinvisibletoall();
			level.var_520d999a = getent("", "");
			level.var_520d999a setinvisibletoall();
			level.var_78977eb8 = getent("", "");
			level.var_78977eb8 setinvisibletoall();
			player flag::set(#"hash_2218e030b30c77e2");
			player flag::set(#"hash_12000c871284e0b5");
			player flag::set(#"hash_7e372a60b99a89e0");
			player flag::set(#"hash_59f3be0494c4801f");
			player flag::set(#"hash_29001ce64677a5cf");
			player flag::set(#"hash_1c96d8540b5d8c50");
			player flag::set(#"hash_1213756b45a941f0");
		}
	#/
}

/*
	Name: function_cac69c4c
	Namespace: namespace_7c0074b5
	Checksum: 0xAB1941FD
	Offset: 0x5E78
	Size: 0xA0
	Parameters: 0
	Flags: Private
*/
private function function_cac69c4c()
{
	/#
		function_af78dff9();
		foreach(player in level.players)
		{
			player flag::set(#"hash_21827937692e2aba");
		}
	#/
}

