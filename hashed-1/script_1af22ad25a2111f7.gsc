// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace jammer;

/*
	Name: init_shared
	Namespace: jammer
	Checksum: 0x5911330
	Offset: 0x1F8
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_578f7c6d))
	{
		level.var_578f7c6d = spawnstruct();
	}
	if(!isdefined(level.var_578f7c6d.var_1728e736))
	{
		level.var_578f7c6d.var_1728e736 = [];
	}
	level.var_578f7c6d.weapon = getweapon(#"eq_emp_grenade");
	level.var_578f7c6d.customsettings = getscriptbundle(level.var_578f7c6d.weapon.customsettings);
	weaponobjects::function_e6400478(#"eq_emp_grenade", &function_1a50ce7b, 1);
	registerclientfields();
	setupcallbacks();
}

/*
	Name: setupcallbacks
	Namespace: jammer
	Checksum: 0xBAB9F447
	Offset: 0x310
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function setupcallbacks()
{
	level.var_a5dacbea = &function_4e7e56a8;
	level.var_5d492b75 = &function_1c430dad;
	level.var_7b151daa = &function_7b151daa;
	level.var_86e3d17a = &function_86e3d17a;
	level.var_fc1bbaef = &function_fc1bbaef;
	level.var_1794f85f = &function_2572e9cc;
	level.var_48c30195 = &function_48c30195;
	callback::on_spawned(&onplayerspawned);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: registerclientfields
	Namespace: jammer
	Checksum: 0x7177D857
	Offset: 0x428
	Size: 0x124
	Parameters: 0
	Flags: Private
*/
function private registerclientfields()
{
	clientfield::register("scriptmover", "isJammed", 9000, 1, "int");
	clientfield::register("missile", "isJammed", 9000, 1, "int");
	clientfield::register("vehicle", "isJammed", 9000, 1, "int");
	clientfield::register("toplayer", "isJammed", 9000, 1, "int");
	clientfield::register("missile", "jammer_active", 9000, 1, "int");
	clientfield::register("toplayer", "jammedvehpostfx", 9000, 1, "int");
}

/*
	Name: function_1a50ce7b
	Namespace: jammer
	Checksum: 0x25380959
	Offset: 0x558
	Size: 0xA6
	Parameters: 1
	Flags: Private
*/
function private function_1a50ce7b(watcher)
{
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.deleteonplayerspawn = 0;
	watcher.enemydestroy = 1;
	watcher.onspawn = &function_7d81a4ff;
	watcher.ondestroyed = &function_b2e496fa;
	watcher.ontimeout = &function_b2e496fa;
	watcher.ondetonatecallback = &function_51a743f8;
}

/*
	Name: function_48c30195
	Namespace: jammer
	Checksum: 0xA44D64D
	Offset: 0x608
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function function_48c30195(entity, var_ec9c756e)
{
	if(isdefined(entity))
	{
		entity.ignoreemp = var_ec9c756e;
	}
}

/*
	Name: function_86e3d17a
	Namespace: jammer
	Checksum: 0x865C8E41
	Offset: 0x640
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_86e3d17a()
{
	return level.var_578f7c6d.customsettings.var_3bd9b483;
}

/*
	Name: register
	Namespace: jammer
	Checksum: 0x4064060D
	Offset: 0x668
	Size: 0x22
	Parameters: 2
	Flags: None
*/
function register(entity, var_448f97f2)
{
	entity.var_123aec6c = var_448f97f2;
}

/*
	Name: function_4e7e56a8
	Namespace: jammer
	Checksum: 0xDEAE09B2
	Offset: 0x698
	Size: 0x36
	Parameters: 2
	Flags: None
*/
function function_4e7e56a8(weapon, callbackfunction)
{
	level.var_578f7c6d.var_1728e736[weapon.name] = callbackfunction;
}

/*
	Name: function_1c601b99
	Namespace: jammer
	Checksum: 0x5B881550
	Offset: 0x6D8
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.var_578f7c6d.weapon, &function_bff5c062);
	}
}

/*
	Name: function_fc1bbaef
	Namespace: jammer
	Checksum: 0x250E657A
	Offset: 0x720
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_fc1bbaef(entity)
{
	thread function_d88f3e48(entity);
}

/*
	Name: function_bff5c062
	Namespace: jammer
	Checksum: 0x6B607538
	Offset: 0x750
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function function_bff5c062(jammer, attackingplayer)
{
	jammer.team = attackingplayer.team;
	jammer setteam(attackingplayer.team);
	jammer.owner = attackingplayer;
	jammer thread function_6a973411();
}

/*
	Name: on_player_killed
	Namespace: jammer
	Checksum: 0x98AE8CE7
	Offset: 0x7C8
	Size: 0x16C
	Parameters: 1
	Flags: None
*/
function on_player_killed(params)
{
	if(!isdefined(params.eattacker))
	{
		return;
	}
	if(!(isdefined(self.isjammed) ? self.isjammed : 0))
	{
		return;
	}
	if(!isdefined(self.var_fe1ebada))
	{
		return;
	}
	if(self.var_fe1ebada == params.eattacker)
	{
		scoreevents::processscoreevent(#"disruptor_kill", self.var_fe1ebada, undefined, level.var_578f7c6d.weapon);
		params.eattacker function_be7a08a8(level.var_578f7c6d.weapon, 1);
	}
	else if(isdefined(self.var_fe1ebada.team) && isdefined(params.eattacker.team) && self.var_fe1ebada.team == params.eattacker.team)
	{
		scoreevents::processscoreevent(#"disruptor_assist", self.var_fe1ebada, undefined, level.var_578f7c6d.weapon);
	}
}

/*
	Name: onplayerspawned
	Namespace: jammer
	Checksum: 0xEFBEBAD7
	Offset: 0x940
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function onplayerspawned()
{
	self.isjammed = 0;
}

/*
	Name: function_7d81a4ff
	Namespace: jammer
	Checksum: 0x2CEF1E7B
	Offset: 0x958
	Size: 0x184
	Parameters: 2
	Flags: Private
*/
function private function_7d81a4ff(watcher, player)
{
	if(!isdefined(self.var_88d76fba))
	{
		self.var_88d76fba = [];
	}
	self.owner = player;
	self.weapon = level.var_578f7c6d.weapon;
	self setweapon(level.var_578f7c6d.weapon);
	self setteam(player getteam());
	self.team = player getteam();
	self clientfield::set("enemyequip", 1);
	thread function_3a3a2ea9(self);
	waitresult = self function_5f86757d();
	if(!isdefined(player) || !isdefined(waitresult))
	{
		return;
	}
	if(waitresult._notify == #"explode" && isdefined(waitresult.position))
	{
		self thread function_87c540c0(self, waitresult.position, player);
	}
}

/*
	Name: function_2572e9cc
	Namespace: jammer
	Checksum: 0x83C063A0
	Offset: 0xAE8
	Size: 0x44
	Parameters: 2
	Flags: Private
*/
function private function_2572e9cc(attackingplayer, var_fb5e3b16)
{
	scoreevents::processscoreevent(var_fb5e3b16, attackingplayer, undefined, level.var_578f7c6d.weapon);
}

/*
	Name: function_87c540c0
	Namespace: jammer
	Checksum: 0xB637E4E0
	Offset: 0xB38
	Size: 0x254
	Parameters: 3
	Flags: Private
*/
function private function_87c540c0(jammer, origin, attackingplayer)
{
	entities = getentitiesinradius(origin, level.var_578f7c6d.weapon.explosionradius);
	var_545dd758 = 0;
	var_480b4b92 = 0;
	foreach(entity in entities)
	{
		if(!function_b16c8865(entity, attackingplayer))
		{
			if(!var_480b4b92 && isplayer(entity) && entity function_6c32d092(#"talent_resistance") && util::function_fbce7263(entity.team, attackingplayer.team))
			{
				attackingplayer damagefeedback::update(undefined, undefined, "resistance", level.var_578f7c6d.weapon);
				var_480b4b92 = 1;
			}
			continue;
		}
		if(isplayer(entity))
		{
			thread function_b8c5ab9c(jammer, entity, attackingplayer);
			continue;
		}
		var_decc08e9 = thread function_e27c41b4(jammer, entity, attackingplayer);
		if(var_decc08e9 === 1)
		{
			var_545dd758++;
		}
	}
	if(var_545dd758 >= 2)
	{
		scoreevents::processscoreevent(#"hash_208b61a32a38340e", attackingplayer, undefined, level.var_578f7c6d.weapon);
	}
}

/*
	Name: function_e27c41b4
	Namespace: jammer
	Checksum: 0xA6319E17
	Offset: 0xD98
	Size: 0x2B0
	Parameters: 3
	Flags: Private
*/
function private function_e27c41b4(jammer, entity, attackingplayer)
{
	entity endon(#"death");
	if(!isdefined(entity))
	{
		return false;
	}
	if(isalive(entity) && isvehicle(entity) && isdefined(level.is_staircase_up))
	{
		function_1c430dad(entity, 1);
		function_58f8bf08(jammer, attackingplayer, undefined);
		entity thread [[level.is_staircase_up]](attackingplayer, jammer);
		return true;
	}
	if(isalive(entity) && isactor(entity))
	{
		function_1c430dad(entity, 1);
		function_58f8bf08(jammer, attackingplayer, undefined);
		entity callback::callback(#"hash_7140c3848cbefaa1", {#jammer:jammer, #hash_dbd1a594:attackingplayer});
		return true;
	}
	weapon = (isdefined(entity.identifier_weapon) ? entity.identifier_weapon : entity.weapon);
	if(!isdefined(weapon))
	{
		return false;
	}
	if(isdefined(level.var_578f7c6d.var_1728e736[weapon.name]))
	{
		function_1c430dad(entity, 1);
		function_58f8bf08(jammer, attackingplayer, undefined);
		function_2e6238c0(weapon, entity.owner);
		thread [[level.var_578f7c6d.var_1728e736[weapon.name]]](entity, attackingplayer);
		return true;
	}
	thread function_ca8a005e(jammer, entity, attackingplayer);
	return true;
}

/*
	Name: function_b8c5ab9c
	Namespace: jammer
	Checksum: 0x3EBAFAD2
	Offset: 0x1050
	Size: 0x13C
	Parameters: 3
	Flags: Private
*/
function private function_b8c5ab9c(jammer, player, attackingplayer)
{
	player notify(#"hash_4f2e183cc0ec68bd");
	player endon(#"death", #"hash_4f2e183cc0ec68bd");
	player clientfield::set_to_player("isJammed", 1);
	player.isjammed = 1;
	player.var_fe1ebada = attackingplayer;
	player setempjammed(1);
	scoreevents::processscoreevent(#"disrupted_enemy", attackingplayer, undefined, level.var_578f7c6d.weapon);
	function_58f8bf08(jammer, attackingplayer, player);
	wait(level.var_578f7c6d.customsettings.var_f29418f1);
	if(!isdefined(player))
	{
		return;
	}
	function_d88f3e48(player);
}

/*
	Name: function_ca8a005e
	Namespace: jammer
	Checksum: 0xDC884A8F
	Offset: 0x1198
	Size: 0x184
	Parameters: 3
	Flags: Private
*/
function private function_ca8a005e(jammer, gadget, attackingplayer)
{
	gadget endon(#"death");
	if(!isdefined(gadget.weapon))
	{
		return;
	}
	if(!gadget.weapon.var_8032088a)
	{
		return;
	}
	function_1c430dad(gadget, 1);
	function_2e6238c0(gadget.weapon, gadget.owner);
	if(isdefined(gadget.weapon.var_775d2aad) && gadget.weapon.var_775d2aad)
	{
		thread function_4a82368f(gadget, gadget.owner);
	}
	wait(gadget.weapon.var_416021d8);
	if(!isdefined(attackingplayer))
	{
		return;
	}
	if(!isdefined(gadget))
	{
		return;
	}
	gadget dodamage(1000, gadget.origin, attackingplayer, jammer, undefined, "MOD_GRENADE_SPLASH", 0, level.var_578f7c6d.weapon);
	function_58f8bf08(jammer, attackingplayer, undefined);
}

/*
	Name: function_4a82368f
	Namespace: jammer
	Checksum: 0x24BE9608
	Offset: 0x1328
	Size: 0xDC
	Parameters: 2
	Flags: None
*/
function function_4a82368f(entity, owner)
{
	/#
		assert(isdefined(owner));
	#/
	if(isplayer(owner))
	{
		owner clientfield::set_to_player("jammedvehpostfx", 1);
	}
	entity waittill(#"death", #"remote_weapon_end", #"hash_2476803a0d5fa572");
	if(!isdefined(owner))
	{
		return;
	}
	if(isplayer(owner))
	{
		owner clientfield::set_to_player("jammedvehpostfx", 0);
	}
}

/*
	Name: function_1c430dad
	Namespace: jammer
	Checksum: 0x903448E1
	Offset: 0x1410
	Size: 0x8A
	Parameters: 2
	Flags: None
*/
function function_1c430dad(entity, isjammed)
{
	if(!isplayer(entity) && !isactor(entity))
	{
		entity clientfield::set("isJammed", isjammed);
	}
	entity.isjammed = isjammed;
	entity.emped = isjammed;
}

/*
	Name: function_d88f3e48
	Namespace: jammer
	Checksum: 0xE45529FC
	Offset: 0x14A8
	Size: 0xE4
	Parameters: 1
	Flags: Private
*/
function private function_d88f3e48(entity)
{
	if(!isdefined(entity))
	{
		return;
	}
	if(isplayer(entity))
	{
		entity clientfield::set_to_player("isJammed", 0);
		entity setempjammed(0);
	}
	function_1c430dad(entity, 0);
	if(isdefined(entity.weapon) && !isplayer(entity) && isdefined(entity.owner))
	{
		function_2eb0a933(entity.weapon, entity.owner);
	}
}

/*
	Name: function_6a973411
	Namespace: jammer
	Checksum: 0x99E93ACA
	Offset: 0x1598
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_6a973411()
{
	util::wait_network_frame();
	self clientfield::set("jammer_active", 0);
	util::wait_network_frame();
	self clientfield::set("jammer_active", 1);
}

/*
	Name: function_cc908239
	Namespace: jammer
	Checksum: 0x87B1EA01
	Offset: 0x1608
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function function_cc908239(entity)
{
	if(isdefined(entity.owner))
	{
		return entity.owner;
	}
	return undefined;
}

/*
	Name: function_51a743f8
	Namespace: jammer
	Checksum: 0x49544A56
	Offset: 0x1640
	Size: 0x34
	Parameters: 3
	Flags: None
*/
function function_51a743f8(attacker, weapon, target)
{
	self delete();
}

/*
	Name: function_b2e496fa
	Namespace: jammer
	Checksum: 0xAB9CDA86
	Offset: 0x1680
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_b2e496fa(watcher)
{
	self delete();
}

/*
	Name: function_b16c8865
	Namespace: jammer
	Checksum: 0x94B0D292
	Offset: 0x16B0
	Size: 0x160
	Parameters: 2
	Flags: Private
*/
function private function_b16c8865(entity, attackingplayer)
{
	if(self == entity)
	{
		return false;
	}
	if(!isplayer(entity) && (!isdefined(entity.model) || entity.model == #""))
	{
		return false;
	}
	if(isactor(entity) && (!(isdefined(entity.var_8f61d7f4) && entity.var_8f61d7f4)))
	{
		return false;
	}
	if(isdefined(entity.team) && !util::function_fbce7263(entity.team, attackingplayer.team))
	{
		return false;
	}
	if(isplayer(entity) && entity function_6c32d092(#"talent_resistance"))
	{
		return false;
	}
	if((isdefined(entity.ignoreemp) ? entity.ignoreemp : 0))
	{
		return false;
	}
	return true;
}

/*
	Name: function_7b151daa
	Namespace: jammer
	Checksum: 0x3EFC0DCA
	Offset: 0x1818
	Size: 0x28
	Parameters: 1
	Flags: Private
*/
function private function_7b151daa(player)
{
	return isdefined(player.isjammed) && player.isjammed;
}

/*
	Name: function_5f86757d
	Namespace: jammer
	Checksum: 0x6B5C83B1
	Offset: 0x1848
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function function_5f86757d()
{
	level endon(#"game_ended");
	waitresult = undefined;
	waitresult = self waittill(#"explode", #"death");
	if(!isdefined(self))
	{
		return waitresult;
	}
	self clientfield::set("enemyequip", 0);
	return waitresult;
}

/*
	Name: function_3a3a2ea9
	Namespace: jammer
	Checksum: 0x5E62B47A
	Offset: 0x18D0
	Size: 0xA4
	Parameters: 1
	Flags: Private
*/
function private function_3a3a2ea9(jammer)
{
	jammer endon(#"death");
	waitresult = undefined;
	waitresult = jammer waittilltimeout(2, #"hash_754a0aedf9f00e8d");
	if(!isdefined(jammer))
	{
		return;
	}
	jammer playsound(#"hash_7ed67b248bc52c02");
	playfxontag(#"hash_5a695126234cbb41", jammer, "tag_origin");
}

/*
	Name: function_58f8bf08
	Namespace: jammer
	Checksum: 0xDABC532B
	Offset: 0x1980
	Size: 0x8C
	Parameters: 3
	Flags: Private
*/
function private function_58f8bf08(jammer, attackingplayer, victim)
{
	if(damagefeedback::dodamagefeedback(level.var_578f7c6d.weapon, attackingplayer))
	{
		attackingplayer thread damagefeedback::update("MOD_UNKNOWN", jammer, undefined, level.var_578f7c6d.weapon, victim, 0, undefined, 0, 0, 1);
	}
}

/*
	Name: function_2e6238c0
	Namespace: jammer
	Checksum: 0x488757EF
	Offset: 0x1A18
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function function_2e6238c0(weapon, owner)
{
	if(!isdefined(weapon) || !isdefined(owner))
	{
		return;
	}
	taacomdialog = undefined;
	leaderdialog = undefined;
	switch(weapon.name)
	{
		case "tank_robot":
		case "inventory_tank_robot":
		case "ai_tank_marker":
		{
			taacomdialog = "aiTankJammedStart";
			leaderdialog = "aiTankJammedStart";
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			taacomdialog = "ultTurretJammedStart";
			leaderdialog = "ultTurretJammedStart";
			break;
		}
		case "ability_smart_cover":
		case "gadget_smart_cover":
		{
			taacomdialog = "smartCoverJammedStart";
			break;
		}
	}
	if(isdefined(leaderdialog) && isdefined(owner))
	{
		if(isdefined(level.var_57e2bc08))
		{
			if(level.teambased)
			{
				thread [[level.var_57e2bc08]](leaderdialog, owner.team, owner);
			}
		}
	}
	if(isdefined(taacomdialog) && isdefined(owner))
	{
		owner thread killstreaks::play_taacom_dialog(taacomdialog);
	}
}

/*
	Name: function_2eb0a933
	Namespace: jammer
	Checksum: 0x9AB68E82
	Offset: 0x1BB8
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function function_2eb0a933(weapon, owner)
{
	if(!isdefined(weapon) || !isdefined(owner))
	{
		return;
	}
	taacomdialog = undefined;
	leaderdialog = undefined;
	switch(weapon.name)
	{
		case "tank_robot":
		case "inventory_tank_robot":
		case "ai_tank_marker":
		{
			taacomdialog = "aiTankJammedEnd";
			leaderdialog = "aiTankJammedEnd";
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			taacomdialog = "ultTurretJammedEnd";
			leaderdialog = "ultTurretJammedEnd";
			break;
		}
		case "ability_smart_cover":
		case "gadget_smart_cover":
		{
			taacomdialog = "smartCoverJammedEnd";
			break;
		}
	}
	if(isdefined(leaderdialog) && isdefined(owner))
	{
		if(isdefined(level.var_57e2bc08))
		{
			if(level.teambased)
			{
				thread [[level.var_57e2bc08]](leaderdialog, owner.team, owner);
			}
		}
	}
	if(isdefined(taacomdialog) && isdefined(owner))
	{
		owner thread killstreaks::play_taacom_dialog(taacomdialog);
	}
}

