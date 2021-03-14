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
        // y:-12,
        distance: 15,
        text: '<a href="/variances/' + variance.id + '">changed</a>',
        backgroundColor: 'white'
      })
    });

    return data_with_var
  }

  function create_chart(key, positions, keyword_id, variances, categories) {
    Highcharts.chart('chart key-id-' + keyword_id, {

        chart: {
            type: 'area',
            height: 125,
            scrollablePlotArea: {
                minWidth: 600
            },
            backgroundColor: '#1e1f2d'
        },

        lang: {
          noData: "loading... data"
        },

        exporting: {
          enabled: false
        },

        title: {
          text: undefined
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
          title: {
              text: 'Date'
          },
          labels: {
            enabled: false
          },
          tickWidth: 0,
          visible: false
        },


        yAxis: {
            startOnTick: true,
            endOnTick: false,
            maxPadding: 0.1,
            reversed: true,
            title: {
                text: undefined
            },
            gridLineWidth: 0,
            showFirstLabel: false,
            min: 1,
        },

        tooltip: {
          headerFormat: '{point.key} <br>',
          pointFormat: 'Position:{point.y} <br>',
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
            lineColor: '#ba54f5',
    				color: '#262744',
            fillOpacity: 0.5,
            name: 'Position',
            marker: {
                enabled: true,
                fillColor: '#ba54f5',
                lineWidth: 1,
                lineColor: '#ba54f5'
            },
            threshold: Infinity,
        }]

    });
  }

  $('.link_modal').click(function() {
    var key_id = $(this).attr('data-id')
    var key = gon.keywords.find(x => x.id === parseInt(key_id))

    var array_date = create_data(key)

    var positions = array_date[0]
    var categories = array_date[1]

    var variances = create_data_variance(key, positions, categories)

    $('.modal-trend').on('shown.bs.modal', function () {
      create_big_chart(key, positions, variances, categories)
    });

  });

  function create_big_chart(key, positions, variances, categories) {
    Highcharts.chart('modal-content', {

        chart: {
            type: 'area',
            zoomType: 'x',
            height: 250,
            scrollablePlotArea: {
                minWidth: 600
            },
            backgroundColor: '#1e1f2d'
        },

        lang: {
          noData: "loading... data"
        },

        exporting: {
          enabled: false
        },

        title: {
          text: undefined
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
          title: {
              text: 'Date'
          }
        },


        yAxis: {
            startOnTick: true,
            endOnTick: false,
            reversed: true,
            title: {
                text: undefined
            },
            gridLineWidth: 0,
            showFirstLabel: true,
            min: 1,
        },

        tooltip: {
          headerFormat: '{point.key} <br>',
          pointFormat: 'Position:{point.y} <br>',
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
            lineColor: '#ba54f5',
    				color: '#262744',
            fillOpacity: 0.5,
            name: 'Position',
            marker: {
                enabled: true,
                fillColor: '#ba54f5',
                lineWidth: 1,
                lineColor: '#ba54f5'
            },
            threshold: Infinity,
        }]

    });
  }

});


/*
 Highcharts JS v9.0.1 (2021-02-15)
 Plugin for displaying a message when there is no data visible in chart.
*/

(function(a){"object"===typeof module&&module.exports?(a["default"]=a,module.exports=a):"function"===typeof define&&define.amd?define("highcharts/modules/no-data-to-display",["highcharts"],function(b){a(b);a.Highcharts=b;return a}):a("undefined"!==typeof Highcharts?Highcharts:void 0)})(function(a){function b(a,b,f,c){a.hasOwnProperty(b)||(a[b]=c.apply(null,f))}a=a?a._modules:{};b(a,"Extensions/NoDataToDisplay.js",[a["Core/Renderer/HTML/AST.js"],a["Core/Chart/Chart.js"],a["Core/Color/Palette.js"],
a["Core/Utilities.js"]],function(a,b,f,c){var h=c.addEvent,g=c.extend,e=c.getOptions;c=b.prototype;e=e();g(e.lang,{noData:"No data to display"});e.noData={attr:{zIndex:1},position:{x:0,y:0,align:"center",verticalAlign:"middle"},style:{fontWeight:"bold",fontSize:"12px",color:f.neutralColor60}};c.showNoData=function(b){var d=this.options;b=b||d&&d.lang.noData;d=d&&(d.noData||{});this.renderer&&(this.noDataLabel||(this.noDataLabel=this.renderer.label(b,0,0,void 0,void 0,void 0,d.useHTML,void 0,"no-data").add()),
this.styledMode||this.noDataLabel.attr(a.filterUserAttributes(d.attr||{})).css(d.style||{}),this.noDataLabel.align(g(this.noDataLabel.getBBox(),d.position||{}),!1,"plotBox"))};c.hideNoData=function(){this.noDataLabel&&(this.noDataLabel=this.noDataLabel.destroy())};c.hasData=function(){for(var a=this.series||[],b=a.length;b--;)if(a[b].hasData()&&!a[b].options.isInternal)return!0;return this.loadingShown};h(b,"render",function(){this.hasData()?this.hideNoData():this.showNoData()})});b(a,"masters/modules/no-data-to-display.src.js",
[],function(){})});
