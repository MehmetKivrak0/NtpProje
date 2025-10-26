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
		<!-- Proje 1: E-Ticaret -->
		<div class="proje_card">
			<div class="proje_card_image">
				<span class="proje_kategori_badge">E-Ticaret</span>
				<a href="proje_detay.html">
					<img src="../example/1_s.jpg" alt="E-Ticaret Platformu" />
				</a>
			</div>
			<div class="proje_card_content">
				<h3 class="proje_card_baslik">E-Ticaret Platformu</h3>
				<p class="proje_card_aciklama">
					Modern ve responsive e-ticaret platformu. Ödeme sistemi entegrasyonu, 
					admin paneli ve gelişmiş stok yönetimi özellikleriyle tam kapsamlı çözüm.
				</p>
				<div class="proje_card_footer">
					<div class="proje_teknolojiler">
						<span class="teknoloji_tag">ASP.NET</span>
						<span class="teknoloji_tag">React</span>
						<span class="teknoloji_tag">SQL</span>
					</div>
					<a href="proje_detay.html" class="proje_detay_btn">
						Detaylı İncele <span class="proje_detay_icon">→</span>
					</a>
				</div>
			</div>
		</div>
		
		<!-- Proje 2: Mobil App -->
		<div class="proje_card">
			<div class="proje_card_image">
				<span class="proje_kategori_badge">Mobil Uygulama</span>
				<a class="grup1" href="../example/2_b.jpg">
					<img src="../example/2_s.jpg" alt="Mobil Bankacılık App" />
				</a>
			</div>
			<div class="proje_card_content">
				<h3 class="proje_card_baslik">Mobil Bankacılık Uygulaması</h3>
				<p class="proje_card_aciklama">
					iOS ve Android platformları için geliştirilmiş güvenli bankacılık uygulaması. 
					Biometric authentication ve end-to-end şifreleme.
				</p>
				<div class="proje_card_footer">
					<div class="proje_teknolojiler">
						<span class="teknoloji_tag">React Native</span>
						<span class="teknoloji_tag">Node.js</span>
					</div>
					<a class="grup1" href="../example/2_b.jpg" class="proje_detay_btn">
						Görseli Büyüt <span class="proje_detay_icon">🔍</span>
					</a>
				</div>
			</div>
		</div>
		
		<!-- Proje 3: ERP -->
		<div class="proje_card">
			<div class="proje_card_image">
				<span class="proje_kategori_badge">Kurumsal Yazılım</span>
				<a class="grup1" href="../example/3_b.jpg">
					<img src="../example/3_s.jpg" alt="ERP Sistemi" />
				</a>
			</div>
			<div class="proje_card_content">
				<h3 class="proje_card_baslik">Kurumsal ERP Sistemi</h3>
				<p class="proje_card_aciklama">
					500+ kullanıcılı entegre ERP sistemi. Finans, İK, stok, 
					üretim modülleriyle tam kapsamlı işletme yönetim çözümü.
				</p>
				<div class="proje_card_footer">
					<div class="proje_teknolojiler">
						<span class="teknoloji_tag">.NET Core</span>
						<span class="teknoloji_tag">Angular</span>
						<span class="teknoloji_tag">PostgreSQL</span>
					</div>
					<a class="grup1" href="../example/3_b.jpg" class="proje_detay_btn">
						Görseli Büyüt <span class="proje_detay_icon">🔍</span>
					</a>
				</div>
			</div>
		</div>
		
		<!-- Proje 4: Web Portal -->
		<div class="proje_card">
			<div class="proje_card_image">
				<span class="proje_kategori_badge">Web Geliştirme</span>
				<a class="grup1" href="../example/4_b.jpg">
					<img src="../example/4_s.jpg" alt="Web Portal" />
				</a>
			</div>
			<div class="proje_card_content">
				<h3 class="proje_card_baslik">Kurumsal Web Portalı</h3>
				<p class="proje_card_aciklama">
					Çok dilli kurumsal web sitesi ve gelişmiş yönetim paneli. 
					SEO optimizasyonu ve analytics entegrasyonu ile profesyonel çözüm.
				</p>
				<div class="proje_card_footer">
					<div class="proje_teknolojiler">
						<span class="teknoloji_tag">Vue.js</span>
						<span class="teknoloji_tag">Laravel</span>
						<span class="teknoloji_tag">MySQL</span>
					</div>
					<a class="grup1" href="../example/4_b.jpg" class="proje_detay_btn">
						Görseli Büyüt <span class="proje_detay_icon">🔍</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- İstatistikler -->
	<div class="projeler_istatistik">
		<div class="istatistik_grid">
			<div class="istatistik_item">
				<span class="istatistik_sayi">150+</span>
				<span class="istatistik_label">Tamamlanan Proje</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">200+</span>
				<span class="istatistik_label">Mutlu Müşteri</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">95%</span>
				<span class="istatistik_label">Müşteri Memnuniyeti</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">10+</span>
				<span class="istatistik_label">Yıl Deneyim</span>
			</div>
		</div>
	</div>
	
	<!-- CTA -->
	<div class="proje_cta">
		<h2>Projeniz İçin Teklif Alın</h2>
		<p>Hayalinizdeki projeyi birlikte gerçeğe dönüştürelim. Ücretsiz danışmanlık ve proje teklifi için bizimle iletişime geçin.</p>
		<a href="iletisim.html" class="cta_btn">İletişime Geçin</a>
	</div>
</div>

</asp:Content>
