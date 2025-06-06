var express = require("express");
var router = express.Router();

var dashController = require("../controllers/dashController");

router.get("/silos", function (req, res) {
    dashController.dadosSilos(req, res);
});

router.get("/silosMedios", function (req, res) {
    dashController.dadosSilosMedios(req, res);
});

router.get("/silosMonitorados", function (req, res) {
    dashController.dadosSilosMonitorados(req, res);
});

module.exports = router;