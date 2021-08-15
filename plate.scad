// Parameters

// Number of rows

rows = 4; // [1 : 10]
columns = 4;
plate_thickness = 1.6;
oled = true; // true/false
oled_row = 1;
oled_column = 1;

bezel_width = 5.05;

quality = 50; // [1 : 100]

// Constants

cherry_size = 14;
cherry_pitch = 19.05;
$fn = quality / 100 * 360;

draw_parts();

module draw_parts() {
    plate();
}

module plate() {
    linear_extrude(plate_thickness)
        union() {
            // Draw OLED module if there is one
            if ( oled ) {
                translate([oled_column * cherry_pitch, -oled_row * cherry_pitch])
                    oled();
                }

            // Fill remaining grid with key switches
            for ( row = [1:1:rows] ) { 
                for ( column = [1:1:columns] ) {
                    translate([column * cherry_pitch, -row * cherry_pitch])
                        if ( !oled || (!((row == oled_row || row == oled_row + 1) && (column == oled_column || column == oled_column + 1))) ){
                            cherry_switch();
                        }
                }
            }
            // Add a bezel
            plate_bezel();
        }
}

module plate_bezel() {
    translate([cherry_pitch * (0.5 + (columns / 2)), -cherry_pitch/2])
        plate_bezel_section(columns);
    translate([cherry_pitch * (0.5 + (columns / 2)), -cherry_pitch * (0.5 + rows)])
        plate_bezel_section(columns);
    translate([cherry_pitch / 2, -cherry_pitch * (0.5 + (rows / 2))])
        rotate([0,0,90])
            plate_bezel_section(rows);
    translate([cherry_pitch * (0.5 + columns),  -cherry_pitch * (0.5 + (rows / 2))])
        rotate([0,0,90])
            plate_bezel_section(rows);
}

module plate_bezel_section( units = 1) {
    hull () {
        translate([cherry_pitch * units / 2, 0])
            circle(d = bezel_width);
        translate([-cherry_pitch * units / 2, 0])
            circle(d = bezel_width);
    }
}

module cherry_switch() {
    difference() {
        square([cherry_pitch + 0.01, cherry_pitch + 0.01], center = true);
        square([cherry_size, cherry_size], center = true);
    }
}

module oled() {
    translate([cherry_pitch/2, -cherry_pitch/2, 0])
        difference() {
            square([cherry_pitch*2 + 0.01, cherry_pitch*2 + 0.01], center = true);
            square([21.744, 10.864], center = true);
        }
}