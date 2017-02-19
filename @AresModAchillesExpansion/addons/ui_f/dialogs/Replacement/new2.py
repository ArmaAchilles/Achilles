with open("RscDisplayAttributesModuleTree.hpp","r") as input_file:
	with open("out_RscDisplayAttributesModuleTree.hpp","w") as output_file:
		for line in input_file.readlines():
			index_x = line.find("x =")
			index_y = line.find("y =")
			index_w = line.find("w =")
			index_h = line.find("h =")
			if index_x is not -1:
				value = float(line.split()[2])
				value -= 53.5
				output_file.write("\t\t\tx = \"{} * (((safezoneW / safezoneH) min 1.2) / 40)\";\n".format(value))
			elif index_y is not -1:
				value = float(line.split()[2])
				value = 36.5 - value
				output_file.write("\t\t\ty = \"safezoneH - {} * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)\";\n".format(value))
			elif index_w is not -1:
				value = float(line.split()[2])
				output_file.write("\t\t\tw = \"{} * (((safezoneW / safezoneH) min 1.2) / 40)\";\n".format(value))
			elif index_h is not -1:
				value = float(line.split()[2])
				output_file.write("\t\t\th = \"{} * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)\";\n".format(value))
			else:
				output_file.write(line)
				