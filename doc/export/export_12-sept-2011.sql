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

SELECT pg_catalog.setval('categories_id_seq', 25, true);


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

SELECT pg_catalog.setval('factures_id_seq', 45, true);


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

SELECT pg_catalog.setval('labours_id_seq', 7, true);


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

SELECT pg_catalog.setval('labtofactures_id_seq', 7, true);


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

SELECT pg_catalog.setval('labtoparcelles_id_seq', 21, true);


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

SELECT pg_catalog.setval('parcelles_id_seq', 11, true);


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

SELECT pg_catalog.setval('produits_id_seq', 49, true);


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

SELECT pg_catalog.setval('protofactures_id_seq', 54, true);


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

SELECT pg_catalog.setval('pulves_id_seq', 77, true);


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

SELECT pg_catalog.setval('putoparcelles_id_seq', 77, true);


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
    "desc" character varying(255),
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

SELECT pg_catalog.setval('putoproduits_id_seq', 89, true);


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

SELECT pg_catalog.setval('saisons_id_seq', 1, true);


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

SELECT pg_catalog.setval('users_id_seq', 34, true);


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
    saison_id integer NOT NULL,
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

SELECT pg_catalog.setval('zonetopas_id_seq', 11, true);


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
1	1	frais generaux	2011-09-12 16:53:25.006167	2011-09-12 16:53:25.006167
2	1	produits phyto	2011-09-12 16:53:25.011413	2011-09-12 16:53:25.011413
3	1	semences	2011-09-12 16:53:25.013994	2011-09-12 16:53:25.013994
4	1	mecanique	2011-09-12 16:53:25.016362	2011-09-12 16:53:25.016362
5	1	batiments	2011-09-12 16:53:25.019293	2011-09-12 16:53:25.019293
6	1	deplacement	2011-09-12 16:53:25.021781	2011-09-12 16:53:25.021781
7	1	frais de gestion	2011-09-12 16:53:25.024154	2011-09-12 16:53:25.024154
8	1	service agricole	2011-09-12 16:53:25.026439	2011-09-12 16:53:25.026439
9	2	divers	2011-09-12 16:53:25.028768	2011-09-12 16:53:25.028768
10	2	azote	2011-09-12 16:53:25.031094	2011-09-12 16:53:25.031094
11	2	desherbant	2011-09-12 16:53:25.033331	2011-09-12 16:53:25.033331
12	2	engrais	2011-09-12 16:53:25.03556	2011-09-12 16:53:25.03556
13	2	fongicide	2011-09-12 16:53:25.037802	2011-09-12 16:53:25.037802
14	2	herbicide	2011-09-12 16:53:25.040186	2011-09-12 16:53:25.040186
15	2	insecticide	2011-09-12 16:53:25.042375	2011-09-12 16:53:25.042375
16	2	oligo	2011-09-12 16:53:25.044629	2011-09-12 16:53:25.044629
17	2	semis	2011-09-12 16:53:25.046812	2011-09-12 16:53:25.046812
18	2	soufre	2011-09-12 16:53:25.049002	2011-09-12 16:53:25.049002
19	3	moisson	2011-09-12 16:53:25.051493	2011-09-12 16:53:25.051493
20	3	covercrop	2011-09-12 16:53:25.053816	2011-09-12 16:53:25.053816
21	3	vibro	2011-09-12 16:53:25.055994	2011-09-12 16:53:25.055994
22	3	herse	2011-09-12 16:53:25.058227	2011-09-12 16:53:25.058227
23	4	foin	2011-09-12 16:53:25.060471	2011-09-12 16:53:25.060471
24	4	PAC	2011-09-12 16:53:25.062662	2011-09-12 16:53:25.062662
25	4	Avoir	2011-09-12 16:53:25.064852	2011-09-12 16:53:25.064852
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
1	agri	\N	2011-09-12 16:53:25.071692	2011-09-12 16:53:25.071692
2	maison	\N	2011-09-12 16:53:25.076647	2011-09-12 16:53:25.076647
3	invest	\N	2011-09-12 16:53:25.078914	2011-09-12 16:53:25.078914
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
1	1	2	1	1	\N	Debit	0	\N	2010-11-30	3	Sacs B.B Adivalor	2.5	01-2010-1187	1	1 sac big bag	2011-09-12 16:53:35.054026	2011-09-12 16:53:35.054026
2	1	2	1	1	\N	Debit	0	\N	2011-01-21	3	Super 45% BB	3069	01-2010-1429	2		2011-09-12 16:53:35.062528	2011-09-12 16:53:35.062528
3	1	2	1	1	\N	Debit	0	\N	2011-01-24	3	engrais 0-20-30	1260.79999999999995	01-2011-1448	3		2011-09-12 16:53:35.078723	2011-09-12 16:53:35.078723
4	1	2	1	1	\N	Debit	0	\N	2011-04-30	3	Sacs B.B Adivalor	5	01-2010-2593	4	2 sac big bag	2011-09-12 16:53:35.087344	2011-09-12 16:53:35.087344
5	1	2	1	1	\N	Debit	0	\N	2011-03-29	3	engrais 0-20-30	2000	01-2010-1982	5		2011-09-12 16:53:35.093008	2011-09-12 16:53:35.093008
6	1	2	1	1	\N	Debit	1	\N	2011-03-11	3	Semance Campus	994	01-2010-1767	6		2011-09-12 16:53:35.101499	2011-09-12 16:53:35.101499
7	1	2	1	1	\N	Debit	1	\N	2011-03-11	3	produits phyto 1	4402.19999999999982	01-2010-1767	7	pas de prix HT. Verifier la somme.	2011-09-12 16:53:35.109527	2011-09-12 16:53:35.109527
8	1	2	1	1	\N	Debit	0	\N	2011-02-28	3	azomag	1680	01-2010-1737	8	azomag 16 BB	2011-09-12 16:53:35.138385	2011-09-12 16:53:35.138385
9	1	2	1	1	\N	Debit	0	\N	2011-04-30	3	produits phyto 2	1654	01-2010-2594	9	avoir de 2% sous condition	2011-09-12 16:53:35.14639	2011-09-12 16:53:35.14639
10	1	2	1	1	\N	Debit	0	\N	2011-03-11	3	produits phyto 3	6314.35000000000036	01-2010-1767	10	avoir de 2% + 3% sauf glifonet -0,30€	2011-09-12 16:53:35.167282	2011-09-12 16:53:35.167282
11	1	2	1	1	\N	Debit	1	\N	2010-08-31	3	Ammonitrate	9204	01-2010-250	11	voire indications manuscrites sur la facture	2011-09-12 16:53:35.199927	2011-09-12 16:53:35.199927
12	1	2	1	1	\N	Debit	1	\N	2010-10-31	3	produits phyto 4	998.990000000000009	01-2010-975	12	avoir de 13,25 à prendre en compte	2011-09-12 16:53:35.210691	2011-09-12 16:53:35.210691
13	1	2	1	1	\N	Debit	0	\N	2010-09-27	3	produits phyto 5	4907.39999999999964	01-2010-471	13		2011-09-12 16:53:35.295196	2011-09-12 16:53:35.295196
14	1	2	1	1	\N	Debit	0	\N	2010-09-30	3	produits phyto 6	246	01-2010-689	14		2011-09-12 16:53:35.309502	2011-09-12 16:53:35.309502
15	1	2	1	1	\N	Debit	0	\N	2010-10-20	13	vitavax + BB	746.580000000000041	22269	15	vitavax + Big BagsBB : 8x9,41=75,24€ à répartir	2011-09-12 16:53:35.323897	2011-09-12 16:53:35.323897
16	1	2	1	1	\N	Debit	0	\N	2011-03-31	31	Fury 5L	163.699999999999989	FCT-1305	16		2011-09-12 16:53:35.329502	2011-09-12 16:53:35.329502
17	1	2	1	1	\N	Debit	1	\N	2011-02-28	13	Picabore + Challenge	1221.80999999999995	24302	17		2011-09-12 16:53:35.338221	2011-09-12 16:53:35.338221
18	1	2	1	1	\N	Debit	0	\N	2011-06-28	31	produits phyto 7	389.899999999999977	FCC-1629	18	produits + Bib Bag 1,50x1,60 : 10x10=100€ a répartir	2011-09-12 16:53:35.352407	2011-09-12 16:53:35.352407
19	1	2	1	1	\N	Debit	0	\N	2010-07-10	31	nuvagrain	51.259999999999998	FCC-44	19		2011-09-12 16:53:35.36369	2011-09-12 16:53:35.36369
20	1	8	1	1	\N	Debit	1	\N	2011-03-27	32	semis tournesol	260	015-2011	20	20ha x 13€/ha = 260€	2011-09-12 16:53:35.372491	2011-09-12 16:53:35.372491
21	1	2	1	1	\N	Debit	1	\N	2011-02-28	3	PRODUITS MANQUANTS	1221.80999999999995	0000	21		2011-09-12 16:53:35.37791	2011-09-12 16:53:35.37791
22	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 19	3537.5	19	21		2011-09-12 16:53:35.398044	2011-09-12 16:53:35.398044
23	1	8	1	1	22	Report	0	\N	2011-01-30	2	Pulvérisation	955	19	21	95,5Ha x 10€ = 955€	2011-09-12 16:53:35.411861	2011-09-12 16:53:35.411861
24	1	8	1	1	22	Report	0	\N	2011-01-30	2	Broyage haies	456	19	21	12h x 38€ = 456€	2011-09-12 16:53:35.419853	2011-09-12 16:53:35.419853
25	1	8	1	1	22	Report	0	\N	2011-01-30	2	Broyage horizontal	297.5	19	21	8h50 x 35€/h = 297,5	2011-09-12 16:53:35.425534	2011-09-12 16:53:35.425534
26	1	8	1	1	22	Report	0	\N	2011-01-30	2	Semis Colza et Blé	1829	19	21	59ha x 31€/ha = 1829€	2011-09-12 16:53:35.431123	2011-09-12 16:53:35.431123
27	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 18	3515	18	22		2011-09-12 16:53:35.436652	2011-09-12 16:53:35.436652
28	1	8	1	1	27	Report	0	\N	2011-01-30	2	Roulage	465	18	22	15h30 x 30€/h = 465€	2011-09-12 16:53:35.442018	2011-09-12 16:53:35.442018
29	1	8	1	1	27	Report	0	\N	2011-01-30	2	Cover-crop	2240	18	22	64h x 35€/h = 2240€	2011-09-12 16:53:35.447934	2011-09-12 16:53:35.447934
30	1	8	1	1	27	Report	0	\N	2011-01-30	2	Vibro	810	18	22	81ha x 10€ = 810€	2011-09-12 16:53:35.453786	2011-09-12 16:53:35.453786
31	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 20	2950	20	23		2011-09-12 16:53:35.459567	2011-09-12 16:53:35.459567
32	1	8	1	1	31	Report	0	\N	2011-01-30	2	Labour + Herse	2830	20	23	(semis prairies)	2011-09-12 16:53:35.465556	2011-09-12 16:53:35.465556
33	1	8	1	1	31	Report	0	\N	2011-01-30	2	Epandage chaux	120	20	23		2011-09-12 16:53:35.535699	2011-09-12 16:53:35.535699
34	1	8	1	3	\N	Reportable	0	\N	2011-07-19	2	facture 24	5790	24	24		2011-09-12 16:53:35.541455	2011-09-12 16:53:35.541455
35	1	8	1	1	34	Report	0	\N	2011-07-19	2	Epandage engrais	2520	24	24	252 ha x 10€ = 2520€	2011-09-12 16:53:35.547327	2011-09-12 16:53:35.547327
36	1	8	1	1	34	Report	0	\N	2011-07-19	2	Pulvérisation cultures	2850	24	24	285 ha x 10€ = 2850€	2011-09-12 16:53:35.553065	2011-09-12 16:53:35.553065
37	1	8	1	1	34	Report	0	\N	2011-07-19	2	tours de champs	120	24	24	4h x 30€/h = 120€ (desherbage)	2011-09-12 16:53:35.558765	2011-09-12 16:53:35.558765
38	1	8	1	1	34	Report	0	\N	2011-07-19	2	semis tournesol	300	24	24	20ha x 15€/ha = 300€ (Semis tournesol Tracteur)	2011-09-12 16:53:35.564407	2011-09-12 16:53:35.564407
39	1	8	1	3	\N	Reportable	0	\N	2011-07-19	2	facture 25	226.400000000000006	25	25		2011-09-12 16:53:35.569871	2011-09-12 16:53:35.569871
40	1	8	1	1	39	Report	0	\N	2011-07-19	2	Vibro	200	25	25	20ha x 10€ = 200€	2011-09-12 16:53:35.575461	2011-09-12 16:53:35.575461
41	1	8	1	1	39	Report	0	\N	2011-07-19	2	Orge	26.3999999999999986	25	25	150kg x 176€/t = 26,40€	2011-09-12 16:53:35.580981	2011-09-12 16:53:35.580981
42	1	8	1	3	\N	Reportable	0	\N	2010-11-07	2	facture 50	6986	50	26		2011-09-12 16:53:35.586417	2011-09-12 16:53:35.586417
43	1	8	1	1	42	Report	0	\N	2010-11-07	2	Moissonnage Blé colza, Tournesol	6375	50	26	85ha x 75€/ha = 6375€	2011-09-12 16:53:35.591805	2011-09-12 16:53:35.591805
44	1	8	1	1	42	Report	0	\N	2010-11-07	2	Transport Céréales	611	50	26	13 voyages x 47€ = 611€	2011-09-12 16:53:35.597215	2011-09-12 16:53:35.597215
45	1	8	1	3	\N	Debit	0	\N	2010-11-10	2	facture 14 : Pressage	3312	14	27		2011-09-12 16:53:35.602597	2011-09-12 16:53:35.602597
\.


--
-- Data for Name: factypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factypes (id, name, display, "desc", created_at, updated_at) FROM stdin;
1	diff	diff	test desc	2011-09-12 16:53:25.104296	2011-09-12 16:53:25.104296
2	total	total	test desc	2011-09-12 16:53:25.109111	2011-09-12 16:53:25.109111
3	null	null	test desc	2011-09-12 16:53:25.11166	2011-09-12 16:53:25.11166
\.


--
-- Data for Name: labours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labours (id, saison_id, category_id, user_id, date, name, cout_ha_passage, "desc", star, adu, created_at, updated_at) FROM stdin;
1	1	20	2	2010-05-01	déchaumage blé - 1	10	date inconnue	0	\N	2011-09-12 16:53:35.681003	2011-09-12 16:53:35.681003
2	1	20	2	2010-05-01	déchaumage blé - 1	10	date inconnue	0	\N	2011-09-12 16:53:36.757768	2011-09-12 16:53:36.757768
3	1	20	2	2010-05-02	déchaumage blé - 2	10	date inconnue	0	\N	2011-09-12 16:53:36.762677	2011-09-12 16:53:36.762677
4	1	20	2	2010-05-03	déchaumage blé - 3	10	date inconnue	0	\N	2011-09-12 16:53:36.767206	2011-09-12 16:53:36.767206
5	1	19	2	2010-05-01	moisson blé	75	date inconnue	0	\N	2011-09-12 16:53:36.771951	2011-09-12 16:53:36.771951
6	1	19	2	2010-05-01	moisson tournesol	75	date inconnue	0	\N	2011-09-12 16:53:36.818076	2011-09-12 16:53:36.818076
7	1	19	2	2010-05-01	moisson colza	75	date inconnue	0	\N	2011-09-12 16:53:36.828247	2011-09-12 16:53:36.828247
\.


--
-- Data for Name: labtofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtofactures (id, saison_id, facture_id, labour_id, value, created_at, updated_at) FROM stdin;
1	1	29	1	110	2011-09-12 18:22:50.87625	2011-09-12 18:22:50.87625
2	1	29	2	430	2011-09-12 18:23:20.351346	2011-09-12 18:23:20.351346
3	1	29	3	430	2011-09-12 18:23:47.032787	2011-09-12 18:23:47.032787
5	1	43	5	3225	2011-09-12 18:24:59.843832	2011-09-12 18:24:59.843832
6	1	43	6	825	2011-09-12 18:25:19.924438	2011-09-12 18:25:19.924438
7	1	43	7	1200	2011-09-12 18:25:50.386148	2011-09-12 18:25:50.386148
4	1	29	4	430	2011-09-12 18:24:05.809097	2011-09-12 19:14:29.257715
\.


--
-- Data for Name: labtoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtoparcelles (id, saison_id, parcelle_id, labour_id, value, created_at, updated_at) FROM stdin;
1	1	11	1	1	2011-09-12 16:53:35.75012	2011-09-12 18:22:50.729836
2	1	2	2	1	2011-09-12 16:53:36.776158	2011-09-12 18:23:20.211395
6	1	1	2	1	2011-09-12 16:53:36.786641	2011-09-12 18:23:20.213868
10	1	6	2	1	2011-09-12 16:53:36.796972	2011-09-12 18:23:20.215679
14	1	7	2	1	2011-09-12 16:53:36.806873	2011-09-12 18:23:20.217386
3	1	2	3	1	2011-09-12 16:53:36.778895	2011-09-12 18:23:46.893147
7	1	1	3	1	2011-09-12 16:53:36.789026	2011-09-12 18:23:46.895268
11	1	6	3	1	2011-09-12 16:53:36.799439	2011-09-12 18:23:47.018621
15	1	7	3	1	2011-09-12 16:53:36.809615	2011-09-12 18:23:47.020824
4	1	2	4	1	2011-09-12 16:53:36.781514	2011-09-12 18:24:05.789788
8	1	1	4	1	2011-09-12 16:53:36.791934	2011-09-12 18:24:05.792311
12	1	6	4	1	2011-09-12 16:53:36.802137	2011-09-12 18:24:05.7954
16	1	7	4	1	2011-09-12 16:53:36.812127	2011-09-12 18:24:05.797383
5	1	2	5	1	2011-09-12 16:53:36.784102	2011-09-12 18:24:59.826795
9	1	1	5	1	2011-09-12 16:53:36.794551	2011-09-12 18:24:59.828924
13	1	6	5	1	2011-09-12 16:53:36.804481	2011-09-12 18:24:59.830577
17	1	7	5	1	2011-09-12 16:53:36.814555	2011-09-12 18:24:59.832813
18	1	1	6	1	2011-09-12 16:53:36.821865	2011-09-12 18:25:19.91064
19	1	11	6	1	2011-09-12 16:53:36.824493	2011-09-12 18:25:19.913122
20	1	10	7	1	2011-09-12 16:53:36.832028	2011-09-12 18:25:50.372318
21	1	8	7	1	2011-09-12 16:53:36.834605	2011-09-12 18:25:50.374496
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
1	1	1	Bruneau	14	\N	2011-09-12 16:53:34.65308	2011-09-12 16:53:34.65308
2	1	1	Mitant	5	\N	2011-09-12 16:53:34.673268	2011-09-12 16:53:34.673268
3	1	5	Feuillets 1	5	\N	2011-09-12 16:53:34.680651	2011-09-12 16:53:34.680651
4	1	5	Feuillets 2	4	\N	2011-09-12 16:53:34.68841	2011-09-12 16:53:34.68841
5	1	5	Feuillets 3	7	\N	2011-09-12 16:53:34.694681	2011-09-12 16:53:34.694681
6	1	1	Pont des champs	10	\N	2011-09-12 16:53:34.702071	2011-09-12 16:53:34.702071
7	1	1	Aeromodelisme	14	\N	2011-09-12 16:53:34.70826	2011-09-12 16:53:34.70826
8	1	4	Derierre	14	\N	2011-09-12 16:53:34.715029	2011-09-12 16:53:34.715029
9	1	3	Champ du Milieu	9	\N	2011-09-12 16:53:34.721795	2011-09-12 16:53:34.721795
10	1	4	Basse-cour	2	\N	2011-09-12 16:53:34.728864	2011-09-12 16:53:34.728864
11	1	3	Vallees	11	\N	2011-09-12 16:53:34.736249	2011-09-12 16:53:34.736249
\.


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY produits (id, category_id, saison_id, name, "desc", unit, star, adu, created_at, updated_at) FROM stdin;
1	9	1	Altigo		kg	\N	\N	2011-09-12 16:53:34.758552	2011-09-12 16:53:34.758552
2	13	1	Amistar Xtra		L	\N	\N	2011-09-12 16:53:34.76464	2011-09-12 16:53:34.76464
3	9	1	Ariane		L	\N	\N	2011-09-12 16:53:34.768789	2011-09-12 16:53:34.768789
4	17	1	Autan		kg	\N	\N	2011-09-12 16:53:34.830808	2011-09-12 16:53:34.830808
5	18	1	Azomag		kg	\N	\N	2011-09-12 16:53:34.834603	2011-09-12 16:53:34.834603
6	18	1	Azomag20		kg	\N	\N	2011-09-12 16:53:34.837987	2011-09-12 16:53:34.837987
7	10	1	Azote		L	\N	\N	2011-09-12 16:53:34.841245	2011-09-12 16:53:34.841245
8	13	1	Bravo Elite		L	\N	\N	2011-09-12 16:53:34.844473	2011-09-12 16:53:34.844473
9	17	1	Campo		kg	\N	\N	2011-09-12 16:53:34.847586	2011-09-12 16:53:34.847586
10	17	1	Campus		kg	\N	\N	2011-09-12 16:53:34.850907	2011-09-12 16:53:34.850907
11	17	1	Catalino		kg	\N	\N	2011-09-12 16:53:34.853965	2011-09-12 16:53:34.853965
12	11	1	Celtic		L	\N	\N	2011-09-12 16:53:34.857143	2011-09-12 16:53:34.857143
13	11	1	Challenge		L	\N	\N	2011-09-12 16:53:34.860189	2011-09-12 16:53:34.860189
14	11	1	Chardol		L	\N	\N	2011-09-12 16:53:34.863337	2011-09-12 16:53:34.863337
15	11	1	Chrono		L	\N	\N	2011-09-12 16:53:34.866566	2011-09-12 16:53:34.866566
16	11	1	Cline		L	\N	\N	2011-09-12 16:53:34.869627	2011-09-12 16:53:34.869627
17	11	1	Colzamid		L	\N	\N	2011-09-12 16:53:34.872593	2011-09-12 16:53:34.872593
18	13	1	Comet Player		L	\N	\N	2011-09-12 16:53:34.875591	2011-09-12 16:53:34.875591
19	12	1	15-15-15		kg	\N	\N	2011-09-12 16:53:34.878573	2011-09-12 16:53:34.878573
20	11	1	Folyr		L	\N	\N	2011-09-12 16:53:34.881685	2011-09-12 16:53:34.881685
21	15	1	Fury		L	\N	\N	2011-09-12 16:53:34.884828	2011-09-12 16:53:34.884828
22	11	1	Glifonet		L	\N	\N	2011-09-12 16:53:34.887965	2011-09-12 16:53:34.887965
23	17	1	Harmony		kg	\N	\N	2011-09-12 16:53:34.891022	2011-09-12 16:53:34.891022
24	9	1	Huile		L	\N	\N	2011-09-12 16:53:34.894619	2011-09-12 16:53:34.894619
25	17	1	Imperio		kg	\N	\N	2011-09-12 16:53:34.898205	2011-09-12 16:53:34.898205
26	9	1	Karate		L	\N	\N	2011-09-12 16:53:34.901886	2011-09-12 16:53:34.901886
27	17	1	Lontrel		kg	\N	\N	2011-09-12 16:53:34.904895	2011-09-12 16:53:34.904895
28	9	1	MAS 91		L	\N	\N	2011-09-12 16:53:34.907791	2011-09-12 16:53:34.907791
29	17	1	Novrel		kg	\N	\N	2011-09-12 16:53:34.910653	2011-09-12 16:53:34.910653
30	9	1	Nuvagrain		L	\N	\N	2011-09-12 16:53:34.913532	2011-09-12 16:53:34.913532
31	17	1	Ovation		kg	\N	\N	2011-09-12 16:53:34.91659	2011-09-12 16:53:34.91659
32	17	1	Paledor		kg	\N	\N	2011-09-12 16:53:34.919532	2011-09-12 16:53:34.919532
33	16	1	Picabore		kg	\N	\N	2011-09-12 16:53:34.922381	2011-09-12 16:53:34.922381
34	11	1	Picosolo		kg	\N	\N	2011-09-12 16:53:34.925215	2011-09-12 16:53:34.925215
35	17	1	Pr		kg	\N	\N	2011-09-12 16:53:34.928032	2011-09-12 16:53:34.928032
36	9	1	Proca		L	\N	\N	2011-09-12 16:53:34.930979	2011-09-12 16:53:34.930979
37	15	1	Proteus		L	\N	\N	2011-09-12 16:53:34.933893	2011-09-12 16:53:34.933893
38	11	1	Pulsar		L	\N	\N	2011-09-12 16:53:34.936747	2011-09-12 16:53:34.936747
39	9	1	Radar		L	\N	\N	2011-09-12 16:53:34.939478	2011-09-12 16:53:34.939478
40	9	1	Richepain		kg	\N	\N	2011-09-12 16:53:34.94233	2011-09-12 16:53:34.94233
41	9	1	spartan		L	\N	\N	2011-09-12 16:53:34.945166	2011-09-12 16:53:34.945166
42	11	1	Springbok		L	\N	\N	2011-09-12 16:53:34.948137	2011-09-12 16:53:34.948137
43	9	1	Stratos		L	\N	\N	2011-09-12 16:53:34.951122	2011-09-12 16:53:34.951122
44	12	1	Super45		kg	\N	\N	2011-09-12 16:53:34.954165	2011-09-12 16:53:34.954165
45	13	1	Surnog		L	\N	\N	2011-09-12 16:53:34.957121	2011-09-12 16:53:34.957121
46	11	1	Traxos		L	\N	\N	2011-09-12 16:53:34.960067	2011-09-12 16:53:34.960067
47	9	1	Vip		L	\N	\N	2011-09-12 16:53:34.963009	2011-09-12 16:53:34.963009
48	12	1	0-20-30		kg	\N	\N	2011-09-12 16:53:34.966119	2011-09-12 16:53:34.966119
49	12	1	0-25-25		kg	\N	\N	2011-09-12 16:53:34.969108	2011-09-12 16:53:34.969108
\.


--
-- Data for Name: protofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY protofactures (id, saison_id, produit_id, facture_id, prix, quantite, created_at, updated_at) FROM stdin;
1	1	44	2	0.465000000000000024	6600	2011-09-12 16:53:35.072032	2011-09-12 16:53:35.072032
2	1	48	3	0.394000000000000017	3200	2011-09-12 16:53:35.083245	2011-09-12 16:53:35.083245
3	1	48	5	0.400000000000000022	5000	2011-09-12 16:53:35.097314	2011-09-12 16:53:35.097314
4	1	10	6	142	7	2011-09-12 16:53:35.105617	2011-09-12 16:53:35.105617
5	1	2	7	43.8999999999999986	10	2011-09-12 16:53:35.113844	2011-09-12 16:53:35.113844
6	1	16	7	20.8999999999999986	15	2011-09-12 16:53:35.116452	2011-09-12 16:53:35.116452
7	1	38	7	56.6000000000000014	10	2011-09-12 16:53:35.118933	2011-09-12 16:53:35.118933
8	1	22	7	3.79999999999999982	200	2011-09-12 16:53:35.121532	2011-09-12 16:53:35.121532
9	1	22	7	3.79999999999999982	100	2011-09-12 16:53:35.124071	2011-09-12 16:53:35.124071
10	1	24	7	2.39999999999999991	60	2011-09-12 16:53:35.126625	2011-09-12 16:53:35.126625
11	1	27	7	52.9500000000000028	12	2011-09-12 16:53:35.129101	2011-09-12 16:53:35.129101
12	1	15	7	37.8999999999999986	15	2011-09-12 16:53:35.131729	2011-09-12 16:53:35.131729
13	1	28	7	198.599999999999994	3	2011-09-12 16:53:35.134499	2011-09-12 16:53:35.134499
14	1	5	8	0.280000000000000027	6000	2011-09-12 16:53:35.142431	2011-09-12 16:53:35.142431
15	1	19	9	50	0.5	2011-09-12 16:53:35.150643	2011-09-12 16:53:35.150643
16	1	24	9	2.39999999999999991	20	2011-09-12 16:53:35.153249	2011-09-12 16:53:35.153249
17	1	47	9	67	10	2011-09-12 16:53:35.155825	2011-09-12 16:53:35.155825
18	1	3	9	15.4000000000000004	30	2011-09-12 16:53:35.158303	2011-09-12 16:53:35.158303
19	1	46	9	31.6499999999999986	10	2011-09-12 16:53:35.160782	2011-09-12 16:53:35.160782
20	1	26	9	132.5	1	2011-09-12 16:53:35.163285	2011-09-12 16:53:35.163285
21	1	43	10	18.8000000000000007	10	2011-09-12 16:53:35.171506	2011-09-12 16:53:35.171506
22	1	39	10	212.5	12	2011-09-12 16:53:35.174035	2011-09-12 16:53:35.174035
23	1	41	10	33.8999999999999986	5	2011-09-12 16:53:35.176682	2011-09-12 16:53:35.176682
24	1	27	10	52.9500000000000028	1	2011-09-12 16:53:35.179159	2011-09-12 16:53:35.179159
25	1	24	10	2.39999999999999991	20	2011-09-12 16:53:35.182535	2011-09-12 16:53:35.182535
26	1	39	10	212.5	2.20000000000000018	2011-09-12 16:53:35.185379	2011-09-12 16:53:35.185379
27	1	36	10	10.1999999999999993	45	2011-09-12 16:53:35.18795	2011-09-12 16:53:35.18795
28	1	8	10	18.3000000000000007	60	2011-09-12 16:53:35.190471	2011-09-12 16:53:35.190471
29	1	18	10	159.900000000000006	6	2011-09-12 16:53:35.193362	2011-09-12 16:53:35.193362
30	1	45	10	32.2000000000000028	10	2011-09-12 16:53:35.196012	2011-09-12 16:53:35.196012
31	1	7	11	0.260000000000000009	25200	2011-09-12 16:53:35.204153	2011-09-12 16:53:35.204153
32	1	7	11	0.260000000000000009	10200	2011-09-12 16:53:35.206695	2011-09-12 16:53:35.206695
33	1	21	12	44.5	5	2011-09-12 16:53:35.276674	2011-09-12 16:53:35.276674
34	1	24	12	2.64999999999999991	20	2011-09-12 16:53:35.279713	2011-09-12 16:53:35.279713
35	1	20	12	30.8000000000000007	10	2011-09-12 16:53:35.28273	2011-09-12 16:53:35.28273
36	1	32	12	61.7999999999999972	2	2011-09-12 16:53:35.28548	2011-09-12 16:53:35.28548
37	1	1	12	63.7999999999999972	2	2011-09-12 16:53:35.288345	2011-09-12 16:53:35.288345
38	1	35	12	23.4699999999999989	7	2011-09-12 16:53:35.29109	2011-09-12 16:53:35.29109
39	1	31	13	139.5	1	2011-09-12 16:53:35.29991	2011-09-12 16:53:35.29991
40	1	17	13	19.3000000000000007	30	2011-09-12 16:53:35.302612	2011-09-12 16:53:35.302612
41	1	42	13	25.8999999999999986	40	2011-09-12 16:53:35.305489	2011-09-12 16:53:35.305489
42	1	14	14	7.84999999999999964	10	2011-09-12 16:53:35.314129	2011-09-12 16:53:35.314129
43	1	14	14	7.84999999999999964	10	2011-09-12 16:53:35.316947	2011-09-12 16:53:35.316947
44	1	24	14	2.60000000000000009	20	2011-09-12 16:53:35.319695	2011-09-12 16:53:35.319695
45	1	21	16	32.740000000000002	5	2011-09-12 16:53:35.33402	2011-09-12 16:53:35.33402
46	1	33	17	2.10000000000000009	40	2011-09-12 16:53:35.342399	2011-09-12 16:53:35.342399
47	1	13	17	18.9600000000000009	60	2011-09-12 16:53:35.345238	2011-09-12 16:53:35.345238
48	1	13	17	1.19999999999999996	60	2011-09-12 16:53:35.348178	2011-09-12 16:53:35.348178
49	1	30	18	36	5	2011-09-12 16:53:35.356721	2011-09-12 16:53:35.356721
50	1	26	18	109.900000000000006	1	2011-09-12 16:53:35.359354	2011-09-12 16:53:35.359354
51	1	30	19	25.629999999999999	2	2011-09-12 16:53:35.368422	2011-09-12 16:53:35.368422
52	1	33	21	2.10000000000000009	40	2011-09-12 16:53:35.38253	2011-09-12 16:53:35.38253
53	1	13	21	18.9600000000000009	60	2011-09-12 16:53:35.385335	2011-09-12 16:53:35.385335
54	1	13	21	1.19999999999999996	60	2011-09-12 16:53:35.387973	2011-09-12 16:53:35.387973
\.


--
-- Data for Name: pulves; Type: TABLE DATA; Schema: public; Owner: -
--

COPY pulves (id, saison_id, user_id, date, name, cout_ha_passage, star, adu, "desc", created_at, updated_at) FROM stdin;
1	1	2	2011-03-11	Glyphosate	23	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-09-12 16:53:35.615776	2011-09-12 16:53:35.615776
2	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-09-12 16:53:35.636329	2011-09-12 16:53:35.636329
3	1	2	2011-04-06	Semis	10	1	\N	indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).	2011-09-12 16:53:35.643394	2011-09-12 16:53:35.643394
4	1	2	2011-04-07	Cline	10	0	\N	2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636	2011-09-12 16:53:35.647452	2011-09-12 16:53:35.647452
5	1	2	2011-04-11	Challenge	10	0	\N	4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182	2011-09-12 16:53:35.654136	2011-09-12 16:53:35.654136
6	1	2	2011-05-20	pulsar	10	0	\N	1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182	2011-09-12 16:53:35.660925	2011-09-12 16:53:35.660925
7	1	2	2011-03-11	Glyphosate	10	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-09-12 16:53:35.779706	2011-09-12 16:53:35.779706
8	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-09-12 16:53:35.789598	2011-09-12 16:53:35.789598
9	1	2	2011-04-06	Semis	10	1	\N	modifier le cout_ha_passage et le dosage	2011-09-12 16:53:35.797117	2011-09-12 16:53:35.797117
10	1	2	2011-04-11	Challenge	10	0	\N		2011-09-12 16:53:35.801495	2011-09-12 16:53:35.801495
11	1	2	2010-08-31	Semis	31	0	\N		2011-09-12 16:53:35.819588	2011-09-12 16:53:35.819588
12	1	2	2010-08-31	colzamid	10	0	\N		2011-09-12 16:53:35.823714	2011-09-12 16:53:35.823714
13	1	2	2010-09-02	springbok	10	0	\N		2011-09-12 16:53:35.83068	2011-09-12 16:53:35.83068
14	1	2	2010-10-07	Folyr	10	0	\N		2011-09-12 16:53:35.837607	2011-09-12 16:53:35.837607
15	1	2	2011-01-23	0-20-30	10	0	\N		2011-09-12 16:53:35.849775	2011-09-12 16:53:35.849775
16	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38 (? Cf carnet trochet)	2011-09-12 16:53:35.856906	2011-09-12 16:53:35.856906
17	1	2	2011-02-10	Stratos	10	0	\N		2011-09-12 16:53:35.863902	2011-09-12 16:53:35.863902
18	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-09-12 16:53:35.871145	2011-09-12 16:53:35.871145
19	1	2	2011-03-08	Soufre	10	0	\N		2011-09-12 16:53:35.87791	2011-09-12 16:53:35.87791
20	1	2	2011-03-08	Fury	10	0	\N		2011-09-12 16:53:35.884547	2011-09-12 16:53:35.884547
21	1	2	2011-03-08	chrono	10	0	\N		2011-09-12 16:53:35.891804	2011-09-12 16:53:35.891804
22	1	2	2011-03-20	picabore	10	0	\N		2011-09-12 16:53:35.903169	2011-09-12 16:53:35.903169
23	1	2	2011-04-02	Surnog	10	0	\N		2011-09-12 16:53:35.912389	2011-09-12 16:53:35.912389
24	1	2	2011-04-20	amistar_xtra	10	0	\N		2011-09-12 16:53:35.919498	2011-09-12 16:53:35.919498
25	1	2	2010-08-30	Semis	31	1	\N	dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)	2011-09-12 16:53:36.026466	2011-09-12 16:53:36.026466
26	1	2	2010-08-30	colzamid	10	0	\N		2011-09-12 16:53:36.030655	2011-09-12 16:53:36.030655
27	1	2	2010-09-02	springbok	10	0	\N		2011-09-12 16:53:36.037837	2011-09-12 16:53:36.037837
28	1	2	2010-10-07	Folyr	10	0	\N		2011-09-12 16:53:36.044753	2011-09-12 16:53:36.044753
29	1	2	2011-01-23	0-20-30	10	0	\N		2011-09-12 16:53:36.056987	2011-09-12 16:53:36.056987
30	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38	2011-09-12 16:53:36.063755	2011-09-12 16:53:36.063755
31	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-09-12 16:53:36.070631	2011-09-12 16:53:36.070631
32	1	2	2011-03-08	Soufre	10	0	\N		2011-09-12 16:53:36.07736	2011-09-12 16:53:36.07736
33	1	2	2011-03-09	Fury	10	0	\N		2011-09-12 16:53:36.084137	2011-09-12 16:53:36.084137
34	1	2	2011-03-08	chrono	10	0	\N	dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.	2011-09-12 16:53:36.090916	2011-09-12 16:53:36.090916
35	1	2	2011-03-24	picabore	10	0	\N		2011-09-12 16:53:36.100035	2011-09-12 16:53:36.100035
36	1	2	2011-04-02	Surnog	10	0	\N		2011-09-12 16:53:36.109446	2011-09-12 16:53:36.109446
37	1	2	2011-04-20	amistar_xtra	10	0	\N		2011-09-12 16:53:36.116127	2011-09-12 16:53:36.116127
38	1	2	2010-10-01	glyphosate	10	0	\N		2011-09-12 16:53:36.154972	2011-09-12 16:53:36.154972
39	1	2	2010-10-22	semis	31	0	\N	dosage réel=180.</br>début Richepin, fin PR.</br>N°43	2011-09-12 16:53:36.161717	2011-09-12 16:53:36.161717
40	1	2	2011-01-20	Super 45	10	0	\N		2011-09-12 16:53:36.165624	2011-09-12 16:53:36.165624
41	1	2	2011-02-08	Azote	10	0	\N		2011-09-12 16:53:36.236053	2011-09-12 16:53:36.236053
42	1	2	2011-03-03	Azote	10	0	\N		2011-09-12 16:53:36.244101	2011-09-12 16:53:36.244101
43	1	2	2011-03-09	Soufre	10	0	\N		2011-09-12 16:53:36.251366	2011-09-12 16:53:36.251366
44	1	2	2011-03-09	Radar	10	0	\N		2011-09-12 16:53:36.258564	2011-09-12 16:53:36.258564
45	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-12 16:53:36.265603	2011-09-12 16:53:36.265603
46	1	2	2011-04-20	Vip	10	1	\N	dosage huile?	2011-09-12 16:53:36.27304	2011-09-12 16:53:36.27304
47	1	2	2011-04-30	Baravo Elite	10	0	\N		2011-09-12 16:53:36.283042	2011-09-12 16:53:36.283042
48	1	2	2011-05-04	Ariane	10	0	\N		2011-09-12 16:53:36.290146	2011-09-12 16:53:36.290146
49	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-12 16:53:36.325863	2011-09-12 16:53:36.325863
50	1	2	2010-10-20	semis	31	0	\N	dosage reel 175kg/Ha.</br>N°42.	2011-09-12 16:53:36.336058	2011-09-12 16:53:36.336058
51	1	2	2011-01-20	Super 45	10	0	\N		2011-09-12 16:53:36.34017	2011-09-12 16:53:36.34017
52	1	2	2011-02-08	Azote	10	0	\N		2011-09-12 16:53:36.347581	2011-09-12 16:53:36.347581
53	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-09-12 16:53:36.354573	2011-09-12 16:53:36.354573
54	1	2	2011-03-03	Azote	10	0	\N		2011-09-12 16:53:36.364254	2011-09-12 16:53:36.364254
55	1	2	2011-03-09	Soufre	10	0	\N		2011-09-12 16:53:36.371328	2011-09-12 16:53:36.371328
56	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-12 16:53:36.378899	2011-09-12 16:53:36.378899
57	1	2	2011-04-21	Vip	10	1	\N	traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha	2011-09-12 16:53:36.38614	2011-09-12 16:53:36.38614
58	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-12 16:53:36.399863	2011-09-12 16:53:36.399863
59	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-12 16:53:36.500243	2011-09-12 16:53:36.500243
60	1	2	2010-10-21	semis	31	0	\N	dosage reel 165kg/Ha.</br>(Voir plan?)	2011-09-12 16:53:36.510541	2011-09-12 16:53:36.510541
61	1	2	2011-01-20	Super 45	10	0	\N		2011-09-12 16:53:36.515059	2011-09-12 16:53:36.515059
62	1	2	2011-02-08	Azote	10	0	\N		2011-09-12 16:53:36.52224	2011-09-12 16:53:36.52224
63	1	2	2011-03-03	Azote	10	0	\N		2011-09-12 16:53:36.529666	2011-09-12 16:53:36.529666
64	1	2	2011-03-09	Soufre	10	0	\N		2011-09-12 16:53:36.536856	2011-09-12 16:53:36.536856
65	1	2	2011-03-14	Radar	10	1	\N	dosage huile?	2011-09-12 16:53:36.544123	2011-09-12 16:53:36.544123
66	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-12 16:53:36.55403	2011-09-12 16:53:36.55403
67	1	2	2011-04-21	Vip	10	1	\N	dosage reel : 0,5L/Ha sur 2.5 Ha.	2011-09-12 16:53:36.561371	2011-09-12 16:53:36.561371
68	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-12 16:53:36.571507	2011-09-12 16:53:36.571507
69	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-12 16:53:36.604296	2011-09-12 16:53:36.604296
70	1	2	2010-10-21	semis	31	0	\N	dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42	2011-09-12 16:53:36.613712	2011-09-12 16:53:36.613712
71	1	2	2011-01-20	Super 45	10	0	\N		2011-09-12 16:53:36.61776	2011-09-12 16:53:36.61776
72	1	2	2011-02-08	Azote	10	0	\N		2011-09-12 16:53:36.624707	2011-09-12 16:53:36.624707
73	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-09-12 16:53:36.631362	2011-09-12 16:53:36.631362
74	1	2	2011-03-03	Azote	10	0	\N		2011-09-12 16:53:36.64062	2011-09-12 16:53:36.64062
75	1	2	2011-03-09	Soufre	10	0	\N		2011-09-12 16:53:36.647628	2011-09-12 16:53:36.647628
76	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-12 16:53:36.654762	2011-09-12 16:53:36.654762
77	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-12 16:53:36.661664	2011-09-12 16:53:36.661664
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
1	1	11	1	0	2011-09-12 16:53:35.760422	2011-09-12 16:53:35.760422
2	1	11	2	0	2011-09-12 16:53:35.765806	2011-09-12 16:53:35.765806
3	1	11	3	0	2011-09-12 16:53:35.768634	2011-09-12 16:53:35.768634
4	1	11	4	0	2011-09-12 16:53:35.771212	2011-09-12 16:53:35.771212
5	1	11	5	0	2011-09-12 16:53:35.773723	2011-09-12 16:53:35.773723
6	1	11	6	0	2011-09-12 16:53:35.776444	2011-09-12 16:53:35.776444
7	1	9	7	0	2011-09-12 16:53:35.80888	2011-09-12 16:53:35.80888
8	1	9	8	0	2011-09-12 16:53:35.811454	2011-09-12 16:53:35.811454
9	1	9	9	0	2011-09-12 16:53:35.813942	2011-09-12 16:53:35.813942
10	1	9	10	0	2011-09-12 16:53:35.816424	2011-09-12 16:53:35.816424
11	1	10	11	0	2011-09-12 16:53:35.926913	2011-09-12 16:53:35.926913
12	1	10	12	0	2011-09-12 16:53:35.929478	2011-09-12 16:53:35.929478
13	1	10	13	0	2011-09-12 16:53:35.931895	2011-09-12 16:53:35.931895
14	1	10	14	0	2011-09-12 16:53:35.997505	2011-09-12 16:53:35.997505
15	1	10	15	0	2011-09-12 16:53:36.0005	2011-09-12 16:53:36.0005
16	1	10	16	0	2011-09-12 16:53:36.003182	2011-09-12 16:53:36.003182
17	1	10	17	0	2011-09-12 16:53:36.005739	2011-09-12 16:53:36.005739
18	1	10	18	0	2011-09-12 16:53:36.008322	2011-09-12 16:53:36.008322
19	1	10	19	0	2011-09-12 16:53:36.010808	2011-09-12 16:53:36.010808
20	1	10	20	0	2011-09-12 16:53:36.013439	2011-09-12 16:53:36.013439
21	1	10	21	0	2011-09-12 16:53:36.015887	2011-09-12 16:53:36.015887
22	1	10	22	0	2011-09-12 16:53:36.018397	2011-09-12 16:53:36.018397
23	1	10	23	0	2011-09-12 16:53:36.020779	2011-09-12 16:53:36.020779
24	1	10	24	0	2011-09-12 16:53:36.023304	2011-09-12 16:53:36.023304
25	1	8	25	0	2011-09-12 16:53:36.123112	2011-09-12 16:53:36.123112
26	1	8	26	0	2011-09-12 16:53:36.125594	2011-09-12 16:53:36.125594
27	1	8	27	0	2011-09-12 16:53:36.128172	2011-09-12 16:53:36.128172
28	1	8	28	0	2011-09-12 16:53:36.130676	2011-09-12 16:53:36.130676
29	1	8	29	0	2011-09-12 16:53:36.133015	2011-09-12 16:53:36.133015
30	1	8	30	0	2011-09-12 16:53:36.13539	2011-09-12 16:53:36.13539
31	1	8	31	0	2011-09-12 16:53:36.13778	2011-09-12 16:53:36.13778
32	1	8	32	0	2011-09-12 16:53:36.140105	2011-09-12 16:53:36.140105
33	1	8	33	0	2011-09-12 16:53:36.142401	2011-09-12 16:53:36.142401
34	1	8	34	0	2011-09-12 16:53:36.144742	2011-09-12 16:53:36.144742
35	1	8	35	0	2011-09-12 16:53:36.147077	2011-09-12 16:53:36.147077
36	1	8	36	0	2011-09-12 16:53:36.149502	2011-09-12 16:53:36.149502
37	1	8	37	0	2011-09-12 16:53:36.151941	2011-09-12 16:53:36.151941
38	1	6	38	0	2011-09-12 16:53:36.297618	2011-09-12 16:53:36.297618
39	1	6	39	0	2011-09-12 16:53:36.300213	2011-09-12 16:53:36.300213
40	1	6	40	0	2011-09-12 16:53:36.302668	2011-09-12 16:53:36.302668
41	1	6	41	0	2011-09-12 16:53:36.305265	2011-09-12 16:53:36.305265
42	1	6	42	0	2011-09-12 16:53:36.307653	2011-09-12 16:53:36.307653
43	1	6	43	0	2011-09-12 16:53:36.310049	2011-09-12 16:53:36.310049
44	1	6	44	0	2011-09-12 16:53:36.312854	2011-09-12 16:53:36.312854
45	1	6	45	0	2011-09-12 16:53:36.315378	2011-09-12 16:53:36.315378
46	1	6	46	0	2011-09-12 16:53:36.317758	2011-09-12 16:53:36.317758
47	1	6	47	0	2011-09-12 16:53:36.32037	2011-09-12 16:53:36.32037
48	1	6	48	0	2011-09-12 16:53:36.322794	2011-09-12 16:53:36.322794
49	1	7	49	0	2011-09-12 16:53:36.407188	2011-09-12 16:53:36.407188
50	1	7	50	0	2011-09-12 16:53:36.409754	2011-09-12 16:53:36.409754
51	1	7	51	0	2011-09-12 16:53:36.41239	2011-09-12 16:53:36.41239
52	1	7	52	0	2011-09-12 16:53:36.414806	2011-09-12 16:53:36.414806
53	1	7	53	0	2011-09-12 16:53:36.417425	2011-09-12 16:53:36.417425
54	1	7	54	0	2011-09-12 16:53:36.419942	2011-09-12 16:53:36.419942
55	1	7	55	0	2011-09-12 16:53:36.488271	2011-09-12 16:53:36.488271
56	1	7	56	0	2011-09-12 16:53:36.491275	2011-09-12 16:53:36.491275
57	1	7	57	0	2011-09-12 16:53:36.49418	2011-09-12 16:53:36.49418
58	1	7	58	0	2011-09-12 16:53:36.49693	2011-09-12 16:53:36.49693
59	1	2	59	0	2011-09-12 16:53:36.578851	2011-09-12 16:53:36.578851
60	1	2	60	0	2011-09-12 16:53:36.581554	2011-09-12 16:53:36.581554
61	1	2	61	0	2011-09-12 16:53:36.584045	2011-09-12 16:53:36.584045
62	1	2	62	0	2011-09-12 16:53:36.586517	2011-09-12 16:53:36.586517
63	1	2	63	0	2011-09-12 16:53:36.588944	2011-09-12 16:53:36.588944
64	1	2	64	0	2011-09-12 16:53:36.591513	2011-09-12 16:53:36.591513
65	1	2	65	0	2011-09-12 16:53:36.594018	2011-09-12 16:53:36.594018
66	1	2	66	0	2011-09-12 16:53:36.596355	2011-09-12 16:53:36.596355
67	1	2	67	0	2011-09-12 16:53:36.598652	2011-09-12 16:53:36.598652
68	1	2	68	0	2011-09-12 16:53:36.601068	2011-09-12 16:53:36.601068
69	1	1	69	0	2011-09-12 16:53:36.733017	2011-09-12 16:53:36.733017
70	1	1	70	0	2011-09-12 16:53:36.736111	2011-09-12 16:53:36.736111
71	1	1	71	0	2011-09-12 16:53:36.738832	2011-09-12 16:53:36.738832
72	1	1	72	0	2011-09-12 16:53:36.741369	2011-09-12 16:53:36.741369
73	1	1	73	0	2011-09-12 16:53:36.743984	2011-09-12 16:53:36.743984
74	1	1	74	0	2011-09-12 16:53:36.746625	2011-09-12 16:53:36.746625
75	1	1	75	0	2011-09-12 16:53:36.749079	2011-09-12 16:53:36.749079
76	1	1	76	0	2011-09-12 16:53:36.751694	2011-09-12 16:53:36.751694
77	1	1	77	0	2011-09-12 16:53:36.754297	2011-09-12 16:53:36.754297
\.


--
-- Data for Name: putoproduits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putoproduits (id, saison_id, pulve_id, produit_id, dosage, dosage_vrai, "desc", created_at, updated_at) FROM stdin;
1	1	1	22	2	\N	\N	2011-09-12 16:53:35.627096	2011-09-12 16:53:35.627096
2	1	1	24	1	\N	\N	2011-09-12 16:53:35.632616	2011-09-12 16:53:35.632616
3	1	2	48	250	\N	\N	2011-09-12 16:53:35.640055	2011-09-12 16:53:35.640055
4	1	4	16	1.36359999999999992	\N	\N	2011-09-12 16:53:35.651082	2011-09-12 16:53:35.651082
5	1	5	13	1.81820000000000004	\N	\N	2011-09-12 16:53:35.657848	2011-09-12 16:53:35.657848
6	1	6	38	0.681819999999999982	\N	\N	2011-09-12 16:53:35.664835	2011-09-12 16:53:35.664835
7	1	7	22	2	\N	\N	2011-09-12 16:53:35.783579	2011-09-12 16:53:35.783579
8	1	7	24	1	\N	\N	2011-09-12 16:53:35.7864	2011-09-12 16:53:35.7864
9	1	8	48	250	\N	\N	2011-09-12 16:53:35.793598	2011-09-12 16:53:35.793598
10	1	10	13	4	\N	\N	2011-09-12 16:53:35.805238	2011-09-12 16:53:35.805238
11	1	12	17	1.80000000000000004	\N	\N	2011-09-12 16:53:35.827455	2011-09-12 16:53:35.827455
12	1	13	42	2.5	\N	\N	2011-09-12 16:53:35.834417	2011-09-12 16:53:35.834417
13	1	14	20	0.599999999999999978	\N	\N	2011-09-12 16:53:35.841231	2011-09-12 16:53:35.841231
14	1	14	24	1	\N	\N	2011-09-12 16:53:35.843864	2011-09-12 16:53:35.843864
15	1	14	21	0.100000000000000006	\N	\N	2011-09-12 16:53:35.846589	2011-09-12 16:53:35.846589
16	1	15	48	200	\N	\N	2011-09-12 16:53:35.853517	2011-09-12 16:53:35.853517
17	1	16	7	243	\N	\N	2011-09-12 16:53:35.860645	2011-09-12 16:53:35.860645
18	1	17	43	2	\N	\N	2011-09-12 16:53:35.867777	2011-09-12 16:53:35.867777
19	1	18	7	281	\N	\N	2011-09-12 16:53:35.874714	2011-09-12 16:53:35.874714
20	1	19	5	150	\N	\N	2011-09-12 16:53:35.881493	2011-09-12 16:53:35.881493
21	1	20	21	0.100000000000000006	\N	\N	2011-09-12 16:53:35.888503	2011-09-12 16:53:35.888503
22	1	21	15	1.25	\N	\N	2011-09-12 16:53:35.896133	2011-09-12 16:53:35.896133
23	1	21	27	1	\N	\N	2011-09-12 16:53:35.899625	2011-09-12 16:53:35.899625
24	1	22	33	2.5	\N	\N	2011-09-12 16:53:35.906714	2011-09-12 16:53:35.906714
25	1	22	37	0.5	\N	\N	2011-09-12 16:53:35.909346	2011-09-12 16:53:35.909346
26	1	23	45	0.599999999999999978	\N	\N	2011-09-12 16:53:35.916199	2011-09-12 16:53:35.916199
27	1	24	2	0.75	\N	\N	2011-09-12 16:53:35.923234	2011-09-12 16:53:35.923234
28	1	26	17	1.80000000000000004	\N	\N	2011-09-12 16:53:36.034505	2011-09-12 16:53:36.034505
29	1	27	42	2.5	\N	\N	2011-09-12 16:53:36.041502	2011-09-12 16:53:36.041502
30	1	28	20	0.599999999999999978	\N	\N	2011-09-12 16:53:36.04847	2011-09-12 16:53:36.04847
31	1	28	24	1	\N	\N	2011-09-12 16:53:36.051184	2011-09-12 16:53:36.051184
32	1	28	21	0.100000000000000006	\N	\N	2011-09-12 16:53:36.053793	2011-09-12 16:53:36.053793
33	1	29	48	200	\N	\N	2011-09-12 16:53:36.060588	2011-09-12 16:53:36.060588
34	1	30	7	243	\N	\N	2011-09-12 16:53:36.067373	2011-09-12 16:53:36.067373
35	1	31	7	280	\N	\N	2011-09-12 16:53:36.074167	2011-09-12 16:53:36.074167
36	1	32	5	150	\N	\N	2011-09-12 16:53:36.081027	2011-09-12 16:53:36.081027
37	1	33	21	0.100000000000000006	\N	\N	2011-09-12 16:53:36.08776	2011-09-12 16:53:36.08776
38	1	34	15	0.713999999999999968	\N	\N	2011-09-12 16:53:36.094394	2011-09-12 16:53:36.094394
39	1	34	27	0.570999999999999952	\N	\N	2011-09-12 16:53:36.096982	2011-09-12 16:53:36.096982
40	1	35	33	2.5	\N	\N	2011-09-12 16:53:36.103658	2011-09-12 16:53:36.103658
41	1	35	37	0.5	\N	\N	2011-09-12 16:53:36.106236	2011-09-12 16:53:36.106236
42	1	36	45	0.599999999999999978	\N	\N	2011-09-12 16:53:36.113062	2011-09-12 16:53:36.113062
43	1	37	2	0.75	\N	\N	2011-09-12 16:53:36.119639	2011-09-12 16:53:36.119639
44	1	38	22	5	\N	\N	2011-09-12 16:53:36.158641	2011-09-12 16:53:36.158641
45	1	40	44	153	\N	\N	2011-09-12 16:53:36.169177	2011-09-12 16:53:36.169177
46	1	41	7	200	\N	\N	2011-09-12 16:53:36.24052	2011-09-12 16:53:36.24052
47	1	42	7	237	\N	\N	2011-09-12 16:53:36.248037	2011-09-12 16:53:36.248037
48	1	43	5	100	\N	\N	2011-09-12 16:53:36.255078	2011-09-12 16:53:36.255078
49	1	44	39	0.275000000000000022	\N	\N	2011-09-12 16:53:36.262247	2011-09-12 16:53:36.262247
50	1	45	36	1	\N	\N	2011-09-12 16:53:36.269698	2011-09-12 16:53:36.269698
51	1	46	47	0.5	\N	\N	2011-09-12 16:53:36.276764	2011-09-12 16:53:36.276764
52	1	46	24	1	\N	\N	2011-09-12 16:53:36.27975	2011-09-12 16:53:36.27975
53	1	47	8	1.39999999999999991	\N	\N	2011-09-12 16:53:36.286699	2011-09-12 16:53:36.286699
54	1	48	3	3	\N	\N	2011-09-12 16:53:36.293844	2011-09-12 16:53:36.293844
55	1	49	22	2	\N	\N	2011-09-12 16:53:36.329994	2011-09-12 16:53:36.329994
56	1	49	14	0.599999999999999978	\N	\N	2011-09-12 16:53:36.332719	2011-09-12 16:53:36.332719
57	1	51	44	153	\N	\N	2011-09-12 16:53:36.344045	2011-09-12 16:53:36.344045
58	1	52	7	200	\N	\N	2011-09-12 16:53:36.351228	2011-09-12 16:53:36.351228
59	1	53	39	0.275000000000000022	\N	\N	2011-09-12 16:53:36.358172	2011-09-12 16:53:36.358172
60	1	53	24	1	\N	\N	2011-09-12 16:53:36.361052	2011-09-12 16:53:36.361052
61	1	54	7	237	\N	\N	2011-09-12 16:53:36.367932	2011-09-12 16:53:36.367932
62	1	55	5	100	\N	\N	2011-09-12 16:53:36.375094	2011-09-12 16:53:36.375094
63	1	56	36	1	\N	\N	2011-09-12 16:53:36.382712	2011-09-12 16:53:36.382712
64	1	57	46	0.710999999999999965	\N	\N	2011-09-12 16:53:36.389937	2011-09-12 16:53:36.389937
65	1	57	47	0.203600000000000003	\N	\N	2011-09-12 16:53:36.39277	2011-09-12 16:53:36.39277
66	1	57	24	1	\N	\N	2011-09-12 16:53:36.395818	2011-09-12 16:53:36.395818
67	1	58	8	1.39999999999999991	\N	\N	2011-09-12 16:53:36.403626	2011-09-12 16:53:36.403626
68	1	59	22	2	\N	\N	2011-09-12 16:53:36.504284	2011-09-12 16:53:36.504284
69	1	59	14	0.599999999999999978	\N	\N	2011-09-12 16:53:36.507118	2011-09-12 16:53:36.507118
70	1	61	44	153	\N	\N	2011-09-12 16:53:36.51876	2011-09-12 16:53:36.51876
71	1	62	7	200	\N	\N	2011-09-12 16:53:36.526159	2011-09-12 16:53:36.526159
72	1	63	7	237	\N	\N	2011-09-12 16:53:36.533365	2011-09-12 16:53:36.533365
73	1	64	5	100	\N	\N	2011-09-12 16:53:36.54065	2011-09-12 16:53:36.54065
74	1	65	39	0.275000000000000022	\N	\N	2011-09-12 16:53:36.547963	2011-09-12 16:53:36.547963
75	1	65	24	1	\N	\N	2011-09-12 16:53:36.550663	2011-09-12 16:53:36.550663
76	1	66	36	1	\N	\N	2011-09-12 16:53:36.557789	2011-09-12 16:53:36.557789
77	1	67	47	0.25	\N	\N	2011-09-12 16:53:36.565092	2011-09-12 16:53:36.565092
78	1	67	24	0.5	\N	\N	2011-09-12 16:53:36.568056	2011-09-12 16:53:36.568056
79	1	68	8	1.39999999999999991	\N	\N	2011-09-12 16:53:36.575214	2011-09-12 16:53:36.575214
80	1	69	22	2	\N	\N	2011-09-12 16:53:36.607878	2011-09-12 16:53:36.607878
81	1	69	14	0.599999999999999978	\N	\N	2011-09-12 16:53:36.610605	2011-09-12 16:53:36.610605
82	1	71	44	153	\N	\N	2011-09-12 16:53:36.621338	2011-09-12 16:53:36.621338
83	1	72	7	200	\N	\N	2011-09-12 16:53:36.628255	2011-09-12 16:53:36.628255
84	1	73	39	0.275000000000000022	\N	\N	2011-09-12 16:53:36.634869	2011-09-12 16:53:36.634869
85	1	73	24	1	\N	\N	2011-09-12 16:53:36.637569	2011-09-12 16:53:36.637569
86	1	74	7	237	\N	\N	2011-09-12 16:53:36.644237	2011-09-12 16:53:36.644237
87	1	75	5	100	\N	\N	2011-09-12 16:53:36.651683	2011-09-12 16:53:36.651683
88	1	76	36	1	\N	\N	2011-09-12 16:53:36.658488	2011-09-12 16:53:36.658488
89	1	77	8	1.39999999999999991	\N	\N	2011-09-12 16:53:36.665438	2011-09-12 16:53:36.665438
\.


--
-- Data for Name: saisons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY saisons (id, name, year, "desc") FROM stdin;
1	2010/2011	2010	\N
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
1	facture	2011-09-12 16:53:24.906166	2011-09-12 16:53:24.906166
2	pulve	2011-09-12 16:53:24.911384	2011-09-12 16:53:24.911384
3	labour	2011-09-12 16:53:24.91396	2011-09-12 16:53:24.91396
4	vente	2011-09-12 16:53:24.916345	2011-09-12 16:53:24.916345
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, name, created_at, updated_at) FROM stdin;
1	Jouve	2011-09-12 16:53:25.117583	2011-09-12 16:53:25.117583
2	Trochet	2011-09-12 16:53:25.122418	2011-09-12 16:53:25.122418
3	Dauger	2011-09-12 16:53:25.1246	2011-09-12 16:53:25.1246
4	Raffault	2011-09-12 16:53:25.127021	2011-09-12 16:53:25.127021
5	C le Mobile	2011-09-12 16:53:25.129059	2011-09-12 16:53:25.129059
6	Credit Agricole Assurances	2011-09-12 16:53:25.131114	2011-09-12 16:53:25.131114
7	Bastard	2011-09-12 16:53:25.13316	2011-09-12 16:53:25.13316
8	Daugeron Garage	2011-09-12 16:53:25.135178	2011-09-12 16:53:25.135178
9	Communaute de communes	2011-09-12 16:53:25.137245	2011-09-12 16:53:25.137245
10	SIAEP de l'Igneraie	2011-09-12 16:53:25.13943	2011-09-12 16:53:25.13943
11	France Telecom	2011-09-12 16:53:25.141577	2011-09-12 16:53:25.141577
12	Dechansiaud	2011-09-12 16:53:25.143705	2011-09-12 16:53:25.143705
13	Renaud	2011-09-12 16:53:25.145808	2011-09-12 16:53:25.145808
14	EDF	2011-09-12 16:53:25.147891	2011-09-12 16:53:25.147891
15	Compta Centre	2011-09-12 16:53:25.149988	2011-09-12 16:53:25.149988
16	Pneu Europe Service	2011-09-12 16:53:25.152419	2011-09-12 16:53:25.152419
17	Sodibe	2011-09-12 16:53:25.154602	2011-09-12 16:53:25.154602
18	Lapeyre	2011-09-12 16:53:25.156717	2011-09-12 16:53:25.156717
19	Seelec	2011-09-12 16:53:25.158829	2011-09-12 16:53:25.158829
20	Denormandie Jardinerie	2011-09-12 16:53:25.160907	2011-09-12 16:53:25.160907
21	MSA	2011-09-12 16:53:25.223423	2011-09-12 16:53:25.223423
22	Agro-Service	2011-09-12 16:53:25.226097	2011-09-12 16:53:25.226097
23	CBM	2011-09-12 16:53:25.228378	2011-09-12 16:53:25.228378
24	Super U	2011-09-12 16:53:25.230575	2011-09-12 16:53:25.230575
25	DDA	2011-09-12 16:53:25.232693	2011-09-12 16:53:25.232693
26	PAC	2011-09-12 16:53:25.234823	2011-09-12 16:53:25.234823
27	Charrier	2011-09-12 16:53:25.236928	2011-09-12 16:53:25.236928
28	La Poste	2011-09-12 16:53:25.239003	2011-09-12 16:53:25.239003
29	Brico Depot	2011-09-12 16:53:25.241089	2011-09-12 16:53:25.241089
30	divers	2011-09-12 16:53:25.243137	2011-09-12 16:53:25.243137
31	Auroy	2011-09-12 16:53:25.245207	2011-09-12 16:53:25.245207
32	Bernard Peres	2011-09-12 16:53:25.247251	2011-09-12 16:53:25.247251
33	Bricomarche	2011-09-12 16:53:25.249283	2011-09-12 16:53:25.249283
34	Aucun	2011-09-12 16:53:25.251405	2011-09-12 16:53:25.251405
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
1	Bruneau	14	2011-09-12 16:53:25.273372	2011-09-12 16:53:25.273372
2	Mitant	5	2011-09-12 16:53:25.278359	2011-09-12 16:53:25.278359
3	La Rue	46.5499999999999972	2011-09-12 16:53:25.280773	2011-09-12 16:53:25.280773
4	Basse-cour	2	2011-09-12 16:53:25.282974	2011-09-12 16:53:25.282974
5	Vallees	11	2011-09-12 16:53:25.285242	2011-09-12 16:53:25.285242
6	Guiberons	2.5	2011-09-12 16:53:25.287502	2011-09-12 16:53:25.287502
7	La cote	2	2011-09-12 16:53:25.289928	2011-09-12 16:53:25.289928
8	Feuillets	16	2011-09-12 16:53:25.292171	2011-09-12 16:53:25.292171
9	Brandes	2.9700000000000002	2011-09-12 16:53:25.294615	2011-09-12 16:53:25.294615
10	Taillis	19.3200000000000003	2011-09-12 16:53:25.296852	2011-09-12 16:53:25.296852
11	Varennes	15.8599999999999994	2011-09-12 16:53:25.299063	2011-09-12 16:53:25.299063
12	Patureaux	8.86999999999999922	2011-09-12 16:53:25.301305	2011-09-12 16:53:25.301305
13	Prairie Chevaux	13.2599999999999998	2011-09-12 16:53:25.303558	2011-09-12 16:53:25.303558
14	Sous l'eglise	1.35000000000000009	2011-09-12 16:53:25.306075	2011-09-12 16:53:25.306075
15	Reserve	2.54999999999999982	2011-09-12 16:53:25.308306	2011-09-12 16:53:25.308306
16	Lavernier	0.75	2011-09-12 16:53:25.310517	2011-09-12 16:53:25.310517
17	Le Bourg-1	0.520000000000000018	2011-09-12 16:53:25.31268	2011-09-12 16:53:25.31268
\.


--
-- Data for Name: zonetopas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY zonetopas (id, saison_id, parcelle_id, zone_id, value, created_at, updated_at) FROM stdin;
1	1	1	1	14	2011-09-12 16:53:34.667058	2011-09-12 16:53:34.667058
2	1	2	2	5	2011-09-12 16:53:34.676787	2011-09-12 16:53:34.676787
3	1	3	8	5	2011-09-12 16:53:34.684681	2011-09-12 16:53:34.684681
4	1	4	8	4	2011-09-12 16:53:34.691648	2011-09-12 16:53:34.691648
5	1	5	8	7	2011-09-12 16:53:34.698209	2011-09-12 16:53:34.698209
6	1	6	3	10	2011-09-12 16:53:34.705312	2011-09-12 16:53:34.705312
7	1	7	3	14	2011-09-12 16:53:34.711419	2011-09-12 16:53:34.711419
8	1	8	3	14	2011-09-12 16:53:34.718408	2011-09-12 16:53:34.718408
9	1	9	3	9	2011-09-12 16:53:34.725024	2011-09-12 16:53:34.725024
10	1	10	4	2	2011-09-12 16:53:34.732311	2011-09-12 16:53:34.732311
11	1	11	5	11	2011-09-12 16:53:34.739507	2011-09-12 16:53:34.739507
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

