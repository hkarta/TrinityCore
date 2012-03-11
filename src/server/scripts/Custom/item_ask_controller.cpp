#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "../../game/Custom/PlayerHousing.h"

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
				if(location)
				{
					if(!player->summon)
						player->summon = player->SummonCreature(218, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN);

					player->PrepareGossipMenu(player->summon);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "click", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "click2", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
					player->SendPreparedGossip(player->summon);
				}
				else if(player->house)
				{
					player->house->TeleportToHouse(player);
				}
			}

			return false;
        }
};

void AddSC_item_ask_controller()
{
    new item_ask_controller();
}