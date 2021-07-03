## These functions are used to either upgrade format on properties. delete obsolete properties. or set default values for new properties

boolean trackingSplitterFixer(string oldSetting, int day, string newSetting)
{
	string setting = get_property(oldSetting);
	if(setting == "")
	{
		return false;
	}

	matcher cleanSpaces = create_matcher(", ", setting);
	setting = replace_all(cleanSpaces, ",");
	string[int] retval = split_string(setting, ",");
	foreach x in retval
	{
		if(retval[x] == "")
		{
			continue;
		}
		matcher dayAdder = create_matcher("[(]", retval[x]);
		retval[x] = replace_all(dayAdder, "(" + day + ":");
		if(get_property(newSetting) != "")
		{
			set_property(newSetting, get_property(newSetting) + "," + retval[x]);
		}
		else
		{
			set_property(newSetting, retval[x]);
		}
	}
	set_property(oldSetting, "");
	return true;
}

void auto_settingsUpgrade()
{
	//upgrade settings from old format to new format
	if(get_property("auto_debug") == "true")
	{
		set_property("auto_logLevel", "debug");
	}

	trackingSplitterFixer("auto_banishes_day1", 1, "auto_banishes");
	trackingSplitterFixer("auto_banishes_day2", 2, "auto_banishes");
	trackingSplitterFixer("auto_banishes_day3", 3, "auto_banishes");
	trackingSplitterFixer("auto_banishes_day4", 4, "auto_banishes");
	trackingSplitterFixer("auto_yellowRay_day1", 1, "auto_yellowRays");
	trackingSplitterFixer("auto_yellowRay_day2", 2, "auto_yellowRays");
	trackingSplitterFixer("auto_yellowRay_day3", 3, "auto_yellowRays");
	trackingSplitterFixer("auto_yellowRay_day4", 4, "auto_yellowRays");
	trackingSplitterFixer("auto_lashes_day1", 1, "auto_lashes");
	trackingSplitterFixer("auto_lashes_day2", 2, "auto_lashes");
	trackingSplitterFixer("auto_lashes_day3", 3, "auto_lashes");
	trackingSplitterFixer("auto_lashes_day4", 4, "auto_lashes");
	trackingSplitterFixer("auto_renenutet_day1", 1, "auto_renenutet");
	trackingSplitterFixer("auto_renenutet_day2", 2, "auto_renenutet");
	trackingSplitterFixer("auto_renenutet_day3", 3, "auto_renenutet");
	trackingSplitterFixer("auto_renenutet_day4", 4, "auto_renenutet");

	if(get_property("auto_100familiar") == "yes")
	{
		set_property("auto_100familiar", my_familiar());
	}
	if(get_property("auto_100familiar") == "no")
	{
		set_property("auto_100familiar", $familiar[none]);
	}
	if(get_property("auto_100familiar") == "false")
	{
		set_property("auto_100familiar", $familiar[none]);
	}
	if(get_property("auto_killingjar") == "done")
	{
		set_property("auto_killingjar", "finished");
	}
	
	if(get_property("auto_wandOfNagamar") == "yes")
	{
		set_property("auto_wandOfNagamar", true);
	}
	if(get_property("auto_wandOfNagamar") == "no")
	{
		set_property("auto_wandOfNagamar", false);
	}
	if(get_property("auto_chasmBusted") == "yes")
	{
		set_property("auto_chasmBusted", true);
	}
	if(get_property("auto_chasmBusted") == "no")
	{
		set_property("auto_chasmBusted", false);
	}

	if(get_property("auto_edDelayTimer") != "")
	{
		set_property("auto_delayTimer", get_property("auto_edDelayTimer"));
	}
	if(get_property("auto_grimstoneFancyOilPainting") == "need")
	{
		set_property("auto_grimstoneFancyOilPainting", true);
	}
	if(get_property("auto_grimstoneFancyOilPainting") == "no")
	{
		set_property("auto_grimstoneFancyOilPainting", false);
	}
	if(get_property("auto_grimstoneOrnateDowsingRod") == "need")
	{
		set_property("auto_grimstoneOrnateDowsingRod", true);
	}
	if(get_property("auto_grimstoneOrnateDowsingRod") == "no")
	{
		set_property("auto_grimstoneOrnateDowsingRod", false);
	}

	if(get_property("auto_abooclover") == "used")
	{
		set_property("auto_abooclover", false);
	}
	if(get_property("lastPlusSignUnlock") == "true")
	{
		auto_log_debug("lastPlusSignUnlock was changed to a boolean, fixing...", "red");
		set_property("lastPlusSignUnlock", my_ascensions());
	}
	if(get_property("lastTempleUnlock") == "true")
	{
		auto_log_debug("lastTempleUnlock was changed to a boolean, fixing...", "red");
		set_property("lastTempleUnlock", my_ascensions());
	}
	if(get_property("auto_consumeKeyLimePies") != "")
	{
		set_property("auto_dontConsumeKeyLimePies", !get_property("auto_consumeKeyLimePies").to_boolean());
	}
}

void auto_settingsFix()
{
	//fix settings where user inputted an invalid value
	if(get_property("auto_save_adv_override").to_int() < -1)
	{
		set_property("auto_save_adv_override", -1);		//values lower than -1 are not valid
	}
}

void auto_settingsDelete()
{
	//delete obsolete settings
	remove_property("auto_debug");
	remove_property("auto_sonata");
	remove_property("auto_edDelayTimer");	//replaced with auto_delayTimer that works in all paths
	remove_property("auto_cubeItems");
	remove_property("auto_useCubeling");
	remove_property("auto_pullPVPJunk");
	remove_property("auto_day1_init");		//old day initialization trackers
	remove_property("auto_day2_init");		//old day initialization trackers
	remove_property("auto_day3_init");		//old day initialization trackers
	remove_property("auto_day4_init");		//old day initialization trackers
	remove_property("auto_gaudy");		//Some lingering stuff from when gaudy pirates mattered is still here
	remove_property("auto_beta_test");		//Beta testing features should be guarded behind their own individual properties
	remove_property("auto_invaderKilled");		//No longer need to track the invaders status ourselves as mafia does it now
	remove_property("auto_airship");
	remove_property("auto_ballroom");
	remove_property("auto_ballroomflat");
	remove_property("auto_ballroomopen");
	remove_property("auto_ballroomsong");
	remove_property("auto_bat");
	remove_property("auto_bean");
	remove_property("auto_blackfam");
	remove_property("auto_blackmap");
	remove_property("auto_boopeak");
	remove_property("auto_castlebasement");
	remove_property("auto_castleground");
	remove_property("auto_castletop");
	remove_property("auto_consumption");
	remove_property("auto_crypt");
	remove_property("auto_day1_cobb");
	remove_property("auto_fcle");
	remove_property("auto_friars");
	remove_property("auto_goblinking");
	remove_property("auto_gremlins");
	remove_property("auto_gremlinBanishes");
	remove_property("auto_gunpowder");
	remove_property("auto_hiddenapartment");
	remove_property("auto_hiddenbowling");
	remove_property("auto_hiddencity");
	remove_property("auto_hiddenhospital");
	remove_property("auto_hiddenoffice");
	remove_property("auto_hiddenunlock");
	remove_property("auto_hiddenzones");
	remove_property("auto_highlandlord");
	remove_property("auto_masonryWall");
	remove_property("auto_mcmuffin");
	remove_property("auto_mistypeak");
	remove_property("auto_mosquito");
	remove_property("auto_nuns");
	remove_property("auto_oilpeak");
	remove_property("auto_orchard");
	remove_property("auto_palindome");
	remove_property("auto_phatloot");
	remove_property("auto_forcePhatLootToken");
	remove_property("auto_prewar");
	remove_property("auto_prehippy");
	remove_property("auto_pirateoutfit");
	remove_property("auto_trytower");
	remove_property("auto_shenCopperhead");
	remove_property("auto_spookyfertilizer");
	remove_property("auto_spookymap");
	remove_property("auto_spookyravensecond");
	remove_property("auto_spookysapling");
	remove_property("auto_sonofa");
	remove_property("auto_sorceress");
	remove_property("auto_swordfish");
	remove_property("auto_tavern");
	remove_property("auto_trapper");
	remove_property("auto_treecoin");
	remove_property("auto_twinpeak");
	remove_property("auto_twinpeakprogress");
	remove_property("auto_war");
	remove_property("auto_winebomb");
	remove_property("auto_clearCombatScripts");
	remove_property("auto_legacyConsumeStuff");		//Knapsack consumption algorithm is now for everyone
	remove_property("betweenAdventureScript");		//might be an old mafia property that was renamed but it does nothing now
	remove_property("auto_copperhead");		//Mafia added tracking for the Copperhead Club non-combat so this is no longer necesssary
	remove_property("auto_mineForOres");		//Automated Ore mining in hardcore is now for everyone!
	remove_property("auto_hpAutoRecoveryItems");
	remove_property("auto_hpAutoRecovery");
	remove_property("auto_hpAutoRecoveryTarget");
	remove_property("auto_skipDesert");
	remove_property("auto_shenStarted");
	remove_property("auto_breakstone");
	remove_property("auto_aftercore");
	remove_property("auto_aboocount");
	remove_property("auto_dinseyGarbageMoney");
	remove_property("auto_lastABooConsider");
	remove_property("auto_lastABooCycleFix");
	remove_property("auto_longConMonster");
	remove_property("auto_voidWarranty");
	remove_property("auto_kingLiberation");
	remove_property("auto_borrowedTimeOnLiberation");
	remove_property("auto_xiblaxianChoice");
	remove_property("auto_extrudeChoice");
	remove_property("auto_consumeKeyLimePies");
	remove_property("auto_shareMaximizer");
	remove_property("auto_allowSharingData");
	remove_property("auto_mummeryChoice");
	remove_property("auto_choice1119");
	remove_property("auto_useTatter");				//obsolete combat directive to use [Tattered Scrap Of Paper] to escape combat
}

void defaultConfig(string prop, string val)
{
	//this function is used to configure default values. it only makes a change if the current value is nothing
	if(get_property(prop) == "")			//property currently not set to anything.
	{
		auto_log_info(prop+ " has no value set. setting it to the default value of " +val);
		set_property(prop,val);
	}
}

void auto_settingsDefaults()
{
	//set default values for settings which have not yet been configured
	defaultConfig("auto_delayTimer", "1");
	defaultConfig("auto_abooclover", "true");		//Are we considering using a clover at A-Boo Peak?
	defaultConfig("auto_paranoia", "-1");
	defaultConfig("auto_inv_paranoia", "false");
	defaultConfig("auto_save_adv_override", "-1");
}

void auto_settings()
{
	auto_settingsUpgrade();		//upgrade settings from old format to new format
	auto_settingsFix();			//fix settings where user inputted an invalid value
	auto_settingsDelete();		//delete obsolete settings
	auto_settingsDefaults();	//set default values for settings which have not yet been configured
}
