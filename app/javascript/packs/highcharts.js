import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {

  // Мы для каждого ключа создаем create_chart
  // и вставляем его в div c id этого ключа
  gon.keywords.forEach(function(key) {
    var data = create_data(key)
    var data_var = create_data_variance(key)
    var chart = create_chart(key, data, key.id, data_var)
  });

  function create_data(key) {
    let data_with_positions = []

    key.positions.forEach((pos) => {
      data_with_positions.push([Date.parse(pos.created_at), parseInt(pos.value)])
    });

    return data_with_positions
  }

  function create_data_variance(key) {
    var product = key.product
    var variances = product.variances

    let data_with_var = []

    variances.forEach(function(variance) {
      data_with_var.push({
        point: {
            xAxis: 0,
            yAxis: 0,
            x: Date.parse(variance.created_at),
            y: 6
        },
        x: -10,
        text: 'Product Changed'
      })
    });

    return data_with_var
  }

  // Находим product относящийся к keyword
  // Находим все variance по продукту

  function create_chart(key, data, keyword_id, data_var) {
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
            labels: data_var
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
