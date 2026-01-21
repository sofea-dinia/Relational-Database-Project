CREATE TABLE Supplier(
Supplier_ID VARCHAR(20),
Supplier_Ref_Code VARCHAR(20),
Supplier_Name VARCHAR(100),
Supplier_Contact VARCHAR(50),
Supplier_Email VARCHAR(100),
Supplier_Address VARCHAR(100),
Supplier_Type VARCHAR(50),
Supplier_Status VARCHAR(20),
Supplier_Added_Date DATE,
Supplier_Rating DECIMAL(2,1),
PRIMARY KEY (Supplier_ID, Supplier_Ref_Code),
UNIQUE(Supplier_ID)
);



CREATE TABLE Department (
    Department_ID VARCHAR(10) NOT NULL,
    Department_Ref VARCHAR(10) NOT NULL,
    Department_Name VARCHAR(100) NOT NULL,
    Department_Vision VARCHAR(100),
    Department_Manager VARCHAR(100) NOT NULL,
    Department_Email VARCHAR(100) NOT NULL,
    Department_Office_Number VARCHAR(20) NOT NULL,
    Department_No_Of_Employees INT NOT NULL,
    Department_Floor VARCHAR(10) NOT NULL,
    Department_Creation_Date DATE NOT NULL,
    Department_Mission VARCHAR(100),
    PRIMARY KEY (Department_ID, Department_Ref),
UNIQUE(Department_ID)
);

CREATE TABLE Training (
    Training_ID VARCHAR(20),
    Training_Title VARCHAR(100),
    Training_Participation_No INT,
    Training_Provider VARCHAR(100),
    Training_Certified VARCHAR(50),
    Training_Duration VARCHAR(50),
    Training_Start_Date DATE,
    Training_End_Date DATE,
    Training_Remarks VARCHAR(255),
    Training_Cost DECIMAL(10,2),
    Training_Location VARCHAR(100),
    PRIMARY KEY(Training_ID, Training_Title),
    UNIQUE(Training_ID)
);


CREATE TABLE Company (
    Company_Reference_No VARCHAR(20) NOT NULL,
    Company_SSM VARCHAR(20) NOT NULL,
    Company_Tax_No VARCHAR(20) NOT NULL,
    Company_Name VARCHAR(100) NOT NULL,
    Company_Email VARCHAR(100) NOT NULL,
    Company_Office_Address VARCHAR(100) NOT NULL,
    Company_Industry VARCHAR(50) NOT NULL,
    Company_Established_Year INT NOT NULL,
    Company_Motto VARCHAR(100) NOT NULL,
    Company_Owner VARCHAR(100) NOT NULL,
    Company_Employee_No INT NOT NULL,
    PRIMARY KEY (Company_Reference_No, Company_SSM, Company_Tax_No),
UNIQUE(Company_Reference_No)
);

CREATE TABLE Person (
    Person_IC VARCHAR2(14) NOT NULL,
    Person_Name VARCHAR2(100) NOT NULL,
    Person_Work_Email VARCHAR2(100) NOT NULL,
    Person_Work_Status VARCHAR2(10) DEFAULT 'Active',
    Company_Reference_No VARCHAR2(10),
    PRIMARY KEY (Person_IC, Person_Work_Email),
    FOREIGN KEY (Company_Reference_No) REFERENCES Company(Company_Reference_No),
UNIQUE(Person_IC)
);


CREATE TABLE Employee (
    Employee_ID VARCHAR(15) NOT NULL,
    Employee_TIN VARCHAR(20) NOT NULL,
    Employee_Gender VARCHAR(1) NOT NULL CHECK (Employee_Gender IN ('F', 'M')),
    Employee_Address VARCHAR(100) NOT NULL,
    Employee_Marital_Status VARCHAR(50) NOT NULL,
    Employee_Hire_Date DATE NOT NULL,
    Employee_Monthly_Salary DECIMAL(12,2) NOT NULL CHECK (Employee_Monthly_Salary >= 1200.00),
    Employee_Age INT NOT NULL,
    Employee_DOB DATE NOT NULL,
    Employee_Employment_Type VARCHAR(10) NOT NULL CHECK (Employee_Employment_Type IN ('Full-time', 'Part-time')),
    Department_ID VARCHAR(15) NOT NULL,
       Person_IC VARCHAR(14) NOT NULL,
    PRIMARY KEY (Employee_ID, Employee_TIN),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
UNIQUE(Employee_ID)
);


CREATE TABLE Leave_Form (
    Leave_Form_ID VARCHAR(15) NOT NULL,
    Leave_Form_Ref_Code VARCHAR(20) NOT NULL,
    LF_Leave_Type VARCHAR(20) NOT NULL,
    LF_Start_Date DATE NOT NULL,
    LF_End_Date DATE NOT NULL,
    LF_Duration INT NOT NULL,
    LF_Reason VARCHAR(100) NOT NULL,
    LF_Submission_Date TIMESTAMP NOT NULL,
    LF_Approval_Date TIMESTAMP NOT NULL,
    LF_Approver_Name VARCHAR(100) NOT NULL,
    LF_Remarks VARCHAR(100) NOT NULL,
    Department_ID VARCHAR(15) NOT NULL,
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Leave_Form_ID, Leave_Form_Ref_Code),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Sales_Person (
    Sales_Person_ID VARCHAR(4) NOT NULL,
    Sales_Person_Ref_Code VARCHAR(20) NOT NULL,
    SP_Year_In_Company INT NOT NULL,
    SP_Language_Proficiency VARCHAR(500),
    SP_NDA_Signed VARCHAR(1) DEFAULT 'N' NOT NULL,
    SP_Quarterly_Target DECIMAL(12,2) NOT NULL,
    SP_Total_Sales_YTD DECIMAL(12,2) NOT NULL,
    SP_Commission_Rate DECIMAL(5,2) NOT NULL,
    SP_Last_Training_Date DATE,
    SP_MicrosoftO_Skill VARCHAR(15) NOT NULL,
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Sales_Person_ID, Sales_Person_Ref_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
UNIQUE(Sales_Person_ID)
);



CREATE TABLE PIC (
    PIC_ID VARCHAR(15) NOT NULL,
    PIC_Reference_No VARCHAR(20) NOT NULL,
    PIC_Position VARCHAR(50) NOT NULL,
    PIC_Joined_Date DATE,
    PIC_Role VARCHAR(100) NOT NULL,
    PIC_Personal_Email VARCHAR(100) NOT NULL,
    PIC_Department VARCHAR(100) NOT NULL,
    PIC_Office_Number VARCHAR(15) NOT NULL,
    PIC_Race VARCHAR(50) NOT NULL,
    PIC_Nationality VARCHAR(50) NOT NULL,
    Sales_Person_ID VARCHAR(4) NOT NULL,
    Company_Reference_No VARCHAR(20) NOT NULL,
           Person_IC VARCHAR(14) NOT NULL,
    PRIMARY KEY (PIC_ID, PIC_Reference_No),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person(Sales_Person_ID),
    FOREIGN KEY (Company_Reference_No) REFERENCES Company(Company_Reference_No),
   FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
UNIQUE(PIC_ID)
);

CREATE TABLE PIC_Visit (
    PICV_ID VARCHAR(10),
    PICV_Timestamp TIMESTAMP,
    PICV_Visit_Date DATE,
    PICV_Duration_Minutes INT,
    PICV_Location VARCHAR(100),
    PICV_Attendees VARCHAR(50),
    PICV_Outcome_Summary VARCHAR(100),
    PICV_Follow_Up_Required VARCHAR(10),
    PICV_Photos_Taken VARCHAR(10),
    PICV_Travel_Cost DECIMAL(10,2),
    PIC_ID VARCHAR(15),
    Sales_Person_ID VARCHAR(4),
    PRIMARY KEY (PICV_ID, PICV_Timestamp),
    FOREIGN KEY (PIC_ID) REFERENCES PIC (PIC_ID),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person (Sales_Person_ID)
);


CREATE TABLE Contract (
    Contract_ID VARCHAR(15) NOT NULL,
    Contract_Ref_Code VARCHAR(20) NOT NULL,
    Contract_Start_Date DATE NOT NULL,
    Contract_End_Date DATE NOT NULL,
    Contract_Agreement_Type VARCHAR(50) NOT NULL,
    Contract_Service_Level VARCHAR(20) NOT NULL,
    Contract_Work_Scope VARCHAR(200) NOT NULL,
    Contract_Total_Value DECIMAL(12,2) NOT NULL,
    Contract_Status VARCHAR(20) NOT NULL,
    Contract_Payment_Term VARCHAR(20) NOT NULL,
    Sales_Person_ID VARCHAR(4) NOT NULL,
    Company_Reference_No VARCHAR(20) NOT NULL,
PIC_ID VARCHAR(15),
    PRIMARY KEY (Contract_ID, Contract_Ref_Code),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person(Sales_Person_ID),
    FOREIGN KEY (Company_Reference_No) REFERENCES Company(Company_Reference_No),
FOREIGN KEY(PIC_ID)REFERENCES PIC(PIC_ID),
UNIQUE(Contract_ID)
);

CREATE TABLE Direct_Purchase (
    DP_ID INT,
    DP_Ref_Code VARCHAR(20),
    DP_Quotation_Ref VARCHAR(50),
    DP_Created_Date DATE,
    DP_Approved_Date DATE,
    DP_Time TIMESTAMP,
    DP_Approved_Status VARCHAR(20),
    DP_Urgency_Level VARCHAR(50),
    DP_Remarks VARCHAR(100),
    DP_Justification VARCHAR(500),
     Contract_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (DP_ID, DP_Ref_Code),
   FOREIGN KEY (Contract_ID) REFERENCES Contract(Contract_ID)
);

CREATE TABLE Tender (
    Tender_ID INT,
    Tender_Ref_Code VARCHAR(20),
    Tender_Open_Date DATE,
    Tender_Created_By VARCHAR(50),
    Tender_Deadline DATE,
    Tender_Award_Date DATE,
    Tender_Name VARCHAR(100),
    Tender_Status VARCHAR(20),
    Tender_No_Competition INT,
    Tender_Type VARCHAR(30),
    Tender_Fee DECIMAL(10,2),
     Contract_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY(Tender_ID, Tender_Ref_Code),
       FOREIGN KEY (Contract_ID) REFERENCES Contract(Contract_ID)
);



CREATE TABLE Stock (
    Stock_ID VARCHAR(10),
    Stock_Shelf VARCHAR(50),
    Stock_Condition VARCHAR(50),
    Stock_Warehouse VARCHAR(100),
    Stock_Received_Date DATE,
    Supplier_ID VARCHAR(10),
    PRIMARY KEY (Stock_ID, Stock_Shelf),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID),
UNIQUE(Stock_ID)
);

CREATE TABLE Photocopier (
    Photocopier_ID INT,
    Photocopier_Model_Number VARCHAR(50),
    Photocopier_Model_Name VARCHAR(100),
    Photocopier_Manufacturer VARCHAR(100),
    Photocopier_Warranty_Period VARCHAR(50),
    Photocopier_Received_Status VARCHAR(50),
    Photocopier_Print_Speed VARCHAR(50),
    Photocopier_Paper_Size_Handling VARCHAR(100),
    Photocopier_Functionality VARCHAR(100),
    Photocopier_Ink_Type VARCHAR(50),
    Stock_ID VARCHAR(10),
    PRIMARY KEY(Photocopier_ID,Photocopier_Model_Number),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID),
UNIQUE(Photocopier_ID)
);

CREATE TABLE Ink (
    Ink_ID INT,
    Ink_Model_Number VARCHAR(50),
    Ink_Type VARCHAR(50),
    Ink_Colour VARCHAR(50),
    Ink_Compatibility VARCHAR(50),
    Ink_Supplier VARCHAR(100),
    Ink_Manufacturer_Date DATE,
    Ink_Price DECIMAL(10,2),
    Ink_Expiry_Date DATE,
    Ink_Order_Status VARCHAR(50),
    Stock_ID VARCHAR(10),
    PRIMARY KEY(Ink_ID,Ink_Model_Number),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID)
);


 CREATE TABLE Feedback(
    Feedback_ID VARCHAR(50),
    Feedback_Title VARCHAR(150),
    Feedback_Submitted_By VARCHAR(100),
    Feedback_Submission_Date DATE,
    Feedback_Rating DECIMAL(2,1),
    Feedback_Comments VARCHAR(300),
    Feedback_Type VARCHAR(50),
    Feedback_Status VARCHAR(20),
   Feedback_Satisfaction_Level VARCHAR(20),
   Feedback_Follow_Up_Respond VARCHAR(300),
   Feedback_Reviewed VARCHAR(10),
   Training_ID VARCHAR(15),
   Stock_ID VARCHAR(10),
   PRIMARY KEY (Feedback_ID, Feedback_Title),
FOREIGN KEY (Training_ID)REFERENCES Training(Training_ID),
FOREIGN KEY (Stock_ID)REFERENCES Stock(Stock_ID),
UNIQUE(Feedback_ID)
   );


CREATE TABLE Service (
    Service_ID INT,
    Service_Sequence_No INT,
    Service_Start_Date DATE,
    Contract_ID VARCHAR2(15),
    Service_Completed_Date DATE,
    Service_Issue_Description VARCHAR(100),
    Service_Type VARCHAR(100),
    Service_Status VARCHAR(50),
    Service_Cost DECIMAL(10,2),
    Service_Resolution VARCHAR(100),
    Service_Rating INT,
    FOREIGN KEY(Contract_ID) REFERENCES Contract(Contract_ID),
    PRIMARY KEY(Service_ID, Service_Sequence_No),
UNIQUE(Service_ID)
);

CREATE TABLE Training_Certificate (
    TC_ID VARCHAR(20),
    TC_Serial_No VARCHAR(50),
    Training_ID VARCHAR(20),
    TC_Name VARCHAR(100),
    TC_Issuer VARCHAR(100),
    TC_Issue_Date DATE,
    TC_Expiry_Date DATE,
    TC_Level VARCHAR(50),
    TC_URL VARCHAR(255),
    TC_Renewal_Period VARCHAR(50),
    TC_Physical VARCHAR(50),
    TC_Digital VARCHAR(50),
    TC_Accreditation VARCHAR(100),
    FOREIGN KEY(Training_ID) REFERENCES Training(Training_ID),
    PRIMARY KEY(TC_ID, TC_Serial_No),
UNIQUE(TC_ID)
);


CREATE TABLE Technician (
    Technician_ID VARCHAR(15) NOT NULL,
    Technician_Ref_Code VARCHAR(20) NOT NULL,
    Technician_Territory VARCHAR(20) NOT NULL,
    Technician_Training_History INT NOT NULL,
    Technician_Skill_Level VARCHAR(1) NOT NULL,
    Technician_Experience_Years INT NOT NULL,
    Technician_BMI DECIMAL(4,1) NOT NULL,
    Technician_Education VARCHAR(100) NOT NULL,
    Technician_Vehicle_Plate VARCHAR(10) NOT NULL,
    Technician_Shift VARCHAR(10) NOT NULL,
    Technician_Uniform_Size VARCHAR(3) NOT NULL,
    EC_ID VARCHAR(30), -- initially nullable
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Technician_ID, Technician_Ref_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
UNIQUE(Technician_ID)
);

CREATE TABLE Emergency_Contact (
    EC_ID INT,
    EC_Ref VARCHAR(50),
    Technician_ID VARCHAR(10), -- initially nullable
    EC_Contact_Priority INT,
    EC_Phone_Number VARCHAR(20),
    EC_Email VARCHAR(100),
    EC_Address VARCHAR(255),
    EC_Medical_Notes VARCHAR(255),
    EC_Notification_Preferences VARCHAR(100),
    EC_Last_Verified_Date DATE,
    EC_Status VARCHAR(50),
    PRIMARY KEY(EC_ID, EC_Ref),
UNIQUE(EC_ID)
);


CREATE TABLE Invoice (
    Invoice_ID INT,
    Invoice_Ref_Code VARCHAR(20),
    Invoice_Date DATE,
    Invoice_Created_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    Invoice_Tax_Rate DECIMAL(5,2),
    Invoice_Discount DECIMAL(10,2),
    Invoice_Total_Amount DECIMAL(10,2),
    Invoice_Payment_Status VARCHAR(20),
    Invoice_Notes VARCHAR(500),
    Contract_ID VARCHAR(15),
    Sales_Person_ID VARCHAR(4),
    PRIMARY KEY (Invoice_ID, Invoice_Ref_Code),
    FOREIGN KEY (Contract_ID) REFERENCES Contract(Contract_ID),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person(Sales_Person_ID),
UNIQUE(Invoice_ID)
);

CREATE TABLE Delivery (
    Delivery_ID VARCHAR(10),
    Delivery_Tracking_No VARCHAR(50),
    Delivery_Scheduled_Date DATE,
    Delivery_Actual_Date DATE,
    Delivery_Courier VARCHAR(100),
    Delivery_Vehicle_Used VARCHAR(100),
    Delivery_Unloading_Time TIMESTAMP,
    Delivery_Client_Acceptance_Status VARCHAR(50),
    Delivery_Damage_Report VARCHAR(100),
    Delivery_Packaging_Condition VARCHAR(50),
    Contract_ID VARCHAR(15),
    Supplier_ID VARCHAR(20),
    Company_Reference_No VARCHAR(20),
    PIC_ID VARCHAR(15),
    Sales_Person_ID VARCHAR(4),
    PR_ID INT,
    PRIMARY KEY (Delivery_ID, Delivery_Tracking_No),
    FOREIGN KEY (Contract_ID) REFERENCES Contract (Contract_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID),
    FOREIGN KEY (Company_Reference_No) REFERENCES Company (Company_Reference_No),
    FOREIGN KEY (PIC_ID) REFERENCES PIC (PIC_ID),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person (Sales_Person_ID),
UNIQUE(Delivery_ID)
);

CREATE TABLE Payment_Record (
    PR_ID INT,
    PR_Ref_Code VARCHAR(20),
    PR_Date DATE,
    PR_Amount_Paid DECIMAL(10,2),
    PR_Method VARCHAR(30),
    PR_Status VARCHAR(20),
    PR_Received VARCHAR(10),
    PR_Created DATE,
    PR_Currency VARCHAR(10),
    Invoice_ID INT,
    Sales_Person_ID VARCHAR(4),
    Delivery_ID VARCHAR(10),
    Supplier_ID VARCHAR(10),
    PRIMARY KEY (PR_ID, PR_Ref_Code),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Sales_Person_ID) REFERENCES Sales_Person(Sales_Person_ID),
    FOREIGN KEY (Delivery_ID) REFERENCES Delivery(Delivery_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
UNIQUE(PR_ID)
);


CREATE TABLE Equipment(
Equipment_ID VARCHAR(20),
Equipment_Ref_Code VARCHAR(50),
    Equipment_Name VARCHAR(100),
    Equipment_Brand VARCHAR(100),
    Equipment_Model VARCHAR(100),
    Equipment_Purchase_Date DATE,
    Equipment_Warranty_Expiry DATE,
    Equipment_Material VARCHAR(100),
   Equipment_Location VARCHAR(100),
    Equipment_Status VARCHAR(100),
Delivery_ID VARCHAR(10),
Supplier_ID VARCHAR(10),
FOREIGN KEY(Delivery_ID)REFERENCES Delivery(Delivery_ID),
FOREIGN KEY(Supplier_ID)REFERENCES Supplier(Supplier_ID),
PRIMARY KEY(Equipment_ID,Equipment_Ref_Code),
UNIQUE(Equipment_ID)
);




CREATE TABLE Service_Equipment (
    Service_ID INT NOT NULL,
    Equipment_ID VARCHAR(20) NOT NULL,
    PRIMARY KEY (Service_ID, Equipment_ID),
    FOREIGN KEY (Service_ID) REFERENCES Service(Service_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID)
);


CREATE TABLE TrainingCertificate_Employee (
    TC_ID VARCHAR(20) NOT NULL,
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (TC_ID, Employee_ID),
    FOREIGN KEY (TC_ID) REFERENCES Training_Certificate(TC_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Training_Employee (
    Training_ID VARCHAR(20) NOT NULL,
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Training_ID, Employee_ID),
    FOREIGN KEY (Training_ID) REFERENCES Training(Training_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


CREATE TABLE Training_Department (
    Training_ID VARCHAR(20) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Training_ID, Department_ID),
    FOREIGN KEY (Training_ID) REFERENCES Training(Training_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);


CREATE TABLE Technician_Service (
    Technician_ID VARCHAR(15) NOT NULL,
    Service_ID INT NOT NULL,
    PRIMARY KEY (Technician_ID, Service_ID),
    FOREIGN KEY (Technician_ID) REFERENCES Technician(Technician_ID),
    FOREIGN KEY (Service_ID) REFERENCES Service(Service_ID)
);


CREATE TABLE Delivery_Stock (
    Delivery_ID VARCHAR(10) NOT NULL,
    Stock_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Delivery_ID, Stock_ID),
    FOREIGN KEY (Delivery_ID) REFERENCES Delivery(Delivery_ID),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID)
);


CREATE TABLE EmergencyContact_Employee (
    EC_ID INT NOT NULL,
    Employee_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (EC_ID, Employee_ID),
    FOREIGN KEY (EC_ID) REFERENCES Emergency_Contact(EC_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Contract_Stock (
    Contract_ID VARCHAR(15) NOT NULL,
    Stock_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Contract_ID, Stock_ID),
    FOREIGN KEY (Contract_ID) REFERENCES Contract(Contract_ID),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID)
);


CREATE TABLE Employee_Supplier (
    Employee_ID VARCHAR(15) NOT NULL,
    Supplier_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Employee_ID, Supplier_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);


CREATE TABLE Feedback_Person (
    Feedback_ID VARCHAR(50) NOT NULL,
    Person_IC VARCHAR(50) NOT NULL,
    PRIMARY KEY (Feedback_ID, Person_IC),
    FOREIGN KEY (Feedback_ID) REFERENCES Feedback(Feedback_ID),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);


CREATE TABLE Photocopier_Technician (
    Photocopier_ID INT NOT NULL,
    Technician_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Photocopier_ID, Technician_ID),
    FOREIGN KEY (Photocopier_ID) REFERENCES Photocopier(Photocopier_ID),
    FOREIGN KEY (Technician_ID) REFERENCES Technician(Technician_ID)
);


CREATE TABLE Equipment_Payment_Record (
    Equipment_ID VARCHAR(20)NOT NULL,
    PR_ID INT NOT NULL,
    PRIMARY KEY (Equipment_ID, PR_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID),
    FOREIGN KEY (PR_ID) REFERENCES Payment_Record(PR_ID)
);

CREATE TABLE Invoice_Stock (
    Invoice_ID INT NOT NULL,
    Stock_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Invoice_ID, Stock_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID)
);


CREATE TABLE Invoice_PIC (
    Invoice_ID INT NOT NULL,
    PIC_ID VARCHAR(15) NOT NULL,
    PRIMARY KEY (Invoice_ID, PIC_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (PIC_ID) REFERENCES PIC(PIC_ID)
);


CREATE TABLE Stock_PaymentRecord (
    Stock_ID VARCHAR(10) NOT NULL,
    PR_ID INT NOT NULL,
    PRIMARY KEY (Stock_ID, PR_ID),
    FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID),
    FOREIGN KEY (PR_ID) REFERENCES Payment_Record(PR_ID)
);

CREATE TABLE Technician_Equipment (
    Technician_ID VARCHAR(15) NOT NULL,
    Equipment_ID VARCHAR(20) NOT NULL,
    PRIMARY KEY (Technician_ID, Equipment_ID),
    FOREIGN KEY (Technician_ID) REFERENCES Technician(Technician_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID)
);


