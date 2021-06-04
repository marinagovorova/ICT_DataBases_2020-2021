--
-- PostgreSQL database dump
--

-- Dumped from database version 11.12
-- Dumped by pg_dump version 11.12

-- Started on 2021-06-04 15:29:32

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

--
-- TOC entry 2874 (class 1262 OID 16393)
-- Name: phone_station; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE phone_station WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE phone_station OWNER TO postgres;

\connect phone_station

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

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16403)
-- Name: call; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы call
CREATE TABLE public.call (
    id_call integer NOT NULL,
    id_zone integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    length integer NOT NULL,
    number_from character varying(20) NOT NULL,
    number_to character varying(20) NOT NULL,
    CONSTRAINT chk_length CHECK ((length >= 0))
);


ALTER TABLE public.call OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16395)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы client
CREATE TABLE public.client (
    phone_number character varying(20) NOT NULL,
    full_name character varying(100) NOT NULL,
    city character varying(50) NOT NULL,
    address character varying(200),
    balance real NOT NULL,
    CONSTRAINT client_phone_number_check CHECK (((phone_number)::text ~ '^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$'::text))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16435)
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы contract
CREATE TABLE public.contract (
    id_contract integer NOT NULL,
    id_tariff integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    price real NOT NULL,
    phone_number character varying(20) NOT NULL,
    CONSTRAINT chk_price CHECK ((price >= (0)::double precision))
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16427)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы payment
CREATE TABLE public.payment (
    id_payment integer NOT NULL,
    amount real NOT NULL,
    requested_date date NOT NULL,
    paid_date date,
    phone_number character varying(20) NOT NULL,
    type character varying(1) NOT NULL,
    status character varying(1) NOT NULL,
    CONSTRAINT payment_status_check CHECK (((status)::text ~ '^[ОН]$'::text)),
    CONSTRAINT payment_type_check CHECK (((type)::text ~ '^[ЗТП]$'::text))
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16443)
-- Name: price_by_zone; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы price_by_zone
CREATE TABLE public.price_by_zone (
    zone_id integer NOT NULL,
    tariff_id integer NOT NULL,
    price real NOT NULL,
    CONSTRAINT chk_price CHECK ((price >= (0)::double precision))
);


ALTER TABLE public.price_by_zone OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16419)
-- Name: tariff; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы tariff
CREATE TABLE public.tariff (
    id_tariff integer NOT NULL,
    base_price real NOT NULL,
    tariff_name character varying(50) NOT NULL,
    CONSTRAINT chk_base_price CHECK ((base_price >= (0)::double precision))
);


ALTER TABLE public.tariff OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16411)
-- Name: zone; Type: TABLE; Schema: public; Owner: postgres
--

-- Создание таблицы zone
CREATE TABLE public.zone (
    id_zone integer NOT NULL,
    zone_name character varying(50) NOT NULL
);


ALTER TABLE public.zone OWNER TO postgres;

--
-- TOC entry 2863 (class 0 OID 16403)
-- Dependencies: 197
-- Data for Name: call; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу call
INSERT INTO public.call VALUES (1, 1, '2021-05-31 09:00:00', 10, '+7 (999) 999-99-99', '+7 (999) 999-99-95');
INSERT INTO public.call VALUES (2, 1, '2021-05-31 09:10:00', 30, '+7 (999) 999-99-99', '+7 (999) 999-99-95');
INSERT INTO public.call VALUES (3, 2, '2021-06-01 18:00:00', 15, '+7 (111) 111-11-11', '+7 (999) 999-99-99');
INSERT INTO public.call VALUES (4, 2, '2021-06-01 20:00:00', 0, '+7 (111) 111-11-11', '+7 (999) 999-99-95');
INSERT INTO public.call VALUES (5, 2, '2021-06-01 21:00:00', 35, '+7 (111) 111-11-11', '+7 (999) 999-99-95');
INSERT INTO public.call VALUES (6, 3, '2021-06-01 13:00:00', 35, '+7 (123) 456-78-90', '+7 (111) 111-11-11');


--
-- TOC entry 2862 (class 0 OID 16395)
-- Dependencies: 196
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу client
INSERT INTO public.client VALUES ('+7 (999) 999-99-99', 'Ivanov Ivan', 'Ivanovo', 'ulitsa Ivanovskaya', 1000);
INSERT INTO public.client VALUES ('+7 (999) 999-99-95', 'Sidorov Petr', 'Moscow', 'Lenina st.', 0);
INSERT INTO public.client VALUES ('+7 (123) 456-78-90', 'Smirnov Vasya', 'St. Petersburg', 'Nevsky prospekt', 300);
INSERT INTO public.client VALUES ('+7 (111) 111-11-11', 'Pertova Masha', 'Moscow', 'Gagarina st.', -100);


--
-- TOC entry 2867 (class 0 OID 16435)
-- Dependencies: 201
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу contract
INSERT INTO public.contract VALUES (1, 1, '2020-01-01', NULL, 1000, '+7 (111) 111-11-11');
INSERT INTO public.contract VALUES (2, 2, '2018-03-10', NULL, 150, '+7 (123) 456-78-90');
INSERT INTO public.contract VALUES (3, 1, '2019-09-09', '2029-09-09', 900, '+7 (999) 999-99-95');
INSERT INTO public.contract VALUES (4, 3, '2021-01-01', NULL, 5000, '+7 (999) 999-99-99');


--
-- TOC entry 2866 (class 0 OID 16427)
-- Dependencies: 200
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу payment
INSERT INTO public.payment VALUES (1, 1000, '2021-02-10', '2021-02-10', '+7 (999) 999-99-99', 'П', 'О');
INSERT INTO public.payment VALUES (2, -200, '2021-02-11', '2021-02-11', '+7 (999) 999-99-99', 'Т', 'О');
INSERT INTO public.payment VALUES (3, -15, '2021-02-12', '2021-02-12', '+7 (999) 999-99-99', 'З', 'О');
INSERT INTO public.payment VALUES (4, -25, '2021-02-12', '2021-02-12', '+7 (999) 999-99-99', 'З', 'О');
INSERT INTO public.payment VALUES (5, -10, '2021-02-14', '2021-02-14', '+7 (999) 999-99-99', 'З', 'О');
INSERT INTO public.payment VALUES (6, -5000, '2021-03-14', NULL, '+7 (999) 999-99-99', 'Т', 'Н');
INSERT INTO public.payment VALUES (7, -150, '2021-05-15', NULL, '+7 (111) 111-11-11', 'Т', 'Н');
INSERT INTO public.payment VALUES (8, -10, '2021-05-20', '2021-05-20', '+7 (123) 456-78-90', 'З', 'О');
INSERT INTO public.payment VALUES (9, -10, '2021-05-20', '2021-05-20', '+7 (123) 456-78-90', 'З', 'О');
INSERT INTO public.payment VALUES (10, -10, '2021-05-20', '2021-05-20', '+7 (123) 456-78-90', 'З', 'О');
INSERT INTO public.payment VALUES (11, 10000, '2021-05-20', '2021-05-20', '+7 (123) 456-78-90', 'П', 'О');


--
-- TOC entry 2868 (class 0 OID 16443)
-- Dependencies: 202
-- Data for Name: price_by_zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу price_by_zone
INSERT INTO public.price_by_zone VALUES (1, 1, 0);
INSERT INTO public.price_by_zone VALUES (2, 1, 0);
INSERT INTO public.price_by_zone VALUES (3, 1, 30);
INSERT INTO public.price_by_zone VALUES (1, 2, 5);
INSERT INTO public.price_by_zone VALUES (2, 2, 10);
INSERT INTO public.price_by_zone VALUES (3, 2, 50);
INSERT INTO public.price_by_zone VALUES (1, 3, 10);
INSERT INTO public.price_by_zone VALUES (2, 3, 10);
INSERT INTO public.price_by_zone VALUES (3, 3, 10);


--
-- TOC entry 2865 (class 0 OID 16419)
-- Dependencies: 199
-- Data for Name: tariff; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу tariff
INSERT INTO public.tariff VALUES (1, 1000, '10000 minutes 10000 Gb');
INSERT INTO public.tariff VALUES (2, 200, 'Poor man choice');
INSERT INTO public.tariff VALUES (3, 5000, 'Very expensive tariff');


--
-- TOC entry 2864 (class 0 OID 16411)
-- Dependencies: 198
-- Data for Name: zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- Вставка в таблицу zone
INSERT INTO public.zone VALUES (1, 'city');
INSERT INTO public.zone VALUES (2, 'intercity');
INSERT INTO public.zone VALUES (3, 'intenational');


--
-- TOC entry 2722 (class 2606 OID 16410)
-- Name: call call_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы call
ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_pkey PRIMARY KEY (id_call);


--
-- TOC entry 2720 (class 2606 OID 16516)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы client
ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (phone_number);


--
-- TOC entry 2730 (class 2606 OID 16442)
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы contract
ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id_contract);


--
-- TOC entry 2728 (class 2606 OID 16434)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы payment
ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id_payment);


--
-- TOC entry 2732 (class 2606 OID 16447)
-- Name: price_by_zone price_by_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы price_by_zone
ALTER TABLE ONLY public.price_by_zone
    ADD CONSTRAINT price_by_zone_pkey PRIMARY KEY (zone_id, tariff_id);


--
-- TOC entry 2726 (class 2606 OID 16426)
-- Name: tariff tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы tariff
ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT tariff_pkey PRIMARY KEY (id_tariff);


--
-- TOC entry 2724 (class 2606 OID 16418)
-- Name: zone zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

-- Первичный ключ таблицы zone
ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (id_zone);


--
-- TOC entry 2733 (class 2606 OID 16484)
-- Name: call call_id_zone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_id_zone_fkey FOREIGN KEY (id_zone) REFERENCES public.zone(id_zone) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2734 (class 2606 OID 16517)
-- Name: call call_number_from_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_number_from_fkey FOREIGN KEY (number_from) REFERENCES public.client(phone_number) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2735 (class 2606 OID 16522)
-- Name: call call_number_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.call
    ADD CONSTRAINT call_number_to_fkey FOREIGN KEY (number_to) REFERENCES public.client(phone_number) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2737 (class 2606 OID 16469)
-- Name: contract contract_id_tariff_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_id_tariff_fkey FOREIGN KEY (id_tariff) REFERENCES public.tariff(id_tariff) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2738 (class 2606 OID 16528)
-- Name: contract contract_phone_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_phone_number_fkey FOREIGN KEY (phone_number) REFERENCES public.client(phone_number) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2736 (class 2606 OID 16533)
-- Name: payment payment_phone_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_phone_number_fkey FOREIGN KEY (phone_number) REFERENCES public.client(phone_number) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2740 (class 2606 OID 16499)
-- Name: price_by_zone price_by_zone_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.price_by_zone
    ADD CONSTRAINT price_by_zone_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariff(id_tariff) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2739 (class 2606 OID 16494)
-- Name: price_by_zone price_by_zone_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- Внешний ключ 
ALTER TABLE ONLY public.price_by_zone
    ADD CONSTRAINT price_by_zone_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.zone(id_zone) MATCH FULL DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2021-06-04 15:29:33

--
-- PostgreSQL database dump complete
--

