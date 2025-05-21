#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
blackColour="\e[0;30m\033[1m"
whiteColour="\e[1;37m\033[1m"
lightRedColour="\e[1;31m\033[1m"
lightGreenColour="\e[1;32m\033[1m"
lightYellowColour="\e[1;33m\033[1m"
lightBlueColour="\e[1;34m\033[1m"
lightPurpleColour="\e[1;35m\033[1m"
lightTurquoiseColour="\e[1;36m\033[1m"
lightGrayColour="\e[0;37m\033[1m"
darkGrayColour="\e[1;30m\033[1m"


function ctrl_c(){
	echo -e "\n\n${redColour}[*]${endColour}${whiteColour} Saliendo...${endColour}"; sleep 1
	tput cnorm ;exit 1
}

trap ctrl_c INT

helpPanel (){
  echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Uso:${endColour}"
  echo -e "\t${lightPurpleColour}-h)${endColour}${whiteColour} Menu de inicio${endColour}"
  echo -e "\t${lightPurpleColour}-m)${endColour}${whiteColour} Dinero con el que se quiere jugar${endColour}"
  echo -e "\t${lightPurpleColour}-t)${endColour}${whiteColour} Tecnica a utilizar${endColour}${blueColour} (${endColour}${lightYellowColour}martingala${endColour}${blueColour}/${endColour}${lightYellowColour}inverselabrouchele${endColour}${blueColour})${endColour}\n"
  
}


martingala (){
  echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Dinero Actual: ${endColour}${greenColour}$totalMoney${endColour} "
  echo -en "${lightPurpleColour}[*]${endColour}${whiteColour} Cuanto dinero quieres apostar? -> ${endColour}" && read initial_bet
  echo -en "${lightPurpleColour}[*]${endColour}${whiteColour} A que deseas apostar contininuamente ?${endColour}${blueColour} (${endColour}${lightYellowColour}Par${blueColour}/${endColour}${lightYellowColour}Impar${endColour}${blueColour})${endColour} -> " && read even_odd
 
  tput civis
  while true; do
    randomNumber="$(($RANDOM % 37))"
    money=$(($totalMoney - $initial_bet))
    echo -e "\n${yellowColour}=> ${endColour}${whiteColour}Haz apostado${endColour}${blueColour} $initial_bet\$${endColour}${whiteColour} y tienes${endColour}${greenColour} $money\$${endColour}"
    echo -e "${yellowColour}=> ${endColour}${whiteColour}Numero${endColour}${blueColour} $randomNumber${endColour}${whiteColour} en jugada${endColour}${purpleColour} $even_odd${endColour}"
    if [ "$even_odd" == "par" ]; then
      if [ "$(($randomNumber % 2))" -eq 0 ]; then
        if [ "$randomNumber" -eq 0 ]; then
          echo -e "\n${redColour}[!]${endColour}${whiteColour} Ha salido ${redColour}0${endColour} ${whiteColour}Perdemos!${endColour}"
        else
          echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Jugada ${endColour}${greenColour}Par${endColour}${whiteColour} Ganamos!${endColour}"
        fi
      else
        echo -e "\n${redColour}[!]${endColour}${whiteColour} Jugada ${endColour}${redColour}Impar${endColour}${whiteColour} Perdemos!${endColour}"
      fi
      sleep 0.4

    fi
  done
  tput cnorm
}

while getopts "m:t:h" arg; do
  case $arg in 
    m) totalMoney=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
  esac
done

if [ $totalMoney ] && [ $technique ]; then
  if [ "$technique"  == "martingala" ]; then
    martingala
  else
    echo -e "\t${lightPurpleColour}[!]${endColour}${redColour} No existe esa Tecnica${endColour}"
    helpPanel
  fi
else
  helpPanel
fi
