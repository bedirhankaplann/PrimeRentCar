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
    
    public partial class Cars
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Cars()
        {
            this.Suitability = new HashSet<Suitability>();
        }
    
        public int id { get; set; }
        public string CarName { get; set; }
        public string CarModel { get; set; }
        public string CarModelYear { get; set; }
        public string CarEngineCapacity { get; set; }
        public string CarGearType { get; set; }
        public string CarFuelType { get; set; }
        public double CarDailyPrice { get; set; }
        public Nullable<System.DateTime> CarRentStart { get; set; }
        public Nullable<System.DateTime> CarRentEnd { get; set; }
        public bool isActive { get; set; }
        public string CarClass { get; set; }
        public string CarImage { get; set; }
        public string PersonMinAge { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Suitability> Suitability { get; set; }
    }
}
