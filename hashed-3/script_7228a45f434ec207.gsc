// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_268fc37c;

/*
	Name: function_89f2df9
	Namespace: namespace_268fc37c
	Checksum: 0xB9A7BB43
	Offset: 0x1F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_39775c4aaea6051b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_268fc37c
	Checksum: 0xB8D47C3B
	Offset: 0x240
	Size: 0x522
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "tomahawk_in_use", 1, 2, "int", &tomahawk_in_use, 0, 1);
	clientfield::register("toplayer", "" + #"upgraded_tomahawk_in_use", 1, 1, "int", &tomahawk_in_use, 0, 1);
	clientfield::register("scriptmover", "play_tomahawk_fx", 1, 2, "int", &play_tomahawk_pickup_fx, 0, 0);
	clientfield::register("actor", "play_tomahawk_hit_sound", 1, 1, "int", &function_9a3953ea, 0, 0);
	clientfield::register("toplayer", "tomahawk_rumble", 1, 2, "counter", &tomahawk_rumble, 0, 0);
	clientfield::register("actor", "tomahawk_impact_fx", 1, 2, "int", &tomahawk_impact_fx, 0, 0);
	clientfield::register("allplayers", "tomahawk_charge_up_fx", 1, 2, "counter", &tomahawk_charge_up_fx, 0, 0);
	var_92c56e8d = getminbitcountfornum(3);
	clientfield::register("scriptmover", "tomahawk_trail_fx", 1, var_92c56e8d, "int", &tomahawk_trail_fx, 0, 0);
	clientfield::register("missile", "tomahawk_trail_fx", 1, var_92c56e8d, "int", &tomahawk_trail_fx, 0, 0);
	setupclientfieldcodecallbacks("toplayer", 1, "tomahawk_in_use");
	setupclientfieldcodecallbacks("toplayer", 1, "" + #"upgraded_tomahawk_in_use");
	level._effect[#"tomahawk_pickup"] = #"hash_589d0bc9c10726fb";
	level._effect[#"tomahawk_pickup_upgrade"] = #"hash_5f183257769badd4";
	level._effect[#"tomahawk_trail"] = #"hash_77b995b902df3cd9";
	level._effect[#"tomahawk_trail_ug"] = #"hash_5384d01e513526";
	level._effect[#"tomahawk_charged_trail"] = #"hash_3d47ab5cd1e7b732";
	level._effect[#"hash_f0d62b29afe4b7c"] = #"hash_5c8911bafb8efe53";
	level._effect[#"tomahawk_impact"] = #"hash_681b2b47d9fb71c9";
	level._effect[#"tomahawk_impact_ug"] = #"hash_26ef5fefeb29c436";
	level._effect[#"tomahawk_fire_dot"] = #"hash_5686def5b4c85661";
	level._effect[#"tomahawk_charge_up"] = #"hash_909f7d24e4e84e3";
	level._effect[#"tomahawk_charge_up_ug"] = #"hash_de4b918ea7d5e3c";
}

/*
	Name: tomahawk_in_use
	Namespace: namespace_268fc37c
	Checksum: 0x3698E871
	Offset: 0x770
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function tomahawk_in_use(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	/#
		if(newval == 1)
		{
			iprintlnbold("");
		}
		else
		{
			iprintlnbold("");
		}
	#/
}

/*
	Name: play_tomahawk_pickup_fx
	Namespace: namespace_268fc37c
	Checksum: 0x84EC4035
	Offset: 0x800
	Size: 0x23A
	Parameters: 7
	Flags: Linked
*/
function play_tomahawk_pickup_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self util::waittill_dobj(localclientnum);
	if(bwasdemojump)
	{
		if(newval == 1)
		{
			if(isdefined(self.n_fx_id))
			{
				stopfx(localclientnum, self.n_fx_id);
				self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
			}
		}
		else if(newval == 2)
		{
			if(isdefined(self.n_fx_id))
			{
				stopfx(localclientnum, self.n_fx_id);
				self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
			}
		}
		return;
	}
	if(newval == 1)
	{
		if(isdefined(self.n_fx_id))
		{
			stopfx(localclientnum, self.n_fx_id);
		}
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		if(isdefined(self.n_fx_id))
		{
			stopfx(localclientnum, self.n_fx_id);
		}
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
	}
}

/*
	Name: function_9a3953ea
	Namespace: namespace_268fc37c
	Checksum: 0xAEFD6998
	Offset: 0xA48
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_9a3953ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self playsound(localclientnum, #"wpn_tomahawk_impact", self.origin + vectorscale((0, 0, 1), 75));
}

/*
	Name: tomahawk_trail_fx
	Namespace: namespace_268fc37c
	Checksum: 0x8A03E0E7
	Offset: 0xAD0
	Size: 0x1EA
	Parameters: 7
	Flags: Linked
*/
function tomahawk_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_95eaa1e))
	{
		deletefx(localclientnum, self.n_trail_fx, 1);
		self.n_trail_fx = undefined;
	}
	if(!isdefined(self.var_5681eeb0))
	{
		self.var_5681eeb0 = self playloopsound(#"hash_5e3cfa1a476b30c4");
	}
	if(newval == 1)
	{
		self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_trail"], self, "tag_fx");
	}
	else
	{
		if(newval == 2)
		{
			self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_trail_ug"], self, "tag_fx");
		}
		else
		{
			if(newval == 3)
			{
				self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_charged_trail"], self, "tag_fx");
			}
			else if(newval == 4)
			{
				self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"hash_f0d62b29afe4b7c"], self, "tag_fx");
			}
		}
	}
}

/*
	Name: tomahawk_impact_fx
	Namespace: namespace_268fc37c
	Checksum: 0x1CD96866
	Offset: 0xCC8
	Size: 0x1CC
	Parameters: 7
	Flags: Linked
*/
function tomahawk_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_d634930c))
	{
		deletefx(localclientnum, self.var_d634930c, 1);
		self.var_d634930c = undefined;
	}
	str_tag = "J_Head";
	var_a4c13d2 = "j_spineupper";
	if(self.archetype == #"zombie_dog")
	{
		str_tag = "J_Head";
		var_a4c13d2 = "J_Spine1";
	}
	if(newval == 1)
	{
		self.var_d634930c = util::playfxontag(localclientnum, level._effect[#"tomahawk_impact"], self, str_tag);
		util::playfxontag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_a4c13d2);
	}
	else if(newval == 2)
	{
		self.var_d634930c = util::playfxontag(localclientnum, level._effect[#"tomahawk_impact_ug"], self, str_tag);
		util::playfxontag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_a4c13d2);
	}
}

/*
	Name: tomahawk_charge_up_fx
	Namespace: namespace_268fc37c
	Checksum: 0x881D332D
	Offset: 0xEA0
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function tomahawk_charge_up_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_5187b05b))
	{
		deletefx(localclientnum, self.var_5187b05b, 1);
		self.var_5187b05b = undefined;
	}
	if(newval == 1)
	{
		self.var_5187b05b = util::playfxontag(localclientnum, level._effect[#"tomahawk_charge_up"], self, "tag_origin");
		self thread function_eea02302();
	}
	else if(newval == 2)
	{
		self.var_5187b05b = util::playfxontag(localclientnum, level._effect[#"tomahawk_charge_up_ug"], self, "tag_origin");
		self thread function_eea02302();
	}
}

/*
	Name: function_eea02302
	Namespace: namespace_268fc37c
	Checksum: 0x9FB2D44
	Offset: 0xFE0
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_eea02302(localclientnum)
{
	self notify(#"hash_5de847b4a6f10108");
	self endon(#"hash_5de847b4a6f10108");
	self endon(#"death");
	self endon(#"disconnect");
	if(!isdefined(self.var_9adf602d))
	{
		self.var_9adf602d = 1;
	}
	self playsound(0, "wpn_tomahawk_charge_" + self.var_9adf602d);
	self.var_9adf602d++;
	wait(1.5);
	self.var_9adf602d = 1;
}

/*
	Name: tomahawk_rumble
	Namespace: namespace_268fc37c
	Checksum: 0x43A782B2
	Offset: 0x10A0
	Size: 0xC2
	Parameters: 7
	Flags: Linked
*/
function tomahawk_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		switch(newvalue)
		{
			case 1:
			{
				self playrumbleonentity(localclientnum, "zm_weap_chakram_catch_rumble");
				break;
			}
			case 2:
			{
				self playrumbleonentity(localclientnum, "zm_weap_chakram_throw_rumble");
				break;
			}
		}
	}
}

