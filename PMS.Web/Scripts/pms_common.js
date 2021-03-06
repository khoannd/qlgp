﻿$(document).ready(function () {
    $('body').bind('ajaxSuccess', function (event, request, settings) {
        if (request.status == 401) {
            window.location.href = "/?logout=1";
        };
    });
});
function convertDateObjectToString(oDate) {
    return oDate.getDate() + "/" + (oDate.getMonth() + 1) + "/" + oDate.getFullYear();
}
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateUrl(url) {
    var ru = /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+|(?:(www)?\.|[\-;:&=\+\$,\w]+@)[A-Za-z0-9\.\-]+)((?:\/[\+~%\/\.\w\-_]*)?\??(?:[\-\+=&;%@\.\w_]*)#?(?:[\.\!\/\\\w]*))?)/;
    return ru.test(url);
}

function makeScrollForModal() {
    $("body").addClass("modal-open");
}
function removeScrollForModal() {
    $("body").removeClass("modal-open");
}
function isDate(date) {
    var currVal = date;

    if (currVal == "") {
        return 0;
    }
    //Declare Regex
    var rxDatePattern = /^((\d{1,2})(\/))?((\d{1,2})(\/))?(\d{4})$/;

    var dtArray = currVal.match(rxDatePattern); // is format OK       

    if (dtArray == null) {
        return -1;
    }

    //Checks for dd/mm/yyyy format.
    var dtDay;
    var dtMonth;

    if (dtArray[4] && dtArray[5] && dtArray[6]) {
        dtDay = dtArray[2];
        dtMonth = dtArray[5];
    } else {
        dtMonth = dtArray[2];
    }
    var dtYear = dtArray[7];

    if (dtMonth) {
        if (dtMonth < 1 || dtMonth > 12) {
            return -2;
        }
    }
    if (dtDay) {
        if (dtDay < 1 || dtDay > 31) {
            return -2;
        }
    }
    if (dtDay && dtMonth) {
        if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31) {
            return -2;
        }
        if (dtMonth == 2) {
            var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));

            if (dtDay > 29 || (dtDay == 29 && !isleap)) {
                return -2;
            }
        }
    }
    return 1;
}

function showMessage(message, type, time) {
    if (type == '0') {
        $.gritter.add({
            title: 'Lỗi',
            text: message,
            class_name: 'gritter-error', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    } else if (type == '1') {
        $.gritter.add({
            title: 'Thành công',
            text: message,
            class_name: 'gritter-success', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    } else if (type == '-1') {
        $.gritter.add({
            title: 'Thông tin',
            text: message,
            class_name: 'gritter-info', //+ ' gritter-light'
            fade_in_speed: 'slow', // how fast notifications fade in (string or int)
            fade_out_speed: 150, // how fast the notices fade out
            time: (time ? time : 4000) // hang on the screen for...
        });
    }

    $(".gritter-close").css({ "margin-left": "90%" });
    //  $.gritter.removeAll();
}

function convertPosition(id) {
    if (id == "1") {
        return "Chủ hộ";
    } else if (id == "2") {
        return "Chồng";
    } else if (id == "3") {
        return "Vợ";
    } else if (id == "4") {
        return "Con";
    } else if (id == "5") {
        return "Cháu";
    } else if (id == "6") {
        return "Cha";
    } else if (id == "7") {
        return "Mẹ";
    } else if (id == "8") {
        return "Ông";
    } else if (id == "9") {
        return "Bà";
    } else if (id == "10") {
        return "Anh";
    } else if (id == "11") {
        return "Chị";
    } else if (id == "12") {
        return "Em";
    } else if (id == "13") {
        return "Dâu";
    } else if (id == "14") {
        return "Rể";
    } else if (id == "15") {
        return "Cô";
    } else if (id == "16") {
        return "Chú";
    } else if (id == "17") {
        return "Bác";
    } else if (id == "18") {
        return "Cậu";
    } else if (id == "19") {
        return "Dì";
    } else if (id == "20") {
        return "Mợ";
    } else if (id == "21") {
        return "Thím";
    } else if (id == "22") {
        return "Dượng";
    } else {
        return "Chưa rõ";
    }
}

function startLoading() {
    $("#loading").fadeIn();
}

function updateTableContent(id) {
    try {
        $("#" + id).dataTable()._fnPageChange(0);
        $("#" + id).dataTable()._fnAjaxUpdate();
    }
    catch (e) {
        $("#loading").fadeOut();
    }

}

function convertStringToDate(date) {
    if (!date) {
        return "";
    }

    date = date.trim();

    if (!date) {
        return "";
    }

    var year = date.substring(0, 4);
    var month = date.substring(4, 6);
    var day = date.substring(6, 8);

    var result = "";

    if (day != "00") {
        result += day + "/";
    }

    if (month != "00") {
        result += month + "/";
    }

    result += year;

    return result;
}

function convertDateToString(date) {
    var day;
    var month;
    var year;

    if (!date) {
        return "";
    }

    var dateParts = date.split('/');

    if (dateParts.length == 3) {
        day = convertStringForDateAndMonth(dateParts[0]);
        month = convertStringForDateAndMonth(dateParts[1]);
        year = dateParts[2];
    } else if (dateParts.length == 2) {
        day = "00";
        month = convertStringForDateAndMonth(dateParts[0]);
        year = dateParts[1];
    }
    else if (dateParts.length == 1) {
        day = "00";
        month = "00";
        year = dateParts[0];
    }
    else {
        return "";
    }

    return year + month + day;
}

function convertStringForDateAndMonth(s) {
    var result;

    if (s.length == 1) {
        result = "0" + s;
    }
    else {
        result = s;
    }

    return result;
}
// Khoan add start
var term = '';
function autocomplete(selector, url, selectedCallback, renderCallback) {
    var cache = {}, lastXhr;
    $(selector).autocomplete({
        minLength: 2,
        delay: 700,
        source: function (request, response) {
            term = $.trim(request.term);
            if (term in cache) {
                if (cache[term]) {
                    response(cache[term]); $(selector).removeClass("ui-autocomplete-loading");
                    return;
                }
            }
            lastXhr = $.getJSON(url, { name: term }, function (data, status, xhr) {
                $(selector).removeClass("ui-autocomplete-loading");
                cache[term] = data.result;
                if (xhr === lastXhr) { response(data.result); }
            });
        },
        select: function (event, ui) {
            if (selectedCallback) {
                selectedCallback(ui.item);
                return false;
            }
        },
        change: function (event, ui) {
            // processing when text change
        },
        create: function (event, ui) {
            
        },
        open: function (event, ui) {

        }
    }).focus(function () {
        if ($(selector).val() == term) {
            $(selector).autocomplete("search");
        }
    }).autocomplete("instance")._renderItem = function (ul, item) {
        if (renderCallback) {
            return renderCallback(ul, item);
        }
        else {
            // create html for each dropdown item
            var dropdownItem = $("<li></li>")
                    .data("item.autocomplete", item) // store data in the item
                    .append("<a>" + (item.ChristianName ? item.ChristianName + " " : "") + item.Name + (item.BirthDate ? ", NS: " + item.BirthDate : "") + "</a>") // can add more properties such as prarish name, gender,...
                    .appendTo(ul);
            return dropdownItem;
        }
    };
}

function showConfirm(message, okCallback, cancelCallback, title) {
    bootbox.dialog({
        closeButton: false,
        message: message,
        title: (title ? title : "Xác nhận"),
        buttons: {
            danger: {
                label: " Xóa",
                className: "ace-icon fa fa-trash-o btn-danger",
                callback: okCallback
            },
            main: {
                label: " Đóng",
                className: "ace-icon fa fa-times btn-default",
                callback: cancelCallback
            }
        }
    });
}
function showAlert(message, title) {
    bootbox.dialog({
        closeButton: false,
        message: message,
        title: (title ? title : "Thông báo"),
        buttons: {
            main: {
                label: " Đóng",
                className: "ace-icon fa fa-times btn-default",
            }
        }
    });
}
function convertVnDate2NumberFormat(vnDate) {
    if (!vnDate || vnDate == "") return vnDate;
    if (vnDate.indexOf(" ") > 0) {
        vnDate = vnDate.substr(0, vnDate.indexOf(" "));
    }

    var dateFormat = /^\d{1,2}[\.|\/|-]\d{1,2}[\.|\/|-]\d{1,4}$/;

    if (dateFormat.test(vnDate)) {
        // remove any leading zeros from date values
        vnDate = vnDate.replace(/0*(\d*)/gi, "$1");
        var dateArray = vnDate.split(/[\.|\/|-]/);
        if (dateArray.length < 3) {
            return false;
        }

        // correct month value
        dateArray[1] = dateArray[1] - 1;

        // correct year value
        if (dateArray[2].length < 4) {
            // correct year value
            dateArray[2] = (parseInt(dateArray[2]) < 50) ? 2000 + parseInt(dateArray[2]) : 1900 + parseInt(dateArray[2]);
        }

        var d = new Date(dateArray[2], dateArray[1], dateArray[0]);
        return d.getFullYear().toString() + padDigits((d.getMonth() + 1), 2) + padDigits(d.getDate(), 2);
    } else {
        return "00000000";
    }
}
function convertVnDate2DateObject(vnDate) {
    if (!vnDate || vnDate == "") return vnDate;
    if (vnDate.indexOf(" ") > 0) {
        vnDate = vnDate.substr(0, vnDate.indexOf(" "));
    }

    var dateFormat = /^\d{1,2}[\.|\/|-]\d{1,2}[\.|\/|-]\d{1,4}$/;

    if (dateFormat.test(vnDate)) {
        // remove any leading zeros from date values
        vnDate = vnDate.replace(/0*(\d*)/gi, "$1");
        var dateArray = vnDate.split(/[\.|\/|-]/);
        if (dateArray.length < 3) {
            return false;
        }

        // correct month value
        dateArray[1] = dateArray[1] - 1;

        // correct year value
        if (dateArray[2].length < 4) {
            // correct year value
            dateArray[2] = (parseInt(dateArray[2]) < 50) ? 2000 + parseInt(dateArray[2]) : 1900 + parseInt(dateArray[2]);
        }

        var d = new Date(dateArray[2], dateArray[1], dateArray[0]);
        return d;
    } else {
        return new Date();
    }
}
function convertVnDate2EnDate(vnDate) {
    if (!vnDate || vnDate == "") return vnDate;
    if (vnDate.indexOf(" ") > 0) {
        vnDate = vnDate.substr(0, vnDate.indexOf(" "));
    }

    var dateFormat = /^\d{1,2}[\.|\/|-]\d{1,2}[\.|\/|-]\d{1,4}$/;

    if (dateFormat.test(vnDate)) {
        // remove any leading zeros from date values
        vnDate = vnDate.replace(/0*(\d*)/gi, "$1");
        var dateArray = vnDate.split(/[\.|\/|-]/);
        if (dateArray.length < 3) {
            return false;
        }

        // correct month value
        dateArray[1] = dateArray[1] - 1;

        // correct year value
        if (dateArray[2].length < 4) {
            // correct year value
            dateArray[2] = (parseInt(dateArray[2]) < 50) ? 2000 + parseInt(dateArray[2]) : 1900 + parseInt(dateArray[2]);
        }

        var d = new Date(dateArray[2], dateArray[1], dateArray[0]);
        return padDigits((d.getMonth() + 1), 2) + '/' + padDigits(d.getDate(), 2) + '/' + d.getFullYear().toString();
    } else {
        return null;
    }
}
function convertEnDate2VnDate(vnDate) {
    if (!vnDate || vnDate == "") return vnDate;
    if (vnDate.indexOf(" ") > 0) {
        vnDate = vnDate.substr(0, vnDate.indexOf(" "));
    }

    var dateFormat = /^\d{1,2}[\.|\/|-]\d{1,2}[\.|\/|-]\d{1,4}$/;

    if (dateFormat.test(vnDate)) {
        // remove any leading zeros from date values
        vnDate = vnDate.replace(/0*(\d*)/gi, "$1");
        var dateArray = vnDate.split(/[\.|\/|-]/);
        if (dateArray.length < 3) {
            return false;
        }

        // correct month value
        dateArray[0] = dateArray[0] - 1;

        // correct year value
        if (dateArray[2].length < 4) {
            // correct year value
            dateArray[2] = (parseInt(dateArray[2]) < 50) ? 2000 + parseInt(dateArray[2]) : 1900 + parseInt(dateArray[2]);
        }

        var d = new Date(dateArray[2], dateArray[0], dateArray[1]);
        return formatDate2VnDate(d);
    } else {
        return null;
    }
}

function convertServerDate2VnDate(value) {
    if (value) {
        var pattern = /Date\(([^)]+)\)/;
        var results = pattern.exec(value);
        var d = new Date(parseFloat(results[1]));
        return formatDate2VnDate(d);
    }
    return "";
}
//all parameters are passed into functions in this class using dd/mm/yyyy format, except the convert function
var dates = {
    convert: function (d) {
        // Converts the date in d to a date-object. The input can be:
        //   a date object: returned without modification
        //  an array      : Interpreted as [year,month,day]. NOTE: month is 0-11.
        //   a number     : Interpreted as number of milliseconds
        //                  since 1 Jan 1970 (a timestamp) 
        //   a string     : Any format supported by the javascript engine, like
        //                  "YYYY/MM/DD", "MM/DD/YYYY", "Jan 31 2009" etc.
        //  an object     : Interpreted as an object with year, month and date
        //                  attributes.  **NOTE** month is 0-11.
        return (
            d.constructor === Date ? d :
            d.constructor === Array ? new Date(d[0], d[1], d[2]) :
            d.constructor === Number ? new Date(d) :
            d.constructor === String ? new Date(d) :
            typeof d === "object" ? new Date(d.year, d.month, d.date) :
            NaN
        );
    },
    compare: function (a, b) {
        a = convertVnDate2DateObject(a);
        b = convertVnDate2DateObject(b);
        // Compare two dates (could be of any type supported by the convert
        // function above) and returns:
        //  -1 : if a < b
        //   0 : if a = b
        //   1 : if a > b
        // NaN : if a or b is an illegal date
        // NOTE: The code inside isFinite does an assignment (=).
        return (
            isFinite(a = this.convert(a).valueOf()) &&
            isFinite(b = this.convert(b).valueOf()) ?
            (a > b) - (a < b) :
            NaN
        );
    },
    add: function (d, i) {
        var day, month, year;
        d = convertVnDate2EnDate(d);
        if (!isNaN(i)) {
            day = parseInt(i);
        }
        else if (i.indexOf(' ') >= 0) {
            var s = i.substr(i.indexOf(' '));
            s = $.trim(s).toLowerCase();
            var v = i.substr(0, i.indexOf(' '));
            if (s.indexOf('day') == 0)
                day = parseInt($.trim(v));
            else if (s.indexOf('month') == 0)
                month = parseInt($.trim(v));
            else if (s.indexOf('year') == 0)
                year = parseInt($.trim(v));
        }

        var date = new Date(d);
        if (day)
            date.setDate(date.getDate() + day);
        else if (month)
            date.setMonth(date.getMonth() + month);
        else if (year)
            date.setYear(date.getFullYear() + year);
        return formatDate2VnDate(date);
    },
    inRange: function (d, start, end) {
        // Checks if date in d is between dates in start and end.
        // Returns a boolean or NaN:
        //    true  : if d is between start and end (inclusive)
        //    false : if d is before start or after end
        //    NaN   : if one or more of the dates is illegal.
        // NOTE: The code inside isFinite does an assignment (=).
        d = convertVnDate2EnDate(d);
        start = convertVnDate2EnDate(start);
        end = convertVnDate2EnDate(end);
        return (
             isFinite(d = this.convert(d).valueOf()) &&
             isFinite(start = this.convert(start).valueOf()) &&
             isFinite(end = this.convert(end).valueOf()) ?
             start <= d && d <= end :
             NaN
         );
    },
    isInFuture: function (d1) {
        // return true if d <= today
        // return falase if d > today
        var d = new Date();
        today = formatDate2VnDate(d);
        var r = this.compare(d1, today);
        return (r > 0);
    }
}
function formatDate2VnDate(d) {
    if (!d) d = new Date();
    return padDigits(d.getDate(), 2) + '/' + padDigits((d.getMonth() + 1), 2) + '/' + d.getFullYear().toString();
}
function padDigits(number, digits) {
    return Array(Math.max(digits - String(number).length + 1, 0)).join(0) + number;
}
String.prototype.paddingLeft = function (paddingValue) {
    return String(paddingValue + this).slice(-paddingValue.length);
};
//like string.format of C#
String.prototype.format = function () {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] != 'undefined' ? args[number] : match;
    });
};
function upperCaseFirstChar(str) {
    if (!str) return str;
    var parts = str.split(" ");
    for (var i in parts) {
        parts[i] = parts[i].substr(0, 1).toUpperCase() + parts[i].substr(1).toLowerCase();
    }
    return parts.join(" ");
}
$(function () {
    $('input.date-picker').mask("99/99/9999");
    $('input.date-picker4').mask("99/99");
    $("input.select-all").click(function () {
        $(this).closest("table").find("tr > td:first-child input[type='checkbox'].sItem").attr("checked", this.checked);
    });
    $(".phone").mask("9999 999 999?9");
    $('input.normal-name').blur(function () {
        $(this).val(upperCaseFirstChar($(this).val()));
    });
    //$(".number").number();

});
// Khoan add end

//Duy add start
function numberWithCommas(x) {
    if (x == undefined) return '';
    var xReail = x.toString().split(',').join('');
    return xReail.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
//Duy add end