using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities
{
    public class Project
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; } // Proje resmi
        public DateTime ProjectDate { get; set; }
        public string ClientName { get; set; } // Müşteri adı
    }
}
