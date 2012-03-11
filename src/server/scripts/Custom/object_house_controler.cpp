#include "ScriptPCH.h"
#include <cstring>

enum eEnums
{
	OFFSET_GENERAL			= 0,
	OFFSET_REVERT			= 10,
	OFFSET_LIST				= 50,
	OFFSET_DISPLAY			= 200,

	DATABASE_SLOT_OFFSET	= 1001,

    SPELL_POLYMORPH         = 12826,
    SPELL_MARK_OF_THE_WILD  = 26990,
};


class object_house_controler : public CreatureScript
{
    public:

        object_house_controler()
            : CreatureScript("object_house_controler")
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

void AddSC_object_house_controler()
{
    new object_house_controler();
}
