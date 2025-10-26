<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hakkimizda.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.hakkimizda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/hakkimizda.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 hakkimizda_container">
        <!-- Hero Bölümü -->
        <div class="hakkimizda_hero">
            <h1>Hakkımızda</h1>
            <p>Yazılım sektöründe 10 yılı aşkın deneyimimizle, modern teknolojiler kullanarak işletmelerin dijital dönüşüm süreçlerinde yanlarında oluyoruz.</p>
        </div>

        <!-- Ana İçerik -->
        <div class="hakkimizda_resim_card">
            <img src="../images/1.jpg" alt="Ofisimiz" />
        </div>

        <div class="hakkimizda_icerik_card">
            <h2 class="hakkimizda_card_baslik">Biz Kimiz?</h2>
            <div class="hakkimizda_card_icerik">
                <p>
                    Yazılım sektöründe 10 yılı aşkın deneyimimizle, modern teknolojiler kullanarak işletmelerin dijital dönüşüm süreçlerinde yanlarında oluyoruz. 
				Web siteleri, mobil uygulamalar, kurumsal yazılımlar ve e-ticaret platformları geliştirme konusunda uzmanlaşmış ekibimizle, 
				müşterilerimize en kaliteli hizmeti sunmayı hedefliyoruz.
                </p>
                <p>
                    150'den fazla başarılı projeye imza atmış, 200'ü aşkın müşteriye hizmet vermiş bir ekip olarak, 
				işinizi dijitale taşımak ve online varlığınızı güçlendirmek için buradayız. 
				Sizin için en uygun yazılım çözümlerini üretmeye hazırız.
                </p>
                <p>
                    ASP.NET, React, Angular, Node.js, Python gibi modern teknolojilerde uzman ekibimiz, 
				projenizin ihtiyaçlarına en uygun teknoloji stack'ini seçerek, 
				ölçeklenebilir, güvenli ve performanslı uygulamalar geliştiriyor.
                </p>
            </div>
        </div>

        <!-- Vizyon & Misyon -->
        <div class="vizyon_misyon_grid">
            <div class="vm_card">
                <span class="vm_icon">🎯</span>
                <h2 class="vm_baslik">Vizyonumuz</h2>
                <div class="vm_icerik">
                    <p>
                        Türkiye'nin ve dünyanın önde gelen yazılım şirketlerinden biri olmak, teknoloji alanında yenilikçi ve öncü projeler geliştirmek. 
                    </p>
                    <p>
                        Müşterilerimize en son teknolojileri kullanarak, rekabet avantajı sağlayan, kullanıcı dostu ve ölçeklenebilir yazılım çözümleri sunmak.
                    </p>
                    <p>
                        Dijital dönüşümün öncüsü olarak, her büyüklükteki işletmenin teknoloji gücünden faydalanmasını sağlamak ve 
					yazılım sektöründe güvenilir bir marka olmak vizyonumuzdur.
                    </p>
                </div>
            </div>

            <div class="vm_card">
                <span class="vm_icon">🎖️</span>
                <h2 class="vm_baslik">Misyonumuz</h2>
                <div class="vm_icerik">
                    <p>
                        <strong>• Müşteri Odaklı Çözümler:</strong> Her projeyi müşterinin ihtiyaçlarına özel tasarlayarak, 
					iş süreçlerini kolaylaştıran ve verimliliği artıran yazılımlar geliştirmek.
                    </p>
                    <p>
                        <strong>• Kalite ve Güvenilirlik:</strong> En yüksek kalite standartlarında, güvenli ve performanslı yazılımlar üretmek.
                    </p>
                    <p>
                        <strong>• Sürekli Gelişim:</strong> Teknolojideki değişimleri yakından takip ederek, ekibimizi ve projelerimizi sürekli geliştirmek.
                    </p>
                    <p>
                        <strong>• İnovasyon:</strong> Yaratıcı ve yenilikçi çözümlerle sektöre değer katmak, fark yaratan projeler üretmek.
                    </p>
                </div>
            </div>
        </div>

        <!-- Değerlerimiz -->
        <div class="degerler_section">
            <h2 class="degerler_baslik">Değerlerimiz</h2>
            <div class="degerler_grid">
                <div class="deger_item">
                    <span class="deger_icon">💎</span>
                    <h3>Kalite</h3>
                    <p>Her projede en yüksek kalite standartlarını uygularız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🤝</span>
                    <h3>Güvenilirlik</h3>
                    <p>Sözleştiğimiz teslim tarihlerine ve kaliteye sadık kalırız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🚀</span>
                    <h3>İnovasyon</h3>
                    <p>Sürekli yeni teknolojiler ve yöntemler araştırırız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🎨</span>
                    <h3>Yaratıcılık</h3>
                    <p>Her projeye özgün ve yaratıcı çözümler üretiriz</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">📈</span>
                    <h3>Büyüme</h3>
                    <p>Müşterilerimizin büyümesine katkı sağlarız</p>
                </div>
                <div class="deger_item">
                    <span class="deger_icon">🌟</span>
                    <h3>Mükemmellik</h3>
                    <p>Her detayda mükemmelliği hedefleriz</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
