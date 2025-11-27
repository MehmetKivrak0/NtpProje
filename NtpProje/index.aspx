<%@ Page Title="Anasayfa" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="NtpProje_Web.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 index_container">

        <div class="hizmetler_ozet">
            <h2 class="section_baslik">Yazılım Hizmetlerimiz</h2>
            <p class="section_alt_baslik">Modern teknolojiler ve en iyi uygulamalarla işletmenizin dijital dönüşümünde yanınızdayız</p>
            
            <div class="hizmet_ozet_grid" style="margin-top: 50px">
                
                <asp:PlaceHolder ID="phEmptyServices" runat="server" Visible="false">
                    <div style="text-align: center; padding: 20px; grid-column: 1 / -1; color:#87257b;">
                        <p>⚠️ Şu an aktif hizmet bilgisi bulunmamaktadır.</p>
                    </div>
                </asp:PlaceHolder>
                
                <asp:Repeater ID="rptHomeServices" runat="server">
                    <ItemTemplate>
                        <div class="hizmet_ozet_card">
                            <span class="hizmet_ozet_icon"><%# Eval("IconClass") %></span>
                            <h3><%# Eval("Name") %></h3>
                            <p><%# Eval("ShortDescription") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div style="text-align: center;">
                <a href="pages/hizmetler.aspx" class="tumunu_gor_btn">Tüm Hizmetlerimiz →</a>
            </div>
        </div>

        
        <div class="blog_ozet_section">
            <h2 class="section_baslik">Son Blog Yazıları</h2>
            <p class="section_alt_baslik">Teknoloji ve yazılım dünyasından son haberler</p>

            <div class="blog_ozet_grid">
                
                <asp:PlaceHolder ID="phEmptyBlog" runat="server" Visible="false">
                    <div style="text-align: center; padding: 20px; grid-column: 1 / -1; color:#87257b;">
                        <p>⚠️ Henüz yayınlanmış blog yazısı bulunmamaktadır.</p>
                    </div>
                </asp:PlaceHolder>
                
                <asp:Repeater ID="rptHomeBlog" runat="server">
                    <ItemTemplate>
                        <div class="blog_ozet_card">
                            <a href='pages/blog_detay.aspx?id=<%# Eval("Id") %>'>
                                <div class="blog_ozet_gorsel">
                                    <img src='<%# GetImageUrl(Eval("ImageUrl")) %>' alt='<%# Eval("Title") %>' />
                                </div>
                                <div class="blog_ozet_icerik">
                                    <h3 class="blog_ozet_baslik"><%# Eval("Title") %></h3>
                                    <p class="blog_ozet_meta">
                                        📅 <%# Eval("PublishDate", "{0:dd MMMM yyyy}") %> | 
                                        ✍️ <%# Eval("AuthorFullName") %>
                                    </p>
                                    <p class="blog_ozet_text"><%# Eval("Summary") %></p>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div style="text-align: center;">
                <a href="pages/blog.aspx" class="tumunu_gor_btn">Tüm Blog Yazılarımız →</a>
            </div>
        </div>

        <div class="cta_section">
            <h2>Projeniz İçin Ücretsiz Teklif Alın</h2>
            <p>Hayalinizdeki yazılım projesini birlikte gerçeğe dönüştürelim. Uzman ekibimiz size en uygun çözümü sunmak için hazır.</p>
            <a href="pages/iletisim.aspx" class="cta_btn">Hemen İletişime Geçin</a>
        </div>
    </div>
</asp:Content>