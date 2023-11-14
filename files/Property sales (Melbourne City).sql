/*
Cleaning Data in SQL Queries
*/

Select * From ['Property Sales of Melbourne City']

---standardize date format

Alter Table ['Property Sales of Melbourne City']
Add Sale_Date Date

Update ['Property Sales of Melbourne City']
Set Sale_Date = CONVERT(Date, Date)

---changing data in Type Column from 'h', 't' and 'u' to 'house', 'town house' and 'unit'

Select Type,
Case
    When Type = 'h' Then 'House'
	When Type = 't' Then 'Town House'
	Else 'Unit'
	End
From ['Property Sales of Melbourne City']

Update ['Property Sales of Melbourne City']
Set Type = Case
    When Type = 'h' Then 'House'
	When Type = 't' Then 'Town House'
	Else 'Unit'
	End


---changing the data in Method column From 'S','SP','PI','PN','SN','VB','W' and 'SA' to 'property sold','property sold prior','property passed in','sold prior not disclosed','sold not disclosed','vendor bid','withdrawn prior to auction' and 'sold after auction'

Select Method,
Case
    When Method = 'S' Then 'property sold'
	When Method = 'SP' Then 'property sold prior'
	When Method = 'PI' Then 'property passed in'
	When Method = 'PN' Then 'sold prior not disclosed'
	When Method = 'SN' Then 'sold not disclosed'
	When Method = 'VB' Then 'vendor bid'
	When Method = 'W' Then 'withdrawn prior to auction'
	Else 'sold after auction'
	End
From ['Property Sales of Melbourne City']

Update ['Property Sales of Melbourne City']
Set Method = Case
    When Method = 'S' Then 'property sold'
	When Method = 'SP' Then 'property sold prior'
	When Method = 'PI' Then 'property passed in'
	When Method = 'PN' Then 'sold prior not disclosed'
	When Method = 'SN' Then 'sold not disclosed'
	When Method = 'VB' Then 'vendor bid'
	When Method = 'W' Then 'withdrawn prior to auction'
	Else 'sold after auction'
	End


---deleting unused columns

Select * From ['Property Sales of Melbourne City']

Alter Table ['Property Sales of Melbourne City']
Drop Column Date, Lattitude, Longtitude, CouncilArea, YearBuilt, Column1, Propertycount



---check if there are duplicates

With RowNumCTE As(
Select *,
ROW_NUMBER() OVER( 
PARTITION BY Address,
             Suburb,
			 Type,
			 Method,
			 SellerG,
			 Postcode
			 ORDER BY Suburb
			 ) row_num

From ['Property Sales of Melbourne City']
)
Select * From RowNumCTE
Where row_num > 1
ORDER BY Suburb


---deleting duplicates

With RowNumCTE As(
Select *,
ROW_NUMBER() OVER( 
PARTITION BY Address,
             Suburb,
			 Type,
			 Method,
			 SellerG,
			 Postcode
			 ORDER BY Suburb
			 ) row_num

From ['Property Sales of Melbourne City']
)
Delete From RowNumCTE
Where row_num > 1


---dealing with missing data

Select * From ['Property Sales of Melbourne City']
Where Bedroom IS NULL And Bathroom IS NULL And Car IS NULL And Landsize IS NULL And BuildingArea IS NULL 


---filling the missing data with 0

Update ['Property Sales of Melbourne City']
Set Bedroom = ISNULL(Bedroom, 0), Bathroom = ISNULL(Bathroom, 0), Car = ISNULL(Car, 0),
Landsize = ISNULL(Landsize, 0), BuildingArea = ISNULL(BuildingArea, 0)
