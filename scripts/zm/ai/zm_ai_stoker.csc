// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_ai_stoker;

/*
	Name: __init__system__
	Namespace: zm_ai_stoker
	Checksum: 0x9546F92E
	Offset: 0x368
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_stoker", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_stoker
	Checksum: 0x1F509FA1
	Offset: 0x3B0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(ai::shouldregisterclientfieldforarchetype(#"stoker"))
	{
		clientfield::register("actor", "crit_spot_reveal_clientfield", 1, getminbitcountfornum(4), "int", &crit_spot_reveal, 0, 0);
		clientfield::register("actor", "stoker_fx_start_clientfield", 1, 3, "int", &stoker_fx_start, 0, 0);
		clientfield::register("actor", "stoker_fx_stop_clientfield", 1, 3, "int", &stoker_fx_stop, 0, 0);
		clientfield::register("actor", "stoker_death_explosion", 1, 2, "int", &stoker_death_explosion, 0, 0);
	}
	ai::add_archetype_spawn_function(#"stoker", &stoker_spawn_init);
}

/*
	Name: stoker_spawn_init
	Namespace: zm_ai_stoker
	Checksum: 0x834986C2
	Offset: 0x540
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function stoker_spawn_init(localclientnum)
{
	self zm_utility::function_3a020b0f(localclientnum, undefined, "zm_ai/fx8_stoker_eye_glow");
	self callback::on_shutdown(&on_entity_shutdown);
}

/*
	Name: on_entity_shutdown
	Namespace: zm_ai_stoker
	Checksum: 0x5085F34A
	Offset: 0x598
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_entity_shutdown(localclientnum)
{
	if(isdefined(self))
	{
		self zm_utility::good_barricade_damaged(localclientnum);
	}
}

/*
	Name: crit_spot_reveal
	Namespace: zm_ai_stoker
	Checksum: 0x12BF7CD7
	Offset: 0x5D0
	Size: 0x9C
	Parameters: 7
	Flags: Linked, Private
*/
function private crit_spot_reveal(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self mapshaderconstant(localclientnum, 0, "scriptVector" + newvalue, 0, 1, 0, 0);
		self playsound(0, #"hash_9cde96bded002d5");
	}
}

/*
	Name: stoker_fx_start
	Namespace: zm_ai_stoker
	Checksum: 0x2103A2C2
	Offset: 0x678
	Size: 0x3DA
	Parameters: 7
	Flags: Linked, Private
*/
function private stoker_fx_start(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(!isdefined(self.currentfx))
	{
		self.currentfx = [];
	}
	if(!self hasdobj(localclientnum))
	{
		return;
	}
	switch(newvalue)
	{
		case 1:
		{
			break;
		}
		case 2:
		{
			if(!isdefined(self.currentfx[2]))
			{
				self.currentfx[2] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_charge_shovel", self, "tag_fx_shovel");
			}
			break;
		}
		case 3:
		{
			if(!isdefined(self.currentfx[3]))
			{
				self.currentfx[3] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_clavicle_le");
				self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
			}
			break;
		}
		case 4:
		{
			if(!isdefined(self.currentfx[4]))
			{
				self.currentfx[4] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_clavicle_ri");
				self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
			}
			break;
		}
		case 5:
		{
			if(!isdefined(self.currentfx[5]))
			{
				self.currentfx[4] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_head");
				self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
			}
			break;
		}
		case 6:
		{
			if(!isdefined(self.currentfx[6]))
			{
				self.currentfx[6] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_wrist_le");
				self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
			}
			break;
		}
		case 7:
		{
			if(!isdefined(self.currentfx[7]) || !isdefined(self.currentfx[7][0]))
			{
				self.currentfx[7][0] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_projectile_coal_charge_bicep", self, "j_shoulder_le");
				self.currentfx[7][1] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_projectile_coal_charge_forearm", self, "j_elbow_le");
				self.currentfx[7][2] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_projectile_coal_charge_hand", self, "j_wrist_le");
			}
			break;
		}
	}
}

/*
	Name: stoker_fx_stop
	Namespace: zm_ai_stoker
	Checksum: 0x2BAA33EF
	Offset: 0xA60
	Size: 0x342
	Parameters: 7
	Flags: Linked, Private
*/
function private stoker_fx_stop(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(!isdefined(self.currentfx))
	{
		self.currentfx = [];
	}
	if(!self hasdobj(localclientnum))
	{
		return;
	}
	switch(newvalue)
	{
		case 1:
		{
			break;
		}
		case 2:
		{
			if(isdefined(self.currentfx[2]))
			{
				stopfx(localclientnum, self.currentfx[2]);
			}
			self.currentfx[2] = undefined;
			break;
		}
		case 3:
		{
			if(isdefined(self.currentfx[3]))
			{
				stopfx(localclientnum, self.currentfx[3]);
			}
			self.currentfx[3] = undefined;
			break;
		}
		case 4:
		{
			if(isdefined(self.currentfx[4]))
			{
				stopfx(localclientnum, self.currentfx[4]);
			}
			self.currentfx[4] = undefined;
			break;
		}
		case 5:
		{
			if(isdefined(self.currentfx[5]))
			{
				stopfx(localclientnum, self.currentfx[5]);
			}
			self.currentfx[5] = undefined;
			break;
		}
		case 6:
		{
			if(isdefined(self.currentfx[6]))
			{
				stopfx(localclientnum, self.currentfx[6]);
			}
			self.currentfx[6] = undefined;
			break;
		}
		case 7:
		{
			if(isdefined(self.currentfx[7]) && isdefined(self.currentfx[7][0]))
			{
				stopfx(localclientnum, self.currentfx[7][0]);
				stopfx(localclientnum, self.currentfx[7][1]);
				stopfx(localclientnum, self.currentfx[7][2]);
				self.currentfx[7][0] = undefined;
				self.currentfx[7][1] = undefined;
				self.currentfx[7][2] = undefined;
			}
			break;
		}
	}
}

/*
	Name: stoker_death_explosion
	Namespace: zm_ai_stoker
	Checksum: 0x5803A94B
	Offset: 0xDB0
	Size: 0x17A
	Parameters: 7
	Flags: Linked
*/
function stoker_death_explosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	switch(newvalue)
	{
		case 1:
		{
			util::lock_model("c_t8_zmb_titanic_stoker_body1_gibbed");
			self thread function_a88c80a3("c_t8_zmb_titanic_stoker_body1_gibbed");
			break;
		}
		case 2:
		{
			self notify(#"unlock_model");
			v_origin = self gettagorigin("j_shoulder_le");
			if(!isdefined(v_origin))
			{
				v_origin = self.origin;
			}
			physicsexplosionsphere(localclientnum, v_origin, 400, 0, 3);
			self thread function_d58cd2d5(localclientnum);
			playsound(localclientnum, #"hash_5c4876ace1c2aa10", self gettagorigin("j_shoulder_le"));
			break;
		}
	}
}

/*
	Name: function_d58cd2d5
	Namespace: zm_ai_stoker
	Checksum: 0x4FF5A266
	Offset: 0xF38
	Size: 0x4AE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d58cd2d5(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	var_4ca7be87 = self.origin;
	var_741c873 = self gettagangles("j_knee_le");
	var_11fd1705 = self gettagorigin("j_knee_le");
	if(!isdefined(var_11fd1705))
	{
		var_11fd1705 = self.origin;
		var_741c873 = self.angles;
	}
	var_ff623659 = self gettagangles("j_clavicle_le");
	var_659c63b = self gettagorigin("j_clavicle_le");
	if(!isdefined(var_659c63b))
	{
		var_659c63b = self.origin;
		var_ff623659 = self.angles;
	}
	var_cf1365cd = self gettagangles("j_shouldertwist_le");
	var_99625f1a = self gettagorigin("j_shouldertwist_le");
	if(!isdefined(var_99625f1a))
	{
		var_99625f1a = self.origin;
		var_cf1365cd = self.angles;
	}
	var_2d81ef5f = [];
	if(!isdefined(var_2d81ef5f))
	{
		var_2d81ef5f = [];
	}
	else if(!isarray(var_2d81ef5f))
	{
		var_2d81ef5f = array(var_2d81ef5f);
	}
	var_2d81ef5f[var_2d81ef5f.size] = vectornormalize(anglestoforward(self.angles));
	if(!isdefined(var_2d81ef5f))
	{
		var_2d81ef5f = [];
	}
	else if(!isarray(var_2d81ef5f))
	{
		var_2d81ef5f = array(var_2d81ef5f);
	}
	var_2d81ef5f[var_2d81ef5f.size] = vectornormalize(anglestoright(self.angles));
	if(!isdefined(var_2d81ef5f))
	{
		var_2d81ef5f = [];
	}
	else if(!isarray(var_2d81ef5f))
	{
		var_2d81ef5f = array(var_2d81ef5f);
	}
	var_2d81ef5f[var_2d81ef5f.size] = var_2d81ef5f[1] * -1;
	var_2d81ef5f = array::randomize(var_2d81ef5f);
	var_4423d870 = var_2d81ef5f[0] + (0, 0, randomfloatrange(0.4, 0.8));
	var_9df00078 = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_clavicle1_gibbed", var_659c63b, var_ff623659, var_659c63b, var_4423d870 * randomfloatrange(0.6, 1.2));
	wait(0.1);
	var_4423d870 = var_2d81ef5f[1] + (0, 0, randomfloatrange(0.4, 0.8));
	e_arm = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_upperarm1_gibbed", var_99625f1a, var_cf1365cd, var_99625f1a, var_4423d870 * randomfloatrange(0.6, 1.2));
	wait(0.1);
	var_4423d870 = var_2d81ef5f[2] + (0, 0, randomfloatrange(0.4, 0.8));
	var_7fb39378 = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_boot1_gibbed", var_11fd1705, var_741c873, var_11fd1705, var_4423d870 * randomfloatrange(0.6, 1.2));
}

/*
	Name: function_a88c80a3
	Namespace: zm_ai_stoker
	Checksum: 0x2E5AF48C
	Offset: 0x13F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a88c80a3(model)
{
	self waittilltimeout(10, #"death", #"unlock_model");
	util::unlock_model(model);
}

