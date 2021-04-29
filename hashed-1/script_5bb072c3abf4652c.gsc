// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_58c342edd81589fb;
#using script_6021ce59143452c3;
#using script_6ce38ab036223e6e;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_891c9bac;

/*
	Name: function_89f2df9
	Namespace: namespace_891c9bac
	Checksum: 0x6C9ABCE2
	Offset: 0x168
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5c6e2deea572eb4a", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_891c9bac
	Checksum: 0x516B1E57
	Offset: 0x1B8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_98eae67a = [];
	level.var_5388c8f9 = [];
	level.var_62281818 = [];
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	if(!isdefined(level.var_4c2cc614))
	{
		level.var_4c2cc614 = &function_fb728280;
	}
}

/*
	Name: __main__
	Namespace: namespace_891c9bac
	Checksum: 0x6910C5DE
	Offset: 0x258
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	self endon(#"_zombie_game_over");
	level waittill(#"all_players_spawned");
	level thread [[level.var_4c2cc614]]();
}

/*
	Name: on_player_connect
	Namespace: namespace_891c9bac
	Checksum: 0x9324AE4A
	Offset: 0x2A0
	Size: 0x1A
	Parameters: 0
	Flags: Linked, Private
*/
private function on_player_connect()
{
	self.isspeaking = 0;
	self.n_vo_priority = 0;
}

/*
	Name: on_player_spawned
	Namespace: namespace_891c9bac
	Checksum: 0x353E1205
	Offset: 0x2C8
	Size: 0xE
	Parameters: 0
	Flags: Linked, Private
*/
private function on_player_spawned()
{
	self.isspeaking = 0;
}

/*
	Name: function_fb728280
	Namespace: namespace_891c9bac
	Checksum: 0xDB145058
	Offset: 0x2E0
	Size: 0x1E6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fb728280()
{
	level endon(#"end_game");
	function_396064c0(1);
	level flag::wait_till("start_zombie_round_logic");
	function_396064c0(0);
	while(true)
	{
		n_round = namespace_a28acff3::get_round_number();
		if(n_round > 4 || n_round - var_ad829e86 > 2)
		{
			break;
		}
		var_f7a978da = function_d74752d8(var_ad829e86);
		if(!(isdefined(var_f7a978da) && var_f7a978da))
		{
			break;
		}
		var_ad829e86++;
		if(namespace_a28acff3::get_round_number() == n_round)
		{
			level waittill(#"end_of_round");
		}
		wait(3);
	}
	while(true)
	{
		n_round = namespace_a28acff3::get_round_number();
		if(n_round >= 7)
		{
			if(!namespace_c3287616::function_40229072())
			{
				if(!zm_audio::sndvoxoverride())
				{
					if(!(isdefined(level.var_b2b15659) && level.var_b2b15659))
					{
						function_9f3a66e0();
					}
				}
			}
		}
		level waittill(#"end_of_round");
		wait(5);
	}
}

/*
	Name: function_7922807c
	Namespace: namespace_891c9bac
	Checksum: 0xDACE2335
	Offset: 0x4D0
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function function_7922807c(var_a33019a0, var_3e24b5d5, a_players, b_force = 1)
{
	function_9f3a66e0(var_3e24b5d5, var_a33019a0, a_players, b_force);
}

/*
	Name: function_3720b375
	Namespace: namespace_891c9bac
	Checksum: 0xF65BDFEA
	Offset: 0x530
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function function_3720b375(var_3e24b5d5, var_a33019a0, a_players, b_force = 1)
{
	function_9f3a66e0(var_3e24b5d5, var_a33019a0, a_players, b_force);
}

/*
	Name: function_9f3a66e0
	Namespace: namespace_891c9bac
	Checksum: 0xDDBCCA38
	Offset: 0x590
	Size: 0x5C6
	Parameters: 4
	Flags: Linked, Private
*/
private function function_9f3a66e0(var_3e24b5d5, var_a33019a0, a_players, b_force = 0)
{
	var_1bc956f4 = (isdefined(var_3e24b5d5) ? var_3e24b5d5 : (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"));
	if(isdefined(var_a33019a0))
	{
		function_2fd1af0(var_a33019a0, 1, var_1bc956f4);
	}
	function_396064c0(1);
	__timeout__ = 5;
	var_a51f2d59 = gettime();
	do
	{
		var_f5f6332 = function_172de553(!b_force, a_players);
		var_1d5dbc39 = array::randomize(getarraykeys(var_f5f6332));
		foreach(var_ac829b0 in var_1d5dbc39)
		{
			var_3e24b5d5 = var_1bc956f4;
			if(isdefined(level.var_66ee3895) && isstring(level.var_66ee3895[var_ac829b0]))
			{
				var_3e24b5d5 = level.var_66ee3895[var_ac829b0];
			}
			function_bd8c7ec(var_ac829b0, var_3e24b5d5);
			player1 = var_f5f6332[var_ac829b0][0];
			player2 = var_f5f6332[var_ac829b0][1];
			if(!is_player_valid(player1) || !is_player_valid(player2))
			{
				continue;
			}
			do
			{
				n_index = (isdefined(var_a33019a0) ? var_a33019a0 : function_e27cd027(var_ac829b0, var_3e24b5d5));
				if(function_c6311709(n_index, var_3e24b5d5))
				{
					var_a2be76a3 = function_2b7b1675(var_3e24b5d5, n_index, player1, player2);
					if(var_a2be76a3.var_dbeb023e.size)
					{
						/#
							if(getdvarint(#"hash_11818496956f235a", 0))
							{
								iprintlnbold(var_3e24b5d5 + "" + function_9e72a96(var_ac829b0) + "" + n_index);
								println(var_3e24b5d5 + "" + function_9e72a96(var_ac829b0) + "" + n_index);
							}
						#/
						if(function_7e4562d7(var_a2be76a3.var_dbeb023e, var_a2be76a3.var_1dc0a881, 1))
						{
							if(isdefined(player1))
							{
								player1 notify(#"hash_ed377b19afa69d2");
							}
							if(isdefined(player2))
							{
								player2 notify(#"hash_ed377b19afa69d2");
							}
							function_3f8824e6(var_ac829b0, var_3e24b5d5);
							level thread function_396064c0(0);
							return 1;
						}
						break;
					}
					if(isdefined(var_a33019a0))
					{
						break;
					}
					else
					{
						function_3f8824e6(var_ac829b0, var_3e24b5d5);
					}
				}
				else
				{
					/#
						if(getdvarint(#"hash_11818496956f235a", 0))
						{
							iprintlnbold(var_3e24b5d5 + "" + function_9e72a96(var_ac829b0) + "" + n_index + "");
							println(var_3e24b5d5 + "" + function_9e72a96(var_ac829b0) + "" + n_index + "");
						}
					#/
					break;
				}
				if(!isdefined(player1) || !isdefined(player2))
				{
					break;
				}
			}
			while(n_index <= 20);
			waitframe(1);
		}
		wait(randomfloatrange(0.3333333, 0.6666667));
	}
	while(!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_a51f2d59) / 1000 <= 0));
	level thread function_396064c0(0);
	return 0;
}

/*
	Name: function_577efa88
	Namespace: namespace_891c9bac
	Checksum: 0xAD6BD9AB
	Offset: 0xB60
	Size: 0x8C
	Parameters: 2
	Flags: None
*/
function function_577efa88(var_a33019a0, var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"))
{
	if(!isdefined(level.var_5388c8f9[var_3e24b5d5]))
	{
		level.var_5388c8f9[var_3e24b5d5] = [];
	}
	level.var_5388c8f9[var_3e24b5d5][var_a33019a0] = 1;
}

/*
	Name: function_2fd1af0
	Namespace: namespace_891c9bac
	Checksum: 0x5C36F0BD
	Offset: 0xBF8
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function function_2fd1af0(var_a33019a0, var_c6a4663f = 1, var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"))
{
	if(!isdefined(level.var_5388c8f9[var_3e24b5d5]))
	{
		level.var_5388c8f9[var_3e24b5d5] = [];
	}
	level.var_5388c8f9[var_3e24b5d5][var_a33019a0] = undefined;
	if(var_c6a4663f)
	{
		function_cf6c9597("skipto", var_3e24b5d5, var_a33019a0);
	}
}

/*
	Name: function_c6311709
	Namespace: namespace_891c9bac
	Checksum: 0xBF53632
	Offset: 0xCC8
	Size: 0x78
	Parameters: 2
	Flags: Linked
*/
function function_c6311709(var_a33019a0, var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"))
{
	if(isdefined(level.var_5388c8f9[var_3e24b5d5]))
	{
		return !isdefined(level.var_5388c8f9[var_3e24b5d5][var_a33019a0]);
	}
	return 1;
}

/*
	Name: function_bd8c7ec
	Namespace: namespace_891c9bac
	Checksum: 0x5AB42369
	Offset: 0xD48
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_bd8c7ec(var_ac829b0, var_3e24b5d5)
{
	if(!isdefined(level.var_98eae67a[#"skipto"]))
	{
		level.var_98eae67a[#"skipto"] = [];
	}
	if(isdefined(level.var_98eae67a[#"skipto"][var_3e24b5d5]))
	{
		var_bc984450 = level.var_98eae67a[#"skipto"][var_3e24b5d5];
		if(function_e27cd027(var_ac829b0, var_3e24b5d5) < var_bc984450)
		{
			function_cf6c9597(var_ac829b0, var_3e24b5d5, var_bc984450);
		}
	}
}

/*
	Name: function_e27cd027
	Namespace: namespace_891c9bac
	Checksum: 0x6EF4B589
	Offset: 0xE28
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function function_e27cd027(var_ac829b0, var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"))
{
	if(!isdefined(level.var_98eae67a[var_ac829b0]))
	{
		level.var_98eae67a[var_ac829b0] = [];
	}
	if(!isdefined(level.var_98eae67a[var_ac829b0][var_3e24b5d5]))
	{
		level.var_98eae67a[var_ac829b0][var_3e24b5d5] = 0;
	}
	return level.var_98eae67a[var_ac829b0][var_3e24b5d5];
}

/*
	Name: function_cf6c9597
	Namespace: namespace_891c9bac
	Checksum: 0x292A91A0
	Offset: 0xEF0
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_cf6c9597(var_ac829b0, var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"), n_index)
{
	if(!isdefined(level.var_98eae67a[var_ac829b0]))
	{
		level.var_98eae67a[var_ac829b0] = [];
	}
	level.var_98eae67a[var_ac829b0][var_3e24b5d5] = n_index;
}

/*
	Name: function_769aa73b
	Namespace: namespace_891c9bac
	Checksum: 0xC1ACEBD5
	Offset: 0xF90
	Size: 0xB6
	Parameters: 3
	Flags: None
*/
function function_769aa73b(var_3e24b5d5, character1, character2)
{
	var_2f0fa840 = namespace_48f3568::function_dc232a80(character1);
	var_7a0bbe3b = namespace_48f3568::function_dc232a80(character2);
	var_ac829b0 = min(var_2f0fa840, var_7a0bbe3b) + "-" + max(var_2f0fa840, var_7a0bbe3b);
	level.var_66ee3895[var_ac829b0] = var_3e24b5d5;
}

/*
	Name: function_3f8824e6
	Namespace: namespace_891c9bac
	Checksum: 0x69A675A9
	Offset: 0x1050
	Size: 0x88
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3f8824e6(var_ac829b0, var_3e24b5d5)
{
	n_index = int(min(function_e27cd027(var_ac829b0, var_3e24b5d5) + 1, 21));
	function_cf6c9597(var_ac829b0, var_3e24b5d5, n_index);
	return n_index;
}

/*
	Name: function_2b7b1675
	Namespace: namespace_891c9bac
	Checksum: 0x604D65C4
	Offset: 0x10E0
	Size: 0x7BC
	Parameters: 4
	Flags: Linked, Private
*/
private function function_2b7b1675(var_3e24b5d5 = (isdefined(level.var_3e24b5d5) ? level.var_3e24b5d5 : "banter"), var_a33019a0, var_2e6c012e, e_player_2)
{
	var_53297699 = var_2e6c012e namespace_48f3568::function_dc232a80();
	var_b1411c83 = var_2e6c012e function_82f9bc9f();
	var_6095116c = e_player_2 namespace_48f3568::function_dc232a80();
	var_1c46f291 = e_player_2 function_82f9bc9f();
	var_b2510068 = [];
	if(!isdefined(var_b2510068))
	{
		var_b2510068 = [];
	}
	else if(!isarray(var_b2510068))
	{
		var_b2510068 = array(var_b2510068);
	}
	var_b2510068[var_b2510068.size] = array(var_53297699, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_53297699);
	if(!isdefined(var_b2510068))
	{
		var_b2510068 = [];
	}
	else if(!isarray(var_b2510068))
	{
		var_b2510068 = array(var_b2510068);
	}
	var_b2510068[var_b2510068.size] = array(var_53297699, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_53297699);
	if(!isdefined(var_b2510068))
	{
		var_b2510068 = [];
	}
	else if(!isarray(var_b2510068))
	{
		var_b2510068 = array(var_b2510068);
	}
	var_b2510068[var_b2510068.size] = array(var_6095116c, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_6095116c);
	if(!isdefined(var_b2510068))
	{
		var_b2510068 = [];
	}
	else if(!isarray(var_b2510068))
	{
		var_b2510068 = array(var_b2510068);
	}
	var_b2510068[var_b2510068.size] = array(var_6095116c, #"vox_" + var_a33019a0 + "_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_6095116c);
	waitframe(1);
	if(var_a33019a0 == 0)
	{
		if(!isdefined(var_b2510068))
		{
			var_b2510068 = [];
		}
		else if(!isarray(var_b2510068))
		{
			var_b2510068 = array(var_b2510068);
		}
		var_b2510068[var_b2510068.size] = array(var_53297699, #"vox_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_53297699);
		if(!isdefined(var_b2510068))
		{
			var_b2510068 = [];
		}
		else if(!isarray(var_b2510068))
		{
			var_b2510068 = array(var_b2510068);
		}
		var_b2510068[var_b2510068.size] = array(var_53297699, #"vox_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_53297699);
		if(!isdefined(var_b2510068))
		{
			var_b2510068 = [];
		}
		else if(!isarray(var_b2510068))
		{
			var_b2510068 = array(var_b2510068);
		}
		var_b2510068[var_b2510068.size] = array(var_6095116c, #"vox_" + var_3e24b5d5 + "_" + var_b1411c83 + "_" + var_1c46f291 + "_" + "plr_" + var_6095116c);
		if(!isdefined(var_b2510068))
		{
			var_b2510068 = [];
		}
		else if(!isarray(var_b2510068))
		{
			var_b2510068 = array(var_b2510068);
		}
		var_b2510068[var_b2510068.size] = array(var_6095116c, #"vox_" + var_3e24b5d5 + "_" + var_1c46f291 + "_" + var_b1411c83 + "_" + "plr_" + var_6095116c);
	}
	var_cd5bda0c = [];
	foreach(test in var_b2510068)
	{
		for(i = 0; i < 20; i++)
		{
			str_alias = test[1] + "_" + i;
			if(soundexists(str_alias))
			{
				var_cd5bda0c[i] = array(test[0], str_alias);
			}
		}
		waitframe(1);
	}
	return {#hash_1dc0a881:array(0, 0.5), #hash_dbeb023e:var_cd5bda0c};
}

/*
	Name: function_d74752d8
	Namespace: namespace_891c9bac
	Checksum: 0x25975B82
	Offset: 0x18A8
	Size: 0x278
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d74752d8(var_2753f06a)
{
	level endon_callback(&function_8d0f6d6c, #"hash_6e979a553f2df885");
	level thread function_b2fd46e3();
	if(namespace_c3287616::function_40229072())
	{
		return 0;
	}
	function_396064c0(1);
	var_845efa03 = 0;
	if(isdefined(level.var_c02e63))
	{
		var_845efa03 = [[level.var_c02e63]](var_2753f06a);
	}
	if(!var_845efa03)
	{
		a_players = util::get_players();
		if(a_players.size == 1)
		{
			e_player = a_players[0];
			if(var_2753f06a == 0)
			{
				str_suffix = #"hash_7722be2c5fbf9090";
			}
			else
			{
				str_suffix = #"hash_353c8321de1d10b1" + var_2753f06a;
			}
			if(isdefined(e_player.var_ab7bf755))
			{
				var_845efa03 = e_player [[e_player.var_ab7bf755]]();
			}
			else
			{
				var_845efa03 = e_player function_a2bd5a0c(str_suffix, 0, 1);
			}
		}
		else
		{
			var_1dc0a881 = array(0, 0.5);
			var_dcc9a85f = (level.script === "zm_escape" ? 2147483647 : 2);
			if(var_2753f06a == 0)
			{
				var_845efa03 = function_7e4562d7(#"hash_72ea1851a50844cf", var_1dc0a881, 1, undefined, 0, 0, var_dcc9a85f);
			}
			else
			{
				var_845efa03 = function_7e4562d7(#"hash_71bde3a512edb440" + var_2753f06a, var_1dc0a881, 1, undefined, 0, 0, var_dcc9a85f);
			}
		}
	}
	level thread function_396064c0(0);
	return var_845efa03;
}

/*
	Name: function_8d0f6d6c
	Namespace: namespace_891c9bac
	Checksum: 0xE4AEEA44
	Offset: 0x1B28
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_8d0f6d6c(str_notify)
{
	level thread function_396064c0(0);
}

/*
	Name: function_396064c0
	Namespace: namespace_891c9bac
	Checksum: 0xC69487D4
	Offset: 0x1B58
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_396064c0(var_e29db913 = 1)
{
	self notify("6f78b87488cdfba0");
	self endon("6f78b87488cdfba0");
	if(!(isdefined(var_e29db913) && var_e29db913))
	{
		wait(2);
	}
	level.var_b625a184 = (var_e29db913 ? 1 : undefined);
}

/*
	Name: function_b2fd46e3
	Namespace: namespace_891c9bac
	Checksum: 0xF434971A
	Offset: 0x1BD0
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_b2fd46e3()
{
	self notify("49fa415c54ac0bb2");
	self endon("49fa415c54ac0bb2");
	while(!(isdefined(level.var_b2b15659) && level.var_b2b15659))
	{
		waitframe(1);
	}
	level notify(#"hash_6e979a553f2df885");
}

/*
	Name: function_ee847f80
	Namespace: namespace_891c9bac
	Checksum: 0xEF5CB2B0
	Offset: 0x1C38
	Size: 0x8C
	Parameters: 2
	Flags: None
*/
function function_ee847f80(var_385e671d, var_e30ebc7f)
{
	var_79ef6f66 = strtok(var_385e671d, "_");
	var_46b688f5 = strtok(var_e30ebc7f, "_");
	return var_79ef6f66[var_79ef6f66.size - 1] < var_46b688f5[var_46b688f5.size - 1];
}

/*
	Name: function_172de553
	Namespace: namespace_891c9bac
	Checksum: 0x3F95A9AB
	Offset: 0x1CD0
	Size: 0x1F6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_172de553(var_ec88b612 = 1, a_players = array::randomize(function_347f7d34()))
{
	var_f5f6332 = [];
	for(i = 0; i < a_players.size; i++)
	{
		for(j = 0; j < a_players.size; j++)
		{
			if(a_players[i] != a_players[j])
			{
				player1 = a_players[i];
				player2 = a_players[j];
				var_2f0fa840 = 0;
				var_7a0bbe3b = 0;
				if(isdefined(player1))
				{
					var_2f0fa840 = player1 namespace_48f3568::function_dc232a80();
				}
				if(isdefined(player2))
				{
					var_7a0bbe3b = player2 namespace_48f3568::function_dc232a80();
				}
				var_ac829b0 = min(var_2f0fa840, var_7a0bbe3b) + "-" + max(var_2f0fa840, var_7a0bbe3b);
				if(!isdefined(var_f5f6332[var_ac829b0]))
				{
					if(!var_ec88b612 || function_5c82f986(player1, player2))
					{
						var_f5f6332[var_ac829b0] = array(player1, player2);
					}
				}
			}
		}
	}
	return var_f5f6332;
}

/*
	Name: function_18d309e5
	Namespace: namespace_891c9bac
	Checksum: 0x1FB09DD
	Offset: 0x1ED0
	Size: 0xCE
	Parameters: 3
	Flags: None
*/
function function_18d309e5(n_timeout, var_ec88b612, a_players)
{
	__timeout__ = n_timeout;
	var_a51f2d59 = gettime();
	do
	{
		var_f5f6332 = function_172de553(var_ec88b612, a_players);
		if(var_f5f6332.size)
		{
			break;
		}
		wait(randomfloatrange(0.2, 0.4));
	}
	while(!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_a51f2d59) / 1000 <= 0));
	return var_f5f6332;
}

/*
	Name: function_5c82f986
	Namespace: namespace_891c9bac
	Checksum: 0x95E816DB
	Offset: 0x1FA8
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function function_5c82f986(var_97beaf8b, var_ccac9966)
{
	if(distancesquared(var_97beaf8b.origin, var_ccac9966.origin) < 589824)
	{
		if(abs(var_97beaf8b.origin[2] - var_ccac9966.origin[2]) < 96)
		{
			if(sighttracepassed(var_97beaf8b.origin + vectorscale((0, 0, 1), 64), var_ccac9966.origin + vectorscale((0, 0, 1), 64), 0, var_97beaf8b, var_ccac9966))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: vo_clear
	Namespace: namespace_891c9bac
	Checksum: 0x4A45362E
	Offset: 0x2090
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function vo_clear(str_endon)
{
	self thread function_ccc44d3e(str_endon);
}

/*
	Name: function_ccc44d3e
	Namespace: namespace_891c9bac
	Checksum: 0xA498F739
	Offset: 0x20C0
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function function_ccc44d3e(str_endon)
{
	if(isdefined(str_endon) && isdefined(self.str_vo_being_spoken))
	{
		/#
			if(getdvarint(#"hash_11818496956f235a", 0))
			{
				iprintlnbold("");
				println("");
			}
		#/
		self stopsound(self.str_vo_being_spoken);
	}
	if(isplayer(self))
	{
		self clientfield::set_to_player("isspeaking", 0);
	}
	self.str_vo_being_spoken = "";
	self.n_vo_priority = 0;
	self.isspeaking = 0;
	self.var_5b6ebfd0 = 0;
	self.var_472e3448 = undefined;
	self.last_vo_played_time = gettime();
	arrayremovevalue(level.var_62281818, self);
	zm_audio::sndvoxoverride(0);
	self notify(#"vo_clear");
	self notify(#"done_speaking");
}

/*
	Name: function_95b99c5b
	Namespace: namespace_891c9bac
	Checksum: 0xD620785A
	Offset: 0x2238
	Size: 0x80
	Parameters: 2
	Flags: Private
*/
private function function_95b99c5b(n_max, var_50bb7db7)
{
	/#
		assert(!isdefined(var_50bb7db7) || var_50bb7db7 < n_max, "");
	#/
	do
	{
		n_new_value = randomint(n_max);
	}
	while(n_new_value === var_50bb7db7);
	return n_new_value;
}

/*
	Name: function_542dfad7
	Namespace: namespace_891c9bac
	Checksum: 0xD5072B8A
	Offset: 0x22C0
	Size: 0x6C
	Parameters: 3
	Flags: Private
*/
private function function_542dfad7(e1, e2, b_lowest_first = 1)
{
	if(b_lowest_first)
	{
		return e1.characterindex <= e2.characterindex;
	}
	return e1.characterindex > e2.characterindex;
}

/*
	Name: is_player_valid
	Namespace: namespace_891c9bac
	Checksum: 0xD9152BEB
	Offset: 0x2338
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_player_valid(e_player)
{
	return zm_utility::is_player_valid(e_player, 0, 0, 0);
}

/*
	Name: function_347f7d34
	Namespace: namespace_891c9bac
	Checksum: 0x6724DA45
	Offset: 0x2370
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_347f7d34()
{
	a_valid_players = [];
	foreach(player in getplayers())
	{
		if(zm_utility::is_player_valid(player))
		{
			if(!isdefined(a_valid_players))
			{
				a_valid_players = [];
			}
			else if(!isarray(a_valid_players))
			{
				a_valid_players = array(a_valid_players);
			}
			a_valid_players[a_valid_players.size] = player;
		}
	}
	return a_valid_players;
}

/*
	Name: function_2ee2ece4
	Namespace: namespace_891c9bac
	Checksum: 0xD9C6523
	Offset: 0x2460
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function function_2ee2ece4(var_79dbc69 = 1)
{
	while(true)
	{
		a_valid_players = function_347f7d34();
		if(a_valid_players.size >= var_79dbc69)
		{
			break;
		}
		waitframe(5);
	}
	return a_valid_players;
}

/*
	Name: function_45e29f06
	Namespace: namespace_891c9bac
	Checksum: 0x10CAB8F6
	Offset: 0x24C8
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function function_45e29f06()
{
	var_5eb47b1d = util::get_active_players();
	foreach(player in var_5eb47b1d)
	{
		if(function_d122265c(player))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_d122265c
	Namespace: namespace_891c9bac
	Checksum: 0x418C1A6D
	Offset: 0x2570
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_d122265c(e_player)
{
	if(!isdefined(e_player) && isplayer(self))
	{
		e_player = self;
	}
	if(e_player.isspeaking)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a2bd5a0c
	Namespace: namespace_891c9bac
	Checksum: 0x4A810016
	Offset: 0x25C8
	Size: 0x1B4
	Parameters: 7
	Flags: Linked
*/
function function_a2bd5a0c(var_cadd3b0c, n_delay = 0, b_wait_if_busy = 0, var_2cb3b5d = 0, var_34e7887 = 0, var_d7714e4e = 0, var_67fee570 = 0)
{
	/#
		/#
			assert(isplayer(self), "" + "");
		#/
	#/
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}
	n_index = namespace_48f3568::function_dc232a80();
	str_vo_alias = var_cadd3b0c + "_" + "plr_" + n_index;
	var_a5e8d5c7 = zm_audio::get_valid_lines(str_vo_alias);
	var_36414a9f = function_8e0f4696(array::random(var_a5e8d5c7), n_delay, b_wait_if_busy, var_2cb3b5d, var_34e7887, var_d7714e4e, 0, var_67fee570);
	return isdefined(var_36414a9f) && var_36414a9f;
}

/*
	Name: function_8e0f4696
	Namespace: namespace_891c9bac
	Checksum: 0xABACF10D
	Offset: 0x2788
	Size: 0x33E
	Parameters: 8
	Flags: Linked
*/
function function_8e0f4696(str_vo_alias, n_delay = 0, b_wait_if_busy = 0, var_2cb3b5d = 0, var_34e7887 = 0, var_d7714e4e = 0, var_9c64da7c = 0, var_67fee570 = 0)
{
	if(!isdefined(self))
	{
		return 0;
	}
	self endon_callback(&vo_clear, #"death");
	if(!isdefined(str_vo_alias))
	{
		return 0;
	}
	if(namespace_f551babc::function_b47f6aba() || zm_utility::is_standard() && !var_9c64da7c || (isdefined(level.var_d555ff19) && level.var_d555ff19))
	{
		return 0;
	}
	if(isplayer(self))
	{
		if(!zm_utility::is_player_valid(self, 0, var_67fee570, 0) || (isdefined(self.dontspeak) && self.dontspeak))
		{
			return 0;
		}
	}
	var_56f97c91 = array::random(zm_audio::get_valid_lines(str_vo_alias));
	if(isdefined(var_56f97c91))
	{
		__timeout__ = n_delay;
		var_a51f2d59 = gettime();
		self notify(#"hash_7efd5bdf8133ff7b");
		if(!zm_audio::function_65e5c19a(var_d7714e4e))
		{
			if(isdefined(b_wait_if_busy) && b_wait_if_busy)
			{
				do
				{
					waitframe(1);
				}
				while(!zm_audio::function_65e5c19a(var_d7714e4e));
			}
			else
			{
				return 0;
			}
		}
		/#
			if(getdvarint(#"hash_11818496956f235a", 0))
			{
				iprintlnbold("" + function_9e72a96(str_vo_alias));
				println("" + function_9e72a96(str_vo_alias));
			}
		#/
		self thread function_597484c3(__timeout__ - float(gettime() - var_a51f2d59) / 1000, var_56f97c91, var_d7714e4e);
		self waittill(#"done_speaking");
		return 1;
	}
	return 0;
}

/*
	Name: function_597484c3
	Namespace: namespace_891c9bac
	Checksum: 0x6CA160
	Offset: 0x2AD0
	Size: 0x144
	Parameters: 3
	Flags: Linked, Private
*/
private function function_597484c3(n_delay, var_56f97c91, var_d7714e4e)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon_callback(&vo_clear, #"death");
	self.isspeaking = 1;
	self.var_5b6ebfd0 = var_d7714e4e;
	if(!isdefined(level.var_62281818))
	{
		level.var_62281818 = [];
	}
	else if(!isarray(level.var_62281818))
	{
		level.var_62281818 = array(level.var_62281818);
	}
	level.var_62281818[level.var_62281818.size] = self;
	zm_audio::sndvoxoverride(1);
	if(n_delay > 0)
	{
		wait(n_delay);
	}
	zm_audio::play_vo_internal(var_56f97c91, (var_d7714e4e ? self : undefined));
	vo_clear();
}

/*
	Name: function_cf1e151c
	Namespace: namespace_891c9bac
	Checksum: 0x5FC05CEB
	Offset: 0x2C20
	Size: 0x158
	Parameters: 5
	Flags: None
*/
function function_cf1e151c(var_3608d414, var_604e94aa = [], b_wait_if_busy = 0, var_2cb3b5d = 0, var_34e7887 = 0)
{
	var_845efa03 = 0;
	foreach(i, str_vo in var_3608d414)
	{
		var_fa74ccf1 = (isdefined(var_604e94aa[i]) ? var_604e94aa[i] : 0.5);
		var_a8d847a7 = function_8e0f4696(str_vo, var_fa74ccf1, b_wait_if_busy, var_2cb3b5d, var_34e7887);
		if(isdefined(var_a8d847a7) && var_a8d847a7)
		{
			var_845efa03 = 1;
			continue;
		}
		break;
	}
	return var_845efa03;
}

/*
	Name: function_7e4562d7
	Namespace: namespace_891c9bac
	Checksum: 0xD3EBB088
	Offset: 0x2D80
	Size: 0x4C4
	Parameters: 7
	Flags: Linked
*/
function function_7e4562d7(var_3505e2ee, var_604e94aa = [], b_wait_if_busy = 0, var_2cb3b5d = 0, var_34e7887 = 0, var_39ed8245 = 1, var_dcc9a85f = 2147483647)
{
	var_845efa03 = 0;
	var_cd5bda0c = [];
	if(isstring(var_3505e2ee) || function_7a600918(var_3505e2ee))
	{
		for(p = 1; p <= 16; p++)
		{
			var_6b452a2f = var_3505e2ee + "_" + "plr_" + p;
			for(i = 0; i < 20; i++)
			{
				str_alias = var_6b452a2f + "_" + i;
				if(soundexists(str_alias))
				{
					var_cd5bda0c[i] = array(p, str_alias);
				}
			}
		}
	}
	else if(isarray(var_3505e2ee))
	{
		var_cd5bda0c = var_3505e2ee;
	}
	a_keys = getarraykeys(var_cd5bda0c);
	var_a7e5c412 = array::sort_by_value(a_keys, 1);
	if(var_dcc9a85f < var_a7e5c412.size)
	{
		foreach(i, n_line in arraycopy(var_a7e5c412))
		{
			player = zm_utility::function_828bac1(var_cd5bda0c[n_line][0]);
			if(!isplayer(player))
			{
				arrayremoveindex(var_a7e5c412, i, 1);
			}
		}
	}
	var_2274675e = 0;
	var_acf085c3 = 0;
	foreach(i, n_line in var_a7e5c412)
	{
		var_fa74ccf1 = (isdefined(var_604e94aa[var_2274675e]) ? var_604e94aa[var_2274675e] : 0.5);
		var_2274675e++;
		var_4a094e30 = var_dcc9a85f - var_acf085c3;
		if(var_4a094e30 <= 0)
		{
			break;
		}
		else if(var_4a094e30 < var_a7e5c412.size - i)
		{
			if(math::cointoss())
			{
				continue;
			}
		}
		player = zm_utility::function_828bac1(var_cd5bda0c[n_line][0]);
		if(isdefined(player))
		{
			var_a8d847a7 = 0;
			if(isplayer(player))
			{
				var_a8d847a7 = player function_8e0f4696(var_cd5bda0c[n_line][1], var_fa74ccf1, b_wait_if_busy, var_2cb3b5d, var_34e7887);
			}
			if(isdefined(var_a8d847a7) && var_a8d847a7)
			{
				var_845efa03 = 1;
				var_acf085c3++;
			}
			if(var_39ed8245)
			{
				if(!(isdefined(player.var_4377124) && player.var_4377124))
				{
					break;
				}
			}
		}
	}
	return var_845efa03;
}

/*
	Name: function_57b8cd17
	Namespace: namespace_891c9bac
	Checksum: 0x826356B
	Offset: 0x3250
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_57b8cd17()
{
	if(isdefined(self.str_vo_being_spoken) && self.str_vo_being_spoken != "")
	{
		self stopsound(self.str_vo_being_spoken);
	}
	vo_clear();
}

/*
	Name: function_3c173d37
	Namespace: namespace_891c9bac
	Checksum: 0x441BE3BD
	Offset: 0x32B0
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_3c173d37(v_pos, n_range = 1000)
{
	foreach(player in util::get_players())
	{
		if(!isdefined(v_pos) || distancesquared(player.origin, v_pos) <= n_range * n_range)
		{
			player function_57b8cd17();
		}
	}
}

/*
	Name: function_82f9bc9f
	Namespace: namespace_891c9bac
	Checksum: 0xCB3AAF84
	Offset: 0x3398
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_82f9bc9f()
{
	fields = getcharacterfields(player_role::get(), currentsessionmode());
	if(isdefined(fields) && isdefined(fields.chrname) && fields.chrname != "")
	{
		return fields.chrname;
	}
	/#
		/#
			assert("");
		#/
	#/
	return "NONE";
}

/*
	Name: function_d8e12055
	Namespace: namespace_891c9bac
	Checksum: 0xE0CA16E4
	Offset: 0x3458
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_d8e12055(var_c93c147d)
{
	level.var_4c2cc614 = var_c93c147d;
}

