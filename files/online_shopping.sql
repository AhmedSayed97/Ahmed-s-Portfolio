/*

Data cleaning

*/

Select * From online_shopping_dataset

Select CustomerID From online_shopping_dataset

--- check for missing values (31 rows contain missing values)

Select * From online_shopping_dataset
Where CustomerID IS NULL

---delete rows contain missing values

Delete From online_shopping_dataset
Where CustomerID IS NULL

--- check again for missing values

Select * From online_shopping_dataset
Where Gender IS NULL or Location IS NULL or Tenure_Months IS NULL or Transaction_Date IS NULL or Transaction_ID IS NULL or Product_Category IS NULL
or Product_Description IS NULL or Product_SKU IS NULL or Quantity IS NULL or Avg_Price IS NULL or Delivery_Charges IS NULL or Coupon_Status IS NULL
or Discount_pct IS NULL or Offline_Spend IS NULL or Online_Spend IS NULL or Month IS NULL

---delete rows where Discount_pct is Null

Delete From online_shopping_dataset
Where Discount_pct IS NULL

---check for duplicates (no duplicates founded)

With RowNumCTE As(
Select *,
         ROW_NUMBER() OVER(
		 Partition BY CustomerID,
		              Gender,
					  Location,
					  [Tenure_Months],
					  [Transaction_ID],
					  [Product_SKU],
					  [Product_Description],
					  [Product_Category],
					  [Coupon_Status],
					  [Coupon_Code]
					  Order By CustomerID
					  ) row_num
From online_shopping_dataset)
Select * From RowNumCTE
Where row_num > 1


---add new column (total_spend) total_spend = offline_spend + online_spend

Alter Table online_shopping_dataset
ADD Total_Spend Float

Update online_shopping_dataset
Set Total_spend = Offline_Spend + Online_Spend

Select * From online_shopping_dataset

---change data in gender column from M and F to Male and Female

Update online_shopping_dataset
Set Gender = 'Male'
Where Gender = 'M'

Update online_shopping_dataset
Set Gender = 'Female'
Where Gender = 'F'


-----------------------------------------------------------------------------------------------------------

/*

Data exploration

*/

Select * From online_shopping_dataset

---What is the total number of customers? ( 1,468)

Select Distinct(CustomerID) From online_shopping_dataset

---total number of orders per customer. (customer with ID number 12748 has the most number of orders) the most loyal customer

Select CustomerID, COUNT(CustomerID) As orders_count From online_shopping_dataset
Group By CustomerID
Order By orders_count Desc

---Who makes more online purchases men or women? women (32767 females, 19757 males)

Select Gender, Count(Gender) As Gender_count From online_shopping_dataset
Group by Gender
Order by Gender_count Desc

---how many unique locations we have? (5 distinct locations)

Select Distinct(Location) From online_shopping_dataset

---count of orders per location. (the most number of orders were in chicago)

Select Location, Count(Location) As Orders_count From online_shopping_dataset
Group By Location
Order By Orders_count Desc

---count of orders per product_category. (Apparel is the most orderd category)

Select Product_Category, COUNT(Product_Category) As orders_count From online_shopping_dataset
Group By Product_Category
Order By orders_count Desc

---what is the total number of quantities orderd? (236,367)

Select SUM(Quantity) As total_num_of_orderd_quantities From online_shopping_dataset

---count of orders per coupon_status.

Select Coupon_Status, COUNT(Coupon_status) As orders_count From online_shopping_dataset
Group by Coupon_Status
Order by orders_count Desc

---what is the sum of offline_spend? ($148,770,500) Offline_Spend: Amount of money spent offline by the customer.

Select SUM(Offline_Spend) As Sum_of_offline_spend From online_shopping_dataset


---what is the sum of online_spend? ($99,491,823.1) Online_Spend: Amount of money spent online by the customer.

Select SUM(Online_Spend) As Sum_of_online_spend From online_shopping_dataset


---what is the sum of total_spend? ($248,262,323.1)

Select Round(SUM(Total_Spend), 1) As Sum_of_total_spend From online_shopping_dataset

 ---what is the sum of avg_price?($2,753,785.47)

 Select Round(SUM(Avg_Price), 2) As Sum_of_price From online_shopping_dataset

 ---summary statistics table

 Select Product_Category, Round(AVG(Avg_Price), 2) As Avg_price,
MAX(Avg_Price) As Max_price,
Min(Avg_Price) As Min_price,
Round(STDEV(Avg_Price), 2) As Stand_dev_of_price,
Round(AVG(Discount_pct), 2) As Avg_discount_percentage,
MAX(Discount_pct) As Max_discount_percentage,
MIN(Discount_pct) As Min_discount_percentage,
Round(STDEV(Discount_pct), 2) As Stand_dev_of_discount_percentage,
Round(AVG(Delivery_Charges), 2) As Avg_Delivery_Charge,
MAX(Delivery_Charges) As Max_Delivery_Charge,
MIN(Delivery_Charges) As Min_Delivery_Charges,
Round(STDEV(Delivery_Charges), 2) As Stand_dev_of_Delivery_Charges
From online_shopping_dataset
Group by Product_Category


