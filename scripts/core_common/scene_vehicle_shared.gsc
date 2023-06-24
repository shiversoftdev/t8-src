// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_objects_shared.gsc;

class cscenevehicle : csceneobject
{
	var _o_scene;
	var _e;
	var _s;

	/*
		Name: constructor
		Namespace: cscenevehicle
		Checksum: 0xA2E431A0
		Offset: 0x498
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenevehicle
		Checksum: 0xEA4DC4D0
		Offset: 0x4B8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_d09b043
		Namespace: cscenevehicle
		Checksum: 0x8BF76591
		Offset: 0x398
		Size: 0xF4
		Parameters: 0
		Flags: Linked
	*/
	function function_d09b043()
	{
		self notify(#"hash_3451c0bca5c1ca69");
		self endon(#"hash_3451c0bca5c1ca69");
		_o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
		var_be17187b = undefined;
		var_be17187b = _e waittill(#"death");
		self.var_1f97724a = 1;
		_e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
		csceneobject::function_1e19d813();
	}

	/*
		Name: _cleanup
		Namespace: cscenevehicle
		Checksum: 0x80F724D1
		Offset: 0x388
		Size: 0x4
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
	}

	/*
		Name: _prepare
		Namespace: cscenevehicle
		Checksum: 0xDACDA5CE
		Offset: 0x368
		Size: 0x14
		Parameters: 0
		Flags: Linked
	*/
	function _prepare()
	{
		csceneobject::set_objective();
	}

	/*
		Name: _set_values
		Namespace: cscenevehicle
		Checksum: 0x2DE968BF
		Offset: 0x220
		Size: 0x13C
		Parameters: 1
		Flags: Linked
	*/
	function _set_values(ent = _e)
	{
		if(!(csceneobject::error(!isvehicle(ent) && ent.classname !== "script_model", "entity is not actually a Vehicle or script_model, but set to Vehicle in scene. Check the GDT to make sure the proper object type is set")))
		{
			scene::prepare_generic_model_anim(ent);
		}
		csceneobject::set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
		csceneobject::set_ent_val("ignoreme", !(isdefined(_s.attackme) && _s.attackme), ent);
		csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
	}

	/*
		Name: _spawn_ent
		Namespace: cscenevehicle
		Checksum: 0x7C6B206A
		Offset: 0x168
		Size: 0xAC
		Parameters: 0
		Flags: Linked
	*/
	function _spawn_ent()
	{
		if(isdefined(_s.model))
		{
			if(isassetloaded("vehicle", _s.model))
			{
				self._e = spawnvehicle(_s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
				scene::prepare_generic_model_anim(_e);
			}
		}
	}

}

