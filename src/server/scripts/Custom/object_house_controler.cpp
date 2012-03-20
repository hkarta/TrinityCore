#include "ScriptPCH.h"
#include <cstring>
#include "../../game/Custom/PlayerHousing.h"
#include <regex>

enum eEnums
{
	OFFSET_ADD_SOMETHING = 20,
	SOFT_LIMIT			 = 20,
	SOFT_FRIENDS		 = 5
};


class object_house_controler : public CreatureScript
{
    public:

        object_house_controler()
            : CreatureScript("object_house_controler")
        {
        }

		void SelectNpcGo(Player *player, Creature *creature)
		{
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			if(player->playerhouse)
			{
				int perpage = 8;
				int i = 0;
				int x = 0;
				HouseItemList::iterator j;
				for (j = player->playerhouse->houseItemList.begin(); j != player->playerhouse->houseItemList.end(); ++j)
				{
					HouseItem *item = *j;
					if(!item->spawned && item->type == 0)
					{
						if(i >= player->pagehelper * perpage && i < (player->pagehelper + 1) * perpage)
						{
							if(item->entry < 0)
							{
								std::string name = "Pridat npc: " + PlayerHousingMgr.GetVendorItem(item->entry, false)->desc;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_ADD_SOMETHING+item->id);
							}
							else
							{
								std::string name = "Pridat objekt: " + PlayerHousingMgr.GetVendorItem(item->entry, false)->desc;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_ADD_SOMETHING+item->id);
							}
						}
						i++;
					}
					else if (item->spawned && item->type == 0)
						x++;
				}

				if(player->pagehelper != 0)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "<< Predchozi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
				if(i - (player->pagehelper * perpage) > perpage)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, ">> Dalsi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, append(append("Spawnnute npc a objekty [", x) + "/", SOFT_LIMIT) + "]", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
			}
		}

		void Guests(Player *player, Creature *creature)
		{
			int perpage = 7;
			int total = player->playerhouse->houseGuests.size();
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			if(total < SOFT_FRIENDS)
				player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, "Pridat zvaneho hosta", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+9,
					"Zadej jmeno hrace, kteremu chces umoznit pristup do sveho domu.", 0, true);
			else 
				perpage++;

			int i = 0;
			player->playerhouse->houseGuests.sort();
			HouseGuests::iterator g;
			for (g = player->playerhouse->houseGuests.begin(); g != player->playerhouse->houseGuests.end(); ++g)
			{
				if(i >= player->pagehelper * perpage && i < (player->pagehelper + 1) * perpage)
				{
					HouseGuest *houseGuest = *g;
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Zakazat vstup hraci " + houseGuest->name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_ADD_SOMETHING+houseGuest->guid);
				}
				i++;
			}
			if(player->pagehelper != 0)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "<< Predchozi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
			if(i - (player->pagehelper * perpage) > perpage)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, ">> Dalsi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, append(append("Zvani hoste [", total) + "/", SOFT_FRIENDS) + "]", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
			
		}

		void MainMenu(Player *player, Creature *creature)
		{
			player->pagehelper = 0;
			player->categoryhelper = 0;
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Smazat objekt/npc v me blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Pridat objekt/npc na mou pozici", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Osoby opravnene ke vstupu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Nakoupit vybaveni", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+12);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Chtel bych jiny dum...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+9);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Prenest na vychozi pozici", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Odejit z domu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID()); // TODO MAIN MENU TEXT
		}

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus(); //DATABASE_SLOT_OFFSET
			if(player->playerhouse && PlayerHousingMgr.GetCurrentHouseArea(player))
			{
				if(player->house == player->playerhouse->GetPhase() && PlayerHousingMgr.GetCurrentHouseArea(player)->id == player->playerhouse->houseTemplate->id)
				{
					if(uiAction == GOSSIP_ACTION_INFO_DEF)
					{
						MainMenu(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 1) // Delete go or creature?
					{
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
						GameObject *object = player->playerhouse->GetNearestObject(player, creature);
						if(object)
						{
							std::string name = "Smazat objekt: " + PlayerHousingMgr.GetVendorItem((int)object->GetGOData()->id, false)->desc;
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5); // REMOVE OBJECT
						}
						else
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zadny objekt ve tve blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

						Creature *creature2 = player->playerhouse->GetNearestCreature(player, creature);
						if(creature2)
						{
							std::string name = "Smazat npc: " + PlayerHousingMgr.GetVendorItem((int)creature2->GetCreatureData()->id * (-1), false)->desc;
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6); // REMOVE NPC
						}
						else
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zadne npc ve tve blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 2)
					{
						player->pagehelper = 0;
						player->categoryhelper = 2;
						SelectNpcGo(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 3)
					{
						player->pagehelper--;
						if(player->categoryhelper == 2)
							SelectNpcGo(player, creature);
						else if(player->categoryhelper == 8)
							Guests(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 4)
					{
						player->pagehelper++;
						if(player->categoryhelper == 2)
							SelectNpcGo(player, creature);
						else if(player->categoryhelper == 8)
							Guests(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 5) // delete go
					{
						PlayerHousingMgr.RemoveGameObject(player, player->playerhouse->GetNearestObject(player, creature));
						MainMenu(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 6) // delete npc
					{
						PlayerHousingMgr.RemoveCreature(player, player->playerhouse->GetNearestCreature(player, creature));
						MainMenu(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 7) // Base loc
					{
						player->TeleportTo(player->playerhouse->houseTemplate->map, player->playerhouse->houseTemplate->x, player->playerhouse->houseTemplate->y, 
							player->playerhouse->houseTemplate->z, player->playerhouse->houseTemplate->o);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 8) // who can enter
					{
						player->pagehelper = 0;
						player->categoryhelper = 8;

						Guests(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 9) // delete house
					{
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Ne, rozmyslel jsem si to", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Ano, chci zrusit tento dum", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+10);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 10) // delete house finish
					{
						player->playerhouse->PackHouse(player);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 11) // leave house
					{
						PlayerHousingMgr.LeaveHouse(player);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 12) // house acessories
					{
						if(player->summon)
							player->summon->DespawnOrUnsummon(0);
						player->summon = player->SummonCreature(221, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);

						player->currentVendorEntry = -1;
						player->GetSession()->SendListInventory(player->summon->GetGUID());
					}
					else if(uiAction > GOSSIP_ACTION_INFO_DEF + OFFSET_ADD_SOMETHING)
					{
						if(player->categoryhelper == 2)
						{
							HouseItemList::iterator j;
							uint32 id = uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_ADD_SOMETHING;
							HouseItem *result = NULL;
							int x = 0;
							for (j = player->playerhouse->houseItemList.begin(); j != player->playerhouse->houseItemList.end(); ++j)
							{
								HouseItem *item = *j;
								if(item->id == id)
								{
									result = item;
								}

								if(item->spawned)
									x++;
							}
							if(result)
							{
								if(x < SOFT_LIMIT)
								{
									if(result->entry < 0)
										PlayerHousingMgr.SpawnCreature(player, result->entry);
									else
										PlayerHousingMgr.SpawnGameObject(player, result->entry);
									player->pagehelper = 0;
								}
								SelectNpcGo(player, creature);
							}
						}
						else if(player->categoryhelper == 8)
						{
							if(uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_ADD_SOMETHING != player->GetGUIDLow())
							{
								PlayerHousingMgr.GuestChange(player, uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_ADD_SOMETHING, false);
							}
							player->pagehelper = 0;
							Guests(player, creature);
						}
					}
				}
			}
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
            return true;
		}

		bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
        {
            player->PlayerTalkClass->ClearMenus();
            if (sender == GOSSIP_SENDER_MAIN)
            {
                if(action == GOSSIP_ACTION_INFO_DEF+9)
				{
					
					bool contains_non_alpha
						= !std::regex_match(code, std::regex("^[A-Za-z]+$"));

					if(!contains_non_alpha)
					{
						PlayerHousingMgr.GuestChange(player, PlayerHousingMgr.GetPlayerGuidByName(code), true);
					}
					Guests(player, creature);
                }
            }
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
            return true;
        }

		std::string append(std::string str, int i)
		{
			std::stringstream s;
			s << str << i;
			return s.str();
		}
};

void AddSC_object_house_controler()
{
    new object_house_controler();
}
