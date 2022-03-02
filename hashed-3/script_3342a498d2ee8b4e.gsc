// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_47fb62300ac0bd60;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_a1ba448e;

/*
	Name: function_89f2df9
	Namespace: namespace_a1ba448e
	Checksum: 0x6493BCB7
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_41d363b76a18b416", &__init__, undefined, #"hash_1222ebda4b02b01b");
}

/*
	Name: __init__
	Namespace: namespace_a1ba448e
	Checksum: 0xB51E165E
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_4e05591e7665f140", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_a1ba448e
	Checksum: 0x3152780D
	Offset: 0x120
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_453c77a41df1963c", &function_27709af9);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_a1ba448e
	Checksum: 0xA1791132
	Offset: 0x1A0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_512902807bf52e0")
	{
		if(self character_unlock::function_f0406288(#"hash_4e05591e7665f140"))
		{
			if(self stats::function_441050ca(#"hash_41f134c3e727d877") >= 20)
			{
				self character_unlock::function_c8beca5e(#"hash_4e05591e7665f140", #"hash_27023afb3f91aba5", 1);
			}
		}
	}
}

/*
	Name: function_27709af9
	Namespace: namespace_a1ba448e
	Checksum: 0x8E559929
	Offset: 0x270
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_27709af9()
{
	if(self character_unlock::function_f0406288(#"hash_4e05591e7665f140"))
	{
		if(self stats::function_441050ca(#"hash_41f134c3e727d877") >= 20)
		{
			self character_unlock::function_c8beca5e(#"hash_4e05591e7665f140", #"hash_27023afb3f91aba5", 1);
		}
	}
}

