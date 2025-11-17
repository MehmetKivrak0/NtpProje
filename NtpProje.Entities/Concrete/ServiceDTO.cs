using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class ServiceDTO : BaseDTO
    {
        public int service_id { get; set; }

        // DÜZELTME: 'title' yerine 'service_name' kullanýyoruz
        public string service_name { get; set; }

        public string slug { get; set; }
        public string description { get; set; }

        // YENÝ ALAN: 'summary' yerine 'short_description' kullanýyoruz
        public string short_description { get; set; }

        public string icon { get; set; }

        // YENÝ ALAN: 'icon_class'
        public string icon_class { get; set; }

        // YENÝ ALAN: 'image_url'
        public string image_url { get; set; }

        public int? display_order { get; set; }
        public int? view_count { get; set; }

        // is_active, created_date, updated_date BaseDTO'dan gelir.
        // NOT: UpdatedDate alaný veritabanýnda olduðu için Service katmanýnda kullanýlabilir.

        // Ýliþkili Özellikler
        // public List<ServiceFeatureDTO> features { get; set; } 
    }
}