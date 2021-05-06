// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace namespace_eb06e24d;

/*
	Name: function_d0ac8d8
	Namespace: namespace_eb06e24d
	Checksum: 0xE78ACDA8
	Offset: 0x68
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_d0ac8d8()
{
	if(!isdefined(level.var_aadba305))
	{
		level.var_aadba305 = (isdefined(getscriptbundlelist(#"hash_4c4900fca46d6c74")) ? getscriptbundlelist(#"hash_4c4900fca46d6c74") : array());
	}
	return level.var_aadba305;
}

/*
	Name: function_3045dd71
	Namespace: namespace_eb06e24d
	Checksum: 0xF0B2E9F0
	Offset: 0xF8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function function_3045dd71()
{
	return function_d0ac8d8().size;
}

/*
	Name: function_550c6257
	Namespace: namespace_eb06e24d
	Checksum: 0x2FD63F4C
	Offset: 0x118
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_550c6257(var_ff60755f)
{
	var_f51354c7 = function_d0ac8d8();
	/#
		assert(var_f51354c7.size > 0);
	#/
	/#
		assert(isdefined(var_f51354c7[0]));
	#/
	if(var_ff60755f < 0 || var_ff60755f >= var_f51354c7.size || !isdefined(var_f51354c7[var_ff60755f]))
	{
		var_ff60755f = 0;
	}
	return getscriptbundle(var_f51354c7[var_ff60755f]);
}

/*
	Name: function_83a2cad4
	Namespace: namespace_eb06e24d
	Checksum: 0xEC40D0A4
	Offset: 0x1D8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_83a2cad4(index)
{
	kit = function_550c6257(index);
	return getscriptbundle(kit.parachute);
}

/*
	Name: function_aa3a05b1
	Namespace: namespace_eb06e24d
	Checksum: 0x92336753
	Offset: 0x230
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_aa3a05b1(index)
{
	kit = function_550c6257(index);
	return getscriptbundle(kit.wingsuit);
}

/*
	Name: function_6452f9c5
	Namespace: namespace_eb06e24d
	Checksum: 0xB82BE424
	Offset: 0x288
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_6452f9c5(index)
{
	kit = function_550c6257(index);
	return getscriptbundle(kit.var_4fa85a25);
}

/*
	Name: function_c72eb508
	Namespace: namespace_eb06e24d
	Checksum: 0x10B717D6
	Offset: 0x2E0
	Size: 0x9A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c72eb508()
{
	if(isdefined(self.var_9f20891))
	{
		return self.var_9f20891;
	}
	count = function_3045dd71();
	seed = self getentitynumber() + (isdefined(level.var_cca3647d) ? level.var_cca3647d : 0);
	self.var_9f20891 = function_d59c2d03(count, seed);
	return self.var_9f20891;
}

/*
	Name: function_37ae175b
	Namespace: namespace_eb06e24d
	Checksum: 0x5D920714
	Offset: 0x388
	Size: 0x152
	Parameters: 1
	Flags: Linked, Private
*/
private function function_37ae175b(type)
{
	/#
		if(getdvarint(#"hash_9003cbb3abd93b7", 0) != 0)
		{
			count = function_3045dd71();
			return int(max(0, min(count, getdvarint(#"hash_9003cbb3abd93b7", 0) - 1)));
		}
		if(getdvarint(#"hash_6c79f9280f28fabe", 0) != 0)
		{
			return self function_c72eb508();
		}
	#/
	if(isbot(self))
	{
		return self function_c72eb508();
	}
	var_5c27e968 = self function_7d5a3c48(currentsessionmode(), type);
	return var_5c27e968;
}

/*
	Name: function_fc6b6f3b
	Namespace: namespace_eb06e24d
	Checksum: 0x96196684
	Offset: 0x4E8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function function_fc6b6f3b()
{
	return function_83a2cad4(self function_37ae175b(0));
}

/*
	Name: function_4a22ec61
	Namespace: namespace_eb06e24d
	Checksum: 0xCB90CC2E
	Offset: 0x520
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_4a22ec61()
{
	return function_550c6257(self function_37ae175b(0));
}

/*
	Name: function_c772633d
	Namespace: namespace_eb06e24d
	Checksum: 0x307AFD45
	Offset: 0x558
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_c772633d()
{
	return function_aa3a05b1(self function_37ae175b(2));
}

/*
	Name: function_3c54cdb1
	Namespace: namespace_eb06e24d
	Checksum: 0x83C1EB9F
	Offset: 0x590
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_3c54cdb1()
{
	return function_550c6257(self function_37ae175b(2));
}

/*
	Name: function_2328db2c
	Namespace: namespace_eb06e24d
	Checksum: 0xAE8CD354
	Offset: 0x5C8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function function_2328db2c()
{
	return function_6452f9c5(self function_37ae175b(1));
}

/*
	Name: function_4a39b434
	Namespace: namespace_eb06e24d
	Checksum: 0x1348458E
	Offset: 0x600
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_4a39b434()
{
	return function_550c6257(self function_37ae175b(1));
}

