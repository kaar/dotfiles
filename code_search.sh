# grep $1 $(find $2 -iname "*cs")
grep $1 $(find ${2:-src/} -iname "*.cs")