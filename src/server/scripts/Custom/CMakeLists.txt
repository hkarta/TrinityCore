# Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  Custom/vendor_multi.cpp
  Custom/vendor_general.cpp
  Custom/ItemSwitcher.cpp
  Custom/object_house_browser.cpp
  Custom/object_house_controler.cpp
  Custom/object_house_gobject.cpp
  Custom/object_house_npc.cpp
  Custom/item_ask_controller.cpp
)

message("  -> Prepared: Custom")
