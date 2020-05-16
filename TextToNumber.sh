# Text to number functions, using bash.
# ---------------------------------------------------------------------------

#  TextToNumber.sh
#  
#
#  Created by Anıl Öztürk on 13.05.2020.
#  


findNumbersForText(){
  local number
  for i in ${!NUMBERS[@]}
  do
    if [[ "$1" == "${NUMBERS[$i]}" ]]
    then
      ((number = $i))
    fi
  done
  echo $number
}
findDecimalsForText(){
  local number
  for i in ${!DECIMALS[@]}
  do
    if [[ "$1" == "${DECIMALS[$i]}" ]]
    then
      ((number += $i*10))
  fi
  done
  echo $number
}
findHundredForText(){
  local number
  if [[ "$1" == "${ATTACHS[1]}" ]]
    then
      ((number += 10**2))
      top=""
      stack_pop words top
      if [ "$top" != "" ]
      then
        number=$(findNumbersForText $top)
        ((number = (number) * 10**2))
      fi
      ((wordsSize -= 1))
      HUNDREDFLAG=$number
  fi
}
findTripleLabelForText(){
  ((WEIGHT=$1))

  top=""
  stack_pop words top
  if [ "$top" != "" ]
  then
    if [ "$top" == "${ATTACHS[1]}" ]
    then
      findHundredForText $top
      local number=$HUNDREDFLAG
      ((number = (number) * 10**$WEIGHT))
      ((FINDED_NUMBER+=$number))
      HUNDREDFLAG=0
      ((wordsSize -= 1))
    else
        local number=$(findNumbersForText $top)
        if [ "$number" ]
        then
          ((number = (number) * 10**$WEIGHT))
          ((FINDED_NUMBER+=$number))
          ((wordsSize -= 1))
          findTripleLabelForText $WEIGHT
        else
          local number=$(findDecimalsForText $top)
          if [ "$number" ]
          then
            ((number = (number) * 10**$WEIGHT))
            ((FINDED_NUMBER+=$number))
            ((wordsSize -= 1))
            findTripleLabelForText $WEIGHT
          else
            stack_push words $top
          fi
        fi
    fi
  fi
}
detectAttachs(){
  if [[ "$1" == "${ATTACHS[2]}" ]]
  then
    if [ $language -eq 1 ]
    then
      local topOld=$top
      top=""
      stack_pop words top
      if [ "$top" == "" ] || [ "$top" == "${ATTACHS[3]}" ] || [ "$top" == "${ATTACHS[4]}" ] || [ "$top" == "${ATTACHS[5]}" ]
      then
        (( FINDED_NUMBER += 10**3 ))
        if [ "$top" ]
        then
          stack_push words $top
        fi
      else 
        stack_push words $top
      fi
    fi
    findTripleLabelForText 3
  fi
  if [[ "$1" == "${ATTACHS[3]}" ]]
  then
    findTripleLabelForText 6
  fi
  if [[ "$1" == "${ATTACHS[4]}" ]]
  then
    findTripleLabelForText 9
  fi
  if [[ "$1" == "${ATTACHS[5]}" ]]
  then
    findTripleLabelForText 12
  fi
  findDecimals $1
}
findDecimals(){
  number1="$(findNumbersForText $1)"
  if [ $number1 ]
  then
    ((FINDED_NUMBER = $FINDED_NUMBER+$number1))
  fi

  number2="$(findDecimalsForText $1)"
  if [ $number2 ]
  then
    ((FINDED_NUMBER = $FINDED_NUMBER+$number2))
  fi
  findHundredForText $1
  number3=$HUNDREDFLAG
  if [ $number3 ]
  then
    ((FINDED_NUMBER = $FINDED_NUMBER+$number3))
    HUNDREDFLAG=0
  fi

}
findTripleGroupFromText(){
  stack_size words wordsSize
  while (( $wordsSize > 0 ))
  do
    top=""
    stack_pop words top
    detectAttachs $top
    ((wordsSize -= 1))
  done
}
findDigitFromText(){
  stack_destroy words
  stack_new words
  FINDED_NUMBER=0
  for word in $1
  do
    stack_push words $word
  done
  findTripleGroupFromText
}
calculateDigitWithText(){
  findDigitFromText "$1"
  echo "$solve $FINDED_NUMBER"
}

  # echo -n "Başlangıç Flag $WEIGHT: "
  # eval 'echo $'"flag_${WEIGHT}"
  # eval "let flag=flag_${WEIGHT}"
  # if [ $flag -eq 0 ] && [ 0 ]
  # then
  #   if [ $WEIGHT -eq 3 ] && [ 0 ]
  #   then
  #     (( FINDED_NUMBER += 10**$WEIGHT ))
  #   else
  #     (( FINDED_NUMBER += 10**($WEIGHT) ))
  #   fi
  # fi
  # SEQUENCE=0
  # ((SEQUENCE=$WEIGHT-2))
  # if [ "$top" == "${ATTACHS[$SEQUENCE]}" ]
  # then
  # echo "girdimmmm"
  #   (( FINDED_NUMBER += 10**$WEIGHT ))
  # fi
  # eval "let flag_${WEIGHT}=1"
  # echo -n "Bitiş Flag $WEIGHT: "
  # eval 'echo $'"flag_${WEIGHT}"