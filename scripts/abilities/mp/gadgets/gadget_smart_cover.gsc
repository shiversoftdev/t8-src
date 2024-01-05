// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\util.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\abilities\gadgets\gadget_smart_cover.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace smart_cover;

/*
	Name: __init__system__
	Namespace: smart_cover
	Checksum: 0x7FD5CC09
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"smart_cover", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: smart_cover
	Checksum: 0x7F8B71A7
	Offset: 0xF8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	function_649f8cbe(&onsmartcoverplaced);
	function_a9427b5c(&function_a430cceb);
	level.var_b57c1895 = &function_9a2b3318;
}

/*
	Name: onsmartcoverplaced
	Namespace: smart_cover
	Checksum: 0x94ECFB2F
	Offset: 0x170
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function onsmartcoverplaced(smartcover)
{
	self battlechatter::function_bd715920(smartcover.weapon, undefined, smartcover.origin, smartcover);
	self callback::callback(#"hash_70eeb7d813f149b2", {#cover:smartcover.smartcover, #owner:self});
}

/*
	Name: function_a430cceb
	Namespace: smart_cover
	Checksum: 0xE1301A9
	Offset: 0x208
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_a430cceb(attacker, weapon)
{
	concertinawire = self;
	if(isdefined(level.figure_out_attacker))
	{
		attacker = self [[level.figure_out_attacker]](attacker);
	}
	if(isdefined(attacker) && isplayer(attacker) && concertinawire.owner !== attacker && isdefined(weapon))
	{
		attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
	}
	self callback::callback(#"hash_15858698313c5f32", {#cover:self, #owner:self.owner});
}

/*
	Name: function_9a2b3318
	Namespace: smart_cover
	Checksum: 0x9E3AAE50
	Offset: 0x318
	Size: 0x15E
	Parameters: 3
	Flags: Linked
*/
function function_9a2b3318(origin, angles, player)
{
	if(isdefined(level.var_5101157d.bundle.var_bc78f60e))
	{
		length2 = (level.var_5101157d.bundle.var_bc78f60e + level.var_5101157d.bundle.maxwidth) * (level.var_5101157d.bundle.var_bc78f60e + level.var_5101157d.bundle.maxwidth);
		foreach(protectedzone in level.var_5101157d.var_d6a27a84)
		{
			if(isdefined(protectedzone))
			{
				dist2 = distance2dsquared(origin, protectedzone.origin);
				if(dist2 < length2)
				{
					return false;
				}
			}
		}
	}
	return true;
}

/*
	Name: function_18f38647
	Namespace: smart_cover
	Checksum: 0x584D81C2
	Offset: 0x480
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_18f38647(zone)
{
	array::add(level.var_5101157d.var_d6a27a84, zone);
}

/*
	Name: function_60a53911
	Namespace: smart_cover
	Checksum: 0x393C9BAC
	Offset: 0x4C0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_60a53911(zone)
{
	arrayremovevalue(level.var_5101157d.var_d6a27a84, zone);
}

