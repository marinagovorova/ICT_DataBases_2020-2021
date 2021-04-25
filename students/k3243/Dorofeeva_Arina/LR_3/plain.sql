--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11
-- Dumped by pg_dump version 11.11

-- Started on 2021-04-25 00:39:02

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

DROP DATABASE courses;
--
-- TOC entry 2936 (class 1262 OID 16394)
-- Name: courses; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE courses WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1251' LC_CTYPE = 'English_United States.1251';


ALTER DATABASE courses OWNER TO postgres;

\connect courses

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
-- TOC entry 206 (class 1259 OID 16595)
-- Name: area; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Площадка

CREATE TABLE public.area (
    address character varying(30) NOT NULL,
    area_name character varying(10) NOT NULL
);


ALTER TABLE public.area OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16605)
-- Name: auditorium; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Аудитория

CREATE TABLE public.auditorium (
    auditorium_number integer NOT NULL,
    area_name character varying(20) NOT NULL,
    type character varying(10) NOT NULL
);


ALTER TABLE public.auditorium OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16679)
-- Name: class; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Занятие

CREATE TABLE public.class (
    class_id integer NOT NULL,
    auditorium_number integer NOT NULL,
    group_number integer NOT NULL,
    recruitment_id integer NOT NULL,
    date date NOT NULL,
    lesson_number integer NOT NULL,
    subject_name character varying(20) NOT NULL,
    teacher_name character varying(30) NOT NULL,
    type character varying(10) NOT NULL
);


ALTER TABLE public.class OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16677)
-- Name: class_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.class ALTER COLUMN class_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.class_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 197 (class 1259 OID 16397)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Курс

CREATE TABLE public.course (
    course_code integer NOT NULL,
    cost integer DEFAULT 1000 NOT NULL,
    hours integer DEFAULT 1 NOT NULL,
    type character varying(10) NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16395)
-- Name: course_course_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course ALTER COLUMN course_code ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_course_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 202 (class 1259 OID 16527)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Зачисление

CREATE TABLE public.enrollment (
    document_number integer NOT NULL,
    group_number integer NOT NULL,
    status character varying(30) NOT NULL,
    enrollment_id integer NOT NULL
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24644)
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.enrollment ALTER COLUMN enrollment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.enrollment_enrollment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 204 (class 1259 OID 16551)
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Группа

CREATE TABLE public."group" (
    group_number integer NOT NULL,
    recruitment_id integer NOT NULL
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16547)
-- Name: group_group_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."group" ALTER COLUMN group_number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.group_group_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 209 (class 1259 OID 16628)
-- Name: inclusion; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Вхождение

CREATE TABLE public.inclusion (
    course_code integer NOT NULL,
    inclusion_id integer NOT NULL,
    subject_name character varying(30) NOT NULL
);


ALTER TABLE public.inclusion OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24654)
-- Name: inclusion_inclusion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inclusion ALTER COLUMN inclusion_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inclusion_inclusion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 199 (class 1259 OID 16409)
-- Name: recruitment; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Набор

CREATE TABLE public.recruitment (
    recruitment_id integer NOT NULL,
    course_code integer DEFAULT 1 NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.recruitment OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16407)
-- Name: recruitment_recruitment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.recruitment ALTER COLUMN recruitment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.recruitment_recruitment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 201 (class 1259 OID 16519)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Слушатель

CREATE TABLE public.student (
    document_number integer NOT NULL,
    passport_date_of_issue date NOT NULL,
    full_name character varying(30) NOT NULL,
    passport_series_and_num character varying(12) NOT NULL,
    passport_issued_by character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    contacts character varying(50) NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16517)
-- Name: student_document_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN document_number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_document_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 205 (class 1259 OID 16587)
-- Name: subject; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Дисциплина

CREATE TABLE public.subject (
    hours integer NOT NULL,
    subject_name character varying(20) NOT NULL
);


ALTER TABLE public.subject OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16618)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

-- создание таблицы Учитель

CREATE TABLE public.teacher (
    teacher_name character varying(30) NOT NULL,
    "position" character varying(10) NOT NULL
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- TOC entry 2923 (class 0 OID 16595)
-- Dependencies: 206
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Площадка данными

INSERT INTO public.area (address, area_name) VALUES ('РљСЂРѕРЅРІРµСЂРєСЃРєРёР№ РїСЂ-С‚, 49Р°', 'РєСЂРѕРЅРІР°');
INSERT INTO public.area (address, area_name) VALUES ('Р‘РёСЂР¶РµРІР°СЏ Р»РёРЅРёСЏ, 14', 'Р±РёСЂР¶Р°');
INSERT INTO public.area (address, area_name) VALUES ('Р›РѕРјРѕРЅРѕСЃРѕРІР°, 9Рµ', 'Р»РѕРјРѕ');


--
-- TOC entry 2924 (class 0 OID 16605)
-- Dependencies: 207
-- Data for Name: auditorium; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Аудитория данными

INSERT INTO public.auditorium (auditorium_number, area_name, type) VALUES (461, 'РєСЂРѕРЅРІР°', 'lecture');
INSERT INTO public.auditorium (auditorium_number, area_name, type) VALUES (206, 'РєСЂРѕРЅРІР°', 'lecture');
INSERT INTO public.auditorium (auditorium_number, area_name, type) VALUES (123, 'РєСЂРѕРЅРІР°', 'lecture');
INSERT INTO public.auditorium (auditorium_number, area_name, type) VALUES (456, 'Р»РѕРјРѕ', 'laboratory');
INSERT INTO public.auditorium (auditorium_number, area_name, type) VALUES (789, 'Р±РёСЂР¶Р°', 'laboratory');


--
-- TOC entry 2928 (class 0 OID 16679)
-- Dependencies: 211
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Занятие данными

INSERT INTO public.class (class_id, auditorium_number, group_number, recruitment_id, date, lesson_number, subject_name, teacher_name, type) OVERRIDING SYSTEM VALUE VALUES (3, 461, 1, 1, '2021-01-01', 1, 'Р±Р°Р·С‹ РґР°РЅРЅС‹С…', 'Р“РѕРІРѕСЂРѕРІР° РњР°СЂРёРЅР° РњРёС…Р°Р№Р»РѕРІРЅР°', 'lecture');
INSERT INTO public.class (class_id, auditorium_number, group_number, recruitment_id, date, lesson_number, subject_name, teacher_name, type) OVERRIDING SYSTEM VALUE VALUES (5, 461, 1, 1, '2021-01-01', 3, 'РїСЂРѕРіСЂР°РјРјРёСЂРѕРІР°РЅРёРµ', 'РРІР°РЅ Р‘СѓСЂР°РєРѕРІ', 'lecture');
INSERT INTO public.class (class_id, auditorium_number, group_number, recruitment_id, date, lesson_number, subject_name, teacher_name, type) OVERRIDING SYSTEM VALUE VALUES (10, 789, 2, 2, '2021-01-01', 2, 'РёРЅС„РѕСЂРјР°С‚РёРєР°', 'РРІР°РЅ Р‘СѓСЂР°РєРѕРІ', 'practice');
INSERT INTO public.class (class_id, auditorium_number, group_number, recruitment_id, date, lesson_number, subject_name, teacher_name, type) OVERRIDING SYSTEM VALUE VALUES (12, 206, 2, 2, '2021-02-01', 6, 'РїСЂРѕРіСЂР°РјРјРёСЂРѕРІР°РЅРёРµ', 'РРІР°РЅ Р‘СѓСЂР°РєРѕРІ', 'practice');
INSERT INTO public.class (class_id, auditorium_number, group_number, recruitment_id, date, lesson_number, subject_name, teacher_name, type) OVERRIDING SYSTEM VALUE VALUES (14, 206, 2, 2, '2021-02-01', 6, 'РїСЂРѕРіСЂР°РјРјРёСЂРѕРІР°РЅРёРµ', 'РРІР°РЅ Р‘СѓСЂР°РєРѕРІ', 'lecture');


--
-- TOC entry 2914 (class 0 OID 16397)
-- Dependencies: 197
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Курс данными

INSERT INTO public.course (course_code, cost, hours, type) OVERRIDING SYSTEM VALUE VALUES (1, 15000, 70, 'IT');
INSERT INTO public.course (course_code, cost, hours, type) OVERRIDING SYSTEM VALUE VALUES (2, 10000, 64, 'РєСѓСЂСЃ РїРѕ Р±Рґ');


--
-- TOC entry 2919 (class 0 OID 16527)
-- Dependencies: 202
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Зачисление данными

INSERT INTO public.enrollment (document_number, group_number, status, enrollment_id) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'is_studying', 4);
INSERT INTO public.enrollment (document_number, group_number, status, enrollment_id) OVERRIDING SYSTEM VALUE VALUES (2, 1, 'expelled', 5);
INSERT INTO public.enrollment (document_number, group_number, status, enrollment_id) OVERRIDING SYSTEM VALUE VALUES (2, 2, 'graduated', 6);
INSERT INTO public.enrollment (document_number, group_number, status, enrollment_id) OVERRIDING SYSTEM VALUE VALUES (3, 2, 'is_studying', 7);


--
-- TOC entry 2921 (class 0 OID 16551)
-- Dependencies: 204
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Группа данными

INSERT INTO public."group" (group_number, recruitment_id) OVERRIDING SYSTEM VALUE VALUES (1, 1);
INSERT INTO public."group" (group_number, recruitment_id) OVERRIDING SYSTEM VALUE VALUES (2, 2);


--
-- TOC entry 2926 (class 0 OID 16628)
-- Dependencies: 209
-- Data for Name: inclusion; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Вхождение данными

INSERT INTO public.inclusion (course_code, inclusion_id, subject_name) OVERRIDING SYSTEM VALUE VALUES (1, 4, 'РёРЅС„РѕСЂРјР°С‚РёРєР°');
INSERT INTO public.inclusion (course_code, inclusion_id, subject_name) OVERRIDING SYSTEM VALUE VALUES (1, 5, 'РїСЂРѕРіСЂР°РјРјРёСЂРѕРІР°РЅРёРµ');
INSERT INTO public.inclusion (course_code, inclusion_id, subject_name) OVERRIDING SYSTEM VALUE VALUES (2, 6, 'РёРЅС„РѕСЂРјР°С‚РёРєР°');
INSERT INTO public.inclusion (course_code, inclusion_id, subject_name) OVERRIDING SYSTEM VALUE VALUES (2, 8, 'Р±Р°Р·С‹ РґР°РЅРЅС‹С…');


--
-- TOC entry 2916 (class 0 OID 16409)
-- Dependencies: 199
-- Data for Name: recruitment; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Набор данными

INSERT INTO public.recruitment (recruitment_id, course_code, start_date, end_date) OVERRIDING SYSTEM VALUE VALUES (1, 1, '2021-01-01', '2021-02-01');
INSERT INTO public.recruitment (recruitment_id, course_code, start_date, end_date) OVERRIDING SYSTEM VALUE VALUES (2, 2, '2021-02-01', '2021-03-01');


--
-- TOC entry 2918 (class 0 OID 16519)
-- Dependencies: 201
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Слушатель данными

INSERT INTO public.student (document_number, passport_date_of_issue, full_name, passport_series_and_num, passport_issued_by, address, contacts) OVERRIDING SYSTEM VALUE VALUES (1, '2015-08-31', 'Р”РѕСЂРѕС„РµРµРІР° РђСЂРёРЅР° Р”РјРёС‚СЂРёРµРІРЅР°', '0515 297301', 'РѕС‚РґРµР»РµРЅРёРµ РЈР¤РњРЎ РїРѕ РџРљ', 'РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі, РЎРјРѕР»СЏС‡РєРѕРІР° 14Рє4', 'kuriyummy@mail.ru');
INSERT INTO public.student (document_number, passport_date_of_issue, full_name, passport_series_and_num, passport_issued_by, address, contacts) OVERRIDING SYSTEM VALUE VALUES (2, '2014-07-31', 'РРІР°РЅРѕРІ РРІР°РЅ РРІР°РЅРѕРІРёС‡', '0000 000000', 'РѕС‚РґРµР»РµРЅРёРµ РЈР¤РњРЎ РїРѕ РџРљ', 'РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі, Р‘РѕР»СЊС€РѕР№ РЎР°РїСЃРѕРЅРёРµРІСЃРєРёР№ РїСЂ-С‚, 2Р°', 'ivanov@mail.ru');
INSERT INTO public.student (document_number, passport_date_of_issue, full_name, passport_series_and_num, passport_issued_by, address, contacts) OVERRIDING SYSTEM VALUE VALUES (3, '2014-07-31', 'РџРµС‚СЂРѕРІ Р’Р°СЃРёР»РёР№ РРІР°РЅРѕРІРёС‡', '1234 567890', 'РѕС‚РґРµР»РµРЅРёРµ РЈР¤РњРЎ РїРѕ РџРљ', 'РЎР°РЅРєС‚-РџРµС‚РµСЂР±СѓСЂРі, РЎС‚СѓРґРµРЅС‡РµСЃРєР°СЏ, 4', 'vasya@mail.ru');


--
-- TOC entry 2922 (class 0 OID 16587)
-- Dependencies: 205
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Дисциплина данными

INSERT INTO public.subject (hours, subject_name) VALUES (24, 'Р±Р°Р·С‹ РґР°РЅРЅС‹С…');
INSERT INTO public.subject (hours, subject_name) VALUES (40, 'РїСЂРѕРіСЂР°РјРјРёСЂРѕРІР°РЅРёРµ');
INSERT INTO public.subject (hours, subject_name) VALUES (30, 'РёРЅС„РѕСЂРјР°С‚РёРєР°');


--
-- TOC entry 2925 (class 0 OID 16618)
-- Dependencies: 208
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

-- заполнение таблицы Учитель данными

INSERT INTO public.teacher (teacher_name, "position") VALUES ('Р“РѕРІРѕСЂРѕРІР° РњР°СЂРёРЅР° РњРёС…Р°Р№Р»РѕРІРЅР°', 'Р±Рґ');
INSERT INTO public.teacher (teacher_name, "position") VALUES ('РРІР°РЅ Р‘СѓСЂР°РєРѕРІ', 'РїРё');


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 210
-- Name: class_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.class_class_id_seq', 14, true);


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 196
-- Name: course_course_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_course_code_seq', 2, true);


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 212
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_enrollment_id_seq', 7, true);


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 203
-- Name: group_group_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_group_number_seq', 2, true);


--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 213
-- Name: inclusion_inclusion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inclusion_inclusion_id_seq', 8, true);


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 198
-- Name: recruitment_recruitment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recruitment_recruitment_id_seq', 2, true);


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 200
-- Name: student_document_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_document_number_seq', 3, true);


--
-- TOC entry 2771 (class 2606 OID 24617)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (area_name);


--
-- TOC entry 2752 (class 2606 OID 16707)
-- Name: auditorium auditorium_auditorium_number_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- номер аудитории не меньше нуля

ALTER TABLE public.auditorium
    ADD CONSTRAINT auditorium_auditorium_number_check CHECK ((auditorium_number >= 0)) NOT VALID;


--
-- TOC entry 2773 (class 2606 OID 16612)
-- Name: auditorium auditorium_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditorium
    ADD CONSTRAINT auditorium_pkey PRIMARY KEY (auditorium_number);


--
-- TOC entry 2753 (class 2606 OID 24692)
-- Name: auditorium auditorium_type_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- тип аудитории выбирается из списка

ALTER TABLE public.auditorium
    ADD CONSTRAINT auditorium_type_check CHECK (((type)::text = ANY ((ARRAY['lecture'::character varying, 'laboratory'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 2754 (class 2606 OID 24707)
-- Name: class class_lesson_number_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- номер пары выбирается из списка

ALTER TABLE public.class
    ADD CONSTRAINT class_lesson_number_check CHECK ((lesson_number = ANY (ARRAY[1, 2, 3, 4, 5, 6, 7, 8]))) NOT VALID;


--
-- TOC entry 2779 (class 2606 OID 16686)
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (class_id);


--
-- TOC entry 2755 (class 2606 OID 24691)
-- Name: class class_type_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- тип занятия выбирается из списка

ALTER TABLE public.class
    ADD CONSTRAINT class_type_check CHECK (((type)::text = ANY ((ARRAY['lecture'::character varying, 'practice'::character varying])::text[]))) NOT VALID;


--
-- TOC entry 2746 (class 2606 OID 16712)
-- Name: course course_cost_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- стоимость курса больше нуля

ALTER TABLE public.course
    ADD CONSTRAINT course_cost_check CHECK ((cost > 0)) NOT VALID;


--
-- TOC entry 2747 (class 2606 OID 16711)
-- Name: course course_hours_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- количество часов больше нуля

ALTER TABLE public.course
    ADD CONSTRAINT course_hours_check CHECK ((hours > 0)) NOT VALID;


--
-- TOC entry 2757 (class 2606 OID 16401)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_code);


--
-- TOC entry 2763 (class 2606 OID 24653)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (enrollment_id);


--
-- TOC entry 2750 (class 2606 OID 24701)
-- Name: enrollment enrollment_status_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- статус зачисления выбирается из списка

ALTER TABLE public.enrollment
    ADD CONSTRAINT enrollment_status_check CHECK (((status)::text = ANY (ARRAY[('is_studying'::character varying)::text, ('graduated'::character varying)::text, ('expelled'::character varying)::text]))) NOT VALID;


--
-- TOC entry 2765 (class 2606 OID 16555)
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (group_number);


--
-- TOC entry 2767 (class 2606 OID 24695)
-- Name: group group_recruitment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_recruitment_id_key UNIQUE (recruitment_id);


--
-- TOC entry 2777 (class 2606 OID 24660)
-- Name: inclusion inclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_pkey PRIMARY KEY (inclusion_id);


--
-- TOC entry 2749 (class 2606 OID 16714)
-- Name: recruitment recruitment_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- дата начала не больше даты окончания

ALTER TABLE public.recruitment
    ADD CONSTRAINT recruitment_check CHECK ((start_date <= end_date)) NOT VALID;


--
-- TOC entry 2759 (class 2606 OID 16413)
-- Name: recruitment recruitment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment
    ADD CONSTRAINT recruitment_pkey PRIMARY KEY (recruitment_id);


--
-- TOC entry 2761 (class 2606 OID 16526)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (document_number);


--
-- TOC entry 2751 (class 2606 OID 16721)
-- Name: subject subject_hours_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

-- количество часов больше нуля

ALTER TABLE public.subject
    ADD CONSTRAINT subject_hours_check CHECK ((hours > 0)) NOT VALID;


--
-- TOC entry 2769 (class 2606 OID 24662)
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subject_name);


--
-- TOC entry 2775 (class 2606 OID 24664)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_name);


--
-- TOC entry 2784 (class 2606 OID 24639)
-- Name: auditorium auditorium_area_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditorium
    ADD CONSTRAINT auditorium_area_name_fkey FOREIGN KEY (area_name) REFERENCES public.area(area_name) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2787 (class 2606 OID 16687)
-- Name: class class_auditorium_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_auditorium_number_fkey FOREIGN KEY (auditorium_number) REFERENCES public.auditorium(auditorium_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2788 (class 2606 OID 16697)
-- Name: class class_group_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_group_number_fkey FOREIGN KEY (group_number) REFERENCES public."group"(group_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2791 (class 2606 OID 24696)
-- Name: class class_recruitment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_recruitment_id_fkey FOREIGN KEY (recruitment_id) REFERENCES public."group"(recruitment_id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2789 (class 2606 OID 24665)
-- Name: class class_sublect_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_sublect_name_fkey FOREIGN KEY (subject_name) REFERENCES public.subject(subject_name) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2790 (class 2606 OID 24670)
-- Name: class class_teacher_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_teacher_name_fkey FOREIGN KEY (teacher_name) REFERENCES public.teacher(teacher_name) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2781 (class 2606 OID 16532)
-- Name: enrollment enrollment_document_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_document_number_fkey FOREIGN KEY (document_number) REFERENCES public.student(document_number);


--
-- TOC entry 2782 (class 2606 OID 16572)
-- Name: enrollment enrollment_group_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_group_number_fkey FOREIGN KEY (group_number) REFERENCES public."group"(group_number) NOT VALID;


--
-- TOC entry 2783 (class 2606 OID 16556)
-- Name: group group_recruitment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_recruitment_id_fkey FOREIGN KEY (recruitment_id) REFERENCES public.recruitment(recruitment_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2785 (class 2606 OID 16641)
-- Name: inclusion inclusion_course_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_course_code_fkey FOREIGN KEY (course_code) REFERENCES public.course(course_code) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2786 (class 2606 OID 24702)
-- Name: inclusion inclusion_subject_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_subject_name_fkey FOREIGN KEY (subject_name) REFERENCES public.subject(subject_name) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2780 (class 2606 OID 16582)
-- Name: recruitment recruitment_course_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment
    ADD CONSTRAINT recruitment_course_code_fkey FOREIGN KEY (course_code) REFERENCES public.course(course_code) ON UPDATE RESTRICT ON DELETE RESTRICT NOT VALID;


-- Completed on 2021-04-25 00:39:02

--
-- PostgreSQL database dump complete
--

