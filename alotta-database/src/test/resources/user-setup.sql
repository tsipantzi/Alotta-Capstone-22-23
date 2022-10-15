DROP TABLE AppUser;
CREATE TABLE AppUser (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    Username VARCHAR(15) NOT NULL,
    Password VARCHAR(15) NOT NULL,
    Account_Type VARCHAR(25) NOT NULL,
    First_Name VARCHAR(15) NOT NULL,
    Last_Name VARCHAR(15) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Zipcode VARCHAR(5) NOT NULL,
    PRIMARY KEY(id)
);