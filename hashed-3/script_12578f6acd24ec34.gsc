// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace sticky_grenade;

/*
	Name: function_89f2df9
	Namespace: sticky_grenade
	Checksum: 0x44284F1D
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"spike_charge", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: sticky_grenade
	Checksum: 0x303E1AE0
	Offset: 0xF8
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level._effect[#"spike_light"] = #"weapon/fx_light_spike_launcher";
	callback::add_weapon_type(#"spike_launcher", &spawned);
	callback::add_weapon_type(#"spike_launcher_cpzm", &spawned);
	callback::add_weapon_type(#"spike_charge", &spawned_spike_charge);
}

/*
	Name: spawned
	Namespace: sticky_grenade
	Checksum: 0x7EA7F0BF
	Offset: 0x1C8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function spawned(localclientnum)
{
	self thread fx_think(localclientnum);
}

/*
	Name: spawned_spike_charge
	Namespace: sticky_grenade
	Checksum: 0xF6063DCE
	Offset: 0x1F8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function spawned_spike_charge(localclientnum)
{
	self thread fx_think(localclientnum);
	self thread spike_detonation(localclientnum);
}

/*
	Name: fx_think
	Namespace: sticky_grenade
	Checksum: 0x2104DF96
	Offset: 0x240
	Size: 0x10A
	Parameters: 1
	Flags: None
*/
function fx_think(localclientnum)
{
	self notify(#"light_disable");
	self endon(#"death");
	self endon(#"light_disable");
	self util::waittill_dobj(localclientnum);
	interval = 0.3;
	for(;;)
	{
		self stop_light_fx(localclientnum);
		self start_light_fx(localclientnum);
		util::server_wait(localclientnum, interval, 0.01, "player_switch");
		self util::waittill_dobj(localclientnum);
		interval = math::clamp(interval / 1.2, 0.08, 0.3);
	}
}

/*
	Name: start_light_fx
	Namespace: sticky_grenade
	Checksum: 0x28503038
	Offset: 0x358
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function start_light_fx(localclientnum)
{
	self.fx = util::playfxontag(localclientnum, level._effect[#"spike_light"], self, "tag_fx");
}

/*
	Name: stop_light_fx
	Namespace: sticky_grenade
	Checksum: 0x67E7263C
	Offset: 0x3B0
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function stop_light_fx(localclientnum)
{
	if(isdefined(self.fx) && self.fx != 0)
	{
		stopfx(localclientnum, self.fx);
		self.fx = undefined;
	}
}

/*
	Name: spike_detonation
	Namespace: sticky_grenade
	Checksum: 0x5368EE85
	Offset: 0x408
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function spike_detonation(localclientnum)
{
	while(isdefined(self))
	{
		waitframe(1);
	}
	if(!isigcactive(localclientnum))
	{
		player = function_5c10bd79(localclientnum);
		explosion_distance = distancesquared(spike_position, player.origin);
		if(explosion_distance <= 450 * 450)
		{
			player thread postfx::playpostfxbundle(#"pstfx_dust_chalk");
		}
		if(explosion_distance <= 300 * 300)
		{
			player thread postfx::playpostfxbundle(#"pstfx_dust_concrete");
		}
	}
}

