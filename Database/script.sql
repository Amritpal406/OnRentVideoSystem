USE [master]
GO
/****** Object:  Database [VideoRentalDB]    Script Date: 01-Aug-21 9:33:53 AM ******/
CREATE DATABASE [VideoRentalDB] ON  PRIMARY 
( NAME = N'VideoAssignTask', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\VideoAssignTask.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'VideoAssignTask_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\VideoAssignTask_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [VideoRentalDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoRentalDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoRentalDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoRentalDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoRentalDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoRentalDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoRentalDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoRentalDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VideoRentalDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoRentalDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoRentalDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoRentalDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoRentalDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoRentalDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoRentalDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoRentalDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoRentalDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VideoRentalDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoRentalDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoRentalDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoRentalDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoRentalDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoRentalDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoRentalDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoRentalDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VideoRentalDB] SET  MULTI_USER 
GO
ALTER DATABASE [VideoRentalDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoRentalDB] SET DB_CHAINING OFF 
GO
USE [VideoRentalDB]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_ID] [int] NOT NULL,
	[Video_ID] [int] NOT NULL,
	[Start] [varchar](50) NULL,
	[Due] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Customer_1] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NULL,
	[Genre] [varchar](50) NULL,
	[Cost] [varchar](10) NULL,
	[Ratting] [varchar](50) NULL,
	[Copies] [int] NULL,
	[Year] [varchar](50) NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllRented]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllRented]
AS
SELECT dbo.Booking.Video_ID AS ID, dbo.Video.Title, dbo.Video.Genre, dbo.Video.Cost, dbo.Video.Copies, dbo.Video.Ratting, dbo.Video.Year
FROM   dbo.Booking INNER JOIN
             dbo.Video ON dbo.Booking.Video_ID = dbo.Video.ID
GO
/****** Object:  View [dbo].[OutRented]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OutRented]
AS
SELECT dbo.Video.ID, dbo.Video.Title, dbo.Video.Genre, dbo.Video.Cost, dbo.Video.Copies, dbo.Video.Ratting, dbo.Video.Year
FROM   dbo.Video LEFT OUTER JOIN
             dbo.Booking ON dbo.Booking.Video_ID = dbo.Video.ID
WHERE (dbo.Booking.Video_ID IS NULL)
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Customer]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Video] FOREIGN KEY([Video_ID])
REFERENCES [dbo].[Video] ([ID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Video]
GO
/****** Object:  StoredProcedure [dbo].[getBooking]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getBooking] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT b.Customer_ID as 'CID',b.Video_ID as 'VID', b.ID as 'ID',c.Name as 'Customer',v.Title as 'Video',v.Cost as 'Cost',b.Start as 'Booking Date',b.Due as 'Return Date', b.Status as 'Status'
	from Booking b,Video v,Customer c where b.Customer_ID=c.ID and b.Video_ID=v.ID;
END
GO
/****** Object:  StoredProcedure [dbo].[getCustomer]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCustomer]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ID,Name,Phone,Address from Customer;
END
GO
/****** Object:  StoredProcedure [dbo].[getVideo]    Script Date: 01-Aug-21 9:33:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getVideo] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ID,Title,Genre,Cost+' $' as 'Cost',Copies,Ratting,Year from Video;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[26] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Video"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 206
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllRented'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllRented'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Video"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 206
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OutRented'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OutRented'
GO
USE [master]
GO
ALTER DATABASE [VideoRentalDB] SET  READ_WRITE 
GO
