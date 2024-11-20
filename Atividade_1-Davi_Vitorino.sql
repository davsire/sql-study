CREATE TABLE Ambulatorios (
	nroa INT,
	andar NUMERIC(2) NOT NULL,
  	capacidade SMALLINT,
  	PRIMARY KEY(nroa)
);

CREATE TABLE Medicos (
	codm INT,
  	nome VARCHAR(40) NOT NULL,
  	idade SMALLINT NOT NULL,
  	cidade VARCHAR(40),
  	CPF NUMERIC(11) NOT NULL UNIQUE,
  	especialidade VARCHAR(30),
  	nroa INT,
  	PRIMARY KEY(codm),
  	FOREIGN KEY(nroa) REFERENCES Ambulatorios
);

CREATE TABLE Pacientes (
	codp INT,
  	nome VARCHAR(40) NOT NULL,
  	idade SMALLINT NOT NULL,
  	cidade VARCHAR(40),
  	CPF NUMERIC(11) NOT NULL UNIQUE,
  	doenca VARCHAR(40) NOT NULL,
  	PRIMARY KEY(codp)
);

CREATE TABLE Funcionarios (
  	codf INT,
  	nome VARCHAR(40) NOT NULL,
  	idade SMALLINT NOT NULL,
  	cidade VARCHAR(40),
  	CPF NUMERIC(11) NOT NULL UNIQUE,
  	salario NUMERIC(10),
  	cargo VARCHAR(40),
  	PRIMARY KEY(codf)
);

CREATE TABLE Consultas (
	codm INT,
  	codp INT,
  	data DATE,
  	hora TIME,
  	PRIMARY KEY(codm, codp, data),
  	FOREIGN KEY(codm) REFERENCES Medicos,
  	FOREIGN KEY(codp) REFERENCES Pacientes
);

ALTER TABLE Funcionarios DROP COLUMN cargo;

CREATE INDEX idx_Paciente_Cidade ON Pacientes(cidade);
