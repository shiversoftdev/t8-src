// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_8988fdbc78d6c53;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace tacticalinsertion;

/*
	Name: init_shared
	Namespace: tacticalinsertion
	Checksum: 0xA151324A
	Offset: 0x190
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.weapontacticalinsertion = getweapon(#"tactical_insertion");
	level._effect[#"tacticalinsertionfizzle"] = #"_t6/misc/fx_equip_tac_insert_exp";
	clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int");
}

/*
	Name: istacspawntouchingcrates
	Namespace: tacticalinsertion
	Checksum: 0x5A3A4C78
	Offset: 0x228
	Size: 0xD8
	Parameters: 2
	Flags: Linked
*/
function istacspawntouchingcrates(origin, angles)
{
	crate_ents = getentarray("care_package", "script_noteworthy");
	mins = (-17, -17, -40);
	maxs = (17, 17, 40);
	for(i = 0; i < crate_ents.size; i++)
	{
		if(crate_ents[i] istouchingvolume(origin + vectorscale((0, 0, 1), 40), mins, maxs))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: overridespawn
	Namespace: tacticalinsertion
	Checksum: 0xDA7AF148
	Offset: 0x308
	Size: 0x148
	Parameters: 1
	Flags: None
*/
function overridespawn(ispredictedspawn)
{
	if(!isdefined(self.tacticalinsertion))
	{
		return false;
	}
	origin = self.tacticalinsertion.origin;
	angles = self.tacticalinsertion.angles;
	team = self.tacticalinsertion.team;
	if(!ispredictedspawn)
	{
		self.tacticalinsertion destroy_tactical_insertion();
	}
	if(team != self.team)
	{
		return false;
	}
	if(istacspawntouchingcrates(origin))
	{
		return false;
	}
	if(!ispredictedspawn)
	{
		self.tacticalinsertiontime = gettime();
		self spawn(origin, angles, "tactical insertion");
		self setspawnclientflag("SCDFL_DISABLE_LOGGING");
		self stats::function_e24eec31(level.weapontacticalinsertion, #"used", 1);
	}
	return true;
}

/*
	Name: waitanddelete
	Namespace: tacticalinsertion
	Checksum: 0xC11B027D
	Offset: 0x458
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function waitanddelete(time)
{
	self endon(#"death");
	waitframe(1);
	self delete();
}

/*
	Name: watch
	Namespace: tacticalinsertion
	Checksum: 0xF6DF1823
	Offset: 0x4A0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function watch(player)
{
	if(isdefined(player.tacticalinsertion))
	{
		player.tacticalinsertion destroy_tactical_insertion();
	}
	player thread spawntacticalinsertion();
	self waitanddelete(0.05);
}

/*
	Name: watchusetrigger
	Namespace: tacticalinsertion
	Checksum: 0x22A518E6
	Offset: 0x518
	Size: 0x1E0
	Parameters: 4
	Flags: Linked
*/
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse)
{
	self endon(#"delete");
	while(true)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		player = waitresult.activator;
		if(!isalive(player))
		{
			continue;
		}
		if(!player isonground())
		{
			continue;
		}
		if(isdefined(trigger.triggerteam) && player.team != trigger.triggerteam)
		{
			continue;
		}
		if(isdefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore)
		{
			continue;
		}
		if(isdefined(trigger.claimedby) && player != trigger.claimedby)
		{
			continue;
		}
		if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed())
		{
			if(isdefined(playersoundonuse))
			{
				player playlocalsound(playersoundonuse);
			}
			if(isdefined(npcsoundonuse))
			{
				player playsound(npcsoundonuse);
			}
			self thread [[callback]](player);
		}
	}
}

/*
	Name: watchdisconnect
	Namespace: tacticalinsertion
	Checksum: 0x6C7F03BC
	Offset: 0x700
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function watchdisconnect()
{
	self.tacticalinsertion endon(#"delete");
	self waittill(#"disconnect");
	self.tacticalinsertion thread destroy_tactical_insertion();
}

/*
	Name: destroy_tactical_insertion
	Namespace: tacticalinsertion
	Checksum: 0xD13558C7
	Offset: 0x758
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function destroy_tactical_insertion(attacker)
{
	self.owner.tacticalinsertion = undefined;
	self notify(#"delete");
	self.owner notify(#"tactical_insertion_destroyed");
	self.friendlytrigger delete();
	self.enemytrigger delete();
	if(isdefined(attacker) && isdefined(attacker.pers[#"team"]) && isdefined(self.owner) && isdefined(self.owner.pers[#"team"]))
	{
		if(level.teambased)
		{
			if(attacker.pers[#"team"] != self.owner.pers[#"team"])
			{
				attacker notify(#"destroyed_explosive");
				attacker challenges::destroyedequipment();
				attacker challenges::destroyedtacticalinsert();
				scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self.owner, undefined);
			}
		}
		else if(attacker != self.owner)
		{
			attacker notify(#"destroyed_explosive");
			attacker challenges::destroyedequipment();
			attacker challenges::destroyedtacticalinsert();
			scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self.owner, undefined);
		}
	}
	self delete();
}

/*
	Name: fizzle
	Namespace: tacticalinsertion
	Checksum: 0xB4AD2A4E
	Offset: 0x998
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function fizzle(attacker)
{
	if(isdefined(self.fizzle) && self.fizzle)
	{
		return;
	}
	self.fizzle = 1;
	playfx(level._effect[#"tacticalinsertionfizzle"], self.origin);
	self playsound(#"dst_tac_insert_break");
	if(isdefined(attacker) && attacker != self.owner)
	{
		if(isdefined(level.globallogic_audio_dialog_on_player_override))
		{
			self.owner [[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
		}
	}
	self destroy_tactical_insertion(attacker);
}

/*
	Name: pickup
	Namespace: tacticalinsertion
	Checksum: 0x1B6BD20E
	Offset: 0xA90
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function pickup(attacker)
{
	player = self.owner;
	self destroy_tactical_insertion();
	player giveweapon(level.weapontacticalinsertion);
	player setweaponammoclip(level.weapontacticalinsertion, 1);
}

/*
	Name: spawntacticalinsertion
	Namespace: tacticalinsertion
	Checksum: 0x5DFA6685
	Offset: 0xB10
	Size: 0x7D8
	Parameters: 0
	Flags: Linked
*/
function spawntacticalinsertion()
{
	self endon(#"disconnect");
	self.tacticalinsertion = spawn("script_model", self.origin + (0, 0, 1));
	self.tacticalinsertion setmodel(#"t6_wpn_tac_insert_world");
	self.tacticalinsertion.origin = self.origin + (0, 0, 1);
	self.tacticalinsertion.angles = self.angles;
	self.tacticalinsertion.team = self.team;
	self.tacticalinsertion setteam(self.team);
	self.tacticalinsertion.owner = self;
	self.tacticalinsertion setowner(self);
	self.tacticalinsertion setweapon(level.weapontacticalinsertion);
	self.tacticalinsertion thread weaponobjects::setupreconeffect();
	self.tacticalinsertion endon(#"delete");
	if(isdefined(level.var_96ee56b5))
	{
		self.tacticalinsertion [[level.var_96ee56b5]]();
	}
	triggerheight = 64;
	triggerradius = 128;
	self.tacticalinsertion.friendlytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + vectorscale((0, 0, 1), 3));
	self.tacticalinsertion.friendlytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
	self.tacticalinsertion.friendlytrigger sethintstring(#"hash_83435f76ff5897f");
	if(level.teambased)
	{
		self.tacticalinsertion.friendlytrigger setteamfortrigger(self.team);
		self.tacticalinsertion.friendlytrigger.triggerteam = self.team;
	}
	self clientclaimtrigger(self.tacticalinsertion.friendlytrigger);
	self.tacticalinsertion.friendlytrigger.claimedby = self;
	self.tacticalinsertion.enemytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + vectorscale((0, 0, 1), 3));
	self.tacticalinsertion.enemytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
	self.tacticalinsertion.enemytrigger sethintstring(#"hash_225043ec880f05f");
	self.tacticalinsertion.enemytrigger setinvisibletoplayer(self);
	if(level.teambased)
	{
		self.tacticalinsertion.enemytrigger setexcludeteamfortrigger(self.team);
		self.tacticalinsertion.enemytrigger.triggerteamignore = self.team;
	}
	self.tacticalinsertion clientfield::set("tacticalinsertion", 1);
	self thread watchdisconnect();
	watcher = weaponobjects::getweaponobjectwatcherbyweapon(level.weapontacticalinsertion);
	self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.friendlytrigger, &pickup, watcher.pickupsoundplayer, watcher.pickupsound);
	self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.enemytrigger, &fizzle);
	if(isdefined(self.tacticalinsertioncount))
	{
		self.tacticalinsertioncount++;
	}
	else
	{
		self.tacticalinsertioncount = 1;
	}
	self.tacticalinsertion setcandamage(1);
	self.tacticalinsertion.health = 1;
	while(true)
	{
		waitresult = undefined;
		waitresult = self.tacticalinsertion waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		if(level.teambased && (!isdefined(attacker) || !isplayer(attacker) || attacker.team == self.team) && attacker != self)
		{
			continue;
		}
		if(attacker != self)
		{
			attacker challenges::destroyedequipment(weapon);
			attacker challenges::destroyedtacticalinsert();
			scoreevents::processscoreevent(#"destroyed_tac_insert", attacker, self, weapon);
		}
		if(watcher.stuntime > 0 && weapon.dostun)
		{
			self thread weaponobjects::stunstart(watcher, watcher.stuntime);
		}
		if(weapon.dodamagefeedback)
		{
			if(level.teambased && self.tacticalinsertion.owner.team != attacker.team)
			{
				if(damagefeedback::dodamagefeedback(weapon, attacker))
				{
					attacker damagefeedback::update();
				}
			}
			else if(!level.teambased && self.tacticalinsertion.owner != attacker)
			{
				if(damagefeedback::dodamagefeedback(weapon, attacker))
				{
					attacker damagefeedback::update();
				}
			}
		}
		if(isdefined(attacker) && attacker != self)
		{
			if(isdefined(level.globallogic_audio_dialog_on_player_override))
			{
				self [[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
			}
		}
		self.tacticalinsertion thread fizzle();
	}
}

/*
	Name: cancel_button_think
	Namespace: tacticalinsertion
	Checksum: 0x79F82CC6
	Offset: 0x12F0
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function cancel_button_think()
{
	if(!isdefined(self.tacticalinsertion))
	{
		return;
	}
	/#
		text = cancel_text_create();
	#/
	self thread cancel_button_press();
	event = undefined;
	event = self waittill(#"tactical_insertion_destroyed", #"disconnect", #"end_killcam", #"abort_killcam", #"tactical_insertion_canceled", #"spawned");
	if(event._notify == "tactical_insertion_canceled")
	{
		self.tacticalinsertion destroy_tactical_insertion();
	}
	/#
		if(isdefined(text))
		{
			text destroy();
		}
	#/
}

/*
	Name: canceltackinsertionbutton
	Namespace: tacticalinsertion
	Checksum: 0x90370B3E
	Offset: 0x1410
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function canceltackinsertionbutton()
{
	if(level.console)
	{
		return self changeseatbuttonpressed();
	}
	return self jumpbuttonpressed();
}

/*
	Name: cancel_button_press
	Namespace: tacticalinsertion
	Checksum: 0xECEA58AD
	Offset: 0x1458
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function cancel_button_press()
{
	self endon(#"disconnect", #"end_killcam", #"abort_killcam");
	while(true)
	{
		wait(0.05);
		if(self canceltackinsertionbutton())
		{
			break;
		}
	}
	self notify(#"tactical_insertion_canceled");
}

/*
	Name: cancel_text_create
	Namespace: tacticalinsertion
	Checksum: 0xF08075CF
	Offset: 0x14D8
	Size: 0x15E
	Parameters: 0
	Flags: None
*/
function cancel_text_create()
{
	/#
		text = newdebughudelem(self);
		text.archived = 0;
		text.y = -100;
		text.alignx = "";
		text.aligny = "";
		text.horzalign = "";
		text.vertalign = "";
		text.sort = 10;
		text.font = "";
		text.foreground = 1;
		text.hidewheninmenu = 1;
		if(self issplitscreen())
		{
			text.y = -80;
			text.fontscale = 1.2;
		}
		else
		{
			text.fontscale = 1.6;
		}
		text settext(#"hash_e0dad145a9829f1");
		text.alpha = 1;
		return text;
	#/
}

/*
	Name: gettacticalinsertions
	Namespace: tacticalinsertion
	Checksum: 0xAD0C5E97
	Offset: 0x1640
	Size: 0xA0
	Parameters: 0
	Flags: None
*/
function gettacticalinsertions()
{
	tac_inserts = [];
	foreach(player in level.players)
	{
		if(isdefined(player.tacticalinsertion))
		{
			tac_inserts[tac_inserts.size] = player.tacticalinsertion;
		}
	}
	return tac_inserts;
}

/*
	Name: tacticalinsertiondestroyedbytrophysystem
	Namespace: tacticalinsertion
	Checksum: 0xB8A0B011
	Offset: 0x16E8
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function tacticalinsertiondestroyedbytrophysystem(attacker, trophysystem)
{
	owner = self.owner;
	if(isdefined(attacker))
	{
		attacker challenges::destroyedequipment(trophysystem.name);
		attacker challenges::destroyedtacticalinsert();
	}
	self thread fizzle();
	if(isdefined(owner))
	{
		owner endon(#"death", #"disconnect");
		waitframe(1);
		if(isdefined(level.globallogic_audio_dialog_on_player_override))
		{
			owner [[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
		}
	}
}

/*
	Name: function_73648468
	Namespace: tacticalinsertion
	Checksum: 0xF6C26D00
	Offset: 0x17D8
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event function_73648468(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(grenade util::ishacked())
	{
		return;
	}
	if(isdefined(level.weapontacticalinsertion) && weapon == level.weapontacticalinsertion)
	{
		grenade thread watch(self);
	}
}

