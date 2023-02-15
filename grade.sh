CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then 
    echo 'success'
else    
    echo 'file does not exist'
    exit
fi

cd ..


cp student-submission/ListExamples.java .

set +e

javac -cp $CPATH *.java

if [[ -f TestListExamples.class ]] && [[ -f ListExamples.class ]]
then
    echo 'success 2'
else
    echo 'did not compile both TestListExamples and ListExamples properly'
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

less output.txt


