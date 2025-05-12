include <../OpenSCAD_Lib/MakeInclude.scad>

// $fa=0.2;

bladeX = 100;
bladeY = 0.35*25.4 + 0.3;
bladeZ = 0.02 * 25.4 + 0.3;

bladeAngle = 70;

module itemModule()
{
	difference()
	{
		cylinder(d=30, h=40);

		bladeXform() tcu([-10,0,0], [bladeX, bladeY, bladeZ]);

		translate([0,0,16]) rotate([0,-bladeAngle,0]) 
		{
			tcy([0, bladeY/2, 8], d=3, h=100);
		}
	}
}

module bladeXform()
{
    translate([-30/2-0,0,0]) rotate([0,-bladeAngle,0]) translate([0, 0, -bladeZ]) children();
}

module clip(d=0)
{
	// tc([-200, -400-d+nothing, -10], 400);
    tc([-200, -400-d+bladeY/2, -10], 400);
	// rotate([0,90-50,0]) tcu([-200, -200, 30], 400);
}

if(developmentRender)
{
	display() itemModule();
    displayGhost() bladeXform() translate([-0.7,0,0]) bladeGhost();
}
else
{
	itemModule();
}

module bladeGhost()
{
    z = 0.02 * 25.4;

    x0 = 0.905*25.4;
    y0 = 0.35 * 25.4;
    hull()
    {
        cylinder(d=nothing, h=z);

        tcu([x0,0,0], [nothing, y0, z]);
        
        // tcu([1.57*25.4,0,0], [nothing, 0.25*25.4, bladeZ])
    }
    x1 = 1.57*25.4-15;
    y1 = 0.25*25.4;
    dy = (y0-y1)/2 - 0.1;
    hull()
    {
        tcu([x0,0,0], [nothing, y0, z]);
        
        tcu([x0+4.7, dy, 0], [nothing, y1, z]);
    }
    tcu([-20+1.57*25.4, dy, 0], [20, y1, z]);
}
