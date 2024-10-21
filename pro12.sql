-- Create the student collection
db.createCollection("student");

-- Insert documents into student collection
db.student.insertMany([
    { student_id: 1, name: "Alice", age: 20, gender: "female", marks: { math: 95, science: 88, english: 82 } },
    { student_id: 2, name: "Bob", age: 22, gender: "male", marks: { math: 78, science: 92, english: 85 } },
    { student_id: 3, name: "Charlie", age: 19, gender: "male", marks: { math: 88, science: 76, english: 90 } },
    { student_id: 4, name: "Diana", age: 21, gender: "female", marks: { math: 85, science: 89, english: 87 } }
]);

-- 1. Find all students who are male
db.student.find({ gender: "male" });

-- 2. Find students who scored more than 90 in math
db.student.find({ "marks.math": { $gt: 90 } });

-- 3. Find students aged 20 and above
db.student.find({ age: { $gte: 20 } });

-- 4. Find students whose English marks are between 80 and 90
db.student.find({ "marks.english": { $gte: 80, $lte: 90 } });

-- 5. Count the number of female students
db.student.countDocuments({ gender: "female" });

-- 6. Find the student with the highest science score
db.student.find().sort({ "marks.science": -1 }).limit(1);

-- 7. Update Bob's math score to 75
db.student.updateOne({ name: "Bob" }, { $set: { "marks.math": 75 } });

-- 8. Delete all students who scored below 70 in math
db.student.deleteMany({ "marks.math": { $lt: 70 } });

-- 9. Use aggregation to find the average marks in science for all students
db.student.aggregate([
    { $group: { _id: null, avgScienceMarks: { $avg: "$marks.science" } } }
]);

-- 10. Find the number of students with marks greater than 80 in any subject
db.student.find({
    $or: [
        { "marks.math": { $gt: 80 } },
        { "marks.science": { $gt: 80 } },
        { "marks.english": { $gt: 80 } }
    ]
}).count();
