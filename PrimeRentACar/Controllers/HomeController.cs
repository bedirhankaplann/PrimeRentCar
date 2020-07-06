using PrimeRentACar.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace PrimeRentACar.Controllers
{
   
    public class HomeController : Controller
    {
        PrimeEntities primeEntities = new PrimeEntities();
        DateModel dateModel = new DateModel();
        public static List<Cars> carList = new List<Cars>();
        public static DateTime startDay;
        public static DateTime endDay;


       
        public static int totalDay = 1;

        // GET: Home
       
        public ActionResult Index()
        {
            
          

            List<SelectListItem> offices = new List<SelectListItem>();

            foreach (var item in primeEntities.Offices.ToList())
            {   //Text = Görünen kısımdır. Kategori ismini yazdıyoruz
                //Value = Değer kısmıdır.ID değerini atıyoruz
                offices.Add(new SelectListItem { Text = item.OfficeName, Value = item.OfficeName });
            }
            ViewBag.Offices = offices;

            return View();
        }


        [HttpPost]
        public ActionResult Index(String offices, DateModel dateModel)
        {
           
            totalDay = dateModel.rentEndDate.DayOfYear - dateModel.rentStartDate.DayOfYear;
            startDay = dateModel.rentStartDate;
            endDay = dateModel.rentEndDate;
            Session["TotalRentDay"] = dateModel.rentEndDate.Day - dateModel.rentStartDate.Day;
            Session["StartDay"] = dateModel.rentStartDate.Day;
            Session["EndDay"] = dateModel.rentStartDate.Day;
            Session["Office"] = offices;

                return RedirectToAction("ChooseCar", "Home");
         
        }


        [HttpGet]
        public ActionResult ChooseCar(string motorHacmi, string yakıtTuru, string vitesTuru, string siralama = "", int sirala = 0 )
        {

           List<Cars> carList = new List<Cars>();   

           
           foreach (var item in primeEntities.Cars.Where(r => r.isActive && r.CarRentStart != dateModel.rentStartDate && r.CarRentEnd != dateModel.rentEndDate).ToList())
           {
                carList.Add(item);

                foreach(var item2 in primeEntities.Suitability.Where(r => r.RentStartDate == startDay && r.RentEndDate == endDay).ToList())
                {
                    if(item.id == item2.CarId)
                    {
                        carList.Remove(item);
                    }
                    
                }
             
           }

            if (motorHacmi != null)
            {
               foreach (var item in carList.Where(r => r.CarEngineCapacity != motorHacmi).ToList())
                {
                    carList.Remove(item);
                }
            }
            if (yakıtTuru != null)
            {
                foreach (var item in carList.Where(r => r.CarFuelType != yakıtTuru).ToList())
                {
                    carList.Remove(item);
                }
            }
            if (vitesTuru != null)
            {
                foreach (var item in carList.Where(r => r.CarGearType != vitesTuru).ToList())
                {
                    carList.Remove(item);
                }
            }
            if (siralama.Equals("Artan"))
            {
                carList = carList.OrderBy(r => r.CarDailyPrice).ToList();
            }

            if (siralama.Equals("Azalan"))
            {
                carList = carList.OrderByDescending(r => r.CarDailyPrice).ToList();
            }


            if (sirala == 1)
             {
                 carList = carList.OrderBy(r => r.CarDailyPrice).ToList();
             }
             if (sirala == 2)
             {
                 carList = carList.OrderByDescending(r => r.CarDailyPrice).ToList();
             }

            if (totalDay == 0)
            {
                totalDay = 1;
            }
            for (int i = 0; i < carList.Count; i++)
            {
                carList[i].CarDailyPrice *= totalDay;
            }

            ViewBag.cars = carList;
            TempData["data"] = carList;
           // return RedirectToAction("SummaryAndPayment", "Home", carList);
            return View();
           
        }

      
        [HttpGet]
        public ActionResult SummaryAndPayment(int id)
        {
            var a = TempData["data"];
            
            foreach (var cars in primeEntities.Cars.Where(r => r.id == id))
            {
                carList.Add(cars);
            }
            for (int i = 0; i < carList.Count; i++)
            {
                carList[i].CarDailyPrice *= totalDay;
            }
            ViewBag.carList = carList;
            TempData["car"] = carList;

            return View(ViewBag.carList);
        }

        [HttpPost]
        public ActionResult SummaryAndPayment( )
        {
            int memberID = Convert.ToInt32(Session["id"]);
            Suitability suitability = new Suitability();
            Cars cars = new Cars();
            
            suitability.CarId = carList[0].id;
            suitability.TotalPrice = carList[0].CarDailyPrice;
            suitability.MemberID = memberID;
            suitability.RentStartDate = startDay;
            suitability.RentEndDate = endDay;
            primeEntities.Suitability.Add(suitability);

            
     
            primeEntities.SaveChanges();


            return RedirectToAction("Profile", "Home");

        }
        public ActionResult Profile()
        {

            return View();
        }
        public ActionResult asss()
        {

            return View();
        }




        public ActionResult SignOut()
        {
            FormsAuthentication.SignOut();
            
            return RedirectToAction("Login", "Security");
        }

    }
}