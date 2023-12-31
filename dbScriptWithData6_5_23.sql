USE [master]
GO
/****** Object:  Database [GroupStudySU23]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE DATABASE [GroupStudySU23]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GroupStudySU23', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\GroupStudySU23.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GroupStudySU23_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\GroupStudySU23_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [GroupStudySU23] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GroupStudySU23].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GroupStudySU23] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GroupStudySU23] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GroupStudySU23] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GroupStudySU23] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GroupStudySU23] SET ARITHABORT OFF 
GO
ALTER DATABASE [GroupStudySU23] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GroupStudySU23] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GroupStudySU23] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GroupStudySU23] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GroupStudySU23] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GroupStudySU23] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GroupStudySU23] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GroupStudySU23] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GroupStudySU23] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GroupStudySU23] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GroupStudySU23] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GroupStudySU23] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GroupStudySU23] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GroupStudySU23] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GroupStudySU23] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GroupStudySU23] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [GroupStudySU23] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GroupStudySU23] SET RECOVERY FULL 
GO
ALTER DATABASE [GroupStudySU23] SET  MULTI_USER 
GO
ALTER DATABASE [GroupStudySU23] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GroupStudySU23] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GroupStudySU23] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GroupStudySU23] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GroupStudySU23] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GroupStudySU23] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GroupStudySU23', N'ON'
GO
ALTER DATABASE [GroupStudySU23] SET QUERY_STORE = OFF
GO
USE [GroupStudySU23]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = OFF;
GO
USE [GroupStudySU23]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](450) NOT NULL,
	[Email] [nvarchar](450) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FullName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Connections]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Connections](
	[Id] [nvarchar](450) NOT NULL,
	[MeetingId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Connections] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupMembers]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[State] [int] NOT NULL,
	[InviteMessage] [nvarchar](max) NULL,
	[RequestMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_GroupMembers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[ClassId] [int] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupSubjects]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupSubjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
 CONSTRAINT [PK_GroupSubjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meetings]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meetings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Start] [datetime2](7) NULL,
	[End] [datetime2](7) NULL,
	[ScheduleStart] [datetime2](7) NULL,
	[ScheduleEnd] [datetime2](7) NULL,
	[GroupId] [int] NOT NULL,
	[CountMember] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Meetings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 6/5/2023 10:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230525161544_Init', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230530060720_AddTables', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230530131539_AddClassAndSubject', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230530131802_AddUsernameAndEmailUniqueConstraint', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230530153213_AddGroupMemberState', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230601095640_ChangeTblGroupMember', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230601111754_SeedGroup', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230601113159_SeedMoreGroup', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230602032430_FixGroupMemberSeeding', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230602093506_RemoveMeetingRoom', N'6.0.16')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230605153013_ChangeMeetingDateNullable', N'6.0.16')
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (1, N'student1', N'trankhaiminhkhoi10a3@gmail.com', N'123456789', N'0123456789', 2, N'Nguyen Van A')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (2, N'student2', N'student2@gmail.com', N'123456789', N'0123456789', 2, N'Nguyen Van B')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (3, N'student3', N'student3@gmail.com', N'123456789', N'0123456789', 2, N'Tran Van C')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (4, N'student4', N'student4@gmail.com', N'123456789', N'0123456789', 2, N'Li Thi D')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (5, N'student5', N'student5@gmail.com', N'123456789', N'0123456789', 2, N'Tran Van E')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (6, N'student6', N'student6@gmail.com', N'123456789', N'0123456789', 2, N'Li Chinh F')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (7, N'student7', N'student7@gmail.com', N'123456789', N'0123456789', 2, N'Ngo Van G')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (8, N'student8', N'student8@gmail.com', N'123456789', N'0123456789', 2, N'Tran Van H')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (9, N'student9', N'student9@gmail.com', N'123456789', N'0123456789', 2, N'Tran Van I')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (10, N'student10', N'student10@gmail.com', N'123456789', N'0123456789', 2, N'Tran Van J')
INSERT [dbo].[Accounts] ([Id], [Username], [Email], [Password], [Phone], [RoleId], [FullName]) VALUES (11, N'parent1', N'trankhaiminhkhoi@gmail.com', N'123456789', N'0123456789', 1, N'Tran Khoi')
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([Id], [Name]) VALUES (6, 6)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (7, 7)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (8, 8)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (9, 9)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (10, 10)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (11, 11)
INSERT [dbo].[Classes] ([Id], [Name]) VALUES (12, 12)
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupMembers] ON 

INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (1, 1, 1, 0, NULL, NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (2, 1, 2, 1, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (3, 1, 3, 2, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (4, 1, 4, 3, NULL, N'Nhóm của bạn rất hay. Bạn cho mình vô nha')
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (5, 1, 5, 4, NULL, N'Nhóm của bạn rất hay. Bạn cho mình vô nha')
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (6, 2, 1, 0, NULL, NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (7, 2, 2, 1, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (8, 2, 3, 2, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (9, 2, 4, 3, NULL, N'Nhóm của bạn rất hay. Bạn cho mình vô nha')
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (10, 3, 2, 0, NULL, NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (11, 3, 1, 1, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (12, 3, 3, 2, N'Nhóm của mình rất hay. Bạn vô nha', NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (13, 3, 4, 3, NULL, N'Nhóm của bạn rất hay. Bạn cho mình vô nha')
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (14, 4, 1, 0, NULL, NULL)
INSERT [dbo].[GroupMembers] ([Id], [GroupId], [AccountId], [State], [InviteMessage], [RequestMessage]) VALUES (1001, 5, 1, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[GroupMembers] OFF
GO
SET IDENTITY_INSERT [dbo].[Groups] ON 

INSERT [dbo].[Groups] ([Id], [Name], [ClassId]) VALUES (1, N'Nhóm 1 của học sinh 1', 7)
INSERT [dbo].[Groups] ([Id], [Name], [ClassId]) VALUES (2, N'Nhóm 2 của học sinh 1', 7)
INSERT [dbo].[Groups] ([Id], [Name], [ClassId]) VALUES (3, N'Nhóm 1 của học sinh 2', 8)
INSERT [dbo].[Groups] ([Id], [Name], [ClassId]) VALUES (4, N'nhóm 3 của học sinh 1', 6)
INSERT [dbo].[Groups] ([Id], [Name], [ClassId]) VALUES (5, N'nhóm 4 tên siêu mới của học sinh 1', 10)
SET IDENTITY_INSERT [dbo].[Groups] OFF
GO
SET IDENTITY_INSERT [dbo].[GroupSubjects] ON 

INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (1, 1, 1)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (2, 1, 4)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (3, 1, 8)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (4, 2, 1)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (5, 2, 2)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (6, 2, 3)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (7, 3, 5)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (8, 3, 6)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (9, 3, 9)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (10, 4, 1)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (1021, 5, 1)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (1022, 5, 2)
INSERT [dbo].[GroupSubjects] ([Id], [GroupId], [SubjectId]) VALUES (1023, 5, 3)
SET IDENTITY_INSERT [dbo].[GroupSubjects] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name]) VALUES (1, N'Parent')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (2, N'Student')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (1, N'Toán')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (2, N'Lí')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (3, N'Hóa')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (4, N'Văn')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (5, N'Sử')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (6, N'Địa')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (7, N'Sinh')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (8, N'Anh')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (9, N'Giáo dục công dân')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (10, N'Công nghệ')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (11, N'Quốc phòng')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (12, N'Thể dục')
INSERT [dbo].[Subjects] ([Id], [Name]) VALUES (13, N'Tin')
SET IDENTITY_INSERT [dbo].[Subjects] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Accounts_Email]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Accounts_Email] ON [dbo].[Accounts]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Accounts_RoleId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_Accounts_RoleId] ON [dbo].[Accounts]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Accounts_Username]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Accounts_Username] ON [dbo].[Accounts]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Connections_AccountId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_Connections_AccountId] ON [dbo].[Connections]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Connections_MeetingId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_Connections_MeetingId] ON [dbo].[Connections]
(
	[MeetingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GroupMembers_AccountId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_GroupMembers_AccountId] ON [dbo].[GroupMembers]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GroupMembers_GroupId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_GroupMembers_GroupId] ON [dbo].[GroupMembers]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Groups_ClassId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_Groups_ClassId] ON [dbo].[Groups]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GroupSubjects_GroupId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_GroupSubjects_GroupId] ON [dbo].[GroupSubjects]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GroupSubjects_SubjectId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_GroupSubjects_SubjectId] ON [dbo].[GroupSubjects]
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Meetings_GroupId]    Script Date: 6/5/2023 10:34:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_Meetings_GroupId] ON [dbo].[Meetings]
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Accounts] ADD  DEFAULT (N'') FOR [FullName]
GO
ALTER TABLE [dbo].[Connections] ADD  DEFAULT (N'') FOR [UserName]
GO
ALTER TABLE [dbo].[GroupMembers] ADD  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Groups] ADD  DEFAULT ((0)) FOR [ClassId]
GO
ALTER TABLE [dbo].[GroupSubjects] ADD  DEFAULT ((0)) FOR [SubjectId]
GO
ALTER TABLE [dbo].[Meetings] ADD  DEFAULT ((0)) FOR [CountMember]
GO
ALTER TABLE [dbo].[Meetings] ADD  DEFAULT (N'') FOR [Name]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Roles_RoleId]
GO
ALTER TABLE [dbo].[Connections]  WITH CHECK ADD  CONSTRAINT [FK_Connections_Accounts_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Connections] CHECK CONSTRAINT [FK_Connections_Accounts_AccountId]
GO
ALTER TABLE [dbo].[Connections]  WITH CHECK ADD  CONSTRAINT [FK_Connections_Meetings_MeetingId] FOREIGN KEY([MeetingId])
REFERENCES [dbo].[Meetings] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Connections] CHECK CONSTRAINT [FK_Connections_Meetings_MeetingId]
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD  CONSTRAINT [FK_GroupMembers_Accounts_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupMembers] CHECK CONSTRAINT [FK_GroupMembers_Accounts_AccountId]
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD  CONSTRAINT [FK_GroupMembers_Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupMembers] CHECK CONSTRAINT [FK_GroupMembers_Groups_GroupId]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Classes_ClassId]
GO
ALTER TABLE [dbo].[GroupSubjects]  WITH CHECK ADD  CONSTRAINT [FK_GroupSubjects_Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupSubjects] CHECK CONSTRAINT [FK_GroupSubjects_Groups_GroupId]
GO
ALTER TABLE [dbo].[GroupSubjects]  WITH CHECK ADD  CONSTRAINT [FK_GroupSubjects_Subjects_SubjectId] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subjects] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GroupSubjects] CHECK CONSTRAINT [FK_GroupSubjects_Subjects_SubjectId]
GO
ALTER TABLE [dbo].[Meetings]  WITH CHECK ADD  CONSTRAINT [FK_Meetings_Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Meetings] CHECK CONSTRAINT [FK_Meetings_Groups_GroupId]
GO
USE [master]
GO
ALTER DATABASE [GroupStudySU23] SET  READ_WRITE 
GO
