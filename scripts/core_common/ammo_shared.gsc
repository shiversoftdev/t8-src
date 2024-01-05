// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\throttle_shared.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\player\player_loadout.gsc;
#using script_4c5c4a64a59247a2;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace ammo;

/*
	Name: main
	Namespace: ammo
	Checksum: 0x84B4858B
	Offset: 0xC0
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	if(!isdefined(level.ai_ammo_throttle))
	{
		level.ai_ammo_throttle = new throttle();
		[[ level.ai_ammo_throttle ]]->initialize(1, 0.1);
	}
}

/*
	Name: dropaiammo
	Namespace: ammo
	Checksum: 0x96B40A15
	Offset: 0x118
	Size: 0xF4
	Parameters: 0
	Flags: None
*/
function dropaiammo()
{
	self endon(#"death");
	if(!isdefined(self.ammopouch))
	{
		return;
	}
	if(isdefined(self.disableammodrop) && self.disableammodrop)
	{
		return;
	}
	[[ level.ai_ammo_throttle ]]->waitinqueue(self);
	droppedweapon = shared::throwweapon(self.ammopouch, "tag_stowed_back", 1, 0);
	if(isdefined(droppedweapon))
	{
		droppedweapon thread ammo_pouch_think();
		droppedweapon setcontents(droppedweapon setcontents(0) & (~(((32768 | 67108864) | 8388608) | 33554432)));
	}
}

/*
	Name: ammo_pouch_think
	Namespace: ammo
	Checksum: 0x5AE0E722
	Offset: 0x218
	Size: 0x606
	Parameters: 0
	Flags: None
*/
function ammo_pouch_think()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"scavenger");
	player = waitresult.player;
	primary_weapons = player getweaponslistprimaries();
	offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
	arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
	offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
	player playsound(#"wpn_ammo_pickup");
	player playlocalsound(#"wpn_ammo_pickup");
	if(isdefined(level.b_disable_scavenger_icon) && level.b_disable_scavenger_icon)
	{
		player hud::flash_scavenger_icon();
	}
	for(i = 0; i < offhand_weapons_and_alts.size; i++)
	{
		weapon = offhand_weapons_and_alts[i];
		maxammo = 0;
		loadout = player loadout::find_loadout_slot(weapon);
		if(isdefined(loadout))
		{
			if(loadout.count > 0)
			{
				maxammo = loadout.count;
			}
			else if(weapon.isheavyweapon && (isdefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon))
			{
				maxammo = weapon.maxammo;
			}
		}
		else
		{
			if(weapon == player.grenadetypeprimary && isdefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0)
			{
				maxammo = player.grenadetypeprimarycount;
			}
			else
			{
				if(weapon == player.grenadetypesecondary && isdefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0)
				{
					maxammo = player.grenadetypesecondarycount;
				}
				else if(weapon.isheavyweapon && (isdefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon))
				{
					maxammo = weapon.maxammo;
				}
			}
		}
		if(isdefined(level.customloadoutscavenge))
		{
			maxammo = self [[level.customloadoutscavenge]](weapon);
		}
		if(maxammo == 0)
		{
			continue;
		}
		if(weapon.rootweapon == level.weaponsatchelcharge)
		{
			if(player weaponobjects::anyobjectsinworld(weapon.rootweapon))
			{
				continue;
			}
		}
		stock = player getweaponammostock(weapon);
		if(weapon.isheavyweapon && (isdefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon))
		{
			ammo = stock + weapon.clipsize;
			if(ammo > maxammo)
			{
				ammo = maxammo;
			}
			player setweaponammostock(weapon, ammo);
			player.scavenged = 1;
			continue;
		}
		if(stock < maxammo)
		{
			ammo = stock + 1;
			if(ammo > maxammo)
			{
				ammo = maxammo;
			}
			else if(isdefined(loadout))
			{
				if("primarygrenade" == player loadout::function_8435f729(weapon))
				{
					player notify(#"scavenged_primary_grenade");
				}
			}
			player setweaponammostock(weapon, ammo);
			player.scavenged = 1;
		}
	}
	for(i = 0; i < primary_weapons.size; i++)
	{
		weapon = primary_weapons[i];
		stock = player getweaponammostock(weapon);
		start = player getfractionstartammo(weapon);
		clip = weapon.clipsize;
		clip = clip * getdvarfloat(#"scavenger_clip_multiplier", 1);
		clip = int(clip);
		maxammo = weapon.maxammo;
		if(stock < maxammo - (clip * 3))
		{
			ammo = stock + (clip * 3);
			player setweaponammostock(weapon, ammo);
			continue;
		}
		player setweaponammostock(weapon, maxammo);
	}
}

