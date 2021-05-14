// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace bb;

/*
	Name: function_89f2df9
	Namespace: bb
	Checksum: 0xDF1FF9D6
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bb", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bb
	Checksum: 0xB5E205C6
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: bb
	Checksum: 0x21B80C5F
	Offset: 0x130
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self._bbdata = [];
	self._bbdata[#"score"] = 0;
	self._bbdata[#"momentum"] = 0;
	self._bbdata[#"spawntime"] = gettime();
	self._bbdata[#"shots"] = 0;
	self._bbdata[#"hits"] = 0;
	callback::on_death(&on_player_death);
}

/*
	Name: function_bf5cad4e
	Namespace: bb
	Checksum: 0x4452745A
	Offset: 0x1E0
	Size: 0x2CC
	Parameters: 1
	Flags: None
*/
function function_bf5cad4e(var_1e866967)
{
	var_10d87328 = (isdefined(level.var_8a3a9ca4.roundend) ? level.var_8a3a9ca4.roundend : 0) - (isdefined(level.var_8a3a9ca4.roundstart) ? level.var_8a3a9ca4.roundstart : 0);
	firstblood = (isdefined(level.var_8a3a9ca4.firstblood) ? level.var_8a3a9ca4.firstblood : 0) - (isdefined(level.var_8a3a9ca4.roundstart) ? level.var_8a3a9ca4.roundstart : 0);
	alliesscore = (isdefined([[level._getteamscore]](#"allies")) ? [[level._getteamscore]](#"allies") : 0);
	axisscore = (isdefined([[level._getteamscore]](#"axis")) ? [[level._getteamscore]](#"axis") : 0);
	var_5e25b17b = abs(alliesscore - axisscore);
	var_1e866967 = {};
	var_1e866967.gamemode = level.gametype;
	var_1e866967.wintype = (isdefined(var_1e866967.wintype) ? var_1e866967.wintype : "NA");
	var_1e866967.var_10d87328 = var_10d87328;
	var_1e866967.firstblood = firstblood;
	var_1e866967.var_5e25b17b = var_5e25b17b;
	var_1e866967.timeremaining = (isdefined(var_1e866967.remainingtime) ? var_1e866967.remainingtime : 0);
	var_1e866967.var_20de6a02 = (isdefined(var_1e866967.var_20de6a02) ? var_1e866967.var_20de6a02 : 0);
	var_1e866967.var_be1de2ab = (isdefined(var_1e866967.var_be1de2ab) ? var_1e866967.var_be1de2ab : 0);
	function_92d1707f(#"hash_1a63efe7c6121b24", var_1e866967);
}

/*
	Name: function_95a5b5c2
	Namespace: bb
	Checksum: 0xAD91F671
	Offset: 0x4B8
	Size: 0x18C
	Parameters: 5
	Flags: None
*/
function function_95a5b5c2(var_daec1817, label, team, origin, player)
{
	if(sessionmodeismultiplayergame())
	{
		var_cfad67d4 = (function_7a600918(team) ? team : hash(team));
		clientid = isdefined(player) && (isdefined(player.clientid) ? player.clientid : -1);
		function_92d1707f(#"hash_d424efe4db1dff7", {#clientid:clientid, #playerz:origin[2], #playery:origin[1], #playerx:origin[0], #team:var_cfad67d4, #label:label, #objtype:var_daec1817, #gametime:function_f8d53445()});
	}
}

/*
	Name: function_c3b9e07f
	Namespace: bb
	Checksum: 0x6FCDF310
	Offset: 0x650
	Size: 0x24C
	Parameters: 14
	Flags: Linked
*/
function function_c3b9e07f(eattacker, attackerorigin, var_a48b1a67, attackerweapon, evictim, victimorigin, var_76d450bd, victimweapon, idamage, smeansofdeath, shitloc, death, isusingheropower, killstreak)
{
	if(!sessionmodeismultiplayergame())
	{
		return;
	}
	mpattacks = {};
	mpattacks.gametime = function_f8d53445();
	if(isdefined(eattacker))
	{
		mpattacks.attackerspawnid = getplayerspawnid(eattacker);
	}
	if(isdefined(attackerorigin))
	{
		mpattacks.attackerx = attackerorigin[0];
		mpattacks.attackery = attackerorigin[1];
		mpattacks.attackerz = attackerorigin[2];
	}
	mpattacks.var_a48b1a67 = var_a48b1a67;
	mpattacks.attackerweapon = attackerweapon;
	if(isdefined(evictim))
	{
		mpattacks.victimspawnid = getplayerspawnid(evictim);
	}
	if(isdefined(victimorigin))
	{
		mpattacks.victimx = victimorigin[0];
		mpattacks.victimy = victimorigin[1];
		mpattacks.victimz = victimorigin[2];
	}
	mpattacks.var_76d450bd = var_76d450bd;
	mpattacks.victimweapon = victimweapon;
	mpattacks.damage = idamage;
	mpattacks.damagetype = smeansofdeath;
	mpattacks.damagelocation = shitloc;
	mpattacks.death = death;
	mpattacks.isusingheropower = isusingheropower;
	mpattacks.killstreak = killstreak;
	function_92d1707f(#"hash_67e3a427b7ec1819", mpattacks);
}

/*
	Name: on_player_death
	Namespace: bb
	Checksum: 0x5321AB3B
	Offset: 0x8A8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function on_player_death(params)
{
	if(isbot(self))
	{
		return;
	}
	if(game.state == "playing")
	{
		self commit_spawn_data();
	}
}

/*
	Name: function_6661621a
	Namespace: bb
	Checksum: 0x80D48C69
	Offset: 0x908
	Size: 0x71C
	Parameters: 0
	Flags: Linked
*/
function function_6661621a()
{
	if(isbot(self))
	{
		return;
	}
	/#
		/#
			assert(isdefined(self._bbdata));
		#/
	#/
	if(!isdefined(self.class_num))
	{
		return;
	}
	if(!sessionmodeismultiplayergame())
	{
		return;
	}
	var_1a7851a3 = spawnstruct();
	var_1a7851a3.gametime = function_f8d53445();
	var_1a7851a3.spawnid = getplayerspawnid(self);
	primaryweapon = self getloadoutweapon(self.class_num, "primary");
	var_1a7851a3.primary = primaryweapon.name;
	var_6834562f = function_285f8efd(primaryweapon);
	var_1a7851a3.primaryattachment1 = var_6834562f.var_65be22a9;
	var_1a7851a3.primaryattachment2 = var_6834562f.attachment1;
	var_1a7851a3.primaryattachment3 = var_6834562f.attachment2;
	var_1a7851a3.primaryattachment4 = var_6834562f.attachment3;
	var_1a7851a3.var_741a707b = var_6834562f.attachment4;
	var_1a7851a3.var_27509928 = hash(self getweaponoptic(primaryweapon));
	var_1a7851a3.var_b3cb3732 = self function_9b237966(self.class_num, 1);
	var_1a7851a3.var_5f2a5b01 = self function_73182cb6(self.class_num, 1);
	secondaryweapon = self getloadoutweapon(self.class_num, "secondary");
	var_1a7851a3.secondary = secondaryweapon.name;
	var_90030ba7 = function_285f8efd(secondaryweapon);
	var_1a7851a3.secondaryattachment1 = var_90030ba7.var_65be22a9;
	var_1a7851a3.secondaryattachment2 = var_90030ba7.attachment1;
	var_1a7851a3.var_1e8aa8c8 = var_90030ba7.attachment2;
	var_1a7851a3.var_783f5bcc = var_90030ba7.attachment3;
	var_1a7851a3.var_82897060 = var_90030ba7.attachment4;
	var_1a7851a3.var_92bbb1fd = hash(self getweaponoptic(secondaryweapon));
	var_1a7851a3.var_37fdd840 = self function_9b237966(self.class_num, 0);
	var_1a7851a3.var_f27f3a24 = self function_73182cb6(self.class_num, 0);
	var_1a7851a3.tacticalgear = self function_d78e0e04(self.class_num);
	var_1a7851a3.killstreak1 = (self.killstreak.size > 0 ? hash(self.killstreak[0]) : 0);
	var_1a7851a3.killstreak2 = (self.killstreak.size > 1 ? hash(self.killstreak[1]) : 0);
	var_1a7851a3.killstreak3 = (self.killstreak.size > 2 ? hash(self.killstreak[2]) : 0);
	talents = self function_4a9f1384(self.class_num);
	var_1a7851a3.var_942f949 = (talents.size > 0 ? talents[0] : 0);
	var_1a7851a3.var_f788d5d5 = (talents.size > 1 ? talents[1] : 0);
	var_1a7851a3.var_9e81a3e0 = (talents.size > 2 ? talents[2] : 0);
	var_1a7851a3.var_9c409f5e = (talents.size > 3 ? talents[3] : 0);
	var_1a7851a3.var_e56631ac = (talents.size > 4 ? talents[4] : 0);
	var_1a7851a3.var_432fed3e = (talents.size > 5 ? talents[5] : 0);
	wildcards = self function_6f2c0492(self.class_num);
	var_1a7851a3.var_bd1c86b8 = (wildcards.size > 0 ? wildcards[0] : 0);
	var_1a7851a3.var_cb5e233b = (wildcards.size > 1 ? wildcards[1] : 0);
	var_1a7851a3.var_13573300 = (wildcards.size > 2 ? wildcards[2] : 0);
	if(isdefined(self.playerrole) && isdefined(self.playerrole.var_c21d61e9))
	{
		var_c0f05cbb = getweapon((isdefined(self.playerrole.var_c21d61e9) ? self.playerrole.var_c21d61e9 : level.weaponnone));
	}
	else
	{
		var_c0f05cbb = level.weaponnone;
	}
	var_1a7851a3.var_9911e1f2 = var_c0f05cbb.name;
	var_1a7851a3.specialistindex = (isdefined(self getspecialistindex()) ? self getspecialistindex() : -1);
	function_92d1707f(#"hash_30b542620e21966d", #"hash_606f63fe928017f1", var_1a7851a3);
}

/*
	Name: commit_spawn_data
	Namespace: bb
	Checksum: 0x8FA5C7F3
	Offset: 0x1030
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function commit_spawn_data()
{
	if(isbot(self))
	{
		return;
	}
	/#
		/#
			assert(isdefined(self._bbdata));
		#/
	#/
	if(!isdefined(self._bbdata))
	{
		return;
	}
	if(!sessionmodeismultiplayergame())
	{
		return;
	}
	specialistindex = (isdefined(self getspecialistindex()) ? self getspecialistindex() : -1);
	mpplayerlives = {#specialist:specialistindex, #name:self.name, #lifetime:gettime() - self._bbdata[#"spawntime"], #lifemomentum:self._bbdata[#"momentum"], #lifescore:self._bbdata[#"score"], #spawnid:getplayerspawnid(self), #gametime:function_f8d53445()};
	function_92d1707f(#"hash_6fc210ad5f081ce8", mpplayerlives);
	self function_6661621a();
}

/*
	Name: function_285f8efd
	Namespace: bb
	Checksum: 0x68A67FA
	Offset: 0x1218
	Size: 0x2B2
	Parameters: 1
	Flags: Linked
*/
function function_285f8efd(weapon)
{
	var_e38a0464 = spawnstruct();
	var_e38a0464.var_65be22a9 = 0;
	var_e38a0464.attachment1 = 0;
	var_e38a0464.attachment2 = 0;
	var_e38a0464.attachment3 = 0;
	var_e38a0464.attachment4 = 0;
	var_e38a0464.attachment5 = 0;
	var_e38a0464.attachment6 = 0;
	if(!isdefined(weapon) || weapon.attachments.size == 0)
	{
		return var_e38a0464;
	}
	var_e38a0464.var_65be22a9 = hash(weapon.attachments[0]);
	if(weapon.attachments.size == 1)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment1 = hash(weapon.attachments[1]);
	if(weapon.attachments.size == 2)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment2 = hash(weapon.attachments[2]);
	if(weapon.attachments.size == 3)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment3 = hash(weapon.attachments[3]);
	if(weapon.attachments.size == 4)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment4 = hash(weapon.attachments[4]);
	if(weapon.attachments.size == 5)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment5 = hash(weapon.attachments[5]);
	if(weapon.attachments.size == 6)
	{
		return var_e38a0464;
	}
	var_e38a0464.attachment6 = hash(weapon.attachments[6]);
	return var_e38a0464;
}

