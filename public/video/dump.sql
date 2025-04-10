--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 16.2

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    IF EXISTS (
      SELECT 1
      FROM pg_event_trigger_ddl_commands() AS ev
      JOIN pg_extension AS ext
      ON ev.objid = ext.oid
      WHERE ext.extname = 'pg_net'
    )
    THEN
      IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'supabase_functions_admin'
      )
      THEN
        CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
      END IF;

      GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

      IF EXISTS (
        SELECT FROM pg_extension
        WHERE extname = 'pg_net'
        -- all versions in use on existing projects as of 2025-02-20
        -- version 0.12.0 onwards don't need these applied
        AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8.0', '0.10.0', '0.11.0')
      ) THEN
        ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
        ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

        ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
        ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

        REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
        REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

        GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
        GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      END IF;
    END IF;
  END;
  $$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: check_reservation_fk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_reservation_fk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

  IF NEW.reservation_type = 'hotel_offer' THEN

    IF NOT EXISTS (SELECT 1 FROM hotel_offers WHERE hotel_offer_id = NEW.reservation_type_id) THEN

      RAISE EXCEPTION 'Invalid hotel_offer_id: %', NEW.reservation_type_id;

    END IF;

  ELSIF NEW.reservation_type = 'hotel_service' THEN

    IF NOT EXISTS (SELECT 1 FROM hotel_services WHERE hotel_service_id = NEW.reservation_type_id) THEN

      RAISE EXCEPTION 'Invalid hotel_service_id: %', NEW.reservation_type_id;

    END IF;

  ELSIF NEW.reservation_type = 'restaurant' THEN

    IF NOT EXISTS (SELECT 1 FROM restaurants WHERE restaurant_id = NEW.reservation_type_id) THEN

      RAISE EXCEPTION 'Invalid restaurant_id: %', NEW.reservation_type_id;

    END IF;

  ELSIF NEW.reservation_type = 'tour_activity' THEN

    IF NOT EXISTS (SELECT 1 FROM tour_announcements WHERE tour_announcement_id = NEW.reservation_type_id) THEN

      RAISE EXCEPTION 'Invalid tour_announcement_id: %', NEW.reservation_type_id;

    END IF;

  END IF;

  RETURN NEW;

END;

$$;


ALTER FUNCTION public.check_reservation_fk() OWNER TO postgres;

--
-- Name: delete_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_user() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog', 'public'
    AS $$

BEGIN

  -- Supprimer l'utilisateur de public.users

  DELETE FROM public.users WHERE user_id = auth.uid();

  

  -- Supprimer l'utilisateur de auth.users

  DELETE FROM auth.users WHERE id = auth.uid();

  

  -- V├®rifier si l'utilisateur a ├®t├® supprim├® de auth.users

  IF NOT FOUND THEN

    RAISE EXCEPTION 'Utilisateur non trouv├® dans auth.users pour UID : %', auth.uid();

  END IF;

END;

$$;


ALTER FUNCTION public.delete_user() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

BEGIN

  INSERT INTO public.users (

    user_id,

    email,

    first_name,

    last_name,

    username,

    role,

    created_at,

    updated_at

  )

  VALUES (

    NEW.id,

    NEW.email,

    COALESCE(NEW.raw_user_meta_data->>'first_name', 'Utilisateur'),

    COALESCE(NEW.raw_user_meta_data->>'last_name', 'SansNom'),

    NEW.email, -- Optionnel : peut ├¬tre omis si username n'est pas requis

    'visitor',

    NOW(),

    NOW()

  )

  ON CONFLICT (user_id) DO UPDATE

  SET email = EXCLUDED.email,

      first_name = COALESCE(EXCLUDED.first_name, public.users.first_name),

      last_name = COALESCE(EXCLUDED.last_name, public.users.last_name),

      username = EXCLUDED.username,

      updated_at = NOW();

  RETURN NEW;

END;

$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: insert_reservation(uuid, text, uuid, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE

  v_reservation_id UUID;

BEGIN

  INSERT INTO reservations (

    user_id,

    reservation_type,

    reservation_type_id,

    number_of_people,

    special_request

  )

  VALUES (

    p_user_id,

    p_reservation_type,

    p_reservation_type_id,

    p_number_of_people,

    p_special_request

  )

  RETURNING reservation_id INTO v_reservation_id;

  RETURN v_reservation_id;

END;

$$;


ALTER FUNCTION public.insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: hotel_offers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel_offers (
    hotel_offer_id uuid DEFAULT gen_random_uuid() NOT NULL,
    hotel_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    room_type character varying(100),
    number_of_rooms integer DEFAULT 1,
    wifi_included boolean DEFAULT false,
    breakfast_included boolean DEFAULT false,
    lunch_included boolean DEFAULT false,
    dinner_included boolean DEFAULT false,
    parking_included boolean DEFAULT false,
    pool_access boolean DEFAULT false,
    gym_access boolean DEFAULT false,
    spa_access boolean DEFAULT false,
    additional_notes text,
    max_occupancy integer DEFAULT 1,
    is_refundable boolean,
    discount_percentage numeric(5,2) DEFAULT 0,
    old_price numeric(10,2),
    new_price numeric(10,2) GENERATED ALWAYS AS ((price * ((1)::numeric - (discount_percentage / (100)::numeric)))) STORED,
    images text,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.hotel_offers OWNER TO postgres;

--
-- Name: hotel_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel_services (
    hotel_service_id uuid DEFAULT gen_random_uuid() NOT NULL,
    hotel_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    service_type character varying(50) NOT NULL,
    duration_type character varying(50) DEFAULT 'once'::character varying,
    discount_percentage numeric(5,2) DEFAULT 0,
    old_price numeric(10,2),
    new_price numeric(10,2) GENERATED ALWAYS AS ((price * ((1)::numeric - (discount_percentage / (100)::numeric)))) STORED,
    CONSTRAINT hotel_services_duration_type_check CHECK (((duration_type)::text = ANY ((ARRAY['once'::character varying, 'hourly'::character varying, 'daily'::character varying, 'weekly'::character varying, 'monthly'::character varying, 'yearly'::character varying])::text[]))),
    CONSTRAINT hotel_services_service_type_check CHECK (((service_type)::text = ANY ((ARRAY['pool'::character varying, 'gym'::character varying, 'spa'::character varying, 'restaurant'::character varying, 'room_service'::character varying, 'bar'::character varying, 'conference_room'::character varying, 'parking'::character varying])::text[])))
);


ALTER TABLE public.hotel_services OWNER TO postgres;

--
-- Name: hotels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotels (
    hotel_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    location character varying(255),
    phone_number character varying(15),
    email character varying(100),
    history text,
    star_rating real NOT NULL,
    images text,
    amenities text,
    check_in_time time without time zone,
    check_out_time time without time zone,
    additional_notes text,
    payment_methods text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    wilaya character varying(100),
    admin_id uuid,
    CONSTRAINT hotels_star_rating_check CHECK (((star_rating >= (1)::double precision) AND (star_rating <= (5)::double precision))),
    CONSTRAINT valid_wilaya CHECK (((wilaya)::text = ANY ((ARRAY['Adrar'::character varying, 'Chlef'::character varying, 'Laghouat'::character varying, 'Oum El Bouaghi'::character varying, 'Batna'::character varying, 'B├®ja├»a'::character varying, 'Biskra'::character varying, 'B├®char'::character varying, 'Blida'::character varying, 'Bouira'::character varying, 'Tamanrasset'::character varying, 'T├®bessa'::character varying, 'Tlemcen'::character varying, 'Tiaret'::character varying, 'Tizi Ouzou'::character varying, 'Alger'::character varying, 'Djelfa'::character varying, 'Jijel'::character varying, 'S├®tif'::character varying, 'Sa├»da'::character varying, 'Skikda'::character varying, 'Sidi Bel Abb├¿s'::character varying, 'Annaba'::character varying, 'Guelma'::character varying, 'Constantine'::character varying, 'M├®d├®a'::character varying, 'Mostaganem'::character varying, 'M''Sila'::character varying, 'Mascara'::character varying, 'Ouargla'::character varying, 'Oran'::character varying, 'El Bayadh'::character varying, 'Illizi'::character varying, 'Bordj Bou Arreridj'::character varying, 'Boumerd├¿s'::character varying, 'El Tarf'::character varying, 'Tindouf'::character varying, 'Tissemsilt'::character varying, 'El Oued'::character varying, 'Khenchela'::character varying, 'Souk Ahras'::character varying, 'Tipaza'::character varying, 'Mila'::character varying, 'A├»n Defla'::character varying, 'Na├óma'::character varying, 'A├»n T├®mouchent'::character varying, 'Gharda├»a'::character varying, 'Relizane'::character varying])::text[])))
);


ALTER TABLE public.hotels OWNER TO postgres;

--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    reservation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    reservation_type character varying(50) NOT NULL,
    reservation_type_id uuid NOT NULL,
    booking_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    number_of_people integer DEFAULT 1 NOT NULL,
    special_request text,
    payment_status character varying(50) DEFAULT 'pending'::character varying,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    duration integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reservations_duration_check CHECK ((duration >= 1)),
    CONSTRAINT reservations_number_of_people_check CHECK ((number_of_people >= 1)),
    CONSTRAINT reservations_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'failed'::character varying, 'refunded'::character varying])::text[]))),
    CONSTRAINT reservations_reservation_type_check CHECK (((reservation_type)::text = ANY ((ARRAY['hotel_offer'::character varying, 'hotel_service'::character varying, 'restaurant'::character varying, 'tour_activity'::character varying])::text[]))),
    CONSTRAINT reservations_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'confirmed'::character varying, 'canceled'::character varying])::text[])))
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurants (
    restaurant_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    location text,
    phone_number text,
    email text,
    speciality text,
    star_rating real,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    images text,
    cuisine_type text,
    opening_hours text,
    additional_notes text,
    dress_code text,
    payment_methods text,
    menu text,
    owner_id uuid DEFAULT auth.uid(),
    status character varying,
    CONSTRAINT restaurants_star_rating_check CHECK (((star_rating >= (1)::double precision) AND (star_rating <= (5)::double precision))),
    CONSTRAINT restaurants_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.restaurants OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    review_type character varying(50) NOT NULL,
    review_type_id uuid NOT NULL,
    rating integer NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5))),
    CONSTRAINT reviews_review_type_check CHECK (((review_type)::text = ANY ((ARRAY['hotel_offer'::character varying, 'hotel_service'::character varying, 'restaurant'::character varying, 'tour_activity'::character varying])::text[])))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: tour_announcements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_announcements (
    tour_announcement_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255),
    description text,
    price numeric(10,2) NOT NULL,
    discount_percentage numeric(5,2) DEFAULT 0,
    old_price numeric(10,2),
    start_date date NOT NULL,
    end_date date NOT NULL,
    difficulty_level character varying(50) DEFAULT 'moderate'::character varying,
    duration character varying(100),
    what_to_bring text,
    meeting_point character varying(255),
    images text,
    max_participants integer,
    language character varying(50),
    is_guided boolean DEFAULT false,
    location character varying(255),
    is_available boolean,
    "Contact" integer,
    created_at timestamp with time zone DEFAULT now(),
    new_price numeric GENERATED ALWAYS AS (
CASE
    WHEN (discount_percentage > (0)::numeric) THEN (price * ((1)::numeric - (discount_percentage / 100.0)))
    ELSE price
END) STORED,
    CONSTRAINT tour_announcements_difficulty_level_check CHECK (((difficulty_level)::text = ANY ((ARRAY['easy'::character varying, 'moderate'::character varying, 'difficult'::character varying])::text[])))
);


ALTER TABLE public.tour_announcements OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    username character varying(100),
    email character varying(100) NOT NULL,
    nationality character varying(100),
    address character varying(255),
    profession character varying(100),
    phone_number character varying(15),
    profile_picture character varying(255),
    role text NOT NULL,
    verified_account boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK ((role = ANY (ARRAY[('visitor'::character varying)::text, ('hotel_admin'::character varying)::text, ('restaurant_admin'::character varying)::text, ('site_admin'::character varying)::text, ('tour_organizer'::character varying)::text])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	66046034-4c95-420a-8f17-2061f6a42e81	{"action":"user_confirmation_requested","actor_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-14 10:23:00.579674+00	
00000000-0000-0000-0000-000000000000	ba28cbe8-7e83-4eb4-852c-1aa28b2a10a4	{"action":"user_confirmation_requested","actor_id":"f175551d-70e1-45bd-a18e-4b76894795b4","actor_username":"hiweyec481@cashbn.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-14 10:31:25.605773+00	
00000000-0000-0000-0000-000000000000	c9d64825-e6f6-4808-9be1-07a9df7ba13c	{"action":"user_signedup","actor_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-02-14 10:35:49.185562+00	
00000000-0000-0000-0000-000000000000	47c9eca3-f879-4a86-9e40-d5d77e4b084b	{"action":"login","actor_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 10:36:33.331951+00	
00000000-0000-0000-0000-000000000000	b1d29f18-6a89-4406-9afe-bb8c1eb72353	{"action":"login","actor_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 10:37:04.086123+00	
00000000-0000-0000-0000-000000000000	c58459f7-f02f-4d49-9fe5-9ddb367afec2	{"action":"login","actor_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 10:52:57.63308+00	
00000000-0000-0000-0000-000000000000	b714dfbc-eeb7-45b5-adaf-04b71967409d	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ib.yebdri@gmail.com","user_id":"49b15cb8-a4ca-4b11-99ab-4526e3aacdea","user_phone":""}}	2025-02-14 10:58:39.360295+00	
00000000-0000-0000-0000-000000000000	dc94f59f-dd68-4b0d-83fb-80a0fda12a3f	{"action":"user_signedup","actor_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-02-14 10:58:58.546291+00	
00000000-0000-0000-0000-000000000000	28d6d7ab-ea02-4dc5-92f4-184e7facbcb8	{"action":"login","actor_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 11:00:34.501819+00	
00000000-0000-0000-0000-000000000000	2a672ca2-1b12-470f-a29c-8d0d19f8f2b9	{"action":"login","actor_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 11:09:34.237382+00	
00000000-0000-0000-0000-000000000000	6446b216-1156-411f-9286-10cfc4730194	{"action":"user_repeated_signup","actor_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-14 11:11:10.688926+00	
00000000-0000-0000-0000-000000000000	f66f3b66-acea-41a8-83fa-727ccdfa86d2	{"action":"login","actor_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 11:11:52.764685+00	
00000000-0000-0000-0000-000000000000	b9d3aa8d-3263-4370-ace9-8662f74f3a68	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ib.yebdri@gmail.com","user_id":"9678b469-4562-45e7-86cd-1ae54bc34b9b","user_phone":""}}	2025-02-14 11:13:40.797747+00	
00000000-0000-0000-0000-000000000000	2fec358f-e487-4de1-aefa-4a57a158309d	{"action":"user_confirmation_requested","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-14 11:15:18.54257+00	
00000000-0000-0000-0000-000000000000	2871d1a8-c937-4b8d-a687-963b3d900e88	{"action":"user_confirmation_requested","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-14 11:16:36.836458+00	
00000000-0000-0000-0000-000000000000	03b552b7-dab8-40af-9fb5-7d53cbec3aa8	{"action":"user_signedup","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-02-14 11:17:08.077152+00	
00000000-0000-0000-0000-000000000000	09973b06-76de-4b9c-bfbe-c4708d8ffef1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:17:24.745426+00	
00000000-0000-0000-0000-000000000000	b692f10c-38d1-472a-ae84-ba4f1394fb39	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:18:18.34325+00	
00000000-0000-0000-0000-000000000000	82aba95c-04a7-4239-be30-df2e8f5531b9	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:18:24.685644+00	
00000000-0000-0000-0000-000000000000	8565352b-d30b-4f06-b972-3310947ea91a	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:23:09.559903+00	
00000000-0000-0000-0000-000000000000	fda0bdfc-af8c-4d36-b2f9-10ac0f32b83a	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:23:27.182614+00	
00000000-0000-0000-0000-000000000000	4015d0fe-494e-4d1e-b3b8-6ded55dda638	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:27:07.720234+00	
00000000-0000-0000-0000-000000000000	28ff7ba5-beec-46ed-a314-818173efd1d0	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 11:27:16.319989+00	
00000000-0000-0000-0000-000000000000	cf606426-32fe-4373-b9c6-c8565ff39756	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:27:31.294959+00	
00000000-0000-0000-0000-000000000000	818529d3-cae4-4fe1-b21e-232a53f94aa3	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 11:43:23.630845+00	
00000000-0000-0000-0000-000000000000	34566f99-2443-4baf-b1a1-21053661dfff	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 12:47:58.732348+00	
00000000-0000-0000-0000-000000000000	7c368f81-42c7-4da6-a342-de3daf61841b	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 13:18:46.211557+00	
00000000-0000-0000-0000-000000000000	b954d968-9fea-4057-a5a9-0709a9e5f734	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 13:18:46.213351+00	
00000000-0000-0000-0000-000000000000	e77d5ff9-c211-405e-861d-f690606cebb3	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 18:26:15.068919+00	
00000000-0000-0000-0000-000000000000	5df7126d-d88c-4b5a-893a-3756aa5452a6	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 13:18:47.738343+00	
00000000-0000-0000-0000-000000000000	7f41cf97-a6fd-4f0a-b150-ee69ce0929b4	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 13:38:43.71572+00	
00000000-0000-0000-0000-000000000000	6a0a885b-5748-4b88-ba2d-af05a0d8cd08	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 13:42:09.577461+00	
00000000-0000-0000-0000-000000000000	825e4155-300a-4ee7-b594-7f84aa51b2e8	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 14:07:41.321836+00	
00000000-0000-0000-0000-000000000000	f1839c92-1a3c-41e6-8b93-8842abd85d86	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 15:08:00.904535+00	
00000000-0000-0000-0000-000000000000	c35848b3-55ed-4980-8e4c-4a2e0a36667a	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 15:08:00.906986+00	
00000000-0000-0000-0000-000000000000	0309fdd3-6863-483c-9403-973ef4071e4e	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 15:16:07.653515+00	
00000000-0000-0000-0000-000000000000	86d77f07-674f-44f1-9f15-40cce460abe1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 15:16:17.793325+00	
00000000-0000-0000-0000-000000000000	cbcc8fc9-4e80-415c-a105-f7ac06241916	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 15:27:51.686788+00	
00000000-0000-0000-0000-000000000000	1ea18f66-9fd8-449e-abe7-b2794ccbfeef	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 15:31:27.498951+00	
00000000-0000-0000-0000-000000000000	e02f71c4-b834-4817-9914-025e0656ea24	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 16:14:29.931586+00	
00000000-0000-0000-0000-000000000000	faddaafd-13bd-496e-aeae-a137ce8ab76e	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 16:14:42.821301+00	
00000000-0000-0000-0000-000000000000	d2d1908a-506d-4339-9542-1421492c29a1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 16:22:32.491521+00	
00000000-0000-0000-0000-000000000000	ac5cb624-7a5e-4050-b78e-f5608fa38510	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 17:30:05.575293+00	
00000000-0000-0000-0000-000000000000	5f621da9-9514-41c3-9fe4-37aa6a9bbbd2	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 17:30:05.57697+00	
00000000-0000-0000-0000-000000000000	1c7f9075-c1cc-4090-8e9d-dbd325a9a88b	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 18:16:38.669285+00	
00000000-0000-0000-0000-000000000000	907647af-c680-435a-a1eb-ef529ac2ced1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 18:21:57.975605+00	
00000000-0000-0000-0000-000000000000	d39dbd81-200b-4c50-9be6-e59088255c1a	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 18:23:13.245824+00	
00000000-0000-0000-0000-000000000000	5f3d5ea5-fcca-4828-a556-31815683b475	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 18:24:00.049015+00	
00000000-0000-0000-0000-000000000000	28f5aff7-eae5-430a-aa7f-f47aafded3cc	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 18:36:51.744287+00	
00000000-0000-0000-0000-000000000000	57c00eae-0a89-42ba-ae16-1c1379cb4505	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 18:37:29.712491+00	
00000000-0000-0000-0000-000000000000	11ef630a-32b7-48d0-b1d1-8066bbb12fbe	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-14 19:38:05.492926+00	
00000000-0000-0000-0000-000000000000	ea2d3722-235d-47e6-b9d5-d28c0a7b4fbf	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 19:39:20.819873+00	
00000000-0000-0000-0000-000000000000	2bfc92c9-2e9a-40a0-b464-3eb3a07e1e5e	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 20:49:41.653516+00	
00000000-0000-0000-0000-000000000000	be7a9012-70ff-4ec8-8716-e1c1ab29b820	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 20:49:41.656048+00	
00000000-0000-0000-0000-000000000000	170fd200-cbd3-431a-8af8-51793409f98d	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 20:50:44.106308+00	
00000000-0000-0000-0000-000000000000	a9a886c3-7165-4dfc-9b90-3134c06eb17e	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 20:51:27.512927+00	
00000000-0000-0000-0000-000000000000	0705cc9a-faae-4460-b92a-aabb7d86fea8	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 21:20:43.595992+00	
00000000-0000-0000-0000-000000000000	6ab1dbcc-5cef-4748-8019-5477360fd6c1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 21:24:01.300592+00	
00000000-0000-0000-0000-000000000000	194c8972-24e8-4f6b-99b9-96916c749093	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 21:25:02.981091+00	
00000000-0000-0000-0000-000000000000	91f67e24-57f3-41be-ab0d-f2517fd33c31	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 21:54:02.628587+00	
00000000-0000-0000-0000-000000000000	25a62957-b5e0-43d3-af68-10d2b0ca617d	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 22:56:31.88404+00	
00000000-0000-0000-0000-000000000000	9a071690-74eb-4bb1-a782-34ebc44b8131	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 22:56:31.885561+00	
00000000-0000-0000-0000-000000000000	a11c59f0-e24a-4a01-886b-964315dec126	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 23:03:57.448354+00	
00000000-0000-0000-0000-000000000000	ae5af5cf-5aa6-42d2-a901-316acac2f7df	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 23:04:00.189422+00	
00000000-0000-0000-0000-000000000000	14a3b506-9db4-4bde-85f7-a89df58791d5	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 23:04:00.722561+00	
00000000-0000-0000-0000-000000000000	8fe77788-319a-450f-a6ad-547badb63f56	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 23:04:01.1317+00	
00000000-0000-0000-0000-000000000000	30fa4c47-0b02-4677-a637-d9a5042cbe5c	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-15 10:52:43.443317+00	
00000000-0000-0000-0000-000000000000	1132179f-d479-4320-97d7-98abf364b234	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-15 18:29:54.336484+00	
00000000-0000-0000-0000-000000000000	20e2712a-b096-4050-9ecf-a2546baf5318	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-15 19:30:09.764838+00	
00000000-0000-0000-0000-000000000000	4c564c31-19b7-461d-9faf-9464572c00c8	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-15 19:30:09.766901+00	
00000000-0000-0000-0000-000000000000	ccf8e8ae-7bc0-4483-98d8-eb44fc7b50a2	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-16 12:43:05.15816+00	
00000000-0000-0000-0000-000000000000	d5208002-270b-483b-983f-ce6a0a42b5e3	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-16 12:43:05.182506+00	
00000000-0000-0000-0000-000000000000	f047bd38-be53-4766-83f9-a899a89a2883	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-16 13:51:34.896546+00	
00000000-0000-0000-0000-000000000000	2842ff42-936b-4d19-a00e-80a105575669	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-16 13:51:34.897479+00	
00000000-0000-0000-0000-000000000000	cef00af4-cd68-45f4-93bd-d74bc3f68d0c	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-16 14:13:08.283472+00	
00000000-0000-0000-0000-000000000000	c15579a9-45c3-4ab5-b98a-02308620c60c	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-16 14:13:14.009936+00	
00000000-0000-0000-0000-000000000000	0c4c5ce8-0861-4d94-8317-61db72a2b0b4	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-16 14:13:42.562466+00	
00000000-0000-0000-0000-000000000000	f7f5441c-432e-459a-b050-aaa54cc71292	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-16 14:13:56.631381+00	
00000000-0000-0000-0000-000000000000	4915dbe2-7082-4516-9937-e71b7ac71404	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-16 14:18:05.781727+00	
00000000-0000-0000-0000-000000000000	1fe1475f-a192-4a70-a47b-1f87351ff35f	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 10:17:27.876828+00	
00000000-0000-0000-0000-000000000000	a55f2292-b8d3-46f7-a3fc-ccba3f663099	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 10:17:27.900934+00	
00000000-0000-0000-0000-000000000000	aeab59a5-4fe8-44a1-8cf5-16e5249884f8	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 10:24:49.35879+00	
00000000-0000-0000-0000-000000000000	2d8730c4-17d7-45d5-8571-6edfffe30e0b	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-17 10:50:20.880094+00	
00000000-0000-0000-0000-000000000000	e9fed95b-e23e-4412-a44b-3c1f02dfe85d	{"action":"user_recovery_requested","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-02-17 10:50:26.737462+00	
00000000-0000-0000-0000-000000000000	265c6e98-3a97-43b7-ae5b-659620fd6b1b	{"action":"user_recovery_requested","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-02-17 10:51:35.095036+00	
00000000-0000-0000-0000-000000000000	06b5cd66-8561-4129-bb39-7df0b5fcf90c	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 10:56:36.360118+00	
00000000-0000-0000-0000-000000000000	c283cc40-77ea-4547-87f3-85ff3335a8e5	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:01:41.26994+00	
00000000-0000-0000-0000-000000000000	01170cd4-0649-4c62-93a4-e483f7cf0658	{"action":"user_confirmation_requested","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-17 11:08:48.505528+00	
00000000-0000-0000-0000-000000000000	3458039c-dbef-49bc-a595-58b0133e45b6	{"action":"user_signedup","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"team"}	2025-02-17 11:09:03.279235+00	
00000000-0000-0000-0000-000000000000	de68b1e4-0667-400f-8f78-fb89fc0d6fb7	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:10:12.717072+00	
00000000-0000-0000-0000-000000000000	96d42f1f-a7cc-4613-aea9-ce4893b7fe7d	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:16:25.385096+00	
00000000-0000-0000-0000-000000000000	6a854a96-52aa-4c78-bca5-69cec2092604	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:16:25.467685+00	
00000000-0000-0000-0000-000000000000	90d96735-167e-4d18-9626-deb01c5813f7	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:16:25.488109+00	
00000000-0000-0000-0000-000000000000	0c937822-cd96-4001-9123-abcad65b1c98	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:16:25.546756+00	
00000000-0000-0000-0000-000000000000	52627141-0332-4e24-9656-60a651a9fa76	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 11:16:29.947757+00	
00000000-0000-0000-0000-000000000000	f3f90e41-360a-4d73-8c12-ee84cfaced8b	{"action":"logout","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account"}	2025-02-17 11:46:59.286807+00	
00000000-0000-0000-0000-000000000000	1f9bf940-a499-4016-930c-02dde310237b	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-18 16:12:52.7936+00	
00000000-0000-0000-0000-000000000000	3016b68a-776d-4fc6-8dd7-bb50be858532	{"action":"user_confirmation_requested","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-19 18:02:41.203649+00	
00000000-0000-0000-0000-000000000000	639b6966-c746-41cf-ad7a-bd4689beb2da	{"action":"user_signedup","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-02-19 18:03:15.944706+00	
00000000-0000-0000-0000-000000000000	aace5dca-a288-4f38-b2f2-a7068fb477ae	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 19:09:59.027249+00	
00000000-0000-0000-0000-000000000000	847cfe71-fbcf-4681-b1ca-f8097d6964b3	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 19:09:59.038869+00	
00000000-0000-0000-0000-000000000000	c793690a-7a18-41b2-af50-da676437cb21	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 20:13:04.841254+00	
00000000-0000-0000-0000-000000000000	cfb4e1fc-926a-4208-a6ba-797ba6ab0ee4	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 20:13:04.843064+00	
00000000-0000-0000-0000-000000000000	2dcbd4b9-ec6a-423b-ba13-c1e09debaa52	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 10:19:51.205247+00	
00000000-0000-0000-0000-000000000000	465714cb-530f-454a-9aa9-69e84d9d8102	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 10:19:51.229023+00	
00000000-0000-0000-0000-000000000000	7beecf4b-e17a-4a2d-99f8-76ff23753aef	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 11:39:38.726142+00	
00000000-0000-0000-0000-000000000000	fb2f57ca-f1c8-4688-87d8-432be77a403e	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 11:39:38.729405+00	
00000000-0000-0000-0000-000000000000	ec461b52-3f52-45e7-8a29-fafac7812662	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 14:04:32.389568+00	
00000000-0000-0000-0000-000000000000	8ec8a8b1-bbce-4b44-be68-c8f50776f5db	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 14:04:32.397638+00	
00000000-0000-0000-0000-000000000000	b57bc018-87b1-4e97-9a90-2a78a3777171	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 14:33:21.244281+00	
00000000-0000-0000-0000-000000000000	f358c7bb-49ad-4b46-9051-820bf03944ad	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 14:38:18.276472+00	
00000000-0000-0000-0000-000000000000	4941a81c-9dcc-43a2-a3e3-8b1280ef66bd	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 16:24:48.969734+00	
00000000-0000-0000-0000-000000000000	79b20139-ffa3-4139-b830-659672763929	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-21 16:24:48.972185+00	
00000000-0000-0000-0000-000000000000	edcbd1cc-51f0-4131-b584-e61ba21856cc	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 19:15:04.819213+00	
00000000-0000-0000-0000-000000000000	b3bb770b-7d6d-44c0-ac0c-258a350e0e12	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 19:16:25.67331+00	
00000000-0000-0000-0000-000000000000	c1bae2d5-e8fc-4839-8412-96fd67124f70	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-22 15:03:56.662074+00	
00000000-0000-0000-0000-000000000000	6757a95b-704d-46b4-8c2a-58c6eedf5b2e	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-22 15:03:56.678348+00	
00000000-0000-0000-0000-000000000000	2bc9e213-8408-4262-a260-fc032e6e413b	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-22 15:16:56.857338+00	
00000000-0000-0000-0000-000000000000	9830c549-41e4-4b61-9eb3-8499abd498f5	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-22 15:17:58.992497+00	
00000000-0000-0000-0000-000000000000	5123d0c4-d86a-4cc2-baa8-a01faa1f66ee	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-22 15:31:47.511304+00	
00000000-0000-0000-0000-000000000000	90cea4ce-0fbd-4cdb-8c96-2a5feba75de5	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-22 15:43:16.166798+00	
00000000-0000-0000-0000-000000000000	daefe378-e40d-44eb-9161-e64a152443f6	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-23 14:56:55.930745+00	
00000000-0000-0000-0000-000000000000	6f86c01f-6318-42e4-a9f7-fc568ec678ef	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-23 14:56:55.949482+00	
00000000-0000-0000-0000-000000000000	b3c140c0-255b-42b8-94da-8c27f139d35d	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-23 16:00:50.342901+00	
00000000-0000-0000-0000-000000000000	655bd8c9-7bac-41e3-87c7-6bfb2f4f0db4	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-23 16:00:50.348094+00	
00000000-0000-0000-0000-000000000000	0242537e-9fb0-4814-843d-8e1eab0feb59	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 16:16:59.310134+00	
00000000-0000-0000-0000-000000000000	3c5522ba-d5b8-48bc-adfb-f9e3d0e579ed	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-23 16:17:24.196414+00	
00000000-0000-0000-0000-000000000000	2ed795e8-2010-4024-b0c4-b9390b0ebd0d	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 16:17:28.661606+00	
00000000-0000-0000-0000-000000000000	c17c5a15-1113-4bbc-9660-f34a68ba552a	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-23 16:17:30.999408+00	
00000000-0000-0000-0000-000000000000	21ded89c-8469-4b98-8a67-a0d984309cbc	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-23 16:17:41.562187+00	
00000000-0000-0000-0000-000000000000	853e1a24-9b23-4f02-ac4a-87afb1e29090	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 16:17:52.195906+00	
00000000-0000-0000-0000-000000000000	f65005b1-954e-4af4-be58-45748871f35b	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 17:00:34.668798+00	
00000000-0000-0000-0000-000000000000	877761e3-cfe7-4c05-8947-4aefe03c5eb9	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-23 17:04:58.670955+00	
00000000-0000-0000-0000-000000000000	a6822091-c690-46a8-9dd5-74d28febf7f0	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 17:11:40.491904+00	
00000000-0000-0000-0000-000000000000	af838bbc-b27f-4f6a-a504-9d2968dff5b0	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-23 17:27:13.231321+00	
00000000-0000-0000-0000-000000000000	9cb51252-84bc-46bc-aeee-558be80d9dfe	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-24 14:22:25.746234+00	
00000000-0000-0000-0000-000000000000	8dd343c2-184b-4b1d-98b5-d58bb386dc95	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-24 14:22:25.756437+00	
00000000-0000-0000-0000-000000000000	09f473f6-9663-42b8-ad32-29be0fb18e94	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 15:08:27.662325+00	
00000000-0000-0000-0000-000000000000	46a042fe-1dd9-4110-8363-a4e143e98d7b	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 15:15:05.650821+00	
00000000-0000-0000-0000-000000000000	c9b27341-a6d2-4927-aca9-be93f61a1e19	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 15:29:49.953369+00	
00000000-0000-0000-0000-000000000000	be62123d-3ca8-4806-9d86-5c8e81394bc9	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-24 15:52:47.64741+00	
00000000-0000-0000-0000-000000000000	903db068-2cd1-4633-88f0-0dfc9535fac2	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 15:53:05.1859+00	
00000000-0000-0000-0000-000000000000	6a190fef-54af-4224-8d33-347236c121cf	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 15:56:29.964672+00	
00000000-0000-0000-0000-000000000000	5c43c791-8cc0-435b-b993-8a385d2a7206	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 16:00:04.277549+00	
00000000-0000-0000-0000-000000000000	abac1a40-4186-40f9-a339-b1cc032bb195	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-24 17:55:21.634755+00	
00000000-0000-0000-0000-000000000000	34668b4b-88f3-4398-9a07-36648b3e5d6b	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 09:19:00.363069+00	
00000000-0000-0000-0000-000000000000	56fa259e-a98a-4f9b-9c98-ec6e0dbe8da0	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 09:19:00.383961+00	
00000000-0000-0000-0000-000000000000	d6141f73-0471-4ab7-9310-a2ed10388ad0	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:23:35.790168+00	
00000000-0000-0000-0000-000000000000	37df78c6-7a37-4900-8fed-7a8a4b6bad69	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 10:22:01.930694+00	
00000000-0000-0000-0000-000000000000	69fbbc7f-2fe1-42f4-bad5-5cfa2c64bb1a	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 10:22:01.933757+00	
00000000-0000-0000-0000-000000000000	a7e35d01-6456-4ba7-92f4-d7fb3c437247	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 10:47:33.012005+00	
00000000-0000-0000-0000-000000000000	c6de8f48-3f4a-4ebb-9b1e-171dba806062	{"action":"user_confirmation_requested","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-25 10:50:25.516714+00	
00000000-0000-0000-0000-000000000000	c955895d-d596-495b-ae7a-99c70fe7d588	{"action":"user_signedup","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"team"}	2025-02-25 10:50:44.716483+00	
00000000-0000-0000-0000-000000000000	ecb06015-8401-4125-b0e6-24a5730f7673	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 10:50:59.887202+00	
00000000-0000-0000-0000-000000000000	c707fb84-b931-417a-b838-a99ba131d062	{"action":"token_refreshed","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 11:53:04.256562+00	
00000000-0000-0000-0000-000000000000	c2812c8a-5e60-494b-8069-8fca901a35b3	{"action":"token_revoked","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 11:53:04.262586+00	
00000000-0000-0000-0000-000000000000	7913c96b-67f9-420f-9839-5a3112a02749	{"action":"token_refreshed","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 13:37:02.421109+00	
00000000-0000-0000-0000-000000000000	9a9deb29-f13a-4823-a788-dcb917699a51	{"action":"token_revoked","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 13:37:02.422797+00	
00000000-0000-0000-0000-000000000000	c4cd3c1a-64c5-4662-9b0b-f89ea1fb3644	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:55:48.633943+00	
00000000-0000-0000-0000-000000000000	5c4e88d3-dfc4-46c6-abfb-ecc08bc8513f	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:55:50.41522+00	
00000000-0000-0000-0000-000000000000	457975f8-aa62-4087-ba81-32ee7d261184	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:56:09.248976+00	
00000000-0000-0000-0000-000000000000	b560bec6-f935-413c-ad3b-fbfbfb034176	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:56:11.062055+00	
00000000-0000-0000-0000-000000000000	5e5bff0b-7d8f-4387-a62d-11a7be44da52	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:56:11.250095+00	
00000000-0000-0000-0000-000000000000	ada467d7-56b4-4159-92bb-f63d00680e26	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 13:56:22.604039+00	
00000000-0000-0000-0000-000000000000	b036ec1e-39ad-4510-a4cd-3c835feba683	{"action":"token_refreshed","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 15:23:32.042058+00	
00000000-0000-0000-0000-000000000000	fc833f8c-4b83-4260-98fe-2dc2404f2a6c	{"action":"token_revoked","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-25 15:23:32.044972+00	
00000000-0000-0000-0000-000000000000	2f057567-9bb5-4a89-acfe-e47ae82474e4	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 18:31:10.952253+00	
00000000-0000-0000-0000-000000000000	ef3eee81-b622-45c3-a958-266d82d30626	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 18:31:10.955264+00	
00000000-0000-0000-0000-000000000000	cddb9187-fbfc-45f8-8d92-e011ebd9eb73	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 17:37:37.491088+00	
00000000-0000-0000-0000-000000000000	53be27d8-fa81-471f-9f47-c2e6c421bf9b	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 17:37:37.516288+00	
00000000-0000-0000-0000-000000000000	1ad67686-72a4-470a-81fa-b6f9a4f92675	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 17:56:20.420016+00	
00000000-0000-0000-0000-000000000000	b3471f9b-e4ef-4077-bb39-73ceb2951340	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 18:01:52.080012+00	
00000000-0000-0000-0000-000000000000	4585f9aa-4711-453c-ac99-b07aff08ea93	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 18:03:00.51072+00	
00000000-0000-0000-0000-000000000000	a60c8a69-f892-4a3a-8016-fe23157e1d5e	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 18:06:04.441597+00	
00000000-0000-0000-0000-000000000000	ab816337-69b7-4f5b-a36d-d417c9506469	{"action":"token_refreshed","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-26 18:08:55.76505+00	
00000000-0000-0000-0000-000000000000	e2a43a26-ebae-4df2-94b9-8209ff8cc8ed	{"action":"token_revoked","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-26 18:08:55.766039+00	
00000000-0000-0000-0000-000000000000	fde00944-8f67-450e-a41d-a846bce0ac3c	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-02-26 18:11:35.378224+00	
00000000-0000-0000-0000-000000000000	88ee7b86-0589-45e3-a6fc-829cb69bb455	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 18:26:06.141087+00	
00000000-0000-0000-0000-000000000000	550a4b33-39c2-4f3f-b9cb-457dad14c3ce	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 18:27:26.770921+00	
00000000-0000-0000-0000-000000000000	e38d1b7c-e85b-4b36-851c-c8ad3e17b3ab	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 18:29:40.874005+00	
00000000-0000-0000-0000-000000000000	90172ed6-6877-4a2f-8b80-a5d62f2a0393	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 13:14:21.630063+00	
00000000-0000-0000-0000-000000000000	cee80bd5-9a40-4dd3-b393-0d50b1538b1b	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 13:14:21.65712+00	
00000000-0000-0000-0000-000000000000	85c76be7-1b1b-48ac-9596-1bfd129f7087	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 13:14:31.859207+00	
00000000-0000-0000-0000-000000000000	9d5e4141-024f-43d1-a69b-0011b37b1e55	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-27 13:29:57.323185+00	
00000000-0000-0000-0000-000000000000	b7aea47d-cbd8-4f21-bb53-6bf5fa3cc6b5	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 13:30:21.199126+00	
00000000-0000-0000-0000-000000000000	85f6b73e-825c-4aab-851c-c28aa98acca9	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 13:22:41.768323+00	
00000000-0000-0000-0000-000000000000	3d5f96f1-ae8d-4fc6-b50d-34d5acacbfeb	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 14:22:03.74187+00	
00000000-0000-0000-0000-000000000000	ae028319-28d8-48e5-b472-65a8498ffb3f	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 14:22:35.71408+00	
00000000-0000-0000-0000-000000000000	e9e403f2-495f-4fc4-b28d-4ff7f4a35ebf	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 14:22:41.436177+00	
00000000-0000-0000-0000-000000000000	2fbcf067-4e42-4850-9e5a-3ed828604a50	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 14:23:53.822165+00	
00000000-0000-0000-0000-000000000000	03647077-e2c4-4633-bc36-d04e61e75d39	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-02-28 14:24:22.156735+00	
00000000-0000-0000-0000-000000000000	8d7284b4-d7ad-4289-8b48-7edb52acdc27	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 14:24:25.489692+00	
00000000-0000-0000-0000-000000000000	5aad4fd5-d65f-4f58-9fca-0c54315f0b44	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 14:49:29.074138+00	
00000000-0000-0000-0000-000000000000	06c4ae19-ad24-41d9-a33b-790a61fc6468	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 14:52:12.873031+00	
00000000-0000-0000-0000-000000000000	4a616f61-8579-4428-a7eb-a09ffda62a0d	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 14:52:30.310605+00	
00000000-0000-0000-0000-000000000000	67343318-a4bb-4a14-9913-90630d0d8a9c	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-02-28 14:53:13.296173+00	
00000000-0000-0000-0000-000000000000	4fafe092-379f-473b-bd3e-e8260a8f1884	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 15:02:38.661437+00	
00000000-0000-0000-0000-000000000000	b029d381-b3aa-4b76-96d5-cda449ab70b1	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 15:13:13.561404+00	
00000000-0000-0000-0000-000000000000	8addf735-b9f8-4874-9357-dd6ce9bd013b	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 15:24:06.745755+00	
00000000-0000-0000-0000-000000000000	0bc83b47-1a29-4925-b24c-43348684effc	{"action":"token_refreshed","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-28 16:35:50.288041+00	
00000000-0000-0000-0000-000000000000	9234bf9e-6944-4af3-be92-1475e4787f5f	{"action":"token_revoked","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"token"}	2025-02-28 16:35:50.299896+00	
00000000-0000-0000-0000-000000000000	7455835e-adf1-4ba4-a9b3-afcdbfbd7456	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:04.817642+00	
00000000-0000-0000-0000-000000000000	7bbaa383-1d00-4ae3-bba6-a318e2115098	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:06.753474+00	
00000000-0000-0000-0000-000000000000	544d7e5b-1d86-4c8d-817a-c201659e4a3a	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:11.715369+00	
00000000-0000-0000-0000-000000000000	8674a372-ca6f-46db-9371-004216533a01	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:11.911315+00	
00000000-0000-0000-0000-000000000000	3b635d40-67cf-4ac6-963a-e6ab6ded5f31	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:12.259177+00	
00000000-0000-0000-0000-000000000000	18ec6dec-140e-43fd-a9b9-e11eb2b1fecc	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:12.416955+00	
00000000-0000-0000-0000-000000000000	007e6d91-5624-4967-9578-3a5207a5759a	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:12.65698+00	
00000000-0000-0000-0000-000000000000	28f2d2db-173f-4085-b28d-109244e17d75	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:28.943899+00	
00000000-0000-0000-0000-000000000000	66e1cf09-d4dd-489e-878e-b43485568f54	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-02-28 16:36:42.870743+00	
00000000-0000-0000-0000-000000000000	1e1c36e9-c64e-4331-a2aa-abd856e88a30	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:45.70312+00	
00000000-0000-0000-0000-000000000000	611ec7f1-46e8-4c0c-b482-dd87d48adfbf	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 16:36:45.81887+00	
00000000-0000-0000-0000-000000000000	6e496023-d3b8-46fd-90f9-ca58faed65ba	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 17:38:39.885054+00	
00000000-0000-0000-0000-000000000000	33118111-4713-4298-bc43-4fb3e78011a7	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 17:38:39.887706+00	
00000000-0000-0000-0000-000000000000	5634495e-8d5b-4e38-835d-563205564256	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 18:42:48.764798+00	
00000000-0000-0000-0000-000000000000	31be8dfa-5dec-4075-935a-edcdf0628d75	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 18:42:48.769016+00	
00000000-0000-0000-0000-000000000000	0ce46981-1b55-4776-821c-d3bf4bca9792	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-01 14:53:11.919749+00	
00000000-0000-0000-0000-000000000000	585b6051-4d25-4053-b7ef-fdb134cfd593	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-01 14:53:11.93424+00	
00000000-0000-0000-0000-000000000000	f9674ddf-e898-4380-bad6-3cae2d979464	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-01 18:47:55.274219+00	
00000000-0000-0000-0000-000000000000	3053debc-3727-499e-b91b-5a71cef12474	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-01 18:47:55.278781+00	
00000000-0000-0000-0000-000000000000	aeebf76e-673a-45eb-a21b-9b57a6c8eeee	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-03 15:59:51.855871+00	
00000000-0000-0000-0000-000000000000	518c504d-c316-474f-9688-e795fc901480	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-03 15:59:51.871721+00	
00000000-0000-0000-0000-000000000000	bec98a61-c14a-4f9c-b997-64f3ac3c9576	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-03 15:59:58.707991+00	
00000000-0000-0000-0000-000000000000	04f7c340-2e91-4d70-bf88-ec43f5b4e78a	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-03 16:01:23.408371+00	
00000000-0000-0000-0000-000000000000	19b8d39d-734d-4250-a9aa-0bebe8c21880	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-03-03 16:01:42.329385+00	
00000000-0000-0000-0000-000000000000	0019346a-9729-44f4-8aee-d5b4ed33ec3c	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-03 16:01:47.514396+00	
00000000-0000-0000-0000-000000000000	38332ef1-7ab7-44f2-8da8-cfe888325b62	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 13:51:53.154345+00	
00000000-0000-0000-0000-000000000000	f3982c9c-dc44-4837-b439-fa51ab4deb51	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-04 14:16:44.472745+00	
00000000-0000-0000-0000-000000000000	e53d3bce-eb41-4270-9877-fdf18e6e700f	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 14:16:54.370076+00	
00000000-0000-0000-0000-000000000000	8bd4a8e6-bc7d-499a-9b1e-f9e175eae80e	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-03-04 14:17:20.561283+00	
00000000-0000-0000-0000-000000000000	771e42b3-d91e-495d-8593-6da2fc98c3bd	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 14:17:25.876831+00	
00000000-0000-0000-0000-000000000000	3707e913-9a85-40a4-b866-0c5bf43961c6	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-04 14:43:58.922472+00	
00000000-0000-0000-0000-000000000000	4fc4ffaf-37e6-4b50-bf7f-a6abd7b93e9d	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 14:44:10.504736+00	
00000000-0000-0000-0000-000000000000	ee08996e-7013-41d9-af69-99e7b7bc01ab	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 15:24:51.831538+00	
00000000-0000-0000-0000-000000000000	1b66fdfe-97b7-4c33-a4c3-a045f9332606	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 15:24:54.476097+00	
00000000-0000-0000-0000-000000000000	697d06bc-6da3-4bcc-9747-e1709ab628ef	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 15:25:00.344017+00	
00000000-0000-0000-0000-000000000000	fcbc5f70-f08d-4994-b93f-3d5a131d2ce0	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 15:27:50.523691+00	
00000000-0000-0000-0000-000000000000	43831076-341d-4125-bbe7-75e5904bd808	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-04 15:27:57.647604+00	
00000000-0000-0000-0000-000000000000	d52bfebc-028a-4a15-8884-2d7fdf67204a	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-07 14:39:56.689436+00	
00000000-0000-0000-0000-000000000000	5050d178-5631-4a4c-a692-2a1519d2193c	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-07 15:58:09.914685+00	
00000000-0000-0000-0000-000000000000	2368592a-e800-4111-ae7b-5b215b2fb271	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-07 16:04:20.569154+00	
00000000-0000-0000-0000-000000000000	7b90b3f5-b5cb-4053-bd27-81fb0f8ab1f1	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-07 16:04:20.571419+00	
00000000-0000-0000-0000-000000000000	de1a20a6-85b6-4fb3-8514-57f164761b40	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-07 16:14:30.45994+00	
00000000-0000-0000-0000-000000000000	cd3fcc5d-ac7f-499a-9d7c-88b976c777a6	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 13:12:58.319+00	
00000000-0000-0000-0000-000000000000	6e06d5af-d6b4-4083-b6c1-7ced16932bea	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 13:12:58.336398+00	
00000000-0000-0000-0000-000000000000	47803665-056f-4f88-8c24-6d6f4643308f	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 13:45:49.005425+00	
00000000-0000-0000-0000-000000000000	8e0d1d83-439a-484b-8f85-6eef59f9be67	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 13:45:49.008507+00	
00000000-0000-0000-0000-000000000000	78bba106-ce9f-4fc6-9dfe-b144200f2d94	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 14:17:13.979293+00	
00000000-0000-0000-0000-000000000000	fa963ff5-c73c-46ca-b704-9e1b1b12b360	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 14:17:13.981638+00	
00000000-0000-0000-0000-000000000000	7cad6ce9-d712-4c33-82d4-243fb550906f	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 15:25:58.600847+00	
00000000-0000-0000-0000-000000000000	c11406a3-4332-4ef8-bb5d-340750e7956e	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 15:25:58.606092+00	
00000000-0000-0000-0000-000000000000	71508b8d-cab7-45fb-a98f-a9f6f00f77c5	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 16:38:43.584557+00	
00000000-0000-0000-0000-000000000000	6f04a471-f61a-42e5-b9ac-e21dfbc38ecd	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-11 16:38:43.587579+00	
00000000-0000-0000-0000-000000000000	654d313d-9333-4362-aa4b-0c88b87b2a45	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-13 17:56:32.76517+00	
00000000-0000-0000-0000-000000000000	77ea31f6-f590-4606-98b3-09cd3cfa8d38	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 09:35:43.701739+00	
00000000-0000-0000-0000-000000000000	8d23b632-9906-4f53-98b4-6d15834876ba	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 09:35:43.71882+00	
00000000-0000-0000-0000-000000000000	374f0eaa-fb7c-4911-8675-8dd49d78fe06	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-14 10:02:25.958455+00	
00000000-0000-0000-0000-000000000000	e554b5f4-ca26-4da6-bd2e-410326d6c5d5	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 11:00:56.183372+00	
00000000-0000-0000-0000-000000000000	8479bc47-8fce-4564-a4f5-06da90e797f1	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 11:00:56.188186+00	
00000000-0000-0000-0000-000000000000	c2ee23a9-4666-4273-a349-f1ab5bb01ee3	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 12:03:08.352503+00	
00000000-0000-0000-0000-000000000000	8256234c-24ec-4408-a627-88ab970f71b3	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 12:03:08.356413+00	
00000000-0000-0000-0000-000000000000	39d43f91-fcf0-48a5-93bb-e62d37b07957	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 13:03:34.81549+00	
00000000-0000-0000-0000-000000000000	34127c5f-dbec-4e7e-bba6-45a51e257234	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 13:03:34.819999+00	
00000000-0000-0000-0000-000000000000	b3196893-1b44-4369-ac47-5574f85a6d90	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-14 13:48:16.563112+00	
00000000-0000-0000-0000-000000000000	76fd7c2d-fb4c-406e-a5df-9d4b924272c1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-14 13:48:31.315822+00	
00000000-0000-0000-0000-000000000000	331f1853-ee69-4aac-a458-f3ada8d6c396	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 14:04:04.637952+00	
00000000-0000-0000-0000-000000000000	933a1f17-f56a-44f0-915e-50b7dad8ca93	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 14:04:04.642272+00	
00000000-0000-0000-0000-000000000000	66703520-d974-4dc8-8f61-fdded519b7f8	{"action":"user_recovery_requested","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-03-14 15:40:20.3885+00	
00000000-0000-0000-0000-000000000000	df064775-c7c5-467b-ac2d-96916ae3f019	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-14 15:41:29.947959+00	
00000000-0000-0000-0000-000000000000	b03e81f8-1bff-4339-9053-5edbc9c51e6c	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 15:45:00.505281+00	
00000000-0000-0000-0000-000000000000	6a18ef96-303f-4e30-9582-bd05bfb2f5d3	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-14 15:45:00.512351+00	
00000000-0000-0000-0000-000000000000	a743c911-5540-4018-ba2f-20c2318e7b5c	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-14 15:45:07.187794+00	
00000000-0000-0000-0000-000000000000	d830fadc-e7c2-4043-ace5-5c9702c427b1	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-14 15:45:23.017018+00	
00000000-0000-0000-0000-000000000000	a740a0cc-6591-4327-b70f-2d9eea49076e	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-14 15:53:00.579601+00	
00000000-0000-0000-0000-000000000000	11d0746b-805c-4fb4-91ba-e3e9ff4cc59d	{"action":"user_recovery_requested","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-03-14 15:53:09.516128+00	
00000000-0000-0000-0000-000000000000	389ec46b-841f-424e-aacd-683c7d9d8f10	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-14 15:54:00.745891+00	
00000000-0000-0000-0000-000000000000	d50cf570-cd59-4652-b985-50a94d9a2454	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-14 15:55:01.773+00	
00000000-0000-0000-0000-000000000000	e53f6c94-72a9-4ac6-b382-98a5b68fc6de	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-14 16:17:02.076292+00	
00000000-0000-0000-0000-000000000000	614cfd7b-692a-4368-b9e1-7915407c1762	{"action":"token_refreshed","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-15 10:19:37.461978+00	
00000000-0000-0000-0000-000000000000	df6532be-b8aa-4a14-b456-f7cdf97af8da	{"action":"token_revoked","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-15 10:19:37.482485+00	
00000000-0000-0000-0000-000000000000	e4bed079-7337-4631-9169-d532e061ca70	{"action":"logout","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-15 10:43:23.410266+00	
00000000-0000-0000-0000-000000000000	f02cc9dd-2c35-4ead-bbfc-cb92a5492ddf	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 10:43:35.03435+00	
00000000-0000-0000-0000-000000000000	3de682df-5a01-4055-9b6a-0971c9d72e8c	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-15 12:48:38.774226+00	
00000000-0000-0000-0000-000000000000	ef70f92d-8eab-45c6-8d31-db12a139497f	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-15 12:48:38.783354+00	
00000000-0000-0000-0000-000000000000	0f31b665-b363-4319-af49-b1e4800eec6c	{"action":"login","actor_id":"4b0ae45e-4416-46f2-b122-2d4185db4ee0","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-15 12:48:38.868873+00	
00000000-0000-0000-0000-000000000000	46b29ab8-94e2-430c-b958-3ee6f65b553f	{"action":"user_signedup","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-15 13:18:06.954254+00	
00000000-0000-0000-0000-000000000000	fc409dbf-e2b1-4eb1-896e-f152f180b961	{"action":"logout","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-15 13:19:54.850238+00	
00000000-0000-0000-0000-000000000000	9c096469-7d56-4842-b30b-318fd1bc7fa1	{"action":"login","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 13:21:00.308248+00	
00000000-0000-0000-0000-000000000000	e14133e6-a889-426b-9fca-bad54928d410	{"action":"logout","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-15 13:21:12.093054+00	
00000000-0000-0000-0000-000000000000	bd3331ec-3dc2-4d53-93ad-b59811a11636	{"action":"login","actor_id":"0f72ae4e-ae49-4145-9609-bc3fe316d9be","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 13:21:41.895628+00	
00000000-0000-0000-0000-000000000000	99e8ba5b-fec4-4275-a4d9-143128ec227c	{"action":"user_signedup","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-15 13:45:15.58766+00	
00000000-0000-0000-0000-000000000000	c186668a-08aa-4628-9b36-8b75efeaf748	{"action":"login","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 13:47:32.949764+00	
00000000-0000-0000-0000-000000000000	80bbf9eb-cb67-45b2-bb83-865b293dc4d0	{"action":"logout","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-15 13:55:20.886686+00	
00000000-0000-0000-0000-000000000000	7fb99394-e732-442a-b2b5-467f94a24533	{"action":"login","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 13:55:32.640403+00	
00000000-0000-0000-0000-000000000000	6a6485a9-77f8-4cdd-9b14-726c4e4a6487	{"action":"login","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 13:58:58.48097+00	
00000000-0000-0000-0000-000000000000	7e9f5f2b-8892-4192-af4a-a20e2a8f3937	{"action":"user_signedup","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-15 14:01:46.320569+00	
00000000-0000-0000-0000-000000000000	d1b5107a-05b3-456c-aa6a-5ef41eb1d0e3	{"action":"logout","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-15 14:02:07.813205+00	
00000000-0000-0000-0000-000000000000	db1c7e85-8e2a-4e6a-abc3-9a8d0e9a5e15	{"action":"login","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 14:02:15.858856+00	
00000000-0000-0000-0000-000000000000	34e358f6-8ba7-43c7-a0bb-f130b0186a5d	{"action":"login","actor_id":"7011dde8-bc9d-4033-aae6-a62c6d927696","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 14:05:33.905044+00	
00000000-0000-0000-0000-000000000000	c9ab8a30-624d-48c1-b3ac-544bd87783a9	{"action":"user_signedup","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-15 14:06:19.814602+00	
00000000-0000-0000-0000-000000000000	18a7f5d9-a029-459f-b27c-f346f6660501	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-15 16:12:35.582252+00	
00000000-0000-0000-0000-000000000000	ffa95db7-1ca2-4b9a-890b-1e9169cd6a25	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-15 23:22:46.253594+00	
00000000-0000-0000-0000-000000000000	0ae1dcd7-af8b-4cd3-9148-63344c813881	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-15 23:22:46.26309+00	
00000000-0000-0000-0000-000000000000	a64d5194-85b9-4188-b0a4-436a807c3202	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-16 22:11:33.598484+00	
00000000-0000-0000-0000-000000000000	e28fc43a-23c3-47ac-8db4-a3ebe9d18507	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-16 22:11:33.634565+00	
00000000-0000-0000-0000-000000000000	57f2821a-7e57-4277-aa97-dab3869f6b45	{"action":"token_refreshed","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-17 10:44:34.750414+00	
00000000-0000-0000-0000-000000000000	74504e59-f4a4-41c2-8af1-88d7ae177d00	{"action":"token_revoked","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-17 10:44:34.773105+00	
00000000-0000-0000-0000-000000000000	bb23f52d-989b-491e-b853-eaec5c7f92a9	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-17 11:32:26.47721+00	
00000000-0000-0000-0000-000000000000	2a29c446-d7e9-4d6d-9b21-0ca49f2a9ce8	{"action":"logout","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-17 11:32:54.227037+00	
00000000-0000-0000-0000-000000000000	3d647539-2450-4378-999f-5c7391d10545	{"action":"login","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-17 11:33:01.294567+00	
00000000-0000-0000-0000-000000000000	fcb5232e-fa2e-48a0-915d-26ad14e7445a	{"action":"logout","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-17 11:33:40.797272+00	
00000000-0000-0000-0000-000000000000	980ac9de-fe78-4e88-9fa6-5bfbdc947f5e	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-17 11:39:30.54473+00	
00000000-0000-0000-0000-000000000000	148a1d7d-c823-4d52-87c5-0c8eb7765990	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-17 11:48:43.03021+00	
00000000-0000-0000-0000-000000000000	20b0997a-87d9-40ca-ae8e-a1621a8f2032	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-17 15:34:42.06329+00	
00000000-0000-0000-0000-000000000000	806db3b8-edb8-4816-94c3-ea707afcc22c	{"action":"token_refreshed","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-17 16:35:11.355804+00	
00000000-0000-0000-0000-000000000000	c82bea0e-5690-4fe0-b452-e807512f3775	{"action":"token_revoked","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-17 16:35:11.377669+00	
00000000-0000-0000-0000-000000000000	7506d243-881e-45ae-a97c-abd2bc704f2b	{"action":"token_refreshed","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-18 10:05:47.90148+00	
00000000-0000-0000-0000-000000000000	8aaaa1f5-01d9-4f06-b170-d22fed1a3caf	{"action":"token_revoked","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-18 10:05:47.925536+00	
00000000-0000-0000-0000-000000000000	49115bd2-2adb-45ea-a330-02367f2ae48c	{"action":"logout","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-18 10:09:27.622161+00	
00000000-0000-0000-0000-000000000000	1c472fb9-40c3-4e9d-9a9e-8e0959314183	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-18 10:15:04.815465+00	
00000000-0000-0000-0000-000000000000	a35baaae-0972-421c-aff7-78efcb63e5be	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-18 10:29:44.019899+00	
00000000-0000-0000-0000-000000000000	617da12a-e0e7-4770-9507-2765b2e54954	{"action":"logout","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-18 11:08:20.686655+00	
00000000-0000-0000-0000-000000000000	34a6b461-c7bd-4405-af88-3adea072009e	{"action":"login","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-18 11:08:28.45257+00	
00000000-0000-0000-0000-000000000000	2378770b-052e-4513-b96b-e2d3c1e25bab	{"action":"logout","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-18 11:09:18.27781+00	
00000000-0000-0000-0000-000000000000	25349de2-ba58-4ad7-ac27-71faeea13270	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-18 11:09:34.6799+00	
00000000-0000-0000-0000-000000000000	0fd93b2c-9150-4c51-9c77-cf1222126d1b	{"action":"login","actor_id":"a920f7d4-293e-4cbd-81d7-d4a2837e03ba","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 13:57:50.601469+00	
00000000-0000-0000-0000-000000000000	71001e04-66f1-4e35-8fc2-88a66ea93610	{"action":"user_signedup","actor_id":"a4772e5e-64c7-4a91-925b-dde76cff89fb","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-19 14:19:22.616183+00	
00000000-0000-0000-0000-000000000000	6fd05ed8-8f96-4339-94b2-fae54674723a	{"action":"user_signedup","actor_id":"9c4b00ad-7dce-4060-bc70-a643d28f74b8","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-19 14:21:34.927355+00	
00000000-0000-0000-0000-000000000000	f5ebd546-f0da-403b-9950-89bb49739055	{"action":"logout","actor_id":"9c4b00ad-7dce-4060-bc70-a643d28f74b8","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 14:21:42.264422+00	
00000000-0000-0000-0000-000000000000	ad6857d2-e095-492c-baf9-589ed9c9a1b9	{"action":"login","actor_id":"9c4b00ad-7dce-4060-bc70-a643d28f74b8","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 14:26:15.860814+00	
00000000-0000-0000-0000-000000000000	f98cedb6-304d-42b2-960d-a68ef2c0e353	{"action":"user_signedup","actor_id":"3530369c-9d0e-4769-8a67-7f8a0a6994ee","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-19 14:27:46.768298+00	
00000000-0000-0000-0000-000000000000	97b1f31a-8489-46a7-ba90-87def82476f4	{"action":"logout","actor_id":"3530369c-9d0e-4769-8a67-7f8a0a6994ee","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 14:28:52.922185+00	
00000000-0000-0000-0000-000000000000	3d3781f0-1893-45bb-9bcb-b1003e09931e	{"action":"login","actor_id":"3530369c-9d0e-4769-8a67-7f8a0a6994ee","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 14:29:00.276146+00	
00000000-0000-0000-0000-000000000000	cb5aae14-2949-4437-b9f7-1bd25178cbce	{"action":"user_signedup","actor_id":"1edd14a4-3673-480e-bd4e-4f0a2d609b0a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 14:30:13.393537+00	
00000000-0000-0000-0000-000000000000	4798354c-d16e-44c5-8613-2ce58318e578	{"action":"login","actor_id":"1edd14a4-3673-480e-bd4e-4f0a2d609b0a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 14:30:13.398275+00	
00000000-0000-0000-0000-000000000000	bde470c8-0b66-423d-b506-ea458f9d8946	{"action":"user_repeated_signup","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-03-19 14:31:42.746951+00	
00000000-0000-0000-0000-000000000000	9b6344e1-966c-4ba8-8024-ac3ace557f0a	{"action":"user_signedup","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 14:31:54.634633+00	
00000000-0000-0000-0000-000000000000	14528f0f-f6d1-40a5-bc9c-3fede8e2688b	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 14:31:54.639109+00	
00000000-0000-0000-0000-000000000000	2ebd04c1-7961-4945-b750-e927afe8acec	{"action":"user_signedup","actor_id":"8f8cb8d7-3934-4e15-9252-f19994b75d36","actor_username":"ahmed.benali@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 14:56:27.051478+00	
00000000-0000-0000-0000-000000000000	dc7f5ae2-b452-48b2-912e-61c318db9068	{"action":"login","actor_id":"8f8cb8d7-3934-4e15-9252-f19994b75d36","actor_username":"ahmed.benali@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 14:56:27.060438+00	
00000000-0000-0000-0000-000000000000	eb199d07-869c-4350-99e1-7f9cc772cd54	{"action":"logout","actor_id":"8f8cb8d7-3934-4e15-9252-f19994b75d36","actor_username":"ahmed.benali@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 14:56:35.369432+00	
00000000-0000-0000-0000-000000000000	39d6ab88-01b4-4efe-8075-b8806e36d9b8	{"action":"user_signedup","actor_id":"f8790052-a0ed-408b-a4cc-aa3cdc30bf38","actor_username":"fatima.zohra@yahoo.fr","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 14:57:29.771319+00	
00000000-0000-0000-0000-000000000000	ecae607a-8890-4474-8167-9bc5915fd673	{"action":"login","actor_id":"f8790052-a0ed-408b-a4cc-aa3cdc30bf38","actor_username":"fatima.zohra@yahoo.fr","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 14:57:29.77484+00	
00000000-0000-0000-0000-000000000000	7542ad40-a716-46fa-b734-8233164d5ae0	{"action":"logout","actor_id":"f8790052-a0ed-408b-a4cc-aa3cdc30bf38","actor_username":"fatima.zohra@yahoo.fr","actor_via_sso":false,"log_type":"account"}	2025-03-19 14:57:45.522946+00	
00000000-0000-0000-0000-000000000000	461a36c9-daad-423e-bc3e-fb8e8ade4b29	{"action":"user_signedup","actor_id":"e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b","actor_username":"karim.djelloul@outlook.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 14:58:54.560444+00	
00000000-0000-0000-0000-000000000000	0ae9fd42-94bb-44f2-b7c6-27a99362c3e4	{"action":"login","actor_id":"e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b","actor_username":"karim.djelloul@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 14:58:54.566093+00	
00000000-0000-0000-0000-000000000000	d4bc3b68-fc34-425e-b8c0-9de2badd3d44	{"action":"logout","actor_id":"e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b","actor_username":"karim.djelloul@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 14:59:13.141436+00	
00000000-0000-0000-0000-000000000000	ca0f9f1f-a377-476d-8cf1-b29ef104fcfa	{"action":"user_signedup","actor_id":"c0df7f47-b0d9-4ad1-b755-7ce091f89b61","actor_username":"lina.saidi@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 15:00:00.053897+00	
00000000-0000-0000-0000-000000000000	c545fd81-158d-449b-8681-44b029b9aa51	{"action":"login","actor_id":"c0df7f47-b0d9-4ad1-b755-7ce091f89b61","actor_username":"lina.saidi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 15:00:00.076198+00	
00000000-0000-0000-0000-000000000000	cfd6a96c-8bcf-492b-9625-de59031c22f8	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-19 17:12:09.29639+00	
00000000-0000-0000-0000-000000000000	7937a379-4abf-4e35-bfe2-88e322f75ae8	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-19 17:12:09.300404+00	
00000000-0000-0000-0000-000000000000	679a877e-f0fe-4935-99c6-e8a5f7ce3544	{"action":"token_refreshed","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-19 17:41:36.029091+00	
00000000-0000-0000-0000-000000000000	7b824d1c-c1b6-4c47-936b-c64fdd905392	{"action":"token_revoked","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-19 17:41:36.033998+00	
00000000-0000-0000-0000-000000000000	31504e62-0441-43cd-a933-e19945d6581f	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 17:41:45.672481+00	
00000000-0000-0000-0000-000000000000	7a78c925-77bd-4720-8133-93737c307bf0	{"action":"logout","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 17:48:01.572612+00	
00000000-0000-0000-0000-000000000000	9f729341-7317-4266-b1d1-c599ebb97f19	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 17:48:12.669202+00	
00000000-0000-0000-0000-000000000000	8cf3d57a-80ae-429a-ae06-d0362076a1ce	{"action":"logout","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 17:50:36.626039+00	
00000000-0000-0000-0000-000000000000	a8d84f5f-6557-4362-85d5-00b6dddd54de	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 17:50:45.163032+00	
00000000-0000-0000-0000-000000000000	25d6eda7-de0d-403f-b8b9-c36c3db1119f	{"action":"logout","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 18:01:32.758699+00	
00000000-0000-0000-0000-000000000000	246ca355-3741-4220-bda3-4f555eb9688f	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-19 18:01:42.372987+00	
00000000-0000-0000-0000-000000000000	c06a7be1-d3b5-4bb6-9f87-98d4c7e140b4	{"action":"logout","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-19 18:01:49.909325+00	
00000000-0000-0000-0000-000000000000	9f18c8ca-4160-4f92-9e9c-e4c4f2011114	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 18:01:59.516668+00	
00000000-0000-0000-0000-000000000000	3b7ade77-572b-4ebe-8e20-9b0012b5e43f	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-20 13:16:21.698798+00	
00000000-0000-0000-0000-000000000000	fbfe7742-5012-4056-96cd-d803caf811ef	{"action":"logout","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-20 14:04:00.869909+00	
00000000-0000-0000-0000-000000000000	6c26f1e1-8977-456d-9926-50a811854971	{"action":"login","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-20 14:04:12.48592+00	
00000000-0000-0000-0000-000000000000	3813fd02-2c81-4e2d-a9e9-ae8a3719e92a	{"action":"login","actor_id":"59d12ed6-83fd-45c9-aedb-6718a252e59a","actor_name":"ibrahim yebdri","actor_username":"ib.yebdri58@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-20 14:13:11.822413+00	
00000000-0000-0000-0000-000000000000	305c5f4b-ab2b-418a-a22b-55c2c395f7c6	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-23 16:27:48.981974+00	
00000000-0000-0000-0000-000000000000	4aa0e03b-41d4-472e-bbf0-feb2d526b35c	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-23 16:27:49.017456+00	
00000000-0000-0000-0000-000000000000	1d2936d2-7a5d-4b6d-89ed-249031a87784	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-23 16:28:18.948889+00	
00000000-0000-0000-0000-000000000000	3db1ad34-16cf-4a82-a6d9-ba9cc437034b	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-23 16:28:44.108012+00	
00000000-0000-0000-0000-000000000000	9fa0cc78-e8c6-470d-a151-bd19ddff7c10	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-03-23 16:29:01.921844+00	
00000000-0000-0000-0000-000000000000	922f2c14-574c-43c1-853b-17c2397dd366	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-23 16:29:54.276137+00	
00000000-0000-0000-0000-000000000000	168a285c-c3dc-4463-a456-ed078469aac1	{"action":"logout","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account"}	2025-03-23 16:33:08.410129+00	
00000000-0000-0000-0000-000000000000	bb2aa37d-2067-41b9-b613-fa8a6d29654a	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-23 16:34:57.542018+00	
00000000-0000-0000-0000-000000000000	c134e169-f6bd-4301-9284-34057e39bf6d	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-03-23 16:43:17.992148+00	
00000000-0000-0000-0000-000000000000	4db42824-9ad0-414b-aa0b-f827b737c742	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-23 16:43:24.619039+00	
00000000-0000-0000-0000-000000000000	9722bf37-9d85-4256-9f8e-4647217a7343	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-23 16:43:24.693886+00	
00000000-0000-0000-0000-000000000000	e7851a07-354e-4b3f-96e2-56c3524fc63e	{"action":"token_refreshed","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 01:21:00.431618+00	
00000000-0000-0000-0000-000000000000	9ebb5ea6-9712-4e6e-94c3-039426ff3c9c	{"action":"token_revoked","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 01:21:00.459682+00	
00000000-0000-0000-0000-000000000000	428856a4-db5f-424e-87d6-667aa2052776	{"action":"token_refreshed","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 14:33:04.321035+00	
00000000-0000-0000-0000-000000000000	cdeea22f-0353-4a1e-bcc7-f6bd1587db90	{"action":"token_revoked","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 14:33:04.336783+00	
00000000-0000-0000-0000-000000000000	895964a4-c84a-405a-af8b-d6607bddc346	{"action":"logout","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account"}	2025-03-25 14:33:09.371146+00	
00000000-0000-0000-0000-000000000000	ddfc5ad9-7efb-412c-9592-bd3cf57f051e	{"action":"login","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-25 14:33:37.830931+00	
00000000-0000-0000-0000-000000000000	a4910f68-e660-4911-902e-398489d25787	{"action":"logout","actor_id":"d314c7cc-ea9d-440e-8d46-1fe4e27938d0","actor_username":"c83360e86a50@drmail.in","actor_via_sso":false,"log_type":"account"}	2025-03-25 15:15:13.195955+00	
00000000-0000-0000-0000-000000000000	5f2a222f-12fc-43fd-9161-541383fe7243	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-25 15:15:17.658312+00	
00000000-0000-0000-0000-000000000000	063e7c86-d7c7-4fdd-a856-0122d3d9d832	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 16:54:29.52369+00	
00000000-0000-0000-0000-000000000000	cc10dd50-8402-46e6-afaf-830146973625	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-25 16:54:29.532413+00	
00000000-0000-0000-0000-000000000000	0160df14-62d3-48e0-9e42-7feb6edcf1ad	{"action":"logout","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-03-25 16:54:40.763541+00	
00000000-0000-0000-0000-000000000000	59958131-3cc4-4560-88bc-5e1507f1f9db	{"action":"login","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-25 16:55:24.113397+00	
00000000-0000-0000-0000-000000000000	49f8a508-7d58-4602-b0c5-8b545cc4559f	{"action":"logout","actor_id":"c95a2106-3226-403a-9d43-5af9e29e5ca1","actor_username":"nosawer579@btcours.com","actor_via_sso":false,"log_type":"account"}	2025-03-25 17:02:15.508535+00	
00000000-0000-0000-0000-000000000000	b56115e3-6779-49d0-8cd2-7ea7fe50c7b8	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-25 17:02:19.261741+00	
00000000-0000-0000-0000-000000000000	a5f44e5f-ef12-4ab0-97eb-9f6b5b103464	{"action":"token_refreshed","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 15:26:31.452149+00	
00000000-0000-0000-0000-000000000000	753b367b-eb83-4232-a0e8-c24bb902efc4	{"action":"token_revoked","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 15:26:31.467503+00	
00000000-0000-0000-0000-000000000000	f1ba3b11-6e8e-45c2-9e8e-d6c36d69da64	{"action":"token_refreshed","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 16:17:14.879697+00	
00000000-0000-0000-0000-000000000000	1372e7c7-fe94-46b1-bb61-9bff24bac7f4	{"action":"token_revoked","actor_id":"428f85b4-5082-4e96-aed6-6703beedf4e7","actor_name":"Ibrahim Yebdri","actor_username":"ib.yebdri@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 16:17:14.89574+00	
00000000-0000-0000-0000-000000000000	0a44e4a9-6f32-4617-aed5-61cdf0ba2218	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:37.008546+00	
00000000-0000-0000-0000-000000000000	6f7a7cd7-c354-4719-b30f-e748fdc1b415	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:42.967384+00	
00000000-0000-0000-0000-000000000000	a7e9d326-f028-48e5-971f-e2feb6e99237	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:49.766626+00	
00000000-0000-0000-0000-000000000000	a9bef1ee-2b48-44e0-80d7-34efaa18c03a	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:51.976288+00	
00000000-0000-0000-0000-000000000000	95fdf525-769e-4c94-9445-0794370424a3	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:52.181023+00	
00000000-0000-0000-0000-000000000000	dce37582-fdd1-4158-a3b0-f4cdbd4bd509	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:52.336611+00	
00000000-0000-0000-0000-000000000000	6a92de75-fc5d-4a8b-a557-d1a6735b9a31	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:52.676612+00	
00000000-0000-0000-0000-000000000000	28d92c37-7622-4d80-9073-53b32180cf38	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:52.776229+00	
00000000-0000-0000-0000-000000000000	1fca0ad4-8db3-44e1-9c16-53b390112a10	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:52.867347+00	
00000000-0000-0000-0000-000000000000	490bc050-e4b9-465e-bc57-f4d635e147ed	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:06:53.078428+00	
00000000-0000-0000-0000-000000000000	1f1cab8d-c24e-4673-a84c-466b76938055	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:07:03.7915+00	
00000000-0000-0000-0000-000000000000	19404d89-a597-4ea6-88d7-40834546cd49	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:07:04.813682+00	
00000000-0000-0000-0000-000000000000	9dbaf03d-28eb-40e9-87cd-451100d36493	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:07:05.022604+00	
00000000-0000-0000-0000-000000000000	670b4d7d-d7a9-4746-a5a3-8d3fd81cf942	{"action":"login","actor_id":"328840a0-6e8c-4444-bb05-a010511f37e7","actor_username":"deddoucheabdou33@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:07:05.498514+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
f175551d-70e1-45bd-a18e-4b76894795b4	f175551d-70e1-45bd-a18e-4b76894795b4	{"sub": "f175551d-70e1-45bd-a18e-4b76894795b4", "email": "hiweyec481@cashbn.com", "address": "LA", "last_name": "Ibrahim Yebdri", "birth_date": "2025-02-07", "first_name": "jfdnkhd", "nationality": "fr", "phone_number": "140", "email_verified": false, "phone_verified": false}	email	2025-02-14 10:31:25.603099+00	2025-02-14 10:31:25.603148+00	2025-02-14 10:31:25.603148+00	9615a20b-17cf-4eac-9da4-70ce8715641a
d314c7cc-ea9d-440e-8d46-1fe4e27938d0	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	{"sub": "d314c7cc-ea9d-440e-8d46-1fe4e27938d0", "role": "visitor", "email": "c83360e86a50@drmail.in", "address": "Alger", "last_name": "blah", "birth_date": "2025-02-25", "first_name": "blah", "nationality": "fr", "phone_number": "4556544", "email_verified": true, "phone_verified": false}	email	2025-02-25 10:50:25.513079+00	2025-02-25 10:50:25.513134+00	2025-02-25 10:50:25.513134+00	03f91f7e-ff51-499b-9c69-22ac6dbc2198
c95a2106-3226-403a-9d43-5af9e29e5ca1	c95a2106-3226-403a-9d43-5af9e29e5ca1	{"sub": "c95a2106-3226-403a-9d43-5af9e29e5ca1", "role": "visitor", "email": "nosawer579@btcours.com", "address": "Oran", "last_name": "user", "birth_date": "2025-02-13", "first_name": "sheraton", "nationality": "uk", "phone_number": "01", "email_verified": true, "phone_verified": false}	email	2025-02-17 11:08:48.499995+00	2025-02-17 11:08:48.50005+00	2025-02-17 11:08:48.50005+00	7b87ab0e-a91e-4eae-bbba-cb2415aafb34
328840a0-6e8c-4444-bb05-a010511f37e7	328840a0-6e8c-4444-bb05-a010511f37e7	{"sub": "328840a0-6e8c-4444-bb05-a010511f37e7", "role": "visitor", "email": "deddoucheabdou33@gmail.com", "address": "arzew", "last_name": "abderrahmene", "birth_date": "2004-07-13", "first_name": "deddouche", "nationality": "fr", "phone_number": "0794553778", "email_verified": true, "phone_verified": false}	email	2025-02-19 18:02:41.196347+00	2025-02-19 18:02:41.196427+00	2025-02-19 18:02:41.196427+00	1e5c9ca7-7d93-43ac-ba19-0dca1276006c
59d12ed6-83fd-45c9-aedb-6718a252e59a	59d12ed6-83fd-45c9-aedb-6718a252e59a	{"sub": "59d12ed6-83fd-45c9-aedb-6718a252e59a", "role": "visitor", "email": "ib.yebdri58@gmail.com", "address": "31000 Oran", "last_name": "Ibrahim ", "birth_date": "2025-04-03", "first_name": "Yebdri", "nationality": "uk", "phone_number": "0778653633", "email_verified": false, "phone_verified": false}	email	2025-03-19 14:31:54.63236+00	2025-03-19 14:31:54.632406+00	2025-03-19 14:31:54.632406+00	24881447-6c86-4dab-8520-bbf5955a4d01
8f8cb8d7-3934-4e15-9252-f19994b75d36	8f8cb8d7-3934-4e15-9252-f19994b75d36	{"sub": "8f8cb8d7-3934-4e15-9252-f19994b75d36", "role": "visitor", "email": "ahmed.benali@gmail.com", "address": "\\t123 Rue Didouche Mourad, Alger", "last_name": "Benali", "birth_date": "2025-03-19", "first_name": "Ahmed", "nationality": "", "phone_number": "0777777777", "email_verified": false, "phone_verified": false}	email	2025-03-19 14:56:27.04661+00	2025-03-19 14:56:27.046659+00	2025-03-19 14:56:27.046659+00	f71da169-c412-4991-866e-84eae53701dc
f8790052-a0ed-408b-a4cc-aa3cdc30bf38	f8790052-a0ed-408b-a4cc-aa3cdc30bf38	{"sub": "f8790052-a0ed-408b-a4cc-aa3cdc30bf38", "role": "visitor", "email": "fatima.zohra@yahoo.fr", "address": "45 Avenue Mohamed V, Oran", "last_name": "Zohra", "birth_date": "2025-03-19", "first_name": "Fatima", "nationality": "", "phone_number": "0555555555", "email_verified": false, "phone_verified": false}	email	2025-03-19 14:57:29.768435+00	2025-03-19 14:57:29.768482+00	2025-03-19 14:57:29.768482+00	cefbf84e-dfa3-4e5f-8a56-752dc8c422a7
104226710710688929647	59d12ed6-83fd-45c9-aedb-6718a252e59a	{"iss": "https://accounts.google.com", "sub": "104226710710688929647", "name": "ibrahim yebdri", "email": "ib.yebdri58@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKh1AsYOFzBlUcI2oIA2YlFlt0Ma_ZEUgXMdgQ4HIhkXtOlSw=s96-c", "full_name": "ibrahim yebdri", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKh1AsYOFzBlUcI2oIA2YlFlt0Ma_ZEUgXMdgQ4HIhkXtOlSw=s96-c", "provider_id": "104226710710688929647", "email_verified": true, "phone_verified": false}	google	2025-03-19 17:50:45.150808+00	2025-03-19 17:50:45.150869+00	2025-03-19 18:01:42.366777+00	aa90aaa1-3363-4912-be1a-7a03c3e8486d
e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b	e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b	{"sub": "e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b", "role": "visitor", "email": "karim.djelloul@outlook.com", "address": "12 Rue Fr├¿res Bouchakour, Constantine", "last_name": "Djelloul\\t", "birth_date": "2025-03-19", "first_name": "Karim", "nationality": "", "phone_number": "066666666", "email_verified": false, "phone_verified": false}	email	2025-03-19 14:58:54.557747+00	2025-03-19 14:58:54.557797+00	2025-03-19 14:58:54.557797+00	86d5524d-40bf-412d-b455-ae6c17a3c42b
c0df7f47-b0d9-4ad1-b755-7ce091f89b61	c0df7f47-b0d9-4ad1-b755-7ce091f89b61	{"sub": "c0df7f47-b0d9-4ad1-b755-7ce091f89b61", "role": "visitor", "email": "lina.saidi@gmail.com", "address": "8 Rue Larbi Ben Mhidi, Tizi Ouzou", "last_name": "Saidi", "birth_date": "", "first_name": "Lina", "nationality": "", "phone_number": "0555555", "email_verified": false, "phone_verified": false}	email	2025-03-19 15:00:00.046944+00	2025-03-19 15:00:00.047002+00	2025-03-19 15:00:00.047002+00	4a46b8a8-62a7-4ffc-b013-e317213eb412
101499043699996559652	428f85b4-5082-4e96-aed6-6703beedf4e7	{"iss": "https://accounts.google.com", "sub": "101499043699996559652", "name": "Ibrahim Yebdri", "email": "ib.yebdri@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJTQCFap8hqXS7iD--4WIhyrO6kxqpuSCkqperE_DGlSsaxJ48d_A=s96-c", "full_name": "Ibrahim Yebdri", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJTQCFap8hqXS7iD--4WIhyrO6kxqpuSCkqperE_DGlSsaxJ48d_A=s96-c", "provider_id": "101499043699996559652", "email_verified": true, "phone_verified": false}	google	2025-03-15 14:06:19.81056+00	2025-03-15 14:06:19.810614+00	2025-03-20 14:04:12.473181+00	d326ddc6-6b3f-456c-8527-99b81070bee9
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
869aeee5-61ae-44ba-99a1-5bd4b708db7a	2025-03-20 14:04:12.496236+00	2025-03-20 14:04:12.496236+00	oauth	77dd5360-a08b-4335-ad16-7a18096f38bf
040bdfec-aa17-4cc4-b031-77dfb8fd1e87	2025-03-20 14:13:11.834645+00	2025-03-20 14:13:11.834645+00	password	76bca874-c848-4df0-8558-04ad503d2556
831bcdf6-468c-4880-8e30-2fe4edc91ee1	2025-03-25 17:02:19.266871+00	2025-03-25 17:02:19.266871+00	password	ef8861d9-e95d-4bbd-a9e1-df5c35c0e00b
a6c4240b-b780-4a60-af55-d8848c3a8bc1	2025-03-26 17:06:37.039876+00	2025-03-26 17:06:37.039876+00	password	67770fe0-09e8-4c63-8245-97337ac13b9b
d2351e8c-0d93-4122-82c9-ea0d1a45fa98	2025-03-26 17:06:42.971+00	2025-03-26 17:06:42.971+00	password	0bf03f58-71de-403a-9353-5a9c38bfc1a8
33ed932d-7aae-48d2-a0b8-3202db1b804f	2025-03-26 17:06:49.778282+00	2025-03-26 17:06:49.778282+00	password	43841600-643e-4428-b248-87bb4c46a202
64de5f63-42bf-4352-a92b-2e3dead5b8f6	2025-03-26 17:06:51.979133+00	2025-03-26 17:06:51.979133+00	password	8bd0b2c5-d59f-4cf8-9a7e-1b67ca45cb88
b42c3220-172f-47a2-8c35-114ce1e5eab5	2025-03-26 17:06:52.186947+00	2025-03-26 17:06:52.186947+00	password	2d8940b4-1cb4-4e04-bea9-a1516637e37a
66d7d1f0-eb2a-466e-85f8-8ca2ce900e7b	2025-03-26 17:06:52.34047+00	2025-03-26 17:06:52.34047+00	password	3226d30a-e5f4-4a5f-aaf4-ec9ccd1970b0
21f233a6-40af-4842-967f-42b99d758a17	2025-03-26 17:06:52.680348+00	2025-03-26 17:06:52.680348+00	password	7bdc57d3-d77f-4ce5-8149-8aa987508a23
a606f106-1666-4862-8252-94c3c48a411e	2025-03-26 17:06:52.778777+00	2025-03-26 17:06:52.778777+00	password	1f6cc4d4-a67c-481c-8440-34e299eda07a
a5287900-e2b7-4c77-905d-c0a67a47141a	2025-03-26 17:06:52.871133+00	2025-03-26 17:06:52.871133+00	password	59d422de-54c2-454b-8adc-73e6fed7c583
58222b77-eaa7-40ce-8532-02f1c231bd7e	2025-03-26 17:06:53.080987+00	2025-03-26 17:06:53.080987+00	password	22f5f3b8-5779-4082-9e59-0a2bc648996c
21b410ca-7bff-4f5c-8f6f-bbe340151906	2025-03-26 17:07:03.793957+00	2025-03-26 17:07:03.793957+00	password	a92c9bd2-bc4d-4800-9b45-3d3da1d55d39
2b93d2bf-fc09-4c3d-9549-672fc61fd859	2025-03-26 17:07:04.81669+00	2025-03-26 17:07:04.81669+00	password	f0717638-8509-412e-b3ca-b8bd61e3fac7
9e688bf1-90a8-4ee9-b596-d2e28feb9d37	2025-03-26 17:07:05.025619+00	2025-03-26 17:07:05.025619+00	password	b5a630a7-aa44-47a8-b966-418cdef0d2e2
3252e492-6d31-4987-8136-46327ea5230d	2025-03-26 17:07:05.503327+00	2025-03-26 17:07:05.503327+00	password	b92dc0cc-cae9-4bf1-9c30-87cea018db14
4dd99eb4-2df3-4247-b8ea-3a1046864187	2025-03-19 15:00:00.141962+00	2025-03-19 15:00:00.141962+00	password	e183e875-5458-4b52-86ac-f376d36e7032
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
05c63329-23cf-4658-8c6f-64edc42a8407	f175551d-70e1-45bd-a18e-4b76894795b4	confirmation_token	a1ed5db317ccb76324a07a0902066be596152be539fd02e77585319f	hiweyec481@cashbn.com	2025-02-14 10:31:26.405963	2025-02-14 10:31:26.405963
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	249	z2_Qp9NY5Sivguv9P7vxsw	328840a0-6e8c-4444-bb05-a010511f37e7	t	2025-03-25 17:02:19.264675+00	2025-03-26 15:26:31.4682+00	\N	831bcdf6-468c-4880-8e30-2fe4edc91ee1
00000000-0000-0000-0000-000000000000	250	SmDwej0uJwPewwIaX-5HKQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 15:26:31.481116+00	2025-03-26 15:26:31.481116+00	z2_Qp9NY5Sivguv9P7vxsw	831bcdf6-468c-4880-8e30-2fe4edc91ee1
00000000-0000-0000-0000-000000000000	235	Um57Ir_Rn94nKB_WncFnUA	428f85b4-5082-4e96-aed6-6703beedf4e7	t	2025-03-20 14:04:12.491084+00	2025-03-26 16:17:14.897665+00	\N	869aeee5-61ae-44ba-99a1-5bd4b708db7a
00000000-0000-0000-0000-000000000000	251	Fbp42nbDJ2T24dxyZUDGXg	428f85b4-5082-4e96-aed6-6703beedf4e7	f	2025-03-26 16:17:14.903833+00	2025-03-26 16:17:14.903833+00	Um57Ir_Rn94nKB_WncFnUA	869aeee5-61ae-44ba-99a1-5bd4b708db7a
00000000-0000-0000-0000-000000000000	252	tKFwEJTif3MOc1Tcj2IoZw	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:37.030857+00	2025-03-26 17:06:37.030857+00	\N	a6c4240b-b780-4a60-af55-d8848c3a8bc1
00000000-0000-0000-0000-000000000000	253	4bHiXIYSaS275yK_tvvRAw	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:42.969737+00	2025-03-26 17:06:42.969737+00	\N	d2351e8c-0d93-4122-82c9-ea0d1a45fa98
00000000-0000-0000-0000-000000000000	254	yc0pn6BN96Wwmuv_YsrnaA	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:49.773346+00	2025-03-26 17:06:49.773346+00	\N	33ed932d-7aae-48d2-a0b8-3202db1b804f
00000000-0000-0000-0000-000000000000	255	-5m8qEVjef8xC20LGdJTpQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:51.977793+00	2025-03-26 17:06:51.977793+00	\N	64de5f63-42bf-4352-a92b-2e3dead5b8f6
00000000-0000-0000-0000-000000000000	256	RW0SUm2rvNrpnSNXPw9xuQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:52.182572+00	2025-03-26 17:06:52.182572+00	\N	b42c3220-172f-47a2-8c35-114ce1e5eab5
00000000-0000-0000-0000-000000000000	257	rCcsS2aXORwyaMPoYP2cfg	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:52.339152+00	2025-03-26 17:06:52.339152+00	\N	66d7d1f0-eb2a-466e-85f8-8ca2ce900e7b
00000000-0000-0000-0000-000000000000	258	DieB-IFVJZiDFeDSJ2fDqw	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:52.678632+00	2025-03-26 17:06:52.678632+00	\N	21f233a6-40af-4842-967f-42b99d758a17
00000000-0000-0000-0000-000000000000	259	n-L-weAg97N0UG9u7v4AuQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:52.777663+00	2025-03-26 17:06:52.777663+00	\N	a606f106-1666-4862-8252-94c3c48a411e
00000000-0000-0000-0000-000000000000	260	cBj_eUsUdXTugF04CtCfTw	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:52.869383+00	2025-03-26 17:06:52.869383+00	\N	a5287900-e2b7-4c77-905d-c0a67a47141a
00000000-0000-0000-0000-000000000000	261	XiSDLOD8gq1wtgomaXA_zA	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:06:53.079901+00	2025-03-26 17:06:53.079901+00	\N	58222b77-eaa7-40ce-8532-02f1c231bd7e
00000000-0000-0000-0000-000000000000	262	rVVZx2Y1uJDL05xDb0J9kg	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:07:03.792893+00	2025-03-26 17:07:03.792893+00	\N	21b410ca-7bff-4f5c-8f6f-bbe340151906
00000000-0000-0000-0000-000000000000	263	NNmdNCtd_nezupDoAYm3Sw	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:07:04.815137+00	2025-03-26 17:07:04.815137+00	\N	2b93d2bf-fc09-4c3d-9549-672fc61fd859
00000000-0000-0000-0000-000000000000	264	eqtAZGpWPnun8rMpFmpYWQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:07:05.024292+00	2025-03-26 17:07:05.024292+00	\N	9e688bf1-90a8-4ee9-b596-d2e28feb9d37
00000000-0000-0000-0000-000000000000	265	ogt9KLMYkeqUfq11O_RDjQ	328840a0-6e8c-4444-bb05-a010511f37e7	f	2025-03-26 17:07:05.500976+00	2025-03-26 17:07:05.500976+00	\N	3252e492-6d31-4987-8136-46327ea5230d
00000000-0000-0000-0000-000000000000	226	82PsLAngM8yuyWRfW8oS6g	c0df7f47-b0d9-4ad1-b755-7ce091f89b61	f	2025-03-19 15:00:00.099868+00	2025-03-19 15:00:00.099868+00	\N	4dd99eb4-2df3-4247-b8ea-3a1046864187
00000000-0000-0000-0000-000000000000	236	r_RqCyKY6FoyEF6Z1kbzbQ	59d12ed6-83fd-45c9-aedb-6718a252e59a	f	2025-03-20 14:13:11.830774+00	2025-03-20 14:13:11.830774+00	\N	040bdfec-aa17-4cc4-b031-77dfb8fd1e87
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
b42c3220-172f-47a2-8c35-114ce1e5eab5	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:52.181877+00	2025-03-26 17:06:52.181877+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
4dd99eb4-2df3-4247-b8ea-3a1046864187	c0df7f47-b0d9-4ad1-b755-7ce091f89b61	2025-03-19 15:00:00.08414+00	2025-03-19 15:00:00.08414+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0	41.97.20.61	\N
66d7d1f0-eb2a-466e-85f8-8ca2ce900e7b	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:52.338225+00	2025-03-26 17:06:52.338225+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
21f233a6-40af-4842-967f-42b99d758a17	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:52.678006+00	2025-03-26 17:06:52.678006+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
040bdfec-aa17-4cc4-b031-77dfb8fd1e87	59d12ed6-83fd-45c9-aedb-6718a252e59a	2025-03-20 14:13:11.829106+00	2025-03-20 14:13:11.829106+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.159.35	\N
a606f106-1666-4862-8252-94c3c48a411e	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:52.776963+00	2025-03-26 17:06:52.776963+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
a5287900-e2b7-4c77-905d-c0a67a47141a	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:52.868142+00	2025-03-26 17:06:52.868142+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
58222b77-eaa7-40ce-8532-02f1c231bd7e	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:53.079227+00	2025-03-26 17:06:53.079227+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
21b410ca-7bff-4f5c-8f6f-bbe340151906	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:07:03.792292+00	2025-03-26 17:07:03.792292+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
831bcdf6-468c-4880-8e30-2fe4edc91ee1	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-25 17:02:19.262487+00	2025-03-26 15:26:31.497827+00	\N	aal1	\N	2025-03-26 15:26:31.495861	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0	41.96.8.70	\N
869aeee5-61ae-44ba-99a1-5bd4b708db7a	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-20 14:04:12.487547+00	2025-03-26 16:17:14.908345+00	\N	aal1	\N	2025-03-26 16:17:14.908259	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	129.45.90.199	\N
a6c4240b-b780-4a60-af55-d8848c3a8bc1	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:37.018221+00	2025-03-26 17:06:37.018221+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
d2351e8c-0d93-4122-82c9-ea0d1a45fa98	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:42.969+00	2025-03-26 17:06:42.969+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
33ed932d-7aae-48d2-a0b8-3202db1b804f	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:49.769987+00	2025-03-26 17:06:49.769987+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
64de5f63-42bf-4352-a92b-2e3dead5b8f6	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:06:51.977044+00	2025-03-26 17:06:51.977044+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
2b93d2bf-fc09-4c3d-9549-672fc61fd859	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:07:04.814496+00	2025-03-26 17:07:04.814496+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
9e688bf1-90a8-4ee9-b596-d2e28feb9d37	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:07:05.023499+00	2025-03-26 17:07:05.023499+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
3252e492-6d31-4987-8136-46327ea5230d	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:07:05.499676+00	2025-03-26 17:07:05.499676+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	41.97.107.3	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	f175551d-70e1-45bd-a18e-4b76894795b4	authenticated	authenticated	hiweyec481@cashbn.com	$2a$10$WDu2lVg5Vdq7JI5AKS7DJuhWRHE3EiwXPwyfnY4BCsfDNaEh044C6	\N	\N	a1ed5db317ccb76324a07a0902066be596152be539fd02e77585319f	2025-02-14 10:31:25.606589+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "f175551d-70e1-45bd-a18e-4b76894795b4", "email": "hiweyec481@cashbn.com", "address": "LA", "last_name": "Ibrahim Yebdri", "birth_date": "2025-02-07", "first_name": "jfdnkhd", "nationality": "fr", "phone_number": "140", "email_verified": false, "phone_verified": false}	\N	2025-02-14 10:31:25.59804+00	2025-02-14 10:31:26.403996+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	328840a0-6e8c-4444-bb05-a010511f37e7	authenticated	authenticated	deddoucheabdou33@gmail.com	$2a$10$esLRCAaaU4ukocwSgkBXxOcSgfBZtW4aGo4Os4bTX47I4AVvXMzBG	2025-02-19 18:03:15.94546+00	\N		2025-02-19 18:02:41.213087+00		\N			\N	2025-03-26 17:07:05.499597+00	{"provider": "email", "providers": ["email"]}	{"sub": "328840a0-6e8c-4444-bb05-a010511f37e7", "role": "visitor", "email": "deddoucheabdou33@gmail.com", "address": "arzew", "last_name": "abderrahmene", "birth_date": "2004-07-13", "first_name": "deddouche", "nationality": "fr", "phone_number": "0794553778", "email_verified": true, "phone_verified": false}	\N	2025-02-19 18:02:41.169892+00	2025-03-26 17:07:05.502492+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	59d12ed6-83fd-45c9-aedb-6718a252e59a	authenticated	authenticated	ib.yebdri58@gmail.com	$2a$10$5i1VVRFoWRZQE8mWwp4BFeTLSNUDCeanhd.ZGEEwKdcavHvyklAv.	2025-03-19 14:31:54.635239+00	\N		\N		\N			\N	2025-03-20 14:13:11.829019+00	{"provider": "email", "providers": ["email", "google"]}	{"iss": "https://accounts.google.com", "sub": "104226710710688929647", "name": "ibrahim yebdri", "role": "visitor", "email": "ib.yebdri58@gmail.com", "address": "31000 Oran", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKh1AsYOFzBlUcI2oIA2YlFlt0Ma_ZEUgXMdgQ4HIhkXtOlSw=s96-c", "full_name": "ibrahim yebdri", "last_name": "Ibrahim ", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKh1AsYOFzBlUcI2oIA2YlFlt0Ma_ZEUgXMdgQ4HIhkXtOlSw=s96-c", "birth_date": "2025-04-03", "first_name": "Yebdri", "nationality": "uk", "provider_id": "104226710710688929647", "phone_number": "0778653633", "email_verified": true, "phone_verified": false}	\N	2025-03-19 14:31:54.629732+00	2025-03-20 14:13:11.833963+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c95a2106-3226-403a-9d43-5af9e29e5ca1	authenticated	authenticated	nosawer579@btcours.com	$2a$10$5ujMwQ6lgYzRo6IKe97jEeBPl5khKxIEhDADx1EDR9VMgc5KK5LfC	2025-02-17 11:09:03.279846+00	\N		2025-02-17 11:08:48.508489+00		\N			\N	2025-03-25 16:55:24.117414+00	{"provider": "email", "providers": ["email"]}	{"sub": "c95a2106-3226-403a-9d43-5af9e29e5ca1", "role": "visitor", "email": "nosawer579@btcours.com", "address": "Oran", "last_name": "user", "birth_date": "2025-02-13", "first_name": "sheraton", "nationality": "uk", "phone_number": "01", "email_verified": true, "phone_verified": false}	\N	2025-02-17 11:08:48.491212+00	2025-03-25 16:55:24.125118+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	428f85b4-5082-4e96-aed6-6703beedf4e7	authenticated	authenticated	ib.yebdri@gmail.com	\N	2025-03-15 14:06:19.815105+00	\N		\N		\N			\N	2025-03-20 14:04:12.487482+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "101499043699996559652", "name": "Ibrahim Yebdri", "email": "ib.yebdri@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJTQCFap8hqXS7iD--4WIhyrO6kxqpuSCkqperE_DGlSsaxJ48d_A=s96-c", "full_name": "Ibrahim Yebdri", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJTQCFap8hqXS7iD--4WIhyrO6kxqpuSCkqperE_DGlSsaxJ48d_A=s96-c", "provider_id": "101499043699996559652", "email_verified": true, "phone_verified": false}	\N	2025-03-15 14:06:19.807045+00	2025-03-26 16:17:14.905786+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f8790052-a0ed-408b-a4cc-aa3cdc30bf38	authenticated	authenticated	fatima.zohra@yahoo.fr	$2a$10$sGfxsnHyGGdxJotXektuyeCRdzYXA1gHXQ4kqTOWrH26xUnoSzu1e	2025-03-19 14:57:29.771882+00	\N		\N		\N			\N	2025-03-19 14:57:29.775445+00	{"provider": "email", "providers": ["email"]}	{"sub": "f8790052-a0ed-408b-a4cc-aa3cdc30bf38", "role": "visitor", "email": "fatima.zohra@yahoo.fr", "address": "45 Avenue Mohamed V, Oran", "last_name": "Zohra", "birth_date": "2025-03-19", "first_name": "Fatima", "nationality": "", "phone_number": "0555555555", "email_verified": true, "phone_verified": false}	\N	2025-03-19 14:57:29.76496+00	2025-03-19 14:57:29.777085+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8f8cb8d7-3934-4e15-9252-f19994b75d36	authenticated	authenticated	ahmed.benali@gmail.com	$2a$10$aEmAre5pP5zcV3CmQUwff.bP0mnfHHO1DTY35UAaoj6Bee183z1z2	2025-03-19 14:56:27.055032+00	\N		\N		\N			\N	2025-03-19 14:56:27.061117+00	{"provider": "email", "providers": ["email"]}	{"sub": "8f8cb8d7-3934-4e15-9252-f19994b75d36", "role": "visitor", "email": "ahmed.benali@gmail.com", "address": "\\t123 Rue Didouche Mourad, Alger", "last_name": "Benali", "birth_date": "2025-03-19", "first_name": "Ahmed", "nationality": "", "phone_number": "0777777777", "email_verified": true, "phone_verified": false}	\N	2025-03-19 14:56:27.037777+00	2025-03-19 14:56:27.0664+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c0df7f47-b0d9-4ad1-b755-7ce091f89b61	authenticated	authenticated	lina.saidi@gmail.com	$2a$10$V37gBhquEAA2bcWgf5.Oc.N3qMTwAOPZaF/HI7FMOA10vMcK8Lulm	2025-03-19 15:00:00.054467+00	\N		\N		\N			\N	2025-03-19 15:00:00.084043+00	{"provider": "email", "providers": ["email"]}	{"sub": "c0df7f47-b0d9-4ad1-b755-7ce091f89b61", "role": "visitor", "email": "lina.saidi@gmail.com", "address": "8 Rue Larbi Ben Mhidi, Tizi Ouzou", "last_name": "Saidi", "birth_date": "", "first_name": "Lina", "nationality": "", "phone_number": "0555555", "email_verified": true, "phone_verified": false}	\N	2025-03-19 15:00:00.031471+00	2025-03-19 15:00:00.132616+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b	authenticated	authenticated	karim.djelloul@outlook.com	$2a$10$m6bvCVNoVW3nBS4Q.UCUPegz0aBsuG.8SWQ5hpOP1NAS4nw6M0qmK	2025-03-19 14:58:54.561326+00	\N		\N		\N			\N	2025-03-19 14:58:54.566673+00	{"provider": "email", "providers": ["email"]}	{"sub": "e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b", "role": "visitor", "email": "karim.djelloul@outlook.com", "address": "12 Rue Fr├¿res Bouchakour, Constantine", "last_name": "Djelloul\\t", "birth_date": "2025-03-19", "first_name": "Karim", "nationality": "", "phone_number": "066666666", "email_verified": true, "phone_verified": false}	\N	2025-03-19 14:58:54.549861+00	2025-03-19 14:58:54.569282+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	authenticated	authenticated	c83360e86a50@drmail.in	$2a$10$jhuSPulFgBnUhouvnxFACO.ITnM/sey93rtbe07.zklcLzoSPq6gO	2025-02-25 10:50:44.717927+00	\N		2025-02-25 10:50:25.517838+00		\N			\N	2025-03-25 14:33:37.832118+00	{"provider": "email", "providers": ["email"]}	{"sub": "d314c7cc-ea9d-440e-8d46-1fe4e27938d0", "role": "visitor", "email": "c83360e86a50@drmail.in", "address": "Alger", "last_name": "blah", "birth_date": "2025-02-25", "first_name": "blah", "nationality": "fr", "phone_number": "4556544", "email_verified": true, "phone_verified": false}	\N	2025-02-25 10:50:25.502225+00	2025-03-25 14:33:37.844642+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: hotel_offers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel_offers (hotel_offer_id, hotel_id, name, description, price, room_type, number_of_rooms, wifi_included, breakfast_included, lunch_included, dinner_included, parking_included, pool_access, gym_access, spa_access, additional_notes, max_occupancy, is_refundable, discount_percentage, old_price, images, start_date, end_date, created_at, updated_at) FROM stdin;
a541bd82-8d12-41d1-9ad4-a59d74a341c6	d6f1e573-8a95-457b-af69-7990d1e00419	chambre	hhhh	800.00	luxe	5	t	t	f	t	f	f	f	f		1	f	0.00	0.00		2025-02-17	2025-02-27	2025-02-17 11:20:05.664624+00	2025-02-17 11:20:05.664624+00
\.


--
-- Data for Name: hotel_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel_services (hotel_service_id, hotel_id, name, description, price, service_type, duration_type, discount_percentage, old_price) FROM stdin;
\.


--
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotels (hotel_id, name, description, location, phone_number, email, history, star_rating, images, amenities, check_in_time, check_out_time, additional_notes, payment_methods, created_at, updated_at, wilaya, admin_id) FROM stdin;
35456c46-71f0-4ba1-b844-5cb0c220e61c	Sheraton	hotel bien pour les vacances	oran,algerie	\N	\N	\N	4	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/hotels-images//shearton.jpg	\N	\N	\N	\N	\N	2025-02-15 13:08:35.899392+00	2025-02-15 13:08:35.899392+00	Oran	\N
d6f1e573-8a95-457b-af69-7990d1e00419	sheraton	kk	hhh	252	hiweyec481@cashbn.com	kk	3	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/hotels-images/hotels/sheraton-1739791094941.png	kk	\N	\N	ll	ll	2025-02-17 11:18:21.933055+00	2025-02-17 11:18:21.933055+00	Adrar	c95a2106-3226-403a-9d43-5af9e29e5ca1
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (reservation_id, user_id, reservation_type, reservation_type_id, booking_date, number_of_people, special_request, payment_status, status, duration, created_at, updated_at) FROM stdin;
77136b1e-6112-47da-b1c1-2d198312cb48	428f85b4-5082-4e96-aed6-6703beedf4e7	hotel_offer	a541bd82-8d12-41d1-9ad4-a59d74a341c6	2025-03-20 14:10:44.87142+00	1		pending	pending	1	2025-03-20 14:10:44.87142+00	2025-03-20 14:10:44.87142+00
41963ade-5be8-4a1c-8aa2-f8ce73bf9796	428f85b4-5082-4e96-aed6-6703beedf4e7	hotel_offer	a541bd82-8d12-41d1-9ad4-a59d74a341c6	2025-03-20 14:12:22.310698+00	1		pending	pending	1	2025-03-20 14:12:22.310698+00	2025-03-20 14:12:22.310698+00
83d4c28b-d2c5-4ec8-b1ab-b81be33a8bc1	59d12ed6-83fd-45c9-aedb-6718a252e59a	hotel_offer	a541bd82-8d12-41d1-9ad4-a59d74a341c6	2025-03-20 14:13:24.189545+00	1		pending	pending	1	2025-03-20 14:13:24.189545+00	2025-03-20 14:13:24.189545+00
ae52db1e-ceb5-4519-8d36-67eed7ec355f	59d12ed6-83fd-45c9-aedb-6718a252e59a	tour_activity	bad421f2-ca8a-4a9b-929b-0db51d34a1da	2025-03-20 14:13:31.428+00	1		pending	pending	1	2025-03-20 14:13:43.321008+00	2025-03-20 14:13:43.321008+00
75f536e1-de8c-40db-940d-9cf679b37ff1	c95a2106-3226-403a-9d43-5af9e29e5ca1	hotel_offer	a541bd82-8d12-41d1-9ad4-a59d74a341c6	2025-03-23 16:44:18.863895+00	1	rien a dire	paid	confirmed	1	2025-03-23 16:44:18.863895+00	2025-03-23 16:44:18.863895+00
55c3fda5-650f-4c23-b346-377b25cee1cf	328840a0-6e8c-4444-bb05-a010511f37e7	tour_activity	bad421f2-ca8a-4a9b-929b-0db51d34a1da	2025-03-25 15:16:12.42+00	1		pending	canceled	1	2025-03-25 15:16:10.924335+00	2025-03-25 15:16:10.924335+00
3a068740-7573-4a5f-9afc-9491cf5a9e86	428f85b4-5082-4e96-aed6-6703beedf4e7	tour_activity	3fb7543e-9199-441e-80ad-74444b0b4eab	2025-03-20 14:12:40.775767+00	1		pending	confirmed	1	2025-03-20 14:12:40.775767+00	2025-03-20 14:12:40.775767+00
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restaurants (restaurant_id, name, description, location, phone_number, email, speciality, star_rating, created_at, images, cuisine_type, opening_hours, additional_notes, dress_code, payment_methods, menu, owner_id, status) FROM stdin;
4fd4b2e8-d1e2-413b-8dad-36128603b9f9	El Barrio	Restaurant 	Oran,  bir eldjir	+213778653	contact@barrio.com	Fast food 	4	2025-03-25 11:01:13.378+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/el-barrio/main.jpg	Fast food	Lundi : 08:00 - 22:00\nMardi : 08:00 - 22:00\nMercredi : 08:00 - 22:00\nJeudi : 08:00 - 22:00\nVendredi : Ferm├®\nSamedi : 08:00 - 22:00\nDimanche : 08:00 - 22:00		Formal	Carte bancaire, Esp├¿ces	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/el-barrio/menu.jpg	\N	approved
41b49668-179a-4715-a4eb-310143cad7dc	Les gazelles 2	Situ├® un peu ├á l'ext├®rieur d'Arzew, sur la route de Cap Carbon, ce restaurant au cadre cossu est un restaurant qui propose de bonnes sp├®cialit├®s de poissons et de fruits de mer. On vous recommande tout particuli├¿rement le gratin de fruits de mer, les crevettes, les calamars ou un poisson grill├® de la p├¬che du jour. Si vous y venez en journ├®e, vous pourrez appr├®cier la superbe vue sur la mer qui s'offre ├á vous depuis les baies vitr├®es du restaurant qui est juste au-dessus des rochers.Le service est impeccable avec des serveurs en tenue. C'est un peu plus cher que la moyenne des restaurants de poissons ├á Oran et sa r├®gion mais cela vaut la peine si on peut se le permettre.	Arzew,Oran	0795 07 63 65	\N		4	2025-02-16 16:47:24.214846+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/la%20gazelle/photo1jpg.jpg	Fruits de mer et poisson, M├®diterran├®enne, Europ├®enne	dimanche\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\nlundi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\nmardi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\nmercredi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\njeudi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\nvendredi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\nsamedi\t12:00ÔÇô14:30, 19:00ÔÇô22:30\r\n	\N	\N	\N	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/la%20gazelle/Capture.PNG	\N	approved
4523e667-5598-4b08-b6d1-8fcf24eadc2e	La Comete	\N	1, Rue de la Paix, Oran Alg├®rie	\N	\N	D├®jeuner, D├«ner	3.5	2025-02-16 18:29:20.956713+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos//la-comete.jpg	Fran├ºaise, Europ├®enne	\N	\N	\N	Ôé¼Ôé¼-Ôé¼Ôé¼Ôé¼	\N	\N	approved
54632be8-ba28-4a94-ab88-139a34f12ff0	bladi	rien  a dire	oran		\N	\N	3	2025-02-21 16:42:24.411365+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/4b0ae45e-4416-46f2-b122-2d4185db4ee0/bladi/main.jpg	moodern		\N	\N	\N	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/4b0ae45e-4416-46f2-b122-2d4185db4ee0/bladi/menu.jpg	4b0ae45e-4416-46f2-b122-2d4185db4ee0	approved
dd3ace5d-864c-4d55-a272-7e04a1ebcaed	nautile		Oran sadikia		\N	\N	3	2025-02-19 18:30:40.244397+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/nautile/main.jpg	earopean		\N	\N	\N	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/nautile/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	approved
ee3a2e3e-9177-4bb8-a8fb-c073964a3d0e	hichem cook	blah blah blah	Alger		\N	\N	3	2025-02-21 10:46:49.983947+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/hichem-cook/main.jpg	Algerien,traditionelle		\N	\N	\N	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/hichem-cook/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	approved
c50db034-c129-4239-ae03-93dd9049c061	hichem cook 2	blah blah	Alger		\N	\N	3	2025-02-25 13:46:21.436031+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/hichem-cook-2/main.jpg	Algerien,traditionelle		\N	\N	\N	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/hichem-cook-2/menu.jpg	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	approved
703ed2a6-7ac6-4922-a647-7722e1a00fd0	Le Petit Chalet	blah blah	Oran		sahmdigitalmarketing@gmail.com	Internationale, Halal	3	2025-02-25 15:52:53.333373+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/le-petit-chalet/main.jpg	Algerien,traditionelle	Dimanche\n12:30-22:30\nLundi\n12:30-22:30\nMardi\n12:30-22:30\nMercredi\n12:30-22:30\nJeudi\n12:30-22:30\nVendredi\n13:30-22:30\nSamedi\n12:30-22:30	D├®jeuner, D├«ner, Brunch		["Esp├¿ces"]	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/le-petit-chalet/menu.png	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	approved
91021631-7ccb-4c9f-80be-7050db69dede	test2	a	tlemcen	01	hiweyec481@cashbn.com	specialit	4	2025-03-15 12:42:22.226+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/test2/main.jpg	moodern	Lundi : 08:00 - 22:00\nMardi : 08:00 - 22:00\nMercredi : 08:00 - 22:00\nJeudi : 08:00 - 22:00\nVendredi : Ferm├®\nSamedi : 08:00 - 22:00\nDimanche : 08:00 - 22:00				https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/test2/menu.jpg	\N	approved
d30e0ca5-a5ac-449a-a861-5ca3c9ee4c6c	Latest Recipe	Lively open kitchen with unusual gastronomic delights and interactive chefs are just some of the daily activities at the Latest Recipe. Experience this live cooking adventure at the lobby level of Le M├®ridien Oran. At the Latest Recipe, guests can indulge in popular dishes that are prepared ÔÇÿa la minuteÔÇÖ.	Le Meridien Oran Hotel & Convention Centre, Oran 31000 Alg├®rie	+213 41 98 40 00	service.lmbkk@lemeridien.com	italien	4	2025-03-26 16:10:05.216+00	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/latest-recipe/main.jpg	Italian / International	Lundi : 08:00 - 22:00\nMardi : 08:00 - 22:00\nMercredi : 08:00 - 22:00\nJeudi : 08:00 - 22:00\nVendredi : 08:00 - 22:00\nSamedi : 08:00 - 22:00\nDimanche : Ferm├®		Smart Casual	Esp├¿ces, Carte bancaire	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/Restaurants_photos/Restaurants_photos/public/latest-recipe/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	pending
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, user_id, review_type, review_type_id, rating, comment, created_at) FROM stdin;
d39ca061-6808-452d-bb69-4c5050a3514f	428f85b4-5082-4e96-aed6-6703beedf4e7	tour_activity	bad421f2-ca8a-4a9b-929b-0db51d34a1da	5	kkk	2025-03-17 11:39:41.020372+00
bcf7b63d-f12e-4ca7-ae3b-c408bd84bae8	59d12ed6-83fd-45c9-aedb-6718a252e59a	tour_activity	3fb7543e-9199-441e-80ad-74444b0b4eab	5	nice	2025-03-19 17:51:49.531189+00
bec5a946-1c56-4173-80cf-96e14522ea55	c95a2106-3226-403a-9d43-5af9e29e5ca1	hotel_offer	a541bd82-8d12-41d1-9ad4-a59d74a341c6	4	c'est manifique	2025-03-25 01:21:27.00619+00
\.


--
-- Data for Name: tour_announcements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_announcements (tour_announcement_id, user_id, name, description, price, discount_percentage, old_price, start_date, end_date, difficulty_level, duration, what_to_bring, meeting_point, images, max_participants, language, is_guided, location, is_available, "Contact", created_at) FROM stdin;
15608dce-a9bf-4b51-bdf8-5ac89dbf993b	328840a0-6e8c-4444-bb05-a010511f37e7	Sortie en famille	fgdfgdf	1200.00	20.00	\N	2025-03-11	2025-03-27	moderate	de 9h ├á 16	dgdgd	place d'arme	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/tour_photos/Sortie%20en%20famille/1741699223187.jpeg	10	Fran├ºais	t	Oran	t	794553778	2025-03-11 13:20:22.996047+00
bad421f2-ca8a-4a9b-929b-0db51d34a1da	328840a0-6e8c-4444-bb05-a010511f37e7	Sortie	dsdsd	1200.00	20.00	\N	2025-03-04	2025-03-21	moderate	de 9h ├á 16	sdsdsdssd	dsdsds	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/tour_photos/Sortie/1741702681167.png	10	Fran├ºais	t	Oran	t	794553778	2025-03-04 14:16:36.14007+00
3fb7543e-9199-441e-80ad-74444b0b4eab	428f85b4-5082-4e96-aed6-6703beedf4e7	santa cruz	descrip	8000.00	80.00	\N	2025-03-17	2025-03-17	easy	5h	rien	oran	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/tour_photos/tours/santa-1742228235086.jpg	98	Fran├ºais	t	oran	t	\N	2025-03-17 16:17:24.445652+00
23c0c96a-b8bf-44fd-8566-364bafcb1e34	428f85b4-5082-4e96-aed6-6703beedf4e7	sidi houari 	description de la sortie en detail	1000.00	4.99	\N	2025-03-28	2025-03-30	moderate	5h	l'energie	place d'arme 	https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/tour_photos/tours/sidi houari -1743006049555.webp	25	Arabe	t	sidi houari oran	t	\N	2025-03-26 16:20:35.678209+00
a9d765d0-ea91-40db-8102-f4217829689a	328840a0-6e8c-4444-bb05-a010511f37e7	test		99.99	5.00	\N	2025-03-26	2025-03-26	moderate				https://axwgziupmlzkyfebumsg.supabase.co/storage/v1/object/public/tour_photos/tours/test-1743008871086.webp	10	Fran├ºais	f		t	\N	2025-03-26 17:08:10.035286+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, first_name, last_name, username, email, nationality, address, profession, phone_number, profile_picture, role, verified_account, created_at, updated_at) FROM stdin;
8f8cb8d7-3934-4e15-9252-f19994b75d36	Ahmed	Benali	ahmed.benali@gmail.com	ahmed.benali@gmail.com	\N	\N	\N	\N	\N	visitor	f	2025-03-19 14:56:27.037413+00	2025-03-19 14:56:27.037413+00
d314c7cc-ea9d-440e-8d46-1fe4e27938d0	blah	blah	c83360e86a50@drmail.in	c83360e86a50@drmail.in	\N	\N	\N	4556544	\N	site_admin	t	2025-02-25 10:50:25.501902+00	2025-02-25 10:50:25.501902+00
f8790052-a0ed-408b-a4cc-aa3cdc30bf38	Fatima	Zohra	fatima.zohra@yahoo.fr	fatima.zohra@yahoo.fr	\N	\N	\N	\N	\N	visitor	f	2025-03-19 14:57:29.764628+00	2025-03-19 14:57:29.764628+00
e12f1d1d-69ae-4c6f-b14f-8159ffb3eb3b	Karim	Djelloul\t	karim.djelloul@outlook.com	karim.djelloul@outlook.com	\N	\N	\N	\N	\N	visitor	f	2025-03-19 14:58:54.549541+00	2025-03-19 14:58:54.549541+00
c0df7f47-b0d9-4ad1-b755-7ce091f89b61	Lina	Saidi	lina.saidi@gmail.com	lina.saidi@gmail.com	\N	\N	\N	\N	\N	visitor	f	2025-03-19 15:00:00.03104+00	2025-03-19 15:00:00.03104+00
428f85b4-5082-4e96-aed6-6703beedf4e7	Ibrahim	Yebdri	ib.yebdri	ib.yebdri@gmail.com	\N	\N	\N	011	\N	tour_organizer	t	2025-03-15 14:06:19.804591+00	2025-03-15 14:06:19.804591+00
59d12ed6-83fd-45c9-aedb-6718a252e59a	Yebdri	Ibrahim 	ib.yebdri58@gmail.com	ib.yebdri58@gmail.com	\N	\N	\N	0778653633	\N	visitor	f	2025-03-19 14:31:54.629344+00	2025-03-19 14:31:54.629344+00
c95a2106-3226-403a-9d43-5af9e29e5ca1	sheraton	user	nosawer579@btcours.com	nosawer579@btcours.com	\N	\N	\N	01	\N	hotel_admin	f	2025-02-17 11:08:48.490849+00	2025-02-17 11:08:48.490849+00
328840a0-6e8c-4444-bb05-a010511f37e7	deddouche	abderrahmene	deddoucheabdou33@gmail.com	deddoucheabdou33@gmail.com	Alg├®rien	Oran		0794553778	\N	tour_organizer	t	2025-02-19 18:02:41.169518+00	2025-03-25 15:29:09.062+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-02-14 09:15:42
20211116045059	2025-02-14 09:15:42
20211116050929	2025-02-14 09:15:42
20211116051442	2025-02-14 09:15:43
20211116212300	2025-02-14 09:15:43
20211116213355	2025-02-14 09:15:43
20211116213934	2025-02-14 09:15:43
20211116214523	2025-02-14 09:15:43
20211122062447	2025-02-14 09:15:43
20211124070109	2025-02-14 09:15:44
20211202204204	2025-02-14 09:15:44
20211202204605	2025-02-14 09:15:44
20211210212804	2025-02-14 09:15:44
20211228014915	2025-02-14 09:15:45
20220107221237	2025-02-14 09:15:45
20220228202821	2025-02-14 09:15:45
20220312004840	2025-02-14 09:15:45
20220603231003	2025-02-14 09:15:45
20220603232444	2025-02-14 09:15:46
20220615214548	2025-02-14 09:15:46
20220712093339	2025-02-14 09:15:46
20220908172859	2025-02-14 09:15:46
20220916233421	2025-02-14 09:15:46
20230119133233	2025-02-14 09:15:46
20230128025114	2025-02-14 09:15:47
20230128025212	2025-02-14 09:15:47
20230227211149	2025-02-14 09:15:47
20230228184745	2025-02-14 09:15:47
20230308225145	2025-02-14 09:15:47
20230328144023	2025-02-14 09:15:47
20231018144023	2025-02-14 09:15:47
20231204144023	2025-02-14 09:15:48
20231204144024	2025-02-14 09:15:48
20231204144025	2025-02-14 09:15:48
20240108234812	2025-02-14 09:15:48
20240109165339	2025-02-14 09:15:48
20240227174441	2025-02-14 09:15:49
20240311171622	2025-02-14 09:15:49
20240321100241	2025-02-14 09:15:49
20240401105812	2025-02-14 09:15:50
20240418121054	2025-02-14 09:15:50
20240523004032	2025-02-14 09:15:50
20240618124746	2025-02-14 09:15:50
20240801235015	2025-02-14 09:15:51
20240805133720	2025-02-14 09:15:51
20240827160934	2025-02-14 09:15:51
20240919163303	2025-02-14 09:15:51
20240919163305	2025-02-14 09:15:51
20241019105805	2025-02-14 09:15:51
20241030150047	2025-02-14 09:15:52
20241108114728	2025-02-14 09:15:52
20241121104152	2025-02-14 09:15:52
20241130184212	2025-02-14 09:15:53
20241220035512	2025-02-14 09:15:53
20241220123912	2025-02-14 09:15:53
20241224161212	2025-02-14 09:15:53
20250107150512	2025-02-14 09:15:53
20250110162412	2025-02-14 09:15:53
20250123174212	2025-02-14 09:15:53
20250128220012	2025-02-14 09:15:54
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
hotels-images	hotels-images	\N	2025-02-14 16:50:20.426384+00	2025-02-14 16:50:20.426384+00	t	f	\N	\N	\N
Restaurants_photos	Restaurants_photos	\N	2025-02-16 16:51:11.220852+00	2025-02-16 16:51:11.220852+00	t	f	\N	\N	\N
tour_photos	tour_photos	\N	2025-02-21 19:57:57.88616+00	2025-02-21 19:57:57.88616+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-02-14 09:11:27.303267
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-02-14 09:11:27.344149
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-02-14 09:11:27.360058
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-02-14 09:11:27.399139
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-02-14 09:11:27.438574
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-02-14 09:11:27.446262
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-02-14 09:11:27.457587
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-02-14 09:11:27.468558
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-02-14 09:11:27.477654
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-02-14 09:11:27.493537
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-02-14 09:11:27.503428
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-02-14 09:11:27.511407
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-02-14 09:11:27.523825
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-02-14 09:11:27.538449
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-02-14 09:11:27.549234
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-02-14 09:11:27.593428
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-02-14 09:11:27.60435
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-02-14 09:11:27.614969
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-02-14 09:11:27.625676
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-02-14 09:11:27.64457
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-02-14 09:11:27.65697
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-02-14 09:11:27.671336
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-02-14 09:11:27.706966
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-02-14 09:11:27.741823
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-02-14 09:11:27.751155
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2025-02-14 09:11:27.765415
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
651a483c-5005-424f-a5b6-109658f644b0	hotels-images	Le_Meridien_Oran_Hotel_and_Convention_Centre-Oran-Exterior_view-5-448873.jpg	\N	2025-02-15 09:30:11.056926+00	2025-02-15 09:30:11.056926+00	2025-02-15 09:30:11.056926+00	{"eTag": "\\"1346360735bc725a059fb448f8d00771-1\\"", "size": 291332, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-15T09:30:11.000Z", "contentLength": 291332, "httpStatusCode": 200}	df8902cd-bcb8-4b59-b974-558dd9d22a93	\N	\N
5bfd73e4-c926-4832-b4ca-e759ab87a541	tour_photos	Sortie/1741096387532-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-04 13:53:07.735143+00	2025-03-04 13:53:07.735143+00	2025-03-04 13:53:07.735143+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-04T13:53:08.000Z", "contentLength": 1129637, "httpStatusCode": 200}	a0c9b5f2-ce98-4c0f-8cf9-d578605b92f5	328840a0-6e8c-4444-bb05-a010511f37e7	{}
60ee6588-e3a8-44bc-a396-6b99931921fe	hotels-images	shearton.jpg	\N	2025-02-15 13:10:02.968834+00	2025-02-15 13:10:02.968834+00	2025-02-15 13:10:02.968834+00	{"eTag": "\\"ea06b8cb55973718372c83c5d0b6fbd0-1\\"", "size": 108696, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-15T13:10:03.000Z", "contentLength": 108696, "httpStatusCode": 200}	0f61c1c8-e85d-49d0-837e-99bfc1332ca1	\N	\N
373461db-3a49-405c-ad79-1130ec0261f5	hotels-images	Le Meridien-1739788890751.png	4b0ae45e-4416-46f2-b122-2d4185db4ee0	2025-02-17 10:41:38.831435+00	2025-02-17 10:41:38.831435+00	2025-02-17 10:41:38.831435+00	{"eTag": "\\"2a4ea9e55abe9e5108b8c1e8d8443271\\"", "size": 570838, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-17T10:41:39.000Z", "contentLength": 570838, "httpStatusCode": 200}	a91bef7e-a4f8-4d12-95b6-a0faaa99d9b0	4b0ae45e-4416-46f2-b122-2d4185db4ee0	{}
620e3b8a-11c0-4796-b2ae-4e7638901cce	hotels-images	hotels/Le Meridien-1739789059772.png	4b0ae45e-4416-46f2-b122-2d4185db4ee0	2025-02-17 10:44:28.151487+00	2025-02-17 10:44:28.151487+00	2025-02-17 10:44:28.151487+00	{"eTag": "\\"60daef8e743870ec963620bb9d89f550\\"", "size": 789694, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-17T10:44:28.000Z", "contentLength": 789694, "httpStatusCode": 200}	bb86808c-9d87-4266-9d29-bc03c30ae489	4b0ae45e-4416-46f2-b122-2d4185db4ee0	{}
cae96dba-f512-4eed-8aad-9986fcd1e596	hotels-images	hotels/sheraton-1739791094941.png	c95a2106-3226-403a-9d43-5af9e29e5ca1	2025-02-17 11:18:21.167145+00	2025-02-17 11:18:21.167145+00	2025-02-17 11:18:21.167145+00	{"eTag": "\\"f64f777a630673d9b088d50459776887\\"", "size": 572701, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-17T11:18:21.000Z", "contentLength": 572701, "httpStatusCode": 200}	6b96e083-67e6-4a14-89c3-ee18e294d3a6	c95a2106-3226-403a-9d43-5af9e29e5ca1	{}
6bcc598f-2ff4-4232-a984-a8d61fc17ddc	Restaurants_photos	la comete/la-comete.jpg	\N	2025-02-16 18:31:29.490632+00	2025-02-18 13:34:17.211677+00	2025-02-16 18:31:29.490632+00	{"eTag": "\\"ab6986ae85c5ba0b26d3f255d8cb0070\\"", "size": 125281, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-18T13:34:17.000Z", "contentLength": 125281, "httpStatusCode": 200}	0583979e-2ed2-4a8c-8c07-d52076783c7a	\N	\N
1a2da396-2a53-4909-bb2c-d6de6b9e5869	Restaurants_photos	la gazelle/photo1jpg.jpg	\N	2025-02-16 16:53:48.657274+00	2025-02-18 13:34:46.99083+00	2025-02-16 16:53:48.657274+00	{"eTag": "\\"ebd803e0e8614b5d9b8f158b35c244c3\\"", "size": 147766, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-18T13:34:47.000Z", "contentLength": 147766, "httpStatusCode": 200}	b01fc082-0572-40bd-bf3c-adf3e8efc839	\N	\N
3d35f8e7-9901-499a-a1d1-d40f5d5266db	Restaurants_photos	la gazelle/Capture.PNG	\N	2025-02-18 13:45:07.955669+00	2025-02-18 13:45:07.955669+00	2025-02-18 13:45:07.955669+00	{"eTag": "\\"ed0afb4ea8ded82d8c10ebc92e8a8880-1\\"", "size": 559378, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-18T13:45:08.000Z", "contentLength": 559378, "httpStatusCode": 200}	f59a0402-ea4e-4316-be27-49688c380f19	\N	\N
5e4e4f60-4040-4221-bbf0-9961b27b9b4c	Restaurants_photos	Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/nautile/main.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-19 18:30:39.309766+00	2025-02-19 18:30:39.309766+00	2025-02-19 18:30:39.309766+00	{"eTag": "\\"796dc1c553e35887768f88fa20c64601\\"", "size": 337648, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-19T18:30:40.000Z", "contentLength": 337648, "httpStatusCode": 200}	4821a1ed-a80c-475a-a5e8-8f85e11f664b	328840a0-6e8c-4444-bb05-a010511f37e7	{}
dbef7bd2-89e7-420e-b778-510f62a0bb8a	Restaurants_photos	Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/nautile/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-19 18:30:40.007635+00	2025-02-19 18:30:40.007635+00	2025-02-19 18:30:40.007635+00	{"eTag": "\\"78c620011d73587e64204e6adebeec35\\"", "size": 114060, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-19T18:30:40.000Z", "contentLength": 114060, "httpStatusCode": 200}	bbfac9f1-bf1d-4dc8-8343-278ec4657561	328840a0-6e8c-4444-bb05-a010511f37e7	{}
3ba4a5b7-934b-417c-aedf-f5b0d9420fd2	Restaurants_photos	Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/hichem-cook/main.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-21 10:46:48.895448+00	2025-02-21 10:46:48.895448+00	2025-02-21 10:46:48.895448+00	{"eTag": "\\"b3e1bddadf66ef1c06b4277745aa0fd2\\"", "size": 442069, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-21T10:46:49.000Z", "contentLength": 442069, "httpStatusCode": 200}	143354ec-7736-4035-9a64-b77fdccbe289	328840a0-6e8c-4444-bb05-a010511f37e7	{}
8bc980e6-f55d-4d1d-99d6-fa34c89ef45a	Restaurants_photos	Restaurants_photos/328840a0-6e8c-4444-bb05-a010511f37e7/hichem-cook/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-21 10:46:49.736697+00	2025-02-21 10:46:49.736697+00	2025-02-21 10:46:49.736697+00	{"eTag": "\\"26a3a4df307c976d3ca4952bcc419bc3\\"", "size": 397894, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-21T10:46:50.000Z", "contentLength": 397894, "httpStatusCode": 200}	5944d7a1-2fd8-47c5-9d12-c32714c5d146	328840a0-6e8c-4444-bb05-a010511f37e7	{}
eee5ca02-8080-4f9b-bde9-c494bb5dc8bd	Restaurants_photos	Restaurants_photos/4b0ae45e-4416-46f2-b122-2d4185db4ee0/bladi/main.jpg	4b0ae45e-4416-46f2-b122-2d4185db4ee0	2025-02-21 16:42:23.580514+00	2025-02-21 16:42:23.580514+00	2025-02-21 16:42:23.580514+00	{"eTag": "\\"ae0c0f3b9470c44b818edd65be571dda\\"", "size": 11868, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-21T16:42:24.000Z", "contentLength": 11868, "httpStatusCode": 200}	61129b10-1c7e-4e56-baaa-1f9019201d51	4b0ae45e-4416-46f2-b122-2d4185db4ee0	{}
0065c263-9e89-4e04-922a-ccbf9adf28db	Restaurants_photos	Restaurants_photos/4b0ae45e-4416-46f2-b122-2d4185db4ee0/bladi/menu.jpg	4b0ae45e-4416-46f2-b122-2d4185db4ee0	2025-02-21 16:42:24.163076+00	2025-02-21 16:42:24.163076+00	2025-02-21 16:42:24.163076+00	{"eTag": "\\"ae0c0f3b9470c44b818edd65be571dda\\"", "size": 11868, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-21T16:42:25.000Z", "contentLength": 11868, "httpStatusCode": 200}	f60c1240-203d-48e2-ad06-c0b177fad269	4b0ae45e-4416-46f2-b122-2d4185db4ee0	{}
36812cd3-2084-43fe-8a42-ff87b33ab961	tour_photos	Sortie/1741096508516-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-04 13:55:08.697003+00	2025-03-04 13:55:08.697003+00	2025-03-04 13:55:08.697003+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-04T13:55:09.000Z", "contentLength": 1129637, "httpStatusCode": 200}	cd0f0059-b2a4-4ea6-ad1a-b42f30188a3d	328840a0-6e8c-4444-bb05-a010511f37e7	{}
cc25890f-fcf1-4d69-bf3d-6ebde7ad2bf2	tour_photos	sortie /1740168165070-cons.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-21 20:02:44.25909+00	2025-02-21 20:02:44.25909+00	2025-02-21 20:02:44.25909+00	{"eTag": "\\"bfb115390b9dd8b70affec990021509c\\"", "size": 265535, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-21T20:02:45.000Z", "contentLength": 265535, "httpStatusCode": 200}	0a60a1fa-3b54-40fa-aecc-d9f42ff8d7c0	328840a0-6e8c-4444-bb05-a010511f37e7	{}
9213e601-76db-402f-888f-dca40b3afc05	Restaurants_photos	Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/hichem-cook-2/main.jpg	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	2025-02-25 13:46:20.741641+00	2025-02-25 13:46:20.741641+00	2025-02-25 13:46:20.741641+00	{"eTag": "\\"e2912518ec1f2a6a5c041375a12b5eff\\"", "size": 92492, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-25T13:46:21.000Z", "contentLength": 92492, "httpStatusCode": 200}	61a29c82-7141-40f5-9a34-d649cc792400	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	{}
a05135be-3f2b-4273-9e20-d9ee2c63f9a9	tour_photos	Sortie/1741102119677-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-04 15:28:39.819524+00	2025-03-04 15:28:39.819524+00	2025-03-04 15:28:39.819524+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-04T15:28:40.000Z", "contentLength": 1129637, "httpStatusCode": 200}	437ecc82-a8e7-4ae5-9823-464bb30df7dc	328840a0-6e8c-4444-bb05-a010511f37e7	{}
d05ea126-af68-4be1-a8ae-5062a46c48ce	Restaurants_photos	Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/hichem-cook-2/menu.jpg	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	2025-02-25 13:46:21.21248+00	2025-02-25 13:46:21.21248+00	2025-02-25 13:46:21.21248+00	{"eTag": "\\"bfb115390b9dd8b70affec990021509c\\"", "size": 265535, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-25T13:46:22.000Z", "contentLength": 265535, "httpStatusCode": 200}	16f32068-56d9-496c-bb1d-484b6bfc14fe	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	{}
ea7e5985-b85b-450b-9c38-9b69d36d4bbd	Restaurants_photos	Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/le-petit-chalet/main.jpg	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	2025-02-25 15:52:52.380014+00	2025-02-25 15:52:52.380014+00	2025-02-25 15:52:52.380014+00	{"eTag": "\\"0f6e394cb444deb25d1a3058a47315ec\\"", "size": 183588, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-25T15:52:53.000Z", "contentLength": 183588, "httpStatusCode": 200}	1e8ce0bb-5e2b-4b92-9db0-44ccf98721a7	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	{}
9882c568-91eb-45ff-a337-580b4f5b46db	Restaurants_photos	Restaurants_photos/d314c7cc-ea9d-440e-8d46-1fe4e27938d0/le-petit-chalet/menu.png	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	2025-02-25 15:52:53.094593+00	2025-02-25 15:52:53.094593+00	2025-02-25 15:52:53.094593+00	{"eTag": "\\"366ce6b8f65e4706739fed1fd4fc3eaf\\"", "size": 487938, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-25T15:52:53.000Z", "contentLength": 487938, "httpStatusCode": 200}	76ff11b2-8c92-4d56-879b-405c8cb7733c	d314c7cc-ea9d-440e-8d46-1fe4e27938d0	{}
352b652f-60c9-48ed-9ff4-ea6596a95090	hotels-images	hotels/Le Meridien-1740662153921.jpg	4b0ae45e-4416-46f2-b122-2d4185db4ee0	2025-02-27 13:15:58.151066+00	2025-02-27 13:15:58.151066+00	2025-02-27 13:15:58.151066+00	{"eTag": "\\"44931e8284298ec48684b6281708e846\\"", "size": 4028, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-27T13:15:59.000Z", "contentLength": 4028, "httpStatusCode": 200}	16fdb68d-57eb-4419-84fd-9d0a79309ecb	4b0ae45e-4416-46f2-b122-2d4185db4ee0	{}
7c2e0aa4-4013-401b-a33c-357305f31632	tour_photos	Sortie en famille/1740765135059-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-28 17:52:15.666481+00	2025-02-28 17:52:15.666481+00	2025-02-28 17:52:15.666481+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-28T17:52:16.000Z", "contentLength": 1129637, "httpStatusCode": 200}	e979b463-5620-4c4b-bf76-2ccbf34d446b	328840a0-6e8c-4444-bb05-a010511f37e7	{}
6969f401-6e17-4bf5-b648-1d851ec5bb8c	tour_photos	Sortie en famille/1740767815008-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-28 18:36:55.700143+00	2025-02-28 18:36:55.700143+00	2025-02-28 18:36:55.700143+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-28T18:36:56.000Z", "contentLength": 1129637, "httpStatusCode": 200}	ced64b9d-4614-4715-bb52-bb4b517fb916	328840a0-6e8c-4444-bb05-a010511f37e7	{}
c317bae7-1557-48c7-9b99-a55290478efe	tour_photos	Sortie en famille/1740769044318-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-28 18:57:25.551953+00	2025-02-28 18:57:25.551953+00	2025-02-28 18:57:25.551953+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-28T18:57:26.000Z", "contentLength": 1129637, "httpStatusCode": 200}	725e799a-9611-49a0-94c1-f96d18c621e2	328840a0-6e8c-4444-bb05-a010511f37e7	{}
f4d6f1d1-0b3e-4a82-90b3-5cd8eb63c18b	tour_photos	Sortie en famille/1740769114275-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-02-28 18:58:34.77756+00	2025-02-28 18:58:34.77756+00	2025-02-28 18:58:34.77756+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-02-28T18:58:35.000Z", "contentLength": 1129637, "httpStatusCode": 200}	e69318ef-f8ba-4be9-a827-eb6f9084d917	328840a0-6e8c-4444-bb05-a010511f37e7	{}
8844fb35-71d7-4523-8cea-0733dd7077b7	tour_photos	Sortie en famille/1740841166636-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 14:59:27.528509+00	2025-03-01 14:59:27.528509+00	2025-03-01 14:59:27.528509+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T14:59:28.000Z", "contentLength": 1129637, "httpStatusCode": 200}	d8ec6d34-f9d6-44ff-bad8-f1525d4b657f	328840a0-6e8c-4444-bb05-a010511f37e7	{}
618c0b6d-0311-4acf-a450-6ae0a69b79d0	tour_photos	Sortie/1741097795891-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-04 14:16:35.96643+00	2025-03-04 14:16:35.96643+00	2025-03-04 14:16:35.96643+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-04T14:16:36.000Z", "contentLength": 1129637, "httpStatusCode": 200}	cb71bd09-52ba-4ca9-9573-4c38cb942ea1	328840a0-6e8c-4444-bb05-a010511f37e7	{}
b6616259-81f7-4d10-9abc-50e9d882e7d8	tour_photos	Sortie en famille/1740841256618-81546803_2764516393608169_8227696504794513408_n.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 15:00:57.28176+00	2025-03-01 15:00:57.28176+00	2025-03-01 15:00:57.28176+00	{"eTag": "\\"366ce6b8f65e4706739fed1fd4fc3eaf\\"", "size": 487938, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T15:00:58.000Z", "contentLength": 487938, "httpStatusCode": 200}	71ea1b77-7f1c-4831-abfd-6b1e1606043b	328840a0-6e8c-4444-bb05-a010511f37e7	{}
20e5d9f4-f6ee-40f2-9b05-4291f5f9fde1	tour_photos	Sortie en famille/1740841306837-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 15:01:47.406508+00	2025-03-01 15:01:47.406508+00	2025-03-01 15:01:47.406508+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T15:01:48.000Z", "contentLength": 1129637, "httpStatusCode": 200}	f109be19-13a2-4fff-830e-d4c621491179	328840a0-6e8c-4444-bb05-a010511f37e7	{}
7c741521-fe4c-45d0-9794-021e212fbc76	tour_photos	Sortie en famille/1741363502815.jpeg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-07 16:05:03.487819+00	2025-03-07 16:05:03.487819+00	2025-03-07 16:05:03.487819+00	{"eTag": "\\"19cf4aeb4c0fd3ed271deb4d51fa10fa\\"", "size": 12291, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-07T16:05:04.000Z", "contentLength": 12291, "httpStatusCode": 200}	c2170628-320a-49e4-851c-9c912066ed23	328840a0-6e8c-4444-bb05-a010511f37e7	{}
a8fb5fd4-64c2-46d2-b8e3-a75e56c953ff	tour_photos	Sortie en famille/1740855006756-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 18:50:06.970978+00	2025-03-01 18:50:06.970978+00	2025-03-01 18:50:06.970978+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T18:50:07.000Z", "contentLength": 1129637, "httpStatusCode": 200}	f7ae056e-6f5f-4706-8873-a72ef7e971fa	328840a0-6e8c-4444-bb05-a010511f37e7	{}
a7fbaf60-fdaf-4458-99dd-9cae983d82b8	tour_photos	Sortie en famille/1740855635172-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 19:00:41.111599+00	2025-03-01 19:00:41.111599+00	2025-03-01 19:00:41.111599+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T19:00:41.000Z", "contentLength": 1129637, "httpStatusCode": 200}	181054ac-2b34-4d77-85c1-e3b8aa248f15	328840a0-6e8c-4444-bb05-a010511f37e7	{}
bba3d6bf-8441-4618-a3de-58973f6e5ee0	tour_photos	Sortie en famille/1741363993837.jpeg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-07 16:13:14.397291+00	2025-03-07 16:13:14.397291+00	2025-03-07 16:13:14.397291+00	{"eTag": "\\"19cf4aeb4c0fd3ed271deb4d51fa10fa\\"", "size": 12291, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-07T16:13:15.000Z", "contentLength": 12291, "httpStatusCode": 200}	785bdc1b-2faa-4d5f-bae6-04d9b6f28ae3	328840a0-6e8c-4444-bb05-a010511f37e7	{}
6e2d126f-2e86-4125-9bf8-0dc09ef5a52c	tour_photos	Sortie en famille/1740856732108-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 19:18:53.469354+00	2025-03-01 19:18:53.469354+00	2025-03-01 19:18:53.469354+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T19:18:54.000Z", "contentLength": 1129637, "httpStatusCode": 200}	27dd6242-81ca-4e16-9b55-0c50e6445782	328840a0-6e8c-4444-bb05-a010511f37e7	{}
44856846-c157-4db8-9736-9776a148975c	tour_photos	Sortie en famille/1740856756795-1200x900_sortie-nature-valloire-valloire-reservations-6254647.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-01 19:19:17.074158+00	2025-03-01 19:19:17.074158+00	2025-03-01 19:19:17.074158+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-01T19:19:17.000Z", "contentLength": 1129637, "httpStatusCode": 200}	cb5a167b-3df3-4255-a50f-6f985d2b0c22	328840a0-6e8c-4444-bb05-a010511f37e7	{}
5f6c273c-3406-4c8a-baa7-a3c8f038e9f9	tour_photos	Sortie en famille/1741699059536.jpeg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-11 13:17:39.180981+00	2025-03-11 13:17:39.180981+00	2025-03-11 13:17:39.180981+00	{"eTag": "\\"19cf4aeb4c0fd3ed271deb4d51fa10fa\\"", "size": 12291, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-11T13:17:40.000Z", "contentLength": 12291, "httpStatusCode": 200}	2a768186-10af-47c3-94f2-d03cceff446e	328840a0-6e8c-4444-bb05-a010511f37e7	{}
abbc6382-c509-48c4-a53d-8541516211c3	tour_photos	Sortie en famille/1741699223187.jpeg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-11 13:20:22.799898+00	2025-03-11 13:20:22.799898+00	2025-03-11 13:20:22.799898+00	{"eTag": "\\"19cf4aeb4c0fd3ed271deb4d51fa10fa\\"", "size": 12291, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-11T13:20:23.000Z", "contentLength": 12291, "httpStatusCode": 200}	137e65d9-3a59-4cc3-815f-d6c9731e4acb	328840a0-6e8c-4444-bb05-a010511f37e7	{}
454c54aa-f34c-49dd-864a-8aa48de54075	tour_photos	Sortie/1741700690445.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-11 13:44:50.554827+00	2025-03-11 13:44:50.554827+00	2025-03-11 13:44:50.554827+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-11T13:44:51.000Z", "contentLength": 1129637, "httpStatusCode": 200}	b9620247-bd39-4197-962a-23e7a87bccca	328840a0-6e8c-4444-bb05-a010511f37e7	{}
99b0798e-e4c6-427c-a9e8-30dd34f18084	tour_photos	Sortie/1741701050341.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-11 13:50:50.315186+00	2025-03-11 13:50:50.315186+00	2025-03-11 13:50:50.315186+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-11T13:50:51.000Z", "contentLength": 1129637, "httpStatusCode": 200}	7793f852-5b7e-4b3c-b963-f5cde62e0e4c	328840a0-6e8c-4444-bb05-a010511f37e7	{}
61f45ce2-a69a-4a61-9129-cf36df2fb168	tour_photos	Sortie/1741702681167.png	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-11 14:18:01.138316+00	2025-03-11 14:18:01.138316+00	2025-03-11 14:18:01.138316+00	{"eTag": "\\"2a768c826800343e2eade3b4b3eac60f\\"", "size": 1129637, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-03-11T14:18:01.000Z", "contentLength": 1129637, "httpStatusCode": 200}	4ddc376a-f231-4dd9-8849-e6bbf0a20673	328840a0-6e8c-4444-bb05-a010511f37e7	{}
24f54a30-3c6a-415b-8b0b-474a820560c8	Restaurants_photos	Restaurants_photos/public/.emptyFolderPlaceholder	\N	2025-03-15 12:42:21.515516+00	2025-03-15 12:42:21.515516+00	2025-03-15 12:42:21.515516+00	{"eTag": "\\"d41d8cd98f00b204e9800998ecf8427e\\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-03-15T12:42:22.000Z", "contentLength": 0, "httpStatusCode": 200}	151f228e-a86d-4444-b6ed-c3d516788a71	\N	{}
eceea1ec-e267-47c7-b2f8-3fd48a4623e2	Restaurants_photos	Restaurants_photos/public/test2/main.jpg	\N	2025-03-15 12:42:27.065381+00	2025-03-15 12:42:27.065381+00	2025-03-15 12:42:27.065381+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-15T12:42:28.000Z", "contentLength": 12833, "httpStatusCode": 200}	3c6d934b-37f2-42fd-a18e-d14632bf49bc	\N	{}
a1df4b8c-5871-413c-9c0d-f1286769b231	Restaurants_photos	Restaurants_photos/public/test2/menu.jpg	\N	2025-03-15 12:42:27.43745+00	2025-03-15 12:42:27.43745+00	2025-03-15 12:42:27.43745+00	{"eTag": "\\"9229ad8e2797e7394be71f356c7eb531\\"", "size": 11863, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-15T12:42:28.000Z", "contentLength": 11863, "httpStatusCode": 200}	fe9eec67-d3dd-4513-be07-84a4591f519b	\N	{}
d063c624-9084-4f0e-98ca-c43b2b154fe8	tour_photos	tours/sortie santa cruz-1742227111452.jpg	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-17 15:58:41.087581+00	2025-03-17 15:58:41.087581+00	2025-03-17 15:58:41.087581+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-17T15:58:42.000Z", "contentLength": 12833, "httpStatusCode": 200}	6d610db6-bd16-4067-b352-a835f9775eaf	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
c19089da-f67a-4a00-b720-d2f0bf90ad3f	tour_photos	tours/meridien-1742227467120.jpg	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-17 16:04:36.779333+00	2025-03-17 16:04:36.779333+00	2025-03-17 16:04:36.779333+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-17T16:04:37.000Z", "contentLength": 12833, "httpStatusCode": 200}	4c824824-02f9-4f2a-98bb-e551590cc0e7	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
8b659134-fe27-497e-823c-c8b99000e65c	tour_photos	tours/snta-1742227765162.jpg	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-17 16:09:36.225323+00	2025-03-17 16:09:36.225323+00	2025-03-17 16:09:36.225323+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-17T16:09:37.000Z", "contentLength": 12833, "httpStatusCode": 200}	cc19295c-ce06-4bb9-a3cb-14f3390967bf	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
2e2c30d2-ba60-4f76-88f3-732d424769a4	tour_photos	tours/santa-1742228203905.jpg	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-17 16:16:53.161291+00	2025-03-17 16:16:53.161291+00	2025-03-17 16:16:53.161291+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-17T16:16:54.000Z", "contentLength": 12833, "httpStatusCode": 200}	3b3d5cef-a49d-4d7b-b973-3a7f297ed3b6	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
1b9fefe9-46eb-4606-8c7c-b00a84157696	tour_photos	tours/santa-1742228235086.jpg	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-17 16:17:24.241828+00	2025-03-17 16:17:24.241828+00	2025-03-17 16:17:24.241828+00	{"eTag": "\\"9f97ca1e0b0f5044dcbc614d29e3db51\\"", "size": 12833, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-17T16:17:25.000Z", "contentLength": 12833, "httpStatusCode": 200}	f2b14714-57c9-4e3b-8462-975f3ab90bfb	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
4b38a40c-7af7-45ba-abf6-f18a6f40aa50	Restaurants_photos	Restaurants_photos/public/el-barrio/main.jpg	\N	2025-03-25 11:01:10.153385+00	2025-03-25 11:01:10.153385+00	2025-03-25 11:01:10.153385+00	{"eTag": "\\"d68bde52fabd6bbe32b33b533fdd20a4\\"", "size": 305320, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-25T11:01:10.000Z", "contentLength": 305320, "httpStatusCode": 200}	ce0b4ace-334b-49a9-a4e3-59720783f3a7	\N	{}
45be2edd-d0fe-4305-ba17-5ad7aaf1751d	Restaurants_photos	Restaurants_photos/public/el-barrio/menu.jpg	\N	2025-03-25 11:01:14.462847+00	2025-03-25 11:01:14.462847+00	2025-03-25 11:01:14.462847+00	{"eTag": "\\"3e6a46c287138c0476f773929dc3aebc\\"", "size": 350154, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-25T11:01:15.000Z", "contentLength": 350154, "httpStatusCode": 200}	53c181c3-1ef7-4f1e-9d12-25cd7e599bbc	\N	{}
c165d4b1-dd3a-4cf5-8c66-23d36a6f60a9	Restaurants_photos	Restaurants_photos/public/latest-recipe/main.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 16:10:03.947617+00	2025-03-26 16:10:03.947617+00	2025-03-26 16:10:03.947617+00	{"eTag": "\\"8b7252e667eed4f69fcf9d48a249b30d\\"", "size": 184549, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-26T16:10:04.000Z", "contentLength": 184549, "httpStatusCode": 200}	88978a4d-d249-4f4b-9d52-318a2ececb6a	328840a0-6e8c-4444-bb05-a010511f37e7	{}
d47f1bfb-fdef-4e8a-a8fb-251576084e6e	Restaurants_photos	Restaurants_photos/public/latest-recipe/menu.jpg	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 16:10:04.382499+00	2025-03-26 16:10:04.382499+00	2025-03-26 16:10:04.382499+00	{"eTag": "\\"fc63cdc20797d4b09f60134df1b25aec\\"", "size": 144974, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-26T16:10:05.000Z", "contentLength": 144974, "httpStatusCode": 200}	d572fd7f-54f1-4b5d-a6ff-f8a2f99933ca	328840a0-6e8c-4444-bb05-a010511f37e7	{}
68a08206-3e0d-414e-8ebc-12437d05b073	tour_photos	tours/sidi houari -1743006016179.webp	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-26 16:20:35.295576+00	2025-03-26 16:20:35.295576+00	2025-03-26 16:20:35.295576+00	{"eTag": "\\"3c6bc560e3c63324b9363eae680282b6\\"", "size": 4396, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-03-26T16:20:36.000Z", "contentLength": 4396, "httpStatusCode": 200}	f05938da-4949-4601-a294-5db280412a4d	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
3c5fc9e1-e357-44db-abf8-17e35704d929	tour_photos	tours/sidi houari -1743006049555.webp	428f85b4-5082-4e96-aed6-6703beedf4e7	2025-03-26 16:21:08.512553+00	2025-03-26 16:21:08.512553+00	2025-03-26 16:21:08.512553+00	{"eTag": "\\"3c6bc560e3c63324b9363eae680282b6\\"", "size": 4396, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-03-26T16:21:09.000Z", "contentLength": 4396, "httpStatusCode": 200}	8a36ecae-ac42-456b-b355-9404a04f0167	428f85b4-5082-4e96-aed6-6703beedf4e7	{}
6e2fdef2-8901-4937-9fd2-80a39ed6b6a4	tour_photos	tours/test-1743008871086.webp	328840a0-6e8c-4444-bb05-a010511f37e7	2025-03-26 17:08:09.785689+00	2025-03-26 17:08:09.785689+00	2025-03-26 17:08:09.785689+00	{"eTag": "\\"3c6bc560e3c63324b9363eae680282b6\\"", "size": 4396, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-03-26T17:08:10.000Z", "contentLength": 4396, "httpStatusCode": 200}	a3c1aeae-ac0d-4eeb-b555-3751b2dc276d	328840a0-6e8c-4444-bb05-a010511f37e7	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 265, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: hotel_offers hotel_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_offers
    ADD CONSTRAINT hotel_offers_pkey PRIMARY KEY (hotel_offer_id);


--
-- Name: hotel_services hotel_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_services
    ADD CONSTRAINT hotel_services_pkey PRIMARY KEY (hotel_service_id);


--
-- Name: hotels hotels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (hotel_id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (reservation_id);


--
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (restaurant_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: tour_announcements tour_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_announcements
    ADD CONSTRAINT tour_announcements_pkey PRIMARY KEY (tour_announcement_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_reservations_reservation_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_reservation_type_id ON public.reservations USING btree (reservation_type_id);


--
-- Name: idx_reservations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_user_id ON public.reservations USING btree (user_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: reservations check_reservation_fk_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_reservation_fk_trigger BEFORE INSERT OR UPDATE ON public.reservations FOR EACH ROW EXECUTE FUNCTION public.check_reservation_fk();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: hotels fk_hotel_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT fk_hotel_admin FOREIGN KEY (admin_id) REFERENCES public.users(user_id);


--
-- Name: hotel_offers hotel_offers_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_offers
    ADD CONSTRAINT hotel_offers_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id) ON DELETE CASCADE;


--
-- Name: hotel_services hotel_services_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_services
    ADD CONSTRAINT hotel_services_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id) ON DELETE CASCADE;


--
-- Name: reservations reservations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: tour_announcements tour_announcements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_announcements
    ADD CONSTRAINT tour_announcements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: users Admin access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin access" ON public.users TO authenticated USING ((auth.role() = 'admin'::text)) WITH CHECK ((auth.role() = 'admin'::text));


--
-- Name: restaurants Allow admin updates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin updates" ON public.restaurants FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'site_admin'::text))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'site_admin'::text)))));


--
-- Name: restaurants Allow authenticated insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated insert" ON public.restaurants FOR INSERT TO authenticated WITH CHECK ((owner_id = auth.uid()));


--
-- Name: users Allow authenticated users to insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated users to insert" ON public.users FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: tour_announcements Allow organizer full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow organizer full access" ON public.tour_announcements TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'organisateur'::text))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'organisateur'::text)))));


--
-- Name: restaurants Allow public inserts to restaurants; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public inserts to restaurants" ON public.restaurants FOR INSERT WITH CHECK (true);


--
-- Name: restaurants Allow public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read" ON public.restaurants FOR SELECT USING (true);


--
-- Name: restaurants Allow public read ; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read " ON public.restaurants FOR SELECT USING (((status)::text = 'approved'::text));


--
-- Name: tour_announcements Allow public read filtered; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read filtered" ON public.tour_announcements FOR SELECT USING (((is_available = true) AND (( SELECT users.role
   FROM public.users
  WHERE (users.user_id = tour_announcements.user_id)) = 'organisateur'::text)));


--
-- Name: restaurants Allow restaurant insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow restaurant insert" ON public.restaurants FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: tour_announcements Enable public read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access" ON public.tour_announcements FOR SELECT USING (true);


--
-- Name: restaurants Full admin access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Full admin access" ON public.restaurants USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((restaurants.restaurant_id = auth.uid()) AND (users.role = 'site_admin'::text))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((restaurants.restaurant_id = auth.uid()) AND (users.role = 'site_admin'::text)))));


--
-- Name: tour_announcements Public access for available activities; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public access for available activities" ON public.tour_announcements FOR SELECT USING ((is_available = true));


--
-- Name: tour_announcements Tour organizers access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Tour organizers access" ON public.tour_announcements USING ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'tour_organizer'::text))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'tour_organizer'::text)))));


--
-- Name: users User can read own role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "User can read own role" ON public.users FOR SELECT TO authenticated USING ((auth.uid() = user_id));


--
-- Name: hotel_offers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hotel_offers ENABLE ROW LEVEL SECURITY;

--
-- Name: hotel_offers hotel_offers_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_offers_delete_policy ON public.hotel_offers FOR DELETE TO authenticated USING ((hotel_id IN ( SELECT hotels.hotel_id
   FROM public.hotels
  WHERE (hotels.admin_id = auth.uid()))));


--
-- Name: hotel_offers hotel_offers_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_offers_insert_policy ON public.hotel_offers FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: hotel_offers hotel_offers_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_offers_select_policy ON public.hotel_offers FOR SELECT USING (true);


--
-- Name: hotel_offers hotel_offers_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_offers_update_policy ON public.hotel_offers FOR UPDATE TO authenticated USING ((hotel_id IN ( SELECT hotels.hotel_id
   FROM public.hotels
  WHERE (hotels.admin_id = auth.uid()))));


--
-- Name: hotel_services; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hotel_services ENABLE ROW LEVEL SECURITY;

--
-- Name: hotel_services hotel_services_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_services_delete_policy ON public.hotel_services FOR DELETE TO authenticated USING ((hotel_id IN ( SELECT hotels.hotel_id
   FROM public.hotels
  WHERE (hotels.admin_id = auth.uid()))));


--
-- Name: hotel_services hotel_services_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_services_insert_policy ON public.hotel_services FOR INSERT TO authenticated WITH CHECK ((hotel_id IN ( SELECT hotels.hotel_id
   FROM public.hotels
  WHERE (hotels.admin_id = auth.uid()))));


--
-- Name: hotel_services hotel_services_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_services_select_policy ON public.hotel_services FOR SELECT USING (true);


--
-- Name: hotel_services hotel_services_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotel_services_update_policy ON public.hotel_services FOR UPDATE TO authenticated USING ((hotel_id IN ( SELECT hotels.hotel_id
   FROM public.hotels
  WHERE (hotels.admin_id = auth.uid()))));


--
-- Name: hotels; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.hotels ENABLE ROW LEVEL SECURITY;

--
-- Name: hotels hotels_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotels_delete_policy ON public.hotels FOR DELETE TO authenticated USING ((admin_id = auth.uid()));


--
-- Name: hotels hotels_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotels_insert_policy ON public.hotels FOR INSERT TO authenticated WITH CHECK ((admin_id = auth.uid()));


--
-- Name: hotels hotels_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotels_select_policy ON public.hotels FOR SELECT USING (true);


--
-- Name: hotels hotels_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY hotels_update_policy ON public.hotels FOR UPDATE TO authenticated USING ((admin_id = auth.uid()));


--
-- Name: reservations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;

--
-- Name: reservations reservations_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reservations_delete_policy ON public.reservations FOR DELETE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: reservations reservations_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reservations_insert_policy ON public.reservations FOR INSERT TO authenticated WITH CHECK ((user_id = auth.uid()));


--
-- Name: reservations reservations_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reservations_select_policy ON public.reservations FOR SELECT TO authenticated USING ((user_id = auth.uid()));


--
-- Name: reservations reservations_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reservations_update_policy ON public.reservations FOR UPDATE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: restaurants; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.restaurants ENABLE ROW LEVEL SECURITY;

--
-- Name: restaurants restaurants_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY restaurants_select_policy ON public.restaurants FOR SELECT USING (true);


--
-- Name: reviews; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

--
-- Name: reviews reviews_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reviews_delete_policy ON public.reviews FOR DELETE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: reviews reviews_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reviews_insert_policy ON public.reviews FOR INSERT TO authenticated WITH CHECK ((user_id = auth.uid()));


--
-- Name: reviews reviews_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reviews_select_policy ON public.reviews FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: reviews reviews_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY reviews_update_policy ON public.reviews FOR UPDATE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: tour_announcements; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tour_announcements ENABLE ROW LEVEL SECURITY;

--
-- Name: tour_announcements tour_announcements_delete_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tour_announcements_delete_policy ON public.tour_announcements FOR DELETE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: tour_announcements tour_announcements_insert_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tour_announcements_insert_policy ON public.tour_announcements FOR INSERT TO authenticated WITH CHECK ((user_id = auth.uid()));


--
-- Name: tour_announcements tour_announcements_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tour_announcements_select_policy ON public.tour_announcements FOR SELECT TO authenticated USING ((user_id = auth.uid()));


--
-- Name: tour_announcements tour_announcements_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY tour_announcements_update_policy ON public.tour_announcements FOR UPDATE TO authenticated USING ((user_id = auth.uid()));


--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: users users_select_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_select_policy ON public.users FOR SELECT TO authenticated USING (true);


--
-- Name: users users_update_policy; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_update_policy ON public.users FOR UPDATE USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Allow authenticated users to upload images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated users to upload images" ON storage.objects FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- Name: objects Allow public read; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public read" ON storage.objects FOR SELECT USING ((bucket_id = 'Restaurants_photos'::text));


--
-- Name: objects Allow public read access; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public read access" ON storage.objects FOR SELECT USING ((bucket_id = 'Restaurants_photos'::text));


--
-- Name: objects Allow public uploads to Restaurants_photos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public uploads to Restaurants_photos" ON storage.objects FOR INSERT WITH CHECK ((bucket_id = 'Restaurants_photos'::text));


--
-- Name: objects Allow restaurant images upload; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow restaurant images upload" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'Restaurants_photos'::text));


--
-- Name: objects Allow upload; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow upload" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'Restaurants_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- Name: objects Allow user uploads; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow user uploads" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'Restaurants_photos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text) AND ((storage.foldername(name))[2] = 'menus'::text)));


--
-- Name: objects Authenticated users can upload; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authenticated users can upload" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'Restaurants_photos'::text));


--
-- Name: objects Tour photos upload; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Tour photos upload" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'tour_photos'::text) AND (EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.user_id = auth.uid()) AND (users.role = 'tour_organizer'::text))))));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION check_reservation_fk(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_reservation_fk() TO anon;
GRANT ALL ON FUNCTION public.check_reservation_fk() TO authenticated;
GRANT ALL ON FUNCTION public.check_reservation_fk() TO service_role;


--
-- Name: FUNCTION delete_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_user() TO anon;
GRANT ALL ON FUNCTION public.delete_user() TO authenticated;
GRANT ALL ON FUNCTION public.delete_user() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text) TO anon;
GRANT ALL ON FUNCTION public.insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text) TO authenticated;
GRANT ALL ON FUNCTION public.insert_reservation(p_user_id uuid, p_reservation_type text, p_reservation_type_id uuid, p_number_of_people integer, p_special_request text) TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE hotel_offers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hotel_offers TO anon;
GRANT ALL ON TABLE public.hotel_offers TO authenticated;
GRANT ALL ON TABLE public.hotel_offers TO service_role;


--
-- Name: TABLE hotel_services; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hotel_services TO anon;
GRANT ALL ON TABLE public.hotel_services TO authenticated;
GRANT ALL ON TABLE public.hotel_services TO service_role;


--
-- Name: TABLE hotels; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hotels TO anon;
GRANT ALL ON TABLE public.hotels TO authenticated;
GRANT ALL ON TABLE public.hotels TO service_role;


--
-- Name: TABLE reservations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reservations TO anon;
GRANT ALL ON TABLE public.reservations TO authenticated;
GRANT ALL ON TABLE public.reservations TO service_role;


--
-- Name: TABLE restaurants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.restaurants TO anon;
GRANT ALL ON TABLE public.restaurants TO authenticated;
GRANT ALL ON TABLE public.restaurants TO service_role;


--
-- Name: TABLE reviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reviews TO anon;
GRANT ALL ON TABLE public.reviews TO authenticated;
GRANT ALL ON TABLE public.reviews TO service_role;


--
-- Name: TABLE tour_announcements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tour_announcements TO anon;
GRANT ALL ON TABLE public.tour_announcements TO authenticated;
GRANT ALL ON TABLE public.tour_announcements TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

