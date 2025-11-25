<%@ Page Title="Proje Detayı" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="proje_detay.aspx.cs" Inherits="NtpProje_Web.ProjeDetay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/proje_detay.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1" style="padding:20px 0px;">
        
        <a href="projeler.aspx" class="geri_buton">← Tüm Projelere Dön</a>
        
        <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
            <div class="alert alert-warning" style="text-align:center; padding:50px; background:#fff3cd; color:#856404; border:1px solid #ffeeba; border-radius:5px;">
                <h3>⚠️ Proje Bulunamadı</h3>
                <p>Aradığınız proje silinmiş veya yayından kaldırılmış olabilir.</p>
                <a href="projeler.aspx" style="color:#856404; font-weight:bold; text-decoration:underline;">Projelere Dön</a>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlContent" runat="server">
            <div class="proje_detay_wrapper">
                <div class="proje_baslik">
                    <asp:Label ID="lblBaslik" runat="server"></asp:Label>
                </div>
                
                <div class="proje_meta">
                    <div class="proje_meta_item">
                        <span class="proje_meta_label">Müşteri:</span>
                        <span><asp:Label ID="lblMusteri" runat="server"></asp:Label></span>
                    </div>
                    <div class="proje_meta_item">
                        <span class="proje_meta_label">Kategori:</span>
                        <span><asp:Label ID="lblKategori" runat="server"></asp:Label></span>
                    </div>
                    <div class="proje_meta_item">
                        <span class="proje_meta_label">Tamamlanma:</span>
                        <span><asp:Label ID="lblTarih" runat="server"></asp:Label></span>
                    </div>
                    <div class="proje_meta_item">
                        <span class="proje_meta_label">Durum:</span>
                        <span style="color:#28a745; font-weight:bold;">Tamamlandı</span>
                    </div>
                    <div class="proje_meta_item">
                        <span class="proje_meta_label">Görüntülenme:</span>
                        <span><asp:Label ID="lblGoruntulenme" runat="server"></asp:Label></span>
                    </div>
                    <div class="clear"></div>
                </div>
                
                <div class="proje_ana_gorsel">
                    <asp:Image ID="imgProje" runat="server" AlternateText="Proje Görseli" />
                </div>
                
                <div class="proje_icerik">
                    <h3>📋 Proje Hakkında</h3>
                    <div class="proje_description">
                        <asp:Literal ID="ltrAciklama" runat="server"></asp:Literal>
                    </div>
                    
                    <h3>💻 Kullanılan Teknolojiler</h3>
                    <div style="margin: 20px 0;">
                        <asp:Repeater ID="rptTeknolojiler" runat="server">
                            <ItemTemplate>
                                <span class="teknoloji_badge"><%# Container.DataItem %></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    
                    <h3>⚙️ Genel Özellikler</h3>
                    <ul>
                        <li>Modern ve kullanıcı dostu arayüz tasarımı</li>
                        <li>Yüksek performanslı ve ölçeklenebilir altyapı</li>
                        <li>Mobil uyumlu (Responsive) tasarım</li>
                        <li>SEO optimizasyonu ve hızlı yükleme süreleri</li>
                        <li>Güvenli veri şifreleme ve KVKK uyumluluğu</li>
                    </ul>
                </div>
                
                <div class="istatistik_wrapper">
                    <div class="istatistik_item">
                        <span class="istatistik_sayi">100%</span>
                        <span class="istatistik_label">Müşteri Memnuniyeti</span>
                    </div>
                    <div class="istatistik_item">
                        <span class="istatistik_sayi">7/24</span>
                        <span class="istatistik_label">Teknik Destek</span>
                    </div>
                    <div class="istatistik_item">
                        <span class="istatistik_sayi">Hızlı</span>
                        <span class="istatistik_label">Teslimat Süresi</span>
                    </div>
                    <div class="istatistik_item">
                        <span class="istatistik_sayi">Güvenli</span>
                        <span class="istatistik_label">Altyapı</span>
                    </div>
                </div>
                
                <div style="margin-top: 40px; padding: 25px; background: #f9f9f9; border-radius: 5px; border-left: 5px solid #63207c;">
                    <h3 style="color: #63207c; margin-bottom: 15px;">💬 Bizimle Çalışmak İster misiniz?</h3>
                    <p style="font-style: italic; line-height: 1.8; color: #666;">
                        "Bu proje gibi sizin hayalinizdeki projeyi de gerçeğe dönüştürebiliriz. Profesyonel ekibimizle tanışmak ve projeniz için özel teklif almak için hemen iletişime geçin."
                    </p>
                    <div style="margin-top: 20px;">
                        <a href="iletisim.aspx" class="cta_btn" style="display:inline-block; background:#63207c; color:white; padding:10px 20px; text-decoration:none; border-radius:5px;">Teklif Alın</a>
                    </div>
                </div>

            </div>
        </asp:Panel>
        
        <a href="projeler.aspx" class="geri_buton">← Tüm Projelere Dön</a>
    </div>
</asp:Content>