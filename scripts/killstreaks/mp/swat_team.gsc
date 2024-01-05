// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_human_interface.gsc;
#using scripts\core_common\ai\archetype_human.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\util.gsc;
#using scripts\mp_common\player\player_utils.gsc;
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\path.gsc;
#using scripts\killstreaks\ai\tracking.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\targetting_delay.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\killstreaks\killstreak_bundles.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using script_52d2de9b438adc78;
#using scripts\killstreaks\helicopter_shared.gsc;
#using scripts\killstreaks\airsupport.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using script_178024232e91b0a1;
#using script_4bf952f6ba31bb17;
#using script_3aa0f32b70d4f7cb;
#using script_3819e7a1427df6d2;

class class_60aca60a 
{

	/*
		Name: constructor
		Namespace: namespace_60aca60a
		Checksum: 0xFBB6FAF9
		Offset: 0x2120
		Size: 0x1E
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self.currentstate = "engage_center";
		self.var_85a7b7d2 = gettime();
	}

	/*
		Name: destructor
		Namespace: namespace_60aca60a
		Checksum: 0x80F724D1
		Offset: 0x2148
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

}

#namespace swat_team;

/*
	Name: __init__system__
	Namespace: swat_team
	Checksum: 0x762B3A43
	Offset: 0x9D8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"swat_team", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: swat_team
	Checksum: 0xA9DEDFAD
	Offset: 0xA28
	Size: 0x3DC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ir_strobe::init_shared();
	if(!isdefined(level.var_1e18ffa0))
	{
		level.var_1e18ffa0 = [];
		level.var_1e18ffa0[#"allies"] = [];
		level.var_1e18ffa0[#"allies"][0] = "spawner_mp_swat_buddy_team1_male";
		level.var_1e18ffa0[#"allies"][1] = "spawner_mp_swat_buddy_team1_female";
		level.var_1e18ffa0[#"allies"][2] = "spawner_mp_swat_buddy_team1_male";
		level.var_1e18ffa0[#"axis"] = [];
		level.var_1e18ffa0[#"axis"][0] = "spawner_mp_swat_buddy_team2_male";
		level.var_1e18ffa0[#"axis"][1] = "spawner_mp_swat_buddy_team2_female";
		level.var_1e18ffa0[#"axis"][2] = "spawner_mp_swat_buddy_team2_male";
	}
	loadsentienteventparameters("sentientevents_mp");
	spawner::add_archetype_spawn_function(#"human", &function_48d57bc8);
	callback::on_actor_damage(&function_493691bc);
	callback::on_ai_killed(&function_6f7a6cbc);
	callback::on_actor_killed(&on_swat_kill);
	callback::on_player_killed_with_params(&on_swat_kill);
	callback::on_finalize_initialization(&function_3675de8b);
	clientfield::register("actor", "swat_light_strobe", 1, 1, "int");
	clientfield::register("scriptmover", "swat_light_strobe", 1, 1, "int");
	clientfield::register("actor", "swat_shocked", 1, 1, "int");
	clientfield::register("vehicle", "swat_helicopter_death_fx", 1, getminbitcountfornum(2), "int");
	clientfield::register("actor", "swat_rob_state", 1, 1, "int");
	killstreaks::register_killstreak("killstreak_swat_team", &function_87bf6422);
	killstreaks::register_alt_weapon("swat_team", getweapon(#"ar_accurate_t8_swat"));
	player::function_3c5cc656(&function_610d3790);
	registerbehaviorscriptfunctions();
}

/*
	Name: function_3675de8b
	Namespace: swat_team
	Checksum: 0x2020BF22
	Offset: 0xE10
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_3675de8b()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon("player_air_vehicle1_main_turret_3rd_person_swat"), &function_fe5b1120);
	}
}

/*
	Name: function_fe5b1120
	Namespace: swat_team
	Checksum: 0xC36137EC
	Offset: 0xE60
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_fe5b1120(helicopter, attackingplayer)
{
	helicopter notify(#"hash_216c905d79c8bbea");
	if(isdefined(helicopter.rope))
	{
		function_d4331865(helicopter.rope);
	}
	helicopter thread swat_helicopter_explode(helicopter);
}

/*
	Name: createremoteweapontrigger
	Namespace: swat_team
	Checksum: 0x191E57E5
	Offset: 0xED8
	Size: 0x21E
	Parameters: 1
	Flags: Linked
*/
function createremoteweapontrigger(hintstring)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	weapon = spawnstruct();
	weapon.remoteowner = player;
	weapon.inittime = gettime();
	weapon.usetrigger = spawn("trigger_radius_use", player.origin, 0, 32, 32);
	weapon.usetrigger enablelinkto();
	weapon.usetrigger linkto(player);
	weapon.usetrigger sethintlowpriority(1);
	weapon.usetrigger setcursorhint("HINT_NOICON");
	weapon.usetrigger sethintstring(hintstring);
	weapon.usetrigger setteamfortrigger(player.team);
	weapon.usetrigger.team = player.team;
	player clientclaimtrigger(weapon.usetrigger);
	player.remotecontroltrigger = weapon.usetrigger;
	player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
	weapon.usetrigger.claimedby = player;
	return weapon;
}

/*
	Name: function_944f0911
	Namespace: swat_team
	Checksum: 0x85CF7077
	Offset: 0x1100
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_944f0911(hintstring)
{
	/#
		assert(isdefined(self.usetrigger));
	#/
	self.usetrigger sethintstring(hintstring);
}

/*
	Name: function_ab9a9770
	Namespace: swat_team
	Checksum: 0xC57DC7A9
	Offset: 0x1150
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_ab9a9770(player)
{
	results = groundtrace(player.origin + vectorscale((0, 0, 1), 70), player.origin + (vectorscale((0, 0, -1), 100)), 0, player);
	if(isdefined(results) && isdefined(results[#"entity"]) && results[#"entity"] ismovingplatform())
	{
		return true;
	}
	return false;
}

/*
	Name: function_87bf6422
	Namespace: swat_team
	Checksum: 0xA859B47C
	Offset: 0x1218
	Size: 0x350
	Parameters: 1
	Flags: Linked
*/
function function_87bf6422(killstreak)
{
	player = self;
	context = spawnstruct();
	context.radius = level.killstreakcorebundle.ksairdropsupplydropradius;
	context.dist_from_boundary = 100;
	context.max_dist_from_location = 4;
	context.perform_physics_trace = 1;
	context.islocationgood = &islocationgood;
	context.objective = #"hash_1b5a86007f598bbc";
	context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
	context.tracemask = 1;
	context.droptag = "tag_attach";
	context.droptagoffset = (-32, 0, 23);
	context.killstreaktype = killstreak;
	context.killstreakref = "swat_team";
	context.var_597ac911 = &stopkillstreak;
	context.var_43dc1011 = player.team;
	killstreak_id = killstreakrules::killstreakstart("swat_team", self.team, 0, 1);
	context.killstreak_id = killstreak_id;
	ksbundle = killstreak_bundles::get_bundle(context);
	if(isdefined(ksbundle))
	{
		context.time = ksbundle.kstime;
		context.fx_name = ksbundle.var_3af79d7e;
	}
	waterdepth = self depthofplayerinwater();
	if(!self isonground() || self util::isusingremote() || waterdepth > 2 || self function_ab9a9770(self))
	{
		self iprintlnbold(#"hash_7b15978f7b8174f7");
		return false;
	}
	player notify(#"hash_6e666a0689c3fd62");
	player thread function_6936559a(context);
	player thread spawn_swat_team(player, context, player.origin);
	util::function_5a68c330(21, player.team, player getentitynumber(), level.killstreaks[#"swat_team"].uiname);
	return true;
}

/*
	Name: function_6936559a
	Namespace: swat_team
	Checksum: 0x3C72C7A4
	Offset: 0x1570
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_6936559a(context)
{
	trace = groundtrace(self.origin + vectorscale((0, 0, 1), 50), self.origin + (vectorscale((0, 0, -1), 100000)), 0, self);
	if(isdefined(trace[#"position"]) && isdefined(trace[#"normal"]))
	{
		origin = trace[#"position"];
		angles = vectortoangles(trace[#"normal"]);
		ir_model = util::spawn_model("wpn_t8_eqp_ir_strobe_world", origin, angles);
		if(isdefined(ir_model))
		{
			context.ir_model = ir_model;
			ir_model clientfield::set("swat_light_strobe", 1);
			ir_model waittilltimeout(10, #"hash_1e4c945d50deb21d");
			ir_model clientfield::set("swat_light_strobe", 0);
			waitframe(2);
			ir_model delete();
		}
	}
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: swat_team
	Checksum: 0x38B04275
	Offset: 0x1708
	Size: 0x45C
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_7b12237f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_521ce9363e228cec", &function_7b12237f);
	/#
		assert(isscriptfunctionptr(&function_e3151f98));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62335a0608a02309", &function_e3151f98);
	/#
		assert(isscriptfunctionptr(&function_e5f59cf0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a938922d1af0c4d", &function_e5f59cf0);
	/#
		assert(isscriptfunctionptr(&function_3c677dcd));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc583c8bb841d4c", &function_3c677dcd);
	/#
		assert(isscriptfunctionptr(&function_994477c0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3861dc092e2bcf88", &function_994477c0, 1);
	/#
		assert(isscriptfunctionptr(&function_fb9f1f3b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48334fe2b83169f2", &function_fb9f1f3b, 1);
	/#
		assert(isscriptfunctionptr(&function_5bc83fac));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_44cbd2652f2bcafb", &function_5bc83fac);
	/#
		assert(isscriptfunctionptr(&function_5e207da3));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_37de1d651cda8ede", &function_5e207da3);
	/#
		assert(isscriptfunctionptr(&swatshouldmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"swatshouldmelee", &swatshouldmelee);
	/#
		assert(isscriptfunctionptr(&swatshouldmelee));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"swatshouldmelee", &swatshouldmelee);
	animationstatenetwork::registeranimationmocomp("mocomp_swat_team_pain", &function_6edff1e1, undefined, &function_8acd749d);
}

/*
	Name: function_6edff1e1
	Namespace: swat_team
	Checksum: 0x68891CFC
	Offset: 0x1B70
	Size: 0xA2
	Parameters: 5
	Flags: Linked
*/
function function_6edff1e1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", self.angles[1]);
	entity animmode("zonly_physics", 1);
	entity pathmode("dont move");
	entity.blockingpain = 1;
}

/*
	Name: function_8acd749d
	Namespace: swat_team
	Checksum: 0x9B1CACE2
	Offset: 0x1C20
	Size: 0x5A
	Parameters: 5
	Flags: Linked
*/
function function_8acd749d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity pathmode("move allowed");
	entity.blockingpain = 0;
}

/*
	Name: function_7b12237f
	Namespace: swat_team
	Checksum: 0xEFABCA69
	Offset: 0x1C88
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7b12237f(entity)
{
	if(isdefined(entity.ai.var_f185cb34) && entity.ai.var_f185cb34)
	{
		return true;
	}
	return false;
}

/*
	Name: function_e3151f98
	Namespace: swat_team
	Checksum: 0xD42B68C
	Offset: 0x1CD8
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e3151f98(entity)
{
	if(isdefined(entity.ai.swat_gunner) && entity.ai.swat_gunner)
	{
		return true;
	}
	return false;
}

/*
	Name: function_e5f59cf0
	Namespace: swat_team
	Checksum: 0x7D633122
	Offset: 0x1D28
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e5f59cf0(entity)
{
	entity unlink();
}

/*
	Name: function_3c677dcd
	Namespace: swat_team
	Checksum: 0x9D5447FD
	Offset: 0x1D58
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3c677dcd(entity)
{
	if(isdefined(entity.enemy) && (!(isdefined(entity.ignoreall) && entity.ignoreall)))
	{
		if(util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(90)))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_5bc83fac
	Namespace: swat_team
	Checksum: 0xF3DCFE85
	Offset: 0x1E00
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5bc83fac(entity)
{
	if(entity.var_40543c03 === "electrical")
	{
		clientfield::set("swat_shocked", 1);
	}
}

/*
	Name: swatshouldmelee
	Namespace: swat_team
	Checksum: 0x40475AE6
	Offset: 0x1E50
	Size: 0x296
	Parameters: 1
	Flags: Linked, Private
*/
function private swatshouldmelee(entity)
{
	if(isdefined(entity.ai.lastshouldmeleeresult) && !entity.ai.lastshouldmeleeresult && (entity.ai.lastshouldmeleechecktime + 200) >= gettime())
	{
		return false;
	}
	entity.lastshouldmeleechecktime = gettime();
	entity.lastshouldmeleeresult = 0;
	if(!isdefined(entity.enemy))
	{
		return false;
	}
	if(!entity.enemy.allowdeath)
	{
		return false;
	}
	if(!isalive(entity.enemy))
	{
		return false;
	}
	if(!issentient(entity.enemy))
	{
		return false;
	}
	if(!isactor(entity.enemy) && !isplayer(entity.enemy))
	{
		return false;
	}
	if(isplayer(entity.enemy) && entity.enemy getstance() == "prone")
	{
		return false;
	}
	if(isactor(entity.enemy))
	{
		if(!isdefined(entity.enemy.archetype))
		{
			return false;
		}
		if(entity.enemy.archetype != #"human")
		{
			return false;
		}
	}
	if(distancesquared(entity.origin, entity.enemy.origin) > 140 * 140)
	{
		return false;
	}
	if(!aiutility::shouldmutexmelee(entity))
	{
		return false;
	}
	if(aiutility::shouldnormalmelee(entity) || aiutility::shouldchargemelee(entity))
	{
		entity.ai.lastshouldmeleeresult = 1;
		return true;
	}
	return false;
}

/*
	Name: function_5e207da3
	Namespace: swat_team
	Checksum: 0x10141E33
	Offset: 0x20F0
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5e207da3(entity)
{
	clientfield::set("swat_shocked", 0);
}

/*
	Name: function_91228fe2
	Namespace: swat_team
	Checksum: 0x24D4573A
	Offset: 0x21E8
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_91228fe2(entity)
{
	if(isdefined(entity.ai.var_5cb410bc))
	{
		entity.ai.var_5cb410bc = undefined;
		if(isdefined(entity.goalpos))
		{
			entity function_a57c34b7(entity.goalpos);
		}
	}
}

/*
	Name: function_a72ef6ce
	Namespace: swat_team
	Checksum: 0x8E0033AB
	Offset: 0x2258
	Size: 0x74
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a72ef6ce(entity, newspot)
{
	/#
		assert(isdefined(newspot));
	#/
	if(isdefined(entity.goalpos) && isdefined(entity.goalradius))
	{
		if(entity isingoal(newspot))
		{
			return true;
		}
		return false;
	}
	return true;
}

/*
	Name: function_f046ec67
	Namespace: swat_team
	Checksum: 0xCCE0F367
	Offset: 0x22D8
	Size: 0x6E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f046ec67(entity)
{
	function_91228fe2(entity);
	entity.ai.var_5cb410bc = new class_60aca60a();
	entity.ai.var_5cb410bc.centerpos = entity.origin;
}

/*
	Name: function_615dc1b2
	Namespace: swat_team
	Checksum: 0x774A518D
	Offset: 0x2350
	Size: 0x6E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_615dc1b2(entity)
{
	/#
		assert(isdefined(entity.ai.var_5cb410bc));
	#/
	entity.ai.var_5cb410bc.var_85a7b7d2 = gettime() + randomintrange(1200, 2200);
}

/*
	Name: function_fb9f1f3b
	Namespace: swat_team
	Checksum: 0xF80BB84A
	Offset: 0x23C8
	Size: 0x920
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fb9f1f3b(entity)
{
	if(isdefined(entity.reacquire_state) && entity.reacquire_state > 0)
	{
		function_91228fe2(entity);
		return false;
	}
	if(!isdefined(entity.enemy) || !entity seerecently(entity.enemy, 8))
	{
		function_91228fe2(entity);
		return false;
	}
	if(!issentient(entity.enemy) || !isplayer(entity.enemy))
	{
		function_91228fe2(entity);
		return false;
	}
	var_1438a751 = distancesquared(entity.origin, entity.enemy.origin);
	if(var_1438a751 < 100 * 100)
	{
		function_91228fe2(entity);
		return false;
	}
	if(var_1438a751 > 1000 * 1000)
	{
		function_91228fe2(entity);
		return false;
	}
	seerecently = entity seerecently(entity.enemy, 8);
	var_245760b8 = entity attackedrecently(entity.enemy, 4);
	var_a199aab8 = seerecently && var_245760b8;
	if(!var_a199aab8)
	{
		function_91228fe2(entity);
		return false;
	}
	if(!isdefined(entity.ai.var_5cb410bc))
	{
		entity thread registerrein_amb("swat_engaging");
		function_f046ec67(entity);
	}
	if(gettime() < entity.ai.var_5cb410bc.var_85a7b7d2)
	{
		return false;
	}
	/#
		assert(isdefined(entity.ai.var_5cb410bc));
	#/
	nextstate = "engage_center";
	switch(entity.ai.var_5cb410bc.currentstate)
	{
		case "engage_center":
		{
			random = randomint(100);
			if(random < 33)
			{
				nextstate = "engage_left";
			}
			else if(random < 66)
			{
				nextstate = "engage_right";
			}
			break;
		}
		case "engage_left":
		case "engage_right":
		{
			nextstate = "engage_center";
			break;
		}
		default:
		{
			break;
		}
	}
	if(nextstate != entity.ai.var_5cb410bc.currentstate)
	{
		dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
		angles = vectortoangles(dirtoenemy);
		angles = (0, angles[1], 0);
		newspot = undefined;
		direction = undefined;
		if(nextstate == "engage_left")
		{
			var_5612239e = anglestoright(angles) * -1;
			movepos = entity.origin + vectorscale(var_5612239e, randomintrange(60, 200));
			tacpoint = getclosesttacpoint(movepos);
			if(isdefined(tacpoint) && tracepassedonnavmesh(entity.origin, tacpoint.origin, 18))
			{
				newspot = tacpoint.origin;
				direction = "engage_left";
			}
		}
		else
		{
			if(nextstate == "engage_right")
			{
				var_c254b075 = anglestoright(angles);
				movepos = entity.origin + vectorscale(var_c254b075, randomintrange(60, 200));
				tacpoint = getclosesttacpoint(movepos);
				if(isdefined(tacpoint) && tracepassedonnavmesh(entity.origin, tacpoint.origin, 18))
				{
					newspot = tacpoint.origin;
					direction = "engage_right";
				}
			}
			else
			{
				newspot = entity.ai.var_5cb410bc.centerpos;
				direction = "engage_center";
			}
		}
		if(isdefined(newspot) && isdefined(direction) && function_a72ef6ce(entity, newspot))
		{
			entity function_a57c34b7(newspot);
			function_615dc1b2(entity);
			/#
				record3dtext("" + direction, newspot + vectorscale((0, 0, 1), 10), (0, 0, 1), "");
				recordline(entity.origin, newspot, (0, 0, 1), "");
				recordcircle(newspot, 8, (0, 0, 1), "");
			#/
		}
		else
		{
			cylinder = ai::t_cylinder(entity.ai.var_5cb410bc.centerpos, entity.goalradius, 40);
			var_c5139037 = ai::t_cylinder(entity.ai.var_5cb410bc.centerpos, 60, 40);
			enemypos = entity.enemy.origin;
			tacpoints = tacticalquery("swat_engage_enemy", cylinder, entity, enemypos, var_c5139037);
			if(isdefined(tacpoints) && tacpoints.size)
			{
				tacpoint = array::random(tacpoints);
				entity function_a57c34b7(tacpoint.origin);
				function_615dc1b2(entity);
				/#
					record3dtext("", tacpoint.origin + vectorscale((0, 0, 1), 10), (0, 0, 1), "");
					recordline(entity.origin, tacpoint.origin, (0, 0, 1), "");
					recordcircle(tacpoint.origin, 8, (0, 0, 1), "");
				#/
			}
		}
	}
	return true;
}

/*
	Name: function_994477c0
	Namespace: swat_team
	Checksum: 0x61CC6931
	Offset: 0x2CF0
	Size: 0x2BA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_994477c0(entity)
{
	if(!isdefined(entity.reacquire_state))
	{
		entity.reacquire_state = 0;
	}
	if(!isdefined(entity.enemy))
	{
		entity.reacquire_state = 0;
		return false;
	}
	if(entity haspath())
	{
		entity.reacquire_state = 0;
		return false;
	}
	if(entity seerecently(entity.enemy, 4))
	{
		entity.reacquire_state = 0;
		return false;
	}
	dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
	forward = anglestoforward(entity.angles);
	if(vectordot(dirtoenemy, forward) < 0.5)
	{
		entity.reacquire_state = 0;
		return false;
	}
	switch(entity.reacquire_state)
	{
		case 0:
		case 1:
		case 2:
		{
			step_size = 32 + (entity.reacquire_state * 32);
			reacquirepos = entity reacquirestep(step_size);
			break;
		}
		case 4:
		{
			if(!entity cansee(entity.enemy) || !entity canshootenemy())
			{
				entity flagenemyunattackable();
			}
			break;
		}
		default:
		{
			if(entity.reacquire_state > 15)
			{
				entity.reacquire_state = 0;
				return false;
			}
			break;
		}
	}
	if(isvec(reacquirepos))
	{
		entity function_a57c34b7(reacquirepos);
		return true;
	}
	entity.reacquire_state++;
	return false;
}

/*
	Name: on_swat_kill
	Namespace: swat_team
	Checksum: 0x1074FB05
	Offset: 0x2FB8
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_swat_kill(params)
{
	if(isdefined(params.einflictor) && isactor(params.einflictor) && (isdefined(params.einflictor.ai.var_ac89e6f6) && params.einflictor.ai.var_ac89e6f6))
	{
		params.einflictor thread registerrein_amb("swat_kill");
	}
}

/*
	Name: function_493691bc
	Namespace: swat_team
	Checksum: 0xB383A05E
	Offset: 0x3060
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_493691bc()
{
	if(isdefined(self.ai.var_ac89e6f6) && self.ai.var_ac89e6f6)
	{
		var_af5a02c6 = int(1 * 1000);
		self.ai.var_b6554c59 = gettime() + var_af5a02c6;
		if(isdefined(self.var_134eefb9))
		{
			maxhealth = self.maxhealth;
			health_percent = self.health / maxhealth;
			objective_setprogress(self.var_134eefb9, health_percent);
		}
	}
}

/*
	Name: function_6f7a6cbc
	Namespace: swat_team
	Checksum: 0xA3AD0B90
	Offset: 0x3130
	Size: 0x2F4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6f7a6cbc(params)
{
	if(!(isdefined(self.ai.var_ac89e6f6) && self.ai.var_ac89e6f6))
	{
		return;
	}
	clientfield::set("swat_light_strobe", 0);
	if(isdefined(self.script_owner) && isdefined(self.script_owner.swat_team))
	{
		arrayremovevalue(self.script_owner.swat_team, self);
	}
	self laseroff();
	if(isdefined(self.var_134eefb9))
	{
		objective_delete(self.var_134eefb9);
		gameobjects::release_obj_id(self.var_134eefb9);
	}
	if(isdefined(params.eattacker))
	{
		if(isplayer(params.eattacker))
		{
			luinotifyevent(#"player_callout", 2, #"hash_4fb540af669c6500", params.eattacker.entnum);
			params.eattacker battlechatter::function_dd6a6012("swat_team", params.weapon);
			self killstreaks::function_73566ec7(params.eattacker, params.weapon, self.script_owner);
			params.eattacker challenges::destroyscorestreak(params.weapon, 0, 1, 0);
		}
	}
	self function_b4f4603e();
	if(isdefined(self.script_owner) && isdefined(self.script_owner.swat_team))
	{
		foreach(swat in self.script_owner.swat_team)
		{
			if(isdefined(swat) && isalive(swat) && swat != self)
			{
				swat thread registerrein_amb("swat_destroyed");
				break;
			}
		}
	}
}

/*
	Name: function_416a0a80
	Namespace: swat_team
	Checksum: 0x2D1BEA3A
	Offset: 0x3430
	Size: 0x20E
	Parameters: 1
	Flags: Linked
*/
function function_416a0a80(owner)
{
	self endon(#"death");
	if(getdvarint(#"hash_667dcfb9f4060f0c", 0))
	{
		self.var_134eefb9 = gameobjects::get_next_obj_id();
		objective_add(self.var_134eefb9, "active", self, #"hash_6cff9cefb99a67d1");
		objective_setprogress(self.var_134eefb9, 1);
		function_da7940a3(self.var_134eefb9, 1);
		objective_setinvisibletoall(self.var_134eefb9);
		objective_setvisibletoplayer(self.var_134eefb9, owner);
	}
	self.ai.var_b6554c59 = gettime();
	maxhealth = self.maxhealth;
	while(true)
	{
		var_d350f9d0 = gettime() >= self.ai.var_b6554c59;
		var_e057e12a = self.health >= self.maxhealth;
		if(var_d350f9d0 && !var_e057e12a)
		{
			newhealth = self.health + 300;
			if(newhealth <= maxhealth)
			{
				self.health = newhealth;
			}
			else
			{
				self.health = maxhealth;
			}
			health_percent = self.health / maxhealth;
			if(isdefined(self.var_134eefb9))
			{
				objective_setprogress(self.var_134eefb9, health_percent);
			}
		}
		wait(1);
	}
}

/*
	Name: function_3863cd9
	Namespace: swat_team
	Checksum: 0x99EA5DA3
	Offset: 0x3648
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_3863cd9(swat)
{
	var_1f2328d0 = swat function_4794d6a3();
	if(isdefined(var_1f2328d0.node))
	{
		var_7a0aa83f = var_1f2328d0.node.origin + vectorscale(anglestoforward(var_1f2328d0.node.angles), 400);
		return var_7a0aa83f;
	}
	return undefined;
}

/*
	Name: function_b4f4603e
	Namespace: swat_team
	Checksum: 0x12367313
	Offset: 0x36E8
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b4f4603e()
{
	removeallinfluencersfromentity(self);
	level influencers::create_friendly_influencer("friend_dead", self.origin, self.team);
}

/*
	Name: function_e69272bf
	Namespace: swat_team
	Checksum: 0x89F50D71
	Offset: 0x3740
	Size: 0x1A2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e69272bf()
{
	/#
		assert(isdefined(self.script_owner));
	#/
	if(!level.teambased)
	{
		team_mask = level.spawnsystem.ispawn_teammask_free;
		enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
	}
	else
	{
		if(isdefined(self.script_owner.pers[#"team"]))
		{
			team = self.script_owner.pers[#"team"];
			team_mask = util::getteammask(team);
			enemy_teams_mask = util::getotherteamsmask(team);
		}
		else
		{
			team_mask = 0;
			enemy_teams_mask = 0;
		}
	}
	angles = self.angles;
	origin = self.origin;
	up = (0, 0, 1);
	forward = (1, 0, 0);
	self influencers::create_entity_influencer("enemy", enemy_teams_mask);
	if(level.teambased)
	{
		self influencers::create_entity_influencer("friend", team_mask);
	}
	self.influencers_created = 1;
}

/*
	Name: function_ace0a9bc
	Namespace: swat_team
	Checksum: 0x3921F24B
	Offset: 0x38F0
	Size: 0x356
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ace0a9bc()
{
	self endon(#"death");
	self.ai.var_ac89e6f6 = 1;
	self.health = 1500;
	self.maxhealth = 1500;
	self.enableterrainik = 1;
	self.ai.var_7c61677c = 1;
	self.highlyawareradius = 3000;
	self.script_accuracy = 1;
	self.var_b6eabf3b = 600;
	self.goalradius = 350;
	self.ai.var_54b19f55 = 1;
	self.sightlatency = 0;
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.ai.var_3af1add3 = &function_3863cd9;
	self laseron();
	self collidewithactors(0);
	self setplayercollision(0);
	self ai::set_behavior_attribute("useGrenades", 0);
	self function_e69272bf();
	while(true)
	{
		if(getdvarint(#"hash_6f66ef2c6ab70226", 0))
		{
			if(isdefined(self.likelyenemyposition))
			{
				/#
					recordline(self.origin, self.likelyenemyposition, (0, 0, 1), "");
					recordcircle(self.likelyenemyposition, 8, (0, 0, 1), "");
				#/
			}
			if(isdefined(self.enemy))
			{
				/#
					recordline(self.origin + vectorscale((0, 0, 1), 70), self.enemy.origin + vectorscale((0, 0, 1), 70), (1, 0, 0), "");
					recordcircle(self.enemy.origin + vectorscale((0, 0, 1), 70), 8, (1, 0, 0), "");
					if(isplayer(self.enemy))
					{
						pathdata = generatenavmeshpath(self.origin, self.enemy.origin, self);
						pathdistance = pathdata.pathdistance;
						path = pathdata.pathpoints;
						path::function_3c367117(path, (0, 0, 1), (1, 0, 0), (1, 0.5, 0));
					}
				#/
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_8fa2faa5
	Namespace: swat_team
	Checksum: 0x5C563560
	Offset: 0x3C50
	Size: 0x1D0
	Parameters: 3
	Flags: Linked, Private
*/
function private function_8fa2faa5(swat, helicopter, position)
{
	swat endon(#"death", #"stop_riding");
	helicopter endon(#"death", #"hash_216c905d79c8bbea");
	level endon(#"game_ended");
	ride_anim = undefined;
	switch(position)
	{
		case 0:
		{
			ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_01_idle";
			break;
		}
		case 1:
		{
			ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_02_idle";
			break;
		}
		case 2:
		{
			ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_03_idle";
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
	/#
		assert(isdefined(ride_anim));
	#/
	if(isdefined(ride_anim))
	{
		while(true)
		{
			if(isalive(swat) && swat hasanimtree())
			{
				swat animation::play(ride_anim, helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
			}
		}
	}
}

/*
	Name: function_67260255
	Namespace: swat_team
	Checksum: 0xCB373088
	Offset: 0x3E28
	Size: 0x244
	Parameters: 3
	Flags: Linked, Private
*/
function private function_67260255(swat, helicopter, killstreak_id)
{
	swat endon(#"swat_landed", #"death");
	helicopter endon(#"death");
	params = undefined;
	params = helicopter waittill(#"hash_216c905d79c8bbea");
	if(isdefined(swat.script_owner))
	{
		swat.script_owner notify(#"hash_216c905d79c8bbea");
		swat.script_owner notify(#"payload_fail");
	}
	if(isdefined(swat.ai) && !swat.ai.var_f185cb34 === 1 && !isdefined(helicopter.var_7faf41b4))
	{
		helicopter.var_7faf41b4 = 1;
		if(isdefined(helicopter.owner))
		{
			helicopter.owner globallogic_audio::play_taacom_dialog("destroyed", "swat_team");
		}
		if(isdefined(params) && isplayer(params.attacker))
		{
			luinotifyevent(#"player_callout", 2, #"hash_6aba3ca683926a75", params.attacker.entnum);
		}
	}
	swat unlink();
	swat startragdoll();
	swat kill(swat.origin, undefined, undefined, undefined, 0, 1);
	function_d4331865(helicopter.rope);
}

/*
	Name: function_ab6f69a1
	Namespace: swat_team
	Checksum: 0xD146112
	Offset: 0x4078
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ab6f69a1(swat)
{
	swat endon(#"swat_landed");
	swat waittill(#"death");
	if(isdefined(swat) && !function_3132f113(swat))
	{
		swat unlink();
		swat startragdoll();
	}
}

/*
	Name: swat_deploy
	Namespace: swat_team
	Checksum: 0x136414F5
	Offset: 0x4110
	Size: 0x388
	Parameters: 5
	Flags: Linked
*/
function swat_deploy(swat, helicopter, position, var_a298d55b, var_eead001f)
{
	swat endon(#"death");
	level endon(#"game_ended");
	deploy_anim = undefined;
	switch(position)
	{
		case 0:
		{
			deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_01";
			break;
		}
		case 1:
		{
			deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_02";
			break;
		}
		case 2:
		{
			deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_03";
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
	/#
		assert(isdefined(deploy_anim));
	#/
	swat notify(#"stop_riding");
	swat pathmode("dont move");
	if(isalive(swat) && swat hasanimtree() && isdefined(deploy_anim))
	{
		swat animation::play(deploy_anim, helicopter.origin, helicopter.angles, 1.2, 0.2, 0.3, undefined, undefined, undefined, 0);
	}
	swat unlink();
	if(var_eead001f)
	{
		swat thread registerrein_amb("swat_arrive");
	}
	aiutility::removeaioverridedamagecallback(swat, &function_e588f057);
	aiutility::addaioverridedamagecallback(swat, &function_47cf421e);
	if(!ispointonnavmesh(self.origin, self))
	{
		point = getclosestpointonnavmesh(swat.origin, 100);
		if(isdefined(point))
		{
			swat forceteleport(point);
		}
	}
	swat.ignoreall = 0;
	swat.ignoreme = 0;
	swat pathmode("move allowed");
	if(isdefined(var_a298d55b))
	{
		if(ispathnode(var_a298d55b))
		{
			swat setgoal(var_a298d55b);
			swat usecovernode(var_a298d55b);
		}
		else if(isvec(var_a298d55b))
		{
			swat setgoal(var_a298d55b);
		}
	}
	swat notify(#"swat_landed");
}

/*
	Name: function_8de67419
	Namespace: swat_team
	Checksum: 0x9E9DA71E
	Offset: 0x44A0
	Size: 0x166
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8de67419(leavenode)
{
	self endon(#"death");
	radius = distance(self.origin, leavenode.origin);
	var_a9a839e2 = getclosestpointonnavvolume(leavenode.origin, "navvolume_big", radius);
	if(isdefined(var_a9a839e2))
	{
		self function_9ffc1856(var_a9a839e2, 0);
		while(true)
		{
			/#
				recordsphere(var_a9a839e2, 8, (0, 0, 1), "");
			#/
			var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");
			if(!var_baa92af9)
			{
				self function_60d50ea4();
				self notify(#"hash_2bf34763927dd61b");
				break;
			}
			waitframe(1);
		}
	}
	else
	{
		self function_60d50ea4();
		self notify(#"hash_2bf34763927dd61b");
	}
}

/*
	Name: function_9fe56d0b
	Namespace: swat_team
	Checksum: 0x4D388118
	Offset: 0x4610
	Size: 0x484
	Parameters: 1
	Flags: Linked
*/
function function_9fe56d0b(helicopter)
{
	helicopter notify(#"leaving");
	helicopter notify(#"heli_leave");
	helicopter.leaving = 1;
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](helicopter, 0);
	}
	leavenode = helicopter::getvalidrandomleavenode(helicopter.origin);
	var_b4c35bb7 = leavenode.origin;
	heli_reset();
	helicopter vehclearlookat();
	exitangles = vectortoangles(var_b4c35bb7 - helicopter.origin);
	helicopter setgoalyaw(exitangles[1]);
	var_e60e2941 = helicopter.var_e60e2941;
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		if(!ispointinnavvolume(helicopter.origin, "navvolume_big"))
		{
			if(issentient(helicopter))
			{
				helicopter function_60d50ea4();
			}
			radius = distance(self.origin, leavenode.origin);
			var_a9a839e2 = getclosestpointonnavvolume(helicopter.origin, "navvolume_big", radius);
			if(isdefined(var_a9a839e2))
			{
				helicopter function_9ffc1856(var_a9a839e2, 0);
				while(true)
				{
					/#
						recordsphere(var_a9a839e2, 8, (0, 0, 1), "");
					#/
					var_baa92af9 = ispointinnavvolume(helicopter.origin, "navvolume_big");
					if(var_baa92af9)
					{
						helicopter makesentient();
						break;
					}
					waitframe(1);
				}
			}
		}
		if(!ispointinnavvolume(leavenode.origin, "navvolume_big"))
		{
			helicopter thread function_8de67419(leavenode);
			helicopter waittill(#"hash_2bf34763927dd61b", #"death");
		}
	}
	if(isdefined(helicopter))
	{
		helicopter function_9ffc1856(var_b4c35bb7, 1);
		helicopter waittilltimeout(20, #"near_goal", #"death");
	}
	if(isdefined(var_e60e2941))
	{
		for(i = var_e60e2941.size; i >= 0; i--)
		{
			if(isdefined(var_e60e2941[i]) && isalive(var_e60e2941[i]))
			{
				var_e60e2941[i] delete();
			}
		}
	}
	if(isdefined(helicopter))
	{
		helicopter stoploopsound(1);
		helicopter util::death_notify_wrapper();
		if(isdefined(helicopter.alarm_snd_ent))
		{
			helicopter.alarm_snd_ent stoploopsound();
			helicopter.alarm_snd_ent delete();
			helicopter.alarm_snd_ent = undefined;
		}
		helicopter delete();
	}
}

/*
	Name: function_5ca48510
	Namespace: swat_team
	Checksum: 0xE90AD22E
	Offset: 0x4AA0
	Size: 0x160
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5ca48510(helicopter, var_1c996690)
{
	helicopter endon(#"death", #"heli_leave");
	level endon(#"game_ended");
	namesstruct_n = var_1c996690;
	lerp_duration = max(((helicopter.origin[2] - var_1c996690[2]) - 600) / 625, 0.8);
	helicopter animation::play("ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", namesstruct_n, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, lerp_duration);
	while(true)
	{
		helicopter animation::play("ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", namesstruct_n, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, 0.8);
	}
}

/*
	Name: heli_reset
	Namespace: swat_team
	Checksum: 0xB9725A44
	Offset: 0x4C08
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self setyawspeed(75, 45, 45);
	self setmaxpitchroll(30, 30);
}

/*
	Name: function_656691ab
	Namespace: swat_team
	Checksum: 0xCD884D5D
	Offset: 0x4C88
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_656691ab()
{
	self endon(#"death", #"abandoned");
	while(true)
	{
		var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");
		if(var_baa92af9)
		{
			heli_reset();
			self makepathfinder();
			self util::make_sentient();
			self.ignoreme = 1;
			if(isdefined(self.heligoalpos))
			{
				self function_9ffc1856(self.heligoalpos, 1);
			}
			self notify(#"hash_340ab3c2b94ff86a");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_9ffc1856
	Namespace: swat_team
	Checksum: 0x21FB270F
	Offset: 0x4DA0
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_9ffc1856(goalpos, stop)
{
	self.heligoalpos = goalpos;
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		if(issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big"))
		{
			self setgoal(goalpos, stop);
			self function_a57c34b7(goalpos, stop, 1);
		}
		else
		{
			self function_a57c34b7(goalpos, stop, 0);
		}
	}
	else
	{
		self setgoal(goalpos, stop);
	}
}

/*
	Name: function_67c394f2
	Namespace: swat_team
	Checksum: 0x80056BD7
	Offset: 0x4EC0
	Size: 0x3A8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_67c394f2(helicopter, destination)
{
	helicopter endon(#"death");
	var_7f4a508d = destination;
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		helicopter thread function_656691ab();
		if(!ispointinnavvolume(var_7f4a508d, "navvolume_big"))
		{
			var_a9a839e2 = getclosestpointonnavvolume(destination, "navvolume_big", 10000);
			var_7f4a508d = (var_a9a839e2[0], var_a9a839e2[1], destination[2]);
			if(isdefined(var_7f4a508d))
			{
				helicopter function_9ffc1856(var_7f4a508d, 1);
				helicopter.var_7f4a508d = var_7f4a508d;
				if(!ispointinnavvolume(var_7f4a508d, "navvolume_big"))
				{
					self waittilltimeout(10, #"hash_340ab3c2b94ff86a");
				}
			}
		}
		self function_9ffc1856(var_7f4a508d, 1);
		self waittill(#"near_goal");
	}
	else
	{
		helicopter thread airsupport::setgoalposition(destination, "swat_heli_reached", 1);
		helicopter waittill(#"swat_heli_reached");
	}
	last_distance_from_goal_squared = 9999999 * 9999999;
	continue_waiting = 1;
	for(remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--)
	{
		current_distance_from_goal_squared = distance2dsquared(helicopter.origin, destination);
		continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > (4 * 4);
		last_distance_from_goal_squared = current_distance_from_goal_squared;
		/#
			if(getdvarint(#"swat_debug", 0))
			{
				sphere(destination, 8, (1, 0, 0), 0.9, 0, 20, 1);
			}
		#/
		if(continue_waiting)
		{
			/#
				if(getdvarint(#"swat_debug", 0))
				{
					iprintln("" + distance2d(helicopter.origin, destination));
				}
			#/
			waitframe(1);
		}
	}
	/#
		if(getdvarint(#"swat_debug", 0))
		{
			iprintln("" + distance2d(helicopter.origin, destination));
		}
	#/
	helicopter notify(#"reached_destination");
}

/*
	Name: swat_helicopter_explode
	Namespace: swat_team
	Checksum: 0x42B00F43
	Offset: 0x5270
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function swat_helicopter_explode(helicopter)
{
	helicopter helicopter::function_e1058a3e();
	wait(0.1);
	if(isdefined(helicopter))
	{
		helicopter delete();
	}
}

/*
	Name: spawn_swat_helicopter
	Namespace: swat_team
	Checksum: 0x668830DD
	Offset: 0x52C8
	Size: 0x2A0
	Parameters: 4
	Flags: Linked, Private
*/
function private spawn_swat_helicopter(owner, origin, angles, context)
{
	helicopter = spawnvehicle("vehicle_t8_mil_helicopter_swat_transport", origin, angles, "swat_helicopter");
	helicopter setowner(owner);
	helicopter thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
	helicopter.spawntime = gettime();
	helicopter clientfield::set("enemyvehicle", 1);
	helicopter.attackers = [];
	helicopter.attackerdata = [];
	helicopter.attackerdamage = [];
	helicopter.flareattackerdamage = [];
	helicopter.killstreak_id = context.killstreak_id;
	helicopter setdrawinfrared(1);
	helicopter.allowcontinuedlockonafterinvis = 1;
	helicopter.soundmod = "heli";
	helicopter.identifier_weapon = getweapon("player_air_vehicle1_main_turret_3rd_person_swat");
	var_9a1bcc5b = 128;
	helicopter setneargoalnotifydist(var_9a1bcc5b);
	helicopter.maxhealth = level.heli_maxhealth;
	helicopter.health = level.heli_maxhealth;
	helicopter.overridevehicledamage = &function_11038a4a;
	helicopter killstreaks::configure_team("swat_team", context.killstreak_id, owner);
	context.helicopter = helicopter;
	helicopter.numflares = 1;
	helicopter thread helicopter::create_flare_ent(vectorscale((0, 0, -1), 100));
	helicopter.target_offset = vectorscale((0, 0, -1), 25);
	target_set(helicopter, vectorscale((0, 0, -1), 25));
	helicopter setrotorspeed(1);
	return helicopter;
}

/*
	Name: function_11038a4a
	Namespace: swat_team
	Checksum: 0x8A78537B
	Offset: 0x5570
	Size: 0x1C0
	Parameters: 15
	Flags: Linked
*/
function function_11038a4a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	helicopter = self;
	if(smeansofdeath == "MOD_TRIGGER_HURT")
	{
		return 0;
	}
	idamage = self killstreaks::ondamageperweapon("swat_team", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.lowhealth, undefined, 0, undefined, 1, 1);
	/#
		if(getdvarint(#"hash_2272264bb18906ce", 0))
		{
			idamage = self.health + 1;
		}
	#/
	if(idamage >= self.health)
	{
		self.health = idamage + 1;
		helicopter.overridevehicledamage = undefined;
		helicopter notify(#"hash_216c905d79c8bbea", {#attacker:eattacker});
		function_d4331865(helicopter.rope);
		helicopter thread swat_helicopter_explode(helicopter);
	}
	return idamage;
}

/*
	Name: function_ab26fd70
	Namespace: swat_team
	Checksum: 0x74B033D
	Offset: 0x5738
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ab26fd70(helicopter)
{
	/#
		assert(!isdefined(helicopter.rope));
	#/
	helicopter.rope = spawn("script_model", helicopter.origin);
	/#
		assert(isdefined(helicopter.rope));
	#/
	helicopter.rope useanimtree("generic");
	helicopter.rope setmodel("p8_fxanim_gp_vehicle_lb_swat_rappel_mod");
	helicopter.rope linkto(helicopter, "tag_origin");
	helicopter.rope hide();
}

/*
	Name: function_61baa879
	Namespace: swat_team
	Checksum: 0x2F228A00
	Offset: 0x5850
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
function private function_61baa879(helicopter)
{
	if(!isdefined(helicopter.rope))
	{
		return;
	}
	helicopter endon(#"hash_216c905d79c8bbea", #"death");
	helicopter.rope endon(#"death");
	helicopter.rope show();
	helicopter endon(#"hash_216c905d79c8bbea", #"death");
	level endon(#"game_ended");
	helicopter.rope animation::play("p8_fxanim_gp_vehicle_lb_swat_rappel_start_anim", helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
}

/*
	Name: function_b7ec43e
	Namespace: swat_team
	Checksum: 0x4C8F5AE0
	Offset: 0x5960
	Size: 0x3C
	Parameters: 1
	Flags: Private
*/
function private function_b7ec43e(rope)
{
	rope endon(#"death");
	if(isdefined(rope))
	{
		rope delete();
	}
}

/*
	Name: function_21f27c75
	Namespace: swat_team
	Checksum: 0x9C8BFD7D
	Offset: 0x59A8
	Size: 0x114
	Parameters: 1
	Flags: Linked, Private
*/
function private function_21f27c75(helicopter)
{
	level endon(#"game_ended");
	if(!isdefined(helicopter.rope))
	{
		return;
	}
	helicopter endon(#"hash_216c905d79c8bbea", #"death");
	helicopter.rope endon(#"death");
	rope = helicopter.rope;
	helicopter notify(#"hash_6d5d50a125188a1b");
	helicopter.rope thread animation::play("p8_fxanim_gp_vehicle_lb_swat_rappel_drop_anim", helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	wait(0.5);
	function_d4331865(rope);
}

/*
	Name: function_d4331865
	Namespace: swat_team
	Checksum: 0x630CAA71
	Offset: 0x5AC8
	Size: 0x2E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d4331865(rope)
{
	if(isdefined(rope))
	{
		rope delete();
		return;
	}
}

/*
	Name: function_47cf421e
	Namespace: swat_team
	Checksum: 0xEA980CF2
	Offset: 0x5B00
	Size: 0x120
	Parameters: 12
	Flags: Linked
*/
function function_47cf421e(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	bundle = getscriptbundle("killstreak_swat_team");
	chargelevel = 0;
	weapon_damage = killstreak_bundles::get_weapon_damage("swat_team", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
	}
	self thread function_2765a1f0(meansofdeath);
	return weapon_damage;
}

/*
	Name: function_cc3b1643
	Namespace: swat_team
	Checksum: 0x163BF8C0
	Offset: 0x5C28
	Size: 0x52
	Parameters: 3
	Flags: Linked
*/
function function_cc3b1643(weapon, shitloc, smeansofdeath)
{
	if(!isdefined(shitloc))
	{
		return false;
	}
	if(shitloc != "head" && shitloc != "helmet")
	{
		return false;
	}
	return true;
}

/*
	Name: function_e588f057
	Namespace: swat_team
	Checksum: 0x64A80124
	Offset: 0x5C88
	Size: 0x142
	Parameters: 12
	Flags: Linked
*/
function function_e588f057(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && attacker.team != self.team)
	{
		var_b25a1274 = function_cc3b1643(weapon, hitloc, meansofdeath);
		if(var_b25a1274)
		{
			damage = damage * 1.2;
		}
		else
		{
			damage = damage * 0.3;
		}
		if(damage < 0)
		{
			damage = 0;
		}
	}
	damage = self killstreaks::ondamageperweapon("swat_team", attacker, damage, idflags, meansofdeath, weapon, self.maxhealth, undefined, self.lowhealth, undefined, 0, undefined, 1, 1);
	return damage;
}

/*
	Name: function_7fac6670
	Namespace: swat_team
	Checksum: 0x8F2AB0CC
	Offset: 0x5DD8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_7fac6670(swat_gunner)
{
	swat_gunner.blindaim = 1;
	swat_gunner.script_accuracy = 0.99;
	swat_gunner.var_b6eabf3b = 400;
}

/*
	Name: function_ab667e1c
	Namespace: swat_team
	Checksum: 0xE580C2D
	Offset: 0x5E20
	Size: 0x334
	Parameters: 2
	Flags: Linked
*/
function function_ab667e1c(owner, helicopter)
{
	/#
		assert(isdefined(owner.swat_team));
	#/
	/#
		assert(isdefined(helicopter));
	#/
	aitypes = level.var_1e18ffa0[#"axis"];
	if(isdefined(owner.team) && owner.team == #"allies")
	{
		aitypes = level.var_1e18ffa0[#"allies"];
	}
	owner.var_e60e2941 = [];
	helicopter.var_e60e2941 = [];
	swat_gunner = spawnactor(aitypes[0], helicopter.origin, (0, 0, 0), "swat_gunner");
	swat_gunner linkto(helicopter, "tag_driver", (0, 0, 0), (0, 0, 0));
	swat_gunner.ai.var_f185cb34 = 1;
	if(!isdefined(owner.var_e60e2941))
	{
		owner.var_e60e2941 = [];
	}
	else if(!isarray(owner.var_e60e2941))
	{
		owner.var_e60e2941 = array(owner.var_e60e2941);
	}
	owner.var_e60e2941[owner.var_e60e2941.size] = swat_gunner;
	if(!isdefined(helicopter.var_e60e2941))
	{
		helicopter.var_e60e2941 = [];
	}
	else if(!isarray(helicopter.var_e60e2941))
	{
		helicopter.var_e60e2941 = array(helicopter.var_e60e2941);
	}
	helicopter.var_e60e2941[helicopter.var_e60e2941.size] = swat_gunner;
	swat_gunner setentityowner(self);
	swat_gunner setteam(owner.team);
	swat_gunner.ignoreall = 1;
	swat_gunner.ignoreme = 1;
	swat_gunner.ai.swat_gunner = 1;
	swat_gunner ai::gun_remove();
	swat_gunner function_7fac6670(swat_gunner);
	swat_gunner thread function_416a0a80(owner);
	swat_gunner thread function_67260255(swat_gunner, helicopter);
}

/*
	Name: function_a543b380
	Namespace: swat_team
	Checksum: 0x78A9B2A9
	Offset: 0x6160
	Size: 0x22E
	Parameters: 1
	Flags: Linked
*/
function function_a543b380(player)
{
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return false;
	}
	if(self.owner === player)
	{
		return false;
	}
	if(player.team == self.team)
	{
		return false;
	}
	if(player.team == #"spectator")
	{
		return false;
	}
	if(!player playerads())
	{
		return false;
	}
	weapon = player getcurrentweapon();
	if(!isdefined(weapon) || !isdefined(weapon.rootweapon))
	{
		return false;
	}
	if(weapon.rootweapon != getweapon(#"shotgun_semiauto_t8"))
	{
		return false;
	}
	if(!weaponhasattachment(weapon, "uber"))
	{
		return false;
	}
	distsq = distancesquared(self.origin, player.origin);
	if(distsq > 900 * 900)
	{
		return false;
	}
	if(!util::within_fov(self.origin, self.angles, player.origin, cos(45)))
	{
		return false;
	}
	if(!util::within_fov(player.origin, player getplayerangles(), self.origin, cos(45)))
	{
		return false;
	}
	return true;
}

/*
	Name: function_18a9058c
	Namespace: swat_team
	Checksum: 0xA8339232
	Offset: 0x6398
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_18a9058c()
{
	self endon(#"death");
	self.ai.var_e90b47c1 = gettime();
	while(isalive(self))
	{
		if(isdefined(self.ai.var_e90b47c1) && gettime() <= self.ai.var_e90b47c1)
		{
			wait(1);
			continue;
		}
		players = getplayers();
		foreach(player in players)
		{
			if(!function_a543b380(player))
			{
				continue;
			}
			if(self cansee(player))
			{
				self.health = self.health + 1;
				self dodamage(1, player.origin, undefined, undefined, "torso_lower", "MOD_UNKNOWN", 0, getweapon("eq_swat_grenade"), 0, 1);
				self.ai.var_e90b47c1 = gettime() + randomintrange(6000, 13000);
				break;
			}
		}
		wait(1);
	}
}

/*
	Name: function_75277c27
	Namespace: swat_team
	Checksum: 0x91E7B93F
	Offset: 0x6578
	Size: 0x96
	Parameters: 2
	Flags: Linked, Private
*/
function private function_75277c27(tacpoint, context)
{
	if(tacpoint.ceilingheight >= 4000)
	{
		/#
			recordsphere(tacpoint.origin, 2, (0, 1, 0), "");
		#/
		return true;
	}
	/#
		recordsphere(tacpoint.origin, 2, (1, 0, 0), "");
	#/
	return false;
}

/*
	Name: function_7d90f954
	Namespace: swat_team
	Checksum: 0x8506C091
	Offset: 0x6618
	Size: 0xA6
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7d90f954(origin, context)
{
	if(ispointonnavmesh(origin, 45))
	{
		/#
			recordsphere(origin + vectorscale((0, 0, 1), 10), 2, (0, 1, 0), "");
		#/
		return true;
	}
	/#
		recordsphere(origin + vectorscale((0, 0, 1), 10), 2, (1, 0, 0), "");
	#/
	return false;
}

/*
	Name: function_9153c267
	Namespace: swat_team
	Checksum: 0x87ECA7A4
	Offset: 0x66C8
	Size: 0x104
	Parameters: 3
	Flags: Linked, Private
*/
function private function_9153c267(origin, context, verticaloffset)
{
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		destination = origin + (0, 0, verticaloffset);
		var_baa92af9 = ispointinnavvolume(destination, "navvolume_big");
		if(var_baa92af9)
		{
			/#
				recordsphere(origin + vectorscale((0, 0, 1), 20), 2, (0, 1, 0), "");
			#/
			return true;
		}
		/#
			recordsphere(origin + vectorscale((0, 0, 1), 20), 2, (1, 0, 0), "");
		#/
		return false;
	}
	return true;
}

/*
	Name: function_accec5c5
	Namespace: swat_team
	Checksum: 0x73103D18
	Offset: 0x67D8
	Size: 0x160
	Parameters: 3
	Flags: Linked, Private
*/
function private function_accec5c5(origin, context, verticaloffset)
{
	if(!function_d15dd929(origin))
	{
		return false;
	}
	mask = 1;
	radius = 30;
	trace = physicstrace(origin + (0, 0, verticaloffset), origin + vectorscale((0, 0, 1), 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), mask);
	if(trace[#"fraction"] < 1)
	{
		/#
			recordsphere(origin + vectorscale((0, 0, 1), 20), 2, (1, 0, 0), "");
		#/
		return false;
	}
	/#
		recordsphere(origin + vectorscale((0, 0, 1), 20), 2, (0, 1, 0), "");
	#/
	return true;
}

/*
	Name: function_d15dd929
	Namespace: swat_team
	Checksum: 0x4873CB77
	Offset: 0x6940
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function function_d15dd929(origin)
{
	result = function_9cc082d2(origin + vectorscale((0, 0, 1), 100), 200);
	if(isdefined(result[#"materialflags"]) && result[#"materialflags"] & 2)
	{
		return false;
	}
	if(!ispointonnavmesh(origin, 16, 1))
	{
		return false;
	}
	return true;
}

/*
	Name: debug_water
	Namespace: swat_team
	Checksum: 0xBB2D6B3C
	Offset: 0x69E8
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function debug_water(tpoint)
{
	/#
		if(!function_d15dd929(tpoint.origin))
		{
			/#
				record3dtext("", tpoint.origin + vectorscale((0, 0, 1), 40), (1, 1, 1), "");
			#/
			/#
				recordline(tpoint.origin + vectorscale((0, 0, 1), 40), tpoint.origin, (1, 1, 1), "");
			#/
		}
	#/
}

/*
	Name: function_6dc6bc6b
	Namespace: swat_team
	Checksum: 0xBDAB3CFC
	Offset: 0x6AB0
	Size: 0xF2
	Parameters: 3
	Flags: Linked
*/
function function_6dc6bc6b(origins, context, verticaloffset)
{
	/#
		assert(isdefined(origins) && origins.size);
	#/
	filteredpoints = [];
	foreach(origin in origins)
	{
		if(function_accec5c5(origin, context, verticaloffset))
		{
			filteredpoints[filteredpoints.size] = origin;
			break;
		}
		waitframe(1);
	}
	return filteredpoints;
}

/*
	Name: function_fc826e6
	Namespace: swat_team
	Checksum: 0x4907B75A
	Offset: 0x6BB0
	Size: 0x148
	Parameters: 3
	Flags: Linked, Private
*/
function private function_fc826e6(tacpoints, context, verticaloffset)
{
	/#
		assert(isdefined(tacpoints) && tacpoints.size);
	#/
	filteredpoints = [];
	foreach(tacpoint in tacpoints)
	{
		/#
			debug_water(tacpoint);
		#/
		if(function_75277c27(tacpoint, context) && function_7d90f954(tacpoint.origin, context) && function_9153c267(tacpoint.origin, context, verticaloffset))
		{
			filteredpoints[filteredpoints.size] = tacpoint.origin;
		}
	}
	return filteredpoints;
}

/*
	Name: function_187f6d8f
	Namespace: swat_team
	Checksum: 0xD8E3CD62
	Offset: 0x6D00
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_187f6d8f(tacpoints)
{
	/#
		assert(isdefined(tacpoints) && tacpoints.size);
	#/
	points = [];
	foreach(tacpoint in tacpoints)
	{
		points[points.size] = tacpoint.origin;
	}
	return points;
}

/*
	Name: function_3b759619
	Namespace: swat_team
	Checksum: 0x5679455D
	Offset: 0x6DC8
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_3b759619(var_1c996690)
{
	result = function_9cc082d2(var_1c996690 + vectorscale((0, 0, 1), 100), 200);
	if(isdefined(result))
	{
		return true;
	}
	return false;
}

/*
	Name: function_263d3e9e
	Namespace: swat_team
	Checksum: 0xD3B896B3
	Offset: 0x6E20
	Size: 0x3F8
	Parameters: 4
	Flags: Linked
*/
function function_263d3e9e(var_1c996690, context, owner, var_9f26686a = 0)
{
	if(getdvarint(#"hash_60d47d611bbc3bed", 1))
	{
		if(!function_3b759619(var_1c996690))
		{
			var_986a13c3 = getclosesttacpoint(var_1c996690);
			if(isdefined(var_986a13c3))
			{
				var_1c996690 = var_986a13c3.origin;
			}
		}
		verticaloffset = getstartorigin(var_1c996690, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2")[2] - var_1c996690[2];
		if(function_7d90f954(var_1c996690, context) && function_9153c267(var_1c996690, context, verticaloffset))
		{
			if(function_accec5c5(var_1c996690, context, verticaloffset))
			{
				return var_1c996690;
			}
		}
		cylinder = ai::t_cylinder(var_1c996690, 2000, 200);
		var_68860686 = ai::t_cylinder(var_1c996690, 100, 200);
		tacpoints = tacticalquery("swat_team_deploy", var_1c996690, cylinder, var_68860686);
		var_c65dd8e7 = undefined;
		if(isdefined(tacpoints) && tacpoints.size)
		{
			var_c65dd8e7 = arraycopy(tacpoints);
			tacpoints = function_fc826e6(tacpoints, context, verticaloffset);
			waitframe(1);
			if(tacpoints.size)
			{
				tacpoints = arraysortclosest(tacpoints, var_1c996690);
				filteredpoints = function_6dc6bc6b(tacpoints, context, verticaloffset);
				if(isdefined(filteredpoints[0]))
				{
					/#
						recordsphere(filteredpoints[0] + vectorscale((0, 0, 1), 70), 4, (1, 0.5, 0), "");
					#/
					return filteredpoints[0];
				}
				var_c71b63fa = arraygetclosest(var_1c996690, tacpoints);
				/#
					recordsphere(var_c71b63fa + vectorscale((0, 0, 1), 70), 4, (0, 1, 1), "");
				#/
				return var_c71b63fa;
			}
		}
		if(!var_9f26686a && isdefined(var_c65dd8e7) && var_c65dd8e7.size)
		{
			points = function_187f6d8f(var_c65dd8e7);
			if(isdefined(points))
			{
				var_54746e33 = arraygetfarthest(var_1c996690, points);
				if(isdefined(var_54746e33))
				{
					/#
						recordsphere(var_54746e33, 4, (0, 1, 1), "");
					#/
					return function_263d3e9e(var_54746e33, context, owner, 1);
				}
			}
		}
	}
	return var_1c996690;
}

/*
	Name: function_fe13a227
	Namespace: swat_team
	Checksum: 0xD525E474
	Offset: 0x7220
	Size: 0xF6
	Parameters: 3
	Flags: None
*/
function function_fe13a227(helicopter, var_1c996690, destination)
{
	helicopter endon(#"death", #"payload_delivered", #"hash_216c905d79c8bbea");
	while(true)
	{
		/#
			recordsphere(var_1c996690, 4, (1, 0.5, 0), "");
			recordsphere(destination, 4, (1, 0.5, 0), "");
			recordline(var_1c996690, destination, (1, 0.5, 0), "");
		#/
		waitframe(1);
	}
}

/*
	Name: function_2bade425
	Namespace: swat_team
	Checksum: 0x85877A5F
	Offset: 0x7320
	Size: 0x2C6
	Parameters: 2
	Flags: Linked
*/
function function_2bade425(owner, helicopter)
{
	aitypes = level.var_1e18ffa0[#"axis"];
	if(isdefined(owner.team) && owner.team == #"allies")
	{
		aitypes = level.var_1e18ffa0[#"allies"];
	}
	for(i = 0; i < 2; i++)
	{
		swat = spawnactor(aitypes[i], vectorscale((-1, 0, 0), 1000), (0, 0, 0), "swat");
		if(!isdefined(self.swat_team))
		{
			self.swat_team = [];
		}
		else if(!isarray(self.swat_team))
		{
			self.swat_team = array(self.swat_team);
		}
		self.swat_team[self.swat_team.size] = swat;
		swat setentityowner(self);
		swat setteam(self.team);
		swat.ignoreall = 1;
		swat.ignoreme = 1;
		swat clientfield::set("enemyvehicle", 1);
		obj_set("swat_member", swat);
		swat.ai.var_2b570fa6 = "parametric_traverse@traversal";
		if(self.team == #"allies")
		{
			if(i == 0)
			{
				swat.voxid = 2;
			}
			else
			{
				swat.voxid = 3;
			}
		}
		else
		{
			if(i == 0)
			{
				swat.voxid = 1;
			}
			else
			{
				swat.voxid = 4;
			}
		}
		swat pathmode("dont move");
		swat callback::function_d8abfc3d(#"on_ai_killed", &function_d86da2e8);
	}
}

/*
	Name: function_820e7c92
	Namespace: swat_team
	Checksum: 0xDB9C47F0
	Offset: 0x75F0
	Size: 0x600
	Parameters: 4
	Flags: Linked, Private
*/
function private function_820e7c92(owner, var_1c996690, nodes, context)
{
	owner endoncallback(&function_d524c2b8, #"disconnect", #"joined_team", #"joined_spectators");
	level endon(#"game_ended");
	/#
		assert(isdefined(var_1c996690));
	#/
	var_1c996690 = function_263d3e9e(var_1c996690, context, owner);
	destination = getstartorigin(var_1c996690, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
	var_6aa266d6 = helicopter::getvalidrandomstartnode(destination).origin;
	helicopter = spawn_swat_helicopter(owner, var_6aa266d6, vectortoangles(owner.origin - var_6aa266d6), context);
	helicopter endon(#"death", #"hash_216c905d79c8bbea");
	helicopter.hardpointtype = "swat_team";
	/#
		helicopter thread function_fe13a227(helicopter, var_1c996690, destination);
	#/
	function_ab667e1c(owner, helicopter);
	function_2bade425(owner, helicopter);
	function_ab26fd70(helicopter);
	/#
		assert(isdefined(owner.swat_team));
	#/
	position = 0;
	foreach(swat in owner.swat_team)
	{
		if(isdefined(swat) && !function_3132f113(swat))
		{
			aiutility::addaioverridedamagecallback(swat, &function_e588f057);
			swat linkto(helicopter, "tag_origin", (0, 0, 0), (0, 0, 0));
			swat thread function_8fa2faa5(swat, helicopter, position);
			swat thread function_ab6f69a1(swat);
			swat thread function_18a9058c();
			owner thread function_67260255(swat, helicopter, context.killstreak_id);
			position++;
		}
	}
	helicopter thread function_67c394f2(helicopter, destination);
	helicopter waittill(#"reached_destination");
	if(isdefined(context.ir_model))
	{
		context.ir_model notify(#"hash_1e4c945d50deb21d");
	}
	helicopter thread function_5ca48510(helicopter, var_1c996690);
	wait_start = gettime();
	while((helicopter.origin[2] - var_1c996690[2]) > 620 && (gettime() - wait_start) < 1000)
	{
		wait(0.1);
	}
	level thread function_61baa879(helicopter);
	position = 0;
	foreach(swat in owner.swat_team)
	{
		if(isdefined(swat) && !function_3132f113(swat) && isalive(swat))
		{
			if(position == 0)
			{
				swat thread swat_deploy(swat, helicopter, position, nodes[position], 1);
			}
			else
			{
				swat thread swat_deploy(swat, helicopter, position, nodes[position], 0);
			}
		}
		position++;
	}
	wait(6.4);
	helicopter thread function_21f27c75(helicopter);
	context.deployed = 1;
	helicopter thread function_9fe56d0b(helicopter);
	helicopter notify(#"payload_delivered");
	owner notify(#"payload_delivered");
}

/*
	Name: function_5479b133
	Namespace: swat_team
	Checksum: 0x8A164C00
	Offset: 0x7BF8
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_5479b133(team, killstreak_id)
{
	self endon(#"payload_delivered", #"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
	self waittill(#"payload_fail");
	if(isdefined(self.var_6c0553ea.deployed) && self.var_6c0553ea.deployed)
	{
		return;
	}
	self stopkillstreak(self.var_6c0553ea);
}

/*
	Name: function_2765a1f0
	Namespace: swat_team
	Checksum: 0xDFB7AA51
	Offset: 0x7CC8
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function function_2765a1f0(meansofdeath)
{
	if(!isdefined(self.ai.var_826ef4c7))
	{
		self.ai.var_826ef4c7 = gettime();
	}
	vo_type = "generic_pain";
	if(meansofdeath === "MOD_MELEE" || meansofdeath === "MOD_MELEE_WEAPON_BUTT")
	{
		vo_type = "stab_pain";
	}
	else if(isdefined(self.var_40543c03))
	{
		switch(self.var_40543c03)
		{
			case "fire":
			{
				vo_type = "fire_pain";
				break;
			}
			case "flash":
			case "emp":
			case "electrical":
			{
				vo_type = "flash_pain";
				break;
			}
		}
	}
	if(gettime() >= self.ai.var_826ef4c7)
	{
		self thread registerrein_amb(vo_type);
		self.ai.var_826ef4c7 = randomintrange(2000, 3500);
	}
}

/*
	Name: registerrein_amb
	Namespace: swat_team
	Checksum: 0xA1EA40EF
	Offset: 0x7E28
	Size: 0x60A
	Parameters: 1
	Flags: Linked, Private
*/
function private registerrein_amb(type)
{
	self endon(#"death");
	if(!isdefined(level.var_bf13c7cf))
	{
		level.var_bf13c7cf = [];
		array::add(level.var_bf13c7cf, #"hash_2416186b2c2fd1a8");
		array::add(level.var_bf13c7cf, #"hash_5ed736ce5677e90");
		array::add(level.var_bf13c7cf, #"hash_6ac3aef794ea4b07");
	}
	if(!isdefined(level.var_afebcc7e))
	{
		level.var_afebcc7e = [];
		array::add(level.var_afebcc7e, #"hash_310164c2facacc31");
		array::add(level.var_afebcc7e, #"hash_c3ec7c69991c32d");
		array::add(level.var_afebcc7e, #"hash_44db3e21d3c99dd6");
	}
	if(!isdefined(level.var_6254ffb6))
	{
		level.var_6254ffb6 = [];
		array::add(level.var_6254ffb6, #"hash_656973028d759c26");
		array::add(level.var_6254ffb6, #"hash_1239ec12044b3fd6");
		array::add(level.var_6254ffb6, #"hash_590e7ce5d23bd0f5");
	}
	if(!isdefined(level.var_383a6948))
	{
		level.var_383a6948 = [];
		array::add(level.var_383a6948, #"hash_44e29c9d2df27e17");
		array::add(level.var_383a6948, #"hash_25c2538c4892d193");
		array::add(level.var_383a6948, #"hash_1af511ba5412916c");
	}
	if(!isdefined(self.voxid))
	{
		return;
	}
	switch(type)
	{
		case "swat_arrive":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_arrive");
			break;
		}
		case "swat_destroyed":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_destroyed");
			break;
		}
		case "swat_engaging":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_engaging");
			break;
		}
		case "swat_kill":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_kill");
			break;
		}
		case "swat_ready":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_ready");
		}
		case "generic_pain":
		{
			if(self.voxid == 1)
			{
				self playsound(array::random(level.var_bf13c7cf));
			}
			else
			{
				if(self.voxid == 2)
				{
					self playsound(array::random(level.var_afebcc7e));
				}
				else
				{
					if(self.voxid == 3)
					{
						self playsound(array::random(level.var_6254ffb6));
					}
					else if(self.voxid == 4)
					{
						self playsound(array::random(level.var_383a6948));
					}
				}
			}
			break;
		}
		case "flash_pain":
		{
			if(randomint(100) > 50)
			{
				self playsound(("vox_swa" + self.voxid) + "_ult_swat_electro");
			}
			else
			{
				self playsound(("vox_swa" + self.voxid) + "_ult_swat_blind");
			}
			break;
		}
		case "fire_pain":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_burn_dead");
			break;
		}
		case "stab_pain":
		{
			self playsound(("vox_swa" + self.voxid) + "_ult_swat_stabbed");
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: spawn_swat_team
	Namespace: swat_team
	Checksum: 0xDD755B55
	Offset: 0x8440
	Size: 0x2A4
	Parameters: 3
	Flags: Linked
*/
function spawn_swat_team(owner, context, origin)
{
	if(!isdefined(owner.swat_team))
	{
		self.swat_team = [];
	}
	else
	{
		owner swat_cleanup();
		owner notify(#"hash_71a1db99eb99dcff");
	}
	owner.var_6c0553ea = context;
	owner.var_6c0553ea.kills = 0;
	owner.var_6c0553ea.clear_kills = 0;
	zone = function_5615237b(origin);
	var_1c996690 = undefined;
	nodes = [];
	owner killstreaks::play_killstreak_start_dialog("swat_team", self.team, context.killstreak_id);
	owner thread function_5479b133(owner.team, context.killstreak_id);
	if(isdefined(zone))
	{
		nodes = getnodearray(zone.target, "targetname");
		for(i = 0; i < nodes.size; i++)
		{
			if(nodes[i].type == "BAD NODE")
			{
				nodes = function_b777d194(origin);
				break;
			}
		}
	}
	else
	{
		nodes = function_b777d194(origin);
	}
	if(!isdefined(nodes))
	{
		nodes = [];
		for(i = 0; i < 2; i++)
		{
			if(!isdefined(nodes))
			{
				nodes = [];
			}
			else if(!isarray(nodes))
			{
				nodes = array(nodes);
			}
			nodes[nodes.size] = (0, 0, 0);
		}
	}
	var_1c996690 = origin;
	owner thread swat_loop(context.killstreak_id);
	owner function_820e7c92(owner, var_1c996690, nodes, context);
}

/*
	Name: function_d1c52e08
	Namespace: swat_team
	Checksum: 0x45C7F47C
	Offset: 0x86F0
	Size: 0xB0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1c52e08()
{
	self endon(#"death");
	while(true)
	{
		waittillframeend();
		if(isdefined(self.enemy) && isplayer(self.enemy) && self cansee(self.enemy))
		{
			self.holdfire = !self targetting_delay::function_1c169b3a(self.enemy);
		}
		else
		{
			self.holdfire = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_48d57bc8
	Namespace: swat_team
	Checksum: 0x54449CCC
	Offset: 0x87A8
	Size: 0x1AE
	Parameters: 0
	Flags: Linked
*/
function function_48d57bc8()
{
	self endon(#"death");
	if(isdefined(level.var_a6a32c8a) && level.var_a6a32c8a)
	{
		return;
	}
	if(isactor(self) && self.archetype === #"human")
	{
		laser_weapon = getweapon(self.weapon.name, "steadyaim");
		self ai::gun_remove();
		self ai::gun_switchto(laser_weapon, "right");
		wait(2);
		if(isdefined(self.var_e09b732c) && self.var_e09b732c)
		{
			return;
		}
		clientfield::set("swat_light_strobe", 1);
		self.var_ab84134 = function_60d95f53() / 1000;
		self thread targetting_delay::function_7e1a12ce();
		self thread function_d1c52e08();
		self thread function_ace0a9bc();
		self thread function_416a0a80(self.script_owner);
		self.killstreaktype = "swat_team";
		self.var_259f6c17 = 1;
	}
}

/*
	Name: function_8821879c
	Namespace: swat_team
	Checksum: 0xBE5ED369
	Offset: 0x8960
	Size: 0x5FE
	Parameters: 1
	Flags: Linked
*/
function function_8821879c(killstreak_id)
{
	self endon(#"hash_71a1db99eb99dcff", #"disconnect", #"joined_team");
	if(!isdefined(self.var_6c0553ea))
	{
		return;
	}
	if(!isdefined(self.var_6c0553ea.remoteweapon))
	{
		return;
	}
	if(!isdefined(self.var_6c0553ea.remoteweapon.usetrigger))
	{
		return;
	}
	self.var_6c0553ea.remoteweapon.usetrigger endon(#"death");
	while(isdefined(self.var_6c0553ea) && isdefined(self.var_6c0553ea.remoteweapon))
	{
		if(!isdefined(self.var_6c0553ea.remoteweapon.usetrigger))
		{
			break;
		}
		res = undefined;
		res = self.var_6c0553ea.remoteweapon.usetrigger waittill(#"trigger", #"death");
		if(res._notify == "death")
		{
			break;
		}
		if(self.var_976238cf == #"swat_team")
		{
			waitframe(1);
			if(!self function_55acff10() && (!(isdefined(self.is_capturing_own_supply_drop) && self.is_capturing_own_supply_drop)))
			{
				ordering = 1;
				timer = gettime() + 50;
				self notify(#"hash_388d15e349a6a017");
				if(self.var_5f43fa0c == "swat_escort")
				{
					self.var_5f43fa0c = "swat_guard";
					self swat_guard();
					if(isdefined(self.var_6c0553ea.remoteweapon))
					{
						self.var_6c0553ea.remoteweapon function_944f0911("");
					}
					wait(3);
					if(isdefined(self.var_6c0553ea.remoteweapon))
					{
						if(!self gamepadusedlast())
						{
							self.var_6c0553ea.remoteweapon function_944f0911(#"hash_600af0ac4af0b090");
						}
						else
						{
							self.var_6c0553ea.remoteweapon function_944f0911(#"hash_60c7465070c7985c");
						}
					}
				}
				else
				{
					self.var_5f43fa0c = "swat_escort";
					self gestures::function_56e00fbf(#"gestable_order_follow", undefined, 0);
					self function_d738127f();
					self thread swat_escort();
					if(isdefined(self.var_6c0553ea.remoteweapon))
					{
						self.var_6c0553ea.remoteweapon function_944f0911("");
					}
					wait(3);
					if(isdefined(self.var_6c0553ea.remoteweapon))
					{
						if(!self gamepadusedlast())
						{
							self.var_6c0553ea.remoteweapon function_944f0911(#"hash_167e638f51287532");
						}
						else
						{
							self.var_6c0553ea.remoteweapon function_944f0911(#"hash_6800108794068996");
						}
					}
				}
			}
		}
		else if(isdefined(ordering) && ordering && !self util::use_button_held())
		{
			ordering = 0;
		}
		if(isdefined(self.is_capturing_own_supply_drop) && self.is_capturing_own_supply_drop)
		{
			if(isdefined(self.var_6c0553ea.remoteweapon))
			{
				self.var_6c0553ea.remoteweapon function_944f0911("");
			}
			wait(5);
			if(isdefined(self.var_6c0553ea.remoteweapon))
			{
				if(self.var_5f43fa0c == "swat_guard")
				{
					if(!self gamepadusedlast())
					{
						self.var_6c0553ea.remoteweapon function_944f0911(#"hash_600af0ac4af0b090");
					}
					else
					{
						self.var_6c0553ea.remoteweapon function_944f0911(#"hash_60c7465070c7985c");
					}
				}
				else
				{
					if(!self gamepadusedlast())
					{
						self.var_6c0553ea.remoteweapon function_944f0911(#"hash_600af0ac4af0b090");
					}
					else
					{
						self.var_6c0553ea.remoteweapon function_944f0911(#"hash_60c7465070c7985c");
					}
				}
			}
		}
	}
	waitframe(1);
}

/*
	Name: function_47e16e28
	Namespace: swat_team
	Checksum: 0x7C933AE8
	Offset: 0x8F68
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_47e16e28()
{
	self endon(#"hash_71a1db99eb99dcff", #"disconnect", #"joined_team");
	while(self.var_976238cf == #"swat_team")
	{
		waitframe(1);
	}
	if(isdefined(self.var_6c0553ea.remoteweapon))
	{
		self.var_6c0553ea.remoteweapon.usetrigger delete();
		self.var_6c0553ea.remoteweapon = undefined;
	}
}

/*
	Name: swat_loop
	Namespace: swat_team
	Checksum: 0xC2BA34EA
	Offset: 0x9020
	Size: 0x300
	Parameters: 1
	Flags: Linked
*/
function swat_loop(killstreak_id)
{
	self endon(#"hash_71a1db99eb99dcff");
	self endoncallback(&function_d524c2b8, #"disconnect", #"joined_team");
	endtime = gettime() + self.var_6c0553ea.time;
	self.var_976238cf = #"swat_team";
	self.var_5f43fa0c = "swat_escort";
	function_4c2ed78d(self, 1);
	self thread swat_escort(0);
	self waittill(#"payload_delivered");
	if(isplayer(self))
	{
		if(!self gamepadusedlast())
		{
			self.var_6c0553ea.remoteweapon = self createremoteweapontrigger(#"hash_167e638f51287532");
		}
		else
		{
			self.var_6c0553ea.remoteweapon = self createremoteweapontrigger(#"hash_6800108794068996");
		}
	}
	self thread function_47e16e28();
	self thread function_8821879c(killstreak_id);
	while(isdefined(self.var_6c0553ea))
	{
		alldead = 1;
		for(i = 0; i < 2; i++)
		{
			if(!isdefined(self.swat_team[i]))
			{
				continue;
			}
			alldead = 0;
			break;
		}
		if(alldead || gettime() > endtime)
		{
			if(alldead)
			{
				self globallogic_audio::flush_killstreak_dialog_on_player(killstreak_id);
				self globallogic_audio::play_taacom_dialog("destroyed", "swat_team");
			}
			else if(gettime() > endtime)
			{
				self globallogic_audio::play_taacom_dialog("timeout", "swat_team");
			}
			self function_d738127f();
			start_swat_team_leave();
			if(isdefined(self.var_6c0553ea.remoteweapon))
			{
				self.var_6c0553ea.remoteweapon.usetrigger delete();
				self.var_6c0553ea.remoteweapon = undefined;
			}
			break;
		}
		waitframe(1);
	}
}

/*
	Name: sort_by_score
	Namespace: swat_team
	Checksum: 0x13E26FAA
	Offset: 0x9328
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function sort_by_score(left, right)
{
	return left.score > right.score;
}

/*
	Name: function_2d44c54f
	Namespace: swat_team
	Checksum: 0xC9F11016
	Offset: 0x9360
	Size: 0x162
	Parameters: 3
	Flags: Linked, Private
*/
function private function_2d44c54f(var_eca4744a, var_56bd1bef, nodes)
{
	tacpoint = getclosesttacpoint(var_56bd1bef);
	foreach(node in nodes)
	{
		withinfov = vectordot(var_eca4744a, (vectornormalize(node.origin - var_56bd1bef)) > cos(30));
		if(withinfov && function_96c81b85(tacpoint, node.origin))
		{
			node.score = 100;
			continue;
		}
		node.score = 0;
	}
	return array::merge_sort(nodes, &sort_by_score);
}

/*
	Name: function_a4ab9672
	Namespace: swat_team
	Checksum: 0xA5DB7E44
	Offset: 0x94D0
	Size: 0x2F6
	Parameters: 5
	Flags: Linked
*/
function function_a4ab9672(swat, owner, var_eca4744a, var_56bd1bef, forced = 0)
{
	/#
		recordsphere(var_56bd1bef, 8, (0, 1, 1), "");
	#/
	nodes = getnodesinradiussorted(var_56bd1bef, 600, 64, 300, "Path");
	if(nodes.size)
	{
		if(!forced)
		{
			nodes_sorted = function_2d44c54f(var_eca4744a, var_56bd1bef, nodes);
		}
		else
		{
			nodes_sorted = nodes;
		}
		foreach(node in nodes_sorted)
		{
			if(canclaimnode(node, owner.team) && !isdefined(node.owner))
			{
				/#
					recordsphere(node.origin, 4, (1, 0.5, 0), "");
					recordline(owner.origin, node.origin, (1, 0.5, 0), "");
				#/
				if(!swat.keepclaimednode)
				{
					swat setgoal(node);
					swat usecovernode(node);
					swat.var_ecdaf39 = node.origin;
					swat.var_1824dd22 = node;
				}
				break;
			}
		}
	}
	else
	{
		points = function_b777d194(var_56bd1bef);
		for(i = 0; i < 2; i++)
		{
			if(owner.swat_team[i] == swat)
			{
				swat setgoal(points[i]);
				swat.var_ecdaf39 = points[i];
				return;
			}
		}
	}
}

/*
	Name: function_7b3ad3fe
	Namespace: swat_team
	Checksum: 0xC3575684
	Offset: 0x97D0
	Size: 0xAA
	Parameters: 2
	Flags: Linked
*/
function function_7b3ad3fe(swat, location)
{
	iterationlimit = getdvarint(#"hkai_pathfinditerationlimit", 1800);
	path = generatenavmeshpath(swat.origin, location, swat, undefined, undefined, iterationlimit);
	if(isdefined(path) && path.status === "succeeded")
	{
		return true;
	}
	return false;
}

/*
	Name: function_4c2ed78d
	Namespace: swat_team
	Checksum: 0x54FD0D94
	Offset: 0x9888
	Size: 0x78E
	Parameters: 2
	Flags: Linked
*/
function function_4c2ed78d(owner, forced = 0)
{
	result = function_9cc082d2(owner.origin, 1000);
	if(!isdefined(result))
	{
		return;
	}
	owner_origin = result[#"point"];
	if(!isdefined(owner_origin))
	{
		return;
	}
	enemies = getplayers();
	potentialenemies = [];
	foreach(enemy in enemies)
	{
		if(owner.team != enemy.team)
		{
			array::add(potentialenemies, enemy);
		}
	}
	if(!forced)
	{
		velocity = owner getvelocity();
		if(length(velocity) >= 20)
		{
			velocity = vectornormalize(velocity);
			owner.var_546b8137 = velocity;
		}
		if(isdefined(owner.var_546b8137))
		{
			var_56bd1bef = owner_origin + vectorscale(vectornormalize(owner.var_546b8137), 200);
		}
		else
		{
			var_56bd1bef = owner_origin + vectorscale(anglestoforward(owner.angles), 200);
		}
	}
	else
	{
		var_56bd1bef = owner_origin;
	}
	result = function_9cc082d2(var_56bd1bef, 1000);
	if(isdefined(result))
	{
		var_56bd1bef = result[#"point"];
	}
	if(!isdefined(var_56bd1bef) && (!isdefined(potentialenemies) || !potentialenemies.size))
	{
		waitframe(1);
		return;
	}
	for(i = 0; i < 2; i++)
	{
		if(!isdefined(owner.swat_team[i]))
		{
			continue;
		}
		swat = owner.swat_team[i];
		if(isdefined(swat.ai.var_5cb410bc))
		{
			continue;
		}
		if(!isdefined(swat.ai.var_b3e4c4fe))
		{
			swat.ai.var_b3e4c4fe = gettime();
		}
		potentialenemies = array::remove_undefined(potentialenemies);
		if(isdefined(potentialenemies) && potentialenemies.size)
		{
			if(isdefined(swat.enemy))
			{
				nearbyplayer = swat.enemy;
			}
			else
			{
				nearbyplayer = arraygetclosest(swat.origin, potentialenemies);
			}
			if(!isdefined(nearbyplayer))
			{
				waitframe(1);
				continue;
			}
			var_470b2385 = distancesquared(swat.origin, nearbyplayer.origin);
			if(swat cansee(nearbyplayer) || var_470b2385 < (300 * 300))
			{
				waitframe(1);
				continue;
			}
			if(isdefined(nearbyplayer))
			{
				if(gettime() < swat.ai.var_b3e4c4fe)
				{
					waitframe(1);
					continue;
				}
				tacpoint = getclosesttacpoint(nearbyplayer.origin);
				if(isdefined(tacpoint))
				{
					newpos = getclosestpointonnavmesh(tacpoint.origin, 200, self getpathfindingradius(), 1);
					if(isdefined(newpos) && function_7b3ad3fe(swat, newpos))
					{
						swat setgoal(newpos, 1);
						swat.ai.var_b3e4c4fe = randomintrange(4500, 6500);
						continue;
					}
					else
					{
						cylinder = ai::t_cylinder(swat.origin, 1200, 200);
						var_8f3583cf = ai::t_cylinder(swat.origin, 150, 200);
						var_5af32875 = ai::t_cylinder(swat.origin, 300, 200);
						tacpoints = tacticalquery("swat_tacquery_seek", swat.origin, cylinder, swat, var_8f3583cf, tacpoint.origin, var_5af32875);
						if(isdefined(tacpoints) && tacpoints.size)
						{
							swat setgoal(tacpoints[0].origin, 1);
							swat.ai.var_b3e4c4fe = randomintrange(4500, 6500);
							continue;
						}
					}
				}
			}
		}
		if(!isdefined(var_56bd1bef))
		{
			waitframe(1);
			continue;
		}
		var_eca4744a = vectornormalize(var_56bd1bef - owner_origin);
		tacpoint = getclosesttacpoint(var_56bd1bef);
		shouldmove = 0;
		if(isdefined(tacpoint))
		{
			if(forced)
			{
				shouldmove = 1;
			}
			else
			{
				if(isdefined(swat.var_ecdaf39))
				{
					shouldmove = distancesquared(var_56bd1bef, swat.var_ecdaf39) >= (600 * 600);
				}
				else
				{
					shouldmove = distancesquared(var_56bd1bef, swat.origin) >= (600 * 600);
				}
			}
		}
		if(shouldmove)
		{
			function_a4ab9672(swat, owner, var_eca4744a, var_56bd1bef, forced);
		}
	}
}

/*
	Name: swat_escort
	Namespace: swat_team
	Checksum: 0x47CA5C6C
	Offset: 0xA020
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function swat_escort(playgesture = 1)
{
	owner = self;
	owner endon(#"hash_71a1db99eb99dcff", #"disconnect", #"joined_team");
	owner waittill(#"payload_delivered");
	owner function_d738127f();
	if(isdefined(owner) && playgesture)
	{
		owner gestures::function_56e00fbf(#"gestable_order_follow", undefined, 0);
	}
	while(true)
	{
		if(isdefined(owner) && owner.var_5f43fa0c == "swat_escort")
		{
			if(isdefined(level.var_6cfbe5a))
			{
				[[ level.var_6cfbe5a ]]->waitinqueue(owner);
			}
			function_4c2ed78d(owner);
		}
		wait(1);
	}
}

/*
	Name: swat_guard
	Namespace: swat_team
	Checksum: 0x3339CADA
	Offset: 0xA168
	Size: 0x386
	Parameters: 0
	Flags: Linked
*/
function swat_guard()
{
	direction = self getplayerangles();
	direction_vec = anglestoforward(direction);
	eye = self geteye();
	direction_vec = (direction_vec[0] * 2000, direction_vec[1] * 2000, direction_vec[2] * 2000);
	trace = bullettrace(eye, eye + direction_vec, 0, self);
	position = getclosestpointonnavmesh(trace[#"position"]);
	if(!isdefined(position))
	{
		var_2b4c258c = trace[#"position"] - eye;
		for(i = 0; i < 8; i++)
		{
			testpos = eye + (vectorscale(var_2b4c258c, (8 - i) / 8));
			position = function_9cc082d2(testpos, 800);
			if(isdefined(position))
			{
				position = position[#"point"];
				break;
			}
		}
	}
	if(!isdefined(position))
	{
		return;
	}
	zone = function_5615237b(position);
	if(isdefined(zone))
	{
		nodes = getnodearray(zone.target, "targetname");
		for(i = 0; i < nodes.size; i++)
		{
			if(nodes[i].type == "BAD NODE")
			{
				nodes = function_b777d194(position);
				break;
			}
		}
	}
	else
	{
		nodes = function_b777d194(position);
	}
	if(!isdefined(nodes))
	{
		waitframe(1);
		return;
	}
	self function_59f58b93(position);
	self gestures::function_56e00fbf(#"gestable_battle_cry", undefined, 0);
	for(i = 0; i < 2; i++)
	{
		if(!isdefined(self.swat_team[i]))
		{
			return;
		}
		if(i == 0)
		{
			self.swat_team[i] thread registerrein_amb("swat_ready");
		}
		self.swat_team[i] setgoal(nodes[i]);
	}
	self.var_6c0553ea.clear_kills = 0;
}

/*
	Name: function_d524c2b8
	Namespace: swat_team
	Checksum: 0xF3FD7EEB
	Offset: 0xA4F8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_d524c2b8(str_notify)
{
	swat_cleanup();
}

/*
	Name: function_a38d2d73
	Namespace: swat_team
	Checksum: 0x81CB3C08
	Offset: 0xA520
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_a38d2d73(tacpoint)
{
	players = getplayers();
	foreach(player in players)
	{
		if(distancesquared(tacpoint.origin, player.origin) <= (200 * 200))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_4670789f
	Namespace: swat_team
	Checksum: 0xCD21CA94
	Offset: 0xA5E8
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_4670789f(tacpoint)
{
	players = getplayers();
	foreach(player in players)
	{
		if(function_96c81b85(tacpoint, player.origin))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_9cb166cd
	Namespace: swat_team
	Checksum: 0xE571AF60
	Offset: 0xA6A0
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9cb166cd(tacpoints)
{
	/#
		assert(isdefined(tacpoints) && tacpoints.size);
	#/
	filteredpoints = [];
	foreach(tacpoint in tacpoints)
	{
		if(!function_4670789f(tacpoint) && !function_a38d2d73(tacpoint))
		{
			filteredpoints[filteredpoints.size] = tacpoint;
		}
	}
	return filteredpoints;
}

/*
	Name: function_e74b21de
	Namespace: swat_team
	Checksum: 0x7028A855
	Offset: 0xA798
	Size: 0x218
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e74b21de(owner)
{
	if(isdefined(owner))
	{
		origin = owner.origin;
		angles = owner getplayerangles();
	}
	else
	{
		origin = self.origin;
		angles = self.angles;
	}
	cylinder = ai::t_cylinder(self.origin, 1500, 250);
	var_84e7232 = origin;
	var_441c6196 = ai::t_cylinder(origin, 100, 250);
	tacpoints = tacticalquery("swat_team_leave", origin, self, cylinder, var_441c6196, var_84e7232);
	if(isdefined(tacpoints) && tacpoints.size)
	{
		tacpoints = function_9cb166cd(tacpoints);
		if(tacpoints.size)
		{
			tacpoint = array::random(tacpoints);
			return {#angles:angles, #origin:tacpoint.origin};
		}
	}
	tacpoints = tacticalquery("swat_team_leave_fallback", origin, self, cylinder, var_441c6196, var_84e7232);
	if(isdefined(tacpoints) && tacpoints.size)
	{
		tacpoints = function_9cb166cd(tacpoints);
		if(tacpoints.size)
		{
			tacpoint = array::random(tacpoints);
			return {#angles:angles, #origin:tacpoint.origin};
		}
	}
	return undefined;
}

/*
	Name: start_swat_team_leave
	Namespace: swat_team
	Checksum: 0x65C6F54A
	Offset: 0xA9B8
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function start_swat_team_leave()
{
	for(i = 0; i < 2; i++)
	{
		if(!isdefined(self.swat_team[i]))
		{
			continue;
		}
		if(isdefined(self.owner))
		{
			self.owner notify(#"hash_71a1db99eb99dcff");
		}
		self.swat_team[i] thread swat_leave();
	}
}

/*
	Name: function_ac0e6696
	Namespace: swat_team
	Checksum: 0xECB7773E
	Offset: 0xAA48
	Size: 0x160
	Parameters: 0
	Flags: Linked
*/
function function_ac0e6696()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		players = getplayers();
		var_2282e309 = 0;
		foreach(player in players)
		{
			if(sighttracepassed(self geteye(), player geteye(), 0, undefined))
			{
				var_2282e309 = 1;
				break;
			}
		}
		if(!var_2282e309)
		{
			function_a00c5973("swat_member", self);
			util::wait_network_frame();
			self delete();
		}
		wait(0.5);
	}
}

/*
	Name: swat_leave
	Namespace: swat_team
	Checksum: 0x93C432B7
	Offset: 0xABB0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function swat_leave()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(isdefined(level.var_6cfbe5a))
	{
		[[ level.var_6cfbe5a ]]->waitinqueue(self);
	}
	self.exit_spawn = function_e74b21de(self.script_owner);
	self clientfield::set("swat_rob_state", 1);
	if(isdefined(self.exit_spawn))
	{
		self thread function_ac0e6696();
		self function_d4c687c9();
		self pathmode("move allowed");
		self.goalradius = 20;
		self setgoal(self.exit_spawn.origin, 0);
		self waittilltimeout(10, #"goal");
	}
	waittillframeend();
	function_a00c5973("swat_member", self);
	util::wait_network_frame();
	self delete();
}

/*
	Name: swat_cleanup
	Namespace: swat_team
	Checksum: 0xCAEF932
	Offset: 0xAD40
	Size: 0x2F8
	Parameters: 1
	Flags: Linked
*/
function swat_cleanup(destroy_heli)
{
	if(gamestate::is_game_over())
	{
		return;
	}
	if(!isdefined(destroy_heli))
	{
		destroy_heli = 1;
	}
	self notify(#"hash_71a1db99eb99dcff");
	if(isdefined(self.var_6c0553ea))
	{
		for(i = self.swat_team.size; i >= 0; i--)
		{
			if(isdefined(self.swat_team[i]) && isalive(self.swat_team[i]))
			{
				self.swat_team[i] kill(self.swat_team[i].origin, undefined, undefined, undefined, 0, 1);
			}
		}
		if(isdefined(self.var_e60e2941))
		{
			for(i = self.var_e60e2941.size; i >= 0; i--)
			{
				if(isdefined(self.var_e60e2941[i]) && isalive(self.var_e60e2941[i]))
				{
					self.var_e60e2941[i] kill(self.var_e60e2941[i].origin, undefined, undefined, undefined, 0, 1);
				}
			}
		}
		if(isdefined(self.var_6c0553ea.helicopter))
		{
			function_d4331865(self.var_6c0553ea.helicopter.rope);
			if(destroy_heli)
			{
				thread swat_helicopter_explode(self.var_6c0553ea.helicopter);
			}
		}
		if(isdefined(self.var_6c0553ea.ir_model))
		{
			self.var_6c0553ea.ir_model notify(#"hash_1e4c945d50deb21d");
		}
		self function_d738127f();
		if(isdefined(self.var_6c0553ea.killstreak_id) && isdefined(self.var_6c0553ea.var_43dc1011))
		{
			stopkillstreak(self.var_6c0553ea);
		}
		if(isdefined(self.var_6c0553ea.remoteweapon))
		{
			self.var_6c0553ea.remoteweapon.usetrigger delete();
			self.var_6c0553ea.remoteweapon = undefined;
		}
		self.var_6c0553ea = undefined;
	}
	self.swat_team = [];
}

/*
	Name: function_d86da2e8
	Namespace: swat_team
	Checksum: 0x602F793D
	Offset: 0xB040
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_d86da2e8(params)
{
	function_a00c5973("swat_member", self);
}

/*
	Name: function_610d3790
	Namespace: swat_team
	Checksum: 0x84243A75
	Offset: 0xB070
	Size: 0x2D2
	Parameters: 4
	Flags: Linked
*/
function function_610d3790(einflictor, victim, idamage, weapon)
{
	attacker = self;
	if(!isdefined(attacker.var_6c0553ea))
	{
		return;
	}
	if(isactor(einflictor))
	{
		attacker.var_6c0553ea.kills++;
		if(attacker.var_6c0553ea.kills == 3)
		{
			scoreevents::processscoreevent(#"hash_7caba8ab83b5373f", attacker, victim, getweapon(#"swat_team"));
		}
		if(einflictor isatgoal())
		{
			scoreevents::processscoreevent(#"hash_69a40144e52332f9", attacker, victim, getweapon(#"swat_team"));
		}
		else
		{
			attacker.var_6c0553ea.clear_kills++;
			if(attacker.var_6c0553ea.clear_kills == 2)
			{
				scoreevents::processscoreevent(#"hash_7e7146503217ca9c", attacker, victim, getweapon(#"swat_team"));
			}
		}
	}
	else
	{
		foreach(swat in attacker.swat_team)
		{
			if(isdefined(swat) && isdefined(swat.enemy) && swat.enemy == victim && swat attackedrecently(victim, 3))
			{
				scoreevents::processscoreevent(#"hash_1f0ecf369a09e682", attacker, victim, getweapon(#"swat_team"));
				return;
			}
		}
	}
}

/*
	Name: function_59f58b93
	Namespace: swat_team
	Checksum: 0xDA02D73C
	Offset: 0xB350
	Size: 0x21C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_59f58b93(origin)
{
	self function_d738127f();
	if(isdefined(self.var_6c0553ea.marker))
	{
		self.var_6c0553ea.marker.origin = origin;
		self.var_6c0553ea.marker.team = self.team;
		self.var_6c0553ea.marker entityheadicons::setentityheadicon(self.pers[#"team"], self, self.var_6c0553ea.objective);
		objid = self.var_6c0553ea.marker.entityheadobjectives[self.var_6c0553ea.marker.entityheadobjectives.size - 1];
		objective_setinvisibletoall(objid);
		objective_setvisibletoplayer(objid, self);
	}
	self.var_6c0553ea.fx_marker = spawnfx(self.var_6c0553ea.fx_name, origin + vectorscale((0, 0, 1), 3), (0, 0, 1), (1, 0, 0));
	self.var_6c0553ea.fx_marker.team = self.team;
	triggerfx(self.var_6c0553ea.fx_marker);
	self.var_6c0553ea.fx_marker setinvisibletoall();
	self.var_6c0553ea.fx_marker setvisibletoplayer(self);
	self playsoundtoplayer(#"uin_mp_combat_bot_guard", self);
}

/*
	Name: function_d738127f
	Namespace: swat_team
	Checksum: 0x681FF101
	Offset: 0xB578
	Size: 0x92
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d738127f()
{
	if(!isdefined(self.var_6c0553ea))
	{
		return;
	}
	if(isdefined(self.var_6c0553ea.marker))
	{
		self.var_6c0553ea.marker entityheadicons::destroyentityheadicons();
	}
	if(isdefined(self.var_6c0553ea.fx_marker))
	{
		self.var_6c0553ea.fx_marker delete();
		self.var_6c0553ea.fx_marker = undefined;
	}
}

/*
	Name: function_5615237b
	Namespace: swat_team
	Checksum: 0xD019D469
	Offset: 0xB618
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function function_5615237b(origin)
{
	structs = struct::get_array("swat_zone", "variantname");
	if(!structs.size)
	{
		return undefined;
	}
	shortest = distancesquared(origin, structs[0].origin);
	best = structs[0];
	foreach(struct in structs)
	{
		newdist = distancesquared(origin, struct.origin);
		if(newdist < shortest)
		{
			shortest = newdist;
			best = struct;
		}
	}
	return best;
}

/*
	Name: function_4c0ed253
	Namespace: swat_team
	Checksum: 0x723DE26C
	Offset: 0xB758
	Size: 0x236
	Parameters: 2
	Flags: Linked
*/
function function_4c0ed253(location, context)
{
	foreach(droplocation in level.droplocations)
	{
		if(distance2dsquared(droplocation, location) < 3600)
		{
			return false;
		}
	}
	if(context.perform_physics_trace === 1)
	{
		mask = 1;
		if(isdefined(context.tracemask))
		{
			mask = context.tracemask;
		}
		radius = context.radius;
		trace = physicstrace(location + vectorscale((0, 0, 1), 5000), location + vectorscale((0, 0, 1), 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
		if(trace[#"fraction"] < 1)
		{
			if(!(isdefined(level.var_66da9c3c) && level.var_66da9c3c))
			{
				return false;
			}
		}
	}
	result = function_9cc082d2(location + vectorscale((0, 0, 1), 100), 170);
	if(!isdefined(result))
	{
		return false;
	}
	if(context.check_same_floor === 1 && (abs(location[2] - self.origin[2])) > 96)
	{
		return false;
	}
	return true;
}

/*
	Name: islocationgood
	Namespace: swat_team
	Checksum: 0xAC0101D2
	Offset: 0xB998
	Size: 0x490
	Parameters: 2
	Flags: Linked
*/
function islocationgood(location, context)
{
	if(getdvarint(#"hash_60d47d611bbc3bed", 1))
	{
		return function_4c0ed253(location, context);
	}
	foreach(droplocation in level.droplocations)
	{
		if(distance2dsquared(droplocation, location) < 3600)
		{
			return 0;
		}
	}
	if(context.perform_physics_trace === 1)
	{
		mask = 1;
		if(isdefined(context.tracemask))
		{
			mask = context.tracemask;
		}
		radius = context.radius;
		trace = physicstrace(location + vectorscale((0, 0, 1), 5000), location + vectorscale((0, 0, 1), 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
		if(trace[#"fraction"] < 1)
		{
			if(!(isdefined(level.var_66da9c3c) && level.var_66da9c3c))
			{
				return 0;
			}
		}
	}
	closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
	isvalidpoint = isdefined(closestpoint);
	if(isvalidpoint && context.check_same_floor === 1 && (abs(location[2] - closestpoint[2])) > 96)
	{
		isvalidpoint = 0;
	}
	if(isvalidpoint && distance2dsquared(location, closestpoint) > (context.max_dist_from_location * context.max_dist_from_location))
	{
		isvalidpoint = 0;
	}
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		destination = getstartorigin(location, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
		var_baa92af9 = ispointinnavvolume(destination, "navvolume_big");
		if(!var_baa92af9)
		{
			isvalidpoint = 0;
		}
	}
	/#
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			if(!isvalidpoint)
			{
				otherclosestpoint = getclosestpointonnavmesh(location, getdvarfloat(#"scr_supply_drop_valid_location_radius_debug", 96), context.dist_from_boundary);
				if(isdefined(otherclosestpoint))
				{
					sphere(otherclosestpoint, context.max_dist_from_location, (1, 0, 0), 0.8, 0, 20, 1);
				}
			}
			else
			{
				sphere(closestpoint, context.max_dist_from_location, (0, 1, 0), 0.8, 0, 20, 1);
				util::drawcylinder(closestpoint, context.radius, 8000, 0.01666667, undefined, vectorscale((0, 1, 0), 0.9), 0.7);
			}
		}
	#/
	return isvalidpoint;
}

/*
	Name: checkforemp
	Namespace: swat_team
	Checksum: 0xF67AE681
	Offset: 0xBE30
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function checkforemp()
{
	self endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"weapon_change", #"death", #"trigger_weapon_shutdown");
	self waittill(#"emp_jammed");
	self killstreaks::switch_to_last_non_killstreak_weapon();
}

/*
	Name: checkweaponchange
	Namespace: swat_team
	Checksum: 0x986C971B
	Offset: 0xBEC8
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function checkweaponchange(team, killstreak_id)
{
	self endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"trigger_weapon_shutdown", #"death");
	self waittill(#"weapon_change");
	stopkillstreak(self.var_6c0553ea);
	self notify(#"cleanup_marker");
}

/*
	Name: stopkillstreak
	Namespace: swat_team
	Checksum: 0xFBCF28C6
	Offset: 0xBF78
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function stopkillstreak(context)
{
	if(isdefined(context.var_45453b2a) && context.var_45453b2a)
	{
		return;
	}
	killstreakrules::killstreakstop("swat_team", context.var_43dc1011, context.killstreak_id);
	context.var_45453b2a = 1;
}

/*
	Name: addoffsetontopoint
	Namespace: swat_team
	Checksum: 0xB18BB5C5
	Offset: 0xBFF0
	Size: 0x78
	Parameters: 3
	Flags: None
*/
function addoffsetontopoint(point, direction, offset)
{
	angles = vectortoangles((direction[0], direction[1], 0));
	offset_world = rotatepoint(offset, angles);
	return point + offset_world;
}

/*
	Name: obj_set
	Namespace: swat_team
	Checksum: 0x42AD41A7
	Offset: 0xC070
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function obj_set(str_objective, e_target)
{
	n_obj_id = gameobjects::get_next_obj_id();
	if(!isdefined(e_target.a_n_objective_ids))
	{
		e_target.a_n_objective_ids = [];
	}
	e_target.a_n_objective_ids[str_objective] = n_obj_id;
	objective_add(n_obj_id, "active", e_target, str_objective);
	function_3ae6fa3(n_obj_id, e_target.team, 1);
	objective_setteam(n_obj_id, e_target.team);
	n_obj_id = gameobjects::get_next_obj_id();
	e_target.a_n_objective_ids[str_objective + "_enemy"] = n_obj_id;
	objective_add(n_obj_id, "active", e_target, str_objective + "_enemy");
	function_da7940a3(n_obj_id, 1);
	function_3ae6fa3(n_obj_id, e_target.team, 0);
	objective_setteam(n_obj_id, e_target.team);
}

/*
	Name: function_a00c5973
	Namespace: swat_team
	Checksum: 0xC829DE04
	Offset: 0xC208
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_a00c5973(str_objective, e_target)
{
	if(isdefined(e_target.a_n_objective_ids) && isdefined(e_target.a_n_objective_ids[str_objective]))
	{
		n_obj_id = e_target.a_n_objective_ids[str_objective];
		e_target.a_n_objective_ids[str_objective] = undefined;
		objective_setstate(n_obj_id, "done");
		gameobjects::release_obj_id(n_obj_id);
		n_obj_id = e_target.a_n_objective_ids[str_objective + "_enemy"];
		e_target.a_n_objective_ids[str_objective + "_enemy"] = undefined;
		objective_setstate(n_obj_id, "done");
		gameobjects::release_obj_id(n_obj_id);
	}
}

