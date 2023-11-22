/*
PC Games Sales
*/


Select * From Games

---Adding a column release_date

Alter Table Games
Add Release_date date
Update Games
Set Release_date = Release


---delete Release column

Alter Table Games
Drop Column Release


---look for Duplicates (No Duplicates Where found)

With RowNumCTE As(
Select *, ROW_NUMBER() Over(
Partition By Name,
             Sales,
			 Series,
			 Genre,
			 Developer,
			 Publisher
			 Order By Name
			 ) row_num
From Games)
Select * From RowNumCTE
Where row_num > 1
Order By row_num


---Deal with Null values [filling missing values with a text (Not available)]

Select Name, Series, COALESCE(Series, 'Not Available') Series_edited From Games

Update Games
Set Series = COALESCE(Series, 'Not Available')

---modify Sales Column (Sales of the game in Millions)

Update Games
Set Sales = Sales*1000000

---The maximum of of Sales

Select MAX(Sales) As largest_sales From Games


---The minimum of Sales

Select MIN(Sales) As smallest_sales From Games

---The Average of Sales

Select AVG(Sales) As AVG_OF_Sales From Games

---The Sum of sales

Select SUM(Sales) As Sum_of_Sales From Games 

---The most Popular genre? (Real-time strategy)

Select Genre, COUNT(Genre) AS Genres_Count From Games
Group By Genre
Order By Genres_Count Desc


--- Which publisher published most of the games? (Electronic Arts)

Select Publisher, COUNT(Publisher) AS Publishers_Count From Games
Group By Publisher
Order By Publishers_Count Desc


--- Which developer developed most of the games? (Blizzard Entertainment)

Select Developer, COUNT(Developer) AS Developers_Count From Games
Group By Developer
Order By Developers_Count Desc
