

create table soldier(
id int unsigned primary key auto_increment,
id_enlisted_rank int unsigned not null,
id_warrant_officer_rank int unsigned not null,
id_officer_rank int unsigned not null,
id_mother int unsigned not null,
id_father int unsigned not null,
id_spouse int unsigned not null,
id_medical int unsigned not null,
id_vaccine int unsigned not null,
id_arms int unsigned not null,
id_bank int unsigned not null,
first_name varchar(55) not null,
last_name varchar(55) not null,
social_security_number varchar(9) not null,
phone varchar(10) not null,
citizenship varchar(50) not null,
degree varchar(50) not null check(degree in('High School','College','Masters','PhD')),
is_married varchar(3) not null check(is_married in('YES','NO')),
constraint check_married check(is_married='NO' and is_married='YES'),

constraint fk_enlisted foreign key (id_enlisted_rank) references enlisted_ranks(id),
constraint fk_warrant foreign key (id_warrant_officer_rank) references warrant_officer_ranks(id),
constraint fk_officer foreign key (id_officer_rank) references officer_ranks(id),
constraint fk_mother foreign key (id_mother) references mother(m_id),
constraint fk_father foreign key (id_father) references father(f_id),
constraint fk_spouse foreign key (id_spouse) references spouse(s_id),
constraint fk_medical foreign key (id_medical) references medical(med_id),
constraint fk_vaccine foreign key (id_vaccine) references vaccine(v_id),
constraint fk_arms foreign key (id_arms) references arms_used(a_id),
constraint fk_bank foreign key (id_bank) references bank(b_id));


create table enlisted_ranks(
id int unsigned primary key auto_increment,
rank_name varchar(100) not null, 
constraint rank_insignia_enlisted check(rank_name='PV1' and rank_name='PV2' and rank_name='PFC' and rank_name='SPC' and rank_name='CPL' and rank_name='SGT' and rank_name='SSG' and rank_name='SFC' and rank_name='MSG' and rank_name='1SG' and rank_name='SGM' and rank_name='CSM' and rank_name = 'SMA' and rank_name='SEAC')
);
create table warrant_officer_ranks(
id int unsigned primary key auto_increment,
rank_name varchar(100) not null, 
constraint rank_insignia_warrant check(rank_name='WO1' and rank_name='CW2' and rank_name='CW3' and rank_name='CW4' and rank_name='CW5'));
create table officer_ranks(
id int unsigned primary key auto_increment,
rank_name varchar(100) not null, 
constraint rank_insignia_officer check(rank_name='2LT' and rank_name='1LT' and rank_name='CPT' and rank_name='MAJ' and rank_name='LTC' and rank_name = 'COL' and rank_name='BG' and rank_name='MG' and rank_name='LTG' and rank_name='GEN')
);

create table mother(
m_id int unsigned primary key auto_increment,
first_name varchar(55) not null,
last_name varchar(55) not null,
m_dob date not null,
mail varchar(55) not null,
phone varchar(10) not null,
city varchar(20) not null,
age tinyint not null check(age between 0 and 100),
state varchar(20) not null
);
create table father(
f_id int unsigned primary key auto_increment,
first_name varchar(55) not null,
last_name varchar(55) not null,
m_dob date not null,
mail varchar(55) not null,
phone varchar(10) not null,
city varchar(20) not null,
age tinyint not null check(age between 0 and 100),
state varchar(20) not null
);

create table spouse(
s_id int unsigned primary key auto_increment,
first_name varchar(55) not null,
last_name varchar(55) not null,
m_dob date not null,
mail varchar(55) not null,
phone varchar(10) not null,
city varchar(20) not null,
age varchar(20) not null,
state varchar(20) not null,
constraint check_age_s check(age between 0 and 100)
);

create table medical(
med_id int unsigned primary key auto_increment, 
height float,
weight decimal(3,2),
is_diabetic varchar(3) not null check(is_diabetic in ('YES', 'NO'))
);

CREATE TABLE vaccine (
    v_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    polio VARCHAR(18) NOT NULL CHECK (polio IN ('vaccined' , 'not vaccined')),
    tetanus VARCHAR(18) NOT NULL CHECK (tetanus IN ('vaccined' , 'not vaccined')),
    DDT VARCHAR(18) NOT NULL CHECK (DDT IN ('vaccined' , 'not vaccined')),
    HIV VARCHAR(18) NOT NULL CHECK (HIV IN ('vaccined' , 'not vaccined')),
    POX VARCHAR(18) NOT NULL check(POX in ('vaccined','not vaccined'))
);

create table arms_used(
    a_id int unsigned primary key auto_increment,
    M17 varchar(3) not null check(M17 in ('YES', 'NO')),
    XM7 varchar(3) not null check(XM7 in ('YES', 'NO')),
    M4A1 varchar(3) not null check(M4A1 in ('YES', 'NO')),
    M249 varchar(3) not null check(M249 in ('YES', 'NO')),
    M107 varchar(3) not null check(M107 in ('YES', 'NO')),
    M67 varchar(3) not null check(M67 in ('YES', 'NO')),
    M141 varchar(3) not null check(M141 in ('YES', 'NO'))
);

create table bank(
b_id int unsigned primary key auto_increment,
value decimal(10,2) not null,
bank_name varchar(20) not null
);

create or replace view soldier_data as
select s.id, concat(s.first_name,' ',s.last_name) as name, s.social_security_number , s.phone, s.citizenship,s.degree, s.is_married as Married, 
e.rank_name as Enlisted_Rank, w.rank_name as Warrant_Officer_Rank, o.rank_name as Officer_Rank, 
concat(mo.first_name,' ',mo.last_name) as mother_name, concat(f.first_name,' ',f.last_name) as father_name,
concat(sp.first_name,' ',sp.last_name) as spouse_name, med.height, med.weight, v.polio, v.tetanus, v.DDT, v.HIV, v.POX,
a.M17, a.XM7, a.M4A1, a.M249, a.M107, a.M67, a.M141
from soldier as s
left join enlisted_ranks as e on s.id_enlisted_rank = e.id
left join warrant_officer_ranks as w on s.id_warrant_officer_rank = w.id
left join officer_ranks as o on s.id_officer_rank = o.id
left join mother as mo on s.id_mother = mo.m_id
left join father as f on s.id_father = f.f_id
left join spouse as sp on s.id_spouse = sp.s_id
left join medical as med on s.id_medical = med.med_id
left join vaccine as v on s.id_vaccine = v.v_id
left join arms_used as a on s.id_arms = a.a_id
where s.citizenship = 'American';     



select * from soldier_data;

