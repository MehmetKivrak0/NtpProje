<%@ Page Title="Uzman Ekip Yönetimi" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="uzmanekp.aspx.cs" Inherits="NtpProje_Web.Admin.uzmanekp" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-content {
            background: #f5f7fa;
            padding: 30px;
            margin-left: 0;
            margin-right: 0;
            min-height: calc(100vh - 60px);
        }

        .topbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            margin-bottom: 30px;
            border-radius: 4px;
            color: white;
        }

        .topbar-left h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
            color: white;
        }

        .topbar-left p {
            margin: 5px 0 0 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        .management-toolbar {
            background: #ffffff;
            border-radius: 4px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .toolbar-info h3 {
            margin: 0 0 10px 0;
            font-size: 18px;
            color: #5a5c69;
        }

        .toolbar-info p {
            margin: 5px 0 0 0;
            color: #858796;
            font-size: 14px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #4e73df;
            color: white;
        }

        .btn-primary:hover {
            background: #375a7f;
        }

        .team-table-container {
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            overflow: hidden;
        }

        .table-header {
            padding: 20px;
            border-bottom: 1px solid #e3e6f0;
            background: #f8f9fc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #5a5c69;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: #f8f9fc;
        }

        .data-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #5a5c69;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e3e6f0;
        }

        .data-table td {
            padding: 15px;
            border-bottom: 1px solid #e3e6f0;
            color: #858796;
        }

        .data-table tbody tr:hover {
            background: #f8f9fc;
        }

        .team-member-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .team-member-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
            flex-shrink: 0;
        }

        .team-member-details h4 {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
            color: #5a5c69;
        }

        .team-member-details p {
            margin: 3px 0 0 0;
            font-size: 13px;
            color: #858796;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background: #d4edda;
            color: #155724;
        }

        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }

        .row-actions {
            display: flex;
            gap: 8px;
        }

        .btn-icon {
            width: 32px;
            height: 32px;
            border-radius: 4px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.2s;
            border: none;
            background: transparent;
            cursor: pointer;
        }

        .btn-edit {
            background: #e3f2fd;
            color: #1976d2;
        }

        .btn-edit:hover {
            background: #bbdefb;
        }

        .btn-delete {
            background: #ffebee;
            color: #c62828;
        }

        .btn-delete:hover {
            background: #ffcdd2;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #858796;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #5a5c69;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 14px;
            color: #858796;
        }

        .message-alert {
            padding: 15px 20px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: none;
        }

        .message-alert.visible {
            display: block;
        }

        .message-alert.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message-alert.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
            .management-toolbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .data-table {
                font-size: 13px;
            }

            .data-table th,
            .data-table td {
                padding: 10px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="topbar">
        <div class="topbar-left">
            <h1>👥 Uzman Ekip Yönetimi</h1>
            <p>Ekip üyelerini yönetin, ekleyin ve düzenleyin</p>
        </div>
    </div>

    <div class="dashboard-content">
        
        <asp:Label ID="lblMessage" runat="server" CssClass="message-alert" Visible="false"></asp:Label>

        <div class="management-toolbar">
            <div class="toolbar-info">
                <h3>Ekip Üyeleri</h3>
                <p>Toplam <strong><asp:Literal ID="ltrTotalMembers" runat="server" Text="0" /></strong> ekip üyesi bulunmaktadır.</p>
            </div>
            <div class="action-buttons">
                <a href="UzmanEkipEkleDzl.aspx?action=add" class="btn btn-primary">
                    <i>➕</i> Yeni Ekip Üyesi Ekle
                </a>
            </div>
        </div>

        <div class="team-table-container">
            <div class="table-header">
                <h2>Tüm Ekip Üyeleri</h2>
            </div>

            <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                <div class="empty-state">
                    <h3>👤 Henüz ekip üyesi eklenmemiştir</h3>
                    <p>Yeni ekip üyesi eklemek için "Yeni Ekip Üyesi Ekle" butonuna tıklayın.</p>
                </div>
            </asp:PlaceHolder>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Fotoğraf</th>
                            <th>Ad Soyad</th>
                            <th>Unvan</th>
                            <th>Pozisyon</th>
                            <th>E-posta</th>
                            <th>Durum</th>
                            <th>Sıralama</th>
                            <th>İşlemler</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptTeamMembers" runat="server" OnItemCommand="rptTeamMembers_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%# RenderMemberAvatar(Container.DataItem) %>
                                    </td>
                                    <td>
                                        <div class="team-member-details">
                                            <h4><%# Eval("Name") %></h4>
                                            <%# !string.IsNullOrEmpty(Eval("Email")?.ToString()) ? "<p>📧 " + Eval("Email") + "</p>" : "" %>
                                        </div>
                                    </td>
                                    <td><%# Eval("Title") ?? "-" %></td>
                                    <td><%# Eval("Position") ?? "-" %></td>
                                    <td><%# Eval("Email") ?? "-" %></td>
                                    <td>
                                        <span class='badge <%# (bool)Eval("IsActive") ? "badge-success" : "badge-danger" %>'>
                                            <%# (bool)Eval("IsActive") ? "Aktif" : "Pasif" %>
                                        </span>
                                    </td>
                                    <td><%# Eval("DisplayOrder") %></td>
                                    <td>
                                        <div class="row-actions">
                                            <a href='UzmanEkipEkleDzl.aspx?action=edit&id=<%# Eval("Id") %>' class="btn-icon btn-edit" title="Düzenle">✏️</a>
                                            <asp:LinkButton runat="server" 
                                                CommandName="Delete" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                OnClientClick="return confirm('Bu ekip üyesini silmek istediğinize emin misiniz?')"
                                                CssClass="btn-icon btn-delete" 
                                                ToolTip="Sil">🗑️</asp:LinkButton>
                                            <asp:LinkButton runat="server" 
                                                CommandName="ToggleActive" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                CssClass="btn-icon" 
                                                ToolTip='<%# (bool)Eval("IsActive") ? "Pasif Yap" : "Aktif Yap" %>'>
                                                <%# (bool)Eval("IsActive") ? "👁️" : "🚫" %>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</asp:Content>
