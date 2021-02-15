import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {

  // Мы для каждого ключа создаем create_chart
  // и вставляем его в div c id этого ключа
  gon.keywords.forEach(function(key) {
    var data = create_data(key)
    var data_var = create_data_variance(key)
    var categories = create_categories(key)
    var chart = create_chart(key, data, key.id, data_var, categories)
    console.log(data)
    console.log(categories)
  });

  function create_data(key) {
    let data_with_positions = []

    key.positions.forEach((pos) => {
      // data_with_positions.push([pos.created_at, parseInt(pos.value)])
      // data_with_positions.push({x: new Date(Date.parse(pos.created_at)).toLocaleDateString(), y: parseInt(pos.value) })
      // data_with_positions.push([Date.parse(pos.created_at),parseInt(pos.value)])
      data_with_positions.push(parseInt(pos.value))
    });

    return data_with_positions
  }

  function create_categories(key) {
    let data_categories = []

    key.positions.forEach((pos) => {
      // data_with_positions.push([pos.created_at, parseInt(pos.value)])
      // data_with_positions.push({x: new Date(Date.parse(pos.created_at)).toLocaleDateString(), y: parseInt(pos.value) })
      // data_with_positions.push([Date.parse(pos.created_at),parseInt(pos.value)])
      data_categories.push(new Date(Date.parse(pos.created_at)).toLocaleDateString())
    });

    return data_categories
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

  function create_chart(key, data, keyword_id, data_var, categories) {
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

        // xAxis: {
        //     type: 'datetime',
        //     title: {
        //         text: 'Date'
        //     },
        //
        //     labels: {
        //       format: '{value:%d/%m/%Y}'
        //     }
        // },

        xAxis: {
            categories: categories,
            // type: 'datetime',
            title: {
                text: 'Date'
            },

            // labels: {
              // format: '{value:%d/%m/%Y}'
            // }
        },


        yAxis: {
            startOnTick: true,
            endOnTick: false,
            maxPadding: 0.35,
            reversed: true,
            title: {
                text: 'Position'
            }
        },

        tooltip: {
            // headerFormat: '',
            pointFormat: 'Position: {point.y} <br>',
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
