// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\trigger_shared.csc;
#using scripts\core_common\water_surface.csc;

#namespace waterfall;

/*
	Name: waterfalloverlay
	Namespace: waterfall
	Checksum: 0xDC89D722
	Offset: 0x100
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function waterfalloverlay(localclientnum)
{
	triggers = getentarray(localclientnum, "waterfall", "targetname");
	foreach(trigger in triggers)
	{
		trigger thread setupwaterfall(localclientnum);
	}
}

/*
	Name: waterfallmistoverlay
	Namespace: waterfall
	Checksum: 0x8D0EC925
	Offset: 0x1C0
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function waterfallmistoverlay(localclientnum)
{
	triggers = getentarray(localclientnum, "waterfall_mist", "targetname");
	foreach(trigger in triggers)
	{
		trigger thread setupwaterfallmist(localclientnum);
	}
}

/*
	Name: waterfallmistoverlayreset
	Namespace: waterfall
	Checksum: 0x617D485D
	Offset: 0x280
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function waterfallmistoverlayreset(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	localplayer.rainopacity = 0;
}

/*
	Name: setupwaterfallmist
	Namespace: waterfall
	Checksum: 0x92EFC4C8
	Offset: 0x2D0
	Size: 0x138
	Parameters: 1
	Flags: None
*/
function setupwaterfallmist(localclientnum)
{
	level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
	level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
	trigger = self;
	for(;;)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		trigplayer = waitresult.activator;
		if(!trigplayer function_21c0fa55())
		{
			continue;
		}
		localclientnum = trigplayer getlocalclientnumber();
		if(isdefined(localclientnum))
		{
			localplayer = function_5c10bd79(localclientnum);
		}
		else
		{
			localplayer = trigplayer;
		}
		filter::init_filter_sprite_rain(localplayer);
		trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist);
	}
}

/*
	Name: setupwaterfall
	Namespace: waterfall
	Checksum: 0xE9A7C8AA
	Offset: 0x410
	Size: 0x150
	Parameters: 2
	Flags: None
*/
function setupwaterfall(localclientnum, localowner)
{
	level notify(#"setupwaterfall_waterfall_csc" + string(localclientnum));
	level endon(#"setupwaterfall_waterfall_csc" + string(localclientnum));
	trigger = self;
	for(;;)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		trigplayer = waitresult.activator;
		if(!trigplayer function_21c0fa55())
		{
			continue;
		}
		localclientnum = trigplayer getlocalclientnumber();
		if(isdefined(localclientnum))
		{
			localplayer = function_5c10bd79(localclientnum);
		}
		else
		{
			localplayer = trigplayer;
		}
		trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall, &trig_leave_waterfall);
	}
}

/*
	Name: trig_enter_waterfall
	Namespace: waterfall
	Checksum: 0xEFF31B0A
	Offset: 0x568
	Size: 0xC0
	Parameters: 1
	Flags: None
*/
function trig_enter_waterfall(localplayer)
{
	trigger = self;
	localclientnum = localplayer.localclientnum;
	localplayer thread postfx::playpostfxbundle(#"pstfx_waterfall");
	playsound(0, #"amb_waterfall_hit", (0, 0, 0));
	while(trigger istouching(localplayer))
	{
		localplayer playrumbleonentity(localclientnum, "waterfall_rumble");
		wait(0.1);
	}
}

/*
	Name: trig_leave_waterfall
	Namespace: waterfall
	Checksum: 0xB8947329
	Offset: 0x630
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function trig_leave_waterfall(localplayer)
{
	trigger = self;
	localclientnum = localplayer.localclientnum;
	localplayer postfx::stoppostfxbundle("pstfx_waterfall");
	if(isunderwater(localclientnum) == 0)
	{
		localplayer thread water_surface::startwatersheeting();
	}
}

/*
	Name: trig_enter_waterfall_mist
	Namespace: waterfall
	Checksum: 0x3F33CCF8
	Offset: 0x6B8
	Size: 0x1CE
	Parameters: 1
	Flags: None
*/
function trig_enter_waterfall_mist(localplayer)
{
	localplayer endon(#"death");
	trigger = self;
	if(!isdefined(localplayer.rainopacity))
	{
		localplayer.rainopacity = 0;
	}
	if(localplayer.rainopacity == 0)
	{
		filter::set_filter_sprite_rain_seed_offset(localplayer, 0, randomfloat(1));
	}
	filter::enable_filter_sprite_rain(localplayer, 0);
	while(trigger istouching(localplayer))
	{
		localclientnum = trigger.localclientnum;
		if(!isdefined(localclientnum))
		{
			localclientnum = localplayer getlocalclientnumber();
		}
		if(isunderwater(localclientnum))
		{
			filter::disable_filter_sprite_rain(localplayer, 0);
			break;
		}
		localplayer.rainopacity = localplayer.rainopacity + 0.003;
		if(localplayer.rainopacity > 1)
		{
			localplayer.rainopacity = 1;
		}
		filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
		filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
		waitframe(1);
	}
}

/*
	Name: trig_leave_waterfall_mist
	Namespace: waterfall
	Checksum: 0x981B8DA2
	Offset: 0x890
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function trig_leave_waterfall_mist(localplayer)
{
	localplayer endon(#"death");
	trigger = self;
	if(isdefined(localplayer.rainopacity))
	{
		while(!trigger istouching(localplayer) && localplayer.rainopacity > 0)
		{
			localclientnum = trigger.localclientnum;
			if(isunderwater(localclientnum))
			{
				filter::disable_filter_sprite_rain(localplayer, 0);
				break;
			}
			localplayer.rainopacity = localplayer.rainopacity - 0.005;
			filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
			filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
			waitframe(1);
		}
	}
	localplayer.rainopacity = 0;
	filter::disable_filter_sprite_rain(localplayer, 0);
}

