VERSION=7.3.0
GCC=gcc-$VERSION
GCC_AR=$GCC.tar.xz
DIR=/tmp
PREFIX=$HOME/.local
NB_CPU=`cat /proc/cpuinfo | grep processor | wc -l`

cd $DIR
wget http://fr.mirror.babylon.network/gcc/releases/$GCC/$GCC_AR

tar xvf $GCC_AR

cd $DIR/$GCC
./contrib/download_prerequisites
cd $DIR

mkdir $DIR/objdir && cd $DIR/objdir
$DIR/$GCC/configure --prefix=$PREFIX --enable-languages=c,c++,fortran,go --disable-multilib --program-suffix=$VERSION
make -j$NB_CPU && make install
