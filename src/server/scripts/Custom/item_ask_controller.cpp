#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "GuildMgr.h"
#include "../../game/Custom/PlayerHousing.h"
#include <list>

class item_ask_controller : public ItemScript
{
    public:

        item_ask_controller()
            : ItemScript("item_ask_controller")
        {
        }

        bool OnUse(Player *player, Item *item, SpellCastTargets const& /*targets*/)
        {
			if(!player->isInCombat() && !player->InArena())
			{
				HouseLocation *location = PlayerHousingMgr.GetCurrentHouseArea(player);
				if(player->playerhouse)
				{
					if(location && player->house == player->playerhouse->GetPhase())
					{
						if(player->summon)
							player->summon->DespawnOrUnsummon(0);
						player->summon = player->SummonCreature(218, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
						//player->summon->house = player->house;

						player->PrepareGossipMenu(player->summon, GOSSIP_ACTION_INFO_DEF);
						player->pagehelper = 0;
						player->categoryhelper = 0;
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Remove nearest object/npc", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Remove nearest/npc", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Allowed visitors", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Buy new items for house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+12);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "I would like different house...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+9);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Reset my position", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Leave house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
						player->SendPreparedGossip(player->summon);
					}
					else if(player->playerhouse)
					{
						PlayerHousingMgr.EnterHouse(player, player->playerhouse->owner_guid);
					}
				}
				else
				{
					if(player->summon)
						player->summon->DespawnOrUnsummon(0);
					player->summon = player->SummonCreature(220, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
				
					player->PrepareGossipMenu(player->summon);
					if(location && player->house == PREVIEW_HOUSE)
					{
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "I'd like this house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "I'd like to see more houses", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
					}
					else
					{
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "I'd like to see more houses", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Not now, take me back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
					}
					player->SendPreparedGossip(player->summon);
				}
			}

			return false;
        }
};

void AddSC_item_ask_controller()
{
    new item_ask_controller();
}

class item_ask_allowehouses : public ItemScript
{
    public:

        item_ask_allowehouses()
            : ItemScript("item_ask_allowehouses")
        {
        }

        bool OnUse(Player *player, Item *item, SpellCastTargets const& /*targets*/)
        {
			if(!player->isInCombat() && !player->InArena())
			{
				if(player->summon)
					player->summon->DespawnOrUnsummon(0);				
				player->summon = player->SummonCreature(219, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
				//player->summon->house = player->house;

				player->PrepareGossipMenu(player->summon, GOSSIP_ACTION_INFO_DEF);
				player->pagehelper = 0;
				player->categoryhelper = 0;

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Enter friend's home", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
				Guild *guild = sGuildMgr->GetGuildById(player->GetGuildId());
				if(PlayerHousingMgr.GetGuildHouseIdIfExists(player) != 0)
				{
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Enter guild house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1); 
				}
				if(player->house != 0)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Leave house", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5); 

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Not now", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
				player->SendPreparedGossip(player->summon);
			}

			return false;
        }
};

void AddSC_item_ask_allowehouses()
{
    new item_ask_allowehouses();
}

class item_purchase : public ItemScript
{
    public:

        item_purchase()
            : ItemScript("item_purchase")
        {
        }

        bool OnUse(Player *player, Item *item, SpellCastTargets const& /*targets*/)
        {
			if(player->playerhouse)
			{
				player->playerhouse->AddItem(player, PlayerHousingMgr.GetVendorItem(item->GetTemplate()->ItemId, true)->entry);
			}

			return false;
        }
};

void AddSC_item_purchase()
{
    new item_purchase();
}