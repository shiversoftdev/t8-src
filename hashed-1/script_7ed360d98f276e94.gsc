// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using script_621434df66e97145;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_ba0faeb1;

/*
	Name: function_89f2df9
	Namespace: namespace_ba0faeb1
	Checksum: 0xDB80BC67
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_18e1088f472208bf", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ba0faeb1
	Checksum: 0x110449CA
	Offset: 0x110
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_18e1088f472208bf", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_ba0faeb1
	Checksum: 0xD82256A
	Offset: 0x178
	Size: 0x290
	Parameters: 4
	Flags: Linked, Private
*/
function private function_d1de6a85(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_b4a6cec6 = zm_trial::function_5769f26a(var_8a72a00b);
			break;
		}
		case 2:
		{
			level.var_b4a6cec6 = zm_trial::function_5769f26a(var_49d8a02c);
			break;
		}
		case 3:
		{
			level.var_b4a6cec6 = zm_trial::function_5769f26a(var_325ff213);
			break;
		}
		case 4:
		{
			level.var_b4a6cec6 = zm_trial::function_5769f26a(var_dd2fad64);
			break;
		}
	}
	callback::on_ai_killed(&on_ai_killed);
	level flag::set(#"hash_25d9ccebd2bdecd9");
	n_obj_id = gameobjects::get_next_obj_id();
	level.a_n_objective_ids[#"hash_18e1088f472208bf"] = n_obj_id;
	objective_add(n_obj_id, "active", level.s_weapons_locker.origin, #"hash_423a75e2700a53ab");
	function_da7940a3(n_obj_id, 1);
	foreach(player in getplayers())
	{
		player.var_45c57fa5 setinvisibletoplayer(player, 0);
		player.var_5a5bf8e7 = 0;
		player.var_9360d1b5 = undefined;
		player thread function_ccbbe9c4(n_obj_id);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_ba0faeb1
	Checksum: 0x2D4189B9
	Offset: 0x410
	Size: 0x252
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	callback::remove_on_ai_killed(&on_ai_killed);
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(player.var_b4a6cec6 < level.var_b4a6cec6)
			{
				if(!isdefined(var_696c3b4))
				{
					var_696c3b4 = [];
				}
				else if(!isarray(var_696c3b4))
				{
					var_696c3b4 = array(var_696c3b4);
				}
				var_696c3b4[var_696c3b4.size] = player;
			}
		}
		if(var_696c3b4.size)
		{
			zm_trial::fail(#"hash_73f632514ab7d15", var_696c3b4);
		}
	}
	objective_delete(level.a_n_objective_ids[#"hash_18e1088f472208bf"]);
	gameobjects::release_obj_id(level.a_n_objective_ids[#"hash_18e1088f472208bf"]);
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
		}
	}
	level.var_b4a6cec6 = undefined;
}

/*
	Name: on_ai_killed
	Namespace: namespace_ba0faeb1
	Checksum: 0x9242EFB
	Offset: 0x670
	Size: 0x224
	Parameters: 1
	Flags: Linked, Private
*/
function private on_ai_killed(params)
{
	if(isplayer(params.eattacker))
	{
		w_root = zm_weapons::function_386dacbc(params.weapon);
		if(params.eattacker.var_636a8bf7 == w_root.name && (isdefined(params.eattacker.var_5a5bf8e7) && params.eattacker.var_5a5bf8e7) && (!(isdefined(params.eattacker.var_9360d1b5) && params.eattacker.var_9360d1b5)))
		{
			params.eattacker.var_b4a6cec6++;
			if(params.eattacker.var_b4a6cec6 < level.var_b4a6cec6)
			{
				params.eattacker namespace_b22c99a5::function_c2cd0cba(level.var_b4a6cec6);
				params.eattacker namespace_b22c99a5::function_2190356a(params.eattacker.var_b4a6cec6);
			}
			if(params.eattacker.var_b4a6cec6 == level.var_b4a6cec6)
			{
				params.eattacker namespace_b22c99a5::function_63060af4(1);
				params.eattacker.var_9360d1b5 = 1;
				params.eattacker notify(#"hash_6170578b35e8c5d7");
				if(level.var_f995ece6 zm_trial_timer::is_open(params.eattacker))
				{
					level.var_f995ece6 zm_trial_timer::close(params.eattacker);
				}
			}
		}
	}
}

/*
	Name: function_ccbbe9c4
	Namespace: namespace_ba0faeb1
	Checksum: 0xC5C99678
	Offset: 0x8A0
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_ccbbe9c4(n_obj_id)
{
	self endon(#"hash_7624857b01de8e38");
	self.var_b4a6cec6 = 0;
	self namespace_b22c99a5::function_c2cd0cba(level.var_b4a6cec6);
	self namespace_b22c99a5::function_2190356a(self.var_b4a6cec6);
	waitframe(1);
	s_notify = undefined;
	s_notify = self waittill(#"hash_9e146af7233ec36", #"hash_7646638df88a3656");
	objective_setinvisibletoplayer(n_obj_id, self);
	if(s_notify._notify == #"hash_9e146af7233ec36")
	{
		self thread function_8b87e57c(undefined, 2, 60);
	}
}

/*
	Name: function_8b87e57c
	Namespace: namespace_ba0faeb1
	Checksum: 0x11558324
	Offset: 0x9A0
	Size: 0x194
	Parameters: 3
	Flags: Linked, Private
*/
function private function_8b87e57c(var_9eb4b9f8, grace_period, var_690d3062)
{
	level endon(#"end_of_round", #"host_migration_begin", #"hash_7646638df88a3656", #"end_game");
	self endon(#"hash_6170578b35e8c5d7");
	if(!isdefined(level.var_489d6aa2))
	{
		level.var_489d6aa2 = var_9eb4b9f8;
	}
	if(!isdefined(level.var_869f4c31))
	{
		level.var_869f4c31 = var_690d3062;
	}
	wait(grace_period);
	var_9eb4b9f8 = (isdefined(var_9eb4b9f8) ? var_9eb4b9f8 : #"");
	if(!level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::open(self);
		level.var_f995ece6 zm_trial_timer::function_8ede8e82(self, var_9eb4b9f8);
		level.var_f995ece6 zm_trial_timer::function_6ad54036(self, 1);
	}
	self namespace_b22c99a5::start_timer(var_690d3062);
	wait(var_690d3062);
	zm_trial::fail(#"hash_73f632514ab7d15");
}

