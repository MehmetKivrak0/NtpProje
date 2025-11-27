<%@ Page Title="Yazı Yönetimi" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="YaziYonetimi.aspx.cs" Inherits="NtpProje_Web.Admin.YaziYonetimi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="blog-management">
        <div class="page-hero card">
            <div>
                <span class="eyebrow">İçerik Kontrol Merkezi</span>
                <h1>Yazı Yönetimi</h1>
                <p>Blog yazıları ve projeleri tek ekrandan takip edin, yayın durumlarını güncelleyin ve hızlıca yeni içerikler ekleyin.</p>
            </div>
            <div class="page-hero-meta">
                <span>Son Senkronizasyon</span>
                <strong><%= DateTime.Now.ToString("dd MMM yyyy") %></strong>
            </div>
        </div>

        <div class="management-toolbar card">
            <div class="toolbar-info">
                <h3>Yayın Akışı</h3>
                <p>Yüklediğiniz yazılar ve projeler anlık olarak aşağıdaki tablolara yansır.</p>
                <div class="stat-chip-group">
                    <div class="stat-chip">
                        <span>Toplam Yazı</span>
                        <strong><asp:Literal ID="ltrTotalPosts" runat="server" /></strong>
                    </div>
                    <div class="stat-chip">
                        <span>Toplam Proje</span>
                        <strong><asp:Literal ID="ltrTotalProjects" runat="server" /></strong>
                    </div>
                </div>
            </div>
            <div class="action-buttons">
                <a href="YaziEkleDuzenle.aspx?type=post&action=add" class="btn btn-primary">
                    <i>➕</i> Yeni Yazı Ekle
                </a>
                    <a href="YaziEkleDuzenle.aspx?type=project&action=add" class="btn btn-secondary">
                        <i>🖼️</i> Yeni Proje Ekle
                    </a>
            </div>
        </div>

        <div class="tabbed-card card">
            <div class="content-tabs">
                <button type="button" class="tab-button active" onclick="switchTab('posts'); return false;">Blog Yazıları</button>
                <button type="button" class="tab-button" onclick="switchTab('projects'); return false;">Projeler</button>
            </div>

            <div class="tab-panels">
                <div id="postsTable" class="dashboard-table tab-panel active">
                    <div class="table-header">
                        <div>
                            <h2>Blog Yazıları</h2>
                            <p class="table-subtitle">Yazar bilgisi, kategori ve yayın durumu ile tam liste</p>
                        </div>
                        <span class="table-count">Toplam: <strong><asp:Literal ID="ltrTotalPostsSidebar" runat="server" /></strong> yazı</span>
                    </div>

                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Seç</th>
                                    <th>Başlık</th>
                                    <th>Yazar</th>
                                    <th>Kategori</th>
                                    <th>Tarih</th>
                                    <th>Durum</th>
                                    <th>Gör.</th>
                                    <th>İşlemler</th>
                                </tr>
                            </thead>
                            
                            <asp:Repeater ID="rptPosts" runat="server" OnItemCommand="ActionCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><input type="checkbox" class="row-checkbox"></td>
                                        <td>
                                            <div class="post-title">
                                                <strong><%# Eval("Title") %></strong>
                                                <small><%# Eval("Summary") %></small>
                                            </div>
                                        </td>
                                        <td><%# Eval("AuthorFullName") %></td>
                                        <td><span class="category-badge"><%# Eval("CategoryName") %></span></td>
                                        <td><%# Eval("PublishDate", "{0:dd MMM yyyy}") %></td>
                                        <td>
                                            <span class='badge <%# Eval("Status").ToString() == "Published" ? "badge-success" : "badge-warning" %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </td>
                                        <td><%# Eval("ViewCount") %></td>
                                        <td>
                                            <div class="row-actions">
                                                <a href='YaziEkleDuzenle.aspx?type=post&action=edit&id=<%# Eval("Id") %>' class="btn-icon btn-edit" title="Düzenle">✏️</a>
                                                
                                                <asp:LinkButton runat="server" 
                                                    CommandName="DeletePost" 
                                                    CommandArgument='<%# Eval("Id") %>' 
                                                    OnClientClick="return confirm('Bu yazıyı silmek istediğinizden emin misiniz?')" 
                                                    CssClass="btn-icon btn-delete" 
                                                    ToolTip="Sil">🗑️</asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>

                <div id="projectsTable" class="dashboard-table tab-panel">
                    <div class="table-header">
                        <div>
                            <h2>Projeler</h2>
                            <p class="table-subtitle">Teslim tarihleri, müşteriler ve durum bilgileri</p>
                        </div>
                        <span class="table-count">Toplam: <strong><asp:Literal ID="ltrTotalProjectsSidebar" runat="server" /></strong> proje</span>
                    </div>

                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Seç</th>
                                    <th>Proje Adı</th>
                                    <th>Müşteri</th>
                                    <th>Kategori</th>
                                    <th>Bitiş</th>
                                    <th>Durum</th>
                                    <th>İşlemler</th>
                                </tr>
                            </thead>
                            
                            <asp:Repeater ID="rptProjects" runat="server" OnItemCommand="ActionCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><input type="checkbox" class="row-checkbox"></td>
                                        <td>
                                            <div class="project-title">
                                                <strong><%# Eval("Title") %></strong>
                                            </div>
                                        </td>
                                        <td><%# Eval("ClientName") %></td>
                                        <td><span class="category-badge"><%# Eval("Category") %></span></td>
                                        <td><%# Eval("CompletionDate", "{0:MMM yyyy}") %></td>
                                        <td><span class='badge'><%# Eval("Status") %></span></td>
                                        <td>
                                            <div class="row-actions">
                                                <a href='YaziEkleDuzenle.aspx?type=project&action=edit&id=<%# Eval("Id") %>' class="btn-icon btn-edit" title="Düzenle">✏️</a>
                                                
                                                <asp:LinkButton runat="server" 
                                                    CommandName="DeleteProject" 
                                                    CommandArgument='<%# Eval("Id") %>' 
                                                    OnClientClick="return confirm('Bu projeyi silmek istediğinizden emin misiniz?')" 
                                                    CssClass="btn-icon btn-delete" 
                                                    ToolTip="Sil">🗑️</asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            var postsTable = document.getElementById('postsTable');
            var projectsTable = document.getElementById('projectsTable');
            var buttons = document.getElementsByClassName('tab-button');

            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }

            postsTable.classList.remove('active');
            projectsTable.classList.remove('active');

            if (tab === 'posts') {
                postsTable.classList.add('active');
                buttons[0].classList.add('active');
            } else {
                projectsTable.classList.add('active');
                buttons[1].classList.add('active');
            }
        }
    </script>

</asp:Content>