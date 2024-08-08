use master
go
drop database if exists StrikeZoneDB
go
create database StrikeZoneDB
go
use StrikeZoneDB
go


drop table if exists LaneReservation
go
CREATE TABLE LaneReservation
(
    LaneReservationID int primary key identity not null,
    LastName varchar(50) not null constraint ck_LaneReservation_LastName_cannot_be_blank check(LastName <> ''),
    FirstName varchar(50) not null constraint ck_LaneReservation_FirstName_cannot_be_blank check(FirstName <> ''),
    --AS not sure what age you allow, but assuming not less then 4
    Age INT not null constraint ck_LaneReservation_Age_must_be_over_3 check(Age > 3),
    LaneNumber int not null constraint ck_LaneReservation_LaneNumber_must_be_between_1_and_20 check (LaneNumber between 1 and 20),
    ReservationStart datetime not null constraint ck_LaneReservation_ReservationStart_must_be_when_alley_is_open check(datename(WEEKDAY,ReservationStart) <> 'saturday' 
        and convert(time, ReservationStart) BETWEEN '09:00:00' AND '22:30:00'  ),
        --AS This can be added in for real life, since your sample data is old dates, I left it out
        -- constraint ck_LaneReservation_ReservationStart_must_be_in_future check (ReservationStart >= getdate()),
    ReservationEnd datetime not null constraint ck_LaneReservation_ReservationEnd_must_be_before_11pm check(convert(time, ReservationEnd) <= '23:00:00'),
    constraint ck_LaneReservation_ReservationTime_must_be_at_least_30_min check (DATEDIFF(minute, ReservationStart, ReservationEnd) >= 30),
    constraint ck_LaneReservation_ReservationEnd_must_end_on_same_day check (datediff(day, ReservationStart, ReservationEnd) = 0)
);


