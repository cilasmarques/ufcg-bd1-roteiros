--QUESTAO 1
CREATE TABLE tarefas (
    atributo1 BIGINT,
    atributo2 VARCHAR(200),
    atributo3 CHAR(11),
    atributo4 INTEGER ,
    atributo5 CHAR(1)
);

INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', '98765432322', 1, 'F');
INSERT INTO tarefas VALUES (null, null, null, null, null);
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', '98765432321', 0, 'FF');

--QUESTAO 2
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');
ALTER TABLE tarefas ALTER COLUMN atributo1 TYPE BIGINT;

--QUESTAO 3
INSERT INTO tarefas VALUES (2147483649, 'limpar portas entrada principal', '32323232955', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar portas janelas entrada principal', '32323232955', 32769, 'A');
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar', '32323232955', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232955', 32766, 'A');

ALTER TABLE tarefas ADD CONSTRAINT atributo4_valido CHECK (atributo4 < 32768);

--QUESTAO 4