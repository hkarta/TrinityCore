UPDATE `creature_addon` SET `bytes1`=0x3000000 WHERE `guid`=207210;
UPDATE `creature_addon` SET `bytes1`=0x3000000 WHERE `guid`=207211;
-- SAI for Unrestrained Dragonhawk
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=25236;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=25236 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25236,0,0,1,62,0,100,0,9143,0,0,0,11,45353,0,0,0,0,0,7,0,0,0,0,0,0,0,'Unrestrained Dragonhawk - On Gossip option select - cast "Quest - Sunwell Daily - Ship Bombing Run Return" on player'),
(25236,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Unrestrained Dragonhawk - On Gossip option select - Close Gossip');
-- Unrestrained Dragonhawk Gossip
UPDATE `creature_template` SET `gossip_menu_id`=9143 WHERE `entry`=25236;
-- Gossip_menu from UDB
DELETE FROM `gossip_menu` WHERE `entry`=9143;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9143,12371);
-- Gossip_menu_option Update from UDB
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9143;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9143,0,0, '<Ride the dragonhawk to Sun''s Reach.>',1,1,0,0,0,0, '');
-- Gossip option Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9143;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9143,0,0,9,11542,0,0,0,'','Show gossip option if player has quest 11542 but not complete'),
(15,9143,0,1,9,11543,0,0,0,'','Show gossip option if player has quest 11543 but not complete');
-- Creature Gossip_menu_id Update from sniff
UPDATE `creature_template` SET `gossip_menu_id`=9052 WHERE `entry`=24965; -- Vindicator Xayann 
UPDATE `creature_template` SET `gossip_menu_id`=9050 WHERE `entry`=24975; -- Mar'nah 
UPDATE `creature_template` SET `gossip_menu_id`=9126 WHERE `entry`=25032; -- Eldara Dawnrunner 
UPDATE `creature_template` SET `gossip_menu_id`=9087 WHERE `entry`=25046; -- Smith Hauthaa 
UPDATE `creature_template` SET `gossip_menu_id`=9064 WHERE `entry`=25057; -- Battlemage Arynna 
UPDATE `creature_template` SET `gossip_menu_id`=9062, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=25059; -- Ayren Cloudbreaker 
UPDATE `creature_template` SET `gossip_menu_id`=9063 WHERE `entry`=25061; -- Harbinger Inuuro 
UPDATE `creature_template` SET `gossip_menu_id`=9127 WHERE `entry`=25069; -- Magister Ilastar 
UPDATE `creature_template` SET `gossip_menu_id`=9115 WHERE `entry`=25112; -- Anchorite Ayuri 
UPDATE `creature_template` SET `gossip_menu_id`=9105 WHERE `entry`=25169; -- Archmage Ne'thul
UPDATE `creature_template` SET `gossip_menu_id`=9286 WHERE `entry`=25632; -- Vindicator Moorba
UPDATE `creature_template` SET `gossip_menu_id`=9285 WHERE `entry`=25638; -- Captain Selana
UPDATE `creature_template` SET `gossip_menu_id`=9198 WHERE `entry`=25950; -- Shaani

-- Gossip Menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=9050 AND `text_id`=12237;
DELETE FROM `gossip_menu` WHERE `entry`=9052 AND `text_id`=12241;
DELETE FROM `gossip_menu` WHERE `entry`=9062 AND `text_id`=12252;
DELETE FROM `gossip_menu` WHERE `entry`=9063 AND `text_id`=12256;
DELETE FROM `gossip_menu` WHERE `entry`=9064 AND `text_id`=12258;
DELETE FROM `gossip_menu` WHERE `entry`=9087 AND `text_id`=12286;
DELETE FROM `gossip_menu` WHERE `entry`=9115 AND `text_id`=12323;
DELETE FROM `gossip_menu` WHERE `entry`=9126 AND `text_id`=12338;
DELETE FROM `gossip_menu` WHERE `entry`=9127 AND `text_id`=12340;
DELETE FROM `gossip_menu` WHERE `entry`=9198 AND `text_id`=12497;
DELETE FROM `gossip_menu` WHERE `entry`=9285 AND `text_id`=12596;
DELETE FROM `gossip_menu` WHERE `entry`=9286 AND `text_id`=12597;
DELETE FROM `gossip_menu` WHERE `entry`=9287 AND `text_id`=12598;
DELETE FROM `gossip_menu` WHERE `entry`=9288 AND `text_id`=12599;
DELETE FROM `gossip_menu` WHERE `entry`=9289 AND `text_id`=12600;
DELETE FROM `gossip_menu` WHERE `entry`=9290 AND `text_id`=12601;
DELETE FROM `gossip_menu` WHERE `entry`=9293 AND `text_id`=12604;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9050,12237),
(9052,12241),
(9062,12252),
(9063,12256),
(9064,12258),
(9087,12286),
(9115,12323),
(9126,12338),
(9127,12340),
(9198,12497),
(9285,12596),
(9286,12597),
(9287,12598),
(9288,12599),
(9289,12600),
(9290,12601),
(9293,12604);

-- Creature Gossip_menu_option insert from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9050,9087,9126,9198,9285,9287,9288,9289) AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9062 AND `id` IN (0,1);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9286 AND `id`=2;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(9050,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9062,0,0,'Speaking of action, I''ve been ordered to undertake an air strike.',1,1,0,0,0,0,''), 
(9062,1,0,'I need to intercept the Dawnblade reinforcements.',1,1,0,0,0,0,''),
(9087,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9126,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9198,0,1,'Let me browse your goods.',3,128,0,0,0,0,''),
(9285,0,0,'Give me a situation report, Captain.',1,1,9287,0,0,0,''),
(9286,2,0,'What is the current state of the Sunwell''s Gates?',1,1,9293,0,0,0,''), 
(9287,0,0,'What went wrong?',1,1,9288,0,0,0,''),
(9288,0,0,'Why did they stop?',1,1,9289,0,0,0,''),
(9289,0,0,'Your insight is appreciated.',1,1,9290,0,0,0,'');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9062 AND `SourceEntry` IN (0,1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9062,0,0,0,9,11532,0,0,0,0,'','Show gossip option only if player has taken quest 11532'),
(15,9062,0,0,1,9,11533,0,0,0,0,'','Show gossip option only if player has taken quest 11533'),
(15,9062,1,0,0,9,11542,0,0,0,0,'','Show gossip option only if player has taken quest 11542'),
(15,9062,1,0,1,9,11543,0,0,0,0,'','Show gossip option only if player has taken quest 11543');

-- SmartAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=25059 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25059,0,0,2,62,0,100,0,9062,0,0,0,11,45071,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Cast "Quest - Sunwell Daily - Dead Scar Bombing Run" on player'),
(25059,0,1,2,62,0,100,0,9062,1,0,0,11,45113,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Cast "Quest - Sunwell Daily - Ship Bombing Run" on player'),
(25059,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ayren Cloudbreaker - On Gossip option select - Close Gossip');

-- Spell scripts from sniff
DELETE FROM `spell_scripts` WHERE `id`=45071;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(45071,2,0,16,12318,1,0,0,0,0,0); -- Play sound
-- ToC missing trigger spawns

SET @GUID            := 88412;
SET @NPC_TRIGGER1    := 34704; -- Val'kyr Twins Bullet Stalker Dark
SET @NPC_TRIGGER2    := 34720; -- Val'kyr Twins Bullet Stalker Light

UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry` IN (@NPC_TRIGGER1,@NPC_TRIGGER2);
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+61;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID+0,@NPC_TRIGGER1,649,15,1,0,0,619.771,143.71,395.244,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+1,@NPC_TRIGGER1,649,15,1,0,0,515.352,115.349,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+2,@NPC_TRIGGER1,649,15,1,0,0,605.514,103.863,395.29,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+3,@NPC_TRIGGER1,649,15,1,0,0,615.137,156.997,395.28,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+4,@NPC_TRIGGER1,649,15,1,0,0,539.179,184.132,395.282,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+5,@NPC_TRIGGER1,649,15,1,0,0,547.76,184.634,395.289,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+6,@NPC_TRIGGER1,649,15,1,0,0,549.764,86.4444,395.266,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+7,@NPC_TRIGGER1,649,15,1,0,0,511.417,127.158,395.266,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+8,@NPC_TRIGGER1,649,15,1,0,0,597.38,183.672,395.28,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+9,@NPC_TRIGGER1,649,15,1,0,0,573.578,187.665,395.492,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+10,@NPC_TRIGGER1,649,15,1,0,0,620.465,134.66,395.233,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+11,@NPC_TRIGGER1,649,15,1,0,0,560.484,187.743,395.959,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+12,@NPC_TRIGGER1,649,15,1,0,0,577.299,186.854,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+13,@NPC_TRIGGER1,649,15,1,0,0,563.467,81.9323,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+14,@NPC_TRIGGER1,649,15,1,0,0,534.748,92.6424,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+15,@NPC_TRIGGER1,649,15,1,0,0,518.503,170.649,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+16,@NPC_TRIGGER1,649,15,1,0,0,514.566,159.918,395.287,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+17,@NPC_TRIGGER1,649,15,1,0,0,568.049,187.67,395.563,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+18,@NPC_TRIGGER1,649,15,1,0,0,522.955,102.127,395.29,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+19,@NPC_TRIGGER1,649,15,1,0,0,611.656,114.281,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+20,@NPC_TRIGGER1,649,15,1,0,0,616.432,126.418,395.264,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+21,@NPC_TRIGGER1,649,15,1,0,0,526.833,181.783,395.285,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+22,@NPC_TRIGGER1,649,15,1,0,0,578.722,87.4444,395.272,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+23,@NPC_TRIGGER1,649,15,1,0,0,509.743,149.005,395.253,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+24,@NPC_TRIGGER1,649,15,1,0,0,592.736,93.6667,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+25,@NPC_TRIGGER1,649,15,1,0,0,506.038,139.517,395.288,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+26,@NPC_TRIGGER1,649,15,1,0,0,608.116,171.731,395.289,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+27,@NPC_TRIGGER1,649,15,1,0,0,586.344,184.078,395.283,4.60767,7200,0,0,1,0,0,0,0,0),
(@GUID+28,@NPC_TRIGGER1,649,15,1,0,0,554.818,187.568,395.288,2.93215,7200,0,0,1,0,0,0,0,0),
(@GUID+29,@NPC_TRIGGER2,649,15,1,0,0,557.743,187.729,395.915,0,7200,0,0,1,0,0,0,0,0),
(@GUID+30,@NPC_TRIGGER2,649,15,1,0,0,544.094,184.648,395.286,0,7200,0,0,1,0,0,0,0,0),
(@GUID+31,@NPC_TRIGGER2,649,15,1,0,0,551.328,187.646,395.596,0,7200,0,0,1,0,0,0,0,0),
(@GUID+32,@NPC_TRIGGER2,649,15,1,0,0,615.137,150.818,395.269,0,7200,0,0,1,0,0,0,0,0),
(@GUID+33,@NPC_TRIGGER2,649,15,1,0,0,571.158,187.691,395.629,0,7200,0,0,1,0,0,0,0,0),
(@GUID+34,@NPC_TRIGGER2,649,15,1,0,0,606.686,106.731,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+35,@NPC_TRIGGER2,649,15,1,0,0,612.118,118.844,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+36,@NPC_TRIGGER2,649,15,1,0,0,546.057,88.7691,395.284,0,7200,0,0,1,0,0,0,0,0),
(@GUID+37,@NPC_TRIGGER2,649,15,1,0,0,517.722,169.069,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+38,@NPC_TRIGGER2,649,15,1,0,0,507.181,142.285,395.255,0,7200,0,0,1,0,0,0,0,0),
(@GUID+39,@NPC_TRIGGER2,649,15,1,0,0,515.399,159.75,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+40,@NPC_TRIGGER2,649,15,1,0,0,592.151,183.8,395.279,0,7200,0,0,1,0,0,0,0,0),
(@GUID+41,@NPC_TRIGGER2,649,15,1,0,0,510.759,127.333,395.263,0,7200,0,0,1,0,0,0,0,0),
(@GUID+42,@NPC_TRIGGER2,649,15,1,0,0,524.257,178.134,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+43,@NPC_TRIGGER2,649,15,1,0,0,570.779,86.2986,395.253,0,7200,0,0,1,0,0,0,0,0),
(@GUID+44,@NPC_TRIGGER2,649,15,1,0,0,588.675,93.0938,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+45,@NPC_TRIGGER2,649,15,1,0,0,603.528,175.476,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+46,@NPC_TRIGGER2,649,15,1,0,0,509.639,133.26,395.247,0,7200,0,0,1,0,0,0,0,0),
(@GUID+47,@NPC_TRIGGER2,649,15,1,0,0,618.965,139.174,395.288,0,7200,0,0,1,0,0,0,0,0),
(@GUID+48,@NPC_TRIGGER2,649,15,1,0,0,514.785,118.731,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+49,@NPC_TRIGGER2,649,15,1,0,0,581.243,184.062,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+50,@NPC_TRIGGER2,649,15,1,0,0,577.757,184.436,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+51,@NPC_TRIGGER2,649,15,1,0,0,580.486,89.691,395.287,0,7200,0,0,1,0,0,0,0,0),
(@GUID+52,@NPC_TRIGGER2,649,15,1,0,0,511.132,151.156,395.264,0,7200,0,0,1,0,0,0,0,0),
(@GUID+53,@NPC_TRIGGER2,649,15,1,0,0,615.401,130.816,395.263,0,7200,0,0,1,0,0,0,0,0),
(@GUID+54,@NPC_TRIGGER2,649,15,1,0,0,599.307,98.8003,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+55,@NPC_TRIGGER2,649,15,1,0,0,520.212,108.429,395.289,0,7200,0,0,1,0,0,0,0,0),
(@GUID+56,@NPC_TRIGGER2,649,15,1,0,0,610.983,164.696,395.288,0,7200,0,0,1,0,0,0,0,0),
(@GUID+57,@NPC_TRIGGER2,649,15,1,0,0,526.337,99.5556,395.29,0,7200,0,0,1,0,0,0,0,0),
(@GUID+58,@NPC_TRIGGER2,649,15,1,0,0,563.997,187.644,395.489,0,7200,0,0,1,0,0,0,0,0),
(@GUID+59,@NPC_TRIGGER2,649,15,1,0,0,555.695,86.0208,395.253,0,7200,0,0,1,0,0,0,0,0),
(@GUID+60,@NPC_TRIGGER2,649,15,1,0,0,535.924,184.207,395.279,0,7200,0,0,1,0,0,0,0,0),
(@GUID+61,@NPC_TRIGGER2,649,15,1,0,0,538.024,92.441,395.289,0,7200,0,0,1,0,0,0,0,0);
-- Flame Sphere should not be visible to players(only their visual)
UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry` IN (30106,31686,31687);
-- Manual: Heavy Frostweave Bandage should be lootable if you have at least 390 skills in First Aid
UPDATE `conditions` SET `ConditionValue2`=390 WHERE `SourceTypeOrReferenceId`=1 AND `SourceEntry`=39152 AND `ConditionTypeOrReference`=7 AND `ConditionValue1`=129;
DROP TABLE IF EXISTS ip2nation;

CREATE TABLE ip2nation (
  ip int(11) unsigned NOT NULL default '0',
  country char(2) NOT NULL default '',
  KEY ip (ip)
);

DROP TABLE IF EXISTS ip2nationCountries;

CREATE TABLE ip2nationCountries (
  code varchar(4) NOT NULL default '',
  iso_code_2 varchar(2) NOT NULL default '',
  iso_code_3 varchar(3) default '',
  iso_country varchar(255) NOT NULL default '',
  country varchar(255) NOT NULL default '',
  lat float NOT NULL default '0',
  lon float NOT NULL default '0',
  PRIMARY KEY  (code),
  KEY code (code)
);
-- Beam Visual
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=60342;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,60342,0,0,31,0,3,29308,0,0,0,'','Beam Visual target Prince Taldaram');

-- script texts for Prince Taldaram
DELETE FROM `creature_text` WHERE `entry`=29308;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29308,0,0,'The hum of magic energy in the air diminishes...',16,0,100,0,0,0,'prince taldaram SAY_1'),
(29308,1,0,'Intruders! Who trespasses in the Old Kingdom?',14,0,100,0,0,0,'prince taldaram SAY_WARNING'),
(29308,2,0,'I will feast on your remains.',14,0,100,0,0,14360,'prince taldaram SAY_AGGRO'),
(29308,3,0,'',14,10,100,0,0,14365,'prince taldaram SAY_SLAY_0'),
(29308,3,1,'I will drink no blood before it''s time.',14,0,100,0,0,14366,'prince taldaram SAY_SLAY_1'),
(29308,3,2,'One final embrace.',14,0,100,0,0,14367,'prince taldaram SAY_SLAY_2'),
(29308,4,0,'Still I hunger. Still... I... thirst.',14,0,100,0,0,14368,'prince taldaram SAY_DEATH'),
(29308,5,0,'So... appetizing.',14,0,100,0,0,14363,'prince taldaram SAY_FEED1'),
(29308,5,1,'Fresh, warm blood. It has been too long.',14,0,100,0,0,14364,'prince taldaram SAY_FEED2'),
(29308,6,0,'Your heartbeat is... music to my ears.',14,0,100,0,0,14361,'prince taldaram SAY_VANISH1'),
(29308,6,1,'I am nowhere... I am everywhere. I am the watcher, unseen.',14,0,100,0,0,14362,'prince taldaram SAY_VANISH2');

-- cleanup
DELETE FROM `script_texts` WHERE `npc_entry`=29308;
-- -----------------------------------
-- --  Loot for The Siege of Ulduar -- 
-- -----------------------------------

-- Old Cleanups:
DELETE FROM `reference_loot_template` WHERE `entry` IN ( 34116,34117,34118,34119,34120,34121,34157,34158,34159,34160,34161,34162);
-- -------------------
-- -- Set Variables --
-- -------------------
-- 10 man mode npcids
SET @FlameLevi10 :=33113;
SET @IgnisFM10 :=33118;
SET @Razorscale10 :=33186;
SET @XT002_10 :=33293;
-- 25 man mode npcids (via procedure)
call `sp_get_npc_diffentry`(@FlameLevi10,1,@FlameLevi25);
call `sp_get_npc_diffentry`(@IgnisFM10,1,@IgnisFM25);
call `sp_get_npc_diffentry`(@Razorscale10,1,@Razorscale25);
call `sp_get_npc_diffentry`(@XT002_10,1,@XT002_25);

SET @Emblem := 47241;
SET @Orb := 45087;
-- -------------------------------------
-- -- Set Reference Loot Template ids --
-- -------------------------------------

SET @EmblemRef := 34349; -- First Free ID
SET @OrbRef := @EmblemRef+1;
SET @Flame10Ref := @EmblemRef+2;
SET @Flame25Ref := @EmblemRef+3;
SET @Ignis10Ref := @EmblemRef+4;
SET @Ignis25Ref := @EmblemRef+5;
SET @Razor10Ref := @EmblemRef+6;
SET @Razor25Ref := @EmblemRef+7;
SET @XT002_10Ref := @EmblemRef+8;
SET @XT002_25Ref := @EmblemRef+9;
-- Flame Levithian
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @EmblemRef AND @EmblemRef+9;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Emblem Ref
(@EmblemRef,47241,0,1,1,1,1), -- Emblem of Triumph 1x
-- OrbRef
(@OrbRef,45087,0,1,1,1,1), -- Runed Orb 1x
-- Flame Levithian 10man
(@Flame10Ref,45286,0,1,1,1,1), -- Pyrite Infuser
(@Flame10Ref,45287,0,1,1,1,1), -- Firesoul
(@Flame10Ref,45288,0,1,1,1,1), -- Firestrider Chestguard
(@Flame10Ref,45289,0,1,1,1,1), -- Lifespark Visage
(@Flame10Ref,45291,0,1,1,1,1), -- Combustion Bracers
(@Flame10Ref,45284,0,1,1,1,1), -- Kinetic Ripper
(@Flame10Ref,45282,0,1,1,1,1), -- Ironsoul
(@Flame10Ref,45285,0,1,1,1,1), -- Might of the Leviathan
(@Flame10Ref,45292,0,1,1,1,1), -- Energy Siphon
(@Flame10Ref,45283,0,1,1,1,1), -- Flamewatch Armguards
-- Flame Levithian 25man
(@Flame25Ref,45117,0,1,1,1,1), -- Constructors Handwraps
(@Flame25Ref,45119,0,1,1,1,1), -- Embrace of the Leviathan
(@Flame25Ref,45113,0,1,1,1,1), -- Glowing Ring of Reclamation
(@Flame25Ref,45115,0,1,1,1,1), -- Leviathan Fueling Manual
(@Flame25Ref,45108,0,1,1,1,1), -- Mechanists Bindings
(@Flame25Ref,45106,0,1,1,1,1), -- Strenght of the Automaton
(@Flame25Ref,45109,0,1,1,1,1), -- Gloves of the Fiery Behemoth
(@Flame25Ref,45114,0,1,1,1,1), -- Steamcallers Totem
(@Flame25Ref,45118,0,1,1,1,1), -- Steamworkers Goggles
(@Flame25Ref,45116,0,1,1,1,1), -- Freya's Choker of Warding
(@Flame25Ref,45111,0,1,1,1,1), -- Mimiron's Inferno Couplings
(@Flame25Ref,45112,0,1,1,1,1), -- The Leviathan's Coil
(@Flame25Ref,45107,0,1,1,1,1), -- Iron Riveted War Helm

-- Ignis the Furnace Master 10man
(@Ignis10Ref,45309,0,1,1,1,1), -- Rifle of the Platinum Guard
(@Ignis10Ref,45310,0,1,1,1,1), -- Gauntlets of the Iron Furnace
(@Ignis10Ref,45311,0,1,1,1,1), -- Relentless Edge
(@Ignis10Ref,45312,0,1,1,1,1), -- Gloves of Smoldering Touch
(@Ignis10Ref,45313,0,1,1,1,1), -- Furnace Stone
(@Ignis10Ref,45314,0,1,1,1,1), -- Igniter Rod
(@Ignis10Ref,45316,0,1,1,1,1), -- Armbraces of the Vibrant Flame
(@Ignis10Ref,45317,0,1,1,1,1), -- Shawl of the Caretaker
(@Ignis10Ref,45318,0,1,1,1,1), -- Drape of Fuming Anger
(@Ignis10Ref,45321,0,1,1,1,1), -- Pauldrons of Tempered Will
-- Ignis the Furnace Master 25man
(@Ignis25Ref,45157,0,1,1,1,1), -- Cindershard Ring
(@Ignis25Ref,45158,0,1,1,1,1), -- Heart of Iron
(@Ignis25Ref,45161,0,1,1,1,1), -- Girdle of Embers
(@Ignis25Ref,45162,0,1,1,1,1), -- Flamestalker Boots
(@Ignis25Ref,45164,0,1,1,1,1), -- Helm of the Furnace Master
(@Ignis25Ref,45165,0,1,1,1,1), -- Worldcarver
(@Ignis25Ref,45166,0,1,1,1,1), -- Charred Saronite Greaves
(@Ignis25Ref,45167,0,1,1,1,1), -- Lifeforge Breastplate
(@Ignis25Ref,45168,0,1,1,1,1), -- Pyrelight Circle
(@Ignis25Ref,45169,0,1,1,1,1), -- Totem of the Dancing Flame
(@Ignis25Ref,45170,0,1,1,1,1), -- Scepter of Creation
(@Ignis25Ref,45171,0,1,1,1,1), -- Intensity
(@Ignis25Ref,45185,0,1,1,1,1), -- Flamewrought Cinch
(@Ignis25Ref,45186,0,1,1,1,1), -- Soot-Covered Mantle
(@Ignis25Ref,45187,0,1,1,1,1), -- Wristguards of the Firetender

-- Razorscale 10man
(@Razor10Ref,45298,0,1,1,1,1), -- RazoRazorcale Talon
(@Razor10Ref,45299,0,1,1,1,1), -- Dragonsteel Faceplate
(@Razor10Ref,45301,0,1,1,1,1), -- BraceRazor of the Smothering Inferno
(@Razor10Ref,45302,0,1,1,1,1), -- Treads of the Invader
(@Razor10Ref,45303,0,1,1,1,1), -- Band of Draconic Guile
(@Razor10Ref,45304,0,1,1,1,1), -- Stormtempered Girdle
(@Razor10Ref,45305,0,1,1,1,1), -- Breastplate of the Afterlife
(@Razor10Ref,45306,0,1,1,1,1), -- Binding of the Dragon Matriarch
(@Razor10Ref,45307,0,1,1,1,1), -- Ironscale Leggings
(@Razor10Ref,45308,0,1,1,1,1), -- Eye of the Broodmother
-- Razorscale 25man
(@Razor25Ref,45137,0,1,1,1,1), -- Veranus' Bane
(@Razor25Ref,45138,0,1,1,1,1), -- Drape of the Drakerider
(@Razor25Ref,45139,0,1,1,1,1), -- Dragonslayer's Brace
(@Razor25Ref,45140,0,1,1,1,1), -- RazoRazorcale Shoulderguards
(@Razor25Ref,45141,0,1,1,1,1), -- Proto-hide Leggings
(@Razor25Ref,45142,0,1,1,1,1), -- RemoRazore
(@Razor25Ref,45143,0,1,1,1,1), -- Saronite Mesh Legguards
(@Razor25Ref,45144,0,1,1,1,1), -- Sigil of Deflection
(@Razor25Ref,45146,0,1,1,1,1), -- Shackles of the Odalisque
(@Razor25Ref,45147,0,1,1,1,1), -- Guiding Star
(@Razor25Ref,45148,0,1,1,1,1), -- Living Flame
(@Razor25Ref,45149,0,1,1,1,1), -- BraceRazor of the Broodmother
(@Razor25Ref,45150,0,1,1,1,1), -- Collar of the Wyrmhunter
(@Razor25Ref,45151,0,1,1,1,1), -- Belt of the Fallen Wyrm
(@Razor25Ref,45510,0,1,1,1,1), -- Libram of Discord
 
-- XT-002 Deconstructor 10man
(@XT002_10Ref,45675,0,1,1,1,1), -- Power Enchancing Loop
(@XT002_10Ref,45676,0,1,1,1,1), -- Chestplate of Vicious Potency
(@XT002_10Ref,45677,0,1,1,1,1), -- Treacherous shoulderpads
(@XT002_10Ref,45679,0,1,1,1,1), -- Gloves of Taut grip
(@XT002_10Ref,45680,0,1,1,1,1), -- Armbands of the construct
(@XT002_10Ref,45682,0,1,1,1,1), -- Pulsing spellshield
(@XT002_10Ref,45685,0,1,1,1,1), -- Plasma Foil
(@XT002_10Ref,45686,0,1,1,1,1), -- Vest of the glowing Cresent
(@XT002_10Ref,45687,0,1,1,1,1), -- Helm of Veiled Energies
(@XT002_10Ref,45694,0,1,1,1,1), -- Conductive cord
(@XT002_10Ref,45867,0,2,2,1,1), -- Breasktplate of the Stoneshaper
(@XT002_10Ref,45868,0,2,2,1,1), -- Aesir's Edge
(@XT002_10Ref,45869,0,2,2,1,1), -- Fluxing Energy Coils
(@XT002_10Ref,45870,0,2,2,1,1), -- Magnetized Projectile Emitter
(@XT002_10Ref,45871,0,2,2,1,1), -- Seal of Ulduar
-- XT-002 Deconstructor 25man
(@XT002_25Ref,45254,0,1,1,1,1), -- Sigil of the Vengeful Heart
(@XT002_25Ref,45251,0,1,1,1,1), -- Shoulderplates of the Deconstructor
(@XT002_25Ref,45247,0,1,1,1,1), -- Signet of the Earthshaker
(@XT002_25Ref,45256,0,1,1,1,1), -- Twisted Visage
(@XT002_25Ref,45250,0,1,1,1,1), -- Crazed Construct Ring
(@XT002_25Ref,45257,0,1,1,1,1), -- Quartz Crystal Wand
(@XT002_25Ref,45260,0,1,1,1,1), -- Boots of Hasty Revival
(@XT002_25Ref,45252,0,1,1,1,1), -- Horologist's Wristguards
(@XT002_25Ref,45253,0,1,1,1,1), -- Mantle of Wavering Calm
(@XT002_25Ref,45258,0,1,1,1,1), -- Sandals of Rash Temperament
(@XT002_25Ref,45249,0,1,1,1,1), -- Brass-lined Boots
(@XT002_25Ref,45246,0,1,1,1,1), -- Golem-Shard Sticker
(@XT002_25Ref,45248,0,1,1,1,1), -- Clockwork Legplates
(@XT002_25Ref,45259,0,1,1,1,1), -- Quartz-studded Harness
(@XT002_25Ref,45255,0,1,1,1,1); -- Thunderfall Totem
-- -----------------------------------------------------------------------------------------------
-- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES -- 
-- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES --
-- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES -- -- END OF REFERENCES --
-- -----------------------------------------------------------------------------------------------

-- Flame Levithian 10Man:
-- NORMAL MODE : 2x [Normal Loot Item] + 1x [Emblem of Valor]
-- ONE TOWER : 2x [Normal Loot Item] + 2x [Emblem of Conquest] + CHANCE TO [Recipe]
-- TWO TOWERS : 2x [Normal Loot Item] + 2x [Emblem of Conquest] + 1x [Runed Orb] + CHANCE TO [Recipe]
-- THREE TOWERS: 2x [Normal Loot Item] + 3x [Emblem of Conquest] + 1x [Runed Orb] + CHANCE TO [Recipe] + 1x [Recipe]
-- FOUR TOWERS : 2x [Normal Loot Item] + 3x [Emblem of Conquest] + 1x [Runed Orb] + CHANCE TO [Recipe] + 1x [Recipe] + 1x [Hard Loot Item]
-- Flame Levithian 25 man
-- NORMAL MODE : 3x [Normal Loot Item] + 1x [Emblem of Conquest] + CHANCE TO [Runed Orb] + CHANCE TO [Recipe]
-- ONE TOWER : 3x [Normal Loot Item] + 2x [Emblem of Conquest] + CHANCE TO [Runed Orb] + CHANCE TO [Recipe]
-- TWO TOWERS : 3x [Normal Loot Item] + 2x [Emblem of Conquest] + CHANCE TO [Runed Orb] + CHANCE TO [Recipe] + 2x [Runed Orb]
-- THREE TOWERS: 3x [Normal Loot Item] + 3x [Emblem of Conquest] + CHANCE TO [Runed Orb] + CHANCE TO [Recipe] + 2x [Runed Orb] + [Recipe]
-- FOUR TOWERS : 3x [Normal Loot Item] + 3x [Emblem of Conquest] + CHANCE TO [Runed Orb] + CHANCE TO [Recipe] + 2x [Runed Orb] + [Recipe] + 1x [Hard Loot Item]

DELETE FROM `creature_loot_template` WHERE `entry` IN (@FlameLevi10,@FlameLevi25,@IgnisFM10,@IgnisFM25,@Razorscale10,@Razorscale25,@XT002_10,@XT002_25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ---------------------------
-- -- Flame Levithian 10man -- 
-- ---------------------------
(@FlameLevi10,1,100,1,0,-@EmblemRef,1), -- 1x emblem
(@FlameLevi10,2,100,1,0,-@Flame10Ref,2), -- 2 from 10man reference
-- Hardmode: 1 tower left
(@FlameLevi10,3,100,2,0,-@EmblemRef,2), -- 2x emblem
(@FlameLevi10,4,100,2,0,-@Flame10Ref,2), -- 2 from 10man reference
-- Hardmode: 2 towers left
(@FlameLevi10,5,100,4,0,-@EmblemRef,2), -- 2x emblem
(@FlameLevi10,6,100,4,0,-@Flame10Ref,2), -- 2 from 10man reference
-- Hardmode: 3 towers left
(@FlameLevi10,7,100,8,0,-@EmblemRef,3), -- 3x emblem
(@FlameLevi10,8,100,8,0,-@Flame10Ref,2), -- 2 from 10man reference
-- Hardmode: 4 towers left
(@FlameLevi10,9,100,16,0,-@EmblemRef,3), -- 3x emblem
(@FlameLevi10,10,100,16,0,-@Flame10Ref,2), -- 2 from 10man reference
-- one from hardmodeloot:
(@FlameLevi10,45296,0,16,1,1,1), -- Twirling Blades
(@FlameLevi10,45293,0,16,1,1,1), -- Handguards of Potent Cures
(@FlameLevi10,45295,0,16,1,1,1), -- Gilded Steel Legplates
(@FlameLevi10,45300,0,16,1,1,1), -- Mantle of Fiery Vengeance
(@FlameLevi10,45297,0,16,1,1,1), -- Shimmering Seal
-- Shared Loot over the modes (masked)
-- Non-Normal (Modes 2|4|8|16) 
(@FlameLevi10,11,5,30,0,-34154,1), -- 1 from recepies (chanced) 
-- More then 1 tower up (Modes 4|8|16)
(@FlameLevi10,@Orb,100,28,0,1,3), -- Runed Orb (1-3)
-- More then 2 towers up (Modes 8|16)
(@FlameLevi10,12,100,24,0,-34154,1), -- 1 from recepies
-- ---------------------------
-- -- Flame Levithian 25man -- 
-- ---------------------------
(@FlameLevi25,1,100,1,0,-@EmblemRef,1), -- 1x emblem
(@FlameLevi25,2,100,1,0,-@Flame25Ref,3), -- 3 from 25man reference
-- Hardmode: 1 tower left
(@FlameLevi25,3,100,2,0,-@EmblemRef,2), -- 2x emblem
(@FlameLevi25,4,100,2,0,-@Flame25Ref,3), -- 3 from 25man reference
-- Hardmode: 2 towers left
(@FlameLevi25,5,100,4,0,-@EmblemRef,2), -- 2x emblem
(@FlameLevi25,6,100,4,0,-@Flame25Ref,3), -- 3 from 25man reference
-- Hardmode: 3 towers left
(@FlameLevi25,7,100,8,0,-@EmblemRef,3), -- 3x emblem
(@FlameLevi25,8,100,8,0,-@Flame25Ref,3), -- 3 from 25man reference
-- Hardmode: 4 towers left
(@FlameLevi25,9,100,16,0,-@EmblemRef,3), -- 3x emblem
(@FlameLevi25,10,100,16,0,-@Flame25Ref,3), -- 3 from 25man reference
-- one from hardmodeloot:
(@FlameLevi25,45132,0,16,1,1,1), -- Golden Saronite Dragon
(@FlameLevi25,45133,0,16,1,1,1), -- Pendant of Fiery Havoc
(@FlameLevi25,45134,0,16,1,1,1), -- Plated Leggings of Ruination
(@FlameLevi25,45135,0,16,1,1,1), -- Boots of Fiery Resolution
(@FlameLevi25,45136,0,16,1,1,1), -- Shoulderpads of Dormant Energies
(@FlameLevi25,45086,0,16,1,1,1), -- Rising Sun
(@FlameLevi25,45110,0,16,1,1,1), -- Titanguard
-- Shared Loot over the modes (masked)
-- All Modes (1|2|4|8|16):
(@FlameLevi25,11,5,31,0,-@OrbRef,1), -- Runed Orb (1x Chanced)
(@FlameLevi25,45038,8,1,0,1,1), -- Fragment of Val'anyr (quest only!?)
(@FlameLevi25,12,5,31,0,-34154,1), -- 1 from recepies (chanced) 
-- More then 1 tower up (Modes 4|8|16)
(@FlameLevi25,13,100,28,0,-@OrbRef,2), -- Runed Orb (2x garanteed)
-- More then 2 towers up (Modes 8|16)
(@FlameLevi25,14,100,24,0,-34154,1), -- 1 from recepies
-- ------------------------------
-- -- IGNIS THE FURNACE MASTER --
-- ------------------------------
-- Ignis the Furnace Master 10man
(@IgnisFM10,1,100,1,0,-@Ignis10Ref,2), -- 2 items from Ref loot
(@IgnisFM10,@Emblem,100,1,0,1,1), -- 1 Emblem
-- Ignis the Furnace Master 25man
(@IgnisFM25,1,100,1,0,-@Ignis25Ref,3), -- 3 items from Ref loot
(@IgnisFM25,@Emblem,100,1,0,2,2), -- 2 Emblem
(@IgnisFM25,3,10,1,0,-34154,1), -- 1 from recepies
(@IgnisFM25,45038,8,1,0,1,1), -- Fragment of Val'anyr (quest only!?)
(@IgnisFM25,45087,75,1,0,1,1), -- Runed Orb
-- ----------------
-- -- RAZORSCALE --
-- ----------------
-- Razorscale 10man
(@Razorscale10,1,100,1,0,-@Razor10Ref ,2), -- 2 items from ref loot
(@Razorscale10,@Emblem,100,1,0,1,1), -- Emblem of Triumph
-- Razorscale 25man
(@Razorscale25,1,100,1,0,-@Razor25Ref,3), -- 3 items from Ref loot
(@Razorscale25,@Emblem,100,1,0,1,2), -- 2 Emblems
(@Razorscale25,2,10,1,0,-34154,1), -- 1 from recepies
(@Razorscale25,45038,8,1,0,1,1), -- Fragment of Val'anyr (quest only!?)
(@Razorscale25,45087,75,1,0,1,1), -- Runed Orb
-- -------------------------
-- -- XT002 DECONSTRUCTOR --
-- -------------------------
-- X002 Deconstructor 10man (and hardmode)
(@XT002_10,1,100,3,0,-@XT002_10Ref,2), -- 2items from Ref loot
(@XT002_10,@Emblem,100,3,0,1,1), -- 1x Emblem 
-- Hard mode 10man only:
(@XT002_10,45442,0,2,1,1,1), -- Sorthalis,Hammer of the Watchers
(@XT002_10,45443,0,2,1,1,1), -- Charm of Meticulous Timing
(@XT002_10,45444,0,2,1,1,1), -- Gloves of the Steady Hand
(@XT002_10,45445,0,2,1,1,1), -- Breastplate of the Devoted
(@XT002_10,45446,0,2,1,1,1), -- Grasps of Reason
-- X002 Deconstructor 25man (and hardmode)
(@XT002_25,1,100,3,0,-@XT002_25Ref,3), -- 3 items from Ref loot
(@XT002_25,2,10,3,0,-34154,1), -- 1 from recepies
(@XT002_25,45038,8,3,0,1,1), -- Fragment of Val'anyr (quest only!?)
(@XT002_25,45087,75,3,0,1,1), -- Runed Orb
(@XT002_25,47241,100,3,0,1,2), -- 2 Emblem of Triumph
-- Hard Mode 25man only:
(@XT002_25,45442,0,2,1,1,1), -- Sorthalis,Hammer of the Watchers
(@XT002_25,45443,0,2,1,1,1), -- Charm of Meticulous Timing
(@XT002_25,45444,0,2,1,1,1), -- Gloves of the Steady Hand
(@XT002_25,45445,0,2,1,1,1), -- Breastplate of the Devoted
(@XT002_25,45446,0,2,1,1,1); -- Grasps of Reason
-- (re) Add reference 26042
SET @NEC := 26042; -- Northrend Emotion Cooking Recipe Reference
DELETE FROM `reference_loot_template` WHERE `entry`=@NEC;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@NEC,43507,0,1,1,1,1), -- Recipe: Tasty cupcake
(@NEC,43508,0,1,1,1,1), -- Recipe: Last Week's Mammoth
(@NEC,43509,0,1,1,1,1), -- Recipe: Bad Clams
(@NEC,43510,0,1,1,1,1); -- Recipe: Haunted Herring

DELETE FROM `creature_loot_template` WHERE `entry` IN (2436,5928,5936,12239,12240,12241,12242,12243,14527,14529,14531,16506,16836,17307,21166,23809,23954,23963,23964,23983,24175,25234,28027,28113,28138,28494,29554,30177,30954,31779,40419);
UPDATE `creature_template`SET `lootid`=entry WHERE `entry` IN (2436,5928,5936,12239,12240,12241,12242,12243,14527,14529,14531,16506,16836,21166,23809,23963,23964,23983,25234,28027,28138,28494,29554,30954,31779,40419);
UPDATE `creature_template` SET `lootid`=0 WHERE `entry` IN (17307,23954,24175,28113,30177);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Farmer Kent (friendly?)
(2436,3692,-100,1,0,1,1), -- Hilsbrad Human Skull
-- Sorrow Wing
(5928,5808,-50,1,0,1,1), --  Pridewing Venom Sac
(5928,5137,80,1,0,1,1), -- Bright Eyeball
(5928,5136,10,1,0,1,1), -- Torn Furry Ear
(5928,1,100,1,0,-@NEC,1), -- Random world green drop ilvl 25-30
-- Orca
(5936,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(5936,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(5936,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(5936,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(5936,26005,1,1,1,-26005,1), -- Northrend World Green Reference #3
(5936,26006,1,1,1,-26006,1), -- Northrend World Green Reference #4
(5936,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(5936,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(5936,26019,0.5,1,1,-26019,1), -- Northrend World Blue Reference #3
(5936,26020,0.5,1,1,-26020,1), -- Northrend World Blue Reference #4
-- Add Theradric Crystal Carving (17684) to the following creatures
(12239,17684,-25,1,0,1,1), -- Spirit of Gelk
(12240,17684,-25,1,0,1,1), -- Spirit of Kolk
(12241,17684,-25,1,0,1,1), -- Spirit of Magra
(12242,17684,-25,1,0,1,1), -- Spirit of Maraudos
(12243,17684,-25,1,0,1,1), -- Spirit of Veng
(14527,18952,-100,1,0,1,1), -- Simone the Inconspicuous - Simone's Head
(14529,18953,-100,1,0,1,1), -- Franklin the Friendly - Klinfran's Head
(14531,18955,-100,1,0,1,1), -- Artorius the Amiable - Artorius's Head
(16506,22708,-100,1,0,1,1), -- Naxxramas Worshipper - Fate of Ramaladni
(16836,23460,-100,1,0,1,1), -- Escaped Dreghood - Broken Blood Sample
(21166,30451,-15,1,0,1,1), -- Illidari Dreadlord - Lohn'goron, Bow of the Torn-heart
-- Vengeance Landing Cannoneer
(23809,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23809,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23809,26005,1,1,1,-26005,1), -- Northrend World Green Reference #3
-- Sergeant Lorric
(23963,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23963,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23963,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23963,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23963,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23963,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23963,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- Lieutenant Celeyne
(23964,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23964,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23964,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23964,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23964,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23964,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23964,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- North Fleet Marine
(23983,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(23983,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(23983,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
(23983,26004,1,1,1,-26004,1), -- Northrend World Green Reference #2
(23983,26017,0.5,1,1,-26017,1), -- Northrend World Blue Reference #1
(23983,26018,0.5,1,1,-26018,1), -- Northrend World Blue Reference #2
(23983,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
-- Stormfleet Deckhand
(25234,26000,3,1,1,-26000,1), -- Northrend World Grey Reference #1
(25234,26003,1,1,1,-26003,1), -- Northrend World Green Reference #1
-- High-Oracle Soo-say
(28027,17058,50,1,0,1,1), -- Fish Oil
(28027,17057,30,1,0,1,1), -- Shiny Fish Scales
(28027,33470,15,1,0,2,4), -- Frostweave Cloth
(28027,35951,10,1,0,1,3), -- Poached Emperor Salmon
(28027,38642,-1,1,0,1,1), -- Golden Engagement Ring
-- Elder Harkek
(28138,33470,40,1,0,2,4), -- Frostweave Cloth
(28138,33447,4,1,0,1,1), -- Runic Healing Potion
(28138,38642,-1,1,0,1,1), -- Golden Engagement Ring
-- Kutube'sa
(28494,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(28494,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(28494,26010,1,1,1,-26010,1), -- Northrend World Green Reference #4
(28494,26011,1,1,1,-26011,1), -- Northrend World Green Reference #5
(28494,26012,1,1,1,-26012,1), -- Northrend World Green Reference #6
(28494,26023,0.5,1,1,-26023,1), -- Northrend World Blue Reference #3
(28494,26025,0.5,1,1,-26025,1), -- Northrend World Blue Reference #4
(28494,26026,0.5,1,1,-26026,1), -- Northrend World Blue Reference #5
(28494,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
(28494,39152,35,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(28494,43297,1,1,0,1,1), -- Damaged Necklace
-- Snowblind Devotee
(29554,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(29554,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(29554,26009,1,1,1,-26009,1), -- Northrend World Green Reference #3
(29554,26010,1,1,1,-26010,1), -- Northrend World Green Reference #4
(29554,26011,1,1,1,-26011,1), -- Northrend World Green Reference #5
(29554,26012,1,1,1,-26012,1), -- Northrend World Green Reference #6
(29554,26013,1,1,1,-26013,1), -- Northrend World Green Reference #7
(29554,26023,0.5,1,1,-26023,1), -- Northrend World Blue Reference #3
(29554,26024,0.5,1,1,-26024,1), -- Northrend World Blue Reference #4
(29554,26025,0.5,1,1,-26025,1), -- Northrend World Blue Reference #5
(29554,26026,0.5,1,1,-26026,1), -- Northrend World Blue Reference #6
(29554,26044,2,1,0,-@NEC,1), -- Northrend Emotion Cooking Recipes
(29554,39152,35,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(29554,43297,1,1,0,1,1), -- Damaged Necklace
-- Rokir
(30954,26001,6,1,1,-26001,1), -- Northrend World Grey Reference #2
(30954,26002,6,1,1,-26002,1), -- Northrend World Grey Reference #3
(30954,26014,2,1,1,-26014,1), -- Northrend World Green Reference #8
(30954,26015,2,1,1,-26015,1), -- Northrend World Green Reference #9
-- Skeletal Archmage
(31779,26001,3,1,1,-26001,1), -- Northrend World Grey Reference #2
(31779,26002,3,1,1,-26002,1), -- Northrend World Grey Reference #3
(31779,26013,1,1,1,-26013,1), -- Northrend World Green Reference #7
(31779,26014,1,1,1,-26014,1), -- Northrend World Green Reference #8
(31779,26015,1,1,1,-26015,1), -- Northrend World Green Reference #9
(31779,26028,0.5,1,1,-26028,1), -- Northrend World Blue Reference #8
(31779,39152,50,1,0,1,1), -- Manual: Heavy Frostweave Bandage
(31779,43297,1,1,0,1,1), -- Damaged Necklace
-- Charscale Assaulter
(40419,26001,6,1,1,-26001,1), -- Northrend World Grey Reference #2
(40419,26002,6,1,1,-26002,1), -- Northrend World Grey Reference #3
(40419,26015,2,1,1,-26015,1), -- Northrend World Green Reference #9
(40419,26016,2,1,1,-26016,1); -- Northrend World Green Reference #10
-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` IN (28494,29554,31779);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(1,28494,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390'),
(1,29554,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390'),
(1,31779,39152,7,129,390,'Manual: Heavy Frostweave Bandage will drop only if the player has first aid at 390');
-- darkmoon faerie resync, again
UPDATE `game_event` SET `start_time`='2012-04-01 00:01:00' WHERE `eventEntry`=5;
UPDATE `game_event` SET `start_time`='2012-05-06 00:01:00' WHERE `eventEntry`=3;
UPDATE `game_event` SET `start_time`='2012-06-03 00:01:00' WHERE `eventEntry`=4;
UPDATE `creature_template` SET `HoverHeight`=10.8, `VehicleId`=232 WHERE `entry`=30393;
UPDATE `creature_template` SET `HoverHeight`=10.8, `VehicleId`=237 WHERE `entry`=30461;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=27530;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=26277;
UPDATE `creature_template` SET `HoverHeight`=10 WHERE `entry`=26276;
UPDATE `creature_template` SET `HoverHeight`=1.2 WHERE `entry`=31070;
UPDATE `creature_template` SET `HoverHeight`=12 WHERE `entry`=37126;
UPDATE `creature_template` SET `HoverHeight`=15 WHERE `entry`=27608;
UPDATE `creature_template` SET `HoverHeight`=15 WHERE `entry`=27608;
UPDATE `creature_template` SET `HoverHeight`=1.6 WHERE `entry`=38392;
UPDATE `creature_template` SET `HoverHeight`=2.25 WHERE `entry`=30272;
UPDATE `creature_template` SET `HoverHeight`=2.58, `Scale`=1.72 WHERE `entry`=26607;
UPDATE `creature_template` SET `HoverHeight`=25 WHERE `entry`=37755;
UPDATE `creature_template` SET `HoverHeight`=26 WHERE `entry`=29790;
UPDATE `creature_template` SET `HoverHeight`=2.7 WHERE `entry`=25451;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=29048;
UPDATE `creature_template` SET `HoverHeight`=2, `VehicleId`=234 WHERE `entry`=30228;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=25445;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `HoverHeight`=2 WHERE `entry`=25721;
UPDATE `creature_template` SET `HoverHeight`=35 WHERE `entry`=27789;
UPDATE `creature_template` SET `HoverHeight`=3 WHERE `entry`=34567;
UPDATE `creature_template` SET `HoverHeight`=3 WHERE `entry`=26668;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=390 WHERE `entry`=34120;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=108 WHERE `entry`=24083;
UPDATE `creature_template` SET `HoverHeight`=3, `VehicleId`=270 WHERE `entry`=31137;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=24272;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=37098;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=28534;
UPDATE `creature_template` SET `HoverHeight`=4 WHERE `entry`=28511;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `HoverHeight`=5.85 WHERE `entry`=32534;
UPDATE `creature_template` SET `HoverHeight`=5, `VehicleId`=348 WHERE `entry`=33214;
UPDATE `creature_template` SET `HoverHeight`=5 WHERE `entry`=27693;
UPDATE `creature_template` SET `HoverHeight`=5 WHERE `entry`=34203;
UPDATE `creature_template` SET `HoverHeight`=6.25 WHERE `entry`=40083;
UPDATE `creature_template` SET `HoverHeight`=6.25 WHERE `entry`=40100;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34496;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34496;
UPDATE `creature_template` SET `HoverHeight`=6 WHERE `entry`=34497;
UPDATE `creature_template` SET `HoverHeight`=7.5 WHERE `entry`=26933;
UPDATE `creature_template` SET `HoverHeight`=8.4, `VehicleId`=232 WHERE `entry`=30420;
UPDATE `creature_template` SET `HoverHeight`=8 WHERE `entry`=33186;
UPDATE `creature_template` SET `HoverHeight`=9 WHERE `entry`=26933;
UPDATE `creature_template` SET `HoverHeight`=9  WHERE `entry`=37528;
UPDATE `creature_template` SET `HoverHeight`=9  WHERE `entry`=37230;
UPDATE `creature_template` SET `HoverHeight`=9, `VehicleId`=375 WHERE `entry`=33687;
UPDATE `creature_template` SET `HoverHeight`=9, `VehicleId`=535 WHERE `entry`=36661;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10.8, `VehicleId`=232 WHERE `entry`=30393;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10 WHERE `entry`=27608;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=10 WHERE `entry`=27608;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=15 WHERE `entry`=32630;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=1.6 WHERE `entry`=38391;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2.25, `VehicleId`=247 WHERE `entry`=30564;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2.25 WHERE `entry`=30272;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=25721;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=29570;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=2 WHERE `entry`=26761;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3.12, `Scale`=2.08 WHERE `entry`=26607;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3 WHERE `entry`=26668;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=3, `VehicleId`=108 WHERE `entry`=24083;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=4 WHERE `entry`=37098;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=4  WHERE `entry`=30945;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5.85 WHERE `entry`=26736;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=5, `VehicleId`=276 WHERE `entry`=31432;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=6 WHERE `entry`=30501;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=7.5 WHERE `entry`=26933;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=8.4, `VehicleId`=232 WHERE `entry`=30420;
UPDATE `creature_template` SET `InhabitType`=0x4, `HoverHeight`=9 WHERE `entry`=26933;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (34477, 35079);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(34477,'spell_hun_misdirection'), 
(35079,'spell_hun_misdirection_proc');
ALTER TABLE `battleground_template` CHANGE `Weight` `Weight` tinyint(3) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `conditions` CHANGE `SourceId` `SourceId` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `creature` CHANGE `equipment_id` `equipment_id` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `creature_addon` CHANGE `path_id` `path_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_ai_scripts` CHANGE `id` `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier';
ALTER TABLE `creature_ai_scripts` CHANGE `creature_id` `creature_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Template Identifier';
ALTER TABLE `creature_ai_scripts` CHANGE `event_type` `event_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type';
ALTER TABLE `creature_ai_scripts` CHANGE `event_chance` `event_chance` int(10) unsigned NOT NULL DEFAULT '100';
ALTER TABLE `creature_ai_scripts` CHANGE `event_flags` `event_flags` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_ai_scripts` CHANGE `action1_type` `action1_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_scripts` CHANGE `action2_type` `action2_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_scripts` CHANGE `action3_type` `action3_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action Type';
ALTER TABLE `creature_ai_summons` CHANGE `id` `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Identifier';
ALTER TABLE `creature_ai_summons` CHANGE `spawntimesecs` `spawntimesecs` int(10) unsigned NOT NULL DEFAULT '120';
ALTER TABLE `creature_classlevelstats` CHANGE `level` `level` tinyint(4) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `class` `class` tinyint(4) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp0` `basehp0` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp1` `basehp1` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basehp2` `basehp2` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basemana` `basemana` smallint(6) NOT NULL;
ALTER TABLE `creature_classlevelstats` CHANGE `basearmor` `basearmor` smallint(6) NOT NULL;
ALTER TABLE `creature_formations` CHANGE `leaderGUID` `leaderGUID` int(10) unsigned NOT NULL;
ALTER TABLE `creature_formations` CHANGE `memberGUID` `memberGUID` int(10) unsigned NOT NULL;
ALTER TABLE `creature_formations` CHANGE `groupAI` `groupAI` int(10) unsigned NOT NULL;
ALTER TABLE `creature_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `creature_onkill_reputation` CHANGE `RewOnKillRepValue1` `RewOnKillRepValue1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `KillCredit1` `KillCredit1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `KillCredit2` `KillCredit2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `exp` `exp` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance1` `resistance1` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance2` `resistance2` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance3` `resistance3` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance4` `resistance4` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance5` `resistance5` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `resistance6` `resistance6` smallint(6) NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem1` `questItem1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem2` `questItem2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem3` `questItem3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem4` `questItem4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem5` `questItem5` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `questItem6` `questItem6` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `creature_template_addon` CHANGE `path_id` `path_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `creature_transport` CHANGE `guid` `guid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'GUID of NPC on transport - not the same as creature.guid';
ALTER TABLE `creature_transport` CHANGE `transport_entry` `transport_entry` int(11) NOT NULL COMMENT 'Transport entry';
ALTER TABLE `creature_transport` CHANGE `npc_entry` `npc_entry` int(11) NOT NULL COMMENT 'NPC entry';
ALTER TABLE `creature_transport` CHANGE `emote` `emote` int(11) NOT NULL;
ALTER TABLE `db_script_string` CHANGE `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';  
  ALTER TABLE `exploration_basexp` CHANGE `level` `level` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `exploration_basexp` CHANGE `basexp` `basexp` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `fishing_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `game_event_creature` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_gameobject` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_model_equip` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_npc_vendor` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_pool` CHANGE `eventEntry` `eventEntry` tinyint(4) NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `gameobject_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `gameobject_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `gossip_menu` CHANGE `entry` `entry` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `menu_id` `menu_id` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `id` `id` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_money` `box_money` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_menu_id` `action_menu_id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `instance_template` CHANGE `allowMount` `allowMount` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `ip2nation` CHANGE `ip` `ip` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `item_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `item_set_names` CHANGE `WDBVerified` `WDBVerified` smallint(6) NOT NULL DEFAULT '1';
ALTER TABLE `item_template` CHANGE `spellcharges_1` `spellcharges_1` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_2` `spellcharges_2` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_3` `spellcharges_3` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_4` `spellcharges_4` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `spellcharges_5` `spellcharges_5` smallint(6) NULL DEFAULT NULL;
ALTER TABLE `item_template` CHANGE `BagFamily` `BagFamily` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `TotemCategory` `TotemCategory` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_1` `socketContent_1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_2` `socketContent_2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketContent_3` `socketContent_3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `socketBonus` `socketBonus` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `GemProperties` `GemProperties` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `item_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `item_template` CHANGE `ScalingStatValue` `ScalingStatValue` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `mail_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `milling_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `npc_spellclick_spells` CHANGE `user_type` `user_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'relation with summoner: 0-no 1-friendly 2-raid 3-party player can click';
ALTER TABLE `outdoorpvp_template` CHANGE `TypeId` `TypeId` tinyint(3) unsigned NOT NULL;
ALTER TABLE `page_text` CHANGE `WDBVerified` `WDBVerified` smallint(6) NULL DEFAULT '1';
ALTER TABLE `pet_name_generation` CHANGE `half` `half` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `pickpocketing_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `player_factionchange_achievement` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_achievement` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `race_A` `race_A` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `race_H` `race_H` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_items` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_reputations` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_reputations` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_spells` CHANGE `alliance_id` `alliance_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_factionchange_spells` CHANGE `horde_id` `horde_id` int(10) unsigned NOT NULL; -- also changed to unsigned
ALTER TABLE `player_xp_for_level` CHANGE `lvl` `lvl` tinyint(3) unsigned NOT NULL; -- also changed from int to tinyint
ALTER TABLE `playercreateinfo_action` CHANGE `action` `action` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `playercreateinfo_item` CHANGE `amount` `amount` tinyint(4) NOT NULL DEFAULT '1';
ALTER TABLE `playercreateinfo_spell_custom` DROP `Active`; -- delete field, it's not used anywhere
ALTER TABLE `prospecting_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `quest_poi` CHANGE `objIndex` `objIndex` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_poi_points` CHANGE `x` `x` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_poi_points` CHANGE `y` `y` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredFactionValue1` `RequiredFactionValue1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredFactionValue2` `RequiredFactionValue2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMinRepValue` `RequiredMinRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMinRepValue` `RequiredMinRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredMaxRepValue` `RequiredMaxRepValue` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `PrevQuestId` `PrevQuestId` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `NextQuestId` `NextQuestId` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `ExclusiveGroup` `ExclusiveGroup` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardSpellCast` `RewardSpellCast` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardHonor` `RewardHonor` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardXPId` `RewardXPId` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId1` `RewardFactionValueId1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId2` `RewardFactionValueId2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId3` `RewardFactionValueId3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId4` `RewardFactionValueId4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueId5` `RewardFactionValueId5` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride1` `RewardFactionValueIdOverride1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride2` `RewardFactionValueIdOverride2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride3` `RewardFactionValueIdOverride3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride4` `RewardFactionValueIdOverride4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RewardFactionValueIdOverride5` `RewardFactionValueIdOverride5` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo1` `RequiredNpcOrGo1` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo2` `RequiredNpcOrGo2` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo3` `RequiredNpcOrGo3` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `RequiredNpcOrGo4` `RequiredNpcOrGo4` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `Unknown0` `Unknown0` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay1` `DetailsEmoteDelay1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay2` `DetailsEmoteDelay2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay3` `DetailsEmoteDelay3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `DetailsEmoteDelay4` `DetailsEmoteDelay4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay1` `OfferRewardEmoteDelay1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay2` `OfferRewardEmoteDelay2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay3` `OfferRewardEmoteDelay3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `OfferRewardEmoteDelay4` `OfferRewardEmoteDelay4` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `quest_template` CHANGE `WDBVerified` `WDBVerified` smallint(6) NOT NULL DEFAULT '1';
ALTER TABLE `reference_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `reputation_spillover_template` CHANGE `faction` `faction` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction entry';
ALTER TABLE `reputation_spillover_template` CHANGE `faction1` `faction1` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'faction to give spillover for';
ALTER TABLE `reputation_spillover_template` CHANGE `faction2` `faction2` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `reputation_spillover_template` CHANGE `faction3` `faction3` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `reputation_spillover_template` CHANGE `faction4` `faction4` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `skinning_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `spell_area` CHANGE `quest_start_active` `quest_start_active` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_area` CHANGE `gender` `gender` tinyint(3) unsigned NOT NULL DEFAULT '2';
ALTER TABLE `spell_area` CHANGE `autocast` `autocast` tinyint(3) unsigned NOT NULL DEFAULT '0';
-- All the fields in spell_dbc where changed to full int32 since the DBC structure is used
ALTER TABLE `spell_dbc` CHANGE `Dispel` `Dispel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Mechanic` `Mechanic` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `CastingTimeIndex` `CastingTimeIndex` int(10) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `spell_dbc` CHANGE `DurationIndex` `DurationIndex` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `ProcChance` `ProcChance` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `ProcCharges` `ProcCharges` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `BaseLevel` `BaseLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxLevel` `MaxLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `SpellLevel` `SpellLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `RangeIndex` `RangeIndex` int(10) unsigned NOT NULL DEFAULT '1';
ALTER TABLE `spell_dbc` CHANGE `Effect1` `Effect1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Effect2` `Effect2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `Effect3` `Effect3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic1` `EffectMechanic1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic2` `EffectMechanic2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectMechanic3` `EffectMechanic3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA1` `EffectImplicitTargetA1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA2` `EffectImplicitTargetA2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetA3` `EffectImplicitTargetA3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB1` `EffectImplicitTargetB1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB2` `EffectImplicitTargetB2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectImplicitTargetB3` `EffectImplicitTargetB3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex1` `EffectRadiusIndex1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex2` `EffectRadiusIndex2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectRadiusIndex3` `EffectRadiusIndex3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName1` `EffectApplyAuraName1` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName2` `EffectApplyAuraName2` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `EffectApplyAuraName3` `EffectApplyAuraName3` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxTargetLevel` `MaxTargetLevel` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `SpellFamilyName` `SpellFamilyName` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `MaxAffectedTargets` `MaxAffectedTargets` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `DmgClass` `DmgClass` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `PreventionType` `PreventionType` int(10) unsigned NOT NULL DEFAULT '0';
--
ALTER TABLE `spell_group` CHANGE `id` `id` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `spell_loot_template` CHANGE `mincountOrRef` `mincountOrRef` mediumint(8) NOT NULL DEFAULT '1';
ALTER TABLE `spell_proc` CHANGE `spellPhaseMask` `spellPhaseMask` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `spell_proc` CHANGE `hitMask` `hitMask` int(11) NOT NULL DEFAULT '0';
ALTER TABLE `spell_enchant_proc_data` CHANGE `procEx` `procEx` int(10) unsigned NOT NULL DEFAULT '0'; -- changed from float to int
ALTER TABLE `spell_required` CHANGE `spell_id` `spell_id` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `spell_required` CHANGE `req_spell` `req_spell` mediumint(8) NOT NULL DEFAULT '0';
ALTER TABLE `spell_threat` CHANGE `flatMod` `flatMod` int(11) NULL DEFAULT NULL;
ALTER TABLE `vehicle_accessory` CHANGE `seat_id` `seat_id` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_accessory` CHANGE `minion` `minion` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_template_accessory` CHANGE `seat_id` `seat_id` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `vehicle_template_accessory` CHANGE `minion` `minion` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `version` CHANGE `cache_id` `cache_id` int(11) NULL DEFAULT '0';
ALTER TABLE `waypoint_data` CHANGE `move_flag` `move_flag` tinyint(4) NOT NULL DEFAULT '0';
ALTER TABLE `spell_dbc` CHANGE `StackAmount` `StackAmount` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `waypoint_data` CHANGE `action_chance` `action_chance` smallint(6) NOT NULL DEFAULT '100';
ALTER TABLE `item_loot_template` CHANGE `maxcount` `maxcount` tinyint(3) unsigned NOT NULL DEFAULT '1';
-- Hunter Volley
UPDATE `spell_bonus_data` SET `ap_bonus`=0.0837 WHERE `entry`=42243;
-- revised from Unholys original works
-- quest 12702 chicken party!
-- quest 12532 flown the coop!
-- 
SET @ENTRY := 28161; -- the chicken
SET @PARTY := 12702; -- chicken party quest
SET @COOP := 12532; -- flown the coop quest
SET @LIFE := 900000; -- minutes

-- set up required spells for the spells to work as they should
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@ENTRY;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES 
(@ENTRY,39996,1,0), -- cover spell (dummy)
(@ENTRY,51037,2,0); -- creates item in players back pack

-- set npc up to use event script
UPDATE `creature_template` SET `AIName`='SmartAI'  WHERE `entry`=@ENTRY;

-- convert over to smart script
DELETE FROM `creature_ai_scripts` WHERE `id`=@ENTRY; -- delete old eai scripts
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,1000,2000,3000,89,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'create random movement every 2-3 secs'),
(@ENTRY,0,1,0,8,0,100,0,51951,0,0,0,11,50839,0,0,0,0,0,1,0,0,0,0,0,0,0, 'when hit with net cast self stun'),
(@ENTRY,0,2,0,8,0,100,0,39996,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'force despawn @1 sec when hit with dummy spell');

-- Remove previous scripts that may interfere with this work
DELETE FROM `quest_start_scripts` WHERE `id` IN (@PARTY,@COOP);

-- start script for quest chicken party (they do not all spawn at same time)
UPDATE `quest_template` SET `StartScript`=@PARTY WHERE `id`=@PARTY; -- 12072
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES 
(@PARTY,1,10,@ENTRY,@LIFE, 0,5251.09,4413.76,-96.086,4.8714),
(@PARTY,2,10,@ENTRY,@LIFE, 0,5251.22,4419.74,-95.8995,3.58335),
(@PARTY,23,10,@ENTRY,@LIFE, 0,5257.58,4421.77,-95.9072,2.62124),
(@PARTY,4,10,@ENTRY,@LIFE,0, 5255.97,4420.37,-95.9999,0.0451326),
(@PARTY,5,10,@ENTRY,@LIFE,0, 5256.78,4420.63,-95.9957,0.320021),
(@PARTY,6,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,0.956194),
(@PARTY,27,10,@ENTRY,@LIFE,0, 5258.54,4420.49,-96.0195,0.551714),
(@PARTY,8,10,@ENTRY,@LIFE,0, 5250.67,4417.98,-95.9787,4.39231),
(@PARTY,9,10,@ENTRY,@LIFE,0, 5273.53,4430.32,-96.0241,1.0897),
(@PARTY,40,10,@ENTRY,@LIFE,0, 5158.3,4605.25,-130.988,3.7522),
(@PARTY,21,10,@ENTRY,@LIFE,0, 5164.6,4609.43,-130.427,3.70115),
(@PARTY,22,10,@ENTRY,@LIFE,0, 5169.53,4612.44,-130.817,4.05065),
(@PARTY,23,10,@ENTRY,@LIFE,0, 5188.49,4627.85,-132.485,3.60691),
(@PARTY,44,10,@ENTRY,@LIFE,0, 5203.19,4631.63,-132.611,2.849),
(@PARTY,25,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.378917),
(@PARTY,26,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.66166),
(@PARTY,27,10,@ENTRY,@LIFE,0, 5203.5,4595.02,-111.327,5.51542),
(@PARTY,48,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,0.579192),
(@PARTY,29,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,1.09756),
(@PARTY,30,10,@ENTRY,@LIFE,0, 5172.43,4533.25,-97.3836,1.15253),
(@PARTY,41,10,@ENTRY,@LIFE,0, 5186.29,4522.69,-91.0957,3.02571),
(@PARTY,32,10,@ENTRY,@LIFE,0, 5214.67,4485.22,-91.3113,2.40524),
(@PARTY,33,10,@ENTRY,@LIFE,0, 5221.85,4475.99,-96.8801,4.89495),
(@PARTY,34,10,@ENTRY,@LIFE,0, 5222.95,4438.1,-96.8062,1.6277),
(@PARTY,35,10,@ENTRY,@LIFE,0, 5224.36,4427.83,-96.9221,2.63301),
(@PARTY,36,10,@ENTRY,@LIFE,0, 5234.72,4406.44,-95.2917,0.0647549),
(@PARTY,47,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,3.79933),
(@PARTY,38,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,4.29414),
(@PARTY,39,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,3.90536),
(@PARTY,40,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,4.36089);

-- start script for quest flown the coop (they do not all spawn at same time)
UPDATE `quest_template` SET `StartScript`=@COOP WHERE `id`=@COOP; -- 12532
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES 
(@COOP,23,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,2.62124),
(@COOP,4,10,@ENTRY,@LIFE,0, 5255.97,4420.37,-95.9999,0.0451326),
(@COOP,5,10,@ENTRY,@LIFE,0, 5256.78,4420.63,-95.9957,0.320021),
(@COOP,6,10,@ENTRY,@LIFE,0, 5257.58,4421.77,-95.9072,0.956194),
(@COOP,27,10,@ENTRY,@LIFE,0, 5258.54,4420.49,-96.0195,0.551714),
(@COOP,8,10,@ENTRY,@LIFE,0, 5250.67,4417.98,-95.9787,4.39231),
(@COOP,9,10,@ENTRY,@LIFE,0, 5273.53,4430.32,-96.0241,1.0897),
(@COOP,40,10,@ENTRY,@LIFE,0, 5158.3,4605.25,-130.988,3.7522),
(@COOP,21,10,@ENTRY,@LIFE,0, 5164.6,4609.43,-130.427,3.70115),
(@COOP,22,10,@ENTRY,@LIFE,0, 5169.53,4612.44,-130.817,4.05065),
(@COOP,23,10,@ENTRY,@LIFE,0, 5188.49,4627.85,-132.485,3.60691),
(@COOP,44,10,@ENTRY,@LIFE,0, 5203.19,4631.63,-132.611,2.849),
(@COOP,25,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.378917),
(@COOP,26,10,@ENTRY,@LIFE,0, 5219.62,4632.46,-134.232,0.66166),
(@COOP,27,10,@ENTRY,@LIFE,0, 5203.5,4595.02,-111.327,5.51542),
(@COOP,48,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,0.579192),
(@COOP,29,10,@ENTRY,@LIFE,0, 5179.35,4558,-100.344,1.09756),
(@COOP,30,10,@ENTRY,@LIFE,0, 5172.43,4533.25,-97.3836,1.15253),
(@COOP,41,10,@ENTRY,@LIFE,0, 5186.29,4522.69,-91.0957,3.02571),
(@COOP,32,10,@ENTRY,@LIFE,0, 5214.67,4485.22,-91.3113,2.40524),
(@COOP,33,10,@ENTRY,@LIFE,0, 5221.85,4475.99,-96.8801,4.89495),
(@COOP,34,10,@ENTRY,@LIFE,0, 5222.95,4438.1,-96.8062,1.6277),
(@COOP,35,10,@ENTRY,@LIFE,0, 5224.36,4427.83,-96.9221,2.63301),
(@COOP,36,10,@ENTRY,@LIFE,0, 5234.72,4406.44,-95.2917,0.0647549),
(@COOP,47,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,3.79933),
(@COOP,38,10,@ENTRY,@LIFE,0, 5227.28,4407.01,-95.3888,4.29414),
(@COOP,39,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,3.90536),
(@COOP,40,10,@ENTRY,@LIFE,0, 5251.09,4413.76,-96.086,4.36089);
-- -------------------------------
-- -- The Antechamber of Ulduar --
-- -------------------------------
-- Creatures
SET @Brundir10 :=32857;
call `sp_get_npc_diffentry`(@Brundir10,1,@Brundir25); -- Get 25man id using procedure
SET @Molgeim10 :=32927;
call `sp_get_npc_diffentry`(@Molgeim10,1,@Molgeim25); -- Get 25man id using procedure
SET @Steelbreaker10 :=32867;
call `sp_get_npc_diffentry`(@Steelbreaker10,1,@Steelbreaker25); -- Get 25man id using procedure
SET @Auriaya10 :=33515;
call `sp_get_npc_diffentry`(@Auriaya10,1,@Auriaya25); -- Get 25man id using procedure
-- Gameobjects
SET @Kologarn10 := 195046; -- Cache of the Living Stone 10man
CALL `sp_get_go_lootid`(@Kologarn10,@CacheLivingStone10); -- Get Lootid from data1 field using procedure
SET @Kologarn25 := 195047; -- Cache of the Living Stone 25man
CALL `sp_get_go_lootid`(@Kologarn25,@CacheLivingStone25); -- Get Lootid from data1 field using procedure
-- bosses
SET @Assembly10Ref := 34359;
SET @Assembly25Ref := @Assembly10Ref+1;
SET @Kologarn10Ref := @Assembly10Ref+2;
SET @Kologarn25Ref := @Assembly10Ref+3;
SET @Auriaya10Ref := @Assembly10Ref+4;
SET @Auriaya25Ref := @Assembly10Ref+5;

-- ------------------------------
-- -- Reference Loot Templates --
-- ------------------------------
-- Delete previous templates if existing
DELETE FROM `reference_loot_template` WHERE `entry` IN (12019,34122,34123,34124,34163,34216);
-- Delete the current if existing & add
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @Assembly10Ref AND @Assembly10Ref+5;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Assembly Of Iron 10man
(@Assembly10Ref,45322,0,1,1,1,1), -- Cloak of the Iron Council
(@Assembly10Ref,45324,0,1,1,1,1), -- Leggings of Swift Reflexes
(@Assembly10Ref,45329,0,1,1,1,1), -- Circlet of True Sight
(@Assembly10Ref,45330,0,1,1,1,1), -- Greaves of Iron Intensity
(@Assembly10Ref,45331,0,1,1,1,1), -- Rune-Etched Nightblade
(@Assembly10Ref,45332,0,1,1,1,1), -- Stormtip
(@Assembly10Ref,45333,0,1,1,1,1), -- Belt of the Iron Servant
(@Assembly10Ref,45378,0,1,1,1,1), -- Boots of the Petrified Forest
(@Assembly10Ref,45418,0,1,1,1,1), -- Lady Maye's Sapphire Ring
(@Assembly10Ref,45423,0,1,1,1,1), -- Runetouch Wristwraps
-- Assembly Of Iron 25man
(@Assembly25Ref,45233,0,1,1,1,1), -- Stormrune Edge
(@Assembly25Ref,45234,0,1,1,1,1), -- Rapture
(@Assembly25Ref,45237,0,1,1,1,1), -- Phaelia's Vestments of the Sprouting Seed
(@Assembly25Ref,45193,0,1,1,1,1), -- Insurmountable Fervor
(@Assembly25Ref,45236,0,1,1,1,1), -- Unblinking Eye
(@Assembly25Ref,45225,0,1,1,1,1), -- Steelbreaker's Embrace
(@Assembly25Ref,45240,0,1,1,1,1), -- Raiments of the Iron Council
(@Assembly25Ref,45226,0,1,1,1,1), -- Ancient Iron Heaume
(@Assembly25Ref,45235,0,1,1,1,1), -- Radiant Seal
(@Assembly25Ref,45227,0,1,1,1,1), -- Iron-studded Mantle
(@Assembly25Ref,45239,0,1,1,1,1), -- Runeshaper's Gloves
(@Assembly25Ref,45224,0,1,1,1,1), -- Drape of the Lithe
(@Assembly25Ref,45232,0,1,1,1,1), -- Runed Ironhide Boots
(@Assembly25Ref,45228,0,1,1,1,1), -- Handguards of the Enclave
(@Assembly25Ref,45238,0,1,1,1,1), -- Overload Legwraps
-- Cache of Living Stone 10man
(@Kologarn10Ref,45701,0,1,1,1,1), -- Greaves of the Earthbinder
(@Kologarn10Ref,45965,0,1,1,1,1), -- Spire of Withering Dreams
(@Kologarn10Ref,45702,0,1,1,1,1), -- Emerald Signet Ring
(@Kologarn10Ref,45696,0,1,1,1,1), -- Mark of the Unyielding
(@Kologarn10Ref,45698,0,1,1,1,1), -- Sabatons of the Iron Watcher
(@Kologarn10Ref,45697,0,1,1,1,1), -- Shoulderguards of the Solemn Watch
(@Kologarn10Ref,45703,0,2,2,1,1), -- Spark of Hope
(@Kologarn10Ref,45700,0,2,2,1,1), -- Stoneguard
(@Kologarn10Ref,45699,0,2,2,1,1), -- Pendant of the Piercing Glare
(@Kologarn10Ref,45704,0,2,2,1,1), -- Shawl of the Shattered Giant
-- Cache of Living Stone 25man
(@Kologarn25Ref,45261,0,1,1,1,1), -- Giant's Bane
(@Kologarn25Ref,45266,0,1,1,1,1), -- Malice
(@Kologarn25Ref,45274,0,1,1,1,1), -- Leggings of the Stoneweaver
(@Kologarn25Ref,45269,0,1,1,1,1), -- Unfaltering Armguards
(@Kologarn25Ref,45268,0,1,1,1,1), -- Gloves of the Pythonic Guardian
(@Kologarn25Ref,45262,0,1,1,1,1), -- Necklace of Unerring Mettle
(@Kologarn25Ref,45275,0,1,1,1,1), -- Bracers of Unleashed Magic
(@Kologarn25Ref,45272,0,1,1,1,1), -- Robes of the Umbral Brute
(@Kologarn25Ref,45267,0,1,1,1,1), -- Saronite Plated Legguards
(@Kologarn25Ref,45263,0,1,1,1,1), -- Wrathstone
(@Kologarn25Ref,45271,0,1,1,1,1), -- Ironmender
(@Kologarn25Ref,45264,0,1,1,1,1), -- Decimator's Armguards
(@Kologarn25Ref,45265,0,1,1,1,1), -- Shoulderpads of the Monolith
(@Kologarn25Ref,45273,0,1,1,1,1), -- Handwraps of Plentiful Recovery
(@Kologarn25Ref,45270,0,1,1,1,1), -- Idol of the Crying Wind
-- Auriaya 10man
(@Auriaya10Ref,45707,0,1,1,1,1), -- Shieldwall of the Breaker
(@Auriaya10Ref,45708,0,1,1,1,1), -- Archaedas' Lost Legplates
(@Auriaya10Ref,45709,0,1,1,1,1), -- Nimble Climber's Belt
(@Auriaya10Ref,45711,0,1,1,1,1), -- Ironaya's Discarded Mantle
(@Auriaya10Ref,45712,0,1,1,1,1), -- Chestplate of Titanic Fury
(@Auriaya10Ref,45713,0,1,1,1,1), -- Nurturing Touch
(@Auriaya10Ref,45832,0,1,1,1,1), -- Mantle of the Preserver
(@Auriaya10Ref,45864,0,1,1,1,1), -- Cover of the Keepers
(@Auriaya10Ref,45865,0,1,1,1,1), -- Raiments of the Corrupted
(@Auriaya10Ref,45866,0,1,1,1,1), -- Elemental Focus Stone
-- Auriaya 25man
(@Auriaya25Ref,45327,0,1,1,1,1), -- Siren's Cry
(@Auriaya25Ref,45437,0,1,1,1,1), -- Runescribed Blade
(@Auriaya25Ref,45315,0,1,1,1,1), -- Stonerender
(@Auriaya25Ref,45439,0,1,1,1,1), -- Unwavering Stare
(@Auriaya25Ref,45326,0,1,1,1,1), -- Platinum Band of the Aesir
(@Auriaya25Ref,45441,0,1,1,1,1), -- Sandals of the Ancient Keeper
(@Auriaya25Ref,45435,0,1,1,1,1), -- Cowl of the Absolute
(@Auriaya25Ref,45438,0,1,1,1,1), -- Ring of the Faithful Servant
(@Auriaya25Ref,45434,0,1,1,1,1), -- Greaves of the Rockmender
(@Auriaya25Ref,45320,0,1,1,1,1), -- Shoulderplates of the Eternal
(@Auriaya25Ref,45325,0,1,1,1,1), -- Gloves of the Stonereaper
(@Auriaya25Ref,45440,0,1,1,1,1), -- Amice of the Stoic Watch
(@Auriaya25Ref,45334,0,1,1,1,1), -- Unbreakable Chestguard
(@Auriaya25Ref,45319,0,1,1,1,1), -- Cloak of the Makers
(@Auriaya25Ref,45436,0,1,1,1,1); -- Libram of the Resolute

-- ---------------------------
-- -- ASSIGN CREATURE LOOTS -- 
-- ---------------------------
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (@Brundir10,@Molgeim10,@Steelbreaker10,@Brundir25,@Molgeim25,@Steelbreaker25,@Auriaya10,@Auriaya25);
DELETE FROM `creature_loot_template` WHERE `entry` IN (@Brundir10,@Molgeim10,@Steelbreaker10,@Brundir25,@Molgeim25,@Steelbreaker25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ASSEMBLY OF IRON 10-man
-- Stormcaller Brundir killed last
(@Brundir10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Brundir10,47241,100,1,0,1,1), -- 1 Emblem of Triumph
-- Runemaster Molgeim killed last
(@Molgeim10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Molgeim10,47241,100,1,0,2,2), -- 2 Emblem of Triumph
(@Molgeim10,45506,100,2,0,1,1), -- Archivum Data Disc
(@Molgeim10,45087,75,1,0,1,1), -- Runed Orb
-- Steelbreaker killed last
(@Steelbreaker10,1,100,1,0,-@Assembly10Ref,2), -- 2 items from reference loot
(@Steelbreaker10,47241,100,1,0,2,2), -- 2 Emblem of Triumph
(@Steelbreaker10,45087,75,1,0,1,1), -- Runed Orb
(@Steelbreaker10,45506,100,1,0,1,1), -- Archivum Data Disc for Quest 
(@Steelbreaker10,25455,0,1,1,1,1), -- Belt fo the Crystal Tree
(@Steelbreaker10,45447,0,1,1,1,1), -- Watchful Eye of Fate
(@Steelbreaker10,45456,0,1,1,1,1), -- Loop of the Agile
(@Steelbreaker10,45449,0,1,1,1,1), -- The Masticator
(@Steelbreaker10,45448,0,1,1,1,1), -- Perilous Bite
-- ASSEMBLY OF IRON 25-man
-- Stormcaller Brundir killed last
(@Brundir25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Brundir25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Brundir25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Brundir25,45087,75,1,0,1,1), -- Runed Orb
(@Brundir25,47241,100,1,0,1,2), --  2 Emblems of Triumph
-- Runemaster Molgeim killed last
(@Molgeim25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Molgeim25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Molgeim25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Molgeim25,45087,75,1,0,1,1), -- Runed Orb
(@Molgeim25,47241,100,1,0,2,2), -- 2 Emblems of Triumph
(@Molgeim25,45506,100,1,0,1,1), -- Archivum Data Disc
-- Steelbreaker killed last
(@Steelbreaker25,1,100,1,0,-@Assembly25Ref,3), -- 3 items from reference loot
(@Steelbreaker25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Steelbreaker25,45038,18,1,0,1,1), -- Fragment of Val'anyr
(@Steelbreaker25,45087,75,1,0,2,2), -- 2x Runed Orb
(@Steelbreaker25,47241,100,1,0,2,2), -- 2 Emblems of Triumph
(@Steelbreaker25,45506,100,1,0,1,1), -- Archivum Data Disc
(@Steelbreaker25,45241,0,1,1,1,1), -- Belt of Colossal Rage
(@Steelbreaker25,45242,0,1,1,1,1), -- Drape of Mortal Downfall
(@Steelbreaker25,45607,0,1,1,1,1), -- Fang of Oblivion
(@Steelbreaker25,45244,0,1,1,1,1), -- Greaves of Swift Vengeance
(@Steelbreaker25,45243,0,1,1,1,1), -- Sapphire Amulet of Renewal
(@Steelbreaker25,45245,0,1,1,1,1); -- Shoulderpads of the Intruder

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (@CacheLivingStone10,@CacheLivingStone25);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- KOLOGARN 10-man
(@CacheLivingStone10,1,100,1,0,-@Kologarn10Ref,2), -- 2 items from reference loot
(@CacheLivingStone10,47241,100,1,0,1,1), -- 1 Emblem of Triumph
-- KOLOGARN 25-Man
(@CacheLivingStone25,1,100,1,0,-@Kologarn25Ref,3), -- 3 items from reference loot
(@CacheLivingStone25,2,10,1,0,-34154,1), -- Chance on Recipe
(@CacheLivingStone25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@CacheLivingStone25,45087,50,1,0,1,1), -- Runed Orb
(@CacheLivingStone25,47241,100,1,0,1,2); -- 2 Emblems of Triumph

DELETE FROM `creature_loot_template` WHERE `entry` IN (@Auriaya10,@Auriaya25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- AURIAYA 10-man
(@Auriaya10,1,100,1,0,-@Auriaya10Ref,2), -- 2 items from reference loot
(@Auriaya10,47241,100,1,0,1,1), -- 1 Emblem of Triumph
-- AURIAYA 25-man
(@Auriaya25,1,100,1,0,-@Auriaya25Ref,3), -- 3 items from reference loot
(@Auriaya25,2,10,1,0,-34154,1), -- Chance on Recipe
(@Auriaya25,45038,8,1,0,1,1), -- Fragment of Val'anyr
(@Auriaya25,45087,75,1,0,1,1), -- Runed Orb
(@Auriaya25,47241,100,1,0,1,2); -- 2 Emblems of Triumph
-- Add missing spawns to db
DELETE FROM `creature` WHERE `guid` IN (4764,28648,40266,40267,40470,40471,40510,40516,40517,40518,40601,40602,40603,41320);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`) VALUES 
(4764,33608,530,1,1,-2263.63,5559.49,67.0918,5.91667,180,0,9156), -- Alchemy
(28648,33609,530,1,1,-2262.64,5561.96,67.0948,5.89921,180,0,9156), -- Blacksmithing
(40266,33610,530,1,1,-2261.59,5564.54,67.095,5.93412,180,0,9156), -- Enchanting
(40267,33611,530,1,1,-2260.64,5567.08,67.092,5.93412,180,0,9156), -- Engineering
(40470,33612,530,1,1,-2264.54,5562.77,67.0939,2.79253,180,0,9156), -- Leatherworking
(40471,33613,530,1,1,-2265.57,5560.32,67.0911,2.80998,180,0,9156), -- Tailoring
(40510,33614,530,1,1,-2263.47,5565.35,67.0937,2.80998,180,0,9156), -- Jewelcrafting
(40516,33615,530,1,1,-2262.36,5567.8,67.0909,2.79253,180,0,9156), -- Inscription
(40517,33616,530,1,1,-2268.1,5563.18,67.0919,5.89921,180,0,9156), -- Herbalism
(40518,33617,530,1,1,-2266.98,5565.78,67.0927,5.89921,180,0,9156), -- Mining
(40601,33618,530,1,1,-2265.86,5568.36,67.0911,5.84685,180,0,9156), -- Skinning
(40602,33619,530,1,1,-2267.52,5569.19,67.0896,2.74017,180,0,9156), -- Cooking
(40603,33621,530,1,1,-2269.93,5564.2,67.09,2.75762,180,0,9156), -- First Aid
(41320,33623,530,1,1,-2268.81,5566.68,67.0905,2.74017,180,0,9156); -- Fishing
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_spinning_pain_spike';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(66316,'spell_spinning_pain_spike'),
(67100,'spell_spinning_pain_spike'),
(67101,'spell_spinning_pain_spike'),
(67102,'spell_spinning_pain_spike');
-- Re-add deleted data
DELETE FROM `creature` WHERE `guid` IN (4764,28648,40266,40267,40470,40471,40510,40516,40517,40518,40601,40602,40603,41320);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(4764,26796,576,2,1,0,0,424.547,185.962,-34.9367,4.72984,3600,0,0,1,0,0,0,0,0),
(28648,17148,530,1,1,0,0,-2910.22,6473.03,82.4898,2.49669,300,0,0,5914,0,0,0,0,0),
(40267,37671,1,1,1,0,0,1391.2,-4486.23,31.4544,3.3355,300,0,0,42,0,0,0,0,0),
(40470,37671,1,1,1,0,0,1392.66,-4481.87,31.3782,1.97284,300,0,0,42,0,0,0,0,0),
(40471,37671,1,1,1,0,0,1393.92,-4489.57,31.4737,4.93701,300,0,0,42,0,0,0,0,0);

-- Add missing spawns to db (trainers)
DELETE FROM `creature` WHERE `guid` IN (40266,40510,40516,40517,40518,40601,40602,40603,41320,41674,41723,41775,41779,41780);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`curhealth`) VALUES 
(40266,33608,530,1,1,-2263.63,5559.49,67.0918,5.91667,180,0,1), -- Alchemy
(40510,33609,530,1,1,-2262.64,5561.96,67.0948,5.89921,180,0,1), -- Blacksmithing
(40516,33610,530,1,1,-2261.59,5564.54,67.095,5.93412,180,0,1), -- Enchanting
(40517,33611,530,1,1,-2260.64,5567.08,67.092,5.93412,180,0,1), -- Engineering
(40518,33612,530,1,1,-2264.54,5562.77,67.0939,2.79253,180,0,1), -- Leatherworking
(40601,33613,530,1,1,-2265.57,5560.32,67.0911,2.80998,180,0,1), -- Tailoring
(40602,33614,530,1,1,-2263.47,5565.35,67.0937,2.80998,180,0,1), -- Jewelcrafting
(40603,33615,530,1,1,-2262.36,5567.8,67.0909,2.79253,180,0,1), -- Inscription
(41320,33616,530,1,1,-2268.1,5563.18,67.0919,5.89921,180,0,1), -- Herbalism
(41674,33617,530,1,1,-2266.98,5565.78,67.0927,5.89921,180,0,1), -- Mining
(41723,33618,530,1,1,-2265.86,5568.36,67.0911,5.84685,180,0,1), -- Skinning
(41775,33619,530,1,1,-2267.52,5569.19,67.0896,2.74017,180,0,1), -- Cooking
(41779,33621,530,1,1,-2269.93,5564.2,67.09,2.75762,180,0,1), -- First Aid
(41780,33623,530,1,1,-2268.81,5566.68,67.0905,2.74017,180,0,1); -- Fishing
-- Greater Blessing of Wisdom and Mana Spring Totem should not stack (hotfix)
SET @GROUP := 1117;
DELETE FROM `spell_group` WHERE id=@GROUP;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(@GROUP,25894), -- Greater Blessing of Wisdom
(@GROUP,5677); -- Mana Spring (cast by Mana Spring Totem)
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=@GROUP;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES 
(@GROUP,3); -- Make them SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT
-- Template updates
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33608; -- Alchemy
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16/*80*/,`trainer_type`=2 WHERE `entry`=33609; -- Blacksmithing
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33610; -- Enchanting
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33611; -- Engineering
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33612; -- Leatherworking
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16 WHERE `entry`=33613; -- Tailoring
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33614; -- Jewelcrafting
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33616; -- Herbalism
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33618; -- Skinning (guessed)
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33617; -- Mining (guessed)
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16 WHERE `entry`=33619; -- Cooking (guessed)
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16 WHERE `entry`=33621; -- First Aid (guessed)
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33615; -- Inscription (guessed)
UPDATE `creature_template` SET `faction_A`=1744,`faction_H`=1744,`npcflag`=`npcflag`|16,`trainer_type`=2 WHERE `entry`=33623; -- Fishing (guessed)

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=0.11,`combat_reach`=0,`gender`=2 WHERE `modelid`=28738; -- shared by many
UPDATE `creature_model_info` SET `bounding_radius`=0.14,`combat_reach`=0,`gender`=2 WHERE `modelid`=28758; -- shared by many

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (33608,33609,33610,33611,33612,33613,33614,33616,33618,33617,33619,33621,33615,33623);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(33608,0,0,1,0, NULL), -- Alchemy
(33609,0,0,1,0, NULL), -- Blacksmithing
(33610,0,0,1,0, NULL), -- Enchanting
(33611,0,0,1,0, NULL), -- Engineering
(33612,0,0,1,0, NULL), -- Leatherworking
(33613,0,0,1,0, NULL), -- Tailoring
(33614,0,0,1,0, NULL), -- Jewelcrafting
(33616,0,0,1,0, NULL), -- Herbalism
(33618,0,0,1,0, NULL), -- Skinning (guessed)
(33617,0,0,1,0, NULL), -- Mining (guessed)
(33619,0,0,1,0, NULL), -- Cooking (guessed)
(33621,0,0,1,0, NULL), -- First Aid (guessed)
(33615,0,0,1,0, NULL), -- Inscription (guessed)
(33623,0,0,1,0, NULL); -- Fishing (guessed)

-- Trainer spells
DELETE FROM `npc_trainer` WHERE `entry` IN (33608,33609,33610,33611,33612,33613,33614,33616,33618,33617,33619,33621,33615,33623);
INSERT INTO `npc_trainer` (`entry`, `spell`, `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES 
(33608, -201001, 0, 0, 0, 0), -- Alchemy
(33608, -201002, 0, 0, 0, 0), -- Alchemy
(33608, -201003, 0, 0, 0, 0), -- Alchemy
(33609, -201004, 0, 0, 0, 0), -- Blacksmithing
(33609, -201005, 0, 0, 0, 0), -- Blacksmithing
(33609, -201006, 0, 0, 0, 0), -- Blacksmithing
(33610, -201009, 0, 0, 0, 0), -- Enchanting
(33610, -201010, 0, 0, 0, 0), -- Enchanting
(33610, -201011, 0, 0, 0, 0), -- Enchanting
(33611, -201012, 0, 0, 0, 0), -- Engineering
(33611, -201013, 0, 0, 0, 0), -- Engineering
(33611, -201014, 0, 0, 0, 0), -- Engineering
(33612, -201027, 0, 0, 0, 0), -- Leatherworking
(33612, -201028, 0, 0, 0, 0), -- Leatherworking
(33612, -201029, 0, 0, 0, 0), -- Leatherworking
(33613, -201039, 0, 0, 0, 0), -- Tailoring
(33613, -201040, 0, 0, 0, 0), -- Tailoring
(33613, -201041, 0, 0, 0, 0), -- Tailoring
(33614, -201024, 0, 0, 0, 0), -- Jewelcrafting
(33614, -201025, 0, 0, 0, 0), -- Jewelcrafting
(33614, -201026, 0, 0, 0, 0), -- Jewelcrafting
(33616, -201018, 0, 0, 0, 0), -- Herbalism
(33616, -201019, 0, 0, 0, 0), -- Herbalism
(33616, -201020, 0, 0, 0, 0), -- Herbalism
(33618, -201036, 0, 0, 0, 0), -- Skinning
(33618, -201037, 0, 0, 0, 0), -- Skinning
(33618, -201038, 0, 0, 0, 0), -- Skinning
(33617, -201033, 0, 0, 0, 0), -- Mining
(33617, -201034, 0, 0, 0, 0), -- Mining
(33617, -201035, 0, 0, 0, 0), -- Mining
(33619, -202004, 0, 0, 0, 0), -- Cooking
(33619, -202005, 0, 0, 0, 0), -- Cooking
(33619, -202006, 0, 0, 0, 0), -- Cooking
(33621, -202007, 0, 0, 0, 0), -- First Aid
(33621, -202008, 0, 0, 0, 0), -- First Aid
(33621, -202009, 0, 0, 0, 0), -- First Aid
(33615, -201021, 0, 0, 0, 0), -- Inscription
(33615, -201022, 0, 0, 0, 0), -- Inscription
(33615, -201023, 0, 0, 0, 0), -- Inscription
(33623, -202001, 0, 0, 0, 0), -- Fishing
(33623, -202002, 0, 0, 0, 0), -- Fishing
(33623, -202003, 0, 0, 0, 0); -- Fishing
-- Quest: Blending In (11633)
-- Spell from Cape only Appliable in City Area
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=45614;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,45614,11633,23,4125,0,0,0, '', 'Shroud of the Scourge - Temple City of En''kilah');
-- CREATURE_FLAG_EXTRA_NO_XP_AT_KILL
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64 WHERE `entry`=21267; -- Mana Beast
-- Fix quest 11468 - Falcon versus hawk
SET @entry := 24747; -- Fjord Hawk
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@entry;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@entry AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@entry,0,0,1,8,0,100,0,44407,0,0,0,11,44408,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fjord Hawk - On Spellhit - Cast spell on invoker'),
(@entry,0,1,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Fjord Hawk - On Spellhit - Despawn');
UPDATE `conditions` SET `ElseGroup`=0 WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=45614; -- typo fix for previous commit
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=47431;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,47431,0,23,4195,0,0,64,'','Capture Jormungar Spawn can only be used in Ice Heart Cavern');
DELETE FROM `spell_script_names` WHERE `spell_id` = 36444;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(36444, 'spell_gen_wg_water');
-- Will of Sartharion should only target the drakes and Sartharion
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=61254;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13, 1, 61254, 0, 0, 31, 0, 3, 30449, 0, 0, 0, '', 'Will of Sartharion'),
(13, 1, 61254, 0, 1, 31, 0, 3, 30451, 0, 0, 0, '', 'Will of Sartharion'),
(13, 1, 61254, 0, 2, 31, 0, 3, 30452, 0, 0, 0, '', 'Will of Sartharion'),
(13, 1, 61254, 0, 3, 31, 0, 3, 28860, 0, 0, 0, '', 'Will of Sartharion');
UPDATE `spell_dbc` SET `EffectApplyAuraName1`=4 WHERE `Id`=56817;
DELETE FROM `gameobject_template` WHERE `entry`=202931;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `WDBVerified`) VALUES
(202931, 5, 9463, 'Serpent Offering', '', '', '', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.17, 0, 0, 0, 0, 0, 0, 12340); -- -Unknown-

UPDATE `gameobject_template` SET `questItem1`=30527, `questItem2`=30524, `questItem3`=30525, `questItem4`=30526 WHERE `entry`=184815; -- Sealed Coffin
-- UPDATE `gameobject_template` SET `data0`=2061, `WDBVerified`=12340 WHERE `entry`=151951; -- Idol Oven Fire
-- UPDATE `gameobject_template` SET `type`=5, `data3`=0, `data5`=0 WHERE `entry`=188187; -- Snow Pile
UPDATE `gameobject_template` SET `size`=0.45 WHERE `entry`=190169; -- Tiger Lily
UPDATE `gameobject_template` SET `unk1`='' WHERE `entry`=190549; -- The Zephyr
-- UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=191300; -- Fire
UPDATE `gameobject_template` SET `displayId`=7836 WHERE `entry`=196485; -- Saronite Rock
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126337; -- 126337
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126338; -- 126338
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126339; -- 126339
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126340; -- 126340
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126341; -- 126341
--  UPDATE `gameobject_template` SET `data0`=2061 WHERE `entry`=126345; -- 126345
UPDATE `gameobject_template` SET `data2`=23787, `data7`=3605, `data19`=0 WHERE `entry`=202443; -- Dedication of Honor
UPDATE `gameobject_template` SET `type`=10 WHERE `entry`=166872; -- Supply Crate
UPDATE `gameobject_template` SET `data6`=-1000 WHERE `entry`=178559; -- Larva Spewer

/*
GameObject (Entry: 126337 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 126338 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 126339 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 126340 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 126341 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 126345 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 151951 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
GameObject (Entry: 191300 GoType: 8) have data0=2061 but SpellFocus (Id: 2061) not exist.
Gameobject (Entry: 188192 GoType: 3) have data7=188187 but GO (Entry 188187) have not GAMEOBJECT_TYPE_TRAP (6) type.
*/
DELETE FROM `spell_script_names` WHERE `spell_id` in (7384,7887,11584,11585);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(7384,	'spell_warr_overpower'),
(7887,	'spell_warr_overpower'),
(11584,	'spell_warr_overpower'),
(11585,	'spell_warr_overpower');
UPDATE `spell_proc_event` SET `SpellFamilyMask0`=0x80000000, `SpellFamilyMask1`=0 WHERE `entry`=67363; -- Fixes Libram of Veracity proc

UPDATE `spell_proc_event` SET `SpellFamilyMask0`=0x10 WHERE `entry`=60132; -- Oblit/Scourge Strike Runic Power Up (T7 4s)
DELETE FROM `spell_dbc` WHERE `Id`=64748; -- Item - Death Knight T8 Tank 4P Bonus
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(64748,1,0,384,0,0,0,0,131080,0,0,0,0,0,1,0,0,101,0,0,80,80,28,1,0,-1,0,0,6,0,0,1,0,1,'0','0','0',-11,0,-11,0,0,0,1,0,0,0,0,0,0,0,0,87,0,0,0,0,0,'0','0','0',1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777829,0,0,0,15,0,0,0,0,0,0,'1','1','1',0,32,'Item - Death Knight T8 Tank 4P Bonus');
-- GO required by spell 70477 - Cleanse Quel'Delar
DELETE FROM `gameobject_template` WHERE `entry`=300246;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES
(300246, 8, 0, 'TEMP Sunwell', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 1641, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 1);
DELETE FROM `spell_dbc` WHERE `Id`=64934; -- Item - Warrior T8 Protection 4P Bonus
INSERT INTO `spell_dbc`(`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(64934,1,0,384,0,0,0,0,131080,0,0,0,0,0,1,0,0,101,0,0,80,80,28,1,0,-1,0,0,6,0,0,1,0,1,'0','0','0',-21,0,-11,0,0,0,1,0,0,0,0,0,0,0,0,87,0,0,0,0,0,'0','0','0',126,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16777829,0,0,0,4,0,0,0,0,0,0,'1','1','1',0,32, 'Item - Warrior T8 Protection 4P Bonus');
DELETE FROM `page_text` WHERE entry IN (2177,2295,2296,2297,2301,2302,2303,2308,2309,3036,3045,3046,3047,3049,3050,3051,3052,3053,3378,3544,3563,3564,3565);
INSERT INTO `page_text` (`entry`, `text`, `next_page`) VALUES
(2177, 'Valea Twinblades \nWarrior of the Scarlet Crusade\nCitizen of Alterac \nLast seen deep in the Eastern Plaguelands', 0),
(2295, 'Before the Age of Memory, the gentle Earthmother breathed upon the golden mists of dawn. Where the amber clouds came to rest, there were endless fields of flowing wheat and barley. This was the basin of her works - the great basket of life and hope.', 2296),
(2296, 'The Earthmother\'s eyes shone down upon the lands she had breathed into creation. Her right eye, An\'she (the sun), gave warmth and light to the land. Her left eye, Mu\'sha (the moon), gave peace and sleep to the stirring creatures of the dawning. Such was the power of her gaze that the Earthmother closed one dreaming eye for every turning of the sky. Thus, her loving gaze turned day into night for the first dawning of the world.   $B', 2297),
(2297, 'While the right eye shone down upon the golden dawn, the Earthmother\'s gentle hands spread out across the golden plains. Wherever the shadow of her arms passed, a noble people arose from the rich soil. The Shu\'halo (the tauren) arose to give thanks and prayer to their loving mother. There, in the endless fields of dawn, the children of the earth swore themselves to her grace and vowed to bless her name until the final darkening of the world.', 0),
(2301, 'Into the brave hearts of her pure children, the Earthmother placed the love of the hunt. For the creatures of the first dawn were savage and fierce. They hid from the Earthmother, finding solace in the shadows and the wild places of the land. The Shu\'halo hunted these beasts wherever they could be found and tamed them with the Earthmother\'s blessing. ', 2302),
(2302, 'One great spirit eluded them, however. Apa\'ro (known as Malorne to the night elves), was a proud stag of snow white fur. His antlers scraped the roof of the heavens and his mighty hooves stamped out the deep places of the world. The Shu\'halo hunted Apa\'ro to the corners of the dawning world - and closed in to snare the proud stag.', 2303),
(2303, 'Seeking to escape, the great stag leapt into the sky. Yet, as his escape seemed assured, his mighty antlers tangled in the stars which held him fast. Though he kicked and struggled, Apa\'ro could not loose himself from the heavens. It was then that Mu\'sha found him as she chased her brother, An\'she, towards the dawn. Mu\'sha saw the mighty stag as he struggled and fell in love with him immediately. ', 2304),
(2308, 'As the mists of dawn faded and the Age of Memory advanced, the demigod, Cenarius, went his own way through the fields of the world. The Shu\'halo (tauren) were sorrowful at his passing and forgot much of the druidism he had taught them. As the generations passed, they forgot how to speak with the trees and the wild things of the land. The dark whispers from the deeps of the world drifted up to their ears once again.', 2309),
(2309, 'Though the children of the earth closed out the evil whisperings, a terrible curse befell their roaming tribes. Out of the black lands of the west came a horde of murderous creatures - the centaur. Cannibals and ravagers, the centaur fell upon the Shu\'halo like a plague. Though the braves and hunters fought with the Earthmother\'s blessing in their hearts, the centaur could not be defeated.', 2310),
(3544, 'You have found the wreckage of a mysterious object. Beyond the flames, you are able to make out an insignia marked "M:1815212085". You wonder what world this object must be from...', 0),
(3378, 'INVINCIBLE$B$BBeloved steed of Prince Arthas Menethil$B$BLoyal and great of heart in life, may you find peace in death.$B$BPure streams and green pastures, devoted friend.', 0),
(3565, 'Gritting his teeth, Marcus gestured as light flashed over him, restoring his strength.$B$BTavi stared anxiously as he rose to his full height, engulfing her in his shadow.  He thrust his hand forward, sending a wave of righteous force through her.  Eyes rolled back as she wavered for several seconds before regaining consciousness.$B$B"I\'ve recently taken the path of... retribution."$B$BThe mischievous smirk returned to her face, "Well then, this is going to be fun."$B$B<The remaining pages have a level 99 requirement to read.>', 0),
(3564, 'Marcus took both her hands in one of his as he reassured her, "It\'s fine.  What is your specialization?"$B$BHer head snapped up, eyes burning with renewed life as shadowy energy channeled through her hands into Marcus, dropping him to his knees in agony.$B$B"Affliction, actually."$B', 3565),
(3563, '"Interested in some more company?" she purred as her hands weaved through a complex summoning ritual, stopping only when she felt the warmth of a new presence behind her.$B$BAll color drained from Marcus\'s face as he struggled to protest.  "I... I don\'t think that\'s appropriate."$B$BConfused, Tavi turned to see what was wrong.  A hideous fel hound stood ready, drooling onto the floor as it stared intently at the half-armored paladin.$B$B"No!  No that\'s not what I meant." she stammered as she dispelled the hungry demon.  "I\'m sorry, that\'s not really my specialization...."', 3564),
(3045, 'First Watch, Eight Bells$BWatches changed.  All is well.', 3046),
(3046, 'Middle Watch, One Bell$BCedric found attempting to break into Captain\'s wine cabinet.  Disciplined.', 3047),
(3047, 'Middle Watch, Two Bells$BCedric climbed rigging, became tangled and fell.  Attended by ship\'s surgeon.  Sent below to sober up.', 3049),
(3049, 'Middle Watch, Four Bells$BBottle of rum found in Cedric\'s pants.  Disciplined.', 3050),
(3050, 'Middle Watch, Five Bells$BCedric\'s clothes found.  Cedric found separately.  Cedric disciplined.', 3051),
(3051, 'Middle Watch, Six Bells$BCedric singing loudly.  Woke Captain.  Cedric disciplined by Captain.', 3052),
(3052, 'Middle Watch, Eight Bells$BWatches changed.  All quiet.  Two men sent to locate Cedric.$B', 3053),
(3053, 'Morning Watch, One Bell$BFire in Captain\'s quarters.  All hands roused.  Throwing powder overboard. ', 0),
(3036, 'The mighty creature\'s maw opened wide, tossing bolts of icy water toward our vessel. Those terrible jaws clamped down upon the bow of our ship, tearing it from the hull. Sailors and cargo were thrown violently into the sea as the remnants of the ship disappeared beneath the waves.$B$BThe last thing I remember was flying from the broken hull, hitting the inky waters, and plunging beneath the waves. The world went dark and I thought for certain I\'d drawn my last breath. When I awoke in Theramore\'s infirmary, I knew someone had to tell our story.', 0);
UPDATE `gameobject_template` SET `faction`=54 WHERE `entry`=178164;
SET @GUID := 247;
DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GUID,178164,409,1,1,736.6528,-1176.32,-118.0967,-0.6806787,0,0,0,1,120,255,1); -- Hot Coal, damage
UPDATE `game_event` SET `start_time` = '2012-04-08 00:01:00' WHERE `eventEntry` =9; -- Noblegarden
UPDATE `game_event` SET `start_time` = '2012-04-29 00:01:00' WHERE `eventEntry` =10; -- Children's Week
UPDATE `spell_proc_event` SET `procFlags`=0 WHERE `entry`=70805;
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sindragosa_ice_tomb_dummy';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69712,'spell_sindragosa_ice_tomb_dummy');
-- Gymer <King of Storm Giants>
UPDATE `creature_template` SET `unit_class`=4,`spell1`=55426,`spell2`=55429,`spell3`=55516,`spell4`=55421,`VehicleId`=205 WHERE `entry`=29884;
DELETE FROM `spell_dbc` WHERE `Id`=31934; -- Blessed Life
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(31934,0,0,384,0,0,0,0,0,0,0,131072,0,0,1,0,1048576,100,1,0,0,0,21,1,0,-1,0,0,6,0,0,1,0,0,'0','0','0',-51,0,0,0,0,0,1,0,0,0,0,0,0,0,0,87,0,0,0,0,0,'0','0','0',127,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'1','0','0',0,0,'Blessed Life');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sindragosa_mystic_buffet';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70127,'spell_sindragosa_mystic_buffet'),
(72528,'spell_sindragosa_mystic_buffet'),
(72529,'spell_sindragosa_mystic_buffet'),
(72530,'spell_sindragosa_mystic_buffet');
DELETE FROM `spell_script_names` WHERE `spell_id`=-1064;
INSERT INTO `spell_script_names` VALUES
(-1064, 'spell_sha_chain_heal');
-- Update proper modelid for Celestial Steed (31957 is wrong)
UPDATE `creature_template` SET `modelid1`=31958,`modelid2`=0 WHERE `entry`=40625;
UPDATE `creature_template` SET `WDBVerified`=12340 WHERE `entry`=40624; -- Verified

-- Remove temp entry 68686 and replace with wdb verified 38686
UPDATE `creature_template` SET `difficulty_entry_3`=38686 WHERE `entry`=36950;
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`exp`=2,`faction_A`=84,`faction_H`=84,`mindmg`=488,`maxdmg`=642,`attackpower`=782,`unit_flags`=32832,`dynamicflags`=8,`minrangedmg`=363,`maxrangedmg`=521,`rangedattackpower`=121 WHERE `entry`=38686;
DELETE FROM `creature_template` WHERE `entry`=68686;
-- Druid
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (779,1822,60089);
DELETE FROM `spell_bonus_data` WHERE `entry` IN (1079,9007,22568);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(1079,0,0,-1,-1, 'Druid - Rip'),
(9007,0,0,-1,-1, 'Druid - Pounce Bleed'),
(22568,0,0,-1,-1, 'Druid - Ferocious Bite');

-- Hunter
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (3044,3674,53352,13812,13797,1978,42243);
UPDATE `spell_bonus_data` SET `ap_dot_bonus`=0.1 WHERE `entry`=13812;
DELETE FROM `spell_bonus_data` WHERE `entry` IN (24131,53353);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(24131,0,0,-1,-1, 'Hunter - Wyvern Sting (triggered)'),
(53353,0,0,-1,-1, 'Hunter - Chimera Shot (Serpent)');
DELETE FROM `spell_ranks` WHERE `first_spell_id`=24131;
INSERT INTO `spell_ranks` VALUES
(24131,24131,1),
(24131,24134,2),
(24131,24135,3),
(24131,27069,4),
(24131,49009,5),
(24131,49010,6);

-- Rogue
UPDATE `spell_bonus_data` SET `direct_bonus`=0,`dot_bonus`=0 WHERE `entry` IN (2818,2819,11353,11354,25349,26968,27187,57969,57970);

-- Howling blast
UPDATE `spell_bonus_data` SET `ap_bonus`=0.2 WHERE `entry`=49184;
-- Fixes some spell power stacking exploits
DELETE FROM `spell_bonus_data` WHERE `entry` IN (44525,18798,16614,7712,13897);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(44525,0,0,-1,-1, 'Enchant Weapon - Icebreaker'),
(18798,0,0,-1,-1, 'Item - Freezing Band'),
(16614,0,0,-1,-1, 'Item - Storm Gauntlets'),
(7712,0,0,-1,-1, 'Item - Fiery Retributer | Blazefury Medallion'),
(13897,0,0,-1,-1, 'Enchant Weapon - Fiery Weapon');
-- Update modelid for Invincible (with not bugged animation)
UPDATE `creature_template` SET `modelid1`=31007,`modelid2`=0,`WDBVerified`=-12340 WHERE `entry`=38545;
DELETE FROM `trinity_string` WHERE `entry` IN(555,556);
DELETE FROM `command` WHERE `name`='hover';
UPDATE `smart_scripts` SET `target_type`=`action_param6` WHERE
(`entryorguid`=369200 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=369201 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=3692 AND `source_type`=0 AND `id`=2) OR
(`entryorguid`=3692 AND `source_type`=0 AND `id`=3) OR
(`entryorguid`=3584 AND `source_type`=0 AND `id`=3) OR
(`entryorguid`=3584 AND `source_type`=0 AND `id`=4) OR
(`entryorguid`=954600 AND `source_type`=9 AND `id`=2) OR
(`entryorguid`=954600 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=7207 AND `source_type`=0 AND `id`=1) OR
(`entryorguid`=7207 AND `source_type`=0 AND `id`=2) OR
(`entryorguid`=911700 AND `source_type`=9 AND `id`=3);

UPDATE `smart_scripts` SET `action_param6`=0 WHERE
(`entryorguid`=369200 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=369201 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=3692 AND `source_type`=0 AND `id`=2) OR
(`entryorguid`=3692 AND `source_type`=0 AND `id`=3) OR
(`entryorguid`=3584 AND `source_type`=0 AND `id`=3) OR
(`entryorguid`=3584 AND `source_type`=0 AND `id`=4) OR
(`entryorguid`=954600 AND `source_type`=9 AND `id`=2) OR
(`entryorguid`=954600 AND `source_type`=9 AND `id`=3) OR
(`entryorguid`=7207 AND `source_type`=0 AND `id`=1) OR
(`entryorguid`=7207 AND `source_type`=0 AND `id`=2) OR
(`entryorguid`=911700 AND `source_type`=9 AND `id`=3);
-- Gnomish Playback Device (item 52709) Targeting condition -- by norfik closes #2169
DELETE FROM `conditions` WHERE `SourceEntry`=74222 AND `ConditionValue2` IN (1268, 7955, 6119);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 74222, 1, 31, 3, 1268, 0, 63, '', 'Gnomish Playback Device on Ozzie Togglevolt'),
(17, 0, 74222, 2, 31, 3, 7955, 0, 63, '', 'Gnomish Playback Device on Milli Featherwhistle'),
(17, 0, 74222, 3, 31, 3, 6119, 0, 63, '', 'Gnomish Playback Device on Tog Rustsprocket');

-- fix revenge ap coeff -- by ric101 closes #3344
UPDATE `spell_bonus_data` SET `ap_bonus` = 0.310 WHERE `entry` = 6572; 

-- fix life seed sp coeff -- by warpten closes #4162
DELETE FROM `spell_bonus_data` WHERE `entry`=48503;
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(48503,0,0,0,0, 'Druid - Living Seed Heal');

-- fix glyph of shadowflame proc only allow on damage. by kandera closes #3530
UPDATE `spell_proc_event` SET `procEx` = procEx|262144 WHERE`entry` = 63310; -- Glyph of shadowflame fix

-- Disable deprecated quests /in 2.4/ from Midsummer Festival - The Festival of Fire {A/H} by trista closes #5982
DELETE FROM `disables` WHERE `sourceType` = 1 AND `entry` in (9367,9368);
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(1,9367,0,0,0,'Disable quest The Festival of Fire {A}/Deprecated after 2.4 Midsummer Festival revamp/'),
(1,9368,0,0,0,'Disable quest The Festival of Fire {H}/Deprecated after 2.4 Midsummer Festival revamp/');

-- fix gameobject spawn for just maces sign -- by mrsmite closes #5849
DELETE FROM `gameobject` WHERE `guid` = 10714;
UPDATE `gameobject` SET `guid` = 10714 WHERE `guid` = 61895 AND `id` = 2157;

-- update npc texts. by helias closes #6098
DELETE FROM `npc_text` WHERE `ID` IN (10719,10782,10783,10787,10788,2838,9072,9110,10310,13293,13641,14089,15077,15155,15240,15412,15866,15873,15877,8663,8244,8254,8255,8282,8291,8296,8298,11093,3464,4776,4713,12130,13002,9984,12977,12978,10918,10999,10986,10991);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`) VALUES 
(10719, '<The chime of A"dal"s voice echoes reassuringly through your mind.>$B$BWorry not, child.  Look in your pack and you will find it once more.', NULL, 0, 1, 0, 0, 0, 0, 0, 0),
(10782, 'Sayoc, da ugly orc here, teach you daggers. You want teaching in other places, you talk to Ileda in da Farstrider Square of Silvermoon or Archibald in the War Quarter of Undercity, hokay?', 'Sayoc, da ugly orc here, teach you daggers. You want teaching in other places, you talk to Ileda in da Farstrider Square of Silvermoon or Archibald in the War Quarter of Undercity, hokay?', 1, 1, 0, 0, 0, 0, 0, 0),
(10783, 'You want to punch things, yah? Talk to Sayoc right here. He teach you.', 'You want to punch things, yah? Talk to Sayoc right here. He teach you.', 1, 1, 0, 0, 0, 0, 0, 0),
(10787, 'Ileda of da blood elves, in Farstrider Square of Silvermoon, train her students in both one and two-handed swords. Archibald, da Undercity"s weapon master, also train you, mon. He in da War Quarter.', 'Ileda of da blood elves, in Farstrider Square of Silvermoon, train her students in both one and two-handed swords. Archibald, da Undercity"s weapon master, also train you, mon. He in da War Quarter.', 1, 1, 0, 0, 0, 0, 0, 0),
(10788, 'Hanashi here knows staves. If you want a sturdier instructor, go to Thunder Bluff. Ansekhwa will teach you on the lower central rise there.', '', 1, 1, 0, 0, 0, 0, 0, 0),
(2838, '', 'Sure thing, $N. Here"s another for you.', 0, 1, 0, 0, 0, 0, 0, 0),
(9072, 'A search of the corpse"s clothing and equipment reveals the insignia you need, undamaged by the battle and foul environment.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(9110, 'Say, you happen to see that arch in the lake to the west?  I wonder where that goes?  I should go divin" over there.', '', 0, 1, 0, 1, 0, 0, 0, 0),
(10310, 'You must be exalted with the blood elves before I will teach you a riding skill, $c.', '', 1, 1, 0, 1, 0, 0, 0, 0),
(13293, 'Please hurry, $N. I am in a great deal of pain and time is running out.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(13641, '<Brann looks at you expectantly.>', '', 0, 1, 0, 0, 0, 0, 0, 0),
(14089, 'I"ve got a lead on Norgannon"s keystone, which guards access to Ulduar"s archives, but the Titans divided it into two pieces and secreted them away.$B$BOne of the pieces, the keystone"s shell, is held within the Inventor"s Library on the northern coast, south of Ulduar itself. The first thing you"ll need to do is retrieve the fragments of an access disk from the library"s guardians.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(15077, 'There you are! I was beginning to think that the Sunreavers had intercepted you. Are you ready to deliver the tome to our representatives in Icecrown?', '', 0, 1, 0, 0, 0, 0, 0, 0),
(15155, 'These appear to be the remains of Thalorien Dawnseeker, the last wielder of Quel"Delar.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(15240, 'I will escort you into the Sunwell when you"re ready.', 'I will escort you into the Sunwell when you"re ready.', 0, 1, 0, 0, 0, 0, 0, 0),
(15412, 'We got the final barrier blockin" entry to Frostwing Halls down, $g lad:lass;. Only Sindragosa stands between the Lich King and divine retribution! What are ye waitin" for?!', '', 0, 1, 0, 5, 0, 0, 0, 0),
(15866, 'De Darkspears have a home again! An" we couldn"t have done it wit"out ya helpin", $N. Now, we celebrate!', '', 0, 1, 0, 1, 0, 1, 0, 0),
(15873, 'Vol"jin told me ta keep hittin" da drum till he gets back.  If ya be waitin" for him, he"d be back soon to take back da Isles.$B$BJust wait here and enjoy da music!', '', 0, 1, 0, 0, 0, 0, 0, 0),
(15877, 'We require da help of allies on da islands.$B$BZen"tabra has been watching over da animals of de Islands for some time now.  We"d need her help and da help of da animal creatures.$B$BBwonsamdi is a powerful loa dat controls de spirits of de dead on da islands.  His blessing is crucial for our attack.$B$BOnce our allies have joined us, Zalazane and his army of mind-controlled trolls will have no chance!  Then, da Echo Isles will be de Darkspears!', '', 0, 1, 0, 0, 0, 0, 0, 0),
(8663, 'Thank you for delivering that list!  My leg is almost recovered enough that I"ll be able to walk back to the crash site.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(8244, 'We"ve been so wrapped up in this war, some of us forgot to make time for love.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(8254, 'You work with machines for so long, sometimes you forget about real hearts.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(8255, '', 'When you have lived as long as I, it becomes easy to forget about love for years. It is always good to be reminded.', 0, 1, 0, 0, 0, 0, 0, 0),
(8282, '', 'You look like you"ve had your heart broken. Come back when you"re not so sad.', 0, 1, 0, 25, 0, 153, 0, 0),
(8291, 'What, you don"t have a token to give me? Don"t you love me?', '', 0, 1, 0, 18, 0, 0, 0, 0),
(8296, 'It looks like you"ve already found love. You can give me a love token, but I"m not giving you anything nice. I"m waiting for someone special.', 'It looks like you"ve already found love. You can give me a love token, but I"m not giving you anything nice. I"m waiting for someone special.', 0, 1, 0, 1, 0, 0, 0, 0),
(8298, 'I"d like you better if you would apply some perfume.', 'I"d like you better if you would apply some perfume.', 0, 1, 0, 24, 0, 0, 0, 0),
(11093, 'Let"s get out of here!', '', 0, 1, 0, 5, 0, 0, 0, 0),
(3464, '', 'You do fine work, but it"s a bit rough around the edges. Don"t worry about it, it will come with practice. Speaking of which, how about we see what you"ve been working on?', 7, 1, 0, 0, 0, 0, 0, 0),
(4776, 'The battle is over, and the people of Darrowshire are saved.', '', 0, 1, 0, 0, 0, 0, 0, 0),
(4713, 'The Nightmare is finally over!  Darrowshire, forgive me!', '', 0, 1, 0, 15, 0, 0, 0, 0),
(12130, '<Old Icefin eyes you warily, his fishy eye blinking as he bobs his head up and down once in a curt dismissal.>', '', 0, 1, 0, 0, 0, 0, 0, 0),
(13002, 'There ya go, mon. Try ta be more careful with this one, won"t ya?$b$bNow head down ta Drak"Zin Ruins and drink it near the pedestal!', NULL, 0, 1, 0, 0, 0, 0, 0, 0),
(9984, 'What are ye doin" here?! Get yer chatty self ta Alterac Vallery, where ye"re needed!', '', 7, 1, 1, 5, 0, 0, 0, 0),
(12977, 'Blight, Blight, Blight... that"s all I hear about around here. I miss the diversity!$b$bHere, here. You have pets, yes? Of course you do. Of course. Little pets. I have a mixture for them. It will make them ca-- ah, clever and strong creatures, yes. Yes. ', '', 1, 1, 396, 5, 0, 0, 0, 0),
(12978, 'Careful with it. It"s unstable and loses its potency quickly. Use it soon! And... preferably within eyesight, yes...', '', 1, 1, 5, 0, 0, 0, 0, 0),
(10918, 'The boy"s too stupid still to say it -- not enough crystal exposure yet -- but, he"s thankful for what you did in getting him those flasks.$B$BNow, only nine more sons to go.  Gah!$B$B<Both of Torkus"s heads sigh.>$B$BWant to take one of them off of our hands?  We"ll sell him to you cheap.', '', 0, 1, 0, 1, 0, 5, 0, 6),
(10999, 'Friend! It"s been too long.  What can we get for you?', '', 0, 1, 1, 1, 0, 0, 0, 0),
(10986, 'Our drinks should quench even the mightiest of thirsts.', '', 0, 1, 1, 396, 0, 0, 0, 0),
(10991, 'What can I say, $N?  Yer the finest o" the Sha"tari Skyguard!$B$BJust don"t be lettin" that go ta yer head.  I can still teach ya a thing or two, $G lad : lass;!$B$B<Sky Commander Keller grins at you and winks.>', '', 0, 0, 0, 0, 0, 0, 0, 0);

-- Fix Kor'kron War Rider flying by trista closes #5569
UPDATE `creature_template` SET `inhabittype`=5,`speed_walk`=1, `speed_run`=1 WHERE `entry`=26813;

-- Gretta the Arbiter (Storm Peaks, Brunhilldar) by mweinelt closes #5493
-- Daily Quest Pooling
-- Source: http://www.wowwiki.com/Gretta_the_Arbiter
SET @pool_id := 354;

DELETE FROM `pool_template` WHERE `entry` = @pool_id;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool_id, 1, 'Gretta the Arbiter - Daily Quests');

DELETE FROM `pool_quest` WHERE `entry` IN (13424, 13423, 13422, 13425);
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(13424, @pool_id, 'Back to the Pit'),
(13423, @pool_id, 'Defending Your Title'),
(13422, @pool_id, 'Maintaining Discipline'),
(13425, @pool_id, 'The Aberrations Must Die');

-- Pathing for Arzeth the Merciless Entry: 19354 by kiperr closes #5510
SET @NPC := 69051;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-617.6182,`position_y`=4800.323,`position_z`=38.53064 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-546.5514,4799.893,33.83914,0,0,0,100,0),
(@PATH,2,-512.5808,4799.929,32.09928,0,0,0,100,0),
(@PATH,3,-480.9247,4799.97,28.25657,0,0,0,100,0),
(@PATH,4,-512.6269,4799.873,32.09928,0,0,0,100,0),
(@PATH,5,-542.1885,4799.724,33.71414,0,0,0,100,0),
(@PATH,6,-570.3811,4800.449,34.60215,0,0,0,100,0),
(@PATH,7,-592.3809,4800.299,35.85215,0,0,0,100,0),
(@PATH,8,-617.6182,4800.323,38.53064,0,0,0,100,0),
(@PATH,9,-659.4124,4799.819,49.09505,0,0,0,100,0),
(@PATH,10,-582.4199,4800.242,34.97715,0,0,0,100,0),
(@PATH,11,-546.5514,4799.893,33.83914,0,0,0,100,0),
(@PATH,12,-542.1885,4799.724,33.71414,0,0,0,100,0),
(@PATH,13,-570.3811,4800.449,34.60215,0,0,0,100,0),
(@PATH,14,-592.3809,4800.299,35.85215,0,0,0,100,0),
(@PATH,15,-617.6182,4800.323,38.53064,0,0,0,100,0),
(@PATH,16,-659.4124,4799.819,49.09505,0,0,0,100,0),
(@PATH,17,-512.5808,4799.929,32.09928,0,0,0,100,0),
(@PATH,18,-480.9247,4799.97,28.25657,0,0,0,100,0),
(@PATH,19,-512.6269,4799.873,32.09928,0,0,0,100,0),
(@PATH,20,-542.1885,4799.724,33.71414,0,0,0,100,0),
(@PATH,21,-570.3811,4800.449,34.60215,0,0,0,100,0),
(@PATH,22,-592.3809,4800.299,35.85215,0,0,0,100,0),
(@PATH,23,-617.6182,4800.323,38.53064,0,0,0,100,0),
(@PATH,24,-659.4124,4799.819,49.09505,0,0,0,100,0),
(@PATH,25,-582.4199,4800.242,34.97715,0,0,0,100,0),
(@PATH,26,-512.6269,4799.873,32.09928,0,0,0,100,0),
(@PATH,27,-542.1885,4799.724,33.71414,0,0,0,100,0),
(@PATH,28,-570.3811,4800.449,34.60215,0,0,0,100,0),
(@PATH,29,-592.3809,4800.299,35.85215,0,0,0,100,0),
(@PATH,30,-617.6182,4800.323,38.53064,0,0,0,100,0);

-- Dark Portal - corrects the entry position and orientation by cdawg closes #5470
UPDATE `areatrigger_teleport` SET `target_position_x`=-248.149292, `target_position_y`=921.874953, `target_position_z`=84.388448, `target_orientation`=1.584155 WHERE `id`=4354;

-- Add pamphlets to mail loot by gecko32 closes #5408
DELETE FROM `mail_loot_template` WHERE `entry` BETWEEN 224 AND 233;
INSERT INTO `mail_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES 
(224, 46875, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Elwynn Forest
(225, 46876, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Darnassus
(226, 46877, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Dun Morogh drawf
(227, 46879, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Azuremyst Isle
(228, 46878, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Dun Morogh gnome
(229, 46884, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Mulgore
(230, 46883, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Durator
(231, 46880, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Orgrimmar
(232, 46882, 100, 1, 0, 1, 1), -- Riding Training Pamphlet Eversong Woods
(233, 46881, 100, 1, 0, 1, 1); -- Riding Training Pamphlet Tirisfal Glades

-- fix coordinates for cannoneer whessan by mosoo closes #5406
UPDATE `creature` SET `position_x`=-2093.53, `position_y`=-3496.47, `position_z`=130.084, `orientation`=3.008 WHERE `id`=3455 LIMIT 1;

-- fix quest requirement for the last of her kind by shlomi 1515 closes #4875
UPDATE `quest_template` SET `PrevQuestID` = 12900 WHERE `id` = 12983;

-- Add rep reward to ICC25 Trash by gecko32 closes #5457
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (37655,38031,38057,38058,38059,38061,38062,38063,38064,38072,38073,38074,38075,38076,38098,38099,38100,38101,38102,38103,38105,38108,38110,38126,38130,38131,38132,38133,38139,38151,38219,38220,38418,38445,38446,38479,38480,38481);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(37655, 1156, 0, 7, 0, 45, 0, 0, 0, 0), -- Decaying colossus
(38031, 1156, 0, 7, 0, 45, 0, 0, 0, 0), -- Deathbound Ward
(38057, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Servant of the throne
(38058, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Nerub'ar Broodkeeper
(38059, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ancient Skeletal Soldier
(38061, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- The Damned
(38062, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Plague Scientist
(38063, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Vengeful Fleshreaper
(38064, 1156, 0, 7, 0, 150, 0, 0, 0, 0), -- Stinky
(38072, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Deathspeacker Attedent
(38073, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Deathspeacker Disciple
(38074, 1156, 0, 7, 0, 45, 0, 0, 0, 0), -- Deathspeacker High Preist
(38075, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Deathspeacker Servant
(38076, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Deathspeacker Zealot
(38098, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Advisor
(38099, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Archmage
(38100, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Blood Knight
(38101, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Lieutenant
(38102, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Commander
(38103, 1156, 0, 7, 0, 150, 0, 0, 0, 0), -- Precious
(38105, 1156, 0, 7, 0, 2, 0, 0, 0, 0), -- Plagued Zombie
(38108, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Blighted Abomination
(38110, 1156, 0, 7, 0, 30, 0, 0, 0, 0), -- Pustulating Horror
(38126, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ymirjar Frostbinder
(38130, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ymirjar Deathbringer
(38131, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ymirjar Huntress
(38132, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ymirjar Battle-Maiden
(38133, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Ymirjar Warlord
(38139, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Frostwarden Handler
(38151, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Frostwing Whelp
(38219, 1156, 0, 7, 0, 150, 0, 0, 0, 0), -- Spinestalker
(38220, 1156, 0, 7, 0, 150, 0, 0, 0, 0), -- Rimefang
(38418, 1156, 0, 7, 0, 45, 0, 0, 0, 0), -- Val'kyr Herald
(38445, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Spire Minion
(38446, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Frenzied Abomination
(38479, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Tactician
(38480, 1156, 0, 7, 0, 15, 0, 0, 0, 0), -- Darkfallen Noble
(38481, 1156, 0, 7, 0, 15, 0, 0, 0, 0); -- Spire Gargoyle

-- fix procs by warpten closes #4467 for 
-- Needle-Encrusted Scorpion
DELETE FROM `spell_proc_event` WHERE `entry`=71404;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(71404,0,0,0,0,0,0,2,0,0,50);

-- Black Magic
DELETE FROM `spell_proc_event` WHERE `entry`=59630;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(59630,0,0,0,0,0,0,0,0,0,35);

-- Environment Creature Hight Update by shlomi1515 closes #4043
UPDATE `creature` SET `position_z`=558.210022 WHERE `guid` IN (85141,85143,85154,85153,85142,85151,85152,85150);
UPDATE `creature` SET `position_z`=586.302 WHERE `guid` IN (85145,85144,85146);
UPDATE `creature` SET `position_z`=586.263 WHERE `guid` IN (85147,85148,85149);

-- fix winterskorn raider not landing by nayd closes #3899
UPDATE `creature_template` SET `InhabitType`=`InhabitType`|1 WHERE `entry`=23665;

-- fix head of onyxia's loot closes by kandera #3851
UPDATE `item_template` SET `flags` = flags|4096 WHERE `entry` IN (18422,18423,49644,49643);

-- fix visual for plagued dragonsflayer tribesman by shlomi1515 closes #3518
DELETE FROM `creature_addon` WHERE `guid` = 97540;
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (38308,38309,37824); -- Professor Putricide triggers
UPDATE `creature_template` SET `ScriptName`='npc_gas_cloud' WHERE `entry`=37562; -- Gas Cloud
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_ooze_summon';
DELETE FROM `spell_target_position` WHERE `id` IN (71413,71414);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(71414,631,4335.00,3206.75,389.399,0),
(71413,631,4380.43,3206.55,389.398,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (71615,71618,71412,71415);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,4,71615,31,3,37690,'Putricide - Tear Gas on Slime Puddle'),
(13,1,71618,31,3,37562,'Putricide - Tear Gas on Gas Cloud'),
(13,2,71618,31,3,37697,'Putricide - Tear Gas on Volatile Ooze'),
(13,4,71618,31,3,38159,'Putricide - Tear Gas on Choking Gas Bomb');

UPDATE `spell_script_names` SET `ScriptName`='spell_putricide_clear_aura_effect_value' WHERE `ScriptName`='spell_putricide_clear_mutated_plague';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(71620,'spell_putricide_clear_aura_effect_value');
ALTER TABLE `battleground_template` ADD `StartMaxDist` float NOT NULL DEFAULT 0 AFTER `HordeStartO`;

UPDATE `battleground_template` SET `StartMaxDist`=200 WHERE `id`=30; -- IC
UPDATE `battleground_template` SET `StartMaxDist`=100 WHERE `id`=1; -- AV
UPDATE `battleground_template` SET `StartMaxDist`=75 WHERE `id` IN (2,3,7); -- WSG, AB, EotS

UPDATE `battleground_template` SET `MinLvl`=1 WHERE `id`=32;
-- Blackened Naaru Silver proc cooldown
DELETE FROM `spell_proc_event` WHERE `entry`=45355;
INSERT INTO `spell_proc_event`(`entry`,`schoolmask`,`spellfamilyname`,`spellfamilymask0`,`spellfamilymask1`,`spellfamilymask2`,`procflags`,`procex`,`ppmrate`,`customchance`,`cooldown`) VALUES
(45355,0,0,0,0,0,0,0,0,0,45);-- Add Bogblossom to this Bogblossom object for the druid quest (other one already contains it)
DELETE FROM `gameobject_loot_template` WHERE (`entry`=10961) AND (`item`=31950);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES (10961,31950,-100,0,0,1,1);
-- Add missing gameobject_loot_templates to prevent startup errors
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (3458,3459,3460,3461,15920,16841,26878,27725);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(3458,4594,100,0,0,1,1), -- Rockscale Cod on Feast Fish
(3459,3771,100,0,0,1,1), -- Wild Hog Shank On Feast Boar
(3460,4538,100,0,0,1,1), -- Snapvine Watermelon on Feast Fruit
(3461,1708,100,0,0,1,1), -- Sweet Nectar on Feast Goblet
(15920,17822,-100,0,0,1,1), -- Weird Map on weird object
(16841,18950,-100,0,0,1,1), -- Chambermaid Pillaclenchers Pillow on Pillaclencher's Ornate Pillow
(26878,45062,100,0,0,1,1), -- Dusty Journal on Dusty Journal (different ID)
(27725,49648,100,0,0,1,1); -- Borrowed Tabard on Clean Laundry (might need condition!)
UPDATE `creature_template_addon` SET `auras`='50453' WHERE `entry`=28017;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=28017;
UPDATE `creature_template` SET `ainame` = '' WHERE `entry`=28017;UPDATE `spell_bonus_data` SET `direct_bonus`=0.8930 WHERE `entry`=51505;
DELETE FROM `spell_proc_event` WHERE `entry`=53601;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(53601, 0, 0, 0x00000000, 0x00000000, 0x00000000, 0, 0, 0, 0, 6);
DELETE FROM `spell_proc_event` WHERE `entry` IN (51486,51485,51483);
SET @Event = 26; -- Pilgrim's Bounty
DELETE FROM `game_event` WHERE `eventEntry`=@Event;
INSERT INTO `game_event` (`eventEntry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`description`,`world_event`) VALUES
(@Event,'2012-11-18 01:00:00','2020-12-31 05:00:00',525600,10020,404,'Pilgrim\'s Bounty',0);
SET @GUID1 := 41781;
SET @GUID2 := 41783;

DELETE FROM creature WHERE guid IN (@GUID1,@GUID2);
INSERT INTO `creature`
(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`)
VALUES
(@GUID1  ,38453,571,1,1,3561.821,-2736.367,136.0317,0), -- Arcturis in Grizzly Hills
(@GUID2,35189,571,1,1,7101.845,-1443.734,924.2609,0.178631); -- Skoll in The Storm Peaks

UPDATE `creature_template` SET `faction_A` = 190, `faction_H`=190 WHERE `entry` IN (38453,35189);

SET @NPC= @GUID1*10;
-- Add pathing for Arcturis
DELETE FROM `creature_addon` WHERE `guid` = @GUID1;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID1,@NPC,0,0,0,0,''); -- Add path for Acturis
-- Add waypoint data for the path:
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`) VALUES
(@NPC,1,3563.499,-2737.698,137.1898),
(@NPC,2,3565.249,-2738.698,138.4398),
(@NPC,3,3566.749,-2739.948,139.9398),
(@NPC,4,3568.249,-2740.698,140.6898),
(@NPC,5,3567.839,-2741.380,141.9256),
(@NPC,6,3569.999,-2741.948,142.1898),
(@NPC,7,3570.749,-2742.448,143.1898),
(@NPC,8,3572.676,-2743.528,144.8479);
UPDATE `npc_spellclick_spells` SET `spell_id`=57053 WHERE `npc_entry`=30066 AND `spell_id`=56678;
UPDATE `creature_template` SET `spell1`=55812 WHERE `entry`=30066;
UPDATE `creature` SET `spawntimesecs`=39600 WHERE `guid` IN (41781,41783); -- Set the spawntime to 11 hours for Arcturis & Skoll
-- ----------------------
-- -- Various Cleanups --
-- ----------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=34105; 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceGroup` IN (27081,27085,27073,26963,26955);
DELETE FROM `reference_loot_template` WHERE `entry` IN (12020,12021,12022,34105,34125,34126,34127,34128,34129,34130);
DELETE FROM `gameobject_loot_template` WHERE `entry`=10961; -- Bad Bogblossom fix was bad
UPDATE `gameobject_template` SET `data1`=26956 WHERE `entry`=194315;
-- -------------------------------
-- -- Variables and definitions -- 
-- -------------------------------
-- Freya 10 man
SET @Freya10k0ID := 194324; -- Freyas Gift 10man ALL elders alive
SET @Freya10k1ID := 194326; -- Freyas Gift 10man killed 1 elder
SET @Freya10k2ID := 194328; -- Freyas Gift 10man killed 2 elder
SET @Freya10k3ID := 194330; -- Freyas Gift 10man killed 3 elder
-- Freya 25 man
SET @Freya25k0ID := 194325; -- Freyas Gift 25man ALL elders alive
SET @Freya25k1ID := 194327; -- Freyas Gift 25man killed 1 elder
SET @Freya25k2ID := 194329; -- Freyas Gift 25man killed 2 elder
SET @Freya25k3ID := 194331; -- Freyas Gift 25man killed 3 elder
-- Hodir
SET @Hodir10nID := 194307; -- Cache of Winter 10man
SET @Hodir10hID := 194200; -- Rare Cache of Winter 10man
SET @Hodir25nID := 194308; -- Cache of Winter 25man
SET @Hodir25hID := 194201; -- Rare Cache of Winter 25man
-- Mimiron
SET @Mimiron10nID := 194789; -- Cache of Innovations 10man
SET @Mimiron25nID := 194956; -- Cache of Innovations 25man
SET @Mimiron10hID := 194957; -- Cache of Innovation 10 man Hardmode
SET @Mimiron25hID := 194958; -- Cache of Innovation 25 man Hardmode
-- Thorim
SET @Thorim10nID := 194312; -- Cache of Storms 10man
SET @Thorim10hID := 194313; -- Cache of Storms 10 man Hardmode
SET @Thorim25nID := 194314; -- Cache of Storms 25man
SET @Thorim25hID := 194315; -- Cache of Storms 25 man Hardmode

-- Use procedure to get Lootid from data1 field and assign it to a variable
-- Freya 10
CALL `sp_get_go_lootid`(@Freya10k0ID,@Freya10k0);
CALL `sp_get_go_lootid`(@Freya10k1ID,@Freya10k1);
CALL `sp_get_go_lootid`(@Freya10k2ID,@Freya10k2);
CALL `sp_get_go_lootid`(@Freya10k3ID,@Freya10k3);
-- Freya 25
CALL `sp_get_go_lootid`(@Freya25k0ID,@Freya25k0);
CALL `sp_get_go_lootid`(@Freya25k1ID,@Freya25k1);
CALL `sp_get_go_lootid`(@Freya25k2ID,@Freya25k2);
CALL `sp_get_go_lootid`(@Freya25k3ID,@Freya25k3);
-- Hodir 10
CALL `sp_get_go_lootid`(@Hodir10nID,@Hodir10n);
CALL `sp_get_go_lootid`(@Hodir10hID,@Hodir10h);
-- Hodir 25
CALL `sp_get_go_lootid`(@Hodir25nID,@Hodir25n);
CALL `sp_get_go_lootid`(@Hodir25hID,@Hodir25h);
-- Mimiron
CALL `sp_get_go_lootid`(@Mimiron10nID,@Mimiron10n);
CALL `sp_get_go_lootid`(@Mimiron10hID,@Mimiron10h);
CALL `sp_get_go_lootid`(@Mimiron25nID,@Mimiron25n);
CALL `sp_get_go_lootid`(@Mimiron25hID,@Mimiron25h);
-- Thorim
CALL `sp_get_go_lootid`(@Thorim10nID,@Thorim10n);
CALL `sp_get_go_lootid`(@Thorim10hID,@Thorim10h);
CALL `sp_get_go_lootid`(@Thorim25nID,@Thorim25n);
CALL `sp_get_go_lootid`(@Thorim25hID,@Thorim25h);
-- Set References
SET @Freya10Ref := 34365; 
SET @Freya25Ref := @Freya10Ref+1;
SET @Hodir10Ref := @Freya10Ref+2; 
SET @Hodir25Ref := @Freya10Ref+3;
SET @Mimiron10Ref := @Freya10Ref+4;
SET @Mimiron25Ref := @Freya10Ref+5;
SET @Thorim10Ref := @Freya10Ref+6;
SET @Thorim25Ref := @Freya10Ref+7;
SET @HandToken := 12026; 
SET @LegToken := @HandToken+1;
SET @LegsToken := @HandToken+2;
SET @ChestToken := @HandToken+3;
SET @HeadToken := @HandToken+4;
SET @GloveToken := @HandToken+5;
SET @ShoulderToken := @HandToken+6;
SET @HelmToken := @HandToken+7;
SET @Recipe := 34154;
-- -------------------------
-- -- Reference Templates --
-- -------------------------
-- Delete previous templates if existing
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @Freya10Ref AND @Freya10Ref+7;
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @HandToken AND @HandToken+7;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Freya 10 man
(@Freya10Ref,45934,0,1,1,1,1), -- Unraveling Reach	
(@Freya10Ref,45935,0,1,1,1,1), -- Ironbark Faceguard
(@Freya10Ref,45941,0,1,1,1,1), -- Chestguard of the Lasher
(@Freya10Ref,45936,0,1,1,1,1), -- Legplates of Flourishing Resolve
(@Freya10Ref,45940,0,1,1,1,1), -- Tunic of the Limber Stalker
-- Freya 25 man
(@Freya25Ref,45483,0,1,1,1,1), -- Boots of the Servant
(@Freya25Ref,45482,0,1,1,1,1), -- Leggings of the Lifetender
(@Freya25Ref,45481,0,1,1,1,1), -- Gauntlets of Ruthless Reprisal
(@Freya25Ref,45480,0,1,1,1,1), -- Nymph Heart Charm
(@Freya25Ref,45479,0,1,1,1,1), -- The Lifebinder
-- Freya Tokens
(@HandToken,45644,0,1,1,1,1), -- Gloves of the Wayward Conqueror
(@HandToken,45645,0,1,1,1,1), -- Gloves of the Wayward Protector
(@HandToken,45646,0,1,1,1,1), -- Gloves of the Wayward Vanquisher
(@LegToken,45653,0,1,1,1,1), -- Legplates of the Wayward Conqueror
(@LegToken,45654,0,1,1,1,1), -- Legplates of the Wayward Protector
(@LegToken,45655,0,1,1,1,1), -- Legplates of the Wayward Vanquisher
-- Hodir 10 man
(@Hodir10Ref,45874,0,1,1,1,1), -- Signet of Winter
(@Hodir10Ref,45458,0,1,1,1,1), -- Stormedge
(@Hodir10Ref,45873,0,1,1,1,1), -- Winter's Frigid Embrace
(@Hodir10Ref,45872,0,1,1,1,1), -- Avalanche
(@Hodir10Ref,45454,0,1,1,1,1), -- Cowl of Icy Breaths
-- Hodir 25 man
(@Hodir25Ref,45452,0,1,1,1,1), -- Frostplate Greaves
(@Hodir25Ref,45454,0,1,1,1,1), -- Frost-Bound Chain Bracers
(@Hodir25Ref,45453,0,1,1,1,1), -- Winter's Icy Embrace
(@Hodir25Ref,45450,0,1,1,1,1), -- Northern Barrier
(@Hodir25Ref,45451,0,1,1,1,1), -- Frozen Loop
-- Hodir Tokens
(@LegsToken,45650,0,1,1,1,1), -- Leggings of the Wayward Conqueror
(@LegsToken,45651,0,1,1,1,1), -- Leggings of the Wayward Protector
(@LegsToken,45652,0,1,1,1,1), -- Leggings of the Wayward Vanquisher
(@ChestToken,45632,0,1,1,1,1), -- Breastplate of the Wayward Conqueror
(@ChestToken,45633,0,1,1,1,1), -- Breastplate of the Wayward Protector
(@ChestToken,45634,0,1,1,1,1), -- Breastplate of the Wayward Vanquisher
-- Mimiron 10 man
(@Mimiron10Ref,45974,0,1,1,1,1), -- Shoulderguards of Assimilation
(@Mimiron10Ref,45976,0,1,1,1,1), -- Static Charge Handwraps
(@Mimiron10Ref,45972,0,1,1,1,1), -- Pulse Baton
(@Mimiron10Ref,45973,0,1,1,1,1), -- Stylish Power Cape
(@Mimiron10Ref,45975,0,1,1,1,1), -- Cable of the Metrognome
-- Mimiron 25 man
(@Mimiron25Ref,45492,0,1,1,1,1), -- Malleable Steelweave Mantle
(@Mimiron25Ref,45493,0,1,1,1,1), -- Asimov's Drape
(@Mimiron25Ref,45490,0,1,1,1,1), -- Pandora's Plea
(@Mimiron25Ref,45491,0,1,1,1,1), -- Waistguard of the Creator
(@Mimiron25Ref,45489,0,1,1,1,1), -- Insanity's Grip
-- Mimiron Tokens
(@HeadToken,45647,0,1,1,1,1), -- Helm of the Wayward Conqueror
(@HeadToken,45648,0,1,1,1,1), -- Helm of the Wayward Protector
(@HeadToken,45649,0,1,1,1,1), -- Helm of the Wayward Vanquisher
(@GloveToken,45641,0,1,1,1,1), -- Gauntlets of the Wayward Conqueror
(@GloveToken,45642,0,1,1,1,1), -- Gauntlets of the Wayward Protector
(@GloveToken,45643,0,1,1,1,1), -- Gauntlets of the Wayward Vanquisher
-- Thorim 10 man
(@Thorim10Ref,45927,0,1,1,1,1), -- Handwraps of Resonance
(@Thorim10Ref,45894,0,1,1,1,1), -- Leggings of Unstable Discharge
(@Thorim10Ref,45895,0,1,1,1,1), -- Belt of the Blood Pit
(@Thorim10Ref,45893,0,1,1,1,1), -- Guise of the Midgard Serpent
(@Thorim10Ref,45892,0,1,1,1,1), -- Legacy of Thunder
-- Throim 25 man
(@Thorim25Ref,45468,0,1,1,1,1), -- Leggings of Lost Love
(@Thorim25Ref,45466,0,1,1,1,1), -- Scale of Fates
(@Thorim25Ref,45467,0,1,1,1,1), -- Belt of the Betrayed
(@Thorim25Ref,45469,0,1,1,1,1), -- Sif's Promise
(@Thorim25Ref,45463,0,1,1,1,1), -- Vulmir, the Northern Tempest
-- Thorim Tokens
(@ShoulderToken,45659,0,1,1,1,1), -- Spaulders of the Wayward Conqueror
(@ShoulderToken,45660,0,1,1,1,1), -- Spaulders of the Wayward Protector
(@ShoulderToken,45661,0,1,1,1,1), -- Spaulders of the Wayward Vanquisher
(@HelmToken,45638,0,1,1,1,1), --  Crown of the Wayward Conqueror
(@HelmToken,45639,0,1,1,1,1), --  Crown of the Wayward Protector
(@HelmToken,45640,0,1,1,1,1); --  Crown of the Wayward Vanquisher
-- -------------------------------
-- -- Gameobject Loot Templates --
-- -------------------------------
-- Delete previous templates if existing
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (@Freya10k3,@Freya10k2,@Freya10k1,@Freya10k0,@Freya25k3,@Freya25k2,@Freya25k1,@Freya25k0,@Hodir10n,@Hodir10h,@Hodir25n,@Hodir25h,@Mimiron10n,@Mimiron10h,@Mimiron25n,@Mimiron25h,@Thorim10n,@Thorim10h,@Thorim25n,@Thorim25h);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ------------------
-- -- Freya 10 man --
-- ------------------
-- Normal Mode:
(@Freya10k3,1,100,1,0,-@Freya10Ref,1), -- 1 from normal loot
(@Freya10k3,2,100,1,0,-@HandToken,1), -- 1 from tokens
(@Freya10k3,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya10k3,47241,100,1,0,1,1), -- 1x Emblem of Triumph
-- Hard Mode: 1 elder alive
(@Freya10k2,1,100,1,0,-@Freya10Ref,1), -- 1 from normal loot
(@Freya10k2,2,100,1,0,-@HandToken,1), -- 1 from tokens
(@Freya10k2,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya10k2,47241,100,1,0,2,2), -- 2x Emblem of Triumph
(@Freya10k2,45087,100,1,0,1,1), -- Runed Orb
(@Freya10k2,3,100,1,0,-34349,1), -- 1x Emblem of Triumph for Alive Elders
-- Hard Mode: 2 elders alive
(@Freya10k1,1,100,1,0,-@Freya10Ref,1), -- 1 from normal loot
(@Freya10k1,2,100,1,0,-@HandToken,1), -- 1 from tokens
(@Freya10k1,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya10k1,47241,100,1,0,3,3), -- 3x Emblem of Triumph
(@Freya10k1,45087,100,1,0,1,1), -- Runed Orb
(@Freya10k1,3,100,1,0,-@Recipe,1), -- 1 from Recipe
(@Freya10k1,4,100,1,0,-34349,2), -- 2x Emblem of Triumph for Alive Elders
-- Hard Mode: 3 elders alive
(@Freya10k0,1,100,1,0,-@Freya10Ref,1), -- 1 from normal loot
(@Freya10k0,2,100,1,0,-@HandToken,1), -- 1 from tokens
(@Freya10k0,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya10k0,47241,100,1,0,3,3), -- 3x Emblem of Triumph (self)
(@Freya10k0,45087,100,1,0,1,1), -- Runed Orb
(@Freya10k0,3,100,1,0,-@Recipe,1), -- 1 from Recipe
(@Freya10k0,45788,-100,1,0,1,1), -- Freya's Sigil 10 man QUEST ONLY
(@Freya10k0,4,100,1,0,-34349,1), -- 3x Emblem of Triumph for Alive Elders
-- 1 from Hardmode items:
(@Freya10k0,45943,0,1,1,1,1), -- Gloves of Whispering Winds
(@Freya10k0,45946,0,1,1,1,1), -- Fire Orchid Signet
(@Freya10k0,45945,0,1,1,1,1), -- Seed of Budding Carnage
(@Freya10k0,45947,0,1,1,1,1), -- Serilas, Blood Blade of Invar One-Arm
(@Freya10k0,45294,0,1,1,1,1), -- Petrified Ivy Sprig
-- ------------------ 
-- -- Freya 25 man -- 
-- ------------------
-- Normal Mode:
(@Freya25k3,1,100,1,0,-@Freya25Ref,1), -- 1 from normal loot
(@Freya25k3,2,100,1,0,-@LegToken,2), -- 2 from tokens
(@Freya25k3,47241,100,1,0,1,1), -- 1x Emblem of Triumph
(@Freya25k3,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya25k3,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Freya25k3,45087,10,1,0,1,1), -- Chance on Runed Orb
(@Freya25k3,45083,5,1,0,1,1), -- Fragment of Val'anyr
-- Hard Mode: 1 elder alive
(@Freya25k2,1,100,1,0,-@Freya25Ref,1), -- 1 from normal loot
(@Freya25k2,2,100,1,0,-@LegToken,2), -- 2 from tokens
(@Freya25k2,47241,100,1,0,2,2), -- 2x Emblem of Triumph
(@Freya25k2,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya25k2,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Freya25k2,4,10,1,0,-34350,1), -- Chance on Runed Orb
(@Freya25k2,45087,100,1,0,2,2), -- 2x Runed Orb
(@Freya25k2,45083,7,1,0,1,1), -- Fragment of Val'anyr
(@Freya25k2,5,100,1,0,-34349,1), -- 1x Emblem of Triumph for Alive Elder
-- Hard Mode: 2 elders alive
(@Freya25k1,1,100,1,0,-@Freya25Ref,1), -- 1 from normal loot
(@Freya25k1,2,100,1,0,-@LegToken,2), -- 2 from tokens
(@Freya25k1,47241,100,1,0,3,3), -- 3x Emblem of Triumph
(@Freya25k1,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya25k1,3,10,1,0,-34350,1), -- Chance on Runed Orb
(@Freya25k1,45087,100,1,0,2,2), -- 2x Runed Orb
(@Freya25k1,4,100,1,0,-@Recipe,1), -- Recipe
(@Freya25k1,5,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Freya25k1,45083,9,1,0,1,1), -- Fragment of Val'anyr
(@Freya25k1,6,100,1,0,-34349,2), -- 2x Emblem of Triumph for Alive Elder
-- Hard Mode: 3 elders alive
(@Freya25k0,1,100,1,0,-@Freya25Ref,1), -- 1 from normal loot
(@Freya25k0,2,100,1,0,-@LegToken,2), -- 2 from tokens
(@Freya25k0,47241,100,1,0,3,3), -- 3x Emblem of Triumph
(@Freya25k0,46110,100,1,0,1,1), -- Alchemist's Cache
(@Freya25k0,3,10,1,0,-34350,1), -- Chance on Runed Orb
(@Freya25k0,45087,100,1,0,2,2), -- 2x Runed Orb
(@Freya25k0,4,100,1,0,-@Recipe,1), -- Recipe
(@Freya25k0,5,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Freya25k0,45814,-100,1,0,1,1), -- Freya's Sigil 25 man QUEST ONLY
(@Freya25k0,45083,20,1,0,1,1), -- Fragment of Val'anyr
(@Freya25k2,6,100,1,0,-34349,3), -- 3x Emblem of Triumph for Alive Elder
-- 1 from Hardmode items
(@Freya25k0,45484,0,1,1,1,1), -- Bladetwister
(@Freya25k0,45486,0,1,1,1,1), -- Drape of the Sullen Goddess
(@Freya25k0,45487,0,1,1,1,1), -- Handguards of Revitalization
(@Freya25k0,45488,0,1,1,1,1), -- Leggings of the Enslaved Idol
(@Freya25k0,45613,0,1,1,1,1), -- Dreambinder
(@Freya25k0,45485,0,1,1,1,1), -- Bronze Pendant of the Vanir
-- ------------------
-- -- Hodir 10 man -- 
-- ------------------
(@Hodir10n,1,100,1,0,-@Hodir10Ref,1), -- 1x Normal Loot Item
(@Hodir10n,2,100,1,0,-@LegsToken,1), -- 1x Token
(@Hodir10n,47241,100,1,0,1,1), -- Emblem of Triumph
-- Hard mode:
(@Hodir10h,1,100,1,0,-@Hodir10Ref,1), -- 1x Normal Loot Item
(@Hodir10h,2,100,1,0,-@LegsToken,1), -- 1x Token
(@Hodir10h,47241,100,1,0,1,1), -- Emblem of Triumph
(@Hodir10h,45786,-100,1,0,1,1), -- Hodir's Sigil
-- 1 from Hardmode items
(@Hodir10h,45887,0,1,1,1,1), -- Ice Layered Barrier
(@Hodir10h,45888,0,1,1,1,1), -- Bitter Cold Armguards
(@Hodir10h,45886,0,1,1,1,1), -- Icecore Staff
(@Hodir10h,45876,0,1,1,1,1), -- Shiver
(@Hodir10h,45877,0,1,1,1,1), -- The Boreal Guard
-- ------------------
-- -- Hodir 25 man -- 
-- ------------------
(@Hodir25n,1,100,1,0,-@Hodir25Ref,1), -- 1x Normal Loot Item
(@Hodir25n,2,100,1,0,-@ChestToken,1), -- 1x Token
(@Hodir25n,47241,100,1,0,1,1), -- Emblem of Triumph
(@Hodir25n,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Hodir25n,45087,10,1,0,1,1), -- Chance on Runed Orb
(@Hodir25n,45083,10,1,0,1,1), -- Fragment of Val'anyr
-- Hard mode:
(@Hodir25h,1,100,1,0,-@Hodir25Ref,1), -- 1x Normal Loot Item
(@Hodir25h,2,100,1,0,-@ChestToken,2), -- 2x Token
(@Hodir25h,47241,100,1,0,1,1), -- Emblem of Triumph
(@Hodir25h,45815,-100,1,0,1,1), -- Hodir's Sigil
(@Hodir25h,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Hodir25h,45087,10,1,0,1,1), -- Chance on Runed Orb
(@Hodir25h,45083,20,1,0,1,1), -- Fragment of Val'anyr
-- --------------------
-- -- Mimiron 10 man --
-- --------------------
(@Mimiron10n,1,100,1,0,-@Mimiron10Ref,1), -- 1x Normal Loot Item
(@Mimiron10n,2,100,1,0,-@HeadToken,1), -- 1x Token
(@Mimiron10n,47241,100,1,0,1,1), -- 1x Emblem of Triumph
-- Hardmode 10 man
(@Mimiron10h,1,100,1,0,-@Mimiron10Ref,1), -- 1x Normal Loot Item
(@Mimiron10h,2,100,1,0,-@HeadToken,1), -- 1x Token
(@Mimiron10h,47241,100,1,0,1,1), -- 1x Emblem of Triumph
(@Mimiron10h,45787,-100,1,0,1,1), -- Mimiron's Sigel (QUEST ONLY, HARDMODE ONLY)
-- 1 from Hardmode items
(@Mimiron10h,45989,0,1,1,1,1), -- Tempered Mercury Greaves
(@Mimiron10h,45982,0,1,1,1,1), -- Fused Alloy Legplates
(@Mimiron10h,45993,0,1,1,1,1), -- Mimiron's Flight Goggles
(@Mimiron10h,45988,0,1,1,1,1), -- Greaves of the Iron Army
(@Mimiron10h,45990,0,1,1,1,1), -- Fusion Blade
-- --------------------
-- -- Mimiron 25 man --
-- --------------------
(@Mimiron25n,1,100,1,0,-@Mimiron25Ref,1), -- 1x Normal Loot Item
(@Mimiron25n,2,100,1,0,-@GloveToken,2), -- 2x Token
(@Mimiron25n,47241,100,1,0,1,1), -- 1x Emblem of Triumph
(@Mimiron25n,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Mimiron25n,45087,10,1,0,1,1), -- Chance on Runed Orb
(@Mimiron25n,45083,8,1,0,1,1), -- Fragment of Val'anyr Normal
-- Hard Mode 25 man
(@Mimiron25h,1,100,1,0,-@Mimiron25Ref,1), -- 1x Normal Loot Item
(@Mimiron25h,2,100,1,0,-@GloveToken,2), -- 2x Token
(@Mimiron25h,47241,100,1,0,1,1), -- 1x Emblem of Triumph
(@Mimiron25h,3,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Mimiron25h,45087,10,1,0,1,1), -- Chance on Runed Orb
(@Mimiron25h,45816,-100,1,0,1,1), -- Mimiron's Sigel (QUEST ONLY, HARDMODE ONLY)
(@Mimiron25h,45083,18,1,0,1,1), -- Fragment of Val'anyr Hardmode
-- 1 from Hardmode items
(@Mimiron25h,45496,0,1,1,1,1), -- Titanskin Cloak
(@Mimiron25h,45494,0,1,1,1,1), -- Delirium's Touch
(@Mimiron25h,45663,0,1,1,1,1), -- Armbands of Bedlam
(@Mimiron25h,45620,0,1,1,1,1), -- Starshard Edge
(@Mimiron25h,45495,0,1,1,1,1), -- Conductive Seal
(@Mimiron25h,45497,0,1,1,1,1), -- Crown of Luminescence
-- -------------------
-- -- Thorim 10 man -- 
-- -------------------
(@Thorim10n,1,100,1,0,-@Thorim10Ref,1), -- 1x Normal Loot Item
(@Thorim10n,2,100,1,0,-@ShoulderToken,1), -- 1x Token
(@Thorim10n,47241,100,1,0,1,1), -- 1x Emblem of Triumph
-- Hardmode 10 man
(@Thorim10h,1,100,1,0,-@Thorim10Ref,1), -- 1x Normal Loot Item
(@Thorim10h,2,100,1,0,-@ShoulderToken,1), -- 1x Token
(@Thorim10h,47241,100,1,0,1,1), -- 1x Emblem of Triumph
(@Thorim10h,45784,-100,2,0,1,1), -- Thorim's Sigil (QUEST ONLY, HARDMODE ONLY)
-- 1 from Hardmode items
(@Thorim10h,45933,0,2,1,1,1), -- Pendant of the Shallow Grave
(@Thorim10h,45929,0,2,1,1,1), -- Sif's Remembrance
(@Thorim10h,45928,0,2,1,1,1), -- Gauntlets of the Thunder God
(@Thorim10h,45931,0,2,1,1,1), -- Mjolnir Runestone
(@Thorim10h,45930,0,2,1,1,1), -- Combatant's Bootblade
-- -------------------
-- -- Thorim 25 man -- 
-- -------------------
(@Thorim25n,1,100,3,0,-@Thorim25Ref,1), -- 1x Normal Loot Item
(@Thorim25n,2,100,3,0,-@HelmToken,2), -- 2x Token
(@Thorim25n,47241,100,3,0,1,1), -- 1x Emblem of Triumph
(@Thorim25n,3,10,3,0,-@Recipe,1), -- Chance on Recipe
(@Thorim25n,45087,10,3,0,1,1), -- Chance on Runed Orb
(@Thorim25n,45083,8,1,0,1,1), -- Fragment of Val'anyr Normal
-- Hardmode 25 man
(@Thorim25h,1,100,3,0,-@Thorim25Ref,1), -- 1x Normal Loot Item
(@Thorim25h,2,100,3,0,-@HelmToken,2), -- 2x Token
(@Thorim25h,47241,100,3,0,1,1), -- 1x Emblem of Triumph
(@Thorim25h,3,10,3,0,-@Recipe,1), -- Chance on Recipe
(@Thorim25h,45087,10,3,0,1,1), -- Chance on Runed Orb
(@Thorim25h,45817,-100,1,0,1,1), -- Thorim's Sigil (QUEST ONLY, HARDMODE ONLY)
(@Thorim25h,45083,18,1,0,1,1), -- Fragment of Val'anyr Hardmode
-- 1 from Hardmode items
(@Thorim25h,45471,0,1,1,1,1), -- Fate's Clutch
(@Thorim25h,45570,0,1,1,1,1), -- Skyforge Crossbow
(@Thorim25h,45472,0,1,1,1,1), -- Warhelm of the Champion
(@Thorim25h,45474,0,1,1,1,1), -- Pauldrons of the Combatant
(@Thorim25h,45470,0,1,1,1,1), -- Wisdom's Hold
(@Thorim25h,45473,0,1,1,1,1); -- Embrace of the Gladiator

-- Increase dropchance for Venture Co. Explosives
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `entry` IN(28123,28124) AND `item`=39651;
-- implement missing Northrend pickpocket loot
-- reference IDs
SET @NEWREF0 := 10026;
SET @NEWREF1 := @NEWREF0+1;
SET @NEWREF2 := @NEWREF0+2;
SET @NEWREF3 := @NEWREF0+3;
SET @NEWREF4 := @NEWREF0+4;
SET @NEWREF5 := @NEWREF0+5;
SET @NEWREF6 := @NEWREF0+6;
SET @NEWREF7 := @NEWREF0+7;
SET @NEWREF8 := @NEWREF0+8;
SET @NEWREF9 := @NEWREF0+9;
-- new references
DELETE FROM `reference_loot_template` WHERE entry IN (@NEWREF0, @NEWREF1, @NEWREF2, @NEWREF3, @NEWREF4, @NEWREF5, @NEWREF6, @NEWREF7, @NEWREF8, @NEWREF9);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`mincountOrRef`,`maxcount`) VALUES
(@NEWREF0,33447,25,1,1),-- Runic Healing Potion
(@NEWREF0,35953,30,1,1),-- Mead Basted Caribou
(@NEWREF0,38260,50,1,1),-- Empty Tobacco Pouch
(@NEWREF0,43575,80,1,1),-- Reinforced Junkbox
(@NEWREF1,36862,4,1,1),-- Wrogn Troll Dice
(@NEWREF1,40202,20,1,1),-- Sizzling Grizzly Flank
(@NEWREF2,33452,30,1,1),-- Honey-Spiced Lichen
(@NEWREF2,38269,35,1,1),-- Soggy Handkerchief
(@NEWREF3,33454,15,1,1),-- Salted Venison
(@NEWREF3,38261,13,1,1),-- Ben House Key
(@NEWREF4,38263,19,1,1),-- Too-Small Amband
(@NEWREF4,38264,18,1,1),-- A Very Pretty Rock
(@NEWREF5,29448,9,1,1),-- Mag'har Mild Cheese
(@NEWREF5,29450,13,1,1),-- Telaari Grapes
(@NEWREF5,37467,40,1,1),-- A Steamy Romance Novel: Forbidden Love
(@NEWREF6,35947,25,1,1),-- Sparkling Frostcap
(@NEWREF6,38269,40,1,1),-- Soggy Handkerchief
(@NEWREF7,33447,25,1,1),-- Runic Healing Potion
(@NEWREF7,35947,25,1,1),-- Sparkling Frostcap
(@NEWREF7,38269,40,1,1),-- Soggy Handkerchief
(@NEWREF7,43575,80,1,1),-- Reinforced Junkbox
(@NEWREF8,35948,11,1,1),-- Savory Snowplum
(@NEWREF8,35950,9,1,1),-- Sweet Potato Bread
(@NEWREF8,35952,8,1,1),-- Briny Hardcheese
(@NEWREF9,33447,25,1,1),-- Runic Healing Potion
(@NEWREF9,38260,50,1,1),-- Empty Tobacco Pouch
(@NEWREF9,43575,80,1,1); -- Reinforced Junkbox
-- implement pickpokect loot
UPDATE `creature_template` SET `pickpocketloot`=entry WHERE `entry` IN (25800,23667,23674,23760,23796,23865,23875,23963,24069,24262,24400,24460,25351,25427,25428,25429,25430,25601,25801,26073,26202,26334,26413,26447,26480,26481,26620,26621,26624,26626,26635,26636,26637,26639,26658,26681,26696,26727,26729,26800,26802,26836,26948,27105,27210,27211,/**/27234,27235,27247,27278,27289,27334,27342,27431,27533,27580,27639,27640,27699,27800,27859,27860,27961,27964,27965,28494,28496,28565,28803,28837,28838,28848,28961,28965,29369,29407,29553,29554,29656,29793,29820,29822,29836,29874,29875,29885,29920,30283,30319,30856,30868,31396,31554,32263);
UPDATE `creature_template` SET `pickpocketloot`=25430 WHERE `entry` IN (23654,23656,23663,23665,25434,26728,26827,26926,27554,32572);
UPDATE `creature_template` SET `pickpocketloot`=26481 WHERE `entry` IN (23662,23940,24016,24161,26493,26655,27007,27009);
UPDATE `creature_template` SET `pickpocketloot`=25351 WHERE `entry` IN (23993,24540,25224,25383,26343,26492,26891,26946,27224,27226,27283,27360,27552,27799,27823,27826,28564,28750);
UPDATE `creature_template` SET `pickpocketloot`=27533 WHERE `entry` IN (26555,26669,26670,26694,26830,27871,28022,28108,28242,28268,28419,29123,29133,29722,29738,30701,30894,30922,30949,31139,31150,31779,31847,32278,32505);
UPDATE `creature_template` SET `pickpocketloot`=30319 WHERE `entry` IN (30111,30179);
DELETE FROM `pickpocketing_loot_template` WHERE entry IN (25800,23656,23662,23663,23665,23667,23674,23760,23796,23865,23875,23940,23963,23993,24016,24069,24161,24262,24400,24460,24540,25224,25351,25383,25427,25428,25429,25430,25434,25601,25801,26073,26202,26334,26343,26413,26447,26480,26481,26492,26493,26555,26620,26621,26624,26626,26635,26636,26637,26639,26655,26658,26669,26670,26681,26694,26696,26727,26728,26729,26800,26802,26827,26830,26836,26891,26926,26946,26948,27007,27009,27105,27210,27211,27224,27226,27234,27235,27247,27278,27283,27289,27334,27342,27360,27431,27533,27552,27554,27580,27639,27640,27699,27799,27800,27823,27826,27859,27860,27871,27961,27964,27965,28022,28108,28242,28268,28419,28494,28496,28564,28565,28750,28803,28837,28838,28848,28961,28965,29123,29133,29369,29407,29553,29554,29656,29722,29738,29793,29820,29822,29836,29874,29875,29885,29920,30111,30179,30283,30319,30701,30856,30868,30894,30922,30949,31139,31150,31396,31554,31779,31847,32263,32278,32505,32572);
INSERT INTO `pickpocketing_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Plague Walker
(30283,43575,100,0,1,1),-- Reinforced Junkbox
(30283,0,100,0,-@NEWREF6,1),
-- Twilight Darkcaster
(30319,0,100,0,-@NEWREF0,1),
(30319,33449,11,0,1,1),-- Crusty Flatbread
(30319,1,100,0,-@NEWREF1,1),
(30319,2,100,0,-@NEWREF3,1),
-- High Priest Talet-Kha
(26073,43575,58,0,1,1),-- Reinforced Junkbox
(26073,0,100,0,-@NEWREF5,1),
(26073,33449,8,0,1,1),-- Crusty Flatbread
(26073,33447,8,0,1,1),-- Runic Healing Potion
-- Nedar, Lord of Rhinos
(25801,0,100,0,-@NEWREF5,1),
(25801,33447,6,0,1,1),-- Runic Healing Potion
(25801,38261,6,0,1,1),-- Bent House Key
-- Clam Master K
(25800,43575,47,0,1,1),-- Reinforced Junkbox
(25800,0,100,0,-@NEWREF5,1),
(25800,38261,15,0,1,1),-- Bent House Key
(25800,33449,5,0,1,1),-- Crusty Flatbread
(25800,33447,5,0,1,1),-- Runic Healing Potion
-- Magmothregar
(25430,0,100,0,-@NEWREF3,1),
(25430,1,100,0,-@NEWREF9,1),
(25430,33449,7,0,1,1),-- Crusty Flatbread
(25430,36862,4,0,1,1),-- Wrogn Troll Dice
-- Kaganishu
(25427,43575,43,0,1,1),-- Reinforced Junkbox
(25427,33454,35,0,1,1),-- Salted Venison
(25427,0,100,0,-@NEWREF4,1),
(25427,33447,8,0,1,1),-- Runic Healing Potion
-- Prince Valanar
(25601,43575,43,0,1,1),-- Reinforced Junkbox
(25601,37467,39,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(25601,33447,9,0,1,1),-- Runic Healing Potion
(25601,38261,9,0,1,1),-- Bent House Key
(25601,33449,4,0,1,1),-- Crusty Flatbread
(25601,29450,4,0,1,1),-- Telaari Grapes
-- Ghostly Sage
(25351,43575,42,0,1,1),-- Reinforced Junkbox
(25351,0,100,0,-@NEWREF2,1),
(25351,33447,10,0,1,1),-- Runic Healing Potion
-- Luthion the Vile
(27860,43575,42,0,1,1),-- Reinforced Junkbox
(27860,0,100,0,-@NEWREF5,1),
(27860,38261,13,0,1,1),-- Bent House Key
(27860,33449,6,0,1,1),-- Crusty Flatbread
(27860,33447,6,0,1,1),-- Runic Healing Potion
-- Reckless Scavenger
(26658,0,100,0,-@NEWREF2,1),
(26658,43575,40,0,1,1),-- Reinforced Junkbox
-- Ziggurat Defender
(26202,43575,40,0,1,1),-- Reinforced Junkbox
(26202,0,100,0,-@NEWREF2,1),
(26202,33447,7,0,1,1),-- Runic Healing Potion
(26202,29569,3,0,1,1),-- Strong Junkbox
-- Magmoth Forager
(25429,43575,39,0,1,1),-- Reinforced Junkbox
(25429,33454,27,0,1,1),-- Salted Venison
(25429,0,100,0,-@NEWREF4,1),
(25429,33447,10,0,1,1),-- Runic Healing Potion
(25429,38266,0.5,0,1,1),-- Rotund Relic
-- Magmoth Shaman
(25428,43575,39,0,1,1),-- Reinforced Junkbox
(25428,33454,28,0,1,1),-- Salted Venison
(25428,0,100,0,-@NEWREF4,1),
(25428,33447,9,0,1,1),-- Runic Healing Potion
(25428,38266,0.5,0,1,1),-- Rotund Relic
-- Vanthryn the Merciless
(27859,43575,39,0,1,1),-- Reinforced Junkbox
(27859,0,100,0,-@NEWREF5,1),
(27859,33449,12,0,1,1),-- Crusty Flatbread
(27859,38261,12,0,1,1),-- Bent House Key
(27859,33447,3,0,1,1),-- Runic Healing Potion
-- Unbound Corrupter
(30868,43575,47,0,1,1),-- Reinforced Junkbox
(30868,40202,18,0,1,1),-- Sizzling Grizzly Flank
(30868,33447,16,0,1,1),-- Runic Healing Potion
(30868,0,100,0,-@NEWREF4,1),
-- Unbound Trickster
(30856,43575,38,0,1,1),-- Reinforced Junkbox
(30856,0,100,0,-@NEWREF4,1),
(30856,33447,19,0,1,1),-- Runic Healing Potion
(30856,40202,14,0,1,1),-- Sizzling Grizzly Flank
-- Kreug Oathbreaker
(27105,43575,63,0,1,1),-- Reinforced Junkbox
(27105,33447,25,0,1,1),-- Runic Healing Potion
(27105,38269,13,0,1,1),-- Soggy Handkerchief
-- Lead Cannoneer Zierhut
(27235,43575,53,0,1,1),-- Reinforced Junkbox
(27235,0,100,0,-@NEWREF5,1),
(27235,33447,8,0,1,1),-- Runic Healing Potion
(27235,38261,8,0,1,1),-- Bent House Key
-- Devout Bodyguard
(27247,43575,50,0,1,1),-- Reinforced Junkbox
(27247,37467,42,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(27247,33447,8,0,1,1),-- Runic Healing Potion
(27247,29450,8,0,1,1),-- Telaari Grapes
(27247,38261,8,0,1,1),-- Bent House Key
-- Magnataur Alpha
(26481,0,100,0,-@NEWREF9,1),
(26481,1,100,0,-@NEWREF3,1),
(26481,33449,5,0,1,1),-- Crusty Flatbread
-- High General Abbendis
(27210,43575,48,0,1,1),-- Reinforced Junkbox
(27210,0,100,0,-@NEWREF5,1),
(27210,33449,10,0,1,1),-- Crusty Flatbread
(27210,33447,10,0,1,1),-- Runic Healing Potion
(27210,38261,8,0,1,1),-- Bent House Key
-- Anub'ar Dreadweaver
(26413,43575,44,0,1,1),-- Reinforced Junkbox
(26413,43576,22,0,1,1),-- Chitin Polish
(26413,33452,11,0,1,1),-- Honey-Spiced Lichen
(26413,33447,11,0,1,1),-- Runic Healing Potion
(26413,43577,11,0,1,1),-- Carapace Cleanser
-- Naxxramas Necrolord
(27289,33452,44,0,1,1),-- Honey-Spiced Lichen
(27289,43575,44,0,1,1),-- Reinforced Junkbox
(27289,33447,11,0,1,1),-- Runic Healing Potion
-- Onslaught Commander Iustus
(27334,37467,50,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(27334,43575,44,0,1,1),-- Reinforced Junkbox
(27334,29448,13,0,1,1),-- Mag'har Mild Cheese
(27334,38261,6,0,1,1),-- Bent House Key
-- Blacksmith Goodman
(27234,43575,41,0,1,1),-- Reinforced Junkbox
(27234,0,100,0,-@NEWREF5,1),
(27234,38261,13,0,1,1),-- Bent House Key
(27234,33447,9,0,1,1),-- Runic Healing Potion
(27234,33449,7,0,1,1),-- Crusty Flatbread
-- Magnataur Youngling
(26480,33449,19,0,1,1),-- Crusty Flatbread
(26480,0,100,0,-@NEWREF3,1),
(26480,1,100,0,-@NEWREF9,1),
-- Bloodpaw Warrior
(27342,43575,40,0,1,1),-- Reinforced Junkbox
(27342,33454,26,0,1,1),-- Salted Venison
(27342,0,100,0,-@NEWREF4,1),
(27342,33447,11,0,1,1),-- Runic Healing Potion
(27342,38266,0.6,0,1,1),-- Rotund Relic
-- Frigid Geist
(27533,0,100,0,-@NEWREF7,1),
-- Snowplain Zealot
(27278,43575,40,0,1,1),-- Reinforced Junkbox
(27278,33454,22,0,1,1),-- Salted Venison
(27278,0,100,0,-@NEWREF4,1),
(27278,33447,12,0,1,1),-- Runic Healing Potion
(27278,38266,0.3,0,1,1),-- Rotund Relic
-- Hulking Atrocity
(26948,43575,39,0,1,1),-- Reinforced Junkbox
(26948,0,100,0,-@NEWREF2,1),
(26948,33447,9,0,1,1),-- Runic Healing Potion
(26948,29569,0.3,0,1,1),-- Strong Junkbox
(26948,38268,0.3,0,1,1),-- Spare Hand
-- Onslaught Executioner
(27211,43575,39,0,1,1),-- Reinforced Junkbox
(27211,0,100,0,-@NEWREF5,1),
(27211,33449,12,0,1,1),-- Crusty Flatbread
(27211,38261,11,0,1,1),-- Bent House Key
(27211,33447,5,0,1,1),-- Runic Healing Potion
-- Gigantaur
(26836,0,100,0,-@NEWREF9,1),
(26836,1,100,0,-@NEWREF3,1),
(26836,33449,12,0,1,1),-- Crusty Flatbread
-- Leprous Servant
(27800,43575,38,0,1,1),-- Reinforced Junkbox
(27800,0,100,0,-@NEWREF2,1),
(27800,33447,7,0,1,1),-- Runic Healing Potion
(27800,38268,2,0,1,1),-- Spare Hand
-- Wretched Belcher
(26624,43575,100,0,1,1),-- Reinforced Junkbox
(26624,0,100,0,-@NEWREF2,1),
(26624,33447,25,0,1,1),-- Runic Healing Potion
(26624,35947,25,0,1,1),-- Sparkling Frostcap
-- Drakkari Commander
(27431,43575,90,0,1,1),-- Reinforced Junkbox
(27431,0,100,0,-@NEWREF2,1),
(27431,33447,26,0,1,1),-- Runic Healing Potion
(27431,35947,10,0,1,1),-- Sparkling Frostcap
-- Drakkari Guardian
(26620,0,100,0,-@NEWREF0,1),
(26620,33454,17,0,1,1),-- Salted Venison
(26620,33449,9,0,1,1),-- Crusty Flatbread
(26620,38261,9,0,1,1),-- Bent House Key
(26620,1,100,0,-@NEWREF1,1),
-- Risen Drakkari Soulmage
(26636,43575,85,0,1,1),-- Reinforced Junkbox
(26636,0,100,0,-@NEWREF2,1),
(26636,35947,21,0,1,1),-- Sparkling Frostcap
(26636,33447,16,0,1,1),-- Runic Healing Potion
-- Ghoul Tormentor
(26621,43575,81,0,1,1),-- Reinforced Junkbox
(26621,0,100,0,-@NEWREF2,1),
(26621,35947,24,0,1,1),-- Sparkling Frostcap
(26621,33447,14,0,1,1),-- Runic Healing Potion
-- Risen Drakkari Warrior
(26635,43575,71,0,1,1),-- Reinforced Junkbox
(26635,0,100,0,-@NEWREF2,1),
(26635,33447,29,0,1,1),-- Runic Healing Potion
(26635,35947,18,0,1,1),-- Sparkling Frostcap
(26635,38268,0.8,0,1,1),-- Spare Hand
-- Risen Drakkari Handler
(26637,0,100,0,-@NEWREF2,1),
(26637,43575,67,0,1,1),-- Reinforced Junkbox
(26637,33447,30,0,1,1),-- Runic Healing Potion
(26637,35947,18,0,1,1),-- Sparkling Frostcap
-- Scourge Reanimator
(26626,0,100,0,-@NEWREF2,1),
(26626,43575,67,0,1,1),-- Reinforced Junkbox
(26626,33447,21,0,1,1),-- Runic Healing Potion
(26626,35947,21,0,1,1),-- Sparkling Frostcap
-- Drakkari Shaman
(26639,0,100,0,-@NEWREF0,1),
(26639,33449,18,0,1,1),-- Crusty Flatbread
(26639,1,100,0,-@NEWREF3,1),
(26639,40202,11,0,1,1),-- Sizzling Grizzly Flank
-- Selas
(27580,43575,50,0,1,1),-- Reinforced Junkbox
(27580,0,100,0,-@NEWREF3,1),
(27580,38260,20,0,1,1),-- Empty Tobacco Pouch
-- Forgemaster Damrath
(26334,43575,48,0,1,1),-- Reinforced Junkbox
(26334,0,100,0,-@NEWREF5,1),
(26334,33447,9,0,1,1),-- Runic Healing Potion
(26334,38261,9,0,1,1),-- Bent House Key
-- Grumbald One-Eye
(26681,43575,39,0,1,1),-- Reinforced Junkbox
(26681,33454,28,0,1,1),-- Salted Venison
(26681,0,100,0,-@NEWREF4,1),
(26681,33447,9,0,1,1),-- Runic Healing Potion
-- Drakkari Shaman
(26447,0,100,0,-@NEWREF9,1),
(26447,1,100,0,-@NEWREF3,1),
(26447,33449,10,0,1,1),-- Crusty Flatbread
(26447,35799,0.2,0,1,1),-- Frozen Mojo
(26447,36862,0.2,0,1,1),-- Wrogn Troll Dice
-- Drakkari God Hunter
(29820,0,100,0,-@NEWREF0,1),
(29820,1,100,0,-@NEWREF1,1),
-- Drakkari Battle Rider
(29836,0,100,0,-@NEWREF0,1),
(29836,40202,18,0,1,1),-- Sizzling Grizzly Flank
-- Ruins Dweller
(29920,43575,71,0,1,1),-- Reinforced Junkbox
(29920,37452,69,0,1,1),-- Fatty Bluefin
(29920,38274,58,0,1,1),-- Large Snail Shell
(29920,38273,35,0,1,1),-- Brain Coral
(29920,33447,16,0,1,1),-- Runic Healing Potion
-- Drakkari Fire Weaver
(29822,0,100,0,-@NEWREF0,1),
(29822,40202,24,0,1,1),-- Sizzling Grizzly Flank
-- Drakkari Inciter
(29874,0,100,0,-@NEWREF0,1),
(29874,36862,16,0,1,1),-- Wrogn Troll Dice
(29874,40202,12,0,1,1),-- Sizzling Grizzly Flank
-- Titanium Siegebreaker
(28961,0,100,0,-@NEWREF0,1),
(28961,40202,35,0,1,1),-- Sizzling Grizzly Flank
-- Stormforged Sentinel
(28837,0,100,0,-@NEWREF0,1),
(28837,40202,16,0,1,1),-- Sizzling Grizzly Flank
-- Titanium Thunderer
(28965,0,100,0,-@NEWREF0,1),
(28965,40202,44,0,1,1),-- Sizzling Grizzly Flank
-- Titanium Vanguard
(28838,0,100,0,-@NEWREF0,1),
(28838,40202,27,0,1,1),-- Sizzling Grizzly Flank
-- Dark Rune Scholar
(27964,0,100,0,-@NEWREF9,1),
(27964,1,100,0,-@NEWREF1,1),
-- Dark Rune Worker
(27961,0,100,0,-@NEWREF0,1),
(27961,40202,29,0,1,1),-- Sizzling Grizzly Flank
(27961,36862,4,0,1,1),-- Wrogn Troll Dice
-- Dark Rune Shaper
(27965,0,100,0,-@NEWREF0,1),
(27965,40202,28,0,1,1),-- Sizzling Grizzly Flank
-- Steel Gate Archaeologist
(24400,0,100,0,-@NEWREF0,1),
(24400,1,100,0,-@NEWREF5,1),
(24400,33449,7,0,1,1),-- Crusty Flatbread
(24400,38261,9,0,1,1),-- Bent House Key
-- Blacksouled Keeper
(23875,0,100,0,-@NEWREF0,1),
(23875,1,100,0,-@NEWREF3,1),
(23875,33449,14,0,1,1),-- Crusty Flatbread
-- Winterskorn Rune-Seer
(23667,0,100,0,-@NEWREF0,1),
(23667,33449,7,0,1,1),-- Crusty Flatbread
(23667,33454,7,0,1,1),-- Salted Venison
-- Sergeant Lorric
(23963,43575,45,0,1,1),-- Reinforced Junkbox
(23963,0,100,0,-@NEWREF5,1),
(23963,33447,13,0,1,1),-- Runic Healing Potion
(23963,38261,11,0,1,1),-- Bent House Key
(23963,33449,7,0,1,1),-- Crusty Flatbread
-- Gjalerhorn Scavenger
(27699,0,100,0,-@NEWREF4,1),
(27699,43575,43,0,1,1),-- Reinforced Junkbox
(27699,33454,22,0,1,1),-- Salted Venison
(27699,33447,7,0,1,1),-- Runic Healing Potion
(27699,29569,0.8,0,1,1),-- Strong Junkbox
-- Iron Rune Binder
(23796,0,100,0,-@NEWREF5,1),
(23796,43575,42,0,1,1),-- Reinforced Junkbox
(23796,38261,12,0,1,1),-- Bent House Key
(23796,33449,11,0,1,1),-- Crusty Flatbread
(23796,33447,9,0,1,1),-- Runic Healing Potion
(23796,29569,0.5,0,1,1),-- Strong Junkbox
-- Forsaken Plaguebringer
(23760,0,100,0,-@NEWREF2,1),
(23760,43575,41,0,1,1),-- Reinforced Junkbox
(23760,33447,10,0,1,1),-- Runic Healing Potion
(23760,38268,0.3,0,1,1),-- Spare Hand
-- Chillmere Tidehunter
(24460,43575,40,0,1,1),-- Reinforced Junkbox
(24460,38274,33,0,1,1),-- Large Snail Shell
(24460,37452,18,0,1,1),-- Fatty Bluefin
(24460,38273,15,0,1,1),-- Brain Coral
(24460,33447,7,0,1,1),-- Runic Healing Potion
-- Vrykul Soul
(24262,0,100,0,-@NEWREF2,1),
(24262,43575,40,0,1,1),-- Reinforced Junkbox
(24262,33447,3,0,1,1),-- Runic Healing Potion
-- Iron Rune Sage
(23674,0,100,0,-@NEWREF5,1),
(23674,43575,39,0,1,1),-- Reinforced Junkbox
(23674,38261,13,0,1,1),-- Bent House Key
(23674,33449,9,0,1,1),-- Crusty Flatbread
(23674,33447,6,0,1,1),-- Runic Healing Potion
-- Vengeance Bringer
(23865,43575,39,0,1,1),-- Reinforced Junkbox
(23865,0,100,0,-@NEWREF2,1),
-- Restless Lookout
(31554,43575,80,0,1,1),-- Reinforced Junkbox
(31554,35947,40,0,1,1),-- Sparkling Frostcap
-- Val'kyr Taskmistress
(31396,43575,56,0,1,1),-- Reinforced Junkbox
(31396,35947,38,0,1,1),-- Sparkling Frostcap
(31396,33447,15,0,1,1),-- Runic Healing Potion
-- Overseer Veraj
(32263,43575,42,0,1,1),-- Reinforced Junkbox
(32263,37467,28,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(32263,38261,15,0,1,1),-- Bent House Key
(32263,33447,13,0,1,1),-- Runic Healing Potion
(32263,0,100,0,-@NEWREF8,1),
-- Steward
(26729,0,100,0,-@NEWREF0,1),
(26729,1,100,0,-@NEWREF3,1),
(26729,33449,31,0,1,1),-- Crusty Flatbread
(26729,29569,0.5,0,1,1),-- Strong Junkbox
-- Alliance Berserker
(26800,43575,62,0,1,1),-- Reinforced Junkbox
(26800,33449,19,0,1,1),-- Crusty Flatbread
(26800,38261,16,0,1,1),-- Bent House Key
(26800,33447,10,0,1,1),-- Runic Healing Potion
(26800,0,100,0,-@NEWREF5,1),
-- Alliance Ranger
(26802,0,100,0,-@NEWREF5,1),
(26802,43575,60,0,1,1),-- Reinforced Junkbox
(26802,38261,34,0,1,1),-- Bent House Key
(26802,33449,24,0,1,1),-- Crusty Flatbread
(26802,33447,12,0,1,1),-- Runic Healing Potion
-- Mage Hunter Ascendant
(26727,0,100,0,-@NEWREF0,1),
(26727,1,100,0,-@NEWREF3,1),
(26727,33449,29,0,1,1),-- Crusty Flatbread
-- Ring-Lord Sorceress
(27639,43575,87,0,1,1),-- Reinforced Junkbox
(27639,37467,46,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(27639,38261,28,0,1,1),-- Bent House Key
(27639,33447,19,0,1,1),-- Runic Healing Potion
(27639,0,100,0,-@NEWREF8,1),
(27639,36863,1.6,0,1,1),-- Decahedral Dwarven Dice
-- Ring-Lord Conjurer
(27640,37467,67,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(27640,43575,64,0,1,1),-- Reinforced Junkbox
(27640,33447,30,0,1,1),-- Runic Healing Potion
(27640,38261,26,0,1,1),-- Bent House Key
(27640,0,100,0,-@NEWREF8,1),
-- Mildred the Cruel
(29885,0,100,0,-@NEWREF0,1),
(29885,40202,13,0,1,1),-- Sizzling Grizzly Flank
-- Snowblind Devotee
(29407,43575,42,0,1,1),-- Reinforced Junkbox
(29407,40202,29,0,1,1),-- Sizzling Grizzly Flank
(29407,0,100,0,-@NEWREF4,1),
(29407,33447,12,0,1,1),-- Runic Healing Potion
-- Snowblind Devotee
(29554,43575,43,0,1,1),-- Reinforced Junkbox
(29554,40202,27,0,1,1),-- Sizzling Grizzly Flank
(29554,0,100,0,-@NEWREF4,1),
(29554,33447,12,0,1,1),-- Runic Healing Potion
(29554,38266,0.2,0,1,1),-- Rotund Relic
-- Frostfeather Witch
(29793,43575,40,0,1,1),-- Reinforced Junkbox
(29793,40202,21,0,1,1),-- Sizzling Grizzly Flank
(29793,0,100,0,-@NEWREF4,1),
(29793,33447,16,0,1,1),-- Runic Healing Potion
-- Icemane Yeti
(29875,43575,39,0,1,1),-- Reinforced Junkbox
(29875,40202,23,0,1,1),-- Sizzling Grizzly Flank
(29875,0,100,0,-@NEWREF4,1),
(29875,33447,15,0,1,1),-- Runic Healing Potion
(29875,38266,0.3,0,1,1),-- Rotund Relic
-- Garm Watcher
(29553,0,100,0,-@NEWREF0,1),
(29553,1,100,0,-@NEWREF1,1),
(29553,24231,0.3,0,2,2),-- Coarse Snuff
-- Stormforged Taskmaster
(29369,43575,38,0,1,1),-- Reinforced Junkbox
(29369,37467,34,0,1,1),-- A Steamy Romance Novel: Forbidden Love
(29369,33447,13,0,1,1),-- Runic Healing Potion
(29369,38261,6,0,1,1),-- Bent House Key
(29369,0,100,0,-@NEWREF8,1),
-- Dragonflayer Bonecrusher
(24069,0,100,0,-@NEWREF0,1),
(24069,1,100,0,-@NEWREF1,1),
(24069,29569,47,0,1,1),-- Strong Junkbox
(24069,29570,34,0,1,1),-- A Gnome Effigy
(24069,27855,22,0,1,1),-- Mag'har Grainbread
(24069,27854,19,0,1,1),-- Smoked Talbuk Venison
(24069,22829,10,0,1,1),-- Super Healing Potion
(24069,23438,1.2,0,1,1),-- Star of Elune
-- Ymirjar Berserker
(26696,0,100,0,-@NEWREF7,1),
(26696,29569,1.1,0,1,1),-- Strong Junkbox
-- Kutube'sa
(28494,0,100,0,-@NEWREF0,1),
(28494,1,100,0,-@NEWREF1,1),
-- Chulo the Mad
(28496,0,100,0,-@NEWREF0,1),
(28496,40202,6,0,1,1),-- Sizzling Grizzly Flank
-- Drakuru's Guard
(28803,43575,50,0,1,1),-- Reinforced Junkbox
(28803,33447,33,0,1,1),-- Runic Healing Potion
(28803,38269,17,0,1,1),-- Soggy Handkerchief
-- Prophet of Har'koa
(28848,0,100,0,-@NEWREF0,1),
(28848,40202,3,0,1,1),-- Sizzling Grizzly Flank
-- Decaying Ghoul
(28565,0,100,0,-@NEWREF7,1),
(28565,22829,0.9,0,1,1),-- Super Healing Potion
-- Drakuru Berserker
(29656,0,100,0,-@NEWREF0,1),
(29656,1,100,0,-@NEWREF3,1),
(29656,33449,11,0,1,1),-- Crusty Flatbread
(29656,29569,0.9,0,1,1); -- Strong Junkbox
-- Add condition to the Lovely Charm aura
DELETE FROM conditions WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`= 69511;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, COMMENT) VALUES
(17,0,69511,0,12,8,0,0,0, '', 'Lovely Charm - Only during event');
-- Remove Skinning loot from Blackwing Spellbinder
UPDATE `creature_template` SET `skinloot`=0 WHERE `entry`=12457;
-- update wrong area.
UPDATE `fishing_loot_template` SET `entry`=4560 WHERE `entry`=4395 AND `item`=11026;
-- Add loot for Hrothgar's Landing
DELETE FROM `creature_loot_template` WHERE `entry` IN (34980,34838,34839,34965);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- AURIAYA 10-man
-- Drottinn Hrothgar - http://old.wowhead.com/npc=34980
(34980,46859,-100,1,0,1,1), -- Stolen Tallstrider Leg
-- Kvaldir Reaver
(34838,46859,-100,1,0,1,1), -- Stolen Tallstrider Leg
(34838,49676,5,1,0,1,1), -- Kvaldir Attack Plans
(34838,33470,35,1,0,1,4), -- 1-4x Frostweave Cloth
(34838,1,10,1,0,-24727,1), -- 1 of Northrend scrolls
(34838,2,10,1,0,-26002,1), -- Northrend Grey Item Reference1
(34838,3,2,1,0,-35080,1), -- Northrend Green Item Reference
-- Kvaldir Mist Binder
(34839,46859,-100,1,0,1,1), -- Stolen Tallstrider Leg
(34839,49676,5,1,0,1,1), -- Kvaldir Attack Plans
(34839,33470,35,1,0,1,4), -- 1-4x Frostweave Cloth
(34839,1,10,1,0,-24727,1), -- 1 of Northrend scrolls
(34839,2,10,1,0,-26002,1), -- Northrend Grey Item Reference1
(34839,3, 2,1,0,-35080,1), -- Northrend Green Item Reference
-- Mistcaller Yngvar
(34965,46859,-100,1,0,1,1); -- Stolen Tallstrider Leg
-- update Plague Slime & Marauding Geist to naxx25 trash lootid
UPDATE `creature_template` SET `lootid`=100005 WHERE `entry` IN(29575,30424); 
--  update Plague Slime & Marauding Geist to naxx10 trash lootid
UPDATE `creature_template` SET `lootid`=100003 WHERE `entry` IN(16243,30083); 
DELETE FROM `creature_loot_template` WHERE `entry` IN(30424,29575,16243,30083);
-- Remove scraps for naxx10 from creature creature_loot_template
DELETE FROM `creature_loot_template` WHERE `item` IN (22373,22374,22375,22376);
-- Fix to add pickpocketing loot for humoniods in borean tundra
SET @GORLOCREF := 25100;
SET @BERYLREF := @GORLOCREF+1;
SET @BLOODREF := @GORLOCREF+2;
SET @CHIEFREF := @GORLOCREF+3;
SET @CULTREF := @GORLOCREF+4;
SET @KVALDIRREF := @GORLOCREF+5;
SET @CLAXREF := @GORLOCREF+6;
SET @MAGMOTHREF := @GORLOCREF+7;
-- Create reference templates
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @GORLOCREF AND @GORLOCREF+7;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(@GORLOCREF,29576,57,1,0,1,1), -- Shark Bait
(@GORLOCREF,29569,30,1,0,1,1), -- Strong Junkbox
(@GORLOCREF,27858,8,1,0,1,1), -- Sunspring Carp
(@GORLOCREF,22829,3,1,0,1,1), -- Super Healing Potion
(@GORLOCREF,23436,0.5,1,0,1,1), -- Living Ruby
(@GORLOCREF,23437,0.5,1,0,1,1), -- Talasite
(@GORLOCREF,23440,0.5,1,0,1,1), -- Dawnstone
(@GORLOCREF,23438,0.5,1,0,1,1), -- Star of Elune
(@GORLOCREF,23439,0.5,1,0,1,1), -- Noble Topaz
-- --------------------------------------------------
(@BERYLREF,37467,32.5,1,0,1,1), -- A Steamy Romance Novel: Forbidden Love
(@BERYLREF,43575,31,1,0,1,1), -- Reinforced Junkbox
(@BERYLREF,38261,10,1,0,1,1), -- Bent House Key
(@BERYLREF,29448,7,1,0,1,1), -- Mag'har Mild Cheese
(@BERYLREF,29450,7,1,0,1,1), -- Telaari Grapes
(@BERYLREF,33447,6,1,0,1,1), -- Runic Healing Potion
(@BERYLREF,33449,6,1,0,1,1), -- Crusty Flatbread
(@BERYLREF,36863,0.5,1,0,1,1), -- Decahedral Dwarven Dice
-- --------------------------------------------------
(@BLOODREF,29572,37,1,0,1,1), -- Aboriginal Carvings
(@BLOODREF,29569,33,1,0,1,1), -- Strong Junkbox
(@BLOODREF,8952,20,1,0,1,1), -- Roasted Quail
(@BLOODREF,22829,8,1,0,1,1), -- Super Healing Potion
(@BLOODREF,23438,0.5,1,0,1,1), -- Star of Elune
(@BLOODREF,23436,0.5,1,0,1,1), -- Living Ruby
(@BLOODREF,23441,0.5,1,0,1,1), -- Nightseye
(@BLOODREF,23437,0.5,1,0,1,1), -- Talasite
(@BLOODREF,23440,0.5,1,0,1,1), -- Dawnstone
-- --------------------------------------------------
(@CHIEFREF,29569,50,1,0,1,1), -- Strong Junkbox
(@CHIEFREF,27858,20,1,0,1,1), -- Sunspring Carp
(@CHIEFREF,29576,20,1,0,1,1), -- Shark Bait
(@CHIEFREF,22829,10,1,0,1,1), -- Super Healing Potion
-- --------------------------------------------------
(@CULTREF,29569,40,1,0,1,1), -- Strong Junkbox
(@CULTREF,29571,37,1,0,1,1), -- A Steamy Romance Novel
(@CULTREF,30458,8,1,0,1,1), -- Stromgarde Muenster
(@CULTREF,27855,7,1,0,1,1), -- Mag'har Grainbread
(@CULTREF,27856,6,1,0,1,1), -- Skethyl Berries
(@CULTREF,22829,2,1,0,1,1), -- Super Healing Potion
(@CULTREF,36863,0.5,1,0,1,1), -- Decahedral Dwarven Dice
-- --------------------------------------------------
(@KVALDIRREF,29569,39,1,0,1,1), -- Strong Junkbox
(@KVALDIRREF,29570,28,1,0,1,1), -- A Gnome Effigy
(@KVALDIRREF,27855,12,1,0,1,1), -- Mag'har Grainbread
(@KVALDIRREF,27854,12,1,0,1,1), -- Smoked Talbuk Venison
(@KVALDIRREF,22829,7,1,0,1,1), -- Super Healing Potion
(@KVALDIRREF,23436,0.5,1,0,1,1), -- Living Ruby
(@KVALDIRREF,23441,0.5,1,0,1,1), -- Nightseye
(@KVALDIRREF,23440,0.5,1,0,1,1), -- Dawnstone
(@KVALDIRREF,23439,0.5,1,0,1,1), -- Noble Topaz
(@KVALDIRREF,23437,0.5,1,0,1,1), -- Talasite
-- --------------------------------------------------
(@CLAXREF,43575,28,1,0,1,1), -- Reinforced Junkbox
(@CLAXREF,38273,26,1,0,1,1), -- Brain Coral
(@CLAXREF,38274,23,1,0,1,1), -- Large Snail Shell
(@CLAXREF,37452,17,1,0,1,1), -- Fatty Bluefin
(@CLAXREF,33447,6,1,0,1,1), -- Runic Healing Potion
-- --------------------------------------------------
(@MAGMOTHREF,38260,33,1,0,1,1), -- Empty Tobacco Pouch
(@MAGMOTHREF,38261,21,1,0,1,1), -- Bent House Key
(@MAGMOTHREF,33449,16,1,0,1,1), -- Crusty Flatbread
(@MAGMOTHREF,43575,16,1,0,1,1), -- Reinforced Junkbox
(@MAGMOTHREF,33454,9,1,0,1,1), -- Salted Venison
(@MAGMOTHREF,33447,5,1,0,1,1), -- Runic Healing Potion
(@MAGMOTHREF,36862,1,1,0,1,1); -- Worn Troll Dice
-- -------------------
-- -- NPC Variables --
-- -------------------
SET @NPC := 25686;
SET @NPC1 := 25700;
SET @NPC2 := 25687;
SET @NPC3 := 25685;
SET @NPC4 := 25449;
SET @NPC5 := 25316;
SET @NPC6 := 25353;
SET @NPC7 := 25719;
SET @NPC8 := 25804;
SET @NPC9 := 25392;
SET @NPC10 := 25651;
SET @NPC11 := 25836;
SET @NPC12 := 25979;
SET @NPC13 := 25806;
SET @NPC14 := 25720;
SET @NPC15 := 25803;
SET @NPC16 := 25880;
SET @NPC17 := 25618;
SET @NPC18 := 25839;
SET @NPC19 := 25470;
SET @NPC20 := 24567;
SET @NPC21 := 25467;
SET @NPC22 := 25468;
SET @NPC23 := 25501;
SET @NPC24 := 25726;
SET @NPC25 := 25701;
SET @NPC26 := 25725;
SET @NPC27 := 25699;
SET @NPC28 := 24576;
SET @NPC29 := 25605;
SET @NPC30 := 25609;
SET @NPC31 := 25378;
SET @NPC32 := 25843;
SET @NPC33 := 25496;
SET @NPC34 := 25479;
SET @NPC35 := 25760;
SET @NPC36 := 26266;
SET @NPC37 := 26451;
SET @NPC38 := 25521;
SET @NPC39 := 25613;
SET @NPC40 := 25522;
SET @NPC41 := 25520;
SET @NPC42 := 25209;
SET @NPC43 := 25210;
SET @NPC44 := 25216;
SET @NPC45 := 25215;
SET @NPC46 := 25217;
SET @NPC47 := 25789;
SET @NPC48 := 24469;
SET @NPC49 := 25432;
SET @NPC50 := 25433;
SET @NPC51 := 25615;
SET @NPC52 := 25523;
-- ----------------------
-- -- Assign the loots --
-- ----------------------
UPDATE `creature_template` SET `pickpocketloot`=`entry` WHERE `entry` IN (@NPC,@NPC1,@NPC2,@NPC3,@NPC4,@NPC5,@NPC6,@NPC7,@NPC8,@NPC9,@NPC10,@NPC11,@NPC12,@NPC13,@NPC14,@NPC15,@NPC16,@NPC17,@NPC18,@NPC19,@NPC20,@NPC21,@NPC22,@NPC23,@NPC24,@NPC25,@NPC26,@NPC27,@NPC28,@NPC29,@NPC30,@NPC31,@NPC32,@NPC33,@NPC34,@NPC35,@NPC36,@NPC37,@NPC38,@NPC39,@NPC40,@NPC41,@NPC42,@NPC43,@NPC44,@NPC45,@NPC46,@NPC47,@NPC48,@NPC49,@NPC50,@NPC51,@NPC52);
DELETE FROM `pickpocketing_loot_template` WHERE `entry` IN (@NPC,@NPC1,@NPC2,@NPC3,@NPC4,@NPC5,@NPC6,@NPC7,@NPC8,@NPC9,@NPC10,@NPC11,@NPC12,@NPC13,@NPC14,@NPC15,@NPC16,@NPC17,@NPC18,@NPC19,@NPC20,@NPC21,@NPC22,@NPC23,@NPC24,@NPC25,@NPC26,@NPC27,@NPC28,@NPC29,@NPC30,@NPC31,@NPC32,@NPC33,@NPC34,@NPC35,@NPC36,@NPC37,@NPC38,@NPC39,@NPC40,@NPC41,@NPC42,@NPC43,@NPC44,@NPC45,@NPC46,@NPC47,@NPC48,@NPC49,@NPC50,@NPC51,@NPC52);
INSERT INTO `pickpocketing_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
-- -----------------------------------------------------------------------------------------------
(@NPC,1,100,1,0,-@GORLOCREF,1), -- Gorloc ref loot template on Gorloc Gibberer
(@NPC1,1,100,1,0,-@GORLOCREF,1), -- Gorloc ref loot template on Gorloc Hunter
(@NPC2,1,100,1,0,-@GORLOCREF,1), -- Gorloc ref loot template on Gorloc Steam Belcher
(@NPC3,1,100,1,0,-@GORLOCREF,1), -- Gorloc ref loot template on Gorloc Waddler
-- -----------------------------------------------------------------------------------------------
(@NPC4,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Beryl Reclaimer
(@NPC5,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Beryl Sorcerer
(@NPC6,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Beryl Treasure Hunter
(@NPC7,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Coldarra Spellbinder
(@NPC8,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Harold Lane <The Fur Baron>
(@NPC9,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on High Priest Andorath
(@NPC10,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Cultist Necrolyte
(@NPC11,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Loot Crazed Diver
(@NPC12,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Loot Crazed Hunter
(@NPC13,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Loot Crazed Poacher
(@NPC14,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Inquisitor Caleras
(@NPC15,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Karen "I Don't Caribou" the Culler
(@NPC16,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Minion of Kaw
(@NPC17,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Varidus the Flenser
(@NPC18,1,100,1,0,-@BERYLREF,1), -- Beryl ref loot template on Northsea Mercenary
-- -----------------------------------------------------------------------------------------------
(@NPC19,1,100,1,0,-@BLOODREF,1), -- Bloodspore ref loot template on Bloodspore Firestarter
(@NPC20,1,100,1,0,-@BLOODREF,1), -- Bloodspore ref loot template on Den Vermin
(@NPC21,1,100,1,0,-@BLOODREF,1), -- Bloodspore ref loot template on Bloodspore Harvester
(@NPC22,1,100,1,0,-@BLOODREF,1), -- Bloodspore ref loot template on Bloodspore Roaster
(@NPC23,1,100,1,0,-@BLOODREF,1), -- Bloodspore ref loot template on Gammoth Tender
-- -----------------------------------------------------------------------------------------------
(@NPC24,1,100,1,0,-@CHIEFREF,1), -- Chieftian ref loot template on Chieftain Burblegobble
(@NPC25,1,100,1,0,-@CHIEFREF,1), -- Chieftian ref loot template on Gorloc Dredger
(@NPC26,1,100,1,0,-@CHIEFREF,1), -- Chieftian ref loot template on Chieftain GurgleBoggle
(@NPC27,1,100,1,0,-@CHIEFREF,1), -- Chieftian ref loot template on Gorloc Mud Splasher
(@NPC28,1,100,1,0,-@CHIEFREF,1), -- Chieftian ref loot template on Riplash Myrmidon
-- -----------------------------------------------------------------------------------------------
(@NPC29,1,100,1,0,-@CULTREF,1), -- Cultist ref loot template on Clandestine Cultist <Cult of the Damned>
(@NPC30,1,100,1,0,-@CULTREF,1), -- Cultist ref loot template on En'kilah Necrolord <Cult of the Damned>
(@NPC31,1,100,1,0,-@CULTREF,1), -- Cultist ref loot template on En'kilah Necromancer <Cult of the Damned>
(@NPC32,1,100,1,0,-@CULTREF,1), -- Cultist ref loot template on Northsea Thug
-- -----------------------------------------------------------------------------------------------
(@NPC33,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Kvaldir Mist Lord
(@NPC34,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Kvaldir Mistweaver
(@NPC35,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Kvaldir Raider
(@NPC36,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Heigarr the Horrible
(@NPC37,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Ragnar Drakkarlund
(@NPC37,35774,-100,1,0,1,1), -- Trident of Naz'jan on Ragnar Drakkarlund 
(@NPC38,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Skadir Longboatsman
(@NPC39,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Skadir Mistweaver
(@NPC40,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Skadir Raider
(@NPC41,1,100,1,0,-@KVALDIRREF,1), -- Kvaldir ref loot template on Skadir Runecaster
-- -----------------------------------------------------------------------------------------------
(@NPC42,1,100,1,0,-@CLAXREF,1), -- Clax ref loot template on Claximus
(@NPC43,1,100,1,0,-@CLAXREF,1), -- Clax ref loot template on Keymaster Urmgrgl
(@NPC44,1,100,1,0,-@CLAXREF,1), -- Clax ref loot template on Winterfin Oracle
(@NPC45,1,100,1,0,-@CLAXREF,1), -- Clax ref loot template on Winterfin Shorestriker
(@NPC46,1,100,1,0,-@CLAXREF,1), -- Clax ref loot template on Winterfin Warrior
-- -----------------------------------------------------------------------------------------------
(@NPC47,1,100,1,0,-@MAGMOTHREF,1), -- Magmoth2 ref loot template on Gammothra the Tormentor
(@NPC48,1,100,1,0,-@MAGMOTHREF,1), -- Magmoth ref loot template on Magnataur Huntress <Mate of Gammothra>
(@NPC49,1,100,1,0,-@MAGMOTHREF,1), -- Magmoth ref loot template on Mate of Magmothregar
(@NPC50,1,100,1,0,-@MAGMOTHREF,1), -- Magmoth ref loot template on Offspring of Magmothregar
(@NPC51,1,100,1,0,-@MAGMOTHREF,1), -- Magmoth ref loot template on Plagued Magnataur
(@NPC52,1,100,1,0,-@MAGMOTHREF,1); -- Magmoth ref loot template on Skadir Mariner
-- fix DB-error on startup
DELETE FROM `creature_loot_template` WHERE `entry` IN (34965,34980); 
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1603019 AND -1603000;
UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName` IN ('boss_algalon','mob_collapsing_star');

-- Difficulty linking
UPDATE `creature_template` SET `difficulty_entry_1`=34296 WHERE `entry`=32953; -- Black Hole

UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`faction_A`=35,`faction_H`=35,`unit_flags`=0x8300,`equipment_id`=2478 WHERE `entry`=34064; -- Brann Bronzebeard
UPDATE `creature_template` SET `speed_walk`=4,`speed_run`=2.14286,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=190,`faction_H`=190,`unit_flags`=0x8100,`BaseAttackTime`=1000,`equipment_id`=2479 WHERE `entry` IN (32871,33070); -- Algalon the Observer
UPDATE `creature_template` SET `faction_A`=190,`faction_H`=190,`exp`=2,`minlevel`=83,`maxlevel`=83,`unit_flags`=0x2000000,`speed_run`=1,`InhabitType`=4 WHERE `entry`=34246; -- Azeroth
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`minlevel`=74,`maxlevel`=74,`unit_flags`=0x2000000,`flags_extra`=0x80,`InhabitType`=4 WHERE `entry`=33086; -- Algalon Stalker
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`unit_flags`=0x2008000,`speed_run`=1,`equipment_id`=2480,`InhabitType`=4 WHERE `entry` IN (33052,33116); -- Living Constellation
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`speed_run`=1,`RegenHealth`=0 WHERE `entry` IN (32955,34215); -- Collapsing Star
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`minlevel`=80,`maxlevel`=80,`unit_flags`=0x2000000,`speed_run`=1,`InhabitType`=4 WHERE `entry` IN (32953,34296); -- Black Hole
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`minlevel`=81,`maxlevel`=81,`unit_flags`=0x8000,`speed_walk`=4,`speed_run`=1.42857,`InhabitType`=4 WHERE `entry` IN(33089,34097,34221,34222); -- Dark Matter
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`unit_flags`=0x2000000,`flags_extra`=0x80 WHERE `entry`=34100; -- Algalon Void Zone Visual Stalker
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`unit_flags`=0x2000000,`speed_run`=1,`InhabitType`=4 WHERE `entry`=34099; -- Worm Hole
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`minlevel`=74,`maxlevel`=74,`unit_flags`=0x2000000,`flags_extra`=0x80,`InhabitType`=4 WHERE `entry`=33104; -- Algalon Stalker Asteroid Target 01
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`minlevel`=74,`maxlevel`=74,`unit_flags`=0x2000000,`flags_extra`=0x80,`InhabitType`=4 WHERE `entry`=33105; -- Algalon Stalker Asteroid Target 02

UPDATE `creature_model_info` SET `bounding_radius`=0.93,`combat_reach`=9,`gender`=0 WHERE `modelid`=28641; -- Algalon the Observer
UPDATE `creature_model_info` SET `bounding_radius`=0.02,`combat_reach`=0.2,`gender`=2 WHERE `modelid`=29133; -- Azeroth
UPDATE `creature_model_info` SET `bounding_radius`=0.62,`combat_reach`=0,`gender`=2 WHERE `modelid`=28741; -- Living Constellation
UPDATE `creature_model_info` SET `bounding_radius`=1,`combat_reach`=1,`gender`=2 WHERE `modelid`=28988; -- Collapsing Star
UPDATE `creature_model_info` SET `bounding_radius`=1,`combat_reach`=1,`gender`=2 WHERE `modelid`=28460; -- Black Hole

UPDATE `gameobject_template` SET `faction`=114,`flags`=32 WHERE `entry`=194910; -- Doodad_UL_SigilDoor_03
UPDATE `gameobject_template` SET `data0`=579 WHERE `entry`=194628; -- Celestial Planetarium Access

UPDATE `creature_template` SET `ScriptName`='boss_algalon_the_observer' WHERE `entry`=32871; -- Algalon the Observer
UPDATE `creature_template` SET `ScriptName`='npc_living_constellation' WHERE `entry`=33052; -- Living Constellation
UPDATE `creature_template` SET `ScriptName`='npc_collapsing_star' WHERE `entry`=32955; -- Collapsing Star
UPDATE `creature_template` SET `ScriptName`='npc_brann_bronzebeard_algalon' WHERE `entry`=34064; -- Brann Bronzebeard
UPDATE `gameobject_template` SET `ScriptName`='go_celestial_planetarium_access' WHERE `entry` IN (194628,194752); -- Celestial Planetarium Access
UPDATE `creature_template` SET `AIName`='NullCreatureAI' WHERE `entry` IN (32953,34099); -- Black Hole

DELETE FROM `creature` WHERE `guid` IN (41781,41783,41790,41811,41812,41814,41819,41820,41821,41822,41823,41875);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`MovementType`) VALUES
(41781,33086,603,3,1,1627.400,-339.4133,417.4044,1.378810,7200,0,0), -- Algalon Stalker
(41783,33086,603,3,1,1622.681,-344.2576,417.3955,1.378810,7200,0,0), -- Algalon Stalker
(41790,33086,603,3,1,1629.984,-271.4798,417.4045,4.782202,7200,0,0), -- Algalon Stalker
(41811,33086,603,3,1,1630.005,-345.5189,417.3955,1.378810,7200,0,0), -- Algalon Stalker
(41812,33089,603,3,16,1622.451,-321.1563,417.6188,4.677482,7200,20,1), -- Dark Matter
(41814,33089,603,3,16,1649.438,-319.8127,418.3941,1.082104,7200,20,1), -- Dark Matter
(41819,33089,603,3,16,1615.060,-291.6816,417.7796,3.490659,7200,20,1), -- Dark Matter
(41820,33089,603,3,16,1647.005,-288.6790,417.3955,3.490659,7200,20,1), -- Dark Matter
(41821,33089,603,3,16,1622.451,-321.1563,417.6188,4.677482,7200,20,1), -- Dark Matter
(41822,33089,603,3,16,1649.438,-319.8127,418.3941,1.082104,7200,20,1), -- Dark Matter
(41823,33089,603,3,16,1615.060,-291.6816,417.7796,3.490659,7200,20,1), -- Dark Matter
(41875,33089,603,3,16,1647.005,-288.6790,417.3955,3.490659,7200,20,1); -- Dark Matter

SET @OGUID := 252;
DELETE FROM `gameobject` WHERE `id` IN (194767,194910,194911,194715,194716,194148,194253,194628,194752,194821,194822);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@OGUID+00,194767,603,3,17,1632.024,-182.9211,427.6681,0.000000,0,0,8.742278E-08,1, 604800,255,1), -- Doodad_UL_SigilDoor_01
(@OGUID+04,194911,603,3,17,1632.024,-182.9211,408.4224,3.141593,0,0,8.742278E-08,1, 604800,255,1), -- Doodad_UL_SigilDoor_02
(@OGUID+10,194910,603,3,17,1632.053,-266.1495,438.5608,0.000000,0,0,8.742278E-08,1, 604800,255,0), -- Doodad_UL_SigilDoor_03
(@OGUID+12,194715,603,3,17,1632.053,-307.6541,417.3211,0.000000,0,0,8.742278E-08,1, 604800,255,0), -- Doodad_UL_UniverseFloor_01
(@OGUID+19,194716,603,3,17,1632.251,-307.5483,416.2641,0.000000,0,0,8.742278E-08,1, 604800,255,1), -- Doodad_UL_UniverseFloor_02
(@OGUID+22,194148,603,3,17,1632.053,-307.6541,417.3211,0.000000,0,0,8.742278E-08,1, 604800,255,1), -- Doodad_UL_UniverseGlobe01
(@OGUID+24,194253,603,3,17,1631.908,-246.4970,417.3211,0.000000,0,0,8.742278E-08,1, 604800,255,1), -- Doodad_UL_Ulduar_Trapdoor_03
(@OGUID+29,194628,603,1, 1,1646.182,-174.6881,427.2536,1.553341,0,0,0.000000E-00,1, 604800,255,1), -- Celestial Planetarium Access
(@OGUID+33,194752,603,2, 1,1646.182,-174.6881,427.2536,1.553341,0,0,0.000000E-00,1, 604800,255,1), -- Celestial Planetarium Access
(@OGUID+37,194821,603,1, 1,1632.099,-306.5609,417.3210,4.694937,0,0,0.000000E-00,1,-604800,255,1), -- Gift of the Observer (10 man)
(@OGUID+46,194822,603,2, 1,1632.099,-306.5609,417.3210,4.694937,0,0,0.000000E-00,1,-604800,255,1); -- Gift of the Observer (25 man)

DELETE FROM `creature_equip_template` WHERE `entry` IN (2478,2479,2480);
INSERT INTO `creature_equip_template` (`entry`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(2478,1903,25972,0),
(2479,45985,45985,0),
(2480,44952,0,0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (32871,33070,33052,33116,33089,34221,34097,34222,33105);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(32871,0,0x0000000,0x0,NULL), -- Algalon the Observer
(33070,0,0x0000000,0x0,NULL), -- Algalon the Observer
(33052,0,0x3000000,0x1,NULL), -- Living Constellation
(33116,0,0x3000000,0x1,NULL), -- Living Constellation
(33089,0,0x3000000,0x1,NULL), -- Dark Matter
(34221,0,0x3000000,0x1,NULL), -- Dark Matter
(34097,0,0x3000000,0x1,NULL), -- Unleashed Dark Matter
(34222,0,0x3000000,0x1,NULL), -- Unleashed Dark Matter
(33105,0,0x3000000,0x1,NULL); -- Algalon Stalker Asteroid Target 02

DELETE FROM `creature_text` WHERE `entry` IN (32871,34064);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`sound`,`emote`,`comment`) VALUES
(34064,0,0,'We did it, lads! We got here before Algalon''s arrival. Maybe we can rig the systems to interfere with his analysis--',14,15824,0,'Brann Bronzebeard - SAY_BRANN_ALGALON_INTRO_1'),
(34064,1,0,'I''ll head back to the Archivum and see if I can jam his signal. I might be able to buy us some time while you take care of him.',12,15825,0,'Brann Bronzebeard - SAY_BRANN_ALGALON_INTRO_2'),
(34064,2,0,'I know just the place. Will you be all right?',14,15823,6,'Brann Bronzebeard - SAY_BRANN_ALGALON_OUTRO'),
(32871,0,0,'Translocation complete. Commencing planetary analysis of Azeroth.',12,15405,0,'Algalon the Observer - SAY_ALGALON_INTRO_1'),
(32871,1,0,'Stand back, mortals. I''m not here to fight you.',12,15406,0,'Algalon the Observer - SAY_ALGALON_INTRO_2'),
(32871,2,0,'It is in the universe''s best interest to re-originate this planet should my analysis find systemic corruption. Do not interfere.',12,15407,0,'Algalon the Observer - SAY_ALGALON_INTRO_3'),
(32871,3,0,'Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer''s message regardless of outcome.',14,15386,0,'Algalon the Observer - SAY_ALGALON_START_TIMER'),
(32871,4,0,'See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.',14,15390,1,'Algalon the Observer - SAY_ALGALON_AGGRO'),
(32871,5,0,'The stars come to my aid!',14,15392,0,'Algalon the Observer - SAY_ALGALON_COLLAPSING_STAR'),
(32871,6,0,'%s begins to Summon Collapsing Stars!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_COLLAPSING_STAR'),
(32871,7,0,'Witness the fury of the cosmos!',14,15396,0,'Algalon the Observer - SAY_ALGALONG_BIG_BANG'),
(32871,8,0,'%s begins to cast Big Bang!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_BIG_BANG'),
(32871,9,0,'You are out of time.',14,15394,0,'Algalon the Observer - SAY_ALGALON_ASCEND'),
(32871,10,0,'%s begins to cast Cosmic Smash!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_COSMIC_SMASH'),
(32871,11,0,'Behold the tools of creation!',14,15397,0,'Algalon the Observer - SAY_ALGALON_PHASE_TWO'),
(32871,12,0,'I have seen worlds bathed in the Makers'' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?',14,15393,1,'Algalon the Observer - SAY_ALGALON_OUTRO_1'),
(32871,13,0,'Perhaps it is your imperfections... that which grants you free will... that allows you to persevere against all cosmically calculated odds. You prevail where the Titan''s own perfect creations have failed.',14,15401,1,'Algalon the Observer - SAY_ALGALON_OUTRO_2'),
(32871,14,0,'I''ve rearranged the reply code - your planet will be spared. I cannot be certain of my own calculations anymore.',14,15402,1,'Algalon the Observer - SAY_ALGALON_OUTRO_3'),
(32871,15,0,'I lack the strength to transmit the signal. You must... hurry... find a place of power... close to the skies.',14,15403,1,'Algalon the Observer - SAY_ALGALON_OUTRO_4'),
(32871,16,0,'Do not worry about my fate, Bronzen. If the signal is not transmitted in time, re-origination will proceed regardless. Save... your world...',14,15404,1,'Algalon the Observer - SAY_ALGALON_OUTRO_5'),
(32871,17,0,'Analysis complete. There is partial corruption in the planet''s life-support systems as well as complete corruption in most of the planet''s defense mechanisms.',12,15398,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_1'),
(32871,18,0,'Begin uplink: Reply Code: ''Omega''. Planetary re-origination requested.',12,15399,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_2'),
(32871,19,0,'Farewell, mortals. Your bravery is admirable, for such flawed creatures.',12,15400,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_3'),
(32871,20,0,'Loss of life unavoidable.',14,15387,0,'Algalon the Observer - SAY_ALGALON_KILL'),
(32871,20,1,'I do what I must.',14,15388,0,'Algalon the Observer - SAY_ALGALON_KILL');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (64996,62266,65509,62304,64597);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,1,64996,31,3,34246,'Algalon the Observer - Reorigination on Azeroth'),
(13,1,62266,31,3,33052,'Algalon Stalker - target Living Constellation'),
(13,1,65509,31,3,33052,'Black Hole - target Living Constellation'),
(13,1,62304,31,3,33104,'Cosmic Smash - target trigger'),
(13,1,64597,31,3,33104,'Cosmic Smash - target trigger');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_phase_punch';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_arcane_barrage';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_trigger_3_adds';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_collapse';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_big_bang';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_remove_phase';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_cosmic_smash';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_cosmic_smash_damage';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_algalon_supermassive_fail';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(64412,'spell_algalon_phase_punch'),
(64599,'spell_algalon_arcane_barrage'),
(64607,'spell_algalon_arcane_barrage'),
(62266,'spell_algalon_trigger_3_adds'),
(62018,'spell_algalon_collapse'),
(64443,'spell_algalon_big_bang'),
(64584,'spell_algalon_big_bang'),
(64445,'spell_algalon_remove_phase'),
(62295,'spell_algalon_cosmic_smash'),
(62311,'spell_algalon_cosmic_smash_damage'),
(64596,'spell_algalon_cosmic_smash_damage'),
(65311,'spell_algalon_supermassive_fail');

SET @DIFF_ID := 3262;
DELETE FROM `spelldifficulty_dbc` WHERE `id` BETWEEN @DIFF_ID AND @DIFF_ID+5;
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(@DIFF_ID+0,64395,64592),
(@DIFF_ID+1,64599,64607),
(@DIFF_ID+2,64443,64584),
(@DIFF_ID+3,64122,65108),
(@DIFF_ID+4,62301,64598),
(@DIFF_ID+5,62304,64597);

UPDATE `instance_encounters` SET `creditType`=1,`creditEntry`=65184 WHERE `entry` IN (757,771); -- Algalon the Observer

DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (10565,10566,10678,9990,9991,10567,10569,10698,10780,10781,10782,10783,10568,10570);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10565,10566,10678,9990,9991,10567,10569,10698,10780,10781,10782,10783,10568,10570);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(10565,12,0,0,''), -- Algalon the Observer kills (Ulduar 10 player)
(10566,12,1,0,''), -- Algalon the Observer kills (Ulduar 25 player)
(10678,12,0,0,''), -- Herald of the Titans
(10678,18,0,0,''), -- Herald of the Titans
(9990,12,0,0,''), -- Lich King 10-player bosses killed
(9991,12,1,0,''), -- Lich King 25-player bosses killed
(10567,12,0,0,''), -- Observed (10 player)
(10569,12,1,0,''), -- Observed (25 player)
(10698,12,1,0,''), -- Realm First! Celestial Defender
(10780,12,0,0,''), -- Supermassive (10 player)
(10781,12,0,0,''), -- Supermassive (10 player)
(10782,12,1,0,''), -- Supermassive (25 player)
(10783,12,1,0,''), -- Supermassive (25 player)
(10568,11,0,0,'achievement_he_feeds_on_your_tears'), -- He Feeds On Your Tears (10 player)
(10568,12,0,0,''), -- He Feeds On Your Tears (10 player)
(10570,11,0,0,'achievement_he_feeds_on_your_tears'), -- He Feeds On Your Tears (25 player)
(10570,12,1,0,''); -- He Feeds On Your Tears (25 player)
SET @Ref := 12002; 
DELETE FROM `reference_loot_template` WHERE `entry`=@Ref;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Ref,47242,100,1,0,1,1);
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (195668,195667,195666,195665,195672,195671,195670,195669) AND `item`=47242;
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (195668,195667,195666,195665,195672,195671,195670,195669) AND `mincountOrRef` = -@Ref;
INSERT INTO gameobject_loot_template (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(195665,5,100,1,0,-@Ref,4), -- 10 man,50 attempts
(195666,3,100,1,0,-@Ref,4), -- 10 man,45+ attempts
(195667,3,100,1,0,-@Ref,2), -- 10 man,25+ attempts
(195668,1,100,1,0,-@Ref,2), -- 10 man,0+ attempts
(195669,6,100,1,0,-@Ref,4), -- 25 man,50 attempts
(195670,4,100,1,0,-@Ref,4), -- 25 man,45+ attempts
(195671,4,100,1,0,-@Ref,2), -- 25 man,25+ attempts
(195672,2,100,1,0,-@Ref,2); -- 25 man,0+ attempts
SET @Bag := 52676;
DELETE FROM `item_loot_template` WHERE `entry`=@Bag;
INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Bag,36933,0,1,1,1,3),-- Forest Emerald
(@Bag,36918,0,1,1,1,3),-- Scarlet Ruby
(@Bag,36921,0,1,1,1,3),-- Autumn's Glow
(@Bag,36930,0,1,1,1,3),-- Monarch Topaz
(@Bag,36924,0,1,1,1,3),-- Sky Sapphire
(@Bag,36927,0,1,1,1,3),-- Twilight Opal
(@Bag,43953,5,1,0,1,1); -- Reins of the Blue Drake
DELETE FROM `creature_loot_template` WHERE `entry` IN (31702,32297) AND `item`=44564;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(31702,44564,0.5,1,0,1,1), -- Recipe: Mighty Arcane Protection Potion on Frostbrood Spawn
(32297,44564,0.5,1,0,1,1); -- Recipe: Mighty Arcane Protection Potion on Cult Researcher
SET @ITEM := 50406; -- Formula: Enchant Gloves - Angler
UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` IN(26343,26344,26336);
DELETE FROM `creature_loot_template` WHERE `item`=@ITEM;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(26343, @ITEM, 1.1, 1, 0, 1, 1), -- Indu'Le Fisherman
(26336, @ITEM, 0.9, 1, 0, 1, 1), -- Indu'Le Mystic
(26344, @ITEM, 1, 1, 0, 1, 1); -- Indu'Le Warrior
-- Make Grimscale Murlocs drop their heads faster...
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-66 WHERE `item`=21757; 

-- Restore horrible mistake in UP34 from myself
UPDATE `gameobject_template` SET `data1`=27512 WHERE `entry`=195669;
UPDATE `gameobject_template` SET `data1`=27517 WHERE `entry`=195670;
UPDATE `gameobject_template` SET `data1`=27518 WHERE `entry`=195671;
-- Fix loottemplates along with it
UPDATE `gameobject_loot_template` SET `entry`=27512 WHERE `entry`=195669;
UPDATE `gameobject_loot_template` SET `entry`=27517 WHERE `entry`=195670;
UPDATE `gameobject_loot_template` SET `entry`=27518 WHERE `entry`=195671;
DELETE FROM `spell_script_names` WHERE `spell_id` IN (20625,29142,35139,42393,49882,55269,56578,38441,66316,67100,67101,67102);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(20625,'spell_gen_default_count_pct_from_max_hp'), -- Ritual of Doom Sacrifice
(29142,'spell_gen_default_count_pct_from_max_hp'), -- Eyesore Blaster
(35139,'spell_gen_default_count_pct_from_max_hp'), -- Throw Boom's Doom
(42393,'spell_gen_default_count_pct_from_max_hp'), -- Brewfest - Attack Keg
(49882,'spell_gen_default_count_pct_from_max_hp'), -- Leviroth Self-Impale
(55269,'spell_gen_default_count_pct_from_max_hp'), -- Deathly Stare
(56578,'spell_gen_default_count_pct_from_max_hp'), -- Rapid-Fire Harpoon
(38441,'spell_gen_50pct_count_pct_from_max_hp'), -- Cataclysmic Bolt
(66316,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 10m
(67100,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 25m
(67101,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 10m heroic
(67102,'spell_gen_50pct_count_pct_from_max_hp'); -- Spinning Pain Spike 25m heroic
-- SAI for Tabard Vendor Elizabeth Ross
SET @ROSS := 28776;
SET @GOSSIP := 9832;

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ROSS;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP AND `id`>0 AND `id`<11;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES 
(@GOSSIP, 1, 0, 'I''ve lost my Blood Knight Tabard.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 2, 0, 'I''ve lost my Tabard of the Hand.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 3, 0, 'I''ve lost my Tabard of the Protector.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 4, 0, 'I''ve lost my Green Trophy Tabard of the Illidari.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 5, 0, 'I''ve lost my Purple Trophy Tabard of the Illidari.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 6, 0, 'I''ve lost my Tabard of Summer Skies.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 7, 0, 'I''ve lost my Tabard of Summer Flames.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 8, 0, 'I''ve lost my Loremaster''s Colors.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 9, 0, 'I''ve lost my Tabard of the Explorer.', 1, 1, 0, 0, 0, 0, ''),
(@GOSSIP, 10, 0, 'I''ve lost my Tabard of the Achiever.', 1, 1, 0, 0, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ROSS AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ROSS, 0, 0, 10, 62, 0, 100, 0, @GOSSIP, 1, 0, 0, 11, 54974, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Blood Knight Tabard'),
(@ROSS, 0, 1, 10, 62, 0, 100, 0, @GOSSIP, 2, 0, 0, 11, 54976, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of the Hand'),
(@ROSS, 0, 2, 10, 62, 0, 100, 0, @GOSSIP, 3, 0, 0, 11, 55008, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of the Protector'),
(@ROSS, 0, 3, 10, 62, 0, 100, 0, @GOSSIP, 4, 0, 0, 11, 54977, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Green Trophy Tabard of the Illidari'),
(@ROSS, 0, 4, 10, 62, 0, 100, 0, @GOSSIP, 5, 0, 0, 11, 54982, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Purple Trophy Tabard of the Illidari'),
(@ROSS, 0, 5, 10, 62, 0, 100, 0, @GOSSIP, 6, 0, 0, 11, 62768, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of Summer Skies'),
(@ROSS, 0, 6, 10, 62, 0, 100, 0, @GOSSIP, 7, 0, 0, 11, 62769, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of Summer Flames'),
(@ROSS, 0, 7, 10, 62, 0, 100, 0, @GOSSIP, 8, 0, 0, 11, 58194, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Loremaster''s Colors'),
(@ROSS, 0, 8, 10, 62, 0, 100, 0, @GOSSIP, 9, 0, 0, 11, 58224, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of the Explorer'),
(@ROSS, 0, 9, 10, 62, 0, 100, 0, @GOSSIP, 10, 0, 0, 11, 55006, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Cast Spell Create Tabard of the Achiever'),
(@ROSS, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Select - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,1,0,2,25549,1,1,1,0,'','Only show gossip if player doesn''t have Blood Knight Tabard'),
(15,@GOSSIP,1,0,8,9737,0,0,0,0,'','Only show gossip if player already finished quest True Masters of Light'),
(15,@GOSSIP,2,0,2,24344,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of the Hand'),
(15,@GOSSIP,2,0,8,9762,0,0,0,0,'','Only show gossip if player already finished quest The Unwritten Prophecy'),
(15,@GOSSIP,3,0,2,28788,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of the protector'),
(15,@GOSSIP,3,0,8,10259,0,0,0,0,'','Only show gossip if player already finished quest Into the Breach'),
(15,@GOSSIP,4,0,2,31404,1,1,1,0,'','Only show gossip if player doesn''t have Green Trophy Tabard of Illidari'),
(15,@GOSSIP,4,0,2,31405,1,1,1,0,'','Only show gossip if player doesn''t have Purple Trophy Tabard of Illidari'),
(15,@GOSSIP,4,0,2,31408,1,1,1,0,'','Only show gossip if player doesn''t have Offering of the Sha''tar'),
(15,@GOSSIP,4,0,8,10781,0,0,0,0,'','Only show gossip if player already finished quest Battle of the Crimson Watch'),
(15,@GOSSIP,5,0,2,31404,1,1,1,0,'','Only show gossip if player doesn''t have Green Trophy Tabard of Illidari'),
(15,@GOSSIP,5,0,2,31405,1,1,1,0,'','Only show gossip if player doesn''t have Purple Trophy Tabard of Illidari'),
(15,@GOSSIP,5,0,2,31408,1,1,1,0,'','Only show gossip if player doesn''t have Offering of the Sha''tar'),
(15,@GOSSIP,5,0,8,10781,0,0,0,0,'','Only show gossip if player already finished quest Battle of the Crimson Watch'),
(15,@GOSSIP,6,0,2,35279,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of Summer Skies'),
(15,@GOSSIP,6,0,2,35280,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of Summer Flames'),
(15,@GOSSIP,6,0,8,11972,0,0,0,0,'','Only show gossip if player already finished quest Shards of Ahune'),
(15,@GOSSIP,7,0,2,35279,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of Summer Skies'),
(15,@GOSSIP,7,0,2,35280,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of Summer Flames'),
(15,@GOSSIP,7,0,8,11972,0,0,0,0,'','Only show gossip if player already finished quest Shards of Ahune'),
(15,@GOSSIP,8,0,2,43300,1,1,1,0,'','Only show gossip if player doesn''t have Loremaster''s Colors'),
(15,@GOSSIP,8,0,17,1681,0,0,0,0,'','Only show gossip if player have achievement Loremaster (A)'),
(15,@GOSSIP,8,1,2,43300,1,1,1,0,'','Only show gossip if player doesn''t have Loremaster''s Colors'),
(15,@GOSSIP,8,1,17,1682,0,0,0,0,'','Only show gossip if player have achievement Loremaster (H)'),
(15,@GOSSIP,9,0,2,43348,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of the Explorer'),
(15,@GOSSIP,9,0,17,45,0,0,0,0,'','Only show gossip if player have achievement Explore Northrend'),
(15,@GOSSIP,10,0,2,40643,1,1,1,0,'','Only show gossip if player doesn''t have Tabard of the Explorer'),
(15,@GOSSIP,10,0,17,1021,0,0,0,0,'','Only show gossip if player have achievement Twenty-Five Tabards');
UPDATE `creature_template` SET `flags_extra`=0x82,`ModelId1`=1126,`ModelId2`=16925 WHERE `entry` IN (38008,38641,38773,38774); -- Blood Orb Controller
UPDATE `creature_template` SET `flags_extra`=0x80,`ModelId1`=19725,`ModelId2`=31095,`baseattacktime`=2000,`speed_walk`=0.8,`speed_run`=0.28571 WHERE `entry` IN (38454,38775,38776,38777); -- Kinetic Bomb
UPDATE `creature_template` SET `exp`=2,`baseattacktime`=2000,`ModelId1`=19725,`ModelId2`=21342 WHERE `entry`=38458; -- Kinetic Bomb Target
UPDATE `creature_template` SET `baseattacktime`=2000,`speed_walk`=4.4,`ModelId1`=19725,`ModelId2`=26767 WHERE `entry` IN (38332,38451); -- Ball of Flame
UPDATE `creature_template` SET `flags_extra`=0x80 WHERE `entry`=37950; -- Valithria Dreamwalker
UPDATE `creature_template` SET `InhabitType`=4 WHERE `InhabitType`&4 AND `flags_extra`&0x80; -- make flying triggers fly
UPDATE `creature_template` SET `InhabitType`=4,`HoverHeight`=12 WHERE `entry`=37126; -- Sister Svalna
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=37950; -- Valithria Dreamwalker
UPDATE `creature_model_info` SET `bounding_radius`=1,`combat_reach`=0,`gender`=0 WHERE `modelid`=31095; -- Kinetic Bomb
UPDATE `creature_model_info` SET `bounding_radius`=0.5,`combat_reach`=1,`gender`=0 WHERE `modelid`=21342; -- Kinetic Bomb Target
UPDATE `creature_model_info` SET `bounding_radius`=0.5,`combat_reach`=1,`gender`=0 WHERE `modelid`=26767; -- Ball of Flame
UPDATE `creature_template_addon` SET `bytes1`=50331648,`bytes2`=1,`mount`=0,`emote`=0,`auras`=NULL WHERE `entry`=38454; -- Kinetic Bomb
-- setup alternate conditions for spell 46488
DELETE FROM `conditions` WHERE `SourceEntry` = 46488 AND `ElseGroup` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,46488,0,1,31,1,3,26817,0,0,0,'',''),
(13,1,46488,0,1,36,1,0,0,0,1,0,'','');
SET @TinRef := 13000; 
SET @TBC1 := @TinRef+1;
SET @TBC2 := @TinRef+2;
SET @WOTLK1 := @TinRef+3;
SET @WOTLK2 := @TinRef+4;
SET @WOTLK3 := @TinRef+5;

SET @Copper := 2770;
SET @Tin := 2771;
SET @Iron := 2772; 
SET @Mithril := 3858;
SET @Thorium := 10620;
SET @FelIron := 23424; 
SET @Adamantite := 23425; 
SET @Cobalt := 36909; 
SET @Saronite := 36912;
SET @Titanium := 36910;

-- Reference Loot Templates
DELETE FROM `reference_loot_template` WHERE `entry` BETWEEN @TinRef AND @TinRef+5;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
-- Stupid Tin
(@TinRef,1529,0,1,1,1,1),  -- Jade
(@TinRef,3864,0,1,1,1,1),  -- Citrine
(@TinRef,7909,0,1,1,1,1),  -- Aquamarine
-- TBC Greens
(@TBC1,21929,0,1,1,1,2), -- Flame Spessarite
(@TBC1,23077,0,1,1,1,2), -- Blood Garnet
(@TBC1,23079,0,1,1,1,2), -- Deep Peridot
(@TBC1,23107,0,1,1,1,2), -- Shadow Draenite
(@TBC1,23112,0,1,1,1,2), -- Golden Draenite
(@TBC1,23117,0,1,1,1,2), -- Azure Moonstone
-- TBC Blues
(@TBC2,23436,0,1,1,1,1), -- Living Ruby
(@TBC2,23437,0,1,1,1,1), -- Talasite
(@TBC2,23438,0,1,1,1,1), -- Star of Elune
(@TBC2,23439,0,1,1,1,1), -- Noble Topaz
(@TBC2,23440,0,1,1,1,1), -- Dawnstone 
(@TBC2,23441,0,1,1,1,1), -- Nightseye
-- WOTLK Greens
(@WOTLK1,36917,0,1,1,1,2), -- Bloodstone
(@WOTLK1,36920,0,1,1,1,2), -- Sun Crystal
(@WOTLK1,36923,0,1,1,1,2), -- Chalcedony
(@WOTLK1,36926,0,1,1,1,2), -- Shadow Crystal
(@WOTLK1,36929,0,1,1,1,2), -- Huge Citrine
(@WOTLK1,36932,0,1,1,1,2), -- Dark Jade
-- WOTLK Blues
(@WOTLK2,36918,0,1,1,1,2), -- Scarlet Ruby
(@WOTLK2,36921,0,1,1,1,2), -- Autumn's Glow
(@WOTLK2,36924,0,1,1,1,2), -- Sky Sapphire
(@WOTLK2,36927,0,1,1,1,2), -- Twilight Opal
(@WOTLK2,36930,0,1,1,1,2), -- Monarch Topaz
(@WOTLK2,36933,0,1,1,1,2), -- Forest Emerald
-- WOTLK Epics
(@WOTLK3,36919,0,1,1,1,1), -- Cardinal Ruby
(@WOTLK3,36922,0,1,1,1,1), -- King's Amber
(@WOTLK3,36925,0,1,1,1,1), -- Majestic Zircon
(@WOTLK3,36928,0,1,1,1,1), -- Dreadstone
(@WOTLK3,36931,0,1,1,1,1), -- Ametrine
(@WOTLK3,36934,0,1,1,1,1); -- Eye of Zul
-- --------------------------------------------------------
-- Prospecting Loot Templates
DELETE FROM `prospecting_loot_template` WHERE `entry` IN (@Copper,@Tin,@Iron,@Mithril,@Thorium,@FelIron,@Adamantite,@Cobalt,@Saronite,@Titanium);
INSERT INTO `prospecting_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
-- Copper Ore
(@Copper,774,0,1,1,1,1), -- Malachite
(@Copper,818,0,1,1,1,1), -- Tigerseye
(@Copper,1210,10,1,0,1,1), -- Shadowgem
-- Tin Ore
(@Tin,1210,0,1,1,1,2),  -- Shadowgem
(@Tin,1705,0,1,1,1,2),  -- Lesser Moonstone
(@Tin,1206,0,1,1,1,2), -- Moss Agate
(@Tin,1,10,1,0,-@TinRef,1), -- One Rare gem chance
-- Iron Ore
(@Iron,1529,30,1,1,1,2), -- Jade
(@Iron,1705,30,1,1,1,2), -- Lesser Moonstone
(@Iron,3864,30,1,1,1,2), -- Citrine
(@Iron,7909,5,1,1,1,1), -- Aquamarine
(@Iron,7910,5,1,1,1,1), -- Star Ruby
-- Mithril Ore
(@Mithril,3864,30,1,1,1,2), -- Citrine
(@Mithril,7909,30,1,1,1,2), -- Aquamarine
(@Mithril,7910,30,1,1,1,2), -- Star Ruby
(@Mithril,12361,2.5,1,1,1,1), -- Blue Sapphire
(@Mithril,12364,2.5,1,1,1,1), -- Huge Emerald
(@Mithril,12799,2.5,1,1,1,1), -- Large Opal
(@Mithril,12800,2.5,1,1,1,1), -- Azerothian Diamond
-- Thorium Ore
(@Thorium,7910,30,1,1,1,2), -- Star Ruby
(@Thorium,12361,15,1,1,1,2), -- Blue Sapphire
(@Thorium,12364,15,1,1,1,2), -- Huge Emerald
(@Thorium,12799,15,1,1,1,2), -- Large Opal
(@Thorium,12800,15,1,1,1,2), -- Azerothian Diamond
(@Thorium,1,10,1,1,-@TBC1,1), -- one from TBC Greens
-- Fel Iron Ore
(@FelIron,1,95,1,1,-@TBC1,1), -- One from TBC Greens
(@FelIron,2,05,1,1,-@TBC2,1), -- One from TBC Blues
-- Adamantite Ore
(@Adamantite,24243,100,1,0,1,1), -- Adamantite Powder
(@Adamantite,1,100,1,1,-@TBC1,1), -- One from TBC Greens
(@Adamantite,2, 10,1,1,-@TBC2,1), -- One from TBC Blues
-- Cobalt Ore
(@Cobalt,1,95,1,1,-@WOTLK1,1), -- One from WOTLK Greens
(@Cobalt,2,05,1,1,-@WOTLK2,1), -- One from WOTLK Blues
-- Saronite Ore
(@Saronite,1,85,1,1,-@WOTLK1,2), -- One from WOTLK Greens
(@Saronite,2,15,1,1,-@WOTLK2,1), -- One from WOTLK Blues
-- Titanium Ore
(@Titanium,46849,75,1,0,1,1), -- Titanium Powder
(@Titanium,1,75,1,1,-@WOTLK1,2), -- Two from WOTLK Greens
(@Titanium,2,25,1,1,-@WOTLK2,1), -- One from WOTLK Blues
(@Titanium,3,20,1,0,-@WOTLK3,1); -- One from WOTLK Epics
UPDATE `creature_template` SET `skinloot`=entry WHERE `entry` IN (30260, 32517, 27641, 28860);
UPDATE `creature_template` SET `skinloot`=70202 WHERE `entry` IN (25774,29693);
UPDATE `creature_template` SET `skinloot`=70203 WHERE `entry`=28257;
UPDATE `creature_template` SET `skinloot`=70207 WHERE `entry`=34137;
UPDATE `creature_template` SET `skinloot`=70208 WHERE `entry` IN (32572,25448,25716,25713);
UPDATE `creature_template` SET `skinloot`=70210 WHERE `entry` IN (33528,40419,26723,31134,36891);
UPDATE `creature_template` SET `skinloot`=70211 WHERE `entry` IN (28847,30206,29875,29931,28203,30432);
UPDATE `creature_template` SET `skinloot`=70212 WHERE `entry` IN (27645,32377,29838,26628,26622,32490,38453,32485,26633,32400,32361,29768,29735,26641,27644,27642,26735,26730,26722,33776,35189,26716,26672,29664,29774);
UPDATE `creature_template` SET `skinloot`=70213 WHERE `entry` IN (27483,29312);
UPDATE `creature_template` SET `skinloot`=70214 WHERE `entry` IN (37217,34564);
UPDATE `creature_template` SET `skinloot`=27641 WHERE `entry` IN (31385,34269,34270,27641,30905,30353);

DELETE FROM `skinning_loot_template` WHERE entry IN (30260,32517,70212,70213,70214,28860,27641);
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
-- Stoic Mammoth
(30260,33568,100,0,1,3), -- Borean Leather
(30260,42542,-50,0,1,1), -- Stoic Mammoth Hide
-- Loque'nahak
(32517,33568,0,1,1,3), -- Borean Leather
(32517,44128,2,1,1,1), -- Arctic Fur
(32517,44687,100,0,1,1), -- Loque'Nahak's Pelt
-- skinloot 70212
(70212,33568,0,1,1,3), -- Borean Leather
(70212,44128,1,1,1,1), -- Arctic Fur
-- skinloot 70213
(70213,33568,0,1,5,12), -- Borean Leather
(70213,44128,1,1,1,1), -- Arctic Fur
-- skinloot 70214
(70214,33568,0,1,12,16), -- Borean Leather
(70214,44128,25,1,1,1), -- Arctic Fur
-- Sartharion
(28860,33568,0,1,8,12), -- Borean Leather
(28860,38557,0,1,8,12),-- Icy Dragonscale
(28860,44128,1,1,1,1), -- Arctic Fur
--  Centrifuge Construct
(27641,41337,85,0,1,3), -- Whizzed-Out Gizmo
(27641,41338,80,0,1,3), -- Sprung Whirlygig
(27641,39690,15,0,1,3), -- Volatile Blasting Trigger
(27641,39684,8,0,1,1), -- Hair Trigger
(27641,36813,8,0,1,3), -- Sprung Sprocket
(27641,39681,8,0,2,4), -- Handful of Cobalt Bolts
(27641,49050,2,0,1,1), -- Schematic: Jeeves
(27641,39682,1,0,1,1), -- Overcharged Capacitor
(27641,39685,1,0,1,1); -- Indestructible Frame
-- Correct dropchance for Mote of Life, wowhead was wrong (as usual)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=18.5307 WHERE `entry`=22307 AND `item`=22575;
-- Update the dropchance to 100% if on quest
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=21477 AND `item`=31372; -- Rocknail Flayer Carcass
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=21478 AND `item`=31373; -- Rocknail Flayer Giblets
DELETE FROM `command` WHERE `name` IN ('modify tp','modify bwalk','modify swim','modify fly','modify arena','modify aspeed','modify morph');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('modify speed all', 1, 'Syntax: .modify aspeed #rate\r\n\r\nModify all speeds -run,swim,run back,swim back- of the selected player to "normalbase speed for this move type"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify speed backwalk', 1, 'Syntax: .modify speed backwalk #rate\r\n\r\nModify the speed of the selected player while running backwards to "normal walk back speed"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify speed fly', 1, '.modify speed fly #rate\nModify the flying speed of the selected player to "normal flying speed"*rate. If no player is selected, modify your speed.\n #rate may range from 0.1 to 50.'),
('modify speed swim', 1, 'Syntax: .modify speed swim #rate\r\n\r\nModify the swim speed of the selected player to "normal swim speed"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify speed walk', 1, 'Syntax: .modify speed bwalk #rate\r\n\r\nModify the speed of the selected player while running to "normal walk speed"*rate. If no player is selected, modify your speed.\r\n\r\n #rate may range from 0.1 to 50.'),
('modify talentpoints', 1, 'Syntax: .modify talentpoints #amount\r\n\r\nSet free talent points for selected character or character\'s pet. It will be reset to default expected at next levelup/login/quest reward.'),
('morph', 2, 'Syntax: .morph #displayid\r\n\r\nChange your current model id to #displayid.'),
('modify arenapoints', 1, 'Syntax: .modify arenapoints #value\r\nAdd $amount arena points to the selected player.');
UPDATE `command` SET `help`='Syntax: .modify speed $speedtype #rate\r\n\r\nModify the running speed of the selected player to "normal base run speed"= 1. If no player is selected, modify your speed.\r\n\r\n$speedtypes may be fly, all, walk, backwalk, or swim.\r\n\r\n #rate may range from 0.1 to 50.' WHERE `name`='modify speed' LIMIT 1;
-- Honor Among Thieves proc chance
UPDATE `spell_proc_event` SET `CustomChance`=33 WHERE `entry`=51698; -- Rank 1
UPDATE `spell_proc_event` SET `CustomChance`=66 WHERE `entry`=51700; -- Rank 2
UPDATE `spell_proc_event` SET `CustomChance`=100 WHERE `entry`=51701; -- Rank 3
UPDATE `warden_checks` SET `comment`='Swimming_FallCalc - movement state' WHERE `id`=15;
UPDATE `warden_checks` SET `comment`='CreateMovementStatus' WHERE `id`=72;
UPDATE `warden_checks` SET `comment`='OnStartSwim  OnSplineStartSwim - movement state' WHERE `id`=170;
UPDATE `warden_checks` SET `comment`='DefaultServerLogin - account name' WHERE `id`=198;
UPDATE `warden_checks` SET `comment`='Login Checksum - authentication process' WHERE `id`=320;
UPDATE `warden_checks` SET `comment`='CalcFallStartElevation - (some kind of wall climb)' WHERE `id`=329;
UPDATE `warden_checks` SET `comment`='Code injection at 0x40100A' WHERE `id`=381;
UPDATE `warden_checks` SET `comment`='Login State - (May be false positive)' WHERE `id`=437;
-- Earthen Power
DELETE FROM `spell_script_names` WHERE `spell_id`=59566;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(59566,'spell_sha_earthen_power');
 -- Rogue T9 2P - Should proc only from Rupture ticks.
DELETE FROM `spell_proc_event` WHERE `entry` IN(67209);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `procFlags`) VALUES 
(67209, 0x01, 8, 0x100000, 0x50000);
-- Apply same loot template to below mentioned Bloodsail NPCs as that of Bloodsail Raider 1561
-- (Mage 1562, Swashbuckler 1563, Warlock 1564, Sea Dog 1565)
UPDATE `creature_template` SET `lootid`=1561 WHERE `entry` IN (1562,1563,1564,1565);
-- Remove Loot from `creature_loot_template` for above mentioned NPCs because it contains only 2 items.
-- Those 2 items, along with complete loot template for these mobs is applied in query above.
DELETE FROM `creature_loot_template` WHERE `entry` IN (1562,1563,1564,1565);
-- Remove loot and gold drop from Bloodsail Warlock's Minions
UPDATE `creature_template` SET `lootid`=0, `mingold`=0 AND `maxgold`=0 WHERE `entry` IN (10928,12922);
DELETE FROM `creature_loot_template` WHERE `entry` IN (10928,12922);
DELETE FROM `spell_script_names` WHERE `spell_id` = 46485;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(46485,'spell_item_greatmothers_soulcatcher');

DELETE FROM `conditions` WHERE `SourceEntry` IN (46485,46488);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,46485,0,1,31,1,3,26817,0,0,0,'',''),
(13,1,46485,0,1,36,1,0,0,0,1,0,'',''),
(13,1,46488,0,1,31,1,3,26817,0,0,0,'',''),
(13,1,46488,0,1,36,1,0,0,0,1,0,'','');

-- Gnome Soul SAI
SET @ENTRY := 26096;
SET @SPELL_ARCANE_EXPLOSION := 35426;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gnome Soul - On Just Summoned - Quest Credit"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,25814,10,1,0,0,0,0,"Gnome Soul - On Just Summoned - Set Data Fizzcrank Mechagnome"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,69,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gnome Soul - On Just Summoned - Move to Summoner"),

(@ENTRY,0,3,4,34,0,100,0,1,0,0,0,11,@SPELL_ARCANE_EXPLOSION,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnome Soul - Reached Summoner - Cast Arcane Explosion Visual"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnome Soul - Reached Summoner - Forced Despawn");

-- Fizzcrank Mechagnome SAI
SET @ENTRY := 25814;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,1,10000,0,0,0,0,0,0,0,0,0,0,0,0,"Fizzcrank Mechagnome - Chance Say on Aggro"),
(@ENTRY,1,0,0,38,0,100,0,1,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Fizzcrank Mechagnome - On Data Set - Forced Despawn");
UPDATE `smart_scripts` SET `source_type`=0,`id`=1 WHERE `entryorguid`=24814 AND `source_type`=1 AND `event_type`=38;
UPDATE `conditions` SET `SourceTypeOrReferenceId`=17 WHERE `SourceEntry` IN (46485,46488);
UPDATE `conditions` SET `ElseGroup`=0 WHERE `SourceEntry` IN (46485,46488) AND `ConditionValue1`=26817;
DELETE FROM `spell_script_names` WHERE `spell_id` = 33110;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(33110,'spell_pri_prayer_of_mending_heal');DELETE FROM `spell_scripts` WHERE `id` IN (15998,25952,29435,45980,51592,51910,52267,54420);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (15998,25952,29435,45980,51592,51910,52267,54420);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(15998, 'spell_gen_despawn_self'),
(25952, 'spell_gen_despawn_self'),
(29435, 'spell_gen_despawn_self'),
(45980, 'spell_gen_despawn_self'),
(51592, 'spell_gen_despawn_self'),
(51910, 'spell_gen_despawn_self'),
(52267, 'spell_gen_despawn_self'),
(54420, 'spell_gen_despawn_self');DELETE FROM `spell_group` WHERE `id` IN (1117,1118);
INSERT INTO `spell_group` (`id`,`spell_id`) VALUES
(1117,25898),
(1117,25899),
(1118,20911),
(1118,20217);

DELETE FROM `spell_group_stack_rules` WHERE `group_id` in (1117,1118);
INSERT INTO `spell_group_stack_rules` (`group_id`,`stack_rule`) VALUES
(1117,3),
(1118,3);
UPDATE `conditions` SET `ElseGroup` = 0, `SourceGroup` = 0 WHERE `SourceEntry` IN (46485,46488);
UPDATE `smart_scripts` SET `source_type` = 0, `id` = 1 WHERE `entryorguid` = 25814 AND `source_type` = 1 AND `id` = 0;
DELETE FROM `creature_text` WHERE `entry`=37813 AND `groupid`=14;
INSERT INTO `creature_text` (`entry`,`groupid`,`text`,`type`,`comment`) VALUES (37813,14,'%s''s Blood Beasts gain the scent of blood!',41,'Deathbringer Saurfang - EMOTE_SCENT_OF_BLOOD');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72771;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,3,72771,31,3,38508,'Deathbringer Saurfang - Scent of Blood on Blood Beast');
-- The Descent into Madness
-- References
-- -------------------------------
-- -- Variables and definitions --
-- -------------------------------
-- Set References
SET @Vezax10Ref := 34373;
SET @Vezax25Ref := @Vezax10Ref+1;
SET @Yogg10Ref := @Vezax10Ref+2;
SET @Yogg25Ref := @Vezax10Ref+3;
SET @Chest := 12034;
SET @Shoulder := 12035;
SET @EmblemRef := 34349; 
SET @Recipe := 34154;
SET @Vezax10 := 33271;
SET @Vezax25 := 33449;
SET @Yogg10 := 33288;
SET @Yogg25 := 33955;

-- -------------------------
-- -- Reference Templates --
-- -------------------------
-- Delete previous templates if existing
DELETE FROM `reference_loot_template` WHERE `entry` IN (34131,34132,34133,34164,34165);
DELETE FROM `reference_loot_template` WHERE `entry` IN (@Vezax10Ref,@Vezax25Ref,@Yogg10Ref,@Yogg25Ref,@Chest,@Shoulder);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Vezax 10 man
(@Vezax10Ref,46014,0,1,1,1,1), -- Saronite Animus Cloak
(@Vezax10Ref,46008,0,1,1,1,1), -- Choker of the Abyss
(@Vezax10Ref,46010,0,1,1,1,1), -- Darkstone Ring
(@Vezax10Ref,45996,0,1,1,1,1), -- Hoperender
(@Vezax10Ref,46015,0,1,1,1,1), -- Pendant of Endless Despair
(@Vezax10Ref,46013,0,1,1,1,1), -- Underworld Mantle
(@Vezax10Ref,46012,0,1,1,1,1), -- Vestments of the Piercing Light
(@Vezax10Ref,46009,0,1,1,1,1), -- Bindings of the Depths
(@Vezax10Ref,45997,0,1,1,1,1), -- Gauntlets of the Wretched
(@Vezax10Ref,46011,0,1,1,1,1), -- Shadowbite
-- Vezax 25 man
(@Vezax25Ref,45513,0,1,1,1,1), -- Boots of the Forgotten Dephts
(@Vezax25Ref,45509,0,1,1,1,1), -- Idol of the Corruptor
(@Vezax25Ref,45501,0,1,1,1,1), -- Boots of the Underdweller
(@Vezax25Ref,45512,0,1,1,1,1), -- Grips of the Unbroken
(@Vezax25Ref,45503,0,1,1,1,1), -- Metallic Loop of the Sufferer
(@Vezax25Ref,45505,0,1,1,1,1), -- Belt of Clinging Hope
(@Vezax25Ref,45502,0,1,1,1,1), -- Helm of the Faceless
(@Vezax25Ref,45145,0,1,1,1,1), -- Libram of the Sacred Shield
(@Vezax25Ref,45508,0,1,1,1,1), -- Belt of the Darkspeaker
(@Vezax25Ref,45504,0,1,1,1,1), -- Darkcore Leggings
(@Vezax25Ref,45514,0,1,1,1,1), -- Mantle of the Unknowing
(@Vezax25Ref,45515,0,1,1,1,1), -- Ring of the Vacant Eye
(@Vezax25Ref,45507,0,1,1,1,1), -- The General's Heart
-- Yogg 10 man
(@Yogg10Ref,46016,0,1,1,1,1), -- Abaddon
(@Yogg10Ref,46018,0,1,1,1,1), -- Deliverance
(@Yogg10Ref,46019,0,1,1,1,1), -- Leggings of the Insatiable
(@Yogg10Ref,46021,0,1,1,1,1), -- Royal Seal of King Llane
(@Yogg10Ref,46022,0,1,1,1,1), -- Pendant of a Thousand Maws
(@Yogg10Ref,46024,0,1,1,1,1), -- Kingsbane
(@Yogg10Ref,46025,0,1,1,1,1), -- Devotion
(@Yogg10Ref,46028,0,1,1,1,1), -- Faceguard of the Eyeless Horror
(@Yogg10Ref,46030,0,1,1,1,1), -- Threads of the Dragon Council
(@Yogg10Ref,46031,0,1,1,1,1), -- Touch of Madness
-- Yogg 25 man
(@Yogg25Ref,45521,0,1,1,1,1), -- Earthshaper
(@Yogg25Ref,45522,0,1,1,1,1), -- Blood of the Old God
(@Yogg25Ref,45523,0,1,1,1,1), -- Garona's Guise
(@Yogg25Ref,45524,0,1,1,1,1), -- Chestguard of Insidious Intent
(@Yogg25Ref,45525,0,1,1,1,1), -- Godbane Signet
(@Yogg25Ref,45527,0,1,1,1,1), -- Soulscribe
(@Yogg25Ref,45529,0,1,1,1,1), -- Shawl of Haunted Memories
(@Yogg25Ref,45530,0,1,1,1,1), -- Sanity's Bond
(@Yogg25Ref,45531,0,1,1,1,1), -- Chestguard of the Fallen God
(@Yogg25Ref,45532,0,1,1,1,1), -- Cowl of Dark Whispers
-- Chest for Yogg
(@Chest,45635,0,1,1,1,1), -- Chestguard of the Wayward Conqueror
(@Chest,45636,0,1,1,1,1), -- Chestguard of the Wayward Protector
(@Chest,45637,0,1,1,1,1), -- Chestguard of the Wayward Vanquisher
(@Shoulder,45656,0,1,1,1,1), -- Mantle of the Wayward Conqueror
(@Shoulder,45657,0,1,1,1,1), -- Mantle of the Wayward Protector
(@Shoulder,45658,0,1,1,1,1); -- Mantle of the Wayward Vanquisher

DELETE FROM `creature_loot_template` WHERE `entry` IN(@Vezax10,@Vezax25,@Yogg10,@Yogg25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- ----------------------------------------------------------
-- General Vezax
-- ----------------------------------------------------------
-- 10 man mode
(@Vezax10,1,100,3,0,-@Vezax10Ref,2), -- 2x Normal Loot Item
(@Vezax10,47241,100,3,0,1,1), -- 1x Emblem of Triumph
-- hardmode loot 10
(@Vezax10,46032,0,2,1,1,1), -- Drape of the Faceless General
(@Vezax10,46034,0,2,1,1,1), -- Leggings of Profound Darkness
(@Vezax10,46033,0,2,1,1,1), -- Tortured Earth
(@Vezax10,46035,0,2,1,1,1), -- Aesuga, Hand of the Ardent Champion
(@Vezax10,46036,0,2,1,1,1), -- Void Sabre
-- 25 man mode
(@Vezax25,1,100,3,0,-@Vezax25Ref,3), -- 3x Normal Loot Item
(@Vezax25,47241,100,3,0,1,1), -- 1x Emblem of Triumph
(@Vezax25,2,10,1,0,-@Recipe,1), -- Chance on Recipe
(@Vezax25,3,10,1,0,-34350,1), -- Chance on Runed Orb
-- hardmode loot 25
(@Vezax25,45498,0,2,1,1,1), -- Lotrafen, Spear of the Damned
(@Vezax25,45511,0,2,1,1,1), -- Scepter of Lost Souls
(@Vezax25,45516,0,2,1,1,1), -- Voldrethar, Dark Blade of Oblivion
(@Vezax25,45517,0,2,1,1,1), -- Pendulum of Infinity
(@Vezax25,45519,0,2,1,1,1), -- Vestments of the Blind Denizen
(@Vezax25,45518,0,2,1,1,1), -- Flare of the Heavens
(@Vezax25,45520,0,2,1,1,1), -- Handwraps of the Vigilant
-- ----------------------------------------------------------
-- Yogg Saron
-- ----------------------------------------------------------
-- 10 man 
-- All modes
(@Yogg10,1,100,31,0,-@Yogg10Ref,1), -- 1x Normal Loot item for modes 0&1&2&3&4
(@Yogg10,2,100,31,0,-@Chest,1), -- 1x Tier token for modes 0&1&2&3&4
(@Yogg10,47241,100,31,0,1,1), -- 1x Emblem of Triumph for modes 0&1&2&3&4
-- Extra for <3 watchers
(@Yogg10,3,100,30,0,-@EmblemRef,1), -- additional Emblem for modes2&3 
-- Extra for <2 watchers
(@Yogg10,4,100,28,0,-34350,1), -- Runed Orb for 0&1&2
(@Yogg10,5,10,28,0,-@Recipe,1), -- Chance on Recipe for 0&1&2
-- Extra for <1 watchers
(@Yogg10,6,100,24,0,-@EmblemRef,1), -- additional Emblem for 0&1 
(@Yogg10,7,100,24,0,-@Recipe,1), -- Garanteed Recipe for 0&1
-- Hardmode 10 loot
(@Yogg10,46067,0,24,1,1,1), -- Hammer of Crushing Whispers
(@Yogg10,46068,0,24,1,1,1), -- Amice of Inconceivable Horror
(@Yogg10,46095,0,24,1,1,1), -- Soul-Devouring Cinch
(@Yogg10,46096,0,24,1,1,1), -- Signet of Soft Lament
(@Yogg10,46097,0,24,1,1,1), -- Caress of Insanity
-- Extra for 0 watchers
(@Yogg10,46312,100,16,0,1,1), -- Vanquished Clutches of Yogg-Saron
-- 25 man mode
-- All modes
(@Yogg25,1,100,31,0,-@Yogg25Ref,2), -- 2x Normal Loot item for modes 0&1&2&3&4
(@Yogg25,2,100,31,0,-@Shoulder,2), -- 2x Tier token for modes 0&1&2&3&4
(@Yogg25,47241,100,31,0,1,1), -- 1x Emblem of Triumph for modes 0&1&2&3&4
(@Yogg25,3,10,31,0,-34350,1), -- Chance on Runed Orb for modes 0&1&2&3&4
(@Yogg25,4,10,31,0,-@Recipe,1), -- Chance on Recipe for 0&1&2&3&4
(@Yogg25,45897,100,31,0,1,1), -- Fragment of Val'anyr
-- Extra for <3 watchers
(@Yogg25,5,100,30,0,-@EmblemRef,1), -- additional Emblem for modes2&3
-- Extra for <2 watchers
(@Yogg25,6,100,28,0,-34350,1), -- Runed Orb for 0&1&2
-- Extra for <1 watchers
(@Yogg25,7,100,24,0,-@EmblemRef,1), -- additional Emblem for 0&1 
(@Yogg25,8,100,24,0,-@Recipe,1), -- Garanteed Recipe for 0&1
-- Hardmode 25 loot
(@Yogg25,45533,0,24,1,1,1), -- Dark Edge of Depravity
(@Yogg25,45534,0,24,1,1,1), -- Seal of the Betrayed King
(@Yogg25,45535,0,24,1,1,1), -- Show of Faith
(@Yogg25,45536,0,24,1,1,1), -- Legguards of Cunning Deception
(@Yogg25,45537,0,24,1,1,1), -- Threads of the False Oracle
-- Extra for 0 watchers
(@Yogg25,45693,100,16,0,1,1); -- Mimiron's Head

-- Cleanups
DELETE FROM `conditions` WHERE `SourceEntry`=45897 AND `SourceGroup`=33955;SET @Triumph :=47241;
-- Cleanup some unneeded references
DELETE FROM `reference_loot_template` WHERE `entry` IN (34167,34168,34169);
UPDATE `creature_loot_template` SET `mincountOrRef`=-34349 WHERE `mincountOrRef` IN (-34167,-34168,-34169);
-- Fix this weird defined reference for ulduar
UPDATE `reference_loot_template` SET `ChanceOrQuestChance`=100,`groupid`=0 WHERE `entry`=34349;
-- Remove Emblem of Triumph from reference_loot
DELETE FROM `reference_loot_template` WHERE `item`=@Triumph AND `entry`IN (12025,35034,35040,35049);
-- Actual Emblem on creature as it should be
DELETE FROM `creature_loot_template` WHERE `entry` IN (30397,30398,31365,31367,31656,31679) AND `item`=@Triumph;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(30397,@Triumph,100,1,0,1,1), -- Commander Kolurg (1)
(30398,@Triumph,100,1,0,1,1), -- Commander Stoutbeard (1)
(31365,@Triumph,100,1,0,1,1), -- Drakkari Colossus (1)
(31367,@Triumph,100,1,0,1,1), -- Drakkari Elemental (1)
(31656,@Triumph,100,1,0,1,1), -- Dalronn the Controller (1)
(31679,@Triumph,100,1,0,1,1); -- Skarvald the Constructor (1)
-- Similar action for gameobjects
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (27416,27417) AND `item`=@Triumph;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27417,@Triumph,100,1,0,1,1), -- Confessor's Cache
(27416,@Triumph,100,1,0,1,1); -- Eadric's Cache
-- Add missing Challe & Orphan Matron Aria Spawns
SET @GUID := 41876;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+1;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES 
(@GUID,23101,530,1,1,0,0,-480.4989,7499.029,181.2889,3.560472,120,0,0,1,0,0), 
(@GUID+1,34365,571,1,1,0,0,5716.604,642.8611,646.2927,5.88176,120,0,0,1,0,0);
-- Add to game event creature
DELETE FROM `game_event_creature` WHERE `guid`=@GUID+1;
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES (10,@GUID+1);
DELETE FROM `creature_loot_template` WHERE `entry` IN(38064,38103);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Precious 25 man
(38103,1,100,1,0,-35069,2), -- Two From ICC Trashgenerated on Precious
(38103,52019,30,1,0,1,1), -- Precious Ribbon on Precious
(38064,1,100,1,0,-35069,2); -- Two From ICC Trashgenerated on Stinky
-- add skinning loot for Stinky & Precious
UPDATE `creature_template` SET `skinloot`=70214 WHERE `entry` IN (37025,38064,37217,38103);
SET @GUID1 := 42158;
SET @GUID2 := 42159;
-- add creature
DELETE FROM creature WHERE guid IN (@GUID1,@GUID2);
INSERT INTO `creature`
(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`)
VALUES
(@GUID1 ,38453,571,1,1,3561.821,-2736.367,136.0317,0), -- Arcturis in Grizzly Hills
(@GUID2,35189,571,1,1,7101.845,-1443.734,924.2609,0.178631); -- Skoll in The Storm Peaks
-- Update template
UPDATE `creature_template` SET `faction_A` = 190, `faction_H`=190 WHERE `entry` IN (38453,35189);
SET @NPC= @GUID1*10;
-- Add pathing for Arcturis
DELETE FROM `creature_addon` WHERE `guid` = @GUID1;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID1,@NPC,0,0,0,0,''); -- Add path for Acturis
-- Add waypoint data for the path:
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`) VALUES
(@NPC,1,3563.499,-2737.698,137.1898),
(@NPC,2,3565.249,-2738.698,138.4398),
(@NPC,3,3566.749,-2739.948,139.9398),
(@NPC,4,3568.249,-2740.698,140.6898),
(@NPC,5,3567.839,-2741.380,141.9256),
(@NPC,6,3569.999,-2741.948,142.1898),
(@NPC,7,3570.749,-2742.448,143.1898),
(@NPC,8,3572.676,-2743.528,144.8479);
-- Spawntimefix
UPDATE `creature` SET `spawntimesecs`=39600 WHERE `guid` IN (@GUID1,@GUID2); -- Set the spawntime to 11 hours for Arcturis & Skoll
UPDATE `script_texts` SET `emote` = 432 WHERE `entry` IN (-1595111);
UPDATE `script_texts` SET `emote` = 396 WHERE `entry` IN (-1595070,-1595075,-1595078,-1595079,-1595088,-1595103,-1595106,-1595107,-1595108,-1595109,-1595113,-1595114,-1595115,-1595116);
UPDATE `script_texts` SET `emote` = 397 WHERE `entry` IN (-1595071,-1595084,-1595093);
UPDATE `script_texts` SET `emote` = 274 WHERE `entry` IN (-1595091);
UPDATE `script_texts` SET `emote` = 5 WHERE `entry` IN (-1595073,-1595118);
UPDATE `script_texts` SET `emote` = 6 WHERE `entry` IN (-1595076);
UPDATE `script_texts` SET `emote` = 1 WHERE `entry` IN (-1595083,-1595100,-1595104,-1595120);
UPDATE `script_texts` SET `emote` = 0 WHERE `entry` IN (-1595009,-1595010,-1595081,-1595082,-1595085,-1595119);

UPDATE `script_texts` SET `type` = 1 WHERE `entry` IN (-1595009,-1595010,-1595087,-1595094,-1595095,-1595093);
UPDATE `script_texts` SET `type` = 0 WHERE `entry` IN (-1595077,-1595078,-1595119);

UPDATE `script_texts` SET `content_default` = "Champions, meet me at the Town Hall at once. We must take the fight to Mal'Ganis." WHERE `entry` = -1595095;
UPDATE `script_texts` SET `content_default` = "Follow me, I know the way through." WHERE `entry` = -1595096;
UPDATE `script_texts` SET `content_default` = "Take position here, and I will lead a small force inside Stratholme to begin the culling. We must contain and purge the infected for the sake of all of Lordaeron!" WHERE entry = -1595087;
UPDATE `script_texts` SET `content_default` = "Ah, you've finally arrived Prince Arthas. You're here just in the nick of time." WHERE `entry` = -1595097;
UPDATE `script_texts` SET `content_default` = "Yes, I'm glad I could get to you before the plague." WHERE `entry` = -1595098;
UPDATE `script_texts` SET `content_default` = "As if I could forget. Listen, Uther, there's something about the plague you should know..." WHERE `entry` = -1595072;
UPDATE `script_texts` SET `content_default` = "There's no need for you to understand, Arthas. All you need to do is die." WHERE `entry` = -1595100;
UPDATE `script_texts` SET `content_default` = "More vile sorcery! Be ready for anything!" WHERE `entry` = -1595102;
UPDATE `script_texts` SET `content_default` = "Watch your backs: they have us surrounded in this hall." WHERE `entry` = -1595104;
UPDATE `script_texts` SET `content_default` = "Mal'Ganis is not making this easy." WHERE `entry` = -1595106;
UPDATE `script_texts` SET `content_default` = "What else can he put in my way?" WHERE `entry` = -1595108;
UPDATE `script_texts` SET `content_default` = "I do what I must for Lordaeron, and neither your words nor your actions will stop me." WHERE `entry` = -1595109;
UPDATE `script_texts` SET `content_default` = "The quickest path to Mal'Ganis lies behind that bookshelf ahead." WHERE `entry` = -1595110;
UPDATE `script_texts` SET `content_default` = "I'm relieved this secret passage still works." WHERE `entry` = -1595112;
UPDATE `script_texts` SET `content_default` = "Let's move through here as quickly as possible. If the undead don't kill us, the fires might." WHERE `entry` = -1595113;
UPDATE `script_texts` SET `content_default` = "Rest a moment and clear your lungs, but we must move again soon." WHERE `entry` = -1595114;
UPDATE `script_texts` SET `content_default` = "That's enough; we must move again. Mal'Ganis awaits." WHERE `entry` = -1595115;
UPDATE `script_texts` SET `content_default` = "At last some good luck. Market Row has not caught fire yet. Mal'Ganis is supposed to be in Crusaders' Square, which is just ahead. Tell me when you're ready to move forward." WHERE `entry` = -1595116;
UPDATE `script_texts` SET `content_default` = "Justice will be done." WHERE `entry` = -1595117;
UPDATE `script_texts` SET `content_default` = "We're going to finish this right now, Mal'Ganis. Just you... and me." WHERE `entry` = -1595118;

UPDATE `script_texts` SET `comment` = concat(`comment`,". NEEDS VERIFICATION") WHERE `entry` IN (-1595101,-1595105);

SET @GUID := 88474;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, 
`MovementType`, `npcflag`, `unit_flags`, `dynamicflags`)
VALUES
(@GUID+00,27737,595,3,1,25543,0,2319.89,1285.78,131.407,1.72169,60,10,0,630,0,1,0,0,0),
(@GUID+01,27737,595,3,1,10979,0,2308.12,1304.21,127.601,4.39662,60,10,0,630,0,1,0,0,0),
(@GUID+02,27737,595,3,1,25542,0,2335.47,1262.04,132.921,1.42079,60,10,0,630,0,1,0,0,0),
(@GUID+03,27737,595,3,1,25543,0,2297.73,1338.75,124.622,2.5574,60,10,0,630,0,1,0,0,0),
(@GUID+04,27737,595,3,1,10979,0,2322.65,1265.39,133.033,5.6524,60,10,0,630,0,1,0,0,0),
(@GUID+05,27737,595,3,1,10973,0,2277.83,1331.92,124.19,3.48045,60,10,0,630,0,1,0,0,0),
(@GUID+06,27737,595,3,1,25543,0,2294.18,1316.93,125.672,6.05649,60,10,0,630,0,1,0,0,0),
(@GUID+07,27737,595,3,1,10973,0,2310.56,1369,128.372,5.03364,60,10,0,630,0,1,0,0,0),
(@GUID+08,27737,595,3,1,10979,0,2306.15,1322.85,125.708,4.99133,60,10,0,630,0,1,0,0,0),
(@GUID+09,27737,595,3,1,10973,0,2320.14,1297.48,129.694,1.35248,60,10,0,630,0,1,0,0,0),
(@GUID+10,27737,595,3,1,25542,0,2291.57,1327.27,124.545,5.32358,60,10,0,630,0,1,0,0,0),
(@GUID+11,27737,595,3,1,25542,0,2308.04,1352.65,126.907,5.83741,60,10,0,630,0,1,0,0,0),
(@GUID+12,27737,595,3,1,10979,0,2329.44,1281.11,132.636,2.25207,60,10,0,630,0,1,0,0,0),
(@GUID+13,27737,595,3,1,0,0,2407.32,1423.8,131.522,6.24743,60,10,0,706,0,1,0,0,0),
(@GUID+14,27737,595,3,1,0,0,2417.26,1428.41,131.652,6.20423,60,10,0,730,0,1,0,0,0),
(@GUID+15,27737,595,3,1,0,0,2420.48,1419.99,130.716,0.0977616,60,10,0,706,0,1,0,0,0),
(@GUID+16,27737,595,3,1,0,0,2426.63,1413.41,130.464,0.404064,60,10,0,730,0,1,0,0,0),
(@GUID+17,27737,595,3,1,0,0,2430.46,1417.6,130.557,0.125247,60,10,0,730,0,1,0,0,0),
(@GUID+18,27737,595,3,1,0,0,2433.94,1427.03,131.18,0.0584885,60,10,0,706,0,1,0,0,0),
(@GUID+19,27737,595,3,1,0,0,2446.5,1428.37,131.013,6.10606,60,10,0,756,0,1,0,0,0),
(@GUID+20,27737,595,3,1,0,0,2449.49,1423.35,130.588,5.77619,60,10,0,706,0,1,0,0,0),
(@GUID+21,27737,595,3,1,0,0,2441.92,1424.41,130.606,6.07857,60,10,0,706,0,1,0,0,0),
(@GUID+22,27737,595,3,1,0,0,2450.6,1438.61,132.213,4.74889,60,10,0,730,0,1,0,0,0),
(@GUID+23,27737,595,3,1,0,0,2460.17,1436.46,131.501,4.73711,60,10,0,756,0,1,0,0,0),
(@GUID+24,27737,595,3,1,0,0,2444.68,1421.68,130.324,6.01338,60,10,0,756,0,1,0,0,0),
(@GUID+25,27737,595,3,1,0,0,2456.87,1419.07,130.488,5.39763,60,10,0,706,0,1,0,0,0),
(@GUID+26,27737,595,3,1,0,0,2464.27,1422.15,130.976,5.22092,60,10,0,756,0,1,0,0,0),
(@GUID+27,27737,595,3,1,0,0,2468.21,1403.06,130.39,5.6364,60,10,0,756,0,1,0,0,0),
(@GUID+28,27737,595,3,1,0,0,2460.88,1406.8,130.508,5.96234,60,10,0,756,0,1,0,0,0),
(@GUID+29,27737,595,3,1,0,0,2485.77,1398.35,130.795,4.71591,60,10,0,756,0,1,0,0,0),
(@GUID+30,27737,595,3,1,0,0,2485.79,1380.46,130.15,5.02928,60,10,0,730,0,1,0,0,0),
(@GUID+31,27737,595,3,1,0,0,2475.77,1396.31,130.124,4.84079,60,10,0,730,0,1,0,0,0),
(@GUID+32,27737,595,3,1,0,0,2476.92,1387.21,129.401,5.05128,60,10,0,730,0,1,0,0,0),
(@GUID+33,27737,595,3,1,0,0,2483.24,1389.37,130.123,4.74104,60,10,0,730,0,1,0,0,0),
(@GUID+34,27737,595,3,1,0,0,2480.2,1370.15,129.533,5.79583,60,10,0,706,0,1,0,0,0),
(@GUID+35,27737,595,3,1,0,0,2481.54,1375.11,129.642,5.4644,60,10,0,730,0,1,0,0,0),
(@GUID+36,27737,595,3,1,0,0,2489.44,1359.42,131.233,5.378,60,10,0,730,0,1,0,0,0),
(@GUID+37,27737,595,3,1,0,0,2486.59,1356.19,131.876,5.7275,60,10,0,756,0,1,0,0,0),
(@GUID+38,27737,595,3,1,0,0,2495.53,1348.61,133.072,5.52722,60,10,0,730,0,1,0,0,0),
(@GUID+39,27737,595,3,1,0,0,2504.48,1349.65,132.856,5.11881,60,10,0,730,0,1,0,0,0),
(@GUID+40,27737,595,3,1,0,0,2493.11,1380.29,130.24,4.93189,60,10,0,706,0,1,0,0,0),
(@GUID+41,27737,595,3,1,0,0,2487.18,1392.64,130.512,4.93818,60,10,0,706,0,1,0,0,0),
(@GUID+42,27737,595,3,1,0,0,2506.49,1336.89,132.794,5.19343,60,10,0,756,0,1,0,0,0),
(@GUID+43,27737,595,3,1,0,0,2518.2,1306.39,130.623,4.81723,60,10,0,756,0,1,0,0,0),
(@GUID+44,27737,595,3,1,0,0,2513.4,1299.67,130.868,4.4206,60,10,0,756,0,1,0,0,0),
(@GUID+45,27737,595,3,1,0,0,2511.45,1291.47,130.808,5.00729,60,10,0,756,0,1,0,0,0),
(@GUID+46,27737,595,3,1,0,0,2518.56,1292.32,130.528,5.16438,60,10,0,756,0,1,0,0,0),
(@GUID+47,27737,595,3,1,0,0,2515.49,1279.85,129.214,5.28847,60,10,0,730,0,1,0,0,0),
(@GUID+48,27737,595,3,1,0,0,2514.37,1285.92,129.934,5.70473,60,10,0,706,0,1,0,0,0),
(@GUID+49,27737,595,3,1,0,0,2522.65,1274.29,128.576,5.44634,60,10,0,706,0,1,0,0,0),
(@GUID+50,27737,595,3,1,0,0,2535.38,1275.77,127.42,5.49817,60,10,0,756,0,1,0,0,0),
(@GUID+51,27737,595,3,1,0,0,2537.59,1273.1,127.05,5.02693,60,10,0,730,0,1,0,0,0),
(@GUID+52,27737,595,3,1,0,0,2547.49,1261.7,126.44,4.78425,60,10,0,730,0,1,0,0,0),
(@GUID+53,27737,595,3,1,0,0,2534.36,1261.06,127.125,4.3994,60,10,0,756,0,1,0,0,0),
(@GUID+54,27737,595,3,1,0,0,2532.69,1251.44,127.452,5.4479,60,10,0,730,0,1,0,0,0),
(@GUID+55,27737,595,3,1,0,0,2551.84,1252.35,125.455,5.04342,60,10,0,706,0,1,0,0,0),
(@GUID+56,27737,595,3,1,0,0,2536.1,1244,126.928,5.16515,60,10,0,756,0,1,0,0,0),
(@GUID+57,27737,595,3,1,0,0,2543.63,1247.23,126.131,5.19735,60,10,0,706,0,1,0,0,0),
(@GUID+58,27737,595,3,1,0,0,2554.21,1238.95,125.475,4.64836,60,10,0,730,0,1,0,0,0),
(@GUID+59,27737,595,3,1,0,0,2548.89,1227.37,126.375,5.31517,60,10,0,756,0,1,0,0,0),
(@GUID+60,27737,595,3,1,0,0,2560.46,1225.4,125.496,4.85335,60,10,0,706,0,1,0,0,0),
(@GUID+61,27737,595,3,1,0,0,2555.11,1218.55,125.944,5.11646,60,10,0,730,0,1,0,0,0),
(@GUID+62,27737,595,3,1,0,0,2561.91,1211.56,125.38,5.5877,60,10,0,730,0,1,0,0,0),
(@GUID+63,27737,595,3,1,0,0,2568.67,1202.96,125.509,4.96095,60,10,0,756,0,1,0,0,0),
(@GUID+64,27737,595,3,1,0,0,2571.93,1193.48,125.619,5.07641,60,10,0,756,0,1,0,0,0),
(@GUID+65,27737,595,3,1,0,0,2577.77,1180.88,125.562,4.64522,60,10,0,756,0,1,0,0,0),
(@GUID+66,27737,595,3,1,0,0,2574.2,1166.63,126.089,4.44966,60,10,0,706,0,1,0,0,0),
(@GUID+67,27737,595,3,1,0,0,2564.78,1166.82,127.092,4.2266,60,10,0,756,0,1,0,0,0),
(@GUID+68,27737,595,3,1,0,0,2577.56,1158.41,126.385,4.07738,60,10,0,756,0,1,0,0,0),
(@GUID+69,27737,595,3,1,0,0,2567.93,1176.56,126.2,4.7489,60,10,0,706,0,1,0,0,0),
(@GUID+70,27737,595,3,1,0,0,2559.28,1189.46,126.642,4.73319,60,10,0,756,0,1,0,0,0),
(@GUID+71,27737,595,3,1,0,0,2554.14,1213.37,126.599,5.13845,60,10,0,706,0,1,0,0,0),
(@GUID+72,27737,595,3,1,0,0,2560.58,1218.48,125.281,4.97351,60,10,0,730,0,1,0,0,0),
(@GUID+73,27737,595,3,1,0,0,2570.2,1170.58,126.311,4.64365,60,10,0,756,0,1,0,0,0),
(@GUID+74,27729,595,3,1,0,0,2496.57,1354.66,132.217,5.13691,120,5,0,63000,0,1,0,0,0),
(@GUID+75,27729,595,3,1,0,0,2494.22,1365.17,130.812,5.15654,120,5,0,63000,0,1,0,0,0),
(@GUID+76,27729,595,3,1,0,0,2440.41,1434.46,131.456,5.69372,120,5,0,63000,0,1,0,0,0),
(@GUID+77,27729,595,3,1,0,0,2433.18,1421.13,130.644,0.046706,120,5,0,63000,0,1,0,0,0),
(@GUID+78,27734,595,3,1,0,0,2546.07,1239.17,125.945,5.07801,120,5,0,63000,0,1,0,0,0),
(@GUID+79,27734,595,3,1,0,0,2458.58,1426.22,131.056,5.42984,120,5,0,63000,0,1,0,0,0),
(@GUID+80,27736,595,3,1,0,0,2488.11,1364.91,130.402,5.35524,120,5,0,130330,0,1,0,0,0),
(@GUID+81,28199,595,3,1,0,0,2527.63,1267.59,128.168,5.12906,120,5,0,63000,0,1,0,0,0),
(@GUID+82,28199,595,3,1,0,0,2528.06,1284.34,128.877,5.14869,120,5,0,63000,0,1,0,0,0),
(@GUID+83,28199,595,3,1,0,0,2466.27,1414.57,130.977,5.18637,120,5,0,63000,0,1,0,0,0),
(@GUID+84,28200,595,3,1,0,0,2570.51,1181.4,125.809,4.61855,120,5,0,50400,44070,1,0,0,0),
(@GUID+85,28200,595,3,1,0,0,2560.45,1202.05,126.031,4.85417,120,5,0,50400,44070,1,0,0,0),
(@GUID+86,28200,595,3,1,0,0,2487.85,1373.29,130.236,5.078,120,5,0,50400,44070,1,0,0,0),
(@GUID+87,28200,595,3,1,0,0,2416.7,1416.52,130.379,0.191224,120,5,0,50400,44070,1,0,0,0),
(@GUID+88,28200,595,3,1,0,0,2424.42,1422.68,130.868,0.25327,120,5,0,50400,44070,1,0,0,0),
(@GUID+89,28201,595,3,1,0,0,2540.67,1254.82,126.274,4.97198,120,5,0,130330,0,1,0,0,0),
(@GUID+90,28201,595,3,1,0,0,2410.03,1417.19,130.577,0.191229,120,5,0,130330,0,1,0,0,0),
(@GUID+91,28249,595,3,1,0,0,2562.66,1177.9,126.716,4.77171,120,5,0,63000,0,1,0,0,0),
(@GUID+92,28249,595,3,1,0,0,2566.72,1190.41,125.837,4.7992,120,5,0,63000,0,1,0,0,0),
(@GUID+93,28249,595,3,1,0,0,2472.34,1404.76,130.752,5.20601,120,5,0,63000,0,1,0,0,0),
(@GUID+94,28249,595,3,1,0,0,2460.59,1413.26,130.46,5.4377,120,5,0,63000,0,1,0,0,0),
(@GUID+95,28249,595,3,1,0,0,2415.04,1423.52,131.111,0.214785,120,5,0,63000,0,1,0,0,0);

DELETE FROM `script_texts` WHERE entry BETWEEN -1595052 AND -1595048;
INSERT INTO `script_texts` (npc_entry,entry, content_default, comment) VALUES
(27913,-1595048, "Scourge forces have been spotted near the Elder's Square Gate!","Spawns near elder's square gate."),
(27913,-1595059, "Scourge forces have been spotted near the Town Hall!","Spawns near town hall."),
(27913,-1595050, "Scourge forces have been spotted near the King's Square fountain!","Spawns near king's square."),
(27913,-1595051, "Scourge forces have been spotted near the Market Row Gate!", "Spawns near market row gate."),
(27913,-1595052, "Scourge forces have been spotted near the Festival Lane Gate!", "Spawns near festval lane gate.");

UPDATE `creature_template` SET `dynamicflags` = 0 WHERE `entry` IN (32273,32313);
UPDATE `areatrigger_teleport` SET id = 5181 WHERE id = 5148;
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 20562;
UPDATE `script_waypoint` SET location_x = 2449.32, location_y = 1191.09 WHERE entry = 26499 AND pointid = 26;

UPDATE `creature_template` SET `lootid` = 32273 WHERE `entry` IN (32273, 32313);

-- thx warpten (fix for credit spell)
UPDATE `spell_dbc` SET `Attributes` = '8388992', `AttributesEx2` = '5', `AttributesEx3` = '269484288' WHERE `Id` = 58630;
-- Wolvar Orphan quest order
UPDATE `quest_template` SET `prevquestid`=13927,`exclusivegroup`=-13930 WHERE `id` IN (13930,13934,13951);
UPDATE `quest_template` SET `prevquestid`=13930,`exclusivegroup`=-13955 WHERE `id` IN (13955,13957);
UPDATE `quest_template` SET `prevquestid`=13955,`exclusivegroup`=0 WHERE `id`=13938;
UPDATE `quest_template` SET `prevquestid`=13938,`exclusivegroup`=0 WHERE `id`=13960;
-- Oracle Orphan quest order
UPDATE `quest_template` SET `prevquestid`=13926,`exclusivegroup`=-13929 WHERE `id` IN (13929,13933,13950);
UPDATE `quest_template` SET `prevquestid`=13929,`exclusivegroup`=-13954 WHERE `id` IN (13954,13956);
UPDATE `quest_template` SET `prevquestid`=13954,`exclusivegroup`=0 WHERE `id`=13937;
UPDATE `quest_template` SET `prevquestid`=13937,`exclusivegroup`=0 WHERE `id`=13959;
-- Human Orphan quest order
UPDATE `quest_template` SET `prevquestid`=1468,`exclusivegroup`=-1479 WHERE `id` IN (1479,1558,1687);
UPDATE `quest_template` SET `prevquestid`=1479,`exclusivegroup`=-558 WHERE `id` IN (558,4822);
UPDATE `quest_template` SET `prevquestid`=558,`exclusivegroup`=0 WHERE `id`=171;
-- Orcish Orphan quest order
UPDATE `quest_template` SET `prevquestid`=172,`exclusivegroup`=-910 WHERE `id` IN (910,911,1800);
UPDATE `quest_template` SET `prevquestid`=910,`exclusivegroup`=-915 WHERE `id` IN (915,925);
UPDATE `quest_template` SET `prevquestid`=915,`exclusivegroup`=0 WHERE `id`=5502;
-- Draenei Orphan quest order
UPDATE `quest_template` SET `prevquestid`=10943,`exclusivegroup`=-10950 WHERE `id` IN (10950,10952,10954);
UPDATE `quest_template` SET `prevquestid`=10950,`exclusivegroup`=-10956 WHERE `id` IN (10956,10962);
UPDATE `quest_template` SET `NextQuestIdChain`=10968 WHERE `id`=10956;
UPDATE `quest_template` SET `prevquestid`=10968,`exclusivegroup`=0 WHERE `id`=10966;
-- Blood Elf Orphan quest order
UPDATE `quest_template` SET `prevquestid`=10942,`exclusivegroup`=-10945 WHERE `id` IN (10945,10951,10953);
UPDATE `quest_template` SET `prevquestid`=10945,`exclusivegroup`=-10960 WHERE `id` IN (10960,10963);
UPDATE `quest_template` SET `prevquestid`=10960,`exclusivegroup`=0 WHERE `id`=11975;
UPDATE `quest_template` SET `prevquestid`=11975,`exclusivegroup`=0 WHERE `id`=10967;
-- Set correct NPC for A Warden of the Alliance
UPDATE `creature_questrelation` SET `id`=14305 WHERE `quest`=171;
DELETE FROM `creature_questrelation` WHERE `id` IN (14305,14444,22817,22818,33532,33533,34365); 
DELETE FROM `game_event_creature_quest` WHERE `eventEntry`=10;
INSERT INTO `game_event_creature_quest` (`eventEntry`,`id`,`quest`) VALUES
-- Alliance
(10,14450,1468), -- Orphan Matron Nightingale - Children's Week
(10,14305,1479), -- Human Orphan - The Bough of the Eternals
(10,14305,1558), -- Human Orphan - The Stonewrought Dam
(10,14305,1687), -- Human Orphan - Spooky Lighthouse
(10,14305,558), -- Human Orphan - Jaina's Autograph
(10,14305,4822), -- Human Orphan - You Scream, I Scream...
-- Horde 
(10,14451,172), -- Orphan Matron Battlewail - Children's Week
(10,14444,910), -- Orcish Orphan - Down at the Docks
(10,14444,911), -- Orcish Orphan - Gateway to the Frontier
(10,14444,1800), -- Orcish Orphan - Lordaeron Throne Room
(10,14444,915), -- Orcish Orphan - You Scream, I Scream...
(10,14444,925), -- Orcish Orphan - Cairne's Hoofprint
(10,14444,5502), -- Orcish Orphan - A Warden of the Horde
-- Outlands: Blood Elfs
(10,22819,10942), -- Orphan Matron Mercy - Children's Week
(10,22817,10945), -- Blood Elf Orphan - Hch'uu and the Mushroom People
(10,22817,10951), -- Blood Elf Orphan - A Trip to the Dark Portal
(10,22817,10953), -- Blood Elf Orphan - Visit the Throne of the Elements
(10,22817,11975), -- Blood Elf Orphan - Now, When I Grow Up...
(10,22817,10963), -- Blood Elf Orphan - Time to Visit the Caverns
(10,22817,10967), -- Blood Elf Orphan - Back to the Orphanage
-- Outlands: Draenei
(10,22819,10943), -- Orphan Matron Mercy - Children's Week
(10,22818,10950), -- Draenei Orphan - Auchindoun and the Ring of Observance
(10,22818,10952), -- Draenei Orphan - A Trip to the Dark Portal
(10,22818,10954), -- Draenei Orphan - Jheel is at Aeris Landing!
(10,22818,10956), -- Draenei Orphan - The Seat of the Naaru
(10,22818,10962), -- Draenei Orphan - Time to Visit the Caverns
(10,22818,10966), -- Draenei Orphan - Back to the Orphanage
-- Northrend: Wolvar
(10,34365,13927), -- Orphan Matron Aria - Little Orphan Kekek Of The Wolvar
(10,33532,13930), -- Wolvar Orphan - Home Of The Bear-Men
(10,33532,13934), -- Wolvar Orphan - The Bronze Dragonshrine
(10,33532,13951), -- Wolvar Orphan - Playmates!
(10,33532,13955), -- Wolvar Orphan - The Dragon Queen
(10,33532,13957), -- Wolvar Orphan - The Mighty Hemet Nesingwary
(10,33532,13960), -- Wolvar Orphan - Back To The Orphanage
-- Northrend: Oracles
(10,34365,13926), -- Orphan Matron Aria - Little Orphan Roo Of The Oracles
(10,33533,13929), -- Oracle Orphan - The Biggest Tree Ever!
(10,33533,13933), -- Oracle Orphan - The Bronze Dragonshrine
(10,33533,13937), -- Oracle Orphan - A Trip To The Wonderworks
(10,33533,13950), -- Oracle Orphan - Playmates!
(10,33533,13954), -- Oracle Orphan - The Dragon Queen
(10,33533,13956), -- Oracle Orphan - Meeting a Great One
(10,33533,13959); -- Oracle Orphan - Back To The Orphanage

-- Removed "When I Grow Up..." and replace it with "Now, When I Grow Up..." 
UPDATE `quest_template` SET `prevquestid`=10945,`exclusivegroup`=-11975 WHERE `id` IN (11975,10963);
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=10960;
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(1,10960,0,'','','Deprecated quest: When I grow up...');
-- Thrallmar Grunt pathing
SET @NPC := 57505;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=168.3949,`position_y`=2641.357,`position_z`=86.32077 WHERE `guid`=@NPC;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,168.3949,2641.357,86.32077,0,0,0,100,0),
(@PATH,2,186.5067,2615.882,87.28357,0,0,0,100,0),
(@PATH,3,188.9113,2601.655,87.28357,0,0,0,100,0),
(@PATH,4,198.3909,2602.661,87.28357,0,0,0,100,0),
(@PATH,5,201.5686,2609.845,87.28357,0,0,0,100,0),
(@PATH,6,187.2484,2616.44,87.28357,0,0,0,100,0),
(@PATH,7,168.7871,2641.268,86.32077,0,0,0,100,0),
(@PATH,8,155.2003,2681.998,84.82113,0,0,0,100,0),
(@PATH,9,194.6133,2692.07,90.61374,0,0,0,100,0),
(@PATH,10,215.4427,2693.589,90.69872,0,0,0,100,0),
(@PATH,11,219.0203,2692.25,90.69665,0,0,0,100,0),
(@PATH,12,225.5117,2680.063,90.68996,0,0,0,100,0),
(@PATH,13,235.309,2679.308,90.69373,0,0,0,100,0),
(@PATH,14,246.9184,2682.646,90.70419,0,0,0,100,0),
(@PATH,15,252.4411,2688.479,90.70386,0,0,0,100,0),
(@PATH,16,255.0155,2699.197,90.70283,0,0,0,100,0),
(@PATH,17,251.5234,2707.998,90.70486,0,0,0,100,0),
(@PATH,18,243.2346,2712.791,90.70392,0,0,0,100,0),
(@PATH,19,231.9871,2713.626,90.70399,0,0,0,100,0),
(@PATH,20,221.1457,2709.591,90.69753,0,0,0,100,0),
(@PATH,21,218.8803,2695.845,90.69318,0,0,0,100,0),
(@PATH,22,215.4517,2693.612,90.69869,0,0,0,100,0),
(@PATH,23,194.7944,2692.039,90.65273,0,0,0,100,0),
(@PATH,24,175.8115,2687.591,86.68189,0,0,0,100,0),
(@PATH,25,155.2143,2682.375,84.82113,0,0,0,100,0),
(@PATH,26,131.8727,2679.832,84.56969,0,0,0,100,0),
(@PATH,27,130.0859,2666.262,84.1262,0,0,0,100,0),
(@PATH,28,153.1291,2650.22,86.15128,0,0,0,100,0);

-- Remove dup Thrallmar Grunt spawn
DELETE FROM `creature` WHERE `guid`=57532;
DELETE FROM `creature_addon` WHERE `guid`=57532;

-- Bat Rider Guard pathing
SET @NPC := 54840;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=156.9029,`position_y`=2554.784,`position_z`=170.8949 WHERE `guid`=@NPC;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,156.9029,2554.784,170.8949,0,0,0,100,0),
(@PATH,2,52.51677,2602.816,139.7838,0,0,0,100,0),
(@PATH,3,42.10146,2627.056,139.7838,0,0,0,100,0),
(@PATH,4,37.17329,2663.729,139.7838,0,0,0,100,0),
(@PATH,5,62.91933,2687.96,139.7838,0,0,0,100,0),
(@PATH,6,96.1871,2688.141,148.4226,0,0,0,100,0),
(@PATH,7,129.818,2690.786,151.256,0,0,0,100,0),
(@PATH,8,165.6888,2715.398,170.8949,0,0,0,100,0),
(@PATH,9,199.7751,2744.93,170.8949,0,0,0,100,0),
(@PATH,10,246.0857,2761.154,170.8949,0,0,0,100,0),
(@PATH,11,295.0904,2757.991,170.8949,0,0,0,100,0),
(@PATH,12,309.3468,2726.089,170.8949,0,0,0,100,0),
(@PATH,13,303.8448,2682.588,170.8949,0,0,0,100,0),
(@PATH,14,289.3104,2650.866,170.8949,0,0,0,100,0),
(@PATH,15,261.2743,2618.831,170.8949,0,0,0,100,0),
(@PATH,16,233.6436,2578.997,170.8949,0,0,0,100,0),
(@PATH,17,199.3375,2546.226,170.8949,0,0,0,100,0);

-- Bat Rider Guard pathing
SET @NPC := 54841;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=65.97776,`position_y`=2661.205,`position_z`=163.6752 WHERE `guid`=@NPC;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,65.97776,2661.205,163.6752,0,0,0,100,0),
(@PATH,2,85.52612,2668.312,163.6752,0,0,0,100,0),
(@PATH,3,119.9537,2689.26,163.6752,0,0,0,100,0),
(@PATH,4,121.8238,2721.88,163.6752,0,0,0,100,0),
(@PATH,5,142.6907,2750.891,163.6752,0,0,0,100,0),
(@PATH,6,149.9812,2788.504,163.6752,0,0,0,100,0),
(@PATH,7,142.9353,2830.464,163.6752,0,0,0,100,0),
(@PATH,8,115.1711,2822.444,163.6752,0,0,0,100,0),
(@PATH,9,57.16672,2791.644,163.6752,0,0,0,100,0),
(@PATH,10,38.80463,2758.823,163.6752,0,0,0,100,0),
(@PATH,11,19.69282,2714.784,163.6752,0,0,0,100,0),
(@PATH,12,23.22027,2677.714,163.6752,0,0,0,100,0);

-- Bat Rider Guard pathing
SET @NPC := 54842;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=263.5968,`position_y`=2694.818,`position_z`=169.7312 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,4097);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,263.5968,2694.818,169.7312,0,0,0,100,0),
(@PATH,2,184.0861,2784.899,154.4534,0,0,0,100,0),
(@PATH,3,154.2815,2754.787,154.3701,0,0,0,100,0),
(@PATH,4,127.0308,2740.488,154.3701,0,0,0,100,0),
(@PATH,5,118.0444,2706.509,154.3701,0,0,0,100,0),
(@PATH,6,115.7577,2669.386,158.6756,0,0,0,100,0),
(@PATH,7,131.4314,2622.531,162.1478,0,0,0,100,0),
(@PATH,8,154.8241,2607.207,164.4812,0,0,0,100,0),
(@PATH,9,176.3283,2571.343,168.5645,0,0,0,100,0),
(@PATH,10,221.6267,2559.683,172.1201,0,0,0,100,0),
(@PATH,11,245.392,2593.423,169.8978,0,0,0,100,0),
(@PATH,12,251.0069,2617.749,169.7312,0,0,0,100,0),
(@PATH,13,263.0581,2644.614,169.7312,0,0,0,100,0);

-- Bat Rider Guard pathing
SET @NPC := 54843;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=62.42025,`position_y`=2785.719,`position_z`=192.1124 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,4097);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,62.42025,2785.719,192.1124,0,0,0,100,0),
(@PATH,2,159.9371,2842.977,208.279,0,0,0,100,0),
(@PATH,3,183.0578,2845.035,208.279,0,0,0,100,0),
(@PATH,4,211.2432,2864.757,214.2235,0,0,0,100,0),
(@PATH,5,238.1182,2871.979,220.9457,0,0,0,100,0),
(@PATH,6,252.9173,2853.913,220.9457,0,0,0,100,0),
(@PATH,7,255.0203,2812.634,220.9457,0,0,0,100,0),
(@PATH,8,240.4993,2780.929,220.9457,0,0,0,100,0),
(@PATH,9,195.4901,2773.965,209.3901,0,0,0,100,0),
(@PATH,10,162.1341,2742.294,212.9179,0,0,0,100,0),
(@PATH,11,125.4935,2720.611,197.9457,0,0,0,100,0),
(@PATH,12,93.49241,2699.757,192.1124,0,0,0,100,0),
(@PATH,13,58.35324,2681.49,192.1124,0,0,0,100,0),
(@PATH,14,22.8833,2715.123,192.1124,0,0,0,100,0),
(@PATH,15,30.10514,2764.5,192.1124,0,0,0,100,0);

-- Fix Bat Rider Guard InhabitType
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=15242;

-- Remove dup Bat Rider Guard spawns
DELETE FROM `creature` WHERE `guid` IN (54839,54844,54845);
DELETE FROM `creature_addon` WHERE `guid` IN (54839,54844,54845);
-- Speech by Martik Tor'seldoi, Thrallmar
SET @ENTRY := 16577;
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,30000,50000,360000,360000,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Martik Tor''seldoi - OOC - Load script every 6 min ooc'),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,11,18100,32,0,0,0,0,1,0,0,0,0,0,0,0, 'Martik Tor''seldoi - Reset - Cast Frost Armor'),
(@ENTRY*100,9,0,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi Say text 0'),
(@ENTRY*100,9,1,0,0,0,100,0,3000,3000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi emote'),
(@ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,5,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi emote'),
(@ENTRY*100,9,3,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,10,57487,16578,0,0,0,0,0,'Blood Elf Pilgrim Say text 0'),
(@ENTRY*100,9,4,0,0,0,100,0,3000,3000,0,0,5,6,0,0,0,0,0,10,57487,16578,0,0,0,0,0,'Blood Elf Pilgrim emote'),
(@ENTRY*100,9,5,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,10,57487,16578,0,0,0,0,0,'Martik Tor''seldoi turn to'),
(@ENTRY*100,9,6,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi Say text 1'),
(@ENTRY*100,9,7,0,0,0,100,0,4000,4000,0,0,1,1,0,0,0,0,0,10,57487,16578,0,0,0,0,0,'Blood Elf Pilgrim Say text 1'),
(@ENTRY*100,9,8,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi Say text 2'),
(@ENTRY*100,9,9,0,0,0,100,0,3000,3000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi emote'),
(@ENTRY*100,9,10,0,0,0,100,0,3000,3000,0,0,5,273,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi emote'),
(@ENTRY*100,9,11,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,10,57487,16578,0,0,0,0,0,'Blood Elf Pilgrim Say text 2'),
(@ENTRY*100,9,12,0,0,0,100,0,1000,1000,0,0,5,15,0,0,0,0,0,9,16578,0,20,0,0,0,0,'Blood Elf Pilgrim emote'),
(@ENTRY*100,9,13,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Martik Tor''seldoi turn to');
-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry` IN (16577,16578);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(16577,0,0, 'Brothers and sisters, I have been to the promised land. I have tasted in the sublim energy. I have felt bliss - bliss so engrossing and all encompassing that I was left wondering if I had stumbled upon the dreams of gods.!',12,0,100,5,0,0, 'Martik Tor''seldoi'),
(16577,1,0, 'In paradise, you merely reach out and take from the Nether.',12,0,100,1,0,0, 'Martik Tor''seldoi'),
(16577,2,0, 'From the very air! Tendrils of arcane energy light up the obsidian sky as plumes of raw magic rise up from fissures in the land. Kneel and drink from the fissure as you do from a stream or well. Pluck a tendril from the heavens as if it were an apple hanging from a branch.',12,0,100,5,0,0, 'Martik Tor''seldoi'),
(16578,0,0, 'Tell us more, Martik. What is it? What does it feel like?',12,0,100,1,0,0, 'Blood Elf Pilgrim'),
(16578,1,0, 'But how?',12,0,100,6,0,0, 'Blood Elf Pilgrim'),
(16578,2,0, '%s smiles/gasps.',16,0,100,0,0,0, 'Blood Elf Pilgrim');
-- Forge of Souls Trash update

-- Npc Updates

-- Spiteful Apparition
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=36551;
UPDATE `creature` SET `spawndist`=20,`MovementType`=1,`curhealth`=1,`curmana`=0 WHERE `id`=36551;
DELETE FROM `creature_template_addon` WHERE `entry`=36551;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES (36551,1, '69105 69136');
-- Spiteful Apparition (Ambient)
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=36967;
UPDATE `creature` SET  `spawndist`=20,`MovementType`=1,`curhealth`=1,`curmana`=0 WHERE `id`=36967;
DELETE FROM `creature_template_addon` WHERE `entry`=36967;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES (36967,1, '69663 69658');
-- Spectral Warden
UPDATE `creature_addon` SET `auras`='69144' WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id`=36666);

-- SAI Updates

-- Spiteful Apparition SAI
SET @ENTRY   := 36551; -- NPC entry
SET @SPELL1  := 41253; -- Greater Invisibility
SET @SPELL2  := 68895; -- Spite (Normal)
SET @SPELL3  := 70212; -- Spite (Heroic)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,6,0,0,0,0,11,@SPELL1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Spiteful Apparition - On Reset - Cast Greater Invisibility'),
(@ENTRY,0,1,0,10,0,100,6,0,10,3000,4000,28,@SPELL1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Spiteful Apparition - OOC range - Remove Greater Invisibility'),
(@ENTRY,0,2,0,0,0,100,2,7000,9000,7000,9000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Spiteful Apparition - Combat - Cast Spite "Normal"'),
(@ENTRY,0,3,0,0,0,100,4,7000,9000,7000,9000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Spiteful Apparition - Combat - Cast Spite "Heroic"');

-- Soulguard Reaper SAI
SET @ENTRY   := 36499; -- NPC entry
SET @SPELL1  := 68797; -- Soulguard Channel
SET @SPELL2  := 69058; -- Shadow Lance
SET @SPELL3  := 69060; -- Frost Nova (Normal)
SET @SPELL4  := 70209; -- Frost Nova (Heroic)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,7,0,0,0,0,11,@SPELL1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Reaper - OOC - Cast Soulguard Channel'),
(@ENTRY,0,1,0,0,0,100,6,5000,6000,7000,9000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Reaper - Combat - Cast Shadow Lance'),
(@ENTRY,0,2,0,0,0,100,2,7000,9000,8000,10000,11,@SPELL3,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Reaper - Combat - Cast Frost Nova "Normal"'),
(@ENTRY,0,3,0,0,0,100,4,7000,9000,8000,10000,11,@SPELL4,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Reaper - Combat - Cast Frost Nova "Heroic"'),
(@ENTRY,0,4,0,4,0,100,6,0,0,0,0,39,30,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Reaper - Aggro - Call for help');

-- Soulguard Beam Focus Target
SET @ENTRY   := 36508; -- NPC entry
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-201770,-201785,-201741);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-201770,0,0,0,1,0,100,6,1000,1000,5000,5000,45,0,1,0,0,0,0,19,36620,60,0,0,0,0,0, 'Soulguard Beam Focus Target - OOC - Set data on Soulguard Adept'),
(-201785,0,0,0,1,0,100,6,1000,1000,5000,5000,45,0,1,0,0,0,0,19,36620,60,0,0,0,0,0, 'Soulguard Beam Focus Target - OOC - Set data on Soulguard Adept'),
(-201741,0,0,0,1,0,100,6,1000,1000,5000,5000,45,0,1,0,0,0,0,19,36620,60,0,0,0,0,0, 'Soulguard Beam Focus Target - OOC - Set data on Soulguard Adept'),
(-201741,0,1,0,1,0,100,6,1000,1000,5000,5000,45,0,1,0,0,0,0,19,36564,60,0,0,0,0,0, 'Soulguard Beam Focus Target - OOC - Set data on Soulguard Bonecaster');

-- Spectral Warden SAI
SET @ENTRY   := 36666; -- NPC entry
SET @SPELL1  := 69633; -- Veil of Shadow
SET @SPELL2  := 69148; -- Wail of Souls (Normal)
SET @SPELL3  := 70210; -- Wail of Souls (Heroic)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,6,5000,6000,9000,10000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Spectral Warden - Combat - Cast Veil of Shadow'),
(@ENTRY,0,1,0,0,0,100,2,9000,11000,5000,6000,11,@SPELL1,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Spectral Warden - Combat - Cast Wail of Souls'),
(@ENTRY,0,2,0,0,0,100,4,9000,11000,5000,6000,11,@SPELL2,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Spectral Warden - Combat - Cast Wail of Souls');

-- Soulguard Watchman SAI
SET @ENTRY   := 36478; -- NPC entry
SET @SPELL1  := 69056; -- Shroud of Runes
SET @SPELL2  := 69053; -- Unholy Rage
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,50,6,0,10000,16000,20000,11,@SPELL1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Watchman - Combat - Cast Shroud of Runes'),
(@ENTRY,0,1,2,0,0,100,6,8000,16000,32000,40000,11,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Watchman - Combat - Cast Unholy Rage'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Watchman - Combat - Say 0'),
(@ENTRY,0,3,0,4,0,100,6,0,0,0,0,39,20,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Watchman - Aggro - Call for help');
-- NPC talk text insert
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s goes into a frenzy!',16,0,100,0,0,0, 'Soulguard Watchman');

-- Soul Horror SAI
SET @ENTRY   := 36522; -- NPC entry
SET @SPELL1  := 69088; -- Soul Strike (Normal)
SET @SPELL2  := 70211; -- Soul Strike (Heroic)
SET @SPELL3  := 69107; -- Killing Spree Invis Aura
SET @SPELL4  := 69106; -- Killing Spree Aura
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,5000,6000,5000,6000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soul Horror - Combat - Cast Soul Strike'),
(@ENTRY,0,1,0,0,0,100,4,5000,6000,5000,6000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soul Horror - Combat - Cast Soul Strike'),
(@ENTRY,0,4,0,4,0,100,6,0,0,0,0,39,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soul Horror - Aggro - Call for help');

-- Soulguard Animator SAI
SET @ENTRY   := 36516; -- NPC entry
SET @SPELL1  := 68834; -- Soulguard Channel Beam02
SET @SPELL2  := 69562; -- Raise Dead
SET @SPELL3  := 69131; -- Soul Sickness
SET @SPELL4  := 69128; -- Soul Siphon
SET @SPELL5  := 69068; -- Shadow Bolt (Normal)
SET @SPELL6  := 70208; -- Shadow Bolt (Heroic)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,7,1000,1000,1000,1000,11,@SPELL1,0,0,0,0,0,9,36522,1,15,0,0,0,0, 'Soulguard Animator - OOC - Cast Soulguard Channel Beam02'),
(@ENTRY,0,1,0,0,1,100,6,20000,25000,20000,25000,11,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Combat - Cast Raise Dead'),
(@ENTRY,0,2,0,0,0,100,6,7000,9000,9000,11000,11,@SPELL3,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Animator - Combat - Cast Soul Sickness'),
(@ENTRY,0,3,0,0,0,100,6,9000,11000,7000,9000,11,@SPELL4,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Animator - Combat - Cast Soul Siphon'),
(@ENTRY,0,4,0,0,0,100,2,4000,5000,3500,4500,11,@SPELL5,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Animator - Combat - Cast Shadow Bolt "Normal"'),
(@ENTRY,0,5,0,0,0,100,4,4000,5000,3500,4500,11,@SPELL6,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Animator - Combat - Cast Shadow Bolt "Heroic"'),
(@ENTRY,0,6,7,4,0,100,6,0,0,0,0,39,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Aggro - Call for help'),
(@ENTRY,0,7,0,61,0,100,6,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Aggro - Set phase 1'),
(@ENTRY,0,8,9,38,0,100,7,0,2,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Data set 2 - Set data'),
(@ENTRY,0,9,0,61,0,100,6,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Data set 2 - Set phase 2'),
(@ENTRY,0,10,11,38,0,100,7,0,3,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Data set 3 - Set data'),
(@ENTRY,0,11,0,61,0,100,6,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Animator - Data set 3 - Set phase 1');

-- Soulguard Adept SAI
SET @ENTRY   := 36620; -- NPC entry
SET @SPELL1  := 68834; -- Soulguard Channel Beam02
SET @SPELL2  := 69562; -- Raise Dead
SET @SPELL3  := 69068; -- Shadow Bolt (Normal)
SET @SPELL4  := 70208; -- Shadow Bolt (Heroic)
SET @SPELL5  := 69066; -- Drain Life (Normal)
SET @SPELL6  := 70213; -- Drain Life (Heroic)
SET @SPELL7  := 69564; -- Shadow Mend (Normal)
SET @SPELL8  := 70205; -- Shadow Mend (Heroic)
SET @SPELL9  := 68797; -- Soulguard Channel
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,7,1000,1000,1000,1000,11,@SPELL1,0,0,0,0,0,9,36522,1,15,0,0,0,0, 'Soulguard Adept - OOC - Cast Soulguard Channel Beam02'),
(@ENTRY,0,1,0,0,4,100,6,20000,25000,20000,25000,11,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Raise Dead'),
(@ENTRY,0,2,0,0,0,100,2,7000,8000,3500,4500,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Shadow Bolt "Normal"'),
(@ENTRY,0,3,0,0,0,100,4,7000,8000,3500,4500,11,@SPELL4,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Shadow Bolt "Heroic"'),
(@ENTRY,0,4,0,0,0,100,2,6000,7000,8000,10000,11,@SPELL5,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Drain Life "Normal"'),
(@ENTRY,0,5,0,0,0,100,4,6000,7000,8000,10000,11,@SPELL6,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Drain Life "Heroic"'),
(@ENTRY,0,6,0,0,0,100,2,30000,35000,18000,22000,11,@SPELL7,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Shadow Mend "Normal"'),
(@ENTRY,0,7,0,0,0,100,4,30000,35000,18000,22000,11,@SPELL8,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Adept - Combat - Cast Shadow Mend "Heroic"'),
(@ENTRY,0,8,0,25,0,100,6,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - On Reset - Set phase 1'),
(@ENTRY,0,9,0,38,1,100,6,0,1,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - On dataset 0 1 - Set phase 2'),
(@ENTRY,0,10,0,1,2,100,7,0,0,0,0,11,@SPELL9,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - OOC - Cast Soulguard Channel'),
(@ENTRY,0,11,12,4,0,100,6,0,0,0,0,39,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Aggro - Call for help'),
(@ENTRY,0,12,0,61,0,100,6,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Aggro - Set phase 3'),
(@ENTRY,0,13,14,38,0,100,7,0,2,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Data set 2 - Set data'),
(@ENTRY,0,14,0,61,0,100,6,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Data set 2 - Set phase 4'),
(@ENTRY,0,15,16,38,0,100,7,0,3,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Data set 3 - Set data'),
(@ENTRY,0,16,0,61,0,100,6,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Adept - Data set 3 - Set phase 3');

-- Soulguard Bonecaster SAI
SET @ENTRY   := 36564; -- NPC entry
SET @SPELL1  := 68834; -- Soulguard Channel Beam02
SET @SPELL2  := 69562; -- Raise Dead
SET @SPELL3  := 69080; -- Bone Volley (Normal)
SET @SPELL4  := 70206; -- Bone Volley (Heroic)
SET @SPELL5  := 69069; -- Shield of Bones (Normal)
SET @SPELL6  := 70207; -- Shield of Bones (Heroic)
SET @SPELL7  := 68797; -- Soulguard Channel
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,7,1000,1000,1000,1000,11,@SPELL1,0,0,0,0,0,9,36522,1,15,0,0,0,0, 'Soulguard Bonecaster - OOC - Cast Soulguard Channel Beam02'),
(@ENTRY,0,1,0,0,4,100,6,20000,25000,20000,25000,11,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Combat - Cast Raise Dead'),
(@ENTRY,0,2,0,0,0,100,2,5000,7000,6000,8000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Combat - Cast Bone Volley "Normal"'),
(@ENTRY,0,3,0,0,0,100,4,5000,7000,6000,8000,11,@SPELL4,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Combat - Cast Bone Volley "Heroic"'),
(@ENTRY,0,4,0,0,0,100,2,5000,7000,7000,9000,11,@SPELL5,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Combat - Cast Shield of Bones "Normal"'),
(@ENTRY,0,5,0,0,0,100,4,5000,7000,7000,9000,11,@SPELL6,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Combat - Cast Shield of Bones "Heroic"'),
(@ENTRY,0,6,0,25,0,100,6,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - On Reset - Set phase 1'),
(@ENTRY,0,7,0,38,1,100,6,0,1,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - On dataset 0 1 - Set phase 2'),
(@ENTRY,0,8,0,1,2,100,7,0,0,0,0,11,@SPELL7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - OOC - Cast Soulguard Channel'),
(@ENTRY,0,9,10,4,0,100,6,0,0,0,0,39,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Aggro - Call for help'),
(@ENTRY,0,10,0,61,0,100,6,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Aggro - Set phase 3'),
(@ENTRY,0,11,12,38,0,100,7,0,2,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Data set 2 - Set data'),
(@ENTRY,0,12,0,61,0,100,6,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Data set 2 - Set phase 4'),
(@ENTRY,0,13,14,38,0,100,7,0,3,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Data set 3 - Set data'),
(@ENTRY,0,14,0,61,0,100,6,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Soulguard Bonecaster - Data set 3 - Set phase 3');

-- Ghoul Minion SAI
SET @ENTRY   := 36916; -- NPC entry
SET @SPELL1  := 69088; -- Soul Strike (Normal)
SET @SPELL2  := 70211; -- Soul Strike (Heroic)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,6,0,0,0,0,45,0,2,0,0,0,0,23,0,0,0,0,0,0,0, 'Ghoul Minion - Just Summoned - Set Data Summoner'),
(@ENTRY,0,1,0,61,0,100,6,0,0,0,0,89,5,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ghoul Minion - Just Summoned - Set Random Movement'),
(@ENTRY,0,2,0,0,0,100,6,115000,115000,115000,115000,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ghoul Minion - combat - die after 2 min'),
(@ENTRY,0,3,0,1,0,100,6,15000,15000,15000,15000,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ghoul Minion - OOC - die after 15 sec'),
(@ENTRY,0,4,5,6,0,100,6,15000,15000,15000,15000,45,0,3,0,0,0,0,23,0,0,0,0,0,0,0, 'Ghoul Minion - on Death - Set data summoner'),
(@ENTRY,0,5,0,61,0,100,6,15000,15000,15000,15000,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ghoul Minion - on Death - despawn after 3 sec');
-- Set proper faction for Ymirjar Skycaller (Heroic)
UPDATE `creature_template` SET `faction_A`=1885,`faction_H`=1885 WHERE `entry`=37643;
-- Add some missing Blood of Heroes spawns
SET @GUID := 5276;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GUID AND @GUID+5;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
(@GUID,176213,0,1,1,1529.10242,-1427.06946,65.49049,-3.001947,0,0,-0.9975634,0.06976615,7200,100,1),
(@GUID+1,176213,0,1,1,1705.87439,-4690.138,48.9742165,-3.08918333,0,0,-0.9996567,0.02620165,7200,100,1),
(@GUID+2,176213,0,1,1,1846.79382,-3825.265,135.5159,1.83259487,0,0,0.7933531,0.6087617,7200,100,1),
(@GUID+3,176213,0,1,1,1748.16333,-4453.13525,74.26272,-2.0594883,0,0,0,0,7200,100,1),
(@GUID+4,176213,0,1,1,2159.835,-2442.754,62.0804,-0.4886912,0,0,-0.2419214,0.9702958,7200,100,1),
(@GUID+5,176213,0,1,1,1342.557,-1382.568,46.89193,2.775069,0,0,0.9832544,0.182238,7200,100,1);
-- Wrathbone Laborer SAI
SET @ENTRY   := 36830; -- NPC entry
SET @SPELL1  := 70302; -- Blinding Dirt
SET @SPELL2  := 70278; -- Puncture Wound (Normal)
SET @SPELL3  := 70279; -- Puncture Wound (Heroic)
SET @SPELL4  := 69572; -- Shovelled! (Normal)
SET @SPELL5  := 70280; -- Shovelled! (Heroic)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256,`AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,6,7000,8000,10000,11000,11,@SPELL1,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Blinding Dirt'),
(@ENTRY,0,1,0,0,0,100,2,8000,9000,9000,10000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Puncture Wound (Normal)'),
(@ENTRY,0,2,0,0,0,100,4,8000,9000,9000,10000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Puncture Wound (Heroic)'),
(@ENTRY,0,3,0,0,0,100,2,5000,6000,7000,8000,11,@SPELL4,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Shovelled! (Normal)'),
(@ENTRY,0,4,0,0,0,100,4,5000,6000,7000,8000,11,@SPELL5,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Shovelled! (Heroic)'),
(@ENTRY,0,5,0,1,0,100,6,1000,3000,3000,3000,5,38,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Wrathbone Laborer - OOC - emote');
-- Fix InhabitType for Eye of the Lich King
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=36913;
-- Updates From CDawg
-- Wrathbone Laborer (heroic) - fix hostility and adds equipment
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256,`equipment_id`=104 WHERE `entry`=37638;
-- Wrathbone Siegesmith (Heroic) add equipment
UPDATE `creature_template` SET `equipment_id`=122 WHERE `entry`=37639;
-- Fallen Warrior add equipment
UPDATE `creature_template` SET `equipment_id`=2328 WHERE `entry`=37612;
-- Forgemaster Garfrost add equipment
UPDATE `creature_template` SET `equipment_id`=2325 WHERE `entry`=37613;
-- Deathwhisper Necrolyte add equipment
UPDATE `creature_template` SET `equipment_id`=2365 WHERE `entry`=37609;
-- Deathwhisper Shadowcaster - add equipment
UPDATE `creature_template` SET `equipment_id`=2365 WHERE `entry`=38025;
-- Alliance slaves add equipments
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37645;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37646;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37647;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37648;
-- horde slaves add equipments
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37649;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37650;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37651;
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=37652;
-- Ymirjar Skycaller (heroic) - Fix unit flags and add equipment
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|32832,`equipment_id`=2438 WHERE `entry`=37643;
-- Fix skillup on some target dummys
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|262144 WHERE `entry` IN (31144,2674,2673);
-- Wrathbone Laborer SAI
SET @ENTRY   := 36830; -- NPC entry
SET @SPELL1  := 70302; -- Blinding Dirt
SET @SPELL2  := 70278; -- Puncture Wound
SET @SPELL3  := 69572; -- Shovelled!
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256,`AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,6,7000,8000,10000,11000,11,@SPELL1,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Blinding Dirt'),
(@ENTRY,0,1,0,0,0,100,6,8000,9000,9000,10000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Puncture Wound (Normal)'),
(@ENTRY,0,2,0,0,0,100,6,5000,6000,7000,8000,11,@SPELL3,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Shovelled! (Normal)'),
(@ENTRY,0,3,0,1,0,100,6,1000,3000,3000,3000,5,38,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Wrathbone Laborer - OOC - emote');
-- Gold for Toc based on old.wowhead
UPDATE `creature_template` SET `mingold`=850000,`maxgold`=950000 WHERE `entry` IN(34797,35447,35448,35449); -- Icehowl
UPDATE `creature_template` SET `mingold`=550000,`maxgold`=650000 WHERE `entry` IN(34780,35216,35268,35269); -- Lord Jaraxxus
UPDATE `creature_template` SET `mingold`=650000,`maxgold`=700000 WHERE `entry` IN(34497,35350,35351,35352,34496,35347,35348,35359); -- Fjola Lightbane & Eydis Darkbane
UPDATE `creature_template` SET `mingold`=500000,`maxgold`=600000 WHERE `entry` IN(34564,34566,35615,35616); -- Anub'arak
-- Based on old.wowhead.com
UPDATE `creature_template` SET `mingold`=1600000,`maxgold`=1800000 WHERE `entry` IN (33113,34003); -- Flame Levithian
UPDATE `creature_template` SET `mingold`=1100000,`maxgold`=1300000 WHERE `entry` IN (33118,33190); -- Ignis the Furnace Master
UPDATE `creature_template` SET `mingold`=280000,`maxgold`=360000 WHERE `entry` IN (33186,33724); -- Razorscale
UPDATE `creature_template` SET `mingold`=670000,`maxgold`=750000 WHERE `entry` IN (33293,33885); -- XT-002 Deconstructor
UPDATE `creature_template` SET `mingold`=1680000,`maxgold`=1900000 WHERE `entry` IN (32857,33694); -- Stormcaller Brundir
UPDATE `creature_template` SET `mingold`=1680000,`maxgold`=1900000 WHERE `entry` IN (32927,33692); -- Runemaster Molgeim
UPDATE `creature_template` SET `mingold`=1680000,`maxgold`=1900000 WHERE `entry` IN (32867,33693); -- Steelbreaker
UPDATE `creature_template` SET `mingold`=1220000,`maxgold`=1500000 WHERE `entry` IN (33515,34175); -- Auriaya
UPDATE `creature_template` SET `mingold`=1650000,`maxgold`=1950000 WHERE `entry` IN (33271,33449); -- General Vezax
UPDATE `creature_template` SET `mingold`=2020000,`maxgold`=2220000 WHERE `entry` IN (33288,33955); -- Yogg-Saron
-- Wrathbone Siegesmith pathing
SET @NPC := 202159;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=646.5851,`position_y`=-191.1892,`position_z`=526.8476 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,1);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,646.5851,-191.1892,526.8476,0,0,0,100,0),
(@PATH,2,648.8837,-181.967,526.7226,0,0,0,100,0),
(@PATH,3,649.4167,-179.4531,526.7226,14000,0,0,100,0),
(@PATH,4,652.1736,-183.3594,526.7226,0,0,0,100,0),
(@PATH,5,648.5643,-188.309,526.8476,0,0,0,100,0),
(@PATH,6,642.5313,-193.4826,527.3874,0,0,0,100,0),
(@PATH,7,633.688,-200.741,528.941,12000,0,0,100,0),
(@PATH,8,641.9254,-196.5747,528.9726,0,0,0,100,0);

-- Wrathbone Siegesmith pathing
SET @NPC := 201855;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=723.5469,`position_y`=-170.9497,`position_z`=527.5121 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,1);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,723.5469,-170.9497,527.5121,13000,0,0,100,0),
(@PATH,2,726.6484,-173.3438,527.1627,0,0,0,100,0),
(@PATH,3,726.6484,-174.3438,527.1627,0,0,0,100,0),
(@PATH,4,725.25,-175.2379,526.8134,0,0,0,100,0),
(@PATH,5,722.0521,-181.5122,526.8134,0,0,0,100,0),
(@PATH,6,721.2031,-187.8142,526.8134,0,0,0,100,0),
(@PATH,7,717.7917,-194.4358,526.8134,0,0,0,100,0),
(@PATH,8,719.3073,-202.2691,527.1509,0,0,0,100,0),
(@PATH,9,720.3403,-206.1198,527.7932,12000,0,0,100,0),
(@PATH,10,717.6111,-199.5035,526.9384,0,0,0,100,0),
(@PATH,11,717.566,-189.0642,526.8134,0,0,0,100,0),
(@PATH,12,718.5764,-182.3958,526.8134,0,0,0,100,0),
(@PATH,13,719.9531,-176.0729,526.8134,0,0,0,100,0);

-- Forgemaster Garfrost pathing
SET @NPC := 201992;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=712.1371,`position_y`=-215.7014,`position_z`=527.066 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`auras`) VALUES (@NPC,@PATH,1,'68792');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,712.1371,-215.7014,527.066,0,0,0,100,0),
(@PATH,2,719.507,-227.8559,527.066,3000,0,0,100,0),
(@PATH,3,712.1371,-215.7014,527.066,0,0,0,100,0),
(@PATH,4,685.1805,-207.349,526.8424,0,0,0,100,0),
(@PATH,5,664.5191,-203.3472,526.816,0,0,0,100,0),
(@PATH,6,645.033,-208.5295,528.941,0,0,0,100,0),
(@PATH,7,653.0729,-194.3681,526.7226,0,0,0,100,0),
(@PATH,8,664.8646,-195.2135,526.7226,0,0,0,100,0),
(@PATH,9,686.0816,-213.8264,526.8424,0,0,0,100,0),
(@PATH,10,697.9757,-221.6215,526.8424,0,0,0,100,0),
(@PATH,11,708.0903,-211.908,527.066,0,0,0,100,0),
(@PATH,12,717.8924,-204.6979,527.191,0,0,0,100,0),
(@PATH,13,699.0504,-201.3438,526.8424,0,0,0,100,0),
(@PATH,14,672.066,-201.1493,526.8424,0,0,0,100,0),
(@PATH,15,655.9496,-203.4931,526.816,0,0,0,100,0),
(@PATH,16,672.066,-201.1493,526.8424,0,0,0,100,0),
(@PATH,17,699.0504,-201.3438,526.8424,0,0,0,100,0),
(@PATH,18,717.8924,-204.6979,527.191,0,0,0,100,0),
(@PATH,19,708.0903,-211.908,527.066,0,0,0,100,0),
(@PATH,20,697.9757,-221.6215,526.8424,0,0,0,100,0),
(@PATH,21,686.0816,-213.8264,526.8424,0,0,0,100,0),
(@PATH,22,664.8646,-195.2135,526.7226,0,0,0,100,0),
(@PATH,23,653.0729,-194.3681,526.7226,0,0,0,100,0),
(@PATH,24,645.033,-208.5295,528.941,0,0,0,100,0),
(@PATH,25,664.5191,-203.3472,526.816,0,0,0,100,0),
(@PATH,26,685.1805,-207.349,526.8424,0,0,0,100,0);
-- Ymirjar Skycaller SAI addition
SET @ENTRY   := 31260; -- NPC entry
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,2,0,25,0,100,6,0,0,0,0,11,46598,0,0,0,0,0,19,36891,20,0,0,0,0,0, 'Ymirjar Skycaller - Reset - Cast Ride Vehicle Hardcoded');

-- Wrathbone Laborer SAI
SET @ENTRY   := -201800; -- NPC entry
SET @SPELL1  := 70302; -- Blinding Dirt
SET @SPELL2  := 70278; -- Puncture Wound
SET @SPELL3  := 69572; -- Shovelled!
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,6,7000,8000,10000,11000,11,@SPELL1,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Blinding Dirt'),
(@ENTRY,0,1,0,0,0,100,6,8000,9000,9000,10000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Puncture Wound (Normal)'),
(@ENTRY,0,2,0,0,0,100,6,5000,6000,7000,8000,11,@SPELL3,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Wrathbone Laborer - Combat - Cast Shovelled! (Normal)');

-- Wrathbone Laborer pathing
SET @NPC := 201800;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=584.4202,`position_y`=188.9149,`position_z`=509.6726 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,1);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,584.4202,188.9149,509.6726,0,0,0,100,0),
(@PATH,2,583.6736,193.9653,509.7404,3000,0,48,100,0),
(@PATH,3,583.6736,193.9653,509.7404,3000,0,48,100,0),
(@PATH,4,583.6736,193.9653,509.7404,3000,0,48,100,0),
(@PATH,5,583.6736,193.9653,509.7404,3000,0,48,100,0),
(@PATH,6,594.0781,190.2622,508.8613,0,0,0,100,0),
(@PATH,7,604.9809,191.5451,507.6583,0,0,0,100,0),
(@PATH,8,617.8438,191.3455,507.5206,0,0,0,100,0),
(@PATH,9,633.1597,186.8281,508.6275,3000,0,48,100,0),
(@PATH,10,633.1597,186.8281,508.6275,3000,0,48,100,0),
(@PATH,11,624.3472,190.9705,507.7706,0,0,0,100,0),
(@PATH,12,613.3229,189.9236,507.3956,0,0,0,100,0),
(@PATH,13,604.5156,189.651,507.3956,0,0,0,100,0),
(@PATH,14,593.9844,187.4479,508.9778,0,0,0,100,0),
(@PATH,15,584.4202,188.9149,509.6726,0,0,0,100,0);
DELETE FROM `waypoint_scripts` WHERE `id`=48;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`guid`) VALUES
(48,0,1,38,67);

-- Add Overlord Drakuru riders to Stonespine Gargoyle
UPDATE creature_template SET InhabitType=4,`flags_extra`=`flags_extra`|128 WHERE entry=28717;
DELETE FROM `creature` WHERE `id`=28717 AND `map`=658;
DELETE FROM `vehicle_template_accessory` WHERE `entry`=36896;
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(36896,28717,1,0, 'Overlord Drakuru on Stonespine Gargoyle',6,30000);
-- [Q] Arelion's Mistress
-- Viera Sunwhisper SAI
-- Twinkle SAI
SET @ENTRY_VIERA := 17226;
SET @ENTRY_TWINKLE := 17230;
SET @QUEST_PLEASURES := 9483;
SET @SPELL_RETRIBUTION := 30077;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_VIERA,@ENTRY_TWINKLE);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_VIERA,@ENTRY_TWINKLE,@ENTRY_VIERA*100,@ENTRY_VIERA*100+1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY_VIERA,0,0,0,20,0,100,0,@QUEST_PLEASURES,0,0,0,80,@ENTRY_VIERA*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Quest Finish - Run Script'),
(@ENTRY_VIERA*100,9,0,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Viera Sunwhisper - On Script - Remove Quest Flag"),
(@ENTRY_VIERA*100,9,1,0,0,0,100,0,2000,2000,0,0,53,0,@ENTRY_VIERA,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Start WP 1'),
(@ENTRY_VIERA*100,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Say Line 0'),
(@ENTRY_VIERA*100,9,3,0,0,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Stand Up'),
(@ENTRY_VIERA*100,9,4,0,0,0,100,0,6500,6500,0,0,45,0,1,0,0,0,0,10,61963,@ENTRY_TWINKLE,0,0,0,0,0,'Viera Sunwhisper - On Script - Set Data 0 1 Twinkle'),
(@ENTRY_VIERA,0,1,2,40,0,100,0,10,@ENTRY_VIERA,0,0,66,0,0,0,0,0,0,11,@ENTRY_TWINKLE,15,0,0,0,0,0,'Viera Sunwhisper - On WP 10 - Face Twinkle'),
(@ENTRY_VIERA,0,2,0,61,0,100,0,0,0,0,0,54,1000000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On WP 10 - Pause WP'),

(@ENTRY_TWINKLE,0,0,0,38,0,100,0,0,1,0,0,53,1,@ENTRY_TWINKLE,0,0,0,0,1,0,0,0,0,0,0,0,'Twinkle - On Data 0 1 Set - Start WP 1 (run)'),
(@ENTRY_TWINKLE,0,1,0,40,0,100,0,13,@ENTRY_TWINKLE,0,0,54,1000000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Twinkle - On WP 13 - Pause WP'),
(@ENTRY_TWINKLE,0,2,0,38,0,100,0,1,2,0,0,53,1,@ENTRY_TWINKLE*10,0,0,0,0,1,0,0,0,0,0,0,0,'Twinkle - On Data Set 1 2 - Start WP 2 (run)'),
(@ENTRY_TWINKLE,0,3,0,40,0,100,0,4,@ENTRY_TWINKLE*10,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On WP 4 (2) - Force Despawn'),

(@ENTRY_VIERA,0,3,0,8,0,100,0,@SPELL_RETRIBUTION,0,0,0,80,@ENTRY_VIERA*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Spellhit - Run Second Script'),
(@ENTRY_VIERA*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Say Line 1'),
(@ENTRY_VIERA*100+1,9,1,0,0,0,100,0,0,0,0,0,33,@ENTRY_VIERA,0,0,0,0,0,7,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Quest Credit'),
(@ENTRY_VIERA*100+1,9,2,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Say Line 2'),
(@ENTRY_VIERA*100+1,9,3,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,9,@ENTRY_TWINKLE,0,25,0,0,0,0,'Twinkle - On Script - Say Line 0'),
(@ENTRY_VIERA*100+1,9,4,0,0,0,100,0,2000,2000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Say Line 3'),
(@ENTRY_VIERA*100+1,9,5,0,0,0,100,0,0,0,0,0,45,1,2,0,0,0,0,10,61963,@ENTRY_TWINKLE,0,0,0,0,0,'Viera Sunwhisper - On Script - Set Data 1 2 Twinkle'),
(@ENTRY_VIERA*100+1,9,6,0,0,0,100,0,0,0,0,0,53,1,@ENTRY_VIERA*10,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On Script - Start WP 2 (run)'),
(@ENTRY_VIERA,0,4,0,40,0,100,0,4,@ENTRY_VIERA*10,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Viera Sunwhisper - On WP 4 (2) - Force Despawn');

-- Waypoints for Viera Sunwhisper
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY_VIERA,@ENTRY_VIERA*10);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY_VIERA,1,-653.739197,4145.138184,64.200729,'Viera Sunwhisper'),
(@ENTRY_VIERA,2,-658.875732,4147.715332,64.168304,'Viera Sunwhisper'),
(@ENTRY_VIERA,3,-681.465088,4147.636230,64.118073,'Viera Sunwhisper'),
(@ENTRY_VIERA,4,-686.400696,4161.865234,59.707859,'Viera Sunwhisper'),
(@ENTRY_VIERA,5,-695.956909,4179.237305,57.618931,'Viera Sunwhisper'),
(@ENTRY_VIERA,6,-699.832153,4189.959473,57.503750,'Viera Sunwhisper'),
(@ENTRY_VIERA,7,-708.518616,4184.436035,55.275894,'Viera Sunwhisper'),
(@ENTRY_VIERA,8,-716.137268,4178.130371,52.637508,'Viera Sunwhisper'),
(@ENTRY_VIERA,9,-719.865295,4174.992676,51.554867,'Viera Sunwhisper'),
(@ENTRY_VIERA,10,-720.839417,4162.232422,50.805923,'Viera Sunwhisper'),

(@ENTRY_VIERA*10,1,-722.323486,4147.936523,50.337898,'Viera Sunwhisper'),
(@ENTRY_VIERA*10,2,-726.639343,4125.156250,48.479683,'Viera Sunwhisper'),
(@ENTRY_VIERA*10,3,-727.648315,4109.684082,47.528461,'Viera Sunwhisper'),
(@ENTRY_VIERA*10,4,-727.874329,4093.438721,46.446579,'Viera Sunwhisper');

-- Waypoints for Twinkle
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY_TWINKLE,@ENTRY_TWINKLE*10);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY_TWINKLE,1,-605.445190,4165.205078,64.081802,'Twinkle'),
(@ENTRY_TWINKLE,2,-619.293335,4161.776855,63.217815,'Twinkle'),
(@ENTRY_TWINKLE,3,-629.536560,4153.708984,64.067123,'Twinkle'),
(@ENTRY_TWINKLE,4,-644.773438,4151.062988,64.174675,'Twinkle'),
(@ENTRY_TWINKLE,5,-658.875732,4147.715332,64.168304,'Twinkle'),
(@ENTRY_TWINKLE,6,-681.465088,4147.636230,64.118073,'Twinkle'),
(@ENTRY_TWINKLE,7,-686.400696,4161.865234,59.707859,'Twinkle'),
(@ENTRY_TWINKLE,8,-695.956909,4179.237305,57.618931,'Twinkle'),
(@ENTRY_TWINKLE,9,-699.832153,4189.959473,57.503750,'Twinkle'),
(@ENTRY_TWINKLE,10,-708.518616,4184.436035,55.275894,'Twinkle'),
(@ENTRY_TWINKLE,11,-716.137268,4178.130371,52.637508,'Twinkle'),
(@ENTRY_TWINKLE,12,-719.865295,4174.992676,51.554867,'Twinkle'),
(@ENTRY_TWINKLE,13,-720.636292,4166.637695,50.815567,'Twinkle'),

(@ENTRY_TWINKLE*10,1,-722.323486,4147.936523,50.337898,'Twinkle'),
(@ENTRY_TWINKLE*10,2,-726.639343,4125.156250,48.479683,'Twinkle'),
(@ENTRY_TWINKLE*10,3,-727.648315,4109.684082,47.528461,'Twinkle'),
(@ENTRY_TWINKLE*10,4,-727.874329,4093.438721,46.446579,'Twinkle');

-- Spawn spell focus object on correct position
DELETE FROM `gameobject` WHERE `id`=300071 AND `guid`=303;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(303,300071,530,1,1,-720.803,4162.77,50.7916,4.61029,0,0,0.742267,-0.670104,300,0,1);

-- Texts
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY_VIERA,@ENTRY_TWINKLE);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY_VIERA,0,0,"Ok, let's go. I know just the perfect spot!",12,0,100,0,0,0,'Viera Sunwhisper'),
(@ENTRY_VIERA,1,0,"I can't wait to try this wine!",12,0,100,0,0,0,'Viera Sunwhisper'),
(@ENTRY_VIERA,2,0,"What... is happening... to me? Get this cat away from me!",12,0,100,0,0,0,'Viera Sunwhisper'),
(@ENTRY_VIERA,3,0,"%s scurries away, attempting to flee from Twinkle",16,0,100,0,0,0,'Viera Sunwhisper'),

(@ENTRY_TWINKLE,0,0,"%s looks at Viera Sunwhisper with very hungry eyes",16,0,100,0,0,0,'Twinkle');
-- Add Missing Ice Wall, Pit of Saron
SET @GUID := 305;
DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
(@GUID,201885,658,3,1,932.2674,-80.6684,591.6761,2.286379,0,0,0,0,300,100,1);
-- Spell area spells for entering POS
DELETE FROM `spell_area` WHERE `spell` IN (70056,70057);
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES
(70056,4904,0,0,0,0,690,2,1), -- Send Script Event (22717)
(70057,4904,0,0,0,0,1101,2,1); -- Send Script Event (22718)

-- Fix flags and equipment for Ymirjar Deathbringer
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry` IN (36892,37641);
UPDATE `creature_template` SET `equipment_id`=2444 WHERE `entry`=37641;
DELETE FROM `spell_target_position` WHERE `id` IN (67834, 68081);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(67834, 571, 3167.01, 5586.04, 880.067, 0),
(68081, 571, 5857.252, 516.8015, 599.82, 2.987);

UPDATE `spell_target_position` SET `target_position_x`=6136.89,`target_position_y`=4785.55,`target_position_z`=100.673 WHERE `id`=67835;
UPDATE `spell_target_position` SET `target_position_x`=8301.39,`target_position_y`=1501.34,`target_position_z`=870.555 WHERE `id`=67836;
DELETE FROM `trinity_string` WHERE `entry` = 555;
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(555,"SetData performed on [GUID: %u, entry: %u, name: %s] Field: %u, Data: %u, with %s");

DELETE FROM `command` WHERE `name` = "npc set data";
INSERT INTO `command` (`name`,`security`,`help`) VALUES
("npc set data", 3, "Syntax: .npc set data $field $data
Sets data for the selected creature. Used for testing Scripting");
-- Fixup for Quest Quest:The Path to the Citadel "Alliance and Horde"

-- Alliance slave add missing equipments
UPDATE `creature_template` SET `equipment_id`=254 WHERE `entry`=36767;

-- Horde Slave SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (36770,36771,36772,36773);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (36770,36771,36772,36773);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (3677000);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36770,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Reset - Emotestate'),
(36771,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Reset - Emotestate'),
(36772,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Reset - Emotestate'),
(36773,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Reset - Emotestate'),
(36770,0,1,0,8,0,100,7,71281,0,0,0,80,3677000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Spellhit - Run Script'),
(36771,0,1,0,8,0,100,7,71281,0,0,0,80,3677000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Spellhit - Run Script'),
(36772,0,1,0,8,0,100,7,71281,0,0,0,80,3677000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Spellhit - Run Script'),
(36773,0,1,0,8,0,100,7,71281,0,0,0,80,3677000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - On Spellhit - Run Script'),
-- Script
(3677000,9,0,0,0,0,100,0,500,500,500,500,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Horde Slave - Script - Turnto envoker'),
(3677000,9,1,0,0,0,100,0,500,500,500,500,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - say text'),
(3677000,9,2,0,0,0,100,0,100,100,100,100,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - set unitflag'),
(3677000,9,3,0,0,0,100,0,100,100,100,100,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - set faction'),
(3677000,9,4,0,0,0,100,0,100,100,100,100,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - set Emotestate'),
(3677000,9,5,0,0,0,100,0,100,100,100,100,33,36770,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Horde Slave - Script - give quest credit'),
(3677000,9,6,0,0,0,100,0,100,100,100,100,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - set run on'),
(3677000,9,7,0,0,0,100,0,500,500,500,500,69,1,0,0,0,0,0,19,23837,70,0,0,0,0,0, 'Horde Slave - Script - move to closest trigger'),
(3677000,9,8,0,0,0,100,0,8000,8000,8000,8000,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Horde Slave - Script - despawn');

-- Alliance Slave SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (36764,36765,36766,36767);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (36764,36765,36766,36767);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (3676400);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36764,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Reset - Emotestate'),
(36765,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Reset - Emotestate'),
(36766,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Reset - Emotestate'),
(36767,0,0,0,11,0,100,6,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Reset - Emotestate'),
(36764,0,1,0,8,0,100,7,71281,0,0,0,80,3676400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Spellhit - Run Script'),
(36765,0,1,0,8,0,100,7,71281,0,0,0,80,3676400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Spellhit - Run Script'),
(36766,0,1,0,8,0,100,7,71281,0,0,0,80,3676400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Spellhit - Run Script'),
(36767,0,1,0,8,0,100,7,71281,0,0,0,80,3676400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - On Spellhit - Run Script'),
-- Script
(3676400,9,0,0,0,0,100,0,500,500,500,500,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Alliance Slave - Script - Turnto envoker'),
(3676400,9,1,0,0,0,100,0,500,500,500,500,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - say text'),
(3676400,9,2,0,0,0,100,0,100,100,100,100,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - set unitflag'),
(3676400,9,3,0,0,0,100,0,100,100,100,100,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - set faction'),
(3676400,9,4,0,0,0,100,0,100,100,100,100,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - set Emotestate'),
(3676400,9,5,0,0,0,100,0,100,100,100,100,33,36764,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Alliance Slave - Script - give quest credit'),
(3676400,9,6,0,0,0,100,0,100,100,100,100,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - set run on'),
(3676400,9,7,0,0,0,100,0,500,500,500,500,69,1,0,0,0,0,0,19,23837,70,0,0,0,0,0, 'Alliance Slave - Script - move to closest trigger'),
(3676400,9,8,0,0,0,100,0,8000,8000,8000,8000,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alliance Slave - Script - despawn');

-- Ball and chain SAI
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN (201969);
DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid` IN (201969);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(201969,1,0,0,64,0,100,6,0,0,0,0,85,71281,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Ball and chain - On Gossip Hello - Envoker cast on self');

-- Spell Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=71281;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,71281,0,31,3,36770,0,0,'','Spell 71281 targets entry 36770'),
(13,1,71281,1,31,3,36771,0,0,'','Spell 71281 targets entry 36771'),
(13,1,71281,2,31,3,36772,0,0,'','Spell 71281 targets entry 36772'),
(13,1,71281,3,31,3,36773,0,0,'','Spell 71281 targets entry 36773'),
(13,1,71281,4,31,3,36764,0,0,'','Spell 71281 targets entry 36764'),
(13,1,71281,5,31,3,36765,0,0,'','Spell 71281 targets entry 36765'),
(13,1,71281,6,31,3,36766,0,0,'','Spell 71281 targets entry 36766'),
(13,1,71281,7,31,3,36767,0,0,'','Spell 71281 targets entry 36767');

-- Creature text from sniff
DELETE FROM `creature_text` WHERE `entry` IN (36770,36771,36772,36773,36764,36765,36766,36767);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- Alliance Slaves
(36764,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Alliance Slave'),
(36764,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Alliance Slave'),
(36764,0,2, 'Have my babies.',12,0,100,0,0,0, 'Alliance Slave'),
(36764,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Alliance Slave'),
(36764,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Alliance Slave'),
(36765,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Alliance Slave'),
(36765,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Alliance Slave'),
(36765,0,2, 'Have my babies.',12,0,100,0,0,0, 'Alliance Slave'),
(36765,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Alliance Slave'),
(36765,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Alliance Slave'),
(36766,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Alliance Slave'),
(36766,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Alliance Slave'),
(36766,0,2, 'Have my babies.',12,0,100,0,0,0, 'Alliance Slave'),
(36766,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Alliance Slave'),
(36766,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Alliance Slave'),
(36767,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Alliance Slave'),
(36767,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Alliance Slave'),
(36767,0,2, 'Have my babies.',12,0,100,0,0,0, 'Alliance Slave'),
(36767,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Alliance Slave'),
(36767,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Alliance Slave'),
-- Horde Slaves
(36770,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Horde Slave'),
(36770,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Horde Slave'),
(36770,0,2, 'Have my babies.',12,0,100,0,0,0, 'Horde Slave'),
(36770,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Horde Slave'),
(36770,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Horde Slave'),
(36771,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Horde Slave'),
(36771,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Horde Slave'),
(36771,0,2, 'Have my babies.',12,0,100,0,0,0, 'Horde Slave'),
(36771,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Horde Slave'),
(36771,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Horde Slave'),
(36772,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Horde Slave'),
(36772,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Horde Slave'),
(36772,0,2, 'Have my babies.',12,0,100,0,0,0, 'Horde Slave'),
(36772,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Horde Slave'),
(36772,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Horde Slave'),
(36773,0,0, 'You''re a beautiful sight... you have no idea.',12,0,100,0,0,0, 'Horde Slave'),
(36773,0,1, '%s lets his mining pick drag on the ground as she approaches, clearly exhausted.',16,0,100,0,0,0, 'Horde Slave'),
(36773,0,2, 'Have my babies.',12,0,100,0,0,0, 'Horde Slave'),
(36773,0,3, 'If by life or death I can repay you, I will.',12,0,100,0,0,0, 'Horde Slave'),
(36773,0,4, 'I''m going to return to the front of the quarry. Kill a few extra for me.',12,0,100,0,0,0, 'Horde Slave');
-- Update Scourgelord Tyrannus "Make him fly"
UPDATE `creature_template_addon` SET `bytes1`=50331648 WHERE `entry`=36794;

-- Put Rimefang in the air and make him fly
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=36661;
UPDATE `creature_template_addon` SET `bytes1`=50331648 WHERE `entry`=36661;

-- Deathwhisper Necrolyte SAI
SET @ENTRY   := 36788; -- NPC entry
SET @SPELL1  := 69577; -- Shadow Bolt
SET @SPELL2  := 69578; -- Conversion Beam
SET @SPELL3  := 45104; -- Shadow Channelling
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,6,100,100,3000,3000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Deathwhisper Necrolyte - Combat - Cast Shadow Bolt'),
(@ENTRY,0,1,0,0,0,100,6,9000,9000,24000,24000,11,@SPELL2,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Deathwhisper Necrolyte - Combat - Cast Conversion Beam'),

-- Deathwhisper Necrolyte pathing
SET @NPC := 202231;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=592.975,`position_y`=176.104,`position_z`=508.746 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@NPC,@PATH,1);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,596.0208,175.5243,508.3654,0,0,0,100,0),
(@PATH,2,605.2656,157.7101,507.2126,0,0,0,100,0),
(@PATH,3,604.4063,146.283,507.3376,0,0,0,100,0),
(@PATH,4,592.2899,131.4271,507.8163,0,0,0,100,0),
(@PATH,5,577.4531,118.224,508.3163,0,0,0,100,0),
(@PATH,6,563.0695,103.7309,514.1504,0,0,0,100,0),
(@PATH,7,557.7743,89.41319,523.1727,0,0,0,100,0),
(@PATH,8,560.9583,77.65278,525.4227,0,0,0,100,0),
(@PATH,9,560.9583,77.65278,525.4227,0,0,0,100,0),
(@PATH,10,571.0139,69.43403,525.2753,0,0,0,100,0),
(@PATH,11,560.9583,77.65278,525.4227,0,0,0,100,0),
(@PATH,12,557.7743,89.41319,523.1727,0,0,0,100,0),
(@PATH,13,563.0695,103.7309,514.1504,0,0,0,100,0),
(@PATH,14,577.4531,118.224,508.3163,0,0,0,100,0),
(@PATH,15,592.2899,131.4271,507.8163,0,0,0,100,0),
(@PATH,16,604.4063,146.283,507.3376,0,0,0,100,0),
(@PATH,17,605.2656,157.7101,507.2126,0,0,0,100,0),
(@PATH,18,596.0208,175.5243,508.3654,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=202231;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES
(202231,202231,0,0,2),
(202231,202099,7,288,2),
(202231,202282,7,324,2),
(202231,202125,7,360,2),
(202231,202203,7,36,2),
(202231,201960,7,72,2);

-- Remove a dupe spawn
DELETE FROM `creature` WHERE `guid`=201998;
DELETE FROM `creature_addon` WHERE `guid`=201998;
