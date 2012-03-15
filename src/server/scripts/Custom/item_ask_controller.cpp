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
			if(!player->isInCombat() && !player->InArena() && player->house)
			{
				HouseLocation *location = PlayerHousingMgr.GetCurrentHouseArea(player);
				if(location && player->GetPhaseMask() == player->house->GetPhase())
				{
					if(!player->summon)
						player->summon = player->SummonCreature(218, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);

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
				else if(player->house)
				{
					PlayerHousingMgr.EnterGuildHouse(player, player->house->owner_guid);
				}
			}

			return false;
        }
};

void AddSC_item_ask_controller()
{
    new item_ask_controller();
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
			if(player->house)
			{
				player->house->AddItem(player, PlayerHousingMgr.GetVendorItem(item->GetTemplate()->ItemId, true)->entry);
			}

			return false;
        }
};

void AddSC_item_purchase()
{
    new item_purchase();
}