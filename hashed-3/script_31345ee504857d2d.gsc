// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace aiinteractables;

/*
	Name: __init__system__
	Namespace: aiinteractables
	Checksum: 0x910E3036
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"ai_interactables", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: aiinteractables
	Checksum: 0x13A6171D
	Offset: 0xE8
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		assert(isscriptfunctionptr(&function_64d25a18));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57181cf80bd4059f", &function_64d25a18);
	/#
		assert(isscriptfunctionptr(&function_64d25a18));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_57181cf80bd4059f", &function_64d25a18);
	/#
		assert(isscriptfunctionptr(&function_b4bc7751));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ef372b4649a577e", &function_b4bc7751);
	thread function_2f0f1b62();
}

/*
	Name: function_2f0f1b62
	Namespace: aiinteractables
	Checksum: 0xE80EDDCC
	Offset: 0x240
	Size: 0x118
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2f0f1b62()
{
	nodes = getallnodes();
	foreach(node in nodes)
	{
		if(isdefined(node.var_514e7397) && node.var_514e7397 && isdefined(node.target))
		{
			if(isdefined(node.var_71c87324) && node.var_71c87324)
			{
				continue;
			}
			var_54d06303 = struct::get(node.target);
			if(isdefined(var_54d06303))
			{
				var_54d06303 scene::init();
			}
		}
	}
}

/*
	Name: function_64d25a18
	Namespace: aiinteractables
	Checksum: 0x28AAD2E1
	Offset: 0x360
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_64d25a18(entity)
{
	if(entity.archetype !== #"human")
	{
		return false;
	}
	if(!isdefined(entity.node))
	{
		return false;
	}
	if(!iscovernode(entity.node))
	{
		return false;
	}
	if(!entity isatcovernode())
	{
		return false;
	}
	if(!(isdefined(entity.node.var_514e7397) && entity.node.var_514e7397))
	{
		return false;
	}
	if(isdefined(entity.node.var_31c05612))
	{
		return false;
	}
	return true;
}

/*
	Name: function_b4bc7751
	Namespace: aiinteractables
	Checksum: 0x18573AE
	Offset: 0x438
	Size: 0x160
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b4bc7751(entity)
{
	/#
		assert(!(isdefined(entity.node.var_31c05612) && entity.node.var_31c05612));
	#/
	if(isdefined(entity.node.target))
	{
		entity pathmode("move delayed", 8);
		entity.node.var_31c05612 = 1;
		var_54d06303 = struct::get(entity.node.target);
		var_54d06303 scene::play(entity);
		var_54d06303 notify(#"hash_4d2293524fe1c94c", {#hash_32684dfb:entity});
		if(isalive(entity))
		{
			entity notify(#"hash_4d2293524fe1c94c", {#hash_c17a3b30:entity.node, #hash_bad0e17c:var_54d06303});
		}
	}
}

