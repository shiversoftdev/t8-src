// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_184abbae9afad370;
#using script_243ea03c7a285692;
#using script_5394c653bafe1358;
#using script_5399f402045d7abd;
#using script_7bafaa95bb1b427e;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;

#namespace namespace_674e6435;

/*
	Name: function_89f2df9
	Namespace: namespace_674e6435
	Checksum: 0x3ACF7F49
	Offset: 0x358
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_707dc47b03316f1d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_674e6435
	Checksum: 0x51D65682
	Offset: 0x3A0
	Size: 0x534
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level.revive_hud = revive_hud::register("revive_hud");
	level.mp_revive_prompt = array(mp_revive_prompt::register("mp_revive_prompt_1"), mp_revive_prompt::register("mp_revive_prompt_2"), mp_revive_prompt::register("mp_revive_prompt_3"), mp_revive_prompt::register("mp_revive_prompt_4"));
	clientfield::function_a8bbc967("hudItems.laststand.progress", 13000, 5, "float");
	clientfield::function_a8bbc967("hudItems.laststand.beingRevived", 13000, 1, "int");
	clientfield::register("clientuimodel", "hudItems.laststand.revivingClientNum", 1, 7, "int");
	clientfield::register("clientuimodel", "hudItems.laststand.reviveProgress", 1, 5, "float");
	clientfield::register("clientuimodel", "EnemyTeamLastLivesData.numPlayersDowned", 1, 3, "int");
	clientfield::register("clientuimodel", "PlayerTeamLastLivesData.numPlayersDowned", 1, 3, "int");
	clientfield::register("allplayers", "laststand_bleed", 1, 1, "int");
	level.var_8e910e84 = 1;
	level.var_97c6ee7c = &playerlaststand;
	level.var_b1ad0b64 = &function_b1ad0b64;
	level.var_97a55bea = getgametypesetting(#"hash_3eb2b790db0345da");
	level.var_25364e47 = getgametypesetting(#"hash_83f11b8abac148f");
	level.var_5c13c13f = getgametypesetting(#"hash_4c7c8c4bd1b2a58b");
	level.var_57e7d5a = getgametypesetting(#"hash_67d54bbc52811921");
	level.var_b5087de4 = getgametypesetting(#"hash_3e13b420d6773b4c");
	level.laststandweapon = getweapon(#"downed");
	level.var_e273f858 = getweapon(#"hash_2ca35808b452d993");
	level.weaponrevivetool = getweapon("syrette");
	level.var_e86679bd = [];
	level.var_8971cf67 = 0;
	level.var_51e72062 = 0;
	level thread revive_hud_think();
	level.var_91c33dcb = getscriptbundle(#"finishers");
	if(!isdefined(getdvar(#"revive_trigger_radius")))
	{
		setdvar(#"revive_trigger_radius", 100);
	}
	callback::on_spawned(&on_player_spawned);
	callback::on_player_damage(&on_player_damage);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_disconnect(&on_player_disconnect);
	level.var_701f2ed4 = [];
	level.var_701f2ed4[#"axis"] = 0;
	level.var_701f2ed4[#"allies"] = 0;
	/#
		level thread function_ce726eb4();
	#/
	setdvar(#"hash_6f1b1794f8f39b93", getgametypesetting(#"hash_7148b13c0ace2cd7"));
}

/*
	Name: function_feb3e91d
	Namespace: namespace_674e6435
	Checksum: 0x7D857546
	Offset: 0x8E0
	Size: 0x50
	Parameters: 0
	Flags: None
*/
function function_feb3e91d()
{
	return (isdefined(getgametypesetting(#"hash_5c7133ffaac1ffc8")) ? getgametypesetting(#"hash_5c7133ffaac1ffc8") : 0);
}

/*
	Name: function_367cfa1b
	Namespace: namespace_674e6435
	Checksum: 0xAE1E4843
	Offset: 0x938
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_367cfa1b(callbackfunc)
{
	level.var_dcc41ae = callbackfunc;
}

/*
	Name: function_eb8c0e47
	Namespace: namespace_674e6435
	Checksum: 0x709AC87F
	Offset: 0x960
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_eb8c0e47(callbackfunc)
{
	level.var_f80fdd3f = callbackfunc;
}

/*
	Name: function_414115a0
	Namespace: namespace_674e6435
	Checksum: 0x70AF7F8
	Offset: 0x988
	Size: 0x66
	Parameters: 2
	Flags: None
*/
function function_414115a0(time, health)
{
	tier = {#health:health, #time:time};
	level.var_e86679bd[level.var_e86679bd.size] = tier;
}

/*
	Name: on_player_spawned
	Namespace: namespace_674e6435
	Checksum: 0x82A31DD9
	Offset: 0x9F8
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self laststand::revive_hud_create();
	self thread function_9f66e37a();
	self thread function_4e612708();
	self.var_d887a4ad = undefined;
	foreach(prompt in level.mp_revive_prompt)
	{
		[[ prompt ]]->function_3b7b386a(self, int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	}
	self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
}

/*
	Name: function_9f66e37a
	Namespace: namespace_674e6435
	Checksum: 0x62E0EF03
	Offset: 0xBB0
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function function_9f66e37a()
{
	self endon(#"death", #"disconnect");
	self.enteredvehicle = 0;
	while(true)
	{
		self waittill(#"enter_vehicle");
		self.enteredvehicle = 1;
	}
}

/*
	Name: function_4e612708
	Namespace: namespace_674e6435
	Checksum: 0xE68BF550
	Offset: 0xC20
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function function_4e612708()
{
	self endon(#"death", #"disconnect");
	while(true)
	{
		self waittill(#"exit_vehicle");
		waitframe(1);
		self.enteredvehicle = 0;
	}
}

/*
	Name: on_player_damage
	Namespace: namespace_674e6435
	Checksum: 0xE530F408
	Offset: 0xC80
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function on_player_damage(params)
{
	if(self is_reviving_any())
	{
		if(isdefined(self.var_58525d55) && isdefined(self.var_58525d55.var_d75a6ff5))
		{
			self.var_58525d55.var_d75a6ff5.var_d733f8d7 = self.var_58525d55.var_d75a6ff5.var_d733f8d7 + params.idamage;
			if(self.health <= params.idamage)
			{
				self.var_58525d55.var_d75a6ff5.var_bb36e277 = 1;
			}
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_674e6435
	Checksum: 0xBAFFD474
	Offset: 0xD48
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function on_player_killed(params)
{
	if(params.smeansofdeath === "MOD_SUICIDE")
	{
		self function_7ff2fc91();
	}
}

/*
	Name: on_player_disconnect
	Namespace: namespace_674e6435
	Checksum: 0xE5F9C26
	Offset: 0xD90
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_player_disconnect()
{
	self function_7ff2fc91();
}

/*
	Name: function_7ff2fc91
	Namespace: namespace_674e6435
	Checksum: 0x7ADD43D4
	Offset: 0xDB8
	Size: 0x190
	Parameters: 0
	Flags: None
*/
function function_7ff2fc91()
{
	friendlies = getplayers(self.team);
	var_90c1e72d = 0;
	foreach(player in friendlies)
	{
		if(player == self)
		{
			continue;
		}
		if(isalive(player) && !player laststand::player_is_in_laststand())
		{
			var_90c1e72d = 1;
			break;
		}
	}
	if(!var_90c1e72d)
	{
		foreach(player in friendlies)
		{
			if(player != self && isalive(player) && player laststand::player_is_in_laststand())
			{
				player thread bleed_out();
			}
		}
	}
}

/*
	Name: function_263a2944
	Namespace: namespace_674e6435
	Checksum: 0xD9F6EEED
	Offset: 0xF50
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function function_263a2944(prompt, var_a1258c6b)
{
	var_a1258c6b waittill(#"player_revived", #"disconnect", #"bled_out", #"death");
	if(isdefined(self))
	{
		[[ prompt ]]->close(self);
		[[ prompt ]]->function_3b7b386a(self, int(min(getdvarint(#"com_maxclients", 0), pow(2, 7))) - 1);
	}
}

/*
	Name: function_c025efba
	Namespace: namespace_674e6435
	Checksum: 0x699A1649
	Offset: 0x1048
	Size: 0xBA
	Parameters: 2
	Flags: None
*/
function function_c025efba(prompt, var_a1258c6b)
{
	var_a1258c6b endon(#"player_revived", #"disconnect", #"bled_out", #"death");
	self endon(#"disconnect");
	while(true)
	{
		[[ prompt ]]->set_health(self, var_a1258c6b.var_2d19ce3c);
		[[ prompt ]]->function_4b3fb8b8(self, var_a1258c6b.reviveprogress);
		waitframe(1);
	}
}

/*
	Name: function_5de626dc
	Namespace: namespace_674e6435
	Checksum: 0x82307AAC
	Offset: 0x1110
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function function_5de626dc(var_a1258c6b)
{
	foreach(prompt in level.mp_revive_prompt)
	{
		if(![[ prompt ]]->function_7bfd10e6(self))
		{
			[[ prompt ]]->open(self);
			[[ prompt ]]->set_health(self, 1);
			[[ prompt ]]->function_4b3fb8b8(self, 0);
			[[ prompt ]]->function_3b7b386a(self, var_a1258c6b getentitynumber());
			self thread function_263a2944(prompt, var_a1258c6b);
			self thread function_c025efba(prompt, var_a1258c6b);
			break;
		}
	}
}

/*
	Name: function_dc7906e8
	Namespace: namespace_674e6435
	Checksum: 0xAD6033CA
	Offset: 0x1248
	Size: 0x2DA
	Parameters: 7
	Flags: None
*/
function function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc)
{
	self.laststandparams = spawnstruct();
	self.var_bfc8055f = spawnstruct();
	self.laststandparams.einflictor = einflictor;
	self.var_bfc8055f.var_b5346661 = (isdefined(einflictor) ? einflictor getentitynumber() : -1);
	self.laststandparams.attacker = attacker;
	self.var_bfc8055f.attackernum = (isdefined(attacker) ? attacker getentitynumber() : -1);
	self.laststandparams.attackerorigin = attacker.origin;
	if(isplayer(attacker))
	{
		self.laststandparams.var_83634238 = attacker getplayerangles();
	}
	else
	{
		self.laststandparams.var_83634238 = attacker.angles;
	}
	self.laststandparams.idamage = idamage;
	self.laststandparams.smeansofdeath = smeansofdeath;
	self.laststandparams.sweapon = weapon;
	self.laststandparams.vdir = vdir;
	self.laststandparams.shitloc = shitloc;
	self.laststandparams.laststandstarttime = gettime();
	self.laststandparams.victimorigin = self.origin;
	self.laststandparams.var_5fceefd4 = self getplayerangles();
	self.laststandparams.victimweapon = self.currentweapon;
	self.laststandparams.var_10d87328 = gettime();
	self.laststandparams.bledout = 0;
	self.laststandparams.var_59b19c1b = 1;
	if(isdefined(einflictor) && isdefined(einflictor.item) && einflictor.item.name === #"planemortar")
	{
		self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
	}
}

/*
	Name: function_67b38e11
	Namespace: namespace_674e6435
	Checksum: 0xC870CA41
	Offset: 0x1530
	Size: 0x1D2
	Parameters: 7
	Flags: None
*/
function function_67b38e11(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.laststandparams))
	{
		self.laststandparams = [];
	}
	if(!isdefined(self.var_bfc8055f))
	{
		self.var_bfc8055f = [];
	}
	self.laststandparams.einflictor = einflictor;
	self.var_bfc8055f.var_b5346661 = (isdefined(einflictor) ? einflictor getentitynumber() : -1);
	self.laststandparams.attacker = attacker;
	self.var_bfc8055f.attackernum = (isdefined(attacker) ? attacker getentitynumber() : -1);
	self.laststandparams.idamage = idamage;
	self.laststandparams.smeansofdeath = smeansofdeath;
	self.laststandparams.sweapon = weapon;
	self.laststandparams.vdir = vdir;
	self.laststandparams.shitloc = shitloc;
	if(isdefined(einflictor) && isdefined(einflictor.item) && einflictor.item.name === #"planemortar")
	{
		self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
	}
}

/*
	Name: function_d5db8d2e
	Namespace: namespace_674e6435
	Checksum: 0x89DC6D93
	Offset: 0x1710
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_d5db8d2e(attacker, weapon)
{
	self function_2907ce7a();
}

/*
	Name: function_463b3f65
	Namespace: namespace_674e6435
	Checksum: 0xA1AA61C4
	Offset: 0x1748
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
			if(getdvarstring(#"hash_37d0f799458a380f", "") == "")
			{
				self notify(#"auto_revive");
				waittillframeend();
				setdvar(#"hash_37d0f799458a380f", "");
				return;
			}
			wait(0.1);
		}
	#/
}

/*
	Name: function_ce726eb4
	Namespace: namespace_674e6435
	Checksum: 0x829D07E4
	Offset: 0x1810
	Size: 0x1C0
	Parameters: 0
	Flags: None
*/
function function_ce726eb4()
{
	/#
		level endon(#"game_ended");
		while(true)
		{
			if(getdvarstring(#"hash_37d0f799458a380f", "") == "")
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
				target dodamage(target.health, target.origin);
				setdvar(#"hash_37d0f799458a380f", "");
			}
			wait(0.1);
		}
	#/
}

/*
	Name: playerlaststand
	Namespace: namespace_674e6435
	Checksum: 0x16F0A777
	Offset: 0x19D8
	Size: 0xA4C
	Parameters: 9
	Flags: None
*/
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride)
{
	if(self laststand::player_is_in_laststand())
	{
		return;
	}
	self.var_60956d6 = self getcurrentweapon();
	self function_dc7906e8(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc);
	if(!isdefined(self.laststandcount))
	{
		self.laststandcount = 0;
	}
	self.laststandcount++;
	self function_ecdd4b27();
	if(isdefined(level.var_f7b64ada))
	{
		[[level.var_f7b64ada]]();
	}
	var_2066d96d = 1;
	friendlies = getplayers(self.team);
	var_90c1e72d = 0;
	foreach(player in friendlies)
	{
		if(player == self)
		{
			continue;
		}
		if(isalive(player) && !player laststand::player_is_in_laststand())
		{
			var_2066d96d = 0;
			var_90c1e72d = 1;
			break;
		}
	}
	if(isdefined(level.var_97a55bea) && level.var_97a55bea)
	{
		var_2066d96d = 1;
	}
	if(self isplayerswimming() || (isdefined(self.enteredvehicle) && self.enteredvehicle))
	{
		var_2066d96d = 1;
	}
	if(level.var_25364e47 && self.laststandcount > level.var_25364e47)
	{
		var_2066d96d = 1;
	}
	if(isdefined(self.last_valid_position) && self.last_valid_position[2] - self.origin[2] > 200)
	{
		var_2066d96d = 1;
	}
	if(attacker === self)
	{
		var_2066d96d = 1;
	}
	if(isdefined(self.usingremote))
	{
		var_2066d96d = 1;
	}
	if(level.var_8971cf67 && self.team == game.defenders)
	{
		var_2066d96d = 1;
	}
	if(level.var_51e72062 && self.team == game.attackers)
	{
		var_2066d96d = 1;
	}
	if(var_2066d96d)
	{
		self undolaststand();
		self.uselaststandparams = 1;
		self function_6da86ae();
		self suicide(smeansofdeath);
		if(isdefined(self.var_d75a6ff5))
		{
			self.var_d75a6ff5.death = 1;
		}
		self function_1e8018b0();
		if(!var_90c1e72d)
		{
			foreach(player in friendlies)
			{
				if(player != self && isalive(player) && player laststand::player_is_in_laststand())
				{
					player thread bleed_out();
				}
			}
		}
		return;
	}
	obituary(self, attacker, level.weaponnone, "MOD_DOWNED");
	if(isdefined(attacker) && isplayer(attacker))
	{
		if(util::function_fbce7263(attacker.team, self.team) && !function_7afe7d1e(attacker, self))
		{
			scoreevents::processscoreevent(#"downed_enemy", attacker, self, weapon);
		}
		if(isdefined(level.var_dcc41ae))
		{
			[[level.var_dcc41ae]](attacker, self, einflictor, weapon, smeansofdeath);
		}
	}
	self.reviveprogress = 0;
	self.var_2d19ce3c = 1;
	level.var_701f2ed4[self.team]++;
	foreach(player in friendlies)
	{
		if(!player laststand::player_is_in_laststand())
		{
			player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", level.var_701f2ed4[self.team]);
		}
		var_13b99768 = player != self && isalive(player);
		if(var_13b99768 || sessionmodeismultiplayergame() && !player laststand::player_is_in_laststand())
		{
			player thread function_5de626dc(self);
		}
	}
	enemies = getplayers(util::getotherteam(self.team));
	foreach(player in enemies)
	{
		if(!player laststand::player_is_in_laststand())
		{
			player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", level.var_701f2ed4[self.team]);
		}
	}
	self notify(#"entering_last_stand");
	self allowjump(0);
	self disableoffhandweapons();
	/#
		self thread function_463b3f65();
	#/
	self.health = 5;
	self.laststand = 1;
	self.meleeattackers = undefined;
	callback::callback(#"on_player_laststand");
	self function_d5db8d2e(attacker, weapon);
	if(!(isdefined(self.no_revive_trigger) && self.no_revive_trigger))
	{
		if(!self oob::isoutofbounds())
		{
			self revive_trigger_spawn();
		}
	}
	self thread laststand_disable_player_weapons();
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
	self thread laststand_bleedout(bleedout_time, var_969fabf4);
	self thread function_263492d9();
	demo::bookmark(#"player_downed", gettime(), self);
	potm::bookmark(#"player_downed", gettime(), self);
	self thread laststand::function_d4c9e1b5();
	self thread auto_revive_on_notify();
	self thread function_5ccd602d();
}

/*
	Name: function_5ccd602d
	Namespace: namespace_674e6435
	Checksum: 0x3088DE71
	Offset: 0x2430
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_5ccd602d()
{
	self endon(#"player_revived", #"disconnect");
	self waittill(#"death");
	self function_2907ce7a();
	self undolaststand();
}

/*
	Name: laststand_disable_player_weapons
	Namespace: namespace_674e6435
	Checksum: 0x5E73FA25
	Offset: 0x24A0
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function laststand_disable_player_weapons()
{
	self endon(#"death", #"disconnect");
	self giveweapon(level.laststandweapon);
	self givemaxammo(level.laststandweapon);
	self switchtoweaponimmediate(level.laststandweapon, 1);
	self disableweaponcycling();
	self disableoffhandweapons();
	self waittill_timeout(1, #"weapon_change_complete");
	self weapons::detach_all_weapons();
}

/*
	Name: function_102748f8
	Namespace: namespace_674e6435
	Checksum: 0x5DF1FAC8
	Offset: 0x2590
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_102748f8()
{
	self takeweapon(level.laststandweapon);
	self giveweapon(level.var_e273f858);
	self switchtoweaponimmediate(level.var_e273f858, 1);
}

/*
	Name: laststand_enable_player_weapons
	Namespace: namespace_674e6435
	Checksum: 0x93A315DA
	Offset: 0x2600
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function laststand_enable_player_weapons()
{
	self takeweapon(level.var_e273f858);
	self enableweaponcycling();
	self enableoffhandweapons();
	self weapons::function_d571ac59(self.var_60956d6);
}

/*
	Name: laststand_clean_up_on_interrupt
	Namespace: namespace_674e6435
	Checksum: 0x4794B502
	Offset: 0x2680
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function laststand_clean_up_on_interrupt(playerbeingrevived)
{
	self endon(#"do_revive_ended_normally", #"disconnect");
	revivetrigger = playerbeingrevived.revivetrigger;
	playerbeingrevived waittill(#"disconnect", #"game_ended", #"death");
	if(isdefined(playerbeingrevived))
	{
		playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
	}
	self stoploopsound(1);
	if(isdefined(revivetrigger))
	{
		revivetrigger delete();
	}
	self function_2907ce7a();
	self revive_give_back_weapons();
	self clientfield::set_player_uimodel("hudItems.laststand.reviveProgress", 0);
}

/*
	Name: laststand_bleedout_damage
	Namespace: namespace_674e6435
	Checksum: 0xB5E1349
	Offset: 0x27B8
	Size: 0x348
	Parameters: 0
	Flags: None
*/
function laststand_bleedout_damage()
{
	self endon(#"player_revived", #"disconnect", #"bled_out");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"laststand_damage");
		if(self.var_d887a4ad === 1)
		{
			return;
		}
		if(waitresult.smeansofdeath == "MOD_MELEE")
		{
			self.var_969fabf4 = 0;
		}
		else
		{
			self.var_969fabf4 = self.var_969fabf4 - waitresult.idamage;
		}
		if(self.var_969fabf4 <= 0)
		{
			self.bleedout_time = 0;
			self.var_1cc38de0 = 1;
			var_f90950bd = (isdefined(waitresult.eattacker) ? waitresult.eattacker : self);
			self.var_a1d415ee = {#hash_10d87328:function_f8d53445(), #shitloc:waitresult.shitloc, #vdir:waitresult.vdir, #sweapon:waitresult.weapon, #smeansofdeath:waitresult.smeansofdeath, #idamage:waitresult.idamage, #hash_83634238:(isplayer(var_f90950bd) ? var_f90950bd getplayerangles() : var_f90950bd.angles), #attackerorigin:var_f90950bd.origin, #attacker:waitresult.eattacker, #einflictor:waitresult.einflictor};
			self notify(#"hash_5b5b14bba3930da1");
		}
		if(isdefined(self.var_d75a6ff5))
		{
			self.var_d75a6ff5.damage = self.var_d75a6ff5.damage + int(waitresult.idamage);
		}
		self function_a6872ca5(waitresult.idamage, waitresult.eattacker, waitresult.idflags, waitresult.smeansofdeath, waitresult.weapon, waitresult.vpoint, waitresult.shitloc, waitresult.vdamageorigin, waitresult.boneindex, waitresult.vsurfacenormal, self.var_969fabf4 <= 0);
	}
}

/*
	Name: laststand_bleedout
	Namespace: namespace_674e6435
	Checksum: 0x8AD31632
	Offset: 0x2B08
	Size: 0x214
	Parameters: 2
	Flags: None
*/
function laststand_bleedout(bleedouttime, var_969fabf4)
{
	self endon(#"player_revived", #"hash_5e936c6d9b46e0b5", #"death");
	self.var_84c0402e = bleedouttime;
	self.bleedout_time = bleedouttime;
	self.var_969fabf4 = var_969fabf4;
	self.var_2d19ce3c = 0;
	if(self.bleedout_time > 0)
	{
		self thread laststand_bleedout_damage();
		var_9da219f5 = gettime();
		while(self.bleedout_time > 0)
		{
			time = gettime();
			if(time >= var_9da219f5)
			{
				self.var_2d19ce3c = self.bleedout_time / bleedouttime;
				self.bleedout_time = self.bleedout_time - 1;
				self clientfield::set_player_uimodel("hudItems.laststand.progress", self.var_2d19ce3c);
				var_9da219f5 = time + 1000;
			}
			self waittill_timeout(float(var_9da219f5 - time) / 1000, #"hash_5b5b14bba3930da1");
		}
		while(self.var_969fabf4 > 0 && isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived == 1)
		{
			wait(0.1);
		}
	}
	if(self.var_d887a4ad === 1)
	{
		return;
	}
	self notify(#"bled_out");
	self thread bleed_out();
}

/*
	Name: function_263492d9
	Namespace: namespace_674e6435
	Checksum: 0x742E2006
	Offset: 0x2D28
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_263492d9()
{
	self endon(#"disconnect", #"death");
	self enableinvulnerability();
	wait(level.var_5c13c13f);
	self disableinvulnerability();
}

/*
	Name: function_6da86ae
	Namespace: namespace_674e6435
	Checksum: 0x91201BFA
	Offset: 0x2D90
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_6da86ae()
{
	if(isdefined(self) && isdefined(self.laststandparams) && !isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
	}
}

/*
	Name: bleed_out
	Namespace: namespace_674e6435
	Checksum: 0xEE645088
	Offset: 0x2DE0
	Size: 0x3DC
	Parameters: 0
	Flags: None
*/
function bleed_out()
{
	self endon(#"player_revived", #"death");
	util::wait_network_frame();
	self function_2907ce7a();
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
		self.revivetrigger = undefined;
	}
	self clientfield::set("laststand_bleed", 0);
	demo::bookmark(#"player_bledout", gettime(), self, undefined, 1);
	potm::bookmark(#"player_bledout", gettime(), self, undefined, 1);
	level notify(#"bleed_out", {#character_index:self.characterindex});
	self notify(#"hash_5e936c6d9b46e0b5");
	callback::callback(#"on_player_bleedout");
	self undolaststand();
	self.uselaststandparams = 1;
	self function_6da86ae();
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
	self function_2907ce7a();
	if(isdefined(self.laststandparams) && isdefined(self.laststandparams.smeansofdeath))
	{
		self suicide(self.laststandparams.smeansofdeath);
	}
	else
	{
		self suicide();
	}
	if(getdvarint(#"hash_62b8db0428755a32", 1) && isplayer(self))
	{
		var_d7e063c = getdvarfloat(#"hash_44de9418bb6289ac", 1.5);
		self playsoundtoplayer(#"hash_11d39dca0f911535", self);
		self lui::screen_fade(var_d7e063c, 1, 0, "black", 0);
		wait(var_d7e063c + 0.2);
		self lui::screen_fade(var_d7e063c, 0, 1, "black", 0);
	}
	if(isdefined(self) && self.var_8da0afa !== 1)
	{
		self thread respawn_player_after_time(15);
	}
}

/*
	Name: respawn_player_after_time
	Namespace: namespace_674e6435
	Checksum: 0x1C1973A8
	Offset: 0x31C8
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
	Namespace: namespace_674e6435
	Checksum: 0x1CC6E0DD
	Offset: 0x3290
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_2907ce7a()
{
	self clientfield::set_player_uimodel("hudItems.laststand.progress", 0);
	self clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
}

/*
	Name: revive_trigger_spawn
	Namespace: namespace_674e6435
	Checksum: 0xAEBCA555
	Offset: 0x32E0
	Size: 0x17C
	Parameters: 0
	Flags: None
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
	self.revivetrigger linkto(self);
	self.revivetrigger.beingrevived = 0;
	self.revivetrigger.createtime = gettime();
	self.revivetrigger.radius = radius;
	self.revivetrigger setteamfortrigger(self.team);
	self thread revive_trigger_think();
}

/*
	Name: revive_trigger_think
	Namespace: namespace_674e6435
	Checksum: 0x2768EBD3
	Offset: 0x3468
	Size: 0x498
	Parameters: 0
	Flags: None
*/
function revive_trigger_think()
{
	self endon(#"death", #"stop_revive_trigger");
	level endon(#"game_ended");
	while(true)
	{
		wait(0.1);
		if(!isdefined(self.revivetrigger))
		{
			self notify(#"stop_revive_trigger");
		}
		self.revivetrigger sethintstring("");
		/#
			if(getdvarint(#"hash_63e053994442bba4", 0) && self attackbuttonpressed() && self throwbuttonpressed() && self fragbuttonpressed())
			{
				self thread revive_success(self);
				self function_2907ce7a();
				return;
			}
		#/
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i].team != self.team)
			{
				continue;
			}
			if(players[i] can_revive(self))
			{
				self.revivetrigger setrevivehintstring(#"hash_51a0f083a5566a3", self.team);
				break;
			}
		}
		for(i = 0; i < players.size; i++)
		{
			reviver = players[i];
			if(!isdefined(reviver))
			{
				continue;
			}
			if(reviver.team != self.team)
			{
				continue;
			}
			if(self == reviver || !reviver is_reviving(self))
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
			}
			if(revive_success)
			{
				self thread revive_success(reviver);
				self function_2907ce7a();
				return;
			}
		}
		if(function_feb3e91d())
		{
			foreach(team in level.teams)
			{
				if(team === self.team)
				{
					continue;
				}
				if(function_356caede(team))
				{
					return;
				}
			}
		}
	}
}

/*
	Name: function_356caede
	Namespace: namespace_674e6435
	Checksum: 0x842CE368
	Offset: 0x3908
	Size: 0x652
	Parameters: 1
	Flags: None
*/
function function_356caede(team)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isdefined(level.alivecount) || !isdefined(level.alivecount[team]))
	{
		return 0;
	}
	if(level.alivecount[team] == 0)
	{
		return 0;
	}
	if(!isdefined(self.revivetrigger))
	{
		return 0;
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
	foreach(var_f7cfe7ee in players)
	{
		if(self == var_f7cfe7ee || !var_f7cfe7ee is_reviving(self, 0, height) || var_f7cfe7ee is_reviving_any() || (isdefined(var_f7cfe7ee.var_5c574004) && var_f7cfe7ee.var_5c574004))
		{
			continue;
		}
		var_f7cfe7ee function_684a5394();
		var_c9c35e60 = randomintrange(1, level.var_91c33dcb.finishers.size - 1);
		/#
			assert(level.var_91c33dcb.finishers.size >= var_c9c35e60);
		#/
		var_abdbed5a = level.var_91c33dcb.finishers[var_c9c35e60].("finisherbundle");
		var_d1d9820d = getscriptbundle(var_abdbed5a);
		if(isdefined(var_d1d9820d.("attacker_gesture")))
		{
			var_f7cfe7ee function_c6775cf9(var_d1d9820d.("attacker_gesture"));
		}
		if(isdefined(var_d1d9820d.("victim_gesture")))
		{
			self function_c6775cf9(var_d1d9820d.("victim_gesture"));
		}
		self function_fab0e07e(var_f7cfe7ee);
		if(!isdefined(var_f7cfe7ee))
		{
			return 0;
		}
		if(!isdefined(self) || !isalive(self) || !isalive(var_f7cfe7ee))
		{
			var_f7cfe7ee function_b16f016a();
			return 0;
		}
		var_f7cfe7ee disableweaponcycling();
		var_f7cfe7ee disableusability();
		var_f7cfe7ee disableoffhandweapons();
		self flagsys::clear(#"hash_40e3b09bdbcdac81");
		var_62728357 = var_f7cfe7ee function_1c8cab15(self);
		if(isdefined(var_f7cfe7ee))
		{
			var_f7cfe7ee function_b16f016a();
			var_f7cfe7ee enableweaponcycling();
			var_f7cfe7ee enableusability();
			var_f7cfe7ee enableoffhandweapons();
			var_e24d6046 = var_f7cfe7ee gettagangles("tag_sync");
			kill_origin = var_f7cfe7ee gettagorigin("tag_sync");
			if(isdefined(self))
			{
				if(isdefined(var_62728357) && var_62728357)
				{
					self function_516a3bef(0);
					self setplayerangles(var_e24d6046);
					self setorigin(kill_origin);
					self dodamage(self.var_969fabf4, self.origin, var_f7cfe7ee, undefined, "none", "MOD_MELEE_ASSASSINATE", 8192);
					self function_2907ce7a();
					return 1;
				}
				self function_516a3bef(1);
				self function_7c685040();
			}
			var_f7cfe7ee function_7c685040();
		}
	}
	return 0;
}

/*
	Name: function_684a5394
	Namespace: namespace_674e6435
	Checksum: 0x3F1A02A0
	Offset: 0x3F68
	Size: 0x24
	Parameters: 0
	Flags: None
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
	Namespace: namespace_674e6435
	Checksum: 0x5FDC4664
	Offset: 0x3F98
	Size: 0x4E
	Parameters: 0
	Flags: None
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
	Namespace: namespace_674e6435
	Checksum: 0x913BAF1D
	Offset: 0x3FF0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_fab0e07e(var_f7cfe7ee)
{
	self endon(#"disconnect");
	var_f7cfe7ee endon(#"disconnect");
	waitframe(1);
	if(isdefined(self) && isdefined(var_f7cfe7ee) && isalive(self) && isalive(var_f7cfe7ee))
	{
		self.laststandparams.var_3f57b6a0 = self.origin;
		self.laststandparams.savedangles = self.angles;
		self playerlinkto(var_f7cfe7ee, "tag_sync");
	}
}

/*
	Name: function_516a3bef
	Namespace: namespace_674e6435
	Checksum: 0xA1755438
	Offset: 0x40C0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_516a3bef(replace)
{
	if(isalive(self) && function_feb3e91d())
	{
		self unlink();
		if(replace)
		{
			self setorigin(self.laststandparams.var_3f57b6a0);
		}
	}
}

/*
	Name: function_c82a14d1
	Namespace: namespace_674e6435
	Checksum: 0xEB59ED73
	Offset: 0x4150
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function function_c82a14d1(var_f7cfe7ee)
{
	self endon(#"death", #"disconnect", #"hash_4db4d01d577965eb");
	var_f7cfe7ee endon(#"death", #"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"contact");
	self flagsys::set(#"hash_40e3b09bdbcdac81");
	self notify(#"hash_b78fae039ab734b");
}

/*
	Name: function_1c8cab15
	Namespace: namespace_674e6435
	Checksum: 0x481C31CD
	Offset: 0x4210
	Size: 0x188
	Parameters: 1
	Flags: None
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
		return 1;
	}
	return 0;
}

/*
	Name: revive_give_back_weapons
	Namespace: namespace_674e6435
	Checksum: 0xFBBF013F
	Offset: 0x43A0
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function revive_give_back_weapons()
{
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.laststand) && self.laststand)
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
	Namespace: namespace_674e6435
	Checksum: 0x52C47298
	Offset: 0x4458
	Size: 0x2D6
	Parameters: 3
	Flags: None
*/
function can_revive(revivee, ignore_touch_checks = 0, height = undefined)
{
	if(!isdefined(revivee.revivetrigger))
	{
		return 0;
	}
	if(!isalive(self))
	{
		return 0;
	}
	if(self laststand::player_is_in_laststand())
	{
		return 0;
	}
	if(isdefined(level.can_revive) && ![[level.can_revive]](revivee))
	{
		return 0;
	}
	if(isdefined(level.can_revive_game_module) && ![[level.can_revive_game_module]](revivee))
	{
		return 0;
	}
	if(isdefined(level.revive_trigger_should_ignore_sight_checks))
	{
		ignore_sight_checks = [[level.revive_trigger_should_ignore_sight_checks]](self);
		if(ignore_sight_checks && isdefined(revivee.revivetrigger.beingrevived) && revivee.revivetrigger.beingrevived == 1)
		{
			ignore_touch_checks = 1;
		}
	}
	if(!ignore_touch_checks)
	{
		if(!self istouching(revivee.revivetrigger))
		{
			return 0;
		}
	}
	if(isdefined(height))
	{
		delta = revivee.origin[2] - self.origin[2];
		if(delta > height || delta < height * -1)
		{
			return 0;
		}
	}
	if(!self laststand::is_facing(revivee, 0.8))
	{
		return 0;
	}
	if(distancesquared(revivee.origin, self.origin) > 140 * 140)
	{
		return 0;
	}
	if(!sighttracepassed(self.origin + vectorscale((0, 0, 1), 50), revivee.origin + vectorscale((0, 0, 1), 30), 0, undefined))
	{
		return 0;
	}
	if(!bullettracepassed(self.origin + vectorscale((0, 0, 1), 50), revivee.origin + vectorscale((0, 0, 1), 30), 0, undefined))
	{
		return 0;
	}
	return 1;
}

/*
	Name: is_reviving
	Namespace: namespace_674e6435
	Checksum: 0xA1CBE083
	Offset: 0x4738
	Size: 0xB4
	Parameters: 3
	Flags: None
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
	return self usebuttonpressed() && can_revive(revivee, ignore_touch_checks, height);
}

/*
	Name: is_reviving_any
	Namespace: namespace_674e6435
	Checksum: 0x62AC27BB
	Offset: 0x47F8
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function is_reviving_any()
{
	return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

/*
	Name: revive_do_revive
	Namespace: namespace_674e6435
	Checksum: 0xAD1932B2
	Offset: 0x4818
	Size: 0x5DA
	Parameters: 1
	Flags: None
*/
function revive_do_revive(playerbeingrevived)
{
	self endon(#"disconnect");
	if(!isdefined(playerbeingrevived))
	{
		return 0;
	}
	/#
		assert(self is_reviving(playerbeingrevived));
	#/
	revivetime = getdvarfloat(#"hash_6f1b1794f8f39b93", 3) * self function_bd85bc2f();
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
	self.var_58525d55 = playerbeingrevived;
	self clientfield::set_player_uimodel("hudItems.laststand.revivingClientNum", playerbeingrevived getentitynumber());
	while(self is_reviving(playerbeingrevived))
	{
		if(self laststand::player_is_in_laststand())
		{
			playerbeingrevived.reviveprogress = 0;
			break;
		}
		if(isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive)
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
		timer = timer + float(function_60d95f53()) / 1000;
		waitframe(1);
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
		if(!(isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive) && !revived)
		{
			if(isplayer(playerbeingrevived))
			{
				playerbeingrevived stoprevive(self);
			}
		}
		playerbeingrevived.revivetrigger sethintstring(#"hash_51a0f083a5566a3");
		playerbeingrevived.revivetrigger.beingrevived = 0;
		if(isdefined(revived) && revived && isdefined(level.var_f80fdd3f))
		{
			[[level.var_f80fdd3f]](playerbeingrevived, self);
		}
	}
	self.var_58525d55 = undefined;
	self notify(#"do_revive_ended_normally");
	self.is_reviving_any--;
	if(self.is_reviving_any < 0)
	{
		self.is_reviving_any = 0;
	}
	else if(self.is_reviving_any > 99999)
	{
		self.is_reviving_any = 99999;
	}
	return revived;
}

/*
	Name: auto_revive_on_notify
	Namespace: namespace_674e6435
	Checksum: 0x4BAAF792
	Offset: 0x4E00
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function auto_revive_on_notify()
{
	self endon(#"death", #"disconnect", #"player_revived");
	waitresult = undefined;
	waitresult = self waittill(#"auto_revive");
	auto_revive(waitresult.reviver);
}

/*
	Name: auto_revive
	Namespace: namespace_674e6435
	Checksum: 0xFF743E64
	Offset: 0x4E80
	Size: 0x216
	Parameters: 1
	Flags: None
*/
function auto_revive(reviver)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"disconnect");
	self.var_d887a4ad = 1;
	var_8c0cedb7 = gettime() + getdvarint(#"hash_77107267fe87b359", 350);
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger.auto_revive = 1;
		while(isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)
		{
			util::wait_network_frame();
		}
		self.revivetrigger.auto_trigger = 0;
	}
	self function_102748f8();
	if(var_8c0cedb7 >= gettime())
	{
		var_cbf9fa14 = var_8c0cedb7 - gettime() / 1000;
		wait(var_cbf9fa14);
	}
	if(!isdefined(self))
	{
		return;
	}
	self reviveplayer();
	self.var_d887a4ad = undefined;
	self notify(#"stop_revive_trigger");
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
		self.revivetrigger = undefined;
	}
	self function_2907ce7a();
	self laststand_enable_player_weapons();
	self allowjump(1);
	self.laststand = undefined;
	self lui::screen_close_menu();
	self notify(#"player_revived", {#reviver:reviver});
}

/*
	Name: revive_success
	Namespace: namespace_674e6435
	Checksum: 0xE521EA86
	Offset: 0x50A0
	Size: 0x39C
	Parameters: 2
	Flags: None
*/
function revive_success(reviver, b_track_stats = 1)
{
	if(!isplayer(self))
	{
		self notify(#"player_revived", {#reviver:reviver});
		return;
	}
	self function_102748f8();
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
	self.laststand = undefined;
	self notify(#"player_revived", {#reviver:reviver});
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
		if(!function_7e980623(reviver, self))
		{
			reviver scoreevents::processscoreevent(#"hash_69d0eb697f788dd", reviver, self);
		}
	}
	self.health = health;
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
		self.revivetrigger = undefined;
	}
	self clientfield::set("laststand_bleed", 0);
	self function_2907ce7a();
	self laststand_enable_player_weapons();
	self lui::screen_close_menu();
	self function_1e8018b0();
	function_58ca2822("player_revived", self, {#reviver:reviver});
	callback::callback(#"on_player_revived");
	if(isdefined(level.var_1a0c2b72))
	{
		reviver [[level.var_1a0c2b72]](self);
	}
}

/*
	Name: revive_hud_think
	Namespace: namespace_674e6435
	Checksum: 0xA86EC7F7
	Offset: 0x5448
	Size: 0x274
	Parameters: 0
	Flags: None
*/
function revive_hud_think()
{
	level endon(#"game_ended");
	while(true)
	{
		wait(0.1);
		if(!laststand::player_any_player_in_laststand())
		{
			continue;
		}
		revived = 0;
		foreach(team, _ in level.teams)
		{
			playertorevive = undefined;
			foreach(player in level.aliveplayers[team])
			{
				if(!isdefined(player.revivetrigger) || !isdefined(player.revivetrigger.createtime))
				{
					continue;
				}
				if(!isdefined(playertorevive) || playertorevive.revivetrigger.createtime > player.revivetrigger.createtime)
				{
					playertorevive = player;
				}
			}
			if(isdefined(playertorevive))
			{
				foreach(player in level.aliveplayers[team])
				{
					if(player laststand::player_is_in_laststand())
					{
						continue;
					}
					player thread faderevivemessageover(playertorevive, 3);
				}
				playertorevive.revivetrigger.createtime = undefined;
				revived = 1;
			}
		}
		if(revived)
		{
			wait(3.5);
		}
	}
}

/*
	Name: faderevivemessageover
	Namespace: namespace_674e6435
	Checksum: 0x2FC0F328
	Offset: 0x56C8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function faderevivemessageover(playertorevive, time)
{
	self thread laststand::revive_hud_show_n_fade(#"hash_14cc93f11ba8334a", time, playertorevive);
}

/*
	Name: function_ecdd4b27
	Namespace: namespace_674e6435
	Checksum: 0xDFE17E6A
	Offset: 0x5710
	Size: 0xF6
	Parameters: 0
	Flags: None
*/
function function_ecdd4b27()
{
	if(!isplayer(self) || isdefined(self.var_d75a6ff5))
	{
		return;
	}
	self.var_d75a6ff5 = {#hash_35b89428:0, #hash_d733f8d7:0, #hash_d10f3b9a:0, #bleed_out:0, #death:0, #damage:0, #end_time:0, #start_time:gettime(), #player_xuid:int(self getxuid(1))};
}

/*
	Name: function_1e8018b0
	Namespace: namespace_674e6435
	Checksum: 0x743B03D6
	Offset: 0x5810
	Size: 0x198
	Parameters: 0
	Flags: None
*/
function function_1e8018b0()
{
	if(!isplayer(self) || !isdefined(self.var_d75a6ff5))
	{
		return;
	}
	self.var_d75a6ff5.end_time = gettime();
	function_92d1707f(#"hash_142816c2e7c5da66", self.var_d75a6ff5);
	self.var_d75a6ff5 = undefined;
	level.var_701f2ed4[self.team]--;
	players = getplayers();
	foreach(player in players)
	{
		if(!isdefined(level.var_701f2ed4[player.team]))
		{
			continue;
		}
		player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", level.var_701f2ed4[player.team]);
		player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", level.var_701f2ed4[util::getotherteam(player.team)]);
	}
}

/*
	Name: function_b1ad0b64
	Namespace: namespace_674e6435
	Checksum: 0x1D2FB17E
	Offset: 0x59B0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b1ad0b64(idamage, smeansofdeath)
{
	if(!(isdefined(self.laststand) && self.laststand))
	{
		return 0;
	}
	return self.var_969fabf4 <= idamage;
}

/*
	Name: function_b394486e
	Namespace: namespace_674e6435
	Checksum: 0xBF79497B
	Offset: 0x59F8
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function function_b394486e()
{
	self.var_d292d803 = spawnstruct();
	self.var_d292d803.cheating = 0;
	self.var_d292d803.downs = array();
	self.var_d292d803.revives = array();
}

/*
	Name: is_cheating
	Namespace: namespace_674e6435
	Checksum: 0xCA60D0E7
	Offset: 0x5A70
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function is_cheating()
{
	if(!isdefined(self.var_d292d803))
	{
		return 0;
	}
	return self.var_d292d803.cheating;
}

/*
	Name: function_7afe7d1e
	Namespace: namespace_674e6435
	Checksum: 0x6ECA1005
	Offset: 0x5AA0
	Size: 0x46A
	Parameters: 2
	Flags: None
*/
function function_7afe7d1e(attacker, victim)
{
	if(!isdefined(level.var_57e7d5a) || level.var_57e7d5a == 0)
	{
		return 0;
	}
	if(!isdefined(attacker.var_d292d803))
	{
		attacker function_b394486e();
	}
	else if(attacker is_cheating())
	{
		return 1;
	}
	if(!isdefined(attacker.var_d292d803.downs[victim.entnum]))
	{
		attacker.var_d292d803.downs[victim.entnum] = array();
		if(!isdefined(attacker.var_d292d803.downs[victim.entnum]))
		{
			attacker.var_d292d803.downs[victim.entnum] = [];
		}
		else if(!isarray(attacker.var_d292d803.downs[victim.entnum]))
		{
			attacker.var_d292d803.downs[victim.entnum] = array(attacker.var_d292d803.downs[victim.entnum]);
		}
		attacker.var_d292d803.downs[victim.entnum][attacker.var_d292d803.downs[victim.entnum].size] = gettime();
		return 0;
	}
	if(!isdefined(attacker.var_d292d803.downs[victim.entnum]))
	{
		attacker.var_d292d803.downs[victim.entnum] = [];
	}
	else if(!isarray(attacker.var_d292d803.downs[victim.entnum]))
	{
		attacker.var_d292d803.downs[victim.entnum] = array(attacker.var_d292d803.downs[victim.entnum]);
	}
	attacker.var_d292d803.downs[victim.entnum][attacker.var_d292d803.downs[victim.entnum].size] = gettime();
	var_1fb8db26 = attacker.var_d292d803.downs[victim.entnum].size;
	if(var_1fb8db26 < level.var_57e7d5a)
	{
		return 0;
	}
	var_1053d9e9 = attacker.var_d292d803.downs[victim.entnum][var_1fb8db26 - 1];
	var_6ab74732 = attacker.var_d292d803.downs[victim.entnum][var_1fb8db26 - level.var_57e7d5a];
	if(var_1053d9e9 - var_6ab74732 <= int(60 * 1000))
	{
		attacker.var_d292d803.cheating = 1;
		attacker.var_d292d803.downs = undefined;
		attacker.var_d292d803.revives = undefined;
	}
	return attacker is_cheating();
}

/*
	Name: function_7e980623
	Namespace: namespace_674e6435
	Checksum: 0x25394226
	Offset: 0x5F18
	Size: 0x46A
	Parameters: 2
	Flags: None
*/
function function_7e980623(reviver, victim)
{
	if(!isdefined(level.var_b5087de4) || level.var_b5087de4 == 0)
	{
		return 0;
	}
	if(!isdefined(reviver.var_d292d803))
	{
		reviver function_b394486e();
	}
	else if(reviver is_cheating())
	{
		return 1;
	}
	if(!isdefined(reviver.var_d292d803.revives[victim.entnum]))
	{
		reviver.var_d292d803.revives[victim.entnum] = array();
		if(!isdefined(reviver.var_d292d803.revives[victim.entnum]))
		{
			reviver.var_d292d803.revives[victim.entnum] = [];
		}
		else if(!isarray(reviver.var_d292d803.revives[victim.entnum]))
		{
			reviver.var_d292d803.revives[victim.entnum] = array(reviver.var_d292d803.revives[victim.entnum]);
		}
		reviver.var_d292d803.revives[victim.entnum][reviver.var_d292d803.revives[victim.entnum].size] = gettime();
		return 0;
	}
	if(!isdefined(reviver.var_d292d803.revives[victim.entnum]))
	{
		reviver.var_d292d803.revives[victim.entnum] = [];
	}
	else if(!isarray(reviver.var_d292d803.revives[victim.entnum]))
	{
		reviver.var_d292d803.revives[victim.entnum] = array(reviver.var_d292d803.revives[victim.entnum]);
	}
	reviver.var_d292d803.revives[victim.entnum][reviver.var_d292d803.revives[victim.entnum].size] = gettime();
	numrevives = reviver.var_d292d803.revives[victim.entnum].size;
	if(numrevives < level.var_b5087de4)
	{
		return 0;
	}
	var_1053d9e9 = reviver.var_d292d803.revives[victim.entnum][numrevives - 1];
	var_6ab74732 = reviver.var_d292d803.revives[victim.entnum][numrevives - level.var_b5087de4];
	if(var_1053d9e9 - var_6ab74732 <= int(60 * 1000))
	{
		reviver.var_d292d803.cheating = 1;
		reviver.var_d292d803.downs = undefined;
		reviver.var_d292d803.revives = undefined;
	}
	return reviver is_cheating();
}

