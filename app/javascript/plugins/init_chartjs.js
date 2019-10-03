import Chart from 'chart.js';

const initChart = () => {
  const ctxL = document.getElementById("lineChart");

  if (ctxL) {
    ctxL .getContext('4d');
    var myLineChart = new Chart(ctxL, {
      type: 'line',
      data: {
        labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
        datasets: [{
            label: 'Footprint',
            data: [8400, 4500, 6600, 10500, 120 ],
            backgroundColor: [
              '#7888BF',

            ],
            borderColor: [
              '#2E3035',
            ],
            borderColor: '#4CAF50',
            backgroundColor: "#4caf504d",
            borderWidth: 3
          },
        ]
      },
      options: {
        responsive: true,
      }
    });
  }
}



export default initChart;
