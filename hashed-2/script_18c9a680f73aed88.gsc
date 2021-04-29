// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace riotshield;

/*
	Name: init_shared
	Namespace: riotshield
	Checksum: 0x6B7B84EC
	Offset: 0x100
	Size: 0xAA
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("scriptmover", "riotshield_state", 1, 2, "int", &shield_state_change, 0, 0);
	level._effect[#"riotshield_light"] = #"_t6/weapon/riotshield/fx_riotshield_depoly_lights";
	level._effect[#"riotshield_dust"] = #"_t6/weapon/riotshield/fx_riotshield_depoly_dust";
}

/*
	Name: shield_state_change
	Namespace: riotshield
	Checksum: 0x5884A5D3
	Offset: 0x1B8
	Size: 0xD2
	Parameters: 7
	Flags: None
*/
function shield_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	switch(newval)
	{
		case 1:
		{
			instant = oldval == 2;
			self thread riotshield_deploy_anim(localclientnum, instant);
			break;
		}
		case 2:
		{
			self thread riotshield_destroy_anim(localclientnum);
			break;
		}
	}
}

/*
	Name: riotshield_deploy_anim
	Namespace: riotshield
	Checksum: 0xD6DC8954
	Offset: 0x298
	Size: 0x16A
	Parameters: 2
	Flags: None
*/
function riotshield_deploy_anim(localclientnum, instant)
{
	self endon(#"death");
	self thread watch_riotshield_damage();
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	if(instant)
	{
		self setanimtime(#"o_riot_stand_deploy", 1);
	}
	else
	{
		self setanim(#"o_riot_stand_deploy", 1, 0, 1);
		util::playfxontag(localclientnum, level._effect[#"riotshield_dust"], self, "tag_origin");
	}
	if(!instant)
	{
		wait(0.8);
	}
	self.shieldlightfx = util::playfxontag(localclientnum, level._effect[#"riotshield_light"], self, "tag_fx");
}

/*
	Name: watch_riotshield_damage
	Namespace: riotshield
	Checksum: 0xDED557E6
	Offset: 0x410
	Size: 0x128
	Parameters: 0
	Flags: None
*/
function watch_riotshield_damage()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		damage_type = waitresult.mod;
		self useanimtree("generic");
		if(damage_type == "MOD_MELEE" || damage_type == "MOD_MELEE_WEAPON_BUTT" || damage_type == "MOD_MELEE_ASSASSINATE")
		{
			self setanim(#"o_riot_stand_melee_front", 1, 0, 1);
		}
		else
		{
			self setanim(#"o_riot_stand_shot", 1, 0, 1);
		}
	}
}

/*
	Name: riotshield_destroy_anim
	Namespace: riotshield
	Checksum: 0xBAB784AB
	Offset: 0x540
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function riotshield_destroy_anim(localclientnum)
{
	self endon(#"death");
	if(isdefined(self.shieldlightfx))
	{
		stopfx(localclientnum, self.shieldlightfx);
	}
	waitframe(1);
	self playsound(localclientnum, #"wpn_shield_destroy");
	self useanimtree("generic");
	self setanim(#"o_riot_stand_destroyed", 1, 0, 1);
	wait(1);
	self setforcenotsimple();
}

