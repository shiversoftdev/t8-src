// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_509a75d1;

/*
	Name: function_89f2df9
	Namespace: namespace_509a75d1
	Checksum: 0x433FB3FC
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6cba02956ebaa3bc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_509a75d1
	Checksum: 0xD5987F35
	Offset: 0xC0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		if(getdvarint(#"hash_79f58c97fc43e423", 0))
		{
			callback::on_localplayer_spawned(&function_774b42ac);
		}
	#/
}

/*
	Name: function_774b42ac
	Namespace: namespace_509a75d1
	Checksum: 0x9C5070EC
	Offset: 0x118
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function function_774b42ac()
{
	/#
		localclientnum = self getlocalclientnumber();
		if(!isdefined(localclientnum))
		{
			return;
		}
		while(true)
		{
			a_ents = getentarray(localclientnum);
			debug2dtext((5, 1035, 0), "" + a_ents.size, (1, 1, 0), 1, (0, 0, 0), 0.5, 1, 30);
			waitframe(30);
		}
	#/
}

