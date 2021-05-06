// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_ffb86e0f;

/*
	Name: function_89f2df9
	Namespace: namespace_ffb86e0f
	Checksum: 0x9D018F60
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_b4777816c1a0582", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ffb86e0f
	Checksum: 0x368056D2
	Offset: 0x118
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"hash_1d02e28ba907a343")) && getgametypesetting(#"hash_1d02e28ba907a343")))
	{
		return;
	}
	callback::on_localclient_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: namespace_ffb86e0f
	Checksum: 0x248000A8
	Offset: 0x198
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function on_player_connect(localclientnum)
{
	level thread function_ad692418(localclientnum);
}

/*
	Name: function_ad692418
	Namespace: namespace_ffb86e0f
	Checksum: 0xCBEDD3AB
	Offset: 0x1C8
	Size: 0x1FA
	Parameters: 1
	Flags: Linked
*/
function function_ad692418(localclientnum)
{
	while(true)
	{
		wait(0.2);
		if(!function_5778f82(localclientnum, #"specialty_tracker"))
		{
			continue;
		}
		origin = getlocalclientpos(localclientnum);
		players = getplayers(localclientnum);
		players = arraysortclosest(players, origin, undefined, 1, 6000);
		tracked = 0;
		foreach(player in players)
		{
			if(tracked >= 10 || !isalive(player) || player function_83973173() || isdefined(getplayervehicle(player)))
			{
				player.tracker_last_pos = undefined;
				continue;
			}
			tracked++;
			if(!isdefined(player.tracker_last_pos))
			{
				player.tracker_last_pos = player.origin;
			}
			positionandrotationstruct = player gettrackerfxposition(localclientnum);
			if(isdefined(positionandrotationstruct))
			{
				player tracker_playfx(localclientnum, positionandrotationstruct);
			}
		}
		players = undefined;
	}
}

/*
	Name: gettrackerfxposition
	Namespace: namespace_ffb86e0f
	Checksum: 0x20C0C21C
	Offset: 0x3D0
	Size: 0x2EE
	Parameters: 1
	Flags: Linked
*/
function gettrackerfxposition(localclientnum)
{
	positionandrotation = undefined;
	player = self;
	offset = (0, 0, 1);
	dist2 = 1024;
	if(isdefined(self.trailrightfoot) && self.trailrightfoot)
	{
		fx = "player/fx8_plyr_footstep_tracker_blood_r";
	}
	else
	{
		fx = "player/fx8_plyr_footstep_tracker_blood_l";
	}
	pos = self.origin + offset;
	if(distancesquared(self.tracker_last_pos, pos) > dist2)
	{
		trace = physicstraceex(pos, pos + vectorscale((0, 0, -1), 10), (0, 0, 0), (0, 0, 0), self, 1);
		if(trace[#"fraction"] < 1)
		{
			up = trace[#"normal"];
			up = (0, 0, 0) - up;
			if(lengthsquared(up) <= 0)
			{
				return undefined;
			}
			fwd = anglestoforward(self.angles);
			vel = self getvelocity();
			if(lengthsquared(vel) > 1)
			{
				fwd = vel;
			}
			right = vectorcross(fwd, up);
			if(lengthsquared(right) <= 0)
			{
				return undefined;
			}
			fwd = vectorcross(up, right);
			pos = trace[#"position"] + trace[#"normal"];
			positionandrotation = spawnstruct();
			positionandrotation.fx = fx;
			positionandrotation.pos = pos;
			positionandrotation.fwd = fwd;
			positionandrotation.up = up;
			self.tracker_last_pos = self.origin;
			if(isdefined(self.trailrightfoot) && self.trailrightfoot)
			{
				self.trailrightfoot = 0;
			}
			else
			{
				self.trailrightfoot = 1;
			}
		}
	}
	return positionandrotation;
}

/*
	Name: tracker_playfx
	Namespace: namespace_ffb86e0f
	Checksum: 0x9844A29D
	Offset: 0x6C8
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function tracker_playfx(localclientnum, positionandrotationstruct)
{
	handle = playfx(localclientnum, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
}

