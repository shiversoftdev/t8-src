// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\globallogic\globallogic_score.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace collapsegrenade;

/*
	Name: __init__system__
	Namespace: collapsegrenade
	Checksum: 0xD1E50653
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"collapsegrenade", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: collapsegrenade
	Checksum: 0xAE1169A4
	Offset: 0x1A8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	weaponobjects::function_e6400478(#"eq_collapse_grenade", &function_41625261, 1);
	clientfield::register("scriptmover", "collapsesphereflag", 1, 1, "int");
	clientfield::register("toplayer", "playerincollapsegrenade", 1, 1, "int");
}

/*
	Name: function_41625261
	Namespace: collapsegrenade
	Checksum: 0x9A6E9510
	Offset: 0x250
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_41625261(watcher)
{
	watcher.onspawn = &function_5df80e43;
	watcher.ondamage = &on_damage;
}

/*
	Name: function_5df80e43
	Namespace: collapsegrenade
	Checksum: 0x67E26BC8
	Offset: 0x298
	Size: 0x3E4
	Parameters: 2
	Flags: Linked
*/
function function_5df80e43(watcher, player)
{
	self endon(#"death");
	grenade = self;
	grenade waittill(#"stationary");
	grenade setcandamage(1);
	grenade.maxhealth = 10000;
	grenade.health = grenade.maxhealth;
	grenade setmaxhealth(grenade.maxhealth);
	var_5ff47c38 = spawn("script_model", grenade.origin);
	var_5ff47c38 setmodel(#"p8_big_sphere");
	var_5ff47c38 setscale(0.0225);
	var_5ff47c38 linkto(grenade);
	var_5ff47c38 clientfield::set("collapsesphereflag", 1);
	grenade thread function_adc9aab9(var_5ff47c38);
	var_80994c8c = 225 * 225;
	grenade_weapon = getweapon(#"eq_collapse_grenade");
	var_f4d9a132 = gettime() + 1000;
	while(true)
	{
		time = gettime();
		a_players = getplayers();
		foreach(player in a_players)
		{
			eye_pos = player gettagorigin("tag_eye");
			if(!(isdefined(player.outsidedeathcircle) && player.outsidedeathcircle) && distancesquared(eye_pos, grenade.origin) <= var_80994c8c)
			{
				if(!isdefined(player.var_fd6d6c7b) || player.var_fd6d6c7b != var_5ff47c38)
				{
					player clientfield::set_to_player("playerincollapsegrenade", 1);
				}
				player.var_fd6d6c7b = var_5ff47c38;
				if(time >= var_f4d9a132)
				{
					player dodamage(5, grenade.origin, grenade.owner, grenade, undefined, "MOD_DEATH_CIRCLE", 0, grenade_weapon);
				}
				continue;
			}
			if(isdefined(player.var_fd6d6c7b) && player.var_fd6d6c7b == var_5ff47c38)
			{
				player.var_fd6d6c7b = undefined;
				player clientfield::set_to_player("playerincollapsegrenade", 0);
			}
		}
		if(time >= var_f4d9a132)
		{
			var_f4d9a132 = gettime() + 1000;
		}
		waitframe(1);
	}
}

/*
	Name: function_adc9aab9
	Namespace: collapsegrenade
	Checksum: 0x16DC28CA
	Offset: 0x688
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_adc9aab9(var_5ff47c38)
{
	self waittill(#"explode", #"death");
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(isdefined(player.var_fd6d6c7b) && player.var_fd6d6c7b == var_5ff47c38)
		{
			player.var_fd6d6c7b = undefined;
			player clientfield::set_to_player("playerincollapsegrenade", 0);
		}
	}
	var_5ff47c38 delete();
}

/*
	Name: on_damage
	Namespace: collapsegrenade
	Checksum: 0xF594F8C5
	Offset: 0x7A8
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function on_damage(watcher)
{
	self endon(#"death");
	damagemax = 50;
	self.damagetaken = 0;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		damage = waitresult.amount;
		type = waitresult.mod;
		weapon = waitresult.weapon;
		if(!isdefined(self.damagetaken))
		{
			self.damagetaken = 0;
		}
		attacker = self [[level.figure_out_attacker]](waitresult.attacker);
		damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
		if(type == "MOD_MELEE" || type == "MOD_MELEE_WEAPON_BUTT" || weapon.isemp || weapon.destroysequipment)
		{
			self.damagetaken = damagemax;
		}
		else
		{
			self.damagetaken = self.damagetaken + damage;
		}
		if(self.damagetaken >= damagemax)
		{
			self detonate();
			return;
		}
	}
}

