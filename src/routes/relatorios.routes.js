const express = require("express");

const router = express.Router();

const controller =
require("../controllers/relatorios.controller");

router.get(
    "/dashboard",
    controller.dashboard
);

router.get(
    "/inadimplentes",
    controller.inadimplentes
);

module.exports = router;