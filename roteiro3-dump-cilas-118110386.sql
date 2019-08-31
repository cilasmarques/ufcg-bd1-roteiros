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

ALTER TABLE ONLY public.entregas DROP CONSTRAINT id_venda_entrega;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT farmacias_associadas;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT endereco_cliente;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT end_cli_entrega;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT cpf_gerente;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT cpf_cliente;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT cnpj_farm;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_sede_key;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_bairro_key;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_pkey;
ALTER TABLE ONLY public.enderecos_clientes DROP CONSTRAINT enderecos_clientes_pkey;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
ALTER TABLE public.clientes ALTER COLUMN end_cliente_cli DROP DEFAULT;
DROP TABLE public.vendas;
DROP TABLE public.medicamentos;
DROP TABLE public.funcionarios;
DROP TABLE public.farmacias;
DROP TABLE public.entregas;
DROP TABLE public.enderecos_clientes;
DROP SEQUENCE public.clientes_end_cliente_cli_seq;
DROP TABLE public.clientes;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.clientes (
    cpf_cli character(11) NOT NULL,
    nome_cli character varying(40),
    idade_cli integer,
    end_cliente_cli integer NOT NULL,
    farmacias_associadas_cli character(17) NOT NULL,
    CONSTRAINT cliente_maior_18 CHECK ((idade_cli >= 18))
);


ALTER TABLE public.clientes OWNER TO cilas;

--
-- Name: clientes_end_cliente_cli_seq; Type: SEQUENCE; Schema: public; Owner: cilas
--

CREATE SEQUENCE public.clientes_end_cliente_cli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientes_end_cliente_cli_seq OWNER TO cilas;

--
-- Name: clientes_end_cliente_cli_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cilas
--

ALTER SEQUENCE public.clientes_end_cliente_cli_seq OWNED BY public.clientes.end_cliente_cli;


--
-- Name: enderecos_clientes; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.enderecos_clientes (
    id_end integer NOT NULL,
    cpf_cli_end character(11) NOT NULL,
    rua_end character varying(40) NOT NULL,
    bairro_end character varying(20) NOT NULL,
    cep_end bigint NOT NULL,
    numero_end integer NOT NULL,
    tipo_end character varying(20) NOT NULL,
    CONSTRAINT tiposdeenderecos CHECK (((tipo_end)::text = ANY ((ARRAY['residencia'::character varying, 'trabalho'::character varying, 'outro'::character varying])::text[])))
);


ALTER TABLE public.enderecos_clientes OWNER TO cilas;

--
-- Name: entregas; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.entregas (
    id_ent integer NOT NULL,
    end_cli_ent integer
);


ALTER TABLE public.entregas OWNER TO cilas;

--
-- Name: farmacias; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.farmacias (
    cnpj character(17) NOT NULL,
    tipo_farmacia character varying(40) NOT NULL,
    bairro character varying(40) NOT NULL,
    sede character varying(40),
    cidade character varying(40) NOT NULL,
    estado character(2) NOT NULL,
    cpf_gerente_farm character(11),
    cpf_clientes_farm character(11),
    CONSTRAINT tiposdefarmacia CHECK (((tipo_farmacia)::text = ANY ((ARRAY['sede'::character varying, 'filial'::character varying])::text[])))
);


ALTER TABLE public.farmacias OWNER TO cilas;

--
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.funcionarios (
    cpf_func character(11) NOT NULL,
    cnpj_farm_func character(17),
    nome_func character varying(40) NOT NULL,
    cargo_func character(11),
    func_eh_gerente boolean,
    vendas_func integer,
    CONSTRAINT func_vendedor CHECK ((((vendas_func < 0) AND (cargo_func = ANY (ARRAY['farmaceutico'::bpchar, 'vendedor'::bpchar, 'entregador'::bpchar, 'caixa'::bpchar, 'administrador'::bpchar, NULL::bpchar]))) OR ((vendas_func >= 0) AND (cargo_func = 'vendedor'::bpchar)))),
    CONSTRAINT tiposdecargo CHECK ((cargo_func = ANY (ARRAY['farmaceutico'::bpchar, 'vendedor'::bpchar, 'entregador'::bpchar, 'caixa'::bpchar, 'administrador'::bpchar, NULL::bpchar])))
);


ALTER TABLE public.funcionarios OWNER TO cilas;

--
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.medicamentos (
    id_med integer NOT NULL,
    nome_med text,
    vendidos_med integer,
    venda_com_receita_med boolean,
    CONSTRAINT naoexcluimed CHECK ((vendidos_med > 0))
);


ALTER TABLE public.medicamentos OWNER TO cilas;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: cilas
--

CREATE TABLE public.vendas (
    venda_realizada integer NOT NULL,
    venda_para_cliente boolean
);


ALTER TABLE public.vendas OWNER TO cilas;

--
-- Name: end_cliente_cli; Type: DEFAULT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.clientes ALTER COLUMN end_cliente_cli SET DEFAULT nextval('public.clientes_end_cliente_cli_seq'::regclass);


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678912', 'Milena', 18, 0, '12345678901234561');
INSERT INTO public.clientes (cpf_cli, nome_cli, idade_cli, end_cliente_cli, farmacias_associadas_cli) VALUES ('12345678915', 'Tejo', 18, 0, '12345678901234561');


--
-- Name: clientes_end_cliente_cli_seq; Type: SEQUENCE SET; Schema: public; Owner: cilas
--

SELECT pg_catalog.setval('public.clientes_end_cliente_cli_seq', 1, false);


--
-- Data for Name: enderecos_clientes; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (0, '12345678913', 'rua', 'bairro', 58175000, 450, 'trabalho');
INSERT INTO public.enderecos_clientes (id_end, cpf_cli_end, rua_end, bairro_end, cep_end, numero_end, tipo_end) VALUES (1, '12345678915', 'rua', 'bairro', 58175001, 470, 'trabalho');


--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.entregas (id_ent, end_cli_ent) VALUES (1012, 0);


--
-- Data for Name: farmacias; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES ('12345678901234561', 'sede', 'catole1', 'sedeL', 'campina grande', 'PB', NULL, NULL);
INSERT INTO public.farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES ('12345678901234563', 'filial', 'catole4', 'sedeN', 'campina grande', 'PB', '12345678913', '12345678912');
INSERT INTO public.farmacias (cnpj, tipo_farmacia, bairro, sede, cidade, estado, cpf_gerente_farm, cpf_clientes_farm) VALUES ('12345678901234564', 'filial', 'catole5', 'sedeO', 'campina grande', 'PB', '12345678914', '12345678915');


--
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678913', '12345678901234561', 'CilasA', 'vendedor   ', true, 0);
INSERT INTO public.funcionarios (cpf_func, cnpj_farm_func, nome_func, cargo_func, func_eh_gerente, vendas_func) VALUES ('12345678914', '12345678901234561', 'CilasB', 'caixa      ', false, -1);


--
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.medicamentos (id_med, nome_med, vendidos_med, venda_com_receita_med) VALUES (1010, 'RIVOTRIL', 1, true);


--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: cilas
--

INSERT INTO public.vendas (venda_realizada, venda_para_cliente) VALUES (1010, true);
INSERT INTO public.vendas (venda_realizada, venda_para_cliente) VALUES (1012, false);


--
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cpf_cli);


--
-- Name: enderecos_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.enderecos_clientes
    ADD CONSTRAINT enderecos_clientes_pkey PRIMARY KEY (id_end);


--
-- Name: entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_pkey PRIMARY KEY (id_ent);


--
-- Name: farmacias_bairro_key; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_bairro_key UNIQUE (bairro);


--
-- Name: farmacias_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_pkey PRIMARY KEY (cnpj);


--
-- Name: farmacias_sede_key; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_sede_key UNIQUE (sede);


--
-- Name: funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf_func);


--
-- Name: medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id_med);


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (venda_realizada);


--
-- Name: cnpj_farm; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT cnpj_farm FOREIGN KEY (cnpj_farm_func) REFERENCES public.farmacias(cnpj);


--
-- Name: cpf_cliente; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT cpf_cliente FOREIGN KEY (cpf_clientes_farm) REFERENCES public.clientes(cpf_cli);


--
-- Name: cpf_gerente; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT cpf_gerente FOREIGN KEY (cpf_gerente_farm) REFERENCES public.funcionarios(cpf_func);


--
-- Name: end_cli_entrega; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT end_cli_entrega FOREIGN KEY (end_cli_ent) REFERENCES public.enderecos_clientes(id_end);


--
-- Name: endereco_cliente; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT endereco_cliente FOREIGN KEY (end_cliente_cli) REFERENCES public.enderecos_clientes(id_end);


--
-- Name: farmacias_associadas; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT farmacias_associadas FOREIGN KEY (farmacias_associadas_cli) REFERENCES public.farmacias(cnpj);


--
-- Name: id_venda_entrega; Type: FK CONSTRAINT; Schema: public; Owner: cilas
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT id_venda_entrega FOREIGN KEY (id_ent) REFERENCES public.vendas(venda_realizada);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

