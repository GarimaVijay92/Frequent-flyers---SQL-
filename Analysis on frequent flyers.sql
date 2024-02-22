use frequentflyer;


select Flight_no 
from flight
where Flight_Origin in ('HOU', 'SFO');


select *
from flyer
where Flyer_Name like "%, D%";


select Flight_operator, count(Flight_operator) as n_flights, avg(Miles_per_flight) as avg_miles
from flight
group by Flight_operator
order by avg(Miles_per_flight) desc;



select F.Flight_operator, count(T.Flight_no)
from flight as F, trip as T
where F.Flight_no = T.Flight_no
and T.Flight_fare > 300
group by F.Flight_operator;



select L.Flyer_Name
from flight as F, flyer as L, trip as T
where L.Frequent_Flyer_ID = T.Frequent_Flyer_ID
and F.Flight_no = T.Flight_no
and F.Flight_Destination = 'ATL';



select F.Flight_no, F.Flight_Origin, F.Flight_Destination
from flight as F
inner join flight as T on F.Flight_Origin = T.Flight_Destination
where F.Flight_Destination = T.Flight_Origin;



select Flight_Destination, n_times
from (
      select F.Flight_Destination, count(T.Flight_no) as n_times,
	  RANK() over (order by count(T.Flight_no) desc) as row_rank
from flight as F, trip as T
where F.Flight_no = T.Flight_no
group by F.Flight_Destination) as destination_rank
where row_rank = 1;



select  Book_First_Author, n_times
from(
     select B.Book_First_Author, count(L.Book_Call_No) as n_times,
     RANK() over (order by count(L.Book_Call_No) desc) as row_rank
from book as B, copy as C, loan as L
where B.Book_ISBN = C.Book_ISBN
and C.Book_Call_No = L.Book_Call_No
group by B.Book_First_Author) as book_rank
where row_rank = 1;



select S.Stu_Name, (sum(datediff(L.Due_date, L.Borrow_Date)))*0.1 as Total_Payment_due
from Student as S, Loan as L
where S.Stu_ID = L.Stu_ID
group by S.Stu_ID
order by Total_Payment_due desc

















