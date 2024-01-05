// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp\mp_firingrange2_scripted.csc;
#using scripts\mp\mp_firingrange2_sound.csc;
#using scripts\mp\mp_firingrange2_fx.csc;
#using scripts\mp_common\util.csc;
#using scripts\mp_common\load.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;

#namespace mp_firingrange2;

/*
	Name: main
	Namespace: mp_firingrange2
	Checksum: 0x4127706F
	Offset: 0x138
	Size: 0x17C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setsaveddvar(#"enable_global_wind", 1);
	setsaveddvar(#"wind_global_vector", "88 0 0");
	setsaveddvar(#"wind_global_low_altitude", 0);
	setsaveddvar(#"wind_global_hi_altitude", 10000);
	setsaveddvar(#"wind_global_low_strength_percent", 100);
	level.var_bbb8810e = #"ui_cam_draft_common";
	level.var_482af62e = #"hash_12263e5d70551bf9";
	mp_firingrange2_fx::main();
	mp_firingrange2_sound::main();
	load::main();
	level.domflagbasefxoverride = &dom_flag_base_fx_override;
	level.domflagcapfxoverride = &dom_flag_cap_fx_override;
	util::waitforclient(0);
}

/*
	Name: dom_flag_base_fx_override
	Namespace: mp_firingrange2
	Checksum: 0x64A5929D
	Offset: 0x2C0
	Size: 0xF2
	Parameters: 2
	Flags: Linked
*/
function dom_flag_base_fx_override(flag, team)
{
	switch(flag.name)
	{
		case "a":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_marker_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_marker_team_r120";
			}
			break;
		}
		case "b":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_marker_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_marker_team_r120";
			}
			break;
		}
		case "c":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_marker_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_marker_team_r120";
			}
			break;
		}
	}
}

/*
	Name: dom_flag_cap_fx_override
	Namespace: mp_firingrange2
	Checksum: 0xDD52AF52
	Offset: 0x3C0
	Size: 0xF2
	Parameters: 2
	Flags: Linked
*/
function dom_flag_cap_fx_override(flag, team)
{
	switch(flag.name)
	{
		case "a":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_cap_indicator_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_cap_indicator_team_r120";
			}
			break;
		}
		case "b":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_cap_indicator_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_cap_indicator_team_r120";
			}
			break;
		}
		case "c":
		{
			if(team == #"neutral")
			{
				return "ui/fx_dom_cap_indicator_neutral_r120";
			}
			else
			{
				return "ui/fx_dom_cap_indicator_team_r120";
			}
			break;
		}
	}
}

