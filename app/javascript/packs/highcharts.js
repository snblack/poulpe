import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {

  // Мы для каждого ключа создаем create_chart
  // и вставляем его в div c id этого ключа
  gon.keywords.forEach(function(key) {
    // console.log(key.positions);
    var data = create_data(key)
    var chart = create_chart(key, data, key.id)
  });

  function create_data(key) {
    let data_with_positions = []

    key.positions.forEach((pos) => {
      data_with_positions.push([Date.parse(pos.created_at), parseInt(pos.value)])
    });

    return data_with_positions
  }

  function create_chart(key, data, keyword_id) {
    // Now create the chart
    Highcharts.chart('chart key-id-' + keyword_id, {

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
            type: 'datetime',
            labels: {

            },
            minRange: 5,
            title: {
                text: 'Date'
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
            headerFormat: 'Position: {point.y} <br>',
            pointFormat: '{point.x} day of week',
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
            data: data,
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
  }

});
