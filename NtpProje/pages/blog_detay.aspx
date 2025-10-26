<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="blog_detay.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.blog_detay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/blog_detay.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1" style="padding: 20px 0px;">
        <a href="blog.aspx" class="geri_buton">← Tüm Blog Yazılarına Dön</a>

        <div class="blog_detay_wrapper">
            <!-- Blog Başlık ve Meta -->
            <div class="blog_detay_baslik">ASP.NET Core 8.0 ile Modern Web Uygulamaları</div>

            <div class="blog_detay_meta">
                <div class="blog_meta_item">
                    <span class="meta_icon">📅</span>
                    <span class="meta_label">Tarih:</span>
                    <span>15 Ekim 2025</span>
                </div>
                <div class="blog_meta_item">
                    <span class="meta_icon">✍️</span>
                    <span class="meta_label">Yazar:</span>
                    <span>Ahmet Yılmaz</span>
                </div>
                <div class="blog_meta_item">
                    <span class="meta_icon">📂</span>
                    <span class="meta_label">Kategori:</span>
                    <span>.NET, Web Development</span>
                </div>
                <div class="blog_meta_item">
                    <span class="meta_icon">⏱️</span>
                    <span class="meta_label">Okuma Süresi:</span>
                    <span>8 dk</span>
                </div>
                <div class="clear"></div>
            </div>

            <!-- Ana Görsel -->
            <div class="blog_ana_gorsel">
                <img src="../example/1_b.jpg" alt="ASP.NET Core 8.0" />
            </div>

            <!-- Kategoriler -->
            <div class="blog_kategoriler">
                <span class="blog_kategori_badge">.NET</span>
                <span class="blog_kategori_badge">Web Development</span>
                <span class="blog_kategori_badge">C#</span>
                <span class="blog_kategori_badge">ASP.NET Core</span>
            </div>

            <!-- Blog İçerik -->
            <div class="blog_detay_icerik">
                <h2>Giriş</h2>
                <p>
                    ASP.NET Core 8.0, Microsoft'un web geliştirme platformunun en son sürümü olarak karşımıza çıkıyor. Bu sürüm, performans iyileştirmeleri, yeni özellikler ve gelişmiş developer deneyimi sunuyor. Bu yazıda ASP.NET Core 8.0'ın getirdiği yenilikleri ve modern web uygulamaları geliştirmek için bilmeniz gereken her şeyi inceleyeceğiz.
                </p>

                <h2>ASP.NET Core 8.0'ın Yenilikleri</h2>
                <p>
                    ASP.NET Core 8.0 ile gelen en önemli yenilikler arasında performans optimizasyonları, Minimal API geliştirmeleri, Blazor'daki ilerlemeler ve cloud-native özellikler bulunuyor.
                </p>

                <h3>1. Performans İyileştirmeleri</h3>
                <p>
                    .NET 8, bir önceki sürüme göre %20-30 oranında daha hızlı çalışıyor. HTTP protokolü optimizasyonları, daha verimli memory kullanımı ve JIT compiler iyileştirmeleri bu performans artışının başlıca nedenleri.
                </p>

                <div class="kod_blogu">
                </div>

                <h3>2. Minimal API Geliştirmeleri</h3>
                <p>
                    Minimal API'ler, ASP.NET Core 6.0 ile tanıtılmıştı ancak 8.0 sürümünde önemli iyileştirmeler aldı. Artık daha karmaşık senaryolarda bile minimal API'leri kullanabiliyoruz. Route grouping, filters ve endpoint metadata desteği geliştirildi.
                </p>

                <ul>
                    <li>Route grupları ile daha organize endpoint tanımları</li>
                    <li>Built-in validation ve error handling</li>
                    <li>OpenAPI/Swagger entegrasyonu geliştirildi</li>
                    <li>Dependency injection tam desteği</li>
                </ul>

                <h3>3. Blazor Server & WebAssembly Geliştirmeleri</h3>
                <p>
                    Blazor, .NET ile full-stack web geliştirme yapmamızı sağlayan framework. 8.0 sürümüyle birlikte Blazor Server ve WebAssembly modeları arasında geçiş yapmak daha kolay hale geldi. Ayrıca yeni component model, improved rendering performance ve better JavaScript interop özellikleri eklendi.
                </p>

                <div class="bilgi_kutusu">
                    <h4>💡 İpucu</h4>
                    <p>Blazor WebAssembly ile SPA (Single Page Application) uygulamaları geliştirebilir, Blazor Server ile ise gerçek zamanlı uygulamalar oluşturabilirsiniz. Her ikisini de aynı kod tabanında kullanabilirsiniz!</p>
                </div>

                <h3>4. Native AOT (Ahead-of-Time) Compilation</h3>
                <p>
                    ASP.NET Core 8.0, Native AOT desteği sunuyor. Bu özellik sayesinde uygulamalarınız daha hızlı başlıyor, daha az memory tüketiyor ve konteyner boyutları küçülüyor. Özellikle mikroservis mimarileri için ideal.
                </p>

                <h2>Modern Web Uygulamaları İçin Best Practices</h2>

                <h3>1. Dependency Injection Kullanımı</h3>
                <p>
                    ASP.NET Core'un built-in DI container'ı çok güçlü. Servislerinizi doğru şekilde kaydetmek ve kullanmak, kodunuzun test edilebilirliğini ve maintainability'sini artırır.
                </p>

                <div class="kod_blogu">
                </div>

                <h3>2. Middleware Pipeline</h3>
                <p>
                    Middleware pipeline, HTTP request-response döngüsünün kalbidir. Authentication, authorization, logging, error handling gibi cross-cutting concerns'leri middleware olarak ekleyebilirsiniz.
                </p>

                <h3>3. Configuration Management</h3>
                <p>
                    appsettings.json, environment variables, user secrets ve Azure Key Vault gibi farklı konfigürasyon kaynaklarını kullanarak güvenli ve esnek konfigürasyon yönetimi sağlayın.
                </p>

                <h3>4. Logging ve Monitoring</h3>
                <p>
                    ILogger interface'ini kullanarak structured logging yapın. Serilog, NLog gibi kütüphanelerle entegre edin. Application Insights veya ELK Stack ile monitoring ve analytics sağlayın.
                </p>

                <h2>Güvenlik Önlemleri</h2>
                <p>
                    Modern web uygulamalarında güvenlik kritik öneme sahip. ASP.NET Core 8.0 şu güvenlik özelliklerini sunar:
                </p>

                <ul>
                    <li><strong>HTTPS Enforcement:</strong> Otomatik HTTPS yönlendirme</li>
                    <li><strong>CORS Policy:</strong> Cross-Origin Resource Sharing kontrolü</li>
                    <li><strong>Authentication & Authorization:</strong> JWT, OAuth 2.0, OpenID Connect desteği</li>
                    <li><strong>Data Protection:</strong> Şifreleme ve data koruma API'leri</li>
                    <li><strong>CSRF Protection:</strong> Cross-Site Request Forgery koruması</li>
                    <li><strong>XSS Prevention:</strong> Cross-Site Scripting koruması</li>
                </ul>

                <div class="uyari_kutusu">
                    <h4>⚠️ Güvenlik Uyarısı</h4>
                    <p>Hassas bilgileri (connection string, API key vb.) asla kod içinde tutmayın. User Secrets (development) ve Azure Key Vault (production) kullanın.</p>
                </div>

                <h2>Performance Optimization</h2>
                <p>
                    Uygulamanızın performansını artırmak için şu teknikleri kullanabilirsiniz:
                </p>

                <ul>
                    <li><strong>Response Caching:</strong> HTTP response'ları cache'leyin</li>
                    <li><strong>Output Caching:</strong> Sayfa çıktılarını cache'leyin</li>
                    <li><strong>Distributed Caching:</strong> Redis ile distributed cache</li>
                    <li><strong>Compression:</strong> Response compression middleware</li>
                    <li><strong>Async/Await:</strong> Asenkron programlama kullanın</li>
                    <li><strong>Connection Pooling:</strong> Database connection pool'u optimize edin</li>
                </ul>

                <h2>Cloud-Native Özellikler</h2>
                <p>
                    ASP.NET Core 8.0, cloud-native uygulamalar için ideal. Docker desteği, Kubernetes entegrasyonu, health checks, ve Azure servisleri ile seamless entegrasyon sunuyor.
                </p>

                <div class="kod_blogu">
                </div>

                <h2>Sonuç</h2>
                <p>
                    ASP.NET Core 8.0, modern web uygulamaları geliştirmek için gereken tüm özellikleri sunuyor. Performans, güvenlik, ölçeklenebilirlik ve developer experience açısından harika bir platform. 
                </p>
                <p>
                    Bu yazıda temel özellikleri ve best practice'leri inceledik. Daha detaylı öğrenmek için Microsoft'un resmi dokümantasyonunu takip etmenizi öneririm.
                </p>

                <div class="yazar_bilgi">
                    <div class="yazar_avatar">
                        <img src="../example/1_s.jpg" alt="Ahmet Yılmaz" />
                    </div>
                    <div class="yazar_detay">
                        <h4>Ahmet Yılmaz</h4>
                        <p>Genel Müdür & Kurucu - 15+ yıl yazılım geliştirme deneyimi. Microsoft MVP.</p>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>

            <!-- Paylaşım Butonları -->
            <div class="paylasim_alani">
                <div class="paylasim_baslik">Bu yazıyı paylaşın:</div>
                <div class="paylasim_butonlar">
                    <a href="#" class="paylasim_btn facebook">Facebook</a>
                    <a href="#" class="paylasim_btn twitter">Twitter</a>
                    <a href="#" class="paylasim_btn linkedin">LinkedIn</a>
                    <a href="#" class="paylasim_btn whatsapp">WhatsApp</a>
                </div>
            </div>

            <!-- İlgili Yazılar -->
            <div class="ilgili_yazilar">
                <h3 class="ilgili_baslik">İlgili Yazılar</h3>
                <div class="ilgili_yazi_item sol">
                    <a href="blog_detay.html">
                        <img src="../example/2_s.jpg" alt="Microservices" />
                        <div class="ilgili_yazi_baslik">Microservices Mimarisine Geçiş</div>
                    </a>
                </div>
                <div class="ilgili_yazi_item sol">
                    <a href="blog_detay.html">
                        <img src="../example/3_s.jpg" alt="React" />
                        <div class="ilgili_yazi_baslik">React 18 ile Modern Frontend</div>
                    </a>
                </div>
                <div class="ilgili_yazi_item sol">
                    <a href="blog_detay.html">
                        <img src="../example/4_s.jpg" alt="DevOps" />
                        <div class="ilgili_yazi_baslik">CI/CD Pipeline Kurulumu</div>
                    </a>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <a href="blog.aspx" class="geri_buton">← Tüm Blog Yazılarına Dön</a>
    </div>

    <div class="wrapper1">
        <div class="partner_yazi">
            <div style="border-bottom: 5px solid #63207c; width: 220px;">TEKNOLOJİ PARTNERLERİMİZ</div>
        </div>
        <div style="width: 100%; overflow: hidden;">
            <div style="width: 105%; margin-left: -7px;">
                <marquee direction="left" behavior="scroll" onmouseover="this.stop()" onmouseout="this.start()" scrollamount="3" width="100%">
                    <div class="referans_item" align="center">
                        <img src="../images/adobelogo.png" width="150" /></div>
                    <div class="referans_item" align="center">
                        <img src="../images/autodesk.jpeg" width="150" /></div>
                    <div class="referans_item" align="center">
                        <img src="../images/netsislogo.jpeg" /></div>
                    <div class="referans_item" align="center">
                        <img src="../images/europaslogo.gif" /></div>
                    <div class="clear"></div>
                </marquee>
            </div>
        </div>
    </div>



</asp:Content>
