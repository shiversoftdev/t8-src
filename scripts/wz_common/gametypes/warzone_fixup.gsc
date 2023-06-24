// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;

#namespace warzone_fixup;

/*
	Name: __init__
	Namespace: warzone_fixup
	Checksum: 0x3C731CFD
	Offset: 0x70
	Size: 0x124
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	waitframe(1);
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	switch(maxteamplayers)
	{
		case 1:
		{
			function_d0dc6619();
			break;
		}
		case 2:
		{
			function_f16631fc();
			break;
		}
		case 4:
		default:
		{
			function_91d1fd09();
			break;
		}
	}
	function_4305a789();
	function_c94723bd();
}

/*
	Name: function_4305a789
	Namespace: warzone_fixup
	Checksum: 0x51C26BBE
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4305a789()
{
	function_9b8d4d02(1);
}

/*
	Name: function_c94723bd
	Namespace: warzone_fixup
	Checksum: 0xFD2D877E
	Offset: 0x1C8
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c94723bd()
{
	var_d1d7eefb = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0);
	if(!var_d1d7eefb)
	{
		function_9b8d4d02();
	}
	if(!(isdefined(getgametypesetting(#"hash_1d02e28ba907a343")) ? getgametypesetting(#"hash_1d02e28ba907a343") : 0))
	{
		namespace_b0722f43::function_96ff7b88(#"hash_3c5ee4ad37d65f4e");
		namespace_b0722f43::remove_item(#"hash_3c5ee4ad37d65f4e");
	}
}

/*
	Name: function_9b8d4d02
	Namespace: warzone_fixup
	Checksum: 0xAF9739EE
	Offset: 0x2D8
	Size: 0xF8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9b8d4d02(prematch = 0)
{
	var_3a1737b4 = getscriptbundles(#"hash_10587321f369e7f3");
	foreach(var_1461de43, var_28f8f6a9 in var_3a1737b4)
	{
		if(var_28f8f6a9.itemtype == #"quest")
		{
			if(prematch)
			{
				namespace_b0722f43::function_96ff7b88(var_1461de43);
				continue;
			}
			namespace_b0722f43::remove_item(var_1461de43);
		}
	}
}

/*
	Name: function_d0dc6619
	Namespace: warzone_fixup
	Checksum: 0x7827483D
	Offset: 0x3D8
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d0dc6619()
{
	namespace_b0722f43::function_96ff7b88(#"hash_35f5430256d9c158");
	namespace_b0722f43::remove_item(#"hash_35f5430256d9c158");
}

/*
	Name: function_f16631fc
	Namespace: warzone_fixup
	Checksum: 0x80F724D1
	Offset: 0x428
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f16631fc()
{
}

/*
	Name: function_91d1fd09
	Namespace: warzone_fixup
	Checksum: 0x80F724D1
	Offset: 0x438
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_91d1fd09()
{
}

