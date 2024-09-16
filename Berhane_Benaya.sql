DROP TABLE blood_banks;

-- Drop the 'BloodBankDonors' table
DROP TABLE BloodBankDonors;

-- Drop the 'patients' table
DROP TABLE patients;

CREATE TABLE patients (
  Patient_Name VARCHAR2(30),
  Patient_Unique_ID VARCHAR2(30) PRIMARY KEY,
  Blood_group VARCHAR2(20),
  Disease VARCHAR2(30)
);

-- Create the 'BloodBankDonors' table
CREATE TABLE BloodBankDonors (
  Donor_Name VARCHAR2(30),
  Donor_Unique_ID VARCHAR2(30) PRIMARY KEY,
  Blood_group VARCHAR2(20),
  Medical_Report VARCHAR2(30),
  Donor_Address VARCHAR2(30),
  Donor_Contact_Number INT
);

-- Create the 'blood_banks' table
CREATE TABLE blood_banks (
  Blood_Bank_Name VARCHAR2(30),
  Blood_Bank_Address VARCHAR2(40),
  Donor_Unique_ID VARCHAR2(30),
  CONSTRAINT fk_donor_id FOREIGN KEY (Donor_Unique_ID) REFERENCES BloodBankDonors(Donor_Unique_ID)
);

INSERT INTO patients VALUES ('John Doe', 'P001', 'O+', 'Hypertension');
INSERT INTO patients VALUES ('Jane Smith', 'P002', 'A-', 'Diabetes');
INSERT INTO patients VALUES ('Bob Johnson', 'P003', 'B+', 'Anemia');

-- Insert data into the 'BloodBankDonors' table
INSERT INTO BloodBankDonors VALUES ('Donor1', 'D001', 'A+', 'Healthy', '123 Main St', 555123456);
INSERT INTO BloodBankDonors VALUES ('Donor2', 'D002', 'O-', 'No issues', '456 Oak St', 555789012);
INSERT INTO BloodBankDonors VALUES ('Donor3', 'D003', 'AB+', 'Good health', '789 Pine St', 555345678);

-- Insert data into the 'blood_banks' table
INSERT INTO blood_banks VALUES ('City Blood Bank', '123 Broadway St', 'D001');
INSERT INTO blood_banks VALUES ('County Blood Bank', '456 Maple St', 'D002');
INSERT INTO blood_banks VALUES ('Regional Blood Bank', '789 Elm St', 'D003');

-- Select Statements

-- 1. Select all patients
select * from patients;

-- 2. Select all donors
select * from BloodBankDonors;

-- Join Queries with Group By

-- 3. Join patients and blood_banks based on blood group with group by
select patients.Patient_Name, patients.Blood_group, count(*) as Donor_Count
from patients
inner join BloodBankDonors on patients.Blood_group = BloodBankDonors.Blood_group
group by patients.Patient_Name, patients.Blood_group;

-- 4. Join BloodBankDonors and blood_banks based on Blood_Bank_Name with group by
select blood_banks.Blood_Bank_Name, count(*) as Donor_Count
from BloodBankDonors
inner join blood_banks on BloodBankDonors.Donor_Unique_ID = blood_banks.Donor_Unique_ID
group by blood_banks.Blood_Bank_Name;

-- Additional Join Queries

-- 5. Join patients and BloodBankDonors based on Blood_group
select patients.Patient_Name, patients.Blood_group, BloodBankDonors.Donor_Name
from patients
inner join BloodBankDonors on patients.Blood_group = BloodBankDonors.Blood_group;

-- 6. Join patients and blood_banks based on Patient_Unique_ID and Donor_Unique_ID
select patients.Patient_Name, patients.Blood_group, blood_banks.Blood_Bank_Name
from patients
inner join blood_banks on patients.Patient_Unique_ID = blood_banks.Donor_Unique_ID;

-- 7. Join BloodBankDonors and blood_banks based on Blood_group and Donor_Unique_ID
select BloodBankDonors.Donor_Name, BloodBankDonors.Blood_group, blood_banks.Blood_Bank_Name
from BloodBankDonors
inner join blood_banks on BloodBankDonors.Blood_group = blood_banks.Donor_Unique_ID;

-- 8. Join patients, BloodBankDonors, and blood_banks based on Blood_group, Patient_Unique_ID, and Donor_Unique_ID
select patients.Patient_Name, BloodBankDonors.Donor_Name, blood_banks.Blood_Bank_Name
from patients
inner join BloodBankDonors on patients.Blood_group = BloodBankDonors.Blood_group
inner join blood_banks on patients.Patient_Unique_ID = blood_banks.Donor_Unique_ID;

-- Update Statements

-- 9. Update a patient's disease
update patients set Disease = 'Heart Disease' where Patient_Unique_ID = 'P001';

-- 10. Update a donor's medical report
update BloodBankDonors set Medical_Report = 'Excellent health' where Donor_Unique_ID = 'D002';
