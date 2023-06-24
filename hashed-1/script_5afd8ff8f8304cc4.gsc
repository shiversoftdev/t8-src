// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_a476311c;

/*
	Name: __init__system__
	Namespace: namespace_a476311c
	Checksum: 0x60D9E7B5
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_7ceb08aa364e4596", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a476311c
	Checksum: 0x52F15B95
	Offset: 0xC0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_250115340b2e27a5", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_a476311c
	Checksum: 0x103696EB
	Offset: 0x128
	Size: 0x2E
	Parameters: 2
	Flags: Private
*/
function private on_begin(local_client_num, params)
{
	level.var_7db2b064 = &function_ecc5a0b9;
}

/*
	Name: on_end
	Namespace: namespace_a476311c
	Checksum: 0x5FF4ECBD
	Offset: 0x160
	Size: 0x16
	Parameters: 1
	Flags: Private
*/
function private on_end(local_client_num)
{
	level.var_7db2b064 = undefined;
}

/*
	Name: is_active
	Namespace: namespace_a476311c
	Checksum: 0x81DB9F97
	Offset: 0x180
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_250115340b2e27a5");
	return isdefined(challenge);
}

/*
	Name: function_ecc5a0b9
	Namespace: namespace_a476311c
	Checksum: 0xE515960F
	Offset: 0x1C0
	Size: 0x44
	Parameters: 3
	Flags: Private
*/
function private function_ecc5a0b9(local_client_num, player, damage)
{
	if(int(damage) <= 1)
	{
		return true;
	}
	return false;
}

