<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IletisimMesajlari.aspx.cs" Inherits="NtpProje.pages.Admin.IletisimMesajlari" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>İletişim Mesajları - Admin Panel</title>
    <link rel="stylesheet" href="../../css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body class="dashboard">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">GB</div>
            <h2>Genç Birey</h2>
        </div>

        <nav class="sidebar-menu">
            <div class="menu-section">
                <div class="menu-section-title">Ana Menü</div>
                <a href="admin_dashboard.html" class="menu-item">
                    <i>📊</i> <span>Dashboard</span>
                </a>
                <a href="#" class="menu-item">
                    <i>📄</i> <span>Sayfalar</span>
                </a>
                <a href="YaziYonetimi.html" class="menu-item">
                    <i>📝</i> <span>Blog Yazıları</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🖼️</i> <span>Projeler</span>
                </a>
                <a href="#" class="menu-item">
                    <i>⚙️</i> <span>Hizmetler</span>
                </a>
            </div>

            <div class="menu-section">
                <div class="menu-section-title">İçerik Yönetimi</div>
                <a href="#" class="menu-item">
                    <i>🎨</i> <span>Medya</span>
                </a>
                <a href="#" class="menu-item">
                    <i>👥</i> <span>Ekip</span>
                </a>
                <a href="#" class="menu-item">
                    <i>💬</i> <span>Yorumlar</span>
                </a>
                <a href="IletisimMesajlari.html" class="menu-item active">
                    <i>📧</i> <span>Mesajlar</span>
                </a>
            </div>

            <div class="menu-section">
                <div class="menu-section-title">Ayarlar</div>
                <a href="KategoriYonetimi.html" class="menu-item">
                    <i>🏷️</i> <span>Kategoriler</span>
                </a>
                <a href="#" class="menu-item">
                    <i>👤</i> <span>Kullanıcılar</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🔧</i> <span>Site Ayarları</span>
                </a>
                <a href="#" class="menu-item">
                    <i>🔐</i> <span>Güvenlik</span>
                </a>
                <a href="#" class="menu-item" onclick="logout()">
                    <i>🚪</i> <span>Çıkış Yap</span>
                </a>
            </div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Topbar -->
        <div class="topbar">
            <div class="topbar-left">
                <h1>İletişim Mesajları</h1>
                <p>Gelen mesajları yönetin ve yanıtlayın</p>
            </div>
            <div class="topbar-right">
                <div class="topbar-user">
                    <div class="user-avatar" id="userAvatar">A</div>
                    <div class="user-info">
                        <div class="user-name" id="userName">Admin User</div>
                        <div class="user-role" id="userRole">Yönetici</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Message Stats -->
        <div class="message-stats">
            <div class="stat-card">
                <div class="stat-icon blue">📧</div>
                <div class="stat-content">
                    <h3>24</h3>
                    <p>Toplam Mesaj</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">✅</div>
                <div class="stat-content">
                    <h3>18</h3>
                    <p>Yanıtlanmış</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon orange">⏳</div>
                <div class="stat-content">
                    <h3>6</h3>
                    <p>Bekleyen</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon red">🔥</div>
                <div class="stat-content">
                    <h3>3</h3>
                    <p>Öncelikli</p>
                </div>
            </div>
        </div>

        <!-- Filters and Actions -->
        <div class="content-filters">
            <div class="filter-group">
                <select id="statusFilter" class="filter-select">
                    <option value="">Tüm Durumlar</option>
                    <option value="unread">Okunmamış</option>
                    <option value="read">Okunmuş</option>
                    <option value="replied">Yanıtlanmış</option>
                    <option value="priority">Öncelikli</option>
                </select>
                
                <select id="typeFilter" class="filter-select">
                    <option value="">Tüm Tipler</option>
                    <option value="general">Genel</option>
                    <option value="project">Proje</option>
                    <option value="service">Hizmet</option>
                    <option value="complaint">Şikayet</option>
                </select>

                <input type="text" id="searchInput" class="search-input" placeholder="Gönderen, konu veya içerik ara...">
            </div>

            <div class="action-buttons">
                <button class="btn btn-primary" onclick="markAllAsRead()">
                    <i>✅</i> Tümünü Okundu İşaretle
                </button>
                <button class="btn btn-secondary" onclick="exportMessages()">
                    <i>📤</i> Dışa Aktar
                </button>
            </div>
        </div>

        <!-- Messages List -->
        <div class="messages-container">
            <div class="messages-list">
                <!-- Message Item 1 -->
                <div class="message-item unread priority" data-id="1" onclick="openMessage(1)">
                    <div class="message-checkbox">
                        <input type="checkbox" class="message-check" data-id="1">
                    </div>
                    <div class="message-avatar">
                        <div class="avatar-circle">A</div>
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <h4>Ahmet Yılmaz</h4>
                            <span class="message-time">2 saat önce</span>
                        </div>
                        <div class="message-subject">Proje Teklifi Hakkında</div>
                        <div class="message-preview">Merhaba, ofis binası projemiz için teklif almak istiyoruz. Detayları paylaşabilir misiniz?</div>
                        <div class="message-meta">
                            <span class="message-type project">Proje</span>
                            <span class="message-priority">Öncelikli</span>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="btn-icon btn-reply" onclick="replyMessage(1)" title="Yanıtla">↩️</button>
                        <button class="btn-icon btn-delete" onclick="deleteMessage(1)" title="Sil">🗑️</button>
                    </div>
                </div>

                <!-- Message Item 2 -->
                <div class="message-item read" data-id="2" onclick="openMessage(2)">
                    <div class="message-checkbox">
                        <input type="checkbox" class="message-check" data-id="2">
                    </div>
                    <div class="message-avatar">
                        <div class="avatar-circle">Z</div>
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <h4>Zeynep Şahin</h4>
                            <span class="message-time">1 gün önce</span>
                        </div>
                        <div class="message-subject">Blog Yazısı Hakkında Soru</div>
                        <div class="message-preview">Yazınızı okudum, çok faydalıydı. Bu konuda daha detaylı bilgi alabilir miyim?</div>
                        <div class="message-meta">
                            <span class="message-type general">Genel</span>
                            <span class="message-status replied">Yanıtlandı</span>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="btn-icon btn-reply" onclick="replyMessage(2)" title="Yanıtla">↩️</button>
                        <button class="btn-icon btn-delete" onclick="deleteMessage(2)" title="Sil">🗑️</button>
                    </div>
                </div>

                <!-- Message Item 3 -->
                <div class="message-item unread" data-id="3" onclick="openMessage(3)">
                    <div class="message-checkbox">
                        <input type="checkbox" class="message-check" data-id="3">
                    </div>
                    <div class="message-avatar">
                        <div class="avatar-circle">M</div>
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <h4>Mehmet Kaya</h4>
                            <span class="message-time">2 gün önce</span>
                        </div>
                        <div class="message-subject">Hizmet Bilgisi</div>
                        <div class="message-preview">3D modelleme hizmetleriniz hakkında bilgi almak istiyorum. Fiyat listesi var mı?</div>
                        <div class="message-meta">
                            <span class="message-type service">Hizmet</span>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="btn-icon btn-reply" onclick="replyMessage(3)" title="Yanıtla">↩️</button>
                        <button class="btn-icon btn-delete" onclick="deleteMessage(3)" title="Sil">🗑️</button>
                    </div>
                </div>

                <!-- Message Item 4 -->
                <div class="message-item read" data-id="4" onclick="openMessage(4)">
                    <div class="message-checkbox">
                        <input type="checkbox" class="message-check" data-id="4">
                    </div>
                    <div class="message-avatar">
                        <div class="avatar-circle">E</div>
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <h4>Elif Demir</h4>
                            <span class="message-time">3 gün önce</span>
                        </div>
                        <div class="message-subject">İş Başvurusu</div>
                        <div class="message-preview">Mimarlık ofisinizde çalışmak istiyorum. CV'mi ekliyorum.</div>
                        <div class="message-meta">
                            <span class="message-type general">Genel</span>
                            <span class="message-status replied">Yanıtlandı</span>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="btn-icon btn-reply" onclick="replyMessage(4)" title="Yanıtla">↩️</button>
                        <button class="btn-icon btn-delete" onclick="deleteMessage(4)" title="Sil">🗑️</button>
                    </div>
                </div>

                <!-- Message Item 5 -->
                <div class="message-item unread" data-id="5" onclick="openMessage(5)">
                    <div class="message-checkbox">
                        <input type="checkbox" class="message-check" data-id="5">
                    </div>
                    <div class="message-avatar">
                        <div class="avatar-circle">C</div>
                    </div>
                    <div class="message-content">
                        <div class="message-header">
                            <h4>Can Özkan</h4>
                            <span class="message-time">4 gün önce</span>
                        </div>
                        <div class="message-subject">Şikayet</div>
                        <div class="message-preview">Web sitenizde teknik bir sorun var. İletişim formu çalışmıyor.</div>
                        <div class="message-meta">
                            <span class="message-type complaint">Şikayet</span>
                            <span class="message-priority">Öncelikli</span>
                        </div>
                    </div>
                    <div class="message-actions">
                        <button class="btn-icon btn-reply" onclick="replyMessage(5)" title="Yanıtla">↩️</button>
                        <button class="btn-icon btn-delete" onclick="deleteMessage(5)" title="Sil">🗑️</button>
                    </div>
                </div>
            </div>

            <!-- Message Detail Panel -->
            <div class="message-detail" id="messageDetail" style="display: none;">
                <div class="message-detail-header">
                    <button class="btn btn-sm btn-secondary" onclick="closeMessageDetail()">← Geri</button>
                    <div class="message-detail-actions">
                        <button class="btn btn-sm btn-primary" onclick="replyToCurrentMessage()">Yanıtla</button>
                        <button class="btn btn-sm btn-danger" onclick="deleteCurrentMessage()">Sil</button>
                    </div>
                </div>

                <div class="message-detail-content" id="messageDetailContent">
                    <!-- Message content will be loaded here -->
                </div>
            </div>
        </div>

        <!-- Bulk Actions -->
        <div class="bulk-actions" id="bulkActions" style="display: none;">
            <span class="bulk-info">Seçili mesajlar:</span>
            <button class="btn btn-sm btn-success" onclick="bulkAction('markRead')">Okundu İşaretle</button>
            <button class="btn btn-sm btn-warning" onclick="bulkAction('markUnread')">Okunmamış İşaretle</button>
            <button class="btn btn-sm btn-danger" onclick="bulkAction('delete')">Sil</button>
        </div>
    </main>

    <!-- Reply Modal -->
    <div id="replyModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Mesaj Yanıtla</h3>
                <button class="modal-close" onclick="closeReplyModal()">×</button>
            </div>
            <form id="replyForm">
                <input type="hidden" id="replyToMessageId" name="messageId">
                
                <div class="form-group">
                    <label for="replyTo">Kime</label>
                    <input type="email" id="replyTo" name="replyTo" readonly>
                </div>
                
                <div class="form-group">
                    <label for="replySubject">Konu</label>
                    <input type="text" id="replySubject" name="replySubject" required>
                </div>
                
                <div class="form-group">
                    <label for="replyContent">Mesaj</label>
                    <textarea id="replyContent" name="replyContent" rows="8" required></textarea>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeReplyModal()">İptal</button>
                    <button type="submit" class="btn btn-primary">Gönder</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let currentMessageId = null;

        // Sayfa yüklendiğinde
        window.addEventListener('load', function() {
            checkAuth();
            loadUserInfo();
        });

        // Kullanıcı girişi kontrolü
        function checkAuth() {
            const adminUser = localStorage.getItem('adminUser');
            if (!adminUser) {
                window.location.href = 'login.html';
                return;
            }
        }

        // Kullanıcı bilgilerini yükle
        function loadUserInfo() {
            const adminUser = localStorage.getItem('adminUser');
            if (adminUser) {
                const user = JSON.parse(adminUser);
                const initial = user.name ? user.name.charAt(0).toUpperCase() : 'A';
                document.getElementById('userAvatar').textContent = initial;
                document.getElementById('userName').textContent = user.name || 'Admin';
                document.getElementById('userRole').textContent = user.role || 'Yönetici';
            }
        }

        // Mesaj aç
        function openMessage(id) {
            currentMessageId = id;
            
            // Demo mesaj verisi
            const messageData = {
                id: id,
                sender: 'Ahmet Yılmaz',
                email: 'ahmet@example.com',
                subject: 'Proje Teklifi Hakkında',
                content: `Merhaba,

Ofis binası projemiz için mimari tasarım hizmeti almak istiyoruz. Proje detayları:

- Konum: İstanbul, Şişli
- Alan: 2,500 m²
- Kat sayısı: 8 kat
- Bütçe: ₺ 5,000,000

Bu konuda teklif alabilir miyiz? Görüşme için uygun zamanlarınızı paylaşabilir misiniz?

Teşekkürler,
Ahmet Yılmaz`,
                date: '2025-01-15 14:30',
                type: 'project',
                priority: true
            };

            // Mesaj detayını göster
            const detailContent = document.getElementById('messageDetailContent');
            detailContent.innerHTML = `
                <div class="message-detail-meta">
                    <div class="message-detail-sender">
                        <strong>${messageData.sender}</strong>
                        <span>${messageData.email}</span>
                    </div>
                    <div class="message-detail-date">${messageData.date}</div>
                </div>
                <div class="message-detail-subject">${messageData.subject}</div>
                <div class="message-detail-body">${messageData.content.replace(/\n/g, '<br>')}</div>
            `;

            document.getElementById('messageDetail').style.display = 'block';
            
            // Mesajı okundu olarak işaretle
            const messageItem = document.querySelector(`[data-id="${id}"]`);
            messageItem.classList.remove('unread');
            messageItem.classList.add('read');
        }

        // Mesaj detayını kapat
        function closeMessageDetail() {
            document.getElementById('messageDetail').style.display = 'none';
            currentMessageId = null;
        }

        // Mesaj yanıtla
        function replyMessage(id) {
            const messageItem = document.querySelector(`[data-id="${id}"]`);
            const senderName = messageItem.querySelector('h4').textContent;
            
            document.getElementById('replyToMessageId').value = id;
            document.getElementById('replyTo').value = senderName.toLowerCase().replace(' ', '.') + '@example.com';
            document.getElementById('replySubject').value = 'Re: ' + messageItem.querySelector('.message-subject').textContent;
            
            document.getElementById('replyModal').style.display = 'block';
        }

        // Mevcut mesaja yanıtla
        function replyToCurrentMessage() {
            if (currentMessageId) {
                replyMessage(currentMessageId);
            }
        }

        // Yanıt modalını kapat
        function closeReplyModal() {
            document.getElementById('replyModal').style.display = 'none';
        }

        // Yanıt formu
        document.getElementById('replyForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const messageId = formData.get('messageId');
            const replyTo = formData.get('replyTo');
            const subject = formData.get('replySubject');
            const content = formData.get('replyContent');
            
            if (!subject || !content) {
                showNotification('Lütfen tüm alanları doldurun!', 'error');
                return;
            }
            
            showNotification('Yanıt gönderildi!', 'success');
            closeReplyModal();
            
            // Mesajı yanıtlandı olarak işaretle
            const messageItem = document.querySelector(`[data-id="${messageId}"]`);
            const meta = messageItem.querySelector('.message-meta');
            if (!meta.querySelector('.message-status')) {
                meta.innerHTML += '<span class="message-status replied">Yanıtlandı</span>';
            }
        });

        // Mesaj sil
        function deleteMessage(id) {
            if (confirm('Bu mesajı silmek istediğinize emin misiniz?')) {
                const messageItem = document.querySelector(`[data-id="${id}"]`);
                messageItem.remove();
                showNotification('Mesaj silindi!', 'success');
            }
        }

        // Mevcut mesajı sil
        function deleteCurrentMessage() {
            if (currentMessageId) {
                deleteMessage(currentMessageId);
                closeMessageDetail();
            }
        }

        // Tümünü okundu işaretle
        function markAllAsRead() {
            const unreadMessages = document.querySelectorAll('.message-item.unread');
            unreadMessages.forEach(message => {
                message.classList.remove('unread');
                message.classList.add('read');
            });
            showNotification('Tüm mesajlar okundu olarak işaretlendi!', 'success');
        }

        // Mesajları dışa aktar
        function exportMessages() {
            showNotification('Mesajlar dışa aktarılıyor...', 'info');
        }

        // Toplu işlemler
        function bulkAction(action) {
            const checkedMessages = document.querySelectorAll('.message-check:checked');
            if (checkedMessages.length === 0) {
                showNotification('Lütfen en az bir mesaj seçin!', 'error');
                return;
            }

            let message = '';
            switch(action) {
                case 'markRead':
                    checkedMessages.forEach(check => {
                        const messageItem = check.closest('.message-item');
                        messageItem.classList.remove('unread');
                        messageItem.classList.add('read');
                    });
                    message = 'Seçili mesajlar okundu olarak işaretlendi!';
                    break;
                case 'markUnread':
                    checkedMessages.forEach(check => {
                        const messageItem = check.closest('.message-item');
                        messageItem.classList.remove('read');
                        messageItem.classList.add('unread');
                    });
                    message = 'Seçili mesajlar okunmamış olarak işaretlendi!';
                    break;
                case 'delete':
                    if (confirm('Seçili mesajları silmek istediğinize emin misiniz?')) {
                        checkedMessages.forEach(check => {
                            check.closest('.message-item').remove();
                        });
                        message = 'Seçili mesajlar silindi!';
                    } else {
                        return;
                    }
                    break;
            }

            showNotification(message, 'success');
            updateBulkActions();
        }

        // Toplu işlemler güncelle
        function updateBulkActions() {
            const checkedMessages = document.querySelectorAll('.message-check:checked');
            const bulkActions = document.getElementById('bulkActions');
            
            if (checkedMessages.length > 0) {
                bulkActions.style.display = 'block';
            } else {
                bulkActions.style.display = 'none';
            }
        }

        // Checkbox değişikliklerini dinle
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('message-check')) {
                updateBulkActions();
            }
        });

        // Arama fonksiyonu
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const messages = document.querySelectorAll('.message-item');
            
            messages.forEach(message => {
                const sender = message.querySelector('h4').textContent.toLowerCase();
                const subject = message.querySelector('.message-subject').textContent.toLowerCase();
                const preview = message.querySelector('.message-preview').textContent.toLowerCase();
                
                if (sender.includes(searchTerm) || subject.includes(searchTerm) || preview.includes(searchTerm)) {
                    message.style.display = '';
                } else {
                    message.style.display = 'none';
                }
            });
        });

        // Çıkış yap
        function logout() {
            if (confirm('Çıkış yapmak istediğinize emin misiniz?')) {
                localStorage.removeItem('adminUser');
                window.location.href = 'login.html';
            }
        }

        // Bildirim göster
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'alert alert-' + type;
            notification.textContent = message;
            notification.style.position = 'fixed';
            notification.style.top = '20px';
            notification.style.right = '20px';
            notification.style.zIndex = '10000';
            notification.style.minWidth = '300px';
            notification.style.animation = 'fadeIn 0.3s ease-in';
            
            document.body.appendChild(notification);
            
            setTimeout(function() {
                notification.style.animation = 'fadeOut 0.3s ease-out';
                setTimeout(function() {
                    notification.remove();
                }, 300);
            }, 3000);
        }

        // Modal dışına tıklandığında kapat
        window.addEventListener('click', function(e) {
            const replyModal = document.getElementById('replyModal');
            if (e.target === replyModal) {
                closeReplyModal();
            }
        });
    </script>
</body>
</html>
