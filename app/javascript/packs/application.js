// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
// import "bootstrap"
import "../stylesheets/application"

require("packs/highcharts")
require("packs/black-dashboard")
require("packs/bootstrap.min.js")

import Highcharts from 'highcharts';
require('highcharts/modules/accessibility')(Highcharts);
require("highcharts/modules/exporting")(Highcharts)
require("highcharts/modules/annotations")(Highcharts)
require("highcharts/modules/export-data")(Highcharts)
window.Highcharts = Highcharts;


Rails.start()
Turbolinks.start()
ActiveStorage.start()
