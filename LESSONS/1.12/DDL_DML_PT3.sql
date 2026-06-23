---drop table staging.priority_roles;

---SELECT * FROM information_schema.tables 
---WHERE table_schema = 'staging';

create or replace table staging.priority_roles (
    role_id integer primary key,
    role_name varchar,
    priority_lvl integer
);

select * from staging.priority_roles;

insert into staging.priority_roles (role_id, role_name, priority_lvl)
values 
(1, 'Data Engineer', 2),
(2, 'Senior Data Engineer', 1),
(3, 'Software Engineer', 3),
(4, 'Data Scientist', 3);


select * from staging.priority_roles;

