--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    upcategory_id integer,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('categories_id_seq', 24, true);


--
-- Name: charges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE charges (
    toto integer
);


--
-- Name: facdivs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE facdivs (
    id integer NOT NULL,
    facture_id integer NOT NULL,
    saison_id integer NOT NULL,
    category_id integer,
    star integer,
    adu integer,
    user_id integer,
    name character varying(255),
    cout double precision,
    ref_client character varying(255),
    ref integer,
    date date,
    "desc" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: facdivs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE facdivs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facdivs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE facdivs_id_seq OWNED BY facdivs.id;


--
-- Name: facdivs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('facdivs_id_seq', 1, false);


--
-- Name: factcats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE factcats (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: factcats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factcats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factcats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factcats_id_seq OWNED BY factcats.id;


--
-- Name: factcats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factcats_id_seq', 3, true);


--
-- Name: factoparcelles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE factoparcelles (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer,
    facture_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: factoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factoparcelles_id_seq OWNED BY factoparcelles.id;


--
-- Name: factoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factoparcelles_id_seq', 1, false);


--
-- Name: factures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE factures (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    category_id integer,
    factcat_id integer,
    factype_id integer,
    reportable_id integer,
    type character varying(255) NOT NULL,
    star integer,
    adu integer,
    date date,
    user_id integer,
    name character varying(255),
    cout double precision,
    ref_client character varying(255),
    ref integer,
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: factures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factures_id_seq OWNED BY factures.id;


--
-- Name: factures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factures_id_seq', 2, true);


--
-- Name: factypes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE factypes (
    id integer NOT NULL,
    name character varying(255),
    display character varying(255),
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: factypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factypes_id_seq OWNED BY factypes.id;


--
-- Name: factypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factypes_id_seq', 3, true);


--
-- Name: labours; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE labours (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    category_id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    name character varying(255) NOT NULL,
    cout_ha_passage double precision,
    "desc" text,
    star smallint,
    adu smallint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: labours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labours_id_seq OWNED BY labours.id;


--
-- Name: labours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labours_id_seq', 16, true);


--
-- Name: labtofactures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE labtofactures (
    id integer NOT NULL,
    saison_id integer,
    facture_id integer,
    labour_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: labtofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labtofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labtofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labtofactures_id_seq OWNED BY labtofactures.id;


--
-- Name: labtofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labtofactures_id_seq', 1, false);


--
-- Name: labtoparcelles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE labtoparcelles (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer,
    labour_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: labtoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labtoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labtoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labtoparcelles_id_seq OWNED BY labtoparcelles.id;


--
-- Name: labtoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labtoparcelles_id_seq', 18, true);


--
-- Name: myusers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE myusers (
    id integer NOT NULL,
    login character varying(255),
    password character varying(255),
    admin smallint
);


--
-- Name: myusers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE myusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: myusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE myusers_id_seq OWNED BY myusers.id;


--
-- Name: myusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('myusers_id_seq', 4, true);


--
-- Name: parcelles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parcelles (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    typeculture_id integer NOT NULL,
    name character varying(255) NOT NULL,
    surface double precision,
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: parcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parcelles_id_seq OWNED BY parcelles.id;


--
-- Name: parcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('parcelles_id_seq', 23, true);


--
-- Name: produits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE produits (
    id integer NOT NULL,
    category_id integer NOT NULL,
    saison_id integer NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    unit character varying(255),
    star integer,
    adu integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE produits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE produits_id_seq OWNED BY produits.id;


--
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('produits_id_seq', 81, true);


--
-- Name: protofactures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE protofactures (
    id integer NOT NULL,
    saison_id integer,
    produit_id integer,
    facture_id integer,
    prix double precision,
    quantite double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: protofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE protofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: protofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE protofactures_id_seq OWNED BY protofactures.id;


--
-- Name: protofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('protofactures_id_seq', 35, true);


--
-- Name: pulves; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pulves (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    name character varying(255) NOT NULL,
    cout_ha_passage double precision,
    star integer,
    adu integer,
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pulves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pulves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pulves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pulves_id_seq OWNED BY pulves.id;


--
-- Name: pulves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pulves_id_seq', 149, true);


--
-- Name: putofactures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE putofactures (
    id integer NOT NULL,
    saison_id integer,
    facture_id integer NOT NULL,
    pulve_id integer NOT NULL,
    value double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: putofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: putofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putofactures_id_seq OWNED BY putofactures.id;


--
-- Name: putofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putofactures_id_seq', 1, false);


--
-- Name: putoparcelles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE putoparcelles (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    parcelle_id integer NOT NULL,
    pulve_id integer NOT NULL,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: putoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: putoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putoparcelles_id_seq OWNED BY putoparcelles.id;


--
-- Name: putoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putoparcelles_id_seq', 184, true);


--
-- Name: putoproduits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE putoproduits (
    id integer NOT NULL,
    saison_id integer,
    pulve_id integer,
    produit_id integer,
    dosage double precision,
    dosage_vrai double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: putoproduits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putoproduits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: putoproduits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putoproduits_id_seq OWNED BY putoproduits.id;


--
-- Name: putoproduits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putoproduits_id_seq', 184, true);


--
-- Name: saisons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE saisons (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    year character varying(255),
    "desc" text
);


--
-- Name: saisons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE saisons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: saisons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE saisons_id_seq OWNED BY saisons.id;


--
-- Name: saisons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('saisons_id_seq', 2, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE settings (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    value_parcelle smallint,
    detail_desc smallint,
    detail_ref smallint,
    float_precision integer,
    text_area_size character varying(255)
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('settings_id_seq', 1, true);


--
-- Name: typecultures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE typecultures (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: typecultures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE typecultures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: typecultures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE typecultures_id_seq OWNED BY typecultures.id;


--
-- Name: typecultures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('typecultures_id_seq', 6, true);


--
-- Name: upcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE upcategories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: upcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE upcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE upcategories_id_seq OWNED BY upcategories.id;


--
-- Name: upcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('upcategories_id_seq', 4, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 32, true);


--
-- Name: ventes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ventes (
    id integer NOT NULL,
    category_id integer NOT NULL,
    saison_id integer NOT NULL,
    prix double precision NOT NULL,
    date date NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    ref integer,
    ref_client character varying(255),
    star integer,
    adu integer,
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: ventes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ventes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ventes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ventes_id_seq OWNED BY ventes.id;


--
-- Name: ventes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ventes_id_seq', 1, false);


--
-- Name: ventoparcelles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ventoparcelles (
    id integer NOT NULL,
    saison_id integer,
    vente_id integer NOT NULL,
    parcelle_id integer NOT NULL,
    value double precision NOT NULL
);


--
-- Name: ventoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ventoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ventoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ventoparcelles_id_seq OWNED BY ventoparcelles.id;


--
-- Name: ventoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ventoparcelles_id_seq', 1, false);


--
-- Name: verifs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE verifs (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: verifs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE verifs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: verifs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE verifs_id_seq OWNED BY verifs.id;


--
-- Name: verifs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('verifs_id_seq', 1, false);


--
-- Name: zones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE zones (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    surface double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE zones_id_seq OWNED BY zones.id;


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('zones_id_seq', 17, true);


--
-- Name: zonetopas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE zonetopas (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer NOT NULL,
    zone_id integer NOT NULL,
    value double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: zonetopas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE zonetopas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zonetopas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE zonetopas_id_seq OWNED BY zonetopas.id;


--
-- Name: zonetopas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('zonetopas_id_seq', 24, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE facdivs ALTER COLUMN id SET DEFAULT nextval('facdivs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factcats ALTER COLUMN id SET DEFAULT nextval('factcats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factoparcelles ALTER COLUMN id SET DEFAULT nextval('factoparcelles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factures ALTER COLUMN id SET DEFAULT nextval('factures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factypes ALTER COLUMN id SET DEFAULT nextval('factypes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labours ALTER COLUMN id SET DEFAULT nextval('labours_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labtofactures ALTER COLUMN id SET DEFAULT nextval('labtofactures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labtoparcelles ALTER COLUMN id SET DEFAULT nextval('labtoparcelles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE myusers ALTER COLUMN id SET DEFAULT nextval('myusers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE parcelles ALTER COLUMN id SET DEFAULT nextval('parcelles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE produits ALTER COLUMN id SET DEFAULT nextval('produits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE protofactures ALTER COLUMN id SET DEFAULT nextval('protofactures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE pulves ALTER COLUMN id SET DEFAULT nextval('pulves_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putofactures ALTER COLUMN id SET DEFAULT nextval('putofactures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putoparcelles ALTER COLUMN id SET DEFAULT nextval('putoparcelles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putoproduits ALTER COLUMN id SET DEFAULT nextval('putoproduits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE saisons ALTER COLUMN id SET DEFAULT nextval('saisons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE typecultures ALTER COLUMN id SET DEFAULT nextval('typecultures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE upcategories ALTER COLUMN id SET DEFAULT nextval('upcategories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ventes ALTER COLUMN id SET DEFAULT nextval('ventes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ventoparcelles ALTER COLUMN id SET DEFAULT nextval('ventoparcelles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE verifs ALTER COLUMN id SET DEFAULT nextval('verifs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE zones ALTER COLUMN id SET DEFAULT nextval('zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE zonetopas ALTER COLUMN id SET DEFAULT nextval('zonetopas_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY categories (id, upcategory_id, name, created_at, updated_at) FROM stdin;
1	1	frais generaux	2011-08-30 17:25:22.785632	2011-08-30 17:25:22.785632
2	1	produits phyto	2011-08-30 17:25:22.790844	2011-08-30 17:25:22.790844
3	1	semences	2011-08-30 17:25:22.793152	2011-08-30 17:25:22.793152
4	1	mecanique	2011-08-30 17:25:22.79532	2011-08-30 17:25:22.79532
5	1	batiments	2011-08-30 17:25:22.797436	2011-08-30 17:25:22.797436
6	1	deplacement	2011-08-30 17:25:22.799965	2011-08-30 17:25:22.799965
7	1	frais de gestion	2011-08-30 17:25:22.802661	2011-08-30 17:25:22.802661
8	2	divers	2011-08-30 17:25:22.804991	2011-08-30 17:25:22.804991
9	2	azote	2011-08-30 17:25:22.807885	2011-08-30 17:25:22.807885
10	2	desherbant	2011-08-30 17:25:22.810125	2011-08-30 17:25:22.810125
11	2	engrais	2011-08-30 17:25:22.812884	2011-08-30 17:25:22.812884
12	2	fongicide	2011-08-30 17:25:22.815736	2011-08-30 17:25:22.815736
13	2	herbicide	2011-08-30 17:25:22.818306	2011-08-30 17:25:22.818306
14	2	insecticide	2011-08-30 17:25:22.821466	2011-08-30 17:25:22.821466
15	2	oligo	2011-08-30 17:25:22.824241	2011-08-30 17:25:22.824241
16	2	semis	2011-08-30 17:25:22.826631	2011-08-30 17:25:22.826631
17	2	soufre	2011-08-30 17:25:22.82887	2011-08-30 17:25:22.82887
18	3	moisson	2011-08-30 17:25:22.831083	2011-08-30 17:25:22.831083
19	3	covercrop	2011-08-30 17:25:22.833298	2011-08-30 17:25:22.833298
20	3	vibro	2011-08-30 17:25:22.835545	2011-08-30 17:25:22.835545
21	3	herse	2011-08-30 17:25:22.837814	2011-08-30 17:25:22.837814
22	4	foin	2011-08-30 17:25:22.840055	2011-08-30 17:25:22.840055
23	4	PAC	2011-08-30 17:25:22.842424	2011-08-30 17:25:22.842424
24	4	Avoir	2011-08-30 17:25:22.844687	2011-08-30 17:25:22.844687
\.


--
-- Data for Name: charges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY charges (toto) FROM stdin;
\.


--
-- Data for Name: facdivs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY facdivs (id, facture_id, saison_id, category_id, star, adu, user_id, name, cout, ref_client, ref, date, "desc", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: factcats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factcats (id, name, "desc", created_at, updated_at) FROM stdin;
1	agri	\N	2011-08-30 17:25:22.851491	2011-08-30 17:25:22.851491
2	maison	\N	2011-08-30 17:25:22.856582	2011-08-30 17:25:22.856582
3	invest	\N	2011-08-30 17:25:22.859289	2011-08-30 17:25:22.859289
\.


--
-- Data for Name: factoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factoparcelles (id, saison_id, parcelle_id, facture_id, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: factures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factures (id, saison_id, category_id, factcat_id, factype_id, reportable_id, type, star, adu, date, user_id, name, cout, ref_client, ref, "desc", created_at, updated_at) FROM stdin;
1	1	6	1	1	\N	Debit	\N	\N	2011-01-01	1	FIXTURE	1000	\N	\N	from seeds	2011-08-30 17:25:27.062499	2011-08-30 17:25:27.062499
2	2	2	1	1	\N	Debit	\N	\N	2011-01-01	1	Achat Phyto	10000	\N	\N	FAKE TO AVOID NIL	2011-08-30 17:25:43.995705	2011-08-30 17:25:43.995705
\.


--
-- Data for Name: factypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factypes (id, name, display, "desc", created_at, updated_at) FROM stdin;
1	diff	diff	test desc	2011-08-30 17:25:22.949849	2011-08-30 17:25:22.949849
2	total	total	test desc	2011-08-30 17:25:22.954992	2011-08-30 17:25:22.954992
3	null	null	test desc	2011-08-30 17:25:22.957406	2011-08-30 17:25:22.957406
\.


--
-- Data for Name: labours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labours (id, saison_id, category_id, user_id, date, name, cout_ha_passage, "desc", star, adu, created_at, updated_at) FROM stdin;
1	1	19	1	2011-01-01	FIXTURE	10	from seeds	\N	\N	2011-08-30 17:25:27.146705	2011-08-30 17:25:27.146705
2	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:27.450576	2011-08-30 17:25:27.450576
3	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:27.520627	2011-08-30 17:25:27.520627
4	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:27.718449	2011-08-30 17:25:27.718449
5	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:27.936743	2011-08-30 17:25:27.936743
6	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:28.127511	2011-08-30 17:25:28.127511
7	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:28.252832	2011-08-30 17:25:28.252832
8	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:28.440821	2011-08-30 17:25:28.440821
9	1	18	2	2009-01-01	moisson	10		\N	\N	2011-08-30 17:25:28.550332	2011-08-30 17:25:28.550332
10	2	18	2	2009-07-24	moisson	10		\N	\N	2011-08-30 17:25:42.603465	2011-08-30 17:25:42.603465
11	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:42.695057	2011-08-30 17:25:42.695057
12	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:42.934113	2011-08-30 17:25:42.934113
13	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:43.153941	2011-08-30 17:25:43.153941
14	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:43.238983	2011-08-30 17:25:43.238983
15	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:43.43484	2011-08-30 17:25:43.43484
16	2	18	2	2009-07-25	moisson	10		\N	\N	2011-08-30 17:25:43.60091	2011-08-30 17:25:43.60091
\.


--
-- Data for Name: labtofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtofactures (id, saison_id, facture_id, labour_id, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: labtoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtoparcelles (id, saison_id, parcelle_id, labour_id, value, created_at, updated_at) FROM stdin;
1	1	11	2	0	2011-08-30 17:25:27.480738	2011-08-30 17:25:27.480738
2	1	9	3	0	2011-08-30 17:25:27.535975	2011-08-30 17:25:27.535975
3	1	10	4	0	2011-08-30 17:25:27.757496	2011-08-30 17:25:27.757496
4	1	8	5	0	2011-08-30 17:25:27.973196	2011-08-30 17:25:27.973196
5	1	6	6	0	2011-08-30 17:25:28.160489	2011-08-30 17:25:28.160489
6	1	7	7	0	2011-08-30 17:25:28.282209	2011-08-30 17:25:28.282209
7	1	2	8	0	2011-08-30 17:25:28.470045	2011-08-30 17:25:28.470045
8	1	1	9	0	2011-08-30 17:25:28.646338	2011-08-30 17:25:28.646338
9	2	13	10	0	2011-08-30 17:25:42.685588	2011-08-30 17:25:42.685588
10	2	12	10	0	2011-08-30 17:25:42.690469	2011-08-30 17:25:42.690469
11	2	14	11	0	2011-08-30 17:25:42.926491	2011-08-30 17:25:42.926491
12	2	16	11	0	2011-08-30 17:25:42.929554	2011-08-30 17:25:42.929554
13	2	19	12	0	2011-08-30 17:25:43.146791	2011-08-30 17:25:43.146791
14	2	20	12	0	2011-08-30 17:25:43.149169	2011-08-30 17:25:43.149169
15	2	23	13	0	2011-08-30 17:25:43.234559	2011-08-30 17:25:43.234559
16	2	22	14	0	2011-08-30 17:25:43.430362	2011-08-30 17:25:43.430362
17	2	21	15	0	2011-08-30 17:25:43.596285	2011-08-30 17:25:43.596285
18	2	18	16	0	2011-08-30 17:25:43.661726	2011-08-30 17:25:43.661726
\.


--
-- Data for Name: myusers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY myusers (id, login, password, admin) FROM stdin;
1	admin	admin	1
2	matthieu		0
3	elisabeth	elisabeth	0
4	thierry	thierry	0
\.


--
-- Data for Name: parcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY parcelles (id, saison_id, typeculture_id, name, surface, "desc", created_at, updated_at) FROM stdin;
1	1	1	Bruneau	14	\N	2011-08-30 17:25:26.939471	2011-08-30 17:25:26.939471
2	1	1	Mitant	5	\N	2011-08-30 17:25:26.958738	2011-08-30 17:25:26.958738
3	1	5	Feuillets 1	5	\N	2011-08-30 17:25:26.965902	2011-08-30 17:25:26.965902
4	1	5	Feuillets 2	4	\N	2011-08-30 17:25:26.972429	2011-08-30 17:25:26.972429
5	1	5	Feuillets 3	7	\N	2011-08-30 17:25:26.978645	2011-08-30 17:25:26.978645
6	1	1	Pont des champs	10	\N	2011-08-30 17:25:26.985634	2011-08-30 17:25:26.985634
7	1	1	Aeromodelisme	14	\N	2011-08-30 17:25:26.991885	2011-08-30 17:25:26.991885
8	1	4	Derierre	14	\N	2011-08-30 17:25:26.998094	2011-08-30 17:25:26.998094
9	1	3	Champ du Milieu	9	\N	2011-08-30 17:25:27.004538	2011-08-30 17:25:27.004538
10	1	4	Basse-cour	2	\N	2011-08-30 17:25:27.011991	2011-08-30 17:25:27.011991
11	1	3	Vallees	11	\N	2011-08-30 17:25:27.019329	2011-08-30 17:25:27.019329
12	2	4	Bruneau	14	\N	2011-08-30 17:25:42.041905	2011-08-30 17:25:42.041905
13	2	4	Mitant	5	\N	2011-08-30 17:25:42.117313	2011-08-30 17:25:42.117313
14	2	4	Feuillets 1	5	\N	2011-08-30 17:25:42.124631	2011-08-30 17:25:42.124631
15	2	5	Feuillets 2	4	\N	2011-08-30 17:25:42.130901	2011-08-30 17:25:42.130901
16	2	4	Feuillets 3	7	\N	2011-08-30 17:25:42.137261	2011-08-30 17:25:42.137261
17	2	6	Pont des champs	10	\N	2011-08-30 17:25:42.144031	2011-08-30 17:25:42.144031
18	2	3	Aeromodelisme	13.5500000000000007	\N	2011-08-30 17:25:42.15031	2011-08-30 17:25:42.15031
19	2	1	Derierre maison	14	\N	2011-08-30 17:25:42.15686	2011-08-30 17:25:42.15686
20	2	1	Champ du Milieu	9	\N	2011-08-30 17:25:42.162938	2011-08-30 17:25:42.162938
21	2	1	Basse-cour	2	\N	2011-08-30 17:25:42.170237	2011-08-30 17:25:42.170237
22	2	1	Vallees	13	\N	2011-08-30 17:25:42.178417	2011-08-30 17:25:42.178417
23	2	1	Guiberons	2.5	\N	2011-08-30 17:25:42.188148	2011-08-30 17:25:42.188148
\.


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY produits (id, category_id, saison_id, name, "desc", unit, star, adu, created_at, updated_at) FROM stdin;
1	8	1	Altigo		L	\N	\N	2011-08-30 17:25:27.179734	2011-08-30 17:25:27.179734
2	12	1	Anistar Xtra		L	\N	\N	2011-08-30 17:25:27.18556	2011-08-30 17:25:27.18556
3	8	1	Ariane		L	\N	\N	2011-08-30 17:25:27.188871	2011-08-30 17:25:27.188871
4	16	1	Autan		kg	\N	\N	2011-08-30 17:25:27.191876	2011-08-30 17:25:27.191876
5	17	1	Azomag		kg	\N	\N	2011-08-30 17:25:27.194951	2011-08-30 17:25:27.194951
6	17	1	Azomag20		L	\N	\N	2011-08-30 17:25:27.197983	2011-08-30 17:25:27.197983
7	9	1	Azote		L	\N	\N	2011-08-30 17:25:27.20107	2011-08-30 17:25:27.20107
8	12	1	Bravo Elite		L	\N	\N	2011-08-30 17:25:27.204808	2011-08-30 17:25:27.204808
9	12	1	Bravoelite		L	\N	\N	2011-08-30 17:25:27.207836	2011-08-30 17:25:27.207836
10	16	1	Campo		kg	\N	\N	2011-08-30 17:25:27.210836	2011-08-30 17:25:27.210836
11	16	1	Campus		kg	\N	\N	2011-08-30 17:25:27.213868	2011-08-30 17:25:27.213868
12	16	1	Catalino		kg	\N	\N	2011-08-30 17:25:27.216929	2011-08-30 17:25:27.216929
13	10	1	Celtic		L	\N	\N	2011-08-30 17:25:27.219832	2011-08-30 17:25:27.219832
14	10	1	Challenge		L	\N	\N	2011-08-30 17:25:27.222716	2011-08-30 17:25:27.222716
15	10	1	Chardol		L	\N	\N	2011-08-30 17:25:27.225541	2011-08-30 17:25:27.225541
16	10	1	Chrono		L	\N	\N	2011-08-30 17:25:27.228416	2011-08-30 17:25:27.228416
17	10	1	Cline		L	\N	\N	2011-08-30 17:25:27.231328	2011-08-30 17:25:27.231328
18	10	1	Colzamid		L	\N	\N	2011-08-30 17:25:27.234466	2011-08-30 17:25:27.234466
19	12	1	Comet Player		L	\N	\N	2011-08-30 17:25:27.237416	2011-08-30 17:25:27.237416
20	10	1	Folyr		L	\N	\N	2011-08-30 17:25:27.240431	2011-08-30 17:25:27.240431
21	14	1	Fury		L	\N	\N	2011-08-30 17:25:27.243347	2011-08-30 17:25:27.243347
22	10	1	Glyphosate		L	\N	\N	2011-08-30 17:25:27.246367	2011-08-30 17:25:27.246367
23	16	1	Harmony		kg	\N	\N	2011-08-30 17:25:27.249713	2011-08-30 17:25:27.249713
24	8	1	Huile		L	\N	\N	2011-08-30 17:25:27.252968	2011-08-30 17:25:27.252968
25	16	1	Imperio		kg	\N	\N	2011-08-30 17:25:27.256056	2011-08-30 17:25:27.256056
26	16	1	Lontrel		kg	\N	\N	2011-08-30 17:25:27.259224	2011-08-30 17:25:27.259224
27	8	1	MAS 91		L	\N	\N	2011-08-30 17:25:27.262474	2011-08-30 17:25:27.262474
28	16	1	Novrel		kg	\N	\N	2011-08-30 17:25:27.265517	2011-08-30 17:25:27.265517
29	16	1	Ovation		kg	\N	\N	2011-08-30 17:25:27.268605	2011-08-30 17:25:27.268605
30	16	1	Paledor		kg	\N	\N	2011-08-30 17:25:27.271699	2011-08-30 17:25:27.271699
31	15	1	Picobore		kg	\N	\N	2011-08-30 17:25:27.274896	2011-08-30 17:25:27.274896
32	10	1	Picosolo		kg	\N	\N	2011-08-30 17:25:27.27815	2011-08-30 17:25:27.27815
33	16	1	Pr		kg	\N	\N	2011-08-30 17:25:27.28143	2011-08-30 17:25:27.28143
34	8	1	Proca		L	\N	\N	2011-08-30 17:25:27.284527	2011-08-30 17:25:27.284527
35	14	1	Proteus		L	\N	\N	2011-08-30 17:25:27.28784	2011-08-30 17:25:27.28784
36	10	1	Pulsar		L	\N	\N	2011-08-30 17:25:27.29145	2011-08-30 17:25:27.29145
37	8	1	Radar		L	\N	\N	2011-08-30 17:25:27.360546	2011-08-30 17:25:27.360546
38	8	1	Richepain		kg	\N	\N	2011-08-30 17:25:27.364908	2011-08-30 17:25:27.364908
39	10	1	Springbok		L	\N	\N	2011-08-30 17:25:27.368189	2011-08-30 17:25:27.368189
40	8	1	Stratos		L	\N	\N	2011-08-30 17:25:27.371331	2011-08-30 17:25:27.371331
41	8	1	Super45		L	\N	\N	2011-08-30 17:25:27.374404	2011-08-30 17:25:27.374404
42	12	1	Surnog		L	\N	\N	2011-08-30 17:25:27.377505	2011-08-30 17:25:27.377505
43	10	1	Traxos		L	\N	\N	2011-08-30 17:25:27.38067	2011-08-30 17:25:27.38067
44	8	1	Vip		L	\N	\N	2011-08-30 17:25:27.383716	2011-08-30 17:25:27.383716
45	11	1	0-20-30		kg	\N	\N	2011-08-30 17:25:27.386749	2011-08-30 17:25:27.386749
46	11	1	0-25-25		kg	\N	\N	2011-08-30 17:25:27.389743	2011-08-30 17:25:27.389743
47	12	2	Anistar		L	\N	\N	2011-08-30 17:25:42.205869	2011-08-30 17:25:42.205869
48	9	2	Azote		L	\N	\N	2011-08-30 17:25:42.212213	2011-08-30 17:25:42.212213
49	17	2	Azomag20		kg	\N	\N	2011-08-30 17:25:42.216027	2011-08-30 17:25:42.216027
50	17	2	Azomag20		L	\N	\N	2011-08-30 17:25:42.219791	2011-08-30 17:25:42.219791
51	16	2	Autan		kg	\N	\N	2011-08-30 17:25:42.223583	2011-08-30 17:25:42.223583
52	16	2	Campo		kg	\N	\N	2011-08-30 17:25:42.227309	2011-08-30 17:25:42.227309
53	10	2	Celtic		L	\N	\N	2011-08-30 17:25:42.230959	2011-08-30 17:25:42.230959
54	10	2	Challlenge		L	\N	\N	2011-08-30 17:25:42.234733	2011-08-30 17:25:42.234733
55	10	2	Celio		L	\N	\N	2011-08-30 17:25:42.238433	2011-08-30 17:25:42.238433
56	10	2	Chrono		L	\N	\N	2011-08-30 17:25:42.242124	2011-08-30 17:25:42.242124
57	12	2	Comet Player		L	\N	\N	2011-08-30 17:25:42.245909	2011-08-30 17:25:42.245909
58	16	2	Catalino		kg	\N	\N	2011-08-30 17:25:42.249681	2011-08-30 17:25:42.249681
59	10	2	Colzamid		L	\N	\N	2011-08-30 17:25:42.253348	2011-08-30 17:25:42.253348
60	10	2	Droid		L	\N	\N	2011-08-30 17:25:42.257202	2011-08-30 17:25:42.257202
61	12	2	Bravo Elite		L	\N	\N	2011-08-30 17:25:42.260845	2011-08-30 17:25:42.260845
62	10	2	Duplason		L	\N	\N	2011-08-30 17:25:42.264552	2011-08-30 17:25:42.264552
63	10	2	Folyr		L	\N	\N	2011-08-30 17:25:42.333329	2011-08-30 17:25:42.333329
64	16	2	Frelon		kg	\N	\N	2011-08-30 17:25:42.337772	2011-08-30 17:25:42.337772
65	14	2	Fury		L	\N	\N	2011-08-30 17:25:42.341672	2011-08-30 17:25:42.341672
66	10	2	Glyphosate		L	\N	\N	2011-08-30 17:25:42.345531	2011-08-30 17:25:42.345531
67	10	2	Harmony		kg	\N	\N	2011-08-30 17:25:42.349282	2011-08-30 17:25:42.349282
68	10	2	Iso		L	\N	\N	2011-08-30 17:25:42.352985	2011-08-30 17:25:42.352985
69	16	2	Imperio		kg	\N	\N	2011-08-30 17:25:42.356767	2011-08-30 17:25:42.356767
70	10	2	Novrel		L	\N	\N	2011-08-30 17:25:42.360405	2011-08-30 17:25:42.360405
71	14	2	Proteus		L	\N	\N	2011-08-30 17:25:42.364309	2011-08-30 17:25:42.364309
72	12	2	Procharge		L	\N	\N	2011-08-30 17:25:42.368219	2011-08-30 17:25:42.368219
73	12	2	Prochloraze		L	\N	\N	2011-08-30 17:25:42.371909	2011-08-30 17:25:42.371909
74	10	2	Picosolo		kg	\N	\N	2011-08-30 17:25:42.375579	2011-08-30 17:25:42.375579
75	12	2	Sunorg		L	\N	\N	2011-08-30 17:25:42.379257	2011-08-30 17:25:42.379257
76	10	2	storane		L	\N	\N	2011-08-30 17:25:42.382914	2011-08-30 17:25:42.382914
77	10	2	suplason		L	\N	\N	2011-08-30 17:25:42.386464	2011-08-30 17:25:42.386464
78	12	2	Prochorage		L	\N	\N	2011-08-30 17:25:42.390093	2011-08-30 17:25:42.390093
79	11	2	Super45		L	\N	\N	2011-08-30 17:25:42.394078	2011-08-30 17:25:42.394078
80	11	2	0-25-25		kg	\N	\N	2011-08-30 17:25:42.397678	2011-08-30 17:25:42.397678
81	11	2	0-20-30		kg	\N	\N	2011-08-30 17:25:42.401316	2011-08-30 17:25:42.401316
\.


--
-- Data for Name: protofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY protofactures (id, saison_id, produit_id, facture_id, prix, quantite, created_at, updated_at) FROM stdin;
1	2	47	2	1000	500	2011-08-30 17:25:44.011017	2011-08-30 17:25:44.011017
2	2	48	2	1000	500	2011-08-30 17:25:44.016515	2011-08-30 17:25:44.016515
3	2	49	2	1000	500	2011-08-30 17:25:44.019287	2011-08-30 17:25:44.019287
4	2	50	2	1000	500	2011-08-30 17:25:44.021948	2011-08-30 17:25:44.021948
5	2	51	2	1000	500	2011-08-30 17:25:44.02478	2011-08-30 17:25:44.02478
6	2	52	2	1000	500	2011-08-30 17:25:44.027533	2011-08-30 17:25:44.027533
7	2	53	2	1000	500	2011-08-30 17:25:44.030147	2011-08-30 17:25:44.030147
8	2	54	2	1000	500	2011-08-30 17:25:44.032946	2011-08-30 17:25:44.032946
9	2	55	2	1000	500	2011-08-30 17:25:44.035606	2011-08-30 17:25:44.035606
10	2	56	2	1000	500	2011-08-30 17:25:44.038306	2011-08-30 17:25:44.038306
11	2	57	2	1000	500	2011-08-30 17:25:44.040973	2011-08-30 17:25:44.040973
12	2	58	2	1000	500	2011-08-30 17:25:44.043619	2011-08-30 17:25:44.043619
13	2	59	2	1000	500	2011-08-30 17:25:44.046342	2011-08-30 17:25:44.046342
14	2	60	2	1000	500	2011-08-30 17:25:44.04893	2011-08-30 17:25:44.04893
15	2	61	2	1000	500	2011-08-30 17:25:44.05147	2011-08-30 17:25:44.05147
16	2	62	2	1000	500	2011-08-30 17:25:44.05407	2011-08-30 17:25:44.05407
17	2	63	2	1000	500	2011-08-30 17:25:44.056692	2011-08-30 17:25:44.056692
18	2	64	2	1000	500	2011-08-30 17:25:44.059351	2011-08-30 17:25:44.059351
19	2	65	2	1000	500	2011-08-30 17:25:44.061917	2011-08-30 17:25:44.061917
20	2	66	2	1000	500	2011-08-30 17:25:44.064542	2011-08-30 17:25:44.064542
21	2	67	2	1000	500	2011-08-30 17:25:44.067264	2011-08-30 17:25:44.067264
22	2	68	2	1000	500	2011-08-30 17:25:44.070029	2011-08-30 17:25:44.070029
23	2	69	2	1000	500	2011-08-30 17:25:44.072615	2011-08-30 17:25:44.072615
24	2	70	2	1000	500	2011-08-30 17:25:44.075236	2011-08-30 17:25:44.075236
25	2	71	2	1000	500	2011-08-30 17:25:44.077779	2011-08-30 17:25:44.077779
26	2	72	2	1000	500	2011-08-30 17:25:44.080406	2011-08-30 17:25:44.080406
27	2	73	2	1000	500	2011-08-30 17:25:44.082978	2011-08-30 17:25:44.082978
28	2	74	2	1000	500	2011-08-30 17:25:44.085628	2011-08-30 17:25:44.085628
29	2	75	2	1000	500	2011-08-30 17:25:44.088336	2011-08-30 17:25:44.088336
30	2	76	2	1000	500	2011-08-30 17:25:44.091089	2011-08-30 17:25:44.091089
31	2	77	2	1000	500	2011-08-30 17:25:44.093629	2011-08-30 17:25:44.093629
32	2	78	2	1000	500	2011-08-30 17:25:44.096179	2011-08-30 17:25:44.096179
33	2	79	2	1000	500	2011-08-30 17:25:44.098696	2011-08-30 17:25:44.098696
34	2	80	2	1000	500	2011-08-30 17:25:44.101248	2011-08-30 17:25:44.101248
35	2	81	2	1000	500	2011-08-30 17:25:44.103823	2011-08-30 17:25:44.103823
\.


--
-- Data for Name: pulves; Type: TABLE DATA; Schema: public; Owner: -
--

COPY pulves (id, saison_id, user_id, date, name, cout_ha_passage, star, adu, "desc", created_at, updated_at) FROM stdin;
1	1	1	2011-01-01	FIXTURE	0	\N	\N	from seeds	2011-08-30 17:25:27.164256	2011-08-30 17:25:27.164256
2	1	2	2011-03-11	Glyphosate	10	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-08-30 17:25:27.393645	2011-08-30 17:25:27.393645
3	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-08-30 17:25:27.412064	2011-08-30 17:25:27.412064
4	1	2	2011-04-06	Semis	10	1	\N	indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).	2011-08-30 17:25:27.419137	2011-08-30 17:25:27.419137
5	1	2	2011-04-07	Cline	10	0	\N	2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636	2011-08-30 17:25:27.429063	2011-08-30 17:25:27.429063
6	1	2	2011-04-11	Challenge	10	0	\N	4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182	2011-08-30 17:25:27.435996	2011-08-30 17:25:27.435996
7	1	2	2011-05-20	pulsar	10	0	\N	1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182	2011-08-30 17:25:27.442933	2011-08-30 17:25:27.442933
8	1	2	2011-03-11	Glyphosate	10	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-08-30 17:25:27.486487	2011-08-30 17:25:27.486487
9	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-08-30 17:25:27.495869	2011-08-30 17:25:27.495869
10	1	2	2011-04-06	Semis	10	1	\N	modifier le cout_ha_passage et le dosage	2011-08-30 17:25:27.505477	2011-08-30 17:25:27.505477
11	1	2	2011-04-11	Challenge	10	0	\N		2011-08-30 17:25:27.512805	2011-08-30 17:25:27.512805
12	1	2	2010-08-31	Semis	10	0	\N		2011-08-30 17:25:27.539508	2011-08-30 17:25:27.539508
13	1	2	2010-08-31	colzamid	10	0	\N		2011-08-30 17:25:27.61246	2011-08-30 17:25:27.61246
14	1	2	2010-09-02	springbok	10	0	\N		2011-08-30 17:25:27.620464	2011-08-30 17:25:27.620464
15	1	2	2010-10-07	Folyr	10	0	\N		2011-08-30 17:25:27.627649	2011-08-30 17:25:27.627649
16	1	2	2011-01-23	0-20-30	10	0	\N		2011-08-30 17:25:27.640554	2011-08-30 17:25:27.640554
17	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38 (? Cf carnet trochet)	2011-08-30 17:25:27.64812	2011-08-30 17:25:27.64812
18	1	2	2011-02-10	Stratos	10	0	\N		2011-08-30 17:25:27.655336	2011-08-30 17:25:27.655336
19	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-08-30 17:25:27.662495	2011-08-30 17:25:27.662495
20	1	2	2011-03-08	Soufre	10	0	\N		2011-08-30 17:25:27.669486	2011-08-30 17:25:27.669486
21	1	2	2011-03-08	Fury	10	0	\N		2011-08-30 17:25:27.676956	2011-08-30 17:25:27.676956
22	1	2	2011-03-08	chrono	10	0	\N		2011-08-30 17:25:27.683904	2011-08-30 17:25:27.683904
23	1	2	2011-03-20	picobore	10	0	\N		2011-08-30 17:25:27.693585	2011-08-30 17:25:27.693585
24	1	2	2011-04-02	Surnog	10	0	\N		2011-08-30 17:25:27.703288	2011-08-30 17:25:27.703288
25	1	2	2011-04-20	anistar_xtra	10	0	\N		2011-08-30 17:25:27.710551	2011-08-30 17:25:27.710551
26	1	2	2010-08-30	Semis	10	1	\N	dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)	2011-08-30 17:25:27.760738	2011-08-30 17:25:27.760738
27	1	2	2010-08-30	colzamid	10	0	\N		2011-08-30 17:25:27.7707	2011-08-30 17:25:27.7707
28	1	2	2010-09-02	springbok	10	0	\N		2011-08-30 17:25:27.777948	2011-08-30 17:25:27.777948
29	1	2	2010-10-07	Folyr	10	0	\N		2011-08-30 17:25:27.784677	2011-08-30 17:25:27.784677
30	1	2	2011-01-23	0-20-30	10	0	\N		2011-08-30 17:25:27.864504	2011-08-30 17:25:27.864504
31	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38	2011-08-30 17:25:27.872052	2011-08-30 17:25:27.872052
32	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-08-30 17:25:27.880484	2011-08-30 17:25:27.880484
33	1	2	2011-03-08	Soufre	10	0	\N		2011-08-30 17:25:27.887768	2011-08-30 17:25:27.887768
34	1	2	2011-03-09	Fury	10	0	\N		2011-08-30 17:25:27.894892	2011-08-30 17:25:27.894892
35	1	2	2011-03-08	chrono	10	0	\N	dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.	2011-08-30 17:25:27.90212	2011-08-30 17:25:27.90212
36	1	2	2011-03-24	picobore	10	0	\N		2011-08-30 17:25:27.911943	2011-08-30 17:25:27.911943
37	1	2	2011-04-02	Surnog	10	0	\N		2011-08-30 17:25:27.921626	2011-08-30 17:25:27.921626
38	1	2	2011-04-20	anistar_xtra	10	0	\N		2011-08-30 17:25:27.928741	2011-08-30 17:25:27.928741
39	1	2	2010-10-01	glyphosate	10	0	\N		2011-08-30 17:25:27.976833	2011-08-30 17:25:27.976833
40	1	2	2010-10-22	semis	10	0	\N	dosage réel=180.</br>début Richepin, fin PR.</br>N°43	2011-08-30 17:25:27.98371	2011-08-30 17:25:27.98371
41	1	2	2011-01-20	Super 45	10	0	\N		2011-08-30 17:25:27.993111	2011-08-30 17:25:27.993111
42	1	2	2011-02-08	Azote	10	0	\N		2011-08-30 17:25:28.000329	2011-08-30 17:25:28.000329
43	1	2	2011-03-03	Azote	10	0	\N		2011-08-30 17:25:28.00744	2011-08-30 17:25:28.00744
44	1	2	2011-03-09	Soufre	10	0	\N		2011-08-30 17:25:28.014688	2011-08-30 17:25:28.014688
45	1	2	2011-03-09	Radar	10	0	\N		2011-08-30 17:25:28.021698	2011-08-30 17:25:28.021698
46	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-08-30 17:25:28.028401	2011-08-30 17:25:28.028401
47	1	2	2011-04-20	Vip	10	1	\N	dosage huile?	2011-08-30 17:25:28.03522	2011-08-30 17:25:28.03522
48	1	2	2011-04-30	Baravo Elite	10	0	\N		2011-08-30 17:25:28.111149	2011-08-30 17:25:28.111149
49	1	2	2011-05-04	Ariane	10	0	\N		2011-08-30 17:25:28.119163	2011-08-30 17:25:28.119163
50	1	2	2010-09-30	glyphosate	10	0	\N		2011-08-30 17:25:28.163701	2011-08-30 17:25:28.163701
51	1	2	2010-10-20	semis	10	0	\N	dosage reel 175kg/Ha.</br>N°42.	2011-08-30 17:25:28.173595	2011-08-30 17:25:28.173595
52	1	2	2011-01-20	Super 45	10	0	\N		2011-08-30 17:25:28.183877	2011-08-30 17:25:28.183877
53	1	2	2011-02-08	Azote	10	0	\N		2011-08-30 17:25:28.194162	2011-08-30 17:25:28.194162
54	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-08-30 17:25:28.201917	2011-08-30 17:25:28.201917
55	1	2	2011-03-03	Azote	10	0	\N		2011-08-30 17:25:28.21212	2011-08-30 17:25:28.21212
56	1	2	2011-03-09	Soufre	10	0	\N		2011-08-30 17:25:28.218975	2011-08-30 17:25:28.218975
57	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-08-30 17:25:28.225747	2011-08-30 17:25:28.225747
58	1	2	2011-04-21	Vip	10	1	\N	traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha	2011-08-30 17:25:28.232918	2011-08-30 17:25:28.232918
59	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-08-30 17:25:28.245047	2011-08-30 17:25:28.245047
60	1	2	2010-09-30	glyphosate	10	0	\N		2011-08-30 17:25:28.285764	2011-08-30 17:25:28.285764
61	1	2	2010-10-21	semis	10	0	\N	dosage reel 165kg/Ha.</br>(Voir plan?)	2011-08-30 17:25:28.296938	2011-08-30 17:25:28.296938
62	1	2	2011-01-20	Super 45	10	0	\N		2011-08-30 17:25:28.377317	2011-08-30 17:25:28.377317
63	1	2	2011-02-08	Azote	10	0	\N		2011-08-30 17:25:28.384632	2011-08-30 17:25:28.384632
64	1	2	2011-03-03	Azote	10	0	\N		2011-08-30 17:25:28.391796	2011-08-30 17:25:28.391796
65	1	2	2011-03-09	Soufre	10	0	\N		2011-08-30 17:25:28.399006	2011-08-30 17:25:28.399006
66	1	2	2011-03-14	Radar	10	1	\N	dosage huile?	2011-08-30 17:25:28.40612	2011-08-30 17:25:28.40612
67	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-08-30 17:25:28.41598	2011-08-30 17:25:28.41598
68	1	2	2011-04-21	Vip	10	1	\N	dosage reel : 0,5L/Ha sur 2.5 Ha.	2011-08-30 17:25:28.423128	2011-08-30 17:25:28.423128
69	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-08-30 17:25:28.432918	2011-08-30 17:25:28.432918
70	1	2	2010-09-30	glyphosate	10	0	\N		2011-08-30 17:25:28.473168	2011-08-30 17:25:28.473168
71	1	2	2010-10-21	semis	10	0	\N	dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42	2011-08-30 17:25:28.482975	2011-08-30 17:25:28.482975
72	1	2	2011-01-20	Super 45	10	0	\N		2011-08-30 17:25:28.492398	2011-08-30 17:25:28.492398
73	1	2	2011-02-08	Azote	10	0	\N		2011-08-30 17:25:28.499289	2011-08-30 17:25:28.499289
74	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-08-30 17:25:28.506132	2011-08-30 17:25:28.506132
75	1	2	2011-03-03	Azote	10	0	\N		2011-08-30 17:25:28.519616	2011-08-30 17:25:28.519616
76	1	2	2011-03-09	Soufre	10	0	\N		2011-08-30 17:25:28.52804	2011-08-30 17:25:28.52804
77	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-08-30 17:25:28.53513	2011-08-30 17:25:28.53513
78	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-08-30 17:25:28.542448	2011-08-30 17:25:28.542448
80	2	2	2009-08-31	Colzamid	10	\N	\N		2011-08-30 17:25:42.438591	2011-08-30 17:25:43.670781
81	2	2	2009-09-02	Novrel	10	\N	\N		2011-08-30 17:25:42.445382	2011-08-30 17:25:43.673111
82	2	2	2009-09-20	folyr	10	\N	\N		2011-08-30 17:25:42.451969	2011-08-30 17:25:43.675378
83	2	2	2009-09-20	fury	10	1	\N	date erronee, avec huile 1L	2011-08-30 17:25:42.45902	2011-08-30 17:25:43.677591
84	2	2	2009-09-20	0-25-25	10	1	\N	date erronee	2011-08-30 17:25:42.466076	2011-08-30 17:25:43.679877
85	2	2	2010-02-10	Azote	10	\N	\N	195kg = 65u	2011-08-30 17:25:42.472776	2011-08-30 17:25:43.682113
86	2	2	2010-03-09	Azote 2eme	10	\N	\N	230kg = 77u	2011-08-30 17:25:42.479684	2011-08-30 17:25:43.684573
87	2	2	2010-03-12	Azomag	10	\N	\N	150kg = 30u	2011-08-30 17:25:42.486347	2011-08-30 17:25:43.686881
88	2	2	2010-03-19	Fury	10	\N	\N		2011-08-30 17:25:42.494065	2011-08-30 17:25:43.689092
89	2	2	2010-04-06	proteus	10	\N	\N		2011-08-30 17:25:42.564351	2011-08-30 17:25:43.691455
90	2	2	2010-04-18	sunorg	10	\N	\N		2011-08-30 17:25:42.572032	2011-08-30 17:25:43.69371
91	2	2	2010-05-07	anistar	10	\N	\N		2011-08-30 17:25:42.579309	2011-08-30 17:25:43.695945
92	2	2	2009-08-13	Glyphosate	10	\N	\N	+ 0,5 L huile	2011-08-30 17:25:42.699335	2011-08-30 17:25:43.698222
94	2	2	2009-09-29	Chrono	10	\N	\N		2011-08-30 17:25:42.712647	2011-08-30 17:25:43.702859
95	2	2	2009-11-20	folyr	10	\N	\N	 + huile 1L	2011-08-30 17:25:42.719927	2011-08-30 17:25:43.705129
96	2	2	2009-11-22	fury	10	\N	\N		2011-08-30 17:25:42.726997	2011-08-30 17:25:43.707352
97	2	2	2010-02-04	0-25-25	10	\N	\N		2011-08-30 17:25:42.797001	2011-08-30 17:25:43.709648
98	2	2	2010-02-10	Azote	10	\N	\N	75u	2011-08-30 17:25:42.804673	2011-08-30 17:25:43.711837
99	2	2	2010-03-12	Azomag20	10	\N	\N	150kg = 30u	2011-08-30 17:25:42.811837	2011-08-30 17:25:43.714293
100	2	2	2010-03-19	fury	10	\N	\N		2011-08-30 17:25:42.819051	2011-08-30 17:25:43.781701
101	2	2	2010-04-06	proteus	10	\N	\N		2011-08-30 17:25:42.826204	2011-08-30 17:25:43.784567
102	2	2	2010-04-18	sunorg	10	\N	\N		2011-08-30 17:25:42.833279	2011-08-30 17:25:43.787162
103	2	2	2010-05-07	anistar	10	\N	\N		2011-08-30 17:25:42.840348	2011-08-30 17:25:43.789721
104	2	2	2009-10-19	Semis	10	\N	\N	PR + Richepain + Frelon + selection Paledor + Richepain n41	2011-08-30 17:25:42.938753	2011-08-30 17:25:43.792282
106	2	2	2009-11-19	desherb colza 2	10	1	\N	7 Ha sur colza. TODO: diminuer le dosage car surface moindre. Picosolo, 80g/Ha, Harmony, 25g/Ha	2011-08-30 17:25:42.955943	2011-08-30 17:25:43.797286
107	2	2	2010-02-04	Super 45	10	\N	\N		2011-08-30 17:25:42.965405	2011-08-30 17:25:43.799788
108	2	2	2010-02-11	Azote 1	10	\N	\N	190 kg, 64u	2011-08-30 17:25:42.972113	2011-08-30 17:25:43.802253
109	2	2	2010-03-09	Azote 2	10	\N	\N	183 kg, 61u	2011-08-30 17:25:42.979274	2011-08-30 17:25:43.80467
110	2	2	2010-03-23	Celio	10	\N	\N	0.5L + Huile 0.1L. sur 6.72 ha cote luzerne	2011-08-30 17:25:42.986322	2011-08-30 17:25:43.807071
111	2	2	2010-04-06	Procharge	10	\N	\N		2011-08-30 17:25:42.993347	2011-08-30 17:25:43.809462
112	2	2	2010-04-18	suplason	10	\N	\N	TODO: ajuster les dosage a la surface. 16 ha derriere maison	2011-08-30 17:25:43.066824	2011-08-30 17:25:43.811842
113	2	2	2010-05-17	Azote 3	10	\N	\N	120kg, 40u	2011-08-30 17:25:43.076792	2011-08-30 17:25:43.81433
114	2	2	2010-05-28	comet Player	10	\N	\N	1 pack = 6 Ha	2011-08-30 17:25:43.083982	2011-08-30 17:25:43.816644
115	2	2	2009-10-20	Semis	10	\N	\N		2011-08-30 17:25:43.1583	2011-08-30 17:25:43.818942
116	2	2	2010-02-04	Super 45	10	\N	\N		2011-08-30 17:25:43.165027	2011-08-30 17:25:43.821228
117	2	2	2010-02-15	Azote 1	10	\N	\N	210kg, 70u	2011-08-30 17:25:43.171757	2011-08-30 17:25:43.823672
118	2	2	2010-03-09	Azote 2	10	\N	\N	200kg, 67u	2011-08-30 17:25:43.178492	2011-08-30 17:25:43.826026
119	2	2	2009-03-23	Droid	10	1	\N	TODO ajuster le dosage. + huile 0.1L. tour de champs	2011-08-30 17:25:43.185233	2011-08-30 17:25:43.828339
120	2	2	2009-04-06	Prochloraze	10	1	\N		2011-08-30 17:25:43.191928	2011-08-30 17:25:43.830632
121	2	2	2009-04-12	Desherbant	10	1	\N	TODO ajuster dosage. Le milieu seulement	2011-08-30 17:25:43.198692	2011-08-30 17:25:43.832999
122	2	2	2009-05-07	Bravo Elite	10	\N	\N		2011-08-30 17:25:43.20789	2011-08-30 17:25:43.835434
123	2	2	2009-10-20	Semis	10	\N	\N	+ 2Ha Autan	2011-08-30 17:25:43.309223	2011-08-30 17:25:43.83776
124	2	2	2009-11-19	Celtic + iso	10	1	\N	sur 3Ha	2011-08-30 17:25:43.317047	2011-08-30 17:25:43.840055
125	2	2	2009-11-19	Harmony	10	\N	\N	sur 7Ha - reste 3 ha	2011-08-30 17:25:43.327196	2011-08-30 17:25:43.842387
126	2	2	2010-02-04	super 45	10	\N	\N		2011-08-30 17:25:43.337101	2011-08-30 17:25:43.844931
127	2	2	2010-02-16	azote 1	10	\N	\N	210kg, 70u	2011-08-30 17:25:43.34425	2011-08-30 17:25:43.847398
128	2	2	2010-03-09	azote 2	10	\N	\N	206kg, 69u	2011-08-30 17:25:43.351231	2011-08-30 17:25:43.8497
129	2	2	2010-03-23	Droid	10	1	\N	TODO ajuster le dosage. + huile 0.1L. sur 3 Ha	2011-08-30 17:25:43.358221	2011-08-30 17:25:43.851989
130	2	2	2010-03-23	Celio	10	1	\N	TODO ajuster le dosage. + huile 0.1L. sur 4 Ha	2011-08-30 17:25:43.365198	2011-08-30 17:25:43.854339
131	2	2	2010-04-06	Prochloraze	10	1	\N		2011-08-30 17:25:43.372151	2011-08-30 17:25:43.856855
132	2	2	2010-05-07	Bravo Elite	10	\N	\N		2011-08-30 17:25:43.379013	2011-08-30 17:25:43.859171
133	2	2	2010-05-17	Azote 3	10	\N	\N	120kg, 40u	2011-08-30 17:25:43.385893	2011-08-30 17:25:43.861436
134	2	2	2010-05-22	comet Player	10	1	\N	1 pack = 6 Ha. 1pack = combien de kg => ajuster chaque occurence de comet player.	2011-08-30 17:25:43.392733	2011-08-30 17:25:43.863824
135	2	2	2009-10-20	Semis	10	\N	\N		2011-08-30 17:25:43.439191	2011-08-30 17:25:43.866249
136	2	2	2009-11-19	Celtic + iso	10	\N	\N		2011-08-30 17:25:43.446107	2011-08-30 17:25:43.868544
137	2	2	2010-02-04	super 45	10	\N	\N		2011-08-30 17:25:43.45517	2011-08-30 17:25:43.870817
138	2	2	2010-02-16	azote 1	10	\N	\N	200kg, 67u	2011-08-30 17:25:43.461878	2011-08-30 17:25:43.873062
139	2	2	2010-03-06	azote 2	10	\N	\N	200kg, 67u	2011-08-30 17:25:43.468764	2011-08-30 17:25:43.875365
140	2	2	2009-04-12	Desherbant	10	\N	\N		2011-08-30 17:25:43.475405	2011-08-30 17:25:43.877653
141	2	2	2010-05-07	Bravo Elite	10	\N	\N		2011-08-30 17:25:43.484779	2011-08-30 17:25:43.880221
142	2	2	2010-05-17	Azote 3	10	\N	\N	120kg, 40u	2011-08-30 17:25:43.558197	2011-08-30 17:25:43.882487
143	2	2	2010-05-28	comet Player	10	1	\N	1 pack = 6 Ha. 1pack = combien de kg => ajuster chaque occurence de comet player.	2011-08-30 17:25:43.565627	2011-08-30 17:25:43.884766
144	2	2	2009-11-22	Glyphosate	10	\N	\N	+ huile 1L/Ha	2011-08-30 17:25:43.605561	2011-08-30 17:25:43.886964
145	2	2	2009-03-24	0-20-30	10	\N	\N		2011-08-30 17:25:43.612563	2011-08-30 17:25:43.889187
146	2	2	2009-04-14	Glyphosate	10	\N	\N		2011-08-30 17:25:43.619377	2011-08-30 17:25:43.891522
147	2	2	2009-04-10	Imperio	10	1	\N	dosage inconnu!	2011-08-30 17:25:43.626211	2011-08-30 17:25:43.893852
148	2	2	2009-04-14	Challenge	10	\N	\N		2011-08-30 17:25:43.632977	2011-08-30 17:25:43.896135
149	2	2	2010-06-07	Azote	10	\N	\N	107kg, 35u	2011-08-30 17:25:43.639748	2011-08-30 17:25:43.89835
79	2	2	2009-08-31	Semis	10	\N	\N	Campo + Catalino, Catalino selection 2Ha cote haie	2011-08-30 17:25:42.417673	2011-08-30 17:25:43.668174
93	2	2	2009-09-05	Semis	10	\N	\N	verifier dosage semis.', :star => 1	2011-08-30 17:25:42.706032	2011-08-30 17:25:43.700586
105	2	2	2009-11-19	desherb colza 1	10	1	\N	TODO: diminuer le dosage car surface moindre. Iso 2L/Ha. Sur tournesol + tour de champs	2011-08-30 17:25:42.945798	2011-08-30 17:25:43.794724
\.


--
-- Data for Name: putofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putofactures (id, saison_id, facture_id, pulve_id, value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: putoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putoparcelles (id, saison_id, parcelle_id, pulve_id, value, created_at, updated_at) FROM stdin;
1	1	11	2	0	2011-08-30 17:25:27.46113	2011-08-30 17:25:27.46113
2	1	11	3	0	2011-08-30 17:25:27.466296	2011-08-30 17:25:27.466296
3	1	11	4	0	2011-08-30 17:25:27.468969	2011-08-30 17:25:27.468969
4	1	11	5	0	2011-08-30 17:25:27.471356	2011-08-30 17:25:27.471356
5	1	11	6	0	2011-08-30 17:25:27.473681	2011-08-30 17:25:27.473681
6	1	11	7	0	2011-08-30 17:25:27.476153	2011-08-30 17:25:27.476153
7	1	9	8	0	2011-08-30 17:25:27.52515	2011-08-30 17:25:27.52515
8	1	9	9	0	2011-08-30 17:25:27.527589	2011-08-30 17:25:27.527589
9	1	9	10	0	2011-08-30 17:25:27.530346	2011-08-30 17:25:27.530346
10	1	9	11	0	2011-08-30 17:25:27.533057	2011-08-30 17:25:27.533057
11	1	10	12	0	2011-08-30 17:25:27.723359	2011-08-30 17:25:27.723359
12	1	10	13	0	2011-08-30 17:25:27.725822	2011-08-30 17:25:27.725822
13	1	10	14	0	2011-08-30 17:25:27.728192	2011-08-30 17:25:27.728192
14	1	10	15	0	2011-08-30 17:25:27.730685	2011-08-30 17:25:27.730685
15	1	10	16	0	2011-08-30 17:25:27.73308	2011-08-30 17:25:27.73308
16	1	10	17	0	2011-08-30 17:25:27.735486	2011-08-30 17:25:27.735486
17	1	10	18	0	2011-08-30 17:25:27.737902	2011-08-30 17:25:27.737902
18	1	10	19	0	2011-08-30 17:25:27.740268	2011-08-30 17:25:27.740268
19	1	10	20	0	2011-08-30 17:25:27.742804	2011-08-30 17:25:27.742804
20	1	10	21	0	2011-08-30 17:25:27.745346	2011-08-30 17:25:27.745346
21	1	10	22	0	2011-08-30 17:25:27.747776	2011-08-30 17:25:27.747776
22	1	10	23	0	2011-08-30 17:25:27.750141	2011-08-30 17:25:27.750141
23	1	10	24	0	2011-08-30 17:25:27.752636	2011-08-30 17:25:27.752636
24	1	10	25	0	2011-08-30 17:25:27.754994	2011-08-30 17:25:27.754994
25	1	8	26	0	2011-08-30 17:25:27.94136	2011-08-30 17:25:27.94136
26	1	8	27	0	2011-08-30 17:25:27.943896	2011-08-30 17:25:27.943896
27	1	8	28	0	2011-08-30 17:25:27.946297	2011-08-30 17:25:27.946297
28	1	8	29	0	2011-08-30 17:25:27.948663	2011-08-30 17:25:27.948663
29	1	8	30	0	2011-08-30 17:25:27.951164	2011-08-30 17:25:27.951164
30	1	8	31	0	2011-08-30 17:25:27.953811	2011-08-30 17:25:27.953811
31	1	8	32	0	2011-08-30 17:25:27.956262	2011-08-30 17:25:27.956262
32	1	8	33	0	2011-08-30 17:25:27.958619	2011-08-30 17:25:27.958619
33	1	8	34	0	2011-08-30 17:25:27.961005	2011-08-30 17:25:27.961005
34	1	8	35	0	2011-08-30 17:25:27.963406	2011-08-30 17:25:27.963406
35	1	8	36	0	2011-08-30 17:25:27.965786	2011-08-30 17:25:27.965786
36	1	8	37	0	2011-08-30 17:25:27.968149	2011-08-30 17:25:27.968149
37	1	8	38	0	2011-08-30 17:25:27.970452	2011-08-30 17:25:27.970452
38	1	6	39	0	2011-08-30 17:25:28.13246	2011-08-30 17:25:28.13246
39	1	6	40	0	2011-08-30 17:25:28.135102	2011-08-30 17:25:28.135102
40	1	6	41	0	2011-08-30 17:25:28.137617	2011-08-30 17:25:28.137617
41	1	6	42	0	2011-08-30 17:25:28.140168	2011-08-30 17:25:28.140168
42	1	6	43	0	2011-08-30 17:25:28.142796	2011-08-30 17:25:28.142796
43	1	6	44	0	2011-08-30 17:25:28.145255	2011-08-30 17:25:28.145255
44	1	6	45	0	2011-08-30 17:25:28.147951	2011-08-30 17:25:28.147951
45	1	6	46	0	2011-08-30 17:25:28.15044	2011-08-30 17:25:28.15044
46	1	6	47	0	2011-08-30 17:25:28.152987	2011-08-30 17:25:28.152987
47	1	6	48	0	2011-08-30 17:25:28.155482	2011-08-30 17:25:28.155482
48	1	6	49	0	2011-08-30 17:25:28.157956	2011-08-30 17:25:28.157956
49	1	7	50	0	2011-08-30 17:25:28.257566	2011-08-30 17:25:28.257566
50	1	7	51	0	2011-08-30 17:25:28.260116	2011-08-30 17:25:28.260116
51	1	7	52	0	2011-08-30 17:25:28.262511	2011-08-30 17:25:28.262511
52	1	7	53	0	2011-08-30 17:25:28.265046	2011-08-30 17:25:28.265046
53	1	7	54	0	2011-08-30 17:25:28.267498	2011-08-30 17:25:28.267498
54	1	7	55	0	2011-08-30 17:25:28.26989	2011-08-30 17:25:28.26989
55	1	7	56	0	2011-08-30 17:25:28.272475	2011-08-30 17:25:28.272475
56	1	7	57	0	2011-08-30 17:25:28.274976	2011-08-30 17:25:28.274976
57	1	7	58	0	2011-08-30 17:25:28.277283	2011-08-30 17:25:28.277283
58	1	7	59	0	2011-08-30 17:25:28.279635	2011-08-30 17:25:28.279635
59	1	2	60	0	2011-08-30 17:25:28.445589	2011-08-30 17:25:28.445589
60	1	2	61	0	2011-08-30 17:25:28.448137	2011-08-30 17:25:28.448137
61	1	2	62	0	2011-08-30 17:25:28.450546	2011-08-30 17:25:28.450546
62	1	2	63	0	2011-08-30 17:25:28.452997	2011-08-30 17:25:28.452997
63	1	2	64	0	2011-08-30 17:25:28.455377	2011-08-30 17:25:28.455377
64	1	2	65	0	2011-08-30 17:25:28.457889	2011-08-30 17:25:28.457889
65	1	2	66	0	2011-08-30 17:25:28.460273	2011-08-30 17:25:28.460273
66	1	2	67	0	2011-08-30 17:25:28.462638	2011-08-30 17:25:28.462638
67	1	2	68	0	2011-08-30 17:25:28.465147	2011-08-30 17:25:28.465147
68	1	2	69	0	2011-08-30 17:25:28.467488	2011-08-30 17:25:28.467488
69	1	1	70	0	2011-08-30 17:25:28.621877	2011-08-30 17:25:28.621877
70	1	1	71	0	2011-08-30 17:25:28.625272	2011-08-30 17:25:28.625272
71	1	1	72	0	2011-08-30 17:25:28.628012	2011-08-30 17:25:28.628012
72	1	1	73	0	2011-08-30 17:25:28.630862	2011-08-30 17:25:28.630862
73	1	1	74	0	2011-08-30 17:25:28.633448	2011-08-30 17:25:28.633448
74	1	1	75	0	2011-08-30 17:25:28.636003	2011-08-30 17:25:28.636003
75	1	1	76	0	2011-08-30 17:25:28.638529	2011-08-30 17:25:28.638529
76	1	1	77	0	2011-08-30 17:25:28.641082	2011-08-30 17:25:28.641082
77	1	1	78	0	2011-08-30 17:25:28.64369	2011-08-30 17:25:28.64369
78	2	13	79	0	2011-08-30 17:25:42.617287	2011-08-30 17:25:42.617287
79	2	12	79	0	2011-08-30 17:25:42.622279	2011-08-30 17:25:42.622279
80	2	13	80	0	2011-08-30 17:25:42.624919	2011-08-30 17:25:42.624919
81	2	12	80	0	2011-08-30 17:25:42.627353	2011-08-30 17:25:42.627353
82	2	13	81	0	2011-08-30 17:25:42.629793	2011-08-30 17:25:42.629793
83	2	12	81	0	2011-08-30 17:25:42.632353	2011-08-30 17:25:42.632353
84	2	13	82	0	2011-08-30 17:25:42.634765	2011-08-30 17:25:42.634765
85	2	12	82	0	2011-08-30 17:25:42.637182	2011-08-30 17:25:42.637182
86	2	13	83	0	2011-08-30 17:25:42.639515	2011-08-30 17:25:42.639515
87	2	12	83	0	2011-08-30 17:25:42.641881	2011-08-30 17:25:42.641881
88	2	13	84	0	2011-08-30 17:25:42.644212	2011-08-30 17:25:42.644212
89	2	12	84	0	2011-08-30 17:25:42.646747	2011-08-30 17:25:42.646747
90	2	13	85	0	2011-08-30 17:25:42.649098	2011-08-30 17:25:42.649098
91	2	12	85	0	2011-08-30 17:25:42.651452	2011-08-30 17:25:42.651452
92	2	13	86	0	2011-08-30 17:25:42.653784	2011-08-30 17:25:42.653784
93	2	12	86	0	2011-08-30 17:25:42.656693	2011-08-30 17:25:42.656693
94	2	13	87	0	2011-08-30 17:25:42.659097	2011-08-30 17:25:42.659097
95	2	12	87	0	2011-08-30 17:25:42.661668	2011-08-30 17:25:42.661668
96	2	13	88	0	2011-08-30 17:25:42.66405	2011-08-30 17:25:42.66405
97	2	12	88	0	2011-08-30 17:25:42.666393	2011-08-30 17:25:42.666393
98	2	13	89	0	2011-08-30 17:25:42.669	2011-08-30 17:25:42.669
99	2	12	89	0	2011-08-30 17:25:42.671415	2011-08-30 17:25:42.671415
100	2	13	90	0	2011-08-30 17:25:42.673744	2011-08-30 17:25:42.673744
101	2	12	90	0	2011-08-30 17:25:42.676195	2011-08-30 17:25:42.676195
102	2	13	91	0	2011-08-30 17:25:42.678691	2011-08-30 17:25:42.678691
103	2	12	91	0	2011-08-30 17:25:42.681078	2011-08-30 17:25:42.681078
104	2	14	92	0	2011-08-30 17:25:42.848555	2011-08-30 17:25:42.848555
105	2	16	92	0	2011-08-30 17:25:42.851222	2011-08-30 17:25:42.851222
106	2	14	93	0	2011-08-30 17:25:42.853665	2011-08-30 17:25:42.853665
107	2	16	93	0	2011-08-30 17:25:42.856178	2011-08-30 17:25:42.856178
108	2	14	94	0	2011-08-30 17:25:42.858662	2011-08-30 17:25:42.858662
109	2	16	94	0	2011-08-30 17:25:42.861037	2011-08-30 17:25:42.861037
110	2	14	95	0	2011-08-30 17:25:42.863575	2011-08-30 17:25:42.863575
111	2	16	95	0	2011-08-30 17:25:42.866007	2011-08-30 17:25:42.866007
112	2	14	96	0	2011-08-30 17:25:42.86859	2011-08-30 17:25:42.86859
113	2	16	96	0	2011-08-30 17:25:42.871	2011-08-30 17:25:42.871
114	2	14	97	0	2011-08-30 17:25:42.873428	2011-08-30 17:25:42.873428
115	2	16	97	0	2011-08-30 17:25:42.875822	2011-08-30 17:25:42.875822
116	2	14	98	0	2011-08-30 17:25:42.880374	2011-08-30 17:25:42.880374
117	2	16	98	0	2011-08-30 17:25:42.894141	2011-08-30 17:25:42.894141
118	2	14	99	0	2011-08-30 17:25:42.89698	2011-08-30 17:25:42.89698
119	2	16	99	0	2011-08-30 17:25:42.899599	2011-08-30 17:25:42.899599
120	2	14	100	0	2011-08-30 17:25:42.902101	2011-08-30 17:25:42.902101
121	2	16	100	0	2011-08-30 17:25:42.904969	2011-08-30 17:25:42.904969
122	2	14	101	0	2011-08-30 17:25:42.907976	2011-08-30 17:25:42.907976
123	2	16	101	0	2011-08-30 17:25:42.91043	2011-08-30 17:25:42.91043
124	2	14	102	0	2011-08-30 17:25:42.913076	2011-08-30 17:25:42.913076
125	2	16	102	0	2011-08-30 17:25:42.916301	2011-08-30 17:25:42.916301
126	2	14	103	0	2011-08-30 17:25:42.92005	2011-08-30 17:25:42.92005
127	2	16	103	0	2011-08-30 17:25:42.923536	2011-08-30 17:25:42.923536
128	2	19	104	0	2011-08-30 17:25:43.092106	2011-08-30 17:25:43.092106
129	2	20	104	0	2011-08-30 17:25:43.094726	2011-08-30 17:25:43.094726
130	2	19	105	0	2011-08-30 17:25:43.097238	2011-08-30 17:25:43.097238
131	2	20	105	0	2011-08-30 17:25:43.099701	2011-08-30 17:25:43.099701
132	2	19	106	0	2011-08-30 17:25:43.102345	2011-08-30 17:25:43.102345
133	2	20	106	0	2011-08-30 17:25:43.104847	2011-08-30 17:25:43.104847
134	2	19	107	0	2011-08-30 17:25:43.107306	2011-08-30 17:25:43.107306
135	2	20	107	0	2011-08-30 17:25:43.10978	2011-08-30 17:25:43.10978
136	2	19	108	0	2011-08-30 17:25:43.112271	2011-08-30 17:25:43.112271
137	2	20	108	0	2011-08-30 17:25:43.114694	2011-08-30 17:25:43.114694
138	2	19	109	0	2011-08-30 17:25:43.117129	2011-08-30 17:25:43.117129
139	2	20	109	0	2011-08-30 17:25:43.119573	2011-08-30 17:25:43.119573
140	2	19	110	0	2011-08-30 17:25:43.122312	2011-08-30 17:25:43.122312
141	2	20	110	0	2011-08-30 17:25:43.12481	2011-08-30 17:25:43.12481
142	2	19	111	0	2011-08-30 17:25:43.127266	2011-08-30 17:25:43.127266
143	2	20	111	0	2011-08-30 17:25:43.129631	2011-08-30 17:25:43.129631
144	2	19	112	0	2011-08-30 17:25:43.132036	2011-08-30 17:25:43.132036
145	2	20	112	0	2011-08-30 17:25:43.134495	2011-08-30 17:25:43.134495
146	2	19	113	0	2011-08-30 17:25:43.136934	2011-08-30 17:25:43.136934
147	2	20	113	0	2011-08-30 17:25:43.139299	2011-08-30 17:25:43.139299
148	2	19	114	0	2011-08-30 17:25:43.141748	2011-08-30 17:25:43.141748
149	2	20	114	0	2011-08-30 17:25:43.144169	2011-08-30 17:25:43.144169
150	2	23	115	0	2011-08-30 17:25:43.214998	2011-08-30 17:25:43.214998
151	2	23	116	0	2011-08-30 17:25:43.217493	2011-08-30 17:25:43.217493
152	2	23	117	0	2011-08-30 17:25:43.21996	2011-08-30 17:25:43.21996
153	2	23	118	0	2011-08-30 17:25:43.222453	2011-08-30 17:25:43.222453
154	2	23	119	0	2011-08-30 17:25:43.224869	2011-08-30 17:25:43.224869
155	2	23	120	0	2011-08-30 17:25:43.227253	2011-08-30 17:25:43.227253
156	2	23	121	0	2011-08-30 17:25:43.229673	2011-08-30 17:25:43.229673
157	2	23	122	0	2011-08-30 17:25:43.232013	2011-08-30 17:25:43.232013
158	2	22	123	0	2011-08-30 17:25:43.400272	2011-08-30 17:25:43.400272
159	2	22	124	0	2011-08-30 17:25:43.402971	2011-08-30 17:25:43.402971
160	2	22	125	0	2011-08-30 17:25:43.405513	2011-08-30 17:25:43.405513
161	2	22	126	0	2011-08-30 17:25:43.407988	2011-08-30 17:25:43.407988
162	2	22	127	0	2011-08-30 17:25:43.410511	2011-08-30 17:25:43.410511
163	2	22	128	0	2011-08-30 17:25:43.413102	2011-08-30 17:25:43.413102
164	2	22	129	0	2011-08-30 17:25:43.415607	2011-08-30 17:25:43.415607
165	2	22	130	0	2011-08-30 17:25:43.418041	2011-08-30 17:25:43.418041
166	2	22	131	0	2011-08-30 17:25:43.42059	2011-08-30 17:25:43.42059
167	2	22	132	0	2011-08-30 17:25:43.422995	2011-08-30 17:25:43.422995
168	2	22	133	0	2011-08-30 17:25:43.425528	2011-08-30 17:25:43.425528
169	2	22	134	0	2011-08-30 17:25:43.427892	2011-08-30 17:25:43.427892
170	2	21	135	0	2011-08-30 17:25:43.573287	2011-08-30 17:25:43.573287
171	2	21	136	0	2011-08-30 17:25:43.575923	2011-08-30 17:25:43.575923
172	2	21	137	0	2011-08-30 17:25:43.578582	2011-08-30 17:25:43.578582
173	2	21	138	0	2011-08-30 17:25:43.581132	2011-08-30 17:25:43.581132
174	2	21	139	0	2011-08-30 17:25:43.583748	2011-08-30 17:25:43.583748
175	2	21	140	0	2011-08-30 17:25:43.586215	2011-08-30 17:25:43.586215
176	2	21	141	0	2011-08-30 17:25:43.588664	2011-08-30 17:25:43.588664
177	2	21	142	0	2011-08-30 17:25:43.591216	2011-08-30 17:25:43.591216
178	2	21	143	0	2011-08-30 17:25:43.593756	2011-08-30 17:25:43.593756
179	2	18	144	0	2011-08-30 17:25:43.647086	2011-08-30 17:25:43.647086
180	2	18	145	0	2011-08-30 17:25:43.649543	2011-08-30 17:25:43.649543
181	2	18	146	0	2011-08-30 17:25:43.651885	2011-08-30 17:25:43.651885
182	2	18	147	0	2011-08-30 17:25:43.654304	2011-08-30 17:25:43.654304
183	2	18	148	0	2011-08-30 17:25:43.65669	2011-08-30 17:25:43.65669
184	2	18	149	0	2011-08-30 17:25:43.659237	2011-08-30 17:25:43.659237
\.


--
-- Data for Name: putoproduits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putoproduits (id, saison_id, pulve_id, produit_id, dosage, dosage_vrai, created_at, updated_at) FROM stdin;
1	1	2	22	2	\N	2011-08-30 17:25:27.403412	2011-08-30 17:25:27.403412
2	1	2	24	99	\N	2011-08-30 17:25:27.408732	2011-08-30 17:25:27.408732
3	1	3	45	250	\N	2011-08-30 17:25:27.415807	2011-08-30 17:25:27.415807
4	1	4	11	99	\N	2011-08-30 17:25:27.423157	2011-08-30 17:25:27.423157
5	1	4	27	99	\N	2011-08-30 17:25:27.425862	2011-08-30 17:25:27.425862
6	1	5	17	1.36359999999999992	\N	2011-08-30 17:25:27.432729	2011-08-30 17:25:27.432729
7	1	6	14	1.81820000000000004	\N	2011-08-30 17:25:27.439663	2011-08-30 17:25:27.439663
8	1	7	36	0.681819999999999982	\N	2011-08-30 17:25:27.446516	2011-08-30 17:25:27.446516
9	1	8	22	2	\N	2011-08-30 17:25:27.490185	2011-08-30 17:25:27.490185
10	1	8	24	99	\N	2011-08-30 17:25:27.492777	2011-08-30 17:25:27.492777
11	1	9	45	250	\N	2011-08-30 17:25:27.49947	2011-08-30 17:25:27.49947
12	1	10	11	99	\N	2011-08-30 17:25:27.509612	2011-08-30 17:25:27.509612
13	1	11	14	4	\N	2011-08-30 17:25:27.516395	2011-08-30 17:25:27.516395
14	1	12	12	3.5	\N	2011-08-30 17:25:27.543482	2011-08-30 17:25:27.543482
15	1	13	18	1.80000000000000004	\N	2011-08-30 17:25:27.616878	2011-08-30 17:25:27.616878
16	1	14	39	2.5	\N	2011-08-30 17:25:27.62436	2011-08-30 17:25:27.62436
17	1	15	20	0.599999999999999978	\N	2011-08-30 17:25:27.631597	2011-08-30 17:25:27.631597
18	1	15	24	1	\N	2011-08-30 17:25:27.634349	2011-08-30 17:25:27.634349
19	1	15	21	0.100000000000000006	\N	2011-08-30 17:25:27.637156	2011-08-30 17:25:27.637156
20	1	16	45	200	\N	2011-08-30 17:25:27.644765	2011-08-30 17:25:27.644765
21	1	17	7	243	\N	2011-08-30 17:25:27.652024	2011-08-30 17:25:27.652024
22	1	18	40	2	\N	2011-08-30 17:25:27.659146	2011-08-30 17:25:27.659146
23	1	19	7	281	\N	2011-08-30 17:25:27.666359	2011-08-30 17:25:27.666359
24	1	20	5	150	\N	2011-08-30 17:25:27.673411	2011-08-30 17:25:27.673411
25	1	21	21	0.100000000000000006	\N	2011-08-30 17:25:27.6806	2011-08-30 17:25:27.6806
26	1	22	16	1.25	\N	2011-08-30 17:25:27.687728	2011-08-30 17:25:27.687728
27	1	22	26	1	\N	2011-08-30 17:25:27.690384	2011-08-30 17:25:27.690384
28	1	23	31	2.5	\N	2011-08-30 17:25:27.697296	2011-08-30 17:25:27.697296
29	1	23	35	0.5	\N	2011-08-30 17:25:27.699959	2011-08-30 17:25:27.699959
30	1	24	42	0.599999999999999978	\N	2011-08-30 17:25:27.706937	2011-08-30 17:25:27.706937
31	1	25	2	0.75	\N	2011-08-30 17:25:27.7143	2011-08-30 17:25:27.7143
32	1	26	12	2	\N	2011-08-30 17:25:27.764576	2011-08-30 17:25:27.764576
33	1	26	29	1.5	\N	2011-08-30 17:25:27.767303	2011-08-30 17:25:27.767303
34	1	27	18	1.80000000000000004	\N	2011-08-30 17:25:27.774612	2011-08-30 17:25:27.774612
35	1	28	39	2.5	\N	2011-08-30 17:25:27.781501	2011-08-30 17:25:27.781501
36	1	29	20	0.599999999999999978	\N	2011-08-30 17:25:27.788299	2011-08-30 17:25:27.788299
37	1	29	24	1	\N	2011-08-30 17:25:27.791009	2011-08-30 17:25:27.791009
38	1	29	21	0.100000000000000006	\N	2011-08-30 17:25:27.860494	2011-08-30 17:25:27.860494
39	1	30	45	200	\N	2011-08-30 17:25:27.868644	2011-08-30 17:25:27.868644
40	1	31	7	243	\N	2011-08-30 17:25:27.876966	2011-08-30 17:25:27.876966
41	1	32	7	280	\N	2011-08-30 17:25:27.884402	2011-08-30 17:25:27.884402
42	1	33	5	150	\N	2011-08-30 17:25:27.891602	2011-08-30 17:25:27.891602
43	1	34	21	0.100000000000000006	\N	2011-08-30 17:25:27.898809	2011-08-30 17:25:27.898809
44	1	35	16	0.713999999999999968	\N	2011-08-30 17:25:27.905905	2011-08-30 17:25:27.905905
45	1	35	26	0.570999999999999952	\N	2011-08-30 17:25:27.90866	2011-08-30 17:25:27.90866
46	1	36	31	2.5	\N	2011-08-30 17:25:27.915686	2011-08-30 17:25:27.915686
47	1	36	35	0.5	\N	2011-08-30 17:25:27.918454	2011-08-30 17:25:27.918454
48	1	37	42	0.599999999999999978	\N	2011-08-30 17:25:27.925481	2011-08-30 17:25:27.925481
49	1	38	2	0.75	\N	2011-08-30 17:25:27.932589	2011-08-30 17:25:27.932589
50	1	39	22	5	\N	2011-08-30 17:25:27.980518	2011-08-30 17:25:27.980518
51	1	40	38	90	\N	2011-08-30 17:25:27.987393	2011-08-30 17:25:27.987393
52	1	40	33	90	\N	2011-08-30 17:25:27.990022	2011-08-30 17:25:27.990022
53	1	41	41	153	\N	2011-08-30 17:25:27.996989	2011-08-30 17:25:27.996989
54	1	42	7	200	\N	2011-08-30 17:25:28.004141	2011-08-30 17:25:28.004141
55	1	43	7	237	\N	2011-08-30 17:25:28.011374	2011-08-30 17:25:28.011374
56	1	44	5	100	\N	2011-08-30 17:25:28.018469	2011-08-30 17:25:28.018469
57	1	45	37	275	\N	2011-08-30 17:25:28.025302	2011-08-30 17:25:28.025302
58	1	46	34	1	\N	2011-08-30 17:25:28.032109	2011-08-30 17:25:28.032109
59	1	47	44	0.5	\N	2011-08-30 17:25:28.038887	2011-08-30 17:25:28.038887
60	1	47	24	1	\N	2011-08-30 17:25:28.041573	2011-08-30 17:25:28.041573
61	1	48	9	1.39999999999999991	\N	2011-08-30 17:25:28.115553	2011-08-30 17:25:28.115553
62	1	49	3	3	\N	2011-08-30 17:25:28.123173	2011-08-30 17:25:28.123173
63	1	50	22	2	\N	2011-08-30 17:25:28.167645	2011-08-30 17:25:28.167645
64	1	50	15	0.599999999999999978	\N	2011-08-30 17:25:28.170299	2011-08-30 17:25:28.170299
65	1	51	33	87.5	\N	2011-08-30 17:25:28.177434	2011-08-30 17:25:28.177434
66	1	51	30	87.5	\N	2011-08-30 17:25:28.180094	2011-08-30 17:25:28.180094
67	1	52	41	153	\N	2011-08-30 17:25:28.189528	2011-08-30 17:25:28.189528
68	1	53	7	200	\N	2011-08-30 17:25:28.198526	2011-08-30 17:25:28.198526
69	1	54	37	275	\N	2011-08-30 17:25:28.206136	2011-08-30 17:25:28.206136
70	1	54	24	1	\N	2011-08-30 17:25:28.208955	2011-08-30 17:25:28.208955
71	1	55	7	237	\N	2011-08-30 17:25:28.215787	2011-08-30 17:25:28.215787
72	1	56	5	100	\N	2011-08-30 17:25:28.22264	2011-08-30 17:25:28.22264
73	1	57	34	1	\N	2011-08-30 17:25:28.229564	2011-08-30 17:25:28.229564
74	1	58	43	0.710999999999999965	\N	2011-08-30 17:25:28.236527	2011-08-30 17:25:28.236527
75	1	58	44	0.203600000000000003	\N	2011-08-30 17:25:28.239228	2011-08-30 17:25:28.239228
76	1	58	24	1	\N	2011-08-30 17:25:28.241898	2011-08-30 17:25:28.241898
77	1	59	8	1.39999999999999991	\N	2011-08-30 17:25:28.248748	2011-08-30 17:25:28.248748
78	1	60	22	2	\N	2011-08-30 17:25:28.290155	2011-08-30 17:25:28.290155
79	1	60	15	0.599999999999999978	\N	2011-08-30 17:25:28.293183	2011-08-30 17:25:28.293183
80	1	61	33	55	\N	2011-08-30 17:25:28.367602	2011-08-30 17:25:28.367602
81	1	61	30	55	\N	2011-08-30 17:25:28.370912	2011-08-30 17:25:28.370912
82	1	61	1	55	\N	2011-08-30 17:25:28.373818	2011-08-30 17:25:28.373818
83	1	62	41	153	\N	2011-08-30 17:25:28.381257	2011-08-30 17:25:28.381257
84	1	63	7	200	\N	2011-08-30 17:25:28.388507	2011-08-30 17:25:28.388507
85	1	64	7	237	\N	2011-08-30 17:25:28.395613	2011-08-30 17:25:28.395613
86	1	65	5	100	\N	2011-08-30 17:25:28.402823	2011-08-30 17:25:28.402823
87	1	66	37	275	\N	2011-08-30 17:25:28.410015	2011-08-30 17:25:28.410015
88	1	66	24	1	\N	2011-08-30 17:25:28.412725	2011-08-30 17:25:28.412725
89	1	67	34	1	\N	2011-08-30 17:25:28.419859	2011-08-30 17:25:28.419859
90	1	68	44	0.25	\N	2011-08-30 17:25:28.42696	2011-08-30 17:25:28.42696
91	1	68	24	0.5	\N	2011-08-30 17:25:28.42965	2011-08-30 17:25:28.42965
92	1	69	8	1.39999999999999991	\N	2011-08-30 17:25:28.436685	2011-08-30 17:25:28.436685
93	1	70	22	2	\N	2011-08-30 17:25:28.476957	2011-08-30 17:25:28.476957
94	1	70	15	0.599999999999999978	\N	2011-08-30 17:25:28.479525	2011-08-30 17:25:28.479525
95	1	71	38	85.5	\N	2011-08-30 17:25:28.486682	2011-08-30 17:25:28.486682
96	1	71	30	85.5	\N	2011-08-30 17:25:28.489304	2011-08-30 17:25:28.489304
97	1	72	41	153	\N	2011-08-30 17:25:28.495974	2011-08-30 17:25:28.495974
98	1	73	7	200	\N	2011-08-30 17:25:28.502896	2011-08-30 17:25:28.502896
99	1	74	37	275	\N	2011-08-30 17:25:28.510335	2011-08-30 17:25:28.510335
100	1	74	24	1	\N	2011-08-30 17:25:28.513901	2011-08-30 17:25:28.513901
101	1	75	7	237	\N	2011-08-30 17:25:28.524245	2011-08-30 17:25:28.524245
102	1	76	5	100	\N	2011-08-30 17:25:28.531875	2011-08-30 17:25:28.531875
103	1	77	34	1	\N	2011-08-30 17:25:28.539176	2011-08-30 17:25:28.539176
104	1	78	8	1.39999999999999991	\N	2011-08-30 17:25:28.546081	2011-08-30 17:25:28.546081
105	2	79	52	3.5	\N	2011-08-30 17:25:42.430033	2011-08-30 17:25:42.430033
106	2	79	58	3.5	\N	2011-08-30 17:25:42.435224	2011-08-30 17:25:42.435224
107	2	80	59	2.20000000000000018	\N	2011-08-30 17:25:42.442233	2011-08-30 17:25:42.442233
108	2	81	70	1.80000000000000004	\N	2011-08-30 17:25:42.448918	2011-08-30 17:25:42.448918
109	2	82	63	0.599999999999999978	\N	2011-08-30 17:25:42.455709	2011-08-30 17:25:42.455709
110	2	83	65	0.100000000000000006	\N	2011-08-30 17:25:42.462777	2011-08-30 17:25:42.462777
111	2	84	80	200	\N	2011-08-30 17:25:42.469735	2011-08-30 17:25:42.469735
112	2	85	48	195	\N	2011-08-30 17:25:42.476453	2011-08-30 17:25:42.476453
113	2	86	48	230	\N	2011-08-30 17:25:42.483277	2011-08-30 17:25:42.483277
114	2	87	49	150	\N	2011-08-30 17:25:42.490815	2011-08-30 17:25:42.490815
115	2	88	65	0.100000000000000006	\N	2011-08-30 17:25:42.497654	2011-08-30 17:25:42.497654
116	2	89	71	0.5	\N	2011-08-30 17:25:42.568495	2011-08-30 17:25:42.568495
117	2	90	75	0.599999999999999978	\N	2011-08-30 17:25:42.575815	2011-08-30 17:25:42.575815
118	2	91	47	0.75	\N	2011-08-30 17:25:42.583054	2011-08-30 17:25:42.583054
119	2	92	66	3	\N	2011-08-30 17:25:42.702962	2011-08-30 17:25:42.702962
120	2	93	52	3	\N	2011-08-30 17:25:42.709506	2011-08-30 17:25:42.709506
121	2	94	56	1.04000000000000004	\N	2011-08-30 17:25:42.71624	2011-08-30 17:25:42.71624
122	2	95	63	0.599999999999999978	\N	2011-08-30 17:25:42.723722	2011-08-30 17:25:42.723722
123	2	96	65	0.100000000000000006	\N	2011-08-30 17:25:42.792971	2011-08-30 17:25:42.792971
124	2	97	80	200	\N	2011-08-30 17:25:42.80114	2011-08-30 17:25:42.80114
125	2	98	48	255	\N	2011-08-30 17:25:42.808486	2011-08-30 17:25:42.808486
126	2	99	50	150	\N	2011-08-30 17:25:42.815701	2011-08-30 17:25:42.815701
127	2	100	65	0.100000000000000006	\N	2011-08-30 17:25:42.822848	2011-08-30 17:25:42.822848
128	2	101	71	0.5	\N	2011-08-30 17:25:42.829977	2011-08-30 17:25:42.829977
129	2	102	75	0.599999999999999978	\N	2011-08-30 17:25:42.837103	2011-08-30 17:25:42.837103
130	2	103	47	0.75	\N	2011-08-30 17:25:42.84399	2011-08-30 17:25:42.84399
131	2	104	52	3	\N	2011-08-30 17:25:42.942505	2011-08-30 17:25:42.942505
132	2	105	53	2	\N	2011-08-30 17:25:42.949809	2011-08-30 17:25:42.949809
133	2	105	68	2	\N	2011-08-30 17:25:42.952669	2011-08-30 17:25:42.952669
134	2	106	74	80	\N	2011-08-30 17:25:42.959588	2011-08-30 17:25:42.959588
135	2	106	67	25	\N	2011-08-30 17:25:42.96233	2011-08-30 17:25:42.96233
136	2	107	79	157	\N	2011-08-30 17:25:42.968951	2011-08-30 17:25:42.968951
137	2	108	48	195	\N	2011-08-30 17:25:42.975788	2011-08-30 17:25:42.975788
138	2	109	48	183	\N	2011-08-30 17:25:42.98307	2011-08-30 17:25:42.98307
139	2	110	55	0.5	\N	2011-08-30 17:25:42.990041	2011-08-30 17:25:42.990041
140	2	111	72	1	\N	2011-08-30 17:25:43.06318	2011-08-30 17:25:43.06318
141	2	112	77	1	\N	2011-08-30 17:25:43.070728	2011-08-30 17:25:43.070728
142	2	112	76	0.900000000000000022	\N	2011-08-30 17:25:43.073494	2011-08-30 17:25:43.073494
143	2	113	48	120	\N	2011-08-30 17:25:43.080643	2011-08-30 17:25:43.080643
144	2	114	57	120	\N	2011-08-30 17:25:43.087726	2011-08-30 17:25:43.087726
145	2	115	51	180	\N	2011-08-30 17:25:43.161949	2011-08-30 17:25:43.161949
146	2	116	79	157	\N	2011-08-30 17:25:43.168642	2011-08-30 17:25:43.168642
147	2	117	48	210	\N	2011-08-30 17:25:43.175361	2011-08-30 17:25:43.175361
148	2	118	48	200	\N	2011-08-30 17:25:43.182169	2011-08-30 17:25:43.182169
149	2	119	60	0.275000000000000022	\N	2011-08-30 17:25:43.188718	2011-08-30 17:25:43.188718
150	2	120	73	1	\N	2011-08-30 17:25:43.195579	2011-08-30 17:25:43.195579
151	2	121	62	1	\N	2011-08-30 17:25:43.202321	2011-08-30 17:25:43.202321
152	2	121	76	0.900000000000000022	\N	2011-08-30 17:25:43.204858	2011-08-30 17:25:43.204858
153	2	122	61	1.39999999999999991	\N	2011-08-30 17:25:43.211386	2011-08-30 17:25:43.211386
154	2	123	64	170	\N	2011-08-30 17:25:43.313454	2011-08-30 17:25:43.313454
155	2	124	53	2	\N	2011-08-30 17:25:43.320906	2011-08-30 17:25:43.320906
156	2	124	68	2	\N	2011-08-30 17:25:43.32387	2011-08-30 17:25:43.32387
157	2	125	67	25	\N	2011-08-30 17:25:43.330954	2011-08-30 17:25:43.330954
158	2	125	74	80	\N	2011-08-30 17:25:43.333735	2011-08-30 17:25:43.333735
159	2	126	79	157	\N	2011-08-30 17:25:43.340908	2011-08-30 17:25:43.340908
160	2	127	48	210	\N	2011-08-30 17:25:43.348043	2011-08-30 17:25:43.348043
161	2	128	48	206	\N	2011-08-30 17:25:43.354887	2011-08-30 17:25:43.354887
162	2	129	60	0.275000000000000022	\N	2011-08-30 17:25:43.361908	2011-08-30 17:25:43.361908
163	2	130	55	0.5	\N	2011-08-30 17:25:43.368882	2011-08-30 17:25:43.368882
164	2	131	73	1	\N	2011-08-30 17:25:43.375852	2011-08-30 17:25:43.375852
165	2	132	61	1.39999999999999991	\N	2011-08-30 17:25:43.3827	2011-08-30 17:25:43.3827
166	2	133	48	120	\N	2011-08-30 17:25:43.389473	2011-08-30 17:25:43.389473
167	2	134	57	1	\N	2011-08-30 17:25:43.396541	2011-08-30 17:25:43.396541
168	2	135	51	170	\N	2011-08-30 17:25:43.442865	2011-08-30 17:25:43.442865
169	2	136	53	2	\N	2011-08-30 17:25:43.449587	2011-08-30 17:25:43.449587
170	2	136	68	2	\N	2011-08-30 17:25:43.452139	2011-08-30 17:25:43.452139
171	2	137	79	157	\N	2011-08-30 17:25:43.458821	2011-08-30 17:25:43.458821
172	2	138	48	200	\N	2011-08-30 17:25:43.465592	2011-08-30 17:25:43.465592
173	2	139	48	200	\N	2011-08-30 17:25:43.472302	2011-08-30 17:25:43.472302
174	2	140	62	1	\N	2011-08-30 17:25:43.479035	2011-08-30 17:25:43.479035
175	2	140	76	0.900000000000000022	\N	2011-08-30 17:25:43.481632	2011-08-30 17:25:43.481632
176	2	141	61	1.39999999999999991	\N	2011-08-30 17:25:43.554541	2011-08-30 17:25:43.554541
177	2	142	48	120	\N	2011-08-30 17:25:43.562209	2011-08-30 17:25:43.562209
178	2	143	57	1	\N	2011-08-30 17:25:43.569548	2011-08-30 17:25:43.569548
179	2	144	66	2	\N	2011-08-30 17:25:43.609283	2011-08-30 17:25:43.609283
180	2	145	81	250	\N	2011-08-30 17:25:43.616252	2011-08-30 17:25:43.616252
181	2	146	66	2	\N	2011-08-30 17:25:43.622921	2011-08-30 17:25:43.622921
182	2	147	69	170	\N	2011-08-30 17:25:43.629809	2011-08-30 17:25:43.629809
183	2	148	54	3.5	\N	2011-08-30 17:25:43.636658	2011-08-30 17:25:43.636658
184	2	149	48	107	\N	2011-08-30 17:25:43.643498	2011-08-30 17:25:43.643498
\.


--
-- Data for Name: saisons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY saisons (id, name, year, "desc") FROM stdin;
1	2010/2011	2010	\N
2	2009/2010	2009	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY schema_migrations (version) FROM stdin;
20100330165713
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY settings (id, saison_id, value_parcelle, detail_desc, detail_ref, float_precision, text_area_size) FROM stdin;
1	1	0	0	0	1	25x6
\.


--
-- Data for Name: typecultures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY typecultures (id, name) FROM stdin;
1	Ble
2	2eme Ble
3	Tournesol
4	Colza
5	Jachere
6	Luzerne
\.


--
-- Data for Name: upcategories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY upcategories (id, name, created_at, updated_at) FROM stdin;
1	facture	2011-08-30 17:25:22.762725	2011-08-30 17:25:22.762725
2	pulve	2011-08-30 17:25:22.768476	2011-08-30 17:25:22.768476
3	labour	2011-08-30 17:25:22.77069	2011-08-30 17:25:22.77069
4	vente	2011-08-30 17:25:22.772838	2011-08-30 17:25:22.772838
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, name, created_at, updated_at) FROM stdin;
1	Jouve	2011-08-30 17:25:22.964374	2011-08-30 17:25:22.964374
2	Trochet	2011-08-30 17:25:22.969608	2011-08-30 17:25:22.969608
3	Dauger	2011-08-30 17:25:22.971932	2011-08-30 17:25:22.971932
4	Raffault	2011-08-30 17:25:22.974104	2011-08-30 17:25:22.974104
5	C le Mobile	2011-08-30 17:25:22.976221	2011-08-30 17:25:22.976221
6	Credit Agricole Assurances	2011-08-30 17:25:22.9786	2011-08-30 17:25:22.9786
7	Bastard	2011-08-30 17:25:22.981358	2011-08-30 17:25:22.981358
8	Daugeron Garage	2011-08-30 17:25:22.983595	2011-08-30 17:25:22.983595
9	Communaute de communes	2011-08-30 17:25:22.986072	2011-08-30 17:25:22.986072
10	SIAEP de l'Igneraie	2011-08-30 17:25:22.988164	2011-08-30 17:25:22.988164
11	France Telecom	2011-08-30 17:25:22.990203	2011-08-30 17:25:22.990203
12	Dechansiaud	2011-08-30 17:25:22.992655	2011-08-30 17:25:22.992655
13	Renaud	2011-08-30 17:25:22.995158	2011-08-30 17:25:22.995158
14	EDF	2011-08-30 17:25:22.997264	2011-08-30 17:25:22.997264
15	Compta Centre	2011-08-30 17:25:22.999319	2011-08-30 17:25:22.999319
16	Pneu Europe Service	2011-08-30 17:25:23.001528	2011-08-30 17:25:23.001528
17	Sodibe	2011-08-30 17:25:23.003641	2011-08-30 17:25:23.003641
18	Lapeyre	2011-08-30 17:25:23.00574	2011-08-30 17:25:23.00574
19	Seelec	2011-08-30 17:25:23.007783	2011-08-30 17:25:23.007783
20	Denormandie Jardinerie	2011-08-30 17:25:23.010051	2011-08-30 17:25:23.010051
21	MSA	2011-08-30 17:25:23.012255	2011-08-30 17:25:23.012255
22	Agro-Service	2011-08-30 17:25:23.014332	2011-08-30 17:25:23.014332
23	CBM	2011-08-30 17:25:23.016363	2011-08-30 17:25:23.016363
24	Super U	2011-08-30 17:25:23.01843	2011-08-30 17:25:23.01843
25	DDA	2011-08-30 17:25:23.020464	2011-08-30 17:25:23.020464
26	PAC	2011-08-30 17:25:23.022605	2011-08-30 17:25:23.022605
27	Charrier	2011-08-30 17:25:23.025351	2011-08-30 17:25:23.025351
28	La Poste	2011-08-30 17:25:23.027615	2011-08-30 17:25:23.027615
29	Brico Depot	2011-08-30 17:25:23.029668	2011-08-30 17:25:23.029668
30	divers	2011-08-30 17:25:23.0319	2011-08-30 17:25:23.0319
31	Bricomarche	2011-08-30 17:25:23.033955	2011-08-30 17:25:23.033955
32	Aucun	2011-08-30 17:25:23.036013	2011-08-30 17:25:23.036013
\.


--
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ventes (id, category_id, saison_id, prix, date, user_id, name, ref, ref_client, star, adu, "desc", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ventoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ventoparcelles (id, saison_id, vente_id, parcelle_id, value) FROM stdin;
\.


--
-- Data for Name: verifs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY verifs (id, name) FROM stdin;
\.


--
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY zones (id, name, surface, created_at, updated_at) FROM stdin;
1	Bruneau	14	2011-08-30 17:25:23.059143	2011-08-30 17:25:23.059143
2	Mitant	5	2011-08-30 17:25:23.064431	2011-08-30 17:25:23.064431
3	La Rue	46.5499999999999972	2011-08-30 17:25:23.066755	2011-08-30 17:25:23.066755
4	Basse-cour	2	2011-08-30 17:25:23.068973	2011-08-30 17:25:23.068973
5	Vallees	11	2011-08-30 17:25:23.071182	2011-08-30 17:25:23.071182
6	Guiberons	2.5	2011-08-30 17:25:23.07382	2011-08-30 17:25:23.07382
7	La cote	2	2011-08-30 17:25:23.076559	2011-08-30 17:25:23.076559
8	Feuillets	16	2011-08-30 17:25:23.079333	2011-08-30 17:25:23.079333
9	Brandes	2.9700000000000002	2011-08-30 17:25:23.081831	2011-08-30 17:25:23.081831
10	Taillis	19.3200000000000003	2011-08-30 17:25:23.084205	2011-08-30 17:25:23.084205
11	Varennes	15.8599999999999994	2011-08-30 17:25:23.08661	2011-08-30 17:25:23.08661
12	Patureaux	8.86999999999999922	2011-08-30 17:25:23.088876	2011-08-30 17:25:23.088876
13	Prairie Chevaux	13.2599999999999998	2011-08-30 17:25:23.091216	2011-08-30 17:25:23.091216
14	Sous l'eglise	1.35000000000000009	2011-08-30 17:25:23.155188	2011-08-30 17:25:23.155188
15	Reserve	2.54999999999999982	2011-08-30 17:25:23.158153	2011-08-30 17:25:23.158153
16	Lavernier	0.75	2011-08-30 17:25:23.160735	2011-08-30 17:25:23.160735
17	Le Bourg-1	0.520000000000000018	2011-08-30 17:25:23.163321	2011-08-30 17:25:23.163321
\.


--
-- Data for Name: zonetopas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY zonetopas (id, saison_id, parcelle_id, zone_id, value, created_at, updated_at) FROM stdin;
1	1	1	1	14	2011-08-30 17:25:26.952733	2011-08-30 17:25:26.952733
2	1	2	2	5	2011-08-30 17:25:26.962017	2011-08-30 17:25:26.962017
3	1	3	8	5	2011-08-30 17:25:26.969281	2011-08-30 17:25:26.969281
4	1	4	8	4	2011-08-30 17:25:26.975563	2011-08-30 17:25:26.975563
5	1	5	8	7	2011-08-30 17:25:26.981947	2011-08-30 17:25:26.981947
6	1	6	3	10	2011-08-30 17:25:26.988837	2011-08-30 17:25:26.988837
7	1	7	3	14	2011-08-30 17:25:26.994981	2011-08-30 17:25:26.994981
8	1	8	3	14	2011-08-30 17:25:27.001357	2011-08-30 17:25:27.001357
9	1	9	3	9	2011-08-30 17:25:27.007908	2011-08-30 17:25:27.007908
10	1	10	4	2	2011-08-30 17:25:27.015205	2011-08-30 17:25:27.015205
11	1	11	5	11	2011-08-30 17:25:27.022424	2011-08-30 17:25:27.022424
12	2	12	1	14	2011-08-30 17:25:42.111396	2011-08-30 17:25:42.111396
13	2	13	2	5	2011-08-30 17:25:42.120697	2011-08-30 17:25:42.120697
14	2	14	8	5	2011-08-30 17:25:42.127783	2011-08-30 17:25:42.127783
15	2	15	8	4	2011-08-30 17:25:42.134146	2011-08-30 17:25:42.134146
16	2	16	8	7	2011-08-30 17:25:42.140339	2011-08-30 17:25:42.140339
17	2	17	3	10	2011-08-30 17:25:42.147152	2011-08-30 17:25:42.147152
18	2	18	3	13.5500000000000007	2011-08-30 17:25:42.153457	2011-08-30 17:25:42.153457
19	2	19	3	14	2011-08-30 17:25:42.159933	2011-08-30 17:25:42.159933
20	2	20	3	9	2011-08-30 17:25:42.166524	2011-08-30 17:25:42.166524
21	2	21	4	2	2011-08-30 17:25:42.173945	2011-08-30 17:25:42.173945
22	2	22	5	11	2011-08-30 17:25:42.181887	2011-08-30 17:25:42.181887
23	2	22	7	2	2011-08-30 17:25:42.184505	2011-08-30 17:25:42.184505
24	2	23	6	2.5	2011-08-30 17:25:42.191274	2011-08-30 17:25:42.191274
\.


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: facdivs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY facdivs
    ADD CONSTRAINT facdivs_pkey PRIMARY KEY (id);


--
-- Name: factcats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factcats
    ADD CONSTRAINT factcats_pkey PRIMARY KEY (id);


--
-- Name: factoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factoparcelles
    ADD CONSTRAINT factoparcelles_pkey PRIMARY KEY (id);


--
-- Name: factures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factures
    ADD CONSTRAINT factures_pkey PRIMARY KEY (id);


--
-- Name: factypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factypes
    ADD CONSTRAINT factypes_pkey PRIMARY KEY (id);


--
-- Name: labours_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labours
    ADD CONSTRAINT labours_pkey PRIMARY KEY (id);


--
-- Name: labtofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labtofactures
    ADD CONSTRAINT labtofactures_pkey PRIMARY KEY (id);


--
-- Name: labtoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labtoparcelles
    ADD CONSTRAINT labtoparcelles_pkey PRIMARY KEY (id);


--
-- Name: myusers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY myusers
    ADD CONSTRAINT myusers_pkey PRIMARY KEY (id);


--
-- Name: parcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parcelles
    ADD CONSTRAINT parcelles_pkey PRIMARY KEY (id);


--
-- Name: produits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);


--
-- Name: protofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY protofactures
    ADD CONSTRAINT protofactures_pkey PRIMARY KEY (id);


--
-- Name: pulves_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pulves
    ADD CONSTRAINT pulves_pkey PRIMARY KEY (id);


--
-- Name: putofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putofactures
    ADD CONSTRAINT putofactures_pkey PRIMARY KEY (id);


--
-- Name: putoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putoparcelles
    ADD CONSTRAINT putoparcelles_pkey PRIMARY KEY (id);


--
-- Name: putoproduits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putoproduits
    ADD CONSTRAINT putoproduits_pkey PRIMARY KEY (id);


--
-- Name: saisons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY saisons
    ADD CONSTRAINT saisons_pkey PRIMARY KEY (id);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: typecultures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY typecultures
    ADD CONSTRAINT typecultures_pkey PRIMARY KEY (id);


--
-- Name: upcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY upcategories
    ADD CONSTRAINT upcategories_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id);


--
-- Name: ventoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ventoparcelles
    ADD CONSTRAINT ventoparcelles_pkey PRIMARY KEY (id);


--
-- Name: verifs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY verifs
    ADD CONSTRAINT verifs_pkey PRIMARY KEY (id);


--
-- Name: zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: zonetopas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY zonetopas
    ADD CONSTRAINT zonetopas_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

