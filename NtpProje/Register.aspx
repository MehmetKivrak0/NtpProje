<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="NtpProje_Web.Register" %>
<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin Kayıt - Genç Birey</title>

  
    <link rel="stylesheet" href="/css/admin.css" />
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <%-- ASP.NET Form etiketi --%>
    <form id="form1" runat="server">
        <div class="auth-container">
            <div class="auth-box">
                <div class="auth-header">
                    <div class="auth-logo">GB</div>
                    <h1>Yeni Hesap Oluştur</h1>
                    <p>Admin paneline kayıt olun</p>
                </div>

                <%-- Hata/Başarı mesajı için Literal --%>
                <asp:Literal ID="ltrMesaj" runat="server"></asp:Literal>

                <div class="form-group">
                    <label for="<%= txtFullName.ClientID %>">Ad Soyad</label>
                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Ahmet Yılmaz" CssClass="form-control" minlength="3"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="<%= txtEmail.ClientID %>">E-posta Adresi</label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="ornek@email.com" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="<%= txtPhoneNumber.ClientID %>">Telefon Numarası</label>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="0555 123 45 67" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="<%= txtPassword.ClientID %>">Şifre</label>
                    <div class="password-field">
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="••••••••" CssClass="form-control" TextMode="Password" minlength="6"></asp:TextBox>
                        <span class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>')">👁️</span>
                    </div>
                    <small style="color: #666; font-size: 12px;">En az 6 karakter olmalıdır</small>
                </div>

                <div class="checkbox-group">
                    <asp:CheckBox ID="chkTerms" runat="server" />
                    <label for="<%= chkTerms.ClientID %>">
                        <a href="#" style="color: #667eea;">Kullanım koşullarını</a> kabul ediyorum
                    </label>
                </div>

                <div class="checkbox-group">
                    <asp:CheckBox ID="chkNewsletter" runat="server" />
                    <label for="<%= chkNewsletter.ClientID %>">E-posta bülteni almak istiyorum</label>
                </div>

                <%-- Buton ve C# olay bağlantısı --%>
                <asp:Button ID="btnRegister" runat="server" Text="Kayıt Ol" OnClick="btnRegister_Click" CssClass="btn btn-primary" />

                <div class="divider">
                    <span>VEYA</span>
                </div>

                <div class="auth-links">
                    <p style="color: #666; font-size: 14px;">
                        Zaten hesabınız var mı?
                        <a href="Login.aspx">Giriş yapın</a>
                    </p>
                </div>
            </div>

            <div class="auth-links" style="margin-top: 20px; text-align: center;">
                <%-- Ana Sayfa linki --%>
                <a href='<%= ResolveUrl("~/index.aspx") %>' style="color: #ffffff; text-decoration: none;">← Ana Sayfaya Dön</a>
            </div>
        </div>
    </form>
    <%-- form etiketi biter --%>

    <%-- Sadece Arayüzle İlgili JS Kodları Kaldı --%>
    <script>
        // Şifre görünürlük toggle
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleIcon = passwordInput.nextElementSibling;
            if (!passwordInput || !toggleIcon) return;

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.textContent = '🙈';
            } else {
                passwordInput.type = 'password';
                toggleIcon.textContent = '👁️';
            }
        }

        // Telefon formatı (Düzeltildi)
        const phoneInput = document.getElementById('<%= txtPhoneNumber.ClientID %>');
        if (phoneInput) {
            phoneInput.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 0) {
                    if (value.length <= 4) {
                        value = value;
                    } else if (value.length <= 7) {
                        value = value.slice(0, 4) + ' ' + value.slice(4);
                    } else if (value.length <= 9) {
                        value = value.slice(0, 4) + ' ' + value.slice(4, 7) + ' ' + value.slice(7);
                    } else {
                        value = value.slice(0, 4) + ' ' + value.slice(4, 7) + ' ' + value.slice(7, 9) + ' ' + value.slice(9, 11);
                    }
                }
                e.target.value = value;
            });
        }
    </script>
</body>
</html>
