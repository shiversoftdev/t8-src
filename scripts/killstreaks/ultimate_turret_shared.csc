// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace ultimate_turret;

/*
	Name: init_shared
	Namespace: ultimate_turret
	Checksum: 0xB939423
	Offset: 0x108
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_1427245))
	{
		level.var_1427245 = {};
		clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int", &turret_open, 0, 0);
		clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
		clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
		clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int", undefined, 0, 0);
	}
}

/*
	Name: turret_init_anim
	Namespace: ultimate_turret
	Checksum: 0xF3B6AB6B
	Offset: 0x240
	Size: 0xEC
	Parameters: 7
	Flags: None
*/
function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
	self setanimtime(#"o_turret_mini_deploy", 0);
}

/*
	Name: turret_open
	Namespace: ultimate_turret
	Checksum: 0x15F0708B
	Offset: 0x338
	Size: 0xC4
	Parameters: 7
	Flags: None
*/
function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

/*
	Name: turret_close_anim
	Namespace: ultimate_turret
	Checksum: 0xAFC255ED
	Offset: 0x408
	Size: 0x9C
	Parameters: 7
	Flags: None
*/
function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
	self useanimtree("generic");
	self setanimrestart(#"o_turret_sentry_close", 1, 0, 1);
}

