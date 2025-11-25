using System.Linq;
using NtpProje.Data.Concrete;

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
    }
}