----- QUESTAO 1 (criando tabela)
CREATE TABLE tarefas (
    atributo1 BIGINT,
    atributo2 VARCHAR(200),
    atributo3 CHAR(11),
    atributo4 INTEGER ,
    atributo5 CHAR(1)
);

-- QUESTAO 1 Testando inserts
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', '98765432322', 1, 'F');
INSERT INTO tarefas VALUES (null, null, null, null, null);
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', '98765432321', 0, 'FF');


----- QUESTAO 2 Testando insert
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- QUESTAO 2 Ajeitando tabela
ALTER TABLE tarefas ALTER COLUMN atributo1 TYPE BIGINT;


----- QUESTAO 3 Criando restrincoes
ALTER TABLE tarefas ADD CONSTRAINT atributo4_valido CHECK (atributo4 < 32768);

-- QUESTAO 3 Testando inserts
INSERT INTO tarefas VALUES (2147483649, 'limpar portas entrada principal', '32323232955', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar portas janelas entrada principal', '32323232955', 32769, 'A');
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar', '32323232955', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232955', 32766, 'R');


----- QUESTAO 4 Renomeando atributos
ALTER TABLE tarefas RENAME COLUMN atributo1 TO id; 
ALTER TABLE tarefas RENAME COLUMN atributo2 TO descricao; 
ALTER TABLE tarefas RENAME COLUMN atributo3 TO func_resp_cpf; 
ALTER TABLE tarefas RENAME COLUMN atributo4 TO prioridade; 
ALTER TABLE tarefas RENAME COLUMN atributo5 TO status; 

-- QUESTAO 4 Removendo valores null
DELETE FROM tarefas WHERE id            = null;
DELETE FROM tarefas WHERE descricao     = null;
DELETE FROM tarefas WHERE func_resp_cpf = null;
DELETE FROM tarefas WHERE prioridade    = null;
DELETE FROM tarefas WHERE status        = null;

-- QUESTAO 4 Setando atributos para not null
ALTER TABLE tarefas ALTER COLUMN id             SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao      SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf  SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade     SET NOT NULL;


----- QUESTAO 5 Adicionando restrincao
ALTER TABLE tarefas ADD CONSTRAINT id_Unique UNIQUE(id);

-- QUESTAO 5 Testando inserts
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '32323232911', 2, 'A');


----- QUESTAO 6
-- 6A) Adicionando restrincao
 ALTER TABLE tarefas ALTER COLUMN func_resp_cpf TYPE CHAR(11);

-- 6B) Atualizando status
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

-- 6B) Adicionando restrincao
ALTER TABLE tarefas ADD CONSTRAINT statusDom CHECK(status = 'P' OR status = 'E' OR status = 'C');


----- QUESTAO 7 Adicionando restincao
ALTER TABLE tarefas ADD CONSTRAINT prio_menor_6 CHECK (prioridade < 6);


----- QUESTAO 8 Criando tabela funcionario
CREATE TABLE funcionario(
    cpf             CHAR(11)        PRIMARY KEY,
    data_nasc       DATE            NOT NULL,
    nome            VARCHAR(50)     NOT NULL,
    funcao          VARCHAR(50)     NOT NULL,
    nivel           CHAR(1)         NOT NULL,
    superior_cpf    CHAR(11)
);

-- QUESTAO 8 Adicionando restrincoes
ALTER TABLE funcionario ADD CONSTRAINT limp_superior CHECK(funcao = 'SUP_LIMPEZA' OR (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL));
ALTER TABLE funcionario ADD CONSTRAINT tipoNivel     CHECK(nivel = 'J' OR nivel = 'P' OR nivel = 'S');

-- QUESTAO 8 Adicionando restrincoes
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);


----- QUESTAO 9 Inserts validos
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1980-05-07', 'Pedro da Silva1', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-05-07', 'Pedro da Silva2', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-05-07', 'Pedro da Silva3', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1980-05-07', 'Pedro da Silva4', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675901', '1980-05-07', 'Pedro da Silva5', 'SUP_LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675906', '1980-05-07', 'Pedro da Silva6', 'SUP_LIMPEZA', 'P', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675907', '1980-05-07', 'Pedro da Silva7', 'SUP_LIMPEZA', 'P', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675908', '1980-05-07', 'Pedro da Silva8', 'LIMPEZA', 'J', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675909', '1980-05-07', 'Pedro da Silva9', 'LIMPEZA', 'S', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675910', '1980-05-07', 'Pedro da Silva10', 'LIMPEZA', 'P', '12345678900');

-- QUESTAO 9 Inserts invalidos
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675901', null        , 'Pedro da Silva11', 'SUP_LIMPEZA' , 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675902', '1980-05-07', null              , 'SUP_LIMPEZA' , 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675903', '1980-05-07', 'Pedro da Silva13', null          , 'P', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675904', '1980-05-07', 'Pedro da Silva14', 'SUP_LIMPEZA' , null, null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675905', '1980-05-07', 'Pedro da Silva15', 'SUP_LIMPEZA' , 'S', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675905', '1980-05-07', 'Pedro da Silva16', 'SUP_LIMPEZA' , 'P', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675905', '1980-05-07', 'Pedro da Silva17', 'SUP_LIMPEZA' , 'J', '12345678900');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12945675908', '1980-05-07', 'Pedro da Silva18', 'LIMPEZA', 'J', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12945675909', '1980-05-07', 'Pedro da Silva19', 'LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12945675910', '1980-05-07', 'Pedro da Silva20', 'LIMPEZA', 'P', null);


----- QUESTAO 10 Adicionando restrincoes
ALTER TABLE tarefas ADD CONSTRAINT tarefas_func FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;
ALTER TABLE tarefas ADD CONSTRAINT tarefas_func2 FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;


----- QUESTAO 11 Adicionando resticoes
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;
ALTER TABLE tarefas ADD CONSTRAINT cpfNull CHECK(status = 'E' AND func_resp_cpf IS NULL);

-- QUESTAO 11 Alterando constrains da questao 10
ALTER TABLE tarefas DROP CONSTRAINT  tarefas_func;
ALTER TABLE tarefas DROP CONSTRAINT  tarefas_func2;
ALTER TABLE tarefas ADD  CONSTRAINT  tarefas_func FOREIGN KEY(func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;
ALTER TABLE tarefas ADD CONSTRAINT cpfNull CHECK(status = 'E' AND func_resp_cpf IS NULL);

-- QUESTAO 11 Removendo um funcionario com status 'E's
DELETE FROM tarefas WHERE status = 'E' ;
