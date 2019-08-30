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
    vendas_func         VARCHAR(30)
);

CREATE TABLE medicamentos (
    id_med                  SERIAL PRIMARY KEY,
    nome_med                TEXT,
    vendidos_med            VARCHAR(30),     
    venda_com_receita_med   BOOLEAN
);

CREATE TABLE vendas (
    venda_realizada        VARCHAR(30) PRIMARY KEY default '',
    venda_para_cliente     BOOLEAN
);

CREATE TABLE entregas (
    id_ent              VARCHAR(30) PRIMARY KEY,  
    end_cli_ent         SERIAL
);

CREATE TABLE clientes (
    cpf_cli                     CHAR(11) PRIMARY KEY,
    nome_cli                    VARCHAR(40),
    idade_cli                   INTEGER,
    end_cliente_cli             SERIAL,
    farmacias_associadas_cli    CHAR(17) NOT NULL
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
ALTER TABLE farmacias ADD CONSTRAINT cpf_gerente        FOREIGN KEY  (cpf_gerente_farm)      REFERENCES funcionarios(cpf_func);
ALTER TABLE farmacias ADD CONSTRAINT cpf_cliente        FOREIGN KEY  (cpf_clientes_farm)     REFERENCES clientes(cpf_cli) ;
ALTER TABLE farmacias ADD CONSTRAINT tiposDeFarmacia    CHECK        (tipo_farmacia IN ('sede', 'filial'));    

--funcionarios
ALTER TABLE funcionarios ADD CONSTRAINT cnpj_farm       FOREIGN KEY  (cnpj_farm_func)   REFERENCES farmacias(cnpj);
ALTER TABLE funcionarios ADD CONSTRAINT func_fez_venda  FOREIGN KEY  (vendas_func)      REFERENCES vendas(venda_realizada);
ALTER TABLE funcionarios ADD CONSTRAINT naoDemite       CHECK        (vendas_func != '');
ALTER TABLE funcionarios ADD CONSTRAINT tiposDeCargo    CHECK        (cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador', NULL));
ALTER TABLE funcionarios ADD CONSTRAINT func_vendedor   CHECK        ((vendas_func = '' AND cargo_func IN ('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador',NULL))
                                                                  OR (vendas_func != '' AND cargo_func IN ('vendedor')));

--medicamentos
ALTER TABLE medicamentos ADD CONSTRAINT medicamento_vendido              FOREIGN KEY  (vendidos_med) REFERENCES vendas(venda_realizada);
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
ALTER TABLE entregas ADD CONSTRAINT id_venda_entrega FOREIGN KEY   (id_ent)         REFERENCES vendas(venda_realizada);


---- COMANDOS ADICIONAIS
--deve ser executado com sucesso 
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234561', 'sede'  , 'catole1', 'sedeL', 'campina grande', 'PB', null, null);

--deve dar erro (funcionario nao existe)
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234562', 'filial', 'catole2', 'sedeM', 'campina grande', 'PB', '12345678910', null);
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234562', 'filial', 'catole4', 'sedeM', 'campina grande', 'PB', '12345678911', '12345678912');

--deve ser executado com sucesso
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678913', '12345678901234561', 'CilasA', 'vendedor', TRUE, '');
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678914', '12345678901234561', 'CilasB', 'caixa', FALSE, null);
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234563', 'filial', 'catole4', 'sedeN', 'campina grande', 'PB', '12345678913', '12345678912');
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234564', 'filial', 'catole5', 'sedeO', 'campina grande', 'PB', '12345678914', '12345678915');

-- deve dar certo
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678912', 'Milena', 18, 0, '12345678901234561');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678915', 'Tejo'  , 18, 0, '12345678901234562');

--deve dar erro (clientes invalidos)
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234565', 'filial', 'catole6', 'sedeP', 'campina grande', 'PB', '12345678913', '12345678917');
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234566', 'filial', 'catole7', 'sedeQ', 'campina grande', 'PB', '12345678914', '12345678918');
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678917', 'Rafael' , 17, 0, '12345678901234565'); --idade
INSERT INTO clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678918', 'Tomaz'  , 18, 0, '12345678901234570'); --cnpj

--deve dar certo
INSERT INTO farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES('12345678901234566', 'sede', 'catole8', 'sedeR', 'campina grande', 'PB', '12345678914', '12345678918');
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678940', '12345678901234566', 'Cilas1', 'administrador', FALSO, 0);
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678941', '12345678901234566', 'Cilas2', 'farmaceutico', FALSO, 0);
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678942', '12345678901234566', 'Cilas3', 'entregador', FALSO, 0);
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678943', '12345678901234566', 'Cilas4', 'caixa', FALSO, 0);

--deve dar erro (funcionario invalido)
INSERT INTO funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678944', '12345678901234566', 'Cilas5', null, FALSO, 0);




