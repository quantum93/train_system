CREATE TABLE "trains" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT "trains_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);
CREATE TABLE "cities" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT "cities_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);
CREATE TABLE "stops" (
	"id" serial NOT NULL,
	"time" TIME NOT NULL,
	"city_id" int NOT NULL,
	"train_id" int NOT NULL,
	CONSTRAINT "stops_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "tickets" (
	"id" serial NOT NULL,
	"stop_id" int NOT NULL,
	CONSTRAINT "tickets_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);
ALTER TABLE "stops" ADD CONSTRAINT "stops_fk0" FOREIGN KEY ("city_id") REFERENCES "cities"("id");
ALTER TABLE "stops" ADD CONSTRAINT "stops_fk1" FOREIGN KEY ("train_id") REFERENCES "trains"("id");
ALTER TABLE "tickets" ADD CONSTRAINT "tickets_fk0" FOREIGN KEY ("stop_id") REFERENCES "stops"("id");
