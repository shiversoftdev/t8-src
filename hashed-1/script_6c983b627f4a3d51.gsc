// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6c983b627f4a3d51;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_c8efdadc;

/*
	Name: init
	Namespace: namespace_c8efdadc
	Checksum: 0x11B30B3A
	Offset: 0x148
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init("fl_oracle_unlocked");
	level.s_apollo_bowl = struct::get("s_apollo_bowl", "targetname");
	level thread function_29bff3c6();
	level thread function_407b2b88();
	level thread function_e71df7b6();
}

/*
	Name: function_29bff3c6
	Namespace: namespace_c8efdadc
	Checksum: 0xBBFDA061
	Offset: 0x1E8
	Size: 0x1FE
	Parameters: 0
	Flags: Linked
*/
function function_29bff3c6()
{
	level endon(#"game_ended");
	level flag::wait_till("all_players_connected");
	level flag::wait_till("power_on");
	level.var_d5ba7324 = util::spawn_model(#"tag_origin", level.s_apollo_bowl.origin, level.s_apollo_bowl.angles);
	waitframe(1);
	level.var_705db276 = 1;
	level.var_d5ba7324 clientfield::set("" + #"hash_74fc30de57a0657a", level.var_705db276);
	a_players = getplayers();
	level.var_6a1bdc96 = 16 * a_players.size;
	level.var_ba3adfd9 = [];
	level.var_ba3adfd9[0] = 0;
	level.var_ba3adfd9[1] = level.var_6a1bdc96 * 0.15;
	level.var_ba3adfd9[2] = level.var_6a1bdc96 * 0.35;
	level.var_ba3adfd9[3] = level.var_6a1bdc96 * 0.55;
	level.var_ba3adfd9[4] = level.var_6a1bdc96 * 0.75;
	level.var_ba3adfd9[5] = level.var_6a1bdc96 * 1;
	level.var_7faa1e46 = 0;
}

/*
	Name: function_9c8540b4
	Namespace: namespace_c8efdadc
	Checksum: 0x671B40D
	Offset: 0x3F0
	Size: 0x1D0
	Parameters: 2
	Flags: Linked
*/
function function_9c8540b4(e_player, n_amount)
{
	e_player endon(#"death");
	if(level.var_705db276 >= 5)
	{
		return;
	}
	if(isdefined(n_amount))
	{
		level.var_7faa1e46 = level.var_7faa1e46 + n_amount;
		if(level.var_7faa1e46 >= level.var_ba3adfd9[level.var_705db276])
		{
			while(level.var_7faa1e46 >= level.var_ba3adfd9[level.var_705db276])
			{
				level.var_705db276++;
				if(level.var_705db276 == 5)
				{
					break;
				}
			}
			level.var_d5ba7324 clientfield::set("" + #"hash_74fc30de57a0657a", level.var_705db276);
		}
		if(level.var_705db276 == 5)
		{
			level flag::set("fl_oracle_unlocked");
			foreach(player in getplayers())
			{
				player zm_vo::function_8e0f4696(#"hash_4c29e41ef47ad9b2", 0, 1, 9999, 1, 1, 1);
			}
		}
	}
}

/*
	Name: function_e71df7b6
	Namespace: namespace_c8efdadc
	Checksum: 0x52750269
	Offset: 0x5C8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_e71df7b6()
{
	level flag::wait_till("all_players_connected");
	scene::add_scene_func("aib_vign_cust_zm_red_orcl", &function_f4472adf, "idle");
	level thread scene::play("aib_vign_cust_zm_red_orcl", "unconscious");
	level flag::wait_till("power_on");
	scene::play("aib_vign_cust_zm_red_orcl", "awaken");
	level thread scene::play("aib_vign_cust_zm_red_orcl", "idle");
}

/*
	Name: function_f4472adf
	Namespace: namespace_c8efdadc
	Checksum: 0xDEDFEA88
	Offset: 0x6B8
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_f4472adf(a_ents)
{
	level.var_bb7822b7 = [];
	level.var_bb7822b7[0] = a_ents[#"hash_7aff0ee60ddd937b"];
	level.var_bb7822b7[1] = a_ents[#"prop 2"];
	level.var_bb7822b7[2] = a_ents[#"prop 3"];
	level.var_bb7822b7[3] = a_ents[#"prop 4"];
	level.var_bb7822b7[4] = a_ents[#"prop 5"];
}

/*
	Name: function_53bac096
	Namespace: namespace_c8efdadc
	Checksum: 0x46B626E
	Offset: 0x7A8
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_53bac096(b_hide)
{
	if(isdefined(level.var_7652563c) && level.var_7652563c)
	{
		level thread scene::play("aib_vign_cust_zm_red_orcl", "idle");
		wait(0.2);
	}
	if(!isdefined(level.var_bb7822b7))
	{
		return;
	}
	if(b_hide)
	{
		foreach(mdl in level.var_bb7822b7)
		{
			mdl ghost();
		}
	}
	else
	{
		foreach(mdl in level.var_bb7822b7)
		{
			mdl show();
		}
	}
}

/*
	Name: function_407b2b88
	Namespace: namespace_c8efdadc
	Checksum: 0x252F6581
	Offset: 0x918
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_407b2b88()
{
	level endon(#"game_ended");
	level flag::wait_till("all_players_connected");
	level flag::wait_till("power_on");
	level.var_483180c5 = getent("coal_brazier_apollo", "targetname");
	level.var_483180c5 clientfield::set("" + #"hash_118e9445b028d4bf", 1);
}

