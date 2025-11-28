using System.Linq;
using NtpProje.Data.Concrete;
using NtpProje.Data.DataModel;

namespace NtpProje.Business.Concrete
{
    public class SettingService
    {
        private readonly SettingRepository _repository;

        public SettingService()
        {
            _repository = new SettingRepository();
        }

        // En önemli metot bu: "Bana 'site_telefon'un değerini ver" diyoruz.
        public string GetValueByKey(string key)
        {
            try
            {
                // Veritabanında setting_key sütununa göre arama yapıyoruz
                var setting = _repository.GetAll().FirstOrDefault(x => x.setting_key == key);

                // Varsa değerini, yoksa boş string döndür
                return setting != null ? setting.setting_value : "";
            }
            catch
            {
                return "Veri Çekilemedi";
            }
        }

        // Ayarları güncellemek için metot
        public bool SetValueByKey(string key, string value)
        {
            try
            {
                // Önce mevcut ayarı bul
                var setting = _repository.GetByKey(key);

                if (setting != null)
                {
                    // Mevcut ayar varsa güncelle
                    setting.setting_value = value;
                    _repository.Update(setting);
                    return true;
                }
                else
                {
                    // Yoksa yeni oluştur
                    var newSetting = new setting
                    {
                        setting_key = key,
                        setting_value = value
                    };
                    _repository.Add(newSetting);
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}