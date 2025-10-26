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
			<form action="#" method="post">
				<div class="form_grup">
					<label class="form_label">Ad Soyad *</label>
					<input type="text" name="adsoyad" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">E-posta *</label>
					<input type="email" name="email" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">Telefon</label>
					<input type="tel" name="telefon" class="form_input" />
				</div>
				<div class="form_grup">
					<label class="form_label">Konu</label>
					<select name="konu" class="form_input">
						<option value="">Seçiniz...</option>
						<option value="web">Web Geliştirme</option>
						<option value="mobil">Mobil Uygulama</option>
						<option value="erp">ERP Yazılımı</option>
						<option value="eticaret">E-Ticaret</option>
						<option value="danismanlik">Danışmanlık</option>
						<option value="diger">Diğer</option>
					</select>
				</div>
				<div class="form_grup">
					<label class="form_label">Mesajınız *</label>
					<textarea name="mesaj" class="form_textarea" required></textarea>
				</div>
				<div class="form_grup">
					<button type="submit" class="form_button">Gönder</button>
				</div>
			</form>
		</div>
		
		<div class="iletisim_form">
			<h2 class="form_baslik">Proje Teklifi Alın</h2>
			<form action="#" method="post">
				<div class="form_grup">
					<label class="form_label">Firma Adı *</label>
					<input type="text" name="firma" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">Yetkili Kişi *</label>
					<input type="text" name="yetkili" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">E-posta *</label>
					<input type="email" name="email" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">Telefon *</label>
					<input type="tel" name="telefon" class="form_input" required />
				</div>
				<div class="form_grup">
					<label class="form_label">Proje Detayları *</label>
					<textarea name="proje" class="form_textarea" required placeholder="Projeniz hakkında detaylı bilgi veriniz..."></textarea>
				</div>
				<div class="form_grup">
					<button type="submit" class="form_button">Teklif İste</button>
				</div>
			</form>
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
