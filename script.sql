USE [master]
GO
/****** Object:  Database [Prime]    Script Date: 7.07.2020 02:11:14 ******/
CREATE DATABASE [Prime]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Prime', FILENAME = N'C:\Users\bedir\Prime.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Prime_log', FILENAME = N'C:\Users\bedir\Prime_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Prime] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Prime].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Prime] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Prime] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Prime] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Prime] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Prime] SET ARITHABORT OFF 
GO
ALTER DATABASE [Prime] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Prime] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Prime] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Prime] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Prime] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Prime] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Prime] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Prime] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Prime] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Prime] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Prime] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Prime] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Prime] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Prime] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Prime] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Prime] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Prime] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Prime] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Prime] SET  MULTI_USER 
GO
ALTER DATABASE [Prime] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Prime] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Prime] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Prime] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Prime] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Prime] SET QUERY_STORE = OFF
GO
USE [Prime]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Prime]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 7.07.2020 02:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CarName] [nvarchar](20) NOT NULL,
	[CarModel] [nvarchar](20) NOT NULL,
	[CarModelYear] [nvarchar](40) NOT NULL,
	[CarEngineCapacity] [nvarchar](4) NOT NULL,
	[CarGearType] [nvarchar](10) NOT NULL,
	[CarFuelType] [nvarchar](20) NOT NULL,
	[CarDailyPrice] [float] NOT NULL,
	[CarRentStart] [datetime] NULL,
	[CarRentEnd] [datetime] NULL,
	[isActive] [bit] NOT NULL,
	[CarClass] [nvarchar](30) NOT NULL,
	[CarImage] [nvarchar](max) NOT NULL,
	[PersonMinAge] [nvarchar](2) NOT NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 7.07.2020 02:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](20) NOT NULL,
	[Surname] [nchar](20) NOT NULL,
	[Email] [nchar](30) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Phone] [nchar](11) NOT NULL,
	[Password] [nchar](64) NOT NULL,
	[isActive] [bit] NULL,
	[IDNo] [nvarchar](11) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[Role] [nvarchar](20) NULL,
	[DateOfRegister] [date] NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offices]    Script Date: 7.07.2020 02:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[OfficeName] [nchar](40) NOT NULL,
 CONSTRAINT [PK_Offices] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suitability]    Script Date: 7.07.2020 02:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suitability](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[CarId] [int] NOT NULL,
	[RentStartDate] [date] NOT NULL,
	[RentEndDate] [date] NOT NULL,
	[TotalPrice] [float] NOT NULL,
 CONSTRAINT [PK_Suitability] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cars] ON 

INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (1, N'FIAT', N'AEGEA', N'2020', N'1.3', N'Manuel', N'Dizel', 190, NULL, NULL, 1, N'ECONOMIC CLASS', N'/assets/img/FAegea.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (2, N'FIAT', N'LINEA', N'2020', N'1.3', N'Manuel', N'Dizel', 160, NULL, NULL, 1, N'ECONOMIC CLASS', N'/assets/img/FLinea.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (3, N'FORD', N'FOCUS', N'2020', N'1.4', N'Manuel', N'Dizel', 230.65, NULL, NULL, 1, N'COMFORT CLASS', N'/assets/img/FFocus.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (4, N'HYUNDAI', N'i20', N'2020', N'1.3', N'Otomatik', N'Dizel', 230, NULL, NULL, 1, N'COMFORT CLASS', N'/assets/img/Hi20.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (5, N'MERCEDES', N'E SERİSİ', N'2020', N'2.0', N'Otomatik', N'Benzin', 425.75, NULL, NULL, 1, N'PREMIER CLASS', N'/assets/img/MercedesE.png', N'25')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (6, N'MAZDA', N'TOUR', N'2020', N'2.0', N'Otomatik', N'Benzin', 350.4, NULL, NULL, 1, N'LUXURY CLASS', N'/assets/img/MTour2.png', N'23')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (8, N'NISSAN', N'QASHQAI', N'2020', N'2.0', N'Manuel', N'Dizel', 350.5, NULL, NULL, 1, N'LUXURY CLASS', N'/assets/img/NQuashai.png', N'23')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (9, N'PEUGEOUT', N'5008', N'2020', N'2.0', N'Otomatik', N'Dizel', 350, NULL, NULL, 1, N'LUXURY CLASS', N'/assets/img/P5008.png', N'23')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (10, N'RENAULT', N'CLIO', N'2020', N'1.2', N'Otomatik', N'Dizel', 170, NULL, NULL, 1, N'ECONOMIC CLASS', N'/assets/img/RClio.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (11, N'WW', N'GOLF', N'2020', N'1.4', N'Manuel', N'Dizel', 225.65, NULL, NULL, 1, N'COMFORT CLASS', N'/assets/img/WGolf.png', N'21')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (12, N'WW', N'PASSAT', N'2020', N'1.6', N'Otomatik', N'Dizel', 350.25, NULL, NULL, 1, N'LUXURY CLASS', N'/assets/img/WPassat.png', N'25')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (13, N'FORD', N'CUSTOM', N'2020', N'2.0', N'Manuel', N'Dizel', 425.65, NULL, NULL, 1, N'LUXURY CLASS', N'/assets/img/FCustom.png', N'25')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (14, N'SKODA', N'KODIAQ', N'2020', N'2.0', N'Otomatik', N'Benzin', 375, NULL, NULL, 1, N'LUXURY CLASS', N'/Areas/Admin/CarImages/Skoda.png', N'23')
INSERT [dbo].[Cars] ([id], [CarName], [CarModel], [CarModelYear], [CarEngineCapacity], [CarGearType], [CarFuelType], [CarDailyPrice], [CarRentStart], [CarRentEnd], [isActive], [CarClass], [CarImage], [PersonMinAge]) VALUES (15, N'MERCEDES', N'C SERİSİ', N'2020', N'2.2', N'Otomatik', N'Benzin', 465.45, NULL, NULL, 1, N'PREMIER CLASS', N'/Areas/Admin/CarImages/MCSeries.png', N'25')
SET IDENTITY_INSERT [dbo].[Cars] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([id], [Name], [Surname], [Email], [DateOfBirth], [Phone], [Password], [isActive], [IDNo], [ImageUrl], [Role], [DateOfRegister]) VALUES (1, N'Bedirhan            ', N'KAPLAN              ', N'bedirhan@prime.com            ', CAST(N'1995-09-21' AS Date), N'05555555555', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, N'12345678901', N'/Areas/Admin/Images/fd.png', N'Admin', NULL)
INSERT [dbo].[Members] ([id], [Name], [Surname], [Email], [DateOfBirth], [Phone], [Password], [isActive], [IDNo], [ImageUrl], [Role], [DateOfRegister]) VALUES (1005, N'Eymen               ', N'KAPLAN              ', N'eymen@customer.com            ', CAST(N'1985-11-11' AS Date), N'05555555555', N'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, N'12121212121', NULL, N'Member', NULL)
INSERT [dbo].[Members] ([id], [Name], [Surname], [Email], [DateOfBirth], [Phone], [Password], [isActive], [IDNo], [ImageUrl], [Role], [DateOfRegister]) VALUES (1007, N'Yasin               ', N'KAPLAN              ', N'yasin@customer.com            ', CAST(N'2001-01-23' AS Date), N'05555555555', N'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, N'12121212121', NULL, N'Member', CAST(N'2020-06-19' AS Date))
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
SET IDENTITY_INSERT [dbo].[Offices] ON 

INSERT [dbo].[Offices] ([id], [OfficeName]) VALUES (1, N'İstanbul Yeni Havalimanı                ')
INSERT [dbo].[Offices] ([id], [OfficeName]) VALUES (2, N'İstanbul Sabiha Gökçen Havalimanı       ')
INSERT [dbo].[Offices] ([id], [OfficeName]) VALUES (3, N'Levent Ofisi                            ')
INSERT [dbo].[Offices] ([id], [OfficeName]) VALUES (4, N'Taksim Ofisi                            ')
INSERT [dbo].[Offices] ([id], [OfficeName]) VALUES (5, N'Kadıköy Ofisi                           ')
SET IDENTITY_INSERT [dbo].[Offices] OFF
GO
SET IDENTITY_INSERT [dbo].[Suitability] ON 

INSERT [dbo].[Suitability] ([id], [MemberID], [CarId], [RentStartDate], [RentEndDate], [TotalPrice]) VALUES (1, 1007, 1, CAST(N'2020-06-23' AS Date), CAST(N'2020-06-27' AS Date), 681.4)
INSERT [dbo].[Suitability] ([id], [MemberID], [CarId], [RentStartDate], [RentEndDate], [TotalPrice]) VALUES (2, 1007, 5, CAST(N'2020-06-22' AS Date), CAST(N'2020-06-27' AS Date), 2128.75)
INSERT [dbo].[Suitability] ([id], [MemberID], [CarId], [RentStartDate], [RentEndDate], [TotalPrice]) VALUES (1002, 1007, 1, CAST(N'2020-06-23' AS Date), CAST(N'2020-06-26' AS Date), 511.04999999999995)
INSERT [dbo].[Suitability] ([id], [MemberID], [CarId], [RentStartDate], [RentEndDate], [TotalPrice]) VALUES (1003, 1007, 2, CAST(N'2020-06-23' AS Date), CAST(N'2020-06-27' AS Date), 640)
INSERT [dbo].[Suitability] ([id], [MemberID], [CarId], [RentStartDate], [RentEndDate], [TotalPrice]) VALUES (2002, 1005, 15, CAST(N'2020-07-15' AS Date), CAST(N'2020-07-23' AS Date), 3723.6)
SET IDENTITY_INSERT [dbo].[Suitability] OFF
GO
ALTER TABLE [dbo].[Suitability]  WITH CHECK ADD  CONSTRAINT [FK_Suitability_Cars] FOREIGN KEY([CarId])
REFERENCES [dbo].[Cars] ([id])
GO
ALTER TABLE [dbo].[Suitability] CHECK CONSTRAINT [FK_Suitability_Cars]
GO
ALTER TABLE [dbo].[Suitability]  WITH CHECK ADD  CONSTRAINT [FK_Suitability_Suitability] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([id])
GO
ALTER TABLE [dbo].[Suitability] CHECK CONSTRAINT [FK_Suitability_Suitability]
GO
USE [master]
GO
ALTER DATABASE [Prime] SET  READ_WRITE 
GO
