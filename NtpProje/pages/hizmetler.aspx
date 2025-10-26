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
		<!-- Hizmet 1: Web Geliştirme -->
		<div class="hizmet_card" id="web">
			<div class="hizmet_icon">💻</div>
			<h2 class="hizmet_card_baslik">Web Geliştirme</h2>
			<p class="hizmet_card_aciklama">
				Modern ve responsive web siteleri, kurumsal web uygulamaları ve e-ticaret platformları geliştiriyoruz. 
				ASP.NET, React, Angular, Vue.js gibi teknolojilerle güçlü web çözümleri sunuyoruz.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Responsive ve SEO Uyumlu</div>
				<div class="hizmet_feature_item">Modern Framework'ler</div>
				<div class="hizmet_feature_item">Yüksek Performans</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 2: Mobil Uygulama -->
		<div class="hizmet_card" id="mobil">
			<div class="hizmet_icon">📱</div>
			<h2 class="hizmet_card_baslik">Mobil Uygulama Geliştirme</h2>
			<p class="hizmet_card_aciklama">
				iOS ve Android platformları için native ve cross-platform mobil uygulamalar. 
				React Native, Flutter ve Xamarin teknolojileriyle profesyonel mobil çözümler.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Native & Hybrid Uygulama</div>
				<div class="hizmet_feature_item">App Store & Google Play</div>
				<div class="hizmet_feature_item">Push Notification</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 3: ERP -->
		<div class="hizmet_card" id="erp">
			<div class="hizmet_icon">🏢</div>
			<h2 class="hizmet_card_baslik">ERP Yazılımları</h2>
			<p class="hizmet_card_aciklama">
				İşletmelerin tüm süreçlerini yöneten kurumsal kaynak planlama sistemleri. 
				Stok, finans, İK, üretim modülleriyle entegre ve ölçeklenebilir çözümler.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Entegre Modüller</div>
				<div class="hizmet_feature_item">Raporlama & Analytics</div>
				<div class="hizmet_feature_item">Multi-User Support</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 4: E-Ticaret -->
		<div class="hizmet_card" id="eticaret">
			<div class="hizmet_icon">🛒</div>
			<h2 class="hizmet_card_baslik">E-Ticaret Çözümleri</h2>
			<p class="hizmet_card_aciklama">
				B2C ve B2B e-ticaret platformları, ödeme sistemleri entegrasyonu, 
				kargo entegrasyonu ve stok yönetimi ile tam kapsamlı online satış çözümleri.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Ödeme Gateway Entegrasyonu</div>
				<div class="hizmet_feature_item">Stok & Sipariş Yönetimi</div>
				<div class="hizmet_feature_item">Admin Paneli</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 5: Özel Yazılım -->
		<div class="hizmet_card" id="ozel">
			<div class="hizmet_icon">⚙️</div>
			<h2 class="hizmet_card_baslik">Özel Yazılım Geliştirme</h2>
			<p class="hizmet_card_aciklama">
				İşletmenizin özel ihtiyaçlarına yönelik tasarlanmış yazılım çözümleri. 
				Mevcut sistemlerinizle entegre, ölçeklenebilir ve güvenli uygulamalar.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">İhtiyaç Analizi</div>
				<div class="hizmet_feature_item">Custom Development</div>
				<div class="hizmet_feature_item">Sistem Entegrasyonu</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 6: Cloud -->
		<div class="hizmet_card" id="cloud">
			<div class="hizmet_icon">☁️</div>
			<h2 class="hizmet_card_baslik">Cloud Çözümleri</h2>
			<p class="hizmet_card_aciklama">
				Azure, AWS ve Google Cloud platformlarında bulut altyapı kurulumu, 
				migrasyonu ve yönetimi. DevOps ve CI/CD süreçleri ile hızlı deployment.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Cloud Migration</div>
				<div class="hizmet_feature_item">DevOps & CI/CD</div>
				<div class="hizmet_feature_item">Infrastructure as Code</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 7: AI -->
		<div class="hizmet_card" id="ai">
			<div class="hizmet_icon">🤖</div>
			<h2 class="hizmet_card_baslik">Yapay Zeka Entegrasyonu</h2>
			<p class="hizmet_card_aciklama">
				Machine Learning, Natural Language Processing, Computer Vision gibi 
				yapay zeka teknolojilerini uygulamalarınıza entegre ediyoruz.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Machine Learning</div>
				<div class="hizmet_feature_item">NLP & Computer Vision</div>
				<div class="hizmet_feature_item">ChatGPT Integration</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
		
		<!-- Hizmet 8: Danışmanlık -->
		<div class="hizmet_card" id="danismanlik">
			<div class="hizmet_icon">💡</div>
			<h2 class="hizmet_card_baslik">Yazılım Danışmanlığı</h2>
			<p class="hizmet_card_aciklama">
				Teknoloji seçimi, mimari tasarım, kod inceleme, performans optimizasyonu 
				ve dijital dönüşüm süreçlerinde profesyonel danışmanlık hizmetleri.
			</p>
			<div class="hizmet_features">
				<div class="hizmet_feature_item">Teknoloji Danışmanlığı</div>
				<div class="hizmet_feature_item">Code Review & Audit</div>
				<div class="hizmet_feature_item">Digital Transformation</div>
			</div>
			<a href="hizmet_detay.html" class="hizmet_detay_link">Detaylı Bilgi</a>
		</div>
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
			<a href="iletisim.html" class="cta_button primary">Teklif Alın</a>
			<a href="projeler.html" class="cta_button secondary">Projelerimizi İnceleyin</a>
		</div>
	</div>
</div>
</asp:Content>
