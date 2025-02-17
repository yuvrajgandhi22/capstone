CREATE TABLE DistrictWiseCrimesAgainstWomen (
    STATE_UT VARCHAR(255),
    DISTRICT VARCHAR(255),
    YEAR INT,
    RAPE INT,
    KIDNAPPING_ABDUCTION INT
);

LOAD DATA INFILE 'path/to/42_District_wise_crimes_committed_against_women_2001_2012.csv'
INTO TABLE DistrictWiseCrimesAgainstWomen
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT STATE_UT, DISTRICT, YEAR, MAX(RAPE) AS MaxRapes, MAX(KIDNAPPING_ABDUCTION) AS MaxKidnappings
FROM DistrictWiseCrimesAgainstWomen
GROUP BY STATE_UT, DISTRICT, YEAR
ORDER BY MaxRapes DESC, MaxKidnappings DESC
LIMIT 1;

SELECT STATE_UT, DISTRICT, YEAR, MIN(RAPE) AS MinRapes, MIN(KIDNAPPING_ABDUCTION) AS MinKidnappings
FROM DistrictWiseCrimesAgainstWomen
GROUP BY STATE_UT, DISTRICT, YEAR
ORDER BY MinRapes ASC, MinKidnappings ASC
LIMIT 1;

CREATE TABLE DistrictWiseCrimesAgainstST (
    STATE_UT VARCHAR(255),
    DISTRICT VARCHAR(255),
    YEAR INT,
    DACOITY INT,
    ROBBERY INT
);

LOAD DATA INFILE 'path/to/02_District_wise_crimes_committed_against_ST_2001_2012.csv'
INTO TABLE DistrictWiseCrimesAgainstST
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT DISTRICT, MAX(DACOITY) AS MaxDacoity, MAX(ROBBERY) AS MaxRobbery
FROM DistrictWiseCrimesAgainstST
GROUP BY DISTRICT
ORDER BY MaxDacoity DESC, MaxRobbery DESC
LIMIT 1;

SELECT DISTRICT, MIN(MURDER) AS MinMurders
FROM DistrictWiseCrimesAgainstST
GROUP BY DISTRICT
ORDER BY MinMurders ASC;

SELECT DISTRICT, YEAR, MURDER
FROM DistrictWiseCrimesAgainstST
ORDER BY MURDER ASC, DISTRICT ASC, YEAR ASC;

CREATE TABLE DistrictWiseCrimesIPC (
    STATE_UT VARCHAR(255),
    DISTRICT VARCHAR(255),
    YEAR INT,
    MURDER INT,
    ATTEMPT_TO_MURDER INT,
    RAPE INT
);

LOAD DATA INFILE 'path/to/01_District_wise_crimes_committed_IPC_2001_2012.csv'
INTO TABLE DistrictWiseCrimesIPC
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(STATE_UT, DISTRICT, YEAR, MURDER, ATTEMPT_TO_MURDER, RAPE);

SELECT STATE_UT, DISTRICT, YEAR, MURDER
FROM (
    SELECT STATE_UT, DISTRICT, YEAR, MURDER, COUNT(*) OVER(PARTITION BY STATE_UT, DISTRICT) AS YearCount
    FROM DistrictWiseCrimesIPC
) sub
WHERE YearCount >= 3
ORDER BY STATE_UT, DISTRICT, YEAR DESC;


