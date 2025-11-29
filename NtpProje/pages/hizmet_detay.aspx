<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hizmet_detay.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.hizmet_detay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/hizmet_detay.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1" style="padding:20px 0px;">
	<a href="hizmetler.aspx" class="geri_buton">← Tüm Hizmetlere Dön</a>
	
	<div class="hizmet_detay_wrapper">
		<!-- Hizmet Başlık -->
		<div class="hizmet_baslik">
			<asp:Literal ID="hizmetBaslik" runat="server"></asp:Literal>
		</div>
		
		<!-- Hizmet Özet -->
		<div class="hizmet_ozet">
			<asp:Literal ID="hizmetOzet" runat="server"></asp:Literal>
		</div>
		
		<!-- Ana Görsel -->
		<div class="hizmet_ana_gorsel">
			<asp:Literal ID="hizmetAnaGorsel" runat="server"></asp:Literal>
		</div>
		
		<!-- Hizmet Detay İçerik -->
		<div class="hizmet_detay_icerik">
			<asp:Literal ID="hizmetDetayIcerik" runat="server"></asp:Literal>
			
			<asp:PlaceHolder ID="phFeatures" runat="server" Visible="false">
				<h3>🎯 Neler Sunuyoruz?</h3>
				<div class="ozellik_grid">
					<asp:Repeater ID="rptFeatures" runat="server">
						<ItemTemplate>
							<div class="ozellik_item">
								<div class="ozellik_icon"><%# Eval("Icon") %></div>
								<div class="ozellik_baslik"><%# Eval("Title") %></div>
								<div class="ozellik_aciklama"><%# Eval("Description") %></div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</asp:PlaceHolder>
			
			<asp:PlaceHolder ID="phTechnologies" runat="server" Visible="false">
				<h3>💻 Kullandığımız Teknolojiler</h3>
				<asp:Repeater ID="rptTechnologies" runat="server" OnItemDataBound="rptTechnologies_ItemDataBound">
					<ItemTemplate>
						<div class="teknoloji_kategori">
							<div class="tek_kategori_baslik"><%# Eval("Category") %></div>
							<div class="teknoloji_listesi">
								<asp:Repeater ID="rptTechItems" runat="server">
									<ItemTemplate>
										<span class="teknoloji_badge"><%# Container.DataItem %></span>
									</ItemTemplate>
								</asp:Repeater>
							</div>
						</div>
					</ItemTemplate>
				</asp:Repeater>
			</asp:PlaceHolder>
			
			<asp:PlaceHolder ID="phProcessSteps" runat="server" Visible="false">
				<h3>🔄 Geliştirme Sürecimiz</h3>
				<div class="surec_timeline">
					<asp:Repeater ID="rptProcessSteps" runat="server">
						<ItemTemplate>
							<div class="surec_item">
								<div class="surec_numara"><%# Container.ItemIndex + 1 %></div>
								<div class="surec_detay">
									<div class="surec_baslik"><%# Eval("Title") %></div>
									<div class="surec_aciklama"><%# Eval("Description") %></div>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</asp:PlaceHolder>
			
			<asp:PlaceHolder ID="phHighlightFeatures" runat="server" Visible="false">
				<h3>✨ Öne Çıkan Özellikler</h3>
				<ul class="ozellik_liste">
					<asp:Repeater ID="rptHighlightFeatures" runat="server">
						<ItemTemplate>
							<li><strong><%# Eval("Title") %>:</strong> <%# Eval("Description") %></li>
						</ItemTemplate>
					</asp:Repeater>
				</ul>
			</asp:PlaceHolder>
			
			<asp:PlaceHolder ID="phWhyChooseUs" runat="server" Visible="false">
				<h3>📈 Neden Bizi Tercih Etmelisiniz?</h3>
				<div class="tercih_kutusu">
					<asp:Repeater ID="rptWhyChooseUs" runat="server">
						<ItemTemplate>
							<div class="tercih_item">
								<div class="tercih_icon">✅</div>
								<div class="tercih_text"><strong><%# Eval("Title") %>:</strong> <%# Eval("Description") %></div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</asp:PlaceHolder>
			
			<div class="iletisim_cta">
				<h3>Projenizi Hayata Geçirelim!</h3>
				<p>Web geliştirme ihtiyaçlarınız için bizimle iletişime geçin. Ücretsiz danışmanlık ve proje teklifi alın.</p>
				<div class="cta_butonlar">
					<a href="iletisim.aspx" class="cta_btn primary">Teklif Alın</a>
					<a href="projeler.aspx" class="cta_btn secondary">Projelerimiz</a>
				</div>
			</div>
		</div>
		
		<!-- Başarı İstatistikleri -->
		<div class="istatistik_container">
			<div class="istatistik_baslik">Başarı İstatistiklerimiz</div>
			<div class="istatistik_grid">
				<div class="istatistik_card">
					<div class="istatistik_sayi">150+</div>
					<div class="istatistik_label">Tamamlanan Web Projesi</div>
				</div>
				<div class="istatistik_card">
					<div class="istatistik_sayi">95%</div>
					<div class="istatistik_label">Müşteri Memnuniyeti</div>
				</div>
				<div class="istatistik_card">
					<div class="istatistik_sayi">24/7</div>
					<div class="istatistik_label">Teknik Destek</div>
				</div>
				<div class="istatistik_card">
					<div class="istatistik_sayi">10+</div>
					<div class="istatistik_label">Yıl Deneyim</div>
				</div>
			</div>
		</div>
	</div>
	
	<a href="hizmetler.aspx" class="geri_buton">← Tüm Hizmetlere Dön</a>
</div>
</asp:Content>
