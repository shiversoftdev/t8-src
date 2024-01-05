// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4351c7d054a77f2c;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace wz_highvaluetarget;

/*
	Name: __init__system__
	Namespace: wz_highvaluetarget
	Checksum: 0xA38CD217
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_highvaluetarget", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_highvaluetarget
	Checksum: 0x5C05C900
	Offset: 0x140
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"wzhighvaluetargets")) && getgametypesetting(#"wzhighvaluetargets")))
	{
		return;
	}
	clientfield::register("allplayers", "ishighvaluetarget", 16000, 1, "int", &target_changed, 0, 0);
	level.var_45c1873e = [];
	for(i = 0; i < 8; i++)
	{
		level.var_45c1873e[i][#"indicator"] = spectrerisingindicator::register("SpectreRisingIndicator_" + i);
		level.var_45c1873e[i][#"clientnum"] = -1;
	}
}

/*
	Name: target_changed
	Namespace: wz_highvaluetarget
	Checksum: 0xDDA1A9A7
	Offset: 0x280
	Size: 0x1AC
	Parameters: 7
	Flags: Linked
*/
function target_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	clientnum = self getentitynumber();
	var_dd4e1d40 = getuimodel(getglobaluimodel(), "Clients");
	clientmodel = getuimodel(var_dd4e1d40, clientnum);
	if(isdefined(clientmodel))
	{
		setuimodelvalue(createuimodel(clientmodel, "isSpectreRisingTarget"), newval == 1);
	}
	/#
		if(getdvarint(#"hash_31365963abce3d7b", 0))
		{
			if(newval)
			{
				if(!self function_d2503806(#"hash_4368c406e6a21060"))
				{
					self playrenderoverridebundle(#"hash_4368c406e6a21060");
				}
			}
			else if(self function_d2503806(#"hash_4368c406e6a21060"))
			{
				self stoprenderoverridebundle(#"hash_4368c406e6a21060");
			}
		}
	#/
}

