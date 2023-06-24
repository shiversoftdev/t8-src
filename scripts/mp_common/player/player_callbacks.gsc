// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_damage.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_ui.gsc;

#namespace player;

/*
	Name: callback_playermelee
	Namespace: player
	Checksum: 0xC68B16BC
	Offset: 0xA8
	Size: 0xD4
	Parameters: 8
	Flags: Linked
*/
function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind)
{
	hit = 1;
	if(level.teambased && !self util::isenemyteam(eattacker.team))
	{
		if(level.friendlyfire == 0)
		{
			hit = 0;
		}
	}
	self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

/*
	Name: function_74b6d714
	Namespace: player
	Checksum: 0x9397463E
	Offset: 0x188
	Size: 0x15C
	Parameters: 5
	Flags: Linked
*/
function function_74b6d714(attacker, effectname, var_894859a2, var_ab5b905e, weapon)
{
	var_20df3f41 = function_1115bceb(effectname);
	if(isdefined(var_ab5b905e) && var_ab5b905e > 0)
	{
		duration = var_ab5b905e;
	}
	else
	{
		duration = undefined;
	}
	attackerishittingteammate = isplayer(attacker) && self util::isenemyplayer(attacker) == 0 && self != attacker;
	attackerishittingself = isplayer(attacker) && self == attacker;
	if(attackerishittingself && weapon.var_50d2316b)
	{
		return;
	}
	if(attackerishittingteammate && !function_1727a023(0, attacker))
	{
		return;
	}
	self status_effect::status_effect_apply(var_20df3f41, weapon, attacker, undefined, duration, var_894859a2);
}

/*
	Name: callback_playershielddamageblocked
	Namespace: player
	Checksum: 0x9AC1D540
	Offset: 0x2F0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function callback_playershielddamageblocked(damage)
{
	previous_shield_damage = self.shielddamageblocked;
	self.shielddamageblocked = self.shielddamageblocked + damage;
	if(self.shielddamageblocked % 200 < previous_shield_damage % 200)
	{
		score_event = "shield_blocked_damage";
		scoreevents::processscoreevent(score_event, self, undefined, self.currentweapon);
	}
}

/*
	Name: callback_playermigrated
	Namespace: player
	Checksum: 0x25136FCF
	Offset: 0x380
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function callback_playermigrated()
{
	/#
		println((("" + self.name) + "") + gettime());
	#/
	if(isdefined(self.connected) && self.connected)
	{
		self globallogic_ui::updateobjectivetext();
	}
	level.hostmigrationreturnedplayercount++;
	if(level.hostmigrationreturnedplayercount >= ((level.players.size * 2) / 3))
	{
		/#
			println("");
		#/
		level notify(#"hostmigration_enoughplayers");
	}
}

/*
	Name: callback_playerlaststand
	Namespace: player
	Checksum: 0xAF34AA0E
	Offset: 0x458
	Size: 0x90
	Parameters: 9
	Flags: Linked
*/
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(isdefined(level.var_97c6ee7c))
	{
		[[level.var_97c6ee7c]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
	}
}

