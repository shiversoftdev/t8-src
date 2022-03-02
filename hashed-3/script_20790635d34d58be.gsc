// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c49ae69cd8ce30c;
#using script_3fda550bc6e1089a;
#using script_47fb62300ac0bd60;
#using script_6c8abe14025b47c4;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;

#namespace helicopter;

/*
	Name: function_89f2df9
	Namespace: helicopter
	Checksum: 0xFEC1AE03
	Offset: 0x130
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"helicopter", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: helicopter
	Checksum: 0x13595CC9
	Offset: 0x180
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_34f03cda = &function_34f03cda;
	level.var_4d5e1035 = &function_4d5e1035;
	level.var_6af968ce = &function_6af968ce;
	init_shared("killstreak_helicopter_comlink");
	player::function_cf3aa03d(&function_d45a1f8d, 0);
}

/*
	Name: function_6af968ce
	Namespace: helicopter
	Checksum: 0x1F994110
	Offset: 0x210
	Size: 0x15C
	Parameters: 3
	Flags: Linked
*/
function function_6af968ce(attacker, weapon, mod)
{
	if(isdefined(attacker) && isplayer(attacker))
	{
		if(!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))
		{
			attacker battlechatter::function_dd6a6012(self.killstreaktype, weapon);
			self killstreaks::function_73566ec7(attacker, weapon, self.owner);
			challenges::destroyedhelicopter(attacker, weapon, mod, 0);
			attacker challenges::addflyswatterstat(weapon, self);
			attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
		}
	}
	if(self.leaving !== 1)
	{
		self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
	}
}

/*
	Name: function_34f03cda
	Namespace: helicopter
	Checksum: 0x8C18A058
	Offset: 0x378
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_34f03cda(hardpointtype)
{
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		self challenges::calledincomlinkchopper();
	}
}

/*
	Name: function_4d5e1035
	Namespace: helicopter
	Checksum: 0x485E95DF
	Offset: 0x3C8
	Size: 0x180
	Parameters: 7
	Flags: Linked
*/
function function_4d5e1035(attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype)
{
	if(weapon_damage > 0)
	{
		self challenges::trackassists(attacker, weapon_damage, 0);
	}
	if(isdefined(event))
	{
		if(isdefined(self.owner) && self.owner util::isenemyplayer(attacker))
		{
			challenges::destroyedhelicopter(attacker, weapon, type, 0);
			challenges::destroyedaircraft(attacker, weapon, playercontrolled, 1);
			scoreevents::processscoreevent(event, attacker, self.owner, weapon);
			attacker challenges::addflyswatterstat(weapon, self);
			if(playercontrolled == 1)
			{
				attacker challenges::destroyedplayercontrolledaircraft();
			}
			if(hardpointtype == "helicopter_player_gunner")
			{
				attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
			}
		}
	}
}

/*
	Name: function_d45a1f8d
	Namespace: helicopter
	Checksum: 0x1A7B7ABB
	Offset: 0x550
	Size: 0x136
	Parameters: 9
	Flags: Linked
*/
function function_d45a1f8d(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(!isdefined(einflictor) || !isdefined(einflictor.owner) || !isdefined(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(einflictor.owner == attacker && weapon == getweapon(#"cobra_20mm_comlink") && (isdefined(einflictor.var_6ac0633e) ? einflictor.var_6ac0633e : 0) < gettime())
	{
		einflictor killstreaks::play_pilot_dialog_on_owner("kill", "helicopter_comlink", einflictor.killstreak_id);
		einflictor.var_6ac0633e = gettime() + 5000;
	}
}

