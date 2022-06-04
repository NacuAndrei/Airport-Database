SET SERVEROUTPUT ON;

DROP TABLE loc CASCADE CONSTRAINTS;
DROP TABLE bilet CASCADE CONSTRAINTS;
DROP TABLE dispune_de CASCADE CONSTRAINTS;
DROP TABLE zbor CASCADE CONSTRAINTS;
DROP TABLE avion CASCADE CONSTRAINTS;
DROP TABLE clasa CASCADE CONSTRAINTS;
DROP TABLE client CASCADE CONSTRAINTS;
DROP TABLE rezervare CASCADE CONSTRAINTS;
DROP TABLE ruta CASCADE CONSTRAINTS;
DROP TABLE echipaj CASCADE CONSTRAINTS;
DROP TABLE numar_locuri CASCADE CONSTRAINTS;
DROP TABLE companie CASCADE CONSTRAINTS;

--4
CREATE TABLE companie
(id_companie VARCHAR2(5) PRIMARY KEY,
denumire_companie VARCHAR2(30),
numar_telefon VARCHAR2(10),
e_mail VARCHAR2(30),
oras_sediu VARCHAR2(25));

CREATE TABLE numar_locuri
(id_nr_loc VARCHAR2(5) PRIMARY KEY,
nr_clasa1 NUMBER(3,0),
nr_clasa2 NUMBER(3,0),
nr_clasaeco NUMBER(3,0));

CREATE TABLE echipaj
(id_echipaj VARCHAR2(5) PRIMARY KEY,
nr_membri NUMBER(2,0),
experienta VARCHAR2(10));

CREATE TABLE ruta
(id_ruta VARCHAR2(5) PRIMARY KEY,
denumire_ruta VARCHAR2(20));

CREATE TABLE rezervare
(id_rezervare VARCHAR2(5) PRIMARY KEY,
data_cumparare DATE,
pret NUMBER(5,0),
data_expirare DATE,
mentiuni VARCHAR2(40));

CREATE TABLE client
(id_client VARCHAR2(5) PRIMARY KEY,
nume VARCHAR2(10),
prenume VARCHAR2(10),
data_nasterii DATE,
telefon VARCHAR2(10),
adresa VARCHAR2(40));

CREATE TABLE clasa
(id_clasa VARCHAR2(5) PRIMARY KEY,
denumire_clasa VARCHAR2(5),
servicii VARCHAR2(40));

CREATE TABLE avion
(id_avion VARCHAR2(5) PRIMARY KEY,
denumire_avion VARCHAR2(15),
id_companie VARCHAR2(5), id_nr_loc VARCHAR2(5), id_echipaj VARCHAR2(5),
CONSTRAINT fk_companie_avion FOREIGN KEY(id_companie)
REFERENCES companie(id_companie),
CONSTRAINT fk_nr_locuri_avion FOREIGN KEY(id_nr_loc)
REFERENCES numar_locuri(id_nr_loc),
CONSTRAINT fk_echipaj_avion FOREIGN KEY(id_echipaj)
REFERENCES echipaj(id_echipaj));

CREATE TABLE zbor
(id_zbor VARCHAR2(5) PRIMARY KEY,
denumire_zbor VARCHAR2(15),
tip_zbor VARCHAR2(15),
data_plecare DATE,
data_sosire DATE,
id_avion VARCHAR2(5), id_ruta VARCHAR2(5),
CONSTRAINT fk_avion_zbor FOREIGN KEY(id_avion)
REFERENCES avion(id_avion),
CONSTRAINT fk_ruta_zbor FOREIGN KEY(id_ruta)
REFERENCES ruta(id_ruta));

CREATE TABLE dispune_de
(id_avion VARCHAR2(5),
id_clasa VARCHAR2(5),
CONSTRAINT id_dispune_de PRIMARY KEY(id_avion, id_clasa),
CONSTRAINT fk_dispune_de_avion FOREIGN KEY(id_avion)
REFERENCES avion(id_avion),
CONSTRAINT fk_dispune_de_clasa FOREIGN KEY(id_clasa)
REFERENCES clasa(id_clasa));

CREATE TABLE bilet
(id_bilet VARCHAR2(5) PRIMARY KEY,
pret_bilet NUMBER(5,0),
data_cumparare date,
id_rezervare VARCHAR2(5), id_client VARCHAR2(5), id_clasa VARCHAR2(5),
CONSTRAINT fk_rezervare_bilet FOREIGN KEY(id_rezervare)
REFERENCES rezervare(id_rezervare),
CONSTRAINT fk_client_bilet FOREIGN KEY(id_client)
REFERENCES client(id_client),
CONSTRAINT fk_clasa_bilet FOREIGN KEY(id_clasa)
REFERENCES clasa(id_clasa));

CREATE TABLE loc
(id_loc VARCHAR2(5) PRIMARY KEY,
nume_loc VARCHAR2(5),
tip_loc VARCHAR2(7),
id_bilet VARCHAR2(5), id_avion VARCHAR2(5),
CONSTRAINT fk_bilet_loc FOREIGN KEY(id_bilet)
REFERENCES bilet(id_bilet),
CONSTRAINT fk_avion_loc FOREIGN KEY(id_avion)
REFERENCES avion(id_avion));

--5
--insert companie
INSERT ALL
INTO companie values ('delt', 'Delta Air Lines', '0735559432', 'office@deltaairlines.us', 'United States')
INTO companie values ('ameri', 'American Airlines Group', '0723452176', 'office@americanairlines.us', 'United States')
INTO companie values ('ryan', 'Ryanair', '0770764321', 'office@ryanair.ie', 'Ireland')
INTO companie values ('luft', 'Lufthansa Group', '0773291631', 'office@lufthansa.de', 'Germany')
INTO companie values ('chi', 'Air China Group', '0731888213', 'office@airchina.cn', 'China')
SELECT  * FROM DUAL;

--insert numar_locuri
INSERT ALL
INTO numar_locuri values ('nr1','30','70','100')
INTO numar_locuri values ('nr2', '100', '100', '100')
INTO numar_locuri values ('nr3', '50', '50', '100')
INTO numar_locuri values ('nr4', '120', '80', '40')
INTO numar_locuri values ('nr5', '90', '50', '60')
SELECT  * FROM DUAL;

--insert echipaj
INSERT ALL
INTO echipaj values('ech1', '14', '10 ani')
INTO echipaj values('ech2', '16', '2 ani')
INTO echipaj values('ech3', '15', '7 ani')
INTO echipaj values('ech4', '13', '1 an')
INTO echipaj values('ech5', '12', '4 ani')
SELECT  * FROM DUAL;

--insert ruta
INSERT ALL
INTO ruta values('r1', 'Bucuresti-Madrid')
INTO ruta values('r2', 'Bucuresti-Roma')
INTO ruta values('r3', 'Bucuresti-Berlin')
INTO ruta values('r4', 'Bucuresti-Amsterdam')
INTO ruta values('r5', 'Bucuresti-Paris')
SELECT  * FROM DUAL;

--insert rezervare
INSERT ALL
INTO rezervare values('re321', '6/june/2021', '200', '16/june/2021', '-')
INTO rezervare values('re107', '5/july/2021', '230', '15/july/2021', '-')
INTO rezervare values('re91', '28/january/2021', '120', '8/february/2021', 'student')
INTO rezervare values('re241', '10/august/2021', '300', '20/august/2021', 'rau de avion')
INTO rezervare values('re697', '12/may/2021', '185', '22/may/2021', 'student')
SELECT  * FROM DUAL;

--insert client
INSERT ALL
INTO client values('c1', 'Dogaru', 'Catalin', '6/august/1989', '0724121766', 'Bucuresti, Compozitorilor 7')
INTO client values('c2', 'Popescu', 'Radu', '3/november/1970', '0770976677', 'Cluj, Costin Nenitescu 1')
INTO client values('c3', 'Croitor', 'Lucian', '20/june/2001', '0723772189', 'Bucuresti, Rasaritului 2')
INTO client values('c4', 'Stoian', 'Laurentiu', '1/april/1960', '0774690332', 'Timisoara, Ciupercilor 3')
INTO client values('c5', 'Ciobanu', 'Victor', '17/october/1993', '07119366', 'Arad, Victoria 6')
SELECT  * FROM DUAL;

--insert clasa
INSERT ALL
INTO clasa values('cl200', '1', 'catering, tv, minibar')
INTO clasa values('cl201', '2', 'catering, minibar')
INTO clasa values('cl202', 'eco', 'catering')
INTO clasa values('cl203', '1 vip', 'catering, tv, minibar, masaj, cuseta')
INTO clasa values('cl204', '2 vip', 'tv, minibar, cuseta')
SELECT  * FROM DUAL;

--insert avion
INSERT ALL
INTO avion values ('b1', 'Boeing 737', 'delt', 'nr3', 'ech2')
INTO avion values ('a1', 'Airbus A320', 'luft', 'nr5', 'ech2')
INTO avion values ('b2', 'Boeing 747', 'chi', 'nr1', 'ech1')
INTO avion values ('b3', 'Boeing 747', 'ameri', 'nr1', 'ech5')
INTO avion values ('a2', 'Airbus A330', 'ryan', 'nr4', 'ech3')
SELECT  * FROM DUAL;

--insert zbor
INSERT ALL
INTO zbor values('z100', 'buc-mad', 'fara escala', '03/june/2021', '03/june/2021', 'b1', 'r1')
INTO zbor values('z101', 'buc-rom', 'fara escala', '05/december/2021', '06/december/2021', 'a2', 'r2')
INTO zbor values('z102', 'buc-ber', 'cu escala', '10/april/2021', '12/april/2021', 'b3', 'r3')
INTO zbor values('z103', 'buc-par', 'fara escala', '06/june/2021', '06/june/2021', 'b2', 'r5')
INTO zbor values('z104', 'buc-ams', 'cu escala', '30/november/2021', '01/december/2021', 'a1', 'r4')
SELECT  * FROM DUAL;

--insert dispune_de
INSERT ALL
INTO dispune_de values ('b1', 'cl200')
INTO dispune_de values ('a1', 'cl201')
INTO dispune_de values ('b2', 'cl202')
INTO dispune_de values ('b3', 'cl203')
INTO dispune_de values ('a2', 'cl204')
INTO dispune_de values ('b1', 'cl204')
INTO dispune_de values ('a1', 'cl203')
INTO dispune_de values ('b2', 'cl200')
INTO dispune_de values ('b3', 'cl202')
INTO dispune_de values ('a2', 'cl203')
SELECT  * FROM DUAL;

--insert bilet
INSERT ALL
INTO bilet values('b73', '140', '3/january/2022','re321', 'c1', 'cl200')
INTO bilet values('b163', '160' , '10/june/2020', 're241', 'c4', 'cl204')
INTO bilet values('b1921', '180', '8/may/2021', 're91', 'c2', 'cl201')
INTO bilet values('b342', '200', '17/november/2021', 're107', 'c3', 'cl202')
INTO bilet values('b7999', '140', '2/july/2020', 're321', 'c1', 'cl200')
SELECT  * FROM DUAL;

--insert loc
INSERT ALL
INTO loc values('lo1', 'loc 1', 'classic', 'b73', 'b1')
INTO loc values('lo2', 'loc 2', 'vip', 'b7999', 'b1')
INTO loc values('lo3', 'loc 3', 'classic', 'b163', 'a1')
INTO loc values('lo4', 'loc 4', 'classic', 'b1921', 'a2')
INTO loc values('lo5', 'loc 5', 'vip', 'b342', 'b3')
SELECT  * FROM DUAL;

--6.  Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind 
--    un subprogram stocat care să utilizeze două tipuri de colecție studiate. Apelați subprogramul.

--Afisati in ordine alfabetica numele clientilor care au achizitionat 
--un bilet in ultimele 4 luni. Se va avisa si data la care a fost cumparat biletul.
CREATE OR REPLACE PROCEDURE p6 
AS
        TYPE tablou IS TABLE OF VARCHAR(50);
        nume tablou;
        TYPE vector IS VARRAY(20) OF bilet.data_cumparare%TYPE;
        data vector;
        CURSOR c IS
            SELECT c.nume || ' ' || c.prenume client, b.data_cumparare data
            FROM client c
            JOIN bilet b ON(b.id_client = c.id_client)
            WHERE months_between(SYSDATE, b.data_cumparare) <= 4
            ORDER BY c.nume;
BEGIN
    OPEN c;
    FETCH c BULK COLLECT INTO nume, data;
    CLOSE c;
    FOR i IN nume.FIRST..nume.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE('Clientul cu numele ' || nume(i));
        DBMS_OUTPUT.PUT_LINE('a achiztionat biletul in data de ' || data(i) || '.');
        DBMS_OUTPUT.PUT_LINE('----------------------------------');
    END LOOP;
END p6;
/

--Apelare
BEGIN
    p6;
END;
/
--7.  Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind 
--    un subprogram stocat care să utilizeze un tip de cursor studiat. Apelați subprogramul.

--    Obtineti pentru fiecare echipaj id-ul acestuia si numarul de membri,
--    specificati pentru fiecare daca cuprinde un numar minim de 15 membri.
CREATE OR REPLACE PROCEDURE p7
AS
        v_nr echipaj.nr_membri%TYPE;
        v_id echipaj.id_echipaj%TYPE;
        CURSOR c IS
            SELECT id_echipaj, nr_membri
            FROM echipaj;
        BEGIN
            OPEN c;
            LOOP
                FETCH c INTO v_id, v_nr;
                EXIT WHEN c%notfound;
                IF v_nr < 15 THEN
                    DBMS_OUTPUT.PUT_LINE('Echipajul ' || v_id || ' cuprinde mai putin de 15 angajati.');
                ELSIF v_nr >= 15 THEN
                    DBMS_OUTPUT.PUT_LINE('Echipajul ' || v_id || ' cuprinde cel putin 15 angajati.');
                END IF;
            END LOOP;
            CLOSE c;
END p7;
/

--Apelare
BEGIN
    p7;
END;
/


--8.  Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind 
--    un subprogram stocat de tip funcție care să utilizeze într-o singură comandă SQL 
--    3 dintre tabelele definite. Tratați toate excepțiile care pot apărea. 
--    Apelați subprogramul astfel încât să evidențiați toate cazurile tratate.

--Pentru echipajul cu cel mai mare numar de membri, afisati denumirea avionului
--cu numar maxim de locuri la clasa 1 intrebuintat echipajului respectiv. 

CREATE OR REPLACE FUNCTION f8
RETURN VARCHAR2 IS
    v_avion   avion.denumire_avion%TYPE;
BEGIN
    SELECT a.denumire_avion
    INTO v_avion
    FROM avion a
    JOIN echipaj e ON(a.id_echipaj = e.id_echipaj)
    JOIN numar_locuri n ON(a.id_nr_loc = n.id_nr_loc)
    WHERE n.nr_clasa1 =
                    (SELECT MAX(nr_clasa1)
                        FROM numar_locuri n1
                        JOIN avion a1 ON a1.id_nr_loc = n1.id_nr_loc
                        WHERE a1.id_echipaj = e.id_echipaj)
    AND e.nr_membri = 
                    (SELECT MAX(nr_membri)
                    FROM echipaj);
    RETURN v_avion;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista avion cu echipaj asignat!');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe avioane cu numar maxim de locuri
                                        la clasa 1 pentru echipajul cerut! / Eixsta mai multe
                                        echipaje cu numar maxim de membri!');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END f8;
/

--Apelare
BEGIN
    DBMS_OUTPUT.PUT_LINE('Denumirea avionului este ' || f8 || '.');
END;
/




--9.  Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind un subprogram stocat 
--    de tip procedură care să utilizeze într-o singură comandă SQL 5 dintre tabelele definite. 
--    Tratați toate excepțiile care pot apărea, incluzând excepțiile NO_DATA_FOUND și TOO_MANY_ROWS. 
--    Apelați subprogramul astfel încât să evidențiați toate cazurile tratate.

--Sa se afiseze numele si prenumele clientului nascut inainte de anul 2000 care a calatorit 
--cu un avion de tip Boeing intrebuintat unui echipaj care are o vechime mai mica de 5 ani.
CREATE OR REPLACE PROCEDURE p9
AS
        v_nume client.nume%TYPE;
        v_prenume client.prenume%TYPE;
BEGIN
    SELECT DISTINCT(c.nume), c.prenume
    INTO v_nume, v_prenume
    FROM client c
    JOIN bilet b ON(b.id_client = c.id_client)
    JOIN loc l ON(l.id_bilet = b.id_bilet)
    JOIN avion a ON(a.id_avion = l.id_avion)
    JOIN echipaj e ON(e.id_echipaj = a.id_echipaj)
    WHERE substr(a.denumire_avion, 1, 6) = 'Boeing'
    AND substr(e.experienta, 1, 1) < 5
    AND c.data_nasterii < '1/january/2000';
                    
    DBMS_OUTPUT.PUT_LINE('Clientul este: ' || v_nume || ' ' || v_prenume || '. ');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Nu exista clienti pentru aceasta cerere!');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Exista mai multi clienti cu acelasi nume! 
                                            / Ati afisat acelasi client de mai multe ori!');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Alta eroare!');
    END p9;
/

--Apelare
BEGIN
    p9;
END;
/

--10. Definiți un trigger de tip LMD la nivel de comandă. Declanșați trigger-ul.

--    Stiind ca la momentul actual serverele nu permit memorarea a mai mult de 8 rezervari,
--    creati un trigger de tip LMD la nivel de comanda care sa nu permita memorarea
--    a unui numar mai mare de 8 rezervari (sunt luate in considerare si cele deja inserate).

CREATE OR REPLACE TRIGGER t10
    AFTER INSERT ON rezervare
    DECLARE
        v_count NUMBER(2);
BEGIN
        SELECT COUNT(*) INTO v_count FROM rezervare;
        IF v_count > 8 THEN
            raise_application_error(-20006, 'Ati atins limita rezervarilor!');
        END IF;
END;
/

--Declansare
BEGIN
    FOR i IN 1..4 LOOP
        INSERT INTO rezervare VALUES(i, '6/june/2021', '200', '16/june/2021', 'test');
    END LOOP;
END;
/

--Stergere
DELETE FROM rezervare WHERE mentiuni like 'test%';
DROP TRIGGER t10;
        

--11. Definiți un trigger de tip LMD la nivel de linie. Declanșați trigger-ul.

--Definiti un trigger de tip LMD care blocheaza cresterea pretului
--unui bilet achizitionat vara.

CREATE OR REPLACE TRIGGER t11
    BEFORE UPDATE OF pret_bilet on bilet
    FOR EACH ROW
BEGIN
        IF (:NEW.pret_bilet > :OLD.pret_bilet) 
            AND (to_char(:OLD.data_cumparare, 'MM') between 6 and 8)  THEN
                raise_application_error(-20007, 'Pretul biletului nu poate fi crescut!');
        END IF;
END;
/

--Declansare
UPDATE bilet
SET pret_bilet = pret_bilet + 200;

--Stergere
DROP TRIGGER t11;


--12. Definiți un trigger de tip LDD. Declanșați trigger-ul.

--Definiti un trigger de tip LDD care permite modificarea schemei doar de catre 
--utilizatorul GRUPA231.

CREATE TABLE istoric
    (utilizator     VARCHAR2(30),
     nume_bd        VARCHAR2(30),
     eveniment      VARCHAR2(30),
     nume_obiect    VARCHAR2(30),
     data           DATE);
/

CREATE OR REPLACE TRIGGER t12
    AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    IF USER != 'GRUPA231' THEN
        raise_application_error(-20008, 'Nu aveti dreptul de a modifica schema!"');
    END IF;
    INSERT INTO istoric VALUES(SYS.login_user, SYS.database_name, SYS.sysevent,
                               SYS.dictionary_obj_name, SYSDATE);
END;
/

--Declansare
ALTER TABLE zbor ADD test VARCHAR(30);
ALTER TABLE zbor DROP COLUMN TEST;
select * 
from istoric;
ROLLBACK;
/
--Stergere
DROP TRIGGER t12;
DROP TABLE istoric;

--13. Definiți un pachet care să conțină toate obiectele definite în cadrul proiectului.
CREATE OR REPLACE PACKAGE pachet_proiect AS
    PROCEDURE p6;
    PROCEDURE p7;
    FUNCTION f8 RETURN VARCHAR2;
    PROCEDURE p9;
END pachet_proiect;
/

CREATE OR REPLACE PACKAGE BODY pachet_proiect AS

--6
--Afisati in ordine alfabetica numele clientilor care au achizitionat 
--un bilet in ultimele 4 luni. Se va avisa si data la care a fost cumparat biletul.
PROCEDURE p6
AS
        TYPE tablou IS TABLE OF VARCHAR(50);
        nume tablou;
        TYPE vector IS VARRAY(20) OF bilet.data_cumparare%TYPE;
        data vector;
        CURSOR c IS
            SELECT c.nume || ' ' || c.prenume client, b.data_cumparare data
            FROM client c
            JOIN bilet b ON(b.id_client = c.id_client)
            WHERE months_between(SYSDATE, b.data_cumparare) <= 4
            ORDER BY c.nume;
BEGIN
    OPEN c;
    FETCH c BULK COLLECT INTO nume, data;
    CLOSE c;
    FOR i IN nume.FIRST..nume.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE('Clientul cu numele ' || nume(i));
        DBMS_OUTPUT.PUT_LINE('a achiztionat biletul in data de ' || data(i) || '.');
        DBMS_OUTPUT.PUT_LINE('----------------------------------');
    END LOOP;
END p6;

--7.
--    Obtineti pentru fiecare echipaj id-ul acestuia si numarul de membri,
--    pecificati pentru fiecare daca cuprinde un numar minim de 15 membri.
PROCEDURE p7
AS
        v_nr echipaj.nr_membri%TYPE;
        v_id echipaj.id_echipaj%TYPE;
        CURSOR c IS
            SELECT id_echipaj, nr_membri
            FROM echipaj;
        BEGIN
            OPEN c;
            LOOP
                FETCH c INTO v_id, v_nr;
                EXIT WHEN c%notfound;
                IF v_nr < 15 THEN
                    dbms_output.put_line('Echipajul ' || v_id || ' cuprinde mai putin de 15 angajati.');
                ELSIF v_nr >= 15 THEN
                    dbms_output.put_line('Echipajul ' || v_id || ' cuprinde cel putin 15 angajati.');
                END IF;
            END LOOP;
            CLOSE c;
END p7;

--8.  
--Pentru echipajul cu cel mai mare numar de membrii, afisati denumirea avionului
--cu numar maxim de locuri la clasa 1 intrebuintat echipajului respectiv. 
FUNCTION f8
RETURN VARCHAR2 IS
    v_avion   avion.denumire_avion%TYPE;
BEGIN
    SELECT a.denumire_avion
    INTO v_avion
    FROM avion a
    JOIN echipaj e ON(a.id_echipaj = e.id_echipaj)
    JOIN numar_locuri n ON(a.id_nr_loc = n.id_nr_loc)
    WHERE n.nr_clasa1 =
                    (SELECT MAX(nr_clasa1)
                        FROM numar_locuri n1
                        JOIN avion a1 ON a1.id_nr_loc = n1.id_nr_loc
                        WHERE a1.id_echipaj = e.id_echipaj)
    AND e.nr_membri = 
                    (SELECT MAX(nr_membri)
                    FROM echipaj);
    RETURN v_avion;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista avion cu echipaj asignat!');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe avioane cu numar maxim de locuri
                                        la clasa 1 pentru echipajul cerut!');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END f8;

--9.
--Sa se afiseze numele si prenumele clientului nascut inainte de anul 2000 care a calatorit 
--cu un avion de tip Boeing intrebuintat unui echipaj are o vechime mai mica de 5 ani.
PROCEDURE p9
AS
        v_nume client.nume%TYPE;
        v_prenume client.prenume%TYPE;
BEGIN
    SELECT DISTINCT(c.nume), c.prenume
    INTO v_nume, v_prenume
    FROM client c
    JOIN bilet b ON(b.id_client = c.id_client)
    JOIN loc l ON(l.id_bilet = b.id_bilet)
    JOIN avion a ON(a.id_avion = l.id_avion)
    JOIN echipaj e ON(e.id_echipaj = a.id_echipaj)
    WHERE substr(a.denumire_avion, 1, 6) = 'Boeing'
    AND substr(e.experienta, 1, 1) < 5
    AND c.data_nasterii < '1/january/2000';
                    
    DBMS_OUTPUT.PUT_LINE('Clientul este: ' || v_nume || ' ' || v_prenume || '. ');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Nu exista clienti pentru aceasta cerere!');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Exista mai multi clienti cu acelasi nume!');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Alta eroare!');
END p9;

END pachet_proiect;
/

--Testare pachet

--6
EXECUTE pachet_proiect.p6;
--7
EXECUTE pachet_proiect.p7;
--8
BEGIN
DBMS_OUTPUT.PUT_LINE('Denumirea avionului este ' || pachet_proiect.f8 || '.');
END;
/
--9
EXECUTE pachet_proiect.p9;