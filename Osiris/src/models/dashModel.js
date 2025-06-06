var database = require("../database/config");

function dadosSilos() {

    var instrucaoSql =
        `SELECT DATE(data_hora) as data_format, MAX(valor) as valor FROM leituraSensor GROUP BY DATE(data_hora) ORDER BY DATE(data_hora) DESC LIMIT 10; 
    `

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosSilosMedios(limite_linhas) {
    var instrucaoSql =
    `
    (
    SELECT fk_sensor as fk1, valor, data_hora
    FROM leituraSensor
    where fk_sensor = 1
    ORDER BY data_hora DESC
    LIMIT 10
)
UNION ALL
(
    SELECT fk_sensor as fk2, valor, data_hora
    FROM leituraSensor
    where fk_sensor = 2
    ORDER BY data_hora DESC
    LIMIT 10
)
LIMIT 20;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosSilosAtualizar(limite_linhas) {
    var instrucaoSql =
    `
    (
    SELECT fk_sensor as fk1, valor, data_hora
    FROM leituraSensor
    where fk_sensor = 1
    ORDER BY data_hora DESC
    LIMIT 1
    
)
UNION ALL
(
    SELECT fk_sensor as fk2, valor, data_hora
    FROM leituraSensor
    where fk_sensor = 2
    ORDER BY data_hora DESC
    LIMIT 1
)
LIMIT 2;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosSilosMonitorados() {
        var instrucaoSql =
        `select idSilo, IFNULL(silo_id, 0) as fkSilo from silo left join sensor on idSilo = silo_id;`
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
}

module.exports = {
    dadosSilos,
    dadosSilosMedios,
    dadosSilosMonitorados,
    dadosSilosAtualizar
}