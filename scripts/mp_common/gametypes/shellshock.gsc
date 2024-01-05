// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\util.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace shellshock;

/*
	Name: __init__system__
	Namespace: shellshock
	Checksum: 0xDCC135E4
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"shellshock", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: shellshock
	Checksum: 0x8B696526
	Offset: 0x150
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	level.shellshockonplayerdamage = &on_damage;
}

/*
	Name: init
	Namespace: shellshock
	Checksum: 0x80F724D1
	Offset: 0x198
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: on_damage
	Namespace: shellshock
	Checksum: 0xDFAFDE90
	Offset: 0x1A8
	Size: 0x1B4
	Parameters: 3
	Flags: Linked
*/
function on_damage(cause, damage, weapon)
{
	if(self util::isflashbanged())
	{
		return;
	}
	if(self.health <= 0)
	{
		self clientfield::set_to_player("sndMelee", 0);
	}
	if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH")
	{
		if(weapon.explosionradius == 0)
		{
			return;
		}
		time = 0;
		if(damage >= 90)
		{
			time = 4;
		}
		else
		{
			if(damage >= 50)
			{
				time = 3;
			}
			else
			{
				if(damage >= 25)
				{
					time = 2;
				}
				else if(damage > 10)
				{
					time = 2;
				}
			}
		}
		if(time)
		{
			if(self util::mayapplyscreeneffect() && self hasperk(#"specialty_flakjacket") == 0)
			{
				self shellshock(#"frag_grenade_mp", 0.5);
			}
		}
	}
}

/*
	Name: end_on_death
	Namespace: shellshock
	Checksum: 0x1285D0C1
	Offset: 0x368
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function end_on_death()
{
	self waittill(#"death");
	waittillframeend();
	self notify(#"end_explode");
}

/*
	Name: end_on_timer
	Namespace: shellshock
	Checksum: 0xE24D7C9C
	Offset: 0x3A0
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function end_on_timer(timer)
{
	self endon(#"disconnect");
	wait(timer);
	self notify(#"end_on_timer");
}

/*
	Name: rcbomb_earthquake
	Namespace: shellshock
	Checksum: 0xD7B66848
	Offset: 0x3E0
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function rcbomb_earthquake(position)
{
	playrumbleonposition("grenade_rumble", position);
	earthquake(0.5, 0.5, self.origin, 512);
}

/*
	Name: reset_meleesnd
	Namespace: shellshock
	Checksum: 0x5B4FC049
	Offset: 0x440
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function reset_meleesnd()
{
	self endon(#"death");
	wait(6);
	self clientfield::set_to_player("sndMelee", 0);
	self notify(#"snd_melee_end");
}

