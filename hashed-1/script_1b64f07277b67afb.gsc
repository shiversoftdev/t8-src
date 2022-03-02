// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16c1c22ee40ef52f;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;

#namespace archetype_human_rpg;

/*
	Name: main
	Namespace: archetype_human_rpg
	Checksum: 0x48767C17
	Offset: 0x98
	Size: 0x84
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	spawner::add_archetype_spawn_function(#"human_rpg", &humanrpgbehavior::archetypehumanrpgblackboardinit);
	spawner::add_archetype_spawn_function(#"human", &humanrpgbehavior::function_daf99f58);
	humanrpgbehavior::registerbehaviorscriptfunctions();
	humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: humanrpgbehavior
	Checksum: 0x80F724D1
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
}

/*
	Name: archetypehumanrpgblackboardinit
	Namespace: humanrpgbehavior
	Checksum: 0xE6D4962A
	Offset: 0x138
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private archetypehumanrpgblackboardinit()
{
	entity = self;
	blackboard::createblackboardforentity(entity);
	ai::createinterfaceforentity(entity);
	self.___archetypeonanimscriptedcallback = &archetypehumanrpgonanimscriptedcallback;
	entity asmchangeanimmappingtable(1);
}

/*
	Name: archetypehumanrpgonanimscriptedcallback
	Namespace: humanrpgbehavior
	Checksum: 0x4633EE61
	Offset: 0x1B0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private archetypehumanrpgonanimscriptedcallback(entity)
{
	entity.__blackboard = undefined;
	entity archetypehumanrpgblackboardinit();
}

/*
	Name: function_daf99f58
	Namespace: humanrpgbehavior
	Checksum: 0x5AB0DC9E
	Offset: 0x1E8
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
function private function_daf99f58()
{
	if(self.var_9fde8624 === #"human_rpg")
	{
		self.var_b3aacd00 = getweapon(#"hash_3b5610f58856b4ea");
		self.var_2fcec084 = getweapon(#"hash_1d8ec79043d16eb");
		self.var_b999a026 = 0;
		self thread function_567e5a33();
	}
}

/*
	Name: function_567e5a33
	Namespace: humanrpgbehavior
	Checksum: 0xF8BB3F77
	Offset: 0x288
	Size: 0x218
	Parameters: 0
	Flags: Linked, Private
*/
function private function_567e5a33()
{
	self endon(#"death");
	self ai::gun_remove();
	self ai::gun_switchto(self.var_b3aacd00, "right");
	while(self.weapon !== self.var_b3aacd00)
	{
		waitframe(1);
	}
	while(isalive(self))
	{
		var_70a33a38 = self ai::function_63734291(self.enemy);
		if(isdefined(var_70a33a38) && var_70a33a38 && (!(isdefined(self.var_b999a026) && self.var_b999a026)))
		{
			self ai::gun_remove();
			self ai::gun_switchto(self.var_2fcec084, "right");
			while(self.weapon !== self.var_2fcec084)
			{
				waitframe(1);
			}
			self.var_b999a026 = 1;
			self waittill(#"weapon_fired", #"enemy", #"missile_fire");
		}
		if(!(isdefined(var_70a33a38) && var_70a33a38) && (isdefined(self.var_b999a026) && self.var_b999a026))
		{
			self ai::gun_remove();
			self ai::gun_switchto(self.var_b3aacd00, "right");
			while(self.weapon !== self.var_b3aacd00)
			{
				waitframe(1);
			}
			self.var_b999a026 = 0;
		}
		waitframe(1);
	}
}

