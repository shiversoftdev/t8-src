// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace bb;

/*
	Name: __init__system__
	Namespace: bb
	Checksum: 0xF4329BA1
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"bb", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bb
	Checksum: 0x40798D8D
	Offset: 0xE8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

/*
	Name: logdamage
	Namespace: bb
	Checksum: 0xEE4AE9E7
	Offset: 0x108
	Size: 0x44
	Parameters: 8
	Flags: Linked
*/
function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned)
{
}

/*
	Name: logaispawn
	Namespace: bb
	Checksum: 0x318F46C2
	Offset: 0x158
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function logaispawn(aient, spawner)
{
}

/*
	Name: logplayerevent
	Namespace: bb
	Checksum: 0xE68F87DE
	Offset: 0x178
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function logplayerevent(player, eventname)
{
	currentweapon = "";
	beastmodeactive = 0;
	if(isdefined(player.currentweapon))
	{
		currentweapon = player.currentweapon.name;
	}
	if(isdefined(player.beastmode))
	{
		beastmodeactive = player.beastmode;
	}
	zmplayerevents = {};
	zmplayerevents.gametime = function_f8d53445();
	zmplayerevents.roundnumber = level.round_number;
	zmplayerevents.eventname = eventname;
	zmplayerevents.spawnid = getplayerspawnid(player);
	zmplayerevents.username = player.name;
	zmplayerevents.originx = player.origin[0];
	zmplayerevents.originy = player.origin[1];
	zmplayerevents.originz = player.origin[2];
	zmplayerevents.health = player.health;
	zmplayerevents.beastlives = player.beastlives;
	zmplayerevents.currentweapon = currentweapon;
	zmplayerevents.kills = player.kills;
	zmplayerevents.zone_name = player.zone_name;
	zmplayerevents.sessionstate = player.sessionstate;
	zmplayerevents.currentscore = player.score;
	zmplayerevents.totalscore = player.score_total;
	zmplayerevents.beastmodeon = beastmodeactive;
	function_92d1707f(#"hash_5bd2a2e3f75111c8", zmplayerevents);
}

/*
	Name: logroundevent
	Namespace: bb
	Checksum: 0x655366BA
	Offset: 0x3C0
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function logroundevent(eventname)
{
	zmroundevents = {#eventname:eventname, #roundnumber:level.round_number, #gametime:function_f8d53445()};
	function_92d1707f(#"hash_1f42d237e3407165", zmroundevents);
	if(isdefined(level.players))
	{
		foreach(player in level.players)
		{
			logplayerevent(player, eventname);
		}
	}
}

/*
	Name: logpurchaseevent
	Namespace: bb
	Checksum: 0xD600A792
	Offset: 0x4E0
	Size: 0x22C
	Parameters: 7
	Flags: Linked
*/
function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname)
{
	zmpurchases = {};
	zmpurchases.gametime = function_f8d53445();
	zmpurchases.roundnumber = level.round_number;
	zmpurchases.playerspawnid = getplayerspawnid(player);
	zmpurchases.username = player.name;
	zmpurchases.itemname = itemname;
	zmpurchases.isupgraded = itemupgraded;
	zmpurchases.itemtype = itemtype;
	zmpurchases.purchasecost = cost;
	zmpurchases.playeroriginx = player.origin[0];
	zmpurchases.playeroriginy = player.origin[1];
	zmpurchases.playeroriginz = player.origin[2];
	zmpurchases.selleroriginx = sellerent.origin[0];
	zmpurchases.selleroriginy = sellerent.origin[1];
	zmpurchases.selleroriginz = sellerent.origin[2];
	zmpurchases.playerkills = player.kills;
	zmpurchases.playerhealth = player.health;
	zmpurchases.playercurrentscore = player.score;
	zmpurchases.playertotalscore = player.score_total;
	zmpurchases.zone_name = player.zone_name;
	function_92d1707f(#"hash_22cb254982ca97dc", zmpurchases);
}

/*
	Name: logpowerupevent
	Namespace: bb
	Checksum: 0x553619A
	Offset: 0x718
	Size: 0x218
	Parameters: 3
	Flags: Linked
*/
function logpowerupevent(powerup, optplayer, eventname)
{
	playerspawnid = -1;
	playername = "";
	if(isdefined(optplayer) && isplayer(optplayer))
	{
		playerspawnid = getplayerspawnid(optplayer);
		playername = optplayer.name;
	}
	zmpowerups = {};
	zmpowerups.gametime = function_f8d53445();
	zmpowerups.roundnumber = level.round_number;
	zmpowerups.powerupname = powerup.powerup_name;
	zmpowerups.powerupx = powerup.origin[0];
	zmpowerups.powerupy = powerup.origin[1];
	zmpowerups.powerupz = powerup.origin[2];
	zmpowerups.eventname = eventname;
	zmpowerups.playerspawnid = playerspawnid;
	zmpowerups.playername = playername;
	function_92d1707f(#"hash_7edbd2a2dee992e9", zmpowerups);
	foreach(player in level.players)
	{
		logplayerevent(player, (("powerup_" + powerup.powerup_name) + "_") + eventname);
	}
}

