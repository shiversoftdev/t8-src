// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_35baff41;

/*
	Name: function_89f2df9
	Namespace: namespace_35baff41
	Checksum: 0x4789B872
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_62ed3e0f56513ba7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_35baff41
	Checksum: 0xDEAAE0EA
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_2c07cbb8e8fd2060", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_35baff41
	Checksum: 0xF4975E6E
	Offset: 0x160
	Size: 0x9C
	Parameters: 1
	Flags: Private
*/
function private function_d1de6a85(var_6ad4e7c6)
{
	fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
	/#
		assert(isdefined(fasttravel_triggers));
	#/
	namespace_b22c99a5::function_2976fa44(fasttravel_triggers.size);
	namespace_b22c99a5::function_dace284(0);
	level thread function_25f146be();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_35baff41
	Checksum: 0x799E856F
	Offset: 0x208
	Size: 0xA4
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	if(!round_reset)
	{
		fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
		/#
			assert(isdefined(fasttravel_triggers));
		#/
		if(function_c83a4a77() < fasttravel_triggers.size)
		{
			zm_trial::fail(#"hash_6d65e724625758f1");
		}
	}
}

/*
	Name: function_c83a4a77
	Namespace: namespace_35baff41
	Checksum: 0xBD0BF9B2
	Offset: 0x2B8
	Size: 0xF2
	Parameters: 0
	Flags: Private
*/
function private function_c83a4a77()
{
	fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
	/#
		assert(isdefined(fasttravel_triggers));
	#/
	count = 0;
	foreach(trigger in fasttravel_triggers)
	{
		if(isdefined(trigger.unitrigger_stub.used) && trigger.unitrigger_stub.used)
		{
			count++;
		}
	}
	return count;
}

/*
	Name: function_25f146be
	Namespace: namespace_35baff41
	Checksum: 0x49F08613
	Offset: 0x3B8
	Size: 0x5E
	Parameters: 0
	Flags: Private
*/
function private function_25f146be()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		namespace_b22c99a5::function_dace284(function_c83a4a77());
		waitframe(1);
	}
}

