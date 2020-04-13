// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap";
import "../stylesheets/application";
import "@fortawesome/fontawesome-free/css/all.css";

require("chartkick")
require("chart.js")

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

global.toastr = require("toastr")

require("packs/demo")
require("packs/adminlte")
require("packs/dashboard")
require("packs/select")
require("packs/pagination")
require("packs/sale_chart")

