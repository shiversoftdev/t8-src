// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace explode;

/*
	Name: function_89f2df9
	Namespace: explode
	Checksum: 0x3EC05320
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"explode", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: explode
	Checksum: 0xD34D549A
	Offset: 0x100
	Size: 0xCC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level.dirt_enable_explosion = getdvarint(#"scr_dirt_enable_explosion", 1);
	level.dirt_enable_slide = getdvarint(#"scr_dirt_enable_slide", 1);
	level.dirt_enable_fall_damage = getdvarint(#"scr_dirt_enable_fall_damage", 1);
	callback::on_localplayer_spawned(&localplayer_spawned);
	/#
		level thread updatedvars();
	#/
}

/*
	Name: updatedvars
	Namespace: explode
	Checksum: 0x6CB0267D
	Offset: 0x1D8
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function updatedvars()
{
	/#
		while(true)
		{
			level.dirt_enable_explosion = getdvarint(#"scr_dirt_enable_explosion", level.dirt_enable_explosion);
			level.dirt_enable_slide = getdvarint(#"scr_dirt_enable_slide", level.dirt_enable_slide);
			level.dirt_enable_fall_damage = getdvarint(#"scr_dirt_enable_fall_damage", level.dirt_enable_fall_damage);
			wait(1);
		}
	#/
}

/*
	Name: localplayer_spawned
	Namespace: explode
	Checksum: 0xDD4C94E3
	Offset: 0x2A8
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function localplayer_spawned(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	if(level.dirt_enable_explosion || level.dirt_enable_slide || level.dirt_enable_fall_damage)
	{
		filter::init_filter_sprite_dirt(self);
		filter::disable_filter_sprite_dirt(self, 5);
		if(level.dirt_enable_explosion)
		{
			self thread watchforexplosion(localclientnum);
		}
		if(level.dirt_enable_slide)
		{
			self thread watchforplayerslide(localclientnum);
		}
		if(level.dirt_enable_fall_damage)
		{
			self thread watchforplayerfalldamage(localclientnum);
		}
	}
}

/*
	Name: watchforplayerfalldamage
	Namespace: explode
	Checksum: 0x125B73C0
	Offset: 0x3B0
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function watchforplayerfalldamage(localclientnum)
{
	self endon(#"death");
	seed = 0;
	xdir = 0;
	ydir = 270;
	while(true)
	{
		self waittill(#"fall_damage");
		self thread dothedirty(localclientnum, xdir, ydir, 1, 1000, 500);
	}
}

/*
	Name: watchforplayerslide
	Namespace: explode
	Checksum: 0x65397AF9
	Offset: 0x460
	Size: 0x1CC
	Parameters: 1
	Flags: None
*/
function watchforplayerslide(localclientnum)
{
	self endon(#"death");
	seed = 0;
	self.wasplayersliding = 0;
	xdir = 0;
	ydir = 6000;
	while(true)
	{
		self.isplayersliding = self isplayersliding();
		if(self.isplayersliding)
		{
			if(!self.wasplayersliding)
			{
				self notify(#"endthedirty");
				seed = randomfloatrange(0, 1);
			}
			filter::set_filter_sprite_dirt_opacity(self, 5, 1);
			filter::set_filter_sprite_dirt_seed_offset(self, 5, seed);
			filter::enable_filter_sprite_dirt(self, 5);
			filter::set_filter_sprite_dirt_source_position(self, 5, xdir, ydir, 1);
			filter::set_filter_sprite_dirt_elapsed(self, 5, getservertime(localclientnum));
		}
		else if(self.wasplayersliding)
		{
			self thread dothedirty(localclientnum, xdir, ydir, 1, 300, 300);
		}
		self.wasplayersliding = self.isplayersliding;
		waitframe(1);
	}
}

/*
	Name: dothedirty
	Namespace: explode
	Checksum: 0xF1165D68
	Offset: 0x638
	Size: 0x124
	Parameters: 6
	Flags: None
*/
function dothedirty(localclientnum, right, up, distance, dirtduration, dirtfadetime)
{
	self endon(#"death");
	self notify(#"dothedirty");
	self endon(#"dothedirty");
	self endon(#"endthedirty");
	filter::enable_filter_sprite_dirt(self, 5);
	filter::set_filter_sprite_dirt_seed_offset(self, 5, randomfloatrange(0, 1));
	util::lerp_generic(localclientnum, dirtduration, &do_the_dirty_lerp_helper, right, up, distance, dirtfadetime);
	filter::disable_filter_sprite_dirt(self, 5);
}

/*
	Name: do_the_dirty_lerp_helper
	Namespace: explode
	Checksum: 0xFCD099EC
	Offset: 0x768
	Size: 0xDC
	Parameters: 8
	Flags: None
*/
function do_the_dirty_lerp_helper(currenttime, elapsedtime, localclientnum, dirtduration, right, up, distance, dirtfadetime)
{
	if(elapsedtime > dirtduration - dirtfadetime)
	{
		filter::set_filter_sprite_dirt_opacity(self, 5, (dirtduration - elapsedtime) / dirtfadetime);
	}
	else
	{
		filter::set_filter_sprite_dirt_opacity(self, 5, 1);
	}
	filter::set_filter_sprite_dirt_source_position(self, 5, right, up, distance);
	filter::set_filter_sprite_dirt_elapsed(self, 5, currenttime);
}

/*
	Name: watchforexplosion
	Namespace: explode
	Checksum: 0xD6D4CD62
	Offset: 0x850
	Size: 0x3A0
	Parameters: 1
	Flags: None
*/
function watchforexplosion(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"explode");
		mod = waitresult.mod;
		position = waitresult.position;
		localclientnum = waitresult.localclientnum;
		explosiondistance = distance(self.origin, position);
		if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH" && explosiondistance < 600 && !function_1cbf351b(localclientnum) && !isthirdperson(localclientnum))
		{
			cameraangles = self getcamangles();
			if(!isdefined(cameraangles))
			{
				continue;
			}
			forwardvec = vectornormalize(anglestoforward(cameraangles));
			upvec = vectornormalize(anglestoup(cameraangles));
			rightvec = vectornormalize(anglestoright(cameraangles));
			explosionvec = vectornormalize(position - self getcampos());
			if(vectordot(forwardvec, explosionvec) > 0)
			{
				trace = bullettrace(getlocalclienteyepos(localclientnum), position, 0, self);
				if(trace[#"fraction"] >= 0.9)
				{
					udot = -1 * vectordot(explosionvec, upvec);
					rdot = vectordot(explosionvec, rightvec);
					udotabs = abs(udot);
					rdotabs = abs(rdot);
					if(udotabs > rdotabs)
					{
						if(udot > 0)
						{
							udot = 1;
						}
						else
						{
							udot = -1;
						}
					}
					else
					{
						if(rdot > 0)
						{
							rdot = 1;
						}
						else
						{
							rdot = -1;
						}
					}
					self thread dothedirty(localclientnum, rdot, udot, 1 - (explosiondistance / 600), 2000, 500);
				}
			}
		}
	}
}

