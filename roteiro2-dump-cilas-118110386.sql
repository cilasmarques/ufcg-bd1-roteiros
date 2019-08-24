--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_func3;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT id_unique;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(50) NOT NULL,
    funcao character varying(50) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT limp_superior CHECK ((((funcao)::text = 'SUP_LIMPEZA'::text) OR (((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)))),
    CONSTRAINT tiponivel CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO cilas;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.tarefas (
    id bigint,
    descricao character varying(200),
    func_resp_cpf character(11),
    prioridade integer,
    status character(1),
    CONSTRAINT atributo4_valido CHECK ((prioridade < 32768)),
    CONSTRAINT statusdom CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO cilas;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1980-05-07', 'Pedro da Silva1', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-05-07', 'Pedro da Silva2', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-05-07', 'Pedro da Silva3', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1980-05-07', 'Pedro da Silva4', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675901', '1980-05-07', 'Pedro da Silva5', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675906', '1980-05-07', 'Pedro da Silva6', 'SUP_LIMPEZA', 'P', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675907', '1980-05-07', 'Pedro da Silva7', 'SUP_LIMPEZA', 'P', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675908', '1980-05-07', 'Pedro da Silva8', 'LIMPEZA', 'J', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675909', '1980-05-07', 'Pedro da Silva9', 'LIMPEZA', 'S', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675910', '1980-05-07', 'Pedro da Silva10', 'LIMPEZA', 'P', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345675905', '1980-05-07', 'Pedro da Silva15', 'SUP_LIMPEZA', 'S', '12345678900');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432322', '1980-05-07', 'Pedro da Silva10', 'LIMPEZA', 'P', '12345678900');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232955', 32767, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483644, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432322', 1, 'C');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: id_unique; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT id_unique UNIQUE (id);


--
-- Name: tarefas_func3; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_func3 FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

