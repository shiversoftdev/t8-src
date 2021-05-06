// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_45e0fb7326469ccf;
#using script_50cd53b603b30ef5;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\mp_common\callbacks.csc;

#namespace namespace_231aa29a;

/*
	Name: init
	Namespace: namespace_231aa29a
	Checksum: 0xE0A671B8
	Offset: 0x128
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"rcbomb_enemy_light"] = #"killstreaks/fx_rcxd_lights_blinky";
	level._effect[#"rcbomb_friendly_light"] = #"killstreaks/fx_rcxd_lights_solid";
	level._effect[#"rcbomb_enemy_light_blink"] = #"killstreaks/fx_rcxd_lights_red";
	level._effect[#"rcbomb_friendly_light_blink"] = #"killstreaks/fx_rcxd_lights_grn";
	level._effect[#"rcbomb_stunned"] = #"hash_622d3cdb93e01de5";
	clientfield::register("vehicle", "stunned", 1, 1, "int", &callback::callback_stunned, 0, 0);
}

/*
	Name: function_155de655
	Namespace: namespace_231aa29a
	Checksum: 0x9DEBE69
	Offset: 0x268
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_155de655(bundle)
{
	if(isdefined(bundle.ksvehicle))
	{
		vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned, bundle);
	}
	if(isdefined(bundle.var_486124e6))
	{
		visionset_mgr::register_overlay_info_style_postfx_bundle(bundle.var_486124e6, 1, 1, bundle.var_486124e6);
	}
}

/*
	Name: spawned
	Namespace: namespace_231aa29a
	Checksum: 0x73591017
	Offset: 0x2F8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function spawned(localclientnum, bundle)
{
	self thread demo_think(localclientnum);
	self thread stunnedhandler(localclientnum);
	self thread boost_think(localclientnum);
	self thread shutdown_think(localclientnum);
	self.driving_fx_collision_override = &ondrivingfxcollision;
	self.driving_fx_jump_landing_override = &ondrivingfxjumplanding;
	self killstreak_bundles::spawned(localclientnum, bundle);
}

/*
	Name: demo_think
	Namespace: namespace_231aa29a
	Checksum: 0xD7B76CE
	Offset: 0x3C0
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function demo_think(localclientnum)
{
	self endon(#"death");
	if(!isdemoplaying())
	{
		return;
	}
	for(;;)
	{
		level waittill(#"demo_jump", #"demo_player_switch");
		self vehicle::lights_off(localclientnum);
	}
}

/*
	Name: boost_blur
	Namespace: namespace_231aa29a
	Checksum: 0x82532E1A
	Offset: 0x440
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function boost_blur(localclientnum)
{
	self endon(#"death");
	if(isdefined(self.owner) && self.owner function_21c0fa55())
	{
		enablespeedblur(localclientnum, getdvarfloat(#"scr_rcbomb_amount", 0.1), getdvarfloat(#"scr_rcbomb_inner_radius", 0.5), getdvarfloat(#"scr_rcbomb_outer_radius", 0.75), 0, 0);
		wait(getdvarfloat(#"scr_rcbomb_duration", 1));
		disablespeedblur(localclientnum);
	}
}

/*
	Name: boost_think
	Namespace: namespace_231aa29a
	Checksum: 0x6745F869
	Offset: 0x560
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function boost_think(localclientnum)
{
	self endon(#"death");
	for(;;)
	{
		self waittill(#"veh_boost");
		self boost_blur(localclientnum);
	}
}

/*
	Name: shutdown_think
	Namespace: namespace_231aa29a
	Checksum: 0x6CBEEB4C
	Offset: 0x5B8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function shutdown_think(localclientnum)
{
	self waittill(#"death");
	disablespeedblur(localclientnum);
}

/*
	Name: play_boost_fx
	Namespace: namespace_231aa29a
	Checksum: 0x5067A8BC
	Offset: 0x5F8
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function play_boost_fx(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		speed = self getspeed();
		if(speed > 400)
		{
			self playsound(localclientnum, #"mpl_veh_rc_boost");
			return;
		}
		util::server_wait(localclientnum, 0.1);
	}
}

/*
	Name: stunnedhandler
	Namespace: namespace_231aa29a
	Checksum: 0xE3BEF2B9
	Offset: 0x6A0
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function stunnedhandler(localclientnum)
{
	self endon(#"death");
	self thread enginestutterhandler(localclientnum);
	while(true)
	{
		self waittill(#"stunned");
		self setstunned(1);
		self thread notstunnedhandler(localclientnum);
		self thread play_stunned_fx_handler(localclientnum);
	}
}

/*
	Name: notstunnedhandler
	Namespace: namespace_231aa29a
	Checksum: 0x7BAEB94C
	Offset: 0x748
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function notstunnedhandler(localclientnum)
{
	self endon(#"death");
	self endon(#"stunned");
	self waittill(#"not_stunned");
	self setstunned(0);
}

/*
	Name: play_stunned_fx_handler
	Namespace: namespace_231aa29a
	Checksum: 0xBB5EDDA3
	Offset: 0x7B0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function play_stunned_fx_handler(localclientnum)
{
	self endon(#"death");
	self endon(#"stunned");
	self endon(#"not_stunned");
	while(true)
	{
		util::playfxontag(localclientnum, level._effect[#"rcbomb_stunned"], self, "tag_origin");
		wait(0.5);
	}
}

/*
	Name: enginestutterhandler
	Namespace: namespace_231aa29a
	Checksum: 0x9CA28FCA
	Offset: 0x848
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function enginestutterhandler(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"veh_engine_stutter");
		if(self function_4add50a7())
		{
			function_36e4ebd4(localclientnum, "rcbomb_engine_stutter");
		}
	}
}

/*
	Name: ondrivingfxcollision
	Namespace: namespace_231aa29a
	Checksum: 0xB5EC124A
	Offset: 0x8C0
	Size: 0x11C
	Parameters: 5
	Flags: Linked
*/
function ondrivingfxcollision(localclientnum, player, hip, hitn, hit_intensity)
{
	if(isdefined(hit_intensity) && hit_intensity > 15)
	{
		volume = driving_fx::get_impact_vol_from_speed();
		if(isdefined(self.sounddef))
		{
			alias = self.sounddef + "_suspension_lg_hd";
		}
		else
		{
			alias = "veh_default_suspension_lg_hd";
		}
		id = playsound(0, alias, self.origin, volume);
		earthquake(localclientnum, 0.7, 0.25, player.origin, 1500);
		player playrumbleonentity(localclientnum, "damage_heavy");
	}
}

/*
	Name: ondrivingfxjumplanding
	Namespace: namespace_231aa29a
	Checksum: 0xF5BCB5BE
	Offset: 0x9E8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function ondrivingfxjumplanding(localclientnum, player)
{
}

