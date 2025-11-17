<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="projeler.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.projeler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/projeler.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 projeler_container">
	<!-- Başlık -->
	<div class="projeler_baslik">
		<h1>Tamamlanan Projelerimiz</h1>
		<p>150'den fazla başarılı projeye imza attık. İşte seçtiğimiz bazı öne çıkan çalışmalarımız.</p>
	</div>
	
	<!-- Proje Grid -->
	<div class="proje_grid">
		<asp:Repeater ID="rptProjeler" runat="server" OnItemDataBound="rptProjeler_ItemDataBound">
			<ItemTemplate>
				<div class="proje_card">
					<div class="proje_card_image">
						<span class="proje_kategori_badge"><%# Eval("Kategori") %></span>
						<a href='<%# "proje_detay.aspx?id=" + Eval("Id") %>'>
							<asp:Image ID="imgProje" runat="server" ImageUrl='<%# Eval("ResimKucuk") %>' 
								AlternateText='<%# Eval("Baslik") %>' />
						</a>
					</div>
					<div class="proje_card_content">
						<h3 class="proje_card_baslik"><%# Eval("Baslik") %></h3>
						<p class="proje_card_aciklama">
							<%# Eval("Aciklama") %>
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
	</div>
	
	<!-- İstatistikler -->
	<div class="projeler_istatistik">
		<div class="istatistik_grid">
			<div class="istatistik_item">
				<asp:Label ID="lblTamamlananProje" runat="server" CssClass="istatistik_sayi" Text="150+"></asp:Label>
				<span class="istatistik_label">Tamamlanan Proje</span>
			</div>
			<div class="istatistik_item">
				<asp:Label ID="lblMutluMusteri" runat="server" CssClass="istatistik_sayi" Text="200+"></asp:Label>
				<span class="istatistik_label">Mutlu Müşteri</span>
			</div>
			<div class="istatistik_item">
				<asp:Label ID="lblMusteriMemnuniyeti" runat="server" CssClass="istatistik_sayi" Text="95%"></asp:Label>
				<span class="istatistik_label">Müşteri Memnuniyeti</span>
			</div>
			<div class="istatistik_item">
				<asp:Label ID="lblYilDeneyim" runat="server" CssClass="istatistik_sayi" Text="10+"></asp:Label>
				<span class="istatistik_label">Yıl Deneyim</span>
			</div>
		</div>
	</div>
	
	<!-- CTA -->
	<div class="proje_cta">
		<h2>Projeniz İçin Teklif Alın</h2>
		<p>Hayalinizdeki projeyi birlikte gerçeğe dönüştürelim. Ücretsiz danışmanlık ve proje teklifi için bizimle iletişime geçin.</p>
		<a href="iletisim.aspx" class="cta_btn">İletişime Geçin</a>
	</div>
</div>

</asp:Content>
