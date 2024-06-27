name = "AI-Swarm"
uid = "a13ac591-b2d9-4d94-0286-3d4b3cce6b97"
version = 286
copyright = "2021 Azraeel"
description = "Welcome to Swarm. What is Swarm? Swarm is a AI Improvement Mod, Swarm wants to make the AI; Smart and Tough to be beat with the goal of reaching a level of truly Competitive AI. That Can Teach New Players and Help Everyone Get Better. REQUIRES AI-Uveso for Map Marker Generator!!!! 219 Version - 2021 Rainbow Cup III Tournment Special Update!"
author = "Azraeel"
url = ""
icon = "/mods/AI-Swarm/icon.jpg"
selectable = true
enabled = true
exclusive = false
ui_only = false
requires = { }
requiresNames = { }
conflicts = { }
before = { }
after = { }
--[[Modifications made to swarm v285:
SHA 990907081d49466e0d0e13136240e5465405bc88 - by Relent0r, June 11, 2023 - changes to fix Swarm to take account of FAF's changes in aibrain logic
SHA 6fdbdffced66007b9406afd3b6102ea1f4a039b2 - By Azraeel, June 11, 2023 - Merge of pull request #50 - changes to fix Swarm to take account of FAF's changes in aibrain logic
SHA 320602eafa628d9d4995ffc232096d64eaa99a70 - by Relent0r, June 24, 2023 - ...warm to work properly, add fallback upgradeid check since the UpgradesTo property will return an empty string instead of nil which will caused t3 structures that cant upgrade to run the upgrade thread. Add support factory check for upgrade thread so that support factories will not try and upgrade when no HQ is available. Fix a couple of global vars that should be local (there are MANY more that have this problem across the AI which will cause strange behaviors in team games with multiple swarm ai).
SHA c88b664d7658a4027725f4678e24c3614cfd5a93 - by Relent0r, June 24, 2023 - …nd to use swarm engineer movement.

Details of the precise changes from each of these SHAs can be viewed on github
The code for version 286 is based on this pull request by Relent0r: https://github.com/Azraeel/AI-Swarm/pull/51
The license applying to swarm also applies to these changes