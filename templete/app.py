from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

# Cargar datos de Active Directory
def cargar_datos():
    with open("ad_users.json", "r", encoding="utf-8") as file:
        return json.load(file)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/data")
def obtener_datos():
    datos = cargar_datos()
    return jsonify(datos)  # Devuelve los datos en formato JSON

if __name__ == "__main__":
    app.run(debug=True)
