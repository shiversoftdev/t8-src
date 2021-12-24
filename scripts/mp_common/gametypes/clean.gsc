// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c49ae69cd8ce30c;
#using script_38af8be38c6709ff;
#using script_47fb62300ac0bd60;
#using script_6c8abe14025b47c4;
#using script_7b8ad364b9de169e;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;
#using scripts\mp_common\gametypes\spawnlogic.gsc;
#using scripts\mp_common\util.gsc;

#namespace clean;

/*
	Name: function_89f2df9
	Namespace: clean
	Checksum: 0x62FF81E1
	Offset: 0x650
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"clean", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: clean
	Checksum: 0x1C37C1A7
	Offset: 0x698
	Size: 0xF4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("clientuimodel", "hudItems.cleanCarryCount", 14000, 4, "int");
	clientfield::register("clientuimodel", "hudItems.cleanCarryFull", 14000, 1, "int");
	clientfield::register("scriptmover", "taco_flag", 14000, 2, "int");
	clientfield::register("allplayers", "taco_carry", 14000, 1, "int");
	clientfield::register("scriptmover", "taco_player_entnum", 14000, 4, "int");
}

/*
	Name: main
	Namespace: clean
	Checksum: 0x117017FB
	Offset: 0x798
	Size: 0x39C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	globallogic::init();
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundlimit(0, 10);
	util::registerroundswitch(0, 9);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
	level.tacos = [];
	level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
	level.teamscorepercleandeposit = getgametypesetting(#"teamscorepercleandeposit");
	level.var_2576eaeb = 0;
	level.cleandepositonlinetime = getgametypesetting(#"cleandepositonlinetime");
	level.cleandepositrotation = getgametypesetting(#"cleandepositrotation");
	level.teambased = 1;
	level.overrideteamscore = 1;
	level.onstartgametype = &onstartgametype;
	level.onspawnplayer = &onspawnplayer;
	level.var_cdb8ae2c = &function_a8da260c;
	player::function_cf3aa03d(&onplayerkilled);
	level.var_b7d7d172 = getweapon(#"clean_drop");
	level.var_c5e28dc5 = getgametypesetting(#"hash_5cc4c3042b7d4935");
	stockpileorders = (level.var_c5e28dc5 ? undefined : "stockpileOrders");
	globallogic_audio::set_leader_gametype_dialog("startStockpile", "hcStartStockpile", stockpileorders, stockpileorders, "bbStartStockpile", "hcbbStartStockpile");
	level.var_11d8b3ba = "ui/fx8_fracture_deposit_point";
	level.var_6c5ba305 = "ui/fx8_fracture_deposit_point_end";
	level.var_dfce3f1c = #"clean_deposit";
	if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
	{
		level.var_11d8b3ba = "ui/fx8_fracture_deposit_point_ire";
		level.var_6c5ba305 = "ui/fx8_fracture_deposit_point_end_ire";
		level.var_dfce3f1c = #"hash_6c8a4a73bc07da57";
	}
	callback::on_connect(&onplayerconnect);
}

/*
	Name: function_a8da260c
	Namespace: clean
	Checksum: 0x6135ED2D
	Offset: 0xB40
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function function_a8da260c()
{
	if(!isdefined(level.spawn_start))
	{
		level.spawn_start = [];
	}
	foreach(team, _ in level.teams)
	{
		spawning::add_spawn_points(team, "mp_tdm_spawn");
		spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
		level.spawn_start[team] = spawning::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
	}
	spawning::updateallspawnpoints();
}

/*
	Name: onstartgametype
	Namespace: clean
	Checksum: 0x783FA1DB
	Offset: 0xC60
	Size: 0x228
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
	{
		foreach(team in level.teams)
		{
			util::function_db4846b(team, 1);
		}
	}
	globallogic_score::resetteamscores();
	if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
	{
		level.var_1940f14e = spawn("script_model", (0, 0, 0));
		level.var_1940f14e setmodel("p8_wz_pot_of_gold_pristine");
		level.var_1940f14e hide();
	}
	level function_c1780fc7();
	level thread function_fd08eb25();
	level thread function_aafe4c74();
	level thread function_c857e45f();
	/#
		level.var_8df7db3b = 0;
		level.var_8b5ef67d = 0;
		level.var_bb42ed2 = 0;
		level.var_9d4a9561 = 0;
		level.var_b8c2e6df = 0;
	#/
	waitframe(1);
	for(i = 0; i < 50; i++)
	{
		level.tacos[i] = function_f82f0bb5();
	}
}

/*
	Name: onplayerconnect
	Namespace: clean
	Checksum: 0x59120F42
	Offset: 0xE90
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function onplayerconnect()
{
	self.pers[#"cleandeposits"] = 0;
	self.pers[#"cleandenies"] = 0;
}

/*
	Name: function_aafe4c74
	Namespace: clean
	Checksum: 0x32BC7E72
	Offset: 0xED0
	Size: 0x1E0
	Parameters: 0
	Flags: None
*/
function function_aafe4c74()
{
	level waittill(#"game_ended");
	foreach(taco in level.tacos)
	{
		if(taco clientfield::get("taco_flag") > 0)
		{
			taco clientfield::set("taco_flag", 0);
		}
	}
	foreach(var_f30b24ef in level.cleandeposithubs)
	{
		var_f30b24ef stoploopsound();
		if(isdefined(var_f30b24ef.baseeffect))
		{
			var_f30b24ef.baseeffect delete();
		}
	}
	foreach(player in level.players)
	{
		player clientfield::set("taco_carry", 0);
	}
}

/*
	Name: debug_print
	Namespace: clean
	Checksum: 0x529C668E
	Offset: 0x10B8
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function debug_print()
{
	/#
		while(true)
		{
			iprintln("" + level.var_8df7db3b);
			iprintln("" + level.var_8b5ef67d);
			iprintln("" + level.var_bb42ed2);
			iprintln("" + level.var_9d4a9561);
			iprintln("" + level.var_b8c2e6df);
			wait(5);
		}
	#/
}

/*
	Name: onspawnplayer
	Namespace: clean
	Checksum: 0xBCA9F66A
	Offset: 0x11A0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function onspawnplayer(predictedspawn)
{
	if(level.usestartspawns && !level.ingraceperiod)
	{
		level.usestartspawns = 0;
	}
	self.var_916cc864 = 0;
	self.var_91be2350 = 0;
	self.var_129c990c = 0;
	self.carriedtacos = 0;
	self.var_3e52c359 = 0;
	self clientfield::set_player_uimodel("hudItems.cleanCarryCount", 0);
	spawning::onspawnplayer(predictedspawn);
}

/*
	Name: onplayerkilled
	Namespace: clean
	Checksum: 0xB1D6E59B
	Offset: 0x1258
	Size: 0x1D4
	Parameters: 9
	Flags: None
*/
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(isplayer(attacker) && attacker.team != self.team)
	{
		if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
		{
			attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
		}
		if(self.carriedtacos >= 5)
		{
			scoreevents::processscoreevent(#"clean_kill_enemy_carrying_tacos", attacker, self, weapon);
		}
	}
	if(isdefined(attacker) && isplayer(attacker) && attacker.team != self.team)
	{
		taco = function_b25ab1e7();
		if(isdefined(taco))
		{
			yawangle = randomint(360);
			taco function_903c4eff(self, attacker, undefined, yawangle);
		}
		self thread function_bbcf6af(attacker, yawangle);
	}
}

/*
	Name: function_8695993b
	Namespace: clean
	Checksum: 0xFB44C8FA
	Offset: 0x1438
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function function_8695993b()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		self flagsys::wait_till("camo_suit_on");
		self clientfield::set("taco_carry", 0);
		self flagsys::wait_till_clear("camo_suit_on");
	}
}

/*
	Name: function_fccce038
	Namespace: clean
	Checksum: 0xE047282
	Offset: 0x14D0
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_fccce038()
{
	if(self.carriedtacos > 0)
	{
		self clientfield::set("taco_carry", 1);
	}
	else
	{
		self clientfield::set("taco_carry", 0);
	}
}

/*
	Name: function_b25ab1e7
	Namespace: clean
	Checksum: 0xFA69D668
	Offset: 0x1530
	Size: 0x13E
	Parameters: 0
	Flags: None
*/
function function_b25ab1e7()
{
	var_ba985a3c = undefined;
	foreach(taco in level.tacos)
	{
		if(taco.interactteam == #"none")
		{
			return taco;
		}
		if(isdefined(taco.var_2581d0d))
		{
			continue;
		}
		if(!isdefined(var_ba985a3c) || taco.droptime < var_ba985a3c.droptime)
		{
			var_ba985a3c = taco;
		}
	}
	if(isdefined(var_ba985a3c) && var_ba985a3c.droptime != gettime())
	{
		/#
			level.var_9d4a9561++;
		#/
		var_ba985a3c registermp_multi_kill_medals_interface();
		return var_ba985a3c;
	}
	/#
		level.var_b8c2e6df++;
	#/
	return undefined;
}

/*
	Name: function_f82f0bb5
	Namespace: clean
	Checksum: 0x7A0FCE2B
	Offset: 0x1678
	Size: 0x118
	Parameters: 0
	Flags: None
*/
function function_f82f0bb5()
{
	visuals = [];
	trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
	trigger.var_a865c2cd = 0;
	taco = gameobjects::create_use_object(#"any", trigger, visuals, undefined, #"hash_77d505035209b8d6");
	taco notsolid();
	taco ghost();
	taco gameobjects::set_use_time(0);
	taco.onuse = &function_95cbd646;
	taco clientfield::set("taco_player_entnum", 15);
	return taco;
}

/*
	Name: function_903c4eff
	Namespace: clean
	Checksum: 0x7C7492B3
	Offset: 0x1798
	Size: 0x344
	Parameters: 4
	Flags: None
*/
function function_903c4eff(victim, attacker, pos, yawangle)
{
	/#
		level.var_8df7db3b++;
		level.var_8b5ef67d = max(level.var_8b5ef67d, level.var_8df7db3b);
	#/
	if(!isdefined(yawangle))
	{
		yawangle = randomint(360);
	}
	if(!isdefined(pos))
	{
		pos = victim.origin + vectorscale((0, 0, 1), 40);
	}
	self.droptime = gettime();
	self.team = victim.team;
	self.victim = victim;
	self.victimteam = victim.team;
	self.attacker = attacker;
	self.attackerteam = attacker.team;
	self.trigger.origin = pos;
	self show();
	self clientfield::set("taco_flag", 1);
	if(isplayer(attacker))
	{
		self clientfield::set("taco_player_entnum", attacker.entnum);
	}
	self playloopsound("mpl_fracture_core_loop");
	self dontinterpolate();
	self gameobjects::allow_use(#"any");
	if(isdefined(self.var_2581d0d))
	{
		self.var_2581d0d delete();
	}
	dropangles = (-70, yawangle, 0);
	force = anglestoforward(dropangles) * randomfloatrange(getdvarfloat(#"dropmin", 220), getdvarfloat(#"dropmax", 300));
	self.var_2581d0d = victim magicmissile(level.var_b7d7d172, pos, force);
	self.var_2581d0d hide();
	self.var_2581d0d notsolid();
	self thread function_8cb72ba4();
	self thread function_9415d18b();
	self thread function_8f7a9a20();
}

/*
	Name: function_8cb72ba4
	Namespace: clean
	Checksum: 0x2E53122
	Offset: 0x1AE8
	Size: 0x128
	Parameters: 0
	Flags: None
*/
function function_8cb72ba4()
{
	level endon(#"game_ended");
	self endon(#"reset");
	self.var_2581d0d endon(#"death", #"stationary");
	while(true)
	{
		if(!isdefined(self.var_2581d0d))
		{
			break;
		}
		if(self.var_2581d0d oob::istouchinganyoobtrigger() || self.var_2581d0d gameobjects::is_touching_any_trigger_key_value("trigger_hurt_new", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32))
		{
			self thread registermp_multi_kill_medals_interface();
			return;
		}
		self.trigger.origin = self.var_2581d0d.origin;
		waitframe(1);
	}
}

/*
	Name: function_9415d18b
	Namespace: clean
	Checksum: 0x5EE2EBF2
	Offset: 0x1C18
	Size: 0xEE
	Parameters: 0
	Flags: None
*/
function function_9415d18b()
{
	level endon(#"game_ended");
	self endon(#"reset");
	self.var_2581d0d endon(#"death");
	if(!isdefined(self.var_2581d0d))
	{
		return;
	}
	self.var_2581d0d waittill(#"stationary");
	self.trigger.origin = self.var_2581d0d.origin;
	self playsound("mpl_fracture_core_drop");
	self clientfield::set("taco_flag", 2);
	self.var_2581d0d delete();
	self.var_2581d0d = undefined;
}

/*
	Name: function_8f7a9a20
	Namespace: clean
	Checksum: 0xF83CB269
	Offset: 0x1D10
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_8f7a9a20()
{
	level endon(#"game_ended");
	self endon(#"reset");
	wait(60);
	/#
		level.var_bb42ed2++;
	#/
	self thread registermp_multi_kill_medals_interface();
}

/*
	Name: registermp_multi_kill_medals_interface
	Namespace: clean
	Checksum: 0x6EF7BA1D
	Offset: 0x1D78
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function registermp_multi_kill_medals_interface()
{
	/#
		level.var_8df7db3b--;
	#/
	self notify(#"reset");
	self clientfield::set("taco_flag", 0);
	self clientfield::set("taco_player_entnum", 15);
	self stoploopsound();
	self.trigger.origin = vectorscale((0, 0, 1), 1000);
	self gameobjects::allow_use(#"none");
	waittillframeend();
	if(isdefined(self.var_2581d0d))
	{
		self.var_2581d0d delete();
		self.var_2581d0d = undefined;
	}
	self ghost();
}

/*
	Name: function_c1780fc7
	Namespace: clean
	Checksum: 0x31C2901E
	Offset: 0x1E80
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function function_c1780fc7()
{
	globallogic::waitforplayers();
	function_b4a9e792("clean_objective_base_trig");
	function_b4a9e792("clean_objective_center_trig");
	function_b4a9e792("clean_objective_scatter_trig");
	function_998dec78();
	if(!isdefined(level.cleandepositpoints))
	{
		/#
			util::error("");
		#/
		return;
	}
	level.cleandeposithubs = [];
	foreach(point in level.cleandepositpoints)
	{
		var_f30b24ef = function_bad2b0d4(point);
		level.cleandeposithubs[level.cleandeposithubs.size] = var_f30b24ef;
	}
}

/*
	Name: function_b4a9e792
	Namespace: clean
	Checksum: 0xEB885E14
	Offset: 0x1FD0
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function function_b4a9e792(targetname)
{
	ents = getentarray(targetname, "targetname");
	foreach(ent in ents)
	{
		ent delete();
	}
}

/*
	Name: function_998dec78
	Namespace: clean
	Checksum: 0x562A9B01
	Offset: 0x2080
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function function_998dec78()
{
	scriptmodels = getentarray("script_model", "className");
	foreach(scriptmodel in scriptmodels)
	{
		if(scriptmodel.model === "p7_mp_flag_base")
		{
			scriptmodel delete();
		}
	}
}

/*
	Name: function_bad2b0d4
	Namespace: clean
	Checksum: 0xE8A2E786
	Offset: 0x2140
	Size: 0x1C0
	Parameters: 1
	Flags: None
*/
function function_bad2b0d4(origin)
{
	trigger = spawn("trigger_radius", origin, 0, 60, 108);
	visuals[0] = spawn("script_model", trigger.origin);
	var_f30b24ef = gameobjects::create_use_object(#"neutral", trigger, visuals, undefined, level.var_dfce3f1c);
	var_f30b24ef gameobjects::allow_use(#"any");
	var_f30b24ef gameobjects::set_visible_team(#"any");
	var_f30b24ef gameobjects::set_use_time(0);
	var_f30b24ef gameobjects::disable_object();
	var_f30b24ef.onuse = &function_83e87bd5;
	var_f30b24ef.canuseobject = &function_1237ad98;
	var_f30b24ef.effectorigin = trigger.origin + (0, 0, 0);
	var_f30b24ef.influencer = influencers::create_influencer("clean_deposit_hub", var_f30b24ef.origin, 0);
	enableinfluencer(var_f30b24ef.influencer, 0);
	return var_f30b24ef;
}

/*
	Name: function_b8a3dde4
	Namespace: clean
	Checksum: 0x16EE86AD
	Offset: 0x2308
	Size: 0x17A
	Parameters: 0
	Flags: None
*/
function function_b8a3dde4()
{
	level endon(#"game_ended");
	self.baseeffect = spawnfx(level.var_11d8b3ba, self.effectorigin);
	self.baseeffect.team = #"none";
	triggerfx(self.baseeffect, 0.001);
	wait_time = level.cleandepositonlinetime;
	if(wait_time < 0)
	{
		wait_time = level.cleandepositonlinetime * 0.05;
	}
	wait(wait_time);
	if(!isdefined(self.baseeffect))
	{
		return;
	}
	self.baseeffect delete();
	self.baseeffect = spawnfx(level.var_6c5ba305, self.effectorigin);
	self.baseeffect.team = #"none";
	triggerfx(self.baseeffect, 0.001);
	self.baseeffect = spawnfx(level.var_6c5ba305, self.effectorigin);
}

/*
	Name: function_fd08eb25
	Namespace: clean
	Checksum: 0xE6B732E2
	Offset: 0x2490
	Size: 0x518
	Parameters: 0
	Flags: None
*/
function function_fd08eb25()
{
	level endon(#"game_ended");
	while(level.inprematchperiod)
	{
		waitframe(1);
	}
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	var_696c0ca5 = -1;
	while(true)
	{
		if(level.var_2576eaeb > 0)
		{
			foreach(team, _ in level.teams)
			{
				setmatchflag("bomb_timer_a", 1);
				setbombtimer("A", (gettime() + 1000) + (int(level.var_2576eaeb * 1000)));
				if(var_696c0ca5 >= 0)
				{
					globallogic_audio::leader_dialog("hubOffline", team);
					globallogic_audio::play_2d_on_team("mpl_fracture_sting_powerdown", team);
				}
			}
			wait(level.var_2576eaeb);
		}
		var_79efdaa0 = function_e3e1cf54(var_696c0ca5);
		var_f30b24ef = level.cleandeposithubs[var_79efdaa0];
		var_f30b24ef gameobjects::enable_object();
		var_f30b24ef gameobjects::allow_use(#"any");
		smart_cover::function_18f38647(var_f30b24ef.trigger);
		concertina_wire::function_18f38647(var_f30b24ef.trigger);
		var_f30b24ef thread function_b8a3dde4();
		enableinfluencer(var_f30b24ef.influencer, 1);
		if(isdefined(level.var_1940f14e))
		{
			level.var_1940f14e.origin = var_f30b24ef.origin - vectorscale((0, 0, 1), 8);
			level.var_1940f14e show();
		}
		setmatchflag("bomb_timer_a", 1);
		setbombtimer("A", (gettime() + 1000) + (int(level.cleandepositonlinetime * 1000)));
		foreach(team, _ in level.teams)
		{
			if(level.var_2576eaeb > 0)
			{
				globallogic_audio::leader_dialog("hubOnline", team);
			}
			else if(var_696c0ca5 >= 0)
			{
				globallogic_audio::leader_dialog("hubMoved", team);
			}
			if(var_696c0ca5 >= 0)
			{
				globallogic_audio::play_2d_on_team("mpl_fracture_sting_moved", team);
			}
		}
		var_696c0ca5 = var_79efdaa0;
		wait(level.cleandepositonlinetime);
		smart_cover::function_60a53911(var_f30b24ef.trigger);
		concertina_wire::function_60a53911(var_f30b24ef.trigger);
		var_f30b24ef gameobjects::disable_object();
		var_f30b24ef gameobjects::allow_use(#"none");
		var_f30b24ef gameobjects::set_visible_team(#"none");
		enableinfluencer(var_f30b24ef.influencer, 0);
		var_f30b24ef stoploopsound();
		if(isdefined(level.var_1940f14e))
		{
			level.var_1940f14e hide();
		}
		var_f30b24ef.baseeffect delete();
	}
}

/*
	Name: function_e3e1cf54
	Namespace: clean
	Checksum: 0xC499233F
	Offset: 0x29B0
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function function_e3e1cf54(var_696c0ca5 = -1)
{
	switch(level.cleandepositrotation)
	{
		case 0:
		{
			return (var_696c0ca5 + 1) % level.cleandeposithubs.size;
		}
		case 1:
		{
			return function_579aa766(var_696c0ca5, &registerexert_immolation_control);
		}
	}
	return registerexert_immolation_control(var_696c0ca5);
}

/*
	Name: function_579aa766
	Namespace: clean
	Checksum: 0xC1417D28
	Offset: 0x2A60
	Size: 0x2E
	Parameters: 2
	Flags: None
*/
function function_579aa766(var_696c0ca5, var_c1e8a2b7)
{
	if(var_696c0ca5 < 0)
	{
		return 0;
	}
	return [[var_c1e8a2b7]](var_696c0ca5);
}

/*
	Name: registerexert_immolation_control
	Namespace: clean
	Checksum: 0xA29D3FE
	Offset: 0x2A98
	Size: 0x108
	Parameters: 1
	Flags: None
*/
function registerexert_immolation_control(var_696c0ca5)
{
	if(!isdefined(level.var_49aeba07))
	{
		level.var_49aeba07 = [];
	}
	if(level.var_49aeba07.size == 0)
	{
		for(i = 0; i < level.cleandeposithubs.size; i++)
		{
			if(i != var_696c0ca5)
			{
				level.var_49aeba07[level.var_49aeba07.size] = i;
			}
		}
		if(level.cleandeposithubs.size < 2)
		{
			return 0;
		}
	}
	var_8ae22528 = randomint(level.var_49aeba07.size);
	nextindex = level.var_49aeba07[var_8ae22528];
	arrayremoveindex(level.var_49aeba07, var_8ae22528);
	return nextindex;
}

/*
	Name: function_60c1a907
	Namespace: clean
	Checksum: 0x13E6D946
	Offset: 0x2BA8
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_60c1a907(var_696c0ca5)
{
	if(var_696c0ca5 < 0)
	{
		return randomint(level.cleandeposithubs.size);
	}
	nextindex = randomint(level.cleandeposithubs.size - 1);
	if(nextindex >= var_696c0ca5)
	{
		nextindex++;
	}
	return nextindex;
}

/*
	Name: hidetimerdisplayongameend
	Namespace: clean
	Checksum: 0x5DB1617E
	Offset: 0x2C28
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function hidetimerdisplayongameend()
{
	level waittill(#"game_ended");
	setmatchflag("bomb_timer_a", 0);
}

/*
	Name: function_c857e45f
	Namespace: clean
	Checksum: 0xB2FCD429
	Offset: 0x2C68
	Size: 0x2DC
	Parameters: 0
	Flags: None
*/
function function_c857e45f()
{
	level endon(#"game_ended");
	while(true)
	{
		time = gettime();
		foreach(player in level.players)
		{
			if(isdefined(player.var_916cc864) && isdefined(player.var_91be2350) && player.var_91be2350 && (time - player.var_916cc864) > (int((((float(function_60d95f53()) / 1000) + 0.25) + 0.1) * 1000)))
			{
				enemyteam = util::getotherteam(player.team);
				level thread popups::displayteammessagetoteam(#"hash_7025b86816895e07", player, player.team, player.var_91be2350, undefined, 1);
				level thread popups::displayteammessagetoteam(#"hash_7025b86816895e07", player, enemyteam, player.var_91be2350, undefined, 1);
				if(player.var_91be2350 >= 10)
				{
					scoreevents::processscoreevent(#"clean_multi_deposit_big", player);
				}
				else if(player.var_91be2350 >= 5)
				{
					scoreevents::processscoreevent(#"clean_multi_deposit_normal", player);
				}
				player.var_91be2350 = 0;
			}
			if(isdefined(player.var_66521d81) && player.var_66521d81 < (gettime() - 1500))
			{
				if(player.var_3e52c359 >= 5)
				{
					scoreevents::processscoreevent(#"clean_multi_deny_tacos", player);
				}
				player.var_3e52c359 = 0;
				player.var_66521d81 = undefined;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_83e87bd5
	Namespace: clean
	Checksum: 0x4BFE10EE
	Offset: 0x2F50
	Size: 0x2F4
	Parameters: 1
	Flags: None
*/
function function_83e87bd5(player)
{
	time = gettime();
	player.var_916cc864 = time;
	if(isdefined(player.pers[#"cleandeposits"]))
	{
		player.pers[#"cleandeposits"] = player.pers[#"cleandeposits"] + 1;
		player.cleandeposits = player.pers[#"cleandeposits"];
		[[level.var_37d62931]](player, 1);
	}
	player stats::function_bb7eedf0(#"cleandeposits", 1);
	if(level.teamscorepercleandeposit > 0)
	{
		var_e5474cba = level.teamscorepercleandeposit;
		player globallogic_score::giveteamscoreforobjective(player.team, var_e5474cba);
	}
	switch(player.var_91be2350)
	{
		case 0:
		{
			player playsound("mpl_fracture_deposit_1");
			break;
		}
		case 1:
		{
			player playsound("mpl_fracture_deposit_2");
			break;
		}
		case 2:
		{
			player playsound("mpl_fracture_deposit_3");
			break;
		}
		case 3:
		{
			player playsound("mpl_fracture_deposit_4");
			break;
		}
		default:
		{
			player playsound("mpl_fracture_deposit_5");
		}
	}
	player.var_91be2350++;
	if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
	{
		scoreevents::processscoreevent("shamrock_enemy_deposit", player);
	}
	else
	{
		scoreevents::processscoreevent("clean_enemy_deposit", player);
	}
	player.carriedtacos--;
	player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
	player function_fccce038();
}

/*
	Name: function_1237ad98
	Namespace: clean
	Checksum: 0xEE15FF9B
	Offset: 0x3250
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function function_1237ad98(player)
{
	if(player.carriedtacos <= 0)
	{
		objective_clearplayerusing(self.objectiveid, player);
		return 0;
	}
	if(!player.var_916cc864)
	{
		return 1;
	}
	return (player.var_916cc864 + (int(0.25 * 1000))) < gettime();
}

/*
	Name: function_95cbd646
	Namespace: clean
	Checksum: 0x353A6887
	Offset: 0x32E0
	Size: 0x494
	Parameters: 1
	Flags: None
*/
function function_95cbd646(player)
{
	if(self.victimteam == player.team)
	{
		player playsound("mpl_fracture_enemy_pickup_m");
		if(isdefined(player.pers[#"cleandenies"]))
		{
			player.pers[#"cleandenies"] = player.pers[#"cleandenies"] + 1;
			player.cleandenies = player.pers[#"cleandenies"];
			[[level.var_37d62931]](player, 1);
		}
		player stats::function_bb7eedf0(#"cleandenies", 1);
		if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
		{
			if(self.victim === player)
			{
				scoreevents::processscoreevent("shamrock_own_collect", player);
			}
			else
			{
				scoreevents::processscoreevent("shamrock_friendly_collect", player);
			}
		}
		else if(self.victim === player)
		{
			scoreevents::processscoreevent("clean_own_collect", player);
		}
		else
		{
			scoreevents::processscoreevent("clean_friendly_collect", player);
		}
		player.var_66521d81 = gettime();
		player.var_3e52c359++;
	}
	else if(player.carriedtacos >= 10)
	{
		time = gettime();
		if(time - player.var_129c990c > 500)
		{
			player playlocalsound("mpl_fracture_enemy_pickup_nope");
			if(!isdefined(player.var_49f1d9cc))
			{
				player.var_49f1d9cc = 0;
			}
			player clientfield::set_player_uimodel("hudItems.cleanCarryFull", player.var_49f1d9cc);
			player.var_49f1d9cc = (player.var_49f1d9cc ? 1 : 0);
		}
		player.var_129c990c = time;
		return;
	}
	player.carriedtacos++;
	player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
	player function_fccce038();
	if(player.carriedtacos < 4)
	{
		player playsound("mpl_fracture_enemy_pickup_s");
	}
	else if(player.carriedtacos < 7)
	{
		player playsound("mpl_fracture_enemy_pickup_m");
	}
	else
	{
		player playsound("mpl_fracture_enemy_pickup_l");
	}
	if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
	{
		scoreevents::processscoreevent("shamrock_enemy_collect", player);
	}
	else
	{
		scoreevents::processscoreevent("clean_enemy_collect", player);
	}
	if(self.attackerteam == player.team && isdefined(self.attacker) && self.attacker != player)
	{
		if(isdefined(level.var_c5e28dc5) && level.var_c5e28dc5)
		{
			scoreevents::processscoreevent("shamrock_assist_collect", self.attacker);
		}
		else
		{
			scoreevents::processscoreevent("clean_assist_collect", self.attacker);
		}
	}
	self registermp_multi_kill_medals_interface();
}

/*
	Name: function_bbcf6af
	Namespace: clean
	Checksum: 0xE1AA35AB
	Offset: 0x3780
	Size: 0x16E
	Parameters: 2
	Flags: None
*/
function function_bbcf6af(attacker, yawangle)
{
	dropcount = self.carriedtacos;
	self.carriedtacos = 0;
	self clientfield::set_player_uimodel("hudItems.cleanCarryCount", self.carriedtacos);
	self function_fccce038();
	/#
		dropcount = dropcount + getdvarint(#"hash_28135ad78580b035", 0);
	#/
	var_8a33c2ea = 360 / (dropcount + 1);
	for(i = 0; i < dropcount; i++)
	{
		taco = function_b25ab1e7();
		if(!isdefined(taco))
		{
			return;
		}
		yawangle = yawangle + var_8a33c2ea;
		randomyaw = 0.8 * var_8a33c2ea;
		randomyaw = randomfloatrange(randomyaw * -1, randomyaw);
		taco function_903c4eff(self, attacker, undefined, yawangle + randomyaw);
	}
}

