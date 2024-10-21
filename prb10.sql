-- Create the Books collection
db.createCollection("Books");

-- Insert documents into Books collection
db.Books.insertMany([
    { book_title: "Book One", author_name: "Author A", status: "active", publish_year: 2010 },
    { book_title: "Book Two", author_name: "Author B", status: "active", publish_year: 2015 },
    { book_title: "Book Three", author_name: "Author A", status: "passive", publish_year: 2020 },
    { book_title: "Book Four", author_name: "Author C", status: "active", publish_year: 2018 }
]);

-- Map function to select active books and group by author_name
var mapFunction = function() {
    if (this.status === "active") {
        emit(this.author_name, 1);
    }
};

-- Reduce function to count the number of books by each author
var reduceFunction = function(key, values) {
    return Array.sum(values);
};

-- Perform the mapReduce operation
db.Books.mapReduce(
    mapFunction,
    reduceFunction,
    { out: "active_books_count" }
);

-- Display the results
db.active_books_count.find();
