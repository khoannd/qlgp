﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PMS.DataAccess.Properties {
    
    
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "14.0.0.0")]
    internal sealed partial class Settings : global::System.Configuration.ApplicationSettingsBase {
        
        private static Settings defaultInstance = ((Settings)(global::System.Configuration.ApplicationSettingsBase.Synchronized(new Settings())));
        
        public static Settings Default {
            get {
                return defaultInstance;
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=KHOIHMSE60981\\SQL2008;Initial Catalog=PMS;Persist Security Info=True;" +
            "User ID=sa;Password=minhkhoi")]
        public string PMSConnectionString {
            get {
                return ((string)(this["PMSConnectionString"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=tuanhm60197\\SQL2008;Initial Catalog=PMS;Persist Security Info=True;Us" +
            "er ID=sa")]
        public string PMSConnectionString1 {
            get {
                return ((string)(this["PMSConnectionString1"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=KHOIHMSE60981\\SQL2008;Initial Catalog=PMS;Persist Security Info=True;" +
            "User ID=sa")]
        public string PMSConnectionString2 {
            get {
                return ((string)(this["PMSConnectionString2"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=QuanLM60389\\SQL2008;Initial Catalog=PMS;Persist Security Info=True;Us" +
            "er ID=sa;Password=123")]
        public string PMSConnectionString3 {
            get {
                return ((string)(this["PMSConnectionString3"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=POLE-PC\\SQLEXPRESS;Initial Catalog=PMS;Integrated Security=True;Multi" +
            "pleActiveResultSets=True")]
        public string PMSConnectionString4 {
            get {
                return ((string)(this["PMSConnectionString4"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=THIPC;Initial Catalog=PMS;Integrated Security=True;MultipleActiveResu" +
            "ltSets=True")]
        public string PMSConnectionString5 {
            get {
                return ((string)(this["PMSConnectionString5"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=.\\SQLExpress;Initial Catalog=QLGP;Integrated Security=True;MultipleAc" +
            "tiveResultSets=True")]
        public string QLGPConnectionString {
            get {
                return ((string)(this["QLGPConnectionString"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        [global::System.Configuration.DefaultSettingValueAttribute("Data Source=ToanPBSE61011;Initial Catalog=QLGP;Integrated Security=True;MultipleA" +
            "ctiveResultSets=True")]
        public string QLGPConnectionString1 {
            get {
                return ((string)(this["QLGPConnectionString1"]));
            }
        }
    }
}
