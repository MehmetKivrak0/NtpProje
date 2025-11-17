using NtpProje.Entities.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities.Concrete
{
    public class ProjectRequestDTO :BaseDTO
    {
        public int project_request_id { get; set; }
        public string contact_person { get; set; } // Yetkili Kişi (txtYetkili)
        public string company_name { get; set; } // Firma Adı (txtFirmaAdi)
        public string email { get; set; }
        public string phone_number { get; set; }
        public string project_details { get; set; } // Proje Detayları (txtProjeDetay)
        public bool is_read { get; set; } = false; // Admin tarafından okunup okunmadığı
        public decimal? estimated_duration { get; set; } // Tahmini süre (Admin doldurur, nullable olabilir)
        public string ip_address { get; set; }
    }
}
