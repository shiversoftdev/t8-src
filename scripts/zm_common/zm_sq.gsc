// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace zm_sq;

/*
	Name: init
	Namespace: zm_sq
	Checksum: 0x3FE2E82B
	Offset: 0xF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec, Private
*/
function private autoexec init()
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			adddebugcommand("");
		}
	#/
}

/*
	Name: register
	Namespace: zm_sq
	Checksum: 0xB7B5E522
	Offset: 0x148
	Size: 0x674
	Parameters: 7
	Flags: Linked
*/
function register(name, step_name, var_e788cdd7, setup_func, cleanup_func, var_d6ca4caf, var_27465eb4)
{
	/#
		/#
			assert(ishash(name), "");
		#/
		/#
			assert(ishash(step_name), "");
		#/
		/#
			assert(ishash(var_e788cdd7), "");
		#/
		if(!isdefined(name))
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
			return;
		}
		if(!isdefined(step_name))
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
			return;
		}
		if(!isdefined(setup_func))
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
			return;
		}
		if(!isdefined(cleanup_func))
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
			return;
		}
		if(isdefined(level._ee) && isdefined(level._ee[name]) && isdefined(var_d6ca4caf) && isdefined(level._ee[name].record_stat))
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
			return;
		}
	#/
	if(!isdefined(level._ee))
	{
		level._ee = [];
	}
	if(!isdefined(level._ee[name]))
	{
		level._ee[name] = {#skip_to_step:-1, #started:0, #current_step:0, #steps:[], #completed:0, #name:name};
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				thread function_28aee167(name);
			}
		#/
	}
	ee = level._ee[name];
	if(!isdefined(ee.record_stat))
	{
		ee.record_stat = var_d6ca4caf;
	}
	if(!isdefined(ee.var_35ccab99))
	{
		ee.var_35ccab99 = var_27465eb4;
	}
	new_step = {#cleaned_up:0, #completed:0, #started:0, #cleanup_func:cleanup_func, #setup_func:setup_func, #hash_e788cdd7:var_e788cdd7, #ee:ee, #name:step_name};
	previous_step = ee.steps[level._ee[name].steps.size - 1];
	if(isdefined(previous_step))
	{
		previous_step.next_step = new_step;
	}
	if(!isdefined(ee.steps))
	{
		ee.steps = [];
	}
	else if(!isarray(ee.steps))
	{
		ee.steps = array(ee.steps);
	}
	ee.steps[ee.steps.size] = new_step;
	level flag::init(var_e788cdd7 + "_completed");
	if(!level flag::exists(ee.name + "_completed"))
	{
		level flag::init(ee.name + "_completed");
	}
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			thread function_b3da1a16(ee.name, new_step.name);
			thread devgui_think();
		}
	#/
}

/*
	Name: start
	Namespace: zm_sq
	Checksum: 0x7719ADEB
	Offset: 0x7C8
	Size: 0x254
	Parameters: 2
	Flags: Linked
*/
function start(name, var_9d8cf7f = 0)
{
	if(!zm_utility::is_ee_enabled() && !var_9d8cf7f)
	{
		return;
	}
	/#
		assert(ishash(name), "");
	#/
	/#
		/#
			assert(isdefined(level._ee[name]), ("" + function_9e72a96(name)) + "");
		#/
	#/
	if(level._ee[name].started)
	{
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(("" + function_9e72a96(name)) + "");
				println(("" + function_9e72a96(name)) + "");
			}
		#/
		return;
	}
	ee = level._ee[name];
	var_5ea5c94d = 0;
	/#
		if(ee.skip_to_step > -1)
		{
			/#
				assert(0 <= ee.skip_to_step, "");
			#/
			if(0 < ee.skip_to_step)
			{
				var_5ea5c94d = 1;
			}
			else if(0 == ee.skip_to_step)
			{
				ee.skip_to_step = -1;
			}
		}
	#/
	level thread run_step(ee, ee.steps[0], var_5ea5c94d);
}

/*
	Name: is_complete
	Namespace: zm_sq
	Checksum: 0x1A47757B
	Offset: 0xA28
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function is_complete(name)
{
	/#
		assert(ishash(name), "");
	#/
	/#
		/#
			assert(isdefined(level._ee[name]), ("" + function_9e72a96(name)) + "");
		#/
	#/
	return level._ee[name].completed;
}

/*
	Name: function_9212ff4d
	Namespace: zm_sq
	Checksum: 0x1490ABBF
	Offset: 0xAD8
	Size: 0x142
	Parameters: 2
	Flags: None
*/
function function_9212ff4d(ee_name, step_name)
{
	/#
		assert(ishash(ee_name), "");
	#/
	/#
		assert(ishash(step_name), "");
	#/
	/#
		assert(isdefined(level._ee[ee_name]), ("" + ee_name) + "");
	#/
	foreach(ee_index, ee_step in level._ee[ee_name].steps)
	{
		if(step_name == ee_step.name)
		{
			return ee_index;
		}
	}
	return -1;
}

/*
	Name: run_step
	Namespace: zm_sq
	Checksum: 0x786C174E
	Offset: 0xC28
	Size: 0x894
	Parameters: 3
	Flags: Linked, Private
*/
function private run_step(ee, step, var_5ea5c94d)
{
	level endon(#"game_ended");
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
			println((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
		}
	#/
	ee.started = 1;
	step.started = 1;
	level thread function_3f795dc3(ee, step, var_5ea5c94d);
	if(!step.completed)
	{
		waitresult = undefined;
		waitresult = level waittill(step.var_e788cdd7 + "_setup_completed", step.var_e788cdd7 + "_ended_early");
	}
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
			println((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
		}
	#/
	if(game.state === "postgame")
	{
		return;
	}
	ended_early = isdefined(waitresult) && waitresult._notify == (step.var_e788cdd7 + "_ended_early");
	[[step.cleanup_func]](var_5ea5c94d, ended_early);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
			println((function_9e72a96(ee.name) + "") + function_9e72a96(step.name) + "");
		}
	#/
	step.cleaned_up = 1;
	if(game.state === "postgame")
	{
		return;
	}
	level flag::set(step.var_e788cdd7 + "_completed");
	if(ee.current_step === 0 && (isdefined(ee.record_stat) && ee.record_stat))
	{
		players = getplayers();
		foreach(player in players)
		{
			player.var_897fa11b = 1;
		}
	}
	if(isdefined(step.next_step))
	{
		var_5ea5c94d = 0;
		/#
			if(ee.skip_to_step > -1)
			{
				var_7f1ec3f3 = ee.current_step + 1;
				/#
					assert(var_7f1ec3f3 <= ee.skip_to_step, "");
				#/
				if(var_7f1ec3f3 < ee.skip_to_step)
				{
					var_5ea5c94d = 1;
				}
				else if(var_7f1ec3f3 == ee.skip_to_step)
				{
					ee.skip_to_step = -1;
				}
				wait(0.5);
			}
		#/
		ee.current_step++;
		level thread run_step(ee, step.next_step, var_5ea5c94d);
	}
	else
	{
		ee.completed = 1;
		level flag::set(ee.name + "_completed");
		if(sessionmodeisonlinegame() && (isdefined(ee.record_stat) && ee.record_stat))
		{
			players = getplayers();
			foreach(player in players)
			{
				if(isdefined(player.var_897fa11b) && player.var_897fa11b)
				{
					player zm_stats::set_map_stat(#"main_quest_completed", 1);
					player zm_stats::function_a6efb963(#"main_quest_completed", 1);
					player zm_stats::function_9288c79b(#"main_quest_completed", 1);
					n_time_elapsed = gettime() - level.var_21e22beb;
					player zm_stats::function_366b6fb9("FASTEST_QUEST_COMPLETION_TIME", n_time_elapsed);
					scoreevents::processscoreevent(#"main_ee", player);
					if(isdefined(ee.var_35ccab99))
					{
						player thread [[ee.var_35ccab99]]();
					}
				}
			}
			zm_stats::set_match_stat(#"main_quest_completed", 1);
			zm_stats::function_ea5b4947();
		}
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(("" + function_9e72a96(ee.name)) + "");
				println(("" + function_9e72a96(ee.name)) + "");
			}
		#/
	}
}

/*
	Name: function_3f795dc3
	Namespace: zm_sq
	Checksum: 0x4B4345FC
	Offset: 0x14C8
	Size: 0xB6
	Parameters: 3
	Flags: Linked, Private
*/
function private function_3f795dc3(ee, step, var_5ea5c94d)
{
	level endon(#"game_ended");
	step endoncallback(&function_df365859, #"end_early");
	level notify(step.var_e788cdd7 + "_started");
	[[step.setup_func]](var_5ea5c94d);
	step.completed = 1;
	level notify(step.var_e788cdd7 + "_setup_completed");
}

/*
	Name: function_df365859
	Namespace: zm_sq
	Checksum: 0x25E3EBE5
	Offset: 0x1588
	Size: 0x12A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_df365859(notifyhash)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((function_9e72a96(self.ee.name) + "") + function_9e72a96(self.name) + "");
			println((function_9e72a96(self.ee.name) + "") + function_9e72a96(self.name) + "");
		}
	#/
	self.completed = 1;
	level notify(self.var_e788cdd7 + "_ended_early");
	level notify(self.var_e788cdd7 + "_setup_completed");
}

/*
	Name: function_f09763fd
	Namespace: zm_sq
	Checksum: 0x6A1E7D4A
	Offset: 0x16C0
	Size: 0x1DC
	Parameters: 2
	Flags: None
*/
function function_f09763fd(ee_name, step_name)
{
	/#
		/#
			assert(ishash(ee_name), "");
		#/
		/#
			assert(isdefined(level._ee[ee_name]), ("" + ee_name) + "");
		#/
		var_da601d7f = function_44e256d8(ee_name);
		index = function_9212ff4d(ee_name, step_name);
		if(index == -1)
		{
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(step_name));
				println((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(step_name));
			}
			return;
		}
		return (((var_da601d7f + "") + function_9e72a96(step_name) + "") + index) + "";
	#/
}

/*
	Name: function_44e256d8
	Namespace: zm_sq
	Checksum: 0x600097F8
	Offset: 0x18A8
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_44e256d8(ee_name)
{
	/#
		/#
			assert(ishash(ee_name), "");
		#/
		return ("" + function_9e72a96(ee_name)) + "";
	#/
}

/*
	Name: function_28aee167
	Namespace: zm_sq
	Checksum: 0xAA10523C
	Offset: 0x1918
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_28aee167(ee_name)
{
	/#
		/#
			assert(ishash(ee_name), "");
		#/
		ee_path = function_44e256d8(ee_name);
		util::waittill_can_add_debug_command();
		adddebugcommand((("" + ee_path) + "") + function_9e72a96(ee_name) + "");
	#/
}

/*
	Name: function_b3da1a16
	Namespace: zm_sq
	Checksum: 0x13216CBC
	Offset: 0x19E8
	Size: 0x184
	Parameters: 2
	Flags: None
*/
function function_b3da1a16(ee_name, step_name)
{
	/#
		/#
			assert(ishash(ee_name), "");
		#/
		/#
			assert(ishash(step_name), "");
		#/
		step_path = function_f09763fd(ee_name, step_name);
		index = function_9212ff4d(ee_name, step_name);
		util::waittill_can_add_debug_command();
		adddebugcommand((((("" + step_path) + "") + function_9e72a96(ee_name) + "") + index) + "");
		adddebugcommand((((("" + step_path) + "") + function_9e72a96(ee_name) + "") + index) + "");
	#/
}

/*
	Name: function_87306f8a
	Namespace: zm_sq
	Checksum: 0x7D0DF259
	Offset: 0x1B78
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function function_87306f8a(ee_name, step_name)
{
	/#
		ee = level._ee[ee_name];
		step_index = function_9212ff4d(ee_name, step_name);
		if(ee.started && step_index <= ee.current_step)
		{
			return false;
		}
		ee.skip_to_step = step_index;
		if(ee.started)
		{
			function_614612f(ee_name);
		}
		else
		{
			start(ee.name);
		}
		return true;
	#/
}

/*
	Name: function_614612f
	Namespace: zm_sq
	Checksum: 0xD91CEEAE
	Offset: 0x1C60
	Size: 0x16C
	Parameters: 1
	Flags: None
*/
function function_614612f(ee_name)
{
	/#
		ee = level._ee[ee_name];
		if(ee.started)
		{
			ee.steps[ee.current_step] notify(#"end_early");
		}
		else if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(ee.steps[ee.current_step].name) + "");
			println((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(ee.steps[ee.current_step].name) + "");
		}
	#/
}

/*
	Name: function_f2dd8601
	Namespace: zm_sq
	Checksum: 0xE5F8DFB3
	Offset: 0x1DD8
	Size: 0x324
	Parameters: 2
	Flags: None
*/
function function_f2dd8601(ee_name, var_f2c264bb)
{
	/#
		level endon(#"game_ended");
		ee = level._ee[ee_name];
		step = ee.steps[var_f2c264bb];
		if(function_87306f8a(ee_name, step.name))
		{
			if(!step.started)
			{
				wait_time = 10 * ee.steps.size;
				waitresult = undefined;
				waitresult = level waittilltimeout(wait_time, step.var_e788cdd7 + "");
				if(waitresult._notify == #"timeout")
				{
					if(getdvarint(#"hash_7919e37cd5d57659", 0))
					{
						iprintlnbold((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
						println((("" + function_9e72a96(ee_name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
					}
					return;
				}
			}
			wait(1);
		}
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name) + "");
			println((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name) + "");
		}
		function_614612f(ee_name);
	#/
}

/*
	Name: devgui_think
	Namespace: zm_sq
	Checksum: 0x5379F41B
	Offset: 0x2108
	Size: 0x7B6
	Parameters: 0
	Flags: None
*/
function devgui_think()
{
	/#
		level notify(#"hash_6d8b1a4c632ecc9");
		level endon(#"hash_6d8b1a4c632ecc9");
		while(true)
		{
			wait(1);
			cmd = getdvarstring(#"hash_319d902ea18eb39");
			setdvar(#"hash_319d902ea18eb39", "");
			cmd = strtok(cmd, "");
			if(cmd.size == 0)
			{
				continue;
			}
			switch(cmd[0])
			{
				case "skip_to":
				{
					ee = level._ee[cmd[1]];
					if(!isdefined(ee))
					{
						continue;
					}
					var_f2c264bb = int(cmd[2]);
					step_name = ee.steps[var_f2c264bb].name;
					if(var_f2c264bb < ee.current_step)
					{
						if(getdvarint(#"hash_7919e37cd5d57659", 0))
						{
							iprintlnbold((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
							println((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
						}
					}
					else
					{
						if(var_f2c264bb == ee.current_step)
						{
							if(getdvarint(#"hash_7919e37cd5d57659", 0))
							{
								iprintlnbold((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(step_name));
								println((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(step_name));
							}
						}
						else
						{
							if(getdvarint(#"hash_7919e37cd5d57659", 0))
							{
								iprintlnbold((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(step_name) + "");
								println((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(step_name) + "");
							}
							function_87306f8a(ee.name, step_name);
						}
					}
					break;
				}
				case "complete":
				{
					ee = level._ee[cmd[1]];
					if(!isdefined(ee))
					{
						continue;
					}
					var_f2c264bb = int(cmd[2]);
					if(var_f2c264bb < ee.current_step)
					{
						if(getdvarint(#"hash_7919e37cd5d57659", 0))
						{
							iprintlnbold((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
							println((("" + function_9e72a96(ee.name)) + "") + function_9e72a96(ee.steps[ee.current_step].name));
						}
					}
					else
					{
						level thread function_f2dd8601(ee.name, var_f2c264bb);
					}
					break;
				}
				case "start":
				{
					if(isdefined(level._ee[cmd[1]]))
					{
						start(hash(cmd[1]));
					}
					break;
				}
				case "show_status":
				{
					if(isdefined(level.var_7f2ca392) && level.var_7f2ca392)
					{
						function_c1d3567c();
					}
					else
					{
						function_5df75220();
						level thread function_9bee49bf();
					}
					break;
				}
				case "outro":
				{
					if(cmd.size < 2 || !isdefined(level._ee[cmd[1]]))
					{
						break;
					}
					ee = level._ee[cmd[1]];
					if(isdefined(ee))
					{
						level waittill(#"start_zombie_round_logic");
						step_name = ee.steps[ee.steps.size - 1].name;
						function_87306f8a(ee.name, step_name);
					}
					break;
				}
			}
		}
	#/
}

/*
	Name: create_hudelem
	Namespace: zm_sq
	Checksum: 0xEB14E1D1
	Offset: 0x28C8
	Size: 0xBA
	Parameters: 2
	Flags: Private
*/
function private create_hudelem(y, x)
{
	/#
		if(!isdefined(x))
		{
			x = 0;
		}
		var_aa917a22 = newdebughudelem();
		var_aa917a22.alignx = "";
		var_aa917a22.horzalign = "";
		var_aa917a22.aligny = "";
		var_aa917a22.vertalign = "";
		var_aa917a22.y = y;
		var_aa917a22.x = x;
		return var_aa917a22;
	#/
}

/*
	Name: function_5df75220
	Namespace: zm_sq
	Checksum: 0x2AD16F45
	Offset: 0x2990
	Size: 0x24A
	Parameters: 0
	Flags: None
*/
function function_5df75220()
{
	/#
		current_y = 30;
		foreach(ee in level._ee)
		{
			current_x = 30;
			if(!isdefined(ee.debug_hudelem))
			{
				ee.debug_hudelem = create_hudelem(current_y, current_x);
			}
			ee.debug_hudelem settext(function_9e72a96(ee.name));
			ee.debug_hudelem.fontscale = 1.5;
			current_x = current_x + 5;
			step_string = "";
			foreach(step in ee.steps)
			{
				current_y = current_y + 15;
				if(!isdefined(step.debug_hudelem))
				{
					step.debug_hudelem = create_hudelem(current_y, current_x);
				}
				step.debug_hudelem settext(step_string + function_9e72a96(step.name));
				step.debug_hudelem.fontscale = 1.5;
			}
			current_y = current_y + 30;
		}
		level.var_7f2ca392 = 1;
	#/
}

/*
	Name: function_c1d3567c
	Namespace: zm_sq
	Checksum: 0x65220912
	Offset: 0x2BE8
	Size: 0x162
	Parameters: 0
	Flags: None
*/
function function_c1d3567c()
{
	/#
		level notify(#"hash_21c0567b0010f696");
		foreach(ee in level._ee)
		{
			if(isdefined(ee.debug_hudelem))
			{
				ee.debug_hudelem destroy();
			}
			ee.debug_hudelem = undefined;
			foreach(step in ee.steps)
			{
				if(isdefined(step.debug_hudelem))
				{
					step.debug_hudelem destroy();
				}
				step.debug_hudelem = undefined;
			}
		}
		level.var_7f2ca392 = undefined;
	#/
}

/*
	Name: function_9bee49bf
	Namespace: zm_sq
	Checksum: 0x610BFF0C
	Offset: 0x2D58
	Size: 0x142
	Parameters: 0
	Flags: None
*/
function function_9bee49bf()
{
	/#
		level endon(#"hash_21c0567b0010f696");
		while(true)
		{
			waitframe(1);
			foreach(ee in level._ee)
			{
				ee.debug_hudelem.color = function_1091b2a0(ee);
				foreach(step in ee.steps)
				{
					step.debug_hudelem.color = function_1091b2a0(step);
				}
			}
		}
	#/
}

/*
	Name: function_1091b2a0
	Namespace: zm_sq
	Checksum: 0x3F693850
	Offset: 0x2EA8
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_1091b2a0(var_4f1c1316)
{
	/#
		if(!var_4f1c1316.started)
		{
			color = vectorscale((1, 1, 1), 0.75);
		}
		else
		{
			if(!var_4f1c1316.completed)
			{
				color = (1, 0, 0);
			}
			else
			{
				color = (0, 1, 0);
			}
		}
		return color;
	#/
}

