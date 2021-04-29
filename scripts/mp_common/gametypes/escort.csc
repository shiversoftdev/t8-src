// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;

#namespace escort;

/*
	Name: main
	Namespace: escort
	Checksum: 0x1AA97CE2
	Offset: 0x158
	Size: 0xE4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("actor", "escort_robot_burn", 6000, 1, "int", &robot_burn, 0, 0);
	clientfield::register("worlduimodel", "Escort.robotProgress", 6000, 7, "float", undefined, 0, 0);
	clientfield::register("worlduimodel", "Escort.robotMoving", 6000, 1, "int", undefined, 0, 0);
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: on_localclient_connect
	Namespace: escort
	Checksum: 0xF56CE78D
	Offset: 0x248
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function on_localclient_connect(localclientnum)
{
	var_e73f171e = getuimodelforcontroller(localclientnum);
	setuimodelvalue(createuimodel(var_e73f171e, "Escort.robotIsEnemy"), 0);
	setuimodelvalue(createuimodel(var_e73f171e, "Escort.robotRebooting"), 0);
	level wait_team_changed(localclientnum);
}

/*
	Name: robot_burn
	Namespace: escort
	Checksum: 0x55098D8D
	Offset: 0x2F8
	Size: 0xB4
	Parameters: 7
	Flags: None
*/
function robot_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self endon(#"death");
		self util::waittill_dobj(localclientnum);
		fxhandles = playtagfxset(localclientnum, "escort_robot_burn", self);
		self thread watch_fx_shutdown(localclientnum, fxhandles);
	}
}

/*
	Name: watch_fx_shutdown
	Namespace: escort
	Checksum: 0x9EE97ED4
	Offset: 0x3B8
	Size: 0x90
	Parameters: 2
	Flags: None
*/
function watch_fx_shutdown(localclientnum, fxhandles)
{
	wait(3);
	foreach(fx in fxhandles)
	{
		stopfx(localclientnum, fx);
	}
}

/*
	Name: wait_team_changed
	Namespace: escort
	Checksum: 0xEEC5B33B
	Offset: 0x450
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function wait_team_changed(localclientnum)
{
	while(true)
	{
		level waittill(#"team_changed");
		if(!isdefined(level.escortrobots))
		{
			continue;
		}
		foreach(robot in level.escortrobots)
		{
			if(isdefined(robot))
			{
				robot thread update_robot_team(localclientnum);
			}
		}
	}
}

/*
	Name: update_robot_team
	Namespace: escort
	Checksum: 0xAF332EF7
	Offset: 0x528
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function update_robot_team(localclientnum)
{
	localplayerteam = function_73f4b33(localclientnum);
	if(shoutcaster::is_shoutcaster(localclientnum))
	{
		friend = self shoutcaster::is_friendly(localclientnum);
	}
	else
	{
		friend = self.team == localplayerteam;
	}
	if(friend)
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
	}
	else
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 1);
	}
	self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
	localplayer = function_5c10bd79(localclientnum);
	localplayer duplicate_render::update_dr_filters(localclientnum);
}

