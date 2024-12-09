def main():
	bulk = []
	for i in range(1,18):
		elem = "                when 4b\"" + format(i, 'b') + "\" => data <= \"" + format(round(25175000/(2*262*(2**(i/12)))), 'b').zfill(16)
		elem += "\";\n\n"
		bulk.extend(elem)
	outFile = open("freqs.txt", 'w')
	print("output\n")
	for line in bulk:
		outFile.write(line)
	outFile.close()

if __name__ == "__main__":
	main()	