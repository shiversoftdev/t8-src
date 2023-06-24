// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace turret;

/*
	Name: __init__system__
	Namespace: turret
	Checksum: 0x71AE8E1E
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"turret", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: turret
	Checksum: 0x9D769735
	Offset: 0x110
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

/*
	Name: field_toggle_lensflare
	Namespace: turret
	Checksum: 0x71BDAAE7
	Offset: 0x168
	Size: 0x116
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings))
	{
		return;
	}
	if(isdefined(self.turret_lensflare_id))
	{
		deletefx(localclientnum, self.turret_lensflare_id);
		self.turret_lensflare_id = undefined;
	}
	if(newval)
	{
		if(isdefined(settings.lensflare_fx) && isdefined(settings.lensflare_tag))
		{
			self.turret_lensflare_id = util::playfxontag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
		}
	}
}

