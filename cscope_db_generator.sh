

PROJECT_DIR=$PWD
cd /

find $PROJECT_DIR  \
	-name "*.cpp" \
	-o -name "*.cxx" \
	-o -name "*.c" \
	-o -name "*.hpp" \
	-o -name "*.hxx" \
	-o -name "*.h" > $PROJECT_DIR/cscope.files

cd $PROJECT_DIR
cscope -b -q -k
