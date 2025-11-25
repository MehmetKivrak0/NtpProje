using System;
using System.Linq;
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel; // Entity (setting) burada

namespace NtpProje.Data.Concrete
{
    // Repository<setting> miras aldığımız için temel metotlar (Add, Delete vb.) otomatik gelir.
    public class SettingRepository : Repository<setting>
    {
        // ÖZEL METOT: Anahtar kelimeye göre ayar getirme
        // Örn: GetByKey("site_email") -> "info@sirket.com" satırını döndürür.
        public setting GetByKey(string key)
        {
            // _table nesnesi Base Repository'den gelir.
            return _table.FirstOrDefault(x => x.setting_key == key);
        }
    }
}