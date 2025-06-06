var dashModel = require("../models/dashModel");

function dadosSilos(req, res) {

    dashModel.dadosSilos().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function dadosSilosMedios(req, res) {

    const limite_linhas = 10;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    dashModel.dadosSilosMedios(limite_linhas).then(function (resultado1) {
        if (resultado1.length > 0) {
            res.status(200).json(resultado1);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function dadosSilosMonitorados(req, res) {

    dashModel.dadosSilosMonitorados().then(function (resultado1) {
        if (resultado1.length > 0) {
            res.status(200).json(resultado1);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function dadosSilosAtualizar(req, res) {

    // var idAquario = req.params.idAquario;

    console.log(`Recuperando medidas em tempo real`);

    dashModel.dadosSilosAtualizar().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


module.exports = {
    dadosSilos,
    dadosSilosMedios,
    dadosSilosMonitorados,
    dadosSilosAtualizar
}