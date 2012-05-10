#include "ScriptPCH.h"
#include <cstring>
#include <list>
#include "../../game/Custom/PlayerHousing.h"

enum eEnums
{
	BASE_TEXT				= 40000, 
	OFFSET_HOUSE_ID			= 20
};


class object_house_browser : public CreatureScript
{
    public:

        object_house_browser()
            : CreatureScript("object_house_browser")
        {
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
			MainMenu(player, creature, 0);
            return true;
        }

		void GenericMenu(Player *player, int option)
		{
			HouseLocationList::iterator i;
			switch(option)
			{
				case 0:
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "I'd like to see more houses", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
					break;
				case 1:
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "I'd like to see more houses", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
					break;
				case 3:
					player->CLOSE_GOSSIP_MENU();
					break;
				default:
					option = option - OFFSET_HOUSE_ID;
					PlayerHousingMgr.EnterPreviewHouse(player, option);
					break;
			}
		}

		void MainMenu(Player *player, Creature* creature, int option)
		{
			int text = 0;

			if(!player->playerhouse)
			{
				HouseLocation *location = PlayerHousingMgr.GetCurrentHouseArea(player);
				HouseLocationList::iterator i;
				int x;
				if(!location)
				{
					switch(option)
					{
						case 0:
							GenericMenu(player, option);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 1:
							text = 4;
							GenericMenu(player, option);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 2:
							text = 6;
							x = 0;
							for (i = PlayerHousingMgr.houseLocationList.begin(); i != PlayerHousingMgr.houseLocationList.end(); ++i)
							{
								HouseLocation *house = *i;
								x++;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Show me " + house->desc, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_HOUSE_ID+house->id);

								if(x == 10)
								{
									player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
									x = 0;
								}
							}
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 3:
							GenericMenu(player, option);
							break;
						default:
							GenericMenu(player, option);
							break;
					}
				}
				else // player already in house
				{
					text = 1;
					switch(option)
					{
						case 0:
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "I'd like this house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
							GenericMenu(player, option);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 1:
							text = 4;
							GenericMenu(player, option);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 2:
							text = 2;
							x = 0;
							for (i = PlayerHousingMgr.houseLocationList.begin(); i != PlayerHousingMgr.houseLocationList.end(); ++i)
							{
								HouseLocation *house = *i;
								x++;
								player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Show me " + house->desc, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_HOUSE_ID+house->id);

								if(x == 10)
								{
									player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
									x = 0;
								}
							}
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						case 3:
							GenericMenu(player, option);
							break;
						case 4:
							PlayerHousingMgr.CreateHouse(player, location->id);
							PlayerHousingMgr.EnterHouse(player, player->GetGUIDLow());
							player->SaveToDB();
							// add item
							break;
						case 5:
							text = 3;
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Yes, I want it", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "I am not sure yet", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+0);
							player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
							break;
						default:
							GenericMenu(player, option);
							break;
					}
				}
			}
			else
			{
				text = 5;
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
				player->PlayerTalkClass->SendGossipMenu(BASE_TEXT + text, creature->GetGUID());
			}
		}

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus();
			MainMenu(player, creature, uiAction - GOSSIP_ACTION_INFO_DEF);
            return true;
		}
};

void AddSC_object_house_browser()
{
    new object_house_browser();
}
