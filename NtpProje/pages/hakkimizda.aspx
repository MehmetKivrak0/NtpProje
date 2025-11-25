<%@ Page Title="Hakkımızda" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hakkimizda.aspx.cs" Inherits="NtpProje_Web.Hakkimizda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/hakkimizda.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 hakkimizda_container">
        
        <div class="hakkimizda_hero">
            <h1>Hakkımızda</h1>
            <p>Yazılım sektöründe 10 yılı aşkın deneyimimizle, modern teknolojiler kullanarak işletmelerin dijital dönüşüm süreçlerinde yanlarında oluyoruz.</p>
        </div>

        <div class="hakkimizda_resim_card">
            <img src='<%= ResolveUrl("~/images/1.jpg") %>' alt="Ofisimiz" />
        </div>

        <div class="hakkimizda_icerik_card">
            <h2 class="hakkimizda_card_baslik">Biz Kimiz?</h2>
            <div class="hakkimizda_card_icerik">
                <asp:Literal ID="ltrKimlik" runat="server"></asp:Literal>
            </div>
        </div>

        <div class="vizyon_misyon_grid">
            <div class="vm_card">
                <span class="vm_icon">🎯</span>
                <h2 class="vm_baslik">Vizyonumuz</h2>
                <div class="vm_icerik">
                    <asp:Literal ID="ltrVizyon" runat="server"></asp:Literal>
                </div>
            </div>

            <div class="vm_card">
                <span class="vm_icon">🎖️</span>
                <h2 class="vm_baslik">Misyonumuz</h2>
                <div class="vm_icerik">
                    <asp:Literal ID="ltrMisyon" runat="server"></asp:Literal>
                </div>
            </div>
        </div>

        <div class="degerler_section">
            <h2 class="degerler_baslik">Değerlerimiz</h2>
            <div class="degerler_grid">
                <div class="deger_item">
                    <span class="deger_icon">💎</span>
                    <h3>Kalite</h3>
                    <p>Her projede en yüksek kalite standartlarını uygularız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🤝</span>
                    <h3>Güvenilirlik</h3>
                    <p>Sözleştiğimiz teslim tarihlerine ve kaliteye sadık kalırız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🚀</span>
                    <h3>İnovasyon</h3>
                    <p>Sürekli yeni teknolojiler ve yöntemler araştırırız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🎨</span>
                    <h3>Yaratıcılık</h3>
                    <p>Her projeye özgün ve yaratıcı çözümler üretiriz</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">📈</span>
                    <h3>Büyüme</h3>
                    <p>Müşterilerimizin büyümesine katkı sağlarız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🌟</span>
                    <h3>Mükemmellik</h3>
                    <p>Her detayda mükemmelliği hedefleriz</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>