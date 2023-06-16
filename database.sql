CREATE TABLE CURRENT_OBSERVATION (
    ISO_CODE              VARCHAR (10) REFERENCES LOCATIONS (ISO_CODE) 
                                       NOT NULL,
    LAST_OBSERVATION_DATE DATE         NOT NULL,
    SOURCE_ID             INTEGER      REFERENCES SOURCE (SOURCE_ID),
    VACCINE_DESC          STRING,
    PRIMARY KEY (
        ISO_CODE,
        LAST_OBSERVATION_DATE
    )
);

CREATE TABLE LOCATION_VACCINES (
    ISO_CODE   VARCHAR (10) REFERENCES LOCATIONS (ISO_CODE) 
                            NOT NULL,
    VACCINE_ID VARCHAR (10) REFERENCES VACCINES (VACCINE_ID) 
                            NOT NULL,
    PRIMARY KEY (
        ISO_CODE,
        VACCINE_ID
    )
);

CREATE TABLE LOCATIONS (
    ISO_CODE     VARCHAR (10) PRIMARY KEY
                              NOT NULL,
    COUNTRY_NAME STRING (255) 
);

CREATE TABLE OBSERVATION_HISTORY (
    ISO_CODE         VARCHAR (10) REFERENCES LOCATIONS (ISO_CODE) 
                                  NOT NULL,
    OBSERVATION_DATE DATE         NOT NULL,
    SOURCE_ID        INTEGER      REFERENCES SOURCE (SOURCE_ID),
    VACCINE_DESC     STRING,
    PRIMARY KEY (
        ISO_CODE,
        OBSERVATION_DATE
    )
);

CREATE TABLE SOURCE (
    SOURCE_ID      INTEGER       PRIMARY KEY AUTOINCREMENT
                                 UNIQUE
                                 NOT NULL,
    SOURCE_WEBSITE VARCHAR (225),
    SOURCE_NAME    VARCHAR (225) 
);

CREATE TABLE STATE (
    STATE_ID   VARCHAR (10, 19) UNIQUE
                                NOT NULL,
    ISO_CODE   VARCHAR (10)     NOT NULL
                                REFERENCES LOCATIONS (ISO_CODE),
    STATE_NAME VARCHAR (20),
    PRIMARY KEY (
        STATE_ID
    )
);

CREATE TABLE STATE_TOTAL_VACCINATION (
    STATE_ID                            VARCHAR (10)    REFERENCES STATE (STATE_ID) 
                                                        NOT NULL,
    OBSERVATION_DATE                    DATE            NOT NULL,
    TOTAL_VACCINATIONS                  VARCHAR,
    TOTAL_DISTRIBUTED                   INTEGER,
    PEOPLE_VACCINATED                   INTEGER,
    PEOPLE_FULLY_VACCINATED             INTEGER,
    TOTAL_BOOSTERS                      INTEGER,
    DAILY_VACCINATIONS                  INTEGER,
    DAILY_VACCINATIONS_RAW              INTEGER,
    SHARE_DOSES_USED                    DECIMAL (15, 3),
    TOTAL_VACCINATIONS_PER_HUNDRED      DECIMAL (16, 3),
    DISTRIBUTED_PER_HUNDRED             DECIMAL (16, 3),
    PEOPLE_VACCINATED_PER_HUNDRED       DECIMAL (16, 3),
    PEOPLE_FULLY_VACCINATED_PER_HUNDRED DECIMAL (16, 3),
    TOTAL_BOOSTERS_PER_HUNDRED          DECIMAL (16, 3),
    DAILY_VACCINATIONS_PER_MILLION      DECIMAL (16, 3),
    PRIMARY KEY (
        STATE_ID,
        OBSERVATION_DATE
    )
);

CREATE TABLE TOTAL_VACCINATION (
    ISO_CODE                             VARCHAR (10)    REFERENCES LOCATIONS (ISO_CODE) 
                                                         NOT NULL,
    OBSERVATION_DATE                     DATE            NOT NULL,
    TOTAL_VACCINATIONS                   INTEGER,
    PEOPLE_VACCINATED                    INTEGER,
    PEOPLE_FULLY_VACCINATED              INTEGER,
    TOTAL_BOOSTERS                       INTEGER,
    DAILY_VACCINATIONS_RAW               INTEGER,
    DAILY_VACCINATIONS                   INTEGER,
    DAILY_PEOPLE_VACCINATED              INTEGER,
    TOTAL_VACCINATIONS_PER_HUNDRED       DECIMAL (16, 3),
    PEOPLE_VACCINATED_PER_HUNDRED        DECIMAL (16, 3),
    PEOPLE__FULLY_VACCINATED_PER_HUNDRED DECIMAL (16, 3),
    TOTAL_BOOSTER_PER_HUNDRED            DECIMAL (16, 3),
    DAILY_VACCINATIONS_PER_MILLION       DECIMAL (16, 3),
    DAILY_PEOPLE_VACCINATED_PER_HUNDRED  DECIMAL (16, 3),
    PRIMARY KEY (
        ISO_CODE,
        OBSERVATION_DATE
    )
);

CREATE TABLE VACCINATION_BY_AGE (
    ISO_CODE                            VARCHAR (10)    REFERENCES LOCATIONS (ISO_CODE) 
                                                        NOT NULL,
    OBSERVATION_DATE                    DATE            NOT NULL,
    AGE_GROUP                           VARCHAR (10)    NOT NULL,
    PEOPLE_VACCINATED_PER_HUNDRED       DECIMAL (15, 3),
    PEOPLE_FULLY_VACCINATED_PER_HUNDRED DECIMAL (15, 3),
    PEOPLE_WITH_BOOSTER_PER_HUNDRED     DECIMAL (15, 3),
    PRIMARY KEY (
        ISO_CODE,
        OBSERVATION_DATE,
        AGE_GROUP
    )
);

CREATE TABLE VACCINES (
    VACCINE_ID   VARCHAR (10) PRIMARY KEY
                              NOT NULL,
    VACCINE_NAME VARCHAR
);
