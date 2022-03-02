// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28a20e497bd69c36;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;

#namespace dom;

/*
	Name: main
	Namespace: dom
	Checksum: 0xB0D381FC
	Offset: 0x158
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	callback::on_localclient_connect(&on_localclient_connect);
	if(getgametypesetting(#"silentplant") != 0)
	{
		setsoundcontext("bomb_plant", "silent");
	}
	if(util::function_8570168d())
	{
		namespace_9096c917::init();
	}
}

/*
	Name: on_localclient_connect
	Namespace: dom
	Checksum: 0xB0D92246
	Offset: 0x200
	Size: 0x160
	Parameters: 1
	Flags: None
*/
function on_localclient_connect(localclientnum)
{
	self.domflags = [];
	while(!isdefined(level.domflags[#"a"]))
	{
		self.domflags[#"a"] = serverobjective_getobjective(localclientnum, "dom_a");
		self.domflags[#"b"] = serverobjective_getobjective(localclientnum, "dom_b");
		self.domflags[#"c"] = serverobjective_getobjective(localclientnum, "dom_c");
		waitframe(1);
	}
	foreach(key, flag_objective in self.domflags)
	{
		self thread monitor_flag_fx(localclientnum, flag_objective, key);
	}
}

/*
	Name: monitor_flag_fx
	Namespace: dom
	Checksum: 0xFCA1C5A5
	Offset: 0x368
	Size: 0x326
	Parameters: 3
	Flags: None
*/
function monitor_flag_fx(localclientnum, flag_objective, flag_name)
{
	if(!isdefined(flag_objective))
	{
		return;
	}
	flag = spawnstruct();
	flag.name = flag_name;
	flag.objectiveid = flag_objective;
	flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag_objective);
	flag.angles = (0, 0, 0);
	flag_entity = serverobjective_getobjectiveentity(localclientnum, flag_objective);
	if(isdefined(flag_entity))
	{
		flag.origin = flag_entity.origin;
		flag.angles = flag_entity.angles;
	}
	fx_name = get_base_fx(flag, #"neutral");
	play_base_fx(localclientnum, flag, fx_name, #"neutral");
	flag.last_progress = 0;
	while(true)
	{
		team = serverobjective_getobjectiveteam(localclientnum, flag_objective);
		if(team != flag.last_team)
		{
			flag update_base_fx(localclientnum, flag, team);
		}
		progress = serverobjective_getobjectiveprogress(localclientnum, flag_objective) > 0;
		if(progress != flag.last_progress)
		{
			var_76587cfe = team;
			if(var_76587cfe == #"neutral")
			{
				var_4e8c1813 = serverobjective_getobjectivegamemodeflags(localclientnum, flag_objective);
				if(var_4e8c1813 == 2)
				{
					var_76587cfe = (shoutcaster::is_shoutcaster(localclientnum) ? #"axis" : #"allies");
				}
				else if(var_4e8c1813 == 1)
				{
					var_76587cfe = (shoutcaster::is_shoutcaster(localclientnum) ? #"allies" : #"axis");
				}
			}
			else if(shoutcaster::is_shoutcaster(localclientnum))
			{
				var_76587cfe = util::get_other_team(var_76587cfe);
			}
			flag update_cap_fx(localclientnum, flag, var_76587cfe, progress);
		}
		waitframe(1);
	}
}

/*
	Name: play_base_fx
	Namespace: dom
	Checksum: 0xACE7956E
	Offset: 0x698
	Size: 0x10A
	Parameters: 4
	Flags: None
*/
function play_base_fx(localclientnum, flag, fx_name, team)
{
	if(isdefined(flag.base_fx))
	{
		stopfx(localclientnum, flag.base_fx);
	}
	up = anglestoup(flag.angles);
	forward = anglestoforward(flag.angles);
	flag.base_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
	setfxteam(localclientnum, flag.base_fx, team);
	flag.last_team = team;
}

/*
	Name: update_base_fx
	Namespace: dom
	Checksum: 0x81D55BBE
	Offset: 0x7B0
	Size: 0x17A
	Parameters: 3
	Flags: None
*/
function update_base_fx(localclientnum, flag, team)
{
	fx_name = get_base_fx(flag, team);
	if(shoutcaster::is_shoutcaster(localclientnum) && team != #"neutral")
	{
		fx_name = fx_name + (team == #"allies" ? "_shoutcaster_allies" : "_shoutcaster_axis");
	}
	if(team == #"neutral")
	{
		play_base_fx(localclientnum, flag, fx_name, team);
	}
	else
	{
		if(flag.last_team == #"neutral" || shoutcaster::is_shoutcaster(localclientnum))
		{
			play_base_fx(localclientnum, flag, fx_name, team);
		}
		else
		{
			setfxteam(localclientnum, flag.base_fx, team);
			flag.last_team = team;
		}
	}
}

/*
	Name: play_cap_fx
	Namespace: dom
	Checksum: 0xCD448A37
	Offset: 0x938
	Size: 0xFC
	Parameters: 4
	Flags: None
*/
function play_cap_fx(localclientnum, flag, fx_name, team)
{
	if(isdefined(flag.cap_fx))
	{
		killfx(localclientnum, flag.cap_fx);
	}
	up = anglestoup(flag.angles);
	forward = anglestoforward(flag.angles);
	flag.cap_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
	setfxteam(localclientnum, flag.cap_fx, team);
}

/*
	Name: update_cap_fx
	Namespace: dom
	Checksum: 0x987EA49C
	Offset: 0xA40
	Size: 0x12A
	Parameters: 4
	Flags: None
*/
function update_cap_fx(localclientnum, flag, team, progress)
{
	if(progress == 0)
	{
		if(isdefined(flag.cap_fx))
		{
			killfx(localclientnum, flag.cap_fx);
		}
		flag.last_progress = progress;
		return;
	}
	fx_name = get_cap_fx(flag, team);
	if(shoutcaster::is_shoutcaster(localclientnum) && team != #"neutral")
	{
		fx_name = fx_name + (team == #"allies" ? "_shoutcaster_allies" : "_shoutcaster_axis");
	}
	play_cap_fx(localclientnum, flag, fx_name, team);
	flag.last_progress = progress;
}

/*
	Name: get_base_fx
	Namespace: dom
	Checksum: 0xAF32F18E
	Offset: 0xB78
	Size: 0x7A
	Parameters: 2
	Flags: None
*/
function get_base_fx(flag, team)
{
	if(isdefined(level.domflagbasefxoverride))
	{
		fx = [[level.domflagbasefxoverride]](flag, team);
		if(isdefined(fx))
		{
			return fx;
		}
	}
	if(team == #"neutral")
	{
		return "ui/fx_dom_marker_neutral";
	}
	return "ui/fx_dom_marker_team";
}

/*
	Name: get_cap_fx
	Namespace: dom
	Checksum: 0xA9030DD4
	Offset: 0xC00
	Size: 0x7A
	Parameters: 2
	Flags: None
*/
function get_cap_fx(flag, team)
{
	if(isdefined(level.domflagcapfxoverride))
	{
		fx = [[level.domflagcapfxoverride]](flag, team);
		if(isdefined(fx))
		{
			return fx;
		}
	}
	if(team == #"neutral")
	{
		return "ui/fx_dom_cap_indicator_neutral";
	}
	return "ui/fx_dom_cap_indicator_team";
}

