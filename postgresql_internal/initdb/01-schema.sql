CREATE TABLE IF NOT EXISTS public.keywords
(
    keyword_id BIGSERIAL NOT NULL,
    keyword_text text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT keywords_pkey PRIMARY KEY (keyword_id),
    CONSTRAINT keywords_keyword_text_key UNIQUE (keyword_text)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keywords
    OWNER to admin;
-- Index: idx_keyword_text

-- DROP INDEX IF EXISTS public.idx_keyword_text;

CREATE INDEX IF NOT EXISTS idx_keyword_text
    ON public.keywords USING btree
    (keyword_text COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: keywords_hash_idx

-- DROP INDEX IF EXISTS public.keywords_hash_idx;

CREATE INDEX IF NOT EXISTS keywords_hash_idx
    ON public.keywords USING hash
    (keyword_id)
    TABLESPACE pg_default;
-- Index: keywords_hash_textx

-- DROP INDEX IF EXISTS public.keywords_hash_textx;

CREATE INDEX IF NOT EXISTS keywords_hash_textx
    ON public.keywords USING hash
    (keyword_text COLLATE pg_catalog."default")
    TABLESPACE pg_default;

CREATE TABLE IF NOT EXISTS public.keyword_products
(
    keyword_id BIGSERIAL NOT NULL,
    product_id bigint NOT NULL,
    CONSTRAINT keyword_product_partitioned_pkey PRIMARY KEY (keyword_id, product_id)
) PARTITION BY HASH (product_id);

ALTER TABLE IF EXISTS public.keyword_products
    OWNER to admin;

CREATE INDEX IF NOT EXISTS keyword_product_product_idx
    ON public.keyword_products USING hash
    (product_id)
;


CREATE TABLE public.keyword_product_p0 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 0)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p0
    OWNER to admin;
CREATE TABLE public.keyword_product_p1 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 1)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p1
    OWNER to admin;
CREATE TABLE public.keyword_product_p10 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 10)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p10
    OWNER to admin;
CREATE TABLE public.keyword_product_p11 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 11)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p11
    OWNER to admin;
CREATE TABLE public.keyword_product_p12 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 12)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p12
    OWNER to admin;
CREATE TABLE public.keyword_product_p13 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 13)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p13
    OWNER to admin;
CREATE TABLE public.keyword_product_p14 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 14)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p14
    OWNER to admin;
CREATE TABLE public.keyword_product_p15 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 15)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p15
    OWNER to admin;
CREATE TABLE public.keyword_product_p16 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 16)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p16
    OWNER to admin;
CREATE TABLE public.keyword_product_p17 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 17)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p17
    OWNER to admin;
CREATE TABLE public.keyword_product_p18 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 18)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p18
    OWNER to admin;
CREATE TABLE public.keyword_product_p19 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 19)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p19
    OWNER to admin;
CREATE TABLE public.keyword_product_p2 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 2)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p2
    OWNER to admin;
CREATE TABLE public.keyword_product_p20 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 20)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p20
    OWNER to admin;
CREATE TABLE public.keyword_product_p21 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 21)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p21
    OWNER to admin;
CREATE TABLE public.keyword_product_p22 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 22)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p22
    OWNER to admin;
CREATE TABLE public.keyword_product_p23 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 23)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p23
    OWNER to admin;
CREATE TABLE public.keyword_product_p24 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 24)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p24
    OWNER to admin;
CREATE TABLE public.keyword_product_p25 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 25)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p25
    OWNER to admin;
CREATE TABLE public.keyword_product_p26 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 26)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p26
    OWNER to admin;
CREATE TABLE public.keyword_product_p27 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 27)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p27
    OWNER to admin;
CREATE TABLE public.keyword_product_p28 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 28)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p28
    OWNER to admin;
CREATE TABLE public.keyword_product_p29 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 29)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p29
    OWNER to admin;
CREATE TABLE public.keyword_product_p3 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 3)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p3
    OWNER to admin;
CREATE TABLE public.keyword_product_p30 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 30)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p30
    OWNER to admin;
CREATE TABLE public.keyword_product_p31 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 31)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p31
    OWNER to admin;
CREATE TABLE public.keyword_product_p32 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 32)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p32
    OWNER to admin;
CREATE TABLE public.keyword_product_p4 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 4)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p4
    OWNER to admin;
CREATE TABLE public.keyword_product_p5 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 5)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p5
    OWNER to admin;
CREATE TABLE public.keyword_product_p6 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 6)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p6
    OWNER to admin;
CREATE TABLE public.keyword_product_p7 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 7)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p7
    OWNER to admin;
CREATE TABLE public.keyword_product_p8 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 8)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p8
    OWNER to admin;
CREATE TABLE public.keyword_product_p9 PARTITION OF public.keyword_products
    FOR VALUES WITH (modulus 33, remainder 9)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.keyword_product_p9
    OWNER to admin;

-- ALTER TABLE keyword_product SET (
--     parallel_workers = 4, 
--     autovacuum_analyze_scale_factor = 0, 
--     autovacuum_vacuum_scale_factor = 0
-- );

CREATE OR REPLACE FUNCTION get_product_keywords(p_product_id INT)
RETURNS TABLE(keyword_text TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT k.keyword_text
    FROM public.keyword_products kp
    JOIN public.keywords k ON k.keyword_id = kp.keyword_id
    WHERE kp.product_id = p_product_id
    LIMIT 30;
END;
$$ LANGUAGE plpgsql;
