CREATE TABLE farmacias {
    id_farmacia      SERIAL   UNIQUE PRIMARY KEY,
    bairro           TEXT     NOT NULL,
    cidade           TEXT     NOT NULL,
    estado           TEXT     NOT NULL,
    tipo_farmacia    TEXT     NOT NULL,
    cpf_gerente_farm CHAR(11) FOREIGN KEY funcionarios(cargo_func),  
    CONSTRAINT tiposDeFarmacia CHECK (tipo_farmacia IN ('sede', 'filial'))    

};

CREATE TABLE funcionarios {
    farmacia_func       SERIAL   FOREIGN KEY REFERENCES farmacias(id_farmacia),
    cpf_func            CHAR(11) UNIQUE PRIMARY KEY,
    nome_func           TEXT     NOT NULL,
    cargo_func          TEXT, 
    func_eh_gerente     BOOLEAN  UNIQUE,
    CONSTRAINT tiposDeCargo CHECK (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL))
};

CREATE TABLE medicamentos {
    id_medicamento       SERIAL PRIMARY KEY,
    nome_med             TEXT,
    venda_com_receita    BOOLEAN,

};

CREATE TABLE vendas {

};

CREATE TABLE entregas {
    cpf_cli CHAR(11) NOT NULL,


};

CREATE TABLE clientes {
    cpf_cli         CHAR(11) UNIQUE PRIMARY KEY,
    nome_cli        TEXT,
};

CREATE TABLE enderecos_clientes {
    cpf_cli         CHAR(11)    FOREIGN KEY REFERENCES clientes(cpf_cli),
    id_endereco     SERIAL      PRIMARY KEY,
    rua             TEXT        NOT NULL,
    bairro          TEXT        NOT NULL,
    cep             BIGINT      NOT NULL,
    numero          INTEGER     NOT NULL,
    tipo_endereco   TEXT        NOT NULL,
    CONSTRAINT tiposDeEnderecos CHECK (tipo_endereco IN ('residencia', 'trabalho', 'outro')
};

-- parei na questao 9