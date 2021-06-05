#Napisati funkciju koja vrši sabiranje i oduzimanje dva proslijedena argu-
#menta, i vraća oba rezultata. Dodati provjeru broja argumenata. Ako
#argument nije proslijeden, dodijeliti mu 0. Obzirom da argumenti mogu
#biti matrice, izvršite provjeru dimenzija. U slučaju da se dimenzije ne
#podudaraju vratiti rezultat 0. Potrebno je provjeriti rad funkcije.
using Pkg
Pkg.add("Gtk")
Pkg.add("PyCall")
win = GtkWindow("Not Wolfram Alpha")
np = pyimport(“numpy”)

g = GtkGrid()
num1 = GtkEntry()  # a widget for entering text
set_gtk_property!(num1, :text, "")
set_gtk_property!(num1, :margin_top, 15)

num2 = GtkEntry()  # a widget for entering text
set_gtk_property!(num2, :text, "")
set_gtk_property!(num2, :margin_top, 15)
set_gtk_property!(num2, :margin_right, 10)

button = GtkButton("Submit")
set_gtk_property!(button, :margin_right, 10)

label = GtkLabel("Enter numbers: ")
set_gtk_property!(label, :margin_top, 20)
set_gtk_property!(label, :margin_left, 10)

zbir = GtkLabel("")
razlika = GtkLabel("")

g1 = GtkGrid()
g1[1,1] = GtkLabel("Zbir: ")
g1[1,2] = zbir
set_gtk_property!(g1, :margin_left, 10)
set_gtk_property!(g1, :row_spacing, 10)  # introduce a 10-pixel gap between columns

g2 = GtkGrid()
g2[1,1] = GtkLabel("Razlika: ")
g2[1,2] = razlika
set_gtk_property!(g2, :margin_left, 10)
set_gtk_property!(g2, :row_spacing, 10)

# Place these graphical elements into the Grid:
g[1,1] = label
g[2,1] = num1   # Cartesian coordinates, g[x,y]
g[3,1] = num2
g[3,2] = button
g[1,3] = g1
g[2,3] = g2
set_gtk_property!(g, :column_spacing, 15)  # introduce a 15-pixel gap between columns
set_gtk_property!(g, :row_spacing, 15)  # introduce a 15-pixel gap between columns

push!(win, g)

function zbir_razlika(x=0,y=0)
 if (size(x)===size(y))
  x + y, x-y
 else return (0,0)
 end
end

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

function on_button_clicked(w)
    x = get_gtk_property(num1,:text,String)

    if(cmp(x, "") == 0)
        matrix1 = 0
    else
        matrix1 = np.matrix(x)
    end

    y = get_gtk_property(num2,:text,String)
    if(cmp(y, "") == 0)
        matrix2 = 0
    else
            matrix2 = np.matrix(y)
    end

    (a, b) = zbir_razlika(matrix1, matrix2)

    GAccessor.text(zbir, stringFromMatrix(a))
    GAccessor.text(razlika,stringFromMatrix(b))
end
signal_connect(on_button_clicked, button, "clicked")

showall(win)
