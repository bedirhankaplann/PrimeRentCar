//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PrimeRentACar.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Suitability
    {
        public int id { get; set; }
        public int MemberID { get; set; }
        public int CarId { get; set; }
        public System.DateTime RentStartDate { get; set; }
        public System.DateTime RentEndDate { get; set; }
        public double TotalPrice { get; set; }
    
        public virtual Cars Cars { get; set; }
        public virtual Members Members { get; set; }
    }
}
