// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace planemortar;

/*
	Name: init_shared
	Namespace: planemortar
	Checksum: 0x1B6F82E7
	Offset: 0x128
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_6ea2bb2e))
	{
		level.var_6ea2bb2e = {};
		level.planemortarexhaustfx = "killstreaks/fx8_mortar_jet_thrusters";
		level.var_913789d7 = "killstreaks/fx8_mortar_jet_contrails";
		clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
	}
}

/*
	Name: planemortar_contrail
	Namespace: planemortar
	Checksum: 0x127DA5DD
	Offset: 0x1C0
	Size: 0xCA
	Parameters: 7
	Flags: None
*/
function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	util::waittill_dobj(localclientnum);
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx_engine_exhaust_back");
		self.fx = util::playfxontag(localclientnum, level.var_913789d7, self, "tag_body_animate");
	}
}

