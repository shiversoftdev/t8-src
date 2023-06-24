// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using script_4bf952f6ba31bb17;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_f0e0a17c;

/*
	Name: __init__system__
	Namespace: namespace_f0e0a17c
	Checksum: 0x1CD8FEC3
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"swat", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_f0e0a17c
	Checksum: 0x647D64FC
	Offset: 0x120
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_f0e0a17c
	Checksum: 0x49209E03
	Offset: 0x140
	Size: 0x244
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
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
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3861dc092e2bcf88", &function_994477c0);
	/#
		assert(isscriptfunctionptr(&function_fb9f1f3b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48334fe2b83169f2", &function_fb9f1f3b);
	animationstatenetwork::registeranimationmocomp("mocomp_swat_team_pain", &function_6edff1e1, undefined, &function_8acd749d);
}

/*
	Name: function_6edff1e1
	Namespace: namespace_f0e0a17c
	Checksum: 0x2B63B8D3
	Offset: 0x390
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
	Namespace: namespace_f0e0a17c
	Checksum: 0xF7F62CD2
	Offset: 0x440
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
	Name: function_e3151f98
	Namespace: namespace_f0e0a17c
	Checksum: 0x1E134A79
	Offset: 0x4A8
	Size: 0x30
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e3151f98(entity)
{
	if(entity.var_9fde8624 === #"hash_65b3e15ded9326be")
	{
		return true;
	}
	return false;
}

/*
	Name: function_e5f59cf0
	Namespace: namespace_f0e0a17c
	Checksum: 0xAAA95774
	Offset: 0x4E0
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
	Namespace: namespace_f0e0a17c
	Checksum: 0xA574F710
	Offset: 0x510
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3c677dcd(entity)
{
	if(isdefined(entity.enemy))
	{
		if(util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(90)))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_994477c0
	Namespace: namespace_f0e0a17c
	Checksum: 0x997FCD0F
	Offset: 0x590
	Size: 0xE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_994477c0(entity)
{
	return false;
}

/*
	Name: function_fb9f1f3b
	Namespace: namespace_f0e0a17c
	Checksum: 0x3C96C04A
	Offset: 0x5A8
	Size: 0xE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fb9f1f3b(entity)
{
	return false;
}

