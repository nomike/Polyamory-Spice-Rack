floor_board_width = 60;
floor_board_height = 10;
side_wall_width = 10;

front_height = 80;
front_bar_width = 5;
front_bar_height = 5;

wall_mount_height = 50;
wall_mount_depth = 5;

wall_thickness = 4;

screw_hole_upper_diameter = 4;
screw_hole_lower_diameter = 6;
screw_hole_length = 7;


_base_height = floor_board_height + (wall_thickness * 2);
_screw_hole_height = _base_height + 35;


rotate([0, -90, 0]) union() {
    // Floor section
    translate([0, front_bar_height + (wall_thickness * 2), 0]) difference() {
        cube([side_wall_width, floor_board_width + (wall_thickness * 2), floor_board_height + (wall_thickness * 2)]);
        translate([0, wall_thickness, wall_thickness]) color("blue") cube([side_wall_width, floor_board_width, floor_board_height]);
    }

    // Front section
    difference(){
        color("red") cube([side_wall_width, front_bar_height + (wall_thickness * 2), front_height]);
        translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) color("blue") cube([side_wall_width, front_bar_height, front_bar_width]);

    }   

    // Wall mount section
    translate([0, front_bar_height + (wall_thickness * 2) + floor_board_width + (wall_thickness * 2), 0]) difference() {
        color("green") cube([side_wall_width, wall_mount_depth, floor_board_height + (wall_thickness * 2) + wall_mount_height]);
        translate([0, 0, _screw_hole_height]) union() {
            translate([side_wall_width / 2, wall_mount_depth, screw_hole_length]) rotate([90, 0, 0]) color("orange") cylinder(d=screw_hole_upper_diameter, h=wall_mount_depth);
            translate([(side_wall_width / 2) - (screw_hole_upper_diameter / 2), 0, 0]) cube([screw_hole_upper_diameter, wall_mount_depth, screw_hole_length]);
            translate([side_wall_width / 2, wall_mount_depth, 0]) rotate([90, 0, 0]) cylinder(d=screw_hole_lower_diameter, h=wall_mount_depth);
        }
    }
    
    translate([0, 47.5, 37]) {
        scale([1, 1.15, 1.15])
        rotate([90, 0, 90]) {
            union() {
                linear_extrude(height=side_wall_width) import("heart-icon.svg", center=true);
                translate([0, 0, side_wall_width / 3]) linear_extrude(height=side_wall_width / 3) import("infinity.svg", center=true);
            }
        }
    }
}
