// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_c9fc4f3f;

/*
	Name: function_89f2df9
	Namespace: namespace_c9fc4f3f
	Checksum: 0x7544483C
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1455490b99d4cbbb", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_c9fc4f3f
	Checksum: 0x56D793A0
	Offset: 0x130
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_1455490b99d4cbbb", "time", 300, &activation, &deactivation);
	bgb::function_95296005(#"hash_1455490b99d4cbbb", &actor_death_override);
	level.var_5bf2be84 = gettime();
	callback::on_ai_spawned(&on_ai_spawned);
}

/*
	Name: activation
	Namespace: namespace_c9fc4f3f
	Checksum: 0xDA01067F
	Offset: 0x208
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect");
}

/*
	Name: deactivation
	Namespace: namespace_c9fc4f3f
	Checksum: 0x80F724D1
	Offset: 0x228
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function deactivation()
{
}

/*
	Name: on_ai_spawned
	Namespace: namespace_c9fc4f3f
	Checksum: 0xE7CE8359
	Offset: 0x238
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function on_ai_spawned()
{
	if(self.archetype === #"zombie")
	{
		var_85574d7a = 0;
		foreach(player in getplayers())
		{
			if(player bgb::is_enabled(#"hash_1455490b99d4cbbb"))
			{
				var_85574d7a = 1;
			}
		}
		if(var_85574d7a)
		{
			self attach("p8_zm_red_floatie_duck", "j_spinelower", 1);
			self.sinkhole_charges_detonatedteleportterminate = 1;
		}
	}
}

/*
	Name: actor_death_override
	Namespace: namespace_c9fc4f3f
	Checksum: 0x5E9BC96
	Offset: 0x350
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function actor_death_override(s_data)
{
	if(isdefined(self) && (isdefined(self.sinkhole_charges_detonatedteleportterminate) && self.sinkhole_charges_detonatedteleportterminate))
	{
		if(gettime() >= level.var_5bf2be84 && randomint(100) < 40)
		{
			var_56fcbe0f = util::spawn_model("p8_zm_red_floatie_duck", self gettagorigin("j_spinelower"), self gettagangles("j_spinelower"));
			if(isdefined(var_56fcbe0f))
			{
				self detach("p8_zm_red_floatie_duck", "j_spinelower");
				level.var_5bf2be84 = gettime() + randomintrange(2000, 5000);
				var_56fcbe0f physicslaunch(self.origin, vectorscale((0, 0, 1), 64));
				var_56fcbe0f thread function_645efd58();
			}
		}
	}
}

/*
	Name: function_645efd58
	Namespace: namespace_c9fc4f3f
	Checksum: 0x12C69633
	Offset: 0x4A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_645efd58()
{
	wait(randomintrange(15, 25));
	if(isdefined(self))
	{
		self delete();
	}
}

