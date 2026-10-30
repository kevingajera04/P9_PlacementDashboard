<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="P9_PlacementDashboard.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Placement Dashboard</title>
    <link href="Content/site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <header class="topbar">
                <div>
                    <div class="eyebrow">STUDENT PLACEMENT CELL</div>
                    <h1>Placement Dashboard</h1>
                    <p class="subtitle">A quick overview of student placement performance.</p>
                </div>
                <a class="nav-button" href="Companies.aspx">Company Summary <span aria-hidden="true">→</span></a>
            </header>

            <main>
                <asp:Label ID="lblMessage" runat="server" CssClass="message" EnableViewState="false" />

                <section class="section-heading">
                    <div>
                        <div class="eyebrow">OVERVIEW</div>
                        <h2>Placement Statistics</h2>
                    </div>
                    <span class="section-note">Live data from PlacementDB</span>
                </section>

                <section class="stats-grid">
                    <article class="stat-card">
                        <span class="stat-label">Total Students</span>
                        <asp:Label ID="lblTotal" runat="server" CssClass="stat-value" Text="0" />
                        <span class="stat-foot">Registered records</span>
                    </article>
                    <article class="stat-card">
                        <span class="stat-label">Placed Students</span>
                        <asp:Label ID="lblPlaced" runat="server" CssClass="stat-value" Text="0" />
                        <span class="stat-foot">Successfully placed</span>
                    </article>
                    <article class="stat-card">
                        <span class="stat-label">Unplaced Students</span>
                        <asp:Label ID="lblUnplaced" runat="server" CssClass="stat-value" Text="0" />
                        <span class="stat-foot">Awaiting placement</span>
                    </article>
                    <article class="stat-card">
                        <span class="stat-label">Placement Percentage</span>
                        <asp:Label ID="lblPercentage" runat="server" CssClass="stat-value" Text="0.00%" />
                        <span class="stat-foot">Placed / total students</span>
                    </article>
                    <article class="stat-card stat-card-highlight">
                        <span class="stat-label">Highest Package</span>
                        <asp:Label ID="lblHighestPackage" runat="server" CssClass="stat-value" Text="0.00" />
                        <span class="stat-foot">LPA</span>
                    </article>
                </section>

                <section class="panel">
                    <div class="panel-heading">
                        <div>
                            <div class="eyebrow">STUDENT DATA</div>
                            <h2>Student Placement Records</h2>
                        </div>
                        <span class="pill">GridView</span>
                    </div>
                    <div class="table-wrap">
                        <asp:GridView ID="gvPlacements" runat="server" AutoGenerateColumns="False"
                            CssClass="data-grid" GridLines="None" EmptyDataText="No student records found."
                            EmptyDataRowStyle-CssClass="empty-row">
                            <Columns>
                                <asp:BoundField DataField="PlacementId" HeaderText="Placement ID" />
                                <asp:BoundField DataField="StudentId" HeaderText="Student ID" />
                                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                <asp:BoundField DataField="JobRole" HeaderText="Job Role" />
                                <asp:BoundField DataField="PackageLPA" HeaderText="Package (LPA)" DataFormatString="{0:N2}" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToBoolean(Eval("IsPlaced")) ? "status status-placed" : "status status-pending" %>'>
                                            <%# Convert.ToBoolean(Eval("IsPlaced")) ? "Placed" : "Not Placed" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </section>

                <footer class="footer-note">Practical 9 · Create Placement Dashboard using Data Controls &amp; Reports</footer>
            </main>
        </div>
    </form>
</body>
</html>
