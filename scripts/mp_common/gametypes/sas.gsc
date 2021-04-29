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
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;
#using scripts\mp_common\util.gsc;

#namespace sas;

/*
	Name: main
	Namespace: sas
	Checksum: 0xC6356497
	Offset: 0x368
	Size: 0x514
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	globallogic::init();
	level.weapon_sas_primary_weapon = getweapon("special_crossbow_t8_sas");
	level.weapon_sas_secondary_weapon = getweapon("special_ballisticknife_t8_dw");
	level.weapon_sas_primary_grenade_weapon = getweapon("hatchet");
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 15000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	level.onstartgametype = &onstartgametype;
	level.onplayerdamage = &onplayerdamage;
	level.onendgame = &onendgame;
	level.pointsperprimarykill = getgametypesetting("pointsPerPrimaryKill") * 5;
	level.pointspersecondarykill = getgametypesetting("pointsPerSecondaryKill") * 5;
	level.pointsperprimarygrenadekill = getgametypesetting("pointsPerPrimaryGrenadeKill") * 5;
	level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill") * 5;
	level.setbacks = getgametypesetting("setbacks");
	player::function_cf3aa03d(&onplayerkilled);
	switch(getgametypesetting("gunSelection"))
	{
		case 0:
		{
			level.setbackweapon = undefined;
			break;
		}
		case 1:
		{
			level.setbackweapon = level.weapon_sas_primary_grenade_weapon;
			break;
		}
		case 2:
		{
			level.setbackweapon = level.weapon_sas_primary_weapon;
			break;
		}
		case 3:
		{
			level.setbackweapon = level.weapon_sas_secondary_weapon;
			break;
		}
		default:
		{
			/#
				assert(1, "");
			#/
			break;
		}
	}
	gameobjects::register_allowed_gameobject(level.gametype);
	level.givecustomloadout = &givecustomloadout;
	var_f429264b = [];
	if(!isdefined(var_f429264b))
	{
		var_f429264b = [];
	}
	else if(!isarray(var_f429264b))
	{
		var_f429264b = array(var_f429264b);
	}
	var_f429264b[var_f429264b.size] = "specialty_sprint";
	if(!isdefined(var_f429264b))
	{
		var_f429264b = [];
	}
	else if(!isarray(var_f429264b))
	{
		var_f429264b = array(var_f429264b);
	}
	var_f429264b[var_f429264b.size] = "specialty_slide";
	if(!isdefined(var_f429264b))
	{
		var_f429264b = [];
	}
	else if(!isarray(var_f429264b))
	{
		var_f429264b = array(var_f429264b);
	}
	var_f429264b[var_f429264b.size] = "specialty_sprintreload";
	if(!isdefined(var_f429264b))
	{
		var_f429264b = [];
	}
	else if(!isarray(var_f429264b))
	{
		var_f429264b = array(var_f429264b);
	}
	var_f429264b[var_f429264b.size] = "specialty_sprintheal";
	level.var_f429264b = var_f429264b;
	globallogic_spawn::addsupportedspawnpointtype("ffa");
	globallogic_audio::set_leader_gametype_dialog("startSticksAndStones", "hcStartSticksAndStones", undefined, undefined, "bbStartSticksAndStones", "hcbbStartSticksAndStones");
}

/*
	Name: givecustomloadout
	Namespace: sas
	Checksum: 0x2A07EAE9
	Offset: 0x888
	Size: 0x3C0
	Parameters: 0
	Flags: None
*/
function givecustomloadout()
{
	defaultweapon = level.weapon_sas_primary_weapon;
	loadout::init_player(1);
	loadout::function_f436358b(self.curclass);
	self function_e6f9e3cd();
	self giveperks();
	self giveweapon(defaultweapon);
	self.primaryloadoutweapon = defaultweapon;
	secondaryweapon = level.weapon_sas_secondary_weapon;
	self giveweapon(secondaryweapon);
	self setweaponammostock(secondaryweapon, 2);
	self.secondaryloadoutweapon = defaultweapon;
	offhandprimary = level.weapon_sas_primary_grenade_weapon;
	self giveweapon(offhandprimary);
	self setweaponammoclip(offhandprimary, 1);
	self.grenadetypeprimary = offhandprimary;
	self.grenadetypeprimarycount = 1;
	loadout = self loadout::function_e27dc453("primarygrenade");
	loadout.weapon = offhandprimary;
	loadout.count = 1;
	self ability_util::gadget_reset(offhandprimary, 0, 0, 1, 0);
	self ability_util::function_36a15b60(offhandprimary);
	self.heroweapon = undefined;
	var_5a17505c = (isdefined(getgametypesetting(#"hash_4ca06c610b5d53bd")) ? getgametypesetting(#"hash_4ca06c610b5d53bd") : 0);
	if(!var_5a17505c)
	{
		secondaryoffhand = getweapon(#"gadget_health_regen");
		secondaryoffhandcount = 0;
		self giveweapon(secondaryoffhand);
		self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
		loadout = self loadout::function_e27dc453("specialgrenade");
		loadout.weapon = secondaryoffhand;
		loadout.count = secondaryoffhandcount;
		self ability_util::function_36a15b60(secondaryoffhand);
	}
	self switchtoweapon(defaultweapon);
	self setspawnweapon(defaultweapon);
	self.killswithsecondary = 0;
	self.killswithprimary = 0;
	self.killswithbothawarded = 0;
	if(isbot(self) && !isdefined(level.botweapons[level.weapon_sas_primary_weapon.name]))
	{
		bot_action::function_ab03ca93(level.weapon_sas_primary_weapon.name);
	}
	return defaultweapon;
}

/*
	Name: giveperks
	Namespace: sas
	Checksum: 0x233C342D
	Offset: 0xC50
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function giveperks()
{
	self clearperks();
	foreach(perkname in level.var_f429264b)
	{
		if(!self hasperk(perkname))
		{
			self setperk(perkname);
		}
	}
}

/*
	Name: onplayerdamage
	Namespace: sas
	Checksum: 0xB43ECB82
	Offset: 0xD08
	Size: 0x126
	Parameters: 10
	Flags: None
*/
function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(weapon == level.weapon_sas_primary_weapon && smeansofdeath == "MOD_IMPACT")
	{
		if(isdefined(eattacker) && isplayer(eattacker))
		{
			if(!isdefined(eattacker.pers[#"sticks"]))
			{
				eattacker.pers[#"sticks"] = 1;
			}
			else
			{
				eattacker.pers[#"sticks"]++;
			}
			eattacker.sticks = eattacker.pers[#"sticks"];
		}
	}
	return idamage;
}

/*
	Name: onplayerkilled
	Namespace: sas
	Checksum: 0x4498351A
	Offset: 0xE38
	Size: 0x494
	Parameters: 9
	Flags: None
*/
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(isdefined(attacker) && isplayer(attacker) && attacker != self)
	{
		if(weapon_utils::ismeleemod(smeansofdeath))
		{
			attacker globallogic_score::givepointstowin(int(level.pointspermeleekill));
			scoreevents::processscoreevent(#"hash_6c8030eb05b53d5a", attacker, self, weapon);
		}
		else if(weapon == level.weapon_sas_primary_weapon)
		{
			attacker.killswithprimary++;
			if(attacker.killswithbothawarded == 0 && attacker.killswithsecondary > 0)
			{
				attacker.killswithbothawarded = 1;
			}
			attacker globallogic_score::givepointstowin(level.pointsperprimarykill);
			scoreevents::processscoreevent(#"hash_614b27b37ccee280", attacker, self, weapon);
		}
		else if(weapon == level.weapon_sas_primary_grenade_weapon)
		{
			attacker globallogic_score::givepointstowin(int(level.pointsperprimarygrenadekill));
		}
		else if(weapon == level.weapon_sas_secondary_weapon)
		{
			attacker.killswithsecondary++;
			if(attacker.killswithbothawarded == 0 && attacker.killswithprimary > 0)
			{
				attacker.killswithbothawarded = 1;
			}
		}
		attacker globallogic_score::givepointstowin(level.pointspersecondarykill);
		scoreevents::processscoreevent(#"hash_25ec47f9609803a9", attacker, self, weapon);
		if(isdefined(level.setbackweapon) && weapon == level.setbackweapon)
		{
			self.pers[#"humiliated"]++;
			self.humiliated = self.pers[#"humiliated"];
			if(globallogic_score::gethighestscoringplayer() === self)
			{
				scoreevents::processscoreevent(#"hash_4ba3fd0437520af2", attacker, self, weapon);
			}
			if(level.setbacks == 0)
			{
				self globallogic_score::setpointstowin(0);
				globallogic_score::_setplayerscore(self, 0);
			}
			else
			{
				self globallogic_score::givepointstowin(level.setbacks * -1);
			}
			attacker playlocalsound("mpl_fracture_sting_moved");
			self globallogic_audio::leader_dialog_on_player("sasHumiliated");
			scoreevents::processscoreevent(#"hash_4c6081a9cebf868a", attacker, self, weapon);
		}
	}
	else
	{
		self.pers[#"humiliated"]++;
		self.humiliated = self.pers[#"humiliated"];
		if(level.setbacks == 0)
		{
			self globallogic_score::setpointstowin(0);
		}
		else
		{
			self globallogic_score::givepointstowin(level.setbacks * -1);
		}
		self playlocalsound(#"mpl_wager_humiliate");
	}
}

/*
	Name: onendgame
	Namespace: sas
	Checksum: 0x7741D0FC
	Offset: 0x12D8
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
	Name: function_bbf3128e
	Namespace: sas
	Checksum: 0x4C0F12E4
	Offset: 0x1320
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function function_bbf3128e()
{
	self endon(#"disconnect", #"death");
}

/*
	Name: setupteam
	Namespace: sas
	Checksum: 0x7FC0CCC5
	Offset: 0x1350
	Size: 0xDE
	Parameters: 1
	Flags: None
*/
function setupteam(team)
{
	util::setobjectivetext(team, #"objectives_sas");
	if(level.splitscreen)
	{
		util::setobjectivescoretext(team, #"objectives_sas");
	}
	else
	{
		util::setobjectivescoretext(team, #"objectives_sas_score");
	}
	spawning::add_spawn_points(team, "mp_dm_spawn");
	spawning::place_spawn_points("mp_dm_spawn_start");
	level.spawn_start = spawning::get_spawnpoint_array("mp_dm_spawn_start");
}

/*
	Name: onstartgametype
	Namespace: sas
	Checksum: 0xCFE716D7
	Offset: 0x1438
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	influencers::create_map_placed_influencers();
}

