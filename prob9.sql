-- Create the Books collection
db.createCollection("Books");

-- Create the Products collection
db.createCollection("Products");

-- Insert documents into Books collection
db.Books.insertMany([
    { book_id: 1, book_title: "Book One", author_name: "Author A", publish_year: 2010 },
    { book_id: 2, book_title: "Book Two", author_name: "Author B", publish_year: 2015 },
    { book_id: 3, book_title: "Book Three", author_name: "Author A", publish_year: 2020 }
]);

-- Insert documents into Products collection
db.Products.insertMany([
    { product_id: 1, name: "Product One", price: 100 },
    { product_id: 2, name: "Product Two", price: 200 },
    { product_id: 3, name: "Product Three", price: 300 }
]);

-- 1. Create an index on the price field in the Products collection
db.Products.createIndex({ price: 1 });

-- 2. Create a compound index on author_name and publish_year in the Books collection
db.Books.createIndex({ author_name: 1, publish_year: 1 });

-- 3. View all indexes created in the Books and Products collections
db.Books.getIndexes();
db.Products.getIndexes();

-- 4. Drop the index created on the price field from the Products collection
db.Products.dropIndex({ price: 1 });

-- 5. Find the total number of books published by each author in the Books collection
db.Books.aggregate([
    { $group: { _id: "$author_name", total_books: { $sum: 1 } } }
]);

-- 6. Write an aggregation query that calculates the average price of all products from the Products collection
db.Products.aggregate([
    { $group: { _id: null, avg_price: { $avg: "$price" } } }
]);

-- 7. Find the maximum and minimum price in the Products collection
db.Products.aggregate([
    { $group: { _id: null, max_price: { $max: "$price" }, min_price: { $min: "$price" } } }
]);

-- 8. Write an aggregation query to count the number of documents in the Books collection where the publish_year is greater than 2015
db.Books.aggregate([
    { $match: { publish_year: { $gt: 2015 } } },
    { $count: "total_books" }
]);

-- 9. Use the $project stage to display only the book_title and author_name fields from the Books collection
db.Books.aggregate([
    { $project: { book_title: 1, author_name: 1, _id: 0 } }
]);

-- 10. Sort documents based on one or more fields of the Books collection
db.Books.find().sort({ publish_year: 1 });
