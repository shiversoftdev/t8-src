// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace teamset;

/*
	Name: init
	Namespace: teamset
	Checksum: 0x91305A4A
	Offset: 0x80
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!isdefined(game.flagmodels))
	{
		game.flagmodels = [];
	}
	if(!isdefined(game.carry_flagmodels))
	{
		game.carry_flagmodels = [];
	}
	if(!isdefined(game.carry_icon))
	{
		game.carry_icon = [];
	}
	game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}

/*
	Name: customteam_init
	Namespace: teamset
	Checksum: 0x7900FC08
	Offset: 0x110
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function customteam_init()
{
	if(getdvarstring(#"g_customteamname_allies") != "")
	{
		setdvar(#"g_teamname_allies", getdvarstring(#"g_customteamname_allies"));
	}
	if(getdvarstring(#"g_customteamname_axis") != "")
	{
		setdvar(#"g_teamname_axis", getdvarstring(#"g_customteamname_axis"));
	}
}

