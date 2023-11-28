/*

Data cleaning using SQL queries

*/

Select * From Egypt_Houses_Price

Select Type, Price, Bedrooms, Bathrooms, Area From Egypt_Houses_Price

--look for missing values

Select * From Egypt_Houses_Price
Where Type Is Null Or Price Is Null Or Bedrooms Is Null Or Bathrooms Is Null Or Area Is Null

-- Delete rows with null values in any of Type, Price, Bedrooms, Bathrooms or Area columns

Delete From Egypt_Houses_Price
Where Type Is Null Or Price Is Null Or Bedrooms Is Null Or Bathrooms Is Null Or Area Is Null

--get the unique values of the type column

Select Distinct(Type) From Egypt_Houses_Price

--update type column

Update Egypt_Houses_Price
Set Type = 'Standalone Villa'
Where Type = 'Stand Alone Villa'

--get the unique values of the type column

Select Distinct(City) From Egypt_Houses_Price

Select * From Egypt_Houses_Price
Where City = '(View phone number)'

-- delete rows where the city column has (View phone number) value

Delete From Egypt_Houses_Price
Where City = '(View phone number)'

--Check for duplicates and delete them

With RowNumCTE As(
Select *, 
         ROW_NUMBER() Over(
		 Partition by Type,
		              Price,
					  Bedrooms,
					  Bathrooms,
					  Area,
					  Furnished,
					  Level,
					  Compound,
					  Payment_Option,
					  Delivery_Date,
					  Delivery_Term,
					  City
					  Order By Type
					  ) row_num
From Egypt_Houses_Price)
Delete From RowNumCTE
Where row_num > 1

--Select * From RowNumCTE
--Where row_num > 1

--Delete Data where Furnished, Delivery Date and Delivery Term is Unknown

Delete From Egypt_Houses_Price
Where Delivery_Date = 'Unknown' Or Delivery_Term = 'Unknown' Or Furnished = 'Unknown'
/* 

Exploring data with SQL queries

*/

Select * From Egypt_Houses_Price

--Type vs Average Price

Select Type, ROUND(AVG(Price),2) As AVG_Price From Egypt_Houses_Price
Group By Type
Order By AVG_Price Desc

--Summary Statistics for Price Column

Select ROUND(AVG(Price),2) As AVG_Price,
       MAX(Price) As Maximum_Price,
	   MIN(Price) As Minimum_Price,
	   ROUND(STDEV(Price),2) As Stand_Dev_Of_Price
From Egypt_Houses_Price

--Summary Statistics for Area Column

Select ROUND(AVG(Area),2) As AVG_Area,
       MAX(Area) As Maximum_Area,
	   MIN(Area) As Minimum_Area,
	   ROUND(STDEV(Area),2) As Stand_Dev_Of_Area
From Egypt_Houses_Price

--What is the most common payment option? (Cash and Installment)

Select Payment_Option, COUNT(Payment_Option) As Counter
From Egypt_Houses_Price
Group By Payment_Option
Order By Counter Desc

--What is the most common Delivery_term? (Finished)

Select Delivery_Term, COUNT(Delivery_Term) As Counter
From Egypt_Houses_Price
Group By Delivery_Term
Order By Counter Desc

--Top 10 most common cities

Select Top 10(City),COUNT(City) As Counter
From Egypt_Houses_Price
Group By City
Order By Counter Desc
