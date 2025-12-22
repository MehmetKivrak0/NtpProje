using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities.Abstract
{
    /// Generic Repository için tip güvenliği sağlayan interface.
    public interface IEntity
    {
        int Id { get; set; }
    }
}
