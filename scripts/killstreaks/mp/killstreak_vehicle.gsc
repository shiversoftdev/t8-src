// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\weapons\deployable.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicles\rcxd.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\killstreaks\remote_weapons.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\killstreaks\killstreak_bundles.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\audio_shared.gsc;
#using scripts\abilities\ability_player.gsc;

#namespace killstreak_vehicle;

/*
	Name: init
	Namespace: killstreak_vehicle
	Checksum: 0x4E2C5766
	Offset: 0x228
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("vehicle", "stunned", 1, 1, "int");
}

/*
	Name: init_killstreak
	Namespace: killstreak_vehicle
	Checksum: 0x713F3AC5
	Offset: 0x268
	Size: 0x14C
	Parameters: 1
	Flags: None
*/
function init_killstreak(bundle)
{
	killstreaks::register_bundle(bundle, &activate_vehicle);
	killstreaks::allow_assists(bundle.var_d3413870, 1);
	remote_weapons::registerremoteweapon(bundle.ksweapon.name, #"", &function_c9aa9ee5, &function_8cb72281, 0);
	vehicle::add_main_callback(bundle.ksvehicle, &init_vehicle);
	deployable::register_deployable(bundle.ksweapon, undefined, undefined);
	level.killstreaks[bundle.var_d3413870].var_b6c17aab = 1;
	if(isdefined(bundle.var_486124e6))
	{
		visionset_mgr::register_info("overlay", bundle.var_486124e6, 1, 1, 1, 1);
	}
}

/*
	Name: init_vehicle
	Namespace: killstreak_vehicle
	Checksum: 0xAC9E3204
	Offset: 0x3C0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function init_vehicle()
{
	vehicle = self;
	vehicle clientfield::set("enemyvehicle", 1);
	vehicle.allowfriendlyfiredamageoverride = &function_e9da8b7d;
	vehicle enableaimassist();
	vehicle setdrawinfrared(1);
	vehicle.delete_on_death = 1;
	vehicle.death_enter_cb = &function_3c6cec8b;
	vehicle.disableremoteweaponswitch = 1;
	vehicle.overridevehicledamage = &on_damage;
	vehicle.overridevehiclekilled = &on_death;
	vehicle.watch_remote_weapon_death = 1;
	vehicle.watch_remote_weapon_death_duration = 0.3;
	vehicle util::make_sentient();
}

/*
	Name: function_3c6cec8b
	Namespace: killstreak_vehicle
	Checksum: 0x4C73E9F7
	Offset: 0x4E8
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function function_3c6cec8b()
{
	remote_controlled = isdefined(self.control_initiated) && self.control_initiated || (isdefined(self.controlled) && self.controlled);
	if(remote_controlled)
	{
		notifystring = undefined;
		notifystring = self waittill(#"remote_weapon_end", #"shutdown");
		if(notifystring._notify == "remote_weapon_end")
		{
			self waittill(#"shutdown");
		}
		else
		{
			self waittill(#"remote_weapon_end");
		}
	}
	else
	{
		self waittill(#"shutdown");
	}
}

/*
	Name: function_aba709c3
	Namespace: killstreak_vehicle
	Checksum: 0x6C52B285
	Offset: 0x5D0
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_aba709c3(hacker)
{
	vehicle = self;
	vehicle clientfield::set("toggle_lights", 1);
	vehicle.owner unlink();
	vehicle clientfield::set("vehicletransition", 0);
	vehicle.owner killstreaks::clear_using_remote();
	vehicle makevehicleunusable();
}

/*
	Name: function_2df6e3bf
	Namespace: killstreak_vehicle
	Checksum: 0xF973AB09
	Offset: 0x680
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_2df6e3bf(hacker)
{
	killstreak_type = level.var_8997324c[self];
	bundle = level.killstreaks[killstreak_type].script_bundle;
	vehicle = self;
	hacker remote_weapons::useremoteweapon(vehicle, bundle.ksweapon, 1, 0);
	vehicle makevehicleunusable();
	vehicle killstreaks::set_killstreak_delay_killcam(killstreak_type);
	vehicle killstreak_hacking::set_vehicle_drivable_time_starting_now(vehicle);
}

/*
	Name: function_fff56140
	Namespace: killstreak_vehicle
	Checksum: 0x27B2A1B0
	Offset: 0x750
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_fff56140(owner)
{
	self endon(#"shutdown");
	self killstreaks::function_fff56140(owner, &function_822e1f64);
}

/*
	Name: function_5e2ea3ef
	Namespace: killstreak_vehicle
	Checksum: 0x57398E73
	Offset: 0x7A8
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_5e2ea3ef(owner, ishacked)
{
	self thread function_fff56140(owner);
}

/*
	Name: can_activate
	Namespace: killstreak_vehicle
	Checksum: 0x7356C107
	Offset: 0x7E0
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function can_activate(placement)
{
	if(!isdefined(placement))
	{
		return false;
	}
	if(!self isonground())
	{
		return false;
	}
	if(self util::isusingremote())
	{
		return false;
	}
	if(killstreaks::is_interacting_with_object())
	{
		return false;
	}
	if(self oob::istouchinganyoobtrigger())
	{
		return false;
	}
	return true;
}

/*
	Name: activate_vehicle
	Namespace: killstreak_vehicle
	Checksum: 0x4373F091
	Offset: 0x868
	Size: 0x508
	Parameters: 1
	Flags: Linked
*/
function activate_vehicle(type)
{
	/#
		assert(isplayer(self));
	#/
	player = self;
	if(!player killstreakrules::iskillstreakallowed(type, player.team))
	{
		return false;
	}
	if(player usebuttonpressed())
	{
		return false;
	}
	bundle = level.killstreaks[type].script_bundle;
	if(isdefined(bundle.ksweapon) && (isdefined(bundle.ksweapon.deployable) && bundle.ksweapon.deployable) && !deployable::function_b3d993e9(bundle.ksweapon, 1))
	{
		return false;
	}
	killstreak_id = player killstreakrules::killstreakstart(type, player.team, 0, 1);
	if(killstreak_id == -1)
	{
		return false;
	}
	vehicle = spawnvehicle(bundle.ksvehicle, player.var_b8878ba9, player.var_ddc03e10, type);
	vehicle deployable::function_dd266e08(player);
	vehicle killstreaks::configure_team(type, killstreak_id, player, "small_vehicle", undefined, &function_5e2ea3ef);
	vehicle killstreak_hacking::enable_hacking(type, &function_aba709c3, &function_2df6e3bf);
	vehicle.damagetaken = 0;
	vehicle.abandoned = 0;
	vehicle.killstreak_id = killstreak_id;
	vehicle.activatingkillstreak = 1;
	vehicle setinvisibletoall();
	vehicle thread watch_shutdown(player);
	vehicle.health = bundle.kshealth;
	vehicle.maxhealth = bundle.kshealth;
	vehicle.hackedhealth = bundle.kshackedhealth;
	vehicle.hackedhealthupdatecallback = &function_f07460c5;
	vehicle.ignore_vehicle_underneath_splash_scalar = 1;
	if(isdefined(bundle.ksweapon))
	{
		vehicle setweapon(bundle.ksweapon);
		vehicle.weapon = bundle.ksweapon;
	}
	vehicle killstreak_bundles::spawned(bundle);
	self thread killstreaks::play_killstreak_start_dialog(type, self.team, killstreak_id);
	self stats::function_e24eec31(bundle.ksweapon, #"used", 1);
	remote_weapons::useremoteweapon(vehicle, bundle.ksweapon.name, 1, 0);
	if(!isdefined(player) || !isalive(player) || (isdefined(player.laststand) && player.laststand) || player isempjammed())
	{
		if(isdefined(vehicle))
		{
			vehicle notify(#"remote_weapon_shutdown");
			vehicle function_1f46c433();
		}
		return false;
	}
	if(!isdefined(vehicle))
	{
		return false;
	}
	vehicle setvisibletoall();
	vehicle.activatingkillstreak = 0;
	target_set(vehicle);
	ability_player::function_c22f319e(bundle.ksweapon);
	vehicle thread watch_game_ended();
	vehicle waittill(#"death");
	return true;
}

/*
	Name: function_f07460c5
	Namespace: killstreak_vehicle
	Checksum: 0x717BCEA3
	Offset: 0xD78
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_f07460c5(hacker)
{
	vehicle = self;
	if(vehicle.health > vehicle.hackedhealth)
	{
		vehicle.health = vehicle.hackedhealth;
	}
}

/*
	Name: function_c9aa9ee5
	Namespace: killstreak_vehicle
	Checksum: 0x119C2BC7
	Offset: 0xDD0
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_c9aa9ee5(vehicle)
{
	player = self;
	vehicle usevehicle(player, 0);
	vehicle clientfield::set("vehicletransition", 1);
	vehicle thread audio::sndupdatevehiclecontext(1);
	vehicle thread watch_timeout();
	vehicle thread function_2cee4434();
	vehicle thread function_22528515();
	vehicle thread watch_water();
	player vehicle::set_vehicle_drivable_time_starting_now(int(vehicle.var_22a05c26.ksduration));
	if(isdefined(vehicle.var_22a05c26.var_486124e6))
	{
		visionset_mgr::activate("overlay", vehicle.var_22a05c26.var_486124e6, player, 1, 90000, 1);
	}
	if(isbot(self))
	{
		if(isdefined(vehicle.killstreaktype) && (vehicle.killstreaktype == "recon_car" || vehicle.killstreaktype == "inventory_recon_car"))
		{
			self thread function_88d23aaa(vehicle);
		}
	}
}

/*
	Name: function_88d23aaa
	Namespace: killstreak_vehicle
	Checksum: 0x48BD3598
	Offset: 0xFB0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_88d23aaa(vehicle)
{
	var_8eaf8b3c = vehicle.overridevehiclekilled;
	vehicle thread rcxd::function_91ea9492();
	vehicle vehicle_ai::get_state_callbacks("death").update_func = undefined;
	vehicle.overridevehiclekilled = var_8eaf8b3c;
}

/*
	Name: function_8cb72281
	Namespace: killstreak_vehicle
	Checksum: 0x56662E66
	Offset: 0x1028
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_8cb72281(vehicle, exitrequestedbyowner)
{
	if(exitrequestedbyowner == 0)
	{
		vehicle function_1f46c433();
		vehicle thread audio::sndupdatevehiclecontext(0);
	}
	if(isdefined(vehicle.var_22a05c26.var_486124e6))
	{
		visionset_mgr::deactivate("overlay", vehicle.var_22a05c26.var_486124e6, vehicle.owner);
	}
	vehicle clientfield::set("vehicletransition", 0);
	function_68a07849(vehicle.var_22a05c26, self.remoteowner);
}

/*
	Name: function_2cee4434
	Namespace: killstreak_vehicle
	Checksum: 0x63B0AE37
	Offset: 0x1118
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_2cee4434()
{
	vehicle = self;
	vehicle endon(#"shutdown", #"death");
	while(isdefined(level.var_46f4865d) && level.var_46f4865d)
	{
		waitframe(1);
	}
	while(!(isdefined(vehicle.owner) && (vehicle.owner attackbuttonpressed() || vehicle.owner vehicleattackbuttonpressed())))
	{
		waitframe(1);
	}
	vehicle function_1f46c433();
}

/*
	Name: watch_exit
	Namespace: killstreak_vehicle
	Checksum: 0xD91199A3
	Offset: 0x11F8
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function watch_exit()
{
	vehicle = self;
	vehicle endon(#"shutdown", #"death");
	while(true)
	{
		timeused = 0;
		while(vehicle.owner usebuttonpressed())
		{
			timeused = timeused + level.var_9fee970c;
			if(timeused >= 250)
			{
				vehicle function_1f46c433();
				return;
			}
			waitframe(1);
		}
		waitframe(1);
	}
}

/*
	Name: function_e99d09a3
	Namespace: killstreak_vehicle
	Checksum: 0x8D855933
	Offset: 0x12C0
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function function_e99d09a3()
{
	self endon(#"shutdown");
	inwater = 0;
	while(!inwater)
	{
		wait(0.5);
		trace = physicstrace(self.origin + vectorscale((0, 0, 1), 10), self.origin + vectorscale((0, 0, 1), 6), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), self, 4);
		inwater = trace[#"fraction"] < 1;
	}
	self function_822e1f64();
}

/*
	Name: watch_water
	Namespace: killstreak_vehicle
	Checksum: 0x59187379
	Offset: 0x13A0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function watch_water()
{
	self endon(#"shutdown");
	var_8a7edebd = 10;
	inwater = 0;
	while(!inwater)
	{
		wait(0.5);
		depth = getwaterheight(self.origin) - self.origin[2];
		inwater = depth > var_8a7edebd;
	}
	self function_822e1f64();
}

/*
	Name: watch_timeout
	Namespace: killstreak_vehicle
	Checksum: 0xFC7558A
	Offset: 0x1450
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function watch_timeout()
{
	vehicle = self;
	bundle = vehicle.var_22a05c26;
	vehicle thread killstreaks::waitfortimeout(bundle.var_d3413870, bundle.ksduration, &function_1f46c433, "shutdown");
}

/*
	Name: function_822e1f64
	Namespace: killstreak_vehicle
	Checksum: 0xB3D36362
	Offset: 0x14C8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_822e1f64()
{
	vehicle = self;
	vehicle.abandoned = 1;
	vehicle function_1f46c433();
}

/*
	Name: function_1f46c433
	Namespace: killstreak_vehicle
	Checksum: 0xCCD21CF4
	Offset: 0x1508
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function function_1f46c433()
{
	vehicle = self;
	vehicle notify(#"shutdown");
}

/*
	Name: function_68a07849
	Namespace: killstreak_vehicle
	Checksum: 0x5C5D4653
	Offset: 0x1538
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_68a07849(bundle, driver)
{
	if(isdefined(driver))
	{
		var_4dd90b81 = 0;
		driver ability_player::function_f2250880(bundle.ksweapon, var_4dd90b81);
	}
}

/*
	Name: watch_shutdown
	Namespace: killstreak_vehicle
	Checksum: 0xBC51023E
	Offset: 0x1590
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function watch_shutdown(driver)
{
	vehicle = self;
	vehicle endon(#"death");
	vehicle waittill(#"shutdown");
	bundle = vehicle.var_22a05c26;
	vehicle notify(#"remote_weapon_shutdown");
	if(isdefined(vehicle.activatingkillstreak) && vehicle.activatingkillstreak)
	{
		killstreakrules::killstreakstop(bundle.var_d3413870, vehicle.originalteam, vehicle.killstreak_id);
		vehicle function_1f46c433();
		vehicle delete();
	}
	else
	{
		vehicle thread function_584fb7a3();
	}
	vehicle killstreaks::function_67bc25ec();
	function_68a07849(bundle, driver);
}

/*
	Name: function_584fb7a3
	Namespace: killstreak_vehicle
	Checksum: 0xC75BE474
	Offset: 0x16E0
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_584fb7a3()
{
	vehicle = self;
	vehicle endon(#"death");
	if(!(isdefined(vehicle.remote_weapon_end) && vehicle.remote_weapon_end))
	{
		vehicle waittill(#"remote_weapon_end", #"hash_59b25025ce93a142");
	}
	attacker = (isdefined(vehicle.owner) ? vehicle.owner : undefined);
	vehicle dodamage(vehicle.health + 1, vehicle.origin + vectorscale((0, 0, 1), 10), attacker, attacker, "none", "MOD_EXPLOSIVE", 0);
}

/*
	Name: function_22528515
	Namespace: killstreak_vehicle
	Checksum: 0x5C1F7D16
	Offset: 0x17E8
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_22528515()
{
	vehicle = self;
	vehicle endon(#"shutdown");
	while(true)
	{
		waitresult = undefined;
		waitresult = vehicle waittill(#"touch");
		ent = waitresult.entity;
		if(isdefined(ent.classname) && (ent.classname == "trigger_hurt_new" || ent.classname == "trigger_out_of_bounds"))
		{
			vehicle function_1f46c433();
		}
	}
}

/*
	Name: on_damage
	Namespace: killstreak_vehicle
	Checksum: 0x99BA9500
	Offset: 0x18C0
	Size: 0x19C
	Parameters: 15
	Flags: Linked
*/
function on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(self.activatingkillstreak)
	{
		return 0;
	}
	if(!isdefined(eattacker) || eattacker != self.owner)
	{
		bundle = self.var_22a05c26;
		idamage = killstreaks::ondamageperweapon(bundle.var_d3413870, eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
	}
	if(isdefined(eattacker) && isdefined(eattacker.team) && util::function_fbce7263(eattacker.team, self.team))
	{
		if(weapon.isemp)
		{
			self.damage_on_death = 0;
			self.died_by_emp = 1;
			idamage = self.health + 1;
		}
	}
	return idamage;
}

/*
	Name: on_death
	Namespace: killstreak_vehicle
	Checksum: 0x5C33C65B
	Offset: 0x1A68
	Size: 0x29C
	Parameters: 8
	Flags: Linked
*/
function on_death(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	vehicle = self;
	player = vehicle.owner;
	player endon(#"disconnect", #"joined_team", #"joined_spectators");
	bundle = self.var_22a05c26;
	var_7d4f75e = (isdefined(vehicle.var_7d4f75e) ? vehicle.var_7d4f75e : 0);
	var_a9911aeb = bundle.var_d3413870;
	var_a8527b41 = vehicle.originalteam;
	var_ebe66d84 = vehicle.killstreak_id;
	if(!var_7d4f75e)
	{
		killstreakrules::killstreakstop(var_a9911aeb, var_a8527b41, var_ebe66d84);
	}
	vehicle clientfield::set("enemyvehicle", 0);
	vehicle explode(eattacker, weapon);
	var_2105be53 = (vehicle.died_by_emp === 1 ? 0.2 : 0.1);
	if(isdefined(player))
	{
		player val::set(#"hash_7412aa1ce117e2a5", "freezecontrols");
		vehicle thread function_de865657(var_2105be53);
		wait(0.2);
		player val::reset(#"hash_7412aa1ce117e2a5", "freezecontrols");
	}
	else
	{
		vehicle thread function_de865657(var_2105be53);
	}
	if(var_7d4f75e)
	{
		killstreakrules::killstreakstop(var_a9911aeb, var_a8527b41, var_ebe66d84);
	}
	if(isdefined(vehicle))
	{
		vehicle function_1f46c433();
	}
}

/*
	Name: watch_game_ended
	Namespace: killstreak_vehicle
	Checksum: 0x53F4575A
	Offset: 0x1D10
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function watch_game_ended()
{
	vehicle = self;
	vehicle endon(#"death");
	level waittill(#"game_ended");
	vehicle.selfdestruct = 1;
	vehicle function_822e1f64();
}

/*
	Name: function_de865657
	Namespace: killstreak_vehicle
	Checksum: 0xB3902931
	Offset: 0x1D80
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_de865657(waittime)
{
	self endon(#"death");
	wait(waittime);
	self ghost();
	self.var_4217cfcb = 1;
}

/*
	Name: vehicle_death
	Namespace: killstreak_vehicle
	Checksum: 0xDEED9F44
	Offset: 0x1DD8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function vehicle_death()
{
	self vehicle_death::death_fx();
	self thread vehicle_death::death_radius_damage();
	self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self vehicle::lights_off();
}

/*
	Name: explode
	Namespace: killstreak_vehicle
	Checksum: 0xBD9EA4F7
	Offset: 0x1EA0
	Size: 0x310
	Parameters: 2
	Flags: Linked
*/
function explode(attacker, weapon)
{
	self endon(#"death");
	owner = self.owner;
	if(!isdefined(attacker) && isdefined(owner))
	{
		attacker = owner;
	}
	attacker = self [[level.figure_out_attacker]](attacker);
	self vehicle_death();
	var_d3213f00 = 0;
	var_3906173b = isdefined(weapon) && weapon.name === "gadget_icepick";
	if(!(isdefined(self.abandoned) && self.abandoned) && isplayer(attacker))
	{
		bundle = self.var_22a05c26;
		if(util::function_fbce7263(self.team, attacker.team))
		{
			if(isdefined(bundle))
			{
				attacker challenges::destroy_killstreak_vehicle(weapon, self, bundle.var_ebc402ca);
			}
			var_d3213f00 = 1;
			if(isdefined(bundle))
			{
				self killstreaks::function_73566ec7(attacker, weapon, owner);
				luinotifyevent(#"player_callout", 2, bundle.var_cbe3d7de, attacker.entnum);
				if(isdefined(weapon) && weapon.isvalid)
				{
					level.globalkillstreaksdestroyed++;
					attacker stats::function_e24eec31(bundle.ksweapon, #"destroyed", 1);
					attacker stats::function_e24eec31(bundle.ksweapon, #"destroyed_controlled_killstreak", 1);
				}
				if(!var_3906173b)
				{
					self killstreaks::play_destroyed_dialog_on_owner(bundle.var_d3413870, self.killstreak_id);
					attacker battlechatter::function_dd6a6012(bundle.var_d3413870, weapon);
				}
			}
		}
	}
	if(isdefined(bundle) && isdefined(bundle.var_bb6c29b4) && isdefined(weapon) && weapon == getweapon(#"shock_rifle"))
	{
		playfx(bundle.var_bb6c29b4, self.origin);
	}
	return var_d3213f00;
}

/*
	Name: function_e9da8b7d
	Namespace: killstreak_vehicle
	Checksum: 0xBF165E65
	Offset: 0x21B8
	Size: 0x70
	Parameters: 4
	Flags: Linked
*/
function function_e9da8b7d(einflictor, eattacker, smeansofdeath, weapon)
{
	if(isdefined(eattacker) && eattacker == self.owner)
	{
		return true;
	}
	if(isdefined(einflictor) && einflictor islinkedto(self))
	{
		return true;
	}
	return false;
}

/*
	Name: function_e94c2667
	Namespace: killstreak_vehicle
	Checksum: 0x7BC32050
	Offset: 0x2230
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_e94c2667()
{
	startheight = 50;
	switch(self getstance())
	{
		case "crouch":
		{
			startheight = 30;
			break;
		}
		case "prone":
		{
			startheight = 15;
			break;
		}
	}
	return startheight;
}

/*
	Name: function_d75fbe15
	Namespace: killstreak_vehicle
	Checksum: 0x8CB7E069
	Offset: 0x22B0
	Size: 0x4A0
	Parameters: 2
	Flags: None
*/
function function_d75fbe15(origin, angles)
{
	startheight = function_e94c2667();
	mins = vectorscale((-1, -1, 0), 5);
	maxs = (5, 5, 10);
	startpoints = [];
	startangles = [];
	wheelcounts = [];
	testcheck = [];
	largestcount = 0;
	largestcountindex = 0;
	testangles = [];
	testangles[0] = (0, 0, 0);
	testangles[1] = vectorscale((0, 1, 0), 20);
	testangles[2] = vectorscale((0, -1, 0), 20);
	testangles[3] = vectorscale((0, 1, 0), 45);
	testangles[4] = vectorscale((0, -1, 0), 45);
	heightoffset = 5;
	for(i = 0; i < testangles.size; i++)
	{
		testcheck[i] = 0;
		startangles[i] = (0, angles[1], 0);
		startpoint = origin + (vectorscale(anglestoforward(startangles[i] + testangles[i]), 70));
		endpoint = startpoint - vectorscale((0, 0, 1), 100);
		startpoint = startpoint + (0, 0, startheight);
		mask = 1 | 2;
		trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);
		if(isdefined(trace[#"entity"]) && isplayer(trace[#"entity"]))
		{
			wheelcounts[i] = 0;
			continue;
		}
		startpoints[i] = trace[#"position"] + (0, 0, heightoffset);
		wheelcounts[i] = function_c82e14d2(startpoints[i], startangles[i], heightoffset);
		if(positionwouldtelefrag(startpoints[i]))
		{
			continue;
		}
		if(largestcount < wheelcounts[i])
		{
			largestcount = wheelcounts[i];
			largestcountindex = i;
		}
		if(wheelcounts[i] >= 3)
		{
			testcheck[i] = 1;
			if(function_b4682bd6(startpoints[i], startangles[i]))
			{
				placement = spawnstruct();
				placement.origin = startpoints[i];
				placement.angles = startangles[i];
				return placement;
			}
		}
	}
	for(i = 0; i < testangles.size; i++)
	{
		if(!testcheck[i])
		{
			if(wheelcounts[i] >= 2)
			{
				if(function_b4682bd6(startpoints[i], startangles[i]))
				{
					placement = spawnstruct();
					placement.origin = startpoints[i];
					placement.angles = startangles[i];
					return placement;
				}
			}
		}
	}
	return undefined;
}

/*
	Name: function_c82e14d2
	Namespace: killstreak_vehicle
	Checksum: 0x3E35AF1E
	Offset: 0x2758
	Size: 0x1EC
	Parameters: 3
	Flags: Linked
*/
function function_c82e14d2(origin, angles, heightoffset)
{
	forward = 13;
	side = 10;
	wheels = [];
	wheels[0] = (forward, side, 0);
	wheels[1] = (forward, -1 * side, 0);
	wheels[2] = (-1 * forward, -1 * side, 0);
	wheels[3] = (-1 * forward, side, 0);
	height = 5;
	touchcount = 0;
	yawangles = (0, angles[1], 0);
	for(i = 0; i < 4; i++)
	{
		wheel = rotatepoint(wheels[i], yawangles);
		startpoint = origin + wheel;
		endpoint = startpoint + (0, 0, -1 * height - heightoffset);
		startpoint = startpoint + (0, 0, height - heightoffset);
		trace = bullettrace(startpoint, endpoint, 0, self);
		if(trace[#"fraction"] < 1)
		{
			touchcount++;
		}
	}
	return touchcount;
}

/*
	Name: function_b4682bd6
	Namespace: killstreak_vehicle
	Checksum: 0xD6BA4EEC
	Offset: 0x2950
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function function_b4682bd6(origin, angles)
{
	liftedorigin = origin + vectorscale((0, 0, 1), 5);
	size = 12;
	height = 15;
	mins = (-1 * size, -1 * size, 0);
	maxs = (size, size, height);
	absmins = liftedorigin + mins;
	absmaxs = liftedorigin + maxs;
	if(boundswouldtelefrag(absmins, absmaxs))
	{
		return false;
	}
	startheight = function_e94c2667();
	mask = (1 | 2) | 4;
	trace = physicstrace(liftedorigin, origin + (0, 0, 1), mins, maxs, self, mask);
	if(trace[#"fraction"] < 1)
	{
		return false;
	}
	size = 2.5;
	height = size * 2;
	mins = (-1 * size, -1 * size, 0);
	maxs = (size, size, height);
	sweeptrace = physicstrace(self.origin + (0, 0, startheight), liftedorigin, mins, maxs, self, mask);
	if(sweeptrace[#"fraction"] < 1)
	{
		return false;
	}
	return true;
}

