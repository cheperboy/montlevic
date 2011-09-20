--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.4
-- Dumped by pg_dump version 9.0.4
-- Started on 2011-09-20 08:57:09 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 401 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1602 (class 1259 OID 66642)
-- Dependencies: 5
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
-- TOC entry 1601 (class 1259 OID 66640)
-- Dependencies: 5 1602
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 1601
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 1601
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('categories_id_seq', 25, true);


--
-- TOC entry 1598 (class 1259 OID 66626)
-- Dependencies: 5
-- Name: charges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE charges (
    toto integer
);


--
-- TOC entry 1620 (class 1259 OID 66726)
-- Dependencies: 5
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
-- TOC entry 1619 (class 1259 OID 66724)
-- Dependencies: 1620 5
-- Name: facdivs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE facdivs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 1619
-- Name: facdivs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE facdivs_id_seq OWNED BY facdivs.id;


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 1619
-- Name: facdivs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('facdivs_id_seq', 1, false);


--
-- TOC entry 1604 (class 1259 OID 66650)
-- Dependencies: 5
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
-- TOC entry 1603 (class 1259 OID 66648)
-- Dependencies: 1604 5
-- Name: factcats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factcats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 1603
-- Name: factcats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factcats_id_seq OWNED BY factcats.id;


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 1603
-- Name: factcats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factcats_id_seq', 3, true);


--
-- TOC entry 1622 (class 1259 OID 66737)
-- Dependencies: 5
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
-- TOC entry 1621 (class 1259 OID 66735)
-- Dependencies: 1622 5
-- Name: factoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 1621
-- Name: factoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factoparcelles_id_seq OWNED BY factoparcelles.id;


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 1621
-- Name: factoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factoparcelles_id_seq', 1, false);


--
-- TOC entry 1618 (class 1259 OID 66715)
-- Dependencies: 5
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
-- TOC entry 1617 (class 1259 OID 66713)
-- Dependencies: 1618 5
-- Name: factures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 1617
-- Name: factures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factures_id_seq OWNED BY factures.id;


--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 1617
-- Name: factures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factures_id_seq', 45, true);


--
-- TOC entry 1600 (class 1259 OID 66631)
-- Dependencies: 5
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
-- TOC entry 1599 (class 1259 OID 66629)
-- Dependencies: 5 1600
-- Name: factypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 1599
-- Name: factypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factypes_id_seq OWNED BY factypes.id;


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 1599
-- Name: factypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factypes_id_seq', 3, true);


--
-- TOC entry 1636 (class 1259 OID 66799)
-- Dependencies: 5
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
-- TOC entry 1635 (class 1259 OID 66797)
-- Dependencies: 1636 5
-- Name: labours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 1635
-- Name: labours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labours_id_seq OWNED BY labours.id;


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 1635
-- Name: labours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labours_id_seq', 7, true);


--
-- TOC entry 1638 (class 1259 OID 66810)
-- Dependencies: 5
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
-- TOC entry 1637 (class 1259 OID 66808)
-- Dependencies: 1638 5
-- Name: labtofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labtofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2055 (class 0 OID 0)
-- Dependencies: 1637
-- Name: labtofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labtofactures_id_seq OWNED BY labtofactures.id;


--
-- TOC entry 2056 (class 0 OID 0)
-- Dependencies: 1637
-- Name: labtofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labtofactures_id_seq', 1, false);


--
-- TOC entry 1640 (class 1259 OID 66818)
-- Dependencies: 5
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
-- TOC entry 1639 (class 1259 OID 66816)
-- Dependencies: 1640 5
-- Name: labtoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE labtoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2057 (class 0 OID 0)
-- Dependencies: 1639
-- Name: labtoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE labtoparcelles_id_seq OWNED BY labtoparcelles.id;


--
-- TOC entry 2058 (class 0 OID 0)
-- Dependencies: 1639
-- Name: labtoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('labtoparcelles_id_seq', 21, true);


--
-- TOC entry 1616 (class 1259 OID 66704)
-- Dependencies: 5
-- Name: myusers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE myusers (
    id integer NOT NULL,
    login character varying(255),
    password character varying(255),
    admin smallint
);


--
-- TOC entry 1615 (class 1259 OID 66702)
-- Dependencies: 5 1616
-- Name: myusers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE myusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 1615
-- Name: myusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE myusers_id_seq OWNED BY myusers.id;


--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 1615
-- Name: myusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('myusers_id_seq', 4, true);


--
-- TOC entry 1642 (class 1259 OID 66826)
-- Dependencies: 5
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
-- TOC entry 1641 (class 1259 OID 66824)
-- Dependencies: 5 1642
-- Name: parcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 1641
-- Name: parcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parcelles_id_seq OWNED BY parcelles.id;


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 1641
-- Name: parcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('parcelles_id_seq', 11, true);


--
-- TOC entry 1624 (class 1259 OID 66745)
-- Dependencies: 5
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
-- TOC entry 1623 (class 1259 OID 66743)
-- Dependencies: 1624 5
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE produits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 1623
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE produits_id_seq OWNED BY produits.id;


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 1623
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('produits_id_seq', 49, true);


--
-- TOC entry 1626 (class 1259 OID 66756)
-- Dependencies: 5
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
-- TOC entry 1625 (class 1259 OID 66754)
-- Dependencies: 1626 5
-- Name: protofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE protofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 1625
-- Name: protofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE protofactures_id_seq OWNED BY protofactures.id;


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 1625
-- Name: protofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('protofactures_id_seq', 54, true);


--
-- TOC entry 1630 (class 1259 OID 66772)
-- Dependencies: 5
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
-- TOC entry 1629 (class 1259 OID 66770)
-- Dependencies: 5 1630
-- Name: pulves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pulves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 1629
-- Name: pulves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pulves_id_seq OWNED BY pulves.id;


--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 1629
-- Name: pulves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pulves_id_seq', 77, true);


--
-- TOC entry 1632 (class 1259 OID 66783)
-- Dependencies: 5
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
-- TOC entry 1631 (class 1259 OID 66781)
-- Dependencies: 5 1632
-- Name: putofactures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 1631
-- Name: putofactures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putofactures_id_seq OWNED BY putofactures.id;


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 1631
-- Name: putofactures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putofactures_id_seq', 1, false);


--
-- TOC entry 1634 (class 1259 OID 66791)
-- Dependencies: 5
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
-- TOC entry 1633 (class 1259 OID 66789)
-- Dependencies: 1634 5
-- Name: putoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 1633
-- Name: putoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putoparcelles_id_seq OWNED BY putoparcelles.id;


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 1633
-- Name: putoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putoparcelles_id_seq', 77, true);


--
-- TOC entry 1628 (class 1259 OID 66764)
-- Dependencies: 5
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
-- TOC entry 1627 (class 1259 OID 66762)
-- Dependencies: 5 1628
-- Name: putoproduits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE putoproduits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 1627
-- Name: putoproduits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE putoproduits_id_seq OWNED BY putoproduits.id;


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 1627
-- Name: putoproduits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('putoproduits_id_seq', 89, true);


--
-- TOC entry 1610 (class 1259 OID 66677)
-- Dependencies: 5
-- Name: saisons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE saisons (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    year character varying(255),
    "desc" text
);


--
-- TOC entry 1609 (class 1259 OID 66675)
-- Dependencies: 5 1610
-- Name: saisons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE saisons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 1609
-- Name: saisons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE saisons_id_seq OWNED BY saisons.id;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 1609
-- Name: saisons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('saisons_id_seq', 1, true);


--
-- TOC entry 1593 (class 1259 OID 62768)
-- Dependencies: 5
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- TOC entry 1612 (class 1259 OID 66688)
-- Dependencies: 5
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
-- TOC entry 1611 (class 1259 OID 66686)
-- Dependencies: 1612 5
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 1611
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 1611
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('settings_id_seq', 1, true);


--
-- TOC entry 1597 (class 1259 OID 66620)
-- Dependencies: 5
-- Name: typecultures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE typecultures (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- TOC entry 1596 (class 1259 OID 66618)
-- Dependencies: 1597 5
-- Name: typecultures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE typecultures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 1596
-- Name: typecultures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE typecultures_id_seq OWNED BY typecultures.id;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 1596
-- Name: typecultures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('typecultures_id_seq', 6, true);


--
-- TOC entry 1608 (class 1259 OID 66669)
-- Dependencies: 5
-- Name: upcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE upcategories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 1607 (class 1259 OID 66667)
-- Dependencies: 5 1608
-- Name: upcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE upcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 1607
-- Name: upcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE upcategories_id_seq OWNED BY upcategories.id;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 1607
-- Name: upcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('upcategories_id_seq', 4, true);


--
-- TOC entry 1606 (class 1259 OID 66661)
-- Dependencies: 5
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 1605 (class 1259 OID 66659)
-- Dependencies: 5 1606
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 1605
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 1605
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 34, true);


--
-- TOC entry 1646 (class 1259 OID 66845)
-- Dependencies: 5
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
-- TOC entry 1645 (class 1259 OID 66843)
-- Dependencies: 5 1646
-- Name: ventes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ventes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 1645
-- Name: ventes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ventes_id_seq OWNED BY ventes.id;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 1645
-- Name: ventes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ventes_id_seq', 1, false);


--
-- TOC entry 1648 (class 1259 OID 66856)
-- Dependencies: 5
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
-- TOC entry 1647 (class 1259 OID 66854)
-- Dependencies: 1648 5
-- Name: ventoparcelles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ventoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 1647
-- Name: ventoparcelles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ventoparcelles_id_seq OWNED BY ventoparcelles.id;


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 1647
-- Name: ventoparcelles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ventoparcelles_id_seq', 1, false);


--
-- TOC entry 1614 (class 1259 OID 66696)
-- Dependencies: 5
-- Name: verifs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE verifs (
    id integer NOT NULL,
    name character varying(255)
);


--
-- TOC entry 1613 (class 1259 OID 66694)
-- Dependencies: 5 1614
-- Name: verifs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE verifs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 1613
-- Name: verifs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE verifs_id_seq OWNED BY verifs.id;


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 1613
-- Name: verifs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('verifs_id_seq', 1, false);


--
-- TOC entry 1595 (class 1259 OID 66612)
-- Dependencies: 5
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
-- TOC entry 1594 (class 1259 OID 66610)
-- Dependencies: 5 1595
-- Name: zones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 1594
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE zones_id_seq OWNED BY zones.id;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 1594
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('zones_id_seq', 20, true);


--
-- TOC entry 1644 (class 1259 OID 66837)
-- Dependencies: 5
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
-- TOC entry 1643 (class 1259 OID 66835)
-- Dependencies: 5 1644
-- Name: zonetopas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE zonetopas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 1643
-- Name: zonetopas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE zonetopas_id_seq OWNED BY zonetopas.id;


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 1643
-- Name: zonetopas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('zonetopas_id_seq', 11, true);


--
-- TOC entry 1929 (class 2604 OID 66645)
-- Dependencies: 1601 1602 1602
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- TOC entry 1938 (class 2604 OID 66729)
-- Dependencies: 1619 1620 1620
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE facdivs ALTER COLUMN id SET DEFAULT nextval('facdivs_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 66653)
-- Dependencies: 1604 1603 1604
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factcats ALTER COLUMN id SET DEFAULT nextval('factcats_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 66740)
-- Dependencies: 1621 1622 1622
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factoparcelles ALTER COLUMN id SET DEFAULT nextval('factoparcelles_id_seq'::regclass);


--
-- TOC entry 1937 (class 2604 OID 66718)
-- Dependencies: 1617 1618 1618
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factures ALTER COLUMN id SET DEFAULT nextval('factures_id_seq'::regclass);


--
-- TOC entry 1928 (class 2604 OID 66634)
-- Dependencies: 1599 1600 1600
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE factypes ALTER COLUMN id SET DEFAULT nextval('factypes_id_seq'::regclass);


--
-- TOC entry 1946 (class 2604 OID 66802)
-- Dependencies: 1635 1636 1636
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labours ALTER COLUMN id SET DEFAULT nextval('labours_id_seq'::regclass);


--
-- TOC entry 1947 (class 2604 OID 66813)
-- Dependencies: 1637 1638 1638
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labtofactures ALTER COLUMN id SET DEFAULT nextval('labtofactures_id_seq'::regclass);


--
-- TOC entry 1948 (class 2604 OID 66821)
-- Dependencies: 1640 1639 1640
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE labtoparcelles ALTER COLUMN id SET DEFAULT nextval('labtoparcelles_id_seq'::regclass);


--
-- TOC entry 1936 (class 2604 OID 66707)
-- Dependencies: 1615 1616 1616
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE myusers ALTER COLUMN id SET DEFAULT nextval('myusers_id_seq'::regclass);


--
-- TOC entry 1949 (class 2604 OID 66829)
-- Dependencies: 1641 1642 1642
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE parcelles ALTER COLUMN id SET DEFAULT nextval('parcelles_id_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 66748)
-- Dependencies: 1623 1624 1624
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE produits ALTER COLUMN id SET DEFAULT nextval('produits_id_seq'::regclass);


--
-- TOC entry 1941 (class 2604 OID 66759)
-- Dependencies: 1626 1625 1626
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE protofactures ALTER COLUMN id SET DEFAULT nextval('protofactures_id_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 66775)
-- Dependencies: 1630 1629 1630
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE pulves ALTER COLUMN id SET DEFAULT nextval('pulves_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 66786)
-- Dependencies: 1632 1631 1632
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putofactures ALTER COLUMN id SET DEFAULT nextval('putofactures_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 66794)
-- Dependencies: 1633 1634 1634
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putoparcelles ALTER COLUMN id SET DEFAULT nextval('putoparcelles_id_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 66767)
-- Dependencies: 1627 1628 1628
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE putoproduits ALTER COLUMN id SET DEFAULT nextval('putoproduits_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 66680)
-- Dependencies: 1609 1610 1610
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE saisons ALTER COLUMN id SET DEFAULT nextval('saisons_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 66691)
-- Dependencies: 1611 1612 1612
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- TOC entry 1927 (class 2604 OID 66623)
-- Dependencies: 1597 1596 1597
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE typecultures ALTER COLUMN id SET DEFAULT nextval('typecultures_id_seq'::regclass);


--
-- TOC entry 1932 (class 2604 OID 66672)
-- Dependencies: 1607 1608 1608
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE upcategories ALTER COLUMN id SET DEFAULT nextval('upcategories_id_seq'::regclass);


--
-- TOC entry 1931 (class 2604 OID 66664)
-- Dependencies: 1605 1606 1606
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1951 (class 2604 OID 66848)
-- Dependencies: 1645 1646 1646
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ventes ALTER COLUMN id SET DEFAULT nextval('ventes_id_seq'::regclass);


--
-- TOC entry 1952 (class 2604 OID 66859)
-- Dependencies: 1647 1648 1648
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ventoparcelles ALTER COLUMN id SET DEFAULT nextval('ventoparcelles_id_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 66699)
-- Dependencies: 1614 1613 1614
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE verifs ALTER COLUMN id SET DEFAULT nextval('verifs_id_seq'::regclass);


--
-- TOC entry 1926 (class 2604 OID 66615)
-- Dependencies: 1594 1595 1595
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE zones ALTER COLUMN id SET DEFAULT nextval('zones_id_seq'::regclass);


--
-- TOC entry 1950 (class 2604 OID 66840)
-- Dependencies: 1644 1643 1644
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE zonetopas ALTER COLUMN id SET DEFAULT nextval('zonetopas_id_seq'::regclass);


--
-- TOC entry 2013 (class 0 OID 66642)
-- Dependencies: 1602
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY categories (id, upcategory_id, name, created_at, updated_at) FROM stdin;
1	1	frais generaux	2011-09-19 16:56:11.849356	2011-09-19 16:56:11.849356
2	1	produits phyto	2011-09-19 16:56:11.854661	2011-09-19 16:56:11.854661
3	1	semences	2011-09-19 16:56:11.857179	2011-09-19 16:56:11.857179
4	1	mecanique	2011-09-19 16:56:11.859662	2011-09-19 16:56:11.859662
5	1	batiments	2011-09-19 16:56:11.862186	2011-09-19 16:56:11.862186
6	1	deplacement	2011-09-19 16:56:11.865004	2011-09-19 16:56:11.865004
7	1	frais de gestion	2011-09-19 16:56:11.867605	2011-09-19 16:56:11.867605
8	1	service agricole	2011-09-19 16:56:11.869996	2011-09-19 16:56:11.869996
9	2	divers	2011-09-19 16:56:11.872443	2011-09-19 16:56:11.872443
10	2	azote	2011-09-19 16:56:11.874705	2011-09-19 16:56:11.874705
11	2	desherbant	2011-09-19 16:56:11.877095	2011-09-19 16:56:11.877095
12	2	engrais	2011-09-19 16:56:11.879453	2011-09-19 16:56:11.879453
13	2	fongicide	2011-09-19 16:56:11.881991	2011-09-19 16:56:11.881991
14	2	herbicide	2011-09-19 16:56:11.8844	2011-09-19 16:56:11.8844
15	2	insecticide	2011-09-19 16:56:11.886675	2011-09-19 16:56:11.886675
16	2	oligo	2011-09-19 16:56:11.889242	2011-09-19 16:56:11.889242
17	2	semis	2011-09-19 16:56:11.891572	2011-09-19 16:56:11.891572
18	2	soufre	2011-09-19 16:56:11.893836	2011-09-19 16:56:11.893836
19	3	moisson	2011-09-19 16:56:11.896177	2011-09-19 16:56:11.896177
20	3	covercrop	2011-09-19 16:56:11.898435	2011-09-19 16:56:11.898435
21	3	vibro	2011-09-19 16:56:11.900709	2011-09-19 16:56:11.900709
22	3	herse	2011-09-19 16:56:11.902957	2011-09-19 16:56:11.902957
23	4	foin	2011-09-19 16:56:11.905255	2011-09-19 16:56:11.905255
24	4	PAC	2011-09-19 16:56:11.908383	2011-09-19 16:56:11.908383
25	4	Avoir	2011-09-19 16:56:11.910901	2011-09-19 16:56:11.910901
\.


--
-- TOC entry 2011 (class 0 OID 66626)
-- Dependencies: 1598
-- Data for Name: charges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY charges (toto) FROM stdin;
\.


--
-- TOC entry 2022 (class 0 OID 66726)
-- Dependencies: 1620
-- Data for Name: facdivs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY facdivs (id, facture_id, saison_id, category_id, star, adu, user_id, name, cout, ref_client, ref, date, "desc", created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2014 (class 0 OID 66650)
-- Dependencies: 1604
-- Data for Name: factcats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factcats (id, name, "desc", created_at, updated_at) FROM stdin;
1	agri	\N	2011-09-19 16:56:11.917028	2011-09-19 16:56:11.917028
2	maison	\N	2011-09-19 16:56:11.922037	2011-09-19 16:56:11.922037
3	invest	\N	2011-09-19 16:56:11.924743	2011-09-19 16:56:11.924743
\.


--
-- TOC entry 2023 (class 0 OID 66737)
-- Dependencies: 1622
-- Data for Name: factoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factoparcelles (id, saison_id, parcelle_id, facture_id, value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2021 (class 0 OID 66715)
-- Dependencies: 1618
-- Data for Name: factures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factures (id, saison_id, category_id, factcat_id, factype_id, reportable_id, type, star, adu, date, user_id, name, cout, ref_client, ref, "desc", created_at, updated_at) FROM stdin;
1	1	2	1	1	\N	Debit	0	\N	2010-11-30	3	Sacs B.B Adivalor	2.5	01-2010-1187	1	1 sac big bag	2011-09-19 16:56:18.52087	2011-09-19 16:56:18.52087
2	1	2	1	1	\N	Debit	0	\N	2011-01-21	3	Super 45% BB	3069	01-2010-1429	2		2011-09-19 16:56:18.529785	2011-09-19 16:56:18.529785
3	1	2	1	1	\N	Debit	0	\N	2011-01-24	3	engrais 0-20-30	1260.79999999999995	01-2011-1448	3		2011-09-19 16:56:18.545948	2011-09-19 16:56:18.545948
4	1	2	1	1	\N	Debit	0	\N	2011-04-30	3	Sacs B.B Adivalor	5	01-2010-2593	4	2 sac big bag	2011-09-19 16:56:18.554578	2011-09-19 16:56:18.554578
5	1	2	1	1	\N	Debit	0	\N	2011-03-29	3	engrais 0-20-30	2000	01-2010-1982	5		2011-09-19 16:56:18.560061	2011-09-19 16:56:18.560061
6	1	2	1	1	\N	Debit	1	\N	2011-03-11	3	Semance Campus	994	01-2010-1767	6		2011-09-19 16:56:18.568471	2011-09-19 16:56:18.568471
7	1	2	1	1	\N	Debit	1	\N	2011-03-11	3	produits phyto 1	4402.19999999999982	01-2010-1767	7	pas de prix HT. Verifier la somme.	2011-09-19 16:56:18.577051	2011-09-19 16:56:18.577051
8	1	2	1	1	\N	Debit	0	\N	2011-02-28	3	azomag	1680	01-2010-1737	8	azomag 16 BB	2011-09-19 16:56:18.607555	2011-09-19 16:56:18.607555
9	1	2	1	1	\N	Debit	0	\N	2011-04-30	3	produits phyto 2	1654	01-2010-2594	9	avoir de 2% sous condition	2011-09-19 16:56:18.615837	2011-09-19 16:56:18.615837
10	1	2	1	1	\N	Debit	0	\N	2011-03-11	3	produits phyto 3	6314.35000000000036	01-2010-1767	10	avoir de 2% + 3% sauf glifonet -0,30€	2011-09-19 16:56:18.637318	2011-09-19 16:56:18.637318
11	1	2	1	1	\N	Debit	1	\N	2010-08-31	3	Ammonitrate	9204	01-2010-250	11	voire indications manuscrites sur la facture	2011-09-19 16:56:18.669102	2011-09-19 16:56:18.669102
12	1	2	1	1	\N	Debit	1	\N	2010-10-31	3	produits phyto 4	998.990000000000009	01-2010-975	12	avoir de 13,25 à prendre en compte	2011-09-19 16:56:18.679777	2011-09-19 16:56:18.679777
13	1	2	1	1	\N	Debit	0	\N	2010-09-27	3	produits phyto 5	4907.39999999999964	01-2010-471	13		2011-09-19 16:56:18.764196	2011-09-19 16:56:18.764196
14	1	2	1	1	\N	Debit	0	\N	2010-09-30	3	produits phyto 6	246	01-2010-689	14		2011-09-19 16:56:18.778514	2011-09-19 16:56:18.778514
15	1	2	1	1	\N	Debit	0	\N	2010-10-20	13	vitavax + BB	746.580000000000041	22269	15	vitavax + Big BagsBB : 8x9,41=75,24€ à répartir	2011-09-19 16:56:18.792318	2011-09-19 16:56:18.792318
16	1	2	1	1	\N	Debit	0	\N	2011-03-31	31	Fury 5L	163.699999999999989	FCT-1305	16		2011-09-19 16:56:18.79793	2011-09-19 16:56:18.79793
17	1	2	1	1	\N	Debit	1	\N	2011-02-28	13	Picabore + Challenge	1221.80999999999995	24302	17		2011-09-19 16:56:18.806127	2011-09-19 16:56:18.806127
18	1	2	1	1	\N	Debit	0	\N	2011-06-28	31	produits phyto 7	389.899999999999977	FCC-1629	18	produits + Bib Bag 1,50x1,60 : 10x10=100€ a répartir	2011-09-19 16:56:18.819885	2011-09-19 16:56:18.819885
19	1	2	1	1	\N	Debit	0	\N	2010-07-10	31	nuvagrain	51.259999999999998	FCC-44	19		2011-09-19 16:56:18.831303	2011-09-19 16:56:18.831303
20	1	8	1	1	\N	Debit	1	\N	2011-03-27	32	semis tournesol	260	015-2011	20	20ha x 13€/ha = 260€	2011-09-19 16:56:18.839549	2011-09-19 16:56:18.839549
22	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 19	3537.5	19	21		2011-09-19 16:56:18.865981	2011-09-19 16:56:18.865981
23	1	8	1	1	22	Report	0	\N	2011-01-30	2	Pulvérisation	955	19	21	95,5Ha x 10€ = 955€	2011-09-19 16:56:18.879847	2011-09-19 16:56:18.879847
24	1	8	1	1	22	Report	0	\N	2011-01-30	2	Broyage haies	456	19	21	12h x 38€ = 456€	2011-09-19 16:56:18.887836	2011-09-19 16:56:18.887836
25	1	8	1	1	22	Report	0	\N	2011-01-30	2	Broyage horizontal	297.5	19	21	8h50 x 35€/h = 297,5	2011-09-19 16:56:18.893546	2011-09-19 16:56:18.893546
26	1	8	1	1	22	Report	0	\N	2011-01-30	2	Semis Colza et Blé	1829	19	21	59ha x 31€/ha = 1829€	2011-09-19 16:56:18.898969	2011-09-19 16:56:18.898969
27	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 18	3515	18	22		2011-09-19 16:56:18.904277	2011-09-19 16:56:18.904277
28	1	8	1	1	27	Report	0	\N	2011-01-30	2	Roulage	465	18	22	15h30 x 30€/h = 465€	2011-09-19 16:56:18.90971	2011-09-19 16:56:18.90971
29	1	8	1	1	27	Report	0	\N	2011-01-30	2	Cover-crop	2240	18	22	64h x 35€/h = 2240€	2011-09-19 16:56:18.915402	2011-09-19 16:56:18.915402
30	1	8	1	1	27	Report	0	\N	2011-01-30	2	Vibro	810	18	22	81ha x 10€ = 810€	2011-09-19 16:56:18.92113	2011-09-19 16:56:18.92113
31	1	8	1	3	\N	Reportable	0	\N	2011-01-30	2	facture 20	2950	20	23		2011-09-19 16:56:18.926649	2011-09-19 16:56:18.926649
32	1	8	1	1	31	Report	0	\N	2011-01-30	2	Labour + Herse	2830	20	23	(semis prairies)	2011-09-19 16:56:18.932354	2011-09-19 16:56:18.932354
33	1	8	1	1	31	Report	0	\N	2011-01-30	2	Epandage chaux	120	20	23		2011-09-19 16:56:19.002815	2011-09-19 16:56:19.002815
34	1	8	1	3	\N	Reportable	0	\N	2011-07-19	2	facture 24	5790	24	24		2011-09-19 16:56:19.009027	2011-09-19 16:56:19.009027
35	1	8	1	1	34	Report	0	\N	2011-07-19	2	Epandage engrais	2520	24	24	252 ha x 10€ = 2520€	2011-09-19 16:56:19.015001	2011-09-19 16:56:19.015001
36	1	8	1	1	34	Report	0	\N	2011-07-19	2	Pulvérisation cultures	2850	24	24	285 ha x 10€ = 2850€	2011-09-19 16:56:19.020843	2011-09-19 16:56:19.020843
37	1	8	1	1	34	Report	0	\N	2011-07-19	2	tours de champs	120	24	24	4h x 30€/h = 120€ (desherbage)	2011-09-19 16:56:19.026479	2011-09-19 16:56:19.026479
38	1	8	1	1	34	Report	0	\N	2011-07-19	2	semis tournesol	300	24	24	20ha x 15€/ha = 300€ (Semis tournesol Tracteur)	2011-09-19 16:56:19.032185	2011-09-19 16:56:19.032185
39	1	8	1	3	\N	Reportable	0	\N	2011-07-19	2	facture 25	226.400000000000006	25	25		2011-09-19 16:56:19.037683	2011-09-19 16:56:19.037683
40	1	8	1	1	39	Report	0	\N	2011-07-19	2	Vibro	200	25	25	20ha x 10€ = 200€	2011-09-19 16:56:19.04339	2011-09-19 16:56:19.04339
41	1	8	1	1	39	Report	0	\N	2011-07-19	2	Orge	26.3999999999999986	25	25	150kg x 176€/t = 26,40€	2011-09-19 16:56:19.048848	2011-09-19 16:56:19.048848
42	1	8	1	3	\N	Reportable	0	\N	2010-11-07	2	facture 50	6986	50	26		2011-09-19 16:56:19.054501	2011-09-19 16:56:19.054501
43	1	8	1	1	42	Report	0	\N	2010-11-07	2	Moissonnage Blé colza, Tournesol	6375	50	26	85ha x 75€/ha = 6375€	2011-09-19 16:56:19.059848	2011-09-19 16:56:19.059848
44	1	8	1	1	42	Report	0	\N	2010-11-07	2	Transport Céréales	611	50	26	13 voyages x 47€ = 611€	2011-09-19 16:56:19.065306	2011-09-19 16:56:19.065306
45	1	8	1	3	\N	Debit	0	\N	2010-11-10	2	facture 14 : Pressage	3312	14	27		2011-09-19 16:56:19.071212	2011-09-19 16:56:19.071212
21	1	2	1	1	\N	Debit	1	0	2011-02-28	3	PRODUITS MANQUANTS	1293.59999999999991	0000	21		2011-09-19 16:56:18.846103	2011-09-19 17:02:03.57804
\.


--
-- TOC entry 2012 (class 0 OID 66631)
-- Dependencies: 1600
-- Data for Name: factypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY factypes (id, name, display, "desc", created_at, updated_at) FROM stdin;
1	diff	diff	test desc	2011-09-19 16:56:11.950353	2011-09-19 16:56:11.950353
2	total	total	test desc	2011-09-19 16:56:11.955237	2011-09-19 16:56:11.955237
3	null	null	test desc	2011-09-19 16:56:11.957468	2011-09-19 16:56:11.957468
\.


--
-- TOC entry 2030 (class 0 OID 66799)
-- Dependencies: 1636
-- Data for Name: labours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labours (id, saison_id, category_id, user_id, date, name, cout_ha_passage, "desc", star, adu, created_at, updated_at) FROM stdin;
1	1	20	2	2010-05-01	déchaumage blé - 1	10	date inconnue	0	\N	2011-09-19 16:56:19.151376	2011-09-19 16:56:19.151376
2	1	20	2	2010-05-01	déchaumage blé - 1	10	date inconnue	0	\N	2011-09-19 16:56:20.336203	2011-09-19 16:56:20.336203
3	1	20	2	2010-05-02	déchaumage blé - 2	10	date inconnue	0	\N	2011-09-19 16:56:20.341289	2011-09-19 16:56:20.341289
4	1	20	2	2010-05-03	déchaumage blé - 3	10	date inconnue	0	\N	2011-09-19 16:56:20.346371	2011-09-19 16:56:20.346371
5	1	19	2	2010-05-01	moisson blé	75	date inconnue	0	\N	2011-09-19 16:56:20.353492	2011-09-19 16:56:20.353492
6	1	19	2	2010-05-01	moisson tournesol	75	date inconnue	0	\N	2011-09-19 16:56:20.415792	2011-09-19 16:56:20.415792
7	1	19	2	2010-05-01	moisson colza	75	date inconnue	0	\N	2011-09-19 16:56:20.428271	2011-09-19 16:56:20.428271
\.


--
-- TOC entry 2031 (class 0 OID 66810)
-- Dependencies: 1638
-- Data for Name: labtofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtofactures (id, saison_id, facture_id, labour_id, value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2032 (class 0 OID 66818)
-- Dependencies: 1640
-- Data for Name: labtoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY labtoparcelles (id, saison_id, parcelle_id, labour_id, value, created_at, updated_at) FROM stdin;
1	1	11	1	0	2011-09-19 16:56:19.221886	2011-09-19 16:56:19.221886
2	1	2	2	0	2011-09-19 16:56:20.358047	2011-09-19 16:56:20.358047
3	1	2	3	0	2011-09-19 16:56:20.364368	2011-09-19 16:56:20.364368
4	1	2	4	0	2011-09-19 16:56:20.370413	2011-09-19 16:56:20.370413
5	1	2	5	0	2011-09-19 16:56:20.373156	2011-09-19 16:56:20.373156
6	1	1	2	0	2011-09-19 16:56:20.375827	2011-09-19 16:56:20.375827
7	1	1	3	0	2011-09-19 16:56:20.378472	2011-09-19 16:56:20.378472
8	1	1	4	0	2011-09-19 16:56:20.381529	2011-09-19 16:56:20.381529
9	1	1	5	0	2011-09-19 16:56:20.384965	2011-09-19 16:56:20.384965
10	1	6	2	0	2011-09-19 16:56:20.387588	2011-09-19 16:56:20.387588
11	1	6	3	0	2011-09-19 16:56:20.390028	2011-09-19 16:56:20.390028
12	1	6	4	0	2011-09-19 16:56:20.392502	2011-09-19 16:56:20.392502
13	1	6	5	0	2011-09-19 16:56:20.395733	2011-09-19 16:56:20.395733
14	1	7	2	0	2011-09-19 16:56:20.400613	2011-09-19 16:56:20.400613
15	1	7	3	0	2011-09-19 16:56:20.404137	2011-09-19 16:56:20.404137
16	1	7	4	0	2011-09-19 16:56:20.407065	2011-09-19 16:56:20.407065
17	1	7	5	0	2011-09-19 16:56:20.410005	2011-09-19 16:56:20.410005
18	1	9	6	0	2011-09-19 16:56:20.421869	2011-09-19 16:56:20.421869
19	1	11	6	0	2011-09-19 16:56:20.424748	2011-09-19 16:56:20.424748
20	1	10	7	1	2011-09-19 16:56:20.432821	2011-09-19 16:57:26.44414
21	1	8	7	1	2011-09-19 16:56:20.435468	2011-09-19 16:57:26.446728
\.


--
-- TOC entry 2020 (class 0 OID 66704)
-- Dependencies: 1616
-- Data for Name: myusers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY myusers (id, login, password, admin) FROM stdin;
1	admin	admin	1
2	matthieu		0
3	elisabeth	elisabeth	0
4	thierry	thierry	0
\.


--
-- TOC entry 2033 (class 0 OID 66826)
-- Dependencies: 1642
-- Data for Name: parcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY parcelles (id, saison_id, typeculture_id, name, surface, "desc", created_at, updated_at) FROM stdin;
1	1	1	Bruneau	14	\N	2011-09-19 16:56:18.12225	2011-09-19 16:56:18.12225
2	1	1	Mitant	5	\N	2011-09-19 16:56:18.141536	2011-09-19 16:56:18.141536
3	1	5	Feuillets 1	5	\N	2011-09-19 16:56:18.148497	2011-09-19 16:56:18.148497
4	1	5	Feuillets 2	4	\N	2011-09-19 16:56:18.154711	2011-09-19 16:56:18.154711
5	1	5	Feuillets 3	7	\N	2011-09-19 16:56:18.161603	2011-09-19 16:56:18.161603
6	1	1	Pont des champs	10	\N	2011-09-19 16:56:18.168663	2011-09-19 16:56:18.168663
7	1	1	Aeromodelisme	14	\N	2011-09-19 16:56:18.17566	2011-09-19 16:56:18.17566
8	1	4	Derierre	14	\N	2011-09-19 16:56:18.181951	2011-09-19 16:56:18.181951
9	1	3	Champ du Milieu	9	\N	2011-09-19 16:56:18.188366	2011-09-19 16:56:18.188366
10	1	4	Basse-cour	2	\N	2011-09-19 16:56:18.195669	2011-09-19 16:56:18.195669
11	1	3	Vallees	11	\N	2011-09-19 16:56:18.202525	2011-09-19 16:56:18.202525
\.


--
-- TOC entry 2024 (class 0 OID 66745)
-- Dependencies: 1624
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY produits (id, category_id, saison_id, name, "desc", unit, star, adu, created_at, updated_at) FROM stdin;
1	9	1	Altigo		kg	\N	\N	2011-09-19 16:56:18.224661	2011-09-19 16:56:18.224661
2	13	1	Amistar Xtra		L	\N	\N	2011-09-19 16:56:18.230831	2011-09-19 16:56:18.230831
3	9	1	Ariane		L	\N	\N	2011-09-19 16:56:18.233967	2011-09-19 16:56:18.233967
4	17	1	Autan		kg	\N	\N	2011-09-19 16:56:18.296001	2011-09-19 16:56:18.296001
5	18	1	Azomag		kg	\N	\N	2011-09-19 16:56:18.29974	2011-09-19 16:56:18.29974
6	18	1	Azomag20		kg	\N	\N	2011-09-19 16:56:18.303034	2011-09-19 16:56:18.303034
7	10	1	Azote		L	\N	\N	2011-09-19 16:56:18.306212	2011-09-19 16:56:18.306212
8	13	1	Bravo Elite		L	\N	\N	2011-09-19 16:56:18.309341	2011-09-19 16:56:18.309341
9	17	1	Campo		kg	\N	\N	2011-09-19 16:56:18.312408	2011-09-19 16:56:18.312408
10	17	1	Campus		kg	\N	\N	2011-09-19 16:56:18.31542	2011-09-19 16:56:18.31542
11	17	1	Catalino		kg	\N	\N	2011-09-19 16:56:18.318471	2011-09-19 16:56:18.318471
12	11	1	Celtic		L	\N	\N	2011-09-19 16:56:18.321492	2011-09-19 16:56:18.321492
13	11	1	Challenge		L	\N	\N	2011-09-19 16:56:18.324454	2011-09-19 16:56:18.324454
14	11	1	Chardol		L	\N	\N	2011-09-19 16:56:18.327408	2011-09-19 16:56:18.327408
15	11	1	Chrono		L	\N	\N	2011-09-19 16:56:18.330464	2011-09-19 16:56:18.330464
16	11	1	Cline		L	\N	\N	2011-09-19 16:56:18.333442	2011-09-19 16:56:18.333442
17	11	1	Colzamid		L	\N	\N	2011-09-19 16:56:18.336354	2011-09-19 16:56:18.336354
18	13	1	Comet Player		L	\N	\N	2011-09-19 16:56:18.339547	2011-09-19 16:56:18.339547
19	12	1	15-15-15		kg	\N	\N	2011-09-19 16:56:18.342493	2011-09-19 16:56:18.342493
20	11	1	Folyr		L	\N	\N	2011-09-19 16:56:18.345506	2011-09-19 16:56:18.345506
21	15	1	Fury		L	\N	\N	2011-09-19 16:56:18.348755	2011-09-19 16:56:18.348755
22	11	1	Glifonet		L	\N	\N	2011-09-19 16:56:18.351869	2011-09-19 16:56:18.351869
23	17	1	Harmony		kg	\N	\N	2011-09-19 16:56:18.3554	2011-09-19 16:56:18.3554
24	9	1	Huile		L	\N	\N	2011-09-19 16:56:18.358451	2011-09-19 16:56:18.358451
25	17	1	Imperio		kg	\N	\N	2011-09-19 16:56:18.3614	2011-09-19 16:56:18.3614
26	9	1	Karate		L	\N	\N	2011-09-19 16:56:18.364381	2011-09-19 16:56:18.364381
27	17	1	Lontrel		kg	\N	\N	2011-09-19 16:56:18.367626	2011-09-19 16:56:18.367626
28	9	1	MAS 91		L	\N	\N	2011-09-19 16:56:18.37069	2011-09-19 16:56:18.37069
29	17	1	Novrel		kg	\N	\N	2011-09-19 16:56:18.373653	2011-09-19 16:56:18.373653
30	9	1	Nuvagrain		L	\N	\N	2011-09-19 16:56:18.376464	2011-09-19 16:56:18.376464
31	17	1	Ovation		kg	\N	\N	2011-09-19 16:56:18.379541	2011-09-19 16:56:18.379541
32	17	1	Paledor		kg	\N	\N	2011-09-19 16:56:18.382589	2011-09-19 16:56:18.382589
33	16	1	Picabore		kg	\N	\N	2011-09-19 16:56:18.385451	2011-09-19 16:56:18.385451
34	11	1	Picosolo		kg	\N	\N	2011-09-19 16:56:18.388558	2011-09-19 16:56:18.388558
35	17	1	Pr		kg	\N	\N	2011-09-19 16:56:18.391444	2011-09-19 16:56:18.391444
36	9	1	Proca		L	\N	\N	2011-09-19 16:56:18.394572	2011-09-19 16:56:18.394572
37	15	1	Proteus		L	\N	\N	2011-09-19 16:56:18.397348	2011-09-19 16:56:18.397348
38	11	1	Pulsar		L	\N	\N	2011-09-19 16:56:18.400134	2011-09-19 16:56:18.400134
39	9	1	Radar		L	\N	\N	2011-09-19 16:56:18.402948	2011-09-19 16:56:18.402948
40	9	1	Richepain		kg	\N	\N	2011-09-19 16:56:18.405935	2011-09-19 16:56:18.405935
41	9	1	spartan		L	\N	\N	2011-09-19 16:56:18.409011	2011-09-19 16:56:18.409011
42	11	1	Springbok		L	\N	\N	2011-09-19 16:56:18.412113	2011-09-19 16:56:18.412113
43	9	1	Stratos		L	\N	\N	2011-09-19 16:56:18.415125	2011-09-19 16:56:18.415125
44	12	1	Super45		kg	\N	\N	2011-09-19 16:56:18.418249	2011-09-19 16:56:18.418249
45	13	1	Surnog		L	\N	\N	2011-09-19 16:56:18.421342	2011-09-19 16:56:18.421342
46	11	1	Traxos		L	\N	\N	2011-09-19 16:56:18.424404	2011-09-19 16:56:18.424404
47	9	1	Vip		L	\N	\N	2011-09-19 16:56:18.427348	2011-09-19 16:56:18.427348
48	12	1	0-20-30		kg	\N	\N	2011-09-19 16:56:18.430527	2011-09-19 16:56:18.430527
49	12	1	0-25-25		kg	\N	\N	2011-09-19 16:56:18.433548	2011-09-19 16:56:18.433548
\.


--
-- TOC entry 2025 (class 0 OID 66756)
-- Dependencies: 1626
-- Data for Name: protofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY protofactures (id, saison_id, produit_id, facture_id, prix, quantite, created_at, updated_at) FROM stdin;
1	1	44	2	0.465000000000000024	6600	2011-09-19 16:56:18.539082	2011-09-19 16:56:18.539082
2	1	48	3	0.394000000000000017	3200	2011-09-19 16:56:18.550215	2011-09-19 16:56:18.550215
3	1	48	5	0.400000000000000022	5000	2011-09-19 16:56:18.564339	2011-09-19 16:56:18.564339
4	1	10	6	142	7	2011-09-19 16:56:18.572958	2011-09-19 16:56:18.572958
5	1	2	7	43.8999999999999986	10	2011-09-19 16:56:18.58112	2011-09-19 16:56:18.58112
6	1	16	7	20.8999999999999986	15	2011-09-19 16:56:18.584751	2011-09-19 16:56:18.584751
7	1	38	7	56.6000000000000014	10	2011-09-19 16:56:18.58813	2011-09-19 16:56:18.58813
8	1	22	7	3.79999999999999982	200	2011-09-19 16:56:18.590917	2011-09-19 16:56:18.590917
9	1	22	7	3.79999999999999982	100	2011-09-19 16:56:18.593494	2011-09-19 16:56:18.593494
10	1	24	7	2.39999999999999991	60	2011-09-19 16:56:18.596091	2011-09-19 16:56:18.596091
11	1	27	7	52.9500000000000028	12	2011-09-19 16:56:18.598577	2011-09-19 16:56:18.598577
12	1	15	7	37.8999999999999986	15	2011-09-19 16:56:18.601047	2011-09-19 16:56:18.601047
13	1	28	7	198.599999999999994	3	2011-09-19 16:56:18.603613	2011-09-19 16:56:18.603613
14	1	5	8	0.280000000000000027	6000	2011-09-19 16:56:18.611881	2011-09-19 16:56:18.611881
15	1	19	9	50	0.5	2011-09-19 16:56:18.619871	2011-09-19 16:56:18.619871
16	1	24	9	2.39999999999999991	20	2011-09-19 16:56:18.622422	2011-09-19 16:56:18.622422
17	1	47	9	67	10	2011-09-19 16:56:18.624927	2011-09-19 16:56:18.624927
18	1	3	9	15.4000000000000004	30	2011-09-19 16:56:18.627371	2011-09-19 16:56:18.627371
19	1	46	9	31.6499999999999986	10	2011-09-19 16:56:18.630606	2011-09-19 16:56:18.630606
20	1	26	9	132.5	1	2011-09-19 16:56:18.633214	2011-09-19 16:56:18.633214
21	1	43	10	18.8000000000000007	10	2011-09-19 16:56:18.641846	2011-09-19 16:56:18.641846
22	1	39	10	212.5	12	2011-09-19 16:56:18.644524	2011-09-19 16:56:18.644524
23	1	41	10	33.8999999999999986	5	2011-09-19 16:56:18.647155	2011-09-19 16:56:18.647155
24	1	27	10	52.9500000000000028	1	2011-09-19 16:56:18.649865	2011-09-19 16:56:18.649865
25	1	24	10	2.39999999999999991	20	2011-09-19 16:56:18.652472	2011-09-19 16:56:18.652472
26	1	39	10	212.5	2.20000000000000018	2011-09-19 16:56:18.65501	2011-09-19 16:56:18.65501
27	1	36	10	10.1999999999999993	45	2011-09-19 16:56:18.657577	2011-09-19 16:56:18.657577
28	1	8	10	18.3000000000000007	60	2011-09-19 16:56:18.660166	2011-09-19 16:56:18.660166
29	1	18	10	159.900000000000006	6	2011-09-19 16:56:18.662671	2011-09-19 16:56:18.662671
30	1	45	10	32.2000000000000028	10	2011-09-19 16:56:18.665212	2011-09-19 16:56:18.665212
31	1	7	11	0.260000000000000009	25200	2011-09-19 16:56:18.673386	2011-09-19 16:56:18.673386
32	1	7	11	0.260000000000000009	10200	2011-09-19 16:56:18.675948	2011-09-19 16:56:18.675948
33	1	21	12	44.5	5	2011-09-19 16:56:18.74597	2011-09-19 16:56:18.74597
34	1	24	12	2.64999999999999991	20	2011-09-19 16:56:18.749014	2011-09-19 16:56:18.749014
35	1	20	12	30.8000000000000007	10	2011-09-19 16:56:18.751809	2011-09-19 16:56:18.751809
36	1	32	12	61.7999999999999972	2	2011-09-19 16:56:18.754655	2011-09-19 16:56:18.754655
37	1	1	12	63.7999999999999972	2	2011-09-19 16:56:18.757306	2011-09-19 16:56:18.757306
38	1	35	12	23.4699999999999989	7	2011-09-19 16:56:18.76003	2011-09-19 16:56:18.76003
39	1	31	13	139.5	1	2011-09-19 16:56:18.768923	2011-09-19 16:56:18.768923
40	1	17	13	19.3000000000000007	30	2011-09-19 16:56:18.771701	2011-09-19 16:56:18.771701
41	1	42	13	25.8999999999999986	40	2011-09-19 16:56:18.774433	2011-09-19 16:56:18.774433
42	1	14	14	7.84999999999999964	10	2011-09-19 16:56:18.782769	2011-09-19 16:56:18.782769
43	1	14	14	7.84999999999999964	10	2011-09-19 16:56:18.785605	2011-09-19 16:56:18.785605
44	1	24	14	2.60000000000000009	20	2011-09-19 16:56:18.788224	2011-09-19 16:56:18.788224
45	1	21	16	32.740000000000002	5	2011-09-19 16:56:18.802084	2011-09-19 16:56:18.802084
46	1	33	17	2.10000000000000009	40	2011-09-19 16:56:18.810299	2011-09-19 16:56:18.810299
47	1	13	17	18.9600000000000009	60	2011-09-19 16:56:18.812918	2011-09-19 16:56:18.812918
48	1	13	17	1.19999999999999996	60	2011-09-19 16:56:18.815693	2011-09-19 16:56:18.815693
49	1	30	18	36	5	2011-09-19 16:56:18.824017	2011-09-19 16:56:18.824017
50	1	26	18	109.900000000000006	1	2011-09-19 16:56:18.827142	2011-09-19 16:56:18.827142
51	1	30	19	25.629999999999999	2	2011-09-19 16:56:18.835497	2011-09-19 16:56:18.835497
52	1	33	21	2.10000000000000009	40	2011-09-19 16:56:18.850772	2011-09-19 16:56:18.850772
53	1	13	21	18.9600000000000009	60	2011-09-19 16:56:18.853461	2011-09-19 16:56:18.853461
54	1	13	21	1.19999999999999996	60	2011-09-19 16:56:18.855997	2011-09-19 16:56:18.855997
\.


--
-- TOC entry 2027 (class 0 OID 66772)
-- Dependencies: 1630
-- Data for Name: pulves; Type: TABLE DATA; Schema: public; Owner: -
--

COPY pulves (id, saison_id, user_id, date, name, cout_ha_passage, star, adu, "desc", created_at, updated_at) FROM stdin;
1	1	2	2011-03-11	Glyphosate	23	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-09-19 16:56:19.085065	2011-09-19 16:56:19.085065
2	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-09-19 16:56:19.107071	2011-09-19 16:56:19.107071
3	1	2	2011-04-06	Semis	10	1	\N	indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).	2011-09-19 16:56:19.114321	2011-09-19 16:56:19.114321
4	1	2	2011-04-07	Cline	10	0	\N	2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636	2011-09-19 16:56:19.118331	2011-09-19 16:56:19.118331
5	1	2	2011-04-11	Challenge	10	0	\N	4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182	2011-09-19 16:56:19.125053	2011-09-19 16:56:19.125053
6	1	2	2011-05-20	pulsar	10	0	\N	1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182	2011-09-19 16:56:19.132288	2011-09-19 16:56:19.132288
7	1	2	2011-03-11	Glyphosate	10	1	\N	verifier les date (2010 ou 2011?).</br>verifier le dosage huile.	2011-09-19 16:56:19.253427	2011-09-19 16:56:19.253427
8	1	2	2011-03-20	Engrais 0-20-30	10	0	\N		2011-09-19 16:56:19.263679	2011-09-19 16:56:19.263679
9	1	2	2011-04-06	Semis	10	1	\N	modifier le cout_ha_passage et le dosage	2011-09-19 16:56:19.271052	2011-09-19 16:56:19.271052
10	1	2	2011-04-11	Challenge	10	0	\N		2011-09-19 16:56:19.27525	2011-09-19 16:56:19.27525
11	1	2	2010-08-31	Semis	31	0	\N		2011-09-19 16:56:19.29326	2011-09-19 16:56:19.29326
12	1	2	2010-08-31	colzamid	10	0	\N		2011-09-19 16:56:19.297427	2011-09-19 16:56:19.297427
13	1	2	2010-09-02	springbok	10	0	\N		2011-09-19 16:56:19.304289	2011-09-19 16:56:19.304289
14	1	2	2010-10-07	Folyr	10	0	\N		2011-09-19 16:56:19.311404	2011-09-19 16:56:19.311404
15	1	2	2011-01-23	0-20-30	10	0	\N		2011-09-19 16:56:19.323858	2011-09-19 16:56:19.323858
16	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38 (? Cf carnet trochet)	2011-09-19 16:56:19.330552	2011-09-19 16:56:19.330552
17	1	2	2011-02-10	Stratos	10	0	\N		2011-09-19 16:56:19.337635	2011-09-19 16:56:19.337635
18	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-09-19 16:56:19.344414	2011-09-19 16:56:19.344414
19	1	2	2011-03-08	Soufre	10	0	\N		2011-09-19 16:56:19.35164	2011-09-19 16:56:19.35164
20	1	2	2011-03-08	Fury	10	0	\N		2011-09-19 16:56:19.360498	2011-09-19 16:56:19.360498
21	1	2	2011-03-08	chrono	10	0	\N		2011-09-19 16:56:19.386276	2011-09-19 16:56:19.386276
22	1	2	2011-03-20	picabore	10	0	\N		2011-09-19 16:56:19.401516	2011-09-19 16:56:19.401516
23	1	2	2011-04-02	Surnog	10	0	\N		2011-09-19 16:56:19.412499	2011-09-19 16:56:19.412499
24	1	2	2011-04-20	amistar_xtra	10	0	\N		2011-09-19 16:56:19.420876	2011-09-19 16:56:19.420876
25	1	2	2010-08-30	Semis	31	1	\N	dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)	2011-09-19 16:56:19.533704	2011-09-19 16:56:19.533704
26	1	2	2010-08-30	colzamid	10	0	\N		2011-09-19 16:56:19.537942	2011-09-19 16:56:19.537942
27	1	2	2010-09-02	springbok	10	0	\N		2011-09-19 16:56:19.545108	2011-09-19 16:56:19.545108
28	1	2	2010-10-07	Folyr	10	0	\N		2011-09-19 16:56:19.552719	2011-09-19 16:56:19.552719
29	1	2	2011-01-23	0-20-30	10	0	\N		2011-09-19 16:56:19.565379	2011-09-19 16:56:19.565379
30	1	2	2011-02-08	Azote	10	0	\N	81u.</br>N°38	2011-09-19 16:56:19.572216	2011-09-19 16:56:19.572216
31	1	2	2011-03-03	Azote	10	0	\N	94u.</br>N°40	2011-09-19 16:56:19.579492	2011-09-19 16:56:19.579492
32	1	2	2011-03-08	Soufre	10	0	\N		2011-09-19 16:56:19.586618	2011-09-19 16:56:19.586618
33	1	2	2011-03-09	Fury	10	0	\N		2011-09-19 16:56:19.593619	2011-09-19 16:56:19.593619
34	1	2	2011-03-08	chrono	10	0	\N	dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.	2011-09-19 16:56:19.600494	2011-09-19 16:56:19.600494
35	1	2	2011-03-24	picabore	10	0	\N		2011-09-19 16:56:19.610692	2011-09-19 16:56:19.610692
36	1	2	2011-04-02	Surnog	10	0	\N		2011-09-19 16:56:19.620957	2011-09-19 16:56:19.620957
37	1	2	2011-04-20	amistar_xtra	10	0	\N		2011-09-19 16:56:19.627554	2011-09-19 16:56:19.627554
38	1	2	2010-10-01	glyphosate	10	0	\N		2011-09-19 16:56:19.668428	2011-09-19 16:56:19.668428
39	1	2	2010-10-22	semis	31	0	\N	dosage réel=180.</br>début Richepin, fin PR.</br>N°43	2011-09-19 16:56:19.675942	2011-09-19 16:56:19.675942
40	1	2	2011-01-20	Super 45	10	0	\N		2011-09-19 16:56:19.679936	2011-09-19 16:56:19.679936
41	1	2	2011-02-08	Azote	10	0	\N		2011-09-19 16:56:19.751191	2011-09-19 16:56:19.751191
42	1	2	2011-03-03	Azote	10	0	\N		2011-09-19 16:56:19.759013	2011-09-19 16:56:19.759013
43	1	2	2011-03-09	Soufre	10	0	\N		2011-09-19 16:56:19.766386	2011-09-19 16:56:19.766386
44	1	2	2011-03-09	Radar	10	0	\N		2011-09-19 16:56:19.773523	2011-09-19 16:56:19.773523
45	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-19 16:56:19.780456	2011-09-19 16:56:19.780456
46	1	2	2011-04-20	Vip	10	1	\N	dosage huile?	2011-09-19 16:56:19.787488	2011-09-19 16:56:19.787488
47	1	2	2011-04-30	Baravo Elite	10	0	\N		2011-09-19 16:56:19.797649	2011-09-19 16:56:19.797649
48	1	2	2011-05-04	Ariane	10	0	\N		2011-09-19 16:56:19.804845	2011-09-19 16:56:19.804845
49	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-19 16:56:19.841783	2011-09-19 16:56:19.841783
50	1	2	2010-10-20	semis	31	0	\N	dosage reel 175kg/Ha.</br>N°42.	2011-09-19 16:56:19.851785	2011-09-19 16:56:19.851785
51	1	2	2011-01-20	Super 45	10	0	\N		2011-09-19 16:56:19.856517	2011-09-19 16:56:19.856517
52	1	2	2011-02-08	Azote	10	0	\N		2011-09-19 16:56:19.863597	2011-09-19 16:56:19.863597
53	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-09-19 16:56:19.871211	2011-09-19 16:56:19.871211
54	1	2	2011-03-03	Azote	10	0	\N		2011-09-19 16:56:19.881008	2011-09-19 16:56:19.881008
55	1	2	2011-03-09	Soufre	10	0	\N		2011-09-19 16:56:19.88845	2011-09-19 16:56:19.88845
56	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-19 16:56:19.895806	2011-09-19 16:56:19.895806
57	1	2	2011-04-21	Vip	10	1	\N	traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha	2011-09-19 16:56:19.90494	2011-09-19 16:56:19.90494
58	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-19 16:56:19.923603	2011-09-19 16:56:19.923603
59	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-19 16:56:20.068882	2011-09-19 16:56:20.068882
60	1	2	2010-10-21	semis	31	0	\N	dosage reel 165kg/Ha.</br>(Voir plan?)	2011-09-19 16:56:20.079569	2011-09-19 16:56:20.079569
61	1	2	2011-01-20	Super 45	10	0	\N		2011-09-19 16:56:20.083997	2011-09-19 16:56:20.083997
62	1	2	2011-02-08	Azote	10	0	\N		2011-09-19 16:56:20.091573	2011-09-19 16:56:20.091573
63	1	2	2011-03-03	Azote	10	0	\N		2011-09-19 16:56:20.099621	2011-09-19 16:56:20.099621
64	1	2	2011-03-09	Soufre	10	0	\N		2011-09-19 16:56:20.106976	2011-09-19 16:56:20.106976
65	1	2	2011-03-14	Radar	10	1	\N	dosage huile?	2011-09-19 16:56:20.114249	2011-09-19 16:56:20.114249
66	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-19 16:56:20.124018	2011-09-19 16:56:20.124018
67	1	2	2011-04-21	Vip	10	1	\N	dosage reel : 0,5L/Ha sur 2.5 Ha.	2011-09-19 16:56:20.131001	2011-09-19 16:56:20.131001
68	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-19 16:56:20.140705	2011-09-19 16:56:20.140705
69	1	2	2010-09-30	glyphosate	10	0	\N		2011-09-19 16:56:20.17509	2011-09-19 16:56:20.17509
70	1	2	2010-10-21	semis	31	0	\N	dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42	2011-09-19 16:56:20.184916	2011-09-19 16:56:20.184916
71	1	2	2011-01-20	Super 45	10	0	\N		2011-09-19 16:56:20.189137	2011-09-19 16:56:20.189137
72	1	2	2011-02-08	Azote	10	0	\N		2011-09-19 16:56:20.196225	2011-09-19 16:56:20.196225
73	1	2	2011-02-11	Radar	10	1	\N	dosage huile?	2011-09-19 16:56:20.202919	2011-09-19 16:56:20.202919
74	1	2	2011-03-03	Azote	10	0	\N		2011-09-19 16:56:20.212598	2011-09-19 16:56:20.212598
75	1	2	2011-03-09	Soufre	10	0	\N		2011-09-19 16:56:20.219737	2011-09-19 16:56:20.219737
76	1	2	2011-04-04	Proca	10	1	\N	PZ (?)	2011-09-19 16:56:20.227469	2011-09-19 16:56:20.227469
77	1	2	2011-04-30	Bravo Elite	10	0	\N		2011-09-19 16:56:20.234446	2011-09-19 16:56:20.234446
\.


--
-- TOC entry 2028 (class 0 OID 66783)
-- Dependencies: 1632
-- Data for Name: putofactures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putofactures (id, saison_id, facture_id, pulve_id, value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2029 (class 0 OID 66791)
-- Dependencies: 1634
-- Data for Name: putoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putoparcelles (id, saison_id, parcelle_id, pulve_id, value, created_at, updated_at) FROM stdin;
1	1	11	1	0	2011-09-19 16:56:19.233678	2011-09-19 16:56:19.233678
2	1	11	2	0	2011-09-19 16:56:19.239174	2011-09-19 16:56:19.239174
3	1	11	3	0	2011-09-19 16:56:19.241795	2011-09-19 16:56:19.241795
4	1	11	4	0	2011-09-19 16:56:19.244363	2011-09-19 16:56:19.244363
5	1	11	5	0	2011-09-19 16:56:19.247103	2011-09-19 16:56:19.247103
6	1	11	6	0	2011-09-19 16:56:19.250044	2011-09-19 16:56:19.250044
7	1	9	7	0	2011-09-19 16:56:19.282453	2011-09-19 16:56:19.282453
8	1	9	8	0	2011-09-19 16:56:19.285154	2011-09-19 16:56:19.285154
9	1	9	9	0	2011-09-19 16:56:19.287685	2011-09-19 16:56:19.287685
10	1	9	10	0	2011-09-19 16:56:19.290143	2011-09-19 16:56:19.290143
11	1	10	11	0	2011-09-19 16:56:19.428837	2011-09-19 16:56:19.428837
12	1	10	12	0	2011-09-19 16:56:19.431811	2011-09-19 16:56:19.431811
13	1	10	13	0	2011-09-19 16:56:19.43493	2011-09-19 16:56:19.43493
14	1	10	14	0	2011-09-19 16:56:19.504078	2011-09-19 16:56:19.504078
15	1	10	15	0	2011-09-19 16:56:19.507181	2011-09-19 16:56:19.507181
16	1	10	16	0	2011-09-19 16:56:19.510192	2011-09-19 16:56:19.510192
17	1	10	17	0	2011-09-19 16:56:19.512622	2011-09-19 16:56:19.512622
18	1	10	18	0	2011-09-19 16:56:19.515166	2011-09-19 16:56:19.515166
19	1	10	19	0	2011-09-19 16:56:19.51794	2011-09-19 16:56:19.51794
20	1	10	20	0	2011-09-19 16:56:19.520468	2011-09-19 16:56:19.520468
21	1	10	21	0	2011-09-19 16:56:19.522981	2011-09-19 16:56:19.522981
22	1	10	22	0	2011-09-19 16:56:19.525489	2011-09-19 16:56:19.525489
23	1	10	23	0	2011-09-19 16:56:19.528047	2011-09-19 16:56:19.528047
24	1	10	24	0	2011-09-19 16:56:19.530556	2011-09-19 16:56:19.530556
25	1	8	25	0	2011-09-19 16:56:19.635102	2011-09-19 16:56:19.635102
26	1	8	26	0	2011-09-19 16:56:19.637616	2011-09-19 16:56:19.637616
27	1	8	27	0	2011-09-19 16:56:19.640116	2011-09-19 16:56:19.640116
28	1	8	28	0	2011-09-19 16:56:19.642844	2011-09-19 16:56:19.642844
29	1	8	29	0	2011-09-19 16:56:19.645227	2011-09-19 16:56:19.645227
30	1	8	30	0	2011-09-19 16:56:19.648054	2011-09-19 16:56:19.648054
31	1	8	31	0	2011-09-19 16:56:19.65067	2011-09-19 16:56:19.65067
32	1	8	32	0	2011-09-19 16:56:19.653104	2011-09-19 16:56:19.653104
33	1	8	33	0	2011-09-19 16:56:19.65546	2011-09-19 16:56:19.65546
34	1	8	34	0	2011-09-19 16:56:19.657847	2011-09-19 16:56:19.657847
35	1	8	35	0	2011-09-19 16:56:19.660159	2011-09-19 16:56:19.660159
36	1	8	36	0	2011-09-19 16:56:19.662791	2011-09-19 16:56:19.662791
37	1	8	37	0	2011-09-19 16:56:19.665328	2011-09-19 16:56:19.665328
38	1	6	38	0	2011-09-19 16:56:19.812345	2011-09-19 16:56:19.812345
39	1	6	39	0	2011-09-19 16:56:19.814995	2011-09-19 16:56:19.814995
40	1	6	40	0	2011-09-19 16:56:19.818214	2011-09-19 16:56:19.818214
41	1	6	41	0	2011-09-19 16:56:19.820722	2011-09-19 16:56:19.820722
42	1	6	42	0	2011-09-19 16:56:19.823235	2011-09-19 16:56:19.823235
43	1	6	43	0	2011-09-19 16:56:19.825721	2011-09-19 16:56:19.825721
44	1	6	44	0	2011-09-19 16:56:19.828194	2011-09-19 16:56:19.828194
45	1	6	45	0	2011-09-19 16:56:19.830699	2011-09-19 16:56:19.830699
46	1	6	46	0	2011-09-19 16:56:19.83325	2011-09-19 16:56:19.83325
47	1	6	47	0	2011-09-19 16:56:19.835674	2011-09-19 16:56:19.835674
48	1	6	48	0	2011-09-19 16:56:19.838326	2011-09-19 16:56:19.838326
49	1	7	49	0	2011-09-19 16:56:19.932467	2011-09-19 16:56:19.932467
50	1	7	50	0	2011-09-19 16:56:19.93724	2011-09-19 16:56:19.93724
51	1	7	51	0	2011-09-19 16:56:19.94209	2011-09-19 16:56:19.94209
52	1	7	52	0	2011-09-19 16:56:19.945369	2011-09-19 16:56:19.945369
53	1	7	53	0	2011-09-19 16:56:19.948596	2011-09-19 16:56:19.948596
54	1	7	54	0	2011-09-19 16:56:19.953635	2011-09-19 16:56:19.953635
55	1	7	55	0	2011-09-19 16:56:20.054334	2011-09-19 16:56:20.054334
56	1	7	56	0	2011-09-19 16:56:20.058954	2011-09-19 16:56:20.058954
57	1	7	57	0	2011-09-19 16:56:20.061832	2011-09-19 16:56:20.061832
58	1	7	58	0	2011-09-19 16:56:20.065367	2011-09-19 16:56:20.065367
59	1	2	59	0	2011-09-19 16:56:20.148189	2011-09-19 16:56:20.148189
60	1	2	60	0	2011-09-19 16:56:20.150939	2011-09-19 16:56:20.150939
61	1	2	61	0	2011-09-19 16:56:20.153606	2011-09-19 16:56:20.153606
62	1	2	62	0	2011-09-19 16:56:20.156321	2011-09-19 16:56:20.156321
63	1	2	63	0	2011-09-19 16:56:20.158883	2011-09-19 16:56:20.158883
64	1	2	64	0	2011-09-19 16:56:20.161789	2011-09-19 16:56:20.161789
65	1	2	65	0	2011-09-19 16:56:20.164568	2011-09-19 16:56:20.164568
66	1	2	66	0	2011-09-19 16:56:20.167009	2011-09-19 16:56:20.167009
67	1	2	67	0	2011-09-19 16:56:20.1695	2011-09-19 16:56:20.1695
68	1	2	68	0	2011-09-19 16:56:20.171948	2011-09-19 16:56:20.171948
69	1	1	69	0	2011-09-19 16:56:20.309028	2011-09-19 16:56:20.309028
70	1	1	70	0	2011-09-19 16:56:20.312283	2011-09-19 16:56:20.312283
71	1	1	71	0	2011-09-19 16:56:20.315728	2011-09-19 16:56:20.315728
72	1	1	72	0	2011-09-19 16:56:20.318492	2011-09-19 16:56:20.318492
73	1	1	73	0	2011-09-19 16:56:20.321258	2011-09-19 16:56:20.321258
74	1	1	74	0	2011-09-19 16:56:20.323836	2011-09-19 16:56:20.323836
75	1	1	75	0	2011-09-19 16:56:20.326332	2011-09-19 16:56:20.326332
76	1	1	76	0	2011-09-19 16:56:20.329177	2011-09-19 16:56:20.329177
77	1	1	77	0	2011-09-19 16:56:20.332175	2011-09-19 16:56:20.332175
\.


--
-- TOC entry 2026 (class 0 OID 66764)
-- Dependencies: 1628
-- Data for Name: putoproduits; Type: TABLE DATA; Schema: public; Owner: -
--

COPY putoproduits (id, saison_id, pulve_id, produit_id, dosage, dosage_vrai, "desc", created_at, updated_at) FROM stdin;
1	1	1	22	2	\N	\N	2011-09-19 16:56:19.096928	2011-09-19 16:56:19.096928
2	1	1	24	1	\N	\N	2011-09-19 16:56:19.102977	2011-09-19 16:56:19.102977
3	1	2	48	250	\N	\N	2011-09-19 16:56:19.111021	2011-09-19 16:56:19.111021
4	1	4	16	1.36359999999999992	\N	\N	2011-09-19 16:56:19.121843	2011-09-19 16:56:19.121843
5	1	5	13	1.81820000000000004	\N	\N	2011-09-19 16:56:19.128889	2011-09-19 16:56:19.128889
6	1	6	38	0.681819999999999982	\N	\N	2011-09-19 16:56:19.135938	2011-09-19 16:56:19.135938
7	1	7	22	2	\N	\N	2011-09-19 16:56:19.257258	2011-09-19 16:56:19.257258
8	1	7	24	1	\N	\N	2011-09-19 16:56:19.259938	2011-09-19 16:56:19.259938
9	1	8	48	250	\N	\N	2011-09-19 16:56:19.267774	2011-09-19 16:56:19.267774
10	1	10	13	4	\N	\N	2011-09-19 16:56:19.278906	2011-09-19 16:56:19.278906
11	1	12	17	1.80000000000000004	\N	\N	2011-09-19 16:56:19.301072	2011-09-19 16:56:19.301072
12	1	13	42	2.5	\N	\N	2011-09-19 16:56:19.308077	2011-09-19 16:56:19.308077
13	1	14	20	0.599999999999999978	\N	\N	2011-09-19 16:56:19.315004	2011-09-19 16:56:19.315004
14	1	14	24	1	\N	\N	2011-09-19 16:56:19.318092	2011-09-19 16:56:19.318092
15	1	14	21	0.100000000000000006	\N	\N	2011-09-19 16:56:19.32074	2011-09-19 16:56:19.32074
16	1	15	48	200	\N	\N	2011-09-19 16:56:19.327378	2011-09-19 16:56:19.327378
17	1	16	7	243	\N	\N	2011-09-19 16:56:19.334387	2011-09-19 16:56:19.334387
18	1	17	43	2	\N	\N	2011-09-19 16:56:19.341313	2011-09-19 16:56:19.341313
19	1	18	7	281	\N	\N	2011-09-19 16:56:19.348238	2011-09-19 16:56:19.348238
20	1	19	5	150	\N	\N	2011-09-19 16:56:19.35517	2011-09-19 16:56:19.35517
21	1	20	21	0.100000000000000006	\N	\N	2011-09-19 16:56:19.377032	2011-09-19 16:56:19.377032
22	1	21	15	1.25	\N	\N	2011-09-19 16:56:19.391406	2011-09-19 16:56:19.391406
23	1	21	27	1	\N	\N	2011-09-19 16:56:19.394743	2011-09-19 16:56:19.394743
24	1	22	33	2.5	\N	\N	2011-09-19 16:56:19.405835	2011-09-19 16:56:19.405835
25	1	22	37	0.5	\N	\N	2011-09-19 16:56:19.408791	2011-09-19 16:56:19.408791
26	1	23	45	0.599999999999999978	\N	\N	2011-09-19 16:56:19.416888	2011-09-19 16:56:19.416888
27	1	24	2	0.75	\N	\N	2011-09-19 16:56:19.424872	2011-09-19 16:56:19.424872
28	1	26	17	1.80000000000000004	\N	\N	2011-09-19 16:56:19.541723	2011-09-19 16:56:19.541723
29	1	27	42	2.5	\N	\N	2011-09-19 16:56:19.548887	2011-09-19 16:56:19.548887
30	1	28	20	0.599999999999999978	\N	\N	2011-09-19 16:56:19.556632	2011-09-19 16:56:19.556632
31	1	28	24	1	\N	\N	2011-09-19 16:56:19.559416	2011-09-19 16:56:19.559416
32	1	28	21	0.100000000000000006	\N	\N	2011-09-19 16:56:19.562125	2011-09-19 16:56:19.562125
33	1	29	48	200	\N	\N	2011-09-19 16:56:19.569062	2011-09-19 16:56:19.569062
34	1	30	7	243	\N	\N	2011-09-19 16:56:19.576249	2011-09-19 16:56:19.576249
35	1	31	7	280	\N	\N	2011-09-19 16:56:19.583255	2011-09-19 16:56:19.583255
36	1	32	5	150	\N	\N	2011-09-19 16:56:19.590456	2011-09-19 16:56:19.590456
37	1	33	21	0.100000000000000006	\N	\N	2011-09-19 16:56:19.59728	2011-09-19 16:56:19.59728
38	1	34	15	0.713999999999999968	\N	\N	2011-09-19 16:56:19.60422	2011-09-19 16:56:19.60422
39	1	34	27	0.570999999999999952	\N	\N	2011-09-19 16:56:19.607278	2011-09-19 16:56:19.607278
40	1	35	33	2.5	\N	\N	2011-09-19 16:56:19.614935	2011-09-19 16:56:19.614935
41	1	35	37	0.5	\N	\N	2011-09-19 16:56:19.617853	2011-09-19 16:56:19.617853
42	1	36	45	0.599999999999999978	\N	\N	2011-09-19 16:56:19.624471	2011-09-19 16:56:19.624471
43	1	37	2	0.75	\N	\N	2011-09-19 16:56:19.631517	2011-09-19 16:56:19.631517
44	1	38	22	5	\N	\N	2011-09-19 16:56:19.672359	2011-09-19 16:56:19.672359
45	1	40	44	153	\N	\N	2011-09-19 16:56:19.683591	2011-09-19 16:56:19.683591
46	1	41	7	200	\N	\N	2011-09-19 16:56:19.755543	2011-09-19 16:56:19.755543
47	1	42	7	237	\N	\N	2011-09-19 16:56:19.762922	2011-09-19 16:56:19.762922
48	1	43	5	100	\N	\N	2011-09-19 16:56:19.770177	2011-09-19 16:56:19.770177
49	1	44	39	0.275000000000000022	\N	\N	2011-09-19 16:56:19.777182	2011-09-19 16:56:19.777182
50	1	45	36	1	\N	\N	2011-09-19 16:56:19.78427	2011-09-19 16:56:19.78427
51	1	46	47	0.5	\N	\N	2011-09-19 16:56:19.791475	2011-09-19 16:56:19.791475
52	1	46	24	1	\N	\N	2011-09-19 16:56:19.794343	2011-09-19 16:56:19.794343
53	1	47	8	1.39999999999999991	\N	\N	2011-09-19 16:56:19.801332	2011-09-19 16:56:19.801332
54	1	48	3	3	\N	\N	2011-09-19 16:56:19.80869	2011-09-19 16:56:19.80869
55	1	49	22	2	\N	\N	2011-09-19 16:56:19.845437	2011-09-19 16:56:19.845437
56	1	49	14	0.599999999999999978	\N	\N	2011-09-19 16:56:19.848227	2011-09-19 16:56:19.848227
57	1	51	44	153	\N	\N	2011-09-19 16:56:19.860224	2011-09-19 16:56:19.860224
58	1	52	7	200	\N	\N	2011-09-19 16:56:19.867703	2011-09-19 16:56:19.867703
59	1	53	39	0.275000000000000022	\N	\N	2011-09-19 16:56:19.875039	2011-09-19 16:56:19.875039
60	1	53	24	1	\N	\N	2011-09-19 16:56:19.877699	2011-09-19 16:56:19.877699
61	1	54	7	237	\N	\N	2011-09-19 16:56:19.885004	2011-09-19 16:56:19.885004
62	1	55	5	100	\N	\N	2011-09-19 16:56:19.892346	2011-09-19 16:56:19.892346
63	1	56	36	1	\N	\N	2011-09-19 16:56:19.900273	2011-09-19 16:56:19.900273
64	1	57	46	0.710999999999999965	\N	\N	2011-09-19 16:56:19.910143	2011-09-19 16:56:19.910143
65	1	57	47	0.203600000000000003	\N	\N	2011-09-19 16:56:19.91569	2011-09-19 16:56:19.91569
66	1	57	24	1	\N	\N	2011-09-19 16:56:19.91887	2011-09-19 16:56:19.91887
67	1	58	8	1.39999999999999991	\N	\N	2011-09-19 16:56:19.928466	2011-09-19 16:56:19.928466
68	1	59	22	2	\N	\N	2011-09-19 16:56:20.073047	2011-09-19 16:56:20.073047
69	1	59	14	0.599999999999999978	\N	\N	2011-09-19 16:56:20.076158	2011-09-19 16:56:20.076158
70	1	61	44	153	\N	\N	2011-09-19 16:56:20.087972	2011-09-19 16:56:20.087972
71	1	62	7	200	\N	\N	2011-09-19 16:56:20.095846	2011-09-19 16:56:20.095846
72	1	63	7	237	\N	\N	2011-09-19 16:56:20.103596	2011-09-19 16:56:20.103596
73	1	64	5	100	\N	\N	2011-09-19 16:56:20.110685	2011-09-19 16:56:20.110685
74	1	65	39	0.275000000000000022	\N	\N	2011-09-19 16:56:20.118011	2011-09-19 16:56:20.118011
75	1	65	24	1	\N	\N	2011-09-19 16:56:20.12076	2011-09-19 16:56:20.12076
76	1	66	36	1	\N	\N	2011-09-19 16:56:20.127712	2011-09-19 16:56:20.127712
77	1	67	47	0.25	\N	\N	2011-09-19 16:56:20.134614	2011-09-19 16:56:20.134614
78	1	67	24	0.5	\N	\N	2011-09-19 16:56:20.137475	2011-09-19 16:56:20.137475
79	1	68	8	1.39999999999999991	\N	\N	2011-09-19 16:56:20.144374	2011-09-19 16:56:20.144374
80	1	69	22	2	\N	\N	2011-09-19 16:56:20.178808	2011-09-19 16:56:20.178808
81	1	69	14	0.599999999999999978	\N	\N	2011-09-19 16:56:20.181526	2011-09-19 16:56:20.181526
82	1	71	44	153	\N	\N	2011-09-19 16:56:20.192867	2011-09-19 16:56:20.192867
83	1	72	7	200	\N	\N	2011-09-19 16:56:20.199781	2011-09-19 16:56:20.199781
84	1	73	39	0.275000000000000022	\N	\N	2011-09-19 16:56:20.206679	2011-09-19 16:56:20.206679
85	1	73	24	1	\N	\N	2011-09-19 16:56:20.209388	2011-09-19 16:56:20.209388
86	1	74	7	237	\N	\N	2011-09-19 16:56:20.216449	2011-09-19 16:56:20.216449
87	1	75	5	100	\N	\N	2011-09-19 16:56:20.224205	2011-09-19 16:56:20.224205
88	1	76	36	1	\N	\N	2011-09-19 16:56:20.231163	2011-09-19 16:56:20.231163
89	1	77	8	1.39999999999999991	\N	\N	2011-09-19 16:56:20.238108	2011-09-19 16:56:20.238108
\.


--
-- TOC entry 2017 (class 0 OID 66677)
-- Dependencies: 1610
-- Data for Name: saisons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY saisons (id, name, year, "desc") FROM stdin;
1	2010/2011	2010	\N
\.


--
-- TOC entry 2008 (class 0 OID 62768)
-- Dependencies: 1593
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY schema_migrations (version) FROM stdin;
20100330165713
\.


--
-- TOC entry 2018 (class 0 OID 66688)
-- Dependencies: 1612
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY settings (id, saison_id, value_parcelle, detail_desc, detail_ref, float_precision, text_area_size) FROM stdin;
1	1	0	0	0	1	25x6
\.


--
-- TOC entry 2010 (class 0 OID 66620)
-- Dependencies: 1597
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
-- TOC entry 2016 (class 0 OID 66669)
-- Dependencies: 1608
-- Data for Name: upcategories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY upcategories (id, name, created_at, updated_at) FROM stdin;
1	facture	2011-09-19 16:56:11.766372	2011-09-19 16:56:11.766372
2	pulve	2011-09-19 16:56:11.772649	2011-09-19 16:56:11.772649
3	labour	2011-09-19 16:56:11.775456	2011-09-19 16:56:11.775456
4	vente	2011-09-19 16:56:11.777803	2011-09-19 16:56:11.777803
\.


--
-- TOC entry 2015 (class 0 OID 66661)
-- Dependencies: 1606
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, name, created_at, updated_at) FROM stdin;
1	Jouve	2011-09-19 16:56:11.96363	2011-09-19 16:56:11.96363
2	Trochet	2011-09-19 16:56:11.968995	2011-09-19 16:56:11.968995
3	Dauger	2011-09-19 16:56:11.971222	2011-09-19 16:56:11.971222
4	Raffault	2011-09-19 16:56:11.973254	2011-09-19 16:56:11.973254
5	C le Mobile	2011-09-19 16:56:11.975232	2011-09-19 16:56:11.975232
6	Credit Agricole Assurances	2011-09-19 16:56:11.977446	2011-09-19 16:56:11.977446
7	Bastard	2011-09-19 16:56:11.980033	2011-09-19 16:56:11.980033
8	Daugeron Garage	2011-09-19 16:56:11.982925	2011-09-19 16:56:11.982925
9	Communaute de communes	2011-09-19 16:56:11.985115	2011-09-19 16:56:11.985115
10	SIAEP de l'Igneraie	2011-09-19 16:56:11.987267	2011-09-19 16:56:11.987267
11	France Telecom	2011-09-19 16:56:11.989415	2011-09-19 16:56:11.989415
12	Dechansiaud	2011-09-19 16:56:11.991562	2011-09-19 16:56:11.991562
13	Renaud	2011-09-19 16:56:11.99371	2011-09-19 16:56:11.99371
14	EDF	2011-09-19 16:56:11.995805	2011-09-19 16:56:11.995805
15	Compta Centre	2011-09-19 16:56:11.997823	2011-09-19 16:56:11.997823
16	Pneu Europe Service	2011-09-19 16:56:11.999947	2011-09-19 16:56:11.999947
17	Sodibe	2011-09-19 16:56:12.002077	2011-09-19 16:56:12.002077
18	Lapeyre	2011-09-19 16:56:12.004366	2011-09-19 16:56:12.004366
19	Seelec	2011-09-19 16:56:12.067147	2011-09-19 16:56:12.067147
20	Denormandie Jardinerie	2011-09-19 16:56:12.069766	2011-09-19 16:56:12.069766
21	MSA	2011-09-19 16:56:12.072243	2011-09-19 16:56:12.072243
22	Agro-Service	2011-09-19 16:56:12.074515	2011-09-19 16:56:12.074515
23	CBM	2011-09-19 16:56:12.076749	2011-09-19 16:56:12.076749
24	Super U	2011-09-19 16:56:12.079018	2011-09-19 16:56:12.079018
25	DDA	2011-09-19 16:56:12.081207	2011-09-19 16:56:12.081207
26	PAC	2011-09-19 16:56:12.08337	2011-09-19 16:56:12.08337
27	Charrier	2011-09-19 16:56:12.085519	2011-09-19 16:56:12.085519
28	La Poste	2011-09-19 16:56:12.087628	2011-09-19 16:56:12.087628
29	Brico Depot	2011-09-19 16:56:12.089963	2011-09-19 16:56:12.089963
30	divers	2011-09-19 16:56:12.092218	2011-09-19 16:56:12.092218
31	Auroy	2011-09-19 16:56:12.09442	2011-09-19 16:56:12.09442
32	Bernard Peres	2011-09-19 16:56:12.096903	2011-09-19 16:56:12.096903
33	Bricomarche	2011-09-19 16:56:12.099198	2011-09-19 16:56:12.099198
34	Aucun	2011-09-19 16:56:12.121551	2011-09-19 16:56:12.121551
\.


--
-- TOC entry 2035 (class 0 OID 66845)
-- Dependencies: 1646
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ventes (id, category_id, saison_id, prix, date, user_id, name, ref, ref_client, star, adu, "desc", created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2036 (class 0 OID 66856)
-- Dependencies: 1648
-- Data for Name: ventoparcelles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ventoparcelles (id, saison_id, vente_id, parcelle_id, value) FROM stdin;
\.


--
-- TOC entry 2019 (class 0 OID 66696)
-- Dependencies: 1614
-- Data for Name: verifs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY verifs (id, name) FROM stdin;
\.


--
-- TOC entry 2009 (class 0 OID 66612)
-- Dependencies: 1595
-- Data for Name: zones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY zones (id, name, surface, created_at, updated_at) FROM stdin;
1	Bruneau	14	2011-09-19 16:56:12.868275	2011-09-19 16:56:12.868275
2	Mitant	5	2011-09-19 16:56:12.874499	2011-09-19 16:56:12.874499
3	La Rue	46.5499999999999972	2011-09-19 16:56:12.877921	2011-09-19 16:56:12.877921
4	Basse-cour	2	2011-09-19 16:56:12.880432	2011-09-19 16:56:12.880432
5	Vallees	11	2011-09-19 16:56:12.88282	2011-09-19 16:56:12.88282
6	Guiberons	2.5	2011-09-19 16:56:12.885154	2011-09-19 16:56:12.885154
7	La cote	2	2011-09-19 16:56:12.887674	2011-09-19 16:56:12.887674
8	Feuillets	16	2011-09-19 16:56:12.890198	2011-09-19 16:56:12.890198
9	Brandes	2.9700000000000002	2011-09-19 16:56:12.892528	2011-09-19 16:56:12.892528
10	Taillis	19.3200000000000003	2011-09-19 16:56:12.894862	2011-09-19 16:56:12.894862
11	Varennes	15.8599999999999994	2011-09-19 16:56:12.897108	2011-09-19 16:56:12.897108
12	Patureaux	8.86999999999999922	2011-09-19 16:56:12.899475	2011-09-19 16:56:12.899475
13	Prairie Chevaux	13.2599999999999998	2011-09-19 16:56:12.902801	2011-09-19 16:56:12.902801
14	Sous l'eglise	1.35000000000000009	2011-09-19 16:56:12.905401	2011-09-19 16:56:12.905401
15	Reserve	2.54999999999999982	2011-09-19 16:56:12.908075	2011-09-19 16:56:12.908075
16	Lavernier	0.75	2011-09-19 16:56:12.910337	2011-09-19 16:56:12.910337
17	Le Bourg-1	0.520000000000000018	2011-09-19 16:56:12.912643	2011-09-19 16:56:12.912643
18	zoneA	10	2011-09-19 16:56:12.914961	2011-09-19 16:56:12.914961
19	zoneB	100	2011-09-19 16:56:12.917136	2011-09-19 16:56:12.917136
20	zoneC	200	2011-09-19 16:56:12.920022	2011-09-19 16:56:12.920022
\.


--
-- TOC entry 2034 (class 0 OID 66837)
-- Dependencies: 1644
-- Data for Name: zonetopas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY zonetopas (id, saison_id, parcelle_id, zone_id, value, created_at, updated_at) FROM stdin;
1	1	1	1	14	2011-09-19 16:56:18.135074	2011-09-19 16:56:18.135074
2	1	2	2	5	2011-09-19 16:56:18.144825	2011-09-19 16:56:18.144825
3	1	3	8	5	2011-09-19 16:56:18.151672	2011-09-19 16:56:18.151672
4	1	4	8	4	2011-09-19 16:56:18.158366	2011-09-19 16:56:18.158366
5	1	5	8	7	2011-09-19 16:56:18.164697	2011-09-19 16:56:18.164697
6	1	6	3	10	2011-09-19 16:56:18.172596	2011-09-19 16:56:18.172596
7	1	7	3	14	2011-09-19 16:56:18.178746	2011-09-19 16:56:18.178746
8	1	8	3	14	2011-09-19 16:56:18.185233	2011-09-19 16:56:18.185233
9	1	9	3	9	2011-09-19 16:56:18.191681	2011-09-19 16:56:18.191681
10	1	10	4	2	2011-09-19 16:56:18.198866	2011-09-19 16:56:18.198866
11	1	11	5	11	2011-09-19 16:56:18.205927	2011-09-19 16:56:18.205927
\.


--
-- TOC entry 1961 (class 2606 OID 66647)
-- Dependencies: 1602 1602
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 1979 (class 2606 OID 66734)
-- Dependencies: 1620 1620
-- Name: facdivs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY facdivs
    ADD CONSTRAINT facdivs_pkey PRIMARY KEY (id);


--
-- TOC entry 1963 (class 2606 OID 66658)
-- Dependencies: 1604 1604
-- Name: factcats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factcats
    ADD CONSTRAINT factcats_pkey PRIMARY KEY (id);


--
-- TOC entry 1981 (class 2606 OID 66742)
-- Dependencies: 1622 1622
-- Name: factoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factoparcelles
    ADD CONSTRAINT factoparcelles_pkey PRIMARY KEY (id);


--
-- TOC entry 1977 (class 2606 OID 66723)
-- Dependencies: 1618 1618
-- Name: factures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factures
    ADD CONSTRAINT factures_pkey PRIMARY KEY (id);


--
-- TOC entry 1959 (class 2606 OID 66639)
-- Dependencies: 1600 1600
-- Name: factypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factypes
    ADD CONSTRAINT factypes_pkey PRIMARY KEY (id);


--
-- TOC entry 1995 (class 2606 OID 66807)
-- Dependencies: 1636 1636
-- Name: labours_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labours
    ADD CONSTRAINT labours_pkey PRIMARY KEY (id);


--
-- TOC entry 1997 (class 2606 OID 66815)
-- Dependencies: 1638 1638
-- Name: labtofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labtofactures
    ADD CONSTRAINT labtofactures_pkey PRIMARY KEY (id);


--
-- TOC entry 1999 (class 2606 OID 66823)
-- Dependencies: 1640 1640
-- Name: labtoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY labtoparcelles
    ADD CONSTRAINT labtoparcelles_pkey PRIMARY KEY (id);


--
-- TOC entry 1975 (class 2606 OID 66712)
-- Dependencies: 1616 1616
-- Name: myusers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY myusers
    ADD CONSTRAINT myusers_pkey PRIMARY KEY (id);


--
-- TOC entry 2001 (class 2606 OID 66834)
-- Dependencies: 1642 1642
-- Name: parcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parcelles
    ADD CONSTRAINT parcelles_pkey PRIMARY KEY (id);


--
-- TOC entry 1983 (class 2606 OID 66753)
-- Dependencies: 1624 1624
-- Name: produits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);


--
-- TOC entry 1985 (class 2606 OID 66761)
-- Dependencies: 1626 1626
-- Name: protofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY protofactures
    ADD CONSTRAINT protofactures_pkey PRIMARY KEY (id);


--
-- TOC entry 1989 (class 2606 OID 66780)
-- Dependencies: 1630 1630
-- Name: pulves_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pulves
    ADD CONSTRAINT pulves_pkey PRIMARY KEY (id);


--
-- TOC entry 1991 (class 2606 OID 66788)
-- Dependencies: 1632 1632
-- Name: putofactures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putofactures
    ADD CONSTRAINT putofactures_pkey PRIMARY KEY (id);


--
-- TOC entry 1993 (class 2606 OID 66796)
-- Dependencies: 1634 1634
-- Name: putoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putoparcelles
    ADD CONSTRAINT putoparcelles_pkey PRIMARY KEY (id);


--
-- TOC entry 1987 (class 2606 OID 66769)
-- Dependencies: 1628 1628
-- Name: putoproduits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY putoproduits
    ADD CONSTRAINT putoproduits_pkey PRIMARY KEY (id);


--
-- TOC entry 1969 (class 2606 OID 66685)
-- Dependencies: 1610 1610
-- Name: saisons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY saisons
    ADD CONSTRAINT saisons_pkey PRIMARY KEY (id);


--
-- TOC entry 1971 (class 2606 OID 66693)
-- Dependencies: 1612 1612
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 66625)
-- Dependencies: 1597 1597
-- Name: typecultures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY typecultures
    ADD CONSTRAINT typecultures_pkey PRIMARY KEY (id);


--
-- TOC entry 1967 (class 2606 OID 66674)
-- Dependencies: 1608 1608
-- Name: upcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY upcategories
    ADD CONSTRAINT upcategories_pkey PRIMARY KEY (id);


--
-- TOC entry 1965 (class 2606 OID 66666)
-- Dependencies: 1606 1606
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2005 (class 2606 OID 66853)
-- Dependencies: 1646 1646
-- Name: ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 66861)
-- Dependencies: 1648 1648
-- Name: ventoparcelles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ventoparcelles
    ADD CONSTRAINT ventoparcelles_pkey PRIMARY KEY (id);


--
-- TOC entry 1973 (class 2606 OID 66701)
-- Dependencies: 1614 1614
-- Name: verifs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY verifs
    ADD CONSTRAINT verifs_pkey PRIMARY KEY (id);


--
-- TOC entry 1955 (class 2606 OID 66617)
-- Dependencies: 1595 1595
-- Name: zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- TOC entry 2003 (class 2606 OID 66842)
-- Dependencies: 1644 1644
-- Name: zonetopas_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY zonetopas
    ADD CONSTRAINT zonetopas_pkey PRIMARY KEY (id);


--
-- TOC entry 1953 (class 1259 OID 62771)
-- Dependencies: 1593
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


-- Completed on 2011-09-20 08:57:09 CEST

--
-- PostgreSQL database dump complete
--

