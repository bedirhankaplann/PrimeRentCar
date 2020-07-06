using PrimeRentACar.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Security.Cryptography;
using System.Text;
using System.Data.Entity;
using System.Web.Security;

namespace PrimeRentACar.Areas.Admin.Controllers
{
    public class AdminController : Controller
    {
        PrimeEntities primeEntities = new PrimeEntities();
        DataListViewModel dataList = new DataListViewModel();

        // GET: Admin/Admin
        public ActionResult Index()
        {
            dataList.cars = primeEntities.Cars.ToList();
            dataList.suitability = primeEntities.Suitability.ToList();
            dataList.members = primeEntities.Members.ToList();
            Session["Total Car"] = dataList.cars.Count();
            Session["Total Admins"] = dataList.members.Where(r => r.Role == "Admin").Count();
            Session["Total Members"] = dataList.members.Where(r => r.Role == "Member").Count();
           // Session["AdminImage"] = dataList.members.Select(r => r.isActive);


            return View();
        }

        public ActionResult CreateAdmin()
        {

            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateAdmin(Members members, HttpPostedFileBase ImageUrl)
        {
            string ImageName = System.IO.Path.GetFileName(ImageUrl.FileName);
            string psychialPath = Server.MapPath("~/Areas/Admin/Images/" + ImageName);
            ImageUrl.SaveAs(psychialPath);
            members.ImageUrl = "/Areas/Admin/Images/" + ImageName;
            members.Password = ConvertSHA256(members.Password);
            members.DateOfRegister = DateTime.Now;
            members.Role = "Admin";
            if(ModelState.IsValid)
            {
                try
                {
                    primeEntities.Members.Add(members);
                    primeEntities.SaveChanges();
                    return RedirectToAction("ListAdmin", "Admin");
                }
                catch(Exception e)
                {
                    ViewBag.Bilgi = "Üzgünüz. Admin Ekleme İşlemi Başarısızdır. " + e.Message;
                    return View();
                }
            }
            return View();
        }

        public static string ConvertSHA256(string passData)
        {
            // Create a SHA256   
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // ComputeHash - returns byte array  
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(passData));

                // Convert byte array to a string   
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }

        }
        public ActionResult ListAdmin()
        {
            //var admins = primeEntities.Admins.ToList();
            dataList.members = primeEntities.Members.Where(r => r.Role == "Admin").ToList();
            return View(dataList);
        }
        public ActionResult EditAdmin(int id)
        {
                ViewBag.id = id;
               
            
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditAdmin(int id, Members members, HttpPostedFileBase ImageUrl)
        {
            ViewBag.id = id;
            if (ModelState.IsValid)
            {
                try
                {
                    if(ImageUrl != null)
                    {
                        string ImageName = System.IO.Path.GetFileName(ImageUrl.FileName);
                        string psychialPath = Server.MapPath("/CarImages/" + ImageName);
                        ImageUrl.SaveAs(psychialPath);
                        members.ImageUrl = "/Images/" + ImageName;
                    }
                    
                    members.Password = ConvertSHA256(members.Password);
                    members.DateOfRegister = DateTime.Now;
                    primeEntities.Entry(members).State = EntityState.Modified;
                    primeEntities.SaveChanges();
                    TempData["Success"] = "Düzenleme İşlemi Başarılı.";
                    return RedirectToAction("ListAdmin", "Admin");
                }
                catch (Exception e)
                {
                    ViewBag.error = "Düzenleme İşlemi Başarsız. " + e.Message;
                    return View();
                }
            }
            return View();
        }
        public ActionResult DeleteAdmin(int id)
        {
            ViewBag.id = id;
            dataList.members = primeEntities.Members.Where(r => r.Role == "Admin").ToList();
            return View(dataList);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteAdmin(int id, Members members)
        {
            if(ModelState.IsValid)
            {
                try
                {
                    members = primeEntities.Members.Find(id);
                    members.isActive = false;
                    primeEntities.SaveChanges();
                    ViewBag.success = "Silme İşlemi Başarıyla Tamamlandı. ";
                    return RedirectToAction("ListAdmin","Admin");
                }
                catch(Exception e)
                {
                    ViewBag.error = "Silme İşlemi Başarsız. " + e.Message;
                    return View();
                }
            }
            
            return View();
        }

        public ActionResult CreateCar()
        {
           
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCar(Cars car, HttpPostedFileBase ImageUrl)
        {
            
            if (ModelState.IsValid)
            {
                string ImageName = System.IO.Path.GetFileName(ImageUrl.FileName);
                string psychialPath = Server.MapPath("~/Areas/Admin/CarImages/" + ImageName);
                ImageUrl.SaveAs(psychialPath);
                car.CarImage = "/Areas/Admin/CarImages/" + ImageName;
                try
                {
                    primeEntities.Cars.Add(car);
                    primeEntities.SaveChanges();
                    ViewBag.success = "Araç Ekleme İşlemi Başarı İle Tamamlanmıştır.";
                    return RedirectToAction("ListCar", "Admin");
                }
                catch(Exception e)
                {
                    ViewBag.error = "Araç Ekleme İşlemi Başarısızdır. " + e.Message;
                    return View();
                }
            }
            return View();
        }
        public ActionResult ListCar()
        {
            dataList.cars = primeEntities.Cars.ToList();
            return View(dataList);
        }
        [HttpPost]
        public ActionResult ListCar(Cars cars)
        {
      
            return View();
        }
        public ActionResult EditCar(int id)
        {
            ViewBag.id = id;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCar(int id,Cars cars, HttpPostedFileBase ImageUrl)
        {
            ViewBag.id = id;
            if (ModelState.IsValid)
            {
                try
                {
                    if(ImageUrl != null)
                    {
                        string ImageName = System.IO.Path.GetFileName(ImageUrl.FileName);
                        string psychialPath = Server.MapPath("~/Areas/Admin/CarImages/" + ImageName);
                        ImageUrl.SaveAs(psychialPath);
                        cars.CarImage = "/Areas/Admin/CarImages/" + ImageName;
                        cars.CarRentStart = null;
                    }
                    
                    cars.CarRentEnd = null;
                    primeEntities.Entry(cars).State = EntityState.Modified;
                    primeEntities.SaveChanges();
                    TempData["Success"] = "Düzenleme İşlemi Başarılı.";
                    return RedirectToAction("ListCar", "Admin");
                }
                catch (Exception e)
                {
                    ViewBag.error = "Düzenleme İşlemi Başarsız. " + e.Message;
                    return View();
                }
            }
            return View();
        }

        public ActionResult DeleteCar(int id)
        {
            ViewBag.id = id;
            dataList.cars = primeEntities.Cars.ToList();
            return View(dataList);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCar(int id, Cars cars)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    cars = primeEntities.Cars.Find(id);
                    cars.isActive = false;
                    primeEntities.SaveChanges();
                    ViewBag.success = "Silme İşlemi Başarıyla Tamamlandı. ";
                    return RedirectToAction("ListCar", "Admin");
                }
                catch (Exception e)
                {
                    ViewBag.error = "Silme İşlemi Başarsız. " + e.Message;
                    return View();
                }
            }

            return View();
        }
        public ActionResult SignOut()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Login", "Security");
        }
    }
}