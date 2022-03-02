// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_e6ad7806;

/*
	Name: function_89f2df9
	Namespace: namespace_e6ad7806
	Checksum: 0x5A0AE5BF
	Offset: 0xB0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4eba302dfad99d61", undefined, &__main__, undefined);
}

/*
	Name: __main__
	Namespace: namespace_e6ad7806
	Checksum: 0x8B417AAB
	Offset: 0xF0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level._effect[#"grenade_light"] = #"weapon/fx8_equip_light_os";
}

/*
	Name: spawned
	Namespace: namespace_e6ad7806
	Checksum: 0xEBFA2943
	Offset: 0x130
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function spawned(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	self thread fx_think(localclientnum);
}

/*
	Name: fx_think
	Namespace: namespace_e6ad7806
	Checksum: 0x296B27B4
	Offset: 0x178
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function fx_think(localclientnum)
{
	self notify(#"light_disable");
	self endon(#"death", #"light_disable");
	self util::waittill_dobj(localclientnum);
	var_18407835 = self.origin;
	interval = 0.3;
	for(;;)
	{
		self stop_light_fx(localclientnum);
		self start_light_fx(localclientnum);
		self fullscreen_fx(localclientnum);
		playsound(localclientnum, #"hash_2bb4a8b02a0d697", var_18407835);
		util::server_wait(localclientnum, interval, 0.01, "player_switch");
		interval = math::clamp(interval / 1.2, 0.08, 0.3);
	}
}

/*
	Name: start_light_fx
	Namespace: namespace_e6ad7806
	Checksum: 0x562BACA0
	Offset: 0x2C8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function start_light_fx(localclientnum)
{
	self.fx = util::playfxontag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
}

/*
	Name: stop_light_fx
	Namespace: namespace_e6ad7806
	Checksum: 0x50844A07
	Offset: 0x320
	Size: 0x4E
	Parameters: 1
	Flags: Linked
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
	Name: fullscreen_fx
	Namespace: namespace_e6ad7806
	Checksum: 0xFECF4061
	Offset: 0x378
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function fullscreen_fx(localclientnum)
{
	if(function_1cbf351b(localclientnum))
	{
		return;
	}
	if(util::is_player_view_linked_to_entity(localclientnum))
	{
		return;
	}
	if(self function_83973173())
	{
		return;
	}
	parent = self getparententity();
	if(isdefined(parent) && parent function_21c0fa55())
	{
		parent playrumbleonentity(localclientnum, "buzz_high");
	}
}

