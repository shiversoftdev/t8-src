// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\util_shared.csc;

#namespace dog;

/*
	Name: init_shared
	Namespace: dog
	Checksum: 0x86530503
	Offset: 0x128
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_f90de4ee))
	{
		level.var_f90de4ee = {};
		clientfield::register("clientuimodel", "hudItems.dogState", 1, 2, "int", undefined, 0, 0);
		clientfield::register("actor", "dogState", 1, 1, "int", &function_654bd68b, 0, 0);
		clientfield::register("actor", "ks_dog_bark", 1, 1, "int", &function_14740469, 0, 0);
		clientfield::register("actor", "ks_shocked", 1, 1, "int", &function_e464e22b, 0, 0);
	}
	ai::add_archetype_spawn_function("mp_dog", &function_b0f3bc1f);
}

/*
	Name: function_b0f3bc1f
	Namespace: dog
	Checksum: 0xB032979F
	Offset: 0x290
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_b0f3bc1f(localclientnum)
{
	self thread watchdeath(localclientnum);
}

/*
	Name: watchdeath
	Namespace: dog
	Checksum: 0xA589F3EB
	Offset: 0x2C0
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function watchdeath(localclientnum)
{
	self waittill(#"death");
	if(isdefined(self) && self hasdobj(localclientnum))
	{
		self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
	}
}

/*
	Name: function_654bd68b
	Namespace: dog
	Checksum: 0xA14FF6E5
	Offset: 0x340
	Size: 0xBC
	Parameters: 7
	Flags: Private
*/
function private function_654bd68b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		if(self flag::exists(#"friendly"))
		{
			self renderoverridebundle::stop_bundle(#"friendly", (sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp"), 0);
		}
	}
}

/*
	Name: function_14740469
	Namespace: dog
	Checksum: 0x4ED86F94
	Offset: 0x408
	Size: 0x104
	Parameters: 7
	Flags: None
*/
function function_14740469(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self) && self hasdobj(localclientnum))
		{
			self setflaggedanimknobrestart(#"hash_506d2ece42569653", #"ai_nomad_dog_additive_bark_01", 1, 0.1, 1);
		}
	}
	else if(isdefined(self) && self hasdobj(localclientnum))
	{
		self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
	}
}

/*
	Name: function_e464e22b
	Namespace: dog
	Checksum: 0x25353510
	Offset: 0x518
	Size: 0xCC
	Parameters: 7
	Flags: None
*/
function function_e464e22b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.zmpowerupinstakill_introduction))
		{
			stopfx(localclientnum, self.zmpowerupinstakill_introduction);
		}
		self.zmpowerupinstakill_introduction = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_lightning_death_dog", self, "j_spine3");
	}
	else if(isdefined(self.zmpowerupinstakill_introduction))
	{
		stopfx(localclientnum, self.zmpowerupinstakill_introduction);
	}
}

