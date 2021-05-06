// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_64ab2b950d85b8ad;
#using script_6b993fdc7adc35ec;
#using script_8abfb58852911dd;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_441c2f1c;

/*
	Name: function_89f2df9
	Namespace: namespace_441c2f1c
	Checksum: 0xC4A1C5E1
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4ae4c6663b1a8c0c", &__init__, undefined, #"hash_568e72715a5f3355");
}

/*
	Name: __init__
	Namespace: namespace_441c2f1c
	Checksum: 0x9D6F2FA4
	Offset: 0xE0
	Size: 0x206
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	gametype = util::function_5df4294();
	if(gametype !== #"warzone_hot_pursuit" && gametype !== #"hash_77edb49e5314223" && gametype !== #"hash_753fcf1725358921" && gametype !== #"warzone_heavy_metal_heroes")
	{
		return;
	}
	if((isdefined(getgametypesetting(#"hash_7d8c969e384dd1c9")) ? getgametypesetting(#"hash_7d8c969e384dd1c9") : 0))
	{
		level.var_5c14d2e6 = &function_3fed57dd;
	}
	if((isdefined(getgametypesetting(#"hash_4149d5d65eb07138")) ? getgametypesetting(#"hash_4149d5d65eb07138") : 0))
	{
		level.var_317fb13c = &function_3fed57dd;
		if(gametype === #"hash_753fcf1725358921")
		{
			level.var_317fb13c = &function_a9b8fa06;
		}
	}
	if((isdefined(getgametypesetting(#"hash_24918193d72a5866")) ? getgametypesetting(#"hash_24918193d72a5866") : 0))
	{
		level.var_5c14d2e6 = &function_9de0644f;
		level.var_317fb13c = &function_9de0644f;
	}
}

/*
	Name: function_ba18c3e5
	Namespace: namespace_441c2f1c
	Checksum: 0x25E817C0
	Offset: 0x2F0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_ba18c3e5(itemname)
{
	if(isdefined(level.var_4afb8f5a[itemname]) && level.var_4afb8f5a[itemname] != #"")
	{
		itemname = level.var_4afb8f5a[itemname];
	}
	return function_4ba8fde(itemname);
}

/*
	Name: function_a9b8fa06
	Namespace: namespace_441c2f1c
	Checksum: 0xC7D6EF93
	Offset: 0x368
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_a9b8fa06()
{
	/#
		assert(isplayer(self));
	#/
	if(!isplayer(self) || !isalive(self))
	{
		return;
	}
	if(item_world::function_1b11e73c())
	{
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		self function_7376c60d();
	}
}

/*
	Name: function_3fed57dd
	Namespace: namespace_441c2f1c
	Checksum: 0x8A1AF9E1
	Offset: 0x430
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function function_3fed57dd()
{
	/#
		assert(isplayer(self));
	#/
	if(!isplayer(self) || !isalive(self))
	{
		return;
	}
	if(item_world::function_1b11e73c())
	{
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		if(!isdefined(level.var_52b56362))
		{
			self function_58190f52();
			return;
		}
		switch(level.var_52b56362)
		{
			case 0:
			{
				self function_58190f52();
				break;
			}
			case 1:
			{
				self function_6667abef();
				break;
			}
			case 2:
			{
				self function_7376c60d();
				break;
			}
			case 3:
			{
				self function_1f091d2f();
				break;
			}
			case 4:
			{
				self function_2d31b980();
				break;
			}
			default:
			{
				self function_58190f52();
				break;
			}
		}
	}
}

/*
	Name: function_9de0644f
	Namespace: namespace_441c2f1c
	Checksum: 0x7E5A4AD1
	Offset: 0x618
	Size: 0x16FA
	Parameters: 0
	Flags: Linked
*/
function function_9de0644f()
{
	/#
		assert(isplayer(self));
	#/
	if(!isplayer(self) || !isalive(self))
	{
		return;
	}
	if(!isdefined(self.var_6b7861bb))
	{
		self.var_6b7861bb = 0;
	}
	self.var_6b7861bb++;
	if(item_world::function_1b11e73c())
	{
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		switch(self.var_6b7861bb)
		{
			case 1:
			{
				smg = function_ba18c3e5(#"hash_34e069748d48b434");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
				smg.attachments = [];
				attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				attachment = function_ba18c3e5(#"hash_43d8944b55b1e63c");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				smg.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(smg));
				self item_world::function_de2018e3(smg, self, var_fa3df96);
				ammo = function_ba18c3e5(#"hash_212b01feaa916a00");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				armor = function_ba18c3e5(#"hash_8578856a247ab60");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
				self item_world::function_de2018e3(armor, self, var_fa3df96);
				health = function_ba18c3e5(#"hash_1abfcce0e9955057");
				health.count = 10;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
				self item_world::function_de2018e3(health, self, var_fa3df96);
				backpack = function_ba18c3e5(#"hash_527b2cdb9b6837f3");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(backpack);
				self item_world::function_de2018e3(backpack, self, var_fa3df96);
				var_dd88a936 = function_ba18c3e5(#"hash_2e33ce38d6cda617");
				var_dd88a936.count = 5;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_dd88a936);
				self item_world::function_de2018e3(var_dd88a936, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
			case 2:
			{
				smg = function_ba18c3e5(#"hash_73ba92c06ae7102a");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
				smg.attachments = [];
				attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				smg.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(smg));
				self item_world::function_de2018e3(smg, self, var_fa3df96);
				self namespace_b376ff3f::function_2b4d7b66(smg, 1, 1, 0, 1);
				ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				armor = function_ba18c3e5(#"hash_6f80136c3b79d9e");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
				self item_world::function_de2018e3(armor, self, var_fa3df96);
				health = function_ba18c3e5(#"hash_1abfcce0e9955057");
				health.count = 10;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
				self item_world::function_de2018e3(health, self, var_fa3df96);
				backpack = function_ba18c3e5(#"hash_527b2cdb9b6837f3");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(backpack);
				self item_world::function_de2018e3(backpack, self, var_fa3df96);
				var_dd88a936 = function_ba18c3e5(#"hash_2e33ce38d6cda617");
				var_dd88a936.count = 5;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_dd88a936);
				self item_world::function_de2018e3(var_dd88a936, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
			case 3:
			{
				smg = function_ba18c3e5(#"hash_6a992c957fb327bb");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
				smg.attachments = [];
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(smg, attachment);
				smg.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(smg));
				self item_world::function_de2018e3(smg, self, var_fa3df96);
				self namespace_b376ff3f::function_2b4d7b66(smg, 1, 1, 0, 1);
				ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				health = function_ba18c3e5(#"hash_1abfcce0e9955057");
				health.count = 5;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
				self item_world::function_de2018e3(health, self, var_fa3df96);
				backpack = function_ba18c3e5(#"hash_527b2cdb9b6837f3");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(backpack);
				self item_world::function_de2018e3(backpack, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
			case 4:
			{
				pistol = function_ba18c3e5(#"hash_6bbeca41cf389982");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(pistol);
				pistol.attachments = [];
				attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				pistol.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(pistol));
				self item_world::function_de2018e3(pistol, self, var_fa3df96);
				self namespace_b376ff3f::function_2b4d7b66(pistol, 1, 1, 0, 1);
				ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				health = function_ba18c3e5(#"hash_1abfcce0e9955057");
				health.count = 5;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
				self item_world::function_de2018e3(health, self, var_fa3df96);
				backpack = function_ba18c3e5(#"hash_527b2cdb9b6837f3");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(backpack);
				self item_world::function_de2018e3(backpack, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
			case 5:
			{
				pistol = function_ba18c3e5(#"hash_6bbeca41cf389982");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(pistol);
				pistol.attachments = [];
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				pistol.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(pistol));
				self item_world::function_de2018e3(pistol, self, var_fa3df96);
				self namespace_b376ff3f::function_2b4d7b66(pistol, 1, 1, 0, 1);
				ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				health = function_ba18c3e5(#"hash_1abfcce0e9955057");
				health.count = 5;
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
				self item_world::function_de2018e3(health, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
			default:
			{
				pistol = function_ba18c3e5(#"hash_6bbeca41cf389982");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(pistol);
				pistol.attachments = [];
				attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
				var_e38a0464 = namespace_b376ff3f::function_520b16d6();
				var_e38a0464.count = 1;
				var_e38a0464.id = attachment.id;
				var_e38a0464.var_bd027dd9 = var_e38a0464.id;
				var_e38a0464.var_a6762160 = attachment.var_a6762160;
				namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
				pistol.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(pistol));
				self item_world::function_de2018e3(pistol, self, var_fa3df96);
				self namespace_b376ff3f::function_2b4d7b66(pistol, 1, 1, 0, 1);
				ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
				self item_world::function_de2018e3(ammo, self, var_fa3df96);
				grapple = function_ba18c3e5(#"hash_68b64725de40edae");
				var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(grapple);
				self item_world::function_de2018e3(grapple, self, var_fa3df96);
				break;
			}
		}
	}
}

/*
	Name: function_58190f52
	Namespace: namespace_441c2f1c
	Checksum: 0x9D68A5C1
	Offset: 0x1D20
	Size: 0x224
	Parameters: 0
	Flags: Linked, Private
*/
private function function_58190f52()
{
	gametype = util::function_5df4294();
	if(gametype == #"warzone_hot_pursuit" || gametype == #"hash_753fcf1725358921")
	{
		pistol = function_ba18c3e5(#"hash_5cc9b5e23093ac03");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(pistol);
		self item_world::function_de2018e3(pistol, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_212b01feaa916a00");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
	}
	else if(gametype == #"hash_77edb49e5314223")
	{
		weapon = function_ba18c3e5(#"hash_15f30a19a23c0190");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
		self item_world::function_de2018e3(weapon, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_3bf6ed4e3a22e9f3");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
	}
	else if(gametype == #"hash_135cf8c5c6396f04")
	{
		function_f56a5599();
	}
}

/*
	Name: function_6667abef
	Namespace: namespace_441c2f1c
	Checksum: 0xA5529D52
	Offset: 0x1F50
	Size: 0x61C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6667abef()
{
	gametype = util::function_5df4294();
	if(gametype == #"warzone_hot_pursuit" || gametype == #"hash_753fcf1725358921")
	{
		pistol = function_ba18c3e5(#"hash_5cc9b5e23093ac03");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(pistol);
		pistol.attachments = [];
		attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		attachment = function_ba18c3e5(#"hash_559f58d5af0b432d");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
		pistol.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(pistol));
		self item_world::function_de2018e3(pistol, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_212b01feaa916a00");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_1abfcce0e9955057");
		health.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
	}
	else if(gametype == #"hash_77edb49e5314223")
	{
		weapon = function_ba18c3e5(#"hash_15f30a19a23c0190");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
		weapon.attachments = [];
		attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		attachment = function_ba18c3e5(#"hash_5506836b90ed93a9");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		weapon.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(weapon));
		self item_world::function_de2018e3(weapon, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_3bf6ed4e3a22e9f3");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_80292d121740f6f");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
	}
	else if(gametype == #"hash_135cf8c5c6396f04")
	{
		function_f56a5599();
	}
}

/*
	Name: function_7376c60d
	Namespace: namespace_441c2f1c
	Checksum: 0x4348F358
	Offset: 0x2578
	Size: 0x2FC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7376c60d()
{
	gametype = util::function_5df4294();
	if(gametype == #"warzone_hot_pursuit" || gametype == #"hash_753fcf1725358921")
	{
		smg = function_ba18c3e5(#"hash_6a992c957fb327bb");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
		self item_world::function_de2018e3(smg, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_1abfcce0e9955057");
		health.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
	}
	else if(gametype == #"hash_77edb49e5314223")
	{
		weapon = function_ba18c3e5(#"hash_36978e3a9321b430");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
		self item_world::function_de2018e3(weapon, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_1f72dec518451f8c");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_80292d121740f6f");
		health.count = 2;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
	}
	else if(gametype == #"hash_135cf8c5c6396f04")
	{
		function_f56a5599();
	}
}

/*
	Name: function_1f091d2f
	Namespace: namespace_441c2f1c
	Checksum: 0xFD0F2AE1
	Offset: 0x2880
	Size: 0x61C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1f091d2f()
{
	gametype = util::function_5df4294();
	if(gametype == #"warzone_hot_pursuit" || gametype == #"hash_753fcf1725358921")
	{
		smg = function_ba18c3e5(#"hash_6a992c957fb327bb");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
		self item_world::function_de2018e3(smg, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		attachment = function_ba18c3e5(#"hash_43d8944b55b1e63c");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(attachment);
		self item_world::function_de2018e3(attachment, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_1abfcce0e9955057");
		health.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		armor = function_ba18c3e5(#"hash_6f80136c3b79d9e");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
		self item_world::function_de2018e3(armor, self, var_fa3df96);
		var_dd88a936 = function_ba18c3e5(#"hash_2e33ce38d6cda617");
		var_dd88a936.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_dd88a936);
		self item_world::function_de2018e3(var_dd88a936, self, var_fa3df96);
	}
	else if(gametype == #"hash_77edb49e5314223")
	{
		weapon = function_ba18c3e5(#"hash_36978e3a9321b430");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
		weapon.attachments = [];
		attachment = function_ba18c3e5(#"hash_513a787ad3a20198");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		attachment = function_ba18c3e5(#"hash_5506836b90ed93a9");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		weapon.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(weapon));
		self item_world::function_de2018e3(weapon, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_1f72dec518451f8c");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_80292d121740f6f");
		health.count = 3;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		armor = function_ba18c3e5(#"hash_568173e016d45c2a");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
		self item_world::function_de2018e3(armor, self, var_fa3df96);
	}
	else if(gametype == #"hash_135cf8c5c6396f04")
	{
		function_f56a5599();
	}
}

/*
	Name: function_2d31b980
	Namespace: namespace_441c2f1c
	Checksum: 0x932664E1
	Offset: 0x2EA8
	Size: 0x7DC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2d31b980()
{
	gametype = util::function_5df4294();
	if(gametype == #"warzone_hot_pursuit" || gametype == #"hash_753fcf1725358921")
	{
		smg = function_ba18c3e5(#"hash_6a992c957fb327bb");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(smg);
		self item_world::function_de2018e3(smg, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_182fdef2ad243e20");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		attachment = function_ba18c3e5(#"hash_43d8944b55b1e63c");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(attachment);
		self item_world::function_de2018e3(attachment, self, var_fa3df96);
		attachment = function_ba18c3e5(#"hash_2b2bf36e2ea5ab8f");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(attachment);
		self item_world::function_de2018e3(attachment, self, var_fa3df96);
		attachment = function_ba18c3e5(#"hash_2a10ad247a663aaa");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(attachment);
		self item_world::function_de2018e3(attachment, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_1abfcce0e9955057");
		health.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		armor = function_ba18c3e5(#"hash_8578856a247ab60");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
		self item_world::function_de2018e3(armor, self, var_fa3df96);
		var_dd88a936 = function_ba18c3e5(#"hash_2e33ce38d6cda617");
		var_dd88a936.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_dd88a936);
		self item_world::function_de2018e3(var_dd88a936, self, var_fa3df96);
	}
	else if(gametype == #"hash_77edb49e5314223")
	{
		weapon = function_ba18c3e5(#"hash_36978e3a9321b430");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
		weapon.attachments = [];
		attachment = function_ba18c3e5(#"hash_66023e3bee6c58a1");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		attachment = function_ba18c3e5(#"hash_a1deb882d59a069");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		attachment = function_ba18c3e5(#"hash_2a10ad247a663aaa");
		var_e38a0464 = namespace_b376ff3f::function_520b16d6();
		var_e38a0464.count = 1;
		var_e38a0464.id = attachment.id;
		var_e38a0464.var_bd027dd9 = var_e38a0464.id;
		var_e38a0464.var_a6762160 = attachment.var_a6762160;
		namespace_a0d533d1::function_9e9c82a6(weapon, attachment);
		weapon.amount = self function_f09c133d(namespace_a0d533d1::function_2b83d3ff(weapon));
		self item_world::function_de2018e3(weapon, self, var_fa3df96);
		ammo = function_ba18c3e5(#"hash_1f72dec518451f8c");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
		self item_world::function_de2018e3(ammo, self, var_fa3df96);
		health = function_ba18c3e5(#"hash_80292d121740f6f");
		health.count = 3;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
		self item_world::function_de2018e3(health, self, var_fa3df96);
		armor = function_ba18c3e5(#"hash_568173e016d45c2a");
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
		self item_world::function_de2018e3(armor, self, var_fa3df96);
		var_dd88a936 = function_ba18c3e5(#"hash_2e33ce38d6cda617");
		var_dd88a936.count = 5;
		var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_dd88a936);
		self item_world::function_de2018e3(var_dd88a936, self, var_fa3df96);
	}
	else if(gametype == #"hash_135cf8c5c6396f04")
	{
		function_f56a5599();
	}
}

/*
	Name: function_f56a5599
	Namespace: namespace_441c2f1c
	Checksum: 0x1E19C61
	Offset: 0x3690
	Size: 0x32C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f56a5599()
{
	weapon = function_ba18c3e5(#"hash_505c397233e87a32");
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
	self item_world::function_de2018e3(weapon, self, var_fa3df96);
	ammo = function_ba18c3e5(#"hash_3bf6ed4e3a22e9f3");
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
	self item_world::function_de2018e3(ammo, self, var_fa3df96);
	weapon = function_ba18c3e5(#"hash_3e4707ff6c41feac");
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(weapon);
	self item_world::function_de2018e3(weapon, self, var_fa3df96);
	ammo = function_ba18c3e5(#"hash_3bf6ed4e3a22e9f3");
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(ammo);
	self item_world::function_de2018e3(ammo, self, var_fa3df96);
	health = function_ba18c3e5(#"hash_45ced3880667df22");
	health.count = 5;
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(health);
	self item_world::function_de2018e3(health, self, var_fa3df96);
	armor = function_ba18c3e5(#"hash_8578856a247ab60");
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(armor);
	self item_world::function_de2018e3(armor, self, var_fa3df96);
	var_57fd914e = function_ba18c3e5(#"hash_4a2739676c12d92a");
	var_57fd914e.count = 5;
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_57fd914e);
	self item_world::function_de2018e3(health, self, var_fa3df96);
	var_82e4671b = function_ba18c3e5(#"hash_50b970644e43947b");
	var_82e4671b.count = 5;
	var_fa3df96 = self namespace_b376ff3f::function_e66dcff5(var_82e4671b);
	self item_world::function_de2018e3(health, self, var_fa3df96);
}

