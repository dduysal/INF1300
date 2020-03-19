--OPPGAVE 1--
select filmcharacter, count(filmcharacter)
from filmcharacter
group by filmcharacter
having count(*) > 800
order by filmcharacter desc;

--OPPGAVE 2--
select person.personid, person.firstname, person.lastname, filmcountry.country, film.title, filmcharacter.filmcharacter
from filmparticipation
left join person
on filmparticipation.personid = person.personid
left join film on filmparticipation.filmid = film.filmid
left join filmcountry on filmparticipation.filmid = filmcountry.filmid
left join filmcharacter on filmparticipation.partid = filmcharacter.partid
where filmcharacter.filmcharacter like 'Ingrid' and person.firstname like 'Ingrid';

--OPPGAVE 3--
select person.firstname, person.lastname, filmcharacter.filmcharacter
from filmparticipation
inner join person on filmparticipation.personid = person.personid
inner join filmcharacter on filmparticipation.partid = filmcharacter.partid
inner join film on filmparticipation.filmid = film.filmid
where person.personid = 3914169 and filmcharacter.filmcharacter is not null;

--OPPGAVE 4--
select person.personid, person.firstname, person.lastname, count(filmcharacter.filmcharacter) from person
inner join filmparticipation
  on person.personid = filmparticipation.personid
inner join filmcharacter
  on filmparticipation.partid = filmcharacter.partid
where filmcharacter.filmcharacter like 'Ingrid'
group by person.personid, person.firstname, person.lastname
order by count(filmcharacter.filmcharacter) desc
limit 1;

--OPPGAVE 5--
select person.firstname, count(filmcharacter)
from filmcharacter
inner join person
  on filmcharacter.filmcharacter = person.firstname
where filmcharacter.filmcharacter
  like person.firstname;
group by person.firstname, filmcharacter.filmcharacter;

--OPPGAVE 6--
select film.title, filmparticipation.parttype, count(filmparticipation.parttype)
from filmparticipation
join film on filmparticipation.filmid = film.filmid
join filmitem on film.filmid = filmitem.filmid
where film.title like '%Lord of the Rings%' and filmitem.filmtype like 'C'
group by film.title, filmparticipation.parttype;

--OPPGAVE 7--
select film.title, filmgenre.genre from film
inner join filmgenre on film.filmid = filmgenre.filmid
where filmgenre.genre like 'Film-Noir'
  and filmgenre.filmid = any (
  select filmid
  from filmgenre
  where genre = 'Comedy');

--OPPGAVE 8--
select film.filmid, film.title, count(filmgenre.genre)
  from film
left join filmgenre on filmgenre.filmid = film.filmid
where film.title like '%Antoine %'
group by film.filmid, film.title;

--To mulige løsninger, de begge får får feil resultat, men kommer ikke på noe annet å gjøre
--OPPGAVE 9--
with unikrolle as (
  select filmcharacter, partid, count(filmcharacter)
    from filmcharacter
group by filmcharacter, partid
having count(filmcharacter.filmcharacter) = 1
)
select unikrolle.filmcharacter, person.firstname, person.lastname, count(film.title) as film
  from filmparticipation
natural join person
natural join film
natural join unikrolle
group by unikrolle.filmcharacter, person.firstname, person.lastname
having count(film.title) > 199;

--ANDRE LØSNING--
with unikrolle as (
  select partid, count(filmcharacter)
    from filmcharacter
  group by filmcharacter, partid
  having count(filmcharacter.filmcharacter) = 1
),

unikfilm as (
  select unikrolle.partid, count(title)
    from film
  natural join unikrolle
  group by unikrolle.partid
  having count(title) > 199
)

select unikrolle.partid, person.firstname, person.lastname
from filmparticipation
natural join unikrolle
natural join person
natural join unikfilm;
limit 13;
