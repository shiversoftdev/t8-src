// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3371dd5958d2f84f;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\struct.gsc;

#namespace pickup_ammo;

/*
	Name: function_cff1656d
	Namespace: pickup_ammo
	Checksum: 0x316BED42
	Offset: 0xF0
	Size: 0x24A
	Parameters: 0
	Flags: None
*/
function function_cff1656d()
{
	var_c2c1c043 = getentarray("pickup_ammo", "targetname");
	foreach(pickup in var_c2c1c043)
	{
		pickup.trigger = spawn("trigger_radius_use", pickup.origin + vectorscale((0, 0, 1), 15), 0, 120, 100);
		pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
		pickup.trigger triggerignoreteam();
		pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], vectorscale((0, 0, 1), 60), "pickup_ammo");
		pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
		pickup.gameobject gameobjects::set_visible_team(#"any");
		pickup.gameobject gameobjects::allow_use(#"any");
		pickup.gameobject gameobjects::set_use_time(0);
		pickup.gameobject.usecount = 0;
		pickup.gameobject.var_5ecd70 = pickup;
		pickup.gameobject.onuse = &function_5bb13b48;
	}
}

/*
	Name: function_4827d817
	Namespace: pickup_ammo
	Checksum: 0x4270FEA7
	Offset: 0x348
	Size: 0x380
	Parameters: 1
	Flags: None
*/
function function_4827d817(weapon)
{
	if(weapon.maxammo <= 0)
	{
		return 0;
	}
	package = struct::get_script_bundle("bountyhunterpackage", level.var_a9f35be1[0]);
	slot = undefined;
	if(isdefined(self.pers[#"hash_50251e63e4a703b5"].weapons[0]) && self.pers[#"hash_50251e63e4a703b5"].weapons[0].name == weapon.name)
	{
		slot = 0;
	}
	else if(isdefined(self.pers[#"hash_50251e63e4a703b5"].weapons[1]) && self.pers[#"hash_50251e63e4a703b5"].weapons[1].name == weapon.name)
	{
		slot = 1;
	}
	if(!isdefined(slot))
	{
		return 0;
	}
	var_f3e0cb57 = self.pers[#"hash_50251e63e4a703b5"].clientfields[slot].val - 1;
	package = struct::get_script_bundle("bountyhunterpackage", level.var_a9f35be1[var_f3e0cb57]);
	var_e6e3de63 = package.var_ef921c3c;
	maxammo = package.refillammo;
	if(!isdefined(maxammo) || maxammo == 0)
	{
		maxammo = weapon.maxammo / weapon.clipsize;
		if(weapon.clipsize == 1)
		{
			maxammo = maxammo + 1;
		}
	}
	clipammo = self getweaponammoclip(weapon);
	stockammo = self getweaponammostock(weapon);
	currentammo = (float(clipammo + stockammo)) / weapon.clipsize;
	if(weapon.statname == #"smg_capacity_t8" && weaponhasattachment(weapon, "uber"))
	{
		self setweaponammostock(weapon, weapon.clipsize);
	}
	else if(currentammo >= maxammo)
	{
		return 0;
	}
	currentammo = currentammo + var_e6e3de63;
	if(currentammo > maxammo)
	{
		currentammo = maxammo;
	}
	self setweaponammostock(weapon, (int(currentammo * weapon.clipsize)) - clipammo);
	return 1;
}

/*
	Name: function_5bb13b48
	Namespace: pickup_ammo
	Checksum: 0xF6466BC4
	Offset: 0x6D0
	Size: 0x28C
	Parameters: 1
	Flags: Private
*/
private function function_5bb13b48(player)
{
	if(isdefined(player) && isplayer(player))
	{
		var_bd3d7a99 = 0;
		primaries = player getweaponslistprimaries();
		foreach(weapon in primaries)
		{
			var_f34ce24d = player function_4827d817(weapon);
			if(var_f34ce24d)
			{
				var_bd3d7a99 = 1;
			}
		}
		if(var_bd3d7a99)
		{
			if(isdefined(self.objectiveid))
			{
				objective_setinvisibletoplayer(self.objectiveid, player);
			}
			self.var_5ecd70 setinvisibletoplayer(player);
			self.trigger setinvisibletoplayer(player);
			self playsoundtoplayer(#"hash_587fec4cf4ba3ebb", player);
			self.usecount++;
			player gestures::function_56e00fbf(#"gestable_grab", undefined, 0);
			if(isdefined(level.var_aff59367) && level.var_aff59367)
			{
				self thread function_7a80944d(player);
			}
		}
		else
		{
			player iprintlnbold(#"hash_2ea29b19d0e205e7");
			self playsoundtoplayer(#"hash_7527c43b92789608", player);
		}
	}
	if(!(isdefined(level.var_aff59367) && level.var_aff59367) && self.usecount >= level.var_ad9d03e7)
	{
		self.var_5ecd70 delete();
		self gameobjects::disable_object(1);
	}
}

/*
	Name: function_7a80944d
	Namespace: pickup_ammo
	Checksum: 0xAC05D4D7
	Offset: 0x968
	Size: 0xC4
	Parameters: 1
	Flags: Private
*/
private function function_7a80944d(player)
{
	level endon(#"game_ended");
	self endon(#"death");
	player endon(#"disconnect");
	wait((isdefined(level.var_ca2fc68c) ? level.var_ca2fc68c : 0));
	if(isdefined(self.objectiveid))
	{
		objective_setvisibletoplayer(self.objectiveid, player);
	}
	self.var_5ecd70 setvisibletoplayer(player);
	self.trigger setvisibletoplayer(player);
}

