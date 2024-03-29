/*
Data Cleaning
*/

Select * From Fashion_Retail_Sales

Select [Customer Reference ID] From Fashion_Retail_Sales

Select [Item Purchased] From Fashion_Retail_Sales

Select [Payment Method] From Fashion_Retail_Sales

Select [Purchase Amount (USD)] From Fashion_Retail_Sales



--- check for duplicates (no duplicates found)


With RowNumCTE As(
Select *, 
         ROW_NUMBER() Over(
		 Partition by [Customer Reference ID],
		              [Item Purchased],
					  [Payment Method],
					  [Date Purchase],
					  [Purchase Amount (USD)]
					  Order By [Customer Reference ID]
					  ) row_num
From Fashion_Retail_Sales)
Select * From RowNumCTE
where row_num > 1


---check for missing values (some missing values found)

Select * From Fashion_Retail_Sales
Where [Purchase Amount (USD)] Is Null

---delete rows with missing values in the purchase amount column

Delete From Fashion_Retail_Sales
Where [Purchase Amount (USD)] Is Null

---check for outliers

Select [Item Purchased], [Purchase Amount (USD)],
([Purchase Amount (USD)] - AVG([Purchase Amount (USD)]) OVER())/STDEV([Purchase Amount (USD)]) OVER() As Zscore
From Fashion_Retail_Sales


Select * From
(Select [Item Purchased], [Purchase Amount (USD)],
([Purchase Amount (USD)] - AVG([Purchase Amount (USD)]) OVER())/STDEV([Purchase Amount (USD)]) OVER() As Zscore
From Fashion_Retail_Sales) as zscore_table
Where Zscore>3 or Zscore<-3
----------------------------------------------------------------------------------------

/*
Data Exploration
*/

Select * From Fashion_Retail_Sales

---Top 10 best-selling items

Select Top 10([Item Purchased]), SUM([Purchase Amount (USD)]) as Total_sales_in_USD, Round(AVG([Review Rating]),2) As Review_rating
From Fashion_Retail_Sales
Group by [Item Purchased]
Order by Total_sales_in_USD Desc

---The total sales is $430,952.

Select SUM([Purchase Amount (USD)]) as Total_sales From Fashion_Retail_Sales


---most used payment method? (Credit Card is the most used Payment method)

Select [Payment Method], COUNT([Payment Method]) as Payment_Method_Counter
From Fashion_Retail_Sales
Group by [Payment Method]
Order by Payment_Method_Counter Desc


---Adding new columns 

Alter Table Fashion_Retail_Sales
Add year int

Alter Table Fashion_Retail_Sales
Add month int

---update table
Update Fashion_Retail_Sales
Set month = DATEPART(month, [Date Purchase])

Update Fashion_Retail_Sales
Set year = DATEPART(year, [Date Purchase])


---which month in 2023 has the most Sales? ( May )

Select Top 1 (month), SUM([Purchase Amount (USD)]) As Total_sales
From Fashion_Retail_Sales
Where year = 2023
Group by month
Order by Total_sales Desc


---summary statistics table

Select [Item Purchased] ,AVG([Purchase Amount (USD)]) As Average_of_sales,
STDEV([Purchase Amount (USD)]) As Standard_deviation_of_sales,
MAX([Purchase Amount (USD)]) As Maximum_of_sales,
MIN([Purchase Amount (USD)]) As Minimum_of_sales
From Fashion_Retail_Sales
Group by [Item Purchased]

