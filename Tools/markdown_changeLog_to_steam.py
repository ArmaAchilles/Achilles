#!/usr/bin/env python3

from __future__ import print_function
from sys import argv, exit
from os.path import basename
from time import sleep

def get_and_check_file(extension):
	'''
	function get and check file
	
	This function reads the passed file and checkes if it is valid or not
	
	input: extension (str)	the valid file extension
	output: file_path and file_name (str) if valid
	'''
	extension_length = len(extension)
	try:
		# get arguments
		file, file_path = argv
		if file_path[1] == "'":
			file_path = file_path[1:-1]
	except ValueError:
		print('\nMissing a valid file as argument! Drag and drop a *.{} file on {}! \n\n'.format(extension,basename(__file__)))
		input('Close program with ENTER...')
		exit()
	file_name = basename(file_path)
	if file_name[-extension_length:] != extension:
		print('\nFile must be of type *.{}!\n\n'.format(extension))
		input('Close program with ENTER...')
		exit()
	return (file_path,file_name)
	
if __name__ == "__main__":
	file_path, file_name = get_and_check_file("txt")
	print("\nConverting {}...".format(file_name))
	with open(file_path,"r") as old_file:
		with open(file_path[:-4] + "_steam.txt","w") as new_file:
			for line in old_file.readlines():
				#handle issue id's
				start_index = line.find("see #") + 5
				if start_index > 4:
					end_index = line.find(")",start_index)
					issue_id = line[start_index:end_index]
					line = line[:(start_index-1)] + "[url=https://github.com/oOKexOo/AresModAchillesExpansion/issues/{0}]#{0}[/url]".format(issue_id) + line [end_index:]
				else:
					#handle normal links
					start_index = line.find("see [") + 5
					if start_index > 4:
						end_index = line.find("]",start_index)
						link_text = line[start_index:end_index]
						new_line = line[:(start_index-1)] + "[url="
						start_index = end_index + 2
						end_index = line.find(")",start_index)
						link = line[start_index:end_index]
						new_line += link + "]" + link_text + "[/url]" + line[(end_index+1):]
						line = new_line
				new_file.write(line)
	print("\nConversion completed!")