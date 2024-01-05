// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace gadget_health_regen;

/*
	Name: __init__system__
	Namespace: gadget_health_regen
	Checksum: 0x803579DA
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_health_regen
	Checksum: 0x3DAF790B
	Offset: 0x148
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("toplayer", "healthregen", 1, 1, "int", &function_31f57700, 0, 1);
	clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int", undefined, 0, 1);
	clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int", undefined, 0, 1);
}

/*
	Name: function_31f57700
	Namespace: gadget_health_regen
	Checksum: 0x9CF9B43
	Offset: 0x210
	Size: 0x144
	Parameters: 7
	Flags: None
*/
function function_31f57700(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame())
	{
		if(newval)
		{
			if(!(isdefined(self.var_b072e263) && self.var_b072e263))
			{
				self.var_e5996046 = self playloopsound(#"hash_390aa7d4252c46b5", 0.25);
				self.var_b072e263 = 1;
				self postfx::playpostfxbundle("pstfx_health_regen");
			}
		}
		else if(isdefined(self.var_b072e263) && self.var_b072e263)
		{
			self stoploopsound(self.var_e5996046);
			self.var_b072e263 = undefined;
			self postfx::exitpostfxbundle("pstfx_health_regen");
		}
	}
}

