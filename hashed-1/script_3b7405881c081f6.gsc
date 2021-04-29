// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_366ff0bb9cb7adb1;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_87f62ea8;

/*
	Name: function_23cbc6c1
	Namespace: namespace_87f62ea8
	Checksum: 0x5C703F81
	Offset: 0xB8
	Size: 0x1B2
	Parameters: 4
	Flags: Linked
*/
function function_23cbc6c1(goal, b_force = 0, n_radius, n_height)
{
	/#
		assert(isbot(self), "" + "");
	#/
	/#
		assert(isdefined(goal), "" + "");
	#/
	if(!isbot(self) || !isdefined(goal))
	{
		return;
	}
	self ai::set_behavior_attribute("control", "autonomous");
	if(self bot_chain::function_58b429fb())
	{
		self bot_chain::function_73d1cfe6();
	}
	if(isdefined(n_radius))
	{
		if(isdefined(n_height))
		{
			self setgoal(goal, b_force, n_radius, n_height);
		}
		else
		{
			self setgoal(goal, b_force, n_radius);
		}
	}
	else
	{
		self setgoal(goal, b_force);
	}
	self.bot.var_bd883a25 = goal;
	self.bot.var_4e3a654 = b_force;
}

/*
	Name: function_33834a13
	Namespace: namespace_87f62ea8
	Checksum: 0x63106721
	Offset: 0x278
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_33834a13()
{
	/#
		assert(isbot(self), "" + "");
	#/
	if(!isbot(self) || !isdefined(self.bot.var_bd883a25))
	{
		return;
	}
	self clearforcedgoal();
	self ai::set_behavior_attribute("control", "commander");
	self.bot.var_bd883a25 = undefined;
	self.bot.var_4e3a654 = undefined;
}

/*
	Name: function_e449b57
	Namespace: namespace_87f62ea8
	Checksum: 0x3E140912
	Offset: 0x358
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_e449b57(gameobject)
{
	/#
		assert(isbot(self), "" + "");
	#/
	/#
		assert(isdefined(gameobject), "" + "");
	#/
	if(!isbot(self) || !isdefined(gameobject))
	{
		return;
	}
	self bot::function_7a6eea9c(gameobject);
}

/*
	Name: function_cf70f2fe
	Namespace: namespace_87f62ea8
	Checksum: 0xD3CFD6D4
	Offset: 0x420
	Size: 0x2C4
	Parameters: 1
	Flags: None
*/
function function_cf70f2fe(startstruct)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	self notify(#"hash_5efbaef0ca9e2136");
	self endon(#"hash_5efbaef0ca9e2136");
	/#
		assert(isbot(self), "" + "");
	#/
	/#
		assert(isstruct(startstruct) || isstring(startstruct), "" + "");
	#/
	if(isstring(startstruct))
	{
		/#
			assert(isdefined(struct::get(startstruct)), "" + "" + startstruct);
		#/
	}
	if(!isbot(self))
	{
		return;
	}
	if(!isstruct(startstruct) && !isstring(startstruct))
	{
		return;
	}
	if(isstring(startstruct) && !isdefined(struct::get(startstruct)))
	{
		return;
	}
	if(self bot_chain::function_58b429fb())
	{
		self bot_chain::function_73d1cfe6();
	}
	self.bot.var_bd883a25 = undefined;
	self.bot.var_4e3a654 = undefined;
	self ai::set_behavior_attribute("control", "autonomous");
	self thread bot_chain::function_cf70f2fe(startstruct);
	while(self bot_chain::function_58b429fb())
	{
		self waittill(#"hash_382a628dad5ecbb5");
	}
	if(!isdefined(self.bot.var_bd883a25))
	{
		self ai::set_behavior_attribute("control", "commander");
	}
}

/*
	Name: function_f89d0427
	Namespace: namespace_87f62ea8
	Checksum: 0x3D4C01D3
	Offset: 0x6F0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_f89d0427()
{
	if(!self bot_chain::function_58b429fb())
	{
		return;
	}
	self bot_chain::function_73d1cfe6();
}

/*
	Name: function_cae2c3ac
	Namespace: namespace_87f62ea8
	Checksum: 0x9ADBB26E
	Offset: 0x730
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_cae2c3ac()
{
	self bot_action::function_ee2eaccc(0);
}

/*
	Name: function_de6c5bcb
	Namespace: namespace_87f62ea8
	Checksum: 0xB51814F1
	Offset: 0x758
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_de6c5bcb()
{
	self bot_action::function_ee2eaccc(1);
}

/*
	Name: function_f1f5be0f
	Namespace: namespace_87f62ea8
	Checksum: 0xE076CFBB
	Offset: 0x780
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_f1f5be0f()
{
	self bot_action::function_ee2eaccc(2);
}

