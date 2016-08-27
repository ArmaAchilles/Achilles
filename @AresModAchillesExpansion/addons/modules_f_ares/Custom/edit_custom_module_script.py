# replace fnc by Thomas Watnedal (http://stackoverflow.com/questions/39086/search-and-replace-a-line-in-a-file-in-python)
# Modified for intended purpose by Kex

from tempfile import mkstemp
from shutil import move
from os import remove, close

fnc_replace(file_path, pattern, subst)::
	#Create temp file
	fh, abs_path = mkstemp()
	with open(abs_path,'w') as new_file:
		with open(file_path) as old_file:
			for line in old_file:
				new_file.write(line.replace(pattern, subst))
	close(fh)
	#Remove original file
	remove(file_path)
	#Move new file
	move(abs_path, file_path)

for i in xrange(100):
	file_path = "functions\\fn_UserDefinedModule{}.sqf".format(i)
	print "edit ", file_path
	to_find = 'ares_zeusExtensions\\Ares'
	substitute = 'achilles\modules_f_ares'
	fnc_replace(file_path,to_find,substitute)
raw_input ('Done')