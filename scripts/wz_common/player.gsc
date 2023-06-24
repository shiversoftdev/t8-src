// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_supply_drop.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wz_player;

/*
	Name: __init__system__
	Namespace: wz_player
	Checksum: 0xC4FBE99D
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_player
	Checksum: 0x83B4B058
	Offset: 0xC8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: wz_player
	Checksum: 0x34345AF
	Offset: 0xF8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self callback::function_20263b9e(&function_20263b9e);
}

/*
	Name: function_20263b9e
	Namespace: wz_player
	Checksum: 0x4D69926E
	Offset: 0x128
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function function_20263b9e(params)
{
	grenade = params.projectile;
	weapon = params.weapon;
	switch(weapon.name)
	{
		case "flare_gun":
		{
			grenade function_4861487f(weapon, self);
			grenade thread function_cd8ee3c5();
			break;
		}
		case "hash_6f845f867b85855e":
		{
			grenade function_4861487f(weapon, self);
			grenade thread function_f3edce9a();
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_4861487f
	Namespace: wz_player
	Checksum: 0x5FAA724F
	Offset: 0x230
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_4861487f(weapon, player)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!self grenade_safe_to_throw(player, weapon))
	{
		self thread makegrenadedudanddestroy();
		return;
	}
}

/*
	Name: function_cd8ee3c5
	Namespace: wz_player
	Checksum: 0xFFE0FC7
	Offset: 0x290
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_cd8ee3c5()
{
	self endon(#"grenade_dud");
	waitresult = undefined;
	waitresult = self waittill(#"explode", #"death");
	if(waitresult._notify == #"explode")
	{
		trace = groundtrace(waitresult.position, waitresult.position + (vectorscale((0, 0, -1), 20000)), 0, self, 0);
		if(isdefined(trace[#"position"]) && trace[#"surfacetype"] != #"none")
		{
			org = trace[#"position"];
			item_supply_drop::drop_supply_drop(org, 1);
		}
	}
}

/*
	Name: function_f3edce9a
	Namespace: wz_player
	Checksum: 0x1EDA065E
	Offset: 0x3C0
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_f3edce9a()
{
	self endon(#"grenade_dud");
	waitresult = undefined;
	waitresult = self waittill(#"explode", #"death");
	if(waitresult._notify == #"explode")
	{
		position = (isdefined(waitresult.position) ? waitresult.position : waitresult.attacker.origin);
		trace = groundtrace(position, position + (vectorscale((0, 0, -1), 20000)), 0, self, 0);
		if(isdefined(trace[#"position"]) && trace[#"surfacetype"] != #"none")
		{
			org = trace[#"position"];
			vehicletypes = array(#"hash_660785b539889002", #"hash_54bf3cd56e8c5c4a", #"hash_6fdb3b0114439974", #"hash_327d1f9834b6b91e");
			item_supply_drop::drop_supply_drop(org, 1, 1, vehicletypes[randomint(vehicletypes.size)]);
		}
	}
}

/*
	Name: grenade_safe_to_throw
	Namespace: wz_player
	Checksum: 0xE49C317B
	Offset: 0x598
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function grenade_safe_to_throw(player, weapon)
{
	return true;
}

/*
	Name: makegrenadedudanddestroy
	Namespace: wz_player
	Checksum: 0x124A5FC8
	Offset: 0x5B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function makegrenadedudanddestroy()
{
	self endon(#"death");
	self notify(#"grenade_dud");
	self makegrenadedud();
	wait(3);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: debug_star
	Namespace: wz_player
	Checksum: 0xB5186428
	Offset: 0x628
	Size: 0x84
	Parameters: 3
	Flags: None
*/
function debug_star(origin, seconds, color)
{
	/#
		if(!isdefined(seconds))
		{
			seconds = 1;
		}
		if(!isdefined(color))
		{
			color = (1, 0, 0);
		}
		frames = int(20 * seconds);
		debugstar(origin, frames, color);
	#/
}

