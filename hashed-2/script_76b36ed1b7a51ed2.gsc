// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_79fbbb4d5723c197;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_6747c550;

/*
	Name: function_89f2df9
	Namespace: namespace_6747c550
	Checksum: 0x14F7B00D
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_23b05089013ba630", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6747c550
	Checksum: 0xBB6D8B9A
	Offset: 0x128
	Size: 0x150
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	clientfield::function_78175813("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, undefined, 0, 0);
	namespace_a6669267::function_c7c05a13();
	var_b9b9b499 = [];
	foreach(mapping in level.var_a16c38d9)
	{
		if(!isdefined(var_b9b9b499[mapping.var_cd35dfb2]))
		{
			var_b9b9b499[mapping.var_cd35dfb2] = 1;
			var_9cf9ba9 = "worlduimodel";
			if(isdefined(mapping.var_7f12f171))
			{
				var_9cf9ba9 = "clientuimodel";
			}
			clientfield::register(var_9cf9ba9, mapping.var_cd35dfb2, 1, mapping.numbits, "int", undefined, 0, 0);
		}
	}
}

