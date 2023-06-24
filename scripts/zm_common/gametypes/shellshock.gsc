// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;

#namespace shellshock;

/*
	Name: __init__system__
	Namespace: shellshock
	Checksum: 0xC075584D
	Offset: 0x100
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
	Checksum: 0x9B9DD0A9
	Offset: 0x148
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&main);
	level.shellshockonplayerdamage = &on_damage;
}

/*
	Name: main
	Namespace: shellshock
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main()
{
}

/*
	Name: on_damage
	Namespace: shellshock
	Checksum: 0x74AB782E
	Offset: 0x1A0
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function on_damage(cause, damage, weapon)
{
	if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH")
	{
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
			if(self util::mayapplyscreeneffect())
			{
				self shellshock(#"frag_grenade_mp", 0.5);
			}
		}
	}
}

/*
	Name: endondeath
	Namespace: shellshock
	Checksum: 0x4D905FEC
	Offset: 0x2D8
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function endondeath()
{
	self waittill(#"death");
	waittillframeend();
	self notify(#"end_explode");
}

/*
	Name: endontimer
	Namespace: shellshock
	Checksum: 0x5F5B8CA0
	Offset: 0x310
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function endontimer(timer)
{
	self endon(#"disconnect");
	wait(timer);
	self notify(#"end_on_timer");
}

/*
	Name: rcbomb_earthquake
	Namespace: shellshock
	Checksum: 0x922DB713
	Offset: 0x350
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function rcbomb_earthquake(position)
{
	playrumbleonposition("grenade_rumble", position);
	earthquake(0.5, 0.5, self.origin, 512);
}

