CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

git clone $1 student-submission
echo 'Finished cloning'

## Recieve the files
submission="student-submission"

if ! [[ -e $submission ]]
then
    echo "Error, nothing found"
    exit
elif  ! [[ -f $submission/ListExamples.java ]]
then 
    echo "Error, no file found"
    exit
else
    echo "Valid file found"
fi

cp -r $submission/* grading-area
cp -r *.java grading-area
cp -r lib grading-area
cd grading-area

# Then, add here code to compile and run, and do any post-processing of the
# tests

javac -cp $CPATH *.java


testCode=$?

if [[ $testCode -ne 0 ]]
then 
    echo $testCode " could not compile"
    exit
fi 

java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples > output.txt

failureString=`grep "FAILURES!!!" output.txt`

if [[ $failureString == "" ]]
then
    echo "Passed 100% Yay!"
else
    echo "There is a test that has failed :("
fi






