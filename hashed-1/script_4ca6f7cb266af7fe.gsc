// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;

#namespace hacker_tool;

/*
	Name: init_shared
	Namespace: hacker_tool
	Checksum: 0x41D44814
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("toplayer", "hacker_tool", 1, 2, "int", &player_hacking, 0, 0);
	level.hackingsoundid = [];
	level.hackingsweetspotid = [];
	level.friendlyhackingsoundid = [];
	callback::on_localplayer_spawned(&on_localplayer_spawned);
}

/*
	Name: on_localplayer_spawned
	Namespace: hacker_tool
	Checksum: 0x1346E05F
	Offset: 0x1B0
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function on_localplayer_spawned(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	player = self;
	if(isdefined(level.hackingsoundid[localclientnum]))
	{
		player stoploopsound(level.hackingsoundid[localclientnum]);
		level.hackingsoundid[localclientnum] = undefined;
	}
	if(isdefined(level.hackingsweetspotid[localclientnum]))
	{
		player stoploopsound(level.hackingsweetspotid[localclientnum]);
		level.hackingsweetspotid[localclientnum] = undefined;
	}
	if(isdefined(level.friendlyhackingsoundid[localclientnum]))
	{
		player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
		level.friendlyhackingsoundid[localclientnum] = undefined;
	}
}

/*
	Name: player_hacking
	Namespace: hacker_tool
	Checksum: 0x6B24BCD1
	Offset: 0x2C8
	Size: 0x444
	Parameters: 7
	Flags: None
*/
function player_hacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"player_hacking_callback");
	player = self;
	if(isdefined(level.hackingsoundid[localclientnum]))
	{
		player stoploopsound(level.hackingsoundid[localclientnum]);
		level.hackingsoundid[localclientnum] = undefined;
	}
	if(isdefined(level.hackingsweetspotid[localclientnum]))
	{
		player stoploopsound(level.hackingsweetspotid[localclientnum]);
		level.hackingsweetspotid[localclientnum] = undefined;
	}
	if(isdefined(level.friendlyhackingsoundid[localclientnum]))
	{
		player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
		level.friendlyhackingsoundid[localclientnum] = undefined;
	}
	if(isdefined(player.targetent))
	{
		player.targetent duplicate_render::set_hacker_tool_hacking(localclientnum, 0);
		player.targetent duplicate_render::set_hacker_tool_breaching(localclientnum, 0);
		player.targetent.isbreachingfirewall = 0;
		player.targetent = undefined;
	}
	if(newval == 2)
	{
		player thread watchhackspeed(localclientnum, 0);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 2);
	}
	else if(newval == 3)
	{
		player thread watchhackspeed(localclientnum, 1);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 1);
	}
	else if(newval == 1)
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), 0);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), "0 0 0 0");
		self thread watchforemp(localclientnum);
	}
	else
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), 0);
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), "0 0 0 0");
	}
}

/*
	Name: watchhackspeed
	Namespace: hacker_tool
	Checksum: 0xB636748B
	Offset: 0x718
	Size: 0xBC
	Parameters: 2
	Flags: None
*/
function watchhackspeed(localclientnum, isbreachingfirewall)
{
	self endon(#"death");
	self endon(#"player_hacking_callback");
	player = self;
	for(;;)
	{
		targetentarray = self gettargetlockentityarray();
		if(targetentarray.size > 0)
		{
			targetent = targetentarray[0];
			break;
		}
		wait(0.02);
	}
	targetent watchtargethack(localclientnum, player, isbreachingfirewall);
}

/*
	Name: watchtargethack
	Namespace: hacker_tool
	Checksum: 0xF45D6E4F
	Offset: 0x7E0
	Size: 0x450
	Parameters: 3
	Flags: None
*/
function watchtargethack(localclientnum, player, isbreachingfirewall)
{
	self endon(#"death");
	player endon(#"death");
	self endon(#"player_hacking_callback");
	targetent = self;
	player.targetent = targetent;
	if(isbreachingfirewall)
	{
		targetent.isbreachingfirewall = 1;
		targetent duplicate_render::set_hacker_tool_breaching(localclientnum, 1);
	}
	targetent thread watchhackerplayershutdown(localclientnum, player, targetent);
	for(;;)
	{
		distancefromcenter = targetent getdistancefromscreencenter(localclientnum);
		inverse = 40 - distancefromcenter;
		ratio = inverse / 40;
		heatval = getweaponhackratio(localclientnum);
		ratio = ratio * ratio * ratio * ratio;
		if(ratio > 1 || ratio < 0.001)
		{
			ratio = 0;
			horizontal = 0;
		}
		else
		{
			horizontal = targetent gethorizontaloffsetfromscreencenter(localclientnum, 40);
		}
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.offsetShaderValue"), horizontal + " " + ratio + " 0 0");
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.perc"), heatval);
		if(ratio > 0.8)
		{
			if(!isdefined(level.hackingsweetspotid[localclientnum]))
			{
				level.hackingsweetspotid[localclientnum] = player playloopsound(#"evt_hacker_hacking_sweet");
			}
		}
		else if(isdefined(level.hackingsweetspotid[localclientnum]))
		{
			player stoploopsound(level.hackingsweetspotid[localclientnum]);
			level.hackingsweetspotid[localclientnum] = undefined;
		}
		if(!isdefined(level.hackingsoundid[localclientnum]))
		{
			level.hackingsoundid[localclientnum] = player playloopsound(#"evt_hacker_hacking_loop");
		}
		if(isdefined(level.hackingsoundid[localclientnum]))
		{
			setsoundpitch(level.hackingsoundid[localclientnum], ratio);
		}
		if(!isbreachingfirewall)
		{
			friendlyhacking = weaponfriendlyhacking(localclientnum);
			if(friendlyhacking && !isdefined(level.friendlyhackingsoundid[localclientnum]))
			{
				level.friendlyhackingsoundid[localclientnum] = player playloopsound(#"evt_hacker_hacking_loop_mult");
			}
			else if(!friendlyhacking && isdefined(level.friendlyhackingsoundid[localclientnum]))
			{
				player stoploopsound(level.friendlyhackingsoundid[localclientnum]);
				level.friendlyhackingsoundid[localclientnum] = undefined;
			}
		}
		wait(0.1);
	}
}

/*
	Name: watchhackerplayershutdown
	Namespace: hacker_tool
	Checksum: 0xE9514677
	Offset: 0xC38
	Size: 0xBC
	Parameters: 3
	Flags: None
*/
function watchhackerplayershutdown(localclientnum, hackerplayer, targetent)
{
	self endon(#"death");
	killstreakentity = self;
	hackerplayer endon(#"player_hacking_callback");
	hackerplayer waittill(#"death");
	if(isdefined(targetent))
	{
		targetent.isbreachingfirewall = 1;
	}
	killstreakentity duplicate_render::set_hacker_tool_hacking(localclientnum, 0);
	killstreakentity duplicate_render::set_hacker_tool_breaching(localclientnum, 0);
}

/*
	Name: watchforemp
	Namespace: hacker_tool
	Checksum: 0x771D65BF
	Offset: 0xD00
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function watchforemp(localclientnum)
{
	self endon(#"death");
	self endon(#"player_hacking_callback");
	while(true)
	{
		if(self isempjammed())
		{
			setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 3);
		}
		else
		{
			setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.blackhat.status"), 0);
		}
		wait(0.1);
	}
}

