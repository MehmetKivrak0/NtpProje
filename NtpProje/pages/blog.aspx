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
            <asp:Repeater ID="rptBlog" runat="server" OnItemDataBound="rptBlog_ItemDataBound">
                <ItemTemplate>
                    <div class="blog_item">
                        <div class="blog_resim">
                            <asp:Image ID="imgBlog" runat="server" ImageUrl='<%# Eval("Resim") %>' 
                                AlternateText='<%# Eval("Baslik") %>' />
                        </div>
                        <div class="blog_content">
                            <h2 class="blog_baslik"><%# Eval("Baslik") %></h2>
                            <div class="blog_meta">
                                <div>
                                    <asp:Repeater ID="rptKategoriler" runat="server">
                                        <ItemTemplate>
                                            <span class="blog_kategori"><%# Container.DataItem %></span>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <span>📅 <%# Eval("Tarih", "{0:dd MMMM yyyy}") %></span>
                            </div>
                            <p class="blog_ozet">
                                <%# Eval("Ozet") %>
                            </p>
                            <div class="blog_footer">
                                <div class="blog_yazar">✍️ <%# Eval("Yazar") %></div>
                                <a href='<%# "blog_detay.aspx?id=" + Eval("Id") %>' class="blog_devami">Devamını Oku</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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
