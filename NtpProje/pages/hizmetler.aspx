<%@ Page Title="Hizmetlerimiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Hizmetler.aspx.cs" Inherits="NtpProje_Web.hizmetler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/hizmetler.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 hizmetler_container">

        <div class="hizmetler_hero">
            <h1>Yazılım Hizmetlerimiz</h1>
            <p>Modern teknolojiler ve en iyi uygulamalarla, işletmenizin dijital dönüşümünde yanınızdayız. İhtiyaçlarınıza özel, ölçeklenebilir ve güvenli yazılım çözümleri sunuyoruz.</p>
        </div>

        <div class="hizmet_grid">
            <asp:Repeater ID="rptHizmetler" runat="server" OnItemDataBound="rptHizmetler_ItemDataBound">
                <ItemTemplate>
                    <div class="hizmet_item">
                        <div class="hizmet_img">
                            <img src='<%# Eval("Image") %>' alt='<%# Eval("Name") %>' />
                        </div>

                        <div class="hizmet_content">
                            <h3><%# Eval("Name") %></h3>
                            
                            <p><%# Eval("Description") %></p>

                            <div class="hizmet_ozellikleri">
                                <ul>
                                    <asp:Repeater ID="rptFeatures" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <i class="fas fa-check"></i> <%# Container.DataItem %>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>

                            <a href='hizmet_detay.aspx?id=<%# Eval("Id") %>' class="hizmet_btn">
                                Devamını Oku
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:PlaceHolder ID="phEmptyMessage" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px;">
                    <p>Gösterilecek hizmet bulunmamaktadır.</p>
                </div>
            </asp:PlaceHolder>

        </div>

        <div class="neden_biz_section">
            <h2 class="neden_biz_baslik">Neden Bizi Tercih Etmelisiniz?</h2>
            <div class="neden_biz_grid">
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">🏆</span>
                    <h3>10+ Yıl Deneyim</h3>
                    <p>Yazılım sektöründe 10 yılı aşkın deneyim ve yüzlerce başarılı proje</p>
                </div>
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">👥</span>
                    <h3>Uzman Ekip</h3>
                    <p>Sertifikalı ve deneyimli yazılımcılardan oluşan profesyonel ekip</p>
                </div>
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">⚡</span>
                    <h3>Hızlı Teslimat</h3>
                    <p>Agile metodoloji ile zamanında ve kaliteli teslimat</p>
                </div>
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">🔒</span>
                    <h3>Güvenlik</h3>
                    <p>En yüksek güvenlik standartları ve veri koruma</p>
                </div>
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">💬</span>
                    <h3>7/24 Destek</h3>
                    <p>Sürekli teknik destek ve bakım hizmetleri</p>
                </div>
                <div class="neden_biz_item">
                    <span class="neden_biz_icon">💰</span>
                    <h3>Uygun Fiyat</h3>
                    <p>Rekabetçi fiyatlarla kaliteli hizmet</p>
                </div>
            </div>
        </div>

        <div class="hizmetler_cta">
            <h2>Projenizi Hayata Geçirelim!</h2>
            <p>İşletmeniz için en uygun yazılım çözümünü birlikte belirleyelim. Ücretsiz danışmanlık ve proje teklifi için hemen iletişime geçin.</p>
            <div class="cta_buttons">
                <a href="iletisim.aspx" class="cta_button primary">Teklif Alın</a>
                <a href="projeler.aspx" class="cta_button secondary">Projelerimizi İnceleyin</a>
            </div>
        </div>
    </div>
</asp:Content>