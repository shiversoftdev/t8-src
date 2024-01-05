// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_cleanup_mgr.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_behavior_utility.gsc;
#using scripts\zm_common\zm_attackables.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie.gsc;
#using script_41fe08c37d53a635;
#using script_522aeb6ae906391e;
#using script_3aa0f32b70d4f7cb;
#using script_489b835a247c990e;
#using scripts\core_common\ai\archetype_utility.gsc;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_caf007e2a98afa2;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace zm_behavior;

/*
	Name: __init__system__
	Namespace: zm_behavior
	Checksum: 0x93A6DDAC
	Offset: 0x428
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_behavior", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_behavior
	Checksum: 0x80B23813
	Offset: 0x478
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	initzmbehaviorsandasm();
	if(!isdefined(level.zigzag_activation_distance))
	{
		level.zigzag_activation_distance = 175;
	}
	if(!isdefined(level.zigzag_distance_min))
	{
		level.zigzag_distance_min = 256;
	}
	if(!isdefined(level.zigzag_distance_max))
	{
		level.zigzag_distance_max = 400;
	}
	if(!isdefined(level.inner_zigzag_radius))
	{
		level.inner_zigzag_radius = 16;
	}
	if(!isdefined(level.outer_zigzag_radius))
	{
		level.outer_zigzag_radius = 128;
	}
	zm_utility::function_d0f02e71(#"zombie");
	spawner::add_archetype_spawn_function(#"zombie", &function_c15c6e44);
	spawner::add_archetype_spawn_function(#"zombie", &zombiespawninit);
	level.do_randomized_zigzag_path = 1;
	level.zombie_targets = [];
	zm::register_actor_damage_callback(&function_7994fd99);
}

/*
	Name: zombiespawninit
	Namespace: zm_behavior
	Checksum: 0x4BE546F
	Offset: 0x5E0
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
function private zombiespawninit()
{
	self pushplayer(0);
	self collidewithactors(0);
	self thread zm_utility::function_13cc9756();
	self.closest_player_override = &zm_utility::function_c52e1749;
	self.var_1731eda3 = 1;
	self.var_2c628c0f = 1;
	self.am_i_valid = 1;
	self.cant_move_cb = &zombiebehavior::function_22762653;
	self zm_spawner::zombie_spawn_init();
}

/*
	Name: function_c15c6e44
	Namespace: zm_behavior
	Checksum: 0x1915A8DA
	Offset: 0x698
	Size: 0x56
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c15c6e44()
{
	self endon(#"death");
	self waittill(#"completed_emerging_into_playable_area");
	self.var_641025d6 = gettime() + self ai::function_9139c839().var_9c0ebe1e;
}

/*
	Name: __main__
	Namespace: zm_behavior
	Checksum: 0x85FAA35E
	Offset: 0x6F8
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_57d3b5eb);
}

/*
	Name: function_57d3b5eb
	Namespace: zm_behavior
	Checksum: 0xB4D7D55E
	Offset: 0x740
	Size: 0x20E
	Parameters: 0
	Flags: Linked
*/
function function_57d3b5eb()
{
	if(isdefined(self._starting_round_number))
	{
		self.maxhealth = int(zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), self._starting_round_number) * (isdefined(level.var_46e03bb6) ? level.var_46e03bb6 : 1));
		self.health = self.maxhealth;
	}
	else
	{
		self zm_cleanup::function_aa5726f2();
	}
	self zm_utility::init_zombie_run_cycle();
	self thread zm_spawner::zombie_think();
	if(isdefined(level._zombie_custom_spawn_logic))
	{
		if(isarray(level._zombie_custom_spawn_logic))
		{
			for(i = 0; i < level._zombie_custom_spawn_logic.size; i++)
			{
				self thread [[level._zombie_custom_spawn_logic[i]]]();
			}
		}
		else
		{
			self thread [[level._zombie_custom_spawn_logic]]();
		}
	}
	if(!isdefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		if(!(isdefined(self.is_inert) && self.is_inert))
		{
			self thread zombie_utility::delayed_zombie_eye_glow();
		}
	}
	if(isdefined(level.zombie_init_done))
	{
		self [[level.zombie_init_done]]();
	}
	self.zombie_init_done = 1;
	self zm_score::function_82732ced();
	self notify(#"zombie_init_done");
}

/*
	Name: initzmbehaviorsandasm
	Namespace: zm_behavior
	Checksum: 0xE90F5E79
	Offset: 0x958
	Size: 0x2434
	Parameters: 0
	Flags: Linked, Private
*/
function private initzmbehaviorsandasm()
{
	/#
		assert(isscriptfunctionptr(&shouldmovecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmove", &shouldmovecondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldtearcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtear", &zombieshouldtearcondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldtauntcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtaunt", &zombieshouldtauntcondition);
	/#
		assert(isscriptfunctionptr(&zombiegottoentrancecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoentrance", &zombiegottoentrancecondition);
	/#
		assert(isscriptfunctionptr(&zombiegottoattackspotcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoattackspot", &zombiegottoattackspotcondition);
	/#
		assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldenterplayablecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldenterplayable", &zombieshouldenterplayablecondition);
	/#
		assert(isscriptfunctionptr(&ischunkvalidcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"ischunkvalid", &ischunkvalidcondition);
	/#
		assert(isscriptfunctionptr(&inplayablearea));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"inplayablearea", &inplayablearea);
	/#
		assert(isscriptfunctionptr(&shouldskipteardown));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldskipteardown", &shouldskipteardown);
	/#
		assert(isscriptfunctionptr(&zombieisthinkdone));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisthinkdone", &zombieisthinkdone);
	/#
		assert(isscriptfunctionptr(&zombieisatgoal));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatgoal", &zombieisatgoal);
	/#
		assert(isscriptfunctionptr(&zombieisatentrance));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatentrance", &zombieisatentrance);
	/#
		assert(isscriptfunctionptr(&zombieshouldmoveawaycondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmoveaway", &zombieshouldmoveawaycondition);
	/#
		assert(isscriptfunctionptr(&waskilledbyteslacondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbytesla", &waskilledbyteslacondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldstun));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
	/#
		assert(isscriptfunctionptr(&zombieisbeinggrappled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisbeinggrappled", &zombieisbeinggrappled);
	/#
		assert(isscriptfunctionptr(&zombieshouldknockdown));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
	/#
		assert(isscriptfunctionptr(&zombieispushed));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieispushed", &zombieispushed);
	/#
		assert(isscriptfunctionptr(&zombiekilledwhilegettingpulled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledwhilegettingpulled", &zombiekilledwhilegettingpulled);
	/#
		assert(isscriptfunctionptr(&zombiekilledbyblackholebombcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledbyblackholebombcondition", &zombiekilledbyblackholebombcondition);
	/#
		assert(isscriptfunctionptr(&function_38fec26f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18fea53546637859", &function_38fec26f);
	/#
		assert(isscriptfunctionptr(&function_e4d7303f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32d8ffc79910d80b", &function_e4d7303f);
	/#
		assert(isscriptfunctionptr(&function_17cd1b17));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1da059a5800a95c5", &function_17cd1b17);
	/#
		assert(isscriptfunctionptr(&disablepowerups));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablepowerups", &disablepowerups);
	/#
		assert(isscriptfunctionptr(&enablepowerups));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablepowerups", &enablepowerups);
	/#
		assert(!isdefined(&zombiemovetoentranceaction) || isscriptfunctionptr(&zombiemovetoentranceaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiemovetoentranceactionterminate) || isscriptfunctionptr(&zombiemovetoentranceactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoentranceaction", &zombiemovetoentranceaction, undefined, &zombiemovetoentranceactionterminate);
	/#
		assert(!isdefined(&zombiemovetoattackspotaction) || isscriptfunctionptr(&zombiemovetoattackspotaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiemovetoattackspotactionterminate) || isscriptfunctionptr(&zombiemovetoattackspotactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoattackspotaction", &zombiemovetoattackspotaction, undefined, &zombiemovetoattackspotactionterminate);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombieidleaction", undefined, undefined, undefined);
	/#
		assert(!isdefined(&zombiemoveaway) || isscriptfunctionptr(&zombiemoveaway));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaway", &zombiemoveaway, undefined, undefined);
	/#
		assert(!isdefined(&zombietraverseaction) || isscriptfunctionptr(&zombietraverseaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombietraverseactionterminate) || isscriptfunctionptr(&zombietraverseactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombietraverseaction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
	/#
		assert(!isdefined(&zombieholdboardaction) || isscriptfunctionptr(&zombieholdboardaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombieholdboardactionterminate) || isscriptfunctionptr(&zombieholdboardactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"holdboardaction", &zombieholdboardaction, undefined, &zombieholdboardactionterminate);
	/#
		assert(!isdefined(&zombiegrabboardaction) || isscriptfunctionptr(&zombiegrabboardaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiegrabboardactionterminate) || isscriptfunctionptr(&zombiegrabboardactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"grabboardaction", &zombiegrabboardaction, undefined, &zombiegrabboardactionterminate);
	/#
		assert(!isdefined(&zombiepullboardaction) || isscriptfunctionptr(&zombiepullboardaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiepullboardactionterminate) || isscriptfunctionptr(&zombiepullboardactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"pullboardaction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
	/#
		assert(!isdefined(&zombieattackthroughboardsaction) || isscriptfunctionptr(&zombieattackthroughboardsaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombieattackthroughboardsactionterminate) || isscriptfunctionptr(&zombieattackthroughboardsactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombieattackthroughboardsaction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
	/#
		assert(!isdefined(&zombietauntaction) || isscriptfunctionptr(&zombietauntaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombietauntactionterminate) || isscriptfunctionptr(&zombietauntactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombietauntaction", &zombietauntaction, undefined, &zombietauntactionterminate);
	/#
		assert(!isdefined(&zombiemantleaction) || isscriptfunctionptr(&zombiemantleaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiemantleactionterminate) || isscriptfunctionptr(&zombiemantleactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemantleaction", &zombiemantleaction, undefined, &zombiemantleactionterminate);
	/#
		assert(!isdefined(&zombiestunactionstart) || isscriptfunctionptr(&zombiestunactionstart));
	#/
	/#
		assert(!isdefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
	#/
	/#
		assert(!isdefined(&zombiestunactionend) || isscriptfunctionptr(&zombiestunactionend));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunaction", &zombiestunactionstart, &function_4e52c07, &zombiestunactionend);
	/#
		assert(isscriptfunctionptr(&zombiestunstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestunstart", &zombiestunstart);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunactionloop", undefined, &function_4e52c07, undefined);
	/#
		assert(isscriptfunctionptr(&function_c377438f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5cae731c54d7a310", &function_c377438f);
	/#
		assert(isscriptfunctionptr(&zombiegrappleactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegrappleactionstart", &zombiegrappleactionstart);
	/#
		assert(isscriptfunctionptr(&zombieknockdownactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
	/#
		assert(isscriptfunctionptr(&function_c8939973));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_c8939973);
	/#
		assert(isscriptfunctionptr(&zombiegetupactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegetupactionterminate", &zombiegetupactionterminate);
	/#
		assert(isscriptfunctionptr(&zombiepushedactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionstart", &zombiepushedactionstart);
	/#
		assert(isscriptfunctionptr(&zombiepushedactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionterminate", &zombiepushedactionterminate);
	/#
		assert(!isdefined(&zombieblackholebombpullstart) || isscriptfunctionptr(&zombieblackholebombpullstart));
	#/
	/#
		assert(!isdefined(&zombieblackholebombpullupdate) || isscriptfunctionptr(&zombieblackholebombpullupdate));
	#/
	/#
		assert(!isdefined(&zombieblackholebombpullend) || isscriptfunctionptr(&zombieblackholebombpullend));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombpullaction", &zombieblackholebombpullstart, &zombieblackholebombpullupdate, &zombieblackholebombpullend);
	/#
		assert(!isdefined(&zombiekilledbyblackholebombstart) || isscriptfunctionptr(&zombiekilledbyblackholebombstart));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiekilledbyblackholebombend) || isscriptfunctionptr(&zombiekilledbyblackholebombend));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombdeathaction", &zombiekilledbyblackholebombstart, undefined, &zombiekilledbyblackholebombend);
	/#
		assert(isscriptfunctionptr(&function_b654f4f5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2574c98f8c8e07ea", &function_b654f4f5);
	/#
		assert(isscriptfunctionptr(&function_36b3cb7d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65c425729831f505", &function_36b3cb7d);
	/#
		assert(isscriptfunctionptr(&getchunkservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"getchunkservice", &getchunkservice);
	/#
		assert(isscriptfunctionptr(&updatechunkservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatechunkservice", &updatechunkservice);
	/#
		assert(isscriptfunctionptr(&updateattackspotservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"updateattackspotservice", &updateattackspotservice);
	/#
		assert(isscriptfunctionptr(&findnodesservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"findnodesservice", &findnodesservice);
	/#
		assert(isscriptfunctionptr(&zombieattackableobjectservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackableobjectservice", &zombieattackableobjectservice);
	/#
		assert(isscriptfunctionptr(&function_fb814207));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiefindfleshservice", &function_fb814207, 2);
	/#
		assert(isscriptfunctionptr(&function_f637b05d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_712f0844b14c72fe", &function_f637b05d, 1);
	/#
		assert(isscriptfunctionptr(&zombieenteredplayable));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieenteredplayableservice", &zombieenteredplayable);
	animationstatenetwork::registeranimationmocomp("mocomp_board_tear@zombie", &boardtearmocompstart, &boardtearmocompupdate, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter@zombie", &barricadeentermocompstart, &barricadeentermocompupdate, &barricadeentermocompterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter_no_z@zombie", &barricadeentermocompnozstart, &barricadeentermocompnozupdate, &barricadeentermocompnozterminate);
	animationstatenetwork::registernotetrackhandlerfunction("destroy_piece", &notetrackboardtear);
	animationstatenetwork::registernotetrackhandlerfunction("zombie_window_melee", &notetrackboardmelee);
	animationstatenetwork::registernotetrackhandlerfunction("smash_board", &function_b37b8c0d);
	animationstatenetwork::registernotetrackhandlerfunction("bhb_burst", &zombiebhbburst);
	animationstatenetwork::registernotetrackhandlerfunction("freezegun_hide", &function_36b3cb7d);
	setdvar(#"scr_zm_use_code_enemy_selection", 0);
}

/*
	Name: function_fb814207
	Namespace: zm_behavior
	Checksum: 0x1D602C1
	Offset: 0x2D98
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_fb814207(behaviortreeentity)
{
	if(isdefined(self.var_72411ccf))
	{
		self [[self.var_72411ccf]](self);
	}
	else
	{
		self zombiefindflesh(self);
	}
}

/*
	Name: zombiefindflesh
	Namespace: zm_behavior
	Checksum: 0x93E6B778
	Offset: 0x2DE8
	Size: 0x984
	Parameters: 1
	Flags: Linked
*/
function zombiefindflesh(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enablepushtime))
	{
		if(gettime() >= behaviortreeentity.enablepushtime)
		{
			behaviortreeentity collidewithactors(1);
			behaviortreeentity.enablepushtime = undefined;
		}
	}
	if(getdvarint(#"scr_zm_use_code_enemy_selection", 0))
	{
		zombiefindfleshcode(behaviortreeentity);
		return;
	}
	if(level.intermission)
	{
		return;
	}
	if(isdefined(behaviortreeentity.var_67faa700) && behaviortreeentity.var_67faa700)
	{
		return;
	}
	if(behaviortreeentity getpathmode() == "dont move")
	{
		return;
	}
	behaviortreeentity.ignore_player = [];
	behaviortreeentity.goalradius = 30;
	if(isdefined(behaviortreeentity.ignore_find_flesh) && behaviortreeentity.ignore_find_flesh)
	{
		return;
	}
	if(behaviortreeentity.team == #"allies")
	{
		behaviortreeentity findzombieenemy();
		return;
	}
	if(zombieshouldmoveawaycondition(behaviortreeentity))
	{
		return;
	}
	zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
	behaviortreeentity.zombie_poi = zombie_poi;
	if(isdefined(zombie_poi) && isdefined(level.var_4e4950d1))
	{
		if(![[level.var_4e4950d1]](behaviortreeentity.zombie_poi))
		{
			behaviortreeentity.zombie_poi = undefined;
		}
	}
	players = getplayers();
	if(!isdefined(behaviortreeentity.ignore_player) || players.size == 1)
	{
		behaviortreeentity.ignore_player = [];
	}
	else if(!isdefined(level._should_skip_ignore_player_logic) || ![[level._should_skip_ignore_player_logic]]())
	{
		i = 0;
		while(i < behaviortreeentity.ignore_player.size)
		{
			if(isdefined(behaviortreeentity.ignore_player[i]) && isdefined(behaviortreeentity.ignore_player[i].ignore_counter) && behaviortreeentity.ignore_player[i].ignore_counter > 3)
			{
				behaviortreeentity.ignore_player[i].ignore_counter = 0;
				behaviortreeentity.ignore_player = arrayremovevalue(behaviortreeentity.ignore_player, behaviortreeentity.ignore_player[i]);
				if(!isdefined(behaviortreeentity.ignore_player))
				{
					behaviortreeentity.ignore_player = [];
				}
				i = 0;
				continue;
			}
			i++;
		}
	}
	behaviortreeentity zombie_utility::run_ignore_player_handler();
	designated_target = 0;
	if(isdefined(behaviortreeentity.var_93a62fe) && (isdefined(behaviortreeentity.var_93a62fe.b_is_designated_target) && behaviortreeentity.var_93a62fe.b_is_designated_target))
	{
		designated_target = 1;
	}
	if(!isdefined(behaviortreeentity.var_93a62fe) && !isdefined(zombie_poi) && !isdefined(behaviortreeentity.attackable))
	{
		if(isdefined(behaviortreeentity.ignore_player))
		{
			if(isdefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]())
			{
				return;
			}
			behaviortreeentity.ignore_player = [];
		}
		/#
			if(isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet)
			{
				return;
			}
		#/
		if(isdefined(level.no_target_override))
		{
			[[level.no_target_override]](behaviortreeentity);
		}
		else
		{
			behaviortreeentity setgoal(behaviortreeentity.origin);
		}
		return;
	}
	if(isdefined(level.var_d22435d9))
	{
		[[level.var_d22435d9]](behaviortreeentity);
	}
	if(!isdefined(level.check_for_alternate_poi) || ![[level.check_for_alternate_poi]]())
	{
		behaviortreeentity.enemyoverride = behaviortreeentity.zombie_poi;
		behaviortreeentity.favoriteenemy = behaviortreeentity.var_93a62fe;
	}
	if(isdefined(behaviortreeentity.v_zombie_custom_goal_pos))
	{
		goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
		if(isdefined(behaviortreeentity.n_zombie_custom_goal_radius))
		{
			behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
		}
		behaviortreeentity setgoal(goalpos);
	}
	else
	{
		if(isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1]))
		{
			behaviortreeentity.has_exit_point = undefined;
			goalpos = behaviortreeentity.enemyoverride[0];
			if(!isdefined(zombie_poi))
			{
				aiprofile_beginentry("zombiefindflesh-enemyoverride");
				queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
				aiprofile_endentry();
				foreach(point in queryresult.data)
				{
					goalpos = point.origin;
					break;
				}
			}
			behaviortreeentity setgoal(goalpos);
		}
		else
		{
			if(isdefined(behaviortreeentity.attackable) && !designated_target)
			{
				if(isdefined(behaviortreeentity.attackable_slot))
				{
					if(isdefined(behaviortreeentity.attackable_goal_radius))
					{
						behaviortreeentity.goalradius = behaviortreeentity.attackable_goal_radius;
					}
					nav_mesh = getclosestpointonnavmesh(behaviortreeentity.attackable_slot.origin, 64);
					if(isdefined(nav_mesh))
					{
						behaviortreeentity setgoal(nav_mesh);
					}
					else
					{
						behaviortreeentity setgoal(behaviortreeentity.attackable_slot.origin);
					}
				}
			}
			else if(isdefined(behaviortreeentity.favoriteenemy))
			{
				behaviortreeentity.has_exit_point = undefined;
				behaviortreeentity val::reset(#"attack_properties", "ignoreall");
				if(isdefined(level.enemy_location_override_func))
				{
					goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.favoriteenemy);
					if(isdefined(goalpos))
					{
						behaviortreeentity setgoal(goalpos);
					}
					else
					{
						behaviortreeentity zombieupdategoal();
					}
				}
				else
				{
					if(isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test)
					{
					}
					else
					{
						if(zombieshouldmoveawaycondition(behaviortreeentity))
						{
						}
						else
						{
							behaviortreeentity zombieupdategoal();
						}
					}
				}
			}
		}
	}
	if(players.size > 1)
	{
		for(i = 0; i < behaviortreeentity.ignore_player.size; i++)
		{
			if(isdefined(behaviortreeentity.ignore_player[i]))
			{
				if(!isdefined(behaviortreeentity.ignore_player[i].ignore_counter))
				{
					behaviortreeentity.ignore_player[i].ignore_counter = 0;
					continue;
				}
				behaviortreeentity.ignore_player[i].ignore_counter = behaviortreeentity.ignore_player[i].ignore_counter + 1;
			}
		}
	}
}

/*
	Name: function_f637b05d
	Namespace: zm_behavior
	Checksum: 0x380CDA4B
	Offset: 0x3778
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_f637b05d(behaviortreeentity)
{
	behaviortreeentity.var_93a62fe = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
}

/*
	Name: zombiefindfleshcode
	Namespace: zm_behavior
	Checksum: 0x817E3CAF
	Offset: 0x37C0
	Size: 0x414
	Parameters: 1
	Flags: Linked
*/
function zombiefindfleshcode(behaviortreeentity)
{
	aiprofile_beginentry("zombieFindFleshCode");
	if(level.intermission)
	{
		aiprofile_endentry();
		return;
	}
	behaviortreeentity.ignore_player = [];
	behaviortreeentity.goalradius = 30;
	if(behaviortreeentity.team == #"allies")
	{
		behaviortreeentity findzombieenemy();
		aiprofile_endentry();
		return;
	}
	if(level.wait_and_revive)
	{
		aiprofile_endentry();
		return;
	}
	if(level.zombie_poi_array.size > 0)
	{
		zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
	}
	behaviortreeentity zombie_utility::run_ignore_player_handler();
	zm_utility::update_valid_players(behaviortreeentity.origin, behaviortreeentity.ignore_player);
	if(!isdefined(behaviortreeentity.enemy) && !isdefined(zombie_poi))
	{
		/#
			if(isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet)
			{
				aiprofile_endentry();
				return;
			}
		#/
		if(isdefined(level.no_target_override))
		{
			[[level.no_target_override]](behaviortreeentity);
		}
		else
		{
			behaviortreeentity setgoal(behaviortreeentity.origin);
		}
		aiprofile_endentry();
		return;
	}
	behaviortreeentity.enemyoverride = zombie_poi;
	if(isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1]))
	{
		behaviortreeentity.has_exit_point = undefined;
		goalpos = behaviortreeentity.enemyoverride[0];
		queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
		foreach(point in queryresult.data)
		{
			goalpos = point.origin;
			break;
		}
		behaviortreeentity setgoal(goalpos);
	}
	else if(isdefined(behaviortreeentity.enemy))
	{
		behaviortreeentity.has_exit_point = undefined;
		/#
			if(isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test)
			{
				aiprofile_endentry();
				return;
			}
		#/
		if(isdefined(level.enemy_location_override_func))
		{
			goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.enemy);
			if(isdefined(goalpos))
			{
				behaviortreeentity setgoal(goalpos);
			}
			else
			{
				behaviortreeentity zombieupdategoalcode();
			}
		}
		else if(isdefined(behaviortreeentity.enemy.last_valid_position))
		{
			behaviortreeentity zombieupdategoalcode();
		}
	}
	aiprofile_endentry();
}

/*
	Name: zombieupdategoal
	Namespace: zm_behavior
	Checksum: 0xF988CC1C
	Offset: 0x3BE0
	Size: 0xA7C
	Parameters: 0
	Flags: Linked
*/
function zombieupdategoal()
{
	aiprofile_beginentry("zombieUpdateGoal");
	shouldrepath = 0;
	zigzag_activation_distance = level.zigzag_activation_distance;
	if(isdefined(self.zigzag_activation_distance))
	{
		zigzag_activation_distance = self.zigzag_activation_distance;
	}
	if(!shouldrepath && isdefined(self.favoriteenemy))
	{
		pathgoalpos = self.pathgoalpos;
		if(!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime())
		{
			shouldrepath = 1;
		}
		else
		{
			if(distancesquared(self.origin, self.favoriteenemy.origin) <= (zigzag_activation_distance * zigzag_activation_distance))
			{
				shouldrepath = 1;
			}
			else if(isdefined(pathgoalpos))
			{
				distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
				shouldrepath = distancetogoalsqr < (72 * 72);
			}
		}
	}
	if(isdefined(level.validate_on_navmesh) && level.validate_on_navmesh)
	{
		if(!ispointonnavmesh(self.origin, self))
		{
			shouldrepath = 0;
		}
	}
	if(isdefined(self.keep_moving) && self.keep_moving)
	{
		if(gettime() > self.keep_moving_time)
		{
			self.keep_moving = 0;
		}
	}
	if(self function_dd070839())
	{
		shouldrepath = 0;
	}
	if(isactor(self) && self asmistransitionrunning() || self asmistransdecrunning())
	{
		shouldrepath = 0;
	}
	if(shouldrepath)
	{
		if(isplayer(self.favoriteenemy))
		{
			goalent = zm_ai_utility::function_a2e8fd7b(self, self.favoriteenemy);
			if(isdefined(goalent.last_valid_position))
			{
				goalpos = getclosestpointonnavmesh(goalent.last_valid_position, 64, self getpathfindingradius());
				if(!isdefined(goalpos))
				{
					goalpos = goalent.origin;
				}
			}
			else
			{
				goalpos = goalent.origin;
			}
		}
		else
		{
			goalpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, self getpathfindingradius());
			if(!isdefined(goalpos) && self.favoriteenemy function_dd070839() && isdefined(self.favoriteenemy.traversestartnode))
			{
				goalpos = self.favoriteenemy.traversestartnode.origin;
			}
			if(!isdefined(goalpos))
			{
				goalpos = self.origin;
			}
		}
		self setgoal(goalpos);
		should_zigzag = 1;
		if(isdefined(level.should_zigzag))
		{
			should_zigzag = self [[level.should_zigzag]]();
		}
		else if(isdefined(self.should_zigzag))
		{
			should_zigzag = self.should_zigzag;
		}
		if(isdefined(self.var_592a8227))
		{
			should_zigzag = should_zigzag && self.var_592a8227;
		}
		var_eb1c6f1c = 0;
		if(isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag)
		{
			if(distancesquared(self.origin, goalpos) > zigzag_activation_distance * zigzag_activation_distance)
			{
				self.keep_moving = 1;
				self.keep_moving_time = gettime() + 700;
				path = undefined;
				if(isdefined(self.var_ceed8829) && self.var_ceed8829)
				{
					pathdata = generatenavmeshpath(self.origin, goalpos, self);
					if(isdefined(pathdata) && pathdata.status === "succeeded" && isdefined(pathdata.pathpoints))
					{
						path = pathdata.pathpoints;
					}
				}
				else
				{
					path = self calcapproximatepathtoposition(goalpos, 0);
				}
				if(isdefined(path))
				{
					/#
						if(getdvarint(#"ai_debugzigzag", 0))
						{
							for(index = 1; index < path.size; index++)
							{
								recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
								record3dtext(abs((path[index - 1][2]) - path[index][2]), path[index - 1], (1, 0, 0));
							}
						}
					#/
					deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);
					if(isdefined(self.zigzag_distance_min) && isdefined(self.zigzag_distance_max))
					{
						deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
					}
					segmentlength = 0;
					for(index = 1; index < path.size; index++)
					{
						if(isdefined(level.var_562c8f67) && (abs((path[index - 1][2]) - path[index][2])) > level.var_562c8f67)
						{
							break;
						}
						currentseglength = distance(path[index - 1], path[index]);
						var_570a7c72 = (segmentlength + currentseglength) > deviationdistance;
						if(index == (path.size - 1) && !var_570a7c72)
						{
							deviationdistance = (segmentlength + currentseglength) - 1;
							var_eb1c6f1c = 1;
						}
						if(var_570a7c72 || var_eb1c6f1c)
						{
							remaininglength = deviationdistance - segmentlength;
							seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
							/#
								recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
							#/
							innerzigzagradius = level.inner_zigzag_radius;
							if(var_eb1c6f1c)
							{
								innerzigzagradius = 0;
							}
							else if(isdefined(self.inner_zigzag_radius))
							{
								innerzigzagradius = self.inner_zigzag_radius;
							}
							outerzigzagradius = level.outer_zigzag_radius;
							if(var_eb1c6f1c)
							{
								outerzigzagradius = 48;
							}
							else if(isdefined(self.outer_zigzag_radius))
							{
								outerzigzagradius = self.outer_zigzag_radius;
							}
							queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
							positionquery_filter_inclaimedlocation(queryresult, self);
							if(queryresult.data.size > 0)
							{
								a_data = array::randomize(queryresult.data);
								for(i = 0; i < a_data.size; i++)
								{
									point = a_data[i];
									n_z_diff = seedposition[2] - point.origin[2];
									if(abs(n_z_diff) < 32)
									{
										self setgoal(point.origin);
										break;
									}
								}
							}
							break;
						}
						segmentlength = segmentlength + currentseglength;
					}
				}
			}
		}
		self.nextgoalupdate = gettime() + randomintrange(500, 1000);
	}
	aiprofile_endentry();
}

/*
	Name: zombieupdategoalcode
	Namespace: zm_behavior
	Checksum: 0x99094798
	Offset: 0x4668
	Size: 0x56C
	Parameters: 0
	Flags: Linked
*/
function zombieupdategoalcode()
{
	aiprofile_beginentry("zombieUpdateGoalCode");
	shouldrepath = 0;
	if(!shouldrepath && isdefined(self.enemy))
	{
		if(!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime())
		{
			shouldrepath = 1;
		}
		else
		{
			if(distancesquared(self.origin, self.enemy.origin) <= (200 * 200))
			{
				shouldrepath = 1;
			}
			else if(isdefined(self.pathgoalpos))
			{
				distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
				shouldrepath = distancetogoalsqr < (72 * 72);
			}
		}
	}
	if(isdefined(self.keep_moving) && self.keep_moving)
	{
		if(gettime() > self.keep_moving_time)
		{
			self.keep_moving = 0;
		}
	}
	if(shouldrepath)
	{
		goalpos = self.enemy.origin;
		if(isdefined(self.enemy.last_valid_position))
		{
			var_2a741504 = getclosestpointonnavmesh(self.enemy.last_valid_position, 64, 16);
			if(isdefined(var_2a741504))
			{
				goalpos = var_2a741504;
			}
		}
		if(isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path)
		{
			if(distancesquared(self.origin, goalpos) > 240 * 240)
			{
				self.keep_moving = 1;
				self.keep_moving_time = gettime() + 250;
				path = self calcapproximatepathtoposition(goalpos, 0);
				/#
					if(getdvarint(#"ai_debugzigzag", 0))
					{
						for(index = 1; index < path.size; index++)
						{
							recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
						}
					}
				#/
				deviationdistance = randomintrange(240, 480);
				segmentlength = 0;
				for(index = 1; index < path.size; index++)
				{
					currentseglength = distance(path[index - 1], path[index]);
					if(segmentlength + currentseglength > deviationdistance)
					{
						remaininglength = deviationdistance - segmentlength;
						seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
						/#
							recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
						#/
						innerzigzagradius = level.inner_zigzag_radius;
						outerzigzagradius = level.outer_zigzag_radius;
						queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
						positionquery_filter_inclaimedlocation(queryresult, self);
						if(queryresult.data.size > 0)
						{
							point = queryresult.data[randomint(queryresult.data.size)];
							if(tracepassedonnavmesh(seedposition, point.origin, 16))
							{
								goalpos = point.origin;
							}
						}
						break;
					}
					segmentlength = segmentlength + currentseglength;
				}
			}
		}
		self setgoal(goalpos);
		self.nextgoalupdate = gettime() + randomintrange(500, 1000);
	}
	aiprofile_endentry();
}

/*
	Name: zombieenteredplayable
	Namespace: zm_behavior
	Checksum: 0xCB0435D0
	Offset: 0x4BE0
	Size: 0x1F0
	Parameters: 1
	Flags: Linked
*/
function zombieenteredplayable(behaviortreeentity)
{
	if(!isdefined(level.playable_areas))
	{
		level.playable_areas = getentarray("player_volume", "script_noteworthy");
	}
	if(zm_utility::function_21f4ac36())
	{
		if(!isdefined(level.var_a2a9b2de))
		{
			level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
		}
		node = function_52c1730(behaviortreeentity.origin, level.var_a2a9b2de, 500);
		if(isdefined(node))
		{
			if(isdefined(behaviortreeentity.var_ee833cd6))
			{
				behaviortreeentity [[behaviortreeentity.var_ee833cd6]]();
			}
			else
			{
				behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
			}
			return true;
		}
	}
	if(zm_utility::function_c85ebbbc())
	{
		foreach(area in level.playable_areas)
		{
			if(behaviortreeentity istouching(area))
			{
				if(isdefined(behaviortreeentity.var_ee833cd6))
				{
					behaviortreeentity [[behaviortreeentity.var_ee833cd6]]();
				}
				else
				{
					behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
				}
				return true;
			}
		}
	}
	return false;
}

/*
	Name: shouldmovecondition
	Namespace: zm_behavior
	Checksum: 0x603AA54D
	Offset: 0x4DD8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function shouldmovecondition(behaviortreeentity)
{
	if(behaviortreeentity haspath())
	{
		return true;
	}
	if(isdefined(behaviortreeentity.keep_moving) && behaviortreeentity.keep_moving)
	{
		return true;
	}
	return false;
}

/*
	Name: zombieshouldmoveawaycondition
	Namespace: zm_behavior
	Checksum: 0xD86948F7
	Offset: 0x4E38
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function zombieshouldmoveawaycondition(behaviortreeentity)
{
	return level.wait_and_revive;
}

/*
	Name: waskilledbyteslacondition
	Namespace: zm_behavior
	Checksum: 0x730745F4
	Offset: 0x4E58
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function waskilledbyteslacondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death)
	{
		return true;
	}
	return false;
}

/*
	Name: disablepowerups
	Namespace: zm_behavior
	Checksum: 0x8794878B
	Offset: 0x4E98
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function disablepowerups(behaviortreeentity)
{
	behaviortreeentity.no_powerups = 1;
}

/*
	Name: enablepowerups
	Namespace: zm_behavior
	Checksum: 0x80257A85
	Offset: 0x4EC0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function enablepowerups(behaviortreeentity)
{
	behaviortreeentity.no_powerups = 0;
}

/*
	Name: zombiemoveaway
	Namespace: zm_behavior
	Checksum: 0x7F743DEE
	Offset: 0x4EE8
	Size: 0x2F0
	Parameters: 2
	Flags: Linked
*/
function zombiemoveaway(behaviortreeentity, asmstatename)
{
	player = util::gethostplayer();
	if(!isdefined(player))
	{
		return 5;
	}
	queryresult = level.move_away_points;
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	if(!isdefined(queryresult))
	{
		return 5;
	}
	self.keep_moving = 0;
	for(i = 0; i < queryresult.data.size; i++)
	{
		if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin))
		{
			continue;
		}
		isbehind = vectordot(player.origin - behaviortreeentity.origin, queryresult.data[i].origin - behaviortreeentity.origin);
		if(isbehind < 0)
		{
			behaviortreeentity setgoal(queryresult.data[i].origin);
			arrayremoveindex(level.move_away_points.data, i, 0);
			i--;
			return 5;
		}
	}
	for(i = 0; i < queryresult.data.size; i++)
	{
		if(!zm_utility::check_point_in_playable_area(queryresult.data[i].origin))
		{
			continue;
		}
		dist_zombie = distancesquared(queryresult.data[i].origin, behaviortreeentity.origin);
		dist_player = distancesquared(queryresult.data[i].origin, player.origin);
		if(dist_zombie < dist_player)
		{
			behaviortreeentity setgoal(queryresult.data[i].origin);
			arrayremoveindex(level.move_away_points.data, i, 0);
			i--;
			return 5;
		}
	}
	self zm::default_find_exit_point();
	return 5;
}

/*
	Name: zombieisbeinggrappled
	Namespace: zm_behavior
	Checksum: 0xA7D01E30
	Offset: 0x51E0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombieisbeinggrappled(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.grapple_is_fatal) && behaviortreeentity.grapple_is_fatal)
	{
		return true;
	}
	return false;
}

/*
	Name: zombieshouldknockdown
	Namespace: zm_behavior
	Checksum: 0x99327F5B
	Offset: 0x5220
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombieshouldknockdown(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown)
	{
		return true;
	}
	return false;
}

/*
	Name: zombieispushed
	Namespace: zm_behavior
	Checksum: 0xE554FBA1
	Offset: 0x5260
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombieispushed(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.pushed) && behaviortreeentity.pushed)
	{
		return true;
	}
	return false;
}

/*
	Name: zombiegrappleactionstart
	Namespace: zm_behavior
	Checksum: 0xDDF84ADC
	Offset: 0x52A0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombiegrappleactionstart(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_grapple_direction", self.grapple_direction);
}

/*
	Name: zombieknockdownactionstart
	Namespace: zm_behavior
	Checksum: 0xA5A4FD52
	Offset: 0x52E0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function zombieknockdownactionstart(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
	behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
	behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
	behaviortreeentity collidewithactors(0);
	behaviortreeentity.blockingpain = 1;
}

/*
	Name: function_c8939973
	Namespace: zm_behavior
	Checksum: 0xB7357207
	Offset: 0x5398
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c8939973(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)
	{
		behaviortreeentity.knockdown = 0;
		behaviortreeentity collidewithactors(1);
	}
}

/*
	Name: zombiegetupactionterminate
	Namespace: zm_behavior
	Checksum: 0x76B143E
	Offset: 0x53F8
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private zombiegetupactionterminate(behaviortreeentity)
{
	behaviortreeentity.knockdown = 0;
	behaviortreeentity collidewithactors(1);
}

/*
	Name: zombiepushedactionstart
	Namespace: zm_behavior
	Checksum: 0xD6B0DD26
	Offset: 0x5438
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private zombiepushedactionstart(behaviortreeentity)
{
	behaviortreeentity collidewithactors(0);
	behaviortreeentity setblackboardattribute("_push_direction", behaviortreeentity.push_direction);
}

/*
	Name: zombiepushedactionterminate
	Namespace: zm_behavior
	Checksum: 0xE882003
	Offset: 0x5490
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private zombiepushedactionterminate(behaviortreeentity)
{
	behaviortreeentity collidewithactors(1);
	behaviortreeentity.pushed = 0;
}

/*
	Name: zombieshouldstun
	Namespace: zm_behavior
	Checksum: 0x3533EFFA
	Offset: 0x54D0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function zombieshouldstun(behaviortreeentity)
{
	if(behaviortreeentity ai::is_stunned() && (!(isdefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death)))
	{
		return true;
	}
	return false;
}

/*
	Name: zombiestunstart
	Namespace: zm_behavior
	Checksum: 0x98D04779
	Offset: 0x5530
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function zombiestunstart(behaviortreeentity)
{
	behaviortreeentity pathmode("dont move", 1);
	callback::callback(#"hash_1eda827ff5e6895b");
}

/*
	Name: function_c377438f
	Namespace: zm_behavior
	Checksum: 0x75E320F0
	Offset: 0x5588
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_c377438f(behaviortreeentity)
{
	behaviortreeentity pathmode("move allowed");
	callback::callback(#"hash_210adcf09e99fba1");
}

/*
	Name: zombiestunactionstart
	Namespace: zm_behavior
	Checksum: 0x608620C9
	Offset: 0x55E0
	Size: 0x48
	Parameters: 2
	Flags: Linked
*/
function zombiestunactionstart(behaviortreeentity, asmstatename)
{
	zombiestunstart(behaviortreeentity);
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: function_4e52c07
	Namespace: zm_behavior
	Checksum: 0x54C879A4
	Offset: 0x5630
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function function_4e52c07(behaviortreeentity, asmstatename)
{
	if(behaviortreeentity ai::is_stunned())
	{
		return 5;
	}
	return 4;
}

/*
	Name: zombiestunactionend
	Namespace: zm_behavior
	Checksum: 0x5011B47B
	Offset: 0x5670
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function zombiestunactionend(behaviortreeentity, asmstatename)
{
	function_c377438f(behaviortreeentity);
	return 4;
}

/*
	Name: zombietraverseaction
	Namespace: zm_behavior
	Checksum: 0x48280388
	Offset: 0x56A8
	Size: 0xB8
	Parameters: 2
	Flags: Linked
*/
function zombietraverseaction(behaviortreeentity, asmstatename)
{
	aiutility::traverseactionstart(behaviortreeentity, asmstatename);
	behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
	disablepowerups(behaviortreeentity);
	behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
	behaviortreeentity pushplayer(1);
	behaviortreeentity callback::callback(#"hash_1518febf00439d5");
	return 5;
}

/*
	Name: zombietraverseactionterminate
	Namespace: zm_behavior
	Checksum: 0x27BA3F59
	Offset: 0x5768
	Size: 0x110
	Parameters: 2
	Flags: Linked
*/
function zombietraverseactionterminate(behaviortreeentity, asmstatename)
{
	aiutility::wpn_debug_bot_joinleave(behaviortreeentity, asmstatename);
	if(behaviortreeentity asmgetstatus() == "asm_status_complete")
	{
		behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;
		if(!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs))
		{
			behaviortreeentity collidewithactors(0);
			behaviortreeentity.enablepushtime = gettime() + 1000;
		}
		if(isdefined(behaviortreeentity.var_9ed3cc11))
		{
			behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
			behaviortreeentity.var_9ed3cc11 = undefined;
		}
	}
	behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
	return 4;
}

/*
	Name: zombiegottoentrancecondition
	Namespace: zm_behavior
	Checksum: 0xD276524F
	Offset: 0x5880
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombiegottoentrancecondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.got_to_entrance) && behaviortreeentity.got_to_entrance)
	{
		return true;
	}
	return false;
}

/*
	Name: zombiegottoattackspotcondition
	Namespace: zm_behavior
	Checksum: 0x302DEC2
	Offset: 0x58C0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombiegottoattackspotcondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot)
	{
		return true;
	}
	return false;
}

/*
	Name: zombiehasattackspotalreadycondition
	Namespace: zm_behavior
	Checksum: 0x89AA5DC3
	Offset: 0x5900
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function zombiehasattackspotalreadycondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0)
	{
		return true;
	}
	return false;
}

/*
	Name: zombieshouldtearcondition
	Namespace: zm_behavior
	Checksum: 0xBD95E5CF
	Offset: 0x5940
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function zombieshouldtearcondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.first_node))
	{
		if(isdefined(behaviortreeentity.first_node.zbarrier))
		{
			if(isdefined(behaviortreeentity.first_node.barrier_chunks))
			{
				if(!zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks))
				{
					return true;
				}
			}
		}
	}
	return false;
}

/*
	Name: zombieshouldattackthroughboardscondition
	Namespace: zm_behavior
	Checksum: 0x1F724AD
	Offset: 0x59D0
	Size: 0x2C2
	Parameters: 1
	Flags: Linked
*/
function zombieshouldattackthroughboardscondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)
	{
		return false;
	}
	if(isdefined(behaviortreeentity.first_node.zbarrier))
	{
		if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombiereachthroughattacks())
		{
			chunks = undefined;
			if(isdefined(behaviortreeentity.first_node))
			{
				chunks = zm_utility::get_non_destroyed_chunks(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
			}
			if(isdefined(chunks) && chunks.size > 0)
			{
				return false;
			}
		}
	}
	if(getdvarstring(#"zombie_reachin_freq") == "")
	{
		setdvar(#"zombie_reachin_freq", 50);
	}
	freq = getdvarint(#"zombie_reachin_freq", 0);
	players = getplayers();
	attack = 0;
	behaviortreeentity.player_targets = [];
	for(i = 0; i < players.size; i++)
	{
		if(isalive(players[i]) && !isdefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && (!(isdefined(players[i].ignoreme) && players[i].ignoreme)))
		{
			behaviortreeentity.player_targets[behaviortreeentity.player_targets.size] = players[i];
			attack = 1;
		}
	}
	if(!attack || freq < randomint(100))
	{
		return false;
	}
	return true;
}

/*
	Name: zombieshouldtauntcondition
	Namespace: zm_behavior
	Checksum: 0xCC6BF536
	Offset: 0x5CA0
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function zombieshouldtauntcondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)
	{
		return false;
	}
	if(!isdefined(behaviortreeentity.first_node.zbarrier))
	{
		return false;
	}
	if(!behaviortreeentity.first_node.zbarrier zbarriersupportszombietaunts())
	{
		return false;
	}
	if(getdvarstring(#"zombie_taunt_freq") == "")
	{
		setdvar(#"zombie_taunt_freq", 5);
	}
	freq = getdvarint(#"zombie_taunt_freq", 0);
	if(freq >= randomint(100))
	{
		return true;
	}
	return false;
}

/*
	Name: zombieshouldenterplayablecondition
	Namespace: zm_behavior
	Checksum: 0xE9435E0A
	Offset: 0x5DC0
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function zombieshouldenterplayablecondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.first_node) && isdefined(behaviortreeentity.first_node.barrier_chunks))
	{
		if(zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks))
		{
			if(!isdefined(behaviortreeentity.attacking_spot) || (isdefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) && (!(isdefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area)))
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: ischunkvalidcondition
	Namespace: zm_behavior
	Checksum: 0x29C5DACA
	Offset: 0x5E98
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function ischunkvalidcondition(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.chunk))
	{
		return true;
	}
	return false;
}

/*
	Name: inplayablearea
	Namespace: zm_behavior
	Checksum: 0xC2D34A1F
	Offset: 0x5EC8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function inplayablearea(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area)
	{
		return true;
	}
	return false;
}

/*
	Name: shouldskipteardown
	Namespace: zm_behavior
	Checksum: 0x756B5453
	Offset: 0x5F08
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function shouldskipteardown(behaviortreeentity)
{
	if(behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string))
	{
		return true;
	}
	return false;
}

/*
	Name: zombieisthinkdone
	Namespace: zm_behavior
	Checksum: 0xDC54C89F
	Offset: 0x5F48
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function zombieisthinkdone(behaviortreeentity)
{
	/#
		if(isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test)
		{
			return false;
		}
	#/
	if(isdefined(behaviortreeentity.zombie_think_done) && behaviortreeentity.zombie_think_done)
	{
		return true;
	}
	return false;
}

/*
	Name: zombieisatgoal
	Namespace: zm_behavior
	Checksum: 0x8A2643B
	Offset: 0x5FB0
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function zombieisatgoal(behaviortreeentity)
{
	var_1f2328d0 = behaviortreeentity function_4794d6a3();
	isatscriptgoal = isdefined(var_1f2328d0.var_9e404264) && var_1f2328d0.var_9e404264;
	if(isdefined(level.var_21326085) && level.var_21326085)
	{
		if(!isatscriptgoal && isdefined(var_1f2328d0.overridegoalpos))
		{
			if(abs(var_1f2328d0.overridegoalpos[2] - behaviortreeentity.origin[2]) < 12)
			{
				dist = distance2dsquared(var_1f2328d0.overridegoalpos, behaviortreeentity.origin);
				if(dist < 144)
				{
					return 1;
				}
			}
		}
	}
	return isatscriptgoal;
}

/*
	Name: zombieisatentrance
	Namespace: zm_behavior
	Checksum: 0xDCB1E405
	Offset: 0x60D8
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function zombieisatentrance(behaviortreeentity)
{
	var_1f2328d0 = behaviortreeentity function_4794d6a3();
	isatscriptgoal = isdefined(var_1f2328d0.var_9e404264) && var_1f2328d0.var_9e404264;
	isatentrance = isdefined(behaviortreeentity.first_node) && isatscriptgoal;
	return isatentrance;
}

/*
	Name: getchunkservice
	Namespace: zm_behavior
	Checksum: 0x935F197A
	Offset: 0x6160
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function getchunkservice(behaviortreeentity)
{
	behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
	if(isdefined(behaviortreeentity.chunk))
	{
		behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
		behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
	}
}

/*
	Name: updatechunkservice
	Namespace: zm_behavior
	Checksum: 0xD0B3FEF0
	Offset: 0x6248
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function updatechunkservice(behaviortreeentity)
{
	while(0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk])
	{
		behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
	}
	behaviortreeentity.lastchunk_destroy_time = gettime();
}

/*
	Name: updateattackspotservice
	Namespace: zm_behavior
	Checksum: 0xE51437EA
	Offset: 0x62C8
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function updateattackspotservice(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.marked_for_death) && behaviortreeentity.marked_for_death || behaviortreeentity.health < 0)
	{
		return false;
	}
	if(!isdefined(behaviortreeentity.attacking_spot))
	{
		if(!behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node))
		{
			return false;
		}
	}
	if(isdefined(behaviortreeentity.attacking_spot))
	{
		behaviortreeentity.goalradius = 12;
		behaviortreeentity function_a57c34b7(behaviortreeentity.attacking_spot);
		if(zombieisatgoal(behaviortreeentity))
		{
			behaviortreeentity.at_entrance_tear_spot = 1;
		}
		return true;
	}
	return false;
}

/*
	Name: findnodesservice
	Namespace: zm_behavior
	Checksum: 0xB7C7A60
	Offset: 0x63C0
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function findnodesservice(behaviortreeentity)
{
	node = undefined;
	behaviortreeentity.entrance_nodes = [];
	if(isdefined(behaviortreeentity.find_flesh_struct_string))
	{
		if(behaviortreeentity.find_flesh_struct_string == "find_flesh")
		{
			return false;
		}
		for(i = 0; i < level.exterior_goals.size; i++)
		{
			if(isdefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == behaviortreeentity.find_flesh_struct_string)
			{
				node = level.exterior_goals[i];
				break;
			}
		}
		for(i = 0; i < level.barrier_align.size; i++)
		{
			if(isdefined(level.barrier_align[i].script_string) && level.barrier_align[i].script_string == behaviortreeentity.find_flesh_struct_string)
			{
				behaviortreeentity.barrier_align = level.barrier_align[i];
			}
		}
		behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
		/#
			assert(isdefined(node), ("" + behaviortreeentity.find_flesh_struct_string) + "");
		#/
		behaviortreeentity.first_node = node;
		goal_pos = getclosestpointonnavmesh(node.origin, 128, self getpathfindingradius());
		behaviortreeentity function_a57c34b7(goal_pos);
		if(zombieisatentrance(behaviortreeentity))
		{
			behaviortreeentity.got_to_entrance = 1;
		}
		return true;
	}
}

/*
	Name: zombieattackableobjectservice
	Namespace: zm_behavior
	Checksum: 0x4F3CE375
	Offset: 0x6618
	Size: 0x12E
	Parameters: 1
	Flags: Linked
*/
function zombieattackableobjectservice(behaviortreeentity)
{
	if(!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable"))
	{
		behaviortreeentity.attackable = undefined;
		return false;
	}
	if(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)
	{
		behaviortreeentity.attackable = undefined;
		return false;
	}
	if(isdefined(behaviortreeentity.aat_turned) && behaviortreeentity.aat_turned)
	{
		behaviortreeentity.attackable = undefined;
		return false;
	}
	if(!isdefined(behaviortreeentity.attackable))
	{
		behaviortreeentity.attackable = zm_attackables::get_attackable();
	}
	else if(!(isdefined(behaviortreeentity.attackable.is_active) && behaviortreeentity.attackable.is_active))
	{
		behaviortreeentity.attackable = undefined;
	}
}

/*
	Name: zombiemovetoentranceaction
	Namespace: zm_behavior
	Checksum: 0x2975A9FB
	Offset: 0x6750
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function zombiemovetoentranceaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.got_to_entrance = 0;
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiemovetoentranceactionterminate
	Namespace: zm_behavior
	Checksum: 0x31B68AF8
	Offset: 0x6798
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function zombiemovetoentranceactionterminate(behaviortreeentity, asmstatename)
{
	if(zombieisatentrance(behaviortreeentity))
	{
		behaviortreeentity.got_to_entrance = 1;
	}
	return 4;
}

/*
	Name: zombiemovetoattackspotaction
	Namespace: zm_behavior
	Checksum: 0x6012CB9F
	Offset: 0x67E8
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function zombiemovetoattackspotaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.at_entrance_tear_spot = 0;
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiemovetoattackspotactionterminate
	Namespace: zm_behavior
	Checksum: 0x7C0ACCD9
	Offset: 0x6830
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function zombiemovetoattackspotactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.at_entrance_tear_spot = 1;
	return 4;
}

/*
	Name: zombieholdboardaction
	Namespace: zm_behavior
	Checksum: 0x5696FAAB
	Offset: 0x6860
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function zombieholdboardaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 1;
	behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
	behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
	boardactionast = behaviortreeentity astsearch(asmstatename);
	boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombieholdboardactionterminate
	Namespace: zm_behavior
	Checksum: 0x9E0C674E
	Offset: 0x6960
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function zombieholdboardactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 0;
	return 4;
}

/*
	Name: zombiegrabboardaction
	Namespace: zm_behavior
	Checksum: 0xB0987E5A
	Offset: 0x6990
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function zombiegrabboardaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 1;
	behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
	behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
	boardactionast = behaviortreeentity astsearch(asmstatename);
	boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiegrabboardactionterminate
	Namespace: zm_behavior
	Checksum: 0xCAD60F6
	Offset: 0x6A90
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function zombiegrabboardactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 0;
	return 4;
}

/*
	Name: zombiepullboardaction
	Namespace: zm_behavior
	Checksum: 0xEE0554EF
	Offset: 0x6AC0
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function zombiepullboardaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 1;
	behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
	behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
	boardactionast = behaviortreeentity astsearch(asmstatename);
	boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiepullboardactionterminate
	Namespace: zm_behavior
	Checksum: 0x361E2E6E
	Offset: 0x6BC0
	Size: 0x32
	Parameters: 2
	Flags: Linked
*/
function zombiepullboardactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 0;
	self.lastchunk_destroy_time = gettime();
	return 4;
}

/*
	Name: zombieattackthroughboardsaction
	Namespace: zm_behavior
	Checksum: 0x2B4B02B8
	Offset: 0x6C00
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function zombieattackthroughboardsaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 1;
	behaviortreeentity.boardattack = 1;
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombieattackthroughboardsactionterminate
	Namespace: zm_behavior
	Checksum: 0xA622308C
	Offset: 0x6C58
	Size: 0x32
	Parameters: 2
	Flags: Linked
*/
function zombieattackthroughboardsactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 0;
	behaviortreeentity.boardattack = 0;
	return 4;
}

/*
	Name: zombietauntaction
	Namespace: zm_behavior
	Checksum: 0x410CF642
	Offset: 0x6C98
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function zombietauntaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 1;
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombietauntactionterminate
	Namespace: zm_behavior
	Checksum: 0xA776C269
	Offset: 0x6CE0
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function zombietauntactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.keepclaimednode = 0;
	return 4;
}

/*
	Name: zombiemantleaction
	Namespace: zm_behavior
	Checksum: 0x5F3024B
	Offset: 0x6D10
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function zombiemantleaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity.clamptonavmesh = 0;
	if(isdefined(behaviortreeentity.attacking_spot_index))
	{
		behaviortreeentity.saved_attacking_spot_index = behaviortreeentity.attacking_spot_index;
		behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
	}
	behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
	behaviortreeentity pushplayer(1);
	behaviortreeentity.isinmantleaction = 1;
	behaviortreeentity zombie_utility::reset_attack_spot();
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiemantleactionterminate
	Namespace: zm_behavior
	Checksum: 0xB3826C62
	Offset: 0x6E10
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function zombiemantleactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity.clamptonavmesh = 1;
	behaviortreeentity.isinmantleaction = undefined;
	if(isdefined(behaviortreeentity.var_9ed3cc11))
	{
		behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
		behaviortreeentity.var_9ed3cc11 = undefined;
	}
	behaviortreeentity zm_behavior_utility::enteredplayablearea();
	return 4;
}

/*
	Name: boardtearmocompstart
	Namespace: zm_behavior
	Checksum: 0xB5C315AF
	Offset: 0x6E98
	Size: 0x1F4
	Parameters: 5
	Flags: Linked
*/
function boardtearmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.barrier_align))
	{
		origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
		angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
	}
	else
	{
		origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
		angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
	}
	entity forceteleport(origin, angles, 1);
	entity.pushable = 0;
	entity.blockingpain = 1;
	entity animmode("noclip", 1);
	entity orientmode("face angle", angles[1]);
}

/*
	Name: boardtearmocompupdate
	Namespace: zm_behavior
	Checksum: 0x15273734
	Offset: 0x7098
	Size: 0x6A
	Parameters: 5
	Flags: Linked
*/
function boardtearmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("noclip", 0);
	entity.pushable = 0;
	entity.blockingpain = 1;
}

/*
	Name: barricadeentermocompstart
	Namespace: zm_behavior
	Checksum: 0x45CA1D4A
	Offset: 0x7110
	Size: 0x2AA
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.barrier_align))
	{
		origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
		angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
	}
	else
	{
		zbarrier_origin = (isdefined(entity.first_node.first_node.zbarrier) ? entity.first_node.zbarrier.origin : entity.first_node.zbarrier_origin);
		var_f4b27846 = (isdefined(entity.first_node.first_node.zbarrier) ? entity.first_node.zbarrier.angles : entity.first_node.var_f4b27846);
		origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompanim);
		angles = getstartangles(zbarrier_origin, var_f4b27846, mocompanim);
	}
	if(isdefined(entity.mocomp_barricade_offset))
	{
		origin = origin + (anglestoforward(angles) * entity.mocomp_barricade_offset);
	}
	entity forceteleport(origin, angles, 1);
	entity animmode("noclip", 0);
	entity orientmode("face angle", angles[1]);
	entity.pushable = 0;
	entity.blockingpain = 1;
	entity pathmode("dont move");
	entity.usegoalanimweight = 1;
}

/*
	Name: barricadeentermocompupdate
	Namespace: zm_behavior
	Checksum: 0x1A3D3A07
	Offset: 0x73C8
	Size: 0x5A
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("noclip", 0);
	entity.pushable = 0;
}

/*
	Name: barricadeentermocompterminate
	Namespace: zm_behavior
	Checksum: 0x67529D6A
	Offset: 0x7430
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.pushable = 1;
	entity.blockingpain = 0;
	entity pathmode("move allowed");
	entity.usegoalanimweight = 0;
	entity animmode("normal", 0);
	entity orientmode("face motion");
}

/*
	Name: barricadeentermocompnozstart
	Namespace: zm_behavior
	Checksum: 0x1433A50
	Offset: 0x74F0
	Size: 0x2AA
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompnozstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.barrier_align))
	{
		origin = getstartorigin(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
		angles = getstartangles(entity.barrier_align.origin, entity.barrier_align.angles, mocompanim);
	}
	else
	{
		zbarrier_origin = (isdefined(entity.first_node.first_node.zbarrier) ? entity.first_node.zbarrier.origin : entity.first_node.zbarrier_origin);
		var_f4b27846 = (isdefined(entity.first_node.first_node.zbarrier) ? entity.first_node.zbarrier.angles : entity.first_node.var_f4b27846);
		origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompanim);
		angles = getstartangles(zbarrier_origin, var_f4b27846, mocompanim);
	}
	if(isdefined(entity.mocomp_barricade_offset))
	{
		origin = origin + (anglestoforward(angles) * entity.mocomp_barricade_offset);
	}
	entity forceteleport(origin, angles, 1);
	entity animmode("noclip", 0);
	entity orientmode("face angle", angles[1]);
	entity.pushable = 0;
	entity.blockingpain = 1;
	entity pathmode("dont move");
	entity.usegoalanimweight = 1;
}

/*
	Name: barricadeentermocompnozupdate
	Namespace: zm_behavior
	Checksum: 0x608DEEEB
	Offset: 0x77A8
	Size: 0x5A
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompnozupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("noclip", 0);
	entity.pushable = 0;
}

/*
	Name: barricadeentermocompnozterminate
	Namespace: zm_behavior
	Checksum: 0xB73BF238
	Offset: 0x7810
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function barricadeentermocompnozterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.pushable = 1;
	entity.blockingpain = 0;
	entity pathmode("move allowed");
	entity.usegoalanimweight = 0;
	entity animmode("normal", 0);
	entity orientmode("face motion");
}

/*
	Name: notetrackboardtear
	Namespace: zm_behavior
	Checksum: 0xEDA272A8
	Offset: 0x78D0
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function notetrackboardtear(animationentity)
{
	if(isdefined(animationentity.chunk))
	{
		animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
		level notify(#"zombie_board_tear", {#s_board:animationentity.first_node, #ai_zombie:animationentity});
	}
}

/*
	Name: notetrackboardmelee
	Namespace: zm_behavior
	Checksum: 0x449F85B9
	Offset: 0x7970
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function notetrackboardmelee(animationentity)
{
	/#
		assert(animationentity.meleeweapon != level.weaponnone, "");
	#/
	if(isdefined(animationentity.first_node))
	{
		meleedistsq = 8100;
		if(isdefined(level.attack_player_thru_boards_range))
		{
			meleedistsq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
		}
		triggerdistsq = 2601;
		for(i = 0; i < animationentity.player_targets.size; i++)
		{
			if(!isdefined(animationentity.player_targets[i]))
			{
				continue;
			}
			playerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.origin);
			heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.origin[2]);
			if(playerdistsq < meleedistsq && (heightdiff * heightdiff) < meleedistsq)
			{
				playertriggerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.first_node.trigger_location.origin);
				heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.first_node.trigger_location.origin[2]);
				if(playertriggerdistsq < triggerdistsq && (heightdiff * heightdiff) < triggerdistsq)
				{
					animationentity.player_targets[i] playsoundtoplayer(#"hash_75318bcffca7ff06", animationentity.player_targets[i]);
					animationentity.player_targets[i] dodamage(animationentity.meleeweapon.meleedamage, animationentity.origin, self, self, "none", "MOD_MELEE");
					break;
				}
			}
		}
	}
	else
	{
		animationentity melee();
	}
}

/*
	Name: function_b37b8c0d
	Namespace: zm_behavior
	Checksum: 0xD7BE3BD
	Offset: 0x7C80
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_b37b8c0d(entity)
{
	if(isdefined(entity.first_node))
	{
		zm_blockers::open_zbarrier(entity.first_node, 1);
	}
}

/*
	Name: findzombieenemy
	Namespace: zm_behavior
	Checksum: 0x22F064F7
	Offset: 0x7CC8
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function findzombieenemy()
{
	if(isdefined(self.var_8b59c468))
	{
		self [[self.var_8b59c468]]();
		return;
	}
	zombies = getaispeciesarray(level.zombie_team, "all");
	zombie_enemy = undefined;
	closest_dist = undefined;
	foreach(zombie in zombies)
	{
		if(isalive(zombie) && (isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area) && !zm_utility::is_magic_bullet_shield_enabled(zombie) && (isdefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies))
		{
			dist = distancesquared(self.origin, zombie.origin);
			if(!isdefined(closest_dist) || dist < closest_dist)
			{
				closest_dist = dist;
				zombie_enemy = zombie;
			}
		}
	}
	self.favoriteenemy = zombie_enemy;
	if(isdefined(self.favoriteenemy))
	{
		self setgoal(self.favoriteenemy.origin);
	}
	else
	{
		self setgoal(self.origin);
	}
}

/*
	Name: zombieblackholebombpullstart
	Namespace: zm_behavior
	Checksum: 0xE4041FA7
	Offset: 0x7ED0
	Size: 0xA6
	Parameters: 2
	Flags: Linked
*/
function zombieblackholebombpullstart(entity, asmstatename)
{
	entity.pulltime = gettime();
	entity.pullorigin = entity.origin;
	animationstatenetworkutility::requeststate(entity, asmstatename);
	zombieupdateblackholebombpullstate(entity);
	if(isdefined(entity.damageorigin))
	{
		entity.n_zombie_custom_goal_radius = 8;
		entity.v_zombie_custom_goal_pos = entity.damageorigin;
	}
	return 5;
}

/*
	Name: zombieupdateblackholebombpullstate
	Namespace: zm_behavior
	Checksum: 0xA2644BDF
	Offset: 0x7F80
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function zombieupdateblackholebombpullstate(entity)
{
	dist_to_bomb = distancesquared(entity.origin, entity.damageorigin);
	if(dist_to_bomb < 16384)
	{
		entity._black_hole_bomb_collapse_death = 1;
	}
	else
	{
		if(dist_to_bomb < 1048576)
		{
		}
		else
		{
		}
	}
}

/*
	Name: zombieblackholebombpullupdate
	Namespace: zm_behavior
	Checksum: 0x8648F898
	Offset: 0x8010
	Size: 0x212
	Parameters: 2
	Flags: Linked
*/
function zombieblackholebombpullupdate(entity, asmstatename)
{
	if(!isdefined(entity.interdimensional_gun_kill))
	{
		return 4;
	}
	zombieupdateblackholebombpullstate(entity);
	if(isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death)
	{
		entity.skipautoragdoll = 1;
		entity dodamage(entity.health + 666, entity.origin + vectorscale((0, 0, 1), 50), entity.interdimensional_gun_attacker, undefined, undefined, "MOD_CRUSH");
		return 4;
	}
	if(isdefined(entity.damageorigin))
	{
		entity.v_zombie_custom_goal_pos = entity.damageorigin;
	}
	if(!(isdefined(entity.missinglegs) && entity.missinglegs) && (gettime() - entity.pulltime) > 1000)
	{
		distsq = distance2dsquared(entity.origin, entity.pullorigin);
		if(distsq < 144)
		{
			entity setavoidancemask("avoid all");
			entity.cant_move = 1;
			if(isdefined(entity.cant_move_cb))
			{
				entity thread [[entity.cant_move_cb]]();
			}
		}
		else
		{
			entity setavoidancemask("avoid none");
			entity.cant_move = 0;
		}
		entity.pulltime = gettime();
		entity.pullorigin = entity.origin;
	}
	return 5;
}

/*
	Name: zombieblackholebombpullend
	Namespace: zm_behavior
	Checksum: 0x1F2EAEB5
	Offset: 0x8230
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function zombieblackholebombpullend(entity, asmstatename)
{
	entity.v_zombie_custom_goal_pos = undefined;
	entity.n_zombie_custom_goal_radius = undefined;
	entity.pulltime = undefined;
	entity.pullorigin = undefined;
	return 4;
}

/*
	Name: zombiekilledwhilegettingpulled
	Namespace: zm_behavior
	Checksum: 0xF6AF7F8F
	Offset: 0x8280
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function zombiekilledwhilegettingpulled(entity)
{
	if(!(isdefined(self.missinglegs) && self.missinglegs) && (isdefined(entity.interdimensional_gun_kill) && entity.interdimensional_gun_kill) && (!(isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death)))
	{
		return true;
	}
	return false;
}

/*
	Name: zombiekilledbyblackholebombcondition
	Namespace: zm_behavior
	Checksum: 0x6193C3AD
	Offset: 0x8300
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function zombiekilledbyblackholebombcondition(entity)
{
	if(isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death)
	{
		return true;
	}
	return false;
}

/*
	Name: function_38fec26f
	Namespace: zm_behavior
	Checksum: 0x7D3C615
	Offset: 0x8340
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_38fec26f(entity)
{
	if(isdefined(entity.freezegun_death) && entity.freezegun_death)
	{
		return true;
	}
	return false;
}

/*
	Name: function_e4d7303f
	Namespace: zm_behavior
	Checksum: 0xDB95E80B
	Offset: 0x8380
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function function_e4d7303f(entity)
{
	return isdefined(entity.var_69a981e6) && entity.var_69a981e6;
}

/*
	Name: function_17cd1b17
	Namespace: zm_behavior
	Checksum: 0x60658DD5
	Offset: 0x83B0
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_17cd1b17(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.enemy))
	{
		return 0;
	}
	meleedistsq = 4096;
	if(isdefined(behaviortreeentity.meleeweapon) && behaviortreeentity.meleeweapon !== level.weaponnone)
	{
		meleedistsq = behaviortreeentity.meleeweapon.aimeleerange * behaviortreeentity.meleeweapon.aimeleerange;
	}
	if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > meleedistsq)
	{
		return 0;
	}
	return isdefined(behaviortreeentity.melee_cooldown) && gettime() < behaviortreeentity.melee_cooldown;
}

/*
	Name: zombiekilledbyblackholebombstart
	Namespace: zm_behavior
	Checksum: 0x94CA00B8
	Offset: 0x84A0
	Size: 0x68
	Parameters: 2
	Flags: Linked
*/
function zombiekilledbyblackholebombstart(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	if(isdefined(level.black_hole_bomb_death_start_func))
	{
		entity thread [[level.black_hole_bomb_death_start_func]](entity.damageorigin, entity.interdimensional_gun_projectile);
	}
	return 5;
}

/*
	Name: zombiekilledbyblackholebombend
	Namespace: zm_behavior
	Checksum: 0x34222444
	Offset: 0x8510
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function zombiekilledbyblackholebombend(entity, asmstatename)
{
	if(isdefined(level._effect) && isdefined(level._effect[#"black_hole_bomb_zombie_gib"]))
	{
		fxorigin = entity gettagorigin("tag_origin");
		forward = anglestoforward(entity.angles);
		playfx(level._effect[#"black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
	}
	entity hide();
	return 4;
}

/*
	Name: zombiebhbburst
	Namespace: zm_behavior
	Checksum: 0xDF68F175
	Offset: 0x8600
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function zombiebhbburst(entity)
{
	if(isdefined(level._effect) && isdefined(level._effect[#"black_hole_bomb_zombie_destroy"]))
	{
		fxorigin = entity gettagorigin("tag_origin");
		playfx(level._effect[#"black_hole_bomb_zombie_destroy"], fxorigin);
	}
	if(isdefined(entity.interdimensional_gun_projectile))
	{
		entity.interdimensional_gun_projectile notify(#"black_hole_bomb_kill");
	}
}

/*
	Name: function_b654f4f5
	Namespace: zm_behavior
	Checksum: 0xEA49A6
	Offset: 0x86C8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_b654f4f5(entity)
{
	if(isdefined(level.var_58e6238))
	{
		entity [[level.var_58e6238]]();
	}
	return 5;
}

/*
	Name: function_36b3cb7d
	Namespace: zm_behavior
	Checksum: 0x99603AB2
	Offset: 0x8708
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_36b3cb7d(entity)
{
	if(isdefined(level.var_f975b6ae))
	{
		entity [[level.var_f975b6ae]]();
	}
}

/*
	Name: function_7994fd99
	Namespace: zm_behavior
	Checksum: 0x743F78B8
	Offset: 0x8740
	Size: 0x100
	Parameters: 12
	Flags: Linked
*/
function function_7994fd99(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker) && isactor(attacker) && self.team == attacker.team)
	{
		return -1;
	}
	if(self.archetype == #"zombie")
	{
		self destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
	}
	return -1;
}

