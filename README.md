# Julia-Simple-GUI

Simple GUI in julia.

More information about each function can be found in the code as commented part.

## Demo
* Addition and subtraction
* 
<img src= /gifs/zadatak1.gif width="500" height="250" />

* Function that finds
  * sum of all elements of the forwarded matrix
  * sum of elements by rows, columns and diagonals
  
<img src= /gifs/zadatak2.gif width="500" height="250" />

* Function that accepts string that represents function and then draws graph

<img src= /gifs/zad3.gif width="650" height="250" />

## Installation
For all functions:  
  ➔ sudo apt install libcanberra-gtk-module libcanberra-gtk3-module  
  ➔ using Gtk  
  ➔ using PyCall (because of function string to matrix, needed numpy)
  
    To install numpy:  
    ➔ sudo apt get install numpy  
    ➔ sudo apt install python3-numpy  
    ➔ sudo apt install python3-pip  
    ➔ pip3 install numpy  
    ➔ pip3 install -upgrade numpy  
    ➔ np = pyimport(“numpy”)  
  
For drawing functions in last GUI:  
➔ using Pkg  
➔ Pkg.add(“GR”)  
➔ using GR  
➔ using Plots  
