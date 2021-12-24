// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_41fe08c37d53a635;
#using script_4c5c4a64a59247a2;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\throttle_shared.gsc;

#namespace gib;

/*
	Name: main
	Namespace: gib
	Checksum: 0xCD6F89E8
	Offset: 0x1B0
	Size: 0xB8
	Parameters: 0
	Flags: AutoExec
*/
autoexec function main()
{
	clientfield::register("actor", "gib_state", 1, 9, "int");
	clientfield::register("playercorpse", "gib_state", 1, 15, "int");
	level.var_ad0f5efa = [];
	if(!isdefined(level.gib_throttle))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.gib_throttle = object;
		[[ level.gib_throttle ]]->initialize(2, 0.2);
	}
}

#namespace gibserverutils;

/*
	Name: function_3aa023f1
	Namespace: gibserverutils
	Checksum: 0x8EC906CE
	Offset: 0x270
	Size: 0x30E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3aa023f1(name, entity)
{
	if(!isdefined(name))
	{
		return undefined;
	}
	gibdef = level.var_ad0f5efa[name];
	if(isdefined(gibdef))
	{
		return gibdef;
	}
	definition = struct::get_script_bundle("gibcharacterdef", name);
	if(!isdefined(definition))
	{
		/#
			assertmsg("" + name);
		#/
		return undefined;
	}
	gibpiecelookup = [];
	gibpiecelookup[2] = "annihilate";
	gibpiecelookup[8] = "head";
	gibpiecelookup[16] = "rightarm";
	gibpiecelookup[32] = "leftarm";
	gibpiecelookup[128] = "rightleg";
	gibpiecelookup[256] = "leftleg";
	var_90aba050 = [];
	foreach(gibflag, gibpiece in gibpiecelookup)
	{
		if(!isdefined(gibpiece))
		{
			/#
				assertmsg("" + gibflag);
			#/
			continue;
		}
		gibstruct = spawnstruct();
		gibstruct.gibmodel = definition.(gibpiece + "_gibmodel");
		gibstruct.gibtag = definition.(gibpiece + "_gibtag");
		gibstruct.gibfx = definition.(gibpiece + "_gibfx");
		gibstruct.gibfxtag = definition.(gibpiece + "_gibeffecttag");
		gibstruct.gibdynentfx = definition.(gibpiece + "_gibdynentfx");
		gibstruct.gibcinematicfx = definition.(gibpiece + "_gibcinematicfx");
		gibstruct.gibsound = definition.(gibpiece + "_gibsound");
		gibstruct.gibhidetag = definition.(gibpiece + "_gibhidetag");
		var_90aba050[gibflag] = gibstruct;
	}
	level.var_ad0f5efa[name] = var_90aba050;
	return var_90aba050;
}

/*
	Name: function_69db754
	Namespace: gibserverutils
	Checksum: 0xB507CCF3
	Offset: 0x588
	Size: 0x48
	Parameters: 3
	Flags: Linked, Private
*/
private function function_69db754(name, gibflag, entity)
{
	var_90aba050 = function_3aa023f1(name, entity);
	return var_90aba050[gibflag];
}

/*
	Name: _annihilate
	Namespace: gibserverutils
	Checksum: 0x5F08B9A3
	Offset: 0x5D8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function _annihilate(entity)
{
	if(isdefined(entity))
	{
		entity notsolid();
	}
}

/*
	Name: _getgibextramodel
	Namespace: gibserverutils
	Checksum: 0x13B149E4
	Offset: 0x610
	Size: 0xC4
	Parameters: 2
	Flags: Linked, Private
*/
private function _getgibextramodel(entity, gibflag)
{
	if(gibflag == 4)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
	}
	if(gibflag == 8)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
	}
	/#
		assertmsg("");
	#/
}

/*
	Name: _gibextra
	Namespace: gibserverutils
	Checksum: 0x183B7A57
	Offset: 0x6E0
	Size: 0x68
	Parameters: 2
	Flags: Linked, Private
*/
private function _gibextra(entity, gibflag)
{
	if(isgibbed(entity, gibflag))
	{
		return 0;
	}
	if(!_hasgibdef(entity))
	{
		return 0;
	}
	entity thread _gibextrainternal(entity, gibflag);
	return 1;
}

/*
	Name: _gibextrainternal
	Namespace: gibserverutils
	Checksum: 0x3B9B43CB
	Offset: 0x750
	Size: 0x1F4
	Parameters: 2
	Flags: Linked, Private
*/
private function _gibextrainternal(entity, gibflag)
{
	if(entity.gib_time !== gettime())
	{
		[[ level.gib_throttle ]]->waitinqueue(entity);
	}
	if(!isdefined(entity))
	{
		return;
	}
	entity.gib_time = gettime();
	if(isgibbed(entity, gibflag))
	{
		return 0;
	}
	if(gibflag == 8)
	{
		if(isdefined((isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)))
		{
			entity attach((isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5), "", 1);
		}
	}
	_setgibbed(entity, gibflag, undefined);
	destructserverutils::showdestructedpieces(entity);
	showhiddengibpieces(entity);
	gibmodel = _getgibextramodel(entity, gibflag);
	if(isdefined(gibmodel) && entity isattached(gibmodel))
	{
		entity detach(gibmodel, "");
	}
	destructserverutils::reapplydestructedpieces(entity);
	reapplyhiddengibpieces(entity);
}

/*
	Name: _gibentity
	Namespace: gibserverutils
	Checksum: 0xCB7CA5C0
	Offset: 0x950
	Size: 0x88
	Parameters: 2
	Flags: Linked, Private
*/
private function _gibentity(entity, gibflag)
{
	if(isgibbed(entity, gibflag) || !_hasgibpieces(entity, gibflag))
	{
		return 0;
	}
	if(!_hasgibdef(entity))
	{
		return 0;
	}
	entity thread _gibentityinternal(entity, gibflag);
	return 1;
}

/*
	Name: _gibentityinternal
	Namespace: gibserverutils
	Checksum: 0xEBFF824E
	Offset: 0x9E0
	Size: 0x194
	Parameters: 2
	Flags: Linked, Private
*/
private function _gibentityinternal(entity, gibflag)
{
	if(entity.gib_time !== gettime())
	{
		[[ level.gib_throttle ]]->waitinqueue(entity);
	}
	if(!isdefined(entity))
	{
		return;
	}
	entity.gib_time = gettime();
	if(isgibbed(entity, gibflag))
	{
		return;
	}
	destructserverutils::showdestructedpieces(entity);
	showhiddengibpieces(entity);
	if(!_getgibbedstate(entity) < 16)
	{
		legmodel = _getgibbedlegmodel(entity);
		entity detach(legmodel);
	}
	_setgibbed(entity, gibflag, undefined);
	entity setmodel(_getgibbedtorsomodel(entity));
	entity attach(_getgibbedlegmodel(entity));
	destructserverutils::reapplydestructedpieces(entity);
	reapplyhiddengibpieces(entity);
}

/*
	Name: _getgibbedlegmodel
	Namespace: gibserverutils
	Checksum: 0xC05BF64C
	Offset: 0xB80
	Size: 0x152
	Parameters: 1
	Flags: Linked, Private
*/
private function _getgibbedlegmodel(entity)
{
	gibstate = _getgibbedstate(entity);
	rightleggibbed = gibstate & 128;
	leftleggibbed = gibstate & 256;
	if(rightleggibbed && leftleggibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
	}
	if(rightleggibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
	}
	if(leftleggibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
	}
	return (isdefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1);
}

/*
	Name: _getgibbedstate
	Namespace: gibserverutils
	Checksum: 0x64085D49
	Offset: 0xCE0
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
private function _getgibbedstate(entity)
{
	if(isdefined(entity.gib_state))
	{
		return entity.gib_state;
	}
	return 0;
}

/*
	Name: _getgibbedtorsomodel
	Namespace: gibserverutils
	Checksum: 0xBAD6F872
	Offset: 0xD18
	Size: 0x152
	Parameters: 1
	Flags: Linked, Private
*/
private function _getgibbedtorsomodel(entity)
{
	gibstate = _getgibbedstate(entity);
	rightarmgibbed = gibstate & 16;
	leftarmgibbed = gibstate & 32;
	if(rightarmgibbed && leftarmgibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
	}
	if(rightarmgibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
	}
	if(leftarmgibbed)
	{
		return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
	}
	return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1);
}

/*
	Name: _hasgibdef
	Namespace: gibserverutils
	Checksum: 0x20954053
	Offset: 0xE78
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
private function _hasgibdef(entity)
{
	return isdefined(entity.gibdef);
}

/*
	Name: _hasgibpieces
	Namespace: gibserverutils
	Checksum: 0xD1EBDF0
	Offset: 0xE98
	Size: 0xAE
	Parameters: 2
	Flags: Linked, Private
*/
private function _hasgibpieces(entity, gibflag)
{
	hasgibpieces = 0;
	gibstate = _getgibbedstate(entity);
	entity.gib_state = gibstate | (gibflag & (512 - 1));
	if(isdefined(_getgibbedtorsomodel(entity)) && isdefined(_getgibbedlegmodel(entity)))
	{
		hasgibpieces = 1;
	}
	entity.gib_state = gibstate;
	return hasgibpieces;
}

/*
	Name: _setgibbed
	Namespace: gibserverutils
	Checksum: 0xD96BE9CE
	Offset: 0xF50
	Size: 0x124
	Parameters: 3
	Flags: Linked, Private
*/
private function _setgibbed(entity, gibflag, gibdir)
{
	if(isdefined(gibdir))
	{
		angles = vectortoangles(gibdir);
		yaw = angles[1];
		yaw_bits = getbitsforangle(yaw, 3);
		entity.gib_state = (_getgibbedstate(entity) | (gibflag & (512 - 1))) + (yaw_bits << 9);
	}
	else
	{
		entity.gib_state = _getgibbedstate(entity) | (gibflag & (512 - 1));
	}
	entity.gibbed = 1;
	entity clientfield::set("gib_state", entity.gib_state);
}

/*
	Name: annihilate
	Namespace: gibserverutils
	Checksum: 0x5B9E9C89
	Offset: 0x1080
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function annihilate(entity)
{
	if(!_hasgibdef(entity))
	{
		return 0;
	}
	gibpiecestruct = function_69db754(entity.gibdef, 2, entity);
	if(isdefined(gibpiecestruct))
	{
		if(isdefined(gibpiecestruct.gibfx))
		{
			_setgibbed(entity, 2, undefined);
			entity thread _annihilate(entity);
			return 1;
		}
	}
	return 0;
}

/*
	Name: copygibstate
	Namespace: gibserverutils
	Checksum: 0x2A3F61BF
	Offset: 0x1138
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function copygibstate(originalentity, newentity)
{
	newentity.gib_state = _getgibbedstate(originalentity);
	togglespawngibs(newentity, 0);
	reapplyhiddengibpieces(newentity);
}

/*
	Name: isgibbed
	Namespace: gibserverutils
	Checksum: 0x2FC1F586
	Offset: 0x11A8
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function isgibbed(entity, gibflag)
{
	return _getgibbedstate(entity) & gibflag;
}

/*
	Name: gibhat
	Namespace: gibserverutils
	Checksum: 0xFE0175F6
	Offset: 0x11E0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function gibhat(entity)
{
	return _gibextra(entity, 4);
}

/*
	Name: gibhead
	Namespace: gibserverutils
	Checksum: 0xA43595DD
	Offset: 0x1210
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function gibhead(entity)
{
	gibhat(entity);
	level notify(#"gib", {#area:"head", #attacker:self.attacker, #entity:entity});
	return _gibextra(entity, 8);
}

/*
	Name: gibleftarm
	Namespace: gibserverutils
	Checksum: 0xC7069CA8
	Offset: 0x12B0
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function gibleftarm(entity)
{
	if(isgibbed(entity, 16))
	{
		return 0;
	}
	if(_gibentity(entity, 32))
	{
		destructserverutils::destructleftarmpieces(entity);
		level notify(#"gib", {#area:"left_arm", #attacker:self.attacker, #entity:entity});
		return 1;
	}
	return 0;
}

/*
	Name: gibrightarm
	Namespace: gibserverutils
	Checksum: 0xAEFC3A27
	Offset: 0x1370
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function gibrightarm(entity)
{
	if(isgibbed(entity, 32))
	{
		return 0;
	}
	if(_gibentity(entity, 16))
	{
		destructserverutils::destructrightarmpieces(entity);
		entity thread shared::dropaiweapon();
		level notify(#"gib", {#area:"right_arm", #attacker:self.attacker, #entity:entity});
		return 1;
	}
	return 0;
}

/*
	Name: gibleftleg
	Namespace: gibserverutils
	Checksum: 0xDC8B3253
	Offset: 0x1448
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function gibleftleg(entity)
{
	if(_gibentity(entity, 256))
	{
		destructserverutils::destructleftlegpieces(entity);
		level notify(#"gib", {#area:"left_leg", #attacker:self.attacker, #entity:entity});
		return 1;
	}
	return 0;
}

/*
	Name: gibrightleg
	Namespace: gibserverutils
	Checksum: 0xBA21EA7A
	Offset: 0x14E8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function gibrightleg(entity)
{
	if(_gibentity(entity, 128))
	{
		destructserverutils::destructrightlegpieces(entity);
		level notify(#"gib", {#area:"right_leg", #attacker:self.attacker, #entity:entity});
		return 1;
	}
	return 0;
}

/*
	Name: giblegs
	Namespace: gibserverutils
	Checksum: 0x90AE34A7
	Offset: 0x1588
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function giblegs(entity)
{
	if(_gibentity(entity, 384))
	{
		destructserverutils::destructrightlegpieces(entity);
		destructserverutils::destructleftlegpieces(entity);
		level notify(#"gib", {#area:"both_legs", #attacker:self.attacker, #entity:entity});
		return 1;
	}
	return 0;
}

/*
	Name: playergibleftarm
	Namespace: gibserverutils
	Checksum: 0xD036C816
	Offset: 0x1640
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function playergibleftarm(entity)
{
	if(isdefined(entity.body))
	{
		dir = (1, 0, 0);
		_setgibbed(entity.body, 32, dir);
	}
}

/*
	Name: playergibrightarm
	Namespace: gibserverutils
	Checksum: 0x86612161
	Offset: 0x1698
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function playergibrightarm(entity)
{
	if(isdefined(entity.body))
	{
		dir = (1, 0, 0);
		_setgibbed(entity.body, 16, dir);
	}
}

/*
	Name: playergibleftleg
	Namespace: gibserverutils
	Checksum: 0xCDC7F89F
	Offset: 0x16F0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function playergibleftleg(entity)
{
	if(isdefined(entity.body))
	{
		dir = (1, 0, 0);
		_setgibbed(entity.body, 256, dir);
	}
}

/*
	Name: playergibrightleg
	Namespace: gibserverutils
	Checksum: 0xA0337E58
	Offset: 0x1748
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function playergibrightleg(entity)
{
	if(isdefined(entity.body))
	{
		dir = (1, 0, 0);
		_setgibbed(entity.body, 128, dir);
	}
}

/*
	Name: playergiblegs
	Namespace: gibserverutils
	Checksum: 0x9353EDAB
	Offset: 0x17A0
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function playergiblegs(entity)
{
	if(isdefined(entity.body))
	{
		dir = (1, 0, 0);
		_setgibbed(entity.body, 128, dir);
		_setgibbed(entity.body, 256, dir);
	}
}

/*
	Name: playergibleftarmvel
	Namespace: gibserverutils
	Checksum: 0x892A2BE4
	Offset: 0x1818
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event playergibleftarmvel(entitystruct)
{
	if(isdefined(entitystruct.player.body))
	{
		_setgibbed(entitystruct.player.body, 32, entitystruct.direction);
	}
}

/*
	Name: playergibrightarmvel
	Namespace: gibserverutils
	Checksum: 0xE3C71E0C
	Offset: 0x1878
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event playergibrightarmvel(entitystruct)
{
	if(isdefined(entitystruct.player.body))
	{
		_setgibbed(entitystruct.player.body, 16, entitystruct.direction);
	}
}

/*
	Name: playergibleftlegvel
	Namespace: gibserverutils
	Checksum: 0xFE34B4B7
	Offset: 0x18D8
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event playergibleftlegvel(entitystruct)
{
	if(isdefined(entitystruct.player.body))
	{
		_setgibbed(entitystruct.player.body, 256, entitystruct.direction);
	}
}

/*
	Name: playergibrightlegvel
	Namespace: gibserverutils
	Checksum: 0xCA96A75A
	Offset: 0x1938
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event playergibrightlegvel(entitystruct)
{
	if(isdefined(entitystruct.player.body))
	{
		_setgibbed(entitystruct.player.body, 128, entitystruct.direction);
	}
}

/*
	Name: playergiblegsvel
	Namespace: gibserverutils
	Checksum: 0x978E15BD
	Offset: 0x1998
	Size: 0x84
	Parameters: 1
	Flags: Event
*/
event playergiblegsvel(entitystruct)
{
	if(isdefined(entitystruct.player.body))
	{
		_setgibbed(entitystruct.player.body, 128, entitystruct.direction);
		_setgibbed(entitystruct.player.body, 256, entitystruct.direction);
	}
}

/*
	Name: reapplyhiddengibpieces
	Namespace: gibserverutils
	Checksum: 0x2E092198
	Offset: 0x1A28
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function reapplyhiddengibpieces(entity)
{
	if(!_hasgibdef(entity))
	{
		return;
	}
	var_90aba050 = function_3aa023f1(entity.gibdef, entity);
	foreach(gibflag, gib in var_90aba050)
	{
		if(!isgibbed(entity, gibflag))
		{
			continue;
		}
		if(!isdefined(gib))
		{
			continue;
		}
		if(isdefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag))
		{
			if(!(isdefined(entity.skipdeath) && entity.skipdeath))
			{
				entity hidepart(gib.gibhidetag, "", 1);
			}
		}
	}
}

/*
	Name: showhiddengibpieces
	Namespace: gibserverutils
	Checksum: 0x4193165A
	Offset: 0x1BA0
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function showhiddengibpieces(entity)
{
	if(!_hasgibdef(entity))
	{
		return;
	}
	var_90aba050 = function_3aa023f1(entity.gibdef, entity);
	foreach(gib in var_90aba050)
	{
		if(!isdefined(gib))
		{
			continue;
		}
		if(isdefined(gib.gibhidetag) && entity haspart(gib.gibhidetag))
		{
			entity showpart(gib.gibhidetag, "", 1);
		}
	}
}

/*
	Name: togglespawngibs
	Namespace: gibserverutils
	Checksum: 0x853FD1C6
	Offset: 0x1CC0
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function togglespawngibs(entity, shouldspawngibs)
{
	if(!shouldspawngibs)
	{
		entity.gib_state = _getgibbedstate(entity) | 1;
	}
	else
	{
		entity.gib_state = _getgibbedstate(entity) & -2;
	}
	entity clientfield::set("gib_state", entity.gib_state);
}

