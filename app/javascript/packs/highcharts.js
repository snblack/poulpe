import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {

  // Мы для каждого ключа создаем create_chart
  // и вставляем его в div c id этого ключа
  gon.keywords.forEach(function(key) {
    var array_date = create_data(key)

    var positions = array_date[0]
    var categories = array_date[1]

    var variances = create_data_variance(key, positions, categories)

    create_chart(key, positions, key.id, variances, categories)
  });

  function create_data(key) {
    let data_with_positions = []
    let data_categories = []

    let positions = key.positions.sort((a, b) => Date.parse(a.created_at) - Date.parse(b.created_at))

    positions.forEach((pos) => {
      data_with_positions.push(parseInt(pos.value))
      data_categories.push(new Date(Date.parse(pos.created_at)).toLocaleDateString())
    });

    return [data_with_positions, data_categories]
  }

  function create_data_variance(key, positions, categories) {
    var variances = key.product.variances

    let data_with_var = []

    variances.forEach(function(variance) {
      let date = new Date(Date.parse(variance.created_at)).toLocaleDateString()
      let index_in_categories = categories.indexOf(date)
      var text = '<a href="/variances/"' + variance.id + ">Product Changed</a>"
      data_with_var.push({
        point: {
            xAxis: 0,
            yAxis: 0,
            x: index_in_categories,
            y: positions[index_in_categories]
        },
        y:-20,
        text: '<a href="/variances/' + variance.id + '">Product Changed</a>'
      })
    });

    return data_with_var
  }

  function create_chart(key, positions, keyword_id, variances, categories) {
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
            labels: variances
        }],

        xAxis: {
            categories: categories,
            // type: 'datetime',
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
            }
        },

        tooltip: {
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
            data: positions,
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
