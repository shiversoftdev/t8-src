// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace ballistic_knife;

/*
	Name: init_shared
	Namespace: ballistic_knife
	Checksum: 0x412E7E73
	Offset: 0xC8
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	level.var_f676fe5a = #"hash_4b7ed37163f1ec57";
	weaponobjects::function_e6400478(#"special_ballisticknife_t8_dw", &createballisticknifewatcher, 0);
	weaponobjects::function_e6400478(#"special_ballisticknife_t8_dw_dw", &createballisticknifewatcher, 0);
	weaponobjects::function_e6400478(#"hash_4646a4e86c781e84", &createballisticknifewatcher, 0);
	weaponobjects::function_e6400478(#"special_crossbow_t8", &createballisticknifewatcher, 0);
	weaponobjects::function_dcc8b5d5(#"special_crossbow_t8", "pistolscope", #"hash_6c40a7a156b05224");
	weaponobjects::function_e6400478(#"hash_6c40a7a156b05224", &createballisticknifewatcher, 0);
	if(isdefined(level.var_b68902c4) && level.var_b68902c4)
	{
		weaponobjects::function_e6400478(#"special_ballisticknife_t8_dw_upgraded", &createballisticknifewatcher, 0);
		weaponobjects::function_e6400478(#"special_ballisticknife_t8_dw_upgraded_dw", &createballisticknifewatcher, 0);
		weaponobjects::function_e6400478(#"hash_176b8e0e47a43cb9", &createballisticknifewatcher, 0);
		weaponobjects::function_e6400478(#"special_crossbow_t8_upgraded", &createballisticknifewatcher, 0);
		weaponobjects::function_dcc8b5d5(#"special_crossbow_t8_upgraded", "pistolscope", #"hash_73258bb36ebe26d");
		weaponobjects::function_e6400478(#"hash_73258bb36ebe26d", &createballisticknifewatcher, 0);
	}
}

/*
	Name: onspawn
	Namespace: ballistic_knife
	Checksum: 0xF5E67597
	Offset: 0x368
	Size: 0x3F8
	Parameters: 2
	Flags: Linked
*/
function onspawn(watcher, player)
{
	player endon(#"death", #"disconnect");
	level endon(#"game_ended");
	waitresult = undefined;
	waitresult = self waittill(#"stationary", #"death");
	if(!isdefined(self))
	{
		return;
	}
	endpos = waitresult.position;
	normal = waitresult.normal;
	angles = waitresult.direction;
	attacker = waitresult.attacker;
	prey = waitresult.target;
	bone = waitresult.bone_name;
	isfriendly = 0;
	if(isdefined(endpos))
	{
		retrievable_model = spawn("script_model", endpos);
		retrievable_model setmodel(watcher.weapon.projectilemodel);
		retrievable_model setteam(player.team);
		retrievable_model setowner(player);
		retrievable_model.owner = player;
		retrievable_model.angles = angles;
		retrievable_model.name = watcher.weapon;
		retrievable_model.weapon = watcher.weapon;
		retrievable_model.targetname = "sticky_weapon";
		if(isdefined(prey))
		{
			retrievable_model.prey = prey;
			if(level.teambased && player.team == prey.team)
			{
				isfriendly = 1;
			}
			if(!isfriendly)
			{
				if(isalive(prey) || !isdefined(prey gettagorigin(bone)))
				{
					retrievable_model droptoground(retrievable_model.origin, 80);
				}
				else
				{
					retrievable_model linkto(prey, bone);
				}
			}
			else if(isfriendly)
			{
				retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
				normal = (0, 0, 1);
			}
		}
		retrievable_model.normal = normal;
		watcher.objectarray[watcher.objectarray.size] = retrievable_model;
		if(isfriendly)
		{
			retrievable_model waittill(#"stationary");
		}
		if(!isdefined(retrievable_model))
		{
			return;
		}
		retrievable_model thread dropknivestoground();
		player notify(#"ballistic_knife_stationary", {#retrievable_model:retrievable_model});
	}
}

/*
	Name: onspawnretrievetrigger
	Namespace: ballistic_knife
	Checksum: 0x579F566B
	Offset: 0x768
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function onspawnretrievetrigger(watcher, player)
{
	player endon(#"death");
	player endon(#"disconnect");
	level endon(#"game_ended");
	waitresult = undefined;
	waitresult = player waittill(#"ballistic_knife_stationary");
	retrievable_model = waitresult.retrievable_model;
	if(!isdefined(retrievable_model))
	{
		return;
	}
	normal = retrievable_model.normal;
	prey = retrievable_model.prey;
	vec_scale = 10;
	trigger_pos = (0, 0, 0);
	if(isdefined(prey) && (isplayer(prey) || isai(prey)))
	{
		trigger_pos = prey.origin + (0, 0, vec_scale);
	}
	else
	{
		trigger_pos = retrievable_model.origin + (vec_scale * normal);
	}
	retrievable_model clientfield::set("retrievable", 1);
	retrievable_model clientfield::set("enemyequip", 1);
	retrievable_model weaponobjects::function_57152a5(watcher, player, trigger_pos);
	retrievable_model.pickuptrigger enablelinkto();
	if(isdefined(prey))
	{
		retrievable_model.pickuptrigger linkto(prey);
	}
	else
	{
		retrievable_model.pickuptrigger linkto(retrievable_model);
	}
	retrievable_model thread weaponobjects::watchshutdown(player);
}

/*
	Name: onpickup
	Namespace: ballistic_knife
	Checksum: 0x903154E0
	Offset: 0x9B0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function onpickup(player, heldweapon)
{
	self weaponobjects::function_db70257(player, heldweapon);
	self delete();
}

/*
	Name: destroy_ent
	Namespace: ballistic_knife
	Checksum: 0x7CC095D3
	Offset: 0xA00
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function destroy_ent()
{
	if(isdefined(self))
	{
		pickuptrigger = self.pickuptrigger;
		if(isdefined(pickuptrigger))
		{
			pickuptrigger delete();
		}
		self delete();
	}
}

/*
	Name: dropknivestoground
	Namespace: ballistic_knife
	Checksum: 0x2DA8AFFD
	Offset: 0xA60
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function dropknivestoground()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = level waittill(#"drop_objects_to_ground");
		self droptoground(waitresult.position, waitresult.radius);
	}
}

/*
	Name: droptoground
	Namespace: ballistic_knife
	Checksum: 0x829762EC
	Offset: 0xAD8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function droptoground(origin, radius)
{
	if(distancesquared(origin, self.origin) < radius * radius)
	{
		self physicslaunch((0, 0, 1), vectorscale((1, 1, 1), 5));
		self thread updateretrievetrigger();
	}
}

/*
	Name: updateretrievetrigger
	Namespace: ballistic_knife
	Checksum: 0x2EE8B365
	Offset: 0xB60
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function updateretrievetrigger()
{
	self endon(#"death");
	self waittill(#"stationary");
	trigger = self.pickuptrigger;
	if(isdefined(trigger))
	{
		trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
		trigger linkto(self);
	}
}

/*
	Name: onfizzleout
	Namespace: ballistic_knife
	Checksum: 0x7EA1606B
	Offset: 0xC08
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function onfizzleout()
{
	self endon(#"death");
	playfx(level.var_f676fe5a, self.origin);
	self delete();
}

/*
	Name: createballisticknifewatcher
	Namespace: ballistic_knife
	Checksum: 0xCF06188F
	Offset: 0xC68
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function createballisticknifewatcher(watcher)
{
	watcher.onspawn = &onspawn;
	watcher.pickup = &onpickup;
	watcher.onfizzleout = &onfizzleout;
	watcher.ondetonatecallback = &weaponobjects::deleteent;
	watcher.onspawnretrievetriggers = &onspawnretrievetrigger;
	watcher.storedifferentobject = 1;
}

