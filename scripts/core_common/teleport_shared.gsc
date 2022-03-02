// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace teleport;

/*
	Name: team
	Namespace: teleport
	Checksum: 0x7185F304
	Offset: 0xE8
	Size: 0x320
	Parameters: 3
	Flags: Linked
*/
function team(kvp, var_dad37549, var_b095575e = 0)
{
	level function_1d2a3300();
	var_bac46abd = self function_166effac(kvp, var_dad37549);
	if(!isdefined(var_bac46abd))
	{
		return 0;
	}
	if(var_bac46abd.var_d7586d.size < level.players.size)
	{
		/#
			assertmsg("");
		#/
		return undefined;
	}
	foreach(e_player in level.players)
	{
		foreach(s_teleport in var_bac46abd.var_d7586d)
		{
			if(!(isdefined(s_teleport.b_used) && s_teleport.b_used))
			{
				e_player function_29305761(s_teleport, var_bac46abd.var_dad37549, var_b095575e);
				break;
			}
		}
	}
	if(isdefined(level.heroes))
	{
		foreach(ai_hero in level.heroes)
		{
			foreach(s_teleport in var_bac46abd.var_10b2deb1)
			{
				if(isdefined(s_teleport.var_f7486b69) && s_teleport.var_f7486b69 != ai_hero.targetname)
				{
					continue;
				}
				if(!(isdefined(s_teleport.b_used) && s_teleport.b_used))
				{
					ai_hero function_df1911b9(s_teleport, var_bac46abd.var_dad37549);
					break;
				}
			}
		}
	}
	function_ff8a7a3(kvp);
	return 1;
}

/*
	Name: player
	Namespace: teleport
	Checksum: 0x8ADA59BA
	Offset: 0x410
	Size: 0x178
	Parameters: 4
	Flags: Linked
*/
function player(e_player, kvp, var_dad37549, var_b095575e = 0)
{
	if(!isalive(e_player))
	{
		return;
	}
	level function_1d2a3300();
	var_20212d26 = self function_e6615993(kvp, var_dad37549);
	str_key = var_20212d26.str_key;
	str_value = var_20212d26.str_value;
	foreach(s_teleport in level.var_d941f923)
	{
		if(s_teleport.(str_key) === str_value && (!(isdefined(s_teleport.b_used) && s_teleport.b_used)))
		{
			e_player function_29305761(s_teleport, var_20212d26.var_dad37549, var_b095575e);
			return true;
		}
	}
	return false;
}

/*
	Name: hero
	Namespace: teleport
	Checksum: 0x265AAEF1
	Offset: 0x590
	Size: 0x180
	Parameters: 3
	Flags: Linked
*/
function hero(ai_hero, kvp, var_dad37549)
{
	level function_1d2a3300();
	var_20212d26 = self function_e6615993(kvp, var_dad37549);
	str_key = var_20212d26.str_key;
	str_value = var_20212d26.str_value;
	foreach(s_teleport in level.var_c89d2304)
	{
		if(isdefined(s_teleport.var_f7486b69) && s_teleport.var_f7486b69 != ai_hero.targetname)
		{
			continue;
		}
		if(s_teleport.(str_key) === str_value && (!(isdefined(s_teleport.b_used) && s_teleport.b_used)))
		{
			ai_hero function_df1911b9(s_teleport, var_20212d26.var_dad37549);
			return true;
		}
	}
	return false;
}

/*
	Name: function_ff8a7a3
	Namespace: teleport
	Checksum: 0xFC61C87E
	Offset: 0x718
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_ff8a7a3(kvp)
{
	var_20212d26 = self function_e6615993(kvp);
	foreach(s_teleport in struct::get_array(var_20212d26.str_value, var_20212d26.str_key))
	{
		s_teleport.b_used = undefined;
	}
}

/*
	Name: function_1d2a3300
	Namespace: teleport
	Checksum: 0x75988E72
	Offset: 0x7D8
	Size: 0x86
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1d2a3300()
{
	if(!isdefined(level.var_d941f923))
	{
		if(!isdefined(level.var_d941f923))
		{
			level.var_d941f923 = struct::get_array("teleport_player", "variantname");
		}
		if(!isdefined(level.var_c89d2304))
		{
			level.var_c89d2304 = struct::get_array("teleport_hero", "variantname");
		}
	}
}

/*
	Name: function_e6615993
	Namespace: teleport
	Checksum: 0x60D8B39F
	Offset: 0x868
	Size: 0x13C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e6615993(kvp, var_dad37549)
{
	if(isdefined(self.script_teleport_location))
	{
		str_value = self.script_teleport_location;
		str_key = "script_teleport_location";
		if(!isdefined(var_dad37549) && isdefined(self.var_3e93c0f9))
		{
			var_dad37549 = self.var_3e93c0f9;
		}
	}
	else
	{
		if(isdefined(kvp) && isarray(kvp))
		{
			str_value = kvp[0];
			str_key = kvp[1];
		}
		else
		{
			str_value = kvp;
			str_key = "script_teleport_location";
		}
	}
	if(!isdefined(var_dad37549))
	{
		var_dad37549 = 0;
	}
	if(!isdefined(str_value) || !isdefined(str_key))
	{
		/#
			assertmsg("");
		#/
		return undefined;
	}
	return {#hash_dad37549:var_dad37549, #str_key:str_key, #str_value:str_value};
}

/*
	Name: function_166effac
	Namespace: teleport
	Checksum: 0x6345B43
	Offset: 0x9B0
	Size: 0x2D4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_166effac(kvp, var_dad37549)
{
	var_20212d26 = self function_e6615993(kvp, var_dad37549);
	if(!isdefined(var_20212d26))
	{
		return undefined;
	}
	str_key = var_20212d26.str_key;
	str_value = var_20212d26.str_value;
	var_d7586d = [];
	foreach(s_teleport_player in level.var_d941f923)
	{
		if(s_teleport_player.(str_key) === str_value)
		{
			if(!isdefined(var_d7586d))
			{
				var_d7586d = [];
			}
			else if(!isarray(var_d7586d))
			{
				var_d7586d = array(var_d7586d);
			}
			if(!isinarray(var_d7586d, s_teleport_player))
			{
				var_d7586d[var_d7586d.size] = s_teleport_player;
			}
		}
	}
	var_10b2deb1 = [];
	if(isdefined(level.heroes))
	{
		foreach(s_teleport_hero in level.var_c89d2304)
		{
			if(s_teleport_hero.(str_key) === str_value)
			{
				if(!isdefined(var_10b2deb1))
				{
					var_10b2deb1 = [];
				}
				else if(!isarray(var_10b2deb1))
				{
					var_10b2deb1 = array(var_10b2deb1);
				}
				if(!isinarray(var_10b2deb1, s_teleport_hero))
				{
					var_10b2deb1[var_10b2deb1.size] = s_teleport_hero;
				}
			}
		}
		if(var_10b2deb1.size < level.heroes.size)
		{
			/#
				assertmsg("");
			#/
			return undefined;
		}
	}
	return {#hash_dad37549:var_20212d26.var_dad37549, #hash_10b2deb1:var_10b2deb1, #hash_d7586d:var_d7586d};
}

/*
	Name: function_29305761
	Namespace: teleport
	Checksum: 0x9DF6F8D8
	Offset: 0xC90
	Size: 0x22E
	Parameters: 3
	Flags: Linked, Private
*/
function private function_29305761(s_teleport, var_dad37549, var_b095575e = 0)
{
	self endon(#"death");
	if(distancesquared(s_teleport.origin, self.origin) < var_dad37549 * var_dad37549)
	{
		return;
	}
	s_teleport.b_used = 1;
	if(!var_b095575e)
	{
		self thread lui::screen_flash(0, 0.3, 0.3);
	}
	if(self isinvehicle())
	{
		vehicle = self getvehicleoccupied();
		if(isdefined(s_teleport.var_ae20ad9b) && s_teleport.var_ae20ad9b)
		{
			vehicle.origin = s_teleport.origin;
			vehicle.angles = s_teleport.angles;
			self notify(#"teleported");
			vehicle notify(#"teleported");
			return;
		}
		vehicle makevehicleunusable();
	}
	if(isdefined(self._scene_object))
	{
		[[ self._scene_object ]]->stop();
	}
	else if(self isplayinganimscripted())
	{
		self animation::stop();
	}
	self setorigin(s_teleport.origin);
	self setplayerangles(s_teleport.angles);
	if(isdefined(vehicle))
	{
		vehicle thread util::auto_delete();
	}
	self notify(#"teleported");
}

/*
	Name: function_df1911b9
	Namespace: teleport
	Checksum: 0x41C9A797
	Offset: 0xEC8
	Size: 0x116
	Parameters: 2
	Flags: Linked
*/
function function_df1911b9(s_teleport, var_dad37549)
{
	if(distancesquared(s_teleport.origin, self.origin) < var_dad37549 * var_dad37549)
	{
		return;
	}
	s_teleport.b_used = 1;
	self forceteleport(s_teleport.origin, s_teleport.angles);
	if(isdefined(s_teleport.target))
	{
		node = getnode(s_teleport.target, "targetname");
	}
	if(isdefined(node))
	{
		self setgoal(node);
	}
	else
	{
		self setgoal(s_teleport.origin);
	}
	self notify(#"teleported");
}

