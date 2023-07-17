--create DATABASE a3
--go
--use a3

Drop TABLE Loan
drop table Reservation
drop table Acquisition
Drop Table Student_CourseOffering
drop table CourseDetails
Drop Table CourseOffering_Privilege
Drop TABLE Moveable
drop table Immovable
Drop TABLE Resource
drop table CourseOfferingNew
drop table privilege
Drop TABLE Category
Drop TABLE StudentMember
drop table StaffMember
Drop TABLE Member

go

CREATE TABLE Member(
    memberID      VARCHAR(15)           NOT NULL, 
    FirstName     VARCHAR(20)           NOT NULL, 
    LastName      VARCHAR(20)           NOT NULL, 
    PhoneNo       INT,
    ActiveStatus  VARCHAR(8)            DEFAULT 'active' CHECK (ActiveStatus IN ('active', 'expire')) NOT NULL, 
    Address       VARCHAR(50),
    Comments      VARCHAR(300),
    Email         VARCHAR(50)           NOT NULL, 
    PRIMARY KEY (memberID),
);
go

CREATE TABLE StudentMember(
    memberID        VARCHAR(15)         NOT NULL, 
    HoldPoint       INT                 DEFAULT 12,
    PRIMARY KEY (memberID),
    Foreign Key (memberID) references Member(memberId) On Update Cascade On 
    Delete CASCADE,
);
go
create table StaffMember(
	MemberID        VARCHAR(15)         NOT NULL,
	Position        VARCHAR(20), 
    AdminFlag       VARCHAR(10)         NOT NULL,
	primary key (MemberID),
	foreign key (MemberID) references Member(MemberId) on update cascade on delete NO ACTION,
);
go
CREATE TABLE Category(
    CategoryId      INT                 NOT NULL,
    name            VARCHAR(20)         NOT NULL,
    Description     varchar(300)        NOT NULL,
    maxTime         VarChar(20)         NOT NULL,
    PRIMARY KEY (categoryID),
);
go
Create Table Resource(
    resourceID      VARCHAR (10)        NOT NULL,
    Description     VARCHAR(50)         NOT NULL, 
    Status          VARCHAR(20)         DEFAULT 'available' CHECK (Status IN ('available', 'occupied', 'damaged'))  NOT NULL, 
    categoryID      INT,
    PRIMARY KEY (resourceID),
    FOREIGN KEY (categoryID) REFERENCES Category(CategoryId) ON UPDATE CASCADE ON
    DELETE NO ACTION,
 
);
go

CREATE TABLE Moveable(
    resourceID          VARCHAR (10)    NOT NULL,
    name                VARCHAR (50)    NOT NULL, 
    Make                VARCHAR(50), 
    Manufacturer        VARCHAR(50), 
    Model               VARCHAR(50),
    Year                int, 
    AssetValue          Money    NOT NULL,
PRIMARY KEY (resourceID),
FOREIGN KEY (resourceID) REFERENCES resource(resourceID) ON UPDATE CASCADE ON
DELETE CASCADE
);
go

create table Immovable(
	ResourceID          varchar (10)    NOT NULL,
	Capacity            INT, 
	RoomId              INT, 
    BuildingId          varchar(10), 
    Campus              varchar(20), 
	primary key (ResourceID),
	foreign key (ResourceID) references resource(ResourceID) on update cascade on delete CASCADE
);
go

CREATE TABLE Loan(
    loanID              INT,
    dateTimeLoaned      DATETIME        NOT NULL, 
    dateTimeReturned    DATEtime,
    dateTimeDue         DATEtime        NOT NULL,
    resourceID          VARCHAR(10)     NOT NULL,
    memberID            VARCHAR(15)     NOT NULL, 
    PRIMARY KEY (loanID),
    FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (resourceID) REFERENCES Moveable ON UPDATE CASCADE ON DELETE NO ACTION,
);
go

create table Reservation(
	ReservationID       int             NOT NULL,
	MemberId            VARCHAR(15)     NOT NULL, 
    ResourceId          VARCHAR(10)     NOT NULL, 
    DateTimeRequired    datetime        NOT NULL,
    DateTimeDue         datetime        NOT NULL, 
	PRIMARY KEY (ReservationId),
	foreign key (MemberId) references Member(memberID) on update cascade on delete no action,
    foreign Key (ResourceId) references Resource(ResourceId) ON UPDATE CASCADE ON DELETE NO ACTION,

);
go

create table Acquisition(
	AcquisitionID       INT             NOT NULL,
	ItemName            VARCHAR(20)     NOT NULL,
    Status              VarChar(20)     DEFAULT 'available',
    fundCode            VarChar(20)     NOT NULL,
    VendorCode          VarChar(20)     NOT NULL,
    Price               money    NOT NULL,
    Make                VarChar(20),
    Manufacturer        VarChar(20),
    Model               VarChar(20),
    Year                Numeric(4),
    Description         VarChar(300),
    Urgency             VarChar(20),
    Notes               VarChar(300),
    MemberId            VarChar(15),
    PRIMARY KEY (AcquisitionID),
	foreign key (MemberID) references Member(MemberID) on update cascade on delete no action
);
go

CREATE TABLE privilege(
	privilegeID		    varchar(20)     NOT NULL,
	name			    varchar(20)     NOT NULL,
	description		    varchar(300)    NOT NULL,
	CategoryID	        int             NOT NULL,
	maxItems	        int             NOT NULL,
	PRIMARY KEY (privilegeID),
    foreign key (CategoryId) references Category(CategoryID) on update cascade on delete no action,
	);
go

CREATE TABLE CourseDetails(
	CourseId		    VARCHAR(8)      NOT NULL,
	Name		        VARCHAR(50),
	PRIMARY KEY (CourseId),
	);
go

CREATE TABLE CourseOfferingNew(
	offeringID          VarChar(8)      NOT NULL,
    courseID            VarChar(8)      NOT NULL,
    yearOffered         numeric(4),
    semesterOffered     int             NOT NULL,
    dateBegins          date            NOT NULL,
    dateEnds            date            NOT NULL,
	PRIMARY KEY (OfferingId),
	);
go

CREATE TABLE student_CourseOffering(
	MemberID	        varchar(15)      NOT NULL,
	OfferingID	        varchar(8)       NOT NULL,
	PRIMARY KEY (MemberID, OfferingID),
	FOREIGN KEY (MemberID) REFERENCES studentMember(MemberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (OfferingID) REFERENCES courseOfferingNEW(offeringID) ON UPDATE CASCADE ON DELETE NO ACTION
	);
go

CREATE TABLE CourseOffering_Privilege(
	privilegeID		    varchar(20)     NOT NULL,
	OfferingID	        varchar(8)      NOT NULL,
	PRIMARY KEY (privilegeID, OfferingID),
	FOREIGN KEY (privilegeID) REFERENCES privilege(privilegeID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (OfferingID) REFERENCES courseOfferingNEW(offeringID) ON UPDATE CASCADE ON DELETE NO ACTION
	);
go



--Input proper data:
INSERT INTO Member VALUES('C3212345', 'Hassan', 'Ali', 0478612345, 'active', '2 Jannat Al-Baqi, Medina, Saudi Arabia', 'Student of Uon', 'C3212345@uon.edu.au')
INSERT INTO Member VALUES('C3212344', 'Hussain', 'Ali', 0478612355, 'active', '1 Karbala 56001, Iraq', 'Student of Uon', 'C3212344@uon.edu.au')
INSERT INTO Member VALUES('C3212333', 'Abbas', 'Ali', 0478612333, 'active', '2 Karbala 56001, Iraq', 'Student of Uon', 'C3212333@uon.edu.au')
INSERT INTO Member VALUES('C3212222', 'Zaynab', 'Ali', 0478672333, 'active', 'El Sayeda Zeinab, Cairo Governorate, Egypt', 'student of uon', 'C3212222@uon.edu.au')
INSERT INTO Member VALUES('C1111111', 'Mohammed', 'Mustafa', 0478672111, 'active', 'Al Haram, Medina 42311, Saudi Arabia', 'Teacher of Uon callaghan and Nuspace', 'C1111111@uon.edu.au')
INSERT INTO Member VALUES('C1111112', 'Ali', 'Murtaza',  0478672112, 'active', 'Imam Sadiq St, Najaf, Iraq', 'Teacher of callaghan', 'C1111112@uon.edu.au')
INSERT INTO Member VALUES('C1111113', 'Fatema', 'Mohammed', 0478672113, 'active', '1 Jannat Al-Baqi, Medina, Saudi Arabia', 'Teacher at uon nuspace', 'C1111113@uon.edu.au')
INSERT INTO Member VALUES('C1111114', 'Adam', 'Ibrahimi', 0431338123, 'expire', '1 University Dr, Callaghan NSW 2308', 'Personal Trainer at the Forum uon', 'C1111114@uon.edu.au')
GO

INSERT INTO StudentMember VALUES('C3212345', 11)
INSERT INTO StudentMember VALUES('C3212344', 12) 
INSERT INTO StudentMember VALUES('C3212333', 4)
INSERT INTO StudentMember VALUES('C3212222', 1)

/*Select * from Member M, StudentMember s
where m.memberID = s.memberID ; */

INSERT INTO StaffMember VALUES('C1111111', 'Head Teacher', 'Admin')
INSERT INTO StaffMember VALUES('C1111112', 'Second Head Teacher', 'Admin')
INSERT INTO StaffMember VALUES('C1111113', 'Teacher', 'Not Admin')
INSERT INTO StaffMember VALUES('C1111114', 'Personal Trainer', 'Not Admin')
GO

INSERT INTO Category VALUES(12345, 'Camera', 'Photography and Videography equipment', 'one week')
INSERT INTO Category VALUES(54321, 'TextBooks', 'TextBook resources', 'one week')
INSERT INTO Category VALUES(53214, 'Calculators', 'Casio mathematical calculators', '2 days')
INSERT INTO Category VALUES(82234, 'BasketBalls', 'Spalding Balls for Basketball', '5 hours'),
                           (83465, 'Speakers', 'Sony Speaker system (Purple)', '2 Days')

GO

INSERT INTO Resource VALUES('ABC1234567', 'Canon EOS 3000D DSLR Camera', 'occupied', 12345)
INSERT INTO Resource(resourceID, Description, categoryID) VALUES('ABC2234567', 'Introduction to Algebra', 54321)
INSERT INTO Resource VALUES('DEF4543465', 'Casio fx-82AU PLUS', 'damaged', 53214)
INSERT INTO Resource(resourceID, Description, categoryID) VALUES('BBL9999999', 'BasketBall 001', 82234)
INSERT INTO Resource(resourceID, Description) VALUES('EVT4985367', 'ComputerLab')
INSERT INTO Resource(resourceID, Description, Status) VALUES('SRT4298976', 'Health and Disease Research Lab', 'Occupied')
INSERT INTO Resource(resourceID, Description, Status) VALUES('GHD4534636', 'Lecture Teather', 'Occupied')
INSERT INTO Resource(resourceID, Description, Status) VALUES('NUG3408963', 'Mathematics Room', 'Occupied')
GO

INSERT INTO Moveable VALUES('ABC1234567',  'DSLR Camera', 'EOS', 'Canon', '3000D', 2015, 5640.35)
INSERT INTO Moveable(resourceID,  name, AssetValue) VALUES('ABC2234567',  'Introduction to Algebra', 346.25)
INSERT INTO Moveable VALUES('DEF4543465',  'Casio Scientifc and graphic calculator', 'Plus', 'Casio', 'fx-82AU', 2013, 50.00)
INSERT INTO Moveable(resourceID,  name, Manufacturer, AssetValue) VALUES('BBL9999999',  'BasketBall 001', 'Spalding', 50.00)
GO

INSERT INTO Immovable VALUES('EVT4985367', 30, 435, 'CAL', 'NUSpace')
INSERT INTO Immovable VALUES('SRT4298976', 30, 685, 'HDL', 'Callaghan')
INSERT INTO Immovable VALUES('GHD4534636', 500, 112, 'LA2', 'Callaghan')
INSERT INTO Immovable VALUES('NUG3408963', 20, 546, 'MATH03', 'Singapore')
GO

INSERT INTO Loan VALUES(11111, '2022-10-01 01:02:03', '2022-10-02 01:02:43', '2022-10-03 01:02:00', 'ABC1234567', 'C3212345')
INSERT INTO Loan VALUES(11112, '2022-10-03 01:02:03', '2022-10-03 02:02:56', '2022-10-03 10:00:00', 'DEF4543465', 'C3212344')
INSERT INTO Loan VALUES(11113, '2022-10-04 01:02:03', '2022-10-05 01:02:55', '2022-10-06 11:00:00', 'ABC1234567', 'C3212333')
INSERT INTO Loan VALUES(11114, '2022-10-05 01:02:03', '2022-10-06 01:02:15', '2022-10-07 11:00:00', 'DEF4543465', 'C3212222')
INSERT INTO Loan VALUES(11115, '2022-09-06 01:02:03', '2022-09-07 01:02:10', '2022-09-08 04:02:00', 'ABC2234567', 'C3212345')
INSERT INTO Loan VALUES(11116, '2022-08-07 01:02:03', '2022-08-08 01:02:11', '2022-08-09 06:02:00', 'DEF4543465', 'C3212222')
INSERT INTO Loan VALUES(11117, '2022-06-08 01:02:03', '2022-06-09 01:02:22', '2022-06-10 23:59:59', 'BBL9999999', 'C1111114')
INSERT INTO Loan VALUES(11118, '2022-08-09 01:02:03', '2022-08-10 01:02:33', '2022-08-10 10:02:00', 'DEF4543465', 'C3212345')
INSERT INTO Loan VALUES(11119, '2022-10-10 01:02:03', '2022-10-22 01:02:44', '2022-10-11 01:02:03', 'ABC1234567', 'C3212344')
GO

INSERT INTO Reservation VALUES(2342551, 'C1111112', 'NUG3408963', '2021-11-11 12:04:22', '2022-12-11 12:04:22')
INSERT INTO Reservation VALUES(2342555, 'C1111113', 'GHD4534636', '2021-11-11 12:04:00', '2022-12-11 12:04:00')
INSERT INTO Reservation VALUES(2342251, 'C1111111', 'SRT4298976', '2022-11-11 12:03:00', '2022-12-13 11:03:00')
INSERT INTO Reservation VALUES(7950549, 'C1111112', 'EVT4985367', '2022-11-20 01:20:00', '2022-12-20 04:04:22')
INSERT INTO Reservation VALUES(7951549, 'C1111113', 'SRT4298976', '2022-05-01 14:20:00', '2022-06-02 04:04:22')
INSERT INTO Reservation VALUES(7952549, 'C1111112', 'EVT4985367', '2022-06-05 06:20:00', '2022-06-06 06:00:00')
INSERT INTO Reservation VALUES(7952849, 'C1111112', 'EVT4985367', '2022-09-19 05:50:00', '2022-09-20 06:00:00')
GO

INSERT INTO Acquisition(AcquisitionID, ItemName, [Status], fundCode, VendorCode, Price, Urgency, Notes, MemberId) VALUES(278346, 'Coffee Cups', 'available', 'HJF435', 'FES345', 23.30, 'high', 'Need for annual staff meeting', 'C1111111')
INSERT INTO Acquisition VALUES(2352837, 'Microphone', 'Available', 'MIC123', 'MIC321', 120.50, 'ABC123', 'Sony', 'XYZ321', 2022, 'Sony Wireless Microphone (Black)', 'Low', 'Need as one is broken', 'C1111113')
INSERT INTO Acquisition VALUES(4352875, 'Speaker', 'Available', 'SPK232', 'SPK342', 500, 'SWF234', 'Rhode', 'POP123', 2022, 'Rhode Subwoofer Speaker system (Green)', 'High', 'Need Very urgent', 'C1111114')
INSERT INTO Acquisition VALUES(4375863, 'Printer', 'Available', 'BEU425', 'EIF325', 1200.00, 'GJB423', 'NOCAP', 'PRI888', 2022, 'All fax no cap', 'Low', 'Replacemnt printer for staff room', 'C1111114')
GO

INSERT INTO privilege VALUES('PRIV54321111', 'Basketball Team', 'Basketball resources for the Unis home team', 82234, 20)
INSERT INTO privilege VALUES('PRIV54322222', 'MATH1110', 'Access to Calculators for Math class', 82234, 20)
INSERT INTO privilege VALUES('PRIV54333333', 'PHTO1111', 'Access to Cameras for Photography class', 12345, 5)
INSERT INTO privilege VALUES('PRIV33333333', 'ENGG2500', 'Access to Enginering textbooks', 54321, 7),
                            ('PRIV44444444', 'PHTO1111', 'Photography class speaker loan', 83465, 3)
GO


INSERT INTO CourseDetails VALUES('MATH1110', 'Maths for Engineering')
INSERT INTO CourseDetails VALUES('SENG2250', 'System and Netowrk Security')
INSERT INTO CourseDetails VALUES('SENG1540', 'Software Engineering and Management')
INSERT INTO CourseDetails VALUES('PHTO1111', 'Introduction to Photographics techniques')
GO

INSERT INTO CourseOfferingNew VALUES('EUE235', 'MATH1110', 2022, 2, '01-01-2022', '02-02-2022') 
INSERT INTO CourseOfferingNew VALUES('OUB976', 'BBAL2323', 2022, 1, '10-10-2022', '12-12-2022') 
INSERT INTO CourseOfferingNew VALUES('BAL324', 'SENG2500', 2021, 1, '11-11-2021', '12-12-2021') 
INSERT INTO CourseOfferingNew VALUES('UHB833', 'PHTO1111', 2022, 2, '01-01-2022', '01-03-2022') 
GO

INSERT INTO student_CourseOffering VALUES('C3212345', 'EUE235')
INSERT INTO student_CourseOffering VALUES('C3212344', 'EUE235')
INSERT INTO student_CourseOffering VALUES('C3212333', 'EUE235')
INSERT INTO student_CourseOffering VALUES('C3212345', 'UHB833')
GO

INSERT INTO CourseOffering_Privilege VALUES('PRIV54321111', 'OUB976')
INSERT INTO CourseOffering_Privilege VALUES('PRIV54322222', 'EUE235')
INSERT INTO CourseOffering_Privilege VALUES('PRIV54333333', 'UHB833')
INSERT INTO CourseOffering_Privilege VALUES('PRIV33333333', 'BAL324')
INSERT INTO CourseOffering_Privilege VALUES('PRIV44444444', 'UHB833')
GO


--Q1: Print the name of student(s) who has/have enrolled in the course with course id MATH1110. (5) 
SELECT m.FirstName, m.LastName, CON.courseID AS [Enrolled In:]
FROM Member m, studentMember student, CourseOfferingNew con,	student_CourseOffering studenttocourse
where m.memberID = student.MemberID and student.MemberID = studenttocourse.MemberID and studenttocourse.OfferingID = con.offeringID and con.courseID = 'MATH1110'

--Q2: Print the maximal number of speakers that the student with name Hassan Ali can borrow. The student is enrolled in the course with course id PHTO1111. Note: speaker is a category. (5) 
SELECT mem.FirstName, mem.LastName, c.name AS [Category], priv.maxItems AS [Maximal number that can be loaned]
FROM privilege priv, member mem, studentMember student, student_CourseOffering studenttocourse, courseOffering_Privilege coursetopriv, courseOfferingNew con, Category c
where mem.memberID = student.memberID and mem.FirstName = 'Hassan' and mem.LastName = 'Ali' and student.memberID = studenttocourse.memberID and studenttocourse.OfferingID = coursetopriv.offeringID and coursetopriv.privilegeID = priv.privilegeID and c.CategoryId = priv.CategoryID and c.name = 'Speakers' and coursetopriv.offeringID = con.offeringID and con.courseID = 'PHTO1111'
--Q3: For a staff member with id number C1111112, print his/her name and phone number, the total number of reservations that the staff had made in 2022. (10) 
SELECT mem.memberID, mem.firstname, mem.LastName, mem.phoneNo, count( distinct res.reservationID) as [Total Reservations in 2022]
FROM member mem, staffMember staff, acquisition acq, reservation res
where mem.MemberID = Staff.memberID and staff.MemberID = 'C1111112' and (mem.memberID = res.memberID and res.DateTimeRequired > '2021-12-31 23:59:59' and res.DateTimeRequired < '2023-01-01 00:00:00')
group by mem.memberID, mem.firstname, mem.LastName, mem.phoneNo
--Q4: Print the name(s) of the student member(s) who has/have borrowed the category with the name of  camera,  of  which  the  model  is  3000D,  in  this  year.  Note:  camera  is  a  category,  model  attribute must be in movable table, and “this year” must be decided by the system. (10) 
SELECT mem.Firstname, mem.Lastname
FROM Member mem, studentMember student, loan l, moveable m,  category c, resource r
WHERE student.memberID = l.memberID and mem.memberID = student.memberID and l.resourceID = m.ResourceID and m.resourceID = r.resourceID and r.categoryID = c.categoryId and c.name = 'Camera' and m.model = '3000D' and year(l.dateTimeLoaned) = Year(SYSDATETIME ())
--Q5: Find the moveable resource that is the mostly loaned in current month. Print the resource id and resource name. Note: “current month” must be decided by the system. (10) 

Select r.resourceID, r.Name
From Loan l, moveable r
Where  l.resourceID = r.resourceID and Month(l.dateTimeLoaned) = month(SYSDATETIME ())
And year(l.dateTimeLoaned) = Year(SYSDATETIME ())
GROUP BY r.resourceID, r.name
HAVING COUNT(*) >=ALL
      (SELECT COUNT (*)
      FROM Loan l, Moveable mr
      WHERE l.resourceID = mr.resourceID and Month(l.dateTimeLoaned) = month(SYSDATETIME ())
GROUP BY mr.resourceID)
/*
--Q6: For each of the three days, including May 1, 2022, June 5, 2022, and September 19, 2022, print the date, the name of the room, and the total number of reservations made for the room id: 685 on each day. (10) 
*/ 
SELECT res.DateTimerequired AS [Date], r.[Description] as [Room Name], count(ReservationID) as [Number of reservations]
FROM reservation res, Resource R, Immovable I
where res.resourceID = R.resourceID and r.resourceId = I.ResourceID and I.RoomId = 685 and ((res.DateTimerequired > '2022-04-30 23:59:59' and res.DateTimerequired < '2022-05-01 23:59:59')) -- or (res.DateTimerequired > '2022-06-04 23:59:59' and res.DateTimerequired < '2022-06-05 23:59:59') or (res.DateTimerequired > '2022-09-18 23:59:59' and res.DateTimerequired < '2022-09-19 23:59:59'))
group by  res.DateTimerequired, r.[Description]




