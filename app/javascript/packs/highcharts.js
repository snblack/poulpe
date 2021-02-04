import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {
  // Data generated from http://www.bikeforums.net/professional-cycling-fans/1113087-2017-tour-de-france-gpx-tcx-files.html
  var elevationData = [
      [1, 20],
      [2, 18],
      [3, 19],
      [4, 15],
      [5, 10],
      [6, 12],
      [7, 15],
      [8, 22],
      [9, 30],
      [10, 40]
  ];

  // Now create the chart
  Highcharts.chart('container', {

      chart: {
          type: 'area',
          zoomType: 'x',
          panning: false,
          panKey: 'shift',
          scrollablePlotArea: {
              minWidth: 600
          }
      },

      title: {
          text: 'Chart position with changes'
      },

      credits: {
          enabled: false
      },

      annotations: [{
          draggable: '',
          labels: [{
              point: {
                  xAxis: 0,
                  yAxis: 0,
                  x: 2,
                  y: 18
              },
              x: -30,
              text: 'Product Changed'
          }, {
              point: {
                  xAxis: 0,
                  yAxis: 0,
                  x: 6,
                  y: 12
              },
              text: 'Product Changed'
          }, {
              point: {
                  xAxis: 0,
                  yAxis: 0,
                  x: 10,
                  y: 40
              },
              text: 'Product Changed'
          }]
      }],

      xAxis: {
          labels: {
              format: '{value} Day of week'
          },
          minRange: 5,
          title: {
              text: 'Date'
          },
          accessibility: {
              rangeDescription: 'Range: 0 to 187.8km.'
          }
      },

      yAxis: {
          startOnTick: true,
          endOnTick: false,
          maxPadding: 0.35,
          reversed: true,
          title: {
              text: 'Position'
          },
          labels: {
              format: '{value}'
          }
      },

      tooltip: {
          headerFormat: 'Position: {point.x} <br>',
          pointFormat: '{point.y} day of week',
          shared: true
      },

      legend: {
          enabled: false
      },

      series: [{
          accessibility: {
              keyboardNavigation: {
                  enabled: false
              }
          },
          data: elevationData,
          lineColor: Highcharts.getOptions().colors[1],
  				Color: Highcharts.getOptions().colors[4],
          fillOpacity: 0.5,
          name: 'Position',
          marker: {
              enabled: false
          },
          threshold: Infinity,
      }]

  });
});
