using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ParishionerSacramentViewModel
    {
        private string christianName;
        private string name;
        private string birthDate;
        private string birthPlace;
        private string fatherName;
        private string motherName;
        private string priest;
        private string parishName;
        private string vicariateName;
        private string dioceseName;
        private string baptismDate;
        private string baptismPlace;
        private string baptismPriest;
        private string baptismPatron;
        private string baptismNumber;
        private string holyDate;
        private string holyPlace;
        private string holyPriest;
        private string holyNumber;
        private string confirmDate;
        private string confirmPlace;
        private string confirmPriest;
        private string confirmPatron;
        private string confirmNumber;

        private string husbandName;
        private string husbandBirthDate;
        private string husbandBirthPlace;
        private string husbandBaptism;
        private string husbandBaptismNumber;
        private string husbandFatherName;
        private string husbandMotherName;
        private string husbandParishName;

        private string wifeName;
        private string wifeBirthDate;
        private string wifeBirthPlace;
        private string wifeBaptism;
        private string wifeBaptismNumber;
        private string wifeFatherName;
        private string wifeMotherName;
        private string wifeParishName;

        private string matrimonyDate;
        private string matrimonyPlace;
        private string matrimonyPriest;
        private string matrimonyFirstWitness;
        private string matrimonySecondWitness;
        private string matrimonyNumber;

        public ParishionerSacramentViewModel()
        {
            christianName = "";
            name = "";
            birthDate = "";
            birthPlace = "";
            fatherName = "";
            motherName = "";
            priest = "";
            parishName = "";
            vicariateName = "";
            dioceseName = "";
            baptismDate = "";
            baptismPlace = "";
            baptismPriest = "";
            baptismPatron = "";
            baptismNumber = "";
            holyDate = "";
            holyPlace = "";
            holyPriest = "";
            holyNumber = "";
            confirmDate = "";
            confirmPlace = "";
            confirmPriest = "";
            confirmPatron = "";
            confirmNumber = "";

            husbandName = "";
            husbandBirthDate = "";
            husbandBirthPlace = "";
            husbandBaptism = "";
            husbandBaptismNumber = "";
            husbandFatherName = "";
            husbandMotherName = "";
            husbandParishName = "";

            wifeName = "";
            wifeBirthDate = "";
            wifeBirthPlace = "";
            wifeBaptism = "";
            wifeBaptismNumber = "";
            wifeFatherName = "";
            wifeMotherName = "";
            wifeParishName = "";

            matrimonyDate = "";
            matrimonyPlace = "";
            matrimonyPriest = "";
            matrimonyFirstWitness = "";
            matrimonySecondWitness = "";
            matrimonyNumber = "";
        }

        public string ChristianName
        {
            get { return christianName; }
            set { christianName = value ?? ""; }
        }

        public string Name
        {
            get { return name; }
            set { name = value ?? ""; }
        }

        public string BirthDate
        {
            get { return birthDate; }
            set { birthDate = value ?? ""; }
        }

        public string BirthPlace
        {
            get { return birthPlace; }
            set { birthPlace = value ?? ""; }
        }
        public string FatherName
        {
            get { return fatherName; }
            set { fatherName = value ?? ""; }
        }
        public string MotherName
        {
            get { return motherName; }
            set { motherName = value ?? ""; }
        }
        public string Priest
        {
            get { return priest; }
            set { priest = value ?? ""; }
        }
        public string ParishName
        {
            get { return parishName; }
            set { parishName = value ?? ""; }
        }
        public string VicariateName
        {
            get { return vicariateName; }
            set { vicariateName = value ?? ""; }
        }
        public string DioceseName
        {
            get { return dioceseName; }
            set { dioceseName = value ?? ""; }
        }

        public string BaptismDate
        {
            get { return baptismDate; }
            set { baptismDate = value ?? ""; }
        }
        public string BaptismPlace
        {
            get { return baptismPlace; }
            set { baptismPlace = value ?? ""; }
        }
        public string BaptismPriest
        {
            get { return baptismPriest; }
            set { baptismPriest = value ?? ""; }
        }
        public string BaptismPatron
        {
            get { return baptismPatron; }
            set { baptismPatron = value ?? ""; }
        }
        public string BaptismNumber
        {
            get { return baptismNumber; }
            set { baptismNumber = value ?? ""; }
        }

        public string HolyDate
        {
            get { return holyDate; }
            set { holyDate = value ?? ""; }
        }
        public string HolyPlace
        {
            get { return holyPlace; }
            set { holyPlace = value ?? ""; }
        }
        public string HolyPriest
        {
            get { return holyPriest; }
            set { holyPriest = value ?? ""; }
        }
        public string HolyNumber
        {
            get { return holyNumber; }
            set { holyNumber = value ?? ""; }
        }

        public string ConfirmDate
        {
            get { return confirmDate; }
            set { confirmDate = value ?? ""; }
        }
        public string ConfirmPlace
        {
            get { return confirmPlace; }
            set { confirmPlace = value ?? ""; }
        }
        public string ConfirmPriest
        {
            get { return confirmPriest; }
            set { confirmPriest = value ?? ""; }
        }
        public string ConfirmPatron
        {
            get { return confirmPatron; }
            set { confirmPatron = value ?? ""; }
        }
        public string ConfirmNumber
        {
            get { return confirmNumber; }
            set { confirmNumber = value ?? ""; }
        }

        public string HusbandName
        {
            get { return husbandName; }
            set { husbandName = value ?? ""; }
        }

        public string HusbandBirthDate
        {
            get { return husbandBirthDate; }
            set { husbandBirthDate = value ?? ""; }
        }

        public string HusbandBirthPlace
        {
            get { return husbandBirthPlace; }
            set { husbandBirthPlace = value ?? ""; }
        }

        public string HusbandBaptism
        {
            get { return husbandBaptism; }
            set { husbandBaptism = value ?? ""; }
        }

        public string HusbandBaptismNumber
        {
            get { return husbandBaptismNumber; }
            set { husbandBaptismNumber = value ?? ""; }
        }

        public string HusbandFatherName
        {
            get { return husbandFatherName; }
            set { husbandFatherName = value ?? ""; }
        }

        public string HusbandMotherName
        {
            get { return husbandMotherName; }
            set { husbandMotherName = value ?? ""; }
        }

        public string HusbandParishName
        {
            get { return husbandParishName; }
            set { husbandParishName = value ?? ""; }
        }

        public string WifeName
        {
            get { return wifeName; }
            set { wifeName = value ?? ""; }
        }

        public string WifeBirthDate
        {
            get { return wifeBirthDate; }
            set { wifeBirthDate = value ?? ""; }
        }

        public string WifeBirthPlace
        {
            get { return wifeBirthPlace; }
            set { wifeBirthPlace = value ?? ""; }
        }

        public string WifeBaptism
        {
            get { return wifeBaptism; }
            set { wifeBaptism = value ?? ""; }
        }

        public string WifeBaptismNumber
        {
            get { return wifeBaptismNumber; }
            set { wifeBaptismNumber = value ?? ""; }
        }

        public string WifeFatherName
        {
            get { return wifeFatherName; }
            set { wifeFatherName = value ?? ""; }
        }

        public string WifeMotherName
        {
            get { return wifeMotherName; }
            set { wifeMotherName = value ?? ""; }
        }

        public string WifeParishName
        {
            get { return wifeParishName; }
            set { wifeParishName = value ?? ""; }
        }

        public string MatrimonyDate
        {
            get { return matrimonyDate; }
            set { matrimonyDate = value ?? ""; }
        }

        public string MatrimonyPlace
        {
            get { return matrimonyPlace; }
            set { matrimonyPlace = value ?? ""; }
        }

        public string MatrimonyPriest
        {
            get { return matrimonyPriest; }
            set { matrimonyPriest = value ?? ""; }
        }

        public string MatrimonyFirstWitness
        {
            get { return matrimonyFirstWitness; }
            set { matrimonyFirstWitness = value ?? ""; }
        }

        public string MatrimonySecondWitness
        {
            get { return matrimonySecondWitness; }
            set { matrimonySecondWitness = value ?? ""; }
        }

        public string MatrimonyNumber
        {
            get { return matrimonyNumber; }
            set { matrimonyNumber = value ?? ""; }
        }

    }
}
