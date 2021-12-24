// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_7d96b004;

/*
	Name: function_89f2df9
	Namespace: namespace_7d96b004
	Checksum: 0x2BC2D672
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1869d2f2ce17de3d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7d96b004
	Checksum: 0xC842275A
	Offset: 0xE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::function_930e5d42(&function_930e5d42);
}

/*
	Name: function_930e5d42
	Namespace: namespace_7d96b004
	Checksum: 0x3EA69EF8
	Offset: 0x110
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_930e5d42(localclientnum)
{
	if(self function_da43934d())
	{
		var_369be743 = self hasperk(localclientnum, #"hash_48d89fda4346187f");
		var_7c49d38b = self.var_369be743 !== var_369be743;
		if(var_7c49d38b)
		{
			self thread function_3e9077b(localclientnum);
		}
		self.var_369be743 = var_369be743;
	}
}

/*
	Name: function_dbd63244
	Namespace: namespace_7d96b004
	Checksum: 0x51B0FBEC
	Offset: 0x1B8
	Size: 0x132
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dbd63244()
{
	/#
		assert(isplayer(self));
	#/
	if(self function_da43934d())
	{
		return self geteye();
	}
	stance = self getstance();
	switch(stance)
	{
		case "prone":
		{
			return self.origin + vectorscale((0, 0, 1), 11);
		}
		case "crouch":
		{
			return self.origin + vectorscale((0, 0, 1), 40);
		}
		case "stand":
		{
			return self.origin + vectorscale((0, 0, 1), 60);
		}
		default:
		{
			return self.origin + vectorscale((0, 0, 1), 60);
		}
	}
}

/*
	Name: function_c9d3a835
	Namespace: namespace_7d96b004
	Checksum: 0x48682C0D
	Offset: 0x2F8
	Size: 0x1A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c9d3a835()
{
	return self.origin + vectorscale((0, 0, 1), 36);
}

/*
	Name: function_3e9077b
	Namespace: namespace_7d96b004
	Checksum: 0xD921A945
	Offset: 0x320
	Size: 0x626
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3e9077b(localclientnum)
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"shutdown", #"death");
	self notify("1cd9d4f64a9f9459");
	self endon("1cd9d4f64a9f9459");
	if(!self hasperk(localclientnum, #"hash_48d89fda4346187f"))
	{
		return;
	}
	var_81f254ba = cos(10);
	while(true)
	{
		var_7cefa3dc = undefined;
		players = getplayers(localclientnum);
		foreach(player in players)
		{
			if(!isdefined(player))
			{
				continue;
			}
			if(player == self)
			{
				continue;
			}
			if(!isalive(player))
			{
				continue;
			}
			if(!player util::isenemyteam(self.team))
			{
				continue;
			}
			if(isdefined(player function_bee2bbc7()) && player function_bee2bbc7())
			{
				continue;
			}
			if(!(isdefined(player isplayerads()) && player isplayerads()))
			{
				continue;
			}
			player_eye_pos = player function_dbd63244();
			var_2cb75b52 = self function_c9d3a835();
			to_self = var_2cb75b52 - player_eye_pos;
			if(lengthsquared(to_self) > 21600 * 21600)
			{
				continue;
			}
			player_angles = player getplayerangles();
			player_forward = anglestoforward(player_angles);
			var_e1a2a16a = vectornormalize(to_self);
			if(vectordot(player_forward, var_e1a2a16a) < var_81f254ba)
			{
				continue;
			}
			var_9901d38a = [];
			if(!isdefined(var_9901d38a))
			{
				var_9901d38a = [];
			}
			else if(!isarray(var_9901d38a))
			{
				var_9901d38a = array(var_9901d38a);
			}
			var_9901d38a[var_9901d38a.size] = self.origin + vectorscale((0, 0, 1), 11);
			if(!isdefined(var_9901d38a))
			{
				var_9901d38a = [];
			}
			else if(!isarray(var_9901d38a))
			{
				var_9901d38a = array(var_9901d38a);
			}
			var_9901d38a[var_9901d38a.size] = self.origin + vectorscale((0, 0, 1), 40);
			if(!isdefined(var_9901d38a))
			{
				var_9901d38a = [];
			}
			else if(!isarray(var_9901d38a))
			{
				var_9901d38a = array(var_9901d38a);
			}
			var_9901d38a[var_9901d38a.size] = self.origin + vectorscale((0, 0, 1), 60);
			los = 0;
			foreach(test_point in var_9901d38a)
			{
				trace_dist = length(to_self) + 100;
				trace_end = test_point + (vectorscale(player_forward, trace_dist * -1));
				trace = bullettrace(test_point, trace_end, 1, self);
				if(trace[#"fraction"] < 1 && trace[#"entity"] === player)
				{
					los = 1;
					break;
				}
			}
			if(los)
			{
				var_7cefa3dc = #"hash_56f62705c6a2bcb6";
				break;
			}
			waitframe(1);
		}
		if(isdefined(var_7cefa3dc) && isdefined(player))
		{
			var_2b836fea = player playsound(localclientnum, var_7cefa3dc);
			while(soundplaying(var_2b836fea))
			{
				waitframe(1);
			}
			wait(randomfloat(1));
		}
		waitframe(1);
	}
}

