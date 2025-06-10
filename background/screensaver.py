import tkinter as tk
from PIL import Image, ImageTk

# Ruta de tu imagen
ruta_imagen = "/fondoada.jpg"  # Asegúrate que esté en la misma carpeta

root = tk.Tk()
root.attributes("-fullscreen", True)
root.config(cursor="none")  # Oculta el cursor

# Cierra el protector si hay movimiento o clic
root.bind("<Motion>", lambda e: root.destroy())
root.bind("<Key>", lambda e: root.destroy())
root.bind("<Button>", lambda e: root.destroy())

imagen = Image.open(ruta_imagen)
pantalla = ImageTk.PhotoImage(imagen.resize((root.winfo_screenwidth(), root.winfo_screenheight())))

fondo = tk.Label(root, image=pantalla)
fondo.pack()

root.mainloop()
