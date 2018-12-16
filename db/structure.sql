SET statement_timeout = 0;
SET lock_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

-- Name: plpgsql; Type: EXTENSION

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

-- Name: EXTENSION plpgsql; Type: COMMENT

-- Name: pgcrypto; Type: EXTENSION

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

-- Name: EXTENSION pgcrypto; Type: COMMENT

-- Name: assignment_role; Type: TYPE

CREATE TYPE public.assignment_role AS ENUM (
    'employee',
    'manager',
    'director',
    'owner'
);

SET default_tablespace = '';

SET default_with_oids = false;

-- Name: ar_internal_metadata; Type: TABLE

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: assignments; Type: TABLE

CREATE TABLE public.assignments (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    user_id uuid,
    ship_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role public.assignment_role DEFAULT 'employee'::public.assignment_role NOT NULL
);

-- Name: schema_migrations; Type: TABLE

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);

-- Name: ships; Type: TABLE

CREATE TABLE public.ships (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    name character varying NOT NULL,
    note text,
    fleet_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

-- Name: users; Type: TABLE

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

-- Name: index_assignments_on_ship_id; Type: INDEX

CREATE INDEX index_assignments_on_ship_id ON public.assignments USING btree (ship_id);

-- Name: index_assignments_on_user_id; Type: INDEX

CREATE INDEX index_assignments_on_user_id ON public.assignments USING btree (user_id);

-- Name: index_assignments_on_user_id_and_ship_id; Type: INDEX

CREATE UNIQUE INDEX index_assignments_on_user_id_and_ship_id ON public.assignments USING btree (user_id, ship_id);

-- Name: index_ships_on_fleet_id; Type: INDEX

CREATE INDEX index_ships_on_fleet_id ON public.ships USING btree (fleet_id);

-- Name: index_users_on_email; Type: INDEX

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);

-- Name: assignments fk_rails_00086f9bf6; Type: FK CONSTRAINT

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_rails_00086f9bf6 FOREIGN KEY (ship_id) REFERENCES public.ships(id);

-- Name: assignments fk_rails_aa6b76dac2; Type: FK CONSTRAINT

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_rails_aa6b76dac2 FOREIGN KEY (user_id) REFERENCES public.users(id);

-- PostgreSQL database dump complete

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180427193318'),
('20181215194611'),
('20181215195040'),
('20181215210423');

