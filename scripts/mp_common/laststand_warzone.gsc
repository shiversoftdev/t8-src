// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_damage.gsc;
#using scripts\mp_common\teams\platoons.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\mp_common\player\player_killed.gsc;
#using script_3de49240300c8cc9;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\platoons.gsc;
#using scripts\weapons\weapons.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\scoreevents.gsc;

#namespace laststand_warzone;

/*
	Name: __init__system__
	Namespace: laststand_warzone
	Checksum: 0x711042B2
	Offset: 0x3B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"laststand_warzone", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: laststand_warzone
	Checksum: 0x5B06F59D
	Offset: 0x3F8
	Size: 0x494
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!sessionmodeiswarzonegame())
	{
		return;
	}
	level.wz_revive_prompt = array(wz_revive_prompt::register("wz_revive_prompt_1"), wz_revive_prompt::register("wz_revive_prompt_2"), wz_revive_prompt::register("wz_revive_prompt_3"));
	clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float");
	clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.laststand.revivingClientNum", 1, 7, "int");
	clientfield::register("clientuimodel", "hudItems.laststand.reviveProgress", 1, 5, "float");
	clientfield::register("clientuimodel", "hudItems.beingFinished", 1, 1, "int");
	clientfield::register("allplayers", "laststand_bleed", 1, 1, "int");
	level.var_8e910e84 = 1;
	level.var_5c13c13f = (isdefined(getgametypesetting(#"hash_4c7c8c4bd1b2a58b")) ? getgametypesetting(#"hash_4c7c8c4bd1b2a58b") : 0);
	level.skiplaststand = getgametypesetting(#"skiplaststand");
	level.var_46a21fe9 = (isdefined(getgametypesetting(#"wzenablecowardswayout")) ? getgametypesetting(#"wzenablecowardswayout") : 0);
	level.var_7d1eeba9 = 1;
	level.var_b1ad0b64 = &function_b1ad0b64;
	level.laststandweapon = getweapon(#"downed");
	level.var_e273f858 = getweapon(#"notdowned");
	level.weaponrevivetool = getweapon("syrette");
	level.var_e86679bd = [];
	level.var_91c33dcb = getscriptbundle(#"finishers");
	if(!isdefined(getdvar(#"revive_trigger_radius")))
	{
		setdvar(#"revive_trigger_radius", 100);
	}
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	callback::on_player_damage(&on_player_damage);
	callback::on_player_killed(&on_player_killed);
	callback::on_disconnect(&on_player_disconnect);
	/#
		level thread function_ce726eb4();
	#/
	setdvar(#"g_revivetime", getgametypesetting(#"laststandrevivetime"));
}

/*
	Name: function_feb3e91d
	Namespace: laststand_warzone
	Checksum: 0x2D177566
	Offset: 0x898
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_feb3e91d()
{
	return true;
}

/*
	Name: function_414115a0
	Namespace: laststand_warzone
	Checksum: 0xCA78A47D
	Offset: 0x8F0
	Size: 0x66
	Parameters: 2
	Flags: Linked
*/
function function_414115a0(time, health)
{
	tier = {#health:health, #time:time};
	level.var_e86679bd[level.var_e86679bd.size] = tier;
}

/*
	Name: on_player_connect
	Namespace: laststand_warzone
	Checksum: 0x882A14D3
	Offset: 0x960
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	foreach(prompt in level.wz_revive_prompt)
	{
		[[ prompt ]]->set_clientnum(self, int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	}
}

/*
	Name: on_player_spawned
	Namespace: laststand_warzone
	Checksum: 0xC8932A2C
	Offset: 0xA48
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.var_d887a4ad = undefined;
	self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	self clientfield::set_player_uimodel("hudItems.playerCleanUps", self.cleanups);
	self clientfield::set_player_uimodel("hudItems.playerKills", self.kills);
	self clientfield::set_player_uimodel("hudItems.beingFinished", 0);
	self.var_156bf46e = undefined;
}

/*
	Name: on_player_damage
	Namespace: laststand_warzone
	Checksum: 0x3B63FC5C
	Offset: 0xB58
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(self is_reviving_any())
	{
		if(isdefined(self.reviving_player) && isdefined(self.reviving_player.var_d75a6ff5))
		{
			self.reviving_player.var_d75a6ff5.var_d733f8d7 = self.reviving_player.var_d75a6ff5.var_d733f8d7 + params.idamage;
			if(self.health <= params.idamage)
			{
				self.reviving_player.var_d75a6ff5.var_bb36e277 = 1;
			}
		}
	}
}

/*
	Name: on_player_killed
	Namespace: laststand_warzone
	Checksum: 0x6FFF5212
	Offset: 0xC20
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	function_23089de2();
}

/*
	Name: on_player_disconnect
	Namespace: laststand_warzone
	Checksum: 0xE6C331F6
	Offset: 0xC40
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	function_23089de2();
	if(isdefined(self.laststandparams))
	{
		attacker = self.laststandparams.attacker;
		weapon = self.laststandparams.sweapon;
		smeansofdeath = self.laststandparams.smeansofdeath;
		if(self util::isenemyplayer(attacker))
		{
			attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, attacker);
			attacker clientfield::set_player_uimodel("hudItems.playerKills", attacker.kills);
		}
	}
}

/*
	Name: function_c7d3aeec
	Namespace: laststand_warzone
	Checksum: 0x7FCE3548
	Offset: 0xD28
	Size: 0x172
	Parameters: 2
	Flags: Linked
*/
function function_c7d3aeec(statname, value)
{
	if(!isdefined(self.var_e241decf))
	{
		self.var_e241decf = [];
	}
	if(!isdefined(self.var_e241decf[statname]))
	{
		self.var_e241decf[statname] = 0;
	}
	self.var_e241decf[statname] = self.var_e241decf[statname] + value;
	self stats::function_d40764f3(statname, value);
	self stats::function_b7f80d87(statname, value);
	cleanups = 0;
	foreach(var_1c190326 in self.var_e241decf)
	{
		cleanups = cleanups + var_1c190326;
	}
	self clientfield::set_player_uimodel("hudItems.playerCleanUps", cleanups);
	self.cleanups = self function_6f7bff5d(#"cleanups", value);
}

/*
	Name: function_6f7bff5d
	Namespace: laststand_warzone
	Checksum: 0x1F1F96B8
	Offset: 0xEA8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_6f7bff5d(statname, value)
{
	if(!isdefined(self.pers[statname]))
	{
		self.pers[statname] = 0;
	}
	self.pers[statname] = self.pers[statname] + value;
	return self.pers[statname];
}

/*
	Name: function_23089de2
	Namespace: laststand_warzone
	Checksum: 0x393534A6
	Offset: 0xF20
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_23089de2()
{
	var_334ebbb6 = function_ed72859e();
	if(!var_334ebbb6)
	{
		teams = self function_2b77bc35();
		foreach(team in teams)
		{
			friendlies = getplayers(team);
			foreach(player in friendlies)
			{
				if(player != self && isalive(player) && player laststand::player_is_in_laststand())
				{
					player thread bleed_out(1);
				}
			}
		}
	}
}

/*
	Name: function_e011eea6
	Namespace: laststand_warzone
	Checksum: 0x53402256
	Offset: 0x10A8
	Size: 0xCA
	Parameters: 1
	Flags: Event
*/
event function_e011eea6(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	if(self inlaststand())
	{
		self.var_156bf46e = eventstruct.vehicle;
	}
	else if(isairborne(eventstruct.vehicle))
	{
		self.var_156bf46e = eventstruct.vehicle;
		waitframe(1);
		if(isalive(self) && !self inlaststand())
		{
			self.var_156bf46e = undefined;
		}
	}
}

/*
	Name: function_263a2944
	Namespace: laststand_warzone
	Checksum: 0x8DC1E762
	Offset: 0x1180
	Size: 0x118
	Parameters: 2
	Flags: Linked
*/
function function_263a2944(prompt, var_a1258c6b)
{
	var_a1258c6b waittill(#"player_revived", #"disconnect", #"bled_out", #"death", #"player_finished");
	if(isdefined(self))
	{
		[[ prompt ]]->close(self);
		[[ prompt ]]->set_clientnum(self, int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
		self notify(prompt.var_47e79fc + "_terminated");
	}
}

/*
	Name: function_60cc4433
	Namespace: laststand_warzone
	Checksum: 0x989BDABA
	Offset: 0x12A0
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_60cc4433(prompt, var_a1258c6b)
{
	if(infection::function_74650d7())
	{
		self endon(prompt.var_47e79fc + "_terminated");
		self waittill(#"death");
		if(isdefined(self))
		{
			[[ prompt ]]->close(self);
			[[ prompt ]]->set_clientnum(self, int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
		}
	}
}

/*
	Name: function_c025efba
	Namespace: laststand_warzone
	Checksum: 0xDD7CF948
	Offset: 0x1390
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function function_c025efba(prompt, var_a1258c6b)
{
	var_a1258c6b endon(#"player_revived", #"disconnect", #"bled_out", #"death", #"player_finished");
	self endon(#"disconnect");
	while(true)
	{
		beingrevived = var_a1258c6b is_being_revived();
		var_3840aba9 = var_a1258c6b function_72e0c544();
		cowardsway = isdefined(var_a1258c6b.var_eb33efbc) && var_a1258c6b.var_eb33efbc;
		[[ prompt ]]->set_cowardsWay(self, !beingrevived && !var_3840aba9 && cowardsway);
		[[ prompt ]]->set_health(self, var_a1258c6b.var_2d19ce3c);
		[[ prompt ]]->set_reviveProgress(self, var_a1258c6b.reviveprogress);
		waitframe(1);
	}
}

/*
	Name: function_2b77bc35
	Namespace: laststand_warzone
	Checksum: 0xC52BD118
	Offset: 0x14F8
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_2b77bc35()
{
	if(platoons::function_382a49e0() && (getteamplatoon(self.team) != #"none" && getteamplatoon(self.team) != #"invalid"))
	{
		teams = function_37d3bfcb(getteamplatoon(self.team));
	}
	else
	{
		teams = [];
		if(!isdefined(teams))
		{
			teams = [];
		}
		else if(!isarray(teams))
		{
			teams = array(teams);
		}
		teams[teams.size] = self.team;
	}
	return teams;
}

/*
	Name: function_fb02bdd4
	Namespace: laststand_warzone
	Checksum: 0x50D44CC2
	Offset: 0x1608
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_fb02bdd4(var_17a89b1)
{
	enemy_teams = [];
	foreach(team, _ in level.teams)
	{
		if(!isinarray(var_17a89b1, team))
		{
			if(!isdefined(enemy_teams))
			{
				enemy_teams = [];
			}
			else if(!isarray(enemy_teams))
			{
				enemy_teams = array(enemy_teams);
			}
			enemy_teams[enemy_teams.size] = team;
		}
	}
	return enemy_teams;
}

/*
	Name: function_16d5deba
	Namespace: laststand_warzone
	Checksum: 0xEF5CC071
	Offset: 0x1700
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_16d5deba()
{
	revive_count = 0;
	friendlies = getplayers(self.team);
	foreach(player in friendlies)
	{
		if(player thread function_5de626dc(self))
		{
			revive_count++;
		}
	}
}

/*
	Name: function_5de626dc
	Namespace: laststand_warzone
	Checksum: 0x73886EE1
	Offset: 0x17C0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_5de626dc(var_a1258c6b)
{
	foreach(prompt in level.wz_revive_prompt)
	{
		if(![[ prompt ]]->function_7bfd10e6(self))
		{
			[[ prompt ]]->open(self, 1);
			[[ prompt ]]->set_health(self, 1);
			[[ prompt ]]->set_reviveProgress(self, 0);
			[[ prompt ]]->set_cowardsWay(self, 0);
			[[ prompt ]]->set_clientnum(self, var_a1258c6b getentitynumber());
			self thread function_263a2944(prompt, var_a1258c6b);
			self thread function_c025efba(prompt, var_a1258c6b);
			self thread function_60cc4433(prompt);
			return true;
		}
	}
	return false;
}

/*
	Name: function_dc7906e8
	Namespace: laststand_warzone
	Checksum: 0x8018474A
	Offset: 0x1928
	Size: 0x232
	Parameters: 7
	Flags: Linked
*/
function function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc)
{
	self.laststandparams = spawnstruct();
	self.laststandparams.einflictor = einflictor;
	self.laststandparams.attacker = attacker;
	self.laststandparams.victimorigin = self.origin;
	self.laststandparams.var_5fceefd4 = self getplayerangles();
	self.laststandparams.victimweapon = self.currentweapon;
	vattacker = (isdefined(attacker) ? attacker : self);
	self.laststandparams.attackerorigin = vattacker.origin;
	self.laststandparams.var_83634238 = (isplayer(vattacker) ? vattacker getplayerangles() : vattacker.angles);
	self.laststandparams.idamage = idamage;
	self.laststandparams.smeansofdeath = smeansofdeath;
	self.laststandparams.sweapon = weapon;
	self.laststandparams.vdir = vdir;
	self.laststandparams.shitloc = shitloc;
	self.laststandparams.laststandstarttime = gettime();
	self.laststandparams.var_10d87328 = function_f8d53445();
	self.laststandparams.bledout = 0;
	self.laststandparams.var_3f57b6a0 = self.laststandparams.victimorigin;
	self.laststandparams.savedangles = self.laststandparams.var_5fceefd4;
}

/*
	Name: function_d5db8d2e
	Namespace: laststand_warzone
	Checksum: 0x20B05E46
	Offset: 0x1B68
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_d5db8d2e(attacker, weapon)
{
	self function_2907ce7a();
}

/*
	Name: function_463b3f65
	Namespace: laststand_warzone
	Checksum: 0xFC05EAD5
	Offset: 0x1BA0
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function function_463b3f65()
{
	/#
		self endon(#"player_revived", #"death");
		while(true)
		{
			if(getdvarstring(#"scr_last_stand", "") == "")
			{
				self notify(#"auto_revive");
				waittillframeend();
				setdvar(#"scr_last_stand", "");
				return;
			}
			wait(0.1);
		}
	#/
}

/*
	Name: function_ce726eb4
	Namespace: laststand_warzone
	Checksum: 0x9B6905D1
	Offset: 0x1C68
	Size: 0x1B8
	Parameters: 0
	Flags: None
*/
function function_ce726eb4()
{
	/#
		level endon(#"game_ended");
		while(true)
		{
			if(getdvarstring(#"scr_last_stand", "") == "")
			{
				host = util::gethostplayer();
				angles = host getplayerangles();
				dir = anglestoforward(angles);
				eye = host geteye();
				dir = dir * 500;
				trace = bullettrace(eye, eye + dir, 1, host);
				target = trace[#"entity"];
				if(!isdefined(target) || !isplayer(target))
				{
					target = host;
				}
				target dodamage(1000, target.origin);
				setdvar(#"scr_last_stand", "");
			}
			wait(0.1);
		}
	#/
}

/*
	Name: function_90f43127
	Namespace: laststand_warzone
	Checksum: 0x8919C4B4
	Offset: 0x1E28
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_90f43127(attacker)
{
	if(!isplayer(attacker))
	{
		return;
	}
	teams = self function_2b77bc35();
	count = 0;
	foreach(team in teams)
	{
		players = getplayers(team);
		foreach(player in players)
		{
			if(player == self)
			{
				continue;
			}
			if(isalive(player) && player laststand::player_is_in_laststand() && isdefined(player.var_53b73ccf) && player.var_53b73ccf == attacker)
			{
				count++;
			}
		}
	}
	return count;
}

/*
	Name: function_ed72859e
	Namespace: laststand_warzone
	Checksum: 0xFBB90CDC
	Offset: 0x1FD8
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function function_ed72859e()
{
	teams = self function_2b77bc35();
	foreach(team in teams)
	{
		players = getplayers(team);
		foreach(player in players)
		{
			if(player == self)
			{
				continue;
			}
			if(isalive(player) && !player laststand::player_is_in_laststand())
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_b1158c52
	Namespace: laststand_warzone
	Checksum: 0xEB2F5EBD
	Offset: 0x2130
	Size: 0x1D6
	Parameters: 1
	Flags: Linked
*/
function function_b1158c52(var_90c1e72d)
{
	if(isdefined(level.skiplaststand) && level.skiplaststand)
	{
		return 1;
	}
	if(!var_90c1e72d)
	{
		return 1;
	}
	if(self isplayerswimming())
	{
		return 1;
	}
	if(self infection::is_infected())
	{
		return 1;
	}
	if(isdefined(self.var_156bf46e) && isvehicle(self.var_156bf46e) && !self.var_156bf46e isremotecontrol() && isairborne(self.var_156bf46e))
	{
		trace = groundtrace(self.origin, self.origin - vectorscale((0, 0, 1), 300), 0, self.var_156bf46e);
		if(trace[#"fraction"] >= 1)
		{
			return 1;
		}
	}
	else
	{
		var_b145f8cd = self.laststandcount - 1;
		if(var_b145f8cd >= level.var_e86679bd.size)
		{
			var_b145f8cd = level.var_e86679bd.size - 1;
		}
		var_e86679bd = level.var_e86679bd[var_b145f8cd];
		if(isdefined(var_e86679bd))
		{
			return var_e86679bd.time <= 0;
		}
	}
	return 0;
}

/*
	Name: playerlaststand
	Namespace: laststand_warzone
	Checksum: 0xBC2AD293
	Offset: 0x2310
	Size: 0x8C4
	Parameters: 9
	Flags: Linked
*/
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride)
{
	if(self laststand::player_is_in_laststand())
	{
		return;
	}
	self.var_60956d6 = self getcurrentweapon();
	var_2165fe71 = self player::function_201c298c();
	if(isdefined(var_2165fe71) && self player::function_ca27b62b(undefined, var_2165fe71))
	{
		attacker = var_2165fe71;
		var_ca60c93e = self.attackerdamage[attacker.clientid];
		weapon = var_ca60c93e.weapon;
	}
	else
	{
		attacker = player::figure_out_attacker(attacker);
	}
	self function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc);
	if(!isdefined(self.laststandcount))
	{
		self.laststandcount = 0;
	}
	self.laststandcount++;
	if(!isdefined(self.var_22002c3b))
	{
		self.var_22002c3b = [];
	}
	if(!isdefined(self.var_22002c3b))
	{
		self.var_22002c3b = [];
	}
	else if(!isarray(self.var_22002c3b))
	{
		self.var_22002c3b = array(self.var_22002c3b);
	}
	if(!isinarray(self.var_22002c3b, einflictor))
	{
		self.var_22002c3b[self.var_22002c3b.size] = einflictor;
	}
	self function_ecdd4b27(attacker);
	callback::callback(#"on_player_downed");
	var_90c1e72d = function_ed72859e();
	var_ef3f8858 = function_90f43127(attacker);
	var_4db50476 = self util::isenemyplayer(attacker);
	if(var_4db50476)
	{
		attacker stats::function_d40764f3(#"downs", 1);
		attacker stats::function_b7f80d87(#"downs", 1);
		attacker.downs = attacker function_6f7bff5d(#"downs", 1);
	}
	if(function_b1158c52(var_90c1e72d))
	{
		obituary(self, attacker, weapon, smeansofdeath);
		if(var_4db50476)
		{
			attacker function_c7d3aeec(#"kills_eliminated", 1);
			attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, attacker);
			attacker clientfield::set_player_uimodel("hudItems.playerKills", attacker.kills);
			damage = self player::function_40c6c42d(attacker);
			if(!var_90c1e72d)
			{
				function_f887b191(self, attacker, damage, 4);
				if(!isdefined(attacker.recentkillvariables))
				{
					attacker scoreevents::resetrecentkillvariables();
				}
				if(!isdefined(attacker.recentkillcount))
				{
					attacker.recentkillcount = 0;
				}
				attacker.recentkillcount = attacker.recentkillcount + var_ef3f8858;
			}
			else
			{
				function_f887b191(self, attacker, damage, 0);
			}
		}
		self undolaststand();
		self.uselaststandparams = 1;
		self function_6da86ae();
		self suicide();
		if(isdefined(self.var_d75a6ff5))
		{
			self.var_d75a6ff5.death = 1;
		}
		self function_1e8018b0();
		return;
	}
	obituary(self, attacker, level.weaponnone, "MOD_DOWNED");
	if(var_4db50476)
	{
		damage = self player::function_40c6c42d(attacker);
		function_f887b191(self, attacker, damage, 1);
	}
	self.reviveprogress = 0;
	self.var_2d19ce3c = 1;
	self function_16d5deba();
	self notify(#"entering_last_stand");
	self allowjump(0);
	self disableoffhandweapons();
	/#
		self thread function_463b3f65();
	#/
	self.health = 5;
	self.laststand = 1;
	self.meleeattackers = undefined;
	self val::set(#"last_stand", "show_weapon_hud", 0);
	callback::callback(#"on_player_laststand");
	self function_d5db8d2e(attacker, weapon);
	if(!(isdefined(self.no_revive_trigger) && self.no_revive_trigger))
	{
		if(!self oob::isoutofbounds())
		{
			self revive_trigger_spawn();
		}
	}
	self laststand_disable_player_weapons();
	bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
	var_969fabf4 = self.maxhealth;
	var_b145f8cd = self.laststandcount - 1;
	if(var_b145f8cd >= level.var_e86679bd.size)
	{
		var_b145f8cd = level.var_e86679bd.size - 1;
	}
	var_e86679bd = level.var_e86679bd[var_b145f8cd];
	if(isdefined(var_e86679bd))
	{
		bleedout_time = var_e86679bd.time;
		var_969fabf4 = var_e86679bd.health;
	}
	self clientfield::set("laststand_bleed", 1);
	/#
		bleedout_time = getdvarfloat(#"overridebleedouttime", bleedout_time);
	#/
	self thread laststand_bleedout(bleedout_time, var_969fabf4);
	self thread laststand_invulnerability();
	demo::bookmark(#"player_downed", gettime(), self);
	potm::bookmark(#"player_downed", gettime(), self);
	self thread laststand::function_d4c9e1b5();
	/#
		self thread auto_revive_on_notify();
	#/
	self thread function_5ccd602d();
}

/*
	Name: function_5ccd602d
	Namespace: laststand_warzone
	Checksum: 0x729BD8F6
	Offset: 0x2BE0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_5ccd602d()
{
	self endon(#"player_revived", #"disconnect");
	self waittill(#"death");
	self function_2907ce7a();
	self undolaststand();
	self function_b1303a37();
	self val::reset(#"last_stand", "show_weapon_hud");
}

/*
	Name: laststand_disable_player_weapons
	Namespace: laststand_warzone
	Checksum: 0xB1642842
	Offset: 0x2C90
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function laststand_disable_player_weapons()
{
	self giveweapon(level.laststandweapon);
	self givemaxammo(level.laststandweapon);
	self switchtoweaponimmediate(level.laststandweapon, 1);
	self disableweaponcycling();
	self disableoffhandweapons();
}

/*
	Name: function_102748f8
	Namespace: laststand_warzone
	Checksum: 0xE967C347
	Offset: 0x2D30
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_102748f8()
{
	self takeweapon(level.laststandweapon);
	self giveweapon(level.var_e273f858);
	self switchtoweaponimmediate(level.var_e273f858, 1);
}

/*
	Name: laststand_enable_player_weapons
	Namespace: laststand_warzone
	Checksum: 0xC87E35C9
	Offset: 0x2DA0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function laststand_enable_player_weapons()
{
	self endon(#"disconnect");
	if(isdefined(self.var_60956d6) && self.var_60956d6.name == #"sig_blade")
	{
		wait(0.03);
	}
	self takeweapon(level.var_e273f858);
	self enableweaponcycling();
	self enableoffhandweapons();
	self enableusability();
	self weapons::function_d571ac59(self.var_60956d6);
}

/*
	Name: laststand_clean_up_on_interrupt
	Namespace: laststand_warzone
	Checksum: 0xDABD412B
	Offset: 0x2E88
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function laststand_clean_up_on_interrupt(playerbeingrevived)
{
	self endon(#"do_revive_ended_normally");
	revivetrigger = playerbeingrevived.revivetrigger;
	playerbeingrevived waittill(#"disconnect", #"game_ended", #"death");
	if(isdefined(playerbeingrevived))
	{
		playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
		playerbeingrevived function_7c685040();
		playerbeingrevived function_516a3bef(1);
	}
	if(isdefined(revivetrigger))
	{
		revivetrigger delete();
	}
	if(isdefined(self))
	{
		self stoploopsound(1);
		self function_7c685040();
		self function_2907ce7a();
		self revive_give_back_weapons();
		self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", 0);
		self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	}
}

/*
	Name: laststand_bleedout_damage
	Namespace: laststand_warzone
	Checksum: 0x9E434A86
	Offset: 0x3080
	Size: 0x49A
	Parameters: 0
	Flags: Linked
*/
function laststand_bleedout_damage()
{
	self endoncallback(&function_99fa3916, #"player_revived", #"death", #"bled_out");
	self val::set(#"laststand", #"takedamage", 0);
	wait(level.var_5c13c13f);
	self val::reset(#"laststand", #"takedamage");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"laststand_damage");
		if(self.var_d887a4ad === 1)
		{
			return;
		}
		playermelee = 0;
		attacker = player::figure_out_attacker(waitresult.eattacker);
		if(isplayer(attacker) && isdefined(waitresult.einflictor) && waitresult.einflictor == attacker)
		{
			playermelee = waitresult.smeansofdeath == "MOD_MELEE" || waitresult.smeansofdeath == "MOD_MELEE_WEAPON_BUTT" || waitresult.smeansofdeath == "MOD_MELEE_ASSASSINATE";
		}
		if(playermelee)
		{
			self.bleedout_time = 0;
		}
		else
		{
			var_47b2d26b = waitresult.idamage / self.var_969fabf4;
			damagetime = self.var_84c0402e * var_47b2d26b;
			self.bleedout_time = self.bleedout_time - damagetime;
		}
		if(self.bleedout_time <= 0)
		{
			self.bleedout_time = 0;
			self.var_1cc38de0 = 1;
			vattacker = (isdefined(attacker) ? attacker : self);
			self.var_a1d415ee = {#hash_10d87328:function_f8d53445(), #shitloc:waitresult.shitloc, #vdir:waitresult.vdir, #sweapon:waitresult.weapon, #smeansofdeath:waitresult.smeansofdeath, #idamage:waitresult.idamage, #hash_83634238:(isplayer(vattacker) ? vattacker getplayerangles() : vattacker.angles), #attackerorigin:vattacker.origin, #attacker:attacker, #einflictor:waitresult.einflictor};
		}
		if(isdefined(self.var_d75a6ff5))
		{
			self.var_d75a6ff5.damage = self.var_d75a6ff5.damage + int(waitresult.idamage);
		}
		self function_a6872ca5(waitresult.idamage, waitresult.eattacker, waitresult.idflags, waitresult.smeansofdeath, waitresult.weapon, waitresult.vpoint, waitresult.shitloc, waitresult.vdamageorigin, waitresult.boneindex, waitresult.vsurfacenormal, self.bleedout_time <= 0);
		self notify(#"update_bleedout");
	}
}

/*
	Name: function_99fa3916
	Namespace: laststand_warzone
	Checksum: 0x3C99A4F1
	Offset: 0x3528
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_99fa3916(notifyhash)
{
	self val::reset(#"laststand", #"takedamage");
}

/*
	Name: is_being_revived
	Namespace: laststand_warzone
	Checksum: 0xC4899785
	Offset: 0x3570
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function is_being_revived()
{
	return isdefined(self.revivetrigger) && (isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived);
}

/*
	Name: function_72e0c544
	Namespace: laststand_warzone
	Checksum: 0x9CDA0F89
	Offset: 0x35B0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_72e0c544()
{
	return isdefined(self.revivetrigger) && (isdefined(self.revivetrigger.var_3840aba9) && self.revivetrigger.var_3840aba9);
}

/*
	Name: laststand_bleedout
	Namespace: laststand_warzone
	Checksum: 0x9B20ADD4
	Offset: 0x35F0
	Size: 0x3D4
	Parameters: 2
	Flags: Linked
*/
function laststand_bleedout(bleedouttime, var_969fabf4)
{
	level endon(#"game_ended");
	self endon(#"player_revived", #"player_bleedout", #"death");
	self.var_84c0402e = bleedouttime;
	self.bleedout_time = bleedouttime;
	self.var_969fabf4 = var_969fabf4;
	self.var_2d19ce3c = 0;
	self.var_1cc38de0 = 0;
	self.var_eb33efbc = 0;
	var_cb141a23 = int(0.1 * 1000);
	var_93b9385d = bleedouttime * 0.06;
	var_cebeb781 = !self usebuttonpressed();
	if(self.bleedout_time > 0)
	{
		self thread laststand_bleedout_damage();
		var_7c962084 = undefined;
		var_9da219f5 = gettime();
		while(self.bleedout_time > 0)
		{
			time = gettime();
			if(isdefined(level.var_46a21fe9) && level.var_46a21fe9 && (!(self is_being_revived() || self function_72e0c544())) && var_cebeb781 && self usebuttonpressed())
			{
				if(!isdefined(var_7c962084))
				{
					var_7c962084 = time;
				}
				self.var_eb33efbc = 1;
				if(time >= (var_7c962084 + var_cb141a23))
				{
					self.bleedout_time = self.bleedout_time - var_93b9385d;
					var_7c962084 = time;
					var_9da219f5 = var_9da219f5 + var_cb141a23;
				}
			}
			else if(time >= var_9da219f5)
			{
				self.bleedout_time = self.bleedout_time - 1;
				var_7c962084 = undefined;
				var_9da219f5 = time + (int(1 * 1000));
			}
			self.var_2d19ce3c = self.bleedout_time / bleedouttime;
			if(self.var_d887a4ad !== 1)
			{
				self clientfield::set_player_uimodel("hudItems.laststand.progress", self.var_2d19ce3c);
			}
			waitframe(1);
			var_cebeb781 = var_cebeb781 | !self usebuttonpressed();
			self.var_eb33efbc = 0;
			while(!(isdefined(self.var_1cc38de0) && self.var_1cc38de0) && (self is_being_revived() || self function_72e0c544()))
			{
				waitframe(1);
			}
		}
	}
	while(isdefined(self.var_bef1bc5d) && self.var_bef1bc5d)
	{
		waitframe(1);
	}
	if(self.var_d887a4ad === 1)
	{
		return;
	}
	self notify(#"bled_out");
	self thread bleed_out(0);
}

/*
	Name: laststand_invulnerability
	Namespace: laststand_warzone
	Checksum: 0x1FE92E3A
	Offset: 0x39D0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function laststand_invulnerability()
{
	self endon(#"disconnect", #"death");
	self enableinvulnerability();
	wait(level.var_5c13c13f);
	self disableinvulnerability();
}

/*
	Name: function_6da86ae
	Namespace: laststand_warzone
	Checksum: 0xCE4A2FFF
	Offset: 0x3A38
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_6da86ae()
{
	if(isdefined(self) && isdefined(self.laststandparams) && !isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
	}
}

/*
	Name: function_dab36dc8
	Namespace: laststand_warzone
	Checksum: 0x28E8A17F
	Offset: 0x3A88
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_dab36dc8()
{
	self notify("5f151ca8bf9ba24f");
	self endon("5f151ca8bf9ba24f");
	self endon(#"hash_6b045e0bc320bbee");
	revivetrigger = self.revivetrigger;
	self waittill(#"disconnect");
	if(isdefined(revivetrigger))
	{
		revivetrigger delete();
	}
}

/*
	Name: bleed_out
	Namespace: laststand_warzone
	Checksum: 0x2EBE2527
	Offset: 0x3B08
	Size: 0x6A6
	Parameters: 1
	Flags: Linked
*/
function bleed_out(var_40d90c02)
{
	self endon(#"player_revived", #"death", #"disconnect");
	self thread function_dab36dc8();
	util::wait_network_frame();
	self function_2907ce7a();
	self function_b1303a37();
	self clientfield::set("laststand_bleed", 0);
	demo::bookmark(#"player_bledout", gettime(), self, undefined, 1);
	potm::bookmark(#"player_bledout", gettime(), self, undefined, 1);
	level notify(#"bleed_out", {#character_index:self.characterindex});
	self notify(#"player_bleedout");
	callback::callback(#"on_player_bleedout");
	self undolaststand();
	self val::reset(#"last_stand", "show_weapon_hud");
	self.uselaststandparams = 1;
	self function_6da86ae();
	suicide_mod = "MOD_BLED_OUT";
	if(isdefined(self.laststandparams) && (!(isdefined(self.var_1cc38de0) && self.var_1cc38de0)))
	{
		self.laststandparams.bledout = 1;
	}
	if(isdefined(self.var_d75a6ff5))
	{
		self.var_d75a6ff5.death = isdefined(self.var_1cc38de0) && self.var_1cc38de0;
		self.var_d75a6ff5.bleed_out = !self.var_d75a6ff5.death;
		self function_1e8018b0();
	}
	var_620529b4 = (isdefined(self.laststandparams) ? self.laststandparams.attacker : undefined);
	if(self util::isenemyplayer(var_620529b4))
	{
		var_620529b4 thread globallogic_score::givekillstats(self.laststandparams.smeansofdeath, self.laststandparams.sweapon, self, var_620529b4);
		var_620529b4 clientfield::set_player_uimodel("hudItems.playerKills", var_620529b4.kills);
		if(var_40d90c02)
		{
			function_f887b191(self, var_620529b4, 0, 4);
		}
		else
		{
			function_f887b191(self, var_620529b4, 0, 0);
		}
	}
	if(isdefined(self.var_a1d415ee))
	{
		attacker = self.var_a1d415ee.attacker;
		if(self.var_a1d415ee.smeansofdeath == "MOD_MELEE_ASSASSINATE")
		{
			suicide_mod = "MOD_MELEE_ASSASSINATE";
		}
		obituary(self, attacker, self.var_a1d415ee.sweapon, self.var_a1d415ee.smeansofdeath);
		if(self util::isenemyplayer(attacker))
		{
			if(isplayer(var_620529b4) && attacker == var_620529b4)
			{
				attacker function_c7d3aeec(#"kills_eliminated", 1);
			}
			else
			{
				if(attacker util::function_4ded36e3(var_620529b4))
				{
					attacker function_c7d3aeec(#"downs_eliminated_team", 1);
					function_f887b191(self, attacker, 0, 2);
				}
				else
				{
					attacker function_c7d3aeec(#"downs_eliminated", 1);
					function_f887b191(self, attacker, 0, 3);
				}
			}
		}
	}
	else
	{
		if(self util::isenemyplayer(var_620529b4))
		{
			obituary(self, var_620529b4, level.weaponnone, "MOD_BLED_OUT");
		}
		else
		{
			obituary(self, undefined, level.weaponnone, "MOD_BLED_OUT");
		}
	}
	self function_2907ce7a();
	self suicide(suicide_mod);
	if(getdvarint(#"hash_62b8db0428755a32", 1) && isplayer(self))
	{
		var_d7e063c = getdvarfloat(#"hash_44de9418bb6289ac", 1.5);
		self playsoundtoplayer(#"hash_11d39dca0f911535", self);
		self lui::screen_fade(var_d7e063c, 1, 0, "black", 0);
		wait(var_d7e063c + 0.2);
		self lui::screen_fade(var_d7e063c, 0, 1, "black", 0);
	}
	self notify(#"hash_6b045e0bc320bbee");
}

/*
	Name: respawn_player_after_time
	Namespace: laststand_warzone
	Checksum: 0xE1DE28FC
	Offset: 0x41B8
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function respawn_player_after_time(n_time_seconds)
{
	self endon(#"death", #"disconnect");
	players = getplayers();
	if(players.size == 1)
	{
		return;
	}
	self waittill(#"spawned_spectator");
	level endon(#"objective_changed");
	wait(n_time_seconds);
	if(self.sessionstate == #"spectator")
	{
		self thread globallogic_spawn::waitandspawnclient();
	}
}

/*
	Name: function_2907ce7a
	Namespace: laststand_warzone
	Checksum: 0xEFD144D9
	Offset: 0x4280
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_2907ce7a()
{
	self clientfield::set_player_uimodel("hudItems.laststand.progress", 0);
	self clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
}

/*
	Name: revive_trigger_spawn
	Namespace: laststand_warzone
	Checksum: 0x13F56161
	Offset: 0x42D0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function revive_trigger_spawn()
{
	radius = getdvarint(#"revive_trigger_radius", 100);
	self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
	self.revivetrigger sethintstring("");
	self.revivetrigger setcursorhint("HINT_NOICON");
	self.revivetrigger setmovingplatformenabled(1);
	self.revivetrigger enablelinkto();
	self.revivetrigger.origin = self.origin;
	self.revivetrigger.radius = radius;
	self.revivetrigger linkto(self);
	self.revivetrigger.beingrevived = 0;
	self.revivetrigger.var_3840aba9 = 0;
	self.revivetrigger.createtime = gettime();
	self.revivetrigger setteamfortrigger(self.team);
	self thread revive_trigger_think();
}

/*
	Name: function_2dcf15cb
	Namespace: laststand_warzone
	Checksum: 0x1C8380FC
	Offset: 0x4468
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function function_2dcf15cb(team)
{
	players = level.aliveplayers[self.team];
}

/*
	Name: revive_trigger_think
	Namespace: laststand_warzone
	Checksum: 0x9DC479A6
	Offset: 0x4498
	Size: 0x298
	Parameters: 0
	Flags: Linked
*/
function revive_trigger_think()
{
	self endon(#"stop_revive_trigger");
	teams = self function_2b77bc35();
	enemy_teams = function_fb02bdd4(teams);
	wait(0.1);
	while(isdefined(self) && (!(isdefined(level.gameended) && level.gameended)))
	{
		if(!isdefined(self))
		{
			break;
		}
		if(!isdefined(self.revivetrigger))
		{
			self notify(#"stop_revive_trigger");
			continue;
		}
		if(!isalive(self))
		{
			continue;
		}
		self.revivetrigger sethintstring("");
		/#
			if(getdvarint(#"lastand_selfrevive", 0) && self attackbuttonpressed() && self throwbuttonpressed() && self fragbuttonpressed())
			{
				self thread revive_success(self);
				self function_2907ce7a();
				return;
			}
		#/
		foreach(team in teams)
		{
			if(function_55f6978f(team))
			{
				return;
			}
		}
		if(function_feb3e91d())
		{
			foreach(team in enemy_teams)
			{
				if(function_356caede(team))
				{
					return;
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_356caede
	Namespace: laststand_warzone
	Checksum: 0x72554345
	Offset: 0x4738
	Size: 0x7EA
	Parameters: 1
	Flags: Linked
*/
function function_356caede(team)
{
	if(!isdefined(self))
	{
		return false;
	}
	if(!isdefined(level.alivecount) || !isdefined(level.alivecount[team]))
	{
		return false;
	}
	if(level.alivecount[team] == 0)
	{
		return false;
	}
	if(!isdefined(self.revivetrigger))
	{
		return false;
	}
	players = getplayers(team, self.revivetrigger.origin, self.revivetrigger.radius);
	height = getdvarint(#"hash_48068f92d21e2a64", 15);
	foreach(player in players)
	{
		if(player can_revive(self, 1, height))
		{
			self.revivetrigger setrevivehintstring(#"hash_a9213d7fcad1656", team);
			break;
		}
	}
	foreach(finisher in players)
	{
		if(self == finisher || !finisher is_reviving(self, 0, height) || finisher is_reviving_any() || finisher function_5c574004())
		{
			continue;
		}
		self clientfield::set_player_uimodel("hudItems.beingFinished", 1);
		finisher function_684a5394();
		var_c9c35e60 = (getdvarint(#"hash_4fe437fabb65172a", 0) > 0 ? getdvarint(#"hash_4fe437fabb65172a", 0) : randomintrange(1, level.var_91c33dcb.finishers.size - 1));
		var_dc5a63bd = level.var_91c33dcb.finishers.size - 1;
		if(isdefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising") && finisher clientfield::get("hasspectrebody"))
		{
			var_c9c35e60 = var_dc5a63bd;
		}
		/#
			assert(level.var_91c33dcb.finishers.size >= var_c9c35e60);
		#/
		var_abdbed5a = level.var_91c33dcb.finishers[var_c9c35e60].("finisherbundle");
		var_d1d9820d = getscriptbundle(var_abdbed5a);
		if(isdefined(var_d1d9820d.("attacker_gesture")))
		{
			finisher function_c6775cf9(var_d1d9820d.("attacker_gesture"));
		}
		if(isdefined(var_d1d9820d.("victim_gesture")))
		{
			self function_c6775cf9(var_d1d9820d.("victim_gesture"));
		}
		self function_fab0e07e(finisher);
		if(!isdefined(finisher))
		{
			return false;
		}
		if(!isdefined(self) || !isalive(self) || !isalive(finisher))
		{
			finisher function_b16f016a();
			if(isdefined(self))
			{
				self clientfield::set_player_uimodel("hudItems.beingFinished", 0);
			}
			return false;
		}
		finisher disableweaponcycling();
		finisher disableusability();
		finisher disableoffhandweapons();
		self flagsys::clear(#"hash_40e3b09bdbcdac81");
		var_62728357 = finisher function_1c8cab15(self);
		if(isdefined(finisher))
		{
			finisher function_b16f016a();
			finisher enableweaponcycling();
			finisher enableusability();
			finisher enableoffhandweapons();
			var_e24d6046 = finisher gettagangles("tag_sync");
			kill_origin = finisher gettagorigin("tag_sync");
			if(isdefined(self))
			{
				if(isdefined(var_62728357) && var_62728357)
				{
					weapon = getweapon(#"bare_hands");
					scoreevents::processscoreevent(#"finishers", finisher, self, weapon);
					self function_516a3bef(0);
					self setplayerangles(var_e24d6046);
					self setorigin(kill_origin);
					self dodamage(self.var_969fabf4, self.origin, finisher, undefined, "none", "MOD_MELEE_ASSASSINATE", 8192);
					self function_2907ce7a();
					return true;
				}
				self clientfield::set_player_uimodel("hudItems.beingFinished", 0);
				self function_516a3bef(1);
				self function_7c685040();
			}
			finisher function_7c685040();
		}
	}
	return false;
}

/*
	Name: function_684a5394
	Namespace: laststand_warzone
	Checksum: 0x3285F840
	Offset: 0x4F30
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_684a5394()
{
	if(!isdefined(self.var_5c574004))
	{
		self.var_5c574004 = 0;
	}
	self.var_5c574004++;
}

/*
	Name: function_b16f016a
	Namespace: laststand_warzone
	Checksum: 0xA72E5A78
	Offset: 0x4F60
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_b16f016a()
{
	self.var_5c574004--;
	if(self.var_5c574004 < 0)
	{
		self.var_5c574004 = 0;
	}
	else if(self.var_5c574004 > 99999)
	{
		self.var_5c574004 = 99999;
	}
}

/*
	Name: function_fab0e07e
	Namespace: laststand_warzone
	Checksum: 0x2767F4AB
	Offset: 0x4FB8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_fab0e07e(finisher)
{
	self endon(#"disconnect");
	finisher endon(#"disconnect");
	waitframe(1);
	if(isdefined(self) && isdefined(finisher) && isalive(self) && isalive(finisher))
	{
		if(isdefined(self.laststandparams))
		{
			self.laststandparams.var_3f57b6a0 = self.origin;
			self.laststandparams.savedangles = self.angles;
		}
		self playerlinkto(finisher, "tag_sync");
	}
}

/*
	Name: function_516a3bef
	Namespace: laststand_warzone
	Checksum: 0x29CA0616
	Offset: 0x5098
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_516a3bef(replace)
{
	if(isalive(self) && function_feb3e91d())
	{
		self unlink();
		if(isdefined(replace) && replace && isdefined(self.laststandparams) && isdefined(self.laststandparams.var_3f57b6a0))
		{
			self setorigin(self.laststandparams.var_3f57b6a0);
		}
	}
}

/*
	Name: function_55f6978f
	Namespace: laststand_warzone
	Checksum: 0x8DDF967
	Offset: 0x5158
	Size: 0x338
	Parameters: 1
	Flags: Linked
*/
function function_55f6978f(team)
{
	if(!isdefined(team))
	{
		return false;
	}
	if(!isdefined(self))
	{
		return false;
	}
	if(!isdefined(self.revivetrigger))
	{
		return false;
	}
	players = getplayers(team, self.revivetrigger.origin, self.revivetrigger.radius);
	foreach(player in players)
	{
		if(player can_revive(self, 1))
		{
			self.revivetrigger setrevivehintstring(#"hash_6ba778165639acc4", team);
			break;
		}
	}
	foreach(reviver in players)
	{
		if(self == reviver || !reviver is_reviving(self, 0))
		{
			continue;
		}
		gun = reviver getcurrentweapon();
		/#
			assert(isdefined(gun));
		#/
		if(gun == level.weaponrevivetool)
		{
			continue;
		}
		reviver giveweapon(level.weaponrevivetool);
		reviver switchtoweapon(level.weaponrevivetool, 1);
		reviver setweaponammostock(level.weaponrevivetool, 1);
		reviver disableweaponcycling();
		reviver disableusability();
		reviver disableoffhandweapons();
		revive_success = reviver revive_do_revive(self);
		if(isdefined(reviver))
		{
			reviver revive_give_back_weapons();
			if(isdefined(revive_success) && revive_success)
			{
				self thread revive_success(reviver);
				self function_2907ce7a();
				return true;
			}
		}
	}
	return false;
}

/*
	Name: revive_give_back_weapons
	Namespace: laststand_warzone
	Checksum: 0x2D508A64
	Offset: 0x5498
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function revive_give_back_weapons()
{
	if(!isdefined(self) || (isdefined(self.laststand) && self.laststand))
	{
		return;
	}
	self takeweapon(level.weaponrevivetool);
	self enableweaponcycling();
	self enableusability();
	self enableoffhandweapons();
	self weapons::function_d571ac59();
}

/*
	Name: can_revive
	Namespace: laststand_warzone
	Checksum: 0x25DCCBE1
	Offset: 0x5550
	Size: 0x1F6
	Parameters: 3
	Flags: Linked
*/
function can_revive(revivee, ignore_touch_checks = 0, height = undefined)
{
	if(!isalive(self))
	{
		return false;
	}
	if(self laststand::player_is_in_laststand())
	{
		return false;
	}
	if(!ignore_touch_checks)
	{
		if(!self istouching(revivee.revivetrigger))
		{
			return false;
		}
	}
	if(!self laststand::is_facing(revivee, 0.8))
	{
		return false;
	}
	if(isdefined(height))
	{
		delta = revivee.origin[2] - self.origin[2];
		if(delta > height || delta < (height * -1))
		{
			return false;
		}
	}
	if(distancesquared(revivee.origin, self.origin) > 140 * 140)
	{
		return false;
	}
	if(!sighttracepassed(self.origin + vectorscale((0, 0, 1), 50), revivee.origin + vectorscale((0, 0, 1), 30), 0, undefined))
	{
		return false;
	}
	if(!bullettracepassed(self.origin + vectorscale((0, 0, 1), 50), revivee.origin + vectorscale((0, 0, 1), 30), 0, undefined))
	{
		return false;
	}
	return true;
}

/*
	Name: is_reviving
	Namespace: laststand_warzone
	Checksum: 0x79D08A25
	Offset: 0x5750
	Size: 0xB4
	Parameters: 3
	Flags: Linked
*/
function is_reviving(revivee, ignore_touch_checks = 0, height = undefined)
{
	if(!isdefined(self) || !isdefined(revivee))
	{
		return 0;
	}
	if(!isalive(revivee))
	{
		return 0;
	}
	if(!isdefined(revivee.revivetrigger))
	{
		return 0;
	}
	return self usebuttonpressed() && self can_revive(revivee, ignore_touch_checks, height);
}

/*
	Name: is_reviving_any
	Namespace: laststand_warzone
	Checksum: 0x4E913811
	Offset: 0x5810
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function is_reviving_any()
{
	return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

/*
	Name: function_5c574004
	Namespace: laststand_warzone
	Checksum: 0x59515D79
	Offset: 0x5830
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_5c574004()
{
	return isdefined(self.var_5c574004) && self.var_5c574004;
}

/*
	Name: revive_do_revive
	Namespace: laststand_warzone
	Checksum: 0x1C6E0F72
	Offset: 0x5850
	Size: 0x5E8
	Parameters: 1
	Flags: Linked
*/
function revive_do_revive(playerbeingrevived)
{
	self endon(#"disconnect");
	if(!isdefined(playerbeingrevived))
	{
		return 0;
	}
	if(!self is_reviving(playerbeingrevived, 1))
	{
		return 0;
	}
	/#
		assert(self is_reviving(playerbeingrevived, 1));
	#/
	revivetime = getdvarfloat(#"g_revivetime", 3) * self function_bd85bc2f();
	timer = 0;
	revived = 0;
	playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 1);
	playerbeingrevived.revivetrigger.beingrevived = 1;
	playerbeingrevived.revivetrigger sethintstring("");
	if(isplayer(playerbeingrevived))
	{
		playerbeingrevived startrevive(self);
	}
	self thread laststand_clean_up_on_interrupt(playerbeingrevived);
	if(!isdefined(self.is_reviving_any))
	{
		self.is_reviving_any = 0;
	}
	self.is_reviving_any++;
	self playsound(#"hash_7f077925d3f525ad");
	self playloopsound(#"hash_67a426610a2d2a2d");
	if(isdefined(playerbeingrevived.var_d75a6ff5))
	{
		playerbeingrevived.var_d75a6ff5.var_d10f3b9a++;
	}
	self.reviving_player = playerbeingrevived;
	self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", playerbeingrevived getentitynumber());
	while(self is_reviving(playerbeingrevived, 0))
	{
		if(isdefined(level.gameended) && level.gameended)
		{
			return 0;
		}
		if(self laststand::player_is_in_laststand())
		{
			playerbeingrevived.reviveprogress = 0;
			break;
		}
		if(isdefined(playerbeingrevived.revivetrigger) && (isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive))
		{
			playerbeingrevived.reviveprogress = 0;
			break;
		}
		playerbeingrevived.reviveprogress = min(timer / revivetime, 1);
		if(timer >= revivetime)
		{
			revived = 1;
			break;
		}
		self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", playerbeingrevived.reviveprogress);
		waitframe(1);
		timer = timer + (float(function_60d95f53()) / 1000);
	}
	self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", 0);
	self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	self stoploopsound(1);
	if(isdefined(playerbeingrevived))
	{
		playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
		playerbeingrevived.reviveprogress = 0;
		if(isdefined(revived) && revived)
		{
			playerbeingrevived playsound(#"hash_39e55bff84ce34c8");
		}
		else
		{
			self playsound(#"hash_c2688a5ec1ca2b5");
		}
		if(isdefined(playerbeingrevived.revivetrigger) && (!(isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive)) && !revived)
		{
			if(isplayer(playerbeingrevived) && isalive(playerbeingrevived))
			{
				playerbeingrevived stoprevive(self);
			}
		}
		if(isdefined(playerbeingrevived.revivetrigger))
		{
			playerbeingrevived.revivetrigger.beingrevived = 0;
		}
	}
	self.reviving_player = undefined;
	self notify(#"do_revive_ended_normally");
	self thread function_adecbc95();
	return revived;
}

/*
	Name: function_adecbc95
	Namespace: laststand_warzone
	Checksum: 0x326172DD
	Offset: 0x5E40
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_adecbc95()
{
	self endon(#"disconnect");
	while(self usebuttonpressed())
	{
		waitframe(1);
	}
	self.is_reviving_any--;
	if(self.is_reviving_any < 0)
	{
		self.is_reviving_any = 0;
	}
	else if(self.is_reviving_any > 99999)
	{
		self.is_reviving_any = 99999;
	}
}

/*
	Name: function_c82a14d1
	Namespace: laststand_warzone
	Checksum: 0xA78B497C
	Offset: 0x5ED0
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_c82a14d1(finisher)
{
	self endon(#"death", #"disconnect", #"finish_abort");
	finisher endon(#"death", #"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"contact");
	self flagsys::set(#"hash_40e3b09bdbcdac81");
	self notify(#"player_finished");
}

/*
	Name: function_1c8cab15
	Namespace: laststand_warzone
	Checksum: 0xDF2760BB
	Offset: 0x5F90
	Size: 0x188
	Parameters: 1
	Flags: Linked
*/
function function_1c8cab15(var_b4bb7319)
{
	var_b4bb7319 endon(#"disconnect");
	self endon(#"disconnect");
	if(isdefined(var_b4bb7319.revivetrigger))
	{
		var_b4bb7319.revivetrigger.var_3840aba9 = 1;
	}
	var_b4bb7319 thread function_c82a14d1(self);
	while(isdefined(var_b4bb7319) && isalive(var_b4bb7319) && isalive(self) && !self laststand::player_is_in_laststand() && var_b4bb7319 laststand::player_is_in_laststand() && !var_b4bb7319 flagsys::get(#"hash_40e3b09bdbcdac81") && !self is_reviving_any())
	{
		waitframe(1);
	}
	if(isdefined(var_b4bb7319.revivetrigger))
	{
		var_b4bb7319.revivetrigger.var_3840aba9 = 0;
	}
	if(isdefined(var_b4bb7319) && var_b4bb7319 flagsys::get(#"hash_40e3b09bdbcdac81"))
	{
		return true;
	}
	return false;
}

/*
	Name: auto_revive_on_notify
	Namespace: laststand_warzone
	Checksum: 0x38631D06
	Offset: 0x6120
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function auto_revive_on_notify()
{
	/#
		self endon(#"death", #"disconnect", #"player_revived");
		waitresult = undefined;
		waitresult = self waittill(#"auto_revive");
		self thread revive_success(waitresult.reviver);
	#/
}

/*
	Name: function_b1303a37
	Namespace: laststand_warzone
	Checksum: 0xAAB17AA4
	Offset: 0x61A8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_b1303a37()
{
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
		self.revivetrigger = undefined;
	}
}

/*
	Name: revive_success
	Namespace: laststand_warzone
	Checksum: 0x741EF2BC
	Offset: 0x61E8
	Size: 0x524
	Parameters: 2
	Flags: Linked
*/
function revive_success(reviver, b_track_stats = 1)
{
	self.var_156bf46e = undefined;
	if(!isplayer(self))
	{
		self notify(#"player_revived", {#reviver:reviver});
		return;
	}
	self function_102748f8();
	if(self util::function_4ded36e3(reviver))
	{
		reviver stats::function_d40764f3(#"revives", 1);
		reviver stats::function_b7f80d87(#"revives", 1);
		reviver.revives = reviver function_6f7bff5d(#"revives", 1);
	}
	if(isdefined(self.laststandparams) && self util::isenemyplayer(self.laststandparams.attacker))
	{
		self.laststandparams.attacker stats::function_d40764f3(#"downs_revived", 1);
	}
	self.var_d887a4ad = 1;
	var_cbf9fa14 = getdvarint(#"hash_77107267fe87b359", 350) / 1000;
	wait(var_cbf9fa14);
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(b_track_stats) && b_track_stats)
	{
		demo::bookmark(#"player_revived", gettime(), reviver, self);
		potm::bookmark(#"player_revived", gettime(), reviver, self);
	}
	if(isplayer(self))
	{
		self allowjump(1);
	}
	if(isdefined(self.laststandparams) && isdefined(self.laststandparams.attacker))
	{
		attacker = self.laststandparams.attacker;
	}
	self.laststandparams = undefined;
	self.laststand = undefined;
	self notify(#"player_revived", {#reviver:reviver});
	self laststand_enable_player_weapons();
	if(!isdefined(self))
	{
		return;
	}
	self reviveplayer();
	self.var_d887a4ad = undefined;
	health = getdvarint(#"hash_7036719f41a78d54", 0);
	if(isdefined(reviver))
	{
		var_e705e073 = reviver function_15098882();
		if(var_e705e073 > 0)
		{
			health = var_e705e073;
		}
	}
	self.health = health;
	self function_b1303a37();
	self clientfield::set("laststand_bleed", 0);
	self function_2907ce7a();
	self lui::screen_close_menu();
	self val::reset(#"last_stand", "show_weapon_hud");
	self function_1e8018b0();
	if(!isdefined(self.pers[#"timesrevived"]))
	{
		self.pers[#"timesrevived"] = 0;
	}
	self.pers[#"timesrevived"]++;
	voiceevent("player_revived", self, {#reviver:reviver});
	var_d13a1b67 = {#attacker:attacker, #reviver:reviver};
	callback::callback(#"on_player_revived", var_d13a1b67);
}

/*
	Name: function_ecdd4b27
	Namespace: laststand_warzone
	Checksum: 0x44C35985
	Offset: 0x6718
	Size: 0x226
	Parameters: 1
	Flags: Linked
*/
function function_ecdd4b27(attacker)
{
	if(game.state == "pregame" || !isplayer(self) || isdefined(self.var_d75a6ff5))
	{
		return;
	}
	self.var_45b88627 = gettime();
	var_b53a7363 = 0;
	friendlyfire = 0;
	if(isdefined(attacker) && isplayer(attacker))
	{
		var_b53a7363 = attacker getxuid(1);
		friendlyfire = self util::function_4ded36e3(attacker);
	}
	self.var_d75a6ff5 = {#hash_35b89428:0, #hash_d733f8d7:0, #hash_d10f3b9a:0, #bleed_out:0, #death:0, #damage:0, #end_time:0, #start_time:function_f8d53445(), #victim_pos_z:self.origin[2], #victim_pos_y:self.origin[1], #victim_pos_x:self.origin[0], #friendly_fire:friendlyfire, #hash_19ead858:int(var_b53a7363), #player_xuid:int(self getxuid(1))};
}

/*
	Name: function_1e8018b0
	Namespace: laststand_warzone
	Checksum: 0x295F4D81
	Offset: 0x6948
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_1e8018b0()
{
	if(game.state == "pregame" || !isplayer(self) || !isdefined(self.var_d75a6ff5))
	{
		return;
	}
	self.var_d75a6ff5.end_time = function_f8d53445();
	function_92d1707f(#"hash_1df8d9815fc22893", self.var_d75a6ff5);
	self.var_d75a6ff5 = undefined;
}

/*
	Name: function_b1ad0b64
	Namespace: laststand_warzone
	Checksum: 0x13593B62
	Offset: 0x69F8
	Size: 0xB8
	Parameters: 2
	Flags: Linked
*/
function function_b1ad0b64(idamage, smeansofdeath)
{
	if(!(isdefined(self.laststand) && self.laststand))
	{
		return 0;
	}
	playermelee = smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT" || smeansofdeath == "MOD_MELEE_ASSASSINATE";
	if(playermelee)
	{
		return 1;
	}
	var_47b2d26b = idamage / self.var_969fabf4;
	damagetime = self.var_84c0402e * var_47b2d26b;
	return self.bleedout_time <= damagetime;
}

/*
	Name: function_7e714b6a
	Namespace: laststand_warzone
	Checksum: 0xD0684724
	Offset: 0x6AB8
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_7e714b6a()
{
	if(!isplayer(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	self.laststandcount = undefined;
}

