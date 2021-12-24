// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47f5b3a23db10e76;
#using script_47fb62300ac0bd60;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\util.gsc;

#namespace smart_cover;

/*
	Name: function_89f2df9
	Namespace: smart_cover
	Checksum: 0x7FD5CC09
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	function_649f8cbe(&function_c8d7d200);
	function_a9427b5c(&function_a430cceb);
	level.var_b57c1895 = &function_9a2b3318;
}

/*
	Name: function_c8d7d200
	Namespace: smart_cover
	Checksum: 0x94ECFB2F
	Offset: 0x170
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_c8d7d200(smartcover)
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
					return 0;
				}
			}
		}
	}
	return 1;
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

