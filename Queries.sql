
--D1.
SELECT TC.OBSERVATION_DATE AS 'OBSERVATION DATE 1', L.COUNTRY_NAME AS 'COUNTRY',TC.DAILY_VACCINATIONS AS 'TOTAL VACCINE OD1',TD.OBSERVATION_DATE AS 'OBSERVATION DATE 2'
,TD.DAILY_VACCINATIONS AS 'TOTAL VACCINE OD2', TC.DAILY_VACCINATIONS-TD.DAILY_VACCINATIONS AS 'DIFFERENCE OF TOTALS'
FROM LOCATIONS L INNER JOIN TOTAL_VACCINATION TC ON L.ISO_CODE = TC.ISO_CODE AND TC.OBSERVATION_DATE = '4/15/2021'
INNER JOIN TOTAL_VACCINATION TD ON L.ISO_CODE = TD.ISO_CODE AND TD.OBSERVATION_DATE = '4/16/2021';


--D2.
SELECT L.COUNTRY_NAME,TV.TOTAL_VACCINATIONS FROM 
TOTAL_VACCINATION TV INNER JOIN CURRENT_OBSERVATION CO ON TV.ISO_CODE = CO.ISO_CODE AND TV.OBSERVATION_DATE = CO.LAST_OBSERVATION_DATE   AND TV.TOTAL_VACCINATIONS <> ''
INNER JOIN LOCATIONS L ON L.ISO_CODE = CO.ISO_CODE
WHERE  TV.TOTAL_VACCINATIONS >  (SELECT ROUND(AVG( TOTAL_VACCINATIONS),2) FROM 
TOTAL_VACCINATION TV INNER JOIN CURRENT_OBSERVATION CO ON TV.ISO_CODE = CO.ISO_CODE AND TV.OBSERVATION_DATE = CO.LAST_OBSERVATION_DATE );


 
--D3.
SELECT L.COUNTRY_NAME,V.VACCINE_NAME FROM LOCATIONS L INNER JOIN LOCATION_VACCINES LC ON L.ISO_CODE = LC.ISO_CODE 
INNER JOIN VACCINES V ON V.VACCINE_ID = LC.VACCINE_ID
WHERE L.ISO_CODE IN (
SELECT ISO_CODE FROM LOCATION_VACCINES 
GROUP BY ISO_CODE
ORDER BY COUNT(VACCINE_ID) DESC, ISO_CODE ASC 
LIMIT 10);


--D4.
SELECT S.SOURCE_NAME,SUM(TOTAL_VACCINATIONS) TOTAL_ADMINISTERED_VACCINE, SOURCE_WEBSITE FROM CURRENT_OBSERVATION CO INNER JOIN SOURCE S ON CO.SOURCE_ID = S.SOURCE_ID 
INNER JOIN TOTAL_VACCINATION TV ON TV.ISO_CODE = CO.ISO_CODE AND TV.OBSERVATION_DATE = CO.LAST_OBSERVATION_DATE
GROUP BY S.SOURCE_ID
ORDER BY S.SOURCE_NAME, SOURCE_WEBSITE;

 --D5.
SELECT DISTINCT M.OBSERVATION_DATE,AU.PEOPLE_FULLY_VACCINATED AS 'AUSTRALIA',US.PEOPLE_FULLY_VACCINATED AS 'UNITED STATES',EN.PEOPLE_FULLY_VACCINATED AS 'ENGLAND' ,CH.PEOPLE_FULLY_VACCINATED AS 'CHINA' 
FROM TOTAL_VACCINATION M 
LEFT JOIN TOTAL_VACCINATION AU ON M.OBSERVATION_DATE = AU.OBSERVATION_DATE AND AU.ISO_CODE = 'AUS' AND AU.PEOPLE_FULLY_VACCINATED <> ''
LEFT JOIN TOTAL_VACCINATION US ON M.OBSERVATION_DATE = US.OBSERVATION_DATE AND US.ISO_CODE = 'USA' AND US.PEOPLE_FULLY_VACCINATED <> ''
LEFT JOIN TOTAL_VACCINATION EN ON M.OBSERVATION_DATE = EN.OBSERVATION_DATE AND EN.ISO_CODE = 'OWID_ENG' AND EN.PEOPLE_FULLY_VACCINATED <> ''
LEFT JOIN TOTAL_VACCINATION CH ON M.OBSERVATION_DATE = CH.OBSERVATION_DATE AND CH.ISO_CODE = 'CHN' AND CH.PEOPLE_FULLY_VACCINATED <> ''
WHERE M.OBSERVATION_DATE LIKE '%2022' AND M.ISO_CODE IN ('AUS','USA','OWID_ENG','CHN');

