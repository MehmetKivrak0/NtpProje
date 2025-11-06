using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities
{
    public class Service
    {
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string Description { get; set; }
        public string IconClass { get; set; } // "fa-star" gibi bir ikon sınıfı
    }
}
