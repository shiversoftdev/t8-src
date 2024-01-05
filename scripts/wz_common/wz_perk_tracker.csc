// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace wz_perk_tracker;

/*
	Name: __init__system__
	Namespace: wz_perk_tracker
	Checksum: 0xB5066FC9
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_perk_tracker", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_perk_tracker
	Checksum: 0xA3AA220B
	Offset: 0x110
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(isdefined(getgametypesetting(#"hash_1d02e28ba907a343")) && getgametypesetting(#"hash_1d02e28ba907a343"))
	{
		return;
	}
	callback::on_localclient_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: wz_perk_tracker
	Checksum: 0x4762EE26
	Offset: 0x190
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function on_player_connect(localclientnum)
{
	level thread tracker(localclientnum);
}

/*
	Name: tracker
	Namespace: wz_perk_tracker
	Checksum: 0x99E22E6A
	Offset: 0x1C0
	Size: 0x1FA
	Parameters: 1
	Flags: Linked
*/
function tracker(localclientnum)
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
	Namespace: wz_perk_tracker
	Checksum: 0x4A38EFEC
	Offset: 0x3C8
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function gettrackerfxposition(localclientnum)
{
	positionandrotation = undefined;
	offset = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
	dist2 = 1024;
	if(isdefined(self.trailrightfoot) && self.trailrightfoot)
	{
		fx = "player/fx_plyr_footstep_tracker_r_wz";
	}
	else
	{
		fx = "player/fx_plyr_footstep_tracker_l_wz";
	}
	pos = self.origin + offset;
	fwd = anglestoforward(self.angles);
	right = anglestoright(self.angles);
	up = anglestoup(self.angles);
	vel = self getvelocity();
	if(lengthsquared(vel) > 1)
	{
		up = vectorcross(vel, right);
		if(lengthsquared(up) < 0.0001)
		{
			up = vectorcross(fwd, vel);
		}
		fwd = vel;
	}
	if(distancesquared(self.tracker_last_pos, pos) > dist2)
	{
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
	return positionandrotation;
}

/*
	Name: tracker_playfx
	Namespace: wz_perk_tracker
	Checksum: 0x2EF12D9
	Offset: 0x640
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function tracker_playfx(localclientnum, positionandrotationstruct)
{
	handle = playfx(localclientnum, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
}

