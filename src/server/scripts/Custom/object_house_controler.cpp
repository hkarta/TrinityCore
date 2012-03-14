#include "ScriptPCH.h"
#include <cstring>
#include "../../game/Custom/PlayerHousing.h"

enum eEnums
{
	OFFSET_ADD_SOMETHING = 20,
	SOFT_LIMIT			 = 20
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
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			if(player->house)
			{
				int perpage = 8;
				int i = 0;
				int x = 0;
				HouseItemList::iterator j;
				for (j = player->house->houseItemList.begin(); j != player->house->houseItemList.end(); ++j)
				{
					HouseItem *item = *j;
					if(!item->spawned && item->type == 0)
					{
						if(i >= player->pagehelper * perpage && i < (player->pagehelper + 1) * perpage)
						{
							if(item->entry < 0)
							{
								std::string name = "Pridat npc: " + PlayerHousingMgr.GetVendorItem(item->entry, false)->desc;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_ADD_SOMETHING+item->id);
							}
							else
							{
								std::string name = "Pridat objekt: " + PlayerHousingMgr.GetVendorItem(item->entry, false)->desc;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_ADD_SOMETHING+item->id);
							}
						}
						i++;
					}
					else if (item->spawned && item->type == 0)
						x++;
				}

				if(player->pagehelper != 0)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<< Predchozi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
				if(i - (player->pagehelper * perpage) > perpage)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, ">> Dalsi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, append(append("Spawnnute npc a objekty [", x) + "/", SOFT_LIMIT) + "]", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
			}
		}

		void MainMenu(Player *player, Creature *creature)
		{
			player->pagehelper = 0;
			player->categoryhelper = 0;
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Smazat objekt/npc v me blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pridat objekt/npc na mou pozici", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Osoby opravnene ke vstupu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Nakoupit vybaveni", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Chtel bych jiny dum...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Jake vyhody ma VIP hrac ve svem dome?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID()); // TODO MAIN MENU TEXT
		}

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus(); //DATABASE_SLOT_OFFSET
			if(player->house)
			{
				if(player->GetPhaseMask() == player->house->GetPhase())
				{
					if(uiAction == GOSSIP_ACTION_INFO_DEF)
					{
						MainMenu(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 1) // Delete go or creature?
					{
						GameObject *object = player->house->GetNearestObject(player, creature);
						if(object)
						{
							std::string name = "Smazat objekt: " + PlayerHousingMgr.GetVendorItem((int)object->GetGOData()->id, false)->desc;
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5); // REMOVE OBJECT
						}
						else
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zadny objekt ve tve blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

						Creature *creature2 = player->house->GetNearestCreature(player, creature);
						if(creature2)
						{
							std::string name = "Smazat npc: " + PlayerHousingMgr.GetVendorItem((int)creature2->GetCreatureData()->id * (-1), false)->desc;
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, name, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6); // REMOVE NPC
						}
						else
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zadne npc ve tve blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
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
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 4)
					{
						player->pagehelper++;
						if(player->categoryhelper == 2)
							SelectNpcGo(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 5) // delete go
					{
						PlayerHousingMgr.RemoveGameObject(player, player->house->GetNearestObject(player, creature));
						MainMenu(player, creature);
					}
					else if(uiAction == GOSSIP_ACTION_INFO_DEF + 6) // delete npc
					{
						PlayerHousingMgr.RemoveCreature(player, player->house->GetNearestCreature(player, creature));
						MainMenu(player, creature);
					}
					else if(uiAction > GOSSIP_ACTION_INFO_DEF + OFFSET_ADD_SOMETHING)
					{
						if(player->categoryhelper == 2)
						{
							HouseItemList::iterator j;
							uint32 id = uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_ADD_SOMETHING;
							HouseItem *result = NULL;
							int x = 0;
							for (j = player->house->houseItemList.begin(); j != player->house->houseItemList.end(); ++j)
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
					}
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
