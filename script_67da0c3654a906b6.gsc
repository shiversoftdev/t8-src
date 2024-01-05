// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace namespace_6c76c1da;

/*
	Name: __init__system__
	Namespace: namespace_6c76c1da
	Checksum: 0x93F6291E
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_442b60ca31422a3c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6c76c1da
	Checksum: 0xFAB70C91
	Offset: 0x110
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_5124770c13a75bab", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_6c76c1da
	Checksum: 0x7D95D6C0
	Offset: 0x178
	Size: 0x160
	Parameters: 3
	Flags: Private
*/
function private on_begin(var_93fc795f, var_a7c52900, var_c8a36f90)
{
	var_a7c52900 = zm_trial::function_5769f26a(var_a7c52900);
	level.var_1c8f9eba = var_c8a36f90;
	wait(6);
	foreach(player in getplayers())
	{
		if(isdefined(var_c8a36f90))
		{
			switch(var_c8a36f90)
			{
				case "prone_random":
				{
					player thread function_9c988cd8(var_93fc795f, var_a7c52900, 1);
					break;
				}
				case "crouch":
				{
					player thread function_9c988cd8(var_93fc795f, var_a7c52900, 0);
					break;
				}
			}
			continue;
		}
		player thread movement_watcher(var_93fc795f, var_a7c52900);
	}
}

/*
	Name: on_end
	Namespace: namespace_6c76c1da
	Checksum: 0xE99A207B
	Offset: 0x2E0
	Size: 0x16
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level.var_1c8f9eba = undefined;
}

/*
	Name: is_active
	Namespace: namespace_6c76c1da
	Checksum: 0x2FA39AFD
	Offset: 0x300
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_5124770c13a75bab");
	return isdefined(challenge);
}

/*
	Name: movement_watcher
	Namespace: namespace_6c76c1da
	Checksum: 0xBFF286ED
	Offset: 0x340
	Size: 0x136
	Parameters: 2
	Flags: Private
*/
function private movement_watcher(var_93fc795f, var_98de1f93)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		var_197c85d1 = self getvelocity();
		var_9b7f7d9b = length(var_197c85d1);
		if(isalive(self) && !self laststand::player_is_in_laststand() && !self issprinting())
		{
			self function_6b13a114(var_93fc795f, var_98de1f93);
			if(var_9b7f7d9b == 0)
			{
				n_wait_time = 0.25;
			}
			else
			{
				n_wait_time = max(0.5, var_9b7f7d9b / 190);
			}
			wait(n_wait_time);
		}
		waitframe(1);
	}
}

/*
	Name: function_6b13a114
	Namespace: namespace_6c76c1da
	Checksum: 0x90959189
	Offset: 0x480
	Size: 0x94
	Parameters: 2
	Flags: Private
*/
function private function_6b13a114(var_93fc795f, var_a7c52900)
{
	self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
	if(var_93fc795f === "health")
	{
		self dodamage(var_a7c52900, self.origin);
	}
	else if(var_93fc795f === "points")
	{
		self zm_score::minus_to_player_score(var_a7c52900, 1);
	}
}

/*
	Name: function_26f124d8
	Namespace: namespace_6c76c1da
	Checksum: 0xCB7B6DAB
	Offset: 0x520
	Size: 0x1D4
	Parameters: 0
	Flags: Private
*/
function private function_26f124d8()
{
	if(!isdefined(level.var_1c8f9eba))
	{
		return true;
	}
	switch(level.var_1c8f9eba)
	{
		case "ads":
		{
			var_389b3ef1 = self playerads();
			if(self adsbuttonpressed() && var_389b3ef1 > 0)
			{
				return true;
			}
			return false;
		}
		case "jump":
		{
			if(self zm_utility::is_jumping())
			{
				return true;
			}
			return false;
		}
		case "slide":
		{
			if(self issliding())
			{
				return true;
			}
			return false;
		}
		case "crouch":
		{
			if(self getstance() === "crouch")
			{
				return true;
			}
			return false;
		}
		case "prone_random":
		case "prone":
		{
			if(self getstance() === "prone")
			{
				return true;
			}
			return false;
		}
		case "movement":
		default:
		{
			v_velocity = self getvelocity();
			if(length(v_velocity) != 0)
			{
				return true;
			}
			return false;
		}
	}
	return false;
}

/*
	Name: function_9c988cd8
	Namespace: namespace_6c76c1da
	Checksum: 0x7BC4C4ED
	Offset: 0x700
	Size: 0x10A
	Parameters: 3
	Flags: Private
*/
function private function_9c988cd8(var_93fc795f, var_98de1f93, var_e898f976 = 0)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	if(!var_e898f976)
	{
		wait(12);
	}
	while(true)
	{
		if(var_e898f976)
		{
			wait(randomfloatrange(10, 25));
		}
		else
		{
			waitframe(1);
		}
		while(isalive(self) && !self laststand::player_is_in_laststand() && !self function_26f124d8())
		{
			self function_6b13a114(var_93fc795f, var_98de1f93);
			wait(1);
		}
	}
}

