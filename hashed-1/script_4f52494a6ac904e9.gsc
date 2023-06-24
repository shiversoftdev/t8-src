// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_1d05befd;

/*
	Name: __init__system__
	Namespace: namespace_1d05befd
	Checksum: 0xE63FDAF9
	Offset: 0x268
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_831eacd382054cc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1d05befd
	Checksum: 0xC2ECA4C5
	Offset: 0x2B0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ai::add_archetype_spawn_function(#"zombie", &function_65089f84);
	clientfield::register("actor", "zm_ai/zombie_electric_fx_clientfield", 21000, 1, "int", &zombie_electric_fx, 0, 0);
	clientfield::register("actor", "zombie_electric_burst_clientfield", 21000, 1, "counter", &function_8f477183, 0, 0);
	clientfield::register("actor", "zombie_electric_water_aoe_clientfield", 21000, 1, "counter", &function_c9f98c07, 0, 0);
	clientfield::register("actor", "zombie_electric_burst_stun_friendly_clientfield", 21000, 1, "int", &function_93585307, 0, 0);
	clientfield::register("toplayer", "zombie_electric_burst_postfx_clientfield", 21000, 1, "counter", &function_4d29fadf, 0, 0);
}

/*
	Name: function_65089f84
	Namespace: namespace_1d05befd
	Checksum: 0x1AE39C85
	Offset: 0x458
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private function_65089f84(localclientnum)
{
}

/*
	Name: zombie_electric_fx
	Namespace: namespace_1d05befd
	Checksum: 0x643BB4B
	Offset: 0x498
	Size: 0xCE
	Parameters: 7
	Flags: Linked, Private
*/
function private zombie_electric_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		if(newval)
		{
			self.var_2e07a8e7 = util::playfxontag(localclientnum, "zm_ai/fx8_elec_zombie_sparky_chest", self, "j_spine4");
		}
		else if(isdefined(self.var_2e07a8e7))
		{
			stopfx(localclientnum, self.var_2e07a8e7);
			self.var_2e07a8e7 = undefined;
		}
	}
}

/*
	Name: function_8f477183
	Namespace: namespace_1d05befd
	Checksum: 0x9F0F1A25
	Offset: 0x570
	Size: 0x9C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_8f477183(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self) && newval)
	{
		playfx(localclientnum, "zm_ai/fx8_elec_zombie_explode", self gettagorigin("j_spine4"));
	}
}

/*
	Name: function_c9f98c07
	Namespace: namespace_1d05befd
	Checksum: 0x187F96BD
	Offset: 0x618
	Size: 0x9C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c9f98c07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self) && newval)
	{
		playfx(localclientnum, "zm_ai/fx8_elec_zombie_blast_area", self gettagorigin("j_spine4"));
	}
}

/*
	Name: function_4d29fadf
	Namespace: namespace_1d05befd
	Checksum: 0x94F3792F
	Offset: 0x6C0
	Size: 0x84
	Parameters: 7
	Flags: Linked, Private
*/
function private function_4d29fadf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self) && newval)
	{
		self thread postfx::playpostfxbundle(#"hash_2083fc2cc0fee308");
	}
}

/*
	Name: function_93585307
	Namespace: namespace_1d05befd
	Checksum: 0x2ECB0B5D
	Offset: 0x750
	Size: 0x1AE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_93585307(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		if(newval)
		{
			if(!isdefined(self.var_2e07a8e7))
			{
				self.var_2e07a8e7 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_torso", self, "j_spine4");
			}
			if(!isdefined(self.var_d48778ce))
			{
				self.var_d48778ce = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");
			}
			if(!isdefined(self.var_93ee541d))
			{
				self.var_93ee541d = self playloopsound("zmb_aat_kilowatt_stunned_lp");
			}
		}
		else
		{
			if(isdefined(self.var_2e07a8e7))
			{
				stopfx(localclientnum, self.var_2e07a8e7);
				self.var_2e07a8e7 = undefined;
			}
			if(isdefined(self.var_d48778ce))
			{
				stopfx(localclientnum, self.var_d48778ce);
				self.var_d48778ce = undefined;
			}
			if(isdefined(self.var_93ee541d))
			{
				self stoploopsound(self.var_93ee541d);
				self.var_93ee541d = undefined;
			}
		}
	}
}

