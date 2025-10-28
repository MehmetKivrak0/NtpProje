using NtpProje.DataAccess; // Bu satır ProjeContext'i bulur
using NtpProje.Entities;   // Bu satır User sınıfını bulur
using System;
using System.Linq;

namespace NtpProje.Business
{
    public class UserManager
    {
        // Kullanıcı Bulma İşlemi
        public User GetUserById(int userId)
        {
            try
            {
                using (var context = new ProjeContext())
                {
                    return context.Users.Find(userId);
                }
            }
            catch (Exception ex)
            {

                // Hatayı loglamak iyi bir pratiktir
                System.Diagnostics.Debug.WriteLine("GetUserById Hatası: " + ex.ToString());
                return null; // Hata olursa null döndür
            }
        }


        // GİRİŞ YAP İŞLEMİ
        // Arayüzden (Login.aspx.cs) email ve password alır.
        public User Login(string email, string password)
        {
            try
            {
                // 'using' bloğu, işlem bitince veritabanı bağlantısını
                // otomatik olarak güvenli bir şekilde kapatır.
                using (var context = new ProjeContext())
                {
                    // LINQ Sorgusu: Users tablosunda, Email'i ve Password'ü
                    // eşleşen ilk kaydı bul ve geri döndür.
                    return context.Users.FirstOrDefault(user =>
                        user.Email == email && user.Password == password);
                }
            }
            catch
            {
                // Bir hata (örn: veritabanı kapalı) olursa null döndür.
                return null;
            }
        }

        // KAYIT OL İŞLEMİ
        // Arayüzden (Register.aspx.cs) dolu bir 'User' nesnesi alır.
        public bool Register(User newUser)
        {
            try
            {
                using (var context = new ProjeContext())
                {
                    // Bu e-posta zaten kayıtlı mı diye kontrol et
                    var existingUser = context.Users.FirstOrDefault(user => user.Email == newUser.Email);
                    if (existingUser != null)
                    {
                        return false; // E-posta zaten alınmış, kaydı durdur.
                    }

                    // Yeni kullanıcıya varsayılan bir rol ata
                    newUser.Role = "Uye"; // "Admin" değil, normal "Üye"

                    // EF aracılığıyla yeni kullanıcıyı 'Users' tablosuna ekle (henüz kaydetmedi)
                    context.Users.Add(newUser);

                    // Değişiklikleri veritabanına fiziksel olarak kaydet (INSERT komutu)
                    context.SaveChanges();
                }
                return true; // İşlem başarılı
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("--- KAYIT HATASI ---");
                System.Diagnostics.Debug.WriteLine(ex.ToString());
                System.Diagnostics.Debug.WriteLine("--- HATA DETAYI BİTTİ ---");

                return false; // Yine false döndür ama hatayı görmüş olduk
            }
        }

        public bool UpdateProfile(User userToUpdate)
        {
            try
            {
                using (var context = new ProjeContext())
                {
                    // E-posta başkası tarafından kullanılıyor mu kontrolü
                    var existingUserWithEmail = context.Users.FirstOrDefault(u =>
                        u.Email == userToUpdate.Email && u.UserId != userToUpdate.UserId);

                    if (existingUserWithEmail != null)
                    {
                        return false; // E-posta başkasına ait.
                    }

                    // EF'ye nesnenin değiştiğini bildir
                    context.Entry(userToUpdate).State = System.Data.Entity.EntityState.Modified;

                    // Şifre ve Rolü GÜNCELLEME!
                    context.Entry(userToUpdate).Property(u => u.Password).IsModified = false;
                    context.Entry(userToUpdate).Property(u => u.Role).IsModified = false;

                    context.SaveChanges(); // Değişiklikleri kaydet
                }
                return true; // Başarılı
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("UpdateProfile Hatası: " + ex.ToString());
                return false; // Başarısız
            }
        }



    }

}