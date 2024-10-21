-- Create the Restaurants database
use Restaurants;

-- Create the REST1 collection
db.createCollection("REST1");

-- Insert documents into REST1 collection
db.REST1.insertMany([
    { restaurant_id: 3001, name: "Restaurant A", address: { building: "123", street: "Main St", city: "Springfield", zipcode: "12345" }, cuisine_type: "Italian", score: 85 },
    { restaurant_id: 3002, name: "Restaurant B", address: { building: "456", street: "Second St", city: "Shelbyville", zipcode: "67890" }, cuisine_type: "Indian", score: 90 },
    { restaurant_id: 3003, name: "Restaurant C", address: { building: "789", street: "Third St", city: "Capital City", zipcode: "11223" }, cuisine_type: "Chinese", score: 75 }
]);

-- Display all documents in the collection REST1
db.REST1.find();

-- Display the fields restaurant_id, name, city, zipcode, but exclude the field _id for all the documents in the collection REST1
db.REST1.find({}, { restaurant_id: 1, name: 1, "address.city": 1, "address.zipcode": 1, _id: 0 });

-- Find the restaurants that achieved a score more than 80 but less than 100
db.REST1.find({ score: { $gt: 80, $lt: 100 } });

-- Update the score of the restaurant with restaurant_id 3001 to 90
db.REST1.updateOne({ restaurant_id: 3001 }, { $set: { score: 90 } });

-- Update the cuisine type of all Indian restaurants to Indian_Zatka
db.REST1.updateMany({ cuisine_type: "Indian" }, { $set: { cuisine_type: "Indian_Zatka" } });

-- Delete the restaurant with restaurant_id 3003
db.REST1.deleteOne({ restaurant_id: 3003 });

-- Delete all restaurants with a score less than 85
db.REST1.deleteMany({ score: { $lt: 85 } });
