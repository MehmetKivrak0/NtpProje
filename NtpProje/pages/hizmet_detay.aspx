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
			<span class="hizmet_icon">💻</span>
			Web Geliştirme Hizmeti
		</div>
		
		<!-- Hizmet Özet -->
		<div class="hizmet_ozet">
			Modern, responsive ve performanslı web siteleri ve web uygulamaları geliştiriyoruz. 
			En güncel teknolojiler ve best practice'ler ile projelerinizi hayata geçiriyoruz.
		</div>
		
		<!-- Ana Görsel -->
		<div class="hizmet_ana_gorsel">
			<img src="../example/1_b.jpg" alt="Web Geliştirme" />
		</div>
		
		<!-- Hizmet Detay İçerik -->
		<div class="hizmet_detay_icerik">
			<h2>Web Geliştirme Hizmetimiz</h2>
			<p>
				Modern web teknolojileri kullanarak, işletmenizin ihtiyaçlarına özel, ölçeklenebilir ve güvenli web çözümleri geliştiriyoruz. Kurumsal web siteleri, e-ticaret platformları, web uygulamaları ve SaaS (Software as a Service) projeleri konusunda uzmanız.
			</p>
			<p>
				Projelerimizde kullanıcı deneyimini (UX) ön planda tutarak, SEO uyumlu, hızlı yüklenen ve tüm cihazlarda sorunsuz çalışan web siteleri tasarlıyoruz.
			</p>
			
			<h3>🎯 Neler Sunuyoruz?</h3>
			<div class="ozellik_grid">
				<div class="ozellik_item">
					<div class="ozellik_icon">🏢</div>
					<div class="ozellik_baslik">Kurumsal Web Siteleri</div>
					<div class="ozellik_aciklama">Şirketinizi en iyi şekilde temsil eden, profesyonel ve etkileyici kurumsal web siteleri</div>
				</div>
				<div class="ozellik_item">
					<div class="ozellik_icon">🛒</div>
					<div class="ozellik_baslik">E-Ticaret Platformları</div>
					<div class="ozellik_aciklama">Ödeme entegrasyonları, stok yönetimi ve admin paneli ile tam kapsamlı e-ticaret çözümleri</div>
				</div>
				<div class="ozellik_item">
					<div class="ozellik_icon">⚡</div>
					<div class="ozellik_baslik">Web Uygulamaları</div>
					<div class="ozellik_aciklama">React, Angular, Vue.js gibi modern framework'lerle SPA (Single Page Application) geliştirme</div>
				</div>
				<div class="ozellik_item">
					<div class="ozellik_icon">📊</div>
					<div class="ozellik_baslik">Dashboard & Admin Panel</div>
					<div class="ozellik_aciklama">Verilerinizi yönetmek için kullanıcı dostu, güçlü admin panelleri ve dashboard'lar</div>
				</div>
				<div class="ozellik_item">
					<div class="ozellik_icon">🔌</div>
					<div class="ozellik_baslik">API Geliştirme</div>
					<div class="ozellik_aciklama">RESTful API ve GraphQL ile backend servisleri ve microservices mimarisi</div>
				</div>
				<div class="ozellik_item">
					<div class="ozellik_icon">📱</div>
					<div class="ozellik_baslik">Responsive Tasarım</div>
					<div class="ozellik_aciklama">Tüm cihazlarda (mobil, tablet, desktop) mükemmel görünüm ve performans</div>
				</div>
			</div>
			
			<h3>💻 Kullandığımız Teknolojiler</h3>
			<div class="teknoloji_kategori">
				<div class="tek_kategori_baslik">Frontend</div>
				<div class="teknoloji_listesi">
					<span class="teknoloji_badge">HTML5</span>
					<span class="teknoloji_badge">CSS3</span>
					<span class="teknoloji_badge">JavaScript</span>
					<span class="teknoloji_badge">TypeScript</span>
					<span class="teknoloji_badge">React</span>
					<span class="teknoloji_badge">Angular</span>
					<span class="teknoloji_badge">Vue.js</span>
					<span class="teknoloji_badge">Bootstrap</span>
					<span class="teknoloji_badge">Tailwind CSS</span>
				</div>
			</div>
			
			<div class="teknoloji_kategori">
				<div class="tek_kategori_baslik">Backend</div>
				<div class="teknoloji_listesi">
					<span class="teknoloji_badge">ASP.NET Core</span>
					<span class="teknoloji_badge">Node.js</span>
					<span class="teknoloji_badge">Python (Django/Flask)</span>
					<span class="teknoloji_badge">PHP (Laravel)</span>
					<span class="teknoloji_badge">Java (Spring Boot)</span>
				</div>
			</div>
			
			<div class="teknoloji_kategori">
				<div class="tek_kategori_baslik">Veritabanı</div>
				<div class="teknoloji_listesi">
					<span class="teknoloji_badge">SQL Server</span>
					<span class="teknoloji_badge">PostgreSQL</span>
					<span class="teknoloji_badge">MySQL</span>
					<span class="teknoloji_badge">MongoDB</span>
					<span class="teknoloji_badge">Redis</span>
				</div>
			</div>
			
			<h3>🔄 Geliştirme Sürecimiz</h3>
			<div class="surec_timeline">
				<div class="surec_item">
					<div class="surec_numara">1</div>
					<div class="surec_detay">
						<div class="surec_baslik">Analiz & Planlama</div>
						<div class="surec_aciklama">İhtiyaç analizi, proje kapsamı belirleme, teknoloji seçimi ve proje planı oluşturma</div>
					</div>
				</div>
				<div class="surec_item">
					<div class="surec_numara">2</div>
					<div class="surec_detay">
						<div class="surec_baslik">Tasarım (UI/UX)</div>
						<div class="surec_aciklama">Wireframe, mockup ve prototip hazırlama, kullanıcı deneyimi optimizasyonu</div>
					</div>
				</div>
				<div class="surec_item">
					<div class="surec_numara">3</div>
					<div class="surec_detay">
						<div class="surec_baslik">Geliştirme</div>
						<div class="surec_aciklama">Frontend ve backend geliştirme, API entegrasyonları, veritabanı tasarımı</div>
					</div>
				</div>
				<div class="surec_item">
					<div class="surec_numara">4</div>
					<div class="surec_detay">
						<div class="surec_baslik">Test & QA</div>
						<div class="surec_aciklama">Functional testing, performance testing, security testing ve bug fixing</div>
					</div>
				</div>
				<div class="surec_item">
					<div class="surec_numara">5</div>
					<div class="surec_detay">
						<div class="surec_baslik">Deployment</div>
						<div class="surec_aciklama">Production ortamına yayınlama, DNS ayarları, SSL sertifikası kurulumu</div>
					</div>
				</div>
				<div class="surec_item">
					<div class="surec_numara">6</div>
					<div class="surec_detay">
						<div class="surec_baslik">Destek & Bakım</div>
						<div class="surec_aciklama">Sürekli izleme, güncellemeler, teknik destek ve yeni özellik geliştirme</div>
					</div>
				</div>
			</div>
			
			<h3>✨ Öne Çıkan Özellikler</h3>
			<ul class="ozellik_liste">
				<li><strong>SEO Optimizasyonu:</strong> Arama motorlarında üst sıralarda yer almanız için SEO best practice'leri uyguluyoruz</li>
				<li><strong>Performans:</strong> Hızlı yükleme süreleri, optimize edilmiş kod ve caching stratejileri</li>
				<li><strong>Güvenlik:</strong> SSL sertifikası, güvenlik duvarı, XSS ve SQL Injection koruması</li>
				<li><strong>Responsive:</strong> Mobil, tablet ve desktop'ta mükemmel görünüm</li>
				<li><strong>CMS Entegrasyonu:</strong> WordPress, Drupal veya custom CMS çözümleri</li>
				<li><strong>Analytics:</strong> Google Analytics, heatmap ve kullanıcı davranış analizi</li>
				<li><strong>Ölçeklenebilirlik:</strong> Büyüyen işinizle birlikte büyüyen altyapı</li>
				<li><strong>Çoklu Dil Desteği:</strong> Multi-language web siteleri</li>
			</ul>
			
			<h3>📈 Neden Bizi Tercih Etmelisiniz?</h3>
			<div class="tercih_kutusu">
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>10+ Yıl Deneyim:</strong> Yüzlerce başarılı proje</div>
				</div>
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>Uzman Ekip:</strong> Sertifikalı ve deneyimli yazılımcılar</div>
				</div>
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>Zamanında Teslimat:</strong> Proje takvimlerine sadık kalıyoruz</div>
				</div>
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>Şeffaf İletişim:</strong> Sürekli bilgilendirme ve raporlama</div>
				</div>
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>Uygun Fiyat:</strong> Rekabetçi fiyatlarla kaliteli hizmet</div>
				</div>
				<div class="tercih_item">
					<div class="tercih_icon">✅</div>
					<div class="tercih_text"><strong>Sürekli Destek:</strong> 7/24 teknik destek hattı</div>
				</div>
			</div>
			
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
