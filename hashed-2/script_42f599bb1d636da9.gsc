// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace sticky_grenade;

/*
	Name: function_89f2df9
	Namespace: sticky_grenade
	Checksum: 0xDCD579F5
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"sticky_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: sticky_grenade
	Checksum: 0xE9C26933
	Offset: 0x138
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"grenade_light"] = #"weapon/fx8_equip_light_os";
	level._effect[#"hash_61fd92df093ebdb4"] = #"hash_44b0fea08babccac";
	callback::add_weapon_type(#"sticky_grenade", &spawned);
	callback::add_weapon_type(#"eq_sticky_grenade", &spawned);
	callback::add_weapon_type(#"hash_4b92b1a2aa3037f5", &spawned);
	callback::add_weapon_type(#"eq_cluster_semtex_grenade", &spawned);
	callback::add_weapon_type(#"hash_66401df7cd6bf292", &function_6054cc1e);
	callback::add_weapon_type(#"hash_18c353e6053566bd", &function_117f61b8);
	callback::add_weapon_type(#"hash_494e1edad9bd44fd", &function_117f61b8);
	callback::add_weapon_type(#"hash_494e1ddad9bd434a", &function_117f61b8);
	callback::add_weapon_type(#"hash_494e18dad9bd3acb", &function_117f61b8);
	callback::add_weapon_type(#"hash_40380537847df901", &function_78bd4311);
	callback::add_weapon_type(#"hash_1d2a1056220e71a9", &function_78bd4311);
	callback::add_weapon_type(#"hash_1d2a0f56220e6ff6", &function_78bd4311);
	callback::add_weapon_type(#"hash_1d2a1256220e750f", &function_78bd4311);
	callback::add_weapon_type(#"hash_1d2a1156220e735c", &function_78bd4311);
}

/*
	Name: spawned
	Namespace: sticky_grenade
	Checksum: 0x39DA04F6
	Offset: 0x448
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function spawned(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	self thread fx_think(localclientnum, 1);
}

/*
	Name: function_78bd4311
	Namespace: sticky_grenade
	Checksum: 0xFE9849D8
	Offset: 0x498
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_78bd4311(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	self thread fx_think(localclientnum, 2);
}

/*
	Name: function_6054cc1e
	Namespace: sticky_grenade
	Checksum: 0x929837F2
	Offset: 0x4E8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_6054cc1e(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	self thread function_c879d0fd(localclientnum);
}

/*
	Name: function_117f61b8
	Namespace: sticky_grenade
	Checksum: 0x392ECD3C
	Offset: 0x530
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_117f61b8(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	handle = self playsound(localclientnum, #"wpn_semtex_countdown");
	self thread stop_sound_on_ent_shutdown(handle);
}

/*
	Name: stop_sound_on_ent_shutdown
	Namespace: sticky_grenade
	Checksum: 0x51BEC129
	Offset: 0x5B0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function stop_sound_on_ent_shutdown(handle)
{
	self waittill(#"death");
	stopsound(handle);
}

/*
	Name: fx_think
	Namespace: sticky_grenade
	Checksum: 0xD4BF798
	Offset: 0x5F0
	Size: 0x23A
	Parameters: 2
	Flags: Linked
*/
function fx_think(localclientnum, var_1e60ee48)
{
	self notify(#"light_disable");
	self endon(#"light_disable");
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	handle = self playsound(localclientnum, #"wpn_semtex_countdown");
	self thread stop_sound_on_ent_shutdown(handle);
	interval = 0.3;
	while(isdefined(self))
	{
		self stop_light_fx(localclientnum);
		localplayer = function_5c10bd79(localclientnum);
		if(!isdefined(localplayer))
		{
			continue;
		}
		if(!localplayer isentitylinkedtotag(self, "j_head") && !localplayer isentitylinkedtotag(self, "j_elbow_le") && !localplayer isentitylinkedtotag(self, "j_spineupper"))
		{
			self start_light_fx(localclientnum, level._effect[#"grenade_light"]);
		}
		self fullscreen_fx(localclientnum, var_1e60ee48);
		util::server_wait(localclientnum, interval, 0.01, "player_switch");
		self util::waittill_dobj(localclientnum);
		interval = math::clamp(interval / 1.2, 0.08, 0.3);
	}
}

/*
	Name: start_light_fx
	Namespace: sticky_grenade
	Checksum: 0x4BF30D86
	Offset: 0x838
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function start_light_fx(localclientnum, fx)
{
	self stop_light_fx(localclientnum);
	self.fx = util::playfxontag(localclientnum, fx, self, "tag_fx");
}

/*
	Name: stop_light_fx
	Namespace: sticky_grenade
	Checksum: 0x68D6B8EC
	Offset: 0x8A0
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
	Name: function_c879d0fd
	Namespace: sticky_grenade
	Checksum: 0xFAC65C2
	Offset: 0x8F8
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_c879d0fd(localclientnum)
{
	self notify(#"light_disable");
	self endon(#"light_disable");
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	interval = 0.3;
	for(;;)
	{
		self stop_light_fx(localclientnum);
		self start_light_fx(localclientnum, level._effect[#"hash_61fd92df093ebdb4"]);
		util::server_wait(localclientnum, interval, 0.01, "player_switch");
		self util::waittill_dobj(localclientnum);
		interval = math::clamp(interval / 1.2, 0.08, 0.3);
	}
}

/*
	Name: sticky_indicator
	Namespace: sticky_grenade
	Checksum: 0xE8387B2F
	Offset: 0xA28
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function sticky_indicator(localclientnum, indicator)
{
	controllermodel = getuimodelforcontroller(localclientnum);
	stickyimagemodel = createuimodel(controllermodel, "hudItems.stuckImageIndex");
	setuimodelvalue(stickyimagemodel, indicator);
	player = function_5c10bd79(localclientnum);
	while(isdefined(self))
	{
		waitframe(1);
	}
	setuimodelvalue(stickyimagemodel, 0);
	if(isdefined(player))
	{
		player notify(#"sticky_shutdown");
	}
}

/*
	Name: fullscreen_fx
	Namespace: sticky_grenade
	Checksum: 0x2B731C08
	Offset: 0xB10
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function fullscreen_fx(localclientnum, indicator)
{
	if(function_1cbf351b(localclientnum))
	{
		return;
	}
	if(util::is_player_view_linked_to_entity(localclientnum))
	{
		return;
	}
	if(self function_4e0ca360())
	{
		return;
	}
	parent = self getparententity();
	if(isdefined(parent) && parent function_21c0fa55())
	{
		parent playrumbleonentity(localclientnum, "buzz_high");
		if(getdvarint(#"ui_hud_hardcore", 0) == 0)
		{
			self thread sticky_indicator(localclientnum, indicator);
		}
	}
}

