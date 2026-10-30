PRACTICAL 9 - PLACEMENT DASHBOARD
ASP.NET Web Forms | C# | .NET Framework 4.8 | SQL Server LocalDB

OPEN THE PROJECT
1. Extract the ZIP file.
2. Open the P9_PlacementDashboard folder.
3. Double-click P9_PlacementDashboard.sln.
4. In Visual Studio, right-click Default.aspx and select Set as Start Page.
5. Press F5 (or click IIS Express).

DATABASE
The application creates the PlacementDB database, dbo.Students table and five
sample rows automatically on the first page request. No manual SQL execution
is normally required.

The connection strings use:
    (LocalDB)\MSSQLLocalDB

If the page shows a LocalDB connection error:
1. Close Visual Studio.
2. Open Visual Studio Installer > Modify.
3. Install the ASP.NET and web development workload and SQL Server Express
   LocalDB (under individual components, if it is not already installed).
4. Reopen the solution and press F5.

PROJECT CONTENTS
- Default.aspx: dashboard summary and GridView.
- Companies.aspx: Repeater and DataList reports.
- Database.cs: automatic database/table setup and sample data.
- Web.config: LocalDB connection strings and .NET Framework settings.
- Database_Setup.sql: optional manual database setup script.

EXPECTED SAMPLE DATA
Total students: 5
Placed students: 4
Unplaced students: 1
Placement percentage: 80.00%
Highest package: 7.25 LPA

NOTES
- Target framework: .NET Framework 4.8.
- This is an ASP.NET Web Forms project, not ASP.NET Core.
- Sample records are inserted only if dbo.Students is empty.
- If you already have a PlacementDB database, the application keeps its data.
