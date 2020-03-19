                          --OPPGAVE 1--
--ssh deryau@login.ifi.uio.no
--psql -h dbpg-ifi-kurs -U deryau -d deryau
--\! wget filene --x3--

                          --OPPGAVE 2--

--1--
select timelistelinje.timelistenr
  from timelistelinje
    inner join timeliste
      on timelistelinje.timelistenr = timeliste.timelistenr
  where timeliste.timelistenr = 3;

--2--
select count(timelistenr)
  from timeliste;

--3--
select timelistenr, status, beskrivelse
  from timeliste
  where status != 'utbetalt';

--4--
select timelistenr, sluttid
  from timelistelinje
  where sluttid
    between '00:00:00' and '09:00:00';

--5--
select *
  from timeliste
    inner join timeantall
      on timeliste.timelistenr = timeantall.timelistenr
  where status != 'utbetalt';

--6--
select sum(varighet)/60
  from varighet
    join timelistelinje
      on timelistelinje.linjenr = varighet.linjenr
        and timelistelinje.timelistenr = varighet.timelistenr
  where timelistelinje.startdato
    between '2016-07-01' and '2016-07-31';

--7--
select timelistenr, beskrivelse, linjenr
  from timelistelinje
  where beskrivelse
    like '%Test%';

--8--
select distinct timelistelinje.beskrivelse
  from timeliste, timelistelinje
  where timeliste.status != 'utbetalt';


                            --OPPGAVE 3--

--TIMELISTE--
insert into timeliste (timelistenr, status, levert, utbetalt, beskrivelse)
  values (8, 'utbetalt', '2016-07-29', '2016-08-10', 'planlegging av neste trinn');

insert into timeliste (timelistenr, status, levert, utbetalt, beskrivelse)
  values (9, 'levert', '2016-08-03', null, 'detaljering av neste trinn');

insert into timeliste (timelistenr, status, levert, utbetalt, beskrivelse)
  values (10, 'aktiv', null, null, 'skrivinv av rapport');

--TIMELISTELINJE--
insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (8, 1, '2016-07-25', '10:15:00',' 17:30:00', 50, 'diskusjoner');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (8, 2, '2016-07-25', '12:45:00', '14:00:00', null, 'konkretisering');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (9, 1, '2016-07-27', '15:15:00', '18:45:00', 70, 'del 1');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (9, 2, '2016-07-28', '10:00:00', '14:00:00', 35, 'del 2');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (9, 3, '2016-07-28', '21:00:00', '04:15:00', 90, 'del 3');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (9, 4, '2016-08-02', '13:00:00', '17:0:00', null, 'del 4');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (9, 3, '2016-07-28', '21:00:00', '04:15:00', 90, 'del 3');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (10, 1, '2016-08-03', '10:50:00', '16:10:00',40, 'kap1');

insert into timelistelinje (timelistenr, linjenr, startdato, starttid, sluttid, pause, beskrivelse)
  values (10, 2, '2016-08-05', '18:00:00', null ,null, 'kap2');


                                  --OPPGAVE 4--
--SKJEKKER FOR TIMELISTE--
select * from timeliste where timelistenr between 8 and 10;

--SKJEKKER FOR TIMELISTELINJE--
select * from timelistelinje where timelistenr >= 8;
