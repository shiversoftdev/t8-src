// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\fx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\struct.csc;

#namespace tacticalinsertion;

/*
	Name: init_shared
	Namespace: tacticalinsertion
	Checksum: 0xF74A2A62
	Offset: 0xE8
	Size: 0x214
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level._effect[#"tacticalinsertionfriendly"] = #"_t6/misc/fx_equip_tac_insert_light_grn";
	level._effect[#"tacticalinsertionenemy"] = #"_t6/misc/fx_equip_tac_insert_light_red";
	clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int", &spawned, 0, 0);
	latlongstruct = struct::get("lat_long", "targetname");
	if(isdefined(latlongstruct))
	{
		mapx = latlongstruct.origin[0];
		mapy = latlongstruct.origin[1];
		lat = latlongstruct.script_vector[0];
		long = latlongstruct.script_vector[1];
	}
	else
	{
		if(isdefined(level.worldmapx) && isdefined(level.worldmapy))
		{
			mapx = level.worldmapx;
			mapy = level.worldmapy;
		}
		else
		{
			mapx = 0;
			mapy = 0;
		}
		if(isdefined(level.worldlat) && isdefined(level.worldlong))
		{
			lat = level.worldlat;
			long = level.worldlong;
		}
		else
		{
			lat = 34.02156;
			long = -118.4487;
		}
	}
	setmaplatlong(mapx, mapy, long, lat);
}

/*
	Name: spawned
	Namespace: tacticalinsertion
	Checksum: 0xB92932E0
	Offset: 0x308
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
	self thread playflarefx(localclientnum);
	self thread checkforplayerswitch(localclientnum);
}

/*
	Name: playflarefx
	Namespace: tacticalinsertion
	Checksum: 0xCE05DE76
	Offset: 0x388
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function playflarefx(localclientnum)
{
	self endon(#"death");
	level endon(#"player_switch");
	self.tacticalinsertionfx = self fx::function_3539a829(localclientnum, level._effect[#"tacticalinsertionfriendly"], level._effect[#"tacticalinsertionenemy"], "tag_flash");
	self thread watchtacinsertshutdown(localclientnum, self.tacticalinsertionfx);
	looporigin = self.origin;
	audio::playloopat("fly_tinsert_beep", looporigin);
	self thread stopflareloopwatcher(looporigin);
}

/*
	Name: watchtacinsertshutdown
	Namespace: tacticalinsertion
	Checksum: 0x9C320F6F
	Offset: 0x488
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function watchtacinsertshutdown(localclientnum, fxhandle)
{
	self waittill(#"death");
	if(isdefined(fxhandle))
	{
		stopfx(localclientnum, fxhandle);
	}
}

/*
	Name: stopflareloopwatcher
	Namespace: tacticalinsertion
	Checksum: 0xDF34D534
	Offset: 0x4E0
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function stopflareloopwatcher(looporigin)
{
	while(true)
	{
		if(!isdefined(self) || !isdefined(self.tacticalinsertionfx))
		{
			audio::stoploopat("fly_tinsert_beep", looporigin);
			break;
		}
		wait(0.5);
	}
}

/*
	Name: checkforplayerswitch
	Namespace: tacticalinsertion
	Checksum: 0x44F54AF9
	Offset: 0x548
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function checkforplayerswitch(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		level waittill(#"player_switch");
		if(isdefined(self.tacticalinsertionfx))
		{
			stopfx(localclientnum, self.tacticalinsertionfx);
			self.tacticalinsertionfx = undefined;
		}
		waittillframeend();
		self thread playflarefx(localclientnum);
	}
}

