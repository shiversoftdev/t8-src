// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_bgb_alchemical_antithesis;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0x1E88FBEA
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_alchemical_antithesis", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0xC3F874D4
	Offset: 0xF8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_alchemical_antithesis", "activated", 1, undefined, undefined, &validation, &activation);
	bgb::function_57eb02e(#"zm_bgb_alchemical_antithesis");
	bgb::function_c2721e81(#"zm_bgb_alchemical_antithesis", &add_to_player_score_override, 0);
}

/*
	Name: validation
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0xDDB877DD
	Offset: 0x1C8
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(level.var_375482b5) && level.var_375482b5)
	{
		return 0;
	}
	return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

/*
	Name: activation
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0x478E1D4C
	Offset: 0x228
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self.ready_for_score_events = 0;
	self bgb::run_timer(60);
	self.ready_for_score_events = 1;
}

/*
	Name: add_to_player_score_override
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0x84C21AC1
	Offset: 0x268
	Size: 0x1E6
	Parameters: 3
	Flags: Linked
*/
function add_to_player_score_override(points, str_awarded_by, zm_scr_spawner_location_distance)
{
	if(!(isdefined(self.bgb_active) && self.bgb_active))
	{
		return points;
	}
	var_f32fbbf5 = int(points / 7.5);
	w_current = self getcurrentweapon();
	if(zm_loadout::is_offhand_weapon(w_current))
	{
		return points;
	}
	if(self zm_utility::is_drinking())
	{
		return points;
	}
	if(w_current == level.weaponrevivetool)
	{
		return points;
	}
	if(w_current.iscliponly)
	{
		return points;
	}
	var_67a898af = self getweaponammostock(w_current);
	var_67a898af = var_67a898af + var_f32fbbf5;
	if(self hasperk(#"specialty_extraammo"))
	{
		var_6ec34556 = w_current.maxammo;
	}
	else
	{
		var_6ec34556 = w_current.startammo;
	}
	if(w_current.isdualwield)
	{
		var_6ec34556 = var_6ec34556 * 2;
	}
	var_67a898af = math::clamp(var_67a898af, 0, var_6ec34556);
	self setweaponammostock(w_current, var_67a898af);
	self thread function_ec301a0d();
	return 0;
}

/*
	Name: function_ec301a0d
	Namespace: zm_bgb_alchemical_antithesis
	Checksum: 0x4596B7D3
	Offset: 0x458
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_ec301a0d()
{
	if(!isdefined(self.var_8f145772))
	{
		self.var_8f145772 = 0;
	}
	if(!self.var_8f145772)
	{
		self.var_8f145772 = 1;
		self playsoundtoplayer(#"zmb_bgb_alchemical_ammoget", self);
		wait(0.5);
		if(isdefined(self))
		{
			self.var_8f145772 = 0;
		}
	}
}

