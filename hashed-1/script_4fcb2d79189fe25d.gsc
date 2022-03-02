// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_68264f587357ea51;
#using script_756c6b0e0e5bb886;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_2badec8b;

/*
	Name: function_89f2df9
	Namespace: namespace_2badec8b
	Checksum: 0xF20E662
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_39c6d37915dd631f", &__init__, undefined, #"hash_1f2b90c8b7f6a12e");
}

/*
	Name: __init__
	Namespace: namespace_2badec8b
	Checksum: 0xB8E1148D
	Offset: 0xE8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_d8437030e2d8dc1", &function_2613aeec);
	callback::on_finalize_initialization(&on_finalize_initialization);
}

/*
	Name: on_finalize_initialization
	Namespace: namespace_2badec8b
	Checksum: 0x4FD7AE92
	Offset: 0x148
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_finalize_initialization(localclientnum)
{
	waitframe(1);
	level function_75097bb5();
}

/*
	Name: function_2613aeec
	Namespace: namespace_2badec8b
	Checksum: 0x4EF5FBF
	Offset: 0x180
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		namespace_72c1550b::function_ea0556fc(#"hash_3af83a27a707345a");
		level thread function_211772b5();
	}
	else
	{
		level thread function_1e3aca52();
	}
}

/*
	Name: function_211772b5
	Namespace: namespace_2badec8b
	Checksum: 0xEF5DE87A
	Offset: 0x1F0
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_211772b5()
{
	item_world::function_4de3ca98();
	var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");
	if(isdefined(var_b2425612) && var_b2425612.size > 1)
	{
		var_65688262 = array::random(var_b2425612);
		arrayremovevalue(var_b2425612, var_65688262);
		foreach(box in var_b2425612)
		{
			if(isdefined(box))
			{
				setdynentenabled(box, 0);
			}
		}
	}
}

/*
	Name: function_1e3aca52
	Namespace: namespace_2badec8b
	Checksum: 0x18C13D14
	Offset: 0x300
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_1e3aca52()
{
	item_world::function_4de3ca98();
	level function_75097bb5();
}

/*
	Name: function_75097bb5
	Namespace: namespace_2badec8b
	Checksum: 0x51B0CE18
	Offset: 0x338
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_75097bb5()
{
	var_1c9468df = getdynent(#"hash_3af83a27a707345a");
	if(isdefined(var_1c9468df))
	{
		setdynentenabled(var_1c9468df, 0);
	}
	var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");
	if(isdefined(var_b2425612))
	{
		foreach(box in var_b2425612)
		{
			if(isdefined(box))
			{
				setdynentenabled(box, 0);
			}
		}
	}
}

