use StrikeZoneDB
go

-- Reports: 
-- 1) I want to find out our busiest day of the week, 
-- the busiest time of the day that people start playing
-- and the average time that people spend there.
-- use as many statements as necessary
select DayOfWeek = datename(weekday, l.ReservationStart) , ReservationsCount = count(*) 
from LaneReservation l
group by datename(weekday, ReservationStart)
order by ReservationsCount desc;

-- busiest time of the day
select HourOfDay = datepart(hour, ReservationStart), ReservationsCount = count(*) 
from LaneReservation l
group by datepart(hour, ReservationStart)
order by ReservationsCount desc;

-- average time spent
select AvgTimeSpent =  avg(datediff(minute, l.ReservationStart, l.ReservationEnd))
from LaneReservation l;

-- 2) We would like a list of how many per age group. 
-- Age group brackets: under 18 , 18-30, between 30- 45, and 45+ 
-- The group with the most should go on top.
select AgeGroup =
    case 
        when age < 18 then 'Under 18'
        when age between 18 and 30 then '18-30'
        when age between 31 and 45 then '31-45'
        else '45+' 
    end,
    count(*) as ReservationsCount
from LaneReservation l
group by  case 
        when age < 18 then 'Under 18'
        when age between 18 and 30 then '18-30'
        when age between 31 and 45 then '31-45'
        else '45+' 
    end
order by ReservationsCount desc;


-- 3) All people ages 18 through 30 are joining the league that we are
-- starting and we need a list of them preseted as follows:
-- Last name, first name (age) 

select LeagueMembers = concat(l.LastName, ', ', l.FirstName,' (', l.Age,')')
from LaneReservation l
where Age between 18 and 30
order by LastName, FirstName;

