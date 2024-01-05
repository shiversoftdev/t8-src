// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_firing_range.csc;
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace character_unlock_seraph;

/*
	Name: __init__system__
	Namespace: character_unlock_seraph
	Checksum: 0xF20E662
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_seraph", &__init__, undefined, #"character_unlock_seraph_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_seraph
	Checksum: 0xB8E1148D
	Offset: 0xE8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"seraph_unlock", &function_2613aeec);
	callback::on_finalize_initialization(&on_finalize_initialization);
}

/*
	Name: on_finalize_initialization
	Namespace: character_unlock_seraph
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
	Namespace: character_unlock_seraph
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
		wz_firing_range::init_targets(#"hash_3af83a27a707345a");
		level thread function_211772b5();
	}
	else
	{
		level thread function_1e3aca52();
	}
}

/*
	Name: function_211772b5
	Namespace: character_unlock_seraph
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
	Namespace: character_unlock_seraph
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
	Namespace: character_unlock_seraph
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

