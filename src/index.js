import { createHighchart } from "./customElements";
import { Elm } from "./Main.elm";

createHighchart("my-chart");
console.log("started");

Elm.Main.init({ node: document.getElementById("app") });
