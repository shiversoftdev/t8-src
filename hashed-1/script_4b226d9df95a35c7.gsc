// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_184abbae9afad370;
#using script_3aa0f32b70d4f7cb;
#using script_522aeb6ae906391e;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_5b1c3d314b9c88fb;
#using script_5c00791eb1bb8daf;
#using script_77dd41c80e39f62;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace namespace_bc1fae7;

/*
	Name: function_89f2df9
	Namespace: namespace_bc1fae7
	Checksum: 0x634B1DED
	Offset: 0x1B8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_78bf0dc450091c57", &__init__, &__main__, #"archetype_avogadro");
}

/*
	Name: __init__
	Namespace: namespace_bc1fae7
	Checksum: 0x9EDA2788
	Offset: 0x218
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"avogadro", &function_f34df3c);
	spawner::function_89a2cd87(#"avogadro", &function_c41e67c);
	level.var_8791f7c5 = &function_ac94df05;
	level.var_a35afcb2 = &function_7d5cf0e4;
	/#
		assert(isscriptfunctionptr(&function_98909da));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_512d14c0bff9da20", &function_98909da);
	/#
		assert(isscriptfunctionptr(&function_d392301));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_59c1b80c0f1a9062", &function_d392301);
}

/*
	Name: __main__
	Namespace: namespace_bc1fae7
	Checksum: 0x80F724D1
	Offset: 0x388
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_f34df3c
	Namespace: namespace_bc1fae7
	Checksum: 0x28D1D263
	Offset: 0x398
	Size: 0x25A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f34df3c()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.cant_move_cb = &namespace_4ae2f15f::function_9c573bc6;
	self.var_31a789c0 = 1;
	self.var_1c0eb62a = 180;
	self.var_a0193213 = 50;
	self.var_13138acf = 1;
	self.var_e729ffb = 2;
	self.var_65e57a10 = 1;
	self.var_1731eda3 = 1;
	self.var_2c628c0f = 1;
	self.var_721a3dbd = 1;
	self.var_12ec333b = 1;
	self.var_6501ffdf = 1;
	self.var_872e52b0 = &function_d44ccb0a;
	self.var_8f61d7f4 = 1;
	self namespace_b912c30b::function_9758722("walk");
	self callback::function_d8abfc3d(#"on_ai_damage", &function_ce2bd83c);
	self callback::function_d8abfc3d(#"hash_11aa32ad6d527054", &namespace_4ae2f15f::function_b8eb5dea);
	self callback::function_d8abfc3d(#"hash_7140c3848cbefaa1", &function_e44ef704);
	self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_b912c30b::function_16e2f075);
	self function_5ff730c7();
	function_905d3c1a(self);
	if(!isdefined(self))
	{
		return;
	}
	if(!getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		self thread namespace_4ae2f15f::function_e261b81d();
	}
	/#
		self.var_6c408220 = &function_c698f66b;
	#/
}

/*
	Name: function_c41e67c
	Namespace: namespace_bc1fae7
	Checksum: 0x844823AE
	Offset: 0x600
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c41e67c()
{
	if(math::cointoss())
	{
		self.var_15aa1ae0 = 0;
	}
	if(getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_4ae2f15f::function_bb3c1175);
		self namespace_4ae2f15f::function_b670d610();
	}
}

/*
	Name: function_5ff730c7
	Namespace: namespace_bc1fae7
	Checksum: 0x18CE3FC4
	Offset: 0x698
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_5ff730c7()
{
	self.var_2cee3556 = [];
	self.var_2cee3556[#"hash_45d006f75a326654"] = 15;
}

/*
	Name: function_745e91e8
	Namespace: namespace_bc1fae7
	Checksum: 0xC3498926
	Offset: 0x6D0
	Size: 0x32
	Parameters: 1
	Flags: Private
*/
private function function_745e91e8(entity)
{
	entity.fovcosine = 0.5;
	entity.maxsightdistsqrd = 900 * 900;
}

/*
	Name: function_d44ccb0a
	Namespace: namespace_bc1fae7
	Checksum: 0xF41A09F
	Offset: 0x710
	Size: 0x8
	Parameters: 0
	Flags: Linked
*/
function function_d44ccb0a()
{
	return 1;
}

/*
	Name: function_905d3c1a
	Namespace: namespace_bc1fae7
	Checksum: 0x525CB0D1
	Offset: 0x720
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_905d3c1a(entity)
{
	entity endon(#"death");
	delta = getmovedelta("ai_t8_zm_avogadro_arrival", 0, 1, entity);
	timeout = getanimlength("ai_t8_zm_avogadro_arrival");
	new_origin = (entity.origin[0], entity.origin[1], entity.origin[2] - delta[2]);
	entity animscripted("avogadro_arrival_finished", new_origin, (0, entity.angles[1], 0), "ai_t8_zm_avogadro_arrival", "normal", "root", 1, 0);
	entity waittill_timeout(timeout, #"hash_10eac2bbf85bab17");
}

/*
	Name: function_98909da
	Namespace: namespace_bc1fae7
	Checksum: 0x41A74209
	Offset: 0x850
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_98909da(entity)
{
	entity thread function_ad2f1327(entity);
}

/*
	Name: function_ad2f1327
	Namespace: namespace_bc1fae7
	Checksum: 0x314F417F
	Offset: 0x880
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function function_ad2f1327(entity)
{
	entity endon(#"death");
	entity.var_8a96267d = undefined;
	entity.is_digging = 1;
	entity pathmode("dont move", 1);
	timeout = getanimlength("ai_t8_zm_avogadro_exit");
	entity animscripted("avogadro_exit_finished", self.origin, self.angles, "ai_t8_zm_avogadro_exit", "normal", "root", 1, 0);
	waitresult = undefined;
	waitresult = entity waittill_timeout(timeout, #"hash_7f362d7c2b78b3ae");
	entity ghost();
	entity notsolid();
	entity val::set(#"hash_5dc24322003886a3", "ignoreall", 1);
	entity clientfield::set("" + #"hash_2eec8fc21495a18c", 0);
	entity notify(#"is_underground");
}

/*
	Name: function_d392301
	Namespace: namespace_bc1fae7
	Checksum: 0x6308DF5B
	Offset: 0xA20
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_d392301(entity)
{
	entity thread function_edc8c459(entity);
}

/*
	Name: function_edc8c459
	Namespace: namespace_bc1fae7
	Checksum: 0x17F1626F
	Offset: 0xA50
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_edc8c459(entity)
{
	entity endon(#"death");
	entity solid();
	entity show();
	entity.var_8ba6ede3 = undefined;
	function_905d3c1a(entity);
	if(!isdefined(entity))
	{
		return;
	}
	entity.is_digging = 0;
	entity pathmode("move allowed");
	entity val::reset(#"hash_5dc24322003886a3", "ignoreall");
	archetype_avogadro::function_dbc638a8(entity);
	entity notify(#"hash_661885e7a60ccf04");
}

/*
	Name: function_ce2bd83c
	Namespace: namespace_bc1fae7
	Checksum: 0xF7A168A5
	Offset: 0xB48
	Size: 0x2F2
	Parameters: 1
	Flags: Linked
*/
function function_ce2bd83c(params)
{
	if(isdefined(self.is_phasing) && self.is_phasing)
	{
		return 0;
	}
	if(isplayer(params.eattacker) && params.eattacker infection::is_infected())
	{
		return 0;
	}
	self player::function_74a5d514(params.eattacker, params.idamage, params.smeansofdeath, params.weapon, params.shitloc);
	if(isdefined(params.einflictor) && isdefined(params.weapon) && params.smeansofdeath !== "MOD_DOT")
	{
		var_9a429025 = function_f74d2943(params.weapon, 7);
		if(isdefined(var_9a429025))
		{
			status_effect::status_effect_apply(var_9a429025, params.weapon, params.einflictor);
		}
	}
	if(isdefined(params.einflictor) && !isdefined(self.attackable) && isdefined(params.einflictor.var_b79a8ac7) && isarray(params.einflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, params.weapon))
	{
		if(params.einflictor namespace_b912c30b::get_attackable_slot(self))
		{
			self.attackable = params.einflictor;
		}
	}
	if(params.smeansofdeath === "MOD_MELEE")
	{
		if(isplayer(params.einflictor))
		{
			if(self.shield)
			{
				params.einflictor status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
			}
		}
		if(!self.shield)
		{
			self.shield = 1;
			self.hit_by_melee++;
		}
	}
	else if(self.hit_by_melee > 0)
	{
		self.hit_by_melee--;
	}
	return params.idamage;
}

/*
	Name: function_e44ef704
	Namespace: namespace_bc1fae7
	Checksum: 0xC5F6E4B
	Offset: 0xE48
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_e44ef704(params)
{
	self.var_ef59b90 = 5;
	if(getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		self callback::callback(#"hash_10ab46b52df7967a");
	}
}

/*
	Name: function_ac94df05
	Namespace: namespace_bc1fae7
	Checksum: 0xE2943104
	Offset: 0xEB0
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_ac94df05(entity)
{
	if(!getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		return entity.aistate === 3 && (entity.var_9bff71aa < 2 || (gettime() - entity.var_7fde19e8) > 1000);
	}
	return isdefined(entity.current_state) && entity.current_state.name === #"chase" && (entity.var_9bff71aa < 2 || (gettime() - entity.var_7fde19e8) > 1000);
}

/*
	Name: function_7d5cf0e4
	Namespace: namespace_bc1fae7
	Checksum: 0x774B342
	Offset: 0xFA0
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_7d5cf0e4(entity)
{
	if(!getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		return entity.aistate === 3;
	}
	return isdefined(entity.current_state) && entity.current_state.name == #"chase";
}

/*
	Name: function_c698f66b
	Namespace: namespace_bc1fae7
	Checksum: 0xCF6A3788
	Offset: 0x1028
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function function_c698f66b()
{
	/#
		if(self.var_15aa1ae0 === 0)
		{
			if(getdvarint(#"recorder_enablerec", 0))
			{
				record3dtext("", self.origin, (1, 0.5, 0), "", self);
			}
			else
			{
				print3d(self.origin, "", (1, 0.5, 0), 1, 1);
			}
		}
	#/
}

