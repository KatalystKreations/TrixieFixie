
/**
 * Opens or closes the save INI file.
 *
 * This function is used to control when the INI file is open for writing.
 * Passing true opens "save.ini", and passing false closes it.
 *
 * Use this to batch multiple save operations efficiently:
 *   save_open(true);
 *   save_section(...);
 *   save_section(...);
 *   save_open(false);
 *
 * @param {bool} _bool  Whether to open (true) or close (false) the INI file.
 */
function save_open(_bool=true) {
    if (_bool)
        ini_open("save.ini");
    else
        ini_close();
}

/**
 * Saves a value to a specific section and key in the INI file.
 *
 * Automatically detects the value type:
 * - numeric values are written using ini_write_real()
 * - boolean values are written using ini_write_real()
 * - all other values are written using ini_write_string()
 *
 * This function does not open or close the INI file on its own,
 * allowing you to batch multiple writes between save_open(true/false).
 *
 * @param {string} _section  The INI section to write to (e.g., "player", "settings").
 * @param {string} _key      The key inside the section to write. (e.g  "x", "volume")
 * @param {any}    _val      The value to save (number or string).
 */
function save_section(_section, _key, _val) {
    if (is_bool(_val))
        ini_write_real(_section, _key, _val);
    else if (is_numeric(_val))
        ini_write_real(_section, _key, _val);
    else
        ini_write_string(_section, _key, _val);
}

/**
 * Saves a value into the "progress" section of the INI file.
 *
 * This is a shorthand for save_section(), used for storing
 * gameplay progress such as level, coins, XP, checkpoints, or any other
 * numeric or string value related to player advancement.
 *
 * The value type is automatically detected by save_section():
 * - numeric values are written as real numbers
 * - boolean values are written as real numbers
 * - all other values are written as strings
 *
 * @param {string} _key   The key inside the "progress" section to write.
 * @param {any}    _val   The value to save (number or string).
 */
function save_progress(_key, _val) {
    save_section("progress", _key, _val);
}


/**
 *  This a shorthand for save_section(). Specifically for saving the section, ' player[ i ] ' values.
 * @param {any} _player_num The player number. (e.g  1)
 * @param {string} _key The File. (e.g  "x")
 * @param {any} _val The Value. (e.g  128)
 */
function save_player(_player_num, _key, _val) {
    var section = "player" + string(_player_num);
    save_section(section, _key, _val);
}



/**
 * Loads a value from an INI file and automatically converts its type.
 *
 * This function reads a key from a given INI section and returns:
 * - the default value if the key does not exist
 * - a real number if the stored value is numeric
 * - a string otherwise
 *
 * @param {string} _section  The INI section to read from (e.g., "player", "progress").
 * @param {string} _key      The key inside the section to load.
 * @param {any}    _default  The value to return if the key does not exist.
 *
 * @returns {real|string}    The loaded value, converted to the correct type.
 */
function load_section(_section, _key, _default) {
    var val = ini_read_string(_section, _key, "__NULL__");
	val = string_trim(val);
	
    // Key doesn't exist → return default
    if (val == "__NULL__") return _default;
	
	// Boolean detection
    if (val == "true") return true;
    if (val == "false") return false;
	
    // If numeric → convert to real
    if (is_numeric(val)) return real(val);

    // Otherwise → return as string
    return val;
}

/**
 * Loads a value from the "progress" section of the INI file.
 *
 * This is a shorthand for load_section(), used for reading
 * gameplay progress such as level, coins, XP, checkpoints, etc.
 *
 * Automatically returns:
 * - the default value if the key does not exist
 * - a real number if the stored value is numeric
 * - a string otherwise
 *
 * @param {string} _key      The key inside the "progress" section to load.
 * @param {any}    _default  The value to return if the key does not exist.
 *
 * @returns {real|string}    The loaded value, converted to the correct type.
 */
function load_progress(_key, _default) {
    return load_section("progress", _key, _default);
}


