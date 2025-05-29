var database = require("../database/config");

function dadosSilos(limite_linhas) {

    var instrucaoSql =
        `select valor, dtRegistro FROM leituraSensor ORDER BY dtRegistro DESC LIMIT ${limite_linhas};
    `

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    dadosSilos
}
