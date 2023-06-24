// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\remote_weapons.gsc;
#using scripts\killstreaks\killstreak_bundles.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\targetting_delay.gsc;
#using scripts\weapons\deployable.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\placeables.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;

#namespace ultimate_turret;

/*
	Name: init_shared
	Namespace: ultimate_turret
	Checksum: 0x2F3CB5EC
	Offset: 0x428
	Size: 0x34C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.ultimate_turret_shared))
	{
		level.ultimate_turret_shared = {};
		killstreaks::register_killstreak("killstreak_ultimate_turret", &activateturret);
		killstreaks::register_alt_weapon("ultimate_turret", getweapon("ultimate_turret_deploy"));
		killstreaks::function_b013c2d3("ultimate_turret", getweapon("ultimate_turret_deploy"));
		killstreaks::register_alt_weapon("ultimate_turret", getweapon(#"gun_ultimate_turret"));
		killstreaks::allow_assists("ultimate_turret", 1);
		level.killstreaks[#"ultimate_turret"].threatonkill = 1;
		clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int");
		clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int");
		clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int");
		clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int");
		if(sessionmodeiscampaigngame())
		{
			vehicle::add_main_callback("veh_ultimate_turret" + "_cp", &initturret);
		}
		else
		{
			vehicle::add_main_callback("veh_ultimate_turret", &initturret);
		}
		callback::on_spawned(&on_player_spawned);
		callback::on_player_killed(&on_player_killed);
		weaponobjects::function_e6400478(#"ultimate_turret", &function_305bbc35, undefined);
		weaponobjects::function_e6400478(#"inventory_ultimate_turret", &function_305bbc35, undefined);
		level.var_43e52789 = 0;
		deployable::register_deployable(getweapon("ultimate_turret"), undefined);
		callback::on_finalize_initialization(&function_1c601b99);
	}
}

/*
	Name: function_1c601b99
	Namespace: ultimate_turret
	Checksum: 0x55DCB611
	Offset: 0x780
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon("ultimate_turret"), &function_bff5c062);
	}
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](getweapon("ultimate_turret"), &function_127fb8f3);
	}
}

/*
	Name: function_127fb8f3
	Namespace: ultimate_turret
	Checksum: 0xE677ED1D
	Offset: 0x818
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_127fb8f3(turret, attackingplayer)
{
	turret.isjammed = 1;
	if(isdefined(level.var_86e3d17a) && turret.classname == "script_vehicle")
	{
		_station_up_to_detention_center_triggers = [[level.var_86e3d17a]]() * 1000;
		if(_station_up_to_detention_center_triggers > 0)
		{
			turret notify(#"cancel_timeout");
			turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
		}
		if(isdefined(level.var_1794f85f))
		{
			[[level.var_1794f85f]](attackingplayer, "disrupted_sentry");
		}
		turret clientfield::set("enemyvehicle", 0);
	}
}

/*
	Name: function_bff5c062
	Namespace: ultimate_turret
	Checksum: 0x47E1F2C0
	Offset: 0x938
	Size: 0x244
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(turret, attackingplayer)
{
	turret function_3a9dddac();
	if(isdefined(turret.turret))
	{
		turret.owner weaponobjects::hackerremoveweapon(turret.turret);
	}
	turret.owner = attackingplayer;
	turret.team = attackingplayer.team;
	turret setowner(attackingplayer);
	turret setteam(attackingplayer.team);
	turret.isjammed = 0;
	if(turret.classname == "script_vehicle")
	{
		if(isdefined(level.var_f1edf93f))
		{
			_station_up_to_detention_center_triggers = int([[level.var_f1edf93f]]() * 1000);
			if((isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0))
			{
				turret notify(#"cancel_timeout");
				turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
			}
		}
		if(isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](turret);
		}
		turret.spawninfluencers = [];
		turret.spawninfluencers[0] = turret createturretinfluencer("turret");
		turret.spawninfluencers[1] = turret createturretinfluencer("turret_close");
	}
	turret thread turret_watch_owner_events();
}

/*
	Name: on_player_spawned
	Namespace: ultimate_turret
	Checksum: 0x8D249DC0
	Offset: 0xB88
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	weapon = getweapon("ultimate_turret");
	if(isdefined(weapon) && !self hasweapon(weapon))
	{
		self clientfield::set_player_uimodel("hudItems.ultimateTurretCount", 0);
	}
	self.var_c306ebe3 = undefined;
}

/*
	Name: initturret
	Namespace: ultimate_turret
	Checksum: 0xA43BF41C
	Offset: 0xC08
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function initturret()
{
	turretvehicle = self;
	turretvehicle.dontfreeme = 1;
	turretvehicle.damage_on_death = 0;
	turretvehicle.delete_on_death = undefined;
	turretvehicle.maxhealth = 2000;
	turretvehicle.damagetaken = 0;
	tablehealth = killstreak_bundles::get_max_health("ultimate_turret");
	if(isdefined(tablehealth))
	{
		turretvehicle.maxhealth = tablehealth;
	}
	turretvehicle.health = turretvehicle.maxhealth;
	turretvehicle turretsetontargettolerance(0, 15);
	turretvehicle clientfield::set("enemyvehicle", 1);
	turretvehicle.soundmod = "mini_turret";
	turretvehicle.overridevehicledamage = &onturretdamage;
	turretvehicle.overridevehiclekilled = &onturretdeath;
}

/*
	Name: activateturret
	Namespace: ultimate_turret
	Checksum: 0x208397EF
	Offset: 0xD38
	Size: 0x84A
	Parameters: 0
	Flags: Linked
*/
function activateturret()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isdefined(player.var_c306ebe3))
	{
		return false;
	}
	killstreakid = self killstreakrules::killstreakstart("ultimate_turret", player.team, 0, 0);
	if(killstreakid == -1)
	{
		return false;
	}
	if(level.var_43e52789)
	{
		return false;
	}
	bundle = level.killstreakbundle[#"ultimate_turret"];
	var_b6c61913 = 0;
	if(var_b6c61913)
	{
		turret = player killstreaks::function_8cd96439("ultimate_turret", killstreakid, &onplaceturret, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "tag_origin", "tag_origin", "tag_origin", 1, #"killstreak_sentry_turret_pickup", bundle.ksduration, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
		turret thread watchturretshutdown(player, killstreakid, player.team);
		turret thread util::ghost_wait_show_to_player(player);
		turret.othermodel thread util::ghost_wait_show_to_others(player);
		event = undefined;
		event = turret waittill(#"placed", #"cancelled", #"death");
		if(event._notify != "placed")
		{
			return false;
		}
		return true;
	}
	turret_team = player.team;
	player.var_c306ebe3 = killstreakid;
	self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 4);
	if(0)
	{
		var_e454da90 = getweapon(#"ultimate_turret_deploy");
		if(var_e454da90 == level.weaponnone)
		{
			return false;
		}
		player giveweapon(var_e454da90);
		slot = player gadgetgetslot(var_e454da90);
		player gadgetpowerreset(slot);
		player gadgetpowerset(slot, 100);
		waitresult = undefined;
		waitresult = player waittilltimeout(0.1, #"death");
		if(!isdefined(waitresult._notify) || waitresult._notify == "death")
		{
			if(isdefined(player))
			{
				player.var_c306ebe3 = undefined;
			}
			killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
			self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
			return false;
		}
		player switchtoweapon(var_e454da90);
		player setoffhandvisible(1);
		waitresult = undefined;
		waitresult = player waittill(#"death", #"weapon_change");
		if(!isdefined(waitresult._notify) || waitresult._notify == "death")
		{
			if(isdefined(player))
			{
				player setoffhandvisible(0);
				player.var_c306ebe3 = undefined;
			}
			killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
			self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
			return false;
		}
	}
	if(isdefined(level.var_ed417bb9))
	{
		waitresult = undefined;
		waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired");
	}
	waitresult = undefined;
	waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired");
	if(waitresult._notify === "weapon_change" && waitresult.last_weapon === var_e454da90 && waitresult.weapon === level.weaponnone)
	{
		waitresult = undefined;
		waitresult = player waittilltimeout(2, #"ultimate_turret_deployed", #"death");
	}
	else if(waitresult._notify === "weapon_change" && waitresult.weapon === var_e454da90)
	{
		waitresult = undefined;
		waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_fired");
	}
	if(isdefined(player) && 0)
	{
		player takeweapon(var_e454da90);
	}
	if(waitresult._notify === "weapon_fired")
	{
		waitresult = undefined;
		waitresult = player waittill(#"ultimate_turret_deployed", #"death");
	}
	if(isdefined(player))
	{
		self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
	}
	if(!isdefined(waitresult._notify) || waitresult._notify != "ultimate_turret_deployed")
	{
		if(isdefined(player))
		{
			player setoffhandvisible(0);
			player.var_c306ebe3 = undefined;
		}
		killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
		return false;
	}
	if(waitresult._notify == "ultimate_turret_deployed" && isdefined(waitresult.turret))
	{
		waitresult.turret thread watchturretshutdown(player, waitresult.turret.killstreakid, player.team);
	}
	player.var_c306ebe3 = undefined;
	return true;
}

/*
	Name: function_305bbc35
	Namespace: ultimate_turret
	Checksum: 0x8988C8ED
	Offset: 0x1590
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_305bbc35(watcher)
{
	watcher.onspawn = &function_3be2d17f;
	watcher.deleteonplayerspawn = 0;
}

/*
	Name: function_3be2d17f
	Namespace: ultimate_turret
	Checksum: 0x6E9900BD
	Offset: 0x15D0
	Size: 0x402
	Parameters: 2
	Flags: Linked
*/
function function_3be2d17f(watcher, player)
{
	player endon(#"death", #"disconnect");
	level endon(#"game_ended");
	self endon(#"death");
	slot = player gadgetgetslot(self.weapon);
	player gadgetpowerreset(slot);
	player gadgetpowerset(slot, 0);
	self weaponobjects::onspawnuseweaponobject(watcher, player);
	self hide();
	self.canthack = 1;
	self.ignoreemp = 1;
	var_83ed455 = 0;
	if(var_83ed455 && isdefined(player))
	{
		player val::set(#"ultimate_turret", "freezecontrols");
	}
	self waittill(#"stationary");
	player stats::function_e24eec31(self.weapon, #"used", 1);
	player notify(#"ultimate_turret_deployed", {#turret:self});
	self deployable::function_dd266e08(player);
	self.origin = self.origin + vectorscale((0, 0, 1), 2);
	player onplaceturret(self);
	if(var_83ed455 && isdefined(player))
	{
		player val::reset(#"ultimate_turret", "freezecontrols");
	}
	if(!isdefined(player.var_85988a58))
	{
		player.var_85988a58 = [];
	}
	if(!isdefined(player.var_85988a58))
	{
		player.var_85988a58 = [];
	}
	else if(!isarray(player.var_85988a58))
	{
		player.var_85988a58 = array(player.var_85988a58);
	}
	player.var_85988a58[player.var_85988a58.size] = self.vehicle;
	player clientfield::set_player_uimodel("hudItems.ultimateTurretCount", player.var_85988a58.size);
	if(isdefined(self.weapon) && isdefined(self.vehicle))
	{
		self.vehicle thread weaponobjects::function_d9c08e94(self.weapon.fusetime, &function_21f16a35);
		self thread function_b649601a();
	}
	self ghost();
	self thread function_24910d60();
	self.vehicle thread function_7f9eb7f();
	self.vehicle.var_1f13c7f1 = getweapon(#"ultimate_turret").var_1f13c7f1;
}

/*
	Name: function_b649601a
	Namespace: ultimate_turret
	Checksum: 0x4E740339
	Offset: 0x19E0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_b649601a()
{
	self.vehicle endon(#"death");
	self.vehicle clientfield::set("ultimate_turret_init", 1);
	wait(0.25);
	self.vehicle clientfield::set("ultimate_turret_open", 1);
}

/*
	Name: function_24910d60
	Namespace: ultimate_turret
	Checksum: 0x7B2D22D
	Offset: 0x1A60
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_24910d60()
{
	vehicle = self.vehicle;
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(waitresult._notify != "death")
	{
		return;
	}
	if(isdefined(self))
	{
		self.var_d02ddb8e = waitresult.weapon;
	}
	if(isdefined(vehicle))
	{
		vehicle function_59ce22f9(undefined, undefined);
	}
}

/*
	Name: function_7f9eb7f
	Namespace: ultimate_turret
	Checksum: 0x1D584EE0
	Offset: 0x1B00
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_7f9eb7f()
{
	owner = self.owner;
	owner endon(#"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"death", #"death_started");
	if(!isdefined(self))
	{
		arrayremovevalue(owner.var_85988a58, undefined);
	}
	else if(self.damagetaken > self.health)
	{
		arrayremovevalue(owner.var_85988a58, self);
		self.owner luinotifyevent(#"hash_126effa63f6e04bd");
	}
	owner clientfield::set_player_uimodel("hudItems.ultimateTurretCount", owner.var_85988a58.size);
}

/*
	Name: onplaceturret
	Namespace: ultimate_turret
	Checksum: 0x27E17539
	Offset: 0x1C18
	Size: 0x930
	Parameters: 1
	Flags: Linked
*/
function onplaceturret(turret)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isdefined(turret.vehicle))
	{
		turret.vehicle.origin = turret.origin;
		turret.vehicle.angles = turret.angles;
		turret.vehicle thread util::ghost_wait_show(0.05);
		turret.vehicle playsound(#"mpl_turret_startup");
	}
	else
	{
		if(sessionmodeiscampaigngame())
		{
			turret.vehicle = spawnvehicle("veh_ultimate_turret" + "_cp", turret.origin, turret.angles, "dynamic_spawn_ai");
		}
		else
		{
			turret.vehicle = spawnvehicle("veh_ultimate_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
		}
		turret.vehicle.owner = player;
		turret.vehicle setowner(player);
		turret.vehicle.ownerentnum = player.entnum;
		turret.vehicle.parentstruct = turret;
		turret.vehicle.controlled = 0;
		turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
		turret.vehicle.ignore_team_kills = 1;
		turret.vehicle.deal_no_crush_damage = 1;
		turret.vehicle.turret = turret;
		turret.killstreakid = player.var_c306ebe3;
		turret.killstreakref = "ultimate_turret";
		turret.vehicle.team = player.team;
		turret.vehicle setteam(player.team);
		turret.vehicle turret::set_team(player.team, 0);
		turret.vehicle turret::set_torso_targetting(0);
		turret.vehicle turret::set_target_leading(0);
		turret.vehicle.use_non_teambased_enemy_selection = 1;
		turret.vehicle.waittill_turret_on_target_delay = 0.25;
		turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
		turret.vehicle killstreaks::configure_team("ultimate_turret", turret.killstreakid, player, undefined);
		turret.vehicle killstreak_hacking::enable_hacking("ultimate_turret", &hackedcallbackpre, &hackedcallbackpost);
		turret.vehicle thread turret_watch_owner_events();
		turret.vehicle thread turret_laser_watch();
		turret.vehicle thread setup_death_watch_for_new_targets();
		turret.vehicle thread function_31477582();
		turret.vehicle.spawninfluencers = [];
		turret.vehicle.spawninfluencers[0] = turret.vehicle createturretinfluencer("turret");
		turret.vehicle.spawninfluencers[1] = turret.vehicle createturretinfluencer("turret_close");
		turret.vehicle thread util::ghost_wait_show(0.05);
		turret.vehicle.var_63d65a8d = "arc";
		turret.vehicle.var_7eb3ebd5 = [];
		turret.vehicle util::function_c596f193();
		turret.vehicle function_bc7568f1();
		turret.vehicle.var_aac73d6c = 1;
		player killstreaks::play_killstreak_start_dialog("ultimate_turret", player.pers[#"team"], turret.killstreakid);
		level thread popups::displaykillstreakteammessagetoall("ultimate_turret", player);
		player stats::function_e24eec31(getweapon("ultimate_turret"), #"used", 1);
		turret.vehicle.killstreak_duration = level.killstreakbundle[#"ultimate_turret"].ksduration + 5000;
		turret.vehicle.killstreak_end_time = gettime() + turret.vehicle.killstreak_duration;
		bundle = get_killstreak_bundle();
		turret.vehicle thread killstreaks::waitfortimeout("ultimate_turret", turret.vehicle.killstreak_duration, &function_be04d904, "delete", "death");
		turret.vehicle.maxsightdistsqrd = 1;
	}
	player deployable::function_6ec9ee30(turret.vehicle, getweapon("ultimate_turret"));
	turret.vehicle playloopsound(#"hash_69240c6db92da5bf", 0.25);
	foreach(player in level.players)
	{
		turret.vehicle respectnottargetedbysentryperk(player);
	}
	turret.vehicle.turret_enabled = 1;
	target_set(turret.vehicle);
	turret.vehicle unlink();
	turret.vehicle vehicle::disconnect_paths(0, 0);
	bundle = get_killstreak_bundle();
	turret.vehicle thread vehicle::watch_freeze_on_flash(3);
	turret.vehicle thread turretscanning();
	turret.vehicle thread function_fefefcc4();
	turret.vehicle thread targetting_delay::function_7e1a12ce(bundle.var_2aeadfa0);
	player notify(#"ultimate_turret_deployed", {#turret:turret.vehicle});
}

/*
	Name: respectnottargetedbysentryperk
	Namespace: ultimate_turret
	Checksum: 0x3C7228E1
	Offset: 0x2550
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function respectnottargetedbysentryperk(player)
{
	if(!isplayer(player))
	{
		return;
	}
	turretvehicle = self;
	turretvehicle setignoreent(player, player hasperk(#"specialty_nottargetedbysentry"));
}

/*
	Name: hackedcallbackpre
	Namespace: ultimate_turret
	Checksum: 0xE6F0759B
	Offset: 0x25D0
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function hackedcallbackpre(hacker)
{
	turretvehicle = self;
	turretvehicle clientfield::set("enemyvehicle", 2);
	turretvehicle.owner clientfield::set_to_player("static_postfx", 0);
	if(turretvehicle.controlled === 1)
	{
		visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
	}
	turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger(turretvehicle.usetrigger);
	turretvehicle remote_weapons::endremotecontrolweaponuse(1);
	turretvehicle.owner unlink();
	turretvehicle clientfield::set("vehicletransition", 0);
}

/*
	Name: hackedcallbackpost
	Namespace: ultimate_turret
	Checksum: 0x4BACD01
	Offset: 0x26F8
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function hackedcallbackpost(hacker)
{
	turretvehicle = self;
	hacker remote_weapons::useremoteweapon(turretvehicle, "ultimate_turret", 0);
	turretvehicle notify(#"watchremotecontroldeactivate_remoteweapons");
	turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(turretvehicle);
}

/*
	Name: play_deploy_anim_after_wait
	Namespace: ultimate_turret
	Checksum: 0x54C516D
	Offset: 0x2778
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function play_deploy_anim_after_wait(wait_time)
{
	turret = self;
	turret endon(#"death");
	wait(wait_time);
	turret play_deploy_anim();
}

/*
	Name: play_deploy_anim
	Namespace: ultimate_turret
	Checksum: 0xE45F5820
	Offset: 0x27D0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function play_deploy_anim()
{
	turret = self;
	turret clientfield::set("auto_turret_close", 0);
	turret.othermodel clientfield::set("auto_turret_close", 0);
	if(isdefined(turret.vehicle))
	{
		turret.vehicle clientfield::set("auto_turret_open", 1);
	}
}

/*
	Name: oncancelplacement
	Namespace: ultimate_turret
	Checksum: 0x824A09F5
	Offset: 0x2870
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function oncancelplacement(turret)
{
	if(isdefined(turret))
	{
		turret notify(#"hash_5f4a0ea8f3f4e0d0");
	}
}

/*
	Name: onpickupturret
	Namespace: ultimate_turret
	Checksum: 0x9881CA4E
	Offset: 0x28A0
	Size: 0x1E4
	Parameters: 1
	Flags: None
*/
function onpickupturret(turret)
{
	player = self;
	turret.vehicle ghost();
	turret.vheicle.turret_enabled = 0;
	turret.vehicle linkto(turret);
	target_remove(turret.vehicle);
	turret clientfield::set("auto_turret_close", 1);
	turret.othermodel clientfield::set("auto_turret_close", 1);
	if(isdefined(turret.vehicle))
	{
		turret.vehicle notify(#"end_turret_scanning");
		turret.vehicle turretsettargetangles(0, (0, 0, 0));
		turret.vehicle clientfield::set("auto_turret_open", 0);
		if(isdefined(turret.vehicle.usetrigger))
		{
			turret.vehicle.usetrigger delete();
			turret.vehicle playsound(#"mpl_turret_down");
		}
		turret.vehicle vehicle::connect_paths();
		turret.vehicle stoploopsound(0.5);
	}
}

/*
	Name: onturretdamage
	Namespace: ultimate_turret
	Checksum: 0x7DB88381
	Offset: 0x2A90
	Size: 0x3A0
	Parameters: 15
	Flags: Linked
*/
function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	empdamage = int((idamage + (self.healthdefault * 1)) + 0.5);
	var_820fb5ae = self.damagetaken;
	idamage = self killstreaks::ondamageperweapon("ultimate_turret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
	self.damagetaken = self.damagetaken + idamage;
	if(self.controlled)
	{
		self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
	}
	if(self.damagetaken > self.maxhealth && !isdefined(self.will_die))
	{
		self.will_die = 1;
		self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	}
	else
	{
		bundle = get_killstreak_bundle();
		if(isdefined(einflictor) && isvehicle(einflictor) && issentient(einflictor))
		{
			if(is_valid_target(einflictor, self.team))
			{
				self.favoriteenemy = einflictor;
				self.var_c8072bcc = gettime();
				self.var_7eb3ebd5[einflictor getentitynumber()] = #"damage";
				self targetting_delay::function_a4d6d6d8(einflictor);
			}
		}
		else if(isalive(eattacker) && issentient(eattacker) && (!(isplayer(eattacker) && eattacker isremotecontrolling())) && is_valid_target(eattacker, self.team))
		{
			self.favoriteenemy = eattacker;
			self.var_c8072bcc = gettime();
			self.var_7eb3ebd5[eattacker getentitynumber()] = #"damage";
			self targetting_delay::function_a4d6d6d8(eattacker);
		}
	}
	return idamage;
}

/*
	Name: onturretdeath
	Namespace: ultimate_turret
	Checksum: 0xBC32B838
	Offset: 0x2E38
	Size: 0x74
	Parameters: 8
	Flags: Linked
*/
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

/*
	Name: ondeathafterframeend
	Namespace: ultimate_turret
	Checksum: 0xC14DA680
	Offset: 0x2EB8
	Size: 0x84
	Parameters: 8
	Flags: Linked
*/
function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	waittillframeend();
	if(isdefined(self))
	{
		self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	}
}

/*
	Name: ondeath
	Namespace: ultimate_turret
	Checksum: 0xC19ED19D
	Offset: 0x2F48
	Size: 0x4B4
	Parameters: 8
	Flags: Linked
*/
function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	turretvehicle = self;
	turretvehicle notify(#"death_started");
	if(turretvehicle.dead === 1)
	{
		return;
	}
	turretvehicle.dead = 1;
	turretvehicle disabledriverfiring(1);
	turretvehicle.turret_enabled = 0;
	turretvehicle vehicle::connect_paths();
	eattacker = self [[level.figure_out_attacker]](eattacker);
	if(isdefined(turretvehicle.parentstruct))
	{
		turretvehicle.parentstruct placeables::forceshutdown();
		if(turretvehicle.parentstruct.killstreaktimedout === 1 && isdefined(turretvehicle.owner))
		{
			if(isdefined(level.var_729a0937))
			{
				turretvehicle.owner [[level.var_729a0937]](turretvehicle.parentstruct.killstreaktype);
			}
		}
		else if(isdefined(eattacker) && isdefined(turretvehicle.owner) && eattacker != turretvehicle.owner)
		{
			turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner(turretvehicle.killstreaktype, turretvehicle.killstreakid);
			if(isplayer(eattacker) && isdefined(level.var_bbc796bf))
			{
				self [[level.var_bbc796bf]](eattacker, weapon);
			}
		}
	}
	if(isdefined(eattacker) && isplayer(eattacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(eattacker)))
	{
		eattacker challenges::destroyscorestreak(weapon, turretvehicle.controlled, 1, 0);
		eattacker stats::function_dad108fa(#"destroy_turret", 1);
		eattacker stats::function_e24eec31(weapon, #"destroy_turret", 1);
	}
	if(isdefined(level.var_d2600afc))
	{
		self [[level.var_d2600afc]](eattacker, self.owner, self.turretweapon, weapon);
	}
	turretvehicle stoploopsound(0.5);
	turretvehicle playsound("mpl_turret_exp");
	turretvehicle function_3a9dddac();
	if(isdefined(self.owner) && isdefined(level.playequipmentdestroyedonplayer))
	{
		self.owner [[level.playequipmentdestroyedonplayer]]();
	}
	var_980fde21 = self.turret;
	wait(0.1);
	turretvehicle ghost();
	turretvehicle notsolid();
	turretvehicle waittilltimeout(2, #"remote_weapon_end");
	if(isdefined(turretvehicle))
	{
		while(isdefined(turretvehicle) && (turretvehicle.controlled || !isdefined(turretvehicle.owner)))
		{
			waitframe(1);
		}
		turretvehicle.dontfreeme = undefined;
		wait(0.5);
		if(isdefined(turretvehicle))
		{
			turretvehicle delete();
		}
	}
	if(isdefined(var_980fde21))
	{
		var_980fde21 delete();
	}
}

/*
	Name: onshutdown
	Namespace: ultimate_turret
	Checksum: 0xA6F61A9B
	Offset: 0x3408
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function onshutdown(turret)
{
	if(isdefined(turret))
	{
		turret notify(#"hash_5f4a0ea8f3f4e0d0");
	}
}

/*
	Name: enableturretafterwait
	Namespace: ultimate_turret
	Checksum: 0xD58A9B5E
	Offset: 0x3438
	Size: 0x7A
	Parameters: 1
	Flags: None
*/
function enableturretafterwait(wait_time)
{
	self endon(#"death");
	if(isdefined(self.owner))
	{
		self.owner endon(#"disconnect", #"joined_team", #"joined_spectators");
	}
	wait(wait_time);
	self.turret_enabled = 1;
}

/*
	Name: createturretinfluencer
	Namespace: ultimate_turret
	Checksum: 0x2FCE0AF9
	Offset: 0x34C0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function createturretinfluencer(name)
{
	turret = self;
	preset = getinfluencerpreset(name);
	if(!isdefined(preset))
	{
		return;
	}
	projected_point = turret.origin + (vectorscale(anglestoforward(turret.angles), preset[#"radius"] * 0.7));
	return influencers::create_enemy_influencer(name, turret.origin, turret.team);
}

/*
	Name: function_3a9dddac
	Namespace: ultimate_turret
	Checksum: 0xFE7B5DCB
	Offset: 0x3588
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_3a9dddac()
{
	if(!isdefined(self.spawninfluencers))
	{
		self.spawninfluencers = [];
		return;
	}
	foreach(influencer in self.spawninfluencers)
	{
		self influencers::remove_influencer(influencer);
	}
	self.spawninfluencers = [];
}

/*
	Name: turret_watch_owner_events
	Namespace: ultimate_turret
	Checksum: 0xC1FF425C
	Offset: 0x3630
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function turret_watch_owner_events()
{
	self notify(#"turret_watch_owner_events_singleton");
	self endon(#"turret_watch_owner_events_singleton", #"death");
	self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
	self makevehicleusable();
	self.controlled = 0;
	if(isdefined(self.owner))
	{
		self.owner unlink();
		self clientfield::set("vehicletransition", 0);
	}
	self makevehicleunusable();
	if(isdefined(self.owner))
	{
		self.owner killstreaks::clear_using_remote();
	}
	self.abandoned = 1;
	onshutdown(self);
	self function_21f16a35();
}

/*
	Name: turret_laser_watch
	Namespace: ultimate_turret
	Checksum: 0x2B09E3C6
	Offset: 0x3788
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function turret_laser_watch()
{
	veh = self;
	veh endon(#"death");
	while(true)
	{
		laser_should_be_on = !veh.controlled && isdefined(veh.enemy) && (!(isdefined(veh.isstunned) && veh.isstunned)) && (!(isdefined(veh.isjammed) && veh.isjammed));
		if(laser_should_be_on)
		{
			if(islaseron(veh) == 0)
			{
				veh vehicle::enable_laser(1, 0);
			}
		}
		else if(islaseron(veh))
		{
			veh vehicle::enable_laser(0, 0);
		}
		wait(0.25);
	}
}

/*
	Name: setup_death_watch_for_new_targets
	Namespace: ultimate_turret
	Checksum: 0x52670188
	Offset: 0x38B8
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function setup_death_watch_for_new_targets()
{
	turretvehicle = self;
	turretvehicle endon(#"death");
	old_target = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = turretvehicle waittill(#"has_new_target");
		if(isdefined(old_target))
		{
			old_target notify(#"abort_death_watch");
		}
		waitresult.target thread target_death_watch(turretvehicle);
		old_target = waitresult.target;
	}
}

/*
	Name: target_death_watch
	Namespace: ultimate_turret
	Checksum: 0xE513737C
	Offset: 0x3970
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function target_death_watch(turretvehicle)
{
	target = self;
	target endon(#"abort_death_watch");
	turretvehicle endon(#"death");
	target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	turretvehicle clearenemy();
}

/*
	Name: get_killstreak_bundle
	Namespace: ultimate_turret
	Checksum: 0x41102EA2
	Offset: 0x3A28
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function get_killstreak_bundle()
{
	return level.killstreakbundle[#"ultimate_turret"];
}

/*
	Name: is_valid_target
	Namespace: ultimate_turret
	Checksum: 0x5BAB97FB
	Offset: 0x3A50
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function is_valid_target(potential_target, friendly_team)
{
	if(isdefined(potential_target))
	{
		if(issentient(potential_target) && potential_target.var_d600e174 === 1)
		{
			return false;
		}
		if(!isdefined(potential_target.team) || potential_target.team == friendly_team)
		{
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: function_fefefcc4
	Namespace: ultimate_turret
	Checksum: 0xDB86B2F9
	Offset: 0x3AE8
	Size: 0x348
	Parameters: 0
	Flags: Linked
*/
function function_fefefcc4()
{
	veh = self;
	turret_index = 0;
	veh endon(#"death", #"death_started", #"end_turret_scanning");
	wait(0.8);
	bundle = get_killstreak_bundle();
	var_beeadda8 = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300);
	while(true)
	{
		if(!isdefined(veh.enemy) && (!(isdefined(veh.isstunned) && veh.isstunned)) && (!(isdefined(veh.isjammed) && veh.isjammed)))
		{
			/#
				var_beeadda8 = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300);
			#/
			var_c9b6d0a7 = getplayers(util::getotherteam(veh.team), veh.origin, var_beeadda8);
			if(var_c9b6d0a7.size > 0)
			{
				if(veh.var_3413afc5 != #"hash_2d94a5f22d36fc73")
				{
					veh function_c524c4c8();
				}
				else
				{
					foreach(nearby_enemy in var_c9b6d0a7)
					{
						if(veh cansee(nearby_enemy) == 0)
						{
							continue;
						}
						if(veh targetting_delay::function_1c169b3a(nearby_enemy) == 0)
						{
							continue;
						}
						if(veh function_9d86d74c(nearby_enemy))
						{
							continue;
						}
						veh.favoriteenemy = nearby_enemy;
						veh.var_c8072bcc = gettime();
						veh.var_7eb3ebd5[nearby_enemy getentitynumber()] = #"hash_47697c94ffb4a5bd";
						break;
					}
				}
			}
			else if(veh.var_3413afc5 != #"standard_sight")
			{
				veh function_bc7568f1();
			}
		}
		wait_time = (veh.var_3413afc5 == #"standard_sight" ? 0.25 : 0.1);
		wait(wait_time);
	}
}

/*
	Name: function_9d86d74c
	Namespace: ultimate_turret
	Checksum: 0x7EBC5989
	Offset: 0x3E38
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_9d86d74c(enemy)
{
	fire_origin = self getseatfiringorigin(0);
	fire_angles = self getseatfiringangles(0);
	shoot_at_pos = enemy getshootatpos(self);
	var_6551f24e = anglestoforward(fire_angles);
	target_offset = shoot_at_pos - fire_origin;
	if(lengthsquared(target_offset) < (22 * 22) && vectordot(var_6551f24e, target_offset) < 0)
	{
		return true;
	}
	return false;
}

/*
	Name: function_2034705c
	Namespace: ultimate_turret
	Checksum: 0xF6F78E4
	Offset: 0x3F48
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_2034705c(bundle)
{
	var_351b3c55 = (isdefined(self.enemy) ? 0 : max((isdefined(self.enemylastseentime) ? self.enemylastseentime : 0), (isdefined(self.var_c8072bcc) ? self.var_c8072bcc : 0)));
	var_c112caa0 = int((isdefined(bundle.var_fa38350a) ? bundle.var_fa38350a : 1) * 1000);
	if(isdefined(self.enemy) && self.var_7eb3ebd5[self.enemy getentitynumber()] === #"damage")
	{
		var_c112caa0 = int((isdefined(bundle.var_33561c46) ? bundle.var_33561c46 : 3) * 1000);
	}
	return gettime() < (var_351b3c55 + var_c112caa0);
}

/*
	Name: function_fc58f46f
	Namespace: ultimate_turret
	Checksum: 0x9EFF7E2F
	Offset: 0x40A8
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_fc58f46f()
{
	veh = self;
	if(isdefined(veh.enemy))
	{
		veh.var_c8072bcc = undefined;
		veh.var_7eb3ebd5[veh.enemy getentitynumber()] = undefined;
	}
	veh clearenemy();
	veh.favoriteenemy = undefined;
	veh.turret_target = undefined;
}

/*
	Name: function_bc7568f1
	Namespace: ultimate_turret
	Checksum: 0xE8B6FE58
	Offset: 0x4138
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_bc7568f1()
{
	self.sightlatency = 100;
	self.fovcosine = 0.5;
	self.fovcosinebusy = 0.5;
	self.var_3413afc5 = #"standard_sight";
}

/*
	Name: function_c524c4c8
	Namespace: ultimate_turret
	Checksum: 0xFE20C97C
	Offset: 0x4190
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_c524c4c8()
{
	self.sightlatency = 100;
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.var_3413afc5 = #"hash_2d94a5f22d36fc73";
}

/*
	Name: get_target_offset
	Namespace: ultimate_turret
	Checksum: 0xC21563DE
	Offset: 0x41E0
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function get_target_offset(target)
{
	var_8134d046 = -12;
	stance = target getstance();
	if(stance == "prone")
	{
		var_8134d046 = -2;
	}
	return (0, 0, var_8134d046);
}

/*
	Name: function_b8952a40
	Namespace: ultimate_turret
	Checksum: 0xA587753D
	Offset: 0x4250
	Size: 0x188
	Parameters: 1
	Flags: Linked
*/
function function_b8952a40(turret_index)
{
	self notify("a8b5c714cb1e6d1");
	self endon("a8b5c714cb1e6d1");
	veh = self;
	while(isdefined(veh.enemy) && (!(isdefined(veh.isstunned) && veh.isstunned)) && (!(isdefined(veh.isjammed) && veh.isjammed)))
	{
		var_559acfe = veh.enemy getvelocity() * getdvarfloat(#"hash_3a25aaa27558e77b", 0.075);
		if(isplayer(veh.enemy))
		{
			target_offset = get_target_offset(veh.enemy);
			veh turretsettarget(turret_index, veh.enemy, target_offset + var_559acfe);
		}
		else
		{
			veh turretsettarget(turret_index, veh.enemy, var_559acfe);
		}
		wait(0.1);
	}
}

/*
	Name: turretscanning
	Namespace: ultimate_turret
	Checksum: 0x3DF72B5D
	Offset: 0x43E0
	Size: 0xEA4
	Parameters: 0
	Flags: Linked
*/
function turretscanning()
{
	veh = self;
	veh endon(#"death", #"death_started", #"end_turret_scanning");
	veh.turret_target = undefined;
	veh.do_not_clear_targets_during_think = 1;
	wait(0.8);
	veh playsound(#"mpl_turret_startup");
	veh playloopsound(#"hash_69240c6db92da5bf");
	bundle = get_killstreak_bundle();
	min_burst_time = bundle.ksburstfiremintime;
	max_burst_time = bundle.ksburstfiremaxtime;
	min_pause_time = bundle.ksburstfiredelaymintime;
	max_pause_time = bundle.ksburstfiredelaymaxtime;
	burst_fire_enabled = bundle.ksburstfireenabled;
	loc_000045A0:
	veh.maxsightdistsqrd = (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
	loc_000045F4:
	veh.var_e812cbe7 = (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
	loc_00004648:
	veh.var_38e6355c = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);
	while(true)
	{
		/#
			loc_000046A8:
			veh.maxsightdistsqrd = (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
			loc_000046FC:
			veh.var_e812cbe7 = (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
			loc_00004750:
			veh.var_38e6355c = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);
		#/
		if(isdefined(veh.isstunned) && veh.isstunned || (isdefined(veh.isjammed) && veh.isjammed))
		{
			veh function_fc58f46f();
			wait(0.5);
			continue;
		}
		if(veh.controlled || !veh.turret_enabled)
		{
			wait(0.5);
			continue;
		}
		if(isdefined(veh.enemy))
		{
			if(!is_valid_target(veh.enemy, veh.team))
			{
				veh setignoreent(veh.enemy, 1);
				veh function_fc58f46f();
				wait(0.1);
				continue;
			}
			var_2aa33bf1 = 0;
			if(distancesquared(veh.enemy.origin, veh.origin) > veh.var_38e6355c && veh.var_7eb3ebd5[veh.enemy getentitynumber()] === #"forwardscan")
			{
				var_2aa33bf1 = 1;
			}
			else if(veh function_9d86d74c(veh.enemy))
			{
				var_2aa33bf1 = 1;
			}
			if(var_2aa33bf1)
			{
				veh setpersonalignore(veh.enemy, 1);
				veh function_fc58f46f();
				wait(0.1);
				continue;
			}
			if(!isdefined(veh.var_7eb3ebd5[veh.enemy getentitynumber()]) && veh targetting_delay::function_1c169b3a(veh.enemy))
			{
				veh.var_c8072bcc = gettime();
				veh.var_7eb3ebd5[veh.enemy getentitynumber()] = #"forwardscan";
			}
		}
		if(veh has_active_enemy(bundle) && isdefined(veh.enemy) && isalive(veh.enemy))
		{
			veh.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);
			if(!isdefined(veh.turret_target) || veh.turret_target != veh.enemy)
			{
				veh.turret_target = veh.enemy;
				if(!isdefined(veh.var_2b8e6720) || (veh.var_2b8e6720 + 5000) < gettime())
				{
					veh playsoundtoteam("mpl_ultimate_turret_lockon", veh.team);
					veh playsoundtoteam("mpl_ultimate_turret_lockon_enemy", util::getotherteam(veh.team));
					veh.var_2b8e6720 = gettime();
				}
				veh thread function_b8952a40(0);
			}
			if(veh.turretontarget && veh function_2034705c(bundle) && veh cansee(veh.enemy))
			{
				if(burst_fire_enabled)
				{
					fire_time = (min_burst_time < max_burst_time ? randomfloatrange(min_burst_time, max_burst_time) : min_burst_time);
					var_fc9f290e = veh.enemy;
					veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
					var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
					if(min_pause_time > 0 && !var_afae28e0)
					{
						pause_time = (min_pause_time < max_pause_time ? randomfloatrange(min_pause_time, max_pause_time) : min_pause_time);
						waitresult = undefined;
						waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
						var_afae28e0 = waitresult._notify === "death";
					}
				}
				else
				{
					var_fc9f290e = veh.enemy;
					veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
					var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
				}
				if(var_afae28e0 && isdefined(veh.turret_target) && isdefined(veh.turret_target.var_e78602fc) && veh.turret_target.var_e78602fc == veh)
				{
					if(isdefined(veh.owner))
					{
						veh.owner luinotifyevent(#"mini_turret_kill");
						veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
					}
					veh.turretrotscale = 1;
					wait(randomfloatrange(0.05, 0.2));
				}
			}
			else
			{
				wait(0.25);
			}
			continue;
		}
		var_4ec572ee = isdefined(veh.turret_target);
		var_bb861d93 = 0;
		if(var_4ec572ee && issentient(veh.turret_target))
		{
			var_bb861d93 = isalive(veh.turret_target);
			veh setpersonalignore(veh.turret_target, 1.5);
		}
		veh function_fc58f46f();
		veh.turretrotscale = 1;
		if(var_4ec572ee && var_bb861d93)
		{
			veh playsoundtoteam("mpl_turret_lost", veh.team);
			veh playsoundtoteam("mpl_turret_lost_enemy", util::getotherteam(veh.team));
		}
		if(veh.var_63d65a8d == "arc")
		{
			if(veh.scanpos === "left")
			{
				veh turretsettargetangles(0, (-10, 40, 0));
				veh.scanpos = "right";
			}
			else
			{
				veh turretsettargetangles(0, (-10, -40, 0));
				veh.scanpos = "left";
			}
		}
		else
		{
			if(veh.scanpos === "left")
			{
				veh turretsettargetangles(0, (-10, 180, 0));
				veh.scanpos = "left2";
			}
			else
			{
				if(veh.scanpos === "left2")
				{
					veh turretsettargetangles(0, (-10, 360, 0));
					veh.scanpos = "right";
				}
				else
				{
					if(veh.scanpos === "right")
					{
						veh turretsettargetangles(0, (-10, -180, 0));
						veh.scanpos = "right2";
					}
					else
					{
						veh turretsettargetangles(0, (-10, -360, 0));
						veh.scanpos = "left";
					}
				}
			}
		}
		waitresult = undefined;
		waitresult = veh waittilltimeout(3.5, #"enemy");
		if(waitresult._notify == #"enemy" && isdefined(veh.enemy))
		{
			if(veh.var_aac73d6c && !isdefined(veh.enemylastseentime))
			{
				attempts = 0;
				max_tries = 10;
				while(attempts < max_tries && !isdefined(veh.enemylastseentime) && isdefined(veh.enemy))
				{
					veh getperfectinfo(self.enemy, 0);
					attempts++;
					wait(0.1);
				}
			}
		}
	}
}

/*
	Name: turretshutdown
	Namespace: ultimate_turret
	Checksum: 0xF430D429
	Offset: 0x5290
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function turretshutdown(killstreakid, team)
{
	turret = self;
	if(turret.shuttingdown === 1)
	{
		return;
	}
	if(isdefined(turret))
	{
		turret.shuttingdown = 1;
	}
	killstreakrules::killstreakstop("ultimate_turret", team, killstreakid);
	deployable::function_81598103(turret);
	if(isdefined(turret.vehicle))
	{
		turret.vehicle function_3a9dddac();
	}
}

/*
	Name: watchturretshutdown
	Namespace: ultimate_turret
	Checksum: 0xE4B4381F
	Offset: 0x5350
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function watchturretshutdown(player, killstreakid, team)
{
	player endon(#"disconnect", #"joined_team", #"joined_spectators");
	player thread function_d6c5b32b(player, killstreakid, team);
	turret = self;
	self waittill(#"hash_5f4a0ea8f3f4e0d0", #"death");
	turretshutdown(killstreakid, team);
}

/*
	Name: function_d6c5b32b
	Namespace: ultimate_turret
	Checksum: 0x5133A96D
	Offset: 0x5420
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function function_d6c5b32b(player, killstreakid, team)
{
	turret = self;
	player waittill(#"disconnect", #"joined_team", #"joined_spectators");
	if(isdefined(turret))
	{
		turret turretshutdown(killstreakid, team);
	}
}

/*
	Name: has_active_enemy
	Namespace: ultimate_turret
	Checksum: 0xFCD26AA9
	Offset: 0x54B8
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function has_active_enemy(bundle)
{
	if(self.var_aac73d6c === 1)
	{
	}
	else if(!isdefined(self.enemylastseentime))
	{
		return 0;
	}
	if(isdefined(self.favoriteenemy))
	{
		if(!isalive(self.favoriteenemy))
		{
			return 0;
		}
		if(self targetting_delay::function_1c169b3a(self.favoriteenemy) == 0)
		{
			return 0;
		}
	}
	if(isdefined(self.enemy) && self.favoriteenemy !== self.enemy)
	{
		if(!isalive(self.enemy))
		{
			return 0;
		}
		if(self targetting_delay::function_1c169b3a(self.enemy) == 0)
		{
			return 0;
		}
	}
	return function_2034705c(bundle);
}

/*
	Name: function_be04d904
	Namespace: ultimate_turret
	Checksum: 0x15B0EC65
	Offset: 0x55C0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_be04d904()
{
	onshutdown(self.turret);
	self function_21f16a35();
}

/*
	Name: function_21f16a35
	Namespace: ultimate_turret
	Checksum: 0x18AD2416
	Offset: 0x5600
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_21f16a35()
{
	self thread function_59ce22f9(undefined, undefined);
}

/*
	Name: function_59ce22f9
	Namespace: ultimate_turret
	Checksum: 0x36F9D50F
	Offset: 0x5628
	Size: 0x1CC
	Parameters: 2
	Flags: Linked
*/
function function_59ce22f9(attacker, callback_data)
{
	if(!isdefined(self))
	{
		return;
	}
	if(self.dead === 1)
	{
		return;
	}
	fxpos = (isdefined(self gettagorigin("tag_turret")) ? self gettagorigin("tag_turret") : self.origin);
	playfx(level._equipment_explode_fx_lg, fxpos);
	self playsound("mpl_turret_exp");
	bundle = level.killstreakbundle[#"ultimate_turret"];
	if(isdefined(bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		playfx(bundle.var_bb6c29b4, self.origin);
	}
	self stoploopsound(0.5);
	self function_3a9dddac();
	turret = self.turret;
	self delete();
	waittillframeend();
	if(isdefined(turret))
	{
		turret delete();
	}
}

/*
	Name: function_31477582
	Namespace: ultimate_turret
	Checksum: 0x626338C7
	Offset: 0x5800
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_31477582()
{
	self endon(#"death");
	waitframe(1);
	var_463c449d = 386.0886 * (float(function_60d95f53()) / 1000);
	max_delta = 1;
	while(true)
	{
		if(!isdefined(self.turret))
		{
			wait(1);
			continue;
		}
		trace = physicstrace(self.origin + vectorscale((0, 0, 1), 15), self.origin + (vectorscale((0, 0, -1), 10)), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);
		if(trace[#"fraction"] > 0)
		{
			new_origin = trace[#"position"];
			self.origin = (new_origin[0], new_origin[1], self.origin[2] - (min(max_delta, self.origin[2] - new_origin[2])));
			max_delta = max_delta + var_463c449d;
			waitframe(1);
			continue;
		}
		max_delta = 1;
		wait(1);
	}
}

/*
	Name: on_player_killed
	Namespace: ultimate_turret
	Checksum: 0xC4305D73
	Offset: 0x59E0
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!isdefined(self.var_6ef09a14))
	{
		return;
	}
	var_f60ab10f = [];
	foreach(var_69501900 in self.var_6ef09a14)
	{
		if(!isdefined(var_69501900))
		{
			continue;
		}
		if(!isdefined(var_69501900.owner))
		{
			continue;
		}
		if(!isdefined(self.var_e78602fc))
		{
			continue;
		}
		if(self.var_e78602fc.vehicletype === #"ultimate_turret")
		{
			continue;
		}
		if(var_69501900.vehicletype === #"ultimate_turret")
		{
			if(!isdefined(var_f60ab10f))
			{
				var_f60ab10f = [];
			}
			else if(!isarray(var_f60ab10f))
			{
				var_f60ab10f = array(var_f60ab10f);
			}
			if(!isinarray(var_f60ab10f, var_69501900.owner))
			{
				var_f60ab10f[var_f60ab10f.size] = var_69501900.owner;
			}
		}
	}
	foreach(player in var_f60ab10f)
	{
		player playsoundtoplayer(#"hash_37ffaa04e3f898fa", player);
	}
}

