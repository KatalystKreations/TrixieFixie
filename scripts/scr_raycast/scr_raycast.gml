function scr_raycast(x1, y1, x2, y2, obj, prec, notme)
/// @desc Casts a ray from (x1,y1) to (x2,y2).
/// @param {real} x1      Start x
/// @param {real} y1      Start y
/// @param {real} x2      End x
/// @param {real} y2      End y
/// @param {object} obj   Object to collide with (or all, or noone)
/// @param {boolean} prec Precise collision (true/false)
/// @param {instance} notme Instance to ignore (usually self)
///
/// @returns {struct|undefined}
///          { hit: bool,
///            x: real, y: real,
///            inst: instance,
///            dist: real,
///            nx: real, ny: real }  // normal approx
{
    //var x1    = argument0;
    //var y1    = argument1;
    //var x2    = argument2;
    //var y2    = argument3;
    //var obj   = argument4;
    //var prec  = argument5;
    //var notme = argument6;

    // First hit along the line
    var hit_inst = collision_line(x1, y1, x2, y2, obj, prec, true);

    if (hit_inst == noone || hit_inst == notme) {
        return undefined;
    }

    // Get exact contact point by binary search along the line
    var lx1 = x1;
    var ly1 = y1;
    var lx2 = x2;
    var ly2 = y2;

    repeat (10) {
        var mx = (lx1 + lx2) * 0.5;
        var my = (ly1 + ly2) * 0.5;

        if (collision_line(lx1, ly1, mx, my, obj, prec, false) == hit_inst) {
            lx2 = mx;
            ly2 = my;
        } else {
            lx1 = mx;
            ly1 = my;
        }
    }

    var hit_x = lx2;
    var hit_y = ly2;

    var dx = x2 - x1;
    var dy = y2 - y1;
    var dist = point_distance(x1, y1, hit_x, hit_y);

    // Approximate surface normal via local sampling
    var eps = 1;
    var sx1 = hit_x + dy;   // perpendicular vector (dy, -dx) or (-dy, dx)
    var sy1 = hit_y - dx;
    var sx2 = hit_x - dy;
    var sy2 = hit_y + dx;

    var c1 = collision_point(sx1, sy1, obj, prec, true);
    var c2 = collision_point(sx2, sy2, obj, prec, true);

    var nx = 0;
    var ny = 0;

    if (c1 != noone || c2 != noone) {
        // Normal points from inside to outside-ish
        if (c1 != noone && c2 == noone) {
            nx = sx2 - hit_x;
            ny = sy2 - hit_y;
        } else if (c2 != noone && c1 == noone) {
            nx = sx1 - hit_x;
            ny = sy1 - hit_y;
        }
        var len = point_distance(0, 0, nx, ny);
        if (len != 0) {
            nx /= len;
            ny /= len;
        }
    }

    return {
        hit  : true,
        x    : hit_x,
        y    : hit_y,
        inst : hit_inst,
        dist : dist,
        nx   : nx,
        ny   : ny
    };
}