#!/bin/bash

gcc64="x86_64-w64-mingw32-gcc"
gcc32="i686-w64-mingw32-gcc"

tmp_o_file="tmp.o"
rel_targ_path=../../@AresModAchillesExpansion
include_path="$PWD/include"

for src_file in $(find . -type f -name "*.c"); do
	if [[ "$src_file" != *"test"* ]]; then
		echo "Compiling $(basename $src_file) ..."
		# 64 bit
		dll_file=${src_file%??}_x64.dll
		$gcc64 -c -O3 $src_file -o $tmp_o_file -I "$include_path"
		$gcc64 -shared -O3 $tmp_o_file -o $dll_file
		mv $dll_file $rel_targ_path/.
		echo "Generated $(basename $dll_file)"
		# 32 bit
		dll_file=${src_file%??}.dll
		$gcc32 -c -O3 $src_file -o $tmp_o_file -I "$include_path"
		$gcc32 -shared -O3 $tmp_o_file -o $dll_file
		mv $dll_file $rel_targ_path/.
		echo "Generated $(basename $dll_file)"
	fi
done
rm $tmp_o_file