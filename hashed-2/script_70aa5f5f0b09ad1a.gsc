// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace bouncingbetty;

/*
	Name: init_shared
	Namespace: bouncingbetty
	Checksum: 0x7779AE5F
	Offset: 0xB8
	Size: 0x1B4
	Parameters: 1
	Flags: None
*/
function init_shared(localclientnum)
{
	level.explode_1st_offset = 55;
	level.explode_2nd_offset = 95;
	level.explode_main_offset = 140;
	level._effect[#"fx_betty_friendly_light"] = #"hash_5f76ecd582d98e38";
	level._effect[#"fx_betty_enemy_light"] = #"hash_330682ff4f12f646";
	level._effect[#"fx_betty_exp"] = #"weapon/fx_betty_exp";
	level._effect[#"fx_betty_exp_death"] = #"weapon/fx_betty_exp_death";
	level._effect[#"fx_betty_launch_dust"] = #"weapon/fx_betty_launch_dust";
	clientfield::register("missile", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
	clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int", &bouncingbetty_state_change, 0, 0);
}

/*
	Name: bouncingbetty_state_change
	Namespace: bouncingbetty
	Checksum: 0x9C7C4B9D
	Offset: 0x278
	Size: 0xDA
	Parameters: 7
	Flags: None
*/
function bouncingbetty_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	switch(newval)
	{
		case 1:
		{
			self thread bouncingbetty_detonating(localclientnum);
			break;
		}
		case 2:
		{
			self thread bouncingbetty_deploying(localclientnum);
			break;
		}
	}
}

/*
	Name: bouncingbetty_deploying
	Namespace: bouncingbetty
	Checksum: 0xC37D7FA3
	Offset: 0x360
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function bouncingbetty_deploying(localclientnum)
{
	self endon(#"death");
	self useanimtree("generic");
}

/*
	Name: bouncingbetty_detonating
	Namespace: bouncingbetty
	Checksum: 0x82D99C47
	Offset: 0x3A8
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function bouncingbetty_detonating(localclientnum)
{
	self endon(#"death");
	up = anglestoup(self.angles);
	forward = anglestoforward(self.angles);
	playfx(localclientnum, level._effect[#"fx_betty_launch_dust"], self.origin, up, forward);
	self playsound(localclientnum, #"wpn_betty_jump");
	self useanimtree("generic");
	self thread watchforexplosionnotetracks(localclientnum, up, forward);
}

/*
	Name: watchforexplosionnotetracks
	Namespace: bouncingbetty
	Checksum: 0xB016C6CA
	Offset: 0x4C0
	Size: 0x20E
	Parameters: 3
	Flags: None
*/
function watchforexplosionnotetracks(localclientnum, up, forward)
{
	self endon(#"death");
	while(true)
	{
		notetrack = undefined;
		notetrack = self waittill(#"explode_1st", #"explode_2nd", #"explode_main");
		switch(notetrack._notify)
		{
			case "explode_1st":
			{
				playfx(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_1st_offset, up, forward);
				break;
			}
			case "explode_2nd":
			{
				playfx(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_2nd_offset, up, forward);
				break;
			}
			case "explode_main":
			{
				playfx(localclientnum, level._effect[#"fx_betty_exp"], self.origin + up * level.explode_main_offset, up, forward);
				playfx(localclientnum, level._effect[#"fx_betty_exp_death"], self.origin, up, forward);
				break;
			}
			default:
			{
				break;
			}
		}
	}
}

