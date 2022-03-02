// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_weap_thundergun;

/*
	Name: function_89f2df9
	Namespace: zm_weap_thundergun
	Checksum: 0xF7367632
	Offset: 0xD0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_weap_thundergun", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_thundergun
	Checksum: 0x327DC83
	Offset: 0x120
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_637ebcc2 = getweapon(#"thundergun");
	level.var_2147152b = getweapon(#"thundergun_upgraded");
	clientfield::register("actor", "" + #"hash_7549405bcfcbcfb", 24000, 1, "counter", &function_5059c81b, 0, 0);
}

/*
	Name: __main__
	Namespace: zm_weap_thundergun
	Checksum: 0x4F7ABF5C
	Offset: 0x1D8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	callback::function_f77ced93(&function_f77ced93);
}

/*
	Name: function_f77ced93
	Namespace: zm_weap_thundergun
	Checksum: 0x78A470B5
	Offset: 0x208
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(s_params)
{
	w_new_weapon = s_params.weapon;
	w_old_weapon = s_params.last_weapon;
	if(w_new_weapon == level.var_637ebcc2 || w_new_weapon == level.var_2147152b)
	{
		/#
			iprintlnbold("");
		#/
	}
}

/*
	Name: thundergun_fx_fire
	Namespace: zm_weap_thundergun
	Checksum: 0xAF21D4D1
	Offset: 0x290
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function thundergun_fx_fire(localclientnum)
{
	playsound(localclientnum, #"wpn_thunder_breath", (0, 0, 0));
}

/*
	Name: function_5059c81b
	Namespace: zm_weap_thundergun
	Checksum: 0x536A22E2
	Offset: 0x2D0
	Size: 0xAC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_5059c81b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));
		if(!isdefined(v_fx_origin))
		{
			v_fx_origin = self.origin;
		}
		playfx(localclientnum, "zm_weapons/fx8_ww_thundergun_impact_zombie", v_fx_origin);
	}
}

