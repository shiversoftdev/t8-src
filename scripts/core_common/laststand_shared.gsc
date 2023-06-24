// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_243ea03c7a285692;
#using scripts\core_common\util_shared.gsc;

#namespace laststand;

/*
	Name: player_is_in_laststand
	Namespace: laststand
	Checksum: 0xD3BA837
	Offset: 0x78
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function player_is_in_laststand()
{
	return isdefined(self.laststand) && self.laststand;
}

/*
	Name: player_num_in_laststand
	Namespace: laststand
	Checksum: 0xE5694F8C
	Offset: 0x98
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function player_num_in_laststand()
{
	num = 0;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(players[i] player_is_in_laststand())
		{
			num++;
		}
	}
	return num;
}

/*
	Name: player_all_players_in_laststand
	Namespace: laststand
	Checksum: 0xE288864F
	Offset: 0x120
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function player_all_players_in_laststand()
{
	return player_num_in_laststand() == getplayers().size;
}

/*
	Name: player_any_player_in_laststand
	Namespace: laststand
	Checksum: 0xCE93723E
	Offset: 0x150
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function player_any_player_in_laststand()
{
	return player_num_in_laststand() > 0;
}

/*
	Name: is_facing
	Namespace: laststand
	Checksum: 0x164BA657
	Offset: 0x170
	Size: 0x130
	Parameters: 2
	Flags: Linked
*/
function is_facing(facee, requireddot = 0.9)
{
	orientation = self getplayerangles();
	forwardvec = anglestoforward(orientation);
	forwardvec2d = (forwardvec[0], forwardvec[1], 0);
	unitforwardvec2d = vectornormalize(forwardvec2d);
	tofaceevec = facee.origin - self.origin;
	tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
	unittofaceevec2d = vectornormalize(tofaceevec2d);
	dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
	return dotproduct > requireddot;
}

/*
	Name: revive_hud_create
	Namespace: laststand
	Checksum: 0x7FD113B2
	Offset: 0x2A8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function revive_hud_create()
{
	/#
		assert(isdefined(level.revive_hud));
	#/
	if(!level.revive_hud revive_hud::is_open(self))
	{
		level.revive_hud revive_hud::open(self);
		waitframe(1);
		if(isdefined(self))
		{
			level.revive_hud revive_hud::set_fadeTime(self, 0);
		}
	}
}

/*
	Name: revive_hud_show_n_fade
	Namespace: laststand
	Checksum: 0xCDD2FE90
	Offset: 0x348
	Size: 0x13C
	Parameters: 3
	Flags: Linked
*/
function revive_hud_show_n_fade(text, time, player = undefined)
{
	if(!(isdefined(level.var_dc60105c) && level.var_dc60105c) && isdefined(level.revive_hud) && level.revive_hud revive_hud::is_open(self))
	{
		level.revive_hud revive_hud::set_fadeTime(self, 0);
		util::wait_network_frame();
		if(!isdefined(self))
		{
			return;
		}
		level.revive_hud revive_hud::set_text(self, text);
		if(isdefined(player))
		{
			level.revive_hud revive_hud::set_clientnum(self, player getentitynumber());
		}
		level.revive_hud revive_hud::set_fadeTime(self, int(time * 10));
	}
}

/*
	Name: drawcylinder
	Namespace: laststand
	Checksum: 0xC54311B4
	Offset: 0x490
	Size: 0x23E
	Parameters: 3
	Flags: None
*/
function drawcylinder(pos, rad, height)
{
	/#
		currad = rad;
		curheight = height;
		for(r = 0; r < 20; r++)
		{
			theta = (r / 20) * 360;
			theta2 = ((r + 1) / 20) * 360;
			line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
			line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
			line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
		}
	#/
}

/*
	Name: function_d4c9e1b5
	Namespace: laststand
	Checksum: 0x65CF9EDE
	Offset: 0x6D8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_d4c9e1b5()
{
	self endon(#"player_revived", #"player_suicide", #"bled_out");
	self waittill(#"disconnect");
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
	}
}

