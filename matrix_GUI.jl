#Napisati funkciju koja vrši sabiranje svih elemenata proslijedene ma-
#trice, sabiranje elemenata po redovima, kolonama i dijagonalama, te
#vraća odgovarajuće sume. Zadatak uradite bez korištenja predefinisa-
#nih funkcija. Potrebno je provjeriti rad funkcije.
# using Gtk
# using PyCall
win = GtkWindow("Not Wolfram Alpha")

g = GtkGrid()
num1 = GtkEntry()  # a widget for entering text
set_gtk_property!(num1, :text, "")
set_gtk_property!(num1, :margin_top, 15)
set_gtk_property!(num1, :margin_right, 10)

button = GtkButton("Submit")
set_gtk_property!(button, :margin_right, 10)

label = GtkLabel("Enter matrix: ")
set_gtk_property!(label, :margin_top, 20)
set_gtk_property!(label, :margin_left, 10)

suma_matrice = GtkLabel("")
suma_redova = GtkLabel("")
suma_kolona = GtkLabel("")
suma_diagonale = GtkLabel("")
suma_sporedne = GtkLabel("")

g1 = GtkGrid()
g1[1,1] = GtkLabel("Suma matrice: ")
g1[1,2] = suma_matrice
set_gtk_property!(g1, :margin_left, 10)
set_gtk_property!(g1, :row_spacing, 10)  # introduce a 15-pixel gap between columns

g2 = GtkGrid()
g2[1,1] = GtkLabel("Suma redova: ")
g2[1,2] = suma_redova
set_gtk_property!(g2, :margin_left, 10)
set_gtk_property!(g2, :row_spacing, 10)  # introduce a 15-pixel gap between columns

g3 = GtkGrid()
g3[1,1] = GtkLabel("Suma kolona: ")
g3[1,2] = suma_kolona
set_gtk_property!(g3, :margin_left, 10)
set_gtk_property!(g3, :row_spacing, 10)  # introduce a 15-pixel gap between columns

g4 = GtkGrid()
g4[1,1] = GtkLabel("Suma glavne dijagonale: ")
g4[1,2] = suma_diagonale
set_gtk_property!(g4, :margin_left, 10)
set_gtk_property!(g4, :row_spacing, 10)  # introduce a 15-pixel gap between columns

g5 = GtkGrid()
g5[1,1] = GtkLabel("Suma sporedne dijagonale: ")
g5[1,2] = suma_sporedne
set_gtk_property!(g5, :margin_left, 10)
set_gtk_property!(g5, :margin_right, 10)
set_gtk_property!(g5, :row_spacing, 10)  # introduce a 15-pixel gap between columns


# Now let's place these graphical elements into the Grid:
g[1,1] = label
g[2:3,1] = num1   # Cartesian coordinates, g[x,y] and span columns
g[3,2] = button
g[1,3] = g1
g[2,3] = g2
g[1,4] = g3
g[2,4] = g4
g[3,4] = g5
set_gtk_property!(g, :column_spacing, 15)  # introduce a 15-pixel gap between columns
set_gtk_property!(g, :row_spacing, 15)  # introduce a 15-pixel gap between columns

push!(win, g)

function stringFromMatrix(a)
    result1 = "    "
    for i in 1 : 1 : size(a,1)
        for j in 1 : 1 : size(a,2)
            result1 = result1 * string(a[i,j]) * "    "
            end
        result1 = result1 *  string("\n") * "    "
    end
    return result1
end

function sume(mat)
    suma_matrice=0
    suma_redova=zeros(size(mat,1))
    suma_kolona=zeros(size(mat,2))
    suma_diagonale=0
    suma_sporedne=0
    for i = 1:size(mat,1)
        for j = 1:size(mat,2)
           suma_matrice+=mat[i,j]
           suma_redova[i]+=mat[i,j]
           suma_kolona[j]+=mat[i,j]
           if size(mat,1) == size(mat,2)
              if i==j
                  suma_diagonale+=mat[i,j]
              end
              if (i + j) == (size(mat,1)+1)
                    suma_sporedne += mat[i,j];
              end
           end
        end
    end
    return suma_matrice,suma_redova,suma_kolona, suma_diagonale, suma_sporedne
end

function on_button_clicked(w)
    x = get_gtk_property(num1,:text,String)
    if(cmp(x, "") == 0)
        matrix1 = 0
    else
    matrix1 = np.matrix(x)
    end

    (a, b, c, d, e) = sume(matrix1)

    GAccessor.text(suma_matrice, stringFromMatrix(a))
    GAccessor.text(suma_redova, stringFromMatrix(b))
    GAccessor.text(suma_kolona, stringFromMatrix(c))
    GAccessor.text(suma_diagonale, stringFromMatrix(d))
    GAccessor.text(suma_sporedne, stringFromMatrix(e))
end
signal_connect(on_button_clicked, button, "clicked")

showall(win)
