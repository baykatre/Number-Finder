# Functions for arithmetic operations, using bash.
# ---------------------------------------------------------------------------

#  ArithmeticOperations.sh
#  
#
#  Created by Anıl Öztürk on 15.05.2020.
#  

getOperand(){
    eval 'echo $arithmetic_operand'"$1"
    eval 'read -p "" operand'"$1"
    eval 'findDigitFromText "$operand'"$1"'"'
    eval 'val'"$1"'=$FINDED_NUMBER'
    eval 'calculateDigit $val'"$1"
    if [ $BASAMAK -gt 9 ]
    then
        echo $first_step_err_msg
        getOperand $1
    fi
}


operations(){
    let operation=$1
    getOperand 1
    getOperand 2
    if [ $operation -eq 1 ]
    then
        addition "$operand1" "$operand2"
    elif [ $operation -eq 2 ]
    then
        subtraction "$operand1" "$operand2"
    fi
}
addition(){
    (( RESULT = $val1 + $val2 ))
    resultText=$(calculateDigit $RESULT)
    echo $solve $val1 " + " $val2 " = " $RESULT "( " $resultText " )"
} 
subtraction(){
    (( RESULT = $val1 - $val2 ))
    resultText=$(calculateDigit $RESULT)
    echo $solve $val1 " - " $val2 " = " $RESULT "( " $resultText " )"
}

startOperations(){
    operations $1
}