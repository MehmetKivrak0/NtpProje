<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="blog.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/blog.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 blog_container">
        <!-- Hero Bölümü -->
        <div class="blog_hero">
            <h1>Teknoloji & Yazılım Blogu</h1>
            <p>Yazılım dünyasındaki son gelişmeler, en iyi uygulamalar ve teknik makalelerle sizleri bilgilendiriyoruz. Ekibimizin deneyimlerinden faydalanın.</p>
        </div>

        <!-- Blog Grid -->
        <div class="blog_grid">
            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/1_s.jpg" alt="ASP.NET Core" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">ASP.NET Core 8.0 ile Modern Web Uygulamaları</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">.NET</span>
                            <span class="blog_kategori">Web Development</span>
                        </div>
                        <span>📅 15 Ekim 2025</span>
                    </div>
                    <p class="blog_ozet">
                        ASP.NET Core 8.0 ile gelen yenilikler ve performans iyileştirmeleri. Minimal API'ler, Blazor gelişmeleri ve cloud-native özellikler. Modern web uygulamaları geliştirmek için bilmeniz gereken her şey bu yazıda. Dependency Injection, middleware yapısı ve best practices...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Ahmet Yılmaz</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>
            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/2_s.jpg" alt="Microservices" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">Microservices Mimarisine Geçiş Rehberi</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">Architecture</span>
                            <span class="blog_kategori">Microservices</span>
                        </div>
                        <span>📅 10 Ekim 2025</span>
                    </div>
                    <p class="blog_ozet">
                        Monolitik yapıdan microservices mimarisine geçiş sürecinde dikkat edilmesi gerekenler. Service mesh, API Gateway, event-driven architecture ve container orchestration konularında detaylı bilgiler. Kubernetes ile deployment stratejileri ve best practices...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Mehmet Kaya</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>
            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/3_s.jpg" alt="React" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">React 18 ile Modern Frontend Geliştirme</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">React</span>
                            <span class="blog_kategori">Frontend</span>
                        </div>
                        <span>📅 5 Ekim 2025</span>
                    </div>
                    <p class="blog_ozet">
                        React 18'in getirdiği yenilikler: Concurrent rendering, automatic batching, transitions ve suspense özellikleri. Hooks kullanımı, state management, performance optimization ve code splitting teknikleri. Modern frontend uygulamaları için best practices...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Zeynep Özkan</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>

            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/4_s.jpg" alt="DevOps" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">CI/CD Pipeline ile Otomatik Deployment</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">DevOps</span>
                            <span class="blog_kategori">CI/CD</span>
                        </div>
                        <span>📅 1 Ekim 2025</span>
                    </div>
                    <p class="blog_ozet">
                        Jenkins, GitLab CI ve GitHub Actions ile continuous integration ve continuous deployment süreçlerinin kurulumu. Docker containerization, automated testing, blue-green deployment ve rollback stratejileri. Infrastructure as Code (IaC) ile Terraform kullanımı...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Burak Şahin</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>

            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/5_s.jpg" alt="AI" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">Yapay Zeka ve Machine Learning Entegrasyonu</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">AI</span>
                            <span class="blog_kategori">Machine Learning</span>
                        </div>
                        <span>📅 25 Eylül 2025</span>
                    </div>
                    <p class="blog_ozet">
                        Python, TensorFlow ve PyTorch ile machine learning modellerinin geliştirilmesi ve uygulamalara entegrasyonu. Natural Language Processing (NLP), Computer Vision ve predictive analytics konularında pratik örnekler. ChatGPT API kullanımı ve fine-tuning teknikleri...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Emre Yıldız</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>

            <div class="blog_item">
                <div class="blog_resim">
                    <img src="../example/6_s.jpg" alt="Security" />
                </div>
                <div class="blog_content">
                    <h2 class="blog_baslik">Web Uygulamalarında Güvenlik En İyi Uygulamaları</h2>
                    <div class="blog_meta">
                        <div>
                            <span class="blog_kategori">Security</span>
                            <span class="blog_kategori">Best Practices</span>
                        </div>
                        <span>📅 20 Eylül 2025</span>
                    </div>
                    <p class="blog_ozet">
                        OWASP Top 10 güvenlik açıkları ve korunma yöntemleri. SQL Injection, XSS, CSRF saldırılarından korunma. Authentication ve authorization best practices. JWT, OAuth 2.0 ve secure coding standartları. Penetration testing ve vulnerability assessment...
                    </p>
                    <div class="blog_footer">
                        <div class="blog_yazar">✍️ Cem Polat</div>
                        <a href="blog_detay.aspx" class="blog_devami">Devamını Oku</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="wrapper1">
        <div class="partner_yazi">
            <div style="border-bottom: 5px solid #63207c; width: 220px;">TEKNOLOJİ PARTNERLERİMİZ</div>
        </div>
        <div style="width: 100%; overflow: hidden;">
            <div style="width: 105%; margin-left: -7px;">
                <marquee direction="left" behavior="scroll" onmouseover="this.stop()" onmouseout="this.start()" scrollamount="3" width="100%">
                    <div class="referans_item" align="center">
                        <img src="../images/adobelogo.png" width="150" />
                    </div>
                    <div class="referans_item" align="center">
                        <img src="../images/autodesk.jpeg" width="150" />
                    </div>
                    <div class="referans_item" align="center">
                        <img src="../images/netsislogo.jpeg" />
                    </div>
                    <div class="referans_item" align="center">
                        <img src="../images/europaslogo.gif" />
                    </div>
                    <div class="clear"></div>
                </marquee>
            </div>
        </div>
    </div>
</asp:Content>
