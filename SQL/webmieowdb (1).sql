-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: mysql:3306
-- Thời gian đã tạo: Th7 29, 2025 lúc 02:11 PM
-- Phiên bản máy phục vụ: 8.0.43
-- Phiên bản PHP: 8.2.27

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
-- Cấu trúc bảng cho bảng `Accounts`
--

CREATE TABLE `Accounts` (
  `Id` int NOT NULL,
  `Username` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Phone` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FullName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Accounts`
--

INSERT INTO `Accounts` (`Id`, `Username`, `Password`, `Email`, `Phone`, `FullName`, `Address`) VALUES
(2, 'admin', '123', 'tieubaoboi532000@gmail.com', '0888941220', 'Nguyễn Lâm Hùng', 'N/A');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Cards`
--

CREATE TABLE `Cards` (
  `Id` int NOT NULL,
  `Code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ServiceType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Amount` int NOT NULL,
  `IsUsed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Cards`
--

INSERT INTO `Cards` (`Id`, `Code`, `ServiceType`, `Amount`, `IsUsed`) VALUES
(1, 'STEAM100_1', 'Steam', 100000, 0),
(2, 'STEAM100_2', 'Steam', 100000, 0),
(3, 'STEAM200_1', 'Steam', 200000, 0),
(4, 'STEAM200_2', 'Steam', 200000, 0),
(5, 'STEAM500_1', 'Steam', 500000, 0),
(6, 'STEAM500_2', 'Steam', 500000, 0),
(7, 'NETFLIX150_1', 'Netflix', 150000, 0),
(8, 'NETFLIX150_2', 'Netflix', 150000, 0),
(9, 'NETFLIX300_1', 'Netflix', 300000, 0),
(10, 'NETFLIX300_2', 'Netflix', 300000, 0),
(11, 'ZING050_1', 'Zing', 50000, 0),
(12, 'ZING050_2', 'Zing', 50000, 0),
(13, 'ZING100_1', 'Zing', 100000, 0),
(14, 'ZING100_2', 'Zing', 100000, 0),
(15, 'GARENA020_1', 'Garena', 20000, 0),
(16, 'GARENA020_2', 'Garena', 20000, 0),
(17, 'GARENA050_1', 'Garena', 50000, 0),
(18, 'GARENA050_2', 'Garena', 50000, 0),
(19, 'GARENA100_1', 'Garena', 100000, 0),
(20, 'GARENA100_2', 'Garena', 100000, 0),
(21, 'GOOGLEPLAY100_1', 'Google Play', 100000, 0),
(22, 'GOOGLEPLAY100_2', 'Google Play', 100000, 0),
(23, 'GOOGLEPLAY200_1', 'Google Play', 200000, 0),
(24, 'GOOGLEPLAY200_2', 'Google Play', 200000, 0),
(25, 'SPOTIFY059_1', 'Spotify', 59000, 0),
(26, 'SPOTIFY059_2', 'Spotify', 59000, 0),
(27, 'SPOTIFY129_1', 'Spotify', 129000, 0),
(28, 'SPOTIFY129_2', 'Spotify', 129000, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `CardStock`
--

CREATE TABLE `CardStock` (
  `Id` int NOT NULL,
  `Type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Amount` int NOT NULL,
  `Code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IsUsed` tinyint(1) NOT NULL,
  `OrderCode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Orders`
--

CREATE TABLE `Orders` (
  `OrderId` int NOT NULL,
  `AccountId` int NOT NULL,
  `Username` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Contact` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `OrderCode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `Status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Card` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Phone` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Plan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ServiceType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `Orders`
--

INSERT INTO `Orders` (`OrderId`, `AccountId`, `Username`, `Contact`, `OrderCode`, `CreatedAt`, `Status`, `Card`, `Email`, `Phone`, `Plan`, `ServiceType`, `Price`) VALUES
(1, 2, 'admin', 'tieubaoboi532000@gmail.com', '98A1BD', '2025-07-29 13:44:16.746080', 'success', 'ST001-GHJKAOW-KLAI', 'tieubaoboi532000@gmail.com', '', 'Vcoin - 500000đ', 'Vcoin', 500000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `__EFMigrationsHistory`
--

CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `__EFMigrationsHistory`
--

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`) VALUES
('20250729133456_InitialCreate', '8.0.13');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `Accounts`
--
ALTER TABLE `Accounts`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `Cards`
--
ALTER TABLE `Cards`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `CardStock`
--
ALTER TABLE `CardStock`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`OrderId`),
  ADD KEY `IX_Orders_AccountId` (`AccountId`);

--
-- Chỉ mục cho bảng `__EFMigrationsHistory`
--
ALTER TABLE `__EFMigrationsHistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `Accounts`
--
ALTER TABLE `Accounts`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `Cards`
--
ALTER TABLE `Cards`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `CardStock`
--
ALTER TABLE `CardStock`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `Orders`
--
ALTER TABLE `Orders`
  MODIFY `OrderId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ràng buộc đối với các bảng kết xuất
--

--
-- Ràng buộc cho bảng `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `FK_Orders_Accounts_AccountId` FOREIGN KEY (`AccountId`) REFERENCES `Accounts` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
