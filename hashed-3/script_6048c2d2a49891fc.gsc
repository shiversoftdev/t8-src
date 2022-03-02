// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_63e7f3a1;

/*
	Name: function_89f2df9
	Namespace: namespace_63e7f3a1
	Checksum: 0x3DFA1235
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_74496e1b656c6651", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_63e7f3a1
	Checksum: 0x674B0EE8
	Offset: 0xF0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_74496e1b656c6651", "time", 60, &enable, &disable, undefined, undefined);
	zm_player::register_player_damage_callback(&function_4b163259);
}

/*
	Name: enable
	Namespace: namespace_63e7f3a1
	Checksum: 0xBCE77DE8
	Offset: 0x190
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	if(zm_utility::is_standard())
	{
		self.var_d3df5e76 = array(2000);
	}
	else
	{
		self.var_d3df5e76 = array(50, 100, 250, 500);
	}
	self.var_7ad1482b = 1;
}

/*
	Name: disable
	Namespace: namespace_63e7f3a1
	Checksum: 0x448D6D6E
	Offset: 0x240
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self.var_d3df5e76 = undefined;
	self.var_7ad1482b = undefined;
}

/*
	Name: function_4b163259
	Namespace: namespace_63e7f3a1
	Checksum: 0x1C0AFC22
	Offset: 0x260
	Size: 0x196
	Parameters: 10
	Flags: Linked
*/
function function_4b163259(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(bgb::is_enabled(#"hash_74496e1b656c6651") && (!(isdefined(self.var_dad8bef6) && self.var_dad8bef6)))
	{
		if(idamage > 0)
		{
			if(self.var_d3df5e76.size > 1)
			{
				n_cost = self.var_d3df5e76[0];
			}
			else
			{
				n_cost = self.var_d3df5e76[0] * self.var_7ad1482b;
				self.var_7ad1482b++;
			}
			if(self zm_score::can_player_purchase(n_cost, 1))
			{
				self function_c5d307a1(n_cost);
				return 0;
			}
			n_cost = zm_score::function_ffc2d0bc();
			if(n_cost == 0)
			{
				n_damage = idamage;
			}
			else
			{
				self function_c5d307a1(n_cost);
				n_damage = 0;
			}
			self bgb::take();
			return n_damage;
		}
	}
	return -1;
}

/*
	Name: function_c5d307a1
	Namespace: namespace_63e7f3a1
	Checksum: 0x2C2F73C4
	Offset: 0x400
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function function_c5d307a1(n_cost)
{
	self zm_score::minus_to_player_score(n_cost, 1);
	if(self.var_d3df5e76.size > 1)
	{
		self.var_d3df5e76 = array::remove_index(self.var_d3df5e76, 0);
	}
}

