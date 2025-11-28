<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="blog_detay.aspx.cs" Inherits="NtpProje_Web.blog_detay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/blog_detay.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1" style="padding: 20px 0px;">
        <a href="blog.aspx" class="geri_buton">← Tüm Blog Yazılarına Dön</a>

        <div class="blog_detay_wrapper">
            <asp:Panel ID="pnlBlogContent" runat="server">
                <!-- Blog Başlık ve Meta -->
                <div class="blog_detay_baslik"><%= CurrentPost?.Title ?? "Blog Yazısı" %></div>

                <div class="blog_detay_meta">
                    <div class="blog_meta_item">
                        <span class="meta_icon">📅</span>
                        <span class="meta_label">Tarih:</span>
                        <span><%= CurrentPost?.PublishDate?.ToString("dd MMMM yyyy") ?? DateTime.Now.ToString("dd MMMM yyyy") %></span>
                    </div>
                    <div class="blog_meta_item">
                        <span class="meta_icon">✍️</span>
                        <span class="meta_label">Yazar:</span>
                        <span><%= CurrentPost?.AuthorFullName ?? "Yazar" %></span>
                    </div>
                    <div class="blog_meta_item">
                        <span class="meta_icon">📂</span>
                        <span class="meta_label">Kategori:</span>
                        <span><%= GetCategoryList() %></span>
                    </div>
                    <div class="blog_meta_item">
                        <span class="meta_icon">⏱️</span>
                        <span class="meta_label">Okuma Süresi:</span>
                        <span><%= GetReadingTime(CurrentPost?.ReadingTime) %></span>
                    </div>
                    <div class="clear"></div>
                </div>

                <!-- Ana Görsel -->
                <% if (CurrentPost != null && !string.IsNullOrEmpty(CurrentPost.ImageUrl)) { %>
                <div class="blog_ana_gorsel">
                    <img src="<%= GetImageUrl(CurrentPost.ImageUrl) %>" alt="<%= CurrentPost.Title %>" />
                </div>
                <% } %>

                <!-- Kategoriler -->
                <% if (CurrentPost != null && !string.IsNullOrEmpty(CurrentPost.CategoryName)) { %>
                <div class="blog_kategoriler">
                    <span class="blog_kategori_badge"><%= CurrentPost.CategoryName %></span>
                </div>
                <% } %>

                <!-- Blog İçerik -->
                <div class="blog_detay_icerik">
                    <%= CurrentPost?.Content ?? "" %>
                </div>
            </asp:Panel>

            <!-- Paylaşım Butonları -->
            <% if (CurrentPost != null) { %>
            <div class="paylasim_alani">
                <div class="paylasim_baslik">Bu yazıyı paylaşın:</div>
                <div class="paylasim_butonlar">
                    <% string shareUrl = Request.Url.AbsoluteUri; %>
                    <a href="https://www.facebook.com/sharer/sharer.php?u=<%= Server.UrlEncode(shareUrl) %>" target="_blank" class="paylasim_btn facebook">Facebook</a>
                    <a href="https://twitter.com/intent/tweet?url=<%= Server.UrlEncode(shareUrl) %>&text=<%= Server.UrlEncode(CurrentPost.Title) %>" target="_blank" class="paylasim_btn twitter">Twitter</a>
                    <a href="https://www.linkedin.com/sharing/share-offsite/?url=<%= Server.UrlEncode(shareUrl) %>" target="_blank" class="paylasim_btn linkedin">LinkedIn</a>
                    <a href="https://wa.me/?text=<%= Server.UrlEncode(CurrentPost.Title + " " + shareUrl) %>" target="_blank" class="paylasim_btn whatsapp">WhatsApp</a>
                </div>
            </div>
            <% } %>

            <!-- İlgili Yazılar -->
            <asp:Panel ID="pnlRelatedPosts" runat="server" Visible="false">
                <div class="ilgili_yazilar">
                    <h3 class="ilgili_baslik">İlgili Yazılar</h3>
                    <asp:Repeater ID="rptRelatedPosts" runat="server">
                        <ItemTemplate>
                            <div class="ilgili_yazi_item sol">
                                <a href='<%# "blog_detay.aspx?id=" + Eval("Id") %>'>
                                    <img src='<%# GetImageUrl(Eval("ImageUrl")) %>' alt='<%# Eval("Title") %>' />
                                    <div class="ilgili_yazi_baslik"><%# Eval("Title") %></div>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="clear"></div>
                </div>
            </asp:Panel>
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
