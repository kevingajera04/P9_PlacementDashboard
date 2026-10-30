/* Optional manual setup script. The application also creates the database,
   Students table and sample rows automatically on first run. */
IF DB_ID(N'PlacementDB') IS NULL
    CREATE DATABASE [PlacementDB];
GO

USE [PlacementDB];
GO

IF OBJECT_ID(N'dbo.Students', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Students
    (
        PlacementId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        StudentId NVARCHAR(20) NOT NULL,
        CompanyName NVARCHAR(100) NULL,
        JobRole NVARCHAR(100) NULL,
        PackageLPA DECIMAL(10,2) NULL,
        IsPlaced BIT NOT NULL CONSTRAINT DF_Students_IsPlaced DEFAULT (0)
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Students)
BEGIN
    INSERT INTO dbo.Students
        (StudentId, CompanyName, JobRole, PackageLPA, IsPlaced)
    VALUES
        (N'STU001', N'TCS', N'Software Engineer', 5.50, 1),
        (N'STU002', N'Infosys', N'System Engineer', 4.50, 1),
        (N'STU003', N'Wipro', N'Project Engineer', 6.00, 1),
        (N'STU004', NULL, NULL, NULL, 0),
        (N'STU005', N'Google', N'Data Analyst', 7.25, 1);
END;
GO
