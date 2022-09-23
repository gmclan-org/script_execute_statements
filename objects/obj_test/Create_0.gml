

	show_debug_message("-- Results of normal script_execute()");
	
	script_execute(script_test);
	script_execute(script_test_legacy);
	
	show_debug_message("-- Results of normal script_execute_function_only()");
	
	script_execute_statements(script_execute_statements);
	script_execute_statements(script_test);
	script_execute_statements(script_test_legacy);