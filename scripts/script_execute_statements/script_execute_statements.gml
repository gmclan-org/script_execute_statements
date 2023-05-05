
	
	/// @desc Executes whole script resource, including global scope code (same as on GameStart)
	/// @param {Asset.GMScript, Function} scr
	function script_execute_statements(scr) {
		if (ds_map_exists(global.__script_resource_list, scr)) {
			script_execute(global.__script_resource_list[? scr]);
		} else {
			throw "script resourse " + string(scr) + " not exists";
		}
	}
	
	/// @param {Function, String} scr
	function script_get_functions(scr) {
		if (is_numeric(scr)) {
			// xfeather disable once GM1041
			scr = script_get_name(scr);
		}
		
		return global.__script_function_list[? scr] ?? [];
	}
	
	
	
	/// prepare data on game start
	/// we're checking for existence in case of calling this script again :)
	if (!variable_global_exists("__script_resource_list")) {
		global.__script_resource_list = ds_map_create();
		global.__script_function_list = ds_map_create();
		__script_execute_pure_setup();
	}

	/// @desc prepares list of "scripts" (not functions), and list of functions inside scripts
	function __script_execute_pure_setup() {
		var _s = 100000;
		var _script_name = undefined;
		var _function_name = undefined;
		
		while script_exists(_s) {
			// feather disable once GM1041
			var _gml_name = string(method(self, _s));			
			if (string_pos("function gml_", _gml_name) < 1) {
				// doesn't start with gml_ so it's script, not function
				_script_name = string_replace(_gml_name, "function ", "");
				global.__script_resource_list[? asset_get_index(_script_name) ] = _s;
				global.__script_function_list[? _script_name ] = [];
			} else {
				// it's a function
				_function_name = string_replace(_gml_name, "function gml_Script_", "");
				array_push(global.__script_function_list[? _script_name], _function_name);
			}
			_s++;
		}
	}