drop table ContactLink;
drop table WorkHistory;
drop table Organization;
drop table Contact;

create table Contact (
	ContactId			varchar(36)		not null,
	DateOfBirth			date,
	FirstName			varchar(25)		not null,
	LastName			varchar(25)		not null,
	HeightFt			integer,
	HeightInch			integer,
	--Picture				clob,
	PreferredHeight		varchar(25),
	primary key (ContactId)
);

create table Organization (
	OrganizationId		varchar(36)		not null,
	OrganizationName	varchar(50)		not null,
	primary key (OrganizationId)
);

create table WorkHistory (
	WorkHistoryId		varchar(36)		not null,
	ContactId			varchar(36)		not null,
	OrganizationId		varchar(36)		not null,
	StartMonth			varchar(2),
	StartYear			varchar(4),
	EndMonth			varchar(2),
	EndYear				varchar(4),
	JobDescription		varchar(200),
	JobTitle			varchar(50),
	primary key (WorkHistoryId),
	FOREIGN KEY (ContactId) REFERENCES Contact(ContactId),
	FOREIGN KEY (OrganizationId) REFERENCES Organization(OrganizationId)
);

create table ContactLink (
	SourceContactId		varchar(36)		not null,
	TargetContactId		varchar(36)		not null,
	WorkHistoryId		varchar(36)		not null,
	RelationshipType    varchar(10)		not null,
	primary key (SourceContactId, TargetContactId, WorkHistoryId),
	FOREIGN KEY (SourceContactId) REFERENCES Contact(ContactId),
	FOREIGN KEY (TargetContactId) REFERENCES Contact(ContactId),
	FOREIGN KEY (WorkHistoryId) REFERENCES WorkHistory(WorkHistoryId),
	CONSTRAINT valid_relationpship_type_name CHECK (RelationshipType = 'Colleague' OR RelationshipType = 'Friend' OR 
													RelationshipType = 'ReportedTo') 

);

-- Peer 1:
--1
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '1992-1-23', 'John', 'Doe', 5, 9, 'Metric');
--2
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('B6581A36-804D-45AC-B2E2-F6DA265AF7DE', '1990-4-29', 'Jack', 'Smith', 6, 1, 'Metric');
--3
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('0934A378-DEDB-4207-B99C-DD0D61DC59BC', '1987-5-28', 'Mindy', 'Johnson', 5, 1, 'Imperial');
--4 DELETE
--insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
--values ('D83168E5-B6AC-4E6B-8082-A8E72593EA78', '1989-7-21', 'Don', 'Harris', 5, 8, 'Imperial');
--(5, 6)
--7 DELETE:
--insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
--values ('155818E1-18DF-4C5C-B240-44128CB7FACD', '1988-4-1', 'Dick', 'Hoffman', 6, 1, 'Imperial');

--1
insert into Organization (OrganizationId, OrganizationName)
values ('338B5289-960D-4D28-A588-3E53A13C7A54', 'Org 1')
--2
insert into Organization (OrganizationId, OrganizationName)
values ('723883FF-EE9F-4F37-8A41-8151DB07203A', 'Org 2')

--1
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
						jobDescription, 
						jobTitle, organizationId, startMonth, startYear)
values ('5155FFA2-DBA3-4A37-B72E-F9AC7065F599', '42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '', '', 
		'Job Description 1', 
		'Job Title 1', '338B5289-960D-4D28-A588-3E53A13C7A54', '1', '2000');
--2
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
						jobDescription, 
						jobTitle, organizationId, startMonth, startYear)
values ('79C54C95-23E0-4A4D-B85A-652599EAE966', '42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '6', '2000', 
		'Job Description 3', 
		'Job Title 3', '338B5289-960D-4D28-A588-3E53A13C7A54', '2', '1990');
--3
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
						jobDescription, 
						jobTitle, organizationId, startMonth, startYear)
values ('C63DFAC4-658A-4D05-9D01-1C01EF5B732E', 'B6581A36-804D-45AC-B2E2-F6DA265AF7DE', '', '', 
		'Job Description 4', 
		'Job Title 4', '723883FF-EE9F-4F37-8A41-8151DB07203A', '6', '1988');
--4
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
						jobDescription, 
						jobTitle, organizationId, startMonth, startYear)
values ('E30344DA-6290-4A46-83FC-CAB6E5119BD4', '0934A378-DEDB-4207-B99C-DD0D61DC59BC', '', '', 
		'Job Description 5', 
		'Job Title 5', '338B5289-960D-4D28-A588-3E53A13C7A54', '5', '1989');
--(5, 6, 7)

--
--Mindy Johnson (6-1988-present)   Colleague: John Doe 	  | Org 2
--John Doe 		(1-2000-present) Reported To: Jack Smith  | Org 1
--1
insert into ContactLink(sourceContactId, targetContactId, 
						workHistoryId, RelationshipType)
values ('0934A378-DEDB-4207-B99C-DD0D61DC59BC', '42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', 
		'C63DFAC4-658A-4D05-9D01-1C01EF5B732E', 'Colleague');
--2
insert into ContactLink(sourceContactId, targetContactId, 
						workHistoryId, RelationshipType)
values ('42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', 'B6581A36-804D-45AC-B2E2-F6DA265AF7DE', 
		'5155FFA2-DBA3-4A37-B72E-F9AC7065F599', 'ReportedTo');
--(3, 4, 5)

-- Peer 2:
/*
--1
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '1993-1-23', 'John', 'Doe', 5, 9, 'Metric');
--(2)
--3
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('0934A378-DEDB-4207-B99C-DD0D61DC59BC', '1987-5-28', 'Mindy', 'Johnson', 5, 1, 'Imperial');
--4
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('D83168E5-B6AC-4E6B-8082-A8E72593EA78', '1989-7-21', 'Don', 'Harris', 5, 8, 'Imperial');
--5
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('151EFA13-A3AD-4C18-A2CE-9D66D0AED112', '1988-1-23', 'Jill', 'Anderson', 5, 3, 'Metric');
--6
insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
values ('6869F4EC-09BB-4FED-A1A7-B446D2C63BAF', '1988-5-28', 'Jennifer', 'Smith', 5, 4, 'Imperial');
--7 DELETE:
--insert into Contact (ContactId, DateOfBirth, FirstName, LastName, HeightFt, HeightInch, PreferredHeight)
--values ('155818E1-18DF-4C5C-B240-44128CB7FACD', '1988-4-1', 'Dick', 'Hoffman', 6, 1, 'Imperial');

--1
insert into Organization (OrganizationId, OrganizationName)
values ('338B5289-960D-4D28-A588-3E53A13C7A54', 'Org 1')
--2
insert into Organization (OrganizationId, OrganizationName)
values ('723883FF-EE9F-4F37-8A41-8151DB07203A', 'Org 2')

--(1)
--2 DELETE:
--insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
--						  jobDescription, 
--						  jobTitle, organizationId, startMonth, startYear)
--values ('79C54C95-23E0-4A4D-B85A-652599EAE966', '42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '2', '1990', 
--		'Job Description 3', 
--		'Job Title 3', '5', '2000');
--(3, 4)
--5
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
					    jobDescription, jobTitle, 
						organizationId, startMonth, startYear)
values ('4165FB55-FCD9-49B5-BD70-AD7F68F750AF', '151EFA13-A3AD-4C18-A2CE-9D66D0AED112', '', '', 
		'Job Description 3', 'Job Title 3', 
		'338B5289-960D-4D28-A588-3E53A13C7A54', '1', '2012');
--6
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
						jobDescription, jobTitle, 
						organizationId, startMonth, startYear)
values ('6692C889-8A75-4869-B91D-4F1909D00D2B', '6869F4EC-09BB-4FED-A1A7-B446D2C63BAF', '', '', 
		'Job Description 1', 'Job Title 1', 
		'338B5289-960D-4D28-A588-3E53A13C7A54', '3', '2010');
--7
insert into WorkHistory(workHistoryId, contactId, endMonth, endYear, 
					    jobDescription, jobTitle, 
						organizationId, startMonth, startYear)
values ('96B1FB6C-EAB2-42B2-BD0A-FEFC1F98A604', '151EFA13-A3AD-4C18-A2CE-9D66D0AED112', '2', '2010', 
		'Job Description 2', 'Job Title 2', 
		'338B5289-960D-4D28-A588-3E53A13C7A54', '4', '2000');

--
--John Doe		(3-2010-present) Reported To: Jennifer Smith    | Org 1
--Jill Anderson (4-2000-2-2010)    Colleague: John Doe		    | Org 1
--Mindy Johnson (1-2012-present)   Colleague: Don Harris	    | Org 2
--(1, 2)
--3
insert into ContactLink(sourceContactId, targetContactId, 
						workHistoryId, RelationshipType)
values ('42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', '6869F4EC-09BB-4FED-A1A7-B446D2C63BAF', 
		'6692C889-8A75-4869-B91D-4F1909D00D2B', 'ReportedTo');
--4
insert into ContactLink(sourceContactId, targetContactId, 
						workHistoryId, RelationshipType)
values ('151EFA13-A3AD-4C18-A2CE-9D66D0AED112', '42FC5EBC-088D-4DC2-BDBD-D89FA170E5C6', 
		'96B1FB6C-EAB2-42B2-BD0A-FEFC1F98A604', 'Colleague');
--5
insert into ContactLink(sourceContactId, targetContactId, 
						workHistoryId, RelationshipType)
values ('0934A378-DEDB-4207-B99C-DD0D61DC59BC', 'D83168E5-B6AC-4E6B-8082-A8E72593EA78', 
		'4165FB55-FCD9-49B5-BD70-AD7F68F750AF', 'Colleague');
*/

select * from Contact;
select * from WorkHistory;
select * from ContactLink;
select * from Organization;

/*
delete from Contact where (ContactId='D83168E5-B6AC-4E6B-8082-A8E72593EA78')
delete from ContactLink where (SourceContactId='0934A378-DEDB-4207-B99C-DD0D61DC59BC' and 
							   TargetContactId='D83168E5-B6AC-4E6B-8082-A8E72593EA78' and 
							   WorkHistoryId='4165FB55-FCD9-49B5-BD70-AD7F68F750AF')
							   */