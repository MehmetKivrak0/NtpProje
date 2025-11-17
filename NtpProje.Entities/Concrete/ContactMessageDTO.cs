using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NtpProje.Entities.Abstract;
using NtpProje.Entities.Concrete;

namespace NtpProje.Entities.Concrete
{
    public class ContactMessageDTO :BaseDTO
    {
        public int contact_message_id { get; set; }
        public string full_name { get; set; }
        public string email { get; set; }
        public string phone_number { get; set; }
        public string subject { get; set; } // Konu
        public string message { get; set; }
        public bool is_read { get; set; } = false; // Admin tarafından okunup okunmadığı
        public DateTime? reply_date { get; set; } // Cevap tarihi (nullable olmalı)
        public string ip_address { get; set; }
    }
}
