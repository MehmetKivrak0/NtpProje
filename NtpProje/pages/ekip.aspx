<%@ Page Title="Ekibimiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ekip.aspx.cs" Inherits="NtpProje_Web.Ekip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
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
                            <img src='<%# Eval("Image") %>' alt='<%# Eval("Name") %>' />
                        </div>
                        
                        <div class="ekip_content">
                            <h3 class="ekip_ad"><%# Eval("Name") %> <%# Eval("Surname") %></h3>
                            
                            <span class="ekip_unvan"><%# Eval("Title") %></span>
                            
                            <p class="ekip_bio">
                                <%# Eval("Description") %>    
                            </p>
                            
                            <div class="ekip_social">
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                                <a href="#"><i class="fab fa-github"></i></a>
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