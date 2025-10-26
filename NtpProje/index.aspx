<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 index_container">
        <!-- Hizmetler Özet -->
        <div class="hizmetler_ozet" >
            <h2 class="section_baslik">Yazılım Hizmetlerimiz</h2>
            <p class="section_alt_baslik">Modern teknolojiler ve en iyi uygulamalarla işletmenizin dijital dönüşümünde yanınızdayız</p>
            
            <div class="hizmet_ozet_grid" style="margin-top:150px">
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">💻</span>
                    <h3>Web Geliştirme</h3>
                    <p>Responsive ve SEO uyumlu web siteleri, web uygulamaları</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">📱</span>
                    <h3>Mobil Uygulama</h3>
                    <p>iOS ve Android için native ve hybrid mobil uygulamalar</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">🏢</span>
                    <h3>ERP Yazılımları</h3>
                    <p>Kurumsal kaynak planlama ve işletme yönetim sistemleri</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">🛒</span>
                    <h3>E-Ticaret</h3>
                    <p>Tam kapsamlı e-ticaret platformları ve online satış çözümleri</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">⚙️</span>
                    <h3>Özel Yazılım</h3>
                    <p>İhtiyaçlarınıza özel tasarlanmış yazılım çözümleri</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">☁️</span>
                    <h3>Cloud Çözümleri</h3>
                    <p>Azure, AWS ve Google Cloud platformlarında bulut hizmetleri</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">🤖</span>
                    <h3>Yapay Zeka</h3>
                    <p>Machine Learning ve AI entegrasyonu hizmetleri</p>
                </div>
                <div class="hizmet_ozet_card">
                    <span class="hizmet_ozet_icon">💡</span>
                    <h3>Danışmanlık</h3>
                    <p>Teknoloji danışmanlığı ve dijital dönüşüm desteği</p>
                </div>
            </div>

            <div style="text-align: center;">
                <a href="pages/hizmetler.html" class="tumunu_gor_btn">Tüm Hizmetlerimiz →</a>
            </div>
        </div>


        <!-- Son Blog Yazıları -->
        <div class="blog_ozet_section">
            <h2 class="section_baslik">Son Blog Yazılarımız</h2>
            <p class="section_alt_baslik">Teknoloji ve yazılım dünyasından son haberler</p>

            <div class="blog_ozet_grid">
                <div class="blog_ozet_card">
                    <a href="pages/blog_detay.html">
                        <div class="blog_ozet_gorsel">
                            <img src="example/1_s.jpg" alt="ASP.NET Core" />
                        </div>
                        <div class="blog_ozet_icerik">
                            <h3 class="blog_ozet_baslik">ASP.NET Core 8.0 ile Modern Web Uygulamaları</h3>
                            <p class="blog_ozet_meta">📅 15 Ekim 2025 | ✍️ Ahmet Yılmaz</p>
                            <p class="blog_ozet_text">ASP.NET Core 8.0 ile gelen yenilikler ve performans iyileştirmeleri...</p>
                        </div>
                    </a>
                </div>
                <div class="blog_ozet_card">
                    <a href="pages/blog_detay.html">
                        <div class="blog_ozet_gorsel">
                            <img src="example/2_s.jpg" alt="Microservices" />
                        </div>
                        <div class="blog_ozet_icerik">
                            <h3 class="blog_ozet_baslik">Microservices Mimarisine Geçiş</h3>
                            <p class="blog_ozet_meta">📅 10 Ekim 2025 | ✍️ Mehmet Kaya</p>
                            <p class="blog_ozet_text">Monolitik yapıdan microservices geçiş sürecinde dikkat edilecekler...</p>
                        </div>
                    </a>
                </div>
                <div class="blog_ozet_card">
                    <a href="pages/blog_detay.html">
                        <div class="blog_ozet_gorsel">
                            <img src="example/3_s.jpg" alt="React" />
                        </div>
                        <div class="blog_ozet_icerik">
                            <h3 class="blog_ozet_baslik">React 18 ile Modern Frontend</h3>
                            <p class="blog_ozet_meta">📅 5 Ekim 2025 | ✍️ Zeynep Özkan</p>
                            <p class="blog_ozet_text">React 18'in getirdiği yenilikler ve concurrent rendering...</p>
                        </div>
                    </a>
                </div>
            </div>

            <div style="text-align: center;">
                <a href="pages/blog.aspx" class="tumunu_gor_btn">Tüm Blog Yazılarımız →</a>
            </div>
        </div>

        <!-- CTA Bölümü -->
        <div class="cta_section">
            <h2>Projeniz İçin Ücretsiz Teklif Alın</h2>
            <p>Hayalinizdeki yazılım projesini birlikte gerçeğe dönüştürelim. Uzman ekibimiz size en uygun çözümü sunmak için hazır.</p>
            <a href="pages/iletisim.aspx" class="cta_btn">Hemen İletişime Geçin</a>
        </div>
    </div>








</asp:Content>

