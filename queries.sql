--select all neihborhoods
SELECT * FROM neighborhood;

--Select all homes in the given neighborhood
SELECT * FROM homes
WHERE Neighborhood_id = (
    SELECT id
    FROM neighborhood
    WHERE Name = 'simpletown'
);

--Create View to select all homes and group by neighborhood
CREATE VIEW homes_in_database AS
SELECT homes.House_Number, homes.Street, homes.City, homes.State, homes.Zip, neighborhood.id AS "Neighborhood ID", neighborhood.Name AS "Neighborhood Name" FROM homes
JOIN neighborhood ON neighborhood.id = homes.Neighborhood_id
ORDER BY neighborhood.id;

--Query to select all active violations in the neighborhood sorted by home
SELECT * FROM violations
WHERE Date_Resolved IS NULL
ORDER BY Home_id;

-- Query to select all resolved violations in the neighborhood sorted by home
SELECT * FROM violations
WHERE Date_Resolved IS NOT NULL
ORDER BY Home_id;

-- Create view to select notifications per violation and address with neighborhood listed
CREATE VIEW notifications_per_home AS
SELECT homes.Neighborhood_id, neighborhood.Name AS "Neighborhood Name", violations.Home_id, homes.House_Number, homes.Street, notifications.Violation_id, violations.Reason, violations.Date_Recorded AS "violation recorded", violations.Date_Resolved AS "violation resolved", notifications.Date_Recorded AS "Notification Date", homeowners.First_Name, homeowners.Last_Name, homeowners.Email
FROM violations
JOIN notifications on notifications.Violation_id = violations.id
JOIN homes on homes.id = violations.Home_id
JOIN neighborhood on neighborhood.id = homes.Neighborhood_id
JOIN homeowners on homeowners.Residence = homes.id
ORDER BY homes.Neighborhood_id, violations.Home_id, notifications.Violation_id, violations.Date_Recorded;

-- Query the view to select the count of notifications for each active violation with location shown
SELECT `Neighborhood Name`, House_Number, Street, Reason, Violation_id, COUNT(*) AS notification_count
FROM notifications_per_home
WHERE `violation resolved` IS NULL
GROUP BY Violation_id;



