// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\trapd.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\placeables.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

class class_7b5e0861 
{
	var m_health;
	var m_name;

	/*
		Name: constructor
		Namespace: namespace_7b5e0861
		Checksum: 0x80F724D1
		Offset: 0x4890
		Size: 0x4
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_7b5e0861
		Checksum: 0x38C6A9F3
		Offset: 0x48A0
		Size: 0x4C
		Parameters: 0
		Flags: 16
	*/
	destructor()
	{
		/#
			if(isdefined(level.trapddebug) && level.trapddebug)
			{
				iprintlnbold("" + m_name);
			}
		#/
	}

	/*
		Name: function_8df621c
		Namespace: namespace_7b5e0861
		Checksum: 0x587DCF6A
		Offset: 0x48F8
		Size: 0x19E
		Parameters: 2
		Flags: None
	*/
	function function_8df621c(bundle, var_a8539bf6)
	{
		self.m_type = bundle.trap_type;
		self.m_name = bundle.name;
		self.m_weapon = bundle.weapon;
		self.m_vehicle = bundle.vehicle;
		self.m_model = bundle.model;
		self.var_e84fc5dc = bundle.var_f495bc84;
		self.var_28f1ce55 = bundle.var_90f05429;
		self.m_spawnsentity = bundle.spawnsentity;
		self.var_656cbe2d = bundle.var_28bb5240;
		self.m_timeout = bundle.timeout;
		self.m_health = bundle.health;
		if(isdefined(m_health))
		{
			self.var_c59ba447 = m_health - (int(m_health / 3));
		}
		self.m_empdamage = bundle.empdamage;
		self.var_f81e0192 = bundle.var_980063fb;
		self.var_b4662b52 = bundle.var_6e2ae4a5;
		self.m_placeimmediately = bundle.placeimmediately;
		self.var_31e7e66a = bundle.var_d6011052;
		self.var_3efa7c17 = var_a8539bf6;
	}

}

#namespace traps_deployable;

/*
	Name: __init__system__
	Namespace: traps_deployable
	Checksum: 0xB75BBC6D
	Offset: 0x260
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"traps_deployable", &__init__, undefined, #"load");
}

/*
	Name: __init__
	Namespace: traps_deployable
	Checksum: 0x9ECA3A38
	Offset: 0x2B0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
	thread init_traps();
}

/*
	Name: on_player_spawned
	Namespace: traps_deployable
	Checksum: 0x47C90130
	Offset: 0x2F0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	if(!isdefined(level._traps_deployable))
	{
		return;
	}
	player = self;
	player owner_init();
}

/*
	Name: owner_init
	Namespace: traps_deployable
	Checksum: 0x2435AAA7
	Offset: 0x338
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function owner_init()
{
	owner = self;
	if(!isdefined(owner._traps_deployable))
	{
		owner._traps_deployable = spawnstruct();
	}
	if(!isdefined(owner._traps_deployable.watchers_init))
	{
		owner._traps_deployable.watchers_init = [];
	}
}

/*
	Name: function_18bbaaf9
	Namespace: traps_deployable
	Checksum: 0x68A78742
	Offset: 0x3B0
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function function_18bbaaf9()
{
	return isdefined(self._traps_deployable) && (isdefined(self._traps_deployable.var_18bbaaf9) && self._traps_deployable.var_18bbaaf9);
}

/*
	Name: init_traps
	Namespace: traps_deployable
	Checksum: 0x1BCCA838
	Offset: 0x3F0
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function init_traps()
{
	function_5726a711();
	/#
		thread debug_init();
	#/
}

/*
	Name: function_5726a711
	Namespace: traps_deployable
	Checksum: 0xA6242547
	Offset: 0x428
	Size: 0x3A0
	Parameters: 0
	Flags: None
*/
function function_5726a711()
{
	level flag::wait_till("all_players_spawned");
	var_59eaf9e1 = struct::get_script_bundle_instances("traps_deployable");
	foreach(var_5e63b00d in var_59eaf9e1)
	{
		if(isdefined(var_5e63b00d.scriptbundlename))
		{
			var_2d727ba0 = struct::get_script_bundle("traps_deployable", var_5e63b00d.scriptbundlename);
			if(isdefined(var_2d727ba0))
			{
				var_a8539bf6 = spawnstruct();
				if(isdefined(var_5e63b00d.script_team) && var_5e63b00d.script_team != #"none")
				{
					var_a8539bf6.team = var_5e63b00d.script_team;
				}
				else
				{
					var_a8539bf6.team = #"any";
				}
				var_a8539bf6.origin = var_5e63b00d.origin;
				var_a8539bf6.angles = var_5e63b00d.angles;
				var_a8539bf6.model = var_5e63b00d.model;
				gameobject = var_2d727ba0.gameobject;
				if(isdefined(var_5e63b00d.var_3b9b6b78))
				{
					gameobject = var_5e63b00d.var_3b9b6b78;
				}
				var_a8539bf6.var_5b026504 = var_5e63b00d.script_objective;
				var_a8539bf6.var_ef146db5 = var_5e63b00d.var_d513a1cb;
				var_a8539bf6.gameobject = gameobject;
				if(var_a8539bf6 register_trap(var_2d727ba0))
				{
					var_5e63b00d.var_a8539bf6 = var_a8539bf6;
					if(!(isdefined(var_5e63b00d.script_enable_on_start) && var_5e63b00d.script_enable_on_start))
					{
						var_a8539bf6 gameobjects::disable_object(1);
					}
					if(isdefined(var_5e63b00d.var_d1cae5f4) && var_5e63b00d.var_d1cae5f4)
					{
						if(isdefined(var_5e63b00d.script_waittill))
						{
							var_5e63b00d thread function_8ecf6615(var_a8539bf6.mdl_gameobject.var_3af54106);
						}
						var_5e63b00d thread function_69996073(var_a8539bf6.mdl_gameobject.var_3af54106);
					}
					level function_8f66239f(var_5e63b00d.var_d513a1cb);
					/#
						var_5e63b00d function_ef942626();
					#/
				}
			}
			else
			{
				/#
					printerror("" + var_5e63b00d.scriptbundlename);
				#/
			}
			continue;
		}
		/#
			printerror("");
		#/
	}
}

/*
	Name: register_trap
	Namespace: traps_deployable
	Checksum: 0x5399EDA9
	Offset: 0x7D0
	Size: 0x3B6
	Parameters: 1
	Flags: None
*/
function register_trap(var_2d727ba0)
{
	var_a8539bf6 = self;
	if(isdefined(var_2d727ba0) && isdefined(var_2d727ba0.trap_type))
	{
		switch(var_2d727ba0.trap_type)
		{
			case "generic":
			{
				function_2ce21754(var_2d727ba0.trap_type, &function_c75a9937, &function_6ce6a400, &function_2b8baf6d, &function_a879466e, &function_efe68db2, &function_6ef47474, &function_a21e6a22);
				break;
			}
			case "fire_bomb":
			case "flash_disruptor":
			case "mine":
			case "claymore":
			{
				function_2ce21754(var_2d727ba0.trap_type, &function_3c3f30e3, &function_6ce6a400, &function_2b8baf6d, &function_a879466e, &function_4a401677, &function_6ef47474, &function_b501ff0b);
				break;
			}
			case "guardian":
			case "turret":
			{
				function_2ce21754(var_2d727ba0.trap_type, &function_a39b7bb6, &function_6ce6a400, &function_69efb3b0, &function_a879466e, &function_612e5ef9, &function_6ef47474, &function_b501ff0b);
				break;
			}
			case "vehicle":
			{
				function_2ce21754(var_2d727ba0.trap_type, &function_deb3cb22, &function_6ce6a400, &function_51d36222, &function_c66a11d0, &function_5c1d01, &function_6ef47474, &function_b501ff0b);
				break;
			}
			default:
			{
				/#
					assertmsg("" + var_2d727ba0.trap_type);
				#/
				/#
					printerror("");
				#/
				return;
			}
		}
		if(var_a8539bf6 function_cf4b6e75(var_2d727ba0))
		{
			return true;
		}
	}
	/#
		printerror("");
	#/
	return false;
}

/*
	Name: function_cf4b6e75
	Namespace: traps_deployable
	Checksum: 0x108AEAB6
	Offset: 0xB90
	Size: 0xDE
	Parameters: 1
	Flags: None
*/
function function_cf4b6e75(var_2d727ba0)
{
	var_a8539bf6 = self;
	if(isdefined(var_2d727ba0.gameobject))
	{
		var_3af54106 = new class_7b5e0861();
		[[ var_3af54106 ]]->function_8df621c(var_2d727ba0, var_a8539bf6);
		var_a8539bf6 function_19e12558(var_3af54106, var_a8539bf6.origin, var_a8539bf6.angles);
		/#
			printinfo("" + var_2d727ba0.name);
		#/
		return true;
	}
	/#
		printerror("");
	#/
	return false;
}

/*
	Name: function_19e12558
	Namespace: traps_deployable
	Checksum: 0x741785EB
	Offset: 0xC78
	Size: 0x224
	Parameters: 4
	Flags: None
*/
function function_19e12558(var_3af54106, origin, angles, var_563080be = undefined)
{
	var_a8539bf6 = self;
	model = var_3af54106.m_model;
	var_ed8e6d51 = undefined;
	if(isdefined(model))
	{
		var_ed8e6d51 = util::spawn_model(model, origin, angles);
	}
	if(isdefined(origin) && isdefined(angles))
	{
		var_a8539bf6.origin = origin;
		var_a8539bf6.angles = angles;
	}
	var_a8539bf6 gameobjects::init_game_objects(var_a8539bf6.gameobject, var_a8539bf6.team, 0, undefined, var_ed8e6d51);
	var_a8539bf6 gameobjects::set_onuse_event(&function_e191d35c);
	if(isdefined(var_a8539bf6.mdl_gameobject.trigger) && (!(isdefined(var_a8539bf6.mdl_gameobject.trigger.var_a865c2cd) && var_a8539bf6.mdl_gameobject.trigger.var_a865c2cd)))
	{
		var_a8539bf6.mdl_gameobject gameobjects::set_use_hint_text(var_3af54106.var_656cbe2d);
	}
	var_a8539bf6.mdl_gameobject.trigger usetriggerrequirelookat();
	if(isdefined(var_563080be))
	{
		var_a8539bf6.mdl_gameobject.b_reusable = 0;
	}
	var_a8539bf6.mdl_gameobject.var_3af54106 = var_3af54106;
	var_3af54106 function_94e3167b(var_a8539bf6.mdl_gameobject);
}

/*
	Name: function_2ce21754
	Namespace: traps_deployable
	Checksum: 0x621D741B
	Offset: 0xEA8
	Size: 0x144
	Parameters: 8
	Flags: None
*/
function function_2ce21754(type, onplacecallback, oncancelcallback, onmovecallback, var_11451882, var_f4ff98c9, ondamagecallback, damagewrapper)
{
	if(function_77a3b730(type))
	{
		return;
	}
	function_422733d9(type);
	function_1abc0efa(type, onplacecallback);
	function_b7d6919(type, oncancelcallback);
	function_8bcde666(type, onmovecallback);
	function_fe99979d(type, ondamagecallback);
	function_670497bc(type, var_11451882);
	function_51a2f229(type, var_f4ff98c9);
	function_f885ebd3(type, damagewrapper);
	/#
		printinfo("" + type);
	#/
}

/*
	Name: function_77a3b730
	Namespace: traps_deployable
	Checksum: 0xA6456908
	Offset: 0xFF8
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function function_77a3b730(type)
{
	return isdefined(level._traps_deployable) && isdefined(level._traps_deployable.traptypes) && isdefined(level._traps_deployable.traptypes[type]);
}

/*
	Name: function_422733d9
	Namespace: traps_deployable
	Checksum: 0xB60317F1
	Offset: 0x1050
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function function_422733d9(type)
{
	if(!isdefined(level._traps_deployable))
	{
		level._traps_deployable = spawnstruct();
	}
	if(!isdefined(level._traps_deployable.traptypes))
	{
		level._traps_deployable.traptypes = [];
	}
	if(!isdefined(level._traps_deployable.traptypes[type]))
	{
		level._traps_deployable.traptypes[type] = spawnstruct();
	}
}

/*
	Name: add_callback
	Namespace: traps_deployable
	Checksum: 0x40A66D11
	Offset: 0x1100
	Size: 0x70
	Parameters: 3
	Flags: None
*/
function add_callback(type, callbackname, callbackfunc)
{
	if(function_77a3b730(type))
	{
		if(isdefined(callbackname) && isdefined(callbackfunc))
		{
			level._traps_deployable.traptypes[type].(callbackname) = callbackfunc;
		}
	}
}

/*
	Name: function_1abc0efa
	Namespace: traps_deployable
	Checksum: 0x50310B84
	Offset: 0x1178
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_1abc0efa(type, callback)
{
	add_callback(type, "onPlaceCallback", callback);
}

/*
	Name: function_b7d6919
	Namespace: traps_deployable
	Checksum: 0x9AD9D385
	Offset: 0x11B8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_b7d6919(type, callback)
{
	add_callback(type, "onCancelCallback", callback);
}

/*
	Name: function_8bcde666
	Namespace: traps_deployable
	Checksum: 0xC9F197C7
	Offset: 0x11F8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_8bcde666(type, callback)
{
	add_callback(type, "onMoveCallback", callback);
}

/*
	Name: function_670497bc
	Namespace: traps_deployable
	Checksum: 0x67552FB7
	Offset: 0x1238
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_670497bc(type, callback)
{
	add_callback(type, "onActivateTrap", callback);
}

/*
	Name: function_51a2f229
	Namespace: traps_deployable
	Checksum: 0x825E3044
	Offset: 0x1278
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_51a2f229(type, callback)
{
	add_callback(type, "onAutoActivateTrap", callback);
}

/*
	Name: function_fe99979d
	Namespace: traps_deployable
	Checksum: 0xD57E4592
	Offset: 0x12B8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_fe99979d(type, callback)
{
	add_callback(type, "onDamageCallback", callback);
}

/*
	Name: function_f885ebd3
	Namespace: traps_deployable
	Checksum: 0x7295BDCA
	Offset: 0x12F8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_f885ebd3(type, callback)
{
	add_callback(type, "damageWrapper", callback);
}

/*
	Name: function_e191d35c
	Namespace: traps_deployable
	Checksum: 0xB84AAAC1
	Offset: 0x1338
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_e191d35c(e_player)
{
	e_gameobject = self;
	e_player thread activate_trap(e_gameobject.var_3af54106, e_gameobject.origin, e_gameobject.angles);
}

/*
	Name: function_51ca9c38
	Namespace: traps_deployable
	Checksum: 0xCB8073A9
	Offset: 0x1398
	Size: 0x16A
	Parameters: 2
	Flags: None
*/
function function_51ca9c38(origin, team)
{
	actorteam = team;
	if(actorteam == #"any")
	{
		actorteam = "all";
	}
	owners = getactorteamarray(actorteam);
	foreach(player in level.players)
	{
		if(player.team == team || team == #"any")
		{
			if(!isdefined(owners))
			{
				owners = [];
			}
			else if(!isarray(owners))
			{
				owners = array(owners);
			}
			owners[owners.size] = player;
		}
	}
	owner = arraygetclosest(origin, owners);
	return owner;
}

/*
	Name: function_6153484f
	Namespace: traps_deployable
	Checksum: 0xA150B285
	Offset: 0x1510
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_6153484f(team)
{
	if(!isdefined(level._traps_deployable.team_owners))
	{
		level._traps_deployable.team_owners = [];
	}
	if(!isdefined(level._traps_deployable.team_owners[team]))
	{
		level._traps_deployable.team_owners[team] = spawn("script_origin", (0, 0, 0));
	}
	level._traps_deployable.team_owners[team].team = team;
	return level._traps_deployable.team_owners[team];
}

/*
	Name: function_69996073
	Namespace: traps_deployable
	Checksum: 0xB4736173
	Offset: 0x15D8
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function function_69996073(var_3af54106)
{
	var_5e63b00d = self;
	var_5e63b00d.var_a8539bf6.mdl_gameobject endon(#"destroyed_complete", #"death");
	var_5e63b00d flag::function_5f02becb();
	teamowner = undefined;
	team = util::get_team_mapping(var_5e63b00d.var_a8539bf6.team);
	if(team == #"any")
	{
		var_db4c606e = function_51ca9c38(var_5e63b00d.var_a8539bf6.origin, team);
		team = var_db4c606e.team;
	}
	teamowner = function_6153484f(team);
	var_5e63b00d.var_a8539bf6 thread function_186e3cc4(var_3af54106, teamowner, team);
}

/*
	Name: function_8ecf6615
	Namespace: traps_deployable
	Checksum: 0x5DED5722
	Offset: 0x1718
	Size: 0x18C
	Parameters: 1
	Flags: None
*/
function function_8ecf6615(var_3af54106)
{
	var_5e63b00d = self;
	var_5e63b00d.var_a8539bf6.mdl_gameobject endon(#"destroyed_complete", #"death");
	waitresult = undefined;
	waitresult = level waittill(var_5e63b00d.script_waittill);
	teamowner = waitresult.owner;
	team = waitresult.team;
	if(!isdefined(teamowner) || !isplayer(teamowner))
	{
		if(!isdefined(team))
		{
			team = util::get_team_mapping(var_5e63b00d.var_a8539bf6.team);
		}
		if(team == #"any")
		{
			var_db4c606e = function_51ca9c38(var_5e63b00d.var_a8539bf6.origin, team);
			team = var_db4c606e.team;
		}
		teamowner = function_6153484f(team);
	}
	var_5e63b00d.var_a8539bf6 thread function_186e3cc4(var_3af54106, teamowner, team);
}

/*
	Name: function_186e3cc4
	Namespace: traps_deployable
	Checksum: 0x5ECFC9E4
	Offset: 0x18B0
	Size: 0x1E4
	Parameters: 3
	Flags: None
*/
function function_186e3cc4(var_3af54106, owner, team)
{
	var_a8539bf6 = self;
	type = var_3af54106.m_type;
	if(isdefined(owner))
	{
		owner owner_init();
		time = gettime();
		if(isdefined(owner._traps_deployable.var_1b518274))
		{
			while(owner._traps_deployable.var_1b518274 == time)
			{
				waitframe(1);
				if(!isdefined(owner))
				{
					/#
						printerror(("" + var_3af54106.m_name) + "");
					#/
					return;
				}
				time = gettime();
			}
		}
		owner._traps_deployable.var_1b518274 = time;
		if(function_77a3b730(type) && isdefined(level._traps_deployable.traptypes[type].onautoactivatetrap))
		{
			tracktrap = var_a8539bf6 [[level._traps_deployable.traptypes[type].onautoactivatetrap]](var_3af54106, owner, team);
		}
		waitframe(1);
		if(isdefined(var_a8539bf6.mdl_gameobject))
		{
			var_a8539bf6.mdl_gameobject thread gameobjects::check_gameobject_reenable();
		}
	}
	else
	{
		/#
			printerror(("" + var_3af54106.m_name) + "");
		#/
	}
}

/*
	Name: activate_trap
	Namespace: traps_deployable
	Checksum: 0x84FC1CEB
	Offset: 0x1AA0
	Size: 0x10C
	Parameters: 3
	Flags: None
*/
function activate_trap(var_3af54106, origin, angles)
{
	player = self;
	type = var_3af54106.m_type;
	player owner_init();
	self._traps_deployable.var_18bbaaf9 = 1;
	if(function_77a3b730(type) && isdefined(level._traps_deployable.traptypes[type].onactivatetrap))
	{
		player [[level._traps_deployable.traptypes[type].onactivatetrap]](var_3af54106, origin, angles);
	}
	else
	{
		/#
			printerror(("" + var_3af54106.m_name) + "");
		#/
	}
}

/*
	Name: track_trap
	Namespace: traps_deployable
	Checksum: 0x3C9F4F4A
	Offset: 0x1BB8
	Size: 0x16E
	Parameters: 1
	Flags: None
*/
function track_trap(var_3c8e8a80)
{
	var_3af54106 = self;
	if(!isdefined(level._traps_deployable.var_1d76a8c4))
	{
		level._traps_deployable.var_1d76a8c4 = [];
	}
	if(isdefined(var_3c8e8a80))
	{
		if(isdefined(var_3af54106.var_3efa7c17.var_5b026504))
		{
			var_3c8e8a80.var_5b026504 = var_3af54106.var_3efa7c17.var_5b026504;
		}
		if(isdefined(var_3af54106.var_3efa7c17.var_ef146db5))
		{
			var_3c8e8a80.var_ef146db5 = var_3af54106.var_3efa7c17.var_ef146db5;
		}
		if(!isdefined(level._traps_deployable.var_1d76a8c4))
		{
			level._traps_deployable.var_1d76a8c4 = [];
		}
		else if(!isarray(level._traps_deployable.var_1d76a8c4))
		{
			level._traps_deployable.var_1d76a8c4 = array(level._traps_deployable.var_1d76a8c4);
		}
		level._traps_deployable.var_1d76a8c4[level._traps_deployable.var_1d76a8c4.size] = var_3c8e8a80;
	}
}

/*
	Name: function_94e3167b
	Namespace: traps_deployable
	Checksum: 0x4E2CCDDB
	Offset: 0x1D30
	Size: 0x16E
	Parameters: 1
	Flags: None
*/
function function_94e3167b(mdl_gameobject)
{
	var_3af54106 = self;
	if(!isdefined(level._traps_deployable.var_9afef5eb))
	{
		level._traps_deployable.var_9afef5eb = [];
	}
	if(isdefined(mdl_gameobject))
	{
		if(isdefined(var_3af54106.var_3efa7c17.var_5b026504))
		{
			mdl_gameobject.var_5b026504 = var_3af54106.var_3efa7c17.var_5b026504;
		}
		if(isdefined(var_3af54106.var_3efa7c17.var_ef146db5))
		{
			mdl_gameobject.var_ef146db5 = var_3af54106.var_3efa7c17.var_ef146db5;
		}
		if(!isdefined(level._traps_deployable.var_9afef5eb))
		{
			level._traps_deployable.var_9afef5eb = [];
		}
		else if(!isarray(level._traps_deployable.var_9afef5eb))
		{
			level._traps_deployable.var_9afef5eb = array(level._traps_deployable.var_9afef5eb);
		}
		level._traps_deployable.var_9afef5eb[level._traps_deployable.var_9afef5eb.size] = mdl_gameobject;
	}
}

/*
	Name: function_c26db3e
	Namespace: traps_deployable
	Checksum: 0xD3353A16
	Offset: 0x1EA8
	Size: 0x20
	Parameters: 3
	Flags: None
*/
function function_c26db3e(origin, angles, player)
{
	return true;
}

/*
	Name: function_e4fd9a4c
	Namespace: traps_deployable
	Checksum: 0xCF0B1EA6
	Offset: 0x1ED0
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_e4fd9a4c(var_3af54106)
{
}

/*
	Name: function_df4e6283
	Namespace: traps_deployable
	Checksum: 0xDB0FF775
	Offset: 0x1EE8
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_df4e6283(var_3af54106)
{
}

/*
	Name: function_a879466e
	Namespace: traps_deployable
	Checksum: 0xE931558
	Offset: 0x1F00
	Size: 0x43C
	Parameters: 3
	Flags: None
*/
function function_a879466e(var_3af54106, origin, angles)
{
	player = self;
	type = var_3af54106.m_type;
	if(function_77a3b730(type))
	{
		onmovecallback = level._traps_deployable.traptypes[type].onmovecallback;
		if(var_3af54106.var_31e7e66a === 1)
		{
			onmovecallback = undefined;
		}
		if(isdefined(var_3af54106.m_weapon) && var_3af54106.m_weapon.deployable)
		{
			player function_e4fd9a4c(var_3af54106);
			placeable = player placeables::function_f872b831(level._traps_deployable.traptypes[type].onplacecallback, level._traps_deployable.traptypes[type].oncancelcallback, onmovecallback, level._traps_deployable.traptypes[type].onshutdowncallback, level._traps_deployable.traptypes[type].ondeathcallback, level._traps_deployable.traptypes[type].onempcallback, level._traps_deployable.traptypes[type].ondamagecallback, level._traps_deployable.traptypes[type].var_d0dd7e76, &function_c26db3e, var_3af54106.m_weapon, var_3af54106.var_656cbe2d, var_3af54106.var_f81e0192, var_3af54106.var_b4662b52, var_3af54106.m_timeout);
			placeable.var_3af54106 = var_3af54106;
			placeable.is_placeable = 1;
			placeable.var_25404db4 = 1;
			placeable placeables::function_613a226a(1);
		}
		else
		{
			placeable = player placeables::spawnplaceable(level._traps_deployable.traptypes[type].onplacecallback, level._traps_deployable.traptypes[type].oncancelcallback, onmovecallback, level._traps_deployable.traptypes[type].onshutdowncallback, level._traps_deployable.traptypes[type].ondeathcallback, level._traps_deployable.traptypes[type].onempcallback, level._traps_deployable.traptypes[type].ondamagecallback, level._traps_deployable.traptypes[type].var_d0dd7e76, var_3af54106.m_model, var_3af54106.var_e84fc5dc, var_3af54106.var_28f1ce55, var_3af54106.m_spawnsentity, var_3af54106.var_656cbe2d, var_3af54106.m_timeout, var_3af54106.m_health, var_3af54106.m_empdamage, var_3af54106.var_f81e0192, var_3af54106.var_b4662b52, var_3af54106.m_placeimmediately, level._traps_deployable.traptypes[type].damagewrapper);
			placeable.var_3af54106 = var_3af54106;
			placeable.is_placeable = 1;
			placeable.var_25404db4 = 1;
			placeable placeables::function_613a226a(1);
			placeable notsolid();
		}
	}
}

/*
	Name: function_c75a9937
	Namespace: traps_deployable
	Checksum: 0xE0A38255
	Offset: 0x2348
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_c75a9937(placeable)
{
	player = self;
	var_3af54106 = placeable.var_3af54106;
	player function_df4e6283(var_3af54106);
}

/*
	Name: function_6ce6a400
	Namespace: traps_deployable
	Checksum: 0xC1A05105
	Offset: 0x23A0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_6ce6a400(placeable)
{
	player = self;
	var_3af54106 = placeable.var_3af54106;
	player function_df4e6283(var_3af54106);
	placeable.var_3af54106.var_3efa7c17 function_19e12558(placeable.var_3af54106, placeable.origin, placeable.angles, 1);
}

/*
	Name: function_2b8baf6d
	Namespace: traps_deployable
	Checksum: 0xB77F319D
	Offset: 0x2448
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function function_2b8baf6d(placeable)
{
	player = self;
	var_3af54106 = placeable.var_3af54106;
	player function_e4fd9a4c(var_3af54106);
	placeable.cancelable = 1;
}

/*
	Name: function_efe68db2
	Namespace: traps_deployable
	Checksum: 0x6BF0A4F5
	Offset: 0x24B0
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function function_efe68db2(var_3af54106, owner, team)
{
	var_a8539bf6 = self;
	/#
		printerror("" + var_a8539bf6.scriptbundlename);
	#/
	return var_3af54106;
}

/*
	Name: function_6ef47474
	Namespace: traps_deployable
	Checksum: 0x80F724D1
	Offset: 0x2510
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_6ef47474()
{
}

/*
	Name: function_a21e6a22
	Namespace: traps_deployable
	Checksum: 0x8A2F9A54
	Offset: 0x2520
	Size: 0x84
	Parameters: 4
	Flags: None
*/
function function_a21e6a22(damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6)
{
	placeable = self;
	placeable function_b501ff0b(damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6);
	placeable thread function_59a79a68(placeable.var_3af54106, damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6);
}

/*
	Name: function_b501ff0b
	Namespace: traps_deployable
	Checksum: 0x6FCD217D
	Offset: 0x25B0
	Size: 0x94
	Parameters: 4
	Flags: None
*/
function function_b501ff0b(damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6)
{
	waitframe(1);
	placeable = self;
	placeable.health = 9999999;
	placeable.damagetaken = 0;
	placeable function_6253b65f(placeable.var_3af54106.m_health, placeable.var_3af54106.var_c59ba447);
}

/*
	Name: function_59a79a68
	Namespace: traps_deployable
	Checksum: 0xA75E2F1
	Offset: 0x2650
	Size: 0x46E
	Parameters: 5
	Flags: None
*/
function function_59a79a68(var_3af54106, damage_callback, destroyed_callback, emp_damage, emp_callback)
{
	self endon(#"death", #"delete");
	/#
		assert(!isvehicle(self) || !issentient(self), "");
	#/
	while(true)
	{
		weapon_damage = undefined;
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		inflictor = waitresult.inflictor;
		damage = waitresult.amount;
		type = waitresult.mod;
		weapon = waitresult.weapon;
		if(isdefined(self.invulnerable) && self.invulnerable)
		{
			continue;
		}
		if(!isdefined(attacker))
		{
			continue;
		}
		friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
		if(!friendlyfire)
		{
			continue;
		}
		isvalidattacker = 1;
		if(level.teambased)
		{
			isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
		}
		if(weapon.isemp && type == "MOD_GRENADE_SPLASH")
		{
			emp_damage_to_apply = var_3af54106.m_empdamage;
			if(!isdefined(emp_damage_to_apply))
			{
				emp_damage_to_apply = (isdefined(emp_damage) ? emp_damage : 1);
			}
			if(isdefined(emp_callback) && emp_damage_to_apply > 0)
			{
				self [[emp_callback]](attacker);
			}
			weapon_damage = emp_damage_to_apply;
		}
		if(isdefined(self.selfdestruct) && self.selfdestruct)
		{
			weapon_damage = self.maxhealth + 1;
		}
		if(!isdefined(weapon_damage))
		{
			weapon_damage = damage;
		}
		if(weapon_damage > 0)
		{
			if(damagefeedback::dodamagefeedback(weapon, inflictor, weapon_damage, type))
			{
				attacker damagefeedback::update();
			}
			self challenges::trackassists(attacker, weapon_damage, 0);
		}
		self.damagetaken = self.damagetaken + weapon_damage;
		if(!issentient(self) && weapon_damage > 0)
		{
			self.attacker = attacker;
		}
		if(self.damagetaken > self.maxhealth)
		{
			weaponstatname = "destroyed";
			switch(weapon.name)
			{
				case "tow_turret":
				case "tow_turret_drop":
				case "auto_tow":
				{
					weaponstatname = "kills";
					break;
				}
			}
			if(isdefined(destroyed_callback))
			{
				self thread [[destroyed_callback]](attacker, weapon);
			}
			return;
		}
		remaining_health = self.maxhealth - self.damagetaken;
		if(remaining_health < self.lowhealth && weapon_damage > 0)
		{
			self.currentstate = "damaged";
		}
	}
}

/*
	Name: function_6253b65f
	Namespace: traps_deployable
	Checksum: 0x6671D638
	Offset: 0x2AC8
	Size: 0x3E
	Parameters: 2
	Flags: None
*/
function function_6253b65f(max_health, low_health)
{
	self.maxhealth = max_health;
	self.lowhealth = low_health;
	self.hackedhealth = self.maxhealth;
}

/*
	Name: function_da421875
	Namespace: traps_deployable
	Checksum: 0x6F903FD0
	Offset: 0x2B10
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_da421875(placeable)
{
	self waittill(#"death");
	if(isdefined(placeable) && (isdefined(placeable.is_placeable) && placeable.is_placeable))
	{
		placeable placeables::forceshutdown();
	}
}

/*
	Name: watcher_init
	Namespace: traps_deployable
	Checksum: 0x77D7C19F
	Offset: 0x2B80
	Size: 0x210
	Parameters: 1
	Flags: None
*/
function watcher_init(var_3af54106)
{
	owner = self;
	var_c29551e1 = var_3af54106.m_weapon.name;
	var_c98531e5 = undefined;
	if(!(isdefined(owner._traps_deployable.watchers_init[var_c29551e1]) && owner._traps_deployable.watchers_init[var_c29551e1]))
	{
		type = var_3af54106.m_type;
		if(type == "claymore")
		{
			var_c98531e5 = owner weaponobjects::createwatcher(var_c29551e1, &trapd::function_ae7e49da, 0);
		}
		else
		{
			if(type == "flash_disruptor")
			{
				var_c98531e5 = owner weaponobjects::createwatcher(var_c29551e1, &trapd::function_d8d3b49b, 0);
			}
			else
			{
				if(type == "fire_bomb")
				{
					var_c98531e5 = owner weaponobjects::createwatcher(var_c29551e1, &trapd::function_518130e, 0);
				}
				else
				{
					var_c98531e5 = owner weaponobjects::createwatcher(var_c29551e1, &trapd::function_1daa29fc, 0);
				}
			}
		}
		owner._traps_deployable.watchers_init[var_c29551e1] = 1;
	}
	else
	{
		var_c98531e5 = owner weaponobjects::getweaponobjectwatcher(var_c29551e1);
	}
	if(!isplayer(owner))
	{
		owner thread weaponobjects::watchweaponobjectspawn("grenade_fire", "death");
	}
	return var_c98531e5;
}

/*
	Name: function_3c3f30e3
	Namespace: traps_deployable
	Checksum: 0x4B569823
	Offset: 0x2D98
	Size: 0x160
	Parameters: 1
	Flags: None
*/
function function_3c3f30e3(placeable)
{
	player = self;
	var_3af54106 = placeable.var_3af54106;
	if(isplayer(player))
	{
		var_c98531e5 = player watcher_init(var_3af54106);
		placeable.weapon_instance = player magicgrenadeplayer(var_3af54106.m_weapon, placeable.origin, (0, 0, -1));
		if(isdefined(placeable.weapon_instance))
		{
			placeable.weapon_instance.angles = placeable.angles;
			placeable.weapon_instance.var_cea6a2fb = placeable;
			var_3c8e8a80 = spawnstruct();
			var_3c8e8a80.var_c98531e5 = var_c98531e5;
			var_3c8e8a80.weapon_instance = placeable.weapon_instance;
			var_3af54106 track_trap(var_3c8e8a80);
			player function_c75a9937(placeable);
		}
	}
	return var_3af54106;
}

/*
	Name: function_4a401677
	Namespace: traps_deployable
	Checksum: 0x7AD5EC20
	Offset: 0x2F00
	Size: 0x248
	Parameters: 3
	Flags: None
*/
function function_4a401677(var_3af54106, owner, team)
{
	var_a8539bf6 = self;
	if(isdefined(owner))
	{
		weapon_instance = undefined;
		var_c98531e5 = owner watcher_init(var_3af54106);
		if(isplayer(owner))
		{
			weapon_instance = owner magicgrenadeplayer(var_3af54106.m_weapon, var_a8539bf6.origin, (0, 0, -1));
		}
		else
		{
			weapon_instance = owner magicgrenadetype(var_3af54106.m_weapon, var_a8539bf6.origin, (0, 0, -1));
		}
		if(isdefined(weapon_instance))
		{
			weapon_instance.angles = var_a8539bf6.angles;
			var_3c8e8a80 = spawnstruct();
			var_3c8e8a80.weapon_instance = weapon_instance;
			var_3c8e8a80.var_c98531e5 = var_c98531e5;
			var_3af54106 track_trap(var_3c8e8a80);
			if(!isdefined(var_a8539bf6.var_6a698b3c))
			{
				var_a8539bf6.var_6a698b3c = [];
			}
			else if(!isarray(var_a8539bf6.var_6a698b3c))
			{
				var_a8539bf6.var_6a698b3c = array(var_a8539bf6.var_6a698b3c);
			}
			var_a8539bf6.var_6a698b3c[var_a8539bf6.var_6a698b3c.size] = weapon_instance;
			var_a8539bf6.var_6a698b3c = array::remove_undefined(var_a8539bf6.var_6a698b3c);
		}
	}
	else
	{
		/#
			printerror(("" + var_3af54106.m_name) + "");
		#/
	}
	return var_3af54106;
}

/*
	Name: function_612e5ef9
	Namespace: traps_deployable
	Checksum: 0x7459EB3A
	Offset: 0x3150
	Size: 0xC0
	Parameters: 3
	Flags: None
*/
function function_612e5ef9(var_3af54106, owner, team)
{
	var_a8539bf6 = self;
	vehicle = turret_activate(var_3af54106, owner, team, undefined, var_a8539bf6.origin, var_a8539bf6.angles, undefined);
	if(isdefined(vehicle))
	{
		var_3c8e8a80 = spawnstruct();
		var_3c8e8a80.var_71676691 = vehicle;
		var_3af54106 track_trap(var_3c8e8a80);
	}
	return var_3af54106;
}

/*
	Name: function_a39b7bb6
	Namespace: traps_deployable
	Checksum: 0x9628E886
	Offset: 0x3218
	Size: 0x120
	Parameters: 1
	Flags: None
*/
function function_a39b7bb6(placeable)
{
	player = self;
	var_3af54106 = placeable.var_3af54106;
	placeable.vehicle = player turret_activate(var_3af54106, player, player.team, placeable.vehicle, placeable.origin, placeable.angles, placeable);
	if(isdefined(placeable.vehicle))
	{
		placeable.vehicle thread util::ghost_wait_show(0.05);
		var_3c8e8a80 = spawnstruct();
		var_3c8e8a80.var_71676691 = placeable.vehicle;
		var_3c8e8a80.var_cea6a2fb = placeable;
		var_3af54106 track_trap(var_3c8e8a80);
	}
	return var_3af54106;
}

/*
	Name: turret_activate
	Namespace: traps_deployable
	Checksum: 0xE727B3AB
	Offset: 0x3340
	Size: 0x448
	Parameters: 7
	Flags: None
*/
function turret_activate(var_3af54106, owner, team, vehicle, origin, angles, parent)
{
	if(isdefined(vehicle))
	{
		vehicle.origin = origin;
		vehicle.angles = angles;
		if(vehicle vehicle_ai::has_state("unaware"))
		{
			vehicle vehicle_ai::set_state("unaware");
		}
	}
	else
	{
		vehicle = spawnvehicle(var_3af54106.m_vehicle, origin, angles, "dynamic_spawn_ai");
		if(isdefined(owner))
		{
			ownerteam = owner.team;
			vehicle.owner = owner;
			vehicle.ownerentnum = owner.entnum;
			if(isplayer(owner))
			{
				vehicle setowner(owner);
			}
		}
		if(!isdefined(team))
		{
			team = ownerteam;
		}
		if(isdefined(team))
		{
			vehicle.team = team;
			vehicle setteam(team);
		}
		vehicle.parentstruct = parent;
		vehicle.controlled = 0;
		vehicle.treat_owner_damage_as_friendly_fire = 1;
		vehicle.ignore_team_kills = 1;
		vehicle.deal_no_crush_damage = 1;
		if(isdefined(vehicle.parentstruct) && (isdefined(vehicle.parentstruct.is_placeable) && vehicle.parentstruct.is_placeable))
		{
			vehicle thread function_da421875(vehicle.parentstruct);
		}
	}
	if(isdefined(vehicle.settings.var_d3cc01c7) && vehicle.settings.var_d3cc01c7 && (!(isdefined(vehicle.var_fcb567c8) && vehicle.var_fcb567c8)))
	{
		if(!isdefined(level.var_c70c6768))
		{
			level.var_c70c6768 = 0;
		}
		else
		{
			level.var_c70c6768 = level.var_c70c6768 + 1;
		}
		vehicle.turret_id = string(level.var_c70c6768);
		badplace_cylinder("turret_bad_place_" + vehicle.turret_id, 0, vehicle.origin, vehicle.settings.var_9493f6dc, vehicle.settings.var_c9c01aa4, #"axis", #"allies", #"neutral");
		vehicle.var_fcb567c8 = 1;
	}
	vehicle unlink();
	loc_00003704:
	loc_00003736:
	targetoffset = ((isdefined(vehicle.settings.settings.lockon_offsetx) ? vehicle.settings.lockon_offsetx : 0), (isdefined(vehicle.settings.settings.lockon_offsety) ? vehicle.settings.lockon_offsety : 0), (isdefined(vehicle.settings.settings.lockon_offsetz) ? vehicle.settings.lockon_offsetz : 36));
	vehicle::make_targetable(vehicle, targetoffset);
	return vehicle;
}

/*
	Name: function_69efb3b0
	Namespace: traps_deployable
	Checksum: 0x23C00F0F
	Offset: 0x3790
	Size: 0x152
	Parameters: 1
	Flags: None
*/
function function_69efb3b0(placeable)
{
	player = self;
	if(isdefined(placeable.vehicle))
	{
		placeable.cancelable = 1;
		placeable.vehicle ghost();
		if(placeable.vehicle vehicle_ai::has_state("off"))
		{
			placeable.vehicle vehicle_ai::set_state("off");
		}
		placeable.vehicle linkto(placeable);
		target_remove(placeable.vehicle);
		if(isdefined(placeable.vehicle.var_fcb567c8) && placeable.vehicle.var_fcb567c8)
		{
			badplace_delete("turret_bad_place_" + placeable.vehicle.turret_id);
			placeable.vehicle.var_fcb567c8 = 0;
		}
	}
}

/*
	Name: function_5c1d01
	Namespace: traps_deployable
	Checksum: 0x7C58BF96
	Offset: 0x38F0
	Size: 0xC0
	Parameters: 3
	Flags: None
*/
function function_5c1d01(var_3af54106, owner, team)
{
	var_a8539bf6 = self;
	vehicle = vehicle_activate(var_3af54106, owner, team, undefined, var_a8539bf6.origin, var_a8539bf6.angles, undefined);
	if(isdefined(vehicle))
	{
		var_3c8e8a80 = spawnstruct();
		var_3c8e8a80.var_71676691 = vehicle;
		var_3af54106 track_trap(var_3c8e8a80);
	}
	return var_3af54106;
}

/*
	Name: function_c66a11d0
	Namespace: traps_deployable
	Checksum: 0x39F18212
	Offset: 0x39B8
	Size: 0xE8
	Parameters: 3
	Flags: None
*/
function function_c66a11d0(var_3af54106, origin, angles)
{
	player = self;
	if(!isdefined(origin))
	{
		origin = player.origin;
	}
	if(!isdefined(angles))
	{
		angles = player.angles;
	}
	vehicle = vehicle_activate(var_3af54106, player, player.team, undefined, origin, angles, undefined);
	if(isdefined(vehicle))
	{
		var_3c8e8a80 = spawnstruct();
		var_3c8e8a80.var_71676691 = vehicle;
		var_3af54106 track_trap(var_3c8e8a80);
	}
	return var_3af54106;
}

/*
	Name: vehicle_activate
	Namespace: traps_deployable
	Checksum: 0x8DE288C4
	Offset: 0x3AA8
	Size: 0x2D0
	Parameters: 7
	Flags: None
*/
function vehicle_activate(var_3af54106, owner, team, vehicle, origin, angles, parent)
{
	if(isdefined(vehicle))
	{
		vehicle.origin = origin;
		vehicle.angles = angles;
	}
	else
	{
		vehicle = spawnvehicle(var_3af54106.m_vehicle, origin, angles, "dynamic_spawn_ai");
		if(isdefined(owner))
		{
			ownerteam = owner.team;
			vehicle.owner = owner;
			vehicle.ownerentnum = owner.entnum;
			if(isplayer(owner))
			{
				vehicle setowner(owner);
			}
		}
		if(!isdefined(team))
		{
			team = ownerteam;
		}
		if(isdefined(team))
		{
			vehicle.team = team;
			vehicle setteam(team);
		}
		vehicle.parentstruct = parent;
		vehicle.controlled = 0;
		vehicle.treat_owner_damage_as_friendly_fire = 1;
		vehicle.ignore_team_kills = 1;
		vehicle.deal_no_crush_damage = 1;
		if(isdefined(vehicle.parentstruct) && (isdefined(vehicle.parentstruct.is_placeable) && vehicle.parentstruct.is_placeable))
		{
			vehicle thread function_da421875(vehicle.parentstruct);
		}
	}
	vehicle unlink();
	loc_00003CF2:
	loc_00003D22:
	targetoffset = ((isdefined(vehicle.settings.settings.lockon_offsetx) ? vehicle.settings.lockon_offsetx : 0), (isdefined(vehicle.settings.settings.lockon_offsety) ? vehicle.settings.lockon_offsety : 0), (isdefined(vehicle.settings.settings.lockon_offsetz) ? vehicle.settings.lockon_offsetz : 0));
	vehicle::make_targetable(vehicle, targetoffset);
	return vehicle;
}

/*
	Name: function_deb3cb22
	Namespace: traps_deployable
	Checksum: 0x80F724D1
	Offset: 0x3D80
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_deb3cb22()
{
}

/*
	Name: function_51d36222
	Namespace: traps_deployable
	Checksum: 0x80F724D1
	Offset: 0x3D90
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_51d36222()
{
}

/*
	Name: function_ad3a08af
	Namespace: traps_deployable
	Checksum: 0xABDE3CCA
	Offset: 0x3DA0
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_ad3a08af()
{
	var_3c8e8a80 = self;
	if(!isdefined(var_3c8e8a80))
	{
		return;
	}
	if(isdefined(var_3c8e8a80.weapon_instance))
	{
		if(isdefined(var_3c8e8a80.var_c98531e5))
		{
			var_3c8e8a80.var_c98531e5 weaponobjects::waitandfizzleout(var_3c8e8a80.weapon_instance, 0.1);
		}
		else
		{
			var_3c8e8a80.weapon_instance delete();
		}
	}
	if(isdefined(var_3c8e8a80.var_71676691))
	{
		var_3c8e8a80.var_71676691 delete();
	}
	if(isdefined(var_3c8e8a80.var_cea6a2fb))
	{
		var_3c8e8a80.var_cea6a2fb placeables::forceshutdown();
	}
}

/*
	Name: function_96155e4f
	Namespace: traps_deployable
	Checksum: 0x1F6ADF1F
	Offset: 0x3E88
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_96155e4f()
{
	mdl_gameobject = self;
	if(!isdefined(mdl_gameobject))
	{
		return;
	}
	mdl_gameobject gameobjects::destroy_object(1, 1);
}

/*
	Name: clean_traps
	Namespace: traps_deployable
	Checksum: 0x7B2B755
	Offset: 0x3ED0
	Size: 0x316
	Parameters: 3
	Flags: None
*/
function clean_traps(all, skipto = undefined, flag = undefined)
{
	if(all)
	{
		level notify(#"hash_6bd910abadea6345");
	}
	if(isdefined(skipto))
	{
		players = getplayers();
		foreach(player in players)
		{
			if(isdefined(player._traps_deployable))
			{
				player._traps_deployable.var_18bbaaf9 = undefined;
			}
		}
	}
	if(isdefined(level._traps_deployable) && isdefined(level._traps_deployable.var_1d76a8c4))
	{
		var_1d76a8c4 = level._traps_deployable.var_1d76a8c4;
		for(i = var_1d76a8c4.size - 1; i >= 0; i--)
		{
			if(isdefined(var_1d76a8c4[i]))
			{
				var_3c8e8a80 = var_1d76a8c4[i];
				if(all || (isdefined(skipto) && var_3c8e8a80.var_5b026504 === skipto) || (isdefined(flag) && var_3c8e8a80.var_ef146db5 === flag))
				{
					var_3c8e8a80 function_ad3a08af();
					arrayremoveindex(var_1d76a8c4, i);
				}
			}
		}
	}
	if(isdefined(level._traps_deployable) && isdefined(level._traps_deployable.var_9afef5eb))
	{
		var_18d5323c = level._traps_deployable.var_9afef5eb;
		for(i = var_18d5323c.size - 1; i >= 0; i--)
		{
			if(isdefined(var_18d5323c[i]))
			{
				mdl_gameobject = var_18d5323c[i];
				if(all || (isdefined(skipto) && mdl_gameobject.var_5b026504 === skipto) || (isdefined(flag) && mdl_gameobject.var_ef146db5 === flag))
				{
					mdl_gameobject function_96155e4f();
					arrayremoveindex(var_18d5323c, i);
				}
			}
		}
	}
}

/*
	Name: function_8f66239f
	Namespace: traps_deployable
	Checksum: 0xBDC224AF
	Offset: 0x41F0
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function function_8f66239f(flags)
{
	if(isdefined(flags) && flags != "")
	{
		var_bb7aa074 = util::create_flags_and_return_tokens(flags);
		for(i = 0; i < var_bb7aa074.size; i++)
		{
			flag = var_bb7aa074[i];
			level thread function_f6ea9af9(flag);
		}
	}
}

/*
	Name: function_f6ea9af9
	Namespace: traps_deployable
	Checksum: 0xA0968E1B
	Offset: 0x4298
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_f6ea9af9(flag)
{
	level endon(#"hash_6bd910abadea6345");
	level notify(("traps_clean" + "_") + flag);
	level endon(("traps_clean" + "_") + flag);
	level flag::wait_till(flag);
	clean_traps(0, undefined, flag);
}

/*
	Name: printerror
	Namespace: traps_deployable
	Checksum: 0xF7CE4C7B
	Offset: 0x4330
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function printerror(message)
{
	/#
		println("", message);
	#/
}

/*
	Name: printinfo
	Namespace: traps_deployable
	Checksum: 0xC5B8E74D
	Offset: 0x4368
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function printinfo(message)
{
	/#
		println("", message);
	#/
}

/*
	Name: function_ef942626
	Namespace: traps_deployable
	Checksum: 0xA56DE7C4
	Offset: 0x43A0
	Size: 0x136
	Parameters: 0
	Flags: None
*/
function function_ef942626()
{
	/#
		if(isdefined(level.trapddebug) && level.trapddebug)
		{
			var_a8539bf6 = self;
			if(!isdefined(level.var_d56d2937))
			{
				level.var_d56d2937 = spawnstruct();
			}
			if(!isdefined(level.var_d56d2937.var_59eaf9e1))
			{
				level.var_d56d2937.var_59eaf9e1 = [];
			}
			if(!isdefined(level.var_d56d2937.var_59eaf9e1))
			{
				level.var_d56d2937.var_59eaf9e1 = [];
			}
			else if(!isarray(level.var_d56d2937.var_59eaf9e1))
			{
				level.var_d56d2937.var_59eaf9e1 = array(level.var_d56d2937.var_59eaf9e1);
			}
			level.var_d56d2937.var_59eaf9e1[level.var_d56d2937.var_59eaf9e1.size] = var_a8539bf6;
		}
	#/
}

/*
	Name: function_3b7cb719
	Namespace: traps_deployable
	Checksum: 0x5E4E0062
	Offset: 0x44E0
	Size: 0xC8
	Parameters: 0
	Flags: None
*/
function function_3b7cb719()
{
	/#
		level.trapddebug = getdvarint(#"scr_trapd_debug", 0);
		while(true)
		{
			trapddebug = level.trapddebug;
			level.trapddebug = getdvarint(#"scr_trapd_debug", 0);
			if(!trapddebug === level.trapddebug)
			{
				function_ea252b49();
				waitframe(1);
				function_5726a711();
			}
			wait(1);
		}
	#/
}

/*
	Name: function_ea252b49
	Namespace: traps_deployable
	Checksum: 0x6B208F0C
	Offset: 0x45B0
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_ea252b49()
{
	/#
		if(isdefined(level.var_d56d2937) && isdefined(level.var_d56d2937.var_59eaf9e1))
		{
			var_59eaf9e1 = level.var_d56d2937.var_59eaf9e1;
			for(i = var_59eaf9e1.size - 1; i >= 0; i--)
			{
				if(isdefined(var_59eaf9e1[i]))
				{
					var_5e63b00d = var_59eaf9e1[i];
					if(isdefined(var_5e63b00d.script_flag_true))
					{
						tokens = util::create_flags_and_return_tokens(var_5e63b00d.script_flag_true);
						for(j = 0; j < tokens.size; j++)
						{
							level flag::clear(tokens[j]);
						}
					}
					if(isdefined(var_5e63b00d.script_flag_false))
					{
						tokens = util::create_flags_and_return_tokens(var_5e63b00d.script_flag_false);
						for(j = 0; j < tokens.size; j++)
						{
							level flag::clear(tokens[j]);
						}
					}
				}
				arrayremoveindex(var_59eaf9e1, i);
			}
		}
		clean_traps(1);
	#/
}

/*
	Name: debug_init
	Namespace: traps_deployable
	Checksum: 0xCEF4B7A6
	Offset: 0x4778
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function debug_init()
{
	/#
		thread function_3b7cb719();
		while(true)
		{
			debugint = getdvarint(#"scr_trapd_int", 0);
			if(debugint)
			{
				switch(debugint)
				{
					case 1:
					{
						if(isdefined(level.trapddebug) && level.trapddebug)
						{
							function_ea252b49();
							waitframe(1);
							function_5726a711();
						}
						break;
					}
				}
				setdvar(#"scr_trapd_int", 0);
			}
			wait(1);
		}
		thread debug_init();
	#/
}

