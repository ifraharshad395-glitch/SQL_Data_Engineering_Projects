create database job_mart;

show databases;

select * from information_schema.schemata;

create schema job_mart.staging;

use job_mart;

create schema if not exists staging;

create table preferred_roles (
    role_id integer,
    role_name varchar
);

select * from information_schema.tables 
where table_catalog = 'job_mart';

create table staging.preferred_roles (
    role_id integer,
    role_name varchar
);

drop table main.preferred_roles;


insert into staging.preferred_roles (role_id, role_name)
values (1, 'Data Engineer'),
       (2, 'Data Scientist');

select * from staging.preferred_roles;

insert into staging.preferred_roles (role_id, role_name)
values (3, 'Data Analyst');

drop table staging.preferred_roles;
      
create table if not exists staging.preferred_roles (
    role_id integer primary key,
    role_name varchar
);
select * from information_schema.tables 
where table_catalog = 'job_mart';

select * from staging.preferred_roles;

insert into staging.preferred_roles (role_id, role_name)
values (1, 'Data Engineer'),
       (2, 'Data Scientist');

insert into staging.preferred_roles (role_id, role_name)
values (3, 'Data Analyst');

alter table staging.preferred_roles
add column preferred_role boolean;

update staging.preferred_roles
set preferred_role = true
where role_id = 1 or role_id = 2;


update staging.preferred_roles
set preferred_role = false
where role_id = 3;

alter table staging.preferred_roles
rename to priority_roles;

select * from staging.priority_roles;

alter table staging.priority_roles
rename column preferred_role to priority_lvl;

alter table staging.priority_roles
alter column priority_lvl type integer;

update staging.priority_roles
set priority_lvl = 3 
where role_id = 3;

