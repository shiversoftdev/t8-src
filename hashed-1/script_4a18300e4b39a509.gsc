// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using script_6b2be07726845c37;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;

#namespace gravity_spikes;

/*
	Name: function_89f2df9
	Namespace: gravity_spikes
	Checksum: 0xAA1F75A
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"gravity_spikes", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gravity_spikes
	Checksum: 0x33CC2CC0
	Offset: 0x100
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	init_shared();
	ability_player::register_gadget_activation_callbacks(7, &function_20bb376d, undefined);
}

/*
	Name: function_20bb376d
	Namespace: gravity_spikes
	Checksum: 0x6CF4A9B7
	Offset: 0x140
	Size: 0xE2
	Parameters: 2
	Flags: None
*/
function function_20bb376d(var_3245778e, weapon)
{
	self battlechatter::function_bd715920(weapon, undefined, self geteye(), self);
	playfx("weapon/fx8_hero_grvity_slam_takeoff_3p", self.origin);
	if(isdefined(self.var_ea1458aa))
	{
		self.var_ea1458aa.var_6799f1da = 0;
		if(!self isonground() && isdefined(self.var_700a5910) && isdefined(self.challenge_jump_begin) && self.var_700a5910 > self.challenge_jump_begin)
		{
			self.var_ea1458aa.var_6799f1da = 1;
		}
	}
}

