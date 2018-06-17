# -------------------------------------------
# Examples of useful shell command lines
# -------------------------------------------

# FIND
# -------------------------------------------
# find entries
find -type f -regex ".*\.\(hpp\|sqf\)" -exec grep -i "category =" {} \;
# find and replace entries
find -type f -regex ".*\.\(hpp\|sqf\)" -exec sed -i 's/[Cc]ategory = \"Spawn\"/Category = \"Achilles_fac_Spawn\"/g' {} \;
