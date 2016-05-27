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
        // GET: Donation
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

        public ActionResult LoadAllDonation(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _donationBusiness.LoadAllDonation(param.sSearch,
                param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public int AddDonation(Donation donation, DonationSession session, int parishionerID, int Type, float InputValue, float ExchangeRate)
        {

            var converter = new DateConverter();
            session.DonationDate = converter.ConvertDateToString(session.DonationDate);
            session.ReceiptDate = converter.ConvertDateToString(session.ReceiptDate);

            int donationId = donation.Id;
            int sessionId = session.Id;
            string currency = _donationBusiness.checkType(Type);

            //Final value caculation
            float finalValue = InputValue * ExchangeRate;
            using (var scope = new TransactionScope())
            {
                //add donation
                if (donationId == 0)
                {
                    donationId = _donationBusiness.AddDonation(donation);
                    if (donationId < 0)
                    {
                        return -1;
                    }
                }

                //Check id session
                //if null -> insert session
                //Update donation level

                //if # null -> return -1
                if (sessionId == 0)
                {
                    session = new DonationSession()
                    {
                        DonationID = donationId,
                        DonationDate = session.DonationDate,
                        ReceiptDate = session.ReceiptDate,
                        Currency = currency,
                        InputValue = InputValue,
                        FinalValue = finalValue,
                        ExchangeRate = ExchangeRate

                    };
                    int sessionStatus = _sessionBusiness.AddSession(session);
                    if (sessionStatus < 0)
                    {
                        return sessionStatus;
                    }
                }
                else
                {
                    return -1;
                }
                //If success all
                scope.Complete();
                return donationId;

            }
            //return Type;
        }
    }
}