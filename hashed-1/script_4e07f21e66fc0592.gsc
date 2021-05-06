// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_f8d18bff;

/*
	Name: function_89f2df9
	Namespace: namespace_f8d18bff
	Checksum: 0x7140F9D
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_572ed1def3a8dbda", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_f8d18bff
	Checksum: 0x26A8C6C1
	Offset: 0x120
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "player_hit_water_balloon", 16000, 1, "int");
	clientfield::register("toplayer", "player_hit_water_balloon_direction", 16000, 4, "int");
	callback::on_player_damage(&function_c9509a9c);
}

/*
	Name: function_c9509a9c
	Namespace: namespace_f8d18bff
	Checksum: 0x9D509BBF
	Offset: 0x1B0
	Size: 0x444
	Parameters: 1
	Flags: Linked
*/
function function_c9509a9c(params)
{
	if(isalive(self) && isplayer(self))
	{
		if(params.weapon.name === #"hash_1888d1367d69b3a7")
		{
			var_feafe576 = 0;
			var_cb01806c = 0;
			var_797a4fe0 = 0;
			bright = 0;
			var_4e1c6c81 = 1;
			var_9ed2938d = 1;
			attacker = params.eattacker;
			height_diff = attacker.origin[2] - self.origin[2];
			if(height_diff < -16)
			{
				var_feafe576 = 1;
				var_4e1c6c81 = 0;
			}
			if(height_diff > 16)
			{
				var_cb01806c = 1;
				var_4e1c6c81 = 0;
			}
			var_1f579e1d = attacker.origin - self.origin;
			var_1f579e1d = (var_1f579e1d[0], var_1f579e1d[1], 0);
			vec_right = anglestoright(self.angles);
			vec_right = vectornormalize(vec_right);
			vec_right = (vec_right[0], vec_right[1], 0);
			var_1f579e1d = vectornormalize(var_1f579e1d);
			vec_dot = vectordot(var_1f579e1d, vec_right);
			if(vec_dot > 0.2)
			{
				bright = 1;
				var_9ed2938d = 0;
			}
			else if(vec_dot < -0.2)
			{
				var_797a4fe0 = 1;
				var_9ed2938d = 0;
			}
			if(var_4e1c6c81 && var_9ed2938d)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 1);
			}
			else if(var_4e1c6c81 && var_797a4fe0)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 2);
			}
			else if(var_4e1c6c81 && bright)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 3);
			}
			else if(var_cb01806c && var_9ed2938d)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 5);
			}
			else if(var_feafe576 && var_9ed2938d)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 4);
			}
			else if(var_feafe576 && var_797a4fe0)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 6);
			}
			else if(var_feafe576 && bright)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 8);
			}
			else if(var_cb01806c && var_797a4fe0)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 9);
			}
			else if(var_cb01806c && bright)
			{
				self clientfield::set_to_player("player_hit_water_balloon_direction", 10);
			}
			self thread function_4df181ef();
		}
	}
}

/*
	Name: function_4df181ef
	Namespace: namespace_f8d18bff
	Checksum: 0xFF1DC699
	Offset: 0x600
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_4df181ef()
{
	self endon_callback(&function_a1805183, #"death", #"game_ended");
	self clientfield::set_to_player("player_hit_water_balloon", 1);
	wait(2);
	self clientfield::set_to_player("player_hit_water_balloon", 0);
}

/*
	Name: function_a1805183
	Namespace: namespace_f8d18bff
	Checksum: 0x7B32C206
	Offset: 0x690
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_a1805183(notifyhash)
{
	self clientfield::set_to_player("player_hit_water_balloon", 0);
}

