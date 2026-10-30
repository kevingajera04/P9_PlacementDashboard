using System;
using System.Data;
using System.Data.SqlClient;

namespace P9_PlacementDashboard
{
    public partial class Companies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Database.EnsureInitialized();
                    LoadCompanies();
                    LoadCompanySummary();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Database connection/setup failed: " +
                        Server.HtmlEncode(ex.Message) +
                        " Check that SQL Server LocalDB is installed and available.";
                }
            }
        }

        private void LoadCompanies()
        {
            const string query = @"
SELECT PlacementId, StudentId, CompanyName, JobRole, PackageLPA
FROM dbo.Students
WHERE IsPlaced = 1
ORDER BY CompanyName, StudentId;";

            using (SqlConnection connection = Database.GetConnection())
            using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
            {
                DataTable table = new DataTable();
                adapter.Fill(table);
                rptCompanies.DataSource = table;
                rptCompanies.DataBind();
                lblNoPlacements.Visible = table.Rows.Count == 0;
            }
        }

        private void LoadCompanySummary()
        {
            const string query = @"
SELECT CompanyName,
       COUNT(*) AS TotalHires,
       MAX(PackageLPA) AS HighestPackage,
       AVG(CAST(PackageLPA AS DECIMAL(10,2))) AS AveragePackage
FROM dbo.Students
WHERE IsPlaced = 1 AND CompanyName IS NOT NULL
GROUP BY CompanyName
ORDER BY CompanyName;";

            using (SqlConnection connection = Database.GetConnection())
            using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
            {
                DataTable table = new DataTable();
                adapter.Fill(table);
                dlPlacements.DataSource = table;
                dlPlacements.DataBind();
                lblNoCompanies.Visible = table.Rows.Count == 0;
            }
        }
    }
}
