

/// @desc Initializes animcurve playback variables.
function curve_create()
{
    curve_active   = false;
    curve_timer    = 0;
    curve_duration = 0;
    curve_curve    = -1;   // animcurve asset
    curve_value    = 0;    // output value
    curve_magnitude = 1;   // multiplier
	channel_Idx 	= 0;
	reset_val 		= true
}


/// @desc Updates curve playback and calculates curve_value.
function curve_step()
{
    if (!curve_active) {
		if (reset_val)
        curve_value = 0;
        return;
    }

    // Normalized time 0 → 1
    var t = 1 - (curve_timer / curve_duration);

    // Evaluate curve
	var chan = animcurve_get_channel(curve_curve, channel_Idx)
    var v = animcurve_channel_evaluate(chan, t);
    // Apply magnitude
    curve_value = v * curve_magnitude;

    // Countdown
    curve_timer--;

    // End curve
    if (curve_timer <= 0) {
        curve_active = false;
		if (reset_val)
        curve_value = 0;
    }
}


/// @desc Starts animcurve playback.
/// * After starting, must use curve_value on desired values
/// @param curve     Animcurve asset
/// @param duration  Frames to play
/// @param magnitude Multiplier for output
/// @param {real|string} _chan_Idx The channel index or name of a given curve asset.
/// @param {bool} _reset_val Reset the value at the end of the curve time.
function curve_start(curve, duration = 30, magnitude = 1, _chan_Idx = 0, _reset_val = true)
{
    curve_active    = true;
    curve_curve     = curve;
    curve_duration  = duration;
    curve_timer     = duration;
    curve_magnitude = magnitude;
	channel_Idx 	= _chan_Idx;
	reset_val		= _reset_val;
}

function curve_new()
{
    return {
        curve_active     : false,
        curve_timer      : 0,
        curve_duration   : 0,
        curve_curve      : -1,
        curve_value      : 0,
        curve_magnitude  : 1,
        channel_Idx      : 0,
        reset_val        : true,

        create : function() {
            curve_active     = false;
            curve_timer      = 0;
            curve_duration   = 0;
            curve_curve      = -1;
            curve_value      = 0;
            curve_magnitude  = 1;
            channel_Idx      = 0;
            reset_val        = true;
        },

        step : function() {
            if (!curve_active) {
                if (reset_val)
                    curve_value = 0;
                return;
            }

            var t = 1 - (curve_timer / curve_duration);

            var chan = animcurve_get_channel(curve_curve, channel_Idx);
            var v    = animcurve_channel_evaluate(chan, t);

            curve_value = v * curve_magnitude;

            curve_timer--;

            if (curve_timer <= 0) {
                curve_active = false;
                if (reset_val)
                    curve_value = 0;
            }
        },

        start : function(curve, duration = 30, magnitude = 1, _chan_Idx = 0, _reset_val = true) {
            curve_active     = true;
            curve_curve      = curve;
            curve_duration   = duration;
            curve_timer      = duration;
            curve_magnitude  = magnitude;
            channel_Idx      = _chan_Idx;
            reset_val        = _reset_val;
        }
    };
}
