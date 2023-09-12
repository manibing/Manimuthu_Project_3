create database ECommerceWebsite;
use ECommerceWebsite;

create table supplier( sup_id int primary key, sup_name varchar(50) not null,
sup_city varchar(50) not null, sup_phone varchar(50) not null);

create table customer( cus_id int primary key,
cus_name varchar(20) not null, cus_phone varchar(10) not null, 
cus_city varchar(30) not null, cus_gender char);

create table category( cat_id int primary key, 
cat_name varchar(20) not null);

create table product ( pro_id int primary key,
pro_name varchar(20) not null default "dummy", 
pro_des varchar(60), 
cat_id int, foreign key (cat_id) references category(cat_id));


create table supplier_pricing ( pricing_id int primary key,
pro_id int,sup_id int,
foreign key (pro_id) references product(pro_id),
foreign key(sup_id) references supplier(sup_id),
sup_price int default 0);

create table orders(ord_id int primary key,ord_amount int not null,
ord_date date not null, cus_id int,pricing_id int,
foreign key (cus_id) references customer(cus_id),
foreign key (pricing_id) references supplier_pricing(pricing_id));

create table rating( rat_id int primary key,ord_id int,rat_ratstars int not null,
 foreign key (ord_id) references orders(ord_id));


INSERT INTO supplier VALUES
    (1, 'Rajesh Retails', 'Delhi', '1234567890'),
    (2, 'Appario Ltd.', 'Mumbai', '2589631470'),
    (3, 'Knome products', 'Bangalore', '9785462315'),
    (4, 'Bansal Retails', 'Kochi', '8975463285'),
    (5, 'Mittal Ltd.', 'Lucknow', '7898456532');
    
    INSERT INTO customer VALUES
    (1, 'AAKASH', '9999999999', 'DELHI', 'M'),
    (2, 'AMAN', '9785463215', 'NOIDA', 'M'),
    (3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
    (4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
    (5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');
    
    INSERT INTO category VALUES
    (1, 'BOOKS'),
    (2, 'GAMES'),
    (3, 'GROCERIES'),
    (4, 'ELECTRONICS'),
    (5, 'CLOTHES');
    
    INSERT INTO product VALUES
    (1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
    (2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
    (3, 'ROG LAPTOP', 'Windows 10 with 15-inch screen, i7 processor, 1TB SSD', 4),
    (4, 'OATS', 'Highly Nutritious from Nestle', 3),
    (5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
    (6, 'MILK', '1L Toned Milk', 3),
    (7, 'Boat Earphones', '1.5-Meter long Dolby Atmos', 4),
    (8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
    (9, 'Project IGI', 'Compatible with Windows 7 and above', 2),
    (10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
    (11, 'Rich Dad Poor Dad', 'Written by Robert Kiyosaki', 1),
    (12, 'Train Your Brain', 'By Shireen Stephen', 1);

INSERT INTO supplier_pricing VALUES
    (1, 1, 2, 1500),
    (2, 3, 5, 30000),
    (3, 5, 1, 3000),
    (4, 2, 3, 2500),
    (5, 4, 1, 1000),
    (6, 12, 2, 780),
    (7, 12, 4, 789),
    (8, 3, 1, 31000),
    (9, 1, 5, 1450),
    (10, 4, 2, 999),
    (11, 7, 3, 549),
    (12, 7, 4, 529),
    (13, 6, 2, 105),
    (14, 6, 1, 99),
    (15, 2, 5, 2999),
    (16, 5, 2, 2999);
    
    INSERT INTO orders VALUES
    (101, 1500, '2021-10-06', 2, 1),
    (102, 1000, '2021-10-12', 3, 5),
    (103, 30000, '2021-09-16', 5, 2),
    (104, 1500, '2021-10-05', 1, 1),
    (105, 3000, '2021-08-16', 4, 3),
    (106, 1450, '2021-08-18', 1, 9),
    (107, 789, '2021-09-01', 3, 7),
    (108, 780, '2021-09-07', 5, 6),
    (109, 3000, '2021-09-10', 5, 3),
    (110, 2500, '2021-09-10', 2, 4),
    (111, 1000, '2021-09-15', 4, 5),
    (112, 789, '2021-09-16', 4, 7),
    (113, 31000, '2021-09-16', 1, 8),
    (114, 1000, '2021-09-16', 3, 5),
    (115, 3000, '2021-09-16', 5, 3),
    (116, 99, '2021-09-17', 2, 14);
    
    
    INSERT INTO rating VALUES
    (1, 101, 4),
    (2, 102, 3),
    (3, 103, 1),
    (4, 104, 2),
    (5, 105, 4),
    (6, 106, 3),
    (7, 107, 4),
    (8, 108, 4),
    (9, 109, 3),
    (10, 110, 5),
    (11, 111, 3),
    (12, 112, 4),
    (13, 113, 2),
    (14, 114, 1),
    (15, 115, 1),
    (16, 116, 0);
    
    select cus_gender , count(cus_id) as TotalCustomers from
    customer where cus_id in(
    select distinct cus_id from orders where ord_amount >=3000)
    group by cus_gender;
    
    
SELECT o.ord_id, p.pro_name
FROM orders o
JOIN supplier_pricing sp ON o.PRICING_ID = sp.PRICING_ID
JOIN product p ON sp.pro_ID = p.pro_id
WHERE o.cus_id = 2;

SELECT s.SUP_ID, s.SUP_NAME
FROM supplier s
JOIN supplier_pricing sp ON s.SUP_ID = sp.SUP_ID
GROUP BY s.SUP_ID, s.SUP_NAME
HAVING COUNT(DISTINCT sp.PRO_ID) > 1;

CREATE VIEW lowest_expensive_product AS
SELECT c.CAT_ID, c.CAT_NAME, p.PRO_NAME, MIN(sp.SUP_PRICE) 
AS Price
FROM category c
JOIN product p ON c.CAT_ID = p.CAT_ID
LEFT JOIN supplier_pricing sp ON p.PRO_ID = sp.PRO_ID
GROUP BY c.CAT_ID, c.CAT_NAME, p.PRO_NAME;

SELECT p.PRO_ID, p.PRO_NAME
FROM product p
JOIN supplier_pricing sp ON p.PRO_ID = sp.PRO_ID
JOIN `orders` o ON sp.PRICING_ID = o.PRICING_ID
WHERE o.ORD_DATE > '2021-10-05';

SELECT CUS_NAME, CUS_GENDER
FROM customer
WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

DELIMITER //

CREATE PROCEDURE SupplierRatingAndServices()
BEGIN
    SELECT 
        s.SUP_ID, 
        s.SUP_NAME,
        CASE
            WHEN AVG(r.RAT_RATSTARS) = 5 THEN 'Excellent Service'
            WHEN AVG(r.RAT_RATSTARS) > 4 THEN 'Good Service'
            WHEN AVG(r.RAT_RATSTARS) > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service,
        AVG(r.RAT_RATSTARS) AS Rating
    FROM supplier s
    LEFT JOIN supplier_pricing sp ON s.SUP_ID = sp.SUP_ID
    LEFT JOIN `orders` o ON sp.PRICING_ID = o.PRICING_ID
    LEFT JOIN rating r ON o.ORD_ID = r.ORD_ID
    GROUP BY s.SUP_ID, s.SUP_NAME;
END //

DELIMITER ;

CALL SupplierRatingAndServices();