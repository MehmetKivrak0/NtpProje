<%@ Page Title="Ekibimiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ekip.aspx.cs" Inherits="NtpProje_Web.Ekip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/ekip.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 ekip_container">
        
        <div class="ekip_hero">
            <h1>Uzman Kadromuz</h1>
            <p>Projelerinizi hayata geçiren deneyimli ve tutkulu ekibimizle tanışın.</p>
        </div>
        
        <div class="ekip_grid">
            <asp:Repeater ID="rptEkip" runat="server">    
                
                <ItemTemplate>
                    <div class="ekip_card">
                        
                        <div class="ekip_img">
                            <img src='<%# GetResolvedImageUrl(Eval("ImageUrl")) %>' alt='<%# Eval("Name") %>' />
                        </div>
                        
                        <div class="ekip_content">
                            <h3 class="ekip_ad"><%# Eval("Name") %></h3>
                            
                            <span class="ekip_unvan"><%# Eval("Title") %></span>
                            <%# !string.IsNullOrEmpty(Eval("Position")?.ToString()) ? "<span class=\"ekip_pozisyon\">" + Eval("Position") + "</span>" : "" %>
                            
                            <p class="ekip_bio">
                                <%# Eval("Bio") %>    
                            </p>
                            
                            <div class="ekip_social">
                                <%# !string.IsNullOrEmpty(Eval("LinkedInUrl")?.ToString()) ? "<a href=\"" + Eval("LinkedInUrl") + "\" target=\"_blank\" rel=\"noopener noreferrer\" class=\"ekip_social_link\" title=\"LinkedIn\"><i class=\"fab fa-linkedin\"></i></a>" : "" %>
                                <%# !string.IsNullOrEmpty(Eval("TwitterUrl")?.ToString()) ? "<a href=\"" + Eval("TwitterUrl") + "\" target=\"_blank\" rel=\"noopener noreferrer\" class=\"ekip_social_link\" title=\"X (Twitter)\"><svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z\"/></svg></a>" : "" %>
                                <%# !string.IsNullOrEmpty(Eval("GithubUrl")?.ToString()) ? "<a href=\"" + Eval("GithubUrl") + "\" target=\"_blank\" rel=\"noopener noreferrer\" class=\"ekip_social_link\" title=\"GitHub\"><i class=\"fab fa-github\"></i></a>" : "" %>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>

                </asp:Repeater>

            <asp:PlaceHolder ID="phEmptyEkip" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px; width: 100%;">
                    <p>Henüz ekip üyesi eklenmemiştir.</p>
                </div>
            </asp:PlaceHolder>
        </div>
        
        <div class="ekip_cta">
            <h2>Bizimle Çalışmak İster misiniz?</h2>
            <div class="cta_buttons">
                <a href="iletisim.aspx" class="cta_button primary">İletişime Geçin</a>
            </div>
        </div>
    </div>
</asp:Content>