using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class ProjectRequestDTO : BaseDTO
    {
        public int Id { get; set; }
        public string CompanyName { get; set; }
        public string AuthorizedPerson { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string ProjectDetails { get; set; }
        public DateTime RequestDate { get; set; }
        public string Status { get; set; }

        // --- DÜZELTME BURADA ---
        // Eskiden string'di, şimdi decimal? yaptık. Çünkü para sayıdır.
        public decimal? Budget { get; set; }

        // SQL: estimated_duration (Bu genelde "2 hafta" gibi yazı olur, string kalsın)
        public string EstimatedDuration { get; set; }

        public bool IsRead { get; set; }

        // Bu zaten decimal? idi, doğru.
        public decimal? QuotedPrice { get; set; }

        public DateTime? QuotedDate { get; set; }
        public string Notes { get; set; }
        public string IpAddress { get; set; }
    }
}