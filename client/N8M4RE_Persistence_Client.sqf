player addEventHandler ["Put",{ 
	N8M4RE_PERSISTENCE_PUT =_this;
	publicVariableServer "N8M4RE_PERSISTENCE_PUT";
	//_this call N8M4RE_PersistenceCreate; 
}];

player addEventHandler ["Take",{ 
	N8M4RE_PERSISTENCE_TAKE = _this;
	publicVariableServer "N8M4RE_PERSISTENCE_TAKE";
	//_this call N8M4RE_PersistenceUpdate; 
}];