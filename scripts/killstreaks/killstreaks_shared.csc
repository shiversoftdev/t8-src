// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace killstreaks;

/*
	Name: init_shared
	Namespace: killstreaks
	Checksum: 0xD6408E03
	Offset: 0x180
	Size: 0x1FE
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("clientuimodel", "locSel.commandMode", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "locSel.snapTo", 1, 1, "int", undefined, 0, 0);
	clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
	clientfield::register("toplayer", "thermal_glow", 1, 1, "int", &function_6d265b7f, 0, 1);
	clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int", &function_c66f053, 0, 1);
	clientfield::register("allplayers", "killstreak_spawn_protection", 1, 1, "int", &function_77515127, 0, 0);
	callback::on_spawned(&on_player_spawned);
	callback::function_17381fe(&function_17381fe);
	level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
}

/*
	Name: timeout_beep
	Namespace: killstreaks
	Checksum: 0x531F3A32
	Offset: 0x388
	Size: 0x232
	Parameters: 7
	Flags: None
*/
function timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"timeout_beep");
	if(!newval)
	{
		return;
	}
	if(isdefined(self.killstreakbundle))
	{
		beepalias = self.killstreakbundle.kstimeoutbeepalias;
	}
	else if(isdefined(self.settingsbundle))
	{
		beepalias = self.settingsbundle.kstimeoutbeepalias;
		var_4f5f9e46 = self.settingsbundle.var_90af4f48;
	}
	self endon(#"death");
	self endon(#"timeout_beep");
	interval = 1;
	if(newval == 2)
	{
		interval = 0.133;
	}
	while(true)
	{
		if(isdefined(beepalias))
		{
			var_91e09a3a = 1;
			if(var_4f5f9e46 === 1)
			{
				driver = self getlocalclientdriver();
				if(!isdefined(driver))
				{
					var_91e09a3a = 0;
				}
			}
			if(var_91e09a3a)
			{
				self playsound(localclientnum, beepalias);
			}
		}
		if(self.timeoutlightsoff === 1)
		{
			self vehicle::lights_on(localclientnum);
			self.timeoutlightsoff = 0;
		}
		else
		{
			self vehicle::lights_off(localclientnum);
			self.timeoutlightsoff = 1;
		}
		util::server_wait(localclientnum, interval);
		interval = math::clamp(interval / 1.17, 0.1, 1);
	}
}

/*
	Name: function_6d265b7f
	Namespace: killstreaks
	Checksum: 0x4CF5619D
	Offset: 0x5C8
	Size: 0x100
	Parameters: 7
	Flags: None
*/
function function_6d265b7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	players = getplayers(localclientnum);
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		player renderoverridebundle::function_f4eab437(localclientnum, newval, #"hash_2c6fce4151016478", &function_429c452);
	}
}

/*
	Name: function_c66f053
	Namespace: killstreaks
	Checksum: 0xE0FCB5B9
	Offset: 0x6D0
	Size: 0x138
	Parameters: 7
	Flags: None
*/
function function_c66f053(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	local_player = self;
	var_c86e6ba8 = self.team;
	players = getplayers(localclientnum);
	should_play = newval == 1;
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		player renderoverridebundle::function_f4eab437(localclientnum, should_play, #"hash_53798044d9a468d7", &function_e56218ab);
	}
}

/*
	Name: function_429c452
	Namespace: killstreaks
	Checksum: 0x28575B15
	Offset: 0x810
	Size: 0x126
	Parameters: 2
	Flags: None
*/
function function_429c452(localclientnum, should_play)
{
	if(!should_play)
	{
		return 0;
	}
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isplayer(self))
	{
		return should_play;
	}
	localplayer = function_5c10bd79(localclientnum);
	if(isdefined(localplayer) && !localplayer util::isenemyteam(self.team))
	{
		return 0;
	}
	if(!function_266be0d4(localclientnum))
	{
		return 0;
	}
	if(self hasperk(localclientnum, #"specialty_nokillstreakreticle"))
	{
		return 0;
	}
	if(self clientfield::get("killstreak_spawn_protection"))
	{
		return 0;
	}
	if(shoutcaster::function_2e6e4ee0(localclientnum))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e56218ab
	Namespace: killstreaks
	Checksum: 0x902D7E62
	Offset: 0x940
	Size: 0x11E
	Parameters: 2
	Flags: None
*/
function function_e56218ab(localclientnum, should_play)
{
	if(!should_play)
	{
		return 0;
	}
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isplayer(self))
	{
		return should_play;
	}
	localplayer = function_5c10bd79(localclientnum);
	if(isdefined(localplayer) && localplayer.team == self.team)
	{
		return 0;
	}
	if(!function_266be0d4(localclientnum))
	{
		return 0;
	}
	if(self hasperk(localclientnum, #"specialty_nokillstreakreticle"))
	{
		return 0;
	}
	if(self clientfield::get("killstreak_spawn_protection"))
	{
		return 0;
	}
	if(shoutcaster::function_2e6e4ee0(localclientnum))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_77515127
	Namespace: killstreaks
	Checksum: 0x5DF9FB25
	Offset: 0xA68
	Size: 0xBC
	Parameters: 7
	Flags: None
*/
function function_77515127(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread renderoverridebundle::function_ee77bff9(localclientnum, "thermal_glow", #"hash_2c6fce4151016478", &function_429c452);
	self thread renderoverridebundle::function_ee77bff9(localclientnum, "thermal_glow_enemies_only", #"hash_53798044d9a468d7", &function_e56218ab);
}

/*
	Name: on_player_spawned
	Namespace: killstreaks
	Checksum: 0x23314BC7
	Offset: 0xB30
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function on_player_spawned(localclientnum)
{
	self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
	self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_53798044d9a468d7");
}

/*
	Name: function_17381fe
	Namespace: killstreaks
	Checksum: 0xFD426CF9
	Offset: 0xB98
	Size: 0xE0
	Parameters: 1
	Flags: None
*/
function function_17381fe(localclientnum)
{
	if(shoutcaster::function_2e6e4ee0(localclientnum))
	{
		foreach(player in getplayers(localclientnum))
		{
			if(isdefined(player) && !function_3132f113(player))
			{
				player renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
			}
		}
	}
}

