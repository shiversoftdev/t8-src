// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace water_surface;

/*
	Name: function_89f2df9
	Namespace: water_surface
	Checksum: 0x8BBA00A
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"water_surface", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: water_surface
	Checksum: 0xF84AB761
	Offset: 0x100
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"water_player_jump_out"] = #"player/fx_plyr_water_jump_out_splash_1p";
	level._effect[#"hash_1e7095084eda811c"] = #"hash_123c2521c68b2167";
	if(isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1)
	{
		return;
	}
	callback::on_localplayer_spawned(&localplayer_spawned);
}

/*
	Name: localplayer_spawned
	Namespace: water_surface
	Checksum: 0x84DD99F5
	Offset: 0x1B8
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function localplayer_spawned(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	if(isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1)
	{
		return;
	}
	filter::init_filter_water_sheeting(self);
	filter::init_filter_water_dive(self);
	self thread underwaterwatchbegin();
	self thread underwaterwatchend();
	filter::disable_filter_water_sheeting(self, 1);
	stop_player_fx(self);
}

/*
	Name: underwaterwatchbegin
	Namespace: water_surface
	Checksum: 0xC0E7B56D
	Offset: 0x2A0
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function underwaterwatchbegin()
{
	self notify(#"underwaterwatchbegin");
	self endon(#"underwaterwatchbegin");
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"underwater_begin");
		if(waitresult.is_teleported)
		{
			filter::disable_filter_water_sheeting(self, 1);
			stop_player_fx(self);
			filter::disable_filter_water_dive(self, 1);
			stop_player_fx(self);
		}
		else
		{
			self thread underwaterbegin();
		}
	}
}

/*
	Name: underwaterwatchend
	Namespace: water_surface
	Checksum: 0x3FD92440
	Offset: 0x398
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function underwaterwatchend()
{
	self notify(#"underwaterwatchend");
	self endon(#"underwaterwatchend");
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"underwater_end");
		if(waitresult.is_teleported)
		{
			filter::disable_filter_water_sheeting(self, 1);
			stop_player_fx(self);
			filter::disable_filter_water_dive(self, 1);
			stop_player_fx(self);
		}
		else
		{
			self thread underwaterend();
		}
	}
}

/*
	Name: underwaterbegin
	Namespace: water_surface
	Checksum: 0xB198176
	Offset: 0x490
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function underwaterbegin()
{
	self notify(#"water_surface_underwater_begin");
	self endon(#"water_surface_underwater_begin");
	self endon(#"death");
	localclientnum = self getlocalclientnumber();
	filter::disable_filter_water_sheeting(self, 1);
	stop_player_fx(self);
	if(islocalclientdead(localclientnum) == 0)
	{
		self.var_733dd716 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
		if(!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition")
		{
			self thread postfx::playpostfxbundle(#"pstfx_watertransition");
		}
	}
}

/*
	Name: underwaterend
	Namespace: water_surface
	Checksum: 0x22A0E157
	Offset: 0x5C8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function underwaterend()
{
	self notify(#"water_surface_underwater_end");
	self endon(#"water_surface_underwater_end");
	self endon(#"death");
	localclientnum = self getlocalclientnumber();
	if(islocalclientdead(localclientnum) == 0)
	{
		if(!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out")
		{
			self thread postfx::playpostfxbundle(#"pstfx_water_t_out");
		}
	}
}

/*
	Name: startwaterdive
	Namespace: water_surface
	Checksum: 0x69DA8DB4
	Offset: 0x690
	Size: 0x230
	Parameters: 0
	Flags: None
*/
function startwaterdive()
{
	filter::enable_filter_water_dive(self, 1);
	filter::set_filter_water_scuba_dive_speed(self, 1, 0.25);
	filter::set_filter_water_wash_color(self, 1, 0.16, 0.5, 0.9);
	filter::set_filter_water_wash_reveal_dir(self, 1, -1);
	i = 0;
	while(i < 0.05)
	{
		filter::set_filter_water_dive_bubbles(self, 1, i / 0.05);
		wait(0.01);
		i = i + 0.01;
	}
	filter::set_filter_water_dive_bubbles(self, 1, 1);
	filter::set_filter_water_scuba_bubble_attitude(self, 1, -1);
	filter::set_filter_water_scuba_bubbles(self, 1, 1);
	filter::set_filter_water_wash_reveal_dir(self, 1, 1);
	i = 0.2;
	while(i > 0)
	{
		filter::set_filter_water_dive_bubbles(self, 1, i / 0.2);
		wait(0.01);
		i = i - 0.01;
	}
	filter::set_filter_water_dive_bubbles(self, 1, 0);
	wait(0.1);
	i = 0.2;
	while(i > 0)
	{
		filter::set_filter_water_scuba_bubbles(self, 1, i / 0.2);
		wait(0.01);
		i = i - 0.01;
	}
}

/*
	Name: startwatersheeting
	Namespace: water_surface
	Checksum: 0x3988569F
	Offset: 0x8C8
	Size: 0x20C
	Parameters: 0
	Flags: None
*/
function startwatersheeting()
{
	self notify(#"startwatersheeting_singleton");
	self endon(#"startwatersheeting_singleton");
	self endon(#"death");
	filter::enable_filter_water_sheeting(self, 1);
	filter::set_filter_water_sheet_reveal(self, 1, 1);
	filter::set_filter_water_sheet_speed(self, 1, 1);
	i = 2;
	while(i > 0)
	{
		filter::set_filter_water_sheet_reveal(self, 1, i / 2);
		filter::set_filter_water_sheet_speed(self, 1, i / 2);
		rivulet1 = i / 2 - 0.19;
		rivulet2 = i / 2 - 0.13;
		rivulet3 = i / 2 - 0.07;
		filter::set_filter_water_sheet_rivulet_reveal(self, 1, rivulet1, rivulet2, rivulet3);
		wait(0.01);
		i = i - 0.01;
	}
	filter::set_filter_water_sheet_reveal(self, 1, 0);
	filter::set_filter_water_sheet_speed(self, 1, 0);
	filter::set_filter_water_sheet_rivulet_reveal(self, 1, 0, 0, 0);
}

/*
	Name: stop_player_fx
	Namespace: water_surface
	Checksum: 0x8FDCAA2A
	Offset: 0xAE0
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function stop_player_fx(localclient)
{
	if(isdefined(localclient.firstperson_water_fx))
	{
		localclientnum = localclient getlocalclientnumber();
		stopfx(localclientnum, localclient.firstperson_water_fx);
		localclient.firstperson_water_fx = undefined;
	}
	if(isdefined(localclient.var_733dd716))
	{
		localclientnum = localclient getlocalclientnumber();
		stopfx(localclientnum, localclient.var_733dd716);
		localclient.var_733dd716 = undefined;
	}
}

