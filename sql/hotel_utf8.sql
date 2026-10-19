USE [master]
GO
/****** Object:  Database [HotelBookingDB]    Script Date: 10/17/2026 4:17:08 PM ******/
CREATE DATABASE [HotelBookingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelBookingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HotelBookingDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HotelBookingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HotelBookingDB_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HotelBookingDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelBookingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelBookingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelBookingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelBookingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelBookingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelBookingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelBookingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HotelBookingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelBookingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelBookingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelBookingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelBookingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelBookingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelBookingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelBookingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelBookingDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HotelBookingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelBookingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelBookingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelBookingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelBookingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelBookingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelBookingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelBookingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HotelBookingDB] SET  MULTI_USER 
GO
ALTER DATABASE [HotelBookingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelBookingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelBookingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelBookingDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelBookingDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelBookingDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HotelBookingDB', N'ON'
GO
ALTER DATABASE [HotelBookingDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [HotelBookingDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HotelBookingDB]
GO
/****** Object:  Schema [dimensions]    Script Date: 10/17/2026 4:17:08 PM ******/
CREATE SCHEMA [dimensions]
GO
/****** Object:  Schema [facts]    Script Date: 10/17/2026 4:17:08 PM ******/
CREATE SCHEMA [facts]
GO
/****** Object:  Schema [raw]    Script Date: 10/17/2026 4:17:08 PM ******/
CREATE SCHEMA [raw]
GO
/****** Object:  Table [dimensions].[agent]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[agent](
	[agent_key] [int] IDENTITY(1,1) NOT NULL,
	[agent_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[agent_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[agent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[country]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[country](
	[country_key] [int] IDENTITY(1,1) NOT NULL,
	[country_code] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[country_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[customer_type]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[customer_type](
	[customer_type_key] [int] IDENTITY(1,1) NOT NULL,
	[customer_type_name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_type_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[customer_type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[date]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[date](
	[date_key] [int] NOT NULL,
	[full_date] [date] NOT NULL,
	[year] [smallint] NOT NULL,
	[month_number] [tinyint] NOT NULL,
	[month_name] [varchar](20) NOT NULL,
	[week_number] [tinyint] NULL,
	[day_of_month] [tinyint] NOT NULL,
	[day_name] [varchar](20) NOT NULL,
	[quarter_number] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[full_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[deposit_type]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[deposit_type](
	[deposit_type_key] [int] IDENTITY(1,1) NOT NULL,
	[deposit_type_name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[deposit_type_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[deposit_type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[hotel]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[hotel](
	[hotel_key] [int] IDENTITY(1,1) NOT NULL,
	[hotel_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[hotel_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[hotel_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[market_segment]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[market_segment](
	[market_segment_key] [int] IDENTITY(1,1) NOT NULL,
	[market_segment_name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[market_segment_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[market_segment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[meal]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[meal](
	[meal_key] [int] IDENTITY(1,1) NOT NULL,
	[meal_code] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[meal_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[meal_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[reservation_status]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[reservation_status](
	[reservation_status_key] [int] IDENTITY(1,1) NOT NULL,
	[reservation_status_name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reservation_status_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[reservation_status_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dimensions].[room_type]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dimensions].[room_type](
	[room_type_key] [int] IDENTITY(1,1) NOT NULL,
	[room_type_code] [varchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[room_type_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[room_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [facts].[booking]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [facts].[booking](
	[booking_key] [bigint] IDENTITY(1,1) NOT NULL,
	[hotel_key] [int] NOT NULL,
	[meal_key] [int] NOT NULL,
	[country_key] [int] NOT NULL,
	[market_segment_key] [int] NOT NULL,
	[reserved_room_type_key] [int] NOT NULL,
	[assigned_room_type_key] [int] NOT NULL,
	[deposit_type_key] [int] NOT NULL,
	[agent_key] [int] NOT NULL,
	[customer_type_key] [int] NOT NULL,
	[reservation_status_key] [int] NOT NULL,
	[is_canceled] [tinyint] NOT NULL,
	[lead_time] [int] NOT NULL,
	[stays_in_weekend_nights] [tinyint] NOT NULL,
	[stays_in_week_nights] [tinyint] NOT NULL,
	[adults] [tinyint] NOT NULL,
	[children] [decimal](4, 1) NOT NULL,
	[previous_cancellations] [smallint] NOT NULL,
	[previous_bookings_not_canceled] [smallint] NOT NULL,
	[days_in_waiting_list] [int] NOT NULL,
	[adr] [decimal](10, 2) NULL,
	[arrival_date] [date] NOT NULL,
	[booking_date] [date] NOT NULL,
	[reservation_status_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [raw].[hotel_bookings_raw]    Script Date: 10/17/2026 4:17:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[hotel_bookings_raw](
	[hotel] [varchar](50) NULL,
	[is_canceled] [tinyint] NULL,
	[lead_time] [int] NULL,
	[arrival_date_year] [smallint] NULL,
	[arrival_date_month] [varchar](20) NULL,
	[arrival_date_week_number] [tinyint] NULL,
	[arrival_date_day_of_month] [tinyint] NULL,
	[stays_in_weekend_nights] [tinyint] NULL,
	[stays_in_week_nights] [tinyint] NULL,
	[adults] [tinyint] NULL,
	[children] [decimal](4, 1) NULL,
	[meal] [varchar](20) NULL,
	[country] [varchar](10) NULL,
	[market_segment] [varchar](30) NULL,
	[previous_cancellations] [smallint] NULL,
	[previous_bookings_not_canceled] [smallint] NULL,
	[reserved_room_type] [varchar](5) NULL,
	[assigned_room_type] [varchar](5) NULL,
	[deposit_type] [varchar](20) NULL,
	[agent] [int] NULL,
	[days_in_waiting_list] [int] NULL,
	[customer_type] [varchar](30) NULL,
	[adr] [decimal](10, 2) NULL,
	[reservation_status] [varchar](20) NULL,
	[reservation_status_date] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_agent] FOREIGN KEY([agent_key])
REFERENCES [dimensions].[agent] ([agent_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_agent]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_assigned_room] FOREIGN KEY([assigned_room_type_key])
REFERENCES [dimensions].[room_type] ([room_type_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_assigned_room]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_country] FOREIGN KEY([country_key])
REFERENCES [dimensions].[country] ([country_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_country]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_customer_type] FOREIGN KEY([customer_type_key])
REFERENCES [dimensions].[customer_type] ([customer_type_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_customer_type]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_deposit] FOREIGN KEY([deposit_type_key])
REFERENCES [dimensions].[deposit_type] ([deposit_type_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_deposit]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_hotel] FOREIGN KEY([hotel_key])
REFERENCES [dimensions].[hotel] ([hotel_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_hotel]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_market_segment] FOREIGN KEY([market_segment_key])
REFERENCES [dimensions].[market_segment] ([market_segment_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_market_segment]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_meal] FOREIGN KEY([meal_key])
REFERENCES [dimensions].[meal] ([meal_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_meal]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_reservation_status] FOREIGN KEY([reservation_status_key])
REFERENCES [dimensions].[reservation_status] ([reservation_status_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_reservation_status]
GO
ALTER TABLE [facts].[booking]  WITH CHECK ADD  CONSTRAINT [FK_booking_reserved_room] FOREIGN KEY([reserved_room_type_key])
REFERENCES [dimensions].[room_type] ([room_type_key])
GO
ALTER TABLE [facts].[booking] CHECK CONSTRAINT [FK_booking_reserved_room]
GO
USE [master]
GO
ALTER DATABASE [HotelBookingDB] SET  READ_WRITE 
GO
