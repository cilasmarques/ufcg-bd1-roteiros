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
    func_eh_gerente     BOOLEAN,
    vendas_func         INTEGER 
);

CREATE TABLE medicamentos (
    id_med                  INTEGER PRIMARY KEY,
    nome_med                TEXT,
    vendidos_med            INTEGER,     
    venda_com_receita_med   BOOLEAN
);

CREATE TABLE clientes (
    cpf_cli                     CHAR(11) PRIMARY KEY,
    nome_cli                    VARCHAR(40),
    idade_cli                   INTEGER,
    end_cliente_cli             SERIAL,
    farmacias_associadas_cli    CHAR(17) NOT NULL
);

CREATE TABLE enderecos_clientes (
    id_end              INTEGER     PRIMARY KEY,
    cpf_cli_end         CHAR(11)    NOT NULL,
    rua_end             VARCHAR(40) NOT NULL,
    bairro_end          VARCHAR(20) NOT NULL,
    cep_end             BIGINT      NOT NULL,
    numero_end          INTEGER     NOT NULL,
    tipo_end            VARCHAR(20) NOT NULL
);

CREATE TABLE vendas (
    venda_realizada        INTEGER PRIMARY KEY,
    venda_para_cliente     BOOLEAN
);

CREATE TABLE entregas (
    id_ent              INTEGER PRIMARY KEY,  
    end_cli_ent         INTEGER
);


--farmacias
ALTER TABLE farmacias ADD CONSTRAINT cpf_gerente        FOREIGN KEY  (cpf_gerente_farm)      REFERENCES funcionarios(cpf_func);
ALTER TABLE farmacias ADD CONSTRAINT cpf_cliente        FOREIGN KEY  (cpf_clientes_farm)     REFERENCES clientes(cpf_cli) ;
ALTER TABLE farmacias ADD CONSTRAINT tiposDeFarmacia    CHECK        (tipo_farmacia IN ('sede', 'filial'));    

--funcionarios
ALTER TABLE funcionarios ADD CONSTRAINT cnpj_farm       FOREIGN KEY  (cnpj_farm_func)   REFERENCES farmacias(cnpj);
ALTER TABLE funcionarios ADD CONSTRAINT tiposDeCargo    CHECK        (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL));
ALTER TABLE funcionarios ADD CONSTRAINT func_vendedor   CHECK        ((vendas_func < 0 AND cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador',NULL))
                                                                  OR (vendas_func >= 0 AND cargo_func IN ('vendedor')));

--medicamentos
ALTER TABLE farmacias    ADD CONSTRAINT id_med_venda                    FOREIGN KEY   (id_med)      REFERENCES vendas(venda_para_cliente);
ALTER TABLE medicamentos ADD CONSTRAINT naoExcluiMed                     CHECK        (vendidos_med > 0);

--clientes
ALTER TABLE clientes ADD CONSTRAINT endereco_cliente      FOREIGN KEY  (end_cliente_cli)            REFERENCES  enderecos_clientes(id_end);
ALTER TABLE clientes ADD CONSTRAINT farmacias_associadas  FOREIGN KEY  (farmacias_associadas_cli)   REFERENCES  farmacias(cnpj);
ALTER TABLE clientes ADD CONSTRAINT cliente_maior_18      CHECK        (idade_cli >= 18);

--clientes_enderecos
ALTER TABLE enderecos_clientes ADD CONSTRAINT tiposDeEnderecos  CHECK (tipo_end IN ('residencia', 'trabalho', 'outro'));

--entregas
ALTER TABLE entregas ADD CONSTRAINT end_cli_entrega  FOREIGN KEY   (end_cli_ent)    REFERENCES enderecos_clientes(id_end);
ALTER TABLE entregas ADD CONSTRAINT id_venda_entrega FOREIGN KEY   (id_ent)         REFERENCES vendas(venda_realizada);


---- COMANDOS ADICIONAIS
--deve ser executado com sucesso 
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234561', 'sede'  , 'catole1', 'sedeL', 'campina grande', 'PB', null, null);

--deve dar erro 
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234562', 'filial', 'catole2', 'sedeM', 'campina grande', 'PB', '12345678910', null);
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234562', 'filial', 'catole4', 'sedeM', 'campina grande', 'PB', '12345678911', '12345678912');
INSERT INTO enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (0, '12345678912', 'rua', 'bairro', 58175000, 450, '');
INSERT INTO enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (0, '12345678913', 'rua', 'bairro', 58175000, 450, 'trabalho');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678912', 'Milena', 18, 0, '12345678901234561');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678915', 'Tejo'  , 18, 0, '12345678901234562');
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678913', '12345678901234561', 'CilasA', 'vendedor', TRUE, 0);
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678914', '12345678901234561', 'CilasB', 'caixa', FALSE, -1);
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234563', 'filial', 'catole4', 'sedeN', 'campina grande', 'PB', '12345678913', '12345678912');
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234564', 'filial', 'catole5', 'sedeO', 'campina grande', 'PB', '12345678914', '12345678915');

--deve dar certo
INSERT INTO enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (0, '12345678912', 'rua', 'bairro', 58175000, 450, 'residencia');
INSERT INTO enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (1, '12345678915', 'rua', 'bairro', 58175001, 470, 'trabalho');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678912', 'Milena', 18, 0, '12345678901234561');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678915', 'Tejo'  , 18, 0, '12345678901234561');
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678913', '12345678901234561', 'CilasA', 'vendedor', TRUE, 0);
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678914', '12345678901234561', 'CilasB', 'caixa', FALSE, -1);
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234563', 'filial', 'catole4', 'sedeN', 'campina grande', 'PB', '12345678913', '12345678912');
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234564', 'filial', 'catole5', 'sedeO', 'campina grande', 'PB', '12345678914', '12345678915');
INSERT INTO medicamentos (id_med, nome_med, vendidos_med, venda_com_receita_med) VALUES(1010, 'RIVOTRIL', 1, TRUE);
INSERT INTO medicamentos (id_med, nome_med, vendidos_med, venda_com_receita_med) VALUES(1012, 'RIVOTRI2', 0, FALSE);
INSERT INTO vendas (venda_realizada, venda_para_cliente) VALUES(1010, TRUE);
INSERT INTO vendas (venda_realizada, venda_para_cliente) VALUES(1012, FALSE);
INSERT INTO entregas (id_ent, end_cli_ent) VALUES(1012, 0);

--deve dar erro
INSERT INTO entregas (id_ent, end_cli_ent) VALUES(1010, 12);

