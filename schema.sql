CREATE TABLE `neighborhood`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `Name` VARCHAR(64) NOT NULL,
    `Date_Created` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

CREATE TABLE `homeowners`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `First_Name` VARCHAR(64) NOT NULL,
    `Last_Name` VARCHAR(64) NOT NULL,
    `Residence` INT UNSIGNED,
    `Email` VARCHAR(256) UNIQUE NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`residence`) REFERENCES `homes`(`id`)
);

CREATE TABLE `homes` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `House_Number` INT NOT NULL,
    `Street` VARCHAR(64) NOT NULL,
    `City` VARCHAR(64) NOT NULL,
    `State` CHAR(2) NOT NULL,
    `Zip` Char(5) NOT NULL,
    `Neighborhood_id` INT UNSIGNED,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`Neighborhood_id`) REFERENCES `neighborhood`(`id`)
);

CREATE TABLE `violations`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `Home_id` INT UNSIGNED,
    `Reason` VARCHAR(256),
    `Date_Recorded` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `Date_Resolved` DATETIME,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`Home_id`) REFERENCES `homes`(`id`)
);


CREATE TABLE `notifications`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `Violation_id` INT UNSIGNED,
    `Date_Recorded` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`Violation_id`) REFERENCES `violations`(`id`)
);

CREATE TABLE `email_queue`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `violation_id` INT UNSIGNED,
    `recipient_email` VARCHAR(256) NOT NULL,
    `subject` VARCHAR(255) NOT NULL,
    `body` TEXT NOT NULL,
    `is_sent` BOOLEAN DEFAULT FALSE,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`violation_id`) REFERENCES `violations`(`id`),
    FOREIGN KEY(`recipient_email`) REFERENCES `homeowners`(`Email`)
);

DELIMITER //

CREATE TRIGGER inital_notification
AFTER INSERT ON `violations`
FOR EACH ROW
BEGIN
    INSERT INTO `notifications` (
        `violation_id`,
        `Date_Recorded`
    )
    VALUES (
        NEW.id,
        NEW.Date_Recorded
    );
END//

DELIMITER ;


DELIMITER //

CREATE TRIGGER update_email_queue
AFTER INSERT ON `notifications`
FOR EACH ROW
BEGIN
    INSERT INTO `email_queue` (
        `violation_id`,
        `recipient_email`,
        `subject`,
        `body`
    )
    SELECT
    violations.id,
    homeowners.Email,
    CONCAT('Notification regarding violation ', violations.id),
    CONCAT(
            'Dear ', homeowners.First_Name, ' ', homeowners.Last_Name, ',\n\n',
            'A violation has been recorded for your residence at ',
            homes.House_Number, ' ', homes.Street, ', ',
            homes.City, ', ', homes.State, ' ', homes.Zip, '.\n\n',
            'Reason: ', violations.Reason, '\n',
            'Date Recorded: ', violations.Date_Recorded, '\n\n',
            'Please take the necessary action to resolve this violation.')
    FROM `violations`
    JOIN `homes`
        ON violations.Home_id = homes.id
    JOIN `homeowners`
        ON homeowners.Residence = homes.id
    WHERE violations.id = NEW.Violation_id;
END//

DELIMITER ;
