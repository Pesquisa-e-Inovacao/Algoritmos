-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

/*
GRUPO 04

Erick Yoshinori
Marília Donato
Matheus Carvalho
Rodrigo Gobetti
Vinicius Silva
*/

DROP DATABASE osiris;
CREATE DATABASE osiris;
USE osiris;
CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(50) not null,
    senha VARCHAR(50) not null,
    cnpj CHAR(18) UNIQUE not null,
    email VARCHAR(50) UNIQUE not null,
    dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Inserindo dados na tabela
INSERT INTO empresa(nomeEmpresa, senha, cnpj, email) VALUES   
	('SPTrack', 'nRxtGe38330ss', '09491417000179', 'sptrackempresa@gmail.com'),  
	('Rodrigao Sojas', 'marh1q5osAexdyt', '94163378000150', 'rodrigao@rodrigao.com');
CREATE TABLE cargo(
	idCargo INT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(100),
    funcao VARCHAR(100),
    acesso_sist TINYINT
);

INSERT INTO cargo (cargo) VALUES
("Dono"),
("Proletário");

CREATE TABLE funcionario(
	idFuncionario INT AUTO_INCREMENT not null,
	fkEmpresa INT not null,
    fkSupervisor INT not null,
	fkCargo INT not null,
    nomeFuncionario VARCHAR(50) NOT NULL,
    email VARCHAR(30) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    turno VARCHAR(50) NOT NULL,
    status_a TINYINT NOT NULL,
	cert_brigadista TINYINT,
    CONSTRAINT depPK PRIMARY KEY (idFuncionario, fkEmpresa),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo),
    FOREIGN KEY (fkSupervisor) REFERENCES funcionario(idFuncionario)
);

INSERT INTO funcionario (nomeFuncionario, email, senha, fkEmpresa, fkCargo, fkSupervisor, turno, status_a, cert_brigadista) VALUES
	('Marília', 'marilia@sptech.school', 'dsghr', 2, 1, 1, "Manhã", 1, 0),
	('Erick', 'erick@sptech.school', 'lknregnj', 2, 2, 1, "Manhã", 1, 0),
	('Rodrigo', 'rodrigo@sptech.school', 'dsghr', 2, 1, 3, "Integral", 1, 1),
	('Matheus', 'matheus@sptech.school', '12435yu', 2, 2, 3, "Integral", 1, 1),
	('Vinicius', 'vinicius@sptech.school', '12435yu', 2, 2, 3, "Integral", 1, 1);
    
CREATE TABLE silo(
idSilo INT PRIMARY KEY AUTO_INCREMENT,
identificador VARCHAR(100),
tipo_silo VARCHAR(100),
cap_armazenamento VARCHAR(100),
dtInstalacao VARCHAR(45),
fkFuncionario INT UNIQUE,
FOREIGN KEY (fkFuncionario) REFERENCES funcionario(idFuncionario),
fkEmpresa_funcionario INT,
FOREIGN KEY (fkEmpresa_funcionario) REFERENCES funcionario(fkEmpresa));

INSERT INTO silo (identificador, tipo_silo, cap_armazenamento, dtInstalacao, fkFuncionario, fkEmpresa_funcionario) VALUES
("Soja 2023/2024", "Madeira", 20000, 2025-01-02, 1, 2);
CREATE TABLE sensor(
	idSensor int primary key auto_increment,
    modelo VARCHAR(100) not null,
    fabricante VARCHAR(100) not null,
    tipoSensor VARCHAR(100) not null,
    dtInstalacao DATE,
    status_s TINYINT,
    fkSilo INT UNIQUE,
    FOREIGN KEY (fkSilo) REFERENCES silo(idSilo)
);

INSERT INTO sensor (modelo, fabricante, tipoSensor, dtInstalacao, status_s, fkSilo) VALUES
("MQ-2", "Rodrigo Sensores", "Detecção de gás", "2025-04-22", 1, 1);

CREATE TABLE leituraSensor(
	idRegistro INT AUTO_INCREMENT,
    fkSensor INT not null,
    CONSTRAINT depPK_sensor PRIMARY KEY (idRegistro, fkSensor),
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor VARCHAR(50),
    uni_medida VARCHAR(100),
    tipo_alerta VARCHAR(100)
);

SELECT * from empresa;
SELECT * from cargo;
SELECT * from funcionario;
SELECT * from sensor;
SELECT * from leituraSensor;
SELECT * from silo;

DELETE FROM leituraSensor WHERE idRegistro = 6 OR idRegistro = 5 OR idRegistro = 36 or idRegistro = 37;

SELECT e.nomeEmpresa as "Empresa", e.cnpj as "CNPJ", e.email as "Email Empresa", f.nomeFuncionario as "Nome Funcionário", f.email as "Nome Funcionário
", c.cargo as "Cargo", fs.nomeFuncionario as "Nome Supervisor", fs.email as "Email Supervisor", cs.cargo as "Cargo Supervisor"
FROM empresa as e 
JOIN funcionario as f ON e.idEmpresa = f.fkEmpresa
JOIN cargo as c ON c.idCargo = f.fkCargo
JOIN funcionario as fs ON fs.idFuncionario = f.fkSupervisor
JOIN cargo as cs ON cs.idCargo = fs.fkCargo ORDER BY e.nomeEmpresa, f.fkCargo ASC;

SELECT e.nomeEmpresa as "Empresa"
, f.nomeFuncionario as "Funcionário Responsável",
 sl.identificador as "Silo", s.modelo as "Sensor", CONCAT(ls.valor, "%") as "Porcentagem de metano", ls.dtRegistro as "Data Captura" 
FROM leituraSensor as ls
JOIN sensor as s ON ls.fkSensor = s.idSensor
JOIN silo as sl ON s.fkSilo = sl.idSilo
JOIN funcionario as f ON sl.fkFuncionario = f.idFuncionario
JOIN empresa as e ON f.fkEmpresa = e.idEmpresa
ORDER BY ls.dtRegistro DESC;

DELETE from leituraSensor where idRegistro > 1;
SELECT * from leituraSensor;