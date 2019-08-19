CREATE TABLE AUTOMOVEL (
	placa CHAR(7) PRIMARY KEY,
	fabricante VARCHAR(20),
	modelo VARCHAR(20),
	cor VARCHAR(8),
	ano CHAR(4)
);

CREATE TABLE SEGURADO (
	cnh CHAR(11) PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	cpf CHAR(11) NOT NULL,
	rg CHAR(9) NOT NULL,
	sexo CHAR(1),
	nascimento DATE,
	endereco VARCHAR(50),
	telefone INTEGER
);

CREATE TABLE PERITO (	
	cpf CHAR(11) PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	endereco VARCHAR(50) NOT NULL,
	sexo CHAR(1),		
	telefone INTEGER		
);

CREATE TABLE OFICINA (	
	endereco VARCHAR(50) PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	telefone INTEGER
);

-- em desenvolvimento
CREATE TABLE SEGURO (	
	placa CHAR(7) PRIMARY KEY,
	modelo VARCHAR(20),	
	telefone INTEGER,
	validade DATE
);






