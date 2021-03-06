#!/bin/sh

MAJOR_HOME="../.."

echo "complile the mml"
$MAJOR_HOME/bin/mmlc $MAJOR_HOME/mml/small.mml


echo
echo "Compiling and mutating project"
echo "(ant -Dmutation=\"=\$MAJOR_HOME/mml/small.mml.bin\" clean compile)"
echo
$MAJOR_HOME/bin/ant -Dmutation="=$MAJOR_HOME/mml/small.mml.bin" clean compile

echo
echo "Compiling tests"
echo "(ant compile-tests)"
echo
$MAJOR_HOME/bin/ant compile-tests

#echo
#echo "Run tests without mutation analysis"
#echo "(ant test)"
#$MAJOR_HOME/bin/ant test

echo
echo "Run tests with mutation analysis"
echo "(ant mutation.test)"
$MAJOR_HOME/bin/ant mutation-test
