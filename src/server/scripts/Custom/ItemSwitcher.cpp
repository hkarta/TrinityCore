/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 *


    INVTYPE_HEAD                                = 1,
    INVTYPE_SHOULDERS                           = 3,
    INVTYPE_CHEST                               = 5, INVTYPE_ROBE                                = 20,
    INVTYPE_WAIST                               = 6,
    INVTYPE_LEGS                                = 7,
    INVTYPE_FEET                                = 8,
    INVTYPE_WRISTS                              = 9,
    INVTYPE_HANDS                               = 10,
    INVTYPE_WEAPON                              = 13, INVTYPE_WEAPONMAINHAND      = 21, INVTYPE_WEAPONOFFHAND         = 22,
    INVTYPE_SHIELD                              = 14,
    INVTYPE_RANGED                              = 15, INVTYPE_RANGEDRIGHT            = 26,
    INVTYPE_CLOAK                               = 16,
    INVTYPE_2HWEAPON                            = 17,
    

	SLOT_HEAD                          = 0,
    SLOT_SHOULDERS                     = 2,
    SLOT_CHEST                         = 4,
    SLOT_WAIST                         = 5,
    SLOT_LEGS                          = 6,
    SLOT_FEET                          = 7,
    SLOT_WRISTS                        = 8,
    SLOT_HANDS                         = 9,
    SLOT_BACK                          = 14,
    SLOT_MAIN_HAND                     = 15,
    SLOT_OFF_HAND                      = 16,
    SLOT_RANGED                        = 17,


	ITEM_SUBCLASS_WEAPON_AXE                    = 0,
    ITEM_SUBCLASS_WEAPON_AXE2                   = 1,
    ITEM_SUBCLASS_WEAPON_BOW                    = 2,
    ITEM_SUBCLASS_WEAPON_GUN                    = 3,
    ITEM_SUBCLASS_WEAPON_MACE                   = 4,
    ITEM_SUBCLASS_WEAPON_MACE2                  = 5,
    ITEM_SUBCLASS_WEAPON_POLEARM                = 6,
    ITEM_SUBCLASS_WEAPON_SWORD                  = 7,
    ITEM_SUBCLASS_WEAPON_SWORD2                 = 8,
    ITEM_SUBCLASS_WEAPON_obsolete               = 9,
    ITEM_SUBCLASS_WEAPON_STAFF                  = 10,
    ITEM_SUBCLASS_WEAPON_EXOTIC                 = 11,
    ITEM_SUBCLASS_WEAPON_EXOTIC2                = 12,
    ITEM_SUBCLASS_WEAPON_FIST                   = 13,
    ITEM_SUBCLASS_WEAPON_MISC                   = 14,
    ITEM_SUBCLASS_WEAPON_DAGGER                 = 15,
    ITEM_SUBCLASS_WEAPON_THROWN                 = 16,
    ITEM_SUBCLASS_WEAPON_SPEAR                  = 17,
    ITEM_SUBCLASS_WEAPON_CROSSBOW               = 18,
    ITEM_SUBCLASS_WEAPON_WAND                   = 19,
    ITEM_SUBCLASS_WEAPON_FISHING_POLE           = 20

	ITEM_SUBCLASS_ARMOR_CLOTH                   = 1,
    ITEM_SUBCLASS_ARMOR_LEATHER                 = 2,
    ITEM_SUBCLASS_ARMOR_MAIL                    = 3,
    ITEM_SUBCLASS_ARMOR_PLATE                   = 4,
    ITEM_SUBCLASS_ARMOR_SHIELD                  = 6,

	ITEM_CLASS_WEAPON                           = 2,
	ITEM_CLASS_ARMOR                            = 4,
ScriptData
SDName: Example_Gossip_Codebox
SD%Complete: 100
SDComment: Show a codebox in gossip option
SDCategory: Script Examples
EndScriptData */

#include "ScriptPCH.h"
#include <cstring>

enum eEnums
{
	OFFSET_GENERAL			= 1,
	OFFSET_REVERT			= 10,
	OFFSET_LIST				= 50,
	OFFSET_DISPLAY			= 200,

	DATABASE_SLOT_OFFSET	= 1001,

    SPELL_POLYMORPH         = 12826,
    SPELL_MARK_OF_THE_WILD  = 26990,
};


class npc_item_switcher : public CreatureScript
{
    public:

        npc_item_switcher()
            : CreatureScript("npc_item_switcher")
        {
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
			InitialList(player, creature);
			player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID());
            return true;
        }

		void InitialList(Player *player, Creature *creature)
		{
			player->itemLoader->LoadAvaiableDisplayIds();
			player->itemLoader->page = 0;
			player->itemLoader->invtype = -1;

			int x = 0;

			for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
			{
				if(x % 5 == 0 && x != 0)
					player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID());

				std::string a = "Navrat podobu ";
				std::string buff = player->itemLoader->GetItemInSlotName(i);
				if(player->itemLoader->ValidateItemInSlot(i, true) &&  buff != "")
				{
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, a + player->itemLoader->GetItemInSlotName(i), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_REVERT+i);
					x++;
				}
				else if(player->itemLoader->ValidateItemInSlot(i, false) &&  buff != "")
				{
					std::string a = "Uprav mi ";
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, a + player->itemLoader->GetItemInSlotName(i), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_LIST+i);
					x++;
				}
			}

			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "Dekuji, nemam zajem.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+1);
		}

		void ShowCategory(Player *player, Creature *creature)
		{
			
			/* iterate  
			OFFSET_GENERAL + 2
			*/
			//player->ADD_GOSSIP_ITEM
				
			AllowedItemList::iterator i;
			int x = -1;
			int first = -1;
			int last = -1;
			Item * item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, player->itemLoader->invtype);
			if(!player->itemLoader->ValidateItemInSlot(player->itemLoader->invtype, true) && player->itemLoader->ValidateItemInSlot(player->itemLoader->invtype, false))
			{
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "^^ Zpet na seznam predmetu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+2);
				for (i = player->itemLoader->allowedItemList.begin(); i != player->itemLoader->allowedItemList.end(); i++)
				{
					AllowedItem *allowedItem = *i;
					if(allowedItem->itemClass == item->GetTemplate()->Class &&
						allowedItem->subClass == item->GetTemplate()->SubClass && allowedItem->inventoryType == item->GetTemplate()->InventoryType)
					{
						x++;
						if(x >= player->itemLoader->page * player->itemLoader->perpage && x < (player->itemLoader->page + 1) * player->itemLoader->perpage)
						{
							if(first == -1)
								first = x;

							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "Zmenit na " + allowedItem->description, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_DISPLAY+allowedItem->displayId);

							last = x;
						}
					}
				}

			if(first != 0 && first != -1)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "<< Predchozi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+3);

			if(last != x)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, ">> Dalsi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+4);

			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "Dekuji, nemam zajem.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+1);
            player->PlayerTalkClass->SendGossipMenu(DATABASE_SLOT_OFFSET + player->itemLoader->invtype, creature->GetGUID());
			}
			else
			{
				InitialList(player, creature);
				player->PlayerTalkClass->SendGossipMenu(999, creature->GetGUID());
			}
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus(); //DATABASE_SLOT_OFFSET

			if(uiAction >= GOSSIP_ACTION_INFO_DEF+OFFSET_DISPLAY)
			{
				if(!player->itemLoader->ValidateItemInSlot(player->itemLoader->invtype, true) && player->itemLoader->ValidateItemInSlot(player->itemLoader->invtype, false) 
					&& player->itemLoader->GetItemInSlotName(player->itemLoader->invtype) != "")
				{
		
					Item *i = player->GetItemByPos(INVENTORY_SLOT_BAG_0, player->itemLoader->invtype);	

					if(!i)
					{
						//sLog->outString(" Skinner >> Cannot get item in slot (step 1): inventory slot = %d", player->itemLoader->invtype);
						InitialList(player, creature);
						player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID()); // Zda se, ze na zvolene pozici se nenachazi zadny predmet. Predmet musi byt po celou dobu vymeny nasazen.
					}
					else
					{
						AllowedItem * allowedItem = player->itemLoader->GetAllowedItemFromItem(i, uiAction-GOSSIP_ACTION_INFO_DEF-OFFSET_DISPLAY); 
						if(!allowedItem)
						{
							//sLog->outString(" Skinner >> Cannot get alloweditem (step 2): item entry = %d", i->GetTemplate()->ItemId);
							InitialList(player, creature);
							player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID()); //Zda se, ze pro tento predmet nemas zadne povolene zmeny.
						}
						else
						{
							int newitem = player->itemLoader->GetEntryForAllowedItem(allowedItem, i);
							if(newitem != -1)
							{
								//sLog->outString(" Skinner >> Item should be created");
								player->DestroyItem(INVENTORY_SLOT_BAG_0, player->itemLoader->invtype, true);
								Item *currentlyEquiped = player->EquipNewItem(player->itemLoader->invtype, newitem, true);
								currentlyEquiped->SendUpdateToPlayer(player);


								InitialList(player, creature);
								player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID()); // Predmet byl uspesne prekovan! Muzu ti pomoct jeste s necim?
							}
							else
							{
								//sLog->outString(" Skinner >> Cannot get entry for allowed item (step 3): item displayid = %d", allowedItem->displayId);
								InitialList(player, creature);
								player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID()); //INTERNI CHYBA 1. Hlaste gamemasterovi.
							}
						}
					}
				}
				else
				{
					InitialList(player, creature);
					player->PlayerTalkClass->SendGossipMenu(999, creature->GetGUID()); // It appears you have changed item in shoulder slot.
				}
			}
            else if (uiAction >= GOSSIP_ACTION_INFO_DEF+OFFSET_LIST) // unswitched items
            {
				player->itemLoader->invtype = uiAction-GOSSIP_ACTION_INFO_DEF-OFFSET_LIST;
				player->itemLoader->page = 0;
				ShowCategory(player, creature);
			}
			else if(uiAction >= GOSSIP_ACTION_INFO_DEF+OFFSET_REVERT) // to be removed
			{
				player->itemLoader->invtype = uiAction-GOSSIP_ACTION_INFO_DEF-OFFSET_REVERT;
				if(player->itemLoader->ValidateItemInSlot(player->itemLoader->invtype, true) && player->itemLoader->GetItemInSlotName(player->itemLoader->invtype) != "")
				{
					Item *i = player->GetItemByPos(INVENTORY_SLOT_BAG_0, player->itemLoader->invtype);
					int original = player->itemLoader->GetOriginalId(i);

					if(!i || original == -1)
					{
						InitialList(player, creature);
						player->PlayerTalkClass->SendGossipMenu(998, creature->GetGUID());
					}
					else
					{
						player->DestroyItem(INVENTORY_SLOT_BAG_0, player->itemLoader->invtype, true);
						Item *currentlyEquiped = player->EquipNewItem(player->itemLoader->invtype, original, true);
						currentlyEquiped->SendUpdateToPlayer(player);

						InitialList(player, creature);
						player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID());
					}
				}
				else
				{
					InitialList(player, creature);
					player->PlayerTalkClass->SendGossipMenu(998, creature->GetGUID()); //INTERNI CHYBA 1. Hlaste gamemasterovi.
				}
			}
			else if (uiAction >= GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL) // general menu
			{
				switch (uiAction)
                {
					case GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+1:
						player->CLOSE_GOSSIP_MENU();
						break;
					case GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+2:
						InitialList(player, creature);
						player->PlayerTalkClass->SendGossipMenu(1000, creature->GetGUID());
						break;
					case GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+3:
						player->itemLoader->page--;
						ShowCategory(player, creature);
						break;
					case GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+4:
						player->itemLoader->page++;
						ShowCategory(player, creature);
						break;
				}
			}

            return true;
		}
};

void AddSC_npc_item_switcher()
{
    new npc_item_switcher();
}
