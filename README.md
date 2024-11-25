# Project Title
Marketing Analysis

## Problem Statement
ShopEasy is experiencing a decline in customer engagement and conversion rates despite increased investments in marketing campaigns. The company seeks to identify the root causes of this issue by analyzing campaign performance data, customer reviews, and social media feedback to uncover insights into customer needs, pain points, and marketing inefficiencies. The goal is to optimize marketing strategies, enhance customer satisfaction, and improve ROI.

### Steps followed 

- Step 1 : Load data into Ms-SQL.
- Step 2 : Extracted data from Dim_Customers, Dim_Products, Facts_Customer_Review, Facts_Customer_Journey and Facts_Engagement_Data tables.

Snap of Dim_Customer table ,

Selected Columns: Retrieved customer details (CustomerID, Name, Email, Gender, Age) and geographic data (Country, City). Used Table Aliases: Assigned c for Dim_Customers and g for Dim_Geography for readability.Performed a LEFT JOIN: Combined customer data with geographic information, ensuring all customers were included. Specified Join Condition: Joined tables on the GeographyID field to match related records. Added Comments: Documented each part of the query for clarity. Reviewed Results: Verified the query output, ensuring accurate data combination.

![Snap_1]![Dim_Customers](https://github.com/user-attachments/assets/dd0bd27f-7aae-4b6a-8375-79d2506b0ded)

Snap of Dim_Products table ,

The query retrieves product details (ProductID, ProductName, Price, and Category) from the dbo.products table and adds a new column PriceCategory. This column categorizes products based on their price:        
 Low: Price < $50    
 Medium: Price between $50 and $200  
 High: Price > $200  
This helps with price-based analysis and segmentation.
  
![Snap_2]![Dim_Products](https://github.com/user-attachments/assets/ec4b06c6-7616-4269-b81e-350a1a2b6944)
 
Snap of Facts_Customer_Review table ,

The query retrieves review details (ReviewID, CustomerID, ProductID, ReviewDate, Rating) and cleans up ReviewText by replacing double spaces with single spaces using the REPLACE function, improving text readability and standardization in the dbo.customer_reviews table.

![Snap_3]![Facts_Customer_Review](https://github.com/user-attachments/assets/843daa75-7867-43d9-9dba-2ae9ab3712d4)

Snap of Facts_Customer_Journey table ,

The query cleans and standardizes customer journey data by:
 Removing Duplicates: Groups records by key columns and keeps only the first occurrence in each group.   
 Handling Missing Values: Replaces missing Duration values with the average duration for the same VisitDate.  
 Standardization: Converts Stage to uppercase and formats data for consistency.   
 This improves data integrity and quality for analysis like customer journey tracking and performance evaluation.

![Snap_4]![Facts_Customer_Journey](https://github.com/user-attachments/assets/b088dd8f-f240-4cda-ab83-271ad56d42a7)

Snap of Facts_Engagement_Data table ,

The query cleans and normalizes engagement data by:   
Standardizing ContentType: Replaces "Socialmedia" with "Social Media" and converts all values to uppercase.   
Extracting Metrics: Splits ViewsClicksCombined to extract Views and Clicks.   
Formatting Dates: Converts EngagementDate to dd.mm.yyyy.
Filtering Data: Excludes rows with ContentType = 'Newsletter'.  
This prepares the data for analyzing engagement metrics and content performance.  

![Snap_5![Facts_Engagement_Data](https://github.com/user-attachments/assets/7fbfa861-05b0-49b0-a818-c83e7339700b)

- Step 3 : Loaded all the different tabled in Power BI to create dashboard. 
- Step 4 : Create relationship between tables.

![Snap_6![Relationship table](https://github.com/user-attachments/assets/c2b35963-2e28-48b2-b0e9-f7b858460587)

- Step 5 : Measures for Engagement and Conversion Tracking

This repository includes a set of custom Power BI DAX measures designed for analyzing customer engagement, campaign performance, and conversion metrics. The measures encompass a variety of key performance indicators (KPIs), including: Clicks, Conversion Rate, Likes, Campaign Engagements, Campaigns, Customer Journey, Customer Reviews, Rating (Average) and Views.
These measures are designed to provide valuable insights into customer behavior, marketing effectiveness, and product feedback in a visual, easily accessible Power BI dashboard.

1.	Clicks = SUM(fact_engagement_data[Clicks])       

2.	Conversion Rate = 
VAR TotalVisitors = CALCULATE( COUNT (fact_customer_journey[JourneyID]) , fact_customer_journey[Action] = "View" )    
VAR TotalPurchases = CALCULATE(         
    COUNT(fact_customer_journey[JourneyID]),        
    fact_customer_journey[Action] = "Purchase"  
)  
RETURN  
IF(  
    TotalVisitors = 0,   
    0,  
    DIVIDE(TotalPurchases, TotalVisitors)  
)  

3.	Likes = SUM(fact_engagement_data[Likes])  

4.	Number of Campaign Engagements = DISTINCTCOUNT(fact_engagement_data[EngagementID])

5.	Number of Campaings = DISTINCTCOUNT(fact_engagement_data[CampaignID])

6.	Number of Customer Jounery = DISTINCTCOUNT(fact_customer_journey[JourneyID])

7.	Number of Customer Reviews = DISTINCTCOUNT( fact_customer_reviews_with_segemnts[ReviewID])

8.	Rating (Average) = AVERAGE(fact_customer_reviews_with_segemnts[Rating])

9.	Views = SUM(fact_engagement_data[Views])

- Step 6 : Dynamic Calendar Table in DAX
This DAX script creates a Calendar Table spanning from January 1, 2023, to December 31, 2025, with calculated columns for time-based analysis:  
- Date, DateAsInteger, Year, MonthNumber, YearMonthShort, MonthNameShort, DayOfWeek, Quarter, and YearQuarter.
- Simplifies time-based reporting and analysis with standardized columns for months, quarters, days, and more.

 Calendar =   
ADDCOLUMNS (     
    CALENDAR ( DATE ( 2023, 1, 1 ), DATE ( 2025, 12, 31 ) ),       
    "DateAsInteger", FORMAT ( [Date], "YYYYMMDD" ),  
    "Year", YEAR ( [Date] ),  
    "Monthnumber", FORMAT ( [Date], "MM" ),  
    "YearMonthnumber", FORMAT ( [Date], "YYYY/MM" ),  
    "YearMonthShort", FORMAT ( [Date], "YYYY/mmm" ),  
    "MonthNameShort", FORMAT ( [Date], "mmm" ),  
    "MonthNameLong", FORMAT ( [Date], "mmmm" ),  
    "DayOfWeekNumber", WEEKDAY ( [Date] ),   
    "DayOfWeek", FORMAT ( [Date], "dddd" ),   
    "DayOfWeekShort", FORMAT ( [Date], "ddd" ),   
    "Quarter", "Q" & FORMAT ( [Date], "Q" ),   
    "YearQuarter",    
        FORMAT ( [Date], "YYYY" ) & "/Q"   
            & FORMAT ( [Date], "Q" )  
)

- Step 7 : Added three different slicers named "Year", "MonthShort" and "Product Name" to filter the data and see different results for analysis on all the three pages.

Overview:
![Snap_7]![Overview ](https://github.com/user-attachments/assets/47af8e10-a624-4309-b899-b2c571ef999d)

The dashboard shows a 9.6% overall conversion rate, with 9.1M views, 1.8M clicks, 414K likes, and an average rating of 3.7. The Baseball Glove has the highest conversion rate (20%), while the Climbing Rope has the lowest (0%). Golf Clubs lead in views (1M), and Dumbbells have the least in both views (60K), clicks (40K), and likes (30K). Volleyball has the highest rating (3.8), while Tennis Racket has the lowest (3.6). Trends show an increase in conversion rates, but views, clicks, and likes are declining. Recommendations include improving the Climbing Rope's conversion rate, promoting high-rated low-converting products, and addressing the declining trends in engagement.

Conversion Details:
![Snap_8]![Conversion Details](https://github.com/user-attachments/assets/36b7d527-8aea-45e8-8c09-e94485bb0c71)

The dashboard shows an overall conversion rate of 9.6%, with 2K views, 16 clicks, 1K drop-offs, and 1K purchases. The Hockey Stick leads in conversion rate (22.2%) and purchases (1K), while Dumbbells show the lowest in views, clicks, drop-offs, and purchases. Baseball Glove has the highest views (2K), and Soccer Ball generates the most clicks (2K). The conversion rate trend is generally increasing, with a dip in May. Key insights highlight that the highest conversion rate corresponds with the highest purchases, and the lowest conversion rate correlates with the lowest purchases. Recommendations include improving Climbing Rope's conversion rate and addressing the declining trends in views, clicks, and drop-offs.

Social Media Details:
![Snap_9]![Social Media Details](https://github.com/user-attachments/assets/78741bf4-0553-41b5-a5f2-3e3b23078738)

The dashboard shows 9.1 million views, 1.8 million clicks, and 414,122 likes overall. Golf Clubs have the highest views (1M), while Dumbbells have the lowest in views (60K), clicks (40K), and likes (30K). Soccer Ball leads in clicks (230K), and Kayaks generate the most likes (220K). There is a decreasing trend in views, clicks, and likes over time. Key insights highlight that products with the highest views also have the most clicks, while the lowest views also correlate with the lowest clicks. Recommendations include investigating the reasons behind the decline in engagement metrics.

Customer Review Details:
![Snap_10]![Customer Review Details](https://github.com/user-attachments/assets/066508e1-85ab-4e60-aa8f-20717a72698c)

The dashboard reveals that the average customer rating is 3.7, with the majority of reviews being positive (409), followed by mixed positive (290), mixed negative (153), neutral (86), and negative (196). The highest-rated products are Volleyball and Yoga Mat (4.5) and Basketball (4.2), while Swim Goggles (2.6) and Tennis Racket (3.0) have the lowest ratings. Positive sentiment peaks in December, while negative sentiment is highest in September. The Tennis Racket has the most reviews (5025), and Dumbbells have the least (11). The most common sentiment is positive, and the most common rating is 4. Recommendations include improving Swim Goggles and Tennis Racket ratings, promoting high-rated products, and investigating the negative sentiment spike in September.

Conclusion:
The dashboard shows a 9.6% overall conversion rate, with some products performing well, like the Baseball Glove and Hockey Stick, while others, such as the Climbing Rope and Dumbbells, are underperforming in conversion and engagement. Social media metrics are declining, and customer ratings are mixed, with products like Swim Goggles and Tennis Racket receiving low ratings. To improve performance, focus on increasing Climbing Rope's conversion rate, promoting high-rated products, addressing negative feedback, and investigating the reasons behind the decline in engagement metrics.
