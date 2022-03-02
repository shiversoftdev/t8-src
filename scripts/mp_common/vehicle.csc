// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace vehicle;

/*
	Name: function_89f2df9
	Namespace: vehicle
	Checksum: 0x250A5570
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"vehicle", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: vehicle
	Checksum: 0x2A666064
	Offset: 0xC0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}
	level.vehicles_inited = 1;
}

/*
	Name: vehicle_rumble
	Namespace: vehicle
	Checksum: 0xABAF1B7
	Offset: 0x100
	Size: 0x378
	Parameters: 1
	Flags: Linked
*/
function vehicle_rumble(localclientnum)
{
	self endon(#"death");
	if(!isdefined(level.vehicle_rumble))
	{
		return;
	}
	type = self.vehicletype;
	if(!isdefined(level.vehicle_rumble[type]))
	{
		return;
	}
	rumblestruct = level.vehicle_rumble[type];
	height = rumblestruct.radius * 2;
	zoffset = -1 * rumblestruct.radius;
	if(!isdefined(self.rumbleon))
	{
		self.rumbleon = 1;
	}
	if(isdefined(rumblestruct.scale))
	{
		self.rumble_scale = rumblestruct.scale;
	}
	else
	{
		self.rumble_scale = 0.15;
	}
	if(isdefined(rumblestruct.duration))
	{
		self.rumble_duration = rumblestruct.duration;
	}
	else
	{
		self.rumble_duration = 4.5;
	}
	if(isdefined(rumblestruct.radius))
	{
		self.rumble_radius = rumblestruct.radius;
	}
	else
	{
		self.rumble_radius = 600;
	}
	if(isdefined(rumblestruct.basetime))
	{
		self.rumble_basetime = rumblestruct.basetime;
	}
	else
	{
		self.rumble_basetime = 1;
	}
	if(isdefined(rumblestruct.randomaditionaltime))
	{
		self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
	}
	else
	{
		self.rumble_randomaditionaltime = 1;
	}
	self.player_touching = 0;
	radius_squared = rumblestruct.radius * rumblestruct.radius;
	while(true)
	{
		if(distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() < 35)
		{
			wait(0.2);
			continue;
		}
		if(isdefined(self.rumbleon) && !self.rumbleon)
		{
			wait(0.2);
			continue;
		}
		self playrumblelooponentity(localclientnum, level.vehicle_rumble[type].rumble);
		while(distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 5)
		{
			wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
		}
		self stoprumble(localclientnum, level.vehicle_rumble[type].rumble);
	}
}

/*
	Name: vehicle_variants
	Namespace: vehicle
	Checksum: 0x4C7BFBC0
	Offset: 0x480
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function vehicle_variants(localclientnum)
{
}

