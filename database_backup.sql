--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.cities OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO "Guest";

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.stops (
    id integer NOT NULL,
    "time" time without time zone NOT NULL,
    city_id integer NOT NULL,
    train_id integer NOT NULL
);


ALTER TABLE public.stops OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.stops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stops_id_seq OWNER TO "Guest";

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.stops_id_seq OWNED BY public.stops.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    stop_id integer NOT NULL
);


ALTER TABLE public.tickets OWNER TO "Guest";

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO "Guest";

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.trains (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.trains OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.trains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trains_id_seq OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.trains_id_seq OWNED BY public.trains.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.stops ALTER COLUMN id SET DEFAULT nextval('public.stops_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.trains ALTER COLUMN id SET DEFAULT nextval('public.trains_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.cities (id, name) FROM stdin;
38	Portland
39	Seattle
\.


--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.stops (id, "time", city_id, train_id) FROM stdin;
56	13:00:00	38	38
57	13:00:00	38	39
58	15:00:00	39	39
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.tickets (id, stop_id) FROM stdin;
\.


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.trains (id, name) FROM stdin;
38	Red line
39	Blue line
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.cities_id_seq', 39, true);


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.stops_id_seq', 58, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.tickets_id_seq', 1, false);


--
-- Name: trains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.trains_id_seq', 39, true);


--
-- Name: cities cities_pk; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pk PRIMARY KEY (id);


--
-- Name: stops stops_pk; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pk PRIMARY KEY (id);


--
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id);


--
-- Name: trains trains_pk; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trains_pk PRIMARY KEY (id);


--
-- Name: stops stops_fk0; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_fk0 FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: stops stops_fk1; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_fk1 FOREIGN KEY (train_id) REFERENCES public.trains(id);


--
-- Name: tickets tickets_fk0; Type: FK CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_fk0 FOREIGN KEY (stop_id) REFERENCES public.stops(id);


--
-- PostgreSQL database dump complete
--

