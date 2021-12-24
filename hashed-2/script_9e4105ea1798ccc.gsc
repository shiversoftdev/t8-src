// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_256b8879317373de;
#using script_35598499769dbb3d;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_armor;

/*
	Name: function_89f2df9
	Namespace: zm_armor
	Checksum: 0x612BEAED
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_armor", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_armor
	Checksum: 0x2C64099D
	Offset: 0x120
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_connect);
}

/*
	Name: on_connect
	Namespace: zm_armor
	Checksum: 0x812B01DA
	Offset: 0x150
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self thread function_49f4b6ee();
}

/*
	Name: register
	Namespace: zm_armor
	Checksum: 0x3286EF6E
	Offset: 0x178
	Size: 0xA6
	Parameters: 2
	Flags: Linked
*/
function register(var_7c8fcded, is_permanent = 1)
{
	if(!isdefined(level.var_9555ebfb))
	{
		level.var_9555ebfb = [];
	}
	else if(!isarray(level.var_9555ebfb))
	{
		level.var_9555ebfb = array(level.var_9555ebfb);
	}
	level.var_9555ebfb[var_7c8fcded] = is_permanent;
}

/*
	Name: function_49f4b6ee
	Namespace: zm_armor
	Checksum: 0xA84B8BB8
	Offset: 0x228
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function function_49f4b6ee()
{
	self.var_9555ebfb = [];
	a_keys = getarraykeys(level.var_9555ebfb);
	foreach(key in a_keys)
	{
		if(level.var_9555ebfb[key])
		{
			self.var_9555ebfb[key] = 0;
		}
	}
	foreach(key in a_keys)
	{
		if(!level.var_9555ebfb[key])
		{
			self.var_9555ebfb[key] = 0;
		}
	}
}

/*
	Name: add
	Namespace: zm_armor
	Checksum: 0xD4AE85D9
	Offset: 0x368
	Size: 0x13E
	Parameters: 4
	Flags: Linked
*/
function add(var_7c8fcded, var_3ed63752, var_28066539, var_df7ee5d1 = #"hash_2082da6662372184")
{
	var_4812bba2 = 0;
	if(isdefined(var_28066539))
	{
		var_d7de78d3 = var_28066539 - self get(var_7c8fcded);
		if(var_3ed63752 <= var_d7de78d3)
		{
			self.armor = self.armor + var_3ed63752;
			var_4812bba2 = var_3ed63752;
		}
		else
		{
			self.armor = self.armor + var_d7de78d3;
			var_4812bba2 = var_d7de78d3;
		}
	}
	else
	{
		self.armor = self.armor + var_3ed63752;
		var_4812bba2 = var_3ed63752;
	}
	if(var_4812bba2 > 0)
	{
		self playsound(var_df7ee5d1);
	}
	var_4812bba2 = var_4812bba2 + self get(var_7c8fcded);
	self.var_9555ebfb[var_7c8fcded] = var_4812bba2;
}

/*
	Name: remove
	Namespace: zm_armor
	Checksum: 0xDEACFF90
	Offset: 0x4B0
	Size: 0x1DE
	Parameters: 2
	Flags: Linked
*/
function remove(var_7c8fcded, var_2cd89ceb = 0)
{
	if(isdefined(self.var_9555ebfb[var_7c8fcded]) && self.var_9555ebfb[var_7c8fcded] > 0)
	{
		if(var_2cd89ceb)
		{
			self.armor = self.armor - self.var_9555ebfb[var_7c8fcded];
			a_keys = getarraykeys(level.var_9555ebfb);
			var_d42adc5 = 0;
			foreach(key in a_keys)
			{
				if(key !== var_7c8fcded && (level.var_9555ebfb[key] || (isdefined(self.var_bacee63b) && self.var_bacee63b && key == #"hash_5c9caf0397b30f1e")))
				{
					var_d42adc5 = var_d42adc5 + get(key);
				}
			}
			var_d42adc5 = min(var_d42adc5, 100);
			self.armor = int(max(var_d42adc5, self.armor));
		}
		self.var_9555ebfb[var_7c8fcded] = 0;
	}
}

/*
	Name: get
	Namespace: zm_armor
	Checksum: 0xC77D5107
	Offset: 0x698
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function get(var_7c8fcded)
{
	if(isdefined(self.var_9555ebfb[var_7c8fcded]))
	{
		return self.var_9555ebfb[var_7c8fcded];
	}
	return 0;
}

/*
	Name: damage
	Namespace: zm_armor
	Checksum: 0x637FCE26
	Offset: 0x6D0
	Size: 0x310
	Parameters: 3
	Flags: Linked
*/
function damage(n_damage, mod_type, e_attacker)
{
	if(self.armor <= 0)
	{
		return n_damage;
	}
	var_ee47fd1b = int(self.armor * 2);
	a_keys = getarraykeys(self.var_9555ebfb);
	if(n_damage > var_ee47fd1b)
	{
		foreach(key in a_keys)
		{
			self remove(key, 1);
		}
		self.armor = 0;
		self playsound(#"hash_2817ca3f96127e62");
		return n_damage - var_ee47fd1b;
	}
	if(n_damage > 0)
	{
		var_ee47fd1b = int(max(1, n_damage / 2));
	}
	else
	{
		var_ee47fd1b = 0;
	}
	self.armor = self.armor - var_ee47fd1b;
	var_c5aebd9f = 0;
	n_index = 0;
	while(var_c5aebd9f < var_ee47fd1b && n_index < a_keys.size)
	{
		var_b12ac727 = a_keys[n_index];
		var_2a0d4230 = self get(var_b12ac727);
		if(var_2a0d4230 > var_ee47fd1b)
		{
			var_34ada56f = var_2a0d4230 - (var_ee47fd1b - var_c5aebd9f);
			self.var_9555ebfb[var_b12ac727] = var_34ada56f;
			var_c5aebd9f = var_c5aebd9f + var_ee47fd1b;
			n_index++;
		}
		else if(var_2a0d4230 > 0)
		{
			var_c5aebd9f = var_c5aebd9f + var_2a0d4230;
			self remove(var_b12ac727);
			if(self.armor <= 0)
			{
				self playsound(#"hash_2817ca3f96127e62");
			}
			n_index++;
		}
		else
		{
			n_index++;
		}
	}
	self notify(#"damage_armor", {#attacker:e_attacker, #mod:mod_type});
	return 0;
}

