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
  echo -e "\n${lightPurpleColour}[*]${endColour}${whiteColour} Dinero actual: ${endColour}${greenColour}$totalMoney${endColour} "
  echo -en "${lightPurpleColour}[*]${endColour}${whiteColour} Cuanto dinero quieres apostar? -> ${endColour}" && read initial_bet
  echo -en "${lightPurpleColour}[*]${endColour}${whiteColour} A que deseas apostar contininuamente ?${endColour}${blueColour} (${endColour}${lightYellowColour}Par${blueColour}/${endColour}${lightYellowColour}Impar${endColour}${blueColour})${endColour} -> " && read even_odd
 
  back_initial_bet=$initial_bet
  play_counter=0
  jugadas_malas=""
  max_money=0
  maxm_play=0

  tput civis
  while true; do
    randomNumber="$(($RANDOM % 37))"
    money=$(($totalMoney - $initial_bet))
    if [ ! "$totalMoney" -le 0 ] && [ "$initial_bet" -le "$totalMoney" ]; then
#     echo -e "\n${yellowColour}=> ${endColour}${whiteColour}Haz apostado${endColour}${blueColour} $initial_bet\$${endColour}${whiteColour} y tienes${endColour}${greenColour} $money\$${endColour}"
#     echo -e "${yellowColour}=> ${endColour}${whiteColour}Numero${endColour}${blueColour} $randomNumber${endColour}${whiteColour} en jugada${endColour}${purpleColour} $even_odd${endColour}"
      if [ "$even_odd" == "par" ]; then
        if [ "$(($randomNumber % 2))" -eq 0 ]; then
          if [ "$randomNumber" -eq 0 ]; then
#           echo -e "\n${redColour}[!]${endColour}${redColour} Ha salido 0 Perdemos!${endColour}"
            totalMoney=$(($totalMoney - $initial_bet))
            initial_bet=$(($initial_bet * 2))
            jugadas_malas+="$randomNumber "
#           echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
          else
#           echo -e "\n${greenColour}[!] Jugada Par Ganamos!${endColour}"
            initial_bet=$back_initial_bet 
            reward=$(($initial_bet * 2))
            totalMoney=$(($totalMoney + $reward))
            jugadas_malas=""
            if [ "$totalMoney" -gt "$max_money" ]; then
              max_money=$totalMoney  
              maxm_play=$play_counter
            fi          
#            echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
          fi
        else
#         echo -e "\n${redColour}[!]${endColour}${redColour} Jugada Impar Perdemos!${endColour}"
          totalMoney=$(($totalMoney - $initial_bet))
          initial_bet=$(($initial_bet * 2))
          jugadas_malas+="$randomNumber "
#         echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
        fi
      elif [ "$even_odd" == "impar" ]; then
         if [ "$(($randomNumber % 2))" -eq 0 ]; then
          if [ "$randomNumber" -eq 0 ]; then
#           echo -e "\n${redColour}[!]${endColour}${redColour} Ha salido 0 Perdemos!${endColour}"
            totalMoney=$(($totalMoney - $initial_bet))
            initial_bet=$(($initial_bet * 2))
            jugadas_malas+="$randomNumber "
#           echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
          else
#           echo -e "\n${greenColour}[!] Jugada Par Ganamos!${endColour}"
#           echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
            totalMoney=$(($totalMoney - $initial_bet))
            initial_bet=$(($initial_bet * 2))
            jugadas_malas+="$randomNumber "
           fi
         else
#         echo -e "\n${redColour}[!]${endColour}${redColour} Jugada Impar Perdemos!${endColour}"
#         echo -e "\n${lightBlueColour}[!]${endColour}${whiteColour} Tienes ${endColour}${greenColour}$totalMoney${endColour}"
          initial_bet=$back_initial_bet 
          reward=$(($initial_bet * 2))
          totalMoney=$(($totalMoney + $reward))
          jugadas_malas=""
          if [ "$totalMoney" -gt "$max_money" ]; then
                max_money=$totalMoney
                maxm_play=$play_counter
          fi
         fi
      else
        echo -e "\n${redColour}[!]${endColour}${redColour} No existe la jugada ($even_odd)${endColour}"
        tput cnorm;exit 0
      fi
    elif [ "$initial_bet" -gt "$totalMoney" ]; then
      echo -e "\n${redColour}[!]${endColour}${redColour} Te has quedado sin dinero suficiente!${endColour}${whiteColour} No puedes apostar ${endColour}${greenColour}$initial_bet\$${endColour}${whiteColour} teniendo ${endColour}${greenColour}$totalMoney\$${endColour}"
      echo -e "\n${yellowColour}=> ${endColour}${whiteColour}Han habido un total de ${endColour}${yellowColour}$play_counter${endColour}${whiteColour} Jugadas${endColour}"
      echo -e "\n${yellowColour}=> ${endColour}${whiteColour}Dinero maximo alcanzado ${endColour}${yellowColour}$max_money${endColour}${whiteColour} en la jugada ${endColour}${lightYellowColour}$maxm_play${endColour}"
      echo -e "\n${yellowColour}=> ${endColour}${whiteColour}Ultimas jugadas malas consecutivas:${endColour}"
      echo -e "${blueColour}$jugadas_malas${endColour}"
      tput cnorm;exit 0
    else
      echo -e "\n${redColour}[!]${endColour}${redColour} Te has quedado sin dinero!${endColour}"
      tput cnorm;exit 0
    fi
  let play_counter+=1
  done
  tput cnorm
}

inverselabrouchele (){
  echo -e "\n${lightPurpleColour}[*]${endColour}${whiteColour} Dinero actual: ${endColour}${greenColour}$totalMoney${endColour} "
  echo -en "${lightPurpleColour}[*]${endColour}${whiteColour} A que deseas apostar contininuamente ?${endColour}${blueColour} (${endColour}${lightYellowColour}Par${blueColour}/${endColour}${lightYellowColour}Impar${endColour}${blueColour})${endColour} -> " && read even_odd
  declare -a my_sequence=(1 2 3 4)
  echo -e "\n${lightPurpleColour}[*]${endColour}${whiteColour} Secuencia actual: ${endColour}${blueColour}[${my_sequence[@]}]${endColour} "
  bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
  unset my_sequence[0]
  unset my_sequence[-1]
  #my_sequence=${my_sequence[@]}
  echo -e "\n${lightPurpleColour}[*]${endColour}${whiteColour} Apostamos ${endColour}${greenColour}$bet\$${endColour} Nueva secuencia${blueColour}[${my_sequence[@]}]${endColour} "


  while  true ; do
    randomNumber="$(($RANDOM % 37))"
    money=$(($totalMoney - $bet))
    echo -e "\n${lightPurpleColour}[*]${endColour}${whiteColour} Numero actual: ${endColour}${greenColour}$randomNumber${endColour} "
  done
  

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
  elif [[ "$technique" == "inverselabrouchele" ]]; then
    inverselabrouchele
  else
    echo -e "\t${lightPurpleColour}[!]${endColour}${redColour} No existe esa Tecnica${endColour}"
    helpPanel
  fi
else
  helpPanel
fi
