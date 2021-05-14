// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_2255a7ad3edc838f;
#using script_2c49ae69cd8ce30c;
#using script_47fb62300ac0bd60;
#using script_5399f402045d7abd;
#using script_56ca01b3b31455b5;
#using script_788472602edbe3b9;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_defaults.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_ui.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;
#using scripts\mp_common\util.gsc;

#namespace oic;

/*
	Name: main
	Namespace: oic
	Checksum: 0x83140A39
	Offset: 0x350
	Size: 0x6FC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	globallogic::init();
	level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill") * 10;
	level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill") * 10;
	level.pointsforsurvivalbonus = getgametypesetting("pointsForSurvivalBonus") * 10;
	level.var_18823aed = 60;
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	level.onstartgametype = &onstartgametype;
	level.onspawnplayer = &onspawnplayer;
	level.givecustomloadout = &givecustomloadout;
	level.onplayerdamage = &onplayerdamage;
	level.onendgame = &onendgame;
	player::function_cf3aa03d(&onplayerkilled);
	var_a7caf947 = [];
	if(!isdefined(var_a7caf947))
	{
		var_a7caf947 = [];
	}
	else if(!isarray(var_a7caf947))
	{
		var_a7caf947 = array(var_a7caf947);
	}
	var_a7caf947[var_a7caf947.size] = "specialty_sprint";
	if(!isdefined(var_a7caf947))
	{
		var_a7caf947 = [];
	}
	else if(!isarray(var_a7caf947))
	{
		var_a7caf947 = array(var_a7caf947);
	}
	var_a7caf947[var_a7caf947.size] = "specialty_slide";
	level.var_a7caf947 = var_a7caf947;
	globallogic_spawn::addsupportedspawnpointtype("ffa");
	var_1f99b9e8 = [];
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"hero_annihilator" + "_oic", "");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "uber");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_fullauto_t8" + "_oic", "");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_topbreak_t8" + "_oic", "");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "pistolscope");
	if(!isdefined(var_1f99b9e8))
	{
		var_1f99b9e8 = [];
	}
	else if(!isarray(var_1f99b9e8))
	{
		var_1f99b9e8 = array(var_1f99b9e8);
	}
	var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "uber");
	level.gunselection = getgametypesetting(#"gunselection");
	level.var_bf82f6b0 = var_1f99b9e8[level.gunselection];
	level.takelivesondeath = 1;
	globallogic_audio::set_leader_gametype_dialog("startOneInTheChamber", "hcStartOneInTheChamber", undefined, undefined, "bbStartOneInTheChamber", "hcbbStartOneInTheChamber");
}

/*
	Name: onplayerdamage
	Namespace: oic
	Checksum: 0x7D6D12E5
	Offset: 0xA58
	Size: 0xBC
	Parameters: 10
	Flags: None
*/
function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(level.gunselection === 7)
	{
		return idamage;
	}
	if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT")
	{
		idamage = self.maxhealth + 1;
	}
	return idamage;
}

/*
	Name: givecustomloadout
	Namespace: oic
	Checksum: 0x4DDA8AE8
	Offset: 0xB20
	Size: 0x378
	Parameters: 0
	Flags: None
*/
function givecustomloadout()
{
	loadout::init_player(1);
	loadout::function_f436358b(self.curclass);
	self setactionslot(3, "flourish_callouts");
	self setactionslot(4, "sprays_boasts");
	weapon = level.var_bf82f6b0;
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	clipammo = 1;
	if(isdefined(self.pers[#"clip_ammo"]))
	{
		clipammo = self.pers[#"clip_ammo"];
		self.pers[#"clip_ammo"] = undefined;
	}
	self setweaponammoclip(weapon, clipammo);
	stockammo = 0;
	if(isdefined(self.pers[#"stock_ammo"]))
	{
		stockammo = self.pers[#"stock_ammo"];
		self.pers[#"stock_ammo"] = undefined;
	}
	self setweaponammostock(weapon, stockammo);
	self setspawnweapon(weapon);
	self giveperks();
	var_5a17505c = (isdefined(getgametypesetting(#"hash_4ca06c610b5d53bd")) ? getgametypesetting(#"hash_4ca06c610b5d53bd") : 0);
	if(!var_5a17505c)
	{
		secondaryoffhand = getweapon(#"gadget_health_regen");
		secondaryoffhandcount = 1;
		self giveweapon(secondaryoffhand);
		self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
		self switchtooffhand(secondaryoffhand);
		loadout = self loadout::function_e27dc453("specialgrenade");
		loadout.weapon = secondaryoffhand;
		loadout.count = secondaryoffhandcount;
		self ability_util::function_36a15b60(secondaryoffhand);
	}
	if(isbot(self) && !isdefined(level.botweapons[#"hash_67d4fc759f718a27"]))
	{
		bot_action::function_ab03ca93(#"hash_67d4fc759f718a27");
	}
	return weapon;
}

/*
	Name: giveperks
	Namespace: oic
	Checksum: 0x49579F76
	Offset: 0xEA0
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function giveperks()
{
	self clearperks();
	foreach(perkname in level.var_a7caf947)
	{
		if(!self hasperk(perkname))
		{
			self setperk(perkname);
		}
	}
}

/*
	Name: onstartgametype
	Namespace: oic
	Checksum: 0x84A73B67
	Offset: 0xF58
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	allowed[0] = "oic";
	globallogic_spawn::addspawns();
	level.displayroundendtext = 0;
	level thread watchelimination();
}

/*
	Name: onspawnplayer
	Namespace: oic
	Checksum: 0x7597F50E
	Offset: 0xFB8
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function onspawnplayer(predictedspawn)
{
	if(!level.inprematchperiod)
	{
		level.usestartspawns = 0;
	}
	spawning::onspawnplayer(predictedspawn);
	clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);
	if(self.pers[#"lives"] == 1)
	{
		globallogic_audio::leader_dialog_on_player("oicLastLife");
	}
}

/*
	Name: onendgame
	Namespace: oic
	Checksum: 0x96655B0F
	Offset: 0x1060
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function onendgame(var_c1e98979)
{
	player = round::function_b5f4c9d8();
	match::function_d1e740f6(player);
}

/*
	Name: saveoffallplayersammo
	Namespace: oic
	Checksum: 0xBF39BA1A
	Offset: 0x10A8
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function saveoffallplayersammo()
{
	wait(1);
	for(playerindex = 0; playerindex < level.players.size; playerindex++)
	{
		player = level.players[playerindex];
		if(!isdefined(player))
		{
			continue;
		}
		if(player.pers[#"lives"] == 0)
		{
			continue;
		}
		currentweapon = player getcurrentweapon();
		player.pers[#"clip_ammo"] = player getweaponammoclip(currentweapon);
		player.pers[#"stock_ammo"] = player getweaponammostock(currentweapon);
	}
}

/*
	Name: isplayereliminated
	Namespace: oic
	Checksum: 0xD55AB835
	Offset: 0x11C8
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function isplayereliminated(player)
{
	return isdefined(player.pers[#"lives"]) && player.pers[#"lives"] <= 0;
}

/*
	Name: getplayersleft
	Namespace: oic
	Checksum: 0xF9894A4E
	Offset: 0x1220
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function getplayersleft()
{
	playersremaining = [];
	for(playerindex = 0; playerindex < level.players.size; playerindex++)
	{
		player = level.players[playerindex];
		if(!isdefined(player))
		{
			continue;
		}
		if(!isplayereliminated(player))
		{
			playersremaining[playersremaining.size] = player;
		}
	}
	return playersremaining;
}

/*
	Name: onplayerkilled
	Namespace: oic
	Checksum: 0xB359E2E3
	Offset: 0x12C0
	Size: 0x264
	Parameters: 9
	Flags: None
*/
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(isdefined(attacker) && isplayer(attacker) && self != attacker)
	{
		weapon = level.var_bf82f6b0;
		attackerammo = attacker getammocount(weapon);
		victimammo = self getammocount(weapon);
		if(attackerammo < 3)
		{
			attacker giveammo(1);
		}
		attacker playlocalsound("mpl_oic_bullet_pickup");
		if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT")
		{
			attacker globallogic_score::givepointstowin(level.pointspermeleekill);
			if(attackerammo > 0)
			{
				scoreevents::processscoreevent(#"knife_with_ammo_oic", attacker, self, sweapon);
			}
			if(victimammo > attackerammo)
			{
				scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", attacker, self, sweapon);
			}
		}
		else
		{
			attacker globallogic_score::givepointstowin(level.pointsperweaponkill);
			if(victimammo > attackerammo + 1)
			{
				scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", attacker, self, sweapon);
			}
		}
		if(self.pers[#"lives"] == 0)
		{
			scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, sweapon);
		}
	}
}

/*
	Name: giveammo
	Namespace: oic
	Checksum: 0x5427E0FB
	Offset: 0x1530
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function giveammo(amount)
{
	currentweapon = self getcurrentweapon();
	clipammo = self getweaponammoclip(currentweapon);
	self setweaponammoclip(currentweapon, clipammo + amount);
}

/*
	Name: shouldreceivesurvivorbonus
	Namespace: oic
	Checksum: 0x9344D36C
	Offset: 0x15A8
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function shouldreceivesurvivorbonus()
{
	if(isalive(self))
	{
		return 1;
	}
	if(self.hasspawned && self.pers[#"lives"] > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: watchelimination
	Namespace: oic
	Checksum: 0x8C7C85C0
	Offset: 0x1608
	Size: 0x190
	Parameters: 0
	Flags: None
*/
function watchelimination()
{
	level endon(#"game_ended");
	for(;;)
	{
		level waittill(#"player_eliminated");
		players = level.players;
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(players[i]) && players[i] shouldreceivesurvivorbonus())
			{
				players[i].pers[#"survived"]++;
				players[i].survived = players[i].pers[#"survived"];
				scoreevents::processscoreevent(#"survivor", players[i]);
				players[i] globallogic_score::givepointstowin(level.pointsforsurvivalbonus);
			}
		}
		survivors = getplayersleft();
		if(survivors.size == 2)
		{
			level thread function_ce7ffccb();
		}
	}
}

/*
	Name: function_ce7ffccb
	Namespace: oic
	Checksum: 0xDFF14171
	Offset: 0x17A0
	Size: 0xEC
	Parameters: 1
	Flags: Private
*/
private function function_ce7ffccb(winner)
{
	if(globallogic_utils::gettimeremaining() <= int(level.var_18823aed * 1000))
	{
		return;
	}
	if(level.var_18823aed > 0)
	{
		level.timelimitoverride = 1;
		setgameendtime(gettime() + int(level.var_18823aed * 1000));
		hostmigration::waitlongdurationwithgameendtimeupdate(level.var_18823aed);
		if(game.state != "playing")
		{
			return;
		}
	}
	thread globallogic::end_round(2);
}

