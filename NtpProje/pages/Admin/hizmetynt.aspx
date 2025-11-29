<%@ Page Title="Hizmet Yönetimi" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="hizmetynt.aspx.cs" Inherits="NtpProje.pages.Admin.hizmetynt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Dashboard Content Padding */
        .dashboard-content {
            background: #f5f7fa;
            padding: 30px;
            margin-left: 0;
            margin-right: 0;
            min-height: calc(100vh - 60px);
        }

        /* Service Stats Cards */
        .service-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #ffffff;
            border-radius: 4px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            transition: transform 0.2s, box-shadow 0.2s;
            border-left: 4px solid #4e73df;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.25rem 2rem 0 rgba(58, 59, 69, 0.25);
        }

        .stat-card.blue { border-left-color: #4e73df; }
        .stat-card.green { border-left-color: #1cc88a; }
        .stat-card.orange { border-left-color: #f6c23e; }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .stat-icon.blue { background: #e3f2fd; }
        .stat-icon.green { background: #d4edda; }
        .stat-icon.orange { background: #fff3cd; }

        .stat-content {
            flex: 1;
        }

        .stat-content h3 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
            color: #5a5c69;
            line-height: 1.2;
        }

        .stat-content p {
            margin: 5px 0 0 0;
            color: #858796;
            font-size: 13px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Services Container */
        .services-container {
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
            flex-wrap: wrap;
            gap: 15px;
        }

        .table-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #5a5c69;
        }

        .table-subtitle {
            margin: 5px 0 0 0;
            font-size: 13px;
            color: #858796;
        }

        .table-count {
            font-size: 14px;
            color: #858796;
        }

        .table-count strong {
            color: #5a5c69;
            font-weight: 700;
        }

        /* Search and Filter Bar */
        .search-filter-bar {
            padding: 20px;
            border-bottom: 1px solid #e3e6f0;
            background: #ffffff;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 1px solid #e3e6f0;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #4e73df;
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #858796;
            font-size: 16px;
        }

        .btn-search {
            background: #4e73df;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-search:hover {
            background: #2e59d9;
        }

        .btn-add-service {
            background: #1cc88a;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
        }

        .btn-add-service:hover {
            background: #17a673;
        }

        /* Services List */
        .services-list {
            padding: 0;
        }

        .service-item {
            padding: 20px;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: background 0.2s;
        }

        .service-item:last-child {
            border-bottom: none;
        }

        .service-item:hover {
            background: #f8f9fc;
        }

        .service-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            flex-shrink: 0;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: #858796;
        }

        .service-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
        }

        .service-content {
            flex: 1;
            min-width: 0;
        }

        .service-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .service-title {
            font-size: 18px;
            font-weight: 600;
            color: #5a5c69;
            margin: 0 0 5px 0;
        }

        .service-description {
            color: #858796;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .service-meta {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            font-size: 12px;
            color: #858796;
        }

        /* Badges */
        .badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-success {
            background-color: #1cc88a;
            color: white;
        }

        .badge-warning {
            background-color: #f6c23e;
            color: #333;
        }

        .badge-secondary {
            background-color: #858796;
            color: white;
        }

        /* Service Actions */
        .service-actions {
            display: flex;
            gap: 8px;
            flex-shrink: 0;
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f3f4f6;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            font-size: 16px;
        }

        .btn-icon:hover {
            background: #e5e7eb;
            transform: translateY(-1px);
        }

        .btn-icon.btn-edit:hover {
            background: #e3f2fd;
            color: #4e73df;
        }

        .btn-icon.btn-delete:hover {
            background: #fee;
            color: #e74a3b;
        }

        .btn-icon.btn-toggle:hover {
            background: #fff3cd;
            color: #f6c23e;
        }

        /* Empty State */
        .empty-services {
            text-align: center;
            padding: 60px 20px;
            color: #858796;
        }

        .empty-services h3 {
            font-size: 20px;
            color: #5a5c69;
            margin-bottom: 10px;
        }

        .empty-services p {
            font-size: 14px;
            color: #858796;
        }

        /* Message Alert */
        .message-alert {
            padding: 12px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
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

        .message-alert.warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .message-alert.info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .service-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                padding: 20px;
            }

            .service-stats {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .service-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .service-image {
                width: 100%;
                height: 200px;
            }

            .service-actions {
                width: 100%;
                justify-content: flex-end;
            }

            .search-filter-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                min-width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="topbar">
        <div class="topbar-left">
            <h1>⚙️ Hizmet Yönetimi</h1>
            <p>Sunduğunuz hizmetleri yönetin, düzenleyin ve yeni hizmetler ekleyin</p>
        </div>
    </div>

    <div class="dashboard-content">
        <!-- Message Alert -->
        <asp:Label ID="lblMessage" runat="server" CssClass="message-alert" Visible="false"></asp:Label>

        <!-- Service Stats -->
        <div class="service-stats">
            <div class="stat-card blue">
                <div class="stat-icon blue">📋</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrTotalServices" runat="server" Text="0" /></h3>
                    <p>Toplam Hizmet</p>
                </div>
            </div>

            <div class="stat-card green">
                <div class="stat-icon green">✅</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrActiveServices" runat="server" Text="0" /></h3>
                    <p>Aktif Hizmet</p>
                </div>
            </div>

            <div class="stat-card orange">
                <div class="stat-icon orange">⏸️</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrInactiveServices" runat="server" Text="0" /></h3>
                    <p>Pasif Hizmet</p>
                </div>
            </div>
        </div>

        <!-- Services Container -->
        <div class="services-container">
            <div class="table-header">
                <div>
                    <h2>Hizmetler</h2>
                    <p class="table-subtitle">Tüm hizmetlerinizi buradan yönetebilirsiniz</p>
                </div>
                <span class="table-count">Toplam: <strong><asp:Literal ID="ltrTotalServicesSidebar" runat="server" Text="0" /></strong> hizmet</span>
            </div>

            <!-- Search and Filter Bar -->
            <div class="search-filter-bar">
                <div class="search-box">
                    <span class="search-icon">🔍</span>
                    <asp:TextBox ID="txtArama" runat="server" placeholder="Hizmet adı veya açıklama ile ara..." CssClass="search-input"></asp:TextBox>
                </div>
                <asp:Button ID="btnAra" runat="server" Text="Ara" CssClass="btn-search" OnClick="btnAra_Click" />
                <a href="hizmetekle.aspx?action=add" class="btn-add-service">
                    <span>➕</span> Yeni Hizmet Ekle
                </a>
            </div>

            <!-- Services List -->
            <div class="services-list">
                
                <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                    <div class="empty-services">
                        <h3>📭 Henüz hizmet eklenmemiş</h3>
                        <p>İlk hizmetinizi eklemek için "Yeni Hizmet Ekle" butonuna tıklayın.</p>
                    </div>
                </asp:PlaceHolder>

                <asp:Repeater ID="rptServices" runat="server" 
                              OnItemCommand="rptServices_ItemCommand"
                              OnItemDataBound="rptServices_ItemDataBound">
                    <ItemTemplate>
                        <div class="service-item">
                            
                            <!-- Service Image -->
                            <div class="service-image">
                                <%#GetServiceImage(Eval("ImageUrl"), Eval("Icon"), Eval("Name")) %>
                            </div>

                            <!-- Service Content -->
                            <div class="service-content">
                                <div class="service-header">
                                    <div>
                                        <h3 class="service-title"><%# Eval("Name") %></h3>
                                        <div class="service-meta">
                                            <span>📊 Sıra: <%# Eval("DisplayOrder") %></span>
                                            <span>👁️ Görüntülenme: <%# Eval("ViewCount") %></span>
                                            <%# !string.IsNullOrEmpty(Eval("Slug")?.ToString()) ? "<span>🔗 Slug: " + Eval("Slug") + "</span>" : "" %>
                                        </div>
                                    </div>
                                    <span class='badge <%# (bool)Eval("IsActive") ? "badge-success" : "badge-warning" %>'>
                                        <%# (bool)Eval("IsActive") ? "Aktif" : "Pasif" %>
                                    </span>
                                </div>
                                
                                <div class="service-description">
                                    <%# GetFormattedDescription(Eval("ShortDescription")) %>
                                </div>
                            </div>

                            <!-- Service Actions -->
                            <div class="service-actions">
                                <a href='hizmetekle.aspx?action=edit&id=<%# Eval("Id") %>' 
                                   class="btn-icon btn-edit" 
                                   title="Düzenle">✏️</a>
                                
                                <asp:LinkButton runat="server" 
                                                CommandName="ToggleActive" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                CssClass="btn-icon btn-toggle" 
                                                ToolTip='<%# (bool)Eval("IsActive") ? "Pasif Yap" : "Aktif Yap" %>'>
                                    <%# (bool)Eval("IsActive") ? "⏸️" : "▶️" %>
                                </asp:LinkButton>
                                
                                <asp:LinkButton runat="server" 
                                                CommandName="Delete" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                OnClientClick="return confirm('Bu hizmeti silmek istediğinize emin misiniz?')" 
                                                CssClass="btn-icon btn-delete" 
                                                ToolTip="Sil">🗑️</asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>

</asp:Content>
