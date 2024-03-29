SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE users (
    id integer PRIMARY KEY,
    email character varying NOT NULL,
    crypted_password character varying,
    salt character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

INSERT INTO users (id, email, crypted_password, salt, created_at, updated_at)
VALUES (1, 'zarzont@ksi', '$2a$10$AOl9bCTjmycie9HZza9Cn.s9TjqYqZfogtCTVOuVjhQfSI0.7icl.', 'HighschoolDxD', NULL, NULL);

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE users_id_seq OWNED BY users.id;

CREATE TABLE roles (
    id integer PRIMARY KEY,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;

CREATE TABLE authors (
    id integer PRIMARY KEY,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;

CREATE TABLE members (
    id integer PRIMARY KEY,
    name character varying,
    surname character varying,
    email character varying,
    card_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE SEQUENCE members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE members_id_seq OWNED BY members.id;

CREATE FUNCTION is_period_correct (period character varying)
  RETURNS boolean AS
$$
BEGIN
  IF period SIMILAR TO '[0-9]{4}/[0-9]{4}' THEN
    IF cast(substring(period from 6 for 4) AS integer) - cast(substring(period from 1 for 4) AS integer) = 1 THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  ELSE
    RETURN FALSE;
  END IF;
END
$$ LANGUAGE plpgsql;

CREATE TABLE periods (
    id integer PRIMARY KEY,
    fee numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    info character varying,
    academic_year character varying CHECK (is_period_correct(academic_year))
);

CREATE SEQUENCE periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE periods_id_seq OWNED BY periods.id;

CREATE TABLE memberships (
    id integer PRIMARY KEY,
    fee_paid boolean,
    tshirt boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    member_id integer REFERENCES members,
    period_id integer REFERENCES periods,
    who_signed_up integer REFERENCES users
);

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;

CREATE TABLE comments (
    id integer PRIMARY KEY,
    text character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    membership_id integer REFERENCES memberships
);

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;

CREATE TABLE memberships_roles (
    membership_id integer REFERENCES memberships,
    role_id integer REFERENCES roles
);


CREATE TABLE publishing_houses (
    id integer PRIMARY KEY,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE SEQUENCE publishing_houses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE publishing_houses_id_seq OWNED BY publishing_houses.id;

CREATE TABLE books (
    id integer PRIMARY KEY,
    title character varying,
    year integer,
    available boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    publishing_house_id integer REFERENCES publishing_houses,
    author_id integer REFERENCES authors
);

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE books_id_seq OWNED BY books.id;

CREATE TABLE book_leases (
    id integer PRIMARY KEY,
    date_start timestamp without time zone,
    date_end timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    member_id integer REFERENCES members,
    active boolean,
    book_id integer REFERENCES books
);

CREATE SEQUENCE book_leases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE book_leases_id_seq OWNED BY book_leases.id;

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);
ALTER TABLE ONLY book_leases ALTER COLUMN id SET DEFAULT nextval('book_leases_id_seq'::regclass);
ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);
ALTER TABLE ONLY books ALTER COLUMN available SET DEFAULT true;
ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);
ALTER TABLE ONLY members ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);
ALTER TABLE ONLY memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);
ALTER TABLE ONLY periods ALTER COLUMN id SET DEFAULT nextval('periods_id_seq'::regclass);
ALTER TABLE ONLY publishing_houses ALTER COLUMN id SET DEFAULT nextval('publishing_houses_id_seq'::regclass);
ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);
ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);

CREATE INDEX index_book_leases_on_book_id ON book_leases USING btree (book_id);
CREATE INDEX index_book_leases_on_member_id ON book_leases USING btree (member_id);
CREATE INDEX index_books_on_author_id ON books USING btree (author_id);
CREATE INDEX index_books_on_publishing_house_id ON books USING btree (publishing_house_id);
CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);
 
SET search_path TO "$user",public;

CREATE FUNCTION get_academic_year_ending(year text)
  RETURNS date AS
$$
BEGIN
  RETURN CAST((substring(year from 6 for 4) || '-10-01') AS DATE);
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION get_academic_year_beginning(year text)
  RETURNS date AS
$$
BEGIN
  RETURN CAST((substring(year from 1 for 4) || '-10-01') AS DATE);
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION set_created_at()
  RETURNS TRIGGER AS
$$
BEGIN
  NEW.created_at := now();
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION set_updated_at()
  RETURNS TRIGGER AS
$$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION book_availability_update()
  RETURNS TRIGGER AS
$$
BEGIN
  update books set available=not NEW.active where id=NEW.book_id;
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION encrypt_password()
  RETURNS TRIGGER AS
$$
BEGIN
  NEW.salt := gen_salt('bf', 8);
  NEW.crypted_password := crypt(NEW.crypted_password, NEW.salt);
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION trim_member_email()
  RETURNS TRIGGER AS
$$
BEGIN
  NEW.email = trim(both from NEW.email);
  RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION delete_members_memebership()
  RETURNS TRIGGER AS
$$
DECLARE
  mid integer;
  msid integer;
BEGIN
  mid = OLD.id;
  msid = (select id from memberships where member_id=mid);
  delete from memberships_roles where membership_id=msid;
  delete from comments where membership_id=msid;
  delete from memberships where member_id=mid;
  return OLD;
END
$$ LANGUAGE plpgsql;


CREATE FUNCTION insert_member_with_membership (name character varying,
                                              surname character varying,
                                              email character varying,
                                              fee_paid boolean,
                                              tshirt boolean,
                                              period_id periods,
                                              who_signed_up integer)
  RETURNS VOID AS
$$
DECLARE
  member_id integer;
BEGIN
  INSERT INTO members (name, surname, email)
  VALUES (name, surname, email) RETURNING id INTO member_id;
  INSERT INTO memberships (fee_paid, tshirt, member_id, period_id, who_signed_up)
  VALUES (fee_paid, tshirt, member_id, period_id, who_signed_up);
END
$$ LANGUAGE plpgsql;

CREATE FUNCTION insert_book_with_publishinghouse_and_author (author_name character varying,title2 character varying,publishing_house_name character varying,year2 integer)
  RETURNS VOID AS
$$
DECLARE
  publishing_house_id integer;
  author_id integer;
BEGIN
  INSERT INTO publishing_houses (name, created_at, updated_at)
  VALUES (publishing_house_name, now(), now()) RETURNING id INTO publishing_house_id;
  INSERT INTO authors (name, created_at, updated_at)
  VALUES (author_name, now(), now()) RETURNING id INTO author_id;
  INSERT INTO books (title, publishing_house_id, author_id, year, created_at, updated_at)
  VALUES (title2, publishing_house_id, author_id, year2, now(), now());
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_member
BEFORE DELETE
  ON members
  FOR EACH ROW
  EXECUTE PROCEDURE delete_members_memebership();

CREATE TRIGGER update_creation_date
BEFORE UPDATE
  ON members
  FOR EACH ROW
  EXECUTE PROCEDURE set_updated_at();

CREATE TRIGGER update_update_date
BEFORE INSERT
  ON members
  FOR EACH ROW
  EXECUTE PROCEDURE set_created_at();

CREATE TRIGGER crypt_password
BEFORE UPDATE OR INSERT
  ON users
  FOR EACH ROW
  EXECUTE PROCEDURE encrypt_password();

CREATE TRIGGER trim_email
BEFORE UPDATE OR INSERT
  ON members
  FOR EACH ROW
  EXECUTE PROCEDURE trim_member_email();

CREATE TRIGGER book_lease_update
BEFORE UPDATE OR INSERT
  ON book_leases
  FOR EACH ROW
  EXECUTE PROCEDURE book_availability_update();

CREATE VIEW email_list AS
  SELECT (name || ' ' || surname) AS name, email  FROM members;

CREATE VIEW current_year_members AS
  SELECT members.id, name, surname, memberships.id AS membership_id
  FROM members
  JOIN memberships ON members.id = memberships.member_id
  JOIN periods ON periods.id = memberships.period_id
  WHERE (SELECT get_academic_year_ending(academic_year)) >= now()
  AND (SELECT get_academic_year_beginning(academic_year)) <= now();

CREATE VIEW registration_dow_statistics AS
  SELECT extract(DOW FROM memberships.created_at), COUNT(DISTINCT memberships.id)
  FROM members
  JOIN memberships ON members.id = memberships.member_id
  JOIN periods ON periods.id = memberships.period_id
  GROUP BY extract(DOW FROM memberships.created_at)
  ORDER BY extract(DOW FROM memberships.created_at) DESC;

CREATE VIEW undelivered_tshirts AS
  SELECT members.id, name, surname, memberships.id AS membership_id
  FROM members
  JOIN memberships ON members.id = memberships.member_id
  WHERE tshirt is false AND fee_paid is true;

CREATE VIEW unpaid_fees AS
  SELECT members.id, name, surname, memberships.id AS membership_id
  FROM members
  JOIN memberships ON members.id = memberships.member_id
  WHERE fee_paid is false;

CREATE VIEW honorable_members AS
  SELECT members.id, name, surname, COUNT(DISTINCT memberships.id)
  FROM members
  JOIN memberships ON members.id = memberships.member_id
  GROUP BY members.id
  ORDER BY COUNT(DISTINCT memberships.id);

CREATE FUNCTION email_string() RETURNS character varying AS $$
  DECLARE
    m character varying;
    member record;
  BEGIN
    FOR member IN SELECT name, email FROM email_list x(name, email)
    LOOP
      m := concat(m, member.name, ' <', member.email, '>; ');
    END LOOP;
    return substring(m from 0 for length(m)-1);
  END;
$$ LANGUAGE plpgsql;
