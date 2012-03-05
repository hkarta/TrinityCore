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

class vendor_general : public CreatureScript
{
    public:

        vendor_general()
            : CreatureScript("vendor_general")
        {
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
			player->currentVendorEntry = -1;
            player->GetSession()->SendListInventory(creature->GetGUID());

            return true;
        }
};

void AddSC_vendor_general()
{
    new vendor_general();
}
