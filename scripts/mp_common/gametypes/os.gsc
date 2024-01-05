// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_loadout.gsc;
#using scripts\core_common\gameobjects_shared.gsc;

#namespace os;

/*
	Name: turn_back_time
	Namespace: os
	Checksum: 0xC5ED5BBD
	Offset: 0xA0
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function turn_back_time(basegametype)
{
	gameobjects::register_allowed_gameobject("os");
	gameobjects::register_allowed_gameobject(basegametype);
	level.oldschoolweapon = getweapon("pistol_standard");
	level.primaryoffhandnull = getweapon(#"null_offhand_primary");
	level.secondaryoffhandnull = getweapon(#"null_offhand_secondary");
	level.givecustomloadout = &give_oldschool_loadout;
}

/*
	Name: give_oldschool_loadout
	Namespace: os
	Checksum: 0xC504632D
	Offset: 0x170
	Size: 0x136
	Parameters: 0
	Flags: None
*/
function give_oldschool_loadout()
{
	self loadout::init_player(1);
	self loadout::function_f436358b("CLASS_ASSAULT");
	self giveweapon(level.oldschoolweapon);
	self switchtoweapon(level.oldschoolweapon);
	self giveweapon(level.primaryoffhandnull);
	self giveweapon(level.secondaryoffhandnull);
	self setweaponammoclip(level.primaryoffhandnull, 0);
	self setweaponammoclip(level.secondaryoffhandnull, 0);
	if(self.firstspawn !== 0)
	{
		self setspawnweapon(level.oldschoolweapon);
	}
	return level.oldschoolweapon;
}

