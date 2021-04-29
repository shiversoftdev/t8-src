// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace player_role;

/*
	Name: function_89f2df9
	Namespace: player_role
	Checksum: 0x3D830C51
	Offset: 0x78
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"player_role", undefined, &__postload_init__, undefined);
}

/*
	Name: __postload_init__
	Namespace: player_role
	Checksum: 0x80F724D1
	Offset: 0xB8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __postload_init__()
{
}

/*
	Name: is_valid
	Namespace: player_role
	Checksum: 0xBD4B8EDB
	Offset: 0xC8
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function is_valid(index)
{
	if(!isdefined(index))
	{
		return 0;
	}
	/#
		if(getdvarint(#"allowdebugcharacter", 0) == 1)
		{
			return index >= 0 && index < getplayerroletemplatecount(currentsessionmode());
		}
	#/
	return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

