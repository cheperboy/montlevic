PGDMP           
            o        
   comptagri_dev    9.0.4    9.0.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     )   SET standard_conforming_strings = 'off';
                       false            �           1262    51054 
   comptagri_dev    DATABASE        CREATE DATABASE comptagri_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';
    DROP DATABASE comptagri_dev;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0 
   SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5            �           2612    11574    plpgsql    PROCEDURAL LANGUAGE     /   CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;
    DROP PROCEDURAL LANGUAGE plpgsql;
             postgres    false            B           1259    53100 
   categories    TABLE     �   CREATE TABLE categories (
    id integer NOT NULL,
    upcategory_id integer,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.categories;
       public         postgres    false    5            A           1259    53098    categories_id_seq    SEQUENCE     s   CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public       postgres    false    1602    5            �           0    0    categories_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE categories_id_seq OWNED BY categories.id;
            public       postgres    false    1601            �           0    0    categories_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('categories_id_seq', 24, true);
            public       postgres    false    1601            >           1259    53084    charges    TABLE     +   CREATE TABLE charges (
    toto integer
);
    DROP TABLE public.charges;
       public         postgres    false    5            T           1259    53184    facdivs    TABLE     �  CREATE TABLE facdivs (
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
    DROP TABLE public.facdivs;
       public         postgres    false    5            S           1259    53182    facdivs_id_seq    SEQUENCE     p   CREATE SEQUENCE facdivs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.facdivs_id_seq;
       public       postgres    false    1620    5            �           0    0    facdivs_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE facdivs_id_seq OWNED BY facdivs.id;
            public       postgres    false    1619            �           0    0    facdivs_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('facdivs_id_seq', 1, false);
            public       postgres    false    1619            D           1259    53108    factcats    TABLE     �   CREATE TABLE factcats (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.factcats;
       public         postgres    false    5            C           1259    53106    factcats_id_seq    SEQUENCE     q   CREATE SEQUENCE factcats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.factcats_id_seq;
       public       postgres    false    1604    5            �           0    0    factcats_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE factcats_id_seq OWNED BY factcats.id;
            public       postgres    false    1603            �           0    0    factcats_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('factcats_id_seq', 3, true);
            public       postgres    false    1603            V           1259    53195    factoparcelles    TABLE     �   CREATE TABLE factoparcelles (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer,
    facture_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 "   DROP TABLE public.factoparcelles;
       public         postgres    false    5            U           1259    53193    factoparcelles_id_seq    SEQUENCE     w   CREATE SEQUENCE factoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.factoparcelles_id_seq;
       public       postgres    false    5    1622            �           0    0    factoparcelles_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE factoparcelles_id_seq OWNED BY factoparcelles.id;
            public       postgres    false    1621                        0    0    factoparcelles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('factoparcelles_id_seq', 1, false);
            public       postgres    false    1621            R           1259    53173    factures    TABLE       CREATE TABLE factures (
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
    DROP TABLE public.factures;
       public         postgres    false    5            Q           1259    53171    factures_id_seq    SEQUENCE     q   CREATE SEQUENCE factures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.factures_id_seq;
       public       postgres    false    1618    5                       0    0    factures_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE factures_id_seq OWNED BY factures.id;
            public       postgres    false    1617                       0    0    factures_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('factures_id_seq', 2, true);
            public       postgres    false    1617            @           1259    53089    factypes    TABLE     �   CREATE TABLE factypes (
    id integer NOT NULL,
    name character varying(255),
    display character varying(255),
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.factypes;
       public         postgres    false    5            ?           1259    53087    factypes_id_seq    SEQUENCE     q   CREATE SEQUENCE factypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.factypes_id_seq;
       public       postgres    false    1600    5                       0    0    factypes_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE factypes_id_seq OWNED BY factypes.id;
            public       postgres    false    1599                       0    0    factypes_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('factypes_id_seq', 3, true);
            public       postgres    false    1599            d           1259    53257    labours    TABLE     �  CREATE TABLE labours (
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
    DROP TABLE public.labours;
       public         postgres    false    5            c           1259    53255    labours_id_seq    SEQUENCE     p   CREATE SEQUENCE labours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.labours_id_seq;
       public       postgres    false    5    1636                       0    0    labours_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE labours_id_seq OWNED BY labours.id;
            public       postgres    false    1635                       0    0    labours_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('labours_id_seq', 16, true);
            public       postgres    false    1635            f           1259    53268 
   labtofactures    TABLE     �   CREATE TABLE labtofactures (
    id integer NOT NULL,
    saison_id integer,
    facture_id integer,
    labour_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 !   DROP TABLE public.labtofactures;
       public         postgres    false    5            e           1259    53266    labtofactures_id_seq    SEQUENCE     v   CREATE SEQUENCE labtofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.labtofactures_id_seq;
       public       postgres    false    1638    5                       0    0    labtofactures_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE labtofactures_id_seq OWNED BY labtofactures.id;
            public       postgres    false    1637                       0    0    labtofactures_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('labtofactures_id_seq', 1, false);
            public       postgres    false    1637            h           1259    53276    labtoparcelles    TABLE     �   CREATE TABLE labtoparcelles (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer,
    labour_id integer,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 "   DROP TABLE public.labtoparcelles;
       public         postgres    false    5            g           1259    53274    labtoparcelles_id_seq    SEQUENCE     w   CREATE SEQUENCE labtoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.labtoparcelles_id_seq;
       public       postgres    false    5    1640            	           0    0    labtoparcelles_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE labtoparcelles_id_seq OWNED BY labtoparcelles.id;
            public       postgres    false    1639            
           0    0    labtoparcelles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('labtoparcelles_id_seq', 18, true);
            public       postgres    false    1639            P           1259    53162    myusers    TABLE     �   CREATE TABLE myusers (
    id integer NOT NULL,
    login character varying(255),
    password character varying(255),
    admin smallint
);
    DROP TABLE public.myusers;
       public         postgres    false    5            O           1259    53160    myusers_id_seq    SEQUENCE     p   CREATE SEQUENCE myusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.myusers_id_seq;
       public       postgres    false    1616    5                       0    0    myusers_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE myusers_id_seq OWNED BY myusers.id;
            public       postgres    false    1615                       0    0    myusers_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('myusers_id_seq', 4, true);
            public       postgres    false    1615            j           1259    53284 	   parcelles    TABLE     *  CREATE TABLE parcelles (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    typeculture_id integer NOT NULL,
    name character varying(255) NOT NULL,
    surface double precision,
    "desc" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.parcelles;
       public         postgres    false    5            i           1259    53282    parcelles_id_seq    SEQUENCE     r   CREATE SEQUENCE parcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.parcelles_id_seq;
       public       postgres    false    1642    5            
           0    0    parcelles_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE parcelles_id_seq OWNED BY parcelles.id;
            public       postgres    false    1641                       0    0    parcelles_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('parcelles_id_seq', 23, true);
            public       postgres    false    1641            X           1259    53203    produits    TABLE     ^  CREATE TABLE produits (
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
    DROP TABLE public.produits;
       public         postgres    false    5            W           1259    53201    produits_id_seq    SEQUENCE     q   CREATE SEQUENCE produits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.produits_id_seq;
       public       postgres    false    5    1624                       0    0    produits_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE produits_id_seq OWNED BY produits.id;
            public       postgres    false    1623                       0    0    produits_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('produits_id_seq', 81, true);
            public       postgres    false    1623            Z           1259    53214 
   protofactures    TABLE       CREATE TABLE protofactures (
    id integer NOT NULL,
    saison_id integer,
    produit_id integer,
    facture_id integer,
    prix double precision,
    quantite double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 !   DROP TABLE public.protofactures;
       public         postgres    false    5            Y           1259    53212    protofactures_id_seq    SEQUENCE     v   CREATE SEQUENCE protofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.protofactures_id_seq;
       public       postgres    false    5    1626                       0    0    protofactures_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE protofactures_id_seq OWNED BY protofactures.id;
            public       postgres    false    1625                       0    0    protofactures_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('protofactures_id_seq', 35, true);
            public       postgres    false    1625            ^           1259    53230    pulves    TABLE     c  CREATE TABLE pulves (
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
    DROP TABLE public.pulves;
       public         postgres    false    5            ]           1259    53228 
   pulves_id_seq    SEQUENCE     o   CREATE SEQUENCE pulves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.pulves_id_seq;
       public       postgres    false    5    1630                       0    0 
   pulves_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE pulves_id_seq OWNED BY pulves.id;
            public       postgres    false    1629                       0    0 
   pulves_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('pulves_id_seq', 149, true);
            public       postgres    false    1629            `           1259    53241    putofactures    TABLE       CREATE TABLE putofactures (
    id integer NOT NULL,
    saison_id integer,
    facture_id integer NOT NULL,
    pulve_id integer NOT NULL,
    value double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
     DROP TABLE public.putofactures;
       public         postgres    false    5            _           1259    53239    putofactures_id_seq    SEQUENCE     u   CREATE SEQUENCE putofactures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.putofactures_id_seq;
       public       postgres    false    1632    5                       0    0    putofactures_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE putofactures_id_seq OWNED BY putofactures.id;
            public       postgres    false    1631                       0    0    putofactures_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('putofactures_id_seq', 1, false);
            public       postgres    false    1631            b           1259    53249 
   putoparcelles    TABLE     
  CREATE TABLE putoparcelles (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    parcelle_id integer NOT NULL,
    pulve_id integer NOT NULL,
    value double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 !   DROP TABLE public.putoparcelles;
       public         postgres    false    5            a           1259    53247    putoparcelles_id_seq    SEQUENCE     v   CREATE SEQUENCE putoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.putoparcelles_id_seq;
       public       postgres    false    5    1634                       0    0    putoparcelles_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE putoparcelles_id_seq OWNED BY putoparcelles.id;
            public       postgres    false    1633                       0    0    putoparcelles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('putoparcelles_id_seq', 184, true);
            public       postgres    false    1633            \           1259    53222    putoproduits    TABLE       CREATE TABLE putoproduits (
    id integer NOT NULL,
    saison_id integer,
    pulve_id integer,
    produit_id integer,
    dosage double precision,
    dosage_vrai double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
     DROP TABLE public.putoproduits;
       public         postgres    false    5            [           1259    53220    putoproduits_id_seq    SEQUENCE     u   CREATE SEQUENCE putoproduits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.putoproduits_id_seq;
       public       postgres    false    5    1628                       0    0    putoproduits_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE putoproduits_id_seq OWNED BY putoproduits.id;
            public       postgres    false    1627                       0    0    putoproduits_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('putoproduits_id_seq', 184, true);
            public       postgres    false    1627            J           1259    53135    saisons    TABLE     �   CREATE TABLE saisons (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    year character varying(255),
    "desc" text
);
    DROP TABLE public.saisons;
       public         postgres    false    5            I           1259    53133    saisons_id_seq    SEQUENCE     p   CREATE SEQUENCE saisons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.saisons_id_seq;
       public       postgres    false    5    1610                       0    0    saisons_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE saisons_id_seq OWNED BY saisons.id;
            public       postgres    false    1609                       0    0    saisons_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('saisons_id_seq', 2, true);
            public       postgres    false    1609            9           1259    51304    schema_migrations    TABLE     P   CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         postgres    false    5            L           1259    53146    settings    TABLE     �   CREATE TABLE settings (
    id integer NOT NULL,
    saison_id integer NOT NULL,
    value_parcelle smallint,
    detail_desc smallint,
    detail_ref smallint,
    float_precision integer,
    text_area_size character varying(255)
);
    DROP TABLE public.settings;
       public         postgres    false    5            K           1259    53144    settings_id_seq    SEQUENCE     q   CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.settings_id_seq;
       public       postgres    false    1612    5                       0    0    settings_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE settings_id_seq OWNED BY settings.id;
            public       postgres    false    1611                       0    0    settings_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('settings_id_seq', 1, true);
            public       postgres    false    1611            =           1259    53078    typecultures    TABLE     a   CREATE TABLE typecultures (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
     DROP TABLE public.typecultures;
       public         postgres    false    5            <           1259    53076    typecultures_id_seq    SEQUENCE     u   CREATE SEQUENCE typecultures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.typecultures_id_seq;
       public       postgres    false    5    1597                       0    0    typecultures_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE typecultures_id_seq OWNED BY typecultures.id;
            public       postgres    false    1596                        0    0    typecultures_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('typecultures_id_seq', 6, true);
            public       postgres    false    1596            H           1259    53127    upcategories    TABLE     �   CREATE TABLE upcategories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
     DROP TABLE public.upcategories;
       public         postgres    false    5            G           1259    53125    upcategories_id_seq    SEQUENCE     u   CREATE SEQUENCE upcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.upcategories_id_seq;
       public       postgres    false    1608    5            !           0    0    upcategories_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE upcategories_id_seq OWNED BY upcategories.id;
            public       postgres    false    1607            "           0    0    upcategories_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('upcategories_id_seq', 4, true);
            public       postgres    false    1607            F           1259    53119    users    TABLE     �   CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.users;
       public         postgres    false    5            E           1259    53117    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    1606    5            #           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       postgres    false    1605            $           0    0    users_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('users_id_seq', 32, true);
            public       postgres    false    1605            n           1259    53303    ventes    TABLE     �  CREATE TABLE ventes (
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
    DROP TABLE public.ventes;
       public         postgres    false    5            m           1259    53301 
   ventes_id_seq    SEQUENCE     o   CREATE SEQUENCE ventes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ventes_id_seq;
       public       postgres    false    5    1646            %           0    0 
   ventes_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE ventes_id_seq OWNED BY ventes.id;
            public       postgres    false    1645            &           0    0 
   ventes_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('ventes_id_seq', 1, false);
            public       postgres    false    1645            p           1259    53314    ventoparcelles    TABLE     �   CREATE TABLE ventoparcelles (
    id integer NOT NULL,
    saison_id integer,
    vente_id integer NOT NULL,
    parcelle_id integer NOT NULL,
    value double precision NOT NULL
);
 "   DROP TABLE public.ventoparcelles;
       public         postgres    false    5            o           1259    53312    ventoparcelles_id_seq    SEQUENCE     w   CREATE SEQUENCE ventoparcelles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.ventoparcelles_id_seq;
       public       postgres    false    1648    5            '           0    0    ventoparcelles_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE ventoparcelles_id_seq OWNED BY ventoparcelles.id;
            public       postgres    false    1647            (           0    0    ventoparcelles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('ventoparcelles_id_seq', 1, false);
            public       postgres    false    1647            N           1259    53154    verifs    TABLE     R   CREATE TABLE verifs (
    id integer NOT NULL,
    name character varying(255)
);
    DROP TABLE public.verifs;
       public         postgres    false    5            M           1259    53152 
   verifs_id_seq    SEQUENCE     o   CREATE SEQUENCE verifs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.verifs_id_seq;
       public       postgres    false    1614    5            )           0    0 
   verifs_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE verifs_id_seq OWNED BY verifs.id;
            public       postgres    false    1613            *           0    0 
   verifs_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('verifs_id_seq', 1, false);
            public       postgres    false    1613            ;           1259    53070    zones    TABLE     �   CREATE TABLE zones (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    surface double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.zones;
       public         postgres    false    5            :           1259    53068    zones_id_seq    SEQUENCE     n   CREATE SEQUENCE zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.zones_id_seq;
       public       postgres    false    1595    5            +           0    0    zones_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE zones_id_seq OWNED BY zones.id;
            public       postgres    false    1594            ,           0    0    zones_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('zones_id_seq', 17, true);
            public       postgres    false    1594            l           1259    53295 	   zonetopas    TABLE       CREATE TABLE zonetopas (
    id integer NOT NULL,
    saison_id integer,
    parcelle_id integer NOT NULL,
    zone_id integer NOT NULL,
    value double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.zonetopas;
       public         postgres    false    5            k           1259    53293    zonetopas_id_seq    SEQUENCE     r   CREATE SEQUENCE zonetopas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.zonetopas_id_seq;
       public       postgres    false    1644    5            -           0    0    zonetopas_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE zonetopas_id_seq OWNED BY zonetopas.id;
            public       postgres    false    1643            .           0    0    zonetopas_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('zonetopas_id_seq', 24, true);
            public       postgres    false    1643            �           2604    53103    id    DEFAULT     [   ALTER TABLE categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1601    1602    1602            �           2604    53187    id    DEFAULT     U   ALTER TABLE facdivs ALTER COLUMN id SET DEFAULT nextval('facdivs_id_seq'::regclass);
 9   ALTER TABLE public.facdivs ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1620    1619    1620            �           2604    53111    id    DEFAULT     W   ALTER TABLE factcats ALTER COLUMN id SET DEFAULT nextval('factcats_id_seq'::regclass);
 :   ALTER TABLE public.factcats ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1604    1603    1604            �           2604    53198    id    DEFAULT     c   ALTER TABLE factoparcelles ALTER COLUMN id SET DEFAULT nextval('factoparcelles_id_seq'::regclass);
 @   ALTER TABLE public.factoparcelles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1621    1622    1622            �           2604    53176    id    DEFAULT     W   ALTER TABLE factures ALTER COLUMN id SET DEFAULT nextval('factures_id_seq'::regclass);
 :   ALTER TABLE public.factures ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1617    1618    1618            �           2604    53092    id    DEFAULT     W   ALTER TABLE factypes ALTER COLUMN id SET DEFAULT nextval('factypes_id_seq'::regclass);
 :   ALTER TABLE public.factypes ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1600    1599    1600            �           2604    53260    id    DEFAULT     U   ALTER TABLE labours ALTER COLUMN id SET DEFAULT nextval('labours_id_seq'::regclass);
 9   ALTER TABLE public.labours ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1635    1636    1636            �           2604    53271    id    DEFAULT     a   ALTER TABLE labtofactures ALTER COLUMN id SET DEFAULT nextval('labtofactures_id_seq'::regclass);
 ?   ALTER TABLE public.labtofactures ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1637    1638    1638            �           2604    53279    id    DEFAULT     c   ALTER TABLE labtoparcelles ALTER COLUMN id SET DEFAULT nextval('labtoparcelles_id_seq'::regclass);
 @   ALTER TABLE public.labtoparcelles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1639    1640    1640            �           2604    53165    id    DEFAULT     U   ALTER TABLE myusers ALTER COLUMN id SET DEFAULT nextval('myusers_id_seq'::regclass);
 9   ALTER TABLE public.myusers ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1615    1616    1616            �           2604    53287    id    DEFAULT     Y   ALTER TABLE parcelles ALTER COLUMN id SET DEFAULT nextval('parcelles_id_seq'::regclass);
 ;   ALTER TABLE public.parcelles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1642    1641    1642            �           2604    53206    id    DEFAULT     W   ALTER TABLE produits ALTER COLUMN id SET DEFAULT nextval('produits_id_seq'::regclass);
 :   ALTER TABLE public.produits ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1623    1624    1624            �           2604    53217    id    DEFAULT     a   ALTER TABLE protofactures ALTER COLUMN id SET DEFAULT nextval('protofactures_id_seq'::regclass);
 ?   ALTER TABLE public.protofactures ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1626    1625    1626            �           2604    53233    id    DEFAULT     S   ALTER TABLE pulves ALTER COLUMN id SET DEFAULT nextval('pulves_id_seq'::regclass);
 8   ALTER TABLE public.pulves ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1630    1629    1630            �           2604    53244    id    DEFAULT     _   ALTER TABLE putofactures ALTER COLUMN id SET DEFAULT nextval('putofactures_id_seq'::regclass);
 >   ALTER TABLE public.putofactures ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1632    1631    1632            �           2604    53252    id    DEFAULT     a   ALTER TABLE putoparcelles ALTER COLUMN id SET DEFAULT nextval('putoparcelles_id_seq'::regclass);
 ?   ALTER TABLE public.putoparcelles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1634    1633    1634            �           2604    53225    id    DEFAULT     _   ALTER TABLE putoproduits ALTER COLUMN id SET DEFAULT nextval('putoproduits_id_seq'::regclass);
 >   ALTER TABLE public.putoproduits ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1627    1628    1628            �           2604    53138    id    DEFAULT     U   ALTER TABLE saisons ALTER COLUMN id SET DEFAULT nextval('saisons_id_seq'::regclass);
 9   ALTER TABLE public.saisons ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1610    1609    1610            �           2604    53149    id    DEFAULT     W   ALTER TABLE settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);
 :   ALTER TABLE public.settings ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1612    1611    1612            �           2604    53081    id    DEFAULT     _   ALTER TABLE typecultures ALTER COLUMN id SET DEFAULT nextval('typecultures_id_seq'::regclass);
 >   ALTER TABLE public.typecultures ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1596    1597    1597            �           2604    53130    id    DEFAULT     _   ALTER TABLE upcategories ALTER COLUMN id SET DEFAULT nextval('upcategories_id_seq'::regclass);
 >   ALTER TABLE public.upcategories ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1608    1607    1608            �           2604    53122    id    DEFAULT     Q   ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1606    1605    1606            �           2604    53306    id    DEFAULT     S   ALTER TABLE ventes ALTER COLUMN id SET DEFAULT nextval('ventes_id_seq'::regclass);
 8   ALTER TABLE public.ventes ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1645    1646    1646            �           2604    53317    id    DEFAULT     c   ALTER TABLE ventoparcelles ALTER COLUMN id SET DEFAULT nextval('ventoparcelles_id_seq'::regclass);
 @   ALTER TABLE public.ventoparcelles ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1647    1648    1648            �           2604    53157    id    DEFAULT     S   ALTER TABLE verifs ALTER COLUMN id SET DEFAULT nextval('verifs_id_seq'::regclass);
 8   ALTER TABLE public.verifs ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1614    1613    1614            �           2604    53073    id    DEFAULT     Q   ALTER TABLE zones ALTER COLUMN id SET DEFAULT nextval('zones_id_seq'::regclass);
 7   ALTER TABLE public.zones ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1594    1595    1595            �           2604    53298    id    DEFAULT     Y   ALTER TABLE zonetopas ALTER COLUMN id SET DEFAULT nextval('zonetopas_id_seq'::regclass);
 ;   ALTER TABLE public.zonetopas ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1643    1644    1644            �          0    53100 
   categories 
   TABLE DATA               N   COPY categories (id, upcategory_id, name, created_at, updated_at) FROM stdin;
    public       postgres    false    1602   ��       �          0    53084    charges 
   TABLE DATA                   COPY charges (toto) FROM stdin;
    public       postgres    false    1598   >�       �          0    53184    facdivs 
   TABLE DATA               �   COPY facdivs (id, facture_id, saison_id, category_id, star, adu, user_id, name, cout, ref_client, ref, date, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1620   [�       �          0    53108    factcats 
   TABLE DATA               E   COPY factcats (id, name, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1604   x�       �          0    53195    factoparcelles 
   TABLE DATA               h   COPY factoparcelles (id, saison_id, parcelle_id, facture_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1622   ��       �          0    53173    factures 
   TABLE DATA               �   COPY factures (id, saison_id, category_id, factcat_id, factype_id, reportable_id, type, star, adu, date, user_id, name, cout, ref_client, ref, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1618   ��       �          0    53089    factypes 
   TABLE DATA               N   COPY factypes (id, name, display, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1600   ��       �          0    53257    labours 
   TABLE DATA               �   COPY labours (id, saison_id, category_id, user_id, date, name, cout_ha_passage, "desc", star, adu, created_at, updated_at) FROM stdin;
    public       postgres    false    1636   �       �          0    53268 
   labtofactures 
   TABLE DATA               e   COPY labtofactures (id, saison_id, facture_id, labour_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1638   "�       �          0    53276    labtoparcelles 
   TABLE DATA               g   COPY labtoparcelles (id, saison_id, parcelle_id, labour_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1640   ?�       �          0    53162    myusers 
   TABLE DATA               6   COPY myusers (id, login, password, admin) FROM stdin;
    public       postgres    false    1616   _�       �          0    53284 	   parcelles 
   TABLE DATA               j   COPY parcelles (id, saison_id, typeculture_id, name, surface, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1642   ��       �          0    53203    produits 
   TABLE DATA               n   COPY produits (id, category_id, saison_id, name, "desc", unit, star, adu, created_at, updated_at) FROM stdin;
    public       postgres    false    1624   |�       �          0    53214 
   protofactures 
   TABLE DATA               o   COPY protofactures (id, saison_id, produit_id, facture_id, prix, quantite, created_at, updated_at) FROM stdin;
    public       postgres    false    1626   ��       �          0    53230    pulves 
   TABLE DATA               y   COPY pulves (id, saison_id, user_id, date, name, cout_ha_passage, star, adu, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1630   l�       �          0    53241    putofactures 
   TABLE DATA               c   COPY putofactures (id, saison_id, facture_id, pulve_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1632   g�       �          0    53249 
   putoparcelles 
   TABLE DATA               e   COPY putoparcelles (id, saison_id, parcelle_id, pulve_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1634   ��       �          0    53222    putoproduits 
   TABLE DATA               q   COPY putoproduits (id, saison_id, pulve_id, produit_id, dosage, dosage_vrai, created_at, updated_at) FROM stdin;
    public       postgres    false    1628   J�       �          0    53135    saisons 
   TABLE DATA               2   COPY saisons (id, name, year, "desc") FROM stdin;
    public       postgres    false    1610   �      �          0    51304    schema_migrations 
   TABLE DATA               -   COPY schema_migrations (version) FROM stdin;
    public       postgres    false    1593   .      �          0    53146    settings 
   TABLE DATA               t   COPY settings (id, saison_id, value_parcelle, detail_desc, detail_ref, float_precision, text_area_size) FROM stdin;
    public       postgres    false    1612   Z      �          0    53078    typecultures 
   TABLE DATA               )   COPY typecultures (id, name) FROM stdin;
    public       postgres    false    1597   �      �          0    53127    upcategories 
   TABLE DATA               A   COPY upcategories (id, name, created_at, updated_at) FROM stdin;
    public       postgres    false    1608   �      �          0    53119    users 
   TABLE DATA               :   COPY users (id, name, created_at, updated_at) FROM stdin;
    public       postgres    false    1606   H	      �          0    53303    ventes 
   TABLE DATA               �   COPY ventes (id, category_id, saison_id, prix, date, user_id, name, ref, ref_client, star, adu, "desc", created_at, updated_at) FROM stdin;
    public       postgres    false    1646   �      �          0    53314    ventoparcelles 
   TABLE DATA               N   COPY ventoparcelles (id, saison_id, vente_id, parcelle_id, value) FROM stdin;
    public       postgres    false    1648   �      �          0    53154    verifs 
   TABLE DATA               #   COPY verifs (id, name) FROM stdin;
    public       postgres    false    1614   �      �          0    53070    zones 
   TABLE DATA               C   COPY zones (id, name, surface, created_at, updated_at) FROM stdin;
    public       postgres    false    1595   �      �          0    53295 	   zonetopas 
   TABLE DATA               `   COPY zonetopas (id, saison_id, parcelle_id, zone_id, value, created_at, updated_at) FROM stdin;
    public       postgres    false    1644   �
      �           2606    53105    categories_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public         postgres    false    1602    1602            �           2606    53192    facdivs_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY facdivs
    ADD CONSTRAINT facdivs_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.facdivs DROP CONSTRAINT facdivs_pkey;
       public         postgres    false    1620    1620            �           2606    53116 
   factcats_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY factcats
    ADD CONSTRAINT factcats_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.factcats DROP CONSTRAINT factcats_pkey;
       public         postgres    false    1604    1604            �           2606    53200    factoparcelles_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY factoparcelles
    ADD CONSTRAINT factoparcelles_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.factoparcelles DROP CONSTRAINT factoparcelles_pkey;
       public         postgres    false    1622    1622            �           2606    53181 
   factures_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY factures
    ADD CONSTRAINT factures_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.factures DROP CONSTRAINT factures_pkey;
       public         postgres    false    1618    1618            �           2606    53097 
   factypes_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY factypes
    ADD CONSTRAINT factypes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.factypes DROP CONSTRAINT factypes_pkey;
       public         postgres    false    1600    1600            �           2606    53265    labours_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY labours
    ADD CONSTRAINT labours_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.labours DROP CONSTRAINT labours_pkey;
       public         postgres    false    1636    1636            �           2606    53273    labtofactures_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY labtofactures
    ADD CONSTRAINT labtofactures_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.labtofactures DROP CONSTRAINT labtofactures_pkey;
       public         postgres    false    1638    1638            �           2606    53281    labtoparcelles_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY labtoparcelles
    ADD CONSTRAINT labtoparcelles_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.labtoparcelles DROP CONSTRAINT labtoparcelles_pkey;
       public         postgres    false    1640    1640            �           2606    53170    myusers_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY myusers
    ADD CONSTRAINT myusers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.myusers DROP CONSTRAINT myusers_pkey;
       public         postgres    false    1616    1616            �           2606    53292    parcelles_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY parcelles
    ADD CONSTRAINT parcelles_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.parcelles DROP CONSTRAINT parcelles_pkey;
       public         postgres    false    1642    1642            �           2606    53211 
   produits_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.produits DROP CONSTRAINT produits_pkey;
       public         postgres    false    1624    1624            �           2606    53219    protofactures_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY protofactures
    ADD CONSTRAINT protofactures_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.protofactures DROP CONSTRAINT protofactures_pkey;
       public         postgres    false    1626    1626            �           2606    53238    pulves_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY pulves
    ADD CONSTRAINT pulves_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.pulves DROP CONSTRAINT pulves_pkey;
       public         postgres    false    1630    1630            �           2606    53246    putofactures_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY putofactures
    ADD CONSTRAINT putofactures_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.putofactures DROP CONSTRAINT putofactures_pkey;
       public         postgres    false    1632    1632            �           2606    53254    putoparcelles_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY putoparcelles
    ADD CONSTRAINT putoparcelles_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.putoparcelles DROP CONSTRAINT putoparcelles_pkey;
       public         postgres    false    1634    1634            �           2606    53227    putoproduits_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY putoproduits
    ADD CONSTRAINT putoproduits_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.putoproduits DROP CONSTRAINT putoproduits_pkey;
       public         postgres    false    1628    1628            �           2606    53143    saisons_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY saisons
    ADD CONSTRAINT saisons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.saisons DROP CONSTRAINT saisons_pkey;
       public         postgres    false    1610    1610            �           2606    53151 
   settings_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.settings DROP CONSTRAINT settings_pkey;
       public         postgres    false    1612    1612            �           2606    53083    typecultures_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY typecultures
    ADD CONSTRAINT typecultures_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.typecultures DROP CONSTRAINT typecultures_pkey;
       public         postgres    false    1597    1597            �           2606    53132    upcategories_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY upcategories
    ADD CONSTRAINT upcategories_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.upcategories DROP CONSTRAINT upcategories_pkey;
       public         postgres    false    1608    1608            �           2606    53124 
   users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    1606    1606            �           2606    53311    ventes_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.ventes DROP CONSTRAINT ventes_pkey;
       public         postgres    false    1646    1646            �           2606    53319    ventoparcelles_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY ventoparcelles
    ADD CONSTRAINT ventoparcelles_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.ventoparcelles DROP CONSTRAINT ventoparcelles_pkey;
       public         postgres    false    1648    1648            �           2606    53159    verifs_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY verifs
    ADD CONSTRAINT verifs_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.verifs DROP CONSTRAINT verifs_pkey;
       public         postgres    false    1614    1614            �           2606    53075 
   zones_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.zones DROP CONSTRAINT zones_pkey;
       public         postgres    false    1595    1595            �           2606    53300    zonetopas_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY zonetopas
    ADD CONSTRAINT zonetopas_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.zonetopas DROP CONSTRAINT zonetopas_pkey;
       public         postgres    false    1644    1644            �           1259    51307    unique_schema_migrations    INDEX     Y   CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);
 ,   DROP INDEX public.unique_schema_migrations;
       public         postgres    false    1593            �   �  x�}�Mn�0F��)r�"%�tw�\`Ѝ�(���J-'���r�Y�Z�O�4�eL�p�s\���!��b����oވ^{���mɧ{Z����g������
ND%^�<Ţ���
��5N㜾�Q	��J ��8�I�X�*z��N�x���ͪD��
����쨬)ϻy��u�@���)=��[?��"D0����L�����<������L��")�
J�&Η:%G��7�D��{s��%M�t��W��D�N$������$J�&�%NkCC�;E�!@���_���<ye�}�v�H倜&����|?/Z̽N �8sͩ��Zv
8�b�r�ӒoJ���
dE�H�E���+�! ��EQ��zF�87D��q&e�ڠ�! '���R2u�
B�y�()�i��|��?,0T�      �   
   x������ � �      �   
   x������ � �      �   W   x�3�LL/����4204�5��56P04�22�22ҳ054�4�#�eę��Y����3S#<R\Ɯ�ye��%�M�4���#����� �L)L      �   
   x������ � �      �   �   x�3�4�4bC�?N�Ԥ���
u
@(����ih`` �O+��U(NMM)�*��56P04�22�22�3032���#�e�	��lvL�H,QȨ,�������U!�_�1���E����*c=KKSsS<R\1z\\\ �"7G      �   `   x�3�L�LK�%��%
)��ɜF�����
��VF�VFFz�&�&�x���8K�Ks`$~�LM,-��Hqs���@Bf���������  �6%      �     x����j1�g�)�w��?��ҡ��!cS���zεG)�	��>	˦@��r0
X#�^^�a��L��|:����TcM˃��Ҟm�i$�	���k�x�����<}���U�t�jh)v��m��S��݉�j� 0��HL*���#q2���v�q� �n�*fnϽ"(n�ʍ�WK=�������Q46>φ�����G:���"J�x��J]rɤhc�R��%�ܚ��[��Yo��Vǥ�}'W� ��)      �   
   x������ � �      �     x�}���0Ϣ�4PjI�u�c������A�
��#��-����}8M�
.��7��A k � ��A�%�a�B��U����y���� ��G}}����� ƪ?���x!�U`��ϻ����p�d��1(�f�n-o՛n�+H��b���:i��(���L7��R�u�N!�G;Ņ��Ps�N1���B@����+XԬW���R��*(�KQW�}Y��M�ln捀rՙk)����y#� �-��y      �   ?   x�3�LL��̃��\F���%%�����\Ɯ�9�ŉI�%H,.N����J8m����� ���      �   �  x����n�0���S�b�����۩�N;��5j �;~�Q���>~�gR����lS6�V��T�:��0<�{"�'�l�����2L�D��������m<��e��!�.ij �w2R�,�w'3*Ȳ�k ���~�ӥ;����W�Z4F�m ��-/�y>�Ӹ�s�B�(tXD�Y���1/K[uZ���z)3vǭ{Oc�T��^k�v�䊀ϩ4�<�k>|�ۢH�!�@
����_k�;@Y���\ oc髝'K����������f��k�`ʧ"n���NT)!���a� 7�P�J��I�� �]oR�jI /�
l󏆪�Y��q+�5�ݸK����?r�N���~^'޾kʺ�0���Xt>z� �*|,k��S���
a5~��R4��@@Te��Y-J���LU���?|;Ӫ���:F��{ � �/xH      �   +  x����n�F��9O�p��C�R�i��PE/r�؂L��
e�~���R�Qp9t��cvg�$لF6��ۥ���|���JHy+­7ҿW���羅^���*����7�C�Hk]��.�
]{�rJ!x���4�e������nM,��+~�H��^Ӿݱj&ڊk���US�9i�1���Emd.
�N �x�4���旾��LaA|���F����@�ֻvLL �U5B �j�+����������*� ���n���I|j�4��S���Î�R^V��H;����5�iQ�+rC:0�I�`��e9�H
#��TK�*�%2Lb�m��#�g��8G�wi�o6}��8M_=0!�BB>~L�'f�ѕX��a��yxᴴ6��B�*��ڿ�ҩe��q��3�K�}j�}:�pyf���� P�ϧs�s�YkE�([|��?n���։JK,�+z_�a�=��Zn���t��>��D��)�+b� ���������Y++q%X
I���v�׶�xC+��-6m�}L��5-V�1!���5��t�{���	�\B���Ȃ�Գ��Y9p&���ذG
�T2"�%!6Cz`F:,�VU�J�-���m��r>T^\&���9����rQ��me�d��#���1��@:���i{l;��jgber*t,�?�a�=��<2,�݂�����11Q�X+�� �NNjg,rxɌ������L���y8���m%�3MM�?�I���"`J"��9]�
��<n6�V	��	ΛJ<	�ǋ��/�}%���u��V�kN�6��f&�V�ح$H���� /"��7S��d��RI�X��uq�ZȆ��=B��f6Q�.�s3���㐉עB`)�Cd4�5B`ͤ�wn� 3�u崄��ٿnm�'�`�b�u��"�|^eiF`���rJ'Ck� 6\���d�3e���#�I6�8�/4��E��!�b^���sF�d����R�vN���=#pj��|��S����	���[��B�gia�8S�������l��˾�F'�ma� 7��!pSj\�����K3�����x�FFQ����E���\��VX~$��%W,ad���0#�SR\��U�0Kʌ��V~"&S���W%����\I�y��
���ih_9I/ke� �S߸f�!+k}M0#��x>�amd$���h����4�iW�.�6!�+����jt���2�=dC��ˍ� ����Q]1���~�iA�+�Q2��e��.zܰ�FFH�4|����&0      �   �  x����m�0��*�@�I)���:�U��y����ٜ�dy��y~d��������Ƈ����_�Ґ|AP�>'\���������"���Qټ���#}��*�S�OI7{A�(�6ǆ�b:��|�9�g� P�{��1�"My�A�� "Uy��9v��B[�zZ�~A���3l���W���kWOv�����e�H �}�}�*�pSy�o�G�b:A�*�J�6.��6��;}�V;�EP����1�����t�r %�RW���1���EP
����_���"(�e��t�b�_���[��S=�²��:�DqGA),�f/���q�²o���*�t�d�쵬�E0
˾�[�*�}�²o���
y�²o���_�O���+v1��`��f�w'-^@���V�l9�����!�|�^��E      �   �
  x��[�����y��:�V��eQ�p7qt�,�iPZ�H����������P���dh���C�3��}�2#:���J/�����������2��'�sW�K�N��z����S}��%�3��j@��ӿ}�_P:�.�z(��&�PB0�V�]�V8O�x�^ ���{��W��|��z�z/@�}��,OgA��r%�����|[�WI�������:�ʈ"$Z��Q��t����ΊE�G
ӹ���x�'�1��O7�>�>r⧺�m?Z���*��z��C��*Y��X԰W`�y�Ǘ��R|���	~r��wX���Z^%�U���ɴ�E�c)�"$�3Փ�<+�������_��u]���<{��T�wX�1����+�(�,Q|@�Tg�lWI����a,�0y��q��85,l�Kk#C�"�[�γVu�N�� 蔅W��KB�*>�9���!���0J���x�_@+��"�7��!(���,�6$�B��׈���1�>e����!��U⟠��
��V3 B������C��Úe"/AT����&�U��oʷ'3""$ۈ��N���*���)�Z���4"D�TB/���J)#��"D�����������
�~�Ͽ��O^�;<O�rS��t�UD��a��DM�0ػ�Tɦ<�4JJ��F�hƄ�fd�aF��5)�!F�F�䶬�@R����}�����	�Z�H�ӈc}��,�z
�$�<^��Qʲ�����:X.Md}��^��&�uU���z5�̄�!�M
`�I��7I��;��) ��S]�"=���*Ms����=��o�<�o���??&�����,���ŦJ�`����
�9��M�c�Ux�'E�Z�#��E�����#X�I8�8bf$�j�"��z�F�HhlD��Q�
i�� �!N?�^Ú4#2̤�q�Ōg&2/B��a<c�V�yy⢫מ�x\�F�ċ�'o[�4XtY��>i
��A(E\�{��g^:��s�aк%,��q�%Lq&aZJ��Սq=�0-���CG#B܌'Lˌa�lD���L'��j`@7�N��hDH��n���NN�#�O��5���ŧ�o�
~�Af�ʊ)��
|�����M�ud�N��D�z���'�i9��^�f���fF��P¹!��9%�!�J�8��i�w�P���!!�z_'�d0*����6�֋������7��&�p~�OȇC��i0���m'BB���k��g
��}V�%Q�V�D����T�c��ͳS�~E���N�D;ɖni^VYR��ki�c�!I:���<B ��Ȋ7"$i�H�\D�Z�=�f�,���[s,v"$���놛`ֲ!�G@���I�Q��Gә�	�Yz#BR�����躕 �������6"$�h`LjY	/B�`i� ƾ+�M�2�xۙ{R�KH��)�g��0���"�4<��NÌ׈��G�q.g0��Ff�EH��63R�.;R=l�!l�6����+�b[h�&���!5�\k�I#Bj�9�4<��F���>�
��w"����9�����DHuqM�g� *�^��x�*#Y�� 5��_^b2��.�;����q�"F���@q�hDH�� ���;ҟdM�@nr�$�_ʺz��!z�m��F��Hh�x�-��1�
�pbֈ����-�hDH�	ޒZE�0oDH�
ߒ�`f+Az<�%�4��z	��)�� ���`�k'B�8����w�q�j�5����C�*��6�>S�hC��-վ?�S�X��)�B�б�W�kQ�:�-w��ܐ^����z%װ�H�G���;!L��,�t���t��7������a��u��&�&�6�":��ވuٻk��Y���Q�,����gX�:lB33aug
{Q�f�e�q��h�cU�7������؁Pv��}k.���IĆQ<�=zP�Þ���C�pȵ,�� �{��X�����3�UKT�Oh�J��a��l��Y��!u]euJ�f$D�^�k%Y��+]|ۑ;��r���V��Y�r���g��.M��
Ă����GV���=���վ=;0M��x�&P	Xd�A1��O��AS��1�20��&؞��F�`Qbj5��$�C�Z�3��j�{x�VA$�����@�b���p��
���o���wgQB��?c�
�$�P��!D	~��iD��J�j6
��s�� �F��%|�� <�rx�V3�-X����/�7�?�<�)~iC�~Y�/o�<]�U��"t c��"|xL�1�ۅ�i����
�G���c��{���f������/�eVԝKB�r�ݹʲ̊E���M6/�e^N�!�����jY律I�AxRf�43
&p�v	1�aVI�v�u[m��A�n<mg���b%��s;�r��!�I�.�iDˊ���F�gDi�O��<kE2���T�{�&3z=kn���6F��ҪG%)F�c� $�O����
Iu���+�x��d��4��<Y��Aw�ɿ��fw��q����gg�*7��YZ�'��2N���u�n\]>�z��������A#R���R������`f2/�������E\���[��{�Ζ��9fK)!���#}�M������I��1hV�DR
HӁ�@w�#`G8f���T˘����9	cX3��`%���h������
���ʦf�;o9�ֿg�����d/����*p�ۍ�H: �c�0jxmk,8�e�|8\6
k�Ԇ:lN;'��J�hx���؄����u��سN�j1x!<�b�͙�n���'�Ā_2�C�$�]
Hb���b1�e�I��c�M�P���v���;��&��C ����1=�P�d.ƽ�鮧ʾ�mp?L�Y�0�\�kG@�asj�p�
|
	
�;���yT����$�F�!F�U�I�T��`���Z����e��)�g
���Mĺ%��#y»E,Tp	�fd�����3G!��P�Vd�������-R����}��;>�"��$�JK]�Ŀ8}�F1�  ������(}�4i�<�&KP\%�|��^��S\��u�P
��������/���ȣ8�[0�Q)��u"�����j�O�C����{�^?8��Q�r&s	)CG�N�&Pn�js������(i���y�TQ!�:a�Ϛ�	hFTt��?�L:Zӹ됮�G����*��#��9��`_�W)
���x���K
�|��W����߰^�}��� ��;���a��g
�
A0�r��!�E
���UねU�Ą�NyՖ�UW]��YD�[�l�[��Q�����%PC+Znkլ��EQ�)l�)���
A$p�L��)
����,�2���������.D;�����3au��f,��H� ��*Tc�}ձ��J6I��t�[����j��xH��ձ�,��Td��f@;���?�ݸ滚��K�Nt�w�4Q�#

��oz%�ݮ��X�w�~X�������.W'��a=O֌lf�ԑ\L[�!r�6C��`�      �   
   x������ � �      �   �  x�}�Q�Ũ
E�/�x�Z�(�c����!�|q�[���&GM���z������O�����������OV��8|�����h�@�`�u>I&hT��f�������'8��HMp~?y��	m?���u��������
�O` �C�Сa�����~+�(��c��W�ΏEQyn�D}<
F��R\D]����v}5Q��R�mL��G��cʮ�h ��(P&u�i�L8��
�J�~�#�'���»�"n�eSe�t"~��0���Hq�M�ٜ�K�c?�d���k�*?�d��)����fӮ��jpB��x��#c��E b

���Խ&���	��v���a�X�����c -(�g���<��ÀBy��UO�@48(�g�������Y�����!a@�<kHypD#9`"�T��шL�I��8�hD&̤6��Z8�q3�~������&�Ǐ�:�w��e�ND��P'��G�j^%"�a�iä���'"�0ԉ��X�d��N�f�LU"�H�D�ajs���0ԉ�a�I�B���:�w�
��#
C��;�n� 
�H"��8���+��&R%���U�la@��eG4{P"�β�&��a@��e��p��H^*���hJP"y����!4g���ʢ��Ds�%����(M
J$�=?W��D4wP"���W\D�&�%Rd��D�ZP"E���D��%Rf� O�hqP"�����'��H��C��"Z�H��*:��h�0�L�j�u�Za@��g�5�y���eRִ���h�0�L�M��j����p~�2��op-��0�LZ�Y��H{P&�-�:2\D�a@�\�*-�E��0�L�1l} R	ʤ-�Z��t�e�2c���0�L.�
�w�jP&��r3�!d���2�������Ë���̬E/�ݢ�]���ɩ�/���v��P�6�^D�L{���qGR\D���U@�`X�#��TQN/'��׋�nyX���Ջ讀��r���Sn2��nj�
����}��~ҹ�i�ㄫV�"�O:?�YA���t���ǝV=���N�*f/W|/���,ۍ���u�d:�b-pGt2�e��q����tD'�	��j��":�β��8�����lb���	Gt2���U�7�N'S	�.hz9�ޞX��th�p|�9�\~8V?���ȷ	���t��#s<�Ďݛ�L82�GS~u�-{Vk��ó�>�s�N�E�XO���9h��̡O�aw��|2�~�@�oϽ�����<u@ǲkWO�@�{{�@�o�b�ZO����;��q�9��u��v��(	�{M�����ݎ�|���u�k���O��Y��|��@�oo�nu�d��'t)�O���O���Zp:.1C��<��:��O:o;�%���I�L���K"�[�����O�r��E&Y	�X��olNL!Yj�����pd��u`�-��iud����6x�|_���u`�=u���$���ƻn����k�����]���2�\Dvr���ޑ��6ƋLҳ,9Z^�D&ᬤn���.����$2��J�Dv�t��$���M�o�?�IfV�%���>��=f�Q7Ehs��C$"�
�:�DV���E&y�Z7�;R{�5�"��yŒ3�=�Q��k����<�\"���W�!�r!�SdZ�ON|�M0�G&ɴ~H����L�i��\�#��!%2I��C"R>�'2I�� �GڒD��~gT�%��{p"�d^��h�H�Zm罈��kT�%��{p"����~9Q�c#��Q�T��$=%����\�.��S��S��LB�	Y(P/�����Q�L")Am�npZ�d>����+��$+%h���1А�DS�f��>`|�In^�':��96RZ+7�_d���Wi|��"��R��*mN�s����U��z/�"�pJP^Ş7���/2�H	J���K�]�?�		J�X���b"��GR��#w+W8�L�R�+��%�CL��@y�6���?�	�+�Y.=�wΐ�����c�QW�k���i�
���D&�)Ay�:סdN	���=�M�D&)Ay����2D&�����=��/�I�#������D&Y)Ay�{��C��DS�;������|k+$(���>(y�I|{`�z�u��\�����E���ԕ��.{�*WԉL�S��f��W�/����%v�?��n}�IFJPb}�SH*P^םb�D����}���      �   �
  x���۱�E��(n�"�� ���n�-��>=5.,�6Em<H���_��׿�\\j���_�����y����K��xk�K5��2C� Ү>.%U�C�: �P�?�4nu$"�h���Ȑ�<�#��к��6�?�R7^�D����G|I.�鹪�����j�*�	���\%�l���"�������8 �e�ͥ�V�FK|r�j�T@���m>'w��3������mB�J_V�i�.�Y���^#��K2GT��6%1K�����:e�Q5�c�
v��7���BN��窶���L �Ek�*7"{\�eLU�Dq4nDU�*ӫ�Y�2s�UG�؎���XB3lI
;{_3v�F��{,"֢�Tfp�:�؝/W/y(ϡ�'�؍�6�}Z�< �W��q�X��������NJ� ��z[-��Ź�e-N����B.��hi��7G��r,{�� TT���[gX�:�٫sD�l�����p^ej��y#j�s���t������m̴���|�>V�TQk[Ŗ,_��d.����חyy��U������C^^�؊�g#j�t�63/��#Q[o�Cf^��MTQ���w�-�t�Cj#j
��93�d��n���93˚����ε���Fz/�+6�nއu�9U��L�uo��׫�"��܈����k-���f�6-����l�c��#�Z$y/N�[t DΉWQ�%�qD}�u��W���m#���/�������{8ȇī
{��oD��A���*RF���F4,Y���6Vl75ν��L;�h)G�F4,���#�q�W��qD�7��YƑ�B�ѫ�
��6��2�Zۊ�t#fm�#����f�P7�a�F�Y]ό��<Z�rnDÜ�pki����5�/7�a6F���8��"�!7�Y�N^�0�ױ"�݈������k*[�#�݈��Z/�q����m#�fjDk����i����[��/�~�J�=܈��|x-���Ɋn��6߈�|��Z��a�M3:2�)�`T�(�݈�}�s�*���r#��td�s�q�5ܘ߈V�:'�s��clD˜�!ǜ��$�6�e�Fb:�$f��rB˝����YG*b��;[,�Z�򳡘��7l��gtDk��-Eqi�Go���rb��h�-||�.LT�r��%��,�z&k���~��
k����ҭ�e�amU�l��E�ܭs�nr^R�6"�o�r�Aw��nD�[�U��MԍH,槄����߈��4?$,����߈�|��;���ث�ڈ�\��;�l��c��H� ~~H���;r#�:���g*�H����-��5s#R7�Y����	i�2|�:kxd�&���/�Hos��7"5S�s��R'�ވ�o�/�H_������ɗ�d{��8�F��-T>i+qۈԌ�>e��C���F�~��!W⭍H���S�2ji-^�Ȃ߅N�7j����F�1������I�t���C�2PkV��:��s&Mkxxy#ȸ���}���Fе�YT��VuF���	�� 4�Br�h<Bxsʷ���<��q$ۯ;s6CG���i���kѨ,?�|{!�g�}�;�: �ծuP�������|�׮��}�F ������� dy)��4ﶹL^�#5�&�-��4����	-�Pgg�6Z����A�b�����kF�~��z�Uӊ��cJ��!�	닺g?_#{���lѢ~f� �pi%y؍�d�����L����6D�-�-X��etD����킝��J�eXu&i�	d-��E*:�|�-.P��t�R���A���9H��d,L�MX�&�,=:R�,*�O��S>���?�F������	v�Ѯ�A���B�.̒4��ԕ��ؕ�jtC� ���t���[thwU�Ǡ��#��yt�u���]����A�io�ͤ:�gt�� �tי�o&�s>Z��v�B�-��^�A��3�M����]���yȈ�V-:b�o�m}�P�u��=�#(m��+I����c�;������!b�j&�&yU���:?Uuګ��koB~sY��c��*�w ��:vC���1���~���qYCdKω?1\ʌ��x�����v�sRZ+:�~���h�*/�����j�iփȿE��:�݆��Qi�����,i�|Nk�Y�FPr��]ĲZ���5L-7�Ҷ�کfyaK�K[T��w#�����@<�Q��):��G �Yb�Åǋ�t���ep�2�G݈��	k�����^�9�&l2ne�4Uvӵ�7�P#¾�F�'ۗ5QyQ�`.v�7"���u�f�[t�r��/�������AH�B��h�[�3��<�S���e�ݰչ��)�[���Í������������Ai���8G�I�����\1m�Ht�� (��[=f���HtAǭ޾
�&���@Ս�>��&ڣ��A���v�Ku{�8�m�~�E.O��Dg�"���u��б�Ol��$��)9���f�:n�v�0m8|��FPr�O���14v�F��3\6�J�	G�t����ᩢ��%IYAg�u��h]�����^�|~Bc�̴A�͏V�Fc2�۫A��z
�1Q&��t���==��Y��;�����3��6��Cl8�q��6�����qF̚�#���w��y���leoD~}}Y�i�|�I~�9�^i#(m��ZIC{���(9�_D���	�      �   '   x�3�4204��`g���e`��X �=... �E�      �      x�32040066043574����� '�s      �      x�3�4�4 CCN#�
3�=... "�!      �   B   x�3�t�I�2�4J�MU 1�9C�K��R��s�L8��s��L9��3R�R��8}J�R��\1z\\\ "�Z      �   b   x�}��
� E��L6 ��3h-n����!@�6 ��}y�x�V��Z� �Z4o�6"ɞ�܄��m��������xZ�oX�u,h������	�]"��m4Z      �   L  x�}�Ao� ��̯ටT�`c�[꤫V[�j��^�CSK�����Ŵ�1>Z�̼y ��a���J�+�$V�T��XS�X@@�5���5�^@���M�
���xqn:2��
T���R4������*C��h��w�\B�q���2׷���ՆP�;w]��%5꒱4!�,z��w`ڪui�V4��4�n��{٦/��ڨ�UB�J����y�㯇C�븽�h��%��>,_��ǝ��V����Ʒ���tnb�dJƨ� �x�=__"7�� ���3��8',�1�G'ߏ�1�Z�v���In�0�����յ���RXR��+��n�w�\�6E�@]`-������fV��K�@�t��X0���s��" C����}��c<�]Lk6���_�v�x{<�֌�(�+"��a�8,t���" -��'Fa�a�H����|cTu��GT�͆i�T����\�FAF1�%T��Ӆ8���2�J͍.!�9��y����T��0# +��WAn�yȽR�����@+��|�ݽQ�?�� 4~o��B|���\
�����N=�1
�$o �?�i�      �   
   x������ � �      �   
   x������ � �      �   
   x������ � �      �   �  x�}��n�0E뙯P�j	�t����p��������E>ߔ�Y�e{��{�Ap���er`4�A������U�gr�BO�T�	������;-<��efpAy�oN4»��ۂ����#>�sI$�([zx/��$��DIP_�=�����,G+�4�q)��yb)H��;��oQ�%7��B5V��MJ>y	���=��DIj���4���o���f#*�I�h��+�֫�Ry��y���@ea�S��F�<�i�mO�CR)l4��?�(T{EH�k�k���|Y��*�u��2��+¶ϯ�y�N?��U�����
���!�)��zEH^x�z�e����~1�'��-�"li˅��s��~�)�����ھpwl��u�&�c�I��5�3pE�G!�7��      �   a  x�}����0EϦ�m B�Բ�ױ@&�=��[��ķ���3/���/?��$oZ�	m����Ԣ�����|i[o���`z�����-����x�x}Ӥ��'��O��Q�rg��0h&�i�	$u��=�T|��X#�6����1�� T2�~�0#��jT�Mj�K!Dj�<�FD��� 9,�s�h,+N� �W���8�lo-�x���ԁO��� W8�:�!���X�A셻	u���jXd*��M[³��A���$=uf�eu�Ȉ�Y�ZR�� �����z�6�l��(�J�d=t���I$����)�wP��~s����E"���
g     