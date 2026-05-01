-- ============================================================
-- 01_dimensions.sql  —  Tablas de dimensiones
-- Proyecto: Telemetría aeroespacial | Compatible con Snowflake
-- Cobertura temporal: 2024-01-01 → 2024-06-30 (182 días, Q1+Q2)
-- Orden de ejecución: este fichero primero
-- ============================================================

-- ------------------------------------------------------------
-- DIM_DATE  (clave YYYYMMDD como INT — estándar DW)
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_DATE (
    DATE_KEY      INT          NOT NULL PRIMARY KEY,
    FULL_DATE     DATE         NOT NULL,
    YEAR          INT          NOT NULL,
    QUARTER       INT          NOT NULL,
    QUARTER_NAME  VARCHAR(6)   NOT NULL,
    MONTH         INT          NOT NULL,
    MONTH_NAME    VARCHAR(12)  NOT NULL,
    MONTH_SHORT   VARCHAR(3)   NOT NULL,
    WEEK_OF_YEAR  INT          NOT NULL,
    DAY_OF_MONTH  INT          NOT NULL,
    DAY_OF_WEEK   INT          NOT NULL,
    DAY_NAME      VARCHAR(12)  NOT NULL,
    IS_WEEKEND    BOOLEAN      NOT NULL
);

INSERT INTO DIM_DATE
    (DATE_KEY,FULL_DATE,YEAR,QUARTER,QUARTER_NAME,MONTH,MONTH_NAME,
     MONTH_SHORT,WEEK_OF_YEAR,DAY_OF_MONTH,DAY_OF_WEEK,DAY_NAME,IS_WEEKEND)
VALUES
(20240101,'2024-01-01',2024,1,'Q1',1,'January','Jan',1,1,1,'Monday',FALSE),
(20240102,'2024-01-02',2024,1,'Q1',1,'January','Jan',1,2,2,'Tuesday',FALSE),
(20240103,'2024-01-03',2024,1,'Q1',1,'January','Jan',1,3,3,'Wednesday',FALSE),
(20240104,'2024-01-04',2024,1,'Q1',1,'January','Jan',1,4,4,'Thursday',FALSE),
(20240105,'2024-01-05',2024,1,'Q1',1,'January','Jan',1,5,5,'Friday',FALSE),
(20240106,'2024-01-06',2024,1,'Q1',1,'January','Jan',1,6,6,'Saturday',TRUE),
(20240107,'2024-01-07',2024,1,'Q1',1,'January','Jan',1,7,7,'Sunday',TRUE),
(20240108,'2024-01-08',2024,1,'Q1',1,'January','Jan',2,8,1,'Monday',FALSE),
(20240109,'2024-01-09',2024,1,'Q1',1,'January','Jan',2,9,2,'Tuesday',FALSE),
(20240110,'2024-01-10',2024,1,'Q1',1,'January','Jan',2,10,3,'Wednesday',FALSE),
(20240111,'2024-01-11',2024,1,'Q1',1,'January','Jan',2,11,4,'Thursday',FALSE),
(20240112,'2024-01-12',2024,1,'Q1',1,'January','Jan',2,12,5,'Friday',FALSE),
(20240113,'2024-01-13',2024,1,'Q1',1,'January','Jan',2,13,6,'Saturday',TRUE),
(20240114,'2024-01-14',2024,1,'Q1',1,'January','Jan',2,14,7,'Sunday',TRUE),
(20240115,'2024-01-15',2024,1,'Q1',1,'January','Jan',3,15,1,'Monday',FALSE),
(20240116,'2024-01-16',2024,1,'Q1',1,'January','Jan',3,16,2,'Tuesday',FALSE),
(20240117,'2024-01-17',2024,1,'Q1',1,'January','Jan',3,17,3,'Wednesday',FALSE),
(20240118,'2024-01-18',2024,1,'Q1',1,'January','Jan',3,18,4,'Thursday',FALSE),
(20240119,'2024-01-19',2024,1,'Q1',1,'January','Jan',3,19,5,'Friday',FALSE),
(20240120,'2024-01-20',2024,1,'Q1',1,'January','Jan',3,20,6,'Saturday',TRUE),
(20240121,'2024-01-21',2024,1,'Q1',1,'January','Jan',3,21,7,'Sunday',TRUE),
(20240122,'2024-01-22',2024,1,'Q1',1,'January','Jan',4,22,1,'Monday',FALSE),
(20240123,'2024-01-23',2024,1,'Q1',1,'January','Jan',4,23,2,'Tuesday',FALSE),
(20240124,'2024-01-24',2024,1,'Q1',1,'January','Jan',4,24,3,'Wednesday',FALSE),
(20240125,'2024-01-25',2024,1,'Q1',1,'January','Jan',4,25,4,'Thursday',FALSE),
(20240126,'2024-01-26',2024,1,'Q1',1,'January','Jan',4,26,5,'Friday',FALSE),
(20240127,'2024-01-27',2024,1,'Q1',1,'January','Jan',4,27,6,'Saturday',TRUE),
(20240128,'2024-01-28',2024,1,'Q1',1,'January','Jan',4,28,7,'Sunday',TRUE),
(20240129,'2024-01-29',2024,1,'Q1',1,'January','Jan',5,29,1,'Monday',FALSE),
(20240130,'2024-01-30',2024,1,'Q1',1,'January','Jan',5,30,2,'Tuesday',FALSE),
(20240131,'2024-01-31',2024,1,'Q1',1,'January','Jan',5,31,3,'Wednesday',FALSE),
(20240201,'2024-02-01',2024,1,'Q1',2,'February','Feb',5,1,4,'Thursday',FALSE),
(20240202,'2024-02-02',2024,1,'Q1',2,'February','Feb',5,2,5,'Friday',FALSE),
(20240203,'2024-02-03',2024,1,'Q1',2,'February','Feb',5,3,6,'Saturday',TRUE),
(20240204,'2024-02-04',2024,1,'Q1',2,'February','Feb',5,4,7,'Sunday',TRUE),
(20240205,'2024-02-05',2024,1,'Q1',2,'February','Feb',6,5,1,'Monday',FALSE),
(20240206,'2024-02-06',2024,1,'Q1',2,'February','Feb',6,6,2,'Tuesday',FALSE),
(20240207,'2024-02-07',2024,1,'Q1',2,'February','Feb',6,7,3,'Wednesday',FALSE),
(20240208,'2024-02-08',2024,1,'Q1',2,'February','Feb',6,8,4,'Thursday',FALSE),
(20240209,'2024-02-09',2024,1,'Q1',2,'February','Feb',6,9,5,'Friday',FALSE),
(20240210,'2024-02-10',2024,1,'Q1',2,'February','Feb',6,10,6,'Saturday',TRUE),
(20240211,'2024-02-11',2024,1,'Q1',2,'February','Feb',6,11,7,'Sunday',TRUE),
(20240212,'2024-02-12',2024,1,'Q1',2,'February','Feb',7,12,1,'Monday',FALSE),
(20240213,'2024-02-13',2024,1,'Q1',2,'February','Feb',7,13,2,'Tuesday',FALSE),
(20240214,'2024-02-14',2024,1,'Q1',2,'February','Feb',7,14,3,'Wednesday',FALSE),
(20240215,'2024-02-15',2024,1,'Q1',2,'February','Feb',7,15,4,'Thursday',FALSE),
(20240216,'2024-02-16',2024,1,'Q1',2,'February','Feb',7,16,5,'Friday',FALSE),
(20240217,'2024-02-17',2024,1,'Q1',2,'February','Feb',7,17,6,'Saturday',TRUE),
(20240218,'2024-02-18',2024,1,'Q1',2,'February','Feb',7,18,7,'Sunday',TRUE),
(20240219,'2024-02-19',2024,1,'Q1',2,'February','Feb',8,19,1,'Monday',FALSE),
(20240220,'2024-02-20',2024,1,'Q1',2,'February','Feb',8,20,2,'Tuesday',FALSE),
(20240221,'2024-02-21',2024,1,'Q1',2,'February','Feb',8,21,3,'Wednesday',FALSE),
(20240222,'2024-02-22',2024,1,'Q1',2,'February','Feb',8,22,4,'Thursday',FALSE),
(20240223,'2024-02-23',2024,1,'Q1',2,'February','Feb',8,23,5,'Friday',FALSE),
(20240224,'2024-02-24',2024,1,'Q1',2,'February','Feb',8,24,6,'Saturday',TRUE),
(20240225,'2024-02-25',2024,1,'Q1',2,'February','Feb',8,25,7,'Sunday',TRUE),
(20240226,'2024-02-26',2024,1,'Q1',2,'February','Feb',9,26,1,'Monday',FALSE),
(20240227,'2024-02-27',2024,1,'Q1',2,'February','Feb',9,27,2,'Tuesday',FALSE),
(20240228,'2024-02-28',2024,1,'Q1',2,'February','Feb',9,28,3,'Wednesday',FALSE),
(20240229,'2024-02-29',2024,1,'Q1',2,'February','Feb',9,29,4,'Thursday',FALSE),
(20240301,'2024-03-01',2024,1,'Q1',3,'March','Mar',9,1,5,'Friday',FALSE),
(20240302,'2024-03-02',2024,1,'Q1',3,'March','Mar',9,2,6,'Saturday',TRUE),
(20240303,'2024-03-03',2024,1,'Q1',3,'March','Mar',9,3,7,'Sunday',TRUE),
(20240304,'2024-03-04',2024,1,'Q1',3,'March','Mar',10,4,1,'Monday',FALSE),
(20240305,'2024-03-05',2024,1,'Q1',3,'March','Mar',10,5,2,'Tuesday',FALSE),
(20240306,'2024-03-06',2024,1,'Q1',3,'March','Mar',10,6,3,'Wednesday',FALSE),
(20240307,'2024-03-07',2024,1,'Q1',3,'March','Mar',10,7,4,'Thursday',FALSE),
(20240308,'2024-03-08',2024,1,'Q1',3,'March','Mar',10,8,5,'Friday',FALSE),
(20240309,'2024-03-09',2024,1,'Q1',3,'March','Mar',10,9,6,'Saturday',TRUE),
(20240310,'2024-03-10',2024,1,'Q1',3,'March','Mar',10,10,7,'Sunday',TRUE),
(20240311,'2024-03-11',2024,1,'Q1',3,'March','Mar',11,11,1,'Monday',FALSE),
(20240312,'2024-03-12',2024,1,'Q1',3,'March','Mar',11,12,2,'Tuesday',FALSE),
(20240313,'2024-03-13',2024,1,'Q1',3,'March','Mar',11,13,3,'Wednesday',FALSE),
(20240314,'2024-03-14',2024,1,'Q1',3,'March','Mar',11,14,4,'Thursday',FALSE),
(20240315,'2024-03-15',2024,1,'Q1',3,'March','Mar',11,15,5,'Friday',FALSE),
(20240316,'2024-03-16',2024,1,'Q1',3,'March','Mar',11,16,6,'Saturday',TRUE),
(20240317,'2024-03-17',2024,1,'Q1',3,'March','Mar',11,17,7,'Sunday',TRUE),
(20240318,'2024-03-18',2024,1,'Q1',3,'March','Mar',12,18,1,'Monday',FALSE),
(20240319,'2024-03-19',2024,1,'Q1',3,'March','Mar',12,19,2,'Tuesday',FALSE),
(20240320,'2024-03-20',2024,1,'Q1',3,'March','Mar',12,20,3,'Wednesday',FALSE),
(20240321,'2024-03-21',2024,1,'Q1',3,'March','Mar',12,21,4,'Thursday',FALSE),
(20240322,'2024-03-22',2024,1,'Q1',3,'March','Mar',12,22,5,'Friday',FALSE),
(20240323,'2024-03-23',2024,1,'Q1',3,'March','Mar',12,23,6,'Saturday',TRUE),
(20240324,'2024-03-24',2024,1,'Q1',3,'March','Mar',12,24,7,'Sunday',TRUE),
(20240325,'2024-03-25',2024,1,'Q1',3,'March','Mar',13,25,1,'Monday',FALSE),
(20240326,'2024-03-26',2024,1,'Q1',3,'March','Mar',13,26,2,'Tuesday',FALSE),
(20240327,'2024-03-27',2024,1,'Q1',3,'March','Mar',13,27,3,'Wednesday',FALSE),
(20240328,'2024-03-28',2024,1,'Q1',3,'March','Mar',13,28,4,'Thursday',FALSE),
(20240329,'2024-03-29',2024,1,'Q1',3,'March','Mar',13,29,5,'Friday',FALSE),
(20240330,'2024-03-30',2024,1,'Q1',3,'March','Mar',13,30,6,'Saturday',TRUE),
(20240331,'2024-03-31',2024,1,'Q1',3,'March','Mar',13,31,7,'Sunday',TRUE),
(20240401,'2024-04-01',2024,2,'Q2',4,'April','Apr',14,1,1,'Monday',FALSE),
(20240402,'2024-04-02',2024,2,'Q2',4,'April','Apr',14,2,2,'Tuesday',FALSE),
(20240403,'2024-04-03',2024,2,'Q2',4,'April','Apr',14,3,3,'Wednesday',FALSE),
(20240404,'2024-04-04',2024,2,'Q2',4,'April','Apr',14,4,4,'Thursday',FALSE),
(20240405,'2024-04-05',2024,2,'Q2',4,'April','Apr',14,5,5,'Friday',FALSE),
(20240406,'2024-04-06',2024,2,'Q2',4,'April','Apr',14,6,6,'Saturday',TRUE),
(20240407,'2024-04-07',2024,2,'Q2',4,'April','Apr',14,7,7,'Sunday',TRUE),
(20240408,'2024-04-08',2024,2,'Q2',4,'April','Apr',15,8,1,'Monday',FALSE),
(20240409,'2024-04-09',2024,2,'Q2',4,'April','Apr',15,9,2,'Tuesday',FALSE),
(20240410,'2024-04-10',2024,2,'Q2',4,'April','Apr',15,10,3,'Wednesday',FALSE),
(20240411,'2024-04-11',2024,2,'Q2',4,'April','Apr',15,11,4,'Thursday',FALSE),
(20240412,'2024-04-12',2024,2,'Q2',4,'April','Apr',15,12,5,'Friday',FALSE),
(20240413,'2024-04-13',2024,2,'Q2',4,'April','Apr',15,13,6,'Saturday',TRUE),
(20240414,'2024-04-14',2024,2,'Q2',4,'April','Apr',15,14,7,'Sunday',TRUE),
(20240415,'2024-04-15',2024,2,'Q2',4,'April','Apr',16,15,1,'Monday',FALSE),
(20240416,'2024-04-16',2024,2,'Q2',4,'April','Apr',16,16,2,'Tuesday',FALSE),
(20240417,'2024-04-17',2024,2,'Q2',4,'April','Apr',16,17,3,'Wednesday',FALSE),
(20240418,'2024-04-18',2024,2,'Q2',4,'April','Apr',16,18,4,'Thursday',FALSE),
(20240419,'2024-04-19',2024,2,'Q2',4,'April','Apr',16,19,5,'Friday',FALSE),
(20240420,'2024-04-20',2024,2,'Q2',4,'April','Apr',16,20,6,'Saturday',TRUE),
(20240421,'2024-04-21',2024,2,'Q2',4,'April','Apr',16,21,7,'Sunday',TRUE),
(20240422,'2024-04-22',2024,2,'Q2',4,'April','Apr',17,22,1,'Monday',FALSE),
(20240423,'2024-04-23',2024,2,'Q2',4,'April','Apr',17,23,2,'Tuesday',FALSE),
(20240424,'2024-04-24',2024,2,'Q2',4,'April','Apr',17,24,3,'Wednesday',FALSE),
(20240425,'2024-04-25',2024,2,'Q2',4,'April','Apr',17,25,4,'Thursday',FALSE),
(20240426,'2024-04-26',2024,2,'Q2',4,'April','Apr',17,26,5,'Friday',FALSE),
(20240427,'2024-04-27',2024,2,'Q2',4,'April','Apr',17,27,6,'Saturday',TRUE),
(20240428,'2024-04-28',2024,2,'Q2',4,'April','Apr',17,28,7,'Sunday',TRUE),
(20240429,'2024-04-29',2024,2,'Q2',4,'April','Apr',18,29,1,'Monday',FALSE),
(20240430,'2024-04-30',2024,2,'Q2',4,'April','Apr',18,30,2,'Tuesday',FALSE),
(20240501,'2024-05-01',2024,2,'Q2',5,'May','May',18,1,3,'Wednesday',FALSE),
(20240502,'2024-05-02',2024,2,'Q2',5,'May','May',18,2,4,'Thursday',FALSE),
(20240503,'2024-05-03',2024,2,'Q2',5,'May','May',18,3,5,'Friday',FALSE),
(20240504,'2024-05-04',2024,2,'Q2',5,'May','May',18,4,6,'Saturday',TRUE),
(20240505,'2024-05-05',2024,2,'Q2',5,'May','May',18,5,7,'Sunday',TRUE),
(20240506,'2024-05-06',2024,2,'Q2',5,'May','May',19,6,1,'Monday',FALSE),
(20240507,'2024-05-07',2024,2,'Q2',5,'May','May',19,7,2,'Tuesday',FALSE),
(20240508,'2024-05-08',2024,2,'Q2',5,'May','May',19,8,3,'Wednesday',FALSE),
(20240509,'2024-05-09',2024,2,'Q2',5,'May','May',19,9,4,'Thursday',FALSE),
(20240510,'2024-05-10',2024,2,'Q2',5,'May','May',19,10,5,'Friday',FALSE),
(20240511,'2024-05-11',2024,2,'Q2',5,'May','May',19,11,6,'Saturday',TRUE),
(20240512,'2024-05-12',2024,2,'Q2',5,'May','May',19,12,7,'Sunday',TRUE),
(20240513,'2024-05-13',2024,2,'Q2',5,'May','May',20,13,1,'Monday',FALSE),
(20240514,'2024-05-14',2024,2,'Q2',5,'May','May',20,14,2,'Tuesday',FALSE),
(20240515,'2024-05-15',2024,2,'Q2',5,'May','May',20,15,3,'Wednesday',FALSE),
(20240516,'2024-05-16',2024,2,'Q2',5,'May','May',20,16,4,'Thursday',FALSE),
(20240517,'2024-05-17',2024,2,'Q2',5,'May','May',20,17,5,'Friday',FALSE),
(20240518,'2024-05-18',2024,2,'Q2',5,'May','May',20,18,6,'Saturday',TRUE),
(20240519,'2024-05-19',2024,2,'Q2',5,'May','May',20,19,7,'Sunday',TRUE),
(20240520,'2024-05-20',2024,2,'Q2',5,'May','May',21,20,1,'Monday',FALSE),
(20240521,'2024-05-21',2024,2,'Q2',5,'May','May',21,21,2,'Tuesday',FALSE),
(20240522,'2024-05-22',2024,2,'Q2',5,'May','May',21,22,3,'Wednesday',FALSE),
(20240523,'2024-05-23',2024,2,'Q2',5,'May','May',21,23,4,'Thursday',FALSE),
(20240524,'2024-05-24',2024,2,'Q2',5,'May','May',21,24,5,'Friday',FALSE),
(20240525,'2024-05-25',2024,2,'Q2',5,'May','May',21,25,6,'Saturday',TRUE),
(20240526,'2024-05-26',2024,2,'Q2',5,'May','May',21,26,7,'Sunday',TRUE),
(20240527,'2024-05-27',2024,2,'Q2',5,'May','May',22,27,1,'Monday',FALSE),
(20240528,'2024-05-28',2024,2,'Q2',5,'May','May',22,28,2,'Tuesday',FALSE),
(20240529,'2024-05-29',2024,2,'Q2',5,'May','May',22,29,3,'Wednesday',FALSE),
(20240530,'2024-05-30',2024,2,'Q2',5,'May','May',22,30,4,'Thursday',FALSE),
(20240531,'2024-05-31',2024,2,'Q2',5,'May','May',22,31,5,'Friday',FALSE),
(20240601,'2024-06-01',2024,2,'Q2',6,'June','Jun',22,1,6,'Saturday',TRUE),
(20240602,'2024-06-02',2024,2,'Q2',6,'June','Jun',22,2,7,'Sunday',TRUE),
(20240603,'2024-06-03',2024,2,'Q2',6,'June','Jun',23,3,1,'Monday',FALSE),
(20240604,'2024-06-04',2024,2,'Q2',6,'June','Jun',23,4,2,'Tuesday',FALSE),
(20240605,'2024-06-05',2024,2,'Q2',6,'June','Jun',23,5,3,'Wednesday',FALSE),
(20240606,'2024-06-06',2024,2,'Q2',6,'June','Jun',23,6,4,'Thursday',FALSE),
(20240607,'2024-06-07',2024,2,'Q2',6,'June','Jun',23,7,5,'Friday',FALSE),
(20240608,'2024-06-08',2024,2,'Q2',6,'June','Jun',23,8,6,'Saturday',TRUE),
(20240609,'2024-06-09',2024,2,'Q2',6,'June','Jun',23,9,7,'Sunday',TRUE),
(20240610,'2024-06-10',2024,2,'Q2',6,'June','Jun',24,10,1,'Monday',FALSE),
(20240611,'2024-06-11',2024,2,'Q2',6,'June','Jun',24,11,2,'Tuesday',FALSE),
(20240612,'2024-06-12',2024,2,'Q2',6,'June','Jun',24,12,3,'Wednesday',FALSE),
(20240613,'2024-06-13',2024,2,'Q2',6,'June','Jun',24,13,4,'Thursday',FALSE),
(20240614,'2024-06-14',2024,2,'Q2',6,'June','Jun',24,14,5,'Friday',FALSE),
(20240615,'2024-06-15',2024,2,'Q2',6,'June','Jun',24,15,6,'Saturday',TRUE),
(20240616,'2024-06-16',2024,2,'Q2',6,'June','Jun',24,16,7,'Sunday',TRUE),
(20240617,'2024-06-17',2024,2,'Q2',6,'June','Jun',25,17,1,'Monday',FALSE),
(20240618,'2024-06-18',2024,2,'Q2',6,'June','Jun',25,18,2,'Tuesday',FALSE),
(20240619,'2024-06-19',2024,2,'Q2',6,'June','Jun',25,19,3,'Wednesday',FALSE),
(20240620,'2024-06-20',2024,2,'Q2',6,'June','Jun',25,20,4,'Thursday',FALSE),
(20240621,'2024-06-21',2024,2,'Q2',6,'June','Jun',25,21,5,'Friday',FALSE),
(20240622,'2024-06-22',2024,2,'Q2',6,'June','Jun',25,22,6,'Saturday',TRUE),
(20240623,'2024-06-23',2024,2,'Q2',6,'June','Jun',25,23,7,'Sunday',TRUE),
(20240624,'2024-06-24',2024,2,'Q2',6,'June','Jun',26,24,1,'Monday',FALSE),
(20240625,'2024-06-25',2024,2,'Q2',6,'June','Jun',26,25,2,'Tuesday',FALSE),
(20240626,'2024-06-26',2024,2,'Q2',6,'June','Jun',26,26,3,'Wednesday',FALSE),
(20240627,'2024-06-27',2024,2,'Q2',6,'June','Jun',26,27,4,'Thursday',FALSE),
(20240628,'2024-06-28',2024,2,'Q2',6,'June','Jun',26,28,5,'Friday',FALSE),
(20240629,'2024-06-29',2024,2,'Q2',6,'June','Jun',26,29,6,'Saturday',TRUE),
(20240630,'2024-06-30',2024,2,'Q2',6,'June','Jun',26,30,7,'Sunday',TRUE);

ALTER TABLE DIM_DATE
ADD COLUMN FULL_DATE_NEW DATE;

UPDATE DIM_DATE
SET FULL_DATE_NEW = TO_DATE(TO_CHAR(DATE_KEY), 'YYYYMMDD');

ALTER TABLE DIM_DATE DROP COLUMN DATE_KEY;
ALTER TABLE DIM_DATE RENAME COLUMN FULL_DATE_NEW TO DATE_KEY;

-- ------------------------------------------------------------
-- DIM_COMPONENT
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_COMPONENT (
    COMPONENT_ID          VARCHAR(20)  NOT NULL PRIMARY KEY,
    COMPONENT_NAME        VARCHAR(100) NOT NULL,
    COMPONENT_TYPE        VARCHAR(50)  NOT NULL,
    SUBSYSTEM             VARCHAR(50)  NOT NULL,
    MANUFACTURER          VARCHAR(100),
    NOMINAL_TEMP_MIN_C    FLOAT,
    NOMINAL_TEMP_MAX_C    FLOAT,
    NOMINAL_PRESSURE_BAR  FLOAT,
    CRITICALITY_LEVEL     VARCHAR(10)  NOT NULL
);

INSERT INTO DIM_COMPONENT VALUES
('COMP-001','Main Engine Alpha',       'engine',    'propulsion', 'AeroJet Rocketdyne',-40, 1200,350.0,'critical'),
('COMP-002','Main Engine Beta',        'engine',    'propulsion', 'AeroJet Rocketdyne',-40, 1200,350.0,'critical'),
('COMP-003','Reaction Control System', 'engine',    'propulsion', 'Moog Inc',          -55,  800,120.0,'high'),
('COMP-004','Solar Panel Array Left',  'power',     'electrical', 'SunPower Corp',     -150, 120,  0.0,'high'),
('COMP-005','Solar Panel Array Right', 'power',     'electrical', 'SunPower Corp',     -150, 120,  0.0,'high'),
('COMP-006','Battery Pack Primary',    'power',     'electrical', 'EaglePicher',       -20,   60,  0.0,'critical'),
('COMP-007','Navigation IMU',          'sensor',    'avionics',   'Honeywell',         -40,   85,  0.0,'critical'),
('COMP-008','Star Tracker',            'sensor',    'avionics',   'Ball Aerospace',    -40,   70,  0.0,'high'),
('COMP-009','Thermal Control Unit',    'sensor',    'thermal',    'NASA JPL',          -60,  150,  5.0,'high'),
('COMP-010','Fuel Tank Primary',       'structure', 'propulsion', 'Lockheed Martin',   -55,   90,420.0,'critical'),
('COMP-011','Oxidizer Tank',           'structure', 'propulsion', 'Lockheed Martin',   -55,   80,380.0,'critical'),
('COMP-012','Communication Antenna',   'sensor',    'avionics',   'Harris Corp',       -100, 120,  0.0,'medium');

-- ------------------------------------------------------------
-- DIM_MISSION_PHASE
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_MISSION_PHASE (
    PHASE_ID           VARCHAR(20)  NOT NULL PRIMARY KEY,
    PHASE_CODE         VARCHAR(20)  NOT NULL,
    PHASE_NAME         VARCHAR(50)  NOT NULL,
    DESCRIPTION        VARCHAR(200),
    TYPICAL_DURATION_H INT,
    PHASE_ORDER        INT          NOT NULL,
    RADIATION_RISK     VARCHAR(10),
    THERMAL_STRESS     VARCHAR(10)
);

INSERT INTO DIM_MISSION_PHASE VALUES
('PHASE-01','prelaunch','Pre-Launch Checkout','Verificación de sistemas en tierra',    72, 1,'low',   'low'),
('PHASE-02','launch',   'Launch & Ascent',    'Encendido y ascenso atmosférico',         2, 2,'low',   'extreme'),
('PHASE-03','meco',     'Main Engine Cutoff', 'Apagado motor principal, separación',     1, 3,'medium','high'),
('PHASE-04','leo',      'Low Earth Orbit',    'Operación en órbita baja 200-2000 km', 720, 4,'medium','medium'),
('PHASE-05','heo',      'High Earth Orbit',   'Órbita alta, mayor exposición radiación',960,5,'high',  'medium'),
('PHASE-06','reentry',  'Reentry',            'Reentrada, pico de estrés térmico',       3, 6,'low',   'extreme'),
('PHASE-07','recovery', 'Recovery',           'Post-aterrizaje, inspección sistemas',   48, 7,'low',   'low');

-- ------------------------------------------------------------
-- DIM_EVENT_TYPE
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_EVENT_TYPE (
    EVENT_TYPE_ID   INT          NOT NULL PRIMARY KEY,
    EVENT_TYPE      VARCHAR(20)  NOT NULL,
    EVENT_SEVERITY  VARCHAR(10)  NOT NULL,
    SEVERITY_ORDER  INT          NOT NULL,
    REQUIRES_ACTION BOOLEAN      NOT NULL,
    COST_CATEGORY   VARCHAR(20)  NOT NULL,
    DESCRIPTION     VARCHAR(200)
);

INSERT INTO DIM_EVENT_TYPE VALUES
(1, 'none',        'none',     0, FALSE,'none',  'Lectura nominal, sin incidencias'),
(2, 'anomaly',     'low',      1, FALSE,'low',   'Desviación leve, dentro de márgenes'),
(3, 'anomaly',     'medium',   2, TRUE, 'low',   'Anomalía moderada, requiere seguimiento'),
(4, 'anomaly',     'high',     3, TRUE, 'medium','Anomalía grave, intervención recomendada'),
(5, 'anomaly',     'critical', 4, TRUE, 'high',  'Anomalía crítica, intervención inmediata'),
(6, 'maintenance', 'low',      1, TRUE, 'low',   'Mantenimiento preventivo rutinario'),
(7, 'maintenance', 'medium',   2, TRUE, 'medium','Mantenimiento correctivo moderado'),
(8, 'maintenance', 'high',     3, TRUE, 'high',  'Mantenimiento mayor urgente'),
(9, 'failure',     'medium',   2, TRUE, 'medium','Fallo parcial, sistema degradado'),
(10,'failure',     'high',     3, TRUE, 'high',  'Fallo grave, sistema comprometido'),
(11,'failure',     'critical', 4, TRUE, 'high',  'Fallo total, fuera de servicio');

-- ------------------------------------------------------------
-- DIM_LAUNCH_SITE
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE DIM_LAUNCH_SITE (
    SITE_ID    INT          NOT NULL PRIMARY KEY,
    SITE_CODE  VARCHAR(50)  NOT NULL,
    SITE_NAME  VARCHAR(100) NOT NULL,
    COUNTRY    VARCHAR(50)  NOT NULL,
    CITY       VARCHAR(50),
    LATITUDE   FLOAT        NOT NULL,
    LONGITUDE  FLOAT        NOT NULL,
    AGENCY     VARCHAR(20)  NOT NULL,
    ACTIVE     BOOLEAN      NOT NULL
);

INSERT INTO DIM_LAUNCH_SITE VALUES
(1,'KSC',        'Kennedy Space Center',       'United States','Merritt Island', 28.524, -80.651,'NASA',     TRUE),
(2,'CCSFS',      'Cape Canaveral SFS',         'United States','Cape Canaveral', 28.488, -80.577,'NASA',     TRUE),
(3,'KOUROU',     'Guiana Space Centre',        'France',       'Kourou',          5.239, -52.769,'ESA',      TRUE),
(4,'BAIKONUR',   'Baikonur Cosmodrome',        'Kazakhstan',   'Baikonur',       45.965,  63.305,'ROSCOSMOS',TRUE),
(5,'TANEGASHIMA','Tanegashima Space Center',   'Japan',        'Tanegashima',    30.399, 130.970,'JAXA',     TRUE),
(6,'SRIHARIKOTA','Satish Dhawan Space Centre', 'India',        'Sriharikota',    13.733,  80.235,'ISRO',     TRUE);
