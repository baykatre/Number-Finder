
#  NumberFinder.sh
#  
#
#  Created by Anıl Öztürk on 9.05.2020.
#  


#!/bin/bash
. stack.sh
. TextToNumber.sh
. NumberToText.sh
. ArithmeticOperations.sh

setTurkish(){
  ATTACHS=("" "yuz" "bin" "milyon" "milyar" "trilyon")
  DECIMALS=("" "on" "yirmi" "otuz" "kirk" "elli" "altmis" "yetmis" "seksen" "doksan")
  NUMBERS=("" "bir" "iki" "uc" "dort" "bes" "alti" "yedi" "sekiz" "dokuz")
  ZERO="sıfır"
  first_step_text_1="1 - Sayı --> Yazı:"
  first_step_text_2="2 - Yazı --> Sayı:"
  first_step_text_3="3 - Yazı ile işlem:"
  first_step_err_msg="Hatalı giriş yaptınız!"
  arithmetic_msg_1="1 - Toplama:"
  arithmetic_msg_2="2 - Çıkarma:"
  arithmetic_operand1="Lütfen operand1 giriniz. (Max milyona kadar, milyon dahil)"
  arithmetic_operand2="Lütfen operand2 giriniz. (Max milyona kadar, milyon dahil)"
  from_number_to_text_text1="Lütfen yazıya çevirilecek sayıyı giriniz. (Max trilyona kadar, trilyon dahil)"
  from_text_to_number_text1="Lütfen sayıya çevirilecek yazı karşılığını giriniz. (Max trilyona kadar, trilyon dahil)"
  solve="Cevap: "
}
setEnglish(){
  ATTACHS=("" "hundred" "thousand" "million" "billion" "trillion")
  DECIMALS=("" "ten" "twenty" "thirty" "fourty" "fifty" "sixty" "seventy" "eigthy" "ninety")
  NUMBERS=("" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine")
  ZERO="zero"
  first_step_text_1="1 - Number --> Text:"
  first_step_text_2="2 - Text --> Number:"
  first_step_text_3="3 - Process with text:"
  first_step_err_msg="Please enter correct choise!"
  arithmetic_msg_1="1 - Addition:"
  arithmetic_msg_2="2 - Subtraction:"
  arithmetic_operand1="Please enter operand1. (Max to million, include million)"
  arithmetic_operand2="Please enter operand2. (Max to million, include million)"
  from_number_to_text_text1="Please a number for translate to text. (Max to trillion, include trillion)"
  from_text_to_number_text1="Please a text for translate to number. (Max to trillion, include trillion)"
  solve="Solve: "
}
# findFirstDigit(){
#       echo ${NUMBERS[$1]}
# }
THOUSANDFLAG=0
HUNDREDFLAG=0

fromNumberToText(){ # Sayıdan yazıya çevirilecek sayıyı alan ve ilgili fonksiyona gönderen yer.
  echo $from_number_to_text_text1
  read -p "" number
  echo -n $solve
  calculateDigit $number
  start
}
fromTextToNumber(){ # TODO: blabla
  echo $from_text_to_number_text1
  read -p "" number
  calculateDigitWithText "$number"
  start
}
arithmeticOptions(){
  echo $arithmetic_msg_1
  echo $arithmetic_msg_2
  read -n 1 process
  echo ""
  if [ $process -eq 1 ]
  then
    startOperations 1
  elif [ $process -eq 2 ]
  then
    startOperations 2
  else
    echo $first_step_err_msg
    start
  fi
}
first_step(){ # Yapılmak istenen işlemlerin seçildiği fonksiyon
  echo $first_step_text_1
  echo $first_step_text_2
  echo $first_step_text_3
  read -n 1 process
  echo ""
  if [ $process -eq 1 ]
  then
  fromNumberToText
  elif [ $process -eq 2 ]
  then
  fromTextToNumber
  elif [ $process -eq 3 ]
  then
  arithmeticOptions
  else
    echo $first_step_err_msg
    start
  fi
}

start(){ # Dil seçiminin yapıldığı başlangıç fonksiyonu
  echo
  echo
  echo "Lütfen dili seçiniz / Please select language"
  echo "1 - Türkçe"
  echo "2 - English"
  echo "Çıkış için 9'a basınız! / Please enter 9 for exit!"
  read -n 1 language
  echo ""
  if [ $language -eq 1 ]
  then
    setTurkish
    first_step
  elif [ $language -eq 2 ]
  then
    setEnglish
    first_step
  elif [ $language -eq 9 ]
  then
    exit 1
  else
    echo "Hatalı giriş yaptınız, lütfen tekrar deneyiniz! / Your input is incorrect, please try again!"
    start
  fi
}

start  # Programın Başlangıç Noktası


