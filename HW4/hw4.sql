-- SQL Forward Engineering Method 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
#################################
-- schema mydb
drop database if exists huntingtontc; 
create database huntingtontc; 
use huntingtontc; 
#################################
-- CREATE TABLES 
#################################
-- 1) 'actor' table 
drop table if exists actor; 
create table actor (
	actor_id int primary key, 
    actor_name varchar(45) not null, 
    phone varchar(20), 
    email varchar(255) not null
); 
###############################
-- 2) 'production' table 
drop table if exists production; 
create table production (
	production_id int primary key, 
    production_name varchar(50) not null, 
    premier date not null, 
    poster blob not null, 
    play_id int not null, 
constraint fk_production_play foreign key (play_id) references play (play_id)
); 
###############################
-- 3) 'rehearsal' table 
drop table if exists rehearsal; 
create table rehearsal (
	rehearsal_id int primary key, 
    starttime datetime not null, 
    endtime datetime not null, 
    production_id int not null, 
constraint fk_rehearsal_production1 foreign key (production_id) references production (production_id)
); 
###############################
-- 4) 'rehearsal_schedule' table 
drop table if exists rehearsal_schedule; 
create table rehearsal_schedule (
	scene_id int not null, 
    rehearsal_id int not null, 
    minutes int, 
constraint fk_rehearsal_schedule_scene1 foreign key (scene_id) references scene (scene_id), 
constraint fk_rehearsal_schedule_rehearsal1 foreign key (rehearsal_id) references rehearsal (rehearsal_id)
); 
##############################
-- 5) 'scene' table 
drop table if exists scene; 
create table scene (
	scene_id int primary key, 
    scene_title varchar(100) not null, 
    sequence_no int not null, 
    play_id int not null, 
constraint fk_scene_play1 foreign key (play_id) references play (play_id)
); 
##############################
-- 6) 'appears' table 
drop table if exists appears; 
create table appears (
	scene_id int not null, 
    character_id int not null, 
constraint fk_appears_scene1 foreign key (scene_id) references scene (scene_id), 
constraint fk_appears_character1 foreign key (character_id) references character_table (character_id)
); 
##############################
-- 7) 'character_table' table 
drop table if exists character_table; 
create table character_table (
	character_id int primary key, 
    character_name varchar(100) not null, 
    character_description varchar(255), 
    play_id int not null, 
constraint fk_character_play1 foreign key (play_id) references play (play_id)
); 
##############################
-- 8) 'play' table 
drop table if exists play; 
create table play (
	play_id int primary key, 
    title varchar(255) not null, 
    play_description varchar(255), 
    author varchar(255) not null
);
###############################
-- 9) 'cast_table' table 
drop table if exists cast_table; 
create table cast_table (
	actor_id int not null, 
    production_id int not null, 
    character_id int not null, 
constraint fk_cast_table_actor1 foreign key (actor_id) references actor (actor_id), 
constraint fk_cast_table_production1 foreign key (production_id) references production (production_id), 
constraint fk_cast_table_character1 foreign key (character_id) references character_table (character_id)
); 
###############################
-- INSERT DATA 
###############################
-- production table values 
-- 1) 
insert into production values
(1, 'Julius Caesar the Musical','2021-6-12','juliuscaesar.png',1), 
(2, 'Rosencrantz and Guildenstern are Dead','2021-7-18','juliuscaesar.png',2);

insert into play values
(1, 'Julis Caesar', null, 'William Shakespeare'),
(2, 'Rosencrantz and Guildrenstern are Dead', null, 'Tom Sheppard'); 

######
-- 2) 
insert into character_table values
(1,'Caesar', 'Protagonist', 1),
(2, 'Brutus', 'Antagonist - assasinator of Caesar', 1),
(3, 'Cassius', 'Antagonist', 1),
(4, 'Antony', 'Roman general - friend of Caesar', 1), 
(5, 'Portia', 'Widfe of Brutus', 1);

insert into actor values 
(1, "Peter O'Toole", '6179643911', 'otoole@gmail.com'), 
(2, 'Will Smith', '3104322400', 'smithw@gmail.com'), 
(3, 'Brad Pitt', '3102756153', 'bradpitthollywood@gmail.com'),
(4, 'Russell Crowe', '3234161011', 'rcrowe1@gmail.com'),
(5, 'Angelina Jolie', '3102736700', 'ajoliehollywood@gmail.com'), 
(6, 'Scarlett Johansson', '3108990200', 'johanssonhollywood@gmail.com');

insert into cast_table values
(1,1,1),
(2,1,2),
(3,1,3),
(4,1,4),
(5,1,5);

######
-- 3) 
insert into scene values 
(1, 'Act 3 Scene 1', 8, 1), 
(2, 'Act 3 Scene 2', 9, 1); 

insert into appears values
(1,1), 
(1,2), 
(1,3),
(1,4),
(2,2),
(2,3), 
(2,4); 


######
-- 4) 
insert into rehearsal values
(1, '2021-03-15 14:00:00', '2021-03-15 18:00:00', 1), 
(2, '2021-03-16 14:00:00', '2021-03-16 18:00:00', 1); 

insert into rehearsal_schedule values 
(1, 1, 120), 
(2, 1, 120), 
(2, 2, 240); 



