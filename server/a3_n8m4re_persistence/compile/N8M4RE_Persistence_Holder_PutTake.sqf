private ["_ply","_plyVar","_con","_movItem","_conPos","_conCargo","_conEveryCargo","_conId","_store"];
if(N8M4RE_PersistenceHolderIndex >= N8M4RE_PersistenceHolderLimit)exitWith{true};
_ply = _this select 0;
_plyVar = _ply getVariable "PERSIST_HOLDER_PLY";	
_con = _this select 1;
_movItem = _this select 2;
_conPos = getPosATL _con;
_conId = _con getVariable "PERSIST_HOLDER_ID";	
_expire = N8M4RE_PersistenceHolderExpires;

//hint format["%1 - find=%2",(typeOf _con),(str(_con) find "dummyweapon.p3d")];
if ( ((typeOf _con) == "GroundWeaponHolder")) then {
			
		if ( isNil "_conId" ) then {
			N8M4RE_PersistenceHolderIndex = N8M4RE_PersistenceHolderIndex + 1;	
			_con setVariable["PERSIST_HOLDER_ID",N8M4RE_PersistenceHolderIndex,true];
		} else { 
			N8M4RE_PersistenceHolderIndex = _conId; 
		};			
		
		_tbl = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS"];
		_key = format["%1:%2",(call EPOCH_fn_InstanceID),N8M4RE_PersistenceHolderIndex];
		
		_conCargo = _con call N8M4RE_Persistence_GetCargo;
		_conEveryCargo = _con call N8M4RE_Persistence_GetEveryContainerCargo;
		_conEveryCargo = [];
		//diag_log format["%1",_conCargo]; 
			
		if ( _conCargo isEqualTo [[],[[],[]],[[],[]],[[],[]]] ) then {
			[_tbl,_key] call EPOCH_server_hiveDEL;
			N8M4RE_PersistenceHolderIndex = N8M4RE_PersistenceHolderIndex - 1;
			_con setVariable ["LAST_CHECK",nil];
			_ply setVariable ["PERSIST_HOLDER_PLY",nil];
			deleteVehicle _con;
		} else {
			_con setVariable ["LAST_CHECK",1000000000000];
			_store = [_conPos,_conCargo,_conEveryCargo];
			// hint format["%1",_conEveryCargo];	
			
			[_tbl,_key,_expire,_store] call EPOCH_server_hiveSETEX;
			_ply setVariable ["PERSIST_HOLDER_PLY",[N8M4RE_PersistenceHolderIndex,_con,_key]];
		};
		
		_tbl = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"];
		_key = format["%1",(call EPOCH_fn_InstanceID)];
		[_tbl,_key,[N8M4RE_PersistenceHolderIndex]] call EPOCH_server_hiveSET;	
			
} else {
		
		if !(isNil "_plyVar") then {
			if ( (_plyVar select 0) == (_plyVar select 1) getVariable "PERSIST_HOLDER_ID" ) then {
				_conCargo = (_plyVar select 1) call N8M4RE_Persistence_GetCargo;
				_conEveryCargo = (_plyVar select 1) call N8M4RE_Persistence_GetEveryContainerCargo;
				_conEveryCargo = [];
				_conPos = getPosATL( _plyVar select 1);
				_store = [_conPos,_conCargo,_conEveryCargo];
				[_tbl,(_plyVar select 2),_expire,_store] call EPOCH_server_hiveSETEX;
			};
		};
};
true
