CREATE TABLE farmacias (
    cnpj                    CHAR(17)        PRIMARY KEY,
    tipo_farmacia           VARCHAR(40)     NOT NULL,
    bairro                  VARCHAR(40)     NOT NULL UNIQUE,
    sede                    VARCHAR(40)     UNIQUE,
    cidade                  VARCHAR(40)     NOT NULL,
    estado                  CHAR(2)         NOT NULL,
    cpf_gerente_farm        CHAR(11) ,  
    cpf_clientes_farm       CHAR(11) 
);

CREATE TABLE funcionarios (
    cpf_func            CHAR(11)    PRIMARY KEY,
    cnpj_farm_func      CHAR(17),
    nome_func           VARCHAR(40) NOT NULL,
    cargo_func          CHAR(11),
    func_eh_gerente     INTEGER,
    vendas_func         SERIAL      
);

CREATE TABLE medicamentos (
    id_med                  SERIAL PRIMARY KEY,
    nome_med                TEXT,
    vendidos_med            SERIAL,     
    venda_com_receita_med   BOOLEAN NOT NULL
);

CREATE TABLE vendas (
    id_venda               SERIAL PRIMARY KEY,  
    venda_para_cliente     BOOLEAN,
    venda_realizada        BOOLEAN 
);

CREATE TABLE entregas (
    id_ent              SERIAL PRIMARY KEY,  
    end_cli_ent         SERIAL
);

CREATE TABLE clientes (
    cpf_cli                     CHAR(11)  PRIMARY KEY,
    nome_cli                    VARCHAR(40),
    idade_cli                   INTEGER,
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
ALTER TABLE farmacias ADD CONSTRAINT cpf_gerente        FOREIGN KEY  (cpf_gerente_farm)      REFERENCES funcionarios(cpf_func) ;
ALTER TABLE farmacias ADD CONSTRAINT cpf_cliente        FOREIGN KEY  (cpf_clientes_farm)     REFERENCES clientes(cpf_cli) ;
ALTER TABLE farmacias ADD CONSTRAINT tiposDeFarmacia    CHECK        (tipo_farmacia IN ('sede', 'filial'));    

--funcionarios
ALTER TABLE funcionarios ADD CONSTRAINT cnpj_farm       FOREIGN KEY  (cnpj_farm_func)   REFERENCES farmacias(cnpj);
ALTER TABLE funcionarios ADD CONSTRAINT func_fez_venda  FOREIGN KEY  (vendas_func)      REFERENCES vendas(id_venda);
ALTER TABLE funcionarios ADD CONSTRAINT naoDemite       CHECK        (vendas_func != NULL);
ALTER TABLE funcionarios ADD CONSTRAINT tiposDeCargo    CHECK        (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL));
ALTER TABLE funcionarios ADD CONSTRAINT func_vendedor   CHECK        (vendas_func > 0 AND cargo_func IN ('vendedor'));

--medicamentos
ALTER TABLE medicamentos ADD CONSTRAINT medicamento_vendido              FOREIGN KEY  (vendidos_med) REFERENCES vendas(id_venda);
ALTER TABLE medicamentos ADD CONSTRAINT naoExcluiMed                     CHECK        (vendidos_med != NULL);
ALTER TABLE medicamentos ADD CONSTRAINT medicamento_com_receita_vendido  CHECK        (venda_com_receita_med = TRUE);

--clientes
ALTER TABLE clientes ADD CONSTRAINT endereco_cliente      FOREIGN KEY  (end_cliente_cli)            REFERENCES  enderecos_clientes(id_end);
ALTER TABLE clientes ADD CONSTRAINT farmacias_associadas  FOREIGN KEY  (farmacias_associadas_cli)   REFERENCES  farmacias(cnpj);
ALTER TABLE clientes ADD CONSTRAINT cliente_maior_18      CHECK        (idade_cli >= 18);

--clientes_enderecos
ALTER TABLE enderecos_clientes ADD CONSTRAINT cpf_cliente FOREIGN KEY (cpf_cli_end) REFERENCES clientes(cpf_cli);
ALTER TABLE enderecos_clientes ADD CONSTRAINT tiposDeEnderecos  CHECK (tipo_end IN ('residencia', 'trabalho', 'outro'));

--entregas
ALTER TABLE entregas ADD CONSTRAINT end_cli_entrega  FOREIGN KEY   (end_cli_ent)    REFERENCES enderecos_clientes(id_end);
ALTER TABLE entregas ADD CONSTRAINT id_venda_entrega FOREIGN KEY   (id_ent)         REFERENCES vendas(id_venda);
