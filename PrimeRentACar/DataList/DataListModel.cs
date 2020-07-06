using PrimeRentACar.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrimeRentACar.DataList
{
    public class DataList
    {

        public List<Cars> cars { get; set; }
        public List<Suitability> suitability { get; set; }
    }
}