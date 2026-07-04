
--Overview
select * from bookings;

-- 1. Retrieve all successful bookings:
create view sucessful_bookings as
select count(*) from bookings where booking_status = 'Success';

select * from sucessful_bookings; 
-- 2. Find the average ride distance for each vehicle type:
create view avg_vehicle_distance as
select vehicle_type, avg(ride_distance) as avg_distance
from bookings
group by vehicle_type;

select * from avg_vehicle_distance;
-- 3. Get the total number of cancelled rides by customers:
create view canceled_by_customer as
select count(booking_status) from bookings
where booking_status = 'Cancelled by Customer';

select * from canceled_by_customer;
-- 4. List the top 5 customers who booked the highest number of rides:
create view top_customer_by_booking as
select customer_id, count(booking_id)
from bookings
group by customer_id
order by count(booking_id) desc
limit 5;

select * from top_customer_by_booking;
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view cancel_by_driver_PC_issue as
select count(booking_status) from bookings
where reason_for_cancelling_by_driver = 'Personal & Car related issues';

select * from cancel_by_driver_PC_issue;
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
create view max_min_driver_ratings as 
select 
max(driver_ratings) as max_driver_ratings,
min(driver_ratings) as min_driver_ratings
from bookings
where vehicle_type = 'Prime Sedan';

select * from max_min_driver_ratings;
-- 7. Retrieve total number of rides where Vehicle type was Auto:
create view total_auto_rides as
select count(*) from bookings
where vehicle_type = 'Auto';

select * from total_auto_rides;
-- 8. Find the average customer rating per vehicle type:
create view avg_ratings_per_vehicle as
select vehicle_type, avg(customer_rating) as avg_cust_ratings
from bookings
group by vehicle_type;

select * from avg_ratings_per_vehicle;
-- 9. Calculate the total booking value of rides completed successfully:
create view total_value_successful_rides as
select sum(booking_value) as total_booking_value 
from bookings
where booking_status = 'Success';

select * from total_value_successful_rides;
-- 10. List all incomplete rides along with the reason:
create view incomplete_rides_reason as
select booking_id, incomplete_rides_reason
from bookings
where incomplete_rides = 1;

select * from incomplete_rides_reason;