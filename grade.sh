CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
cp ../TestListExamples.java ./
if [[ -f ListExamples.java ]]
then
    echo 'file found'
else
    echo 'File not found'
    exit 1
fi

javac -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar *.java > error-output.txt

if [[ $? -eq 0 ]]
then
    echo 'files compile'
else
    echo 'there were compilation errors'
    exit 1
fi

java -cp .:../lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > testResults.txt

if [[ $? -eq 1 ]]
then
    echo 'No Errors found'
    grep "Tests Run: *" testResults.txt
else
    echo 'Errors found - redo'
fi

rm testResults.txt error-output.txt ListExamples.java

