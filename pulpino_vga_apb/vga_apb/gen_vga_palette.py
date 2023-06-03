# Generate palette for VGA APB module

# Set VGA output color depth
color_depth = 4

# Set out filename
filename = "vga_palette.mem"


def color2rgb(color):
    r = (color >> 4) & 0x3
    g = (color >> 2) & 0x3
    b = (color >> 0) & 0x3

    scale_coeff = (2**color_depth - 1) / 3
    r = int(round( r * scale_coeff ))
    g = int(round( g * scale_coeff ))
    b = int(round( b * scale_coeff ))

    rgb = (r << 2*color_depth) | (g << 1*color_depth) | (b << 0*color_depth)
    return f'{rgb:0{color_depth*3}b}'


with open(filename, "w") as fout:
    for color in range(256):
        fout.write(color2rgb(color))
        fout.write('\n')
