const express = require("express");
const cors = require("cors");

const veterinariosRoutes =
require("./routes/veterinarios.routes");

const animaisRoutes =
require("./routes/animais.routes");

const consultasRoutes =
require("./routes/consultas.routes");

const pagamentosRoutes =
require("./routes/pagamentos.routes");

const relatoriosRoutes =
require("./routes/relatorios.routes");

const app = express();

app.use(cors());

app.use(express.json());

app.use(
    "/api/veterinarios",
    veterinariosRoutes
);

app.use(
    "/api/animais",
    animaisRoutes
);

app.use(
    "/api/consultas",
    consultasRoutes
);

app.use(
    "/api/pagamentos",
    pagamentosRoutes
);

app.use(
    "/api/relatorios",
    relatoriosRoutes
);

module.exports = app;