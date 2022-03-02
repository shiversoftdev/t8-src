// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_8f74625a;

/*
	Name: function_89f2df9
	Namespace: namespace_8f74625a
	Checksum: 0xF4166A04
	Offset: 0x138
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_c70352f852fda84", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: namespace_8f74625a
	Checksum: 0x3CA2D2AB
	Offset: 0x188
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
	clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &function_6567bf42, 0, 0);
}

/*
	Name: function_6567bf42
	Namespace: namespace_8f74625a
	Checksum: 0xC42D3E62
	Offset: 0x278
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_6567bf42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_336cece53ae2342f");
	}
	else
	{
		self function_5d482e78(#"hash_336cece53ae2342f");
	}
}

/*
	Name: supply_drop_fx
	Namespace: namespace_8f74625a
	Checksum: 0x24B46875
	Offset: 0x318
	Size: 0x26C
	Parameters: 7
	Flags: Linked
*/
function supply_drop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		fxent = spawn(localclientnum, self.origin, "script_model");
		fxent setmodel("tag_origin");
		fxent linkto(self);
		var_96514d8b = (isdefined(getgametypesetting(#"hash_2e25d475b271a700")) ? getgametypesetting(#"hash_2e25d475b271a700") : 0);
		if(var_96514d8b)
		{
			fxent.var_4a630a3f = function_239993de(localclientnum, "smoke/fx8_column_md_green", fxent, "tag_origin");
		}
		else
		{
			fxent.var_4a630a3f = function_239993de(localclientnum, "smoke/fx8_column_md_red", fxent, "tag_origin");
		}
		self.fxent = fxent;
		playfx(localclientnum, "killstreaks/fx8_agr_drop_box_wz", self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		playsound(localclientnum, #"hash_49b7275f4ddde9b8", self.origin);
		self.var_3a55f5cf = 1;
	}
	else if(isdefined(self.fxent))
	{
		if(isdefined(self.fxent.var_4a630a3f))
		{
			stopfx(localclientnum, self.fxent.var_4a630a3f);
		}
		self.fxent delete();
	}
}

