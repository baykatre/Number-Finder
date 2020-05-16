# Number to text functions, using bash.
# ---------------------------------------------------------------------------

#  NumberToText.sh
#  
#
#  Created by Anıl Öztürk on 12.05.2020.
#  

findSecondDigit(){
  echo ${DECIMALS[(($1/10))]} ${NUMBERS[(($1%10))]}
}

findThirdDigit(){
      ((DIVIDED_NUMBER = $1/100))
      ((REDUCED_NUMBER = $1-$DIVIDED_NUMBER*100))
      if [ $DIVIDED_NUMBER -eq 0 ]
      then
        retval="$(findSecondDigit $REDUCED_NUMBER)"
        echo $retval
      elif [ $DIVIDED_NUMBER -eq 1 ]
      then
        retval=$(findSecondDigit $REDUCED_NUMBER)
        echo ${ATTACHS[1]} $retval
      elif [ $DIVIDED_NUMBER -gt 1 ]
      then
        retval=$(findSecondDigit $REDUCED_NUMBER)
        echo ${NUMBERS[$DIVIDED_NUMBER]} ${ATTACHS[1]} $retval
      fi
}

findTripleGroup() {
  findThirdDigit $1
}

findDigit(){
  BASAMAK=1
  NUMBER_IN=$1
  NUMBER=$NUMBER_IN
  while [ $NUMBER -gt 9 ]
  do
    ((NUMBER = $NUMBER / 10))
    ((BASAMAK= $BASAMAK + 1))
  done
}
parseFirstThreeDigit() {
      ((WEIGHT=$1))
      ((FIRST_DIVIDED_NUMBER = $2/(10**($WEIGHT-1))))
      ((REDUCED_NUMBER = $2-$FIRST_DIVIDED_NUMBER*(10**($WEIGHT-1))))
      ((SECOND_DIVIDED_NUMBER = $REDUCED_NUMBER/(10**($WEIGHT-2))))
      ((REDUCED_NUMBER = $REDUCED_NUMBER-$SECOND_DIVIDED_NUMBER*(10**($WEIGHT-2))))
      ((THIRD_DIVIDED_NUMBER = $REDUCED_NUMBER/(10**($WEIGHT-3))))
      ((REDUCED_NUMBER = $REDUCED_NUMBER-$THIRD_DIVIDED_NUMBER*(10**($WEIGHT-3))))
      ((FINAL_DIVIDED_NUMBER = $FIRST_DIVIDED_NUMBER*100 + $SECOND_DIVIDED_NUMBER*10 + $THIRD_DIVIDED_NUMBER))
      echo $FINAL_DIVIDED_NUMBER
}

calculateDigit(){
  findDigit $1
  if [ $BASAMAK -eq 1 ] || [ $BASAMAK -eq 2 ] || [ $BASAMAK -eq 3 ]
  then
    if [ $1 -eq 0 ]
    then
      echo $ZERO
    else
      retval=$(findThirdDigit $NUMBER_IN)
      echo "$retval"
    fi
  elif [ $BASAMAK -eq 4 ] || [ $BASAMAK -eq 5 ] || [ $BASAMAK -eq 6 ]
  then
    firstThirdDigits=$(parseFirstThreeDigit 6 $NUMBER_IN)
    ((lastThirdDigits = $NUMBER_IN - $firstThirdDigits*(10**3)))
    if [ $language -eq 1 ] && [ $firstThirdDigits -eq 1 ]
    then
      firstThirdDigits=0
      THOUSANDFLAG=1
    fi
    echo "$(findThirdDigit $firstThirdDigits)" $([[ $firstThirdDigits -gt 0 || $THOUSANDFLAG -eq 1 ]] && echo ${ATTACHS[2]} ) "$(findThirdDigit $lastThirdDigits)"
  elif [ $BASAMAK -eq 7 ] || [ $BASAMAK -eq 8 ] || [ $BASAMAK -eq 9 ]
  then
    firstThirdDigits=$(parseFirstThreeDigit 9 $NUMBER_IN)
    ((middleNumber = $NUMBER_IN - $firstThirdDigits*(10**6)))
    middleThirdDigits=$(parseFirstThreeDigit 6 $middleNumber)
    ((lastThirdDigits = $middleNumber - $middleThirdDigits*(10**3)))
    if [ $language -eq 1 ] && [ $middleThirdDigits -eq 1 ]
    then
      middleThirdDigits=0
      THOUSANDFLAG=1
    fi
    echo "$(findThirdDigit $firstThirdDigits)" ${ATTACHS[3]} "$(findThirdDigit $middleThirdDigits)" $([[ $middleThirdDigits -gt 0 || $THOUSANDFLAG -eq 1 ]] && echo ${ATTACHS[2]} ) "$(findThirdDigit $lastThirdDigits)"
  elif [ $BASAMAK -eq 10 ] || [ $BASAMAK -eq 11 ] || [ $BASAMAK -eq 12 ]
  then
    firstThirdDigits=$(parseFirstThreeDigit 12 $NUMBER_IN)
    ((secondNumber = $NUMBER_IN - $firstThirdDigits*(10**9)))
    secondThirdDigits=$(parseFirstThreeDigit 9 $secondNumber)
    ((thirdNumber = $secondNumber - $secondThirdDigits*(10**6)))
    thirdThirdDigits=$(parseFirstThreeDigit 6 $thirdNumber)
    ((lastThirdDigits = $thirdNumber - $thirdThirdDigits*(10**3)))
    if [ $language -eq 1 ] && [ $thirdThirdDigits -eq 1 ]
    then
      thirdThirdDigits=0
      THOUSANDFLAG=1
    fi
    echo "$(findThirdDigit $firstThirdDigits)" ${ATTACHS[4]} "$(findThirdDigit $secondThirdDigits)" $([[ $secondThirdDigits -gt 0 ]] && echo ${ATTACHS[3]} ) "$(findThirdDigit $thirdThirdDigits)" $([[ $thirdThirdDigits -gt 0 || $THOUSANDFLAG -eq 1 ]] && echo ${ATTACHS[2]} ) "$(findThirdDigit $lastThirdDigits)"
  elif [ $BASAMAK -eq 13 ] || [ $BASAMAK -eq 14 ] || [ $BASAMAK -eq 15 ]
  then
    firstThirdDigits=$(parseFirstThreeDigit 15 $NUMBER_IN)
    ((secondNumber = $NUMBER_IN - $firstThirdDigits*(10**12)))
    secondThirdDigits=$(parseFirstThreeDigit 12 $secondNumber)
    ((thirdNumber = $secondNumber - $secondThirdDigits*(10**9)))
    thirdThirdDigits=$(parseFirstThreeDigit 9 $thirdNumber)
    ((fourthNumber = $thirdNumber - $thirdThirdDigits*(10**6)))
    fourthThirdDigits=$(parseFirstThreeDigit 6 $fourthNumber)
    ((lastThirdDigits = $fourthNumber - $fourthThirdDigits*(10**3)))
    if [ $language -eq 1 ] && [ $fourthThirdDigits -eq 1 ]
    then
      fourthThirdDigits=0
      THOUSANDFLAG=1
    fi
      echo "$(findThirdDigit $firstThirdDigits)" ${ATTACHS[5]} "$(findThirdDigit $secondThirdDigits)" $([[ $secondThirdDigits -gt 0 ]] && echo ${ATTACHS[4]} ) "$(findThirdDigit $thirdThirdDigits)" $([[ $thirdThirdDigits -gt 0 ]] && echo ${ATTACHS[3]} ) "$(findThirdDigit $fourthThirdDigits)" $([[ $fourthThirdDigits -gt 0 || $THOUSANDFLAG -eq 1 ]] && echo ${ATTACHS[2]} ) "$(findThirdDigit $lastThirdDigits)"
  else
      echo "Çabuk burayı terket!"
  fi
}