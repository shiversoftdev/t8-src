// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28212a1c4376c358;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace concertina_wire;

/*
	Name: init_shared
	Namespace: concertina_wire
	Checksum: 0x2DD80671
	Offset: 0x158
	Size: 0x1A4
	Parameters: 1
	Flags: None
*/
function init_shared(var_4b51853b)
{
	clientfield::register("scriptmover", "concertinaWire_placed", 1, 5, "float", &function_6873a657, 0, 0);
	clientfield::register("scriptmover", "concertinaWireDestroyed", 1, 1, "int", &function_8455c7c0, 0, 0);
	clientfield::register("scriptmover", "concertinaWireDroopyBits", 1, 3, "int", &function_3a927971, 0, 0);
	level.var_87226c31 = spawnstruct();
	level.var_87226c31.bundle = getscriptbundle(var_4b51853b);
	level.var_87226c31.var_3e7344ee = getweapon(#"eq_concertina_wire");
	level.var_87226c31.var_546a220c = "concertina_wire_objective_default";
	level.var_87226c31.var_925bbb2 = [];
	deployable::function_2e088f73(level.var_87226c31.var_3e7344ee, 1);
}

/*
	Name: function_34a7968c
	Namespace: concertina_wire
	Checksum: 0x23FA725B
	Offset: 0x308
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_34a7968c(localclientnum)
{
	self notify("c298d246402eaf6");
	self endon("c298d246402eaf6");
	self endon(#"death");
	player = function_5c10bd79(localclientnum);
	player waittill(#"death");
	self.var_ad9b20ac = undefined;
}

/*
	Name: function_8455c7c0
	Namespace: concertina_wire
	Checksum: 0x4CE3FC4F
	Offset: 0x388
	Size: 0x3C
	Parameters: 7
	Flags: None
*/
function function_8455c7c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_3a927971
	Namespace: concertina_wire
	Checksum: 0x8996E56F
	Offset: 0x3D0
	Size: 0x1AC
	Parameters: 7
	Flags: None
*/
function function_3a927971(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(1 == newval || 3 == newval)
	{
		self function_d309e55a("wire_10", 1);
		self function_d309e55a("wire_09", 1);
	}
	else
	{
		self function_d309e55a("wire_10", 0);
		self function_d309e55a("wire_09", 0);
	}
	if(2 == newval || 3 == newval)
	{
		self function_d309e55a("wire_02", 1);
		self function_d309e55a("wire_03", 1);
	}
	else
	{
		self function_d309e55a("wire_02", 0);
		self function_d309e55a("wire_03", 0);
	}
}

/*
	Name: function_6873a657
	Namespace: concertina_wire
	Checksum: 0x61772105
	Offset: 0x588
	Size: 0x20C
	Parameters: 7
	Flags: None
*/
function function_6873a657(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(level.var_87226c31) || !isdefined(level.var_87226c31.bundle) || !isdefined(level.var_87226c31.bundle.deployanim))
	{
		return;
	}
	self useanimtree("generic");
	var_f56117a2 = 1 - newval;
	if(bnewent || newval == 1)
	{
		self setanim(level.var_87226c31.bundle.deployanim, 1, var_f56117a2, 0);
	}
	if(bwastimejump)
	{
		var_e72a224a = self getanimtime(level.var_87226c31.bundle.deployanim);
		if(var_f56117a2 < var_e72a224a || bnewent)
		{
			self setanimtime(level.var_87226c31.bundle.deployanim, var_f56117a2);
		}
	}
	else
	{
		self setanimtime(level.var_87226c31.bundle.deployanim, var_f56117a2);
	}
}

/*
	Name: function_1c2930c7
	Namespace: concertina_wire
	Checksum: 0xCDC64FAD
	Offset: 0x7A0
	Size: 0x2B2
	Parameters: 1
	Flags: None
*/
function function_1c2930c7(localclientnum)
{
	player = function_5c10bd79(localclientnum);
	player notify(#"hash_5c7dbac0591cb11f");
	player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
	level endon(#"game_ended");
	level.var_87226c31.var_aef370a9[localclientnum] = 1;
	var_ccfe777 = 0;
	while(true)
	{
		waitframe(1);
		player = function_5c10bd79(localclientnum);
		if(!isdefined(player))
		{
			break;
		}
		var_b43e8dc2 = player function_287dcf4b(level.var_87226c31.bundle.var_63aab046, level.var_87226c31.bundle.maxwidth, 0, 0, level.var_87226c31.var_3e7344ee);
		if(!isdefined(var_b43e8dc2) && !var_ccfe777)
		{
			var_ccfe777 = 1;
			player function_bf191832(0, (0, 0, 0), (0, 0, 0));
			continue;
		}
		else
		{
			if(isdefined(var_b43e8dc2) && var_ccfe777)
			{
				var_ccfe777 = 0;
			}
			else if(!isdefined(var_b43e8dc2))
			{
				player function_bf191832(0, (0, 0, 0), (0, 0, 0));
				continue;
			}
		}
		if((isdefined(level.var_87226c31.bundle.var_8fa9aac4) ? level.var_87226c31.bundle.var_8fa9aac4 : 0))
		{
			if(var_b43e8dc2.var_bf9ca9b0)
			{
				var_688ed1a6 = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 0, 1);
			}
			else
			{
				var_688ed1a6 = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 2, 3);
			}
		}
	}
}

/*
	Name: function_8fb44aff
	Namespace: concertina_wire
	Checksum: 0xF5DA2E47
	Offset: 0xA60
	Size: 0x54
	Parameters: 6
	Flags: None
*/
function function_8fb44aff(localclientnum, origin, angles, isvalid, var_eb65925c, var_4b3e5e0a)
{
	self function_bf191832(0, origin, angles);
}

