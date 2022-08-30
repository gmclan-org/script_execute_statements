
	

	/// @param {Asset.GMScript} scr
	function script_execute_pure(scr) {
		if (ds_map_exists(global.__sc_pure_list, scr)) {
			script_execute(global.__sc_pure_list[? scr]);
		} else {
			throw "script " + string(scr) + " not exists";
		}
	}
	
	/// prepare data
	global.__sc_pure_list = ds_map_create();
	__script_execute_pure_setup();

	function __script_execute_pure_setup() {
		var _s = 100000;
		while script_exists(_s) {
			var _gml_name = string(method(self, _s));			
			if (string_pos("function gml_", _gml_name) < 1) {
				global.__sc_pure_list[? asset_get_index(string_replace(_gml_name, "function ", "")) ] = _s;
			}
			_s++;
		}
	}