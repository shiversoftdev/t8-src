// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wz_stash_blackjack;

/*
	Name: __init__system__
	Namespace: wz_stash_blackjack
	Checksum: 0xB4D4A563
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_stash_blackjack", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_stash_blackjack
	Checksum: 0x51E262EE
	Offset: 0xC0
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.blackjackstash = (isdefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0);
	customgame = gamemodeismode(1) || gamemodeismode(7);
	if(customgame || !level.blackjackstash)
	{
		level thread function_e973becc();
	}
}

/*
	Name: function_e973becc
	Namespace: wz_stash_blackjack
	Checksum: 0x4372E8E9
	Offset: 0x198
	Size: 0xB0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e973becc()
{
	item_world::function_4de3ca98();
	var_14957968 = getdynentarray(#"wz_stash_blackjack");
	foreach(var_2e01d28f in var_14957968)
	{
		item_world::function_160294c7(var_2e01d28f);
	}
}

