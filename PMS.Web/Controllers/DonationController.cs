using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Models;
using System.Transactions;
using PMS.DataAccess.Utilities;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class DonationController : Controller
    {
        private readonly DonationBusiness _donationBusiness;
        private readonly CommunityBusiness _communityBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly DonationSessionBusiness _sessionBusiness;

        public DonationController()
        {
            _donationBusiness = new DonationBusiness(DbConfig.GetConnectionString());
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _sessionBusiness = new DonationSessionBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            var community = _communityBusiness.getAllCommunity().ToList();
            var vicariate = _vicariateBusiness.getAllVicariate().ToList();
            var parish = _parishBusiness.GetAllParish().ToList();

            ViewBag.Communities = community;
            ViewBag.Vicariates = vicariate;
            ViewBag.Parishes = parish;
            return View();
        }

        public ActionResult LoadAllDonation(jQueryDataTableParam param, int parishId, int communityId)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _donationBusiness.LoadAllDonation(param, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDonationSession(int DonationID)
        {
            var result = _donationBusiness.LoadDonationSession(DonationID);
            return Json(new
            {
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDonationByID(int parishionerID)
        {
            //return string.Empty;
            var donors = _donationBusiness.GetDonationByID(parishionerID);

            JsonResult jr = Json(new { result = donors }, JsonRequestBehavior.AllowGet);
            return jr;
        }

        public int AddDonation(int parishionerID)
        {
            Donation donation = new Donation();
            donation.ParishionerID = parishionerID;
            //add donation                    
            return _donationBusiness.AddDonation(donation);
        }

        public int UpdateDonation(int donationId, int parishionerID)
        {
            var result = _donationBusiness.UpdateDonation(donationId, parishionerID);
            return result;
        }

        public int AddDonationDetail(int donationId, string donationDate, int parishionerID, int type, float inputValue, float exchangeRate, string note)
        {
            var converter = new DateConverter();
            string currency = _donationBusiness.checkType(type);

            //Final value caculation
            float finalValue = inputValue * exchangeRate;


            using (var scope = new TransactionScope())
            {
                if (donationId == 0)
                {
                    Donation donation = new Donation();
                    donation.ParishionerID = parishionerID;
                    //add donation                    
                    donationId = _donationBusiness.AddDonation(donation);
                    if (donationId < 0)
                    {
                        return -1;
                    }
                }

                var session = new DonationSession()
                {
                    DonationID = donationId,
                    DonationDate = donationDate,
                    ReceiptDate = string.Empty,
                    Currency = currency,
                    InputValue = inputValue,
                    FinalValue = finalValue,
                    ExchangeRate = exchangeRate,
                    Note = note
                };
                int sessionStatus = _sessionBusiness.AddSession(session);
                if (sessionStatus < 0)
                {
                    return sessionStatus;
                }

                //If success all
                scope.Complete();
                return donationId;
            }
        }

        public int UpdateDonationDetail(int sessionId, string donationDate, int type, float inputValue, float exchangeRate, string note)
        {
            var converter = new DateConverter();
            string currency = _donationBusiness.checkType(type);

            //Final value caculation
            float finalValue = inputValue * exchangeRate;


            var session = new DonationSession()
            {
                Id = sessionId,
                DonationDate = donationDate,
                ReceiptDate = string.Empty,
                Currency = currency,
                InputValue = inputValue,
                FinalValue = finalValue,
                ExchangeRate = exchangeRate,
                Note = note
            };
            return _sessionBusiness.UpdateSession(session);
        }

        public ActionResult GetSessionDetail(int sessionId)
        {
            var sessionDetail = _donationBusiness.GetSessionByID(sessionId);

            JsonResult jr = Json(new { result = sessionDetail }, JsonRequestBehavior.AllowGet);
            return jr;
        }

        public int DeleteSession(int sessionId)
        {
            return _sessionBusiness.DeleteSession(sessionId);
        }

        public int DeleteDonation(int donationId)
        {
            return _donationBusiness.DeleteDonation(donationId);
        }
    }
}