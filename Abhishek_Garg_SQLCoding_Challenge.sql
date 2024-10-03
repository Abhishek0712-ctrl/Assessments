create database Crime_manager
 
use Crime_manager


CREATE TABLE Crime ( 
    CrimeID INT PRIMARY KEY, 
    IncidentType VARCHAR(255), 
    IncidentDate DATE, 
    Location VARCHAR(255), 
    Description TEXT, 
    Status VARCHAR(20) 
);

CREATE TABLE Victim ( 
    VictimID INT PRIMARY KEY, 
    CrimeID INT, 
    Name VARCHAR(255), 
    ContactInfo VARCHAR(255), 
    Injuries VARCHAR(255), 
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID) 
);

CREATE TABLE Suspect ( 
    SuspectID INT PRIMARY KEY, 
    CrimeID INT, 
    Name VARCHAR(255), 
    Description TEXT, 
    CriminalHistory TEXT, 
    FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID) 
);

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status) 
VALUES 
    (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'), 
    (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'), 
    (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries) 
VALUES 
    (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'), 
    (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
	(3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None'); 

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory) 
VALUES 
(1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'), 
(2, 2, 'Unknown', 'Investigation ongoing', NULL), 
(3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests'); 


--ANS 1

select * from Crime where status ='Open'

--ANS 2

select count(*) as TotalIncidents from Crime

--ANS 3

select Distinct IncidentType from Crime

--ANS 4

select * from Crime where IncidentDate between '2023-09-01' and '2023-09-10'

--ANS 5

select * from victim order by Age Desc

--ANS 6

select avg(Age) as AverageAge from Victim

--ANS 7

select  incidenttype, count(IncidentType)as Count,Status from Crime group by IncidentType,Status having Status='open'

--ANS 8

select * from victim where Name like '%Doe'

--ANS 9

select v.Name,c.Status from Crime c join Victim v on c.CrimeID=v.VictimID where c.Status='Open' or c.Status='Closed'


--ANS 10

select c.IncidentType,v.age from Crime c join Victim v on c.CrimeID=v.CrimeID where v.Age=30 or v.Age=35

--ANS 11

select v.Name,c.IncidentType,c.Description from Crime c join Victim v on c.CrimeID=v.VictimID where c.IncidentType='Robbery'

--ANS 12

select IncidentType,count(*) from Crime where Status='Open' group by IncidentType having count(*)>1

--ANS 13

SELECT c.CrimeID,c.IncidentType,c.IncidentDate,c.Location,s.Name AS SuspectName
FROM Crime c
JOIN Suspect s ON c.CrimeID = s.CrimeID
JOIN Victim v ON s.Name = v.Name AND s.CrimeID = v.CrimeID;


--ANS 14

select c.CrimeID,c.IncidentType,c.Description,c.IncidentDate,c.Status,v.VictimID,v.Name,v.ContactInfo,s.SuspectID,s.Name,s.Description 
from Crime c join Victim v 
on c.CrimeID=v.CrimeID 
join Suspect s on c.CrimeID=s.CrimeID

--ANS 15

select CrimeID,IncidentType,Location,Description,Status from crime where CrimeID in (select v.CrimeID from victim v join Suspect s on v.CrimeID=s.CrimeID where s.age>v.age)

--ANS 16

SELECT Name, COUNT(DISTINCT CrimeID) AS IncidentCount
FROM Suspect
GROUP BY Name
HAVING COUNT(DISTINCT CrimeID) > 1;

--ANS 17

select c.CrimeID,s.SuspectID,s.Name,s.Description,c.IncidentType from Crime c join Suspect s on c.CrimeID=s.CrimeID where s.SuspectID=NULL

--ANS 18

select * from Crime where IncidentType='Homicide' or IncidentType='Robbery'

--Ans 19

SELECT c.CrimeID,c.IncidentType,c.IncidentDate,c.Location,s.Name
FROM Crime c
LEFT JOIN Suspect s 
ON c.CrimeID = s.CrimeID;


--ANS 20

select SuspectID,CrimeID,name,Description,CriminalHistory,Age 
from suspect where CrimeID in 
(select CrimeID from Crime where IncidentType='Robbery' or IncidentType='Assault')