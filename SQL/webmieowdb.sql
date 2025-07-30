-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 29, 2025 lúc 05:52 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webmieowdb`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accounts`
--

CREATE TABLE `accounts` (
  `Id` int(11) NOT NULL,
  `Username` longtext NOT NULL,
  `Password` longtext NOT NULL,
  `Email` longtext NOT NULL,
  `Phone` longtext NOT NULL,
  `FullName` longtext NOT NULL,
  `Address` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `accounts`
--

INSERT INTO `accounts` (`Id`, `Username`, `Password`, `Email`, `Phone`, `FullName`, `Address`) VALUES
(5, 'admin', '123', 'tieubaoboi532000@gmail.com', '0888941220', 'Nguyễn Lâm Đù', 'N/A');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cards`
--

CREATE TABLE `cards` (
  `Id` int(11) NOT NULL,
  `Code` longtext NOT NULL,
  `IsUsed` tinyint(4) NOT NULL,
  `ServiceType` longtext NOT NULL,
  `Amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cards`
--

INSERT INTO `cards` (`Id`, `Code`, `IsUsed`, `ServiceType`, `Amount`) VALUES
(1, 'STEAM100_1', 0, 'Steam', 100000),
(2, 'STEAM100_2', 0, 'Steam', 100000),
(3, 'STEAM200_1', 0, 'Steam', 200000),
(4, 'STEAM200_2', 0, 'Steam', 200000),
(5, 'STEAM500_1', 0, 'Steam', 500000),
(6, 'STEAM500_2', 0, 'Steam', 500000),
(7, 'NETFLIX150_1', 0, 'Netflix', 150000),
(8, 'NETFLIX150_2', 0, 'Netflix', 150000),
(9, 'NETFLIX300_1', 0, 'Netflix', 300000),
(10, 'NETFLIX300_2', 0, 'Netflix', 300000),
(11, 'ZING050_1', 0, 'Zing', 50000),
(12, 'ZING050_2', 0, 'Zing', 50000),
(13, 'ZING100_1', 0, 'Zing', 100000),
(14, 'ZING100_2', 0, 'Zing', 100000),
(15, 'GARENA020_1', 0, 'Garena', 20000),
(16, 'GARENA020_2', 0, 'Garena', 20000),
(17, 'GARENA050_1', 0, 'Garena', 50000),
(18, 'GARENA050_2', 0, 'Garena', 50000),
(19, 'GARENA100_1', 0, 'Garena', 100000),
(20, 'GARENA100_2', 0, 'Garena', 100000),
(21, 'GOOGLEPLAY100_1', 0, 'Google Play', 100000),
(22, 'GOOGLEPLAY100_2', 0, 'Google Play', 100000),
(23, 'GOOGLEPLAY200_1', 0, 'Google Play', 200000),
(24, 'GOOGLEPLAY200_2', 0, 'Google Play', 200000),
(25, 'SPOTIFY059_1', 0, 'Spotify', 59000),
(26, 'SPOTIFY059_2', 0, 'Spotify', 59000),
(27, 'SPOTIFY129_1', 0, 'Spotify', 129000),
(28, 'SPOTIFY129_2', 0, 'Spotify', 129000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cardstock`
--

CREATE TABLE `cardstock` (
  `Id` int(11) NOT NULL,
  `Type` longtext NOT NULL,
  `Amount` int(11) NOT NULL,
  `Code` longtext NOT NULL,
  `IsUsed` tinyint(4) NOT NULL,
  `OrderCode` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `OrderId` int(11) NOT NULL,
  `AccountId` int(11) NOT NULL,
  `Username` longtext NOT NULL,
  `Contact` longtext NOT NULL,
  `OrderCode` longtext NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `Status` longtext NOT NULL,
  `Card` longtext DEFAULT NULL,
  `Email` longtext NOT NULL,
  `Phone` longtext NOT NULL,
  `Plan` longtext NOT NULL,
  `ServiceType` longtext NOT NULL,
  `Price` int(11) NOT NULL,
  `AccountId1` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`OrderId`, `AccountId`, `Username`, `Contact`, `OrderCode`, `CreatedAt`, `Status`, `Card`, `Email`, `Phone`, `Plan`, `ServiceType`, `Price`, `AccountId1`) VALUES
(29, 5, 'admin', 'tieubaoboi532000@gmail.com', '332A71', '2025-07-25 22:48:02.337867', 'success', 'GMZing71901KKLA', 'tieubaoboi532000@gmail.com', '', 'Zing - 500000đ', 'Zing', 500000, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `__efmigrationshistory`
--

CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `__efmigrationshistory`
--

INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
('20250725161421_InitialCreate', '8.0.7'),
('20250725194938_UpdateOrderCardNullable', '8.0.7'),
('20250725200023_InitSchema', '8.0.7'),
('20250725202426_Initial', '8.0.7');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `cardstock`
--
ALTER TABLE `cardstock`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderId`),
  ADD KEY `FK_Orders_Accounts_AccountId` (`AccountId`);

--
-- Chỉ mục cho bảng `__efmigrationshistory`
--
ALTER TABLE `__efmigrationshistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accounts`
--
ALTER TABLE `accounts`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `cards`
--
ALTER TABLE `cards`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `cardstock`
--
ALTER TABLE `cardstock`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_Orders_Accounts_AccountId` FOREIGN KEY (`AccountId`) REFERENCES `accounts` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
