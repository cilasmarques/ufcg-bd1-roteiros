CREATE TABLE farmacias (
    cnpj                    CHAR(17)        PRIMARY KEY,
    bairro                  VARCHAR(40)     NOT NULL,
    cidade                  VARCHAR(40)     NOT NULL,
    estado                  VARCHAR(40)     NOT NULL,
    tipo_farmacia           VARCHAR(40)     NOT NULL,
    cpf_gerente_farm        CHAR(11) ,  
    cpf_cliente_farmacia    CHAR(11) 
);
ALTER TABLE farmacias ADD CONSTRAINT cpf_gerente        FOREIGN KEY  (cpf_gerente_farm)     REFERENCES funcionarios(cargo_func) ;
ALTER TABLE farmacias ADD CONSTRAINT cpf_cliente        FOREIGN KEY  (cpf_cliente_farmacia) REFERENCES clientes(cpf_cli) ;
ALTER TABLE farmacias ADD CONSTRAINT tiposDeFarmacia    CHECK        (tipo_farmacia IN ('sede', 'filial');    


CREATE TABLE funcionarios (
    cpf_func            CHAR(11)    PRIMARY KEY,
    cnpj_farm_func      SERIAL,
    nome_func           VARCHAR(40) NOT NULL,
    cargo_func          CHAR(11),
    func_eh_gerente     BOOLEAN     UNIQUE,
    ja_vendeu           BOOLEAN     
);
ALTER TABLE funcionarios ADD CONSTRAINT cnpj_farm            FOREIGN KEY  (cnpj_farm_func)   REFERENCES farmacias(cnpj);
ALTER TABLE funcionarios ADD CONSTRAINT func_ja_vendeu       FOREIGN KEY  (ja_vendeu)        REFERENCES vendas(venda_realizada);
ALTER TABLE funcionarios ADD CONSTRAINT tiposDeCargo         CHECK        (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL);
ALTER TABLE funcionarios ADD CONSTRAINT naoDemite            CHECK        (ja_vendeu IN TRUE);

CREATE TABLE medicamentos (
    id_med                  SERIAL PRIMARY KEY,
    nome_med                TEXT,
    venda_com_receita_med   BOOLEAN
);

CREATE TABLE vendas (
    venda_realizada  BOOLEAN PRIMARY KEY
);

CREATE TABLE entregas (
    cpf_cli_ent  CHAR(11), 
    ende_cli_ent SERIAL   
);
ALTER TABLE entregas ADD CONSTRAINT cnpj_cli  FOREIGN KEY  (cpf_cli_ent)    REFERENCES farmacias(cpf_cliente_farmacia);
ALTER TABLE entregas ADD CONSTRAINT ende_cli  FOREIGN KEY  (ende_cli_ent)   REFERENCES clientes(endereco_cliente);

CREATE TABLE clientes (
    cpf_cli           CHAR(11)  PRIMARY KEY,
    nome_cli          VARCHAR(40),
    end_cliente_cli   SERIAL
);
ALTER TABLE clientes ADD CONSTRAINT endereco_cliente  FOREIGN KEY  (end_cliente_cli)   REFERENCES  enderecos_clientes(id_endereco);

CREATE TABLE enderecos_clientes (
    id_endereco_end     SERIAL      PRIMARY KEY,
    cpf_cli_end         CHAR(11)    NOT NULL,
    rua_end             VARCHAR(40) NOT NULL,
    bairro_end          VARCHAR(20) NOT NULL,
    cep_end             BIGINT      NOT NULL,
    numero_end          INTEGER     NOT NULL,
    tipo_end            VARCHAR(20) NOT NULL
);
ALTER TABLE clientes ADD CONSTRAINT cpf_cliente FOREIGN KEY cpf_cli_end REFERENCES clientes(cpf_cli);
ALTER TABLE ADD CONSTRAINT tiposDeEnderecos CHECK (tipo_endereco IN ('residencia', 'trabalho', 'outro');

--11