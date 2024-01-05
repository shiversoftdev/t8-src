// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace spike_charge_siegebot;

/*
	Name: __init__system__
	Namespace: spike_charge_siegebot
	Checksum: 0xFCE2AF0A
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"spike_charge_siegebot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: spike_charge_siegebot
	Checksum: 0xA47F8636
	Offset: 0xF0
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level._effect[#"spike_charge_siegebot_light"] = #"light/fx_light_red_spike_charge_os";
	callback::add_weapon_type(#"spike_charge_siegebot", &spawned);
	callback::add_weapon_type(#"spike_charge_siegebot_theia", &spawned);
	callback::add_weapon_type(#"siegebot_launcher_turret", &spawned);
	callback::add_weapon_type(#"siegebot_launcher_turret_theia", &spawned);
	callback::add_weapon_type(#"siegebot_javelin_turret", &spawned);
}

/*
	Name: spawned
	Namespace: spike_charge_siegebot
	Checksum: 0xA709DBE8
	Offset: 0x220
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function spawned(localclientnum)
{
	self thread fx_think(localclientnum);
}

/*
	Name: fx_think
	Namespace: spike_charge_siegebot
	Checksum: 0x7D219C12
	Offset: 0x250
	Size: 0x132
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
		self playsound(localclientnum, #"wpn_semtex_alert");
		util::server_wait(localclientnum, interval, 0.01, "player_switch");
		self util::waittill_dobj(localclientnum);
		interval = math::clamp(interval / 1.2, 0.08, 0.3);
	}
}

/*
	Name: start_light_fx
	Namespace: spike_charge_siegebot
	Checksum: 0xAFD9A8C2
	Offset: 0x390
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function start_light_fx(localclientnum)
{
	self.fx = util::playfxontag(localclientnum, level._effect[#"spike_charge_siegebot_light"], self, "tag_fx");
}

/*
	Name: stop_light_fx
	Namespace: spike_charge_siegebot
	Checksum: 0x8311BA2D
	Offset: 0x3E8
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

