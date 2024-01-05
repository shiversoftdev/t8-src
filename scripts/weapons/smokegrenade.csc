// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\player\player_stats.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\sound_shared.csc;

#namespace smokegrenade;

/*
	Name: init_shared
	Namespace: smokegrenade
	Checksum: 0x46E804F1
	Offset: 0x138
	Size: 0x196
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int", &insmoke, 0, 0);
	clientfield::register("scriptmover", "smoke_state", 16000, 1, "int", &function_ffbaa2ce, 0, 0);
	clientfield::register("allplayers", "insmoke", 16000, 2, "int", &insmoke, 0, 0);
	renderoverridebundle::function_f72f089c(#"hash_8120ecc0ceec5c6", "rob_mute_smoke_outline", &function_28db726, undefined, undefined, 1);
	renderoverridebundle::function_f72f089c(#"hash_224b6b4d7364dbb5", "rob_mute_smoke_outline_team", &function_62ec0142, undefined, undefined, 1);
	callback::on_localplayer_spawned(&on_local_player_spawned);
	level.var_7cc76271 = &vehicle_transition;
}

/*
	Name: on_local_player_spawned
	Namespace: smokegrenade
	Checksum: 0x46196D20
	Offset: 0x2D8
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function on_local_player_spawned(local_client_num)
{
	thread function_e69d0e4d(local_client_num);
	thread track_grenades(local_client_num);
	players = getplayers(local_client_num);
	foreach(player in players)
	{
		if(isdefined(player) && isalive(player))
		{
			player function_4fc900e1(local_client_num);
		}
	}
}

/*
	Name: track_grenades
	Namespace: smokegrenade
	Checksum: 0x2CDA032F
	Offset: 0x3D8
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function track_grenades(local_client_num)
{
	self notify(#"track_grenades");
	self endon(#"track_grenades", #"death", #"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"grenade_fire");
	grenade = waitresult.projectile;
	weapon = waitresult.weapon;
}

/*
	Name: function_709fad19
	Namespace: smokegrenade
	Checksum: 0xAF3504C4
	Offset: 0x488
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function function_709fad19()
{
	weapon = getweapon(#"eq_smoke");
	if(!isdefined(weapon) || weapon == level.weaponnone || !isdefined(weapon.customsettings))
	{
		return 128;
	}
	var_b0b958b3 = getscriptbundle(weapon.customsettings);
	return (isdefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128);
}

/*
	Name: monitor_smoke
	Namespace: smokegrenade
	Checksum: 0x8C96C717
	Offset: 0x548
	Size: 0x258
	Parameters: 1
	Flags: None
*/
function monitor_smoke(local_client_num)
{
	var_d3f60df1 = self;
	self notify(#"monitor_smoke");
	self endon(#"monitor_smoke", #"death", #"delete");
	localplayer = function_5c10bd79(local_client_num);
	if(isdefined(var_d3f60df1) && isdefined(var_d3f60df1.owner) && isdefined(localplayer) && var_d3f60df1.owner != localplayer)
	{
		return;
	}
	radius = function_709fad19();
	while(isdefined(var_d3f60df1))
	{
		waitresult = undefined;
		waitresult = var_d3f60df1 waittilltimeout(0.25, #"death");
		players = getplayers(local_client_num);
		foreach(player in players)
		{
			dist = distance2d(player.origin, var_d3f60df1.origin);
			if(dist < radius)
			{
				if(!isdefined(player.var_d3f60df1))
				{
					player.var_d3f60df1 = var_d3f60df1;
					player function_4fc900e1(local_client_num);
				}
				continue;
			}
			if(isdefined(player.var_d3f60df1))
			{
				player.var_d3f60df1 = undefined;
				player function_4fc900e1(local_client_num);
			}
		}
		if(waitresult._notify != "timeout")
		{
			break;
		}
	}
}

/*
	Name: function_ffbaa2ce
	Namespace: smokegrenade
	Checksum: 0x54B1828A
	Offset: 0x7A8
	Size: 0x138
	Parameters: 7
	Flags: None
*/
function function_ffbaa2ce(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread monitor_smoke(local_client_num);
	}
	else
	{
		self notify(#"monitor_smoke");
		players = getplayers(local_client_num);
		foreach(player in players)
		{
			if(isdefined(player) && isalive(player))
			{
				player.var_d3f60df1 = undefined;
				player function_4fc900e1(local_client_num);
			}
		}
	}
}

/*
	Name: function_e69d0e4d
	Namespace: smokegrenade
	Checksum: 0xF8DF2E37
	Offset: 0x8E8
	Size: 0x1C4
	Parameters: 1
	Flags: None
*/
function function_e69d0e4d(local_client_num)
{
	self notify(#"hash_2286178f49f4601d");
	self endon(#"hash_2286178f49f4601d", #"death", #"disconnect");
	var_e098466f = 0;
	while(true)
	{
		var_7bf0773f = function_7bf0773f(local_client_num);
		if(isdefined(var_e098466f) && var_e098466f && !var_7bf0773f || (!(isdefined(var_e098466f) && var_e098466f) && var_7bf0773f))
		{
			var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
			if(var_85098191)
			{
				players = getplayers(local_client_num);
				foreach(player in players)
				{
					if(isdefined(player) && isalive(player))
					{
						player function_4fc900e1(local_client_num);
					}
				}
			}
			var_e098466f = var_7bf0773f;
		}
		wait(0.25);
	}
}

/*
	Name: function_62ec0142
	Namespace: smokegrenade
	Checksum: 0xBF17B607
	Offset: 0xAB8
	Size: 0x1F8
	Parameters: 2
	Flags: None
*/
function function_62ec0142(local_client_num, bundle)
{
	var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
	if(!var_85098191)
	{
		return false;
	}
	if(util::is_player_view_linked_to_entity(local_client_num))
	{
		return false;
	}
	if(!self function_83973173())
	{
		return false;
	}
	if(function_7bf0773f(local_client_num))
	{
		return false;
	}
	if(!(isdefined(self.insmoke) && self.insmoke & 2))
	{
		return false;
	}
	localplayer = function_5c10bd79(local_client_num);
	if(self == localplayer)
	{
		curweapon = self function_d2c2b168();
		blade = getweapon(#"sig_blade");
		if(!isthirdperson(local_client_num) || curweapon != blade)
		{
			return false;
		}
	}
	weapon = getweapon("eq_smoke");
	if(isdefined(weapon.customsettings))
	{
		var_ed9e87ac = getscriptbundle(weapon.customsettings);
		/#
			assert(isdefined(var_ed9e87ac));
		#/
		if(!(isdefined(var_ed9e87ac.var_563d4859) ? var_ed9e87ac.var_563d4859 : 0))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_28db726
	Namespace: smokegrenade
	Checksum: 0xAF6B344D
	Offset: 0xCB8
	Size: 0x188
	Parameters: 2
	Flags: None
*/
function function_28db726(local_client_num, bundle)
{
	var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
	if(!var_85098191)
	{
		return false;
	}
	if(util::is_player_view_linked_to_entity(local_client_num))
	{
		return false;
	}
	if(self function_83973173())
	{
		return false;
	}
	if(function_7bf0773f(local_client_num))
	{
		return false;
	}
	if(!(isdefined(self.insmoke) && self.insmoke & 1))
	{
		return false;
	}
	weapon = getweapon("eq_smoke");
	if(isdefined(weapon.customsettings))
	{
		var_ed9e87ac = getscriptbundle(weapon.customsettings);
		/#
			assert(isdefined(var_ed9e87ac));
		#/
		if((isdefined(var_ed9e87ac.var_ae2b2941) ? var_ed9e87ac.var_ae2b2941 : 0) && self function_6c32d092(local_client_num, #"talent_coldblooded"))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: vehicle_transition
	Namespace: smokegrenade
	Checksum: 0x22465A25
	Offset: 0xE48
	Size: 0x118
	Parameters: 7
	Flags: None
*/
function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	players = getplayers(local_client_num);
	foreach(player in players)
	{
		if(isalive(player))
		{
			var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
			if(var_85098191)
			{
				player function_4fc900e1(local_client_num);
			}
		}
	}
}

/*
	Name: function_4fc900e1
	Namespace: smokegrenade
	Checksum: 0x4BE34FDC
	Offset: 0xF68
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_4fc900e1(local_client_num)
{
	self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly_smoke", #"hash_8120ecc0ceec5c6");
	self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy_smoke", #"hash_224b6b4d7364dbb5");
}

/*
	Name: insmoke
	Namespace: smokegrenade
	Checksum: 0xB24638C4
	Offset: 0xFF0
	Size: 0xA4
	Parameters: 7
	Flags: None
*/
function insmoke(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = self;
	player.insmoke = newval;
	var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
	if(var_85098191)
	{
		function_4fc900e1(local_client_num);
	}
}

