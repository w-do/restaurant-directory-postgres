-- schema

CREATE TABLE public.city
(
    id uuid NOT NULL,
    name character varying(128) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT city_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.city
    OWNER to postgres;

CREATE TABLE public.cuisine
(
    id uuid NOT NULL,
    name character varying(128) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cuisine_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.cuisine
    OWNER to postgres;

CREATE TABLE public.restaurant
(
    id uuid NOT NULL,
    city_id uuid,
    name character varying(128) COLLATE pg_catalog."default" NOT NULL,
    notes character varying(1024) COLLATE pg_catalog."default",
    parking_lot integer,
    tried boolean NOT NULL,
    yelp character varying(512) COLLATE pg_catalog."default",
    CONSTRAINT restaurant_pkey PRIMARY KEY (id),
    CONSTRAINT restaurant__city__city_id FOREIGN KEY (city_id)
        REFERENCES public.city (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE public.restaurant
    OWNER to postgres;

CREATE TABLE public.restaurant_x_cuisine
(
    cuisine_id uuid NOT NULL,
    restaurant_id uuid NOT NULL,
    CONSTRAINT restaurant_x_cuisine_pkey PRIMARY KEY (cuisine_id, restaurant_id),
    CONSTRAINT restaurant_x_cuisine__cuisine__cuisine_id FOREIGN KEY (cuisine_id)
        REFERENCES public.cuisine (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT restaurant_x_cuisine__restaurant_restaurant_id FOREIGN KEY (restaurant_id)
        REFERENCES public.restaurant (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public.restaurant_x_cuisine
    OWNER to postgres;

-- seed data

INSERT INTO city
VALUES
    ('4e218695-7402-4627-ae9e-a9fb600e34b3', 'Ypsilanti'),
    ('a72fc62b-1e31-4ed3-b2da-218869f056d5', 'Dearborn'),
    ('aa662a98-518c-4155-bcc6-b68fca83c111', 'Ann Arbor');

INSERT INTO cuisine
VALUES
    ('d19cd0ba-2210-4b83-a76c-86a90bddac47', 'Middle Eastern'),
    ('15ab3dd0-0893-4187-a3d3-d8c5efdf4cff', 'Korean'),
    ('6b6ababb-ee05-4747-bac4-c1ac048a8fda', 'Mexican'),
    ('4dec8b4f-0e2d-4b9d-8bf9-4718f096b46f', 'Syrian'),
    ('8258bbe6-1f19-48ec-83a7-a5afdb95fb24', 'Yemeni'),
    ('5ad96fdf-bdfa-451a-8518-0b741765e186', 'Chinese');

INSERT INTO restaurant
VALUES
    ('0918c514-f10c-4dc6-94ee-51a4a61c2571', '4e218695-7402-4627-ae9e-a9fb600e34b3', 'Lan City Handpulled Noodles', null, 1, false, 'https://www.yelp.com/biz/lan-city-handpulled-noodles-ypsilanti'),
    ('22646d94-08ab-4d69-b399-e7e249060e59', '4e218695-7402-4627-ae9e-a9fb600e34b3', 'Yee Siang Dumplings', null, 1, true, 'https://www.yelp.com/biz/yee-siang-dumplings-ann-arbor'),
    ('460b847b-7614-458c-83c5-f4e85d0cb86f', '4e218695-7402-4627-ae9e-a9fb600e34b3', 'Haifa Falafel', null, 1, true, 'https://www.yelp.com/biz/haifa-falafel-ann-arbor'),
    ('70ac2872-08e7-4806-8675-2841b87a35f4', 'aa662a98-518c-4155-bcc6-b68fca83c111', 'Yoon''s Bakery', 'custard bread', null, true, 'https://www.yelp.com/biz/yoons-bakery-ann-arbor'),
    ('93627751-d6c4-4a59-9661-a7192a6a7fef', 'a72fc62b-1e31-4ed3-b2da-218869f056d5', 'Mocha cafe', null, null, false, null),
    ('95ddecbb-f0f0-49e7-8b5a-b691adf4a726', '4e218695-7402-4627-ae9e-a9fb600e34b3', 'Maiz', null, 0, true, 'https://www.yelp.com/biz/minys-mexican-restaurant-ypsilanti'),
    ('adbd63b2-04c0-4433-802a-82b20a3a3be8', 'aa662a98-518c-4155-bcc6-b68fca83c111', 'Zingerman''s Delicatessen', null, 0, true, null),
    ('bfd81fe1-f081-461e-bb2b-419d747e705f', 'aa662a98-518c-4155-bcc6-b68fca83c111', 'Hola Seoul', null, null, true, null),
    ('cd6ef927-6404-4edd-81bb-7863e1e34234', 'aa662a98-518c-4155-bcc6-b68fca83c111', 'Seoul Street', null, 2, false, null),
    ('e2e2b579-984e-44b3-b9de-1e34cfd8c1b0', 'a72fc62b-1e31-4ed3-b2da-218869f056d5', 'Hamido', null, null, true, null),
    ('ffe346be-c9b6-4501-8374-cffa3da4d741', 'aa662a98-518c-4155-bcc6-b68fca83c111', 'Syrian Cuisine & Exotic Bakeries', null, 1, false, 'https://www.yelp.com/biz/syrian-cuisine-and-exotic-bakeries-ann-arbor');

INSERT INTO restaurant_x_cuisine
VALUES
    ('15ab3dd0-0893-4187-a3d3-d8c5efdf4cff', 'bfd81fe1-f081-461e-bb2b-419d747e705f'),
    ('15ab3dd0-0893-4187-a3d3-d8c5efdf4cff', 'cd6ef927-6404-4edd-81bb-7863e1e34234'),
    ('4dec8b4f-0e2d-4b9d-8bf9-4718f096b46f', 'ffe346be-c9b6-4501-8374-cffa3da4d741'),
    ('5ad96fdf-bdfa-451a-8518-0b741765e186', '0918c514-f10c-4dc6-94ee-51a4a61c2571'),
    ('5ad96fdf-bdfa-451a-8518-0b741765e186', '22646d94-08ab-4d69-b399-e7e249060e59'),
    ('6b6ababb-ee05-4747-bac4-c1ac048a8fda', '95ddecbb-f0f0-49e7-8b5a-b691adf4a726'),
    ('6b6ababb-ee05-4747-bac4-c1ac048a8fda', 'bfd81fe1-f081-461e-bb2b-419d747e705f'),
    ('8258bbe6-1f19-48ec-83a7-a5afdb95fb24', '93627751-d6c4-4a59-9661-a7192a6a7fef'),
    ('d19cd0ba-2210-4b83-a76c-86a90bddac47', '460b847b-7614-458c-83c5-f4e85d0cb86f'),
    ('d19cd0ba-2210-4b83-a76c-86a90bddac47', 'e2e2b579-984e-44b3-b9de-1e34cfd8c1b0');
