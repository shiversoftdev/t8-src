// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_64ac23dbb2d7d587;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_c4d6fb7;

/*
	Name: function_89f2df9
	Namespace: namespace_c4d6fb7
	Checksum: 0xF67C583C
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_50750492a887f8e7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c4d6fb7
	Checksum: 0xA755F67B
	Offset: 0x100
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	renderoverridebundle::function_f72f089c(#"hash_f5de00feee70c13", (sessionmodeiscampaigngame() ? #"hash_461520942fd1154d" : #"rob_sonar_set_friendlyequip_mp"), &function_8550d243);
	renderoverridebundle::function_f72f089c(#"hash_77f7418d2f2a7890", #"rob_sonar_set_enemyequip", &function_62888a11);
	renderoverridebundle::function_f72f089c(#"hash_61c696df3d5a1765", #"hash_44adc567f9f60d61", &function_b52a94e5);
	callback::on_localplayer_spawned(&on_localplayer_spawned);
}

/*
	Name: on_localplayer_spawned
	Namespace: namespace_c4d6fb7
	Checksum: 0x2418EDB8
	Offset: 0x210
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function on_localplayer_spawned(localclientnum)
{
	if(self function_21c0fa55())
	{
		self thread function_7800b9c2(localclientnum);
	}
}

/*
	Name: function_e446e567
	Namespace: namespace_c4d6fb7
	Checksum: 0x5E4382C6
	Offset: 0x258
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_e446e567(notifyhash)
{
	if(!isdefined(self.var_100abb43) || !isarray(self.var_100abb43))
	{
		return;
	}
	foreach(item in self.var_100abb43)
	{
		if(isdefined(item))
		{
			item.var_f19b4afd = undefined;
		}
	}
}

/*
	Name: function_7800b9c2
	Namespace: namespace_c4d6fb7
	Checksum: 0x79CEA8ED
	Offset: 0x310
	Size: 0x380
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7800b9c2(localclientnum)
{
	level endon(#"game_ended");
	self endon_callback(&function_e446e567, #"death");
	if(!isdefined(self.var_100abb43))
	{
		self.var_100abb43 = [];
	}
	while(true)
	{
		var_94c264dd = self hasperk(localclientnum, #"specialty_showenemyequipment");
		if(!var_94c264dd && isdefined(self.var_53204996))
		{
			var_94c264dd = var_94c264dd | self [[self.var_53204996]](localclientnum);
		}
		if(!var_94c264dd && self.var_100abb43.size == 0)
		{
			wait(0.2);
			continue;
		}
		var_5ef114b0 = [];
		if(var_94c264dd)
		{
			var_7c16c290 = array::filter(level.enemyequip, 0, &function_5118c0a3);
			items = arraycombine(level.allvehicles, var_7c16c290, 0, 0);
			arrayremovevalue(items, undefined, 0);
			var_5ef114b0 = arraysortclosest(items, self.origin, 5, 0, 7200);
		}
		foreach(item in self.var_100abb43)
		{
			if(isdefined(item))
			{
				item.var_f19b4afd = undefined;
			}
		}
		foreach(item in var_5ef114b0)
		{
			item.var_f19b4afd = 1;
		}
		var_2e2e2808 = arraycombine(self.var_100abb43, var_5ef114b0, 0, 0);
		foreach(item in var_2e2e2808)
		{
			if(isdefined(item))
			{
				if(isdefined(item.vehicletype))
				{
					item function_c34cebb1(localclientnum);
				}
				else
				{
					item weaponobjects::updateenemyequipment(localclientnum, undefined);
				}
			}
			waitframe(1);
		}
		self.var_100abb43 = var_5ef114b0;
		wait(0.2);
	}
}

/*
	Name: function_5118c0a3
	Namespace: namespace_c4d6fb7
	Checksum: 0xBED2E643
	Offset: 0x698
	Size: 0x2E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5118c0a3(item)
{
	return isdefined(item) && !item function_ca024039();
}

/*
	Name: function_c34cebb1
	Namespace: namespace_c4d6fb7
	Checksum: 0x948939E0
	Offset: 0x6D0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c34cebb1(localclientnum)
{
	self renderoverridebundle::function_c8d97b8e(localclientnum, #"friendly", #"hash_f5de00feee70c13");
	self renderoverridebundle::function_c8d97b8e(localclientnum, #"enemy", #"hash_77f7418d2f2a7890");
	self renderoverridebundle::function_c8d97b8e(localclientnum, #"neutral", #"hash_61c696df3d5a1765");
}

/*
	Name: function_76a0624a
	Namespace: namespace_c4d6fb7
	Checksum: 0x3D9320C4
	Offset: 0x790
	Size: 0x6A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_76a0624a()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team))
	{
		return 0;
	}
	if(self.owner.team == #"neutral")
	{
		return 0;
	}
	return self.owner function_83973173();
}

/*
	Name: function_da8108ae
	Namespace: namespace_c4d6fb7
	Checksum: 0x83F3F8B2
	Offset: 0x808
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_da8108ae()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team))
	{
		return 0;
	}
	if(self.owner.team == #"neutral")
	{
		return 0;
	}
	return !self.owner function_83973173();
}

/*
	Name: function_8550d243
	Namespace: namespace_c4d6fb7
	Checksum: 0x6B186296
	Offset: 0x880
	Size: 0xC2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8550d243(localclientnum, bundle)
{
	if(function_9d295a8c(localclientnum))
	{
		return 0;
	}
	if(self.type === "vehicle" && isinvehicle(localclientnum, self))
	{
		return 0;
	}
	if(self.type === "vehicle_corpse")
	{
		return 0;
	}
	if(self function_76a0624a() && (isdefined(self.var_f19b4afd) && self.var_f19b4afd))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_62888a11
	Namespace: namespace_c4d6fb7
	Checksum: 0x29EA0BAE
	Offset: 0x950
	Size: 0xC2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_62888a11(localclientnum, bundle)
{
	if(function_9d295a8c(localclientnum))
	{
		return 0;
	}
	if(self.type === "vehicle" && isinvehicle(localclientnum, self))
	{
		return 0;
	}
	if(self.type === "vehicle_corpse")
	{
		return 0;
	}
	if(self function_da8108ae() && (isdefined(self.var_f19b4afd) && self.var_f19b4afd))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b52a94e5
	Namespace: namespace_c4d6fb7
	Checksum: 0xB848BD2
	Offset: 0xA20
	Size: 0xDE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b52a94e5(localclientnum, bundle)
{
	if(function_9d295a8c(localclientnum))
	{
		return 0;
	}
	if(self.type === "vehicle" && isinvehicle(localclientnum, self))
	{
		return 0;
	}
	if(self.type === "vehicle_corpse")
	{
		return 0;
	}
	if(!self function_76a0624a() && !self function_da8108ae() && (isdefined(self.var_f19b4afd) && self.var_f19b4afd))
	{
		return 1;
	}
	return 0;
}

