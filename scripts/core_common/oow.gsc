// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\map.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace oob;

/*
	Name: __init__system__
	Namespace: oob
	Checksum: 0x617098BC
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_160d7214c7356e06", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: oob
	Checksum: 0x11C620ED
	Offset: 0x100
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_c0556c0 = {#height_max:2147483647, #height_min:-2147483647};
	callback::on_game_playing(&on_game_playing);
}

/*
	Name: on_game_playing
	Namespace: oob
	Checksum: 0x43B466D5
	Offset: 0x168
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function on_game_playing()
{
	var_65792f8b = map::get_script_bundle();
	if(isdefined(var_65792f8b))
	{
		if(!isdefined(var_65792f8b.var_aa91547b))
		{
			var_65792f8b.var_aa91547b = 0;
		}
		if(!isdefined(var_65792f8b.var_eac026ad))
		{
			var_65792f8b.var_eac026ad = 0;
		}
		if(var_65792f8b.var_aa91547b != 0 || var_65792f8b.var_eac026ad != 0)
		{
			level.var_c0556c0.height_min = (isdefined(var_65792f8b.var_aa91547b) ? var_65792f8b.var_aa91547b : 0);
			level.var_c0556c0.height_max = (isdefined(var_65792f8b.var_eac026ad) ? var_65792f8b.var_eac026ad : 0);
			/#
				assert(level.var_c0556c0.height_min <= level.var_c0556c0.height_max);
			#/
			if(!level.var_c0556c0.height_min <= level.var_c0556c0.height_max)
			{
				return;
			}
		}
	}
	level thread function_e8f5803d();
}

/*
	Name: function_e8f5803d
	Namespace: oob
	Checksum: 0xAAB2194B
	Offset: 0x2E8
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_e8f5803d()
{
	while(true)
	{
		wait(5);
		foreach(team, _ in level.teams)
		{
			foreach(player in level.aliveplayers[team])
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(player function_eb7eb3d4())
				{
					kill_entity(player);
				}
			}
		}
	}
}

/*
	Name: function_eb7eb3d4
	Namespace: oob
	Checksum: 0x98CB7091
	Offset: 0x408
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_eb7eb3d4()
{
	if(!isdefined(self))
	{
		return false;
	}
	/#
		if(self isinmovemode("", ""))
		{
			return false;
		}
	#/
	height = self.origin[2];
	if(level.var_c0556c0.height_min > height || level.var_c0556c0.height_max < height)
	{
		return true;
	}
	return false;
}

/*
	Name: kill_entity
	Namespace: oob
	Checksum: 0xDB9D8081
	Offset: 0x4B0
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function kill_entity(entity)
{
	if(isplayer(entity) && entity isinvehicle())
	{
		vehicle = entity getvehicleoccupied();
		occupants = vehicle getvehoccupants();
		foreach(occupant in occupants)
		{
			occupant unlink();
		}
		if(!(isdefined(vehicle.allowdeath) && !vehicle.allowdeath))
		{
			vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
		}
	}
	entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);
	if(isplayer(entity))
	{
		entity suicide();
	}
}

