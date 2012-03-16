#include "ScriptPCH.h"
#include <cstring>

enum eEnums
{
	OFFSET_GENERAL			= 10,
};


class object_house_npc : public CreatureScript
{
    public:

        object_house_npc()
            : CreatureScript("object_house_npc")
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
			player->pagehelper = 0;
			player->categoryhelper = 0;

			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Vstup do domu sveho znameho", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Vstup do domu sve guildy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1); 
			player->PlayerTalkClass->SendGossipMenu(999, creature->GetGUID());
		}

		void ShowFriends(Player *player, Creature *creature)
		{
			int perpage = 9;
			int total = player->allowedHouses.size();
			int i = 0;
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Zpet do menu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
			player->allowedHouses.sort();
			AllowedHousesNames::iterator j;
			for (j = player->allowedHouses.begin(); j != player->allowedHouses.end(); ++j)
			{
				if(i >= player->pagehelper * perpage && i < (player->pagehelper + 1) * perpage)
				{
					HouseName *name = *j;
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Navstivit " + name->name, 
						GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+OFFSET_GENERAL+name->guid);
				}
				i++;
			}

			if(player->pagehelper != 0)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "<< Predchozi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
			if(i - (player->pagehelper * perpage) > perpage)
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, ">> Dalsi strana", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus(); //DATABASE_SLOT_OFFSET
			if(uiAction == GOSSIP_ACTION_INFO_DEF + 1)
			{
				InitialList(player, creature);
			}
			else if(uiAction == GOSSIP_ACTION_INFO_DEF + 2)
			{
				player->pagehelper = 0;
				player->categoryhelper = 2;
				ShowFriends(player, creature);
			}
			else if(uiAction == GOSSIP_ACTION_INFO_DEF + 3)
			{
				player->pagehelper++;
				ShowFriends(player, creature);
			}
			else if(uiAction == GOSSIP_ACTION_INFO_DEF + 4)
			{
				player->pagehelper--;
				ShowFriends(player, creature);
			}
			else if(uiAction > GOSSIP_ACTION_INFO_DEF + OFFSET_GENERAL)
			{
				House *house = PlayerHousingMgr.GetPlayerHouse(uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_GENERAL);
				if(PlayerHousingMgr.CanEnterGuildHouse(player, house))
				{
					PlayerHousingMgr.EnterGuildHouse(player, uiAction - GOSSIP_ACTION_INFO_DEF - OFFSET_GENERAL);
				}
			}
			player->PlayerTalkClass->SendGossipMenu(999, creature->GetGUID()); // It appears you have changed item in shoulder slot.

			return true;
		}
};

void AddSC_object_house_npc()
{
    new object_house_npc();
}
