if !( isServer || isDedicated ) then {

	player addEventHandler ["Put",{ 
		N8M4RE_PERSISTENCE_PUT =_this;
		publicVariableServer "N8M4RE_PERSISTENCE_PUT";
	}];

	player addEventHandler ["Take",{ 
		N8M4RE_PERSISTENCE_TAKE = _this;
		publicVariableServer "N8M4RE_PERSISTENCE_TAKE";
	}];
};
