using System;
using System.Configuration;
using System.Data.SqlClient;

namespace P9_PlacementDashboard
{
    /// <summary>
    /// Creates PlacementDB and the Students table on the first page request.
    /// Sample rows are inserted only when the table is empty.
    /// </summary>
    public static class Database
    {
        private static readonly object InitLock = new object();
        private static bool _initialized;

        public static void EnsureInitialized()
        {
            if (_initialized)
                return;

            lock (InitLock)
            {
                if (_initialized)
                    return;

                string masterConnectionString =
                    ConfigurationManager.ConnectionStrings["PlacementDBMaster"].ConnectionString;

                // Create the database if it does not already exist.
                using (SqlConnection masterConnection = new SqlConnection(masterConnectionString))
                {
                    masterConnection.Open();
                    const string createDatabaseSql = @"
IF DB_ID(N'PlacementDB') IS NULL
BEGIN
    CREATE DATABASE [PlacementDB];
END";
                    using (SqlCommand command = new SqlCommand(createDatabaseSql, masterConnection))
                    {
                        command.ExecuteNonQuery();
                    }
                }

                // Create the required table. IsPlaced is included because the dashboard
                // calculates placed and unplaced student counts.
                using (SqlConnection connection = GetConnection())
                {
                    connection.Open();
                    const string setupSql = @"
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

IF COL_LENGTH(N'dbo.Students', N'IsPlaced') IS NULL
BEGIN
    ALTER TABLE dbo.Students
    ADD IsPlaced BIT NOT NULL CONSTRAINT DF_Students_IsPlaced_Added DEFAULT (0);
END;

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
END;";
                    using (SqlCommand command = new SqlCommand(setupSql, connection))
                    {
                        command.ExecuteNonQuery();
                    }
                }

                _initialized = true;
            }
        }

        public static SqlConnection GetConnection()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["PlacementDBConnection"].ConnectionString;
            return new SqlConnection(connectionString);
        }
    }
}
