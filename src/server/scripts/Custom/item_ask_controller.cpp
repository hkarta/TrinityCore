#include "ScriptPCH.h"
#include "ScriptMgr.h"
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
			if(!player->isInCombat() && !player->InArena() && player->playerhouse)
			{
				HouseLocation *location = PlayerHousingMgr.GetCurrentHouseArea(player);
				if(location && player->house == player->playerhouse->GetPhase())
				{
					if(player->summon)
						player->summon->DespawnOrUnsummon(0);
					player->summon = player->SummonCreature(218, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);
					//player->summon->house = player->house;

					player->PrepareGossipMenu(player->summon);
					player->pagehelper = 0;
					player->categoryhelper = 0;
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Smazat objekt/npc v me blizkosti", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Pridat objekt/npc na mou pozici", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Osoby opravnene ke vstupu", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Nakoupit vybaveni", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Chtel bych jiny dum...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Jake vyhody ma VIP hrac ve svem dome?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Prenest na vychozi pozici", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
					player->SendPreparedGossip(player->summon);
				}
				else if(player->playerhouse)
				{
					PlayerHousingMgr.EnterGuildHouse(player, player->playerhouse->owner_guid);
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

				player->PrepareGossipMenu(player->summon);
				player->pagehelper = 0;
				player->categoryhelper = 0;
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, "Vstup do domu sveho znameho", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Vstup do domu sve guildy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1); 
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