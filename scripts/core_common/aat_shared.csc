// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\array_shared.csc;

#namespace aat;

/*
	Name: __init__system__
	Namespace: aat
	Checksum: 0x28894D6
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"aat", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: aat
	Checksum: 0xCE9ADCF2
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	level.aat_initializing = 1;
	level.aat_default_info_name = "none";
	level.aat_default_info_icon = "blacktransparent";
	level.aat = [];
	register("none", level.aat_default_info_name, level.aat_default_info_icon);
	callback::on_finalize_initialization(&finalize_clientfields);
}

/*
	Name: register
	Namespace: aat
	Checksum: 0x276A6428
	Offset: 0x1B0
	Size: 0x16A
	Parameters: 3
	Flags: Linked
*/
function register(name, localized_string, icon)
{
	/#
		assert(isdefined(level.aat_initializing) && level.aat_initializing, "");
	#/
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert(!isdefined(level.aat[name]), ("" + name) + "");
	#/
	/#
		assert(isdefined(localized_string), "");
	#/
	/#
		assert(isdefined(icon), "");
	#/
	level.aat[name] = spawnstruct();
	level.aat[name].name = name;
	level.aat[name].localized_string = localized_string;
	level.aat[name].icon = icon;
}

/*
	Name: aat_hud_manager
	Namespace: aat
	Checksum: 0x658FB951
	Offset: 0x328
	Size: 0x78
	Parameters: 7
	Flags: Linked
*/
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.update_aat_hud))
	{
		[[level.update_aat_hud]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
}

/*
	Name: finalize_clientfields
	Namespace: aat
	Checksum: 0xD5C5129F
	Offset: 0x3A8
	Size: 0x18A
	Parameters: 0
	Flags: Linked
*/
function finalize_clientfields()
{
	/#
		println("");
	#/
	if(level.aat.size > 1)
	{
		array::alphabetize(level.aat);
		i = 0;
		foreach(aat in level.aat)
		{
			aat.n_index = i;
			i++;
			/#
				println("" + aat.name);
			#/
		}
		n_bits = getminbitcountfornum(level.aat.size - 1);
		clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
	}
	level.aat_initializing = 0;
}

/*
	Name: get_string
	Namespace: aat
	Checksum: 0xF1D75254
	Offset: 0x540
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function get_string(n_aat_index)
{
	foreach(aat in level.aat)
	{
		if(aat.n_index == n_aat_index)
		{
			return aat.localized_string;
		}
	}
	return level.aat_default_info_name;
}

/*
	Name: get_icon
	Namespace: aat
	Checksum: 0xBF9360A3
	Offset: 0x5E8
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function get_icon(n_aat_index)
{
	foreach(aat in level.aat)
	{
		if(aat.n_index == n_aat_index)
		{
			return aat.icon;
		}
	}
	return level.aat_default_info_icon;
}

