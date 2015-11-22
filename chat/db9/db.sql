--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2015-11-21 11:49:31 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 177 (class 3079 OID 11860)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2023 (class 0 OID 0)
-- Dependencies: 177
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 16447)
-- Name: chat; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE chat (
    id integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "user" integer NOT NULL,
    action boolean NOT NULL,
    content text NOT NULL
);


ALTER TABLE chat OWNER TO root;

--
-- TOC entry 172 (class 1259 OID 16445)
-- Name: chat_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_id_seq OWNER TO root;

--
-- TOC entry 2024 (class 0 OID 0)
-- Dependencies: 172
-- Name: chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE chat_id_seq OWNED BY chat.id;


--
-- TOC entry 176 (class 1259 OID 16482)
-- Name: parsed_chat; Type: MATERIALIZED VIEW; Schema: public; Owner: root; Tablespace: 
--

CREATE MATERIALIZED VIEW parsed_chat AS
 SELECT chat.id,
    chat."time",
    chat."user",
    chat.action,
    chat.content,
    to_tsvector(chat.content) AS parsed
   FROM chat
  WITH NO DATA;


ALTER TABLE parsed_chat OWNER TO root;

--
-- TOC entry 175 (class 1259 OID 16458)
-- Name: user; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    op boolean NOT NULL DEFAULT false,
    username text NOT NULL
);


ALTER TABLE "user" OWNER TO root;

--
-- TOC entry 174 (class 1259 OID 16456)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO root;

--
-- TOC entry 2025 (class 0 OID 0)
-- Dependencies: 174
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 1897 (class 2604 OID 16450)
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY chat ALTER COLUMN id SET DEFAULT nextval('chat_id_seq'::regclass);


--
-- TOC entry 1898 (class 2604 OID 16461)
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 1900 (class 2606 OID 16455)
-- Name: chat_pk; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_pk PRIMARY KEY (id);


--
-- TOC entry 1902 (class 2606 OID 16466)
-- Name: user_pk; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- TOC entry 1904 (class 2606 OID 16473)
-- Name: user_username_uq; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_uq UNIQUE (username);


--
-- TOC entry 1905 (class 2606 OID 16467)
-- Name: chat_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_user_fk FOREIGN KEY ("user") REFERENCES "user"(id);


--
-- TOC entry 2022 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-11-21 11:49:31 CET

--
-- PostgreSQL database dump complete
--

