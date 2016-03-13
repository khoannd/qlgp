using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class ParishionerMatrimonyViewModel
    {
        private string priest;
        private string parishName;
        private string vicariateName;
        private string dioceseName;

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

        public ParishionerMatrimonyViewModel()
        {
            priest = "";
            parishName = "";
            vicariateName = "";
            dioceseName = "";
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
