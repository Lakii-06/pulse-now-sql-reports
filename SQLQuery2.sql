CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Age INT CHECK (Age > 0),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    IDNumber VARCHAR(20) UNIQUE NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL
);

INSERT INTO Patient (PatientID, FullName, Age, Gender, IDNumber, ContactNumber) VALUES
(1, 'Nimal Perera', 34, 'Male', '901234567V', '0771234567'),
(2, 'Fatima Hassan', 28, 'Female', '902345678V', '0772233445'),
(3, 'Amal Jayasinghe', 42, 'Male', '911122233V', '0773344556'),
(4, 'Zahra Nazeem', 19, 'Female', '920011223V', '0711234567'),
(5, 'Dinithi Herath', 31, 'Female', '913456789V', '0723456789'),
(6, 'Isuru Fernando', 25, 'Male', '914567890V', '0751234567'),
(7, 'Shanaya Deen', 38, 'Female', '901234879V', '0761122334'),
(8, 'Tharindu Senanayake', 29, 'Male', '901238899V', '0788877665'),
(9, 'Yasmin Noor', 45, 'Female', '900123444V', '0701234567'),
(10, 'Rashid Khalid', 52, 'Male', '909876543V', '0745544332');


SELECT * FROM Patient;


CREATE TABLE Receipt (
    ReceiptID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    PackageID INT,
    DateIssued DATE
);

INSERT INTO Receipt (ReceiptID, PatientID, PackageID, DateIssued) VALUES
(101, 1, 201, '2025-06-01'),
(102, 2, 202, '2025-06-02'),
(103, 3, 201, '2025-06-02'),
(104, 4, 203, '2025-06-03'),
(105, 5, 204, '2025-06-03'),
(106, 6, 202, '2025-06-04'),
(107, 7, 203, '2025-06-04'),
(108, 8, 204, '2025-06-05'),
(109, 9, 201, '2025-06-05'),
(110, 10, 202, '2025-06-06');

SELECT * FROM Receipt;


CREATE TABLE Package (
    PackageID INT PRIMARY KEY,
    PackageName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price >= 0),
    AgeCategory VARCHAR(20),
    GenderType VARCHAR(10) CHECK (GenderType IN ('Male', 'Female', 'All'))
);

INSERT INTO Package (PackageID, PackageName, Price, AgeCategory, GenderType) VALUES
(201, 'Basic Health Checkup', 1500.00, 'Adult', 'All'),
(202, 'Advanced Heart Screening', 3200.00, 'Senior', 'Male'),
(203, 'Women’s Wellness', 2800.00, 'Adult', 'Female'),
(204, 'Child Immunization Package', 2000.00, 'Child', 'All'),
(205, 'Diabetes Monitoring', 2500.00, 'Adult', 'All'),
(206, 'Senior Citizen Full Checkup', 3500.00, 'Senior', 'All'),
(207, 'Pregnancy Care Package', 3000.00, 'Adult', 'Female'),
(208, 'Men’s Fitness Panel', 2700.00, 'Adult', 'Male'),
(209, 'Cancer Screening', 4000.00, 'Adult', 'All'),
(210, 'Pre-employment Medicals', 2200.00, 'Adult', 'All');

SELECT * FROM Package;


CREATE TABLE Test (
    TestID INT PRIMARY KEY,
    TestName VARCHAR(100) NOT NULL,
    Description TEXT
);

INSERT INTO Test (TestID, TestName, Description) VALUES
(301, 'Blood Pressure', 'Measures systolic and diastolic pressure.'),
(302, 'Blood Sugar', 'Checks glucose level in blood.'),
(303, 'Cholesterol', 'Measures HDL, LDL, and triglycerides.'),
(304, 'ECG', 'Electrocardiogram to check heart rhythm.'),
(305, 'Urine Test', 'General health screening through urine analysis.'),
(306, 'X-Ray Chest', 'Checks lungs and heart size.'),
(307, 'Pregnancy Test', 'Detects HCG hormone levels.'),
(308, 'Eye Vision Test', 'Checks eyesight and vision clarity.'),
(309, 'HIV Test', 'Detects presence of HIV antibodies.'),
(310, 'Liver Function Test', 'Analyzes enzymes and proteins in the liver.');

SELECT * FROM Test;



CREATE TABLE PackageTest (
    PackageID INT,
    TestID INT,
    PRIMARY KEY (PackageID, TestID),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID),
    FOREIGN KEY (TestID) REFERENCES Test(TestID)
);

INSERT INTO PackageTest (PackageID, TestID) VALUES
(201, 301), -- Basic Health Checkup: Blood Pressure
(201, 302), -- Basic: Blood Sugar
(201, 303), -- Basic: Cholesterol
(202, 304), -- Heart Screening: ECG
(202, 303), -- Heart Screening: Cholesterol
(203, 307), -- Women's Wellness: Pregnancy Test
(203, 305), -- Women's: Urine Test
(204, 305), -- Child Package: Urine
(204, 308), -- Child: Eye Vision
(205, 302); -- Diabetes: Blood Sugar

SELECT * FROM PackageTest;


CREATE TABLE Report (
    ReportID INT PRIMARY KEY,
    ReceiptID INT FOREIGN KEY REFERENCES Receipt(ReceiptID),
    CollectionDate DATE NOT NULL,
    Notes TEXT,
    Status VARCHAR(10) CHECK (Status IN ('Fit', 'Unfit'))
);

INSERT INTO Report (ReportID, ReceiptID, CollectionDate, Notes, Status) VALUES
(401, 101, '2025-06-02', 'Normal checkup. All good.', 'Fit'),
(402, 102, '2025-06-03', 'Blood sugar slightly high.', 'Unfit'),
(403, 103, '2025-06-03', 'Heart rhythm irregular.', 'Unfit'),
(404, 104, '2025-06-04', 'All tests normal.', 'Fit'),
(405, 105, '2025-06-04', 'Some vitamin deficiency noted.', 'Fit'),
(406, 106, '2025-06-05', 'BP elevated. Monitoring needed.', 'Unfit'),
(407, 107, '2025-06-05', 'Normal results.', 'Fit'),
(408, 108, '2025-06-06', 'Vision test failed.', 'Unfit'),
(409, 109, '2025-06-06', 'Slight cholesterol elevation.', 'Fit'),
(410, 110, '2025-06-07', 'Pregnancy test positive.', 'Fit');

SELECT * FROM Report;


CREATE TABLE ReportTest (
    ReportID INT,
    TestID INT,
    Results TEXT,
    PRIMARY KEY (ReportID, TestID),
    FOREIGN KEY (ReportID) REFERENCES Report(ReportID),
    FOREIGN KEY (TestID) REFERENCES Test(TestID)
);

INSERT INTO ReportTest (ReportID, TestID, Results) VALUES
(401, 301, '120/80'),
(401, 302, 'Normal'),
(402, 302, 'High'),
(403, 304, 'Irregular rhythm'),
(404, 305, 'Clear'),
(405, 303, 'Slightly low HDL'),
(406, 301, '140/90'),
(407, 305, 'Normal'),
(408, 308, 'Poor vision in left eye'),
(410, 307, 'Positive');

SELECT * FROM ReportTest;


CREATE TABLE RepeatTest (
    RepeatTestID INT PRIMARY KEY,
    ReportID INT FOREIGN KEY REFERENCES Report(ReportID),
    TestID INT FOREIGN KEY REFERENCES Test(TestID)
);

INSERT INTO RepeatTest (RepeatTestID, ReportID, TestID) VALUES
(501, 402, 302), -- Blood sugar repeat for Report 402
(502, 403, 304), -- ECG repeat for Report 403
(503, 406, 301), -- BP repeat for Report 406
(504, 408, 308), -- Eye test repeat for Report 408
(505, 402, 303), -- Cholesterol added for follow-up
(506, 406, 302), -- Blood sugar added to BP follow-up
(507, 408, 305), -- Urine test follow-up
(508, 403, 301), -- BP added for heart screening
(509, 406, 303), -- Cholesterol added to monitor heart
(510, 402, 305); -- Urine test repeat just in case

SELECT * FROM RepeatTest;


