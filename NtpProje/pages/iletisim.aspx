<%@ Page Title="İletişim" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="NtpProje_Web.Iletisim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%= ResolveUrl("~/css/genc_birey_stil.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%= ResolveUrl("~/css/iletisim.css") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 iletisim_container">

        <div class="iletisim_hero">
            <h1>Bize Ulaşın</h1>
            <p>Projeleriniz, sorularınız ve iş birliği teklifleriniz için bizimle iletişime geçin.</p>
        </div>

        <div class="iletisim_bilgi">
            <h2 class="iletisim_bilgi_baslik">İletişim Bilgilerimiz</h2>
            <div class="iletisim_grid">
                <div class="iletisim_item">
                    <div class="iletisim_baslik">📍 Adres</div>
                    <div class="iletisim_detay">
                        <asp:Literal ID="litAdres" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="iletisim_item">
                    <div class="iletisim_baslik">📞 Telefon</div>
                    <div class="iletisim_detay">
                        <asp:Literal ID="litTelefon" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="iletisim_item">
                    <div class="iletisim_baslik">📧 E-posta</div>
                    <div class="iletisim_detay">
                        <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="iletisim_item">
                    <div class="iletisim_baslik">🕐 Çalışma Saatleri</div>
                    <div class="iletisim_detay">
                        <asp:Literal ID="litSaatler" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>

        <div class="form_container">

            <div class="iletisim_form">
                <h2 class="form_baslik">İletişim Formu</h2>
                <asp:Label ID="lblIletisimMesaj" runat="server" CssClass="form_mesaj" Visible="false"></asp:Label>

                <asp:Panel ID="pnlIletisimForm" runat="server">
                    <div class="form_grup">
                        <asp:Label ID="lblAdSoyad" runat="server" AssociatedControlID="txtAdSoyad" CssClass="form_label" Text="Ad Soyad *"></asp:Label>
                        <asp:TextBox ID="txtAdSoyad" runat="server" CssClass="form_input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAdSoyad" runat="server" ControlToValidate="txtAdSoyad"
                            ErrorMessage="Ad Soyad gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" CssClass="form_label" Text="E-posta *"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form_input" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="E-posta gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Geçerli bir e-posta giriniz" CssClass="validation_error" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblTelefon" runat="server" AssociatedControlID="txtTelefon" CssClass="form_label" Text="Telefon"></asp:Label>
                        <asp:TextBox ID="txtTelefon" runat="server" CssClass="form_input" TextMode="Phone"></asp:TextBox>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblKonu" runat="server" AssociatedControlID="ddlKonu" CssClass="form_label" Text="Konu"></asp:Label>
                        <asp:DropDownList ID="ddlKonu" runat="server" CssClass="form_input">
                            <asp:ListItem Value="" Text="Seçiniz..."></asp:ListItem>
                            <asp:ListItem Value="Genel" Text="Genel Bilgi"></asp:ListItem>
                            <asp:ListItem Value="Teklif" Text="Teklif İsteği"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblMesaj" runat="server" AssociatedControlID="txtMesaj" CssClass="form_label" Text="Mesajınız *"></asp:Label>
                        <asp:TextBox ID="txtMesaj" runat="server" CssClass="form_textarea" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMesaj" runat="server" ControlToValidate="txtMesaj"
                            ErrorMessage="Mesaj gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Button ID="btnGonder" runat="server" Text="Gönder" CssClass="form_button" OnClick="btnGonder_Click" />
                    </div>
                </asp:Panel>
            </div>

            <div class="iletisim_form">
                <h2 class="form_baslik">Proje Teklifi</h2>
                <asp:Label ID="lblTeklifMesaj" runat="server" CssClass="form_mesaj" Visible="false"></asp:Label>

                <asp:Panel ID="pnlTeklifForm" runat="server">
                    <div class="form_grup">
                        <asp:Label ID="lblFirmaAdi" runat="server" AssociatedControlID="txtFirmaAdi" CssClass="form_label" Text="Firma Adı"></asp:Label>
                        <asp:TextBox ID="txtFirmaAdi" runat="server" CssClass="form_input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirmaAdi" runat="server" ControlToValidate="txtFirmaAdi"
                            ErrorMessage="Firma Adı gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblYetkili" runat="server" AssociatedControlID="txtYetkili" CssClass="form_label" Text="Yetkili Kişi"></asp:Label>
                        <asp:TextBox ID="txtYetkili" runat="server" CssClass="form_input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvYetkili" runat="server" ControlToValidate="txtYetkili"
                            ErrorMessage="Yetkili Kişi gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblTeklifEmail" runat="server" AssociatedControlID="txtTeklifEmail" CssClass="form_label" Text="E-posta"></asp:Label>
                        <asp:TextBox ID="txtTeklifEmail" runat="server" CssClass="form_input" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTeklifEmail" runat="server" ControlToValidate="txtTeklifEmail"
                            ErrorMessage="E-posta gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revTeklifEmail" runat="server" ControlToValidate="txtTeklifEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Geçerli bir e-posta giriniz" CssClass="validation_error" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblTeklifTelefon" runat="server" AssociatedControlID="txtTeklifTelefon" CssClass="form_label" Text="Telefon"></asp:Label>
                        <asp:TextBox ID="txtTeklifTelefon" runat="server" CssClass="form_input" TextMode="Phone"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTeklifTelefon" runat="server" ControlToValidate="txtTeklifTelefon"
                            ErrorMessage="Telefon gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Label ID="lblProjeDetay" runat="server" AssociatedControlID="txtProjeDetay" CssClass="form_label" Text="Proje Detayları"></asp:Label>
                        <asp:TextBox ID="txtProjeDetay" runat="server" CssClass="form_textarea" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProjeDetay" runat="server" ControlToValidate="txtProjeDetay"
                            ErrorMessage="Proje Detayları gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_grup">
                        <asp:Button ID="btnTeklifIste" runat="server" Text="Teklif İste" CssClass="form_button" OnClick="btnTeklifIste_Click" />
                    </div>
                </asp:Panel>
            </div>
        </div>

        <div class="harita_wrapper">
            <iframe
                id="ifHarita"
                runat="server"
                style="border: 0; width: 100%; height: 400px;"
                allowfullscreen=""
                loading="lazy"></iframe>
        </div>
    </div>
</asp:Content>
