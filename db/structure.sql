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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comfy_cms_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_blocks (
    id integer NOT NULL,
    identifier character varying NOT NULL,
    content text,
    blockable_type character varying,
    blockable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comfy_cms_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_blocks_id_seq OWNED BY public.comfy_cms_blocks.id;


--
-- Name: comfy_cms_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_categories (
    id integer NOT NULL,
    site_id integer NOT NULL,
    label character varying NOT NULL,
    categorized_type character varying NOT NULL
);


--
-- Name: comfy_cms_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_categories_id_seq OWNED BY public.comfy_cms_categories.id;


--
-- Name: comfy_cms_categorizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_categorizations (
    id integer NOT NULL,
    category_id integer NOT NULL,
    categorized_type character varying NOT NULL,
    categorized_id integer NOT NULL
);


--
-- Name: comfy_cms_categorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_categorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_categorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_categorizations_id_seq OWNED BY public.comfy_cms_categorizations.id;


--
-- Name: comfy_cms_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_files (
    id integer NOT NULL,
    site_id integer NOT NULL,
    block_id integer,
    label character varying NOT NULL,
    file_file_name character varying NOT NULL,
    file_content_type character varying NOT NULL,
    file_file_size integer NOT NULL,
    description character varying(2048),
    "position" integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comfy_cms_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_files_id_seq OWNED BY public.comfy_cms_files.id;


--
-- Name: comfy_cms_layouts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_layouts (
    id integer NOT NULL,
    site_id integer NOT NULL,
    parent_id integer,
    app_layout character varying,
    label character varying NOT NULL,
    identifier character varying NOT NULL,
    content text,
    css text,
    js text,
    "position" integer DEFAULT 0 NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comfy_cms_layouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_layouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_layouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_layouts_id_seq OWNED BY public.comfy_cms_layouts.id;


--
-- Name: comfy_cms_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_pages (
    id integer NOT NULL,
    site_id integer NOT NULL,
    layout_id integer,
    parent_id integer,
    target_page_id integer,
    label character varying NOT NULL,
    slug character varying,
    full_path character varying NOT NULL,
    content_cache text,
    "position" integer DEFAULT 0 NOT NULL,
    children_count integer DEFAULT 0 NOT NULL,
    is_published boolean DEFAULT true NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comfy_cms_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_pages_id_seq OWNED BY public.comfy_cms_pages.id;


--
-- Name: comfy_cms_revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_revisions (
    id integer NOT NULL,
    record_type character varying NOT NULL,
    record_id integer NOT NULL,
    data text,
    created_at timestamp without time zone
);


--
-- Name: comfy_cms_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_revisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_revisions_id_seq OWNED BY public.comfy_cms_revisions.id;


--
-- Name: comfy_cms_sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_sites (
    id integer NOT NULL,
    label character varying NOT NULL,
    identifier character varying NOT NULL,
    hostname character varying NOT NULL,
    path character varying,
    locale character varying DEFAULT 'en'::character varying NOT NULL,
    is_mirrored boolean DEFAULT false NOT NULL
);


--
-- Name: comfy_cms_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_sites_id_seq OWNED BY public.comfy_cms_sites.id;


--
-- Name: comfy_cms_snippets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comfy_cms_snippets (
    id integer NOT NULL,
    site_id integer NOT NULL,
    label character varying NOT NULL,
    identifier character varying NOT NULL,
    content text,
    "position" integer DEFAULT 0 NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comfy_cms_snippets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comfy_cms_snippets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comfy_cms_snippets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comfy_cms_snippets_id_seq OWNED BY public.comfy_cms_snippets.id;


--
-- Name: entry_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entry_owners (
    old_id integer,
    old_price_entry_id integer,
    old_shopper_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    price_entry_id uuid,
    shopper_id uuid
);


--
-- Name: entry_owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entry_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entry_owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entry_owners_id_seq OWNED BY public.entry_owners.old_id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invites (
    old_id integer,
    old_price_book_id integer,
    name character varying,
    email character varying,
    status character varying DEFAULT 'sent'::character varying NOT NULL,
    token character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    price_book_id uuid
);


--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invites_id_seq OWNED BY public.invites.old_id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.members (
    old_id integer,
    old_price_book_id integer,
    old_shopper_id integer,
    admin boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    price_book_id uuid,
    shopper_id uuid
);


--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.members_id_seq OWNED BY public.members.old_id;


--
-- Name: price_book_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_book_pages (
    old_id integer,
    name character varying,
    category character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_names text[] DEFAULT '{}'::text[],
    unit character varying,
    old_price_book_id integer,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    price_book_id uuid
);


--
-- Name: price_book_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_book_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: price_book_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_book_pages_id_seq OWNED BY public.price_book_pages.old_id;


--
-- Name: price_books; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_books (
    old_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying DEFAULT 'My Price Book'::character varying NOT NULL,
    region_codes character varying[] DEFAULT '{}'::character varying[],
    old_store_ids integer[] DEFAULT '{}'::integer[],
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    store_ids uuid[] DEFAULT '{}'::uuid[]
);


--
-- Name: price_books_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: price_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_books_id_seq OWNED BY public.price_books.old_id;


--
-- Name: price_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_entries (
    old_id integer,
    date_on date NOT NULL,
    old_store_id integer,
    product_name character varying NOT NULL,
    amount integer NOT NULL,
    package_size integer NOT NULL,
    package_unit character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    total_price money NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    store_id uuid
);


--
-- Name: price_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: price_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_entries_id_seq OWNED BY public.price_entries.old_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shoppers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shoppers (
    old_id integer,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    guest boolean DEFAULT false NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


--
-- Name: shoppers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shoppers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shoppers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shoppers_id_seq OWNED BY public.shoppers.old_id;


--
-- Name: shopping_list_item_purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shopping_list_item_purchases (
    old_id integer,
    old_shopping_list_item_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    shopping_list_item_id uuid
);


--
-- Name: shopping_list_item_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shopping_list_item_purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shopping_list_item_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shopping_list_item_purchases_id_seq OWNED BY public.shopping_list_item_purchases.old_id;


--
-- Name: shopping_list_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shopping_list_items (
    old_id integer,
    old_shopping_list_id integer,
    name character varying,
    amount integer DEFAULT 1 NOT NULL,
    unit character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    shopping_list_id uuid
);


--
-- Name: shopping_list_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shopping_list_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shopping_list_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shopping_list_items_id_seq OWNED BY public.shopping_list_items.old_id;


--
-- Name: shopping_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shopping_lists (
    old_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying,
    old_price_book_id integer,
    price_book_id uuid,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


--
-- Name: shopping_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shopping_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shopping_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shopping_lists_id_seq OWNED BY public.shopping_lists.old_id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stores (
    old_id integer,
    name character varying NOT NULL,
    location character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    region_code character varying NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.old_id;


--
-- Name: comfy_cms_blocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_blocks ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_blocks_id_seq'::regclass);


--
-- Name: comfy_cms_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_categories ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_categories_id_seq'::regclass);


--
-- Name: comfy_cms_categorizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_categorizations ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_categorizations_id_seq'::regclass);


--
-- Name: comfy_cms_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_files ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_files_id_seq'::regclass);


--
-- Name: comfy_cms_layouts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_layouts ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_layouts_id_seq'::regclass);


--
-- Name: comfy_cms_pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_pages ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_pages_id_seq'::regclass);


--
-- Name: comfy_cms_revisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_revisions ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_revisions_id_seq'::regclass);


--
-- Name: comfy_cms_sites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_sites ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_sites_id_seq'::regclass);


--
-- Name: comfy_cms_snippets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_snippets ALTER COLUMN id SET DEFAULT nextval('public.comfy_cms_snippets_id_seq'::regclass);


--
-- Name: entry_owners old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entry_owners ALTER COLUMN old_id SET DEFAULT nextval('public.entry_owners_id_seq'::regclass);


--
-- Name: invites old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invites ALTER COLUMN old_id SET DEFAULT nextval('public.invites_id_seq'::regclass);


--
-- Name: members old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members ALTER COLUMN old_id SET DEFAULT nextval('public.members_id_seq'::regclass);


--
-- Name: price_book_pages old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_book_pages ALTER COLUMN old_id SET DEFAULT nextval('public.price_book_pages_id_seq'::regclass);


--
-- Name: price_books old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_books ALTER COLUMN old_id SET DEFAULT nextval('public.price_books_id_seq'::regclass);


--
-- Name: price_entries old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_entries ALTER COLUMN old_id SET DEFAULT nextval('public.price_entries_id_seq'::regclass);


--
-- Name: shoppers old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shoppers ALTER COLUMN old_id SET DEFAULT nextval('public.shoppers_id_seq'::regclass);


--
-- Name: shopping_list_item_purchases old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_list_item_purchases ALTER COLUMN old_id SET DEFAULT nextval('public.shopping_list_item_purchases_id_seq'::regclass);


--
-- Name: shopping_list_items old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_list_items ALTER COLUMN old_id SET DEFAULT nextval('public.shopping_list_items_id_seq'::regclass);


--
-- Name: shopping_lists old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_lists ALTER COLUMN old_id SET DEFAULT nextval('public.shopping_lists_id_seq'::regclass);


--
-- Name: stores old_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores ALTER COLUMN old_id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comfy_cms_blocks comfy_cms_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_blocks
    ADD CONSTRAINT comfy_cms_blocks_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_categories comfy_cms_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_categories
    ADD CONSTRAINT comfy_cms_categories_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_categorizations comfy_cms_categorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_categorizations
    ADD CONSTRAINT comfy_cms_categorizations_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_files comfy_cms_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_files
    ADD CONSTRAINT comfy_cms_files_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_layouts comfy_cms_layouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_layouts
    ADD CONSTRAINT comfy_cms_layouts_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_pages comfy_cms_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_pages
    ADD CONSTRAINT comfy_cms_pages_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_revisions comfy_cms_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_revisions
    ADD CONSTRAINT comfy_cms_revisions_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_sites comfy_cms_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_sites
    ADD CONSTRAINT comfy_cms_sites_pkey PRIMARY KEY (id);


--
-- Name: comfy_cms_snippets comfy_cms_snippets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comfy_cms_snippets
    ADD CONSTRAINT comfy_cms_snippets_pkey PRIMARY KEY (id);


--
-- Name: entry_owners entry_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entry_owners
    ADD CONSTRAINT entry_owners_pkey PRIMARY KEY (id);


--
-- Name: invites invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: price_book_pages price_book_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_book_pages
    ADD CONSTRAINT price_book_pages_pkey PRIMARY KEY (id);


--
-- Name: price_books price_books_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_books
    ADD CONSTRAINT price_books_pkey PRIMARY KEY (id);


--
-- Name: price_entries price_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_entries
    ADD CONSTRAINT price_entries_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shoppers shoppers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shoppers
    ADD CONSTRAINT shoppers_pkey PRIMARY KEY (id);


--
-- Name: shopping_list_item_purchases shopping_list_item_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_list_item_purchases
    ADD CONSTRAINT shopping_list_item_purchases_pkey PRIMARY KEY (id);


--
-- Name: shopping_list_items shopping_list_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_list_items
    ADD CONSTRAINT shopping_list_items_pkey PRIMARY KEY (id);


--
-- Name: shopping_lists shopping_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT shopping_lists_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: index_cms_categories_on_site_id_and_cat_type_and_label; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_cms_categories_on_site_id_and_cat_type_and_label ON public.comfy_cms_categories USING btree (site_id, categorized_type, label);


--
-- Name: index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id ON public.comfy_cms_categorizations USING btree (category_id, categorized_type, categorized_id);


--
-- Name: index_cms_revisions_on_rtype_and_rid_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cms_revisions_on_rtype_and_rid_and_created_at ON public.comfy_cms_revisions USING btree (record_type, record_id, created_at);


--
-- Name: index_comfy_cms_blocks_on_blockable_id_and_blockable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_blocks_on_blockable_id_and_blockable_type ON public.comfy_cms_blocks USING btree (blockable_id, blockable_type);


--
-- Name: index_comfy_cms_blocks_on_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_blocks_on_identifier ON public.comfy_cms_blocks USING btree (identifier);


--
-- Name: index_comfy_cms_files_on_site_id_and_block_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_files_on_site_id_and_block_id ON public.comfy_cms_files USING btree (site_id, block_id);


--
-- Name: index_comfy_cms_files_on_site_id_and_file_file_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_files_on_site_id_and_file_file_name ON public.comfy_cms_files USING btree (site_id, file_file_name);


--
-- Name: index_comfy_cms_files_on_site_id_and_label; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_files_on_site_id_and_label ON public.comfy_cms_files USING btree (site_id, label);


--
-- Name: index_comfy_cms_files_on_site_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_files_on_site_id_and_position ON public.comfy_cms_files USING btree (site_id, "position");


--
-- Name: index_comfy_cms_layouts_on_parent_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_layouts_on_parent_id_and_position ON public.comfy_cms_layouts USING btree (parent_id, "position");


--
-- Name: index_comfy_cms_layouts_on_site_id_and_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_comfy_cms_layouts_on_site_id_and_identifier ON public.comfy_cms_layouts USING btree (site_id, identifier);


--
-- Name: index_comfy_cms_pages_on_parent_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_pages_on_parent_id_and_position ON public.comfy_cms_pages USING btree (parent_id, "position");


--
-- Name: index_comfy_cms_pages_on_site_id_and_full_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_pages_on_site_id_and_full_path ON public.comfy_cms_pages USING btree (site_id, full_path);


--
-- Name: index_comfy_cms_sites_on_hostname; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_sites_on_hostname ON public.comfy_cms_sites USING btree (hostname);


--
-- Name: index_comfy_cms_sites_on_is_mirrored; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_sites_on_is_mirrored ON public.comfy_cms_sites USING btree (is_mirrored);


--
-- Name: index_comfy_cms_snippets_on_site_id_and_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_comfy_cms_snippets_on_site_id_and_identifier ON public.comfy_cms_snippets USING btree (site_id, identifier);


--
-- Name: index_comfy_cms_snippets_on_site_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comfy_cms_snippets_on_site_id_and_position ON public.comfy_cms_snippets USING btree (site_id, "position");


--
-- Name: index_entry_owners_on_old_price_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entry_owners_on_old_price_entry_id ON public.entry_owners USING btree (old_price_entry_id);


--
-- Name: index_entry_owners_on_old_shopper_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entry_owners_on_old_shopper_id ON public.entry_owners USING btree (old_shopper_id);


--
-- Name: index_entry_owners_on_price_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entry_owners_on_price_entry_id ON public.entry_owners USING btree (price_entry_id);


--
-- Name: index_entry_owners_on_shopper_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entry_owners_on_shopper_id ON public.entry_owners USING btree (shopper_id);


--
-- Name: index_invites_on_old_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invites_on_old_price_book_id ON public.invites USING btree (old_price_book_id);


--
-- Name: index_invites_on_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invites_on_price_book_id ON public.invites USING btree (price_book_id);


--
-- Name: index_invites_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invites_on_token ON public.invites USING btree (token);


--
-- Name: index_members_on_old_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_old_price_book_id ON public.members USING btree (old_price_book_id);


--
-- Name: index_members_on_old_shopper_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_old_shopper_id ON public.members USING btree (old_shopper_id);


--
-- Name: index_members_on_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_price_book_id ON public.members USING btree (price_book_id);


--
-- Name: index_members_on_shopper_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_members_on_shopper_id ON public.members USING btree (shopper_id);


--
-- Name: index_price_book_pages_on_old_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_book_pages_on_old_price_book_id ON public.price_book_pages USING btree (old_price_book_id);


--
-- Name: index_price_book_pages_on_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_book_pages_on_price_book_id ON public.price_book_pages USING btree (price_book_id);


--
-- Name: index_price_book_pages_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_book_pages_on_updated_at ON public.price_book_pages USING btree (updated_at);


--
-- Name: index_price_entries_on_date_on; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_entries_on_date_on ON public.price_entries USING btree (date_on);


--
-- Name: index_price_entries_on_old_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_entries_on_old_store_id ON public.price_entries USING btree (old_store_id);


--
-- Name: index_price_entries_on_package_unit; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_entries_on_package_unit ON public.price_entries USING btree (package_unit);


--
-- Name: index_price_entries_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_price_entries_on_store_id ON public.price_entries USING btree (store_id);


--
-- Name: index_shoppers_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_shoppers_on_confirmation_token ON public.shoppers USING btree (confirmation_token);


--
-- Name: index_shoppers_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shoppers_on_email ON public.shoppers USING btree (email);


--
-- Name: index_shoppers_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_shoppers_on_reset_password_token ON public.shoppers USING btree (reset_password_token);


--
-- Name: index_shopping_list_item_purchases_on_old_shopping_list_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_list_item_purchases_on_old_shopping_list_item_id ON public.shopping_list_item_purchases USING btree (old_shopping_list_item_id);


--
-- Name: index_shopping_list_item_purchases_on_shopping_list_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_list_item_purchases_on_shopping_list_item_id ON public.shopping_list_item_purchases USING btree (shopping_list_item_id);


--
-- Name: index_shopping_list_items_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_list_items_on_created_at ON public.shopping_list_items USING btree (created_at);


--
-- Name: index_shopping_list_items_on_shopping_list_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_list_items_on_shopping_list_id ON public.shopping_list_items USING btree (shopping_list_id);


--
-- Name: index_shopping_lists_on_old_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_lists_on_old_price_book_id ON public.shopping_lists USING btree (old_price_book_id);


--
-- Name: index_shopping_lists_on_price_book_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shopping_lists_on_price_book_id ON public.shopping_lists USING btree (price_book_id);


--
-- Name: index_stores_on_region_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_region_code ON public.stores USING btree (region_code);


--
-- Name: price_entries_replace_lower_product_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_entries_replace_lower_product_name_idx ON public.price_entries USING btree (replace(lower((product_name)::text), ' '::text, ''::text));


--
-- Name: stores_replace_lower_loc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stores_replace_lower_loc_idx ON public.stores USING btree (replace(lower((location)::text), ' '::text, ''::text));


--
-- Name: stores_replace_lower_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stores_replace_lower_name_idx ON public.stores USING btree (replace(lower((name)::text), ' '::text, ''::text));


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20150515135324'),
('20150517163242'),
('20150526134610'),
('20150526162500'),
('20150602144258'),
('20150603150915'),
('20150623100624'),
('20150623133041'),
('20150703104544'),
('20150704110603'),
('20150704125425'),
('20150719122747'),
('20150722073017'),
('20150722133633'),
('20150722185828'),
('20150722191719'),
('20150728060734'),
('20150802092633'),
('20150804070800'),
('20150812211210'),
('20150825073302'),
('20150901184909'),
('20150913110243'),
('20150915112020'),
('20151018103303'),
('20151018104004'),
('20151018110108'),
('20160222063236'),
('20160315215629'),
('20160315220121'),
('20160321222045'),
('20160321225104'),
('20160325102353'),
('20160325104640'),
('20160325104938'),
('20160325113925'),
('20160325115200'),
('20160325122950'),
('20160328063823'),
('20160420201023'),
('20160422074848'),
('20160422074934'),
('20160422130026'),
('20160422132605'),
('20160422134223'),
('20160423082705'),
('20160423133138'),
('20160425061130'),
('20160426040101'),
('20160426060238'),
('20160427034514'),
('20160427044309'),
('20160427053838'),
('20160731065137'),
('20160813040420'),
('20160813051712'),
('20160907192939'),
('20160907193348'),
('20160907201400'),
('20160907201827'),
('20160907202420'),
('20160907203114'),
('20160907203447'),
('20160907213922'),
('20160907220016'),
('20160907221147'),
('20160907221341'),
('20160907222134'),
('20160907222903'),
('20160907223941');


