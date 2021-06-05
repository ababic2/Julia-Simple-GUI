# using Pkg
# Pkg.add(“GR”)
# using GR
# using Plots
#using Gtk
#using Plots

# Napisati funkciju koja prima string koji je reprezentacija naredbe, te
# crta grafik proizvoljne funkcije jedne promjenljive. Potrebno je iskoristiti
# odgovarajuće meta naredbe za evaluaciju string-a kao izraza/naredbe. U
# funkciji predvidjeti da broj tačaka intervala bude 100, te da se funkcija
# crta na intervalu [-5,-5].

win = GtkWindow("Not Wolfram Alpha")

g = GtkGrid()
num1 = GtkEntry()  # a widget for entering text
set_gtk_property!(num1, :text, "")
set_gtk_property!(num1, :margin_top, 15)
set_gtk_property!(num1, :margin_right, 10)

button = GtkButton("Submit")
set_gtk_property!(button, :margin_right, 10)

label = GtkLabel("Enter function: ")
set_gtk_property!(label, :margin_top, 20)
set_gtk_property!(label, :margin_left, 10)

g[1,1] = label
g[2:3,1] = num1
g[3,2] = button

set_gtk_property!(g, :column_spacing, 15)  # introduce a 15-pixel gap between columns
set_gtk_property!(g, :row_spacing, 15)  # introduce a 15-pixel gap between columns

push!(win, g)

function crtaj(s::String)
    global x=LinRange(-5,5,100)
    x=[x;];
    y = eval(Meta.parse(s))
    display(Plots.plot(x, y))
end

function on_button_clicked(w)
    x = get_gtk_property(num1,:text,String)
    crtaj(x)
end
signal_connect(on_button_clicked, button, "clicked")

showall(win)
