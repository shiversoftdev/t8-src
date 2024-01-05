// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace item_supply_drop;

/*
	Name: __init__system__
	Namespace: item_supply_drop
	Checksum: 0xF4166A04
	Offset: 0x138
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"item_supply_drop", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: item_supply_drop
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
	clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
}

/*
	Name: supply_drop_parachute
	Namespace: item_supply_drop
	Checksum: 0xC42D3E62
	Offset: 0x278
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function supply_drop_parachute(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self playrenderoverridebundle(#"hash_336cece53ae2342f");
	}
	else
	{
		self stoprenderoverridebundle(#"hash_336cece53ae2342f");
	}
}

/*
	Name: supply_drop_fx
	Namespace: item_supply_drop
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
			fxent.supplydropfx = function_239993de(localclientnum, "smoke/fx8_column_md_green", fxent, "tag_origin");
		}
		else
		{
			fxent.supplydropfx = function_239993de(localclientnum, "smoke/fx8_column_md_red", fxent, "tag_origin");
		}
		self.fxent = fxent;
		playfx(localclientnum, "killstreaks/fx8_agr_drop_box_wz", self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		playsound(localclientnum, #"hash_49b7275f4ddde9b8", self.origin);
		self.var_3a55f5cf = 1;
	}
	else if(isdefined(self.fxent))
	{
		if(isdefined(self.fxent.supplydropfx))
		{
			stopfx(localclientnum, self.fxent.supplydropfx);
		}
		self.fxent delete();
	}
}

