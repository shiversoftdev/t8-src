// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace empgrenade;

/*
	Name: function_89f2df9
	Namespace: empgrenade
	Checksum: 0x7F8D766A
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"empgrenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: empgrenade
	Checksum: 0x624EAC3F
	Offset: 0x150
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("toplayer", "empd", 1, 1, "int", &onempchanged, 0, 1);
	clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int", &onempmonitordistancechanged, 0, 0);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: onempchanged
	Namespace: empgrenade
	Checksum: 0x8C1DE97C
	Offset: 0x210
	Size: 0xD4
	Parameters: 7
	Flags: None
*/
function onempchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	localplayer = function_5c10bd79(localclientnum);
	if(newval == 1)
	{
		self startempeffects(localplayer);
	}
	else
	{
		already_distance_monitored = localplayer clientfield::get_to_player("empd_monitor_distance") == 1;
		if(!already_distance_monitored)
		{
			self stopempeffects(localplayer, oldval);
		}
	}
}

/*
	Name: startempeffects
	Namespace: empgrenade
	Checksum: 0xFBACF45
	Offset: 0x2F0
	Size: 0xBC
	Parameters: 2
	Flags: None
*/
function startempeffects(localplayer, bwastimejump = 0)
{
	filter::init_filter_tactical(localplayer);
	filter::enable_filter_tactical(localplayer, 2);
	filter::set_filter_tactical_amount(localplayer, 2, 1);
	if(!bwastimejump)
	{
		playsound(0, #"mpl_plr_emp_activate", (0, 0, 0));
	}
	audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

/*
	Name: stopempeffects
	Namespace: empgrenade
	Checksum: 0xC1A2CC49
	Offset: 0x3B8
	Size: 0xB4
	Parameters: 3
	Flags: None
*/
function stopempeffects(localplayer, oldval, bwastimejump = 0)
{
	filter::init_filter_tactical(localplayer);
	filter::disable_filter_tactical(localplayer, 2);
	if(oldval != 0 && !bwastimejump)
	{
		playsound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
	}
	audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

/*
	Name: on_player_spawned
	Namespace: empgrenade
	Checksum: 0x58616DAA
	Offset: 0x478
	Size: 0x120
	Parameters: 1
	Flags: None
*/
function on_player_spawned(localclientnum)
{
	self endon(#"disconnect");
	localplayer = function_5c10bd79(localclientnum);
	if(localplayer != self)
	{
		return;
	}
	curval = localplayer clientfield::get_to_player("empd_monitor_distance");
	inkillcam = function_1cbf351b(localclientnum);
	if(curval > 0 && localplayer isempjammed())
	{
		startempeffects(localplayer, inkillcam);
		localplayer monitordistance(localclientnum);
	}
	else
	{
		stopempeffects(localplayer, 0, 1);
		localplayer notify(#"end_emp_monitor_distance");
	}
}

/*
	Name: onempmonitordistancechanged
	Namespace: empgrenade
	Checksum: 0x3AE1F96A
	Offset: 0x5A0
	Size: 0xD0
	Parameters: 7
	Flags: None
*/
function onempmonitordistancechanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	localplayer = function_5c10bd79(localclientnum);
	if(newval == 1)
	{
		startempeffects(localplayer, bwastimejump);
		localplayer monitordistance(localclientnum);
	}
	else
	{
		stopempeffects(localplayer, oldval, bwastimejump);
		localplayer notify(#"end_emp_monitor_distance");
	}
}

/*
	Name: monitordistance
	Namespace: empgrenade
	Checksum: 0xA6873B0E
	Offset: 0x678
	Size: 0x338
	Parameters: 1
	Flags: None
*/
function monitordistance(localclientnum)
{
	localplayer = self;
	localplayer endon(#"death");
	localplayer endon(#"end_emp_monitor_distance");
	localplayer endon(#"team_changed");
	if(localplayer isempjammed() == 0)
	{
		return;
	}
	distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
	new_distance = 0;
	max_static_value = getdvarfloat(#"ks_emp_fullscreen_maxstaticvalue", 0);
	min_static_value = getdvarfloat(#"ks_emp_fullscreen_minstaticvalue", 0);
	min_radius_max_static = getdvarfloat(#"ks_emp_fullscreen_minradiusmaxstatic", 0);
	max_radius_min_static = getdvarfloat(#"ks_emp_fullscreen_maxradiusminstatic", 0);
	if(isdefined(distance_to_closest_enemy_emp_ui_model))
	{
		while(true)
		{
			/#
				max_static_value = getdvarfloat(#"ks_emp_fullscreen_maxstaticvalue", 0);
				min_static_value = getdvarfloat(#"ks_emp_fullscreen_minstaticvalue", 0);
				min_radius_max_static = getdvarfloat(#"ks_emp_fullscreen_minradiusmaxstatic", 0);
				max_radius_min_static = getdvarfloat(#"ks_emp_fullscreen_maxradiusminstatic", 0);
			#/
			new_distance = getuimodelvalue(distance_to_closest_enemy_emp_ui_model);
			range = max_radius_min_static - min_radius_max_static;
			current_static_value = max_static_value - (range <= 0 ? max_static_value : new_distance - min_radius_max_static / range);
			current_static_value = math::clamp(current_static_value, min_static_value, max_static_value);
			emp_grenaded = localplayer clientfield::get_to_player("empd") == 1;
			if(emp_grenaded && current_static_value < 1)
			{
				current_static_value = 1;
			}
			filter::set_filter_tactical_amount(localplayer, 2, current_static_value);
			wait(0.1);
		}
	}
}

