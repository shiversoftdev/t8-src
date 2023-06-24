// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace gadget_cymbal_monkey;

/*
	Name: __init__system__
	Namespace: gadget_cymbal_monkey
	Checksum: 0x5EED4850
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"cymbal_monkey", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: gadget_cymbal_monkey
	Checksum: 0x6A4DDB87
	Offset: 0x110
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	level.var_7d95e1ed = [];
	level.var_7c5c96dc = &function_4f90c4c2;
	level thread function_a23699fe();
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: gadget_cymbal_monkey
	Checksum: 0x3286F94B
	Offset: 0x180
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](getweapon(#"cymbal_monkey"), &function_127fb8f3);
	}
}

/*
	Name: __main__
	Namespace: gadget_cymbal_monkey
	Checksum: 0xE4D4A6E4
	Offset: 0x1D8
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
}

/*
	Name: function_a23699fe
	Namespace: gadget_cymbal_monkey
	Checksum: 0x76A067E7
	Offset: 0x218
	Size: 0x140
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a23699fe()
{
	level endon(#"game_ended");
	var_cf4e80a7 = 250;
	while(true)
	{
		for(i = 0; i < level.var_7d95e1ed.size; i++)
		{
			monkey = level.var_7d95e1ed[i];
			if(!isdefined(monkey) || (isdefined(monkey.var_68005ac5) && monkey.var_68005ac5))
			{
				continue;
			}
			if(!isdefined(monkey.var_38af96b9))
			{
				monkey delete();
				continue;
			}
			if(function_7e60533f(monkey, var_cf4e80a7))
			{
				monkey thread function_b9934c1d();
			}
			waitframe(1);
		}
		level.var_7d95e1ed = array::remove_undefined(level.var_7d95e1ed);
		waitframe(1);
	}
}

/*
	Name: function_7e60533f
	Namespace: gadget_cymbal_monkey
	Checksum: 0x8755C9B3
	Offset: 0x360
	Size: 0x17A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7e60533f(monkey, radius)
{
	nearby_players = getentitiesinradius(monkey.origin, radius, 1);
	foreach(player in nearby_players)
	{
		if(function_17c51c94(monkey, player))
		{
			return true;
		}
	}
	var_b1de6a06 = getentitiesinradius(monkey.origin, radius, 15);
	foreach(actor in var_b1de6a06)
	{
		if(function_17c51c94(monkey, actor))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_17c51c94
	Namespace: gadget_cymbal_monkey
	Checksum: 0x76A2C3BA
	Offset: 0x4E8
	Size: 0x80
	Parameters: 2
	Flags: Linked, Private
*/
function private function_17c51c94(monkey, ent)
{
	if(!isdefined(ent))
	{
		return false;
	}
	if(isplayer(ent) || isactor(ent) && util::function_fbce7263(ent.team, monkey.team))
	{
		return true;
	}
	return false;
}

/*
	Name: function_4776caf4
	Namespace: gadget_cymbal_monkey
	Checksum: 0x53E28474
	Offset: 0x570
	Size: 0x244
	Parameters: 1
	Flags: Private, Event
*/
event private function_4776caf4(eventstruct)
{
	if(eventstruct.weapon.name == #"cymbal_monkey")
	{
		e_grenade = eventstruct.projectile;
		e_grenade ghost();
		e_grenade.angles = self.angles;
		var_bdd70f6a = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
		e_grenade.var_bdd70f6a = var_bdd70f6a;
		e_grenade.var_bdd70f6a linkto(e_grenade);
		e_grenade.var_bdd70f6a.var_38af96b9 = e_grenade;
		e_grenade.var_bdd70f6a.team = e_grenade.team;
		e_grenade.var_bdd70f6a clientfield::set("enemyequip", 1);
		e_grenade waittill(#"stationary", #"death");
		if(!isdefined(e_grenade) && isdefined(var_bdd70f6a))
		{
			var_bdd70f6a delete();
		}
		if(isdefined(self) && isdefined(e_grenade) && isdefined(e_grenade.var_bdd70f6a))
		{
			e_grenade.var_bdd70f6a.var_acdc8d71 = getclosestpointonnavmesh(e_grenade.var_bdd70f6a.origin, 360, 15.1875);
			array::add(level.var_7d95e1ed, e_grenade.var_bdd70f6a);
			self callback::callback(#"hash_3c09ead7e9d8a968", e_grenade.var_bdd70f6a);
		}
	}
}

/*
	Name: function_b9934c1d
	Namespace: gadget_cymbal_monkey
	Checksum: 0xBA240DDA
	Offset: 0x7C0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_b9934c1d()
{
	self endon(#"death");
	if(isdefined(level.var_2746aef8))
	{
		[[level.var_2746aef8]](self);
	}
	self.var_68005ac5 = 1;
	self playsound(#"hash_4509539f9e7954e2");
	playfxontag(level._effect[#"monkey_glow"], self, "tag_weapon");
	self thread scene::play(#"hash_2b352ec1d391daaa", self);
	self thread util::delay(6.5, "death", &function_4e61e1d);
	var_de3026af = gettime() + (int(8 * 1000));
	while(gettime() < var_de3026af)
	{
		if(!isdefined(self.var_38af96b9))
		{
			break;
		}
		waitframe(1);
	}
	self function_4f90c4c2();
}

/*
	Name: function_4e61e1d
	Namespace: gadget_cymbal_monkey
	Checksum: 0xF9B466BF
	Offset: 0x920
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_4e61e1d()
{
	self playsound(#"zmb_vox_monkey_explode");
}

/*
	Name: function_4f90c4c2
	Namespace: gadget_cymbal_monkey
	Checksum: 0x97373D5C
	Offset: 0x950
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_4f90c4c2()
{
	if(isdefined(self.var_38af96b9))
	{
		self callback::callback(#"hash_6aa0232dd3c8376a");
		playsoundatposition(#"wpn_claymore_alert", self.origin);
		self.var_38af96b9 detonate();
	}
	self delete();
}

/*
	Name: function_4a5dff80
	Namespace: gadget_cymbal_monkey
	Checksum: 0x77D4CAC8
	Offset: 0x9E8
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_4a5dff80(zombie)
{
	var_2d9e38fc = 360 * 360;
	var_128c12c9 = undefined;
	best_monkey = undefined;
	foreach(monkey in level.var_7d95e1ed)
	{
		if(!isdefined(monkey))
		{
			continue;
		}
		dist_sq = distancesquared(zombie.origin, monkey.origin);
		if(isdefined(monkey) && (isdefined(monkey.var_68005ac5) && monkey.var_68005ac5) && dist_sq < var_2d9e38fc)
		{
			if(!isdefined(var_128c12c9) || dist_sq < var_128c12c9)
			{
				var_128c12c9 = dist_sq;
				best_monkey = monkey;
			}
		}
	}
	return best_monkey;
}

/*
	Name: function_127fb8f3
	Namespace: gadget_cymbal_monkey
	Checksum: 0x79897743
	Offset: 0xB38
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_127fb8f3(cymbal_monkey, attackingplayer)
{
	cymbal_monkey endon(#"death");
	randangle = randomfloat(360);
	if(isdefined(level._equipment_emp_destroy_fx))
	{
		playfx(level._equipment_emp_destroy_fx, cymbal_monkey.origin + vectorscale((0, 0, 1), 5), (cos(randangle), sin(randangle), 0), anglestoup(cymbal_monkey.angles));
	}
	wait(1.1);
	playfx(#"hash_65c5042becfbaa7d", cymbal_monkey.origin);
	cymbal_monkey function_4f90c4c2();
}

