#!/bin/bash


MENUBOX=${MENUBOX=dialog}


funcDisplayDialogMenu(){
  $MENUBOX --title "[ MAIN MENU ]" --menu "Use UP/Down Arrows to Move and Select or the Number of Your Choice and Enter" 15 45 4 1 "Display Hello World" 2 "Display Goodbye World" 3 "Display Nothing" X "Exit" 2>choce.txt
}


funcDisplayDialogMenu

case "`cat choice.txt`" in 
  1) echo "Hello World";;
  2) echo "Goodbye World";;
  3) echo "Nothing";;
  X) echo "Exit";;
esac

