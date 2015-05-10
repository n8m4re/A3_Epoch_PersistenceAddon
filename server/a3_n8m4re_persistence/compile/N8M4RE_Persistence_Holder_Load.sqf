private ["_index","_key","_res","_arr","_hld","_car","_pos","_diag","_tbl"];
_diag = diag_tickTime;
_index = [format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"],(call EPOCH_fn_InstanceID)] call EPOCH_server_hiveGET;
if ((_index select 0) == 1 && typeName(_index select 1) == "ARRAY") then {
	for "_i" from 1 to ((_index select 1) select 0) do {
			_tbl = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS"];
			_key = format["%1:%2", call EPOCH_fn_InstanceID,_i];
			_res = [_tbl,_key] call EPOCH_server_hiveGET;  //EPOCH_server_hiveGETTTL _ttl = _res select 2;
			if ((_res select 0) == 1 && typeName(_res select 1) == "ARRAY") then {
				if !((_res select 1) isEqualTo []) then {
					_arr = _res select 1;
					_pos = _arr select 0;
					_car = _arr select 1;
					if ((_car isEqualTo [[],[[],[]],[[],[]],[[],[]]]) || (_pos isEqualTo [])) then {
						[_tbl,_key] call EPOCH_server_hiveDEL;
					} else {
						N8M4RE_PersistenceHolderIndex = N8M4RE_PersistenceHolderIndex + 1;
						_hld = createVehicle ["GroundWeaponHolder",_pos,[],0,"CAN_COLLIDE"];
						_hld setdir (random 360);
						_hld setVariable["BIS_enableRandomization",false];
						_hld setVariable["PERSIST_HOLDER_ID",N8M4RE_PersistenceHolderIndex,true];
						_hld setVariable["LAST_CHECK",1000000000000];
						if(surfaceIsWater _pos)then{
							_hld setposASL _pos;
						} else {
							_hld setposATL _pos;
						};
						[_hld,(_car select 0)] call N8M4RE_Persistence_AddWeaponCargo;	
						[_hld,(_car select 1)] call N8M4RE_Persistence_AddItemCargo;	
						[_hld,(_car select 2)] call N8M4RE_Persistence_AddMagazinesCargo;
						[_hld,(_car select 3)] call N8M4RE_Persistence_AddBackpackCargo;
						_hld enableSimulationGlobal true;
					};
				};
			};
	};
};
diag_log format["[N8M4RE PERSISTENCE]: HOLDER SPAWN TIME: %1",diag_tickTime-_diag];
diag_log format["[N8M4RE PERSISTENCE]: HOLDER SPAWNED: %1",N8M4RE_PersistenceHolderIndex];
true
