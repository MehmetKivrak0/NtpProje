<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ekip.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.ekip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
<link href="../css/ekip.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 ekip_container">
	<!-- Hero Bölümü -->
	<div class="ekip_hero">
		<h1>Ekibimiz</h1>
		<p>Deneyimli ve tutkulu yazılım profesyonellerinden oluşan ekibimizle, projelerinizi başarıyla hayata geçiriyoruz. Her biri alanında uzman ekip üyelerimiz ile çözüm ortağınızız.</p>
	</div>
	
	<!-- Ekip Grid -->
	<div class="ekip_grid">
		<asp:Repeater ID="rptEkip" runat="server">
			<ItemTemplate>
				<div class="ekip_item">
					<div class="ekip_foto">
						<asp:Image ID="imgEkip" runat="server" ImageUrl='<%# Eval("Foto") %>' 
							AlternateText='<%# Eval("Isim") %>' />
					</div>
					<div class="ekip_isim"><%# Eval("Isim") %></div>
					<div class="ekip_pozisyon"><%# Eval("Pozisyon") %></div>
					<div class="ekip_aciklama"><%# Eval("Aciklama") %></div>
				</div>
			</ItemTemplate>
		</asp:Repeater>
	</div>
	
	<!-- İstatistikler -->
	<div class="ekip_istatistik">
		<h2 class="ekip_istatistik_baslik">Ekip İstatistiklerimiz</h2>
		<div class="ekip_istatistik_grid">
			<div class="ekip_istatistik_item">
				<asp:Label ID="lblEkipUyesi" runat="server" CssClass="ekip_istatistik_sayi" Text="50+"></asp:Label>
				<span class="ekip_istatistik_label">Ekip Üyesi</span>
			</div>
			<div class="ekip_istatistik_item">
				<asp:Label ID="lblSeniorDeveloper" runat="server" CssClass="ekip_istatistik_sayi" Text="15+"></asp:Label>
				<span class="ekip_istatistik_label">Senior Developer</span>
			</div>
			<div class="ekip_istatistik_item">
				<asp:Label ID="lblSertifikasyon" runat="server" CssClass="ekip_istatistik_sayi" Text="20+"></asp:Label>
				<span class="ekip_istatistik_label">Sertifikasyon</span>
			</div>
			<div class="ekip_istatistik_item">
				<asp:Label ID="lblMotivasyon" runat="server" CssClass="ekip_istatistik_sayi" Text="100%"></asp:Label>
				<span class="ekip_istatistik_label">Motivasyon</span>
			</div>
		</div>
	</div>
</div>
</asp:Content>
