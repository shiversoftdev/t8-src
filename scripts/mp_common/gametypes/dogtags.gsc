// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace dogtags;

/*
	Name: init
	Namespace: dogtags
	Checksum: 0xD453B5EB
	Offset: 0x188
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.antiboostdistance = getgametypesetting(#"antiboostdistance");
	level.dogtags = [];
	callback::on_spawned(&on_spawn_player);
}

/*
	Name: spawn_dog_tag
	Namespace: dogtags
	Checksum: 0xC6749B7
	Offset: 0x1F0
	Size: 0x838
	Parameters: 4
	Flags: Linked
*/
function spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only)
{
	if(isdefined(level.dogtags[victim.entnum]))
	{
		playfx("ui/fx_kill_confirmed_vanish", level.dogtags[victim.entnum].curorigin);
		level.dogtags[victim.entnum] notify(#"reset");
		var_5ee49ea8 = victim getspecialistindex();
		if(var_5ee49ea8 != level.dogtags[victim.entnum].var_5ee49ea8)
		{
			level.dogtags[victim.entnum].var_5ee49ea8 = var_5ee49ea8;
			level.dogtags[victim.entnum].visuals[0] setmodel(victim getenemydogtagmodel());
			level.dogtags[victim.entnum].visuals[1] setmodel(victim getfriendlydogtagmodel());
		}
	}
	else
	{
		visuals[0] = spawn("script_model", (0, 0, 0));
		visuals[0] setmodel(victim getenemydogtagmodel());
		visuals[1] = spawn("script_model", (0, 0, 0));
		visuals[1] setmodel(victim getfriendlydogtagmodel());
		trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
		level.dogtags[victim.entnum] = gameobjects::create_use_object(victim.team, trigger, visuals, vectorscale((0, 0, 1), 16), #"hash_bc7bcc75f63dc7b");
		level.dogtags[victim.entnum] gameobjects::set_use_time(0);
		level.dogtags[victim.entnum].onuse = &onuse;
		level.dogtags[victim.entnum].custom_onuse = on_use_function;
		level.dogtags[victim.entnum].victim = victim;
		level.dogtags[victim.entnum].victimteam = victim.team;
		level.dogtags[victim.entnum].var_5ee49ea8 = victim getspecialistindex();
		level thread clear_on_victim_disconnect(victim);
		victim thread team_updater(level.dogtags[victim.entnum]);
	}
	pos = victim.origin + vectorscale((0, 0, 1), 14);
	level.dogtags[victim.entnum].curorigin = pos;
	level.dogtags[victim.entnum].trigger.origin = pos;
	level.dogtags[victim.entnum].visuals[0].origin = pos;
	level.dogtags[victim.entnum].visuals[1].origin = pos;
	level.dogtags[victim.entnum].visuals[0] dontinterpolate();
	level.dogtags[victim.entnum].visuals[1] dontinterpolate();
	level.dogtags[victim.entnum] gameobjects::allow_use(#"any");
	level.dogtags[victim.entnum].visuals[0] thread show_to_team(level.dogtags[victim.entnum], attacker.team);
	level.dogtags[victim.entnum].visuals[1] thread show_to_enemy_teams(level.dogtags[victim.entnum], attacker.team);
	level.dogtags[victim.entnum].attacker = attacker;
	level.dogtags[victim.entnum].attackerteam = attacker.team;
	level.dogtags[victim.entnum].unreachable = undefined;
	level.dogtags[victim.entnum].tacinsert = 0;
	if(isdefined(level.dogtags[victim.entnum].objectiveid))
	{
		objective_setposition(level.dogtags[victim.entnum].objectiveid, pos);
		objective_setstate(level.dogtags[victim.entnum].objectiveid, "active");
	}
	if(objectives_for_attacker_and_victim_only)
	{
		objective_setinvisibletoall(level.dogtags[victim.entnum].objectiveid);
		if(isplayer(attacker))
		{
			objective_setvisibletoplayer(level.dogtags[victim.entnum].objectiveid, attacker);
		}
		if(isplayer(victim))
		{
			objective_setvisibletoplayer(level.dogtags[victim.entnum].objectiveid, victim);
		}
	}
	level.dogtags[victim.entnum] thread bounce();
	level notify(#"dogtag_spawned");
}

/*
	Name: show_to_team
	Namespace: dogtags
	Checksum: 0xCDFBA4
	Offset: 0xA30
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function show_to_team(gameobject, show_team)
{
	self show();
	foreach(team, _ in level.teams)
	{
		self hidefromteam(team);
	}
	self showtoteam(show_team);
}

/*
	Name: show_to_enemy_teams
	Namespace: dogtags
	Checksum: 0x45AF69B7
	Offset: 0xAF8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function show_to_enemy_teams(gameobject, friend_team)
{
	self show();
	foreach(team, _ in level.teams)
	{
		self showtoteam(team);
	}
	self hidefromteam(friend_team);
}

/*
	Name: onuse
	Namespace: dogtags
	Checksum: 0x38AC0186
	Offset: 0xBC0
	Size: 0x28C
	Parameters: 1
	Flags: Linked
*/
function onuse(player)
{
	if(!isdefined(player) || !isdefined(self))
	{
		return;
	}
	if(isdefined(self.visuals[0]))
	{
		self.visuals[0] playsoundtoplayer(#"hash_59915eb03bb56417", player);
		self.visuals[0] playsoundtoallbutplayer(#"mpl_killconfirm_tags_pickup", player);
	}
	tacinsertboost = 0;
	if(util::function_fbce7263(player.team, self.attackerteam))
	{
		player stats::function_dad108fa(#"killsdenied", 1);
		player recordgameevent("return");
		if(self.victim == player)
		{
			if(self.tacinsert == 0)
			{
				event = "retrieve_own_tags";
			}
			else
			{
				tacinsertboost = 1;
			}
		}
		else
		{
			event = "kill_denied";
		}
		if(!tacinsertboost)
		{
			player.pers[#"killsdenied"]++;
			player.killsdenied = player.pers[#"killsdenied"];
		}
	}
	else
	{
		event = "kill_confirmed";
		player stats::function_dad108fa(#"killsconfirmed", 1);
		player recordgameevent("capture");
		if(isdefined(self.attacker) && self.attacker != player)
		{
			self.attacker onpickup("teammate_kill_confirmed");
		}
	}
	if(!tacinsertboost && isdefined(player))
	{
		player onpickup(event);
	}
	[[self.custom_onuse]](player);
	self reset_tags();
}

/*
	Name: reset_tags
	Namespace: dogtags
	Checksum: 0xD770BD2E
	Offset: 0xE58
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function reset_tags()
{
	self.attacker = undefined;
	self.unreachable = undefined;
	self notify(#"reset");
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.curorigin = vectorscale((0, 0, 1), 1000);
	self.trigger.origin = vectorscale((0, 0, 1), 1000);
	self.visuals[0].origin = vectorscale((0, 0, 1), 1000);
	self.visuals[1].origin = vectorscale((0, 0, 1), 1000);
	self.tacinsert = 0;
	self gameobjects::allow_use(#"none");
	objective_setstate(self.objectiveid, "invisible");
}

/*
	Name: onpickup
	Namespace: dogtags
	Checksum: 0x5E750025
	Offset: 0xF90
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function onpickup(event)
{
	scoreevents::processscoreevent(event, self, undefined, undefined);
}

/*
	Name: clear_on_victim_disconnect
	Namespace: dogtags
	Checksum: 0x90FBD89B
	Offset: 0xFC8
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function clear_on_victim_disconnect(victim)
{
	level endon(#"game_ended");
	guid = victim.entnum;
	victim waittill(#"disconnect");
	if(isdefined(level.dogtags[guid]))
	{
		level.dogtags[guid] gameobjects::allow_use(#"none");
		playfx("ui/fx_kill_confirmed_vanish", level.dogtags[guid].curorigin);
		level.dogtags[guid] notify(#"reset");
		waitframe(1);
		if(isdefined(level.dogtags[guid]))
		{
			objective_delete(level.dogtags[guid].objectiveid);
			level.dogtags[guid].trigger delete();
			for(i = 0; i < level.dogtags[guid].visuals.size; i++)
			{
				level.dogtags[guid].visuals[i] delete();
			}
			level.dogtags[guid] notify(#"deleted");
			level.dogtags[guid] = undefined;
		}
	}
}

/*
	Name: on_spawn_player
	Namespace: dogtags
	Checksum: 0x6616ACF0
	Offset: 0x11B8
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function on_spawn_player()
{
	if(!(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn))
	{
		return;
	}
	if(level.rankedmatch || level.leaguematch)
	{
		if(isdefined(self.tacticalinsertiontime) && (self.tacticalinsertiontime + 100) > gettime())
		{
			mindist = level.antiboostdistance;
			mindistsqr = mindist * mindist;
			distsqr = distancesquared(self.origin, level.dogtags[self.entnum].curorigin);
			if(distsqr < mindistsqr)
			{
				level.dogtags[self.entnum].tacinsert = 1;
			}
		}
	}
}

/*
	Name: team_updater
	Namespace: dogtags
	Checksum: 0xDFB28A0
	Offset: 0x12B8
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function team_updater(tags)
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"joined_team");
		tags.victimteam = self.team;
		tags reset_tags();
	}
}

/*
	Name: time_out
	Namespace: dogtags
	Checksum: 0x8A310801
	Offset: 0x1340
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function time_out(victim)
{
	level endon(#"game_ended");
	victim endon(#"disconnect");
	self notify(#"timeout");
	self endon(#"timeout");
	level hostmigration::waitlongdurationwithhostmigrationpause(30);
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.curorigin = vectorscale((0, 0, 1), 1000);
	self.trigger.origin = vectorscale((0, 0, 1), 1000);
	self.visuals[0].origin = vectorscale((0, 0, 1), 1000);
	self.visuals[1].origin = vectorscale((0, 0, 1), 1000);
	self.tacinsert = 0;
	self gameobjects::allow_use(#"none");
}

/*
	Name: bounce
	Namespace: dogtags
	Checksum: 0x918DA1D7
	Offset: 0x14B0
	Size: 0x220
	Parameters: 0
	Flags: Linked
*/
function bounce()
{
	level endon(#"game_ended");
	self endon(#"reset");
	bottompos = self.curorigin;
	toppos = self.curorigin + vectorscale((0, 0, 1), 12);
	while(true)
	{
		self.visuals[0] moveto(toppos, 0.5, 0.15, 0.15);
		self.visuals[0] rotateyaw(180, 0.5);
		self.visuals[1] moveto(toppos, 0.5, 0.15, 0.15);
		self.visuals[1] rotateyaw(180, 0.5);
		wait(0.5);
		self.visuals[0] moveto(bottompos, 0.5, 0.15, 0.15);
		self.visuals[0] rotateyaw(180, 0.5);
		self.visuals[1] moveto(bottompos, 0.5, 0.15, 0.15);
		self.visuals[1] rotateyaw(180, 0.5);
		wait(0.5);
	}
}

/*
	Name: checkallowspectating
	Namespace: dogtags
	Checksum: 0xC9DB65F
	Offset: 0x16D8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function checkallowspectating()
{
	self endon(#"disconnect");
	waitframe(1);
	spectating::update_settings();
}

/*
	Name: should_spawn_tags
	Namespace: dogtags
	Checksum: 0x1B03FEDA
	Offset: 0x1718
	Size: 0x154
	Parameters: 9
	Flags: Linked
*/
function should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(isalive(self))
	{
		return false;
	}
	if(isdefined(self.switching_teams))
	{
		return false;
	}
	if(isdefined(attacker) && attacker == self)
	{
		return false;
	}
	if(level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team)
	{
		return false;
	}
	if(isdefined(attacker) && (!isdefined(attacker.team) || attacker.team == "free") && (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn"))
	{
		return false;
	}
	return true;
}

/*
	Name: onusedogtag
	Namespace: dogtags
	Checksum: 0xB811F260
	Offset: 0x1878
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function onusedogtag(player)
{
	if(player.pers[#"team"] == self.victimteam)
	{
		player.pers[#"rescues"]++;
		player.rescues = player.pers[#"rescues"];
		if(isdefined(self.victim))
		{
			if(!level.gameended)
			{
				self.victim thread dt_respawn();
			}
		}
	}
}

/*
	Name: dt_respawn
	Namespace: dogtags
	Checksum: 0x2424184B
	Offset: 0x1930
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function dt_respawn()
{
	self thread waittillcanspawnclient();
}

/*
	Name: waittillcanspawnclient
	Namespace: dogtags
	Checksum: 0x974A9213
	Offset: 0x1958
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function waittillcanspawnclient()
{
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && (self.sessionstate == "spectator" || !isalive(self)))
		{
			self.pers[#"lives"] = 1;
			self thread [[level.spawnclient]]();
			continue;
		}
		return;
	}
}

