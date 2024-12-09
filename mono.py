# SUBDIVISION = 16 #th notes

#notes should be in this format: (length)(modifier)(name)
import math

def main():
	print("start\n")
	files = ["keys.txt",] # music file names
	dict = {}
	print("processing\n")
	for file in files:
		dict[file.split(".")[0]] = read(file)
	for key in dict:
		writeFile(key, dict[key][0], dict[key][1])

	print("done\n")

def read(name):
	list = []
	notes = []
	with open(name, 'r') as file:
		for line in file:
			line = line.strip().split()
			if line[0] == "//":
				continue
			elif line[0] == "!":
				notes = line[1:]
				continue
			print(f"about to process ({line})")
			for str in line:
				list += process(str)
			assert len(list) % 16 == 0, f"TIME ERROR: length is({len(list)})"
	return [notes, list]

def process(str):
	assert len(str) >= 2, f"ERROR: asked to process ({str})"
	durNote = length(str[0]) - 1
	durRest = 1
	if str[1] == '.':
		str = str[2:]
		durRest = durNote
		durNote = 1
	elif str[1] == '/':
		str = str[2:]
		durRest = 0
		durNote += 1
	else:
		str = str[1:]

	print(f"adding: ({str})")

	return (([str] * durNote) + (["r"] * durRest))

# returns note length based on code
def length(num):
	lengths = {
		"1": 16,
		"2": 8,
		"3": 6, #dotted quarter
		"4": 4,
		"7": 3,
		"8": 2,
		"6": 1
	}
	out = lengths.get(num)
	assert out is not None, f"asked for length of ({num}) note"
	return out

def writeFile(name, notes, music):
	wordSize = math.ceil(math.log2(len(notes)))
	addrWidth = math.ceil(math.log2(len(music)))
	legend = "-- Notes: "
	dict = {value: format(index, 'b').zfill(wordSize) for index, value in enumerate(notes)}
	for key in dict:
		legend += key + "- " + dict[key] + ", "

	strTop = '''-- Template for generating a ROM module from a text file

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ''' + name + ''' is
    generic(
        ADDR_WIDTH : natural := ''' + str(addrWidth) + ''';
        WORD_SIZE : natural := ''' + str(wordSize) + ''' 
    );
    port(
        clk : in std_logic;
        addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        data : out std_logic_vector(WORD_SIZE - 1 downto 0)
    );
end ''' + name + ''';
''' + legend[:len(legend) - 2] +'''
architecture synth of ''' + name + ''' is
begin
    process (clk) begin
        if rising_edge(clk) then
            case addr is
'''
	bulk = []
	for i in range(len(music)):
		elem = "                when " + str(addrWidth) + "b\"" + format(i, 'b') + "\" => data <= \"" + dict[music[i]]
		elem += "\";\n\n"
		bulk.extend(elem)

	strEnd = '''                when others => data <= (others => '0');
            end case;
        end if;
    end process;
end;
'''
	outFile = open(name + ".vhd", 'w')
	print("output\n")
	outFile.write(strTop)
	for line in bulk:
		outFile.write(line)

	outFile.write(strEnd)
	outFile.close()

if __name__ == "__main__":
	main()			
