--Load data into addresses
INSERT INTO homes (House_Number, Street, City, State, Zip, Neighborhood_id)
VALUES (12946,'Nebraska Ave','Omaha','NE',68164,1),
(13002,'Nebraska Ave','Omaha','NE',68164,1),
(13008,'Nebraska Ave','Omaha','NE',68164,1),
(13011,'Nebraska Ave','Omaha','NE',68164,1),
(13012,'Nebraska Ave','Omaha','NE',68164,1),
(13015,'Nebraska Ave','Omaha','NE',68164,1),
(13016,'Nebraska Ave','Omaha','NE',68164,1),
(13019,'Nebraska Ave','Omaha','NE',68164,1),
(13022,'Nebraska Ave','Omaha','NE',68164,1),
(13023,'Nebraska Ave','Omaha','NE',68164,1),
(13030,'Nebraska Ave','Omaha','NE',68164,1);

--Load Data into violations
INSERT INTO violations (Home_id, Reason)
VALUES (3, 'Wood rot located on windows above the garage'),
(4, 'House is painted orange'),
(7, 'Large weeds growing in flower beds')
(9, 'Weeds cover more than 50% of the front lawn.');

UPDATE violations
SET Date_Resolved = '2026-10-04 20:45:00'
WHERE id = 3;

-- Load data into notifications table
INSERT INTO notifications (Violation_id, Date_Recorded)
VALUES (1, CURRENT_TIMESTAMP),
(2, CURRENT_TIMESTAMP),
(3, CURRENT_TIMESTAMP);

INSERT INTO homeowners (first_name, last_name, residence, email)
VALUES ('Sam', 'Smith', 1, 'samsmith@gmail.com'),
('Mike', 'May', 2, 'Mikemay@hotmail.com'),
('Nancy', 'Swan', 3, 'Swanlake52@aol.com'),
('David', 'Black', 4, 'DMblack@gmc.com'),
('Theresa', 'Smith', 5, 'Tsmith@gmail.com'),
('Danny', 'Rear', 6, 'dannyrear@gmail.com'),
('Samantha', 'Cooley', 7, 'Sam@cooley.com'),
('Mary', 'Elizabeth', 8, 'Queenbeth@aol.com'),
('Dick', 'Tracey', 9, 'traceyturkeys@msn.com'),
('RJ', 'Donley', 10, 'RJ25@zohomail.com'),
('Terrence', 'Patel', 11, 'Tpatel@shell.com');
