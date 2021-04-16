CREATE TABLE dzieci1 (
 id INTEGER NOT NULL,
 imie VARCHAR2(15) NOT NULL,
 nazwisko VARCHAR2(20) NOT NULL,
 wzrost INTEGER NOT NULL,
 waga NUMBER(5, 2) NOT NULL,
 data_ur DATE NOT NULL,
 kieszonkowe NUMBER
);
ALTER TABLE dzieci1 ADD CONSTRAINT dzieci_pk PRIMARY KEY ( id );
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('1','ANNA','NOWAK','150','51',to_date('09/12/02','RR/MM/DD'),null);
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('2','EWA','MAZUREK','140','45',to_date('10/03/16','RR/MM/DD'),'50');
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('3','BARBARA','BURCZAK','151','35',to_date('12/09/04','RR/MM/DD'),null);
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('4','CELINA','KOWALSKA','120','25',to_date('13/02/20','RR/MM/DD'),'45');
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('5','DARIA','MURALSKA','165','55',to_date('98/05/07','RR/MM/DD'),'80');
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('6','franciszek','nowacki','155','58',to_date('02/07/13','RR/MM/DD'),'65');
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('7','gustaw','modry','101','35',to_date('03/01/25','RR/MM/DD'),null);
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('8','hanna','kowalska','121','33',to_date('03/06/09','RR/MM/DD'),'30');
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('9','iwan','kukulski','80','23',to_date('04/01/13','RR/MM/DD'),null);
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('10','jan','burczak','68','15',to_date('05/12/30','RR/MM/DD'),null);
Insert into DZIECI1 (ID,IMIE,NAZWISKO,WZROST,WAGA,DATA_UR,KIESZONKOWE) values
('11','Krzysztof','Malcarek','149','47',to_date('00/04/04','RR/MM/DD'),null);
insert all
into dzieci1(id,imie,nazwisko,wzrost,waga,data_ur,kieszonkowe) values
('12','Andrzej','Bukowski','170','79',to_date('2001-01-13','RRRR-MM-DD'),'100')
into dzieci1(id,imie,nazwisko,wzrost,waga,data_ur,kieszonkowe) values
('13','Norbert','Szalka','145','49',to_date('2010-07-03','RRRR-MM-DD'),null)
into dzieci1(id,imie,nazwisko,wzrost,waga,data_ur,kieszonkowe) values
('14','Weronika','Micek','171','66',to_date('2000-03-03','RRRR-MM-DD'),'120')
select * from dual;
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;


select
imie as IMIE,
nazwisko as NAZWISKO,
extract(year from data_ur) as "ROK URODZENIA",
extract(month from data_ur) as "MIESIAC URODZENIA",
extract(day from data_ur) as "DZIEN URODZENIA",
trunc(months_between(sysdate,data_ur)/12) as "PRZEZYTE LATA",
trunc(mod(months_between(sysdate,data_ur),12))+
trunc(months_between(sysdate,data_ur)/12)*12 as "PRZEZYTE MIESIACE"
from dzieci1
where (wzrost>=100 and waga<70) or kieszonkowe >= 50
order by imie asc;

select 
imie as "IMIE",
nazwisko as "NAZWISKO",
replace(lower(nazwisko),'ski') as "NAZWISKA BEZ KONCOWKI SKI",
regexp_count (imie,'[qwrtpsdfghjklzxcvbnmQWRTPSDFGHJKLZXVBNM]') as "LICZBA SPOLGLOSEK W IMIENIU",
waga/1000 as "WAGA [t]"
from dzieci1
where (wzrost>=120 and waga >=45) or not imie like 'ANNA'
order by kieszonkowe desc;

update dzieci1
set kieszonkowe=0
where kieszonkowe is null;
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;


update dzieci1
set kieszonkowe=kieszonkowe+100
where (trunc(months_between(sysdate,data_ur)/12)>= 10 and kieszonkowe is null) or
(trunc(mod(months_between(sysdate,data_ur),12))+
trunc(months_between(sysdate,data_ur)/12)*12)>126;
select imie, nazwisko, kieszonkowe from dzieci1;

update dzieci1
set imie=upper(substr(imie,1,1))
where (id>=1 and wzrost<180) or kieszonkowe>100;
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;




update dzieci1
set nazwisko=
 upper(substr(nazwisko,1,1))
where (kieszonkowe>150 and wzrost>160) or kieszonkowe>=200;
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;



delete from dzieci1
where (trunc(mod(months_between(sysdate,data_ur),12))+
trunc(months_between(sysdate,data_ur)/12)*12 >=200 and extract(day from data_ur)>15) or to_char(data_ur,'MM')='01';
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;

delete from dzieci1
where regexp_count(nazwisko,'[aeiouAEIOU]')>1 and regexp_count(imie,'[aeiouAEIOU]')=1;
select ID ,
IMIE ,
NAZWISKO ,
WZROST ,
WAGA ,
DATA_UR ,
KIESZONKOWE  from dzieci1;














