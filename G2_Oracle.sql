
REM *******************************************************************
REM drop tables
REM *******************************************************************
DROP TABLE performance_date CASCADE CONSTRAINTS;
DROP TABLE reservation_performance CASCADE CONSTRAINTS;
DROP TABLE reservation_spectator CASCADE CONSTRAINTS;
DROP TABLE spectator CASCADE CONSTRAINTS;
DROP TABLE rehearsal CASCADE CONSTRAINTS;
DROP TABLE rehearsal_actor CASCADE CONSTRAINTS;
DROP TABLE location CASCADE CONSTRAINTS;
DROP TABLE performance CASCADE CONSTRAINTS;
DROP TABLE performance_actor CASCADE CONSTRAINTS;
DROP TABLE actor CASCADE CONSTRAINTS;
DROP TABLE zip_code CASCADE CONSTRAINTS;
DROP TABLE subscriber CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;

REM *******************************************************************
REM maak tabel performance aan

CREATE TABLE performance
	(theatre_performance VARCHAR2(30)
	,season DATE
	,producer VARCHAR2(30) NOT NULL
	,description VARCHAR2(200) NOT NULL
	,price_ticket NUMBER(6,2) 
	,CONSTRAINT per_pk 
		PRIMARY KEY(theatre_performance,season)
	);

REM *******************************************************************
REM maak tabel performance_date aan

CREATE TABLE performance_date
	(theatre_performance VARCHAR2(30)
	,date_time DATE
	,season DATE
	,CONSTRAINT perf_pk 
		PRIMARY KEY(theatre_performance, date_time)
	,CONSTRAINT perf_fk 
		FOREIGN KEY(theatre_performance,season)	
		REFERENCES performance(theatre_performance,season)
	);
REM *******************************************************************
REM maak tabel zip_code aan

	CREATE TABLE zip_code
	(zip_code NUMBER(4)
		CONSTRAINT zip_pk PRIMARY KEY
	,city VARCHAR2(25) NOT NULL
	);

REM *******************************************************************
REM maak tabel subscriber aan

CREATE TABLE subscriber
	(subscriber_id NUMBER(10)
		CONSTRAINT subscriber_pk  PRIMARY KEY
	,subscriber_name VARCHAR2(20)
	,subscriber_firstname VARCHAR2(20)
	,address VARCHAR2(30)
	,zip_code NUMBER(4)
	,telephone NUMBER(15)
	,email VARCHAR2(30)
	,CONSTRAINT sub_fk 
		FOREIGN KEY(zip_code) 
		REFERENCES zip_code(zip_code)
	);

REM *******************************************************************
REM maak tabel reservation aan

CREATE TABLE reservation
	(reservation_id NUMBER(10)
		CONSTRAINT res_pk PRIMARY KEY
	,subscriber_id NUMBER(10)
	,comments VARCHAR2(200)
	,CONSTRAINT res_fk 
		FOREIGN KEY(subscriber_id) 
		REFERENCES subscriber(subscriber_id)
	);

REM *******************************************************************
REM maak tabel reservation_performance aan

	CREATE TABLE reservation_performance
	(reservation_id NUMBER(10)
	,theatre_performance VARCHAR2(30)
	,date_time DATE
	,CONSTRAINT res_perf_pk 
		PRIMARY KEY(theatre_performance, date_time)
	,CONSTRAINT res_perf_res_fk
		FOREIGN KEY(reservation_id) 
		REFERENCES reservation 
	,CONSTRAINT res_perf_perf_date_fk
		FOREIGN KEY(theatre_performance, date_time) 
		REFERENCES performance_date 
	);

  

REM *******************************************************************
REM maak tabel spectator aan

CREATE TABLE spectator
	(spectator_id NUMBER(10)
		CONSTRAINT spec_id_pk PRIMARY KEY
	,spectator_name VARCHAR2(20)
		CONSTRAINT spec_name_nn NOT NULL
	,spectator_firstname VARCHAR2(20)
		CONSTRAINT spec_fname_nn NOT NULL
	);

REM *******************************************************************
REM maak tabel reservation_spectator aan

CREATE TABLE reservation_spectator
	(reservation_id NUMBER(10)
	,spectator_id NUMBER(10)
	,CONSTRAINT res_spec_pk 
		PRIMARY KEY(reservation_id, spectator_id)
	,CONSTRAINT res_perf_fk 
		FOREIGN KEY(reservation_id) 	
		REFERENCES reservation(reservation_id)
	,CONSTRAINT res_spect_fk 
		FOREIGN KEY(spectator_id)
		REFERENCES spectator(spectator_id)
	);

REM *******************************************************************
REM maak tabel location aan

CREATE TABLE location
	(location_id NUMBER(10)
		CONSTRAINT loc_pk PRIMARY KEY
	,address VARCHAR2(30)
	,zip_code number(4)
	,CONSTRAINT loc_fk 
		FOREIGN KEY(zip_code) 
		REFERENCES zip_code(zip_code)
	);
  
REM *******************************************************************
REM maak tabel rehearsal aan

CREATE TABLE rehearsal
	(theatre_performance VARCHAR2(30)
	,date_starttime DATE
	,location_id NUMBER(10) 
	,CONSTRAINT reh_pk 
		PRIMARY KEY(theatre_performance, date_starttime)
	,CONSTRAINT reh_fk 
		FOREIGN KEY(location_id) 
		REFERENCES location(location_id)
	);

REM *******************************************************************
REM maak tabel actor aan

CREATE TABLE actor
	(actor_id NUMBER(10)
		CONSTRAINT act_id_pk PRIMARY KEY
	,actor_name VARCHAR2(20) NOT NULL
	,actor_firstname VARCHAR2(20) NOT NULL
	,known_from VARCHAR2(30)
	);

REM *******************************************************************
REM maak tabel rehearsal_actor aan

CREATE TABLE rehearsal_actor
	(date_starttime DATE
	,actor_id NUMBER(10)
	,theatre_performance VARCHAR2(30)
	,CONSTRAINT reh_actor_pk 
		PRIMARY KEY(date_starttime, actor_id)
	,CONSTRAINT reh_actor_id_fk 
		FOREIGN KEY(actor_id) 
		REFERENCES actor(actor_id)
	,CONSTRAINT reh_th_per_fk 
		FOREIGN KEY(theatre_performance,date_starttime) 
		REFERENCES rehearsal(theatre_performance,date_starttime)
	);

REM *******************************************************************
REM maak tabel performance_actor aan

CREATE TABLE performance_actor
	(theatre_performance VARCHAR2(30)
	,season DATE
	,actor_id NUMBER(10)
	,CONSTRAINT per_act_pk 
		PRIMARY KEY(theatre_performance, season, actor_id)
	,CONSTRAINT act_id_fk 
		FOREIGN KEY(actor_id) 	
		REFERENCES actor(actor_id)
	,CONSTRAINT per_season__fk 
		FOREIGN KEY(theatre_performance,season) 
		REFERENCES performance(theatre_performance,season)
	);





