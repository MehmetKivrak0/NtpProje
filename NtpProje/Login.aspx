<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NtpProje_Web.Login" %>

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
            <div class="auth-box">

                <div class="auth-header">
                    <div class="auth-logo">GB</div>
                    <h1>Admin Paneli</h1>
                    <p>Hesabınıza Giriş Yapın</p>
                </div>

                <%-- Hata Mesajı Alanı (Label olarak düzenlendi) --%>
                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert alert-danger"></asp:Label>
                
                <div class="form-group">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">E-posta Adresi</asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="ornek@email.com" CssClass="form-control" TextMode="Email" autocomplete="email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword">Şifre</asp:Label>
                    <div class="password-field">
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="••••••••" CssClass="form-control" TextMode="Password" autocomplete="current-password"></asp:TextBox>
                        
                        <span class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>')">👁️</span>
                    </div>
                </div>

              

                <asp:Button ID="btnLogin" runat="server" Text="Giriş Yap" CssClass="btn btn-primary" OnClick="btnLogin_Click" />

                

                <div class="divider">
                    <span>Veya</span>
                </div>

                <div class="auth-links">
                    <p style="color: #666; font-size: 14px;">
                        Hesabınız yok mu ?
                        <a href="Register.aspx">Kayıt Olun</a>
                    </p>
                </div>

            </div>
            
            <%-- Ana Sayfaya Dön Linki --%>
            <div class="auth-links" style="margin-top: 20px; text-align: center;">
                 <a href="/index.aspx" style="color: #ffffff; text-decoration: none;">← Ana Sayfaya Dön</a>
             </div>

        </div> 
    </form>

    <script>
        // JS Fonksiyonu: togglePassword
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleIcon = document.querySelector('.password-toggle');
            if (!passwordInput || !toggleIcon) return;

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