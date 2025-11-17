<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hizmetler.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.hizmetler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/hizmetler.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 hizmetler_container">
	<!-- Hero Bölümü -->
	<div class="hizmetler_hero">
		<h1>Yazılım Hizmetlerimiz</h1>
		<p>Modern teknolojiler ve en iyi uygulamalarla, işletmenizin dijital dönüşümünde yanınızdayız. İhtiyaçlarınıza özel, ölçeklenebilir ve güvenli yazılım çözümleri sunuyoruz.</p>
	</div>
	
	<!-- Hizmet Grid -->
	<div class="hizmet_grid">
		<asp:Repeater ID="rptHizmetler" runat="server" OnItemDataBound="rptHizmetler_ItemDataBound">
			<ItemTemplate>
				<div class="hizmet_card" id='<%# Eval("Id") %>'>
					<div class="hizmet_icon"><%# Eval("Icon") %></div>
					<h2 class="hizmet_card_baslik"><%# Eval("Baslik") %></h2>
					<p class="hizmet_card_aciklama">
						<%# Eval("Aciklama") %>
					</p>
					<div class="hizmet_features">
						<asp:Repeater ID="rptFeatures" runat="server">
							<ItemTemplate>
								<div class="hizmet_feature_item"><%# Container.DataItem %></div>
							</ItemTemplate>
						</asp:Repeater>
					</div>
					<a href='<%# "hizmet_detay.aspx?id=" + Eval("Id") %>' class="hizmet_detay_link">Detaylı Bilgi</a>
				</div>
			</ItemTemplate>
		</asp:Repeater>
	</div>
	
	<!-- Neden Biz -->
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
	
	<!-- CTA -->
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
