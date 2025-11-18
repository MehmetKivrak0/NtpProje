// NtpProje.Entities/Concrete/ProjectRequestDTO.cs içinde:
using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class ProjectRequestDTO : BaseDTO
    {
        // DÜZELTME: Tüm alanlar PascalCase oldu.
        public int Project_request_id { get; set; } // CS0246 hatasını önlemek için alt çizgi korunabilir
        public string Contact_person { get; set; }
        public string Company_name { get; set; }
        public string Email { get; set; }
        public string Phone_number { get; set; }
        public string Project_details { get; set; }
        public bool Is_read { get; set; } = false;
        public decimal? Estimated_duration { get; set; }
        public string Ip_address { get; set; }

        // BaseDTO'dan gelenler: created_date, updated_date, is_active
    }
}