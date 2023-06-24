// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2f1f2c10d854244;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace localheal;

/*
	Name: __init__system__
	Namespace: localheal
	Checksum: 0xF6257D98
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"localheal", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: localheal
	Checksum: 0xC6CB8B20
	Offset: 0x130
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function init_shared(localclientnum)
{
	clientfield::register("clientuimodel", "hudItems.localHealActive", 1, 1, "int", undefined, 0, 0);
	clientfield::register("allplayers", "tak_5_heal", 1, 1, "counter", &function_981ad238, 0, 0);
}

/*
	Name: function_eefb5c87
	Namespace: localheal
	Checksum: 0xD2A802C0
	Offset: 0x1C8
	Size: 0x20A
	Parameters: 7
	Flags: None
*/
function function_eefb5c87(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	ent = getentbynum(localclientnum, newval);
	if(newval != oldval || (isdefined(ent) && (!(isdefined(ent.var_4dffc910) && ent.var_4dffc910))))
	{
		robname = #"hash_aa2ba3bf66e25d2";
		oldent = getentbynum(localclientnum, oldval);
		if(isdefined(oldent) && (isdefined(oldent.var_4dffc910) && oldent.var_4dffc910))
		{
			oldent function_577be059(0);
			oldent stoprenderoverridebundle(robname);
			oldent.var_4dffc910 = undefined;
		}
		entnum = self getentitynumber();
		if(newval != entnum)
		{
			if(isdefined(ent) && (!(isdefined(ent.var_4dffc910) && ent.var_4dffc910)))
			{
				ent function_577be059(1);
				ent playrenderoverridebundle(robname);
				ent function_78233d29(robname, "", "Alpha", 1);
				ent.var_4dffc910 = 1;
			}
		}
	}
}

/*
	Name: function_981ad238
	Namespace: localheal
	Checksum: 0x1A3E3FA9
	Offset: 0x3E0
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_981ad238(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval != oldval)
	{
		if(self function_21c0fa55())
		{
			postfx::playpostfxbundle(#"hash_2ac1d3d8a26022e1");
		}
	}
}

