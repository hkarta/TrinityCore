#include "gamePCH.h"
#include "ItemLoader.h"
#include <list>
#include <string>
#include "Item.h"
#include "ObjectMgr.h"
#include "GossipDef.h"

ItemLoader::ItemLoader(Player *owner)
{
	this->owner = owner;
	lastRefresh = 0;//getMSTime(); //GetMSTimeDiffToNow(oldMSTime)
	refreshTime = 1;
	perpage = 9;    		
}


ItemLoader::~ItemLoader(void)
{
}

AllowedItem* ItemLoader::GetAllowedItemFromItem(Item *item, int displayid)
{
	AllowedItemList::iterator i;
	
	bool passed = false;
	for (i = allowedItemList.begin(); i != allowedItemList.end(); i++)
	{
		AllowedItem *allowedItem = *i;
		//sLog->outString("   >> Now testing allowed item %u", allowedItem->displayId);
		if(allowedItem->itemClass == item->GetTemplate()->Class &&
			allowedItem->subClass == item->GetTemplate()->SubClass && allowedItem->inventoryType == item->GetTemplate()->InventoryType 
			&& allowedItem->displayId == displayid)
			return allowedItem;
	}

	return NULL;
}

Item* ItemLoader::GetItemInSlot(int slot)
{
	Item * item = owner->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

	if(!item)
		return NULL;
	else return item;
}

int ItemLoader::GetEntryForAllowedItem(AllowedItem *item, Item *baseitem)
{
	//todo timer
	QueryResult result = WorldDatabase.PQuery("SELECT entry FROM _customitems WHERE displayID = %d AND class = %d AND subclass = %d AND inventoryType = %d AND basedOnItem = %d LIMIT 1", 
		item->displayId, item->itemClass, item->subClass, item->inventoryType, baseitem->GetTemplate()->ItemId);
	//													  0		 1		   2			  3			 4			  5  
	if (result)
	{		
		Field *fields = result->Fetch();
		sLog->outString("      >> Found item id: %d", fields[0].GetInt32());
		return fields[0].GetInt32();
	}
	else
	{

		QueryResult result = WorldDatabase.PQuery("SELECT entry FROM _customitems WHERE displayID = 0 AND class = %d AND subclass = %d AND inventoryType = %d AND basedOnItem = 0 LIMIT 1", 
		item->itemClass, item->subClass, item->inventoryType);
		//													  0		 1		   2			  3			 4			  5  
		if (result)
		{
			Field *fields = result->Fetch();
			sLog->outString("      >> Found matching unused item entry: %d", fields[0].GetInt32());
			int sheath = item->sheath;
			if(sheath == -1)
				sheath = baseitem->GetTemplate()->Sheath;

			WorldDatabase.DirectPExecute("REPLACE INTO item_template " 
											"(entry, class, subclass, unk0, name, displayid, Quality, Flags, FlagsExtra, BuyCount, BuyPrice, SellPrice, InventoryType, "
    //                                              13              14           15          16             17               18                19              20
                                             "AllowableClass, AllowableRace, ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell, requiredhonorrank, "
    //                                              21                      22                       23               24        25          26             27           28
                                             "RequiredCityRank, RequiredReputationFaction, RequiredReputationRank, maxcount, stackable, ContainerSlots, StatsCount, stat_type1, "
    //                                            29           30          31           32          33           34          35           36          37           38
                                             "stat_value1, stat_type2, stat_value2, stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5, stat_type6, "
    //                                            39           40          41           42           43          44           45           46           47
                                             "stat_value6, stat_type7, stat_value7, stat_type8, stat_value8, stat_type9, stat_value9, stat_type10, stat_value10, "
    //                                                   48                    49           50        51        52         53        54         55      56      57        58
                                             "ScalingStatDistribution, ScalingStatValue, dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, "
    //                                            59          60         61          62       63       64            65            66          67               68
                                             "nature_res, frost_res, shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1, spellcharges_1, "
    //                                              69              70                71                 72                 73           74               75
                                             "spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1, spellid_2, spelltrigger_2, spellcharges_2, "
    //                                              76               77              78                  79                 80           81               82
                                             "spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, "
    //                                              83               84              85                  86                 87           88               89
                                             "spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, "
    //                                              90               91              92                  93                  94          95               96
                                             "spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5, spellcharges_5, "
    //                                              97               98              99                  100                 101        102         103       104          105
                                             "spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5, bonding, description, PageText, LanguageID, PageMaterial, "
    //                                            106       107     108      109          110            111       112     113         114       115   116     117
                                             "startquest, lockid, Material, sheath, RandomProperty, RandomSuffix, block, itemset, MaxDurability, area, Map, BagFamily, "
    //                                            118             119             120             121             122            123              124            125
                                             "TotemCategory, socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3, socketBonus, "
    //                                            126                 127                     128            129            130            131         132         133
                                             "GemProperties, RequiredDisenchantSkill, ArmorDamageModifier, Duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, "
    //                                           134        135            136
                                             "FoodType, minMoneyLoot, maxMoneyLoot)" 

											 "SELECT %d, class, subclass, unk0, name, %d, Quality, Flags, FlagsExtra, BuyCount, BuyPrice, SellPrice, InventoryType, "
    //                                              13              14           15          16             17               18                19              20
											"AllowableClass, AllowableRace, ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell, requiredhonorrank, "
	//                                              21                      22                       23               24        25          26             27           28
											"RequiredCityRank, RequiredReputationFaction, RequiredReputationRank, maxcount, stackable, ContainerSlots, StatsCount, stat_type1, "
	//                                            29           30          31           32          33           34          35           36          37           38
											"stat_value1, stat_type2, stat_value2, stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5, stat_type6, "
	//                                            39           40          41           42           43          44           45           46           47
											"stat_value6, stat_type7, stat_value7, stat_type8, stat_value8, stat_type9, stat_value9, stat_type10, stat_value10, "
	//                                                   48                    49           50        51        52         53        54         55      56      57        58
											"ScalingStatDistribution, ScalingStatValue, dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, "
	//                                            59          60         61          62       63       64            65            66          67               68
											"nature_res, frost_res, shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1, spellcharges_1, "
	//                                              69              70                71                 72                 73           74               75
											"spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1, spellid_2, spelltrigger_2, spellcharges_2, "
	//                                              76               77              78                  79                 80           81               82
											"spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, "
	//                                              83               84              85                  86                 87           88               89
											"spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, "
	//                                              90               91              92                  93                  94          95               96
											"spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5, spellcharges_5, "
	//                                              97               98              99                  100                 101        102         103       104          105
											"spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5, bonding, description, PageText, LanguageID, PageMaterial, "
	//                                            106       107     108      109          110            111       112     113         114       115   116     117
											"startquest, lockid, Material, %d, RandomProperty, RandomSuffix, block, itemset, MaxDurability, area, Map, BagFamily, "
	//                                            118             119             120             121             122            123              124            125
											"TotemCategory, socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3, socketBonus, "
	//                                            126                 127                     128            129            130            131         132         133
											"GemProperties, RequiredDisenchantSkill, ArmorDamageModifier, Duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, "
	//                                           134        135            136
											"FoodType, minMoneyLoot, maxMoneyLoot FROM item_template WHERE entry = %d", fields[0].GetInt32(), item->displayId, sheath, baseitem->GetTemplate()->ItemId);
			sLog->outString("      >> Executed it directly...");
			if(sObjectMgr->AddOrReloadItem(fields[0].GetInt32()))
			{
				sLog->outString("      >> Custom item created: %d", fields[0].GetInt32());
				WorldDatabase.PExecute("UPDATE _customitems SET basedOnItem = %d, displayID = %d WHERE entry = %d", baseitem->GetTemplate()->ItemId, item->displayId, fields[0].GetInt32());
				return fields[0].GetInt32();
			}
			else
				sLog->outString("      >> Reload failed.", fields[0].GetInt32());
		}
		else
		{
			sLog->outString("   >> Cannot select item placeholder");
		}
	}

	sLog->outString("   >> Item creation failed or item not found");
	return -1;
}

int ItemLoader::GetOriginalId(Item *i)
{
	QueryResult result = WorldDatabase.PQuery("SELECT basedOnItem FROM _customitems WHERE entry = %d LIMIT 1", 
		i->GetTemplate()->ItemId);
	//													  0		
	if (result)
	{
		Field *fields = result->Fetch();
		return fields[0].GetInt32();
	}

	return -1;
}

bool ItemLoader::ValidateItemInSlot(int slot, bool remove)
{
	//sLog->outString(">> Entering check for item slot %u", slot);
	Item * item = owner->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
	if(!item)
		return false;

	AllowedItemList::iterator i;
	
	bool passed = false;
	for (i = allowedItemList.begin(); i != allowedItemList.end(); i++)
	{
		AllowedItem *allowedItem = *i;
		//sLog->outString("   >> Now testing allowed item %u", allowedItem->displayId);
		if(allowedItem->itemClass == item->GetTemplate()->Class &&
			allowedItem->subClass == item->GetTemplate()->SubClass && allowedItem->inventoryType == item->GetTemplate()->InventoryType)
		{
			//sLog->outString("       >> Passed first check");
			if(remove)
			{
				if(allowedItem->displayId == item->GetTemplate()->DisplayInfoID)
				{
					//sLog->outString("           >> I was removing and item passed");
					return true;
					
				}
				//sLog->outString("           >> I was removing and item did not passed");
			}
			else
			{
				if(allowedItem->displayId == item->GetTemplate()->DisplayInfoID)
				{
					//sLog->outString("           >> I was not removing and item failed check 2");
					return false;
				}
				else
					passed = true;
			}
		}
	}
	      
	//sLog->outString("   >> Let final pass decide");

	if(remove)
		return false;
	else if(passed)
		return true;
	else
		return false;
}

std::string ItemLoader::GetItemInSlotName(int slot)
{
	Item * item = owner->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

	if(!item)
		return "";
	return item->GetTemplate()->Name1;
}

void ItemLoader::LoadAvaiableDisplayIds()
{
	if(lastRefresh == 0 || lastRefresh + refreshTime < getMSTime())
	{
		allowedItemList.clear();
		QueryResult result = CharacterDatabase.PQuery("SELECT class, subclass, inventoryType, displayId, description, sheath FROM character_item_morphs WHERE `character` = %u", owner->GetGUIDLow());
		//													  0		 1		   2			  3			 4			  5
		if (result)
		{
			do
			{
				Field *fields = result->Fetch();
				int itemClass = fields[0].GetInt32();
				int subClass = fields[1].GetInt32();
				int inventoryType = fields[2].GetInt32();
				int displayId = fields[3].GetInt32();
				int sheath = fields[5].GetInt32();
				std::string description = fields[4].GetString();
				allowedItemList.push_back(new AllowedItem(itemClass, subClass, inventoryType, displayId, description, sheath));
			}
    		while (result->NextRow());
		}
		lastRefresh = getMSTime(); 
	}
}

AllowedItem::AllowedItem(int itemClass, int subClass, int inventoryType, int displayId, std::string description, int sheath)
{
	this->itemClass = itemClass;
	this->subClass = subClass;
	this->inventoryType = inventoryType;
	this->displayId = displayId;
	this->description = description;
	this->sheath = sheath;
}