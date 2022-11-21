# COSC 304 - Introduction to Database Systems
Lab 8: Images, Security, and Transactions

Modify your existing project web site with new features including a product detail page, a login feature, an administrator page, and support for transactions.

Project Requirements (25 marks)

Sample web site

Start with the setup for lab 7 for either Java, PHP, or Node.js. If you have an existing Docker container for lab 7, you do not need to download and setup lab 7 again.

Download starter code for Java, PHP, or Node.js. These code files should be ADDED to your existing lab 7 project. There is a new main page (index.jsp/php), an administrator page (admin.jsp/php), and images in the img folder. The four new code files to change: validateLogin.jsp/php, product.jsp/php, admin.jsp/php, and ship.jsp/php.

Your output does not have to look exactly like the sample (feel free to make it look better!).

The product page will show details on the product including images. An image can be retrieved from a local folder using a URL or stored as a binary object in the database.

Marking Guide (product page): (10 marks)

+1 mark - for modifying product listing page to go to product detail page when click on product name
+3 marks - for using PreparedStatement to retrieve and display product information by id
+2 marks - for displaying an image using an HTML img tag based on productImageURL field
+3 marks - for displaying an image from the binary field productImage by providing an img tag and modifying the displayImage.jsp/php file.
+1 mark - for adding link to "add to cart" and to "continue shopping"

Screenshot

https://github.com/rlawrenc/cosc_304/blob/main/labs/lab8/assign/img/productPage.png![image](https://user-images.githubusercontent.com/78832175/203176521-d1a34f99-2671-419d-b1b6-558cbcadc645.png)

Marking Guide (admin and login page): (5 marks)

+1 mark - for checking user is logged in before accessing page
+2 marks - for displaying a report that list the total sales for each day. Hint: May need to use date functions like year, month, day.
+1 mark - for displaying current user on main page (index.jsp/php)
+2 marks - for modifying validateLogin to check correct user id and password

Screenshot

https://github.com/rlawrenc/cosc_304/blob/main/labs/lab8/assign/img/adminPage.png![image](https://user-images.githubusercontent.com/78832175/203176548-e0919329-40d2-4223-ac60-f4b666da3fb4.png)

Marking Guide (customer page): (5 marks)

+1 mark - for displaying error message if attempt to access page and not logged in
+4 marks - for retrieving customer information by id and displaying it

Screenshot

https://github.com/rlawrenc/cosc_304/blob/main/labs/lab8/assign/img/customerPage.png![image](https://user-images.githubusercontent.com/78832175/203176563-ab7aedc9-bad8-45a5-ae6d-ea0a222a4847.png)

Marking Guide (shipment page): (5 marks)

+3 mark -for using transactions to either process the shipment and ship all items (up to 3) or generate an error
+2 marks - for checking that there is enough of each item to ship from the warehouse. Rollback transaction if any item does not have enough inventory.
Test by entering URL like: http://localhost:8080/ship.jsp?orderId=1

Screenshot - Successful Shipment with orderId=1

https://github.com/rlawrenc/cosc_304/blob/main/labs/lab8/assign/img/shipmentPage1.png![image](https://user-images.githubusercontent.com/78832175/203176591-ce689e3c-1dc7-481a-a918-58598153642a.png)

Screenshot - Unsuccessful Shipment with orderId=3

https://github.com/rlawrenc/cosc_304/blob/main/labs/lab8/assign/img/shipmentPage2.png![image](https://user-images.githubusercontent.com/78832175/203176627-88ff87e8-f3b9-422d-a5fa-35f5874d79ae.png)

If you do not demonstrate live to the TA in virtual office hours, please upload a video clip demonstrating your working pages with the new features.
