// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace trophy_system;

/*
	Name: init_shared
	Namespace: trophy_system
	Checksum: 0xBB510412
	Offset: 0xB8
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 0);
	clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

/*
	Name: trophy_state_change
	Namespace: trophy_system
	Checksum: 0x4EA7AB09
	Offset: 0x158
	Size: 0xCA
	Parameters: 7
	Flags: None
*/
function trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			self thread trophy_rolling_anim(localclientnum);
			break;
		}
		case 2:
		{
			self thread trophy_stationary_anim(localclientnum);
			break;
		}
		case 3:
		{
			break;
		}
		case 0:
		{
			break;
		}
	}
}

/*
	Name: trophy_state_change_recon
	Namespace: trophy_system
	Checksum: 0xB8CF871F
	Offset: 0x230
	Size: 0xCA
	Parameters: 7
	Flags: None
*/
function trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			self thread trophy_rolling_anim(localclientnum);
			break;
		}
		case 2:
		{
			self thread trophy_stationary_anim(localclientnum);
			break;
		}
		case 3:
		{
			break;
		}
		case 0:
		{
			break;
		}
	}
}

/*
	Name: trophy_rolling_anim
	Namespace: trophy_system
	Checksum: 0xB3D562FB
	Offset: 0x308
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function trophy_rolling_anim(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
}

/*
	Name: trophy_stationary_anim
	Namespace: trophy_system
	Checksum: 0xC7141B00
	Offset: 0x390
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function trophy_stationary_anim(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
	self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
}

