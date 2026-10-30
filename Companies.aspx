<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="P9_PlacementDashboard.Companies" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Company Placement Summary</title>
    <link href="Content/site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <header class="topbar">
                <div>
                    <div class="eyebrow">STUDENT PLACEMENT CELL</div>
                    <h1>Company Placement Summary</h1>
                    <p class="subtitle">Placed students and company-wise hiring details.</p>
                </div>
                <a class="nav-button" href="Default.aspx">← Back to Dashboard</a>
            </header>

            <main>
                <asp:Label ID="lblMessage" runat="server" CssClass="message" EnableViewState="false" />

                <section class="panel">
                    <div class="panel-heading">
                        <div>
                            <div class="eyebrow">PLACEMENT LIST</div>
                            <h2>Placed Student Records</h2>
                        </div>
                        <span class="pill">Repeater</span>
                    </div>
                    <div class="table-wrap">
                        <asp:Repeater ID="rptCompanies" runat="server">
                            <HeaderTemplate>
                                <table class="data-grid repeater-grid">
                                    <thead>
                                        <tr>
                                            <th>Placement ID</th>
                                            <th>Student ID</th>
                                            <th>Company</th>
                                            <th>Job Role</th>
                                            <th>Package (LPA)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("PlacementId") %></td>
                                    <td><%#: Eval("StudentId") %></td>
                                    <td><%#: Eval("CompanyName") %></td>
                                    <td><%#: Eval("JobRole") %></td>
                                    <td><%# Eval("PackageLPA", "{0:N2}") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:Label ID="lblNoPlacements" runat="server" CssClass="empty-message" Visible="false" Text="No placed students found." />
                    </div>
                </section>

                <section class="panel">
                    <div class="panel-heading">
                        <div>
                            <div class="eyebrow">COMPANY REPORT</div>
                            <h2>Company-wise Hiring Details</h2>
                        </div>
                        <span class="pill">DataList</span>
                    </div>
                    <div class="company-cards">
                        <asp:DataList ID="dlPlacements" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" CssClass="company-list">
                            <ItemTemplate>
                                <article class="company-card">
                                    <h3><%#: Eval("CompanyName") %></h3>
                                    <div class="company-metric">
                                        <span>Students hired</span>
                                        <strong><%# Eval("TotalHires") %></strong>
                                    </div>
                                    <div class="company-metric">
                                        <span>Highest package</span>
                                        <strong><%# Eval("HighestPackage", "{0:N2}") %> LPA</strong>
                                    </div>
                                    <div class="company-metric">
                                        <span>Average package</span>
                                        <strong><%# Eval("AveragePackage", "{0:N2}") %> LPA</strong>
                                    </div>
                                </article>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:Label ID="lblNoCompanies" runat="server" CssClass="empty-message" Visible="false" Text="No company details are available yet." />
                    </div>
                </section>

                <footer class="footer-note">Practical 9 · Repeater and DataList data controls</footer>
            </main>
        </div>
    </form>
</body>
</html>
