<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="proje_detay.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.proje_detay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/proje_detay.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1" style="padding:20px 0px;">
	<a href="projeler.html" class="geri_buton">← Tüm Projelere Dön</a>
	
	<div class="proje_detay_wrapper">
		<div class="proje_baslik">E-Ticaret Platformu - TechMart Online Satış Sitesi</div>
		
		<div class="proje_meta">
			<div class="proje_meta_item">
				<span class="proje_meta_label">Müşteri:</span>
				<span>TechMart A.Ş.</span>
			</div>
			<div class="proje_meta_item">
				<span class="proje_meta_label">Kategori:</span>
				<span>E-Ticaret & Web Geliştirme</span>
			</div>
			<div class="proje_meta_item">
				<span class="proje_meta_label">Tamamlanma:</span>
				<span>Eylül 2024</span>
			</div>
			<div class="proje_meta_item">
				<span class="proje_meta_label">Süre:</span>
				<span>6 Ay</span>
			</div>
			<div class="proje_meta_item">
				<span class="proje_meta_label">Ekip:</span>
				<span>8 Kişi</span>
			</div>
			<div class="clear"></div>
		</div>
		
		<div class="proje_ana_gorsel">
			<img src="../example/1_b.jpg" alt="E-Ticaret Platformu" />
		</div>
		
		<div class="proje_icerik">
			<h3>📋 Proje Hakkında</h3>
			<p>
				TechMart A.Ş. için geliştirdiğimiz bu e-ticaret platformu, modern web teknolojileri kullanılarak sıfırdan tasarlanmış, ölçeklenebilir ve kullanıcı dostu bir online satış sistemidir. Proje, günlük binlerce ziyaretçiye hizmet verebilecek altyapıya sahiptir.
			</p>
			<p>
				Platform, responsive (mobil uyumlu) tasarımı, hızlı yükleme süreleri ve sezgisel kullanıcı arayüzü ile kullanıcı deneyimini ön planda tutar. Ayrıca güçlü admin paneli sayesinde ürün, kategori, sipariş ve müşteri yönetimi kolaylıkla yapılabilmektedir.
			</p>
			
			<h3>🎯 Proje Hedefleri</h3>
			<ul>
				<li>Modern ve kullanıcı dostu bir e-ticaret deneyimi sunmak</li>
				<li>Yüksek performanslı ve ölçeklenebilir bir altyapı kurmak</li>
				<li>Güvenli ödeme sistemleri entegrasyonu sağlamak</li>
				<li>Mobil cihazlarda mükemmel performans elde etmek</li>
				<li>SEO optimizasyonu ile organik trafiği artırmak</li>
				<li>Kapsamlı admin paneli ile kolay yönetim sağlamak</li>
			</ul>
			
			<h3>💻 Kullanılan Teknolojiler</h3>
			<div style="margin: 20px 0;">
				<span class="teknoloji_badge">ASP.NET Core 8.0</span>
				<span class="teknoloji_badge">C#</span>
				<span class="teknoloji_badge">Entity Framework Core</span>
				<span class="teknoloji_badge">SQL Server</span>
				<span class="teknoloji_badge">React.js</span>
				<span class="teknoloji_badge">Redux</span>
				<span class="teknoloji_badge">Bootstrap 5</span>
				<span class="teknoloji_badge">jQuery</span>
				<span class="teknoloji_badge">RESTful API</span>
				<span class="teknoloji_badge">SignalR</span>
				<span class="teknoloji_badge">Redis Cache</span>
				<span class="teknoloji_badge">Azure</span>
			</div>
			
			<h3>⚙️ Özellikler</h3>
			<ul>
				<li><strong>Kullanıcı Yönetimi:</strong> Üyelik sistemi, profil yönetimi, sipariş geçmişi</li>
				<li><strong>Ürün Kataloğu:</strong> Kategorize edilmiş ürünler, gelişmiş arama ve filtreleme</li>
				<li><strong>Sepet & Ödeme:</strong> Güvenli sepet yönetimi, çoklu ödeme seçenekleri (Kredi Kartı, Havale, Kapıda Ödeme)</li>
				<li><strong>Sipariş Takibi:</strong> Gerçek zamanlı sipariş durumu takibi, kargo entegrasyonu</li>
				<li><strong>Admin Panel:</strong> Ürün, kategori, sipariş, kullanıcı, rapor yönetimi</li>
				<li><strong>Kampanya Yönetimi:</strong> İndirim kodları, kampanyalar, özel fiyatlandırma</li>
				<li><strong>Stok Yönetimi:</strong> Otomatik stok takibi ve uyarı sistemi</li>
				<li><strong>Multi-Currency:</strong> Çoklu para birimi desteği (TRY, USD, EUR)</li>
				<li><strong>SEO Optimizasyonu:</strong> URL yeniden yazma, meta etiketleri, sitemap</li>
				<li><strong>Analytics:</strong> Google Analytics entegrasyonu, detaylı raporlama</li>
			</ul>
			
			<h3>🔐 Güvenlik</h3>
			<p>
				Proje geliştirilirken güvenlik en önemli önceliğimizdi. SSL/TLS şifreleme, OWASP Top 10 güvenlik standartları, SQL Injection koruması, XSS ve CSRF koruması gibi güvenlik önlemleri uygulanmıştır. Ödeme bilgileri PCI-DSS uyumlu olarak işlenmektedir.
			</p>
			
			<h3>📱 Responsive Tasarım</h3>
			<p>
				Platform, tüm cihazlarda (masaüstü, tablet, mobil) sorunsuz çalışacak şekilde tasarlanmıştır. Mobil kullanıcı deneyimi optimize edilmiş ve sayfa yükleme süreleri minimum seviyeye indirilmiştir.
			</p>
			
			<div class="proje_sonuc">
				<div class="proje_sonuc_baslik">🎉 Proje Sonuçları ve Başarılar</div>
				<p>
					Proje canlıya alındıktan sonra ilk 3 ayda müşterimizin online satışlarında %350 artış gözlemlendi. Sayfa yükleme süreleri %60 oranında iyileştirildi. Mobil dönüşüm oranı %85 arttı. Müşteri memnuniyeti skoru 4.8/5.0 seviyesine ulaştı.
				</p>
			</div>
		</div>
		
		<div class="istatistik_wrapper">
			<div class="istatistik_item">
				<span class="istatistik_sayi">10K+</span>
				<span class="istatistik_label">Günlük Ziyaretçi</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">5000+</span>
				<span class="istatistik_label">Aktif Ürün</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">350%</span>
				<span class="istatistik_label">Satış Artışı</span>
			</div>
			<div class="istatistik_item">
				<span class="istatistik_sayi">99.9%</span>
				<span class="istatistik_label">Uptime</span>
			</div>
		</div>
		
		<div class="proje_galeri">
			<div class="proje_galeri_baslik">📸 Proje Görselleri</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/1_b.jpg" title="Ana Sayfa">
					<img src="../example/1_s.jpg" alt="Ana Sayfa" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/2_b.jpg" title="Ürün Listesi">
					<img src="../example/2_s.jpg" alt="Ürün Listesi" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/3_b.jpg" title="Ürün Detay">
					<img src="../example/3_s.jpg" alt="Ürün Detay" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/4_b.jpg" title="Sepet">
					<img src="../example/4_s.jpg" alt="Sepet" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/5_b.jpg" title="Ödeme Sayfası">
					<img src="../example/5_s.jpg" alt="Ödeme Sayfası" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/6_b.jpg" title="Admin Panel">
					<img src="../example/6_s.jpg" alt="Admin Panel" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/7_b.jpg" title="Sipariş Yönetimi">
					<img src="../example/7_s.jpg" alt="Sipariş Yönetimi" />
				</a>
			</div>
			<div class="galeri_item">
				<a class="galeri" href="../example/8_b.jpg" title="Raporlama">
					<img src="../example/8_s.jpg" alt="Raporlama" />
				</a>
			</div>
			<div class="clear"></div>
		</div>
		
		<div style="margin-top: 40px; padding: 25px; background: #f9f9f9; border-radius: 5px;">
			<h3 style="color: #63207c; margin-bottom: 15px;">💬 Müşteri Görüşü</h3>
			<p style="font-style: italic; line-height: 1.8; color: #666;">
				"Yazılım şirketinizle çalışmak harika bir deneyimdi. Ekibiniz profesyonel, iletişim sürekli ve şeffaftı. Beklentilerimizin üzerinde bir e-ticaret platformu teslim ettiler. Özellikle admin panelinin kullanım kolaylığı ve sistemin performansı bizi çok memnun etti. Satışlarımız ilk aydan itibaren ciddi oranda arttı. Kesinlikle tavsiye ediyoruz!"
			</p>
			<p style="margin-top: 15px; font-weight: bold; color: #63207c;">
				- Ahmet Yılmaz, TechMart A.Ş. Genel Müdürü
			</p>
		</div>
	</div>
	
	<a href="projeler.html" class="geri_buton">← Tüm Projelere Dön</a>
</div>
</asp:Content>
