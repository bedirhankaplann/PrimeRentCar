using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrimeRentACar.Models
{
    public class DataListViewModel
    {
        public List<Cars> cars { get; set; }
        public List<Suitability> suitability { get; set; }
        public List<Members> members { get; set; }

    }
}