#!/bin/bash

hexCodesEncode=(0 1 2 3 4 5 6 7 8 9 A B C D E F)
hexCodesDecode=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)

echo "zamiana systemu hex-bin"
echo -n "podaj system ('1' - binary; '2' - hexadecimal): "
read sys


if test $sys == 1 2>/dev/null; then
  echo -n "podaj liczbe binarna: "
  read number

  dec=0

  for ((i=${#number}-1;i>=0;i--)); do 

    bit=${number:i:1}

    if test $bit == 1; then 
      pow=$((${#number}-i-1))
      dec=$((dec+(2**$pow)))
    fi

  done

  until test $dec == 0; do 
    x=$((dec/16))
    out=${hexCodesEncode[$((dec-x*16))]}$out
    dec=$x
  done

  echo "liczba $number w systemie hexadecimalnym wynosi $out"

elif test $sys == 2; then 
  echo -n "podaj liczbe hexadecimalna: "
  read number

  dec=0

  for ((i=${#number}-1;i>=0;i--)); do 

    bit=${number:i:1}

    pow=$((${#number}-i-1))

    if test $bit -le 9 2>/dev/null || test $bit -ge 0 2>/dev/null; then
      vbit=$((bit*(16**$pow)))
    else
      case $bit in
        A) vbit=10;;
        B) vbit=11;;
        C) vbit=12;;
        D) vbit=13;;
        E) vbit=14;;
        F) vbit=15;;
        *) vbit=0;;
      esac 
      vbit=$((vbit*(16**$pow)))
    fi
    dec=$((dec+vbit))

  done
  
  out=""
  until test $dec == 0; do 
   x=$((dec/2))
   out=$((dec-x*2))$out
   dec=$x
  done
  echo "liczba $number w systemie binarnym wynosi $out"
fi 
