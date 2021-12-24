// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_399c912938783695;
#using scripts\core_common\util_shared.gsc;

#namespace zm_inventory;

/*
	Name: function_cb96f01d
	Namespace: zm_inventory
	Checksum: 0x69529CB5
	Offset: 0x1E8
	Size: 0xEA
	Parameters: 4
	Flags: Linked, Private
*/
private function function_cb96f01d(mappingname, var_3e666f2f, numbits, var_7f12f171)
{
	if(!isdefined(level.var_a16c38d9[mappingname]))
	{
		level.var_a16c38d9[mappingname] = spawnstruct();
	}
	if(isdefined(var_7f12f171) && var_7f12f171)
	{
		var_3e666f2f = "ZMInventoryPersonal." + var_3e666f2f;
	}
	else
	{
		var_3e666f2f = "ZMInventory." + var_3e666f2f;
	}
	level.var_a16c38d9[mappingname].var_cd35dfb2 = var_3e666f2f;
	level.var_a16c38d9[mappingname].numbits = numbits;
	level.var_a16c38d9[mappingname].var_7f12f171 = var_7f12f171;
}

/*
	Name: function_c7c05a13
	Namespace: zm_inventory
	Checksum: 0xB29280DB
	Offset: 0x2E0
	Size: 0x810
	Parameters: 0
	Flags: Linked
*/
function function_c7c05a13()
{
	level.var_a16c38d9 = [];
	fields = namespace_cb7cafc3::function_10672567();
	if(!isdefined(fields) || !isdefined(fields.zm_inventory))
	{
		return;
	}
	var_21249230 = getscriptbundle(fields.zm_inventory);
	level.var_a16c38d9 = [];
	if(isdefined(var_21249230.challenges) && isdefined(var_21249230.var_5a90928f))
	{
		function_cb96f01d(var_21249230.var_5a90928f, "ChallengesInfo.stage", 5, 1);
		if(isdefined(var_21249230.var_f7d932ea))
		{
			function_cb96f01d(var_21249230.var_f7d932ea, "ChallengesInfo.currentProgress", 7, 1);
		}
		if(isdefined(var_21249230.var_c53f31a1))
		{
			function_cb96f01d(var_21249230.var_c53f31a1, "ChallengesInfo.numNeeded", 7, 1);
		}
	}
	if(isdefined(var_21249230.var_48fdfb9a) && isdefined(var_21249230.var_88c17f11))
	{
		function_cb96f01d(var_21249230.var_88c17f11, "ObjProgInfo.Eye.stage", 2, var_21249230.var_f3d39d90);
	}
	if(isdefined(var_21249230.var_38b9613) && var_21249230.var_38b9613)
	{
		if(isdefined(var_21249230.var_ffb8d676))
		{
			for(i = 0; i < var_21249230.var_ffb8d676.size; i++)
			{
				item = var_21249230.var_ffb8d676[i];
				if(isdefined(item.var_846fa8e))
				{
					clientfield = ("ObjProgInfo.NonlinearObjProgRingItemInfos." + (i + 1)) + ".earned";
					function_cb96f01d(item.var_846fa8e, clientfield, 1, var_21249230.var_f3d39d90);
				}
			}
		}
	}
	else if(isdefined(var_21249230.var_f4dc6a81) && isdefined(var_21249230.var_846fa8e))
	{
		function_cb96f01d(var_21249230.var_846fa8e, "ObjProgInfo.Ring.stage", 4, var_21249230.var_f3d39d90);
	}
	if(isdefined(var_21249230.var_207c2ef6))
	{
		for(i = 0; i < var_21249230.var_207c2ef6.size; i++)
		{
			item = var_21249230.var_207c2ef6[i];
			if(isdefined(item.clientfield))
			{
				clientfield = ("PaPItems." + (i + 1)) + ".stage";
				function_cb96f01d(item.clientfield, clientfield, 2, item.var_7db3435c);
			}
		}
	}
	if(isdefined(var_21249230.var_50cf6c21))
	{
		if(isdefined(var_21249230.var_b10f2611))
		{
			function_cb96f01d(var_21249230.var_b10f2611, "WonderWeaponPhaseInfo.phase", 2, var_21249230.var_3e38620e);
		}
		var_867e2c15 = -1;
		var_b3aac704 = -1;
		index = 1;
		for(p = 0; p < var_21249230.var_50cf6c21.size; p++)
		{
			phase = var_21249230.var_50cf6c21[p];
			for(c = 0; c < phase.components.size; c++)
			{
				component = phase.components[c];
				if(isdefined(component.clientfield))
				{
					var_2641997d = ("WonderWeaponItems." + index) + ".stage";
					function_cb96f01d(component.clientfield, var_2641997d, 3, component.var_7db3435c);
				}
				if(isdefined(component.var_9f618001))
				{
					var_9f618001 = ("WonderWeaponItems." + index) + ".numAcquired";
					function_cb96f01d(component.var_9f618001, var_9f618001, 2, component.var_7db3435c);
				}
				index++;
			}
		}
	}
	if(isdefined(var_21249230.shieldpieces))
	{
		for(p = 0; p < var_21249230.shieldpieces.size; p++)
		{
			if(isdefined(var_21249230.shieldpieces[p].clientfield))
			{
				clientfield = ("ShieldPieces." + (p + 1)) + ".stage";
				function_cb96f01d(var_21249230.shieldpieces[p].clientfield, clientfield, 1, var_21249230.shieldpieces[p].var_7db3435c);
			}
		}
	}
	if(isdefined(var_21249230.quests))
	{
		for(q = 0; q < var_21249230.quests.size; q++)
		{
			quest = var_21249230.quests[q];
			if(isdefined(quest.var_a0ebe517))
			{
				var_e7e5896d = ("QuestPhaseInfos." + (q + 1)) + ".phase";
				function_cb96f01d(var_21249230.quests[q].var_a0ebe517, var_e7e5896d, 2, var_21249230.quests[q].var_7db3435c);
			}
			var_d4cb13fd = "Quest" + (q + 1);
			index = 1;
			for(p = 0; p < quest.phases.size; p++)
			{
				phase = quest.phases[p];
				for(i = 0; i < phase.items.size; i++)
				{
					if(isdefined(phase.items[i].clientfield))
					{
						var_2641997d = ((var_d4cb13fd + ".") + index) + ".stage";
						function_cb96f01d(phase.items[i].clientfield, var_2641997d, 2, phase.items[i].var_7db3435c);
					}
					index++;
				}
			}
		}
	}
}

