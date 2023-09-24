/*

Cleaning Data in SQL Queries


*/


Select * From Sales

--editing the ship date and order date columns' format

Select [Ship Date], CONVERT(date,[Ship Date],105) From Sales

Select [Order Date], CONVERT(date,[Order Date],105) From Sales

Update Sales
Set [Ship Date] = CONVERT(date,[Ship Date],105)

Update Sales
Set [Order Date] = CONVERT(date,[Order Date],105)

---------------------------------------------------------------------------------------------------------------------

--Get the unique values of ship mode, customer name and segment columns

Select Distinct([Ship Mode]) From Sales

Select Distinct([Customer Name]) From Sales

Select Distinct([Sub-Category]) From Sales

----------------------------------------------------------------------------------------------------------------------

--look for missing data (No missing data founded except for order date column)

Select * From Sales
Where Profit IS NULL;

----------------------------------------------------------------------------------------------------------------------

--look for duplicate values (No Duplicates founded)

With RowNumCTE As(
Select *,
         ROW_NUMBER() Over(
		 Partition By [Ship Date],
		              [Row ID],
		              [Ship Mode],
		              [Customer ID],
					  [Customer Name],
					  [Postal Code],
		              [Product ID],
					  [Category],
					  [Sub-Category],
					  [Product Name]
					  Order By [Row ID]
					  ) row_num
From Sales)
Select * From RowNumCTE
Where row_num > 1
Order By [Product ID]

---------------------------------------------------------------------------------------------------------------------------

/*

Exploring data in SQL Queries

*/

--Segment vs Profit

Select Segment, SUM(Profit) As total_profit From Sales
Group By Segment
Order By total_profit Desc;

--Category vs Profit

Select Category, SUM(Profit) As total_profit From Sales
Group By Category
Order By total_profit Desc;

--Sub-Category vs Profit

Select [Sub-Category], SUM(Profit) As total_profit From Sales
Group By [Sub-Category]
Order By total_profit Desc;

--Top 10 customers by profit

Select Top 10[Customer Name], SUM(Profit) As total_profit From Sales
Group By [Customer Name]
Order By total_profit Desc


--Statistical summary of sales


--What is the average of sales?

Select AVG(Sales) As Sales_Average From Sales

--what is the Maximum Value of sales?

Select MAX(Sales) As Sales_max_value From Sales

--what is the Minimum value of sales?

Select MIN(Sales) As Sales_min_value From Sales

--what is the Range of Sales?

Select (MAX(Sales) - MIN(Sales)) As Range_of_sales
From Sales

--what is the standard deviation of sales?

Select STDEV(Sales) As Stand_dev_of_sales
From Sales


--Statistical summary of profit

--What is the average of profit?

Select AVG(Profit) As Profit_Average From Sales

--what is the Maximum Value of profit?

Select MAX(Profit) As Profit_max_value From Sales

--what is the Minimum value of profit?

Select MIN(Profit) As Profit_min_value From Sales

--what is the Range of profit?

Select (MAX(Profit) - MIN(Profit)) As Range_of_profit
From Sales

--what is the standard deviation of profit?

Select STDEV(Profit) As Stand_dev_of_profit
From Sales
