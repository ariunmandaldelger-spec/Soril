
Create database hospital_db;
Use hospital_db;

create table patients (
	patient_id int primary key auto_increment,
    name varchar(100) not null,
    age int,
    gender varchar(10),
    phone varchar(15) unique
);
create table doctors(
	doctor_id int primary key auto_increment,
    name varchar(100) not null,
    specialty varchar(100),
    phone varchar(15) unique
);
create table appointments (
	appointments_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    appointment_date date,
    
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor)
);
create table prescriptions(
	prescription_id int primary key auto_increment,
    appointment_id int,
    medicine varchar(100),
    dosage varchar(50),
    
    foreign key (appointment_id) references appointments(appointment_id)
);

insert into patients (name, age, gender, phone)
values
('bat', 25, 'male', '99999999'),
('sara', 50, 'famale', '88888888');
insert into doctors (name, specialty, phone)
values
('Dr.Aaw', 'asd', '99119911'),
('Anhaa', 'sss', '99330575');
insert into appointments (patient_id, doctor_id, appointment_date)
values
(1, 1, '2026-03-25'),
(2, 1, '2026-03-24'),
(1, 2, '2026-03-23');
insert into prescriptions (appointment_id, medicane, dosage)
values
(1, 'Haluunii em', '1 udaa/udurt'),
(2, 'ibuprofen denk', '100udaa/udurt');

select p.name as patient, d.name as doctor, a.appointment_date
from appointments a
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id;
select d.name, count(a.patient_id) as total_patients
from doctors d 
join appointments a on a.doctor_id = a.doctor_id
group by d.name;

select p.name, count(*) as visit_count
from patients p
join appointments a on p.patient_id = a.patient_id
group by p.name
having count(*) >= 2;



create user 'admin_user'@'localhost' identified by '1413';
create user 'report_user'@'localhost' identified by '1413';
grant all privileges on hospital_db.* to 'admin_user'@'localhost';
grant select on hospital_db.* to 'report_user'@'localhost';
show grants for 'admin_user'@'localhost';
show grants for 'report_user'@'localhost';
flush privileges;
