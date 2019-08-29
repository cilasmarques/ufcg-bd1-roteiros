CREATE TABLE farmacias (
    cnpj                    CHAR(17)        PRIMARY KEY,
    bairro                  VARCHAR(40)     NOT NULL UNIQUE,
    sede                    VARCHAR(40)     NOT NULL UNIQUE,
    cidade                  VARCHAR(40)     NOT NULL,
    estado                  VARCHAR(40)     NOT NULL,
    tipo_farmacia           VARCHAR(40)     NOT NULL,
    cpf_gerente_farm        CHAR(11) ,  
    cpf_clientes_farm       CHAR(11) 
);

CREATE TABLE funcionarios (
    cpf_func            CHAR(11)    PRIMARY KEY,
    cnpj_farm_func      CHAR(17),
    nome_func           VARCHAR(40) NOT NULL,
    cargo_func          CHAR(11),
    func_eh_gerente     BOOLEAN     UNIQUE,
    fez_venda_func      BOOLEAN     
);

CREATE TABLE medicamentos (
    id_med                  SERIAL PRIMARY KEY,
    nome_med                TEXT,
    foi_vendido_med         BOOLEAN,     
    venda_com_receita_med   BOOLEAN
);

CREATE TABLE vendas (
    id_venda         INTEGER PRIMARY KEY,
    venda_realizada  BOOLEAN 
);

CREATE TABLE entregas (
    id_ent              INTEGER PRIMARY KEY,  
    end_cli_ent         SERIAL,
    ent_realizada       BOOLEAN
);

CREATE TABLE clientes (
    cpf_cli                     CHAR(11)  PRIMARY KEY,
    nome_cli                    VARCHAR(40),
    idade_cli                   CHAR(3),
    end_cliente_cli             SERIAL,
    farmacias_associadas_cli    CHAR(17)
);

CREATE TABLE enderecos_clientes (
    id_end              SERIAL      PRIMARY KEY,
    cpf_cli_end         CHAR(11)    NOT NULL,
    rua_end             VARCHAR(40) NOT NULL,
    bairro_end          VARCHAR(20) NOT NULL,
    cep_end             BIGINT      NOT NULL,
    numero_end          INTEGER     NOT NULL,
    tipo_end            VARCHAR(20) NOT NULL
);

--farmacias
ALTER TABLE farmacias ADD CONSTRAINT cpf_gerente        FOREIGN KEY  (cpf_gerente_farm)     REFERENCES funcionarios(cpf_func) ;
ALTER TABLE farmacias ADD CONSTRAINT cpf_cliente        FOREIGN KEY  (cpf_clientes_farm)     REFERENCES clientes(cpf_cli) ;
ALTER TABLE farmacias ADD CONSTRAINT tiposDeFarmacia    CHECK        (tipo_farmacia IN ('sede', 'filial'));    

--funcionarios
ALTER TABLE funcionarios ADD CONSTRAINT cnpj_farm            FOREIGN KEY  (cnpj_farm_func)   REFERENCES farmacias(cnpj);
ALTER TABLE funcionarios ADD CONSTRAINT func_fez_venda       FOREIGN KEY  (fez_venda_func)   REFERENCES vendas(venda_realizada);
ALTER TABLE funcionarios ADD CONSTRAINT naoDemite            CHECK        (fez_venda_func = TRUE);
ALTER TABLE funcionarios ADD CONSTRAINT tiposDeCargo         CHECK        (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL));
ALTER TABLE funcionarios ADD CONSTRAINT func_eh_gerente      CHECK        (fez_venda_func = TRUE AND cargo_func IN ('farmaceutico', 'administrador'));

--medicamentos
ALTER TABLE medicamentos ADD CONSTRAINT medicamento_vendido  FOREIGN KEY  (foi_vendido_med) REFERENCES vendas(venda_realizada);
ALTER TABLE medicamentos ADD CONSTRAINT naoExcluiMed         CHECK        (foi_vendido_med = TRUE);

--entregas
ALTER TABLE entregas ADD CONSTRAINT cpf_cli   FOREIGN KEY  (cpf_cli_ent)    REFERENCES farmacias(cpf_clientes_farm);
ALTER TABLE entregas ADD CONSTRAINT end_cli   FOREIGN KEY  (end_cli_ent)    REFERENCES clientes(end_cliente_cli);

--clientes
ALTER TABLE clientes ADD CONSTRAINT endereco_cliente      FOREIGN KEY  (end_cliente_cli)            REFERENCES  enderecos_clientes(id_end);
ALTER TABLE clientes ADD CONSTRAINT farmacias_associadas  FOREIGN KEY  (farmacias_associadas_cli)   REFERENCES  farmacias(cnpj);
ALTER TABLE clientes ADD CONSTRAINT cliente_maior_18      CHECK        (idade_cli >= 18);

--clientes_enderecos
ALTER TABLE enderecos_clientes ADD CONSTRAINT cpf_cliente FOREIGN KEY (cpf_cli_end) REFERENCES clientes(cpf_cli);
ALTER TABLE enderecos_clientes ADD CONSTRAINT tiposDeEnderecos  CHECK (tipo_end IN ('residencia', 'trabalho', 'outro'));

--entregas
ALTER TABLE entregas ADD CONSTRAINT id_venda_entrega FOREIGN KEY (id_ent)        REFERENCES vendas(id_venda);
ALTER TABLE entregas ADD CONSTRAINT entrega_ralizada FOREIGN KEY (ent_realizada) REFERENCES vendas(venda_realizada);

--11
