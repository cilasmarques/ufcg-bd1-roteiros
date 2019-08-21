CREATE TABLE AUTOMOVEL (
	n_chassi          CHAR(17) PRIMARY KEY,
	placa             CHAR(7),
	fabricante        VARCHAR(20),
	modelo            VARCHAR(20),
	cor  			  VARCHAR(8),
	ano               CHAR(4),
	cpf_segurado      CHAR(11) NOT NULL
);

CREATE TABLE SEGURADO (
	cpf               CHAR(11) PRIMARY KEY,
	nome              VARCHAR(20) NOT NULL,
	rg                CHAR(9) NOT NULL,
	sexo              CHAR(1),
	nascimento        DATE,
	endereco          VARCHAR(50),
	telefone          INTEGER,
	codigo_seguro     CHAR(19) NOT NULL
);

CREATE TABLE PERITO (	
	cpf               CHAR(11) PRIMARY KEY,
	nome              VARCHAR(20) NOT NULL,
	endereco          VARCHAR(50) NOT NULL,
	sexo              CHAR(1),		
	telefone          INTEGER		
);

CREATE TABLE OFICINA (	
	cnpj              CHAR(14) PRIMARY KEY,
	nome              VARCHAR(20) NOT NULL,
	endereco          VARCHAR(50) NOT NULL,
	telefone          INTEGER
);

CREATE TABLE SEGURO (
	codigo_seguro               CHAR(19) PRIMARY KEY,
	nome_seguro                 VARCHAR(50),
	n_chassi_automovel_segurado CHAR(17) NOT NULL,
	validade                    DATE NOT NULL
);

CREATE TABLE SINISTRO (
	id_evento         SERIAL PRIMARY KEY,
	codigo_seguro     CHAR(19) NOT NULL,
	data_evento       DATE NOT NULL
);

CREATE TABLE PERICIA (
	id_pericia        SERIAL PRIMARY KEY,
	cpf_perito        CHAR(11) NOT NULL,
	laudo_pericia     VARCHAR(5000),
	data_pericia      DATE NOT NULL
);

CREATE TABLE REPARO (
	id_reparo                   SERIAL PRIMARY KEY,
 	cnpj_oficina                CHAR(14) NOT NULL,
	n_chassi_automovel_reparado CHAR(17) NOT NULL,
	laudo_reparo                VARCHAR(5000),
	data_reparo                 DATE NOT NULL
);

ALTER TABLE automovel ADD CONSTRAINT automovel_segurado FOREIGN KEY (cpf_segurado)                REFERENCES segurado  (cpf);
ALTER TABLE segurado  ADD CONSTRAINT segurado_seguro    FOREIGN KEY (codigo_seguro)               REFERENCES seguro   (codigo_seguro);
ALTER TABLE seguro    ADD CONSTRAINT seguro_automovel   FOREIGN KEY (n_chassi_automovel_segurado) REFERENCES automovel (n_chassi);
ALTER TABLE sinistro  ADD CONSTRAINT sinistro_seguro    FOREIGN KEY (codigo_seguro)               REFERENCES seguro (codigo_seguro);
ALTER TABLE reparo    ADD CONSTRAINT reparo_automovel   FOREIGN KEY (n_chassi_automovel_reparado) REFERENCES automovel (n_chassi);
ALTER TABLE reparo    ADD CONSTRAINT reparo_oficina     FOREIGN KEY (cnpj_oficina)                REFERENCES oficina   (cnpj);
ALTER TABLE pericia   ADD CONSTRAINT pericia_perito     FOREIGN KEY (cpf_perito)                  REFERENCES perito    (cpf);
