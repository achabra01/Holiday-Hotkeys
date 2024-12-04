# this program takes a png image and generates the VHDL code to store that
# image in ROM

# takes the image and opens it, making sure it is RGB
from PIL import Image
im = Image.open('Homescreen.png', 'r')
im = im.convert("RGB")
width, height = im.size
pixel_values = list(im.getdata()) # gets all the RGB values for each pixel

# rounds the RGB values from 8-bit values to 2-bit values
rounded_values = []
for r, g, b in pixel_values:
    # Scale 8-bit (0-255) to 2-bit (0-3)
    r_6bit = round(r / 255 * 3)
    g_6bit = round(g / 255 * 3)
    b_6bit = round(b / 255 * 3)
    rounded_values.append((r_6bit, g_6bit, b_6bit))

# this holds all the VHDL that comes before the case statements
first_lines = ["library IEEE;\n",
"use IEEE.std_logic_1164.all;\n",
"use IEEE.numeric_std.all;\n\n",


"entity my_rom is\n",
"  port(\n",
"    clk : in std_logic;\n",
"    addr : in std_logic_vector(15 downto 0); -- 16 words total\n",
"    data : out std_logic_vector(5 downto 0) -- 6-bit words, RRGGBB\n",
"  );\n",
"end;\n\n",

"architecture sim of my_rom is\n",
"begin\n",
"  process(clk) begin\n",
"    if rising_edge(clk) then\n",
"      case addr is\n"]

# this holds all the VHDL that comes after the case statements
last_lines = ["      end case;\n",
"    end if;\n",
"  end process;\n",
"end;\n"]

# opens a .vhd file and writes the image as a VHDL ROM in the file
with open("my_rom.vhd", 'w') as file:
    file.writelines(first_lines)

    # this for loop prints out all the case statements which hold the color of
    # each pixel
    for i in range(len(rounded_values)):
        x = i % width  # Calculate the x-coordinate
        y = i // width  # Calculate the y-coordinate
        pixel = rounded_values[i]  # Get the pixel value (R, G, B)

        # holds 6 bits - 2 bits for each RGB value
        binary_string = ''.join(format(component, '02b') for component in pixel)

        # checks if a pixel is black and doesn't write a case statement for it
        # to save memory because black is the most common color in the image
        if (binary_string == "000000"):
            continue

        # writes the case statement for a given pixel
        file.write("        when " + "\"" + format(y, '08b'))
        file.write(format(x, '08b') + "\" => data <= ")
        file.write("\"" + binary_string + "\"" + ";\n")
    
    # writes the last lines to the .vhd file
    file.write("        when others => data <= \"000000\";\n")
    file.writelines(last_lines)
