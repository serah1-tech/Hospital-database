-- Part 1: Database Modelling
-- This SQL script is part of the assignment for Week 1: Introduction & Foundational Skills



-- Select the hospital_db database to work with
USE hospital_db;

-- Step 2: Create the patients table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each patient
    first_name VARCHAR(50) NOT NULL,           -- First name of the patient
    last_name VARCHAR(50) NOT NULL,            -- Last name of the patient
    date_of_birth DATE NOT NULL,               -- Patient's date of birth
    gender VARCHAR(10) NOT NULL,               -- Gender of the patient
    language VARCHAR(20) NOT NULL              -- Language spoken by the patient
);

-- Step 3: Create the providers table
CREATE TABLE providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each provider
    first_name VARCHAR(50) NOT NULL,           -- First name of the provider
    last_name VARCHAR(50) NOT NULL,            -- Last name of the provider
    provider_speciality VARCHAR(50) NOT NULL,  -- Speciality of the provider
    email_address VARCHAR(100),                -- Email address of the provider
    phone_number VARCHAR(15),                  -- Phone number of the provider
    date_joined DATE NOT NULL                  -- Date the provider joined the hospital
);

-- Step 4: Create the visits table
CREATE TABLE visits (
    visit_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each visit
    patient_id INT,                            -- ID of the patient (foreign key)
    provider_id INT,                           -- ID of the provider (foreign key)
    date_of_visit DATE NOT NULL,               -- Date of the visit
    date_scheduled DATE NOT NULL,              -- Date the visit was scheduled
    visit_department_id INT NOT NULL,          -- ID of the department the visit is related to
    visit_type VARCHAR(50) NOT NULL,           -- Type of visit (e.g., check-up, emergency)
    blood_pressure_systolic INT,               -- Systolic blood pressure reading
    blood_pressure_diastolic DECIMAL(5,2),     -- Diastolic blood pressure reading
    pulse DECIMAL(5,2),                        -- Pulse rate
    visit_status VARCHAR(20) NOT NULL,         -- Status of the visit (e.g., completed, scheduled)
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

-- Step 5: Create the ed_visits table
CREATE TABLE ed_visits (
    ed_visit_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each emergency department visit
    visit_id INT,                              -- ID of the visit (foreign key)
    patient_id INT,                            -- ID of the patient (foreign key)
    acuity INT NOT NULL,                       -- Acuity level of the visit
    reason_for_visit VARCHAR(100) NOT NULL,    -- Reason for the visit
    disposition VARCHAR(50) NOT NULL,          -- Disposition after the visit (e.g., admitted, discharged)
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Step 6: Create the admissions table
CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each admission
    patient_id INT,                             -- ID of the patient (foreign key)
    admission_date DATE NOT NULL,               -- Date of admission
    discharge_date DATE NOT NULL,               -- Date of discharge
    discharge_disposition VARCHAR(50) NOT NULL, -- Disposition at discharge (e.g., home, transfer)
    service VARCHAR(50) NOT NULL,               -- Service or department responsible for the admission
    primary_diagnosis VARCHAR(100) NOT NULL,    -- Primary diagnosis at admission
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Step 7: Create the discharges table
CREATE TABLE discharges (
    discharge_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each discharge
    admission_id INT,                           -- ID of the admission (foreign key)
    patient_id INT,                             -- ID of the patient (foreign key)
    discharge_date DATE NOT NULL,               -- Date of discharge
    discharge_disposition VARCHAR(50) NOT NULL, -- Disposition at discharge
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
