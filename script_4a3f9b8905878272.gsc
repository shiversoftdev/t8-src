// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace aiutility;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: aiutility
	Checksum: 0xE83A4401
	Offset: 0x208
	Size: 0x112C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&isatcrouchnode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcrouchnode", &isatcrouchnode);
	/#
		assert(iscodefunctionptr(&btapi_isatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isatcovercondition", &btapi_isatcovercondition);
	/#
		assert(isscriptfunctionptr(&isatcoverstrictcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcoverstrictcondition", &isatcoverstrictcondition);
	/#
		assert(isscriptfunctionptr(&isatcovermodeover));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodeover", &isatcovermodeover);
	/#
		assert(isscriptfunctionptr(&isatcovermodenone));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodenone", &isatcovermodenone);
	/#
		assert(isscriptfunctionptr(&isexposedatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isexposedatcovercondition", &isexposedatcovercondition);
	/#
		assert(isscriptfunctionptr(&keepclaimednodeandchoosecoverdirection));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimednodeandchoosecoverdirection", &keepclaimednodeandchoosecoverdirection);
	/#
		assert(isscriptfunctionptr(&resetcoverparameters));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"resetcoverparameters", &resetcoverparameters);
	/#
		assert(isscriptfunctionptr(&cleanupcovermode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupcovermode", &cleanupcovermode);
	/#
		assert(isscriptfunctionptr(&canbeflankedservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"canbeflankedservice", &canbeflankedservice);
	/#
		assert(isscriptfunctionptr(&shouldcoveridleonly));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldcoveridleonly", &shouldcoveridleonly);
	/#
		assert(isscriptfunctionptr(&issuppressedatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"issuppressedatcovercondition", &issuppressedatcovercondition);
	/#
		assert(isscriptfunctionptr(&coveridleinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleinitialize", &coveridleinitialize);
	/#
		assert(iscodefunctionptr(&btapi_coveridleupdate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_coveridleupdate", &btapi_coveridleupdate);
	/#
		assert(isscriptfunctionptr(&coveridleupdate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleupdate", &coveridleupdate);
	/#
		assert(isscriptfunctionptr(&coveridleterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleterminate", &coveridleterminate);
	/#
		assert(isscriptfunctionptr(&shouldleanatcoveridlecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcoveridlecondition", &shouldleanatcoveridlecondition);
	/#
		assert(isscriptfunctionptr(&continueleaningatcoveridlecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcoveridlecondition", &continueleaningatcoveridlecondition, 5);
	/#
		assert(isscriptfunctionptr(&isflankedbyenemyatcover));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isflankedbyenemyatcover", &isflankedbyenemyatcover);
	/#
		assert(isscriptfunctionptr(&coverflankedinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionstart", &coverflankedinitialize);
	/#
		assert(isscriptfunctionptr(&coverflankedactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionterminate", &coverflankedactionterminate);
	/#
		assert(isscriptfunctionptr(&supportsovercovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsovercovercondition", &supportsovercovercondition);
	/#
		assert(isscriptfunctionptr(&shouldoveratcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldoveratcovercondition", &shouldoveratcovercondition);
	/#
		assert(isscriptfunctionptr(&coveroverinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverinitialize", &coveroverinitialize);
	/#
		assert(isscriptfunctionptr(&coveroverterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverterminate", &coveroverterminate);
	/#
		assert(isscriptfunctionptr(&function_b605a3b2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ddf57d938c96a6", &function_b605a3b2);
	/#
		assert(isscriptfunctionptr(&supportsleancovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsleancovercondition", &supportsleancovercondition);
	/#
		assert(isscriptfunctionptr(&shouldleanatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcovercondition", &shouldleanatcovercondition);
	/#
		assert(isscriptfunctionptr(&continueleaningatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcovercondition", &continueleaningatcovercondition, 1);
	/#
		assert(isscriptfunctionptr(&coverleaninitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleaninitialize", &coverleaninitialize);
	/#
		assert(isscriptfunctionptr(&coverleanterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleanterminate", &coverleanterminate);
	/#
		assert(isscriptfunctionptr(&function_9e5575be));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72e14fa3a8f112e4", &function_9e5575be);
	/#
		assert(isscriptfunctionptr(&function_dc503571));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_229844e28015a254", &function_dc503571);
	/#
		assert(isscriptfunctionptr(&function_eb148f38));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65aba356fa88122c", &function_eb148f38);
	/#
		assert(isscriptfunctionptr(&function_4c672ae3));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35b14110efcdb018", &function_4c672ae3, 1);
	/#
		assert(isscriptfunctionptr(&function_a938cb03));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_636e311aa7ebc589", &function_a938cb03);
	/#
		assert(isscriptfunctionptr(&function_f82f8634));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2005ffaf6edd8e46", &function_f82f8634);
	/#
		assert(isscriptfunctionptr(&supportspeekcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportspeekcovercondition", &supportspeekcovercondition);
	/#
		assert(isscriptfunctionptr(&coverpeekinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekinitialize", &coverpeekinitialize);
	/#
		assert(isscriptfunctionptr(&coverpeekterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekterminate", &coverpeekterminate);
	/#
		assert(isscriptfunctionptr(&coverreloadinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverreloadinitialize", &coverreloadinitialize);
	/#
		assert(isscriptfunctionptr(&refillammoandcleanupcovermode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoandcleanupcovermode", &refillammoandcleanupcovermode);
}

/*
	Name: coverreloadinitialize
	Namespace: aiutility
	Checksum: 0xBA65D904
	Offset: 0x1340
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private coverreloadinitialize(entity)
{
	entity setblackboardattribute("_cover_mode", "cover_alert");
	keepclaimnode(entity);
}

/*
	Name: refillammoandcleanupcovermode
	Namespace: aiutility
	Checksum: 0x64FBBD2
	Offset: 0x1398
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function refillammoandcleanupcovermode(entity)
{
	if(isalive(entity))
	{
		refillammo(entity);
	}
	cleanupcovermode(entity);
}

/*
	Name: supportspeekcovercondition
	Namespace: aiutility
	Checksum: 0x7479ABBC
	Offset: 0x13F8
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
function private supportspeekcovercondition(entity)
{
	return isdefined(entity.node);
}

/*
	Name: coverpeekinitialize
	Namespace: aiutility
	Checksum: 0xCCA411AB
	Offset: 0x1418
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private coverpeekinitialize(entity)
{
	entity setblackboardattribute("_cover_mode", "cover_alert");
	keepclaimnode(entity);
	choosecoverdirection(entity);
}

/*
	Name: coverpeekterminate
	Namespace: aiutility
	Checksum: 0xDD3C7E5
	Offset: 0x1488
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private coverpeekterminate(entity)
{
	choosefrontcoverdirection(entity);
	cleanupcovermode(entity);
}

/*
	Name: function_dc503571
	Namespace: aiutility
	Checksum: 0x45F9396A
	Offset: 0x14D0
	Size: 0x120
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dc503571(entity)
{
	if(isdefined(entity.node))
	{
		if(entity.node.type == #"cover left" || entity.node.type == #"cover right")
		{
			return true;
		}
		if(entity.node.type == #"cover pillar")
		{
			if(!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) || (!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048)))
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_eb148f38
	Namespace: aiutility
	Checksum: 0xBB0EB156
	Offset: 0x15F8
	Size: 0x348
	Parameters: 1
	Flags: Linked, Private
*/
function private function_eb148f38(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin))
	{
		return 0;
	}
	yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	legalaimyaw = 0;
	if(entity.node.type == #"cover left")
	{
		aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
		legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= -10;
	}
	else
	{
		if(entity.node.type == #"cover right")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
			legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= 10;
		}
		else if(entity.node.type == #"cover pillar")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover");
			supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
			supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
			angleleeway = 10;
			if(supportsright && supportsleft)
			{
				angleleeway = 0;
			}
			if(supportsleft)
			{
				legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= (angleleeway * -1);
			}
			if(!legalaimyaw && supportsright)
			{
				legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= angleleeway;
			}
		}
	}
	return legalaimyaw;
}

/*
	Name: function_4c672ae3
	Namespace: aiutility
	Checksum: 0xB5DF5984
	Offset: 0x1948
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4c672ae3(entity)
{
	if(entity asmistransitionrunning())
	{
		return 1;
	}
	return function_eb148f38(entity);
}

/*
	Name: function_7353f95b
	Namespace: aiutility
	Checksum: 0xE3FC55AA
	Offset: 0x1998
	Size: 0x3C0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7353f95b(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type))
	{
		return 0;
	}
	if(isdefined(entity.enemy))
	{
		yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	}
	else
	{
		pos = entity.node.origin + (250 * entity.node.angles);
		yawtoenemyposition = angleclamp180((vectortoangles(pos - entity.node.origin)[1]) - entity.node.angles[1]);
	}
	legalaimyaw = 0;
	if(entity.node.type == #"cover left")
	{
		aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
		legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= -10;
	}
	else
	{
		if(entity.node.type == #"cover right")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
			legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= 10;
		}
		else if(entity.node.type == #"cover pillar")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover");
			supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
			supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
			angleleeway = 10;
			if(supportsright && supportsleft)
			{
				angleleeway = 0;
			}
			if(supportsleft)
			{
				legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= (angleleeway * -1);
			}
			if(!legalaimyaw && supportsright)
			{
				legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= angleleeway;
			}
		}
	}
	return legalaimyaw;
}

/*
	Name: function_e9788bfb
	Namespace: aiutility
	Checksum: 0xBD4212D3
	Offset: 0x1D60
	Size: 0x42
	Parameters: 1
	Flags: Private
*/
function private function_e9788bfb(entity)
{
	if(entity asmistransitionrunning())
	{
		return 1;
	}
	return function_7353f95b(entity);
}

/*
	Name: function_a938cb03
	Namespace: aiutility
	Checksum: 0xEA888722
	Offset: 0x1DB0
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a938cb03(entity)
{
	setcovershootstarttime(entity);
	keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_lean");
	choosecoverdirection(entity);
}

/*
	Name: function_f82f8634
	Namespace: aiutility
	Checksum: 0x18660506
	Offset: 0x1E38
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f82f8634(entity)
{
	choosefrontcoverdirection(entity);
	cleanupcovermode(entity);
	clearcovershootstarttime(entity);
}

/*
	Name: supportsleancovercondition
	Namespace: aiutility
	Checksum: 0x52A0ADC
	Offset: 0x1E98
	Size: 0x120
	Parameters: 1
	Flags: Linked, Private
*/
function private supportsleancovercondition(entity)
{
	if(isdefined(entity.node))
	{
		if(entity.node.type == #"cover left" || entity.node.type == #"cover right")
		{
			return true;
		}
		if(entity.node.type == #"cover pillar")
		{
			if(!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024) || (!(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048)))
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: shouldleanatcovercondition
	Namespace: aiutility
	Checksum: 0x8D88667B
	Offset: 0x1FC0
	Size: 0x348
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldleanatcovercondition(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin))
	{
		return 0;
	}
	yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	legalaimyaw = 0;
	if(entity.node.type == #"cover left")
	{
		aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
		legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= -10;
	}
	else
	{
		if(entity.node.type == #"cover right")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
			legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= 10;
		}
		else if(entity.node.type == #"cover pillar")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover");
			supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
			supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
			angleleeway = 10;
			if(supportsright && supportsleft)
			{
				angleleeway = 0;
			}
			if(supportsleft)
			{
				legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= (angleleeway * -1);
			}
			if(!legalaimyaw && supportsright)
			{
				legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= angleleeway;
			}
		}
	}
	return legalaimyaw;
}

/*
	Name: continueleaningatcovercondition
	Namespace: aiutility
	Checksum: 0xD11E3C01
	Offset: 0x2310
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private continueleaningatcovercondition(entity)
{
	if(entity asmistransitionrunning())
	{
		return 1;
	}
	return shouldleanatcovercondition(entity);
}

/*
	Name: shouldleanatcoveridlecondition
	Namespace: aiutility
	Checksum: 0x372CAD57
	Offset: 0x2360
	Size: 0x3C0
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldleanatcoveridlecondition(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type))
	{
		return 0;
	}
	if(isdefined(entity.enemy))
	{
		yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	}
	else
	{
		pos = entity.node.origin + (250 * entity.node.angles);
		yawtoenemyposition = angleclamp180((vectortoangles(pos - entity.node.origin)[1]) - entity.node.angles[1]);
	}
	legalaimyaw = 0;
	if(entity.node.type == #"cover left")
	{
		aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
		legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= -10;
	}
	else
	{
		if(entity.node.type == #"cover right")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
			legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= 10;
		}
		else if(entity.node.type == #"cover pillar")
		{
			aimlimitsforcover = entity getaimlimitsfromentry("cover");
			supportsleft = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024);
			supportsright = !(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048);
			angleleeway = 10;
			if(supportsright && supportsleft)
			{
				angleleeway = 0;
			}
			if(supportsleft)
			{
				legalaimyaw = yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10) && yawtoenemyposition >= (angleleeway * -1);
			}
			if(!legalaimyaw && supportsright)
			{
				legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= angleleeway;
			}
		}
	}
	return legalaimyaw;
}

/*
	Name: continueleaningatcoveridlecondition
	Namespace: aiutility
	Checksum: 0xD7C1D49D
	Offset: 0x2728
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private continueleaningatcoveridlecondition(entity)
{
	if(entity asmistransitionrunning())
	{
		return 1;
	}
	return shouldleanatcoveridlecondition(entity);
}

/*
	Name: coverleaninitialize
	Namespace: aiutility
	Checksum: 0xB0E69CAC
	Offset: 0x2778
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private coverleaninitialize(entity)
{
	setcovershootstarttime(entity);
	keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_lean");
	choosecoverdirection(entity);
}

/*
	Name: coverleanterminate
	Namespace: aiutility
	Checksum: 0xC06BA502
	Offset: 0x2800
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private coverleanterminate(entity)
{
	choosefrontcoverdirection(entity);
	cleanupcovermode(entity);
	clearcovershootstarttime(entity);
}

/*
	Name: function_9e5575be
	Namespace: aiutility
	Checksum: 0xE61F2145
	Offset: 0x2860
	Size: 0x7A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e5575be(entity)
{
	choosefrontcoverdirection(entity);
	cleanupcovermode(entity);
	clearcovershootstarttime(entity);
	entity ai::gun_recall();
	entity.blockingpain = 0;
}

/*
	Name: supportsovercovercondition
	Namespace: aiutility
	Checksum: 0x792A8287
	Offset: 0x28E8
	Size: 0x22C
	Parameters: 1
	Flags: Linked, Private
*/
function private supportsovercovercondition(entity)
{
	stance = entity getblackboardattribute("_stance");
	if(isdefined(entity.node))
	{
		if(entity.node.type == #"conceal crouch" || entity.node.type == #"conceal stand")
		{
			return true;
		}
		if(!isinarray(getvalidcoverpeekouts(entity.node), "over"))
		{
			return false;
		}
		if(entity.node.type == #"cover left" || entity.node.type == #"cover right" || (entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch"))
		{
			if(stance == "crouch")
			{
				return true;
			}
		}
		else if(entity.node.type == #"cover stand" || entity.node.type == #"conceal stand")
		{
			if(stance == "stand")
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: shouldoveratcovercondition
	Namespace: aiutility
	Checksum: 0xD862BC85
	Offset: 0x2B20
	Size: 0x1F6
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldoveratcovercondition(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin))
	{
		return false;
	}
	aimtable = (iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over");
	aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
	yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	legalaimyaw = yawtoenemyposition >= (aimlimitsforcover[#"aim_right"] - 10) && yawtoenemyposition <= (aimlimitsforcover[#"aim_left"] + 10);
	if(!legalaimyaw)
	{
		return false;
	}
	pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
	legalaimpitch = pitchtoenemyposition >= (aimlimitsforcover[#"aim_up"] + 10) && pitchtoenemyposition <= (aimlimitsforcover[#"aim_down"] + 10);
	if(!legalaimpitch)
	{
		return false;
	}
	return true;
}

/*
	Name: coveroverinitialize
	Namespace: aiutility
	Checksum: 0x3A141D1A
	Offset: 0x2D20
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private coveroverinitialize(entity)
{
	setcovershootstarttime(entity);
	keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_over");
}

/*
	Name: coveroverterminate
	Namespace: aiutility
	Checksum: 0x8AC02D04
	Offset: 0x2D90
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private coveroverterminate(entity)
{
	cleanupcovermode(entity);
	clearcovershootstarttime(entity);
}

/*
	Name: function_b605a3b2
	Namespace: aiutility
	Checksum: 0xB9F18F38
	Offset: 0x2DD8
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b605a3b2(entity)
{
	coveroverterminate(entity);
	entity ai::gun_recall();
	entity.blockingpain = 0;
}

/*
	Name: coveridleinitialize
	Namespace: aiutility
	Checksum: 0x7BA45DE9
	Offset: 0x2E30
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private coveridleinitialize(entity)
{
	keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_alert");
}

/*
	Name: coveridleupdate
	Namespace: aiutility
	Checksum: 0xD14F6DDA
	Offset: 0x2E88
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private coveridleupdate(entity)
{
	if(!entity asmistransitionrunning())
	{
		releaseclaimnode(entity);
	}
}

/*
	Name: coveridleterminate
	Namespace: aiutility
	Checksum: 0xA49719AB
	Offset: 0x2ED0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private coveridleterminate(entity)
{
	releaseclaimnode(entity);
	cleanupcovermode(entity);
}

/*
	Name: isflankedbyenemyatcover
	Namespace: aiutility
	Checksum: 0x850BCAF
	Offset: 0x2F18
	Size: 0x6E
	Parameters: 1
	Flags: Linked, Private
*/
function private isflankedbyenemyatcover(entity)
{
	return canbeflanked(entity) && entity isatcovernodestrict() && entity isflankedatcovernode() && !entity haspath();
}

/*
	Name: canbeflankedservice
	Namespace: aiutility
	Checksum: 0x89EA2A35
	Offset: 0x2F90
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private canbeflankedservice(entity)
{
	setcanbeflanked(entity, 1);
}

/*
	Name: coverflankedinitialize
	Namespace: aiutility
	Checksum: 0x9D203612
	Offset: 0x2FC0
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
function private coverflankedinitialize(entity)
{
	if(isdefined(entity.enemy))
	{
		entity getperfectinfo(entity.enemy);
		entity pathmode("move delayed", 0, 2);
	}
	setcanbeflanked(entity, 0);
	cleanupcovermode(entity);
	keepclaimnode(entity);
	entity setblackboardattribute("_desired_stance", "stand");
}

/*
	Name: coverflankedactionterminate
	Namespace: aiutility
	Checksum: 0x915ABDDC
	Offset: 0x3098
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private coverflankedactionterminate(entity)
{
	entity.newenemyreaction = 0;
	releaseclaimnode(entity);
}

/*
	Name: isatcrouchnode
	Namespace: aiutility
	Checksum: 0x53412A77
	Offset: 0x30D0
	Size: 0x120
	Parameters: 1
	Flags: Linked
*/
function isatcrouchnode(entity)
{
	if(isdefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path"))
	{
		if(distancesquared(entity.origin, entity.node.origin) <= (24 * 24))
		{
			return !isstanceallowedatnode("stand", entity.node) && isstanceallowedatnode("crouch", entity.node);
		}
	}
	return 0;
}

/*
	Name: isatcoverstrictcondition
	Namespace: aiutility
	Checksum: 0x8E7BD0ED
	Offset: 0x31F8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function isatcoverstrictcondition(entity)
{
	return entity isatcovernodestrict() && !entity haspath();
}

/*
	Name: isatcovermodeover
	Namespace: aiutility
	Checksum: 0xEFCC9CD5
	Offset: 0x3240
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function isatcovermodeover(entity)
{
	covermode = entity getblackboardattribute("_cover_mode");
	return covermode == "cover_over";
}

/*
	Name: isatcovermodenone
	Namespace: aiutility
	Checksum: 0x1D07DA3C
	Offset: 0x3290
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function isatcovermodenone(entity)
{
	covermode = entity getblackboardattribute("_cover_mode");
	return covermode == "cover_mode_none";
}

/*
	Name: isexposedatcovercondition
	Namespace: aiutility
	Checksum: 0x170CD7E8
	Offset: 0x32E0
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function isexposedatcovercondition(entity)
{
	return entity isatcovernodestrict() && !entity shouldusecovernode();
}

/*
	Name: shouldcoveridleonly
	Namespace: aiutility
	Checksum: 0x8CEA5918
	Offset: 0x3328
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function shouldcoveridleonly(entity)
{
	if(entity ai::get_behavior_attribute("coverIdleOnly"))
	{
		return true;
	}
	if(isdefined(entity.node.script_onlyidle) && entity.node.script_onlyidle)
	{
		return true;
	}
	return false;
}

/*
	Name: issuppressedatcovercondition
	Namespace: aiutility
	Checksum: 0x82F55732
	Offset: 0x33A0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function issuppressedatcovercondition(entity)
{
	return entity.suppressionmeter > entity.suppressionthreshold;
}

/*
	Name: keepclaimednodeandchoosecoverdirection
	Namespace: aiutility
	Checksum: 0xFED67BF5
	Offset: 0x33D0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function keepclaimednodeandchoosecoverdirection(entity)
{
	keepclaimnode(entity);
	choosecoverdirection(entity);
}

/*
	Name: resetcoverparameters
	Namespace: aiutility
	Checksum: 0x669CA2BD
	Offset: 0x3418
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function resetcoverparameters(entity)
{
	choosefrontcoverdirection(entity);
	cleanupcovermode(entity);
	clearcovershootstarttime(entity);
}

/*
	Name: choosecoverdirection
	Namespace: aiutility
	Checksum: 0xC78F5804
	Offset: 0x3478
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function choosecoverdirection(entity, stepout)
{
	if(!isdefined(entity.node))
	{
		return;
	}
	coverdirection = entity getblackboardattribute("_cover_direction");
	entity setblackboardattribute("_previous_cover_direction", coverdirection);
	entity setblackboardattribute("_cover_direction", calculatecoverdirection(entity, stepout));
}

/*
	Name: calculatecoverdirection
	Namespace: aiutility
	Checksum: 0x95885EC5
	Offset: 0x3520
	Size: 0x452
	Parameters: 2
	Flags: Linked
*/
function calculatecoverdirection(entity, stepout)
{
	if(isdefined(entity.treatallcoversasgeneric))
	{
		if(!isdefined(stepout))
		{
			stepout = 0;
		}
		coverdirection = "cover_front_direction";
		if(entity.node.type == #"cover left")
		{
			if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4 || math::cointoss() || stepout)
			{
				coverdirection = "cover_left_direction";
			}
		}
		else
		{
			if(entity.node.type == #"cover right")
			{
				if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4 || math::cointoss() || stepout)
				{
					coverdirection = "cover_right_direction";
				}
			}
			else if(entity.node.type == #"cover pillar")
			{
				if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024)
				{
					return "cover_right_direction";
				}
				if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048)
				{
					return "cover_left_direction";
				}
				coverdirection = "cover_left_direction";
				if(isdefined(entity.enemy))
				{
					yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
					aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
					legalrightdirectionyaw = yawtoenemyposition >= (aimlimitsfordirectionright[#"aim_right"] - 10) && yawtoenemyposition <= 0;
					if(legalrightdirectionyaw)
					{
						coverdirection = "cover_right_direction";
					}
				}
			}
		}
		return coverdirection;
	}
	coverdirection = "cover_front_direction";
	if(entity.node.type == #"cover pillar")
	{
		if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 1024) == 1024)
		{
			return "cover_right_direction";
		}
		if(isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 2048) == 2048)
		{
			return "cover_left_direction";
		}
		coverdirection = "cover_left_direction";
		if(isdefined(entity.enemy))
		{
			yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
			aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
			legalrightdirectionyaw = yawtoenemyposition >= (aimlimitsfordirectionright[#"aim_right"] - 10) && yawtoenemyposition <= 0;
			if(legalrightdirectionyaw)
			{
				coverdirection = "cover_right_direction";
			}
		}
	}
	return coverdirection;
}

/*
	Name: clearcovershootstarttime
	Namespace: aiutility
	Checksum: 0x496C3D5F
	Offset: 0x3980
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function clearcovershootstarttime(entity)
{
	entity.covershootstarttime = undefined;
}

/*
	Name: setcovershootstarttime
	Namespace: aiutility
	Checksum: 0x30A72460
	Offset: 0x39A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function setcovershootstarttime(entity)
{
	entity.covershootstarttime = gettime();
}

/*
	Name: canbeflanked
	Namespace: aiutility
	Checksum: 0x11CC409A
	Offset: 0x39C8
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function canbeflanked(entity)
{
	return isdefined(entity.canbeflanked) && entity.canbeflanked;
}

/*
	Name: setcanbeflanked
	Namespace: aiutility
	Checksum: 0x9E87794A
	Offset: 0x39F8
	Size: 0x22
	Parameters: 2
	Flags: Linked
*/
function setcanbeflanked(entity, canbeflanked)
{
	entity.canbeflanked = canbeflanked;
}

/*
	Name: cleanupcovermode
	Namespace: aiutility
	Checksum: 0xE4FF5DD0
	Offset: 0x3A28
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function cleanupcovermode(entity)
{
	if(btapi_isatcovercondition(entity))
	{
		covermode = entity getblackboardattribute("_cover_mode");
		entity setblackboardattribute("_previous_cover_mode", covermode);
		entity setblackboardattribute("_cover_mode", "cover_mode_none");
	}
	else
	{
		entity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
		entity setblackboardattribute("_cover_mode", "cover_mode_none");
	}
}

