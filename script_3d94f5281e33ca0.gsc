// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_shared_ingame_objective : cluielem
{

	/*
		Name: constructor
		Namespace: cct_shared_ingame_objective
		Checksum: 0x64ECCE70
		Offset: 0x280
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_ingame_objective
		Checksum: 0x967AEF80
		Offset: 0xDC8
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_objpoints
		Namespace: cct_shared_ingame_objective
		Checksum: 0x26ABD408
		Offset: 0xD90
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objpoints(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objpoints", value);
	}

	/*
		Name: set_objectivetext
		Namespace: cct_shared_ingame_objective
		Checksum: 0xA607E24A
		Offset: 0xD58
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_objectivetext(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "objectiveText", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_ingame_objective
		Checksum: 0x942B967E
		Offset: 0x450
		Size: 0x8FC
		Parameters: 2
		Flags: None
	*/
	function set_state(localclientnum, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			[[ self ]]->set_data(localclientnum, "_state", 0);
		}
		else
		{
			if(#"fadeout" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				if(#"timer_on" == state_name)
				{
					[[ self ]]->set_data(localclientnum, "_state", 2);
				}
				else
				{
					if(#"hash_7b45e6511e6e3303" == state_name)
					{
						[[ self ]]->set_data(localclientnum, "_state", 3);
					}
					else
					{
						if(#"dynobj_killtoearnhellstorm" == state_name)
						{
							[[ self ]]->set_data(localclientnum, "_state", 4);
						}
						else
						{
							if(#"hash_1f92740e023d0e37" == state_name)
							{
								[[ self ]]->set_data(localclientnum, "_state", 5);
							}
							else
							{
								if(#"dynobj_killtoearnrcxd" == state_name)
								{
									[[ self ]]->set_data(localclientnum, "_state", 6);
								}
								else
								{
									if(#"hash_2ad0da501b5586a4" == state_name)
									{
										[[ self ]]->set_data(localclientnum, "_state", 7);
									}
									else
									{
										if(#"dynobj_killtoearnswat" == state_name)
										{
											[[ self ]]->set_data(localclientnum, "_state", 8);
										}
										else
										{
											if(#"hash_4de4402f8698c768" == state_name)
											{
												[[ self ]]->set_data(localclientnum, "_state", 9);
											}
											else
											{
												if(#"hash_63d3d0d871ba1adb" == state_name)
												{
													[[ self ]]->set_data(localclientnum, "_state", 10);
												}
												else
												{
													if(#"hash_2f0272e755f4abf7" == state_name)
													{
														[[ self ]]->set_data(localclientnum, "_state", 11);
													}
													else
													{
														if(#"dynobj_killtoearnlightningstrike" == state_name)
														{
															[[ self ]]->set_data(localclientnum, "_state", 12);
														}
														else
														{
															if(#"hash_71743ffed428ea2f" == state_name)
															{
																[[ self ]]->set_data(localclientnum, "_state", 13);
															}
															else
															{
																if(#"hash_519ed82ca27249dd" == state_name)
																{
																	[[ self ]]->set_data(localclientnum, "_state", 14);
																}
																else
																{
																	if(#"hash_7d5a07e3680ec561" == state_name)
																	{
																		[[ self ]]->set_data(localclientnum, "_state", 15);
																	}
																	else
																	{
																		if(#"hash_80668531e9e4db6" == state_name)
																		{
																			[[ self ]]->set_data(localclientnum, "_state", 16);
																		}
																		else
																		{
																			if(#"hash_5ba30c4069a3b28" == state_name)
																			{
																				[[ self ]]->set_data(localclientnum, "_state", 17);
																			}
																			else
																			{
																				if(#"dynobj_killmantises" == state_name)
																				{
																					[[ self ]]->set_data(localclientnum, "_state", 18);
																				}
																				else
																				{
																					if(#"hash_83700757d6b9194" == state_name)
																					{
																						[[ self ]]->set_data(localclientnum, "_state", 19);
																					}
																					else
																					{
																						if(#"hash_6dfb08308c7640b0" == state_name)
																						{
																							[[ self ]]->set_data(localclientnum, "_state", 20);
																						}
																						else
																						{
																							if(#"hash_2a4442540584316a" == state_name)
																							{
																								[[ self ]]->set_data(localclientnum, "_state", 21);
																							}
																							else
																							{
																								if(#"hash_7917ffb178e31e9c" == state_name)
																								{
																									[[ self ]]->set_data(localclientnum, "_state", 22);
																								}
																								else
																								{
																									if(#"hash_1a051da4d150816" == state_name)
																									{
																										[[ self ]]->set_data(localclientnum, "_state", 23);
																									}
																									else
																									{
																										if(#"hash_347a715457b3ba72" == state_name)
																										{
																											[[ self ]]->set_data(localclientnum, "_state", 24);
																										}
																										else
																										{
																											if(#"hash_21962bee0a15424" == state_name)
																											{
																												[[ self ]]->set_data(localclientnum, "_state", 25);
																											}
																											else
																											{
																												if(#"dynobj_killzombies" == state_name)
																												{
																													[[ self ]]->set_data(localclientnum, "_state", 26);
																												}
																												else
																												{
																													if(#"hash_29a3c52abd286a3d" == state_name)
																													{
																														[[ self ]]->set_data(localclientnum, "_state", 27);
																													}
																													else
																													{
																														if(#"hash_6b6581d0506c0b19" == state_name)
																														{
																															[[ self ]]->set_data(localclientnum, "_state", 28);
																														}
																														else
																														{
																															if(#"hash_34061eae676df48d" == state_name)
																															{
																																[[ self ]]->set_data(localclientnum, "_state", 29);
																															}
																															else
																															{
																																if(#"hash_2937fe33c735a583" == state_name)
																																{
																																	[[ self ]]->set_data(localclientnum, "_state", 30);
																																}
																																else
																																{
																																	if(#"hash_4bfdec8101cde9e7" == state_name)
																																	{
																																		[[ self ]]->set_data(localclientnum, "_state", 31);
																																	}
																																	else
																																	{
																																		if(#"dynobj_killspawnbeacons" == state_name)
																																		{
																																			[[ self ]]->set_data(localclientnum, "_state", 32);
																																		}
																																		else
																																		{
																																			if(#"hash_1a4b4231363359c4" == state_name)
																																			{
																																				[[ self ]]->set_data(localclientnum, "_state", 33);
																																			}
																																			else
																																			{
																																				if(#"dynobj_killwiretrappedenemies" == state_name)
																																				{
																																					[[ self ]]->set_data(localclientnum, "_state", 34);
																																				}
																																				else
																																				{
																																					if(#"hash_5c25a457d21d00a3" == state_name)
																																					{
																																						[[ self ]]->set_data(localclientnum, "_state", 35);
																																					}
																																					else
																																					{
																																						if(#"oneline" == state_name)
																																						{
																																							[[ self ]]->set_data(localclientnum, "_state", 36);
																																						}
																																						else
																																						{
																																							if(#"hash_6e90224596225271" == state_name)
																																							{
																																								[[ self ]]->set_data(localclientnum, "_state", 37);
																																							}
																																							else
																																							{
																																								if(#"hash_52e0c66ed90c5996" == state_name)
																																								{
																																									[[ self ]]->set_data(localclientnum, "_state", 38);
																																								}
																																								else
																																								{
																																									if(#"hash_75d2922ca26f2a88" == state_name)
																																									{
																																										[[ self ]]->set_data(localclientnum, "_state", 39);
																																									}
																																									else
																																									{
																																										/#
																																											assertmsg("");
																																										#/
																																										/#
																																										#/
																																									}
																																								}
																																							}
																																						}
																																					}
																																				}
																																			}
																																		}
																																	}
																																}
																															}
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	/*
		Name: open
		Namespace: cct_shared_ingame_objective
		Checksum: 0xE131F252
		Offset: 0x418
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"ct_shared_ingame_objective");
	}

	/*
		Name: function_fa582112
		Namespace: cct_shared_ingame_objective
		Checksum: 0xB6455A91
		Offset: 0x388
		Size: 0x88
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "objectiveText", #"");
		[[ self ]]->set_data(localclientnum, "objpoints", 0);
	}

	/*
		Name: register_clientside
		Namespace: cct_shared_ingame_objective
		Checksum: 0x97961506
		Offset: 0x358
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cct_shared_ingame_objective
		Checksum: 0x3FD7B63E
		Offset: 0x2A0
		Size: 0xAC
		Parameters: 3
		Flags: None
	*/
	function setup_clientfields(uid, var_a584bc49, var_ea26adc8)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 6, "int");
		cluielem::function_dcb34c80("string", "objectiveText", 1);
		cluielem::add_clientfield("objpoints", 1, 11, "int", var_ea26adc8);
	}

}

#namespace ct_shared_ingame_objective;

/*
	Name: register
	Namespace: ct_shared_ingame_objective
	Checksum: 0xCB3D755
	Offset: 0xD0
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_a584bc49, var_ea26adc8)
{
	elem = new cct_shared_ingame_objective();
	[[ elem ]]->setup_clientfields(uid, var_a584bc49, var_ea26adc8);
	return elem;
}

/*
	Name: register_clientside
	Namespace: ct_shared_ingame_objective
	Checksum: 0x12AE69F9
	Offset: 0x130
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new cct_shared_ingame_objective();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_ingame_objective
	Checksum: 0x74944B72
	Offset: 0x178
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: ct_shared_ingame_objective
	Checksum: 0x7A2C9511
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: ct_shared_ingame_objective
	Checksum: 0xA1E98F8A
	Offset: 0x1C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_state
	Namespace: ct_shared_ingame_objective
	Checksum: 0xF162D5AB
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_objectivetext
	Namespace: ct_shared_ingame_objective
	Checksum: 0x5691ABE4
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectivetext(localclientnum, value)
{
	[[ self ]]->set_objectivetext(localclientnum, value);
}

/*
	Name: set_objpoints
	Namespace: ct_shared_ingame_objective
	Checksum: 0x91A06E5F
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objpoints(localclientnum, value)
{
	[[ self ]]->set_objpoints(localclientnum, value);
}

