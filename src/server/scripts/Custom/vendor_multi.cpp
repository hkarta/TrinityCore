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
 */

/* ScriptData
SDName: Example_Gossip_Codebox
SD%Complete: 100
SDComment: Show a codebox in gossip option
SDCategory: Script Examples
EndScriptData */

#include "ScriptPCH.h"
#include <cstring>
#include "../../game/Custom/CustomVendor.h"

class vendor_multi : public CreatureScript
{
    public:

        vendor_multi()
            : CreatureScript("vendor_multi")
        {
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            IterateCategory(player, creature);
            return true;
        }

		void IterateCategory(Player* player, Creature* creature, int category = 0)
		{
			player->PlayerTalkClass->ClearMenus();
			player->currentVendorEntry = -1;
			VendorEntry *current = current = CustomVendorMgr.GetParent(category);
			VendorEntryList *result;
			
			if(category == 0)
				result = CustomVendorMgr.GetBaseItemsForEntry(creature->GetEntry());
			else 
				result = CustomVendorMgr.GetItemsForEntry(creature->GetEntry(), category);
			VendorEntryList::iterator i;

			int x = 0;
			for (i = result->begin(); i != result->end(); ++i)
			{
				VendorEntry *vendorEntry = *i;

				int icon = GOSSIP_ICON_CHAT;
				if(CustomVendorMgr.GetNext(creature->GetEntry(), vendorEntry->next) < 0)
					icon = GOSSIP_ICON_MONEY_BAG;

				player->ADD_GOSSIP_ITEM(icon, vendorEntry->desc, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2+vendorEntry->next);
				x++;
				if(x == 5)
				{
					player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
					x = 0;
				}
			}

			if(current)
			{
				if(current->group != 0)
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<< Zpet", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2+current->id);
				else
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<< Zpet", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
				x++;
			}

			if(x != 0)
				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
		}

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
        {
			if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
            {
				IterateCategory(player, creature);
            }
            else if (uiAction > GOSSIP_ACTION_INFO_DEF+1)
            {
				int id = uiAction-GOSSIP_ACTION_INFO_DEF-2;
				int next = CustomVendorMgr.GetNext(creature->GetEntry(), id);
				if(next < 0)
				{
					next = (-1) * next;
					player->currentVendorEntry = next;
					player->GetSession()->SendListInventory(creature->GetGUID(), next);
				}
				else
					IterateCategory(player, creature, id);
            }

            return true;
        }

};

void AddSC_vendor_multi()
{
    new vendor_multi();
}
