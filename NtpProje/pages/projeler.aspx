<%@ Page Title="Projelerimiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="projeler.aspx.cs" Inherits="NtpProje_Web.Projeler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%= ResolveUrl("~/css/genc_birey_stil.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%= ResolveUrl("~/css/projeler.css") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 projeler_container">
        <div class="projeler_baslik">
            <h1>Tamamlanan Projelerimiz</h1>
            <p>150'den fazla başarılı projeye imza attık. İşte seçtiğimiz bazı öne çıkan çalışmalarımız.</p>
        </div>
        
        <div class="proje_grid">
            <asp:Repeater ID="rptProjeler" runat="server" OnItemDataBound="rptProjeler_ItemDataBound">
                <ItemTemplate>
                    <div class="proje_card">
                        <div class="proje_card_image">
                            <span class="proje_kategori_badge"><%# Eval("Category") %></span>
                            
                            <a href='<%# "proje_detay.aspx?id=" + Eval("Id") %>'>
                                <asp:Image ID="imgProje" runat="server" 
                                    ImageUrl='<%# GetImageUrl(Eval("ImageUrl")) %>' 
                                    AlternateText='<%# Eval("Title") %>' />
                            </a>
                        </div>
                        <div class="proje_card_content">
                            <h3 class="proje_card_baslik"><%# Eval("Title") %></h3>
                            
                            <p class="proje_card_aciklama">
                                <%# Eval("Description") %>
                            </p>
                            
                            <div class="proje_card_footer">
                                <div class="proje_teknolojiler">
                                    <asp:Repeater ID="rptTeknolojiler" runat="server">
                                        <ItemTemplate>
                                            <span class="teknoloji_tag"><%# Container.DataItem %></span>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <a href='<%# "proje_detay.aspx?id=" + Eval("Id") %>' class="proje_detay_btn">
                                    Detaylı İncele <span class="proje_detay_icon">→</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:PlaceHolder ID="phEmptyProject" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px; grid-column: 1 / -1;">
                    <p>Henüz listelenecek proje bulunmamaktadır.</p>
                </div>
            </asp:PlaceHolder>
        </div>
        
        <div class="proje_cta">
            <h2>Projeniz İçin Teklif Alın</h2>
            <p>Hayalinizdeki projeyi birlikte gerçeğe dönüştürelim. Ücretsiz danışmanlık ve proje teklifi için bizimle iletişime geçin.</p>
            <a href="iletisim.aspx" class="cta_btn">İletişime Geçin</a>
        </div>
    </div>
</asp:Content>