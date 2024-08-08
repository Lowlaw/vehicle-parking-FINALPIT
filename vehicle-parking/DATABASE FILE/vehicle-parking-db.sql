-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2024 at 04:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vehicle-parking-db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAdmin` (IN `p_AdminName` VARCHAR(120), IN `p_UserName` VARCHAR(120), IN `p_MobileNumber` BIGINT, IN `p_Security_Code` INT, IN `p_Email` VARCHAR(200), IN `p_Password` VARCHAR(120))   BEGIN
    INSERT INTO admin (AdminName, UserName, MobileNumber, Security_Code, Email, Password)
    VALUES (p_AdminName, p_UserName, p_MobileNumber, p_Security_Code, p_Email, p_Password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteVehicle` (IN `p_vehicleID` INT)   BEGIN
    DELETE FROM vehicle_info
    WHERE ID = p_vehicleID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateHourlyRate` (IN `categoryId` INT, IN `newHourlyRate` DECIMAL(10,2))   BEGIN
    -- Update the hourly rate for the specified vehicle category
    UPDATE vcategory
    SET HourlyRate = newHourlyRate
    WHERE ID = categoryId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `activevehicles`
-- (See below for the actual view)
--
CREATE TABLE `activevehicles` (
`ID` int(10)
,`ParkingNumber` varchar(120)
,`VehicleCategory` varchar(120)
,`VehicleCompanyname` varchar(120)
,`RegistrationNumber` varchar(120)
,`OwnerName` varchar(120)
,`OwnerContactNumber` bigint(10)
,`InTime` timestamp
,`OutTime` timestamp
,`ParkingCharge` int(100)
,`Remark` mediumtext
,`Status` varchar(5)
,`HourlyRate` decimal(10,2)
,`ParkingTimer` float
);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` int(10) NOT NULL,
  `AdminName` varchar(120) DEFAULT NULL,
  `UserName` varchar(120) DEFAULT NULL,
  `MobileNumber` bigint(10) DEFAULT NULL,
  `Security_Code` int(55) NOT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Password` varchar(120) DEFAULT NULL,
  `AdminRegdate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `AdminName`, `UserName`, `MobileNumber`, `Security_Code`, `Email`, `Password`, `AdminRegdate`) VALUES
(1, 'RYAN OTACAN', 'admin', 7854445410, 6969, 'otacanryan@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '2024-08-03 21:38:23'),
(10, 'rr', 'rr', 123456, 123456, 'rr@gmail.com', '45d839f8449df04d881af4db44597fa1', '2024-08-08 14:34:14');

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `after_update_admin_log_changes` AFTER UPDATE ON `admin` FOR EACH ROW BEGIN
    -- Log changes for AdminName
    IF OLD.AdminName <> NEW.AdminName THEN
        INSERT INTO admin_log (AdminID, FieldChanged, OldValue, NewValue)
        VALUES (OLD.ID, 'AdminName', OLD.AdminName, NEW.AdminName);
    END IF;

    -- Log changes for UserName
    IF OLD.UserName <> NEW.UserName THEN
        INSERT INTO admin_log (AdminID, FieldChanged, OldValue, NewValue)
        VALUES (OLD.ID, 'UserName', OLD.UserName, NEW.UserName);
    END IF;

    -- Log changes for MobileNumber
    IF OLD.MobileNumber <> NEW.MobileNumber THEN
        INSERT INTO admin_log (AdminID, FieldChanged, OldValue, NewValue)
        VALUES (OLD.ID, 'MobileNumber', OLD.MobileNumber, NEW.MobileNumber);
    END IF;

    -- Log changes for Email
    IF OLD.Email <> NEW.Email THEN
        INSERT INTO admin_log (AdminID, FieldChanged, OldValue, NewValue)
        VALUES (OLD.ID, 'Email', OLD.Email, NEW.Email);
    END IF;

    -- Log changes for Password
    IF OLD.Password <> NEW.Password THEN
        INSERT INTO admin_log (AdminID, FieldChanged, OldValue, NewValue)
        VALUES (OLD.ID, 'Password', OLD.Password, NEW.Password);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_log`
--

CREATE TABLE `admin_log` (
  `LogID` int(10) NOT NULL,
  `AdminID` int(10) NOT NULL,
  `FieldChanged` varchar(120) DEFAULT NULL,
  `OldValue` varchar(255) DEFAULT NULL,
  `NewValue` varchar(255) DEFAULT NULL,
  `ChangeTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_log`
--

INSERT INTO `admin_log` (`LogID`, `AdminID`, `FieldChanged`, `OldValue`, `NewValue`, `ChangeTime`) VALUES
(1, 1, 'AdminName', 'ryan Otacan', 'Ryyan Otacan', '2024-08-08 14:02:47'),
(2, 1, 'AdminName', 'Ryyan Otacan', 'RYAN OTACAN', '2024-08-08 14:03:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `parkingchargesbycategory`
-- (See below for the actual view)
--
CREATE TABLE `parkingchargesbycategory` (
`Category` varchar(120)
,`TotalVehicles` bigint(21)
,`TotalCharges` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `c_name` varchar(255) NOT NULL,
  `c_email` varchar(55) NOT NULL,
  `c_website` varchar(55) NOT NULL,
  `c_address` varchar(255) NOT NULL,
  `last_update` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `c_name`, `c_email`, `c_website`, `c_address`, `last_update`) VALUES
(1, 'Otacan - Jarantilla', 'otacan-jarantilla@gmail.com', 'Otacan-Jarantilla.ph', 'Cagayan de Oro City', '2024-08-08 21:53:11');

--
-- Triggers `settings`
--
DELIMITER $$
CREATE TRIGGER `before_update_settings` BEFORE UPDATE ON `settings` FOR EACH ROW BEGIN
    SET NEW.last_update = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vcategory`
--

CREATE TABLE `vcategory` (
  `ID` int(10) NOT NULL,
  `VehicleCat` varchar(120) DEFAULT NULL,
  `shortDescription` varchar(50) NOT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp(),
  `HourlyRate` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vcategory`
--

INSERT INTO `vcategory` (`ID`, `VehicleCat`, `shortDescription`, `CreationDate`, `HourlyRate`) VALUES
(1, 'Four Wheeler', 'Demo 4W', '2024-07-04 03:06:50', 10300.00),
(2, 'Two Wheeler', 'Demo 2W', '2024-07-04 03:07:09', 50.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vehiclecategoryrates`
-- (See below for the actual view)
--
CREATE TABLE `vehiclecategoryrates` (
`Category` varchar(120)
,`Rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_info`
--

CREATE TABLE `vehicle_info` (
  `ID` int(10) NOT NULL,
  `ParkingNumber` varchar(120) DEFAULT NULL,
  `VehicleCategory` varchar(120) NOT NULL,
  `VehicleCompanyname` varchar(120) DEFAULT NULL,
  `RegistrationNumber` varchar(120) DEFAULT NULL,
  `OwnerName` varchar(120) DEFAULT NULL,
  `OwnerContactNumber` bigint(10) DEFAULT NULL,
  `InTime` timestamp NULL DEFAULT current_timestamp(),
  `OutTime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `ParkingCharge` int(100) NOT NULL,
  `Remark` mediumtext NOT NULL,
  `Status` varchar(5) NOT NULL,
  `HourlyRate` decimal(10,2) DEFAULT NULL,
  `ParkingTimer` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vehicle_info`
--

INSERT INTO `vehicle_info` (`ID`, `ParkingNumber`, `VehicleCategory`, `VehicleCompanyname`, `RegistrationNumber`, `OwnerName`, `OwnerContactNumber`, `InTime`, `OutTime`, `ParkingCharge`, `Remark`, `Status`, `HourlyRate`, `ParkingTimer`) VALUES
(38, '94756', 'Four Wheeler', '1231', '123123', '123123', 123123, '2024-08-07 01:13:44', '2024-08-07 01:14:57', 300, 'sada', 'Out', 100.00, 3),
(41, '71026', 'Two Wheeler', 'Honda', '45466', 'ryan otacan', 123456789, '2024-08-07 01:51:56', '2024-08-07 01:52:14', 150, '', '', 50.00, 3),
(42, '90847', 'Four Wheeler', 'test', '2323', 'rqq', 123, '2024-08-08 13:56:49', '2024-08-08 14:41:16', 51500, '', '', 100.00, 5);

--
-- Triggers `vehicle_info`
--
DELIMITER $$
CREATE TRIGGER `after_insert_vehicle_info_log` AFTER INSERT ON `vehicle_info` FOR EACH ROW BEGIN
    INSERT INTO vehicle_info_log (VehicleID, Action)
    VALUES (NEW.ID, 'Inserted');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_info_log`
--

CREATE TABLE `vehicle_info_log` (
  `LogID` int(10) NOT NULL,
  `VehicleID` int(10) NOT NULL,
  `Action` varchar(50) NOT NULL,
  `LogTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle_info_log`
--

INSERT INTO `vehicle_info_log` (`LogID`, `VehicleID`, `Action`, `LogTime`) VALUES
(1, 42, 'Inserted', '2024-08-08 13:56:49');

-- --------------------------------------------------------

--
-- Structure for view `activevehicles`
--
DROP TABLE IF EXISTS `activevehicles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `activevehicles`  AS SELECT `v`.`ID` AS `ID`, `v`.`ParkingNumber` AS `ParkingNumber`, `v`.`VehicleCategory` AS `VehicleCategory`, `v`.`VehicleCompanyname` AS `VehicleCompanyname`, `v`.`RegistrationNumber` AS `RegistrationNumber`, `v`.`OwnerName` AS `OwnerName`, `v`.`OwnerContactNumber` AS `OwnerContactNumber`, `v`.`InTime` AS `InTime`, `v`.`OutTime` AS `OutTime`, `v`.`ParkingCharge` AS `ParkingCharge`, `v`.`Remark` AS `Remark`, `v`.`Status` AS `Status`, `v`.`HourlyRate` AS `HourlyRate`, `v`.`ParkingTimer` AS `ParkingTimer` FROM `vehicle_info` AS `v` WHERE `v`.`Status` = 'Out' ;

-- --------------------------------------------------------

--
-- Structure for view `parkingchargesbycategory`
--
DROP TABLE IF EXISTS `parkingchargesbycategory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `parkingchargesbycategory`  AS SELECT `vc`.`VehicleCat` AS `Category`, count(`v`.`ID`) AS `TotalVehicles`, sum(`v`.`ParkingCharge`) AS `TotalCharges` FROM (`vehicle_info` `v` join `vcategory` `vc` on(`v`.`VehicleCategory` = `vc`.`VehicleCat`)) WHERE `v`.`Status` = 'Out' GROUP BY `vc`.`VehicleCat` ;

-- --------------------------------------------------------

--
-- Structure for view `vehiclecategoryrates`
--
DROP TABLE IF EXISTS `vehiclecategoryrates`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vehiclecategoryrates`  AS SELECT `v`.`VehicleCat` AS `Category`, `v`.`HourlyRate` AS `Rate` FROM `vcategory` AS `v` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `admin_log`
--
ALTER TABLE `admin_log`
  ADD PRIMARY KEY (`LogID`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vcategory`
--
ALTER TABLE `vcategory`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `vehicle_info`
--
ALTER TABLE `vehicle_info`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `vehicle_info_log`
--
ALTER TABLE `vehicle_info_log`
  ADD PRIMARY KEY (`LogID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `admin_log`
--
ALTER TABLE `admin_log`
  MODIFY `LogID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vcategory`
--
ALTER TABLE `vcategory`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vehicle_info`
--
ALTER TABLE `vehicle_info`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `vehicle_info_log`
--
ALTER TABLE `vehicle_info_log`
  MODIFY `LogID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
