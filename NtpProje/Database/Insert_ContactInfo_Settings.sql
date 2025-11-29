-- =============================================
-- Footer İletişim Bilgileri için Settings Tablosuna Veri Ekleme
-- =============================================
-- Bu script, footer'daki iletişim bilgilerini settings tablosuna ekler.
-- Eğer kayıtlar zaten varsa, günceller (MERGE kullanarak).

-- 1. ADRES BİLGİSİ
IF NOT EXISTS (SELECT 1 FROM settings WHERE setting_key = 'site_address')
BEGIN
    INSERT INTO settings (setting_key, setting_value, setting_type, description, updated_date)
    VALUES ('site_address', 'Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / İzmir', 'text', 'Site adres bilgisi (Footer ve İletişim sayfasında kullanılır)', GETDATE());
END
ELSE
BEGIN
    UPDATE settings 
    SET setting_value = 'Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / İzmir',
        updated_date = GETDATE()
    WHERE setting_key = 'site_address';
END

-- 2. TELEFON BİLGİSİ
IF NOT EXISTS (SELECT 1 FROM settings WHERE setting_key = 'site_phone')
BEGIN
    INSERT INTO settings (setting_key, setting_value, setting_type, description, updated_date)
    VALUES ('site_phone', '+90 232 464 1 184', 'text', 'Site telefon numarası (Footer ve İletişim sayfasında kullanılır)', GETDATE());
END
ELSE
BEGIN
    UPDATE settings 
    SET setting_value = '+90 232 464 1 184',
        updated_date = GETDATE()
    WHERE setting_key = 'site_phone';
END

-- 3. E-POSTA BİLGİSİ
IF NOT EXISTS (SELECT 1 FROM settings WHERE setting_key = 'site_email')
BEGIN
    INSERT INTO settings (setting_key, setting_value, setting_type, description, updated_date)
    VALUES ('site_email', 'info@gencbirey.com', 'text', 'Site e-posta adresi (Footer ve İletişim sayfasında kullanılır)', GETDATE());
END
ELSE
BEGIN
    UPDATE settings 
    SET setting_value = 'info@gencbirey.com',
        updated_date = GETDATE()
    WHERE setting_key = 'site_email';
END

-- 4. ÇALIŞMA SAATLERİ (İletişim sayfasında kullanılıyor)
IF NOT EXISTS (SELECT 1 FROM settings WHERE setting_key = 'site_working_hours')
BEGIN
    INSERT INTO settings (setting_key, setting_value, setting_type, description, updated_date)
    VALUES ('site_working_hours', 'Pazartesi - Cuma: 09:00 - 18:00', 'text', 'Çalışma saatleri bilgisi (İletişim sayfasında kullanılır)', GETDATE());
END

-- Kontrol: Eklenen kayıtları göster
SELECT 
    setting_key AS 'Ayar Anahtarı',
    setting_value AS 'Değer',
    description AS 'Açıklama',
    updated_date AS 'Güncellenme Tarihi'
FROM settings
WHERE setting_key IN ('site_address', 'site_phone', 'site_email', 'site_working_hours')
ORDER BY setting_key;

PRINT '✅ Footer iletişim bilgileri başarıyla eklendi/güncellendi!';

