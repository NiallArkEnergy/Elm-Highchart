import Highcharts from "highcharts";

export function createHighchart(tag) {
  customElements.define(
    tag,
    class extends HTMLElement {
      render() {
        this.chart = new Highcharts.Chart(
          Object.assign(
            JSON.parse(this.getAttribute("chartsettings") || "{}"),
            {
              chart: {
                renderTo: this
              }
            }
          )
        );
      }
      static get observedAttributes() {
        return ["chartsettings"];
      }
      attributeChangedCallback() {
        console.log("update");
        this.chart &&
          this.chart.update(JSON.parse(this.getAttribute("chartsettings")));
      }
      dispose() {
        this.chart && this.chart.destroy();
      }
      connectedCallback() {
        this.render();
      }
      disconnectedCallback() {
        this.dispose();
      }
    }
  );
}
