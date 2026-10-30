using System;
using System.Data;
using System.Data.SqlClient;

namespace P9_PlacementDashboard
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Database.EnsureInitialized();
                    LoadSummary();
                    LoadPlacements();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Database connection/setup failed: " +
                        Server.HtmlEncode(ex.Message) +
                        " Check that SQL Server LocalDB is installed and available.";
                }
            }
        }

        private void LoadSummary()
        {
            const string query = @"
SELECT
    COUNT(*) AS TotalStudents,
    COALESCE(SUM(CASE WHEN IsPlaced = 1 THEN 1 ELSE 0 END), 0) AS PlacedStudents,
    COALESCE(SUM(CASE WHEN IsPlaced = 0 THEN 1 ELSE 0 END), 0) AS UnplacedStudents,
    COALESCE(MAX(CASE WHEN IsPlaced = 1 THEN PackageLPA END), 0) AS HighestPackage
FROM dbo.Students;";

            using (SqlConnection connection = Database.GetConnection())
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int total = Convert.ToInt32(reader["TotalStudents"]);
                        int placed = Convert.ToInt32(reader["PlacedStudents"]);
                        int unplaced = Convert.ToInt32(reader["UnplacedStudents"]);
                        decimal highest = Convert.ToDecimal(reader["HighestPackage"]);
                        decimal percentage = total == 0 ? 0 : (decimal)placed * 100m / total;

                        lblTotal.Text = total.ToString();
                        lblPlaced.Text = placed.ToString();
                        lblUnplaced.Text = unplaced.ToString();
                        lblPercentage.Text = percentage.ToString("N2") + "%";
                        lblHighestPackage.Text = highest.ToString("N2") + " LPA";
                    }
                }
            }
        }

        private void LoadPlacements()
        {
            const string query = @"
SELECT PlacementId, StudentId,
       COALESCE(CompanyName, '—') AS CompanyName,
       COALESCE(JobRole, '—') AS JobRole,
       PackageLPA, IsPlaced
FROM dbo.Students
ORDER BY PlacementId;";

            using (SqlConnection connection = Database.GetConnection())
            using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
            {
                DataTable table = new DataTable();
                adapter.Fill(table);
                gvPlacements.DataSource = table;
                gvPlacements.DataBind();
            }
        }
    }
}
