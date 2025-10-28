<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NtpProje.Login" %>


<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin Giriş - Genç Birey</title>

    <%-- CSS Yolunu Kök Dizine Göre Düzeltme --%>
    <link rel="stylesheet" href="/css/admin.css" />

    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-container">
            <%-- Beyaz Kutu Başlıyor --%>
            <div class="auth-box">

                <%-- Başlık Alanı --%>
                <div class="auth-header">
                    <div class="auth-logo">GB</div>
                    <h1>Admin Paneli</h1>
                    <p>Hesabınıza Giriş Yapın</p>
                </div>

                <%-- Hata Mesajı Alanı (auth-box İÇİNDE) --%>
                <asp:Literal ID="ltrMesaj" runat="server"></asp:Literal>

                <%-- Form Elemanları (auth-box İÇİNDE) --%>
                <div class="form-group">
                    <label for="<%= txtEmail.ClientID %>">E-posta Adresi</label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="ornek@email.com" CssClass="form-control" TextMode="Email" autocomplete="email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="<%= txtPassword.ClientID %>">Şifre</label>
                    <div class="password-field">
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="••••••••" CssClass="form-control" TextMode="Password" autocomplete="current-password"></asp:TextBox>
                        <%-- JS Fonksiyonu düzeltildi --%>
                        <span class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>')">👁️</span>
                    </div>
                </div>

                <div class="checkbox-group">
                    <asp:CheckBox ID="chkRememberMe" runat="server" />
                    <label for="<%= chkRememberMe.ClientID %>">Beni Hatırla</label>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Giriş Yap" CssClass="btn btn-primary" OnClick="btnLogin_Click" />

                <div class="auth-links">
                    <a href="#" id="forgotPassword">Şifrenizi mi unuttunuz?</a> <%-- Bu linkin işlevselliği ayrı yapılmalı --%>
                </div>

                <div class="divider">
                    <span>Veya</span>
                </div>

                <div class="auth-links">
                    <p style="color: #666; font-size: 14px;">
                        Hesabınız yok mu ?
                        <a href="Register.aspx">Kayıt Olun</a>
                    </p>
                </div>

            </div> <%-- auth-box BURADA KAPANIR --%>

            <%-- Ana Sayfaya Dön Linki (auth-box DIŞINDA, auth-container İÇİNDE) --%>
            <div class="auth-links" style="margin-top: 20px; text-align: center;">
                 <a href="/index.aspx" style="color: #ffffff; text-decoration: none;">← Ana Sayfaya Dön</a>
             </div>

        </div> <%-- auth-container BURADA KAPANIR --%>
    </form>

    <script>
        // Şifre görünürlük toggle (Düzeltildi: fieldId kullanılacak)
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId); // 'password' yerine fieldId kullanıldı
            const toggleIcon = document.querySelector('.password-toggle');
            if (!passwordInput || !toggleIcon) return; // Null kontrolü eklendi

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.textContent = '🙈';
            } else {
                passwordInput.type = 'password';
                toggleIcon.textContent = '👁️';
            }
        }
    </script>
</body>
</html>