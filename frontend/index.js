const axios = require('axios');
const Plotly = require('plotly.js/lib/index-basic');

Plotly.newPlot('plot', []);

function renderRatios(data){
  const curenciesRatios = data.reduce((accumulator, ratio) => {
    if(!accumulator[ratio.from_currency]){
      accumulator[ratio.from_currency] = {
        x: [],
        y: [],
        name: ratio.from_currency,
        type: 'scatter'
      };
    }
    accumulator[ratio.from_currency].x.push(ratio.ts);
    accumulator[ratio.from_currency].y.push(ratio.buy);

    return accumulator;
  }, {});

  const plotData = [];
  Object.keys(curenciesRatios).forEach((key) => {
    plotData.push(curenciesRatios[key]);
  });
console.log(plotData);
  Plotly.addTraces('plot', plotData);
};

axios.get('/ratios')
  .then(function (response) {
    renderRatios(response.data);
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
  .then(function () {
  });

axios.get('/avg_day_ratios')
  .then(function (response) {
    renderRatios(response.data);
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
  .then(function () {
  });
