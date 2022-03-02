// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace lightning_chain;

/*
	Name: function_89f2df9
	Namespace: lightning_chain
	Checksum: 0xECD5F183
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"lightning_chain", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: lightning_chain
	Checksum: 0x6D91D929
	Offset: 0x178
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 1);
	clientfield::register("vehicle", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 0);
	clientfield::register("actor", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
	clientfield::register("vehicle", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
}

/*
	Name: lc_shock_fx
	Namespace: lightning_chain
	Checksum: 0xE583984E
	Offset: 0x2A8
	Size: 0x1CE
	Parameters: 7
	Flags: Linked
*/
function lc_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(newval)
	{
		if(!isdefined(self.lc_shock_fx))
		{
			str_tag = "J_SpineUpper";
			str_fx = "zm_ai/fx8_elec_shock";
			if(!self isai())
			{
				str_tag = "tag_origin";
			}
			if(newval > 1)
			{
				str_fx = "zm_ai/fx8_elec_bolt";
			}
			self.lc_shock_fx = util::playfxontag(localclientnum, str_fx, self, str_tag);
			if(!isdefined(self.var_b3a6c3f7))
			{
				self.var_b3a6c3f7 = self playloopsound(#"hash_536f193a75e9cec9", 1);
			}
			self playsound(0, #"hash_63d588d1f28ecdc1");
		}
	}
	else
	{
		if(isdefined(self.lc_shock_fx))
		{
			stopfx(localclientnum, self.lc_shock_fx);
			self.lc_shock_fx = undefined;
		}
		if(isdefined(self.var_b3a6c3f7))
		{
			self stoploopsound(self.var_b3a6c3f7);
			self.var_b3a6c3f7 = undefined;
		}
	}
}

/*
	Name: lc_play_death_fx
	Namespace: lightning_chain
	Checksum: 0x40AEC4E6
	Offset: 0x480
	Size: 0x16C
	Parameters: 7
	Flags: Linked
*/
function lc_play_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	str_tag = "J_SpineUpper";
	if(isdefined(self.isdog) && self.isdog)
	{
		str_tag = "J_Spine1";
	}
	if(!self.archetype === #"zombie")
	{
		tag = "tag_origin";
	}
	switch(newval)
	{
		case 2:
		{
			str_fx = "zm_ai/fx8_elec_bolt";
			break;
		}
		case 3:
		{
			str_fx = "zm_ai/fx8_elec_shock_os";
			break;
		}
		default:
		{
			str_fx = "zm_ai/fx8_elec_shock";
			break;
		}
	}
	util::playfxontag(localclientnum, str_fx, self, str_tag);
}

