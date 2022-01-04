--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Ubuntu 14.1-2.pgdg20.04+1)
-- Dumped by pg_dump version 14.1 (Ubuntu 14.1-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    account_number character varying(255) NOT NULL,
    userphone_number character varying(10) NOT NULL,
    shaba_number character varying(255),
    balance bigint NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: account_transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_transaction (
    tr_id integer NOT NULL,
    account_number character varying(255) NOT NULL,
    transaction_type character varying(255),
    transaction_date date,
    transaction_amount bigint,
    CONSTRAINT account_transaction_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['inc-ch/dp'::character varying, 'dec-ch/ps'::character varying, 'inc-ch/rfu'::character varying, 'inc-ch/up'::character varying, 'dec-ch/p'::character varying, 'inc-crd'::character varying, 'dec-crd'::character varying, 'inc-ch'::character varying, 'dec-ch'::character varying])::text[])))
);


ALTER TABLE public.account_transaction OWNER TO postgres;

--
-- Name: account_transaction_tr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_transaction_tr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_transaction_tr_id_seq OWNER TO postgres;

--
-- Name: account_transaction_tr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_transaction_tr_id_seq OWNED BY public.account_transaction.tr_id;


--
-- Name: airplane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.airplane (
    id integer NOT NULL,
    capacity integer NOT NULL,
    max_load integer
);


ALTER TABLE public.airplane OWNER TO postgres;

--
-- Name: airplane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.airplane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.airplane_id_seq OWNER TO postgres;

--
-- Name: airplane_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.airplane_id_seq OWNED BY public.airplane.id;


--
-- Name: bus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus (
    bus_id integer NOT NULL,
    bus_capacity integer NOT NULL,
    is_vip boolean DEFAULT false NOT NULL
);


ALTER TABLE public.bus OWNER TO postgres;

--
-- Name: bus_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_bus_id_seq OWNER TO postgres;

--
-- Name: bus_bus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_bus_id_seq OWNED BY public.bus.bus_id;


--
-- Name: bus_travel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_travel (
    id integer NOT NULL,
    from_city character varying(255) NOT NULL,
    to_city character varying(255) NOT NULL,
    from_terminal character varying(255),
    to_terminal character varying(255),
    departure_date date NOT NULL,
    departure_time time without time zone NOT NULL,
    is_final_dest boolean DEFAULT true NOT NULL,
    is_between_way boolean DEFAULT false NOT NULL,
    bus_id integer NOT NULL
);


ALTER TABLE public.bus_travel OWNER TO postgres;

--
-- Name: bus_travel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_travel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_travel_id_seq OWNER TO postgres;

--
-- Name: bus_travel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_travel_id_seq OWNED BY public.bus_travel.id;


--
-- Name: bus_travel_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_travel_ticket (
    bus_company character varying(255) NOT NULL,
    bus_travelid integer NOT NULL,
    alibaba_offer boolean DEFAULT false NOT NULL,
    age_range character varying(255) DEFAULT 'adult'::character varying NOT NULL,
    cost integer NOT NULL,
    CONSTRAINT bus_travel_ticket_age_range_check CHECK (((age_range)::text = ANY ((ARRAY['child'::character varying, 'adult'::character varying])::text[])))
);


ALTER TABLE public.bus_travel_ticket OWNER TO postgres;

--
-- Name: bus_travel_ticket_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_travel_ticket_order (
    personid integer NOT NULL,
    userphone_number character varying(10) NOT NULL,
    bus_company character varying(255) NOT NULL,
    bus_travelid integer NOT NULL,
    chair_num integer
);


ALTER TABLE public.bus_travel_ticket_order OWNER TO postgres;

--
-- Name: external_flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_flight (
    number integer NOT NULL,
    from_city character varying(255) NOT NULL,
    to_city character varying(255) NOT NULL,
    from_airport character varying(255),
    to_airport character varying(255),
    fly_date date NOT NULL,
    fly_time time without time zone NOT NULL,
    arrive_time time without time zone,
    chair_reserved integer,
    flight_class character varying(255) DEFAULT 'economy'::character varying NOT NULL,
    airplane_id integer NOT NULL,
    CONSTRAINT external_flight_flight_class_check CHECK (((flight_class)::text = ANY ((ARRAY['economy'::character varying, 'business'::character varying, 'firstclass'::character varying])::text[])))
);


ALTER TABLE public.external_flight OWNER TO postgres;

--
-- Name: external_flight_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_flight_ticket (
    external_flightnumber integer NOT NULL,
    airline_name character varying(255) NOT NULL,
    ticket_type character varying(255) DEFAULT 'systemic'::character varying NOT NULL,
    alibaba_offer boolean DEFAULT false NOT NULL,
    age_range character varying(255) DEFAULT 'adult'::character varying NOT NULL,
    cost integer NOT NULL,
    CONSTRAINT external_flight_ticket_age_range_check CHECK (((age_range)::text = ANY ((ARRAY['baby'::character varying, 'child'::character varying, 'adult'::character varying])::text[]))),
    CONSTRAINT external_flight_ticket_ticket_type_check CHECK (((ticket_type)::text = ANY ((ARRAY['systemic'::character varying, 'charter'::character varying])::text[])))
);


ALTER TABLE public.external_flight_ticket OWNER TO postgres;

--
-- Name: external_flight_ticket_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_flight_ticket_order (
    personid integer NOT NULL,
    userphone_number character varying(10) NOT NULL,
    flightnumber integer NOT NULL,
    airline_name character varying(255) NOT NULL,
    two_way_id integer,
    multiple_way_id integer,
    chair_num integer
);


ALTER TABLE public.external_flight_ticket_order OWNER TO postgres;

--
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    name character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    grade integer,
    popularity character varying(255) DEFAULT 'good'::character varying,
    hotel_type character varying(255) DEFAULT 'hotel'::character varying,
    has_pool boolean DEFAULT false NOT NULL,
    has_safebox boolean DEFAULT false NOT NULL,
    billiard_table boolean DEFAULT false NOT NULL,
    has_gym boolean DEFAULT false NOT NULL,
    CONSTRAINT hotel_hotel_type_check CHECK (((hotel_type)::text = ANY ((ARRAY['hotel'::character varying, 'hotel apartment'::character varying])::text[]))),
    CONSTRAINT hotel_popularity_check CHECK (((popularity)::text = ANY ((ARRAY['amazing'::character varying, 'excellent'::character varying, 'great'::character varying, 'good'::character varying])::text[])))
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- Name: internal_flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_flight (
    number integer NOT NULL,
    from_city character varying(255) NOT NULL,
    to_city character varying(255) NOT NULL,
    fly_date date NOT NULL,
    fly_time time without time zone NOT NULL,
    arrive_time time without time zone,
    chair_reserved integer,
    airplane_id integer NOT NULL
);


ALTER TABLE public.internal_flight OWNER TO postgres;

--
-- Name: internal_flight_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_flight_ticket (
    flightnumber integer NOT NULL,
    airline_name character varying(255) NOT NULL,
    ticket_type character varying(255) DEFAULT 'systemic'::character varying NOT NULL,
    alibaba_offer boolean DEFAULT false NOT NULL,
    age_range character varying(255) DEFAULT 'adult'::character varying NOT NULL,
    cost integer NOT NULL,
    CONSTRAINT internal_flight_ticket_age_range_check CHECK (((age_range)::text = ANY ((ARRAY['baby'::character varying, 'child'::character varying, 'adult'::character varying])::text[]))),
    CONSTRAINT internal_flight_ticket_ticket_type_check CHECK (((ticket_type)::text = ANY ((ARRAY['systemic'::character varying, 'charter'::character varying])::text[])))
);


ALTER TABLE public.internal_flight_ticket OWNER TO postgres;

--
-- Name: internal_flight_ticket_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_flight_ticket_order (
    personid integer NOT NULL,
    userphone_number character varying(10) NOT NULL,
    flightnumber integer NOT NULL,
    airline_name character varying(255) NOT NULL,
    two_way_id integer,
    chair_num integer
);


ALTER TABLE public.internal_flight_ticket_order OWNER TO postgres;

--
-- Name: passport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passport (
    passport_number character varying(255) NOT NULL,
    pass_expiration date,
    pass_country character varying(255)
);


ALTER TABLE public.passport OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    national_code character varying(10),
    first_name character varying(255),
    last_name character varying(255),
    birth_date date,
    gender character varying(255) DEFAULT 'male'::character varying,
    phone_number character varying(10),
    latin_firstname character varying(255),
    latin_lastname character varying(255),
    gregorian_bth date,
    passport_number character varying(255),
    CONSTRAINT person_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying])::text[])))
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;


--
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    room_number integer NOT NULL,
    hotelname character varying(255) NOT NULL,
    bed_num integer,
    is_vip boolean DEFAULT false NOT NULL,
    has_brfst boolean DEFAULT false NOT NULL,
    hotelcity character varying(255) NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- Name: room_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_order (
    personid integer NOT NULL,
    userphone_number character varying(10) NOT NULL,
    room_number integer NOT NULL,
    entry_date date NOT NULL,
    departure_date date,
    one_night_cost integer,
    three_night_cost integer
);


ALTER TABLE public.room_order OWNER TO postgres;

--
-- Name: room_room_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_room_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_room_number_seq OWNER TO postgres;

--
-- Name: room_room_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_room_number_seq OWNED BY public.room.room_number;


--
-- Name: stop_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stop_city (
    bus_travelid integer NOT NULL,
    city_name character varying(255) NOT NULL,
    is_final_dest boolean DEFAULT false NOT NULL
);


ALTER TABLE public.stop_city OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    phone_number character varying(10) NOT NULL,
    email_address character varying(255),
    fullname character varying(255),
    gender character varying(255) DEFAULT 'male'::character varying,
    birth_date date,
    national_code character varying(255),
    landing_phone character varying(255),
    password character varying(255),
    registery_date date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT user_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying])::text[])))
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: account_transaction tr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transaction ALTER COLUMN tr_id SET DEFAULT nextval('public.account_transaction_tr_id_seq'::regclass);


--
-- Name: airplane id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airplane ALTER COLUMN id SET DEFAULT nextval('public.airplane_id_seq'::regclass);


--
-- Name: bus bus_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus ALTER COLUMN bus_id SET DEFAULT nextval('public.bus_bus_id_seq'::regclass);


--
-- Name: bus_travel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel ALTER COLUMN id SET DEFAULT nextval('public.bus_travel_id_seq'::regclass);


--
-- Name: person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- Name: room room_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN room_number SET DEFAULT nextval('public.room_room_number_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (account_number, userphone_number, shaba_number, balance) FROM stdin;
1111111111	3234244242	\N	0
2222222222	8234344344	\N	0
3333333333	2334346454	\N	0
4444444444	6234228543	\N	0
5555555555	4325335543	\N	0
6666666666	7434245354	\N	250000
8888888888	5935336544	\N	7500000
9999999999	6464245252	\N	3600000
1212121212	5346464242	\N	8430000
3838383838	3423345935	\N	1000000
7777777777	6755335633	\N	89700000
\.


--
-- Data for Name: account_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_transaction (tr_id, account_number, transaction_type, transaction_date, transaction_amount) FROM stdin;
1	1111111111	inc-ch	\N	0
2	2222222222	inc-ch	\N	0
3	3333333333	inc-ch	\N	0
4	4444444444	inc-ch	\N	0
5	5555555555	inc-ch	\N	0
6	6666666666	inc-ch	\N	250000
7	7777777777	inc-ch	\N	100000000
8	8888888888	inc-ch	\N	7500000
9	9999999999	inc-ch	\N	3600000
10	1212121212	inc-ch	\N	8430000
12	7777777777	dec-ch/p	\N	10000000
13	3838383838	inc-ch	\N	4000000
14	3838383838	dec-ch/p	\N	3000000
15	2222222222	inc-ch	\N	3000000
16	2222222222	dec-ch/p	\N	3000000
17	7777777777	dec-ch/p	\N	300000
\.


--
-- Data for Name: airplane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.airplane (id, capacity, max_load) FROM stdin;
1	300	\N
\.


--
-- Data for Name: bus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus (bus_id, bus_capacity, is_vip) FROM stdin;
1	22	t
2	22	t
\.


--
-- Data for Name: bus_travel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_travel (id, from_city, to_city, from_terminal, to_terminal, departure_date, departure_time, is_final_dest, is_between_way, bus_id) FROM stdin;
1	tehran	mashhad	\N	\N	2021-12-14	13:30:00	t	f	1
3	tehran	babol	\N	\N	2021-12-15	17:45:00	t	f	2
\.


--
-- Data for Name: bus_travel_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_travel_ticket (bus_company, bus_travelid, alibaba_offer, age_range, cost) FROM stdin;
iran peyma	1	f	adult	3000000
iran peyma	3	f	adult	6500000
\.


--
-- Data for Name: bus_travel_ticket_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_travel_ticket_order (personid, userphone_number, bus_company, bus_travelid, chair_num) FROM stdin;
11	3423345935	iran peyma	1	6
2	8234344344	iran peyma	1	10
\.


--
-- Data for Name: external_flight; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_flight (number, from_city, to_city, from_airport, to_airport, fly_date, fly_time, arrive_time, chair_reserved, flight_class, airplane_id) FROM stdin;
1313	los angeles	tehran	\N	\N	2021-12-11	04:00:00	\N	\N	economy	1
\.


--
-- Data for Name: external_flight_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_flight_ticket (external_flightnumber, airline_name, ticket_type, alibaba_offer, age_range, cost) FROM stdin;
1313	mahan	systemic	f	adult	10000000
\.


--
-- Data for Name: external_flight_ticket_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_flight_ticket_order (personid, userphone_number, flightnumber, airline_name, two_way_id, multiple_way_id, chair_num) FROM stdin;
7	6755335633	1313	mahan	\N	\N	\N
\.


--
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel (name, city, grade, popularity, hotel_type, has_pool, has_safebox, billiard_table, has_gym) FROM stdin;
espinas	tehran	\N	good	hotel	f	f	f	f
\.


--
-- Data for Name: internal_flight; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_flight (number, from_city, to_city, fly_date, fly_time, arrive_time, chair_reserved, airplane_id) FROM stdin;
\.


--
-- Data for Name: internal_flight_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_flight_ticket (flightnumber, airline_name, ticket_type, alibaba_offer, age_range, cost) FROM stdin;
\.


--
-- Data for Name: internal_flight_ticket_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_flight_ticket_order (personid, userphone_number, flightnumber, airline_name, two_way_id, chair_num) FROM stdin;
\.


--
-- Data for Name: passport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passport (passport_number, pass_expiration, pass_country) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, national_code, first_name, last_name, birth_date, gender, phone_number, latin_firstname, latin_lastname, gregorian_bth, passport_number) FROM stdin;
1	\N	ali	gholami	\N	male	\N	\N	\N	\N	\N
4	\N	reza	maleki	\N	male	\N	\N	\N	\N	\N
5	\N	morteza	molayee	\N	male	\N	\N	\N	\N	\N
6	\N	saeed	hejazi	\N	male	\N	\N	\N	\N	\N
7	\N	john	wick	\N	male	\N	\N	\N	\N	\N
8	\N	arman	fadayee	\N	male	\N	\N	\N	\N	\N
9	\N	mohammad	sajadi	\N	male	\N	\N	\N	\N	\N
10	\N	ali	mohammadi	\N	male	\N	\N	\N	\N	\N
2	\N	zohre	rasooli	\N	female	\N	\N	\N	\N	\N
3	\N	elham	niayeshi	\N	female	\N	\N	\N	\N	\N
11	\N	sajad	mohammadi	\N	male	\N	\N	\N	\N	\N
\.


--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (room_number, hotelname, bed_num, is_vip, has_brfst, hotelcity) FROM stdin;
1	espinas	2	t	t	tehran
2	espinas	2	t	t	tehran
3	espinas	2	t	t	tehran
4	espinas	2	t	t	tehran
5	espinas	2	t	t	tehran
6	espinas	2	t	t	tehran
7	espinas	2	t	t	tehran
8	espinas	2	t	t	tehran
9	espinas	2	t	t	tehran
10	espinas	2	t	t	tehran
\.


--
-- Data for Name: room_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_order (personid, userphone_number, room_number, entry_date, departure_date, one_night_cost, three_night_cost) FROM stdin;
7	6755335633	1	2021-12-11	\N	300000	\N
\.


--
-- Data for Name: stop_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stop_city (bus_travelid, city_name, is_final_dest) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (phone_number, email_address, fullname, gender, birth_date, national_code, landing_phone, password, registery_date) FROM stdin;
8234344344	\N	zohre rasooli	female	\N	\N	\N	\N	2021-12-18
2334346454	\N	elham niayeshi	female	\N	\N	\N	\N	2021-12-18
3234244242	\N	ali gholami	male	\N	\N	\N	\N	2021-12-28
6234228543	\N	reza maleki	male	\N	\N	\N	\N	2021-12-28
4325335543	\N	morteza molayee	male	\N	\N	\N	\N	2021-12-28
7434245354	\N	saeed hejazi	male	\N	\N	\N	\N	2021-12-28
6755335633	\N	john wick	male	\N	\N	\N	\N	2021-12-28
5935336544	\N	arman fadayee	male	\N	\N	\N	\N	2021-12-28
6464245252	\N	mohammad sajadi	male	\N	\N	\N	\N	2021-12-28
5346464242	\N	ali mohammadi	male	\N	\N	\N	\N	2021-12-28
3423345935	\N	sajad mohammadi	male	\N	\N	\N	\N	2021-12-28
\.


--
-- Name: account_transaction_tr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transaction_tr_id_seq', 17, true);


--
-- Name: airplane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.airplane_id_seq', 1, true);


--
-- Name: bus_bus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_bus_id_seq', 2, true);


--
-- Name: bus_travel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_travel_id_seq', 3, true);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 11, true);


--
-- Name: room_room_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_room_number_seq', 10, true);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (account_number);


--
-- Name: account_transaction account_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transaction
    ADD CONSTRAINT account_transaction_pkey PRIMARY KEY (tr_id, account_number);


--
-- Name: airplane airplane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.airplane
    ADD CONSTRAINT airplane_pkey PRIMARY KEY (id);


--
-- Name: bus bus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT bus_pkey PRIMARY KEY (bus_id);


--
-- Name: bus_travel bus_travel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel
    ADD CONSTRAINT bus_travel_pkey PRIMARY KEY (id);


--
-- Name: bus_travel_ticket_order bus_travel_ticket_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket_order
    ADD CONSTRAINT bus_travel_ticket_order_pkey PRIMARY KEY (personid, userphone_number, bus_company, bus_travelid);


--
-- Name: bus_travel_ticket bus_travel_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket
    ADD CONSTRAINT bus_travel_ticket_pkey PRIMARY KEY (bus_company, bus_travelid);


--
-- Name: external_flight external_flight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight
    ADD CONSTRAINT external_flight_pkey PRIMARY KEY (number);


--
-- Name: external_flight_ticket_order external_flight_ticket_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket_order
    ADD CONSTRAINT external_flight_ticket_order_pkey PRIMARY KEY (personid, userphone_number, flightnumber, airline_name);


--
-- Name: external_flight_ticket external_flight_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket
    ADD CONSTRAINT external_flight_ticket_pkey PRIMARY KEY (external_flightnumber, airline_name);


--
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (name, city);


--
-- Name: internal_flight internal_flight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight
    ADD CONSTRAINT internal_flight_pkey PRIMARY KEY (number);


--
-- Name: internal_flight_ticket_order internal_flight_ticket_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket_order
    ADD CONSTRAINT internal_flight_ticket_order_pkey PRIMARY KEY (personid, userphone_number, flightnumber, airline_name);


--
-- Name: internal_flight_ticket internal_flight_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket
    ADD CONSTRAINT internal_flight_ticket_pkey PRIMARY KEY (flightnumber, airline_name);


--
-- Name: passport passport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passport
    ADD CONSTRAINT passport_pkey PRIMARY KEY (passport_number);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: room_order room_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_order
    ADD CONSTRAINT room_order_pkey PRIMARY KEY (personid, userphone_number, room_number);


--
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_number);


--
-- Name: stop_city stop_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stop_city
    ADD CONSTRAINT stop_city_pkey PRIMARY KEY (bus_travelid);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (phone_number);


--
-- Name: account fkaccount370677; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT fkaccount370677 FOREIGN KEY (userphone_number) REFERENCES public."user"(phone_number);


--
-- Name: account_transaction fkaccount_tr659513; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transaction
    ADD CONSTRAINT fkaccount_tr659513 FOREIGN KEY (account_number) REFERENCES public.account(account_number);


--
-- Name: bus_travel_ticket_order fkbus_travel176748; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket_order
    ADD CONSTRAINT fkbus_travel176748 FOREIGN KEY (userphone_number) REFERENCES public."user"(phone_number);


--
-- Name: bus_travel_ticket fkbus_travel199957; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket
    ADD CONSTRAINT fkbus_travel199957 FOREIGN KEY (bus_travelid) REFERENCES public.bus_travel(id);


--
-- Name: bus_travel_ticket_order fkbus_travel586055; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket_order
    ADD CONSTRAINT fkbus_travel586055 FOREIGN KEY (bus_company, bus_travelid) REFERENCES public.bus_travel_ticket(bus_company, bus_travelid);


--
-- Name: bus_travel fkbus_travel803535; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel
    ADD CONSTRAINT fkbus_travel803535 FOREIGN KEY (bus_id) REFERENCES public.bus(bus_id);


--
-- Name: bus_travel_ticket_order fkbus_travel908364; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_travel_ticket_order
    ADD CONSTRAINT fkbus_travel908364 FOREIGN KEY (personid) REFERENCES public.person(id);


--
-- Name: external_flight_ticket_order fkexternal_f151542; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket_order
    ADD CONSTRAINT fkexternal_f151542 FOREIGN KEY (userphone_number) REFERENCES public."user"(phone_number);


--
-- Name: external_flight_ticket_order fkexternal_f682901; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket_order
    ADD CONSTRAINT fkexternal_f682901 FOREIGN KEY (flightnumber, airline_name) REFERENCES public.external_flight_ticket(external_flightnumber, airline_name);


--
-- Name: external_flight fkexternal_f699999; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight
    ADD CONSTRAINT fkexternal_f699999 FOREIGN KEY (airplane_id) REFERENCES public.airplane(id);


--
-- Name: external_flight_ticket fkexternal_f707173; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket
    ADD CONSTRAINT fkexternal_f707173 FOREIGN KEY (external_flightnumber) REFERENCES public.external_flight(number);


--
-- Name: external_flight_ticket_order fkexternal_f88432; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_flight_ticket_order
    ADD CONSTRAINT fkexternal_f88432 FOREIGN KEY (personid) REFERENCES public.person(id);


--
-- Name: internal_flight_ticket_order fkinternal_f120670; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket_order
    ADD CONSTRAINT fkinternal_f120670 FOREIGN KEY (flightnumber, airline_name) REFERENCES public.internal_flight_ticket(flightnumber, airline_name);


--
-- Name: internal_flight_ticket_order fkinternal_f2261; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket_order
    ADD CONSTRAINT fkinternal_f2261 FOREIGN KEY (userphone_number) REFERENCES public."user"(phone_number);


--
-- Name: internal_flight_ticket fkinternal_f313007; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket
    ADD CONSTRAINT fkinternal_f313007 FOREIGN KEY (flightnumber) REFERENCES public.internal_flight(number);


--
-- Name: internal_flight fkinternal_f410201; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight
    ADD CONSTRAINT fkinternal_f410201 FOREIGN KEY (airplane_id) REFERENCES public.airplane(id);


--
-- Name: internal_flight_ticket_order fkinternal_f729355; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_flight_ticket_order
    ADD CONSTRAINT fkinternal_f729355 FOREIGN KEY (personid) REFERENCES public.person(id);


--
-- Name: person fkperson221793; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fkperson221793 FOREIGN KEY (passport_number) REFERENCES public.passport(passport_number);


--
-- Name: room fkroom33780; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT fkroom33780 FOREIGN KEY (hotelname, hotelcity) REFERENCES public.hotel(name, city);


--
-- Name: room_order fkroom_order117193; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_order
    ADD CONSTRAINT fkroom_order117193 FOREIGN KEY (userphone_number) REFERENCES public."user"(phone_number);


--
-- Name: room_order fkroom_order442223; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_order
    ADD CONSTRAINT fkroom_order442223 FOREIGN KEY (room_number) REFERENCES public.room(room_number);


--
-- Name: room_order fkroom_order614423; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_order
    ADD CONSTRAINT fkroom_order614423 FOREIGN KEY (personid) REFERENCES public.person(id);


--
-- Name: stop_city fkstop_city656787; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stop_city
    ADD CONSTRAINT fkstop_city656787 FOREIGN KEY (bus_travelid) REFERENCES public.bus_travel(id);


--
-- PostgreSQL database dump complete
--

