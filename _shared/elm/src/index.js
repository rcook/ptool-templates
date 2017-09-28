import "./main.css"
const logoPath = require("./logo.svg")
const Elm = require("./App.elm")
const root = document.getElementById("root")
{% block embed %}
Elm.App.embed(root, logoPath)
{% endblock %}