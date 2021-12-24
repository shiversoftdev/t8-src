// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5660bae5b402a1eb;
#using script_6e3c826b1814cab6;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_carpenter;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_carpenter
	Checksum: 0xDD917DF2
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_carpenter", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_carpenter
	Checksum: 0x1438953E
	Offset: 0x1B8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("carpenter", &grab_carpenter);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("carpenter", "p7_zm_power_up_carpenter", #"hash_460ca52bf94f19c0", &func_should_drop_carpenter, 0, 0, 0);
	}
}

/*
	Name: grab_carpenter
	Namespace: zm_powerup_carpenter
	Checksum: 0xB765C1AE
	Offset: 0x248
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function grab_carpenter(e_player)
{
	var_ea1d8f06 = 1;
	if(zm_utility::is_standard())
	{
		var_ea1d8f06 = 0;
		e_player zm_score::player_add_points("carpenter_powerup", 200, undefined, undefined, undefined, undefined, 1);
	}
	level thread start_carpenter(e_player, var_ea1d8f06);
	e_player thread zm_powerups::powerup_vo("carpenter");
	level notify(#"hash_4d7676bba8e782b5", {#hash_264cf1f9:e_player});
}

/*
	Name: get_closest_window_repair
	Namespace: zm_powerup_carpenter
	Checksum: 0x33722CE2
	Offset: 0x320
	Size: 0x11C
	Parameters: 2
	Flags: None
*/
function get_closest_window_repair(windows, origin)
{
	current_window = undefined;
	shortest_distance = undefined;
	for(i = 0; i < windows.size; i++)
	{
		if(zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks))
		{
			continue;
		}
		if(!isdefined(current_window))
		{
			current_window = windows[i];
			shortest_distance = distancesquared(current_window.origin, origin);
			continue;
		}
		if(distancesquared(windows[i].origin, origin) < shortest_distance)
		{
			current_window = windows[i];
			shortest_distance = distancesquared(windows[i].origin, origin);
		}
	}
	return current_window;
}

/*
	Name: start_carpenter
	Namespace: zm_powerup_carpenter
	Checksum: 0xDACDD13F
	Offset: 0x448
	Size: 0x4FA
	Parameters: 2
	Flags: Linked
*/
function start_carpenter(var_264cf1f9, var_ea1d8f06 = 1)
{
	level.carpenter_powerup_active = 1;
	carp_ent = spawn("script_origin", (0, 0, 0));
	carp_ent playloopsound(#"evt_carpenter");
	if(namespace_59ff1d6c::function_901b751c(#"hash_3386caa315211c88"))
	{
		window_boards = struct::get_array("exterior_goal", "targetname");
		if(isdefined(level._additional_carpenter_nodes))
		{
			window_boards = arraycombine(window_boards, level._additional_carpenter_nodes, 0, 0);
		}
		boards_near_players = get_near_boards(window_boards);
		boards_far_from_players = get_far_boards(window_boards);
		level repair_far_boards(boards_far_from_players);
		for(i = 0; i < boards_near_players.size; i++)
		{
			window = boards_near_players[i];
			num_chunks_checked = 0;
			last_repaired_chunk = undefined;
			while(true)
			{
				if(zm_utility::all_chunks_intact(window, window.barrier_chunks))
				{
					break;
				}
				chunk = zm_utility::get_random_destroyed_chunk(window, window.barrier_chunks);
				if(!isdefined(chunk))
				{
					break;
				}
				window thread zm_blockers::replace_chunk(window, chunk, 1);
				last_repaired_chunk = chunk;
				if(isdefined(window.clip))
				{
					window.clip triggerenable(1);
					window.clip disconnectpaths();
				}
				else
				{
					zm_blockers::blocker_disconnect_paths(window.neg_start, window.neg_end);
				}
				util::wait_network_frame();
				num_chunks_checked++;
				if(num_chunks_checked >= 20)
				{
					break;
				}
			}
			if(isdefined(window.zbarrier))
			{
				if(isdefined(last_repaired_chunk))
				{
					while(window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing")
					{
						waitframe(1);
					}
					if(isdefined(window._post_carpenter_callback))
					{
						window [[window._post_carpenter_callback]]();
					}
				}
				continue;
			}
			while(isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair")
			{
				waitframe(1);
			}
		}
	}
	carp_ent stoploopsound(1);
	carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
	carp_ent waittill(#"sound_done");
	if(var_ea1d8f06)
	{
		if(zm_powerups::function_cfd04802(#"carpenter") && isplayer(var_264cf1f9))
		{
			var_264cf1f9 zm_score::player_add_points("carpenter_powerup", 200, undefined, undefined, undefined, undefined, 1);
		}
		else
		{
			foreach(e_player in level.players)
			{
				e_player zm_score::player_add_points("carpenter_powerup", 200, undefined, undefined, undefined, undefined, 1);
			}
		}
	}
	carp_ent delete();
	level notify(#"carpenter_finished");
	level.carpenter_powerup_active = undefined;
}

/*
	Name: get_near_boards
	Namespace: zm_powerup_carpenter
	Checksum: 0xEEBF7B2A
	Offset: 0x950
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function get_near_boards(windows)
{
	players = getplayers();
	boards_near_players = [];
	for(j = 0; j < windows.size; j++)
	{
		close = 0;
		for(i = 0; i < players.size; i++)
		{
			origin = undefined;
			if(isdefined(windows[j].zbarrier))
			{
				origin = windows[j].zbarrier.origin;
			}
			else
			{
				origin = windows[j].origin;
			}
			if(distancesquared(players[i].origin, origin) <= 562500)
			{
				close = 1;
				break;
			}
		}
		if(close)
		{
			boards_near_players[boards_near_players.size] = windows[j];
		}
	}
	return boards_near_players;
}

/*
	Name: get_far_boards
	Namespace: zm_powerup_carpenter
	Checksum: 0x51892C31
	Offset: 0xAA8
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function get_far_boards(windows)
{
	players = getplayers();
	boards_far_from_players = [];
	for(j = 0; j < windows.size; j++)
	{
		close = 0;
		for(i = 0; i < players.size; i++)
		{
			origin = undefined;
			if(isdefined(windows[j].zbarrier))
			{
				origin = windows[j].zbarrier.origin;
			}
			else
			{
				origin = windows[j].origin;
			}
			if(distancesquared(players[i].origin, origin) >= 562500)
			{
				close = 1;
				break;
			}
		}
		if(close)
		{
			boards_far_from_players[boards_far_from_players.size] = windows[j];
		}
	}
	return boards_far_from_players;
}

/*
	Name: repair_far_boards
	Namespace: zm_powerup_carpenter
	Checksum: 0xFA8616E0
	Offset: 0xC00
	Size: 0x24E
	Parameters: 1
	Flags: Linked
*/
function repair_far_boards(barriers)
{
	for(i = 0; i < barriers.size; i++)
	{
		barrier = barriers[i];
		if(zm_utility::all_chunks_intact(barrier, barrier.barrier_chunks))
		{
			continue;
		}
		if(isdefined(barrier.zbarrier))
		{
			a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
			if(isdefined(a_pieces))
			{
				for(xx = 0; xx < a_pieces.size; xx++)
				{
					chunk = a_pieces[xx];
					barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
					barrier.zbarrier.chunk_health[chunk] = 0;
				}
			}
			for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
			{
				barrier.zbarrier setzbarrierpiecestate(x, "closed");
				barrier.zbarrier showzbarrierpiece(x);
			}
		}
		if(isdefined(barrier.clip))
		{
			barrier.clip triggerenable(1);
			barrier.clip disconnectpaths();
		}
		else
		{
			zm_blockers::blocker_disconnect_paths(barrier.neg_start, barrier.neg_end);
		}
		if((i % 4) == 0)
		{
			util::wait_network_frame();
		}
	}
}

/*
	Name: func_should_drop_carpenter
	Namespace: zm_powerup_carpenter
	Checksum: 0xA25AFC7E
	Offset: 0xE58
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function func_should_drop_carpenter()
{
	if(get_num_window_destroyed() < 5 && (!(isdefined(level.var_ef7415bc) && level.var_ef7415bc)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: get_num_window_destroyed
	Namespace: zm_powerup_carpenter
	Checksum: 0xF326A706
	Offset: 0xEA8
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function get_num_window_destroyed()
{
	num = 0;
	for(i = 0; i < level.exterior_goals.size; i++)
	{
		if(zm_utility::all_chunks_destroyed(level.exterior_goals[i], level.exterior_goals[i].barrier_chunks))
		{
			num = num + 1;
		}
	}
	return num;
}

