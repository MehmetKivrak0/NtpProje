<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="_241613001_Mehmet_Kıvrak_NtpProje.pages.iletisim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/genc_birey_stil.css" rel="stylesheet" type="text/css" />
    <link href="../css/iletisim.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper1 iletisim_container">
	<!-- Hero Bölümü -->
	<div class="iletisim_hero">
		<h1>Bize Ulaşın</h1>
		<p>Projeleriniz, sorularınız ve iş birliği teklifleriniz için bizimle iletişime geçin. Size en kısa sürede dönüş yapacağız.</p>
	</div>
	
	<!-- İletişim Bilgileri -->
	<div class="iletisim_bilgi">
		<h2 class="iletisim_bilgi_baslik">İletişim Bilgilerimiz</h2>
		<div class="iletisim_grid">
			<div class="iletisim_item">
				<div class="iletisim_baslik">📍 Adres</div>
				<div class="iletisim_detay">Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / Alsancak - İzmir</div>
			</div>
			<div class="iletisim_item">
				<div class="iletisim_baslik">📞 Telefon</div>
				<div class="iletisim_detay">+90 232 464 1 184<br />+90 232 464 1 183</div>
			</div>
			<div class="iletisim_item">
				<div class="iletisim_baslik">📧 E-posta</div>
				<div class="iletisim_detay">info@yazilimsirketi.com<br />destek@yazilimsirketi.com</div>
			</div>
			<div class="iletisim_item">
				<div class="iletisim_baslik">🕐 Çalışma Saatleri</div>
				<div class="iletisim_detay">Pazartesi - Cuma: 09:00 - 18:00<br />Cumartesi: 10:00 - 14:00</div>
			</div>
		</div>
	</div>
	
	<!-- İletişim Formları -->
	<div class="form_container">
		<div class="iletisim_form">
			<h2 class="form_baslik">İletişim Formu</h2>
			<asp:Label ID="lblIletisimMesaj" runat="server" CssClass="form_mesaj" Visible="false"></asp:Label>
			<asp:Panel ID="pnlIletisimForm" runat="server">
				<div class="form_grup">
					<label class="form_label" for="<%= txtAdSoyad.ClientID %>">Ad Soyad *</label>
					<asp:TextBox ID="txtAdSoyad" runat="server" CssClass="form_input" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvAdSoyad" runat="server" ControlToValidate="txtAdSoyad" 
						ErrorMessage="Ad Soyad gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtEmail.ClientID %>">E-posta *</label>
					<asp:TextBox ID="txtEmail" runat="server" CssClass="form_input" TextMode="Email" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
						ErrorMessage="E-posta gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
						ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
						ErrorMessage="Geçerli bir e-posta adresi giriniz" CssClass="validation_error" Display="Dynamic"></asp:RegularExpressionValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtTelefon.ClientID %>">Telefon</label>
					<asp:TextBox ID="txtTelefon" runat="server" CssClass="form_input" TextMode="Phone"></asp:TextBox>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= ddlKonu.ClientID %>">Konu</label>
					<asp:DropDownList ID="ddlKonu" runat="server" CssClass="form_input">
						<asp:ListItem Value="" Text="Seçiniz..."></asp:ListItem>
						<asp:ListItem Value="web" Text="Web Geliştirme"></asp:ListItem>
						<asp:ListItem Value="mobil" Text="Mobil Uygulama"></asp:ListItem>
						<asp:ListItem Value="erp" Text="ERP Yazılımı"></asp:ListItem>
						<asp:ListItem Value="eticaret" Text="E-Ticaret"></asp:ListItem>
						<asp:ListItem Value="danismanlik" Text="Danışmanlık"></asp:ListItem>
						<asp:ListItem Value="diger" Text="Diğer"></asp:ListItem>
					</asp:DropDownList>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtMesaj.ClientID %>">Mesajınız *</label>
					<asp:TextBox ID="txtMesaj" runat="server" CssClass="form_textarea" TextMode="MultiLine" Rows="5" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvMesaj" runat="server" ControlToValidate="txtMesaj" 
						ErrorMessage="Mesaj gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<asp:Button ID="btnGonder" runat="server" Text="Gönder" CssClass="form_button" OnClick="btnGonder_Click" />
				</div>
			</asp:Panel>
		</div>
		
		<div class="iletisim_form">
			<h2 class="form_baslik">Proje Teklifi Alın</h2>
			<asp:Label ID="lblTeklifMesaj" runat="server" CssClass="form_mesaj" Visible="false"></asp:Label>
			<asp:Panel ID="pnlTeklifForm" runat="server">
				<div class="form_grup">
					<label class="form_label" for="<%= txtFirmaAdi.ClientID %>">Firma Adı *</label>
					<asp:TextBox ID="txtFirmaAdi" runat="server" CssClass="form_input" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvFirmaAdi" runat="server" ControlToValidate="txtFirmaAdi" 
						ErrorMessage="Firma Adı gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtYetkili.ClientID %>">Yetkili Kişi *</label>
					<asp:TextBox ID="txtYetkili" runat="server" CssClass="form_input" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvYetkili" runat="server" ControlToValidate="txtYetkili" 
						ErrorMessage="Yetkili Kişi gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtTeklifEmail.ClientID %>">E-posta *</label>
					<asp:TextBox ID="txtTeklifEmail" runat="server" CssClass="form_input" TextMode="Email" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvTeklifEmail" runat="server" ControlToValidate="txtTeklifEmail" 
						ErrorMessage="E-posta gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
					<asp:RegularExpressionValidator ID="revTeklifEmail" runat="server" ControlToValidate="txtTeklifEmail" 
						ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
						ErrorMessage="Geçerli bir e-posta adresi giriniz" CssClass="validation_error" Display="Dynamic"></asp:RegularExpressionValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtTeklifTelefon.ClientID %>">Telefon *</label>
					<asp:TextBox ID="txtTeklifTelefon" runat="server" CssClass="form_input" TextMode="Phone" required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvTeklifTelefon" runat="server" ControlToValidate="txtTeklifTelefon" 
						ErrorMessage="Telefon gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<label class="form_label" for="<%= txtProjeDetay.ClientID %>">Proje Detayları *</label>
					<asp:TextBox ID="txtProjeDetay" runat="server" CssClass="form_textarea" TextMode="MultiLine" Rows="5" 
						placeholder="Projeniz hakkında detaylı bilgi veriniz..." required="true"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvProjeDetay" runat="server" ControlToValidate="txtProjeDetay" 
						ErrorMessage="Proje Detayları gereklidir" CssClass="validation_error" Display="Dynamic"></asp:RequiredFieldValidator>
				</div>
				<div class="form_grup">
					<asp:Button ID="btnTeklifIste" runat="server" Text="Teklif İste" CssClass="form_button" OnClick="btnTeklifIste_Click" />
				</div>
			</asp:Panel>
		</div>
	</div>
	
	<!-- Harita -->
	<div class="harita_wrapper">
		<iframe 
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3124.8449!2d27.1428!3d38.4382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMzjCsDI2JzE3LjUiTiAyN8KwMDgnMzQuMSJF!5e0!3m2!1str!2str!4v1234567890"
			width="100%" 
			height="400" 
			style="border:0;" 
			allowfullscreen="" 
			loading="lazy">
		</iframe>
	</div>
</div>
</asp:Content>
