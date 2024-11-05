-- Create the Employee database
use Employee;

-- Create the emp1 collection
db.createCollection("emp1");

-- Insert documents into emp1 collection
db.emp1.insertMany([
    { eno: 1, ename: "John", address: "123 Elm St", sal: 12000 },
    { eno: 2, ename: "Jane", address: "456 Oak St", sal: 11000 },
    { eno: 3, ename: "Alice", address: "789 Pine St", sal: 9000 },
    { eno: 4, ename: "Bob", address: "321 Maple St", sal: 8000 }
]);

-- Display all documents
db.emp1.find();

-- Insert document with custom object id
db.emp1.insertOne({ _id: ObjectId("507f1f77bcf86cd799439011"), eno: 5, ename: "Charlie", address: "654 Birch St", sal: 7000 });

-- Display employees with salary greater than 5000
db.emp1.find({ sal: { $gt: 5000 } });

-- Display employees with salary less than 15000
db.emp1.find({ sal: { $lt: 15000 } });

-- Display employees with salary between 10000 and 20000
db.emp1.find({ sal: { $gt: 10000, $lt: 20000 } });

-- Update salary of all employees by 10%
db.emp1.updateMany({}, { $mul: { sal: 1.10 } });

-- Delete employees with salary less than 5000
db.emp1.deleteMany({ sal: { $lt: 5000 } });

-- Rename collection emp1 to employee1
db.emp1.renameCollection("employee1");

-- Display employees whose name starts with 'n'
db.employee1.find({ ename: { $regex: /^n/i } });

-- Sort names in ascending order
db.employee1.find().sort({ ename: 1 });
