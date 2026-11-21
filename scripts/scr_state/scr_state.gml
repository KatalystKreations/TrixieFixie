


/**
 * @param {any} _state State to check for.
 * @param {any} ... Other states to check for.
*/
function state_is(_state) {
	if variable_instance_exists(id, "state"){
	    for (var i = 0; i < argument_count; i++) {
	        if (state == argument[i]) {
	            return true;
	        }
	    }
	}
    return false;
}

/**
 * @param {any} _state State to change to.
*/
function state_to(_state) {
	if variable_instance_exists(id, "state"){
		state = _state
	}
}