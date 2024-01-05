// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;

#namespace zm_item_pickup;

/*
	Name: create_item_pickup
	Namespace: zm_item_pickup
	Checksum: 0x4C379D4C
	Offset: 0x80
	Size: 0x10A
	Parameters: 5
	Flags: Linked
*/
function create_item_pickup(var_3d455c82, var_4b1985dd, var_b4bbefe4, n_radius = 64, var_c12c30aa = 0)
{
	if(zm_utility::is_ee_enabled() || !var_c12c30aa)
	{
		if(!isdefined(var_4b1985dd))
		{
			var_4b1985dd = zm_utility::function_d6046228(#"hash_388256f1e5a62d7c", #"hash_7693de01f82d93f0");
		}
		s_unitrigger = self zm_unitrigger::create(var_4b1985dd, n_radius, undefined, 1, var_c12c30aa);
		self.var_b4a870af = var_3d455c82;
		self.var_4bac8510 = var_b4bbefe4;
		self thread item_think();
		return s_unitrigger;
	}
}

/*
	Name: item_think
	Namespace: zm_item_pickup
	Checksum: 0x12DB7B32
	Offset: 0x198
	Size: 0xA8
	Parameters: 0
	Flags: Linked, Private
*/
function private item_think()
{
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		if(!isdefined(self.var_4bac8510) || [[self.var_4bac8510]](s_notify.e_who))
		{
			level thread [[self.var_b4a870af]](self, s_notify.e_who);
			self function_d6812b9d();
		}
	}
}

/*
	Name: function_d6812b9d
	Namespace: zm_item_pickup
	Checksum: 0xD7334151
	Offset: 0x248
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_d6812b9d()
{
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
	self delete();
}

/*
	Name: function_e8661563
	Namespace: zm_item_pickup
	Checksum: 0xFA332F41
	Offset: 0x290
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function function_e8661563(func_callback, var_c12c30aa = 0)
{
	if(var_c12c30aa && !zm_utility::is_ee_enabled())
	{
		return;
	}
	s_unitrigger = self zm_unitrigger::create("", 64, &function_8769717c, 1, var_c12c30aa);
	s_unitrigger.pickup_callbacks = array(func_callback);
	return s_unitrigger;
}

/*
	Name: function_8769717c
	Namespace: zm_item_pickup
	Checksum: 0xBEDE8F39
	Offset: 0x348
	Size: 0x13C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8769717c()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	s_stub = self.stub;
	if(isdefined(waitresult.activator) && s_stub.b_picked_up !== 1)
	{
		s_stub.b_picked_up = 1;
		foreach(func_callback in s_stub.pickup_callbacks)
		{
			waitresult.activator thread [[func_callback]](s_stub.related_parent);
		}
		s_stub.related_parent hide();
		zm_unitrigger::unregister_unitrigger(s_stub);
	}
}

