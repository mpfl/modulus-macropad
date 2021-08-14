rows = 4;
columns = 4;
thickness = 1.5;
oled_row = 1;
oled_column = 1;

cherry_size = 14;
cherry_pitch = 19.05;



for ( row = [1:1:rows] ) { 
    for ( column = [1:1:columns] ) {
        if ( row != oled_row && column != oled_column)
        translate([column * cherry_pitch, -row * cherry_pitch, 0])
            cherry_switch();
    }
}


module cherry_switch() {
    difference() {
        cube([cherry_pitch, cherry_pitch, thickness], center = true);
        cube([cherry_size, cherry_size, thickness*2], center = true);
    }
}

module oled() {
    difference() {
        cube([cherry_pitch*2, cherry_pitch*2, thickness], center = true);
        cube([cherry_size*2, cherry_size*2, thickness*2], center = true);
    }
}