// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_db48768d;

/*
	Name: function_89f2df9
	Namespace: namespace_db48768d
	Checksum: 0x603F80CF
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2d11bcef9355cc81", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_db48768d
	Checksum: 0x31C3EC71
	Offset: 0x2D0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	level.var_13a6af33 = &function_619bb271;
}

/*
	Name: init_clientfields
	Namespace: namespace_db48768d
	Checksum: 0x1773BA7C
	Offset: 0x308
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "ship_lights_control", 24000, 1, "int", &ship_lights_control, 0, 0);
	clientfield::register("world", "lighthouse_lights_control", 24000, 1, "int", &lighthouse_lights_control, 0, 0);
	clientfield::register("world", "facility_lights_control", 24000, 1, "int", &facility_lights_control, 0, 0);
	clientfield::register("world", "infusion_lights_hot", 24000, 1, "int", &infusion_lights_hot, 0, 0);
	clientfield::register("world", "infusion_lights_cold", 24000, 1, "int", &infusion_lights_cold, 0, 0);
	clientfield::register("world", "orange_deactivate_radiant_exploders_client", 24000, 1, "counter", &orange_deactivate_radiant_exploders_client, 0, 0);
}

/*
	Name: ship_lights_control
	Namespace: namespace_db48768d
	Checksum: 0x56AF7C8F
	Offset: 0x4C8
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function ship_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		exploder::exploder("fxexp_script_ship_power");
		exploder::exploder("fx_power_on2");
	}
	else if(newval == 0)
	{
		exploder::stop_exploder("fxexp_script_ship_power");
		exploder::stop_exploder("fx_power_on2");
	}
}

/*
	Name: lighthouse_lights_control
	Namespace: namespace_db48768d
	Checksum: 0xB984ED03
	Offset: 0x590
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function lighthouse_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		exploder::exploder("fxexp_script_lighthouse_interior_power");
		exploder::exploder("fxexp_script_docks_power");
		exploder::exploder("fx_power_on1");
	}
	else if(newval == 0)
	{
		exploder::stop_exploder("fxexp_script_lighthouse_interior_power");
		exploder::exploder("fxexp_script_docks_power");
		exploder::stop_exploder("fx_power_on1");
	}
}

/*
	Name: facility_lights_control
	Namespace: namespace_db48768d
	Checksum: 0x13A987B0
	Offset: 0x688
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function facility_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		exploder::exploder("fxexp_script_facility_power_on");
		exploder::exploder("fxexp_script_facility_power_on_fx");
		exploder::exploder("fxexp_script_infusion_default");
		exploder::exploder("fxexp_script_facility_power_off");
	}
	else if(newval == 0)
	{
		exploder::stop_exploder("fxexp_script_facility_power_on");
		exploder::stop_exploder("fxexp_script_facility_power_on_fx");
		exploder::stop_exploder("fxexp_script_infusion_default");
		exploder::stop_exploder("fxexp_script_facility_power_off");
	}
}

/*
	Name: infusion_lights_hot
	Namespace: namespace_db48768d
	Checksum: 0xA65C3344
	Offset: 0x7B0
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function infusion_lights_hot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		exploder::stop_exploder("fxexp_script_infusion_default");
		exploder::exploder("fxexp_script_infusion_hot");
	}
	else if(newval == 0)
	{
		exploder::stop_exploder("fxexp_script_infusion_hot");
		exploder::exploder("fxexp_script_infusion_default");
	}
}

/*
	Name: infusion_lights_cold
	Namespace: namespace_db48768d
	Checksum: 0xA66367E5
	Offset: 0x878
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function infusion_lights_cold(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		exploder::stop_exploder("fxexp_script_infusion_default");
		exploder::exploder("fxexp_script_infusion_cold");
	}
	else if(newval == 0)
	{
		exploder::stop_exploder("fxexp_script_infusion_cold");
		exploder::exploder("fxexp_script_infusion_default");
	}
}

/*
	Name: function_619bb271
	Namespace: namespace_db48768d
	Checksum: 0xE962BB02
	Offset: 0x940
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_619bb271(string)
{
	if(!isdefined(level.var_989f7c7c))
	{
		level.var_989f7c7c = [];
	}
	array::add(level.var_989f7c7c, string, 0);
}

/*
	Name: orange_deactivate_radiant_exploders_client
	Namespace: namespace_db48768d
	Checksum: 0x4B50B6BB
	Offset: 0x998
	Size: 0xE2
	Parameters: 7
	Flags: Linked
*/
function orange_deactivate_radiant_exploders_client(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(level.var_989f7c7c))
		{
			foreach(exploder_id in level.var_989f7c7c)
			{
				exploder::kill_exploder(exploder_id);
				wait(0.3);
			}
			level.var_989f7c7c = undefined;
		}
	}
}

