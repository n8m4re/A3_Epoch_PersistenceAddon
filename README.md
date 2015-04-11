# Install Server

ADD  "a3_n8m4re_persistence.bpo"  TO  "@epochhive/addons"


# Install Client Mission

ADD  "N8M4RE_Persistence_Client.sqf"  TO  "mpmissions/epoch.mapname", 
if you have there a *.pbo instead of a folder, please google for "how to extract .pbo", pbo is an archive like "zip" you need a tool for that.

open the "init.sqf" inside of the "mpmissions/epoch.mapname" folder, if not exist then create an new file with an     editor like "notepad++" and name it to "init.sqf"

example for the "init.sqf"
```
// stop server loading the client script
// tutorial: http://killzonekid.com/arma-scripting-tutorials-basic-multiplayer-coding-summary/  
if (isDedicated) exitWith {}; 

// compile the script on mission load
// https://community.bistudio.com/wiki/compileFinal
sdropClient=compileFinal preprocessFileLineNumbers "N8M4RE_Persistence_Client.sqf";

// wait client is ready 
// https://community.bistudio.com/wiki/waitUntil
// https://community.bistudio.com/wiki/isPlayer
// https://community.bistudio.com/wiki/alive
waitUntil{(isPlayer player) && (alive player) && !isNil "EPOCH_loadingScreenDone"};

// Starts running the script
// https://community.bistudio.com/wiki/spawn
[] spawn N8M4RE_Persistence_Client;
```


# Battleye

ADD TO "publicvariable.txt"

```
!="N8M4RE_(PERSISTENCE_PUT|PERSISTENCE_TAKE)"
```

# Epoch Server Config

ADD TO "@epochhive/epochconfig.hpp"

```
PersistenceTablePrefix = "PERSIST"; // change will create a new table in db ( prefix_mapname )
PersistenceExpires = 1500; // 3600 expiration date in seconds 1day=86400, 2days=172800, 4days=345600, 8days=691200
PersistenceLimit = 5000; // max limit to store
```


# Author
Nightmare - http://n8m4re.de


# License
All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

http://creativecommons.org/licenses/by-nc-sa/4.0/
