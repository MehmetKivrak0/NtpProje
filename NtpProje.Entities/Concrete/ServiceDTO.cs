using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class ServiceDTO : BaseDTO
    {
        // BaseDTO'dan Id ve Name gelir (ServiceId, ServiceName)
        public string Description { get; set; }
        public string IconClass { get; set; }

        public ServiceDTO() { }

        public ServiceDTO(int id, string name, string description)
        {
            this.Id = id;
            this.Name = name;
            this.Description = description;
        }

        public override string ToString()
        {
            return $"Service: {Name} - {Description}";
        }
    }
}

