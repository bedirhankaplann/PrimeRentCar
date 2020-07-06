using PrimeRentACar.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;


namespace PrimeRentACar.Controllers
{
    [AllowAnonymous]
    public class SecurityController : Controller
    {
        PrimeEntities primeEntities = new PrimeEntities();
        // GET: Login
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(Members userModel)
        {
            if(ModelState.IsValid)
            {
                userModel.Password = ConvertSHA256(userModel.Password);
                try
                {
                    var currentUser = primeEntities
                        .Members
                        .FirstOrDefault(r => r.Email == userModel.Email && r.Password == userModel.Password && r.isActive == true);
                    if (currentUser != null)
                    {
                        Session["active"] = "1";
                        Session["id"] = currentUser.id;
                        Session["Name"] = currentUser.Name;
                        Session["Surname"] = currentUser.Surname;
                        Session["AdminImage"] = currentUser.ImageUrl;
                        Session["DateOfBirth"] = currentUser.DateOfBirth;
                        Session["IDNo"] = currentUser.IDNo;
                        Session["Email"] = currentUser.Email;
                        Session["Phone"] = currentUser.Phone;
                        TempData["user"] = currentUser;

                        FormsAuthentication.SetAuthCookie(currentUser.id.ToString(), false);
                        TempData["userId"] = currentUser.id;

                        if(currentUser.Role == "Member")
                        {
                            return RedirectToAction("Index", "Home");
                        }
                        return RedirectToAction("Index", "Admin", new { area = "Admin" });
                        
                    }
                    else
                    {
                        ViewBag.message = "Lütfen Bilgilerinizi Kontrol Ediniz.";
                        return View();
                    }
                }
                catch(Exception e)
                {
                    ViewBag.message = "Lütfen Bilgilerinizi Kontrol Ediniz. " + e.Message;
                    return View();
                }
            }
            return View();
        }


        public ActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SignUp(Members member)
        {
            if(ModelState.IsValid)
            {
                member.Password = ConvertSHA256(member.Password);
                member.Role = "Member";
                member.DateOfRegister = DateTime.Now;
                member.isActive = true;
                try
                {
                    primeEntities.Members.Add(member);
                    primeEntities.SaveChanges();
                    ViewBag.Info = "Teşekkürler, Kayıt İşlemi Başarıyla Tamamlandı.";

                    return RedirectToAction("Login", "Security");

                }
                catch(Exception e)
                {
                    ViewBag.Info = "Üzgünüz, Kayıt İşlemi Başarısız. " + e.Message;
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

        public ActionResult SasdignUp()
        {
            return View();
        }
    }
}