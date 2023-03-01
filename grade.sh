CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm ListExamples.class
rm TestListExamples.class
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then 
    echo 'FILE: EXISTS'
else    
    echo 'Are you sure you passed in the right file?'
    exit
fi

cd ..


cp student-submission/ListExamples.java ./

set +e

javac -cp $CPATH *.java

if [[ -f TestListExamples.class ]] && [[ -f ListExamples.class ]] && [[ $(wc -l < grep_results.txt) -eq 0 ]]
then
    echo 'COMPILE: SUCCESS'
else
    echo 'You have a compile error. Check through your code again to see if there is a syntax error.'
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

grep -h 'FAILURES!!!' output.txt > grep_results.txt


if [[ $(wc -l <grep_results.txt) -ge 1 ]]
then
    echo 'You have test failures. Fix them.'
else
    echo 'You passed all of your tests!'
fi
