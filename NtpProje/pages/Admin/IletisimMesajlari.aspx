<%@ Page Title="İletişim Mesajları" Language="C#" MasterPageFile="~/pages/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="IletisimMesajlari.aspx.cs" Inherits="NtpProje_Web.Admin.IletisimMesajlari" ValidateRequest="false" %>

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

        /* Message Stats Cards */
        .message-stats {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
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
        .stat-card.orange { border-left-color: #f6c23e; }
        .stat-card.green { border-left-color: #1cc88a; }
        .stat-card.purple { border-left-color: #6f42c1; }
        .stat-card.red { border-left-color: #e74a3b; }

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
        .stat-icon.orange { background: #fff3cd; }
        .stat-icon.green { background: #d4edda; }
        .stat-icon.purple { background: #e7d5ff; }
        .stat-icon.red { background: #ffe5e5; }

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

        /* Messages Container */
        .messages-container {
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            overflow: hidden;
        }

        .messages-list {
            padding: 0;
        }

        /* Message Item */
        .message-item {
            padding: 20px;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            align-items: flex-start;
            gap: 15px;
            transition: background 0.2s;
        }

        .message-item:last-child {
            border-bottom: none;
        }

        .message-item:hover {
            background: #f8f9fc;
        }

        .message-item.unread {
            background: #f0f7ff;
            border-left: 4px solid #4e73df;
        }

        .message-item.read {
            background: #ffffff;
            border-left: 4px solid #e3e6f0;
        }

        /* Message Avatar */
        .message-avatar {
            flex-shrink: 0;
        }

        .avatar-circle {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 20px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        /* Message Content */
        .message-content {
            flex: 1;
            min-width: 0;
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .message-header h4 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #5a5c69;
        }

        .message-time {
            font-size: 12px;
            color: #858796;
            font-weight: 400;
        }

        .message-subject {
            font-weight: 600;
            font-size: 15px;
            color: #2c3e50;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .message-preview {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .message-meta {
            font-size: 12px;
            color: #858796;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        /* Badges */
        .badge-read {
            background-color: #1cc88a;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-unread {
            background-color: #f6c23e;
            color: #333;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Message Actions */
        .message-actions {
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

        .btn-icon.btn-delete:hover {
            background: #fee;
            color: #e74a3b;
        }

        /* Empty State */
        .empty-messages {
            text-align: center;
            padding: 60px 20px;
            color: #858796;
        }

        .empty-messages h3 {
            font-size: 20px;
            color: #5a5c69;
            margin-bottom: 10px;
        }

        .empty-messages p {
            font-size: 14px;
            color: #858796;
        }

        /* Topbar */
        .topbar-left p {
            margin: 5px 0 0 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        /* İletişim Bilgileri Section */
        .contact-info-section {
            background: #ffffff;
            border-radius: 4px;
            padding: 30px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 30px;
        }

        .contact-info-title {
            font-size: 20px;
            font-weight: 700;
            color: #5a5c69;
            margin: 0 0 25px 0;
            text-align: center;
        }

        .contact-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .contact-info-item {
            background: #f8f9fc;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #4e73df;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .contact-info-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(58, 59, 69, 0.15);
        }

        .contact-info-label {
            font-weight: 600;
            color: #5a5c69;
            font-size: 14px;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .contact-info-value {
            color: #858796;
            font-size: 15px;
            line-height: 1.6;
        }

        .contact-info-input {
            width: 100%;
            padding: 12px;
            border: 1px solid #e3e6f0;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            color: #5a5c69;
            background: #ffffff;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .contact-info-input:focus {
            outline: none;
            border-color: #4e73df;
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        }

        .btn-save-contact {
            background: #4e73df;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 6px rgba(78, 115, 223, 0.3);
        }

        .btn-save-contact:hover {
            background: #2e59d9;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(78, 115, 223, 0.4);
        }

        .contact-info-message {
            display: block;
            padding: 12px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }

        .contact-info-message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .contact-info-message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .message-stats {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 1200px) {
            .message-stats {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                padding: 20px;
            }

            .message-stats {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .contact-info-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .message-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .message-actions {
                width: 100%;
                justify-content: flex-end;
            }

            .message-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <div class="topbar">
            <div class="topbar-left">
            <h1>📧 İletişim Mesajları</h1>
                <p>Gelen mesajları yönetin ve yanıtlayın</p>
        </div>
        </div>

    <div class="dashboard-content">
        <!-- Message Stats -->
        <div class="message-stats">
            <div class="stat-card blue">
                <div class="stat-icon blue">📧</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrTotalMessages" runat="server" Text="0" /></h3>
                    <p>Toplam İletişim Mesajı</p>
                </div>
            </div>

            <div class="stat-card orange">
                <div class="stat-icon orange">⏳</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrUnreadMessages" runat="server" Text="0" /></h3>
                    <p>Okunmamış Mesaj</p>
                </div>
            </div>

            <div class="stat-card green">
                <div class="stat-icon green">✅</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrReadMessages" runat="server" Text="0" /></h3>
                    <p>Okunmuş Mesaj</p>
                </div>
            </div>

            <div class="stat-card purple">
                <div class="stat-icon purple">📋</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrTotalProjectRequests" runat="server" Text="0" /></h3>
                    <p>Toplam Proje Teklifi</p>
                </div>
            </div>

            <div class="stat-card red">
                <div class="stat-icon red">🚨</div>
                <div class="stat-content">
                    <h3><asp:Literal ID="ltrUnreadProjectRequests" runat="server" Text="0" /></h3>
                    <p>Okunmamış Teklif</p>
                </div>
            </div>
        </div>

        <!-- İletişim Bilgilerimiz Düzenleme -->
        <div class="contact-info-section">
            <h2 class="contact-info-title">İletişim Bilgilerimiz</h2>
            <p style="text-align: center; color: #858796; margin-bottom: 20px;">Bu bilgiler sitede (iletisim.aspx) gösterilecektir.</p>
            
            <asp:Label ID="lblContactInfoMessage" runat="server" CssClass="contact-info-message" Visible="false"></asp:Label>
            
            <asp:Panel ID="pnlContactInfoForm" runat="server">
                <div class="contact-info-grid">
                    <div class="contact-info-item">
                        <div class="contact-info-label">📍 Adres</div>
                        <asp:TextBox ID="txtAdres" runat="server" CssClass="contact-info-input" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-label">📞 Telefon</div>
                        <asp:TextBox ID="txtTelefon" runat="server" CssClass="contact-info-input"></asp:TextBox>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-label">📧 E-posta</div>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="contact-info-input" TextMode="Email"></asp:TextBox>
                    </div>
                    <div class="contact-info-item">
                        <div class="contact-info-label">🕐 Çalışma Saatleri</div>
                        <asp:TextBox ID="txtSaatler" runat="server" CssClass="contact-info-input" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>
                </div>
                
                <!-- Harita Linki -->
                <div style="margin-top: 25px; padding: 20px; background: #f8f9fc; border-radius: 8px; border-left: 4px solid #6f42c1;">
                    <div class="contact-info-label" style="margin-bottom: 10px;">🗺️ Google Maps Harita Linki (Embed)</div>
                    <p style="font-size: 12px; color: #858796; margin-bottom: 10px;">Google Maps'ten "Haritayı Paylaş" > "Haritayı Yerleştir" seçeneğinden embed kodunu VEYA sadece URL'yi buraya yapıştırın.</p>
                    <asp:TextBox ID="txtHaritaLink" runat="server" CssClass="contact-info-input" TextMode="MultiLine" Rows="4" placeholder="Örnek URL: https://www.google.com/maps/embed?pb=..."></asp:TextBox>
                    <p style="font-size: 11px; color: #858796; margin-top: 8px;">💡 İpucu: Google Maps'te "Haritayı Paylaş" > "Haritayı Yerleştir" > "HTML'yi Kopyala" ile iframe kodunu alın. Sistem otomatik olarak URL'yi çıkaracaktır. VEYA sadece URL'yi yapıştırabilirsiniz.</p>
                </div>
                
                <div style="text-align: center; margin-top: 25px;">
                    <asp:Button ID="btnKaydet" runat="server" Text="💾 Bilgileri Kaydet" CssClass="btn-save-contact" OnClick="btnKaydet_Click" />
                </div>
            </asp:Panel>
        </div>

        <!-- İletişim Mesajları Container -->
        <div class="messages-container">
            <h2 style="padding: 20px 20px 10px 20px; margin: 0; font-size: 20px; color: #5a5c69; border-bottom: 1px solid #e3e6f0;">📧 İletişim Mesajları</h2>
            <div class="messages-list">
                
                <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                    <div class="empty-messages">
                        <h3>📭 Gelen kutusu boş</h3>
                        <p>Henüz hiç mesaj almadınız.</p>
                    </div>
                </asp:PlaceHolder>

                <asp:Repeater ID="rptMessages" runat="server" OnItemCommand="rptMessages_ItemCommand">
                    <ItemTemplate>
                        <div class='message-item <%# (bool)Eval("IsRead") ? "read" : "unread" %>'>
                            
                    <div class="message-avatar">
                                <div class="avatar-circle">
                                    <%# Eval("NameSurname").ToString().Substring(0, 1).ToUpper() %>
                    </div>
                </div>

                    <div class="message-content">
                        <div class="message-header">
                                    <h4><%# Eval("NameSurname") %></h4>
                                    <span class="message-time"><%# Eval("CreatedDate", "{0:dd MMM yyyy HH:mm}") %></span>
                        </div>
                                
                                <div class="message-subject">
                                    <%# Eval("Subject") %>
                                    <span class='<%# (bool)Eval("IsRead") ? "badge-read" : "badge-unread" %>'>
                                        <%# (bool)Eval("IsRead") ? "Okundu" : "Yeni" %>
                                    </span>
                </div>

                                <div class="message-preview">
                                    <%# Eval("Message") %>
                </div>

                        <div class="message-meta">
                                    <span>📧 <%# Eval("Email") %></span>
                                    <span>📞 <%# Eval("Phone") %></span>
                    </div>
                </div>

                            <div class="message-actions">
                                <asp:LinkButton runat="server" CommandName="MarkRead" CommandArgument='<%# Eval("Id") %>' 
                                                Visible='<%# !(bool)Eval("IsRead") %>'
                                                CssClass="btn-icon" ToolTip="Okundu İşaretle">✅</asp:LinkButton>
                                
                                <asp:LinkButton runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' 
                                                OnClientClick="return confirm('Bu mesajı silmek istediğinize emin misiniz?')"
                                                CssClass="btn-icon btn-delete" ToolTip="Sil">🗑️</asp:LinkButton>
                    </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>

        <!-- Proje Teklifleri Container -->
        <div class="messages-container" style="margin-top: 30px;">
            <h2 style="padding: 20px 20px 10px 20px; margin: 0; font-size: 20px; color: #5a5c69; border-bottom: 1px solid #e3e6f0;">📋 Proje Teklifleri</h2>
            <div class="messages-list">
                
                <asp:PlaceHolder ID="phEmptyProjectRequests" runat="server" Visible="false">
                    <div class="empty-messages">
                        <h3>📭 Proje teklifi yok</h3>
                        <p>Henüz hiç proje teklifi almadınız.</p>
                    </div>
                </asp:PlaceHolder>

                <asp:Repeater ID="rptProjectRequests" runat="server" OnItemCommand="rptProjectRequests_ItemCommand">
                    <ItemTemplate>
                        <div class='message-item <%# (bool)Eval("IsRead") ? "read" : "unread" %>'>
                            
                    <div class="message-avatar">
                                <div class="avatar-circle" style="background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);">
                                    <%# Eval("CompanyName").ToString().Substring(0, 1).ToUpper() %>
                    </div>
                </div>

                    <div class="message-content">
                        <div class="message-header">
                                    <h4><%# Eval("CompanyName") %></h4>
                                    <span class="message-time"><%# Eval("RequestDate", "{0:dd MMM yyyy HH:mm}") %></span>
                        </div>
                                
                                <div class="message-subject">
                                    Yetkili: <%# Eval("AuthorizedPerson") %>
                                    <span class='<%# (bool)Eval("IsRead") ? "badge-read" : "badge-unread" %>'>
                                        <%# (bool)Eval("IsRead") ? "Okundu" : "Yeni" %>
                                    </span>
                </div>

                                <div class="message-preview">
                                    <%# Eval("ProjectDetails") %>
                </div>

                        <div class="message-meta">
                                    <span>📧 <%# Eval("Email") %></span>
                                    <span>📞 <%# Eval("Phone") %></span>
                                    <%# Eval("Budget") != null && Eval("Budget").ToString() != "0" ? "<span>💰 Bütçe: " + string.Format("{0:N0}", Eval("Budget")) + " TL</span>" : "" %>
                                    <%# !string.IsNullOrEmpty(Eval("Status")?.ToString()) ? "<span class='badge-read'>📊 " + Eval("Status") + "</span>" : "" %>
                    </div>
                </div>

                            <div class="message-actions">
                                <asp:LinkButton runat="server" CommandName="MarkRead" CommandArgument='<%# Eval("Id") %>' 
                                                Visible='<%# !(bool)Eval("IsRead") %>'
                                                CssClass="btn-icon" ToolTip="Okundu İşaretle">✅</asp:LinkButton>
                                
                                <asp:LinkButton runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' 
                                                OnClientClick="return confirm('Bu proje teklifini silmek istediğinize emin misiniz?')"
                                                CssClass="btn-icon btn-delete" ToolTip="Sil">🗑️</asp:LinkButton>
                    </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>

</asp:Content>
