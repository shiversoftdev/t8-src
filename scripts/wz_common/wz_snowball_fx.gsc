// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wz_snowball_fx;

/*
	Name: __init__system__
	Namespace: wz_snowball_fx
	Checksum: 0x64C4FBD0
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_snowball_fx", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_snowball_fx
	Checksum: 0x54CFEC56
	Offset: 0x118
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "player_hit_freezing_snowball", 9000, 1, "int");
	clientfield::register("toplayer", "player_hit_snowball_direction", 9000, 4, "int");
	callback::on_player_damage(&function_c9509a9c);
}

/*
	Name: function_c9509a9c
	Namespace: wz_snowball_fx
	Checksum: 0x732C6572
	Offset: 0x1A8
	Size: 0x444
	Parameters: 1
	Flags: Linked
*/
function function_c9509a9c(params)
{
	if(isalive(self) && isplayer(self))
	{
		if(params.weapon.name === #"snowball")
		{
			var_feafe576 = 0;
			var_cb01806c = 0;
			bleft = 0;
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
				bleft = 1;
				var_9ed2938d = 0;
			}
			if(var_4e1c6c81 && var_9ed2938d)
			{
				self clientfield::set_to_player("player_hit_snowball_direction", 1);
			}
			else
			{
				if(var_4e1c6c81 && bleft)
				{
					self clientfield::set_to_player("player_hit_snowball_direction", 2);
				}
				else
				{
					if(var_4e1c6c81 && bright)
					{
						self clientfield::set_to_player("player_hit_snowball_direction", 3);
					}
					else
					{
						if(var_cb01806c && var_9ed2938d)
						{
							self clientfield::set_to_player("player_hit_snowball_direction", 5);
						}
						else
						{
							if(var_feafe576 && var_9ed2938d)
							{
								self clientfield::set_to_player("player_hit_snowball_direction", 4);
							}
							else
							{
								if(var_feafe576 && bleft)
								{
									self clientfield::set_to_player("player_hit_snowball_direction", 6);
								}
								else
								{
									if(var_feafe576 && bright)
									{
										self clientfield::set_to_player("player_hit_snowball_direction", 8);
									}
									else
									{
										if(var_cb01806c && bleft)
										{
											self clientfield::set_to_player("player_hit_snowball_direction", 9);
										}
										else if(var_cb01806c && bright)
										{
											self clientfield::set_to_player("player_hit_snowball_direction", 10);
										}
									}
								}
							}
						}
					}
				}
			}
			self thread function_4df181ef();
		}
	}
}

/*
	Name: function_4df181ef
	Namespace: wz_snowball_fx
	Checksum: 0x31884B35
	Offset: 0x5F8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_4df181ef()
{
	self endoncallback(&function_8407e8ae, #"death", #"game_ended");
	self clientfield::set_to_player("player_hit_freezing_snowball", 1);
	wait(2);
	self clientfield::set_to_player("player_hit_freezing_snowball", 0);
}

/*
	Name: function_8407e8ae
	Namespace: wz_snowball_fx
	Checksum: 0x72CF504C
	Offset: 0x688
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_8407e8ae(notifyhash)
{
	self clientfield::set_to_player("player_hit_freezing_snowball", 0);
}

