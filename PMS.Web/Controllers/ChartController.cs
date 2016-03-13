using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ChartController : Controller
    {
        private readonly ChartBusiness _chartBusiness;

        public ChartController()
        {
            _chartBusiness = new ChartBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetSumOfParishionerByYear(int vicariateId, int parishId, string[] years, int chartCondition)
        {
            int roleId = (int)Session["RoleId"];
            int dioceseId = (int)Session["DioceseId"];
            int[] baptismResult = new int[years.Length];
            int[] holyCommunionResult = new int[years.Length];
            int[] confirmationresult = new int[years.Length];

            int[] results = new int[years.Length];

            var chart = new ChartViewModel();


            if (roleId != 1)
            {
                parishId = (int)Session["ParishId"];
            }
            if (chartCondition == 1)
            {
                results = _chartBusiness.GetsumOfParishionerByYear(roleId, dioceseId, vicariateId, parishId, years);
                var chartBasic = new ChartBasicComponentViewModel();

                chartBasic.label = "Biểu đồ thống kê";
                chartBasic.fillColor = "rgba(151,187,205,0.5)";
                chartBasic.strokeColor = "rgba(151,187,205,0.8)";
                chartBasic.highlightFill = "rgba(151,187,205,0.75)";
                chartBasic.hightlightStroke = "rgba(151,187,205,1)";
                chartBasic.data = new int[years.Length];
                chart.labels = new string[years.Length];
                for (int i = 0; i < years.Length; i++)
                {
                    chartBasic.data[i] = results[i];
                    chart.labels[i] = years[i];
                }
                chart.datasets = new[] { chartBasic };
            }
            else
            {
                if (chartCondition == 2)
                {
                    results = _chartBusiness.GetSumOfMatrimonyByYear(roleId, dioceseId, vicariateId, parishId, years);
                    var chartBasic = new ChartBasicComponentViewModel();

                    chartBasic.label = "Biểu đồ thống kê";
                    chartBasic.fillColor = "rgba(151,187,205,0.5)";
                    chartBasic.strokeColor = "rgba(151,187,205,0.8)";
                    chartBasic.highlightFill = "rgba(151,187,205,0.75)";
                    chartBasic.hightlightStroke = "rgba(151,187,205,1)";
                    chartBasic.data = new int[years.Length];
                    chart.labels = new string[years.Length];
                    for (int i = 0; i < years.Length; i++)
                    {
                        chartBasic.data[i] = results[i];
                        chart.labels[i] = years[i];
                    }
                    chart.datasets = new[] { chartBasic };
                }
                else
                {
                    if (chartCondition == 3)
                    {
                        var sacramentResult = _chartBusiness.GetSumOfSacramentByYear(roleId, dioceseId, vicariateId,
                            parishId, years, out baptismResult, out holyCommunionResult, out confirmationresult);

                        var baptismChartBasic = new ChartBasicComponentViewModel();
                        var holyCommunionChartBasic = new ChartBasicComponentViewModel();
                        var confirmationChartBasic = new ChartBasicComponentViewModel();

                        baptismChartBasic.label = "Rửa tội";
                        baptismChartBasic.fillColor = "rgba(151,187,205,0.5)";
                        baptismChartBasic.strokeColor = "rgba(151,187,205,0.8)";
                        baptismChartBasic.highlightFill = "rgba(151,187,205,0.75)";
                        baptismChartBasic.hightlightStroke = "rgba(151,187,205,1)";
                        baptismChartBasic.pointColor = "rgba(220,220,220,1)";
                        baptismChartBasic.pointStrokeColor = "#fff";
                        baptismChartBasic.pointHighlightFill = "#fff";
                        baptismChartBasic.pointHighlightStroke = "rgba(220,220,220,1)";
                        baptismChartBasic.data = new int[years.Length];

                        holyCommunionChartBasic.label = "Xưng tội rước lễ";
                        holyCommunionChartBasic.fillColor = "rgba(151,249,190,0.5)";
                        holyCommunionChartBasic.strokeColor = "rgba(255,255,255,1)";
                        holyCommunionChartBasic.highlightFill = "rgba(151,187,205,0.75)";
                        holyCommunionChartBasic.hightlightStroke = "rgba(151,187,205,1)";
                        holyCommunionChartBasic.pointColor = "rgba(151,187,205,1)";
                        holyCommunionChartBasic.pointStrokeColor = "#fff";
                        holyCommunionChartBasic.pointHighlightFill = "#fff";
                        holyCommunionChartBasic.pointHighlightStroke = "rgba(151,187,205,1)";
                        holyCommunionChartBasic.data = new int[years.Length];

                        confirmationChartBasic.label = "Thêm sức";
                        confirmationChartBasic.fillColor = "rgba(252,147,65,0.5)";
                        confirmationChartBasic.strokeColor = "rgba(255,255,255,1)";
                        confirmationChartBasic.highlightFill = "rgba(151,187,205,0.75)";
                        confirmationChartBasic.hightlightStroke = "rgba(151,187,205,1)";
                        confirmationChartBasic.pointColor = "rgba(173,173,173,1)";
                        confirmationChartBasic.pointStrokeColor = "#fff";
                        confirmationChartBasic.pointHighlightFill = "#fff";
                        confirmationChartBasic.pointHighlightStroke = "rgba(151,187,205,1)";
                        confirmationChartBasic.data = new int[years.Length];

                        chart.labels = new string[years.Length];
                        for (int i = 0; i < years.Length; i++)
                        {
                            baptismChartBasic.data[i] = baptismResult[i];
                            holyCommunionChartBasic.data[i] = holyCommunionResult[i];
                            confirmationChartBasic.data[i] = confirmationresult[i];

                            chart.labels[i] = years[i];
                        }
                        chart.datasets = new[] { baptismChartBasic, holyCommunionChartBasic, confirmationChartBasic };
                    }
                    else
                    {
                        if (chartCondition == 4)
                        {
                            List<ChartCommunityViewModel> chartCommunityResult =
                                _chartBusiness.GetSumOfParishionerByCommunity(parishId).ToList();
                            int chartCommunityLenght = chartCommunityResult.Count;

                            var chartBasic = new ChartBasicComponentViewModel();
                            int i = 0;

                            chartBasic.label = "Số giáo dân";
                            chartBasic.fillColor = "rgba(151,187,205,0.5)";
                            chartBasic.strokeColor = "rgba(151,187,205,0.8)";
                            chartBasic.highlightFill = "rgba(151,187,205,0.75)";
                            chartBasic.hightlightStroke = "rgba(151,187,205,1)";
                            chartBasic.data = new int[chartCommunityLenght];
                            chart.labels = new string[chartCommunityLenght];
                            foreach (var item in chartCommunityResult)
                            {
                                chartBasic.data[i] = item.SumOfParishioner;
                                chart.labels[i] = item.CommunityName;
                                i++;
                            }
                            chart.datasets = new[] { chartBasic };
                        }
                        else
                        {
                            if (chartCondition == 5)
                            {
                                results = _chartBusiness.GetsumOfParishionersWereBornByYear(roleId, dioceseId, vicariateId, parishId, years);
                                var chartBasic = new ChartBasicComponentViewModel();

                                chartBasic.label = "Số giáo dân được sinh ra";
                                chartBasic.fillColor = "rgba(151,187,205,0.5)";
                                chartBasic.strokeColor = "rgba(151,187,205,0.8)";
                                chartBasic.highlightFill = "rgba(151,187,205,0.75)";
                                chartBasic.hightlightStroke = "rgba(151,187,205,1)";
                                chartBasic.data = new int[years.Length];
                                chart.labels = new string[years.Length];
                                for (int i = 0; i < years.Length; i++)
                                {
                                    chartBasic.data[i] = results[i];
                                    chart.labels[i] = years[i];
                                }
                                chart.datasets = new[] { chartBasic };
                            }
                            else
                            {
                                var AgeCompareResult = _chartBusiness.GetsumOfParishionerByAge(roleId, dioceseId,
                                    vicariateId, parishId);
                                var chartBasic = new ChartBasicComponentViewModel();

                                chartBasic.label = "Số giáo dân";
                                chartBasic.fillColor = "rgba(151,187,205,0.5)";
                                chartBasic.strokeColor = "rgba(151,187,205,0.8)";
                                chartBasic.highlightFill = "rgba(151,187,205,0.75)";
                                chartBasic.hightlightStroke = "rgba(151,187,205,1)";
                                chartBasic.data = new int[7];
                                chart.labels = new string[7];
                                for (int i = 0; i < 7; i++)
                                {
                                    chartBasic.data[i] = AgeCompareResult[i];
                                }
                                //
                                chart.labels[0] = "Dưới 7 tuổi";
                                chart.labels[1] = "7 đến 12";
                                chart.labels[2] = "13 đến 16";
                                chart.labels[3] = "17 đến 25";
                                chart.labels[4] = "26 đến 30";
                                chart.labels[5] = "31 đến 50";
                                chart.labels[6] = "Trên 50 tuổi";
                                //
                                chart.datasets = new[] { chartBasic };
                            }
                        }
                    }
                }
            }

            return Json(new { result = chart }, JsonRequestBehavior.AllowGet);
        }
    }
}