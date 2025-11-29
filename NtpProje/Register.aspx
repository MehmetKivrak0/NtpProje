<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="NtpProje_Web.Register" %>
<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin Kayıt - Innovate Yazılım</title>

  
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
                    <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="0555 123 45 67" CssClass="form-control" TextMode="Phone" MaxLength="14"></asp:TextBox>
                    <small style="color: #666; font-size: 12px;">Format: 0555 123 45 67</small>
                </div>

                <div class="form-group">
                    <label for="<%= txtPassword.ClientID %>">Şifre</label>
                    <div class="password-field">
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="••••••••" CssClass="form-control" TextMode="Password" minlength="6"></asp:TextBox>
                        <span class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>')">👁️</span>
                    </div>
                    <small id="passwordHelp" style="color: #666; font-size: 12px; display: block; margin-top: 5px;">
                        Şifre gereksinimleri:
                    </small>
                    <ul id="passwordRequirements" style="list-style: none; padding: 0; margin: 5px 0 0 0; font-size: 12px;">
                        <li id="reqLength" style="color: #999; margin: 3px 0;">
                            <span class="req-icon">❌</span> En az 6 karakter
                        </li>
                        <li id="reqLowercase" style="color: #999; margin: 3px 0;">
                            <span class="req-icon">❌</span> En az bir küçük harf (a-z)
                        </li>
                        <li id="reqUppercase" style="color: #999; margin: 3px 0;">
                            <span class="req-icon">❌</span> En az bir büyük harf (A-Z)
                        </li>
                    </ul>
                    <asp:CustomValidator ID="cvPassword" runat="server" 
                        ControlToValidate="txtPassword" 
                        ErrorMessage="Şifre gereksinimleri karşılanmıyor." 
                        ForeColor="Red" 
                        Display="Dynamic"
                        ClientValidationFunction="validatePassword"
                        OnServerValidate="cvPassword_ServerValidate"
                        ValidationGroup="RegisterForm">
                    </asp:CustomValidator>
                </div>

               

                

                <%-- Buton ve C# olay bağlantısı --%>
                <asp:Button ID="btnRegister" runat="server" Text="Kayıt Ol" OnClick="btnRegister_Click" CssClass="btn btn-primary" ValidationGroup="RegisterForm" />

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

        // Şifre validasyon fonksiyonu (Client-side)
        function validatePassword(source, arguments) {
            const password = arguments.Value;
            
            // Şifre gereksinimlerini kontrol et
            const hasMinLength = password.length >= 6;
            const hasLowercase = /[a-z]/.test(password);
            const hasUppercase = /[A-Z]/.test(password);
            
            // Her gereksinimi kontrol et ve görsel geri bildirim ver
            updatePasswordRequirement('reqLength', hasMinLength);
            updatePasswordRequirement('reqLowercase', hasLowercase);
            updatePasswordRequirement('reqUppercase', hasUppercase);
            
            // Tüm gereksinimler karşılanıyorsa geçerli
            arguments.IsValid = hasMinLength && hasLowercase && hasUppercase;
        }

        // Şifre gereksinimlerini görsel olarak güncelle
        function updatePasswordRequirement(reqId, isValid) {
            const reqElement = document.getElementById(reqId);
            if (!reqElement) return;
            
            const icon = reqElement.querySelector('.req-icon');
            if (icon) {
                if (isValid) {
                    icon.textContent = '✅';
                    reqElement.style.color = '#28a745';
                } else {
                    icon.textContent = '❌';
                    reqElement.style.color = '#999';
                }
            }
        }

        // Şifre alanı değiştiğinde gerçek zamanlı validasyon
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    const password = this.value;
                    
                    // Her karakter yazıldığında gereksinimleri kontrol et
                    const hasMinLength = password.length >= 6;
                    const hasLowercase = /[a-z]/.test(password);
                    const hasUppercase = /[A-Z]/.test(password);
                    
                    updatePasswordRequirement('reqLength', hasMinLength);
                    updatePasswordRequirement('reqLowercase', hasLowercase);
                    updatePasswordRequirement('reqUppercase', hasUppercase);
                    
                    // CustomValidator'ı manuel olarak çağır
                    if (typeof Page_ClientValidate === 'function') {
                        Page_ClientValidate('RegisterForm');
                    }
                });
            }
        });

        // Türkiye Telefon Formatı (0XXX XXX XX XX)
        const phoneInput = document.getElementById('<%= txtPhoneNumber.ClientID %>');
        if (phoneInput) {
            // +90 ile başlayan formatı da destekle
            phoneInput.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\D/g, ''); // Sadece rakamları al
                
                // +90 ile başlıyorsa onu kaldır ve 0 ekle
                if (value.startsWith('90') && value.length >= 10) {
                    value = '0' + value.slice(2);
                }
                
                // Eğer 90 ile başlamıyorsa ve 0 ile başlamıyorsa, 0 ekle
                if (value.length > 0 && !value.startsWith('0') && !value.startsWith('90')) {
                    value = '0' + value;
                }
                
                // Maksimum 11 haneli olmalı (0 + 10 hane)
                if (value.length > 11) {
                    value = value.slice(0, 11);
                }
                
                // Formatla: 0XXX XXX XX XX
                let formatted = '';
                if (value.length > 0) {
                    formatted = value.charAt(0); // İlk karakter (0)
                    
                    if (value.length > 1) {
                        formatted += value.slice(1, 4); // İlk 3 hane (555)
                    }
                    if (value.length > 4) {
                        formatted += ' ' + value.slice(4, 7); // Sonraki 3 hane (123)
                    }
                    if (value.length > 7) {
                        formatted += ' ' + value.slice(7, 9); // Sonraki 2 hane (45)
                    }
                    if (value.length > 9) {
                        formatted += ' ' + value.slice(9, 11); // Son 2 hane (67)
                    }
                }
                
                e.target.value = formatted;
            });
            
            // Backspace tuşu için özel kontrol
            phoneInput.addEventListener('keydown', function (e) {
                if (e.key === 'Backspace' && e.target.value.length > 0) {
                    // Geri al tuşuna basıldığında son karakteri kontrol et
                    // Eğer boşluk karakteriyse, onu ve bir önceki karakteri sil
                    const cursorPos = e.target.selectionStart;
                    if (cursorPos > 0 && e.target.value.charAt(cursorPos - 1) === ' ') {
                        e.preventDefault();
                        e.target.value = e.target.value.slice(0, cursorPos - 2) + e.target.value.slice(cursorPos - 1);
                        e.target.setSelectionRange(cursorPos - 2, cursorPos - 2);
                    }
                }
            });
            
            // Paste (yapıştır) için özel kontrol
            phoneInput.addEventListener('paste', function (e) {
                setTimeout(function() {
                    const pastedValue = phoneInput.value.replace(/\D/g, '');
                    if (pastedValue.length > 0) {
                        if (pastedValue.startsWith('90') && pastedValue.length >= 10) {
                            phoneInput.value = '0' + pastedValue.slice(2);
                        } else if (!pastedValue.startsWith('0')) {
                            phoneInput.value = '0' + pastedValue;
                        }
                        // Input event'i tetiklenerek formatlanacak
                        phoneInput.dispatchEvent(new Event('input'));
                    }
                }, 10);
            });
        }
    </script>
</body>
</html>
