// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_10df686;

/*
	Name: function_89f2df9
	Namespace: namespace_10df686
	Checksum: 0xA0C67529
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3e54b9da1b1e7a51", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_10df686
	Checksum: 0x587397E
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: namespace_10df686
	Checksum: 0xD1C36D04
	Offset: 0x100
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::function_7f42e14e(#"specialty_mod_extraammo", "mod_bandolier", #"hash_420c7fd6609f0966", #"specialty_extraammo", 3500);
	zm_perks::register_perk_threads(#"specialty_mod_extraammo", &function_dde8cedc, &function_3781ff37);
}

/*
	Name: function_dde8cedc
	Namespace: namespace_10df686
	Checksum: 0xBCAE9E91
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_dde8cedc()
{
	self thread function_9335851();
}

/*
	Name: function_3781ff37
	Namespace: namespace_10df686
	Checksum: 0x2246689C
	Offset: 0x1C8
	Size: 0x36
	Parameters: 4
	Flags: Linked
*/
function function_3781ff37(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	self notify(#"hash_73b1e35c66a4e898");
}

/*
	Name: function_9335851
	Namespace: namespace_10df686
	Checksum: 0xA79F56A
	Offset: 0x208
	Size: 0x354
	Parameters: 0
	Flags: Linked
*/
function function_9335851()
{
	self endon(#"disconnect", #"hash_73b1e35c66a4e898");
	while(true)
	{
		wait(1);
		a_weapons = self getweaponslistprimaries();
		foreach(weapon in a_weapons)
		{
			w_current = self getcurrentweapon();
			var_911fad7c = zm_weapons::function_af29d744(w_current);
			w_root = zm_weapons::function_386dacbc(weapon);
			if(var_911fad7c == w_root)
			{
				continue;
				continue;
			}
			if(weaponhasattachment(weapon, "uber") && w_root == getweapon(#"smg_capacity_t8"))
			{
				continue;
				continue;
			}
			n_clip = self getweaponammoclip(weapon);
			n_clip_size = weapon.clipsize;
			n_stock_size = self getweaponammostock(weapon);
			if(isdefined(n_clip) && isdefined(n_clip_size) && n_clip < n_clip_size)
			{
				var_8e477029 = int(ceil(n_clip_size * 0.05));
				if(weapon.iscliponly)
				{
					continue;
					continue;
				}
				if(n_stock_size >= var_8e477029)
				{
					self setweaponammoclip(weapon, n_clip + var_8e477029);
					self setweaponammostock(weapon, n_stock_size - var_8e477029);
					if(n_clip + var_8e477029 >= n_clip_size)
					{
						self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
					}
					continue;
				}
				if(n_stock_size > 0)
				{
					self setweaponammoclip(weapon, n_clip + 1);
					self setweaponammostock(weapon, n_stock_size - 1);
					self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
				}
			}
		}
	}
}

