// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_bgb_board_games;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_board_games
	Checksum: 0xFA430EB5
	Offset: 0x110
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_board_games", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_board_games
	Checksum: 0x99F2830E
	Offset: 0x160
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_board_games", "time", 300, &enable, &disable, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_board_games
	Checksum: 0x8D654F86
	Offset: 0x1E0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self thread function_202a3d22();
}

/*
	Name: disable
	Namespace: zm_bgb_board_games
	Checksum: 0x80F724D1
	Offset: 0x208
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

/*
	Name: function_202a3d22
	Namespace: zm_bgb_board_games
	Checksum: 0xE920DD05
	Offset: 0x218
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_202a3d22()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"boarding_window");
		s_window = waitresult;
		self bgb::do_one_shot_use();
		self thread function_c2342058(s_window);
	}
}

/*
	Name: function_c2342058
	Namespace: zm_bgb_board_games
	Checksum: 0x29B9CF47
	Offset: 0x2C8
	Size: 0x32C
	Parameters: 1
	Flags: Linked
*/
function function_c2342058(s_window)
{
	carp_ent = spawn("script_origin", (0, 0, 0));
	carp_ent playloopsound(#"evt_carpenter");
	while(true)
	{
		if(zm_utility::all_chunks_intact(s_window, s_window.barrier_chunks))
		{
			break;
		}
		chunk = zm_utility::get_random_destroyed_chunk(s_window, s_window.barrier_chunks);
		if(!isdefined(chunk))
		{
			break;
		}
		s_window thread zm_blockers::replace_chunk(s_window, chunk, undefined, 1);
		self.rebuild_barrier_reward = self.rebuild_barrier_reward + 10;
		if(self.rebuild_barrier_reward < zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round"))
		{
			self zm_score::player_add_points("rebuild_board", 10);
			self zm_utility::play_sound_on_ent("purchase");
		}
		last_repaired_chunk = chunk;
		if(isdefined(s_window.clip))
		{
			s_window.clip triggerenable(1);
			s_window.clip disconnectpaths();
		}
		else
		{
			zm_blockers::blocker_disconnect_paths(s_window.neg_start, s_window.neg_end);
		}
		util::wait_network_frame();
		num_chunks_checked++;
		if(num_chunks_checked >= 20)
		{
			break;
		}
	}
	if(isdefined(s_window.zbarrier))
	{
		if(isdefined(last_repaired_chunk))
		{
			while(s_window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing")
			{
				waitframe(1);
			}
			if(isdefined(s_window._post_carpenter_callback))
			{
				s_window [[s_window._post_carpenter_callback]]();
			}
		}
	}
	else
	{
		while(isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair")
		{
			waitframe(1);
		}
	}
	carp_ent stoploopsound(1);
	carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
	carp_ent waittill(#"sound_done");
	carp_ent delete();
}

