// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace proximity_grenade;

/*
	Name: init_shared
	Namespace: proximity_grenade
	Checksum: 0x80B55558
	Offset: 0xD0
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	clientfield::register("toplayer", "tazered", 1, 1, "int", undefined, 0, 0);
	level._effect[#"prox_grenade_friendly_default"] = #"weapon/fx_prox_grenade_scan_blue";
	level._effect[#"prox_grenade_friendly_warning"] = #"weapon/fx_prox_grenade_wrn_grn";
	level._effect[#"prox_grenade_enemy_default"] = #"weapon/fx_prox_grenade_scan_orng";
	level._effect[#"prox_grenade_enemy_warning"] = #"weapon/fx_prox_grenade_wrn_red";
	level._effect[#"prox_grenade_player_shock"] = #"weapon/fx_prox_grenade_impact_player_spwner";
	callback::add_weapon_type(#"proximity_grenade", &proximity_spawned);
	level thread watchforproximityexplosion();
}

/*
	Name: proximity_spawned
	Namespace: proximity_grenade
	Checksum: 0x2681B617
	Offset: 0x250
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function proximity_spawned(localclientnum)
{
	if(self isgrenadedud())
	{
		return;
	}
	self.equipmentfriendfx = level._effect[#"prox_grenade_friendly_default"];
	self.equipmentenemyfx = level._effect[#"prox_grenade_enemy_default"];
	self.equipmenttagfx = "tag_fx";
	self thread weaponobjects::equipmentteamobject(localclientnum);
}

/*
	Name: watchforproximityexplosion
	Namespace: proximity_grenade
	Checksum: 0x29B6ADFC
	Offset: 0x2E8
	Size: 0x1C0
	Parameters: 0
	Flags: Linked
*/
function watchforproximityexplosion()
{
	if(getactivelocalclients() > 1)
	{
		return;
	}
	weapon_proximity = getweapon(#"proximity_grenade");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"explode");
		weapon = waitresult.weapon;
		owner_cent = waitresult.owner_cent;
		position = waitresult.position;
		localclientnum = waitresult.localclientnum;
		if(weapon.rootweapon != weapon_proximity)
		{
			continue;
		}
		if(!util::is_player_view_linked_to_entity(localclientnum))
		{
			explosionradius = weapon.explosionradius;
			localplayer = function_5c10bd79(localclientnum);
			if(distancesquared(localplayer.origin, position) < explosionradius * explosionradius)
			{
				if(isdefined(owner_cent))
				{
					if(owner_cent function_21c0fa55() || !owner_cent function_83973173())
					{
						localplayer thread postfx::playpostfxbundle("pstfx_shock_charge");
					}
				}
			}
		}
	}
}

